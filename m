Return-Path: <linux-rdma+bounces-3683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C7B929705
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 10:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC3281E15
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9CB653;
	Sun,  7 Jul 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvW3cZzB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D5C8F3
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339342; cv=none; b=Kvuc+8N6SU+9Rjy5Ab6If8WLrXCWWIHVbbB9kAeuAiU96N6quI39GFM9Mpft5BJjr8jsdh2Lnw/Cmmbgd8HPrLUXS8SWGIu8yMN6LsM2vnxrGdK3AWX/zqj2GojAer6Vv8qC0JYxuD/+1p5J/LT+12UEZ5KOd9TB9p0bGv/Hcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339342; c=relaxed/simple;
	bh=rMtmijfuu8T4evy96wfecjdoiE9xw4qEDhWK++3lmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9cUj/qQfRHBFmBbdrsHvHJ2bvbqcY/B0NbANIB5lIGjFPmqS/j69jGjXUjdb8m1LyOp6RwGXyl9o9ILA2mjtneSLC09Xswdit+4NT6KHXugidsN/9sBGy55qd/PAmIO8Nxu8Jge1NtJYUXnkKxgw2hYEXas57B/aUabbqMlb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvW3cZzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BCC3277B;
	Sun,  7 Jul 2024 08:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720339342;
	bh=rMtmijfuu8T4evy96wfecjdoiE9xw4qEDhWK++3lmHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvW3cZzBA3F3azCsjSUINfbcTl+0yRGovo61uwee6gYp91jXIocKJ9b7Tc6skGrMx
	 jMh0yQRLYMPsFw/KGeti067dUM4AqkMkwEIHnJg0QSY4r9XDSTbCNyG53lN07gRv41
	 R0V04CMhrGqFhOSNB7RBDpcg9HirpKswNjJeYJvvsNxmg6/AkVwHv8LAw96JJt3dJv
	 SstuS9pKGqFRN9Yl92DwX7xhzlpugOhzIfCLeB/G/A7N/WnaXldT6aagziVFgN/Xax
	 Jzf1nRRIxKnEkH/6MNX7PiZMlf7UEJg4sbl78dez3KsbGc12NZFFPFIvKdJf2NuL1L
	 Iz1V1edtqpaag==
Date: Sun, 7 Jul 2024 11:02:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mark Zhang <markzhang@nvidia.com>
Cc: dsahern@gmail.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC RESEND iproute2-next 1/2] rdma: update uapi header
Message-ID: <20240707080217.GC6695@unreal>
References: <20240704062901.1906597-1-markzhang@nvidia.com>
 <20240704062901.1906597-2-markzhang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704062901.1906597-2-markzhang@nvidia.com>

On Thu, Jul 04, 2024 at 09:29:00AM +0300, Mark Zhang wrote:
> Update rdma_netlink.h file upto kernel commit 294424839b5e
> ("RDMA/nldev: Add support to dump device type and parent device if exists")
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org>

