Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78193BB25C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 12:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436742AbfIWKmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 06:42:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436612AbfIWKmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 06:42:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so13390991wrs.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bie9KL9yJERoJZj4EjoE8MYg8DxrJf4PDDoi7h/yI5Y=;
        b=QPxdsbTNP7EdrQJX9EfFIUg6w/5lvGBF/OBov1/OwaClTNBrMNVvoX13Ml2f7fCfoy
         A387vnIEScjUnKLvLErICN0PXG3wnNC0elwISc7MfMlSXDOFkvO7jMA75sJQbwZC1LFs
         apCC7QzIJTdK5kfRVrvcAu8Qs7RTs6AQ+72FMkLNvxlHR5/fiMfP2LT3hYWDLQDI0ppH
         PrcIB9pCiyXQZaiwubnZu9eHqh5O8DCPHqpoY5I1qV/aBOz0dKtO6M7tUu38AtbYbNkc
         nrYoDRhL/nmc/QN/g2YFlheDOTwx8ZgqSxMRLmzFrZXnkkurIykomdsNpYspLzPBMKcQ
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bie9KL9yJERoJZj4EjoE8MYg8DxrJf4PDDoi7h/yI5Y=;
        b=AxW55fopYfLwkFnLtVXlVyMew5SPQhlP3NirN4POBTfJdVSCQ8tdE/6uri/mP5DP0l
         haNJVXhUaW8DNFtoKE+2C/lAgLkR451nEqdxWEvQuG2vgE5/xtKq7Wggt8pAmMpBmbYx
         kjlIfBb1Krl7qAvWiqzaGI+phrRHuxSPKveHQZ6w6yEzJNnLmU4BKRi/Ij4m7w1a/yB4
         VzJGYjMjPOLH3bynA8kU1YQXgUbA1nerQtFg6GC7n+PHsmPKCYnZlUiQ8Y+bq9eySwex
         mnxMop9bFqpdBz+RH1Sxir2VpFV6Kz0LGQ3XoyxxxJe3gtI/RjYKl8rOOumHv92KyQiq
         1q/Q==
X-Gm-Message-State: APjAAAWRFOKkEomNKE/YjIl2ALqBAZxakY2LqzxjX6BtHDu9P0z7kT29
        JD86v9DdTj2j1bdlARd1bOqJ4OXn
X-Google-Smtp-Source: APXvYqwTZUkEZnbmUtFSRAbfaxqJc0l/kgRhvcR8jnbyQLiwFPPyxpHMRStzeGiU0PDitoNrBxad0Q==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr9235413wrj.380.1569235335219;
        Mon, 23 Sep 2019 03:42:15 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id u22sm18508427wru.72.2019.09.23.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:42:14 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Moni Shoua <monis@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 3/3] RDMA/rxe: Verify modify_device mask
Date:   Mon, 23 Sep 2019 13:41:58 +0300
Message-Id: <20190923104158.5331-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923104158.5331-1-kamalheib1@gmail.com>
References: <20190923104158.5331-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Verify that the passed mask to rxe_modify_device() is supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 623129f27f5a..fa47bdcc7f54 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -106,6 +106,10 @@ static int rxe_modify_device(struct ib_device *dev,
 {
 	struct rxe_dev *rxe = to_rdev(dev);
 
+	if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
+		     IB_DEVICE_MODIFY_NODE_DESC))
+		return -EOPNOTSUPP;
+
 	if (mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID)
 		rxe->attr.sys_image_guid = cpu_to_be64(attr->sys_image_guid);
 
-- 
2.20.1

