Return-Path: <linux-rdma+bounces-22718-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AaIhNcmpRmoEbQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22718-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:11:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98016FBDF6
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:11:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=YhTkq2iH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22718-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22718-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9549131254D6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EFE31F98B;
	Thu,  2 Jul 2026 17:12:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FD3093DD;
	Thu,  2 Jul 2026 17:12:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012357; cv=none; b=owAoE5bTKOpg5zXw6Ni3dOS7XNQrgiTo6GGLAyLb8QC5k6Voy4cvJyrqU/iVPD6hjqsGF47i2ZFfv2nVXaY0FubcondEIAsaw10pL/Q/z3lfrY4hIxr8TeKiVL7IMeFRBHhzX4aJJjDU1UD6y5C8WxaSwbmXabth0s1EV+YB8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012357; c=relaxed/simple;
	bh=ui7Wvq31+bmhfdGiaQu1nVRQtVBuT+2jB1IXxK1XaZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITOdGhBajQvzsgT/bOcQ7jSpVNcxv9TmKhyYDvaEpZNI8h84oA0ywA77mMtki0vXP9Jtpck2WJ1y2H4mjJxkblcybIApcU7wX11Dt1YOMdCLxQIF7Qhy4BEyvBvfHsj+lj4xrAobylzln0FXKS/yZSOXlqkVW6fsndVM4n97gHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YhTkq2iH; arc=none smtp.client-ip=115.124.30.131
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783012350; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vQZAChbuoVsas+C9SU6lXSqc6Mn3Gbl8B75Pqg5FD4w=;
	b=YhTkq2iHhHmU++xvPZsVB2ZQGz8P4XtjWJZ3mpuGaK6L9pfXRxx/2+lzSdlk7FgN9a1bXR3431akmVBklKT3+tetK4/Xr5psX9GuYLNBa4aHW8qD1P3rTHeUVCXHhS6cg/mzXvQw+EK//40U4hj9y9x08JD1i4DnX9pv600uJBI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X6FdVAf_1783012348;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6FdVAf_1783012348 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 01:12:29 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Hans Wippel <hwippel@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/smc: ignore peer-supplied rmbe_idx and dmbe_idx
Date: Fri,  3 Jul 2026 01:11:38 +0800
Message-ID: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.vnet.ibm.com,m:hwippel@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22718-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,xbow.com:email,alibaba.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B98016FBDF6

Linux always uses exactly one RMBE per RMB (index 1 for SMC-R) and
one DMBE per DMB (index 0 for SMC-D), so conn->tx_off is always zero.
Hardcode these fixed values instead of deriving tx_off from the
peer-supplied rmbe_idx / dmbe_idx in the CLC Accept/Confirm message.

Fixes: e6727f39004b ("smc: send data (through RDMA)")
Fixes: 413498440e30 ("net/smc: add SMC-D support in af_smc")
Cc: stable@vger.kernel.org
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/af_smc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..3706e8ac49e0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -729,11 +729,15 @@ static void smcr_conn_save_peer_info(struct smc_sock *smc,
 {
 	int bufsize = smc_uncompress_bufsize(clc->r0.rmbe_size);
 
-	smc->conn.peer_rmbe_idx = clc->r0.rmbe_idx;
+	/* Linux uses exactly one RMBE per RMB (always index 1); ignore the
+	 * peer-supplied rmbe_idx to prevent a malicious peer from setting an
+	 * out-of-bounds tx_off.
+	 */
+	smc->conn.peer_rmbe_idx = 1;
 	smc->conn.local_tx_ctrl.token = ntohl(clc->r0.rmbe_alert_token);
 	smc->conn.peer_rmbe_size = bufsize;
 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
-	smc->conn.tx_off = bufsize * (smc->conn.peer_rmbe_idx - 1);
+	smc->conn.tx_off = 0;
 }
 
 static void smcd_conn_save_peer_info(struct smc_sock *smc,
@@ -741,12 +745,16 @@ static void smcd_conn_save_peer_info(struct smc_sock *smc,
 {
 	int bufsize = smc_uncompress_bufsize(clc->d0.dmbe_size);
 
-	smc->conn.peer_rmbe_idx = clc->d0.dmbe_idx;
+	/* Linux uses exactly one DMBE per DMB (always index 0); ignore the
+	 * peer-supplied dmbe_idx to prevent a malicious peer from deriving an
+	 * out-of-bounds tx_off that causes an OOB write.
+	 */
+	smc->conn.peer_rmbe_idx = 0;
 	smc->conn.peer_token = ntohll(clc->d0.token);
 	/* msg header takes up space in the buffer */
 	smc->conn.peer_rmbe_size = bufsize - sizeof(struct smcd_cdc_msg);
 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
-	smc->conn.tx_off = bufsize * smc->conn.peer_rmbe_idx;
+	smc->conn.tx_off = 0;
 }
 
 static void smc_conn_save_peer_info(struct smc_sock *smc,
-- 
2.43.7


