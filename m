Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196D5BF372
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Sep 2022 04:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIUC3E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUC3D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 22:29:03 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10F840BE0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 19:29:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQLob7P_1663727338;
Received: from 30.221.97.160(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VQLob7P_1663727338)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 10:28:59 +0800
Message-ID: <4f2425e1-4326-c337-5bc5-06400a6cce62@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 10:28:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH for-next 4/4] RDMA/erdma: Support dynamic mtu
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
 <20220909093822.33868-5-chengyou@linux.alibaba.com> <YymkwSPZa3B0oTKk@unreal>
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YymkwSPZa3B0oTKk@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/20/22 7:32 PM, Leon Romanovsky wrote:
> On Fri, Sep 09, 2022 at 05:38:22PM +0800, Cheng Xu wrote:
>> Hardware now support jumbo frame for RDMA. So we introduce a new CMDQ
>> message to support mtu change notification.
>>
<...>
> 
> I don't see any backward compatibility here. How can you make sure that
> new code that supports MTU change works correctly on old FW/device?
> 

In this case, driver needn't to consider backward compatibility.

ERDMA hardware is programmable part of our iaas infrastructure, and can be
hot-update without BMs/VMs awareness.Before I submitted this patch, all the
FWs has been updated, and support this feature, no old FWs exist.

Thanks,
Cheng Xu


