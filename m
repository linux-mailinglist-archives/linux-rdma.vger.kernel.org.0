Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B37161C66
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2020 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgBQUnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Feb 2020 15:43:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42426 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUni (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Feb 2020 15:43:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so17938514oih.9;
        Mon, 17 Feb 2020 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mt8KEiHVFXt+VI7oyaRToYaExGUPicwbfI4j6wwtPQE=;
        b=NSM1P5SbjhpDBQ9V9I+7JKKNZZ8Xsi/Ao/gOUbQ1xd+3FCSvZBiK2f28jPw8GLxAEi
         aPZehpxvudMkidUrcGsB2Bew1M4jb7qwd7CU6KSuteWVELybmQqqn+sWdTuiGjRa2g10
         +XPrCy7IfzxuiYXxJGNn7Ms7wtLppo/NuXOOLQgDXLpcxFU4SBFDoIcJJzIs6MrZpt5v
         OK9Wpq4viCjxUrxAqvRh/W2VHdxlS/M8ZahbKDXH/U2gJQ5iTtyzaTqqisYboEJxjtVl
         hNHbFyIaNBkGy8Y7gWacVVo0+X77h06DaEi0HIZrwH3mG260jhh4PYTM8+cJZWgXikmi
         bYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mt8KEiHVFXt+VI7oyaRToYaExGUPicwbfI4j6wwtPQE=;
        b=nHxJb/N0aEXI1NLuEX6v7goMRKLqSy2/f6Oe/ur4GDnQuJUWv1J3+8Y9hjmvmTffGd
         hDULZoeMDf0ZI8lNjXGj5mGcQjgm4DPCfCU5lHtSGCztmG9J67UAI2blGUPRa99n8X8h
         hAK6FSREY/mooA0V2D2ww1ry/6800CZI5OBBLhE3xSp8nd38YT9Sco6bBKmkqD8RqF1X
         TQ3JmRGtHeBALgLm5Cwlr1KtB6i35NHyMlHNhdwPSKDvZGvjTqw4YFRHiSIX16K5a9Ag
         Axrw5TOTyicoVx7j0AmPBQI1veCKvoVSC7tCjY2QEEN1K4RjKyAVhZ154iDOanXAwne4
         RiEA==
X-Gm-Message-State: APjAAAWx8xNsmDH5SniaSlaS6gKI0cMNDnb6qfbkgcsQom4cDI5RRHIH
        XioNkIq8Dk7YsiSnNin+azk=
X-Google-Smtp-Source: APXvYqwScEu4D7KeCYqO8/1v9KdWk5GSYNtypdkxNUfqBHecf0KjewwAPXsmUl0Uj1AZUoq+J4MAcA==
X-Received: by 2002:aca:530e:: with SMTP id h14mr505712oib.105.1581972218092;
        Mon, 17 Feb 2020 12:43:38 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id w20sm545592otj.21.2020.02.17.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 12:43:37 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Date:   Mon, 17 Feb 2020 13:43:18 -0700
Message-Id: <20200217204318.13609-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clang warns:

../drivers/infiniband/core/security.c:351:41: warning: converting the
enum constant to a boolean [-Wint-in-bool-context]
        if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
                                               ^
1 warning generated.

A bitwise OR should have been used instead.

Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
Link: https://github.com/ClangBuiltLinux/linux/issues/889
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/core/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 2b4d80393bd0..b9a36ea244d4 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -348,7 +348,7 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
 		new_pps->main.state = IB_PORT_PKEY_VALID;
 
-	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
+	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
 		new_pps->main.port_num = qp_pps->main.port_num;
 		new_pps->main.pkey_index = qp_pps->main.pkey_index;
 		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
-- 
2.25.1

