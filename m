Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A56126F6
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Oct 2022 03:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJ3Cxh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3Cxg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 22:53:36 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4648EB4;
        Sat, 29 Oct 2022 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667098413; i=@fujitsu.com;
        bh=PdGMq5jhTndn3C8TSzAZMy4sSkX9K8IOAvOSbW37nxk=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=uN45gEmmIs+7taQEsOMyCYwJdBvlDBjCW7WtXaLTEeJjNzsV2Xm6XcxF8X5EO6Vec
         n4WD22tycJdBNM5fvC57VmfYoCoQoENkUxqZNUXRw5IHZC9v5GvmMwWhgbm++g43/c
         TRbGdp5pDNnDPE/vlvw7bWMsXgOUWFf/u4rwZZ/+Tl1qs+7fHiLx72/jUoSS0T3qC+
         HpaSgiufIGVlrgezzcWYeMkBNkMSsRuFdVdMnYDFoRbipsQLkucuWS0QFB/mrR5M2w
         hrJwcFl2IJqBSpqgxQeOFP0sjxNCxV4E8MC0JtrbMjJC5FSxrNUDS3GQ9JE5rv26ot
         9rfSYTpKJLOYg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsViZ8OxWVf7eWy
  yweWlchYzZ5xgtJjyaymzxeVdc9gsnh3qZbH4MnUas8X5Y/3sDmweO2fdZffYtKqTzePzJjmP
  rZ9vswSwRLFm5iXlVySwZjRcvcBe0CZT8frIAqYGxiaJLkYuDiGBjYwS849eYIdwFjNJPHown
  Q3C2QaUOdTI2MXIycErYCdxaOFpZhCbRUBVYmbbYlaIuKDEyZlPWEBsUYEIiYePJoHZwgL2Eu
  /aJ7KB2MwC4hK3nsxnArFFBGIk/h37xQgRd5fom7IPaA4H0DJHiab7+iBhNgENiXstN8FKOAW
  cJCYd38AEUW4hsfjNQXYIW15i+9s5YOdICChKHOn8ywJhV0jMmtXGBGGrSVw9t4l5AqPwLCSX
  zkJy0SwkY2chGbuAkWUVo1lxalFZapGuqV5SUWZ6RkluYmaOXmKVbqJeaqluXn5RSYauoV5ie
  bFeanGxXnFlbnJOil5easkmRmCspRQnOO1gnLLsj94hRkkOJiVR3szO2GQhvqT8lMqMxOKM+K
  LSnNTiQ4wyHBxKErxNj4BygkWp6akVaZk5wLiHSUtw8CiJ8EYfA0rzFhck5hZnpkOkTjEqSon
  zOj4ESgiAJDJK8+DaYKnmEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVhXpHHQFN4MvNK4Ka/
  AlrMBLQ4fVIUyOKSRISUVAPT2eIfyYsm2FrXh5Spd/tJqEnty+W5sWLK4fKnOj0TkpfH/2K4f
  jZlwgqXr4deKRkcT9p6+ouYtWNPQWLTxzvNb6ZG9/3TPZWV719+6uKtGYd1y/WZd7jJZ9W3pj
  JnHUw4d2CbsuPXymPev0teHDu+JvfLwmruly+m+Wybp9FU4nC49v3LV9P8vty5F67XHGSx6Z1
  8lGUCa4qReNYjtjk7c/edmcJe41Rx/Juz3sKUqdtmnpx56NXH3jqGkDcbAsviqp+l3XtwvvRi
  stdPn6DU5fWPP/xzVrnK2cS29/He6YmsLC+Xti/OuJoUwrbAZNmF+UwhS55c0M1bpHMhtihOK
  feEYnD+vic7ayXfhSiUKLEUZyQaajEXFScCAByihl+wAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-5.tower-732.messagelabs.com!1667098411!33197!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23476 invoked from network); 30 Oct 2022 02:53:31 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-5.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 02:53:31 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id E63CC142;
        Sun, 30 Oct 2022 02:53:30 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id D947E73;
        Sun, 30 Oct 2022 02:53:30 +0000 (GMT)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 02:53:27 +0000
Message-ID: <a0ab3805-3602-6037-b9b6-ddab88c424be@fujitsu.com>
Date:   Sun, 30 Oct 2022 10:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix mr->map double free
Content-Language: en-US
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>, <linux-kernel@vger.kernel.org>
References: <1667097525-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <1667097525-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please ignore this one, which failed to compile because it was based on a wrong branch

i will repost a new one later.



On 30/10/2022 10:38, Li Zhijian wrote:
> rxe_mr_cleanup() which tries to free mr->map again will be called
> when rxe_mr_init_user() fails.
>
> [43895.939883] CPU: 0 PID: 4917 Comm: rdma_flush_serv Kdump: loaded Not tainted 6.1.0-rc1-roce-flush+ #25
> [43895.942341] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [43895.945208] Call Trace:
> [43895.946130]  <TASK>
> [43895.946931]  dump_stack_lvl+0x45/0x5d
> [43895.948049]  panic+0x19e/0x349
> [43895.949010]  ? panic_print_sys_info.part.0+0x77/0x77
> [43895.950356]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [43895.952589]  ? preempt_count_sub+0x14/0xc0
> [43895.953809]  end_report.part.0+0x54/0x7c
> [43895.954993]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.956406]  kasan_report.cold+0xa/0xf
> [43895.957668]  ? rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.959090]  rxe_mr_cleanup+0x9d/0xf0 [rdma_rxe]
> [43895.960502]  __rxe_cleanup+0x10a/0x1e0 [rdma_rxe]
> [43895.961983]  rxe_reg_user_mr+0xb7/0xd0 [rdma_rxe]
> [43895.963456]  ib_uverbs_reg_mr+0x26a/0x480 [ib_uverbs]
> [43895.964921]  ? __lock_acquire+0x876/0x31e0
> [43895.966182]  ? ib_uverbs_ex_create_wq+0x630/0x630 [ib_uverbs]
> [43895.967739]  ? uverbs_fill_udata+0x1c6/0x330 [ib_uverbs]
> [43895.969204]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x1a2/0x250 [ib_uverbs]
> [43895.971126]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.973094]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.975096]  ? uverbs_fill_udata+0x25f/0x330 [ib_uverbs]
> [43895.976466]  ib_uverbs_cmd_verbs+0x1397/0x15a0 [ib_uverbs]
> [43895.977930]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x1a0/0x1a0 [ib_uverbs]
> [43895.979937]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]
>
> This issue was fistrly exposed since
> commit: b18c7da63fcb ("RDMA/rxe: Fix memory leak in error path code")
> and then we fixed it in
> commit: 8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
> but this fix was reverted together at last by
> commit: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")
>
> Fixes: 1e75550648da (Revert "RDMA/rxe: Create duplicate mapping tables for FMRs")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index d4f10c2d1aa7..baa9d3be178a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -99,6 +99,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>   		kfree(mr->map[i]);
>   
>   	kfree(mr->map);
> +	mr->map = NULL;
>   err1:
>   	return -ENOMEM;
>   }
> @@ -163,9 +164,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   				pr_warn("%s: Unable to get virtual address\n",
>   						__func__);
>   				err = -ENOMEM;
> -				goto err_cleanup_map;
> +				goto err_release_umem;
>   			}
> -
>   			buf->addr = (uintptr_t)vaddr;
>   			buf->size = PAGE_SIZE;
>   			num_buf++;
> @@ -182,10 +182,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>   
>   	return 0;
>   
> -err_cleanup_map:
> -	for (i = 0; i < mr->num_map; i++)
> -		kfree(mr->map[i]);
> -	kfree(mr->map);
>   err_release_umem:
>   	ib_umem_release(umem);
>   err_out:

