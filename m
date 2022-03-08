Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258214D248B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 23:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiCHXAj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 18:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiCHXAi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 18:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24D184D24F
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 14:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646780379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzoZYAsHrVdv98Xt1yQ3c/yb77T1PgQBlk+j4+YdQqs=;
        b=BgevHF636apLMi7QL11UeY2QE3aLMUC6mTUK3GwB+LdIt1msL+rA7QMakelQ7tGEKNQyhw
        27A9sl65tnNiqMG1aper7Qt950x8boxl1bJXITCFU9/a3msA3TzjZXX3k4d1mI2VkRKQkk
        uQYM1aMXi8dROMWejUU2Vc6ZW3+NhQA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-hL7umv63NS6LvqPYcl8POg-1; Tue, 08 Mar 2022 17:59:38 -0500
X-MC-Unique: hL7umv63NS6LvqPYcl8POg-1
Received: by mail-pg1-f198.google.com with SMTP id q7-20020a63e207000000b003801b9bb18dso216292pgh.15
        for <linux-rdma@vger.kernel.org>; Tue, 08 Mar 2022 14:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzoZYAsHrVdv98Xt1yQ3c/yb77T1PgQBlk+j4+YdQqs=;
        b=oSjeUkX5cUB3rFDKDXm4ks4TKQ97gIMjoYlaYcT1Xhlltqdf35xbUPMoj/PAQHGkvR
         BDNEpMnvkATv/WlpbahaEJUMhc5jd5CzZIKLwgQAXMcCUQhOXPDEG7GLDB1ir3yNkgDq
         b0tBg/SfDlIgVM9C6YvXHva3UGchOv8TIVrSlEUn97Ba33TkCoafGDTLVme/qdgROTLT
         kWRaTzfpan14D+wP3bRaTo87t4750sWFMk2ptm9/G+bsUbAmnG/HqBS63nIWE17PTW1+
         J7daaJBiS2CmpFSoLRiLbevnGNCReERgcJCS4RsFJ1cN/NGxJZZ4Zjow50iiNNbUzNtU
         dnog==
X-Gm-Message-State: AOAM530nJUwNp/RqmMJ502Ngknj+0bgxbAEUO0vycXar4pBnn6cprIxD
        xgV2pmOnTqKgnTbDyeXBoVhAVONDERLl3hw2f+xPU8XhDwzPr/+bJLvtFFxutFsP4Nn3ApZXtBf
        ++VzcAWoqeTwbn5HokOIrjduaTRQWkSsZeWoEig==
X-Received: by 2002:a17:902:ce86:b0:151:a78b:44fe with SMTP id f6-20020a170902ce8600b00151a78b44femr19284461plg.159.1646780376974;
        Tue, 08 Mar 2022 14:59:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaJw+Dfu3e7uZzkDDFjsyYEDS9HCRwvl6GxiQmrUkZUYPtyT+OK0JFJRX4YT9rNCsDqEuKLjXcwDJmw3s+apI=
X-Received: by 2002:a17:902:ce86:b0:151:a78b:44fe with SMTP id
 f6-20020a170902ce8600b00151a78b44femr19284437plg.159.1646780376664; Tue, 08
 Mar 2022 14:59:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
In-Reply-To: <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 9 Mar 2022 06:59:24 +0800
Message-ID: <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 8, 2022 at 11:51 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Hi Yi Zhang,
>
> Please send the commands to repro.
>
> I run the following with no success to repro:
>
> for i in `seq 100`; do echo $i &&  cat /sys/kernel/debug/kmemleak &&
> echo clear > /sys/kernel/debug/kmemleak && nvme reset /dev/nvme2 &&
> sleep 5 && echo scan > /sys/kernel/debug/kmemleak ; done

Hi Max
Sorry, I should add more details when I report it.
The kmemleak observed when I was reproducing the "nvme reset" timeout
issue we discussed before[1], and the cmd I used are[2]

[1]
https://lore.kernel.org/linux-nvme/CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com/T/#m5e6dcc434fc1925b18047c348226cfbc48ffbd14
[2]
# nvme connect to target
# nvme reset /dev/nvme0
# nvme disconnect-all
# sleep 10
# echo scan > /sys/kernel/debug/kmemleak
# sleep 60
# cat /sys/kernel/debug/kmemleak


>
> -Max.
>
> On 2/21/2022 1:37 PM, Yi Zhang wrote:
> > Hello
> >
> > Below kmemleak triggered when I do nvme connect/reset/disconnect
> > operations on latest 5.17.0-rc5, pls check it.
> >
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff8883e398bc00 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8883e398a700 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > unreferenced object 0xffff8894253d9d00 (size 192):
> >    comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
> >    hex dump (first 32 bytes):
> >      80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
> >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace:
> >      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
> >      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
> >      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
> >      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
> >      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
> >      [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
> >      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
> >      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
> >      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
> >      [<00000000471d7945>] ksys_write+0xf1/0x1c0
> >      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
> >      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> >
> >
>


-- 
Best Regards,
  Yi Zhang

