Return-Path: <linux-rdma+bounces-22258-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q4dHAXI6MGq2QAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22258-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:46:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D2688F05
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:46:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ankey-net.20251104.gappssmtp.com header.s=20251104 header.b=On5wCwtp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22258-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22258-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB93303FB67
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9262DF153;
	Mon, 15 Jun 2026 17:46:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3E241695
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545583; cv=none; b=RUoYXwBUYwGrRcndCHega70etwbi7i57BDNWlFsgSuN29e6tSTY/U+Y30J0dvLsWsIIy5AwpRBn0H6ew/fqq3HGPI5FbsJDiPZPT3WNo8rVJwGoxMoNXRKrVQEA29UZIaLQNiXaSkAKCLyxf31EyTAXPALzCrv47SzWtb7WZLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545583; c=relaxed/simple;
	bh=ocWgTOMXwjI5TVoyjUAYU/X/PDgJy39gHQDLgMO3Sw4=;
	h=From:Subject:Date:To:Cc:Message-ID; b=YlkGzQL1lU6io0K8psMq4Fk8Q4DhZ8m6A9UWgp4OR35+I6A5bT/2zIe3XHLVb0fMoDMb4voRqesZu+0GJnjDe7rKxnUFNKnRRAMaS4YnpWqLG8SSEWGBqI5sXpkJJGM8ZYf45qu+UfcmpNO1rnsVeHqyfRfEIhZs3oQFEFXjrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=On5wCwtp; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842307473b5so2554165b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545581; x=1782150381; darn=vger.kernel.org;
        h=message-id:cc:to:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qetJH6uAcYEaNA7WIluzKnDC7IXjgavBC++l+5U3BLA=;
        b=On5wCwtp1pRC//8FxcyVQdPIIYJ8md7OxsbdrFC5TeeDB+qJ7En0EZ+l+966KKogis
         PV6pOh2cf5bcGKzyuu6B3v6MR+Sld5jzWd3xZLfm4YEkBIIT0dvK1gm+NrgwXX1D+3C3
         LhEwApg4gRtFX5dO3cdJw4SORuHloUcsTwI3bKFRIsaOEMvWbhQrrPQrK/jHn05fzEZL
         TkzDLxpziMM/K6Cbq202f2v5FCiqU8tHX5hkMTQPmIlmDfvkcVn8oeMO8nmfmiCtm++F
         q86y4EbPVZ9LWqDMAi/vT83BO7qLwrKhlDSzsig8m64AtvMeG6YCQaEb/DIKGDeRb/U7
         IYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545581; x=1782150381;
        h=message-id:cc:to:date:subject:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qetJH6uAcYEaNA7WIluzKnDC7IXjgavBC++l+5U3BLA=;
        b=m0QuRz+HX7Y9FEpu7dg5G0omM22spwWaRgAhaP60yIyNNn9toq3S/0EukYmGwuTRhY
         2RziSk1+CTuUrgsLYmiOQbvpiIIWpj6g1PCfXrrjKMHIy2/r++ftuHrOG6yFXDXSlwMN
         7HiVbvutljt24Xas71no5BX4npckvBvpdyibfy22mOvb8XKK0fvDo9Nr/guhVthSk27O
         goo1j7micBaxrtMyVmx/Gi+noAnKeXYNxjqQhe6hstXfDYw2UH9blQZRxu1SbDIVkLgC
         4v1w0Gf2d1z6lnfP45Teymmde+6CGjotTHzlVFCex8D1AYXHJqWj9luvNasN3hFUkjS4
         cfqA==
X-Forwarded-Encrypted: i=1; AFNElJ83PyOr8fbr1HLmIidh+/QHnNIw6utSWaoxj6m4XNxOHP8xj9bMLTPYxGoMHAGoj8PBUvvcJrnKFa2w@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwTIrGSGgsNdoA5A7E8DnlGlpltvI7rtHbg3x6WWEhQidHnFw
	U/LXhxl8eJIXr75A7BJP2C0mVv7Unfrm2Vc5/A0SVQGfSbqQvwzAAbjjvPTnRmcBbQ==
X-Gm-Gg: Acq92OFSE7zip1baJ3ROiug3Iq6pLVhAmXc7trZ++SWQ1rKAnZsrpHVteR6Vs7SUHnY
	HfTKctgT+6VKYbPRPpr3c8PIjo2BN/eQINCm8XVN3S5P8EbBiIDvlr/dp4Mc/DGMb9Xy0oIBR3o
	jFKWncSc2O/Jwh5pkZ6DSJzfd/XJz2OW+LN+e7XdtBVEhhhgYxtj9a00adff8D5UBHG00HFGcsb
	B/U9FTCzajG2TOglKfJavBjLkQpy4hjrzoF57yDmn2w0kvn0j8CKLvmBQIxcawSN88o1QMDCRbj
	BPDSEdynhCJv1CVbPxUIrjEgse2SnvjMGFxxWo3AJVqHdS6Ia999yqJiUtJcQxoetIi//IiMuLX
	BNUdmryV1tKNBq+6wjbsvmBrQzuljUVbo5dFwLU0o0HKp1rlH3+ya16VaZLqnRD9qKWXi71iuuk
	kuISAlwMMWQVdQlU1f03Go3ntmEBePfrHC79Or2rzNMoxBlXY43kCqkNIROTC3jXDH7rMetL57b
	3PVmaIgM3gEm6hC/s2i6gMs9vHO9ZAKZAERL7pQJFnetHA=
X-Received: by 2002:a05:6a00:1311:b0:842:7867:430b with SMTP id d2e1a72fcca58-8434ce40e46mr16487940b3a.29.1781545580609;
        Mon, 15 Jun 2026 10:46:20 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:19 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject:
 [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6 RDMA-CM connect
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ankey-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22258-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ankey.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ankey-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ankey.net:mid,ankey.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E15D2688F05

RDMA-CM cannot establish an IPv6 RoCEv2 connection between two NICs that
live on the same host. This shows up on hosts that pin one process per
NUMA-local NIC and let those processes talk to each other over each NIC's
global IPv6 GID (e.g. a storage daemon with one engine per NUMA node on
dual ConnectX-7). rdma_resolve_addr() and ib_send_cm_req() both return
success, but the destination NIC silently drops the frame and the peer
never sees the REQ; the connection times out.

The bug has two halves, one on each side of the connection:

1) Send side (patch 1, drivers/infiniband/core/addr.c)

   When the destination address is local, addr_resolve_neigh() copies the
   *source* device's MAC into the path record's destination MAC. That is
   right for true loopback (same netdev), but for a destination that lives
   on a different netdev of the same host the destination NIC will not
   accept a frame addressed to the source NIC's MAC and drops it in HW.
   The fix resolves the netdev that owns the destination address and uses
   its MAC.

2) Receive side (patch 2, drivers/infiniband/core/cma.c)

   Once the REQ does reach the peer, validate_ipv6_net_dev() rejects it:
   rt6_lookup() of a same-host destination collapses onto the loopback
   netdev, so the strict rt6i_idev->dev == net_dev check fails with
   -EHOSTUNREACH even though the REQ arrived on the right net_dev. The fix
   accepts an RTF_LOCAL route when net_dev itself owns the listener
   address. This half is only observable once patch 1 lets the REQ arrive.

Both halves are needed for a working connection; patch 1 alone makes the
REQ reach the peer but it is then rejected by the unfixed receive side.

Verification
------------
Measured on two RoCEv2 ConnectX-7 ports on the same host, each with a
global IPv6 GID (port A "src", port B "dst"), driving a cross-NIC
RDMA-CM connect (rping, src GID on port A -> dst GID on port B) while
tracing the destination MAC resolved in addr_resolve():

  without the series:  resolved dst MAC = port A's MAC (the *source* NIC)
                        -> frame dropped, connect times out
  with the series:     resolved dst MAC = port B's MAC (the *dest* NIC)
                        -> connect completes

The kernel under test carried c31e4038c97f and its dst_rtable() prereq
(i.e. the same addr_resolve_neigh()/is_dst_local() shape as for-next);
the change applies unmodified to rdma.git for-next.

Note on stable: the Fixes: tags bound the backport to where each construct
exists in its current form. Trees predating c31e4038c97f have the
equivalent send-side gap in the older IFF_LOOPBACK form of
addr_resolve_neigh() and would need a separately shaped backport.

The patches are independent files but should be applied as a pair so the
connection works end to end.

Alex Timofeyev (2):
  RDMA/core: use destination netdev MAC for cross-NIC same-host local
    dst
  RDMA/cma: accept cross-NIC same-host local dst in
    validate_ipv6_net_dev

 drivers/infiniband/core/addr.c | 22 +++++++++++++++++++---
 drivers/infiniband/core/cma.c  | 15 ++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)


base-commit: 20ff9350862468af21b46cae2c22d17d6ec637f9
-- 
2.40.4


