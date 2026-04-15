Return-Path: <linux-rdma+bounces-19368-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GiCNTAp32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19368-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A55A400AA9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CA2530143C0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6137F8AF;
	Wed, 15 Apr 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HVQ1z+LF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881482580EE
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232749; cv=none; b=Pe3NyQjhe8bOSVbAJ9vk44PALWwPP8m1uUJ9gABx1PEMOSr86ivkE5SvxdglIoaLKn7sBHx4cz4ZtOKczeJNG9VHUYMJdWXrD3l4SXbkOlnt5jK7qxDRlDdZO12TSRrjqXNEG4GK3BzCgr3842FO+ydxaoVneM8qLtJYNHjHEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232749; c=relaxed/simple;
	bh=IA6Jp7mbpoldHQLczHrNdzqrVcvGXd0gXimBOcmtpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkNAzdkUcMFIA6ud1drUaehkZmJn+HT5l3KbwiIbCOTmc6UKP9zcKvTick778aI0+Nyj+RYZaH+AEIpjupECO4LALkyOEgjKo4gDlITQcifaBk2REFgidOVqtKm9yU5lnIIqWn+jm4LDPQF85tP53TZMsXCDrA3IviK61g93y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HVQ1z+LF; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79a46260385so69095287b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232746; x=1776837546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TB2DxZFT4yz9vSDDmXGxraR0PjsS1JCdzriFJCuz7U=;
        b=SJ69oNJRt9qruQK5PKC58gExtgoJzpJl5v/Danjy9Afm8siNGPNVA6LMqbVH4a6PWP
         j4r8+B4ArcFNY/bJh2MZl6JDV17sW8aoFqoutIE4PfdRZZjmSUYGVyKKiMwFecr0Sx3V
         1QmYoqNAP6y48CMEtXoqLUtXDSu6HcURP8sCpsX8tAHzwkyK/CZ1ZYBqQyQyzeptT9Mu
         23D89pvB2WNdVXtK8wgFFglLvNtIpvjInjaizjjazmIJu5rpyyaaa4X4C7D3fTM+Vjsm
         hLETv9Zop42hZyjGI0o1DLhY08XBPs5uV4EVPoAMo52NgRERtdO6UTFnq6+pQf5j9u7c
         3gcA==
X-Gm-Message-State: AOJu0YzpWAe6q0jfF9Ng24zCNAuFMHw6lYCLJcQRk9uuncSNwNHPpWNj
	Tx84NMQSH0my4gsomNOOrIRlaFW0pLkISzbHUabTTjDRr830IF3SiFrV0C2fIwkG1R8PZyhbALI
	6kXPTC8Cfc00GUVgqeaaKFlAGOUOY3dtzASnMLsOcTRR4wkKZndWzXVQfAN3+vQcN9QN7IB6FTk
	iH9Hp6NnDEXSma4q5Hm0r4XV1ZkcyczgZpAuDvf0dkQtM/ybT0WHn6pIdHJGx6O7BNQI60rNqOZ
	McYqBbYR9SSofdWrmqPYerZKi02
X-Gm-Gg: AeBDietMf2VXjhm5T38jRfd8/E8WykTLq6KUVhF782d2p+uOixYrLsI6kXFP+drx+XX
	u1BFJ2cStU3TqV6TH0/TlDTKW+qRSIqmjTUoysQ82kAk4p+9fpf6d07y4Gyy7kXcwPO2r0N5iFk
	snXTjw07v50UdzyAdMyU76i1Iv/TXGUsfXNwnwA4molgo9DykqgrFcypoDMLWvSoisu/BQLCmYv
	Bs8RvtMZYpAZGrk95Q541A+LYOOV+2on+z3vC1HYD+18S1Hyw8/VgTannGCoScHDNFbXfb1igaR
	tlCfxrO1Ku4J7O75DR/Lgc0VA3IY9VuWE0D3/sBHCLlO1n3h2Q2RbZU8EMlEi8FCNg5m/xQLg/C
	lgfdTS4smFjb27p9MYd8u+f2rZCwTgaHUI8g7rnorVp+aj8sRQljwcF0fqz8XG3AVS+mmFvuocq
	E9k2oev7R9DMyA+xprAW/GGMIMtxxCpUFU285SYCmKAiO38YYMeajOHpFGQYPvKhvxEVoW
X-Received: by 2002:a05:690c:112:b0:79f:525f:be64 with SMTP id 00721157ae682-7af72532484mr226816777b3.51.1776232746562;
        Tue, 14 Apr 2026 22:59:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b768d373cesm662547b3.15.2026.04.14.22.59.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358f058973fso6637398a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232745; x=1776837545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TB2DxZFT4yz9vSDDmXGxraR0PjsS1JCdzriFJCuz7U=;
        b=HVQ1z+LFSa1KK6OwP57T3lzmeCDCdn63iYBVdm8IhGv6mY5LetQcRnhgQ+Q1a6FKPI
         2lRcAan8KgdILsCjCZ9/6bKnOJZAzARfhwQaY+ob0PYYIRdyvvY1OkujLRrSk5a6G2iW
         VIQ8GaPlqf2vHOsWrFsc1bWReT5QTZapcTmAk=
X-Received: by 2002:a17:90b:1a90:b0:35f:b5df:453 with SMTP id 98e67ed59e1d1-35fb5df0dcbmr11219429a91.22.1776232745331;
        Tue, 14 Apr 2026 22:59:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1a90:b0:35f:b5df:453 with SMTP id 98e67ed59e1d1-35fb5df0dcbmr11219391a91.22.1776232744812;
        Tue, 14 Apr 2026 22:59:04 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:04 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 2/7] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Wed, 15 Apr 2026 11:19:52 +0530
Message-ID: <20260415054957.36745-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
References: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19368-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A55A400AA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to add extra slots or
to round up the slot count. Use 'max_recv_wr' count provided
by the application as is.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 561d491f12ff..35416571b3ec 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1475,7 +1475,9 @@ static struct bnxt_re_qp *bnxt_re_create_shadow_qp
 
 static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
-				struct bnxt_re_ucontext *uctx)
+				struct bnxt_re_ucontext *uctx,
+				bool app_qp,
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
+		if (!app_qp) {
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
@@ -1678,6 +1684,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
+	bool app_qp = false;
 	int rc = 0, qptype;
 
 	rdev = qp->rdev;
@@ -1724,7 +1731,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 	}
 
 	/* Setup RQ/SRQ */
-	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx);
+	rc = bnxt_re_init_rq_attr(qp, init_attr, uctx, app_qp, ureq);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


