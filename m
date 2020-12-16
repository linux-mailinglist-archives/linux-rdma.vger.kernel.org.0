Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5893E2DC983
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgLPXQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLPXQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:16:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC78C06179C
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:58 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l200so29819768oig.9
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8uD86olxiCaZrASlwVO7mc1iqr605LiqaRsth4EE+A=;
        b=tBoAoJO56IsllZmiL5T3V6sOyAklINXeMJYxjje+YpHxYf1Mp+Yk3x8toAP3ZHBKk4
         BqX4poR3Bo7fL6KiLaJI0Fmht0SijnIhRHVP4de3Tv0HHlefPJQNW+WrTd+4OUu6zdDr
         DjsvhgzNwbhCEVkixIu5dgX6WJn/Nx1IK+0kUk7KDsxY4AdwiYXsf1PtklZKDFpQVwpu
         2pYWNPLY+wiz8+TzDjmb1w1Ovwbxjhsu7wOiF4Rco9xg2BmNdPcFD2Nl6Y3+artIINWM
         d+uJPRM3IOSTiREKZULjKiUaULwEG3LNVwzCS4ICPUYhQyI6RPWW9/QqEqt84rfv9NDu
         KopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8uD86olxiCaZrASlwVO7mc1iqr605LiqaRsth4EE+A=;
        b=D73tPf+ezC8S261/2nYgwW8Me6ylE71fHHSC8JeVtv318ALHsLvgulJDAEE+yi4IwF
         zUhMg1mn5fbSBj5QxqE1ETHG56xhag4QJclsFybqIYaxSgGGnEtXpBVc0uUkx22RpK6h
         Il38ynMBrfAaV/QWPoUanwpZT4REe5gpwH8TW5f36hhqMC0KTZmEhgwI7aYDGego84mD
         OnQ3F8e8g+Pp829aeEyR9uzcbsAXCUT107qTGX3F4izUnB6mgI8rr0tBylZEIiwOC/05
         2KXE5jQvHRgrHwHMbyjq0yPnG13JQODVEm3zPnl23qPNA2Qc7zZPeD7BS5F1pS4y8Cnw
         kpsw==
X-Gm-Message-State: AOAM531nom8nQxuDF/VmvtToSmiAhQFM9GZUtM/PUFzGJrQYT3vThrax
        pZadEWLjTydUg0ieAry0VF4=
X-Google-Smtp-Source: ABdhPJw7n5FqSlkCIJFfeJfhILH7hQsDPqVnXQsj3KwQRUjo7DXI9mOCDUAFaqdjY0qrh8p8dMmlLA==
X-Received: by 2002:aca:c3c6:: with SMTP id t189mr3283542oif.21.1608160558006;
        Wed, 16 Dec 2020 15:15:58 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:15:57 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 1/7] RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
Date:   Wed, 16 Dec 2020 17:15:44 -0600
Message-Id: <20201216231550.27224-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove RXE_POOL_ATOMIC flag from rxe_type_info for AH objects.
These objects are now allocated by rdma/core so there is no
further reason for this flag.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index b374eb53e2fe..11571ff64a8f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -25,7 +25,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
-		.flags		= RXE_POOL_ATOMIC | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
-- 
2.27.0

