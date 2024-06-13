Return-Path: <linux-rdma+bounces-3088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DE906041
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AF51C2124C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 01:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34739168CC;
	Thu, 13 Jun 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkjYSL7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B9D8BEC;
	Thu, 13 Jun 2024 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240661; cv=none; b=CWgXmpgSf3+olKsFm/juT4Z8Sfe6YHSdCOWnm47yf34tUWKmx5Kxlm9rH3Tq0Lv8p0Nsf3CZ55C4rEU39BLUcmgPkh5IfR4YFoJOV0zpVg9M4eBqJVFvp8v2UonRBq4FxCUeD6ssfIsHkD82nxUum+duJF1rCkZOMhpltIAn0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240661; c=relaxed/simple;
	bh=mUqdzlE2YgruqKLE1C3H5e4Ue5/0C4g77p2kLBoVhBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS7BC7Kk99nc7G29RIPeEP9J/9hw8zXGTBF5W60w8orkMeKAKJHxdY6WwB8277nZ8ycYByehnSvwTbpXKyl98lvA/SArBO0GfRN6elGKrX9qVVLQzuYBAPPTIpdX/YcbUtLGPuZMHtvFgj1/HYw4vQK698wsS8kO+/S1sB8rA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkjYSL7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF86DC116B1;
	Thu, 13 Jun 2024 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240660;
	bh=mUqdzlE2YgruqKLE1C3H5e4Ue5/0C4g77p2kLBoVhBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hkjYSL7aymQsKlAzq6Yed36s96sUhKIrGVugQoUZuBakuqy5MAFwMb9wDNXMy/8dk
	 ACR/+jWtdDJu4jjEWklpD+2sovBrpkY5/eODSIi6kfyWz1nli+JOxE6wnCctmEFWeO
	 P7AxEm7W6DW2X0F/fKIMb42o3P8ng7mledOqjOSE9uAdgtmBhgDnZQ/mVfkXuAGfVZ
	 o3ufs+N3LwP7cUHVV4ENoAMn2SUtlp8fj0337DU8SoDxfUaBEq5y0Svneg2g95ypda
	 4H7PQ/LRp3qqwbI/9f+7YKLgSJnCF65JdchVhtlas32NqbtfdnUW3dNtHpbEWdCkWV
	 lT7lmYIFOYLig==
Date: Wed, 12 Jun 2024 18:04:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 linux-net-drivers@amd.com, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 linux-rdma@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Louis Peens <louis.peens@corigine.com>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
 i.maximets@ovn.org
Subject: Re: [PATCH net-next 0/5] net: flower: validate encapsulation
 control flags
Message-ID: <20240612180419.391f584d@kernel.org>
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>
References: <20240609173358.193178-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  9 Jun 2024 17:33:50 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Now that all drivers properly rejects unsupported flower control flags
> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.

Thanks for doing this work!
Do you have any more of such series left? Could we perhaps consider
recording the driver support somewhere in struct net_device and do=20
the rejecting in the core? That's much easier to extend when adding
new flags than updating all the drivers.
This series I think may not be a great first candidate as IIUC all
drivers would reject so the flag would be half-dead...

