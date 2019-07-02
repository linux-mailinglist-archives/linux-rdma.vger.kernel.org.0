Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB25D146
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGBOOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 10:14:18 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:51514 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOOS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 10:14:18 -0400
Received: from [195.176.96.212] (helo=[10.3.4.72])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hiJY1-0007US-5n; Tue, 02 Jul 2019 16:14:17 +0200
Subject: Re: [PATCH] ibverbs/rxe: Remove variable self-initialization
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
 <20190702140643.GV4727@mtr-leonro.mtl.com>
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <87010175-9072-b0e6-afc0-4e632587503a@os.inf.tu-dresden.de>
Date:   Tue, 2 Jul 2019 16:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702140643.GV4727@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 02/07/2019 16:06, Leon Romanovsky wrote:
> On Tue, Jul 02, 2019 at 03:49:28PM +0200, Maksym Planeta wrote:
>> In some cases (not in this particular one) variable self-initialization
>> can lead to undefined behavior. In this case, it is just obscure code.
>>
>> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 00eb99d3df86..116cafc9afcf 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -558,7 +558,7 @@ int rxe_completer(void *arg)
>>   {
>>   	struct rxe_qp *qp = (struct rxe_qp *)arg;
>>   	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> -	struct rxe_send_wqe *wqe = wqe;
>> +	struct rxe_send_wqe *wqe = NULL;
> 
> This can't work, for example call to do_read() will crash the system,
> due to pointer dereference.
> 

wqe will be properly initialized before actual usage.

Before do_read can be called, first there is necessary COMPST_GET_ACK, 
and then necessary COMPST_GET_WQE. Then get_wqe will be called, that 
sets proper value for wqe.

>>   	struct sk_buff *skb = NULL;
>>   	struct rxe_pkt_info *pkt = NULL;
>>   	enum comp_state state;
>> --
>> 2.20.1
>>

-- 
Regards,
Maksym Planeta
