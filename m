Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050DE2B510
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfE0M0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 08:26:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39106 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfE0M0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 08:26:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so15439278qkd.6
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+g52EaCMMLGA1oGswHNE4URzFyMIs2Igb1Mp4ikhvY=;
        b=EBk5LUD9rlvzxEA4NE3MhDOz7lJNOcyIsCAhpcOgdzhrewpP1UsgyWYN7YkbsAkhbN
         V1DFEF5H+NBascHCq4husro1VS5Qse7U04KDoba9NeAoygevwVhWwuK4GlHdwk9P6NrY
         zfW0IH7VGjE7kGzW8G5kQt1xpC/faPZrePmaiB52ZyQP9xmVJz67Hx7IqTIp/u0hoQbQ
         +GmTcHDfGr2pnS242dNVNMz1Byb6d/QMuE9ohad4o4FWSr4ERsCon/QUiOwynAGI1wX2
         HuAF+OcKGxD1UqkG4PKC46U9mc2AKUy2eVhwhLWZNoEN4DQ4K1cg5lB8w6Ae6MihrnS1
         qzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+g52EaCMMLGA1oGswHNE4URzFyMIs2Igb1Mp4ikhvY=;
        b=VfZCPM1UHbRNXbTJWaDc9bdOZmj/XhA6pHC5r3Qumt16cKnN3vEFUok5Ym1I0HTENA
         vxIYbhY4t7M/1y4h+3d5dRowka+FNVtnaI8EWu/9HP5TYq0tHoUAgc/VHfoDbjvODYvJ
         imEzphq89Mpd4FNxcEqTjD15fTqzipHZCQt3ikbjlL8mXznY8SZKuPxkEIO6/ciXQza8
         syyAyx5knTzF/PWgkM19HMmGrqOSxL96OPnYcCIRw/5c26m6vDPabrCXVEFfvcpoq0lR
         1HzCFrQgg3CeO8BXf8hKEq/socY72TC2F372JD5GK8d5XBrT65NMe9Sypxl/zS1/gLKo
         8thw==
X-Gm-Message-State: APjAAAWhGgL7zIetcoSciKVfrnDtHvGH7UVGZBTZAlVy7pmQ2q/rAWC5
        uf3Oampe5NQ2W8qQisgmwACSTQ==
X-Google-Smtp-Source: APXvYqzl1gF4A/BozgVnksQrGYgSKLgjeOAg+VrSEeoA5XQBi+Nrvrvf3uK6ARC8tV6sKYeTjjaEHQ==
X-Received: by 2002:a37:ea16:: with SMTP id t22mr63959991qkj.337.1558959967831;
        Mon, 27 May 2019 05:26:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id m5sm747298qke.25.2019.05.27.05.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 05:26:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVEhb-0003nH-1S; Mon, 27 May 2019 09:26:07 -0300
Date:   Mon, 27 May 2019 09:26:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC] verbs: Introduce a new reg_mr API for virtual address space
Message-ID: <20190527122607.GD8519@ziepe.ca>
References: <20190526080224.2778-1-yuval.shaia@oracle.com>
 <20190527121134.GC8519@ziepe.ca>
 <20190527121838.GA13891@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527121838.GA13891@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 03:18:39PM +0300, Yuval Shaia wrote:
> On Mon, May 27, 2019 at 09:11:34AM -0300, Jason Gunthorpe wrote:
> > On Sun, May 26, 2019 at 11:02:24AM +0300, Yuval Shaia wrote:
> > > The virtual address that is registered is used as a base for any address
> > > used later in post_recv and post_send operations.
> > > 
> > > On a virtualised environment this is not correct.
> > > 
> > > A guest cannot register its memory so hypervisor maps the guest physical
> > > address to a host virtual address and register it with the HW. Later on,
> > > at datapath phase, the guest fills the SGEs with addresses from its
> > > address space.
> > > Since HW cannot access guest virtual address space an extra translation
> > > is needed map those addresses to be based on the host virtual address
> > > that was registered with the HW.
> > > 
> > > To avoid this, a logical separation between the address that is
> > > registered and the address that is used as a offset at datapath phase is
> > > needed.
> > > This separation is already implemented in the lower layer part
> > > (ibv_cmd_reg_mr) but blocked at the API level.
> > > 
> > > Fix it by introducing a new API function that accepts a address from
> > > guest virtual address space as well.
> > > 
> > > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > >  libibverbs/driver.h    |  3 +++
> > >  libibverbs/dummy_ops.c | 10 ++++++++++
> > >  libibverbs/verbs.h     | 26 ++++++++++++++++++++++++++
> > >  providers/rxe/rxe.c    | 16 ++++++++++++----
> > >  4 files changed, 51 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> > > index e4d624b2..73bc10e6 100644
> > > +++ b/libibverbs/driver.h
> > > @@ -339,6 +339,9 @@ struct verbs_context_ops {
> > >  				    unsigned int access);
> > >  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
> > >  				 int access);
> > > +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> > > +					 size_t length, uint64_t hca_va,
> > > +					 int access);
> > 
> > I don't want to see a new entry point, all HW already supports it, so
> > we should just add the hca_va to the main one and remove the
> > assumption that the void *addr should be used as the hca_va from the
> > drivers.
> 
> So it is better to change the reg_mr signature? That would break API, i.e.
> all apps that are using reg_mr would have to be changed accordingly.
> I'm a newbie here so i might be talking nonsense.

driver.h is not ABI

> > > diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> > > index cb2d8439..8bcc8388 100644
> > > +++ b/libibverbs/verbs.h
> > > @@ -2037,6 +2037,9 @@ struct verbs_context {
> > >  	struct ibv_mr *(*reg_dm_mr)(struct ibv_pd *pd, struct ibv_dm *dm,
> > >  				    uint64_t dm_offset, size_t length,
> > >  				    unsigned int access);
> > > +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> > > +					 size_t length, uint64_t hca_va,
> > > +					 int access);
> > 
> > Can't add new functions here, breaks the ABI
> 
> My assumption was that it is better to add new function than to change an
> existing function's signature.

verbs.h is ABI, so you have to change it by growing the structs, not
adding things in the middle.

Probably the best thing for an API like this is to just add a new
normally linked public function instead of using function pointers
here.

Jason
