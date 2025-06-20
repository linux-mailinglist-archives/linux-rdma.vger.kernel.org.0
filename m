Return-Path: <linux-rdma+bounces-11500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730CEAE1A2C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CD9189BAEA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26628A1FE;
	Fri, 20 Jun 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLk3W+n8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6221A425;
	Fri, 20 Jun 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419818; cv=none; b=UWul1cVDrYaHnZ94Arrc8JAJkUjCdjNaEPVOAkZzcQaxWMwfdBlVAlDmixZHcQ/kP4sPa6DzXQ/T64aAKgunVHNU7FCUeps6A9SX8bE1omzSSq6M5HROi39OfaDrq2HffO0kLOrOc3i+CdUZs21OwmLiv0s9n5zGNAmdF2KSTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419818; c=relaxed/simple;
	bh=huyYXBjxoUlbMgsEeTSO6RSLo2wZgKDFybH8JTb2g7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thOQ9ZWaxkKvJMJt5CBm3TJVrIkD0yL2J3yT8ayGcsRRxYsiKMk5B+GUcpkOKmPUIZ1h+HqLBly1aV4LmGkzBVJ+StonQ6WBuArCDzPc7ceZRWIAPgh7Cw87zICb/MwMm8waUMiSYlyD1Wa0RAQF8u0wRm50OhqPA+mwExfu5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLk3W+n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B0C4CEE3;
	Fri, 20 Jun 2025 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419817;
	bh=huyYXBjxoUlbMgsEeTSO6RSLo2wZgKDFybH8JTb2g7U=;
	h=From:To:Cc:Subject:Date:From;
	b=PLk3W+n8O9Q8SeD4XraZY78wnohzP6GWTciiDsfCB31+VTS3aBn0YbGqHGo8KYTfK
	 UbJEgpwICGi35S6ZJqq1tYIh3Le1lysdVB836foEcu6RwxDoW9RBw2AzPEDvnda1cU
	 py1VyGN7NQ6VZrHMtXGKi7kmEUfX4btMyIHkY0UelMTdqf8hsd6HzpSWsjJh/1lxK7
	 ivcQ3E5rYPm6QWiOqFGqe1XLDJdXLEPF3y1brzHwGtQrW+eVkv8/VpZw5o5yPzLS/o
	 qnvZrvtHIcfTCL9XkopBQbMkAqHN10HLIvgeVMv/i/w29Dg3Ckmk4ap0iBr/nVfyyh
	 wiHQtrmwJVIYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Showrya M N <showrya@chelsio.com>,
	Eric Biggers <ebiggers@google.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] RDMA/siw: work around clang stack size warning
Date: Fri, 20 Jun 2025 13:43:28 +0200
Message-Id: <20250620114332.4072051-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang inlines a lot of functions into siw_qp_sq_process(), with the
aggregate stack frame blowing the warning limit in some configurations:

drivers/infiniband/sw/siw/siw_qp_tx.c:1014:5: error: stack frame size (1544) exceeds limit (1280) in 'siw_qp_sq_process' [-Werror,-Wframe-larger-than]

The real problem here is the array of kvec structures in siw_tx_hdt that
makes up the majority of the consumed stack space.

Ideally there would be a way to avoid allocating the array on the
stack, but that would require a larger rework. Add a noinline_for_stack
annotation to avoid the warning for now, and make clang behave the same
way as gcc here. The combined stack usage is still similar, but is spread
over multiple functions now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 6432bce7d083..3a08f57d2211 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -277,6 +277,15 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 	return PKT_FRAGMENTED;
 }
 
+static noinline_for_stack int
+siw_sendmsg(struct socket *sock, unsigned int msg_flags,
+	    struct kvec *vec, size_t num, size_t len)
+{
+	struct msghdr msg = { .msg_flags = msg_flags };
+
+	return kernel_sendmsg(sock, &msg, vec, num, len);
+}
+
 /*
  * Send out one complete control type FPDU, or header of FPDU carrying
  * data. Used for fixed sized packets like Read.Requests or zero length
@@ -285,12 +294,11 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 			      int flags)
 {
-	struct msghdr msg = { .msg_flags = flags };
 	struct kvec iov = { .iov_base =
 				    (char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent,
 			    .iov_len = c_tx->ctrl_len - c_tx->ctrl_sent };
 
-	int rv = kernel_sendmsg(s, &msg, &iov, 1, iov.iov_len);
+	int rv = siw_sendmsg(s, flags, &iov, 1, iov.iov_len);
 
 	if (rv >= 0) {
 		c_tx->ctrl_sent += rv;
@@ -427,13 +435,13 @@ static void siw_unmap_pages(struct kvec *iov, unsigned long kmap_mask, int len)
  * Write out iov referencing hdr, data and trailer of current FPDU.
  * Update transmit state dependent on write return status
  */
-static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
+static noinline_for_stack int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
+					 struct socket *s)
 {
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
 	struct kvec iov[MAX_ARRAY];
 	struct page *page_array[MAX_ARRAY];
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
 
 	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
 	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
@@ -586,14 +594,16 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 		rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
 				  c_tx->sge_off, data_len);
 		if (rv == data_len) {
-			rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
+
+			rv = siw_sendmsg(s, MSG_DONTWAIT | MSG_EOR, &iov[seg],
+					 1, trl_len);
 			if (rv > 0)
 				rv += data_len;
 			else
 				rv = data_len;
 		}
 	} else {
-		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
+		rv = siw_sendmsg(s, MSG_DONTWAIT | MSG_EOR, iov, seg + 1,
 				    hdr_len + data_len + trl_len);
 		siw_unmap_pages(iov, kmap_mask, seg);
 	}
-- 
2.39.5


