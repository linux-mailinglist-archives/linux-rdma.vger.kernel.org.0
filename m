Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D93454563
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 12:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhKQLNZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhKQLNX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 06:13:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76766C061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 03:10:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w1so9254661edd.10
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJji4DY6yxs7c2HS32dihlZ0SeYbbfm5LnsF7YOTppI=;
        b=oqg1M4QW5JWAFl318Jf3BCcyII2na6Ihvx26ZriRPWBdpiYpY0D2a878ANd394O5YI
         HSBZXgieEi/4NzyBY4nSuNxfIY+dnt3E9nW5fqBk4tSU3WtOTfX+s27qVwd9C8wXHMZu
         sWrf0CJuhOAgsjosCwRpGhAZY99nj1EjM3eL+YNQJvGPzK1B/5VpU68JxAH++kmldzXM
         zh4o/Gs1fL8fALHsH4HABc7JVV7R2eeQo0pnGZBjP2tZjwibE35DqTFNJHvALLyEEDid
         JTRyoN0HSitWIJupT2gWIvTtrtmhTMhPb4GBmMPVe9lPdeZt+RE1VnN3xCdXdgmveC50
         y+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJji4DY6yxs7c2HS32dihlZ0SeYbbfm5LnsF7YOTppI=;
        b=R2zTIThdDPKXJHoXV3bYocxYlZR/9h7Msrw6ii6jqYMmtB0gNeBI2OCmFN4zfZQS9U
         6uVDsewTArcxPnrDkypQWj9EMOGRsl30wObpIuhUCJu3WYbT0+jwsPOodUkZQHyXqFeD
         UyCTTJ9rNn9IRpvFX3AI4Os/+7eqSSCUVWS1nPQvn6BNJWKZ66nDxH2+PnjGijGzhz1x
         4MAavJHgFcuZF9bYPiHguVV/POHG1Rw9JfL7r0GpVrJy/vDm1StXfrAJBwtM7MdUUjfk
         kOItWsF82mwpABesbIsQVciNplDm3EO9vyBQfW0eKarvqxw6Tdw42i56anSxcRDGW4s9
         673Q==
X-Gm-Message-State: AOAM531rvD7TTYJvW6C+12Zf3rz2TPWyuDQsNdR24yUQCHKpHu0jCMcz
        LTIoIFlZI4/AjHHVmfD774DI7sPLVsL12Q==
X-Google-Smtp-Source: ABdhPJyRM1pBs/8uJEVaqCshuhRBNKRDlYxsaUCLraAJwjsZwY64HEKeXnRbz9mOV5pkOeW8cgTTMw==
X-Received: by 2002:aa7:c902:: with SMTP id b2mr20507960edt.320.1637147422886;
        Wed, 17 Nov 2021 03:10:22 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id w1sm11557509edd.49.2021.11.17.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:10:22 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/hns: Validate the pkey index
Date:   Wed, 17 Nov 2021 13:10:09 +0200
Message-Id: <20211117111009.119268-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before query pkey, make sure that the quered index is valid.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4194b626f3c6..8233bec053ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -270,6 +270,9 @@ static enum rdma_link_layer hns_roce_get_link_layer(struct ib_device *device,
 static int hns_roce_query_pkey(struct ib_device *ib_dev, u32 port, u16 index,
 			       u16 *pkey)
 {
+	if (index > 0)
+		return -EINVAL;
+
 	*pkey = PKEY_ID;
 
 	return 0;
-- 
2.31.1

