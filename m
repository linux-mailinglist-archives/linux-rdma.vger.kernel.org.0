Return-Path: <linux-rdma+bounces-20712-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKJ4ClD5BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20712-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8C544BE7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A815D30138A6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00BD33F378;
	Thu, 14 May 2026 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X9X7CfDe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19571320CBE
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776381; cv=none; b=GyJfeBEI8bOlsVcWkesj/Cw3LNyNvVi4ZsVnBTPXpppBy0TglgHALvdNlEA498IKozmuFDIZgYGwLI9ycxhi/ZUjhwx8jbkEd3KSNgc6MFxj94IcsdtX7NBcorcjgNPpqlJJ3a6Zn19FkcxqddrJ8780/hQVEiBpg26lqz3LeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776381; c=relaxed/simple;
	bh=wbSax1j94TarfeVhh/jq34XlMBNSZPOosjFjDbIpGz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC/e0VpMLfyTxo9GqKP7moBr42QNfo+1b4W774qMmxcU30JnzL8LgS1ULwN/omS3pdA2Ss/9aIJ+l9SoiU8zG4nYeEJlLV0oHqMdSVa1VXZniu4rBaUgD+sxUZoJ7x6ESpeP1hWb/nbFubCRAKZa9Xw1NN691q8VkrftNnoL9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X9X7CfDe; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso76794646d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776379; x=1779381179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpRHlvXpRGKmnpzQ8sKj2I6KDfX3CD9sv1ZBiRR4tdc=;
        b=bAT0WZzuoqxyjW6iHsXLtrey1lEY01BueuX7SAOmyn5LHnlDxKosnThhhsMItMT6AA
         ENtga8Xtia0PnwCTkOnPkpBkLcnywV9nChds+k6Z7/vu7mu82w8sopeZnJnKMH6csLm8
         ChBUhtd5aLmYZsgaNVhasCH49T1nnFfS7xFX0ntHFuMCt2VGFMt0wwvYtKSlBAHR3KKX
         WYcJp0fogXZFqjlqgA7dxV8plCqg8lRb9a0+6CvFNdkLQDacDoeoqx+uq/vl6gWzeWK4
         sFcnQk8RWhto1YCb+Oq3Hv3djhVvQe/gXTIXIy8KjbOx/MfAinkRDMFtfzd4me1f9wtS
         LyYw==
X-Gm-Message-State: AOJu0Yy9WyNOxWxty6mEFsKmXsOa1+rE7QYBPEaU9ouVzuaYBWmqZX2a
	zhfdNdP99dOSOUi84gCIxLFb8dXHfGVZFkdL6CM2dsC4XHgfECdcnutAckG6sce6gj+MZJue6Qy
	eyhI+/5ZI/hK0ajGzuPLea+Y5foLmPPMXI9yWCfDcwOmNmgX9x1aZZIqfQATgsKb2xeJLBY1Cjo
	WnfZh+Fe9pxApq+z2GyOoidDLdp+8HNbxjQLgDedgZmln7cDoxSsOeKq/zt8+T7q/aJ1n5vKGMh
	jM/ndqxom1WOqRVwiAjLYh5dvTW
X-Gm-Gg: Acq92OGz7K0y7csqu8ZxQOhoa/KpJLW/BGXg/k/tQc4SmxjZAHKlKUDnqM2w3I9hhXz
	zykAe0e+pQzbUEC0MVvFRzfPIQiGw18lCy1jO9bIKCocPHrS4hoJ2c6gEdzVeSqKy5/f+4eh80x
	rNMOmZt4+UdlbcotNKmlzTPPLojGOTzcmKCRGYNVyUuPhdGKf7XX9RklZU86OCwNrKfV2YP4uYp
	PStGOprACGisi9sn6SxbJpURFJHL+TUNPrNz/xA1exbjgiV3Ti6DYSvtgYTKb5u125YxKUMlY5k
	uS7ZrG9vNCGnlivoa/pZZQMgxmLjk8PdIWNWZ/2rEUaECDPOugx9CvRvm2Y4f6vob4ribB5BCXf
	Gr3O8ydEXPemdUq8TWgO11MrnyNaLMsnkP3Z6Np0CwNVlJgWhQEpufHIbB3Zh5gFXIo5zrh5XEp
	sbtlCLkz6zimqM00GaZa4QP2b93YXBLksA6jzJHmbof5ZYcHgveS1XOTHq5ALC76XDzBOP
X-Received: by 2002:a0c:f109:0:b0:8bd:de6d:c344 with SMTP id 6a1803df08f44-8ca0f6837e1mr4175696d6.20.1778776378769;
        Thu, 14 May 2026 09:32:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8c90aa2aa4esm2211906d6.23.2026.05.14.09.32.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:32:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36629e48023so8723443a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776377; x=1779381177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpRHlvXpRGKmnpzQ8sKj2I6KDfX3CD9sv1ZBiRR4tdc=;
        b=X9X7CfDec0LIoEd3LsUzxrom/q4oaadBzYxsQ74X9u4MVVcX0YJIeh2lUlPZPZ4oVU
         bgf4oKfGSv+cophF/sWrDB//qYe64EwrbiQm/3qQYNWZchOVJQFW49dl5jeyDzuJ/rTj
         f6rM66veEDE5f4gH8oHbNy9Ab9raDcCntV/fg=
X-Received: by 2002:a17:90b:2549:b0:368:ac5f:d31b with SMTP id 98e67ed59e1d1-36951b8708amr115302a91.24.1778776377419;
        Thu, 14 May 2026 09:32:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2549:b0:368:ac5f:d31b with SMTP id 98e67ed59e1d1-36951b8708amr115277a91.24.1778776376919;
        Thu, 14 May 2026 09:32:56 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:32:56 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 3/7] RDMA/bnxt_re: Update sq depth for app allocated QPs
Date: Thu, 14 May 2026 21:53:32 +0530
Message-ID: <20260514162336.72644-4-sriharsha.basavapatna@broadcom.com>
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
X-Rspamd-Queue-Id: 98F8C544BE7
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20712-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

For app allocated QPs, there's no need to reserve extra slots.
The application accounts for this while allocating the SQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c67179160654..fd1ea053d563 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1541,7 +1541,8 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool fixed_que_attr)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1582,13 +1583,18 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			sq->max_sw_wqe = sq->max_wqe;
 
 	}
-	sq->q_full_delta = diff + 1;
-	/*
-	 * Reserving one slot for Phantom WQE. Application can
-	 * post one extra entry in this case. But allowing this to avoid
-	 * unexpected Queue full condition
-	 */
-	qplqp->sq.q_full_delta -= 1;
+	if (!fixed_que_attr) {
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
 
@@ -1737,7 +1743,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq, fixed_que_attr);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


