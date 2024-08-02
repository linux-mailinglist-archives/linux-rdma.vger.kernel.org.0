Return-Path: <linux-rdma+bounces-4178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B012094563A
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 04:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B79E285F02
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0217BB7;
	Fri,  2 Aug 2024 02:09:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B997B67E;
	Fri,  2 Aug 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722564577; cv=none; b=iyzLCNYOUQGDCFX0gYj/1gzaaeYf8aFRFWzsnyTSJ/zr8Vp0gPFRHbDNDZAwNoXG2Fg+CJU+YpfXa4nFBTwW+hFG3zsCuMa3FI7Zyygs0ElmRwm+hMb+xqOj7fkMt21x6SUuri1ZjBQBicEV2ipqiVjXN2iZbUGGZqMdBUM8VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722564577; c=relaxed/simple;
	bh=lBhZS0fo/JCrcwS6Q+2SKuWPoJJtuygpwYMcSBth6xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Erioi0ITRofiMBl/Nrvt9u1lQ0dtVcFmu0csMzj79WpurmGNCFRQsrY3OfGXmgLWBVe/615SYS0T3gQOOMIjQWinaEXpic4aSvNkuw9G7kyrGP/OFh8EmthMhE6H48qAHnm3gN1THKxFo/rV5ad4FwV7eTqeH0YDVEr3tqNfRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WZq0R0PRFz1j6Dl;
	Fri,  2 Aug 2024 10:04:55 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E86BA1A0188;
	Fri,  2 Aug 2024 10:09:30 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Aug 2024 10:09:30 +0800
Message-ID: <d7735944-76ab-065d-dbcd-796087ae3f8d@hisilicon.com>
Date: Fri, 2 Aug 2024 10:09:29 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<nab@risingtidesystems.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>
References: <20240801123253.2908831-1-huangjunxian6@hisilicon.com>
 <98763329-897a-4f91-ab08-62bbd6afc8ec@acm.org>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <98763329-897a-4f91-ab08-62bbd6afc8ec@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/8/2 0:20, Bart Van Assche wrote:
> On 8/1/24 5:32 AM, Junxian Huang wrote:
>> Besides, exchange the order of INIT_WORK() and srpt_refresh_port()
>> in srpt_add_one(), so that when srpt_refresh_port() failed, there
>> is no need to cancel the work in this iteration.
> 
> The above description is wrong. There is no need to cancel work after
> INIT_WORK() has been called if the work has never been queued. Hence,
> moving the INIT_WORK() call is not necessary.
> 

Well, inspired by your comment I looked into the code again and I think
perhaps this whole patch is not necessary.

I encountered this problem in 5.10 kernel, where ib_register_event_handler()
was called before the for-loop. But this bug has been fixed in the current
mainline, and the work won't be queued until the whole for-loop is finished.

Thanks,
Junxian

>> @@ -3220,7 +3221,6 @@ static int srpt_add_one(struct ib_device *device)
>>           sport->port_attrib.srp_max_rsp_size = DEFAULT_MAX_RSP_SIZE;
>>           sport->port_attrib.srp_sq_size = DEF_SRPT_SQ_SIZE;
>>           sport->port_attrib.use_srq = false;
>> -        INIT_WORK(&sport->work, srpt_refresh_port_work);
>>             ret = srpt_refresh_port(sport);
>>           if (ret) {
>> @@ -3229,6 +3229,8 @@ static int srpt_add_one(struct ib_device *device)
>>               i--;
>>               goto err_port;
>>           }
>> +
>> +        INIT_WORK(&sport->work, srpt_refresh_port_work);
>>       }
> 
> I don't think that this change is necessary.
> 
> Bart.
> 

