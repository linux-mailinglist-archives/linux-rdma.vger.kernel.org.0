Return-Path: <linux-rdma+bounces-4781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42FC96E7B1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 04:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A191C23283
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9522064;
	Fri,  6 Sep 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iTcVHOD8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992C1CA94;
	Fri,  6 Sep 2024 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589571; cv=none; b=KF7NRGbtQH6gdY1bNd9Mj4V9ux4tvRlBNBbOrnam1IcA1O0P6gTr6uhiFrKODyhSkH4/T3JCgfzcN32O6Or1pTvhpz5zLMtr4P8wsxGomiazE1yPDv19N3Obv2IvQet2bcG7Grc+aUPjrP7eisJCm8FMMRranMK1mGTEOEulMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589571; c=relaxed/simple;
	bh=/rrNQ3DJ6lqgHmOf/PoBMk9RKW9jtGcIJb3qfz96IOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlFyk9aw3JyiHXEHB+9Hj115u2ok1UrCe2ODTbOvy4os/gTHkyB+4q53kIDRVTgouS/vmTaST9ZA9fgxQ5JHcVlB1tfJOSiFwZMBQrZnPJAwd+j4YX7bpMV+yGnf/JJVI7TUrCm1s7cu5UFQXY8miI8RzIBtiTjSHH691EDLcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iTcVHOD8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725589566; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rt0XPjVQz4cJF6ZEE2poXzj/CE9oleB0jw6s6iQ/pLw=;
	b=iTcVHOD8t6GNzUqkX0G9PQlUk8/DiHahhs428AmJGX6O3+H9vytQ5qzRyKLgOmsD7dy8ZQypt38hDZgpkkokcGfuGIaZ/OfKdypwsllJLLddY9FQ0bzaoZL4ztl+o6gtL8sw4smsyYUsWxCw3i/FvmlEXoLTvOkT+LGVpGS4yog=
Received: from 30.221.149.28(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WENfBWM_1725589564)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 10:26:05 +0800
Message-ID: <035c03ae-ad8b-4bf5-9a29-5fc04eeb4842@linux.alibaba.com>
Date: Fri, 6 Sep 2024 10:26:03 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
To: Andrew Lunn <andrew@lunn.ch>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
 <0ccd6ef0-f642-45c3-a914-a54b50e11544@linux.alibaba.com>
 <9a3aec30-37a6-4c62-b2b6-186468b6a68f@lunn.ch>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <9a3aec30-37a6-4c62-b2b6-186468b6a68f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/6/24 5:12 AM, Andrew Lunn wrote:
>> Hi everyone,
>>
>> Just a quick reminder regarding the patch that seems to have been
>> overlooked, possibly dues to its status was
>> mistakenly updated to change request ?
> Once it gets set to change request, it is effectively dead. Please
> repost.
>
> 	Andrew

Thanks for the reminder,  I will repost it later.

Best wishes,
D. Wythe

