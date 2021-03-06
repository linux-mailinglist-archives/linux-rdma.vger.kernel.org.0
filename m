Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0A32FC1F
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCFQ7T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Mar 2021 11:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCFQ7T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Mar 2021 11:59:19 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401FC06174A
        for <linux-rdma@vger.kernel.org>; Sat,  6 Mar 2021 08:59:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id d9so4975031ote.12
        for <linux-rdma@vger.kernel.org>; Sat, 06 Mar 2021 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ujMQlMJvkDJMf+J4/U2ZXTZHWfnO4gPq/YpskvaiY+Y=;
        b=uRrGGXgrUtsNoVIffMx6lH+difQtmloeF+gly/iax4jTJQg5NP/oPFQiHJ0/8H2xcp
         WTPAnEBagc0HZNmuJDaV01ecoITT5OLYi5CS2MJnNmlc7bR8kCEYosyiuQwgMGSy4GOu
         vLzbnEICgeRJSv07iD1ASzromytHKo7slByAqzim8vAAwWuTUxc6V0yLzUIxRqed4vyC
         3UrESCjnZNpnN1o9qHEhioV2VsGMnXfFI2FvZRnAPSFo0TZONzfMGuwvf2TJQ5pQ3rFK
         zYTjN6eGWRif0CEZNf8EST9KQ8SkQbg+wByl5Y68D/2Q0MMSLurK2URkT1W7LrYSw+/h
         xj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ujMQlMJvkDJMf+J4/U2ZXTZHWfnO4gPq/YpskvaiY+Y=;
        b=D/AVrISN9pcBsgAXkM22FcFdhf0D5kVhMdPWHsTETI81s91hClWMEIxVyy/LYw+DgE
         VpiqGAtVK/udC1/VYqcXQmp9XusfJHVBzX2yC6VG9rDJvi1BanzUdjo4AmyrM1chPWQB
         plVyvQn9lGheiN2QEcDtWROrucVNoChQf+7fdY1helrC+/VKmQogYEIKG35UDDAqxWpX
         sTXQ9IyNJbmbPiYyERtc652P4nHx+zT94PVJt+QREv1WmThoWgUBAHGYVndY/8yLgzn9
         7VNoUpzthOddj6hclbkvuvo2UMZg86/gZ9LrrWdIVRI7r0gbB69eUi0jbFzAGqVfTTnn
         RxqQ==
X-Gm-Message-State: AOAM532+v4CkhfNH1xTQQMK6WdGpKvcEpRLdYJai0LANr3qUs/VqcFBJ
        o3t1JlRkj9xvJDlUeoXCpnh5LfL7f7NyNrgf1PnW8dUhM9Q=
X-Google-Smtp-Source: ABdhPJwCu3hgUwsBG1JQlwbfT6sKgG1RuiCCTnhhTLT9tXBJqCC/RKcH53xwjvYabnhemo7GQJgcEmvU5MH7j4Rl+Xo=
X-Received: by 2002:a9d:7650:: with SMTP id o16mr3940242otl.278.1615049958448;
 Sat, 06 Mar 2021 08:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20210307004256.7082-1-yanjun.zhu@intel.com>
In-Reply-To: <20210307004256.7082-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 7 Mar 2021 00:59:07 +0800
Message-ID: <CAD=hENeugBS6mGMwqMV+zXrOMSZFk_num3wAYRyD6YJhkfXDcw@mail.gmail.com>
Subject: Fwd: [PATCHv2 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable
 set in cmdline
To:     Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
in the stack. As such, the operations of ipv6 in RXE will fail.
So ipv6 features in RXE should also be disabled in RXE.

Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
V1->V2: Modify the pr_info messages
---
 drivers/infiniband/sw/rxe/rxe_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
b/drivers/infiniband/sw/rxe/rxe_net.c
index 0701bd1ffd1a..6ef092cb575e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
net_device *ndev,
        struct dst_entry *ndst;
        struct flowi6 fl6 = { { 0 } };

+       if (!ipv6_mod_enabled()) {
+               pr_info("IPv6 is disabled");
+               return NULL;
+       }
+
        memset(&fl6, 0, sizeof(fl6));
        fl6.flowi6_oif = ndev->ifindex;
        memcpy(&fl6.saddr, saddr, sizeof(*saddr));
@@ -608,6 +613,10 @@ static int rxe_net_ipv4_init(void)
 static int rxe_net_ipv6_init(void)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+       if (!ipv6_mod_enabled()) {
+               pr_info("IPv6 is disabled");
+               return 0;
+       }

        recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
                                                htons(ROCE_V2_UDP_DPORT), true);
--
2.25.1
