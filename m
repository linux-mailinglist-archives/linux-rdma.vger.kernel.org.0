Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3AC8B68
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfJBOja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 10:39:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33730 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJBOja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 10:39:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so26685762qtd.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7YHqyUZD/8NIZ2SubBXQMgHPSS2u+oGKWBH9fMpoRow=;
        b=o22pljnxja/9CD7V4C4Qn1J1tj1U0zcwxX6JKuoamq0XxWpooE+3q5sabL2Tr0Xnpi
         RAgdb9V1d8Cf2nlx9omXQgRqcuUNyi7DSPpzZMqbVl9fQlRChMczEIX4NxHG4pt/ssFj
         JLXaYAvVeTUVCRvGF1KeZQtcjEHHt0uO8zAnhjWqpFMkihfNgbUFxJsIJQ6qBrjncixs
         DYMKAdWoT+0iIZcFjysj48v0tGVrwy4B3kkb3xZzU+8AKNS4OvGvNb1QA7Tbj5WB9GAl
         yZQGxt4uWOHzYgkIJ4x6epYxkOxu1bor7+sG0j/gnqdQMq2b4fPSrDabCOtEPqImqCrt
         XPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7YHqyUZD/8NIZ2SubBXQMgHPSS2u+oGKWBH9fMpoRow=;
        b=RA1zaxssxWmJOliNei6GKwLcn4HV8BeUyB35Fe5c8Y8mywL8VBvznpWeU2HJTxjHdT
         /zUF19+mYZ0lB3YaLUYTkO4IgoIlfLgvW0rv/3GWNp+HK0JuT8tixJqLVRjonuGJLYhX
         WYUZwmgkLGjwGXFeR/z2BtKeppSYRgSifB2JFKepyYyJEumd0fecgdGhkSbc94LLwOUd
         mBH8UTl2tNY7lkLlFdHUvGOOVR2aEG6ccuEqY/Jx4ak1Hc21ug9jz5fbSAZvgXV8jSiO
         GVTJH9coYHuiOxtFGJHMLmi/eX6OmTwRNJaQ8kq5XX5BJBVxcH+juk5vEat4DfWTUvlH
         svKg==
X-Gm-Message-State: APjAAAVVPXVsXQ7ItHZ1GLK8RYgM88lortRKWI+C0UwgvF1nRTMuCTTH
        PZyVTkPR9Gci1shH6k/lpvJLeasnc+E=
X-Google-Smtp-Source: APXvYqx2s77HtzscqetmzrgbU5wP2nVoy4k6FeFeTk/+TA557I+ojc6fH4KuDw1QpblX/+ZVpTYMcw==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr4360009qta.375.1570027169559;
        Wed, 02 Oct 2019 07:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w9sm2483148qto.44.2019.10.02.07.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 07:39:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFfmq-00070n-Hc; Wed, 02 Oct 2019 11:39:28 -0300
Date:   Wed, 2 Oct 2019 11:39:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 2/6] RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an
 implicit MR
Message-ID: <20191002143928.GE17152@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-3-jgg@ziepe.ca>
 <20191002081826.GA5855@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002081826.GA5855@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 11:18:26AM +0300, Leon Romanovsky wrote:
> > @@ -202,15 +225,22 @@ static void mr_leaf_free_action(struct work_struct *work)
> >  	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
> >  	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
> >  	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
> > +	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
> > +	int srcu_key;
> >
> >  	mr->parent = NULL;
> >  	synchronize_srcu(&mr->dev->mr_srcu);
> 
> Are you sure that this line is still needed?

Yes, in this case the mr->parent is the SRCU 'update' and it blocks
seeing this MR in the pagefault handler.

It is necessary before calling ib_umem_odp_release below that frees
the memory

Jason
