Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03FB7D991F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbjJ0M6O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0M6O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 08:58:14 -0400
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7B128
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 05:58:11 -0700 (PDT)
Message-ID: <37f4c803-657d-4be5-04f1-3dcaba913a67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698411489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN8E+pjWtfBBCGkyHy4w50Db3Ybyjwc0ID11g9FHq/8=;
        b=lhBlvQSQ4r7VZSmTuWk9WwHxZQFva6bRyeolc08133Ax2jEg8SxB1GAlB9zBARCm2SIUaZ
        PBxUqksw9FGtYlCuSJGqFE73UvFFExuozCBbLIFZ977ulHZzJe44WhTuqxkTZCSc14MJft
        q9tLLwIvQVPnWK2xU2PP3ToSGzNMBpc=
Date:   Fri, 27 Oct 2023 20:58:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V3 08/18] RDMA/siw: Factor out siw_generic_rx helper
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
 <20231027023328.30347-9-guoqing.jiang@linux.dev>
 <SN7PR15MB575582520A864E7144F1E2B099DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <SN7PR15MB575582520A864E7144F1E2B099DCA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/27/23 20:44, Bernard Metzler wrote:
>
>> -----Original Message-----
>> From: Guoqing Jiang <guoqing.jiang@linux.dev>
>> Sent: Friday, October 27, 2023 4:33 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH V3 08/18] RDMA/siw: Factor out siw_generic_rx
>> helper
>>
>> Remove the redundant code given they share the same logic.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_qp_rx.c | 53 ++++++++++-----------------
>>   1 file changed, 20 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> index 10805a7d0487..2a6473a5abe0 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> @@ -405,6 +405,20 @@ static struct siw_wqe *siw_rqe_get(struct siw_qp *qp)
>>   	return wqe;
>>   }
>>
> Maybe better call it siw_rx_data()?

Ok, will change it in new version.

> For a 'generic receive' I could imagine 1000 things.
> You made an abstraction for receiving different types
> of payload.

Right.

Thanks,
Guoqing
