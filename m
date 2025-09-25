Return-Path: <linux-rdma+bounces-13654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FBBA0383
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B2A38844F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96F2F6180;
	Thu, 25 Sep 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iGtCWCaV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8742E2DF3;
	Thu, 25 Sep 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812894; cv=none; b=OvK8PuONFknF1duzfnHlukAhzBx8mHbhZuUU6tT6yE+C3I/FfGN3aRNd2CIpCOU4e5Rcm3JQD/oN72yjzQREKsg4SAQ3j6v12txPvuURV7aauZaVdVm03js1D0l81l4AbdSsUlFIbx5CZBVYDveFQdquKC2vihH7tDe3+lxvX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812894; c=relaxed/simple;
	bh=06Rk5hx4rBoiZk1a/BE38euS1iIEAjuVsTnbFIfdpTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=h2rVzCMlSOKuwNXurCuwoW2SytANomUvxK+cSsFLc1KM3xKDHZHQcKmrQBbZWjUFrxb0ZEquOud38FD2+uSyEioLp6xfRUg+jIJuLECQv4jSNFFa0oyLm78/g/2W8pXX+Jhn4U2+VXQ4q5lvtSlzWyVDmzRbJ6dMA8U8w7X8oUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iGtCWCaV; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758812851; x=1759417651; i=markus.elfring@web.de;
	bh=06Rk5hx4rBoiZk1a/BE38euS1iIEAjuVsTnbFIfdpTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iGtCWCaVpBt26+JQmVnTnB3hxqP5ax/dEXiMXcYOxtLWqDp2ZkpVB874e1rTj58a
	 HEBRH8DScsYjZyTXmpSlhTP1h8vq0891u7oOLWrtToNJa7eyQ1Pa+YEg6QjcZJ6kW
	 IYwA5jrP1RZkY/iexDpBaIcJuwNifqgu/mi/CBGVTFy3cDcs3+dB82bdYvUDW3wz5
	 iPw7VLjWCVLqyoliIUYU0lsGchcG2pJ2i9h3jQs8S9kLpwb1qCFspVtAjIvFCUpIT
	 Zzvm1sZxI9SnbCsZ/zkkkheEp9/3qUGlIOwTF8siENmOV8o9FLXeiC7AJVQSp9D1D
	 PNBUO08kkk2Kx8/euA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1uSjnX2F1M-00mywx; Thu, 25
 Sep 2025 17:07:31 +0200
Message-ID: <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
Date: Thu, 25 Sep 2025 17:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7mgn5Iw3/ePGX0b5l1Rpa0nZNxgsv4lo29NVxcWljgubZrqWgSS
 /Bw+kJ7wL0a45cMgHIJbYJKRt29S/OQujATXl8eUD/7E/1mmtbTTZat7h67XaorOKtKgj4R
 O+AzXliPdhVd1CepRRvkycnU9mzzoVwzYfqi1GQtvvX1VY9Ze1g4b0vz26UFMxyUQk3z+Ds
 mA/Tbt/40Hjms3osleeWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ii7A5UxXGI4=;qS3BL0sQ1f5u9keu6QEwPh/mebq
 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
 bDsxw==

=E2=80=A6> The script supports context, report, and org modes.

I suggest to omit this sentence from the description.


Will the hint =E2=80=9Cscripts/=E2=80=9D be omitted from the patch prefix?


=E2=80=A6> +++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
=E2=80=A6> +// URL: https://coccinelle.gitlabpages.inria.fr/website

I suggest to omit this comment line.


=E2=80=A6> +virtual context
> +virtual org
> +virtual report

The restriction on the support for three operation modes will need further=
 development considerations.


> +@r@
> +expression ptr;
> +constant fmt;
> +position p;
> +identifier print_func;
> +@@
> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)

How do you think about to use the metavariable type =E2=80=9Cformat list=
=E2=80=9D?

Would it matter to restrict expressions to pointer expressions?


> +@script:python depends on r && org@

I guess that such an SmPL dependency specification can be simplified a bit=
.


> +p << r.p;
> +@@
> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR=
_ERR()")

I suggest to reconsider the implementation detail once more
if the SmPL asterisk functionality fits really to the operation modes =E2=
=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.

The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also without=
 an extra position variable,
can't it?

Regards,
Markus

