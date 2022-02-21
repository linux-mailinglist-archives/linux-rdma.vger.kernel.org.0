Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D74BE3E1
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Feb 2022 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356510AbiBULiE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Feb 2022 06:38:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBULiE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Feb 2022 06:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A1211AD98
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645443460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mHD2CShMYCyFetIZOd+avQiJcNcAccLGdg5neFJHfG0=;
        b=fHe4XkmAs5ypM/QMkBavfgZ754hYl6BZc32U5BHnGPuqeQ1V627Dn8M1pesm8EKfM3nGQL
        7utOlsqtcS4w9VcqcYJ68MopZt32bBL+vvoEJ2H6gh1SO0P0vvGwM6c7M94wsT11rEJUDV
        qjUeeHqR3NseTWk9GbfLPNEupTC9o3c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-55UWg4ShNUei9Wqq8b38Jw-1; Mon, 21 Feb 2022 06:37:39 -0500
X-MC-Unique: 55UWg4ShNUei9Wqq8b38Jw-1
Received: by mail-pg1-f198.google.com with SMTP id d9-20020a630e09000000b00374105253b2so3854695pgl.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Feb 2022 03:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mHD2CShMYCyFetIZOd+avQiJcNcAccLGdg5neFJHfG0=;
        b=oBBw3INVJAQbqPkb9j6ZSnpRO4UpwnBtzUyBPIf9eImjh21LVCe3fGxuCxxHHkaB7o
         Pg5XjVEZNXDGpPfn2pmbZZqmqcdbBztVJaKzDF3WviivrxtPztc+WrLnaFIWe84rAmad
         VLq6SSjmNAdwQhIIT6dm3AuqWAqIoo/N8NWIr+ST008TNuTYAeCvw6tI2wnD7aSj/MO4
         qexHBPSio5dsFxHfoVpoIXM4vVhNhLXK/ZOUYQj21l8yL5eHBwjoBVQH0ECW7NqX9VcL
         enhbtrU5q6zoi0xTO5sfcWo2v3PBg/eYxU7dqqHprEQ01EobbJj3YxJv5e9fTxcDdiah
         4slQ==
X-Gm-Message-State: AOAM530Fs+f8De2lfkLKmYFakYrRZrDccEke9rAXoq/K2fr2DbEminS/
        kOMK9pIXQdntKqWAIO4wJrnWqUtiuuZerraQjwR3OBXJcmhht7RoseSUcU87p3OKexAJnCC9vEm
        u+itxs3Ns7KDobKBJD/yyVTliyaAXKz4gulSEYA==
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id e21-20020a63f555000000b003739ad0ca08mr15737476pgk.315.1645443457687;
        Mon, 21 Feb 2022 03:37:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWdM+PKanq35v7zv/1p+fTJWfMxn5qkkVvgJM5UejOk+cixCZORo5+nvL7Xm35wqpz/E9ZwbTu6m2YTVs97UM=
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id
 e21-20020a63f555000000b003739ad0ca08mr15737450pgk.315.1645443457226; Mon, 21
 Feb 2022 03:37:37 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 21 Feb 2022 19:37:26 +0800
Message-ID: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
Subject: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with nvme-rdma testing
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
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

Hello

Below kmemleak triggered when I do nvme connect/reset/disconnect
operations on latest 5.17.0-rc5, pls check it.

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8883e398bc00 (size 192):
  comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
  hex dump (first 32 bytes):
    80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
    [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
    [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
    [<00000000aade682c>] blk_alloc_queue+0x400/0x840
    [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
    [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
    [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
    [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000031d8624b>] vfs_write+0x17e/0x9a0
    [<00000000471d7945>] ksys_write+0xf1/0x1c0
    [<00000000a963bc79>] do_syscall_64+0x3a/0x80
    [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
unreferenced object 0xffff8883e398a700 (size 192):
  comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
  hex dump (first 32 bytes):
    80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
    [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
    [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
    [<00000000aade682c>] blk_alloc_queue+0x400/0x840
    [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
    [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
    [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
    [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000031d8624b>] vfs_write+0x17e/0x9a0
    [<00000000471d7945>] ksys_write+0xf1/0x1c0
    [<00000000a963bc79>] do_syscall_64+0x3a/0x80
    [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
unreferenced object 0xffff8894253d9d00 (size 192):
  comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
  hex dump (first 32 bytes):
    80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
    [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
    [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
    [<00000000aade682c>] blk_alloc_queue+0x400/0x840
    [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
    [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
    [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
    [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
    [<0000000031d8624b>] vfs_write+0x17e/0x9a0
    [<00000000471d7945>] ksys_write+0xf1/0x1c0
    [<00000000a963bc79>] do_syscall_64+0x3a/0x80
    [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae



-- 
Best Regards,
  Yi Zhang

