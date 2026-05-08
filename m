Return-Path: <linux-rdma+bounces-20225-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LcrBCyp/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20225-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:13:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382474F41C8
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17022302E40E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706237D12A;
	Fri,  8 May 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e95DZYd5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043F364E9A
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231304; cv=none; b=QNHJq6E+dLcahn4sarHijfbvrIKQJSfa8QjomDWI2fUkq1gVxsveRj723fNWaSZC4D3CIcNV2cPyAWiNaolqTuE8rZc6Ss2U65p6/q7fg7wPFtk1DSx8/G42BHKM3c6Y3o0yjCXoS5iF2jcjNUbx46yZ9ubCpWV7Q/ZKsJ2ZgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231304; c=relaxed/simple;
	bh=9V/WoB/9U3eAeuCCwyrhgi20SvC42R3pB/6wX8EMScI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baoTGkHc26C+ju73+h93wrq/67VPB5I5wKkiX6dnQx9XgKiQj+0p8/01J6Fb2dpzE+NJ71p9uGZj4ah7SD07c6fCraFuR3sdMrpzDImDj+4m4n/5gU0kCa1WhFTR8+VqjKJ0paPLbC21GkY11dGrmYYQrJvm7TV6NkyUaBjrhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e95DZYd5; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6949831a7bcso984653eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231301; x=1778836101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+J5jjfmXDWoRSTMYY+lXaonhlsKDPg8Z+SvbaRGZts=;
        b=gwCtCV944AF/F6JA25FEdzkyEflOKJEEVNavwTWyBBrGLeFDhoQ0IsYLUZWWFNspWB
         jXQmwZT4hmJU+e0t+wkLHjfpJ5m6qBCbkDtMOyC9nvdf/zwHV4OMFagOpQEvzOcHt9ah
         cpcMAmD+Qloajz8wk4Ga6tFeYNAgwiKp317W+g57C3pDgu/kMy56+zSDLjYsgtf5tFDy
         2HUrGk0HlBLHuQHUmx1XRlCgMUY57iDOTEKIfvm6c3MzLnhuyLiRgBZDsHPC+opHbzrw
         BJA86dEj2pEHBuekDb0zH57QuX5a5BrJkUBeJPrFAEhOuZtDs3Gp7al5gvXNQ+0ZIVzF
         hbXA==
X-Gm-Message-State: AOJu0YyzOpJRd0M5Zq46zX59P9vYz97NASe1uuADyWj0Mj4rhZD7PyMX
	fWG5pRriPFGOvbaLNNF5oF/VZWLdk+V/YDXmZ6OA4A9+LRYZYK5HjvS9b7nnfI1+TC+jPUAQf6S
	OOgyBw9T+n1VwSjWZQCA4d0k/qo+YeLdtku32xGo4H80p2G/j7kEFgBaVHAtdeDUAWXNcrcDvUI
	beIUhcCvJ9XrIXKFoNsuk2KVUh2fFzfwGplFbsVt15c15dKS1v7K4MFKptkX/aJAO9WtlnP7333
	8vQ3ck+qtPpvbwHH2Z42NVyB2e/
X-Gm-Gg: AeBDies1spvvffE3adzCtRiDRn/7n2Mg8pAKITHC/QwVQEcx3Ok2oJMO5+ShFLtORL8
	lgORDh2HJnmi8g8MpxD6Dwe9oVuwtcmO4gZ43/qV2HKoAQ1aqAdgoNrj8n5kipy4ErlAlfE9JrW
	otIsZnSFJu0kwkcwlUYc+s0sg6gBsJ+RHvy1Zir2zJqlKPS05dzEAY5iIym+HRvbUrfn5ZiuBo/
	PQZeydfsYKCR+ah5jMZgQwsmeH0B2Zu1VTeVJLHZDrMcgB2g5HPLLL8u5ocGu8FxHi8aB7p3WPx
	yJLZg8jllSbCJptwZQyTcotogP42N5OyqdCwMdHLi0QWQMJ7QAbnFpveWA3G18Qsc4IMeIPQWad
	0HsBDzmmkk6oNSbFoDtUuO425lWohhEi9Pqps2MP3QHBv6T0B/+L/YZDLMW0HpM9k0sm8x5YyBm
	bQjaAieegy5c5XwbKC8Jg+Nay5cHM=
X-Received: by 2002:a05:6820:1b05:b0:694:9156:9b97 with SMTP id 006d021491bc7-69b25b78f91mr1015815eaf.22.1778231301536;
        Fri, 08 May 2026 02:08:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43557135d5esm159044fac.6.2026.05.08.02.08.19
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3663b332420so1225288a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231297; x=1778836097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+J5jjfmXDWoRSTMYY+lXaonhlsKDPg8Z+SvbaRGZts=;
        b=e95DZYd5rwISuM0rzMDd8tNQE6um/IjAfB76D9f7TB8NK7AoAVM3ZisuX2nrxSHgX6
         66NsiDDYZ7Ci30XyIhPcN1HYZ1PsAMBd9dTHVE86JfT99jYLHeDh4W6ivFkd5X5sHcIQ
         bZWKYBTV/9TyrpGhvG4YQ07Wmh3Un5zV/ZyMw=
X-Received: by 2002:a05:6a21:32a5:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3aab16e8729mr2188097637.33.1778231297458;
        Fri, 08 May 2026 02:08:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a5:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3aab16e8729mr2188073637.33.1778231297065;
        Fri, 08 May 2026 02:08:17 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:15 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 2/7] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Fri,  8 May 2026 14:28:53 +0530
Message-ID: <20260508085858.21060-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
References: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 382474F41C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20225-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 561d491f12ff..0ab4ac2f4c41 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1475,7 +1475,9 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 
 static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
-				struct bnxt_re_ucontext *uctx)
+				struct bnxt_re_ucontext *uctx,
+				bool fixed_que_attr,
+				struct bnxt_re_qp_req *ureq)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1500,12 +1502,16 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
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
@@ -1676,6 +1682,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
+	bool fixed_que_attr = false;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
 	int rc = 0, qptype;
@@ -1724,7 +1731,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	}
 
 	/* Setup RQ/SRQ */
-	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
+	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx, fixed_que_attr, ureq);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


