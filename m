Return-Path: <linux-rdma+bounces-9977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D65BAA9D96
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37A317B189
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09D262FD3;
	Mon,  5 May 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pJhvvEEu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3F1E52D;
	Mon,  5 May 2025 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478467; cv=none; b=JioD4eYJahWlg9VtTHZK1U1oRgCcwhNEW1PAxNKDb0+RVXBWgGS56gM4gvEs/SBHiUfhxP9qvSSDaZHNPuH4m6ERZw1cTigZsXtQoFcbD/9q0yKM75Ijw1zs8ch3dd7hIYbU6AG9DiyuFBdDN3sUuqlMN5PDLl3NWgDI5uMuaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478467; c=relaxed/simple;
	bh=3Z4HIPbhfROj3JRvNjx9nFFQ52DooU1tbemGhN/zXlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSvlktm8A2XT3d5GU3P2qOH9+QURP2tqPHxy1JS1b+DdgN3paEl2RsfaJWmfWEEzN1hmQcSV51Y84LfZdJErNR4izBuRZ23/QfHU6lKwokPsTJioKjVNeuSX7VofISsgM2TO8Ie/5u+SVNaeU98iTK3dSS5sKFJmh/8y8DkBDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pJhvvEEu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DEH6IwGx6oEmmYF7UGfURivuNMF8wH1SDn/lmXt9meI=; b=pJhvvEEuTmQjioWB
	kl1+nE5vArkBMnYw8P5P+MhfHYqJ7fz5SUpzNwJ+oZAlaZipF2QgdkL5tzRLf1buHtTNjaFFHhD83
	Lwavl7gigVO/K6sQfbhhEYzdonl+6RwUZryizjyrZExbZ0F/avuN3jcasgbU33R8M5syZZxrE3rAN
	87QEa7gG4h+HdNm2SAxmAiCl9E6C/To+dm5iZDtw6ewByrGBT7xNQhkbkRauV82SEKkSGvxwA0Yyz
	g81/U4GEAEbWJIkxLbIp0+LaZQnQNHXR7kNDFm/hpj7XOmOmOdGcbN0PDsr5LpaWtmsfKqGlGFhGH
	0rNW8OkwQBgplc+wbQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uC2pP-001WMn-2s;
	Mon, 05 May 2025 20:54:19 +0000
From: linux@treblig.org
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] IB/hfi1: Remove unused sc_drop and sdma_all_idle
Date: Mon,  5 May 2025 21:54:19 +0100
Message-ID: <20250505205419.88131-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

sc_drop() and sdma_all_idle() were both added in 2015's
commit 7724105686e7 ("IB/hfi1: add driver files")

but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/hw/hfi1/pio.c  | 10 ----------
 drivers/infiniband/hw/hfi1/pio.h  |  1 -
 drivers/infiniband/hw/hfi1/sdma.c | 18 ------------------
 drivers/infiniband/hw/hfi1/sdma.h |  1 -
 4 files changed, 30 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 5a91cbda4aee..764286da2ce8 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1361,16 +1361,6 @@ void sc_flush(struct send_context *sc)
 	sc_wait_for_packet_egress(sc, 1);
 }
 
-/* drop all packets on the context, no waiting until they are sent */
-void sc_drop(struct send_context *sc)
-{
-	if (!sc)
-		return;
-
-	dd_dev_info(sc->dd, "%s: context %u(%u) - not implemented\n",
-		    __func__, sc->sw_index, sc->hw_context);
-}
-
 /*
  * Start the software reaction to a context halt or SPC freeze:
  *	- mark the context as halted or frozen
diff --git a/drivers/infiniband/hw/hfi1/pio.h b/drivers/infiniband/hw/hfi1/pio.h
index d07cc6ea7c63..ab0f9a3a8d12 100644
--- a/drivers/infiniband/hw/hfi1/pio.h
+++ b/drivers/infiniband/hw/hfi1/pio.h
@@ -246,7 +246,6 @@ void sc_disable(struct send_context *sc);
 int sc_restart(struct send_context *sc);
 void sc_return_credits(struct send_context *sc);
 void sc_flush(struct send_context *sc);
-void sc_drop(struct send_context *sc);
 void sc_stop(struct send_context *sc, int bit);
 struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
 				pio_release_cb cb, void *arg);
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 0d2b39b7c8b5..16a749d16ee9 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1520,24 +1520,6 @@ void sdma_all_running(struct hfi1_devdata *dd)
 	}
 }
 
-/**
- * sdma_all_idle() - called when the link goes down
- * @dd: hfi1_devdata
- *
- * This routine moves all engines to the idle state.
- */
-void sdma_all_idle(struct hfi1_devdata *dd)
-{
-	struct sdma_engine *sde;
-	unsigned int i;
-
-	/* idle all engines */
-	for (i = 0; i < dd->num_sdma; ++i) {
-		sde = &dd->per_sdma[i];
-		sdma_process_event(sde, sdma_event_e70_go_idle);
-	}
-}
-
 /**
  * sdma_start() - called to kick off state processing for all engines
  * @dd: hfi1_devdata
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index d77246b48434..91dfd5d0c419 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -373,7 +373,6 @@ void sdma_start(struct hfi1_devdata *dd);
 void sdma_exit(struct hfi1_devdata *dd);
 void sdma_clean(struct hfi1_devdata *dd, size_t num_engines);
 void sdma_all_running(struct hfi1_devdata *dd);
-void sdma_all_idle(struct hfi1_devdata *dd);
 void sdma_freeze_notify(struct hfi1_devdata *dd, int go_idle);
 void sdma_freeze(struct hfi1_devdata *dd);
 void sdma_unfreeze(struct hfi1_devdata *dd);
-- 
2.49.0


