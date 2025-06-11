Return-Path: <linux-rdma+bounces-11207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534DAD5C20
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CFD189C8B5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A881EB5D0;
	Wed, 11 Jun 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6zzHJdT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC81B0421
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659332; cv=none; b=cncfIxsmi2/x1wuCxJcmNafCRBZS2pJ8wxO3rdnrMjDrjVpQFLTQXMo6FYeNExzAIOJtjKg7tamkeGjGs24p6dqKGZxFZBAge4iDG4k2e+S97ZYEC8TAvF5Jv1ib7lLOAzTwt/e6MNtlE0x5m4vI6jXLi/9vsd5+NaxzWiQY0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659332; c=relaxed/simple;
	bh=+cNbzIgDhMeuwAkNzi/3fc6nZoO14RYP9J4c34j0cgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsRg7Zl4SbxT7+mBLsLtKL26hOtV/zJGw9bQuETC/6QMGScjYzse/j5j4xZMzHMhNp+8hn6MwfD0G7nzwjdlR8e7ZekPt1duJWkrLpSrpsGjfBAM8FA9QK7vW494iEcwbsisX/UoXWIniRO1MkVlg3Y4TjzD1BOvNL8zejVw/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6zzHJdT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234fcadde3eso245455ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749659330; x=1750264130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOxwJfbTjd0nhVHGDbSIDsq+dRe9mSGmkQlhPsH6Fqw=;
        b=J6zzHJdT3L/Mlk6mhQvsDgOyUu6+/4/LlruFKhRQAT2d/rKt7y9ZLtmxe8YF27zvvo
         WLnw66XSFoPJVXePUAKKl4/mUkFJ/27GS7caAjcTE/9wbmtXxAH1tphkFUEvItqksrud
         6btIBjIlhPXsQf6A0tk1Fh0uBqmWNlIx2ql2aKD6/osDE5yvYGbjZgJlUU4XmwFVE8LM
         rc6zyBtDoRw5d8iIX0vohu0njPID8z4NQxlCtKlkAdSJ3fGABxJYykNE8hWotZ59yrp7
         2rn28j1L5bhgwsaK0SN0LyoVozZ6TV8sGPAfSUqZ+MY5BQgoZEJztZeqJQsuVgtbc9G9
         W5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659330; x=1750264130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOxwJfbTjd0nhVHGDbSIDsq+dRe9mSGmkQlhPsH6Fqw=;
        b=hfuZoGUqjUvRKXrjoy1gszSX6A2nn4HVXqUlcP/mnvlU7jKXL7KWTxaMxCob5WTAxJ
         giPuiKGpoJ3FFKiHVsqApOYM0TPLSx1g4x2JN4m1PzhbGHXiFTa462x1IphJR9o52+tN
         Dkm6eQCzLfrrNmIwAIFjQ142mUL0Vt+aII1JF7Itvj7RxO9TZh+S+tTKptFmLRCFotxU
         zvLAy6mwKuje/opSY0ewSrTpTxrSmHqUvzxk0oBj3urLN7TH1NbRZtIK/LqK7wYA8qxk
         fcuO/hpjIailMUp7WYoTiHy5q77QO3YzU+bg7MPpuCIEowZfGPrqT9mlnuU6gPTFU1DX
         uDUQ==
X-Gm-Message-State: AOJu0YzCs3DICAmH0o618hDwjiipvUDORxqgTUB2DlLiWUy6j0WW0xnW
	aQgQaNen4UOevG3WxgbH6IUYqze3EjsXmlrqvonzzCZ/Z0i/C0+vD+cQKXcJiA==
X-Gm-Gg: ASbGncsfMHTTZGqwKJ+XGHZQvkg45rFL13mnT0E1c2GxEY0eA6cenAA0DRGxQkbuOaQ
	o5t54msjAnTZiydj6TH/umuACbnI/zbXuBRFyWqEtao5BcDFMJmyoxhmeOHFb7Ux8Wa4EMxcxjc
	4z+URzP3WfO3W9uvtJk7hA8qto8oOM+4DKOyGjXpDStqLTyybO+H+L7WNV71EQp6SUOaLd8s5R+
	fGtYBI0wrZZn9wyNcU1kdGmDPywDKaIHPMwbM7/Zs+V3ekgoM/t3lJe2ROMuywIdBGjwHAL52mz
	2b9HYxUZIf2TzqGLmt3PVUcvfBkA+2YL1iKu3Z+DEKXb+HuxmwM+qtHBBcR+zrXX8UIjhq96BL0
	ynQnSkuiI8U4QrxgtrA==
X-Google-Smtp-Source: AGHT+IG8NYUM4M2OFle2MllOfekS+tOoMbl7qKrnwgk0/VZuKTF8iBufeRINmR7fgjNSPAHrSEIYVw==
X-Received: by 2002:a17:902:f709:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23641a9c9c6mr59451155ad.20.1749659329606;
        Wed, 11 Jun 2025 09:28:49 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030968c9sm89871125ad.87.2025.06.11.09.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:28:49 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next v3] RDMA/rxe: Remove redundant page presence check
Date: Wed, 11 Jun 2025 16:27:58 +0000
Message-ID: <20250611162758.10000-1-dskmtsd@gmail.com>
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

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>

v2->v3:
  - Move page_offset error check before hmm_pfn_to_page(), as suggested by Zhu

---
 drivers/infiniband/sw/rxe/rxe_odp.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index dbc5a5600eb7..0846bd972e15 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
 		user_va = kmap_local_page(page);
-		if (!user_va)
-			return -EFAULT;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
 		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
@@ -283,17 +281,15 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
 		return RESPST_ERR_RKEY_VIOLATION;
 	}
 
-	idx = rxe_odp_iova_to_index(umem_odp, iova);
 	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
-	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
-	if (!page)
-		return RESPST_ERR_RKEY_VIOLATION;
-
 	if (unlikely(page_offset & 0x7)) {
 		rxe_dbg_mr(mr, "iova not aligned\n");
 		return RESPST_ERR_MISALIGNED_ATOMIC;
 	}
 
+	idx = rxe_odp_iova_to_index(umem_odp, iova);
+	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
+
 	va = kmap_local_page(page);
 
 	spin_lock_bh(&atomic_ops_lock);
@@ -352,10 +348,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
-		if (!page) {
-			mutex_unlock(&umem_odp->umem_mutex);
-			return -EFAULT;
-		}
 
 		bytes = min_t(unsigned int, length,
 			      mr_page_size(mr) - page_offset);
@@ -396,12 +388,6 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 		return RESPST_ERR_RKEY_VIOLATION;
 
 	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
-	index = rxe_odp_iova_to_index(umem_odp, iova);
-	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
-	if (!page) {
-		mutex_unlock(&umem_odp->umem_mutex);
-		return RESPST_ERR_RKEY_VIOLATION;
-	}
 	/* See IBA A19.4.2 */
 	if (unlikely(page_offset & 0x7)) {
 		mutex_unlock(&umem_odp->umem_mutex);
@@ -409,6 +395,9 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 		return RESPST_ERR_MISALIGNED_ATOMIC;
 	}
 
+	index = rxe_odp_iova_to_index(umem_odp, iova);
+	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
+
 	va = kmap_local_page(page);
 	/* Do atomic write after all prior operations have completed */
 	smp_store_release(&va[page_offset >> 3], value);
-- 
2.43.0


