Return-Path: <linux-rdma+bounces-21304-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJYRMLyyFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21304-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:48:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F85D7E35
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9F13010EE4
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693A3FF892;
	Tue, 26 May 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="tOmvav7e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D94355F57
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806522; cv=none; b=E1xZ1R8YixjKdrx/5fSDTvbS1ktmta60szqMnF2ie6hsTxrjJVipRUBudx4wMWgfI/jrJFnWkn3VzojA2yxZHgERGLxPbreQvqArR7TGZ401ZeDHg0xOBAnB0H60DCHzxifBgRic9h+RjufYZKK87ejSkfg71LY27uZpKQ8FqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806522; c=relaxed/simple;
	bh=64gInwnnjhhv8V6kuMqS9KmmdJUoAxUSoD1AvBRfyeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfQQTG8uqNJWwIUkCvf5qM2eWWbwqPVcHWq4zF8K1nYVTPl3H2abq1LkySO50EOWT1XQoUPDfSQnL28IM2QvRfyNBrrZyWLQ8EQ1ANVBr/xtxiDtjRbBvXV1Wc99qkr+pUcqiymjoAeivV6QiYxnUyB3477mS29dMuNhFAKkC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tOmvav7e; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4905529b933so23425295e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806517; x=1780411317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTKl3pLJD8SabdAaZe07jyBUSBk+quM4ZE1IBcHKtIw=;
        b=tOmvav7egtcpyOBHUNOLhBFLcLhh9M3/KAimiGO0tr/i7z0zbv7PnkAJnr85cXaNnC
         H1EGny2bHxGIcvYz2LOUFcx7c64i8FXmUPE5zF9IHT9/EH76fA4wknm+W5GAGR9vKDEq
         L+dMQXI1BjuitbFO9HnxdRihohoS4sSYZnHgFe5SzhjZDCRhJSVKzINeUtXwyHAfDhjl
         bLufdR4xg1h6OD2YmJiuI9sQ5zczVdLefXcewWVssh9dnLaThtyTk8htLHU8qy2kCZF6
         U9jJoGwFtXTDOX1gFBikyDHKeWIwsZ/7PAeOcUiF338jHWaewywvuCiS6O2ylq53fUgT
         iW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806517; x=1780411317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTKl3pLJD8SabdAaZe07jyBUSBk+quM4ZE1IBcHKtIw=;
        b=HN+tCRvomtXJnMN/2puc1Q2jWokN2bRosdVe96Cgpce76pjhH2MbUjMmkRJzhHQ4sU
         rEdUwJEQwDDzA0HjHas7mhMLjXXXp+GSN7RoUTNPXUxDS08PFvynFu/FOQWN4aIlloYr
         zcYQ35mFgkgI49Tgie8Cmhh7DyRbXGeLsnxlG2fCiynjXvyfnfvC/EZJ4AZarvbNfhir
         OZrCKm+pan4Ug77Xe7bwqYzo4Yk1beGJt8lYYGRZCjixe8dqF62tlrKn3KGKiAB9P2aR
         5bX0iYoVFQqjtiyzVbo8GQyiOqSBQwyRIfRi2o125JVhP4HN+nPwUZikFCvYufvoIVIL
         vCeA==
X-Gm-Message-State: AOJu0YwZgOPVKp9MsHUkf+/L+A3GTBrk2JPT9FyVwGEGrUZEq4nxzCCs
	QTAo/YKS+bDg8hqZ/Jrma/BPdVUPZBq4pMnI0BDLEa7Mt+gvqgWQnPNeAhLB1iTigc99cbn/io+
	XXTZlRLKqqfd7
X-Gm-Gg: Acq92OEkiWgMng1gUkf34b/MjZ9QzYhzN2zDwLS2HPUAk+AWtRz75wfuouHo1lZQlrr
	lmFHfklT4KYaltFjFzJRk2bldA4935CI5yLfIjfBJOT8s2U+G02XHHeyKSerXK47YR0YHq2UVW4
	SyNkNqi9dtIkmld+VPEJm4BaK7T0oZRl6F3pv6OcpBqJlq4RK6Ao3P7wWQPHDQJAstcfH0AvSLY
	+l7dXQmXmnX7hiaam02382VJf7TeOFknZbTTYoRO5xXfZ99MyZBmokpKYtE41ifvWdHIL7xteEP
	XGltiJ5bD8wizC5d/NnRuDsX+2zhufYxN2PwwjHa7bZJ40RqTxgppGdVXuwINRx/fOlecqJGBxT
	HCT5oMJB7dR0wensk7+je1q3aRUkwNJJUQ29E+Fop+hiydGrnZJE3FP5k2Wm5A/QE8PQ2DTVwGL
	IrzDyam+kMr50xkr0TM3oaZWFHzHFFptIR
X-Received: by 2002:a05:600c:a011:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-49050ff7b15mr246311765e9.5.1779806516558;
        Tue, 26 May 2026 07:41:56 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904333146bsm193574235e9.0.2026.05.26.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:41:56 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Tue, 26 May 2026 16:41:37 +0200
Message-ID: <20260526144152.1422310-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21304-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 392F85D7E35
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

 drivers/infiniband/core/umem.c                | 336 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_ioctl.c        |  25 ++
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
 include/rdma/uverbs_ioctl.h                   |  31 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 783 insertions(+), 265 deletions(-)

-- 
2.54.0


