Return-Path: <linux-rdma+bounces-4633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DB9643E3
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6783A287B3D
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEC319413D;
	Thu, 29 Aug 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="COJdahzx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2288191F82
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933107; cv=none; b=ZMeqYtHHw9YpSgWv2/1gmSxt9S8HRKD/B+WRHBsU06J9fg3pB6RLGAKBfd4/w77DbHqy7/BcKNluwweJWn3fIueP90/2wESF5pycxZs4woRVsdmPf35lBBzW7T+5FAazM8VJ1UzAuSeTeZx7/yk6Eil+u/mq06YmtDVb1OXA1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933107; c=relaxed/simple;
	bh=sURMtzuV0ZrU8K7+aftkHR7/JR+cvtBsjFKF3I6Pios=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QDQodvMypDZbWmy0GVehDPF0q9iRoghu8JquWEPzMTQYBvsUhuJ2uB+oYBKpieE/3BOf36apEhH9Ozseuq0u7mOXAKT5mCFfpjJnjCjRswaVDlLmQcSO3z9KOyKeT+HJX8xmTKewvU9P9PceLFCyZkMHc4N8lrBvS0fP0xDXNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=COJdahzx; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34234a57-9553-4193-a855-ee1ebbea3d6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724933103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bH9C24zmmgRCb7/6azqdebeQn6ZBHHKKKffowbEd9Dk=;
	b=COJdahzx6NfKxtXt/DRPcvmCqzVEemh/YsrD96kCx2XyPOPines01uWs6rfis9GYqkFnjt
	3SGCn8pVXeUP43+H/9+j8e7YKWsuWzJ/MGzpqTA68Ty2BmYVK72EbVayOkv8t9QXNNiug/
	rnqP0Er+dQiuP/MOyAqlRDtaOZ9L/GU=
Date: Thu, 29 Aug 2024 20:04:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re=3A_=5Bbug=5D_rdma-core/librdmacm/cma=2Ec_rdma=5Fcreate?=
 =?UTF-8?B?X3FwX2V4w6/CvGFkZCBpZC0+Y3EgcmVmZXIgdG8gcXBfYXR0ci0+Y3EsIHdoZW4g?=
 =?UTF-8?Q?qp=5Fattr-=3Ecq_is_not_NULL=2C_and_id-=3Ecq_is_NULL?=
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, =?UTF-8?B?6Z2z5paH5a6+?=
 <jinwenbinxue@163.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
 <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/28 8:51, Zhijian Li (Fujitsu) 写道:
> Not related to your modification,
> 
> In general,
> - Please report a bug with more details, such as how to reproduce, your expectations and what's the impact, etc...
> - Please follow the patch submit instruction[1] or a PR if you want to submit a patch to the communities.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html

It seems a rdma-core problem. Not sure if it is reasonable to use the 
above link.

Zhu Yanjun

> 
> 
> On 27/08/2024 14:20, 靳文宾 wrote:
>>
>>
>>
>>
>>
>> I think the following modification is more correct,
>> if there have something i dont know, pls tell me, thx
>>
>>
>>
>>
>>
>> diff --git a/librdmacm/cma.c b/librdmacm/cma.c
>> index 7b924bd0d..9e71ba858 100644
>> --- a/librdmacm/cma.c
>> +++ b/librdmacm/cma.c
>> @@ -1654,10 +1654,20 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
>>           if (ret)
>>                   return ret;
>>
>>
>> -       if (!attr->send_cq)
>> +       if (!attr->send_cq) {
>>                   attr->send_cq = id->send_cq;
>> -       if (!attr->recv_cq)
>> +       } else {
>> +               if (!id->recv_cq)
>> +                       id->recv_cq = attr->recv_cq;
>> +       }
>> +       if (!attr->recv_cq) {
>>                   attr->recv_cq = id->recv_cq;
>> +       } else {
>> +               if (!id->recv_cq)
>> +                       id->recv_cq = attr->recv_cq;
>> +       }
>> +
>> +
>>           if (id->srq && !attr->srq)
>>                   attr->srq = id->srq;
>>           qp = ibv_create_qp_ex(id->verbs, attr);
>>
>>
>>
>>


