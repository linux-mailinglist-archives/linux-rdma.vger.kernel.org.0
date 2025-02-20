Return-Path: <linux-rdma+bounces-7897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8DA3E059
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF23C3A9FF0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E820B1FD;
	Thu, 20 Feb 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M9vRRCbA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D31FF5FE;
	Thu, 20 Feb 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068253; cv=none; b=GP1gizp5nR4jQdIwykO7NXNhOw4qUGrp8EWrEQGUlcHStrWZO4+QcPHEtrdgjtWG5sAUPbFsZu2e6cUdp99b5Zd3qTq4F60FKcDffqAMs5D2b7lpQ9nMDCr0nmal4YaLxCBo6CihZfkTNU4RM0qJMeQL7ny6fOaLb/9Ide9RHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068253; c=relaxed/simple;
	bh=S2Cp2QeCTboIPkqp369Oo0lo+0M7cZnbKd+wHZSVx9k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEth15fjnl2V4FdWB7oQSKrbB6NI5j6HU5js2Unj3262HcTOkwvvO8bxeMsklZZol/+MUEaDFpSGcy2ZVlQepmVa4bxKyQVrJ2Q/z8Eum9jFVjb5eNCDVI5vviDyd0Jro4wzH5k02e6SgwIYRSQxaWmCnlPnC3D4RLebrpshd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M9vRRCbA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D0E220376CD;
	Thu, 20 Feb 2025 08:17:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D0E220376CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740068250;
	bh=GkPk3vpo3fjZ76nSYEcI8RaFBSu99lnwsP2xmX+YLqI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=M9vRRCbA4t8agc57RtPDTlFanjsd1kyMTIKmtK0WIEi0jKc0MN5zrDxWFmqHcc2tN
	 QxaJA7UOEH+zXoIs/YyoFF9eyPOwTmc4dCP8PHrdqd0QLuLGdNEYqNV675HZa6V7S4
	 JGi5ZSgtld/s2UCGDlFjmzsQK/iWwwlNhfL2haSc=
Message-ID: <bfd711f3-2de6-44d0-afe9-e24470448011@linux.microsoft.com>
Date: Thu, 20 Feb 2025 08:17:31 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rdma: Converge on using secs_to_jiffies()
To: Leon Romanovsky <leon@kernel.org>
References: <20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com>
 <20250220070729.GK53094@unreal>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250220070729.GK53094@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/2025 11:07 PM, Leon Romanovsky wrote:
> On Wed, Feb 19, 2025 at 09:36:38PM +0000, Easwar Hariharan wrote:
>> This series converts users of msecs_to_jiffies() that either use the
>> multiply pattern of either of:
>> - msecs_to_jiffies(N*1000) or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> where N is a constant or an expression, to avoid the multiplication.
> 
> Can you please provide justification for that? What is wrong with current code?
> 

There is nothing specifically wrong with the current code, it just does an unnecessary
multiplication for what it does, as the cover letter mentions. IMHO, it's also more readable
to just see secs_to_jiffies(30) and understand that it's a 30 second timeout.

Thanks,
Easwar (he/him)



