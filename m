Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2F362D9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFERja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:39:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41067 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFERja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:39:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id s57so11834290qte.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybj1p+3wcYlhfA2C5XOSkI05LBbFJvNFfBuYFch0szI=;
        b=lySfKiTSy3qIXNUvifPFoi9KWOo/3bZXpK6xqtrpITwWUXUsPv/xQQKnO04U8sbWrG
         kKoGT49WQ5NbpqEJ+dF5C+aIPjwRTDFV9eGcyqidi/fRl7W9ivwp2sx7toQbeipsG6TS
         Rox7hH0CATm/S40C9qD0T3U/ureGzaAQlqDV6qBZTBDFGen5bgvX/QhAqeqaq10Fjabd
         XRnhCOCjMY/3qUnmB3EpM8d/J2/yYmbbsy7DSK6lGrqmFvrwo0XpCb43TvqU+K1+YzWL
         IHB62XHaflF8slmNXZA0HDeL4JEdcn1H1x2fJ/HmsqFZZPtH2lJmZlTnEO/wL0k0g+0L
         MHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ybj1p+3wcYlhfA2C5XOSkI05LBbFJvNFfBuYFch0szI=;
        b=go1/uNxERmBijVQ9Rsouir/c5iV5mWnB88pTVf4jc2Ir63kpmfy4tOYdTo15tj1/0z
         aYRGCPhQmCKi9LIcNqccnwiOoFY/pNCw+cpiEMlZ5gC/Tbr0ixq6P3h3EcICyykoz+U7
         IFDpMXEwDiyi17G31v+jOiP+WQ/6PGFb4rnAM6j3SBfYlq31xxx57OmFj2mhrxiy9oP2
         14DHKk6BRtNT2ygnIIt7GqRHyMFujwJu+8sAm8RXnfMwB3S/newBUdMZo4tyNy53IjAc
         1Fr4dFhdycf+78WL2rC4aIrJ80J/hRNe0sG8lpYI5fZ/FFoEMbRgRaAhMG2KToRQFp6M
         DI/A==
X-Gm-Message-State: APjAAAVV0MlZFMTh4P/r0veOMLI9j2tMgjcX2XpiQUXkK+EjP9DxDjn7
        9W2khAzhS2JyHNTHXdp8ZTH5tPXH/7OKsg==
X-Google-Smtp-Source: APXvYqz6garZoydsgtalcMFJA34iQEt8J8NMRZKkaBlFpxKfNoS2bJ67CG9AkehZPiSeCcLFMJDoYg==
X-Received: by 2002:ac8:303a:: with SMTP id f55mr36409458qte.101.1559756368825;
        Wed, 05 Jun 2019 10:39:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c184sm2560479qkf.82.2019.06.05.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:39:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYZsl-0004gG-JA; Wed, 05 Jun 2019 14:39:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 0/3] Move more constant stuff into struct ib_device_ops
Date:   Wed,  5 Jun 2019 14:39:23 -0300
Message-Id: <20190605173926.16995-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Each driver has a single constant value for
 - driver_id
 - uverbs_abi_ver
 - module owner

So set them in the ib_device_ops along with the other constant stuff.

Jason Gunthorpe (3):
  RDMA: Move driver_id into struct ib_device_ops
  RDMA: Move uverbs_abi_ver into struct ib_device_ops
  RDMA: Move owner into struct ib_device_ops

 drivers/infiniband/core/device.c              | 18 ++++++++++++++---
 drivers/infiniband/core/uverbs_main.c         |  8 ++++----
 drivers/infiniband/core/uverbs_uapi.c         |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  6 +++---
 drivers/infiniband/hw/bnxt_re/main.c          |  7 ++++---
 drivers/infiniband/hw/cxgb3/iwch_provider.c   |  7 ++++---
 drivers/infiniband/hw/cxgb4/provider.c        |  7 ++++---
 drivers/infiniband/hw/efa/efa_main.c          |  7 ++++---
 drivers/infiniband/hw/hfi1/verbs.c            |  6 ++++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |  7 ++++---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  7 +++++--
 drivers/infiniband/hw/mlx4/main.c             | 20 ++++++++++---------
 drivers/infiniband/hw/mlx5/main.c             |  7 ++++---
 drivers/infiniband/hw/mthca/mthca_provider.c  |  8 ++++----
 drivers/infiniband/hw/nes/nes_verbs.c         |  7 +++++--
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  7 ++++---
 drivers/infiniband/hw/qedr/main.c             |  7 ++++---
 drivers/infiniband/hw/qib/qib_verbs.c         |  6 ++++--
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  7 ++++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  7 ++++---
 drivers/infiniband/sw/rdmavt/vt.c             |  6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  7 ++++---
 include/rdma/ib_verbs.h                       |  7 ++++---
 include/rdma/rdma_vt.h                        |  2 +-
 24 files changed, 108 insertions(+), 72 deletions(-)

-- 
2.21.0

