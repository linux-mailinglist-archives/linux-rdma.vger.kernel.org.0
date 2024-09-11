Return-Path: <linux-rdma+bounces-4868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78079747D1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69929288D44
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD2B1F94D;
	Wed, 11 Sep 2024 01:34:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983520B0F;
	Wed, 11 Sep 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018472; cv=none; b=mCE0KiCNppTqi1SfuPoGT1jsoosPQecrc1D8fL8ZtVwBT2SW48esl/80pHjSR8ASQVur8GFtm3teLlHewOKaULdaDDnTCZN3yCX4NMfVbX0pkcQVWftVhTS4wD4wLTfHPyLdJjj/yVURd6snviZiZCYiNHJY6Uuc1RB7Dimnb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018472; c=relaxed/simple;
	bh=E4n8hVRYdle1IsmTUXIhxE0J57haaa1Xa7brDvP3xy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=saKZ9NeEC/Br8jAEW2bbO3yw7QTH+OXL1J5G9d5y4RwZ3xKHy0FICFBdde7Tysn9nGVwxuXXhZpJYfRKOyxCUDtdslslT7mHQnxAHhRoopEIvDRZGRX5Ii87/0brkm/WcB/k2NYcjaagDOd5P5sgTlCrx7xYYOc4d/RJT5rpJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3NLY5tb0z1HJC2;
	Wed, 11 Sep 2024 09:30:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 88ED1180042;
	Wed, 11 Sep 2024 09:34:20 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 09:34:20 +0800
Message-ID: <4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com>
Date: Wed, 11 Sep 2024 09:34:19 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 3/9] RDMA/hns: Fix cpu stuck caused by printings
 during reset
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-4-huangjunxian6@hisilicon.com>
 <20240910130946.GA4026@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240910130946.GA4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/10 21:09, Leon Romanovsky wrote:
> On Fri, Sep 06, 2024 at 05:34:38PM +0800, Junxian Huang wrote:
>> From: wenglianfa <wenglianfa@huawei.com>
>>
>> During reset, cmd to destroy resources such as qp, cq, and mr may
>> fail, and error logs will be printed. When a large number of
>> resources are destroyed, there will be lots of printings, and it
>> may lead to a cpu stuck. Replace the printing functions in these
>> paths with the ratelimited version.
> 
> At lease some of them if not most should be deleted.
> 

Hi Leon,I wonder if there is a clear standard about whether printing
can be added?

Thanks,
Junxian

> Thanks

