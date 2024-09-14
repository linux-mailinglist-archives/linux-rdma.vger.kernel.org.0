Return-Path: <linux-rdma+bounces-4943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AC978CB4
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 04:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352E01C21D4F
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275FC8C7;
	Sat, 14 Sep 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="DtIrMPTT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA62F24;
	Sat, 14 Sep 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726279969; cv=none; b=RzrZBhkPd2WGFXDIocN0tWvoL7aUerr1mKy5/olwVe+TctY103r0MsIhE+8XCotMfvpoNBU1KtEW7SqgDEmMXjb5Wvlq+sMBQCorfmqlNc+V1G/wPf5NaWMLxBhX+P/7veqe/LfYsZgdguTVFrZkFBRY3gZG+fHSX2pD9kZhqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726279969; c=relaxed/simple;
	bh=G0nJyBmj3VUsf2JzsWWPxhsSR7+cfwPdpD5U+nbh5CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmsZOZOFOi9fOw2SnzgwXkxJptlfZWyQkFgALXxISdZNUswCOtAeizoBjcqs2ws1iFerwjq+9Fk2ifLD6FXuJUcEd3IMjQS7weTVvrr73zDqkldFzT+NWXKsh+b0Ezmq4KRR+FcD0++8lMTQqL/rdf8a9fXiE2uDn1vS/qpg2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=DtIrMPTT; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48E2C2BX012622
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 14 Sep 2024 04:12:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726279928; bh=G0IQjnC9Z4j5bgt24Uw21tvGgqTZhtqPZhCt0RIK0vI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtIrMPTTwZSkB4UwrYRvbhNocUQFDFgw2NWYME/JAdVKA+0jHPObl0KtkQMVfz/lj
	 JCKf674oC/JahfuwaK8hEYWWYpJOfbxR29jHob75pD1XWtmNTABkScczjfKPMXlFCk
	 jqxxRbn8kfxPhNul9HOGEG7sKecl3+BNgo5D+6xE=
Message-ID: <6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
Date: Fri, 13 Sep 2024 19:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <20240913135510.1c760f97@kernel.org>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <20240913135510.1c760f97@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13.09.2024 at 13:55, Jakub Kicinski wrote:
> On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Olędzki wrote:
>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>
>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>> as close as possible to each other.
>>
>> Simplify the logic for selecting SFF_8436 vs SFF_8636.
> 
> Minor process suggestion, I think you may be sending the patches one by
> one. It's best to format them into a new directory and send all at once
> with git send-email. Add a cover letter, too.
> 

Thanks, yes, will do for v2. I assume this needs to wait for about two weeks for net-next to re-open?

Krzysztof

