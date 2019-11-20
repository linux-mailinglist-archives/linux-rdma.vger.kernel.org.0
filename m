Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24E41030DB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 01:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKTAp6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 19:45:58 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42381 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfKTAp6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 19:45:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id z67so8048888ywb.9
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 16:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tuV7xu2Rju5lQFpl5xMqpSZDCTZLHviTXghW0ovGl8Y=;
        b=erwl7dYy/OzvcW1+kL5Oz/93UJoROFNCCBHKWHm7QpGSeTjQB4EtA0gEf2vXTNzX8m
         XKBfvURUevE1FgnAzuuAJjm+wW2fL2rfRD58/dGEOg1GLO2uvT1P8qeAfQgqw4W2c4cx
         aPPB6/kwL1u6tn3MQameaw0g6Ck1UmoMOK4mMfv+Ly3s4muWoJE59QN73NvoXdlzMW3w
         vHEPKuVmV3eYIu6zMPsjRLZ7XeqR7TIqg2j3Dv+2YHaleIqEZak1VTJnTXUC0R74ABBE
         8xoADNZYoaaxv9wupUukl6KVq+ovxnMRmYw4d9XULcBMdnhgm5jCx58PWAAeiNiHZLqP
         FceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tuV7xu2Rju5lQFpl5xMqpSZDCTZLHviTXghW0ovGl8Y=;
        b=FUDLHrhCb7AZ+G4+BuJelBXfRTJtFlF4cnF83GdYv+uuvraUiHbQdoEZvJszOMlE7M
         uRzeHeiAxpH0r0LuBWhgXeabhGG42DbGGpL6DlPFQMw04o6xRQvNZnS/H1+/y3ktzXQW
         SwqFAER2ikz6f9E2+GIlKtUiyrpQh3IL81Pcpe8SoFJ/YrLtfWdBIEHSwGNXLZ+JIaes
         gsjiGk+m+mGmHSH14MpqgZiWngo9eTdH6kXPs7z3WwU5wOkAr8aag3poinZIaTQmHHmm
         i9QX4NFIuRKm3mDD5+zCfZ4t/rmubyXYitM3J5ZxKLoQWR6Ld/6uehi8Mz26uOTiVR1O
         Pb+A==
X-Gm-Message-State: APjAAAXC7lEjM2l05d8khMl31CM5DM4/wcm6RRUO0PrxZdzqW7BgzvqD
        9TFbj80cAjVJAXxDvGeMTQosHWnyGR4=
X-Google-Smtp-Source: APXvYqy0beRNVTwD61SUbZDI5Hysw9ucbgGlcORNK0wCn60MsiH6q/BJwQBRxsBxLJs4jN8swohJyg==
X-Received: by 2002:a0d:d285:: with SMTP id u127mr455697ywd.263.1574210757708;
        Tue, 19 Nov 2019 16:45:57 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 197sm10078814ywf.42.2019.11.19.16.45.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 16:45:56 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAK0jtUc014295
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 00:45:55 GMT
Subject: [PATCH v7 0/2] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Tue, 19 Nov 2019 19:45:55 -0500
Message-ID: <20191120004308.5860.40857.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These two patches apply independently of each other to v5.4-rc8.

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

Chuck Lever (2):
      RDMA/core: Trace points for diagnosing completion queue issues
      RDMA/cma: Add trace points in RDMA Connection Manager


 drivers/infiniband/core/Makefile    |    4 -
 drivers/infiniband/core/cma.c       |   59 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 ++
 drivers/infiniband/core/cma_trace.h |  219 +++++++++++++++++++++++++++++++
 drivers/infiniband/core/cq.c        |   27 +++-
 drivers/infiniband/core/trace.c     |   14 ++
 include/rdma/ib_verbs.h             |    5 +
 include/trace/events/rdma_core.h    |  250 +++++++++++++++++++++++++++++++++++
 8 files changed, 573 insertions(+), 21 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_core.h

--
Chuck Lever
