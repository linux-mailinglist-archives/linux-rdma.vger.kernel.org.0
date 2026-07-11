Return-Path: <linux-rdma+bounces-23057-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jsAIDZX0UWpZKwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23057-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 09:45:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1B740C9D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 09:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=LkEOMDkm;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23057-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23057-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 296A23010D08
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC022F99B8;
	Sat, 11 Jul 2026 07:45:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7537C0FF;
	Sat, 11 Jul 2026 07:45:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755905; cv=none; b=ipA5eVJAETOrh2+lcZjSnlAEPKS2RdfrRW6AsrryMbL+atYQCniynJ5prnxjQq6UDfGLa6Hpcow+tkLfzffKIAtaTGT94Xm0HfQ+cvu5u5kA2/fuPqakMudyIfnZnyVnflXkuobmVAtSOgurQEOy7S+Veqt0VHRXCze8NBV3XUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755905; c=relaxed/simple;
	bh=SKtlWD3szBtItKAM745R/SjGNiriLui2N0zipFKueYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bw+y7sd3HCWzTCc52ANGMFo4s1w40vM5qfFz9Z+Wwc00kF1crP7ncCK+m7XBelH7jsA2TThVlgklK90TFJ25+AzP+8ZD9PcYRNB7q5tED01wwWqxmCdoIIJIjtN9m9+6KZ7mR4JhgdsTOMAbMSyRpatJ7s5NkYa/0HsBAxYeGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkEOMDkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA79AC2BCC6;
	Sat, 11 Jul 2026 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783755905;
	bh=SKtlWD3szBtItKAM745R/SjGNiriLui2N0zipFKueYE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LkEOMDkmz/Z/HVUq/f8NSgc4aSVB8wlo3LV4hII+8c2m4D6gLu9pE09XbNuxrkBJ4
	 yprQBsGE6dH2yxjANmfL6WbCwrar/gs0wP0Tp7ThG7JgY4KTvhIqk/umxuX9eVfCRr
	 E6azKIt68WtQkAvW6U++mMf/AJoHsSx/e8YX8seKnso3OWnbl09Q5HVpO2EGoZ5KEq
	 0AxjzSS9QUQ2WDN/B6yDLVheC4+8aNhdMpp8czlAsv8jbbNW5z12IdDQFZ/QyfVAkj
	 ltO1odCMa+56owss1vNvHX6RNIzrWR10dgTrzFrSjBBHPYBc2MxmAyYqq3Z6/ABJ4L
	 F87DnPJRvgR2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD5C43458;
	Sat, 11 Jul 2026 07:45:04 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 11 Jul 2026 02:45:05 -0500
Subject: [PATCH net] net/smc: guard the CDC receive path against an unset
 RMB
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-b4-disp-c36a9798-v1-1-340b0c6053fb@proton.me>
X-B4-Tracking: v=1; b=H4sIAID0UWoC/x3MQQqAIBBA0avErBtQK82uEi0yx5qNhUYE0d2Tl
 m/x/wOZElOGoXog0cWZ91gg6wqWbY4rIftiUEJpYaRE16LnfODS6Nka26N0Tee8tsEbBSU7EgW
 +/+UIkU6Y3vcDmVyAM2cAAAA=
To: Paolo Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Eric Dumazet <edumazet@google.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Tony Lu <tonylu@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783755904; l=2576;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=yh7714RV6Cc4s3RDFou/eCDussZT7vcBjhLsr4ZeUcM=;
 b=Vuf9mDuj3w2B5nPA+qf5Tbf1h0yrJMdX2RH27z3Uj+NAYdJbs56Ch06TWSEojM/H7bCWfWEJ5
 bO8b2caGqWECB+3WZ4YOTFo63lNPdGDfV3K1ucad2XC0bayn9Jxj1hb
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:guwen@linux.alibaba.com,m:edumazet@google.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:davem@davemloft.net,m:tonylu@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:mjambigi@linux.ibm.com,m:wenjia@linux.ibm.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23057-lists,linux-rdma=lfdr.de,hexlabsecurity.proton.me];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,proton.me:replyto,proton.me:mid,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24C1B740C9D

From: Bryam Vargas <hexlabsecurity@proton.me>

The SMC CDC receive handlers look up a connection by its wire token and
then dereference conn->rmb_desc -- smcd_cdc_rx_tsklet() reads
rmb_desc->cpu_addr and smc_cdc_msg_recv_action() reads rmb_desc->len --
but a connection is published to the link group's token tree in
smc_conn_create(), before smc_buf_create() allocates its RMB.  A peer
that sends a CDC message carrying the connection's token in that setup
window reaches the handlers with conn->rmb_desc still NULL and crashes
the host with a NULL pointer dereference.

Bail out of both receive handlers when the RMB is not yet allocated, as
they already do for a killed or out-of-sync connection.

Closes: https://sashiko.dev/#/patchset/20260705-b4-disp-28a1bbca-v4-1-be089b98acc6@proton.me?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reachability is by source inspection: smc_conn_create() registers the
connection before smc_buf_create() allocates conn->rmb_desc, and the
receive handlers guard only !conn/out_of_sync/killed.  Verified with an
in-kernel KASAN model reproducing the deref with rmb_desc == NULL (fault
at the ->len / ->cpu_addr offsets) and clean with the guard.  af_smc runs
over an RDMA fabric or an ISM device, so this is the model rather than a
live trigger; reproducer available on request.

No Fixes: tag: the CDC receive path predates the history available here;
the introducing commits are the original CDC support and its SMC-D
addition -- please add whichever tag you prefer.
---
 net/smc/smc_cdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..d60f68facbc3 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -446,7 +446,7 @@ static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
 	struct smcd_cdc_msg cdc;
 	struct smc_sock *smc;
 
-	if (!conn || conn->killed)
+	if (!conn || conn->killed || !conn->rmb_desc)
 		return;
 
 	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
@@ -483,7 +483,7 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 	lgr = smc_get_lgr(link);
 	read_lock_bh(&lgr->conns_lock);
 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
-	if (!conn || conn->out_of_sync) {
+	if (!conn || conn->out_of_sync || !conn->rmb_desc) {
 		read_unlock_bh(&lgr->conns_lock);
 		return;
 	}

---
base-commit: dd3210c47e8d3ac6b4e9141fc68acc03b38c0ba3
change-id: 20260711-b4-disp-c36a9798-1b35bd69fd72

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



