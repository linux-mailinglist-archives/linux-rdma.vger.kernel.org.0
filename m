Return-Path: <linux-rdma+bounces-8362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFCA501C3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048B63B102E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6C024CEE2;
	Wed,  5 Mar 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OlThstys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09924BC18;
	Wed,  5 Mar 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184452; cv=none; b=Alp6AqohuF0yaYyqoOpibynLW5EX2pS4SGsgpb80z7qWbCJCkkKpar1xwprwaHplQ1eU0hkdPIwCL9Qg1NRIioO5k4cN/h4J3Hn0qvIxA0FOkzVXYRiTciRWA2qm3fIvi7QC5Be/wdjTN6LxyuyCSUWm+x3pGzlEFxYERQ8AW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184452; c=relaxed/simple;
	bh=xpcQbs4tyQQ+SW3I3wZ517Ns00JpxHyOOR9gZd4k3L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMkS7Y2wL+xiZrlprRuWCwkG7dE6laCuUaT7zn3br6H35B5BXW0QrmSVq5ZiLXCOyGfei9gNPS4VMy9owiNGS3gcLL1wfTpqqIrZcFH2nRGlzEUYhpvArgNga72oqipUaq4NBpXOL6Z8xWoODTsjAnzeahJMmTCzfo63t/5NZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OlThstys; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741184442; x=1741789242; i=markus.elfring@web.de;
	bh=C1xWGzwYPulTit0Q4OqYEAYIGUZud3a18Yr5KId4AB8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OlThstys6j83TWzkyFcMswl/GOTcM3VEpAu3qt2qK287aJw8yBDslqMH3mQ/imIc
	 ynQHBbnKQG5Ku/za3XWJ5+m3vA/mZH4zv/KYgsSIHBDHSgA7/u7mxkHI9WuyaXFH+
	 uCOkNJq52SDtbgZ/26funprLFb4NWXM8wuA3/+OQHNl5A9761SFHclRVPxQflTdws
	 4RMzskm0NStsYCiPDTo/wZlPopdK1S+5b+wDDYy8uD2xPyKTJXaSkF3TmeymsJi8C
	 w8WQEPCUwEB9J04At8isQwHb9dQy6u8ztBApGfpf4LXZyixHJC30zN1OWrm/jnAZt
	 sMqhz2G6D4M2sdfkXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Fj-1tZX9L08H7-00I6c4; Wed, 05
 Mar 2025 15:20:42 +0100
Message-ID: <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
Date: Wed, 5 Mar 2025 15:20:41 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()
To: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Cheng Xu <chengyou@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Yang Li <yang.lee@linux.alibaba.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K5YWpl1afCIz0GSstMdQrjpKFA5E9zL+d6oUnGlMOn9oeASRXMM
 cxOSbYvrdMcL5omgjTJmGrvhAgOtgemjkpRpepr+oDPbfmNlOhHZBpyRHqrh7cZ7doD1Ioy
 EiDLvYTClCslBiG7DVhc9QPEG9vvNLD9gmYVv1EgQCmnXuJaR/anSsQ/o/eDgMZV1CRGZay
 k0BnV2DvSPWrF3Z170RuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gkDAiXcZH1k=;xz6JkpFjlNnnbsnyId4VAAQBYB9
 gj4Beb6FayFHM+1bAX90V/bSG3/gQmPupHRKxKzdED9+llmecmGpdQnrUTdasLiJ7oQ/8PEaQ
 zn+NaH5ZETr5WC0U47QwQQFrwZn/poog0ZDEUs2AKFsHlyMGMQ6sO2pYhHXbQsWZZ4qXIiyhv
 bgKWlf1CJPC/2AuLxrk0WZWIBF6Hs0yG68fbjCFl1o8KXdutMD/LufdhzdhZdjdZaNnAWU2QJ
 yWyFLulaOpFNT0fHwx+AgrGJbEKigSIPLM3Du9kYJYBy3h9rQDjdx9vQGClDCs9Q0BiVoxVH+
 85AGZPGzYGhK8kgZuaO02XX8WaP4Rsf9WZpc4weY0A5Hw+atGKJnJUQ4nSMLnZLO6qFOfz/Zc
 1Nx6ezUnWDFFyQffJOKJJpX6R0RA2IrMjXvvojeJAKytVrk8nx+c/9rKw/LQmOnLYKts+lo9B
 /Uc1aLKXi6oaHYE/XaMG5cuLyrwUwVBVrE7UH2J1eoF8wNsQDWRYYSj03nw5yaPivMsTPX/sE
 EGuhlXedguV7tvfa4yS5LQDZc6XlGWcxEOFFpTmxhHUCygUr002AQtANhzNA7TfytfSP0Sk0H
 qrQpVo6c8qNk/TyARLXSwrFOs/cq0Idb86qSZjD/OK5x/VlKCGyDuZrkhBdTGC9uUKj4UgU2C
 h8XYp0qRz/hpf7mmgEHR50eiBnG4AFCzZ3rNRvrOhONSOvkIlvW5JO/UH/Bp3ySsMWRVcGHqT
 wgIFVGOUrCdB1tErrx5DBJ+aruL7TQhouko8vWxlz5r7tvyD84TFi8B/PneQEc6MTIskZm9Xs
 o4vL91KQ/rqLx0e2aKQyLHVEV6wkRwfx0nha+UF//r9sXleqZ+0bmUZm+WDRSo/5xg9vUt0FQ
 +0k9RUnnpILrviowSwiwSQ8vqHAd2ZyLAWSigXVca6ZC3ZI/JekwWPSAhdmzO89j/k6wLV+5F
 iPmj4Ud9diSnNOqarGsbbTJo4oR1UlgIm34w2aaAdEnAhbNcBmKLtZCpH2g8ZhiGBSRmY5/M5
 lnsTAGHxnIISkPnULX/RcI8UlS47DRqE+WVky3nRng1SGq3V8tM0ibq7QgnAOtq48L3tIpOPm
 xBjJXJp28BArO2+pkH+SVh45iDfnzwQfqjNuFPEfxK66aK5RaNb1+QvTL3L78DDj9/+LMSdi8
 KbL8JvI8pa0CDu6YxCRBcK71mnnhq0i/LuLMATBifXFX6UAfGDcTpkAXcfMFsQqOcLlgErtqx
 t3Mt9dbeEQe4YZnomN9dKlTX2QE+r8aneg8h7XiRCjEItR9Itp2UYgqA65mRuIe547q0/fAz9
 go/TF8a/wRy7S89tN567WnVAp08wKSMMPcJFL/lw2s6UyuEvq8SnApJJDLt31+AmWV71H3XdP
 FHtEE/450w7P9JH+VL220PGPgt6m2BkYgMYmWUOwBSaKYmj6V87D/NO7OiZwNsDvrJJ/5d0Kw
 sw0WY6+fVlliAzq2pP77dif5eDBk=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 5 Mar 2025 15:07:51 +0100

The implementation of the function =E2=80=9Cerdma_accept_newconn=E2=80=9D =
contained
still the statement =E2=80=9Cnew_cep->sock =3D NULL=E2=80=9D after
the function call =E2=80=9Cerdma_cep_put(new_cep)=E2=80=9D.
Thus delete an inappropriate reset action.

Reported-by: Cheng Xu <chengyou@linux.alibaba.com>
Link: https://lore.kernel.org/cocci/167179d0-e1ea-39a8-4143-949ad57294c2@l=
inux.alibaba.com/
Link: https://lkml.org/lkml/2023/3/19/191
Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/hw/erdma/erdma_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/h=
w/erdma/erdma_cm.c
index 1b23c698ec25..e0acc185e719 100644
=2D-- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -709,7 +709,6 @@ static void erdma_accept_newconn(struct erdma_cep *cep=
)
 		erdma_cancel_mpatimer(new_cep);

 		erdma_cep_put(new_cep);
-		new_cep->sock =3D NULL;
 	}

 	if (new_s) {
=2D-
2.48.1


