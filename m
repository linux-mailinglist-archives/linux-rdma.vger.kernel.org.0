Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3974857EA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbiAESHM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiAESHM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 13:07:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B62C061245
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 10:07:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z29so165264163edl.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOA7cQZGZSkH+Vt7FU073b/2VPF6/ZlsEy7TqOsThXM=;
        b=HimojwbFmDgouPWfW+ndJT+4sWisX3zIeKLmvO+y/A2SnMKEoLVXp8yIBYsfKIveaU
         D3WH882DK1gc0vDZAWgstCXGCWcYfaOik36eK5oXhkeAHdFOUOOEe4SMFGuQisngkzQj
         YHFd+dZY5VEXeScg0A4H/87KnQatry8w5oHWAvhLAG+CY3Evle1HhePaOgwAtR2iF5Uj
         /AgiF6H7ObbHvh6OZ5ZyyQQzq1o0tMvFmrMb8Vq2HY/ITvsAkUTGJe1jJ/zp7nYaz5lM
         soE6JkK9akHoXosF92yK/BIYkCZ3kzdqKnc37tcEiIlnj98VkmnIFIdD3kaP38riNeDF
         2Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOA7cQZGZSkH+Vt7FU073b/2VPF6/ZlsEy7TqOsThXM=;
        b=KiFw+2Uwt7UvJ1WVepF1ePQ0PUUiEIuqz7hwfUw8nfCz7bHpqbqKI6jNl0wJslJLgf
         HOov1Fh8R9i7Mmec+c5QtQ1NzEie8rRLecGsgpr8XJO7zuhjRcOXymGUCf3u6gEkU+If
         mCPYc07zlGDy4iPtDsEr4wQ9lFdMRALhp/9VzoEnf58pVhJUO7nLX0bmrhSRa8tDdtDR
         9P3a70i3B1XpREi26livfsJLqf5Q+rh7FYSnifENncuPDrkS6ZFF2Ma618Y/dkCnpwQ4
         vqdICPmcNDE/4z4N4h+RWGgC6DMavqdwfobGrluZ0p19yFz/vHPUoAKj9pggga8TJp37
         y5zg==
X-Gm-Message-State: AOAM531R2aB2lN9TvCBU642NZk+y1Xe9V10TyBSlQleabaRmFYoqGxep
        VlhOMV3MbT7tiQ6rSxduTBMpWMyuMApOfg==
X-Google-Smtp-Source: ABdhPJx9ZQFaqxPsghQ2YYWyGFNZarxMn92CP8FHuhGEbHrqjpwhTt1uG0jAwWa2dMYD1k27hhqW7A==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr54323293eda.287.1641406030238;
        Wed, 05 Jan 2022 10:07:10 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4592:200:545c:cb34:8a20:aae1])
        by smtp.gmail.com with ESMTPSA id eg12sm15970910edb.25.2022.01.05.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:07:10 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        vaishali.thakkar@ionos.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 0/5] RTRS renaming
Date:   Wed,  5 Jan 2022 19:07:03 +0100
Message-Id: <20220105180708.7774-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

This patchset from Vaishali, renames a few internal structures to make
the code easier to understand.

rtrs_sess is in fact a path. rtrs_clt/_srv is in fact a session.
This is a mess and makes it difficult to get into the code.

The patchset is based on rdma/for-next:
c8f476da84ad ("Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux")

v3: rename a few more variables in log/comments. (Thanks Guoqing)
more detailed changelog in patch 2/3/5

v2: merge first 3 patches to one to be bisectable. (Thanks Guoqing)
https://lore.kernel.org/linux-rdma/20220103133339.9483-1-jinpu.wang@ionos.com/T/#t

v1: https://lore.kernel.org/linux-rdma/aac5544b-279d-35f5-6f19-eb0301294122@linux.dev/T/#md5be427877cbfcb1741cccea4d081df09ae18561


Thanks!

Vaishali Thakkar (5):
  RDMA/rtrs: Rename rtrs_sess to rtrs_path
  RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
  RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
  RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
  RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess

 drivers/block/rnbd/rnbd-clt.c                |    4 +-
 drivers/block/rnbd/rnbd-clt.h                |    2 +-
 drivers/block/rnbd/rnbd-srv.c                |   16 +-
 drivers/block/rnbd/rnbd-srv.h                |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |    8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  145 +--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 1087 +++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   41 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   18 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  121 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  684 +++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   98 +-
 drivers/infiniband/ulp/rtrs/rtrs.h           |   34 +-
 14 files changed, 1156 insertions(+), 1120 deletions(-)

-- 
2.25.1

