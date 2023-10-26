Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C37D7CEE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJZGh4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 02:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJZGhz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 02:37:55 -0400
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D279C
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 23:37:53 -0700 (PDT)
Message-ID: <1d10bc47-cdea-047c-0967-c42a5dd0c454@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698302269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCaq211H78DuqCVaO5Lz9KLnu8jk35NU60IVeTtFoOs=;
        b=XWLOcHrMbyA9peZXGHvuk6G5jErXSN4WZrej+FEjs65KVlxY27xElyP2OicgZWBKRCcIQU
        E8XWZDRKKuXdsSFmeLFoGta5pAGEmF90teBdQby3u3fNIXtAJAXN5deWcL04IYHlMgMDwD
        EEwmayK8zuWJxONImFRPWq32xQklUZI=
Date:   Thu, 26 Oct 2023 14:37:42 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 02/19] RDMA/siw: Introduce siw_srx_update_skb
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-3-guoqing.jiang@linux.dev>
 <SN7PR15MB575564AC986E9CB8F3D1E06799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SN7PR15MB575564AC986E9CB8F3D1E06799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
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



On 10/25/23 20:33, Bernard Metzler wrote:
>> -----Original Message-----
>> From: Guoqing Jiang<guoqing.jiang@linux.dev>
>> Sent: Monday, October 9, 2023 9:18 AM
>> To: Bernard Metzler<BMT@zurich.ibm.com>;jgg@ziepe.ca;leon@kernel.org
>> Cc:linux-rdma@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH 02/19] RDMA/siw: Introduce siw_srx_update_skb
>>
>> There are some places share the same logic, factor a common
>> helper for it.
>>
>> Signed-off-by: Guoqing Jiang<guoqing.jiang@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_qp_rx.c | 31 +++++++++++----------------
>>   1 file changed, 12 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> index 33e0fdb362ff..aa7b680452fb 100644
>> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> @@ -881,6 +881,13 @@ int siw_proc_rresp(struct siw_qp *qp)
>>   	return rv;
>>   }
>>
>> +static void siw_srx_update_skb(struct siw_rx_stream *srx, u16 length)
>> +{
>> +	srx->skb_offset += length;
>> +	srx->skb_new -= length;
>> +	srx->skb_copied += length;
>> +}
>> +
> better call it siw_update_skb_rcvd()?
> We are not updating the skb here, but our state
> referencing an skb.

Sure, thanks for the naming!

Thanks,
Guoqing
