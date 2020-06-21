Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962D02029B1
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgFUIo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 04:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbgFUIoz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Jun 2020 04:44:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76072C061794
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 01:44:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so14767751ejd.13
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vXghn8OZzXp+6loAMtl2MesAOQ8Ej0ZRmQwUh9IRAk=;
        b=YhT1KKY0N8Hgd7vTUUjPD0/gInPLMQx81u884mZnLeIFmZfAwKGMVxR7Tqpi3SQA+q
         buxYvyB89txbPMsUW8YicXM0kxeEVrgiEzSJoIlAyhbhywyvZpcwMbc7+AHSVJlQDL/6
         XEG+kwVh8298r3zf8IxTDNa9OvYFlpzOO02ctbAOnkZvuUbcwaFJcJz6CqloT+hXsQNm
         zzKaO1kf0qFFSphuBVThK1/AGfufl+FPbuREj6okVg3/VnfZOf6l/F5lzddfdf/+WCZH
         HjNicC+7QO7is99c0/GkpbY/rZU+OsGrubTLNQ3amdyIgh665njxItjQMfNtg9HjD1+O
         myRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vXghn8OZzXp+6loAMtl2MesAOQ8Ej0ZRmQwUh9IRAk=;
        b=f5YPUv+6BE43dAoRccKbgsDIOSmfkS9OLznQgCx8BPLbhRO7PCc9HrDV0Ym1p0iTWD
         7M4j77zhB6hVez1mwU/k8gK47ykzy69VCqoiJzfsNGc3Fe+M/E6GbpdPapJT7ahLAhdg
         i3teqCGi8Tf0o5TRIoai40BUlCaIe/hIY70LpbWHY2+mlLGsZlCdcOBtUFjUbBPaoBNZ
         JPtWmFWiMdbjvMt4z8sFgOZdd/7qHVTsrBEwkZ3ti9rK7zvsmMclyltBlirvui+/IeP9
         WSKHDF3KIrmFvluuLI00AuU8bflWtK1L9cqJXFLqnwivvKGJtx1V/Nka5xqC4NwKg59k
         dzEg==
X-Gm-Message-State: AOAM531WokGKiP+FswTw+ovBqJBelS/s8QGsjl/ZaaavE2qFxJVvOLRf
        soo4L6kA0CIm6wLdEq2uzQQHlgHNE6s=
X-Google-Smtp-Source: ABdhPJxb5I3leXvLLa0RcgX4Jc+gIhuMqfpLBHg4E56jpCpwP7ReBjtNisYeYKWNdWfeKklsOVGCtg==
X-Received: by 2002:a17:906:cb97:: with SMTP id mf23mr11985024ejb.468.1592729094013;
        Sun, 21 Jun 2020 01:44:54 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.189])
        by smtp.googlemail.com with ESMTPSA id l24sm450288edv.88.2020.06.21.01.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 01:44:53 -0700 (PDT)
Subject: Re: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR
 verbs
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
 <20200619125003.GW65026@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <7923c6bc-d11a-e86f-02de-7da530c9e596@dev.mellanox.co.il>
Date:   Sun, 21 Jun 2020 11:44:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619125003.GW65026@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/19/2020 3:50 PM, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 10:45:53AM +0300, Yishai Hadas wrote:
>> Implement the import/unimport MR verbs based on their definition as
>> described in the man page.
>>
>> It uses the query MR KABI to retrieve the original MR properties based
>> on its given handle.
>>
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>>   libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
>>   libibverbs/driver.h          |  3 +++
>>   libibverbs/libibverbs.map.in |  1 +
>>   providers/mlx5/mlx5.c        |  2 ++
>>   providers/mlx5/mlx5.h        |  3 +++
>>   providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
>>   6 files changed, 68 insertions(+)
>>
>> diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
>> index cb729b6..6984948 100644
>> +++ b/libibverbs/cmd_mr.c
>> @@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
>>   		return ret;
>>   	return 0;
>>   }
>> +
>> +int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
>> +		     uint32_t mr_handle)
>> +{
>> +	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
>> +			     UVERBS_METHOD_QUERY_MR,
>> +			     5, NULL);
>> +	struct ibv_mr *mr = &vmr->ibv_mr;
>> +	uint64_t iova;
>> +	int ret;
>> +
>> +	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
>> +			  &mr->lkey);
>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
>> +			  &mr->rkey);
>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
>> +			  &mr->length);
>> +	/* The iova may be used down the road, let's have it ready from kernel */
>> +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
>> +			  &iova);
> 
> There isn't much reason to fill the attribute here..
> 

We have defined this attribute from kernel perspective to be mandatory 
from day one as of other attributes above.
Are you suggesting to change in kernel to let this attribute be optional 
and not fill it here ? other alternative ?

Yishai
