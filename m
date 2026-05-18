Return-Path: <linux-rdma+bounces-20915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IF6MF82C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:55:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352057064F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F32D3028F53
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE848165B;
	Mon, 18 May 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jn5nQSDy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E84534A8
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119210; cv=none; b=N8Oqm2aWEre2pdgvN5RnIUW+zRQpW/mRfJde2xR9S7I62cdDMpqJXqd9osjFZ5bXi6KULd0/shmWF6j3mFVF4TPEAm01Yd9FeEu7eyOx4DVhUGfBlIPovPEjK/JnGeD2ftb56HXlfSb6JqgzfCzRkcH5x0x2ZVOJ4aRdS5RcTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119210; c=relaxed/simple;
	bh=MJyTuZTTLntARMzg56dJ4YbrqGtkEu6XQ9x8NFlAheI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+DQyTeqTh5GI2tGG2YdJuGieAyccbYJkEDlKooPJX9SHZ6uQZ9QXTJfp7cVqElep0Qda52sioPYaF/QUPC2/c8aICS1BnLgwNlctsAl+O0i6nPZaISmGSIuHVeEDYbCOMpSP+E35bXRKstTDkC/VZDiuXQi0v4HNjtFB8kRC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jn5nQSDy; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2b45cb89f7eso15895075ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119206; x=1779724006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=JVyvyegSWz36+m2JjPtAlw8Kx3gBryouS+egnoh8rBn2K3/EUcZd4U/cB6dWFnj+qg
         GNaolIbdD0JZyaAkUkd85u5hnvE2SHNvTVa18MX8sTxcP7Gf/b82cYxW4lYmm+tY9BR9
         16ZohCycMx+H3b4FSEWDltptzMzCE7WLd3DTorZfNjg33sJ7kYWVYdhWCjHTnnG2FJLv
         W8lW5XP2rx00Fa0mOzLj2aXPi1/8tGXeiV3kAwRTLiKTETA0WfyEOKyz3ekbWK1JwHKD
         WbPJ2jFeNlcspSz9KmcaCoqidJJ1Ab+ay99f85TajrSwtthFmVjh5/VIJVCxoTUO5QXy
         WD1w==
X-Gm-Message-State: AOJu0YyNtXcrXJjzpP5RFEuHfkcLajpNc7QVeBXoypas8A5sc1Q/jOaW
	E3LOorqEoyFToDoer7fPbRXl40IHg1CSfZ+v5b2PB447I63lgKpJGQz2ucE6k8Hf+ctVkl8Rb2d
	qdYlpXkiajnV5LGWbrjeqYNwpZhWCRrSXHbO9RJ0HjZPDk5Yv/cAugfh4zqHPXclIS//rEtpVg5
	V7uYRiVgWP5JDy0XJbcXM1NLmUOlFuoj2Wvu44/nh/U1T4KGfpo1W6uUgbNB3jFmzMJjIRDgY4f
	/3Gq95wHFSjUGu50+AhI9Q0Nm4q
X-Gm-Gg: Acq92OG40KMipixw3twhaLak4sggKtS/yxJryCn8heiGvG7Stnf7LuX7KoLgQm3Fslr
	+9/JVwguBW5We07DML7z1BUvAnbvhscgMNYk4j6Oz17rLgBRFCBYCg/+zqk+4pnRqhkb2Zz5eIx
	joiQsuLkxKMFjevHkmgwGmGFFzaJNaFeYRTyTmzQNsDXAma3P4ejpGzM/WYTcDFh0JAo+shGKYL
	+Lu55w9j4TNoMH9t6nQ9mI3pyeKcXSFKlklJYKR5OZ76+SHxVg9bbV3eY5OY3LDpOuhlDyF/MDk
	oE0qkm70gkfsv12Pe1ZDz+X3UcOpVOdk/DoXNC22WRH1uOJnn+Z4mdQoJqKWvGhA92c2CoTD9l9
	krm5AtX2qsAJIbNCbxlgILgbG+wM1Qne72rKvbreBVXP8gyLAs083mpIX+1sqWe1A2Ee+ouKifd
	+ohUZ9PnBVmffNXnu2k6+8Uf664C5nd40aU0dNUhAtP2Sfyv3Iyh9RCoF1O+iSGDAo1F0q
X-Received: by 2002:a17:902:a5c9:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2bd7e905aa3mr117466895ad.35.1779119206002;
        Mon, 18 May 2026 08:46:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5c35d715sm11215695ad.24.2026.05.18.08.46.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba268cb5e6so25473035ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119204; x=1779724004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAQPPmcRJWkown1LyDC5bNtlWnHSpD7C7p7K+V4HamU=;
        b=Jn5nQSDyKyYtgneH42LWEnsWIlVmRjpX4NeksZ1coN5Ubwpn8r+vH0Fu1UUwnObjIH
         0hN6hevNn8JePs34KPX0HIynh8q+TmRhAIvRAeFMe/gC+JBEiLemrz4nOgQwBw5mduLR
         qkgXbEeSyAzwqs9CMqEB3BHXSPQn0O2eVyeS4=
X-Received: by 2002:a17:903:298b:b0:2bd:5b1c:f78e with SMTP id d9443c01a7336-2bd7e8bcfedmr160948635ad.28.1779119204164;
        Mon, 18 May 2026 08:46:44 -0700 (PDT)
X-Received: by 2002:a17:903:298b:b0:2bd:5b1c:f78e with SMTP id d9443c01a7336-2bd7e8bcfedmr160948485ad.28.1779119203719;
        Mon, 18 May 2026 08:46:43 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:42 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 2/9] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Mon, 18 May 2026 21:07:14 +0530
Message-ID: <20260518153721.183749-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20915-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5352057064F
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


