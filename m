Return-Path: <linux-rdma+bounces-22321-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FtIFJH2rMmrd3QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22321-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:13:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B469A734
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:13:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RkvnvNMP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22321-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22321-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 026C5301D32D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D423ED5B;
	Wed, 17 Jun 2026 14:11:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2E3FBEC6
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 14:11:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705518; cv=none; b=QbA2x9bQFiUZcTS47KDewZMpalBgU4XI8HtoIKoVo6vEQYcGLbQy7ytm+s/dx/s4u+KNji1wwbGO/tfl35OU4S1EKFFcdWBOBt9PcwozodYkXjw3t+yIH7Ur8U1SdSPIoMnzSLYZFjKfh6AVo24X/HCZOZMqcSDKd0y1P+OahI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705518; c=relaxed/simple;
	bh=JpWrF5ojxh1u25u+nW20xKlOzSox0eYg3LuZv16/oLA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kaK2aFIwei2zAoX30EzF4BnzGlO1Etm34MNHD5aAqeUBYlOey/xO1ATSC/snk8uj8agXWtZ2MbgtO/+o21/ZFnglIfPQt1m739MwiBqGlypACUCLLVL1zaydrygQWVuZlOEqmK4nWNNDiHp52rTMesD/XoGeHc3CDYmQN73pIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkvnvNMP; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7f010ade153so59278487b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781705516; x=1782310316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PM2oKTJxXbG2kGkmXULehxZPFK8EBGHr5Syt01BuWtI=;
        b=RkvnvNMPL8MX3EOtAdPm7+1jbqrSTWeTaZDFPIqs30QQ1YhdwaXDz8vLuMicmlDbv0
         Ex0h//lIGP3L2VesIqNcwEZ8z+0fa7gCIenK87dzdqDabcy1s5JlCB6PKAvimDqfGr0r
         oCKrztSYMcaN03yJznsQ/yZ75VR85bbbmQKPwNOFvOTiRC81Rb/Ln7u+OZ9bx6M8qq0b
         Lg4DpydF3/TzO0aUIloqNEL13+RBo5CHCB2sYtjv0W//oEtxKe4ITB8SA6cVQK7KECsp
         7GM5bldzZD9pOh9KwOC5Jur9mwwM/lWhAnG57dtjtwHn4rRxc9mi/3gfRzArrhddiVrc
         XUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705516; x=1782310316;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PM2oKTJxXbG2kGkmXULehxZPFK8EBGHr5Syt01BuWtI=;
        b=WG7eFumtwxP5dUUnQS8UE0NX544NNxVd/qpz+qTWMVRIeuP18y9MvbRNM2oMRvaACJ
         Cc/8bwh9yHZ6eHZwfYTDgSs2L3ypwKPxa7xyVFJLmmkRbTEubFidQzIy0kdJsAaEjgph
         dir+LoKQAyf57foeByNxS7a6r41ZY1HcDDMxYbihQvkFkGeRg8/7FVnumW+z0IRhUybb
         VSf35FILxHYn6Cp8IA0Kky1o7kRL2fVvD/zLIN7ZmjdAlRHtE/+6a1qvDDFIiRS9+Kwn
         6kQ/+LNr+gcZKxF147dzonZi27TIUwFxlWbmubpfGb0syznnQ5gjYFcWtxovD03XOeJQ
         CsEw==
X-Gm-Message-State: AOJu0YzKX0FjsnLFDC9wS+H1YP5PaJ4JcIiHnxkEjCEx/U3qV32LYTcM
	R0n+LUf+05YqKgEEDGMA4LOjJD+F8aJVWYN7ebDFy5EjMv76bD/kjumQTUNn3lDA9rqrpOmoGNh
	4yhPIH32RvA==
X-Received: from ywbbc15.prod.google.com ([2002:a05:690c:f:b0:7dd:7e79:4cea])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:4b04:b0:7fd:e030:23db
 with SMTP id 00721157ae682-7fe5f47a9c4mr37016817b3.31.1781705515424; Wed, 17
 Jun 2026 07:11:55 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:11:53 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617141154.3219558-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Prevent rereg_mr for non-mem regions
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22321-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E1B469A734

When a QP/CQ/SRQ is created, a two step process is used
where the buffer is allocated in userspace and explicitly
registered with the normal reg_mr mechanism prior to creating
the actual QP/CQ/SRQ object.

These special registrations are indicated via an ABI field
so the driver knows that they do not have a valid mkey and
to skip the actual CQP command submission.

Since these are real MRs objects from the core's perspective,
it is possible for a user application to invoke rereg_mr on them
and cause a real CQP op to be emitted with the zero-initialized
mkey value of 0.

Fixes: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
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


