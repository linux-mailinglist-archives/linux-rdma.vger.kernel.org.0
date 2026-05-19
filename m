Return-Path: <linux-rdma+bounces-20981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GdOGlR/DGo1igUAu9opvQ
	(envelope-from <linux-rdma+bounces-20981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:18:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BF581460
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5EA1303D177
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5E376A01;
	Tue, 19 May 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XZD5rYG9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA543AFD1A
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203426; cv=none; b=COPWfkCEfCRM+/t6f1SxOWGfvRMiiJ2yKT0/JKe27peMPWUIqXbvGL9hJ9vhxTB/+m7ElFOrtylnRDASLlwm9tpcL/sHzaw/tKvtbjPJAJ/7cZji+imw2KhQvGbqRQec2CIEypWY8hFQbzdqNdQrkdYAXtaJ4A5XaLPHOfTVCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203426; c=relaxed/simple;
	bh=ywzOCWxdvCHvCjMdFj3myQHz6aAOarwACMoljeznHzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp1yqRTMaCmyOXeE0G9TR8+ErxNZh6XBSUU3jVSelTIkl+OxElgu34m/C65FrNIvkJaCjTa+pUq1XTWxP9R+/P8XNDmPjsgbs9gF9/Xa1TwRDLQJSqAyi9jV7QDx++T4uBYgX2q8bNtCz54xW2D8/6vaEwDGLh5fmxU6oIC465A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XZD5rYG9; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7bd9f61458eso24540557b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203419; x=1779808219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YZztpL0TodEzzK65k+7saogZn2KkDHLiGIEeRdXBxg=;
        b=b4iucVkqSl/4p+HotAxLBaTcy3HEykre48YwN7F07ldkkIKn963DtmRXVAGv8kIPZp
         S1iS+J4MdvryYJ6JJ+87b+6RofZY70WHmoMX/zFCRMRk1eVn/BV6hRmjH0HnBJnaq16L
         Bu4x8zcxsQj2yynw6g7f5i1mz3vqwhz19CQoiDxEnI47sKPB13OWV33GtHSohlCazuAW
         2LVJ0JL8oolEAsvnE3mzmNNcoWAaVF+cYW9hC68vR5wh5TnLJCtADRbRYeX+LFgU9f8B
         rlGMkDYKq2AttnnL1g8KCKLHdwoK5HBleXnFaQLSQ8yUBx3C0ZcsF+KM2PNmnMpEaBsQ
         RQpQ==
X-Gm-Message-State: AOJu0YzDu76SJos7nRemoEvQs4LciZI7LzBqhPifGvRdslV4Ah11zCYn
	XznWGv9sMHn1Wi3a5NHIwQXK328/3T2qv8VE3HRkfWHbJFTCa+gQokJNXnJ2T3XqbUeDEG2sv+V
	NSv0Dlh1ZGBplA1d/medPfUIPG4UlR1B4wP31sb6pAiXUbFMIfSLPjwcTlBWrsSbpnuYWs9iZQf
	C3D5qsQVLP85dtwN4zsKpRb4tNxlP+2yWog4Nio07u6AGohYCQ8NDIkWhxQkkcM5FY/UGnTDdKC
	u3//iSQnOs7SU2LBvfGs+ntr+Sl
X-Gm-Gg: Acq92OHthdjtDqqKW39kJif/bMlnxgmxgmN8VYlCfRGyZZzuOsQ6iMposITKRcIW+xe
	0p+T4o5obywoPVe7WfFyoJzflWB5hRjX/z3IAcvX3Qrsf0cBBq3FKCsfecgSiYJ3w6pVykATdug
	H9HCoPBrCkqlAzleapCn273rQaymhv3wBNfaBt/5QOBrVGt05Vh+luad2mAvLukLCYe7RuUGk9e
	zVIw6JTMLmoxeOa6uusXNvMEiIMRKXWYHqZOhjinrg4yXkSo+qRcxE1Zuj0oVUbo1MMrtGehrbp
	bTuDWeQnCYVdA2yQ5r0VvFbKZKnGXsSoE9y61S6lRQaLtMYQpDTisW5uXm83H07jrSWg9ubsEK+
	tYDihKBih4IPxG1gEPiLPd02DKV6J3KV5RBLvU0aKwPRml6pT1FePgUWlk8g4XeBEzIfb7w+x4H
	xXOM/R4ZFZlY14W8rHlod6ek11UrnVZyEqBo17N0VMrYfWjJTc+k14VLiP5zWtrgvttG6P6KXTk
	X75sQU=
X-Received: by 2002:a05:690c:e566:b0:79f:7972:f89a with SMTP id 00721157ae682-7c95bd1b4b8mr177342027b3.28.1779203418582;
        Tue, 19 May 2026 08:10:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7cc990d2c9esm5798857b3.12.2026.05.19.08.10.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6aeb3637so93014365ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203417; x=1779808217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YZztpL0TodEzzK65k+7saogZn2KkDHLiGIEeRdXBxg=;
        b=XZD5rYG9+pzpv/E3lw7IIhHYpJ48kS9QgzUrH4mXaGZPC5LRMDDszCcWPI3cJ1vtHy
         wUbMGfQ0e5JrkcgwrP4IMlUIzdIzg0eS9lTPnoOQwBj/ZCQ3HW3DAVSRvTQC/3r7HIMk
         vaApyOg/e0rp+r11kBN+4MqR6qrTmiHMT8EBE=
X-Received: by 2002:a17:903:3c6e:b0:2bc:cf07:9244 with SMTP id d9443c01a7336-2bd7e77c36cmr232618355ad.2.1779203417329;
        Tue, 19 May 2026 08:10:17 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2bc:cf07:9244 with SMTP id d9443c01a7336-2bd7e77c36cmr232618005ad.2.1779203416924;
        Tue, 19 May 2026 08:10:16 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:14 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 6/9] RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
Date: Tue, 19 May 2026 20:30:38 +0530
Message-ID: <20260519150041.7251-7-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20981-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 035BF581460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current logic in the doorbell cleanup function is not
sufficient for a change in a subsequent patch, that fails
doorbell remove operation in some conditions. The cleanup
should facilitate freeing of the dbr object when the caller
may not retry the teardown operation (implicit teardown:
process-exit/driver-removal).

Extend this counter to use kref mechanism so that the dbr
object gets freed (via kref callback) when there are no more
references to it, rather than directly freeing it in the
cleanup uapi.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 ++-
 drivers/infiniband/hw/bnxt_re/uapi.c     | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 08f71a94d55d..13dac48ed453 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -167,7 +167,7 @@ struct bnxt_re_dbr_obj {
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_dpi dpi;
 	struct bnxt_re_user_mmap_entry *entry;
-	atomic_t usecnt; /* QPs using this dbr */
+	struct kref usecnt; /* 1 (uobject) + n (QPs using this dbr) */
 };
 
 struct bnxt_re_flow {
@@ -308,4 +308,5 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+void bnxt_re_dbr_kref_release(struct kref *ref);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 3eaee7101615..b8fc8bfba2ad 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -369,6 +369,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	}
 
 	obj->rdev = rdev;
+	kref_init(&obj->usecnt);
 	uobj->object = obj;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_DBR_HANDLE);
 
@@ -391,15 +392,24 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	return ret;
 }
 
+void bnxt_re_dbr_kref_release(struct kref *ref)
+{
+	struct bnxt_re_dbr_obj *obj =
+		container_of(ref, struct bnxt_re_dbr_obj, usecnt);
+	struct bnxt_re_dev *rdev = obj->rdev;
+
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kfree(obj);
+}
+
 static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
 			       enum rdma_remove_reason why,
 			       struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_dbr_obj *obj = uobject->object;
-	struct bnxt_re_dev *rdev = obj->rdev;
 
-	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
-	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	kref_put(&obj->usecnt, bnxt_re_dbr_kref_release);
 	return 0;
 }
 
-- 
2.51.2.636.ga99f379adf


