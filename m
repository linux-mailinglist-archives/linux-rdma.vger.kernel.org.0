Return-Path: <linux-rdma+bounces-13697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0BBA7048
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 14:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46462189861B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562D25A35F;
	Sun, 28 Sep 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="klqOJub7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9494C98;
	Sun, 28 Sep 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759060854; cv=none; b=CC6pxGqc1V/HtpBnpLSCMWWyPcucK26MERE+q5CjkzxioBTsph1S3it/wDzizfJm7A6IWqTqdX1r0Skm9XuKj7nJHb4E1IIXeNLAkBV1VMc6zUaLjD4atfQrXsrQZPTupBy7EUPe+l1zMT6z1rqdhS+4KJmpYjfU4GIJWVhjJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759060854; c=relaxed/simple;
	bh=5kSYwI1fExW/VBymyR86n7aGbGDd7UxkPNzpe285Cuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0V8wWtcOdAVGt+aEfvEgKNj21yM2XN5ppfDDBIq8VGDCSFXgoiFcm1ma/LT4s+5/YnbZOwqxTs7yuuF7rT1zI3PXodQgdKUyTXEfuWwqsBe+O/wTLKsXiMdo58NVRKhZ5Fh++H/SXOdnaBsm8PMWtEKqO00LmEXL42wm7HqG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=klqOJub7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759060833; x=1759665633; i=markus.elfring@web.de;
	bh=5kSYwI1fExW/VBymyR86n7aGbGDd7UxkPNzpe285Cuo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=klqOJub7aVEase4NRs9heDLJlXSe81jwoJN0cLW2VhydwqvXrHFaMe5QOzPnL53t
	 w7ZMtpJvf22W1Zs4+w3P8juPYs2rXFUp+/+cGoVJz71YgLZfeFaG2acmD6xBgLdm1
	 0dZNmsiLIFz+Clt1ajr9T1I6ZAyjpQSr+B3Qv/zykO4XCmKJewEwYMizvU98apB2H
	 whrvV2wI5romcXzYiNocI1nJ5KnwG8bU+Q+anu1fj8p6UC5cYR5V87gLA5E4dV3vE
	 QNr9Xdhbs4BxEdm8+j000Qj+23D6+m9njBMPS0Yb16FZJek8CaM5oTaEG0dcba/8k
	 Y3f15ic6lsiWf3bMmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1urbeC20AD-00TjJO; Sun, 28
 Sep 2025 14:00:33 +0200
Message-ID: <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
Date: Sun, 28 Sep 2025 14:00:30 +0200
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfRoYHOv6NQNX00nJwlkyn01nCtvVFnA6CNWxWYxczxDu5V7M5M
 lFTjtzJl6c6WhN3yNpedS5tjCPdW5XPZYK3Q0sOTA64oYhaXCAx6yr3CTOCuJYTVj7mu7pP
 JVGnLIQCX7QTCp/yIOckjYa4Sgise9SiYDwEgke2IGX6gl8msx8c6GX5FwHDWCdmciIgEht
 crTONWAzPUibicFTJI/sQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ruhJg9TlPTE=;13uZiVnD11nrb44LTjzDnsZTiSB
 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
 sqzqQ==

>>> +virtual context
>>> +virtual org
>>> +virtual report
>>
>> The restriction on the support for three operation modes will need furt=
her development considerations.
>=20
> I don't understand what you mean?

The development status might be unclear for the handling of a varying numb=
er of operation modes
by coccicheck rules, isn't it?


> I did find "format list" in the documentation, but spatch fails when I
> try to use it.

Which SmPL code variations did you try out?


>> Would it matter to restrict expressions to pointer expressions?
>=20
> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
> didn't find anything. Am I doing it wrong?

Further software improvements can be reconsidered accordingly.


>>> +@script:python depends on r && org@
>>
>> I guess that such an SmPL dependency specification can be simplified a =
bit.
>=20
> You mean drop the depends on r?

You may omit =E2=80=9Cr &&=E2=80=9D (because the rule is referenced by an =
SmPL variable declaration),
can't you?


>>> +p << r.p;
>>> +@@
>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print P=
TR_ERR()")
>>
>> I suggest to reconsider the implementation detail once more
>> if the SmPL asterisk functionality fits really to the operation modes =
=E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.
>>
>> The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also with=
out an extra position variable,
>> can't it?
>=20
> Can you please explain?

Are you aware of data format requirements here?

Regards,
Markus


