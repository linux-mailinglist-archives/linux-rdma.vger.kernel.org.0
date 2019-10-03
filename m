Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DADC9EC8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfJCMsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 08:48:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34627 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJCMsm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 08:48:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id 3so3399883qta.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2019 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xCYuBm/C/4R9/rW9aA9GUi2vNkXBWjAEwDuliyQLLw=;
        b=JUEzkMvHCh7aN817AR7mRM0CgqFpbGE1pC9AMkqPNQFB/fqgp/bEElaY0DsfkRjJPm
         YlumomS5SGU+ZYEWXwhRC4aO7N+8P099dZXtDnUqrKhGLvswAyX5UQKvI/2J/4EkpoTH
         nTtBRfSEP3bOOjwdAwCXkcGeUmvq9j1Ex0GusgEGASQnqV5COogJ5/YgL6ns3+kXRm+d
         n2Jq05zLaJDatMjvb5hKx/m+cHtOsuJH6BEeu1sUbtBnHGe5QEivZl5CloCt8FgQVxQM
         TFHhI/sMfWVfLKndZJbG48mz4h9bBdOSTMgwxafIB1f1AUs2+lDpnpteqaArWtRI1x0B
         59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xCYuBm/C/4R9/rW9aA9GUi2vNkXBWjAEwDuliyQLLw=;
        b=ldC3mJ4noyg3MwWddJ8VU6QGZrEDeiVvh0c/T+1vwimG7VWFUId62JWzDRBYUv7mOG
         Qg8h0Pl9H5UpJxua5Q2niD0RybDoOo+OAPJSEkuD7lyPdd1dUsNuHWSu+EuFCCI+WiDI
         Fyq8REjc2oEU49HWQBlEFU+ib/NruTlKuIkzaY9bFrDuQHn6fPU4GR4K9D+dlZ4yKill
         lfRAf0joLnzTHM+fSEXBX47KxnosGZBMz7nXX52LezdRJqFICQvbo65wJw/gRPKLsNKa
         pRg5D1l4G7Kk6LI5QXfv/OUCEIGc6Few7hGCEr3yFGml4RLp7Tc4dOj2HDLBcJpYLHKV
         9u+A==
X-Gm-Message-State: APjAAAVL/4docAm6jpWZlzhrRJdN3475KIIO81k20JjApBWXzy9Zzuz9
        7IwIdt+Jv3HQmFyWJFHv7rBetw==
X-Google-Smtp-Source: APXvYqxgAlAh39aychwsSJoEoQJi8oZWGsYcVgTHXoNXiSqTIf4jUNSnLTwlRkQAu78PW5MmTQ8/1w==
X-Received: by 2002:ac8:48d8:: with SMTP id l24mr1718590qtr.241.1570106921263;
        Thu, 03 Oct 2019 05:48:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p56sm1549261qtp.81.2019.10.03.05.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 05:48:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iG0XA-0001TY-4n; Thu, 03 Oct 2019 09:48:40 -0300
Date:   Thu, 3 Oct 2019 09:48:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 2/6] RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an
 implicit MR
Message-ID: <20191003124840.GB26135@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-3-jgg@ziepe.ca>
 <20191002081826.GA5855@unreal>
 <20191002143928.GE17152@ziepe.ca>
 <20191002154114.GF5855@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002154114.GF5855@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 06:41:14PM +0300, Leon Romanovsky wrote:
> On Wed, Oct 02, 2019 at 11:39:28AM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 02, 2019 at 11:18:26AM +0300, Leon Romanovsky wrote:
> > > > @@ -202,15 +225,22 @@ static void mr_leaf_free_action(struct work_struct *work)
> > > >  	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
> > > >  	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
> > > >  	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
> > > > +	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
> > > > +	int srcu_key;
> > > >
> > > >  	mr->parent = NULL;
> > > >  	synchronize_srcu(&mr->dev->mr_srcu);
> > >
> > > Are you sure that this line is still needed?
> >
> > Yes, in this case the mr->parent is the SRCU 'update' and it blocks
> > seeing this MR in the pagefault handler.
> >
> > It is necessary before calling ib_umem_odp_release below that frees
> > the memory
> 
> sorry for not being clear, I thought that synchronize_srcu() should be
> moved after your read_lock/unlock additions to reuse grace period.

It has to be before to ensure that the page fault handler does not
undo the invaliate below with new pages

Jason
