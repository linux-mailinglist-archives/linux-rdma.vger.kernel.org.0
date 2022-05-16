Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95332527BEC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 04:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiEPCaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiEPCaO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 22:30:14 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB483FD04
        for <linux-rdma@vger.kernel.org>; Sun, 15 May 2022 19:30:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDCSziF_1652668209;
Received: from 30.43.106.100(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDCSziF_1652668209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 10:30:10 +0800
Message-ID: <d9376e3c-38cb-9c6e-1234-48d3ed08d78f@linux.alibaba.com>
Date:   Mon, 16 May 2022 10:30:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 00/12] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220510125038.GA1093446@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220510125038.GA1093446@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/10/22 8:50 PM, Jason Gunthorpe wrote:
> On Thu, Apr 21, 2022 at 03:17:35PM +0800, Cheng Xu wrote:
>> Hello all,
>>
>> This v7 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
>> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
>> userspace provider has already been created [1].
> 
> It doesn't compile:
> 
> ../drivers/infiniband/hw/erdma/erdma_verbs.c:291:8: error: no member named 'kernel_cap_flags' in 'struct ib_device_attr'
>          attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
>          ~~~~  ^
> ../drivers/infiniband/hw/erdma/erdma_verbs.c:291:27: error: use of undeclared identifier 'IBK_LOCAL_DMA_LKEY'
>          attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
>                                   ^
> 
> Jason

This v7 patch set is based on the latest for-next branch. This
change is introduced by (e945c653c, RDMA: Split kernel-only global 
device caps from uverbs device caps). Maybe you compile the patch set
with for-rc?
If so, should the code be base on the for-rc code?

(BTW, sorry for late reply. My mail APP classified your responses to
wrong folder, and I'm aware of this after visiting the website
lore.kernel.org)

Thanks,
Cheng Xu



