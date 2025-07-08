Return-Path: <linux-rdma+bounces-11964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D266AFCCD2
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0967B0554
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BFA2DECD2;
	Tue,  8 Jul 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LPlz2b67"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369672DECB3
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983100; cv=none; b=gub7uQPlGvFoYcog56ThaBxE7664raslEYAF7qWO4q88noAJNIbY4583SBI2wl7//2gbAgyfJTjfj6WVKxOflOMxDybzzjW5Gx976+kT/rvmQlq4CJhIP361QVgdMKnT+vh8f2PyfMtKiQCsnufcuvHZlxKto3cFCHDzLmGcr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983100; c=relaxed/simple;
	bh=Xm6BviRyHbWGkj9NkN7TKU3lIJZgy3NXNBJ/kb2mlH0=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fLsX7Kkr1kiNweAEXnxExIX5iAVjhABfU41Zu3UH7yu0J8sQsINz1jMVLFIEHFvuuHe2w5MsFmu+5gZo/9lTeKW2k9pkLaPcWqEFpHaOOX/W0u2ANZAdjUW0dbAKTw+6o8mClEBK5Mxq4zHNQzwPjcH2SQWQLzb2krTgflqvTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LPlz2b67; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751983099; x=1783519099;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=0O562Pwl/ropBXW/kvUK+MJHLDqwi99wwOASXQRj1qU=;
  b=LPlz2b67TyrdDK4gWy+lSdh9j31spz61EMa7ZzzQWdGud+oUdOyUhzB+
   bCkOzpGt2PjAne0WS35Htd456GFFO2RQ+jooBUtWUy0oqgYqDNwgqJGL8
   lrJebRKj/FLcPXPOlmaIEZt9Uz2NBuAkB6lzl78HZOOVbDiA49wwpY/ju
   pYUEMc9XewQUWLHacLiZURdVnIc6pWBP3YCDbMTeyzxdprzqMePkUl6zZ
   EVTRW5/i6QezLftmAjAd4QLQm2JszKCM0RxQDeaZNkkJCW4VjaPm9h7Y2
   vOhe649TmDxLEegr+ynK4CEo8r2//EFqA607VWSYEyb/Aj2w+4oyYnwMX
   A==;
X-IronPort-AV: E=Sophos;i="6.16,297,1744070400"; 
   d="scan'208";a="315671130"
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 13:58:14 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:21709]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.138:2525] with esmtp (Farcaster)
 id 46ee311e-cf88-457d-a591-9aa09ddc6194; Tue, 8 Jul 2025 13:58:13 +0000 (UTC)
X-Farcaster-Flow-ID: 46ee311e-cf88-457d-a591-9aa09ddc6194
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 13:58:13 +0000
Received: from [192.168.122.16] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Jul 2025 13:58:03 +0000
Message-ID: <4f25d3c1-c32d-4a45-9db2-8b8e1602c698@amazon.com>
Date: Tue, 8 Jul 2025 16:57:58 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>, Gal Pressman <gal.pressman@linux.dev>
CC: Junxian Huang <huangjunxian6@hisilicon.com>, Leon Romanovsky
	<leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>, Bernard Metzler
	<bmt@zurich.ibm.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, Chengchang Tang
	<tangchengchang@huawei.com>, Cheng Xu <chengyou@linux.alibaba.com>,
	"Christian Benvenuti" <benve@cisco.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Edward Srouji
	<edwards@nvidia.com>, Kai Shen <kaishen@linux.alibaba.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, <linux-rdma@vger.kernel.org>, Long Li
	<longli@microsoft.com>, Michal Kalderon <mkalderon@marvell.com>, "Mustafa
 Ismail" <mustafa.ismail@intel.com>, Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, "Zhu
 Yanjun" <zyjzyj2000@gmail.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
 <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
 <20250708122943.GW1410929@nvidia.com>
 <d143ed1f-a4f1-4acf-978f-059101f3973d@linux.dev>
 <20250708131331.GY1410929@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250708131331.GY1410929@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/8/2025 4:13 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Jul 08, 2025 at 04:12:09PM +0300, Gal Pressman wrote:
>> On 08/07/2025 15:29, Jason Gunthorpe wrote:
>>> On Tue, Jul 08, 2025 at 09:03:12AM +0300, Gal Pressman wrote:
>>>> On 08/07/2025 5:27, Junxian Huang wrote:
>>>>> Could you change hns part as below? We have an error counter in the err_out label.
>>>> Same for EFA.
>>> Yuk, why?
>>>
>>> If we want to count system call failures it should not be done in
>>> drivers.
>> Why is this check different than others?
>>
>> EFA counts failures from incompatible udata/abi, or even
>> ib_copy_from_data() errors, isn't it similar?
> It is, and that is the Yuk. Drives shouldn't have counters for generic
> system call failures.
>
> Jason

IMHO if control reaches driver code, it isn't a generic system call failure.

Maybe we should find a way to check this in common code rather than 
handling in each driver.


Michael


