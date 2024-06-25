Return-Path: <linux-rdma+bounces-3476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3C91662F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 13:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDD01C21743
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E014A619;
	Tue, 25 Jun 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RStL0QbY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24499149C4C
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314919; cv=none; b=XQIHoA6EUMHAgI88n6Oz9mjZNcFZBhYdk26Ar+RLT+yMki6tAQ9/S37gYM3XdX4Et4H36+fbZGpOVxo0QRuYa96u+VkpH0ur0liAdKpan4CSZZLrIC1u1XNSTy8CwtqmuNAatYZGH/qMrqTQPnNB6ZWB7H4ZAiNs0utYZ7Q5pls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314919; c=relaxed/simple;
	bh=JRJMb8trIjNg03cm4j50RD1VcdhPH1VJoAebm9sbGf8=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FMahGfrzkrFhPhbBVZEaleAIlXq16X/+f2hir/qXYjPOQlyrOhRyx8nmZcD84a4Ys9RUQmKIg1B5IUG0h8l8Fssqtc/ovb5Ib/t0nE7Fg5GswUOtYaU60AkIw0Db9tZfJvdy1z0RAC+vlbOl7M726qT39Xuxki3Dcj5E9SDd1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RStL0QbY; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719314918; x=1750850918;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=W1xjvIPQ9cJvxreJWBWNRlt4CS8i/Fcln6axZShz4Qo=;
  b=RStL0QbYhXbr8S1tZ9ORJK+alQC+Cds/QpHrgSmrzb4//WoNS+JcWQ06
   KRHTWoDBVBbWs+yK9jAfhFT1qgKrm9mpCbgsQ6ZnCzninh/hlcP9/T7nh
   A3KqGbO5pc3t2A4L0fxB9YS6jtbDzp8Ol/UGe4RkJcNOBof7iaUT8ixb2
   4=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="641525854"
Subject: Re: [PATCH for-next 3/5] RDMA/efa: Validate EQ array out of bounds reach
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:28:35 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:12671]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.217:2525] with esmtp (Farcaster)
 id bfcc38a4-2c1e-4ac7-9842-d77cee374399; Tue, 25 Jun 2024 11:28:33 +0000 (UTC)
X-Farcaster-Flow-ID: bfcc38a4-2c1e-4ac7-9842-d77cee374399
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:28:32 +0000
Received: from [192.168.71.82] (10.85.143.173) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:28:29 +0000
Message-ID: <eab3899b-25b8-4e4f-8c85-38188a30a6d8@amazon.com>
Date: Tue, 25 Jun 2024 14:28:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-4-mrgolin@amazon.com>
 <bfd4cbb0-baee-4762-a0d3-8734df36e3d0@linux.dev>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <bfd4cbb0-baee-4762-a0d3-8734df36e3d0@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 6/25/2024 9:33 AM, Gal Pressman wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 24/06/2024 19:09, Michael Margolin wrote:
>> From: Yonatan Nachum <ynachum@amazon.com>
>>
>> When creating a new CQ with interrupts enabled, the caller needs to
>> specify an EQ index to which the interrupts will be sent on, we don't
>> validate the requested index in the EQ array.
>> Validate out of bound reach of the EQ array and return an error.
>>
>> This is not a bug because IB core validates the requested EQ number when
>> creating a CQ.
> Then why is this patch needed?

Mainly as best practice of validating the index right before array 
access to avoid hard to catch bugs.

Michael


