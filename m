Return-Path: <linux-rdma+bounces-18729-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOKCOThPxmk2IgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18729-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:34:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61898341C85
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1467F30C3305
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866A3D5255;
	Fri, 27 Mar 2026 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/I8O+JC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE903D8102
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603624; cv=none; b=Khlh9y4sqjDI/OTfF/Kse3NECyJmBNBBIGAsmsjcagYz001LtUWdwQZ9BpoaE+ycF7D8mXXEp8jNnmmqbbtbzKnku02WQW0Rd/aHxiLiOf3f7pX9/+DvzDGzotQ2vPhOSBewkEunXaza4qgSizAGYkn0rEMc1btUYmau4qDQDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603624; c=relaxed/simple;
	bh=cSJDfFUffonR4h3ckbLlZlYP9gPR6KXYULruYjHNSz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2ygao3HBdIOmcqWK66fUjg3hl7Dozre6JM+Gt3AZrvEJXmjmmNdWlV4UnYk+XzA8oHR/GmFixGJD5py++Xj4GdOWeu+hhMrAEKCcAsy9Bs/18Wqg82Y0Cur5axXnKkg3TVsraSPCRxKEXM3cho1ztOtLdXSbo+3IWInI/x2Zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/I8O+JC; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1164256a91.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603621; x=1775208421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI4ZyoeViLiR23r/ShiYHRP25iFNwTyHSboyfbNoOXs=;
        b=c2LS8+XIyGwSG00vzp0Z3A6KGsIvxjcrgRQnROxxbu1pX8AyDmZ1LxAgeWVizupoIZ
         aW4y5V0D1LQ4ghFXcWQ9Xb+obXzzHtkYaVwdMbMt9++V0ArPGQnB7C5cpXqbWNKzeDmh
         JkRNzBpjHMtjx4C0eLJcEuvWa3s3424GpPQwq4nFymt2WxOPhZUSrUcE9XbXmGUs35nA
         qX0c9pi253yGfNqkhkIYLXvVX0/6mvo7x1pY6PzN7hT2c0/Njzq5BQWMIEOB9Ka7Htl0
         jsCxTD8lpxRrP1k81zTXcmhw98moJ+buSMt2B0fvVC1bOmJ4gEeEGkVjSi2OFGQr7QjB
         hKjA==
X-Gm-Message-State: AOJu0Yzmh9BfUyb+SN1xrxieE+ScvNHCX4BBnS11omepTHM+gZf8/quG
	On3MeIa7gCCsQq2Mvx7484zA4EPw8Ke8CwSpAqauRQ/KMXWKqUVXpmJOGAZXOXkexd38Kz5gc5P
	5UPkc5eyZXwiaw/PVFacIrOCr6q+M+Yl+osDPdzcnARs/SeCVNMakq6rFXRsueQVIMYpS0ygugi
	Aa8fXcQGHOJ+htdAmhhFlaUVMK0mL1FG9/o/ogY6RAVB67Cqy9M/q3No6iTzfeqlHfFjOSXLkE4
	c71iz4dwsragPfCEmrh9PeJsqfA
X-Gm-Gg: ATEYQzzm+DgJYy7jo/ETmlB/AwP4jlFD8oJr/sQRl5+JGq4Qomwv2lsbrtHZx7iptlZ
	LTs3VLhDNdrGotItlbfb/RK+EwoaiGg9vIyoeAVJwS2dfTQa+xJ/nL9fyfj7u8OCNMS97Opn9XV
	6P9Lae99yClEiosHT6VLznsiK2p7jFgfmVooeHvUG1ttUdz2ZSrU3mB18y+biVZHB0fHRq8TAt0
	eOTwAOitDVdHL9sgItSEnzp+Sl1L4GJWqm7C9bcLwYjT7EB6w5nW3nIFG2jafU2BwOCHZNicKZB
	HKwSVozVawUxJsR9nJ4z7TdJkN355kH1Qno+icgpjOT0Eun8O370cVkvB7qBA5xbDiDs8bvMAES
	OJmneK2lk7CDNTxXVcdhkwTbk+MhaI/Wc7GQ+lWJ51/jJ5wWGEFwGF924Soy2lML2XP+yRwLUPr
	LvvIxk7cwF4r7alHJ8ijC4oen0NFfM8VsqoHiy+FukIrTQqusR3js/kWhjhhFqH/kbf3qW
X-Received: by 2002:a17:90b:1fd0:b0:359:8f63:9a25 with SMTP id 98e67ed59e1d1-35c227baa3amr4208479a91.3.1774603620686;
        Fri, 27 Mar 2026 02:27:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c2e9ea156sm67554a91.1.2026.03.27.02.27.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900fc7033bso38378997b3.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603619; x=1775208419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI4ZyoeViLiR23r/ShiYHRP25iFNwTyHSboyfbNoOXs=;
        b=P/I8O+JC9o7wZdyREqggrR+GBljs8G8fHRWIRZ0YupHlsxkOZwornb/56lF07otoV1
         Muddf5KJWDOeBQCwSJeANI0Os/VO5rPP3yOPHUnW96YHopxybEmS/3IqvLXdH1/kG5tE
         zmxxV30YKYVU/hkxdZhFrGkoquhA0UFLgZk4U=
X-Received: by 2002:a05:690c:6601:b0:79a:42f1:abbf with SMTP id 00721157ae682-79bd02aacc6mr38001547b3.24.1774603619339;
        Fri, 27 Mar 2026 02:26:59 -0700 (PDT)
X-Received: by 2002:a05:690c:6601:b0:79a:42f1:abbf with SMTP id 00721157ae682-79bd02aacc6mr38001417b3.24.1774603618889;
        Fri, 27 Mar 2026 02:26:58 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:26:58 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 2/8] RDMA/bnxt_re: Update rq depth for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:49 +0530
Message-ID: <20260327091755.47754-3-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-18729-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 61898341C85
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
index 2c7b1cfb7b1e..61879222248d 100644
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


