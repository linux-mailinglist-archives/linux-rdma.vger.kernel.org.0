Return-Path: <linux-rdma+bounces-6323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2369E82FE
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Dec 2024 02:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0876D1655EB
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Dec 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992AD9479;
	Sun,  8 Dec 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDmMSfuN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7C8F5A;
	Sun,  8 Dec 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733621890; cv=none; b=ofWH4KVDEyoRpmDqVXS/lU82sTzOGOCHu7AOz4s60MnFw1PFeI5Dr/CO/+JgfYbMR6SpR66CafxMy6nDvAjC/slTzE8qw+SRoJj4NnjcEk6vF2dzxZIBwnYEIvFqz4e7s0E0nmvXrmXwixgi6QtnQdobl0gPkLk2ejanta/2SqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733621890; c=relaxed/simple;
	bh=TR2J5NSAw+Lh87enOFM+xV4x+lnybI/rvOVW3mAn2sE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzp7rx3w+Mcow1sm5iw1mMWssKYCHOrzADE330vEZ+LoHuIF7frq7ObBjTEJ5n+wvfdLBo9ra9pti1AAAzhWimS1BduBW7pFe+XCnlV+o0Q4HSXg46dyR8MKtJbzGjvLSBhfwffb1j/D6JZwZBf10SNNCeF5Bd7qmfXJZuITDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDmMSfuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FCBC4CECD;
	Sun,  8 Dec 2024 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733621889;
	bh=TR2J5NSAw+Lh87enOFM+xV4x+lnybI/rvOVW3mAn2sE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDmMSfuN2R2stjPTSLN5y+pAb8xTU0AzMMC5W2SGxKDaL7gKlsyqd0xOFq1k5lkt1
	 hwZJcQzyYwIEqdrb8OaP9NnqpHfs8MK8lokilRMxKzdtfSa5Gmp/I8waUnADMjKoGL
	 R8CO49piyffvkELYB8u92/1iyGG55LlyvHIMpiRIybE3L+Qmv9dX2wJM+9o0L2wf0c
	 TStdl2Zf2sgYro8VNEqp04Dtjfje8ZeK2/D8iTct8kFn1QWJV5UlQ/eaZgdeAN9Wxo
	 7EnmQIJoL9txGQSEDenlpeJjY0SsWSeCK4eO6n+GJphFUr6VjZ0OifUpVX/Vhlhj2j
	 tWbXIH6O23u/g==
Date: Sat, 7 Dec 2024 17:38:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, gal@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Tariq Toukan
 <ttoukan.linux@gmail.com>
Subject: Re: [PATCH v3 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241207173808.5866b5a6@kernel.org>
In-Reply-To: <20241206090328.4758-1-laoar.shao@gmail.com>
References: <20241206090328.4758-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 17:03:28 +0800 Yafang Shao wrote:
> We observed a high number of rx_discards_phy events on some servers when
> running `ethtool -S`. However, this important counter is not currently
> reflected in the /proc/net/dev statistics file, making it challenging to
> monitor effectively.
> 
> Since rx_fifo_errors represents receive FIFO errors on this network
> deivice, it makes sense to include rx_discards_phy in this counter to
> enhance monitoring visibility. This change will help administrators track
> these events more effectively through standard interfaces.

It's not a standard if there is no definition applicable across vendors.
Count it as generic rx_dropped. If you disagree with me please carry
this tag on future versions:

Nacked-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: cr

