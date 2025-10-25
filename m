Return-Path: <linux-rdma+bounces-14045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A201C099ED
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD52B3AE46C
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC930F55C;
	Sat, 25 Oct 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpRRBtsd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B79307ADE;
	Sat, 25 Oct 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409506; cv=none; b=PEsUoONWSJvbOUbSkFTaIy7+f8ZKlbb5fKIeQpVdVxIPEOJxIoPhGxTtRvac3FMp4MkaqDst1SdOh41pAKEC1uzIwj7YVXofurOFqMbSvz39hjShX0P6F/2iqfckYYivXjmPDNdt73jW9Jq5n1/RrP1Nl/erBBxQEOj8cL53qZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409506; c=relaxed/simple;
	bh=mQCUW0RCCXD33ZtjeHweSU2Gd6SdDLgTUBvEpuaGNgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2ev8lyGFDO64YHMNhi+7GrqhKl9ZfJlA3aOQujR4uQZ5/rnJDfIpTRgHYi22azBnIrsGJauS3Sz5en8HVtUaceTCXM2JmpyFuk3j3sluJNtad2LzrPsJ1+fxG2sMp1OyDEQbLR5AT+XWmEKSgeV61W6lSnOmU4wyIYARBuegI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpRRBtsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4B7C4CEF5;
	Sat, 25 Oct 2025 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409506;
	bh=mQCUW0RCCXD33ZtjeHweSU2Gd6SdDLgTUBvEpuaGNgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpRRBtsdLECqNsox2HDQJgzIwMcuXmcg8LY9MjeXbK6KodWsdSpwvJxQFLoCRe4SV
	 1x4p+jzWA4E4ltu1E7UHsKfIeJ5EP9IhzyLbff3RxdwGtGCX32YUmbA5wpsuTK504J
	 nV2+I1JY9N355bx5pLnt+zHlb5NoQrTMUUrVjOpfziUUWXhejfTQUwftwTynfbsFYR
	 GcKGtVq6XKiqBDn7Yrc0L3C4jJNr2gjR6hUkzM//S9paaihkJQlJKH7d/JBIEJ9wH+
	 T+iF0cNxrsQ0jW7i8Y6me7gOLJUGmlFJ5B/ijbLxL40/gNGBtw51oebUhOnNprS31l
	 LEHYTb20vRK2w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	longli@microsoft.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] RDMA/mana_ib: Drain send wrs of GSI QP
Date: Sat, 25 Oct 2025 11:59:44 -0400
Message-ID: <20251025160905.3857885-353-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 44d69d3cf2e8047c279cbb9708f05e2c43e33234 ]

Drain send WRs of the GSI QP on device removal.

In rare servicing scenarios, the hardware may delete the
state of the GSI QP, preventing it from generating CQEs
for pending send WRs. Since WRs submitted to the GSI QP
hold CM resources, the device cannot be removed until
those WRs are completed. This patch marks all pending
send WRs as failed, allowing the GSI QP to release the CM
resources and enabling safe device removal.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://patch.msgid.link/1753779618-23629-1-git-send-email-kotaranov@linux.microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation

- What it fixes
  - Addresses a real hang during device removal when hardware loses GSI
    QP state and stops generating send CQEs; pending GSI send WRs hold
    CM resources and block teardown. The patch proactively fails those
    WRs so CM can release resources and removal can proceed.

- Change details and rationale
  - drivers/infiniband/hw/mana/cq.c: adds mana_drain_gsi_sqs(struct
    mana_ib_dev *mdev)
    - Obtains the GSI QP by number via mana_get_qp_ref(mdev,
      MANA_GSI_QPN, false).
    - Locates its send CQ: container_of(qp->ibqp.send_cq, struct
      mana_ib_cq, ibcq).
    - Under cq->cq_lock, iterates pending UD SQ shadow entries via
      shadow_queue_get_next_to_complete(&qp->shadow_sq), marks each with
      IB_WC_GENERAL_ERR, and advances with
      shadow_queue_advance_next_to_complete(&qp->shadow_sq).
    - After unlocking, invokes cq->ibcq.comp_handler if present to wake
      pollers, then mana_put_qp_ref(qp).
    - This directly resolves the “no CQE emitted” case by synthesizing
      error completion for all outstanding GSI send WRs.
  - drivers/infiniband/hw/mana/device.c: in mana_ib_remove, before
    unregistering the device, calls mana_drain_gsi_sqs(dev) when running
    as RNIC. This ensures all problematic GSI send WRs are drained
    before teardown.
  - drivers/infiniband/hw/mana/mana_ib.h: defines MANA_GSI_QPN (1) and
    declares mana_drain_gsi_sqs(), making explicit that QP1 is the GSI
    QP and exposing the drain helper.

- Scope, risk, and stable rules compliance
  - Small, contained change:
    - Touches only the MANA RDMA (mana_ib) driver and only the teardown
      path and CQ-side helper.
    - No UAPI/ABI change, no behavior outside removal-time GSI send WR
      cleanups.
  - No architectural changes:
    - Adds a helper and a single removal-path call site; does not
      refactor subsystem code.
  - Low regression risk:
    - Operates under existing cq->cq_lock to serialize with CQ
      processing.
    - Uses existing shadow queue primitives and error code
      IB_WC_GENERAL_ERR.
    - Only runs on device removal for RNIC devices; normal datapath
      unaffected.
  - User-visible impact is a fix for a hard-to-debug removal hang;
    aligns with stable policy to backport important bug fixes.

- Security and reliability considerations
  - Prevents a device-removal stall that can be a
    reliability/availability issue (potential DoS via stuck teardown).
    The fix reduces hang risk without exposing new attack surface.

- Dependencies and backport considerations
  - The patch relies on:
    - Presence of GSI/UD QP support and the shadow SQ/RQ infrastructure
      (e.g., qp->shadow_sq, shadow_queue_get_next_to_complete(), and
      cq->cq_lock).
    - The GSI QP number being 1 (MANA_GSI_QPN).
    - A mana_get_qp_ref() with a boolean third parameter in the target
      tree (some branches have a 2-argument variant; trivial adaptation
      may be required).
  - Conclusion: Backport to stable series that already include MANA’s
    GSI/UD QP and shadow-queue CQ processing. It’s not applicable to
    older trees that lack UD/GSI support in this driver.

Why this meets stable criteria

- Fixes an important, user-affecting bug (device removal hang).
- Minimal, well-scoped change in a single driver.
- No new features or interface changes.
- Low risk of regression; guarded by existing locking and only active
  during removal.
- RDMA driver-local; no core subsystem impact.

Given the above, this is a strong candidate for backporting to relevant
stable kernels that contain the corresponding GSI/UD code paths.

 drivers/infiniband/hw/mana/cq.c      | 26 ++++++++++++++++++++++++++
 drivers/infiniband/hw/mana/device.c  |  3 +++
 drivers/infiniband/hw/mana/mana_ib.h |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 28e154bbb50f8..1becc87791235 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -291,6 +291,32 @@ static int mana_process_completions(struct mana_ib_cq *cq, int nwc, struct ib_wc
 	return wc_index;
 }
 
+void mana_drain_gsi_sqs(struct mana_ib_dev *mdev)
+{
+	struct mana_ib_qp *qp = mana_get_qp_ref(mdev, MANA_GSI_QPN, false);
+	struct ud_sq_shadow_wqe *shadow_wqe;
+	struct mana_ib_cq *cq;
+	unsigned long flags;
+
+	if (!qp)
+		return;
+
+	cq = container_of(qp->ibqp.send_cq, struct mana_ib_cq, ibcq);
+
+	spin_lock_irqsave(&cq->cq_lock, flags);
+	while ((shadow_wqe = shadow_queue_get_next_to_complete(&qp->shadow_sq))
+			!= NULL) {
+		shadow_wqe->header.error_code = IB_WC_GENERAL_ERR;
+		shadow_queue_advance_next_to_complete(&qp->shadow_sq);
+	}
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
+	if (cq->ibcq.comp_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
+	mana_put_qp_ref(qp);
+}
+
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 {
 	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index fa60872f169f4..bdeddb642b877 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -230,6 +230,9 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 {
 	struct mana_ib_dev *dev = dev_get_drvdata(&adev->dev);
 
+	if (mana_ib_is_rnic(dev))
+		mana_drain_gsi_sqs(dev);
+
 	ib_unregister_device(&dev->ib_dev);
 	dma_pool_destroy(dev->av_pool);
 	if (mana_ib_is_rnic(dev)) {
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 5d31034ac7fb3..af09a3e6ccb78 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -43,6 +43,8 @@
  */
 #define MANA_AV_BUFFER_SIZE	64
 
+#define MANA_GSI_QPN		(1)
+
 struct mana_ib_adapter_caps {
 	u32 max_sq_id;
 	u32 max_rq_id;
@@ -718,6 +720,7 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr);
 
+void mana_drain_gsi_sqs(struct mana_ib_dev *mdev);
 int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 
-- 
2.51.0


