Return-Path: <linux-rdma+bounces-12839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82920B2DF7C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B388188458C
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6192609EE;
	Wed, 20 Aug 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ExXxeslR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABE26CE0F;
	Wed, 20 Aug 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700486; cv=none; b=AEzKt2P4Z+pYWUdImg2oUsQyOi3zAayaboeJIwVwWyy8HbNcoo88+yrBAdRKUPjh8ntmGzOWjuq6J2Ka3k78uNY/zapSnYr2AyZVRxWMJ7y0FkB9XrVp6zZu6mPaj8lRaSGaSO93xRQd8lK+Stut9NejS3adaIl/lYmFFm2eYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700486; c=relaxed/simple;
	bh=JO5yfw1jePeKpa6tz/uHQ68bs90Q841AXFtyOtjtMCg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=dYvtyBkCSG0DDvaqPkBBAHzTsPK/YOnrRhlfCZgEBRaDF3VaapSFoD4tPUGZ9q4aWp5enuu37BNYys11SVFGWRxPg9rbkkAXm7LJBVWLfr7HB1y+uU4dV585rN/W4coOcmQClrTYTRCi9hZW8fKseCBhanmZv8GjSU1R1j+VOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ExXxeslR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755700459; x=1756305259; i=markus.elfring@web.de;
	bh=toIjmxbvBmy6y6/C8Y4006Ts6phvbymA50PNKpKdUYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ExXxeslRIXAzQC7isZUM5Yxxu4030e3stvTpJqNZkuJ4732r9OgTuaXmgznMIJOd
	 eqb6P2ADACreMNeh9Mr5eFJdxHfBGuiQGfAujOavl3X9o4HbupZKJqzskrlBNOHo3
	 eipj2uA3R9ZMMWBXqfVdpaDRxp1H9fWBd6aauDsFeXttjRvjS6L8dwQ8Mi1H/iQXf
	 oYVa9Pyu7airS++ndpzpyrcGiZXHJ3RkvSbr5uhWzC2V0f9kEQr+wxzCEBMJnTnHP
	 QYviPaAD34FTtIogMISgsDc63Et/I/Kz0IegWpqbN75wGEpo+mIuaFX7/danA4tEh
	 v5pE7InHQen7vhFGYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALiZ-1uiRYO0jMZ-00EH1t; Wed, 20
 Aug 2025 16:34:19 +0200
Message-ID: <e8a8404b-b524-4d9e-b0de-d743acf8d7b4@web.de>
Date: Wed, 20 Aug 2025 16:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qianfeng Rong <rongqianfeng@vivo.com>, linux-rdma@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Cheng Xu
 <chengyou@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
References: <20250820132132.504099-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] RDMA/erdma: Use vcalloc() instead of vzalloc()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250820132132.504099-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pOlsOCo1whUL+u1QcSKTztWPbfp76Pzojzh9mYBu8mXsMBYoOvM
 jT+5P9sSGiPQ8li71FdylRwHv9/llB1KXwA3IeUzfP9liyVyiz7hBA+kPNUOWEcjvYBmU/4
 CRUIO0zR5A7O/NdGXjx5xe5bPUgdq2ueqeM+aOzhNiMg1FxXW9LMTzv6hPSPGooOD1IPl7/
 hU1za4nbrn/4Ow5g6cuUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r6RU7Eu54xU=;rfeA2hG+w70sxhfVmM6sNfFFj/g
 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

> Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs(). =E2=80=A6



=E2=80=A6
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *de=
v, dma_addr_t **dma_addrs,
> =20
>  	npages =3D (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
>  		 PAGE_SHIFT;
> -	pg_dma =3D vzalloc(npages * sizeof(dma_addr_t));
> +	pg_dma =3D vcalloc(npages, sizeof(dma_addr_t));
=E2=80=A6

How do you think about to adjust also the size determination?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17-rc2#n944

	pg_dma =3D vcalloc(npages, sizeof(*pg_dma));


Regards,
Markus

