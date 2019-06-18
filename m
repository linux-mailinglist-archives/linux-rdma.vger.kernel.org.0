Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46CC4AA35
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfFRSsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 14:48:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34442 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfFRSsK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 14:48:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so16719742qtu.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNUYSxSNmQUKvCt5SlSj4VUhgTvckTHE4NII56DdNFM=;
        b=o8UAueg63RwB19WzkIRWBlyyO6GnrkrpOGZx1MuhG1XuWy4stkvJw6ZYFcc7u29UlK
         d2rAVBruuIgyrkcwpKNDzwN7CASIsn5WL4PxGZlynOvOViMG/DNiw85RPawjzJQeEF9o
         HGFi1SHvsHrrtQurbP212qOdicm5FK0AZX9jSh0QpYMIepr0XN3x2QsrhpV+W1hVN1FK
         wOdM6PjHugaAS8qvJg8KALG7JNqvBDO0c4dsPitGzZEkJeh5BL5eNvDSO0He5Yp9EaaJ
         Kr0Wean/R3ALljUArJUNJMcFcBRew/uEPpHPQ8xXe4HRFJjjQznWx4hWUOh+Z9hk6u74
         NMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNUYSxSNmQUKvCt5SlSj4VUhgTvckTHE4NII56DdNFM=;
        b=PzS2WzMcF5ieqwhulaUwUHVUalFROkwxroHV0ocuRgL5PjUNdjYsSxG0N91iNMuSwp
         NLwl1UDJZX1az3zajd39YR76PQKN26JhB17Jq3pewJfvwML2yInhzOHqUUSXkM3faysj
         WyKb4nQvujcdA/1UGwML4izuUKL1fr5oFYpuGrrA0//dyPPNQIFJKrpWOx8ActHSIv3e
         97TbsM4l3w3gQS2B4ptBmNlZmcZUsSNq6uIFw9SMIscS8kIX+q9frFa/hgrrinxhp48X
         lm+83kx34GFk/e3DjGF7SJVpBMW7LXfjSmfDJJs6kr6clPz5q/yPWbkAAPdSEOLVM/wQ
         sLbw==
X-Gm-Message-State: APjAAAVUucCpcNOMBpqIPKWNAfeFOGhJfzprFJx+WshNj1B/9fXiK7fb
        KUYFiMTylKsqA8X72JQnBcVz4w==
X-Google-Smtp-Source: APXvYqxUVDFxstN/WAauCDtGVCLAwK0X3MiA90DRxvYMN09+KUg2ASnRA5Alc36bJZPHn43DRy+9KA==
X-Received: by 2002:a0c:bf47:: with SMTP id b7mr28958792qvj.4.1560883689379;
        Tue, 18 Jun 2019 11:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d123sm9719999qkb.94.2019.06.18.11.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 11:48:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdJ9M-00004v-Ak; Tue, 18 Jun 2019 15:48:08 -0300
Date:   Tue, 18 Jun 2019 15:48:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/efa: Handle mmap insertions overflow
Message-ID: <20190618184808.GN6961@ziepe.ca>
References: <20190618130732.20895-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618130732.20895-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 04:07:32PM +0300, Gal Pressman wrote:
> When inserting a new mmap entry to the xarray we should check for
> 'mmap_page' overflow as it is limited to 32 bits.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Changelog:
> v1->v2
> * Bring back the ucontext->mmap_xa_page assignment before __xa_insert
>  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 0fea5d63fdbe..fb6115244d4c 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  			     void *obj, u64 address, u64 length, u8 mmap_flag)
>  {
>  	struct efa_mmap_entry *entry;
> +	u32 next_mmap_page;
>  	int err;
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>  	entry->mmap_flag = mmap_flag;
>  
>  	xa_lock(&ucontext->mmap_xa);
> +	if (check_add_overflow(ucontext->mmap_xa_page,
> +			       (u32)(length >> PAGE_SHIFT),
> +			       &next_mmap_page))
> +		goto err_unlock;
> +
>  	entry->mmap_page = ucontext->mmap_xa_page;
> -	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);

Why did DIV_ROUND_UP become >> ?

Jason
