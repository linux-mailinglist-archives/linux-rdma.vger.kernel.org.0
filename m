Return-Path: <linux-rdma+bounces-8271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52FA4CD17
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9427A4796
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD342356AB;
	Mon,  3 Mar 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WFd+7kVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3A11CA9;
	Mon,  3 Mar 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035426; cv=none; b=jeYpJ0liGmJ1vE4D5caevM3EhV/8OGY8pUMPITOb5hRDGKCVGl6YwZpj4iqJTbe3sB0+vT5G2SFBdnyw9NLRF+rC0xjOZvav6a0r9ir/gc/aUpyIpGOODCxzYOZklZSXifHG1Fs4OkKAhafCoBF5k5hvhGZbd/AxcKi9SKaoBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035426; c=relaxed/simple;
	bh=wkPrI5PI4gOi80WWVhId6dzA8Q9owv5JCghvbzkIVPM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n3JG0wtFH7R04RvBbbe2Lan+zeQvGgYpxE6cf61o7ycytzdSj80DvaQNBGewJLGpDbW5Ai8XJpHgedJ29J+KA+kDstjKoza3UENdFAuXvnEXN9Ozapd4lZSc67ZngS6Uh1WwN026hXZX+QNTRSA5bhmBfmTrswRnrjjiUhGldrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WFd+7kVM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 860C12110483;
	Mon,  3 Mar 2025 12:57:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 860C12110483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741035424;
	bh=3qh+61wOXo3xnM/WVr1EaxpXDMg9Qc5SkS1wS9/KCaA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WFd+7kVMwb8m/yRhGu82uGV6e/HKaH3YScqYDNg3VqULYlWwhYN1W/EwkQ+KpHk2M
	 B+UrWMeoRFcHhvu9/IkXdfvLFS9RIsO/J8jsCs0ntQiYwMGh95feOKPx7lgiJPPiC7
	 /EfD2TyFRiTmU900qpo0PnuB9Rpe0/+ft8U6VJfk=
Message-ID: <f0fa9bc3-159a-413f-a957-0298a55cf728@linux.microsoft.com>
Date: Mon, 3 Mar 2025 12:57:09 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 0/3] Converge on using secs_to_jiffies() part two
To: Jakub Kicinski <kuba@kernel.org>
References: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
 <20250221162107.409ae333@kernel.org>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250221162107.409ae333@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/2025 4:21 PM, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 20:30:35 +0000 Easwar Hariharan wrote:
>> The conversion is made with Coccinelle with the secs_to_jiffies() script
>> in scripts/coccinelle/misc. Attention is paid to what the best change
>> can be rather than restricting to what the tool provides.
>>
>> The non-netdev patches that include the update to secs_to_jiffies.cocci to address
>> expressions are here: https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com
> 
> Can the secs_to_jiffies cocci check script finally run in report mode?
> 
> I think that needs to be fixed first, before we start "cleaning up"
> existing code under net.

It does not, yet. I'm not ignoring this feedback, it's just taking a bit
of wall clock time between commercial commitments. :) 

Thanks,
Easwar (he/him)

