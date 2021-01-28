Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4707C307834
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhA1Off (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:35:35 -0500
Received: from gentwo.org ([3.19.106.255]:44588 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhA1Ofc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Jan 2021 09:35:32 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 290D83F4C1; Thu, 28 Jan 2021 14:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2737B3F461;
        Thu, 28 Jan 2021 14:34:45 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:34:45 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Jason Gunthorpe <jgg@nvidia.com>
cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
In-Reply-To: <20210128140335.GA13699@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2101281433270.10563@www.lameter.com>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com> <20210128140335.GA13699@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 28 Jan 2021, Jason Gunthorpe wrote:

> I need patches to be sent in a way that shows in patchworks to be
> applied:
>
> https://patchwork.kernel.org/project/linux-rdma/list/


I see it in patchworks:

https://patchwork.kernel.org/project/linux-rdma/patch/alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com/

> > Index: linux/drivers/infiniband/core/cma.c
> > ===================================================================
> > +++ linux/drivers/infiniband/core/cma.c	2021-01-25 09:39:29.191032891 +0000
> > @@ -4542,17 +4542,6 @@ static int cma_join_ib_multicast(struct
>
> Also if patches aren't generated with 'git diff' then I won't fix any
> minor conflicts :(

Well it was quilt ...... Do I need to put it into a git tree somewhere?

