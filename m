Return-Path: <linux-rdma+bounces-13743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649ABAE3D4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D5D3AE543
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384420FA81;
	Tue, 30 Sep 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f+bucK+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE171E868;
	Tue, 30 Sep 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254330; cv=none; b=fNiZFCn9kBV6/LjBgwif4Ss6/RKf8rpQsNE87IPLZI+RVahghmh4OHcd+uTAtQPgZTHm6eYUTHuUMQb4RKANVIjH7VFRj5c6Ocl3AJnXBfuyOFqKfHxBylf8TVJzB5zOKxCkqZwriVghCCXBC1TKFDVi24oyECHdob7dOYHyLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254330; c=relaxed/simple;
	bh=GHQ7kAbyKMWtfiyGjhFgX+5zS4fS7VeU7a37UwZONMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CiexvsT855c70fhvv9z+LEN/kcXEjw/0utFb0WWkZ20cITi9JRfJx8M7qRwvsFfqAjS77vdiFM4BRKnj9ixJzWcZvEMWmtf8D0jgabl5dcHKZWPANLHyv+aamNwAD0q3+D7Sv9QrM0RvqSzX8M9CQKFaEH3HPHGEG9r+RdnhnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f+bucK+k; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759254323; x=1759859123; i=markus.elfring@web.de;
	bh=PpluSChczr8BaGSG5s4VrAsAMr0xyrz2rcrPAwRdOn8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f+bucK+kxjCzCPLmmanf8wvB6zlT6NEhkeJAyx4elkexNb0v3n08EbfpHv8Wbf78
	 ArUBExMCFPzPfFrB71dUlSIqAmYn8S7HOw+bX8uwxdxlZgXvlnVrsAXuwftkA5epH
	 Q45cIFoI4sruFr8h/zbyFGo6yNnCyaPlbmAY/KIrDDjQdRpXjcaXcJrNiP9uCEUl0
	 v4APPBx8p963bxd4og6aGbwxTLU/ixtOLe2hPHhiifAf+P9dDmg3KRBvtTyEUlgFC
	 FwkRxPQob6rAWVa7k6+lKrmF8yCZQUrYalrn3keHKkA8vNjplvhmA0ygYFLHMZamX
	 MVXwHQ20Gf/11sgVHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1uYB4I2ag9-00pLm8; Tue, 30
 Sep 2025 19:45:23 +0200
Message-ID: <dd0da1bd-12d7-4820-9513-4a04cc13d8b8@web.de>
Date: Tue, 30 Sep 2025 19:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/6] Coccinelle: ptr_err_to_pe: Distinguish implementation
 details better for operation mode properties
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
X-Provags-ID: V03:K1:AJ/o8DVDoTEOzTMY9AJ4yOYEpGfrCYyo4LGOm8Y8hWzqDcHMW3z
 dDE20KJlCsgtmSaK9o9qBmo3Up23duAXDz6CNSSd8rxEBuBdj32beY2k0jgEkW54OeC7xcw
 HcV/YYO/uQUZVQLfVsQot5CEmEmfwr+m/U573Gt82t/CaZyiSp2Tn5di/SS/El0ZPd7IXh8
 t5E5cx5m+3Q6UoclxA+CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o3h7lwKwQHk=;xLzMuzKoeTJTZT2Ss/ow/Nb8v8G
 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
 HNJyi21ADGl/67Jb0d2NIFW3XA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 18:24:19 +0200

The coccicheck operation modes are connected with data format requirements=
.
Take them better into account in the affected SmPL code.

* The mode =E2=80=9Ccontext=E2=80=9D works without an extra position varia=
ble.

* The other two output modes should not be mixed with data according to
  =E2=80=9Ccontext=E2=80=9D information.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index f0bd658c7edb..fa93a6f2e3d2 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -12,13 +12,20 @@
=20
 virtual context, report, org
=20
-@r@
+@depends on context@
+expression ptr;
+constant char[] fmt;
+identifier print_func;
+@@
+*print_func(..., fmt, ..., PTR_ERR(ptr), ...)
+
+@r depends on org || report@
 expression ptr;
 constant char[] fmt;
 position p;
 identifier print_func;
 @@
-*print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+ print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
 @script:python depends on report@
 p << r.p;
=2D-=20
2.51.0



