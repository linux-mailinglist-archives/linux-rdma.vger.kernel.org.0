Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27503D09A0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhGUGoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhGUGku (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:40:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7FC061762;
        Wed, 21 Jul 2021 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jvEUbpJ8TCtLelW8CVjzfn7aO1stF0egZ5Xqu/e2sSA=; b=qW8hShGi6jgJH5/3/w00cESqOZ
        t/EtXpoZ7FlwX8rNh/oNFITrVQgdktxf1T0t+3EKBYq8y7m6Kzi2VIxre6PLdyb++1y3p/74Ae8Dp
        VnFvL62/825cINrbM+26Y1U69gx23Q/32BJ7LLiYeWz7mEuxUpIrdsp/EmBDKPB4Bi3ZU4uPkRUuL
        Ew9IrnvrdFbzACea+L7Mr7uqf0IvEzLEJMCIdQGhM0o6Nni9SAPF8Zr1hyLxg7rWegM37AvJMmyf4
        OFDqe5De4c91xLXRYpyYMw1+XMbJNDUgtmm3sTgCOeClrLQdRCi76DAXj2D6vp+QznCEYpv7GUx4H
        9KjoVjVA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m66XB-008v47-0p; Wed, 21 Jul 2021 07:20:55 +0000
Date:   Wed, 21 Jul 2021 08:20:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations
 interface for uverbs
Message-ID: <YPfK0VHovcc45heP@infradead.org>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
 <YPfDUN6CaOdGZLPS@infradead.org>
 <YPfHXpFtB1RJ4yjU@unreal>
 <YPfI4+M/Ula5a0KZ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfI4+M/Ula5a0KZ@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 08:12:35AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 10:06:06AM +0300, Leon Romanovsky wrote:
> > You will need to add some sort of "if qp tpye" for ib_create_qp_uverbs() callers,
> > because they always provide udata != NULL. 
> > 
> > After this series, the callers look like this:
> > 
> >  1438         qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
> >                                                           ^^^^^^^^^ not NULL
> > 
> > So instead of bothering callers, I implemented it here with one "if".
> 
> Sorry if my mail was confusing.  I don't want it in the callers, I
> want it as deep down in the stack as possible instead of having the
> strange wrapper.

In fact ib_create_qp_user already sets udata to NULL for IB_QPT_XRC_TGT,
and _ib_create_qp/create_qp ignores the caller if the udata is NULL.
So I think you can just remove the wrapper and we're already fine.
