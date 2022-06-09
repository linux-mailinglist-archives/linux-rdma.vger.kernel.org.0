Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5254413C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiFICGb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 22:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFICGa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 22:06:30 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1771E4424
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 19:06:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFpDyjD_1654740384;
Received: from 30.43.106.59(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VFpDyjD_1654740384)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 10:06:25 +0800
Message-ID: <c55b6b3b-ebaf-390a-184a-cd14638d6383@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 10:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH for-next v10 00/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220608104320.53066-1-chengyou@linux.alibaba.com>
 <20220608115400.GK3932382@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220608115400.GK3932382@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/8/22 7:54 PM, Jason Gunthorpe wrote:
> On Wed, Jun 08, 2022 at 06:43:09PM +0800, Cheng Xu wrote:
>> Hello all,
>>
>> This v10 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
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
>>
>> Fixed issues in v10:
>> - Remove unneeded semicolon in erdma_qp.c reported by Abcci Robot.
>> - Remove duplicated include in erdma_cm.c reported by Abcci Robot.
>> - Fix return value check in erdma_alloc_ucontext() reported by Hulk
>>    Robot.
>> - Sort the include headers.
> 
> I updated it, but please wait longer before sending v11.
> 
> Jason

Got it, and I will wait longer.

Thanks,
Cheng Xu
