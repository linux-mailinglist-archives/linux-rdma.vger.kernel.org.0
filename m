Return-Path: <linux-rdma+bounces-22295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ampOR8GMmpytwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:27:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DED69620E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:27:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AONuLRoA;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22295-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22295-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0D63088D14
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1B2F6920;
	Wed, 17 Jun 2026 02:27:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B013A86C
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 02:27:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663260; cv=none; b=N7Quv33UsuswFUm4cbaFcwP9Xbvo0x6PY1vOPGO0w/WG6gaNzcpqpjG9gxLtbmG1OxiD2dD9kZjnNPB8kRIlbonyZi+TU0BD+xG+OrhUf4YjB3RH6Opl15ihD4gNuA+YNqgNTy4FXeIGgIRtySw3jraQvT8wbsMMFpJtQxUTsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663260; c=relaxed/simple;
	bh=fcR+jezMV/sVy606yqri75vwYxp/Ra0GNSz9cosRPkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5Bh0f/+J+3Yn4aL641xNuJhKOzAnPPoqhKJsPX8IzZhQ57XDK+Kx5OTFDfiBkKtNd9gef5PNXt+0DOQxCRKz4kJQAeKyXj0QKIb1TL0yXUVEPfQbXLTE5bIOOMp2Nz6jZpLVGsi8Ze43Q/kKWKJBL3Uo9JkUlfrhceuM/lGO7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AONuLRoA; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so49251156d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781663258; x=1782268058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktjJqBnaGmjMRGpJyIHT+t50w0McyR9fKA191IrHC5Y=;
        b=AONuLRoAkaBHsKgZhkHEJuKWw3GhBUhZcpuU3NpcAbPKMUuMvKlbMZDwqVPYk7Gzi6
         yG8cv5QSh1ncm9/sPDJXcXfDSFLv4a410Z3tXtRURhXLcEgSBz0xGjOJQ8wLgNAYEKej
         r+F4SXS88z5Fn1K3tBRZOZ7YlgiWCUw1atijE4+w6pMx3mRIt0PHT/KwN4pPUpKNuzKS
         SA9xOsL4fm+mz6VzMvHzSIW61tIwJptB4c6Rm9zp0xiiDjRn7gpDp/dMyeNQlF3Mzr/M
         pWyYT4L4jSWgjxEJownAG4ego1vT8UGN8xvqqCYLqxPdKZbBv0QRNV6o1ejbldDkh8XD
         LQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663258; x=1782268058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktjJqBnaGmjMRGpJyIHT+t50w0McyR9fKA191IrHC5Y=;
        b=J4ta+0Fj6h3UgnJfQFXHwozQRtG2mM35XdVe71kovcDFGYQ8y70VK5sPgRotR7sbY+
         dRx49wCweCU3ELhzh5w4x08Are4zDBG1XArac4JyfZh1rAHeycDxbN14LVnZL08FB4Pu
         gI+nAx3fcOgO/CqrwdZcK/GjTQSbLSAVOpxu6QWguRqWNWRhzvQsut2HMrWPak2wnhan
         XjyeySHIMn48eXt+glaGMNV/evHMAwEctZ4FnAQPfrdXS2EVY2vVdAmbBDpTlYmBoTvn
         LXfiF2vUBJxd+M0hjq/F3hcYLpsQ3jMg7DFSytuTtfOr8EsHh/EP+35AZwf7oy0nmfLe
         5t2w==
X-Forwarded-Encrypted: i=1; AFNElJ8+oLuvKFmUcJ3ZrFHfhW/PaXjB+gJa4mK2Hmf1Ht7MBFEzDLrVh60b+vzivn2A4W+lcG6pAxBc7Zxy@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUz0f4vAOtUDx86lQxwqoB7bAawOsAv+7hEeS284MSu2Ra5/9
	vlSZYP6d6oZaMXHqOgtpljdwbYYXHUF7XZwHRxcs4zM3CncKRq40HEeA
X-Gm-Gg: AfdE7cm6crLfuXc3/00Nx9eqzxScSBAnaUuSQPLLVLM5xj2doH2cmdeqP0t0b40pda7
	Ae6PmlKQKWNe/Gh5z5iU281NRoWqhP3H+zLRnRjpOfbMnvzcQg3HNyYZfEOqbBqdb/2vDVukrgK
	64RYSFsuLUQ93fGet9+CuYgqcoj/yipzI+yugdsC1F+PKPs+754lmO/Oz5rMrS5T/w7LtZF99z/
	menRl+rHGEaGVqGvMP7xXBaFDppQSs11QRD1dCy3rfQPPdxUta16WJkcx5v1WKJhqjDApoUQ3TX
	E7lozBCsPTqRvGU1eFSRv0r7K6SCkkBJoMzEdGkPqW9EG40Uat6riRIGu36YXu4PVNZyTowhPWc
	2EAN7U6oZaYAUt0Y3vxHL82lKY2Ix2cxCwsEe0yVP8iqNyommGKwfIkSBr4eZlidHPPjdEzTuqG
	Y3MMKfn9ta8Jr3mYSFx4C4hlK+/CaEsDdJ18ywXEmfOFzcyE0GeXGoatNLF1qxayMR2zcoBE9Fv
	/XMx7bQvpwPxICZfqRmy2UqAiEbjxkH
X-Received: by 2002:ad4:594b:0:b0:8ca:25d3:bf41 with SMTP id 6a1803df08f44-8db5b6b245cmr39290106d6.8.1781663258118;
        Tue, 16 Jun 2026 19:27:38 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f4556922sm51235576d6.24.2026.06.16.19.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:27:37 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Bob Pearson <rpearsonhpe@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: insert mcg into mcg_tree only after rxe_mcast_add() succeeds
Date: Tue, 16 Jun 2026 22:27:28 -0400
Message-ID: <20260617022728.2770116-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev>
References: <1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22295-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:rpearsonhpe@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42DED69620E


rxe_get_mcg() publishes a newly allocated multicast group in
rxe->mcg_tree before programming the backing Ethernet multicast address
with rxe_mcast_add(), which runs outside mcg_lock. A local userspace
RDMA client reaches this path with ATTACH_MCAST on a UD QP; if
rxe_mcast_add() then returns an error (for example -ENODEV when the
backing netdev has been removed, or a propagated dev_mc_add() error),
the unwind frees the published group without removing it from the tree.
A later lookup of the same MGID dereferences the freed struct rxe_mcg
from __rxe_lookup_mcg().

Fix this by keeping the new mcg private until rxe_mcast_add() succeeds.
Split the tree publication into __rxe_publish_mcg(), call rxe_mcast_add()
before taking the tree reference, and free the still-private mcg on
failure. Because the group is never visible in mcg_tree until the
multicast address is programmed, no concurrent caller can look it up or
attach a QP to a group that is about to be torn down, so the error path
needs no conditional unwind. If another caller publishes the same MGID
while the address is being programmed, the post-add re-check under
mcg_lock finds the winner; this caller then drops its private object and
balances its own rxe_mcast_add() with rxe_mcast_del() before returning
the winner.

Reproduced by forcing the rxe_mcast_add() error return under KASAN:
without the change the next attach to the same MGID reports a
slab-use-after-free in __rxe_lookup_mcg(); with it the forced failure
returns cleanly. A no-injection attach/detach regression, including a
two-QP shared join/leave and re-attach, stays KASAN- and leak-clean.

Fixes: a926a903b7dc ("RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock")
Cc: stable@vger.kernel.org # v5.18+
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: switch approach in response to Zhu Yanjun's review of v1
    (https://lore.kernel.org/all/1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev/). v1 unwound the
    already-published mcg on the failure path; Zhu noted that because
    rxe_mcast_add() runs outside mcg_lock, a concurrent caller can find
    the published mcg and attach a QP in that window, so an unconditional
    teardown would orphan those QPs and leak the mcg. Rather than make the
    teardown conditional, v2 does not publish the mcg into mcg_tree until
    after rxe_mcast_add() has succeeded, which removes the window entirely
    (the safety of the two-CPU same-MGID race and the loser-side
    rxe_mcast_del() balance is analysed in the commit log above). No
    Fixes/stable change; this is still the same UAF.
    v1: https://lore.kernel.org/all/20260614130443.2517578-1-michael.bommarito@gmail.com/

Reproduction
============

Tested on v7.1-rc4 (5200f5f493f7) on x86_64 QEMU/KVM with KASAN,
rxe, rdma_rxe, and userspace verbs against a Soft-RoCE device.

Conditions: the caller needs access to the rxe uverbs device and a UD
QP. The demonstrated error path requires rxe_mcast_add() to fail after
the mcg allocation; natural failures include netdev removal returning
-ENODEV and dev_mc_add() errors such as -ENOMEM. The test made that
return deterministic by forcing rxe_mcast_add() to return -ENODEV.

The private harness creates a UD QP, attaches an MGID, forces the
rxe_mcast_add() failure, and repeats attach on the same MGID so the
lookup walks the stale rb-node.

Stock: KASAN reports a slab-use-after-free in __rxe_lookup_mcg() while
comparing mcg->mgid on the next attach.
Patched: the forced-failure path returns without a KASAN report.
Regression: no-injection attach/detach, two-QP shared join/leave, and
re-attach complete without KASAN, WARN, or leak reports.

Mitigations: restrict access to the rxe uverbs device or avoid loading
the rxe driver where untrusted local users can create RDMA objects.

The harness is available off-list on request. The RDMA selftest gate was
checked; tools/testing/selftests/rdma does not contain a matching
rxe_mcast or ATTACH_MCAST coverage test.

 drivers/infiniband/sw/rxe/rxe_mcast.c | 50 +++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 5cad72073eca1..eaa259cc39ea9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -175,7 +175,9 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
  * @mgid: multicast address as a gid
  * @mcg: new mcg object
  *
- * Context: caller should hold rxe->mcg lock
+ * Initializes the mcg fields. The mcg is private and not yet visible in
+ * mcg_tree, so this may run without rxe->mcg_lock; __rxe_publish_mcg()
+ * makes it visible under the lock once it is ready.
  */
 static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 			   struct rxe_mcg *mcg)
@@ -184,13 +186,22 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
+}
 
-	/* caller holds a ref on mcg but that will be
-	 * dropped when mcg goes out of scope. We need to take a ref
-	 * on the pointer that will be saved in the red-black tree
-	 * by __rxe_insert_mcg and used to lookup mcg from mgid later.
-	 * Inserting mcg makes it visible to outside so this should
-	 * be done last after the object is ready.
+/**
+ * __rxe_publish_mcg - make a fully initialized mcg visible in mcg_tree
+ * @mcg: the mcg object
+ *
+ * Context: caller must hold rxe->mcg_lock and a reference on mcg
+ */
+static void __rxe_publish_mcg(struct rxe_mcg *mcg)
+{
+	/* caller holds a ref on mcg but that will be dropped when mcg goes
+	 * out of scope. We need to take a ref on the pointer that will be
+	 * saved in the red-black tree by __rxe_insert_mcg and used to lookup
+	 * mcg from mgid later. Inserting mcg makes it visible to outside so
+	 * this is done last after the object is ready and the multicast
+	 * address has been programmed.
 	 */
 	kref_get(&mcg->ref_cnt);
 	__rxe_insert_mcg(mcg);
@@ -228,26 +239,37 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 		err = -ENOMEM;
 		goto err_dec;
 	}
+	__rxe_init_mcg(rxe, mgid, mcg);
+
+	/* program the multicast address while mcg is still private, before
+	 * it is inserted into mcg_tree. dev_mc_add() may sleep so this must
+	 * run outside mcg_lock. On failure mcg was never published, so a
+	 * plain free is correct and the tree is untouched.
+	 */
+	err = rxe_mcast_add(rxe, mgid);
+	if (err) {
+		kfree(mcg);
+		goto err_dec;
+	}
 
 	spin_lock_bh(&rxe->mcg_lock);
-	/* re-check to see if someone else just added it */
+	/* re-check to see if someone else just added it while we were adding
+	 * the multicast address; if so use theirs and drop ours
+	 */
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
+		rxe_mcast_del(rxe, mgid);
 		atomic_dec(&rxe->mcg_num);
 		kfree(mcg);
 		return tmp;
 	}
 
-	__rxe_init_mcg(rxe, mgid, mcg);
+	__rxe_publish_mcg(mcg);
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	/* add mcast address outside of lock */
-	err = rxe_mcast_add(rxe, mgid);
-	if (!err)
-		return mcg;
+	return mcg;
 
-	kfree(mcg);
 err_dec:
 	atomic_dec(&rxe->mcg_num);
 	return ERR_PTR(err);

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

