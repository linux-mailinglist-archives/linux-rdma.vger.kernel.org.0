Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481062D4704
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgLIQq1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLIQq1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:46:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A11C0613CF
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v22so2276546edt.9
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVbwOdJukubQMaW8coy+qgARdUfuQM5NJvzECqXS7bU=;
        b=bWnSFNkqfqdzdSAhy9L81Gaj/KVOrM1zBH9zalV70+GAp9SBs5pS2MQmcUVpO51wa6
         V1AtxcUr9vba+GjzlSJi0hiwsNpvigZ6QV8nMKeilr4vepf3zXEsiae4R76tR9HN6/gG
         xL1sASmeuv3QUNCxxT2mEuvM7HpCUdXMd03IEjUwinGiqt95Kke8CQAMu5BLtIcGoP2c
         mOShjWmJH2t4AH86TDfGCLW6VQP4vKV/xmuDBOTSL3YyI9O4UJ27km4MfAIF4lFpfgZ9
         ls9ejMaP9Q9KnKCG9GB5qxO8nUPzk2zBdjOjKaGMOnwyoaPdvCplLGUeWMDfY5VRmCoI
         5cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVbwOdJukubQMaW8coy+qgARdUfuQM5NJvzECqXS7bU=;
        b=DU3dq+3zNv2r8aLk5eU7eGd8FWAllg095oULOUSFskttYh8Og1r6YAz4FGFTzWk2En
         O2BF9XbIWF0AvnQTof6vgmgXZT+hGNfK0cX5p5XCvBbAw7H+GnFNi+k8q6qC3odVDMt3
         zbcocepKzwoEtq0Q7zBOVa7zFw4VWJluWA8qVQUg6whB6vvr3vyahtBNeO7ebrIapTyl
         Iyvo19gZrCbHZHlN/2K4bXLukjkiR7mmpaBl4TVRsHMuwTrSI899ryf2xH28yaNChuJg
         n2Kj+qtAMJSEg/TAS6pbJFL219UQYjjPXtKIlCP/u8EECyYbr1ktUIu+xL9thCufgun3
         +2SA==
X-Gm-Message-State: AOAM530KnnYxhXQRs794z+2L/WSdPvSZ5+JaWrpLefNPSesQuvX+U7z1
        uZgkvFsySwKDLCLoc9L677MzcUL31ae0Hg==
X-Google-Smtp-Source: ABdhPJxp/i0OVyWgZRlLkkVO09vKckbUkdup4NESNf1AG4V0bhjxXljTiskfoAOWml0q8/+8uMI57A==
X-Received: by 2002:a05:6402:c83:: with SMTP id cm3mr2769931edb.189.1607532344855;
        Wed, 09 Dec 2020 08:45:44 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:44 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 00/18] Misc update for rtrs
Date:   Wed,  9 Dec 2020 17:45:24 +0100
Message-Id: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

It contains a few bugfix and cleanup.

The patches are created based on rdma/for-next.

Thanks!

Guoqing Jiang (8):
  RDMA/rtrs-srv: Jump to dereg_mr label if allocate iu fails
  RDMA/rtrs: Call kobject_put in the failure path
  RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
  RDMA/rtrs-clt: Kill wait_for_inflight_permits
  RDMA/rtrs-clt: Remove unnecessary 'goto out'
  RDMA/rtrs-clt: Kill rtrs_clt_change_state
  RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
  RDMA/rtrs-clt: Refactor the failure cases in alloc_clt

Jack Wang (10):
  RDMA/rtrs: Extend ibtrs_cq_qp_create
  RMDA/rtrs-srv: Occasionally flush ongoing session closing
  RDMA/rtrs-srv: Release lock before call into close_sess
  RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
  RDMA/rtrs-clt: Set mininum limit when create QP
  RDMA/rtrs-srv: Fix missing wr_cqe
  RDMA/rtrs: Do not signal for heatbeat
  RDMA/rtrs-clt: Use bitmask to check sess->flags
  RDMA/rtrs-srv: Do not signal REG_MR
  RDMA/rtrs-srv: Init wr_cnt as 1

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  11 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 120 +++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  24 ++--
 drivers/infiniband/ulp/rtrs/rtrs.c           |  18 +--
 7 files changed, 93 insertions(+), 93 deletions(-)

-- 
2.25.1

