Return-Path: <linux-rdma+bounces-12929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E424B3546D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7993BE006
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F562FA0DF;
	Tue, 26 Aug 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cxqfT2Uv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CE2F99A8
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189268; cv=none; b=dKQJAew6CVxdgZF24vnUILYvAS7x0zLVbv/azzMtKTRl4C9vTGum/GIc8+KQeu2ikSsK0XcA9OtFPW+PpPQWm0O0pfYlTHbXPNDlZbjDYtPznV7RD+d1GCBLZWF1II6xIbN8osoY3zBYsde2n8MVFqSvFhqEc7ZCFTZgHcTH/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189268; c=relaxed/simple;
	bh=ONvUs6gCM1AXz/svlHDmLstiRv7jgG5D+ybE8/LNI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM6VUQe48gmmVxb0wyHNnPBCdF488AE/7wME8q38chh/nRrEJJhywFbuDgHBy+yT2YL2Y0TkwLZjyqq/qPIH2Qc4dwIWHCcQjJzyG2/yXBk7bGPpfN/r/cyDNT7hQARRMZndXE7rGGNG0Q8cjXAFEW1V5Ol4zval6lPvuQKmXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cxqfT2Uv; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e9537c4a2cdso2022218276.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189266; x=1756794066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDT5ArH2GSLOx05FVKYh091ceB024UhDnWB5JU+LHP4=;
        b=WNk2XQy7RuPKHwX/zYmhErhLCc2Tvsh9N/Ltdaf86ugz8Kor13bXHF0WDl3SwvQjw5
         XX825TuFej1UsALAuIB37U5U0ogVQZnU2plHJPqhE/g5+vb7HatF0kwBqkuFEVrjsI7p
         CzI7hiQPmRvFHsedMw8xXhAg0rkeQzfvRKIt/XLZVtQ09NZ1U9PFHzyy27aYYfI5js8i
         s+GqNGnpeUAOBjXu2IA3zNFEfcUHcqJmhVp4PUzuMC+T/IcZhBvhXddJQh6hvE5Xg5vT
         yOKt6p2xootmO9e0ch/e/Tp+HDQ36M0SacRlsj6pR9d5Ks1irVOw6VU9hKw6dMb8vggn
         t8yQ==
X-Gm-Message-State: AOJu0YwmaQ63oH0B/ciaXcBLlfoqK13RS7St2rQ9Qm8Kr6hOYTxqGwHo
	QE9l+2y8uIOTk/JTwLvjmFdZDWc+b+S9vty5COY3oMwsej5IVGmPklA9/sZyfXDyErqHKTcNO06
	AqR2AVM3LTVF5vHxb1ov1v++SNFrZUyXJUp4aUURfmIQPiIk4Ae0JcLUgKcrJ9u48nUMWQOswXU
	H0jmO9NbR0JAkNoMTotR5OSEm3km+epL7F5j2ZuzyOeR+0/P/FKeISZDIetgqmcw6TsKAlnOU7W
	6m4OEV+2wZhmcTy+8QIcd9l3f/x1A==
X-Gm-Gg: ASbGncsKC6jvWJ9wr8CyUUHBRoxfAN4gqlet3l/A+47THppVH/yWUtqTl3WRAF8JwQQ
	WH8iT4bmv4wroabr0fRfwIhcp6C+BrGEemoQs3oqTe3w6D94qiCYOVubVjGXgkYr11l49KstcpY
	CM9bB/fI0ow9Sp5cDr9O/Z+TbBQtFgiK/M2Fg3glvub0skJTZM69361rtp9ZhW4qoTb1cp2cWqO
	NXR3ZGbRP2n3FMx6P3i7VWW0RnLtrcGQPqTfkOZNyNHCZ/LOfQDTZlb6J4SzhVX1a1lC2qTU87/
	Lx7CxyCW7YplpuP9vjmrwiXYd1jUniAD6YU7OaPYkr3gVuGJF1o/xGXOF2/EZkZ0pnk7BIsM9Kt
	Q8O0c0zdj+kPCdL9u0tPDjm2vu4/Ot35Lv2pTTcFWMXqdR+j315P6m4bkRCnhNU33qMUjLczmy6
	GxuHe0gIBqjiyV
X-Google-Smtp-Source: AGHT+IFIeaCrQzvy2vSh0JYLfnu+6E7ZMERlHnCk/7Q56BldRLNhsu6xgsfn1xYN7jOKgbRC/aroxNHtMpUv
X-Received: by 2002:a05:6902:2a49:b0:e95:3ae8:844 with SMTP id 3f1490d57ef6-e953ae80c2amr7812968276.38.1756189266265;
        Mon, 25 Aug 2025 23:21:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e952c35c0e7sm681673276.15.2025.08.25.23.21.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:21:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246eb38205fso17208885ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189265; x=1756794065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDT5ArH2GSLOx05FVKYh091ceB024UhDnWB5JU+LHP4=;
        b=cxqfT2Uv4y0tQWOyZHcPgZFPL7vF71+03KDRR2k7rH28acMt7dYUY+ihJJf894W4bw
         ZgZECirxYYQMy+i7iCuTop5it8LMg9sZgdCXRme0rQa28ykZmxU0AH8Oq+g8mYwao8Ob
         +Q1wfdt7rbija2InhcUCSRyAvmpnAwv9eVuMc=
X-Received: by 2002:a17:903:234c:b0:246:1c5c:775 with SMTP id d9443c01a7336-2462eddce8dmr173542935ad.1.1756189265009;
        Mon, 25 Aug 2025 23:21:05 -0700 (PDT)
X-Received: by 2002:a17:903:234c:b0:246:1c5c:775 with SMTP id d9443c01a7336-2462eddce8dmr173542685ad.1.1756189264611;
        Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH V2 rdma-next 10/10] RDMA/bnxt_re: Remove unnecessary condition checks
Date: Tue, 26 Aug 2025 11:55:22 +0530
Message-ID: <20250826062522.1036432-11-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The check for "rdev" and "en_dev" pointer validity always
return false.

Remove them.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3e1161721738..583199e90bdd 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -916,20 +916,12 @@ static void bnxt_re_deinitialize_dbr_pacing(struct bnxt_re_dev *rdev)
 static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
-	struct bnxt_en_dev *en_dev;
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ring_free_input req = {};
 	struct hwrm_ring_free_output resp;
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!rdev)
-		return rc;
-
-	en_dev = rdev->en_dev;
-
-	if (!en_dev)
-		return rc;
-
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
@@ -955,9 +947,6 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!en_dev)
-		return rc;
-
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
 	req.enables = 0;
 	req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
@@ -990,9 +979,6 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!en_dev)
-		return rc;
-
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
@@ -1020,9 +1006,6 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 
 	stats->fw_id = INVALID_STATS_CTX_ID;
 
-	if (!en_dev)
-		return rc;
-
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
-- 
2.43.5


