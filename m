Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCE4C219A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBXCNT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBXCNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:13:18 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72AE13FAFB
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:12:49 -0800 (PST)
Message-ID: <e48c607e-d86a-fa06-746b-3176222288ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645668767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ohc3bMD/8j4gFrqMsjYoQvUqhtRyLjQBuIeALhh1mVY=;
        b=oyPkPtz0IGXMIHaCT0bj8RBtcFBxUjSOlmWR72RhcHVuFB0n1m/JcqO5iYiAcKl56CyIV3
        1gSFYCAsYoCBd0hZ/HhdYV7b26IBW64Lq8MWfroDGYnXdnDdvnMBwUS/GS1QL554eqmW76
        OcqZ9HhOR8+3cz3+n4aNqfa4DaNAveE=
Date:   Thu, 24 Feb 2022 10:12:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
References: <20220217181938.3798530-1-yanjun.zhu@linux.dev>
 <bbabbd38-e68f-f167-bf0e-c0f760e05c61@linux.dev>
 <0e3d1406d83b472eba6f805a34234cde@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <0e3d1406d83b472eba6f805a34234cde@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/2/24 2:00, Saleem, Shiraz 写道:
>> Subject: Re: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
>>
>> 在 2022/2/18 2:19, yanjun.zhu@linux.dev 写道:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> The function irdma_create_mg_ctx always returns 0, so make it void and
>>> delete the return value check.
>>>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> gentle ping
>>
>> Zhu Yanjun
>>
>>> ---
>>>    drivers/infiniband/hw/irdma/uda.c | 9 ++-------
>>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/irdma/uda.c
>>> b/drivers/infiniband/hw/irdma/uda.c
>>> index 7a9988ddbd01..5eeb76bc29fd 100644
>>> --- a/drivers/infiniband/hw/irdma/uda.c
>>> +++ b/drivers/infiniband/hw/irdma/uda.c
>>> @@ -86,8 +86,7 @@ enum irdma_status_code irdma_sc_access_ah(struct
>> irdma_sc_cqp *cqp,
>>>     * irdma_create_mg_ctx() - create a mcg context
>>>     * @info: multicast group context info
>>>     */
>>> -static enum irdma_status_code
>>> -irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
>>> +static void irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
>>>    {
>>>    	struct irdma_mcast_grp_ctx_entry_info *entry_info = NULL;
>>>    	u8 idx = 0; /* index in the array */ @@ -106,8 +105,6 @@
>>> irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
>>>    			ctx_idx++;
>>>    		}
>>>    	}
>>> -
>>> -	return 0;
>>>    }
>>>
>>>    /**
>>> @@ -135,9 +132,7 @@ enum irdma_status_code
>> irdma_access_mcast_grp(struct irdma_sc_cqp *cqp,
>>>    		return IRDMA_ERR_RING_FULL;
>>>    	}
>>>
>>> -	ret_code = irdma_create_mg_ctx(info);
>>> -	if (ret_code)
>>> -		return ret_code;
>>> +	irdma_create_mg_ctx(info);
> ret_code is unused now? Get rid of it?

Thanks, it is removed in the latest commit.

Zhu Yanjun

>
> Shiraz
