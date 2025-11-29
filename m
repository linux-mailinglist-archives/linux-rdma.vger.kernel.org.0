Return-Path: <linux-rdma+bounces-14824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A77C944FE
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 18:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CC8D347067
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Nov 2025 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650CD217733;
	Sat, 29 Nov 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1igAvtG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B963238D54
	for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435725; cv=none; b=gm3CawoopOxgGi+sQHpy93y3Dc6+n1eu743YIUeJjD6HeP1iuvHH1OOAy6IPHf1xloiQoPFlSY6r8EY+MqNdoe8L9me+9rLJCKYyLz5pwSpZtj79G+YgWv74nG2aQEVlWTGGom90z7458TxEy0y7E4fT27Ack/DTcqTGptjKZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435725; c=relaxed/simple;
	bh=ESolznQjF2nJhJa2th6SIL8uNYyIzctp3rJSdR7zOSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdfCVGAAz4EisME3P3Iv4aPg8UgzpjBcKgs5cOZw1+BNYD8bdGgYdJTGj2nsMNrRzK312Q0F05IaqZOKaQTtokMq6SiZNGqE3jfHFm8A6EeHo1fJ8wdSA95NWpBVOAUtijnaOtrEu3hIK46PeYb5EalspDADR8GiEz9cvBjxFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S1igAvtG; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-298039e00c2so40227825ad.3
        for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 09:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435723; x=1765040523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Itz0sM7J6D5CRuXD8v42KtoQUwP30o1kFc+bZcaiTeY=;
        b=Mzsn8wQwW6E5iiANGYYaLsF9v2nhsj4nxB7sevDJgvJw+ohwj3neHZzXBMHsPii5iv
         O5VfnYulWFcrrrDplBmciOB7xAvOGFRcPkAYLkWv41kkFXejWOmK8gDcq+TLhJE5sxi5
         /q1W84YsjhsKgI8LWILeWyHpc/0IEU/3iMWSTRS4CLCF8n0+SYu8k2x2aLZEp5kTqs9O
         AsJXccO4uUDQ8IqELUrnBPZlMH5pzLiWE2OEKdV4cExk+ZqkZzaF81hhyNPSq0RcylzE
         uKJDxHpLSDyS2Ybi4DtZHM9+rftUCWbUClO29Gzd6OEiQZI1veCdhW8zic3KjJGdKD3s
         w6xg==
X-Gm-Message-State: AOJu0YzMTLU8VWnnGK5Avc1sYNIpI/Ri/V2KK8/IEhksvoBXwm2o4tZ0
	iwasd7p4WdAJAK25toArsfJOeeF3rwugzT1kSno9YB/W3UGpEmmmAr6saLD8iZ3f8m4lqn9vECN
	oOxPzWd+Tp4T5L5sPQWSxZxLYf0ea77stTZ4BW418xudABX7qle7CVQRszJhymzmfbW57QrJxoq
	9n6ljR9XY1awiN2IMGgwfHXB+pgZ3EEYs/tjz+6a+VNliTeT4lox4Um+OxVZsbekc2MxKKDiS0x
	r3yb6bMnuRK9EUhXmiwqKDDQWm8
X-Gm-Gg: ASbGncvuIJu2BFssX7wVWWPGJlXKPFPmuUuiivdss1JA9u0dJQS/DoaheiFmz4zEzlH
	IRp148VxUOGCidbdA1ss/t2v/HG3yh0W494nP2bcLjH9Lh0rp0coGYC35uN7MNXTm4om8v3ebAc
	C7MJ6u46AQUMNsedkvwdPaaYp17JGmQNleHl9fa8kdluACLl9eKSlvRjvKlckb6qhAYPCo6ifZU
	VLvLgp0cXbAM+ym5osrzWRJ5Eg3c2RbJyO8WMN+qSCycMy7IyAdFuMzBDsBaiAKdncG3PAHtmlq
	M+rZ1+TtDM2Q+CkWGK4+cz1q7B2bmQET6HDZr4d3wg7ADjNJHQTSKQ6tN6Zp+kjZtnKrfQLG8oQ
	z/R3whOSKYf6zmp2BA21hh60heqC+rZh+whH9LSX/4Zn5pXhO1RHOg3kaSvkuyliuD5bCjBp8QE
	nNg9EaG0E2wiA6nm1vevDpG5P3sfj/85E+ukBPUN0qzyUuqecPxq9Th/5EbP4=
X-Google-Smtp-Source: AGHT+IGK/W6w8gVXOMwamp0P4jBacRRMor/OJWCNRQC99ShmI6TMX+v2myR/C3vjQVrNWZCDetCnpWAmsLlu
X-Received: by 2002:a17:903:3845:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-29b6bf7f2cdmr297664095ad.51.1764435722482;
        Sat, 29 Nov 2025 09:02:02 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce41b379sm9121125ad.4.2025.11.29.09.02.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Nov 2025 09:02:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so4291573a91.2
        for <linux-rdma@vger.kernel.org>; Sat, 29 Nov 2025 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764435720; x=1765040520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itz0sM7J6D5CRuXD8v42KtoQUwP30o1kFc+bZcaiTeY=;
        b=S1igAvtG1HgsyHspT4fb7A8g+dJJkZjm6X1YQgrmkAzg66fEJEjPwRTojQjyr0DJ/6
         61fj8CR7G08AbicuBoDVuBrD2GJKf/qnFgTTmFUAVj0HXWrNxYZnjn3swDGHVOUQShBv
         9pTqSoZMrWEE6mkvNBJPNOc1TvtfYw7AXAdVk=
X-Received: by 2002:a17:90b:2588:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-34733e457b9mr30239697a91.4.1764435720077;
        Sat, 29 Nov 2025 09:02:00 -0800 (PST)
X-Received: by 2002:a17:90b:2588:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-34733e457b9mr30239669a91.4.1764435719630;
        Sat, 29 Nov 2025 09:01:59 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b1cbdc0sm8099285a91.2.2025.11.29.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:01:59 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 0/4] RDMA/bnxt_re: Support direct verbs
Date: Sat, 29 Nov 2025 22:24:37 +0530
Message-ID: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   8 +-
 drivers/infiniband/hw/bnxt_re/dv.c        | 973 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 556 +++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  27 +
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 310 +++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  10 +
 include/uapi/rdma/bnxt_re-abi.h           |  47 ++
 11 files changed, 1441 insertions(+), 546 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


