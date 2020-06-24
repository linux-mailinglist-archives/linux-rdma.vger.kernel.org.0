Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E0206D6D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 09:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbgFXHUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 03:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFXHUI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 03:20:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA64C061573
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 00:20:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so1360680ejd.13
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xQXxSxInlv1hYmHyFvXnuvd28mgsMDNfsDY1aPqKgxA=;
        b=sqV3cIvbs2/AYA1zbQYA7m8sghFxVmFl3hKNF3CFRHgj9rEQFC3sT3VNxZ7/pomTpb
         BxoPHegNQ/XYIvw/b1/Hf7p/EvOgBg/LkhVty/MpdvQWwIc4tpCjNxWZSkBI7/8RJMh6
         BM5dHWazEtFK8OD38cNjQqpgvpyjz9xCjhPW26D8vaEThEIM9Xtyg1D07S8ZA7+HqBXL
         2IxkiWDSujPV1bcwEwW3fDozRAoiftKSCXgtMkJFBD0jQsluTPvd4/fBmyskZigH/pPV
         hwFoXD8qRLS93Q9a6ko37dMQmHhOBD4Bu13Id6gPecFEZJ7dD9DgPxieWf2HeA5yCj9x
         vDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQXxSxInlv1hYmHyFvXnuvd28mgsMDNfsDY1aPqKgxA=;
        b=D8N1eFXhDrDXTtatQOEcOsb/vxSDyykcvlhZ229zGkkHwlRIveEoNxw6B5fn0rXjXl
         ccFIuYvr1KgA0+FwuYfwXauA+Y5UWVhk/cynCJZYpW/kGswsNHNpcyhAGGqCcjzJFMoC
         rxi9zrGSOdZAA9cdIYhoSkz+RIJpCuRDe3RzZySQIsxagcRCaEXYMFUwcOCqSLX2dgTD
         M7taKuQ2AlqtdYJIWHKhV8KImHnwUDLowhyW+szbZb78KMcHRAxYw8F4wwDKexORdYvK
         vLmjan+41ESIGuhGEavM1IiqaISO27gkrBtxxKuJWd2xlyjvLWF9UpoildpcjdrXCWYy
         diBg==
X-Gm-Message-State: AOAM530bMhka5aT5M2uSAQabfAD1rdGdJ7t/Sq5pWsmPAxO2mvAEfM79
        t6cDInRYcuVUZP0vOh7e3PcrDCvSkdY=
X-Google-Smtp-Source: ABdhPJzJujPZiP9Rj1s5qTjwwgtlD21/WuKz5d5++CWE+/lTvpW7wni2ExDPLBBYbkUHEt8xMiK0tg==
X-Received: by 2002:a17:906:3154:: with SMTP id e20mr24643793eje.171.1592983206596;
        Wed, 24 Jun 2020 00:20:06 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id dt22sm15687108ejc.104.2020.06.24.00.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 00:20:06 -0700 (PDT)
Subject: Re: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR
 verbs
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
 <20200619125003.GW65026@mellanox.com>
 <7923c6bc-d11a-e86f-02de-7da530c9e596@dev.mellanox.co.il>
 <20200623173324.GK2874652@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <982624ee-87ad-4205-b297-2bc1d285b822@dev.mellanox.co.il>
Date:   Wed, 24 Jun 2020 10:20:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623173324.GK2874652@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/23/2020 8:33 PM, Jason Gunthorpe wrote:
> On Sun, Jun 21, 2020 at 11:44:52AM +0300, Yishai Hadas wrote:
>> On 6/19/2020 3:50 PM, Jason Gunthorpe wrote:
>>> On Wed, Jun 17, 2020 at 10:45:53AM +0300, Yishai Hadas wrote:
>>>> Implement the import/unimport MR verbs based on their definition as
>>>> described in the man page.
>>>>
>>>> It uses the query MR KABI to retrieve the original MR properties based
>>>> on its given handle.
>>>>
>>>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>>>>    libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
>>>>    libibverbs/driver.h          |  3 +++
>>>>    libibverbs/libibverbs.map.in |  1 +
>>>>    providers/mlx5/mlx5.c        |  2 ++
>>>>    providers/mlx5/mlx5.h        |  3 +++
>>>>    providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
>>>>    6 files changed, 68 insertions(+)
>>>>
>>>> diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
>>>> index cb729b6..6984948 100644
>>>> +++ b/libibverbs/cmd_mr.c
>>>> @@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
>>>>    		return ret;
>>>>    	return 0;
>>>>    }
>>>> +
>>>> +int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
>>>> +		     uint32_t mr_handle)
>>>> +{
>>>> +	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
>>>> +			     UVERBS_METHOD_QUERY_MR,
>>>> +			     5, NULL);
>>>> +	struct ibv_mr *mr = &vmr->ibv_mr;
>>>> +	uint64_t iova;
>>>> +	int ret;
>>>> +
>>>> +	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
>>>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
>>>> +			  &mr->lkey);
>>>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
>>>> +			  &mr->rkey);
>>>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
>>>> +			  &mr->length);
>>>> +	/* The iova may be used down the road, let's have it ready from kernel */
>>>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
>>>> +			  &iova);
>>>
>>> There isn't much reason to fill the attribute here..
>>>
>>
>> We have defined this attribute from kernel perspective to be mandatory from
>> day one as of other attributes above.
>> Are you suggesting to change in kernel to let this attribute be optional and
>> not fill it here ? other alternative ?
> 
> I'm not sure output attributes should be marked as mandatory?
> 

Looking in kernel side, the semantics in most of the cases including for 
other MR method [1] which returns lkey & rkey as of this method is to 
define the output attributes as mandatory. When used, it may point that 
from API point of view it makes no-sense to not return those attributes 
back to user as them are really mandatory. (see also other examples, as 
of port_num for UVERBS_METHOD_QUERY_PORT, QP, SRQ, CQ output fields, 
DEVX usage, etc.).

However, In case an attribute is not a spec mandatory (e.g. SRQN for non 
XRC case) or that application can work in some way without having it 
(e.g. 'core_support' for UVERBS_METHOD_GET_CONTEXT) it's defined an 
optional.

As this IOVA attribute is currently not really in use, I believe that we 
can set it in kernel as an optional while leaving other attributes for 
this API (e.g. rkey, lkey, etc.) to be mandatory and cleanup here its 
setting.

Makes sense ? if yes, I'll go by that approach and send V1 in kernel 
side for that change.

[1] 
https://elixir.bootlin.com/linux/v5.3-rc7/source/drivers/infiniband/core/uverbs_std_types_mr.c#L196

Yishai
