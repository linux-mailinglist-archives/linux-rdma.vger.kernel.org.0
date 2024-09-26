Return-Path: <linux-rdma+bounces-5111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CF9873EF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711261C22C63
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431F18B1A;
	Thu, 26 Sep 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G1wnzP8Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9DEEB7
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355411; cv=none; b=SqmHN8ZqhbiidkHybFn7Ygu1kCdBZCNOmZEO7ldnWAF50igF7ArgSlVE6VT7/i9by6/RjzhLNTcHM/xBKSAkoKFqyF/lFlKWPgEHjSMJcwELCCBiurFF1WQynf1ZfajyTrYW7z9r4hLrxxoBxC9qYQd+Rk5UR3kLR/f4lc5wRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355411; c=relaxed/simple;
	bh=stb7J0GudKWn9sb+uhM0LqNrzmvRr1XIZd4GT+1xY4U=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=meCKrT2mzlJd/6/DBAfcwOS2a3wWbNKxYW6qAWHe78xlIkMZLcKq/JDm745VQmqN565tXpkLecrwXEEApL88uXiRuGePtLC6AO2GGF0BLPvU6CIyRbK/HIv1YdjYcJv1OI5bqvfGk+dBXKTYfXXQ7uulqUK8DKjMlFV8ddn3bWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G1wnzP8Z; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727355411; x=1758891411;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=pWlRWr46R/ox/Azvt4oqnRI8Ezwy510qSyHgxx7Y2/8=;
  b=G1wnzP8ZBby/fzKQKRSwV6wy+Mq5k6Fkk5+wHWOrkgpfILCo7tFaMckE
   PDt7r5nZ4aDe1n4W6V88m1h98xHkQ1DqDCYokPy1qKpw31YRYe5Uvbxy9
   V9+KPVEEvTruhXneNukq8vL4NQnxIzx3EH9BQ3V9tau0pUzF7QUZ87mQH
   M=;
X-IronPort-AV: E=Sophos;i="6.11,155,1725321600"; 
   d="scan'208";a="764184762"
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:56:43 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:15567]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.76:2525] with esmtp (Farcaster)
 id f5c0697d-4418-4dbc-bf6c-e688b1d33918; Thu, 26 Sep 2024 12:56:40 +0000 (UTC)
X-Farcaster-Flow-ID: f5c0697d-4418-4dbc-bf6c-e688b1d33918
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 12:56:40 +0000
Received: from [192.168.80.200] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 12:56:36 +0000
Message-ID: <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
Date: Thu, 26 Sep 2024 15:56:31 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, kernel test robot
	<lkp@intel.com>, Yehuda Yitschak <yehuday@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240924180030.GM9417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

On 9/24/2024 9:00 PM, Jason Gunthorpe wrote:

> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Sep 24, 2024 at 12:16:03PM +0000, Michael Margolin wrote:
>> The GUID is received in big-endian so align types accordingly to avoid
>> compiler warnings.
>>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409032113.bvyVfsNp-lkp@intel.com/
>>
>> Fixes: 04e36fd27a2a ("RDMA/efa: Add support for node guid")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
>> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>   drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
>>   drivers/infiniband/hw/efa/efa_com_cmd.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
>> index 5a774925cdea..5754da4e6ff8 100644
>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
>> @@ -465,7 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
>>        result->db_bar = resp.u.device_attr.db_bar;
>>        result->max_rdma_size = resp.u.device_attr.max_rdma_size;
>>        result->device_caps = resp.u.device_attr.device_caps;
>> -     result->guid = resp.u.device_attr.guid;
>> +     result->guid = (__force __be64)resp.u.device_attr.guid;
> That can't be right, use the proper conversion function, or the proper
> type..
>
> Jason
The current assumption in the driver is that data from the device 
arrives in a correct byte order for the CPU, while the guid field is in 
reversed order.

Would you suggest doing something like:

>-     result->guid = resp.u.device_attr.guid;
>+     result->guid = __cpu_to_be64(__swab64(resp.u.device_attr.guid));

Michael


