Return-Path: <linux-rdma+bounces-1361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8AD877656
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5487628193C
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB91F608;
	Sun, 10 Mar 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDc3ozOb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708EF22EED;
	Sun, 10 Mar 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070391; cv=none; b=WvUJakeF77SpEVodoemJxwOC2XnDNS7E57GA8opvgF4oIOHvDR4SUHDFnI45tn8b1O5sd/KZ8IOSIeXEeznzkIxLBXbMRLWpzqReofeM92aVM5c3euSqFMLWfCr77cJIH6SXDM69fNG4mkjes/MtwFa3Clm4dYE5lVUp0uM9a6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070391; c=relaxed/simple;
	bh=YWjjnQjyzOwC1iISznXSR2OaGbSmKQDVUsuZqgK1ZFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxO+3NYNJpVeTEbHIb39q9te/cimOTdUQafw8IsJ+ap/q+LGYUIA1HKOdSatdKgZK/K4OMPlrmX+lbq4tbBiZ4o6QNEztDwtxOHJPNQpD4Ye+lsklz0Dm3DuU2DCXUsFIZcs+83/otOPhGRT0IvjyrzWHt+MSdqiGmpBzvoqzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDc3ozOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1F6C433C7;
	Sun, 10 Mar 2024 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710070391;
	bh=YWjjnQjyzOwC1iISznXSR2OaGbSmKQDVUsuZqgK1ZFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDc3ozObFpW6fYmTmiR2OeDzowmoJhgILRGJgVSKjqAkM6s1Bc+6RP/Ky7nsCXiqX
	 xMArkHznjMgL+XW5rFKWBDh84oXoxzOjHz2uvQLdr/R0fTWUQbWm2vUw5D38wxzhJI
	 4WdIGcIg0M5VL3XbjbTHWt8fORQPKvxZ7ik0/qvxty+Nj2s9WSux7ZBoBEN3oVBf8C
	 bobiEU+cLSLrGuykwzKEe/LX1GR1VWLXGCDDb1DnCY1FKKv3zpruTIUv3IBMhiLENj
	 rX06NAJfgMn5q+KWEJTCxzfFRn/8KLqZwce46faT2qGbB2s5Sncgq4at3r1NUQx/VI
	 DaQSLzVTK08/Q==
Date: Sun, 10 Mar 2024 13:33:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: linke li <lilinke99@qq.com>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
Message-ID: <20240310113306.GF12921@unreal>
References: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>

On Sat, Mar 09, 2024 at 08:27:16PM +0800, linke li wrote:
> In siw_orqe_start_rx, the orqe's flag in the if condition is read using
> READ_ONCE, checked, and then re-read, voiding all guarantees of the
> checks. Reuse the value that was read by READ_ONCE to ensure the
> consistency of the flags throughout the function.

Please read include/asm-generic/rwonce.h comments when READ_ONCE() is used.
There is no value in caching the output of READ_ONCE().

Thanks

