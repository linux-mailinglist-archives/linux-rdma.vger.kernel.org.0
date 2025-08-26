Return-Path: <linux-rdma+bounces-12924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467FB35464
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E71B65A69
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59B2F83AE;
	Tue, 26 Aug 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bpF3gDX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116182F548E
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189252; cv=none; b=NPBfyyIiYtxdPMRRl5xPIW5njJLMad6bKMPtomyfjSmsMwVGsAdEAvpGlYYwiqakEM0aUwf0dve4lkMZ9Qxt4l/PlDLAzMIW01CJkkdJ+TrfMOJuzbFT4fN9XjEGA1SXWDP2wKs1M4D/JUg9Or/Dts1dlFoySxBXRHkqSWpsvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189252; c=relaxed/simple;
	bh=kgLWykzDGE/b6FrWKGyRLhq2eXNsrpe9+bBTJFazARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZrBizYQkgpRbaMd8At747R6HkQBUJsmsq2cbrgqUlohRIEfdEJZCM8UT1VTxR8DqIW9wpBvi0P4V6vsTY0fHAzqccwk5fVmD/7xMwRtQBvnBOdvEr6QXpfFEBlmJsAORrMhmcj4faBG5Z8FpVfuxUPWNnOtOoUON7lvstARYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bpF3gDX0; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3eb6da24859so16435655ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189250; x=1756794050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=AGnzc7EKjAxCHj69OyVTnwyiAhlAkFFOYylwp4qHbJA49u/EVqjI0Q2Pe+cmdBb7WR
         s4/uAtYhARD5lp+r5Mg9px7nFEyAqlxs+veDmrXFtons4QLFmvDSH0S3sdvoxZN6Y5K/
         bdI6lvuBZkYXPqHd7dIlHMxH79mAvhrwjAECz+FM3TB70VyBWpk6Y83/90d1BW3ch+/h
         om3LinSsBd3/YfQYwAGn07LiDgBcUDvIiD+GT5n3zb2eErEUcDef9M+WZUjTMOZeRhri
         MFm6boMeJinpyiWeaUeUXl8vAlUWEK5Pjo0y80TXTHjsLQfzzMYxn6jbL3qSqQSMlEmp
         0C2g==
X-Gm-Message-State: AOJu0Yw+lM2LdjOqmwPqjFigzDG29s1c/R8kn20dJIdcaUiFZeA6X/xF
	0zK4xTb77ngFK1NY99B5pMzJPkcJeNy4cPit+EnrDnF0zscN4CzRhrBkqJxIxrEGncUczYwXrWH
	skXlSoOiTkaKEGOR9e+eySCl+3eV6C8e6v/r50OzFhCwkPT0GhOHy2foybEskBsSQTMZN9g8xs7
	DHJ2sK1jG1gnStFaxn3pstBJeBcAYEpyVXyz1AdCjz2qwPYLPCKfvKa1C4wNpmLv51kXP0NJVp5
	AMh1glWWPWDwoJiLHIsV8ebVyJk8g==
X-Gm-Gg: ASbGncvZLBrFIXQfzSyjW5y1/AFshKEx8wPpo+3DfvaYPjr4Id4vIWKC35ZByREfyPc
	ve6J4+oW9WGMObisMXZ29zM3nuZs9yLADYSeXoKnJNzSYOjIdswL28OzffnZ6egZSZtYDwtkhip
	2IGizytaIegpreIipOcXyjHzPB/cwW6rU9r3w1gLJB+oVWOv1SjQ2PDBuAqdVh522Bo0s9/HvZ3
	t3dvm6ryS+QBZ4m46yhRK3GDF/0ufsXnIw2jWnlp3a91/Wj2c5drgHbhV4++WSEbL5MzU7SQf8T
	itVyvyAqlpOa2kJ1mJb71eSW+4/kCVIOhoRQvzQBIbpndpwQrRmE0/om/ClC9yIdQot/bWs53ek
	nVb78VIK7IRXXACNLpC+0qaP7IR/VtfqI13PZ82JJlSLyDphk5sAbhaRY4H4hZMK38biQgYgW/v
	H6pquy+6U87Qbu
X-Google-Smtp-Source: AGHT+IESI0tqtw/P+r3Q8YqkyOidldvC34+6Jssw+ar6pq3O9xQzb4EE9WVlVI1Lh+AvG9T9spJaCGDD32L4
X-Received: by 2002:a05:6e02:214f:b0:3e5:52a3:dade with SMTP id e9e14a558f8ab-3e921f3872bmr212515095ab.16.1756189249859;
        Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3ea4bf9db8fsm7715145ab.8.2025.08.25.23.20.49
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so8687125a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189248; x=1756794048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=bpF3gDX09dPa9eVn8zVK/caqPsSVHHZ9eJT5XRVVsBrS0DN+ZAxsAqPheK/JXBZRbG
         AHH9e2MuRWJXM5snI8g/CIWkV42+IjCGLHx4k+piHpzISYK9Ymxxi4LvYUpJj+Rsd/Xv
         LpYlkQQS/yiMtxBl32AM8KxvyAFyKpAv7NT8Q=
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr20647360a91.24.1756189248123;
        Mon, 25 Aug 2025 23:20:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr20647332a91.24.1756189247590;
        Mon, 25 Aug 2025 23:20:47 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:47 -0700 (PDT)
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
Subject: [PATCH V2 rdma-next 05/10] RDMA/bnxt_re: Add support for unique GID
Date: Tue, 26 Aug 2025 11:55:17 +0530
Message-ID: <20250826062522.1036432-6-kalesh-anakkur.purayil@broadcom.com>
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


