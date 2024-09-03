Return-Path: <linux-rdma+bounces-4717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2324969C1A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B931C23458
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE51C9871;
	Tue,  3 Sep 2024 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCiuNqMj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443321C985E;
	Tue,  3 Sep 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363479; cv=none; b=cO+QVfQ4wJyRQcQNLcuZpzWDKwP8anM4dQEWjN32//qAheYlgJKWuFRC3go4fRj59NfFQB2EpH2MtBxoAkF6wSGdspUQ0AcxfU22AAJfYzxiCHSLEjIOJh/k5NsDSKpk5NcHQmGncLD74YWIazz7u053OxaD705FzVneazXxVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363479; c=relaxed/simple;
	bh=VU2AL8gzcAybPFd7XKWxlWyUsR2cBFvhtk6ksKQLrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCac7GcLInRO8UuhsyRrjR105adZBDidUZoX2BtT/nyGzy8+IH9sKxSMEy2KSc95pwcC7lyluZ2FziB72uX4Lvw8wygad9vrRANG/wVLTIuYP+KY3ZFqcoY9IChz2sxUJbh7qTeo9QYrCYlAH23f46t451mx+FQS4q8+/nuW0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCiuNqMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AF6C4CEC9;
	Tue,  3 Sep 2024 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363478;
	bh=VU2AL8gzcAybPFd7XKWxlWyUsR2cBFvhtk6ksKQLrzE=;
	h=From:To:Cc:Subject:Date:From;
	b=vCiuNqMj4S1DjlGb8QrFwRUFzUWtNk4ofN1z9mVkzPfpG1uhrCd0zV4Vb6nvB10Th
	 UbOnbAAHZezXfVQrFm/nj+PuIV9Wtejw30sfeXpfKshJnYLQ3lbmxOxdF4GidyW+/Z
	 Ny1WY2LZFdOHdMN1YHEefCWop9ZlMTchSz9lXkeTPDJftdU3YqfAkqb11as29gz2+O
	 4CcBcbyENqYuSWEXSKwtitgDaol5A1996nnp4VCQri46h+3P6+4UpGAHRxl6vWNc0L
	 TVldKSAp2Ln2ssm9uuLA1Z2AZuXUC/vLD/aeGs1SwdADMbUNH+SGO3uiYHGtGPmpTG
	 ypqu0cMfh5a1Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
Date: Tue,  3 Sep 2024 14:37:50 +0300
Message-ID: <cover.1725362773.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Edward introduces mlx5 data direct placement (DDP)
feature. 

This feature allows WRs on the receiver side of the QP to be consumed
out of order, permitting the sender side to transmit messages without
guaranteeing arrival order on the receiver side.

When enabled, the completion ordering of WRs remains in-order,
regardless of the Receive WRs consumption order.

RDMA Read and RDMA Atomic operations on the responder side continue to
be executed in-order, while the ordering of data placement for RDMA
Write and Send operations is not guaranteed.

Thanks

Edward Srouji (2):
  net/mlx5: Introduce data placement ordering bits
  RDMA/mlx5: Support OOO RX WQE consumption

 drivers/infiniband/hw/mlx5/main.c    |  8 +++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
 include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
 include/uapi/rdma/mlx5-abi.h         |  5 +++
 5 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.46.0


