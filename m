Return-Path: <linux-rdma+bounces-20524-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBp9NEqKA2pN7AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20524-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397F52901D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC4630872BA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608636F916;
	Tue, 12 May 2026 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmUPQdEe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238F3AD511
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616900; cv=none; b=LD4zWH1Vq1uBp3BRYSp6aV3UVk7QG/bKggy1Ag7ZVH8ch2TkwRGquihF2twmYfsIAwDRSxTVnEZXpRCgdA0Uq/n9qQl983BjlKQoKZm8W6jGnpppuz3zzIgHIvic5MCS/06mWlpDEUGUZ4VKh3o3ZdFUZWVwp+tOAtQPpJA2ZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616900; c=relaxed/simple;
	bh=evijYqI5MvA/bUAUn9wUlofA87BvntWhJzV7Ij9roZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OyEHRsa9kkutnKEndCXRSW5K81BF9KX+1pfXILsqH5Hi+O4KnLCRcnKaRrHp82dnC9YzB2gNBfK7nesPNhXP+I2Ps0gTY+ZgPsJD3FEb0dbTDaHfp8hGkf4vxyichpMHJ+I8M+YqLXdDa+IZGd4cslDyt9ANlbFwAON1veSD7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmUPQdEe; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47c7b282e21so2356079b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616896; x=1779221696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zo4wfCS7DovMthnNqpPeS7jpyUGWNT1RN2DCXg0Rsk=;
        b=XmUPQdEekxWNkxGKwxghg3/9/2n3PGH5xY5vQgctA+2jWQx30NKzMA8V/xc0gKZmjR
         FjBff1h9Efr3DsJNsYJCFunr0RU3qN04lmzNvVRsE/A3RYRUxkjVSJhHomXFzelIcczI
         oN98ROIlZNX5inP2oFHQq74fSdYA3RUz77QVKJ6gJz4lPBjoq9t21rYHZhxAMgNiVvUT
         EtIkd690HsE2/OOTTiIPPgSV0MNNS0nGdJbl+WvERZ1t/D7HLhM/Ziq9DENeLpfhXumY
         k1ibu5HeCAZG7oJN/x/e/4F1uA86g/hOLZbzkOnuIhTVTgKvPHIJ7+2qfR9nYQTIgwE2
         QI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616896; x=1779221696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zo4wfCS7DovMthnNqpPeS7jpyUGWNT1RN2DCXg0Rsk=;
        b=DAvQmov8mEAgvNixrTKG/TtNP4WBDDaUpWRV/WP6MOpgShiAMKvXk4Cw140NnDBOtL
         Px9VTexOCXLLD6Hp+iIOiPrc2uZo85r+1UW6HRVZIkxLvwMsljKeS0wyByXTwCxV7lat
         qqak+oi9aPEnOmM7SikLFgj6NcTzp76/YMuazm4G0QmtXEVCxSCvlcux7xtyJG52oUpk
         LaAMxGplib2Gqegi9doGzuee8jXWFlYTNlweUZzjWm0dpERgSc0jBCofGzmjxPVEIWi7
         gU4vkHopxxGYsYfT9LR7qJzb5QmWqqf0LwOYWY9sPx72LvcN4YEloH/GIBb87PEDuRes
         m4fQ==
X-Gm-Message-State: AOJu0YwV6G5cnsrVWvgWmCyC4CDlE0Jo8SEgGefqJzz8O82wR/TOSngk
	AevDFO0HtO4xasJjQd+dhkhzlr87tN5CHkz+tbao1hvFO7saR9U8Q7KPpDiRyJfz
X-Gm-Gg: Acq92OF//o8xw/Aqfz/hv5kVOMCQO1F1ClWap/Twvod0Ekj4vl6e6YX45dm53H//y5p
	sCkw7C2Dz5/dYEsRmgJbuN2T/tVHsSa/+63rsw5/+zhUZtRGd39k22YIFZPotfIMq0yoB614Ilm
	7983Xmpw+nZURB2IFg87KZqDa114TPkVX6ALDXTXdrCjuBj/kTmHtiw8br+01MPN/idBOhvaOB8
	AWlDNt+u5GqjSgy5Q+52qHd2ylbOE0AyGIue4/W+kJ4Ha1FtcVXig9hPzz/zE+5bWWl717+RK/2
	0M3qzCLX1pX59CLjWUa++hDWRVXqc6hsbjksGBlGoJ8z6zCHPZduGe8nPsPZXpqO+8xijA/5FYE
	wgJmEa67X1p8uJVD6u4Fc/ufkOwYAdbyqaWNKvIJoHw8rbqm+D57avQcw1WDuA3D/fnptyIHVF5
	2c7qxTOge9zs0881YWQn1ntSwXB8DCkaokoaQsu05pvN78MIOknSzqSwWG
X-Received: by 2002:a05:6808:238c:b0:467:bfa:bdb2 with SMTP id 5614622812f47-482b2bbe682mr401098b6e.25.1778616896285;
        Tue, 12 May 2026 13:14:56 -0700 (PDT)
Received: from localhost.localdomain ([2600:1014:b0b0:a3c6:a82b:c292:fd90:24d0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm22800623b6e.11.2026.05.12.13.14.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 13:14:55 -0700 (PDT)
From: Liibaan Egal <liibaegal@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH rdma-next 0/2] RDMA/rxe: add local implicit ODP MR support
Date: Tue, 12 May 2026 15:14:51 -0500
Message-Id: <20260512201453.21156-1-liibaegal@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4397F52901D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20524-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[liibaegal@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This RFC adds local-access implicit On-Demand Paging memory regions to
RXE (Soft-RoCE).

RXE already supports explicit ODP MRs. The implicit registration form
(addr == 0, length == U64_MAX, IB_ACCESS_ON_DEMAND) is recognized but
not implemented: the implicit branch in rxe_odp_mr_init_user() returns
-EINVAL through a placeholder block, and no path creates child umems
for SGE accesses on an implicit MR.

This series wires the implicit registration case through
ib_umem_odp_alloc_implicit() and routes the local SGE walker through
per-chunk child umems. The chunk size is fixed at 2 MiB
(RXE_ODP_CHILD_SHIFT = 21) and children are allocated lazily on first
access via ib_umem_odp_alloc_child(), stored in a per-MR xarray.

Patches
-------

  1/2 RDMA/rxe: add local implicit ODP MR support

      Adds rxe_odp_mr_init_implicit() (rejects remote access bits with
      -EOPNOTSUPP, allocates the parent umem). Adds rxe_odp_get_child()
      and the per-chunk loop in rxe_odp_mr_copy() and the prefetch
      path. Atomic, flush and atomic-write paths reject implicit MRs
      at the top because those helpers walk mr->umem->pfn_list
      directly which is empty for an implicit parent. rxe_mr_cleanup
      walks the child xarray and releases each child before the
      parent.

      This patch leaves IB_ODP_SUPPORT_IMPLICIT unadvertised, so
      rxe_odp_mr_init_user() still returns -EINVAL on the implicit
      form. No user-visible behavior change yet.

  2/2 RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access

      Flip the cap bit so userspace can probe support via
      ibv_query_device. Kept as its own patch so the policy question
      is separable from the implementation.

Question for reviewers
----------------------

Patch 2/2 advertises IB_ODP_SUPPORT_IMPLICIT for a local-access-only
operation matrix. Local SGE access on implicit MRs works; remote rkey
access, atomic, flush, and atomic-write on implicit MRs do not. Is
this an acceptable use of the capability bit, or should capability
exposure wait for a broader operation matrix? Splitting the cap flip
out is meant to keep that decision separable from the implementation.

Scope and limitations
---------------------

Out of scope in this series:

- Remote rkey access on implicit MRs. Rejected at registration time
  with -EOPNOTSUPP.
- Atomic, flush, atomic-write paths. These return -EOPNOTSUPP /
  RESPST_ERR_RKEY_VIOLATION on implicit MRs.
- Child reclaim. The xarray grows monotonically per MR; a child is
  not freed until MR destroy. Long-lived implicit MRs that touch a
  sparse address space accumulate children. A reclaim mechanism is
  the natural follow-up.

Tested
------

Verified on rdma/for-next at commit 7fd2df204f34 (Linux 7.1-rc2),
arm64, Soft-RoCE over loopback:

- Registration accept/reject matrix (5 cases).
- Single-chunk 64 KiB RDMA WRITE through an implicit lkey.
- Two-chunk multi-range test: two 1 MiB WRITEs from buffers in
  different 2 MiB chunks of one implicit MR.
- Cross-chunk single-SGE test: one 128 KiB WRITE whose SGE spans a
  2 MiB chunk boundary.

Each patch builds cleanly standalone (M=drivers/infiniband/sw/rxe).

Registration latency was measured for 4 KiB to 1 GiB across explicit
and implicit forms. Explicit grows with size and fails ENOMEM at 1 GiB
on a 6 GiB host. Implicit median latency stays in the low microseconds
across all sizes; peak RSS during an implicit registration stays at
the baseline, while explicit RSS climbs with the registered size. The
benchmark measures registration-time work only; it does not
characterize first-touch or steady-state data path cost. Tests, bench
and raw numbers are in the companion repository:
https://github.com/Liibon/rxe-implicit-odp

scripts/checkpatch.pl --strict on each patch: 0 errors, 0 warnings,
0 checks.

---

Liibaan Egal (2):
  RDMA/rxe: add local implicit ODP MR support
  RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access

 drivers/infiniband/sw/rxe/rxe.c       |   7 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  19 +++
 drivers/infiniband/sw/rxe/rxe_odp.c   | 288 +++++++++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  18 +++
 4 files changed, 275 insertions(+), 57 deletions(-)

Liibaan Egal (2):
  RDMA/rxe: add local implicit ODP MR support
  RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access

 drivers/infiniband/sw/rxe/rxe.c       |   7 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  19 ++
 drivers/infiniband/sw/rxe/rxe_odp.c   | 288 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  18 ++
 4 files changed, 275 insertions(+), 57 deletions(-)

-- 
2.43.0


