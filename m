Return-Path: <linux-rdma+bounces-12870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1611B30D1F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18190B63DD7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B92367D1;
	Fri, 22 Aug 2025 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PeFwcHv1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFF21770B
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835366; cv=none; b=VVB6FSgVkRc0wGpsCsPJ6h4qWrgiga3FX1Xc0iSdnfnF2m4oYomZjIu7hiLd2QTDyq3s9bshlISl/B6u6fCAHsZwRj4NBhmzjgNlEqs6WqtavlSS8uJziAT25DlO86+KEXLnwV8TcSgHjOZ5wfnVEA3wSJjr2spZhh9oDvUlL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835366; c=relaxed/simple;
	bh=ljgXtCbMutgZoiP95fUzEdlrtbyCvK47QZbot9u60JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmS300NZlYvUpz+3EIDjibwbKzNkWubJCkr6JZpkDgAVpQWwH3AyKyGOrXi0YreqcCozPjYMEMLWjOiR/tocK9ybDizZbOYKIKgjO71f46YfD67hFGM2qe/K4dqdzvaSCMk3fegYpccpr26c/eP5gFRualkgLZvQaws8iyB9ssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PeFwcHv1; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so1617027b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835365; x=1756440165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4iLTbNCQWmFelHo92CQb3hcDOCGRqAUjKsZcLfgPSU=;
        b=BsJRfxbiIPVVzwHOXCxZArmf5B8CEAvCgWl7X9jlxwrxgkrVxi0C4dCuElukjJvJpb
         1NMeaflBA1gBjfZfqugy218kcIL+iyG8ffOeRMyd46fWmxFXaBbkLpfjt4Dd/K5sD9dR
         uIfCpOkI9iQHb0FxiMzqrEQeCkOcx+0+znH4akxuFH6k8PvbzpPNKUnhihVyhRwPZGER
         4Vnhk3lWOm42b/w7Ft6jCi6JceQGjvHQ09Oo2TS71zaHkaynEqPJBEorn7NZuV96AMUY
         fq7ay3oim1qWBKz0rqp5hW23tyDwXL8Q3reWnjuV+BEkepBIKwocZMOJOXxueLskO9xr
         scRQ==
X-Gm-Message-State: AOJu0Yx2Q6O2owrTWCzf+ejEDE2aonC4JqbSzacPBCqXI+A93UCY5cC1
	I6d0LqOLhhuSjo4YQPtxybVO/LtLZmOvCuOadKgcKW/5YkMZoQkS5FdPncALfq1pdjGMf9QINnb
	AwMlrinzLOihbc404e/r2Sk+tL5C/VwsFXalY68G2fZoPcH1FsMiPeZitCn701HMTIko9rQEPgk
	9Af7wJDRauh2VK4rm5oLn4a4gC9o7jUPufx8lQEmSU92xhGe6BT2wD3rkkER7hCQPMW5LTUa0Re
	TbAVcI8w6Jgnew2Vqnwb6xlgKLLog==
X-Gm-Gg: ASbGncv190v3mlFjwqq7zJlYz/HcLn/x2kATkpIticN4QIYmXs3QfkC0kVkkN0JsArm
	bFEbM2DXv2fkrteawkHj6VMXz0zGrAc9eeDyvqh7Xwh51KxoCaIhNn+7qC+HwsTy6kj3fXqfB27
	OT00bXYKkCKJXkPFuH/L6ZIxWhUcrwtr8907AiRF2YhM4B7RbxS+ud34g6Bob+kPsRGvJoTI9K6
	jbLFvuxrRGNh/OYRwDjPpnxq1ROwcz/7/pW8BVJHFs+02KixMUKPevz5gR6cN3l5vvgol+Q79ds
	9H3xIuPYcdPWVk51hypaig4Og9jlKJDwWH/VA+ZiZVt9NuaY1MGcMoZrhWUQMXDcISLSOM8hJ0u
	2bk3zVsfMur5LVqXGlwzfciv9SnmP5M8MEdHY8xnQOKdveoD/2zltlhoeYupIpyqnv2VXKuHqPz
	aQAq8yyLb6ULRs
X-Google-Smtp-Source: AGHT+IGCoqrxQsjop1I5Ix6cQSigLZDPIkiSgo+QlYy+jBuXTxcOIqpda2gJtjn6gOc6CVgn0uzqHnnS06p5
X-Received: by 2002:a05:6a00:21c9:b0:76f:9e0a:f790 with SMTP id d2e1a72fcca58-7702fac3771mr2274853b3a.19.1755835364586;
        Thu, 21 Aug 2025 21:02:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-76e7d0c8ebfsm806164b3a.3.2025.08.21.21.02.44
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e5fde8fso1625796b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835363; x=1756440163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4iLTbNCQWmFelHo92CQb3hcDOCGRqAUjKsZcLfgPSU=;
        b=PeFwcHv1rEWYdv+1OG0waLOneG1wr0OcIQK1qOWgX03dE04jeIsbCkroeteUwX/Djd
         n21TQImAmzvRnsp08vV42M1APwb42UVx6kfo0kgsenEWRHkT0YkMjX/8sA1XlSYsaJ6v
         IaWMQdEEVV+G+bJ3qttEsPccgYSxA69V5LHtg=
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-7702f9d7f70mr2458295b3a.6.1755835362767;
        Thu, 21 Aug 2025 21:02:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-7702f9d7f70mr2458253b3a.6.1755835362264;
        Thu, 21 Aug 2025 21:02:42 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:41 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
Date: Fri, 22 Aug 2025 09:37:51 +0530
Message-ID: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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


