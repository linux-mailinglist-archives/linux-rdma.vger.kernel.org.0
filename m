Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004F068290
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 05:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfGODSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Jul 2019 23:18:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35545 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfGODSa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 14 Jul 2019 23:18:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so689770pgr.2;
        Sun, 14 Jul 2019 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aE6SuAr5H5qAZWelFb9mqN1QtTfGNscONvOMNDLeXBw=;
        b=k/f3yj+0PsBpLbdtsVd1+GCSWSgqMGhZ1gNERlD7lU3ICNQvgVuzTXXdwH2+u2NGTI
         wc+SEb/dUDQpr0RfNt/TxdnYz9Q7rPSTJYmzaHP3tYGvpeFw8EBe5XDwR9iXVEkIfAbf
         e6ZZ5tXwFvEwz+BefsUJ3EH1adqweVjEnXYAMw2yNUdvPYP05Hefi2JtSrlE7PpJaiqh
         U2g2gecw7ji2D90MdpFj72s3ghZYPf76gMOmltsXlvFkjijNx3++SkeLAIJ1+12mVv8M
         OweIA76Llu2mkAajBhxdrlOBFiuHGNA7nHV48ob4We3US28VcMdY8T4zkqq/AOaNgnWG
         wboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aE6SuAr5H5qAZWelFb9mqN1QtTfGNscONvOMNDLeXBw=;
        b=HjsCd2ZdSWXsyc4BAi1TBvE3Cfeo6gZ7Fpg4Yve4lVQcBiJll1gLWq7zED0KcytyEl
         cW8IXI6ix9uTmdgQ2Wot/LgH6x66vTKnL0XpFwNLOndrFZEJF2KMl4S29VQ6KykRCTFr
         sP0bA7HTY0X3ims7TA6/JFqu3EbEE887VW43BEm+Cyw8HsRoAya5bDxT/yPMcQzXHi+k
         07cZDznd1HPBSHT0y7rWAn0rgVCTlqzKWoGnPD0hWuUxLpA90epLFXp2ZMBpdbDxaGau
         /05/v6GJmJkJKxOOXX0pxo1XbpO0bRaV64h3rWZeLgZY7QFH9BNbxU+pwB6XTISOErnn
         4ISQ==
X-Gm-Message-State: APjAAAU6hByi6Q/EIvUlsbxTp73l0RoNPwzF0rwIyIq298N8rJqk2a90
        mff/838Vcfv0Crec9XpjxdQ=
X-Google-Smtp-Source: APXvYqykfHc/FmjeX8n9Rl11ELrzB26XfmyjybneiTcpRvkg2er00sas9TCqoZ3C7yYWEHb37RE9VQ==
X-Received: by 2002:a17:90a:3401:: with SMTP id o1mr26579989pjb.7.1563160709937;
        Sun, 14 Jul 2019 20:18:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id z20sm22629240pfk.72.2019.07.14.20.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:18:29 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 11/24] RDMA/nes: Remove call to memset after pci_alloc_consistent
Date:   Mon, 15 Jul 2019 11:18:23 +0800
Message-Id: <20190715031823.6704-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pci_alloc_consitent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

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

