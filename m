Return-Path: <linux-rdma+bounces-23101-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/20I+KlVGojowMAu9opvQ
	(envelope-from <linux-rdma+bounces-23101-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:46:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87319748E3D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:46:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=UqlKmidR;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23101-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23101-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22C0D30217D4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E63B2FFD;
	Mon, 13 Jul 2026 08:36:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034763B2D18
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 08:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931815; cv=none; b=HBNGndSHfw+oHMMmWL6aLeV1Ff4B3bdN92PMZU/4nenKDoSjKbkjGcPrntjdxmqn1ZuQz6HVEBTzQvAGIE+LK8UZY4fkh2ruE+8ZULx40e8ykrW7ytUIP2v04gfiZrQ+rq8DwN9NvZE+fuAR3qc6spxDY/oIirTVL8Aa3p2k6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931815; c=relaxed/simple;
	bh=ulwjwRtT1jHGE09Th2dscQMIiLMx1T/VFSGlGtqLP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7tXlVV98XPmUxoy39XIoJMUBZlY5EHeA+3EFcdKWB2FJhKfxD95JR/HR/Bh8uI6B3httLtnT6kVwKFP60VANLWxi3JWiewHZZCHQRtNAlMRBJMsw2Jxl10HL1GXDFtoEhMIgZQUWZ68rLrFeeIHsdun9bEwkEZCnqU0+FUKYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UqlKmidR; arc=none smtp.client-ip=209.85.128.225
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-80e2cfe6918so28881347b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931813; x=1784536613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7m1olp6RNw1P8642fW8LLCzIOoIE2zYEsaGLMCeaiA=;
        b=Ll1Q3+ZUQLOenAW2c/DK2Pboi17qNNAavcVC0ASJ//O7RuDIbhE2qiGnrdjW7iBsr7
         ggcq7HMJx6zZsEcofpjJdEXWqTA0puvbd1HP7BT/YzQZon7IDvp3r5BWgXrFEj2aa6t7
         8M4M+K/a5eZo51lYGgHmpF/K2M9cnhnW77ArAGs6Mkj1aos7r6+Z7mXI9OkPgoaC9/t/
         lEWqXv9Sox+rGIx/6m6j3r7eRaP8ZZtebZOL1dOLmvnudPbFcj+vGNzUPaxIoqHZ4zWT
         lCc0/R5a4UQqb/T8QnIKO5nqEFQWp5OiE8U6iKXUMBSFpL8+Ep/bgGmKtbUo/GMGJjsx
         GSnw==
X-Gm-Message-State: AOJu0YygRSAgR//XdRVIg/7fJ6lqKZcc3N361show8Lbjo0UJ1+oj7BZ
	syWaePZl56jVRpt784RQucV0cXuFzDyBITGOLIf2TdzQLuhYDesETLl8V43Ym2eMQR/ozDGgszT
	xjhlyVM4qdsYliVC+FcHYRa4x6Q+Z1OoK5XEOwWwPer3Cro86F5qM7j5PBBPQ97jS2ZEmIJ9QY0
	E8E69sNJ4Xul6e0qGsmTgcjDOs7Ol77n2df6fnbU0dyyyr/LheJYCOMQ41nD6EI9RRUxNVVz84G
	5c5J/kiQfv6/bDa+w==
X-Gm-Gg: AfdE7cl/XzHUyeNuYc1hlU/VNXj6wJGprz9zE5Ir3HlazHu9IMTz3mx2pzRPGCCrm2M
	x9lXNczQZ2w69xFmu06WtY3nbE06oTZyw8z3jvtA9nIR70Gg03PNi93P7VFfNtQYZ2YJypjqfbW
	NcHAw8pREbQq0Xvlw0c/px9/5xXsDYPmafIKEgAgpib+H2Saw+wme5GgmpEn8BwTUZ50QYUSM6/
	/zWLBbmAXw0j4ewFrzqynR0JMZTLmW7vfDKKMR4CEner7fQuZ2MLs2G6m1YZuw9yyMrIoL89OVy
	pZbigWB1WeivCxaE4Ys/Mg5ABNO8g4EE1UUuUr278KOk4caXSdIphnsZ+0KzXFZraZrztX+VPBY
	9EOjMtznJilKbb1GK/995jRHvN5QOG5g3yy9LgM7sV6mfjKLznt2/Eosa4L86Q6d1iLDrlHyP7l
	9WdYdrEglsynVIrUpSMQ4JOp6LhRx+Z27Sm50sKnmkMkp7rkNQcA==
X-Received: by 2002:a05:690c:660c:b0:81d:8ae3:de65 with SMTP id 00721157ae682-81e8ffe88cemr57786067b3.1.1783931813022;
        Mon, 13 Jul 2026 01:36:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-81e6c1c8bd0sm4932997b3.24.2026.07.13.01.36.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:36:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so39359755ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783931812; x=1784536612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7m1olp6RNw1P8642fW8LLCzIOoIE2zYEsaGLMCeaiA=;
        b=UqlKmidR4scPiCuhm9E7ze3EcH2dMRTLSSWc6ShKNA30ihGIDAsHZsNHzu1aj1pRbr
         ra45JGxUzru69SmE3d3uwryIaTDZGu4rkBVa7EXf6L9LrLJUb5DiOKE+YzIuvqvRFHzq
         ZSn2SdGBBX8gTteR8a7aIHNAMwvFwMU9a8MvM=
X-Received: by 2002:a17:902:f787:b0:2ce:d957:59c4 with SMTP id d9443c01a7336-2ced9575addmr12449485ad.6.1783931811856;
        Mon, 13 Jul 2026 01:36:51 -0700 (PDT)
X-Received: by 2002:a17:902:f787:b0:2ce:d957:59c4 with SMTP id d9443c01a7336-2ced9575addmr12449265ad.6.1783931811325;
        Mon, 13 Jul 2026 01:36:51 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm95005385ad.57.2026.07.13.01.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:36:50 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	alhouseenyousef@gmail.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 3/4] RDMA/bnxt_re: Fix toggle page UAF in GET_TOGGLE_MEM with mmap entry refcount
Date: Mon, 13 Jul 2026 06:58:29 -0700
Message-Id: <20260713135830.1934471-4-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
References: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-23101-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:alhouseenyousef@gmail.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87319748E3D

bnxt_re_destroy_cq/srq can erase the entry from the XArray and call
rdma_user_mmap_entry_remove() on the toggle_entry concurrently with
the caller's xa_load() and its subsequent use of that toggle_entry.
Fix by taking an extra kref directly on the toggle_entry's
rdma_user_mmap_entry while the GET_TOGGLE_MEM handle exists, released
when the handle is destroyed. This pins exactly the resource that
GET_TOGGLE_MEM hands out (the mmap offset/page), independent of the
CQ/SRQ's own lifetime.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index c879f5223ea7..c13497b187b5 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -214,12 +214,14 @@ DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
 
 /* Toggle MEM */
 struct bnxt_re_toggle_mem {
+	struct bnxt_re_user_mmap_entry *toggle_entry;
 	u64 mmap_offset;
 };
 
 static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
+	struct bnxt_re_user_mmap_entry *toggle_entry = NULL;
 	enum bnxt_re_get_toggle_mem_type res_type;
 	struct bnxt_re_toggle_mem *tmem;
 	struct ib_uobject *res_uobj;
@@ -244,6 +246,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	if (err)
 		return err;
 
+	/*
+	 * Hold xa_lock across xa_load + kref_get so that a concurrent
+	 * bnxt_re_destroy_cq/srq cannot call __xa_erase and remove the
+	 * toggle_entry between our load and our reference on it.
+	 */
 	if (res_type == BNXT_RE_CQ_TOGGLE_MEM) {
 		struct bnxt_re_cq *cq;
 
@@ -254,6 +261,10 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 			if (cq->toggle_entry)
 				mmap_offset =
 					rdma_user_mmap_get_offset(&cq->toggle_entry->rdma_entry);
+			if (mmap_offset) {
+				kref_get(&cq->toggle_entry->rdma_entry.ref);
+				toggle_entry = cq->toggle_entry;
+			}
 		}
 		xa_unlock(&uctx->cq_xa);
 	} else if (res_type == BNXT_RE_SRQ_TOGGLE_MEM) {
@@ -266,6 +277,10 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 			if (srq->toggle_entry)
 				mmap_offset =
 					rdma_user_mmap_get_offset(&srq->toggle_entry->rdma_entry);
+			if (mmap_offset) {
+				kref_get(&srq->toggle_entry->rdma_entry.ref);
+				toggle_entry = srq->toggle_entry;
+			}
 		}
 		xa_unlock(&uctx->srq_xa);
 	} else {
@@ -276,9 +291,12 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return -EOPNOTSUPP;
 
 	tmem = kzalloc_obj(*tmem);
-	if (!tmem)
+	if (!tmem) {
+		rdma_user_mmap_entry_put(&toggle_entry->rdma_entry);
 		return -ENOMEM;
+	}
 
+	tmem->toggle_entry = toggle_entry;
 	tmem->mmap_offset = mmap_offset;
 	uobj->object = tmem;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
@@ -306,6 +324,7 @@ static int get_toggle_mem_obj_cleanup(struct ib_uobject *uobject,
 {
 	struct bnxt_re_toggle_mem *tmem = uobject->object;
 
+	rdma_user_mmap_entry_put(&tmem->toggle_entry->rdma_entry);
 	kfree(tmem);
 	return 0;
 }
-- 
2.39.3


