Return-Path: <linux-rdma+bounces-10678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D6AC32F6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845B47A58CE
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57F190679;
	Sun, 25 May 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJd8osIj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DB1531C1
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748162688; cv=none; b=j95jSx0qK+LQXx/hfxasVddlYg+2VeSml8bpydqEIq4uOqf8Adi3qspo9+w5SwgqFYH2K1lv/BaFAT5QBrPz+P55eiR9DiX0dcVxX0B75QNiP2f9oxnOoIQKAXS+B+e8awf5gEbMDSBnEIjBFevtux3ZUfPLd35q1i14yIbeN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748162688; c=relaxed/simple;
	bh=4b+kH//QGK2xq/9suWprev7XZAd5J5v6P47MOdztpI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mzVs2ppCOxAtYYMN5lLLpa2oblZv1l5LfwB/5fu+MEZoZTcjfZblHbirmZp9VTjYcQOPreDztopm/+/lpVtb6uhGLyVAeN+wWs+cMihjQtpq9Quss5Gc638MqmC/Erdy4IgYXEmAWuOl/9qROqv+cNmY9rGjdTPyM4ee2CpDxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJd8osIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C8AC4CEEA;
	Sun, 25 May 2025 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748162687;
	bh=4b+kH//QGK2xq/9suWprev7XZAd5J5v6P47MOdztpI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vJd8osIjaGjTyGD8PSEn6Iyldw0c6V1FS9pdgfseJ5f9wahMsVNEaD9HzMvyXZiZ+
	 hahQAcPcGv7rLsziGDThBjUEAC0uegI3F9elcu0B34gy9ZAm9CqTSrFg366HRGRJTR
	 NRYwBNCZmWDI3wqzhr0kn90hdMuG+ZPS6juDiFAgqNBSukY1dkvFxvF0Y+k865au6y
	 AiCYifpJvd8uGnEgfApU5Gi9cb9ME91wZd7+Ij0a9OjZQbkorP5PQxozR03IhTPkWI
	 1zoR2gdQNFKu9yY+8bHC18XAylWaTDN1IAzA05azPq76YfN7nQPOqEsHUO67yFr37y
	 rLL6vbSMEpWyw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250523023433.2171003-1-huangjunxian6@hisilicon.com>
References: <20250523023433.2171003-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix endian issue in trace events
Message-Id: <174816268412.1195729.15725392522385671964.b4-ty@kernel.org>
Date: Sun, 25 May 2025 04:44:44 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 23 May 2025 10:34:33 +0800, Junxian Huang wrote:
> Avoid using __le32 directly in trace events to fix sparse complains:
> 
> drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: cast to restricted __le32
> drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: restricted __le32 degrades to integer
> drivers/infiniband/hw/hns/./hns_roce_trace.h:48:1: sparse: sparse: restricted __le32 degrades to integer
> drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: cast to restricted __le32
> drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: restricted __le32 degrades to integer
> drivers/infiniband/hw/hns/./hns_roce_trace.h:90:1: sparse: sparse: restricted __le32 degrades to integer
> drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: cast to restricted __le32
> drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: restricted __le32 degrades to integer
> drivers/infiniband/hw/hns/./hns_roce_trace.h:173:1: sparse: sparse: restricted __le32 degrades to integer
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix endian issue in trace events
      https://git.kernel.org/rdma/rdma/c/7cf155310f14f9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


