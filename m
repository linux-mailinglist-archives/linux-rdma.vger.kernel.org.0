Return-Path: <linux-rdma+bounces-22727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9FXlMhKkRmpMawsAu9opvQ
	(envelope-from <linux-rdma+bounces-22727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:46:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 183266FB9E6
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:46:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=h1OKxy+3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22727-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22727-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CBCD300D175
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69425361DC3;
	Thu,  2 Jul 2026 17:46:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CEE30C141
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:46:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014415; cv=none; b=j5+gyb/N3wVhVF40zXVxjFCD+CJf3rJZzg8Yu5/STyMdELhoYBuiOswhPx/xqN6vlEFbtena9asB36aERI6UVQ7F/MS0Nhv0ZPUHy+l7Z2cBRIMpV/8190WVCtdbEiRJ7EBxWTK0Ct5FXLxEPXMhpqUT4BbFlHODs4/Qp25SQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014415; c=relaxed/simple;
	bh=GL3YOcxIEMLKzg7odoUj07PgGolhZW3Dd0/qCjs4Jsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE5TxGnDzmdxcr/yegAbOU6AU28QWA63MrgTndVoOrSnwpDrlvQgb/1Djf70/o0IypvZENBu3rfGSXlbXzJRz3rjEuU1SyyLDy9xYqKgtcXTwDHcbB1HpUIHFx+WnhSVFRi4eso//P6OzGCinUME1Gf7/6FYPhvi0nXU7CRcvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h1OKxy+3; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91562bf6c12so136798685a.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2026 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783014413; x=1783619213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boFzdPDkhwjAKttJz9OJN+BCdriuoKp5yffYezagjwI=;
        b=h1OKxy+334VdHc+p3msAKDCZJ3nBUnqkvjcag3hAEnm8zM7NYuNzl0a60YSbwxL5Uj
         lhS8BkM6K5Ov9TZbNANToQpG4aezGs7xIMF2dqj3xD9rO2N0SJp4qgzlTMBQGHv0xRrb
         HBrUIbDOZgtnTQvfuf4ebvt9UIFzDaGiKZKArxZ13oCb87jpZxRoV5uPKQms5cr663ed
         oxk/z/UYLPz1roMr6uSEsm7mEFwlmBQdK9+oNFNqljaiewmLWnKufJJDf4Qf6m9uWN1d
         4sswwtOKHi+KEQIzEx7J5qEcc40zdQE03m7HNcZpzjrMui1/5bde/Ig14qbgaRnKQk7z
         qO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783014413; x=1783619213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boFzdPDkhwjAKttJz9OJN+BCdriuoKp5yffYezagjwI=;
        b=cON+Uaut7WDHhJH3C4YoUo+BY1YXGh5OkMXyvpxNNgK10a6ESjuHNjDSXKC9Uf/Lzm
         kHwSc5Fcp7ZC/PzkN4guaMhb4+/F+L2OPCDvtbx2eOYoAMMadl4GOEN9dOX+3ksQgpot
         xUkBbpunjCVDymVuWJElTh7l1a3bzzXsJ0UCChuNXtRrLqQ/AesUtTYKw7w5hOjZGg4F
         h6wb0jzsUbzUuvuPznLxjnckLSS+YTaeBzhbkkILPEa+YnpxSIDeSZBOFogTF1kJTx0s
         bj4+7szXng0R0wCrEKvU/alkKoYeObR+SHTzZJckjmFjHZNioFBxVfzowd3FCvjgvyq4
         t6Jw==
X-Forwarded-Encrypted: i=1; AFNElJ8PVrWLKwh3gmXu0CCm2wNHF7GE23xMm8Bj6vItCMdu2ADEF6FkQErwIU8pMVq9ZKTnEwVLOOpieGsz@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKkVHeoj2VdwNlghpVIYwOsiQQVYEXGMQ8zKw5Vc/XKnQHaf3
	DwbpW24OrlQ5HWRaZqS8PVXGHFm7SIeeqxXUcipUHbiPNoivzHbIu4q/mOUUctwKw8g=
X-Gm-Gg: AfdE7cmKx7skGBaZ1mHQ/Dz/l0hoBf8EUKZ0M7fLymvm/dLBAzz5R+rAbu/aBUG/LGt
	Nyc4paYaHVRDaFHFAmzIPVNbOLKRs1dVYQZ6vYi/VjEnXp/P+Rdh6GVx5MIoEMpN+KQzL4i+Jp1
	kkqwsBP9SMciCz/oGs+veAElHKPp66laMoN3JkiV083kDyHaaBHn9L7OGJEtmatBMwukT9v+a6l
	TXxsb9icLWcAcGJOeRr/DAyimqSPSJQiAa/MAdqNVxtmMtFUYA3VdAAXh5nyK5uuSuJyIXPR3es
	u9ums74bIwo2uqACtcvVmIIIlQUUHsYRBrizkt4HLmtRupiXyxA9tV5Fpg8Ol3UkDJbn67XfjPe
	7jMvyOnUlwGoDsPSNABZpvK9ljgLAx6ExRtLWWqGrBMKjqD0HSR0sb64czbVgnX1RzJemfUBs6v
	2ad/9L1NsQ5eeIZXJKAFu/Ojt6a4p337L3/f6a17wOn5jhgxrY/T2HmRtotdJlAXBciK8=
X-Received: by 2002:a05:620a:630b:10b0:92e:7d53:8e8d with SMTP id af79cd13be357-92e7d62da46mr591469985a.27.1783014412881;
        Thu, 02 Jul 2026 10:46:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724ba6fesm31970626d6.41.2026.07.02.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:46:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfLUx-00000006NSd-3IZw;
	Thu, 02 Jul 2026 14:46:51 -0300
Date: Thu, 2 Jul 2026 14:46:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Bloch <markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>,
	Majd Dibbiny <majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/8] RDMA/core: Add
 rdma_restrack_begin/abort/commit_del() operations
Message-ID: <20260702174651.GT7525@ziepe.ca>
References: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
 <20260701-restrack-uaf-fix-resub-v1-1-c660cda4df2a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-restrack-uaf-fix-resub-v1-1-c660cda4df2a@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22727-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 183266FB9E6

On Wed, Jul 01, 2026 at 03:28:15PM +0300, Edward Srouji wrote:

> +static void restrack_drain_res(struct rdma_restrack_root *rt,
> +			       struct rdma_restrack_entry *res)
> +{
> +	struct rdma_restrack_entry *old;
> +
> +	old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, GFP_KERNEL);
> +	WARN_ON(old != res);
> +
> +	rdma_restrack_put(res);
> +	wait_for_completion(&res->comp);
> +}

> + */
> +void rdma_restrack_begin_del(struct rdma_restrack_entry *res)
> +{
> +	struct rdma_restrack_root *rt;
> +
> +	if (!res->valid)
> +		return;
> +
> +	if (res->no_track) {
> +		rdma_restrack_put(res);
> +		wait_for_completion(&res->comp);
> +		return;
> +	}
> +
> +	rt = res_to_rt(res);
> +	if (!rt)
> +		return;
> +
> +	restrack_drain_res(rt, res);

Why the duplicatin of the put and wait? Maybe
 restrack_drain_res(NULL, res)

should just skip the xa part? Same for the other functions.

Jason

