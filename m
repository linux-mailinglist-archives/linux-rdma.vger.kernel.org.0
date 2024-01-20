Return-Path: <linux-rdma+bounces-665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104B8333EC
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jan 2024 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F28B22101
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jan 2024 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B92DDC3;
	Sat, 20 Jan 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRGFnh4n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C051EAF0;
	Sat, 20 Jan 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705751343; cv=none; b=QfDBnR8EOwLHKdjg7xeL1ruXzmCJU8umMw2uNLPTh/FWTdm8KsmUzuN3Bz3uFFS3IF3I5VakXII52DABcQQCwDQk1AgM+j/iq0vG8rBmYY2nF4imocuF8og+/efWyzimW/RiZERYPRP/nYJptK/WMQk8mcvjHHXhJPpaiYWDX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705751343; c=relaxed/simple;
	bh=mdIkL7GnY9uNIXZjyKw6WvyQU9zXwQu64RRQFYtCffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzrf7qFID/vEiLZfY2rpP1UeKpwh1BTe2apl9RSe6boARgrQvRMT6g93pwchkHXPTGGOKudPGBua443+milSlPZrQhBhzirmOlC8vikeSmf6EhArKac0wJvcglBQVIlRJ1atpRYLoBIm0HOUmjULTeIwOKDrCK3SITVsUwMwaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRGFnh4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70187C433F1;
	Sat, 20 Jan 2024 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705751342;
	bh=mdIkL7GnY9uNIXZjyKw6WvyQU9zXwQu64RRQFYtCffE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRGFnh4nsjrmoor4f9VPm0kMUsN0gfDp6m3jgAwIXy1HraYs8RGJHwLwo00aGmSdn
	 QflMkVLU3Ep/f4VNwcGy3JyM8yNJjoML9bn7GC2KKI70sVEj8mESA/kshBwKAs6afT
	 D41s44AQ8TqvoOh734hrScmIezPBTCxHhieN+2OR0DBQTO7yfkNcdhJZ5oJFnVudOn
	 sbdWZxvGMNpnXf+DvE4egGtSY/pA+5m+mWrfQfpNVOGdyPNd7rTWKcgXjZ8VQ7p/hG
	 pi+M5x65w5LAMox9P1gdMrddnDnCV16scqR552RkDgEWqWOMZVLSBOQhwzDD/Kr3OQ
	 CipCVwb8xrCSQ==
Date: Sat, 20 Jan 2024 11:48:56 +0000
From: Simon Horman <horms@kernel.org>
To: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzkaller@googlegroups.com, chenyuan0y@gmail.com, zzjas98@gmail.com,
	gerd.rausch@oracle.com, allison.henderson@oracle.com,
	aron.silverton@oracle.com
Subject: Re: [PATCH] net/rds: Fix UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
Message-ID: <20240120114856.GC110624@kernel.org>
References: <1705715319-19199-1-git-send-email-sharath.srinivasan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705715319-19199-1-git-send-email-sharath.srinivasan@oracle.com>

On Fri, Jan 19, 2024 at 05:48:39PM -0800, Sharath Srinivasan wrote:
> Syzcaller UBSAN crash occurs in rds_cmsg_recv(),
> which reads inc->i_rx_lat_trace[j + 1] with index 4 (3 + 1),
> but with array size of 4 (RDS_RX_MAX_TRACES).
> Here 'j' is assigned from rs->rs_rx_trace[i] and in-turn from
> trace.rx_trace_pos[i] in rds_recv_track_latency(),
> with both arrays sized 3 (RDS_MSG_RX_DGRAM_TRACE_MAX). So fix the
> off-by-one bounds check in rds_recv_track_latency() to prevent
> a potential crash in rds_cmsg_recv().
> 
> Found by syzcaller:
> =================================================================
> UBSAN: array-index-out-of-bounds in net/rds/recv.c:585:39
> index 4 is out of range for type 'u64 [4]'
> CPU: 1 PID: 8058 Comm: syz-executor228 Not tainted 6.6.0-gd2f51b3516da #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0xd5/0x130 lib/ubsan.c:348
>  rds_cmsg_recv+0x60d/0x700 net/rds/recv.c:585
>  rds_recvmsg+0x3fb/0x1610 net/rds/recv.c:716
>  sock_recvmsg_nosec net/socket.c:1044 [inline]
>  sock_recvmsg+0xe2/0x160 net/socket.c:1066
>  __sys_recvfrom+0x1b6/0x2f0 net/socket.c:2246
>  __do_sys_recvfrom net/socket.c:2264 [inline]
>  __se_sys_recvfrom net/socket.c:2260 [inline]
>  __x64_sys_recvfrom+0xe0/0x1b0 net/socket.c:2260
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ==================================================================
> 
> Fixes: 3289025aedc0 ("RDS: add receive message trace used by application")
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Closes: https://lore.kernel.org/linux-rdma/CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com/
> Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>

Thanks,

looking over the code in question I agree with your analysis, that the
problem was introduced in the cited commit, and that this is an appropriate
fix.

Reviewed-by: Simon Horman <horms@kernel.org>


