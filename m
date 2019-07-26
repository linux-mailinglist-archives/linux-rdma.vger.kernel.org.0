Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FA761F5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2019 11:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGZJZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jul 2019 05:25:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33705 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZJZx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Jul 2019 05:25:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so50823114ljg.0
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jul 2019 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+PIbmOU2L0JKXtCkLpSiyF+YIeyaYLwnS78i5Iju9M=;
        b=dbYOmz3UopyNMm7b+ZL7OYeHZdKMjC8uKvQEM6zd4xeZieU1Gi9gvjgH3EC1AIvYE7
         duuZwTh1H+R8KFptKI/jmo5gs6vbyo1Hn4Yvszu+PAhMscpBeKE0NUDIEylJzsG9RQXx
         O2eO72Dl+2cezfYqquobSJ95toySzW4VpudQ7IDc/a/BCdxaZULQMFGSNR1MEkaqRfzu
         yw4myOKYtau9cDEFTvOv9lQXp+tPo3R7FgKpCKwXTLMufDI4BbufB6HK0z6U+rlKB8h6
         Txn8SJkVcvNbYm8TbvLQK9gHymzUcOxdcaMUAG9qs1HWphbaCs1bXctY+Umltlf2xL9w
         VbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9+PIbmOU2L0JKXtCkLpSiyF+YIeyaYLwnS78i5Iju9M=;
        b=qE+onMgxfzKIJ8RlNMNKrGvq9AyZoDu0tCt1oC3nc82tzqi0sHI2cY2JuXJBvYteLo
         OeV0YOFxQtoHb39RRopwaAI60tmAc1xeNc37i5QjHHLvfQkRVecCbqi65tX8PqyvI2Li
         k6Q4RJ9iAF4WorYvg7F0Ofd+m2BNQM/qseciE3VLxSALwXQq2MCyxjtQWo0bz2c99FHm
         ACofwEMSSlxd3BSHy8nOCyZ4GU7tdAAqZsqqRArVzuTIng8ChjCZ/8wxjGT9Vel1tEg2
         KxUKHZ0sIz72/KS/BeEGGTr+XJc61hBzgK+FvJSEsh11XpRTtgIgbPYgHC6tSKD3J7BQ
         /6ZQ==
X-Gm-Message-State: APjAAAU7tiHwQ2TqfiRJbAlfUqZFT/+yb5EgmgHsy40iCOXylh3qb1iR
        vuJbxUbgwBsOOWkUWBASIwPW7w==
X-Google-Smtp-Source: APXvYqx3uN2nE7n6qS05F8mg8lPbGXuEEWpcKrx2U8qn9xYeIoCbLmf2xLHai/CRWcn88ThrbBoiNw==
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr46776497ljl.59.1564133151828;
        Fri, 26 Jul 2019 02:25:51 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id m17sm9919308lji.16.2019.07.26.02.25.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:25:51 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rdma: siw: remove unused variable
Date:   Fri, 26 Jul 2019 11:25:40 +0200
Message-Id: <20190726092540.22467-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The variable 'p' si no longer used and the compiler rightly complains
that it should be removed.

../drivers/infiniband/sw/siw/siw_mem.c: In function ‘siw_free_plist’:
../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused variable
 ‘p’ [-Wunused-variable]
  struct page **p = chunk->plist;
                ^

Rework to remove unused variable.

Fixes: 8288d030447f ("mm/gup: add make_dirty arg to put_user_pages_dirty_lock()")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/infiniband/sw/siw/siw_mem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 358d440efa11..ab83a9cec562 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -63,8 +63,6 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
 			   bool dirty)
 {
-	struct page **p = chunk->plist;
-
 	put_user_pages_dirty_lock(chunk->plist, num_pages, dirty);
 }
 
-- 
2.20.1

