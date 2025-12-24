Return-Path: <linux-rdma+bounces-15208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD543CDBAD4
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB3D6300DBA0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FEC32E749;
	Wed, 24 Dec 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="O3fkwGEd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635132E728
	for <linux-rdma@vger.kernel.org>; Wed, 24 Dec 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766565205; cv=none; b=slHwluwnQZkXUT3nMb2esqAOMMnc2qKu45MEBf5tLpsG1EhVr8u/wpQqoz2vZmfecHUomZeIyIMPqzfeht8tex8Rw+SM3C5E5GeZ1Y4rqSu/w/OeL1hWRPn5gcKsREo3rWZCdC31dixa8tS8EWvN4fy8v5yLGF1OU+atjTzedIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766565205; c=relaxed/simple;
	bh=UQ7fWqhrk4BDlC41m9Dku6MHHbeNLNllW2pWurqgdhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQd/O8yG0WymJNBzxsO8ps3YLuqTT58AAB4nCI0O5VkrxF9oZYU2qw5nMopyDeing0Dp2tqsS73C10CvM4y67cvvyxXS6CsQ4Pyq+B+yZrInM6GT3Lpg4EQyp0WEw3b93fhvhqbQbn90y30hq/K2MXzBgUgHaAcCgyKEP5XIRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=O3fkwGEd; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id YJmuviXw6KXDJYKJ2v3TMu; Wed, 24 Dec 2025 08:33:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YKJ1vPkuSHSQMYKJ2vCIqs; Wed, 24 Dec 2025 08:33:16 +0000
X-Authority-Analysis: v=2.4 cv=GIQIEvNK c=1 sm=1 tr=0 ts=694ba54c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=WQzkbIxKHun9VTyIaSsA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UQ7fWqhrk4BDlC41m9Dku6MHHbeNLNllW2pWurqgdhk=; b=O3fkwGEdmPbXMaKcGvRk4sArq6
	HUg0DOzgDGftzA7JRtOdLWaB+PLsP7MZVKPfSe6hkzBqW9uQrWeNNscxbpSSYC1/jy+ctCwrTtnJP
	WCak6iTquleRP2p27YNHo8ZU1TxsKEK6iIHA0ac1VQuh60o2dCkWn1yB6SDVQ4AEXEqcH8nQgR13f
	pgkfcdk196Y58jnRQ75zb7vRGx3wIDOktODtyo/qUeCKMtSJTUErcdb/lnGxjfaGSaVXmrfgAzO5A
	JEq/XcbqHJOZlVNFbIu6hPOOjqWv+pZYg/e7cLub5ADDpX3P6N3dXLRfNMSDCg3iEhxWplj90696y
	wdTgBHBA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:61551 helo=[10.242.145.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vYKIz-00000000ZE4-3MQU;
	Wed, 24 Dec 2025 02:33:15 -0600
Message-ID: <62e3bf9f-3dd2-4fc9-b661-cacc93e84de9@embeddedor.com>
Date: Wed, 24 Dec 2025 17:32:27 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Sword <gregsword0@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <d1ecf8f9-5595-48fb-a694-41a542860986@embeddedor.com>
 <CAEz=LcvVgX8VA4M3TJM38NXrhyx-QohBdSoZOG=p3X9pbTY4pA@mail.gmail.com>
 <d4f60741-b0af-4a51-a1dc-cded1f34f309@embeddedor.com>
 <CAEz=LcsLXuAiQ0Rv0Z7E9mV35Qd92xxGsoSdDFBT8F1AdfZcoA@mail.gmail.com>
 <911ba345-7da6-4d05-955a-d33dd4b1e8c8@embeddedor.com>
 <20251224065107.GD11869@unreal>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251224065107.GD11869@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vYKIz-00000000ZE4-3MQU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.242.145.44]) [118.18.233.1]:61551
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGTqKZ3hguxT46nvjygJwp87oAUF79geOvnw6TMghl41zOvShR+sbledondsWn95xPdNCTJtTp38/tanRVHkV23g19gpHXHzchoPfAmtaqLVs2uCjJCz
 RFGyfU8NsWBWOzpXrO0m3fgAz1E2vKExq64CROQJzVnW/fMdVcfrmvv65xVZpHudLgvZDXCfs33JfbJEcDwQlK7KOY2kZeasryCLK+76BbxDXRcJ7ubZMzfX

> So please remember that both of you want the same thing, and let's keep the
> discussion focused on the technical issues.

Absolutely, we all care about the same and, to me, this[1] really marked
the end of this thread. So, thanks for your intervention, and thanks
Zhu for addressing that issue.

On my side, I'm off the rest of the year. Enjoy some time away from the
keyboard everyone, and happy holidays to those who have the chance.

-Gustavo

[1] https://lore.kernel.org/linux-rdma/20251223142055.GC11869@unreal/

