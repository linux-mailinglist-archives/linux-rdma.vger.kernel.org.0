Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3A3552B0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbhDFLvH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbhDFLvG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:51:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A9C061756
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:50:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k8so8768677edn.6
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qEgfGkEH/4geB+vsRguqEiTYghExirAxMsBMTZDkxo=;
        b=L5EBAuUn6Duc93ViZh2kS/yNB9fVN7CY+w5Gt7cS16OrCR0hyv2YCmr7M5ERRGa93Z
         VgHaKTck15dl5prehWPTnLz7NEMiMxZ94DpylGaTtYjIJrjm6Utdx12XH5uEDjjLRolF
         JASfucoAVbX8s+ls/X3AJxSEiA9e1JHzrWfXJnBP9B1fjal3kHR2ATd7xlv97lvIQjbA
         LGDdi7nL82SJSlOj8rhEsiRqiZHj1TlNN99jsFpPOJ+VuF23Nx9527jD8Ft0GlQm+SUT
         5VvYmYYgzOOEw1FsP4Q3vpRFZ6PH0/8Lgod7f+IfMPeGdtTJwklCCsZ7DM0A52HMN4Pr
         R5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qEgfGkEH/4geB+vsRguqEiTYghExirAxMsBMTZDkxo=;
        b=Xo8wC2VXQJC0SEEsTvpEwoX8hu0yoajHVB3hqCxYrOTWCEOby7akSon8UFDego7aCX
         OhnUsa6zN2u+kGMYuwpzLkwsq6Tzcn4nfOmGsF2NyHOruCydJChkbVxEk7Qh6TDvXj6W
         b5UKW+qxrqGgnZcgeWd5eI1pvKp5I0gVsttMmZdb10rebwkvQ7a3QF+eKRewC++bkld7
         ttkiHJvwZCevA5Q4koiZ0t7IF7bCatvsJRyxzRIiXEbPHzvHsfKQToRobD+RLg+ggANy
         gBKmFSaGMWnV+L9lrpPPm3fw+q0BOSrk7SkbL7kYEB7bIq9lFeKwGXYCZhgBBwV+jbxl
         kHTA==
X-Gm-Message-State: AOAM531WxFUaeBKrKrkZi/+0Fkhtqf4oym5sOQa/CDK5146GoZZ89q6r
        WfK7FtXk6Pl2M53/K2dVA6HJHFI6w3Mm4ahw
X-Google-Smtp-Source: ABdhPJwEc8Q+BidNwrVcAZ08ycPeZUQXQlxlJ27moaWipmKzJsTe4W4Vf3I2pNmsRAxbrsIYFD/Wuw==
X-Received: by 2002:aa7:db51:: with SMTP id n17mr38765588edt.259.1617709857301;
        Tue, 06 Apr 2021 04:50:57 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id t1sm855964eds.53.2021.04.06.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:50:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        akinobu.mita@gmail.com, corbet@lwn.net,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 0/4] Enable Fault Injection for RTRS
Date:   Tue,  6 Apr 2021 13:50:45 +0200
Message-Id: <20210406115049.196527-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

My colleagues and I would like to apply the fault injection
of the Linux to test error handling of RTRS module. RTRS module
consists of client and server modules that are connected via
Infiniband network. So it is important for the client to receive
the error of the server and handle it smoothly.

When debugfs is enabled, RTRS is able to export interfaces
to fail RTRS client and server.
Following fault injection points are enabled:
- fail a request processing on RTRS client side
- fail a heart-beat transferation on RTRS server side

This patch set is just a starting point. We will enable various
faults and test as many error cases as possible.

Best regards

Gioh Kim (4):
  RDMA/rtrs: Enable the fault-injection
  RDMA/rtrs-clt: Inject a fault at request processing
  RDMA/rtrs-srv: Inject a fault at heart-beat sending
  docs: fault-injection: Add fault-injection manual of RTRS

 .../fault-injection/rtrs-fault-injection.rst  | 83 +++++++++++++++++++
 drivers/infiniband/ulp/rtrs/Makefile          |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 44 ++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  7 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        | 13 +++
 drivers/infiniband/ulp/rtrs/rtrs-fault.c      | 52 ++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-fault.h      | 28 +++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  | 44 ++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  5 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h        | 13 +++
 10 files changed, 291 insertions(+)
 create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-fault.h

-- 
2.25.1

