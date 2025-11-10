Return-Path: <linux-rdma+bounces-14361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C2C47646
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF833AD5FB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D2308F2A;
	Mon, 10 Nov 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L7lPs1dB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FA228CBC
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787030; cv=none; b=kDJVKChLqI3BcGWpjHQ22zM6m0LQK9gu5sIVDAeC3v62a5UFA4Mhyf//6uPVFy28uMojhUTzGB4NhM8qHJyONHijLCuxZBv7zE+0a/VargETOBUx5sVbE3SZCadjxGK7UWF+00YBadJge55QnytzfGQG3b3TBS1QmkeVq8SfFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787030; c=relaxed/simple;
	bh=miHmFIsXhaYaZxG+6QWGHWcy7oOTsqt+ebruuQhYgBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jj8QpwtBgMjb9vDmH1RFa459r5vwDjzXGEWdZXvr9tku5zmFbbWUa5amg0HMUVsGCHopNvxWXjCDn5oR+DA7AjaAPBr77DtR1R1oTY+XILXnPQ8w7V/nBk43mdv/WCeXd2bgw1qQwMeGkEY1rNUtqemWzEY8LGy/gXvFMIvsnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L7lPs1dB; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b98a619f020so2763307a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 07:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787027; x=1763391827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVNnAj0mqJD4SH0d2KSIWfy/7DtS6g0Oi5XVR0ozGVo=;
        b=fD14RyDaUrwrWfzMSyo7YNHXTMUoDYfJG2etTwNYrheR4v9i6YLEa84npeJdfhJ3pA
         1GLCexEZskpqO1vJM6H5Bk+eXvdL8kfTVfsODxVy1TuR+lcYP74yF9Lqkj8XyqUBONpI
         41xWYCXQ8lG3tZlgW3F7YiB0FW6+jcgKblEuvbiupSIfGiIxhNX9D/ElxRn4L6JsU674
         LzSFbK93CjLJ8qk+AntQF4XtwF0H49v4Fu5q3xr+AmhBVBXrL2TbBThpcZ732hIk9Kct
         ZoeVUpoxaaCzEatpolFxFPOEp3OdNV4FI4x3hE4ttItiQBE9q12S0zGF/fvDQ/kNHDLH
         LrHg==
X-Gm-Message-State: AOJu0YyBIfXnugfoZbVH/5JfTqql3QNP4o2d+1Miak3HtUWHVWekroR3
	6vosgGvlu1urTyf4aPd1Gmtjw3YxDzo6pGZ0rU0VQnNYEwiatAK6JTvvTq1reEwP9YM46QJ/FwL
	Rrs7ljelUoBMXDGf36fk9ByMHSUJeGIItI15+Hz5MNyIqDTmgEV7EIuXU7nzSdWh2h7mBp2aSFe
	+K0I0Ka6hvEk/Hgd7eS78XcvunRsxZx7Sqq7fBuZqYx4NP2jIizV9O7ZNQqOtsOWlwZe/gXOWX6
	mLU1S421y3IqPcYhXh+spmeuJP1
X-Gm-Gg: ASbGnctURLZCOCh3geTsekXB2+wxTw4TGn68pMVEMi2P7lCBdF1WB5E5wP+eyldUeE/
	xwW40xqJkZxJFw+5bRjWF6JFd/Yzeypf/NqGUypBTyAIiLngiqK2wOVPCNPBfEg3IDJZV/GuhmJ
	6nYeXoHTiQSCXJ4+03+63MDqffMoEdNtfrDYX8yWLgYaXnrC57HO9ftBulmo6UUwfOUYYA4h/XY
	+olKojaI7CcrQyw2YqOKM/aq9SsWEh7cJwAlISYIbSsJCfEorhWLzrF6obGjChznd+A3I+aH1bc
	F4VZuRL2dpHyUxdPLc4sh6GOMHB84PE1Ns+hANlfb//0qxOr+32za4DX3ot1XB8+ZRkfyJERV88
	iimnJIQncGZKC8s9WxnP6T27lHU/mrZ4XWB/bd014H3W26OzlgEVT0r29CdYzzDZc2YgOQJZrux
	ygz9haKK/WHMswtA0KioYZKQYRi3eHuSCFGH+c9ZvWykYx/A==
X-Google-Smtp-Source: AGHT+IHi6pSxdkiOKt8vsKu7upiFM+0tZ5yrmkJoFCGbwVIzhRiQBs4O66Ioh1fAgDqdz/5v5n63k4g8aAtQ
X-Received: by 2002:a17:902:f644:b0:298:250b:a547 with SMTP id d9443c01a7336-298250ba936mr37743145ad.56.1762787022812;
        Mon, 10 Nov 2025 07:03:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-297dde373f3sm8888045ad.4.2025.11.10.07.03.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:03:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958c80fcabso86999805ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762787020; x=1763391820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVNnAj0mqJD4SH0d2KSIWfy/7DtS6g0Oi5XVR0ozGVo=;
        b=L7lPs1dBpdN2hR5eqci5P4hGJdvcnjQ3SFQZaq5bOWWRFliB9NHGYXHzBDnsRo/d3a
         Y/Z9DNr98i9/swYm4zj8ojvG0CNV0R0PJgrwDyUmgUNj8lYtXV7yER4BEE0jPhbFmWUU
         RD81M0jPtIktts+JwZ/tzSRk9xcc6FAU8aFmU=
X-Received: by 2002:a17:903:3846:b0:295:8c51:64ff with SMTP id d9443c01a7336-297e56aeb63mr114897865ad.29.1762787020195;
        Mon, 10 Nov 2025 07:03:40 -0800 (PST)
X-Received: by 2002:a17:903:3846:b0:295:8c51:64ff with SMTP id d9443c01a7336-297e56aeb63mr114890325ad.29.1762787014157;
        Mon, 10 Nov 2025 07:03:34 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm153216885ad.78.2025.11.10.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:03:33 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 0/4] RDMA/bnxt_re: Support direct verbs
Date: Mon, 10 Nov 2025 20:26:24 +0530
Message-ID: <20251110145628.290296-1-sriharsha.basavapatna@broadcom.com>
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
Patch#3 Support dbr and umem direct verbs
Patch#4 Support cq and qp direct verbs

Thanks,
-Harsha

******

Changes:

v3:
- Addressed code review comments in patches 1, 2 and 4.
v2:
- Fixed build warnings reported by test robot in patches 3 and 4.

v2: https://lore.kernel.org/linux-rdma/20251104072320.210596-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20251103105033.205586-1-sriharsha.basavapatna@broadcom.com/

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/hw/bnxt_re/Makefile    |    2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   12 +-
 drivers/infiniband/hw/bnxt_re/dv.c        | 1662 +++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  547 +++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   23 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  |  310 ++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   10 +
 include/uapi/rdma/bnxt_re-abi.h           |  142 ++
 10 files changed, 2219 insertions(+), 542 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


