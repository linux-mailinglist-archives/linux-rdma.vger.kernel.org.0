Return-Path: <linux-rdma+bounces-13740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAABAE386
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E011945FA6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96AD30CB23;
	Tue, 30 Sep 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dhwQgOzJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F52B9B9;
	Tue, 30 Sep 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253834; cv=none; b=YrpXF736NCjOWZOF+MDoQyrfVy6xBSHBQpJ6g6zmolEODQGO9F5Q15LyovEUoTkTCN0Ucf+PgNogu5tNJOxjehJWxWdyM9Dm9x5tiicwyERT6cSfAZg0hnKiSg99iQz0HMRJxGHvu+Eej3FwbTu2JSRQvj8P2DQbrxm/+rByxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253834; c=relaxed/simple;
	bh=xi9GiPTBBhlYeNFPNwd77JG6ckuL4jiUtpxRsGJ2sSU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YAvKNsAPwXRJrubazMbkspMeBlvJTyiPyfOFGL4bzLvhRnaTdQE0I1yeXT1K29QXhsr/DPTO10Igg7aLDtt9+EMgUhgsmz7Yca4gcaCYl21uBaCD2iT2TpUN4yMUep++SI8Xgg2OcdvqzwEsRnxrxPenMxhJ7YeNaL+UejeECvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dhwQgOzJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253827; x=1759858627; i=markus.elfring@web.de;
	bh=xi9GiPTBBhlYeNFPNwd77JG6ckuL4jiUtpxRsGJ2sSU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dhwQgOzJufI2+MXbLeOkKGQ5Z7k5FXzJDcAI0tQ3gHLvoA2qjQP+sDwO5raLqHGL
	 enGtd5L0fIamT0ZH90wy2QNY2byloReQDuQ0Mb75r1vyifgEYLAcB1HNgpSqntCzL
	 cYiK8C7nGr+hlNFxSicKwt9aiYyhi5qbH7pO0eCRpzW7Q6pjV4WHAmXdkRInY5yPj
	 oaPgel/Qez5mQnMJ0HrCFLK0B6WwUosKuYC7RCIVZCxdqEieQDWQJYjXq7Mvf2Fvu
	 CuZt3SLNF7xDOZLWXxIdCj/Bmr/u9i6gs5S8NMFpYTHqVORaLifW6R4H635qnYzdV
	 enIV5eaZYDpX64Q14A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1uNysl0XCi-00fgBI; Tue, 30
 Sep 2025 19:37:07 +0200
Message-ID: <b411c283-9430-4949-a6ee-bb8ea9febcaf@web.de>
Date: Tue, 30 Sep 2025 19:37:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_3/6=5D_Coccinelle=3A_ptr=5Ferr=5Fto=5Fpe=3A_Rest?=
 =?UTF-8?Q?rict_the_metavariable_type_=E2=80=9Cconstant=E2=80=9D_for_the_usa?=
 =?UTF-8?Q?ge_of_string_literals?=
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
X-Provags-ID: V03:K1:k3EkLB9qu2BOQA23380kZ7XhRGtFs1YYkOodspawFefJo1Ntc8N
 myySCEgLm9+wUVNp62zrGBBf+JkOAGl5AkVnCP8LdzGJLc8iA2F5CBbkQJtieTzAEOBUEST
 UsEdtvGuSW4Va0/oRZD2bIHPUfQ22z1hR8PQ5E8A8D7N44xovchqBytD1IPHnIOrOqqsg4B
 RmFCng8CIF7YuReFz9hBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WuT2TIEqz0Y=;fXUEds/GG7BzIL1Iet6Jxjs0msW
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 17:28:20 +0200

Refine the metavariable type =E2=80=9Cconstant=E2=80=9D with =E2=80=9Cchar=
[]=E2=80=9D so that only
string literals should be found for the desired source code search.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
See also:
[PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
https://lore.kernel.org/cocci/6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.=
com/


 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccine=
lle/misc/ptr_err_to_pe.cocci
index 26888d2c9c83..fb4b5bf91081 100644
=2D-- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
@@ -14,7 +14,7 @@ virtual context, report, org
=20
 @r@
 expression ptr;
-constant fmt;
+constant char[] fmt;
 position p;
 identifier print_func;
 @@
=2D-=20
2.51.0



