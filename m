Return-Path: <linux-rdma+bounces-17373-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCG1IvNvpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17373-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E731D738E
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D4C7300E5F8
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090835AC38;
	Mon,  2 Mar 2026 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QUIXrD8q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6F3314A1
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449764; cv=none; b=Yu3H6L5KabFDNt3PhLGiZDTxl50ubNg6bkGNY38WPZvhgeaF4LMHRaN7tLTT34ranHTXMUldnI4KDqW+sbKbnRd38PCJZUb93UshSPP6ZPFPeWfES1dNjos4f2QsSjACl4XR0bhJEiJvbB8hDUH1SGLz3PfrNupMrocp9LUaWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449764; c=relaxed/simple;
	bh=wzoTzDZfR74LHJe4IlH48WnnSgNz6KxCjg3/UXWp6cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pi3DErsd50mlap/Dthe0feGs3LMnpm7OYz9B5XOJdyvVzVGMffldNx7ykwPziuwdwK9/7VbTcVsyGAbKb34l9L1q4S4At4hvoQ2j9FhcL1xY6IxJanmdQGWguyG+SItOM5LCgSd3T30wKedZzfx5BCZcKyzm6lor+Av3iZbgmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QUIXrD8q; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso29536115ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449763; x=1773054563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3mtYoZnNth2yhl0G7Nmm4KUyLYSKPenHEGd7Pp2dSs=;
        b=fBtowE2ZY9q4c/kCpFkW20nrvFvs3VFMszf0fKbaHwTU/1SAU9KQs4H1mhSD7CYHGW
         WMIdytPSxRHTy5TGP51dq2gh0+2x2M3gxSPKRhjj/bibGvTazRCdM8rm6FuGa8XZVCqT
         MMpCl5Sj7QVd35lQ2sQJwod6jssjInNSB6UJMBwJDVfJIz39kSpAV5agrqPRRpAHxq16
         8ZZRjEHF3w8SFIrzlhJaUSm24aUlRaZAR0CgL+IRvna7olWk+6TAQsmltz4MJ8Cmnkqv
         Q38yc/yxA0z27UEZdi6g/OkkjvW4LeRVtjev/ai7/6QQPsCZZB4D9zLvHU3mCqeyz66N
         rqDQ==
X-Gm-Message-State: AOJu0YzqLMK4mdy7MHCvMSkGXwCHG6RTcd2Y86KCTM78VsJThjaRgJpV
	FTfz/mAb0oOFSMT49COwVOfNbcoH+LWhXGPXbMlXwk51yNjBshnrIkcSJ74vhI+wSMqpy3NVRpg
	b/AG6cHHaApXAEaBdxW2cMKAvUt7Om60E9pQrsXjTBTQU2B1ere0EjKnIF4M6hAIs1J1TpBvNxD
	ciablG5sJ4cz1LsmlyWC4JUHoUO13qvT9lUYeISVLhau3SLffXwXaaFua5WjsYU1W3NUYSQp73B
	LsI474jWF5KsTyHAQLeOYlulTQp
X-Gm-Gg: ATEYQzyUT2zA+FO8MDa80cv2MOl42M8sYNWVjNA4WS5Ty1ut3P5faVOBQbZY52Ggmhp
	9z4OXmLRkeltf7jc3Tt4s1CliKWrlvYc1Y05jc2inTnnvr10XTsAtpguHvBDLNBQ9OtvQgApC9U
	dG4kWng+LSXc1yGLosSSpLi0NNpRxRWrxqHdNw9W7whgMVsIIprYy+QAp6Iyw7vwVQmS1byU2rH
	/j2IlvG3QZHGhWA3HcCZU5GYHzlG1QNkpYZEZBBeeDg8khvXy9DYbAmU+K5j/ZIvczxT5UTAmmL
	YAJ9+iMS/bHgImwH1f5R2mZeuJnhTWYGSQMcbrAGKrXKaumt+aI1b7T3SwCOtcrerG+oJM+f0jx
	6TWz2NtuZCbuBND6lDiiUbjKoU7Ugv1e1XImL3n1Pzcl6Hlls5Az3bD5ozdEai63dqBhmVInMwZ
	K8vvKAn2CUBcwrgX4Co9YVvQwIOjbnwPqE4TI6fEa7EWK7kML5AeM6DUZJx0YYqbWQvg4OnOk=
X-Received: by 2002:a17:902:f60e:b0:2ae:3a74:64e3 with SMTP id d9443c01a7336-2ae3a746645mr70433835ad.10.1772449762484;
        Mon, 02 Mar 2026 03:09:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae491cd7f1sm5815865ad.41.2026.03.02.03.09.22
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso40131485ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449760; x=1773054560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3mtYoZnNth2yhl0G7Nmm4KUyLYSKPenHEGd7Pp2dSs=;
        b=QUIXrD8qfPYiqAuSIo5BPd2WcLEqQa+51LwFcBGVc4xIR8XQRdXx4+8xokMCeKJVpP
         J68gsKU/KTrP18Ch9e70FFTimJikB9gtMfPAYk7yvTfZUIa3xncoGGJSJHANlaHGonS6
         0tsq0p43SNidTuFOmGnYyrfv95QaH4MAaTdKA=
X-Received: by 2002:a17:903:2304:b0:2ae:4c76:14ea with SMTP id d9443c01a7336-2ae4c761807mr38538955ad.57.1772449760382;
        Mon, 02 Mar 2026 03:09:20 -0800 (PST)
X-Received: by 2002:a17:903:2304:b0:2ae:4c76:14ea with SMTP id d9443c01a7336-2ae4c761807mr38538695ad.57.1772449759797;
        Mon, 02 Mar 2026 03:09:19 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:18 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 0/6] RDMA/bnxt_re: Support uapi extensions
Date: Mon,  2 Mar 2026 16:30:30 +0530
Message-ID: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17373-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2E731D738E
X-Rspamd-Action: no action

Hi,

This patchset provides uapi extensions in the bnxt_re driver.

This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide uverb extensions using which the application can allocate and
manage the HW resources (Doorbell, Queues etc).

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support doorbell extensions
Patch#4 Refactor bnxt_re_create_cq()
Patch#5 Separate user/kernel CQ creation paths
Patch#6 Support application specific CQs

Thanks,
-Harsha

******

Changes:

v14:
- Rebased to the latest rdma-next branch + v2 of udata helper series.
  https://lore.kernel.org/linux-rdma/0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com/
- Resolved conflicts.
- Split user/kernel CQ changes into a separate patch (#5).
- Updated Patch#6 to the new create_user_cq() devop.
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

v13: https://lore.kernel.org/linux-rdma/20260217025910.15865-1-sriharsha.basavapatna@broadcom.com/
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
  RDMA/bnxt_re: Separate kernel and user CQ creation paths
  RDMA/bnxt_re: Support application specific CQs

 drivers/infiniband/hw/bnxt_re/Makefile    |   2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 688 ++++++++++------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  13 +-
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 305 +++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 469 +++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h           |  36 +-
 10 files changed, 990 insertions(+), 585 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/uapi.c

-- 
2.51.2.636.ga99f379adf


