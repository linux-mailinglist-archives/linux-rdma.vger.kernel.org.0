Return-Path: <linux-rdma+bounces-15289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60118CF10B4
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF42C3043F6E
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3156298CD5;
	Sun,  4 Jan 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE2ElZiA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF93221721;
	Sun,  4 Jan 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534729; cv=none; b=MuvV/J7/iQiiom49FUUOtCFRGWUZeN26ehHGsKy1zOnia7VMDtU2AucsdOKBSEGL3phm1u1BymmMg5oR1C0PhnnMiy8sRv7TkjiK33AF+SWq7ce95sdCv/fB+BBUlmWAnYPv83RO2VhYa/70cLq54d7oQoCcDoTWybOQElTlZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534729; c=relaxed/simple;
	bh=jENC5axotUMMRBSPnZ2/0la2N0qC/blZRxffKg8xvjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJPrTDEZco8m65M4umeZ5hHvwHs/Gv57bkEqOM+5WFr8n+/EIOuZgVGOH+JTOJQudPM/qTcvzJvELdFP2FM5F/wu0ZpfKTpFhIJs0uk3qt35pMJXYyhti4NVq/JleGx4y/yaC9ZaUQKWB/f8I+nhYlwDfNGYgd3Vnnaeh4MNQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE2ElZiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9FEC4CEF7;
	Sun,  4 Jan 2026 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767534729;
	bh=jENC5axotUMMRBSPnZ2/0la2N0qC/blZRxffKg8xvjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uE2ElZiAmoYT9Jv13jCgvJgZI7PvkTr4iVVtKja5NZpGIlsNc8B74q9SKRokBy87n
	 JxVQUmz9rbUZPJlwawg/C831ZKIRFqz4Rv+PkalUSJWVIjPSIYv1je8WCZqEOPhaEW
	 BusJLnLYEa5pAzZQGRAQhOWxdilo5fnzDjUXub7cwzSiu6RJs5Sa2aWBic+sYGyTTU
	 fPTYom8fZLI76sihAnpjAUOvHJ4n1KQD+o0gVjHB9CtJtKS8RCJgfRm3tgMzulEIWE
	 ICyUNblHpPJuiS1s6UerHUL1MAQ14SOMsJc64rvLXE9T+g8FKS63slVuKsFCD+IVzq
	 hss21UI8yLBdg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 6/6] RDMA/ocrdma: Remove unused OCRDMA_UVERBS definition
Date: Sun,  4 Jan 2026 15:51:38 +0200
Message-ID: <20260104-ib-core-misc-v1-6-00367f77f3a8@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
References: <20260104-ib-core-misc-v1-0-00367f77f3a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The OCRDMA_UVERBS() macro is unused, so remove it to clean up the code.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
index 5eb61c110090..5584b781e2e8 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
@@ -67,8 +67,6 @@
 #define OC_SKH_DEVICE_VF 0x728
 #define OCRDMA_MAX_AH 512
 
-#define OCRDMA_UVERBS(CMD_NAME) (1ull << IB_USER_VERBS_CMD_##CMD_NAME)
-
 #define convert_to_64bit(lo, hi) ((u64)hi << 32 | (u64)lo)
 #define EQ_INTR_PER_SEC_THRSH_HI 150000
 #define EQ_INTR_PER_SEC_THRSH_LOW 100000

-- 
2.52.0


