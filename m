Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1E25457D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgH0M46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgH0M4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:56:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48156C061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:56:14 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so4399211qth.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G00UKA0nZlMPRLquxYhlcniBG/78wjyIKcUP65vesAY=;
        b=XdgGUAAvOvDLmPv7uVIMNJpXox61bP+7DJoMaNBo4eovjFXrDeWRVVdoDFmC4VmVif
         aWz6jCVMnZU+fA4NQ/XxwHmi0t+JChDo7wLQHbdXe8Zk3oDdca7y9gDAr/ix+10cwPFh
         3wUmMKr5DrP92mOBWCGvg3FcSF74k+Fln3D+g6zcoWvCa6lGWfOFWa8y8zXlhiBCj2VG
         ul0Qqv+NVF/xxvGlwH1CIQsBZTmR08HXYAOzRPqAfV2CBYdzBmYs0zjGbDym5rhDtJCv
         +mPDQt3qq31WisiZ7OiAZm5VmScIIHOWI+ZUf/YT98SpnNim6zrrhoSyJHLI1D55UnR5
         p28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G00UKA0nZlMPRLquxYhlcniBG/78wjyIKcUP65vesAY=;
        b=MzrTWy20NkHMmmMAs90R2jVKltYPb8SW/JN3FuOUqjvgXVRSNPYmpUiQ2BkrUNx/de
         GiDlWnCvix2ddlXhL8QxQrpc/XFf3QVyF0qchoMCI6JqUVL/dizaxeUbUL1kLbL63AhG
         /1nRdhb8NkeB1pIqkVY8R5ZYhBJWhilJk3z/GHR5KvGhIuRKUg/XaW4KIsD2Oyx+W7Ay
         V5jzqQMOZQxSaQvROakj5//+SZ9MQEWAOmnPjnFDgLemDlZqSg8cdqKo/h7mtsaJ9wUM
         ZngX7EAFcvz1Kp1GEHFMeg0IyYxKOHOp6qiBmHcGsj1jgmxMhw8joyRt9m1iGGl+a/Eo
         bcog==
X-Gm-Message-State: AOAM531UQ53KSqqkUWWCX88vIjsKMyEhd+3D+9VW0St+hhowcf/vY1Ly
        MWJol1f6wyjJeDZCoK9YO++EhQ==
X-Google-Smtp-Source: ABdhPJyoHMVCvwZzIqL790KEHKDSXJczj5ZnhZ0ZxWdjbuR+10HE8TCPicP66Lga4f+FeXtOy6zBeA==
X-Received: by 2002:ac8:6f44:: with SMTP id n4mr19208480qtv.336.1598532973563;
        Thu, 27 Aug 2020 05:56:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c24sm1633944qkk.89.2020.08.27.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:56:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHRs-00GtDb-Fb; Thu, 27 Aug 2020 09:56:12 -0300
Date:   Thu, 27 Aug 2020 09:56:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 06/17] rdma_rxe: Added stubs for alloc_mw and
 dealloc_mw verbs
Message-ID: <20200827125612.GP24045@ziepe.ca>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-7-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-7-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:27PM -0500, Bob Pearson wrote:
> Added a new file focused on memory windows, rxe_mw.c and adds stubbed
> out kernel verbs API for alloc_mw and dealloc_mw. These functions are added
> to the context ops struct and bits added to the supported APIs mask.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/Makefile    |  1 +
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  5 +++++
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 22 ++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  4 ++++
>  4 files changed, 32 insertions(+)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 66af72dca759..1e24673e9318 100644
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -15,6 +15,7 @@ rdma_rxe-y := \
>  	rxe_qp.o \
>  	rxe_cq.o \
>  	rxe_mr.o \
> +	rxe_mw.o \
>  	rxe_opcode.o \
>  	rxe_mmap.o \
>  	rxe_icrc.o \
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 47d1730f43dd..9ab5f2c34def 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -111,6 +111,11 @@ void rxe_mem_cleanup(struct rxe_pool_entry *arg);
>  
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>  
> +/* rxe_mw.c */
> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
> +			   struct ib_udata *udata);
> +int rxe_dealloc_mw(struct ib_mw *ibmw);
> +
>  /* rxe_net.c */
>  void rxe_loopback(struct sk_buff *skb);
>  int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> new file mode 100644
> index 000000000000..f5df5e0b714f
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * linux/drivers/infiniband/sw/rxe/rxe_mw.c
> + *
> + * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
> + */
> +
> +#include "rxe.h"
> +#include "rxe_loc.h"
> +
> +struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
> +			   struct ib_udata *udata)
> +{
> +	pr_err_once("%s: not implemented\n", __func__);
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +int rxe_dealloc_mw(struct ib_mw *ibmw)
> +{
> +	pr_err_once("%s: not implemented\n", __func__);
> +	return -EINVAL;
> +}

The patches should be ordered to avoid things like this, just add the
final implemetnation as the last patch

Jason
