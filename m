Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B14318571
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBKG42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhBKG4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 01:56:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C2C061574
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y8so5820916ede.6
        for <linux-rdma@vger.kernel.org>; Wed, 10 Feb 2021 22:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgRk8aXgFUYuNkIDQkrW6Ufo8omkVB0qoXylaqS5ofc=;
        b=gLQAzzDBOew83s5v8caLp1KpPeN7F61+Plhotx8nR1ABDBjQYt7YoiI6Kclup5+cAw
         9BdSUkGVteDV1nJc8ydhsP2Zgt2k5Pl4W+soK6OskpMU27M7RbKtTDmekR8TNIV38TPq
         LF8XUYi72TsZTrq6T0kEoaRmcjyaVrVtca5kgH1RMRBumgOJvepvzY0Chx3E58uHVpUT
         KrAmPXX/J5IxhlQ8OOaBI3FdCe/DOv8h96fMWl92Y0WMnBnIyZ/ho/CEu3jEqJewNOxy
         KWKFsYRb8jA42es0E9gPW3E0Ie1aWphBQvnoQ3jpZFxy6J/pb9JNjxQOFMC4Ma4KPS2c
         A7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgRk8aXgFUYuNkIDQkrW6Ufo8omkVB0qoXylaqS5ofc=;
        b=NkoECJ0cj+YY/F80NPEaWEdKkcol+FFClE1rE8ERfDzIQ3byqWbIAhPnmnZ7Q2slD2
         D8+rmqwFujpYItYl1bnLJUOjJL5O8OoUDBt4ihVvNbJ9z88k8VpOHQS0ci2032n49jm+
         XyE88vSO3CfiuIpqwoW2V/g24OduNbUS9CJkcsUUeI8s4ZIDg0J+5KdhfrkMZkGwIDuh
         jJIJH+FuF5sk5eOmno8lMjiwsagkS4F0DMIgfInIV3rXaZTWyUUp872UWM+R3sjI0SQs
         V65tMKb/9wn1qfQEnQWI51GAYf1xZvlZ19kJVy9Hw7J3EDyHAL2GqiaAhv4P+BXBt8+P
         u9iQ==
X-Gm-Message-State: AOAM5306inN+Mopuh9+h64cD7xPc/gzVLvEINZRdetGUPsCpE9X8wnO8
        HDMZJiB25EYhSKDI514Lvf67XjRmoO8WzQ==
X-Google-Smtp-Source: ABdhPJxpHUwOwyphvMJWe35S3ytO+sx6OYKhGZlzeZyQ7nvabYsLFjqbuZ1lNT0jis8vZCrXenv+4Q==
X-Received: by 2002:aa7:c58e:: with SMTP id g14mr6951366edq.318.1613026527655;
        Wed, 10 Feb 2021 22:55:27 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49a6:4a00:4d27:617f:73f7:3a8b])
        by smtp.gmail.com with ESMTPSA id v9sm3241486ejd.92.2021.02.10.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 22:55:27 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 0/4] A few bugfix for RTRS
Date:   Thu, 11 Feb 2021 07:55:22 +0100
Message-Id: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include follwing bugfix to next release.

One bugfix for KASAN splat due to we use wrong structure type when send
RDMA_WRITE_WITH_IMM opcode from me.

One bugfix for allowing addition of random path to exsition session from Haris.

2 bugfix for memory leak from Gioh.

Thanks!
Jack Wang

Gioh Kim (2):
  RDMA/rtrs-srv: fix memory leak by missing kobject free
  RDMA/rtrs-srv-sysfs: fix missing put_device

Jack Wang (1):
  RDMA/rtrs-srv: Fix BUG: KASAN: stack-out-of-bounds

Md Haris Iqbal (1):
  RDMA/rtrs: Only allow addition of path to an already established
    session

 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  5 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 91 ++++++++++++--------
 5 files changed, 65 insertions(+), 40 deletions(-)

-- 
2.25.1

