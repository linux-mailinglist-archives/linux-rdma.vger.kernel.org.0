Return-Path: <linux-rdma+bounces-2857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0278FBBF7
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9294D1F26BAC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0014A60A;
	Tue,  4 Jun 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUdLj4Md"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3134A11;
	Tue,  4 Jun 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527489; cv=none; b=XIieI9XOQd7xd7ICEfcYOKutYCUqrl/FADH3CpAeO9xT+Ur/cJaU1qWP0hGs18HdokO7d5cHZHwPUXtLr9FyQE34UarniQX/u+4d1ZGvaEA9rc8R/HziP5big5OSk2CPD+5jWQYfVr5/Q7RbaZmwFnb0EeDxwQVrAinHFZ/B4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527489; c=relaxed/simple;
	bh=7nozJoS27TnUtwEyt01rUHz8ZytmR7cN5oUHgzupIyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckdo4ZD+U5vWfA8kuFB7A2sNJm2pvIqWN3DF6npTZYqacvFZeiv9kIRoVTJ3+SsuR3XtoBxyzM0mcR2LRKtzTnx/0iAbjRYIaOoFw5INvG/nlfyzvGNP0nStoRhQFz4iufA19+Sg94Zq8qzoW58p4oHByQHrfnwmeebb9Ea+SBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUdLj4Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD2FC2BBFC;
	Tue,  4 Jun 2024 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527489;
	bh=7nozJoS27TnUtwEyt01rUHz8ZytmR7cN5oUHgzupIyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUdLj4Mdi847j2rt8G31dUu+LngXPIo5Y7OfpGAHnqACt9pfar2v9fejJjW5UR9j5
	 98hh6DW1U8Ds80qB9ufxDNw1lpZR5wAnBuvgAnfedHPD+Jqq9MZNUBXfGPhmPyYVdw
	 cHhxnGLCEkPBG0i9k1Z+QIfQZU6g2iltouQZVtgMqkwNtHgoTEqZ/Nc6Pb6uis2oIb
	 08ea49kKVVKyZb8Aeypgo0C1JO/+VCSZK+3Bzj8oxiDUX2+d2Ye/egolK3mAfrv4CF
	 JsrEKF1ooBTgvbMshG9MlExosHPcytMxoHOcNpnkWfYzoFZyA7jFFLR5Qgy7UrUTOr
	 Ec1wDVb88BNqA==
Date: Tue, 4 Jun 2024 21:58:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240604185804.GT3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
 <20240604113834.GO3884@unreal>
 <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl9BOaPDsQBc8hSL@slm.duckdns.org>

On Tue, Jun 04, 2024 at 06:30:49AM -1000, Tejun Heo wrote:
> Hello, Leon.
> 
> On Tue, Jun 04, 2024 at 02:38:34PM +0300, Leon Romanovsky wrote:
> > Thanks, it is very rare situation where call to flush/drain queue
> > (in our case kthread_flush_worker) in the middle of the allocation
> > flow can be correct. I can't remember any such case.
> >
> > So even we don't fully understand the root cause, the reimplementation
> > is still valid and improves existing code.
> 
> It's not valid. pwq release is async and while wq free in the error path
> isn't. The flush is there so that we finish the async part before
> synchronize error handling. The patch you posted will can lead to double
> free after a pwq allocation failure. We can make the error path synchronous
> but the pwq free path should be updated first so that it stays synchronous
> in the error path. Note that it *needs* to be asynchronous in non-error
> paths, so it's going to be a bit subtle one way or the other.

But at that point, we didn't add newly created WQ to any list which will execute
that asynchronous release. Did I miss something?

Anyway, I understand that the lockdep_register_key() corruption comes
from something else. Do you have any idea what can cause it? How can we
help debug this issue?

Thanks

> 
> Thanks.
> 
> -- 
> tejun
> 

