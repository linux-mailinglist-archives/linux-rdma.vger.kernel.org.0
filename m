Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6BD8952
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfJPHW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 03:22:57 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38659 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfJPHW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Oct 2019 03:22:56 -0400
Received: by mail-wm1-f44.google.com with SMTP id 3so1518253wmi.3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2019 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3unKm9Z0CPcFFg+ecbBetblVIGjkbtozQ3fW2ZFw4LU=;
        b=eMK8uRWvpQTVW6sP4eR1IMSmCqVjzB3zSvzH1TtqgN4SHkQJZP6p3HnsYPz5A3leuO
         I/n6GYu2DEPXZ72Wq+nF6N/yyN4Qhhg+PA2SNcwY7GSLfkdxV3UNlh2oRdMvXudqt5OA
         gloJbosDQImdmC+3KaYlFbPSnyyKi0if3Bx/8Q+X2aAMAomr6wTFyU+lIdt7RbkBWF/t
         /qi5JVSkuvVDnyZezDFWB+4kkxDhI0lIRKy519BrfUTu9frFYLRvufAJITl8ZSn92rdk
         LYyyTLUImBOhlkjbUHoO+31DbamBkI83wLBdn8FYrfCMGNgFqGeaL6deARvbsgdGOAXi
         DyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3unKm9Z0CPcFFg+ecbBetblVIGjkbtozQ3fW2ZFw4LU=;
        b=IFPRputZfET+wqjrgTmc2Wjlt60mXZHm2ur4MoHgH6dwwKeBCOMiXTnf7DiE5qDgXh
         ERzYQTA2ACUEPNSySswUv5C44PzRroKgpkX06tQ2xI13MWYfDfOi+teEX9eCsuR5kZ19
         dKdFMW7Xbho8f7KTaSygWC50n5tctPeeoRiifeyHGCrXx25dYkKvGRvez4PDyQYbZit0
         oDGYFbjLpf6e76qmMBfjwYKDT8fW1RazxCiaO1mqfjwN1QQJCtGWXzUIIYnNC/KixVux
         AImV5nFDxe8B1IbVMgeCd2T/LdZ925SZ3koPFf/rVLmaWyumGIbouxIdjqu4Tb1ozvDE
         zjoQ==
X-Gm-Message-State: APjAAAWrUaAmSl4GkQU7970b873+PK1pGlrRyWRLuHuewJjL62iOWbYT
        JdYXt9+YifWP2QDi/yIXzMfkCaG5
X-Google-Smtp-Source: APXvYqyG6HY3xa1aWwkCjGrqrxz0WJE/5wAs2S2xuq+aM9G9ENMuQNUMuYwAstx+LRn2J8A4NK6v3A==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr1838678wmj.123.1571210574562;
        Wed, 16 Oct 2019 00:22:54 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id r140sm1687046wme.47.2019.10.16.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:22:53 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2 0/4] RDMA: modify_port improvements
Date:   Wed, 16 Oct 2019 10:22:30 +0300
Message-Id: <20191016072234.28442-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changelog:
v2: Include fixes lines.

This series includes three patches which fix the return values from
modify_port() callbacks when they aren't supported.

Kamal Heib (4):
  RDMA/core: Fix return code when modify_port isn't supported
  RDMA/hns: Remove unsupported modify_port callback
  RDMA/ocrdma: Remove unsupported modify_port callback
  RDMA/qedr: Remove unsupported modify_port callback

 drivers/infiniband/core/device.c            | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 7 -------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 drivers/infiniband/hw/qedr/main.c           | 1 -
 drivers/infiniband/hw/qedr/verbs.c          | 6 ------
 drivers/infiniband/hw/qedr/verbs.h          | 2 --
 8 files changed, 1 insertion(+), 26 deletions(-)

-- 
2.20.1

