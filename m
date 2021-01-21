Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3162FF2FE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbhAUSOa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbhAUJqF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:46:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A2C061757
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c128so936066wme.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqHnJ2PCqY0GDD9E/M7j7TZIcrnsj5geJs7YkKXUyyQ=;
        b=RTUKiq8Os5P5UyzCC/cUjVpVnM5DorMjaNn+QkLgBUSmF/z/Onh3iZAYn+of7tsD5T
         oZNB2XQtiosWQEzjBU4S7sraSsPlxge80pYuBywKY+agV/0tfHSLbKKwuwKMYQGcPYS9
         7Fw7BcHG1/fzSbVYb6DHGfdUNNsoyN6ak+SC9yEn6m9a3mRp/yFY6hAx9cSjZRl59v+P
         RzMbbG/FHz/yfOm6cM0O/4TUSjiWpCSGZ1hLM2RU0Fj4TSxKlvzPmmfBiPXKm+WHTJPg
         Z9L1r5lJs82BSrmnaBxeIklNWH5VFelO+F4FJBSTtqmv1JiCGo8xDGwTEVxTpgxmCRag
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqHnJ2PCqY0GDD9E/M7j7TZIcrnsj5geJs7YkKXUyyQ=;
        b=HkGAdPJRMpowMsD9WRw2Q1UOxSY2zdN2rMaasaTM/8scukwCvJrb/rhuQdvuRb5Dnr
         QuUdkTWO4cWpzHlZuIwHDhDqwQZZ5lgiNXlDtLFKCBbsBztl+f0aUE7a6WwztLyAmcwk
         7RpKGjTrQLFnFCNvhMAOWAj1c+dNLD7UfeC7y8Hs/NO6W9k3KBM33fQHItV9yp62UIMX
         QrvnBtmxzzWaYMLquCrg3A48Y0Sp90b/TZvOr81LKaLReOGPkhLv19bxIz4lW4IBE1lr
         8YElRIZmXSAvxrheOGi4xZK+KlAZMMWU6c+DlCiSSHLerOI6oxMlfWmwP7Liwbk2ygD/
         ZM+Q==
X-Gm-Message-State: AOAM531S0YNb+HBxAMZ8dJN0LbyuJ6XHEMPYa8lefIl5zEtU0e5qrbEU
        DavtlMOuKxBw62TWGH2jwcq2lw==
X-Google-Smtp-Source: ABdhPJxZCaAzCae2wKCuVCpT+4ho7qtdoImSFpg9c2BEz0qXsuK08X7w5N74AR8JZOUHinI5F+y9ow==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr7997443wmj.117.1611222323296;
        Thu, 21 Jan 2021 01:45:23 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 01/30] RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'
Date:   Thu, 21 Jan 2021 09:44:50 +0000
Message-Id: <20210121094519.2044049-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'dev' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'pfault' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'wqe_end' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'bytes_mapped' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'total_wqe_bytes' not described in 'pagefault_data_segments'
 drivers/infiniband/hw/mlx5/odp.c:1062: warning: Function parameter or member 'receive_queue' not described in 'pagefault_data_segments'

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index aa2413b50adc9..7b30be6aeb167 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1040,16 +1040,18 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 /**
  * Parse a series of data segments for page fault handling.
  *
- * @pfault contains page fault information.
- * @wqe points at the first data segment in the WQE.
- * @wqe_end points after the end of the WQE.
- * @bytes_mapped receives the number of bytes that the function was able to
- *               map. This allows the caller to decide intelligently whether
- *               enough memory was mapped to resolve the page fault
- *               successfully (e.g. enough for the next MTU, or the entire
- *               WQE).
- * @total_wqe_bytes receives the total data size of this WQE in bytes (minus
- *                  the committed bytes).
+ * @dev:  Pointer to mlx5 IB device
+ * @pfault: contains page fault information.
+ * @wqe: points at the first data segment in the WQE.
+ * @wqe_end: points after the end of the WQE.
+ * @bytes_mapped: receives the number of bytes that the function was able to
+ *                map. This allows the caller to decide intelligently whether
+ *                enough memory was mapped to resolve the page fault
+ *                successfully (e.g. enough for the next MTU, or the entire
+ *                WQE).
+ * @total_wqe_bytes: receives the total data size of this WQE in bytes (minus
+ *                   the committed bytes).
+ * @receive_queue: receive WQE end of sg list
  *
  * Returns the number of pages loaded if positive, zero for an empty WQE, or a
  * negative error code.
-- 
2.25.1

