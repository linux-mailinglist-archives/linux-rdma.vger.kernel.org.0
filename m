Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA3725BAD5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 08:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgICGGz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 02:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICGGx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 02:06:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716EC061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 23:06:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m5so1234807pgj.9
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBVC6oLyNJnmC7CK+9/5MHrueGDnYbnXC6caSW30iCk=;
        b=gTrKtX5B/2/V2GqN7XapNSdK2gR05VeFhq+mTqjQBq36zjjxA33A2XcblqpwGei/ld
         PWQjlpaQJXESW+i36nArWdrwqubc9yBv6G9nmYEbD2TfKwgtPHXZ2quziEn5BXmHiq6V
         dkXlRNy0N9L2VFgQwmYuFcqekqZN/oCDzk1kMBLI86UOSjD9YpscmG8AXu+jP30Dr+6L
         r9jaTqBdWLw+WYYdv/3okCVFKlLf7EQTUkypCUF7J8sTGMlbnbZlPi0vQHpf/bJ6604K
         OIMzJ4zl1i/QV0QWL9mJWAYGSNLNGRuoy4LQzTLonlP/Xn4c34dxOBk9MxPAUcZDupsm
         Y/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBVC6oLyNJnmC7CK+9/5MHrueGDnYbnXC6caSW30iCk=;
        b=gLaAF+rkfe/Q3zOmSKOeUqFN3xxG6tiYas98PYSc/bWrWnhm6hU2X23KmNYOwozleI
         4PIQnGCmutkSybwyL90M3d3wK+rlor9/ZEyXvCmw/j/uPsrRrkW4cjj0+PXYCCWFrE0M
         zhLRUW7GO/Rn3P5/x5eOr+lzSiEWL1h73zh11dJJBH5J3op5UHr395c7Fse2ggcmN7VW
         c3S64Mi3R6sHir2ja9/Re1tFQYfKrBLMOCtEDsQWJaSLzwDWbgPce5FYoLRts1uRHZJ4
         IIogzwNAN+/Z1la0aKKsRZqz87bqY0VGJ39kPiTskY10dR/Otnl0QKhQelmU89VyRTez
         3ZZg==
X-Gm-Message-State: AOAM531Khe+GwRLeNNFkYaohfGqs3fxLrLHkf3+EDJOZw94w6kuw2OVP
        LzINz85phV796f6dtaN6CxQ=
X-Google-Smtp-Source: ABdhPJyTU0/xl3citwb3RpsAz29JZbv+OplSEaJ3fUNeK4qxMbZ8pkhYm6jgaxcjRbN6NLoUCo2z5g==
X-Received: by 2002:a05:6a00:89:: with SMTP id c9mr2230206pfj.159.1599113211239;
        Wed, 02 Sep 2020 23:06:51 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.170])
        by smtp.gmail.com with ESMTPSA id v1sm1210395pjh.16.2020.09.02.23.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 23:06:50 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com,
        devesh.sharma@broadcom.com, somnath.kotur@broadcom.com,
        sriharsha.basavapatna@broadcom.com, nareshkumar.pbs@broadcom.com,
        jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v2 0/5] RDMA: convert tasklets to use new
Date:   Thu,  3 Sep 2020 11:36:32 +0530
Message-Id: <20200903060637.424458-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts
all the infiniband drivers to use the new tasklet_setup() API

The series is based on 5.9-rc3

v2:
 Fixed bnxt_re driver. Suggested by Jason.
 Fixed subject line.

Allen Pais (5):
  RDMA/bnxt_re: convert tasklets to use new tasklet_setup() API
  IB/hfi1: convert tasklets to use new tasklet_setup() API
  RDMA/i40iw: convert tasklets to use new tasklet_setup() API
  RDMA/qib: convert tasklets to use new tasklet_setup() API
  RDMA/rxe: convert tasklets to use new tasklet_setup() API

 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  7 +++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 11 +++++------
 drivers/infiniband/hw/hfi1/sdma.c          | 22 +++++++++++-----------
 drivers/infiniband/hw/i40iw/i40iw_main.c   | 14 +++++++-------
 drivers/infiniband/hw/qib/qib_iba7322.c    |  7 +++----
 drivers/infiniband/hw/qib/qib_sdma.c       | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_cq.c         |  6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c       |  8 ++++----
 drivers/infiniband/sw/rxe/rxe_task.h       |  2 +-
 9 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.25.1

