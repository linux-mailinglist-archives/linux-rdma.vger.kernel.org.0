Return-Path: <linux-rdma+bounces-13094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F2B44547
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 20:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB01A47464
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 18:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D4342CB6;
	Thu,  4 Sep 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HBmN3SnX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A7342C9C;
	Thu,  4 Sep 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010362; cv=none; b=TswZ9j2c1U9v4QOJB5eixzPTtArJZcl2sFXTWqlx1qpNacq/wOdESnAmVJVg8LtGzfG+LtJQZQNCIMqyNscvtAi6aF3fvvFZu7/d2OvdBs2oid9V2tlqbVdNAf1gGv78cJHTua+5SdedyOqKCwsP7Rg3JI5j2zOo4j79wZe/xfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010362; c=relaxed/simple;
	bh=+tteNLx9opozrh1s8Efp+6clgTIu9P57fY5cwnZi94A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Dr2HCf/cFBvbJMTFdX+EiHAi4RDwB9+kYYQJP0ERbi8zHluWmSjNJPYkA+Riq/BCzYqHJ2bPZdOKwfOPbbgwqDDtHL39gLBeG+FtLkNelGIMqin0KfCnPUbzrBW+uWEBtOHb+sec/q3J/cxh2LLNZw7rOMnypQD1ITEfySKM4lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HBmN3SnX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757010335; x=1757615135; i=markus.elfring@web.de;
	bh=AxrXcyH9yQHDLWNeHJjAZYu3Zod7lCovQeXx09PsYAA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HBmN3SnX4I+aK+YhRllSRifvY6VFm94Wyq7C5wa3doujWMyst2+y6XS4NdpYtZyL
	 e7z+tDex3YWab5BC8J506X93swI5qtOQXLPYp71NjExDntSGbYOETUmVoxzaZVXcH
	 bwZoa1v2IG+VRmhUPeOWB6Ru67LgAuz/Zu4beLoh+2N8oIK1fEQWQo6RaioIuE0yA
	 ICrXR2fva3SS1pIA53QFwfAvBdnyrrpp6fwy5cWxDXAONOf6F8JM4qyqgpQMKK1Ok
	 TRLMkPTyZqJbiaenA6Sr2FOWFrhE2/SpB3R/FhKgW3I8J4IxzFhE4dZIvGcKYmkSc
	 8iM90iss4yBpyclKkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.243]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1uhbbR2BGs-00Girz; Thu, 04
 Sep 2025 20:25:35 +0200
Message-ID: <c9f68648-8231-455f-adcf-eec83a282e4b@web.de>
Date: Thu, 4 Sep 2025 20:25:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Makar Semyonov <m.semenov@tssltd.ru>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>
References: <20250904140858.1690639-1-m.semenov@tssltd.ru>
Subject: Re: [PATCH 1/2] eth: mlx5: fix double free of flow_table groups on
 allocation failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250904140858.1690639-1-m.semenov@tssltd.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9O+Dw4A/WU71jMlPHXMsJnEC886sjLXmFlhRnyH72BAeTPFddtz
 KtnNHDXdbo+PCLbKUxH8rQlLWsc8+jCvh4S1Ebd51rxUO11uBTHJMCDZul3g/kCtOCwPjH8
 hgek5LBlQ21TJF6rR+Pc+Ee8WlOkXFniHvketp9kg0YRx8Xi8NDR8ZaEwStrnmE1xfCwGCK
 A9lcyXv063QKUz6SmJQzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kauTz5nALZo=;c/umTDZRCnY293/zQjo+ygU91TX
 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
 1qkcHxoCNIkJg2gmFQbjnuGwGWGeN/Pg==

=E2=80=A6
> This commit fixes the issue by =E2=80=A6

* See also:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n94

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Would you like to reconsider the numbers in the subject prefix?


Regards,
Markus

