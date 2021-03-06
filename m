Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490232FB09
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCFOGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Mar 2021 09:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCFOFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Mar 2021 09:05:51 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1FC06174A
        for <linux-rdma@vger.kernel.org>; Sat,  6 Mar 2021 06:05:51 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id t16so4692812ott.3
        for <linux-rdma@vger.kernel.org>; Sat, 06 Mar 2021 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3f4u7+LKJOicUKGybe5l4C16IXX9OYBlo1ifNc2N53c=;
        b=k/fZwcjT0HTrrPuWeOocfix/75s1mMsMxg1GAxYhYWZ0Zh54amUmD+ARVpHNzFcMZ+
         mX7K+zTcp0WB62i17wruZvX4S/NH+DYRpguMWX/zpg4nsg5Hqx/SrwvwX1pM1TOVph1e
         aD+iXiKkXeIgL8KMyZjKTs2SDl6CaIBQ1z9p+GcXYYFWQARkYnb2V2QnrrNYY+KybwYV
         nXS29hXXJWAj78cDQxrHcWF1sznQdv1KEDq70FNNIycEzbbDQpgc01cAmltv5rbRw60j
         MKQh/bPwdmjNSthyH3SdKQSBzN/MJHuvjURqcL8pwmlJPthtbk+O5F7+Lrp0NmZji/u0
         2WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3f4u7+LKJOicUKGybe5l4C16IXX9OYBlo1ifNc2N53c=;
        b=GRfpvqnriRFfjfQ0vuNbF3gGuHQzyYFTd3HU8OLBPRW/9dGiItszL+s8N9aNfxsXKJ
         GO0nYwZVPTjJHpkw0N7xI5bqYVcKC6uKTAEGPssnd5Xl80GPpALiF5ckEvin5/brgu2D
         Dt1zt6yXNeQtCxSp/dJ/qC3Le0yZ/zb1Bo7VTUUNZTCLGK3Lp7Z0jxzHDVnxZ5WDhfFg
         B1D2X8oRKPeKKUsDQEV17REUFUjVBGFjR5jZIEJpIRuhpdTjTLsCQKFsh8s0YP1BaZi8
         h/849NlPEb8uEsDngAce3GsOxuiX0VEOrMEzfNlGCosyg3kZVtvP/frytQY1T9ldk/jm
         XX9g==
X-Gm-Message-State: AOAM53288Kc9hEP6Ye6sdtAcCv6Sc4uqFpNZIwhSLnSXfXHyN5cIefml
        VFuHcI//VRRsBY0Vbmiz4YcUFDh11pG05Xjqrak=
X-Google-Smtp-Source: ABdhPJwr0XBS12ifLBnhAG3SrHpxLf4mmfg9fk9j/DqHZA6+ABNARzJ4/rZIlsKw4xfhJpvdwhx2qUKEMu32C4uaSq4=
X-Received: by 2002:a9d:5c03:: with SMTP id o3mr8841424otk.53.1615039550410;
 Sat, 06 Mar 2021 06:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20210306214804.6849-1-yanjun.zhu@intel.com>
In-Reply-To: <20210306214804.6849-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 6 Mar 2021 22:05:39 +0800
Message-ID: <CAD=hENdtK8qvHEnowpUZ+sL-SoB7bu2nMEDrkFjgdbbhxBqaMg@mail.gmail.com>
Subject: Fwd: [PATCH 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable
 set in cmdline
To:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
in the stack. As such, the operations of ipv6 in RXE will fail.
So ipv6 features in RXE should also be disabled in RXE.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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
+               pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
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
+               pr_info("IPv6 is disabled by ipv6.disable=1 in cmdline");
+               return 0;
+       }

        recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
                                                htons(ROCE_V2_UDP_DPORT), true);
--
2.25.1
