Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1453F3E3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiFGCYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 22:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiFGCYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 22:24:14 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D937B9E4
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 19:24:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFbXC3U_1654568647;
Received: from 30.43.105.179(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VFbXC3U_1654568647)
          by smtp.aliyun-inc.com;
          Tue, 07 Jun 2022 10:24:09 +0800
Message-ID: <b488fce9-f027-1efa-ce0d-d8ae6e4831bb@linux.alibaba.com>
Date:   Tue, 7 Jun 2022 10:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH for-next v9 00/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220523075528.35017-1-chengyou@linux.alibaba.com>
 <20220606154754.GA645238@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220606154754.GA645238@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/6/22 11:47 PM, Jason Gunthorpe wrote:
> On Mon, May 23, 2022 at 03:55:17PM +0800, Cheng Xu wrote:
>> Hello all,
>>

<...>

> I've put this into linux-next - usually you will get a bunch of static
> checker reports so lets imagine a v10 re-post after that concludes.
> 

OK, I will wait the reports and fix the issues if reported.

Thanks very much.
Cheng Xu

