Return-Path: <linux-rdma+bounces-8204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1428DA48E09
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 02:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0505C16BCD5
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B254918;
	Fri, 28 Feb 2025 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="y9SHZ+6H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2524B34
	for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706706; cv=none; b=ig9Nzv0GTyPMVJbf4/bq0SQZRzHqLlPN3tG2eUr+lEZupWdYem/li6zV2LT8HugXWczkE/55LaboPM9BTFVjv7GtbZsEKTp8iqRNOvasF7SmLVEsJJJ9EqLL2X1a7SNdfcH1BWclQ7DEk4MPs74OxEre4omadFY9YqCFX6USbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706706; c=relaxed/simple;
	bh=yYfSHuxvwl5xS7zsK1TXHUkqz6Q7RguDWTF2WQvCm5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXiHG/mp9biSLcu4JV8DYnAuDf6dvrrfQhfx0zpL6iL1ALaqP79XUTwO3QzWmP7rkm838RgA+tvfUWcYa3Y1ju2wZhL6hUpZV6REqqQOTRRIId8ysRzWIrdqZrhSdhHFn/4dX4XCZVwuvyTJjS7w6ffAkVINYGdG/VOQc4XDkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=y9SHZ+6H; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id nQc7t3McKAfjwnpKUtvkFQ; Fri, 28 Feb 2025 01:38:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id npKSt7Ghf5f3RnpKTtm7uW; Fri, 28 Feb 2025 01:38:17 +0000
X-Authority-Analysis: v=2.4 cv=MrBU6Xae c=1 sm=1 tr=0 ts=67c11389
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=iit3rYpcdqjZrRsmSfkA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yYfSHuxvwl5xS7zsK1TXHUkqz6Q7RguDWTF2WQvCm5I=; b=y9SHZ+6H68pJ5tDrM+J2zCHCAO
	ABBs7xNrX44ynaGgtCol5KkHqphPr+nmdTfYlFuetlSFpqHMWF5RYk81V2A33YpoGkYCkTHaINX47
	VDqoV8EZbrDZlWm3nvXkJQTq1GKAFWllQmzOsfU36/mLnbmW1hrBL1m4OI85IcCrsxv3z4a6s54TI
	mSq/rfLx0ckfnoq3joWRuNwNjSVQ0CztHekvKXn5ip7/l/hyYiVc3Jng+hp+WzxgC54xWLefJ0Tlc
	2kf21EE80kslvG0Zfm3fyje964vMQA84Km5VzUrsZQVlLdsPNY5h1dk/wkx1Jf6pMJTf6mK7bvFzM
	dSM8JIlA==;
Received: from [45.124.203.140] (port=53803 helo=[192.168.0.158])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tnpKQ-000000036Gj-1EMq;
	Thu, 27 Feb 2025 19:38:14 -0600
Message-ID: <2cba8450-9f52-4131-8dd0-47210826b6b4@embeddedor.com>
Date: Fri, 28 Feb 2025 12:07:58 +1030
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: patchwork-bot+netdevbpf@kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z76HzPW1dFTLOSSy@kspp>
 <174070615348.1621364.6459318760619423212.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <174070615348.1621364.6459318760619423212.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tnpKQ-000000036Gj-1EMq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.158]) [45.124.203.140]:53803
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNiP2g4Tt+c2f5thjT9bLkTg03MlsaReL0f3KAA/+q6DqoKImZnuJoiXWxWhvxoBnqxfX4WI2M3+Y8vZi+kO85SIoBKcNC0t4KRQE7eKdouOXP/Wvnmz
 w1LGvcXSD2kBKQKRxRpCbvmUQVptcyaJx3SHaIHYZSzawcn02tTmZH1Ze2Y8BMoFn7XVtmw4mS6BHv0R3LZxrGYFiAYm/cg7nrWIh3WhoX+tfXuuHfnJwWR8

> This patch was applied to netdev/net-next.git (main)

Awesome. :)

Thank you, guys.
--
Gustavo

