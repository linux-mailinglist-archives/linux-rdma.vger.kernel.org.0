Return-Path: <linux-rdma+bounces-4177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BF9455CF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB6E1C225FD
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E188F70;
	Fri,  2 Aug 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBg2oTFn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640817758;
	Fri,  2 Aug 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560279; cv=none; b=sN6nhWSWRQginXUmVUALkRC5JFsmsRkKROam8wXWeOTMZlByjLcW0HKiWTF1rDJWkjVzVeW6ER/OW3Lbm6kSPWLWoy6lrdQatU4NSvz8y7n9jr4eYTKGHW8mewy3KCxxHX1Pqqgw4dhR5AFMmgj6kpdhyhLWYRliDypkFH8UEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560279; c=relaxed/simple;
	bh=MTaSJyGBiIzdMGc84TjF9+v49GKSVnCpV8/HKiLEJVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udwZXn3UnSYayeq438g/3vpVBxS/1gOOorLIi5UGJPFyPxavDbw2xhKygNT3Z9KQdLiLokfAn9bqktcRQUl0o8dtxYnbdZm3EbeS1iPk4qEOSIsPhcleCtncq30lUQzalbw1UoJZR5mISmxnPIc9mtF8U4GXEbS3qoQNW+UbRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBg2oTFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE2C32786;
	Fri,  2 Aug 2024 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722560278;
	bh=MTaSJyGBiIzdMGc84TjF9+v49GKSVnCpV8/HKiLEJVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBg2oTFnzq35PaCY+KM6z8eegHyrndOsaaeFoP7q+ZTnzWPRcfkCT5397TvNCPveY
	 V3onjqNZn3QeYsho+3D77AbHeyqKdDTZCvPuC0Uw43Tsw1NI28LAF5jLVdaQgLXOMz
	 pRnIXP2QmirdYXOSA1FR1XHDHzxN/6MHEsZVYQArfbMxgFLV1sryyHnVBkWgCyrKtW
	 iPtMyU4W5tztq4HUipwxm+5zk1yeMnERVMfac9eJdXAAOhEYl5gnPwQt1f3SeKLFMD
	 M6W1MO+FkTW3TACWGqenMNSMDUlwXLg6/mnksYMUYL7W6jpML3fA18Oc5SQe+/UKIi
	 2V9xzc9Jr0XpQ==
Date: Thu, 1 Aug 2024 17:57:56 -0700
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
Message-ID: <20240801175756.71753263@kernel.org>
In-Reply-To: <CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
	<20240731190829.50da925d@kernel.org>
	<CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 15:00:23 -0700 Allen wrote:
> > Could you shed some light in the cover letter or this patch why
> > tasklet_enable() is converted to enable_and_queue_work() at
> > the face of it those two do not appear to do the same thing?  
> 
> With the transition to workqueues, the implementation on the workqueue side is:
> 
> tasklet_enable() -> enable_work() + queue_work()
> 
> Ref: https://lore.kernel.org/all/20240227172852.2386358-7-tj@kernel.org/
> 
> enable_and_queue_work() is a helper which combines the two calls.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=474a549ff4c989427a14fdab851e562c8a63fe24
> 
> Hope this answers your question.

To an extent. tj says "unconditionally scheduling the work item after
enable_work() returns %true should work for most users." 
You need to include the explanation of the conversion not being 1:1 
in the commit message, and provide some analysis why it's fine for this
user.

