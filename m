Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4B47982E
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Dec 2021 03:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhLRC3W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Dec 2021 21:29:22 -0500
Received: from out1.migadu.com ([91.121.223.63]:14055 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhLRC3V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Dec 2021 21:29:21 -0500
Message-ID: <a660b16a-d2be-a3fb-131d-0d4a0c5a31fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639794560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RLQioTSDFmL9+DH0ZtUtN3nB4W3jSYMfhG0Vm0tsDM=;
        b=LGTlrAXZph+srI7H0npZqXU5kvuQ9A/HW1YkHbAHX8HC7AFNqCkxvVnZnm7A2Cw92dm+8j
        XXCYihSHxv3fuqwCvm7sjzw6qJleVfHhdn4u4qNZCSwhWRTUSzis8VqSHYa3wJPazzn+3i
        zP58lrsS2/tZQPkN6WDsQLmccszTJuI=
Date:   Sat, 18 Dec 2021 10:29:15 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
 <d62f36375fac4a1286194bcbddcf50d4@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <d62f36375fac4a1286194bcbddcf50d4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/12/17 10:02, Saleem, Shiraz 写道:
>> Subject: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
>> get the source udp port number for a QP based on the local QPN. This provides a
>> better spread of traffic across NIC RX queues.  The method in the commit
>> d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
>> scaling") is stable. So it is also adopted in this commit.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index 102dc9342f2a..2697b40a539e 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp
>> *iwqp)
>>   	return status ? -ENOMEM : 0;
>>   }
>>
>> +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp) {
>> +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff); }
>> +
> 
> There are core hash function helpers based on the grh.flow_label or lqpn/rqrpn that RoCEv2 drivers could use the to get the UDP src port?
> 
> https://elixir.bootlin.com/linux/v5.16-rc5/source/include/rdma/ib_verbs.h#L4719
> 
> Why don't we use them instead to set the udp_info->src_port in irdma_modify_qp_roce when the path address vector is provided?

Got it. I will send a new patch based on your suggestion.
Thanks.
Zhu Yanjun

> 
> Shiraz

