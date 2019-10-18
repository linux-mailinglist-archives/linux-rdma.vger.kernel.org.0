Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0081FDC18B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfJRJld (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 05:41:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38591 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409690AbfJRJld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 05:41:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so5416766wmi.3
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkzmz2qGtNZ7G3wa+kWShhmOGmor0JHxullS6dxBu0c=;
        b=MrJXh9tRQBaXCv1YMqTQnJX4E/4R+J7pNn0QY8PLBZQfCq0jtqI4u3mlBpBTSjoK1N
         UeK6ibxkxaGOmTo4bJE4df5u8pEuyHLrntEYvSoAgX0OY5d2pUjwNEViuOFIb65JJ3W4
         ddMJuIIofw2DWnsKSoK6p2Wo5sDbQsI5nGg9uBYQn80YeZdmA+K+zJQZ/DOFZ3PfaCQ4
         saJE80sEnwSejY1DCbwbx6qgWYVTa7v1q759ePWMzcuUHUedtq7xABZLdwsQvLzrsBIu
         Znya2DA/5OIoSbS7OAjwjZ/WAxh7DJ/na4aSILfT6miUAm5rP4g5ByYAfCP3PhO3LWkI
         ILDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkzmz2qGtNZ7G3wa+kWShhmOGmor0JHxullS6dxBu0c=;
        b=S1achaFY3n5aXpOlNRtXUuS604KkD929ZORmbV3u7U9l56w+j32cT3QNmB4wJAvNMk
         6urmvt5itT7PMUCTWPtO2cU5PkvPtAeG8SosAnEVhD1EOK6y0hQZJK4LBgxSvtxRRQ6W
         rjEMT4Fn5M4XCHBrmLlNWe60p22zf+c8ueaxg16ef2KfwHiOscC2ry+o99LLs/NGQtef
         A9gWEMuqf3+9f9ifW7yJMPDNlbBEQwNQuLk7OWYUZ1Q0CcXf8sH1u+ASebLSDcTmse0c
         vhIbTkxgjDUyHwm468HjFvAN1D3P1Lkl4W1qqnsD4QAcWJPjuxpwi1TSzpCJyyB607ZO
         U+LQ==
X-Gm-Message-State: APjAAAWYZwnIVoTIYcmulnT4jg0L+2WaCfmK1yRAcgTNIvv2tbndIX/b
        Vv9Ut51w1D/+3uSffd85zjOAchaA
X-Google-Smtp-Source: APXvYqwzThDUqaIUNYHCwMvPHmjObD2i4FAWR1q1VLjZ+UMzOA5Xg2ULIt/ahtSZr6u7X/AK4NgFSg==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr7097384wme.111.1571391692185;
        Fri, 18 Oct 2019 02:41:32 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 126sm2186111wma.48.2019.10.18.02.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:41:31 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v3 1/4] RDMA/core: Fix return code when modify_port isn't supported
Date:   Fri, 18 Oct 2019 12:41:12 +0300
Message-Id: <20191018094115.13167-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018094115.13167-1-kamalheib1@gmail.com>
References: <20191018094115.13167-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Improving return code from ib_modify_port() by doing the following:
1- Use "-EOPNOTSUPP" instead "-ENOSYS" which is the proper return code.
2- Avoid confusion by return "-EOPNOTSUPP" when modify_port() isn't
   supplied by the provider and the protocol is IB, otherwise return
   success to avoid failure of the ib_modify_port() in CM layer.

Fixes: 61e0962d5221 ("IB: Avoid ib_modify_port() failure for RoCE devices")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a667636f74bf..626ac18dd3a7 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2397,7 +2397,7 @@ int ib_modify_port(struct ib_device *device,
 					     port_modify_mask,
 					     port_modify);
 	else
-		rc = rdma_protocol_roce(device, port_num) ? 0 : -ENOSYS;
+		rc = rdma_protocol_ib(device, port_num) ? -EOPNOTSUPP : 0;
 	return rc;
 }
 EXPORT_SYMBOL(ib_modify_port);
-- 
2.20.1

