Return-Path: <linux-rdma+bounces-5903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91D9C32D0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E95B20BD7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45438DF9;
	Sun, 10 Nov 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3du1XFb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4438FA3;
	Sun, 10 Nov 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248924; cv=none; b=CzIbYc7HfFB4VLo0ZkmtVzZaY4cCXgbvT588jTXUusP2Dtu06BLAfncRw6h0HpPHK5g6I9x5MzXW0s5ulqrnVyBjAk/5QAE9ffeKoZY1pmyMzhFa23qVAFj5NlXtNJO9scve9JqmatFrS2jf09Q/CEfpzd6PfubUBnRxc4P5gLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248924; c=relaxed/simple;
	bh=NKEdFAEQX3z9SwrCkMOGWoU4HvTVSn4adV5zJi4cTxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpHfkxebIBRTDrY+pQIQnJK59aWSdw7fmAcYHjkRT7VrxmrMQjhIbinFpOlNAHclNZsb8weMYgdMmxS53L58cgvkEfLomQr1GorCC8oILFRgW0HeiqvgYGck7HwQeaxtR/UOmKyC8x0DzJJTQ+zUPw8R77/qpEReXGgvGS0ydLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3du1XFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C106C4CECD;
	Sun, 10 Nov 2024 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731248923;
	bh=NKEdFAEQX3z9SwrCkMOGWoU4HvTVSn4adV5zJi4cTxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3du1XFb3G6LjwQLw59sQB99r4WAEgy53T+lqd3vpCdwJ9fw18h+InLwE1JirawDZ
	 OyPuKVp9Y7FLKpe5dBcPvQM8vsLw/yWv15gZH0QyMiz3DO9Mx2ltxjz/gbGH/srgKY
	 U27wN08+Uax6IYZvt/GPO+7paWj56HdUrKSem4rpeBIIMHJ24UEvYguAP4apJovbAR
	 q+K/N5MM1iG4vf/zP2zbbXmlj1iKRpVBFLFsXnAIiuqkQQsX+uHWYq/bzrpleDOgO/
	 BW48ZtRZrWgZ11XxF9dloLjawWWFFrKdbSG9zjnYfNpnoZEkw9e+vWu8sFuGOS4+Hn
	 sw81Lu8+UE9pA==
Date: Sun, 10 Nov 2024 16:28:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix different dgids mapping to the
 same dip_idx
Message-ID: <20241110142836.GB50588@unreal>
References: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>

On Thu, Nov 07, 2024 at 02:11:48PM +0800, Junxian Huang wrote:
> From: Feng Fang <fangfeng4@huawei.com>
> 
> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
> Currently a queue 'spare_idx' is used to store QPN of QPs that use
> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
> This method lacks a mechanism for deduplicating QPN, which may result
> in different dgids sharing the same dip_idx and break the one-to-one
> mapping requirement.
> 
> This patch replaces spare_idx with xarray and introduces a refcnt of
> a dip_idx to indicate the number of QPs that using this dip_idx.
> 
> The state machine for dip_idx management is implemented as:
> 
> * The entry at an index in xarray is empty -- This indicates that the
>   corresponding dip_idx hasn't been created.
> 
> * The entry at an index in xarray is not empty but with 0 refcnt --
>   This indicates that the corresponding dip_idx has been created but
>   not used as dip_idx yet.
> 
> * The entry at an index in xarray is not empty and with non-0 refcnt --
>   This indicates that the corresponding dip_idx is being used by refcnt
>   number of DIP QPs.
> 
> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
> v1 -> v2:
> * Use xarray instead of bitmaps as Leon suggested.
> * v1: https://lore.kernel.org/all/20240906093444.3571619-10-huangjunxian6@hisilicon.com/
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 11 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 96 +++++++++++++++------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  2 -
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  7 +-
>  5 files changed, 74 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 9b51d5a1533f..560a1d9de408 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -489,12 +489,6 @@ struct hns_roce_bank {
>  	u32 next; /* Next ID to allocate. */
>  };
> 
> -struct hns_roce_idx_table {
> -	u32 *spare_idx;
> -	u32 head;
> -	u32 tail;
> -};
> -
>  struct hns_roce_qp_table {
>  	struct hns_roce_hem_table	qp_table;
>  	struct hns_roce_hem_table	irrl_table;
> @@ -503,7 +497,7 @@ struct hns_roce_qp_table {
>  	struct mutex			scc_mutex;
>  	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
>  	struct mutex bank_mutex;
> -	struct hns_roce_idx_table	idx_table;
> +	struct xarray			dip_xa;

I don't see xa_destroy() for this xarray, why?

Thanks

