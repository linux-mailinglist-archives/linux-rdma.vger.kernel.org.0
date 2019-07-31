Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF417BF06
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfGaLP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:15:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfGaLP2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 07:15:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so44154337wrr.4
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crtL51XQqSRRlxWMIfz7T4S/5O93x6zgYjSUF7m9UVk=;
        b=jegIlqYynwc07GcqCHOY0cV3PO4pKWXxgl0P/sVig741TGk8zfWTHMwzAVTrkzTFVE
         hnpOS4a0063ArcDhSiAoyYZvxi4zi3612wxCsy4gcZlzwpiKYTRV3RauIw9bCCbDbAlU
         6WZl8d1BL0n0I9zsCulrnwsLaNeruogIhBkkJjD42iYczE4Fek8DTKO4dqMqFo3Sr7bd
         eeEL7sFfMxEUNbBvWIbzjVW5kjW+O72ST9lv4F6laAUl7aHSxMj1ksmaubL9hxxBNxQR
         jAJ3N+qCTnru3ihpueKBj5XjuKRQ1z7EYV7WCmSsJv5UF5gs9zR6ky6yGd4mIZ5Wcda8
         61Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crtL51XQqSRRlxWMIfz7T4S/5O93x6zgYjSUF7m9UVk=;
        b=F656Im6LABWYW10oYpdTrqMZiLWFVcVYL3wMWcywn8mnROIknv+ztQPvQu/BScPLT1
         yYF2HRmY3bxGfdmzWjlwxP7rDob1RvohHInFRwD+Ptr0dEOaW1/FWtYJx1CHM4Ynjiku
         5U3rkhHPLbTxTId2kBvnFUdnC44fQYhYPR0gpT/kUEvLR/xss5qPw4wCN1d1O/qJPXTw
         q51dS07kAMRaqixVNEFS+HaGZcA8gFjaIIBQU+3oKIq/9DjT/0Ou7I2GZm5gmX/uaEJG
         UDcsEg97rJ6o2yfP4QoO0WYeGsVwA7wiCO9RnNblAi2biOmYnzc5CYEjjMl0njimBjYF
         yRyA==
X-Gm-Message-State: APjAAAVnAlllpLcSJRwTM4M+fTjgjQkuCwf9/YPsd6fw3811lXac01Xx
        H4sTkiJtB5T23czyx3G43IRBI6Gi
X-Google-Smtp-Source: APXvYqw5CbPqb2JMC1ihIn2NLADiXwqirIC51AW5eJb7kYwcENgVim7COWOflLiKdi2lhJc6Ip69dA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr49561856wrm.161.1564571725901;
        Wed, 31 Jul 2019 04:15:25 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id h133sm73133732wme.28.2019.07.31.04.15.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 04:15:25 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/4] RDMA: Cleanups and improvements 
Date:   Wed, 31 Jul 2019 14:14:59 +0300
Message-Id: <20190731111503.8872-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes few cleanups and improvements, the first patch
introduce a new enum for describing the physical state values and use it
instead of using the magic numbers, patch 2-4 add support for a common
query port for iWARP drivers and remove the common code from the iWARP
drivers.

Kamal Heib (4):
  RDMA: Introduce ib_port_phys_state enum
  RDMA/cxgb3: Use ib_device_set_netdev()
  RDMA/core: Add common iWARP query port
  RDMA/{cxgb3, cxgb4, i40iw}: Remove common code

 drivers/infiniband/core/device.c             | 85 ++++++++++++++++----
 drivers/infiniband/core/sysfs.c              | 24 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  | 45 +++++------
 drivers/infiniband/hw/cxgb4/provider.c       | 24 ------
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 11 ---
 drivers/infiniband/hw/mlx5/main.c            |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 +-
 drivers/infiniband/hw/qedr/verbs.c           |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +-
 drivers/infiniband/sw/rxe/rxe.h              |  4 -
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 +-
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +-
 include/rdma/ib_verbs.h                      | 10 +++
 16 files changed, 136 insertions(+), 103 deletions(-)

-- 
2.20.1

