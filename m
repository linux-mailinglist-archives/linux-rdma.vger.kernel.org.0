Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E582072E3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgFXMIp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 08:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388522AbgFXMIo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 08:08:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502672088E;
        Wed, 24 Jun 2020 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593000524;
        bh=x5E4NeaEUyA42H8D+d3uvtECKmUEW4kMd8MIIhntWEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0fTwQiM2AnG2++nvBMqcP4kFmThTTo4ZVpGP2v6NSl+6ahTqQjI/54x9Yc6Q5AqD
         2WTdZ1rLKpjCQAYysEJodp2PjrFMpRy4yUdvUtRKkzxVP8W2UGc33bqyf7a/rxF11N
         6eoGZCN/6mb6RfWKgLz794IOrUIaim190Z/7YQA0=
Date:   Wed, 24 Jun 2020 15:08:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH wip/jgg-next] fixup! RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200624120840.GA1446285@unreal>
References: <20200624070031.1436711-1-leon@kernel.org>
 <20200624115331.GQ2874652@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624115331.GQ2874652@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 08:53:31AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 24, 2020 at 10:00:31AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Rebase error against
> > https://lore.kernel.org/r/20200507062942.98305-1-leon@kernel.org
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/nldev.c | 2 --
> >  1 file changed, 2 deletions(-)
>
> Hurm, OK, I squashed it in, the commit IDs will change now for your
> userspace series

Right, but commit ID is not critical, better to keep bisectability.

>
> Jason
