Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0169754DF31
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiFPKgb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiFPKfw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 06:35:52 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD25DBF9
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 03:35:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VGa1MfB_1655375723;
Received: from 30.43.105.121(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VGa1MfB_1655375723)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 18:35:24 +0800
Message-ID: <bba62ab7-3557-0f96-1e38-d217cb39de96@linux.alibaba.com>
Date:   Thu, 16 Jun 2022 18:35:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/14] rdma/siw: implement non-blocking connect
Content-Language: en-US
To:     Stefan Metzmacher <metze@samba.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <BYAPR15MB2631B0C5E27454FE2ECBAC2799AD9@BYAPR15MB2631.namprd15.prod.outlook.com>
 <ad060508-3cfd-8663-2d19-22c351f98ca1@samba.org>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <ad060508-3cfd-8663-2d19-22c351f98ca1@samba.org>
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



On 6/16/22 5:07 PM, Stefan Metzmacher wrote:
> Hi Bernard,
> 
>> Hi Stefan, much appreciated! I think the erdma driver
>> did a good job implementing something similar, but w/o
>> the need to look into MPA v2 specifics, especially the
>> extra handshake in RDMA mode.
> 
> As far as I see they introduce a dedicated
> ERDMA_CM_WORK_CONNECTTIMEOUT and the timeouts
> are:
> 
>  > +#define MPAREQ_TIMEOUT (HZ * 20)
>  > +#define MPAREP_TIMEOUT (HZ * 10)
>  > +#define CONNECT_TIMEOUT (HZ * 10)
> 
> If I read the code correct that would be 10 + 20 seconds
> before a RDMA_CM_EVENT_ESTABLISHED must be posted.
> 

You are right.

> I'm using just one timer (#define MPAREQ_TIMEOUT (HZ * 10)) that spans 
> the tcp connect
> as well as the MPA handshare.
> 
> I don't think we should care in what portion the time was spend
> between tcp and mpa, what matters for the caller is the overall timeout
> to get a valid connection. So I think a single timeout is better.
> 

Indeed one timer is enough and works fine. But in erdma, our consider
is:

TCP connection establishment and iWarp MPA negotiation are two stages.
tcp connect timeout often means the server is offline. And how long the 
MPA negotiation takes is influenced by the server's load (client will 
wait longer if many clients connect to it due to more RDMA resources 
need being allocated).

We want to distinguish these two situations. A shorter TCP expired time
and a longer MPA expired time allow clients can try to connect another
server fast if the current server is unreachable, and also have
enough time to wait the MPA negotiation finished. This solves some
issues in our internal scenarios.

Thanks,
Cheng Xu

