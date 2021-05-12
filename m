Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4525837B480
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 05:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhELD3I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 23:29:08 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46605 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELD3H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 23:29:07 -0400
Received: by mail-pf1-f180.google.com with SMTP id q2so17490547pfh.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 20:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NIkwCVnHdsIh7if1p+8mswBSPL3Giet5HV93R6+NOQ=;
        b=bmtl2Utr0NcMxSDvTOAoP6Xvy2ZMhZeEV3LnfegdM9VUtBSqApX4XzSvymZ8VSQ9Mw
         +1YraFTQGW9aUsHuPTXGm6Na6JYF4sGUrB+/b3XuUnrlzD0A4rXZ1DVoBF2fmPQtwyVF
         ZxsHbIxBN4wtdS75C5bjVTwQ7facworjwDmXtYEcltwGMDBP9lhMtpxKz7Jnqsh8PCT/
         nzbJUYMHKqLq/q9wAwtAIqWF5N5WW6WMSG9n/n/8y79WZJdE4Wk6iVXBVR8LCr7tRpZQ
         id4ljLr+uOcbRZheYGvjc5D0XvwOetLtzFC3d9Vcmoyk+6A6ZIiZNlmZbftcUpBLHKVr
         PfHA==
X-Gm-Message-State: AOAM530DbYt8reyueTX17cPVR2SsNfrgNiasFq/M2hTZrxkhtpHdWJsY
        KPZmAG+J7bHoW0aNyGaUHe4=
X-Google-Smtp-Source: ABdhPJxs3l35e50CTFBxPFRr1kdBP8kDuPAPgpsmPCa/1KdlV01WK8ATW7Ze/PBaTJ4AZFqQQ9Lp4g==
X-Received: by 2002:a63:4f50:: with SMTP id p16mr33573127pgl.245.1620790079183;
        Tue, 11 May 2021 20:27:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:76b9:3c77:17e3:3073])
        by smtp.gmail.com with ESMTPSA id q194sm15008703pfc.62.2021.05.11.20.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:27:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] SRP kernel patches for kernel v5.14
Date:   Tue, 11 May 2021 20:27:47 -0700
Message-Id: <20210512032752.16611-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Please consider the five patches in this series for kernel v5.14.

Thanks,

Bart.

Bart Van Assche (5):
  RDMA/ib_hdrs.h: Remove a superfluous cast
  RDMA/srp: Add more structure size checks
  RDMA/srp: Apply the __packed attribute to members instead of
    structures
  RDMA/srp: Fix a recently introduced memory leak
  RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent

 drivers/infiniband/ulp/srp/ib_srp.c | 154 ++++++++++++----------------
 drivers/infiniband/ulp/srp/ib_srp.h |   2 -
 include/rdma/ib_hdrs.h              |   2 +-
 include/scsi/srp.h                  |  26 ++---
 4 files changed, 76 insertions(+), 108 deletions(-)

