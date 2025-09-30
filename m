Return-Path: <linux-rdma+bounces-13741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC6BAE3A7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C04A72F2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BB25BF1B;
	Tue, 30 Sep 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XZgU4oaW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38D1C862D;
	Tue, 30 Sep 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253968; cv=none; b=QRD/k7sqODUqVNaO7t9J8WyXDmQawtsz6O6kUKbNUBR28l/GjwSXl2pSujpB1nHw/tDelG3Rd8QEMUfhh7Ew2T/YCPU2gCKQD9p6tJgcMVTGe0F2ohHOVzLTX3xC+1ZrqWJWDog6JhXvXORIX7YizVWx7oFFpucK+Jlkboyt1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253968; c=relaxed/simple;
	bh=dJ22hKA0Pw46/eMtwHJfDRVC5brR1Fd+Ptpn07rVw+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iQPXv6kpt9ns/QeweRs3atVCCT7L6WHPFQCNtFut/4qoyciQ6CY2zkqMx6HJHjEdmos3zb7Gw9macf5qf+MjCchfzBxcIr8sQ/7n01zzPwIbWOKOvJnatEb4wEPEnnUg0dSlRr/JmBpfKSzivGdmkSN5+6p1DwgHcHE6MVdKnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XZgU4oaW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253951; x=1759858751; i=markus.elfring@web.de;
	bh=dJ22hKA0Pw46/eMtwHJfDRVC5brR1Fd+Ptpn07rVw+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XZgU4oaW7BOwhHTup9t5ED9kRtmQRwaLIt55LbrgDlNFj2cTpUJLM3rmF4K7nwe7
	 mzhsRicpsyW90HLjXAhPnzh6uL88b9OtuNvyZXvdkiQjnqed+GP+vUezVxLQQwsSH
	 9IE3X6RRWecjefupjbGE6xef8EUrQFj1HYGxfrk4CzH6wS87YV9FEY7f6I3oGg8jZ
	 zFhmhyt+cx593TSFStQReFII59EXGjy3oTDmVqpNS0eKqDH7RIiSGLXdpzt/r4xH8
	 nup5qK7G+tPL+nw4k10p45y+vbNLMJBney+zVxYJ2Z85beI83r7yukT3QDOUouDLm
	 459RYsd3StOH2D2E1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1uTDts2lzP-00aR68; Tue, 30
 Sep 2025 19:39:11 +0200
Message-ID: <277fbd11-6533-4f45-a846-cf31abfb06d9@web.de>
Date: Tue, 30 Sep 2025 19:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/6] Coccinelle: ptr_err_to_pe: Omit a redundant space
 character
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
X-Provags-ID: V03:K1:O58Z0tenR95pqkFlVQReIQKIrnCZPgmwLTINoBPLcq/rz6je78X
 I9wlB7XA+mOUULOWmo/zNnlAqjvgJ/txjtA1iKXNU43DPWWayOHLH8SqA/o9T+zYgyhf4iW
 YIwasVpMiD3uBhIsx+vbs/6BzPtSHptLfo/2wdfN5jWR1DhrrGiYKrfx4gTCINK2HtLkg46
 wXj6BsU8PCxu3kgTMh7nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YGCqnEc+tpA=;J/TcG41QIuUmuFRkbV688znzMJ4
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:33:10 +0200

An extra space character is not required after an SmPL asterisk.
Thus omit it.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index fb4b5bf91081..b2db0dc3395e 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -18,7 +18,7 @@ constant char[] fmt;
 position p;
 identifier print_func;
 @@
-* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
+*print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
=20
 @script:python depends on r && report@
 p << r.p;
=2D-=20
2.51.0



