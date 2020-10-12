Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B28B5E0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgJLNSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbgJLNSS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB5C0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i5so16888995edr.5
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvirsXnJVSAT6v2zbz7MZzJ59bABXt7Pd4zHTcU+YVo=;
        b=gr/+DNf6iy25kgT/eVWuLGAWv10XgmQexRjz0wK8X8Rg6gE2L0EfL1c4TwdJf13yqj
         mulcH6bBdK3LtnUJbXpg3DzC7ED0OqxAStD6lm7w+TC4abpMee1IsnDEWzp0rJbWu1iV
         Aqydnvr2mPa0o1STbqhV47/u487te1DRNfy0oOrCP2Tv00VoXUZkjo4v1mTTSJPeO7am
         lEUOC9aOC9QaLD+6wEF+XZnr/RFU1L3ZKcGQG4xIYS58uUzBqJh1CuAy4s0MiZhYjN9V
         0KOvXNl5MR2wEaB9V57JWEq3OhtTTRfqyBwBS6Wi3eHTEcSf9PdXxeJ1WvkcdFCXhGJR
         X6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvirsXnJVSAT6v2zbz7MZzJ59bABXt7Pd4zHTcU+YVo=;
        b=hrdgzZp/qiv8TijjETDtdAOzm8JHrQRZ5YN1jYu7YujZkd4N7Y4Kyhdynk0p7VDaV1
         DQWilYBVdtdgUHmatZOP4ZLjv7ii/9P17xqzbr8lTtQLVQVdrYLi9jI7k/1D0FMdczkK
         m3hGfgOk91RQ6f6rUiUoCfiUZmdjsFKUdv/zkXriRICL5dBh+5r3q0qIvfmHoWOHgzLM
         MaXnUmphOf2H3n4Bl7S0iLsTTrmdLlvZjowtlYDJiVY5vg9HChiVmd9OBc9mZdf5MHwO
         A7064B3qBOS2HGNiZia6woBLmhVGjVELHMOz/hwJOBPNDF3iARThRpibQzclOO69djgj
         lUWA==
X-Gm-Message-State: AOAM532i1jVu044HU935CwJVtd0zOdgAvYPRe8K6jGn5/iM+uzev7gHK
        8OGJLtTRtb9ErMeX1Msuub8tcb13oQi99w==
X-Google-Smtp-Source: ABdhPJwfgpW4DiWJjBXQ2G6SkT7uXaMX8fZK0yRm+UlQgB89LN1OrUr/oaSFyFxggi2WERZY/WKLZA==
X-Received: by 2002:aa7:d892:: with SMTP id u18mr14563667edq.305.1602508695768;
        Mon, 12 Oct 2020 06:18:15 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:15 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 00/13] rtrs: misc fix and cleanup 
Date:   Mon, 12 Oct 2020 15:18:01 +0200
Message-Id: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to upstream.


Danil Kipnis (1):
  RDMA/rtrs-clt: remove destroy_con_cq_qo in case route resolving failed

Gioh Kim (6):
  RDMA/rtrs-clt: remove unnecessary dev_ref of rtrs_sess
  RDMA/rtrs: removed unused filed list of rtrs_iu
  RDMA/rtrs: remove unnecessary argument dir of rtrs_iu_free
  RDMA/rtrs-clt: remove duplicated switch-case handling for CM error
    events
  RDMA/ibtrs-clt: missing error from rtrs_rdma_conn_established
  RDMA/rtrs-clt: remove duplicated code

Guoqing Jiang (4):
  RDMA/rtrs-srv: fix typo
  RDMA/rtrs-srv: kill rtrs_srv_change_state_get_old
  RDMA/rtrs: introduce rtrs_post_send
  RDMA/rtrs-clt: remove 'addr' from rtrs_clt_add_path_to_arr

Jack Wang (2):
  RDMA/rtrs-clt: remove outdated comment in create_con_cq_qp
  RDMA/rtrs-clt: avoid run destroy_con_cq_qp/create_con_cq_qp in
    parallel

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 103 +++++++++++--------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  33 +++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs.c     |  61 ++++++---------
 6 files changed, 82 insertions(+), 123 deletions(-)

-- 
2.25.1

