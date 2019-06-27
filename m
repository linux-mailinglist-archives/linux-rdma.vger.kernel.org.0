Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52D6588AB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF0Rhy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:37:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF0Rhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jun 2019 13:37:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so1676507plt.3;
        Thu, 27 Jun 2019 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vZbLMT75xPEFnkKEVUncUf8nAxbOxsediMRWlL6dS0A=;
        b=SFSjUPJEJvuJSyjQ+LAyTEgVUoO7EtibVeHMzoSKDmuXOI3JP1n1j4vgcXMR5ggsIo
         Hh8PPncNTiS5ygTlALSNrWxAAecQuHtbfRMWF5gNreq1CbEBzcpFj7T/Uvn5/Z6AUGHw
         IbGfUMqvgx4OpjS2wk4zrIHuQxnG+lV+l+5WNCsezdrNgiHjfc3RrDsobY9Bo7+1D8/V
         x6Hs6cPlT63jf5j2uFz5Z7aJCXwoDkDknlaDT1dcjztXrN9hedR4Dbve+JJZ9JGyMb7N
         wpbxBOYwPwTKglRWpCq1obkqZzIaX3fLxA6W4nHpeqTGpRQqJZm/f538PkR+/lfpdFEa
         dlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vZbLMT75xPEFnkKEVUncUf8nAxbOxsediMRWlL6dS0A=;
        b=TrrHqq/9lFD/GerUm57YJ92yjvzfu38yBbwgKcrl2YYxq+hxWRjcbnrCrixz4Su0ZB
         QnH38lkUTHOUWn8QH+HZ0KJJgDuYPZcp6NYgTDuzy+U1N0WaJP0GdxINY4RGSu49NiO/
         8N9BQ9U/nk+WEgcp6Wh3cYpCDMrv7ajYkD64oL3eDeMHZVz3qCnIaZgo58X+onwhW1B9
         ohty2/lBeEmiJXNG4T30uq8ABf6Yz1bc15kK7asnyoRhrqaWvVzvhyxp9F3Ys79066pg
         YpYP9GisysI3QLo8VeTYA98P9v/G2y1WtzOkOXWaK8UuUv3spnmx1v349IHdpnQ4RofD
         R9kw==
X-Gm-Message-State: APjAAAWMemoDGN59+LCB4ZB6w/VDbOOcnZF07CRcGCI/M84ywdKJ+ec1
        McK4LMz9AFtdJElP6xNKSos=
X-Google-Smtp-Source: APXvYqznjtx8hkRzqEa0kwnFZLOkJIW943FyGptWgKDJw0ioaC+bdE00q/EqZ6PU6XihKr9CxoIqLw==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr6043420plb.270.1561657073701;
        Thu, 27 Jun 2019 10:37:53 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t29sm4564327pfq.156.2019.06.27.10.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:37:53 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/87] infiniband: nes: remove memset after pci_alloc_consistent in nes_verbs.c
Date:   Fri, 28 Jun 2019 01:37:47 +0800
Message-Id: <20190627173747.3201-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/nes/nes_verbs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 49024326a518..534f978f1a58 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -828,7 +828,6 @@ static int nes_setup_virt_qp(struct nes_qp *nesqp, struct nes_pbl *nespbl,
 		kunmap(nesqp->page);
 		return -ENOMEM;
 	}
-	memset(nesqp->pbl_vbase, 0, 256);
 	/* fill in the page address in the pbl buffer.. */
 	tpbl = pblbuffer + 16;
 	pbl = (__le64 *)nespbl->pbl_vbase;
@@ -898,8 +897,6 @@ static int nes_setup_mmap_qp(struct nes_qp *nesqp, struct nes_vnic *nesvnic,
 			"host descriptor rings located @ %p (pa = 0x%08lX.) size = %u.\n",
 			mem, (unsigned long)nesqp->hwqp.sq_pbase, nesqp->qp_mem_size);
 
-	memset(mem, 0, nesqp->qp_mem_size);
-
 	nesqp->hwqp.sq_vbase = mem;
 	mem += sizeof(struct nes_hw_qp_wqe) * sq_size;
 
-- 
2.11.0

