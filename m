Return-Path: <linux-rdma+bounces-11909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD56AFA37C
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 09:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75A6189A572
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jul 2025 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501219DFAB;
	Sun,  6 Jul 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qELWBM7C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503343159
	for <linux-rdma@vger.kernel.org>; Sun,  6 Jul 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751787456; cv=none; b=mhoCWIGY6JNuHpLY0UTn6dOAe99wkLA/MEdjdcK5CUtRG26asyqSWdU0U+3SYbPIkTe9BJF4KVgFincNkZoh47y1KPZXg8H0/3WXazhBCmWT1AgWFgsfv060hBPhbhvhoS2Vo28uF6Fo95s9Z5a54GKZOPq6UZvU56dl/jW+c9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751787456; c=relaxed/simple;
	bh=GtptPjErZW/0ydkdlaJujyJcdrgTujs+pGprdKSBFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyiHxZiHuBL0vWs9LcnCBDP965CK75DjTEoBIzLlvrXk+xwJAbUrubVEfydZYESuFPv+InqNIGGwP4eda//jInSuet02c1RRxIXdzyyp3u6wpYyNEzNk3X1tlP8Wz9YcybsTtPBXf0/IlyFBEQzYo6L/NolEfkzhYd53DP20/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qELWBM7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA3DC4CEED;
	Sun,  6 Jul 2025 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751787455;
	bh=GtptPjErZW/0ydkdlaJujyJcdrgTujs+pGprdKSBFGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qELWBM7C5VXN9goVfBmef1dBUmfH0qcRhGkCvhdADIKd0m1NFOaVMCSzCnc+OE1io
	 mQl9GrRjHCp9RjCLscXdhbOUZ5tBdyGUA9OhBtq3fjSljQdfLw8NtGUKSGdbsUHp9c
	 vKMj3Vzl8AdWCXUt6OTYsPcBYhJxNMdLpyTEgEhfD+PMlxymYLBVgcLAKtIJA4aZok
	 gySQJoPPIO7o4UMm39CDUnP1a/b2ddBtQ/eGdwB5tjWYhDXr7pDdul3JNHDTu2FwgD
	 9MaE2rxGwiZibE623RnMFPGof3cH+WzifVlAzantzcQAb0crJxix1ysAtDX+G9wE3P
	 TPdQlRQLagvzw==
Date: Sun, 6 Jul 2025 10:37:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/bnxt_re: Support 2G message size
Message-ID: <20250706073729.GR6278@unreal>
References: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
 <20250704043857.19158-3-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704043857.19158-3-kalesh-anakkur.purayil@broadcom.com>

On Fri, Jul 04, 2025 at 10:08:56AM +0530, Kalesh AP wrote:
> From: Selvin Xavier <selvin.xavier@broadcom.com>
> 
> bnxt_qplib_put_sges is calculating the length in
> a signed int. So handling the 2G message size
> is not working since it is considered as negative.
> 
> Use a unsigned number to calculate the total message
> length. As per the spec, IB message size shall be
> between zero and 2^31 bytes (inclusive). So adding
> a check for 2G message size.

You can easily use opto 80 chars per-line in commit messages, there is
no need to limit yourself to 50 chars.

Thanks

