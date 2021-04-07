Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F01356A10
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhDGKmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhDGKmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:42:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6BC061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 03:42:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b7so26885476ejv.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CF2lM1/w6DLAQBoUHxnVXrEjzGKtW70rTmQqxRniZ10=;
        b=gpoXOaK3qftw3z3bocDk866dptZqLKCy8UKTkcyeZi7fo2Mf0iMlakLdGVhaj98Hie
         2PMH+e58++v3cOLvFiTGzNUKaDtOlzg/XSOBD8bkGrGUMen4iDfv6tKJFrTuByDBl9gY
         KD2ETt41wuSxzZXy1j+R/5YylMsVPPS8CIE5nLLfQTL1xmv5QBdCoYvuLKu70B/JozyJ
         /v7JZP+qO78HJd2Pw2uL2DpR9oBqI7A0WWkLtgVc6r1VpoD7rrpMQFfy/uQwcNBeEQrn
         +vqH+ddwQ3cIuRTu6KLrNTbGo22ypdSoL2lgw09KCcBhxImoNBctSc6VZdGeGu5i76vd
         I0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CF2lM1/w6DLAQBoUHxnVXrEjzGKtW70rTmQqxRniZ10=;
        b=PnkWdDnz52iu1xnFFq0RVoSZJ3grv0DHdK0Ceft3TDd47eI9JYeuxNEUuJh9HztbLH
         jnRv6kZn/2gNNwAV/06zaqqbNa6szLg4VJSwO93zjCwJ3ADBiqP92rxQTcQmGucZoVln
         84JejVuwGEQBSuUDs50w7LI2eePAXM8oeKAZF5tUpAbgtW1qviAOi6uFF20pAcux55Sf
         4cwdllNoJD4LGDq7bXGYqUsqGC71+EMmuaqRQQORO0XhX1B73je745aTy75oFSLd0ccm
         xoHB84Pg5cGht+acqjsAjWp8CYT9/5E+RFDMNm4wEEYDVWOrvF7YwGwutmcQ9dikFg/o
         RWiA==
X-Gm-Message-State: AOAM531WLsw399owIgQ1TVKMIPhlawHplYEcjATaKDv7e/SxYW8bnj6X
        g1EslqMz1+nkK52RQw2ARiSRtMQNJuDtxQcH
X-Google-Smtp-Source: ABdhPJzMtjULc3FJrqroapY0spErlOm+1ReS6asLD3+uQ40X326NkNA2Bwl2JqF3cE+ilihnmpIVLw==
X-Received: by 2002:a17:907:700d:: with SMTP id wr13mr3025336ejb.310.1617792126242;
        Wed, 07 Apr 2021 03:42:06 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id j1sm12359779ejt.18.2021.04.07.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:42:05 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 0/4] New multipath policy for RTRS client
Date:   Wed,  7 Apr 2021 12:41:59 +0200
Message-Id: <20210407104203.24792-1-gi-oh.kim@ionos.com>
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

