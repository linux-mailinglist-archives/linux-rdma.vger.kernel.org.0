Return-Path: <linux-rdma+bounces-1786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA2898DAB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1D91F2B836
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289212F5BC;
	Thu,  4 Apr 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ma/rRknA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C212D1ED
	for <linux-rdma@vger.kernel.org>; Thu,  4 Apr 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253822; cv=none; b=AndjuBIn+9vZsLWRUwQ9LTDZS1prK81yxKYoEFALovuAdFYgbewXsZS9Lwl8gcRnpPH0FbIZOP749PyVVkUZlPwIBMOG/jAa4lwC5jxNHrS4qYZGIrB+RrP4Vykl98MGnBub2BXfWmWWD+wDikCOB3KYt+pdh+niuy96J5YTrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253822; c=relaxed/simple;
	bh=3WEFMiS6QZkLVWFnc0yYlhiL8opXk4f10CH79dWiY94=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UAu4a0CeI7+Z2e3sUxijlaA+kNFpzKZ3eIP5pJcQQ3Y/pcnOzo16YhQP0rhWpzC0rAn5lw1JPTFG+DGXcXLitf4eVEXwFxO0Pyr3E0zziRpQwnsqeNZ/n56iuhUPS06MeDZUgwmvTwT0gKCO4i8ZGdwrgTxEzA5gXsJZva4IRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ma/rRknA; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be9584b6-85fc-46bb-87b8-18ca6103a5a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712253818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WEFMiS6QZkLVWFnc0yYlhiL8opXk4f10CH79dWiY94=;
	b=ma/rRknAkLyfpxLRbKlMGK8EM2SwE+zxZo7eU3UnBQHNO6FdumYBkgCkWMmMG4an+VWdDM
	6mNvVzU5V8UPKfcyVB0HVckt9vFCcSXne8TZ8ylqt07TU8dcBa5uQvtt/S16WkOH9eiHUV
	TL5H0S0d1o5nRawpkWmkOnGpsIBxim8=
Date: Thu, 4 Apr 2024 20:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
 <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
 <20240404145913.GF1363414@ziepe.ca>
 <7a2a41c2-c8ef-402d-933a-2b2d8a956207@linux.dev>
In-Reply-To: <7a2a41c2-c8ef-402d-933a-2b2d8a956207@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/4/4 20:01, Zhu Yanjun 写道:
>
>
> 在 2024/4/4 16:59, Jason Gunthorpe 写道:
>> On Wed, Mar 27, 2024 at 08:40:54PM +0100, Zhu Yanjun wrote:
>>> 在 2024/3/27 14:08, Jason Gunthorpe 写道:
>>>> On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
>>>>> From: Zhu Yanjun<yanjun.zhu@linux.dev>
>>>>>
>>>>> If the definition of pr_fmt is before the header file. The pr_fmt
>>>>> will be overwritten by the header file. So move the definition of
>>>>> pr_fmt to the below of the header file.
>>>> what header file?
>>> include/linux/printk.h
>>>
>>> Because this driver will finally call printk function to output the logs,
>>> the header file include/linux/printk.h needs be included.
>>>
>>> In include/linux/printk.h, pr_fmt is defined.
>> This doesn't make sense, printk.h has:
>>
>> #ifndef pr_fmt
>> #define pr_fmt(fmt) fmt
>> #endif
>>
>> Before or after printk.h should not have an impact.


Sorry. The previous mail is not sent successfully. I resend it.

> #ifndef pr_fmt
>
> ...
>
> #endif
>
> The above will not undefine pr_fmt.
>
> #undef pr_fmt will undefine pr_fmt.
>
> This link explains the above in details.
>
https://www.techonthenet.com/c_language/directives/ifndef.php
>
> Thanks a lot for your comments.
>
> Zhu Yanjun
>
>> Jason

