Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC6274370
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgIVNoj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIVNoj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 09:44:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6BC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 06:44:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so3422290wmm.2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEql/yKjmpdnbyvaUwyS2yz2YZQa7bcbJnCzko9aQvM=;
        b=mVIadGSz9bfoDqbQZQKiDDZQ6pI/cozM2yIVHn3E3Jbe4xKB2hz1t1WR2WWpmWI/nx
         jhssgBiwKhzfcZTVd1e87IniqfFL5A1H4k7IktZFJE0AMXV8I+b153B2b4Za6zHysphe
         tyD6OdD9dY+3alTCh5ujmYOnJQADmWd1J1ENg7P+q1NYP5rxwBb0MsN6r4+8azD/SEev
         49NQZAcEhJCqxRd8TeqmRW+Ijms+WlWvixnpbkDkixiTWy3gE2hEuS8redBNUfDe4Q2y
         eoqL5TgI2UeYmxBYoqzz4EXqHdpGRKWw0mz/A1cX31PSY+dxaxV4A2NeQFK/DsEDkcZK
         o4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEql/yKjmpdnbyvaUwyS2yz2YZQa7bcbJnCzko9aQvM=;
        b=pb8g7YlOHGg5P4rhIOUBpUpF+nVMQecZ8VkpQPF9dRY1uqpnZ3LeRIeNc5hxrgTVvM
         RziA+YIk44GeEy9uh0OYIPhHhBIExoecs4Yb/5TMx9H6tFWQVR5Sh8XUP31Xy7KBMxml
         9u1+AZlq47HRBPiwpUNqt1xxeN3rQ3m5ptji7Gi2cqzVAuEQKBxW7rbXZe8TmLgimNll
         WeRaWI8CRPyaLsYoYlqBabr/sHX3ez7wvyzpEQi6ptEpGrfZdWzTedJSRX+yXk+cfTiv
         wDafQpr8q5IQoa/iAiEv5KfmO512TDSjDJxrMbZPM74Y8lwOMggrI8xJ6y6hMc5niKnV
         ctjw==
X-Gm-Message-State: AOAM530CelNTXtjhisZbS5v29snfWfEv4l3ryqOAkiQXQf8E7yplTHm8
        Csr8RMOoz8PSz1vmF/e94CX3Aw5bjHk=
X-Google-Smtp-Source: ABdhPJw5nJdPXZReembSLS4tKkMIg5KpmbOMuqYxpczvsDULVdeKKsH3Dk3Oz/I1GWlFYIk4jexf3w==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr1204998wmj.66.1600782277433;
        Tue, 22 Sep 2020 06:44:37 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f:5cc2:9fa6:fc6d:771d])
        by smtp.gmail.com with ESMTPSA id a81sm5074908wmf.32.2020.09.22.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 06:44:36 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/mlx4: Fix return value when QP type isn't supported
Date:   Tue, 22 Sep 2020 16:44:29 +0300
Message-Id: <20200922134429.130255-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The proper return code is "-EOPNOTSUPP" when trying to modify a raw
packet QP over an IB port.

Fixes: 3987a2d3193c ("IB/mlx4: Add raw packet QP support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 2975f350b9fd..3c6ed7a7d407 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -2785,8 +2785,10 @@ static int _mlx4_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if ((attr_mask & IB_QP_PORT) && (ibqp->qp_type == IB_QPT_RAW_PACKET) &&
 	    (rdma_port_get_link_layer(&dev->ib_dev, attr->port_num) !=
-	     IB_LINK_LAYER_ETHERNET))
+	     IB_LINK_LAYER_ETHERNET)) {
+		err = -EOPNOTSUPP;
 		goto out;
+	}
 
 	if (attr_mask & IB_QP_PKEY_INDEX) {
 		int p = attr_mask & IB_QP_PORT ? attr->port_num : qp->port;
-- 
2.26.2

