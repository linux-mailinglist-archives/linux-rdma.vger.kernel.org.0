Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713E5F2F17
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Oct 2022 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJCKwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Oct 2022 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJCKw1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Oct 2022 06:52:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281CE5788A
        for <linux-rdma@vger.kernel.org>; Mon,  3 Oct 2022 03:52:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd10so21297090ejc.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Oct 2022 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h+iNDFFBmRSTs83x5DP2zCPfIEFpaEyEDolI5fG6fJM=;
        b=NIPcu+oDR8z5ijl1KaJmzCXt/cp/m/fuc9YVYqFyJNUaXARBoi4xjDnFvqeIYhB+3T
         Ok49L9JqPNuHXoQzS4ydVwkkBZN0CO7S97cURO+sXh+Em37z77mbq85STfzb88Su4hbv
         0onoregr17N3tEUVP/BHkARRg5RpRpx0hxFNkwAib4kSc+G9Mno5rjTDmbta1eDO0ZUX
         eoy99nOL6Q6iLikkOnZk6SF3kUysxPqzvLrdyvfZN54Fhtcr8zqgPzmDZtla1T5QzuCN
         7E8ZR170Bh9xzAFwMxjcxZYrmImNEJbhFC/DIxRrugy1fk490HzU3QM3Lmpu8dS5e3dY
         EnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h+iNDFFBmRSTs83x5DP2zCPfIEFpaEyEDolI5fG6fJM=;
        b=Uei5SnGnTSsTJf42nKVkAVuoZ7GQWU8TEyQ0F14+DjqPueDNmhCS5bvFtZ+mzb8r7g
         aXbn1ZiSkSOBgvKVHRy6x6THHSPqo7zSwFcNcJrMq7sSEa5Xfq2SGTXXAAs99MwpUv43
         zp4mvkrwGktslNXw0jMIwr/zW7Siy9V5U0wqZsNMozkMQZ33LAXPwaMc1fdm1TrFMrfB
         TEiu8Ujzl34R5ePyyTcgQ4jozKUgjeEtkoWswPHeOyquNrG88llTxQ7kcB0zCs67FyZs
         UhZZxM0rlFBpyN99J3cDsts9+FDS3STkJoXnbGzrN+Yfl3SzAyLNlFf2NN9mFkysHsDy
         xUVg==
X-Gm-Message-State: ACrzQf2IjhfHbXUrWT99f8x5V2t/0Sj/Y3kEH1R4YdXMNhZJ2mv3GR+n
        GMlgiT1iqqeaGVLjhAAj7O6vhQ==
X-Google-Smtp-Source: AMsMyM7Dnkro7trEPzpMl38dWC4arOUOx4MIzN691YI3hhQleogN2MgxU4NPx6xkcYKjoU6AUoXDIg==
X-Received: by 2002:a17:907:3207:b0:741:3a59:738d with SMTP id xg7-20020a170907320700b007413a59738dmr14436379ejb.110.1664794339025;
        Mon, 03 Oct 2022 03:52:19 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id ku20-20020a170907789400b0078cac2a1faesm484668ejc.202.2022.10.03.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:52:18 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v2 10/13] net: devlink: add not cleared type warning to port unregister
Date:   Mon,  3 Oct 2022 12:52:01 +0200
Message-Id: <20221003105204.3315337-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221003105204.3315337-1-jiri@resnulli.us>
References: <20221003105204.3315337-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

By the time port unregister is called. There should be no type set. Make
sure that the driver cleared it before and warn in case it didn't. This
enforces symmetricity with type set and port register.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 2f565976979f..cac0c7852159 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -9977,6 +9977,7 @@ EXPORT_SYMBOL_GPL(devlink_port_register);
 void devl_port_unregister(struct devlink_port *devlink_port)
 {
 	lockdep_assert_held(&devlink_port->devlink->lock);
+	WARN_ON(devlink_port->type != DEVLINK_PORT_TYPE_NOTSET);
 
 	devlink_port_type_warn_cancel(devlink_port);
 	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
-- 
2.37.1

