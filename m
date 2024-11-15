Return-Path: <linux-rdma+bounces-6004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A649CF4D8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4DEB2B030
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717541D63DD;
	Fri, 15 Nov 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6+16K88"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E95136338;
	Fri, 15 Nov 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698685; cv=none; b=nKnZsjKVV8Ukf0vGK3Gwesg8lDkBG/Nt5IKdgdVWMeZFwbExhgzqD/Lt4pOiw1/yeak+88KxxnpuJla723l0Y4O+97jCRg55eps7ZJwyRi4UZdvZ/E70Wesj3S73gXe5NSdf2RvYJO+tS85DPU/GeFouoiBfNcrnZDfF0JHq7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698685; c=relaxed/simple;
	bh=apenax866phqLqv9fAsQ4RZ4o0uadofNqaDzue/6OQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeX5ll6gXy99eJZsFFsO/4wCUFTLNMB+70k7c33lqahcAe+cQS6StK7y6kBS4cQnezzkFHSqR7eRr+EcDL42VBsmLYiUi9o3h3iCKPC0x8HOckimNs+dEyeWKLCgOCzGUQQDKf+imTCkqxvedotGcA9RsyrK/UyW///KG6xJtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6+16K88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A82CC4CECF;
	Fri, 15 Nov 2024 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731698684;
	bh=apenax866phqLqv9fAsQ4RZ4o0uadofNqaDzue/6OQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d6+16K88oA79TCHj07xWAMfzNUHgu42MQfPL5aCzpVHwDuFbFeR1QirlmIigW/hB6
	 V9ZpfQ1n4aXjscrgDDAlRTw9iTqiVnRVlCD3yLCWul95R83uYY1XfLHs+Bhn/i4prh
	 +UCCfXgdxpGgVdZ6O4TQMKiUkjuAJh9Wi/9qDVhcOPQtsVtSLfISrA26v7D02Za8RF
	 r4/I1bMxxo9aDH0VApQnPH8O1Rm502wUndUPgUriH0NYj8NJb2c62JTI9F9qJPPF/Z
	 L+IaXwHdEkKOlg3OkHqKb5Mbf57PRXsziSJIcPedTY7BdJVWtnz2xX0sXUSNLr/Zsn
	 /huG/3FW6uImg==
Date: Fri, 15 Nov 2024 11:24:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, ttoukan.linux@gmail.com,
 gal@nvidia.com, tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241115112443.197c6c4e@kernel.org>
In-Reply-To: <Zzb_7hXRPgYMACb9@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
	<20241114182750.0678f9ed@kernel.org>
	<CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
	<20241114203256.3f0f2de2@kernel.org>
	<CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
	<Zzb_7hXRPgYMACb9@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 00:01:50 -0800 Saeed Mahameed wrote:
> not rx_missed_errors please, it is exclusive for software lack of buffers.
> 
> Please have a look at thtool_eth_XXX_stats IEEE ethnl_stats, if you need to
> extend, this is the place. 
> 
> RFC2863[1] defines this type of discards as ifInDiscards. So let's add
> it to ehttool std stats. mlx5 reports most of them already to driver custom
> ethtool -S 

We can, but honestly I'd just make sure they are counted in rx_dropped
and leave the detailed breakdown in ethtool -S. The value of the common
stats kicks in when we have multiple NICs with reasonably similar
interpretations. Hopefully for missed we do have that interpretation.
Anything further down in the pipeline will be device specific.
Or at least I haven't figured out sufficient commonalities among 
the devices I deal with in production..

