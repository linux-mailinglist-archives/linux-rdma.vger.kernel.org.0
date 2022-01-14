Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1C48ED60
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiANPsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 10:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiANPsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 10:48:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02887C061574
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so5609523wmb.1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 07:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veg5W3bweatOvJg7Kra9dyvXIH+yJd4fFUwUnAFuRHk=;
        b=CQREACLntKPXWPCe+F0OsUalDBvlohAoPX4PsC/neemXy7zuf3l8Y6o1c3w7MNV6Su
         mkbu89IgOjiS2kOHNyBLxlRs3fX6/C+i7xIhujRwMl3/va3fn1vlHTjAEGPBUAVYA3Gf
         87G4n1sLWoLGOUwoRBVfMcAJcSxyjZZ+D2ixtUCxUjpeGdOWSl39k26zojrn1BvjLEqQ
         IaS0I9rIOXf8m/l8DfwiypOU2rCk1Rm73iUYQ6JQtL0thwKNjbb7D5OCzTHAnKcTsKjP
         UfWX1vZM9OLSUKJCvHOSt4iHD9Mvdufucf3UIHjLXen1/CebKqL11JI9Hgkls2VRkvEZ
         kcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veg5W3bweatOvJg7Kra9dyvXIH+yJd4fFUwUnAFuRHk=;
        b=CW8X3cblxJmngevSsNyQYavDwzuMUwqCJR6n5IV17+ztvvWWF+kvAo/ThuxwCXoFzP
         BYh7sBIcd43dL6Z2NrhaAfiTiVV5qxzQ+qkGA05BANKQ9m/yM45j9iCATE7D/J0wwRSL
         d87ufLqCnhJfzNCdRyKr9hfUEkGuXFoJ67VYB+o9M8nbQJjgfs54oDwkwYsXNfz4HmRH
         3kNCsInAALtmEvoywjwG7YI+mjahseQqZ/RGLokfVZY3GfF4E6sJ8emBD3HilAFZ6nRA
         8VH1wgy3yu4lzPm5O/j1bKZtAanwFpLje/P4Ugwe73nFYlAKnbB9mwG76V2bTcvYwiwb
         Sy3g==
X-Gm-Message-State: AOAM532vXy9yWH2EYYUPD+lX2auye3VwkrIkgOyhdAD75k0xsP0/LEZH
        Cfqbt6HAWrDP8t4ElNUVY+MHjnkoUA4WrQ==
X-Google-Smtp-Source: ABdhPJwr7I50A1NI0AzNpz9LHunhIatZOv5oNOw1sigaDP9pxNr45k8XWqU9z44xrNSGJkMPExK6FQ==
X-Received: by 2002:a05:6402:1d4e:: with SMTP id dz14mr9528797edb.286.1642175284542;
        Fri, 14 Jan 2022 07:48:04 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id x20sm2522028edd.28.2022.01.14.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:48:04 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/5] Misc update for RTRS
Date:   Fri, 14 Jan 2022 16:47:48 +0100
Message-Id: <20220114154753.983568-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

The patchset is organized as:
- patch1, patch2, patch3 fixes warnings generated from checkpatch
- patch4 updates a comment.
- patch5 In case of error, performs failover earlier & avoids deadlock

Gioh Kim (3):
  RDMA/rtrs: fix CHECK:BRACES type warning
  RDMA/rtrs-clt: fix CHECK type warnings
  RDMA/rtrs-clt: fix CHECK type warnings

Jack Wang (2):
  RDMA/rtrs-clt: Update one outdated comment in path_it_deinit
  RDMA/rtrs-clt: Do stop and failover outside reconnect work.

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 91 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.c           |  1 -
 4 files changed, 47 insertions(+), 49 deletions(-)

-- 
2.25.1

