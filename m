Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2746885F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Dec 2021 00:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhLDXwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Dec 2021 18:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLDXwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Dec 2021 18:52:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8440C061751;
        Sat,  4 Dec 2021 15:49:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 137so5294050wma.1;
        Sat, 04 Dec 2021 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWsnLUzt7xPyfaUEp7AhtS+i4yJOhxJfuwFef1QcioQ=;
        b=MA90VAWGZs5/+OM/gUMZQ4HvKMjYJakgjAGicJ+e96yL97S1g+cVPZoeDTO1IBOJYu
         BLNWDR9p+aHqXP4JOPxv2SZJht6Rsshz7RoRCbmVy/L8MDrvqaw/EpIzxYO7LybwmTqu
         AWv4jmxVsd0IcuywtoKDNpedHCgaOgNQ6bfmksEZtchBEzp9iECqLoM2HW5ZfgZtOq08
         iI2VVYnlAcfplIy87feZTL+OSdOCFArX2Eov4pU7Z414GwLG7rwgRSRmIcZHcc7Gm6xb
         bxte7NrTxYloDk6Q+l4eclCsWVypXvG9rl7icTJvb05LS/71k3vdRMrlZo3nYscK1py/
         8HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWsnLUzt7xPyfaUEp7AhtS+i4yJOhxJfuwFef1QcioQ=;
        b=g1kKlFTIPmW3zj/FcIXR55lfyRoHQuVeMuMureVRwtPi3G+1dD4vDXuQFNicLctzKP
         8Sg9c2vjWiXVMl0L4vUbc8x5Fk8Qhn0jjTIscxhNbY/9Ydmdpr+cVUSJAh7j19DeZRjW
         U3cJnDOZW3i4Xa1zDAI67CsFL5QYEkIJJLjhfT6YfxNBHp5Ctrjd0qoRgv/+T8MiyIeL
         fgaZv0a1Cb1/zpsvDZowms22suozpHKsNdNv55ozqXrRndo9yc/YeC851khm6oC8mKSv
         oMuyjoBxPMyMz6YDc72D5ClylvQrPRuDW6vZomJVxRA17/0Bywn2qDvLAFRFP/LNXJ/I
         Q4cw==
X-Gm-Message-State: AOAM532Ss8hw8y90BeM1+PLKXewxD8iYEpZ+8RxpmIawlpUuDNEYFDzf
        gL1Zh/RO/zcDAOf4fujxvBA=
X-Google-Smtp-Source: ABdhPJyquTw+gollfacPNGvbmh7rTCuMo2tpX9RD66yE/W5y2bKwUkROwhBXl+w0tJmpMH2LGXmsdg==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr26535230wmj.166.1638661745589;
        Sat, 04 Dec 2021 15:49:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n15sm9278184wmq.38.2021.12.04.15.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 15:49:05 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/core: Remove redundant pointer mm
Date:   Sat,  4 Dec 2021 23:49:04 +0000
Message-Id: <20211204234904.105026-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pointer mm is assigned a value but it is never used. The pointer
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/core/umem_odp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 7a47343d11f9..aead24c1a682 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -227,7 +227,6 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 				    const struct mmu_interval_notifier_ops *ops)
 {
 	struct ib_umem_odp *umem_odp;
-	struct mm_struct *mm;
 	int ret;
 
 	if (WARN_ON_ONCE(!(access & IB_ACCESS_ON_DEMAND)))
@@ -241,7 +240,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 	umem_odp->umem.length = size;
 	umem_odp->umem.address = addr;
 	umem_odp->umem.writable = ib_access_writable(access);
-	umem_odp->umem.owning_mm = mm = current->mm;
+	umem_odp->umem.owning_mm = current->mm;
 	umem_odp->notifier.ops = ops;
 
 	umem_odp->page_shift = PAGE_SHIFT;
-- 
2.33.1

