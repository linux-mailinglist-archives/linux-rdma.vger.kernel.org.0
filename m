Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA654DE75
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiFPJv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFPJv5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 05:51:57 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E830D4EF75
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 02:51:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGZsK7._1655373112;
Received: from 30.43.105.121(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VGZsK7._1655373112)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 17:51:53 +0800
Message-ID: <519e5f3e-1319-d8f9-5ab0-a86351e96c0f@linux.alibaba.com>
Date:   Thu, 16 Jun 2022 17:51:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH for-next v11 08/11] RDMA/erdma: Add connection management
 (CM) support
Content-Language: en-US
To:     Stefan Metzmacher <metze@samba.org>, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com,
        dan.carpenter@oracle.com
References: <20220615015227.65686-1-chengyou@linux.alibaba.com>
 <20220615015227.65686-9-chengyou@linux.alibaba.com>
 <ad1bb1ae-39ae-a728-07d6-2d996292d240@samba.org>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ad1bb1ae-39ae-a728-07d6-2d996292d240@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/16/22 5:11 PM, Stefan Metzmacher wrote:
> 
> Am 15.06.22 um 03:52 schrieb Cheng Xu:
>> ERDMA's transport protocol is iWarp, so the driver must support CM
>> interface. In CM part, we use the same way as SoftiWarp: using kernel
>> socket to set up the connection, then performing MPA negotiation in
>> kernel. So, this part of code mainly comes from SoftiWarp, base on it,
>> we add some more features, such as non-blocking iw_connect 
>> implementation.
> 
> It would be great to have common parts to be unified in the long run
> otherwise fixes are only applied to one version.
> 

Yeah, it's looks good. But for now I think it is better to keep the
respective implementations. Because erdma and siw have different
purposes: siw aims to provides a standard iWarp implementation in
kernel, while erdma is a RDMA adapter in our cloud, needing fit our
hardware and the special network environment. There are already some
differences, and I'm not sure there will be more or not in the future.
We may consider it in the future.

Thanks your advice.
Cheng Xu



