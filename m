Return-Path: <linux-rdma+bounces-15651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A05D38D2F
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EFAB3024255
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB52314A94;
	Sat, 17 Jan 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bMHXx8Cf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6F286400
	for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768637339; cv=none; b=Fz3mJcwXh4PC+OXRocknz6OU4Gdii0qQM/ctMD0jWqlwT/7hoPywhNAFreh+1TVNxWI24AfMCZiELCgU819n26sMEWugWoEXOB6SlatY6dBKCxwsP2SmGWanXEgMpdxrq1j9VClvf0tamSF4EmYZ2Z2c41EfU8ASqoFNg+4IiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768637339; c=relaxed/simple;
	bh=gaNmANuJkIdQql/i8QF1sqrWWFYC9/9hrFBDtFM3FFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPWNrd9ZdfBDM8SHg9ELnrRXlaa/oyeucvm06B+qhLsl+Ez8AUggWKJ4CgSuVxxOmfyHMwC59TQctkk7w8X0Z/MoUXfBJ9cytTUq9JAYG3ekzOFnI/5leoEnLOWl1kUt8JisthDEW9i+3bzi7GFxk2N//zIocXYVXN0jDaflHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bMHXx8Cf; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a09757004cso24760545ad.3
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768637337; x=1769242137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chjj4KECsdraHp3KJ11M5y3DUBmnDXYBuBomkNAmUx8=;
        b=FPUhToZ6ghHUP+AZz6F/jNJ4kxZY9AoPIaN2wjkWXqzPtQd/LRSdVd0vlwMM/eBQrG
         p+DcKg59iVq024BWqMnxwxV3iCrcUd3ilDq7tlLcqPCmenERVU8omuMJ79fenzcpbwnF
         9dmK0bs0olQOmTdSEyIbUCYNIjZH/Z0Zn/Cj1V03YdYuMbkPVWGiXtxbsff1Nwt9Y+gr
         c5mRjN3wNTT1d51QWfRzsJDnu29tPWO7qDrGgnjCUD+GsIePRbXinYnxGVYoZKsrw06y
         WEeduozzqRftuCWrMOePV5hH2nO6IVzqfxZQw4dRAb0rO8m8Ll/GIKraLP9/NabfaMcP
         aU7w==
X-Gm-Message-State: AOJu0Yw3Qa+hD8HWNzNRtL/y+yUYxFbacwefwyUEFIM532KlxUMdlSNd
	9qcYW5JZBjY5m9pBP1CBnS8ToA09H+Fsn9CmMPl1mKvckRATaSXbTUdf+8IcZogirE5ZSwOyImu
	jAIugjETBFJyhztYrubdb95BjF+pt83GuEONl0jf3bgKnyFPrxlURO7nKf1ivwRtzXTqu2TvBiK
	YWDMjm/fxKnDCK7RtAfoRE4/4WHpd+lhbfFs5rtEI+PGnfQOstol9lVUv3iATPjysotwlnLicGq
	d0cieiOuOS4wsjGoSaENC4OPS1N
X-Gm-Gg: AY/fxX5B/rgcZgJZPwDrpAs0AaatZAO85uY8m8fzpKpR5tkAXy0rK9A4S8BYbwOUM8J
	D07d1gu06fZ+bHLFGt5B0d8AAfQk9x6Rh55JnqO4+a0O08DK0ZN457qHR/W1M5HJew/sf7TXe3w
	9fCQdO8s7f/DwT967O0TLrTZsL7sCcVTHRFK8bnYjViuBTtZiYhAW4B4qlXpt7YYtdrjTv00s+t
	DM4kAtVSNqvw1pok1vmxigd9gfypRvoku+WLrqkbqf2bZcvNY8glJSt7Jhhw1Gz4XXqB0XBNq3m
	W33Rrfhf57TUsmAjhEO+kWHusPZdzkZgeEeN8VGIJB1RgjxkkQ9IC1Dv17B/vOwO9EGvaLTWlAy
	UPfogG6RqJF5BChe9StBoZdMprTmmjIjawId7oExyZyZWL0jxKEjGfdJXzrM7uodUffBb36f0pJ
	PGT/+qpq4BrRpq1j9tyQVrc5JMHFhYYgCggKb9SDeBXGz4iuJvKEZU4q4jQBI=
X-Received: by 2002:a17:903:2451:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2a7175bc919mr50354965ad.42.1768637336903;
        Sat, 17 Jan 2026 00:08:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190d249bsm6457285ad.23.2026.01.17.00.08.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:08:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f39ad0d82so5604310b3a.3
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768637335; x=1769242135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Chjj4KECsdraHp3KJ11M5y3DUBmnDXYBuBomkNAmUx8=;
        b=bMHXx8CfgdPPtnar9sQ3khHYQNfBaJd1ay57wG5wFcAbaXbcoIR/NzbD+Nr1WROynV
         2e9fixNmxBdxA889LSqT1a/MjgeSaBOdTbZNayja0/IXKjrlhTCGVPOpj7w4Cf+oDVX/
         AO3gJTyh850jU5v8/biFFkrOBQh5wbYqhymSU=
X-Received: by 2002:a05:6a00:8c13:b0:7e8:4433:8fb4 with SMTP id d2e1a72fcca58-81fa03c99a3mr5723672b3a.60.1768637334959;
        Sat, 17 Jan 2026 00:08:54 -0800 (PST)
X-Received: by 2002:a05:6a00:8c13:b0:7e8:4433:8fb4 with SMTP id d2e1a72fcca58-81fa03c99a3mr5723655b3a.60.1768637334536;
        Sat, 17 Jan 2026 00:08:54 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdafdsm3833819b3a.15.2026.01.17.00.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 00:08:53 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v8 0/4] RDMA/bnxt_re: Support direct verbs
Date: Sat, 17 Jan 2026 13:30:48 +0530
Message-ID: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patchset supports Direct Verbs in the bnxt_re driver.

This is required by vendor specific applications that need to manage
the HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide Direct Verbs using which the application can allocate and
manage the HW resources (Queues, Doorbell etc) . The Direct Verbs
enable the application to implement the control path.

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support dbr direct verbs
Patch#4 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

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
  RDMA/bnxt_re: Direct Verbs: Support DBR verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/hw/bnxt_re/Makefile    |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   6 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 952 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 552 +++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  22 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 310 +++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 include/uapi/rdma/bnxt_re-abi.h           |  49 ++
 10 files changed, 1411 insertions(+), 545 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


