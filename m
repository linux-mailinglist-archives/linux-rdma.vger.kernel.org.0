Return-Path: <linux-rdma+bounces-21033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AreDx+KDWpdygUAu9opvQ
	(envelope-from <linux-rdma+bounces-21033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AFD58B8FC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F666301E222
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12743D47B7;
	Wed, 20 May 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Uxf/QJzL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F333D3CEE
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271898; cv=none; b=cVRYl8Of6Tiz+1KigWVCJ0sSpY687smWC8rK6ifJnviKzCIVQOlBld2BjWegBjhGOEobD+Tn17oBpU84HxcY3ZQuH14jcjKWsozBoQkuLbwveR1rpa98/oBSsGIwyPJt5bWl9DTeoY9bVOwnSLJdjydl9HDKYpC6Lxaf2CwQPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271898; c=relaxed/simple;
	bh=tWlDC4V7wcI1M8JpHsypvcAIVERg2LZ0+fVZhaD/k4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sB7BDjCFnum45EjwCJe2qNWW2eSVqaLrJlCdDnOev84cyf6Kt5Qyp1bhQnebiqtl9hslqEV1KHcIjL1TxmwRFcv55ttTZYo3rl8Bh2nSUVIuQ9QjjYWn25Ro39LLVg9UkSUohdo4Egh03+EbvNaepIpKL1yAsi4XGv7w7kBtwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Uxf/QJzL; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so68278695e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271892; x=1779876692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IldFzI7NSCTQmcpNj4jScQZQq+8zKw/Zhd161WZQRuM=;
        b=Uxf/QJzL8ArpVszgQh6e1tVmzNvo3wx75tlahYjHVxCEcH3VQwo376QAD8fcEG5SXx
         BfGlThEMNxqpFllzTeeBYKZBuNg3dW7D3cJE9o0q7aKcj4bg9MwHyD1DaQmkU2b9RZfV
         ylRsMkamD2mdBrWRQo0KAdtRmsnl/+aDpgucAjR0vpaLLZsJ7IA1/+XYNdZZraUblNHB
         yBBUzbvPq+Qh4ejkkPNtt8t8YGjA7Gv3+T8zAyZM0nFf0CLJ37+HgStVUmooqC31vpXc
         5C6bPgIbh9fvMCw4Q9+MLeiMJKqmAYor9CLXbRsRsFvRaNWicblaZ2ekvWRSrfu5POCS
         PhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271892; x=1779876692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IldFzI7NSCTQmcpNj4jScQZQq+8zKw/Zhd161WZQRuM=;
        b=BYBqto/EuEQOrFOEfpoAWDobkoUS0re0l9Ruz9btQ3+o5SjBhx0lM4rF1CZiJ7FvGC
         GzYPr3tN7X7UyQpMQK0Kg4bYFhypfGbqDZGbO4iWrBnGYLQoW6Adh3rlbmFHVe92AAX+
         FVZQFBVjEjgUsYyUS38fZ5wkACi4tFkb4ZV1O2nXhybs/yT/MejaCW5uprGbUpDk+d48
         0Sc5MhAmsRFDYqZSar+CF+N6cXaK4xYPMONW1IuxpBeXAGzH62rrR2WkBiUCwJyv35DL
         vn1RldsCItLls4TI/0fo+ZYncJs81LxPAAclgK0KB4jFAvzMFRjTK4Q/8FFD97JS6i1U
         2prw==
X-Gm-Message-State: AOJu0Yx++myMKFPdvNVsouokW6nOodNtNGg60TeQW68LfCLRBYKldVBW
	Wbp6I2EpC/M9dIvQelBSOrWIEJASvRuTou+CNtRl7YXhvJE96EUbqOAWcF3kqmVsBuYG9lWjKWv
	wToVbYi3MiNzN
X-Gm-Gg: Acq92OFJpgP4+HDdQZ3uwU4vED6B2oYO4o4MYO2Ff+A+5Wboq6u8iDV5C/K83DH4LWW
	QLJQMWZYFTdmTz9h7aitcF+9BfIc09QIZTyhiXELZNFNWjDZVeGD/cZFd3w3oS1h3caPUdY5cWy
	8rhlvEsLIDzmyY/PGdZrH3o3s7v62HJb607Y85VyuOpjEBCKqUKApRU/rU9dSk2tnzgDmwVR6XB
	4AHATpB+JGQRiVIpBXm6Ic+D+I4zGopjizTPCMCGm1T0hlXAr1B+SO03CbLg6C5jPjPHA2+FF7w
	eLk+9DFIo+B4MW7RCSTufnTdJHNZ5wG3VyeV6gnszqC3GUwHYgdc9vxYe0J+GwvMbJIQmrlGVYr
	DRoTcVkcVknyYcm+MyUr95IkhWfbVfOG2eRTSi4N3+8N9olRZIDPgRy5eePr/Y6+KanzPudr0ZA
	2o7x7LcptxeolbR8iOUtXCzIHLl9oQoj1uTE+MH1FBO/n4v8J74y0ZEQ==
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id 5b1f17b1804b1-48fe651690fmr361979235e9.26.1779271892322;
        Wed, 20 May 2026 03:11:32 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaa2c96csm129371125e9.2.2026.05.20.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Wed, 20 May 2026 12:11:14 +0200
Message-ID: <20260520101129.899464-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21033-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 25AFD58B8FC
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

See individual patches for changelog.

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

 drivers/infiniband/core/umem.c                | 336 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_ioctl.c        |  28 ++
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
 include/rdma/uverbs_ioctl.h                   |  21 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  23 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 772 insertions(+), 265 deletions(-)

-- 
2.54.0


