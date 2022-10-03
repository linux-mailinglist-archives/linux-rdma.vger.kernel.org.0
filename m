Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F395F2F12
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Oct 2022 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJCKw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Oct 2022 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJCKwW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Oct 2022 06:52:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C2564FF
        for <linux-rdma@vger.kernel.org>; Mon,  3 Oct 2022 03:52:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qx23so3162947ejb.11
        for <linux-rdma@vger.kernel.org>; Mon, 03 Oct 2022 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Xkrdf+/gpeU5ZHA2wpZ8zSHF8UtvbLtsh5YT340b3BI=;
        b=M9W8FyKtE7LXzRoNB8Sb/sfSubpt/ZijK8IOz3Ee2tcJTAvutO79YJqccrCdFc4gV4
         lBvuvQ32PlIxiQQ/ptBkVhdgtZlH2Y7cRxiX+DRP1fjrAtqIioCpf2jpZMgZecYibtp2
         RwiHQM3iMcZPBraf5mDsSqV7p3Ai1ebYvVBbq+YdOezWp0f8zICR2YxkMekpgoXd+oRh
         oLrYHrXeyMMdJZtkis2deZp8eEkYsb+CLVL8WOXqiyplijKwAuxc5SzTqbTnc3AcYdof
         t5G7OojhrUL4H+uRziS+kpMcoEgfcoh44HjmbyAPJyyjwGASvXZvqenxpjM0yxZsxqqW
         ThKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xkrdf+/gpeU5ZHA2wpZ8zSHF8UtvbLtsh5YT340b3BI=;
        b=3mSuAvnI3M0Y2HJZGpW+lXC46L5mD+wZQ0ucA0LkzkLK83dxPzjrne/uUjt/4l/n80
         NTbtXFOmfcZ4LQoMYSZL56kXdzM88zzXbUHmvSf6ExhrS/3CAByDYY8+lE1hlTjo/fjv
         rRyUqJLgQThtWeCi9LTmz1VtTfPcHBOuSha25Cgh7y0XWh7A0tXCTvP3o94ybMjRuiuB
         f8T6AMOJYTF6d/JJkxrVJC/H4zMPEaRCFAybtRSK2T9E+N5w4h1x1h6x2n4imOWGWhN9
         zapO4/IuiHsrzwik3AlYRZuH0yp8MBhxbH5gquZXm7/g71fxWd27zRwqUsrpZF4bPn8H
         lDGQ==
X-Gm-Message-State: ACrzQf28mK77ho4THCeDBp/XwIBuHggVEpEO055uNroUf62dMk9xtfsW
        cH/DGpMBfjjMONErLFqZz+qsWw==
X-Google-Smtp-Source: AMsMyM5A8U8LA70MkFIGnVea7NS0pnndm/xMbAiWo0q7gd1JHgp5tTEHb7rln48GMWHmvn+xRf+jYg==
X-Received: by 2002:a17:907:1ddb:b0:777:51ba:e58f with SMTP id og27-20020a1709071ddb00b0077751bae58fmr14197750ejc.695.1664794336266;
        Mon, 03 Oct 2022 03:52:16 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170907770700b0078b551d2fa3sm1762461ejc.103.2022.10.03.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:52:15 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v2 08/13] net: devlink: remove net namespace check from devlink_nl_port_fill()
Date:   Mon,  3 Oct 2022 12:51:59 +0200
Message-Id: <20221003105204.3315337-9-jiri@resnulli.us>
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

It is ensured by the netdevice notifier event processing, that only
netdev pointers from the same net namespaces are filled. Remove the
net namespace check from devlink_nl_port_fill() as it is no longer
needed.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/core/devlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index f119ac43c50d..b5a452bec313 100644
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
2.37.1

