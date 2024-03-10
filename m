Return-Path: <linux-rdma+bounces-1360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D0877635
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E02B20CA8
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41271EB3B;
	Sun, 10 Mar 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ1ja7vZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405FEEDD;
	Sun, 10 Mar 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710069469; cv=none; b=bONzzhV9IlkjYZneU1JXMo+RlqyLRHafr1yZaje5Ol/TCtRlW5dAvdmRr4iIHbL96KQ/hLJ3aR4IbNFqzMkXprAwm4s4c/PDECtxob+tAXOL4bdEJpbFNPnPMa/go6ONmCTFp27C+jYNpNEnWKbfl8I2xwNQ0YeljjxZfkNaD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710069469; c=relaxed/simple;
	bh=3s1ZmveQR14tT13H4TyNz+vgrxtLD79xkbyvkzcU1+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNVA+svzL6yRJZzU0krQEbdhLUA7UdjdjdN+KckGzrFcOEBLOi/dmSQvCmM0L7GM96/U0Au/Se0lQKu7MZTtFTB1sP0n4SdtX2inGunNZlf2Kldd4PL2oydiamQhs8ngXaBObJX2SOaM5oAW36oQKOm4t5uqVawkdhvIXzqmE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ1ja7vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BE5C433F1;
	Sun, 10 Mar 2024 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710069468;
	bh=3s1ZmveQR14tT13H4TyNz+vgrxtLD79xkbyvkzcU1+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ1ja7vZkyLjEP1jHyBw9XoAqfauKPAxHyRr3nkVN6LzcREvSIkONg/zUKvs3hdNk
	 oGzfRqK07qiV9ld0H8ywEk3FkGXwUqRYyajvJaEp4aWPXqeCTaqFusiPPT6zy/NG3k
	 QJkmBsA5RR3t4TxLwu2H+3995AArWpMOQ5eOHEas3Ur49+LSxIxivivl3NHlbCtelB
	 WUmKbGkrrCl9Sc601XU42UsLgbFiZR0qCZ7YcQGjoc7W0PhNu47d9+AIIIlQRIgqzC
	 cZ5WVwwKBgko3j5MSbdzPEKPlG0SxpODviGM5uBXDhYlk7hmmUj5pLZKWD7hK0gr+z
	 ROHseIkJ2j+jw==
Date: Sun, 10 Mar 2024 13:17:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, rama.nichanamatlu@oracle.com
Subject: Re: [PATCH v3] RDMA/cm: add timeout to cm_destroy_id wait
Message-ID: <20240310111744.GE12921@unreal>
References: <20240309063323.458102-1-manjunath.b.patil@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309063323.458102-1-manjunath.b.patil@oracle.com>

On Fri, Mar 08, 2024 at 10:33:23PM -0800, Manjunath Patil wrote:
> Add timeout to cm_destroy_id, so that userspace can trigger any data
> collection that would help in analyzing the cause of delay in destroying
> the cm_id.
> 
> New noinline function helps dtrace/ebpf programs to hook on to it.
> Existing functionality isn't changed except triggering a probe-able new
> function at every timeout interval.
> 
> We have seen cases where CM messages stuck with MAD layer (either due to
> software bug or faulty HCA), leading to cm_id getting stuck in the
> following call stack. This patch helps in resolving such issues faster.
> 
> kernel: ... INFO: task XXXX:56778 blocked for more than 120 seconds.
> ...
> 	Call Trace:
> 	__schedule+0x2bc/0x895
> 	schedule+0x36/0x7c
> 	schedule_timeout+0x1f6/0x31f
>  	? __slab_free+0x19c/0x2ba
> 	wait_for_completion+0x12b/0x18a
> 	? wake_up_q+0x80/0x73
> 	cm_destroy_id+0x345/0x610 [ib_cm]
> 	ib_destroy_cm_id+0x10/0x20 [ib_cm]
> 	rdma_destroy_id+0xa8/0x300 [rdma_cm]
> 	ucma_destroy_id+0x13e/0x190 [rdma_ucm]
> 	ucma_write+0xe0/0x160 [rdma_ucm]
> 	__vfs_write+0x3a/0x16d
> 	vfs_write+0xb2/0x1a1
> 	? syscall_trace_enter+0x1ce/0x2b8
> 	SyS_write+0x5c/0xd3
> 	do_syscall_64+0x79/0x1b9
> 	entry_SYSCALL_64_after_hwframe+0x16d/0x0
> 
> Orabug: 36280065

Not related to the upstream.

> 
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
> v3:
>  - added #define
> 
> v2:
>  - removed sysctl related code
> 
>  drivers/infiniband/core/cm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index ff58058aeadc..793103cf8152 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -34,6 +34,7 @@ MODULE_AUTHOR("Sean Hefty");
>  MODULE_DESCRIPTION("InfiniBand CM");
>  MODULE_LICENSE("Dual BSD/GPL");
>  
> +#define CM_DESTORY_ID_WAIT_TIMEOUT 10000 /* msecs */

CM_DESTORY_ID_WAIT_TIMEOUT -> CM_DESTROY_ID_WAIT_TIMEOUT

Fixed and applied.

Thanks

