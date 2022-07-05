Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1035661F1
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 05:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGEDno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 23:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGEDno (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 23:43:44 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A43EA2BE5
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 20:43:42 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AnYPE/Ko7qgmquNomsbY+Oz3mjhxeBmL7ZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmQWDGuBaPyMNmv2e953PNvi9UJTu5aAyNVkTFZqqClmQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlsZ2iS?=
 =?us-ascii?q?QYrP6TKsOoAURhECDw4NqpDkFPCCSHl7pbNlB2XLhMAxN0rVinaJ7Yw4P56CHt?=
 =?us-ascii?q?V8voYMD0lYRWKhubwy7W+IsF+l8YxPcuxZNtHkn5lxDDdS/0hRPjrR6jN4/db0?=
 =?us-ascii?q?S02i8QIGuzRD+IdaDxyfFHabxhGEkkYBYh4n+qygHT7NTpCpzq9p6U4y3rSwRR?=
 =?us-ascii?q?8lrPkWOc50PTiqd59xx7e/zyZuT+iRExyCTBW8hLdmlrEuwMFtXqTtFouKYCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+FRq/K4P9i7hdFDExQPXwFLXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiXqrbHXoB19726MtN9xYgBHpTnuAtjjfZqxz/5ICMwqTNCftWrdyQ?=
 =?us-ascii?q?+VxeNZnOjfKlTbckWUnINgPOVbEpSWY+edMbEVt6nHCUWDYrMdKce8gdyVrNab?=
 =?us-ascii?q?33FwVhtrdq0lyw94DzyQGkpwSBIuP+tCKLOsotpAuyG7eWkaKuCyBnw+VeDFoN?=
 =?us-ascii?q?HR0L38ZxpuPW9b1CC+ySOv9KXhEwWVmjMXUzZ0y78k9mTf1yzVj5/TyM2G9g?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127263895"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jul 2022 11:43:41 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 405B04D16FFC;
        Tue,  5 Jul 2022 11:43:39 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 5 Jul 2022 11:43:40 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 5 Jul 2022 11:43:39 +0800
Subject: Re: [PATCH] RDMA/rxe: Process received packets in time
To:     Xiao Yang <yangx.jy@fujitsu.com>, <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>
References: <20220703155625.14497-1-yangx.jy@fujitsu.com>
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <8a034c85-3594-f965-6604-87361645016a@fujitsu.com>
Date:   Tue, 5 Jul 2022 11:43:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20220703155625.14497-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-yoursite-MailScanner-ID: 405B04D16FFC.AF7F6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

on 7/3/2022 11:56 PM, Xiao Yang wrote:
> If received packets (i.e. skb) stored in qp->resp_pkts
> cannot be processed in time, they may be ovewritten/reused
> and then lead to abnormal behavior.
>
> For example, running test_qp_ex_rc_atomic_cmp_swp always
> reproduced a panic on my slow vm:
> --------------------------------------------------------
> [39867.797693] rdma_rxe: qp#17 state = GET ACK
> [39867.800667] rdma_rxe: qp#17 state = GET WQE
> [39867.800722] rdma_rxe: qp#17 state = CHECK PSN
> [39867.800739] rdma_rxe: qp#17 state = CHECK ACK
> [39867.800776] rdma_rxe: unexpected opcode
> [39867.800790] rdma_rxe: qp#17 state = ERROR
> ...
> [39867.822361] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [39867.822361] #PF: supervisor read access in kernel mode
> [39867.822361] #PF: error_code(0x0000) - not-present page
> [39867.822361] PGD 0 P4D 0
> [39867.822361] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [39867.822361] CPU: 3 PID: 19605 Comm: python3 Kdump: loaded Tainted: G        W         5.19.0-rc2+ #33
> [39867.822361] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
> [39867.822361] RIP: 0010:rxe_completer+0x41f/0xd10 [rdma_rxe]
> [39867.822361] Code: 41 83 ff 0d 0f 84 a7 02 00 00 41 83 ff 0e 0f 85 da 00 00 00 48 85 db 0f 84 74 fe ff ff 48 8b 6b 08 48 8d 7b d8 be 01 00 00 00 <4c> 8b 75 00 e8 68 65 56 dd 48 8d bd a0 01 00 00 e8 8c 47 00 00 4c
> [39867.822361] RSP: 0000:ffff9eab813c7e18 EFLAGS: 00000286
> [39867.822361] RAX: 0000000000022b5a RBX: ffff8adb07efeb28 RCX: 0000000000000006
> [39867.822361] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8adb07efeb00
> [39867.822361] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> [39867.822361] R10: 0000000000000000 R11: 0000000000011fac R12: ffff8adb06ae11a0
> [39867.822361] R13: 00000000fffffff5 R14: ffff9eab81803e80 R15: 000000000000000c
> [39867.822361] FS:  00007f87f99eb6c0(0000) GS:ffff8adb3dd00000(0000) knlGS:0000000000000000
> [39867.822361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [39867.822361] CR2: 0000000000000000 CR3: 0000000106c3e000 CR4: 00000000000006e0
> [39867.822361] Call Trace:
> [39867.822361]  <TASK>
> [39867.822361]  ? __local_bh_enable_ip+0x83/0xf0
> [39867.822361]  rxe_do_task+0x67/0xc0 [rdma_rxe]
> [39867.822361]  tasklet_action_common.isra.0+0xe2/0x110
> [39867.822361]  __do_softirq+0xf0/0x4b5
> [39867.822361]  irq_exit_rcu+0xef/0x130
> [39867.822361]  sysvec_apic_timer_interrupt+0x40/0xc0
> [39867.822361]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [39867.822361] RIP: 0033:0x7f87f96fcce5
> ...
> --------------------------------------------------------
>
> The root cause is that a received skb stored in qp->resp_pkts
> has been ovewritten by another QP. Like the following logic:
> --------------------------------------------------------
>                      /* Trigger timeout */
> Requester(QP#17) -> retransmit_timer()
>                      -> rxe_completer()
>                            /* No skb (Atomic ACK) is added
>                             * to qp->resp_pkts */
>                            qp->req.need_retry = 1;
>                            rxe_run_task(&qp->req.task, 0);
>
>                      /* First skb (Atomic ACK) arrived &&
>                       * rxe_requester() is not called yet */
> Requester(QP#17) -> rxe_rcv()
>                         /* Add the skb (Atomic ACK) into qp->resp_pkts */
>                      -> rxe_comp_queue_pkt()
>                         -> rxe_completer()
>                               /* qp->req.need_retry == 1 */
>                               if (qp->req.need_retry) {
> 		                ret = -EAGAIN;
>                                  goto done;
> 		             }
>
> Responder(QP#18) -> rxe_rcv()
>                         /* The skb (Atomic ACK) has been reused
>                          * to store the Atomic Comapre_Swap request */

Well, i didn't see how/when another QP can reuse/overwrite this skb.
If this is true, i think we should fix it as well.

Thanks


>                      -> rxe_responder()
>
>                      /* rxe_requester() is called */
> Requester(QP#17) -> rxe_requester()
>                         if (unlikely(qp->req.need_retry)) {
> 		          req_retry(qp);
> 		          qp->req.need_retry = 0;
>                         }
>
> 	            /* Trigger timeout again */
> Requester(QP#17) -> retransmit_timer()
>                      -> rxe_completer()
>                            /* qp->req.need_retry == 0 */
>                            if (qp->req.need_retry) {
> 		             ret = -EAGAIN;
>                               goto done;
> 		          }
>                            /* check_ack() throws "unexpected opcode" */
>                         -> check_ack()
>                            return COMPST_ERROR;
> --------------------------------------------------------
>
> If qp->req.need_retry is set and qp->resp_pkts is not empty,
> Process received packets in time to fix the issue.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index da3a398053b8..8ffc874a25af 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -580,7 +580,7 @@ int rxe_completer(void *arg)
>   		qp->comp.timeout_retry = 0;
>   	}
>   
> -	if (qp->req.need_retry) {
> +	if (qp->req.need_retry && !skb_queue_len(&qp->resp_pkts)) {
>   		ret = -EAGAIN;
>   		goto done;
>   	}


