Return-Path: <linux-rdma+bounces-12690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B922B23C15
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B71AA57FF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BBC2D7392;
	Tue, 12 Aug 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BGPxhRb2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53751DFCB;
	Tue, 12 Aug 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039452; cv=none; b=BfobgZGaF7oCuWBixQpk9tYc6AY5IRrLltEe5yZCd5wY6j6TGzxCIbPTy8EN9OrrLEpDL5qB7vfTVdLUY+dsRlMf9uW/R+j2yiyOHKggUtGF0cybbfqlQ+2ewKUmUQ6mn9ly7Y92VkqmUfvOSQF9Z+IQ//LPRPQo9S82Jas/qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039452; c=relaxed/simple;
	bh=Jn0Scey20IWQjV8yQsVwKnL3ajtRwc+Pa/RAser3aRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9xXtR00nweE8cXiOYS7xPTD0ffFxPwu+JG+pBGjI3qE2U1H1gbvKixvfRHYevDzp7Evx0ne1bt+6EnPhnV0s3wY2upMWdXtzWGwp8+wkRQXXZJ9cqG/GXOe3v6Ideo4/WuZF+Rhp/wab6FeZQlROZzTuJDuPGOdik4exhItIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BGPxhRb2; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755039447; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hzyGLAvYMg6i3Vhc3/4W2C3KZxciNBuhQJ30QdiHlJ0=;
	b=BGPxhRb2O1Y2qYxuVTH/UopSDG7gWn3T8ZVgwPzFlnQGtaQAWMCZ/6bQ88xqWAudIc8x88wATofOb8LmgWYbaB7u2M7jAY5spcOZlcRUTLRCEmyayIelQPft2/d+ZXnf86OvRQPyoTXVATt6AgGbziB5wLrktjlYnpeJQTAmO2c=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlcqLHL_1755039124 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 06:52:05 +0800
Date: Wed, 13 Aug 2025 06:52:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
Message-ID: <aJvFlBISHJMe-0Jt@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-9-wintera@linux.ibm.com>
 <aJiwrG-XD06gTKb3@linux.alibaba.com>
 <2d511067-0cc6-4911-846a-ab815a0b318b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d511067-0cc6-4911-846a-ab815a0b318b@linux.ibm.com>

On 2025-08-11 16:27:21, Alexandra Winter wrote:
>
>
>On 10.08.25 16:46, Dust Li wrote:
>> I've been wondering whether we should completely remove the ISM concept
>> from SMC. Including rename smc_ism.c into smc_dibs.c.
>> 
>> Since DIBS already serves as the replacement for ISM, having both ISM
>> and DIBS coexist in the codebase seems a bit confusing and inconsistent.
>> Removing ISM could help streamline the code and improve clarity.
>> 
>> Best regards,
>> Dust
>
>I second that.
>Like I wrote in the last commit message:
>"[RFC net-next 17/17] net/dibs: Move event handling to dibs layer
>...
>SMC-D and ISM are now independent.
>struct ism_dev can be moved to drivers/s390/net/ism.h.
>
>Note that in smc, the term 'ism' is still used. Future patches could
>replace that with 'dibs' or 'smc-d' as appropriate."
>
>
>I am not sure what would be the best way to do such a global replacement.
>One big patch on top of dibs-series? That would be a lot of changes without
>adding any functionality.

I prefer this approach. Renaming without changing functionality keeps
the patch clean and makes it easier to cherry-pick.

Best regards,
Dust

>Or do you have other clarity improvements in the pipeline that could be combined?
>I would like to defer that decision to the smc maintainers. Would that be ok for you?
>

