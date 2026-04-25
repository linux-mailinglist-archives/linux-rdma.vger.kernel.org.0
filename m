Return-Path: <linux-rdma+bounces-19540-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO/nCUQW7GkKUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19540-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:17:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F04646B3
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8B393005AAD
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02FA1F192E;
	Sat, 25 Apr 2026 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eANfOi+3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B031D514E
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079871; cv=none; b=gvgkfqRFbJvV439f2tLmbr0Q9EwIKy24Hq3Iwf6WLjDL0GAiR2CU6a7g9qi2xlXNLIGa1pBFSaMYomgPet9ZNCMSUPmVnPyMvAn0koWql6fv0tPvUOIpMZguE5KdYcj3Q/eGUfX7k1EMQc4N2Amwo28z8ST3jE0fE0u8y6xW04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079871; c=relaxed/simple;
	bh=j1GqOGyw5FPqwJe4InJ5sUFWXvL/G1NJ0Gt5UZ/j/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkBrkhUny3eu0Ac2woDXFh8xEd48rIMQBoVtboesSSjJXZsfIFDVaA7T8r1YzSjF25gNGbHZlQFSgvfY6FtaQygVQE+HYsuq024TapXV5/r8kqi8SKq+lM2WgZEHwMO/+WL3vtIvZZTBdOCnLqPswyN6/3+xXaybLohp36J6YUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eANfOi+3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso115354515e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 18:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777079869; x=1777684669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8R+K/lrchlEuKESbig6vaThp46zt3bXsNQE6bFQm4Mc=;
        b=eANfOi+3OdF7eiZ+Wh3gMqjHYyIKe6ErGg1Qa//qNHUM9tEn8HxCfEELkJnQ0v/dGi
         2NG0br8V+sqhhaTt4SZiUdkfxWlcZfVr4NXIekD+p1zZLZ0DVfmjReNRebIXLL5dicwN
         SfLYUn929EgkyJxfdwVLYf1paO8jNmRiMMuGoEroO14oww4RiRpjntmOPv1vOkcqWWBz
         TcCT1JDL0WKDzi92NKNJoGeCjQbSEINw74xbkSDyyqsUQLxPmUxHAmiEPNo8Vi4KejUS
         wt9RfTmybYuwbJeWLlb8zCFesm+xD93cV4a8UZavbXSgDBnQfpyznuh8ZqRowX+6gaSz
         uTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777079869; x=1777684669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R+K/lrchlEuKESbig6vaThp46zt3bXsNQE6bFQm4Mc=;
        b=UoEfB+d47PCXTI0zsRtMoM2Ea/UszHwD/n+2Fs9S3PcHjsZ7I4Lgc7NBXN6TP65ohx
         RAiSV/Woy/muRsy3tQbE7h+m8aEqlm/CIgtVz3D5M74g/ul3/O/W6owSWbyA3iUzK9eL
         C4RgXGc371i6OYer0ptavCP/RNrz4JZkBfwSy+OjFHCnJRNNcCHO/0I57s+Q4yP+OxzP
         hx+pHCay9kNo4Hq/1JTMZ/Y3jaoCStD7vmSp9+Gm4HYmtmiyU5mUmt14OCFAgYBFrPXd
         sKiIhwe6gRz5JXgVcM8AtT9UhwFqWqKr2NMqWSgloEi6WxWRVkU7rhAc4ExlaiMBwQFe
         z0MA==
X-Gm-Message-State: AOJu0Ywitj53CrOzfRYRSHAqCbhVTsdn1iz1C8aSXBbuMjaTqKG3Ilk0
	MW+JVr4ksHTbNteleJczbeZab7ekqbaQJCQCuPvugAhXujFKnXXCeCih
X-Gm-Gg: AeBDieu0lwXERaqBFzKZlND5p6OBOwUxZ7su1JgCASJDwv3xoXJNnmQC+Javl/XmL5p
	AmkROKQqEUa4E0Wcj/t38ckcXkBPlHc8sS/Le+l/Qrl08dOg04jHWIZZm30SC1Nb+ix1pucSGEk
	kmeCwSI43H68VrLB+ff3Qs2tjRcTFn+fVExy48VYjXdYQyND3NbnhrIiosksP2KdAr8DGc7vVSZ
	WA1G6czRERdn9mJwfybp8EDQuGay/2+DeRC+A0sdltPRkrJJplWoGXKZXOH2bV5s01yqh9kgMwI
	AXrfY3/cSh4KEDkVbK7EY8qS29VZyKUROHilkYpcnYcORnkn445AlXf/ybqfTPmv3klfWmxvKJt
	pV9+dphYqNX/aF5vDGHbhMgG+P1UnL8jGOmwxI5XENCIlo85Ep/CWkz2Y27QwrSA2OLTKwdw0f5
	f5EboatsnUFaAU2UvQRR0+PLu8d+qSLConXhSxHjR+gtP4xJDfxS4KbmLCGtsYRPzONTknsSe82
	8B5JIrfEQ91Rey7a3DAzopS5FPbDw52PhlcwfVSiQ==
X-Received: by 2002:a05:600c:8908:b0:48a:58e1:6d02 with SMTP id 5b1f17b1804b1-48a58e16eb2mr176025505e9.19.1777079868565;
        Fri, 24 Apr 2026 18:17:48 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm350796605e9.2.2026.04.24.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:17:46 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH rdma v1] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
Date: Sat, 25 Apr 2026 02:17:28 +0100
Message-ID: <20260425011739.21557-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B89F04646B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19540-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

mlx5r_umr_update_xlt() allocates and DMA maps an XLT buffer with
mlx5r_umr_create_xlt(). The buffer is released by the common cleanup path
through mlx5r_umr_unmap_free_xlt().

After mlx5_odp_populate_xlt() became fallible, its error path returned
directly and skipped that cleanup. This leaks the XLT DMA mapping and
buffer. If the emergency XLT page was used, it also leaves
xlt_emergency_page_mutex locked.

Jump to the existing cleanup path instead of returning directly.

Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 29488fba21a0..14ed8e8182f8 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -915,7 +915,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		 */
 		err = mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
 		if (err)
-			return err;
+			goto out;
 		dma_sync_single_for_device(ddev, sg.addr, sg.length,
 					   DMA_TO_DEVICE);
 		sg.length = ALIGN(size_to_map, MLX5_UMR_FLEX_ALIGNMENT);
@@ -925,6 +925,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		mlx5r_umr_update_offset(&wqe.ctrl_seg, idx * desc_size);
 		err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, true);
 	}
+out:
 	sg.length = orig_sg_length;
 	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
 	return err;
-- 
2.43.0


