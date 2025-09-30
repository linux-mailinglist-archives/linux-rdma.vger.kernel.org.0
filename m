Return-Path: <linux-rdma+bounces-13739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E98BAE35D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71004C0FE0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEF30E0FD;
	Tue, 30 Sep 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FvZ/vxC6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF130DEB4;
	Tue, 30 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253743; cv=none; b=Jdluq3BbfL/8vsyd752UqeSPgYpEeZqgJ/PzvMg4aKbXSPCpeOTQuxUkyf79vxScYV7IhbU7WiZmH+aLEkDYTzVz4XRO7TMHQaONml/7tf0qesYPfsx6AxBP3uuqd7gFr2XDrDYjANExuo0IkVCZIp67N4tuNGbGZj7Y1CoxmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253743; c=relaxed/simple;
	bh=Y/Rs5WoF+wLZrzN8PlphZNOI7hxIXeNc83w/Hb0puDs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DRLjkj+YXDEHJwRpXqKor/1SnVvz3JpZWlvsP+0tWTFzQUagx85U3H21SM03Z0p0Cd1U57se9gR9nhbtg6tgseC+VWuH7HM3WlFbF4Eib1uovNWtJR49sAdbptQhkvL9+KY6t7sKcJ23QUAmeScqch2HutzzmK+J2pn8zH83pfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FvZ/vxC6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253732; x=1759858532; i=markus.elfring@web.de;
	bh=Y/Rs5WoF+wLZrzN8PlphZNOI7hxIXeNc83w/Hb0puDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FvZ/vxC6eeZIiVNnQBOctyVHHPU0TMYKCkd7zccGBikMfFSM3IYqIiuBYboU8qFV
	 D0x72RO5ywmYUCkLhCvIWlXJjx3R8+e7Cax83jOd9OW+Ii5QEbgO70JuP08ufdyRO
	 HhqP/R81K9t29s6uMlzhcruiv9aql5GL/+lbPZkrZEk3bYFyVGaT8yojn+bW1lI+R
	 zUCQJc6h12cPQEze8DWCx3oMA12BBLqTRoTBqcJJJtQaJ6aqW10+fbJOTTHq7X5SL
	 gTMD30PZymk4d5vg2SKcaDadXFzB6J3+iIEgqYeInOfRstJ2as+ujbNPGMEBesbLv
	 51aaRIm8EDQLHE1bYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1uG6wR0CJn-017zxZ; Tue, 30
 Sep 2025 19:35:32 +0200
Message-ID: <fdde8ee1-b531-47b2-86af-9f2229351631@web.de>
Date: Tue, 30 Sep 2025 19:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_2/6=5D_Coccinelle=3A_ptr=5Ferr=5Fto=5Fpe=3A_Redu?=
 =?UTF-8?Q?ce_repetition_of_the_key_word_=E2=80=9Cvirtual=E2=80=9D?=
From: Markus Elfring <Markus.Elfring@web.de>
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
References: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fUE0+nNNqjgkL4JVVlPEmUziqhzZ3XUqlFsHjUHsB0Ki7Pz4b/e
 eaXs6IUCyBkHNz4jc5dvRvB+4n+rytSiyyh89oOrntqmJjUdRZ3TOx3yr25Lf3vz55T/2/v
 6tMgOFlrF8pFsaNyfVLgufAO7wkSPnFyQCwsJmCX2cimfqiITElf/3GL1Z1hfa+CuRbvvWD
 qbSxXu2pBn3UYcI9hVGiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2GxwOgLr9o=;cNbNzKq7qGmAOgVGh88eLUmSwsj
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:11:48 +0200

This SmPL script is using three input variables. They can be specified
in a more succinct way. Thus adjust the corresponding SmPL code layout.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 1a373c0a8180..26888d2c9c83 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -10,9 +10,7 @@
 // Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
 // Options: --no-includes --include-headers
=20
-virtual context
-virtual org
-virtual report
+virtual context, report, org
=20
 @r@
 expression ptr;
=2D-=20
2.51.0



