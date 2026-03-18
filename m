Return-Path: <linux-rdma+bounces-18298-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBoSEdJ2ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18298-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:56:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E652B9889
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89AD63103400
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF43B9616;
	Wed, 18 Mar 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ar4+CWE7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736383B8D79
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827466; cv=none; b=F0VqH94pC5atsNkaetQudu0RnAvCz+2W/3AvA+dqZT4e6LpDwAlLldGiZ0kMda4a53qQtes4k7DC8LTLHWLUVdWCYAlLk4LQdI59n3o51G403GJYEnQwhBpux9zWg4FmEtRWeLI5hKJ6JdFOSkUsoyJmIw/MeGj0ATLxshT2qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827466; c=relaxed/simple;
	bh=rZ6XLqrSHLVYtGkiWq+/3mIvzZ8RhMzqjek4N8MpSH8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Kz3ENeZPIFRBXrB9gXrYoAD2zJ3nDXfc+b8wkP+F9hrFiN5Q0PEFCI2TV0NlL3GiFB4q5UDq+a4VAdNtr9JKzEpUbOWwliZtTrD9wAuV8FV6sIlVBjsBrjyXtqbF1HbmgyPAFN9xanMBZprW4kBHn5vGKAtziiNR1eJk5mifFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ar4+CWE7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so78537665e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773827455; x=1774432255; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ6XLqrSHLVYtGkiWq+/3mIvzZ8RhMzqjek4N8MpSH8=;
        b=ar4+CWE7jmFpDlvhZEkRV98tby/YOxxwTNhJgUizrtWV7kLIAgZu/q9EunFsTeQIg6
         v99TRDiA88bWkWI8h2Y0EZJcG6CyXdyTjrHRJhT6znP38qjl2sWl2LK2NMN+0GnGT5J+
         /9X62r0U3fZbfSlsuf5MS2uBE+SqJ6gjtxJFMxsB7J9YVk8IPzM+/7NYZWwtZcj/PJUB
         ewBf+eoslgCl0G5dOVwpf7OSVK5ZGDiYIzXOYai4fzU0YWiuwmCPh3lWcEr5YH8MdjkY
         z8Gj8r+jUhgsam6JOTZ6Ud6CRYXjURDTJrjiNw1r9DF8tICLr7dinLyTowXUfuyrK86n
         qZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773827455; x=1774432255;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZ6XLqrSHLVYtGkiWq+/3mIvzZ8RhMzqjek4N8MpSH8=;
        b=kaHUUpLb5a48J/QN+CxGSNImulb2aGpmG/8bE4rK4Ig7gdBrBXWAQcrfc6A3oVzk4d
         kODyA/d6UMqnbd89TnytSd+ZfZZdL7dxRIxacMkgZuub7Yyqrx8VnIQMbGvxpzmqKsFL
         zHb9kEE8cbA0mj0M3TZXldaNVYPsYid3IwSMImzSaDh3W1D0q07JuYgzFO6jme8G7w3h
         3nrNkrrAO+ux3v6gJgRgp3DdVOBOl8+HOVXGB+6xsYuN1KxQfRUXQ4Zy1RLbe8/kdEwh
         OVGSYlT6EUgFAxkGtRSGcr0GtSZcumwbCB1389rJF0fMWyEGRgIE50GZwTrRmhV6VbQ8
         aCdA==
X-Forwarded-Encrypted: i=1; AJvYcCX9uyE32NjA7tzhvUWro8ZQo5yA1upo4ELnyHmsHXhuPePVK8Bx0zWPfvm8mkDab+7wuGw6t2KXFAtZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UyuES2dS7+cLyK0p7Z4UwoeUnyAyJ2ivrBjHS2xRPJaPoHMF
	5y98/ds9YrG267ajucmR9ivo/iwRxyxvbYmgR0mA6mm5r0DvUjPfGSoI/K2yrFZ7ork=
X-Gm-Gg: ATEYQzy6GgHVoxZq8kfnM+g30b70+ahTu7ylGQpvOO6qfXrf83UOtlHh7WZbBvknFk/
	Tc3cTzOWL5/faLinqthGqZogIhKmtfvDA67xolVh6DNzCPwNld4k7cISBT0dQzg9XpnijGgOn9W
	Fjdd8StAOGdc3J97mDvji/1qRVlCx0TI9fgMuaU8W4sHUhqzqo4VF81MdNzVIb2pY1rnqquoI36
	QsydotmTJA/ChOpjzkLgqQ/K3+GgzwdziR+FkhKI05U5+ZkVvuqmfGCtvvgx/dKsMTXZF1HpU39
	JJtnKCrm+5PVokJekx+7/2FE6dRIrWxZHNNTRtebdRtH9H5g1qeHidm7EXW7ooCBeYSXAqDcFR4
	QWAvzjr0uMJ7xDNSOsJfdnyk8jeBRMBWwHWxDyKO/UkcQO3H1yuyb+amQeBqnlCvdzL05VVF2h6
	QxUtXU6EF8o75TdcIRMdg=
X-Received: by 2002:a05:600c:4612:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-486f442e710mr28542555e9.3.1773827454803;
        Wed, 18 Mar 2026 02:50:54 -0700 (PDT)
Received: from localhost ([189.99.238.44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715f8b61sm13492337b3.44.2026.03.18.02.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 06:50:51 -0300
Message-Id: <DH5TCPI2CFJ2.ZBO1LQWYQUCO@suse.com>
Subject: Re: [PATCH 01/10 net-next v3] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
Cc: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Selvin Xavier" <selvin.xavier@broadcom.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Ido Schimmel" <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, "Simon Horman" <horms@kernel.org>, "Saurav
 Kashyap" <skashyap@marvell.com>, "Javed Hasan" <jhasan@marvell.com>,
 <GR-QLogic-Storage-Upstream@marvell.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>, "Varun Prakash"
 <varun@chelsio.com>, "Alexander Aring" <aahringo@redhat.com>, "David
 Teigland" <teigland@redhat.com>, "Andreas Gruenbacher"
 <agruenba@redhat.com>, "Nikolay Aleksandrov" <razor@blackwall.org>, "David
 Ahern" <dsahern@kernel.org>, "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>, "David
 Howells" <dhowells@redhat.com>, "Marc Dionne" <marc.dionne@auristor.com>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>, "Xin Long"
 <lucien.xin@gmail.com>, "Jon Maloy" <jmaloy@redhat.com>, "Bjorn Andersson"
 <bjorn.andersson@oss.qualcomm.com>, "Arnd Bergmann" <arnd@arndb.de>, "Shawn
 Guo" <shawnguo@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Sven Peter" <sven@kernel.org>, "Lad Prabhakar"
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, "Kuninori Morimoto"
 <kuninori.morimoto.gx@renesas.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Kuan-Wei Chiu" <visitorckw@gmail.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, "Ryota Sakamoto"
 <sakamo.ryota@gmail.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Kir
 Chou" <note351@hotmail.com>, "David Gow" <david@davidgow.net>, "Vikas
 Gupta" <vikas.gupta@broadcom.com>, "Bhargava Marreddy"
 <bhargava.marreddy@broadcom.com>, "Rajashekar Hudumula"
 <rajashekar.hudumula@broadcom.com>, =?utf-8?q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, <linux-kernel@vger.kernel.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-rdma@vger.kernel.org>,
 <oss-drivers@corigine.com>, <linux-scsi@vger.kernel.org>,
 <gfs2@lists.linux.dev>, <bridge@lists.linux.dev>,
 <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
 <linux-afs@lists.infradead.org>, <linux-sctp@vger.kernel.org>,
 <tipc-discussion@lists.sourceforge.net>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Fernando
 Fernandez Mancera" <fmancera@suse.de>, <netdev@vger.kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-2-fmancera@suse.de>
 <69dd007c-16d3-44c2-bc30-4e7f5a95addb@oss.qualcomm.com>
In-Reply-To: <69dd007c-16d3-44c2-bc30-4e7f5a95addb@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,linux-m68k.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,gondor.apana.org.au,hotmail.com,davidgow.net,blochl.de,vger.kernel.org,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18298-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[70];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:url]
X-Rspamd-Queue-Id: A7E652B9889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 18, 2026 at 3:51 AM -03, Krzysztof Kozlowski wrote:
> On 17/03/2026 15:00, Fernando Fernandez Mancera wrote:
>> Maintaining a modular IPv6 stack offers image size savings for specific
>> setups, this benefit is outweighed by the architectural burden it
>> imposes on the subsystems on implementation and maintenance. Therefore,
>> drop it.
>>=20
>> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
>> dependencies across the tree that explicitly checked for IPV6=3Dm. In
>> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
>> and MODULE_LICENSE().
>>=20
>> This is also replacing module_init() by device_initcall(). It is not
>> possible to use fs_initcall() as IPv4 does because that creates a race
>> condition on IPv6 addrconf.
>>=20
>> Finally, modify the default configs from CONFIG_IPV6=3Dm to CONFIG_IPV6=
=3Dy
>> except for m68k as according to the bloat-o-meter the image is
>> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
>> this architecture by default. This is aligned with m68k RAM requirements
>> and recommendations [1].
>>=20
>> [1] http://www.linux-m68k.org/faq/ram.html
>>=20
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> Tested-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
> That's a Kconfig/defconfig only patch, so build system. You cannot test
> it in a meaning of testing code. Building code is not testing.

Should I have sent 9 emails instead of 1 to the whole series?

>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> You removed important parts of Ack. It was not provided like that.
>
> Best regards,
> Krzysztof


