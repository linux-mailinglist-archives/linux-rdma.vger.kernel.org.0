Return-Path: <linux-rdma+bounces-20599-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAuDKbO6BGrHNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20599-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF5E53863A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE510301450F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991BB4DD6D2;
	Wed, 13 May 2026 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIcAPyg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4D4DBD97
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694813; cv=none; b=YgYc/55Y6zUtpH7/xrvmJozjH7ZrJr7Uq2DMC7XXNb+LPJNodae1quWxdDrLNyOfufmd8v2CeS10z8b3NEjE/m+On42R3mWyQJICUkCfvnzPwT+w1I6yf1bB8aoOvS9PDIIvCaUSYVcKgbjj3sCwXpHYDFjmZMRbYSKcoP9s778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694813; c=relaxed/simple;
	bh=zNu1dPnVUp8Za6/qZk1i2eXcs0j69iChQl4hWpE2ByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/TZRIAp0JRHC50bIfgnbdq+J3Wc0PO4T2PV213ERq0halwwdPIbKbVJFZgWa4Rii5ZIJ8MdvgZM0j36OKiUn41yVBHs3m4cOsEdDi1bhZqwF9tDncH+7xqTgUui3qBUT/NP6zxLv8eFxjg8k/1YZk+I95a0sCqwJcI6iOR4FVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIcAPyg8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e63771eb0so65145001cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778694810; x=1779299610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxFjpCjJA3p0RNQiO7dqfCUMLP5o0eD7dzNq+c/0a0w=;
        b=VIcAPyg8SmosR7d/vqegtKR9UKxQ3PoGyOoFtJBgi5bk85zFDRVx02nlE0czOFAvfa
         7j8YvriVE3eSAKY6JkMxRad4Mu3Nb2xAAsyoBI+lkOKxu0BQgTWq89/RnrRlaR/LuXdx
         wrBWk1crGtquuFLDtMmUoeh+qTQ0k4tU/PmVY73bszP6ViADAclfyXt38JjJVIDrEh0Z
         gyZUE3Y2k8lwCXK+1JlHyygZeqDVaIZ+IICrOJuW5WafA1FtfWD0mAtsZGfM5WLgWKyD
         I0soExJtnfZp4vVUrgMJ7dHKqwEscwtrBqgN+aaJYxjj82DgL4hAAkSukyNLmQuRqgYl
         ulEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694810; x=1779299610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxFjpCjJA3p0RNQiO7dqfCUMLP5o0eD7dzNq+c/0a0w=;
        b=rArIvbKZjg6ha1dugeVQTPHKPLCS7pih3JvHIt2Abr8uXd2WGgerFyrTbxpnGvryBx
         Ffwuqq9tI7SrTqHvFJqvAfZnd2FdMGrvIGVPCNONNOBhKGi+SyISkjHW5O5yFEMiy8vV
         vdDXAcPmnEpqv9W/QAcjqvelBiwm1XT4rpqCUtd0qiF9qpIx+2HXt7SLy8uTk/GOFkyD
         wRZl2R1uWxXC7rrp68gua17G/pdxIYar0rEFYjBc29yf/ULqnEm2ls7skoxWNruGhU9w
         AzKG+4bCfMyGog4CaNxViFZBQ/Q3jOTSXPwQbDmRdcZ+d3i5SX7KltIIegrx2rfrQK1v
         jQYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Vf1afdxeWC8U6QA+8lXDdKOCnhLHFCuSRI/LYZLAKcn9ydBOtPMHVMl/goCeRaUgtKhmRsc+O2oMu@vger.kernel.org
X-Gm-Message-State: AOJu0YyRq/7w/mmVGS7m7An2N2DtimaIowzQ63+xgnG9bh5+fXLbAWYF
	K7TAIG+yYuVIEB3jBKUKGP6xusviebUkvQfrZaOypwlFwHbA4cHJIp+b8ksacUpl
X-Gm-Gg: Acq92OHMq+FkDqI9sfaal8buHN4y82iFV3v687D7VDTU+/E3G7gB07oJ0rcmn9A2AnS
	cxWhgAtX7aW966/uJAeURTIeHSeiSqyESgDwNrIxu2bOS1jTnG77zI+oWoi97y3N3nAJPpbwpY7
	22eudUQsBj3cIBgPjGRrMGEOKh72hoqOyqKZYMIV/ueeciLRrqH+9AeY7AlKHlo3F2hfDkkgAy4
	B+hDPfDGxZXQCskgWZolbJ6Mwvfe68DPJS9RHXS5Qjnps3rRgykbvqkmv97HkGJ01qP3DGYFmAc
	tEU5oIR/PMjop2tWiAmDkSLoT5m+datZPSYwTsFtQwgdvAzA9zKfAtknn6KMKhZQmfDRF3T1OCQ
	fHbE8lgFg/uVaNfiq9ptohFuyDWpOfaYYB1JOgiH8H+oRf4Pvmi3aBa7QX7KzSQoGM+ufShgshK
	H/h3fF9JCr5+RsoVTwNhIk6PACe07gsZoj0SydBjwjELcyOdgwugmJVLOeqr0TUY4T7MPQQoS8M
	jJ2ToYvsateJIVo4zB0IQjr+7o5EVInilDYDBWn9aM=
X-Received: by 2002:a05:622a:2611:b0:50f:de06:45e2 with SMTP id d75a77b69052e-5162fefff50mr53939611cf.31.1778694810400;
        Wed, 13 May 2026 10:53:30 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bf6720asm2036946d6.39.2026.05.13.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:53:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] RDMA/siw: add KUnit tests for MPA receive parsing
Date: Wed, 13 May 2026 13:53:25 -0400
Message-ID: <20260513175325.2042630-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513175325.2042630-1-michael.bommarito@gmail.com>
References: <20260513175325.2042630-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DF5E53863A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20599-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a KUnit suite (CONFIG_SIW_MPA_RX_KUNIT_TEST) that exercises the
real siw_tcp_rx_data() path with three cases covering the MPA length
validation added in the previous patch:

  - siw_mpa_write_underflow_rejected
      Constructs an sk_buff carrying a tagged RDMA WRITE FPDU whose
      mpa_len is one below iwarp_pktinfo[opcode].hdr_len -
      MPA_HDR_SIZE.  Registers a REMOTE_WRITE MR in mem_xa so the
      WRITE path would otherwise reach siw_proc_write(), and calls
      siw_tcp_rx_data() directly.  Asserts the FPDU is rejected with
      TERM(LLP/MPA/FPDU_START) and rx_suspend = 1.

  - siw_mpa_write_minimum_valid_accepted
      Regression control with mpa_len = hdr_len - MPA_HDR_SIZE (the
      smallest legal value, i.e. a zero-length WRITE).  Asserts the
      new check does not fire: no terminate, rx_stream not
      suspended.

  - siw_mpa_write_underflow_rejected_live_socket
      Opens a loopback AF_INET socketpair via sock_create_kern(),
      attaches a struct siw_cep as sk_user_data so sk_to_qp()
      resolves to the test QP, and installs siw_qp_llp_data_ready as
      sk_data_ready on the victim socket.  Writes the malformed FPDU
      via kernel_sendmsg from the attacker side.  The kernel TCP
      stack delivers, sk_data_ready fires in softirq, and
      tcp_read_sock dispatches to siw_tcp_rx_data the same way a
      remote peer would.  Asserts the same terminate state as the
      first case.

The third case is the design driver: it confirms the bug-fix
codepath fires from a real softirq RX entry, not just a synthetic
direct call.  On a stock siw tree the same harness reproduces the
KASAN slab-out-of-bounds / use-after-free in skb_copy_bits.

Bringing siw's loopback netdev up (case 3 binds 127.0.0.1) is done
inline via dev_change_flags() under rtnl_lock since the KUnit
environment does not run init scripts.

Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/infiniband/sw/siw/Kconfig            |  18 +
 drivers/infiniband/sw/siw/Makefile           |   2 +
 drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c | 349 +++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index 186f182b80e7..b137f5920271 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -18,3 +18,21 @@ config RDMA_SIW
 	space verbs API, libibverbs. To implement RDMA over
 	TCP/IP, the driver further interfaces with the Linux
 	in-kernel TCP socket layer.
+
+config SIW_MPA_RX_KUNIT_TEST
+	bool "KUnit tests for Soft-iWARP MPA receive parsing" if !KUNIT_ALL_TESTS
+	depends on KUNIT && RDMA_SIW
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit regression tests for the Soft-iWARP MPA receive
+	  state machine. The tests cover the MPA length consistency
+	  check in siw_get_hdr(): malformed FPDUs whose mpa_len is
+	  below the opcode's fixed DDP/RDMAP header must be rejected
+	  with TERM(LLP/MPA/FPDU_START); the minimum-valid mpa_len
+	  (zero-length WRITE) must still be accepted. One case drives
+	  the real kernel TCP receive path via a loopback socketpair
+	  so the same softirq sk_data_ready -> tcp_read_sock ->
+	  siw_tcp_rx_data chain a remote peer would exercise is
+	  covered.
+
+	  If unsure, say N.
diff --git a/drivers/infiniband/sw/siw/Makefile b/drivers/infiniband/sw/siw/Makefile
index f5f7e3867889..09d4c90d8758 100644
--- a/drivers/infiniband/sw/siw/Makefile
+++ b/drivers/infiniband/sw/siw/Makefile
@@ -9,3 +9,5 @@ siw-y := \
 	siw_qp_tx.o \
 	siw_qp_rx.o \
 	siw_verbs.o
+
+siw-$(CONFIG_SIW_MPA_RX_KUNIT_TEST) += siw_mpa_rx_kunit.o
diff --git a/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c b/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c
new file mode 100644
index 000000000000..204b3213b840
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_mpa_rx_kunit.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit harness for siw MPA receive-state length validation.
+ *
+ * Internal to the SIW_MPA_LEN_UNDERFLOW_RX_COPY disclosure validation tree.
+ * Not part of the upstream patch.
+ *
+ *   case 1: short mpa_len triggers the new siw_get_hdr() check via direct
+ *           siw_tcp_rx_data() call with a constructed sk_buff
+ *           - expects: TERM(LLP/MPA/FPDU_START), rx_suspend=1
+ *           - under stock siw: KASAN slab-out-of-bounds in skb_copy_bits()
+ *           - under patched siw: no splat, terminate state set
+ *
+ *   case 2: minimum-valid mpa_len control (constructed sk_buff)
+ *           - mpa_len = hdr_len - MPA_HDR_SIZE  ->  fpdu_part_rem = 0
+ *             so siw_proc_write() takes the zero-length WRITE short path
+ *             and returns 0 without calling skb_copy_bits().
+ *           - expects: no TERM, state machine progressed normally
+ *
+ *   case 3: real loopback TCP socketpair (the "live two-node" analog)
+ *           - opens AF_INET TCP sockets in-kernel via sock_create_kern()
+ *           - binds/listens on 127.0.0.1:0, connects, accepts
+ *           - installs siw_qp_llp_data_ready on the victim socket and
+ *             attaches a struct siw_cep so sk_to_qp() resolves to our qp
+ *           - writes the malformed FPDU bytes via kernel_sendmsg on the
+ *             attacker socket
+ *           - the kernel TCP stack delivers, sk_data_ready fires, and
+ *             siw_qp_llp_data_ready -> tcp_read_sock -> siw_tcp_rx_data
+ *             runs in the normal kernel receive path
+ *           - expects: TERM(LLP/MPA/FPDU_START) on the qp
+ */
+
+#include <kunit/test.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <linux/wait.h>
+#include <linux/xarray.h>
+#include <net/sock.h>
+#include <net/tcp.h>
+#include <rdma/ib_verbs.h>
+
+#include "siw.h"
+#include "siw_cm.h"
+#include "siw_mem.h"
+
+static void siw_kunit_kfree_skb(void *skb)
+{
+	kfree_skb(skb);
+}
+
+struct siw_mpa_rx_ctx {
+	struct siw_device *sdev;
+	struct siw_qp *qp;
+	struct siw_mem *mem;
+	void *target;
+	u32 stag;
+};
+
+static void siw_mpa_rx_setup(struct kunit *test, struct siw_mpa_rx_ctx *c)
+{
+	void *xa_ret;
+
+	c->stag = 0x00000100;
+
+	c->sdev = kunit_kzalloc(test, sizeof(*c->sdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->sdev);
+	xa_init_flags(&c->sdev->mem_xa, XA_FLAGS_ALLOC1);
+
+	c->qp = kunit_kzalloc(test, sizeof(*c->qp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->qp);
+	c->qp->sdev = c->sdev;
+	c->qp->pd = kunit_kzalloc(test, sizeof(*c->qp->pd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->qp->pd);
+	c->qp->rx_stream.state = SIW_GET_HDR;
+
+	c->target = kunit_kzalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->target);
+
+	c->mem = kunit_kzalloc(test, sizeof(*c->mem), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c->mem);
+	kref_init(&c->mem->ref);
+	c->mem->sdev = c->sdev;
+	c->mem->stag = c->stag;
+	c->mem->stag_valid = 1;
+	c->mem->va = (u64)(uintptr_t)c->target;
+	c->mem->len = 64;
+	c->mem->pd = c->qp->pd;
+	c->mem->perms = IB_ACCESS_REMOTE_WRITE;
+
+	xa_ret = xa_store(&c->sdev->mem_xa, c->stag >> 8, c->mem, GFP_KERNEL);
+	KUNIT_ASSERT_FALSE(test, xa_is_err(xa_ret));
+}
+
+static void siw_mpa_rx_run(struct kunit *test, struct siw_mpa_rx_ctx *c,
+			   u16 mpa_len_val)
+{
+	struct iwarp_rdma_write write = { };
+	struct sk_buff *skb;
+	read_descriptor_t rd_desc = { };
+	u8 payload[sizeof(write) + 1];
+
+	write.ctrl.mpa_len = cpu_to_be16(mpa_len_val);
+	write.ctrl.ddp_rdmap_ctrl = DDP_FLAG_TAGGED | DDP_FLAG_LAST |
+		cpu_to_be16(DDP_VERSION << 8) |
+		cpu_to_be16(RDMAP_VERSION << 6) |
+		cpu_to_be16(RDMAP_RDMA_WRITE);
+	write.sink_stag = cpu_to_be32(c->stag);
+	write.sink_to = cpu_to_be64((u64)(uintptr_t)c->target);
+
+	memcpy(payload, &write, sizeof(write));
+	payload[sizeof(write)] = 0x41;
+
+	skb = alloc_skb(sizeof(payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	skb_put_data(skb, payload, sizeof(payload));
+	kunit_add_action_or_reset(test, siw_kunit_kfree_skb, skb);
+
+	rd_desc.arg.data = c->qp;
+	rd_desc.count = sizeof(payload);
+
+	siw_tcp_rx_data(&rd_desc, skb, 0, sizeof(payload));
+}
+
+static void siw_mpa_write_underflow_rejected(struct kunit *test)
+{
+	struct siw_mpa_rx_ctx c;
+
+	siw_mpa_rx_setup(test, &c);
+
+	/* mpa_len one byte short of the WRITE hdr_len - MPA_HDR_SIZE floor. */
+	siw_mpa_rx_run(test, &c,
+		       sizeof(struct iwarp_rdma_write) - MPA_HDR_SIZE - 1);
+
+	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.valid, 1);
+	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.layer,
+			(int)TERM_ERROR_LAYER_LLP);
+	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.etype,
+			(int)LLP_ETYPE_MPA);
+	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.ecode,
+			(int)LLP_ECODE_FPDU_START);
+	KUNIT_EXPECT_EQ(test, (int)c.qp->rx_stream.rx_suspend, 1);
+}
+
+static void siw_mpa_write_minimum_valid_accepted(struct kunit *test)
+{
+	struct siw_mpa_rx_ctx c;
+
+	siw_mpa_rx_setup(test, &c);
+
+	/*
+	 * mpa_len == hdr_len - MPA_HDR_SIZE is the smallest legal value;
+	 * it yields fpdu_part_rem = 0, i.e. a zero-length WRITE. The new
+	 * length check in siw_get_hdr() must accept this.
+	 */
+	siw_mpa_rx_run(test, &c,
+		       sizeof(struct iwarp_rdma_write) - MPA_HDR_SIZE);
+
+	KUNIT_EXPECT_EQ(test, (int)c.qp->term_info.valid, 0);
+	KUNIT_EXPECT_EQ(test, (int)c.qp->rx_stream.rx_suspend, 0);
+}
+
+static int siw_mpa_rx_bring_up_lo(struct kunit *test)
+{
+	struct net_device *lo;
+	int rv;
+
+	rtnl_lock();
+	lo = __dev_get_by_name(&init_net, "lo");
+	KUNIT_ASSERT_NOT_NULL(test, lo);
+	if (!(lo->flags & IFF_UP))
+		rv = dev_change_flags(lo, lo->flags | IFF_UP, NULL);
+	else
+		rv = 0;
+	rtnl_unlock();
+	KUNIT_ASSERT_EQ(test, rv, 0);
+	return 0;
+}
+
+static int siw_mpa_rx_make_pair(struct kunit *test, struct socket **listen,
+				struct socket **server, struct socket **client)
+{
+	struct sockaddr_in addr = { .sin_family = AF_INET, };
+	struct sockaddr_in bound = { };
+	struct socket *l = NULL, *s = NULL, *c = NULL;
+	int rv;
+
+	siw_mpa_rx_bring_up_lo(test);
+
+	rv = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_TCP, &l);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = 0;
+	rv = kernel_bind(l, (struct sockaddr_unsized *)&addr, sizeof(addr));
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	rv = l->ops->getname(l, (struct sockaddr *)&bound, 0);
+	KUNIT_ASSERT_GT(test, rv, 0);
+
+	rv = kernel_listen(l, 1);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	rv = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_TCP, &c);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	rv = kernel_connect(c, (struct sockaddr_unsized *)&bound,
+			    sizeof(bound), 0);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	rv = kernel_accept(l, &s, 0);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	*listen = l;
+	*server = s;
+	*client = c;
+	return 0;
+}
+
+static void siw_mpa_write_underflow_rejected_live_socket(struct kunit *test)
+{
+	struct siw_device *sdev;
+	struct siw_qp *qp;
+	struct siw_cep *cep;
+	struct siw_mem *mem;
+	struct socket *listen_sock = NULL, *server_sock = NULL, *client_sock = NULL;
+	struct iwarp_rdma_write write = { };
+	struct kvec iov;
+	struct msghdr msg = { };
+	void *xa_ret, *target;
+	u8 payload[sizeof(write) + 1];
+	u32 stag = 0x00000100;
+	int rv, i;
+
+	sdev = kunit_kzalloc(test, sizeof(*sdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sdev);
+	xa_init_flags(&sdev->mem_xa, XA_FLAGS_ALLOC1);
+
+	qp = kunit_kzalloc(test, sizeof(*qp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, qp);
+	qp->sdev = sdev;
+	qp->pd = kunit_kzalloc(test, sizeof(*qp->pd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, qp->pd);
+	qp->rx_stream.state = SIW_GET_HDR;
+	init_rwsem(&qp->state_lock);
+	qp->attrs.state = SIW_QP_STATE_RTS;
+	qp->cep = NULL;
+
+	/* Register a valid REMOTE_WRITE memory object. On unpatched siw
+	 * this is what lets the negative-length copy reach skb_copy_bits;
+	 * without an MR the STag lookup in siw_proc_write() returns NULL
+	 * and the WRITE is terminated before the underflow primitive fires.
+	 * With this patch in place, the new siw_get_hdr() check rejects
+	 * the FPDU BEFORE STag lookup, so the MR is unused. We keep it in
+	 * the test so unpatched-kernel reruns also exercise the full path.
+	 */
+	target = kunit_kzalloc(test, 64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, target);
+	mem = kunit_kzalloc(test, sizeof(*mem), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+	kref_init(&mem->ref);
+	mem->sdev = sdev;
+	mem->stag = stag;
+	mem->stag_valid = 1;
+	mem->va = (u64)(uintptr_t)target;
+	mem->len = 64;
+	mem->pd = qp->pd;
+	mem->perms = IB_ACCESS_REMOTE_WRITE;
+	xa_ret = xa_store(&sdev->mem_xa, stag >> 8, mem, GFP_KERNEL);
+	KUNIT_ASSERT_FALSE(test, xa_is_err(xa_ret));
+
+	/* siw_qp_llp_data_ready dereferences sk_user_data as siw_cep. */
+	cep = kunit_kzalloc(test, sizeof(*cep), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cep);
+	cep->qp = qp;
+	spin_lock_init(&cep->lock);
+	kref_init(&cep->ref);
+
+	rv = siw_mpa_rx_make_pair(test, &listen_sock, &server_sock, &client_sock);
+	KUNIT_ASSERT_EQ(test, rv, 0);
+
+	write_lock_bh(&server_sock->sk->sk_callback_lock);
+	server_sock->sk->sk_user_data = cep;
+	server_sock->sk->sk_data_ready = siw_qp_llp_data_ready;
+	qp->attrs.sk = server_sock;
+	write_unlock_bh(&server_sock->sk->sk_callback_lock);
+
+	write.ctrl.mpa_len =
+		cpu_to_be16(sizeof(write) - MPA_HDR_SIZE - 1);
+	write.ctrl.ddp_rdmap_ctrl = DDP_FLAG_TAGGED | DDP_FLAG_LAST |
+		cpu_to_be16(DDP_VERSION << 8) |
+		cpu_to_be16(RDMAP_VERSION << 6) |
+		cpu_to_be16(RDMAP_RDMA_WRITE);
+	write.sink_stag = cpu_to_be32(stag);
+	write.sink_to = cpu_to_be64((u64)(uintptr_t)target);
+
+	memcpy(payload, &write, sizeof(write));
+	payload[sizeof(write)] = 0x41;
+
+	iov.iov_base = payload;
+	iov.iov_len = sizeof(payload);
+	rv = kernel_sendmsg(client_sock, &msg, &iov, 1, sizeof(payload));
+	KUNIT_ASSERT_EQ(test, rv, (int)sizeof(payload));
+
+	/* Wait for TCP to deliver bytes and sk_data_ready to fire. */
+	for (i = 0; i < 200; i++) {
+		if (qp->term_info.valid)
+			break;
+		msleep(20);
+	}
+
+	KUNIT_EXPECT_EQ(test, (int)qp->term_info.valid, 1);
+	KUNIT_EXPECT_EQ(test, (int)qp->term_info.layer,
+			(int)TERM_ERROR_LAYER_LLP);
+	KUNIT_EXPECT_EQ(test, (int)qp->term_info.etype,
+			(int)LLP_ETYPE_MPA);
+	KUNIT_EXPECT_EQ(test, (int)qp->term_info.ecode,
+			(int)LLP_ECODE_FPDU_START);
+	KUNIT_EXPECT_EQ(test, (int)qp->rx_stream.rx_suspend, 1);
+
+	/* Detach our handler before tearing down sockets so the TCP stack
+	 * cannot call into freed kunit memory after the test.
+	 */
+	write_lock_bh(&server_sock->sk->sk_callback_lock);
+	server_sock->sk->sk_user_data = NULL;
+	server_sock->sk->sk_data_ready = sock_def_readable;
+	write_unlock_bh(&server_sock->sk->sk_callback_lock);
+
+	sock_release(client_sock);
+	sock_release(server_sock);
+	sock_release(listen_sock);
+}
+
+static struct kunit_case siw_mpa_rx_cases[] = {
+	KUNIT_CASE(siw_mpa_write_underflow_rejected),
+	KUNIT_CASE(siw_mpa_write_minimum_valid_accepted),
+	KUNIT_CASE(siw_mpa_write_underflow_rejected_live_socket),
+	{ }
+};
+
+static struct kunit_suite siw_mpa_rx_suite = {
+	.name = "siw_mpa_rx",
+	.test_cases = siw_mpa_rx_cases,
+};
+
+kunit_test_suite(siw_mpa_rx_suite);
-- 
2.53.0


