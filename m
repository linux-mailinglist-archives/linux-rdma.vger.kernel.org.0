Return-Path: <linux-rdma+bounces-13738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC6BAE335
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D131E188A4F1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8C22F74E;
	Tue, 30 Sep 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tBBQHV+V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57A242D60;
	Tue, 30 Sep 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253645; cv=none; b=BKX1e6mqz3Qgsth9KrykbOsmOvTUGoXZVP6QEKy3KotiP4zXWVlhTThME8p5lNbSgHCq81CS9EDiMViacQMbfb689MTUUg8AmPhBT2/u2V628r2+sL4KpIPlf2x/nxUKc+UeTxsyJMRFHlxe+Upy8av6H8YaY+iC8BVhLM0Tyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253645; c=relaxed/simple;
	bh=a2i0ZDg1Nn9bTTxopVw11ptAfPxZl/mc99E1QunLURI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YeoacZichk5gK4MN3YjWhnnypmX0lpp4H7bKSgxnKf0xCh2MXhP8aQR1b8QkSeyFgA7pZbLDb05Xpl0N5BV670qTOKiY0RUmfnvmxE7RonOdoqI9zorl6lVqpWsXckbhiqom32HvpKIDUZ3zXV0ncQ+GJ5tBkXoYZ5wJio/+zjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tBBQHV+V; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253622; x=1759858422; i=markus.elfring@web.de;
	bh=a2i0ZDg1Nn9bTTxopVw11ptAfPxZl/mc99E1QunLURI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tBBQHV+VbKASaDwvMX9Gv8Dmky6tQscQ2W5UZoBTBxz5pizYocmcZvJOd+XJv7zy
	 hrrK+jmq2tCYX44MMDiahBwKZwa11S/ka8BykmU+8R21dUnCtZqnGcMi+0YLPU+Sk
	 C/222xqWXVXyk+rsgav/n60msYe0XN8uPoBe+Q0ZurqcOURoz5TR17TbaxDTsy83V
	 BHiNkY4qNz7XmZbuSyZx8g3B9MP1vhTwjRR4RLzOjJ2Rpz0ONOFf88oqI6d5Wew9L
	 HypDgxSdWJj2mN3NDsoKIK5qTamDqUiY721a7ATk/mHsCuGeZEwing+zBhi8YUI/c
	 8uXP4RFaMtsB9cbOxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1upQif3MHM-00XxMG; Tue, 30
 Sep 2025 19:33:41 +0200
Message-ID: <fb3aff08-c0d5-4b07-8d05-13f70f6774fa@web.de>
Date: Tue, 30 Sep 2025 19:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/6] Coccinelle: ptr_err_to_pe: Omit an URL comment line
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
X-Provags-ID: V03:K1:jd4JiyPtHHL+G5eattRBR6VSpiKThhqekzrA4ShmfZMC3g/Kspm
 ezXqfFsV4CsLrDvX8ylItN5DmmWA1A+m3tZ3QO5+HZgkjnOx6azSOBrwU0W7v4JPotYTwFM
 ZRoz030fwGFzXUeGdsHsBgUUF/wHR3qIY6hScgA2A+1t/vuvpL4xZmRo0i4jnuvZDqpIdve
 JjrtyPbVoaz4FUWWINF5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TTGQW9M99PI=;BxrzvepsRdE/T6H207i4JcrvGHV
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 16:57:47 +0200

The Coccinelle software is documented to some degree by several
information sources already. Thus delete the repetition of a known URL
in a comment line.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 0494c7709245..1a373c0a8180 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -8,7 +8,6 @@
 ///
 // Confidence: High
 // Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
-// URL: https://coccinelle.gitlabpages.inria.fr/website
 // Options: --no-includes --include-headers
=20
 virtual context
=2D-=20
2.51.0



