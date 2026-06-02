Return-Path: <linux-rdma+bounces-21639-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y0fcHpozH2qeigAAu9opvQ
	(envelope-from <linux-rdma+bounces-21639-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:48:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29585631855
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cl90eKqR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21639-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21639-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5CB8306D58A
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17022279329;
	Tue,  2 Jun 2026 19:46:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3421A434
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 19:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429609; cv=none; b=Pe724FQw9HK6waudVx+SMBOXzJPIJpt/864HcFycJgsKOEhA4KID83wHM6DiFh0QboBXuPbc8xOASHAbyrAsn6Poftf8vA/239TT8fFLpYDVQL+0Bzy6yGtULUnXNJLA6JEY8OFr82MMHdoE7HnGgu5JAn4etsoGDQMwuG7aC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429609; c=relaxed/simple;
	bh=D6UZDnyjlzb1tjCGRTyvdU0cKpyDRuOWJ7z+8lBC1rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9c3B9XDWPHqmYb3FkEZm3JlHkUPWxPYa8FbQEpn0j8UzOaPBQis79lpxsswBBGG+07dZWgfA7Qt5p8Y4pgddnOy2wjq8nZJIfI3xBTJShpaJ2Noxqab9+vudehWqKzw21xsSUKdn2NUGgBGh5sVY2xfrzb2XrBMwXQ07a8vLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl90eKqR; arc=none smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176d4c14f5so8299861cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429608; x=1781034408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZT0cZ8sVMgpqU3LQqdB6NvntMdy3q7IleXIHtXo8Wk=;
        b=Cl90eKqRJ2hhwSo6IFVI9UE3drHZjG5skEklbrMBSCsFqdjsHX6OSvdZWBST7ck2DQ
         srSkFJi/POfKBIyYXjWm6QwvxN0F+VZTOn4m3EVH9WMyEOJioIunXpSMDadqf0503Ecm
         Qp1zlFyy9fLY3mnZlq3XTojUZVmEmd1KE4DxKfWrouDaj6v2Mz4cXYkuwKww6VOqIZJ/
         905djg9WeD7GbvrQ8zO4i4/vEED1d24Fd/3IV40kp7mr9T3W9m1ZT4Ki+tenYT/QscOO
         Uwf9gOsSbfJkIxWsLV42WsG6rzw/nnRD7T7VvzLHbiHjS9dS5TcmoWmWDzDMVN8Mydry
         n30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429608; x=1781034408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZT0cZ8sVMgpqU3LQqdB6NvntMdy3q7IleXIHtXo8Wk=;
        b=GLr4iE0k24Oam6g1P0hTeS9oESwjl4SngxPKjfZqvAjoMVDfJvs0pEJkruR/TnxzEZ
         uoN24guvg3mNJmaO10PCn5whwHgx1hmOfRA59qJ5RmyZoHEgby8IvymAMzZ8MClcbPHM
         C2o/zcZJ3HkrzjDr5kWgcG7ySwBCb/vsyhG/yfSWxGzZXsjb5F8z3XdekPyXOjQoFfmF
         50w7dfba9Ni0F5uAAy1sdmXuTjHAAKNe4yn5cwghT6xqGnZcLHO6PsAX9+PYPXcPyz9y
         rIyykX3ctCmiDyDJ6ivF1mijudFIEdn+ZRNnVlRO87h6lzRVSPdXLwnvBN7x4rTr/bCx
         TEzA==
X-Gm-Message-State: AOJu0YyFfmUXGaOiZ1uI8tUHHUgTpBRz8YYWrFoxKmp4r4nQPvbJklmm
	V/0S4MPjOiPUF58GctO3clyYFgAK1NlO2F9XgOKReqq9V/XVoNGFgVgJ
X-Gm-Gg: Acq92OECkk4A+YqOB8QgAA3Kq0wtdkJeEwtJklx3r4UcrAeDaVYIts6Nr5yVkVdjrTl
	lQJptd8LsAhOfEwEpbzsuN7M7Nr1dKKJ774/qj1u00RbhgkrbdgBXqEPnPSZ9ZPZyP91k0x/9IY
	MOBcZZAs0V4rrVQHO6JQ3Sj82dV+XiCm0yW8y6H2/wPkNea4n28M0bCSQD+lckOPoqFrQ5GU7uk
	7rX5S0bhE0L7kDIPrAUPumbzQdrNZKsHzUEqJx4eKwB5zTBUsl1/Wt1c/tmePcZzsI63aaGJJ+N
	mzjwy2tlXRy+mrhXR9M3QO9wU7SIRbPUdKZB293L5ILeWe/apaU3mgYLTITgqfCNlzYxkEXGXOD
	A8vtaWvEjW4/TuB6UYimdM0QSTkwk1l8ziTWMozr3o6Q4qAkQ1bjPyDG4gEy9tRB/XmpLijoKRc
	oClfMJaLuuSP0JtbpHE2W+i9DVQdLOUIznt3ty/4GxdNOdK0j+q8E2guxfJCPL8LU3KxxE0dATD
	y63OUJrImorexZ6A3qXYiddMQypn30=
X-Received: by 2002:a05:622a:1304:b0:517:64b8:5a1f with SMTP id d75a77b69052e-517786efdc8mr7448531cf.35.1780429607484;
        Tue, 02 Jun 2026 12:46:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775d8100fsm7136801cf.14.2026.06.02.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:46:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] IB/isert: reject login PDUs shorter than ISER_HEADERS_LEN
Date: Tue,  2 Jun 2026 15:46:42 -0400
Message-ID: <20260602194642.2273217-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21639-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sagi@grimberg.me,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29585631855

In drivers/infiniband/ulp/isert/ib_isert.c, isert_login_recv_done()
computes the login request payload length as wc->byte_len minus
ISER_HEADERS_LEN with no lower bound, and login_req_len is a signed int.
A remote iSER initiator can post a login Send work request carrying
fewer than ISER_HEADERS_LEN (76) bytes, so the subtraction underflows
and login_req_len becomes negative.

isert_rx_login_req() then reads that negative length back into a signed
int, takes size = min(rx_buflen, MAX_KEY_VALUE_PAIRS), and because the
min() is signed it keeps the negative value; the value is then passed as
the memcpy() length and sign-extended to a multi-gigabyte size_t. The
copy into the 8192-byte login->req_buf runs far out of bounds and
faults, crashing the target node. The login phase precedes iSCSI
authentication, so no credentials are required to reach this path.

Reject any login PDU shorter than ISER_HEADERS_LEN before the
subtraction, mirroring the existing early return on a failed work
completion, so login_req_len can never go negative. The upper bound was
already safe: a posted login buffer cannot deliver more than
ISER_RX_PAYLOAD_SIZE, so the difference stays at or below
MAX_KEY_VALUE_PAIRS and the existing min() clamps it; only the missing
lower bound needs to be added.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Impact: a remote, pre-auth iSER initiator can crash an iSER-enabled LIO
target by sending a single login PDU shorter than ISER_HEADERS_LEN,
underflowing login_req_len to a negative value that drives an
out-of-bounds memcpy.

Analysis
========

Tree: mainline a1f173eb51db (7.1-rc4 line), x86_64.

ISER_HEADERS_LEN is sizeof(struct iser_ctrl) (28, __packed) plus
sizeof(struct iscsi_hdr) (48) = 76. login_req_len is a signed int
(ib_isert.h). For a received login Send with wc->byte_len in 1..75,
isert_login_recv_done() stores wc->byte_len - ISER_HEADERS_LEN, which
underflows to a negative int. isert_rx_login_req() reads it back as
int rx_buflen, computes size = min(rx_buflen, MAX_KEY_VALUE_PAIRS)
(MAX_KEY_VALUE_PAIRS is 8192; the min is signed so size stays
negative), and calls memcpy(login->req_buf, isert_get_data(rx_desc),
size). login->req_buf is an 8192-byte kzalloc in the iSCSI target login
path. The negative size sign-extends to a multi-gigabyte size_t at
memcpy(), so the copy runs out of bounds of req_buf and faults.

Conditions: an RDMA transport plus an iSER-enabled LIO target. iSER is
enabled per portal (targetcli enable_iser); a plain iSCSI-over-TCP
target does not load this path. RoCEv2 and iWARP transports are
routable, so the initiator need not share the target's L2 segment;
RoCEv1 and native InfiniBand require an adjacent initiator. The
malformed login Send is accepted during the login phase, before iSCSI
authentication, so no credentials are required.

The upper bound is already safe: a posted login receive buffer cannot
deliver more than ISER_RX_PAYLOAD_SIZE, so wc->byte_len - 76 stays at
or below MAX_KEY_VALUE_PAIRS and the existing min() clamps it. Only the
missing lower bound is added here. The initiator-side iSER receive path
rejects short receives; the target login path had no equivalent floor.

With the patch, a login Send shorter than ISER_HEADERS_LEN is dropped
in isert_login_recv_done() (the new early return logs "login request
length N is too short") and login_req_len is left untouched, so the
downstream min()/memcpy() length stays within the 8192-byte buffer; a
well-formed login (wc->byte_len >= 76) is unaffected. The defect is
identified by static analysis of the cited code paths; the path can be
exercised by driving a short login Send at an rxe-backed iSER LIO
target under KASAN.

 drivers/infiniband/ulp/isert/ib_isert.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 348005e71891c..a849a420be421 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1383,6 +1383,12 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
 			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
+	if (unlikely(wc->byte_len < ISER_HEADERS_LEN)) {
+		isert_err("login request length %u is too short\n",
+			  wc->byte_len);
+		return;
+	}
+
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
 	if (isert_conn->conn) {
-- 
2.53.0


