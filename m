Return-Path: <linux-rdma+bounces-20977-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAtXLBqADGo1igUAu9opvQ
	(envelope-from <linux-rdma+bounces-20977-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:22:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3BF58154A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635D930E6041
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD431E107;
	Tue, 19 May 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R922KWQq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE423AFCE2
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203408; cv=none; b=PM+zDaY/A23PQysafRtBD9IQeK4QIZm0FMRn264Ue4nIANW5XukI9+LJrrSLC4JrULJazhi1CCq3TJl+FW53ZsJq68PL1VizhZ+JmQVb9cvv4IOfdSxXN6D1BA6MhExPzRAe6vOQQQ6P0sz2ykQA0q0ziIGOZZj2lHUju88/UmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203408; c=relaxed/simple;
	bh=MJyTuZTTLntARMzg56dJ4YbrqGtkEu6XQ9x8NFlAheI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rih5q+Hb89jPCMaFDBySoROVZC2FBn5kOudrtzKvjbrifKcdVi7QBkhgOkQpsqstljArkNZuL+yn9KmeO4CDwMm+NGTjDgXIPSNx7qjJQZl/3/LpxQYzySBgNQX8+lDY8/GFPAFa+DUVpCSSnaDiH+iO906eBjcMNJ/e4qjFhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R922KWQq; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-82748257f5fso2967679b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203406; x=1779808206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=EXWMMWp0bs9KLGGz8j2ER4kzJgJUJcAZaxVSKFKDhX9RWjEOEIhz0piamakM7cAl1e
         1EMoNHNHiD58FuaJCVSaPmTU3ABHEI7UXEx/Jqk4HWnMn62/q4ZVmJxJvzAMRa2jbqts
         JnIFQKj/v6kfN+Pfb9apRGhxvyXZtpt1KwT3RNbE7lnmIqUn7C7hPN78BOvUd7vdvm2n
         NyY3efwZ3PmZvxhIncI7o6LcASfpdKrVuOvv7JRRZZ25h54iq3O12v2AXucs9odGzPA9
         LsXrMzP3a11NZ6hzS/6V3wMWMf5sy8Ny+Q4GOpN1PlvLuJW4k8bsi0XCW+QlV0zoJci+
         EqaQ==
X-Gm-Message-State: AOJu0YzPkH/SXZ33xWVRJwKXaPT1VkGwNDXA072/Tac9c/C0NO+yqyd3
	4ks7nrOB2681GyNE3dxEcbV42DliN8S8/QL38JxM/SJ5Rl5kGD7A9U0dMVudoYRldQ695T2v42H
	M6KamRC66c1rgPsaFi7azqYXo+xMjFiLsPKYRvggG9DgXznIUUgsuPC1uYbBONIippsrfdQEsZA
	b+cVS8LnhymIdaZb+H7hVVHOnswXSw/xQfCapxGL69jO2Ov51VnHfXpgzVZd9Vjf2YDR8+zRpeJ
	kt1+/EyGKE6iu0rkoSOo/t72FKT
X-Gm-Gg: Acq92OGvfyijROT0mYixae/EQb9KHtAGL69mBBSNFcPPoaVbWZhd0rHqBn4yby0EXL7
	VJaa0/LaXo8jS4dcJ+limgaCw6Ga/12z6apn5I5JQ4lyUnFfAGqo5AJcH35iztRkdvRKvTVfX7X
	TtDsMEiN/KUxz0EBaJ2NVrynQ9sChHil+4MCkaLfBzBN0oe7K2O/EJES8oYOFvF3GixTGS56pF6
	alTpAg0JF5u6a6CJdxgPSntaj5Byt3E7ujXNsABQ+xrTQf2K2uPOHHjtYH5ycCB6rg3pn9SRM94
	dLRWCmxwY2AxVufkfNsMLxNIy8nENgAp0YjnYkXAFWZbyAJ14X4rh42To5Mg6o8h+F/ru0GuGa2
	0j/T29bUCOmo7cZT9PnHj4Ghatyd+CUL3YB2Xaj0bQCAcHgFRx7WG05m0sxOKiBkDLQ2nwbbfJR
	hJTAz5N1TJptzV/+9nRZ+wauuPJXPmAKCZa8MzX3ACiEoaUWcn+7g0JcvPS1e/0GqNTA//2M5NY
	KmLLuo=
X-Received: by 2002:a05:6a00:9290:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-83f18e769b7mr19777539b3a.19.1779203405522;
        Tue, 19 May 2026 08:10:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-83f1983b319sm1253292b3a.6.2026.05.19.08.10.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba054e0304so36581515ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203403; x=1779808203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=R922KWQq/XCkJZRaS4MjPwk0dL1IuUjQDwAxhICNgPys7snuuyfyMVfIenSJta07b2
         78hogHW9mvM4/pp595VHrhy1TKXLgqwI8eBPKhJhpSSStptwJ1YIi9uxv15CMrQKEM5w
         Al5poG/J397SRStkq45UCtOMxVUR0uxEN24yE=
X-Received: by 2002:a17:903:3850:b0:2bd:6327:b507 with SMTP id d9443c01a7336-2bd6327b69bmr204708485ad.18.1779203403247;
        Tue, 19 May 2026 08:10:03 -0700 (PDT)
X-Received: by 2002:a17:903:3850:b0:2bd:6327:b507 with SMTP id d9443c01a7336-2bd6327b69bmr204708185ad.18.1779203402750;
        Tue, 19 May 2026 08:10:02 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:02 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 2/9] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Tue, 19 May 2026 20:30:34 +0530
Message-ID: <20260519150041.7251-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20977-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3D3BF58154A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to add extra slots or
to round up the slot count. Use 'max_recv_wr' count provided
by the application as is.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 561d491f12ff..c67179160654 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1475,7 +1475,8 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 
 static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
-				struct bnxt_re_ucontext *uctx)
+				struct bnxt_re_ucontext *uctx,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1500,12 +1501,16 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 		init_attr->cap.max_recv_sge = rq->max_sge;
 		rq->wqe_size = bnxt_re_setup_rwqe_size(qplqp, rq->max_sge,
 						       dev_attr->max_qp_sges);
-		/* Allocate 1 more than what's provided so posting max doesn't
-		 * mean empty.
-		 */
-		rq->max_wqe = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1,
-						 dev_attr->max_qp_wqes + 1,
-						 uctx);
+		if (!fixed_que_attr) {
+			/* Allocate 1 more than what's provided so posting max doesn't
+			 * mean empty.
+			 */
+			rq->max_wqe = bnxt_re_init_depth(init_attr->cap.max_recv_wr + 1,
+							 dev_attr->max_qp_wqes + 1,
+							 uctx);
+		} else {
+			rq->max_wqe = init_attr->cap.max_recv_wr;
+		}
 		rq->max_sw_wqe = rq->max_wqe;
 		rq->q_full_delta = 0;
 		rq->sg_info.pgsize = PAGE_SIZE;
@@ -1676,6 +1681,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
+	bool fixed_que_attr = false;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
 	int rc = 0, qptype;
@@ -1724,7 +1730,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	}
 
 	/* Setup RQ/SRQ */
-	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
+	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx, fixed_que_attr);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


