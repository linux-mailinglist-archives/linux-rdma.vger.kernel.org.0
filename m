Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B04229100
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 08:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGVGfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 02:35:37 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25592 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVGfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 02:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595399736; x=1626935736;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sMxTKggyWW8akj3924gWlhwqkiklVYYmiv4urtdv+wo=;
  b=Mo9GD3xK9XOkDcUk1zROnhCuVXaenbOTdO9+3LRGeTQvFV7gH0a6OGUg
   XPvdtIKBep315+9/kfkRcqV8d0DYmAZKk0QI6VwE+H4hiyXo2SOCAnF7U
   OadLKCiGNmPcWwvbPFXO0pRSLYClhgkXZ6AidZ15G3MJMAeQ9SqfD7Z0Y
   E=;
IronPort-SDR: Pt9iILhiR4vjuxu9uONwgxjswT3NHnjg1zJClWspXQIkcHyNJ/13+39orUBIarRsw63n5M5dLy
 MK2/JhIu82WQ==
X-IronPort-AV: E=Sophos;i="5.75,381,1589241600"; 
   d="scan'208";a="61810427"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Jul 2020 06:35:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 74DA4A23F5;
        Wed, 22 Jul 2020 06:35:26 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 06:35:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.156) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 06:35:19 +0000
Subject: Re: [PATCH for-next v2 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>, <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        <linux-rdma@vger.kernel.org>,
        "Alexander Matushevsky" <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
References: <20200720080113.13055-4-galpress@amazon.com>
 <202007210118.fF0Xv5Jy%lkp@intel.com>
 <99314564-cb73-5a25-3583-1afda323d2b3@amazon.com>
 <CAKwvOdns6+LVqLO_aZgXOYi33xskO860=BEU-=Q7c3nGYkHs2A@mail.gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2567f2dc-90e7-a0ca-e322-f585bda08e42@amazon.com>
Date:   Wed, 22 Jul 2020 09:35:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdns6+LVqLO_aZgXOYi33xskO860=BEU-=Q7c3nGYkHs2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.156]
X-ClientProxiedBy: EX13D39UWB003.ant.amazon.com (10.43.161.215) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/07/2020 20:10, Nick Desaulniers wrote:
> On Tue, Jul 21, 2020 at 4:27 AM 'Gal Pressman' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
>>
>> On 20/07/2020 20:08, kernel test robot wrote:
>>> Hi Gal,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on 5f0b2a6093a4d9aab093964c65083fe801ef1e58]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/Add-support-for-0xefa1-device/20200720-160419
>>> base:    5f0b2a6093a4d9aab093964c65083fe801ef1e58
>>> config: x86_64-allyesconfig (attached as .config)
>>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cf1105069648446d58adfb7a6cc590013d6886ba)
>>
>> Uh, looks like I use some gcc specific stuff here.. I guess it's time to start
>> checking clang compilation as well :).
>>
>> Will fix and resubmit.
> 
>>> drivers/infiniband/hw/efa/efa_verbs.c:1539:18: error: invalid application of 'sizeof' to an incomplete type 'struct (anonymous struct at drivers/infiniband/hw/efa/efa_verbs.c:1529:2) []'
>            for (i = 0; i < ARRAY_SIZE(user_comp_handshakes); i++) {
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> is user_comp_handshakes forward declared but not defined for an allyesconfig?
> 

I don't think that's the issue here, the real problem is the first error:

>> drivers/infiniband/hw/efa/efa_verbs.c:1533:3: error: function definition is not allowed here
                   DEFINE_COMP_HANDSHAKE(max_tx_batch, EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
                   ^
   drivers/infiniband/hw/efa/efa_verbs.c:1520:4: note: expanded from macro 'DEFINE_COMP_HANDSHAKE'
                           DEFINE_GET_DEV_ATTR_FUNC(_attr)                        \
                           ^
   drivers/infiniband/hw/efa/efa_verbs.c:1506:2: note: expanded from macro 'DEFINE_GET_DEV_ATTR_FUNC'


Apparently the braced group (is that how its called?) is supported by gcc, but not clang.
