Return-Path: <linux-rdma+bounces-8473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1CA56946
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 14:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC703B24D4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA91219A79;
	Fri,  7 Mar 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vrtbW5Tf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6C2581;
	Fri,  7 Mar 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355187; cv=none; b=qAxw9NBrzGysULXewhoF8aHGdde1nLIF4daMPDXJBHEEv8gGKbchMkk0axpYv6w3vJaOpJMcat9pIhFwCSe6k2vR9h7+R3FmlwJsw09JVAA2TFiZ1iy4vQ76+HDaRsKhkxD6Lsw8cAoJ41jipQJQUMp2kTaUK7N+8PS2J60EUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355187; c=relaxed/simple;
	bh=xe3dq1lMwCjuvas4NThUEA2HM04dL8I/ZpvWQshvHDk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jU4019+fDR2xM0MoZt3QU9izQlwkqlSdmoVu56iTFBUXGGXwtkR/zuEMD288yTCu5YUMXR1hTGMH+lzvMoIxem/8CxIAu/1v0Aw8xmHsilt3gQWAHLzjfA1IC8krga3Igd3+RnBos2plJ73zIl99Da7UIuJcI9bLrJ5gFC/OgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vrtbW5Tf; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741355149; x=1741959949; i=markus.elfring@web.de;
	bh=xe3dq1lMwCjuvas4NThUEA2HM04dL8I/ZpvWQshvHDk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vrtbW5TfKJndneNcCEsATPw+2baTk8MpsW2GdZwgiY7A5P6n4RIEVv5mFz87p0vj
	 Oge8j2btcIQr+M3yGxbxHBzUK3SAL+R+xtF5zU/s0gYOnRzQT5ahcdM/irLWhfv73
	 pYRR5NgP2kGtjigBBfGV0MOiQvCkxXWWUm9S7Io3omPiRdeD1Js/B245Opgu4qKdd
	 OUAj4mXW2quI66zdQ+pzAS/E7G3a+qxIJdD7nlfw4wigURiT8lLYBK3Eg46+wvP8H
	 6sLlcsB2S01UWlrXexTgdIpLoM8LsgRQ3LMRJStn3oSpDmkF8WAEfrMOrlIbVV8UC
	 ZTHy9DogR9ibU1FoBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1taGDp47oj-00NlvY; Fri, 07
 Mar 2025 14:45:49 +0100
Message-ID: <153efbda-0e3c-493a-bbb1-a60341acb557@web.de>
Date: Fri, 7 Mar 2025 14:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250307021820.2646-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH net v4?] net/mlx5: handle errors in
 mlx5_chains_create_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250307021820.2646-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tmYN2Pjofv/eiFN8bLxU4cNyOa4V1SX0XeJ73cPWkyyhv2sJ43M
 iJae9DYN8uWgVwUGhoSESz1uk+EEbybfaSwQUIIdd44iYGr5etE5upuzx0A1Bp6441ggAlA
 M9QJRVr4jWahZLO5F9TaAZIxiYLzaAtgDh/qTl5zhlmwiXXpME2FvU1Je5oRAdwRGuYuI1a
 iz/l4A5b0DBDDLdhtST5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jYSBPqJ6fR8=;G4NRJm53FT3Ae4/aC4bR2KlNT/0
 l/apEsQ/2l57MUGUXpGDaERnaq1AOf2v3OVHtD0vKBgiJLE4pqHe6i3FM+Okzwvcy1dQTBIO0
 /Z/IxFewHKFbi+6BAhJ1GWDOZt0wmn3jHo2GSGzghEe3+B9nnGKcylpvhDEFPc4BJGD+zYOkj
 WzAOYo/X3/tw63S0pmalZ21qEuw91cHgUp4LEHVMI4tX1odUAu2DCixbYNq/N6YaRQeZbVESs
 Nf3/8pnN4+SrTu7DJQrSQOMavEpYFpXVV3HM0encZ6n4t6ymaaO/wU7JE4FyMFiaABysgRl/Y
 v7QSkBghO2d89NH4ONvcMkPWnLD0Myu0OP7n7EfOgOfSeq9KK4DCvFJmVLkiVoXg4sj1yxl41
 eopPLWOTqzG1yGd6WKf6simSY8YmZxN7lNbGYjFfvgMP7t5iAr/CdFcOWm7u4/69X9D3qk89Y
 o8Vecf/1xGPnPYR3HgFuwXzkvt0JgXbJ7p2xx+hgeMIpDrBxLHbaZyF9+7LgcoSJO4RrCKE6D
 sVka5CXqSrsx2j5FzOAuXd1iJWkFR4x+/gqA7AcGa/KLD2/8uhhpd+4taZk8nmILC2AKI3Nhk
 DmYaM4bsFp9q0kssRBsIbHvqxUEotKaP77KzOTtqRqxTRLswi9MPOV3/VC6Qv5PtZK9eXH1LS
 +bXHXIdVj56SDCwYZ9hnBSThuNhA/eGRFfM//9XFK6dZmGhd77BsvbjHn0ifTe+wBslZZ0ZxI
 pVBHitdpcbwQEXPSqAugahpnEG9g8ACfyunh9yRH9ItLLiLJmA94ZrDkL6bxhqm9Sx6IdEPT8
 UNCV+iWXKk52+BsS4Ly8yIXneiWU3wA69RjYPRb7q0WdaiQFfFTrHokr65HKQCqQrby26FtM5
 e6ROzd5kfm1QPteOpDYtmO3lEMEsmXfR1aZZj/eKN5kkiSP4U7yCQ9+w1QM2KOyvxxpSdE3C+
 6J+5OFYGAYaSRkFBMpzJWaSPL2ctO7LybahJprJl8zaHegoQPhjbw7P1lcVrvshsHJ6Xv6HcC
 1DWanzhP/69Y26NawIRIfGbRA7HmkZAsTgzB5CTLd1WMrxLBtue3mRPUO21z1SSRmL4n57OEX
 hj2q877lDSQebXMLSOsfWC0ZRjIOKE4U1eGoLTJTMjoy6xwm6KQCL1zyHR5ecTp6w613kGAfy
 AsLmuyt0d/+ihX1pnF9gBjB5p7EkSYDz9fcvLDnr2dzZXb6nL/GgqINidrKCnBY7Ek0d17jjp
 bDw5xy370+9DaXm7aY4qK92TXMOzWiDEh74e/BQ64BtUU/lsbNVu4rIptOUu0rsRNbTO2KkNA
 NcFKFwjMyxdyVnhFaE58lrZ6zEBhFPN+/+dXS32nk3jSI/hfnxVNlBYEwXCsmFBalGdAumyS0
 5hFJ73QGYvQTJV4M2T3nZWvuDFHKrjBg/r0vNI2lG3zGnl+B1SUW4SsSRokDe48VhSVV/lMsd
 qFJHeiw==

I suggest to reconsider the patch version number selection once more.


> In mlx5_chains_create_table(), the return value of mlx5_get_fdb_sub_ns()
> and mlx5_get_flow_namespace() must be checked to prevent NULL pointer
> dereferences. If either function fails, the function should log error
> message with mlx5_core_warn() and return error pointer.

Please improve such a change description another bit.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc5#n94

Regards,
Markus

