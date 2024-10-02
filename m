Return-Path: <linux-rdma+bounces-5180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E355698D348
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB62228336C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FC1CF7D1;
	Wed,  2 Oct 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ly6viJMu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D142EB1D
	for <linux-rdma@vger.kernel.org>; Wed,  2 Oct 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872246; cv=none; b=uM0nFMKQV3pNNCoDNOLlRHikwiG6E7Raeb3sn16ZS5AGAjrH2sqiscGMzmgKWqLzf8e3wWS1kvp4pxgcM+Q0IOrA5Ii6QX84jI6ZbFTH01P3hQhP07il2C1ovt2XQs+KUSt3yZAkG9RdXsCi9oI0MpYZDtuhVPHUBAE1tIzpItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872246; c=relaxed/simple;
	bh=VJDXB8Z2oGEULIwOPnkHIgc2ukLaSkTajrZf4Qs3br4=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SqK+4+hDb7tEKavBM0oK7Oq+Gl6DqyDMIfn+viqlVtfWUWaaMunwFjiC/dPeAsNx7ZaIz1ZjpZgfjIk2mEXDxKpoXBVXJWgKTHD+8mYKTHGyvvGHGVNSoM/d7vbj++ZPqquPidXGYDdyi9ZbCYySlG40VLo0DwIX3qSkpQWbUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ly6viJMu; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727872245; x=1759408245;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=wUUNb33AVkzx25jxAF1z5uhyDt/ssFWcN/nhg/Vc9DE=;
  b=Ly6viJMuamlHSZ3puUBIwABkIgNOwTc6oe8JkT3sfA66ZY/TMCKgki58
   lscAKTAKTTejxv8WePSHB/blbOJV27HQdnVd3EQ6aMQBNtsySYIctihx+
   ihE6Tp+WfPKaYXi3jJTL/qLATcbVtTDBW8n9tyKS8m4Au/MzI5crpg+bS
   c=;
X-IronPort-AV: E=Sophos;i="6.11,171,1725321600"; 
   d="scan'208";a="236151142"
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:30:42 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:41909]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.93:2525] with esmtp (Farcaster)
 id 6134564b-2511-4165-a495-58669f31b1cb; Wed, 2 Oct 2024 12:30:40 +0000 (UTC)
X-Farcaster-Flow-ID: 6134564b-2511-4165-a495-58669f31b1cb
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 12:30:39 +0000
Received: from [192.168.145.55] (10.85.143.176) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 12:30:35 +0000
Message-ID: <e9f442c6-cf22-4772-9aee-e2e36f4d2029@amazon.com>
Date: Wed, 2 Oct 2024 15:30:30 +0300
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
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
 <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
 <20240926145423.GB9417@nvidia.com>
 <08cf6d96-02f0-4974-ac69-b9a5184bfb20@amazon.com>
 <20240926223400.GS9417@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240926223400.GS9417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 9/27/2024 1:34 AM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Sep 26, 2024 at 11:03:57PM +0300, Margolin, Michael wrote:
>> On 9/26/2024 5:54 PM, Jason Gunthorpe wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, Sep 26, 2024 at 04:25:19PM +0300, Margolin, Michael wrote:
>>>
>>>> Actually that's wrong, the device always sets guid in BE order so no
>>>> swap is needed in the driver in any case.
>>> They you just mark it as _be64 in the struct and there is no reason
>>> for the __force ?
>>>
>>> Jason
>> That's probably the most correct way but I prefer to avoid introducing
>> kernel specific types in a shared interface file.
> ?
>
> what is a "shared interface file" ?
>
> That doesn't sound like a linux thing
>
> Jason

Nothing particularly related to linux, just a common practice of having 
the same interface on both sides (driver and device in this case).

Michael


