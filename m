Return-Path: <linux-rdma+bounces-13703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0487BA75BD
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E190176758
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4792550BA;
	Sun, 28 Sep 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZY6ga6yf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392123BF9C;
	Sun, 28 Sep 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081918; cv=none; b=befrwCEzqvxwsZOKkQL6E8c7fiYwWmp8KIm9i4fDN3biYxug637tk978ryZqtlAEvMF9XugMenwLxq71U+8NQABVrFY5vtqLZ9qHZQbJFjA988gorHPfq7+zCGi229YcTHSaroeJ9eTld9bkPQQpGjFmr7lv3yF4oqEUJRCT3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081918; c=relaxed/simple;
	bh=WKMCyS3jCeMTkJ4zg8ja5dS+2dWHBVk0U6vBjvU3Aew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLx2fPCWl8/jCa4SzItg2XyatYOpm+8/3ZGXrtx0e3E5+zo2TroH06YaGwL4IcY6fIGdXhR6sA9vP5prg41vVhq5XzdDQrvfflLc8apInNCsUzH1DnrX2iqz3D6sDPEH5i8IfjjFFJ32NlmR/s9LeoY1VK3brvr9iZafzX0TLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZY6ga6yf; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759081900; x=1759686700; i=markus.elfring@web.de;
	bh=WKMCyS3jCeMTkJ4zg8ja5dS+2dWHBVk0U6vBjvU3Aew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZY6ga6yfjUXspR/ETGHdoVVP04rac4VeOUmyLvoennKVWORquiVMG6MuhB8wh7Ck
	 sGoopK8QK2ng7f1CVGEesxPcdq3MiS6tSvlx5c3Cj+e9uvk1nh0+VIKYe+Sw7g4FX
	 kb4TueUe+A9psvc/uciTTifKI5y3obzotM6Zrj72rhkKwjDBJo8NbzR08k8KSIwtK
	 luAf7Rg+VmrqS9CZdcwGQ7MnVexXVaXUE/bKfbgFKvn0yAmjSTHXCJe9FpwPNrwI3
	 zqDta1tZP1b+rLTZxB/61/Mtz3AZQb13O791TNbZN9U/j+SomnM8uBSwnrR8ffCNq
	 E5rtIeNPuiX/NPgNmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.189]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1v41UG1LqW-000Oci; Sun, 28
 Sep 2025 19:51:40 +0200
Message-ID: <99ea3145-5df5-4da0-9e3e-269c243f42d0@web.de>
Date: Sun, 28 Sep 2025 19:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [1/2] scripts/coccinelle: Find PTR_ERR() to %pe
 candidates
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
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
 <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
 <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0Vd5ev+1IUxNfq8rNbPYQUaHpaERCYaT/18K5Fl5szUxOuB0inT
 +mI148Cl6VZnXfcnRNC+vFG0wOkry3y+gu/2PpQW8EViv8fazPVzEuQXly+uycXqCVhnJ6E
 RK6YpIko9e3wvhjAy7/nED6l4ftiszDf/GBkicL7QJ7Tv4+PilIO4XeUANqTUv5EdwPVQJ2
 sNRifuNRUfsFeki0pDkPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CpAuMkuyyEA=;NREyE8K8h+aSn0b6ExSYGWHOGzp
 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
 2

> I'm not really sure if I'm speaking to a real person or some kind of
> weird AI, so I'm going to respectfully ignore these comments..

Can you get more development ideas from another information source
than from hints by known contributors (like me)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.17-rc7#n71

I hope that the clarification can become more constructive again.

Regards,
Markus

