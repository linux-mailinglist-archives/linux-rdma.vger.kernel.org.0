Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F06136C0
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 13:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiJaMoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJaMnl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 08:43:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CAFF5B1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 05:43:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so4148961wrb.9
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0g3PNQNaq71jLJ4UpVZaKOXefH28jG9imHyeR9aPw8=;
        b=4eCWxMXB9Aqb/NtwEfrCFCyU7B2E+OE/z4QmM9ekA9NweNMnt09i87EWh+Z3fVtwZ0
         eMu7wnvImnJE9Ov06G9w/B1zr+c4Hg2GMn3hC7YlPs2kGPmuuxH1CKWjPqK4bqtq6jHz
         c7qmBl+hcx0FqYJh4gPZWHxI8ztetLCIJg8JNgwzxdLp0ti3wLp4+aKiCc9pixBIs0HH
         Y4CAx9O5AYiawmzioUs8R96Z3quRY9NlUF0wMkXzNH45jcnCcvrgvnYtXSKdBheXSlLB
         z4HrUuF2b6A9VoI9hIdDOiR/SivopW988O24OqCrW1hqalfzdVOoTHXEsXpfGNRoGV6J
         J7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0g3PNQNaq71jLJ4UpVZaKOXefH28jG9imHyeR9aPw8=;
        b=4j/I6EdGhy1hOC7Maap95te4HJeOoFQ3oKvrBPS2JqPuzVknJWjeHhyvl4eLWId+n3
         MYIHCGuOtmX2MFrpkDcdk2Io/eRlxyiUqtYxK2o+MywsiwN2o/dZzaWtHYXfMU93c1Uc
         mW9gYud6gMAjm0XYVfuie9PQcQ5yZZyZ1G7IAPW74nK+NDwlNXb8FUAgZmvFklbOkiwz
         QZ8HhNRcrHEiOtodsxO+hsNjRTSX3Su6pOgwer9HFkcTozPdMKfTiY8zwkY3sVVSYezg
         hPg/qZsHg/6UNDoTD2qJ92sKk9mpy1/b+DsgCck2EUYNHnrsU9LRojN/fl4BFdJmHdne
         gXxw==
X-Gm-Message-State: ACrzQf34XMUaFxuqhqELxp+1S7TJiwiBnm4Z+B0OWxb9ZRteElabUd+H
        j/DS6H4s4BfneN9TiVifi4jCOQ==
X-Google-Smtp-Source: AMsMyM6H9cuDoRc4K06yGY3dxzpABM2WO8/8ZyIRhfBR7GRvWrinOCzwFFWqyJHqlxFHZPGRnBchVg==
X-Received: by 2002:a5d:4306:0:b0:236:c907:76f7 with SMTP id h6-20020a5d4306000000b00236c90776f7mr3893781wrq.130.1667220186217;
        Mon, 31 Oct 2022 05:43:06 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003bfaba19a8fsm7434850wms.35.2022.10.31.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:43:05 -0700 (PDT)
From:   Jiri Pirko <jiri@resnulli.us>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, tariqt@nvidia.com, moshe@nvidia.com,
        saeedm@nvidia.com, linux-rdma@vger.kernel.org
Subject: [patch net-next v3 13/13] net: expose devlink port over rtnetlink
Date:   Mon, 31 Oct 2022 13:42:48 +0100
Message-Id: <20221031124248.484405-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031124248.484405-1-jiri@resnulli.us>
References: <20221031124248.484405-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

Expose devlink port handle related to netdev over rtnetlink. Introduce a
new nested IFLA attribute to carry the info. Call into devlink code to
fill-up the nest with existing devlink attributes that are used over
devlink netlink.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h        | 14 +++++++++++++
 include/uapi/linux/if_link.h |  2 ++
 net/core/devlink.c           | 20 ++++++++++++++++++
 net/core/rtnetlink.c         | 39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7befad57afd4..fa6e936af1a5 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1873,6 +1873,9 @@ int devlink_compat_phys_port_name_get(struct net_device *dev,
 int devlink_compat_switch_id_get(struct net_device *dev,
 				 struct netdev_phys_item_id *ppid);
 
+int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port);
+size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port);
+
 #else
 
 static inline struct devlink *devlink_try_get(struct devlink *devlink)
@@ -1909,6 +1912,17 @@ devlink_compat_switch_id_get(struct net_device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port)
+{
+	return 0;
+}
+
+static inline size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
+{
+	return 0;
+}
+
 #endif
 
 #endif /* _NET_DEVLINK_H_ */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 5e7a1041df3a..9af9da1db4e8 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -372,6 +372,8 @@ enum {
 	IFLA_TSO_MAX_SEGS,
 	IFLA_ALLMULTI,		/* Allmulti count: > 0 means acts ALLMULTI */
 
+	IFLA_DEVLINK_PORT,
+
 	__IFLA_MAX
 };
 
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 3a454d0045e5..7277169d0b1e 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -880,6 +880,26 @@ static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *dev
 	return -EMSGSIZE;
 }
 
+int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port)
+{
+	if (devlink_nl_put_handle(msg, devlink_port->devlink))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		return -EMSGSIZE;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devlink_nl_port_handle_fill);
+
+size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
+{
+	struct devlink *devlink = devlink_port->devlink;
+
+	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
+}
+EXPORT_SYMBOL_GPL(devlink_nl_port_handle_size);
+
 struct devlink_reload_combination {
 	enum devlink_reload_action action;
 	enum devlink_reload_limit limit;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 74864dc46a7e..e034c0c8e6cc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -53,6 +53,7 @@
 #include <net/fib_rules.h>
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
+#include <net/devlink.h>
 
 #include "dev.h"
 
@@ -1038,6 +1039,16 @@ static size_t rtnl_proto_down_size(const struct net_device *dev)
 	return size;
 }
 
+static size_t rtnl_devlink_port_size(const struct net_device *dev)
+{
+	size_t size = nla_total_size(0); /* nest IFLA_DEVLINK_PORT */
+
+	if (dev->devlink_port)
+		size += devlink_nl_port_handle_size(dev->devlink_port);
+
+	return size;
+}
+
 static noinline size_t if_nlmsg_size(const struct net_device *dev,
 				     u32 ext_filter_mask)
 {
@@ -1091,6 +1102,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
 	       + rtnl_prop_list_size(dev)
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
+	       + rtnl_devlink_port_size(dev)
 	       + 0;
 }
 
@@ -1728,6 +1740,30 @@ static int rtnl_fill_proto_down(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int rtnl_fill_devlink_port(struct sk_buff *skb,
+				  const struct net_device *dev)
+{
+	struct nlattr *devlink_port_nest;
+	int ret;
+
+	devlink_port_nest = nla_nest_start(skb, IFLA_DEVLINK_PORT);
+	if (!devlink_port_nest)
+		return -EMSGSIZE;
+
+	if (dev->devlink_port) {
+		ret = devlink_nl_port_handle_fill(skb, dev->devlink_port);
+		if (ret < 0)
+			goto nest_cancel;
+	}
+
+	nla_nest_end(skb, devlink_port_nest);
+	return 0;
+
+nest_cancel:
+	nla_nest_cancel(skb, devlink_port_nest);
+	return ret;
+}
+
 static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			    struct net_device *dev, struct net *src_net,
 			    int type, u32 pid, u32 seq, u32 change,
@@ -1865,6 +1901,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			   dev->dev.parent->bus->name))
 		goto nla_put_failure;
 
+	if (rtnl_fill_devlink_port(skb, dev))
+		goto nla_put_failure;
+
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.37.3

