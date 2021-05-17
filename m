Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E710382810
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhEQJUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhEQJUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284CFC061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b25so8132102eju.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sp3GThisTF08ImQ5ACX15e1wHRDCtHLH2KD3I/sz9ig=;
        b=eqousOsV6DQBssl3XD/jxmXqkSQ7YmxQNn1i0KjT7yWUtj1RoSw+zaSIDs48T6RbUu
         pcIUfW1InRMQD4wRPhdoGy6t9aM4N8vwR1oArArQUW+TAxBgSGgGfogF+FT0WV6IanYA
         oRQKCUlnMdz5cBQXTsQqXMv5WkOpLzRR336SlX40AG0BjgIHWFjCqiRnXpTs6iwxFk4P
         Vd2kHdW3sVu2mZd7gWq2artMyLGpGOKw9TbYAwSHBqHLU0uikAuhUsPkUeXL7YGcAh+j
         qvk9/9kEXaIhj0ni15QCYC6dojdYwYhftXcARiz+Nq0A4VyR77Wa8U8RWGS9ot8Dkz4r
         7zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sp3GThisTF08ImQ5ACX15e1wHRDCtHLH2KD3I/sz9ig=;
        b=BwYV7Df68+U8CfXXbhxQ6C3ohruA7ZXXlCJO1ztG3/ANw36tABrRlxwIoBpTXk3SAF
         c+pZTWAegOTEjliMIeeg4iqtAoWlqTftQenStBRWVxPwu27tqawYy1EMEqdTgAnY6SHk
         ++YH9vDRdmc0tMFBsZcsLOfk8UL1B7LLeCacJR+i6HUPeb+AzNczJiOc76Gass7o+8lx
         dXjiKG0FGi2itXqAXMN6ZkDSd25EypqrIokGi4Q5B7i/sBeCUIafB/Gb7B3PraoGMXFq
         Exr4ZuVytUETBlvQvlSbtPxmSWDSY3y04Pn78b+GoUdblzrErPcCGUAJogWYQRZYVDsZ
         9TJg==
X-Gm-Message-State: AOAM532WC61fs7n7o/FW2d7YbJIVW86AoiRLcH9RcUyIeAUGuPOtnY+b
        TNFunJw0yV2b3rlQz6U1Hn4e0FXdhLkTJQ==
X-Google-Smtp-Source: ABdhPJwCmBrBQiT3EfPYSJsnPjEs4im9Qk1+bL/LH3h3i3YZHzM11Xvos8iQfGmECqnceMKB1i9blQ==
X-Received: by 2002:a17:906:cc9:: with SMTP id l9mr19026104ejh.454.1621243155762;
        Mon, 17 May 2021 02:19:15 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:15 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 00/19] Misc update for rtrs
Date:   Mon, 17 May 2021 11:18:24 +0200
Message-Id: <20210517091844.260810-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- Patch 01 ~ 11: Typical code refactoring patches
- Patch 12: Requested by Jason
https://www.spinics.net/lists/linux-rdma/msg102009.html
- Patch 13 ~ 19: Bug fixes

V2->V1:
- drop one patch "RDMA/rtrs-clt: No need to check queue_depth when
receiving" as requested by Leon
- (void) casting will be removed by next patch set
as requested by Leon.
https://www.spinics.net/lists/linux-rdma/msg102200.html


Dima Stepanov (1):
  RDMA/rtrs: Use strscpy instead of strlcpy

Gioh Kim (7):
  RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  59 +++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  14 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 163 +++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   1 -
 9 files changed, 147 insertions(+), 114 deletions(-)

-- 
2.25.1

