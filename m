Return-Path: <linux-rdma+bounces-12880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E2B30D3E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2540AC5E30
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D6296BA3;
	Fri, 22 Aug 2025 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xl+iEgpU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242226B769
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835401; cv=none; b=Ob1e8BPVxXG4Ul+/VKnPeibNDlz67zK4B+SzuLZPlJnedTOmrOjOHRbqwJDRzHoyJycXoB+9QOf+ybtp+qjePqcDvoQyxwZ3gA6qmA39sURveSFIML7jc3NHnYw/qhfLKUBbsXwl6TmlM1UzjQ2FPjjgjdyNLxoFlD6LsOwfRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835401; c=relaxed/simple;
	bh=jvXFLpYVYHEIUc1iLOZbe4sL5yU9EXCDJbEwLbZOtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWLSx6um8pYLaqfYvJSGtaTYZp2fEszewexE9CsNkDQbSP6ZzDhKEmB/ViBiU3IZK0diAIujuqZISn/OZOifdP45QLaGD1FFVHwUFbshSvWC/fTo6SYz8oDXa/zwDopHZSTM5GDDdTnrU1oS4j2pX2bz60SKWepG+thMPcDZD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xl+iEgpU; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-24622df0d95so6287585ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835397; x=1756440197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f53GRlIh8R+xAEhzUiUULZbbPM7pwilIyORgSUpiEzU=;
        b=nD2G6HW6BDcMQ9QdGo+G4MgB6yjanrQtzqfREk3TXBysFc/0yvvqp0qCifpB1RZIkd
         0J+43DJhe0uH+HxOylF7uHMyWlfNfhZ6jfS0rYCCPMClD+4WDfEWvBnlR17fZaXopWxh
         xl/WBgG1xDNWsKn8wjOfsRn35k/y6wab5ZoilWdpFPcGzJmhAI4QnZjGfajqXAkdMB90
         7jIbv6U7axNrmOT8gDcR34+lgfwsQBF50gRVeTF36gMa2VgbqD6WzpCucWnypVjgFqRS
         9mNFJS5jkFwvm4eh/1OHiCDVDxYceX15aA1NAah9JzZQVpIYo2ejP3f0QFK8hm4GLAqr
         NLBw==
X-Gm-Message-State: AOJu0Yzj9cYp04ccYhUi/67sbSiRE/CyPIgDTukLI0HkP7vH2KuNzgni
	LcEoaRWD8End21av5SCRpomeoKqeZZEjhLlUZlpcsIWzN5+Ch2z3RVVACH/edFheRs6NOpKgquX
	X0G1IAOVpfDiVbC0eO9mYol4ex/LbNAztVgUSU/eMrPUo5FNXAA2QzoTNecfa6GzYtqCIRFQgLw
	Zu9XDRH1tmVrvpXmkFdUvy1TnBFjtMzZP0RIymxPUyMU4BNWQYfx8Opx5sidV2bptXvRzlIv6PP
	/31NtPJojIFD00EKdBRsyhqq5soAQ==
X-Gm-Gg: ASbGnct7pnbefD0SpgamF9sABrB7a/dK7jz3ZWsPwCXHuWbhL3ftyteJl0H07CFlwtV
	007RJHPxyFZNncp2YOCAlXIpd5Q6I9BuiGoFJqNlL7h2arjyxHdRqm7CVq05N2HXf3Ww/ccdsq0
	ipWZ78mcF3VuwlxWwpjKUn0pH9sw7DEFqb3P29JeTNGlbww7akYqugHslpotr55oIumuN/RGFjl
	GCwWlyGJNq/hNeDhzIIXBpDTW/lEq18ydiF/ckiZinndoyuVpwJVy/KSs3oZxIcvAVYjtHm7p6u
	HxIjtZMRY5cfzGGI5qKragfHRFC8XCTMDnO3mQLdpkuetVJjGozLmugdQ0UdAjlmu/NiwHm54pP
	fUUGLrUaIBVZn7d4wp1ij+QQgkwSeuseB7HpBb4P6aVa+t5tBzrIb9NqCa3jcfkccYOVnzw1/bL
	xBb3hpf669MgD8
X-Google-Smtp-Source: AGHT+IEbqhm+u19Nnr1MBG6g38ppvMB3fN1Dq7s4+m/fjpOdJaQMD7aLWLKZeKFOg37uMgS7H6s457G2dKda
X-Received: by 2002:a17:902:e841:b0:240:3c62:6194 with SMTP id d9443c01a7336-2462ee52164mr22313955ad.20.1755835397141;
        Thu, 21 Aug 2025 21:03:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed32cf5asm6596595ad.6.2025.08.21.21.03.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e92b3dde9so1641199b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835395; x=1756440195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f53GRlIh8R+xAEhzUiUULZbbPM7pwilIyORgSUpiEzU=;
        b=Xl+iEgpUKa/bzhcquYrK6c29hn8RN1c0MU19bDxxATuq9j+RIfN53+NtPXxzUDeAai
         tI7eO4LDhD9EvFvvpoMhR6CouJ3ZEl/RSUKJRH1GhaDsz/BoW3XL9///d5XIS+UKhl6Y
         IMdTsAxyJG+5LZVvTnxrz1zP+1tD2iYZ4mTCc=
X-Received: by 2002:a05:6a00:10c7:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-7702fa62641mr2408573b3a.13.1755835395367;
        Thu, 21 Aug 2025 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c7:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-7702fa62641mr2408534b3a.13.1755835394864;
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
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
Subject: [PATCH rdma-next 10/10] RDMA/bnxt_re: Remove unnecessary condition checks
Date: Fri, 22 Aug 2025 09:38:01 +0530
Message-ID: <20250822040801.776196-11-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3e1161721738..43af0dba0749 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -922,14 +922,6 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
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


