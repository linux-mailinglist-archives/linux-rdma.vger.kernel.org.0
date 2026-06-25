Return-Path: <linux-rdma+bounces-22478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YATJA7V2PWq63QgAu9opvQ
	(envelope-from <linux-rdma+bounces-22478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 20:43:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 735266C8449
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 20:43:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=email-od.com header.s=dkim header.b=PZvKz0Ls;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22478-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22478-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A34E13048C2A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66812330315;
	Thu, 25 Jun 2026 18:42:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD530AD1A
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jun 2026 18:42:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412977; cv=none; b=prJnz/HfC+FfL2JdEx+OoxoL2Ef8/Zkre7EoOE5SFoITqftTbiZ1RXOo1TNyg+DCMZPRtxxVS4R9QCekXgFDS5t9xjvSFzVYZPTilW8zwHD+Gp4ZP6Iqh8TEyMN2Jq8tEdgPJkMpnYRtBJ5QJ9ZCJ6AoQ4lvL7p5Qk1i1NfQ1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412977; c=relaxed/simple;
	bh=kJKNJkF5QOs4cZuQ9+D2G3nujsZcacTzbC9UogrJ7oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L28NBBEn1nBmM+qPYToEkYZ2nccaB/2+Ja3iPEQawVVDkC4FzmDZgldFGbmd902cTR7mH0/x5m//fpohshMBbnHHi2zcyCx7ZSLl+2rOtsjwbZfhDJ/i+VdLHR6p3hTTGNbGZ+i+QIwGDVytLACWzeV3eqI0DPv+7HkrD8d932U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=PZvKz0Ls; arc=none smtp.client-ip=142.0.186.134
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1782412976; x=1785004976;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=QafzHX47EfvlGgwNVRYg4gzbfir7598XKcBTZi54JhQ=;
	b=PZvKz0LskFaZaoAkwPs5PRXESXLmCTMGbGcGIOTE1DZIf6JB7Iz4Y6sggWNZ6JNo5DkYQ1FlGIlYVtDkRZsfCuLC50bYaReOOfwGaozJRxlLD8hz+XQ/cqi2VTemZSYUfeziBydiDukwHsvht18i2JAInHDTOvfICx9he2A4Yjw=
X-Thread-Info: NDUwNC4xMi4zYjRhMzAwMDJjM2MwNTMubGludXgtcmRtYT12Z2VyLmtlcm5lbC5vcmc=
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id 873A72CE019A;
	Thu, 25 Jun 2026 13:42:31 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	dtatulea@nvidia.com
Cc: dev@nalramli.com,
	nalramli@fastly.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning on frag page release
Date: Thu, 25 Jun 2026 13:40:58 -0400
Message-ID: <20260625174059.2879717-1-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[email-od.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22478-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nalramli.com: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:dtatulea@nvidia.com,m:dev@nalramli.com,m:nalramli@fastly.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@nalramli.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[email-od.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,email-od.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 735266C8449

Hello mlx5 experts,

We have been experiencing frequent WARNINGs in the mlx5 driver on frag pa=
ge
release and we think it could possibly be caused by a bug in mlx5. Could
you please review the attached patch and provide us your guidance on
whether or not our investigation and assumptions are valid, and if so,
would it be possible to incorporate this fix into your next release?

Best Regards,

Nabil S. Alramli (1):
  net/mlx5: RX, Fix refcount warning on frag page release

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 39 ++++++++++---------
 3 files changed, 22 insertions(+), 21 deletions(-)

--=20
2.43.0


