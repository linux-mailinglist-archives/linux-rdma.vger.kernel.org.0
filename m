Return-Path: <linux-rdma+bounces-20141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GmqJC2L/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E99234E8837
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5194300DDE1
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48D3EF65F;
	Thu,  7 May 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fUqCmhA8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88A3AB275
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158358; cv=none; b=PpW3FDyK+Eryge7Db0K+FVAeaYwGihF1poCyHfLI/7ze/cLeIjiWsuwEtg0ZJkxOeIgyTODhv0g3fU3YyzB1Ssul4gDk1ionXumsAVBv322AvbNj653DyfH+5B19T41YX1Xm/3omU81ajhNcLtiNnAc9eCAjZsSz54ERIxdiTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158358; c=relaxed/simple;
	bh=yDTU3vDvTyrxBR1DIk6vRtOZfFo7VB6jCc0LkW8m2bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayDEoiU51hhbupIAdgZhawnjhhSxlsd068h9IOKPOY7P2s4Toc8gzyn1fwN3pwnCYAz9vuODjCGvay0dkIBYcsDS8hgbU31Y+PppdrgeKXITAE7mbchxfLw5bpPexkjkRJNSqOEPHesvlJt//hejcZeZs3bYV8/ecEUcuIkcb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=fUqCmhA8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so8221165e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158352; x=1778763152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9v7MbLWaxw3c9gXJACmw5XDSErWjGYxDo5t0mh5t/hA=;
        b=fUqCmhA8kRgFb2wB8RwTHQZXE1tRDWLfFAZxXYiQLdF84ITHI2PLflHJTG5BvrMvmE
         Jmkd/kukhSZjgbapK6sr2bO61O7FuurTVls02niITB6fnEOFsJ63WwTAaXMe+vCrR2Yv
         pTOF7tl5E+F8PhAEkby/Gp0oeMxz/3F9w99j/ueCtah7GUfOizSnC2MKXUqw6J9C+TKs
         sONMppSDT3C+D31Q670fwghcmhO9Tq9b3U5RuOMbax/QL3BmeITRqvP1RSVX0jeBoFk/
         2nXUNmI2oUaaVrerK9l9He5TXnJvhI9xZERT72ZIpNOi4aUfg8kJ9lDTHgW5tgvzLbv+
         paUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158352; x=1778763152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v7MbLWaxw3c9gXJACmw5XDSErWjGYxDo5t0mh5t/hA=;
        b=eRX/Pc/rA5EUs5GxgUwG6TeJ3C60DxN/kzwbdhu0p/7ku3oDqp8Y1jgpUT8IDSPZXB
         /nSiCr/sAQ5NV5UKxispnscKxqZWtJPNrrU1iRQoq7tzaJnNFbnHNOHmZqy29FSEAOTG
         vRz293MgpEvhhUPtcnyywxQ/iebJQ/6a3dlJG7bOmu4tdnKcLBDgxw8m3SrQlRiOV6mV
         4tQOR4Mqn5PpM3V4bmE/Vm3QNmjlzhuPMDYx0ACUdbllwXQXtNoOO+9P1NB2p+tQhnI1
         N6W6ru+ccM2I8ZnEaL7/yZLVShLjz8g5wgS5uPIHXeTlFZ1NBgcSAvvjwczlr/DRDLPh
         hPgQ==
X-Gm-Message-State: AOJu0YyqFqbm/3In0OKVMm+8qe8ikuVHf6N/sUwtXV06C79rpxfC1t7f
	bMx0P9t11L+N7HUY+K50Q1vxEFWY6VU2wWxk4pBreWHH7etiekcb7K+OK6M6F3+VdKf1E4c1yLH
	y5B8l
X-Gm-Gg: AeBDieuA5vPQ3LPvauzfIQPBecd7UVmtwlKf+MqUMG7+cvfT74v3LDVQ0M6ojDAK/uY
	FixUBV60dnK9K0HCTmreiJ3XCl51lsbwfimvC+PchgeXpRW+YSHiMUV/Qpfntfj2sB4vNSrfkxc
	qeqryGtnWo5aQ+BSClL8+5IotFaN0OFH9XCaPTYGV2EoQ4pTkIAPDjvIvntQKW03mj0x4F+SEGX
	Lu58PIMiF3BZvb1RS+pCsVLq6Jl5cgUogJnwg8vXuE8do145WUesa+e4IGynJ9bKtJo8NrkYmJG
	XWN/HSEoebzSaPBk1nK01GEBrJhH04c2GRn8GtT9Jlo9kRzIFyjRSE75D38qRMTEPumEu1l7ahT
	fH1PoLnbCN1lzZHnFSDjEV578CsNRmf3qmowxL2HP/Er7uFfkZbd6leaw6APEKr3nggoIzohB1z
	wBaJjRUwLGfkUjznB+3RKe868RvufEe2+IEwySQbXtdQ3iqNguHEdD5ulB
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id 5b1f17b1804b1-48e51f55272mr136688855e9.27.1778158352293;
        Thu, 07 May 2026 05:52:32 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03d59sm18415290f8f.20.2026.05.07.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:31 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 00/16] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Thu,  7 May 2026 14:52:15 +0200
Message-ID: <20260507125231.2950751-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E99234E8837
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
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20141-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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

---

See individual patches for changelog.

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

 drivers/infiniband/core/umem.c                | 213 +++++++++++++++++-
 drivers/infiniband/core/uverbs_cmd.c          |   1 -
 drivers/infiniband/core/uverbs_ioctl.c        |  47 ----
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
 drivers/infiniband/hw/mlx5/qp.c               |  51 ++++-
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
 include/rdma/ib_umem.h                        |  89 +++++++-
 include/rdma/ib_verbs.h                       |   1 -
 include/rdma/uverbs_ioctl.h                   |  63 +++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  23 ++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |   5 +
 47 files changed, 633 insertions(+), 302 deletions(-)

-- 
2.53.0


