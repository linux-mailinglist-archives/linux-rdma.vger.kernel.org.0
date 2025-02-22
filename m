Return-Path: <linux-rdma+bounces-8007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A15A40AE9
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F987ABABC
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 18:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E8207DFD;
	Sat, 22 Feb 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny+LEaiX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C981D5AB5;
	Sat, 22 Feb 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248016; cv=none; b=a1GF8E8cpgFyvpizvNF5mqUq6pdfuhGdnwLutkOW1uOFgxYgVC26Ll9nVvcUgfMw35Y0UeCUOPIn+C59g3SqD1x+NWr7eGb8rfcUftAMKsJfENPFgws0WN5lR0qoi6Yx26LlGq+hhYOiMcmUO1HKDTl6e//Lu01mR1lS4KvwCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248016; c=relaxed/simple;
	bh=2A232/zdzvYXkCPrQJhGW9CjGVVsP8a988AYRPhVnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfHPwcP+Jayq9+k/YsrD9CARufCfEldNE3GAwuonwl1o8s61CDgXShwGjL4RQrQJB5UaPqAwdfTasE2FyWSiPS0fkiC2mLgZDYBa9mSCHOrwR1FO6rjoQ5t92Uvd7OIaLU0sjUieVM3MDteYl2jK5b32+m10VW5DKVbpyKln6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny+LEaiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568A4C4CED1;
	Sat, 22 Feb 2025 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740248015;
	bh=2A232/zdzvYXkCPrQJhGW9CjGVVsP8a988AYRPhVnjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ny+LEaiXR9zhHLYDLhvE+5ldKn+peAsHbgm3TVmxLM9OaUmM2MztvTJ+IHN1TCKjg
	 IJu64kvxmfuSlTmVB+HkeoLTAGany+gQ7Z4boGXwOX1GsIZQmFTCu30ZD904njy0oX
	 CVJ2HaK/2OCKJfciPEVy33Lk8l/iEGogPQ70cyctT3azfRL4mvFpRuQGHOdZCOmgNv
	 HKMeo5p2aCpakcSuXmEG9Xt6nO83YLrSaKK/c9uvDgDAh837Thftbc4SM8KyD1s6Da
	 uZiFwYUBi5SAQSHM9a6lCyjhxAmuVshcI0UvDholX8Jx8yvDoeZOd2Lgco6AgapIaF
	 V7ZIHAoNGFNzA==
Date: Sat, 22 Feb 2025 20:13:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rdma: Converge on using secs_to_jiffies()
Message-ID: <20250222181331.GS53094@unreal>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
 <20250220070729.GK53094@unreal>
 <bfd711f3-2de6-44d0-afe9-e24470448011@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd711f3-2de6-44d0-afe9-e24470448011@linux.microsoft.com>

On Thu, Feb 20, 2025 at 08:17:31AM -0800, Easwar Hariharan wrote:
> On 2/19/2025 11:07 PM, Leon Romanovsky wrote:
> > On Wed, Feb 19, 2025 at 09:36:38PM +0000, Easwar Hariharan wrote:
> >> This series converts users of msecs_to_jiffies() that either use the
> >> multiply pattern of either of:
> >> - msecs_to_jiffies(N*1000) or
> >> - msecs_to_jiffies(N*MSEC_PER_SEC)
> >>
> >> where N is a constant or an expression, to avoid the multiplication.
> > 
> > Can you please provide justification for that? What is wrong with current code?
> > 
> 
> There is nothing specifically wrong with the current code.

So let's keep current code as is.

Thanks

