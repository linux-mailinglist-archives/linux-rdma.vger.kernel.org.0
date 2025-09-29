Return-Path: <linux-rdma+bounces-13729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC6BAA4BF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614E3192238F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D62243387;
	Mon, 29 Sep 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzdtXT+1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EE2405EC;
	Mon, 29 Sep 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170614; cv=none; b=MjJ4v6nGKz+KROHHPqGYjenGq4dwlwzZLL4GJYDWwOfwIpvUo6PMaytoaE4Wdv/3G/4tGhwjakADO6476hpqoTLFZyVgs6a6ZzYxVwbXZ4hCrjZBwXcsgSpsXoSE0FBrGuWuUZ1i+vFDmhrsHLzyq4gN85Qq2foW5Ik6xCPrBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170614; c=relaxed/simple;
	bh=rJ2qz3X9zXmAr8f5ULFf/IOmDoZ3cSKZpUCMR3PZM4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5h3d37apms7QZmLguY/lCybcMBMXMkDcihROKRC5qJGxHsEdCsujE9w+w/bLLGB7RxxA0tOQgnBMiR1Pene7UnK+1hn6Qo73po40T7m/9ftHdEsdYBx7XaRcXcHUURFR80MQAf49hTK/JEU1edEcIoYegKICGyp2YjtcUuf/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzdtXT+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09FAC4CEF4;
	Mon, 29 Sep 2025 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759170610;
	bh=rJ2qz3X9zXmAr8f5ULFf/IOmDoZ3cSKZpUCMR3PZM4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PzdtXT+1eDllY8w+VOqFihbNZrHe9bw1aPUFZRrOIwVJhDTs+XjAFvLEH/imbx3qH
	 1IM/vNzAiSo20pxBMPJdqndAk1v5FCythLckQfAhVZ+nYgmh3Pn8NDqPIpZTT5PA/Z
	 NqlcqQWFoHZbDvpbc5lkRrTsB5JW5JJdFfFSE8OE0g1ueXkp3F7ijznW9bQQD+8Q0O
	 +aWo898dVNgjANsERCrWzM7ucMkAtkumxIX3fAA2zxbQCAx4e5rEe7gSRdPIm+h9wi
	 TsGQyq6cyTQY2ENEa4g8a1Gc+HRDWpIHn1x+SrlHpmwx5VIRvvpTwA967V0U6FkJHC
	 TEQxQ2DMWRrZw==
Message-ID: <2d23db3f-27fb-4f9c-b516-97b5687f2a36@kernel.org>
Date: Mon, 29 Sep 2025 19:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 13/14] dibs: Move data path to dibs layer:
 manual merge
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>,
 Julian Ruess <julianr@linux.ibm.com>, Aswin Karuvally <aswin@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shannon Nelson <sln@onemain.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
 <20250918110500.1731261-14-wintera@linux.ibm.com>
 <74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
 <20250925105733.040604ca@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250925105733.040604ca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

(Sorry for the delay, I was travelling)

On 25/09/2025 18:57, Jakub Kicinski wrote:
> On Wed, 24 Sep 2025 10:07:35 +0100 Matthieu Baerts wrote:
>> Regarding this conflict, I hope the resolution is correct. The patch
>> from 'net' was modifying 'net/smc/smc_loopback.c' in
>> smc_lo_register_dmb() and __smc_lo_unregister_dmb(). I applied the same
>> modifications in 'drivers/dibs/dibs_loopback.c', in
>> dibs_lo_register_dmb() and __dibs_lo_unregister_dmb(). In net-next,
>> kfree(cpu_addr) was used instead of kvfree(cpu_addr), but this was done
>> on purpose. Also, I had to include mm.h to be able to build this driver.
>> I also attached a simple diff of the modifications I did.
> 
> Thanks a lot for sharing the resolutions!

You are very welcome!

>> Note: no rerere cache is available for this kind of conflicts.
> 
> BTW have you figured out how to resolve that automatically?
> NIPA does trusts rerere but because it didn't work we were running
> without net for the last few days (knowingly) :(

When I was in charge of supporting MPTCP on top of a few old stable
kernels, and keeping new features in sync on all these kernels, I ended
up automating the resolution of such conflicts. In my case, I was
cherry-picking patches, and I could then simply take a fingerprint based
on the 'git diff' output without the index and lines numbers. With the
hash of the diff, I could either create or get the corresponding
'.patch' file can be automatically applied with the 'patch' command to
resolve the conflicts.

In your case, you are merging trees that are regularly changing, if I'm
not mistaken. In this case, the fingerprint should not be based on
everything pending during the merge, but I guess it should be possible
to get a fingerprint, e.g. a diff showing the conflicts.

Note that in the MPTCP tree, we use 'TopGit' [1], and our tree is
regularly synced with 'net' and 'net-next'. When there are conflicts, I
only have to fix them once, because TopGit merges multiple branches and
keep a continuous history. That's another solution, but it might not be
adapted to NIPA's needs.

[1] https://mackyle.github.io/topgit/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


