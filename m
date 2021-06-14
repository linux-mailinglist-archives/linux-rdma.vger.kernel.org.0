Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74273A5ECA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFNJGm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 05:06:42 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:45990 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJGm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 05:06:42 -0400
Received: by mail-ej1-f48.google.com with SMTP id k7so15390572ejv.12
        for <linux-rdma@vger.kernel.org>; Mon, 14 Jun 2021 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8skk959+yJZ6i3vudYxWQePThQjvG9B3KzS7DG1fG8=;
        b=MgYULn2nhpUAjsCI2eBhF7ssm03PpZ2rVBmx5TN53KJEzPbyDqoVNJlMajHvVKUb8J
         /D26okvFmfwI633Y3I5UKMzSPOZ8/bWKmRes+qPj/ZNEkuAR98mTrQxMc7PAM9vqVSNN
         Zmu7ebKCHJgIhIcyHw45jBN5bXb606PeM9Gqr5HTA8TTzihwnd2QRt+bq7VKKOATD0Pg
         IB+8d+ZnR/Js0R/jheR2uS+K9uhWKSBJEauDcqJlz5x3Mwh9vNgKi7Jdhdnv5ZWNfFBE
         rmmB481jz6I6orkfHQjse33EsuB9t2dQ8+wPFhZPdwAkZ5jVes/ZXBLKIGsn1kYPQ/5U
         /LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8skk959+yJZ6i3vudYxWQePThQjvG9B3KzS7DG1fG8=;
        b=n5zg5krLHXJowGtLaOq1yZQuDfEorr4kQVYfeglOfMuInegilRFblmmVLW93Ng4FXt
         XmROu9DH0vrDT6sPAtPFIQIzziD4tHf76kh3eV5LWrjiS+gyGyMEWs85TaNcTyL3Ph5v
         3qRDLufh+hF6btLsW9NzXGQCV3Bb9g2RzanEBdbaPQA3lt/IqetOSjaT+wioMUZhLt6e
         CZwBqtEu5ZHcq6q4sh7o8ccl2qMAyXMgswoayNIXqkNpAOmW25dL/L5D+3+cfcRrAlP6
         broESPz1FrLCDt8eSGxrS1BROyiuRrm/bY7ROxRwRKOMd8pJ6pQgRx84Iqo8n1lbzbVT
         hIUw==
X-Gm-Message-State: AOAM531BFyeqZ8FWG8UAecOpWnBoms5lJD/mSP8lIwuNuKaIm7c+BCOv
        zjzS5HMRP+j04xIwdDUBYPq1ZzI9dm/GnA==
X-Google-Smtp-Source: ABdhPJzugzjgTBjnwfw4IBM3P5g2eRnUVMzjR3VWlTz/wfjLIFNT2FY82Gbiuagqidk/qsSw0/zLwQ==
X-Received: by 2002:a17:906:264c:: with SMTP id i12mr14277968ejc.101.1623661418686;
        Mon, 14 Jun 2021 02:03:38 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4960:8600:dc5e:964f:b034:cb7d])
        by smtp.gmail.com with ESMTPSA id qq26sm6764355ejb.6.2021.06.14.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:03:38 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 0/5] Misc update for RTRS
Date:   Mon, 14 Jun 2021 11:03:32 +0200
Message-Id: <20210614090337.29557-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- first 2 patches are for reducing the memory usage when create QP.
- the third one are to make testing on RXE working.
- the fourth one is just cleanup for variables.
- the last one is new to check max_qp_wr as suggested by Leon

v3->v2:
- added R-b from Leon for all 5 patches.
- s/NOMEM/ENOMEM in patch3 commit message as suggested by Leon.
- Rephrase the commit message for the renaming (patch4) as suggested by Leon
v2->v1:
- A new patch to check device map_qp_wr when create QP.

v2: https://lore.kernel.org/linux-rdma/20210611121034.48837-1-jinpu.wang@ionos.com/T/#t
v1: https://lore.kernel.org/linux-rdma/20210608103039.39080-1-jinpu.wang@ionos.com/T/#t

This patchset is based on rdma/for-next branch.

Note: I tried the patchset for fast memory registration on write path can still apply.
https://lore.kernel.org/linux-rdma/20210608113536.42965-1-jinpu.wang@ionos.com/T/#t

Thanks!

Guoqing Jiang (1):
  RDMA/rtrs: Rename cq_size/queue_size to cq_num/queue_num

Jack Wang (3):
  RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
  RDMA/rtrs-clt: Use minimal max_send_sge when create qp
  RDMA/rtrs: Check device max_qp_wr limit when create QP

Md Haris Iqbal (1):
  RDMA/rtrs: RDMA_RXE requires more number of WR

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 50 ++++++++++++++------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 10 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 34 ++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs.c     | 24 ++++++-------
 5 files changed, 65 insertions(+), 56 deletions(-)

-- 
2.25.1

