Return-Path: <linux-rdma+bounces-13153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9242B488AE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 11:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E153189078C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883322ECD13;
	Mon,  8 Sep 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O+u62tKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2427F4F5
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324343; cv=none; b=DvtXn+ycpw2dWSUcYXtmL9KTVSglWMAv6Vx0MWfhza4HbN8du8sqzGyMZ/CRUki/5sDDMi/da23L3s7Tiq1jnXs3FxSrShJcmRwIEPpo/K+qGEDaPP2c1wz/c2A+Qft0Jfm1AGY3UEaz+BsnxSbzlJTQNevG5761xvauIpeXzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324343; c=relaxed/simple;
	bh=uCbn0TsZDbcf3EXBEsnCLqrPoUIhBXplR/PHwKHXo0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAtcUsV2OabwssEvncdxiKc8ZsvovuNh9ND4U+Eq/ApFWPeTHD6LSEucQA7KC/wXdCGAHQfQwFFYxFnAgJ4kGegiSX0kJP9AK3QSJQTIhoi0oIyJ2xV7Eg9N7RVFYjBNC8pgmjHIMTPIbVRrhb+P9EkgUumWGvLIdDwl0i9Q3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O+u62tKM; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3f660084016so27037135ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324340; x=1757929140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGjl4q66wmN7/ezkb9S+V7QVIqhx40OH4hsVUrE8K0g=;
        b=LkdVzeLlikrmcF2T9uviiUxXKGF+lJPK8mfA6TOjfJHXEuShvbPd/XShmOjC185x+U
         5IhC76GfD6mqShszZP0EvEOyXIW6awVOwUf2XK0OBmcIbzbNyYlEP+oGLSijgVqXr84P
         kjLFXozJ0FHtMQ8dKUxg95KxPXbkZLA3uXhFRG5DsDWkiOONektNyXBR86hlMjEtaveh
         JhqYegrNngC7gYAc9HKG96uMblgUjqI2FzbgT4S7Kpw7XiBcX/HJ2s7n9dnEKWAI1xAj
         zBGz/XVCCkcvw4dYt+n/2lLBdWP4NFf3jz7SrpFLIPlYnPdj2mcXTZxlKlStPA3n/IX9
         67cg==
X-Gm-Message-State: AOJu0YzetbJDVwoAbhkcTRo/MZ79hZ3dk04L7q4PzY2JcTkrE7sUJLVN
	zgVuFpH+LT8UqZszNo8jgYfufvxOkAosp4kf2nAsyfhjtQ7G85C+wRMytLFMdAATad5mz7E2CJq
	fsoeZR/WQEAM1Yf1kzNjW9DlckL9ohxgcsVK5BfiISrPbsOXLs5/HrY5bOX8K4bpKBFp0VOUZJU
	wgHA8bChMRAJct8N00AkxtYrHhxyH9V960bEXoRffSiGQmPbdvPo3MWqNSIUwguoGeSLxFjVqLa
	4OAIwBUrIzozm6jewnKm9BA4ymnzg==
X-Gm-Gg: ASbGncvV5I2AytL7RMsdKCbw4byY2Bt0jM8RdigvJIqO4W/9XUAVSR1RDAQDQQBKDIp
	xA1rnko0mVay9tYOm5kW0wQe8qrXTgYE2A1ZMiFRZ0uTFkrIotS1N3yECivPi4JtwjVKLcMk4W3
	aOp63Co0iu6ZnGcBIrErHKk8nf5BI1NxzlVJDyv0og1TGumOcmF7X9Bu72AH+Aey9udOfzpr+6J
	Uqn0XAR2TpMGxZZu3mAX3nDzg2hD74gxBYrhou/Vqjbnu3rGtNv2hfq5ijc697J4R62sQwF5pvl
	XuAGl3rH8uWR6sK5V0j0FKkSdSyUv97R4nhi7QtQ48N8mCzjkLOEsu14xqATUSum7zdWd46sDZM
	7yz4craMkxi1TzGrHvS5oqxELF4SHqNRAQEkIOUs9njTmSuH7jfwiMfrvz/w34nW6WJ9B8FVtak
	/XGW80b+GhoOSC
X-Google-Smtp-Source: AGHT+IEentAnI1yj0z6qRZ5KdLBVgjnziNgHhb/Jl+pNRxdF1zphm0ZkabxVVNMn+VJXwHdjra5MXgfIwMD5
X-Received: by 2002:a05:6e02:441a:20b0:3fe:33d4:8890 with SMTP id e9e14a558f8ab-3fe33d48949mr83910705ab.17.1757324340610;
        Mon, 08 Sep 2025 02:39:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f8af8752dfsm7010415ab.42.2025.09.08.02.39.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:39:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-252afdfafe1so17597755ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Sep 2025 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757324339; x=1757929139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGjl4q66wmN7/ezkb9S+V7QVIqhx40OH4hsVUrE8K0g=;
        b=O+u62tKMfpPej6XHFf+uuytIdvHaKQoHnKzyK4RtuI42K3CgQhHuDwb6NWtsigj4v/
         vEGRJOaT3Cc4uIaqpCxqI5A0k13zb2F59b1uxiUxVNLyP3XjpHNblhYJ2CuTikkaE1PV
         3dkuOF33UWeSRiO1+wnCtlIynPaZ3vhSPlCv0=
X-Received: by 2002:a05:6a20:7fa5:b0:243:f797:fdf9 with SMTP id adf61e73a8af0-25344415f91mr9005557637.47.1757324339115;
        Mon, 08 Sep 2025 02:38:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa5:b0:243:f797:fdf9 with SMTP id adf61e73a8af0-25344415f91mr9005549637.47.1757324338715;
        Mon, 08 Sep 2025 02:38:58 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d8ead7bbbsm1629283a91.16.2025.09.08.02.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:38:58 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH V2 rdma-next 2/2] RDMA/bnxt_re: Avoid GID level QoS update from the driver
Date: Mon,  8 Sep 2025 15:15:16 +0530
Message-ID: <20250908094516.18222-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250908094516.18222-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  4 -
 drivers/infiniband/hw/bnxt_re/main.c     | 97 ------------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 40 ----------
 3 files changed, 141 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b5d0e38c7396..2cce7818daaa 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -174,7 +174,6 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
-#define BNXT_RE_FLAG_QOS_WORK_REG		5
 #define BNXT_RE_FLAG_RESOURCES_ALLOCATED	7
 #define BNXT_RE_FLAG_RESOURCES_INITIALIZED	8
 #define BNXT_RE_FLAG_ERR_DEVICE_DETACHED       17
@@ -187,9 +186,6 @@ struct bnxt_re_dev {
 
 	int				id;
 
-	struct delayed_work		worker;
-	u8				cur_prio_map;
-
 	/* RCFW Channel */
 	struct bnxt_qplib_rcfw		rcfw;
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4703ed3ec928..a55ea813176c 100644
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
@@ -2071,9 +1996,6 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_re_net_unregister_async_event(rdev);
 	bnxt_re_uninit_dcb_wq(rdev);
 
-	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
-		cancel_delayed_work_sync(&rdev->worker);
-
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
@@ -2106,16 +2028,6 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
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
@@ -2272,15 +2184,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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
index b602a1da19cd..79edff6bda95 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -396,46 +396,6 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
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


