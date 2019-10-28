Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF601E75B1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfJ1QAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:00:06 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46038 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJ1QAG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:00:06 -0400
Received: by mail-wr1-f42.google.com with SMTP id q13so10439117wrs.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXV7X6fMokZT0pDVcFDMQH9M9pgB+ph8TvWGz5FJSlE=;
        b=gBqj5gAoKyKoLrwSvl6Tfq8KeXJDIz8E1tWDxZscmgJRIys6xfb3+ND9LRooLGfELF
         buD42u7h/RmZMRLmidtP5YAaaZaiOHUh6Ae0h27wtlFL8KD17Vh7my7mjJ6HcSUNZR2o
         QeOqxeJ2XPA1GXNgc0Sh9IZZgXEJ10t/ajS+RVySqX2BrkCcli3ZcTD9DO4qkKdY6wOa
         v3tBre05LLNBIy/WpuJOuzJsBM0jU0jAjB74Itm2dOW4pezCRwmiztYOEB4uDQ8/ajkG
         R1ddZni8DvNzJrxd3YMjWeb/f2j8R3dBH7GakCm0Xma9DhFTe9R44UMp6woO8ugPOILi
         R8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXV7X6fMokZT0pDVcFDMQH9M9pgB+ph8TvWGz5FJSlE=;
        b=T3J6MDq/5/a61INaUQNXAZWPMXITAB1rbA+IvHWU3Cnr/ksrhzTGgnTp2ZurZ+MhNw
         7FTPqsNk8s1WPBznVSsiUJqwbYFraTswvDJE+7scEg56ueAFCT9RaOlD8Sc+2PVgRCmf
         H6BF0+DVBx0w7UM0jSddyU1h+Flekwhf5ZfqmbwURqAMYBPKFaVhDWeCmFpkvzyvA1cE
         pzN3YDCnJKa7ptMWIfuxb6jHPIRI3A6FMEQujKXOtMGujgi+4NGzOVl811Yviy9GzRnu
         tm/RQIaX8pL4t0aq00r8UAvjtPYMIUaIIKbz9U5R84PujwIlfuj7DJVS/b488VMRMpl9
         w3qw==
X-Gm-Message-State: APjAAAWUTl8+aiocBu+FrEBN0WGsfbstywRz5VcSc5lj8O7L0vkNp9Ia
        /bs/e3W19vNyrMsEeG6xWghaOKiBuuk=
X-Google-Smtp-Source: APXvYqxcUngCNNOysvsYZRjqIPiH329rMjnGmmTsXguHWlR4+/NIACaENhXF0vhe3OP6cac26aNtVg==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr16241546wru.25.1572278402321;
        Mon, 28 Oct 2019 09:00:02 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id a2sm11871600wrv.39.2019.10.28.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:00:01 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [for-next v4 0/4] RDMA: modify_port improvements
Date:   Mon, 28 Oct 2019 17:59:27 +0200
Message-Id: <20191028155931.1114-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changelog:
v4: Allow only IB_PORT_CM_SUP fake manipulation for RoCE providers.
v3: Improve [patch 1/4].
v2: Include fixes lines.

This series includes three patches which fix the return values from
modify_port() callbacks when they aren't supported.

Kamal Heib (4):
  RDMA/core: Fix return code when modify_port isn't supported
  RDMA/hns: Remove unsupported modify_port callback
  RDMA/ocrdma: Remove unsupported modify_port callback
  RDMA/qedr: Remove unsupported modify_port callback

 drivers/infiniband/core/device.c            | 6 +++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 7 -------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 drivers/infiniband/hw/qedr/main.c           | 1 -
 drivers/infiniband/hw/qedr/verbs.c          | 6 ------
 drivers/infiniband/hw/qedr/verbs.h          | 2 --
 8 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.20.1

