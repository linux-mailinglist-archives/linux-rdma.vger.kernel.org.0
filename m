Return-Path: <linux-rdma+bounces-12788-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68478B28C58
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 11:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA051C21520
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 09:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75923F26A;
	Sat, 16 Aug 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CGjmAFig"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7A194C75;
	Sat, 16 Aug 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336366; cv=none; b=DMe/2UeYU4S+rZQkZD1O+TELZzMD4ARUzzf4NHIbbl1z/h/w+UNHifQChPs22JorjMS87j0sSYdD0TaJGm4vqECY7TvRqsUAtQk4LWP7jzYrVF85IZg4nrvB+f2vJYzYl4og56l2wT4/+Ok8o541KeCTCXJrF+l2qmfyBcfRZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336366; c=relaxed/simple;
	bh=QvEU6HRO0DARKMydq9orO5i/PFQrv20H+oLTRghpq7w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UEOOHei0KKIq9lhfteVY0G0UaH4E4krMzVmUm+I1zoN4y+vDBzyHdvxqkA3nMRaVbjulT0St3wQl7p5ASsNtPvZ1wVMZB7BLn/ceLRduWr3Drb2vYmNK9FEHJy7HihMWDnwud0WyeCCGloZca/4mJKkQH0j4yH3UB8j+c8cPbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CGjmAFig; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755336337; x=1755941137; i=markus.elfring@web.de;
	bh=ygRsKx0lB8Er7OpZFhZCEN79wM6pfvOZNWmfxbSCU/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CGjmAFigBIOAKV3SK59zAXQtjHvji5NMQ14hTRERTb+NgSzPL10Ej28vedhfmQDX
	 96evRJVsPBvR2ugYCJ74u+SQUM4RJTd22QCMuNxLh9qkbnzhwE8RUMhBKEYYwH9PV
	 RPDGjfftCzAubDpStO/TkX7WVHDCCKXhBW4br2l1RylGVeK7R4QGr9++ZoRdNoUrY
	 OH6iA/pwjhfz9OErB9FjQWd1KtC+skHsGHyWDs2u6P0ag0pahqXI/Ut/uYqFnwX6V
	 isdsiOzVBXrr3YtjDcvlYPSSj31SgpV9eYAzSlR1poUcBgIXhnUwyqBSJLBCfv6HD
	 pTf+//vsJ5824b5KMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMXxF-1v6f3v3XFv-00J9mY; Sat, 16
 Aug 2025 11:25:36 +0200
Message-ID: <f9638a40-7927-4456-9b9d-d449c06b1070@web.de>
Date: Sat, 16 Aug 2025 11:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Allen Hubbe <allen.hubbe@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Brett Creeley <brett.creeley@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Paolo Abeni <pabeni@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>,
 Shannon Nelson <sln@onemain.com>, Simon Horman <horms@kernel.org>
References: <20250814053900.1452408-2-abhijit.gangurde@amd.com>
Subject: Re: [PATCH v5 01/14] net: ionic: Create an auxiliary device for rdma
 driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250814053900.1452408-2-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iauRxyQjADelyP2sFys0+KzZgu340c5fR0yRNILaMmNldQTIdsM
 CeEHBC2P0pBAN2+qIPwq5489DZ1b/svSfNPk4fDXoBoJ4wQ9Ze5+lXkYYQAvmGscPG1saVQ
 RiyyjdhktVdWsEJaf3cGI9KSRua3DSP8AwtL4F3mwO2baM6lE+7QHO6NSfK0fB6/GH5cHDZ
 rX4qof1IlRc4xj9MfnMZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NQdwOQD4K88=;38XZtlDYX325gzU941eoHYLCE79
 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
 f5Wq+JLTwVXwpeAzxdkTxxzBbcK9f/i/KzMHq

=E2=80=A6
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
> @@ -0,0 +1,80 @@
=E2=80=A6
> +void ionic_auxbus_unregister(struct ionic_lif *lif)
> +{
> +	mutex_lock(&lif->adev_lock);
> +	if (!lif->ionic_adev)
=E2=80=A6
> +out:
> +	mutex_unlock(&lif->adev_lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a call
like =E2=80=9Cscoped_guard(mutex, &lif->adev_lock)=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16/source/include/linux/mutex.h#L225

Regards,
Markus

