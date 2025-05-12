Return-Path: <linux-rdma+bounces-10296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FFBAB34B3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 12:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542DC17D781
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7AE255E33;
	Mon, 12 May 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw2LL6q4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45625D21F
	for <linux-rdma@vger.kernel.org>; Mon, 12 May 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045078; cv=none; b=V2g4M1F0EExAmHLqoRPGXVPbxqxZQRk3ZkSirGvNrY89M/6QysIpvn/bEQbZO7jECY4xuv7/8PEHddDxzt3OmUUQy1pOc8mgql0DIFcwfzYWTH88/LdZUDJ6kXxwzANLJUzK6TSoPfLMqUnXRlJili3H6GR8BLSwEMEEXH0rBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045078; c=relaxed/simple;
	bh=GpFlu9kpfUsMUoSrA+P7batXjG0r7txaDELedMY06WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgoezw37epjV9dkTUTtQeAyYJBiNfyLj/dr+UMR5oPX30s1GHkq03Hvo4ZN9eYEolRE0yzXbdafk7/9SSx65p3WSOXURDhtzjd4uw1mTOkW/ywYVOPqLhqciAd1WLjg63iomI+SLKHkpjPpd3XUaoBtAnWvw6O88uvzPJt0Ue98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw2LL6q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD3C4CEED;
	Mon, 12 May 2025 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747045077;
	bh=GpFlu9kpfUsMUoSrA+P7batXjG0r7txaDELedMY06WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aw2LL6q4jjFnGA2MoIbOYCbvHL8/WvJaqFlEw1WiETye7oBygyvnLrHjQ9tNF5cUa
	 kaWCbPN4YclqxQwFFOXP3tEe5xB0Zt8oWnDHdDvfXCV5MNO2DcXalHPIfet1W3j0KY
	 4BmHUWWF5HcRz09kaSxOYH27RW0ovRS8f4t2km6WiHSyxVhvwSHe6lmr8HbCNOL6EU
	 X2p0w0b8nlK5qeN4WoT7rrHNBexnHZ7+gtBPoito1hBCUF7LjU/21r8k4ML0yfrNUX
	 GIqiXMcZIvYxsFk+YV4AnHjrbXTVJ5TTHFfDdZ9fKcxcSDqDCkDJSDJZut115NhUFU
	 9hruxswhpXHmw==
Date: Mon, 12 May 2025 13:17:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: =?utf-8?B?5ZGo5rSq6ZSL?= <hfzhou369@163.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: Clarification on rdma-core Code Style and Contribution Guidelines
Message-ID: <20250512101751.GB22843@unreal>
References: <2442ea1c.5bd5.196a9714b5b.Coremail.hfzhou369@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2442ea1c.5bd5.196a9714b5b.Coremail.hfzhou369@163.com>

On Wed, May 07, 2025 at 02:31:36PM +0800, 周洪锋 wrote:
> 
> 
> Dear Maintainers,
> 
> 
> I hope this message finds you well.
> 
> 
> I'm Zhou Hongfeng from BitIntelligence, a network company from China, and I’m interested in contributing to rdma-core. While preparing my patches, I want to ensure my code adheres to the project’s style guidelines. However, I noticed a few uncertainties regarding the current practices:
> 
> 
>   `.clang-format` Usage: The repository includes a .clang-format file, but it hasn’t been updated in a while. When I ran clang-format-11) on the existing codebase, nearly all files showed formatting differences. This suggests the config might not fully align with the actual code style. Is `clang-format` the recommended tool for enforcing style consistency? If so, is there an updated version of the config file that maintainers endorse?

We follow kernel coding style in rdma-core too, but some code was
written before we adopted this policy. So the guidelines are relatively
simple: use kernel style for new files, and "existing to that file" for
changes in already existing codebase.

> 
> 
>   Manual Style Rules: If the project prioritizes manual style enforcement over automated tools, could you point me to documented conventions (e.g., indentation, naming, comments)?
> 
> 
>   Pre-Submission Handling: Should contributors manually match the existing style, or is it acceptable to submit patches reformatted with an updated .clang-format?

Sure, it is perfectly fine to extend existing .clang-format.

> 
> 
> Additionally, if there are other contribution guidelines (e.g., commit message format, testing requirements), I’d appreciate any pointers to avoid unnecessary review overhead.

Kernel coding style, pyverbs tests coverage and +1 from CI.

Thanks

> 
> 
> Thank you for your time and guidance! I’m happy to adjust my workflow to align with the project’s standards. Looking forward to your insights.
> 
> 
> Best regards,
> Zhou Hongfeng
> Github.com/zhf999

