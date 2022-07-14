Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA98575282
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiGNQNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiGNQNa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 12:13:30 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F61564ED
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:13:29 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10bec750eedso2988222fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=WIW9CfNLLX24TuODHpTc1Rz5Z+DqmwVtq9bbMh43yDs=;
        b=i2t6kOb0K1Y2aWoX+D9ZHH23Z+ZfjFKCxmOCRbOKWAOvGS94O01Gkem8BCVD4lxvwu
         7hk/RF6gPQEUPNkwOkHt+4cflhCG+J6jxy8Eav2N/apyacU53DnnKlN2YD+rDm4Ia4R1
         GQZuCdvR901iokWjFyx29OJ2ba/Towswrd+tzz1Iw8LZfPxWS5rDiRpxibEgAv4HSXMo
         9jGqdStfOR+HA3jcLJMPNpfdMpn04GzXm87t9S80Kb+yI1XKtFQANarp/4ul++ZdcWFC
         +JlCJVjs48kiRCY+Ykx/oZP6Zw0qRhg6YW2ZjB8MbHRu7uZH7o5/cPbjY6Vlf32mBRbF
         Yg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WIW9CfNLLX24TuODHpTc1Rz5Z+DqmwVtq9bbMh43yDs=;
        b=UL3xqtrKwGc6yLIklPwIWGZXtKBbZC2muDXROmCXlzNvVTG2JUId6gOqivcMsLwnyw
         of/nZN1o2KQ2KmkzvnUD3KCcgK4xpQbwlyzISUF489wT7NzASz+qr1MWUVg8mSLyOcvE
         jrQIAAbovAdOJgO90yt5XTCUf1Z4Ek0wBYL5XiVupPC8PGAywb0BqAQqrlT/I0GnmZok
         tixsG1MvlN1wBYQnPwRp0sx1SePeFMrCS7E8bXaIZI2RbRnQJIJ20s4LOSNaBDCpLmFc
         wDwRTHSbPWtztEnyDOjXP0Oow/eWGvXP2RhEMMRGJZGrbYSQ9MZIoPE6iWHmIbgFjN/V
         d73g==
X-Gm-Message-State: AJIora92y9DUkQQbA4MaLfWcSR+00+IXmyQoZ4MYzTWqU79tJv8COjZ9
        ExJvBqbVW8sonVr+pNTqopIduE9ZG9E=
X-Google-Smtp-Source: AGRyM1tJdbYl9vx46hPWIbG4ZEP1X9ndIDbRAr+N14muaDd0phNVtExI3YGAlhJlOtbMk5p3thVTaQ==
X-Received: by 2002:a05:6870:1cb:b0:10b:b089:abb6 with SMTP id n11-20020a05687001cb00b0010bb089abb6mr7466604oad.140.1657815208478;
        Thu, 14 Jul 2022 09:13:28 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id l2-20020a9d6a82000000b006168ededf96sm833385otq.2.2022.07.14.09.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:13:27 -0700 (PDT)
Message-ID: <c82760f8-8774-a90e-7636-1c8954c007f3@gmail.com>
Date:   Thu, 14 Jul 2022 11:13:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220706092811.1756290-1-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220706092811.1756290-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/6/22 04:21, lizhijian@fujitsu.com wrote:
> It's possible mr_pd(mr) returns NULL if rxe_mr_alloc() fails.
> 
> it fixes below panic:
> [  114.163945] RPC: Registered rdma backchannel transport module.
> [  116.868003] eth0 speed is unknown, defaulting to 1000
> [  120.173114] rdma_rxe: rxe_mr_init_user: Unable to allocate memory for map
> [  120.173159] ==================================================================
> [  120.173161] BUG: KASAN: null-ptr-deref in __rxe_put+0x18/0x60 [rdma_rxe]
> [  120.173194] Write of size 4 at addr 0000000000000080 by task rdma_flush_serv/685
> [  120.173197]
> [  120.173199] CPU: 0 PID: 685 Comm: rdma_flush_serv Not tainted 5.19.0-rc1-roce-flush+ #90
> [  120.173203] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
> [  120.173208] Call Trace:
> [  120.173216]  <TASK>
> [  120.173217]  dump_stack_lvl+0x34/0x44
> [  120.173250]  kasan_report+0xab/0x120
> [  120.173261]  ? __rxe_put+0x18/0x60 [rdma_rxe]
> [  120.173277]  kasan_check_range+0xf9/0x1e0
> [  120.173282]  __rxe_put+0x18/0x60 [rdma_rxe]
> [  120.173311]  rxe_mr_cleanup+0x21/0x140 [rdma_rxe]
> [  120.173328]  __rxe_cleanup+0xff/0x1d0 [rdma_rxe]
> [  120.173344]  rxe_reg_user_mr+0xa7/0xc0 [rdma_rxe]
> [  120.173360]  ib_uverbs_reg_mr+0x265/0x460 [ib_uverbs]
> [  120.173387]  ? ib_uverbs_modify_qp+0x8b/0xd0 [ib_uverbs]
> [  120.173433]  ? ib_uverbs_create_cq+0x100/0x100 [ib_uverbs]
> [  120.173461]  ? uverbs_fill_udata+0x1d8/0x330 [ib_uverbs]
> [  120.173488]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x19d/0x250 [ib_uverbs]
> [  120.173517]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x190/0x190 [ib_uverbs]
> [  120.173547]  ? radix_tree_next_chunk+0x31e/0x410
> [  120.173559]  ? uverbs_fill_udata+0x255/0x330 [ib_uverbs]
> [  120.173587]  ib_uverbs_cmd_verbs+0x11c2/0x1450 [ib_uverbs]
> [  120.173616]  ? ucma_put_ctx+0x16/0x50 [rdma_ucm]
> [  120.173623]  ? __rcu_read_unlock+0x43/0x60
> [  120.173633]  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x190/0x190 [ib_uverbs]
> [  120.173661]  ? uverbs_fill_udata+0x330/0x330 [ib_uverbs]
> [  120.173711]  ? avc_ss_reset+0xb0/0xb0
> [  120.173722]  ? vfs_fileattr_set+0x450/0x450
> [  120.173742]  ? should_fail+0x78/0x2b0
> [  120.173745]  ? __fsnotify_parent+0x38a/0x4e0
> [  120.173764]  ? ioctl_has_perm.constprop.0.isra.0+0x198/0x210
> [  120.173784]  ? should_fail+0x78/0x2b0
> [  120.173787]  ? selinux_bprm_creds_for_exec+0x550/0x550
> [  120.173792]  ib_uverbs_ioctl+0x114/0x1b0 [ib_uverbs]
> [  120.173820]  ? ib_uverbs_cmd_verbs+0x1450/0x1450 [ib_uverbs]
> [  120.173861]  __x64_sys_ioctl+0xb4/0xf0
> [  120.173867]  do_syscall_64+0x3b/0x90
> [  120.173877]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  120.173884] RIP: 0033:0x7f4b563c14eb
> [  120.173889] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 b9 0c 00 f7 d8 64 89 01 48
> [  120.173892] RSP: 002b:00007ffe0e4a6fe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 9a5c2af6a56f..cec5775a72f2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -695,8 +695,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  void rxe_mr_cleanup(struct rxe_pool_elem *elem)
>  {
>  	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
> +	struct rxe_pd *pd = mr_pd(mr);
>  
> -	rxe_put(mr_pd(mr));
> +	if (pd)
> +		rxe_put(pd);
>  
>  	ib_umem_release(mr->umem);
>  

Li,

You seem to be fixing the problem in the wrong place. All MRs should have an associated PD.
The PD is passed in as a struct ib_pd to one of the MR registration APIs from rdma-core.
The PD is allocated in rdma-core and it should check that it has a valid PD before it calls
the rxe driver. I am not sure how you triggered the above behavior.

The address of the PD is saved in the MR struct when the MR is registered and just should never
be NULL. Assuming there is a way to register an MR without a PD (I have never seen this) we should
check it in the registration routine not the cleanup routine and fail the call there.

[Jason, Is there such a thing as an MR without a valid PD?]

Bob
