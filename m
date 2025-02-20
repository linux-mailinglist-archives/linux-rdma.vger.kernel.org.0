Return-Path: <linux-rdma+bounces-7872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000A0A3CEDF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 02:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4993B15A4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC51C1F02;
	Thu, 20 Feb 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObMTd2Zl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90314D29B;
	Thu, 20 Feb 2025 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015991; cv=none; b=BlkUE2B2NbLHSKZgvVRxjxxhi0GVDBgshdFqXoF76HC6pzRrRmFTmikdiCUbrEVNJN8yQuV9SqTbjo6vD9EHbmkuAsCXQbmEppDSp2rYRP67cxecfxv7JYi+tW/i652tQowNPMjBtj0t84VmXemnnRkgV3jGy47OafWecNVR8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015991; c=relaxed/simple;
	bh=lOCIKrG4fnWuEnXHjMyM7hZ4f/XNChZyeVKyouzur8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhV8SsbkseTU4I907DX4MRnQXgs9pkRaGAoeRpZyX3UqxpHZut378Tpj72phlbnCzQceFR2asFN11yoE0J6uiBzmCur0r+o4JBhQ0Xl0GGJ9xhxfzaAu1hL5wvwjr8GA47zQb5uKsnWOdH3Tmkcl8HPvYEgNrqWgiOgExTxT4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObMTd2Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF1FC4CED1;
	Thu, 20 Feb 2025 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740015990;
	bh=lOCIKrG4fnWuEnXHjMyM7hZ4f/XNChZyeVKyouzur8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObMTd2ZlVJylLtds82Kj4tPBl7X05QL/6o7/5QbYWay8BODTX+lznxpN9Kcgb6+7s
	 hsgwbKYz7r8cbVecsZpuQ/9GzIbob7O2fQPzKYixARFQvqy7sbKj4tLsorT+etfov8
	 byOnVueq/JcSIPGCn6hJmmYWi61P//ft6gReLVDo8tDaRSGIhkVTnyA7Ht2YeWFBeQ
	 bEmN2XLYG5fzGT6bkLxtWcFeQK+Bsv4xta0FuaEQ//WIiAglqSUNQRNPKMPgaxvUFL
	 ufDMBU3qQ+bP1VPEF5T5y421nDEeDDXu2alyUMBGnH0Dcszqydt5XYrliCpKLP/57d
	 RwvI7WDsJvOcw==
Date: Wed, 19 Feb 2025 17:46:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250219174629.4791c1e9@kernel.org>
In-Reply-To: <99543a40-2a57-4c10-8876-cde08cb15199@gmail.com>
References: <Z6GCJY8G9EzASrwQ@kspp>
	<4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
	<8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
	<7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
	<5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
	<36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
	<59b075bc-f6e6-42f0-bc01-c8921922299d@gmail.com>
	<20250218131345.6bd558cb@kernel.org>
	<99543a40-2a57-4c10-8876-cde08cb15199@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 14:14:35 +0200 Tariq Toukan wrote:
> On 18/02/2025 23:13, Jakub Kicinski wrote:
> > On Tue, 18 Feb 2025 17:53:14 +0200 Tariq Toukan wrote:  
> >> Maybe it wasn't clear enough.
> >> We prefer the original patch, and provided the Reviewed-by tag for it.  
> > 
> > Can you explain what do you mean by "cleaner"?
> > I like the alternative much more.  
> 
> Cleaner in the sense that it doesn't touch existing code in en_rx.c 
> (datapath), and has shorter dereferences for the inner umr_wqe fields, like:
> umr_wqe->ctrl
> vs.
> umr_wqe->hdr.ctrl

IMO that's minor, not sufficient to justify struct_group_tagged()

