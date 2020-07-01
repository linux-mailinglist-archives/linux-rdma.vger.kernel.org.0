Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE017210B06
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgGAM23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgGAM22 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 08:28:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4ACC061755
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 05:28:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so24352747ejn.10
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IFTnudrh3vVKiozIEytnmg4rd+xAHR4SoULSKwREn/M=;
        b=HxzkJa152oierdratZN5oGsk3M0n0gPsO1rTz5Mo7r+Nl8+Tn6o5G5AmfAvN3D5Thq
         SlSzb1tXfWBpzsJommLEt+vi3/4gY+uF+AetWg2T6b+qIny6WVnDvclcoPmlwfyOMg99
         DHGExLhegkv1hRjJ5JEwuqf92x7doQ1emweZefOjd13hAtMITvf9FmKYhk3/kOHqjic+
         LV1jWHaj8EFEFhiN5o073xab4DPJxmb7Gwqd240RE7PXDyNQ5VzhcywM8PjtRzqN+nOs
         /1ndyyS3zvPDA8krzxr++PazJsedJrzcxCh692JZaHdt2l2BEUD4A6JlyaMIfysBx0Sl
         i5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IFTnudrh3vVKiozIEytnmg4rd+xAHR4SoULSKwREn/M=;
        b=QFpstOduxAogy9B3YzK/4P8GaWzy/WDpyo+y9iwmVh3aeZp3jDVZPaJnpshh3P88eq
         JSF8ECt2yRbJINPl6oy9cqKs65GRhDreWsYcY5fjuzUwl38Eonb8mOxmNxzmBxJxYBN6
         GmpYtGPVdmga4GBDQqUgzkFfJvulA2XA9ndzbTlP2LP6nDsckOykepkos8k1LVNZbgsW
         T0llph50mWrY6EQ0c+n3y2iehQBA+9hvSV/+Ps7n+XrNpcJeRvxWokeyTSyn/Svo5eDs
         7HddzrZGhB/bnKyv9IGmvQmh0bb9EOPVjO7qRUpR8czi/USp9wRxFeWLZFxBtrJ4PrgY
         aGyw==
X-Gm-Message-State: AOAM533G33I7wDUf31w1wOKqim0Ckg9Z7G4VaUL3/BhmB+L3QdwZTYXt
        8Wv+e1MF5U13qxeBSuKkLuWtfA==
X-Google-Smtp-Source: ABdhPJwY9ms4huNfTx07mnjqSiLKU2HrM/KWcXgGXznqA07g1kKqjRDh7xVBRJeNKRrlgiEwrUdVwQ==
X-Received: by 2002:a17:907:212b:: with SMTP id qo11mr22350801ejb.452.1593606507156;
        Wed, 01 Jul 2020 05:28:27 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id u2sm6370802edq.29.2020.07.01.05.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 05:28:26 -0700 (PDT)
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
Message-ID: <653b5832-c934-5460-1874-697809ff885d@dev.mellanox.co.il>
Date:   Wed, 1 Jul 2020 15:28:24 +0300
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

OK, this attribute was changed to be optional in V1 kernel series, the 
PR was updated to not fill this attribute at all, thanks.

Yishai
