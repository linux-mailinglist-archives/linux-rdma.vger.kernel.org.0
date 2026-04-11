Return-Path: <linux-rdma+bounces-19227-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IxGJ69f2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19227-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1C3E06C7
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467CB301AA7D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4C2475CF;
	Sat, 11 Apr 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="0Brv7wJd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BC1531C8
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918963; cv=none; b=Frjb4W/xTeWtCXQY2B840OZ9B0RgSrcFl7LwK6Vi6/ZjozbeSmZN3hEeC6iSWrdgXcHEs6Om22GsGxO5bohTXQRyNsrJH9+WZLsEr/dwknBmZyW8iRDHEo7OMHjRl8vnpoGGbkSnTMtvJ7lbcayWTo4T62dxJZhNjcEkjJIlOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918963; c=relaxed/simple;
	bh=E6Aqbc7/QePpHqzpzgHRJjvWkJYZoq3rwrjKQN99+cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNzYN28cKitSpBDgsnD7mErmQclsYmI/oqL7uf6cR9BzNdI3ObTZ9srcfommsmntJ74AEy508VabGevQT37cMIlv/w89cVtOshAVFnKIgx5QfESoBGtLEbpr+P2lLnCeeSfsPpVFUT7rGb/4pmzMxqx8HWZw8HT79WdP2ZMqNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=0Brv7wJd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso2980304f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918957; x=1776523757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpUhbkJcJ/W4+uPclQvqu53SYpRmHbesRAXjaeVlK+U=;
        b=0Brv7wJdvDaFNxNEqjM5VBtlbBq2Se9we3L5vciaLk2xEd1FO81ImHkvp+0Edbc3hP
         OloFTie+QiCnL7rRBc6y6vJawXFvLktfkjoGwl4pYoqj5D1BRWq56Z8e01r+rDIQzTde
         3lwckf3ah14hKTM4Le5lDT1oc0Sknse8O5nce2ZkzwACmPCP3bIiQKfOacFntux/Zry5
         0w99lO0Ox3eDxtFCoxieagUcyAWkWKzeowvTNgWnpuMXFPnp1a7ZobzMGszFNa7E68Ax
         ZOzlvQOyj+UBPS9E9Edwb15tbgg4TyQ2rZuSAuasoBXOSJ1tND/QkcJkVc5MZfM3+R7r
         BbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918957; x=1776523757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpUhbkJcJ/W4+uPclQvqu53SYpRmHbesRAXjaeVlK+U=;
        b=nIidLrG5UzaxgVrl+gsR1f9ZtrdGurtkDbgY8nOag0p/uXfcGdxgtNdRcMtsYZi2fm
         UIirOPG3oxvspjcs0iKq914eG8jznMRkyluH6x7myXPYD71MFyee3gce8D5/RvB/jEVo
         QeIjdNNGZ2Djd7/Z4ELCZhC63rDcie7jJYoWeCcQF8kbVvIfAsT1wVx0De7JN10VQDXQ
         igXvZV7sTqx3/+lDXqZX339U2vBF6Jz2zIQPFEYLpthsmpCoCHAwf4BxqNwsXOLFQmnM
         5b1zmsRM9tbw3buNWx0dBaKluciR2h3cP06YT3KFTgN5PXZiZLAiXp/ghETA87RDX4HL
         oefw==
X-Gm-Message-State: AOJu0YzYKZVyFea+hiYjYP+rAls+NWHCkdsiP4tT1rbQ7vfbsdsNogYC
	+FL6bxrBWfkzUkKFMLI4+FNYEwdEypS0/sRXO/U2Zn6uIPNaB21jUN92LUs2PQQCE10ElkT9APd
	uzGLj
X-Gm-Gg: AeBDiev0y6QZ8A13mQv9KCLNVVOP69knIuPU2GHElClFWcGNb15o9g2Fe4v+yHWO8+6
	SxV+N8oI4X/e5VD1KVALsUcFE93Ctcq7syICIQQtF4wmArp/aMaeDjCwUhzZo8gRo+oFTd9hpwX
	vKVOShIGMRKtZRQEFFx9BoaxWWCeXNEoNWXqNU8NOgtCRIrMwuYCM4RvV80o4jhrzUUl5+l28iI
	R8IznLpzLRf0/srTa9ojNL1TevHDmstcK4k9rHa09shAHSrkiuxFG7w0PQjh1dIbtNi7fgvmdcY
	w6y5/DmLzyF0hZO6RH0oy7/exooYKEr0VWENrgmv9GBKlK42ydih2Wdv5Rlz6jvZBrjJoVu8QDc
	hxbgbSbjDZwfTXMYe1OnDlVAvz/hNCfd/UrHONRekkgBwjvqbAPZ8WFMBB541aUMAF4hdofZUCs
	qRMildis3m0qYPwVY/QmuUV7IdSE0t0MHJ7frh42NEnno=
X-Received: by 2002:a05:6000:144b:b0:43d:1e2f:bdac with SMTP id ffacd0b85a97d-43d642dd680mr10907289f8f.49.1775918957130;
        Sat, 11 Apr 2026 07:49:17 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de343bsm15753162f8f.8.2026.04.11.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:16 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Sat, 11 Apr 2026 16:49:00 +0200
Message-ID: <20260411144915.114571-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
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
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19227-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D4F1C3E06C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

This patchset introduces a generic buffer descriptor infrastructure
for passing memory buffers (dma-buf or user VA) to uverbs commands,
and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
bnxt_re and mlx4 drivers.
Instead of adding per-command UAPI attributes for each new buffer
type, a single UVERBS_ATTR_BUFFERS array attribute carries all buffer
descriptors. Each descriptor specifies a buffer type and is indexed by
per-command slot enums. A consumption check ensures userspace and
driver agree on which buffers are used.
The patchset:
1. Introduces the core ib_umem_list infrastructure and UAPI.
2. Factors out CQ buffer umem processing into a helper.
3. Integrates umem_list into CQ creation, with fallback to existing
   per-attribute path.
4-7. Converts efa, mlx5, bnxt_re and mlx4 to use umem_list for CQ
   buffer.
8. Removes the legacy umem field from struct ib_cq, now that all
   drivers use umem_list for CQ buffer management.
9. Adds a consumption check verifying all umem_list buffers were
   consumed by the driver after CQ creation.
10. Integrates umem_list into QP creation.
11. Converts mlx5 QP creation to use umem_list.
12-15. Extends CQ and QP with doorbell record buffer slots and
   converts mlx5 to use them.

Note this re-works the original patchset trying to handle this:
https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
The code is so much different I'm sending this is a new patchset.

---
v1->v2:
one fix and one rebase, see individual patches for changelog

Jiri Pirko (15):
  RDMA/core: Introduce generic buffer descriptor infrastructure for umem
  RDMA/uverbs: Push out CQ buffer umem processing into a helper
  RDMA/uverbs: Integrate umem_list into CQ creation
  RDMA/efa: Use umem_list for user CQ buffer
  RDMA/mlx5: Use umem_list for user CQ buffer
  RDMA/bnxt_re: Use umem_list for user CQ buffer
  RDMA/mlx4: Use umem_list for user CQ buffer
  RDMA/uverbs: Remove legacy umem field from struct ib_cq
  RDMA/uverbs: Verify all umem_list buffers are consumed after CQ
    creation
  RDMA/uverbs: Integrate umem_list into QP creation
  RDMA/mlx5: Use umem_list for QP buffers in create_qp
  RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
  RDMA/mlx5: Use umem_list for CQ doorbell record
  RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
  RDMA/mlx5: Use umem_list for QP doorbell record

 drivers/infiniband/core/core_priv.h           |   1 +
 drivers/infiniband/core/umem.c                | 248 ++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c          |  18 +-
 drivers/infiniband/core/uverbs_std_types_cq.c | 158 ++++++-----
 drivers/infiniband/core/uverbs_std_types_qp.c |  22 +-
 drivers/infiniband/core/verbs.c               |  27 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  23 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  17 +-
 drivers/infiniband/hw/mlx4/cq.c               |  41 +--
 drivers/infiniband/hw/mlx5/cq.c               |  40 ++-
 drivers/infiniband/hw/mlx5/doorbell.c         |  41 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 drivers/infiniband/hw/mlx5/qp.c               |  76 ++++--
 drivers/infiniband/hw/mlx5/srq.c              |   2 +-
 include/rdma/ib_umem.h                        |  54 ++++
 include/rdma/ib_verbs.h                       |   5 +-
 include/rdma/uverbs_ioctl.h                   |  14 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
 19 files changed, 663 insertions(+), 171 deletions(-)

-- 
2.53.0


