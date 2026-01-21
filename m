Return-Path: <linux-rdma+bounces-15861-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFgcOXo0cWlQfQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15861-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:18:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026D5D00B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A81A8E876
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E033B96B;
	Wed, 21 Jan 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="SIVTIhgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2E35B13D;
	Wed, 21 Jan 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026055; cv=none; b=nVJyz++v3ckHIZyiCGrRXfPSE9iP96RQ1VpFgM5eOswC0oXStdRi5OLskj4WpowtascxDFRHJA3gR0hTLZ2x6NYGlK4+MBK/9wkNwC9TeAvYJefRVXNi0ueg4UHYlEXRSGXA6dX9TY3aGSXNyRsTyIX85mIq9EzuWJVBrjYUZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026055; c=relaxed/simple;
	bh=cOnqUUL7E4FTsaHW7SE9STpkjqum3me+/nnXUw9NXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xyn1d4HH5skhMOLh2c+A/lug0YabBrN7FjnEPZTTewW1vZrnYz9NNqy1MUTHuQHjxxbsmA1tbwxjDtrSE49UwoOiaL7TkxA2nRz6YjlnMyjM7sKHltVJHQfLxrlGiJYVpvCkqbWrHXi3s/IVlPAfOeiVIhaL4HFXn53E0sn80Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=SIVTIhgp; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=TqRv1PrsZuX8ecKkLkDgc7fJ7itA2d4kN4K7Sowwdy4=; b=SIVTIhgp8U92R6hn1xUVwwkLCA
	CS9mLoyttm94XuVfM91FC1zFneOUZqwR2VEfj7tD1R1bA6FvLzcwFf2tCtPKJBrqEd1Nk6KXqMBvA
	/d+DF51yxBmx6MYvuWC0sh6f6xVSL8kW8aziaGzUE/Ux0X45EhERyiHapS+OXwsEiQ+9Enln886qY
	ZUpYKPvcvMEm6B4PJvlCI4VsHykx8Sj8TFo5T+LM8B7N/9f6YhQ3s9Wa6uwJppSLRtBfYM/deBHbg
	FDunl/N7RzTZ1zfhxfsb+Xs3nJMoumOIc0ebCxxlAJUr08a9A2aCVbrcRTCJ4hNbYju8oheuuPqBE
	orENp8aTvdMObZa1yV5lt3nSz+To7S/6zf902s457LS4827GUzGxa+lX2wG39zU52Ppcz2DxPxsxB
	YvgMTHu9Mywhda+uxw+cOUow/Si1DClXtuDj89bp6MYNFHDG8EvlzsJd8ScWbuuCNMyvyW+yzmIw5
	jQyvCuAC8fPZHOUH9Bf9y49a;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieUF-00000001ejf-0cvq;
	Wed, 21 Jan 2026 20:07:31 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use rdma_restrict_node_type()
Date: Wed, 21 Jan 2026 21:07:10 +0100
Message-ID: <cover.1769025321.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15861-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[samba.org,ziepe.ca,kernel.org,gmail.com,talpey.com,microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	DKIM_TRACE(0.00)[samba.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8026D5D00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

for smbdirect it required to use different ports depending
on the RDMA protocol. E.g. for iWarp 5445 is needed
(as tcp port 445 already used by the raw tcp transport for SMB),
while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
use an independent port range (even for RoCEv2, which uses udp
port 4791 itself).

Currently ksmbd is not able to function correctly at
all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
at the same time.

And cifs.ko uses 5445 with a fallback to 445, which
means depending on the available interfaces, it tries
5445 in the RoCE range or may tries iWarp with 445
as a fallback. This leads to strange error messages
and strange network captures.

To avoid these problems they will be able to
use rdma_restrict_node_type(RDMA_NODE_RNIC) before
trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
before trying port 445. It means we'll get early
-ENODEV early from rdma_resolve_addr() without any
network traffic and timeouts.

This is marked as RFC as I want to get feedback
if the rdma_restrict_node_type() function is acceptable
for the RDMA layer. And because the current form of
the smb patches are not tested, I only tested the
rdma part with my branch the prepares IPPROTO_SMBDIRECT
sockets.

I'm not sure if this would be acceptable for 6.19
in order to avoid the smb layer problems, if the
RDMA layer change is only acceptable for 7.0 that's
also fine.

This is based on the following fix applied:
smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND on init
https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.org/
It's not yet in Linus' tree, so if this gets ready
before it's merged we can squash it.

Stefan Metzmacher (3):
  RDMA/core: introduce rdma_restrict_node_type()
  smb: client: make use of rdma_restrict_node_type()
  smb: server: make use of rdma_restrict_node_type()

 drivers/infiniband/core/cma.c      |  30 ++++++++
 drivers/infiniband/core/cma_priv.h |   1 +
 fs/smb/client/smbdirect.c          |  26 +++++++
 fs/smb/server/transport_rdma.c     | 108 +++++++++++++++++++++--------
 include/rdma/rdma_cm.h             |  17 +++++
 5 files changed, 154 insertions(+), 28 deletions(-)

-- 
2.43.0


