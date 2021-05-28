Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D058B3941C0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhE1LcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1LcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E290C061574
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j10so4447463edw.8
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vXg2l/Hh+I2uCatLoYGs6UobAmWg0IaJC5AS0qAr0Qg=;
        b=Uf7lbEqXrl23yj+/X8+4hD9gH8Ck+HfN7XQFGcNYwWZg+jwO91fF2M95YUwcN10FlW
         aaPhjGbhm/Ea06bv+qUNlDFsjK+MvgAU4FzI74kNrU8FcbXkQ5LEuZ+QrryDr8xsCEJ8
         K7ksX3sWHCWGP4SOn16j3r1sUCOYNPs7dsorerJXiK+FcmZmlad6gV1lHPi35lk6SXgQ
         9hp0DqsWMH8OkZNPjdLPBL0U6Ax79f+UDnf7GFBchHG1ccbpGcRe+Wv8roLOVAg7pd8x
         oHsPW5hN4cLKZHqlSF7juVwCHqwLaKMBImoGneVafsb5s6JsB4HyFLMc9ASGblF2Y1Y1
         Yn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vXg2l/Hh+I2uCatLoYGs6UobAmWg0IaJC5AS0qAr0Qg=;
        b=h08kMIdurn/6f6PPvTdHpQKP1kFQh+k7VD6/y+r/Z7xdLxKDcWx4W1i2PIRznA1OXX
         /I6Y/qKSV2jGUSgze8GmW3AOHye2n9P+OC2GS/fHWv40k9dP9LelwdR2xzZ7KmybJ5+2
         pgqLTqS7hMF8kDi/2aNwW2CbO+gUygc9hrzTaCk90Z0+9a9eWNaGTYf6mRkz2sxJ0aMd
         zsDZ9DvkF6IZocgtzy8M/6TSysOlnQ1vJplWThedOQ6he3ilJOLpTiADCYt97V3UCC+G
         8eKfmMheqbaL3HfhfPeAfg81dL5AiJA47I8JbPqLH66VpoD9jkWYTT81+KYynCicK6fB
         rMoA==
X-Gm-Message-State: AOAM532ZgqMqcF2JB+jvYZGdZ/myObiZnowrWquz+8BuhXswo1TK/AJu
        NhRG85ws5H1SaJrTaQoRCkVjn9/pHk0d2g==
X-Google-Smtp-Source: ABdhPJyjzePC0HHPUTSZXGIzQ7CimaMWQOURrZQJFTuePWA0EjP0Bf47D+sL9WB1EaeH/MaT24X5bQ==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr4889552edq.35.1622201419744;
        Fri, 28 May 2021 04:30:19 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:19 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 00/20] RTRS update for 5.14
Date:   Fri, 28 May 2021 13:29:58 +0200
Message-Id: <20210528113018.52290-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- Patch 01 ~ 10: Typical code refactoring patches
- Patch 11: Requested by Jason
https://www.spinics.net/lists/linux-rdma/msg102009.html
- Patch 12 RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight, we
  split the sysfs_emit conversion to a seperate patch 13.
- Patch 14 ~ 20: Bug fixes

V3->V2:
- ratelimit error message for first_con check. (Jason)
- split the sysfs_emit conversion to a new patch 13.

V2->V1:
- drop one patch "RDMA/rtrs-clt: No need to check queue_depth when
receiving" as requested by Leon
- (void) casting will be removed by next patch set
as requested by Leon.
https://www.spinics.net/lists/linux-rdma/msg102200.html


Dima Stepanov (1):
  RDMA/rtrs: Use strscpy instead of strlcpy

Gioh Kim (7):
  RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
  RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
  RDMA/rtrs: Define MIN_CHUNK_SIZE
  RDMA/rtrs: Do not reset hb_missed_max after re-connection
  RDMA/rtrs-srv: Duplicated session name is not allowed
  RDMA/rtrs-srv: Fix memory leak of unfreed rtrs_srv_stats object
  RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and
    stats->pcpu_stats

Guoqing Jiang (6):
  RDMA/rtrs-srv: Kill reject_w_econnreset label
  RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
  RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
  RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
  RDMA/rtrs-srv: Kill __rtrs_srv_change_state
  RDMA/rtrs-clt: Remove redundant 'break'

Jack Wang (2):
  RDMA/rtrs-srv: convert scnprintf to sysfs_emit
  RDMA/rtrs-srv: Fix memory leak when having multiple sessions

Md Haris Iqbal (4):
  RDMA/rtrs-srv: Add error messages for cases when failing RDMA
    connection
  RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
    stats
  RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
  RDMA/rtrs-clt: Check if the queue_depth has changed during a
    reconnection

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  58 +++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  14 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 163 +++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   1 -
 9 files changed, 146 insertions(+), 114 deletions(-)

-- 
2.25.1

