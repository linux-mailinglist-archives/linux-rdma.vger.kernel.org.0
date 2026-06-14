Return-Path: <linux-rdma+bounces-22214-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VPVLJAKnLmpe1gQAu9opvQ
	(envelope-from <linux-rdma+bounces-22214-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:05:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433468110F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:05:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=APtjPMMJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22214-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22214-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4852300F5C8
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA8355F22;
	Sun, 14 Jun 2026 13:04:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D239A7F7
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 13:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442296; cv=none; b=vF7jo/fGSIREV0Q3eA5FYSC1Xzme5L9Hr9Rv8nktT0re1MzVGstBLUbMm0kVPwHRkPh4SUn2wi0SW0augWF1v+R9UWxmyOsL/4FJ91xSaiG0OiHyJsWYXQ54DIfXm7FLpkEwxvFEKrqXG0LJhiQDUF1aHken14mOWdScfMIH6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442296; c=relaxed/simple;
	bh=ADCNFUh94Rv4KNKJvYbbe8p47vvd4whs5tudmJRWnb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqHOC9Ibth9w7LGfgL3YYmS7zAL94zanQt07icbau/0ehARkM9cN3tcZYQBbA2H4f29P+HvrsUJdp3yD4h7oN9lh9t6w+d0C5CmbUBsosBk0ntdErsqg/kSi5WHZwgyeQpETu92MBToYTEU7zK6sqoZwF32BSwbpz/7ovZJzFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APtjPMMJ; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517863a2edfso19962561cf.1
        for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442293; x=1782047093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GPmxYA8Yy2PWTqYiGecskY9yfd7+d/20uBDlyc5AuA=;
        b=APtjPMMJr7psP9tQyrGlwR1AqtdHU4ElC4d1EJ0WpJ6QfGFQNwskHSVyW3oqXiGQq9
         e+JhC3zwee1uPvy3qSA15Qu5KJCoIlciXKwr2Q+W7LfkRmb7Ecg4HmivVMvWVtrE+5wW
         0Vz3rLi05eFaQnv9SrrBul9WjSRvWRwtxKA1T7vmwb3trIMDiLt0hGW46vFcLSUk68wV
         TngkOQpWz3s4A3tmh5Kb8IYqZH1y/scDOSOr1KIbv0Y0ayaqWEirG31dH4j9SxI9B8Ps
         kiwsCORessnXzjdIYd3oPF4hc6Wbpp+EJu9L+J6CY0aHobzx0kTs7+0NOXbrWbPQliBr
         frnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442293; x=1782047093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GPmxYA8Yy2PWTqYiGecskY9yfd7+d/20uBDlyc5AuA=;
        b=I8ugbKqKw9LobBK8ClO3vwJQI+ESWtiK7ZNr5JNGSkzZQ/wzYbsVcWBF8cOqRRw6ya
         sZaFxQItiRJc12kvQif2kVaHJGIxgVkYxhTFHUnLZ79A8eKUmhVtp5w+TeNVdqkU59RG
         6gdTyoHfh4i1tp7lba3uHNwG9WZBcwlMZ6jWGdI7X9aHARtUud6xO5+EXsMfSII6wgEf
         Ng+NBsoOQKbozHquXrfG1uezLhtXxVfMf3K4WEwtDOLavodSgmqZ2wPr4uh/OE7dNonv
         r9+NWGHYqrzerygwxVftAwgp7CiSm96uIokcb8BSHgd3OreEtXnSb4PyflHLFd8ZunPF
         +aqg==
X-Forwarded-Encrypted: i=1; AFNElJ9LDx+vK7M+A42I0CJ4rFCVXT1wbAcbSc0b4qwaPa1E0fDXGLIU5f1Rb6FUVGj8914V7c3CXctcaDZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxIn/0ZNbmFyc0xP2ixdrnVpk0r9BBojXjjH8a/VHzWchXa3S3+
	y3zAEVonNkwNu9jTkkRpMbDf9FidAEWVJbsY170D2CzsLPFxzUigTkB1
X-Gm-Gg: Acq92OFpCCOVb+HeFTCHwKWf4F+uJHfICsmKGq9/N1j5UuXo7j0/qhwLCj7/mLNp5F1
	ovDxgv4pOBKE1MDAX6DT1MU3gtJl/em5mmwbuCOUgjzp5ASxKVe7eWBaVmzxupqLpjX0s8NRRLo
	+dtwjpLmMMFoU3BhYG9WbKCDmarwQ9mPDJJxYhKoF/2TgRQIorUNx4R7hkLSWCgTEzEnnA+roEQ
	j+okg0Pzp9hKZzP8b9veJPjqb94u64AnRCDU7Pt/h5f+N6jsqlILPsYFtuAYd0t2Fg5EbTKUr13
	JaSpW0Wx0QpR9vNLjBW32/mVVDpdUT0aTr5HF/p94owpJeGosm+A+25DzMnI/EAP4WQa+3dASIj
	roEccbtjTIDPq+0Ku4mtlZKjSiOs8Je3oZ4A/pGP6VGTN9zIVgL2qSz0Rg2u6QHzy7isK5Sgv/c
	J+2SVd6kWLfLTIJ45VRxRUGRAaXXF17MrlJuMz2zZDWPtVjtYwCAN6vv+O8fit7D+2NQcgtUSGc
	E5DHLYKV5/Lfxp2GN6mLzxBl7VEe+G7UJxKSsz0PK8=
X-Received: by 2002:a05:622a:a0f:b0:517:9593:edaa with SMTP id d75a77b69052e-517fe4d7868mr162415471cf.31.1781442293315;
        Sun, 14 Jun 2026 06:04:53 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb854290sm73644611cf.31.2026.06.14.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:04:52 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Bob Pearson <rpearsonhpe@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: destroy the mcg when rxe_mcast_add() fails in rxe_get_mcg()
Date: Sun, 14 Jun 2026 09:04:43 -0400
Message-ID: <20260614130443.2517578-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:rpearsonhpe@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22214-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3433468110F

rxe_get_mcg() inserts the new mcg into rxe->mcg_tree and takes the tree
reference before calling rxe_mcast_add() outside mcg_lock. On failure
the error path frees the mcg with a bare kfree() without erasing the
tree node or dropping the tree reference, so the freed mcg stays linked
in mcg_tree and the next __rxe_lookup_mcg() on the same mgid uses it
after free. rxe_mcast_add() fails reachably from an unprivileged caller:
-ENODEV when the backing netdev is removed, or a propagated dev_mc_add()
error.

Tear the mcg down with __rxe_destroy_mcg() on the failure path, as
rxe_attach_mcast() already does.

Reproduced under KASAN on QEMU by forcing the rxe_mcast_add() failure;
the use-after-free in __rxe_lookup_mcg() is gone after this change.

Fixes: a926a903b7dc ("RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock")
Cc: stable@vger.kernel.org # v5.18+
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduction (v7.1-rc4, x86_64 QEMU/KVM, KASAN, Soft-RoCE):

Forcing rxe_mcast_add() to return -ENODEV, an unprivileged ATTACH_MCAST
on a UD QP leaves the freed mcg linked in mcg_tree. On the stock kernel
the next lookup reports

  BUG: KASAN: slab-use-after-free in __rxe_lookup_mcg

and the subsequent rb_erase() panics. Patched, the forced failure
returns cleanly. Control: with injection disabled, re-attach and detach
of the same MGID and a two-QP join/leave are KASAN-clean on both trees.

tools/testing/selftests/rdma has no rxe_mcast coverage; harness off-list
on request.

 drivers/infiniband/sw/rxe/rxe_mcast.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 5cad720..7f148d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -196,6 +196,8 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	__rxe_insert_mcg(mcg);
 }
 
+static void __rxe_destroy_mcg(struct rxe_mcg *mcg);
+
 /**
  * rxe_get_mcg - lookup or allocate a mcg
  * @rxe: rxe device object
@@ -247,7 +249,13 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	if (!err)
 		return mcg;
 
-	kfree(mcg);
+	/* mcg was made visible in mcg_tree; unwind the insert before freeing. */
+	spin_lock_bh(&rxe->mcg_lock);
+	__rxe_destroy_mcg(mcg);
+	spin_unlock_bh(&rxe->mcg_lock);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	return ERR_PTR(err);
+
 err_dec:
 	atomic_dec(&rxe->mcg_num);
 	return ERR_PTR(err);
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


