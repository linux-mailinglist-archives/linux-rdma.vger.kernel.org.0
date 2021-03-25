Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4134959B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCYPdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCYPdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9EC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so2895190eds.7
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1J7N2J/+A/l9wQQRtaZQonwEecsdtgtAQHNZdZtl9eU=;
        b=FMWCkwTM6a9SPpSNRxb4+2mu6n2hpcSNEvVDjmgG0Qq5L+gjlTf3fcPw0d21Hdvb1H
         LoQveyIyNkV+2MIzDkR+fG8gLUPZlL1EBaHWj6CKjdBDJe0H6s27EsuLqC05c6JFoXCo
         La4q+1znyWBTDqBS76JFQQX9vwaROU4243pniu3UTPK14QtVEYkS7lPpvssURCusiPFU
         xQICG2jCUuCdNISbzbZdIpfqVVTkxDS6nbu7cC0wVX8aswmuy27T/xVK+idiaVM8tWhs
         wNZDGu8uBMGAcSfq76yOtWxlXptOM3G/V7FKsOaubfjgL8/i0IHOe0OkGJuLE63/cZXD
         1+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1J7N2J/+A/l9wQQRtaZQonwEecsdtgtAQHNZdZtl9eU=;
        b=he1GDC1YXpu+frHHrzfQr0gm1J8RxpLD7n0J0ONcZsfjXXHwMAwsc6QC7yzXr0uUwg
         Jma6TFLABY4btvoW0LlcnBCZGIkVyNIh2YHkACPxxjAQ5g5S+dPzUndDg0OVdv4KsV9y
         5tRAbquG1yQlcj4OuzIc1S81GV8NtbT3zS7mVxcIoBgvDSxy5HDxz0gLuxzx3an14Kg6
         Sp2noIqTePz6mhpNscJE96jsX1tF9ozPjz0rMWTjkpPYFurdWWDgVmisJSuKF9E7oJg9
         Qj2/SHC3/LsqTquCrUk2fC396bFO5lgEE4wYkPIlr6FQOIPJBvSqIJdL07+QzitccSSf
         ukRw==
X-Gm-Message-State: AOAM531wVdX3dGHiZ8VwIUFw9w7Qs+6RT9yv1Q6YUATEkctA7X+wCt5b
        kAjYlN4U9HjmM5gahLLsooBbtFVIgqhmTdSS
X-Google-Smtp-Source: ABdhPJxUVAYYNNgBIh6egqs1RGCkBtCiye3VZooFNj49PFh7gdbpyaZQQuqJ+qAA5h65Fs+nTo4GtQ==
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr9830535edb.33.1616686393048;
        Thu, 25 Mar 2021 08:33:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:12 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 00/22] Misc update for rtrs
Date:   Thu, 25 Mar 2021 16:32:46 +0100
Message-Id: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

It contains a few bugfix and cleanup:
- Change maintainer
- Change domain address of maintainers' email: from cloud.ionos.com to ionos.com
- Add some fault-injection points and document update
- New policy for path finding: min-latency and document update
- Code refactoring to remove unused code and better error message 

Danil Kipnis (1):
  MAINTAINERS: Change maintainer for rtrs module

Gioh Kim (12):
  RDMA/rtrs: Enable the fault-injection
  RDMA/rtrs-clt: Inject a fault at request processing
  RDMA/rtrs-srv: Inject a fault at heart-beat sending
  docs: fault-injection: Add fault-injection manual of RTRS
  RDMA/rtrs: New function converting rtrs_addr to string
  RDMA/rtrs-clt: Print more info when an error happens
  RDMA/rtrs-srv: More debugging info when fail to send reply
  RDMA/rtrs-srv: Report temporary sessname for error message
  RDMA/rtrs-clt: Simplify error message
  RDMA/rtrs-clt: Add a minimum latency multipath policy
  RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
  Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy

Guoqing Jiang (5):
  RDMA/rtrs-clt: Break if one sess is connected in rtrs_clt_is_connected
  RDMA/rtrs-clt: Remove redundant code from rtrs_clt_read_req
  RDMA/rtrs: Kill the put label in
    rtrs_srv_create_once_sysfs_root_folders
  RDMA/rtrs: Remove sessname and sess_kobj from rtrs_attrs
  RDMA/rtrs: Cleanup the code in rtrs_srv_rdma_cm_handler

Jack Wang (2):
  RDMA/rtrs: cleanup unused variable
  RDMA/rtrs-clt: Cap max_io_size

Md Haris Iqbal (2):
  RDMA/rtrs-clt: Close rtrs client conn before destroying rtrs clt
    session files
  RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
    stats

 .../ABI/testing/sysfs-class-rtrs-client       |  12 ++
 .../fault-injection/rtrs-fault-injection.rst  |  83 ++++++++++++++
 MAINTAINERS                                   |   4 +-
 drivers/infiniband/ulp/rtrs/Makefile          |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  91 +++++++++++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 108 +++++++++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  14 +++
 drivers/infiniband/ulp/rtrs/rtrs-fault.c      |  52 +++++++++
 drivers/infiniband/ulp/rtrs/rtrs-fault.h      |  28 +++++
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  64 +++++++++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  31 +++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        |  13 +++
 drivers/infiniband/ulp/rtrs/rtrs.c            |  27 +++++
 drivers/infiniband/ulp/rtrs/rtrs.h            |   3 +-
 15 files changed, 486 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.h

-- 
2.25.1

