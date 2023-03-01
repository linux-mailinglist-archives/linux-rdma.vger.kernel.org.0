Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822E6A671F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAEwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCAEwn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:43 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913099757
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:42 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bi17so9876376oib.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t+RYCR+GPDypYJCw/mzDu3u7+tUDxfIXpU6DUOVASg=;
        b=GDnTZ2DdEuvjVcBRjktEMVLUm40jKnc4aoO8C2qM1IEvuS8GKJswK8N4M0+1hK564U
         YKrAKOSwEHaufB1EjdMiDITmi3mo5m7x76sTlHrVWaGHXCGFEeKs+XLqqAwemL9sr5O9
         QEiQs5AD41K6IXaJC9YqWjX25YVUf/HU5aty68WUubmGCC4JBoUekFtusZfEIs7cEfjg
         mPeUTRa8cS8JBHAUai524kwKnfhulYBg/wzdEe7nBqETv1Gp9+lVq4gl6Kn+qZ5YLclx
         Kg7prC7V9qpNy6cipDiu8zQ4S321xE7bHOOOeyaX8iYrx++01abThXkA0cC7rLUhgO9r
         NMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t+RYCR+GPDypYJCw/mzDu3u7+tUDxfIXpU6DUOVASg=;
        b=FA73VjD1h1boeKxXdeWq446e4DsZKGc+9xG5LWaFR34qy42xP7RA1SR8QolbBI0ioC
         MX9C+YmbCYOHheqqL9CTdw7F1jIzeDsd1Tbo1c9GARf4AKiYRbytcpGKef/e0GYJxPIX
         EKB/fMUs2TbAjHG3cCDKFtbExh6ctyDZ9kz/2A9/ANf6CdGBrHU2lyz2PE2Gnfdd+dKO
         5WctPmQvNk+FU+lNrupk7lPnWOiYFW9pzHdzj7l2bzEFixKEboU9olAwoMmKPqRnWFej
         +JTXzAg8sy92SrhAGQJElxFCnrG2aEsmxTaN3aFkplXvlIokWY4NBBjvkTGVa0/OdnlB
         vSAw==
X-Gm-Message-State: AO0yUKXmTS4TBV9aJY2hcbHcmuP8qbTv+e7B0mPzDun+PVVXEZQbKkI2
        y2Evx0Fkh0ehyxHYGYs4vug=
X-Google-Smtp-Source: AK7set8sRQslXu/qq5Vs9+yhdaEgxPqUp+3WMk/ouoB+Jb+c0nwCgDdDqCLiDUjhu0+Uptyjqi8o7Q==
X-Received: by 2002:a05:6808:148:b0:384:1e0c:fbbf with SMTP id h8-20020a056808014800b003841e0cfbbfmr2406320oie.40.1677646361865;
        Tue, 28 Feb 2023 20:52:41 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/8] RDMA/rxe: Warn if refcnt zero in rxe_put
Date:   Tue, 28 Feb 2023 22:51:49 -0600
Message-Id: <20230301045154.23733-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds a WARN_ON if the reference count of the object
passed to __rxe_put() is <= 0. This can only happen if there is a
bug in the rxe driver but has bad consequences if there is.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 3f6bd672cc2d..1b160e36b751 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -244,6 +244,8 @@ int __rxe_get(struct rxe_pool_elem *elem)
 
 int __rxe_put(struct rxe_pool_elem *elem)
 {
+	if (WARN_ON(kref_read(&elem->ref_cnt) <= 0))
+		return 0;
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
-- 
2.37.2

