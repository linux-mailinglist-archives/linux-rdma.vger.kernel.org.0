Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43986125308
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRUSH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 15:18:07 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36296 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLRUSH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 15:18:07 -0500
Received: by mail-yb1-f193.google.com with SMTP id i72so1290026ybg.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GdxdX5oK4XzJU09CrM+z3XIDAAXxc1KNCFcWath6hjY=;
        b=IIcg+sPhkmgrHAnH0KKtw9H08NUQTiCmWBD8+pQEqiH2g660UUmYDgCBme0OXQ2NxC
         NgYt0V4r8TvsWgu1LjPQtyzY7tziKfJb+9GZoe6aqSAVV0PM6iwf+RAqtaOAxOYrdcJ4
         SqFgB0IFjFUiC0FQHghYGIB4hngb6FIUauc75K3IbmKcTU6xM1LOqvWSzpqLq06W0Kmw
         6rIdDOLdIBY477Ehgh84kUfGOVNaNEuNIssxqSQx9TQdeNHpfECX4PKtd5jOIeHGG8AN
         siAuFNr8a359Ud5aiYkaq68j6E4VGYusya2Oosi+ltETEYs9nbsA5QX2h3RLmKVgpKr9
         m0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GdxdX5oK4XzJU09CrM+z3XIDAAXxc1KNCFcWath6hjY=;
        b=twnbqmYqRdZInH/ES8aFxITXwwtKDzmR1oFGInDbx/eDDR8ilzgRQd9eTJMCHtQWub
         iaIQmq4BihNKRkTPhGAfwHLBMEIZajAJJgHOMkOe4byPfGR3wQgrxBK6sWXMF0pJGYhy
         nArjJ0S8dLV4X25ONIsYoCzjwttOnnE/eDjuJzzpxI1OXzD6GYmc86Bg6w53wKdmiDiR
         d/N6US7JA1s1BvxNjPO1hg1AcUmxjm0vlKmQgfm+ny7ccHLgojkez4xfVxuXQ1opgALY
         4YX6iwNXARdxJJjK0ZD2SHsg7beFXh+h5j+cYKrngzwdPeT4oRbA/TljJKRQfo6Ya9n0
         MV/A==
X-Gm-Message-State: APjAAAUrJzPm3fxHC4B4h1QDs6lScedFZNRR29FLSQm736rnK+ATwBCY
        eLIo+95vMIvd1NQ3IFdskNk=
X-Google-Smtp-Source: APXvYqx9P7TZwmIlmnqgvhRUv41jKOOopuQxUVh7FwmVH+Y/DdnFpIRFja3ylO4eI58vBEFpRQMCVw==
X-Received: by 2002:a25:8509:: with SMTP id w9mr3205005ybk.89.1576700286225;
        Wed, 18 Dec 2019 12:18:06 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i72sm1378692ywg.49.2019.12.18.12.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:18:05 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBIKI40e022494;
        Wed, 18 Dec 2019 20:18:04 GMT
Subject: [PATCH v10 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 18 Dec 2019 15:18:04 -0500
Message-ID: <20191218201631.30584.53987.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey y'all-

Refresh of the RDMA/core trace point patches.


Changes since v9:
- One-line Makefile fix to ensure patch 1/3 compiles

Changes since v8:
- Merged up to v5.5-rc2
- Added trace points to record lifetime of rdma_cm_id's QP
- Added trace points in the "drain QP" path
- Various other clean-ups

Changes since v7:
- Capture the return value from the ULP's CM event handler
- Record the lifetime of each rdma_cm_id
- Include an example patch for capturing MR lifetime

Changes since v6:
- Move include/trace/events/rmda_cma.h to drivers/infiniband/core/cma_trace.h
- Add sample trace log output to the patch descriptions
- Back to the inlined version of ib_poll_cq()

Changes since v5:
- Add low-overhead trace points in the Connection Manager
- Address #include heartburn found by lkp

Changes since v4:
- Removed __ib_poll_cq, uninlined ib_poll_cq

Changes since v3:
- Reverted unnecessary behavior change in __ib_process_cq
- Clarified what "id" is in trace point output
- Added comment before new fields in struct ib_cq
- New trace point that fires when there is a CQ allocation failure

Changes since v2:
- Removed extraneous changes to include/trace/events/rdma.h

Changes since RFC:
- Display CQ's global resource ID instead of it's pointer address

---

Chuck Lever (3):
      RDMA/cma: Add trace points in RDMA Connection Manager
      RDMA/core: Trace points for diagnosing completion queue issues
      RDMA/core: Add trace points to follow MR allocation


 drivers/infiniband/core/Makefile    |    6 -
 drivers/infiniband/core/cma.c       |   88 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 +
 drivers/infiniband/core/cma_trace.h |  391 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/cq.c        |   27 ++
 drivers/infiniband/core/trace.c     |   14 +
 drivers/infiniband/core/verbs.c     |   43 +++-
 include/rdma/ib_verbs.h             |    5 
 include/trace/events/rdma_core.h    |  394 +++++++++++++++++++++++++++++++++++
 9 files changed, 946 insertions(+), 38 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

--
Chuck Lever
