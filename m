Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C261A390477
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhEYPDR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhEYPDP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 11:03:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A73C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 08:01:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso13664450wmh.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=espu6hbJNQlJc2vEJrTbS+1+0xJX7+izxDqne7PHbeQ=;
        b=ZESaQuGpLuo00FjomObydUa4ZSTC29IRgTtQ+tq9eVS/ggXLwKC6Rz6onBvMvIZd/r
         IvlQNuLZ4XXyCkYYiinRf9P6SL947mQoIOC3HzKu8YODz3qZjA5ni4ViAQNO8fyqOpsk
         Z8E1G7FyEgKaVn7aq6zUYUtgPJVO4W65sPkRJbvzSp8DgfkpHXArTcrn3yQ98yWWgdLs
         2qVGCe7OKnlCFAVl2aB/ezc0lKI6TJg0UQblU+I03AgeDx30ylBfRfFg5cJnxArA1EYU
         Fiy8llZSPHc5mI4heCdX+CxCX5VUnng5TrbaVxUtR0kJPZA80bzfaa33LXP7teJ/px7q
         u0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=espu6hbJNQlJc2vEJrTbS+1+0xJX7+izxDqne7PHbeQ=;
        b=mal6MTzf60ehosrUHJgX7xVX7oA2/CrJfft8hxCoSc+yw5rbOIy/OJxc9PcSpeBPo9
         e/ZtDwTXFQcNhMWe25IPy0YzzHHj7mpEmaL3WpebmnaDIOw86vF+9sBz/JEkOhTTBGi+
         qO5/YaWG+4g/Je5SsU0nQ/WBJGlYLZ0aKi7PWnZ5bZ23/IwWIHihL+bsrf8NbRjw2W9b
         P4G8l/J1oXH/dLuM7mxlUVW0ISL1aQJTdXCRKwA7On4RLtM0utzt0OSgElfAxyUCz2ui
         JaHGlGOQ7JWfwIdUYi3ARY7ly2fSf9DGgE+trNK5un1lI86XbbXGAX/yZx+qo/Y4wluB
         wq5w==
X-Gm-Message-State: AOAM53140+J38wbauE/9yOnIZqpFh+jhAtDIszXduhNN/K0kE0/8CgyC
        wG6IIA2oCXKftdzgFQ9tLUga4sDbECk=
X-Google-Smtp-Source: ABdhPJyjkF7XdNujL/jimAWHkvXZ5GFmaOMYnLgz1KjawJ4QC+am53TXqZ9LYTVc6eMHLvyxQ/YpgQ==
X-Received: by 2002:a1c:b306:: with SMTP id c6mr4260719wmf.37.1621954902710;
        Tue, 25 May 2021 08:01:42 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f::1007])
        by smtp.gmail.com with ESMTPSA id h13sm11760599wml.26.2021.05.25.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:01:42 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/ipoib: Fix warning caused by destroying non-initial netns
Date:   Tue, 25 May 2021 18:01:34 +0300
Message-Id: <20210525150134.139342-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After the introduce of 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for
ipoib interfaces"), If the IPoIB device is moved to non-initial netns,
destroying that netns lets the device vanish instead of moving it back
to the initial netns, This is happening because default_device_exit()
skips the interfaces due to having rtnl_link_ops set.

Steps to reporoduce:
  ip netns add foo
  ip link set mlx5_ib0 netns foo
  ip netns delete foo

------------[ cut here ]------------
WARNING: CPU: 1 PID: 704 at net/core/dev.c:11435 netdev_exit+0x3f/0x50
Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun d
 fuse
CPU: 1 PID: 704 Comm: kworker/u64:3 Tainted: G S      W  5.13.0-rc1+ #1
Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
Workqueue: netns cleanup_net
RIP: 0010:netdev_exit+0x3f/0x50
Code: 48 8b bb 30 01 00 00 e8 ef 81 b1 ff 48 81 fb c0 3a 54 a1 74 13 48
8b 83 90 00 00 00 48 81 c3 90 00 00 00 48 39 d8 75 02 5b c3 <0f> 0b 5b
c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00
RSP: 0018:ffffb297079d7e08 EFLAGS: 00010206
RAX: ffff8eb542c00040 RBX: ffff8eb541333150 RCX: 000000008010000d
RDX: 000000008010000e RSI: 000000008010000d RDI: ffff8eb440042c00
RBP: ffffb297079d7e48 R08: 0000000000000001 R09: ffffffff9fdeac00
R10: ffff8eb5003be000 R11: 0000000000000001 R12: ffffffffa1545620
R13: ffffffffa1545628 R14: 0000000000000000 R15: ffffffffa1543b20
FS:  0000000000000000(0000) GS:ffff8ed37fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005601b5f4c2e8 CR3: 0000001fc8c10002 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ops_exit_list.isra.9+0x36/0x70
 cleanup_net+0x234/0x390
 process_one_work+0x1cb/0x360
 ? process_one_work+0x360/0x360
 worker_thread+0x30/0x370
 ? process_one_work+0x360/0x360
 kthread+0x116/0x130
 ? kthread_park+0x80/0x80
 ret_from_fork+0x22/0x30
---[ end trace 74b40f8fbd65a323 ]---

To avoid the above warning and later on the kernel panic that could
happen on shutdown due to a null pointer dereference, Make sure to set
the netns_refund flag that was introduced by [1] to properly restore
the IPoIB interfaces to the initial netns.

[1] - 3a5ca857079e ("can: dev: Move device back to init netns on owning
netns delete").

Fixes: 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index d5a90a66b45c..5b05cf3837da 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -163,6 +163,7 @@ static size_t ipoib_get_size(const struct net_device *dev)
 
 static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
 	.kind		= "ipoib",
+	.netns_refund   = true,
 	.maxtype	= IFLA_IPOIB_MAX,
 	.policy		= ipoib_policy,
 	.priv_size	= sizeof(struct ipoib_dev_priv),
-- 
2.26.3

