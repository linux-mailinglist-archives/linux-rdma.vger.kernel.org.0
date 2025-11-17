Return-Path: <linux-rdma+bounces-14522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E12C62808
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 07:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6B33A818B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2F313E16;
	Mon, 17 Nov 2025 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d7mWdkz/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EEE155326
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360696; cv=none; b=dO/U4c/uApSXs3NHXVs/SDqgB1aYefTnU3XBN+6H/VrJg/9F7a2tx3rAAG0tpcH7S6m/nufVR01YgVTPLLLNRPEjt5V20oMcR81ViPgf+yglIYplG8yVGarza/Sg/VAUEnc+QOWDD0xYBa34mra3WljUdVPa5/8vvNUs+wXbKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360696; c=relaxed/simple;
	bh=HUP47Es81H6j4LH5sqZhMMYBlLJmbYX+nudLKYfk9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHUJTA6UOJevaTvH24fXG9RI1FeAih9wnhCiP/3mqtryywBqbXiAWkKBu/yE+7PLz/hd5NdPAX5eSYjN8BDvLwfMAXVKhiDBjC2mYz2ITUbP7OjgkNoNhlie7Ppo1MQhAuqxyFL5q2O9oQIhgZEBs2BF7iSOMNq9Wtaz2dQx2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d7mWdkz/; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-3e7e57450ceso1157157fac.2
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763360694; x=1763965494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9mrzZZg3uMsx/6KZOmg4pIac7UI5nNwmAUi/UZ5Exg=;
        b=aqDui/CDcRv+PhFPfVbzHP0HfwTM8Qe4Uy/Lje6X+RRi3skuzPMajtQFy4fwBQ81qy
         3GMGx0Zm1grWnYkWpLdAp149QLezrmcIaiPVfZjpmmyFv6gt14mmB2F6ZsN6mXoUQj4F
         59ewn+j+sU0KtjahvoFAGfW2ebVm5M7WBmg8I0SC1UrpkizZsz773VNTluUPBa+1UW8R
         aD/isPVZbpL44DypTp0mHCLC3wiGG12sus0apy544J1BUWZZGYPfGRld/XV0KXTTdohJ
         Q7QW6jrMrcLCWiFdqn1Ku7WWRVQ8XSyYtBOXeQS1QlBdjR6JRzLLF9YuHXTxne39M6tg
         P2Kg==
X-Gm-Message-State: AOJu0Yztm+js6cVJ9t5ofvr203r0hDhWV0EQKH2JYm6a1CwzviOA1rAF
	0BEu9wTNEHC+qAtwRY6QEtGmF44WOKXRu5usN6XN2P/ziKj2Cxx3zfYoPSmXv9aYT3THHUXiUWY
	TBy7BwYPpEXyzqMfuOPrYqHa2ZZc7mHoRzX1HeRma/x8UXmeKIns0MWSymBTTfFqMeUNZI1Dkxa
	emsxy0IFmbcAzyK5UHfAEQmDjPMOXXQiMbOiThikOkTOpSNNlNE08j766A4PlAqg3yvVp/PdjlD
	XT4S6oemv1Drum19RfGiBhuK4ak
X-Gm-Gg: ASbGncuAOnU49OSyEukWxw6VIAjsGAZ/AhMY50LBD7In1WS5LuIhY6mPmKveJBWC8gr
	d2+VnEn3I0GnVwKgXy+E166DNy42z+Gpisgly7Zid/QEQfwaiMzplW8+vC9a/5N56K0rtBBspOw
	Q7p4iQMcNvxpI6jP2ASNaAxK50P9HMt8xsuV1Z4i+4jncvoc43gLlydo+1VTHt7HR5YdGvdolcH
	Q00qDv7DseZ3OBfN1D6BwAVMpfKHdykapG2gjW0ZPY24aEVPRy5NTN4Z57VhDyQtzBPezYNzzy/
	x7/ZrfwNAiiK6rwbYskfllyox4CmYeVVkbt63tpN8ie3s8Df8D99bKCjQE8DGhWIE0V4i63a+iB
	K+0q+9cDxwpDYYeQPRdHe5Yz+ONaHYLShVEq3Ly6yvVpW9kdgBVi87TdyqfR9Uj30H5wPVj8rey
	27r7WlB/IYUGV9FnIIyfsSoNwBF5A7GvLqTuchT58GoQ8mqMHFU3ZOAlkzyoc=
X-Google-Smtp-Source: AGHT+IFXVPJolK35SgeCWcGc4iwy0uKsbioazRir4Vr7RIwtrw6Cx16FQbM0qiWu/Wzc9RQbx6wQbutYV+MP
X-Received: by 2002:a05:6870:1610:b0:3e8:9e31:7fbb with SMTP id 586e51a60fabf-3e89e31a40fmr2649456fac.35.1763360693873;
        Sun, 16 Nov 2025 22:24:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ec48dcb934sm131641fac.15.2025.11.16.22.24.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 22:24:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9208e1976so5385083b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Nov 2025 22:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763360691; x=1763965491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9mrzZZg3uMsx/6KZOmg4pIac7UI5nNwmAUi/UZ5Exg=;
        b=d7mWdkz/mKTjebIOoeUKSpTA6p/RfNYt0MOixhqYjcNG76EWNHiXPBo5yMWzuK+xdZ
         tbRCHxiHy1jkmlxqYTPUM1bRFUzBELbbTddbcz9TmPR71BS3n+xbNlFzYYe/0qs9/VtH
         ucOiNZVmVGpIUjYjNXDyAbiCAGG+BmQeEixzk=
X-Received: by 2002:a05:6a00:2d19:b0:7b7:8aad:99cc with SMTP id d2e1a72fcca58-7ba39b38900mr10050423b3a.3.1763360691509;
        Sun, 16 Nov 2025 22:24:51 -0800 (PST)
X-Received: by 2002:a05:6a00:2d19:b0:7b7:8aad:99cc with SMTP id d2e1a72fcca58-7ba39b38900mr10050401b3a.3.1763360690995;
        Sun, 16 Nov 2025 22:24:50 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm11897785b3a.40.2025.11.16.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 22:24:50 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 0/5] RDMA/bnxt_re: Support direct verbs
Date: Mon, 17 Nov 2025 11:47:36 +0530
Message-ID: <20251117061741.15752-1-sriharsha.basavapatna@broadcom.com>
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

Patch#1 Add a marshalling function in rdma core
Patch#2 Move uapi methods to a separate file
Patch#3 Refactor existing bnxt_qplib_create_qp() function
Patch#4 Support dbr and umem direct verbs
Patch#5 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

v4:
- Added a new (rdma core) patch.
- Addressed code review comments in patch 5.
v3:
- Addressed code review comments in patches 1, 2 and 4.
v2:
- Fixed build warnings reported by test robot in patches 3 and 4.

v3: https://lore.kernel.org/linux-rdma/20251110145628.290296-1-sriharsha.basavapatna@broadcom.com/
v2: https://lore.kernel.org/linux-rdma/20251104072320.210596-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs

Sriharsha Basavapatna (2):
  RDMA/core: Add a marshalling function to copy from userspace
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/core/uverbs_marshall.c |   73 ++
 drivers/infiniband/core/verbs.c           |    8 +-
 drivers/infiniband/hw/bnxt_re/Makefile    |    2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   12 +-
 drivers/infiniband/hw/bnxt_re/dv.c        | 1407 +++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  547 ++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   23 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  |  310 ++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   10 +
 include/rdma/ib_marshall.h                |    4 +
 include/rdma/ib_verbs.h                   |    2 +-
 include/uapi/rdma/bnxt_re-abi.h           |  142 +++
 14 files changed, 2045 insertions(+), 548 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


