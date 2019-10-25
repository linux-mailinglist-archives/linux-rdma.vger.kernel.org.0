Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E41E56C2
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 00:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfJYW6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 18:58:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43742 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfJYW6i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 18:58:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so2497508pgh.10
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 15:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jXDNPMHHwc83BOJ89YXwYW4Jgyv+JzOIiFw0eYOgnRE=;
        b=NXtWs71t4mTsK2YYr6kTS1nNi5RzhLUPPZ4zREcYN1S6dLShC/Pqf36bFua4EnKDBu
         1d6RlIVChr0EVwlj6KI3p6YNdgKwdAtaDBWDI9IYAlixzo8cmk1V0N6A24nNC7sKPoS0
         UzJEKa8rZIRFrbu8HZZu1F6hPWUYxH3Yo+aHrWyhl3WgJoo+Ffuw9gW0hxHKswguWHiO
         +Iy9a5rYGfwINU810HmD7L5WgvaJZxNeGJVdH7fofKG+9dHQ6X3jV3NfIVr/4y7MM1GP
         DMlxp5TP9FQFoSCbDCVOKF3cTg+pH3qI0N3spuD0hKHxI5pEI6AlzdcG/bGO2mlvfvZ3
         m2Iw==
X-Gm-Message-State: APjAAAV4U8zY109mQcjCR5DmqSV6od7ttRZUnOZaS9wFow55J0Ja28u0
        45VpYr46zACFxXGOg4SkpoM=
X-Google-Smtp-Source: APXvYqy3vYMzOrCF5nMm3G0mVvN6NLBf3ZsEL9bSWWpSBERCPGIs9LA93HWmpXcE2UwHqBx2GeB3yA==
X-Received: by 2002:a63:1b41:: with SMTP id b1mr7344495pgm.335.1572044317266;
        Fri, 25 Oct 2019 15:58:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o123sm3243983pfg.161.2019.10.25.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 15:58:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Fixes related to the DMA max_segment_size parameter
Date:   Fri, 25 Oct 2019 15:58:26 -0700
Message-Id: <20191025225830.257535-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

These four patches are what I came up with while analyzing a kernel warning
triggered by the ib_srp kernel driver. Please consider these patches for
inclusion in the Linux kernel.

Thanks,

Bart.

Changes compared to v1:
- Restored the dma_set_max_seg_size() call in setup_dma_device(). Reordered
  this patch series to keep it bisectable.

Bart Van Assche (4):
  RDMA/core: Fix ib_dma_max_seg_size()
  rdma_rxe: Increase DMA max_segment_size parameter
  siw: Increase DMA max_segment_size parameter
  RDMA/core: Set DMA parameters correctly

 drivers/infiniband/core/device.c      | 16 ++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 +++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  |  3 +++
 include/rdma/ib_verbs.h               |  4 +---
 6 files changed, 23 insertions(+), 5 deletions(-)
