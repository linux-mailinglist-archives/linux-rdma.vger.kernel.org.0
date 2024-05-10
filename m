Return-Path: <linux-rdma+bounces-2395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5C8C20A3
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 11:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D047D1C221A1
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CA1635DC;
	Fri, 10 May 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VFMBqrbP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72977119;
	Fri, 10 May 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332463; cv=none; b=pqgXTVhr6A4D7lSe6Pp5lfMn0D7tYzMIIWdITq1gkGkqKj9eBnO9kDpK21Gcx2vPuu5aZcesv97oE51qW32+k8ImSAIAknO7ix4rzQBADoZgQIwP8zDXs/ZD0e32WNxYnqtnuActP238Oy8NLDcD5Nel4dTwEOnJtkjJIqRAkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332463; c=relaxed/simple;
	bh=W6EfEcxkzj+33/w5SVI935EGKINwwG4AtG59hsNqWD8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QZVuAX4RPmr6vzbCcSnwVhvXzjNVxaD6AsPkh8SQMYhjqUjey8OGf6GJW8LZ+CCSl7VYWdl0GCl+vfxUdgbwFHDw/L9jJoIjsiKmSGeUfd+IjFi0n2C59NEQXuWGEtumDXvEyAx2pQFfe61/YqbW0Cq6B4UONHODxDlEAAnl39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VFMBqrbP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715332458; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=W6EfEcxkzj+33/w5SVI935EGKINwwG4AtG59hsNqWD8=;
	b=VFMBqrbPAizbnoeePKlz3usqVfqNJByZreOh61mT5AYnmnXv1wkK8YldCcEVbwY8cMbHCQxdDtOAScDnYW8SXA+PtlJ8TpRChw1idxLNXyRxNLtxtCuUoGWONG9Cbtr98rsfra2NgtGOviUxPV3xNUW+09xoI46Wzh+WqjJ7+BE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W69yFeK_1715332455;
Received: from 30.221.149.42(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W69yFeK_1715332455)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 17:14:17 +0800
Message-ID: <daf475c1-f729-47ab-81bf-f0e2d2e24b08@linux.alibaba.com>
Date: Fri, 10 May 2024 17:14:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Introduce IPPROTO_SMC
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/10/24 12:12 PM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
>
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);

A eBPF version of smc_run is also available here:

https://github.com/D-Wythe/smc-tools/tree/ipproto_smc

You can test IPPROTO_SMC by script:

   smc_run.pid COMMAND

While you can still test AF_SMC by script:

   smc_run COMMAND

D. Wythe

