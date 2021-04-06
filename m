Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEBE35531B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbhDFMGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhDFMGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:06:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC103C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:05:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qo10so11132372ejb.6
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlf16P6rOs6cEXE8LkUl1ZfiMhJykBCVyfD6gOgXukE=;
        b=e/mhRR3Trh5ycSU2RlJMDHXGgdfqCnjEk/lBkDmHLQ6jBemqxtg1XsObwlc9gc1zY2
         ENpZzYaO6c2Gj9gCsr4adeWtQSIEEJqIfPtuNXaF1b5onpQp7sR9pL2Jf9m4YICMPgG0
         18/Y/VI96q7Km1CwPvHGMRQKR1yK5JsR2FiVyAtUKzl7ceSCWukUtyJf4B65PuI244z4
         kYrOSnHZqG94uAiaWgpUqK+pYvwAsckRxiOJJSfAqZZvx3a+Z5Xpwte8imCfVB6xcJ3Y
         pD89Tb0qE1OM6nxsAs/J3mf23TcpaPkzFTzL7Jy6UVj9f/fOvdR2+3SmrjwJ+UaILbCi
         mW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlf16P6rOs6cEXE8LkUl1ZfiMhJykBCVyfD6gOgXukE=;
        b=oOuQhLc67KF/3UimvzTwL4kQGC+PoScjyniFX2yrl68zXQbbzY4b7bHMcWTgTnJbNQ
         677ur1ZXVLkUjKSHUxbQoifpZqd5RNLC+MFsBRhFOu9QKZL1atJjC8SGui3vn2EyeBca
         2NhWZpUUL/gqI8Vq6A3U5RJ7aiiBgjKlysX/67RaByLmGgvN8dk3ZO3WxdvnvOiinkCb
         DRXkqm9Q7aOf2P+f0liABnRVm2erwl2blfpiETcSEExT0ifS+Mr/ZlV2hHJkQmYsE2ka
         cRhNWODUKETHz3Tm5D+Wkp1ZWiGWcIkjdxKDAmJVHtC4GHxCqHJwwzEpVov4ZnOIh9TH
         PCtA==
X-Gm-Message-State: AOAM530OrUqJI9ItkEBurNXTQVSX+J1xNaJV7Ua+eV64387YWvC6IRON
        nmZNF1IxQvfhxJmkkvrcZESK+Pi8M+R1Yz3W
X-Google-Smtp-Source: ABdhPJy8X/Pz2FvSKx8sKpkENc/rygNvVNg6WNY+gdMbRo1SxMktw7J2TucFrtwiu7PfQLcd9pxVvw==
X-Received: by 2002:a17:907:1184:: with SMTP id uz4mr10108561ejb.465.1617710755217;
        Tue, 06 Apr 2021 05:05:55 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id jj15sm10987694ejc.99.2021.04.06.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:05:55 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 0/4] New multipath policy for RTRS client
Date:   Tue,  6 Apr 2021 14:05:49 +0200
Message-Id: <20210406120553.197848-1-gi-oh.kim@ionos.com>
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

Gioh Kim (3):
  RDMA/rtrs-clt: Add a minimum latency multipath policy
  RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
  Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy

Md Haris Iqbal (1):
  RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its
    stats

 .../ABI/testing/sysfs-class-rtrs-client       | 12 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 34 ++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        | 60 ++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h        |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h        |  2 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |  3 +
 6 files changed, 108 insertions(+), 4 deletions(-)

-- 
2.25.1

