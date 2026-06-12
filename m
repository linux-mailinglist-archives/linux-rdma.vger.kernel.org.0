Return-Path: <linux-rdma+bounces-22154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ieNGxvBK2qOEQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:19:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C623677BE2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:19:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=U4JRN5Oz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22154-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22154-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ABE4301B3F0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7737BE7C;
	Fri, 12 Jun 2026 08:19:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536D30F7E8;
	Fri, 12 Jun 2026 08:19:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252374; cv=none; b=fRh9t6RRmibMZBPuf5cGQe3SvOHX+w8CPYCOZNSzFmViTL/hR9LJOLVCo8rWPoQyCIBfZX2FCZ+WEh2njyapkHo/eCbJpezU73sv1ogr/scWOl25bUfIEQzmYq43+yQyaO8Q3Kx0udOVXzUJGy0aBJNTk5dPKRFWvCLf4XEKhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252374; c=relaxed/simple;
	bh=DDb390pH86F+MDAKPh2YrcsD3VaZg2jS2rjKd2DBMYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6stgTr3v0rIronpXt3XNZlR6iZfBxI17waNy+HCmgjhas1ebEmdV4CzoSdfhzmsyVH1mUn3PGA9a+0StcuGct0AdSolXnIkSgaWodv0HuPejVCaJa3Rfq0ftwQ1F505dBagGBv+9UoVuKtavyjCs4lQjPsxM0rJLjD5Eu/Dnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=U4JRN5Oz; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p3Oqjlj/auX5F9Pcu1687Su6+uFqsB+j7WxdEnNQCQg=; b=U4JRN5OzVWPkFIz8k+tXNZuqX2
	m84pOgKMjluRHVI+0+jIhucCVfJc6M/1y2m7BW4K3eZpZp/xCf/ba/xs1Wu7qrkuzPbvL/18FPlRC
	8q1PYPOWoh7Mukd/cilKaG16Eif4ZcFaxjbUr7amvYo9xOs4ov0ag8F9Vlv/EwnetNfepbHnKIKUc
	1PSNGQy45UAcgg980DBjmV1NTtuJtOw86Hu+xJ9YgEdrt6qtsxcjxg1Vv2DSAPcXg0b1rHPqXi+Ke
	OokErsv2t4k0Ye9VDkaQKLURaJccAZVyS6zBKpyQMiUU2eOtW/CAzDlUZk0I1YFdS4GHkpvixChNe
	2uvD6fkg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wXx6s-00AbGb-16;
	Fri, 12 Jun 2026 08:19:26 +0000
Date: Fri, 12 Jun 2026 01:19:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Allison Henderson <achender@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kselftest@vger.kernel.org, kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Grover <andy.grover@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] rds: convert to getsockopt_iter: manual
 merge
Message-ID: <aivAbAIjnTeqlsdS@gmail.com>
References: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
 <20260608-getsock_more-v3-2-706ecf2ea332@debian.org>
 <2e1b0534-a1a0-4eb1-a5e2-d42fcf991188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1b0534-a1a0-4eb1-a5e2-d42fcf991188@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:achender@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:broonie@kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-22154-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C623677BE2

Hello Matthieu,

On Thu, Jun 11, 2026 at 02:52:36PM +0200, Matthieu Baerts wrote:
> > +	/*
> > +	 * iov_iter_extract_pages() pins only user-backed (ubuf) iters;
> > +	 * iov_iter_extract_will_pin() reports whether an unpin is owed here.
> > +	 */
> > +	if (pages && iov_iter_extract_will_pin(&opt->iter_out))
> >  		unpin_user_pages(pages, nr_pages);
>
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
>
>   f512db8267b73 ("rds: mark snapshot pages dirty in rds_info_getsockopt()")
>
> and this one from 'net-next':
>
>   6e94eeb2a2a6 ("rds: convert to getsockopt_iter")

I was aware of the conflict but didn't realize a note would be helpful
for the merge. I should have included one.

Could you point me to an example commit/patch that contains such a note so I
can understand the expected format and procedure?

Apologies for the omission.
--breno

