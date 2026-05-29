Return-Path: <linux-rdma+bounces-21500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI1XIViZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C295603139
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB463104BB5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498D3382E1;
	Fri, 29 May 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="JSpkMiDs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA63330B09
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062201; cv=none; b=qtLepkS6vD2NaCZneu/RUVjhv8S9nE7tKz8PO532gue3CgTULf6/zrwVSyUD/8gLhTkMXxsXUv2DOhH32qH3CjEm0ybyP6Rfoy3k4iXgY1J87HUv/7mRpTAFb5XXrSzdWZVeCeHtwTF0eWB7amUOIz45vwcoYYg2BBDIkS30+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062201; c=relaxed/simple;
	bh=9BcxZHfNhm5/MbtZzE/FpXYIYs4JINHWlMFzuDOX0NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5V+XHxqYBN7mbadOy4l+tg4vjTKHojRqADQOq5Ayr+EQ1Xp+wNacy21jyL9+f54hPVv4jfvPsghxO1xawLLozskZwpMvzXY4XFEzBNAnvxlfB49VcYjxMeJS4dSAV60yzq5I2JTYuyfC7ZaTUyy+Nwd57kxd93Jbr74mY/cjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JSpkMiDs; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45eeba68948so1224061f8f.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062196; x=1780666996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQfnn3UXeGDn1B7XQUNz2N5ZpMg+DUdHP4LfQPjwqOI=;
        b=JSpkMiDsdJ8d092oifAvEqzJzsbuY+l3b/b8mlemg0zgkdmw2aWDW+yjxkedk4rq4H
         mSTb8CSNadWHjuuVOpqp1pBVwdOozDd8O0St7e99Px3jnd6JlDo3ctyaZrXS/yxaetNa
         Q/l+9wERK7NeTUinLnrnBGq+LwgqxN89zQeMdks3/MvHVVRv4FZVZ6N66vQdbOEoGbHk
         dI8QJgTLeyz2Pl5Y6jwChUYT6LfrQLGjHCl3xX9kGK5ILs3N+KNtczDtR54CQo9H+Q5y
         8eoeFmGXbUNn5samRtR+w+/71hkuW/6PUodmPQDGbd3XVMGOALJWpyV8EYm5ALBbHlqO
         Udpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062196; x=1780666996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQfnn3UXeGDn1B7XQUNz2N5ZpMg+DUdHP4LfQPjwqOI=;
        b=lBSxuDW2yRyRXb0sKZg8Jn/aDjLPbsbVzm813p5lssZXQ631ytYcA8fuTl448KPV0B
         nIFi2NVnPhqgFpHLjvIv2/f16m2f/Ppq6JROG3vVazMOhfhJXgNGh/fMhKPciO18jTmx
         xXuN9pUWS3lNXIQ+6+Bpy5Ek+Fdqc4OLBnJq7l1Ae9+px6OrwHi/8+7gLzU52wW2D1hS
         YuC2olizlZwXd5FBoOcixafMH+mD7rgMcY5LxMzv0BvDw29piy5gXMljUrN8qcVN91K/
         wjTYj8IF1YnlbAUrcF9mUI/MxjEKzETUxIcDxl2OlJxuuEAFoRlEACabvIkq2SdwfLSv
         EXnA==
X-Gm-Message-State: AOJu0Yx1sKPMaPNr1vgI72bIqu0p3jOiY4/uWDaVuhgv0PKSAWIp4FJP
	V0QHxKDpFJV6FmQA1ulMj8CuKcsN1I4P/z33zlQqOa4r6AKNUtAxepJ/Y0TBEbbS64lpLWSQays
	/gntd+wP1Ias/
X-Gm-Gg: Acq92OGvQf0zhPVnPcIDPCVOxv0r4/F2FPfKw/EaJ+D/99HpVkquhKRh+oTR3j6Ffnw
	fufFrZb2v0PZfZZnJ/zEqCnVyFHe/BiUi49yXDINVMBiZRF1+Nqi++/vArigCQsYAYZ0xia0D1s
	XNHoe3HGuAvN/j864WUK40qV9m+Y55YIeuGz/4muy0nRhRGSTcE7uBh7tXJDqfySXHmlK82Q8cg
	LAM4JfgtpW2sxoK0UdfwcAhqkxMD4eEXTHJIJaM4XkizATjDUvOEixa/hBVeIpMtRYe3q0zLt64
	dVi/Goesmh3WW2STsTEZL+ZA4kWWvtuvsBx7+HXvUvC4vPR9r9NzSM9lgjorEXkkmEnFFET859F
	0t6GZ/0wtqYJyJSm3yhrybrm7EwkbU6Iy018ct757MjdDp6Gg1xzG1IWxmdo4N3h69qo5JVGVYF
	Mfsq9LMgtCFcdi2pJLelGV7yKEotMv5pM2JhoKhiswg0U=
X-Received: by 2002:a05:6000:220c:b0:45e:f2bd:2b17 with SMTP id ffacd0b85a97d-45ef2bd2d85mr4480506f8f.21.1780062195443;
        Fri, 29 May 2026 06:43:15 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a037fsm3632608f8f.4.2026.05.29.06.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:14 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 00/16] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Fri, 29 May 2026 15:42:56 +0200
Message-ID: <20260529134312.2836341-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21500-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	URIBL_MULTI_FAIL(0.00)[resnulli.us:server fail,resnulli-us.20251104.gappssmtp.com:server fail,tor.lore.kernel.org:server fail,nvidia.com:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 3C295603139
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
14. Adds missing ib_umem_is_contiguous() stub.
15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
   doorbell records.

---

base-commit: 9733e9f580fdda2e8c1cd349caddd93f026ab6f5

See individual patches for changelog.

v8: https://lore.kernel.org/all/20260527170948.2017439-1-jiri@resnulli.us/
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

Jiri Pirko (16):
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
  RDMA/umem: Add ib_umem_is_contiguous() stub for
    !CONFIG_INFINIBAND_USER_MEM
  RDMA/mlx5: Use UMEM attribute for CQ doorbell record
  RDMA/mlx5: Use UMEM attribute for QP doorbell record

 drivers/infiniband/core/ib_core_uverbs.c      |  25 ++
 drivers/infiniband/core/umem.c                | 349 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_std_types_cq.c |  73 +---
 drivers/infiniband/core/uverbs_std_types_qp.c |   6 +
 drivers/infiniband/core/verbs.c               |   7 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  61 +--
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
 drivers/infiniband/hw/mlx5/cq.c               |  41 +-
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         | 103 +++++-
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
 include/rdma/ib_umem.h                        |  75 +++-
 include/rdma/ib_verbs.h                       |   1 -
 include/rdma/uverbs_ioctl.h                   |  30 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 809 insertions(+), 265 deletions(-)

-- 
2.54.0


