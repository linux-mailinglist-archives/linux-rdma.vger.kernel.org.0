Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA71EBF20
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFBPgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBPgA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 11:36:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3979C08C5C0;
        Tue,  2 Jun 2020 08:35:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so4211895pfg.2;
        Tue, 02 Jun 2020 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EYkzwEV9xYGFRcvjgUXkBaYtfbadsZOtEiHhmejCdU=;
        b=jXvGJP1gZu9liak+Ab3bimqHSewwSk9Fv4qLyhrGSuU2hdUx6Q1uzTJTRmjMpopOXq
         hFTdX94fal0c6nUyqJIaHo7nDvssgJizbJdj4ksvsvsxPAWoG3luZ99UCziqZl07otRp
         RwuD51KehZYOd3bA7JDEsAN58cF0ri4ruxcYIwD9+VECCzPZOJuxhQE90Q5geynUa0Gv
         +OtW2iq+qr71MGPu5Ncth2kBVFlgJ4rOPngX2QLnIg+5iHiDylBd++/bWoR3Xz3XGUge
         EuyFgTYMKruwyyf2jrLDgMQbGYOg6TKo/gcTODqBCUH4A+fZ5RX6tEu2rfCB69kcOw73
         w+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EYkzwEV9xYGFRcvjgUXkBaYtfbadsZOtEiHhmejCdU=;
        b=PygJAUpMcTRqXQgJIOx9ioAEA1/UBBaNLzjBrl2jsPq4QVcRPpkvwMN3hwYGIB4w1i
         q9O+52QYEeaY3QAzcb+g5q8hDZUUBH1VWz6EjPevER0K5rk1MtttYbUsjgnzcLgoo5wt
         wYIxV6th1MRkZt9uB/flyYEyjL4Vrj3iFQeI1rGIm4tW9gjlMMmxkmTqJGG4VAVTp8t2
         RJUwSUJ9DexetsokGG132E6rXMgg6xWlMDL4cyR3qZKQW0zf2/NAgxm//pnmuuiQdeUj
         DYuAC+h4hTotGgfendiblHA6eRH/zmTn6g5IZuwutitsTG3xZ9tJDezo9RdXNLaf4SU9
         XDRw==
X-Gm-Message-State: AOAM5300ilyR9ljANbiay0V49QVvYSpHqxY0HTVdwP6ZbcEYyVtbRE3U
        SrSUYp85edSW32czJ4hXmthX/Y1cQTpTG37q1mk=
X-Google-Smtp-Source: ABdhPJyrUrtx2tzUesymBMoc0kdJViRXxTZ2EDEFS/7FPRQVJG33RuLHgEDquM+cx++UWJIkCIICcAQNM4q9wTB39Uc=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr8466830pgk.203.1591112158239;
 Tue, 02 Jun 2020 08:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092041.32011-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200602092041.32011-1-piotr.stankiewicz@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 18:35:46 +0300
Message-ID: <CAHp75Vf6xzuD2MPLr2xW0=1-040uNS-Ady1LSZ-9hqGPjK6sxg@mail.gmail.com>
Subject: Re: [PATCH 08/15] IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 2, 2020 at 12:25 PM Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.

...

> -       unsigned int flags = PCI_IRQ_MSIX | PCI_IRQ_MSI;
> +       unsigned int flags = PCI_IRQ_MSI_TYPES;
>
>         if (!pci_is_pcie(dd->pcidev)) {
>                 qib_dev_err(dd, "Can't find PCI Express capability!\n");

Internally I have proposed at last this:

convert the following
        if (dd->flags & QIB_HAS_INTX)
               flags |= PCI_IRQ_LEGACY;

to
        if (dd->flags & QIB_HAS_INTX)
               flags = PCI_IRQ_ALL_TYPES;
        if (dd->flags & QIB_HAS_INTX)
               flags = PCI_IRQ_MSI_TYPES;

-- 
With Best Regards,
Andy Shevchenko
