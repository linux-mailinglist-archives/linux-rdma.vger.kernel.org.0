Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE430527C3D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 05:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiEPDPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 23:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEPDPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 23:15:39 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD211C01
        for <linux-rdma@vger.kernel.org>; Sun, 15 May 2022 20:15:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDCuF3O_1652670932;
Received: from 30.43.106.100(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDCuF3O_1652670932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 11:15:33 +0800
Message-ID: <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
Date:   Mon, 16 May 2022 11:15:32 +0800
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
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
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
> Jason


Yeah, I remember your suggestion that the ibdev should keep the same
lifecycle with its PCI device, and so does it now.

The initialization flow for erdma now:
      probe:
        - Hardware specified initialization
        - IB device initialization
        - Calling ib_register_device with ibdev->netdev == NULL

After probe, The ib device has been registered, but we left it in
invalid state.
To fully complete the initialization, we should set the ibdev->netdev.

And the newlink command in erdma only do one thing now: set the 
ibdev->netdev if the rule matches, and it is uncorrelated with the
ib device lifecycle.

I think this may be the best way to link the netdev to ibdev for erdma.
Using netdev notifier is not good because we should register a netdev
notifier for the module.

If this way is not proper or there are some better ways, please let me
know.

Thanks,
Cheng Xu
