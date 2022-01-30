Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC74A3ACF
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jan 2022 23:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiA3W5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jan 2022 17:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3W5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jan 2022 17:57:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B115C061714;
        Sun, 30 Jan 2022 14:57:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so21681399wrg.12;
        Sun, 30 Jan 2022 14:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRnVDlUc0cHdmJ1CgTjVStFKbLl2jN4+t3yT8yZoSSM=;
        b=cEnANCyz3HKi3Fu0/p4/NLI5kIj8zREkE/saQmSCA01QFchsbPst890RIGwBgUMrAM
         3VQMHLTmb4oCcYBXUHTr6zeSWNcDOOVtiGdfasYYQqvrDem26J9PesJWWx+wPT71ujM2
         IOL0b5oUML+1FNLLnNVbRSUCLrdrmt7O/D+hGSj0f3ZU8xZlSpWOrYErQYghRTCIAECp
         rsSDVp4K8cQCrI1MVIf0GnFkGqMv4gmRmDOFyBrI6GEgYGGn06z1JIWxzdfzQQRjXJV3
         ivbFdgz6yTmxUEYETt/Vdw+ZliHd8YbW5XrvGUBPUUBOWI+CNR4TyLLk8B6X8WXEi+cn
         3UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRnVDlUc0cHdmJ1CgTjVStFKbLl2jN4+t3yT8yZoSSM=;
        b=yWuy7WJynaOSA/umoBNDDu3ZNhHCD0LpdGjxBrAfhirtpntgnGcKjD9DtO3Ka2u65y
         TZae33RTpaGh8MF9IUdintCX/+WJgf1LdvRNBve47AromE2xs0dA1FsaeOLPYa8ipw0p
         LB4oNACKc/zWKNj2T2JL/cgl94fFBDZjzsw1XTRipFhEDKjGe8Fxc15LEyfAETwl1Ic5
         HyTuldZoMKEqIzkLn3cXx3+yV8UuM8iypVW+BmSkBPiEhrXX/io3QoGSjXbYe5uG0fTY
         9+aNUjZgdYE0mp9yF8ezVZBzG9V14blHaJ3uw96h0FNk0UXBknUI5NN4PJuuAatIN4sU
         lizg==
X-Gm-Message-State: AOAM5314hPld0HU7mD/l/HrlDXgMAtrtRY146BWIVV+QmciTL70bbhFq
        ImeJxOJyb4zf6Do0IWhkLVg=
X-Google-Smtp-Source: ABdhPJxT5Snxjy7iAudOO6dXhluR0gkiB5JqxZjtG9osbKD+F9INRgWz1RNQc8Gkcj6XeZx0D65HwQ==
X-Received: by 2002:a5d:64e3:: with SMTP id g3mr6767428wri.90.1643583468811;
        Sun, 30 Jan 2022 14:57:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r2sm7254070wmq.0.2022.01.30.14.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:57:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx4: remove redundant assignment to variable nreq
Date:   Sun, 30 Jan 2022 22:57:47 +0000
Message-Id: <20220130225747.8114-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variable nreq is being assigned a value that is never read. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/mlx4/srq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 6a381751c0d8..c4cf91235eee 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -320,7 +320,6 @@ int mlx4_ib_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 	if (mdev->dev->persist->state & MLX4_DEVICE_STATE_INTERNAL_ERROR) {
 		err = -EIO;
 		*bad_wr = wr;
-		nreq = 0;
 		goto out;
 	}
 
-- 
2.34.1

