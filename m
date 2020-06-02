Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0C1EBF24
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgFBPge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgFBPgd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 11:36:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B8C08C5C0;
        Tue,  2 Jun 2020 08:36:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so2365415pfp.9;
        Tue, 02 Jun 2020 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6W7gmxi1HD/CxtILNA8B1uFQ7YHTrdX2XrPNC7Oabrw=;
        b=HZlG1PQ7BXdNGTu+QPdnaWIluYnQ4buUmOnFUC6CZLge6GTp5FV0GcZyzS2uTbjixk
         kvhV1GVlqD97Gx21PfpX85t39CQvm9Wmt0wnr1+717RvE0OQA3oDsXl82vkYDRRTo83M
         GqnJ+e2M4kQm3isgERkFMoKGECIrxUgCfYBKCvGIo5rbEgUt+hrBDdK9RI8rFh+KENPU
         Dq8O3tNMjzY8B4hCThzCjDrQZJVwKHjHxizWcR2OZ9QKlBQMAM7zqhBZm6Cxg3EkXhwF
         mj8wo9ay/G3x0CJiAbN3WBHVkjhBUzZCMj5P1kSbIJ39OmCUB77WPC2Tl6KG+von5c24
         cPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6W7gmxi1HD/CxtILNA8B1uFQ7YHTrdX2XrPNC7Oabrw=;
        b=i48RUuyS+RsvMyxlZdWGlaEfLnSJ9P21fMmnjccG8qRrNJr+7y4jUwiYSQcmHSmPm1
         UUErm4AUNBHMpILGVQ7Ixbuu6V88n7HCE3ckYoAUfpsxeeuSvXvryL7j7xnkH5yn3tQS
         /r/A0pgvk/o1Ecs5teU1GxqIWqGX0wHge8tnF5dro0mq4WkfYNxpSGQI4QapM6+GZXTT
         /F+WNZd+lIAtiKW8w14peImWA34ZHfQDx5+/JXDSL6oTphq2PbbexLQSMRHK3DJqwQkm
         SSM08gSMwGEFzRuK6uTcZtNIumxnlcArtbyRDgQCZ10pAiqZry8IX3BWXuk5WalGnGq/
         emoQ==
X-Gm-Message-State: AOAM531XOFwHuLTdYNuSUm1oBbBvytLPPmcu6H49VkQo34CHugTYi8ez
        hmnVFfzBNQLxWj2TfJvxezjXncRMLssC+YbnS5njPff6UbI=
X-Google-Smtp-Source: ABdhPJzyvuMaCkgh5zF5fh/+9LcoWqNEZXZe9xCyM/eJdL6vuGt0TSCzODQE7H6TPaeYRam8LA6OYW11U4fG9OOa1rg=
X-Received: by 2002:a63:305:: with SMTP id 5mr23848882pgd.74.1591112193342;
 Tue, 02 Jun 2020 08:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092041.32011-1-piotr.stankiewicz@intel.com> <CAHp75Vf6xzuD2MPLr2xW0=1-040uNS-Ady1LSZ-9hqGPjK6sxg@mail.gmail.com>
In-Reply-To: <CAHp75Vf6xzuD2MPLr2xW0=1-040uNS-Ady1LSZ-9hqGPjK6sxg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 18:36:21 +0300
Message-ID: <CAHp75VddXuVMMiKWAjZTDGh5jGVP=j7pdpPSF9fRNXHYCig7rg@mail.gmail.com>
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

On Tue, Jun 2, 2020 at 6:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 2, 2020 at 12:25 PM Piotr Stankiewicz
> <piotr.stankiewicz@intel.com> wrote:

...

>         if (dd->flags & QIB_HAS_INTX)
>                flags = PCI_IRQ_ALL_TYPES;

>         if (dd->flags & QIB_HAS_INTX)

This line should be 'else'.

>                flags = PCI_IRQ_MSI_TYPES;

-- 
With Best Regards,
Andy Shevchenko
