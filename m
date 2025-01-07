Return-Path: <linux-rdma+bounces-6880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B621DA03E4C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 12:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041A218857F0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7CC1E5701;
	Tue,  7 Jan 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ONfKM3sg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCE1AD3E0;
	Tue,  7 Jan 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251005; cv=none; b=idPF/w69uJM9qtdcaRyzJK6XYcHBmuvjnB/SeZONCR9TvDln9WN6WpxGPvi21mCv5WVfxprrNwQ4rf0scmWFq6w/h5MW3fKqz/bTHXXLndojLXBUSI1oy/G0jCUpAKgXHfRAbVpWzh/BHd0F3On/q6Se4Osam/bVPRwKztK2g34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251005; c=relaxed/simple;
	bh=Y/W35cGL4AP760QZmhuCb73b/ujNw5RzEZcAa2siicw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+dnTb4m0O6ELo3RWB0vdHfQw3/p7AJnAIPjHRl5oVaciz8KqqusXv285KW+TVKy+w9jVtpv8KAk3l+72ijqgrJIZunEbl+Cve79bMGXR54hlek+OEoCwCClK8Cqj6VXq8EYEb1m4RxDAkIriTQT7si0e9+YJePkLW6ZaXDVTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ONfKM3sg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0061A20704;
	Tue,  7 Jan 2025 12:56:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IneULMp334a; Tue,  7 Jan 2025 12:56:34 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 98F722067F;
	Tue,  7 Jan 2025 12:56:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 98F722067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736250994;
	bh=14o46c5adIkRvsnT1HmrA12+G3Y47DkBP+h07nnvIBE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ONfKM3sgpapRE1/WnoG11ngvBe3ycsZSpc8AAWH/ILYjK3Lltf56mdvqVvkc/JLgL
	 D6TyQuU8TYe7W07PQANFCM06TC7xnKUUhJg999Kb0xfeWgLWn+w75skYbeMSJxdFWR
	 U68UWoWQPeVvZPrtGEcB0MnZdLHynR6OQMzfrnMRiU43LEq7eBjsl6wR6q7ANS9I9F
	 PlUH8lD6HpF/8y19VzOCd4NR0WH7cZr2uU2FHDTLZFCkImnkwSJ3YPW9ICQdZe3GKr
	 TiG6tuqCkpPEV3GBOMjMiuME61PWC9hQeSl6V1VYqJ1Bm7s3jhQ2mNsVfbvtThnjwf
	 z0ZtwZbNW+r2g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 7 Jan 2025 12:56:34 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 12:56:34 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E79173184216; Tue,  7 Jan 2025 12:56:33 +0100 (CET)
Date: Tue, 7 Jan 2025 12:56:33 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jianbo Liu <jianbol@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Potnuri Bharat Teja" <bharat@chelsio.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH ipsec-next 1/2] xfrm: Support ESN context update to
 hardware for TX
Message-ID: <Z30WcStdG5Z4tDru@gauss3.secunet.de>
References: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
 <20250107102204.GB87447@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107102204.GB87447@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jan 07, 2025 at 12:22:04PM +0200, Leon Romanovsky wrote:
> On Thu, Dec 19, 2024 at 02:37:29PM +0200, Leon Romanovsky wrote:
> > From: Jianbo Liu <jianbol@nvidia.com>
> > 
> > Previously xfrm_dev_state_advance_esn() was added for RX only. But
> > it's possible that ESN context also need to be synced to hardware for
> > TX, so call it for outbound in this patch.
> > 
> > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/networking/xfrm_device.rst                 | 3 ++-
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
> >  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
> >  net/xfrm/xfrm_replay.c                                   | 1 +
> >  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> Steffen,
> 
> This is kindly reminder.

Sorry for the dealy, the holidays came faster than expected :)

> > diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> > index bc56c6305725..e500aebbad22 100644
> > --- a/net/xfrm/xfrm_replay.c
> > +++ b/net/xfrm/xfrm_replay.c
> > @@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
> >  		}
> >  
> >  		replay_esn->oseq = oseq;
> > +		xfrm_dev_state_advance_esn(x);

This is the only line of code that this patchset adds
to the xfrm stack, so merging this through mlx5 might
create less conflicts.

In case you want to do that, you can add my 'Acked-by'
to this patch. Otherwise I'll pull it into the ipsec-next
tree tomorrow.

