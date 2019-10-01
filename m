Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5099C393A
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfJAPig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38590 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfJAPig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so11656600qkc.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p462bBu3FLp7h99bhn7hlf1550lKI8QVbiyabIvmL8s=;
        b=GC+jISPJiApirnCQHb4hocNDB50/YNDD/bhsMoT0KdJ1CkJyMYoStp3RXqJQZtiNp1
         rXv7rYq7R5k0dnOgW89FMa5+SBCMpMkBWorJ4xabpvUlTlBH7vqVPjGPDuv4kQfqzOg0
         df0GoYafMJAgeRQHH/uw+ckAw1ugVOfc0qeEEUdkzxg+kNXo9/DkBtzKKhhbPnm7tcfg
         8Ac8B46wjKUvIeyx000OF+bSs3EPKUWXm3pqL4jM2a3e1iIUj4RUYJ0+iaz3xM+zhR5a
         nxbjXryMNc+gnujnAb3FrdD4VNT5Ru7hBX0NdmYkB3U4s3MizUgzX+lva3zQN1B44KYv
         LD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p462bBu3FLp7h99bhn7hlf1550lKI8QVbiyabIvmL8s=;
        b=kv62bMWiBc8YgBRVrMGaJiNneFWAWePvASsLC8LGWL0oERX1AXrbT3o8TTx96PAZIh
         9xxtlEIQhjVW52EyNFN8c3ERCpMo/tMDuyAADqid9mWR8U4qdAG+8toWDpHsoW9wyekk
         YAyZapo0hqRAKOGGzDO4KR530y++cXf61lhOUA2vHvqvH4yKTBcG5xJjkbAQF2IyvLdW
         IWVpQI9OlzRZR0ibFNvEy6dnH3oRpfe+P8T3MaK5N8JWXklJqbuV9xJ/EQEqrtEeLRPk
         JplnBxVEeuViI2p6Hs3hNW6rA4iOkFdSYVNXkRviIJN2DHRfP/J36R8DhiVf0L7hgQ1Q
         WEcQ==
X-Gm-Message-State: APjAAAU84w1Ycpxv78Nj5dmNDxBqE6bzN/7kv6g0jjj7Y25Dii6FIMOB
        x7i0w1OXLfNhhchIzVU0wXhMHhjSpXI=
X-Google-Smtp-Source: APXvYqxadej/LIVqPeuu3ZKcEpo03tAQSKJPLkcHSQXEmHlrvHa5n6MBSJcyMoNAAfGYm0Z2fqqbkw==
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr6667129qki.125.1569944315253;
        Tue, 01 Oct 2019 08:38:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q5sm11566507qte.38.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKET-0006ER-VX; Tue, 01 Oct 2019 12:38:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH -rc 0/6] Bug fixes for odp
Date:   Tue,  1 Oct 2019 12:38:15 -0300
Message-Id: <20191001153821.23621-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Various assorted bug fixes for the ODP feature closing races and other bad
locking things we be seeing in the field.

Jason Gunthorpe (6):
  RDMA/mlx5: Do not allow rereg of a ODP MR
  RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an implicit MR
  RDMA/odp: Lift umem_mutex out of ib_umem_odp_unmap_dma_pages()
  RDMA/mlx5: Order num_pending_prefetch properly with synchronize_srcu
  RDMA/mlx5: Put live in the correct place for ODP MRs
  RDMA/mlx5: Add missing synchronize_srcu() for MW cases

 drivers/infiniband/core/umem_odp.c           |  6 +-
 drivers/infiniband/hw/mlx5/devx.c            | 58 +++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  3 +-
 drivers/infiniband/hw/mlx5/mr.c              | 68 ++++++++------------
 drivers/infiniband/hw/mlx5/odp.c             | 58 +++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/mr.c |  8 +--
 6 files changed, 96 insertions(+), 105 deletions(-)

-- 
2.23.0

