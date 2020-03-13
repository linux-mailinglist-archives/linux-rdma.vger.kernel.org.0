Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65614184868
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCMNo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:44:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32945 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:44:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so7506197qtn.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eE9cavhiLlvuEur+MG4EkrjIkSRrYoKgic3d1Kdjsuc=;
        b=ZYSCngtWLRoONCeTKNO1wbuAPZXa5+nLr0qbg6+WuzPZseTvzxvMfha/WcE6lARyL9
         USQYTxW3emnZRqOYP//85AgVLtefiIDO4O6R8n/nI2ectLKl/JSZ/gSTktMk3UGyaBHP
         nNW5vXsnd4PuAT6Lj87ZRVD/GnqGJ3FTFoveqcaxm1MuaBTSJPBSulkFqRuxjGuLE4VS
         m0o5jnga5zT4LfxPPZj0BLMj6/8i0N8Uht9ZN6nw50K1CCw42PFQO9FHAZzzbDw2+Ado
         P6846lWYXCCAOmhvF4+8gFAUqaJquZb1XcB3s0CgBZ5FLW4YkRUhdbsft2NCdUTohkYI
         MA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eE9cavhiLlvuEur+MG4EkrjIkSRrYoKgic3d1Kdjsuc=;
        b=CLKlmhzcY6NxYNwcEW8huK4GgV3sGzErfGY8MyRTTqpyrD2GfZ5wcaJySZuPQ4B+DN
         m+7kCP1eypL+/nVKBUXqa3CHDkF+T9pQxvSbVjs2J9Qz+68mVyZNPV0nFVoQAJp/35xF
         L5819y2zu1f1/McHARCeo08WNnzhz9G3KObcycb1UG7Nvh5ZdUm60LZB91fodXmYXLYQ
         8sEWkKAW9lg6gWPeHmo/bZijMgfaxcEeV909/5RhouUkrbRUJbPNxT2/+aybaURaP7aR
         kJzRdjdb4Sntb57RnhbKsgNU1nj2KDeJIiKDmLvSKfqXrWU0WrzczvkPA+1r5u9AwqwT
         t4Fg==
X-Gm-Message-State: ANhLgQ2PBam41LZWAvBtKySjvKzO7O40NZbt5XR3FE/pVanWRSv4rhvC
        W4RSWHy8sW5oxmYyy8dop5uetw==
X-Google-Smtp-Source: ADFU+vtDliWapgmei6C1LMtH9OcsJT+/uos9HgzVMTgT6IP1ITld97hHBI7v0liLHA6PT1nfgE47JQ==
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr2364382qtt.275.1584107097763;
        Fri, 13 Mar 2020 06:44:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p73sm10813808qka.14.2020.03.13.06.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:44:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkcS-0006Rg-La; Fri, 13 Mar 2020 10:44:56 -0300
Date:   Fri, 13 Mar 2020 10:44:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200313134456.GA24733@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091438.248429-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:14:30AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Remove custom and duplicated variant of offsetofend().
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index bf3120f140f7..5c57098a4aee 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
>  	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
>  }
>  
> -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> -				 sizeof_field(typeof(x), fld) <= (sz))
> -
>  #define is_reserved_cleared(reserved) \
>  	!memchr_inv(reserved, 0, sizeof(reserved))
>  
> @@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>  	if (err)
>  		goto err_out;
>  
> -	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> +	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {

The > needs to be >=, and generally we write compares as
   'variable XX constant'

> @@ -896,7 +893,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		goto err_out;
>  	}
>  
> -	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
> +	if (offsetofend(typeof(cmd), num_sub_cqs) > udata->inlen) {

Same

Jason
