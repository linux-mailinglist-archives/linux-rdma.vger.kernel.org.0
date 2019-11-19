Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC44102D9B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSUbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:31:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45580 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:31:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so19109792qke.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ffL3XiM0LtkLjeoyTC4fynmObhqLJBu0oAAkB1Sv6bg=;
        b=QQpEdvQrv3VxEyEYawc6fHFuZTPgaWu6FsHVD1e1ezyhaWuRpUshlK+MeazAk2Yb5c
         WdHqQAt7ivBcTNSFX+SeqsrF/JATfpYGHbtKF9ZWf/kyX3NaiwyEQMwEL1nkfMSCAwYZ
         t4OIx6yol25quBvST7aX7t+bwogjXEt24v+18KV7WVflf5ZgdKKOBb1IJsebR8NVP7MP
         03sq5wcV+rHoLsGqOZhto/2fT/FHkbdJD+L0KtvgjAaXKCGBqOT1pcW4JFQcZWrCjMLx
         ADqyaSIsUC/Vs7bEx9q9hfSBfSAD83fckZKmhgYBNkAHRMgRj9Teu0ct9fKFBDZsDIhs
         MmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ffL3XiM0LtkLjeoyTC4fynmObhqLJBu0oAAkB1Sv6bg=;
        b=OtfJZowlOJNosgAY2JIBZSSW4/0fD2M8M+6Ziechhwb6Judz2RigUjQjjH4GCVhNtg
         r2gXDCPudQCXbaR+oC5pqmxqEU67c/0YpexVelV7T5Waq3TLJJN0YUSTHeTM2kKbgwez
         2QTyxrcdDAZHYosF9OzrjqsxGV6wiAeh7tcHurXdetRPcrNtuA21ytKC8CvDXD3EXpAf
         lWYiBqCPVdfiVUtVynW+Psoy0JOnZV4+OpDhC17j+e1Opn4GluikwHmMssocHzzR46cu
         xG/LbTZkZIsWgFL7z5eV9nEF2+vCihePHMYD2ZdniFDeNeXUYuhLKvghjHzF4uBba89B
         JHXg==
X-Gm-Message-State: APjAAAWU0n2uqMlFro9gr56RPQXquGqt5bzCXWsToltFkU+h4kE6/Lex
        RmEN0kKltEK5ethE3oZiR/WYxQ==
X-Google-Smtp-Source: APXvYqzq78z4Kwl63piCU4DA6NkhH7ZUgZoHCweA3yZzD+3qAZFN3jAYRSTk9DhNa8iA9vWigiyilw==
X-Received: by 2002:a05:620a:1375:: with SMTP id d21mr1191457qkl.285.1574195499276;
        Tue, 19 Nov 2019 12:31:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k199sm10614778qke.0.2019.11.19.12.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:31:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXA9y-0003RM-6w; Tue, 19 Nov 2019 16:31:38 -0400
Date:   Tue, 19 Nov 2019 16:31:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191119203138.GA13145@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 11:54:38AM -0800, rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> Introduce maximum WQE size to impose limits on max SGE's and inline data
> 
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>  drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 1b596fb..31fb5c7 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -68,7 +68,6 @@ enum rxe_device_param {
>  	RXE_HW_VER			= 0,
>  	RXE_MAX_QP			= 0x10000,
>  	RXE_MAX_QP_WR			= 0x4000,
> -	RXE_MAX_INLINE_DATA		= 400,
>  	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>  					| IB_DEVICE_BAD_QKEY_CNTR
>  					| IB_DEVICE_AUTO_PATH_MIG
> @@ -79,7 +78,9 @@ enum rxe_device_param {
>  					| IB_DEVICE_RC_RNR_NAK_GEN
>  					| IB_DEVICE_SRQ_RESIZE
>  					| IB_DEVICE_MEM_MGT_EXTENSIONS,
> +	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */

This shouldn't just be a random constant, I think you are trying to
say:

  RXE_MAX_WQE_SIZE = sizeof(struct rxe_send_wqe) + sizeof(struct ib_sge)*RXE_MAX_SGE

Just say that

>  	RXE_MAX_SGE			= 32,
> +	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,

This is mixed up now, it should be

  RXE_MAX_INLINE_DATA = RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe)

> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index aeea994..323e43d 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -78,9 +78,12 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
>  		}
>  	}
>  
> -	if (cap->max_inline_data > rxe->max_inline_data) {
> +	if (cap->max_inline_data >
> +	    rxe->max_inline_data - sizeof(struct rxe_send_wqe)) {
>  		pr_warn("invalid max inline data = %d > %d\n",
> -			cap->max_inline_data, rxe->max_inline_data);
> +			cap->max_inline_data,
> +			rxe->max_inline_data -
> +			    (u32)sizeof(struct rxe_send_wqe));

Then this isn't needed

And this code in the other patch:

+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;

Makes sense as both max_inline_data and 'init->cap.max_send_sge *
sizeof(struct ib_sge)' are exclusive of the wqe header

Jason
