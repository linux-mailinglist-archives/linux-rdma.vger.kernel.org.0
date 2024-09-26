Return-Path: <linux-rdma+bounces-5112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FC987468
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91DE1C22B1E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC21CAB8;
	Thu, 26 Sep 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hNyXWDA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6845038
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357133; cv=none; b=WXuAjTABh/QURwcu1W+oQcjxtiRiGTbkQ1NEwQpsBWEyI92gUAIJwtiI1PviMXJtWRqqa55FRA+cEC2eV8uNYx9Y0R5ZqAxszqnlJjWnUUiqFdiSwERzPlzNyq/93K42V24eqr6e7DSKIVvARklHbgSJgSULy1n34QycF3fWCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357133; c=relaxed/simple;
	bh=OslnV8ow3aEoY5EqJlFHpRjfvIRhRQgyBRJUjrWrYAE=;
	h=Subject:Message-ID:Date:MIME-Version:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DELeTfzh5nSAomVwmfOhgMRLWY/ZgP6BYZ9fAxJDu+MSd6/BuG1iUJn6uFOYqAlJkHZZMDeh6x6s2WrsmplnwaxL8NHO4gWTgcN3x2sheuUk/k+EpVAywTQnX84G9wrkPLPIYcvqCAEvr32Qb9Wi7E5NW4jlOM/bKFOsYnki4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hNyXWDA1; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727357132; x=1758893132;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=Eec2DETW/1iYUOJJHMJKbsznD2l+0QARLxNQ2eC0koE=;
  b=hNyXWDA1M+eKiJ+Nn0UpEecgszN51+Q+i2CBzQK2M+am87Uj9xjGwxwS
   NRmr6/hzSPiTMvykCHSANjDlCB48xlTnLw/fYt25FzpMEIueVFyMj8lHS
   pLaduexk8LrU0Mjcu7QPQrlHihKy5GfTENo7GVFePPNVDXM2Alyy/0DJe
   4=;
X-IronPort-AV: E=Sophos;i="6.11,155,1725321600"; 
   d="scan'208";a="430582056"
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 13:25:29 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:24539]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.159:2525] with esmtp (Farcaster)
 id a3ab0278-9c22-44f4-b432-2cec63694161; Thu, 26 Sep 2024 13:25:28 +0000 (UTC)
X-Farcaster-Flow-ID: a3ab0278-9c22-44f4-b432-2cec63694161
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 13:25:28 +0000
Received: from [192.168.80.200] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 13:25:24 +0000
Message-ID: <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
Date: Thu, 26 Sep 2024 16:25:19 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Margolin, Michael" <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, kernel test robot
	<lkp@intel.com>, Yehuda Yitschak <yehuday@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
Content-Language: en-US
In-Reply-To: <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 9/26/2024 3:56 PM, Margolin, Michael wrote:
> On 9/24/2024 9:00 PM, Jason Gunthorpe wrote:
>
>> CAUTION: This email originated from outside of the organization. Do 
>> not click links or open attachments unless you can confirm the sender 
>> and know the content is safe.
>>
>>
>>
>> On Tue, Sep 24, 2024 at 12:16:03PM +0000, Michael Margolin wrote:
>>> The GUID is received in big-endian so align types accordingly to avoid
>>> compiler warnings.
>>>
>>> Closes: 
>>> https://lore.kernel.org/oe-kbuild-all/202409032113.bvyVfsNp-lkp@intel.com/
>>>
>>> Fixes: 04e36fd27a2a ("RDMA/efa: Add support for node guid")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
>>> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
>>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>>> ---
>>>   drivers/infiniband/hw/efa/efa_com_cmd.c | 2 +-
>>>   drivers/infiniband/hw/efa/efa_com_cmd.h | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c 
>>> b/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> index 5a774925cdea..5754da4e6ff8 100644
>>> --- a/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
>>> @@ -465,7 +465,7 @@ int efa_com_get_device_attr(struct efa_com_dev 
>>> *edev,
>>>        result->db_bar = resp.u.device_attr.db_bar;
>>>        result->max_rdma_size = resp.u.device_attr.max_rdma_size;
>>>        result->device_caps = resp.u.device_attr.device_caps;
>>> -     result->guid = resp.u.device_attr.guid;
>>> +     result->guid = (__force __be64)resp.u.device_attr.guid;
>> That can't be right, use the proper conversion function, or the proper
>> type..
>>
>> Jason
> The current assumption in the driver is that data from the device 
> arrives in a correct byte order for the CPU, while the guid field is 
> in reversed order.
>
> Would you suggest doing something like:
>
>> -     result->guid = resp.u.device_attr.guid;
>> +     result->guid = __cpu_to_be64(__swab64(resp.u.device_attr.guid));
>
> Michael
>
Actually that's wrong, the device always sets guid in BE order so no 
swap is needed in the driver in any case.

