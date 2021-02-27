Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C3326D9F
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhB0Pda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Feb 2021 10:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhB0Pd3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Feb 2021 10:33:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B749C06174A
        for <linux-rdma@vger.kernel.org>; Sat, 27 Feb 2021 07:32:47 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o3so13160566oic.8
        for <linux-rdma@vger.kernel.org>; Sat, 27 Feb 2021 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtcXgpKb03h0T6RrYmdUTpR5fd4LDYeIGYCScRSRMEQ=;
        b=HBjZxZBAL9StSoiwQnOWYMWA/J78eEzgI70J2PFZYquBMhOIMwRnsfsEtasLU2yueY
         qVfSS9BKewzGWL4k3grvbILLRhx64gdivvw0njzAuOlcD+j5ziL0YD9GLUoe5n+2T+oq
         aCm0oGgiv7H0TtawARz5JV3P/b3OCrlueEgwMnYigqeqDhKhqYE58dbmNqhZ1HNlGGU1
         hqZJrwvsNFLjSWUoWhJtYlQldoQmopxKOF7+7hI2q0QJYlho6ftIB+K9Dz9fb0gPwk3N
         UT/mx01xGnMbDNrRM0at/nNph158/ka4BzgGaNBA2KKPVJ3JJVvnBSYrTEs9HUf9os/d
         CA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtcXgpKb03h0T6RrYmdUTpR5fd4LDYeIGYCScRSRMEQ=;
        b=sc5Ugw2SW45KdQdNwx4VzeXKN4ghSkEAgXRoGWpAqfW8ZSZlBWZl06SUo5hnUoxCy1
         dHXHxCP31XCt6BRyTdMJKQaCXrGTOy09k3GYvAQg2O2zD3cAhXsP0qHv7HFn8WuQmFUG
         /cYmksT1RAz/6wEO+YIIFUb2rB9oRvBYtfU6QhxSf2GfUXJ+QidIBsjFaaQgiU3VmZ+1
         vXIYlpqrEmQXBego3wcr5qMozgS9zVo88I//ldwlNWafRwIuwOS7L7fklUKQhrjDxtMB
         EWniyNOR5xz2nSm28vM80/Vj/R+ILvRltUmMW2cPAyflGZc01rWBvtz/Y0DWH/dZOCC6
         LbKw==
X-Gm-Message-State: AOAM530gIyV744L07WnSiIUrQnC5cp1VxIos9lygISwxZtQcOuLEm+Gu
        CsrE46JaBcoOcPugJ1BVsWkAjJQU225mGAeTfdo5DmoK5MB3ew==
X-Google-Smtp-Source: ABdhPJwiGpThMMBAojxeKlyXgIEQRUQ8abqNHkW5KCfwywdNxyCyf2CP/QMDbLY08q0WQi8rjme41bi6Fd4wLLUhtNI=
X-Received: by 2002:aca:3a41:: with SMTP id h62mr5749191oia.89.1614439966644;
 Sat, 27 Feb 2021 07:32:46 -0800 (PST)
MIME-Version: 1.0
References: <1688338252.14107275.1614354083739.JavaMail.zimbra@redhat.com>
 <1010828157.14107334.1614354448762.JavaMail.zimbra@redhat.com>
 <CAD=hENfyNMc-wQL5JAX+T3GGaj75mMy8JTpuUrpuqOPY0Gcgfw@mail.gmail.com> <b153b7e2-e62b-1289-3566-c1184e224ed8@redhat.com>
In-Reply-To: <b153b7e2-e62b-1289-3566-c1184e224ed8@redhat.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 27 Feb 2021 23:32:35 +0800
Message-ID: <CAD=hENeotEgBxi7WFmUVg8asxPduJaVc3UR+YSV3DxdX5v0=2w@mail.gmail.com>
Subject: Re: modprobe rdma_rxe failed when ipv6 disabled
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From 9dcdd09f3ca3cf222b563866acd91d18bc4b93d4 Mon Sep 17 00:00:00 2001
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Sat, 27 Feb 2021 23:01:15 +0000
Subject: [PATCH 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable set in
 cmdline

When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
in the stack. As such, the operations of ipv6 in RXE will fail.
So ipv6 features in RXE should also be disabled in RXE.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
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

On Sat, Feb 27, 2021 at 6:18 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
>
>
> On 2/27/21 5:05 PM, Zhu Yanjun wrote:
> > On Fri, Feb 26, 2021 at 11:50 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >> Hello
> >>
> >> I found this failure after ipv6 disabled, is that expected?
> >>
> >> # modprobe rdma_rxe
> >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> >>
> >> # dmesg
> >> [  596.783484] rdma_rxe: failed to create udp socket. err = -97
> >> [  596.789144] rdma_rxe: Failed to create IPv6 UDP tunnel
> > ipv6 in RXE is based on config_ipv6. If config_ipv6 is disabled. rxe
> > will not implement ipv6 features.
> > How do you disable ipv6 in your hosts?
> Sorry, I should give the detailed info, I disabled it by kernel parameter:
> # cat /proc/cmdline  | grep -o ipv6.disable=1
> ipv6.disable=1
>
>
>
> > Zhu Yanjun
> >
> >> # uname -r
> >> 5.11.0
> >>
> >>
> >>
> >> Best Regards,
> >>    Yi Zhang
> >>
> >>
>
