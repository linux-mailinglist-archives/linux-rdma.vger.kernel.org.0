Return-Path: <linux-rdma+bounces-16064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAa0MvmVeGnmrAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:39:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D7792ED3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A46330193BF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFA341AC1;
	Tue, 27 Jan 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XilVKr9Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A76342148
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510372; cv=none; b=Td7MG0U3/rJv2LZEhTz7/1a9MNe1/Qyf/taUoNRk4lTEGTi8QRiOuViV5X9VH2cx4Aqcdh+bQzQCVDdybOd8N6dK5uk4wAeKV7hDMklW7eB518Bjy20IUKmlW/zAtIW2BpOBi0CeC7pVTLEQGqiQq2HkJfKWF2NbE8r9Y5cT6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510372; c=relaxed/simple;
	bh=/c/SIY6z0Ywjcglg8Hmfde+1GXdN4ITZvJS005Xzc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcp7stmVn3WUPlQ95HiSCCd0ECUygEO2/HIlVrMcRXaDjzUFPmE1hi/7GGuK5c8DVhCbPFZmowE/QP+tr6peys6lD6HzKjm0kARhzJrdssUBtgq5zYSz/luiQS9FXq1bDAO02m4O0XByIU3acsMnMLbd+ozPIcHlND6zPwiysdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XilVKr9Y; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-40946982a78so75732fac.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510370; x=1770115170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdcaXTVu0PiDDHEnCFPakMCUntEUymtyrHTLVD2CMY8=;
        b=RUa3w9tsOQU+OY4QnLdUEdByNBUdxxeS1RybCiYqMlB8xN2OqeQCPYSl3NAnF9gHc6
         zQ9aXYaCh/MUkePr+a30loJSMcGxn3odFIWWxCzMSCF3Gp1dV9KpaCijLJdYEx6zNupF
         3QkKq/0Cmu2ORi9r/HkUHrf3TuOzw6Y/v6nbibGxSqk8isB6Ae3rri+IPds2bi7KOUdc
         hakjVqR4XrDZmxlFj8j/3z+XbNtxYp6OMzYqmLpNdN4fT2nGhiwDZhcwPv9BqHU+Ewb6
         H5nB98A8iOULzJ6hIERC0rcCr9FsBzE2BDZk/YXtaMxiBCwuPyEe9T1vWEUPttGLqe9y
         ZAmA==
X-Gm-Message-State: AOJu0YyhqSuTUM/YOHLXeCpyP1n2BKuRXBVxFteiSfpXCk1GpyrtAKUu
	KGY9HcxnEqxFVhZJEU4MI8EclBkIFjS5eDlU5Ee8XtOs59MU0vuq24kjFFAFoFwh9IPrkB3CL9S
	4oy5gFLHe2YI/nvTMknfNk3KR9QCdAeBzSdkAt8zBvpp8+3sXJB2ZxmhgUQPxopy3KFJOVy2KDd
	MFXw9Fe4Vy9qsuFcPRaTmGIQRBTeYQc7JgsYEeNdI5FRY7a22Umh+qJcmyfTIlzLG+xqXJexFCJ
	pGId2td0aBZgy/pLnEemJQrNMy5
X-Gm-Gg: AZuq6aLZ/GA6vnmNBki3rp+CWDcdbUOIl6Io+HHkgPTL6gTRKId4U4r0jm0mJp8epiQ
	Gxnsb44SlGNhyZCq0ZZpGJ9+7a6DVyBctehMJGs0g1e/D2jCjTeHqVfqOe2lAiM0YNFWy2vFhbo
	K+hni1swjG0NDHvoATqNLvrnyH6SMKw7oUgpkCNex5ZmBc7FIXql+pTawzh3Jlxa4yNaTA/QByg
	POehnQ9wbo1xM4ElKXwIddZL/3CQoog4WNyHtanLfzBaFGPE1N2QmkTE0PvJXNymMw+V7zsrMnH
	LhopjTZusY4DdlYLnjhAvGKeVB00rQuwXXb40ORUzs+ADrVwdewufOZu2Ukhj4yX+jmueLLWMR1
	PKPmAUe6AQWXoOgyeLkZ3mYKxsznMNi/7uA6rnD/P2ZTWQyBC+trVtWtG3IgVMOWR/fBWde83M9
	GTNClUYwFL22qWkS28vS7EmGO71PFn+uZKpdWJorSeY5BBtq9PxmUpguAe
X-Received: by 2002:a05:6871:6a10:b0:409:463f:7fb4 with SMTP id 586e51a60fabf-409463f987dmr355906fac.38.1769510366832;
        Tue, 27 Jan 2026 02:39:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-408af888d2bsm1323565fac.5.2026.01.27.02.39.25
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:39:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a13be531b2so55610995ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769510364; x=1770115164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdcaXTVu0PiDDHEnCFPakMCUntEUymtyrHTLVD2CMY8=;
        b=XilVKr9YXifioXpJDXhh+yNEaMPGhTTcRjprSvukKJTX5pEJDOIrGDub+EXCjOjAfr
         23Tv0HchzNzht4qKVW7V3KPbaJXqSWfQBuSOxtzOK0ZBxh9ukMHaUpn1NbP10aG2Mzkg
         ss8WMmvOhC5Dq1Z53Zl6KnG62EptTLu/voHbo=
X-Received: by 2002:a17:903:1249:b0:299:e215:f62d with SMTP id d9443c01a7336-2a870d57808mr12714205ad.5.1769510364080;
        Tue, 27 Jan 2026 02:39:24 -0800 (PST)
X-Received: by 2002:a17:903:1249:b0:299:e215:f62d with SMTP id d9443c01a7336-2a870d57808mr12714075ad.5.1769510363626;
        Tue, 27 Jan 2026 02:39:23 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa792sm114502875ad.19.2026.01.27.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:39:22 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v9 0/5] RDMA/bnxt_re: Support direct verbs
Date: Tue, 27 Jan 2026 16:01:04 +0530
Message-ID: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16064-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82D7792ED3
X-Rspamd-Action: no action

Hi,

This patchset supports Direct Verbs in the bnxt_re driver.

This is required by vendor specific applications that need to manage
the HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide Direct Verbs using which the application can allocate and
manage the HW resources (Queues, Doorbell etc) . The Direct Verbs
enable the application to implement the control path.

Patch#1 Uverbs support for user allocated QP mem
Patch#2 Move uapi methods to a separate file
Patch#3 Refactor existing bnxt_qplib_create_qp() function
Patch#4 Support dbr direct verbs
Patch#5 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

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

v8: https://lore.kernel.org/linux-rdma/20260117080052.43279-1-sriharsha.basavapatna@broadcom.com/
v7: https://lore.kernel.org/linux-rdma/20260113170956.103779-1-sriharsha.basavapatna@broadcom.com/
v6: https://lore.kernel.org/linux-rdma/20251224042602.56255-1-sriharsha.basavapatna@broadcom.com/
v5: https://lore.kernel.org/linux-rdma/20251129165441.75274-1-sriharsha.basavapatna@broadcom.com/
v4: https://lore.kernel.org/linux-rdma/20251117061741.15752-1-sriharsha.basavapatna@broadcom.com/
v3: https://lore.kernel.org/linux-rdma/20251110145628.290296-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20251104072320.210596-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Jiri Pirko (1):
  RDMA/uverbs: Support QP creation with user allocated memory

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_std_types_qp.c | 157 ++-
 drivers/infiniband/hw/bnxt_re/Makefile        |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   6 +
 drivers/infiniband/hw/bnxt_re/dv.c            | 916 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 663 ++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  30 +
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      | 310 ++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  10 +
 include/rdma/ib_verbs.h                       |   4 +
 include/uapi/rdma/bnxt_re-abi.h               |  44 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   8 +
 15 files changed, 1628 insertions(+), 578 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


