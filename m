Return-Path: <linux-rdma+bounces-23008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ObVjL0wiUWoO/wIAu9opvQ
	(envelope-from <linux-rdma+bounces-23008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:48:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC873CB2F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 18:48:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="rT Q33as";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23008-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23008-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4AE301186C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18D43B3EF;
	Fri, 10 Jul 2026 16:42:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03862D1303;
	Fri, 10 Jul 2026 16:42:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701772; cv=none; b=Jvr5J3KEDPhb9MZQRNVbjNnE74w+1tILZ5hpb+SaWf1hxuXI1kaH/EBk4BbXkRHm88+eIDC/2wC9RLUPGwstu8MmobJreHr6EgrJTI95R8ioYwKuyLb7lzXAdV+xC+OSO1Rn31IEt/YvMOdPWKkL73edw/5viWKqWik4wfnHGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701772; c=relaxed/simple;
	bh=9nA8uhhcTDfyIof4mgln0Vtd+gRgUi+zZKMRB+ptwlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT8bTHtoT+SaO1xl1i+6jU7At0FdFw4onueZqjjlKUxdrTlYpogKkwqNOC4lU9tDz6WtAl1qh8e3KIdbtLopTUhvXzytKWLFqA72yYxMpfkzr7PeePWz6eiaG+tCdw8dB5Re/a86BzaAYw56Y8UuTVeAJg+kSlbuKf6lzUTwHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rTQ33asI; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JLwLbiytSY+NyZAL9Suy3UCiKJ7rIXpmNTauGzSf0qA=; b=rT
	Q33asI7ND/klJqTsm2Y//NzF/md9BOcnx4kmTIAb2qfX9Aj2oFr5FoPlsKl/PB2AtGKpPam6603A5
	c7HlnVtI1nDMWn2UPUKjxl9/tKxUGrqFeSYXfSRW4+SnEVyQZMzscaD1UXlbgP8YKMmW4sZO2Z+X9
	96I+TPOA/yJGbyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEJH-00BfaP-5P; Fri, 10 Jul 2026 18:42:43 +0200
Date: Fri, 10 Jul 2026 18:42:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: gg@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH net v2] bnge/bng_re: fix ring ID widths
Message-ID: <97cb56d0-24c0-4d94-9455-8c7b1b185c14@lunn.ch>
References: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
 <13ce47bb-c8e2-4ad6-8942-e0b4f8ff9e49@lunn.ch>
 <CAHLZf_vxM0uht9S3tD02uaDWLSsYyMcCnRrwmOGhkDU4UeTbrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLZf_vxM0uht9S3tD02uaDWLSsYyMcCnRrwmOGhkDU4UeTbrw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23008-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:vikas.gupta@broadcom.com,m:gg@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EFC873CB2F

On Fri, Jul 10, 2026 at 11:40:25AM +0530, Vikas Gupta wrote:
> Hi Andrew,
> 
> On Sun, Jul 5, 2026 at 12:04 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > - Backward compatibility with older firmware is not a concern.
> >
> > Could you expand on that please.
> 
> The backward compatibility concern raised in v1 does not apply. Thor
> Ultra hardware has not yet been deployed and no firmware has been
> released to the field. However, future revisions of HSI must maintain
> backward compatibility.

O.K, thanks.

We take backwards compatibility seriously. The fact this hardware has
not yet escaped the laboratory, is one of the few reasons acceptable
for breaking backwards compatibility, so should be stated in the
commit message. That also avoids having to answer the question again
and again.

    Andrew

