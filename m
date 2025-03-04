Return-Path: <linux-rdma+bounces-8335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B325AA4EB2F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4731189B41A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A92923B6;
	Tue,  4 Mar 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8KYe4Jp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF17207DE6;
	Tue,  4 Mar 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111179; cv=none; b=QroyOMlQlEiD3nTzgrcP3wuCZMrDw+8vE9qYRfZWHPWQUfQw8MMJy4zAs1xHi4LUGqE/ZXV+FEW/2QcEVFaZLXhxmfUGlpz4CIw1FIubkz1595srISCPg2dWMBCrpkLGHOUSml0UEILqBg/fVaUDAilXWvQan0WKntwPOkXiidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111179; c=relaxed/simple;
	bh=YVZdnIYU5dWmx6KvKoMzGZLeD/aY3dyAs8KrL9Pjvxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxuEgp/AmI0anlBX1R3/e5jUEmtvfoFWX7bbqY0OIorLEJa2C5c/Ho7hj30cgb38hjICD5XMxP9l6FdNqGL51m52FXO5nB/6/vhEkCSf9CmQrC6fFATYdQVvGjmbdorcJ1YMACkXpm1RIBzXhgtaweZQ+5ztQ3FBPTFIJYm4biU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8KYe4Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C6CC4CEE5;
	Tue,  4 Mar 2025 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111178;
	bh=YVZdnIYU5dWmx6KvKoMzGZLeD/aY3dyAs8KrL9Pjvxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8KYe4Jp6/Sx/x93RVneDKiT6giUhpqeUWQgkD8WFbqlLUzv1XqnMaZiVVmmwoU56
	 pA8rTblZCA/GJXZIZuQ3isx7eYAcyx19c4QKfUEVLdvCkgJCKvm45VsSHhNUexFOeU
	 iGMqChatgjFhlkSj1SGzU319VYsGUxLdu+Dz8srAIhmDJcsSY2yZJ5T0QH10+loH3N
	 WBQuOkrTCINa9nJI1H9P+/eXuc3Bv9Cz5VNk3UMZHtHv3UaV/BQxr/yMYiwjcFNINq
	 O8J+W1MxvESlz3Y44Cm9zgoFWUH3086IZxU0N58cx5WN9v0VXLaL+vXF/WW0l7chxu
	 IP/PNUHcFlKyA==
Date: Tue, 4 Mar 2025 09:59:37 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <Z8c_iRE-XWuv5mrD@x130>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250304140036.GK133783@nvidia.com>

On 04 Mar 10:00, Jason Gunthorpe wrote:
>On Mon, Mar 03, 2025 at 05:53:58PM -0800, Jakub Kicinski wrote:
>> On Thu, 27 Feb 2025 20:26:28 -0400 Jason Gunthorpe wrote:
>> > v5:
>> >  - Move hunks between patches to make more sense
>> >  - Rename ucmd_buffer to fwctl_ucmd_buffer
>> >  - Update comments and commit messages
>> >  - Copyright to 2025
>> >  - Drop bxnt WIP patches
>> >  - Allow a NULL ops->info
>> >  - Decode more op codes for mlx5 and the sub-operation for
>> >    MLX5_CMD_OP_ACCESS_REG/_USER
>>
>> Did you address my feedback? I asked for the mlx5 support to only be
>> enabled in RDMA is in use. Saeed who wrote the mlx5 parts of this
>> patchset clearly admitted on v4:

When I said fwctl is not needed for netdev, I meant that it will not be used
for netdev object configuration and as I said before FW will block that
anyways. fwctl in mlx5 is not only for RDMA, So I don't know how to address
your comment. 

Not to mention that fwctl is a very great tool to debug netdev problems.

>
>I never agreed to that formulation. I suggested that perhaps runtime
>configurations where netdev is the only driver using the HW could be
>disabled (ie a netdev exclusion, not a rdma inclusion).
>
>However, there is not agreement on this from Saeed who is responsible
>for mlx5:
>
> https://lore.kernel.org/all/Z7z0ADkimCkhr7Xz@x130/
>
>I also surveyed other stakeholders on a netdev-exclusion proposal and
>did not hear support. You need to convince people this is a good idea.
>
>However, I would agree fwctl should not accept any fwctl drivers for
>simple networking devices. However, "smart nics" and RDMA capable
>devices are in-scope.
>

>I could also probably agree to using kconfig to disable fwctl drivers
>on kernels that statically compile out rdma, vdpa, nvme and related,
>though I agree with Saeed that it seems to lack technical merit.
>
>> Greg, I've been asking for this interface to be scoped to when RDMA
>> (/CXL/storage) is in enabled on these NICs since pretty much the first
>> RFC.
>
>You only started asking for this more limited approach in v4. All your
>previous arguments were that fwctl should be entirely killed for any
>networking HW.
>
>Jason
>

