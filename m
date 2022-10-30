Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB200612700
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Oct 2022 04:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ3DGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 23:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3DGU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 23:06:20 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C9357CF;
        Sat, 29 Oct 2022 20:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667099174; i=@fujitsu.com;
        bh=xsxOGa6FPEXmqQbTfz81awAL9OxEXHq+jA5A5B9ruqY=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=WFqAqF7l2YHZHM9uu5MKBwTrluUlXAdgQGMaISc50/0jIjbwOYDSmIRSKo02+GuAF
         CpwIIpjJ4kWP2J1TgLhhX4fFbhi4Byv73yDhF/bkbLF39GskiuoL4VIRJ983GvF7QR
         8et1nO5XRc/E9OEBS47UBVO7jLkjCQli/ZetRX01IOVVQdOq95iI1NYqCdvpjBnxSU
         rfiifn10hqdZz4Ni2DZyyHxmXrVv9OZ5utOXgepgMl60vbtlKBu0xh3TbmaNGrKA+z
         JkRvmWaOnNRVzNK2be49snnduGNuAnsLp7WIUzcLUbaVTzVbNQjXEQdiW1EyJieUsB
         hcN1lyIbEnEjw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRWlGSWpSXmKPExsViZ8MxSVflVWy
  yQddWS4uZM04wWkz5tZTZ4vKuOWwWzw71slh8mTqN2eL8sX52BzaPnbPusntsWtXJ5vF5k5zH
  1s+3WQJYolgz85LyKxJYM2bOnM5csFa6YuHK/UwNjN/Euxi5OIQEtjBKTD+9kwnCWc4kMWniL
  GYI5wCjxOb1N4EynBxsAhoS91puMoLYIgIxEv+O/QKzmQXyJPY8bmMBsYUF7CTu7T4GZrMIqE
  pcmL8brIZXwFFiWsslMFtCQEFiysP3zBBxQYmTM5+wQMyRkDj44gVQnAOoRkliZnc8RHmFxKx
  ZbUwQtprE1XObmCcw8s9C0j0LSfcCRqZVjGbFqUVlqUW6hiZ6SUWZ6RkluYmZOXqJVbqJeqml
  uuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIGhnVKs0r6D8dOyP3qHGCU5mJREeTM7Y5OF+
  JLyUyozEosz4otKc1KLDzHKcHAoSfA2PQLKCRalpqdWpGXmAOMMJi3BwaMkwpv2AijNW1yQmF
  ucmQ6ROsVoyTF19r/9zBzLweTMr20HmIVY8vLzUqXEeR0fAjUIgDRklObBjYOlgkuMslLCvIw
  MDAxCPAWpRbmZJajyrxjFORiVhHmrQNbyZOaVwG19BXQQE9BB6ZOiQA4qSURISTUwzfw448k1
  /it1c3T3zmGc9XRe28GTvILvj+5YWPpCzIHl8jrBABXewP9L9jTO3Nc275Z309dfv+zqmjZyf
  JohKbJ3hvuzqZm8naezbHtM4yoECw8X79xuNufk1JX5C1WZvLzN+u/X/ecPCM2xWbd9460Y4Q
  vRIftlTbU9nytMWxhfyVHrm7PcIOzu9kzvwyGfSzeU5ubPjnD2qEhfzX3u8gS7kGmLFgqzbhf
  8GjNHs9C75tPlws9Rlus7tdkOZle/nl7T36GtG3OspWvHI+76r1O43b5m5YkrWv9Zf3zLnx8b
  nX7pv3oxrWvmTubjC8uCL3Zcv1TwTrMr/YrP8SyVa7IWPB/CFnDpLrf4/SEnUomlOCPRUIu5q
  DgRAP8kmyeAAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-2.tower-565.messagelabs.com!1667099172!327533!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8022 invoked from network); 30 Oct 2022 03:06:12 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-2.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 03:06:12 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9CBEA1000F5;
        Sun, 30 Oct 2022 03:06:12 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 903551000E9;
        Sun, 30 Oct 2022 03:06:12 +0000 (GMT)
Received: from 899b73eed648.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 03:06:09 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "Li Zhijian" <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Date:   Sun, 30 Oct 2022 03:04:33 +0000
Message-ID: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mr_cleanup() which tries to free mr->map again will be called
when rxe_mr_init_user() fails.

[43895.939883] CPU: 0 PID: 4917 Comm: rdma_flush_serv Kdump: loaded Not tainted 6.1.0-rc1-roce-flush+ #25
[43895.942341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[43895.945208] Call Trace:
[43895.946130]  <TASK>
[43895.946931]  dump_stack_lvl+0x45/0x5d
[43895.948049]  panic+0x19e/0x349
[43895.949010]  ? panic_print_sys_info.part.0+0x77/0x77
[43895.950356]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[43895.952589]  ? preempt_count_sub+0x14/0xc0
[43895.953809]  end_report.part.0+0x54/0x7c
[43895.954993]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
[43895.956406]  kasan_report.cold+0xa/0xf
[43895.957668]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
[43895.959090]  rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
[43895.960502]  __rxe_cleanup+0x10a/0x1e0 [rdma_rxe]
[43895.961983]  rxe_reg_user_mr+0xb7/0xd0 [rdma_rxe]
[43895.963456]  ib_uverbs_reg_mr+0x26a/0x480 [ib_uverbs]
[43895.964921]  ? __lock_acquire+0x876/0x31e0
[43895.966182]  ? ib_uverbs_ex_create_wq+0x630/0x630 [ib_uverbs]
[43895.967739]  ? uverbs_fill_udata+0x1c6/0x330 [ib_uverbs]
[43895.969204]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x1a2/0x250 [ib_uverbs]
[43895.971126]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
[43895.973094]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
[43895.975096]  ? uverbs_fill_udata+0x25f/0x330 [ib_uverbs]
[43895.976466]  ib_uverbs_cmd_verbs+0x1397/0x15a0 [ib_uverbs]
[43895.977930]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
[43895.979937]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]

This issue was fistrly exposed since
commit: b18c7da63fcb ("RDMA/rxe: Fix memory leak in error path code")
and then we fixed it in
commit: 8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
but this fix was reverted together at last by
commit: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")

Fixes: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d4f10c2d1aa7..7c99d1591580 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -99,6 +99,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 		kfree(mr->map[i]);
 
 	kfree(mr->map);
+	mr->map = NULL;
 err1:
 	return -ENOMEM;
 }
@@ -122,7 +123,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	int			num_buf;
 	void			*vaddr;
 	int err;
-	int i;
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
@@ -163,9 +163,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				pr_warn("%s: Unable to get virtual address\n",
 						__func__);
 				err = -ENOMEM;
-				goto err_cleanup_map;
+				goto err_release_umem;
 			}
-
 			buf->addr = (uintptr_t)vaddr;
 			buf->size = PAGE_SIZE;
 			num_buf++;
@@ -182,10 +181,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	return 0;
 
-err_cleanup_map:
-	for (i = 0; i < mr->num_map; i++)
-		kfree(mr->map[i]);
-	kfree(mr->map);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
-- 
1.8.3.1

