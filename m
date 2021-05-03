Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3C37147A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhECLtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhECLtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378CC06174A
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so5902047edn.7
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlgjX89Rr/7BLuyVCwzxlD3tiv0FfQYTpRIbP6WwSyc=;
        b=R6V4q70J1yiT7d12Ba7NZUIRCNhw5jeoPnBZaVAClhXUc/wHQuG29M+XIhbollI23V
         facNTFKPnxE/HzX5t5KSmwK/iCr2EzbJtjIljYjbI6ll5IN7IRxHw+TEoJhhJ6y7TZeW
         B7SBVd2kVaOA2N/KZr9y/SP4Q2y6M1kS75Ivjm0RV5NEdMsrT3MQhl+IPdrFhR+E+cZL
         BBw521FlFAZqqeyuo4NtQNXxkBBiG3vieW63ZT02IG/N72h/vdy3Fatk5nxuAG6Koju+
         xKDXrULwdzNySUJtPnZjqKkTTFtvHt4n3fqY0LjCXY5CBSCrwswfOZTDvAm4OvF3HnS3
         IMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlgjX89Rr/7BLuyVCwzxlD3tiv0FfQYTpRIbP6WwSyc=;
        b=h8xl7/S+fvAKfB4uV7yTyk+gM/IkeK5fLIUqVXheJ67Sn/bol1epPmP9n80pdJ/LRe
         r0oxrabOhK718U/UmkxeVp44wFgy2WsHaejPwyRxpNbvsxcyepFFwPjXWUMMgESsGzMx
         oP8nP3+ZS8we11UPqeIlPWYDFeaMzZIpcf+8K2roQUmBV81Odn+o7ooYV3o926GQJpPM
         +bDbtXsEFx8coDLdHudjD4nKCIGmwDOttC0EsGLZuE2gFx3K243EmVaHJIIKnOds8pgJ
         KS2/FrkNFXgHl2ANGBekFUWJUFX+LJESykr3OnJW5WoYFxCgCf8DHpjxhWqkMxi4Wsld
         ltKg==
X-Gm-Message-State: AOAM532Ba4YOez7VJB2WOlvQqCl3f1dfeurLlR2/xr1TS/m1TKgpiRPj
        jne5I0u5zJcvHnsv/Fg5SuTzGJH9H+wduQ==
X-Google-Smtp-Source: ABdhPJxEqI1XsPOnT1nhBzUR1HIsjLA939O4+0Cf30pljrORpxY7Y+M2f7TyfpkmRa9cVElI2+O6cw==
X-Received: by 2002:a05:6402:617:: with SMTP id n23mr19638862edv.45.1620042501244;
        Mon, 03 May 2021 04:48:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 00/20] Misc update for rtrs
Date:   Mon,  3 May 2021 13:47:58 +0200
Message-Id: <20210503114818.288896-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- Patch 01 ~ 12: Typical code refactoring patches
- Patch 13: Requested by Jason
https://www.spinics.net/lists/linux-rdma/msg102009.html
- Patch 14 ~ 20: Bug fixes

Dima Stepanov (1):
  RDMA/rtrs: Use strscpy instead of strlcpy

Gioh Kim (8):
  RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
  RDMA/rtrs-clt: No need to check queue_depth when receiving
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

Jack Wang (1):
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  59 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  14 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 163 +++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   1 -
 9 files changed, 144 insertions(+), 117 deletions(-)

-- 
2.25.1

