Return-Path: <linux-rdma+bounces-5998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F92A9CDB1B
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EACB2263F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4618CBF2;
	Fri, 15 Nov 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PJATuAiM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2F188A3A
	for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661715; cv=none; b=TmMKN87ucztUaLZEG+r9u1ha3dEUNNnkLOYBavagDym1J3n8qpa2BjkFOqBkyIUArjXZz1C9eU/zIsdxfwvK8j2+THrYiascd6v1A5OnKCFLHrUHWJZMoM+jPoy6cek0ugVxkVY96lE0qj0PezEwXc6tufiHt6ufC3r2oF/sQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661715; c=relaxed/simple;
	bh=jO+6wrlHF7JEkrR57DxrmHttnb9NFFYqU2jKUtuEMdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E3brQxjVggBkYea0nSU255OOM5jCalasCQ1U8XZ8d23w/pu7XuUQ3KhRtMpZc7RFso74iwjrt/KOdue/kKjupXHMtIr//IUiCfWVVCep+tQylGKrEkE9nI/4XjmZTE9QsRih2mnQmYQsFaPZdr991vRf9ev2qWifIAMaOuKsDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PJATuAiM; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1398757b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731661713; x=1732266513; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dg/hdqJktBcdJNz2xR56FmxvAVyE+yddqh0hutwjZ44=;
        b=PJATuAiM9YHaKjsuPn1WTDtapWvuJ07V/rVn0Ho8S5Z5E8qga2A+JVPbuFybCwO8gh
         gCs9M3abr7zVJcKmBDVhlPtnw2iNnsyd/jZR1nDqTEnJRWUbZvUfHtvciyTebKyuZxn8
         rxyYHWDFvJGVB1xuM6hiUIJBQWF8SPutSelrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661713; x=1732266513;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg/hdqJktBcdJNz2xR56FmxvAVyE+yddqh0hutwjZ44=;
        b=VwaBblkoYajm1h1UPWlqBkCMVgPHL5GgqG9G8z+FUPFjKodYHsAVPDoU3PyAQi4j1q
         q24n0/SOZ0HZcI3dKBV5kj/aWgrTMvBmHC/kiLFEa1U4ztC8Bssg1oUY2t2KU3Vxnypd
         T9JZeD94QRAR85uz2xPPFqCMeHesPg0Fnhmo6FvgJVvIs25wpvv1o/uPNHmBF/X8COQB
         p8KyXcVKecWIT8KeH17GKuJBEM+Hm3asFgiz0EMARPHLDASbjn4eCIgKQCLJoI/ijnwh
         IYd12WrfDD9cW56i8si5rpWnH0zl8SXgfhWehw6IPDt1QIdJ8l0/+FUDzQTDf5jaEYj2
         xgFg==
X-Gm-Message-State: AOJu0Yys8llooFfxcY2X7iRjTy+aV8oQoI1hq7vRaFejGRHR1vzg3vP0
	uzLNG9gsWS0nLrF8ayR2AQZQIaQa00nkbeDsgmCG7P+dp1APoL8YOFEh75JD6Q==
X-Google-Smtp-Source: AGHT+IE+rx3zQYPKHhNBRB++8EY3MtAPuEYRkh34QwWxbGH3KEgdDyHCqtiJYJypZ2UuJKLtoN+UyA==
X-Received: by 2002:a05:6a00:1393:b0:71e:7b8a:5953 with SMTP id d2e1a72fcca58-72476cb4154mr2298431b3a.24.1731661713529;
        Fri, 15 Nov 2024 01:08:33 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711de6fsm927926b3a.61.2024.11.15.01.08.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:08:32 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 1/3] RDMA/bnxt_re: Support different traffic class
Date: Fri, 15 Nov 2024 00:47:42 -0800
Message-Id: <1731660464-27838-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Adding support for different traffic class passed
to driver. Fix the traffic class setting in modify_qp
by skipping the ECN bits. Pass the service level received
from applications to the firmware.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f6e9eef..481261f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2136,7 +2136,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		qp->qplib_qp.ah.sgid_index = ctx->idx;
 		qp->qplib_qp.ah.host_sgid_index = grh->sgid_index;
 		qp->qplib_qp.ah.hop_limit = grh->hop_limit;
-		qp->qplib_qp.ah.traffic_class = grh->traffic_class;
+		qp->qplib_qp.ah.traffic_class = grh->traffic_class >> 2;
 		qp->qplib_qp.ah.sl = rdma_ah_get_sl(&qp_attr->ah_attr);
 		ether_addr_copy(qp->qplib_qp.ah.dmac,
 				qp_attr->ah_attr.roce.dmac);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e56f42f..256c437 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1318,6 +1318,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct creq_modify_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_modify_qp req = {};
+	u16 vlan_pcp_vlan_dei_vlan_id;
 	u32 temp32[4];
 	u32 bmask;
 	int rc;
@@ -1414,7 +1415,16 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_DEST_QP_ID)
 		req.dest_qp_id = cpu_to_le32(qp->dest_qpn);
 
-	req.vlan_pcp_vlan_dei_vlan_id = cpu_to_le16(qp->vlan_id);
+	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID) {
+		vlan_pcp_vlan_dei_vlan_id =
+			((res->sgid_tbl.tbl[qp->ah.sgid_index].vlan_id <<
+			  CMDQ_MODIFY_QP_VLAN_ID_SFT) &
+			 CMDQ_MODIFY_QP_VLAN_ID_MASK);
+		vlan_pcp_vlan_dei_vlan_id |=
+			((qp->ah.sl << CMDQ_MODIFY_QP_VLAN_PCP_SFT) &
+			 CMDQ_MODIFY_QP_VLAN_PCP_MASK);
+		req.vlan_pcp_vlan_dei_vlan_id = cpu_to_le16(vlan_pcp_vlan_dei_vlan_id);
+	}
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),  sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
-- 
2.5.5


