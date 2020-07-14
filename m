Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885EA21EB09
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgGNIKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIKv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134EC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so20215475wru.6
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvLV11o002k6lwnLUwZHmglOAmUCRXCOV1xsKs+vcjk=;
        b=k+TyF8tS3Gi3IYxRBY1qwBdmMHBtRS1T/MPgGXBchBEhhEHgp+L/rN1gzhvk9PYJH3
         dQpsHlEIObQtyY4rl0Fv4MNna0Tji9PrprJbyOwMR1xMTnIFBI87PXTqwffolAgMma0J
         RSgn9JzzddIuUutQeo2UkJcWNd4B4OuAfzhDg4K314I9QXcTOMCjn7420az0+LrR/Hfr
         nqk8o2gsSoemTN9GNJ4+0sgDgxlK5B9EbnRBf0o7fenGhBt4xqiMZGdpNhUGmzs5y+Ge
         JLGotVcWJEu4t4OtM+azdHXMXT3d8qy26aoNIiDSFo2zOkIZsayVF0dmB6Pd0grryh2t
         K2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvLV11o002k6lwnLUwZHmglOAmUCRXCOV1xsKs+vcjk=;
        b=FQhjPqZzQDr7G/JVYwe3mVL5lncJ4URc+0mH/T19pNm+mGIoeyRmHBKGE2v+0JSmo3
         AdLvMuuI5LtBIcmjXnqTOIbrfGDtuPzqAmc5QnxZrO1u3TB1QUcCOssZ1SUkh8Dp7dCL
         ieB90mlN5PV7vmklAVl+Jx2C991tHZeOFtW0kxH2g/HNO/3tO6rfS8R2kavE3BcF70yn
         FtQEEBQl2dtwmGkoQbmEWJPtalF4f6SMbm7HusAAiwXb/xhtoTCvI6ZODpbRQ6YDNnbz
         Un5hFpZsKrz8VZAKksMMdljxlJ+NwqdcK1Qq/4NAugzsx6H3WNAhUA8eMP+MQMhrIUel
         FNyw==
X-Gm-Message-State: AOAM532nKUkczMGX5s2shEmUvKxQDRyRfmSkZ2+zTAHpGmbuq3QaNOBB
        PxMQaD2TdGWB1sW8cEmPL80MG1xZLIY=
X-Google-Smtp-Source: ABdhPJyYx33nRoNXk0Dc+zUEF2pEObINlI5FxUH1aBJrXIWgxcxQgumcd/Fse66N6z1J5AYU4gONMw==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr3700790wrp.268.1594714249140;
        Tue, 14 Jul 2020 01:10:49 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:48 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/7] RDMA: Remove query_pkey from iwarp providers
Date:   Tue, 14 Jul 2020 11:10:31 +0300
Message-Id: <20200714081038.13131-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set does the following:
1- Avoid exposing the pkeys sysfs entries for iwarp providers.
2- Avoid allocating the pkey cache for iwarp providers.
3- Remove the requirement by RDMA core to implement query_pkey
   by all providers.
4- Remove the implementation of query_pkey callback from iwarp providers.

Kamal Heib (7):
  RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
  RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
  RDMA/core: Remove query_pkey from the mandatory ops
  RDMA/siw: Remove the query_pkey callback
  RDMA/cxgb4: Remove the query_pkey callback
  RDMA/i40iw: Remove the query_pkey callback
  RDMA/qedr: Remove the query_pkey callback

 drivers/infiniband/core/cache.c           | 45 ++++++++++------
 drivers/infiniband/core/device.c          |  4 +-
 drivers/infiniband/core/sysfs.c           | 64 ++++++++++++++++-------
 drivers/infiniband/hw/cxgb4/provider.c    | 11 ----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 -------
 drivers/infiniband/hw/qedr/main.c         |  3 +-
 drivers/infiniband/hw/qedr/verbs.c        |  1 -
 drivers/infiniband/sw/siw/siw_main.c      |  1 -
 drivers/infiniband/sw/siw/siw_verbs.c     |  9 ----
 drivers/infiniband/sw/siw/siw_verbs.h     |  1 -
 10 files changed, 77 insertions(+), 81 deletions(-)

-- 
2.25.4

