Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE821EB0C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNIK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 04:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIKz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 04:10:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3184CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so20190403wrm.4
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0zVNNuC9gPKJDZ51KIhZtCKujT98xSSIIXlx1rNfiA=;
        b=C1ugTTVLHogPttpzrDpybgqgVwvXeM+/eMYd/Vef7+WU0JCWV3HebsA9qh2TxIW2gR
         Or6L5jSmTGej1z/AJfenPkKIUAIU9r+abxW4zRJB49cGd2Tk0BC/upMgX1KMWwV70/4V
         FLRSu6A5EK3mdmhjXmUFbxSYQ5/zKVQFnhiz9hgkrdU/5qqpGAURW/bt+BKR8wp7JZnv
         Lr4WXT6RGoh9HcOkGgVn1q2vzIThYt4+va6aGTl6BkuBMYUN6EhxjX5OZOcnLspBEZUq
         dJVMJBXdFjRQSVQ0SFfi9LcMTNlkbv8Qz+UMmkKtEOAKqNHk8HOmvTR/UQ88iN1R5ZNq
         4IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0zVNNuC9gPKJDZ51KIhZtCKujT98xSSIIXlx1rNfiA=;
        b=m0xmij2GLEJrYtzQun8tcLb4LESSRgDFYvItUCH/MfL9qq1j2ahlh8Vcgj+ZDu7l1i
         f+rGziAuOFmuGXVFi2Js9vmK4K+E7TRl968XTDyzNL8bAquPNoK+oCk/FIEz302ELRgc
         UGqwTF3NUbDh9jJ6nglrZJVaywnZZgriOO/tTOIzpUzZhOYywubPm6CnQbCL7FEg95ZH
         dJHp3xzjGaMdsQwDn+M01uzgB+6xGmftGAdqrybLfAC5/NIC12n8Jhma5Ad752VWARa1
         QMWf2702YsvbK31i/0uuMtzMoYwtjSCYsKUWNorp1mFBsexbs6bFv03+ftG7uyamLd/L
         ku/Q==
X-Gm-Message-State: AOAM530QTSPXwEzIgi09VNOiRw6M/VvpZr2F8dcwm/mK/zNGgiQVPbjx
        9bPwgXJtPU+6rWsMIwx6p8p/QI28/1A=
X-Google-Smtp-Source: ABdhPJwyFYzKPTqd37+a466d1UwzmAgSz+IFL58nUYg5Q0XlM9ukEO4MnQHxcCTECQp7aenx9PJ7dA==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr3621864wru.303.1594714253797;
        Tue, 14 Jul 2020 01:10:53 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-176-63-152.red.bezeqint.net. [79.176.63.152])
        by smtp.gmail.com with ESMTPSA id f197sm3403891wme.33.2020.07.14.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:10:53 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 3/7] RDMA/core: Remove query_pkey from the mandatory ops
Date:   Tue, 14 Jul 2020 11:10:34 +0300
Message-Id: <20200714081038.13131-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The query_pkey() isn't mandatory for the iwarp providers, so remove
this requirement from the RDMA core.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b2d617e599a1..d293b826acbc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -272,7 +272,6 @@ static void ib_device_check_mandatory(struct ib_device *device)
 	} mandatory_table[] = {
 		IB_MANDATORY_FUNC(query_device),
 		IB_MANDATORY_FUNC(query_port),
-		IB_MANDATORY_FUNC(query_pkey),
 		IB_MANDATORY_FUNC(alloc_pd),
 		IB_MANDATORY_FUNC(dealloc_pd),
 		IB_MANDATORY_FUNC(create_qp),
@@ -2362,6 +2361,9 @@ int ib_query_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (!device->ops.query_pkey)
+		return -EOPNOTSUPP;
+
 	return device->ops.query_pkey(device, port_num, index, pkey);
 }
 EXPORT_SYMBOL(ib_query_pkey);
-- 
2.25.4

