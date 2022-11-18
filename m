Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7162EE15
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 08:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKRHEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 02:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiKRHD7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 02:03:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E85D6A5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 23:03:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k5so3724010pjo.5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 23:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cVYC9gCu9dZewg6m513pArmm4B3CXBuEVhMXD5KfQ1c=;
        b=byUcXWznJw4u5RwfZ5rY0WtKtU4MAU9/28J27mBMe2QpzBhOR3MV1xnrMRAzLWRAvL
         R6e2N2LmJfTzL5KzccRsxqAHVwTityNOWPrC9leTs0pEFaJrg41M0mnZZ9J5OOPDtyt4
         BYeZHOBfiy9tw6xKydEJNoFmc15Nnu4J3LhVUogOYjbmSeBivQSAL/SGI1ndbCCxaOL3
         phOJO4rZlRpOJ7MvDljVeGNn8cdk2glaZRKJvx2Bxd5B/qDyPdC3+tYAKI3/60VvDo1K
         Wl7Sg+P0lslpo27lXrKgFJ2fZ756aiDIz18aF/JeKG9/Hk0rxVvGO4defGMzY6qCuU7u
         LUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVYC9gCu9dZewg6m513pArmm4B3CXBuEVhMXD5KfQ1c=;
        b=t1T7DvW9S+6golQ/gmi/vjJSGCke/lRPnyp3T/os6RTkRlTeH3HGF87ykndH8D0GUL
         qfAHwGVQbUHigH0UuHhvzWlZ3XOCCMNua4oX9e2LIhm3078mmsJW4xNp69QmuyJlXfjD
         bCunEcdjYg4SCP7NShy36DMMGu5q4BRyA0EtZn7L0LpM6AZVIKj2kj87EEUyYaST9fT6
         QBb5rcedUFm0KsKMv0iPglTxrdbuhMTECVWjBaeB0ipoWsVlzY3SMiVTHIUqy5Zw5fZK
         6UU2odS6HHD9cGCNMlSo0qIcBEXTLIv+44+MalbkDpiC77AjNMEqOnWMKNAR5g3kvDW4
         xqpw==
X-Gm-Message-State: ANoB5pkfpo4eoLeXJjY6Oszh1bGeXg5qkU90HF32dl7C/7YOu3ABhOf4
        Bcve1wXwCKUdE3jzz3dFy75Ct9+l/aVZHTmkIOV9fVSN+qo=
X-Google-Smtp-Source: AA0mqf5X+oHHkdOTc443E2/RMqQw4nB83YGVzhlULldTYIJcv0sAPKie9KjZ4YwNYbgA59UgxjBXfqIQ0tf9tHaIr/M=
X-Received: by 2002:a17:90b:198e:b0:20d:23ee:c041 with SMTP id
 mv14-20020a17090b198e00b0020d23eec041mr6315572pjb.140.1668755036917; Thu, 17
 Nov 2022 23:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
In-Reply-To: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 18 Nov 2022 15:03:45 +0800
Message-ID: <CAD=hENfW9oTdHmnaxtv59q+cJAYA05i40Xsp17DW9pXXjHfpFQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 17, 2022 at 7:29 PM Zhang Xiaoxu <zhangxiaoxu5@huawei.com> wrote:
>
> There is a null-ptr-deref when mount.cifs over rdma:
>
>   BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>   Read of size 8 at addr 0000000000000018 by task mount.cifs/3046
>
>   CPU: 2 PID: 3046 Comm: mount.cifs Not tainted 6.1.0-rc5+ #62
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc3
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x34/0x44
>    kasan_report+0xad/0x130
>    rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>    execute_in_process_context+0x25/0x90
>    __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
>    rxe_create_qp+0x16a/0x180 [rdma_rxe]
>    create_qp.part.0+0x27d/0x340
>    ib_create_qp_kernel+0x73/0x160
>    rdma_create_qp+0x100/0x230
>    _smbd_get_connection+0x752/0x20f0
>    smbd_get_connection+0x21/0x40
>    cifs_get_tcp_session+0x8ef/0xda0
>    mount_get_conns+0x60/0x750
>    cifs_mount+0x103/0xd00
>    cifs_smb3_do_mount+0x1dd/0xcb0
>    smb3_get_tree+0x1d5/0x300
>    vfs_get_tree+0x41/0xf0
>    path_mount+0x9b3/0xdd0
>    __x64_sys_mount+0x190/0x1d0
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> The root cause of the issue is the socket create failed in
> rxe_qp_init_req().
>
> So add a null ptr check about the sk before reset the dst socket.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index a62bab88415c..4bab641fdd42 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -829,7 +829,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>         if (qp->resp.mr)
>                 rxe_put(qp->resp.mr);
>
> -       if (qp_type(qp) == IB_QPT_RC)
> +       if (qp_type(qp) == IB_QPT_RC && qp->sk)
>                 sk_dst_reset(qp->sk->sk);

If qp->sk is not created successfully, it need not be released.

833
834         free_rd_atomic_resources(qp);
835
836         kernel_sock_shutdown(qp->sk, SHUT_RDWR);

               if (qp->sk) {              <---add qp->sk test here
837           sock_release(qp->sk);
              }

Zhu Yanjun

>
>         free_rd_atomic_resources(qp);
> --
> 2.31.1
>
