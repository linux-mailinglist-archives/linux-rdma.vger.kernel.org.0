Return-Path: <linux-rdma+bounces-22063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 52LUK+DsKGpdNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48331665D0B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RuKqOGQV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22063-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22063-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 177C530F79FD
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6A35F5E1;
	Wed, 10 Jun 2026 04:46:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EB35B63C
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066817; cv=none; b=vCkAA8/qRplETnmNDfh4uwjzjFgSY9q0p2jr1HO5Iye4Kq/hQ0YMtM15bs+k4pxaeGTpdYNKk1/szJyX/qeNmD6AkQ78eQ4o3S4IfxAFieGCu2RvWGnJBcnz+OBSn9zodhogwhWEGIU5cQoFKjnJcR/eU6zl47adXCGcJIchy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066817; c=relaxed/simple;
	bh=4RnMaYK8iYg5ke28e+4c5GyvZxRun4ufh8jHJAP3yDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Upl9wYgVYbMukc8ayfzByR8ghFyrc1Ur83aahGStzraYuVqsCzRtVhLgIXJg0OsbWCCXtZVQMcTyAHrNkEyv0D13cEOa9+z9/6ygZHbdZhynnMpS2ou7BLw+0ND1JwdOO/HkZyyB2upKmgNOghSG+wmh064X7dGXNN8RcCKnHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RuKqOGQV; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6603d8697d2so6180744d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066815; x=1781671615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3Ib6LDrc3mK3EDiUpMMEhZzZGqQZCtHaRoj8Bky1ws=;
        b=XphQheA6ATbMRFpuz3sJL1ZG0upXXxoVRq+dTNtTFv85o+lytDU/UP9URoZ3jhQ1C3
         z00t/1AfxI8O9PyFKu17DAW7LaHOpzU8NDKvG+6w+/saX7MtjdBoCCInB4aUvoGM4Q/j
         3pvnxDQ3ozKSEZd92O3ZEc5uhiPpsV7HIcMqxrBMzWs8eTvbl8gEUCKYPR4bij1EZZFw
         rkhy5uX/TD9Bvc9K2MLuVc7tQ0+8tgB+y8dJtuL6ts3pqdaiAlqDeyUI32tjwmHTjKkn
         ws0WCG4s1/trQa3zTz1zaT2B0iLW3wrxoQZspV7a1ef5K4TsZ6Z+g7GogvNt+kLOHtHB
         mbNg==
X-Gm-Message-State: AOJu0YwgV1XkUxgokcsnXlX6X4d/eHRG3sAmmcrmsMtRK5R7cbNJ8Ef0
	2hGo7gnRw4h1S2JMSoEVgDhm1ogOScAIFna6CYd60iftOKY+3lQdkjxBbvvEmecNyFv/OinaAq2
	jKuJ1nSa4RchKlAHZatHJmpyyBXtlK1SRKZOQNvpmM2sZ7rpeDVkW2xAariUyPL/0nFgnaHEIsp
	vRqjDdF20fuFm5qtdDoe2Qk9F3IFR2XH5ydBYWnUTO8GlHvYwLXpeOnkVuwasMAAO4Fsh29dHyf
	yFdXmgXKr6j/Mp0hw==
X-Gm-Gg: Acq92OGvPwuzrvcAuGqAIy5ijZGaoOU//IhFAYaRcYYUMtyoCQjeY5E7FXigBNSr3zF
	xxe8M3PbeIL5Fej+nHlyEY9zBDYaptMUxjMYB131Yccq5PM+iJUZ4cGEq+EINr0DhBiA4MzITiU
	3D+EWlYSIL3soOX9Go3OWXRfEDj6ms8guBeCn8mzr3uDfmAIFy/PQFVyQIruw5WTKWkl0ikGzeT
	K3InZG+MttzjdTX5WiC1NAETAJQP4PLVr4NhEmVefy1LeJi8ZeND5WeqtL3uIkihDAhLinPaF/y
	D6Km6enhXg61KnHPMiGvLifpqHdYzQJRYrtzWfWS2W5iCEs4XKTzwytrGZcfOxSIoViTGcoZix9
	PNSI6gjrxMFdzVAS+tfCBr7EPyDffM8h95iP6sdmuaGQOqYY7NW4G19la6CILXvK5Ymb5BmEaWo
	iJ1ficzMs3SAQ/0Q43eJcZKBb6XF1QivGZYa7kbzV5TkBAf7vCaFA1Mq83A9Cv76EyRzOXu8w=
X-Received: by 2002:a05:690e:408a:b0:65c:513f:5a43 with SMTP id 956f58d0204a3-6614f5f6f59mr5512174d50.22.1781066815176;
        Tue, 09 Jun 2026 21:46:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-660d61ea17fsm1736290d50.15.2026.06.09.21.46.54
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85a2c129b3so2985409a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066814; x=1781671614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3Ib6LDrc3mK3EDiUpMMEhZzZGqQZCtHaRoj8Bky1ws=;
        b=RuKqOGQVlPmOWYXTRfyLx+df2LmNHa6GQbvtbIsOrfDgvzlj2EI01u20HvXsDh2PjD
         MsiArscVC8AIZkSpGuGdq+FM5Zi5rcIFnDLzLr3FRTA7DHHORc1Hm8wdYsYG9DJXcCrD
         K+3GuWJZcsSGPWz6Xm9Wq+V00+4dJpEZZe0gU=
X-Received: by 2002:a05:6a00:bc10:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-8430a62eed1mr7681871b3a.2.1781066813923;
        Tue, 09 Jun 2026 21:46:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc10:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-8430a62eed1mr7681851b3a.2.1781066813477;
        Tue, 09 Jun 2026 21:46:53 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:52 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 08/11] RDMA/bnxt_re: Avoid any race while handling the hash list of SRQ
Date: Wed, 10 Jun 2026 03:08:52 -0700
Message-Id: <20260610100855.64212-9-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22063-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48331665D0B

Adding/Deleting to/from hash list needs to be synchronized
with the traversing of the hash list. Adding a mutex for this
synchronization to avoid any usage of the SRQ structures
after the SRQ is freed.

Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++++
 drivers/infiniband/hw/bnxt_re/main.c     | 1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c346dec14dec..5fec474fcc2e 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -218,6 +218,7 @@ struct bnxt_re_dev {
 	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
 	struct mutex			cq_hash_lock;  /* guards cq_hash  */
+	struct mutex			srq_hash_lock; /* guards srq_hash */
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 15d54b718dbe..b415a3a25721 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2154,7 +2154,9 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
 		free_page((unsigned long)srq->uctx_srq_page);
+		mutex_lock(&rdev->srq_hash_lock);
 		hash_del(&srq->hash_entry);
+		mutex_unlock(&rdev->srq_hash_lock);
 	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
 	ib_umem_release(srq->umem);
@@ -2264,7 +2266,9 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 		resp.srqid = srq->qplib_srq.id;
 		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+			mutex_lock(&rdev->srq_hash_lock);
 			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
+			mutex_unlock(&rdev->srq_hash_lock);
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 8e6257a4e048..6915fc3f1392 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2341,6 +2341,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	mutex_init(&rdev->cq_hash_lock);
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_init(rdev->srq_hash);
+	mutex_init(&rdev->srq_hash_lock);
 
 	bnxt_re_debugfs_add_pdev(rdev);
 
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 5f56db41a445..54d7e99e47d2 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -41,12 +41,14 @@ static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32
 {
 	struct bnxt_re_srq *srq = NULL, *tmp_srq;
 
+	mutex_lock(&rdev->srq_hash_lock);
 	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
 		if (tmp_srq->qplib_srq.id == srq_id) {
 			srq = tmp_srq;
 			break;
 		}
 	}
+	mutex_unlock(&rdev->srq_hash_lock);
 	return srq;
 }
 
-- 
2.39.3


