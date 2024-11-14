Return-Path: <linux-rdma+bounces-5970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516259C8018
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174382836E1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BD1E5027;
	Thu, 14 Nov 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I0SqJsqx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F51E3DD8;
	Thu, 14 Nov 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548416; cv=none; b=fXPDssCkQoC5e1+1gms2JSKvzsADkUA2oCF1Hmn6mIlJxZEdzXa23lEN5Lk2BTh+VVpQYOBEzipQlFU6M+dIsyeN08KA2cSoSef7y1+xgBzb4nrtFhBStjUAHqigZCM9nR3BV+7cKRrpQkAMxqUqxEJyoirlIF4TbiRfzfnuA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548416; c=relaxed/simple;
	bh=cU45uoLxwMlXc6cOPxZY6RiC71jcMhO9rfhrmJp8YWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhADH4vRFWlbMRbWrCzPj8O3YiB56ngw+1VxsQQq6RDh7niY/Z4WS6f/1kA5t5kM/AqZE/s7mI12OTT8gHZVyjNuY+ZvO7pUEz9cY9H8P94kAICQQyNrpPzXmPuEDL8bzjkKsP714N78qdPljWTYVrTKfEC7kLORYnlv61NzbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I0SqJsqx; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731548405; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ltl5k40jpmW1C9WKnmciGeeLcfTplcqonRFnFzBJ50s=;
	b=I0SqJsqxfvohs37YaOwHgPMoRG2po8YlO2G1B7EQ2YDwkwor3Ah0b1PZB9hVk38sLx+1An6uNrkuUDwjn2A+sRhsn9jRz1dIlHdPtZaTKyBRzAe8w8p274PMZunFWy8kMqrKaFnnoTJKJiCaPcAB3RKOXslK1BWhsLbTWdAwhfs=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WJMObH1_1731548404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 09:40:05 +0800
Date: Thu, 14 Nov 2024 09:40:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 1/3] net/smc: refactoring lgr pending lock
Message-ID: <20241114014004.GE89669@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241113071405.67421-1-alibuda@linux.alibaba.com>
 <20241113071405.67421-2-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113071405.67421-2-alibuda@linux.alibaba.com>

On 2024-11-13 15:14:03, D. Wythe wrote:
>This patch replaces the locking and unlocking of lgr pending with
>a unified inline function, and since the granularity of lgr pending
>lock is within the lifecycle of init_info, which make it possible
>to record the lock state on init_info, which provides a potential
>functionality for multiple unlocks without triggering exceptions, which

Since we already have lockdep, I am skeptical about the usefulness of
this feature.

>creates conditions to reduce the scope of locks in the future.

>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> net/smc/af_smc.c   | 24 ++++++++++++------------
> net/smc/smc_core.h | 29 +++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+), 12 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 9d76e902fd77..19480d8affb0 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -1251,10 +1251,10 @@ static int smc_connect_rdma(struct smc_sock *smc,
> 	if (reason_code)
> 		return reason_code;
> 
>-	mutex_lock(&smc_client_lgr_pending);
>+	smc_lgr_pending_lock(ini, &smc_client_lgr_pending);
> 	reason_code = smc_conn_create(smc, ini);
> 	if (reason_code) {
>-		mutex_unlock(&smc_client_lgr_pending);
>+		smc_lgr_pending_unlock(ini);
> 		return reason_code;
> 	}
> 
>@@ -1343,7 +1343,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
> 		if (reason_code)
> 			goto connect_abort;
> 	}
>-	mutex_unlock(&smc_client_lgr_pending);
>+	smc_lgr_pending_unlock(ini);
> 
> 	smc_copy_sock_settings_to_clc(smc);
> 	smc->connect_nonblock = 0;
>@@ -1353,7 +1353,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
> 	return 0;
> connect_abort:
> 	smc_conn_abort(smc, ini->first_contact_local);
>-	mutex_unlock(&smc_client_lgr_pending);
>+	smc_lgr_pending_unlock(ini);
> 	smc->connect_nonblock = 0;
> 
> 	return reason_code;
>@@ -1412,10 +1412,10 @@ static int smc_connect_ism(struct smc_sock *smc,
> 	ini->ism_peer_gid[ini->ism_selected].gid = ntohll(aclc->d0.gid);
> 
> 	/* there is only one lgr role for SMC-D; use server lock */
>-	mutex_lock(&smc_server_lgr_pending);
>+	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
> 	rc = smc_conn_create(smc, ini);
> 	if (rc) {
>-		mutex_unlock(&smc_server_lgr_pending);
>+		smc_lgr_pending_unlock(ini);
> 		return rc;
> 	}
> 
>@@ -1446,7 +1446,7 @@ static int smc_connect_ism(struct smc_sock *smc,
> 				  aclc->hdr.version, eid, ini);
> 	if (rc)
> 		goto connect_abort;
>-	mutex_unlock(&smc_server_lgr_pending);
>+	smc_lgr_pending_unlock(ini);
> 
> 	smc_copy_sock_settings_to_clc(smc);
> 	smc->connect_nonblock = 0;
>@@ -1456,7 +1456,7 @@ static int smc_connect_ism(struct smc_sock *smc,
> 	return 0;
> connect_abort:
> 	smc_conn_abort(smc, ini->first_contact_local);
>-	mutex_unlock(&smc_server_lgr_pending);
>+	smc_lgr_pending_unlock(ini);
> 	smc->connect_nonblock = 0;
> 
> 	return rc;
>@@ -2478,7 +2478,7 @@ static void smc_listen_work(struct work_struct *work)
> 	if (rc)
> 		goto out_decl;
> 
>-	mutex_lock(&smc_server_lgr_pending);
>+	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
> 	smc_close_init(new_smc);
> 	smc_rx_init(new_smc);
> 	smc_tx_init(new_smc);
>@@ -2497,7 +2497,7 @@ static void smc_listen_work(struct work_struct *work)
> 
> 	/* SMC-D does not need this lock any more */
> 	if (ini->is_smcd)
>-		mutex_unlock(&smc_server_lgr_pending);
>+		smc_lgr_pending_unlock(ini);
> 
> 	/* receive SMC Confirm CLC message */
> 	memset(buf, 0, sizeof(*buf));
>@@ -2528,7 +2528,7 @@ static void smc_listen_work(struct work_struct *work)
> 					    ini->first_contact_local, ini);
> 		if (rc)
> 			goto out_unlock;
>-		mutex_unlock(&smc_server_lgr_pending);
>+		smc_lgr_pending_unlock(ini);
> 	}
> 	smc_conn_save_peer_info(new_smc, cclc);
> 
>@@ -2544,7 +2544,7 @@ static void smc_listen_work(struct work_struct *work)
> 	goto out_free;
> 
> out_unlock:
>-	mutex_unlock(&smc_server_lgr_pending);
>+	smc_lgr_pending_unlock(ini);
> out_decl:
> 	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
> 			   proposal_version);
>diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>index 69b54ecd6503..5abe9438772c 100644
>--- a/net/smc/smc_core.h
>+++ b/net/smc/smc_core.h
>@@ -432,6 +432,8 @@ struct smc_init_info {
> 	u8			ism_offered_cnt; /* # of ISM devices offered */
> 	u8			ism_selected;    /* index of selected ISM dev*/
> 	u8			smcd_version;
>+	/* mutex holding for conn create */
>+	struct mutex *mutex;
> };
> 
> /* Find the connection associated with the given alert token in the link group.
>@@ -600,6 +602,33 @@ int smcr_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
> int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb);
> int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
> 
>+static inline void smc_lgr_pending_lock(struct smc_init_info *ini, struct mutex *lock)
>+{
>+	if (unlikely(ini->mutex))
>+		pr_warn_once("smc: lgr pending deadlock dected.");
>+
>+	mutex_lock(lock);
>+	ini->mutex = lock;
>+}
>+
>+/* It will save the locking status of the ini, which provides a potential functionality
>+ * for multiple unlocks without triggering exceptions. This creates conditions
>+ * to reduce the scope of locks in the future.
>+ */
>+static inline void smc_lgr_pending_unlock(struct smc_init_info *ini)
>+{
>+	/* tempory */
>+	struct mutex *lock;
>+
>+	/* already unlock it, just return */
>+	if (!ini->mutex)
>+		return;
>+
>+	lock = ini->mutex;
>+	ini->mutex = NULL;
>+	mutex_unlock(lock);
>+}
>+
> static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
> {
> 	return link->lgr;
>-- 
>2.45.0
>

