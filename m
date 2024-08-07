Return-Path: <linux-rdma+bounces-4235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607394AA6E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031E5281CDE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FA823DF;
	Wed,  7 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRy8qbY8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478B7D3FB;
	Wed,  7 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041475; cv=none; b=E6+WDku9DGYSbpcMcNFSQ35BEHd5IwmBoN/NPHn7fNyhsUr7M3CWN5ovyqLftLcDRcsr2QWREVbCjGJk3aXGcit160svL/2MB1rfWINgRLuBhurBsHA8kTrLDTOJam3bEkQ2sFmz/H1NYCONK8cBFDvIFv5wob4lJjVwtJE0398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041475; c=relaxed/simple;
	bh=TNbm7duLFewBmORokJ3DmoAXPMUZyENSQJQ/UUWmImI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zyig+JjAjGDmaLzUVcqcsV92nzTmAovyIDQLrKH/pCOXNuwz7Sm0LeQW+/SQZ9mTHJsVKBxyzESPkTasotqFPbKxGSCQYQZth35Sn41ITEDE6XXtd0Ut2mLGiyoQ96lWQcel6HrSo2dVAdhIg7nXf1NnZVev83pxJQEtdk5r/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRy8qbY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CDBC4AF0D;
	Wed,  7 Aug 2024 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041475;
	bh=TNbm7duLFewBmORokJ3DmoAXPMUZyENSQJQ/UUWmImI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRy8qbY8QL9gw+Rxi1NPDkmyHkk+JP1lYri2ncdxnynbyjilz3fPfhbkfNzSEe/K9
	 u+K9fFWalBP5fJ+5ONK+osCrnw0XE292xBiX46vI9y3dD3zsu5vSaeRqkf2OJrjx8+
	 JqRX5Zbt7P7gL3gIosjCw9R+ZWtek068hGORdcIpAjJwMLseZRbAVTx1fTLR0Kdv/X
	 7DMnjNQr16q7znbb6dbxdd90tSxFbh6gj6UVeCfaZpyYc5SzOcHoxhBku6bjpldD1k
	 eAJF7JZ6kKq7Mn4B1P2wGOV3Hc2WO/8YbZ/LLYz2tl/VGlbErgvjEo5pYnIgGmK0iI
	 EyUXeggJoVZWQ==
Date: Wed, 7 Aug 2024 07:37:52 -0700
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
Message-ID: <20240807073752.01bce1d2@kernel.org>
In-Reply-To: <CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
	<20240731190829.50da925d@kernel.org>
	<CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
	<20240801175756.71753263@kernel.org>
	<CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
	<20240805123946.015b383f@kernel.org>
	<CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 20:15:50 -0700 Allen wrote:
> In the context of of the driver, the conversion from tasklet_enable()
> to enable_and_queue_work() is correct because the callback function
> associated with the work item is designed to be safe even if there
> is no immediate work to process. The callback function can handle
> being invoked in such situations without causing errors or undesirable
> behavior. This makes the workqueue approach a suitable and safe
> replacement for the current tasklet mechanism, as it provides the
> necessary flexibility and ensures that the work item is properly
> scheduled and executed.

Fewer words, clearer indication that you read the code would be better
for the reviewer. Like actually call out what in the code makes it safe.

Just to be clear -- conversions to enable_and_queue_work() will require
manual inspection in every case.

