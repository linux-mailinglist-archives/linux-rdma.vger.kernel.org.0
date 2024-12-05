Return-Path: <linux-rdma+bounces-6258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C09E4C85
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F90283E0F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79055183CCA;
	Thu,  5 Dec 2024 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T7T50QX8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC779DC
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367300; cv=none; b=kyFX4nk/wrAafXLXpQiGajpTsLmeiSPp+RVoL85algqK7YbjXaZIpD+OZALEhZbj2ik/L4T28J7K/IHdVVe1/XeM/mACwYZfF7puOHQIKMDiFULnQ4dS8jiwY4kYsdT0hyhk8xQ7MxoBZeUyzkJ3bV7/p8Kpsv4fGqXPK9wSi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367300; c=relaxed/simple;
	bh=mIfDbINLSoTYr4zImkEtDVjLSTZhY76NJWGSj3D4hls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJRKDS7zshWbb/fa2dJNYEfctaMSGxSxyRlWIA5ODM8SMS9NQoQ9Q2fkHzv/UK2bE7vojKDCXOktgYR/zAVlAtrhjqAtpPLR95UnCABl79uR2bOw3uKEE0D/QWBoxhKJ4iNCIpppcblN0XG/PVekTukJsLocgz/Prca2P+QyYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T7T50QX8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733367295; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gwokBYlz74FXROMe54dusjpHwFOFjA9eZoJG+Y70AZE=;
	b=T7T50QX8/kuGG3vwcTlNYPg854RNBwjrNUpWHwGnI8rzSpL5RZNW5iWBa5+xvd0333xFHh9U4Wx4TT4PKJ6gO3B/A6fSF9C0+4uQpul34HQQpRW/OyM+QlZmYjPq4vM48QohbpqigJFpI5xX9eiaeuEjH/p1+DzMxcr/O2EisQc=
Received: from 30.221.116.17(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKrXGrU_1733367294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 10:54:54 +0800
Message-ID: <c20497ea-8fa0-4536-84f3-af19444c0c83@linux.alibaba.com>
Date: Thu, 5 Dec 2024 10:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 4/8] RDMA/erdma: Add address handle
 implementation
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
 chengyou@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-5-boshiyu@linux.alibaba.com>
 <20241204141102.GP1245331@unreal>
From: Boshi Yu <boshiyu@linux.alibaba.com>
In-Reply-To: <20241204141102.GP1245331@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/4 22:11, Leon Romanovsky wrote:
> On Tue, Nov 26, 2024 at 02:59:10PM +0800, Boshi Yu wrote:
>> The address handle contains the necessary information to transmit
>> messages to a remote peer in the RoCEv2 protocol. This commit
>> implements the erdma_create_ah(), erdma_destroy_ah(), and
>> erdma_query_ah() interfaces, which are used to create, destroy,
>> and query an address handle, respectively.
>>
>> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma.h       |   4 +-
>>   drivers/infiniband/hw/erdma/erdma_hw.h    |  34 ++++++
>>   drivers/infiniband/hw/erdma/erdma_main.c  |   4 +
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 135 +++++++++++++++++++++-
>>   drivers/infiniband/hw/erdma/erdma_verbs.h |  28 +++++
>>   5 files changed, 203 insertions(+), 2 deletions(-)
> 
> <...>
> 
>> +static void erdma_av_to_attr(struct erdma_av *av, struct rdma_ah_attr *attr)
>> +{
>> +	attr->type = RDMA_AH_ATTR_TYPE_ROCE;
>> +
>> +	rdma_ah_set_sl(attr, av->sl);
>> +	rdma_ah_set_port_num(attr, av->port);
>> +	rdma_ah_set_ah_flags(attr, IB_AH_GRH);
>> +
>> +	rdma_ah_set_grh(attr, NULL, av->flow_label, av->sgid_index,
>> +			av->hop_limit, av->traffic_class);
>> +	rdma_ah_set_dgid_raw(attr, av->dgid);
>> +}
> 
> <...>
> 
>> +int erdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
>> +{
>> +	struct erdma_ah *ah = to_eah(ibah);
>> +
>> +	memset(ah_attr, 0, sizeof(*ah_attr));
>> +	erdma_av_to_attr(&ah->av, ah_attr);
> 
> This function is used only once and in this file. There is no need to
> create useless indirection. The same comment applicable to other
> functions as well.
> 
> Thanks

Hi, Leon,

Thank you for your suggestion. We will fix the problem in the patch v2.

Thanks,
Boshi Yu



