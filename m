Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE86114A76
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2019 02:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLFBYg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 20:24:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45724 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLFBYg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 20:24:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so1976534plz.12;
        Thu, 05 Dec 2019 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEsrWVW0HwmOsVFJJw4nLhvKEtLDOtBM/LHp3eOGtHg=;
        b=Cttvg7su4A6+PVhvW09cCHSYKvWVkwU9RVk0Q7zmD5/W746mWH8Ef5+i3gG1uJ/d60
         umQFZ1vbS9Xuygej+dIzwLhbO/S0QDk/F7QIlbgrwNE7K+4j7athkWaEbQqiQZIrQ9Ms
         NwsiZ/7hz7BvTltRqtfUphFuYDk6Uyw/FJDbkmpfx7qBRIXt+Kc0cSD/esMR5zAXW3DM
         oqjss2BAJ14GKXpNXgnHechy3iklgT0QQaPYtTtVw7iZgIOK5bMuMzrZqVRQ2MVpsvoo
         0P6SQxlBHykKrFba+VO273H23qLfVdlMbtFUkkUVK9OrZVmVJIm52Y1P//PFFXA/Pjsi
         TaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yEsrWVW0HwmOsVFJJw4nLhvKEtLDOtBM/LHp3eOGtHg=;
        b=Cb8BIa6cpJyC3cPbPpSUgCO5E8GBklnk8KALxA8gB8GIQRFTGDdfuVnCcVxKXc3YyZ
         JVFM1w/KyF+IRRQxDpOaE9rN2xrau3/1K1bhpkpsaqJZ6RPW4CYLOPNIHkl2A4CH5Qpt
         /XP8WfuPQVRLoZnhQ9PrR5svdxBj6sfBQ32+7Wae3T5uJ7p+7ulUnSlmlNvKq/Cl6qOF
         FcAviaovvj/ml/3iJxLbzw7vFZQSyS/CAIEcPZFp/cLo3nZnjH87wfxqZzJL11NenYE3
         LN8BdSgDC+d2en9zRvuqqFlTCu/1gNdt5PUQiR3MQ5FJ5zb0wqnGD/BGpOG4hwT+MaxI
         CHZg==
X-Gm-Message-State: APjAAAV514z2pFYF5ESBnDDJ6xCBC3SgqDZQppzARbzlJRrTIaBgLeN7
        vKPEThc9plrIg6/ClQOKPus=
X-Google-Smtp-Source: APXvYqwRAjcAuD553Owy+TPa2K5/wy5j4g/ih8l5A6lrWw0Lfa17tJW9vcvEvoRUfp5G9jzouTfCjA==
X-Received: by 2002:a17:90a:f0d6:: with SMTP id fa22mr12659929pjb.136.1575595475535;
        Thu, 05 Dec 2019 17:24:35 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id c9sm13282596pfn.65.2019.12.05.17.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:24:34 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] RDMA/cma: add missed unregister_pernet_subsys in init failure
Date:   Fri,  6 Dec 2019 09:24:26 +0800
Message-Id: <20191206012426.12744-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The driver forgets to call unregister_pernet_subsys() in the error path
of cma_init().
Add the missed call to fix it.

Fixes: 4be74b42a6d0 ("IB/cma: Separate port allocation to network namespaces")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add fixes tag.

 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 25f2b70fd8ef..43a6f07e0afe 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4763,6 +4763,7 @@ static int __init cma_init(void)
 err:
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
+	unregister_pernet_subsys(&cma_pernet_operations);
 err_wq:
 	destroy_workqueue(cma_wq);
 	return ret;
-- 
2.24.0

