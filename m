Return-Path: <linux-rdma+bounces-16420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJE8I8u2gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30196D65F3
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5539A301C53F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558C396B64;
	Tue,  3 Feb 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HAVP6TA4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938734D93E
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108610; cv=none; b=hq4PlU4NNsFdrBlpVK0Ci1i6q7EubaG2i0HwF5luI5yWrbAJxsLQelrCf/tgNGCSSvVd0D1vz4geYOFm61DJlsNdtB1FILFMvhi1EG0G8/MJCSVyAmgQmiSd4I9U/CespNIQisE6c8BsifhafoVodPGSCVw9Kh0jlB67xz4dsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108610; c=relaxed/simple;
	bh=mp5ThVsB+Xsf9fK87beQfLgNx7BNT8ak2gHhgXEVNMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXesPcxY27vRw9Ylrdl51OCapDgsCv2T+lj/8UZtZT3wSO/ylCOAx1av/GDu2UqQejtJ7wGfIIWfHLio+8mQjnFZJMg8WGKZEn2A2eyGQw5pLimrcHMQ4jurrYQ7NVxhVFOLViDXGHLeat5Y76dT1oELday9RkYzN2y9DTShHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HAVP6TA4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f2599980so25142915e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108605; x=1770713405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhEQ7JojjB1NKH8viEmZ/9MkJlLxmHsPXISYe09CKlw=;
        b=HAVP6TA4v2RxSvb9SyYvJaR8zZ1wcNDK6TYKtMWnH72n+amDAdiAg93ddQszmqm4jH
         vdV2EBPZ7b05GTuHjSZ1WLu4qWhlaJS9bnbulFwUQnOZDaooL9KkwGuQMyxGJ4a5Z6++
         bGyeRAKxBprUBKTgKGI6KrOq3IWw122xL80OdqOGtlyyUG1Ojv4y9CWyT5jfziE38BbX
         XVFNIVFxoK7hQnM42LG+GKSBzyW2LPg5B2RzgQU5E2WHott2if++gKz8swizNsQHsU/f
         BrUe4EGFkPoqu8zzMe93e6WDaxODfR56OsRvpG1qjIUfHWXz9BHfqDGlfD9OI+Q+zsqX
         z28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108605; x=1770713405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhEQ7JojjB1NKH8viEmZ/9MkJlLxmHsPXISYe09CKlw=;
        b=Dqa6mAvwAHHMlFDmf47GY6EpedNUxFNv4oTt6LHsYyfvXFkzSLmNZPnuotYua/U63t
         Pfye7jXqchwXe7ZTKu0q7EWLOf0+Y51JJu0WWUYzJxMYEfOM7wje+zSIx34qVhE6xCG/
         X0AIj2fg+79WBHgWKDDJbTVrIdZDVHzw9KNJAEgwuQRJ6uyYgzTtdrl8SJr/ZySaXcAi
         leepH7+jiPvXTCLrsM0um8yT1cztMZ/7iID8bd1sPB6LaaUrZG1tzFrADWDldcSK+Hd/
         9kifn+vlYkzIfmzhEIcfZy41D3H4UaliGaKuw4XHwa+N61uUBDoaCZSrlZtwTyNSuYQ8
         jwaQ==
X-Gm-Message-State: AOJu0YxUY7ZKt0qIH9WyqZx8cETZHU45D9sHsNNjYfDlP/oFXeK9NZpx
	Ohjiypafx4WCNOz7uVyiPyIiaDjkcR0eLNEGAGqQXeaqwwBPvycGJeztJ0u1tg8CH9UkMUGFwhT
	ti8Eg
X-Gm-Gg: AZuq6aI9cnaxkwBjHrxFeQT0o02U1qzZSUHeEyq4uFc8FaJMz/fv+iIy0X96TsVntzm
	QmMgmeXR4GV4WiEMZgulIhQxIXutC0w/zlN9L9moXZtFK3A3MRDqK0XZS7Scsy5cFAQUqhBb/A1
	EXO/P4ZE/buYlR0hPe0ZLN0MMix4ll0qUiS6rZSZSoYKOVPZ51TjGrsTf3wA8xH5axA7OWz5SM7
	YFdh5rETk0btznb5FlA8r5Bh0m0FBU4yxQLf20c5DsnKs5UxDtdtUC0dj2py/tWXd9KSlrk/edJ
	Ik1TGRiDCjvwKtzmrSB4SxqoKo0y0qR2yX+SXEak0V+Hmx8HXFAYa3KK0I+b5LSSYYCsiNgwd4o
	bm4qf1yPT75EK0gq4lZJaHbCYy99BFcdOzLXyG7J8W1Vmf+RC1ArSZFo8PwYYlFGLbfMSfMMQLg
	vlpA==
X-Received: by 2002:a05:600c:3e16:b0:483:a21:774a with SMTP id 5b1f17b1804b1-4830a2177b7mr9036525e9.26.1770108604853;
        Tue, 03 Feb 2026 00:50:04 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da91a227sm144772905e9.2.2026.02.03.00.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:03 -0800 (PST)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 00/10] RDMA: Extend uverbs umem support for QP buffers and doorbell records
Date: Tue,  3 Feb 2026 09:49:52 +0100
Message-ID: <20260203085003.71184-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16420-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 30196D65F3
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

This patchset extends the existing CQ umem buffer infrastructure to QP
creation and adds doorbell record (DBR) umem support for both CQ and QP.

The kernel already supports CQ creation with externally provided umem
buffers. This patchset:

1. Adds umem reference counting to simplify memory lifecycle management.
2. Adds mlx5 driver implementation for the existing CQ buffer umem support.
3. Extends QP creation to support external SQ/RQ buffer umems.
4. Adds doorbell record umem support for both CQ and QP.
5. Implements all extensions in mlx5 driver.

This enables integration with dmabuf exporters for specialized memory
types, such as GPU memory for GPU-direct RDMA scenarios.

Patch #1 introduces reference counting for ib_umem objects to simplify
memory lifecycle management when umem buffers are shared between the
core layer and device drivers.
Patch #2 adopts the new ib_umem refcounting model for create_cq_umem.
Patch #3 implements mlx5 driver support for the existing CQ buffer umem
interface.
Patch #4 factors out common buffer umem parsing into a shared helper.
Patch #5 adds core framework for QP buffer umem support with new uverbs
attributes for SQ/RQ buffers.
Patch #6 implements mlx5 driver support for QP buffer umem extension.
Patch #7 extends create_cq_umem device op with DBR umem parameter and
adds new uverbs attributes for CQ DBR.
Patch #8 implements mlx5 driver support for CQ DBR umem and extends the
doorbell mapping infrastructure.
Patch #9 extends create_qp_umem device op with DBR umem parameters and
adds new uverbs attributes for SQ/RQ DBR.
Patch #10 implements mlx5 driver support for QP DBR umem.

Jiri Pirko (10):
  RDMA/umem: Add reference counting to ib_umem
  RDMA/uverbs: Use umem refcounting for CQ creation with external buffer
  RDMA/mlx5: Add support for CQ creation with external umem buffer
  RDMA/uverbs: Factor out common buffer umem parsing into helper
  RDMA/core: Add support for QP buffer umem in QP creation
  RDMA/mlx5: Add support for QP creation with external umem buffers
  RDMA/uverbs: Add doorbell record umem support to CQ creation
  RDMA/mlx5: Add external doorbell record umem support for CQ
  RDMA/uverbs: Add doorbell record umem support to QP creation
  RDMA/mlx5: Add external doorbell record umem support for QP

 drivers/infiniband/core/core_priv.h           |   9 ++
 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/umem.c                |   5 +
 drivers/infiniband/core/umem_dmabuf.c         |   1 +
 drivers/infiniband/core/umem_odp.c            |   3 +
 drivers/infiniband/core/uverbs_ioctl.c        |  68 +++++++++++
 drivers/infiniband/core/uverbs_std_types_cq.c | 104 +++++++---------
 drivers/infiniband/core/uverbs_std_types_qp.c | 114 +++++++++++++++++-
 drivers/infiniband/core/verbs.c               |  72 +++++++++--
 drivers/infiniband/hw/efa/efa.h               |   3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  10 +-
 drivers/infiniband/hw/mlx5/cq.c               |  47 ++++++--
 drivers/infiniband/hw/mlx5/doorbell.c         |  27 ++++-
 drivers/infiniband/hw/mlx5/main.c             |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   9 +-
 drivers/infiniband/hw/mlx5/qp.c               |  93 +++++++++++---
 drivers/infiniband/hw/mlx5/srq.c              |   2 +-
 include/rdma/ib_umem.h                        |   9 ++
 include/rdma/ib_verbs.h                       |   7 ++
 include/rdma/uverbs_ioctl.h                   |   7 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  20 +++
 21 files changed, 500 insertions(+), 113 deletions(-)

-- 
2.51.1


