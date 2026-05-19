Return-Path: <linux-rdma+bounces-20975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sISjNhWADGo1igUAu9opvQ
	(envelope-from <linux-rdma+bounces-20975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:21:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565658153B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3640B3080672
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BC3AFD09;
	Tue, 19 May 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQbY1yF7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f103.google.com (mail-vs1-f103.google.com [209.85.217.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE83AFD0D
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203401; cv=none; b=dmXEMB/DPRyhIg8grGCib+BD5F6sJiSww/FLvMsl9lUjr/CGupo8tu+KNwhyLNGl5zflR0U/dAu1XlUcb1IIJVRx60vpqnjMwXIVJtGb2UHhWqBVrGOJqHe4YT/ty/e9e+h+tV7NDgG7gR7I6B7ciZ2uFzgEix8zeRMasLBVCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203401; c=relaxed/simple;
	bh=4YlMb/qGwHwlKPPTkDkLxbznJgaB0nxuJDpHEdZy3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYXyGHqVuhaU6exwMzV9VDM+DciEYnTjdEduo5cic7ZH+/Liwzq21l2MJs3SXVxNjruvekJipDuV8rfKuYA0jtz4LDa9NqHvfykW3hAvfcgJYzapLCgcjDCX0fdX0k8s8mGK29Wja4aeQEk3/mAMbjA4qs+54MB+Dilk4RWQ3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XQbY1yF7; arc=none smtp.client-ip=209.85.217.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f103.google.com with SMTP id ada2fe7eead31-63270abd14fso1112080137.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203398; x=1779808198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/H/RKE/d8dpx4JUeq1dzhZ/G1iNaRKLAArGz7BAB14=;
        b=EqzyWaqqtRyT27+vV2UgI+nlJ58QHS+rsAdhIgpblUZFDFzcO0oZqN7SWz9oUUE3Y+
         8OZcBXjjWJCbRaSuQxMungZjHveZH2tp1iDqHQyXyQjBvLw+//OtmWLP4W5XBZUzAYPu
         7rOVb2Ijf2D6xnkH8reJLNbFuSKs75obUR9/wae2HjWVPrtuvZIL6AtUe4gwbHydn/1U
         6VtCtOqMnj78XTxqQ1zW14AxQz82Ol2DDLKzaTq4kDSWyn0rri3y/Y/+MkqRAVg9E5eX
         stG4sRmKMlUxd9qij4Fd8Tgfn4vJP8LpNBmGW7ziD5Px6HlxlwL7i9yeOxhWiZiZ2WxD
         m40w==
X-Gm-Message-State: AOJu0YxrmAS36/f3drionoEvvldW2OoXUhipe14LBq4m28PeqdZlaO/J
	oXRE9QA51Pru1Yw5t7etFCbdqv0fUaZRSNE+LsSuqRLbSnoztSz7w2VIxNe/PnKHsJzZ+hNMAvu
	/AF0OQxMn9utsRFU4hsocURLJU30DP/6sNP3OWD+U+bmfEAJAQmJoigxI0Q7HzmIcuMfsPlMqmR
	TNTrUVMRI0Aj+vmdTSn6rSdfN+9rpquJN4jBELJGiGsa4Jy3Aipx3IjA7Ipy3jgefdA8J/4+Zz6
	84Sd4K9uA+xb6OA+WEC0iqcRmrVSXc=
X-Gm-Gg: Acq92OFNwRKj8n53AKTbEkxOLs3oLx7ZYWWSzTSLHdogerx85u1ZG+u7S9lAiZ9Phhe
	WvClqk+1ll2JVwIcGl/vZyEenmrZC7dD6OcutgVJHOxSpOTUtwdR1r6NYc2KsqpNAXRhzX9TwiP
	3zdCz6GhrxOOJERwtC6H0nGwRRKqhelgFhfLriMwXzwDjZH8Y16He2XzEsIi9fnpxBS/NIM9yUL
	O8ZCtQ9Pp7bqbtX/Pk/0Suv3GxuWON6oRnND73kSL9kB69/oJkZnzAEDZKOnP3C3qfoQWySleK/
	cikt++4908Ucg86MwHMHCpEzeqL6JzUGTIgrJJEZsyY3Hsb5NpSZ919EPs161L0a+QUSByYbZuC
	7FVizfEZmk65TUlRBqENIkafrJZFJoDbFt/uh7yUY97gcCJMD0TbVJhgp57FTZy6sUqsFhewr/b
	cBUsKOWpjs9No08LXt15RAtQEl4SNBAw8mgzrMJrZKG4nYx8FQej9leYMRHborxibHwCj7
X-Received: by 2002:a67:e118:0:b0:633:a4bd:5b28 with SMTP id ada2fe7eead31-63a403b04c0mr8278064137.30.1779203397987;
        Tue, 19 May 2026 08:09:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63cd19df5dfsm939504137.12.2026.05.19.08.09.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:09:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso53632145ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203397; x=1779808197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/H/RKE/d8dpx4JUeq1dzhZ/G1iNaRKLAArGz7BAB14=;
        b=XQbY1yF7seulaUx8gDylKgwcYhUIfEquQChWrlop/46CEsmgVOe+hYbO3ZYbwAASCe
         jjPS60DJCdul7v1c7SEwjwUReC/oxeZH3HxqBVGUEnNOIENNL/HyHXktuw23RPzZxw63
         MB6NmcDJwWtt2cZvt+StsCvUe/SHBUNWkhUqQ=
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr144692865ad.3.1779203396862;
        Tue, 19 May 2026 08:09:56 -0700 (PDT)
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr144692615ad.3.1779203396387;
        Tue, 19 May 2026 08:09:56 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:09:55 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 0/9] RDMA/bnxt_re: Support QP uapi extensions
Date: Tue, 19 May 2026 20:30:32 +0530
Message-ID: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20975-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:mid,broadcom.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3565658153B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset adds QP uapi extensions to the bnxt_re driver.
This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

This series supports application allocated memory for QPs.
The application takes into account SQ/RQ ring sizing constraints
(extra entries, rounding up etc) while allocating this memory.
The driver should avoid duplicating this logic while creating
these QPs.

uAPI changes in this series:
- Patch#4: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
- Patch#8: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#9: new comp_mask 'FIXED_QUE_ATTR' in bnxt_re_qp_req.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update msn table size for app allocated QPs
Patch#5 Update hwq depth for app allocated QPs
Patch#6 Enhance dbr usecnt logic in doorbell uapis
Patch#7 Enhance dpi lifecycle logic in doorbell uapis
Patch#8 Support doorbells for app allocated QPs
Patch#9 Enable app allocated QPs 

Thanks,
-Harsha

******

Changes:

v7:
- Fixed an issue reported by Sashiko.
  - Patch#7:
    Restrict changes to DPI allocated by DBR_ALLOC(),
    by using a boolean dpi_valid.

v6:
- Fixed issues reported by Sashiko AI.
- Added two new patches: #6 and #7.
- Patch#6: Support kref for DBR object (from v5).
- Patch#7: DPI lifecycle changes.
- Patch#8 (QP-DBR) requires these two patches.
- Patch#9:
  - Commit msg updated: removed unused comp_mask.
  - ureq->sq_npsn validation (from v5).
- Remaining issues are about lack of ureq->sq_slots validation.
  - Existing code; will be fixed in a subsequent patch series.

v5:
- Fixed issues reported by Sashiko AI.
- Patch#1:
  - No changes.
  - Issues are about lack of ureq->sq_slots validation.
  - Existing code; will be fixed in a subsequent patch series.
- Patch#2:
  - Removed unused ureq param in bnxt_re_init_rq_attr().
- Patch#4:
  - Issues are about lack of ureq->sq_npsn validation.
  - Validation added in Patch#7 fixes these issues.
- Patch#5:
  - Updated to utilize existing code for RQ hwq depth.
- Patch#6:
  - Moved usecnt relase logic to after QP is destroyed in HW.
  - Avoids race with concurrent dbr destroy.
  - Updated usecnt from simple atomic to kref based counter.
  - This handles implicit teardown of dbr.
  - Added kfree() of dbr.
- Patch#7:
  - Added validation of ureq->sq_npsn.
  - Removed unused ureq comp_mask: BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS.

v4:
- Rebased to latest for-next tree (Linux 7.1-rc1, commit: 254f49634ee1).
- Renamed QP req comp_mask: APP_ALLOCATED_QP_ENABLE -> FIXED_QUE_ATTR.

v3:
- Removed umem patch from the series, that is dependent on uverbs support.
- Patch#7: Process DBR_HANDLE attr regardless of app_qp comp_mask.

v2:
- Rebased to umem_list uverbs patch series:
  https://patchwork.kernel.org/project/linux-rdma/cover/20260325150048.168341-1-jiri@resnulli.us/
- Deleted Patch#9; create_qp_umem devop is not supported.

v6: https://lore.kernel.org/linux-rdma/20260518153721.183749-1-sriharsha.basavapatna@broadcom.com/
v5: https://lore.kernel.org/linux-rdma/20260514162336.72644-1-sriharsha.basavapatna@broadcom.com/
v4: https://lore.kernel.org/linux-rdma/20260508085858.21060-1-sriharsha.basavapatna@broadcom.com/
v3: https://lore.kernel.org/linux-rdma/20260415054957.36745-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.basavapatna@broadcom.com/

******

Sriharsha Basavapatna (9):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
  RDMA/bnxt_re: Enhance dpi lifecycle logic in doorbell uapis
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 273 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   6 +-
 drivers/infiniband/hw/bnxt_re/uapi.c     |  49 +++-
 include/uapi/rdma/bnxt_re-abi.h          |   7 +-
 4 files changed, 242 insertions(+), 93 deletions(-)

-- 
2.51.2.636.ga99f379adf


