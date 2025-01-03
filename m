Return-Path: <linux-rdma+bounces-6784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D3A002F2
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 04:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE211883F07
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1E19DF8D;
	Fri,  3 Jan 2025 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugFlG+HR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252118E359;
	Fri,  3 Jan 2025 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735873373; cv=none; b=UNmRgwhbn8fTVrw4yiuSnjx7kHjhZSP5UStZYRJze13vhRDNfaG0X4XHyIw1KSbWc8GVplAdU/2kgAPVCHClbF1JVeV5u3C6l2+rpvlRpzgcGhhJcrl8CO9v0mKCYzx7YhCY9Vy3yU0p4GocHMn0QcW0Ry3dxEzqUAwkgDgQFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735873373; c=relaxed/simple;
	bh=sISZToZ3HkWThbVCO4MjptYH89XgoDn1B/Ii76AHTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgEykqIWwQCKkkWc2Lfpa99As8F4sD27B8iT+SGUJ74wRGvuzjYCro3krIPM8wQmyXtLig1QuRBlaN+8NVFW+2I8wNP3xmZzKd4hVEecsS57m1zUsck6VZMyY2ovvfaIvOOQrwYyqNv43//WKbA33uPHQObRwb6UQuRfz8hm7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugFlG+HR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3919BC4CED0;
	Fri,  3 Jan 2025 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735873372;
	bh=sISZToZ3HkWThbVCO4MjptYH89XgoDn1B/Ii76AHTmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ugFlG+HRXTyqhUwVLjvUwu/fu5+OLe8CdW5FTbiQw2BK+/HTIPNpsleLc4wb6a6ao
	 uA7HncLGBM5IezfTwwNu4DQolgrT2N6Ka2QTdULdc9iXuPLx0tK1z7q1eusrwQ1psI
	 xMcvPYBsZnHsYJfnFtRZR4DxzY1nOKnWOJUILk/6ucPARUB/GnO0A4cS3uFsec/nUB
	 mWzIsjj2KzN71pVANthcgAbp+G1U3KLG1hqU6DkfVsVGOkXOI+ehFojJKKUamtAlwP
	 hSawZeulJJXmqGAjbJRfiCs0+a0JX11ZmuM5FmPaozUpLzEuZUu3TB5A7iLDRNDvD1
	 pYqyH/Ath+2uA==
Date: Thu, 2 Jan 2025 19:02:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, PASIC@de.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix data error when recvmsg with MSG_PEEK
 flag
Message-ID: <20250102190251.73b389d8@kernel.org>
In-Reply-To: <20241220031451.52343-1-guangguan.wang@linux.alibaba.com>
References: <20241220031451.52343-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 11:14:51 +0800 Guangguan Wang wrote:
> Subject: [PATCH net] net/smc: fix data error when recvmsg with MSG_PEEK flag

Since this is a fix you need to repost with a Fixes tag added.
-- 
pw-bot: cr

