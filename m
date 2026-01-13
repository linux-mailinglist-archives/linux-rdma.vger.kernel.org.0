Return-Path: <linux-rdma+bounces-15524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD73D1A93A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60C0300D643
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB02DC769;
	Tue, 13 Jan 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UKBkURpu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441F2512C8
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324678; cv=none; b=mjCnqKW0i3pLjeo+sysXZF2BomTIf0BB1DyCjqirbwMlU1dupdf6ecGgUokfk9lo6F3yWbN6osEfvTFyaql52aZXf1dIplnpL1uJitxGi2sGLxmPa9LJGpwUHRTdFNqf21Axvq3Epg86MrZIddD9CRvr0PbAkwCID5bSqorZYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324678; c=relaxed/simple;
	bh=8TJ+jeUePupYSPMl4pjipdGG8Gu6uaZBAk5L/V2zzT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrDlPMdhaKWESQuJZN16Mrw7ijoUgWm2z2hanIDx8M8fiN3BM3gbjHRqOsse7Nf9T/tFnfwDdZObDjhaOrfxESGbTmjXlyBw+sEysbozHCxmgQcVBRGzm2RhBcQPKdrUUXIyqtjvR/mpCrqvYmKa+EGMO/Bb1GqJDAQV8sLcErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UKBkURpu; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6446c924f9eso7305667d50.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324676; x=1768929476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zBQS164TqY/RKfewboOFDZ6ye0GmLmrOSgdu3lR5Ok=;
        b=uohKnq4eDZgg3hbJwIFe04a5n9WkNLxGdpiKGRevt6GSSYxU5YTFt/kmZOvA7AJAU0
         iGx94s68x8fSu30f0HQyzAGIl3igFNzj59XNkMt3T5+SpCa0PT3y1UgdPGKsOqVwTKgh
         u0+y8ewpkBENACvEWUQbCOpJWpshD9WY2+w57pd6HdG1TZXTuehnfqqhcn7ehko/SZW6
         GWBT0UkiijFfmg2NvoBK8LZ7SupnQFOGuRiECWENcODm/+gOxaJc2EgCgl/Cf9LcEUHU
         MRKjztjv1xerAtB1NzkqwZ8VTsuU4AgHWGh4wsatwRCuY+GhXV28nDidGbcqj3IVBSPQ
         zriw==
X-Gm-Message-State: AOJu0YwDDXUgLQCygmuUs9U5A/Itm/QXBwAoQBKxCgDQvxqNfrCe/qsl
	05XEcwsFiZ16tmjeOIm581KZ0gEO3yfxSryGy5m++nY+z2/ZUQtY5MkcKu6ze25UeBzWvhqGj44
	HM8ZSZYAH8NzSwGgLLwByTAVSIjEVOMBmV8IGFzOAGRIadwS1jVZIJcUGv90ppkN6uWDGrjE1oQ
	OJFX6XsUa5hWylKcIscC8Ql2L8goe9+MeyG68EwgB2XNifJRLdWvMVgyuLLZ2N927PdNa6u6I9o
	Xcdp7kQCMqwNYNYIiZk+BC8DWC/
X-Gm-Gg: AY/fxX7KRu11GGO6MtcT4SYr8QZfWATdHAIw5jHVPn6v3+6Ae9I1C0796x1rPCid5n/
	v5em1uRBOgtWhQzZ1TeLgxlwi/gHQJDHDbCLoX9e/Vk/mz/ol+iPUUp+o5kZAparucQYLOQQjTv
	E1WojiI6J0wQCuwc8tudlrENa5I4sAX9E4y5Uyt8Al5bopy37FWvb4VKwt3461ANfs1wuL8YLnZ
	UD3K6JyYwH7ccivDCXUNu6aN4rwC/I1vihdNVVaO5rvOrsO5EZ+I/Gwj9mNul9E+cCY7u/4o/tZ
	maaVrKYvIAjP6aVvRstJHPByFHJFV3A7MYA6iVqGbLyCMPxZhj+VFDtrXac5xrmes7aY2SL36PD
	EsmHFKxiMxxH5A7bCiCIUkgHuunAQrmrlN4cBZ+SMo3nRiOwmx+ZRElEXGJbGiddKNiZN2PSyFP
	JB6faTYz+335bcqla2DJ98ONuVp55ybvOMNSt2Hs8KSE1N3ugnqZuxTZxFUwc=
X-Google-Smtp-Source: AGHT+IEhpYdQeKXmNDLpph+tgU4G5TVrIa8oAivo/k/1eJOefslD1T3KUo/QBDzKkf5tllLKpmywhJ1VsKE3
X-Received: by 2002:a05:690e:1247:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-64716c4c245mr17681242d50.65.1768324676421;
        Tue, 13 Jan 2026 09:17:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d8a14f3sm1978018d50.8.2026.01.13.09.17.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:17:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f0c7a06eso88344425ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768324675; x=1768929475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zBQS164TqY/RKfewboOFDZ6ye0GmLmrOSgdu3lR5Ok=;
        b=UKBkURpuNtkEoubrwj0u89mwmtZ/Nb6uUIsWpfHsrDgyXRdLi8/ZlAD2r0r9HoqhbV
         nXnWQXrT6YWSniY0aMkiZKOYKUp3AxNsQLjlF+1WOGwl9fjYng5uj5RieTL2DBRcff8d
         ItF9taDC1bTONAdDvZQONXdJ7nEPL8F7eZPKA=
X-Received: by 2002:a17:903:2ec5:b0:297:f527:a38f with SMTP id d9443c01a7336-2a3ee452d90mr207120365ad.18.1768324675025;
        Tue, 13 Jan 2026 09:17:55 -0800 (PST)
X-Received: by 2002:a17:903:2ec5:b0:297:f527:a38f with SMTP id d9443c01a7336-2a3ee452d90mr207120195ad.18.1768324674625;
        Tue, 13 Jan 2026 09:17:54 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2a4sm19357855ad.13.2026.01.13.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:17:54 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 0/4] RDMA/bnxt_re: Support direct verbs
Date: Tue, 13 Jan 2026 22:39:52 +0530
Message-ID: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   8 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 934 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 552 +++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  22 +
 drivers/infiniband/hw/bnxt_re/main.c      |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 310 +++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 include/uapi/rdma/bnxt_re-abi.h           |  46 ++
 11 files changed, 1394 insertions(+), 545 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


