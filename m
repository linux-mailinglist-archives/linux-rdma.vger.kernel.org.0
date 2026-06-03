Return-Path: <linux-rdma+bounces-21688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R4jsDjxLIGrS0QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 17:41:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA3639515
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 17:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ispras.ru header.s=default header.b=hq6LbCY4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21688-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21688-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ispras.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B41433BF6F9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD23D88F9;
	Wed,  3 Jun 2026 15:24:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F073D79E8;
	Wed,  3 Jun 2026 15:24:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500272; cv=none; b=lRQxb8MEYF45fRavLbudw3T2dIShin/77+54MwOsyOVNgLLgXMZeidxAgvQXrwZjw/uJDNenpQciDJJQjEwvKAXRohnujebBwDKlsphzJ48tqTFR/+gWwO2I0tH2fmieXByGVuaCJgD9+kulu1Hz4d4CvqLAc8WAO6I5OGCL3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500272; c=relaxed/simple;
	bh=VYGbKoBU1kgJ8/HqyzVh46Bxs708cg3YePpBv9k6/7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUPutO5s5DN9NALlMfSxW/5Z9PfVgb68ns6qn2UIiuQ2/VFQ3pXTy3X4pzWtSn8AUpaQvb2blqGWNwW9fIsFcPDVouGS7miRa7XzEH8UCwmL2lhW83W4aqX18ZmCq8/a0JCTSqwH71/cixaobGteACbLL5TpAaD4EVWE8VFTFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=hq6LbCY4; arc=none smtp.client-ip=83.149.199.84
Received: from localhost (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id A754B45F7992;
	Wed,  3 Jun 2026 15:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A754B45F7992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780500268;
	bh=dDezscWghLoipjsue1MQr5iD2rpVXv26dElJr8ULXHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq6LbCY4N1O+D8J3Nccr51xNzAnl2JGwoqOdtHVAJHdJjsIqLNBlvIuAYVLYcwMj4
	 Qt73OtQ/c5ktuEHoz1WSsXJA4nhgBvJvE6noFbE3n9bVkyn4qmMDs0wavz6eLNRQFp
	 jnGgcx3M6r/YOuhFB4DJqezrSBaodTV7D0PXqVxM=
Date: Wed, 3 Jun 2026 18:24:28 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Zhu Yanjun <zyjzyj2000@gmail.com>, Doug Ledford <dledford@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Haggai Eran <haggaie@mellanox.com>, 
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.1] RDMA/rxe: Complete the rxe_cleanup_task backport
Message-ID: <20260603180641-95dcfccf487143d39ac329a8-pchelkin@ispras>
References: <20260603132729.423-1-vlad102nikolaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603132729.423-1-vlad102nikolaev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pchelkin@ispras.ru,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21688-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,kernel.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,linuxtesting.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras:mid,ispras.ru:from_mime,ispras.ru:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6FA3639515

On Wed, 03. Jun 16:27, Vladislav Nikolaev wrote:
> No upstream commit exists for this patch.
> 
> The issue was introduced with backporting upstream commit b2b1ddc45745
> ("RDMA/rxe: Fix the error "trying to register non-static key in
> rxe_cleanup_task"") to the 6.1 stable tree as commit 3236221bb8e4
> ("RDMA/rxe: Fix the error "trying to register non-static key in
> rxe_cleanup_task"").

I may be wrong and then the stable kernel maintainers might correct me,
but there's been some consensus established in at least recent stable
patches workflow that if the backport version of the upstream commit is
incorrect or, in this particular case, incomplete - the corresponding
patches should be reverted from the affected stable branches and ported
properly once again.  That would make it easier to follow in future.

See [1] or [2] for reference.

[1]: https://lore.kernel.org/stable/20260402-tavern-keen-2b4fa6b9@mheyne-amazon/T/#u
[2]: https://lore.kernel.org/stable/ahgiBNbwo7FudH9r@decadent.org.uk/

P.S: consider porting 1c7eec4d5f3b ("RDMA/rxe: Fix "trying to register
non-static key in rxe_qp_do_cleanup" bug") as well to 6.1/6.6 and other
relevant stables (if tinkering with this code anyway) ?

Thanks.

