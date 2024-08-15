Return-Path: <linux-rdma+bounces-4380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59749953E12
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 01:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3AAB21803
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F42D156C5F;
	Thu, 15 Aug 2024 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVXBqxRM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC4370;
	Thu, 15 Aug 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765768; cv=none; b=HaG7eciZPgg17NVTEx0PmIjNo02n059jKcvKrAnQkdEPEYsrCXBXjHKOWJTmRoMsyBlMeuuRc3jNdMiNMU26+3W0NEsn/bL6+JgjaYb60FbUOpqg8aE35pwy7WgipauwlXoPN3ret8BMT3Thya2PnhZYZnTDaEWdxWBWIuu/I3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765768; c=relaxed/simple;
	bh=fWIsV9hFatQJdiwFfYJliIME9lY/73qLiUKyBkbpiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Ze7tAmevpCUwCoYlb+66Bnhj3PFq0yOfnsJyPly10oM8lzLKru1PELWNX7cwtKG2YwK4CnXCfpYjtaAULnZk4iILltMOrr7Ska/jeAsKVnPzcKVZXrWeKDBuqfnhtgf/Sz5i9egjlTt56Evu6sV8jrf50RPXh4uf8Z7/pDJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVXBqxRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EC8C32786;
	Thu, 15 Aug 2024 23:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723765767;
	bh=fWIsV9hFatQJdiwFfYJliIME9lY/73qLiUKyBkbpiUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVXBqxRMtiFwRkpu8TfmVW7mZSxnYl2qG7JzGdw3A0P7ERAwWseFYCcNx+3NJTvfY
	 /f7xy1Plh+6MmP9qKbAQIs5OrhHGaADBS4mr6jCRDZ9EjgFiwY+uXuzWCaTwfX13Ze
	 IuFeJkE8GkEsunDkRS7xkOTInNo8//ddF4H5l0qr+U9pVZhofbDutO5k8tCtPQv0Ti
	 ug8h49NFwoM/ka8PqXz/ibpHLEmbcllmyFUXB5yJKg1QNiZ4B1/LdWIBbOTwJEUfMq
	 w9AEADUyNdR5zAiBTJoD7abhg36HBBYxYDC5O02MLDuWChehM4F9ZNobSXYOJxqvjW
	 X2qirOlapHK8A==
Date: Thu, 15 Aug 2024 16:49:24 -0700
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
Message-ID: <20240815164924.6312eb47@kernel.org>
In-Reply-To: <CAOMdWSLEWzdzSEzZqhZAMqfG7OtpLPeFGMuUVn1eYt1Pc_YhRA@mail.gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
	<20240730183403.4176544-6-allen.lkml@gmail.com>
	<20240731190829.50da925d@kernel.org>
	<CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
	<20240801175756.71753263@kernel.org>
	<CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
	<20240805123946.015b383f@kernel.org>
	<CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
	<20240807073752.01bce1d2@kernel.org>
	<CAOMdWSJF3L+bj-f5yz5BULTHR1rsCV-rr_MK0bobpKgRwuM9kA@mail.gmail.com>
	<20240809203606.69010c5b@kernel.org>
	<CAOMdWSLEWzdzSEzZqhZAMqfG7OtpLPeFGMuUVn1eYt1Pc_YhRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 09:45:43 -0700 Allen wrote:
> > Hm. Let me give you an example of what I was hoping to see for this
> > patch (in addition to your explanation of the API difference):
> >
> >  The conversion for oct_priv->droq_bh_work should be safe. While
> >  the work is per adapter, the callback (octeon_droq_bh()) walks all
> >  queues, and for each queue checks whether the oct->io_qmask.oq mask
> >  has a bit set. In case of spurious scheduling of the work - none of
> >  the bits should be set, making the callback a noop.  
> 
> Thank you. Really appreciate your patience and help.
> 
> Would you prefer a new series/or update this patch with this
> additional info and resend it.

Just thinking from the perspective of getting the conversions merged,
could you send out the drivers/net/ethernet conversions which don't
include use of enable_and_queue_work() first? Those should be quick 
to review and marge. And then separately if you could send the rest 
with updated commit messages for each case that would be splendid

