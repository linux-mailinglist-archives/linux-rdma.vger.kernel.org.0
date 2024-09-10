Return-Path: <linux-rdma+bounces-4858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B5973857
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E85B260D9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED01925AC;
	Tue, 10 Sep 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muTlFuvS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A5191F9F;
	Tue, 10 Sep 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973931; cv=none; b=IddMIc4BiJq7Qsn5q7ZQi1aM0GovEL7tPpxyh/n+NGocKjZIUeaMbA0qxI7OgXILoIoDq5ynYjFfUdqurhwzzgHHGj4oqSFvWWHYdExc5eqbfuxd64VhqVwuNKsBQNTevOablX1G7sZVqwgg+S4B6H9wpwEjdie7KKYypIumZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973931; c=relaxed/simple;
	bh=IiXPGmsHEiLsBuGb98RBBtINtggf+1ffEWkoTXYgLNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9o02/hRqy6j8F1YHkO9L24juGZ3qc4nVW+odiuNjWlrWG7G9a8rUXXsgNuasHRLK/wtzgc3G53u8UobZ5a91yMZfCViRmom8ER49d60GT3AR4Kt28rGjtUt4KjxWtYiQRxOly50YkLCoGxQd/JwfJTufCEv8a4yQWy4ELUc8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muTlFuvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D8C4CEC6;
	Tue, 10 Sep 2024 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725973930;
	bh=IiXPGmsHEiLsBuGb98RBBtINtggf+1ffEWkoTXYgLNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muTlFuvSiVz1ka3apXUfDTIjMwlbJcQNJ5R4Ew6ehJn7Lpw3M4ynAp+v65RWMN9FB
	 QFHn1a9I1QmfyIEdNqm5n9AKCPb+lMcXOobG34L/5GPAzkX9qg48Nw07OPnJccHyyx
	 ZAup8WSBOjxwNaXYGRR5ijiex/D5yCyZsW0yMXaqBOh2Z/r5fCG4HTDvOzFoAnenx/
	 IErRAHuxQf0xmJf5CQu/44JG3IpLaqs7oGzkaqSkKoIp04kYqV1wIM+mktjbajsKz9
	 NIXWvqj5tT9QYSWGZOSXRz3HLGs+gzNdgZYBpB8nxKzG4TIlQb0tOe0aMb3cmVb7/n
	 04+Cntwcw+JvQ==
Date: Tue, 10 Sep 2024 16:12:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/hns: Fix different dgids mapping to
 the same dip_idx
Message-ID: <20240910131205.GB4026@unreal>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-10-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093444.3571619-10-huangjunxian6@hisilicon.com>

On Fri, Sep 06, 2024 at 05:34:44PM +0800, Junxian Huang wrote:
> From: Feng Fang <fangfeng4@huawei.com>
> 
> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
> Currently a queue 'spare_idx' is used to store QPN of QPs that use
> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
> This method lacks a mechanism for deduplicating QPN, which may result
> in different dgids sharing the same dip_idx and break the one-to-one
> mapping requirement.
> 
> This patch replaces spare_idx with two new bitmaps: qpn_bitmap to record
> QPN that is not being used as dip_idx, and dip_idx_map to record QPN
> that is being used. Besides, introduce a reference count of a dip_idx
> to indicate the number of QPs that using this dip_idx. When creating
> a DIP QP, if it has a new dgid, set the corresponding bit in dip_idx_map,
> otherwise add 1 to the reference count of the reused dip_idx and set bit
> in qpn_bitmap. When destroying a DIP QP, decrement the reference count
> by 1. If it becomes 0, set bit in qpn_bitmap and clear bit in dip_idx_map.
> 
> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 58 ++++++++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  1 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 ++++--
>  4 files changed, 67 insertions(+), 14 deletions(-)

It is strange implementation, double bitmap and refcount looks like
open-coding of some basic coding patterns. Let's wait with applying it
for now.

Thanks

