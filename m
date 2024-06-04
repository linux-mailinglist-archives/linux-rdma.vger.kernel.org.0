Return-Path: <linux-rdma+bounces-2839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBF8FB4C1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E352282AFE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7D171C9;
	Tue,  4 Jun 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnVc8vTk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F40DDD8;
	Tue,  4 Jun 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509893; cv=none; b=iEZii3chAA4kvhVPYmqMdBhvESI2GT6833ePzfw1dhrNzykcwR3pfnlF2mfr1kBOwtBlFMNDknAmcddh8fdZpxbFEr10X/4UBroFYxo0gi7+WGid374e6BrrJ5NPxf8H0VUMaLdV9Q/2IxbM+ivZWMoxEE3ooeVgm2PIhXxnIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509893; c=relaxed/simple;
	bh=m56D1HG4TMAp7Ua7lG8n8m71RA05vQrWG6ab/U1JnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf7MiMLq+14hRsHTmoYxSwLmyWqK8r+hFfM1TfL0HL6b+M26wb4r+t83RZR1AeCBvGIMAlB/nE4xJ2EmY5v8ZCDmKAxdLi05X3FRl/e/6Y+nBGF/vOT4VO00I71nFP08OrlvFTGgv/otav+FxmefLVzUGqSrwPX7Gv0Dw5OaVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnVc8vTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5DC2BBFC;
	Tue,  4 Jun 2024 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509893;
	bh=m56D1HG4TMAp7Ua7lG8n8m71RA05vQrWG6ab/U1JnzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnVc8vTkWsUBY6czpccOVE7VnFFYHTLsvUwkfK2iG9NDzCoVc2U41OrYHX7EO+HZV
	 AJ1CQOwCimEIxxO1jQPHfN8Gu8Y58hg64hovDVUqmJvac9CxU9tDgQaG9PiFUbXZl1
	 p+n0Fxgxfz4nwLlKZkU0u6WAeyeouCQ+hUQIonQa4thNqTwel3wgQTZDeDR8YG2EKc
	 dgvzrv9C0uCpQkgl6zSe97VqlV8BDpXXxsyLn0e/qpAFGfF8sBYp7dJuOM11cmrZTH
	 B+tD/T/nhQ5ZiZYdazwOnISUSeoe4gFf+LXvY97rtbwo9MxtzJJyYDNHG0vIocXGj9
	 H5cTYbCkbf8bw==
Date: Tue, 4 Jun 2024 07:04:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Itay
 Avraham <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240604070451.79cfb280@kernel.org>
In-Reply-To: <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 21:01:58 -0600 David Ahern wrote:
> On 6/3/24 12:42 PM, Jakub Kicinski wrote:
> > Somewhat related, I saw nVidia sells various interesting features in its
> > DOCA stack. Is that Open Source?  
> 
> Seriously, Jakub, how is that in any way related to this patch set?

Whether they admit it or not, DOCA is a major reason nVidia wants
this to be standalone rather than part of RDMA.

> You are basically suggesting that if any vendor ever has an out of tree
> option for its hardware every patch it sends should be considered a ruse
> to enable or simplify proprietary options.

Ooo, is that a sore spot?

I don't begrudge anyone building proprietary options, but leave
upstream out of it.

