Return-Path: <linux-rdma+bounces-18340-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA3rFS7Kumm6bwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18340-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C445A2BEABA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230083191857
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57DA3E3C5D;
	Wed, 18 Mar 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D11s32Qa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753130DD38
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847681; cv=none; b=kJobLJaEzGS00Gmjw73ZLuaO8fBywSsDKmrnAtIHlNdTFC/mJFydgRrITt1EqoxZuIwxbwUgS8aCYf1WD5zMy0WHmBieGv5ChWHUPksLw2djT6eIthSpXCXTfXckl6nQlaiFpcsRHj3zsgfwzhstkcr3Y9G5jgro5j+FCZ8UvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847681; c=relaxed/simple;
	bh=GbZRRh4RoNSGiNCTFjlbY2ucXc50MIoFQsOyq9Oa01k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqUlPAPr8fx9nf89tU3NGnoymXNawjTtuNeB5WoeudwfZiX07TU5glkmTMyxTSDf1XvWw0sagDpMxoNv8YJHcV3bSaGV1BZzwpA0jhnM6kF/+89K4IhWMNWpjZaKgc9vlNeWsgDxmaASEEOeQUpYp3qOjAsUIQznyxljOq0uxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D11s32Qa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso7025868f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773847676; x=1774452476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77Y5sebBj+JaxjNi30fFEElZ26WjOo0wU0NWMbSKIuo=;
        b=D11s32QaVKpvTfD9NT1dKUc3lrrrhRDCW1bWahQaFoQa7lIxRk0kGwhufw6SbjQVVb
         mOpasD9Oq/i2LiceTysjQlZKr2NpqqFzkpfKGYo3X2wDojp3X22o7bSPBiWGMNafjgS6
         YFqlAUVVA2Fwf8zmrqGdVnD6pxSm5prkTiMxA3h4ZtTmgHjk8ZHQ9pgXJPDmXDIidDsj
         gHjDOEBmKV7l6Dqhkvf+AezSis4mDYbJ1M65glABEdkfdAK9OI7tlW0SDLlVWYneJex/
         PtOSyxXc+HvBtkU0DqmVYiXPjgNo17yA/EJXO8Bpz49XJtBROwk8Pklzc2oL5fJ2OAY6
         muWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847676; x=1774452476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77Y5sebBj+JaxjNi30fFEElZ26WjOo0wU0NWMbSKIuo=;
        b=OCLM95mMGPLPTW+wHaME0IK01UIWMzyq+vklUG1cSOoub3ie3PLsE1mf8VhxHcLYvq
         DV5lWO2Jk46whmrc7rNIGtFXlfPNt17wTekGugDe23nmvqS8ebWKsMvp67ygbBquwbxi
         wBDOxLJRoyBRndX5Hayrqo8zY77WIitFg/eT+wDo65qrKdtfkDbIkiTrQpe+y9/jlkag
         X9y6Wxq7rL/W0r0XTDCyehtOsZUPBG9WL99G1EtPCtQ0oTyQkLQOn6I9FMDqQY6SA+eD
         T5LPiSwv+Lu0kt1YTb7pkf9K7R9UpEVNGHjsXJJ0cpTKFvVwU5RRNd6VbeUcG20FDZfl
         E01w==
X-Forwarded-Encrypted: i=1; AJvYcCWfNObJK5t6LW8cB37cuHC8sN6t3KwczeCHfXk4ZMv3ZOy0uOlIG1PpNbHgz8TPIkLzO1h8uT7+cBpP@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGMS99hLdzuHi7Fm/7cbOS+9YF8INQtvO6abznvlSBhQX9cuU
	ORWRKMoEdHn4+fD7YTBmaqjMqSoBVIQwXcOoF3hT+/RMuVwvdCfDlpHhiITIJqZHbew=
X-Gm-Gg: ATEYQzxdlDuGUz72tsMfKroXZ4q+9jRayWmDpbrxGnKYF90Itp/QneOUtVweqExcPEG
	XZgNCDqBghfqF6jg0D7r+Ou7qfOrFMdeucxdyE3e9R1gYJl3YSzc8nZ2IwjwoWjnzeN5JDmBNXl
	kVNd4cmBOzRwK+veTTrDZjVmf/Zi7B1wdLLgyvc2SHkl53Z7l0+D1YcH/USdul8DjIevpsqaH/E
	qL5DTXYG1uairtNXN9qtS3Zk6MoG0MVd/2krmm6AnmNnRba5KlleFM6UNcBAotoKG3LYBwoCeA0
	FxHlAOJTbgQPRdFrGcCrf7YawM0nHQKTHAmsbmhLGBOVM5s1rdOUHB9x+UoCu+8DquCrCAJJF2x
	nOq77H5UeIUeOZ3IwYH7+GmieXgWhLFQxKdpw59N0AB3orj621IWxqLT9WPTgZLxVLLrW+BVUAW
	L7XWP4HgbEbCMb9IUgvfL6y+GF23SUhtPVLeY+CLojeK9bWdc=
X-Received: by 2002:a05:6000:288c:b0:43b:3b80:6776 with SMTP id ffacd0b85a97d-43b527c35e6mr6305356f8f.30.1773847676142;
        Wed, 18 Mar 2026 08:27:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51899617sm9075379f8f.31.2026.03.18.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:27:55 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH v2] RDMA/rxe: Replace use of system_unbound_wq with rxe_wq
Date: Wed, 18 Mar 2026 16:27:48 +0100
Message-ID: <20260318152748.837388-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18340-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.985];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C445A2BEABA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

This specific driver already allocate an unbound workqueue named "rxe_wq",
so replace system_unbound_wq with this one instead of system_dfl_wq.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- use of rxe_wq instead of the new system_dfl_wq.
- removed the "static" key from rxe_wq definition making it extern in the
  header file.

---
 drivers/infiniband/sw/rxe/rxe.h      | 2 ++
 drivers/infiniband/sw/rxe/rxe_odp.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_task.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index ff8cd53f5f28..c56bae376c7f 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -121,4 +121,6 @@ void rxe_port_up(struct rxe_dev *rxe);
 void rxe_port_down(struct rxe_dev *rxe);
 void rxe_set_port_state(struct rxe_dev *rxe);
 
+extern struct workqueue_struct *rxe_wq;
+
 #endif /* RXE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index bc11b1ec59ac..ff904d5e54a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		work->frags[i].mr = mr;
 	}
 
-	queue_work(system_unbound_wq, &work->work);
+	queue_work(rxe_wq, &work->work);
 
 	return 0;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index f522820b950c..801d06c969c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,7 +6,7 @@
 
 #include "rxe.h"
 
-static struct workqueue_struct *rxe_wq;
+struct workqueue_struct *rxe_wq;
 
 int rxe_alloc_wq(void)
 {
-- 
2.53.0


