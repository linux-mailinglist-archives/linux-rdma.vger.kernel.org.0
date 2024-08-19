Return-Path: <linux-rdma+bounces-4407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC8956304
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 07:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65E1B21E8B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 05:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFD313C81B;
	Mon, 19 Aug 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UG/6G8nU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508712E7E
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044126; cv=none; b=PoEl2rlipBEXfd0EY/oDf5iw4sDMfRPRW0VutetECedTbSkUELq798k21BrjnaH3bGLPuPZrpinM0PmzQQj1L8wVXWU0fa7bj51xC5GRrTQj3Gfsm9EiVObOJtn50o/PU5fh2knW3t38dhS4P/IO9WaNgplPOBkXCFcyU9w0Jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044126; c=relaxed/simple;
	bh=XRNPwJ1F8fBIe3GpfU3H/VJ5IL2eAwnoiCCA0zfUQIU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ft8jVkR01WxA1DyzBh2QRE32/MDiWCT6pYUyY1t5E7I6FGvuQBEvNChD/xAVwUQ7rw5epOjzDfjfJBB6jB2Udi7VVfJ09RTAJOchnGU9gqTVRJfSXh5LKYStvTDiz7cFqh67ggNZgXi0pkJH8t9zENO8dxrMUqd+lRVjvFS5Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UG/6G8nU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7126d62667bso2224099b3a.3
        for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724044124; x=1724648924; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO8zmU/aL92V3UcRkxXh9T8/TueghUEDrqd4Du5Isnw=;
        b=UG/6G8nUCCP2gqZzf05iUQyi4n96bF53lfxfk/1RcoMNWgPtGuHmGwY/eOUyVDU5HA
         +lOhiJ6ZZqV9y94kxX6SmYInNySaAeGx5s7Y2ak7Kl8qYilzMeDCWORIIf0kvyBSXpDM
         TgZok4wPTVp5UJKGjEaEnjP6gOteLHPUghWYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044124; x=1724648924;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NO8zmU/aL92V3UcRkxXh9T8/TueghUEDrqd4Du5Isnw=;
        b=ZJk8WSQpPaU1Xc8JaJZ5ce0S4w+S0ChbrEn1vMrQIwroJUxG3y2M3jcwPfoSKCqGb2
         E7MqtAkUAJR1uUhLT1FHmZmnyAfx4q+3hKX8UQp2EBY/0d051BY7VBeBt+W3gLMD21xB
         cx8ydaa+lbHy+sUXlhU2PpdtrNCgx7Jxf+W+k/09z/d23x/ijzWKSy7PvOi4LslJo3Yx
         IOoqW0FWRARxFEWogXihSC7ofqw6JdyWozUR84Y4Xsvduu86IuvE8N2ujOy7A5LyR6oh
         mTmnbyC3o3+22HFqY2BcZu/fMevbz5vTQoCGnfsoXc7e/iBZ/EqxeeEKJq5yWln6Z0MH
         T4FQ==
X-Gm-Message-State: AOJu0YwOUl4zkreuw4Tq8ISeEcE/snw0Hc3btW+ngOZZ546oUU8ucnoX
	U9Hi8YYhM2E87DzxPs35aYJiurofLrg7Akf13sVXVsVJxkNvb4d8Cfsl4skVDw==
X-Google-Smtp-Source: AGHT+IHwOyOMFHGpDS8MC6C39iWYAcX154tQZXUsqz9p+DMa156mcJlwCOqDgJWwL2PwTXb8JdteuQ==
X-Received: by 2002:aa7:88cf:0:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-713c4efca41mr8335822b3a.24.1724044123712;
        Sun, 18 Aug 2024 22:08:43 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm6908021a12.4.2024.08.18.22.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:08:43 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 0/5] RDMA/bnxt_re: Use variable size Work Queue entry for Gen P7 adapters
Date: Sun, 18 Aug 2024 21:47:22 -0700
Message-Id: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Enable the Variable size Work Queue entry support for Gen P7 adapters. This would
help in the better utilization of the queue memory and pci bandwidth due to the
smaller send queue Work entries.

Please review and apply.

Thanks,
Selvin Xavier

v2 -> v3:
  Fix a sparse error
	- Reported-by: kernel test robot <lkp@intel.com>
	- Closes: https://lore.kernel.org/oe-kbuild-all/202408181809.Sed4EJbs-lkp@intel.com/

  Split the patch 3 from v2 series  into two - a bug fix and functional change

v1 -> v2:
  Fixing the mail id of the signed-off in the commit message.
  No other functional changes



Selvin Xavier (5):
  RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
  RDMA/bnxt_re: Get the WQE index from slot index while completing the
    WQEs
  RDMA/bnxt_re: Fix the table size for PSN/MSN entries
  RDMA/bnxt_re: Handle variable WQE support for user applications
  RDMA/bnxt_re: Enable variable size WQEs for user space applications

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 119 +++++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  16 ++++-
 drivers/infiniband/hw/bnxt_re/main.c     |  21 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  61 +++++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  24 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |   7 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   6 ++
 include/uapi/rdma/bnxt_re-abi.h          |   7 ++
 8 files changed, 188 insertions(+), 73 deletions(-)

-- 
2.5.5


