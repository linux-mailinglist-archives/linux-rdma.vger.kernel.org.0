Return-Path: <linux-rdma+bounces-15504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25489D19150
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F9B030060E7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D133BBC6;
	Tue, 13 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sImy+7TU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115B26D4EF;
	Tue, 13 Jan 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310510; cv=none; b=rL1/geTMbpsQ97/6MD0mlpKZ4GLMvHtzpmytH4QNLr9nBEmm/5SwEZI48qyzkk8reN1UO3Ux2kLSt2cw6NJG5vMfuhHuHEm++oeLqbcRBQs8rSjnyeiyDZ3RomqxXTwlnFetLqMQ9jjAA3oZlQaAGDxhYLiBr2fsQrHMwPj8OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310510; c=relaxed/simple;
	bh=gtRSjksw9jDTYGXf0RhgAwYLTZztraOK8uc+9QY38mo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cuyaCkLeGWHz9oCJ+oHeWMoBN/nvGP4gglQVmXGbR0af/WOzMo84TioMGgbeRxJCwCeypNsxVaqEZhRCmRrduCjleEKhx4YRwSHdSR4MeLI0kC0uS0k5UzgqR1iaoa2ne3uWV04C23NIKsENuI4kBq/7A6VEliPdHFOvHkXNnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sImy+7TU; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768310494; x=1768915294; i=markus.elfring@web.de;
	bh=gtRSjksw9jDTYGXf0RhgAwYLTZztraOK8uc+9QY38mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sImy+7TUBBHdWwS/IvPRKP5Oh2rT6ipPlwwvoHEtJBhnG5YYyv63XZIiWxyr6lo5
	 iw6nerSEbn+AfGSi01SNzvfAB716BCzwzuq9Au7Po5Nh83mR5B4CfXBQowSzf35Vk
	 n/l3fkJofhRlFKaWtTOc4VOtXOeuU7/AroMaIWTmHOM+RvRoMA2EVkjFIeT3xhqYl
	 QypouXwCMWHeCFaXGIAtVCO8TKNXMltnuE5BUhDBam+5aizFUtJARPeemUnoXw+dp
	 BDYxHdABW8yhgKM3RCOwN/pBFaXRqFL0aAWGxlmXjoa9gVIO3+afUXvj8ZK5nNZ7B
	 Yi56VYQakYXsljmS4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1wAMOL27dr-00lilB; Tue, 13
 Jan 2026 14:21:34 +0100
Message-ID: <eeef5d49-9019-4ad6-b7dc-9b193350d73b@web.de>
Date: Tue, 13 Jan 2026 14:21:30 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zeng Chi <zengchi@kylinos.cn>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Zeng Chi <zeng_chi911@163.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20260109090650.1734268-1-zeng_chi911@163.com>
Subject: Re: [PATCH] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260109090650.1734268-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9qOw+zDNVsvq1oUdjaJLTB/d0wq/Q0DrhFrwiqtXEAVOzXxBJEu
 mscDas4lHUJ8CgrGZKl6GunKd5eAxT2q29q4DxxSySCTLj/ZPrzxI0UDU1PU05h8Z4J2u5s
 BLdrJr7xn2xjzAOeL9st2BZDRYLJ7tFfVF8mKO9Dl5Pf5l4xStGchcC6tffpai2NWXX/CEY
 fNPDJcGvDQ9Io9oWb9HTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g1O6J4lAyFE=;ZsTfizGTzzPlF/JqWnaNhMkR8LP
 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
 3GFVyVazk5mA8dmvo=

=E2=80=A6
> This patch fixes this smatch report:
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

Regards,
Markus

