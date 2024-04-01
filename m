Return-Path: <linux-rdma+bounces-1701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B8893AB6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8B9281B7B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAE219E0;
	Mon,  1 Apr 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcs8EFpf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4BD26D;
	Mon,  1 Apr 2024 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972137; cv=none; b=kKrgoJZVf/gc/xNhFP4OHcFVAamIwWJEnq4Okuxxlytuvr8xSsV9osmkGo6ohJUAPFR6Ta73r7GVtG8hHjSE6h0lSkk1dyCYiLggId5f8Cc400pfC606+zu55sk5Nmi8OmAGLPK/HsEuTGcgDZBgTGPW4dly8CZTenGKv+nGizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972137; c=relaxed/simple;
	bh=pCIf/4JC3Jz+ajCP9yLU5DVCXUIXygecRnTv9SJ1/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqO6Bm9OzSY+NBs4TuQLa9reXr1knU9on1q/cL7i/JjkQxYbszPlD7N8HEvMlswY31reiFF1IimHYyJds1d8AS9q8tK7oNIdUeoMHXS2OgPv8kN4DXt16+HlksRl6qFrJPwrcLDk67SUDjADvcOelFLLJRqG5rNkiXV3ZOU35nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcs8EFpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B07C433F1;
	Mon,  1 Apr 2024 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711972136;
	bh=pCIf/4JC3Jz+ajCP9yLU5DVCXUIXygecRnTv9SJ1/Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcs8EFpfbw6zrCYqHYrhBQhB3RLk3U1DdxllVf9G4y9QG+eWKlBs3juHWGNg1RanN
	 On7Q1LBmtdahanBGKGoGeGDbytgqQ4N+aA1/2MntxhRyFeW65v7RptykINzPDNjaY+
	 YXb5kUqDQFdO46SOVTGNYgkYujzOErVE0D4pUObvoe5nXdYs8LsriKrRwoxK07ftyI
	 Ivili8Yt7u9ytkky4JO2cTWP8tQNKjoqAFvk8QcthuTeRwLHPBJRhJAEB7cg4VocWu
	 WMJZvbl/z2goaN7xD6EbOlRb4W00JZAek8M1VEo5YdbzzyoW7XmX1QLqbiA9I5TZYF
	 7jvgjwFvgRI/A==
Date: Mon, 1 Apr 2024 14:48:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support DSCP
Message-ID: <20240401114853.GA73174@unreal>
References: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>

On Fri, Mar 15, 2024 at 05:35:51PM +0800, Junxian Huang wrote:
> Add support for DSCP configuration. For DSCP, get dscp-prio mapping
> via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
> UD or in QPC for RC) with the priority value. The prio-tc mapping is
> configured to HW by hns3 nic driver. HW will select a corresponding
> TC according to SL and the prio-tc mapping.
> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 32 +++++---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 86 ++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 13 ++++
>  include/uapi/rdma/hns-abi.h                 |  9 ++-
>  5 files changed, 117 insertions(+), 29 deletions(-)

1. What is TC mode?
2. Did you post rdma-core PR?

Thanks

