Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694A417E96
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Sep 2021 02:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhIYAWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 20:22:34 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:59676 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhIYAWe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Sep 2021 20:22:34 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 8276B1008CBC0;
        Sat, 25 Sep 2021 08:20:58 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 6B08C200B5750;
        Sat, 25 Sep 2021 08:20:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WZm9hljEh1F3; Sat, 25 Sep 2021 08:20:58 +0800 (CST)
Received: from [192.168.10.98] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 43222200B574F;
        Sat, 25 Sep 2021 08:20:46 +0800 (CST)
Message-ID: <9439f81a-9bcb-816e-4187-2b37a388db19@sjtu.edu.cn>
Date:   Sat, 25 Sep 2021 08:20:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Content-Language: en-US
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org> <YUwin2cn8X5GGjyY@unreal>
 <9cda0704-0e63-39b2-7874-fd679314eb2b@acm.org>
 <CH0PR01MB71533CD295D5799DC26CF857F2A49@CH0PR01MB7153.prod.exchangelabs.com>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <CH0PR01MB71533CD295D5799DC26CF857F2A49@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/9/24 22:43, Marciniszyn, Mike wrote:
>> On 9/22/21 23:45, Leon Romanovsky wrote:
>>> Isn't kptr_restrict sysctl is for that?
>> Hi Leon,
>>
>> After I sent my email I discovered the following commit: 5ead723a20e0
>> ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed"; v5.12).
>> I think that commit does what we need?
>>
> Thanks Bart,
>
> I agree.
>
> Jason, as to traces, I suspect we need to do the same %p thing there for existing code and any new work.
>
> For situations for debugging in the wild, a command line arg can show the actual value.   I'm ok with that.
>
> Mike

Can this patch which changes %llx to %p in infiniband hfi1 to avoid 
kernel pointer release be applied?


Thanks.


Guo

