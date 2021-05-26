Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED8390FD2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhEZEzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 00:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhEZEyy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 00:54:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E2C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c3so337416oic.8
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ0doLod747i+Hirggcyc5NIGETCnQNv1L9xB1gXwpk=;
        b=HurmO38lzW6v1PcEvZIH5bIgwGnpxT3RTS2ZSwucSqEa+S5Z2C/uCb+o+x0SsdKMmy
         uXzxzYpjr9x/LGxzcgP1qRUNS5lehAJ95SdV8jIk8k+IQPQNlTpgsIEZcwTlQxcRdU5t
         OegBdB+YITyJitujdyU5xmruW6iYnHwGFMA2aUAX8s01X0lcD80i++yH8GAXBd4dKy44
         RYYJRTq+jlgVE5FR+vhWxqQXp1MKxyWboAdDuCMWg/KV7dCor6nieE+CRcbb5HT50gyD
         wtNe4s6U2RA0D15CE5bxvd5YZg2GHTJ0yEPn2ZDcpmDwUzfT4/mnXqFMCyiGV5jeCX4W
         z+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ0doLod747i+Hirggcyc5NIGETCnQNv1L9xB1gXwpk=;
        b=nqih0TfjPSwGC1SuLQkc81TYjm/OxQWlOFf8CRot6ZuJpy+Bbfmd3UnMYifm43IqQy
         kbj2gjbC/9wYuwcL2Ed3WVsWxEuQZtgic4c/b8UV58G3AFqKGV58dCkvNXRh78/5eq5Y
         mJRv387QM+vaDCE5O0O2ZsYsmW9raIySrgnT5oYeOrgT4p9LzscA7d/LcchOkfRYq3gc
         LVR7QLYgU5k9Rw14ls0FV071UEcUoH1sZGCvnO4TDvvqubMiS2nD3VkxhNAD+93jvANy
         GALZhmYKf3hvvCVoiXFphCHbkfyAx3Uik1trZ8MJH8fI94rvZn/SONnjuxVPLR7oHOEg
         1W7w==
X-Gm-Message-State: AOAM531q8lqjhuJGdl/xnl25Bl9X8+7H0Zx0DomjFCoIdtleAd/A1kjQ
        5EJS4s8cCLxtKhGlZAiMb9Q=
X-Google-Smtp-Source: ABdhPJzCH0tAHj00htUzJmP9Q9O6j/Lsx3cp7qNLyL/OxmA0Qb28WCM9GfoVxnWJufMfveh7JjzmIw==
X-Received: by 2002:a54:4690:: with SMTP id k16mr652245oic.57.1622004741091;
        Tue, 25 May 2021 21:52:21 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a858-04cc-9df4-eb0d.res6.spectrum.com. [2603:8081:140c:1a00:a858:4cc:9df4:eb0d])
        by smtp.gmail.com with ESMTPSA id o20sm4186543otl.2.2021.05.25.21.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 21:52:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/2] Fix memory ordering errors in queues
Date:   Tue, 25 May 2021 23:51:38 -0500
Message-Id: <20210526045139.634978-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These two patches optimize the memory ordering in rxe_queue.h so
that user space and not kernel space indices are protected for loads
with smp_load_acquire() and stores with smp_store_release(). The
original implementation of this did not apply to all index references
which has recently caused test case errors traced to stale memory loads.
These patches fix those errors.

Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Added a way to distinguish between user and kernel indices.
---
Bob Pearson (2):
  RDMA/rxe: Add a type flag to rxe_queue structs
  RDMA/rxe: Protect user space index loads/stores

 drivers/infiniband/sw/rxe/rxe_cq.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |   8 +-
 drivers/infiniband/sw/rxe/rxe_queue.h | 181 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_srq.c   |   4 +-
 5 files changed, 145 insertions(+), 64 deletions(-)

-- 
2.30.2

