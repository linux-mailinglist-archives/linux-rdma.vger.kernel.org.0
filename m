Return-Path: <linux-rdma+bounces-590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D474F8296CE
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8468C289FB2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B453F8D4;
	Wed, 10 Jan 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ok9kMP5U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68843F8D2
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jan 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704880861; x=1736416861;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=f7ftmcd1YCXCUjPsXYvF0wf+1htNOqqlSdiSjHfIrek=;
  b=ok9kMP5UNlq0c/IJJntha+/LhhUCR1jaY3u2TlaBap6glrxPxFJ2PawE
   ybINDqRKAhtNXVI/BBElW1rVcyoopY75S7SOCLjbR+H4SNncyPxY4G0/l
   z2oQ2N9LysIaeMYpJPy5vTe0es0KgWaagl/1NFkW7IpOHibq5D4gqof0S
   w=;
X-IronPort-AV: E=Sophos;i="6.04,184,1695686400"; 
   d="scan'208";a="388821809"
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 10:00:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id C3E8480E7D;
	Wed, 10 Jan 2024 10:00:50 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:34154]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.189:2525] with esmtp (Farcaster)
 id 2789ee24-d884-44ed-a2c2-c8d5fd289b86; Wed, 10 Jan 2024 10:00:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2789ee24-d884-44ed-a2c2-c8d5fd289b86
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 10:00:49 +0000
Received: from [192.168.135.165] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 10:00:46 +0000
Message-ID: <d426646b-9618-4316-8e3f-8943b836cf3a@amazon.com>
Date: Wed, 10 Jan 2024 12:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Anas Mousa <anasmous@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal> <20240108130554.GF50406@nvidia.com>
 <20240108180140.GB12803@unreal> <20240108180636.GM50406@nvidia.com>
 <86765443-4292-44b4-824e-d2ea5ebebc18@app.fastmail.com>
 <20240109180523.GA7488@unreal>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240109180523.GA7488@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 1/9/2024 8:05 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Jan 08, 2024 at 09:40:32PM +0200, Leon Romanovsky wrote:
>>
>> On Mon, Jan 8, 2024, at 20:06, Jason Gunthorpe wrote:
>>> On Mon, Jan 08, 2024 at 08:01:40PM +0200, Leon Romanovsky wrote:
>>>>> I was saying in the rdma-core PR that this field shouldn't even
>>>>> exist..
>>>> Something like that?
>>> Yeah, like that. However it is difficult to get the out valid uattr
>>> back in the rdma-core side.
>>>
>>> This is best if the ID's can have well defined not-valid values such
>>> as 0 or -1.
>> Michael tried something like that in previous versions by defining 0xffff as not valid.
>>
>> I didn't like it because there's no promise from PCI core that it is invalid value.
> Michael,
> What do you think?
>
> Thanks

In this case I prefer to keep the explicit validity for consistency with
the device originated values.

In general I think it will be useful to have some convenient way to get
attr validity from the ioctl mechanism in rdma-core.

Michael


