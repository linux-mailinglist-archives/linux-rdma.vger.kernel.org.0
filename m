Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952A47EC72E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjKOP2I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKOP2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B9D101
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so10677759a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062081; x=1700666881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW3a8FMsS31luQZTd2cWIZE9yQSnciSmaftHSgr3QiA=;
        b=Pbl4xroQYvm+7aML2VCmKqy/ix8kWcTIGKOAnUnVq5UI5fb/6gYVDgYXRWNfVMC6HI
         KiuRIvV+gmtnevFYOt5trHVnGkElGpXOOAFMtcBAP3ZlIU6oviLnXjB59TDdt84BHtsi
         XfveWYihxIlMNUSM2KW/T0sjVsKJtqDFH4D55TGM1oXgumKnTGu31mUq7liqHVheqg2Q
         EP5AjhF3clW+Hh+oHKhSqZiZwKeu7bEk0N0ItmGNZxePk1au7yHiuvbiSuXdi06PsnN9
         zxA4tdcqUv8hS0s9HJgJn6lzuCwsjXQW00EBAbMP6QfIY8vcX8SKQe8SIu0R+kIwNp7N
         U34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062081; x=1700666881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW3a8FMsS31luQZTd2cWIZE9yQSnciSmaftHSgr3QiA=;
        b=Nq515ViEn1zI8v/8OSIdi5GfRYtWDkGYWCb7nselL+J4fOCLeJ194vAsS+Abr6XTFl
         94J407esK0TkcUT3NV5ci5mEPm4bVNLoJ6Qp7pj1vTVb3trsds+7ZxS+zPhvD/YpsWJU
         T31Fzuwf7bS7IFSTkfX3fI5P6lMOMAqS5XnN7vAWXeW60QTYLVWZDj6eJYXjlqJq57hr
         77hM2Ui9XK84hKM8BHO4h10GtF32GY8nJZtqmM++moKBZgv1drBFUqkMwRBqf4yk/Gpl
         I+J/QakRNw0huTphOWELHIXQNObZIeFmZaIwpOqhveBtnvTpZSTF35EuFBHmLB/aDXFl
         Op1g==
X-Gm-Message-State: AOJu0YyGqjjkYXHTMIwnB8RY2vEcumyiCvDwcyRWgDv/y+WG/HjLIvMo
        QN+W8O16aDP/1yN7JWlNC3PpZzabhN4kGBq/+sM=
X-Google-Smtp-Source: AGHT+IGegLniqBBH85Ky9JK/BGpLKWwt4QhEwUiTqHSljPIyblh2+CwC1FWMsm+Z5zDuDb3kLrPAvA==
X-Received: by 2002:aa7:d847:0:b0:543:5281:2ad8 with SMTP id f7-20020aa7d847000000b0054352812ad8mr9834481eds.18.1700062081238;
        Wed, 15 Nov 2023 07:28:01 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:28:00 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 8/9] RDMA/rtrs-clt: Remove the warnings for req in_use check
Date:   Wed, 15 Nov 2023 16:27:48 +0100
Message-Id: <20231115152749.424301-9-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

As we chain the WR during write request: memory registration,
rdma write, local invalidate, if only the last WR fail to send due
to send queue overrun, the server can send back the reply, while
client mark the req->in_use to false in case of error in rtrs_clt_req
when error out from rtrs_post_rdma_write_sg.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index df10d29c3fe9..8c5054d18402 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -384,7 +384,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	struct rtrs_clt_path *clt_path;
 	int err;
 
-	if (WARN_ON(!req->in_use))
+	if (!req->in_use)
 		return;
 	if (WARN_ON(!req->con))
 		return;
-- 
2.25.1

