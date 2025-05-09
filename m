Return-Path: <linux-rdma+bounces-10209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D50AB1BDB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597253BAF43
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837523BD0F;
	Fri,  9 May 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JPX5nA7v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036A1E32D3
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813675; cv=none; b=mxfYo9tuBLAsRrNJ+wTs682TUNaSpH3+SwNTJbNTAfw0fYq8ScbnOHhEQD60ipcvDAzdgJF+7VhSQ15rNfppOh93m/BuVXEV7X7+FMDHMPKRyl2pjSpHuT7sk/5taPHkg3IAr63BwQWPiYqP7k0carKGM4qPxy5u9EAlikcHres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813675; c=relaxed/simple;
	bh=AMyc4SmAogKNz5XjZB3Ho9OHByV9t/zDyyabGQYPS30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUcY2aebEIS6Y20bNB/4qEBM9OW3aT1I+01+O94V+heeKQnfRdqd2tKnirCaPqkWfnxRaR3YO2LuuCNQhSqVBdewPz0meMSGwkQKG8Yp4yGsc8gxlYGIkQpkmJiGWyp24hr7MolD7RuM0jlz05C3ORKAsZHNt0SVQOA9D6+l+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JPX5nA7v; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e86a760-ec53-4daf-87da-889070ad69fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746813660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8dQcrXzbbC+fJqoBrbF+CpsKPOBWpsb9plw12SLHS0=;
	b=JPX5nA7vjHKG1nEIGLKgk83cQegpiCBCyQVpINyWwUYn0Zm/iPaniNSxva1JgnRGr5YZ5f
	T0yYHpreviwViozmeSn4ZnxH7JVzod3RPRdctABwF8rhsIflhPOYOSUjOYcgcvnzuHZs6K
	SNyyKLotNiujv1RoBua6tYyS+Ob2Pqw=
Date: Fri, 9 May 2025 11:00:43 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 Jason Xing <kerneljasonxing@gmail.com>
References: <20250508235109.585096-1-stfomichev@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250508235109.585096-1-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/8/25 4:51 PM, Stanislav Fomichev wrote:
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


