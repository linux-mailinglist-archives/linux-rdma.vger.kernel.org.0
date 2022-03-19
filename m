Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B64DE696
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 07:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiCSG4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCSG4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 02:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B6AC517DA
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647672887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MgHqQLktkSEmFbrCodRv6+T7FFFapV0MhghNqFLZ9Sg=;
        b=L3iV0HCXO6YCadvuEogrsMEC1BR37ZVMV9Tsz0rKWAmCHPshbNBCPlDQgFysZ9DybEWxS7
        4p61tvMj2+Pirz3/hxxmZGayE6NCnBaj6gDp6PP8Wmi9tFftQNQhiH0wfsp7x3T/f1a9tc
        XhsVn3dFIQ6UqDo0ERBaXEddyt/277c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-o_kY1TBSNr2FwBVggybeaw-1; Sat, 19 Mar 2022 02:54:45 -0400
X-MC-Unique: o_kY1TBSNr2FwBVggybeaw-1
Received: by mail-pl1-f197.google.com with SMTP id n12-20020a1709026a8c00b001538f557d52so4642440plk.2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 23:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MgHqQLktkSEmFbrCodRv6+T7FFFapV0MhghNqFLZ9Sg=;
        b=UEBa1tDUCHIsL4RzlrUyeQYk9SMg+I0ton4fToJoBl9gJ8RgX5w3nqUXQ+dV9h0Omc
         8z9wqt8y1+eUn5Prnj1ljsYBFoviRhF/+cTsas3yRL5e2zlaXjuzpk53RK9aL2Gr2Ksd
         wB6KpqjnRrotMebH5d5MeOEPiZgn++6etF5E+9PxTY41y5mkrfY0sBPE+nQfPwVHQAKL
         JEiJjse9tDRjrszxQFZJr0L6gSbrgKHrCU3aOAqLdDzzhXuNV0ol1V/o/mhm99NcpVP+
         QFbWP6YGsHWY1hfQgw1hhQTY88FU97uwuoitGe2+zb54stUhOA/mF+WBCMg9udfqSdSH
         1oyg==
X-Gm-Message-State: AOAM531avrIVVEjO48LJKRYquYKJeB7Gfa9p1ObYmIzV00EtN03p4HYA
        +ObFv/u1epVaIDNtfaJnrEL3d63i4AUdm0mxg2ixha6b+mtSFPHeTWIqFmLkuAzq75U8+cjr/cf
        iI1gZlJ+70Xa3ulNyHATZViRTOHWkQcUjuTd8yg==
X-Received: by 2002:a05:6a00:18a3:b0:4f7:260b:2954 with SMTP id x35-20020a056a0018a300b004f7260b2954mr13458287pfh.33.1647672883573;
        Fri, 18 Mar 2022 23:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLTocqal7C0HeEq4UKjHTjc7bAEgXua/jBaj1r+Muuk6BV88dNnvU9E0tgxjD3oGJ8Qn/8gj17+AzbHvfpVl4=
X-Received: by 2002:a05:6a00:18a3:b0:4f7:260b:2954 with SMTP id
 x35-20020a056a0018a300b004f7260b2954mr13458263pfh.33.1647672882978; Fri, 18
 Mar 2022 23:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com> <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
 <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
In-Reply-To: <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 19 Mar 2022 14:54:31 +0800
Message-ID: <CAHj4cs_L=QHh4XeOJGfibfSJhhijS6s7RBNuLd_XetKT3hfjWQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 10, 2022 at 7:52 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 3/9/2022 12:59 AM, Yi Zhang wrote:
> > On Tue, Mar 8, 2022 at 11:51 PM Max Gurtovoy <mgurtovoy@nvidia.com> wro=
te:
> >> Hi Yi Zhang,
> >>
> >> Please send the commands to repro.
> >>
> >> I run the following with no success to repro:
> >>
> >> for i in `seq 100`; do echo $i &&  cat /sys/kernel/debug/kmemleak &&
> >> echo clear > /sys/kernel/debug/kmemleak && nvme reset /dev/nvme2 &&
> >> sleep 5 && echo scan > /sys/kernel/debug/kmemleak ; done
> > Hi Max
> > Sorry, I should add more details when I report it.
> > The kmemleak observed when I was reproducing the "nvme reset" timeout
> > issue we discussed before[1], and the cmd I used are[2]
> >
> > [1]
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Flinux-nvme%2FCAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5v=
wU0w%40mail.gmail.com%2FT%2F%23m5e6dcc434fc1925b18047c348226cfbc48ffbd14&am=
p;data=3D04%7C01%7Cmgurtovoy%40nvidia.com%7C8cef8eb496e84d35f52308da0157541=
9%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637823771831899724%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C3000&amp;sdata=3DkjMvRAWlBe1ym3FDQO1rdZ9%2FwtKQpscvXRG48aTt3L0%3D&=
amp;reserved=3D0
> > [2]
> > # nvme connect to target
> > # nvme reset /dev/nvme0
> > # nvme disconnect-all
> > # sleep 10
> > # echo scan > /sys/kernel/debug/kmemleak
> > # sleep 60
> > # cat /sys/kernel/debug/kmemleak
> >
> Thanks I was able to repro it with the above commands.
>
> Still not clear where is the leak is, but I do see some non-symmetric
> code in the error flows that we need to fix. Plus the keep-alive timing
> movement.
>
> It will take some time for me to debug this.
>
> Can you repro it with tcp transport as well ?

Yes, nvme/tcp also can reproduce it, here is the log:

unreferenced object 0xffff8881675f7000 (size 192):
  comm "nvme", pid 3711, jiffies 4296033311 (age 2272.976s)
  hex dump (first 32 bytes):
    20 59 04 92 ff ff ff ff 00 00 da 13 81 88 ff ff   Y..............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
    [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
    [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
    [<000000002653e58d>] blk_alloc_queue+0x400/0x840
    [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
    [<00000000486936b6>] nvme_tcp_setup_ctrl+0x70c/0xbe0 [nvme_tcp]
    [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
    [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000056b79a25>] vfs_write+0x17e/0x9a0
    [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
    [<00000000c035c128>] do_syscall_64+0x3a/0x80
    [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
unreferenced object 0xffff8881675f7600 (size 192):
  comm "nvme", pid 3711, jiffies 4296033320 (age 2272.967s)
  hex dump (first 32 bytes):
    20 59 04 92 ff ff ff ff 00 00 22 92 81 88 ff ff   Y........".....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
    [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
    [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
    [<000000002653e58d>] blk_alloc_queue+0x400/0x840
    [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
    [<000000006ca5f9f6>] nvme_tcp_setup_ctrl+0x772/0xbe0 [nvme_tcp]
    [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
    [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000056b79a25>] vfs_write+0x17e/0x9a0
    [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
    [<00000000c035c128>] do_syscall_64+0x3a/0x80
    [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae
unreferenced object 0xffff8891fb6a3600 (size 192):
  comm "nvme", pid 3711, jiffies 4296033511 (age 2272.776s)
  hex dump (first 32 bytes):
    20 59 04 92 ff ff ff ff 00 00 5c 1d 81 88 ff ff   Y........\.....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000adbc7c81>] kmem_cache_alloc_trace+0x10e/0x220
    [<00000000c04d85be>] blk_iolatency_init+0x4e/0x380
    [<00000000897ffdaf>] blkcg_init_queue+0x12e/0x610
    [<000000002653e58d>] blk_alloc_queue+0x400/0x840
    [<00000000fcb99f3c>] blk_mq_init_queue_data+0x6a/0x100
    [<000000004a3bf20e>] nvme_tcp_setup_ctrl.cold.57+0x868/0xa5d [nvme_tcp]
    [<000000000bb29b26>] nvme_tcp_create_ctrl+0x953/0xbb4 [nvme_tcp]
    [<00000000ca3d4e54>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000056b79a25>] vfs_write+0x17e/0x9a0
    [<00000000a5af6c18>] ksys_write+0xf1/0x1c0
    [<00000000c035c128>] do_syscall_64+0x3a/0x80
    [<000000000e5ea863>] entry_SYSCALL_64_after_hwframe+0x44/0xae



>
> maybe add some debug prints to catch the exact flow it happens ?
>
> >> -Max.
> >>
> >> On 2/21/2022 1:37 PM, Yi Zhang wrote:
> >>> Hello
> >>>
> >>> Below kmemleak triggered when I do nvme connect/reset/disconnect
> >>> operations on latest 5.17.0-rc5, pls check it.
> >>>
> >>> # cat /sys/kernel/debug/kmemleak
> >>> unreferenced object 0xffff8883e398bc00 (size 192):
> >>>     comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
> >>>     hex dump (first 32 bytes):
> >>>       80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g..=
..
> >>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> >>>     backtrace:
> >>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >>>       [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rd=
ma]
> >>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rd=
ma]
> >>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>> unreferenced object 0xffff8883e398a700 (size 192):
> >>>     comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
> >>>     hex dump (first 32 bytes):
> >>>       80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g..=
..
> >>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> >>>     backtrace:
> >>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >>>       [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rd=
ma]
> >>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rd=
ma]
> >>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>> unreferenced object 0xffff8894253d9d00 (size 192):
> >>>     comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
> >>>     hex dump (first 32 bytes):
> >>>       80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g..=
..
> >>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..............=
..
> >>>     backtrace:
> >>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >>>       [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [=
nvme_rdma]
> >>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rd=
ma]
> >>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>
> >>>
> >>>
> >
>


--=20
Best Regards,
  Yi Zhang

