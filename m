Return-Path: <linux-rdma+bounces-12875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A2B30D28
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D935E8839
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7F28D8D8;
	Fri, 22 Aug 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UQKRBk8t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26D28D8CE
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835382; cv=none; b=lP4AGS2U3eeWfkNd3A7c+Ae1to1nQjy+F3uX422mqs9oJm9XOmWCdomsU/Yux1MQk8XfjxXKhPHt0HsTQsXVUSsTktXQOuZeQPok4AgW0SN6cdPY4ChFHosJHtrLw20i/ouJ7VWvYbn1U5Ddgr6ls9hHXbxeHwl/03FBkBKvxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835382; c=relaxed/simple;
	bh=kgLWykzDGE/b6FrWKGyRLhq2eXNsrpe9+bBTJFazARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVJjac+TLB4HIvBFFjUZmOHcN52Y1kQFc6wxRIOUX0xl6L/R30pOwQFVCqywpJglnCj1j3bIMVT/hTdrpbZHWrGE1CZsdfxrcS59worIYMrNAtuVMht9e4i9y5xPyurBafbd6n+IcNtP8so2nS5tnH/x7JVjo24skYy3/Yiqldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UQKRBk8t; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-76e2eb09041so1619501b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835380; x=1756440180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=SU/jv3GsYVJfMs6NJGggGMom/As+DOMvMtqqC/ueQBsHgH6PZWDAYaUBXb7nwHfXkg
         admmwEusbBnELIf2nASRD1+UVN3VYanJyURrstpaOGNwE3/x6KWPIQ4geYx2XhP7QNuH
         UD2hEkAMrPhZW6KCANzsQw5yWBaVso5L1LhHUngvNzDnSEEk+SXB2KKfQE0z4MJs9puE
         VKbqku8Ke1QZoxB5qhbHySc8MVtDZiAlzI41KMjdvJu56V83S8ypfAWNPWruU2ayYXm5
         U63yUUHxdB7BOtOdDC7sPQn41kWslF8Iz+OKcX2+H7laSPa1C1PGESvCRi354JGlWip0
         M8lg==
X-Gm-Message-State: AOJu0YwyOOOE7lSRdpRN/thvhDLU4LxKoWskvwjufgKYNQv7oDeGr2kp
	M6yHUyUXn3xFOae+9YC5LR5ddqeKfiDzDK7srnewXkzuVlVK5dW+j5Hp2xwPb04G75z9gl8lUiO
	FcL73lxrdg1UJpE0jjRM+2LpKMP5IrfK/Qg5pL/xDSZGhu8tvGGZiXczdSS+RJqQfqHybeHyZg4
	8o2cbvypRAy2v+2Nkpo8i0kH/KV6xiPtjUVb0MVnUV9scRzUv3iYAWfvQr2iuijG1UixmEXquF/
	lKowZwz2Gc0WvDOAlrx2MvgPSXg6w==
X-Gm-Gg: ASbGncshcsw42MEd8vw0O75sADnxe7eAbWoUQS90twDKF11UgZh6GUYt+jdFaaaL0ns
	ovtiQ5VWh6i0tvsQOVyAb36zhF8kzBLNiXj36vCYbAiEKF0mWNUPzUTRq9JmclUMDv33UwkWMmv
	e9khIpxVaV8D8DuS0+K1l6YIVemh/OjxAHBQpEF8bnhkt/WHum8f9uqco2NvRJF/yc1INL+cQHF
	tTgyRkBirPHaKRbyzAbYBTlQXWXZxU8rsg/GAVstsNS0Pfcyw+FNgWm39tlcWcqn8wtZXvR5HI8
	tKVzxvPvWCwlx0LgZ3/Xla5OClTuDc43JWVugcHq3UixZhwMC4erI3mAwTKZMULiSXMtNvVYZK8
	99M+VghZF5yoGehvL5U9OmQYC/D/+FEXw7xoVV8XEXfIVQ3lnPcco+K6fG9SwsSqu0IaC++d4Fs
	xzog/lnpesDiw5
X-Google-Smtp-Source: AGHT+IERT22ghzk4p+9DqDGkOn8T94rYJlva2BfYSJYljesZmapgKtAj9zAFF7rovhpbhv9jJp0aGTVL/QOk
X-Received: by 2002:a05:6a00:ab84:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-7702fa0ac01mr2206686b3a.13.1755835380400;
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-76e7d0f5670sm818053b3a.4.2025.08.21.21.03.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so1882429b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835379; x=1756440179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=UQKRBk8t5dUFqz7Pp/3IDtySNk2JSod5y7Mde42oheywAHiWDJNPnYowFFhHUPvf01
         QMgCVhDMrQOGy+iCHFWihyA3IC5WdQBrV4Y6QO4S6dg/rnS/F8Se8T6vu8ZZRm3Ymaee
         D+ohteOAAriBUHly4a/CyXFTqG3+V5fpN9u74=
X-Received: by 2002:a05:6a20:734b:b0:23d:e026:5eec with SMTP id adf61e73a8af0-24340af1359mr2532198637.6.1755835378547;
        Thu, 21 Aug 2025 21:02:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:23d:e026:5eec with SMTP id adf61e73a8af0-24340af1359mr2532160637.6.1755835378064;
        Thu, 21 Aug 2025 21:02:58 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:57 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 05/10] RDMA/bnxt_re: Add support for unique GID
Date: Fri, 22 Aug 2025 09:37:56 +0530
Message-ID: <20250822040801.776196-6-kalesh-anakkur.purayil@broadcom.com>
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

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

- RawEth QP requires unique GID so that per function stats_ctx
  is not polluted by packets mirrored to RoCE vnic.
- Added support to add unique GID when RawEth type QP is created.
- Added support to destroy unique GID when RawEth type QP is
  destroyed.
- Allocated exclusive stats_ctx to use for RawEth type QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 57 ++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/main.c      | 42 +++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  6 ++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  3 +-
 5 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 195a9ba6f65d..c83809c72f5b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -288,7 +288,9 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 	}
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = iboe_get_mtu(rdev->netdev->mtu);
-	port_attr->gid_tbl_len = dev_attr->max_sgid;
+	/* One GID is reserved for RawEth QP. Report one less */
+	port_attr->gid_tbl_len = (rdev->rcfw.roce_mirror ? (dev_attr->max_sgid - 1) :
+				  dev_attr->max_sgid);
 	port_attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 				    IB_PORT_DEVICE_MGMT_SUP |
 				    IB_PORT_VENDOR_CLASS_SUP;
@@ -429,7 +431,7 @@ int bnxt_re_add_gid(const struct ib_gid_attr *attr, void **context)
 
 	rc = bnxt_qplib_add_sgid(sgid_tbl, (struct bnxt_qplib_gid *)&attr->gid,
 				 rdev->qplib_res.netdev->dev_addr,
-				 vlan_id, true, &tbl_idx);
+				 vlan_id, true, &tbl_idx, false, 0);
 	if (rc == -EALREADY) {
 		ctx_tbl = sgid_tbl->ctx;
 		ctx_tbl[tbl_idx]->refcnt++;
@@ -955,6 +957,20 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	return rc;
 }
 
+static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return;
+
+	rc = bnxt_qplib_del_sgid(&rdev->qplib_res.sgid_tbl,
+				 (struct bnxt_qplib_gid *)&rdev->ugid,
+				 0xFFFF, true);
+	if (rc)
+		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -994,6 +1010,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	else if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_UD)
 		atomic_dec(&rdev->stats.res.ud_qp_count);
 
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
+		bnxt_re_del_unique_gid(rdev);
+
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
@@ -1595,6 +1614,29 @@ static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
+static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return 0;
+
+	rdev->ugid.global.subnet_prefix = cpu_to_be64(0xfe8000000000abcdLL);
+	addrconf_ifid_eui48(&rdev->ugid.raw[8], rdev->netdev);
+
+	rc = bnxt_qplib_add_sgid(&res->sgid_tbl,
+				 (struct bnxt_qplib_gid *)&rdev->ugid,
+				 rdev->qplib_res.netdev->dev_addr,
+				 0xFFFF, true, &rdev->ugid_index, true,
+				 hctx->stats3.fw_id);
+	if (rc)
+		dev_err(rdev_to_dev(rdev), "Failed to add unique GID. rc = %d\n", rc);
+
+	return rc;
+}
+
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
@@ -1656,6 +1698,17 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		}
 	}
 
+	/* Support for RawEth QP is added to capture TCP pkt dump.
+	 * So unique SGID is used to avoid incorrect statistics on per
+	 * function stats_ctx
+	 */
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE) {
+		rc = bnxt_re_add_unique_gid(rdev);
+		if (rc)
+			goto qp_destroy;
+		qp->qplib_qp.ugid_index = rdev->ugid_index;
+	}
+
 	qp->ib_qp.qp_num = qp->qplib_qp.id;
 	if (qp_init_attr->qp_type == IB_QPT_GSI)
 		rdev->gsi_ctx.gsi_qp = qp;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c25eb2525a8f..479c2a390885 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2006,6 +2006,42 @@ static int bnxt_re_get_stats_ctx(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static int bnxt_re_get_stats3_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return 0;
+
+	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &hctx->stats3);
+	if (rc)
+		return rc;
+
+	rc = bnxt_re_net_stats_ctx_alloc(rdev, &hctx->stats3);
+	if (rc)
+		goto free_stat_mem;
+
+	return 0;
+free_stat_mem:
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats3);
+
+	return rc;
+}
+
+static void bnxt_re_put_stats3_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+
+	if (!rdev->rcfw.roce_mirror)
+		return;
+
+	bnxt_re_net_stats_ctx_free(rdev, hctx->stats3.fw_id);
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats3);
+}
+
 static void bnxt_re_put_stats_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
@@ -2028,6 +2064,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
+	bnxt_re_put_stats3_ctx(rdev);
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
@@ -2232,6 +2270,10 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	if (!rdev->is_virtfn)
 		bnxt_re_read_vpd_info(rdev);
 
+	rc = bnxt_re_get_stats3_ctx(rdev);
+	if (rc)
+		goto fail;
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ed1be06c2c60..2ea3b7f232a3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -304,6 +304,7 @@ struct bnxt_qplib_ctx {
 	struct bnxt_qplib_hwq		tim_tbl;
 	struct bnxt_qplib_tqm_ctx	tqm_ctx;
 	struct bnxt_qplib_stats		stats;
+	struct bnxt_qplib_stats		stats3;
 	struct bnxt_qplib_vf_res	vf_res;
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 79edff6bda95..d10741151543 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -308,7 +308,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, const u8 *smac,
-			u16 vlan_id, bool update, u32 *index)
+			u16 vlan_id, bool update, u32 *index,
+			bool is_ugid, u32 stats_ctx_id)
 {
 	struct bnxt_qplib_res *res = to_bnxt_qplib(sgid_tbl,
 						   struct bnxt_qplib_res,
@@ -373,6 +374,9 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		req.src_mac[1] = cpu_to_be16(((u16 *)smac)[1]);
 		req.src_mac[2] = cpu_to_be16(((u16 *)smac)[2]);
 
+		req.stats_ctx = cpu_to_le16(CMDQ_ADD_GID_STATS_CTX_STATS_CTX_VALID |
+					    (u16)stats_ctx_id);
+
 		bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 					sizeof(resp), 0);
 		rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e9834e7fc383..58f90f3e57f7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -323,7 +323,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, u16 vlan_id, bool update);
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, const u8 *mac, u16 vlan_id,
-			bool update, u32 *index);
+			bool update, u32 *index,
+			bool is_ugid, u32 stats_ctx_id);
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-- 
2.43.5


