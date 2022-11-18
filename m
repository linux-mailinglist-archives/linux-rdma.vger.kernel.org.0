Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B162EE49
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 08:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKRH1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 02:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRH1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 02:27:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF413D0C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 23:27:48 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ND7Zr0xJtzJnlr;
        Fri, 18 Nov 2022 15:24:36 +0800 (CST)
Received: from [10.174.176.83] (10.174.176.83) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:27:46 +0800
Message-ID: <66408f90-e07e-0202-82f0-024ddb67cd69@huawei.com>
Date:   Fri, 18 Nov 2022 15:27:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@ziepe.ca>, <leon@kernel.org>
References: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
 <CAD=hENfW9oTdHmnaxtv59q+cJAYA05i40Xsp17DW9pXXjHfpFQ@mail.gmail.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
In-Reply-To: <CAD=hENfW9oTdHmnaxtv59q+cJAYA05i40Xsp17DW9pXXjHfpFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Yanjun.

I notice your commit 548ce2e66725 ("RDMA/rxe: Fix the error caused by qp->sk")
already add the test here and merge into linux repo.

@@ -835,8 +835,10 @@ static void rxe_qp_do_cleanup(struct work_struct *work)

         free_rd_atomic_resources(qp);

-       kernel_sock_shutdown(qp->sk, SHUT_RDWR);
-       sock_release(qp->sk);
+       if (qp->sk) {
+               kernel_sock_shutdown(qp->sk, SHUT_RDWR);
+               sock_release(qp->sk);
+       }
  }


On 2022/11/18 15:03, Zhu Yanjun wrote:
> On Thu, Nov 17, 2022 at 7:29 PM Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
>>
>> There is a null-ptr-deref when mount.cifs over rdma:
>>
>>    BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>>    Read of size 8 at addr 0000000000000018 by task mount.cifs/3046
>>
>>    CPU: 2 PID: 3046 Comm: mount.cifs Not tainted 6.1.0-rc5+ #62
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc3
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x34/0x44
>>     kasan_report+0xad/0x130
>>     rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>>     execute_in_process_context+0x25/0x90
>>     __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
>>     rxe_create_qp+0x16a/0x180 [rdma_rxe]
>>     create_qp.part.0+0x27d/0x340
>>     ib_create_qp_kernel+0x73/0x160
>>     rdma_create_qp+0x100/0x230
>>     _smbd_get_connection+0x752/0x20f0
>>     smbd_get_connection+0x21/0x40
>>     cifs_get_tcp_session+0x8ef/0xda0
>>     mount_get_conns+0x60/0x750
>>     cifs_mount+0x103/0xd00
>>     cifs_smb3_do_mount+0x1dd/0xcb0
>>     smb3_get_tree+0x1d5/0x300
>>     vfs_get_tree+0x41/0xf0
>>     path_mount+0x9b3/0xdd0
>>     __x64_sys_mount+0x190/0x1d0
>>     do_syscall_64+0x35/0x80
>>     entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>
>> The root cause of the issue is the socket create failed in
>> rxe_qp_init_req().
>>
>> So add a null ptr check about the sk before reset the dst socket.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index a62bab88415c..4bab641fdd42 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -829,7 +829,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>>          if (qp->resp.mr)
>>                  rxe_put(qp->resp.mr);
>>
>> -       if (qp_type(qp) == IB_QPT_RC)
>> +       if (qp_type(qp) == IB_QPT_RC && qp->sk)
>>                  sk_dst_reset(qp->sk->sk);
> 
> If qp->sk is not created successfully, it need not be released.
> 
> 833
> 834         free_rd_atomic_resources(qp);
> 835
> 836         kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> 
>                 if (qp->sk) {              <---add qp->sk test here
> 837           sock_release(qp->sk);
>                }
> 
> Zhu Yanjun
> 
>>
>>          free_rd_atomic_resources(qp);
>> --
>> 2.31.1
>>
