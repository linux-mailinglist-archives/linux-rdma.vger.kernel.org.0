Return-Path: <linux-rdma+bounces-16390-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFujJgCDgWlNGwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16390-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3589D491E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF7B30069AB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFE2F39B1;
	Tue,  3 Feb 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yplf2aBL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F86192B7D
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095356; cv=none; b=ZOrjPovLopTuTz0pJ6/hK6QCHwgU0dAx3XIT8OJeghkQWq1pgwK9ywY/VYWtCEGe1GY8zkKODXn0dOZ3dneF4FVZMkbVuO/FDG52x7CMSaochcj6OdvZTUCuFdRm1Zetu4rKRo798xhkSS0+6ybPOWjErGyoys1ocuCm6iti/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095356; c=relaxed/simple;
	bh=pR4L2rMeyfFKqF0KqSGmPKUoSYc82N9Bk06IH/0c1R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eoRoPLUCenUC03WWWzzYtGGJBNe4kon8NGCBTVhXTIgQD7KqG3/SPL9jfyk6osnEWg3s6KpqsZVN66Tig8HJCTr7JRBIk8nPSdbrPbTjBGc1qJ0meM88vfczeEucvp6umy2BLQZ8CmHxPQ/zrfieuyX0EI0ni1zj/mVdKPcXzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yplf2aBL; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c65822dead7so2062432a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095354; x=1770700154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W13QsJysAuhzPW1PDBgh2Vqmo6mJ2keoagDseiZ7L0o=;
        b=fQufqN1tPg+KJffwHDsplwKBVUU0Wy9/jDQ8mbJH294Vh6hPp7yq/X3KS41n1LD8JU
         ih3Sa80I3TiLPg9keG1Ovc0KFBc9C1LgtFCFHXimD2y8LgBZpmIqvYikFdcQCdTy0JQ6
         4WarCt+KN32x/yz2vraS2Tw4kbatVdU4Szx+qP8hFJa852DUmUHE4tjusDMVGzudTdfj
         +KCJAwsAz0uk2+HQqHSXPRDNvHmsQrJj2ZI1nrsjI7Az3WGDGnOBZD6AQtXowptu50dd
         RbhdezMEMzTwggcuNKceDpgnzm7koJRKASO6MX2ZYrvY6jxofJY4e/eC5vXmgXc8Tk6L
         iRTQ==
X-Gm-Message-State: AOJu0Yw+JHoKQFMg+pFet1ry8d8RgN2FmNd6tc3wqQQzDJp9o/PQL2OE
	0xS9J+sjntTnRcOeiyXLY/yJrv0ggzhZ2eP5rnNw6YMjMFWb/sXdKfilJeELsYSClJpjxRsAplM
	tB5TuIxvyTVG1367OV5yoQX+Gy8uzUdLZf8FOjcQ0S1Y49kJRZgS5Gp9y6LT+52RiHgx8vdxX1i
	MCFo1hpw9oj0dIit/RPKXC/cCyPKxgIDiTxrz6SDP1Ba/QO5akpnLGbWHdoT3x1o2oq802fsvCd
	qWCmpaOZ/h5CKzSHRcZdFGlNOxE
X-Gm-Gg: AZuq6aLWocOyHGETXE+Qd3Zjf1g+EgjkbYuftRg6tZSd5t2hPzZ6vnU2wAU5hsBe9Zr
	fpBhX8+1qZWh3PLQr7foGhnBhUxo0RHmeeO4fAaY9tkGD95+QAMUOEouyXGClDphOpSGkkjvDaF
	WSh1PIBo9wUZTNespM5yVtMpUa/UMu6xyvCaI4XvABMJMMySsfpv9i0dayhQrih69r29p7uOPD0
	GIef7KE4tPp727kfbpwRBGQU30EmTqb8WCsQckh4nmjXGSjfzHBvFLuf5CQj3mQDJpF0i9GEviz
	UMFKGNn68P029bSdECHN3HivryRFV4oYFZMCSknQiBhcGfVNoORz6c52u+SHPIaAnqhEphNSW4r
	jfYTKhxoUHX25QD6PsGTIoPl1hFRo08jYijFgNx4CRoFVK6qZYUW+SUNXSX88BgAGji6lS5D/Q2
	pLZcGbMKKhmlYho9RRSzQ8P8KbJWcjqIzkWf/Jni0Bux11BH6KeOF5hw==
X-Received: by 2002:a17:902:cecb:b0:295:54cb:16ac with SMTP id d9443c01a7336-2a8d7ed87e3mr147213125ad.18.1770095353935;
        Mon, 02 Feb 2026 21:09:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b4265d6sm24177035ad.25.2026.02.02.21.09.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 21:09:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c68b97b7316so1506217a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 21:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770095352; x=1770700152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W13QsJysAuhzPW1PDBgh2Vqmo6mJ2keoagDseiZ7L0o=;
        b=Yplf2aBLkm/9hWjcE9bi2msXzAq1yr6KuIh6wVAZrK6YgZa0M6J5xCdJDgwYNFTkZ1
         Im4ogPOuXIIWyUf1Pd9dXz/e7yFhjim9uuDe2AI9y/Db/gjtrhaxmf4zTVj6KvtLSjwc
         wQpqr1FUn6wj+ciWF4f0JgSfJzFjNgh4KLPho=
X-Received: by 2002:a05:6a21:6490:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-392e0145956mr11849567637.54.1770095351784;
        Mon, 02 Feb 2026 21:09:11 -0800 (PST)
X-Received: by 2002:a05:6a21:6490:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-392e0145956mr11849550637.54.1770095351418;
        Mon, 02 Feb 2026 21:09:11 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547b1306c5sm621948a91.15.2026.02.02.21.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:09:10 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v10 0/6] RDMA/bnxt_re: Support direct verbs
Date: Tue,  3 Feb 2026 10:30:43 +0530
Message-ID: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16390-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C3589D491E
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
Patch#5 Support cq direct verbs
Patch#6 Support qp direct verbs

Thanks,
-Harsha

******

Changes:

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
  RDMA/bnxt_re: Direct Verbs: Support DBR verbs

Sriharsha Basavapatna (3):
  RDMA/uverbs: Support QP creation with user allocated memory
  RDMA/bnxt_re: Direct Verbs: Support CQ verbs
  RDMA/bnxt_re: Direct Verbs: Support QP verbs

 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/uverbs_std_types_qp.c | 157 ++-
 drivers/infiniband/hw/bnxt_re/Makefile        |   2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   4 +
 drivers/infiniband/hw/bnxt_re/dv.c            | 906 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 666 ++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  32 +
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      | 305 ++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  10 +
 include/rdma/ib_verbs.h                       |   4 +
 include/uapi/rdma/bnxt_re-abi.h               |  44 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |   8 +
 15 files changed, 1623 insertions(+), 569 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


