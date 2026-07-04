Return-Path: <linux-rdma+bounces-22758-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R8mWOEpSSWpq0QAAu9opvQ
	(envelope-from <linux-rdma+bounces-22758-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 20:34:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A717708313
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 20:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=m538+Iqz;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22758-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22758-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3539F301E3CE
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jul 2026 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2136E478;
	Sat,  4 Jul 2026 18:34:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02C288C30;
	Sat,  4 Jul 2026 18:34:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783190061; cv=none; b=O4gfqa94QQROJRfRpDn4PiWZknIbks/TerKXog8GX8MD44cdcdYvx3D5GHdOxJr5JaIa3q4QzNwzCKVNb+/6uIhwAIUabW192M2qVAW0O/baIhvWTbAaze1nfACaySexcdODg4YEwNygRyQiUK5jE6B50p83c8CtKMtyrbtyOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783190061; c=relaxed/simple;
	bh=t4uLipmtTHy4TWILekTxNplI5i8nYUWkrj5/SDDiN8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuu4j0dmU7TA01uJcNwNJxFoymmX3BmMj+4TtptChR+7mjBohQUXTruuF4Iyk+kYBUW/jjJ8+j5dvcMlqpT2kgGXyTNxJSq0gdIPhARRLTguqNBl/Hcb1nUa8BXfz9M+v0aURau+ITRq2NuXdvAWQ1LAOKg2K09NkCjGV5FBryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m538+Iqz; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E8SM0kUCm63/KA5auRY+06ic1R1eaIh69eRXGvfr/9c=; b=m538+IqzX64c8XRC/KO4zFNtgr
	XEBwPOZ17t5enfp6bSfr2TxY9bbwG4nmCNsndLuCed5R+Q0+SBoWU9vEaZqcPJp+G2hY+V9pavMCT
	53bcv1DR6Cm05dUdK1gi0n8bw+NO3lhKrrihbDoIu8VUS8VT2BSmdluikB+n/Ed7iFlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wg5Bk-00AiZ5-8P; Sat, 04 Jul 2026 20:34:04 +0200
Date: Sat, 4 Jul 2026 20:34:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vikas Gupta <vikas.gupta@broadcom.com>, gg@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
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
Message-ID: <13ce47bb-c8e2-4ad6-8942-e0b4f8ff9e49@lunn.ch>
References: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22758-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vikas.gupta@broadcom.com,m:gg@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A717708313

> - Backward compatibility with older firmware is not a concern.

Could you expand on that please.

      Andrew

