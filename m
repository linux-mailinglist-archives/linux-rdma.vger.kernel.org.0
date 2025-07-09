Return-Path: <linux-rdma+bounces-11998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EEAFE0A1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E403A50D2
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388E26C3A0;
	Wed,  9 Jul 2025 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMzPNY0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71426B955
	for <linux-rdma@vger.kernel.org>; Wed,  9 Jul 2025 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044183; cv=none; b=GA6h99+xZspP8Uc0MDDYo447p5zQ/zwHf+1boHAxhyx0mwrY8EPwD04HLdeeejNxA2tV75RviiCskcaBtYWBmNShsihcrFbPsJlFaDwHdl6mSNaBLPkM90kQcyoxX1gK5RnlzkkxTC/JaBb2Gm2tqra7xz3I8vIH8URcCbx3gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044183; c=relaxed/simple;
	bh=8zxQCCOKiOSZMlPZ2bQfLbmJIcDu23BYiagUw6MK+EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Val17MN6S9KWkae8iuvtqvadmiBtig2w0WxkuiMLo11LiPRzdwSs9WrAxDBOGRnrNtyvbG3dt+86M+UzGPrnyFZTaPg/QkTJm7fWTuRtd/8YKRDAHFRLdTswp3AceozX+aL3mVTMdN6tl08rS8fWFNsguhy7qLW2bbdAiCwNyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMzPNY0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B180C4CEF0;
	Wed,  9 Jul 2025 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044183;
	bh=8zxQCCOKiOSZMlPZ2bQfLbmJIcDu23BYiagUw6MK+EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sMzPNY0Jdufw2P4WYxPrl2Qb4+BVtXBIzNFlV+VlxG5IurfzXbjXNp7bYQxnNSLZr
	 nDMehc1sj5DFkWq3eFbu2nAWx7iStH8Zg4IpCMdfHWehPlt8lY9dvA4AaRELW1i9Er
	 QBXffDS2yQxvEdBNu83icZz83X6ryRsqTowjmlqM/P0edM3T1TMDe/SLeRZD6TH+l3
	 IsKwDAw5oLW8vPcTIiHCl9eqUrV6C41zbObxg/4PDxrR7OGdN7McVw3eJHNVVwLNV4
	 5ccnyGaP3YxVDRCYhOYNXyG6ENATUUk32fwSF+kwLh/uN90lqIvS6VIBVvQ/zEjELP
	 zmnUVi7Mk7iMw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Basel Nassar <baselna@amazon.com>, David Shoolman <shoolman@amazon.com>, 
 Yonatan Nachum <ynachum@amazon.com>
In-Reply-To: <20250706070740.22534-1-mrgolin@amazon.com>
References: <20250706070740.22534-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add Network HW statistics counters
Message-Id: <175204417958.1575949.10589396577061713242.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 02:56:19 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 06 Jul 2025 07:07:40 +0000, Michael Margolin wrote:
> Update device API and request network counters. Expose newly added
> counters through ib core counters mechanism.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Add Network HW statistics counters
      https://git.kernel.org/rdma/rdma/c/475ac071bade37

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


