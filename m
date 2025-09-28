Return-Path: <linux-rdma+bounces-13701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235ABA716B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C7F18975FD
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BAD214A93;
	Sun, 28 Sep 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qWLpetk1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B42185B67;
	Sun, 28 Sep 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068980; cv=none; b=hqu79oz1CIsDSUS0Ik9y2uldSN8OrEaChfjf8OvpBMVrjYvhraaTE7FnZTI7ay/yv/Ch4ay9cMMvaDCY8DLjOhgIW/s9F1slaxgIOUUwfT8zg4nYSfjeHa98+BS/lPp+HfM3D/FmFWYaPDq5okVpj6IGSAUsEudnuMe0t+9KTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068980; c=relaxed/simple;
	bh=AcVJZ3zjTGDdL14Tw7LuQrtPZgPW/ebeShaSrL2ipR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoJfxcziM+H0+Z3Uk9nkCCLtt/C/VblgCrWoFa8iUwbl4rJnyY6KN/UJjDyX9eE/lsdgQBAT+ql9T2pO9S+z0OW8cpEAyRLdD7YdejicKZaUNBni8Gd3NfrxKTh6bzIkPLrvOS7DdtO3UCX2acFPKN6fSsX0SepW1ZH+xwpc3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qWLpetk1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759068967; x=1759673767; i=markus.elfring@web.de;
	bh=AcVJZ3zjTGDdL14Tw7LuQrtPZgPW/ebeShaSrL2ipR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qWLpetk1NOdGaf834cP6bUAVVXFqBWk7p79h8VsWG+rMBT72O5Bv3ZigEEmNtFKV
	 jMaAd2xrXQ84vKBBNU6caX4n7t+3Bsk8SP/LJAI8OHifh4z0Z0BgauwRQD10fRg1f
	 jlgdq0KQWgv1W7JlTdHoleFzrUeq/0pVuHL3WplNzwi6Towj0vqVz9sRCDhc3Xgae
	 XCilKeizePykF6FAbgB7Uh74SjUSWpm2U0sfymlJT8eV+k/L8UijxNTRUdXk8XOuP
	 OOc0jyet1l+rvi3zWPKgpYee4joYQwue67BcociliLSYbfhOB51cMCAWhgNsT+UlK
	 aL1FrLD57fdNC5wY2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1uYGT13572-00qilt; Sun, 28
 Sep 2025 16:16:07 +0200
Message-ID: <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
Date: Sun, 28 Sep 2025 16:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0hatDYEYy2uD29QN3EaTBTxU5tOZ6ZzrC5GplzxlKO1EXaS/LXk
 wOxwomn9HNCRV8/CAKUNk3V473/donib2HWXdP9U+DaiKTBXcI/8HRRbDitvM2ak8deQQfC
 B2pqx+kHnv9qLO/oGNZnhaBbkvZkaVazKppZV+65sxD4/zkl6hCi/7Qsw+b5ExD7OK1o5O2
 j2HWjmR1BqaT70uYtC/wA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z4NZJCk4/dw=;dA3orOOxN1X2hVgjehhdf9uVwzt
 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
 03S+Q==

>>>>> +virtual context
>>>>> +virtual org
>>>>> +virtual report
>>>>
>>>> The restriction on the support for three operation modes will need fu=
rther development considerations.
>>>
>>> I don't understand what you mean?
>>
>> The development status might be unclear for the handling of a varying n=
umber of operation modes
>> by coccicheck rules, isn't it?
>=20
> I'm sorry, I still don't understand what you mean (the problem is likely
> on my side).

The development status is evolving somehow.


> Do you want me to change anything?

You would like to achieve further software refinements.
Did you notice remaining open issues from public information sources?


>>>>> +p << r.p;
>>>>> +@@
>>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print=
 PTR_ERR()")
>>>>
>>>> I suggest to reconsider the implementation detail once more
>>>> if the SmPL asterisk functionality fits really to the operation modes=
 =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.
>>>>
>>>> The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also wi=
thout an extra position variable,
>>>> can't it?
>>>
>>> Can you please explain?
>>
>> Are you aware of data format requirements here?
>=20
> Apparently not, I'll be glad to learn.

Each =E2=80=9Coperation mode=E2=80=9D is connected with a known data forma=
t.
The corresponding software documentation is probably still improvable.
Can you determine data format distinctions from published coccicheck scrip=
ts
(and related development discussions)?

Regards,
Markus

