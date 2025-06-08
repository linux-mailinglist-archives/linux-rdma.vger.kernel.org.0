Return-Path: <linux-rdma+bounces-11057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A1AD11AE
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F03166AD7
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E871FDA8C;
	Sun,  8 Jun 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRNL/jI/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1311EEAA
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749375471; cv=none; b=FgVk4wKsP6oiAl6FLU9E8Kaq1O05BZKGkSolgaOHYsp/WV17ohGp8l+YmyfarGo11sHu4SeROlhHJS3rd9hMfmIySZ3Hm9f7RHgF5yltPe3ogrcv+V96aDVvOyYawWpZwc75y7CaOgEzk2NEXt8WhdA45GvYc9PrBY43uPMosC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749375471; c=relaxed/simple;
	bh=+dWtZ/xi7Acns0MqVsrZxF84fuuckfyu+GMwnR6xlGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvP9GJ5CPxIhDUdC5qxGnmFM4vY+8ElPGd7lYKGC1A2qE6i88o3YcCC8hn70uB9RHI3dF6Ho43EgIBREla8PNNl6wFWO88sBuCD9+eqa3VfY/9FLOgUffFuL1ew2wQ/9BsB0qEME84RyO+BriaqkeMCpZ4vKHmUGGfM1MRGgaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRNL/jI/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235f9ea8d08so25559715ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 08 Jun 2025 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749375469; x=1749980269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E85wFTupTSAWVW7W4vqaNYmglzQJyupGRFnbCerLkng=;
        b=kRNL/jI/IWPBXIYUXLozOB5miZ019Iak+my57Y9h19LSORQnI7AwQA9H/ZT7UnToDd
         ZoWLNa7bXngZmA4ycRlduVmEFgXe73cUfz0oQ1giuiYSgtG9zfMAa8pct1LA5oXMSaxv
         4R305Ah6KjpJTI1YHzmfsfxt58cD2a3cQDh3+eCcD7fUFolKdCPJTe9SVCfTOgPN750y
         vb+n3IpwY09RajKZ6CA+Zi8BUMwiSncsedibdCtfrg9P/GFWie+8CcxsupsDy5+HJruj
         9e2PvC6K71D06UB50vFoC5eYlMSi6GZsK8MJw2fsjByTxW0MwqWvfnrg1CQ95auw2Rh6
         6wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749375469; x=1749980269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E85wFTupTSAWVW7W4vqaNYmglzQJyupGRFnbCerLkng=;
        b=jch/F5tWwmew7qhPKzvdlNN8GpHeJHZG4SrWblrkKIFbh7NsyS4nOAAk4g2766yu+k
         aKEXAumpRK0Ik+xx/b34LpNFyBzUxYX5RpaFkJ6JOXDPAUdJVpdRC5E9wjIaOPaaELKd
         yyvjx7qN/lqXqVcYFHR3roGQPjkm5THmRtT7LEbV2fFWdjuLiiH03VFA/w/Qx2ASIUK1
         MkQTpsahUWd3ei/uJhk8fAUtuk4VrAX0FpoqI62mLbWWyRReV+pFE8InIoLOcfIsWnIc
         n/FOel/zyN4EBbi3OyP2tBLEjdkqpviPkllmBfhzg34vIdIbw6cyyzzVHE91bRMiyQq9
         JFAg==
X-Gm-Message-State: AOJu0YwxVuQxjnI7VNzLBIJrwYmA/qH92LK7ymWB/WeMBpJSFUQYUZXy
	wcUL7zxm9jOkzo463k+wCKTS4ewyPy8R72MtFZac9csatlBtzju/iy0Sw3bnaA==
X-Gm-Gg: ASbGncuROzI0YybBmjaHBYzT2E9/SDkPJ6WxkFmcbue30j3TMEYRxt6DcfjFZiseLFl
	mHg4T0xvum6zuUHwjn7GQblyl6U2HeEoWWgEMFPq7TGtmMBgRPcrc0xlI7N8R1QF27ylZyhoRwV
	QLya6G/Enow5FeaHM4dezMQJVirPefaePXRhWhKvkKbSpuaeR8MDZofI8+S6hD70eErq3B8/eV4
	JtcZuYS1CteRzw50J/m+BOOEr6tSJUiO3IEyH/zFpl7YACiEGHUOiOy3V3AsIZU08gC/TuRiCgK
	LAm/xMfpsRbonFnzJMEu1SB24pSrnqkzCUFDUIf7j0XMH+gd8oV6F50DvyobInvig+IeHXb33OL
	1SoO3DowlQtCnsz+bEQdb22vy2aA=
X-Google-Smtp-Source: AGHT+IGIx3BGDQMjW1gJxEGr5UguNgQsmHFzRNzHTuKZAFMujeCE3Pgu9E7xk/AA2LDyLVlerbcRJg==
X-Received: by 2002:a17:903:18f:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23601e21f1dmr138138365ad.5.1749375468983;
        Sun, 08 Jun 2025 02:37:48 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fe271sm37041645ad.128.2025.06.08.02.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:37:48 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v1] RDMA/rxe: Remove redundant page presence check
Date: Sun,  8 Jun 2025 09:37:23 +0000
Message-ID: <20250608093723.3132-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
should return an error in case the target pages cannot be mapped until
timeout, so these checks can safely be removed.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index dbc5a5600eb7..fb88f2901c58 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
 		user_va = kmap_local_page(page);
-		if (!user_va)
-			return -EFAULT;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
 		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
@@ -286,8 +284,6 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
 	idx = rxe_odp_iova_to_index(umem_odp, iova);
 	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
-	if (!page)
-		return RESPST_ERR_RKEY_VIOLATION;
 
 	if (unlikely(page_offset & 0x7)) {
 		rxe_dbg_mr(mr, "iova not aligned\n");
-- 
2.43.0


