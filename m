Return-Path: <linux-rdma+bounces-2924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA48FDC63
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 03:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E566C1F23729
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA01758D;
	Thu,  6 Jun 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZYsSnaw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058813FEE;
	Thu,  6 Jun 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639108; cv=none; b=vCFPfYl6d4G5XY8FRqSGWnizZjlsAlxAyts2jHGHw90PuxaY2lHdZOUPepYa9z93XLdxUy3XsMVQGkMq381axzckEcYk7CEYTevCnPb5BRWyG73HVh6pcWezfdtaZDM2UUktZ7ABoYk9pimYXpucXPWp+FLZFmV1WHJBFhjPIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639108; c=relaxed/simple;
	bh=LMH/6S7ojwS+cNq5NMSC/XHKx8l4iSLOp0qY3slkayg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtbzkpD1RCUpEPDl/O7y2tS0nW6NIL9WPwhiG49UIvle7Mg2+pAbDW7v3mDgf2zuwxrOl7n8rtGMQTYmCfBp8rTjvZfbdweRJoYCgxQHE62jzD2ERyn6qETWs+ZtODwwS1WuAIswgcCgHfGqKnvPqX9F9bPCDaYQ1DXBY2daKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZYsSnaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F87C2BD11;
	Thu,  6 Jun 2024 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717639108;
	bh=LMH/6S7ojwS+cNq5NMSC/XHKx8l4iSLOp0qY3slkayg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZYsSnaw5M1zbYtSpBXYqcqiSe6OOSUx3C9N3GRN6NCToBmMZerHm//iRV059iNd6
	 lC7Z2A9alFc++kGCuBw6lfnebnI0oOafQTYIOxq1JrMjyFNcH9oic1PHTzYV3Lar6h
	 sLDYJB0+3ZX2yQIFIyeRTel7gNJHWZocn6y5pLi2eHtbSjrLVC4w6TweWoKmh8jgBu
	 qU3M+vbFFqCo1dJgTNL2plvxfhbmENIk9hCCJthz2oWP2aZDLjhf2z0FFtW1HYuZlc
	 b5sEPir/V23weCpnk1ALxMXWDb4nU05FziOMithhTVKSg9y7PoMGJWuVdM+U1IwUhl
	 ldTfzOSpDbbzg==
Message-ID: <5fd15963-5678-4965-b19f-67cdb6def3f2@kernel.org>
Date: Wed, 5 Jun 2024 19:58:25 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240604070451.79cfb280@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 8:04 AM, Jakub Kicinski wrote:
> Ooo, is that a sore spot?

Maintainer overreach? Absolutely.

The sky is not falling with this proposed subsystem; engineers are
merely trying to solve real, customer problems.

