Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A7D6899
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfJNRin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 13:38:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfJNRin (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Oct 2019 13:38:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so20708554wrt.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2019 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGSj+0zwi0V4FE8yNS+b2NCvo79lwer8DLhs3owmsYw=;
        b=rWLwv6FEKa03sfHl1XwxBo5j2JVahQ3FIK+LD7DO1s6YRcseRODC5844798/MVh1B8
         q/AmBKbO3C4iKIdPU+n65/4MMDTGStFLdZH3MZz79iLxCnNspIMjF2MJZHGi7ydTHDDL
         gjDROGwe7sjaZ7G56x7xQtteIkYJWX9EYwpXVTsMPFQNhPXb9AjRf6TqL0e/RAAcS7ix
         n4ph3NIgXSg3pih/QLOgitLxr8R/ClYSfZ5/lZp39ev7GkkqPKzEMUeuHjG8tFb+8nDd
         d/09N3Gvtde41UUgMl7QhKhDATTf9HJ+yO35UnFqyA7rW0xLB0x/SmDcatLObmAJUS92
         j9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGSj+0zwi0V4FE8yNS+b2NCvo79lwer8DLhs3owmsYw=;
        b=r2wMeaCLyoyUXqQyWJLAEig4RcnlRPX/DuBTbtNCdiwfVrwlj1UBfYcth8+IZei79j
         YC3Fs2Th4/fT3Sfz45KEl5xoFe6MFXFyCJslBa14dfQ9goUmz8xxHFTWAq5eJKSlLtP3
         jsA4lHs/6lizsjWfW6q/xrrpJB6BCPLflsNcMS4UsFlPJA9LMr4W4KFzwLretKxi3Ope
         atGvwqt3BuvTH6040qQ889Dvagk/bN2yQYvwW6X9/iBa4kpQHYW5oBy9AgHWSnEUbfjk
         jU1RPxzzaVHSmKiRzPV2Yh45+6B/uDiMLypDsM/912nGjC3v3Gek1/9HbwuBTisWQxg1
         FHIw==
X-Gm-Message-State: APjAAAXmjY0Tl0fCGRWoRckZZlmpgesMIKkzYFDfL+QKHRHUjV9cXWAI
        gnZvVVw+6ex57kf+TqrOlxqUBJFG
X-Google-Smtp-Source: APXvYqwTJRCT6cdkwMzTc9UDRdsf76Aau/W6dO1zdU2jdEuvEFPS4zFc5OZOBQGzfpP+QXm04Zypuw==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr17424564wrq.35.1571074719707;
        Mon, 14 Oct 2019 10:38:39 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 36sm24981585wrp.30.2019.10.14.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:38:39 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 3/4] RDMA/ocrdma: Remove unsupported modify_port callback
Date:   Mon, 14 Oct 2019 20:38:16 +0300
Message-Id: <20191014173817.10596-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014173817.10596-1-kamalheib1@gmail.com>
References: <20191014173817.10596-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to return always zero for function which is not
supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index c15cfc6cef81..d8c47d24d6d6 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -166,7 +166,6 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.get_port_immutable = ocrdma_port_immutable,
 	.map_mr_sg = ocrdma_map_mr_sg,
 	.mmap = ocrdma_mmap,
-	.modify_port = ocrdma_modify_port,
 	.modify_qp = ocrdma_modify_qp,
 	.poll_cq = ocrdma_poll_cq,
 	.post_recv = ocrdma_post_recv,
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index e8267e590772..e72050de5734 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -190,12 +190,6 @@ int ocrdma_query_port(struct ib_device *ibdev,
 	return 0;
 }
 
-int ocrdma_modify_port(struct ib_device *ibdev, u8 port, int mask,
-		       struct ib_port_modify *props)
-{
-	return 0;
-}
-
 static int ocrdma_add_mmap(struct ocrdma_ucontext *uctx, u64 phy_addr,
 			   unsigned long len)
 {
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 32488da1b752..3a5010881be5 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -54,8 +54,6 @@ int ocrdma_arm_cq(struct ib_cq *, enum ib_cq_notify_flags flags);
 int ocrdma_query_device(struct ib_device *, struct ib_device_attr *props,
 			struct ib_udata *uhw);
 int ocrdma_query_port(struct ib_device *, u8 port, struct ib_port_attr *props);
-int ocrdma_modify_port(struct ib_device *, u8 port, int mask,
-		       struct ib_port_modify *props);
 
 enum rdma_protocol_type
 ocrdma_query_protocol(struct ib_device *device, u8 port_num);
-- 
2.20.1

