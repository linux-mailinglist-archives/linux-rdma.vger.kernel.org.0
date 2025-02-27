Return-Path: <linux-rdma+bounces-8192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F618A48B93
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF637A4880
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EB2777F0;
	Thu, 27 Feb 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4vVxHb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111232777E4;
	Thu, 27 Feb 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695342; cv=none; b=TQloeigq8FJEoAJAU89P6lrmK8LcLpI9D93wUiDbdHlwjlKVE0Pqv2XkydNnA7QUn009tcP1LeoFX/YbS76e3cWXSAdXRVn32GsbpNoQqwKOCtU+dTOq6Ckdl+PDN06dOqwXPzFn3r6EsaBlWU06f3f4Bg1fmV2/V3JG4N/0oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695342; c=relaxed/simple;
	bh=JaD+FnEpy+s6FEH08xKKgBCiLA6od6W80/3yvoQsld4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiPLotQMqAueLaLM9yVhjg4QtRZRytt+Q29NnAY94N2npDy6gZCPsdi+eBaD9lw/2ibR8AeWLlCD1sY/4Ve6jhr/TOq+YJdeTHKQq2Ut4iRW2x6z8x0eZsVPGKZQLpV7ftWInXSve1eGzgDni2v15aM9tpk2xOMXtZHKNDnrlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4vVxHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7076DC4CEDD;
	Thu, 27 Feb 2025 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695341;
	bh=JaD+FnEpy+s6FEH08xKKgBCiLA6od6W80/3yvoQsld4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tc4vVxHb6aqjkPkupuQqEH/Ks1+On4j8FWplK6sxLp9PICCcDfleAu9+PjycYXqEZ
	 lp6UUWxdSdd74OPq6etsz2nsufcWA87wYhMkJ7rFcJdNtUGfJzhXLWEs4y/dywvbmG
	 KhxxyLcRc7hd1aYN42GZPrwbXf8uRr1P+SLl4OSfX6v8bbQRl7rzQsI7MWZAdoXtdw
	 I7SQNEmdqTzKJuQJQI5FpO6JJ79pS7lt5YPRhjajYKxMgN/FW/A75Q522Jr64KmkEq
	 g3GbOnOzEVsuw1VnBgdEKtox1DGCNBLvOprB88rafoXmMefyoGkFX3eJqnN4kFRtxn
	 /80crPvggY2Zw==
Date: Thu, 27 Feb 2025 14:29:00 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z8DnLGnhV3WxpHyW@x130>
References: <Z76HzPW1dFTLOSSy@kspp>
 <Z79iP0glNCZOznu4@x130>
 <69815658-68cd-46cf-bca1-81119bbdb49a@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69815658-68cd-46cf-bca1-81119bbdb49a@embeddedor.com>

On 27 Feb 12:06, Gustavo A. R. Silva wrote:
>
>>>
>>>-struct mlx5e_umr_wqe {
>>>+struct mlx5e_umr_wqe_hdr {
>>>    struct mlx5_wqe_ctrl_seg       ctrl;
>>>    struct mlx5_wqe_umr_ctrl_seg   uctrl;
>>>    struct mlx5_mkey_seg           mkc;
>>>+};
>>>+
>>>+struct mlx5e_umr_wqe {
>>>+    struct mlx5e_umr_wqe_hdr hdr;
>>
>>You missed or ignored my comment on v0, anyway:
>>
>>Can we have struct mlx5e_umr_wq_hdr defined anonymously within
>>mlx5e_umr_wqe? Let's avoid namespace pollution.
>
>I thought your comment was directed to Jabuk.
>
>I don't see how to avoid that and at the same time changing
>the type of the conflicting object and fix the warnings:
>
>-			struct mlx5e_umr_wqe   umr_wqe;
>+			struct mlx5e_umr_wqe_hdr umr_wqe;
>
>My first patch avoids the need to introduce a bunch of `hdr.`
>changes. However, `hdr` is introduced as an identifier for
>the members grouped in the new type `struct mlx5e_umr_wqe_hdr`.
>
>Of course struct_group_tagged() also creates an anonymous struct,
>which is why we can avoid all those `hdr.` changes in v1.
>

I missed the fact that it was used part of another struct that needed only
the header.

This patch is alright, no need to change anything.

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>

>--
>Gustavo

