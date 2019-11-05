Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE4F0638
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfKETrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 14:47:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36448 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKETrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Nov 2019 14:47:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id d13so22341675qko.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2019 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=In8zIlEek1F3Y7J4BDJIH4p66Fe9y4GTIugIWdREpTo=;
        b=oDPVfJU6qV+EolMylysHcX2b/jvnGS9xboFib9YcUTgGs0j+KSq4ReG916/QrtG6dZ
         pH4NDBODgxQP69HHMTKpfWAv1YNVxS5ts8hLAXTYdAwHFNTxKZ6XUAk0uzGXCiXP8IgL
         ajk3TIMvdv+aUmOpgm7WPbE3lXKdVQWTRaYZwD+rT9PHxoEqJYtvhsuvVZ3hKoX/e1fP
         bSoeCt84wjQhKFGSWhfQHPJ+eXHXIt/Y+Ppgedvh1HqKTi8yk/rnF0s14BSwg+sFN8s/
         tyHiIXtZDT1gibevMmkwCLUylAGWsws8w004Y61Qz7XVzz2e45HLdecGancrt1jjjy8o
         n+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=In8zIlEek1F3Y7J4BDJIH4p66Fe9y4GTIugIWdREpTo=;
        b=W8XhUvKExc8GyG+N/FQXKJhng0ioEGEwKFF52TcrKyXQuQpVh3dZUaiYgj7BuhCh8Y
         yzmaVx8FswFNPOsIox7EvRKecL1ov6FYVkD7ZrXneIP9M4nwv4sYZdVPJgCTrWrsMGGY
         eZd3wzVvFeOd4V/1nABYRA4SrrVLVYFMB0EpUnZjwZ4SD6QJj72jpGNLmKQ8DVHic/2r
         hkRg3X5g+gwy52jF17xlrBu2/7hrD+KvL/BChDAh0jWxq7GagyZ6Mia/ULq5dObMNQHd
         8dDg5TSPVRfD8+azOLjkpV3+N/Jz+G6gMkMbA2/zugXvrPw926qIlFX6mfDTzfP8rVtN
         2sBQ==
X-Gm-Message-State: APjAAAXY+ZSxxx80GsVLSwqQ/yOfRcqfSw7cgTqwodXOkjY3Ts6ELOs3
        PJ92zPwn+AHpwBm7viw9+tUNYw==
X-Google-Smtp-Source: APXvYqwkkbYRkytNrCP/Wke81nUiUMTD9oMJt87kG7XBPXhcUOZy6oKqScVRfC/1+C4R0eo2Dh2ITA==
X-Received: by 2002:a37:6156:: with SMTP id v83mr22644172qkb.43.1572983266030;
        Tue, 05 Nov 2019 11:47:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d39sm13121973qtc.23.2019.11.05.11.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Nov 2019 11:47:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iS4nn-0005BA-Ov; Tue, 05 Nov 2019 15:47:43 -0400
Date:   Tue, 5 Nov 2019 15:47:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, dledford@redhat.com, galpress@amazon.com,
        yishaih@mellanox.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v12 rdma-next 3/8] RDMA: Connect between the mmap entry
 and the umap_priv structure
Message-ID: <20191105194743.GA19748@ziepe.ca>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
 <20191030094417.16866-4-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030094417.16866-4-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 11:44:12AM +0200, Michal Kalderon wrote:

> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index b1f5334ff907..dbe9bd3d389a 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -819,7 +819,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		goto out_unlock;
> -	rdma_umap_priv_init(priv, vma);
> +	rdma_umap_priv_init(priv, vma, opriv->entry);
>  
>  	up_read(&ufile->hw_destroy_rwsem);
>  	return;
> @@ -844,6 +844,11 @@ static void rdma_umap_close(struct vm_area_struct *vma)
>  	if (!priv)
>  		return;
>  
> +	if (priv->entry) {
> +		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
> +		priv->entry = NULL;
> +	}
> +

This should be done inside the lock otherwise it can race with
uverbs_user_mmap_disassociate(), the assignment of NULL is not needed
as we free it immediately after.


> @@ -946,6 +951,13 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  
>  			if (vma->vm_mm != mm)
>  				continue;
> +
> +			if (priv->entry) {
> +				rdma_user_mmap_entry_put(ufile->ucontext,
> +							 priv->entry);
> +				priv->entry = NULL;
> +			}
> +
>  			list_del_init(&priv->list);
>  
>  			zap_vma_ptes(vma, vma->vm_start,

The zap needs to be before the entry_put so that the pages are
actually removed before the driver goes to free them

Jason
