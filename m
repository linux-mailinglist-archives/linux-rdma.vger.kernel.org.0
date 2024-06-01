Return-Path: <linux-rdma+bounces-2743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F28D6D6A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 03:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD21C21B3A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C852D6FC7;
	Sat,  1 Jun 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1JCQf3b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E91879;
	Sat,  1 Jun 2024 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206589; cv=none; b=W4v+5xjcF63CWm0hfOR3Kj1/46vhdJqDl0L0H5DQasgbNT0F8sPf2G4kisL+BWOieue0uQVHKye40WHMfePTKI76zAYh9r7mb2bu1YCNZ6x1pzaeJfuA1da+xYfZozsdTO+eQqIMjIQ1APeL67RwRdgrjW8eVey5buXIUpOWC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206589; c=relaxed/simple;
	bh=M8/pffXdKKDDc2omgjyG4lVjGiNptu8jJGHTnrYhQaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9I1YkzuCZGuQQTraQ4k3OH4kGPF0OUJ5s3els/rVAb7mOAuzGCBjqyKf9aQ3Zu8npeyK8oCJQ24t5DzobhHdZIUDyJXCxLo4HX+721zbGXHbbd0AJg26l//CyX2zaU+hjc5jpNFni3W85pvjo1AXGzcbgYu75e+kLprl71nQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1JCQf3b; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bvanassche@acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717206585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8WfBxq8XLRTBZ5tQIhY0Q9aeK+UOqcJTpHkcaQ+TpQ=;
	b=h1JCQf3bfvXrbdLOdGdABlt8LfZALDMGbAVnfTqDUYOxSM3Tq18lpwx0IEIulB64lhNDA3
	hEnw9oEijJgYuLz0ms7jokSKK7Z/9F0rB7hrgOkVmnHSUmodBVnfAwpV9MjYzzJQb9nOBk
	94sVvCusQLEVWDHsZow2xEDcZ6Ha9cQ=
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: shinichiro.kawasaki@wdc.com
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-nvme@lists.infradead.org
X-Envelope-To: linux-scsi@vger.kernel.org
X-Envelope-To: nbd@other.debian.org
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <53f5e515-bad2-4094-ab7a-64d807ce1223@linux.dev>
Date: Sat, 1 Jun 2024 03:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
 <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
 <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
 <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
 <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/31 22:46, Bart Van Assche 写道:
> On 5/31/24 13:35, Zhu Yanjun wrote:
>> On Fri, May 31, 2024 at 10:08 PM Bart Van Assche <bvanassche@acm.org> 
>> wrote:
>>>
>>> On 5/31/24 13:06, Zhu Yanjun wrote:
>>>> On Fri, May 31, 2024 at 10:01 PM Bart Van Assche 
>>>> <bvanassche@acm.org> wrote:
>>>>>
>>>>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>>>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, 
>>>>>> do you make
>>>>>> tests with siw driver to verify whether the problem with srp/002, 
>>>>>> 011 is also > fixed or not?
>>>>>
>>>>> I have not yet seen any failures of any of the SRP tests when using 
>>>>> the siw driver.
>>>>> What am I missing?
>>>   >
>>>   > (left out a bunch of forwarded emails)
>>>
>>> Forwarding emails is not useful, especially if these emails do not 
>>> answer the question
>>> that I asked.
>>
>> Bob had made tests with siw. From his mail, it seems that the similar
>> problem also occurs with SIW.
> 
> I'm not aware of anyone other than Bob having reported failures of the 
> SRP tests
> in combination with the siw driver.

At that time, I had not reproduce this problem with SIW, either.

Zhu Yanjun

> 
> Thanks,
> 
> Bart.
> 


