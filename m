Return-Path: <linux-rdma+bounces-3135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAE907C14
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 21:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15113283298
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442714B075;
	Thu, 13 Jun 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kius/dwM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3288130487
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305993; cv=none; b=O2Av48ToYyei4vXkcfuyBFAppYTkEvgSfraVMErGoidiKezf8vasGagguXWeAC560/5m4rHUjLwn6bLW4GvCySbyV2MbvWMlhs+oaRPdme4VBNwsqNBtoGF2qxYn4o+aBwc6M0AZ1navKCNg6Y1pHymh8NBvxCuywprVhR7rgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305993; c=relaxed/simple;
	bh=CDiNrnUFuf0VaRRD1CLGhoLVNxnLhFeKe0mRdAAJfks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPabMuw99WYYF+9BfhuTTf/i/iMDW7SAdjXCBeEljQDV8U7c+XHl8n7r8ctGlYSNHFd5AMjX5s7CtHSn1sLqn74Cmp6W7KHuizip67JegD98Ikha0z8AAdtkxbIGMy815PXtH8FtQ7yHGsmXeUo5THyNZa9t2qQhVJ3IWp1daP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kius/dwM; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: leon@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718305988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hNaE3IbzxeGRFY6CKfI0yTFA+y5GlIBjn8i8uzMEWI=;
	b=kius/dwMrdQzXdd3rEIC2ped5DIamyGAFwKAdVLJqm8OdoDVpHXoRcUJN/GnhVO0JwuQ2L
	o9d2Ld3Ox9NNEGDb5F0dWdd62ObL59JzsdpsVJfAw8CiuHSarCCIAENEYDMjWEyU49RIGS
	UaM/Em1FTUkg0zI8Or8WoexE3fjoVk0=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: jianbol@nvidia.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: saeedm@nvidia.com
X-Envelope-To: tariqt@nvidia.com
Message-ID: <09aab0b6-ed3f-4569-992b-ea5bfc1c2c32@linux.dev>
Date: Fri, 14 Jun 2024 03:12:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
 <20240607173003.GN19897@nvidia.com> <20240613180600.GG4966@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240613180600.GG4966@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/14 2:06, Leon Romanovsky 写道:
> On Fri, Jun 07, 2024 at 02:30:03PM -0300, Jason Gunthorpe wrote:
>> On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
>>> From: Jianbo Liu <jianbol@nvidia.com>
>>>
>>> UMR QP is not used in some cases, so move QP and its CQ creations from
>>> driver load flow to the time first reg_mr occurs, that is when MR
>>> interfaces are first called.
>>
>> We use UMR for kernel MRs too, don't we?
> 
> Strange, I know that I answered to this email, but I don't see it in the ML.
> 
> As far as I checked, we are not. Did I miss something?

I have also found this problem. IMO, 2 reasons:
1. Delay in maillist. That is, there is a delay between a mail sent out 
and this mail appearing in maillist. We will find this mail in the 
maillist after some time.

2. sometimes, we forget to include maillist.^_^

Zhu Yanjun
> 
> Thanks
> 
>>
>> Jason


