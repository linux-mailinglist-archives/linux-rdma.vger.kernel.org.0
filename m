Return-Path: <linux-rdma+bounces-13742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A5BAE3BF
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B823BB770
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB02930749B;
	Tue, 30 Sep 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U3Vzja7H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FF1F5851;
	Tue, 30 Sep 2025 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254145; cv=none; b=tUO5yoHlTgiDiidSpfpGoTBVYet8+I3bYoWmqrwj0VhsY7CDTOC1DvxuRES5D2Urr2ugJpGn4L2mg8tieTrNOfJG/VguEnIIMknIjsdyFOOSnvUstSS5gTwYCKAp7p7X4c2lr03eQJ0x2qKY0ng2Ebpdmqx1qobyZUSVSiKxsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254145; c=relaxed/simple;
	bh=UdXAcy60pbXLM1GQoLBtLI/y16G6uwx1OVabU2xuMpw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a+SZHuF7arkf9bNymGLJu2lUKywyQa3Xe/F9qseGpBbwzmvHXpsBYOq1HOEwwP/e3A/fPhGxlk78lo/Prbbvxh2aFlbDOXeXnKngNZFcVnsQlGsFBXrFRqO2mUQLiGIMWdbdHM00JIlVVURVhHGnPrkIqQrx1UQ1XTs+dnK8CME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U3Vzja7H; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759254132; x=1759858932; i=markus.elfring@web.de;
	bh=UdXAcy60pbXLM1GQoLBtLI/y16G6uwx1OVabU2xuMpw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U3Vzja7HqwFjJ1iJ30RDBFlT9K/GHyuulFZADG5oY4ShWtN7/A/U76nuXmvItZ+b
	 n5tj08npO2xwZUBL4/xvk0u0SeM/ciwqHW/z64p9nWzDkXU4Kt+BMq11NrDCCB2Z2
	 6IrlseuIO8gGzyvtGtmEGt+CBcqW79DlCaBu8HToZM9VkcUpBGGMCEtYGpjbhZHag
	 /iwj76QmGVRFLvs1cJztSfNKThbFxXxAxeP02WRnoRx3zxAvGk5fOgwV5h44w2iS0
	 1XJ6Gwn9S2oBHtMIs+S9SOTdccBHfzKdCiy4gNja2Gyz0HohDxijW/Zgf/ZGUSiLz
	 F/wtsldisMH13c9JOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3ox-1v7mom3Vv5-00Don7; Tue, 30
 Sep 2025 19:42:11 +0200
Message-ID: <e8a3b5c5-4667-40ea-913d-737b58401f79@web.de>
Date: Tue, 30 Sep 2025 19:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/6] Coccinelle: ptr_err_to_pe: Simplify two SmPL dependency
 specifications
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
X-Provags-ID: V03:K1:15pAcpfSZQjBI8xXlLm2tTzkOeZpZ7eY43IUVzBTdhRKcsqDW+Q
 qjKJH3QWe+x/ddq507uOeDSS9w0bAzTGx1CSj2/Ppwh/8nqkkxpjAXIlyCf0QNeXkMmWaSD
 45cyAxSPpnKuvMnxgOGXG6HS27IiBeqgkOd06To4gKOrUtLvs+/55S2uagwK8wuqzLdTqkl
 qZFrnJN90yriDJY7Lg+RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pr+UgT/XXl4=;HEzWpmvAAXi/cjdINT6Hxs3KoOt
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:46:55 +0200

Omit the explicit specification =E2=80=9Cr &&=E2=80=9D from two SmPL rules
because the references are sufficient according to data declarations
for Python scripts.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index b2db0dc3395e..f0bd658c7edb 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -20,12 +20,12 @@ identifier print_func;
 @@
 *print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
-@script:python depends on r && report@
+@script:python depends on report@
 p << r.p;
 @@
 coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print =
PTR_ERR()")
=20
-@script:python depends on r && org@
+@script:python depends on org@
 p << r.p;
 @@
 coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_E=
RR()")
=2D-=20
2.51.0



