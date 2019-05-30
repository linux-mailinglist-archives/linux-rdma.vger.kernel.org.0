Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90B2FAF7
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfE3Lfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 07:35:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Lfr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 07:35:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn7so2441898plb.10;
        Thu, 30 May 2019 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Gt0gUf0AQbrtJK63hcCvf0nmCK2kTuZ6XzEzk2of5ZQ=;
        b=ZIvI7TKl3IrUTcNtE7do2ad/sqMf0L09luhAg7lm8GG4B6M8sMvXew4ID39CXRwi3w
         YnOhkOf/+3mL6Mzd149eQR8BWCYbCzgNY40XBnLpWDbVBwyixJIlMlGOI+l584OUU1nJ
         /IJkh0vkkLEzcMmugu/6UtJTarJoeC+a6UdsUVRsYowSCkx9mjU/EMSMOO1/egxjDuJR
         zFASo2URvqCLTC2jsNvybmAUMui0yb/vcRaZ1Qu9wn3Pa8InZjCOCi/wzazSs/ibZvSQ
         X3SqwkaIgzBA00zq0FzBroHq0O5nnw3/0UceSr5dOQzZXWJD+f+NopPIHF+rmKW4/RXU
         cEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Gt0gUf0AQbrtJK63hcCvf0nmCK2kTuZ6XzEzk2of5ZQ=;
        b=Y8Q83hx4MnvZsVnJ5T4w9nGp0tiHgA/P8rhTdMB23HAcY6Q7bcmllgu5YvnCttdwHK
         w3sr1JvSOKJj5al4fKERHAs7i8OUnY7Px98XhD6As9ioyu5yvi6K79zoLnFE3gJyBPjM
         7g/kiISwo+BQn1bjjbG6cYo6aUp1rVT2u1l5+sfHzBberLceFPHDmnkpkhTkV2haVaw5
         KO0FRVCoAURiJdXqIA/qZl77RzONsbwtzxF1PR/+b9HGlsCCyCJUP2Q6VXSVCgtGFols
         RZjOGjzuZ6mbm418oVZTfKrN8BpNrqlVfKnHlZdI9BYJZ9ufCI2ck7qQtnmAjeWXGXCe
         gt7g==
X-Gm-Message-State: APjAAAXX/BYOlQj3cQcuJn7WxM8uCNWlJIqMomV5MiumSxr3DZNd+vfa
        Pyd70ESeGyFea8g/tj0i9Yk=
X-Google-Smtp-Source: APXvYqykuZ4mMIqMrhhMN+jNTuTfDgkesJM4mLM9Y1u6c+MYbZtMrGMBTZuoUncnu/pqD7aym4+HPQ==
X-Received: by 2002:a17:902:b584:: with SMTP id a4mr3357771pls.333.1559216147397;
        Thu, 30 May 2019 04:35:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18sm4620520pfj.17.2019.05.30.04.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:35:46 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Ariel Levkovich <lariel@mellanox.com>
Subject: [PATCH] IB/mlx5: Limit to 64-bit builds
Date:   Thu, 30 May 2019 04:35:44 -0700
Message-Id: <1559216144-2085-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

32-bit builds fail with errors such as

ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
Cc: Ariel Levkovich <lariel@mellanox.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/infiniband/hw/mlx5/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/Kconfig b/drivers/infiniband/hw/mlx5/Kconfig
index ea248def4556..574b97da7a43 100644
--- a/drivers/infiniband/hw/mlx5/Kconfig
+++ b/drivers/infiniband/hw/mlx5/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MLX5_INFINIBAND
 	tristate "Mellanox 5th generation network adapters (ConnectX series) support"
-	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
+	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE && 64BIT
 	---help---
 	  This driver provides low-level InfiniBand support for
 	  Mellanox Connect-IB PCI Express host channel adapters (HCAs).
-- 
2.7.4

