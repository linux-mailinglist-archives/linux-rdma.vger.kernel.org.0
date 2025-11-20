Return-Path: <linux-rdma+bounces-14657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A577C74FF1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FF4F12A8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC830498F;
	Thu, 20 Nov 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTy2iFCB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DC33C521;
	Thu, 20 Nov 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651725; cv=none; b=u6nbYd6YqDdiOgZtYd3di/Qp66sgN6W5ittWGtuWXhLFWbwX1MubFU7bESf+P+aFt9ZC8xlJ+IwWOzsLFwZzUmjCGGbWvu0MfOM5NnD4PlfWUWn+jIUlYbzXUv3S78Nv08pJe06TNfDhF3iM1BL2l5ri2iQU/dGNDkWDF5g4//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651725; c=relaxed/simple;
	bh=X2LclfuGi2ToBZtM3Eh7iUP+PW192X8dQLDR6eYAUGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9yf5ZaSglKeJmgNTlDsf+4bYD4w36/bGNkwFFwgGAJHWAnHlimN75b1u2/xEhmzdjMKUJrycOcZ8U+LFZ1/gL23G1IgwDpxPj4qz48hi0N0w+lJaNzU4aRhRPkQQwsrgAM906I6IQlEK2lK219SaXgXn+kUu6fPDOtbJXMioaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTy2iFCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F5C4CEF1;
	Thu, 20 Nov 2025 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763651724;
	bh=X2LclfuGi2ToBZtM3Eh7iUP+PW192X8dQLDR6eYAUGg=;
	h=From:To:Cc:Subject:Date:From;
	b=KTy2iFCBGFzXc2UeV6zFK5TFddpO9lL/Y5A46DcUnrQWmRl10TOdmNh3weOtz1qMv
	 odOe1ATxCd59PE1khlBllIdjeA40vUwSo5oHyNmtJOBq+u5pw0rV4vTc6ntFNjG1qI
	 6/ZdJmWibTWEWZZ7+dge0ZbTxaLkawQ4sCU9q3BsxqIlF7X+nwPdAM7q0B0iMsK7al
	 5hgeBwDShss6uhz2rU/mQT0aJur9YSfLV2rfIP1T6n7+MlITvNTnfSBxrPlFTrQmzR
	 yQ7UCrYUh1Oq0A3GeDL0q7qn+OGNOOM94qAh5F6aqWR7fYp2l9HRzhoNZtD9IvGQ8G
	 +72DwVr+RhJAw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 0/2] Add new IB rate for XDR (8x) support
Date: Thu, 20 Nov 2025 17:15:14 +0200
Message-ID: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251120-speed-8-bc95d6f7d170
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

Nothing super fancy, just addition of new 1600_8x lane speed.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Maher Sanalla (2):
      RDMA/core: Add new IB rate for XDR (8x) support
      RDMA/mlx5: Add support for 1600_8x lane speed

 drivers/infiniband/core/verbs.c   | 3 +++
 drivers/infiniband/hw/mlx5/main.c | 4 ++++
 drivers/infiniband/hw/mlx5/qp.c   | 5 +++--
 include/rdma/ib_verbs.h           | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)
---
base-commit: d056bc45b62b5981ebcd18c4303a915490b8ebe9
change-id: 20251120-speed-8-bc95d6f7d170

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


