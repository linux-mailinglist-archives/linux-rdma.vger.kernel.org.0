Return-Path: <linux-rdma+bounces-7764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B738DA35779
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DC166AA9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F02046AA;
	Fri, 14 Feb 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDPp28Ow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D01519A9
	for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516264; cv=none; b=Cp0O21k41hRCWKkNX2Nd49PPdDpOZg7BRcJvQFZV6b2lMQ1CHC2Mji1yInsYoAIMyhBACfs/w2a5h1F4J4CL/RU6fwh67yxJ0Vo8wdQifs0yoN7iuYJaaHtURSXk+fHSCi8OGtG5thfpcalifpC3alG3B1eI3seGnHMbQ3E01ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516264; c=relaxed/simple;
	bh=WvHtlm7ilpb49u+gwFozqfs+9kX8e5c3i6foF/7a7zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8Cm/UCqEMs2DCq/IiTlWWBWFn4HAfhR9Px7VjTYXk8lDzpoyjW4vBkmAp67aa58t2thlpa3xFYCSwfxzW9Uhm2Ym6ICR79FSAVSxzMvzgbiV5xNbTiaO/74MmMfcV3MwIxoeRT7+5RWB7B+w0QkflQxg/+RxFTrUMWXlmU+Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDPp28Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE77C4CED1;
	Fri, 14 Feb 2025 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739516264;
	bh=WvHtlm7ilpb49u+gwFozqfs+9kX8e5c3i6foF/7a7zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDPp28OwSCEznHxzd2kFc5PG9CIw8Ub9xkgGwEMhYGHH68ACHR1nLzpWXTaxdSr7R
	 lX/0HwQD109aNKFCpHayzglnS1rX58e8KdLHqIS+kzezhNLAT/6vSKvnIMMV108CKj
	 ec/n1Eor+Ws8fae5IAcarBCItCIjnArjKqO3baSlWhYI9McWLKoll6wp04nY8Er8ms
	 MV7/7kME/4TEklJHFzT8rEh7laapu/wwTDtQ46VkHH5oJNQtAi8MCBDwm1O1uWp7HY
	 YawsBEwVaGR1R2T5/zrpbmjbmHh1A+ys4MGN6X20Fdz0f4uSqSgq80YNNXaf7JDVtt
	 aydPW9SnI9c2g==
Date: Fri, 14 Feb 2025 08:57:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250214065739.GR17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <173945122413.294504.1292933084740931802.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173945122413.294504.1292933084740931802.b4-ty@kernel.org>

On Thu, Feb 13, 2025 at 07:53:44AM -0500, Leon Romanovsky wrote:
> 
> On Sun, 09 Feb 2025 14:26:08 +0000, Michael Margolin wrote:
> > A single scatter-gather entry is limited by a 32 bits "length" field
> > that is practically 4GB - PAGE_SIZE. This means that even when the
> > memory is physically contiguous, we might need more than one entry to
> > represent it. Additionally when using dmabuf, the sg_table might be
> > originated outside the subsystem and optimized for other needs.
> > 
> > For instance an SGT of 16GB GPU continuous memory might look like this:
> > (a real life example)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] RDMA/core: Fix best page size finding when it can cross SG entries
>       https://git.kernel.org/rdma/rdma/c/a4b57de5dfef29

I dropped this patch for now.

Thanks

> 
> Best regards,
> -- 
> Leon Romanovsky <leon@kernel.org>
> 
> 

