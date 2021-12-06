Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B8346AE55
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhLFXZm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:25:42 -0500
Received: from out2.migadu.com ([188.165.223.204]:47613 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242479AbhLFXZl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:25:41 -0500
Message-ID: <246bcb01-95f4-c6a7-15ae-2553047b7698@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638832930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7IvlrCtoKjp5xd4xDDKc/Sxwxwqn6nlOxXKDx4LRjI=;
        b=dJcXjdqUg8/yFxwViZVGv+r0E3hwunwPrpF6jzMouO3W7eM+DuTskZOeBOXoBFWjJrpS9n
        HeGWM9Z71aoRNRgy8tBpjF6YPu00DmiNmJPRYgGe1Lye9jZx+TJ4dORnftVxbiVoiE/uhA
        y9fXHpCv8fdwoCZcpQHZZ6Q0PFrxh5k=
Date:   Tue, 7 Dec 2021 07:22:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/uverbs: remove the unnecessary assignment
To:     Haakon Bugge <haakon.bugge@oracle.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc:     Doug Ledford <dledford@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
References: <20211207064607.541695-1-yanjun.zhu@linux.dev>
 <D8348428-539D-4C4D-8D21-C23C1B0E80EB@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <D8348428-539D-4C4D-8D21-C23C1B0E80EB@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/12/6 22:27, Haakon Bugge 写道:
> 
> 
>> On 7 Dec 2021, at 07:46, yanjun.zhu@linux.dev wrote:
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The struct member variable create_flags are assigned twice.
> 
> may be "... is assigned twice." ?
My bad. Thanks.

Zhu Yanjun
> 
>> Remove the unnecessary assignment.
>>
>> Fixes: ece9ca97ccdc8 ("RDMA/uverbs: Do not check the input length on create_cq/qp paths")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> LGTM, so
> 
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> 
> 
> Thxs, Håkon
> 
>> ---
>> drivers/infiniband/core/uverbs_cmd.c | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
>> index d1345d76d9b1..6b6393176b3c 100644
>> --- a/drivers/infiniband/core/uverbs_cmd.c
>> +++ b/drivers/infiniband/core/uverbs_cmd.c
>> @@ -1399,7 +1399,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>> 	attr.sq_sig_type   = cmd->sq_sig_all ? IB_SIGNAL_ALL_WR :
>> 					      IB_SIGNAL_REQ_WR;
>> 	attr.qp_type       = cmd->qp_type;
>> -	attr.create_flags  = 0;
>>
>> 	attr.cap.max_send_wr     = cmd->max_send_wr;
>> 	attr.cap.max_recv_wr     = cmd->max_recv_wr;
>> -- 
>> 2.27.0
>>
> 

