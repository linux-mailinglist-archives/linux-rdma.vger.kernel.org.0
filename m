Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB53246FBE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgHQRx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbgHQRxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 13:53:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3457C061389
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 10:53:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so13094031qtn.9
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qJKHV+uR7EHxj6Xx8FbbDgPhogd8I9njcQU8EAXvkQ=;
        b=eZR0WfgN5VnjasTe4SSju/DBe5GM7/1zgG558EVIEYqjTyUtTzYQ9HQO8tZ/pjhXR4
         y4MDdtYuAAwlwpXLG1N/fGPd2GrheSQvtp26XM7gOaX3NztXoqM6k9pRO/Gow4qk0aR3
         BpPuw4JlOpLKZicE4gEzsIg0Fy9Nq/LwItDtcIVXVFACAQFUovgsDmYgv0FB4S0ztZLq
         5P6Nqh5qURy6QR1nhiv3i9uQ9Kxe1h1H1e88am3REjCsiNneoTWSrw0uE1poR/cME3GJ
         gmIJRZI56BiHf81xGF37tpNxbhaN27HdFfunjzN/EjKZm2GbMXqD8c3Lop1cr5QD7nhR
         p5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qJKHV+uR7EHxj6Xx8FbbDgPhogd8I9njcQU8EAXvkQ=;
        b=smw3aPzlQBj6CtqBMRW4xfnYZGEIWDSI7QvJOIwi57PEZaA0hJk9Fqet9832FEq5Uq
         3mQmp2cAWPPH3L67RlwsMJq/KlSpdr1SS353hdPqZR0SdXkxg4VMzKo3NeQnojvpVR82
         ZeDzvmTM2L3K6mZWnepjAvoLkdUaRujgqiuP8KsRCJb46Kyf2QYkG/9luCDurOQj1Ncf
         GigolLao6Y49ZzX5H1n5B7tT9bnO7QBlNVyw+VBukR9AckLuTq5TLh9GxLBJOKxEeQTh
         8q6PXS4afzWXV9RaHmCuRiciKAmCdWU05g8XhD6Qrrxjxo1YCHVEsClDhmia+L9/2X4D
         zvxg==
X-Gm-Message-State: AOAM5329Wa+GZ6c3tLhS7Hf2Rx9B7RojHBmkFziE0+mTBIb/9oBUtS7J
        bX4nGzSMKIwcCq1gUfoXd5OSSw==
X-Google-Smtp-Source: ABdhPJzCaYQxApihx4dIieIEvWuoenIg4/F/KmoMRyKOXtKtqpn47Et8huEquYYdnWP2opbPNFOzKQ==
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr14580291qte.78.1597686799970;
        Mon, 17 Aug 2020 10:53:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 141sm17857695qke.41.2020.08.17.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:53:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k7jJu-007tAD-4T; Mon, 17 Aug 2020 14:53:18 -0300
Date:   Mon, 17 Aug 2020 14:53:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, keescook@chromium.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH 1/5] infiniband: bnxt_re: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20200817175318.GW24045@ziepe.ca>
References: <20200817082844.21700-1-allen.lkml@gmail.com>
 <20200817082844.21700-2-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817082844.21700-2-allen.lkml@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 17, 2020 at 01:58:40PM +0530, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  7 +++----
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 ++++++-------
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 117b42349a28..62b01582aa1c 100644
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -295,9 +295,9 @@ static void __wait_for_all_nqes(struct bnxt_qplib_cq *cq, u16 cnq_events)
>  	}
>  }
>  
> -static void bnxt_qplib_service_nq(unsigned long data)
> +static void bnxt_qplib_service_nq(struct tasklet_struct *t)
>  {
> -	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
> +	struct bnxt_qplib_nq *nq = from_tasklet(nq, t, nq_tasklet);
>  	struct bnxt_qplib_hwq *hwq = &nq->hwq;
>  	int num_srqne_processed = 0;
>  	int num_cqne_processed = 0;
> @@ -448,8 +448,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
>  
>  	nq->msix_vec = msix_vector;
>  	if (need_init)
> -		tasklet_init(&nq->nq_tasklet, bnxt_qplib_service_nq,
> -			     (unsigned long)nq);
> +		tasklet_setup(&nq->nq_tasklet, bnxt_qplib_service_nq);
>  	else
>  		tasklet_enable(&nq->nq_tasklet);
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> index 4e211162acee..7261be29fb09 100644
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
> @@ -50,7 +50,7 @@
>  #include "qplib_sp.h"
>  #include "qplib_fp.h"
>  
> -static void bnxt_qplib_service_creq(unsigned long data);
> +static void bnxt_qplib_service_creq(struct tasklet_struct *t);
>  
>  /* Hardware communication channel */
>  static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
> @@ -79,7 +79,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
>  		goto done;
>  	do {
>  		mdelay(1); /* 1m sec */
> -		bnxt_qplib_service_creq((unsigned long)rcfw);
> +		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
>  	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
>  done:
>  	return count ? 0 : -ETIMEDOUT;
> @@ -369,10 +369,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
>  }
>  
>  /* SP - CREQ Completion handlers */
> -static void bnxt_qplib_service_creq(unsigned long data)
> +static void bnxt_qplib_service_creq(struct tasklet_struct *t)
>  {
> -	struct bnxt_qplib_rcfw *rcfw = (struct bnxt_qplib_rcfw *)data;
> -	struct bnxt_qplib_creq_ctx *creq = &rcfw->creq;
> +	struct bnxt_qplib_creq_ctx *creq = from_tasklet(creq, t, creq_tasklet);

This is just:

  struct bnxt_qplib_rcfw *rcfw = from_tasklet(rcfw, t, crew.creq_tasklet);

No need for the extra container_of

Jason
