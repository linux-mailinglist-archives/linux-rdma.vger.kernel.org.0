Return-Path: <linux-rdma+bounces-19369-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKeAGjkp32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19369-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF655400AB7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02303027955
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9E37DEB0;
	Wed, 15 Apr 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AE9Erj+l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E682D322E
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232752; cv=none; b=ovmJ7o5wqOPbE2p/VL/BPY/IXn55KNUDdccXc2OysRM52z/0fOOtY+zLo8qSYpo2xCX4N4ZMcSusPTGb35g/ys5XGj0dafsklVBl4qgqCbk1UW9Renr16hl7FLMwrlsSoO2uEJeBVvfty2S2sBrIH7xD3ozttoaLaa/2QqoALxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232752; c=relaxed/simple;
	bh=+K424xFsR48rKXrOh8fObtLJ0dV1m/45wS11E8wEU8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuksNCrryfYSyuU5JfKIlPNpWIgZtlU3i0QoKaaJQn5CmH84qyJiWjrBmGODXADFTC8S7RieD5CztSsVZEfRg9uONHJ7HWN2CX4eplAfUtt81VI5M0oSN7B7oPZT/Q8vVqMdKUmMJq454FcwncC9hLA5QNzpqTpXvksi7OkDZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AE9Erj+l; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6926426eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232751; x=1776837551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyt5AVOAMPexR7KSCWxfBaAk7TRYb/a0vqdw8YUDqAQ=;
        b=qlCR+/wM5S8BQizF8JMbFMj0qW6bjs0cykem1XkaHuGpEdWcLhs7+IonBqynNPZ95b
         K61VynjE0zyc7MdMXVse0Rot9y/WU9HIZSfR1HHItECd93P/6I4tExMzo7w8iJDGqaZZ
         vFU/hxpo6KCBTTC7676KFUse6Ba8p7quzJA4UuBBIlitwm8H2bQyyYQsNWWXtqYuimg7
         pVfWzfRviOfb/unvc+fdNZEtWXk7iJmsMfb13dynQzo2psTT2SlrMiSKtLJFuUuYRQSW
         IxvSXl+4dYbC+GKtVWmnBnBzHYkPSZQy3RHE4tDms+MTSInPprzZujrTQDbtQYgg7CXN
         8hWQ==
X-Gm-Message-State: AOJu0YyOqzMh9g9pVgTtLk9ADGeEdl3/Sxv3Y3cQ0CmrhV7Y+QSAVIOM
	++E6BDCkXwp5zIOHWiqZpnHEH02Rst3G+6vI7isk17iWPEqe+Gmkx5KMN6oaSx/uzpJLPYS3uUM
	PTppwvunOZ+hONzQhYSIKsiIl9Hf2NmQkNpXltkUlohVkKV69GwUqt+a/rBmfrnLlVIqFrv+5y1
	6eQPA6DhiSyKZ3n5ep7Npo2r3jtFFygCf+Niodb6orONB2gt3dAnVU6/rTrE2m9SCI+FJQzvLLX
	uMKPi5Wymu+HHhqXQhuFxzHSTm3
X-Gm-Gg: AeBDievnPtYR3YNeyfVnsAy5MRI5JropnJ81h1SMLjZb6OCcSjla+SNWMNgTB7J7aLr
	p48SMi78/AAVnz6/uROvFsogZ3wHtjCRN7OEriPsjHkNirUoJj1SZuZgWarGp3OrG6VrTp/ES30
	Mx4JOay+shKznLeyysjQg2JKHoUAVg2HSKwAslyXweU8j4MkEcY0CWIrCfDGQsNEkLACUkEWsQg
	7V7lMxEC44i8eJdEBMKyCXMyQ8CD0W0E2n4Kvcj7k3rVKosTMrstIDRaTMP6zPwipVisCwWEXLq
	2QbHqYDmF+Zfo5h9rQxb1ZfvZ7RWlJ41ot6lIFFLrK58D8hoMEBTn0ORx+/uOru8gGufPoovJ0m
	XVL/bswE9JDKJMgJn6jY2IzSSkhlcnrivqraltuWxp41VcGWwVgHwl8lkl/3s0lpI9L+GMtLXao
	Kzw43Jhzhqpb1Y3gfYIfYOIaCNxOMaYlvJStbt/GXPOoE5x5H4C9rib3WcvAnoKbHKZ0Nj
X-Received: by 2002:a05:7022:517:b0:128:dab3:f528 with SMTP id a92af1059eb24-12c34e892c2mr11746743c88.8.1776232750491;
        Tue, 14 Apr 2026 22:59:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12c5f40ddbbsm4169c88.3.2026.04.14.22.59.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f058973fso6637434a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232749; x=1776837549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyt5AVOAMPexR7KSCWxfBaAk7TRYb/a0vqdw8YUDqAQ=;
        b=AE9Erj+lojH5AKo3Glcizw2/iYS/DoR3ZEIsuSIDV1mCjgPNHA4kHKIhbjPjScDksi
         pAne0g5J1OpgZY8dMqqisPromQzlkiasWrDsogycOV7G/FDKbqj/Sj5Ztlxx6BlpdU8L
         pQhacGF+3F0IUCFyR6CJAvHOhpwAD/+ZzedQE=
X-Received: by 2002:a17:90b:538c:b0:35b:9896:cbcd with SMTP id 98e67ed59e1d1-35e42854dfemr18773455a91.27.1776232748661;
        Tue, 14 Apr 2026 22:59:08 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:35b:9896:cbcd with SMTP id 98e67ed59e1d1-35e42854dfemr18773433a91.27.1776232748186;
        Tue, 14 Apr 2026 22:59:08 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:07 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 3/7] RDMA/bnxt_re: Update sq depth for app allocated QPs
Date: Wed, 15 Apr 2026 11:19:53 +0530
Message-ID: <20260415054957.36745-4-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19369-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF655400AB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to reserve extra slots.
The application accounts for this while allocating the SQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 35416571b3ec..4594e98762f7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1542,7 +1542,8 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool app_qp)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1583,13 +1584,18 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			sq->max_sw_wqe = sq->max_wqe;
 
 	}
-	sq->q_full_delta = diff + 1;
-	/*
-	 * Reserving one slot for Phantom WQE. Application can
-	 * post one extra entry in this case. But allowing this to avoid
-	 * unexpected Queue full condition
-	 */
-	qplqp->sq.q_full_delta -= 1;
+	if (!app_qp) {
+		sq->q_full_delta = diff + 1;
+		/*
+		 * Reserving one slot for Phantom WQE. Application can
+		 * post one extra entry in this case. But allowing this to avoid
+		 * unexpected Queue full condition
+		 */
+		qplqp->sq.q_full_delta -= 1;
+	} else {
+		sq->q_full_delta = 0;
+	}
+
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
 
@@ -1738,7 +1744,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq, app_qp);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


