Return-Path: <linux-rdma+bounces-1378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA96877B99
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 09:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2325CB20CDD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB321118B;
	Mon, 11 Mar 2024 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ON9V5FQZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461811428E
	for <linux-rdma@vger.kernel.org>; Mon, 11 Mar 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145082; cv=none; b=FXmQHiilridfr6N9LAqAH0RD2hphhZYIM+ZjrfD6KRMbCT47+2CogLfuXOaoJwTQUqyDwbbOWQLp+apD0dg5sZOuhvyLgUHF72g8+gERm0rnTuLbRzGSLid+kPF4fgTXB2kNYr/QLpwjCYDAK6Ghd9g5rfwbH9jr6Wrsi/R9o30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145082; c=relaxed/simple;
	bh=jzvSjvVA6Jyy48uWqmfGdrZwBkgTuPLqmjeUVsU/44Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhkK69bJz4oqw01SdPMTQPHr/NjlFhRl8scOIpTR4/xFLf50IQPUCTbEQS4wNKlEWoRtI9DO7fpVx6EaS9bKvDcEObLofo2L33LrPyp51qE+Z0uVm3thyzcEooOGBWa/sJVVp5IeH/QswQV9eR5Bhe2ANOX/ctZqFfYVXIu//Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ON9V5FQZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c391960-4406-4089-991e-d54ecc45524f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710145078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/Gz70WprgLvSEDgpF5x0FUaddqxV0rehd1ZR+aa/us=;
	b=ON9V5FQZKlAsAbR47O1AsQEFG48m7H6UueIUrYklxzeol9YBF2b2dTvxV9SiOAxZcSAoJW
	WSbs59ndbxLCvr8yMz9cWGYnuy8FBsXDlo9NF/AEZ9PQGRfSnFP+R4NaIVgMrL7QINVdnN
	5nH3L1J3bIa/3mu+w6+ydd+tl/wh2KY=
Date: Mon, 11 Mar 2024 09:17:51 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
To: linke li <lilinke99@qq.com>, gregsword0@gmail.com
Cc: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <CAEz=LctG46xSHVxRg0VwnfCpv+uyOHdb0jqQ+WJNc7zSnMA2Ng@mail.gmail.com>
 <tencent_C20218AE8489E90806F1522C24B11BAFD30A@qq.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <tencent_C20218AE8489E90806F1522C24B11BAFD30A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

In the original source code, READ_ONCE(xxx) is in if test. In your 
commit, you move READ_ONCE out of this if test.

So the time slot exists between fetching and using. In the original 
source code, it does not exist. And the fetching and using are not 
protected by locks. As is suggested by Leon.

This will introduce risks.

The binary is based on optimization level and architectures. It is very 
complicated.

Zhu Yanjun

On 11.03.24 03:57, linke li wrote:
>> This is not a smp problem. Compared with the original source, your
>> commit introduces a time slot.
> I don't know what do you mean by a time slot. In the binary level, they
> have the same code.
>

