Return-Path: <linux-rdma+bounces-20709-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKe6B0L5BWqcdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20709-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F669544BD0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDAE03019448
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95833A007;
	Thu, 14 May 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CMXv9LDF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f104.google.com (mail-yx1-f104.google.com [74.125.224.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FD33A03F
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776372; cv=none; b=JBJ58uIEiaGLhkNmed3kMlnlbhvqAox0/lwT5EoHxwTT6M5uZG4ZvAbsoW0piv2/fS44No2dwZkMLL00nZ/1d9NqL7LiiOrB2OVcEEpQAVV47VCNhMCj2ThiDNP4L33K2ODtzdj2DO9vLN7tUBhsdtURDPQ0l3uIFMT0xjIvZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776372; c=relaxed/simple;
	bh=sktRoFzieH6qr3ORsRds74y9WUczyaIFApiprYBIJqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4UrQJ353KSfSVwSw8BVTHH3Y6UtPlxfxQvSu1tV0LM6gStRU2YpKY53Z60le0tqHyGLlU0fxFbe6mreLBazKTZDeXF+nIcQHkpbcbVjZTpt7sD/0es+aZGzsmY0zEtp3CLUPcB/gplvfFIcD3ZIVWbDuOfGkMAArxP/goHlQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CMXv9LDF; arc=none smtp.client-ip=74.125.224.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f104.google.com with SMTP id 956f58d0204a3-6530287803cso9772458d50.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776370; x=1779381170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsZABU0iyKYxPVvjrZg+J4oIuRZWEpZ0XJPcviemT8Q=;
        b=MPnDPNJAAd3uG9E6uyHDg94q70mz9MNHg3O5msheQET1n1yXpkSaOedbthJBT7Aw7R
         FCB320at+krdOzuR3rEYgMhxDzaRFIbPtx7KrqIEK9OhZTm0K6XXeLwCq/e+Bf2bYHx3
         xmjqgHWIdvp0+GxKBFE9LN1mJ4MypTtQ2tf6iLR8A4Tz3WS82eXORku7I71GfLIfNQFx
         EXATX2ykz51Rfib6zoHrkr/HnUZCET2C8Sm6BpSZgi2P8nFNZDbLkc/aXL+hZ5S9nIWI
         hY+wxKsoNOw67xKf1y7Vi8DgiD3AvnS3zQll03pTM6JHEVJv7QzJ86ph+iBS2NDSkcdM
         iLJw==
X-Gm-Message-State: AOJu0YyxmG+fSDVPwh8a69Ff8s9soi6E3Jc0fo42giyhkl7uDx6B0PaB
	rEsL1sJDFQZJeMvES3lpJS1cB+VnyWnMIhjnX4iLY1k3YaeCHlKva6uUuRehJkwQ+8tENRcbt97
	/IXu9TPBLZAHdeWvSRmjg0r4DS+ovwATKPCaGTwvoACdWLHWPiIhz1Vxl/4FR5Mhwczj60gzrIl
	JQ7IF+5tftlBb+DuNlGzyz0aaS84xFp/zcashRzswVAZ8x8KgyR2mu9kmwrUmvgaOji7jqnTTdf
	iW5zb2+O5gGn0tSf+igFzh8secjWOw=
X-Gm-Gg: Acq92OFG+6ZTxOCbxvSy35Uw5op/ioxyDWZBcHkV7CLcjWvgjkgWBULI/hLdvg47jfA
	70XnoxE3VAWjFwAYlcL7oymUoOUSC4qyITmIa8hMGmOmM44Vns1N2EEmaMs6gqqNG0scal7MDs1
	AgVTIdGoIzgwfR/9kyHv4wrV3IGPuVxgv86umveseldfVxpMT9/xmx1+yPjRIASW426qrQNBEEz
	bsZJTXs9R03EaluI2m5MA0FK6teJzYzhNUtjIMMqK/5eN4Qz/V8CVdv/g7qE1gVAi6uP3HNmlIe
	Ig+AJfBBM8PaUu+0tZKImK6o1ha6cg8cYpVYMm8i7sHt3lZ/8O4aXdUHbxxdRZBDv5+hYT0jDYt
	53cHfS1MgIwnRJulNWf6rhaE+/5TmLE/npDoBB/fw0ntMa5O9+YBchKyBZX+y6/jvv7s2Wz91US
	761th2p9Pt5c+VyzKoKnsqMk2/f2eUIh5ZLGBwFRYSzkHvWIT6q+TZDfBbW4xvnMqDRYeG
X-Received: by 2002:a05:690c:60c4:b0:7ba:d5fb:b579 with SMTP id 00721157ae682-7c6ae330d63mr84229757b3.36.1778776368847;
        Thu, 14 May 2026 09:32:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7c7f6082f75sm2150807b3.19.2026.05.14.09.32.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:32:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so7461943a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776367; x=1779381167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsZABU0iyKYxPVvjrZg+J4oIuRZWEpZ0XJPcviemT8Q=;
        b=CMXv9LDFotL1yjknKMiT93r+O+6ZE8en4swTDiPqvFc8tRNEuk852W8e6NgAE3gNQw
         7IRUC9q98HZLflzcxZm+8CNReygeeN/3JG7sSgKmnE1LWAvPRedLKdj0fRWTsr/gMpSS
         5kMqtTm8U8fU6dA01jHxvmLDyUigMNQ6UrRW8=
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-369519ffc97mr150933a91.9.1778776367494;
        Thu, 14 May 2026 09:32:47 -0700 (PDT)
X-Received: by 2002:a17:90b:5290:b0:35c:30a8:32a with SMTP id 98e67ed59e1d1-369519ffc97mr150901a91.9.1778776366884;
        Thu, 14 May 2026 09:32:46 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:32:46 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 0/7] RDMA/bnxt_re: Support QP uapi extensions
Date: Thu, 14 May 2026 21:53:29 +0530
Message-ID: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 7F669544BD0
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
	TAGGED_FROM(0.00)[bounces-20709-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
- Patch#6: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#7: new comp_mask 'FIXED_QUE_ATTR' in bnxt_re_qp_req.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update msn table size for app allocated QPs
Patch#5 Update hwq depth for app allocated QPs
Patch#6 Support doorbells for app allocated QPs
Patch#7 Enable app allocated QPs 

Thanks,
-Harsha

******

Changes:

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

v4: https://lore.kernel.org/linux-rdma/20260508085858.21060-1-sriharsha.basavapatna@broadcom.com/
v3: https://lore.kernel.org/linux-rdma/20260415054957.36745-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.basavapatna@broadcom.com/

******

Sriharsha Basavapatna (7):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 269 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   4 +-
 drivers/infiniband/hw/bnxt_re/uapi.c     |  39 +++-
 include/uapi/rdma/bnxt_re-abi.h          |   7 +-
 4 files changed, 226 insertions(+), 93 deletions(-)

-- 
2.51.2.636.ga99f379adf


