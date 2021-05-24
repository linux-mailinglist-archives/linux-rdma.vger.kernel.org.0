Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564AB38E00E
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 06:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhEXENs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 00:13:48 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:44922 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEXENs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 00:13:48 -0400
Received: by mail-pj1-f42.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso9763615pjq.3
        for <linux-rdma@vger.kernel.org>; Sun, 23 May 2021 21:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stvT+gMKDC+K5sqDtXmcJoHHbh700ztn3oGcfv259FQ=;
        b=WLOHHRZVG6auf/3onRkxOMJdf7UoTB4ZQv9XIo6epCxXox/xgYZg2stA8NMqlnftY8
         iFwRYMz7ROwAgtTr5UzxyeXYGFjUdazfOK0SxF6pCewqP2X484PfBH2y68ZjefhWZNMQ
         8t54F8qG1IGriLbUMgDPfgQsdeYN1E9omV3wNE5MwNoES3yH2+MMWeCTfQLyQpnCUGWF
         0sY61nxMq3Y/YY0GG91um8x3p5DvKbY6WXYZxw3GfYvUm0I2n4PQF3yb+kn1eCWRJztK
         hBJo4NinIUvn8x1OX5rLke5muYIscdnzIsSN8CMX/cAO9WSCdH7C/BwXDXoR6HyZPysf
         EBwA==
X-Gm-Message-State: AOAM531rb5vXwZ1sWEXb4J62XAL2Pcv3aTcKj9k024Q9L+KIJM06PYBZ
        ZrA8Akw/rPHpP6zELDfEU54=
X-Google-Smtp-Source: ABdhPJy85DpSgg2bqUGemFUnDsQpNQe/H3BEaBKmM2SjD9+zZ+70LrZlj9bo7rwGrDqieyd/Xe+NvQ==
X-Received: by 2002:a17:903:52:b029:f0:c3b2:15ac with SMTP id l18-20020a1709030052b02900f0c3b215acmr23817647pla.82.1621829537706;
        Sun, 23 May 2021 21:12:17 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q9sm13141979pjm.23.2021.05.23.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:12:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/5] RDMA kernel patches for kernel v5.14
Date:   Sun, 23 May 2021 21:12:06 -0700
Message-Id: <20210524041211.9480-1-bvanassche@acm.org>
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

Changes compared to v1:
- Reworked patch 1/5 based on Leon's feedback.
- Changed __packed into __packed __aligned(4) in patch 3/5.
- Removed the mr_list variable in patch 4/5.
- Removed one if-test from patch 5/5.

Bart Van Assche (5):
  IB/hfi1: Move a function from a header file into a .c file
  RDMA/srp: Add more structure size checks
  RDMA/srp: Apply the __packed attribute to members instead of
    structures
  RDMA/srp: Fix a recently introduced memory leak
  RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent

 drivers/infiniband/hw/hfi1/trace.c  |   5 +
 drivers/infiniband/ulp/srp/ib_srp.c | 157 ++++++++++++----------------
 drivers/infiniband/ulp/srp/ib_srp.h |   2 -
 include/rdma/ib_hdrs.h              |   5 -
 include/scsi/srp.h                  |  26 ++---
 5 files changed, 80 insertions(+), 115 deletions(-)

