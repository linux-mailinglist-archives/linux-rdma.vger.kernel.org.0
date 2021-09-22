Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A24149BF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhIVMzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhIVMzL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A6C061574
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q26so6464816wrc.7
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A7B7KUJUyfyLuFkX/hhYyVnS4wp9aLy2fQmORbo5jw=;
        b=CvM9tBxQGJloLWWaYxZQBfhILkG7sgLZpvboUckxCEjQ2InMeVChM7e8r0fKnwZmL5
         rsgHuNGlfWSz+72OMCwO4ZyEx911XA8FSV636IxSgxxdJ/mQ65WhLUxvBB9yLzhpPM37
         gUF15gUVy6Ru3pQDXKg7EClkoWek1/jljL59zKnNCZy88jv5YlZfzFPs85/Idw61Bxiz
         8SBjg3wOBI6myAuKJcqbfEJwGgGzVul2IzFRfbt1aPysa4L/x14YM7amxQ3nG4Bwj67L
         SdeCl19VLUbEUqcHiLLlwrjFBf0Kz20ITAtor1D93qdECYPlFf9rZDEqTTk+vo+Vm6Q5
         V0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A7B7KUJUyfyLuFkX/hhYyVnS4wp9aLy2fQmORbo5jw=;
        b=n/CqFdFc4sTbUu9H6uDpsHKEzBARnYBND6T514bDWnurVESM49OWI+VvGfaq+Mw1r2
         9OMrISnIiMJiUbRPL6oZz4vhugCXic/Q/lj+ZZ2voqYoRXywqbkWNL12V2bGpg7L/NKr
         FGNx9NgoERDY3lwku016U+MNqbck8Atz5zslQhMImSPXEzlPtiLaMs84mUqQLB9Yzw3g
         0KzndF8x9uiLuMlN435M/aiV2qpsVYkwU0KNPqNRCj3I815PBEYaZEB0W8eeIG81C9/C
         ziWhv9CQLUar7kQQc2hRQpUOYJhVQUIA+E2Tf8OQjZu2ZJ0eFY4bfVzajXbZiuRyspzy
         XBZw==
X-Gm-Message-State: AOAM532QQgOMzRPIUfySu2L+z/pXwHEpzV5MSo+2J1/9RjryOZkpHHFN
        6yd3VPV8TwYExpCkRPCkj4y2jWmh6ZctiA==
X-Google-Smtp-Source: ABdhPJyZtDC2osQywW/cc22PJFH18xad5UUzzO4xEUVzsZVFF0K5N3KYlSFvWBGTcYNP2+gZtwXVmA==
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr13953038wry.129.1632315219507;
        Wed, 22 Sep 2021 05:53:39 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:39 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/7] Misc update for RTRS
Date:   Wed, 22 Sep 2021 14:53:26 +0200
Message-Id: <20210922125333.351454-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

The patchset is orgnized as:
- patch1 sysfs_emit conversion.
- patch2 remove len parameter.
- patch3 Fix warning with poll mode.
- patch4 Replace duplicate check.
- patch5 Introduce helper function
- patch6 Disallow special characters.
- patch7 One entry one value for sysfs

Jack Wang (2):
  RDMA/rtrs: Fix warning when use poll mode on client side.
  RDMA/rtrs: Replace duplicate check with is_pollqueue helper

Md Haris Iqbal (5):
  RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
  RDMA/rtrs: Remove len parameter from helper print functions of sysfs
  RDMA/rtrs: Introduce destroy_cq helper
  RDMA/rtrs: Do not allow sessname to contain special symbols / and .
  RDMA/rtrs-clt: Follow "one entry one value" rule for IO migration
    stats

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 49 +++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 11 +++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  6 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 13 +++---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  6 +++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           | 31 ++++++++++---
 10 files changed, 80 insertions(+), 46 deletions(-)

-- 
2.25.1

