Return-Path: <linux-rdma+bounces-7880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF4A3D1C1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FCD160A22
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EB1E3DEF;
	Thu, 20 Feb 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA8BV9iX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AA442C;
	Thu, 20 Feb 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035254; cv=none; b=cSH0TWvqxSsfwCVKmOrIND31y1kd6cvXf7b5ALJL3ipDitzNzccTFppGpRt1YliY90tOevDhhLLFb800aaHO1tDgr6G77ZYsEBkuKvU4fV/kbiDnY7BitO5DALRCrmmeArug0aw+PdIJ4I+oWMRDlG+HBjR/prZJbcSaaBOrv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035254; c=relaxed/simple;
	bh=PEqaQq3z7OYwiHe4pXAOBQKVNqOKwupXRK90MFiAV7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRltElAUEq50EHjAnZPDH+IDbs4etFACxFMFgeH1+tNJx7ZYdoFNuZp9Rk/oxGyA07fpds+qsZJ6kHswhQA/PVa12dKpyKOrMJ5i0PlYkY1l79JoZlJQ67oCnOuqCfoFhgK635BNkDz/pATXyc+CIRioed8WSniuPWut1E/VHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA8BV9iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F8C4CEE3;
	Thu, 20 Feb 2025 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740035254;
	bh=PEqaQq3z7OYwiHe4pXAOBQKVNqOKwupXRK90MFiAV7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WA8BV9iXAxJpm2EtzQ8UMvgeOTiZHOCvhdwc8arrRxBTgoOMzm+oCRbBNMUGS5P9y
	 8LUlHLoY2V9O7N8FuwLZTMaxfAi6om1B0F7DM/Iy3LrX2XSyOIhaeqvNae5YFqOfzf
	 DTNeg/4HdzQuy+Bl0DEVgMmvZRfcAxkZ6SB8PzTXi+pHMp5Alytm3yiun684I+sU8P
	 qsxhMo8MiiDlHwJXx2Z2lkj9lFXo5DtS8Q6lKObkV3vpz+9Ogr3u5togN1CQqJXHve
	 fjpDwX/P4n4qfwLAFQLtYu6KaJ0GlgVLFuxcKaJ0J7cFiRlY7YkgVJ4pfuN7ZbSOFZ
	 mO8tFLmHRj/dw==
Date: Thu, 20 Feb 2025 09:07:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rdma: Converge on using secs_to_jiffies()
Message-ID: <20250220070729.GK53094@unreal>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>

On Wed, Feb 19, 2025 at 09:36:38PM +0000, Easwar Hariharan wrote:
> This series converts users of msecs_to_jiffies() that either use the
> multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.

Can you please provide justification for that? What is wrong with current code?

Thanks

