Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77810ECFB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2019 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfLBQU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 11:20:58 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42458 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 11:20:58 -0500
Received: by mail-yb1-f194.google.com with SMTP id a11so172266ybc.9
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GpJfhLpUlzG6giWLXw/K7NLcXUw8jRJZCqf4beMRe4w=;
        b=cxyRLGeCFiLWz1t31wUjnVPQh7F63uuCULX4APG3cy56mjlLFFtzSwnoECV2m/Bkmg
         y2XrZVRbE2F4Ax0mo2DICMt2E+XnMAYqNqhklf0Hff0kei2MhyoFBWNNvoTkh6lOu4Qn
         BN7F0aHV5SxJwSaSOkOAIzJ0L9KE+I14snTz0DPzjDojllSFvFsMYE+4xxZ6RNZ5W/Rd
         JNM0UIZwxn3eFDfC9amZhm/F6ptgcda1FngQVHPUo1cXUu92jwzAc9jsVU7A7GhkZagw
         S/yc4YVFA4DkdvdjSWZ3kQL4c4brcquTAGKHA5z3bf0tK+CvzrFYIc93NthmyTxyeNYy
         hsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GpJfhLpUlzG6giWLXw/K7NLcXUw8jRJZCqf4beMRe4w=;
        b=LUomFnwrqMwDsM3yLVF0dc9RqAlYX7MCrUmub2/nxCsGHM8RwOsYV4J6E6rOaM/lup
         ouSS4GrQht9Ns0cL6YJvCf+snwbqGE33oaD8ZgdeyHL96vaWZfIb4mdC4nkaj3O1W38X
         cwXGPZt+t9XP5FfW92NfbLV/13es4cgobKBEtx7O/p15cY+OCSuSvnJijKtkbqmVYNLA
         xHsJc1YdnrO4uc5Jq4n9bk0J+mHs/bymvVjKN8UWqqp5PVEJIE6yD7NMIun2A0jwn7GT
         x5R1uzHDUY7gGRkn4ehD/sem1/2Nvq9b7SX6khqD89q9+VlgayZCsvtJfmmKekyn5GjC
         PC4w==
X-Gm-Message-State: APjAAAVLfeB/T+RgWWGmkZIfqZZc5N20AdbqLVWyRNKg0IUfS54Hc/0v
        PVTywtxArRlj/p/o4342sZV2kb5V
X-Google-Smtp-Source: APXvYqyZN/vWSc9kU2mpnr5NIxyYD026jyRHW8cI5zRXx7YMKqgO/MYuLunQAzetR2LhccJ3FxZ9iw==
X-Received: by 2002:a25:c08d:: with SMTP id c135mr197163ybf.100.1575303656944;
        Mon, 02 Dec 2019 08:20:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m16sm17473ywa.90.2019.12.02.08.20.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:20:55 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GKsv3014242
        for <linux-rdma@vger.kernel.org>; Mon, 2 Dec 2019 16:20:54 GMT
Subject: [PATCH v8 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:20:54 -0500
Message-ID: <20191202161518.3950.61082.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

Refresh of the RDMA/core trace point patches.

I've been working on improving how RPC/RDMA handles device removal
and disconnect, so I've added some trace points in the core CMA
code to report rdma_cm_id lifetime-related events.

I've also had need to record creation and release of MRs. I had an
old patch to do that, so that is also included here. The patch
description can be improved, but it's ready for review comments, at
least.


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


 drivers/infiniband/core/Makefile    |    4 
 drivers/infiniband/core/cma.c       |   68 +++++-
 drivers/infiniband/core/cma_trace.c |   16 ++
 drivers/infiniband/core/cma_trace.h |  302 ++++++++++++++++++++++++++++
 drivers/infiniband/core/cq.c        |   27 ++-
 drivers/infiniband/core/trace.c     |   14 +
 drivers/infiniband/core/verbs.c     |   39 +++-
 include/rdma/ib_verbs.h             |    5 
 include/trace/events/rdma_core.h    |  373 +++++++++++++++++++++++++++++++++++
 9 files changed, 816 insertions(+), 32 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

--
Chuck Lever
