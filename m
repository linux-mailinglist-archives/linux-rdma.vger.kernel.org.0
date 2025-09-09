Return-Path: <linux-rdma+bounces-13201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC26B4FA19
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8003ACAA0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF2335BD8;
	Tue,  9 Sep 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IvE7sjg6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0F320CA6;
	Tue,  9 Sep 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420070; cv=none; b=skOyqGgyH87cYAPSdnkCSpZuad1FbbzX0F+wacXHZJo0Eu1b2hED4R34RMr9pmY9eSNRxp604T7LNSQJk8TJ8gc56nPDfNl00SJhnfQuTcJlqFMPnvFjYxZ+U9Fmiz76Y6wd3EeDTTNUaPWiqhpOSM2CkddILNsTCHouA7OgtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420070; c=relaxed/simple;
	bh=OB63mIo4zdSMWKbh2EcQLPe3oSRYB9H/CMW5Vw3qz4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcyL0JrvAihgt1aje4htzD1A9p7W+G1A9KlBuqqa+yvZHLkYo/C5Pc6d3Q0auhQDwVGzHAl3Nc9eX3gevqreEKDjF+VqMNzhjoaYRoxJ/zclp6LFHlNZS8bPijO7lar+vMIliMBW62OwiYNxTWcSUktxknIVt5lim9E3/g2wdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IvE7sjg6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757420064; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=YQGx5IQ4PPAyFAVoz8cJdR94oARhHl805b2sz6A9J0c=;
	b=IvE7sjg6sLU2jnyon+WWP/jp1b838NP4yPsFM21ye5seJZjFBJTKUdM5bWs3JoY9I1adIbtCQltFscjqDjDb03wt3s8gagFjDlz7l3eSJ+FcqjEZcBjqvIAoZq71XNM8RlirfFAaqb434Tq+iEKAeOxPmkUHMl1adCr+DVp0KYM=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wne8cK2_1757420063 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 20:14:24 +0800
Date: Tue, 9 Sep 2025 20:14:23 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Remove unused argument from 2 SMC functions
Message-ID: <aMAaH7oQz-FM96sv@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250909071145.2440407-1-mjambigi@linux.ibm.com>
 <aMAR8q4mc3Lhkovw@linux.alibaba.com>
 <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>

On 2025-09-09 17:13:35, Mahanta Jambigi wrote:
>On 09/09/25 5:09 pm, Dust Li wrote:
>> On 2025-09-09 09:11:45, Mahanta Jambigi wrote:
>>> The smc argument is not used in both smc_connect_ism_vlan_setup() &
>>> smc_connect_ism_vlan_cleanup(). Hence removing it.
>>>
>>> Fixes: 413498440e30 net/smc: add SMC-D support in af_smc
>> 
>> The standard format for the Fixes tag requires the title to be enclosed
>> in parentheses.
>
>I missed this. Let me fix it in next version.
>
>> 
>> But I don't think this is a bugfix.
>
>Yeah, its more of a clean up code. Should I use net-next? How should I
>got about this.

Yes, I think it should remove the Fixes tag and go to net-next.

Best regards,
Dust


