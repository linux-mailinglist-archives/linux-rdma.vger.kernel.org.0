Return-Path: <linux-rdma+bounces-12919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5977B35451
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF4D17E7FC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB802F546C;
	Tue, 26 Aug 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dSU7ZBrJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CF295DA6
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189235; cv=none; b=m8BUYrZyk/myVlYVyu0K24Q47+0L1ma2mIGYSGM08UqbOmKr26Fiy9orMtyqcX1+2pHSy8OHdhhstjt592aC7eKVmxwTkAt2+yavm6VSK3Yr50Z0UAm4FtB1BAAKmnA7wXdwo1NgfJ1BNk1+kbhs3KJQRWyoCAnsRBHEnESDQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189235; c=relaxed/simple;
	bh=4+QtwmqqdSoA2OHoNbqSk7MafkqjBrM2m4ocl+VyIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbQXMdgzdrytiSHPDw4vGvd5wzkRJScuoRF0KdI1oS3MlXnR3/XsXFnm/JrOp2lgvKtUb/XjANv0/2x3qzlJEYaYdvr5F4EJ5P9bHepUblPc8oZr05pKU6rRmnaREdoI2w3KKMP7bvl+p2SHkwfwrxXdRCn/9cS9aWNkD6eUEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dSU7ZBrJ; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-77057c4d88bso1700401b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189233; x=1756794033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d86HF9eSYw5UzbRxdfVxFLEbL9A3yFfnZEambMky0vM=;
        b=Xxw+H8j/6CH4a5r3eNZYSejYhmFbWqMOoJnvQW9cXZb7jw2+i6D5uim6fPVPB53wcy
         4AdB2J4TAEUy9UNuQfmpc0x74QuScLhJV+R2PwX0u5jHYH5ZHVqednsfDmJKbBPb2fTW
         1n6z+UlnJcj4VdI6MjcMGZxQAUGA3wTHV6BZQrpzGfhiH+CoDzbdx71sB4HZ6sZceo5u
         pJudsko/mS+KsYnm+xbIaiCtJGLoM8dZVQQssmK6+flNs7ibpYn36AT2JRTyViHnxN8B
         EP0b72BS9ZIQYJFwJ6jnkHMYVEK5X1If4Si5sqoVVP9WcJmCnMk3uAlcjzNK7L103ZOr
         dZZw==
X-Gm-Message-State: AOJu0YzEO0w7+NC6Ff/+BRJmGhgswiTyE2uDfTlC0UUDhQEEHJILNHba
	oPdN7QB6aphAMlJr9g1cWnYMpAhyslYYyAwljMQo9LI9fVbmkWg8HP+5j08dyNrcy5OMSUS+2Qp
	2OEUZIWRuj6QSVnMBjSsFKACLs4sGkuqj1eTNxhIfv976wjUjJFPup2q7z+CoFImyD+r8SVrtHd
	rOv0aedhqmZSq7tN7+7x2+F66PJ/xKFiji2/IHgGP7bnH9YL5uiZIY1xDTEzb5WVGfSKA1pWgix
	lQalSP64cE0Y6HKfGcf0hUR2uoWXA==
X-Gm-Gg: ASbGncskYnXrxz7pOUg6KJmAwA0h8EhhIuqss8uhcG8iZSum90Yvjc6sFd3JccukuBu
	O1Oeu5v2XCBnSb2XUc8jbSQDo+9qeVFSkVFjcKGR96byfhDXctuTrBBHLqdSXSoU/Fkm+Qf1YjA
	kUnjoZOENzFHFe7MA6Oq9pJDMzv29E0YGRXp2HyIegSHxVbde90P3iu2Kp5g1aS9KNyODcEdQHs
	tUQGJDxT/2jSH7UjE1gbTsAk8masL9tMnvJ8bJ1sxklcaarhiEPEq5dUbJnEZXEX5PYc2gfkhK8
	3qlDnTaXLrRZM2tnuESLJQO0hiCBCj1p+P1c04gRVpsk/1gicoVo4N8l7Ita6QAhrqZnFzaTKGP
	rSRCOsHtZjTuWRkzkby7rfpA9ml+JGhsxMMf/xIfoW8jjt3B5OefnN54a5uggb0S3KjKYgJAPkQ
	J0OB9DDd9sv3dL
X-Google-Smtp-Source: AGHT+IHMM0xY0BOfN9bRnrK7Ppmaf3WPgcj18v+tC1XGl94XRt50n+/14HQ7F3vrJvEPXnQPlEeYbTPoVj3A
X-Received: by 2002:a17:903:1b4b:b0:245:fbf8:dd0b with SMTP id d9443c01a7336-2462efd4ec2mr190379675ad.57.1756189232780;
        Mon, 25 Aug 2025 23:20:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2466886d4adsm7566195ad.53.2025.08.25.23.20.32
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47253319b8so3939744a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189231; x=1756794031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d86HF9eSYw5UzbRxdfVxFLEbL9A3yFfnZEambMky0vM=;
        b=dSU7ZBrJt3Z1CaOdpT6IPpPHdo1w9t3+sCGyRLayj9+ewYnuqk2d2kNsnZZYg1UdN8
         2KTTywZpPA34WJinZpxTyw6C/JRWFreoGFuFlk0XXafW6Ny7P4vlB+sfrDGVjuziQNrc
         Ts3S4RLXjxPyVr/8b7GAb0I+nFXUGcIDoYuM0=
X-Received: by 2002:a05:6a20:4320:b0:23f:fa6e:912c with SMTP id adf61e73a8af0-24340b8da90mr23186470637.2.1756189231091;
        Mon, 25 Aug 2025 23:20:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:4320:b0:23f:fa6e:912c with SMTP id adf61e73a8af0-24340b8da90mr23186443637.2.1756189230652;
        Mon, 25 Aug 2025 23:20:30 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:30 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
Date: Tue, 26 Aug 2025 11:55:12 +0530
Message-ID: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
QPs, which receive plain Ethernet packets. This patch adds ib_create_flow()
and ib_destroy_flow() support in the bnxt_re driver. For now, only the
sniffer rule is supported to receive all port traffic. This is to support
tcpdump over the RDMA devices to capture the packets.

Patch#1 is Ethernet driver change to reserve more stats context to RDMA device.
Patch#2, #3 and #4 are code refactoring changes in preparation for subsequent patches.
Patch#5 adds support for unique GID.
Patch#6 adds support for mirror vnic.
Patch#7 adds support for flow create/destroy.
Patch#8 enables the feature by initializing FW with roce_mirror support.
Patch#9 is to improve the timeout value for the commands by using firmware provided message timeout value.
Patch#10 is another related cleanup patch to remove unnecessary checks.

This patch series is created on top of the below series posted on 08/14/2025:

[PATCH rdma-next 0/9] bnxt_re enhancements

Please review and apply.

V1->V2: Fixed an issue in Patch#10
V1: https://lore.kernel.org/linux-rdma/20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com/T/#mfb0a80be2fbd68d595e22ae0c0f1403ef9bc5ba6

Kalesh AP (3):
  RDMA/bnxt_re: Refactor hw context memory allocation
  RDMA/bnxt_re: Refactor stats context memory allocation
  RDMA/bnxt_re: Remove unnecessary condition checks

Saravanan Vajravel (7):
  bnxt_en: Enhance stats context reservation logic
  RDMA/bnxt_re: Add data structures for RoCE mirror support
  RDMA/bnxt_re: Add support for unique GID
  RDMA/bnxt_re: Add support for mirror vnic
  RDMA/bnxt_re: Add support for flow create/destroy
  RDMA/bnxt_re: Initialize fw with roce_mirror support
  RDMA/bnxt_re: Use firmware provided message timeout value

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  13 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 146 +++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  10 +
 drivers/infiniband/hw/bnxt_re/main.c          | 221 ++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c    |   4 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h    |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  38 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  21 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      |  43 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   5 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h      |  41 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   6 +
 16 files changed, 486 insertions(+), 87 deletions(-)

-- 
2.43.5


