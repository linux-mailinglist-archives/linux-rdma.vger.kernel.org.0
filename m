Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C376166DE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKBQCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKBQCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 12:02:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9662C661
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 09:02:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l14so25236027wrw.2
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UpIgcCxpuX16JUndv1v99RKAxd8jzd6FAQ3FSiOEFo=;
        b=C3WeWdPzBh+ymQHRxEkskX1A1hhpTZxl5+HvrHoUfcl5V4YUqOZ+kmemnwsVZ9eLPT
         UhtP9aWO2Z+T+gjrd/VvU/MWRcC/Qco0ACADo/Vtid3Ww0fYa8QVGwV9wd9dGTRUub9l
         qCPtKkZxXAc5VYag8QhkbMCB6LiV0WCnmot+1qPAiAJVm+q77F6u4Ig1yC0tRP8pc7Vx
         epq/CFKTpFMNW/c2HuMk67KAU81FdxUKJ9/NqW81wasnIBRbXKkJb/Vu8V+pabKLEEhl
         FCpHNcJTVPzRCZ8W2eXWNCCdje+4G3hMXsMNdm9bInFtQhdeXqRY4Qb1RDdoKuYBPYeY
         Jdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UpIgcCxpuX16JUndv1v99RKAxd8jzd6FAQ3FSiOEFo=;
        b=tcVPGWfLSA7bKr3N+SzL91m/8gfSZv+e5j+jWhI0VpvC9ja5Lg8m9Ozu3X7JdCctdB
         PBcpfwjENwvw7dowb9R8u5yhIoClY99NC7mus6rBoCj61EZV1ajXJUOty7OP5gbxLmuz
         w91VBGEoYj0MSgIWqOAxU+V7Ecb9zU1GDTf6y3rm5us/SfOjbhwTlMYPdABRTpdwDPey
         LR+iqWPNeXI62iv9j7+4i3bfrrFiqpPlXWA13DFj/uFTpPgqM/tcxXsFyaC9wXUitDsm
         XmE20SjCgkt7hV1DpTpsf0ic1CW28qSpUYVDHFyeoqaUQED6YjwhIFfE4hGVqSwEGW5G
         lAww==
X-Gm-Message-State: ACrzQf2tXJEXLahFDqyG27tRUyEOi4JsukCjah6m+64jf2pdoWU0gqGW
        UAi3Dx4rzNaBmUn3VuYSUu9fIQ==
X-Google-Smtp-Source: AMsMyM7U4WtHw7+2aA0nV5GNsmXIY5cFBsC85Op42Zg6VW9ZaqD1uWn24LT3/lb0AVPpsZFPqCx3XQ==
X-Received: by 2002:adf:9d88:0:b0:236:57e2:c90 with SMTP id p8-20020adf9d88000000b0023657e20c90mr15755853wre.712.1667404945296;
        Wed, 02 Nov 2022 09:02:25 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b00236e9755c02sm3891765wri.111.2022.11.02.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:02:24 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v4 08/13] net: devlink: remove net namespace check from devlink_nl_port_fill()
Date:   Wed,  2 Nov 2022 17:02:06 +0100
Message-Id: <20221102160211.662752-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102160211.662752-1-jiri@resnulli.us>
References: <20221102160211.662752-1-jiri@resnulli.us>
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

It is ensured by the netdevice notifier event processing, that only
netdev pointers from the same net namespaces are filled. Remove the
net namespace check from devlink_nl_port_fill() as it is no longer
needed.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/core/devlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 70a374c828ae..d948bb2fdd5f 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -1305,10 +1305,9 @@ static int devlink_nl_port_fill(struct sk_buff *msg,
 			devlink_port->desired_type))
 		goto nla_put_failure_type_locked;
 	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH) {
-		struct net *net = devlink_net(devlink_port->devlink);
 		struct net_device *netdev = devlink_port->type_eth.netdev;
 
-		if (netdev && net_eq(net, dev_net(netdev)) &&
+		if (netdev &&
 		    (nla_put_u32(msg, DEVLINK_ATTR_PORT_NETDEV_IFINDEX,
 				 netdev->ifindex) ||
 		     nla_put_string(msg, DEVLINK_ATTR_PORT_NETDEV_NAME,
-- 
2.37.3

