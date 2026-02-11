Return-Path: <linux-rdma+bounces-16754-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXNOeF8jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16754-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D712498C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BA9B300463E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BA369204;
	Wed, 11 Feb 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fplv/2WU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A41946BC
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814682; cv=none; b=j+eleUVxrbmtEk4c50S6ItDEsLHs6rmUpCrsw+WDO21DJjnwYmibi48OLl+h7qZYLFdPGRGtF/P85bwDwQFvKIi0XhvNr/uXcpEfDlq+V45SLyWtYEKE0kfZdWOGfKDTOvhcbb4++dpj3nHKLn1F6h7ga3pdT/TAnCAGvLp5bHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814682; c=relaxed/simple;
	bh=buNka9Ju1ouuVvRcw51JqdhWGIlKVzpsLIlYbr8+9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBoRRYIQCtnqn9DVbSkxxJ3uH05ArOlj/nCwofSDJASj3YJlXtFpUjDBMNVMcYC1MswveIMCgTnPp6Lj0oLbYeJT++k58bzO86xWqFjxg/l19nf5RkLgg0BSN0XYHZDBytOktHYMskvd/FaWkvqpZ7CKj70T53vXDG7PpaFQ26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fplv/2WU; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d1890f5cafso1875365a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814680; x=1771419480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVfExJIti78yroGjS6glX6Rbvk8S4UMnxaOb+n9/+hI=;
        b=Y4JTfzysYBKvNHx8Wtjm1wXExBfe+0aoOse6rVPMDnWjGUaDhlY+VSyMJcusr4XgxK
         5yRy92BNNhrj2SZ+adHPUkYssDsefGE8llQAyX78Wpp3AFQtyed+/tjobM+JKKuoyOb9
         vIPBH14AdoihIH9sm264M/MB+v3eYv2g1qNQAav45Q2lFcs2EtcjaXh83GShqgxthdfD
         5g1/x99A9bheOTrHSFz7v9if/iWyfFqkpaHDeCsQn7/ilW4QyV7pZ8X/qNMioP5Sspd3
         cYPVa5G3ZUxKuAhZWTSdKO6sWYGTSWJu7XMhK0QdzSZLxp2MqrvDRCKblQvYiAoq2Was
         Y5lg==
X-Gm-Message-State: AOJu0YxvjS6aj6iL9TLosPT/P83UufHj/hEu6ZpJRtevXHgN0vhsn+2k
	/O9qz2JvsJr4BwJCvY2p0VkYXF3ghF3eTP+BivYsCViIARcRc424RnTkbxnsB6aYjhFRS8OHqk4
	JLrLXviXYOX3pzoJOLk7Pexdgri/92KOl/sUH+AwrZFeMvp0lpFnqud9g369gYzRhZ7ZyT9/evu
	B0i+2OKBTET/O+NeEvvcxtuR6dM2tsKkv83P94s9qo3fTlup47e1nncD89u+4DygU2y8OV1Px8i
	clEiE32DDK16+q4df/eTXoIQAcS
X-Gm-Gg: AZuq6aKzAgc5wxaa4iWVwhahD7p2kdS//e1u3Ibb5S73Ow7TFGcZNmcXWncFU+IOeo3
	SsHjt+5X++L08Fa7wqHG5THY2hunPYs0W2kAjcnCPiXEOpThlZv9KOYjnEPXuWmy3fJApyzzI3A
	f/pNSDIH0lZaIMPvDTGvSIbgbkS8GoGV3wxGSaNzW0n2qNoWVH3GaLxyAzrpXYD62Oj0j253qsg
	53UNlVEIl/gZrBzyLMyTW/bDB9ZysWBPCbhgyt5eafCv4CFx0fgSekfYrZ6J2+9M3l19XR77woa
	z7gAoQrcuOkq7OM/PmSaf8JltaYFjyzdFrnPRjd9fNaUxSfbCOnPe6e70dxiJYxmVA+4nUpQ6QX
	8WBaOGD1SRCli5j6Q9KpDa9VeEDiko2joleU2oQ1FLyH/kS4N6YQL/8lRjGa7PnLFNp009djH5l
	AItUIvHoCSk0Cfh8KTzSS8dTr8ot1sePa+8wFtuyTiiClKGhkhY+Rb8ZFqKwgAEf1WAUdg
X-Received: by 2002:a05:6830:6ac5:b0:7c7:5458:75f8 with SMTP id 46e09a7af769-7d4a57ac333mr1147084a34.29.1770814679865;
        Wed, 11 Feb 2026 04:57:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4a75cfa5fsm278644a34.6.2026.02.11.04.57.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:57:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6de2c762aaso5762384a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770814678; x=1771419478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVfExJIti78yroGjS6glX6Rbvk8S4UMnxaOb+n9/+hI=;
        b=Fplv/2WU838CPVhTTghkTgf6iEkf01TbVwWQ+BacsuhrbvpGhjDgv7GFR+VPkVluYf
         HO0bbL0SMJDzSIB2wLbrIYIk31mzyBg1GFz48lNNO63xFOqCdM8g9MMt8C9SvM2WmN7a
         Rj8Ox3HRtYZxxoccTaFvRNfYjm2LeRxjS1vpE=
X-Received: by 2002:a05:6a21:62ca:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-3942e644454mr2509608637.47.1770814678303;
        Wed, 11 Feb 2026 04:57:58 -0800 (PST)
X-Received: by 2002:a05:6a21:62ca:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-3942e644454mr2509592637.47.1770814677852;
        Wed, 11 Feb 2026 04:57:57 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm22206515ad.79.2026.02.11.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:57:57 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v12 0/6] RDMA/bnxt_re: Support uapi extensions
Date: Wed, 11 Feb 2026 18:19:21 +0530
Message-ID: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16754-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 005D712498C
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 574 +++++++++-------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  12 +
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 305 ++++--------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 469 ++++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h           |  36 +-
 10 files changed, 914 insertions(+), 546 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/uapi.c

-- 
2.51.2.636.ga99f379adf


