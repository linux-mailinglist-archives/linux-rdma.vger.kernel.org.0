Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B152DD2D0
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgLQOT7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgLQOT6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:19:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E0C061794
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw4so38043675ejb.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qLeEBe2ToeKhrGNMM1vz1BmF/OLjpceLfv/oRJO4kM=;
        b=Wuvt+2sfGq1FlwnxLfVndNw6jxuegvYK9zVcaChdVleRRUQjLsr7Qt5klktOUyXkKK
         espiCpNY6mRRNBzMdxT1pr4qlAgDOHlDSqf6EAdBE1K/5YFtRkhVgsB9cEr87LBx7oM1
         yStpppkyilNEsSKvahFKH7aHA6EDa/A7Li2s9CxVofWFO46jnIeqozrXn6NIQJn/h00Z
         /INjG2ZyCJ+lz3vc5VK11VZBXEs0OOQUb64qNi2mEusssWJ0RR26QADXUIWayhCoi6oC
         xLqWaSAsomb86HQk22XXEOVxc10E66DgQTHcMPJzSwQeHQMfY9RmPOkNT7Op0U4bvhT4
         MOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qLeEBe2ToeKhrGNMM1vz1BmF/OLjpceLfv/oRJO4kM=;
        b=k7TD7XPOjmOLxPat78OyN3qRjFxLLEbissQc1TEvB6CjlEGIh3htlwNLof+ZtjpBbW
         o2J+6KD+fjhdJ3Ab5tNTDBIL6nKoP7b/zI20U3G4Qyc+uVZdNy4PsF//hDRoGUyYoqZr
         fxIlL7Sv2Kr/ht2NJpABAt2RPXEkoFne+DkpE4nk8R8rccri9+fZ35Ivc71GeMraIJ+Z
         tCoC+Hz6GNaWhDW3YjddIps1kKGgzfJpGqQDsAETtJKbmdH2bG4VtNxDV07nmHImuxeV
         817flnf+HT5PkaqdF7TTcSOQ8eH5C0q+xPaEiOdw06CwHAKj6GQp+LZUFtFHZM1EyQaj
         oVXQ==
X-Gm-Message-State: AOAM533fTYgLQ499EyDs3g/HM+eBlcDuTqF99rjmUxn2Q12YocjqWB0/
        xAxII/OdOz5RP2x3DeR/SMLT7j+WUKXiww==
X-Google-Smtp-Source: ABdhPJyjRDvxEJ54K8mQIn2U9TrEx/lDfcSF5TUHZioUTVmqi/oecuOxx98mqqqZRpvrkGMJbyfbaQ==
X-Received: by 2002:a17:906:adcb:: with SMTP id lb11mr34478256ejb.346.1608214756902;
        Thu, 17 Dec 2020 06:19:16 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:16 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCHv2 for-next 00/19] Misc update for rtrs 
Date:   Thu, 17 Dec 2020 15:18:56 +0100
Message-Id: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

It contains a few bugfix and cleanup:
- Fix memory leak incase of failure in kobj_init_and_add in both clt/srv
- reduce memory footprint by set proper limit when create QP
- fix missing wr_cqe in a few cases on srv, it could lead to crash in error
  case.
- remove the SIGNAL flag for heartbeat, otherwise it could mess around 
the send_wr_awail accouting.
- flush on going session closing to release the memory presure on server.
- other misc fix and cleanup.

The patches are created based on rdma/for-next.

V2->V1
* more descprition for the patches above as requested by Jason, also include
Fixes tag for bugfix.
* suppress the lockdep warning for PATCH 2 `Occasionally flush ongoing session closing`
with comment.
* new bugfix PATCH 19 RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug

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

Jack Wang (11):
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
  RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  11 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 120 +++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  34 ++++--
 drivers/infiniband/ulp/rtrs/rtrs.c           |  32 ++---
 7 files changed, 110 insertions(+), 100 deletions(-)

-- 
2.25.1

