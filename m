Return-Path: <linux-rdma+bounces-14246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F007FC31E48
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23B294E18CC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880D432862D;
	Tue,  4 Nov 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8GlBeXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC72F5339
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270797; cv=none; b=P+N7mLyOCnH06lC6lIZwau87XQWx4Z+clnnj10OqrFurPi8oK8Kt6e/a+62dOV1BDhopruiKNUreNvOFbGFQgmVNJ2NXE60v/+uenqXWczFBJsM/dCSC4HtkknbqeOgNza9TcHI+AKSLvk85shZL2RUFLsrjeEANgfaNvr2fZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270797; c=relaxed/simple;
	bh=CIlelnNfIOXmGKo+MJvfvRXYvQsfy/5QjwJWhEeswSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxOH+XNvFkaIQTnU6qEpbE2m5DH14jO6QkjtnMPIa6S0ipry1+Onm3GhoD8ltMgYhqokk8xHuxV5+TcRuj1GQvAn+1JQO0MZrHX+Cx0WPAtKRlgX5ROuX2g7vO1R0BxASqw1GoDqSvZbpjvEZ/O9nhdDRyK7Rg2oUsNb2B8Bl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8GlBeXI; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4f79310d-e656-4fde-8f09-1875a3ceb12a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762270790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aG5N+Of6PqRuXBsFhInGGF5xhN3hQ5ApNJm/prsjvM=;
	b=j8GlBeXItYXIzs0aTtOpvYasJU/CgMTFBzshKiOORkCT0PjUWQCz/JYZ8C/7FrYDoLpPJ3
	7LdT7k5zUhmxqdRTRIwNsDR07bOmbdBG9CHM7lqdqVl6DXAZSFrtK4GVYl8kFV8T9OLSf7
	/rxRIBETuJ9MEs80w8/Nl4fiAyNwJDo=
Date: Tue, 4 Nov 2025 07:39:44 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
 syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
References: <20251104020845.254870-1-yanjun.zhu@linux.dev>
 <20251104130001.GI1204670@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251104130001.GI1204670@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/4 5:00, Jason Gunthorpe 写道:
> On Mon, Nov 03, 2025 at 06:08:45PM -0800, Zhu Yanjun wrote:
>> @@ -800,13 +800,24 @@ static void release_gid_table(struct ib_device *device,
>>   		return;
>>   
>>   	for (i = 0; i < table->sz; i++) {
>> +		int cnt = 200;
>> +
>>   		if (is_gid_entry_free(table->data_vec[i]))
>>   			continue;
>>   
>> -		WARN_ONCE(true,
>> -			  "GID entry ref leak for dev %s index %d ref=%u\n",
>> +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
>> +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
>>   			  dev_name(&device->dev), i,
>> -			  kref_read(&table->data_vec[i]->kref));
>> +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
>> +
>> +		while ((kref_read(&table->data_vec[i]->kref) > 0) && (cnt > 0)) {
>> +			cnt--;
>> +			msleep(10);
>> +		}
> Definately don't want to see this looping.
>
> If it is waiting for the work queue then maybe this should flush the
> work queue.

Thanks a lot, Jason. I will delve into your suggestions and follow your 
advice to send a new patch for this problem.

Yanjun.Zhu

>
> Something like this?
>
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -799,7 +799,19 @@ static void release_gid_table(struct ib_device *device,
>          if (!table)
>                  return;
>   
> +       mutex_lock(&table->lock);
>          for (i = 0; i < table->sz; i++) {
> +               if (is_gid_entry_free(table->data_vec[i]))
> +                       continue;
> +
> +               /*
> +                * The entry may be sitting in the WQ waiting for
> +                * free_gid_work(), flush it to try to clean it.
> +                */
> +               mutex_unlock(&table->lock);
> +               flush_workqueue(ib_wq);
> +               mutex_lock(&table->lock);
> +
>                  if (is_gid_entry_free(table->data_vec[i]))
>                          continue;
>   
> @@ -808,6 +820,7 @@ static void release_gid_table(struct ib_device *device,
>                            dev_name(&device->dev), i,
>                            kref_read(&table->data_vec[i]->kref));
>          }
> +       mutex_unlock(&table->lock);
>   
>          mutex_destroy(&table->lock);
>          kfree(table->data_vec);
>
>
-- 
Best Regards,
Yanjun.Zhu


