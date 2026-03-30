Return-Path: <linux-rdma+bounces-18793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOSwGOumymml+wUAu9opvQ
	(envelope-from <linux-rdma+bounces-18793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 18:38:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69935EE74
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACCB5304BD3A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35490387378;
	Mon, 30 Mar 2026 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeZfhOar"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F23783D1
	for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888404; cv=none; b=kZ6PEnO+klV/UJW0SQyRlhNIOZ0EjvwWKNQgk3WyUCxOAnrqVMR32YwMLfVfSiCrjus6DRUrgrmrPFhZjYt+nreA6m4nCW+bhxXhXJKFz7cy0BBja2BjtF2kHqK1oENHy6fb9t1Cnmqx2pQE1BDbCUFB6sSTp9spXx6eqp9BTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888404; c=relaxed/simple;
	bh=bGbFMyNnpvCVl+J0fK0MN9STuZl4qNUJD/+cYmD4OpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ac1esnc58vICN0v0a9jjfh25mapT5MRKr0YwURRPXDyzRXqE9SmLqYhnkSiVhcewaBmtXi6Gbios//HiIbcJ5bAXUuL7IxxGfPnj6RthjhlQjlhAxgWo7PcI1jAqP+/n3Xbnw0zoCFNccXwTzdncjVBYL45P0zqNKJy/a9SlfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeZfhOar; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso3082365b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774888401; x=1775493201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MhflspkR5aGjRme5EkFXDYWe0+axu7ca+z2U/EdobE=;
        b=NeZfhOarwK6GEC8IqRuS5PmzQhLLx9Tup3nFB7zj4xMez+K75TIFUEq0xveereSNHR
         4su2/rT6ED326uONP4oFMpE2UAS5FaFsz7OLuL92lUX57zIzgeSvJfkL7RQRX1RlWpsU
         FkNBxHvmtjCbYko11BVepk6Qyxj06jAulx+vNRbwdU4mjnqeSzmlTdKne4bbQkPtsJOM
         ZnwtDwKChm/e+j6WzGHuMuxON2pOxd/uksr1r+hOkr3WUdfLMhOMEShhFwUAM8w0ZdHn
         hxd2e2gwhV7Q8kZynI6txCJWdsP2mvy9z50ui8ahlMKHHsRysnJh4dvnhem5rwmS8o7K
         XxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774888401; x=1775493201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MhflspkR5aGjRme5EkFXDYWe0+axu7ca+z2U/EdobE=;
        b=TgMtt7SppAw8VzdUjo785GqIXyhD5cnR5Y6kTIJ5Od8J5myovHdqI1usOv6pC9bvoM
         IaIhU9amIGQ/bmQlo1q+f1mEdLjaWaQFXPgaIqfKX+orenOEjv6jwAlWkjw7dg4ehnbs
         2SnEzmZ/0M6raWn2uhDRE1BzGDFvP7XopRH6qCXQoQtYFgT0r+icy33EPOKf8X3IPdua
         KhDrIUVjc13y3pkmRHqk/ncY5BhNvtYpsRNUax/H90NEZEmypKdr7Wy332xaMIjtM2mg
         cGgno4DwDXfgpECaBeRjdzdjC+qgF2e7KlzK5dtGG8MgmXVHjmuLeUXM8XcsaeX7ZkPo
         uw4g==
X-Forwarded-Encrypted: i=1; AJvYcCWY1XOj6H4g+RTUyRvlbNGuAHlMpuJjcmk3S0wdGtjfX1f9Lo/St88M0hHkA4N4yRC6U1ovfD2JP5IZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzgW9kf6mLVb9Un+ieG//nsVeDU038/9bhdFstp3LPo+0yEJ3
	IMUaHPzhm2RauQr1QrYlrZVIRrBs8nLkE2FzUIeDBbUtWC6++ZvvANpH
X-Gm-Gg: ATEYQzwMJcdchUAHMF/gSdQe9vQRokiVQueH1Bgrs9TPldTFM1FNi4Y1KmHpXRlYtRF
	SmH50SRPrdNPEo559TsQ/8WAHzUwdVTZZdug5aNkPkMWGIKnwM3ec7XiR9vPwK4os6Gu/P6hu8/
	aPpJ4NO/CDHkdNNw6VVur3X8jN1uqlqXtErzp6VoXkFjifun7StzLX65GkkA+4lhoRxyuMDKV3a
	4Rfce9+B1lseIJTBXxoHW2mnd816v7A0GcZ0ROvjhpdbA+UjIZqK4rNX4iJ07whoAAikAG6DbAd
	N/6oj4exxWKUcDC6R2QYiEhM57loJkhvnyJxIejHS4iftqwsPXdgz87oYCBFLtbn05VMVLfpdSw
	1fl7TV2deOcfeOSS3ZNcvL/QmhabgW6yjA2D2SLW9/nKFeB+zRsorKjkl7jUwIq/e2BYVZQesVd
	TloAJOk8CO6raHY8uhH/7CHiJ7fpXJbymoOEB9Vf8BA6PpRUgEOdVncZRqUvSps3B09++Va3NPD
	JHQHZ9eCBIX
X-Received: by 2002:a05:6a00:17a8:b0:824:3ef6:a815 with SMTP id d2e1a72fcca58-82cd623571bmr198850b3a.8.1774888400531;
        Mon, 30 Mar 2026 09:33:20 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6e9sm9137762b3a.46.2026.03.30.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:33:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] rds: ib: reject FRMR registration before IB connection is established
Date: Tue, 31 Mar 2026 00:32:38 +0800
Message-ID: <20260330163237.2752440-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-18793-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA69935EE74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rds_ib_get_mr() extracts the rds_ib_connection from conn->c_transport_data
and passes it to rds_ib_reg_frmr() for FRWR memory registration. On a
fresh outgoing connection, ic is allocated in rds_ib_conn_alloc() with
i_cm_id = NULL because the connection worker has not yet called
rds_ib_conn_path_connect() to create the rdma_cm_id. When sendmsg() with
RDS_CMSG_RDMA_MAP is called on such a connection, the sendmsg path parses
the control message before any connection establishment, allowing
rds_ib_post_reg_frmr() to dereference ic->i_cm_id->qp and crash the
kernel.

The existing guard in rds_ib_reg_frmr() only checks for !ic (added in
commit 9e630bcb7701), which does not catch this case since ic is allocated
early and is always non-NULL once the connection object exists.

 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 RIP: 0010:rds_ib_post_reg_frmr+0x50e/0x920
 Call Trace:
  rds_ib_post_reg_frmr (net/rds/ib_frmr.c:167)
  rds_ib_map_frmr (net/rds/ib_frmr.c:252)
  rds_ib_reg_frmr (net/rds/ib_frmr.c:430)
  rds_ib_get_mr (net/rds/ib_rdma.c:615)
  __rds_rdma_map (net/rds/rdma.c:295)
  rds_cmsg_rdma_map (net/rds/rdma.c:860)
  rds_sendmsg (net/rds/send.c:1363)
  ____sys_sendmsg
  do_syscall_64

Add a check in rds_ib_get_mr() that verifies ic, i_cm_id, and qp are all
non-NULL before proceeding with FRMR registration, mirroring the guard
already present in rds_ib_post_inv(). Return -ENODEV when the connection
is not ready, which the existing error handling in rds_cmsg_send() converts
to -EAGAIN for userspace retry and triggers rds_conn_connect_if_down() to
start the connection worker.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/rds/ib_rdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 077f7041df155..2cfec252eeac2 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -604,8 +604,13 @@ void *rds_ib_get_mr(struct scatterlist *sg, unsigned long nents,
 		return ibmr;
 	}
 
-	if (conn)
+	if (conn) {
 		ic = conn->c_transport_data;
+		if (!ic || !ic->i_cm_id || !ic->i_cm_id->qp) {
+			ret = -ENODEV;
+			goto out;
+		}
+	}
 
 	if (!rds_ibdev->mr_8k_pool || !rds_ibdev->mr_1m_pool) {
 		ret = -ENODEV;
-- 
2.43.0


