Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006C7DE1E2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 04:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfJUCKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 22:10:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38392 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUCKk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 22:10:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so7387329pfe.5
        for <linux-rdma@vger.kernel.org>; Sun, 20 Oct 2019 19:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7TTaaDMixXPQb0zQn53Ua2GXjIgAh3GfRyOj9qxPM8=;
        b=qakVF809Nq0M7HUyjvc/qNaoPR60lwOMZ5gnss2TOiVr76tLjIxdj+pd6X3pkfJrpE
         MKoIHojQoHBQSZrVVlcHGFty+hjvKUdPJPaWkWATFgfaIl1q++UwPFl33a7JnRWLDTdu
         w3pRD/UXCPe98Ratj9NfnSHoB0hJpppNHVTgie1fiTUKLWBWjqHth9+jteL7kdz6PQVn
         ERBalIsz7VVpNORd2jgCFv/hXjVKF+azakcxkEgdDzscVBOlpWU1nyOd++FmNWVkrn39
         4ndZZT+w5YMGHwtpmiiDVIaMzvkXGx7C6bQE8kbGIOFEeHIlfnkPbTisAzkNYhObrFmP
         raLw==
X-Gm-Message-State: APjAAAUlS61KJZmPCkTAbj3CaLvtnefzCkuMVmIMto854CzbKeb3Lkyt
        D3+PSzhnNzshi9LKyanaUzU=
X-Google-Smtp-Source: APXvYqydit0v2ViafUppj7WrZVIC4jRItpcXRJ5K5LrheeikACjIoxgLFe3FtipDYdOxMjVedHBbqw==
X-Received: by 2002:a17:90a:2466:: with SMTP id h93mr25367869pje.79.1571623839797;
        Sun, 20 Oct 2019 19:10:39 -0700 (PDT)
Received: from localhost.net ([2601:647:4000:ce:256c:d417:b24b:327f])
        by smtp.gmail.com with ESMTPSA id k23sm12559333pgi.49.2019.10.20.19.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 19:10:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Fixes related to the DMA max_segment_size parameter
Date:   Sun, 20 Oct 2019 19:10:26 -0700
Message-Id: <20191021021030.1037-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

These four patches are what I came up with while analyzing a kernel warning
triggered by the ib_srp kernel driver. Please consider these patches for
inclusion in the Linux kernel.

Thanks,

Bart.

Bart Van Assche (4):
  RDMA/core: Fix ib_dma_max_seg_size()
  RDMA/core: Set DMA parameters correctly
  rdma_rxe: Increase DMA max_segment_size parameter
  siw: Increase DMA max_segment_size parameter

 drivers/infiniband/core/device.c      | 13 +++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  3 +++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  |  3 +++
 include/rdma/ib_verbs.h               |  4 +---
 6 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.23.0

