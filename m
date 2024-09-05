Return-Path: <linux-rdma+bounces-4763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8696CD73
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 05:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662B5B21EDF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927D13D53F;
	Thu,  5 Sep 2024 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jxA3Dpci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAE539A
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507604; cv=none; b=GjYKEoeqHzmwZazegpOuYFge/Nl7lxVXn+SYhgzz7acWxPDUW54PmOZxBRm+Dk22ygugOwf0e+sLRCfosZePiTPz4ud8RDLiXtAM0xqpokjtaCFZSyDH7cY3PLFh5H/LBytvXjcYgBdP2CWy6CTTDlsuQhYjAbJTLMY4J2Y3pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507604; c=relaxed/simple;
	bh=gLGeCUSaHQ5soqdXdwTlDoA2iG/EDuSAQeO89ocP8KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R781oeVkNeGWihg18nsqhnnztt5SvOvW0DxFa7f7eLVYzJAoxmxVnxBywZvWk5XukmfiSzKLaT46AWX3HWw94pIrQjNVXNT1o7/aWsNKh0GYxQ1MIEx/aeLpBe+m0yR6apnkPQEypR8zX5ABOpd0tsnxtemHXw/DpXQUz3PRNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jxA3Dpci; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725507598; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IwAyTdIFsfBdbu6pCHP6rOYIgFfPion+n0naDFNC3cg=;
	b=jxA3DpciCOqSVp3VCeyMk3sb4FJZPgwH07nLt7QJVahPysKiN1bcpRecKjhBPes7hEm6KOG6BHkcSKV8ZUhg4nCbFtV+GnQlF+Y5bcQNyUYT6p0frenaiT9ACnDZJHb5xl2VGOwCnX/k6M29a7IZ6HxPEzohfT4PVcUc7LUw79A=
Received: from 30.221.115.16(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WEJrPWC_1725507597)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:39:58 +0800
Message-ID: <c1c45940-866c-eebb-8824-d6c73d01bf25@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:39:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe process
 more robust
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 KaiShen@linux.alibaba.com
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
 <20240829100955.GB26654@unreal>
 <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>
 <20240902072133.GC4026@unreal>
 <9cbb54a2-1929-f3d3-5b4a-3c613e6759a6@linux.alibaba.com>
 <20240904160609.GC1909087@ziepe.ca>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20240904160609.GC1909087@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/5/24 12:06 AM, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2024 at 05:09:09PM +0800, Cheng Xu wrote:
> 
>> The hardware now requires that the former reset (issued in the
>> remove routine) must be completed before device init (issued in the
>> probe routine). Waiting the reset completed either in the remove
>> routine or in the probe routine both can meet the requirement.  This
>> patch chose to wait in the probe routine because it can speed up the
>> remove process.
> 
> But what happens if you attach VFIO or some other driver while this
> background reset is occuring? Are you OK with that?

Yes, it's OK.

To simplify the description, We have two relevant components in the
hardware: The device management engine and the RDMA engine. The PCIe
device initialization (erdma, vfio and other drivers will perform it)
is handled by device management engine without any issue. The issue described
in this patch pertains to the RDMA engine, which is only invoked by erdma
driver.

In fact, this low-probability issue is not very serious and can be resolved
by reloading the driver. After internal discussion, we have decided to eliminate
this constraint through appropriate firmware modifications.

Thanks,
Cheng Xu

> 
> Jason

