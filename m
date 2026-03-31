Return-Path: <linux-rdma+bounces-18817-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNQCOhsby2kEEAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18817-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:53:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBD362E0D
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405093063A15
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5C2F5A34;
	Tue, 31 Mar 2026 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTnZYmKF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086B23A9BD
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918156; cv=none; b=fg3UL9MuhRA0cU6qvn+BPg4HhI1t3QuFzESwiFK5HoZFmOP2vRK7y9jd4obmwkIkp8XYKYIP4/mJzCU/B6PqxcVugPYwZzETK85jggUYWnY8yO6A5XatcEq/WqQGq7up9DGDMt1Wy6k9drS02lRksXPpssIzo2aEQTZsHN2cwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918156; c=relaxed/simple;
	bh=iPj1esjPyQMuh4WUKLUVr6cUL4OZykR8gDVx+T5rnLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkx7mQ+LYxjYCY+GCTMAiru+fSuW6f1mpHz7r1V5cYF8Ud0LrAVekHsxnMRkslz5ULd4OK7tTRWyMq3KJe8sTUk38bgIcBdHJNe64sWzgHvHMeOeuEps49WEzjnAJp66wgaMA6C1dBCYBHOZAGpQudeM57KSNUBdw3QMNdoj18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTnZYmKF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1193613f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918153; x=1775522953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csGPUb3mVHj8mOAvrCTp6ZFFCIPT+BOCtOTgMTYKr6Q=;
        b=hTnZYmKFETyToW7S6jLaog0/rVKtY/WPHKb+kgAdhaPbJkNg8+yEyA2nu3CfgwBknI
         2ZMJzeTFViuI+IDYAWYgAvpCQrtvZtSwz/+8iyQxR8s3M2/DqIylJucY6UKVUxxeOezv
         vvYhb+ZeFmilbwRvaYq+uxiSWnnk20VcM3CPFIFtJrG7yg0xyN6gjPW+oBb4yT1ic2e8
         MKfcIoKIHCWsjA5wPWeG6HFAY2iLd+5+y9I4Yg0+yaizMV9tke0xGFIuuEzj5yALvRlr
         W0wPOGX/v6ZAuRHnBHwIBFzMdOwMembxeRcbt2BxFb4QkEGW6+2rAs75hV1M+jldakPs
         aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918153; x=1775522953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csGPUb3mVHj8mOAvrCTp6ZFFCIPT+BOCtOTgMTYKr6Q=;
        b=Ay4xwEwGIdSwYw69obp0cryLo+UvWwWLgH5/V6bHSgUYwGU4934rJD+GOqC9PjZ6GR
         2dmovfkQHmfbxK0QeK530TvQVui+okgZ8lj+QUMVggVEuQ9IbzpSK8dToRcoMWa7/smC
         bLJMxDFLwzJeHB0wbpDO5AtWxUh6BupgmxAbme+nu52Uot+mpQrVSmyEg2nt2teYXYaJ
         uffzmWqSPGn/uL1BlkYn0uDB9taWGLM9M49SREQAbv5H5tpYvwRUhXt8pZn6leKwkOzk
         6TjThX6uUAs069i7gwbw0ydT0cvRhjFpueynY9FM8WKvxU97B7mLD0le1PL8rUHcoMxT
         E+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXlxHMCr94aM+8PNhb+dk0rqKkWLPMJczo4A8Quz05qRPg4qVz7DLblCRza/B4pAl+2HNs5vr2VvGqv@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpDcfJ/5YG7klS+etQ/BxEmVOUt+VLJ93K4T9u5264HQMuQG9
	65fVm7zLz5PvwUjhhXPIBiRuO8wcyL9vOO4FthAVU2dyjkyUdsepWW+j
X-Gm-Gg: ATEYQzzKoK5sRLt2BY39fcwqnnIr+zezVKh7LnSkAZDKNJi9clweE6rU/duuoJOtaYd
	kw2UJUK7jKk8gleF3FP8FOCnT4WkdtTOMrEHXZwCrOSiF7i0Z45dKB22U7vwoNx1cPykH/XgUSU
	zLAEELWkqcuHCyfX2Yk1ieSRdd2+US4z5ajkHWXxRY6dMkwg9FyXFhubwACnQ7cw65ngH2woQ9J
	sgVdL4ErDn9h12MIhFFcGHbqARoipvWdBbrTLhPkeVlVW4Hix4fhRI9EX6pBV/rS/AMyA5FoPZl
	ctbyHJuGwTiDUEY/mlCUhzuBZh6oThkbGIt/PaG3yXZRV1NddikAriCLte4GzQYzA3379+QtpOd
	VmMdjusgukBVQRUoCU4afLqDMfwPtBlO/s4kf0FSiFO95rRiP5ipDB45onNtpaj5FNlerTq8Ihv
	2Slclk+gTho2E3Oy7mf/gEc4eN5lKfX7sQJIoeqVNInhWf4/NNSJ8VjUa7Kk7W2L4215Kwc8ewQ
	58rqA1lvmQmOroVbs503natrUP5Ux7qVTfQBn5iHNM9JfEZes+sA7uqfZg=
X-Received: by 2002:a5d:6344:0:b0:43c:f40f:6c91 with SMTP id ffacd0b85a97d-43cf40f6df3mr12456532f8f.10.1774918153342;
        Mon, 30 Mar 2026 17:49:13 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245e2f6sm23428139f8f.18.2026.03.30.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:49:11 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH] IB/mlx5: Fix memory leak in GSI QP destroy error path
Date: Tue, 31 Mar 2026 01:48:10 +0100
Message-ID: <20260331004811.8851-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mellanox.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18817-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36DBD362E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_destroy_gsi(), if the call to ib_destroy_qp() fails for
the hardware receive QP (gsi->rx_qp), the function currently returns
early. This results in a memory leak of the software resources
(outstanding_wrs, tx_qps) and the 'gsi' structure itself.

Align the GSI destroy path with the 'best-effort' cleanup pattern. Even
if the hardware fails to release the QP, proceed with the software
cleanup to prevent orphan allocations.

Fixes: d16e91daf446 ("IB/mlx5: Add GSI QP wrapper")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/gsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index b2e2a219639d..2272236e7f7f 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -175,11 +175,9 @@ int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
 	int ret;
 
 	ret = ib_destroy_qp(gsi->rx_qp);
-	if (ret) {
+	if (ret)
 		mlx5_ib_warn(dev, "unable to destroy hardware GSI QP. error %d\n",
 			     ret);
-		return ret;
-	}
 	dev->devr.ports[port_num - 1].gsi = NULL;
 	gsi->rx_qp = NULL;
 
-- 
2.43.0


