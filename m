Return-Path: <linux-rdma+bounces-1714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B28944AB
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD551C218B8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA524E1D6;
	Mon,  1 Apr 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhgXf8dQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840F1DFF4;
	Mon,  1 Apr 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995130; cv=none; b=meirY1EJRqXt54mivkmSvNYkc7jztxWNDk50SJXATlouxGprlSJwttW1MtxyroOtSg1LlVfZ63nH9uU4YXloZiUioOo2wWN7aa6V+9vVA2H//w6zJoPTWiaPSidNblKuhGvFLknp1egce46Igt70mNq10PQ4b8D5eFrpZTi0im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995130; c=relaxed/simple;
	bh=A411EZgHmp3c7197ZJ8Qjf7fYUtEd7pYUVgTImdegQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ8Thu65qol34gkHDNEMckPCzFFvh8GyUR917Fo/yJ4qC7+ohizbLvejCfUB6K15UxNLp594p07/CnOsCX7iDVRK0fq71GNeWxhGle0YIN7WcCmzvSFBPkaoU/0aK0wL1qGgxdP3zDCJsK+wBRBS4Kt8Ki4WQQd3DcuK1cDLIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhgXf8dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7382C433C7;
	Mon,  1 Apr 2024 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711995129;
	bh=A411EZgHmp3c7197ZJ8Qjf7fYUtEd7pYUVgTImdegQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhgXf8dQulqZp2bP1mzKG+Pjd43ns3WWeGfnhAl0MSNCaPBmZgrapgQrZoTkW1p1w
	 ZxThyPNZFR/PFdFbuRVqbXPJu6xabPMwYjyAnxk+eBcMqxhGOz2yCPbURsOM2Wbf3k
	 yY3+WPmwVuNDKn84POxrGHrxjKkFovrYu+ubnp1Wzq4Y/983zWWm3InQlsDioZe2TB
	 0uBjdXNn5zkru74U2xTNWp1b8KGuryOUqxiS0RpcWAoixaDObLxszIoJLf/LQt0HhU
	 q1mOGR53BjNkh518I6hudTkLTfCgZ4Cb2dxjXFiAtsRqYd21RVmvS6grrchYUV1Wak
	 Gz37tuHUN30XQ==
Date: Mon, 1 Apr 2024 21:12:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support DSCP
Message-ID: <20240401181204.GC11187@unreal>
References: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
 <20240401114853.GA73174@unreal>
 <1f786e1b-e8ff-1d6f-7c4d-89724eda6712@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f786e1b-e8ff-1d6f-7c4d-89724eda6712@hisilicon.com>

On Mon, Apr 01, 2024 at 09:25:39PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/4/1 19:48, Leon Romanovsky wrote:
> > On Fri, Mar 15, 2024 at 05:35:51PM +0800, Junxian Huang wrote:
> >> Add support for DSCP configuration. For DSCP, get dscp-prio mapping
> >> via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
> >> UD or in QPC for RC) with the priority value. The prio-tc mapping is
> >> configured to HW by hns3 nic driver. HW will select a corresponding
> >> TC according to SL and the prio-tc mapping.
> >>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 32 +++++---
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 86 ++++++++++++++++-----
> >>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 13 ++++
> >>  include/uapi/rdma/hns-abi.h                 |  9 ++-
> >>  5 files changed, 117 insertions(+), 29 deletions(-)
> > 
> > 1. What is TC mode?
> 
> TC mode indicates whether the HW is configured as DSCP mode or VLAN priority
> mode currently.
> 
> > 2. Did you post rdma-core PR?
> 
> Not yet. I was meant to wait until this patch is applied. Should I post it
> right now?

Yes, for any UAPI changes, we require to have rdma-core PR.

Thanks

> 
> Junxian
> 
> > 
> > Thanks

