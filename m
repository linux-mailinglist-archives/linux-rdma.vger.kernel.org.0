Return-Path: <linux-rdma+bounces-16729-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKjiJNZmi2kMUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16729-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:11:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FA11DA63
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFBC03058493
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA832AACB;
	Tue, 10 Feb 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BjNloo8c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632431B825
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743307; cv=none; b=D2cLnQgKZ6vkn8DrclIuiVwVsGGVwAAhTFwtILCLEFgd/GkKvICr2y1WKFFCqC42Y8f4DdndUIJ1WKVyg0LJlOtkBJDWVoITse0m32p1oXiMOVe0pyjWOvJVmUHdK+XXFyQ03LOOGNM2x6PYBn4jxtJcGAN9tXZFOstNVYgpyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743307; c=relaxed/simple;
	bh=ZieUx864AgOEBA7L8j5gSxwiE95PyRuxJfVkUj375JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGd6YIgI0jlPODN0XgHvjw3VHddPjgYibhplIaIG3YTGRm8dUrQNLJlVmUwXrXQh70UZwCGk9E0XyAshB06aOLtDDjX3OBBqEJqDfUOVuAKlJO1TA3bQDl1FEh5+gGZjamzg0iVKIAqjgxQo7U7pdfm1Es1Uxdn8a19uyobYp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BjNloo8c; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so3765813a34.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743305; x=1771348105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKViaj5hnG2SV7FFinOAj8zkIXGMcIEboBAiEtxmn2s=;
        b=s1UgoPHqfNeTJUiAz6hJ3RF/keSnaU+dd8IRznpPP+IfRfnQUvz4TKs+TZC5VwA6AJ
         FUAwgVmFNed+G3TE6RPc16aWcvUxDbmOQCXUxmj+FrTvNWey/qTIdaYMDIGqsYjlgQmq
         YijAFt4VsUVYXlaNylWnrgbiEoa5GWvumlIY6kaKAP9OisqHFZUbXuX3kc4uvttk4jCh
         9lQZx0vKoIcCVR/IvibVIgtRt5ZEDgRo9rmQNNk8upkTBsbOR1Yw1WEdtcj3wAyIEy6i
         h77RM1G9YZOTXNnxFMoyRmfJEfJ0IUNlouNZz8pC5bBQHCi4GNdOiExmv1yY/TbAldcX
         IZqA==
X-Gm-Message-State: AOJu0Yxk5EUuij5QPWjNDwYTwfIBpg4s49c2apXW2IIMY4tizsHbpJ1X
	Qo1lHjfXbllqPovyA0H0Rnu7dsvqAs78b9KMMw4JuCSzWY+hDFjsf6yAQBh2ZHgFyeYZ8DOzzea
	Wo+s6JyiViPzidX5D2joArdNMRAtt/rVRyiyjHWWv35rWk1z/3DJqV4DA9bFwINXnvEoitWck4Y
	IdjiPNtUdzRyQ7An/geg8WuTNRdezy5VM7Xkj52+M5xkSMZCPwhRTjJEgNdNtII2dRNBimzKsKA
	Q/+GDOKr6CzDDeLHU++Wo6ew8vy
X-Gm-Gg: AZuq6aKhrb0hHdmWF960ynQHaYIPSVxMhZEY/dRXk8xN8wyAUVUk7z4RPyGPa0XzTbl
	YU6WBmTXuVFp0zzki7FOyEgbT0IBCKYnjc02oXEkYcdTXUH6JByaIBitUC7tTxto+3iA34JbpCS
	25eauI8r7KutXcEpZVKWS76f45zcLsP0tW1FJiUC2eFQk8QFhkTnW7CY8BmwecMiYeUOdAaPUJ1
	9+vGzlfAFnG8B3kDBWi7ROvkvVaHJhFjylEUn6zs9d3O4wR7QSrKwoSDwWRKmAPHHI/YfFYQWyH
	S9OF5qbtaYd7HfIrI3i5mvTTz+WqD/Juu7+C5WX7/CE+wqiWLt0765MuiU1F2Cm/zDh5XpkOU2H
	zXnlXp8dHkXnSIW9m+jKqP9njxuV9J1FWJhVSWSb1/bNqAnEymQuN4CPj1uTLM9j+dhHVdkULJ0
	la/F6KIPg8MQfs2YuCxc8TK0dpVVhokZr7mmLcxuJQyMXj4IM0ig27C7e6ttpNblpwhYtj
X-Received: by 2002:a05:6830:82e4:b0:7c7:655c:7353 with SMTP id 46e09a7af769-7d46440c23bmr8767426a34.12.1770743305215;
        Tue, 10 Feb 2026 09:08:25 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4647748e5sm3180815a34.5.2026.02.10.09.08.24
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:08:25 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8243e218869so2360413b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743304; x=1771348104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKViaj5hnG2SV7FFinOAj8zkIXGMcIEboBAiEtxmn2s=;
        b=BjNloo8cKZmdQmBrPaP5PpGw5NntsSZ9gX4k2QCJhTopFDUm3Gg1xNFZS9Qk4grmL3
         h/HBTV9JfuWhX9In2kFQ/pwEH7pweePZy4zlGhUBqgLu4a7CeCxo+tdU85Fa3oVcnIEs
         uknGaKkzPn9Ncdzv0a7dT0sc+s7D7h8eHOwrI=
X-Received: by 2002:a05:6a00:1707:b0:81d:d666:72e1 with SMTP id d2e1a72fcca58-824415ff9a6mr14931066b3a.10.1770743303550;
        Tue, 10 Feb 2026 09:08:23 -0800 (PST)
X-Received: by 2002:a05:6a00:1707:b0:81d:d666:72e1 with SMTP id d2e1a72fcca58-824415ff9a6mr14931044b3a.10.1770743303056;
        Tue, 10 Feb 2026 09:08:23 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f269sm15620806b3a.7.2026.02.10.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:08:22 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v11 0/6] RDMA/bnxt_re: Support uapi extensions
Date: Tue, 10 Feb 2026 22:29:33 +0530
Message-ID: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16729-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E56FA11DA63
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 585 +++++++++-------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  12 +
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 305 ++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 469 +++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h           |  31 ++
 10 files changed, 921 insertions(+), 545 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/uapi.c

-- 
2.51.2.636.ga99f379adf


