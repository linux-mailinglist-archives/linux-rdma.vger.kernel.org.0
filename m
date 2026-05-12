Return-Path: <linux-rdma+bounces-20475-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMgZHff1AmqvzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20475-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:42:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC751DF47
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9559A3008D77
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF93B7B75;
	Tue, 12 May 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PCPLz2ku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003C025B0B3;
	Tue, 12 May 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578933; cv=none; b=s5AA3ygGTAtlhP8RwDxcjimR2n4ZBbv66KEVmwMU9LMBSlptuJNFrAzG7qel82vYEmmU2S2ipuwla1ZlzuKiFGH9hlvp/EPxyXVeRmvnO5wggbGz38PcUkxoChH8s/wdeN9SUU2SfdZQBXNy9YxN1yvcWKxOAZ36xNWYhyq0CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578933; c=relaxed/simple;
	bh=h01wSVlOKeL6zz90a+6NC126jPSw8lwXIHFZEz7QtI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwsAzBnfeAHnH1Xph7ln6DYP53fJmpp2e8Ppq62MRnk0M3/Ul2/wwk9RNxnJKrw3iL7cDQyyGOSzgHLKlTLOeIw3rl0PiQUrYnNc+C4XvIzGqIcUNI4jo1zNWBwmU3TY2/bpKBjTjSHrqiY7CCU3Ti6ikkAwiD0yVayClhn+cT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PCPLz2ku; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id C059E20B7167; Tue, 12 May 2026 02:42:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C059E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778578929;
	bh=Sx/71IeY0S0zRcEMYNngeq6KBWhOETCNBtFrzTg0f84=;
	h=From:To:Cc:Subject:Date:From;
	b=PCPLz2kuxLtK0Ko9JavB0IoXoBvqFIxGD9ZvVQ1aF7t9FeJsoerbB2byY3lrxy77O
	 g1MBlaXdDuV+3TJ1K0CvtKilj0iyHMbFJ6OQtcoG3Cd9VZ8ciQlpxMgwesn/hBOP6r
	 8f+5eCQoGjVrwPxMFpQSMC1y25bVnANCcVETM1XQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mana_ib: Report max_msg_sz in mana_ib_query_port
Date: Tue, 12 May 2026 02:42:09 -0700
Message-ID: <20260512094209.264955-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23DC751DF47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20475-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Report max_msg_sz for mana_ib, which is 16MB.

Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 9af92a4..4c211ac 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -638,6 +638,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 	if (mana_ib_is_rnic(dev)) {
 		props->gid_tbl_len = 16;
 		props->ip_gids = true;
+		props->max_msg_sz = SZ_16M;
 		if (port == 1)
 			props->port_cap_flags = IB_PORT_CM_SUP;
 	}
-- 
2.43.0


