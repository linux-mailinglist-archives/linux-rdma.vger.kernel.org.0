Return-Path: <linux-rdma+bounces-1845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596289BFC6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BE3285E96
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D057D41B;
	Mon,  8 Apr 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJGhC5xC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC37D3F1;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581228; cv=none; b=DEJgRnnyrF0xqgg4ewjVgJ6ODRr8p/C6DOGiw8NVlExhWC6p3MJq62jdGm8Qg+PTfaoi99KUKsoCE+c/1Za/e60fZlLCSCqtX0jxJAXtQgHAdPN4GMqhn7Eu/YyPDI/wPwf0LLSX/73NKwWCUpCS7HXDg3a3JdKl/HYQO0jtnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581228; c=relaxed/simple;
	bh=Wpv5AKvn48JjIJwCSXxs+rgMlho3WmegP95pAqv7OOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH79FaTQRS3OKKJf/XwPWW3C2ONbCFKrEP5pJq/DI7wSr6cqv9Z5fYDQI7EnG0RuWo03mkFPgl+f8/KlyZe2JBYazQh1xaYuDYPa4VqOJAD/SkQjgB0w++wrvoemNm8eKv3NnXEKVPSEvNo7GZcOkRQ+Lf1NZx6nMZZawjnv/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJGhC5xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE8C433B2;
	Mon,  8 Apr 2024 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581228;
	bh=Wpv5AKvn48JjIJwCSXxs+rgMlho3WmegP95pAqv7OOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJGhC5xCjCwXgcZJ0g3vBg/r0ulgVUGmdvMC9pjzwD3AVdMeE3DvbCP733rQgj1JS
	 0UqtFfkIs7CXis50ct2Lygz+Z6/oZCt6wg/G8ba6MGOQEW+MDEeZrzc1HGXOlSBWXH
	 fW5a/cLxIX5O1sJ8nw78nJnH7f5xV7brTvxA5JAnjiZCIbOImEHX2PtSS5ylH3oaVk
	 +xXCmvRgJPJ/zSLD/qD10aeXwY+5s+GwZXsaT3OtoRkl8I9FDQTA1CTFuNPTXCPqpU
	 rGo8nlPQ3KjS0KwbFgr+7ap6HMbBhqpISs7MRHPXsi2W1JpWhncN2E/YtQS2rdIBwA
	 KgZZSUCN4U5/g==
Date: Mon, 8 Apr 2024 16:00:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v4 0/4] Define and use mana
 queues for CQs and WQs
Message-ID: <20240408130024.GG8764@unreal>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240408112533.GF8764@unreal>
 <PAXPR83MB05570E9EE9853B2E6F66703DB4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05570E9EE9853B2E6F66703DB4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Mon, Apr 08, 2024 at 12:50:12PM +0000, Konstantin Taranov wrote:
> > From: Leon Romanovsky <leon@kernel.org>
> > On Mon, Apr 08, 2024 at 02:14:02AM -0700, Konstantin Taranov wrote:
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > >
> > > This patch series aims to reduce code duplication by introducing a
> > > notion of mana ib queues and corresponding helpers to create and
> > > destroy them.
> > >
> > > v3->v4:
> > > * Removed debug prints in patches, as asked by Leon
> > >
> > > v2->v3:
> > > * [in 4/4] Do not define an additional struct for a raw qp
> > >
> > > v1->v2:
> > > * [in 1/4] Added a comment about the ignored return value
> > > * [in 2/4] Replaced RDMA:mana_ib to RDMA/mana_ib in the subject
> > > * [in 4/4] Renamed mana_ib_raw_qp to mana_ib_raw_sq
> > >
> > > Konstantin Taranov (4):
> > >   RDMA/mana_ib: Introduce helpers to create and destroy mana queues
> > >   RDMA/mana_ib: Use struct mana_ib_queue for CQs
> > >   RDMA/mana_ib: Use struct mana_ib_queue for WQs
> > >   RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
> > >
> > >  drivers/infiniband/hw/mana/cq.c      | 52 +++-------------
> > >  drivers/infiniband/hw/mana/main.c    | 39 ++++++++++++
> > >  drivers/infiniband/hw/mana/mana_ib.h | 26 ++++----
> > >  drivers/infiniband/hw/mana/qp.c      | 93 +++++++++-------------------
> > >  drivers/infiniband/hw/mana/wq.c      | 33 ++--------
> > >  5 files changed, 96 insertions(+), 147 deletions(-)
> > 
> > It doesn't apply.
> > 
> 
> I guess there was some mis-synchronisation between us.
> I see that you have already applied the patch 6 days ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/
> 
> I am sorry for sending a newer version after the patch has been applied.
> I have not checked this before sending.
> I can take care of useless debug prints in a future cleanup patch.

Please rebase your series, and resend.

Thanks

