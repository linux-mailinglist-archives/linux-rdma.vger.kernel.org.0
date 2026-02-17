Return-Path: <linux-rdma+bounces-16934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dM2VNInbk2k89QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:07:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634714895E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2528D3014500
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 03:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B21A5B8A;
	Tue, 17 Feb 2026 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d7X08Yh9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AE1EEE6
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297669; cv=none; b=TVpBvTnxOg9Bxsp8v1cM2jytDi9s7bcTJJc7HUZpNWj/W4X+gVZFlv9ty8fi3cD40iVP44Qk3jQL9pVKcgm7LT2pC6eV9+50iCv2sTzAGWChGZyyhQsD5OaKJe+PFqSJ7mRgHoNZqYl4box9vbpSeUxQQzi9g8nfIX2B3Jr8voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297669; c=relaxed/simple;
	bh=uuU0sTsORvU4LigIP/GaeqMo9LjYuDexQr9O6OpPFd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvUjZ8gM+H8Ff8+itDVsZQgXa0XLlRcJx22T0dI4BiH8QwPPUbr3Ru76MGzlsHab3zaDQvF5gEgfNTaGjfIvcfJkx47HJyQ4phV83ybqRFmgwEKsDR19gOzPzrfs2A45aJVfb/c42S+FtGwUGZP21Luw76rhiSYcyJPJKB08S2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d7X08Yh9; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8954c9daaeaso53880106d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297667; x=1771902467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UlbyhqnSRWOX1kAUIBJqH28f6F6QZLCzsnAWpGshWk=;
        b=mvnXF7vSr0Kqk3BO/YXa1+q8h1ax2GtJt6qtgt5tHr4Np9lBJx1K1APN3qDRBKmcBN
         PUalnTEYPAHQ+eLUc2FoELWyxiTZlXa7NOXRuGWcqNsghyzwrexQR1PWBDz6YcJ6rMuf
         YAqbCwQnct+d9WMQw3IP00gX14tQFENBOVkpvfCgrmCroV4WkEvIwYjn4xVqOoaCtFds
         +sVbmOrF1hFL+KpTXimb9LPvbIdJaAtuJjv8oUI5bWV/sWakI4G9YkuoVl/E/V0Ww8Os
         SpcWjt2RyQeqzxoM0COHoRuqT/FEJkORZkZAzi3EbWFYdxlc6B+pBHl4M/+fbiMGFYX7
         tnWA==
X-Gm-Message-State: AOJu0YxXugcamo5X1DwnqMK9ym6r1KNM0aOTZbkxlqzfcPXqpsHtjAGi
	EKvMiI9ZNA7hvmSEgKGsVRj/zolOPdTK/9ZUo+kQIm4N2qhUzvdWCDkVgrkMhi7nSp1DsqYofvj
	2m2hSdeg7roUWWpeWzKRuHGmQnjttmCguBO85rkujGeMwexztnUU+osssTQuw7Uijf9/gOKdtQx
	sj0dAzYiCAs0FPYVGiZT9VkZStOIZU6tFPHCTE1ypPg53bJsN03xIL1saRqFUCW9MDdUbWDITVZ
	iVq2ZMV7jxKJBU+PGknW5wEJOvl
X-Gm-Gg: AZuq6aJANAO026oczYXe4XMDXVcdTxaTM8jpJ62RxJQ61/+A+Jxc6Xeav2lqc4EcqG+
	lcyPHQvN67nr8pjVpHh1ZFcrq+j0piwKrJsqCsUUAShx8SqWVBAZjc83QglEr+UiId1Zjd7dxn9
	MB302xfCf7xB7Jh2JJfrbwHq/7qxBz9Fe8d3MQtz6uhAAQf88QEPVkXYZra4R3/fLQEia6SmZOr
	PXTPKn2vsFiNmG5POZ+Gom74BRM/jVeFncOP+eHga+Q69+MhSC8vZSJ7I4OKc5AVU08HO4rlXF5
	xrhwXjG6XMtZ1zk2BpzS8kbRjXh0RiDbd4jmpS/ZrLtQLBRU3y8fixaM/U0uzOUwqlz8o3EVedq
	eNGC5coidZmkjdoezewVYC0k/XKh3zPq82Fn36bmPx2hZz4nwAl/kmCTCTGB1nEuRNU36SvUkxu
	3Nyv3Wn1U2ErF87R7ue4yN3GIp9LFhyU3mo1v5/DEvHluHqkqhSsP4c/qILes6VkhDZQgE
X-Received: by 2002:ad4:5c6a:0:b0:807:8020:1055 with SMTP id 6a1803df08f44-89734917cf8mr201722146d6.37.1771297666748;
        Mon, 16 Feb 2026 19:07:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cc7aa5dsm22379326d6.1.2026.02.16.19.07.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:07:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad60525deso194061485ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771297665; x=1771902465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UlbyhqnSRWOX1kAUIBJqH28f6F6QZLCzsnAWpGshWk=;
        b=d7X08Yh9Wy5y1pv2JWCwxNuO66i49H3IyOJZ6+YrCeGGWfSs5srhcNX7yfFrV/HKzd
         nJS7UhVmglKWe/QZaeOygoIgtZFyQd0Mj3WQbYgQpHARgVBEPwwcQcQwkIbPAksCMZs7
         y2darb4u/W9Hk3sB2lOm2A/BDeC5PvIpcMIUs=
X-Received: by 2002:a17:903:46ce:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2ab4cfbc9d9mr151066775ad.26.1771297664629;
        Mon, 16 Feb 2026 19:07:44 -0800 (PST)
X-Received: by 2002:a17:903:46ce:b0:2a9:4450:abbc with SMTP id d9443c01a7336-2ab4cfbc9d9mr151066485ad.26.1771297664021;
        Mon, 16 Feb 2026 19:07:44 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm20688167a91.4.2026.02.16.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 19:07:43 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v13 0/6] RDMA/bnxt_re: Support uapi extensions
Date: Tue, 17 Feb 2026 08:29:04 +0530
Message-ID: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16934-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3634714895E
X-Rspamd-Action: no action

Hi,

This patchset provides uapi extensions in the bnxt_re driver.

This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide uverb extensions using which the application can allocate and
manage the HW resources (Doorbell, Queues etc).

This patch series is based on the udata helper series here:
https://lore.kernel.org/linux-rdma/0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com/

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support doorbell extensions
Patch#4 Refactor bnxt_re_create_cq()
Patch#5 Support dmabuf for CQ rings
Patch#6 Support application specific CQs

Thanks,
-Harsha

******

Changes:

v13:
- Patch#5:
  - Split user and kernel CQ creation paths.
  - Required by the new CQ interface series:
    https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-0-f3be85847922@nvidia.com/
v12:
- Patch#6
  - Added a separate comp_mask enum for req_cq.
  - Renamed cqe comp_flag (BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE).
  - Pass comp_mask flags directly to the validation function.
  - Deleted a couple of debug prints.
v11:
- Patch#1
  - Rename dv.c->uapi.c. 
- Patch#3 (DBR)
  - Renamed abi enums/vars.
  - Updated commit message.
- CQ patch
  - Split into 3 separate patches (#4,5,6).
  - Refactored functionality into standard CQ functions.
  - Renamed abi enums/vars; deleted dv functions.
  - Updated commit messages.
- Dropped QP patch from the series.
v10:
- Fixed comp_mask issues:
  - Driver returns cmask capability in ucntx for CQ/QP.
  - Driver checks req comp_mask for supported bitmasks.
  - Driver returns -EOPNOTSUPP if invalid comp_mask.
- Fixed zero initialization of req/resp structures.
- Use PD object from QP; deleted pd_id in ureq.
- Deleted debug counters.
- Split CQ/QP changes into two separate patches (#5,#6).
v9:
- Added a new uverbs patch (#1) in RDMA core.
  - Supports user/app allocated memory for QP.
- Updated Patch#5 (cq/qp) to utilize umem dev op.
- Updated driver ABI file (deleted dmabuf_fd/len fields).
v8:
- Patch#3:
  - Removed dpi_hash table (and lock/rcu).
  - Renamed bnxt_re_alloc_dbr_obj->bnxt_re_dbr_obj.
  - Added an atomic usecnt in dbr_obj.
- Patch#4:
  - Registered a driver specific attribute for dbr_handle.
  - Process dbr_handle during QP creation.
  - Added refcnt logic to avoid dbr deletion with active QPs.
  - Reverted dpi hash table lookup and related code.
  - Removed dpi from req_qp ABI.
  - Added ib_umem_find_best_pgsz() in umem processing.
  - Added a wrapper function for dv_cq deletion.
v7:
- Patch#3:
  - DBR_OFFSET attribute changed to PTR_OUT.
  - Added a reserved field in struct bnxt_re_dv_db_region.
  - Reordered sequence in DBR_ALLOC (hash_add -> uverbs_finalize).
  - Synchronized access to dpi hash table.
- Patch#4:
  - Changed dmabuf_fd type (u32->s32) in ABI.
  - Changed num_dma_blocks() arg from PAGE_SIZE to SZ_4K. 
  - Fixed atomic read/inc race window in bnxt_re_dv_create_qplib_cq().
  - Deleted bnxt_re_dv_init_ib_cq(). 
v6:
- Minor updates in Patch#3:
  - Removed unused variables.
  - Renamed & updated a uverbs method to a global.
- Minor updates in Patch#4:
  - Removed unused variables, stray hunks.
v5:
- Design changes to address previous round of comments:
  - Reverted changes in rdma-core (removed V4-Patch#1).
  - Removed driver support for umem-reg/dereg DVs (Patch#3).
  - Enhanced driver specific udata to avoid new CQ/QP ioctls (Patch#4).
  - Removed additional driver functions in modify/query QP (Patch#4).
  - Utilized queue-va in udata for deferred pinning (Patch#4).
v4:
- Added a new (rdma core) patch.
- Addressed code review comments in patch 5.
v3:
- Addressed code review comments in patches 1, 2 and 4.
v2:
- Fixed build warnings reported by test robot in patches 3 and 4.

v12: https://lore.kernel.org/linux-rdma/20260211124927.57617-1-sriharsha.basavapatna@broadcom.com/
v11: https://lore.kernel.org/linux-rdma/20260210165939.41625-1-sriharsha.basavapatna@broadcom.com/
v10: https://lore.kernel.org/linux-rdma/20260203050049.171026-1-sriharsha.basavapatna@broadcom.com/
v9: https://lore.kernel.org/linux-rdma/20260127103109.32163-1-sriharsha.basavapatna@broadcom.com/
v8: https://lore.kernel.org/linux-rdma/20260117080052.43279-1-sriharsha.basavapatna@broadcom.com/
v7: https://lore.kernel.org/linux-rdma/20260113170956.103779-1-sriharsha.basavapatna@broadcom.com/
v6: https://lore.kernel.org/linux-rdma/20251224042602.56255-1-sriharsha.basavapatna@broadcom.com/
v5: https://lore.kernel.org/linux-rdma/20251129165441.75274-1-sriharsha.basavapatna@broadcom.com/
v4: https://lore.kernel.org/linux-rdma/20251117061741.15752-1-sriharsha.basavapatna@broadcom.com/
v3: https://lore.kernel.org/linux-rdma/20251110145628.290296-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20251104072320.210596-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Support doorbell extensions

Sriharsha Basavapatna (3):
  RDMA/bnxt_re: Refactor bnxt_re_create_cq()
  RDMA/bnxt_re: Support dmabuf for CQ rings
  RDMA/bnxt_re: Support application specific CQs

 drivers/infiniband/hw/bnxt_re/Makefile    |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 680 ++++++++++------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  12 +
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 305 +++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 469 +++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h           |  36 +-
 10 files changed, 988 insertions(+), 578 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/uapi.c

-- 
2.51.2.636.ga99f379adf


