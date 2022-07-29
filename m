Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7F584B60
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiG2GH6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2GH5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 02:07:57 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED56BC1F
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 23:07:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKk5.Sl_1659074873;
Received: from 30.43.106.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VKk5.Sl_1659074873)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 14:07:54 +0800
Message-ID: <277031d8-6e9c-b845-1331-6685c00f7a8a@linux.alibaba.com>
Date:   Fri, 29 Jul 2022 14:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v14 0/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220727014927.76564-1-chengyou@linux.alibaba.com>
 <YuHgsTJ/tO9Lbodl@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YuHgsTJ/tO9Lbodl@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/22 9:04 AM, Jason Gunthorpe wrote:
> On Wed, Jul 27, 2022 at 09:49:16AM +0800, Cheng Xu wrote:
>> Hello all,
>>
>> This v14 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
>> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
>> userspace provider has already been created [1].
>>
>> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
>> environment, initially offered in g7re instance. It can improve the
>> efficiency of large-scale distributed computing and communication
>> significantly and expand dynamically with the cluster scale of Alibaba
>> Cloud.
>>
>> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
>> works in the VPC network environment (overlay network), and uses iWarp
>> transport protocol. ERDMA supports reliable connection (RC). ERDMA also
>> supports both kernel space and user space verbs. Now we have already
>> supported HPC/AI applications with libfabric, NoF and some other internal
>> verbs libraries, such as xrdma, epsl, etc,.
>>
>> For the ECS instance with RDMA enabled, our MOC hardware generates two
>> kinds of PCI devices: one for ERDMA, and one for the original net device
>> (virtio-net). They are separated PCI devices.
> 
> Applied to for-next, please sent any further fixes as individual
> patches

We will.

Thank you, Jason. And thank everyone else who gave us lots of help.

Cheng Xu
