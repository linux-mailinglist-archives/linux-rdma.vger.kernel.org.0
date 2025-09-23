Return-Path: <linux-rdma+bounces-13586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E226B948A5
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7724018A2823
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB32C30F55D;
	Tue, 23 Sep 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZFkGCscI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BF24BCF5
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608540; cv=none; b=hNHtemOwcnkMXGEZ4YphlCI9/9GRJFdg8PCCp7oc5MN4OF/j1SecuL/P1DTki70fEQmgyh7sdlwgTFN5/73xBlFs5k8gavLxevSRyduQU2Ct7nf8H7pNjyEvnSPgxTu30oWwbdCPXGoTgSIgTToh7/2ezCBNMf+KnHN9TA3Erks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608540; c=relaxed/simple;
	bh=xUbAhyBkTrhBCb2SgTehiFXfa3rDOS/A7DRzcAoHW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeN9N+NOMw32AS8Ebv60KRa5uyJbVJZbNthyfr1+xJopZJqg0zyaM82v8DbZQcqM5otiUDy9aiFYzWBuXrMeLn899qisY4QgyX1SZ2vsQE1LVplwMguhXx4YbEdNezgtnLODDJYtP75PbE1BcClAk4ciODEVhcWRltDWkMjEfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZFkGCscI; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-b54dc768f11so3830659a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608538; x=1759213338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSQnn8Y+AfVQ05yIGdENHheIplwTs9oj4V4Skp+PIYs=;
        b=PfQWyFfdjZZtfuXY3mSCVcbMAWKDji2iR8XrSCJHRfPXeVE9G9LcFwWS0XGETEejJv
         Z5c1WuXBO4F28zbsBXvCCN6zGJDm6Wi0pr2AQ1hncYirVKPcHPUTLjk/3YZ079ZftzO6
         63gzO4/lyH2V0AQIdb0+383vZBZxFVm+4pGG1wmhnY55WcaXPFFYduXW/frYwsEgUBb4
         28Gegffn7eKB4mUKTHjKGgXVleXhICxTJ3fhIOJmcp0S0BRGhsFoTB4OcwHrkOPqRfj9
         EUz/LyryrnhJdF+krueYu5RZJgCbvUglFGkmXhEIjgylAkhuvyQ1/h/1ppOUyQqIKpi2
         VS8w==
X-Gm-Message-State: AOJu0YzMUQfyfChfliyvZwAkiM1AoGfkt81iiQn9AO7XnetmvlEB6n9o
	BOOjLVgSj8a+tzOjA1ZQobTLa980w9Ok82Bjmgs/OS6x5UPhwYA2e/XpVBKJLbE7HGs6hVOnfV/
	MXMZ8jr0YH03jE8yE4GYG62hr+JNdVEHyHuFZYMtKoQWG2Xn/Y/ACjzVrIJwTLjiXB3rJ/WnA21
	A5lhsmG7z8PST1FZJ7OGWNeew62qAYdNACLgO3wGubXzTN7InY2Z+539MTQvNY53YXPf628gtx6
	8PCgYBH9ONEU98XMRS6xME0YDxzJQ==
X-Gm-Gg: ASbGnct+WL4yYK0KhIyqLx9sMGF1HDsVtLxVRgcgojE9V+vkrVFhmdBwGBGBxg72AWq
	vF4nauZM2ofxlcRlvJaYqnf5YaHLguCWVpiE6TDj6sS4NnW4oTUggkFTZoswVUWt8pBIYpHVhLB
	TJQ/aWnpwEZu6GtwxZxQOdSFJmAz7VuWQu8b62IEBrbEmQhhygk1NcMPCEGF/ANNdNuLfbTQqCM
	pTF/B6ohkRUFuzswNof5VMrU/UNfGkdn+1cFubHKHNw+XuWLVW8hLkukjwIAeQKyHlL1h6XWc+p
	448ZTnb6Ud9XfzMMVmKp9gUBreHRCjQRnrFssI5uLbcSfEheAJ7wNpw4N62B+BKGr9F5ZFQEoMc
	wAGWJhsP+2e6QbniYqf7dJB21plX4aHVDcORiEqhnIz+gkAsOdB/IBfpp+aKpQRnz0Z6nOYCUdY
	WqpXhIHV6JAISc/Hk=
X-Google-Smtp-Source: AGHT+IEaf5yYm65cXHdl3vn2mdS4oJ6KFBUSkNChUO5/MEJBzh67U6x0aS/N7OZzrcyvUAnFG7Tg9aa9P7f5
X-Received: by 2002:a17:903:2343:b0:25c:982e:2b22 with SMTP id d9443c01a7336-27cc8656201mr14902425ad.61.1758608538191;
        Mon, 22 Sep 2025 23:22:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bae5fsm9329165ad.63.2025.09.22.23.22.17
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 23:22:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso2590427a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 23:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758608536; x=1759213336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSQnn8Y+AfVQ05yIGdENHheIplwTs9oj4V4Skp+PIYs=;
        b=ZFkGCscIwTCO/EEnEMGGhNN7b1yVTz4I5TngyFcefOL6aL9GpadkjRl406ZLAPBKBa
         voPseIgJWgrdVIgyCTNDIPPPQEMuN/kqndpfuvQkdpH7Fi1X8Vvl8msT6JoW2ULfrR/P
         lgWuS4BEZ2lAEhLyKaQ4ELhKOMcxBgK7/PGjs=
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-27cc79cb186mr17546515ad.56.1758608536309;
        Mon, 22 Sep 2025 23:22:16 -0700 (PDT)
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-27cc79cb186mr17546265ad.56.1758608535909;
        Mon, 22 Sep 2025 23:22:15 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053db2sm152582285ad.2.2025.09.22.23.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:22:15 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 1/2] RDMA/bnxt_re: Add debugfs info entry for device and resource information
Date: Tue, 23 Sep 2025 11:56:56 +0530
Message-ID: <20250923062657.981487-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

Add a new debugfs info entry that displays device information and
non-statistics data using the seq_file interface. This entry shows:

- Resource watermarks (peak usage tracking)
- Operational counters (CQ resize count)
- Doorbell pacing information

Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index e632f1661b92..be5e9b5ca2f0 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -8,6 +8,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/pci.h>
+#include <linux/seq_file.h>
 #include <rdma/ib_addr.h>
 
 #include "bnxt_ulp.h"
@@ -314,6 +315,40 @@ static const struct file_operations bnxt_re_cc_config_ops = {
 	.write = bnxt_re_cc_config_set,
 };
 
+static int info_show(struct seq_file *m, void *unused)
+{
+	struct bnxt_re_dev *rdev = m->private;
+	struct bnxt_re_res_cntrs *res_s = &rdev->stats.res;
+
+	seq_puts(m, "Info:\n");
+	seq_printf(m, "Device Name\t\t: %s\n", dev_name(&rdev->ibdev.dev));
+	seq_printf(m, "PD Watermark\t\t: %llu\n", res_s->pd_watermark);
+	seq_printf(m, "AH Watermark\t\t: %llu\n", res_s->ah_watermark);
+	seq_printf(m, "QP Watermark\t\t: %llu\n", res_s->qp_watermark);
+	seq_printf(m, "RC QP Watermark\t\t: %llu\n", res_s->rc_qp_watermark);
+	seq_printf(m, "UD QP Watermark\t\t: %llu\n", res_s->ud_qp_watermark);
+	seq_printf(m, "SRQ Watermark\t\t: %llu\n", res_s->srq_watermark);
+	seq_printf(m, "CQ Watermark\t\t: %llu\n", res_s->cq_watermark);
+	seq_printf(m, "MR Watermark\t\t: %llu\n", res_s->mr_watermark);
+	seq_printf(m, "MW Watermark\t\t: %llu\n", res_s->mw_watermark);
+	seq_printf(m, "CQ Resize Count\t\t: %d\n", atomic_read(&res_s->resize_count));
+	if (rdev->pacing.dbr_pacing) {
+		seq_printf(m, "DB Pacing Reschedule\t: %llu\n", rdev->stats.pacing.resched);
+		seq_printf(m, "DB Pacing Complete\t: %llu\n", rdev->stats.pacing.complete);
+		seq_printf(m, "DB Pacing Alerts\t: %llu\n", rdev->stats.pacing.alerts);
+		seq_printf(m, "DB FIFO Register\t: 0x%x\n",
+			   readl(rdev->en_dev->bar0 + rdev->pacing.dbr_db_fifo_reg_off));
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(info);
+
+static void bnxt_re_debugfs_add_info(struct bnxt_re_dev *rdev)
+{
+	debugfs_create_file("info", 0400, rdev->dbg_root, rdev, &info_fops);
+}
+
 void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 {
 	struct pci_dev *pdev = rdev->en_dev->pdev;
@@ -325,6 +360,8 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 	rdev->qp_debugfs = debugfs_create_dir("QPs", rdev->dbg_root);
 	rdev->cc_config = debugfs_create_dir("cc_config", rdev->dbg_root);
 
+	bnxt_re_debugfs_add_info(rdev);
+
 	rdev->cc_config_params = kzalloc(sizeof(*cc_params), GFP_KERNEL);
 
 	for (i = 0; i < BNXT_RE_CC_PARAM_GEN0; i++) {
-- 
2.43.5


