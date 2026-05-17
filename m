Return-Path: <linux-rdma+bounces-20811-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMwUMXpgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20811-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975955F7AC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE9B63005AB5
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B4280325;
	Sun, 17 May 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="KsrYoNds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269861ACED5
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999414; cv=none; b=bpG0A8s/QWzNsMHK/4XzTCX4IGDTDQSk0OD5QOZ6tiVk+1AT4HQZQJtT5v4C2rgdYNimBtJ6ZeH4RV58YXYuylpsDkIMbwAM/pmWez1jMJjtYU+L5udc/C0EAWXM6r43AmboUsrPICcnOOBkj2FEhenGk8ckWHK3lTMLrjU2SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999414; c=relaxed/simple;
	bh=ftYbjdBe92C0ifSdfkN0YyaACxO3nNsgG7pIm9BMx8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+gmTrDP2TGCf9TmskJHpv2Z9Wn2o49TjN0o9ojENYz7oZE0wTjA3p1K9P3u0THvro1kPCH9YkHvRrYZP0IsDbXpS/FK3aOnIyWcswBrsIXM0u3DqQd/X/79uliTW0QqtxfG2YW40DmU/DH5GSDIDqNRqOcEigpPo/ND+WR0Mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=KsrYoNds; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488b0046078so9689995e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999408; x=1779604208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr6X/VVyxGOrDglPUG0QJo95WDmZiQHUed5KzuSozPY=;
        b=KsrYoNdsw/ddyiOQH14UjlCfmbjBGNUwoN9UJuStmgpdwf34W32Ov4AIogaPqHtZ8U
         qRpKITCW5QY+hH9MS1eh+rMRRoYAcp+bKB86MpdX7+11xJ3dvinN8ZDU/LKixP/zPRQ4
         mm67BA4/qclv4G5jfV2AKD6UrtdU8hmMjV3ygDQQrlWipZy7xxonvhIBKQiuBd7IYvzk
         tt0I+JIEsJl+kQIInPCr2IogP8ApWRhnbli1HPKgaoBZeEwrRnaZ2PNKPjwlWhwpib5T
         cfaRcuhlF1nNYQA9ZdGrcuCVxx95OMSR0L26QO7ug9f3jyPjU+pH9Br1v3Po7SNP9jHp
         57RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999408; x=1779604208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr6X/VVyxGOrDglPUG0QJo95WDmZiQHUed5KzuSozPY=;
        b=IVH/Qah8wOuXkyNJVx74SxKRW5OkTbjNx+/3WPNuetPbsoqrsp2oUL/aSTaAR96Zx0
         Wz+C8r2DEET215tati+F9nX3TyXxEhvddbvr45oF2b5LByj1exyLbapdZuUdM3OyKgTT
         +yYQ/6LEJPMm8ydd1vRnfomanAX7r/qlPcVnqTvFaTyvBnYCwNgrJ/c/v9c2TQgVBP8C
         k8ZmgdCgoAr6QmnZquiz51C8mkQk4tZuGJOprZQaEFIg4DHiKQ4dfGxhhq5SruJOmOw1
         cnlA7ZimU8c1xCj1/sCOefASvqakaJnev/cenxybeY+69xjuXhl5gk6T/rvCnPOrdzbZ
         LIIA==
X-Gm-Message-State: AOJu0Yz9QgCLnxPHMAhlsiwUwbdNjrQo3rYbyq1pXaCWtWh6YYn/QwyJ
	GWe19kz9IQCaw6BdkPOBKWYrsTRTEObEYA2ljMs2p/Ajsa5c65YoxCRddSfGBycIZSR+c1f2Ok7
	ax+REKCdRuA8G91k=
X-Gm-Gg: Acq92OFFOGMU8jop7FWUzqQw3qVla5gyB9QSkOIxaIRWtg6cQ6GdQ3/fXUiNL0VX346
	2Y0Y7JbaXRO/rikotxnNGAJXCZzq/icbYlFYco/aJv2HEQV3Ng5dNN5fjJvz5cROQW/Zvn1p225
	uWLTkc7vgDbwHhRZw+yztVhCqEaAFNLBixI7KGXF8dj/F8mC3k97QU8ioStG7Nb6OJeeFAm/yAp
	um5Y6HZTuz+1Yw4nVfKk2wwbkeIgj3iVLOt1vVKUQYmqorskB6DZtFsX2cpZDoGGUNFY1QOWsnf
	v/NtmmFaSvEGtpfEnDpU0vOGSeDl1BdiX28XrmY7MUQbKFo0ISNf7drIfuguz0FZ5NJf+HRF4EN
	BRHXLgY8Nx6ilef9JPI86TPgb2pJr6KufE/K3vwqqVr1wLFdxrEWeXVpLPR3YBeMJamLAhkEXqX
	5uYjNenakIZElfDWuaqizRbl4c0gMxXX8qtHusMzmRBAsP9Q==
X-Received: by 2002:a05:600c:c10b:b0:48f:d1b8:9aa4 with SMTP id 5b1f17b1804b1-48fe5fcdef4mr108853955e9.7.1778999408161;
        Sat, 16 May 2026 23:30:08 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead18659sm54250115e9.7.2026.05.16.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:07 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v5 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Sun, 17 May 2026 08:29:51 +0200
Message-ID: <20260517063006.2200680-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5975955F7AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20811-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Action: no action

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
   it through the new central ib_umem_get(); no behaviour change.
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
Based on top of: https://lore.kernel.org/all/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com/

See individual patches for changelog.

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
  RDMA/umem: Route ib_umem_get_va() through ib_umem_get()
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

 drivers/infiniband/core/umem.c                | 237 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_ioctl.c        |  28 +++
 drivers/infiniband/core/uverbs_std_types_cq.c |  73 +-----
 drivers/infiniband/core/uverbs_std_types_qp.c |   6 +
 drivers/infiniband/core/verbs.c               |   7 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  61 ++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |   1 +
 drivers/infiniband/hw/cxgb4/mem.c             |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  29 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.c     |   6 +-
 drivers/infiniband/hw/hns/hns_roce_db.c       |   4 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |   4 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  10 +-
 drivers/infiniband/hw/irdma/verbs.c           |   4 +-
 drivers/infiniband/hw/mana/main.c             |   2 +-
 drivers/infiniband/hw/mana/mr.c               |   2 +-
 drivers/infiniband/hw/mlx4/cq.c               |  56 +++--
 drivers/infiniband/hw/mlx4/doorbell.c         |   4 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   1 +
 drivers/infiniband/hw/mlx4/mr.c               |   4 +-
 drivers/infiniband/hw/mlx4/qp.c               |   4 +-
 drivers/infiniband/hw/mlx4/srq.c              |   2 +-
 drivers/infiniband/hw/mlx5/cq.c               |  41 +--
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |  95 +++++--
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +-
 drivers/infiniband/hw/mlx5/mr.c               |   6 +-
 drivers/infiniband/hw/mlx5/qp.c               |  51 +++-
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
 include/rdma/ib_umem.h                        | 100 +++++++-
 include/rdma/ib_verbs.h                       |   1 -
 include/rdma/uverbs_ioctl.h                   |  21 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  23 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 693 insertions(+), 258 deletions(-)

-- 
2.54.0


