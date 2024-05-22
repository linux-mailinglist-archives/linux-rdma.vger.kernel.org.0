Return-Path: <linux-rdma+bounces-2575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58828CBFCB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F531C20CDE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677B81211;
	Wed, 22 May 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PbqmaMl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0046BFCA
	for <linux-rdma@vger.kernel.org>; Wed, 22 May 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375749; cv=none; b=tg1x/ZDygk+wWQMc8ZBKQViQUnfSkaLlfw694EwbOtZ6KlvWKGXdvbFgg4eArgwiCzvj8LXcpP/gzkDwtW4mHf1G0UlmstMNJPYYVgR4v+DV8uux/aa6SKPgmyDA/squDE/0dEMC9ddVceDfeYS9ehf0wFDy9s+7oTJnbLDK8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375749; c=relaxed/simple;
	bh=Op93j6WT7ewCL13T6vg2g9WuB6JO45rP9tKg9/2I64c=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNIwK0TUawgpYbmHdXyKNJB76x636A7F8sWI5x8ceZwxyl7dWg6l6qH+aE7whf7tPYbK3CwSuYIPb3CPAKt778aZhPnbUptoKzzTyvCMESQQayW266uFpqephnB0WENLwqXpVVAPh73KvOPaYU6d52Hq1+QhhiOD4il3fKFK4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PbqmaMl1; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716375748; x=1747911748;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Lfw+iLFs6o5C2n/yYmshZmLcXBQLsgkeEXben4b+pVg=;
  b=PbqmaMl1Z+TnRu+CFRHkjB59VF+OKfyqxNWExJqZakyDlELZCFvFi0e5
   RTRurX/en+bAzsD3uFhPxjWSfH5+u8LgwuUP+UgiimQNn6hqkNOQSxp9J
   7urKW9uaK74d9SPCDXZaKc0WqxkYi3qSnKFPSyse9zsVAQ7e1mj+N2ipL
   M=;
X-IronPort-AV: E=Sophos;i="6.08,179,1712620800"; 
   d="scan'208";a="296764234"
Subject: Re: [PATCH for-next] RDMA/efa: Properly handle unexpected AQ completions
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 11:02:27 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:37338]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.29.8:2525] with esmtp (Farcaster)
 id d589abe6-19ee-48ee-8b55-a147583cafde; Wed, 22 May 2024 11:02:25 +0000 (UTC)
X-Farcaster-Flow-ID: d589abe6-19ee-48ee-8b55-a147583cafde
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 11:02:25 +0000
Received: from [192.168.92.204] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 11:02:21 +0000
Message-ID: <010ecf52-6d2b-4b5e-92e0-57e0069057fd@amazon.com>
Date: Wed, 22 May 2024 14:02:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Firas Jahjah <firasj@amazon.com>,
	Yehuda Yitschak <yehuday@amazon.com>
References: <20240513064630.6247-1-mrgolin@amazon.com>
 <5f2f0165-c148-4bba-8af9-ded7665ba373@linux.dev>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <5f2f0165-c148-4bba-8af9-ded7665ba373@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Thanks Gal, we indeed shouldn't see such errors on regular basis and the 
print is sufficient to help tracking and debugging in case it appears.


Michael

On 5/16/2024 1:54 PM, Gal Pressman wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 13/05/2024 9:46, Michael Margolin wrote:
>> Do not try to handle admin command completion if it has an unexpected
>> command id and print a relevant error message.
>>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>   static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
>>   {
>>        struct efa_admin_acq_entry *cqe;
>>        u16 queue_size_mask;
>> -     u16 comp_num = 0;
>> +     u16 comp_cmds = 0;
>>        u8 phase;
>> +     int err;
>>        u16 ci;
>>
>>        queue_size_mask = aq->depth - 1;
>> @@ -453,10 +456,12 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
>>                 * phase bit was validated
>>                 */
>>                dma_rmb();
>> -             efa_com_handle_single_admin_completion(aq, cqe);
>> +             err = efa_com_handle_single_admin_completion(aq, cqe);
>> +             if (!err)
>> +                     comp_cmds++;
> I would count the unexpected completions as well.
> Regardless, I would definitely add a counter to track these (hopefully)
> rare cases.
>
> Whatever you decide:
> Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

