Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9575F120E9D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLPPxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 10:53:46 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41505 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLPPxq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 10:53:46 -0500
Received: by mail-yw1-f67.google.com with SMTP id l22so2620365ywc.8
        for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2019 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gzw6S9crG67zdWmMRSJia6mpZc9fjFAy3SgR5svbEao=;
        b=SeQoGd/zjnOAsJd1y/yCSC4t5mUovmynEPhnwAm1v2jY9JXBWrdflZWZkrLo9QTgss
         RUUKegPJnwK4GrYbns7xUIxQRKQHaHePla0Dn0GRSPR0tiQV/9xu7z7VbD5F13OJhws2
         G3wTAMTv9lByXCa7IdiaAo3zej6BC/KfuCITdNeDv1W9yfHlp9m19705qPfokdwmFZi6
         8XM7zkbjHi5QSTMMIr+GXkPYuoyzUfKgrbz9Nyg5+aLWXshOYBgzbd95P/7AOGFjajyJ
         aDOjUlHUtU6NZtFWHkUVpGIUgBZ6FzGpSxB6dqaKQ3g768+W1y0M8n1CAfMO1GDXvLn0
         6EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gzw6S9crG67zdWmMRSJia6mpZc9fjFAy3SgR5svbEao=;
        b=lKURH8MMMJ2/DWSXhe0YEgU70vAfIy/NrOQjN1ARdtAKTA84r4/3e2eMK6tlpPRX1o
         WZ6z8Iw82jFjUylEesOpHMt42B0KF0pj7gL8nGkL69krEphUL96Z0ZbabeBLuL/1ykwB
         OSXqPkwiml3XRv6oizKBN3/WNirBOWUeuyMmvZpnXrBaaaAFNbEwchY9cHi464tuag1Q
         IV519cl/yzkyYbGtR3+oWsX0lkdhwBJncSYIMI0oulqyFGl7BoVCp4NiMjv/pMYTinLC
         bRCtPLZ59v20gsIvOidCIUPRjxEdbXzdiRKULR4tvPO47I7Q27bhuITDHAwk9Dk4ubjK
         gXgw==
X-Gm-Message-State: APjAAAX9Is2fwOBzgktnc1HHWjqs4TY3Dtke2IH+oCwI+FVY1if/qPts
        C5FCwooo8KEMA2x8nZGZiYk=
X-Google-Smtp-Source: APXvYqzvDlAGWr81Gg/3N4K1++sbvMWNTk8e+IyfCXwFbge0VlWQ7DTT3u+3IKwXif0ZZc1p7bQNVA==
X-Received: by 2002:a81:7007:: with SMTP id l7mr19412103ywc.148.1576511625352;
        Mon, 16 Dec 2019 07:53:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b76sm2785803ywb.77.2019.12.16.07.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:53:44 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBGFrhIO014698;
        Mon, 16 Dec 2019 15:53:43 GMT
Subject: [PATCH v9 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 16 Dec 2019 10:53:43 -0500
Message-ID: <20191216154924.21101.64860.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey y'all-

Refresh of the RDMA/core trace point patches. Anything else needed
before these are acceptable?


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


 drivers/infiniband/core/Makefile    |    5 
 drivers/infiniband/core/cma.c       |   88 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 +
 drivers/infiniband/core/cma_trace.h |  391 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/cq.c        |   27 ++
 drivers/infiniband/core/trace.c     |   14 +
 drivers/infiniband/core/verbs.c     |   43 +++-
 include/rdma/ib_verbs.h             |    5 
 include/trace/events/rdma_core.h    |  394 +++++++++++++++++++++++++++++++++++
 9 files changed, 945 insertions(+), 38 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

--
Chuck Lever
