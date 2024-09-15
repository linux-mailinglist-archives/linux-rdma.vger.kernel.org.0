Return-Path: <linux-rdma+bounces-4949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E536979466
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 04:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A67B22BBF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AE748D;
	Sun, 15 Sep 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="ilEhHjem"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FFC8CE;
	Sun, 15 Sep 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366939; cv=none; b=owWq/MU7GWRKsPz+Ilix0BPD+stciEGOjEjyxfIRgpCtxf3GyJupRa7cd1Wqrh5CCJN7isMXN3/6aMEc1OwTDmePrK5BhUtvlm1Ie+Drh+DbtBLxz30pkFxRFliCPILDj7VcrlthLg+ETmaoXDeOZCalNx+ykrjgQMhQe3yFJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366939; c=relaxed/simple;
	bh=Qhv9sjisXssLByDeTW4sElfpfjfZTcPFI8JsS5SNhZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWPxHgm5LmJ8CzlNIN9+SrqNRrDoxdrz/cNXcb/dgF8gBn79MMu99P9xSqXIEYkP5BbpxOMizhFUuaxXLbJzGKT1Q32bZnCkEOvp9SCX7zLiU+jjtY1heNFc3kpTE1RgYqmnLwkPbL+k7dykjoYLzVGWDsbcDOSSMoTZVaSb0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=ilEhHjem; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48F2LUOP000569
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 15 Sep 2024 04:21:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726366896; bh=LR47unBQVogBjHIoDXQHW8rlU0C4v2wh3MS9cFAlQEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ilEhHjemej77iuafYA0UKbUucMwIgCuCNrbyn22efeLEkGMWQtWbrxJcYmxzQw5Cs
	 KCgwX1e5KMI/iptY6PDZTA8+RSR8Yqjx8jPMtTCljA/hlXoD1X9p4W+nRMm4BUtkde
	 6kdHpjisL7a8wahTQdp0q2eoslox4TkKuZHdUUIY=
Message-ID: <528f30ca-5434-4f75-9587-c253c934bfc1@ans.pl>
Date: Sat, 14 Sep 2024 19:21:28 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <20240913135510.1c760f97@kernel.org>
 <6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
 <20240913194808.43932def@kernel.org> <20240914082156.GB8319@kernel.org>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <20240914082156.GB8319@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.09.2024 at 01:21, Simon Horman wrote:
> On Fri, Sep 13, 2024 at 07:48:08PM -0700, Jakub Kicinski wrote:
>> On Fri, 13 Sep 2024 19:12:01 -0700 Krzysztof Olędzki wrote:
>>> On 13.09.2024 at 13:55, Jakub Kicinski wrote:
>>>> On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Olędzki wrote:  
>>>>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>>>>
>>>>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>>>>> as close as possible to each other.
>>>>>
>>>>> Simplify the logic for selecting SFF_8436 vs SFF_8636.  
>>>>
>>>> Minor process suggestion, I think you may be sending the patches one by
>>>> one. It's best to format them into a new directory and send all at once
>>>> with git send-email. Add a cover letter, too.
>>>>   
>>>
>>> Thanks, yes, will do for v2. I assume this needs to wait for about
>>> two weeks for net-next to re-open?
>>
>> The cleanups - yes, but if patch 3 works you should make it independent
>> and send as a fix (and trees never close for fixes).
> 
> Hi Krzysztof,
> 
> Just to expand on what Jakub wrote a little. In general fixes should have a
> Fixes tag and be targeted at the net tree.
> 
> 	Subject: [PATCH net] ...
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html

Yes, thank you Simon for the additional feedback.

I initially targeted net-next following Ido's request:
 https://lore.kernel.org/netdev/Ztna8O1ZGUc4kvKJ@shredder.mtl.com/

If we all believe "net" is the right target, I'm more than happy to update it and re-send that single
patch now. Should I mark it as "v2" even if no difference because of the tree change?

Also, I did include Fixes in that patch:
 Fixes: f5826c8c9d57 ("net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure")
 Fixes: 32a173c7f9e9 ("net/mlx4_core: Introduce mlx4_get_module_info for cable module info reading")

See: https://lore.kernel.org/netdev/2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl/

Thanks,
 Krzysztof

