Return-Path: <linux-rdma+bounces-20913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGpcJw42C2qgEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:53:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 649FF5705E5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7650306938D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3492261B92;
	Mon, 18 May 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O/yveKa9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1A48096B
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119206; cv=none; b=lGFAMYijpduRBubQSvRdl4ixeoa4T3owC2pHv/6A0BJO8zVm7O3da0fhQKMxGZS5NxfmB1w8qzjgryHlkUG0qZRoInRRN4t8zN7Pl8VdNol9CHkDcW+JlDR3oYV9wRPs5Bzp3D2B4RPInPl2KJvW01hoQKtDbGzeYDNcQtlNx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119206; c=relaxed/simple;
	bh=cyWxq1LD91n+xqDbn1SzZHjU8rQZoGM4OpZLJqdPvr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgBkxwyrQ3hrS7XKC13/IKyrJkrP9MTRzDfCd3wcJn5RgsX+sFHkgb35CvLwXH62C8W3YtYagJUXWiWoQWFwnRfLMMCD1ZS/2NMBVQirFL6HVOpqkU+wWQyus77EUzIzYcDihnlxyfy/diYjEJVL66jJF9259jm33Y067NkbDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O/yveKa9; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2b45cb89f7eso15893895ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119200; x=1779724000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MWwyI4XNO3zV/ZNeuZwl7ae1dksBSvGbIrWbaSgkrA=;
        b=KHOysgS/eHn2qMexOrUrVY8RNfrgqtTbyIHBH9aPotECkQ43e1YR4P002VZCWerDBd
         +MVWc5+ty5QjU7s/o9DhjhGsKA6wcA41AHvo4ueZpZo9FN9irU/GX3Fo/vp1G+USXrOc
         7eEz6+uGs2+/nI5Uzl/edyJWefOk/W0rI9zBEOTyYAT1+kSKPxwJ895CwEzC1ASYolXO
         SurCLoIQdJe0Wpehc8YHFKlT1mUyAk/kofVfHg6entPHcZK4gJax9nXtRMWKhhmA0hej
         fsAAmbBuBwqpNH9CK3iq2jVCRo3iV/ZhMvU6HhUW9l4VTi3zoWrL8jPUUVQTm44V5Ywq
         HCxw==
X-Gm-Message-State: AOJu0Yzpp7wwygzVlzfaSkQj636kfhu/Osx8VKskizU7sXr1yhW365Ew
	affXONPqCkB6VM3OlU0TJ6hw9khbEmiD1DkiUwYghXoYa9CTYWeRobyA5yB/EcXkF0+9lClftSa
	Ibk0rDkhnU1mq4Usq5tRxoseTxv82ZiLtBQ++VWpejzkyHK/lsrlMuoDzkdXpPYMudBZCGgXn/b
	xYwDuWgiH04rVkeEVQftg2bydXZSvg1Q6GIUl2CUGrWiQpYIBfPs+xCcPkSzvrMqX07RTGcFs0p
	dn6pvJnzkvkbmJe0oWeE8hrOMO3HgY=
X-Gm-Gg: Acq92OFMTgboWcRZfsWJghTI3EU670D89R65P8TdLX03Xt+OYMMI3VWrjHJEIUCH5S8
	86EVMxXqRcqbk8lyxMRPJJGacBubfmDKU5+OooiDu5MVqsY+xqokB7hGgALQ0BAGqFsz4B312/h
	+X22s7gWPd3WFk9UuVdJTwOSckYH0ETotV4s+P3jqpb44c9Dvvtw1ffbYzt0qSlth6EXJKg/VWb
	giwxf+pifyI6RoDIaC5WuGy2pRzBE+eRzyj8+gcmFjFTmGUjQTUlJv35QIZySvWGALcH/q/F3RM
	1zJJ3NK5caKUH9Q6WJP/srwGO0aoi6gPV9I9wrjCPaQIDksH+PN20Rotcy9utFwswYk/YIA/gJE
	lbA7GkZBSYtUN8gvxj4F6m+W6lfrYv3w7ZSuz9aDsrr5b3UjH8E3UImxCA22QGdhdPpeB+g8mt6
	vq6fzlVhKonyn1BkMkLHzUNfmZUgv5aNdaIda+UoyrxVTyFrXVgIbUf7lymxKQTv13HOLD
X-Received: by 2002:a17:902:868e:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2bd7e88f4b6mr110706725ad.26.1779119199987;
        Mon, 18 May 2026 08:46:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5d0f7361sm11406885ad.54.2026.05.18.08.46.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:46:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba15e384c7so17190465ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119198; x=1779723998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MWwyI4XNO3zV/ZNeuZwl7ae1dksBSvGbIrWbaSgkrA=;
        b=O/yveKa9GUbZ+MEMii6c0cvj9X/uuJmb1WFBVpNhqYEo//QiCyI+mlFSKfkKAoiPsR
         hd+40e8edI14AVKAyuGaWZLq7x285ZC+bRy839R38jgID5rWbQKP/CdnvrWKqZp1MaUg
         W/eBqtYUemYcLXMNHS6DKm0vrB+GgUmgwlQPw=
X-Received: by 2002:a17:902:ef11:b0:2be:1eb1:eaf7 with SMTP id d9443c01a7336-2be1eb1ec68mr18495735ad.24.1779119197569;
        Mon, 18 May 2026 08:46:37 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:2be:1eb1:eaf7 with SMTP id d9443c01a7336-2be1eb1ec68mr18495535ad.24.1779119197085;
        Mon, 18 May 2026 08:46:37 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:46:36 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 0/9] RDMA/bnxt_re: Support QP uapi extensions
Date: Mon, 18 May 2026 21:07:12 +0530
Message-ID: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20913-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 649FF5705E5
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   5 +-
 drivers/infiniband/hw/bnxt_re/uapi.c     |  48 +++-
 include/uapi/rdma/bnxt_re-abi.h          |   7 +-
 4 files changed, 240 insertions(+), 93 deletions(-)

-- 
2.51.2.636.ga99f379adf


