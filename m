Return-Path: <linux-rdma+bounces-10531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D761AC0AB5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B5D1888E10
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A628982B;
	Thu, 22 May 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Cq7Okl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0C1C32
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913805; cv=none; b=k/o2rOFkyPJKhCE6tNhdS5FM7Oq5hTicAkV6C8eFSXk1d9ThTaSumJwHZ/zm0DazBP7UgOuXYU9oL52dSnDJSIfjq+J+HnbJW2uG/RbGTyQp0pOmrWYD9A58jrB5ZrU++bAJ3jl+xWKB1Lgc1T/btJ4vOi4NQCoLCVcFOAoA8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913805; c=relaxed/simple;
	bh=EDGCT34bwJE3mYIR1yHvvib35gF7eOmHgclVlWziu7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ji0au43DEZaMy79ds8Kkbt8CkoXT7uX7sjOAEDKNXOxTG4N1gvFUAiRiJ1zIqdcvbVbS4sMOoR+7wyBVNC536AMDxhQSY8c4lr9EhY9upvAb3+fhklO/Fpo3fMVlzLynYU265wa29LWK5nr5fytdihuIpBeRAxLgTt/Cq1rW2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Cq7Okl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A89C4CEE4;
	Thu, 22 May 2025 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747913805;
	bh=EDGCT34bwJE3mYIR1yHvvib35gF7eOmHgclVlWziu7o=;
	h=From:To:Cc:Subject:Date:From;
	b=i7Cq7Oklv8IYB3UgvXTnZPPSok7UuqGVx8sN91GpEm3alvMv1bGzUtWs1lBbfWZjO
	 ggNdz0csmPC0GD99mFBFSVN0EZLRkPnpWaySS4rB7Z1TKiEp0po5adyRa8/TAM0hUR
	 palSHwmZKMogMbTv8FanuDFrbBmcK3VjIwklktZ3+gJqwlA/0O+N1hDdxqFJVZypsg
	 w5XksVdawLaiY0YlRTcboT9YjKsMdCuQUpWeIuiTpLg3+UqBFsofo8e956I4cCItKz
	 vOKBdWtVU4tbFofXE/WbsAfwRdV341uJQVV+8th3848TQjRZskQppnL6ri9WaFLkoZ
	 AEgxrbo6JTQew==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>,
	linux-rdma@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO pages
Date: Thu, 22 May 2025 14:36:18 +0300
Message-ID: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

RO pages has "perm" equal to 0, that caused to the situation
where such pages were marked as needed to have fault and caused
to infinite loop.

Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index a1416626f61a5..0f67167ddddd1 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
 	while (addr < iova + length) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 
-		if (!(umem_odp->map.pfn_list[idx] & perm)) {
+		if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
 			need_fault = true;
 			break;
 		}
-- 
2.49.0


