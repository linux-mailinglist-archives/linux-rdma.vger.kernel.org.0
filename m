Return-Path: <linux-rdma+bounces-5685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14869B897E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5815A1F226AD
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1A137745;
	Fri,  1 Nov 2024 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SmBU/FZ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9075D8F0
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429741; cv=none; b=um+YEmS7lt+b6NJLybo7OiWuAVLbzoswX4WWwiz7BJ3f0ZgBE+pk11/FvDGa8fiB4Zu/hNX+oRlp9e8D534OzeJFEPK3OLFoEFEvbe7jBQQPhXy9Rkg0fUtnOcsNt2dMSbIEP1E5hZksgoHi8U8ojCzk/fMSws8hREevM2iHi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429741; c=relaxed/simple;
	bh=I0XECtx1DvuN+XyykqOgqrMPAa06bhYerf4OOPCAv/k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jsEmliZrcxsfu1m3oKvVQIAHALUq+MR6IAhd1owWLHPLZXGef+JIgS4Hu9+uympaMNtOyf8Xq4fqpZfLl5tZIcgM2ga94Myzfv0RvIJaNwcrQ3KrjH46fpWKjGO1kMeOsoMdTtveTbFB0vNAre1BedDDw9X+hG2b/JalPfCxe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SmBU/FZ8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbcd71012so18649385ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730429739; x=1731034539; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUIgZJSJVQ9gId0ra5czrf6XQbzLvyVb5vmJHuqrod4=;
        b=SmBU/FZ8XtZdOoMYLt1cUGxNUs9bRrB+axX66/ubAG2FFzXbc6SEIkzzkHwZZPShRy
         JUviOYh/QZVFso38GlsshuWkMAbaVbvybykrxcWWKY5YBXCeVmS0lhuljrXiz9DUpdVp
         aD5fJexE9Y141dYQp1IalNq6mOi060RF1hxw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730429739; x=1731034539;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUIgZJSJVQ9gId0ra5czrf6XQbzLvyVb5vmJHuqrod4=;
        b=UQkyRFI3ivTpx20fWy19V7Pd+XfOBkPLbKsPIvBSOtLGOV+n+WAwnYh6G6GOjgqkq0
         ERWk4SNMxCnRYPgPNTo/E4p1SEo761vnGD5S9vR6t8c2YBIrfUf1MXBSs0o2ITEDwwvy
         j7COsyLHfFTnYJHCpeFbupRL+NZ1TOk3CSqz4KKEyoQZQ/TxMvEibcafPzU/t1KG1fXs
         s6c6NvB7xh9hGvA5dO/mAlr1DoiRDF8/aLInpslsMFURiQiDPVqworJw2AYZ+DHRoKN+
         9waic1tQKXsGPGl5connnb+8eBOhU73giLR7Tg9CHjTZAT8n85A0sLlZZ0//1/xGM1bU
         HZOQ==
X-Gm-Message-State: AOJu0Yy0gSsze8xuu4ZoGQd5XoJ4SJI9DUlVniTi/Li8zV1wPlPpgNC6
	0IRk/ZpYallmBsR/EVPVn0Qk66MW44GrBE3lPCfssjaG31pqaWV3CG13Hd/meg==
X-Google-Smtp-Source: AGHT+IEJ4Tudes7CwDskYTtvm+8yA2uSB/nZxIi2FzB2Cs96GrEvMc9f3grs7vonU4qUXH10BPr/tg==
X-Received: by 2002:a17:902:e847:b0:20c:a498:1e4d with SMTP id d9443c01a7336-2111afa9461mr24435635ad.60.1730429738863;
        Thu, 31 Oct 2024 19:55:38 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc1asm14961005ad.57.2024.10.31.19.55.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:55:38 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/4] RDMA/bnxt_re: Debug enhancements for bnxt_re driver
Date: Thu, 31 Oct 2024 19:34:39 -0700
Message-Id: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

This series is the first set that enables few debug
options in bnxt_re driver. Implements the basic driver
data collection using the rdma tool. Also, implements
raw data query option to get some of the Hardware specific
information for analysis. Added a debugfs folder for bnxt_re
corresponding to each PCI device to display some of the
driver specific information. This will be enhanced in future
series.

Please review and apply.

Thanks,
Selvin Xavier

v1 - v2 :
	- Remove the unnecessary user/kernel text
	  displayed in dump output
	- Avoid unnecessary NULL check while deleting
	  the debugfs directory

Kalesh AP (1):
  RDMA/bnxt_re: Add debugfs hook in the driver

Kashyap Desai (3):
  RDMA/bnxt_re: Support driver specific data collection using rdma tool
  RDMA/bnxt_re: Add support for querying HW contexts
  RDMA/bnxt_re: Support raw data query for each resources

 drivers/infiniband/hw/bnxt_re/Makefile     |   3 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  21 +++
 drivers/infiniband/hw/bnxt_re/debugfs.c    | 138 +++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.h    |  21 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |   4 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |   1 +
 drivers/infiniband/hw/bnxt_re/main.c       | 272 ++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  35 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   2 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  40 +++++
 11 files changed, 537 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.c
 create mode 100644 drivers/infiniband/hw/bnxt_re/debugfs.h

-- 
2.5.5


