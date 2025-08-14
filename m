Return-Path: <linux-rdma+bounces-12756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBEB2640F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E43F17C2BF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031732727FC;
	Thu, 14 Aug 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nbxhs1F8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62E318156
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170404; cv=none; b=AE2rOq9OKu1aoFT8a2XKrFUCtK234OS8GtFKy3MWGBjS2TxfdKz9kOMpYhSZ5SKLVW8Zpj5hr3pdnYCfCNe8IxOcVR8OygAHWgiIY6MV+9jx6gIWuMMUfJSWBZJ1q+iB4CJqA3yEZsCG3ipGzn8pkjmHhUu3EFNg1n9BEWx6Yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170404; c=relaxed/simple;
	bh=W0sdYqTiG/VpCC7isuHn8GbT6+lYncPckAJV6u8+kmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1mQ1oF0S3r7uOFFwWxc1PnCbHpfHHYCy0O/gj7pr6exu58VfgOFtHSHKponhIYU0d50ccfBSa//XQuYWSjODYo2rsOdalQa/NznUtpRTTmwd+FxCjpqG3MUbn6quUZ6PWK1Qt4iutBsivjQA7jqE9hJ4adeq3OfYkUJkYZVSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nbxhs1F8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244580523a0so6979845ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170402; x=1755775202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdBbh52+wdbpaseYwLsgYNiA8SzI9KZV+XaS3AIB8eM=;
        b=Nbxhs1F8HiInzOjis5zNYWvcbsFmhuakE0lnfS7DzAzwbx3ULzCqwZ/IEWiQIjTLm6
         6T7QQGIcBBSY4+wxh3KHw3mhxbaYJgm5oWLJ6yGguDvdKuN7hebXJI1wrLGXZyPuNqeg
         +FG6agd/GgvulRGGfTbBWhWI96dKP9IXLcf98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170402; x=1755775202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdBbh52+wdbpaseYwLsgYNiA8SzI9KZV+XaS3AIB8eM=;
        b=nveIxbCHVam2ZV6PiaeZ0cu51HIZX9TjXR2FBDFqWOYj402r1aH5TkgA11rF+TY4KR
         0tAGT66HQyuiiJUbBpE3SAo+bUrKmS/KC8P9pMkB529l4myjsw3xYlx//VGY96Nu2Dlh
         pC+WpYeTvZEl2nvA25R57e20saiAu1Z2sLEo7oTPF1POZ/FVrT6P0Y1RfarqC/W9e07b
         Lad8nPHkYA4e0SrHKT0X8xrvuMwpwEnTN3p/Cf6IWmFd6CVOq0siZeCcDTDAMpRJfCqK
         6TdycRdOSrlh7+rkUpGGusN/ZMyaawXCfdVg4C1+LsNc2P76nMQAjLoaZINghjsTdtr1
         90Yw==
X-Gm-Message-State: AOJu0YzUQhPqTqXHbiW+w1m56Jddrds47eJQ8Pyvr3yNhJYyW9KFCvVu
	2kZF4tb5cf98XvpvPvk+e2kjTHPZgAwMTwGp1Fz68HQPV7diGrPaHBpp/dY2asMQknWrMsvSKJk
	617Y=
X-Gm-Gg: ASbGncs1OVYD7bQl8oBI/Bb3n7e8swz5nOpi4Qq0kDxdGU35UlVkaq4slJxsjt0cWL+
	6WBRLiJwaAS6CgyXLe6q4j09cP8xQqOAE3oxgujQkTxuQ4YJNZvgKmj3k3EFII4G7RfCsI2crhB
	ULOo1y2ZwbBjJan96R+QNt3mX24Vzrcq+nwu/LDd1qhc1Z7qWU9lSuokbFEaBXDVRUskC4qpHVD
	WYdqGZ8PJ6EuduCqEbnop/IC9oX1WyIF3rh62Xsce9DPzP/0tXZPA97U5Y3qnNO21j6ng010kUP
	1LYqWV5WYQd80Bi5zhLzwfN/jBZhFCE1N1LKQIsjjrUlLBYbkLYayT485OXPaR+We4i14tihOOC
	PHgufAHHXYJE73h6xHzweNy6jBokBQIfifb4Z8LCTM+t0iDviibLltDd/QDMYmmzc4IqgPrtGrN
	xKaUXicNHdp9joGZn/5bimgDhxtcEDT1Gv5IHCnIKv
X-Google-Smtp-Source: AGHT+IHKv9dsQP5pOfjlji2VmP1NWi+YtMH4mfaFWBtusBYCW9WCcIZm9b1KU1mh84iJDOp08KiZtg==
X-Received: by 2002:a17:902:f693:b0:242:cd69:faa6 with SMTP id d9443c01a7336-24458b25ffdmr34691675ad.29.1755170402470;
        Thu, 14 Aug 2025 04:20:02 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:02 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH rdma-next 4/9] RDMA/bnxt_re: Avoid GID level QoS update from the driver
Date: Thu, 14 Aug 2025 16:55:50 +0530
Message-ID: <20250814112555.221665-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shravya KN <shravya.k-n@broadcom.com>

The driver inserts a VLAN header into RoCE packets when the
traffic was untagged by modifying the existing GID entries.
This has caused the firmware to enforce only VLAN-based
priority mappings, ignoring other valid priority configurations
set via APP TLVs (e.g., DSCP selectors).

Driver now has support for selecting the service level (vlan id)
and traffic class (dscp) during modify_qp. So no need to override
the priority update using the update gid method. Hence removing
the code that handles the above operation.

Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c     | 94 ------------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 40 ----------
 2 files changed, 134 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f08948a49976..a66da4892ad4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1870,81 +1870,6 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
 	mutex_unlock(&rdev->qp_lock);
 }
 
-static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
-{
-	struct bnxt_qplib_sgid_tbl *sgid_tbl = &rdev->qplib_res.sgid_tbl;
-	struct bnxt_qplib_gid gid;
-	u16 gid_idx, index;
-	int rc = 0;
-
-	if (!ib_device_try_get(&rdev->ibdev))
-		return 0;
-
-	for (index = 0; index < sgid_tbl->active; index++) {
-		gid_idx = sgid_tbl->hw_id[index];
-
-		if (!memcmp(&sgid_tbl->tbl[index], &bnxt_qplib_gid_zero,
-			    sizeof(bnxt_qplib_gid_zero)))
-			continue;
-		/* need to modify the VLAN enable setting of non VLAN GID only
-		 * as setting is done for VLAN GID while adding GID
-		 */
-		if (sgid_tbl->vlan[index])
-			continue;
-
-		memcpy(&gid, &sgid_tbl->tbl[index], sizeof(gid));
-
-		rc = bnxt_qplib_update_sgid(sgid_tbl, &gid, gid_idx,
-					    rdev->qplib_res.netdev->dev_addr);
-	}
-
-	ib_device_put(&rdev->ibdev);
-	return rc;
-}
-
-static u32 bnxt_re_get_priority_mask(struct bnxt_re_dev *rdev)
-{
-	u32 prio_map = 0, tmp_map = 0;
-	struct net_device *netdev;
-	struct dcb_app app = {};
-
-	netdev = rdev->netdev;
-
-	app.selector = IEEE_8021QAZ_APP_SEL_ETHERTYPE;
-	app.protocol = ETH_P_IBOE;
-	tmp_map = dcb_ieee_getapp_mask(netdev, &app);
-	prio_map = tmp_map;
-
-	app.selector = IEEE_8021QAZ_APP_SEL_DGRAM;
-	app.protocol = ROCE_V2_UDP_DPORT;
-	tmp_map = dcb_ieee_getapp_mask(netdev, &app);
-	prio_map |= tmp_map;
-
-	return prio_map;
-}
-
-static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
-{
-	u8 prio_map = 0;
-
-	/* Get priority for roce */
-	prio_map = bnxt_re_get_priority_mask(rdev);
-
-	if (prio_map == rdev->cur_prio_map)
-		return 0;
-	rdev->cur_prio_map = prio_map;
-	/* Actual priorities are not programmed as they are already
-	 * done by L2 driver; just enable or disable priority vlan tagging
-	 */
-	if ((prio_map == 0 && rdev->qplib_res.prio) ||
-	    (prio_map != 0 && !rdev->qplib_res.prio)) {
-		rdev->qplib_res.prio = prio_map;
-		bnxt_re_update_gid(rdev);
-	}
-
-	return 0;
-}
-
 static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
 {
 	if (rdev->is_virtfn)
@@ -2106,16 +2031,6 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 }
 
-/* worker thread for polling periodic events. Now used for QoS programming*/
-static void bnxt_re_worker(struct work_struct *work)
-{
-	struct bnxt_re_dev *rdev = container_of(work, struct bnxt_re_dev,
-						worker.work);
-
-	bnxt_re_setup_qos(rdev);
-	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
-}
-
 static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	struct bnxt_re_ring_attr rattr = {};
@@ -2270,15 +2185,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		if (rc)
 			ibdev_warn(&rdev->ibdev, "Failed to query CC defaults\n");
 
-		rc = bnxt_re_setup_qos(rdev);
-		if (rc)
-			ibdev_info(&rdev->ibdev,
-				   "RoCE priority not yet configured\n");
-
-		INIT_DELAYED_WORK(&rdev->worker, bnxt_re_worker);
-		set_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags);
-		schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
-
 		if (!(rdev->qplib_res.en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT))
 			bnxt_re_vf_res_config(rdev);
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 68981399598d..ce6ec3412c11 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -397,46 +397,6 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	return 0;
 }
 
-int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
-			   struct bnxt_qplib_gid *gid, u16 gid_idx,
-			   const u8 *smac)
-{
-	struct bnxt_qplib_res *res = to_bnxt_qplib(sgid_tbl,
-						   struct bnxt_qplib_res,
-						   sgid_tbl);
-	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct creq_modify_gid_resp resp = {};
-	struct bnxt_qplib_cmdqmsg msg = {};
-	struct cmdq_modify_gid req = {};
-	int rc;
-
-	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
-				 CMDQ_BASE_OPCODE_MODIFY_GID,
-				 sizeof(req));
-
-	req.gid[0] = cpu_to_be32(((u32 *)gid->data)[3]);
-	req.gid[1] = cpu_to_be32(((u32 *)gid->data)[2]);
-	req.gid[2] = cpu_to_be32(((u32 *)gid->data)[1]);
-	req.gid[3] = cpu_to_be32(((u32 *)gid->data)[0]);
-	if (res->prio) {
-		req.vlan |= cpu_to_le16
-			(CMDQ_ADD_GID_VLAN_TPID_TPID_8100 |
-			 CMDQ_ADD_GID_VLAN_VLAN_EN);
-	}
-
-	/* MAC in network format */
-	req.src_mac[0] = cpu_to_be16(((u16 *)smac)[0]);
-	req.src_mac[1] = cpu_to_be16(((u16 *)smac)[1]);
-	req.src_mac[2] = cpu_to_be16(((u16 *)smac)[2]);
-
-	req.gid_index = cpu_to_le16(gid_idx);
-
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
-				sizeof(resp), 0);
-	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
-	return rc;
-}
-
 /* AH */
 int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			 bool block)
-- 
2.43.5


