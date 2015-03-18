format_pounds(value)
{
    return "£ " + Round(value, 2)
}

matchbook_calc(laystake, layodds, commission)
{
    commP := commission / 100
    if (layodds >= 2)
    {
        return commP * laystake
    }
    liability := (layodds - 1) * laystake
    return commP * liability
}
