Return-Path: <linux-rdma+bounces-13986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD7BFE99F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 01:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A86114EBA42
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 23:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE7D274652;
	Wed, 22 Oct 2025 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCpA8F/e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF527462;
	Wed, 22 Oct 2025 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176475; cv=none; b=eB2YK66HCN4R7pQFzKoE35SdLvI5f7b3YpJY+dpfgVByr/ZM70vyA28E6UKFWwgb9TDI+Sc/WgfJJ4quyazqFn1oVyEbObZ+CunLvSmYuBTJZcU2jd4F5rduTmp82Nx3tfqg7ZzVSCyl0DnsFHCegRYB3Lox3eMKNGmdO2lfh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176475; c=relaxed/simple;
	bh=x6KLeRxX8JxH4jBMTLXXQTSz04FBf2X8jBD2EXyvfuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fbtsm9vc28dwqZ5ctqewfg4TcTlEybtm+KsRjqmVi+ttVifneX0DP7dYXDfB9f1Lol7TEllOuMjEpNfiqDmY+px8DGUaz4++OwHYoZx7jNkuLk/6PeNdaa+XA1bJ5wKUCMmkrrPDZcNVTOiBAdCcY3+RcYt/aPoPm+2uuTZSqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCpA8F/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47C2C4CEE7;
	Wed, 22 Oct 2025 23:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761176474;
	bh=x6KLeRxX8JxH4jBMTLXXQTSz04FBf2X8jBD2EXyvfuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCpA8F/e2qmKvCMup2IUXnfmSx/UsVGY6I3aFsLupwA8xBXeAw0WCq3aC8AffUUHV
	 1fwbfR+3Q+m6r4vcwMR5HLchUOWj07ykwwoSN+5yA2Yj21aOeg/Fx2IVUdMeM7Mfpb
	 uIw+a461ytDQ2KLV0/pHlfjGyys/NCzAfn0Xz33z5H8C5bFbEXb8N9wbmrYIvmiNrY
	 3fmohCspNdsaKCAaBF/jpelUdxpCX9+/ukrs/tydtlCg6jQ6fadkQSq3uSURT7PQ5k
	 E6xpo7zmN1wnAS6j6DXXk6ZpCznxj04mUSPGJaUNU6hSPLp1l4uyU7z0EK7fp3eKlV
	 jTfmo2rC8twdg==
Date: Wed, 22 Oct 2025 16:41:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Leon
 Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <20251022164112.40b5f5ae@kernel.org>
In-Reply-To: <20251022190932.1073898-1-daniel.zahka@gmail.com>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:09:31 -0700 Daniel Zahka wrote:
> swp_l4_csum_mode controls how L4 transmit checksums are computed when
> using Software Parser (SWP) hints for header locations.
> 
> Supported values:
>   1. device_default: use device default setting.
>   2. full_csum: calculate L4 checksum with the psuedo-header.
>   3. l4_only: calculate L4 checksum without the psuedo-header. Only
>      available when swp_l4_csum_mode_l4_only is set in
>      mlx5_ifc_nv_sw_offload_cap_bits.

make htmldoc seems to be upset about the formatting of the
Documentation. 

Documentation/networking/devlink/mlx5.rst:78: ERROR: Error parsing content block for the "list-table" directive: exactly one bullet list expected.

Not clear to me why the new entry is bad and existing one with double
bullets are okay, but we can't have errors..
-- 
pw-bot: cr

