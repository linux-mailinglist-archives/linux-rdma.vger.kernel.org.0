Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB2356B50
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbhDGLfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 07:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347371AbhDGLe5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 07:34:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291D4C061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 04:34:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p4so10152612edr.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yEn1S7vRpSE4v84fcQ+X2rl1hB3xf/Gs67lTQQGsts=;
        b=dDLaxLBftjgt05EaLzDMDqMR/tqv4rkKNABP2+cwhZjSthf7NE7M+CuQF89RR5kFUB
         Ic7u92kNQSM9Vvkdj/CuowhrDWuM9G/Z24vx28A3O4hn5bICF1MnS8lXkrh3I9kjdTCf
         WOQizeaY2tmBMat5Dt2dkvoYJGbj3BWJcGZKvv9fileHrqVKPlP2Og00Lozfwa+7nIIP
         kLhtz2ZY7wnD3dJlpqKOQwvhg4XU2iddr3r5wLlsWiWqKHUfBLJp7w4xG0MKGnPitNP5
         kqg9RcI19WbS21bAs5CU4CsSIWNKpFxmQaKwxJot/a8xRl1O3goT+WCcDtrGSAf12oCb
         6MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yEn1S7vRpSE4v84fcQ+X2rl1hB3xf/Gs67lTQQGsts=;
        b=HXvJ7BCL9L/R3UvhqGVKnuIgp+LECHaOK20pIi2Grk6Sdq5JPqnlpkKsZGMqTx+PGy
         ++2vRq6tWJaKxsOMtYamASw8UpH39MTY22tg9lMRvEAV87Xt4TNrR2xRfWi9ADEwO4Gu
         25pUJaSrBWRDLo9DU4pgjYsaT0gL1ot3Tj3ROluuGULy1N46MUNYugtYlOhrnf6Kt+ex
         EACSBCBVmR8QQu0Ii/7R/SPS3TKAkxYaqD2LdNw1/d2RNDITffi3k2Piw6ypDbP1zZAR
         C8VfcnG8Y7JsZcZM6WvfFa52KCKztzGVxfkn6OkR3KaiF2f4cP4UKGkEV7wLPgIOASZo
         PMYQ==
X-Gm-Message-State: AOAM533Yan+/DA1D0PQsWzmaxMeBz6+JZgmPyh77TO/eWeYQfBMdLqLH
        /QTXwIhFbxRgIOSfDyQF/fmz7CIirVHha0hG
X-Google-Smtp-Source: ABdhPJwcD6hpnlYqx3O+nCYkxR7aJTwbp1CcD2MavTEMnbbV59kluKk50tKhjuhPFJgABat5rwluDQ==
X-Received: by 2002:aa7:da97:: with SMTP id q23mr3779336eds.180.1617795286835;
        Wed, 07 Apr 2021 04:34:46 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a9sm15491186eds.33.2021.04.07.04.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 04:34:46 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 0/4] New multipath policy for RTRS client
Date:   Wed,  7 Apr 2021 13:34:40 +0200
Message-Id: <20210407113444.150961-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set introduces new multipath policy 'min-latency'.
The latency is a time calculated by the heart-beat messages. Whenever
the client sends heart-beat message, it checks the time gap between
sending the heart-beat message and receiving the ACK. So this value
can be changed regularly.
If client has multi-path, it can send IO via a path having the least
latency.

V3->V2: use sysfs_emit instead of scnprintf
V2->V1: use sysfs_emit instead of sprintf

Gioh Kim (3):
  RDMA/rtrs-clt: Add a minimum latency multipath policy
  RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
  Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy

Md Haris Iqbal (1):
  RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
    stats

 .../ABI/testing/sysfs-class-rtrs-client       | 12 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 35 ++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 60 ++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  2 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  3 +
 6 files changed, 109 insertions(+), 4 deletions(-)

-- 
2.25.1

