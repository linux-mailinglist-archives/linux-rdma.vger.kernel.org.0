Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7916184C92
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 17:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCMQdl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 12:33:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37211 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQdl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 12:33:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id f16so4510555plj.4
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nppOv9lcgiGAGp/Bbugg8uQVl02SwGon4PiLC8BlqbU=;
        b=XiWMKiWhCr5gj5iWGLjZPHKKux5IC2hm77mmXzhUYJuP9apS9R3Mj5a8XxQ0wFsT2Y
         C0mQ+NU2R/ETJ9TtMRDLHR2oD47htuRRbdPGSAMKLE1RrvhF86R4NftlgF4rssoqh7tp
         ULHjjVJzyKSO+mDop4yL4Cxo0f5sXM4t7Yq+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nppOv9lcgiGAGp/Bbugg8uQVl02SwGon4PiLC8BlqbU=;
        b=ARpVxrl7vZhfoKSxHvAs/QOlQS4AfI3Dj/vaFd22iIeyfoqrgeQtUhCG6eV/+Z2e2B
         YWGbMNC00kX7jfloja7Xf4omN3lfmafufBQn8twjGZlYu7LphveEbvpPIuU26/K5obO8
         Khzjzo9jn/A5prJS9cwnB50Q9RZO7FuqWmTP56u8ltjw4aaV7P6n1H6GzF29kqDFVV1u
         7y6n39QuazHDm2HP79rm1MfONgex+F1B4/dpJfx2SO4xNo3tAMoS3nLG9YdmMwJAglqL
         4+BDH1s6TECfI2aPIpk5DGYJrDMFgvkRlNKhmyQTDPn000DmPfv1r+NpRdnkQ7Td3UVb
         d3pg==
X-Gm-Message-State: ANhLgQ1p1XyqC7q5we7955Pndf3P9/z2P+qlnkaIMBVBRWTDtHegxW2i
        8l2L00/XLfb5P4lq/iksGqIQEw==
X-Google-Smtp-Source: ADFU+vtMzavlCs4tNXEDIc5w3tdcPEr7TXyCTIWvwmY8B9fkrRz8iQ2YCYznAorSDEsBgpSrrw8HZg==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr10966011pjk.195.1584117219922;
        Fri, 13 Mar 2020 09:33:39 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v5sm2338344pjn.2.2020.03.13.09.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:33:39 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 0/3] RDMA/bnxt_re: Fixes for handling device references
Date:   Fri, 13 Mar 2020 09:33:24 -0700
Message-Id: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid the driver's internal mechanisms to check
for device registered state and counting the work queue
scheduling.

v1-> v2:
  - Removed all reference of BNXT_RE_FLAG_IBDEV_REGISTERED
    from patch 1
  - Removed smp_mb__before_atomic call from patch 3

Jason Gunthorpe (2):
  RDMA/bnxt_re: Use ib_device_try_get()
  RDMA/bnxt_re: Fix lifetimes in bnxt_re_task

Selvin Xavier (1):
  RDMA/bnxt_re: Remove unnecessary sched count

 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  2 --
 drivers/infiniband/hw/bnxt_re/main.c    | 37 ++++++++++++++-------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

-- 
2.5.5

