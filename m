Return-Path: <linux-rdma+bounces-6006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC10A9CF81E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3A2822AE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999A1E47D7;
	Fri, 15 Nov 2024 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O46Dc1/i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A591E47B3;
	Fri, 15 Nov 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705921; cv=none; b=h1bJuE42rIc6xGv7eqtXGRdK70/9+BknkpckNJ8cIFKWJ3zi5lvBKYM1KOdJNDb2HX9+n1qOtEzIJQ8tW1NVPLiOmCqN9P8Jkcj8ilFADy0HNLjGX4LBLGIupB+0Xx187vHPrdFjO1aSxUqW2DK7Ew9HsIYqtnJhoBOdtbie56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705921; c=relaxed/simple;
	bh=1ENIdbEyc6VbJ9Kjv+rnJnmPC14F7VyBXrXvMKEIrZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNqZYGF+4xfRJZYXBbHJ4TnzDvPpHY7/QBmdLhCkjmt29eENr0cZcbrHzqeGhX3PHEi3B/0NY0MxWFsEdonJJFV9lHvWIlBrXZcHiES+Zp9PsdKSdSfzuTsb4n2o5oKqhBaEO1NsPs43Swq6N9MJQp27uEZivEfv3+L18LUgJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O46Dc1/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0D3C4CECF;
	Fri, 15 Nov 2024 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731705920;
	bh=1ENIdbEyc6VbJ9Kjv+rnJnmPC14F7VyBXrXvMKEIrZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O46Dc1/iJftzsF2xDRAWrdNcj/Pf0xU6yDdwTbSY+6BOfMr5FFX9WjKBWkIkYMizi
	 azs5+yII1H82uv98sN1GsLixs4H83PAmjboEp3YCLdQ47uxeBbi1OJGHh84rqc0tD7
	 VjVSFL6vQ6TDGEKG0Y/YP79et+Ilne6SDkQyLg47CuuDCkZPH6EheUsq9YFCxL5RJm
	 ZS+H5BccpBw8NUXVQmuQWxUTPUqbQhsW8Vd0WWggrh6+TuM/S25m6KdxPd/YRZn62M
	 m0AeBm8He6Gf5XbzaqHdH3Lu4PtU1Sx//6togjlFYfCZkPsGeSdHV6YMJqV9sYetIt
	 WDfQbxpiznRGA==
Date: Fri, 15 Nov 2024 13:25:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>,
 ttoukan.linux@gmail.com, gal@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241115132519.03f7396c@kernel.org>
In-Reply-To: <Zzem_raXbyAuSyZO@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
	<20241114182750.0678f9ed@kernel.org>
	<CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
	<20241114203256.3f0f2de2@kernel.org>
	<CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
	<Zzb_7hXRPgYMACb9@x130>
	<20241115112443.197c6c4e@kernel.org>
	<Zzem_raXbyAuSyZO@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:54:38 -0800 Saeed Mahameed wrote:
> >We can, but honestly I'd just make sure they are counted in rx_dropped  
> 
> rx_dropped: Number of packets received but not processed,
>   *   e.g. due to lack of resources or unsupported protocol.
>   *   For hardware interfaces this counter may include packets discarded
>   *   due to L2 address filtering but should not include packets dropped
>                                   ^^^^^^^^^^^^^^
>   *   by the device due to buffer exhaustion which are counted separately in
>                            ^^^^^^^^^^^^^^^^^
>   *   @rx_missed_errors (since procfs folds those two counters together).
>       ^^^^^^^^^^^^^^^^^

I presume you quote this comment to indicate the rx_dropped should
count packets dropped due to buffer exhaustion? If yes then you don't
understand the comment. If no then I don't understand why you're
quoting it.

> I think we should use rx_fifo_errors for this and update documentation:
> 
> rx_missed_errors --> host buffers
> rx_fifo_errors   --> device buffers

In theory I'd love to use fifo errors to mean device buffer drops.
In practice devices can backpressure due to host slowness, so the
device drops are hard to categorize. The vendors themselves have
limited understanding of how their devices will behave under real
workloads. And once devices are deployed it may be too late to change
definitions.

> rx_dropped       --> unsupported portocols, filter drops, link down, etc..

