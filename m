Return-Path: <linux-rdma+bounces-6175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E239DFE66
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1688280C97
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2391FCCE7;
	Mon,  2 Dec 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIbb3Fc+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D21FBEA9;
	Mon,  2 Dec 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134254; cv=none; b=NXjLc9lyrUKc2KdNn4mcOekO01sW7rG8B0mQIUTfpU5RQ0C9aQfdyWYA9K5fD7uURuZI9bzZfNYVdPXmO4OrUE0CQj0TpSpgi6vhdvcVLnFeFYdVVj+DsNKdab484/cR1xMyEPuBh9CCp2V6RrkpkJeZ74/PbypJQk3py4bdwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134254; c=relaxed/simple;
	bh=K12IWzr7ZzpJLWTT+sNll1SfEYElORyx9EZ8o7u51ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rz75FECQirx/H8Uacb9IhnJEC/SuXwyh9go2DsB3n9FEPHUB5ntmM4UFrLt61XiXaJQ0Rcx+6bgeZ3U55I2UTQBZuzlW+VJ9lrEwyFSQ6JQBTv4M6FRIdcO9e7l4jM44YPPuEkfKyRdvYhZYPKiFh7P5zpmqnxhRv+tR6OjObuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIbb3Fc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C29FEC4CED1;
	Mon,  2 Dec 2024 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733134253;
	bh=K12IWzr7ZzpJLWTT+sNll1SfEYElORyx9EZ8o7u51ME=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KIbb3Fc+KDroWCb3fIq+KTn/HPAhZWNr4o8JQU9cjzJkUPjgdcgYZEe6p0tAurvCj
	 1eiA6UXh365jffZoNhSk3C2uVdua2ptrmrLMGe4bVhkdYIYb8LtWuvgvpm2DiBzGke
	 XxR/DMJW32YPCcYzGhnmE1fMztImytGqh5wLaFIPfZX0bstMSdvC50PLyi9UMmi00M
	 QgRzeO24alFNZo6bSqqnjpj99Y86cQXxItasX0ejTYrYb1We4AvmQAP03VwXao3O8a
	 edwKtN8Fv4S0eWk1hw5+afahCGMe9Rf4MGiXeM+bofJK+Oq5KN5QMxdfbNrmYjPQ+j
	 flQek4PPwhbDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF5D73612;
	Mon,  2 Dec 2024 10:10:53 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 02 Dec 2024 15:40:51 +0530
Subject: [PATCH net-next RESEND v2] net/smc: Remove unused function
 parameter in __smc_diag_dump
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAKqHTWcC/4WNMQ+CMBSE/wrpbElbQK2Tg6wOOhpDCn3AGyikr
 QRD+O9WJl00t7zLu/tuJg4sgiOHaCYWRnTYm2DEJiJVq0wDFHXwRDCRcs4krXGifT84WhSuqwq
 Nqin0oxso26oyAakTWack1AcLIbuib8SApwYm/35c8mt+PpF7OFt0vrfPdX3ka/L/0MhpUJVlK
 oEsVTo9IqLXsapiNCt2FB8owX6gREDJHUtKvueSA/tGLcvyAlRntyYhAQAA
X-Change-ID: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134252; l=1964;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=zCxOxxK4jUmuWneAk7mzPYC43+hjuOr5TSFC2vSGlrc=;
 b=UJ2tqCJTl+Rjxgg3UW7xGs/kWb0PbQKYRae+HCAb15pkoLFCldFgsbURksOSEj2qN4V8BQfaf
 x1Gk5jADLFOCg3tFAZ9B8zgBAYRtO83dl52EQLzyYyK9kv9RtMJ2kB+
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
There is only one instance of this function being called and its passed
with a NULL value in place of bc.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- Added target tree and prefix
- Carried forward Reviewed-by: tag from v1
- Link to v1: https://lore.kernel.org/r/20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in
---
 net/smc/smc_diag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
-			   const struct smc_diag_req *req,
-			   struct nlattr *bc)
+			   const struct smc_diag_req *req)
 {
 	struct smc_sock *smc = smc_sk(sk);
 	struct smc_diag_fallback fallback;
@@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
 	int snum = cb_ctx->pos[p_type];
-	struct nlattr *bc = NULL;
 	struct hlist_head *head;
 	int rc = 0, num = 0;
 	struct sock *sk;
@@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			continue;
 		if (num < snum)
 			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
 		if (rc < 0)
 			goto out;
 next:

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



