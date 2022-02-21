Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC34BE6D6
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Feb 2022 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358056AbiBUMiS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Feb 2022 07:38:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348921AbiBUMiN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Feb 2022 07:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51F08F10
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 04:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645447069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XV77O2+22zDtjFuEpVNaAxOO3yTDMtaxVMxo4p+73Ys=;
        b=e46gEOUNjR+UvvsO6xsMCJj7IdeFpEBFv5AzoAW+SnFWYRcR6niHv5zPYiG3KBN5HcbIic
        uTAZ3ryfwRagmo9Sg8sCzLW/26wRUC9XiPaVunShBs4ny5MT5IMH5eNYvbEzQlxQKmYQuj
        TNnxJcThH7AprWrHqPF7TnQKZR5dDP0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-gutUsVX_MuekP-hRh5XO6w-1; Mon, 21 Feb 2022 07:37:48 -0500
X-MC-Unique: gutUsVX_MuekP-hRh5XO6w-1
Received: by mail-pf1-f197.google.com with SMTP id e18-20020aa78252000000b004df7a13daeaso4996240pfn.2
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 04:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV77O2+22zDtjFuEpVNaAxOO3yTDMtaxVMxo4p+73Ys=;
        b=N40vie7OK+jKtved6vYlPL2BZSZzntSWga9xb2Z8QHp2F4Xek8i+zb36FS98jRhkWx
         bKlATkg0rTY2qCqJVch0GNgLwX2i9gIxzdVi68djdig5ArXyLEcxr69rB9y2bWTNJf6q
         WNMhsufNgJtvE2F4GoGnHSl/cjjXjUuxMlvY4G7P85DExUt6A4zgqzucBY2mQ/VYWjTy
         h0fsTq5l9kqLgXV84gm3mU+YkYnNSPD0IWCcFJhqNUBdLsMzjyIaaGYiIDgxiwoczwMw
         Xl6qqO+7LpNQUnQuTvkIrS1jZvNJDSk4zz0xdKoxUhD8UEspeyXKJ1orv2fJoyQYCAcW
         00BA==
X-Gm-Message-State: AOAM532OuaHYdf7MUzXEdDtFnDYXeLSsHMsA8urn+ohWxn6PhVR31y0t
        PIUZspp3Gs7BxKqz+n+oIwCEe4a348E4N0f7V2i0Cn5aK2zBRREU3GjedmNVlHe/bijStsDpx8H
        klJk6zJr+qeVntTQEltLCWIs847LuSCcLXrNAWg==
X-Received: by 2002:a62:e90f:0:b0:4d1:7437:f0c2 with SMTP id j15-20020a62e90f000000b004d17437f0c2mr19953768pfh.5.1645447067046;
        Mon, 21 Feb 2022 04:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzixRnA8+DunkkS5x+iGYLT96XMjkOmR40D3b+P+um2eJ4jwjynrDD/f05ZFc6Qi7y65d8ojFEcMoUM+/e+XlA=
X-Received: by 2002:a62:e90f:0:b0:4d1:7437:f0c2 with SMTP id
 j15-20020a62e90f000000b004d17437f0c2mr19953743pfh.5.1645447066738; Mon, 21
 Feb 2022 04:37:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
In-Reply-To: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 21 Feb 2022 20:37:35 +0800
Message-ID: <CAHj4cs_LZoohRngyjz8GZCZfK+XOTT5-3ihxnwOVD2jwGEKygw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

add linux-nvme maillist
On Mon, Feb 21, 2022 at 7:37 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> Below kmemleak triggered when I do nvme connect/reset/disconnect
> operations on latest 5.17.0-rc5, pls check it.
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8883e398bc00 (size 192):
>   comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8883e398a700 (size 192):
>   comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8894253d9d00 (size 192):
>   comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
>   hex dump (first 32 bytes):
>     80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>     [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>     [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>     [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>     [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>     [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
>     [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>     [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>     [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>     [<00000000471d7945>] ksys_write+0xf1/0x1c0
>     [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>     [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang

