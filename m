Return-Path: <linux-rdma+bounces-21380-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPEBWolF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21380-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08E5E82E1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E19A43022F74
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084C44B687;
	Wed, 27 May 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="MNh6MFp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06841322F
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901795; cv=none; b=nKSDwoA86KVb24tMEXGCRrnR7lbl44PH0h6JgNs8ocChcbi0/J9J2jpBPjhNyhUqz/GoaSjujCxGt8jKH2gF+7K4Zzeh39OSqjF6Zj/jRpxdohyYHEXoTD9OuUQzO9T+wQURFDSlK6YtbtFr0ahtiAo2BejvZvHDmTd7tUT9q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901795; c=relaxed/simple;
	bh=BgzR5WyB4TNJ/+tjNLjunmBBPvmp//qVwgRjvMzwGa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3h2RUJm24P+JnL7zJ/eSx1SkYrnsgIuoPL6xb/Dn6+1P/oWYYz0OxkecnAkIw1KM8RxDdsWgou5sSZ+Il4WXWu/UAuu6+c6TX/ZqFVo1BW5AcKef4eP6A0G79T3NLLac5p5SpJWhgdHhWXee5tFnsvKZ5dIc49FCdQJXwaYLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=MNh6MFp8; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so71369015e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901792; x=1780506592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5JQqp8tY/Rcl+IxUZwBHGACmw0TlOY9plUDglmqwcQ=;
        b=MNh6MFp83kHKIQRs5djsC7pKD8gjpQe1BknF09tsWgjRAqW2kLWwl3SX8wclvaTmom
         h0AR9603n6M82DlgJZEtLHE82mW9MP+K8W2I0xNs0I4HbXvLtt5SRvdDXiJCawK9E4kQ
         Udm8VOq8fhh1yxuIc1eVydS52+3l3tzxSAL+slwQ3dubjbvOdsCE9gQDv6toGjZPTP81
         O7+q/3uBhJkJDTF4ym03cxZeMFEQMmo8nwm0g/+j8lupxEVK9AcCTKo1/5WmoZDivRC0
         SfmTR+8anIi5fgrO4jmVh+imKQel7okCH29kWNh0iNWvBfwJtbOZerIpVCoGIDGL3UVn
         2AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901792; x=1780506592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5JQqp8tY/Rcl+IxUZwBHGACmw0TlOY9plUDglmqwcQ=;
        b=CbmFy8Oxvs3bpKgHYbMZVpzYI6vraCSFjTNVSIuVo7oQnKdtoD7GlYNtDrN5Gwiiab
         T+XYo/Kr3k0tcPkI3cn8A1vNTFPdGV/E5fk7g6jYXdsiiHItk1gWaqJcm4G5sOVN0qbs
         l2bbfArCrB97hIfZBOzGJ8DvkLJlEmiLTBNlfjSrPealPr7HQWc8ajlJnzsb9/hL8HHA
         WgIxnPN1w6vcfJ86ixpd0BJErbSlF1Eyp60aS6Mxf5zWD+ShqRaSBcfLAJgOk79/Xe8H
         o0mfIXC/+9Y70WXhovQC0lz3U5K7A3g6x76nNU97z1nNMUHbHmNY9ynhMsHtFTpD5V0L
         Zqxw==
X-Gm-Message-State: AOJu0Yy5ospwlZdJKErc6Sxha1XxGTXo/u//s70+t5hQ4QFyx59hyO9a
	Mg+nBara0eLtLSPWkyOhNEDJOX9VOyw2vAOiSj9Ly0UB4FaVaXVL/+6Y5HMtsuvfR8/j47DxfJx
	9sRMMFb6h7eoV
X-Gm-Gg: Acq92OHXkOXSgHCbTFjFnOw2fj04RITgUe49HKQAT2iu3aaoz8SPN0W9bXER+RPJcpk
	Abhlyq/OpPWjpceN7bUKit7VP2RCFJ7/m5WVp9jb0iFHInVYjpIafUBFCQQ79f/M3is4bfOWIHf
	73kGZCxZLGT5aHzFjwRY4jcd46fHXrdxcI5tc3+QNJFNUlJcLR7Sz6To7RI4gV6MrBwF5k+ZSEY
	7JrzD+ZGSjyxNTrAJIYr77IF9HbuijuJlGSu8XtxbPwa+D+58ZkjnCF9YsrhpFHCJFpFoQyl2WX
	q5IJOBF+RyCSZmvnHs7wAGfr0mLUihxCtmUod25WSs7g5Rry491AWIELhab47g24mcg/HbkMQYd
	d+m6qP+TOFc4JBc4TL7QXepr0tDJrVNaABrm9DJpn+t4hA1MTc9hvvleUmBJIhPJ4Ys5mGe64c1
	5+0G+kwcBmqxMLlYnNCmOB4l/cP/Q30dY=
X-Received: by 2002:a05:600c:a402:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-490425ad10cmr326821025e9.14.1779901791565;
        Wed, 27 May 2026 10:09:51 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454db285sm380241795e9.5.2026.05.27.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:09:51 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Wed, 27 May 2026 19:09:33 +0200
Message-ID: <20260527170948.2017439-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21380-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 7F08E5E82E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

This patchset introduces a generic buffer descriptor infrastructure
for passing memory buffers (dma-buf or user VA) to uverbs commands,
and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
bnxt_re and mlx4 drivers.

Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
carry one buffer descriptor each. Each descriptor specifies a buffer
type, covering both VA and dma-buf. A consumption check ensures
userspace and driver agree on which attributes are used.

The patchset:
1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
   it through ib_umem_get_attr_or_va(); no behaviour change.
3. Introduces the core buffer descriptor infrastructure and UAPI.
5. Factors out CQ buffer umem processing into a helper.
6. Adds the CQ buffer UMEM attribute and driver wrappers.
7-10. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
   with drivers taking umem ownership.
11. Removes the legacy umem field from struct ib_cq, now that all
   drivers use the new helpers.
12. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
13. Converts mlx5 QP creation to use the new attributes.
14-15. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
   doorbell records.

---
Based on top of: jgg-for-next 9733e9f580fdda2e8c1cd349caddd93f026ab6f5

See individual patches for changelog.

v7: https://lore.kernel.org/all/20260526144152.1422310-1-jiri@resnulli.us/
v6: https://lore.kernel.org/all/20260520101129.899464-1-jiri@resnulli.us/
v5: https://lore.kernel.org/all/20260517063006.2200680-1-jiri@resnulli.us/
v4: https://lore.kernel.org/all/20260507125231.2950751-1-jiri@resnulli.us/
v3: https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/
v2: https://lore.kernel.org/all/20260411144915.114571-1-jiri@resnulli.us/
v1: https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/

Note this re-works the original patchset trying to handle this:
https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
The code is so much different I'm sending this is a new patchset.

Jiri Pirko (15):
  RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
  RDMA/umem: Split ib_umem_get_va() into a thin wrapper around
    __ib_umem_get_va()
  RDMA/core: Introduce generic buffer descriptor infrastructure for umem
  RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
  RDMA/uverbs: Push out CQ buffer umem processing into a helper
  RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
  RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
  RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
  RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
  RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
  RDMA/uverbs: Remove legacy umem field from struct ib_cq
  RDMA/uverbs: Use UMEM attributes for QP creation
  RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
  RDMA/mlx5: Use UMEM attribute for CQ doorbell record
  RDMA/mlx5: Use UMEM attribute for QP doorbell record

 drivers/infiniband/core/ib_core_uverbs.c      |  24 ++
 drivers/infiniband/core/umem.c                | 336 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_std_types_cq.c |  73 +---
 drivers/infiniband/core/uverbs_std_types_qp.c |   6 +
 drivers/infiniband/core/verbs.c               |   7 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  61 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   1 +
 drivers/infiniband/hw/cxgb4/mem.c             |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  29 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c     |   6 +-
 drivers/infiniband/hw/hns/hns_roce_db.c       |   4 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   4 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  10 +-
 drivers/infiniband/hw/irdma/verbs.c           |   4 +-
 drivers/infiniband/hw/mana/main.c             |   2 +-
 drivers/infiniband/hw/mana/mr.c               |   2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  56 +--
 drivers/infiniband/hw/mlx4/doorbell.c         |   4 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   1 +
 drivers/infiniband/hw/mlx4/mr.c               |   4 +-
 drivers/infiniband/hw/mlx4/qp.c               |   4 +-
 drivers/infiniband/hw/mlx4/srq.c              |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  41 ++-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |  93 ++++-
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +-
 drivers/infiniband/hw/mlx5/mr.c               |   6 +-
 drivers/infiniband/hw/mlx5/qp.c               |  69 +++-
 drivers/infiniband/hw/mlx5/srq.c              |   4 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   2 +-
 drivers/infiniband/hw/qedr/verbs.c            |  13 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |   4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  10 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |   2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c            |   2 +-
 drivers/infiniband/sw/siw/siw_mem.c           |   4 +-
 include/rdma/ib_umem.h                        |  71 +++-
 include/rdma/ib_verbs.h                       |   1 -
 include/rdma/uverbs_ioctl.h                   |  30 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 781 insertions(+), 265 deletions(-)

-- 
2.54.0


