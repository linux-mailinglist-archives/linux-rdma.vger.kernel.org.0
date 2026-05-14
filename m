Return-Path: <linux-rdma+bounces-20711-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLvzKT75BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20711-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB4544BC9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A82A530078B5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E833A9D1;
	Thu, 14 May 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="StCwu75a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8E2D238A
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776378; cv=none; b=O6qvwqCn23CMar/KKT7nxYbVSB1nA//r55T1t92Ya/ilsGxNBGcdKXPaps7yJoBEVM8ir0yCskIVfQCoT55AyKlSlcKhjiD6DLbPpU6LnD5jNqdNs878NoeDh0UITOWYNtw0M8aGBNC8jwpprHc/v4qd3U8hTPmszI9fJ5lawUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776378; c=relaxed/simple;
	bh=MJyTuZTTLntARMzg56dJ4YbrqGtkEu6XQ9x8NFlAheI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1wVpOia8JWho0JRKMSMkyw8EDXFW+HFVya6IgXeiTUl01mK3YGTkL+n4Or2BXtye58bjD8LWsPcA8QbssA9xYVYQ9gNE10Xv7df1NXv015HiPOxEraMNEXhzbbH2XzAFbCpbgaCyCNS8D5cBfIxU5aRJZoDXP4Pddf2T9amfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=StCwu75a; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-65c6a2158d3so7064316d50.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776376; x=1779381176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=L1HFOAabipignJBp6pgfqPPZ5CEkWSUx0xlaVKFTLYQtacF6qRcT0tPDvAKkp3BxOX
         zGkN2a90HvBJMoEJIrv1LyHfsYGPmNdzWa65OqgStSq3kIbS6tkgqQb8YtFJ1zD1gwS5
         P05C56h4ona0M73iMXRgDebG5WIonWMTJ/KsngOEu5CvK3n4oHTr9MkpLlQkaVhATfbO
         MTsgXG5pxE6QRvT64zdkS4BxoQ6HSU6GsorpBPJcrZJRq9R37EwkdTPaEvEXkWqLqq7L
         D8saTXzSPLeNSXri1C7V9AzSa8e581I1FUFLcT8ou7555M9J/kcP7rsdfwY2ljHxNmKL
         ZYWg==
X-Gm-Message-State: AOJu0YzzxxtafmWtivxie7Sb5mPDimimw0sz0KZW70Zafi6/FOVj3FWA
	4iE2xbTsgoPjUgTeyUiLQ0TiZp25omwepf9z1qDUOYAmzAI8pkV0saxMXA2SIp73Sfv+GftTBnq
	Q7qMVhg/1gKq5hXJuEaEhxcb0w1612/YgLqx3F950B+6u+BTCEyEjmufLj7F/0++GxdbM7P+mjG
	ra0BcCyX+udY7Ni7pJl3etFI3XGTH5kF1WYzS2ZhNVLBgfELDo4odlGqa66hz2PSMForg5mPb5E
	kCOb45YfBRQ8U4ZYlMQ8rrG73P9
X-Gm-Gg: Acq92OE3Rrt+xi7fdxz47iYITjpKJmGBQbVxMZhQU+RtGdyN4WFtzc5pTJwQIyRP/YW
	H25cJDje18xUZpfvk1FcMTof4StDQgb6sQ+71Clx3jg1pwIQsP0Lv0H6xkCm48h4QLkuB7Uw5Vv
	GdSa91+FTiYIbVzts/bWqCyHYJGJRpetGHVs5EXpkMTv42PCygW62uJA7iZXWhwa3XueXsQdcSf
	q6rVW35wlPbaOd+K5i1ew8rwWnuwWtXOCbZwi5oQv5N4EcrsaaKTGG0KSN2eNXeztGKdb7lT/dZ
	euT4HvrPnCUwzXOvA5ja2A/O51J780veF9tK4w+KalYgWCr53/6BJvP7j8/6H5bhu/I7mXm2hRM
	jtOpz7KsKlZVBIvV/LfAuA7a5MWGdmgtcqad8tc5n9fhe5nrhK909vKCaMk2IG+ywVkRn6MYLFc
	wRzMW/YO1yDRtW4e2fuG9Wkdd3cy1UeucRF9NwixAWKrzd/o3QAUqHsExqOyavuX6aXcyuoF7XU
	2Sxs/Y=
X-Received: by 2002:a05:690c:4d87:b0:7c0:de77:f47a with SMTP id 00721157ae682-7c6ad089a5bmr94326657b3.46.1778776375946;
        Thu, 14 May 2026 09:32:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8c90a45de2asm2199876d6.18.2026.05.14.09.32.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:32:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368b68a33adso4684824a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776374; x=1779381174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=StCwu75a9XIHpXcjr0FZ55EmgIFXnFH329ub2k4ZQJOGmJmurqkxGc5mu4w0bOQn0G
         LO6DRc9aLqw8Fin+YFrXMvknowAHe6Uazxx2f3CMipNcWOZhA8dZ9ql1VthNPnhIAyn7
         2M9I+SoZAO6bsyNBj2ie3Xors0Cd6Do1f6Oak=
X-Received: by 2002:a17:90b:5848:b0:366:1172:597e with SMTP id 98e67ed59e1d1-369519f2d87mr146048a91.9.1778776374176;
        Thu, 14 May 2026 09:32:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5848:b0:366:1172:597e with SMTP id 98e67ed59e1d1-369519f2d87mr146014a91.9.1778776373664;
        Thu, 14 May 2026 09:32:53 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:32:53 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 2/7] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Thu, 14 May 2026 21:53:31 +0530
Message-ID: <20260514162336.72644-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
References: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 44DB4544BC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20711-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


