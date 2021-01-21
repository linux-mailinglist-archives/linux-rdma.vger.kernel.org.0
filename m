Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3512FF36A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbhAUSOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbhAUJqD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:03 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBCAC061575
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so1067804wry.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDOJVjBvkDH3sAaM+vmNs4WaqlfGHr2TJccVLZYYeLo=;
        b=kA5ZwtCNuOp/fL/ip4gcHO71xzXDbXy4v+FTtPttbnW1lfY8iizGh7RZM0JIWu5Yit
         1+CYG+MDseTrqVDbJ5v36cbR7SDQBkA52zl+pFMH1VHClcyHV7V5kZYHZUQ5YgUnJR/+
         ykXMtmilD4mcljiyTEz41FdXXtqZj3FeMQc7OMxgZR80M/DT1E6zRsKyM49OlHYMnBRk
         W3E9E9edNegy8iW1yxMO0HsyJgLmBSBM0oCueg4Bzf9q/NA2Xji3yKp78/+nP0uS3DeM
         vKjlHEs+dJ81zrpJIzv63QhdRvwfa18lF9cvK/ALqyeEyodpP0JK1Mp2F3dr17ygDH+i
         2TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDOJVjBvkDH3sAaM+vmNs4WaqlfGHr2TJccVLZYYeLo=;
        b=Ie/4JyN1T1iL5aJmfGnFzr3+gZD+ySICeeDDX4Y+v5ZM+6gBAiEpmxkvar925IhSJW
         HjGFr3s453baTExqTjdYmgFCSy1lf73T7o98X3h5HHw1MxDrOXtHMrv+krOvguTa+brD
         oA4ArgrVj+nqmxYFvddeHm201vdTgxy1c+nJuwPrAuRRfv3maAVqAe5XUfmMj+N85FTJ
         p3xk93AFIz6tRrgkE+7gU3jcST+5tWZg8CTUkDUyCO9BE8fMY1fsTz1rqFJHWUCVklSD
         1FZyMQXtkFqdodZSiprgOivZgdBCRkiDZEqdYI0PuoP725EHIqQ9KJB/RjEJ5Y9xjm4p
         uqZQ==
X-Gm-Message-State: AOAM531KO7NUUMq4AfnRWIY0CtIavAUwDOm1L9uLhQdpgv/JcpNPPh6G
        YKAtO2F+OEQFdmrFgdTfJ70AOQ==
X-Google-Smtp-Source: ABdhPJyvEpiuR6sbN6/7M9ufq5hAHFT8FS1aClnjo3W98c6z2OUENHpgF2P7gX9oD9f9lqp0qZYy8g==
X-Received: by 2002:a5d:47ae:: with SMTP id 14mr13046159wrb.378.1611222321921;
        Thu, 21 Jan 2021 01:45:21 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Intel <ibsupport@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nenglong Zhao <zhaonenglong@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Wei Hu <xavier.huwei@huawei.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH 00/30] [Set 2] Rid W=1 warnings from Infiniband
Date:   Thu, 21 Jan 2021 09:44:49 +0000
Message-Id: <20210121094519.2044049-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 2 of 3 (hopefully) sets required to fully clean-up.

Lee Jones (30):
  RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in
    'pagefault_data_segments()'
  RDMA/hw/mlx5/qp: Demote non-conformant kernel-doc header
  RDMA/hw/efa/efa_com: Stop using param description notation for
    non-params
  RDMA/hw/hns/hns_roce_hw_v1: Fix doc-rot issue relating to 'rereset'
  RDMA/hw/hns/hns_roce_mr: Add missing description for 'hr_dev' param
  RDMA/hw/qib/qib_driver: Fix misspelling in 'ppd's param description
  RDMA/sw/rdmavt/vt: Fix formatting issue and update description for
    'context'
  RDMA/hw/qib/qib_eeprom: Fix misspelling of 'buff' in
    'qib_eeprom_{read,write}()'
  RDMA/hw/qib/qib_mad: Fix a few misspellings and supply missing
    descriptions
  RDMA/hw/qib/qib_intr: Fix a bunch of formatting issues
  RDMA/hw/qib/qib_pcie: Demote obvious kernel-doc abuse
  RDMA/hw/qib/qib_qp: Fix some issues in worthy kernel-doc headers and
    demote another
  RDMA/sw/rdmavt/cq: Demote hardly complete kernel-doc header
  RDMA/hw/qib/qib_rc: Fix some worthy kernel-docs demote hardly complete
    one
  RDMA/hw/hfi1/chip: Fix a bunch of kernel-doc formatting and spelling
    issues
  RDMA/hw/qib/qib_twsi: Provide description for missing param 'last'
  RDMA/hw/qib/qib_tx: Provide description for
    'qib_chg_pioavailkernel()'s 'rcd' param
  RDMA/hw/qib/qib_uc: Provide description for missing 'flags' param
  RDMA/hw/qib/qib_ud: Provide description for 'qib_make_ud_req's 'flags'
    param
  RDMA/sw/rdmavt/mad: Fix 'rvt_process_mad()'s documentation header
  RDMA/hw/qib/qib_user_pages: Demote non-conformant documentation header
  RDMA/sw/rdmavt/mcast: Demote incomplete kernel-doc header
  RDMA/hw/hfi1/exp_rcv: Fix some kernel-doc formatting issues
  RDMA/hw/qib/qib_iba7220: Fix some kernel-doc issues
  RDMA/hw/hfi1/file_ops: Fix' manage_rcvq()'s 'arg' param
  RDMA/sw/rdmavt/mr: Fix some issues related to formatting and missing
    descriptions
  RDMA/hw/qib/qib_iba7322: Fix a bunch of copy/paste issues
  RDMA/hw/qib/qib_verbs: Repair some formatting problems
  RDMA/hw/qib/qib_iba6120: Fix some repeated (copy/paste) kernel-doc
    issues
  RDMA/sw/rdmavt/qp: Fix a bunch of kernel-doc misdemeanours

 drivers/infiniband/hw/efa/efa_com.c        |  2 +-
 drivers/infiniband/hw/hfi1/chip.c          | 46 +++++++++++-----------
 drivers/infiniband/hw/hfi1/exp_rcv.c       |  8 ++--
 drivers/infiniband/hw/hfi1/file_ops.c      |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  1 +
 drivers/infiniband/hw/mlx5/odp.c           | 22 ++++++-----
 drivers/infiniband/hw/mlx5/qp.c            |  2 +-
 drivers/infiniband/hw/qib/qib_driver.c     |  2 +-
 drivers/infiniband/hw/qib/qib_eeprom.c     |  4 +-
 drivers/infiniband/hw/qib/qib_iba6120.c    | 18 ++++-----
 drivers/infiniband/hw/qib/qib_iba7220.c    | 16 ++++----
 drivers/infiniband/hw/qib/qib_iba7322.c    | 14 +++----
 drivers/infiniband/hw/qib/qib_intr.c       | 16 ++++----
 drivers/infiniband/hw/qib/qib_mad.c        | 10 +++--
 drivers/infiniband/hw/qib/qib_pcie.c       |  2 +-
 drivers/infiniband/hw/qib/qib_qp.c         | 12 +++---
 drivers/infiniband/hw/qib/qib_rc.c         |  5 ++-
 drivers/infiniband/hw/qib/qib_twsi.c       |  1 +
 drivers/infiniband/hw/qib/qib_tx.c         |  1 +
 drivers/infiniband/hw/qib/qib_uc.c         |  1 +
 drivers/infiniband/hw/qib/qib_ud.c         |  1 +
 drivers/infiniband/hw/qib/qib_user_pages.c |  2 +-
 drivers/infiniband/hw/qib/qib_verbs.c      |  6 +--
 drivers/infiniband/sw/rdmavt/cq.c          |  2 +-
 drivers/infiniband/sw/rdmavt/mad.c         |  7 +++-
 drivers/infiniband/sw/rdmavt/mcast.c       |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c          | 21 +++++-----
 drivers/infiniband/sw/rdmavt/qp.c          | 34 +++++++++-------
 drivers/infiniband/sw/rdmavt/vt.c          |  2 +-
 30 files changed, 143 insertions(+), 121 deletions(-)

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Gal Pressman <galpress@amazon.com>
Cc: Intel <ibsupport@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Lijun Ou <oulijun@huawei.com>
Cc: linux-rdma@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Nenglong Zhao <zhaonenglong@hisilicon.com>
Cc: Weihang Li <liweihang@huawei.com>
Cc: "Wei Hu
Cc: Wei Hu <xavier.huwei@huawei.com>
Cc: Yossi Leybovich <sleybo@amazon.com>
-- 
2.25.1

