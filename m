Return-Path: <linux-rdma+bounces-19913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBW6Ejim+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E192B4BE40A
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DFB33039384
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC720DD51;
	Mon,  4 May 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="diM6wMF0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CD29BD9A
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903060; cv=none; b=ssJIrO5KSMKdBsZy+R5Zi4UHtXfP35c60fLD8UQbdtHOkOKjiGzPO/Ps0jFLXiH9MSEr97hnsPv4MNd9mYGYj+1spIOz8koOxyP13MUrKvGkELPHSd3ZV9i877LZyqhmzah0RYgKPMuH2VErXuvX8shBNUcqG5tGr1vA6wRwaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903060; c=relaxed/simple;
	bh=7T0wLqJEDD2Ya+cbEoPRv68zZG2W/hONFHvP5t1GVrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTbER59Dv/sI2b51YgcynZ87aoaYElYYA/Iw32SoGcHyrCexhCJSoFfvSwfAuna5wB17A7kcb73Irl++G5a6vC+DnBgAuvTgksW/wmmox+eHokqTIP8JhpDuacWeDaBcUrvD0k9DKnL74lxeAigb3Gvn81qyegNU3gzTT32InIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=diM6wMF0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so33336455e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903054; x=1778507854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RBsMQlQY7YoWqziSSaIkdVoLmGXdutCTLQ6AVPD5c8=;
        b=diM6wMF0iAap3Gk6qofDd+t7TlxapwAj76HnvltkipWq95sQPxWLDq7BJ4tvh2yDqs
         iEMGTixlUntmDQ77qHhCBy3lgS4rPy3WwaRtj5UnDa+MUqU/5SISv75fWlw5pMaMrCgN
         Lz/oRw/H/kxwWyUd3rUe8OHVqKw9anpU56dTZuhxY4T90nLXfDhMalf3LhU3c4zwcn6t
         lBnNJ3v1dG2TJtXeL6ix5TqX371Sv24/R/Cx/3sIlXsMNJPX/idGutEV+EUyREKbmKqG
         o66LJ92BF/dGd/Mt3soHuzR0QQlSVon4whRhQ9i7Ymkqpzo5q62VbvGE3ylMQLgpbOMj
         XE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903054; x=1778507854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RBsMQlQY7YoWqziSSaIkdVoLmGXdutCTLQ6AVPD5c8=;
        b=nk/XP9+3Zc63eZZMSJmr+H4hWlcEPNOIANLMLCUz1aHrrLZ7DcHkKqaTOM/8zPbAc6
         iMtzOvXBwHfZ3Zj8WcolGtKn+yrcfbDKTA8MgF4ZiJi1GRA9AjhHufnUv9OUjiAJNbD2
         hrfb2IhCBdTtTuC2NnvWhjTLxrMhO23rizXKVYqkBfxCfd1p1IQ6uuYXT2pnP7Li1aDB
         5PyF+beGIYUof8wWCSRhk6wryd/r4Cb2ks+BGh9v5/tj7Sqm0OlXhxLNqBRItPU/HElv
         a7wLqt4519eTj27jo5iL55Iug8yGMK05hb7y/yhH1fSbhPd51fLOpzHo5xprQRr5HUwn
         b6Aw==
X-Gm-Message-State: AOJu0YwL6omafPLQ5Rf6EYgdQD9QVV3lwvT66SaNHKrr4adV6zdfa3fB
	1O8kumvXEj9rQn2UGLOR06cRUA8Pjx0ss4vtH5gxsTBB+4QIgqilcy2nWvUsOib5Se1zCoaK4GQ
	7Zl7wbOI=
X-Gm-Gg: AeBDiesDxDqRPfSeDbvIvCTiOOuqrPi21E7BrnwPRoxEb+SODMxlFCkiQDvRQTc9EHX
	MxGb+t/G3qx2VoQ8Fysl+ITRTh6zE4V283/xP1q5B7EjQpe5AqT1S9Q+aQEM7d/fDo1CamX1zKm
	5QAkwF7K8jtFVwm57p2ZvoB/hUWZsAGtP4FiDbDgMtUH/vShIwKjlmN2U+lKGSII0+dK4dLhXSg
	UVKHzCoROSjyI2+sB8C8n/FOXrNXvFs2XyFG/f/4edLC7Zj9KEIjJOj/y7koynwqcpUm/3W2iqt
	AF2dCTjC2DzeKXERw0GIGdoUDROmnyOLyeqsFbitCi0qafYGiYqD0Q/R6xd2cZIxsyd/Ct8YqvV
	Ef96K9pEsGbbWJi+OKm7wN/F7kWNGTT9Y5FzJfMbQzISaR8JnjHq3EfVIoJVOKS0o9vrv74SV0f
	jIZUjmzl7Ssp124ylH8GhkuP03
X-Received: by 2002:a05:600c:3b15:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48a98676e37mr167936115e9.29.1777903053974;
        Mon, 04 May 2026 06:57:33 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee6ee5sm104325745e9.8.2026.05.04.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:33 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 00/17] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Mon,  4 May 2026 15:57:14 +0200
Message-ID: <20260504135731.2345383-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E192B4BE40A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19913-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]

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
5. Inlines the const attr helpers so ib_core can use them.
6. Factors out CQ buffer umem processing into a helper.
7. Adds the CQ buffer UMEM attribute and driver wrappers.
8-11. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
   with drivers taking umem ownership.
12. Removes the legacy umem field from struct ib_cq, now that all
   drivers use the new helpers.
13. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
14. Converts mlx5 QP creation to use the new attributes.
15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
   doorbell records.
17. Adds a CONFIG_DEBUG_KERNEL-gated tracker that warns when userspace
   supplies an attribute nothing reads.

---

See individual patches for changelog.

v2: https://lore.kernel.org/all/20260411144915.114571-1-jiri@resnulli.us/
v1: https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/

Note this re-works the original patchset trying to handle this:
https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
The code is so much different I'm sending this is a new patchset.

Jiri Pirko (17):
  RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
  RDMA/umem: Split ib_umem_get_va() into a thin wrapper around
    __ib_umem_get_va()
  RDMA/core: Introduce generic buffer descriptor infrastructure for umem
  RDMA/umem: Route ib_umem_get_va() through ib_umem_get()
  RDMA/uverbs: Inline _uverbs_get_const_{signed,unsigned}()
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
  RDMA/uverbs: Track attr consumption and warn on unused attrs

 drivers/infiniband/core/rdma_core.h           |   2 +-
 drivers/infiniband/core/umem.c                | 217 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_ioctl.c        | 102 ++++----
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
 drivers/infiniband/hw/mlx5/cq.c               |  41 ++--
 drivers/infiniband/hw/mlx5/devx.c             |   2 +-
 drivers/infiniband/hw/mlx5/doorbell.c         |  55 ++++-
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
 drivers/infiniband/sw/siw/siw_mem.c           |   2 +-
 include/rdma/ib_umem.h                        |  89 ++++++-
 include/rdma/ib_verbs.h                       |   1 -
 include/rdma/uverbs_ioctl.h                   | 113 ++++++---
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  23 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 48 files changed, 717 insertions(+), 329 deletions(-)

-- 
2.53.0


