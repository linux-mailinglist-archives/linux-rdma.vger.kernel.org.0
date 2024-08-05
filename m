Return-Path: <linux-rdma+bounces-4207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2C94826E
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 21:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC930B224C3
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2024 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D716BE22;
	Mon,  5 Aug 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+TBG7AP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71616B3B8;
	Mon,  5 Aug 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886789; cv=none; b=ixVz69H6hjdcRJX2TxEOEmLyBFfqlfsizcg68/Bc2rOxK1ZvJSTbYCjVqoALVB5ygvHelnyS+lXnCOvI/dVXzYmXJi5P5YGhZb4BlBaC5gbXKO9MqYKElcZDzGC9tQlM81cuGbWZQxrcSX4Cg6OJRU/d+N+/52HHNB6IM7GJFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886789; c=relaxed/simple;
	bh=5gi+2Mvn0ix7ok44OzuyN0ail4x5h1C+o3N8wqrERvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjGlOHYiuSkHln/Bzw8eIZKxBVeSPZhgzXfuAunNrT/vH6vfGpt2CIA1LCBf+ghXQ+GFH4d6wb5mNYvtjoyUMUQpwKRDp3kUuQUs2/kIeEUmgsMWL9emn8sM3T0LwSZJOOCa7CQI7tbmnmqN9pJdbglqrgpTQhdJJsPI95XFbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+TBG7AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B089C32782;
	Mon,  5 Aug 2024 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886788;
	bh=5gi+2Mvn0ix7ok44OzuyN0ail4x5h1C+o3N8wqrERvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y+TBG7APWQjKmrmb4BLRjw5D1qEjcKGa4IH1w+r0MEW+DYX6ucK7SEK/vmAfgSchv
	 pC0EtvWpLTV9M3Fcd5Bpkgdc3o98SxD2dX3bDounXMRbIbGm40KzD54ZvYpStYBGFO
	 gqenEVbS3KTdFt3jrG+1YD7OyNatuCr2qOa7UY+84efjy1H4+N7eeuZ1SXPvT3KMrz
	 THa+4tM8EEVRri03AONTq/8iQpysDJ5qDGI/HVpl3m/yhQvn7BQudhgCaFcrV1I2by
	 5pc83Do9uwIj8V+HbG+2HPtZEtwZbmdfvVHFD0x0JxWpUBWvF/ZkaPXGXJdBERM3jW
	 sPGwZroiBxTpQ==
Date: Mon, 5 Aug 2024 12:39:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com,
 mlindner@marvell.com, stephen@networkplumber.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 borisp@nvidia.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, louis.peens@corigine.com,
 richardcochran@gmail.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
 linux-net-drivers@amd.com, netdev@vger.kernel.org, Sunil Goutham
 <sgoutham@marvell.com>
Subject: Re: [net-next v3 05/15] net: cavium/liquidio: Convert tasklet API
 to new bottom half workqueue mechanism
Message-ID: <20240805123946.015b383f@kernel.org>
In-Reply-To: <CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
	<20240731190829.50da925d@kernel.org>
	<CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
	<20240801175756.71753263@kernel.org>
	<CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 10:23:41 -0700 Allen wrote:
> Sure, please review the explanation below and let me
> know if it is clear enough:
> 
> tasklet_enable() is used to enable a tasklet, which defers
> work to be executed in an interrupt context. It relies on the
> tasklet mechanism for deferred execution.
> 
> enable_and_queue_work() combines enabling the work with
> scheduling it on a workqueue. This approach not only enables
> the work but also schedules it for execution by the workqueue
> system, which is more flexible and suitable for tasks needing
> process context rather than interrupt context.
> 
> enable_and_queue_work() internally calls enable_work() to enable
> the work item and then uses queue_work() to add it to the workqueue.
> This ensures that the work item is both enabled and explicitly
> scheduled for execution within the workqueue system's context.
> 
> As mentioned, "unconditionally scheduling the work item after
> enable_work() returns true should work for most users." This
> ensures that the work is consistently scheduled for execution,
> aligning with the typical workqueue usage pattern. Most users
> expect that enabling a work item implies it will be scheduled for
> execution without additional conditional logic.

This looks good for the explanation of the APIs, but you need to 
add another paragraph explaining why the conversion is correct
for the given user. Basically whether the callback is safe to 
be called even if there's no work. 

