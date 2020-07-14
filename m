Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7921F985
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgGNSeh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSeg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 14:34:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFEC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so23976004wrw.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E57L4Yz4N4WKiMjEMD+183sT+62ICJV/rOkOHFAoG/8=;
        b=QXU0bRghfoh4ZrBkeFWORL8xMtqTyf+Lx8A1TquVb8EbJf3UwrIQtzxvrdk4437FxO
         7n5mCDe5ovNrTVGH1CBI+HaMSLAvYFSq6ORmDk9hYUxKcwS2kVkO+6fi82jTCjhlYbBu
         +kIt7usu9pSjWG+SKAJw9dROtPORMxjojxCmSrx5+iPGGBlj5Z9qtqYitUsP3meDS+ow
         nxz3Io1W5xyYO9/skJ8e2uKPtPmMNAeoF+OqkDpyk5KfqmDBEo1cs5GS8x/ZKk1/4SOG
         yK/YwT+uhjOUpP4W42buot85qfi/b42p7ap+scY3OJt18sdMQag8N5XKncR/D3W3fzK/
         z/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E57L4Yz4N4WKiMjEMD+183sT+62ICJV/rOkOHFAoG/8=;
        b=kuAfLhqtwKvX4FMsbYTnCG1DV2Oj7Sos7jg9HN8mFAhZXNrVIPnQsdwW0jeeLI3M0h
         kd1Bdsr0m6dFA5JpN0PIdk1yuPRDKfYQT5IqtyzvYtBloCu1P7mz5sR+KJdpkyL0JoLJ
         NKjgH3P/JO94JBDgHFKtzroNxjc/1fQVolmF33iohJYkmGJy6syMaBkkCwOSrm+tpFYz
         dyg6228x56Lysl0RZlduFQdwi5R8hCCMKD63KMp7m/aJgo1f3XrrrVZo7Co+qQXyAH3Q
         JmqHZlODSabnyZy+PWWAIW4h65xRV0qqrbriLGCM182ZFBqJ7xBoQBUHBzuy9VdJ0nAz
         sNWQ==
X-Gm-Message-State: AOAM533qrQ1CUnT7EiOOxYNMWZVnO9HTCW0Igjr+WCpbmi73pyyVnXMK
        Zd32TtGMEmF//XbKLtFLnsWgbU95LnU=
X-Google-Smtp-Source: ABdhPJxiVRh+oiK3S+aNyA6wJt7esCs2R/NAXCsEKvvON6XlpWCUJDRAHDQEOdQJvChqBUZhRehe4w==
X-Received: by 2002:adf:dfcd:: with SMTP id q13mr7337423wrn.295.1594751674619;
        Tue, 14 Jul 2020 11:34:34 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:34 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 0/7] RDMA: Remove query_pkey from iwarp providers
Date:   Tue, 14 Jul 2020 21:34:07 +0300
Message-Id: <20200714183414.61069-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set does the following:
1- Avoid exposing the pkeys sysfs entries for iwarp providers.
2- Avoid allocating the pkey cache for iwarp providers.
3- Remove the requirement by RDMA core to implement query_pkey
   by all providers.
4- Remove the implementation of query_pkey callback from iwarp providers.

v1: Patch #1: Move the free of the pkey_group to the right place.

Kamal Heib (7):
  RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
  RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
  RDMA/core: Remove query_pkey from the mandatory ops
  RDMA/siw: Remove the query_pkey callback
  RDMA/cxgb4: Remove the query_pkey callback
  RDMA/i40iw: Remove the query_pkey callback
  RDMA/qedr: Remove the query_pkey callback

 drivers/infiniband/core/cache.c           | 45 ++++++++++------
 drivers/infiniband/core/device.c          |  4 +-
 drivers/infiniband/core/sysfs.c           | 64 ++++++++++++++++-------
 drivers/infiniband/hw/cxgb4/provider.c    | 11 ----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 -------
 drivers/infiniband/hw/qedr/main.c         |  3 +-
 drivers/infiniband/hw/qedr/verbs.c        |  1 -
 drivers/infiniband/sw/siw/siw_main.c      |  1 -
 drivers/infiniband/sw/siw/siw_verbs.c     |  9 ----
 drivers/infiniband/sw/siw/siw_verbs.h     |  1 -
 10 files changed, 77 insertions(+), 81 deletions(-)

-- 
2.25.4

