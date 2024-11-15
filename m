Return-Path: <linux-rdma+bounces-6005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618069CF550
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262332829B2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F32C1E2018;
	Fri, 15 Nov 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3HZ0eRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259F1E1C11;
	Fri, 15 Nov 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700479; cv=none; b=ug392/2R1LmpmsB0eJPlY5MFieDOa9r4k3bMy4zBx76k3sIQG10qx2chNHtPi8lz3o++jxyXrsY2borB+YAudVCbtBmMRH1bSDgDwy2iZbHGNwwESZcjh5iHjB19/mv8AHe1/Yuz+nc8uzg8JeXDdomF4ZFVfqgkDnx+anZXEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700479; c=relaxed/simple;
	bh=WrHr6v2E2Efu0rDsPHTri+2VR8nw8MQ3tADUm0HMpUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXMTz5yya5sPNFm6RN0oyuIPubDTaKsX7S4QGocLS/DcfDmhAa5PhBf6FPMjuoPNRwPE38csQxy4TsDUsTU2qV08LIeMdMIRpjfuiFcypFZ+o47GPzVYXuMAFh6VYBoV0y9PNKJHH8H3T9XPhtenxn/XxOGV4ro51G1nIo8SBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3HZ0eRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F88C4CED5;
	Fri, 15 Nov 2024 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731700479;
	bh=WrHr6v2E2Efu0rDsPHTri+2VR8nw8MQ3tADUm0HMpUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3HZ0eRjYeSnD8C5E/PjquQcgECqW9HBWdadrx26Y40DhwNf+f9RfIzfmQGXaApiU
	 zDQUW16mnFHiM2nZxT9t+3M5zOWlBkofs50wMLqR/9CPmQ+/qypyCeqowUWh2u/vrO
	 rlEFc2rw68ql4VNzvdQ55Ctvi422hdVV4vY6Nhky34tE1ufRwMtIx90mIoTBlfO1va
	 JDMPnHqFSA4eF1MMQac7HXqOLSqp/hOnYK47vaAn+lqCy3epoMJ43xsAXcIuHkj6MQ
	 vfuIfuj2HZcXONxwDVEfqp89YyX4XcL3gMj1aAX1Ejyv58QNAWhiTAURh5+wyvzPcq
	 8KoGjforHZS8g==
Date: Fri, 15 Nov 2024 11:54:38 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>,
	ttoukan.linux@gmail.com, gal@nvidia.com, tariqt@nvidia.com,
	leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <Zzem_raXbyAuSyZO@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
 <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
 <20241114203256.3f0f2de2@kernel.org>
 <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
 <Zzb_7hXRPgYMACb9@x130>
 <20241115112443.197c6c4e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241115112443.197c6c4e@kernel.org>

On 15 Nov 11:24, Jakub Kicinski wrote:
>On Fri, 15 Nov 2024 00:01:50 -0800 Saeed Mahameed wrote:
>> not rx_missed_errors please, it is exclusive for software lack of buffers.
>>
>> Please have a look at thtool_eth_XXX_stats IEEE ethnl_stats, if you need to
>> extend, this is the place.
>>
>> RFC2863[1] defines this type of discards as ifInDiscards. So let's add
>> it to ehttool std stats. mlx5 reports most of them already to driver custom
>> ethtool -S
>
>We can, but honestly I'd just make sure they are counted in rx_dropped

rx_dropped: Number of packets received but not processed,
  *   e.g. due to lack of resources or unsupported protocol.
  *   For hardware interfaces this counter may include packets discarded
  *   due to L2 address filtering but should not include packets dropped
                                  ^^^^^^^^^^^^^^
  *   by the device due to buffer exhaustion which are counted separately in
                           ^^^^^^^^^^^^^^^^^
  *   @rx_missed_errors (since procfs folds those two counters together).
      ^^^^^^^^^^^^^^^^^

I think we should use rx_fifo_errors for this and update documentation:

rx_missed_errors --> host buffers
rx_fifo_errors   --> device buffers
rx_dropped       --> unsupported portocols, filter drops, link down, etc..

rx_dropped doesn't reflect a performance issue, but a configuration mishap
"lack of resources" should be removed from the doc or improved
since I believe it meant "allocation failure of resources" such as skbs,
which is the common use case.

>and leave the detailed breakdown in ethtool -S. The value of the common
>stats kicks in when we have multiple NICs with reasonably similar
>interpretations. Hopefully for missed we do have that interpretation.
>Anything further down in the pipeline will be device specific.
>Or at least I haven't figured out sufficient commonalities among
>the devices I deal with in production..
>

