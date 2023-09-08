Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A692798882
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbjIHOWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjIHOWo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 10:22:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633101BF9
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 07:22:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41368601e92so13213061cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 Sep 2023 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694182959; x=1694787759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DGIn2TrzhN1/7P30IYwkdw76l9rjdwVa0UFxDxOrEc=;
        b=nMWf7dmS/hlq2sJfJQrkTSMoLw8C1muBUeCw8oMZJ/el5Av6a0c9xZJPv8YP4jicZ7
         9QtXWxoC3h10nBW/q3pxPYv4jtzV11SPlJH8HuBE+lQ2Q0e5G5zA1aWB9uHSardh77/m
         kph6wVdm7A/x7DuSPDASUsqBkP+/YopForbFZZHQjMrx64N4ajjnVMN00Br44YtoxlPn
         ZsWJK7AM+TG9z0dBUJ5an8WU4LkgLKlyRFbmkKwp8rEDxy03hcWNyxVzy1T0CAOBPBmB
         KvJ3TSukNBW68f4uenspmVvqSKSXknm/uF0dOdbaqBkAu6aE2D/ftDi18op5v57spS0i
         H6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182959; x=1694787759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DGIn2TrzhN1/7P30IYwkdw76l9rjdwVa0UFxDxOrEc=;
        b=KQKB+VUanlvejzMKQ58eLNwef91CB+i66T+HuBb1XpNPKrYksQK1UZu/i9VoIIQWgO
         8qfkYyHbpQ6iB9+5IHYjdxQu9lFnzENXhIkChZUWk/l4LTJ9RvAaa9pkdeKTgAgeJeBf
         d6zQs0PPh3k4WEVz4UrKumcFB8lKTsYLqQ9nlVwL6rWCe5zQVKwWg5gv4lkVE2X0f5mJ
         Wuiag2egi/9hni70NXRDlwyfpBv/qx9NS95mM/E7sBOojO3ePdDIrzsd7Qz7a272R5jK
         uZn49KidAt10JgkNt3pkt50IcqDxtVq32gtm1cjLvMurO+SZ85v+F5Ge89qftL7nEl5g
         oeNQ==
X-Gm-Message-State: AOJu0YwDm6k0Sr86Rqn0S2EWwKG0jE6QAyb/OHNm//DDC32XhLhj9Svh
        p80CaCB/o70UZLZ4yrrutFDLhw==
X-Google-Smtp-Source: AGHT+IF85r1wVh7xGySwFbtuZtJ4lf2+XyPaF89ogW0tYLg1HmLTHhPBPzOfd0FHJWABpcAO9mGqMA==
X-Received: by 2002:a0c:cd11:0:b0:64f:72cc:4bca with SMTP id b17-20020a0ccd11000000b0064f72cc4bcamr2586320qvm.47.1694182959492;
        Fri, 08 Sep 2023 07:22:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id o3-20020a0ce403000000b00653589babfcsm731433qvl.132.2023.09.08.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:22:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qecNZ-001ISz-Lq;
        Fri, 08 Sep 2023 11:22:37 -0300
Date:   Fri, 8 Sep 2023 11:22:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v6 4/7] RDMA/rxe: Add page invalidation support
Message-ID: <ZPsuLeuGAgpBoTjU@ziepe.ca>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <1566fd3c63e4dac66717731e2c7a80039244e3af.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566fd3c63e4dac66717731e2c7a80039244e3af.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 08, 2023 at 03:26:45PM +0900, Daisuke Matsuda wrote:
> On page invalidation, an MMU notifier callback is invoked to unmap DMA
> addresses and update the driver page table(umem_odp->dma_list). It also
> sets the corresponding entries in MR xarray to NULL to prevent any access.
> The callback is registered when an ODP-enabled MR is created.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/Makefile  |  2 +
>  drivers/infiniband/sw/rxe/rxe_odp.c | 64 +++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 5395a581f4bb..93134f1d1d0c 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -23,3 +23,5 @@ rdma_rxe-y := \
>  	rxe_task.o \
>  	rxe_net.o \
>  	rxe_hw_counters.o
> +
> +rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> new file mode 100644
> index 000000000000..834fb1a84800
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
> + */
> +
> +#include <linux/hmm.h>
> +
> +#include <rdma/ib_umem_odp.h>
> +
> +#include "rxe.h"
> +
> +static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
> +				unsigned long end)
> +{
> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
> +	void *entry;
> +
> +	XA_STATE(xas, &mr->page_list, lower);
> +
> +	/* make elements in xarray NULL */
> +	xas_lock(&xas);
> +	while (true) {
> +		xas_store(&xas, NULL);
> +
> +		entry = xas_next(&xas);

I think this should just be

   xas_for_each(xas, entry, upper)
         xas_store(&xas, NULL)

> +		if (xas_retry(&xas, entry) || (xas.xa_index <= upper))
> +			continue;

xa_erase doesn't deal with retry entries, why do you think this does?

IIRC retry entries cannot be seen under the spinlock

Jason
