Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A387B1B3E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2019 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfIMJz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 05:55:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44344 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbfIMJz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 05:55:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so28837983otj.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2019 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMQYVHEWLYiHDyJ6nTZFM9bO2lcGE6JPb6li8qp7+Vk=;
        b=dJzYZ3B+/+gdgBIxCnf0X6itRvlfNcX7If2XgYPo5Ssp7hdAepbogmTZly9CF/3YaU
         lJE6KuYWAxZYeSG8Ti8SOEg0Bc0mrcXVMo7eNZuiUel54x/TFKXkg6Viw9w2U/J/BYCP
         hYscKPhgytjFQTDbt1ZajAMSP+ZI4tGFtwGUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMQYVHEWLYiHDyJ6nTZFM9bO2lcGE6JPb6li8qp7+Vk=;
        b=bm/cGMMGY9x1rozlihhtQSYqABNvf2aBRQogl3AcPllgjsjPYyWDBKkXDFHeUM2zQI
         flK+ewheoABkYyULJYuwhAMHqGP6/YUWJjse5qD4O8iaPMZ2Djr/Mw4foZ5Lf5/ajCHs
         IryRPci8YiP7jAxEMiklp8Zg3R1flaK6y3ilqRUa2QVny21BFCFEQgq1e8con3kNBzhw
         2zSN1I7COmuz1/lc2vZtFiZD/3nfiWUvDOdTRDpmD6mlPWCr7CaDM04PP0jCYOkRCiEE
         LuwFxLTZaqkywGlbRMSyF+FaC8K+IM4VTQG+b6nA6W7Zgeq5QnS5V+UZth7YbJRUiULC
         Y3BQ==
X-Gm-Message-State: APjAAAVrO0sazu2OrkQznVS4NEKUxVM1SJXRaRKm38pWTaw2lv9sgGU3
        90js41XujfUQYEzlm8c0q3i5ABa2UuC8ueP85Iw8TA==
X-Google-Smtp-Source: APXvYqw+1a84R4pBtZm3Y54xxn1FobvFYUznqgrUfd5/p6M55wi73uijrk14i87/KA7+sR2LmnCkMGF2HZR7ArTo1Co=
X-Received: by 2002:a9d:37c7:: with SMTP id x65mr37287063otb.47.1568368556464;
 Fri, 13 Sep 2019 02:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190911092856.11146-1-colin.king@canonical.com> <20190912150957.GA9160@mellanox.com>
In-Reply-To: <20190912150957.GA9160@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Fri, 13 Sep 2019 15:25:45 +0530
Message-ID: <CA+sbYW1MWTBa-yG+Z2Z5KwZGfwRTOdLpzL64fE35OEeGrPbgeQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" -> "missing_resp"
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Colin King <colin.king@canonical.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 12, 2019 at 8:40 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Sep 11, 2019 at 10:28:56AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in a literal string, fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > index 604b71875f5f..3421a0b15983 100644
> > --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> > @@ -74,7 +74,7 @@ static const char * const bnxt_re_stat_name[] = {
> >       [BNXT_RE_SEQ_ERR_NAKS_RCVD]     = "seq_err_naks_rcvd",
> >       [BNXT_RE_MAX_RETRY_EXCEEDED]    = "max_retry_exceeded",
> >       [BNXT_RE_RNR_NAKS_RCVD]         = "rnr_naks_rcvd",
> > -     [BNXT_RE_MISSING_RESP]          = "missin_resp",
> > +     [BNXT_RE_MISSING_RESP]          = "missing_resp",
>
> Broadcom folks, can you confirm if this is OK? Is the string ABI for
> this driver?
>

 bnxt_re doesn't have a string ABI.
This is a spelling mistake while posting the patch and it is okay to
merge this patch.

Thanks
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
