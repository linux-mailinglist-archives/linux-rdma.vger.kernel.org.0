Return-Path: <linux-rdma+bounces-8278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A82A4D143
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 02:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9B77A744A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B713B58C;
	Tue,  4 Mar 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuQy3rXN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699286359;
	Tue,  4 Mar 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053240; cv=none; b=S9S5x4eR5Le/cGiKkN1o1er0kykEKt1Ccp5Apv/4bHtKMdITk3B83hlJcPT5+WOQGzgy6/3L43wv4oOINADgP+J94BDmeogaDKvVeAoFxbhfFFoMMIcioObYvOPHOUAq9VnkCru017DJglwV7Tq8jP74MaqBIVupRZvnKCHrjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053240; c=relaxed/simple;
	bh=vOBtcO7BUDYYfaSWV47VlqyBHkJCqACzFydEcJw2Ntk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHAHV9tIrJgfLu6UHnPco/qn3ff3XhSDopDuZO2wQWGD68jWp7pjapGWU2Onb5+AMAFlil6UBZRlTg2lI3MOZMVVRMwIpz3l+TzdrhIANQskR7j9HSqL/0TKTepq78tYXG3mlgD0N6ilvuZFAUHKrhVyNOIeHuEzl24fVeEAip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuQy3rXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FE6C4CEE4;
	Tue,  4 Mar 2025 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741053240;
	bh=vOBtcO7BUDYYfaSWV47VlqyBHkJCqACzFydEcJw2Ntk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuQy3rXNDuM/qY9D81GwMkmmunQH0flv8m+4EvTB3KTAdDCb99wwcI2B28/AtxbSU
	 SlN5YCHjymEmrYY3AhCUEf8JeAwGQMm9AvI/WK3VW5Tw8wQ6vFigZl4b6qcMXqb0dk
	 9lbMkX8c4ofgl4znJu9Fu0ACRfQrsFfkmRhOos7CV5qZzBm2Btqq6CLg6ONPE579Bh
	 parZfI56L3XGiWo5VYRgd77vmxSz4eUql4mMdW07W1xGv2EQ18cVuRz0llMT++VVWs
	 UDvCciSuL84WcI54cdt1+T/LtQCgnRxss53awyi0wlo63mWJ4X8fGS1GlWtglm8ieV
	 tMxHq+NllyLZg==
Date: Mon, 3 Mar 2025 17:53:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250303175358.4e9e0f78@kernel.org>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 20:26:28 -0400 Jason Gunthorpe wrote:
> v5:
>  - Move hunks between patches to make more sense
>  - Rename ucmd_buffer to fwctl_ucmd_buffer
>  - Update comments and commit messages
>  - Copyright to 2025
>  - Drop bxnt WIP patches
>  - Allow a NULL ops->info
>  - Decode more op codes for mlx5 and the sub-operation for
>    MLX5_CMD_OP_ACCESS_REG/_USER

Did you address my feedback? I asked for the mlx5 support to only be
enabled in RDMA is in use. Saeed who wrote the mlx5 parts of this
patchset clearly admitted on v4:

  As explained above, netdev doesn't need it

https://lore.kernel.org/all/Z6ZsOMLq7tt3ijX_@x130/

Greg, I've been asking for this interface to be scoped to when RDMA
(/CXL/storage) is in enabled on these NICs since pretty much the first
RFC. Do I need to keep responding?

