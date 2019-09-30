Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6241DC2AAF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfI3XRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37597 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3XRT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so8253254pgg.4
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dw6LcD+rPlGASnCj2Y1Cm5MoNmcMhS9zPQWiSG8HVIE=;
        b=Qmh98TTqpNXBtGz4aFTpgtWY1XTYUwggh8pX7qo3ik2NkvrDK8zoZwkiH24Xl7qsgs
         tDygVviQcCgUhFPpmGn0jLy4ZzXVc0la1TBl8F0SPAjcDT8JgLRhCAMsMl2YwPbm+Dwt
         IYWuq3WuQFGxvQy6jRh+KyIyHAQaJG5FXrIr6rx+OxejXt+J37x4w1rUXWqs18EKvpGR
         PWCD3D0F+LH0xxVL7cSF8W7gkzqJmZQJI1BZSyBtxGy3N7084Jd76P5n9UCI0r33N8qi
         Slzv4QvHYwgImKHp/t+ZYXQd4I/d3y0oCvyIL0tzcQcp7zYHmgqRGY1msX+l/wIddIyT
         cI6w==
X-Gm-Message-State: APjAAAWoSbaoG8vc6syFTp83B4lg1m6vlRe157xKBffXMeTsBMMGzjbH
        b8RukSND/fgXVtnSIbh1YewC6eSd
X-Google-Smtp-Source: APXvYqxqkR7Sv/S7snz5g3+T78YUIkgWNYhE+/c+NxtNIt7v1Dx6Ksovfchr9GEgHCETGawMSyqzTw==
X-Received: by 2002:a62:b606:: with SMTP id j6mr25420656pff.254.1569885438528;
        Mon, 30 Sep 2019 16:17:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/15] RDMA patches for kernel v5.5
Date:   Mon, 30 Sep 2019 16:16:52 -0700
Message-Id: <20190930231707.48259-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

This patch series includes my pending RDMA kernel patches. Please consider
these for inclusion in Linux kernel v5.5.

Thanks,

Bart.

Bart Van Assche (15):
  RDMA/ucma: Reduce the number of rdma_destroy_id() calls
  RDMA/iwcm: Fix a lock inversion issue
  RDMA/siw: Simplify several debug messages
  RDMA/siw: Fix port number endianness in a debug message
  RDMA/siw: Make node GUIDs valid EUI-64 identifiers
  RDMA/srp: Remove two casts
  RDMA/srp: Honor the max_send_sge device attribute
  RDMA/srp: Make route resolving error messages more informative
  RDMA/srpt: Fix handling of SR-IOV and iWARP ports
  RDMA/srpt: Fix handling of iWARP logins
  RDMA/srpt: Improve a debug message
  RDMA/srpt: Rework the approach for closing an RDMA channel
  RDMA/srpt: Rework the code that waits until an RDMA port is no longer
    in use
  RDMA/srpt: Make the code for handling port identities more systematic
  RDMA/srpt: Postpone HCA removal until after configfs directory removal

 drivers/infiniband/core/cma.c         |   3 +-
 drivers/infiniband/core/ucma.c        |  17 ++-
 drivers/infiniband/sw/siw/siw_cm.c    |  45 ++-----
 drivers/infiniband/sw/siw/siw_main.c  |  11 +-
 drivers/infiniband/ulp/srp/ib_srp.c   |  15 ++-
 drivers/infiniband/ulp/srp/ib_srp.h   |   3 +
 drivers/infiniband/ulp/srpt/ib_srpt.c | 186 +++++++++++++-------------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  34 +++--
 8 files changed, 156 insertions(+), 158 deletions(-)

-- 
2.23.0.444.g18eeb5a265-goog

