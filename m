Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58A2100E35
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKRVtD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 16:49:03 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:46184 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVtD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 16:49:03 -0500
Received: by mail-yb1-f174.google.com with SMTP id v15so7853069ybp.13
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wk6ZXhhY6vpm7U9JM9wSb8R283ePMO1QRn06jEGOPlY=;
        b=hoywfMUNj9RPR6/8zmv6CGArE9hXqHSmPj7F8S/f4RLziaEUauEnzwnvlsY4bM/NSN
         nzJ8vQf40L472A+iJnTgd8ReG97BEWTwKdJy2VeQTVvwfgIOnElGJEyfFL2PV6Hz2wrv
         nkT27xrLbHK4VzpScroFZEHMHsbViqIABk6kaNM/C1qWLvdoIqcu6lz3Cmbch1yM3qNF
         5BV5+CLNDl6vIi7/hWH+i3yAh9ytB2nSdwKNTvMQrW2r1DYOrJ18zXkSUpGYhq+3sy14
         CT375wHM07mN3ZbBZoW9yFqzXcs0FwQV2wOx3nZ6RAkFDHaGghj4JO1Kh418fzt1bUX5
         Zrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Wk6ZXhhY6vpm7U9JM9wSb8R283ePMO1QRn06jEGOPlY=;
        b=C9/cQR0C61zLLu/MoVqF9fLfQKqPJ/vwA/T3W0exzb14nAsE81fs8KXFyt1AGenSr7
         jngPeHVfxhl02VvUNGu7ebJ7/AX8wUnEenEHnWfoyNP4e9k0tD5bMsbkeXHeYPB5qqtc
         KbkMMnN7znzBlng37gaZugFJUaALWNZXHyS6wzhFdfJb1UCsWBCWvTpjnPA5BQgJxA14
         3o+CI2dDyHwnlR1TyE/6MeXcGF5B7rB/ZVW1wQuKwBW8eWGC49bLg47vz695tY0H1Oae
         g4qXXq0PTa43Mh4BWB3LReLq4Tufp7W9w1yhhBHXxbWN+q/OxGSYdPOmLhZjwFbJ5+7L
         ckbw==
X-Gm-Message-State: APjAAAWt+U7qkCslQJqBDAZ/UGto4M2z9Lk+kPw1WaBduaI2HPEaq4en
        5PjXNi80aAHPLynH4QAND9NOUCi7ZBs=
X-Google-Smtp-Source: APXvYqzHN7uhRmOlLJ85YhyqMBQ44JfXfq9ZUJJ9364fBcoNkkJgz8CzQE1sA22PwsOanfMWEC5k5Q==
X-Received: by 2002:a25:dfcb:: with SMTP id w194mr15396004ybg.79.1574113742425;
        Mon, 18 Nov 2019 13:49:02 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k125sm8489693ywe.66.2019.11.18.13.49.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:49:01 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAILn0h3011173
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 21:49:00 GMT
Subject: [PATCH v6 0/2] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 18 Nov 2019 16:49:00 -0500
Message-ID: <20191118214447.27891.58814.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
 drivers/infiniband/core/cma.c       |   60 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 ++
 drivers/infiniband/core/cq.c        |   36 +++++
 drivers/infiniband/core/trace.c     |   14 ++
 include/rdma/ib_verbs.h             |   11 +-
 include/trace/events/rdma_cma.h     |  218 +++++++++++++++++++++++++++++++
 include/trace/events/rdma_core.h    |  250 +++++++++++++++++++++++++++++++++++
 8 files changed, 585 insertions(+), 24 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/trace.c
 create mode 100644 include/trace/events/rdma_cma.h
 create mode 100644 include/trace/events/rdma_core.h

--
Chuck Lever
