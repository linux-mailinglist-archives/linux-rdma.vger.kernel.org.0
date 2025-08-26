Return-Path: <linux-rdma+bounces-12926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10279B35466
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB79686AC6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E822F8BDF;
	Tue, 26 Aug 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EogmH6Rh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C462F60A3
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189260; cv=none; b=lne6YSRgyvf+loxlXdT9PCb9Sz0XJIgXULiyWUf0Z3ByNRSIpbr7Tl+pFKaDDt9NVcYjUdpbD1e8OYPg7iEUNcrtHKFYVIPliZjr7fKv5TM4vq+muZmzEal2JhDWGiUztK3mGPtf6BMMxcIMW3D+Igk5V6WvNnNMWhjt5uwyxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189260; c=relaxed/simple;
	bh=TIsik8++R/27mabka3M9kiy5YAv1vONc6jlOzZ5bxn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4/64slGSg+Ty+iqPHfyrlTojFkfRDBpSG25pNS+KhqfR6saZtfU1NZOet9R0XmyY81MamQ6FjMlYoqSPm19lToJD7PXz2o62SxaYu8s1CjSMh2HsT+0yJ0AiYpizKQv/pvujoOgj6Se5DwAy+ZxrHs1cT60zJyaXafqS2P02mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EogmH6Rh; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-71d6083cc69so40620487b3.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189257; x=1756794057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpLVCWhYNJHu5P2oJU2x+VekYsAhN0PPaGcsV8sCkwU=;
        b=hHTwQnWaActqYcfQgYAXVE1EmXl1NJPilfvd85dpLB0qM5tZ6GsrWAw9BIO4DmDJvL
         kShocjmTH8t5y6yYe63mOZFPAqDKe7N+GWM7Yy5qCXOPCpjqwR0PV0Nq9y9scCIQJlkb
         AfosPhk6v3ZS62sA3mUlVQjAA29wmNgQ8hruKHPxeZvd9Mw9id6M2LjYVSVcu/bBlMT+
         sn4sUYHInAiIYFPgBr+6ShnNoZpqW6Bym1vv+f8aI88a0OojAp1I0hFhsMhMPxQG87hd
         ey7/tDG54ZSS0bRY4jLoNSaaSR3rI8a5G52pAHfn5ad7jR5+9X6HD9cdE5zPh/lgpfue
         li4Q==
X-Gm-Message-State: AOJu0YwA6WsL1y28QpxxNNkNOAqkO4k8U4iBfozRNPBth1QaBSujKya9
	BviTXxr1Dc+tDB/+En5zi4wVvCfNyVm7BwLSYWXkAKqgZvIekvQzUPtXcJQiGEasY43NunTnY3c
	8QhCkRa8JEEfhjJJYLG0YoWJ7eEpePJYUzQ0F6JpQIFgrPy7H0ghlGxbDBMBj02YUyow4TZhcXe
	t9CrwI+yThR0OlgwJzoOVN/FY3PZ8Ikz9MVOGCQWZZiKfRFUdhWflEEx5lWLb4BiD09+IFZITZj
	XVwh09zP4bqeFn28eqwE0xR/W4a/A==
X-Gm-Gg: ASbGnctl64fqouNM1mVNJnM3eIH10xtpn3V4m3OLsq8GpLsA2OEA56YpOD7NZRx3x4d
	maudLIW/DXd/c/DFpxtGjZPB/HYsXtaWqg+FXrj2wix+VpjsbhP5/7HafGuC5vrqQE+FQhqeL8Q
	tTFzVBEXk2LdMAaMgzugL/Vqllj0Ld1IIEYOhX7FmwYwlQ+cHPwnvP9xDQ3oMPripehpVysmfF4
	3CgqRGKjkVea3QW1eG5EACPpkEmf7nPWyweCc+Orqk7fY4Q1Wk2pZlsYEzHEtqVj+SNchmnR/Pz
	zR8w0hs+XrqDDyd8+6vMgnAdx4e3qAr3iRP8ZyeKzjM739fvhMQh1b3WbvODN9/2QknzbYydZ47
	H8Y6nnKS2l6ps8LmTDQqp9lDoRA8JgZHfuSONnaqWaBW4IfsFhEt3I3L460nnieI4DaiF8GYiD1
	Mad89Qw8Xa7Tsi
X-Google-Smtp-Source: AGHT+IEiH1TDCgziU5RsGHBQQoEez3nKzV3y3Km9yKJ+MSIWKB0ycx6iDPepDVBuwpQGvb3B4iqL1evMfeZd
X-Received: by 2002:a05:690c:368d:b0:71c:530:1450 with SMTP id 00721157ae682-71fdc314cc8mr155859257b3.21.1756189257544;
        Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff16a3c26sm4493377b3.5.2025.08.25.23.20.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so4127587a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189256; x=1756794056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpLVCWhYNJHu5P2oJU2x+VekYsAhN0PPaGcsV8sCkwU=;
        b=EogmH6RhxRKOgzHqge9Tnjy+iEKljHaQ+5HKEUMfVq0CvU5YKDUBOv+UmiGFNqpUwb
         xlSp5k4GEkatcJDt7q6xc9gKBYXavlMbcJIQEmJPCUP9jVGUqWZ3MGLWWnwsrA4+4D3T
         Ft+k1Brh4N788kWw6YUSc3NLPhRjLc9PBkKeY=
X-Received: by 2002:a17:903:2ecd:b0:246:22e3:6a2a with SMTP id d9443c01a7336-2462ee1a616mr186242485ad.15.1756189254703;
        Mon, 25 Aug 2025 23:20:54 -0700 (PDT)
X-Received: by 2002:a17:903:2ecd:b0:246:22e3:6a2a with SMTP id d9443c01a7336-2462ee1a616mr186242215ad.15.1756189254224;
        Mon, 25 Aug 2025 23:20:54 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:53 -0700 (PDT)
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
Subject: [PATCH V2 rdma-next 07/10] RDMA/bnxt_re: Add support for flow create/destroy
Date: Tue, 26 Aug 2025 11:55:19 +0530
Message-ID: <20250826062522.1036432-8-kalesh-anakkur.purayil@broadcom.com>
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

- Added support for create_flow and destroy_flow verbs. These
  verbs are used on RawEth QP to add a specific flow action.
- To support TCP dump on RoCE, added IB_FLOW_ATTR_SNIFFER
  attribute.
- In create_flow verb, driver allocates mirror_vnic and configure it
  with RawEth QP. Once this is done, driver will enable mirroring.
- In destroy_flow, driver will disable mirroring and free the mirror
  vnic.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 87 ++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  5 ++
 drivers/infiniband/hw/bnxt_re/main.c     |  2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 37 ++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  2 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h | 40 ++++++++++-
 7 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3f7f6cefe771..3a219d67746c 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -234,6 +234,7 @@ struct bnxt_re_dev {
 	u16			mirror_vnic_id;
 	union			ib_gid ugid;
 	u32			ugid_index;
+	u8			sniffer_flow_created:1;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c83809c72f5b..90c23d0ee262 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4449,6 +4449,93 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 	}
 }
 
+static int bnxt_re_setup_vnic(struct bnxt_re_dev *rdev, struct bnxt_re_qp *qp)
+{
+	int rc;
+
+	rc = bnxt_re_hwrm_alloc_vnic(rdev);
+	if (rc)
+		return rc;
+
+	rc = bnxt_re_hwrm_cfg_vnic(rdev, qp->qplib_qp.id);
+	if (rc)
+		goto out_free_vnic;
+
+	return 0;
+out_free_vnic:
+	bnxt_re_hwrm_free_vnic(rdev);
+	return rc;
+}
+
+struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
+				    struct ib_flow_attr *attr,
+				    struct ib_udata *udata)
+{
+	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
+	struct bnxt_re_dev *rdev = qp->rdev;
+	struct bnxt_re_flow *flow;
+	int rc;
+
+	if (attr->type != IB_FLOW_ATTR_SNIFFER ||
+	    !rdev->rcfw.roce_mirror)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mutex_lock(&rdev->qp_lock);
+	if (rdev->sniffer_flow_created) {
+		ibdev_err(&rdev->ibdev, "RoCE Mirroring is already Configured\n");
+		mutex_unlock(&rdev->qp_lock);
+		return ERR_PTR(-EBUSY);
+	}
+
+	flow = kzalloc(sizeof(*flow), GFP_KERNEL);
+	if (!flow) {
+		mutex_unlock(&rdev->qp_lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	flow->rdev = rdev;
+
+	rc = bnxt_re_setup_vnic(rdev, qp);
+	if (rc)
+		goto out_free_flow;
+
+	rc = bnxt_qplib_create_flow(&rdev->qplib_res);
+	if (rc)
+		goto out_free_vnic;
+
+	rdev->sniffer_flow_created = 1;
+	mutex_unlock(&rdev->qp_lock);
+
+	return &flow->ib_flow;
+
+out_free_vnic:
+	bnxt_re_hwrm_free_vnic(rdev);
+out_free_flow:
+	mutex_unlock(&rdev->qp_lock);
+	kfree(flow);
+	return ERR_PTR(rc);
+}
+
+int bnxt_re_destroy_flow(struct ib_flow *flow_id)
+{
+	struct bnxt_re_flow *flow =
+		container_of(flow_id, struct bnxt_re_flow, ib_flow);
+	struct bnxt_re_dev *rdev = flow->rdev;
+	int rc;
+
+	mutex_lock(&rdev->qp_lock);
+	rc = bnxt_qplib_destroy_flow(&rdev->qplib_res);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev, "failed to destroy_flow rc = %d\n", rc);
+	rdev->sniffer_flow_created = 0;
+
+	bnxt_re_hwrm_free_vnic(rdev);
+	mutex_unlock(&rdev->qp_lock);
+	kfree(flow);
+
+	return rc;
+}
+
 static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
 {
 	struct bnxt_re_cq *cq = NULL, *tmp_cq;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 445a28b3cd96..76ba9ab04d5c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -272,6 +272,11 @@ struct ib_mr *bnxt_re_reg_user_mr_dmabuf(struct ib_pd *ib_pd, u64 start,
 					 struct uverbs_attr_bundle *attrs);
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
+struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
+				    struct ib_flow_attr *attr,
+				    struct ib_udata *udata);
+int bnxt_re_destroy_flow(struct ib_flow *flow_id);
+
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 07d25deffabe..fe1be036f8f2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1383,6 +1383,8 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.reg_user_mr_dmabuf = bnxt_re_reg_user_mr_dmabuf,
 	.req_notify_cq = bnxt_re_req_notify_cq,
 	.resize_cq = bnxt_re_resize_cq,
+	.create_flow = bnxt_re_create_flow,
+	.destroy_flow = bnxt_re_destroy_flow,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, bnxt_re_cq, ib_cq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, bnxt_re_pd, ib_pd),
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index d10741151543..9ef581ed785c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -1106,3 +1106,40 @@ int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
+
+int bnxt_qplib_create_flow(struct bnxt_qplib_res *res)
+{
+	struct creq_roce_mirror_cfg_resp resp = {};
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct cmdq_roce_mirror_cfg req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_ROCE_MIRROR_CFG,
+				 sizeof(req));
+
+	req.mirror_flags = (u8)CMDQ_ROCE_MIRROR_CFG_MIRROR_ENABLE;
+
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	return bnxt_qplib_rcfw_send_message(rcfw, &msg);
+}
+
+int bnxt_qplib_destroy_flow(struct bnxt_qplib_res *res)
+{
+	struct creq_roce_mirror_cfg_resp resp = {};
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct cmdq_roce_mirror_cfg req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_ROCE_MIRROR_CFG,
+				 sizeof(req));
+
+	req.mirror_flags &= ~((u8)CMDQ_ROCE_MIRROR_CFG_MIRROR_ENABLE);
+
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+
+	return bnxt_qplib_rcfw_send_message(rcfw, &msg);
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 58f90f3e57f7..147b5d9c0313 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -360,6 +360,8 @@ int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 type, u32 xid,
 int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
 			      struct bnxt_qplib_cc_param *cc_param);
 void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw);
+int bnxt_qplib_create_flow(struct bnxt_qplib_res *res);
+int bnxt_qplib_destroy_flow(struct bnxt_qplib_res *res);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index f9ac37335a1d..cfdf69a3fe9a 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -144,7 +144,8 @@ struct cmdq_base {
 	#define CMDQ_BASE_OPCODE_MODIFY_CQ              0x90UL
 	#define CMDQ_BASE_OPCODE_QUERY_QP_EXTEND        0x91UL
 	#define CMDQ_BASE_OPCODE_QUERY_ROCE_STATS_EXT   0x92UL
-	#define CMDQ_BASE_OPCODE_LAST                  CMDQ_BASE_OPCODE_QUERY_ROCE_STATS_EXT
+	#define CMDQ_BASE_OPCODE_ROCE_MIRROR_CFG	0x99UL
+	#define CMDQ_BASE_OPCODE_LAST                   CMDQ_BASE_OPCODE_ROCE_MIRROR_CFG
 	u8	cmd_size;
 	__le16	flags;
 	__le16	cookie;
@@ -2109,6 +2110,43 @@ struct creq_query_roce_stats_ext_resp_sb {
 	__le64	dup_req;
 };
 
+/* cmdq_roce_mirror_cfg (size:192b/24B) */
+struct cmdq_roce_mirror_cfg {
+	u8      opcode;
+	#define CMDQ_ROCE_MIRROR_CFG_OPCODE_ROCE_MIRROR_CFG	0x99UL
+	#define CMDQ_ROCE_MIRROR_CFG_OPCODE_LAST		\
+				CMDQ_ROCE_MIRROR_CFG_OPCODE_ROCE_MIRROR_CFG
+	u8      cmd_size;
+	__le16  flags;
+	__le16  cookie;
+	u8      resp_size;
+	u8      reserved8;
+	__le64  resp_addr;
+	u8      mirror_flags;
+	#define CMDQ_ROCE_MIRROR_CFG_MIRROR_ENABLE		0x1UL
+	u8      rsvd[7];
+};
+
+/* creq_roce_mirror_cfg_resp (size:128b/16B) */
+struct creq_roce_mirror_cfg_resp {
+	u8      type;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_MASK	0x3fUL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_SFT	0
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_QP_EVENT	0x38UL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_TYPE_LAST	\
+			CREQ_ROCE_MIRROR_CFG_RESP_TYPE_QP_EVENT
+	u8      status;
+	__le16  cookie;
+	__le32  reserved32;
+	u8      v;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_V		0x1UL
+	u8      event;
+	#define CREQ_ROCE_MIRROR_CFG_RESP_EVENT_ROCE_MIRROR_CFG	0x99UL
+	#define CREQ_ROCE_MIRROR_CFG_RESP_EVENT_LAST	\
+			CREQ_ROCE_MIRROR_CFG_RESP_EVENT_ROCE_MIRROR_CFG
+	u8      reserved48[6];
+};
+
 /* cmdq_query_func (size:128b/16B) */
 struct cmdq_query_func {
 	u8	opcode;
-- 
2.43.5


