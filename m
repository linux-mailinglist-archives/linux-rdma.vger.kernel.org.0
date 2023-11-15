Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAF7EC729
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjKOP2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKOP2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D96F19D
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso10696695a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062078; x=1700666878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXVhHS+esCbUis83o9HgRtgY9C2LVzgM15KGu0G+oHs=;
        b=Et4L7PyhSvUFMKsbre+FL7woptaHtWNky4XILXsN3a98joPTcwbcv6ObQpjJcJZS9Q
         iwZZ/L28GvsFHQqrOJGDNnA9pir56OOa+UMrY1omTdVyQR2qZXy+kEtoOK1qFeVvmbuU
         6wgk3dDwGTj0QnP6gj8I6hHPyVB9tle5LubPdyHLCBVanqvZ96fEnntxQ35dqqvT53Mn
         jtZENoot5Af7Q6d1xxIl1KFYv1yvdIW3UrRlvir5et0Iazzxz8QZKtD3l3QlLro1WSJs
         343ItU1XDP13ynr4zov/Dd5gdfv3ankz61vvLqsD2/Zhkcka3Sy5fyIjsQa5kNhFvSI7
         emQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062078; x=1700666878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXVhHS+esCbUis83o9HgRtgY9C2LVzgM15KGu0G+oHs=;
        b=muIBSECIKzNgIQ39J0EcjA2ahTKeZu9uKFNb0aawYqd4HSwCGfDTirfPPL5hpAdL2j
         mix+6Gn1+M48YhifyuAhtyjezus07OBYn2AAOmVdTSFo3Sv6CEoD7lDB0wHGs/EIZcj5
         6JGHgAi2UCjCzodiSwuPS+T8Ql2pdKKCClD8RdHU5l3ugJMGJo3aqa9qp8vO1HBujkOq
         ret7PmWWFOtuI3seTBqdIO0a9N9LGTMYZxTwXURVfBt+oI5d9anRY71vT/77uClKeiRA
         LzQB3bTTl/O23F+F5J87dE2kQDKRZy+PPhzKhpcNxe+DkP4yIxLTG7KDyZ6Fyw3QpszY
         onfg==
X-Gm-Message-State: AOJu0YxZ2EERbpbYHGCdGo2D31pmdObA1VO8kR0JnJybq0xDvSl0Y0eP
        4YY6zQ35oLA+BEmggMAXVg8/PAiaW+UTlEGeAoM=
X-Google-Smtp-Source: AGHT+IHU11tSAaiOQYuQKIMF6+OBUWDUgBSyvA/13IHjTvOKVWca6MKAZ2FW4a2xY5kWC2ZKDvOw8g==
X-Received: by 2002:aa7:c045:0:b0:543:5f3:c92 with SMTP id k5-20020aa7c045000000b0054305f30c92mr9476082edo.36.1700062077971;
        Wed, 15 Nov 2023 07:27:57 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:57 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 3/9] RDMA/rtrs-clt: Start hb after path_up
Date:   Wed, 15 Nov 2023 16:27:43 +0100
Message-Id: <20231115152749.424301-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

If we start hb too early, it will confuse server side to close
the session.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 984a4a1db3c8..83ebd9be760e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2352,8 +2352,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	if (err)
 		goto destroy;
 
-	rtrs_start_hb(&clt_path->s);
-
 	return 0;
 
 destroy:
@@ -2627,6 +2625,7 @@ static int init_path(struct rtrs_clt_path *clt_path)
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
+	rtrs_start_hb(&clt_path->s);
 out:
 	mutex_unlock(&clt_path->init_mutex);
 
-- 
2.25.1

