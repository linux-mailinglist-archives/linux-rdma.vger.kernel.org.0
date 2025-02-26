Return-Path: <linux-rdma+bounces-8116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E3A45A18
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48CD3A7FE4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EB122425A;
	Wed, 26 Feb 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dd6qq9k2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Du3Vr4KR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CC22424E;
	Wed, 26 Feb 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562142; cv=none; b=huQQ6h8d3ONqkBeiUrUlFe9WpBd1nhlm9du8nrT0p6uIZDT5kptXNidinpg1vXyNVICcps+PjV/4FuH9B4gtWlrhADVKes61XXR5UdEwgRukvS1UAYbf2EhZM0IQ/TYpFfy3o0GZE4qxEaqkkgeNcgPTgETbINw446orhAVeeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562142; c=relaxed/simple;
	bh=YhsSjtzXRvYZA9Qw98AirEaomPekRALwXcQG3tJuiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnvpFsXlvQ7yJSipiVO8Aomg0hLQwUJOrQPUirbBWRgTekcJ5ISIDCnCeK4yovX7EGnFtGRisQpj1ynJ3xcxNio18EVJLxieZU6VQrM/4sW/1YlgsXHbopnanT14wE7C5XPNT1EM7Zx5f0GIuLlbu5bxuASAsWvFgZnHeuuK2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dd6qq9k2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Du3Vr4KR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:28:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740562138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dVDKsl/jgCikGL6Si5UGaYai+g1mwDkISq2RZJ1jdQ=;
	b=dd6qq9k2VXEtW5kWheJ/jtPsMowP9UYF/Spnm9jPM6LfC/jFplvpfX+TsPf5DxON4cfvHB
	ImwJG0r0baUhAuU6ZxwxQUMVHPnw1xEPKICYCNjY1+t+oXjWgYVnUuZkQ/NVScFty7jL6J
	rXbfeGJVfQ7/9HWJidj+OEWS3mM8ZMJk5bqjPWc7Zg5RuO5/kuVw7TO0xt6lKbQW91rI3h
	je28olGGCtyNT9Ouql/PLlipxNDdLFNP40fQ5tdHuQRzK3ErbLNCDxjuzAaC/bgcigl7Hh
	FXP7UYZ+zFRVsFdrEB5+CR3MlPjH44pbjTZAb/CCLyeJh9CLuSBF3K67XsJgrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740562138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dVDKsl/jgCikGL6Si5UGaYai+g1mwDkISq2RZJ1jdQ=;
	b=Du3Vr4KRRcb3vJr5XmtjI66KPXuAJ37HuHQ0pAZUJ+H27QBGPKRAYGNhhiHNqR1709CF88
	MN0vMXBq3YHWtwDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
Message-ID: <20250226092857.La2UyrrB@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-2-bigeasy@linutronix.de>
 <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>

On 2025-02-22 16:13:35 [+0800], Yunsheng Lin wrote:
> > @@ -99,11 +106,19 @@ bool page_pool_get_stats(const struct page_pool *p=
ool,
> >  		const struct page_pool_recycle_stats *pcpu =3D
> >  			per_cpu_ptr(pool->recycle_stats, cpu);
> > =20
> > -		stats->recycle_stats.cached +=3D pcpu->cached;
> > -		stats->recycle_stats.cache_full +=3D pcpu->cache_full;
> > -		stats->recycle_stats.ring +=3D pcpu->ring;
> > -		stats->recycle_stats.ring_full +=3D pcpu->ring_full;
> > -		stats->recycle_stats.released_refcnt +=3D pcpu->released_refcnt;
> > +		do {
> > +			start =3D u64_stats_fetch_begin(&pcpu->syncp);
> > +			u64_stats_add(&stats->recycle_stats.cached,
> > +				      u64_stats_read(&pcpu->cached));
> > +			u64_stats_add(&stats->recycle_stats.cache_full,
> > +				      u64_stats_read(&pcpu->cache_full));
> > +			u64_stats_add(&stats->recycle_stats.ring,
> > +				      u64_stats_read(&pcpu->ring));
> > +			u64_stats_add(&stats->recycle_stats.ring_full,
> > +				      u64_stats_read(&pcpu->ring_full));
> > +			u64_stats_add(&stats->recycle_stats.released_refcnt,
> > +				      u64_stats_read(&pcpu->released_refcnt));
>=20
> It seems the above u64_stats_add() may be called more than one time
> if the below u64_stats_fetch_retry() returns true, which might mean
> the stats is added more than it is needed.
>=20
> It seems more correct to me that pool->alloc_stats is read into a
> local varible in the while loop and then do the addition outside
> the while loop?

indeed, indeed, what was I thinking=E2=80=A6

>=20
> > +		} while (u64_stats_fetch_retry(&pcpu->syncp, start));
> >  	}
> > =20
> >  	return true;

Sebastian

