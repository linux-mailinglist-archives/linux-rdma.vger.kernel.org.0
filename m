Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804878498B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfHGKbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:31:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41122 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbfHGKbu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:31:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so87591186wrm.8
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+bDJrDFi3CtuJvT1mMy497fGymepKVwPqfzySMCSxk=;
        b=AGdWGDF9yAlHvB7Vc81n0QU41JkUDdyT+QBx2Dxa9Buqu0i99h8ufFFbfhxuPTYAAo
         yzs0C3oH7vtpLo6wTJq8VM8xSOpFejE4F85J2dTCBg43wLkS5Kt0dDESyMpkwyXYD98o
         PZrOXSDxK53A7ckmecTpJltfZHPT3Hlr/jjAv3Muw46TYtxOSgi423UFjDjCDV57seV6
         W/fSmq/5ddkJrb4mAiDcJ1stqS+BqpC9xqQhC8X95W/tT5XndpDqjW6LHkmHvwRmnEn8
         eMNKdIAPn99BpHTgtn+69uMQSTD29R6u5eFPi/Ln6iAIoDTPkcWU/jK4u6JnwVOMa1Dk
         eIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+bDJrDFi3CtuJvT1mMy497fGymepKVwPqfzySMCSxk=;
        b=nkH0fI5k4Ru/fouF3JI0tMt3djLBl+JtyYswZlpre1aSbUr9s3Cg6dGjstbkXZc0ro
         zb+ngWMwVydRBy5Hjyq09HE8XEyYV1xXmOtjZ0YMbotP7P19xryH8KYrIaQilu9VUTZw
         osr8WYofnCXZCF2RbjfwgEgUNE6W1VVYvM5S7Azny8T01WW1s0LaSViUrYPToYZzwAla
         2JgpJr5aeZE4YU+aKUOpGc38Q/jJN7Oy0xEeOLv0y18CcW2McvkN3mlJJo0/7BYeo0vc
         kt1QTEGONFA5oX+P4o/4hXxVNIIbUlT/OtVRpuFwUueOo3UDOp3T4aIoqzjvER5ElzGh
         ckgQ==
X-Gm-Message-State: APjAAAU9VQyh4dnrddhH1Fxp8325o1/B0IfojpGNLV4v3Fkq0KwWJPnF
        guNsW/+6HdHTBC6sCGEnxcSFwFwDjtc=
X-Google-Smtp-Source: APXvYqzVQveMkn75c6W2ijZmF6n6LprF/I6SHVVJ/86rf+iNIK8w2zsSa6/d6z+onvZaL6RnGJzGaw==
X-Received: by 2002:adf:e552:: with SMTP id z18mr10210528wrm.45.1565173907766;
        Wed, 07 Aug 2019 03:31:47 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id o3sm79713845wrs.59.2019.08.07.03.31.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:31:47 -0700 (PDT)
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
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
Date:   Wed,  7 Aug 2019 13:31:34 +0300
Message-Id: <20190807103138.17219-1-kamalheib1@gmail.com>
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

Changes from v3:
- Patch #1:
-- Introduce phys_state_to_str() and use it. 

Changes from v2:
- Patch #1:
-- Update mlx4 and hns to use the new ib_port_phys_state enum.
- Patch #3:
-- Use rdma_protocol_iwarp() instead of rdma_node_get_transport().

Changes from v1 :
- Patch #3:
-- Delete __ prefix.
-- Add missing dev_put(netdev);
-- Initilize gid to {}.
-- Return error code directly.

Kamal Heib (4):
  RDMA: Introduce ib_port_phys_state enum
  RDMA/cxgb3: Use ib_device_set_netdev()
  RDMA/core: Add common iWARP query port
  RDMA/{cxgb3, cxgb4, i40iw}: Remove common code

 drivers/infiniband/core/device.c             | 87 ++++++++++++++++----
 drivers/infiniband/core/sysfs.c              | 30 ++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c  | 45 +++++-----
 drivers/infiniband/hw/cxgb4/provider.c       | 24 ------
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h  | 10 ---
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 11 ---
 drivers/infiniband/hw/mlx4/main.c            |  3 +-
 drivers/infiniband/hw/mlx5/main.c            |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 +-
 drivers/infiniband/hw/qedr/verbs.c           |  4 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +-
 drivers/infiniband/sw/rxe/rxe.h              |  4 -
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 +-
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +-
 include/rdma/ib_verbs.h                      | 10 +++
 19 files changed, 144 insertions(+), 119 deletions(-)

-- 
2.20.1

