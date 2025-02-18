Return-Path: <linux-rdma+bounces-7814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823ADA3AA13
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 21:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C6F188A2B3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBBE1DDC34;
	Tue, 18 Feb 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcCAXXON"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3E1A3178;
	Tue, 18 Feb 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911204; cv=none; b=Unu7n+0Ku1BjcLa5UEzCKAue2IkK+mBntbBoefMrNAbafS1mlH79mK9BrqB5DbrGmibOTpH04AXRZY+ImfYGWc7t3b5zLcLdi33pofwYs3yUeClUbrMT3vTSIusVes6yoj5LmH9zp4UmyOUGGFXX9uFHXIne+2VYxSqkClM3QDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911204; c=relaxed/simple;
	bh=7rWpVGk9+3bdZU5vcmZmy7BQEclObTPaZOX1MwmNQfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnkxA5LReyUDLiSUzG8PGUS+RPk2dnHW5uD/YoM8wkzRhFwnPqc7Ml5NeA/1/ojVwuWGaF+qkkYAg3C9Si5Tje3l6WToaNjYO0ryg2Fnc0rQ8VZNiwDDjorOCCc5u8ule3uhWpVX4B3AXohgHQX4LDxgGclV+16yulyqRD6FN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcCAXXON; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0462df14-0aaa-4861-a0a4-dade4cfa727e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739911190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpY7Wp9A5OrP01XjYb8sMlnmyc1nWglgkRg0g+3xUdg=;
	b=tcCAXXONjDT/OngPf2x8vKJiHrWMIUrrugxnILHDOpCXRYu3MBoazO82ZM7VSPkuczGLWw
	1KZasNRLocM8fP8QV99JR7+aRscLdZIenUpkrd9/lva1TkO4U0TnNW6Tw38WI5yUEZArgS
	ayvN642CY1KMmwMmNZSdemceCsQGgaY=
Date: Tue, 18 Feb 2025 21:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next 3/5] xfrm: rely on XFRM offload
To: Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Louis Peens <louis.peens@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Ilia Lin <ilia.lin@kernel.org>
References: <cover.1738778580.git.leon@kernel.org>
 <3de0445fa7bf53af388bb8d05faf60e3deb81dc2.1738778580.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <3de0445fa7bf53af388bb8d05faf60e3deb81dc2.1738778580.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/5 19:20, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After change of initialization of x->type_offload pointer to be valid
> only for offloaded SAs. There is no need to rely both on x->type_offload
                                                   ^^^^^^^^
                                                rely on both ??
Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> and x->xso.type to determine if SA is offloaded or not.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

