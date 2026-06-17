Return-Path: <linux-rdma+bounces-22322-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RigkNACtMmoR3gUAu9opvQ
	(envelope-from <linux-rdma+bounces-22322-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:19:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCC69A7CB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:19:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="UB6rv/92";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22322-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22322-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E90308060D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1F3BCD31;
	Wed, 17 Jun 2026 14:19:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B9217F27
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 14:19:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705980; cv=none; b=TSCwjdboH487XcV5MhDOjDDkekG33O7O4ya6ggUEWtdXB9X22gZy2Nl2nhAcrmHd/iS1rPKmZUeMfgAIxTkTLsswrKgMbGqFEBAK0rBZb++zEkVXnU9cKeAU0ANepTmTUtWB9N3adKcOIMVUmZfyTOPncagJAUYzB0o/YrhJmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705980; c=relaxed/simple;
	bh=zZoo8dbCs6tRnFqZQ/YjTxcSJnuJHzujwoPE93bS+rE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SmF61C5ZPAI3TO52IvBJap93jXbH/XxIhljoBVAvSMpImen8KYXOFc1he+7lJ+Rb6NmMLijdY9icFJ6wUY0cEyeXvfBOCu8x3fal3RZvvbDJ2gzYmxDQEJLtQlq1EpGSwAGCojs5gzUYHn6/LrLIeQo6a0a0uWYKIS8kvsrn8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UB6rv/92; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7fd85d01ed0so26010857b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781705978; x=1782310778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H2fgG+6T38RQ1QVHd79VUYTxf7kLI875NAGbhgsVhQY=;
        b=UB6rv/92JpVw6E/RhtyCMtLVUnedu3cIVGroGvykLaTN3lVubiEogSH5T1v+hucDOS
         X1fh6QxJMf/0w7oySPg17xARZ04I0WO2a/sB5JEZEkLZV4SyakAWbjKwnr9wmmEp2n06
         Eg5AINal11eOWM5eWDdP451nd0dqYCzI/JA98sskAdEdJz0ljuR9znKMsdlfxOGuaiAD
         Wlek7YsgOZoU+hRmIsNbAN+IqZbSK34uoz248cGwoW20tKSktXmB6+j+2uxWFxQlHGDj
         SmLhSvFhOGfwPUmz0/At9gchN/onCeHMRvpRfZRVe/5k2mUxX4SMDwQmORNqacFvj8S1
         Vvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705978; x=1782310778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2fgG+6T38RQ1QVHd79VUYTxf7kLI875NAGbhgsVhQY=;
        b=FapqcSUMna0ieqL1uu1lP6X6t6bJpM/ZA8S6DVhF7F2lH1e7SNtno+Bh7G3JMq103Y
         dLp96CyN7mV3qe4O3o+X/T0Ah7HOXFJhRKV5J9hxRqExaTPbEEDnO6eZc1FqOAtSZeQn
         FfeQQatrfO5F1zbIgVwkDmDK7VT3n/hBnUxh5qq16Lhykyi1q72gg0plqn0v5KQIF01S
         yfKSCqh8C3Yh04BMpkVHtEKM2aXBTqldiaaBn+I26tK2Yxs42vLmbyk/GZhQTSVp2uxa
         UypzL802SMRVpGfNPoyCthQ1QhVgO5yVHWt0XsakCrbbqf89Ge/RRJeJTe+QxpwIYnn2
         eIWA==
X-Gm-Message-State: AOJu0YxGHLUFJL2f72gBU/uapiE4X5mD8PwfjsEiS/4pLqsaWIEDSyTp
	TnYcBiqKQjw5dG4K5OGJtHmIWX11QPsv6BQbz/MTiRsjv5lMa33aLKF9zhMZbhI5IBEPV30jEup
	EOSNGE3Pl5w==
X-Received: from ywee13.prod.google.com ([2002:a05:690c:a18d:b0:7fd:a7b6:8d9e])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:348a:b0:7fe:200f:e7fe
 with SMTP id 00721157ae682-7fe5ea938b5mr41092067b3.51.1781705977666; Wed, 17
 Jun 2026 07:19:37 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:19:36 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617141936.3280979-1-jmoroni@google.com>
Subject: [PATCH rdma-next v2] RDMA/irdma: Prevent rereg_mr for non-mem regions
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22322-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BDCC69A7CB

When a QP/CQ/SRQ is created, a two step process is used
where the buffer is allocated in userspace and explicitly
registered with the normal reg_mr mechanism prior to creating
the actual QP/CQ/SRQ object.

These special registrations are indicated via an ABI field
so the driver knows that they do not have a valid mkey and
to skip the actual CQP command submission.

Since these are real MR objects from the core's perspective,
it is possible for a user application to invoke rereg_mr on them
and cause a real CQP op to be emitted with the zero-initialized
mkey value of 0.

Fix this by preventing rereg_mr on these special regions.

Fixes: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
V1->V2: Minor commit message fixes.

 drivers/infiniband/hw/irdma/verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b79f5afe68..da8b4ae786 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3791,6 +3791,9 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_mr *ib_mr, int flags,
 	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM)
+		return ERR_PTR(-EINVAL);
+
 	if (dmabuf_revocable) {
 		umem_dmabuf = to_ib_umem_dmabuf(iwmr->region);
 
-- 
2.54.0.1189.g8c84645362-goog


