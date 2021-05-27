Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC239369C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhE0Tt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhE0Tt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 15:49:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF1C061574
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y76so1920062oia.6
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBvEkafDW/r4s+E4XYG5SG1suG2j+bRDVxhf7lUBVpo=;
        b=gv0HSPbIMH70fl3LmUalf5pucSy/RjzQLRYHrFaCMK2SDrw5EtgMorciekCqlPKxDZ
         5tp5car2crM8H1WHm7NuSyg5BPH6z5Y9gfS9fDKBgook0jRGwC4O7KinYdnCiRsAcj5n
         N9ei1f1DjFhBOvLrpi+55tKh8I0KxWunjuq0S5Ssp6W+kQnydMSYKbVjEbYG1EE0oStD
         wauJi/sNBDszcRYVSvA0A/9+hRQM3OGL7HBI4oceWcQs6i1zvLelU/JKQnpURtHPzE89
         gjw2ctv+sIpyYnoweknuGRjdyKHOiaayoq/CuhMtQg6KJzKO+2NcM3En9Hv/czyk/6ol
         oPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBvEkafDW/r4s+E4XYG5SG1suG2j+bRDVxhf7lUBVpo=;
        b=DpkEuFsWy2wOPeL2HoYEuZ2JeqTlxH92ZNsEbvH0Ua/de5nU+WhuR5esipWVOycUuN
         a2VyZ3+qAiX16ri1jHeUiIIpfNOHL8VcvU9lHfOtwZfVYih+3e1ppKO6ARkfoW1oIPZJ
         x6Uvi+yVxlNv+q/l8QrYPQ/Queb6whD8YECIQdGXfjZ/oGR2e8Z3DptrqNXJ4JngfxQC
         nFz9Mvxz4L002eWnbtDa6Pur+3MrY7CY6QoCbEaxm+bm56DioKyy19fWKB4Y5yYl0yZB
         bIj4OqT1vaMFQbv/SLkpGGa265f1BlfuRhUPS0kA5lFewLrlbtSlUc8qep1Git66K3Mh
         /fgw==
X-Gm-Message-State: AOAM533zm5Dvn1JYLoKDTrH5/69T0JTuVSFi02iMYAWWzORjtDjEU7ED
        l6S3GYNt1M+jL5Jr8LqaVow=
X-Google-Smtp-Source: ABdhPJwOM9B47lJGxxyYjbjoGhazRPOh7JFnwc3rO/EXAbFVtEhtnHIN2b6NZjaUWRxCSKkIOMbHLg==
X-Received: by 2002:a05:6808:10cd:: with SMTP id s13mr6850422ois.113.1622144873757;
        Thu, 27 May 2021 12:47:53 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-6d76-be96-2893-c13e.res6.spectrum.com. [2603:8081:140c:1a00:6d76:be96:2893:c13e])
        by smtp.gmail.com with ESMTPSA id s76sm650226oie.50.2021.05.27.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:47:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/3] Fix memory ordering errors in queues
Date:   Thu, 27 May 2021 14:47:45 -0500
Message-Id: <20210527194748.662636-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches optimize the memory ordering in rxe_queue.h so
that user space and not kernel space indices are protected for loads
with smp_load_acquire() and stores with smp_store_release(). The
original implementation of this did not apply to all index references
which has recently caused test case errors traced to stale memory loads.
These patches fix those errors and also protect kernel indices from
malicious modification by user space.

Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3:
  Protected kernel index in shared queues from modification by user space.
  Pass queue type to allow compiler to optimize queue methods.
v2:
  Add a way to distinguish between user and kernel indices.
v1:
  Add missing smp_load_acquire() calls.
---
Bob Pearson (3):
  RDMA/rxe: Add a type flag to rxe_queue structs
  RDMA/rxe: Protect user space index loads/stores
  RDMA/rxe: Protext kernel index from user space

 drivers/infiniband/sw/rxe/rxe_comp.c  |  31 ++-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  32 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  22 ++-
 drivers/infiniband/sw/rxe/rxe_queue.c |  21 +-
 drivers/infiniband/sw/rxe/rxe_queue.h | 272 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_req.c   |  46 +++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  44 ++++-
 drivers/infiniband/sw/rxe/rxe_srq.c   |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  80 ++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   5 +-
 10 files changed, 423 insertions(+), 135 deletions(-)

-- 
2.30.2

