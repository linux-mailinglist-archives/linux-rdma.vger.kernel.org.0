Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D370050C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjELKQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbjELKQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 06:16:33 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [IPv6:2001:41d0:1004:224b::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF129D
        for <linux-rdma@vger.kernel.org>; Fri, 12 May 2023 03:16:31 -0700 (PDT)
Message-ID: <5eacf66d-053e-d82b-1e73-c808fb4c8aad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683886589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6Wem/v3s40IpU/4vM3KdBYaIHM33/erB6EQnTE0H+w=;
        b=ugB2fatRP3xgDY9Igh9H5noqrVuta25yPnVcmps7CyaQhAsCjfXXLrvJuV1ibevR3kLG8C
        JafTC10bd3NXCvTPhLM30BQ4g/jBTRRt4vEl4FMGuNYyMl90TX9IQfmchQ2Y8nR8Mi4LdO
        M92KqdPIaEUKouhfLXWGuDH5MdF075s=
Date:   Fri, 12 May 2023 18:16:26 +0800
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port
Content-Language: en-US
To:     syzbot <syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com>,
        bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000001f992805fb79ce97@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <0000000000001f992805fb79ce97@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/12/23 15:10, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusio..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=162c0566280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
> dashboard link: https://syzkaller.appspot.com/bug?extid=79f283f1f4ccc6e8b624
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8c18a31ba47/disk-16a88291.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/03a18f29b7e7/vmlinux-16a88291.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1db2407ade1e/bzImage-16a88291.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com
>
> xfrm0 speed is unknown, defaulting to 1000
> ==================================================================
> BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
> Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211
>
> CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> Workqueue: infiniband ib_cache_event_task
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>   print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>   print_report mm/kasan/report.c:462 [inline]
>   kasan_report+0x11c/0x130 mm/kasan/report.c:572
>   siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
>   iw_query_port drivers/infiniband/core/device.c:2049 [inline]
>   ib_query_port drivers/infiniband/core/device.c:2090 [inline]
>   ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
>   ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
>   ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
>   ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
>   process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>   worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>   kthread+0x344/0x440 kernel/kthread.c:379
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>   </TASK>

This might be similar as 390d3fdcae2d,  let me play with syzbot a bit 😉

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git 
for-rc

diff --git a/drivers/infiniband/core/device.c 
b/drivers/infiniband/core/device.c
index a666847bd714..9dd59f8d5f05 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2016,6 +2016,7 @@static int iw_query_port(struct ib_device *device,
{
        struct in_device *inetdev;
        struct net_device *netdev;
+int ret;

        memset(port_attr, 0, sizeof(*port_attr));

@@ -2045,8 +2046,9 @@static int iw_query_port(struct ib_device *device,
                rcu_read_unlock();
        }

+ret = device->ops.query_port(device, port_num, port_attr);
        dev_put(netdev);
-       return device->ops.query_port(device, port_num, port_attr);
+return ret;
}

static int __ib_query_port(struct ib_device *device,
