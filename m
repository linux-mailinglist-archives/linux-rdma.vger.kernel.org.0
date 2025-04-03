Return-Path: <linux-rdma+bounces-9140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDAA7A3B7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B3D17294C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3282066DB;
	Thu,  3 Apr 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0g9gYuU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08461210FB
	for <linux-rdma@vger.kernel.org>; Thu,  3 Apr 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687200; cv=none; b=Rb9qWOJSBKJHotaTAR0e4e0rsXKN1UwB4Qf1zarzTCelQO+oM38BlWum38R1MuvhSrGsRSDzUMWosKAUivde3QxAbtIFuTueEeRoBiRTRuMw3H1Fj1unfi+rHKR8vLneytz+wzMdaP8F/tvLTDhFJ3xFGZyJN2hnhKsll3gp2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687200; c=relaxed/simple;
	bh=Stf4GBlAENrbX62tTgzgbry1kGHvlfGiAZfmAAHsTw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZWeNKxnfuVoOW5eXUtfG8pnxfNrQ+6DfGIuJNOBXKfusYmm6+SB+2FCSRuel3IlQ0QOiagSgRC8USPdzruRxoE/dv7RYxbVRFEC4FLht0d2UnrS75rJZt+4gmOOSb0G9HvFvwEpytJmr2FnDBf8b2NBILI6k4YreYK/9GPHAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0g9gYuU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f845e90c-50ff-4e0f-9b73-55a704ba934f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743687194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZZb/gFwlvAyeQdhrFBMQJGozN69evNRZkpQ70NB8go=;
	b=X0g9gYuUWXhqaBGqe2Ml5tjAIfLCZLssn5d1/ph4SSR8JC6znA+6tYTQoUUHxBWP2I5TTV
	i+x5OmIW7Ae/c3q76GRVGMXb7bH9bHV8gt+6puvHCWaBUkTSpC5hju+RWpVvU5U+wWsP1G
	64pSTIK/0ogJCQvnP6OmJnYACt6lhEo=
Date: Thu, 3 Apr 2025 15:33:10 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250402032657.1762800-1-lizhijian@fujitsu.com>
 <a0eb561e-9fa9-46ab-bb0a-6e68a8e0d834@linux.dev>
 <20551f6e-df87-460b-9927-70c93b8d6149@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20551f6e-df87-460b-9927-70c93b8d6149@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/3 4:59, Zhijian Li (Fujitsu) 写道:
> 
> 
> On 02/04/2025 16:58, Zhu Yanjun wrote:
>>
>> Previously I once discussed with Bob Pearson about the function names.
> 
> This is a frequently raised question, yet I have not discovered a definitive
> coding style(Please let me know if you have). According to my understanding,
> the common practice I adhere to is as follows:
> 

You have your own principals. In the linux rdma maillist, there is no 
such common principals. From the debug perspective, it is better to add 
rxe_ prefix to make debuf life easier. But if you follow your advice to 
choose not to add rxe_ prefix, it is also OK. After all, no such 
principals exist currently.

Zhu Yanjun

> - Functions utilized within a single file often do not require a prefix, as current situation.
> - If a function is to be used across multiple files, I believe a prefix is essential.
> 
> Thanks
> Zhijian
> 
>> Perhaps it is better to rename is_odp_mr to rxe_is_odp_mr?
>>
>> Since sometimes we debug in rdma, with a lot of functions with the same name, it is difficult to recognize the modules that this function belongs to.
>>
>> Thus, in rxe module, it is better to add rxe_ prefix to the function name. But anyway, this commit is fine.


