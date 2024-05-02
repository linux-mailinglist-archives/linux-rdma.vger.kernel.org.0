Return-Path: <linux-rdma+bounces-2203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C208B94A5
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 08:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8075B2260E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC489219F6;
	Thu,  2 May 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L1+Tp8N+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49721345;
	Thu,  2 May 2024 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631347; cv=none; b=hoo3VlKsdbvh91/EDOCIsGj0dEPUdbfWJih0rEBCGxosSTOcGg9uzW93K0mtVkZoUoffrtDVSVtOvwAtBXPSYMINEafoTJF1WFnPyVHT316y0rWxYCtRZVF/0sv0VuXohn1O8wUJAoRS97i/NgO6PKy4AAVVNJ9vPGAK4rlMNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631347; c=relaxed/simple;
	bh=9FUfT9VaNrtqxQ1YjgvMddICn5YizAP767a8zOUVqPs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z7KuL3QcaeCJ1jiX7qOWQtxti1spUl3+ctriLOtSPC+uRwu6AWTUO3dFFn+5sEIZi85Yd1gW9aI9alvdoixY5MLKZ2P4EcqVlc+r+83ky+OWQ4EKLbwzwWpiqn8XAg5EZ46RbRSexj2JG2koo9f2UA0mXQyqfsxQfGIopFIbG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L1+Tp8N+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714631317; x=1715236117; i=markus.elfring@web.de;
	bh=9FUfT9VaNrtqxQ1YjgvMddICn5YizAP767a8zOUVqPs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L1+Tp8N+2yr3dpPhvozytf5hK2bQj1B5pvBQr30Nji0B20FbHEeeyWk2NWNOyXW5
	 3INMofiEfQ1aFr1yDNp0rBrnGeJWAhKVs7G8uWU6WzKhvNGZ0JL97+Z/98+TZyiKC
	 YbnsaGZ4Ih8w9bbSMnCMBn+nuI+qwh+ED3nGmZ4Hpa9uONNxni6CMLHGbJelMIju9
	 rnpJO6tI8axFYOHTRTgfXRcsTZUwIpEyU764bPHQM2yFHvqqK579RAiC0R6O12tVF
	 4t6wp53YSPblz2HBP1GY9q+MtLHooLWeFc81twbLIFW6OKNQj64a+yUb2p+nCoT5t
	 Z/IbAe6rsIiwtOldCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1sYAJF426v-00eqn4; Thu, 02
 May 2024 08:28:37 +0200
Message-ID: <3a7ed58e-4eb3-46ca-ba1e-98c6a3c40c17@web.de>
Date: Thu, 2 May 2024 08:28:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jules Irenge <jbi.octave@gmail.com>, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Shifeng Li <lishifeng@sangfor.com.cn>, wenglianfa@huawei.com
References: <ZjF1Eedxwhn4JSkz@octinomon.home>
Subject: Re: [PATCH v2] RDMA/core: Remove NULL check before dev_{put, hold}
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZjF1Eedxwhn4JSkz@octinomon.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DDdubhNHr4n90W0v9i3irF7oQhagbTx+mK/lqZcmJcnKCkxYZGz
 /BDn0izav/8uPpbKv7945o5eCQOt+BnL3yZ+syH8xSoh/L5XlJHhC1qzFuum5fcC6KioL/d
 qOq3whKWMyW4jIQ+czuDISh0dW3nGRfgO44Pw8+y1Yk2qOP570b8TzY9OmAnQhGOoGn3sDJ
 WfzFei555EgLXImDafWpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SmLxQDW2y04=;exhhi93XyXFs6mYkVdZXskZ/17p
 DRs5Muvk/wKmelMa4NZy8wkXaQfwee5B+1E9/JKc4eCifjb6h0nYWGX3uWixLl/4b9Vx/8Bcj
 N1lm7ZLty3SDArJeR+f6QfJE/hUCAfoOq/S2ysSH9F4BlGeYSEAl30NeRhuwOC9E1coeF1x4J
 1Jok25WDdiolW+pW0RO0hVZl4op7Nv2Am8sISD7INPJp1KXSRuSWaQTysOhmNtbGC8NxIzG/N
 +vbW68TnRGcacQWtEyxJaioc+92gDJGeg4KcAKNMZkcriS7Z/66cGKakX+LPnwKqWGQKoWj3i
 3oJ7+SxbiBp3p7vbOwbeWNf2NHiFM7QEm8gyCWl8/Pfg3xcJsf7Kz/83roKOtk/ipxPtBBuNc
 FJtjh4kYFu1t7RCbjmE76ADzVl72WfWNstfRDD15iqH9T/rRkp6TDCj6pJDseYoKwjRqSYq/u
 u/UM8m1wi9P76ypzH1o0/lYOy5MyVCSLuGzxEGV4WdFxm/XrOTWU+m1YtFh0sfmdWBNJwgRA7
 kgVtORgPrK2bpbSasZzXkGB1aba17lyhflcYI+eIe12aCMGG1ctoOYXiYJiZf9Uq+Rd7+/rFE
 bRdYGmUUFK552bMmCOxg29iWWy9fTbOFlZxRQDWpj5akqvzppzgzNrwkL5nbdAiFDMwN15wvn
 ld7lljj/ZLiYI3CDnWnqymEoQtwDZgDZsHvRXh58SZpk0sRmkBiSBWPIvQnizMoMw+7ygv9Sk
 KwJM+NCQ5dSwKLh46PyIRwiG0pzUZkYqZ8zpmFLmUBSHqmSBohyP5qBeRlztGUQwlGe7Novdl
 YjQ2hGSIdti3m0/Uffs8OV28P+iFG1lfJkc7Y97sJqXhE=

=E2=80=A6
> There is no need to check before using dev_{put, hold}

How do you think about to improve the change description with a correspond=
ing imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n94

Regards,
Markus

