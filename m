Return-Path: <linux-rdma+bounces-3638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F97926EA0
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 07:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E39B2827E9
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 05:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875A194AD7;
	Thu,  4 Jul 2024 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHvPktvx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBC194AC2
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069291; cv=none; b=D91c/w8IKNndX5RbjHJbxPwGxgIVcjTHragzZmg36wr+F6qrdxqCJe7WtnIoAyzemWBpc8n6um0ISZo+Ff/lBMCEg77dQv59smYs4ecATq3jvd6BHybKsembTQ77ajbkFvmIzgw8POso39/X1luXY7e/6KoGWA5q7klvDkEevlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069291; c=relaxed/simple;
	bh=OA1zCs5GsXUSqCvIMa4hn/+4GsK3XpQzI3TKcmUtbZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar5+TfkYAcBD1fAz9DC0XyqM82EkNa0wkCWfJptr3jjuEEaGMbyApNnKplR2Z7KF/c2QvBzDM3KDNq/PJNlmrOL16zwC8Cgwh7MqONQcnIsFhvK6hlcEYyQR/0dnR3N0b3sM++LY464SyWwk+QzcQS7l5X4sFwNpk+CJyty1J1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHvPktvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AC1C3277B;
	Thu,  4 Jul 2024 05:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720069291;
	bh=OA1zCs5GsXUSqCvIMa4hn/+4GsK3XpQzI3TKcmUtbZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHvPktvxglzV0ojA4fFq7H27HtTtMemfId51LVqq+r3yXCpo1rHachzirfGq6s4XL
	 J/6L4M7SS8e6yNfFtTOLqjqxwAphIeZb4H9CIRPwAhl1cbc7XY3dV1TJUPpvBhc0Y9
	 5v3kSinEsRss6oJNR3JhJScli2HpU8ouJT24LC0Pbhl8OHI+5qAGFyP3nu+YZeLUVH
	 d2dOmkyD48+5Q9me7zf4nxoONaDv1AXYOX96CqkouL0QGvOns4z9I3DmBtIUDfZ4AS
	 Ty5XGnq6aQ08DBy+GwA4gJPb/oxJMcg8OvixPt/CbNfZbVd06tYmMjNdesBGrPSYX/
	 VN9GYSkjXf5Qw==
Date: Thu, 4 Jul 2024 08:01:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mark Zhang <markzhang@nvidia.com>
Cc: dsahern@gmail.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC iproute2-next 0/2] Supports to add/delete IB devices with
 type SMI
Message-ID: <20240704050127.GC95824@unreal>
References: <20240701083112.1793515-1-markzhang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701083112.1793515-1-markzhang@nvidia.com>

On Mon, Jul 01, 2024 at 11:31:10AM +0300, Mark Zhang wrote:
> This series supports to add/delete an IB device with type SMI. This is
> complimentary to the kernel patches that support to IB sub device
> and mlx5 implementation.
> 
> https://lore.kernel.org/all/cover.1718553901.git.leon@kernel.org/
> 
> There's no kernel commit ID for the rdma_netlink.h change as the kernel
> part isn't accepted yet.
> 
> Thanks
> 
> Mark Zhang (2):
>   Update rdma_netlink.h file upto kernel commit

Kernel part was accepted, please resend this series with the updated
first commit.

Thanks

>   rdma: Supports to add/delete a device with type SMI
> 
>  man/man8/rdma-dev.8                   |  40 +++++++++
>  rdma/dev.c                            | 120 ++++++++++++++++++++++++++
>  rdma/include/uapi/rdma/rdma_netlink.h |  13 +++
>  rdma/rdma.h                           |   2 +
>  rdma/utils.c                          |   2 +
>  5 files changed, 177 insertions(+)
> 
> -- 
> 2.26.3
> 
> 

