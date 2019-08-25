Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989B19C245
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfHYGBg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 02:01:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46093 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfHYGBg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Aug 2019 02:01:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so8141733plz.13;
        Sat, 24 Aug 2019 23:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6ZsZK4p4MXPI3SkwkWUjJCGWv6W/bc6fpGu48AA4hT8=;
        b=SRaI5KWNYWTd3lexMDNYkbPOGasxLeKLGrGvx5EMB3SLudIjd4zWZRn7/+cstRZRcU
         EEDF9lq4Gubyd1HrhjHI+KmIEVx/n3A57CUvedeBGgv66Matu+UyJw2xlZPLNSq0Ej7R
         XYWLD5n2FAFbimVC0T2TrHb+y9A7WWWZIDhnPCZeIwSOnfWBg2wzfxZKeeHrlypTVxr3
         JdYv++BnVaL7GlmiJfq0TakovfkMg2ks+IkFcg1Wy0k2bgvMrCk1kiOLqOUUDgzpLMIl
         abjO3bo9mGsekKrf9v2j7KSkon3jF4mSBNY6v3eXAw0ZtF8rtvOqu+vY10FviQJV9cC5
         GmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ZsZK4p4MXPI3SkwkWUjJCGWv6W/bc6fpGu48AA4hT8=;
        b=hSVqi9UiGLUQ0nAx0l3sOXz27ckwyPA+dR9mGkIi7ANtkBYn1iKBsada/yM4uKZxOQ
         zASC+dDrr4rpPT2V1nrPC5641QIsCqe4WBiBD56TnBqDt/Ni5zBDackb+/2zDOugpnu6
         EwwBSBN4Wrds4kopSLIidEuQhtcX8+8ASL4w1GF7u+24kUMFHjJZitiKqoJ0zQiBUpTl
         Y/aFH3KrJgvPXySVx+gttj8+eKc6ZmT4OGkvUd0kPI2TJHXU69NXPjKFZoiucpdxFNnu
         0/JVaRy5CXiaqCci0xv+w6WPzbcgkk0C/IVX9SE5LdmEFz2+TcExYSzhSVWjSJEa8oWG
         5Cwg==
X-Gm-Message-State: APjAAAXs5ImW7+pRNlGTdu1woBRoqAX2DJiKccm1OgQKB0Ii0N5Kc2mP
        mfOsK/1caeVhRUXma2YvNPAUWw14
X-Google-Smtp-Source: APXvYqyokA+ZcoLf6u9diGb4xyTkf6EioYCNE+bVNTu3Y05sg9baz/G131P6XSlj/0F5djzC45WhJg==
X-Received: by 2002:a17:902:6a:: with SMTP id 97mr12795614pla.5.1566712895427;
        Sat, 24 Aug 2019 23:01:35 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.17.2])
        by smtp.gmail.com with ESMTPSA id v67sm12361736pfb.45.2019.08.24.23.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 23:01:34 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Date:   Sun, 25 Aug 2019 11:37:27 +0530
Message-Id: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

First, length passed to mmap is checked explicitly against
PAGE_SIZE.

Second, if vma->vm_pgoff is passed as non zero, it would return
error. It appears like driver is expecting vma->vm_pgoff to
be passed as 0 always. otherwise throw error (not sure if done
with a particular purpose). Rather driver could set vma->vm_pgoff
to 0 irrespective of the value passed to it.

vm_map_pages_zero() has condition to validate incorrect length
passed to driver and second it can also set vma->vm_pgoff to 0
before mapping the page to vma.

Hence convert to use vm_map_pages_zero().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0569bca..366211d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2071,12 +2071,10 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 					struct vm_area_struct *vma,
 					struct mlx5_ib_ucontext *context)
 {
-	if ((vma->vm_end - vma->vm_start != PAGE_SIZE) ||
-	    !(vma->vm_flags & VM_SHARED))
-		return -EINVAL;
+	struct page *pages;
 
-	if (get_index(vma->vm_pgoff) != MLX5_IB_CLOCK_INFO_V1)
-		return -EOPNOTSUPP;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
 
 	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
 		return -EPERM;
@@ -2084,9 +2082,9 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 
 	if (!dev->mdev->clock_info)
 		return -EOPNOTSUPP;
+	pages = virt_to_page(dev->mdev->clock_info);
 
-	return vm_insert_page(vma, vma->vm_start,
-			      virt_to_page(dev->mdev->clock_info));
+	return vm_map_pages_zero(vma, &pages, 1);
 }
 
 static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
-- 
1.9.1

