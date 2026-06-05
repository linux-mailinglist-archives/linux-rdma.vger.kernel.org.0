Return-Path: <linux-rdma+bounces-21874-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ytfsLzwnI2oMjgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21874-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:45:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD164B08B
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 21:45:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=L5ivxWRC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21874-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21874-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6880301A938
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCF400E02;
	Fri,  5 Jun 2026 19:38:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A012357739;
	Fri,  5 Jun 2026 19:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688334; cv=none; b=HHCkY37EYqtymbFYjH/CjWAE/J35L/INfXQxWX50Q0UJcCHtBLBQIT8Gve/x+pO5Lf3MzKlQ1L7ZCwbbfP4gpBR2yVEZVCRPaVBjbxXDTtvlf5y+H1DMy0usSdWJrUQhLlrFU3LHFLVZM7zsHQzCkli0rfHik0GL4oclpW/0WEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688334; c=relaxed/simple;
	bh=lCwO5Rwr3CuwAk5QAocAvVlHD7rUNE/JkIOKu5NrsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGCSmzA2ftFi2ZUveMxhHb1lG9Jntythwe24Oukb1+oXL3wr4I1Kh4x7eu9HimYgBX/3ga0eLu+ptIFeRD6eTYdZagr/y1ISbzyzBVR9nuWTTBO4VyyKBsF8qU5jJqtXmx+kljrNGHMPb0vB8xn7Bjl6KkW4ZyqVle663w53iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L5ivxWRC; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EA09540E01F9;
	Fri,  5 Jun 2026 19:38:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UseOQ94Zu18F; Fri,  5 Jun 2026 19:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1780688318; bh=yMNim7+M4ABpkCsf5wTM7i14oOqpyG/4aQieIQ4pxgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5ivxWRCx4VgbIkEomBzqdDTY/eUKo20HGoIT9Gx6wEvTJp81zrO3rwkwjnpCgr/w
	 c9HFOOH8Pp/Y88RsGxhP5wEU+IGCP0Ml3HzO5ZpwZO09z1TCv5+TAHt6xwblstOsAK
	 NkPFeHEVDnbfjnzwIcldbTcSDHuzfqOcq+tZc3+OxkHuGkG5Xef41svr0bz9ix4ura
	 8zHOSx48y+6S7rGN7Eez4/GMM17vLfc5U/MFzljFJZTdS4NFzniDBQzrr52Vu5ErA6
	 ZUxYY3jNw36TuOynV6Y/ojdEIjGM1Rduulv3pjU+W3/YxdyG3RVKJi5XsCPZr+Bgv5
	 k6KgUrKgPssTGJw+MOpTUgOfD+KCuocStOsbIWFVTopQgjO//oTZHVSqTB9agm0AmK
	 Dg/TPpawtLGmxCV1Qem5zHj1nxV0fJ7WVt7bfdxvfCAMU5kERh2t26FvCRA1YoAhcF
	 PqCF7PX4GXv+MqNkb9Fqpx3IK932v+9mL9RJ/aYVfOPBJsXG3QjS4XQI3czWX7hbm0
	 TfsKFVrz6fBrQHRPXJfI5uCjiLzm6551VucGUsKZB4kI5F5avzlgHyMytYZ/H0Yxmf
	 CY/7S+91ujoSjSpSaZHaqDGsMWZyXVj8mC1dPNmRfN2jWOadkbmNnWVw5ZnflXhtq+
	 a/4p5C5BiTnlEAfjqCREC+sA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D53DE40E0203;
	Fri,  5 Jun 2026 19:37:57 +0000 (UTC)
Date: Fri, 5 Jun 2026 12:37:55 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next V3 0/7] devlink: Add boot-time eswitch mode
 defaults
Message-ID: <20260605193755.GEaiMlkzeIgEXc-qtZ@fat_crate.local>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21874-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bp@alien8.de,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,resnulli.us,marvell.com,nvidia.com,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,baidu.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:from_mime,alien8.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23DD164B08B

On Fri, Jun 05, 2026 at 09:10:23PM +0300, Mark Bloch wrote:
> This series adds a devlink_eswitch_mode= kernel command line parameter for
> applying a default devlink eswitch mode during device initialization.

Please trim your Cc list. There's nothing I can do about networking. You're
CCing too many people unnecessarily.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

