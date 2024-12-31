Return-Path: <linux-rdma+bounces-6771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F79FEC72
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 03:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ACC16131A
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220185464B;
	Tue, 31 Dec 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dbt4Ft+x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6510F1
	for <linux-rdma@vger.kernel.org>; Tue, 31 Dec 2024 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735613810; cv=none; b=r8LGimP0Hg6QJPci1KonX82tOOODVC4CFVhcu+dOiZuRQOw/b4po92/OBYoD1KrzvuJrcuEgP6eDalnojVrErHZSR+QVB1xoiRiadfXLkqNQLtlzHRKuv91ln1D4dugAFURuV15ZASt1toLqo34KTgK1aqcCtjK9YJMfSC7x6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735613810; c=relaxed/simple;
	bh=AirrZFwn7PLT55nVKOUBpQ7z2ed0xw5GjXHpV+KDK9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmTfF2PcpHLnVTrBEhaL/InJdDnEypFIFBjlPghwGbhGhnT4r12p6bV/t+NMRx06ASj//1y884NE3kc+auM1d446LCOgLg7qmtg/7AR9EsJtVQN0TaQAH48GaTtP6F18eGV9PUdHL7BbYivuzwyNpsUoG5JUARm2t80CDfobGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dbt4Ft+x; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so12973902a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 18:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735613808; x=1736218608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuX4XfyI06e+2aFb6ajN6wRV8OjwFev1WW7yMwP0jiQ=;
        b=dbt4Ft+xhMmnB9vfUHax6epXLgnsRVmKpaFmDiU8SxlsP9dfOVxRvX7ZQIavVQQk/p
         IuHnxFIUQDtdg8dCWh4UT1tnHhR2Y/2Zk9AEiJrMS4kqLb9UDNW6gGe2B7+5KlvzKUnO
         +l4tpW74uBfxAjBu/1C5VYD2heXdJ3FGFCOs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735613808; x=1736218608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuX4XfyI06e+2aFb6ajN6wRV8OjwFev1WW7yMwP0jiQ=;
        b=PDWtwXc2mxj05Ji3/fnuL76fzCv/P09QRwn6ITHjeSkRknHnnongsLKoxjCKhoFx9z
         +tpoumIivmX8i6p5imo2NOqx/Kw9TOQ3wUKrpUAWIiELhAovn1TijnHiChKJFw+Lm246
         qAZCfDR3CUdkYf8fmW0eMBXnSg6XhFqtHZ82jU13yDEyIoEAft7JXwah5ovO7KK72Pqj
         lGtxX3SemT3VLAo++DoZN2g9NudTxXTezOo4Tnb+J6nXBgZMHoWTiF85Lx7AjZ3Lpqo9
         5FLFxBvLHZKCvDSAUVecWZoZmbQrnQf5zNwfcaGFBSvBoBiup+ddRfwwPilY7Hv404JH
         B3UA==
X-Gm-Message-State: AOJu0Yyehyu8BoeJpGHYMtmoG6OmRWuQRovvY9GiCWVVZ50nE1pEVO6k
	2r0FQ7o3JzFpU5qN4p9BMKxA12MECeHWOBngqBVxmoKJyrFfoytVEiFib1iF3A==
X-Gm-Gg: ASbGncsz5MXTTGIjLeG3Ejjudax2IzxNSrUbs63kkbxh3kHbspxFXwUp4xvvwXRIVG0
	oNxLXJDmqzmXxUfZ0Wu78nMtXymrayifuF6tGIh/Fbl2pH8owma2Yzs93Oo5+uPUhFA5FAc6bUs
	DlzDUKoe+8Lv6I5IoxGq7TeUGoGUUqFh96Dme71Bj4zNV2txnK71KeNpM5tqNgJuTrYKdWvIv1Q
	foav/2WePn53zSQavqxq2MCKEoUlaAhmZtm+nlibhM32HxsTQmWWHZj+9B6WCa6zP4rNAkV21Ti
	S+oOHnul6wL49MGA5Rx7WXP9zKB06/v67/Iub6HX96TkdXKKK6dAoyb/Zbw=
X-Google-Smtp-Source: AGHT+IGuV6xrCEFwYo2zFEUoYnZq2osdsq9cI+JQroD6CdD2GqCYIdiMTsdfp7QXHOxB5+e8Z8WBLw==
X-Received: by 2002:a05:6a00:398a:b0:725:d1d5:6d86 with SMTP id d2e1a72fcca58-72abde989a6mr52900551b3a.19.1735613808536;
        Mon, 30 Dec 2024 18:56:48 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c182sm20616236b3a.189.2024.12.30.18.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 18:56:47 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc v3] RDMA/bnxt_re: Fix error recovery sequence
Date: Tue, 31 Dec 2024 08:20:08 +0530
Message-ID: <20241231025008.2267162-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed to return ENXIO from __send_message_basic_sanity()
to indicate that device is in error state. In the case of
ERR_DEVICE_DETACHED state, the driver should not post the
commands to the firmware as it will time out eventually.

Removed bnxt_re_modify_qp() call from bnxt_re_dev_stop()
as it is a no-op.

Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
V3: As suggested by Leon, removed pci_channel_offline() check from this patch.
    This will be reviewed further and push a separate patch.
V2: No changes since v1 and is just a resend.
V1: https://patchwork.kernel.org/project/linux-rdma/patch/20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com/
---
 drivers/infiniband/hw/bnxt_re/main.c       | 8 +-------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 5 +++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b7af0d5ff3b6..c143f273b759 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1715,11 +1715,8 @@ static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
 
 static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
 {
-	int mask = IB_QP_STATE;
-	struct ib_qp_attr qp_attr;
 	struct bnxt_re_qp *qp;
 
-	qp_attr.qp_state = IB_QPS_ERR;
 	mutex_lock(&rdev->qp_lock);
 	list_for_each_entry(qp, &rdev->qp_list, list) {
 		/* Modify the state of all QPs except QP1/Shadow QP */
@@ -1727,12 +1724,9 @@ static void bnxt_re_dev_stop(struct bnxt_re_dev *rdev)
 			if (qp->qplib_qp.state !=
 			    CMDQ_MODIFY_QP_NEW_STATE_RESET &&
 			    qp->qplib_qp.state !=
-			    CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+			    CMDQ_MODIFY_QP_NEW_STATE_ERR)
 				bnxt_re_dispatch_event(&rdev->ibdev, &qp->ib_qp,
 						       1, IB_EVENT_QP_FATAL);
-				bnxt_re_modify_qp(&qp->ib_qp, &qp_attr, mask,
-						  NULL);
-			}
 		}
 	}
 	mutex_unlock(&rdev->qp_lock);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5e90ea232de8..17e62f22683b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -424,7 +424,8 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 
 	/* Prevent posting if f/w is not in a state to process */
 	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
-		return bnxt_qplib_map_rc(opcode);
+		return -ENXIO;
+
 	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 		return -ETIMEDOUT;
 
@@ -493,7 +494,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	rc = __send_message_basic_sanity(rcfw, msg, opcode);
 	if (rc)
-		return rc;
+		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
 
 	rc = __send_message(rcfw, msg, opcode);
 	if (rc)
-- 
2.43.5


