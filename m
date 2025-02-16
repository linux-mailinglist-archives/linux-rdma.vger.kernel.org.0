Return-Path: <linux-rdma+bounces-7781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE8A37423
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D0F1890B2D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240918E351;
	Sun, 16 Feb 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rbTLqm4M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3D18C91F
	for <linux-rdma@vger.kernel.org>; Sun, 16 Feb 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709388; cv=none; b=AFXBN0qJSjX37xbCK3bITt5XY+k1I+iUpMxgJ2A5qot4e8HDNLUcsK21702I1EjnShmy6bfA6aNuz99YpDADJbK8l3lSiv6+Jc47mC5GhWl/uv4kT5I6FDG36ywBOU0Yn8HUri1UNDisHbx58rvsv4Rs3gxiakJUMpzt4EJjbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709388; c=relaxed/simple;
	bh=WatZkQw62zNtUEV0V7EKrjwS1ywhQacJKS3qD8BFQrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUwg+IFCxkWa9eUba+ck0lKOKiKKr6CB/Lrlew7B6g5UJe1X6nDxT+qFvNnsBLidL+vA4wahCntBl25lEj3+r846hFC5cWgI3xN1ZZo1vyvv09z3VpyDvMg5Im0aiTEwvjfC8+WltJD5LBbtbHaCXOKshWntzbrmDiXtbUTJ3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rbTLqm4M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6775786f-ee86-4990-8db8-ea95d4313973@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739709383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDBfuwN7zF5bfcepsK7mvv2IbRXE9jZFhB763pxzsqs=;
	b=rbTLqm4MS/vUuGgVmIojj0rfqc5jA5Fz/SJAClsGV+8TPL+SqVsz+x5wr5PDlcP2JVzM4Q
	wMVVwSo+vYPPiqKQRDUhjJWKruqaNxTZl4p7WlIDelGyWNxg9NBpbdw41Ub3a85ElyeWOS
	eYpA3rry46FvVQ+DG3bo3huLFkWgR6c=
Date: Sun, 16 Feb 2025 13:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next 4/5] xfrm: provide common xdo_dev_offload_ok
 callback implementation
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>,
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
 <d2aa8f840b0c81e33239e2a4b126730ae40864f1.1738778580.git.leon@kernel.org>
 <647895d9-e8d1-4921-b5ba-b38b2176604e@linux.dev>
 <20250216110711.GU17863@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250216110711.GU17863@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/2/16 12:07, Leon Romanovsky 写道:
> On Sun, Feb 16, 2025 at 10:33:59AM +0100, Zhu Yanjun wrote:
>> 在 2025/2/5 19:20, Leon Romanovsky 写道:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Almost all drivers except bond and nsim had same check if device
>>> can perform XFRM offload on that specific packet. The check was that
>>> packet doesn't have IPv4 options and IPv6 extensions.
>>>
>>> In NIC drivers, the IPv4 HELEN comparison was slightly different, but
>>> the intent was to check for the same conditions. So let's chose more
>>> strict variant as a common base.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>>    Documentation/networking/xfrm_device.rst      |  3 ++-
>>>    drivers/net/bonding/bond_main.c               | 16 +++++---------
>>>    .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 -------------------
>>>    .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 --------------
>>>    .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 -------------------
>>>    drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 -------------------
>>>    .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 -------------
>>>    .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 --------------
>>>    .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 ----------
>>>    drivers/net/netdevsim/ipsec.c                 | 11 ----------
>>>    drivers/net/netdevsim/netdevsim.h             |  1 -
>>>    net/xfrm/xfrm_device.c                        | 15 +++++++++++++
>>>    12 files changed, 22 insertions(+), 145 deletions(-)
>>>
>>> diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
>>> index 66f6e9a9b59a..39bb98939d1f 100644
>>> --- a/Documentation/networking/xfrm_device.rst
>>> +++ b/Documentation/networking/xfrm_device.rst
>>> @@ -126,7 +126,8 @@ been setup for offload, it first calls into xdo_dev_offload_ok() with
>>>    the skb and the intended offload state to ask the driver if the offload
>>>    will serviceable.  This can check the packet information to be sure the
>>>    offload can be supported (e.g. IPv4 or IPv6, no IPv4 options, etc) and
>>> -return true of false to signify its support.
>>> +return true of false to signify its support. In case driver doesn't implement
>> In this commit, remove the functions cxgb4_ipsec_offload_ok,
>> ch_ipsec_offload_ok, ixgbe_ipsec_offload_ok, ixgbevf_ipsec_offload_ok,
>> cn10k_ipsec_offload_ok, mlx5e_ipsec_offload_ok, nfp_net_ipsec_offload_ok and
>> nsim_ipsec_offload_ok, use the function xfrm_dev_offload_ok to do the same
>> work.
>>
>> But in the file xfrm_device.rst, "return true or false to signify its
>> support"?
> This sentence continued in the xfrm_device.rst: "...  In case driver doesn't implement
> this callback, the stack provides reasonable defaults."

Got it.

I mean "... and return true of false to signify its support..."

                                           ^^

should be "... and return true or false to signify its support..."

^_^

Zhu Yanjun

>
>> of --> should be "or"
>>
>> Thanks a lot.
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Thanks
>
>> Zhu Yanjun
>>
>>> +this callback, the stack provides reasonable defaults.
>>>    Crypto offload mode:
>>>    When ready to send, the driver needs to inspect the Tx packet for the
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index e45bba240cbc..bfb55c23380b 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -676,22 +676,16 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>>>    static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)

-- 
Best Regards,
Yanjun.Zhu


