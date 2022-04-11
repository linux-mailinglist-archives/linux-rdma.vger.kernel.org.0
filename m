Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768B44FB204
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbiDKCyl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiDKCyk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 22:54:40 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0042A32
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 19:52:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V9ggfkh_1649645544;
Received: from 30.43.105.159(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V9ggfkh_1649645544)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 10:52:25 +0800
Message-ID: <4bd2e278-bb7e-1b7b-ba01-84a1a0d01958@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 10:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH for-next v5 00/12] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com
References: <20220406023450.56683-1-chengyou@linux.alibaba.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220406023450.56683-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/6/22 10:34 AM, Cheng Xu wrote:
> Hello all,
> 

<...>

Hello, Jason and Leon,

This v5 patchset has a compilation issue with the latest for-next
branch, due to "pci_dma_compat.h" was removed in kernel 5.18. And it
will have another compilation issue with the "device_cap_flags" [1], but
I didn't see the changes in for-next branch for now.

I will fix them together and send another patchset after the changes in
[1] are present in for-next branch.

[1] 
https://lore.kernel.org/netdev/0-v2-22c19e565eef+139a-kern_caps_jgg@nvidia.com/

Thanks,
Cheng Xu

> Cheng Xu (12):
>    RDMA: Add ERDMA to rdma_driver_id definition
>    RDMA/core: Allow calling query_port when netdev isn't attached in
>      iWarp
>    RDMA/erdma: Add the hardware related definitions
>    RDMA/erdma: Add main include file
>    RDMA/erdma: Add cmdq implementation
>    RDMA/erdma: Add event queue implementation
>    RDMA/erdma: Add verbs header file
>    RDMA/erdma: Add verbs implementation
>    RDMA/erdma: Add connection management (CM) support
>    RDMA/erdma: Add the erdma module
>    RDMA/erdma: Add the ABI definitions
>    RDMA/erdma: Add driver to kernel build environment
> 
>   MAINTAINERS                               |    8 +
>   drivers/infiniband/Kconfig                |    1 +
>   drivers/infiniband/core/device.c          |    7 +-
>   drivers/infiniband/hw/Makefile            |    1 +
>   drivers/infiniband/hw/erdma/Kconfig       |   12 +
>   drivers/infiniband/hw/erdma/Makefile      |    4 +
>   drivers/infiniband/hw/erdma/erdma.h       |  288 ++++
>   drivers/infiniband/hw/erdma/erdma_cm.c    | 1434 ++++++++++++++++++++
>   drivers/infiniband/hw/erdma/erdma_cm.h    |  168 +++
>   drivers/infiniband/hw/erdma/erdma_cmdq.c  |  497 +++++++
>   drivers/infiniband/hw/erdma/erdma_cq.c    |  205 +++
>   drivers/infiniband/hw/erdma/erdma_eq.c    |  334 +++++
>   drivers/infiniband/hw/erdma/erdma_hw.h    |  504 +++++++
>   drivers/infiniband/hw/erdma/erdma_main.c  |  631 +++++++++
>   drivers/infiniband/hw/erdma/erdma_qp.c    |  564 ++++++++
>   drivers/infiniband/hw/erdma/erdma_verbs.c | 1454 +++++++++++++++++++++
>   drivers/infiniband/hw/erdma/erdma_verbs.h |  342 +++++
>   include/uapi/rdma/erdma-abi.h             |   49 +
>   include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
>   19 files changed, 6503 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/infiniband/hw/erdma/Kconfig
>   create mode 100644 drivers/infiniband/hw/erdma/Makefile
>   create mode 100644 drivers/infiniband/hw/erdma/erdma.h
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.h
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_hw.h
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>   create mode 100644 include/uapi/rdma/erdma-abi.h
> 
