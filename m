Return-Path: <linux-rdma+bounces-23041-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VDs/EfCvUWpzHQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23041-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 04:52:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785C7400BF
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 04:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Td/Q7BKy";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23041-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23041-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B623F30342A3
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D72FBDFD;
	Sat, 11 Jul 2026 02:51:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DD2D6E66;
	Sat, 11 Jul 2026 02:51:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738282; cv=none; b=sQ1hNZ48EfElQUcjhStEtyx9IQzfttbHK4I08V5HIejM+Aj6UFuWDJt+V/xVGxC3Y/rJ7kb6F9X6NSOC33co203gA45933oIQ3cCQsGPhh9ZBkFuxJWNDFojmJzXBBkJdwiwk27CpwDVeDVeKSYvdfS8AsGuYHN1AvgtIfvrKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738282; c=relaxed/simple;
	bh=I0WR9mcCZfkWpnKLyYSGeHJOayh5zXyFcAasfbcm140=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyhExOg83SPEcG7ALOSxvR4skBCQdySuNjgE2LH+zUwNatvkoCzzBmsjxQY7T8Evotqgwuv1ulj8l82PHLc+YJmOknd488w5Wzz/RYLDPBCkuWp32tbJSCh/hiKV7xzqH6v/wnei/xMZTIGYIXd/F9F1zwmL6tRlx2oQwIIBtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td/Q7BKy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E031F00A3A;
	Sat, 11 Jul 2026 02:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783738280;
	bh=Esuz7zhCAZGqe+bNR0ZD1+tVMnDFoolklsUSF2CYBOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Td/Q7BKy8vjz2jkk3RVsTVPXZJMpBoIqXg8MchEtjeSbKrabBedGMqr17LDNDnnrW
	 mUhSVDWYPL/V/mi681N7TFWqpCejlRy3eWHDrU/9NaqphO4or5RPSsM1Ss1QcH4gej
	 n2oYuMWzR8kK72a8JOvtl2YlQ1y4Auu9WZnY1PUhrNhQ/dazrVVWHILVOpN7rkPMiU
	 0DuqegoYrpGMu4LVC0nes2qnlpDi9sq4K8SutiOHcGIRW/vDjX/zbO3HZJZfsX69E7
	 8nIgRpvfld1DZoJm15Al50SOV3rWGcXp9nG+/IAEsu1vG6RE7wBgQdL/QGnoF428Up
	 gCgv/+gUbnrdw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org
Cc: achender@kernel.org
Subject: [PATCH net 3/3] net/rds: fix rds_message leak in the rds_send_xmit() drop path
Date: Fri, 10 Jul 2026 19:51:18 -0700
Message-Id: <20260711025118.2449428-4-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260711025118.2449428-1-achender@kernel.org>
References: <20260711025118.2449428-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:achender@kernel.org,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23041-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9785C7400BF

From: Sharath Srinivasan <sharath.srinivasan@oracle.com>

When rds_send_xmit() picks the next message off cp_send_queue it takes
its own reference with rds_message_addref().  If the message then hits
the never-retransmit check (RDS_MSG_FLUSH, or an RDMA op that was
already retransmitted), it is moved to the local to_be_dropped list and
that reference is dropped after the batch.

However, if RDS_MSG_ON_CONN has already been cleared - e.g. a racing
rds_send_drop_to() or rds_send_path_reset() took the message off the
connection lists - the message is not added to to_be_dropped and the
reference taken above is never dropped: cp_xmit_rm has not been set at
this point, so the loop simply abandons rm and the rds_message (and
everything it pins: pages, MRs, notifiers) leaks after an RDMA error.

Drop the reference directly in that case.

This mirrors Oracle UEK commit "net/rds: fix rds_message memleak in
rds_send_xmit".

Fixes: 2ad8099b58f2 ("RDS: rds_send_xmit() locking/irq fixes")
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
[achender: port to net-next; update commit message]
Assisted-by: Claude-Code:claude-fable-5
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/send.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 68be1bf0e0adf..ab3a8366c53bd 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -339,9 +339,17 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			    (rm->rdma.op_active &&
 			    test_bit(RDS_MSG_RETRANSMITTED, &rm->m_flags))) {
 				spin_lock_irqsave(&cp->cp_lock, flags);
-				if (test_and_clear_bit(RDS_MSG_ON_CONN, &rm->m_flags))
+				if (test_and_clear_bit(RDS_MSG_ON_CONN, &rm->m_flags)) {
+					/* our ref is put after the batch */
 					list_move(&rm->m_conn_item, &to_be_dropped);
-				spin_unlock_irqrestore(&cp->cp_lock, flags);
+					spin_unlock_irqrestore(&cp->cp_lock, flags);
+				} else {
+					/* already off the conn list; drop
+					 * the ref taken above ourselves
+					 */
+					spin_unlock_irqrestore(&cp->cp_lock, flags);
+					rds_message_put(rm);
+				}
 				continue;
 			}
 
-- 
2.25.1


