Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719CF3B6E64
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhF2Gzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhF2Gzv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C7C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v20so15917632eji.10
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCDlmqCxi4w8kgmY0n9zAvpidQK1fSA0NuOSQRDZIic=;
        b=di4Q1MJjIURk2Wp+xwVehHAXCaJidH4axBQ+18K9xr3J9W6lG1mhScVg1DZo2Wmnji
         doPXia75z68fLpNOdjRfqi/jcsE0JfmKQaJBBWbBLjIz8mB4x7UxvCMHNTXSuyEJa0/t
         hkzp4I3yTGt4VisOSDyGE2polzpMwhwYYkc+xLsdpdiocQWCdQu38X6a9Cg0r40V3pVk
         GdKvVoYEpD5f9pvkEarV6E0bUuPK5HMV9bwXTZberDiyYeifI7Xbj3LImApmHJ46prqO
         sHxXmznXDKPODQWOluUNZuGqbpHhnwA96E4+L4tj8Kbv0ekqyvV+ZQd9wC1ZK4R9Qs07
         5THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCDlmqCxi4w8kgmY0n9zAvpidQK1fSA0NuOSQRDZIic=;
        b=Io2VdRyGcXypxJkfvaO5EoJmBeQN4AXFLIV2nNrmVPtA3ihx5lPbMzmzpsx7ys0fZr
         zp7YP1QG6A3vv6bjfMwEq23e0KERSTlWk1jD1hueE84y4kNWHxW+w+DkiMGAdiuB5OvE
         AYSXvGq1SozqmmOOVPnYuq5NuRDCJKfJXw6JTbxwpTses5x3dsXkwupZ1hp/1QGYkq9o
         MpNkjDRlN7pzYHUI9hnXCuPbOR4qDCj1ujc0fFdN72v1w1R2xX0aoked8lf26pPvAgkW
         wTluBz0GRZQMBuzMduIxLg6QYtri0NbuZArYqUm/qsot4zHoIgULsroKOJybvVBjR4aB
         B11w==
X-Gm-Message-State: AOAM531C2UMvWkiYSvtKci0vvZeZB6b7Ll6PgtrOd2x7kH0D7YmCNHdt
        d3O/FdOKBjYCVEVjAY+MyEZEj7PDXjDoSA==
X-Google-Smtp-Source: ABdhPJyHuOIXIjDUqJE6YHgukCUWNjIyTrPg8g7EjTrq84eCd48Vszjb161Wi0TKbhaRVBQoY/BwrQ==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr17819082ejc.359.1624949603171;
        Mon, 28 Jun 2021 23:53:23 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:22 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH for-next 0/6] Bugfixes for send queue overflow by heartbeat
Date:   Tue, 29 Jun 2021 08:53:15 +0200
Message-Id: <20210629065321.12600-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

This patchset fix a regression since b38041d50add ("RDMA/rtrs: Do not signal for heatbeat").

In commit b38041d50add, the signal flag is droped to fix the send queue full
logic, but introduced a worse bug the send queue overflow on both clt and srv
by heartbeat, sorry.

The patchset is orgnized as:
- patch1 debug patch.
- patch2 preparation.
- patch3 signal both IO and heartbeat.
- patch4 cleanup.
- patch5 cleanup
- patch6 move sq_wr_avail to account send queue full correctly.

The patches are created base on rdma/wip/jgg-for-next at commit:
1f700757224e ("RDMA/irdma: Fix potential overflow expression in irdma_prm_get_pbles")

Thanks!

Jack Wang (6):
  RDMA/rtrs: Add error messages for failed operations.
  RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
  RDMA/rtrs: Enable the same selective signal for heartbeat and IO
  RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
  RDMA/rtrs: Remove unused flags parameter
  RDMA/rtrs: Move sq_wr_avail to rtrs_con

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 ++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 19 ++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  2 --
 drivers/infiniband/ulp/rtrs/rtrs.c     | 23 ++++++++++++++++-------
 6 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.25.1

