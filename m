Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD713D09C0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhGUGxD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235270AbhGUGuo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 02:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C6160FEA;
        Wed, 21 Jul 2021 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626852671;
        bh=wWQxKLbViMQ6IioJwrIW6WryLEBn92ln/LclVS/TIuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WK0GEeAwPG2IcBNUfqoYtOlPZJ+Jfdv8Na3BIvlnR8R8bcjmvmAwEzU+h01OBrmG7
         vOYbyxJhrBfCD8Lo72NkyNGNX9Qd9nTedaSbsG4JjblG4r742i1xDPR/LFlnjEetn5
         NQbv2VhXIYHebsKJkRRdEXHFQAgge5QCi3OA80ZQun96ryEgjpHF2dDyUML1Sb2dsY
         rKG/uhf8rAQgMHNoMKFGnjpsMPF91TJsLUZdkAqSUo/B7LpJ0S37WY/qQNADQyHR9Z
         oSOq3Sa+Mvu2VZLt1wIAg1lQJvl47sovB87grKHRen9KrQAM37Io6skRofd9AxhbN4
         ZrRYlwOTrjxuw==
Date:   Wed, 21 Jul 2021 10:31:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations
 interface for uverbs
Message-ID: <YPfNPL8qWcvMVyD2@unreal>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
 <YPfDUN6CaOdGZLPS@infradead.org>
 <YPfHXpFtB1RJ4yjU@unreal>
 <YPfI4+M/Ula5a0KZ@infradead.org>
 <YPfK0VHovcc45heP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPfK0VHovcc45heP@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 08:20:49AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 08:12:35AM +0100, Christoph Hellwig wrote:
> > On Wed, Jul 21, 2021 at 10:06:06AM +0300, Leon Romanovsky wrote:
> > > You will need to add some sort of "if qp tpye" for ib_create_qp_uverbs() callers,
> > > because they always provide udata != NULL. 
> > > 
> > > After this series, the callers look like this:
> > > 
> > >  1438         qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
> > >                                                           ^^^^^^^^^ not NULL
> > > 
> > > So instead of bothering callers, I implemented it here with one "if".
> > 
> > Sorry if my mail was confusing.  I don't want it in the callers, I
> > want it as deep down in the stack as possible instead of having the
> > strange wrapper.
> 
> In fact ib_create_qp_user already sets udata to NULL for IB_QPT_XRC_TGT,
> and _ib_create_qp/create_qp ignores the caller if the udata is NULL.
> So I think you can just remove the wrapper and we're already fine.

Yeah, thanks
