Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF152B4B8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiERIam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiERIal (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 04:30:41 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC454027
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 01:30:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDciQvC_1652862634;
Received: from 30.43.106.18(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDciQvC_1652862634)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 May 2022 16:30:35 +0800
Message-ID: <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
Date:   Wed, 18 May 2022 16:30:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220510131724.GA1093822@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
> On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
> 
>> +static struct rdma_link_ops erdma_link_ops = {
>> +	.type = "erdma",
>> +	.newlink = erdma_newlink,
>> +};
> 
> Why is there still a newlink?
> 

Hello, Jason,

About this issue, I have another idea, more simple and reasonable.

Maybe erdma driver doesn't need to link to a net device in kernel. In
the core code, the ib_device_get_netdev has several use cases:

   1). query port info in netlink
   2). get eth speed for IB (ib_get_eth_speed)
   3). enumerate all RoCE ports (ib_enum_roce_netdev)
   4). iw_query_port

The cases related to erdma is 4). But we change it in our patch 02/12.
So, it seems all right that we do not link erdma to a net device.

* I also test this solution, it works for both perftest and NoF. *

Another issue is how to get the port state and attributes without
net device. For this, erdma can get it from HW directly.

So, I think this may be the final solution. (BTW, I have gone over
the rdma drivers, EFA does in this way, it also has two separated
devices for net and rdma. It inspired me).

Thanks,
Cheng Xu
