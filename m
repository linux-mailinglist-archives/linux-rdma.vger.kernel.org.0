Return-Path: <linux-rdma+bounces-6811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD6A0153D
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF512162BA2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048051C1F24;
	Sat,  4 Jan 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vFsU461T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AB1C0DED;
	Sat,  4 Jan 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000997; cv=none; b=WMR0m+VOyWfCl226GNh8m2SG6aRZQ6dbnGluBwRqKNlaok+C6nml389PDZN6dZJVRgCuBTaccTxUbYNZbZPsfwkTF6OxyWNUcWD5Z1UQ9wu94fQ13c4tWZxFR7KPIep1AC7DXXRgixSdEY6UeFA//5A9NPLhUuh4d5h+qZpc1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000997; c=relaxed/simple;
	bh=2QsLBjnqFiVvAgOGKno5kaNm5Ulb18UE+Q5yqVObqeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjPS2ISZ1ZBQgKlduMO6NDQY7kx8bHxdDfmSssZ+KoJlsjtBD6/Nk13UBvOpFDGhYxzHv1RRv7R1b7mzcMlAHQYJX1r/oYzmb1OkM7OcrbJfu/WHXJxKBLUiPpDaCBKPCDYIzq7jiZ8IhuEK6gtp85clILsqe6oDbc8N1FN5sRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vFsU461T; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736000985; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H4G3A9ya85VFNRHxiMF5hvkQd8M0Zfv6QOF+y2epB98=;
	b=vFsU461TI/1yIvirkovoUL6tVc2BMm1UKaDjvZruTDKU4ExIH2F9zbla1KGWu4EKkGs73yhugxTEaDu2Ceww+Vv8Rq4opS2VcimDJtV2ScVgBWwtXn8fpYTxK816BfnH3EnUoFOeYIsm1J/wu1RzrVliWP545Vxqp0lpcZeSwsU=
Received: from 30.32.68.161(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WMw6oFD_1736000983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Jan 2025 22:29:45 +0800
Message-ID: <d0c1d3ae-43ac-482d-91ac-cde4686a3cdc@linux.alibaba.com>
Date: Sat, 4 Jan 2025 22:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix data error when recvmsg with MSG_PEEK
 flag
To: Jakub Kicinski <kuba@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, PASIC@de.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241220031451.52343-1-guangguan.wang@linux.alibaba.com>
 <20250102190251.73b389d8@kernel.org>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250102190251.73b389d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/3 11:02, Jakub Kicinski wrote:
> On Fri, 20 Dec 2024 11:14:51 +0800 Guangguan Wang wrote:
>> Subject: [PATCH net] net/smc: fix data error when recvmsg with MSG_PEEK flag
> 
> Since this is a fix you need to repost with a Fixes tag added.

Thanks for reminding. I will resend it soon.

Thanks,
Guangguan Wang

