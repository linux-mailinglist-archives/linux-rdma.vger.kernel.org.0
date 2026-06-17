Return-Path: <linux-rdma+bounces-22294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UoS/By4AMmpItgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:02:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14F696080
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:02:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ankey-net.20251104.gappssmtp.com header.s=20251104 header.b=tOQJtQCx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22294-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22294-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8448630251CB
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7AE2DB7AE;
	Wed, 17 Jun 2026 02:02:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C727B50F
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 02:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661736; cv=none; b=HEW3TDYWvbm+SryIDNgQ9ionMR4UR9eB9P7mvd3Az2+6bPwQi55vPOlDZk5/2pNMIK6+x18gGbnsNRWhVslRuzcyibOVvnYNfi0q1eSqe6L/RQtv0EPbpJWdtQvrZCeWq39yYpO7YWgu5U7xoipnvsMZeUmEIHMGiqz9VZV57Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661736; c=relaxed/simple;
	bh=/6qqonAB1rvfwi0nHfBcjTnP0l6KSbTgCUpfm1TzYf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4ls2JMKXcYMI5A9t2hbTxZU479AY8zsEODEiSG0YYpqt9sayhT7bCCpQOfbD5lzjuuohfIpspd/CgNcE1O9wSz1Py6QLoJopEVi6YkcxPx18qbemZjH26aVbQZzeJKOuglLJunkAQQW1ceQT8GryLsxBQz7PRGnyEoMi76bX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=tOQJtQCx; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b9328c4aso38774125ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781661734; x=1782266534; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ztbMiRRaO/C1m+UU2CZ46ifpbNE3xQILmUDMNi364=;
        b=tOQJtQCxmO8sWi2mM1fh9NbmclYDichvbh8WHbygZw17Zn5GoApHfy2ktyo2wuH7lK
         jzRF8CgBklu+OV83/NHJxPlGbhm2LbAyipRS/a09aalFDcaaUNESMELmfXxYomfa9aTc
         vOH3hmx9VeopheqyQtAcElaVq1W40UNnBE0eC47ygMAVkx48Ka0oS825sPy/XB0VwAcK
         5ZsrrhtVu66uEd7cqg08yLQUztFx96Co1p4EvcdRA+62kIZRSTt+LwtzKVkvEJ3tmcL6
         f2vjjwbNYfW3bB0F1X8F5Xec0FOMONnraiDd/zDk2JNTguRw3xQkuhbWEICBnCFTBXdE
         24Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661734; x=1782266534;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7ztbMiRRaO/C1m+UU2CZ46ifpbNE3xQILmUDMNi364=;
        b=rHvPxv311a6YAwk6V+o+aSij0C/Zg7j8nEh6K0Qh3b/aA9HnDVFDNLWx/ZgsL6GdH4
         ZVnCT3E3tqhfipe0wIx2O6faWPLQsFwqBluuTuNRyeo/FAaZ9e6is5+oxytcXZUhdWRv
         rBjX00pO58eJUNfqVVBnaBqItJWP8irGbxgf0URms+zFfgFBY3S20x/aHkqBJeZs7UN0
         z7lMInrYTxJqnBV4eAR9mTbjo91ZyREmt/Lp18OTcaB4V/Bx1oI81wUDxU0Sqy2s20dq
         ZQcVGwR3OsR4KKwrnLLPmCZac7+DK3x84n2GNpND2UkQEKOKWgEeOEl53lJ6MmVxMbAP
         zZ9Q==
X-Forwarded-Encrypted: i=1; AFNElJ94PmrfjMasBUPRwL5ZyzFTlq+qwshQbpzt3E3nbArT261qtv8z5ofCz6Jshx6GpiCPSkWxh/PrClle@vger.kernel.org
X-Gm-Message-State: AOJu0YyRh3c1cLdTqzw4VKW7eLVz353mIs7wVY+Tp+xa6NfRi/LR/UkJ
	J6rtzS4C+r/u5qqW4baAMzhyUANume6o2TdRwkTZ01Eis/sdPVxoHokAbs4BooqxIg==
X-Gm-Gg: AfdE7cmNAmxrWWH4ryTTpxI53FOAmHgcG3qs3B069D5IO2GnbVrK6oi+nal06U9a90n
	rna6E7cWEBkkyeFJdoqpkqBYIaeIJFP5LryngHZFsSV+h99sb7mqHZ43PHzkr6M5uD0CfSvY4cd
	DDPLvalq6+yZYx4BKY/80jpzELCDOW0I6+gXZMuDmWQrMphZxE4WDLgLZUeMx+W+/XgartVI8g/
	ei5ojWwL5eZboxL7SGHPv9CyXMsxpI7yWSh9nufp7hpvbqlqK1S5LQhVFgB7oPDCR4szhsqnQu8
	LDL/Q5ajeJfJQvGw87okMO5/4N8USYm1Z/y/FalficuOUnxWEO8HU/S8Z3+4JX10Xr04ukVED1y
	9czqewwvznwMMm21YMtu662qWgvlcGWCNJ+wpQ3bER1rWgnvtDGV8yYdIYB01pt9pA1O0UGBA/h
	8RTPMaqBKYCr9rib3j2Ix34YlPmWB94LFSBdHaCW66H5CBE3q0535qQBudGiD5LIALis2kCGzfB
	csmX+vTdVNL30/dYlHKgz1IkTA=
X-Received: by 2002:a17:902:fc47:b0:2c2:8659:da43 with SMTP id d9443c01a7336-2c6bbf7cdeemr15372715ad.4.1781661733790;
        Tue, 16 Jun 2026 19:02:13 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([20.29.181.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a3ee1052sm25075775ad.48.2026.06.16.19.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:02:13 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6
 RDMA-CM connect
Date: Wed, 17 Jun 2026 02:02:12 +0000
Message-ID: <1781661732.reply1-sashka@ankey.net>
In-Reply-To: <1781545579.1-sashka@ankey.net>
References: <1781545579.1-sashka@ankey.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ankey-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22294-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ankey.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ankey-net.20251104.gappssmtp.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ankey.net:mid,ankey.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B14F696080

> You need to setup policy routing or a VRF so these local routes don't
> show up the way they do. We shouldn't be mangling the loopback routes
> in the kernel, and removing the check is not correct.

You're right, and thanks for pushing back on this.

I've been testing VRF all day and it solves the problem completely,
with no kernel changes. Putting each NIC in its own VRF moves that
NIC's addresses out of the global v6 local table (255), so the
cross-NIC same-host destination no longer collapses to lo -- it
resolves on-wire to the real egress device:

  # enp49s0np0 -> vrfdata0 (table 100), enp193s0np0 -> vrfdata1 (101)
  $ ip -6 route get <dst-on-other-local-nic> from <src> oif enp49s0np0
  ... dev enp49s0np0 ...        # was: local ... dev lo

So neither addr_resolve_neigh() nor validate_ipv6_net_dev() ever hits
the local shortcut my patches were rewriting. The check stays correct
and the loopback routes stay untouched, exactly as you said.

I validated it with the actual workload that motivated the series, not
just rping: a 3-node DAOS cluster (two engines per host, one per NUMA
NIC) on a kernel WITHOUT these two patches -- only the upstream prereqs
fa29d1e8877b + c31e4038c97f. All 6 ranks join and stay joined, and a
pool created across all of them comes up healthy. That covers both the
same-host cross-NIC path and the cross-host path, all over v6 RoCEv2.

One observation in case it's useful to others who hit this: VRF
self-RPC relies on c31e4038c97f -- once an address is homed in a VRF
table, is_dst_local() needs the RTF_LOCAL test rather than the old
IFF_LOOPBACK one to still recognize it as local. That commit is in
v6.18 but not in linux-6.6.y, which is the stable base we (and
presumably other RoCE-on-6.6 users) are on; might be worth a stable
backport on its own merits, independent of this series.

Given all that, please drop this series -- I'm withdrawing it. The
right fix here is configuration, not a kernel patch. Appreciate the
review and the steer toward VRF.

Thanks,
Alex

