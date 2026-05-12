Return-Path: <linux-rdma+bounces-20522-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH8UDPuAA2pB6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20522-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:35:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D687528AF7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FB93048569
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6736F90C;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2nNsfdt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D536F908;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614456; cv=none; b=EzXAoVywUkCMEgJLBAgS2zW0vSBHVwSz5YHzcvs6gfwQe4bufRpEbWpP6BHUnfLb5TRX6df7UGZFaj+vKfjOe5HoyKUZApjO1hsc8uTGaAAODIaz85yRP+mcNPIQEX8+zQ9OtuKV35TUlaKWBZUOZD4pVWlCwid4rSMvC4QAx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614456; c=relaxed/simple;
	bh=3+nSg75y6p6zOz4d2VibPFbgZawtw1IHZauV+GTSQMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEujDSjmak3DaTTS0jiIwFXNfUuPn/QLr7d6IJdRV+8+mhK0qg9xKKwknfil5/4Vb8Q+3Q5pjAZsjNQ5rcUrQRfkaHLdRlQRHcipi4NMlrzvVP6GHr3b5TX1qQOULAUhZ6eExhLU3Bo9aGUNqjVKVT0ivISY/n5e6Mc38yNke+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2nNsfdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E372C2BCFB;
	Tue, 12 May 2026 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614456;
	bh=3+nSg75y6p6zOz4d2VibPFbgZawtw1IHZauV+GTSQMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2nNsfdt1w3CvNz1BpMUDjxjBFOVjsWWAU8kyZhJJcVsAcDcfoczU7Nbh6beUD+KQ
	 XfrgKR1hWVoay27334fnevzJvrTikFJseySdT3hYk/tBVTKNAiovNiw8mUnHkLex0z
	 PJ7oO24bIEIP9koK2XyejoahssbwqFMRQCZFVS/S1BN2GS0Dn76FX92cPO1k8zwdto
	 Gqmn78Z6aD423Sr40wwmL9pSItt/Hy6cVMAxhIf4BFC2IJOx7UitJj3vcM9bQNWiJp
	 ll0x2sZw2r/Ka8AsIfvN6C81XtIoDr+kmcBmxicGBuxMzmxE6+LQo17mxDbE3YOJuL
	 AQzXELOLG45SQ==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next v2 4/4] devlink: Drop now duplicate pid fallback for netns
Date: Tue, 12 May 2026 13:34:07 -0600
Message-ID: <20260512193412.32019-5-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512193412.32019-1-dsahern@kernel.org>
References: <20260512193412.32019-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D687528AF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20522-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Now that netns_get_fd handles by name and pid, the special
handling in devlink to fallback to PID can be removed with
both cases handled by the FD attribute.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 devlink/devlink.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 730515a78950..908a0e32be2b 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -428,12 +428,6 @@ static void dl_arg_inc(struct dl *dl)
 	dl->argv++;
 }
 
-static void dl_arg_dec(struct dl *dl)
-{
-	dl->argc++;
-	dl->argv--;
-}
-
 static char *dl_argv_next(struct dl *dl)
 {
 	char *ret;
@@ -2153,14 +2147,12 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			err = dl_argv_str(dl, &netns_str);
 			if (err)
 				return err;
-			opts->netns = netns_get_fd(netns_str);
-			if ((int)opts->netns < 0) {
-				dl_arg_dec(dl);
-				err = dl_argv_uint32_t(dl, &opts->netns);
-				if (err)
-					return err;
-				opts->netns_is_pid = true;
-			}
+
+			err = netns_get_fd(netns_str);
+			if (err < 0)
+				return err;
+
+			opts->netns = err;
 			o_found |= DL_OPT_NETNS;
 		} else if (dl_argv_match(dl, "action") &&
 			   (o_all & DL_OPT_RELOAD_ACTION)) {
@@ -2725,10 +2717,7 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_TRAP_ACTION,
 				opts->trap_action);
 	if (opts->present & DL_OPT_NETNS)
-		mnl_attr_put_u32(nlh,
-				 opts->netns_is_pid ? DEVLINK_ATTR_NETNS_PID :
-						      DEVLINK_ATTR_NETNS_FD,
-				 opts->netns);
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_NETNS_FD, opts->netns);
 	if (opts->present & DL_OPT_RELOAD_ACTION)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_RELOAD_ACTION,
 				opts->reload_action);
-- 
2.43.0


