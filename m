Return-Path: <linux-rdma+bounces-1067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F227C85B38F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC56B21A78
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFDA5C912;
	Tue, 20 Feb 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mDCUOo62"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD935C60A;
	Tue, 20 Feb 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412532; cv=none; b=G00w3sP0LDph/SyRgCkSI0OOoqc64B5+quq1YHwDSwJRWV1h4/ASc70pIKGHzvDIvRzLc/XujZLuNc7GSOl4AsK9oByx4LGWQunKB/r702RfbrhQDT75gfHXBmjt0svk+IYUoS1t1yuf4eRrSnVCxMsryp96ymOHiqDr0y2pSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412532; c=relaxed/simple;
	bh=SiTAsqKh8EAlVt3tvGR5Lh2Elhcnf0KiBNWqK87aAHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R40bY3R3eou1tkwqOyJMEyV7cXsILJYNKxNivSqIjU/O6g86T3MN4jfbtkmpEUQ54MG1wEN0g4B8kU3DxJgI1oKiF9l83+o5xr0qODsT3cOQdC8jUUhKHXWk0pIC7kEQleZ6SvKkbXK5YXDaxaCM7sMyUi5huEDZ2ZM4U3MyViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mDCUOo62; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412522; h=From:To:Subject:Date:Message-Id;
	bh=cOgniKP2yjByNBrFGRtX5j3RCkIgyNcnzJjy9IfWBWI=;
	b=mDCUOo62S3/AJ6AGzFW5y7ffXHFXm1701eZRHpsho3vg6x1J0U6+Tl5ju5m/bbk7e/mmXr1JeRob/0zXugXUUdNSfty90QsLV+E3fMMq2w1DTBOx1eV0eUxtKoLowAYGtq0EFLoGLJL3oYrBfRceZk4PicH8kIz+k/exqfgYAd8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXhV_1708412521;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXhV_1708412521)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:02:01 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 18/20] net/smc: add define and macro for smc_negotiation
Date: Tue, 20 Feb 2024 15:01:43 +0800
Message-Id: <1708412505-34470-19-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

smc_negotiation is a new way to describe the state of the SMC
protocol, note that it will only be used by inet sock. It mainly
describes the following states of SMC sock:

TBD:        Before TCP handshake is completed.
PREPARE:    TCP is established, and smc is establishing.
SMC:        smc handshake is established.
NO_SMC:     sock should act as TCP.

Before this patch, it is determined that these conditions must be
applied simultaneously to syn_smc/use_fallback/sk_state,
synchronization of fields needs to be handled with care,
while syn_smc field cannot be modified at any time. Based on these
considerations, inet sock uses smc_negotiation to control the
protocol state.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc.h      |  1 +
 net/smc/smc_inet.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1675193..538920f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -252,6 +252,7 @@ struct smc_sock {				/* smc sock container */
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	unsigned char		smc_state;	/* smc state used in smc via inet_sk */
+	unsigned int		isck_smc_negotiation;
 	unsigned long		smc_sk_flags;	/* smc sock flags used for inet sock */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
index 68ecfa0..1f182c0 100644
--- a/net/smc/smc_inet.h
+++ b/net/smc/smc_inet.h
@@ -18,6 +18,9 @@
 /* MUST after net/tcp.h or warning */
 #include <net/transp_v6.h>
 
+#include <net/smc.h>
+#include "smc.h"
+
 extern struct proto smc_inet_prot;
 extern struct proto smc_inet6_prot;
 
@@ -27,6 +30,99 @@
 extern struct inet_protosw smc_inet_protosw;
 extern struct inet_protosw smc_inet6_protosw;
 
+enum smc_inet_sock_negotiation_state {
+	/* When creating an AF_SMC sock, the state field will be initialized to 0 by default,
+	 * which is only for logical compatibility with that situation
+	 * and will never be used.
+	 */
+	SMC_NEGOTIATION_COMPATIBLE_WITH_AF_SMC = 0,
+
+	/* This connection is still uncertain whether it is an SMC connection or not,
+	 * It always appears when actively open SMC connection, because it's unclear
+	 * whether the server supports the SMC protocol and has willing to use SMC.
+	 */
+	SMC_NEGOTIATION_TBD = 0x10,
+
+	/* This state indicates that this connection is definitely not an SMC connection.
+	 * and it is absolutely impossible to become an SMC connection again. A fina
+	 * state.
+	 */
+	SMC_NEGOTIATION_NO_SMC = 0x20,
+
+	/* This state indicates that this connection is an SMC connection. and it is
+	 * absolutely impossible to become an not-SMC connection again. A final state.
+	 */
+	SMC_NEGOTIATION_SMC = 0x40,
+
+	/* This state indicates that this connection is in the process of SMC handshake.
+	 * It is mainly used to eliminate the ambiguity of syn_smc, because when syn_smc is 1,
+	 * It may represent remote has support for SMC, or it may just indicate that itself has
+	 * supports for SMC.
+	 */
+	SMC_NEGOTIATION_PREPARE_SMC = 0x80,
+
+	/* flags */
+	SMC_NEGOTIATION_LISTEN_FLAG = 0x01,
+	SMC_NEGOTIATION_ABORT_FLAG = 0x02,
+};
+
+static __always_inline void isck_smc_negotiation_store(struct smc_sock *smc,
+						       enum smc_inet_sock_negotiation_state state)
+{
+	WRITE_ONCE(smc->isck_smc_negotiation,
+		   state | (READ_ONCE(smc->isck_smc_negotiation) & 0x0f));
+}
+
+static __always_inline int isck_smc_negotiation_load(struct smc_sock *smc)
+{
+	return READ_ONCE(smc->isck_smc_negotiation) & 0xf0;
+}
+
+static __always_inline void isck_smc_negotiation_set_flags(struct smc_sock *smc, int flags)
+{
+	smc->isck_smc_negotiation = (smc->isck_smc_negotiation | (flags & 0x0f));
+}
+
+static __always_inline int isck_smc_negotiation_get_flags(struct smc_sock *smc)
+{
+	return smc->isck_smc_negotiation & 0x0f;
+}
+
+static __always_inline bool smc_inet_sock_check_fallback_fast(struct sock *sk)
+{
+	return !tcp_sk(sk)->syn_smc;
+}
+
+static __always_inline bool smc_inet_sock_check_fallback(struct sock *sk)
+{
+	return isck_smc_negotiation_load(smc_sk(sk)) == SMC_NEGOTIATION_NO_SMC;
+}
+
+static __always_inline bool smc_inet_sock_check_smc(struct sock *sk)
+{
+	if (smc_inet_sock_check_fallback_fast(sk))
+		return false;
+
+	return isck_smc_negotiation_load(smc_sk(sk)) == SMC_NEGOTIATION_SMC;
+}
+
+static __always_inline bool smc_inet_sock_is_active_open(struct sock *sk)
+{
+	return !(isck_smc_negotiation_get_flags(smc_sk(sk)) & SMC_NEGOTIATION_LISTEN_FLAG);
+}
+
+static inline void smc_inet_sock_abort(struct sock *sk)
+{
+	write_lock_bh(&sk->sk_callback_lock);
+	if (isck_smc_negotiation_get_flags(smc_sk(sk)) & SMC_NEGOTIATION_ABORT_FLAG) {
+		write_unlock_bh(&sk->sk_callback_lock);
+		return;
+	}
+	isck_smc_negotiation_set_flags(smc_sk(sk), SMC_NEGOTIATION_ABORT_FLAG);
+	write_unlock_bh(&sk->sk_callback_lock);
+	sk->sk_error_report(sk);
+}
+
 /* obtain TCP proto via sock family */
 static __always_inline struct proto *smc_inet_get_tcp_prot(int family)
 {
-- 
1.8.3.1


