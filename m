Return-Path: <linux-rdma+bounces-5971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41699C8036
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 02:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1983428393A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 01:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117B1E571A;
	Thu, 14 Nov 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qsFP7mvC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399B1E5709;
	Thu, 14 Nov 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549097; cv=none; b=XutYyDuFSjbaAl+aJ8Tvthpj3xFOOH4IAK5niaFnkQ0/Ho83JaT/mKzPMF6HNb+bwNfk8Azjr7sBknmar6RFIneO+TiiY3lz5sg9a+ZQRo+2ewEYcFBP2+fk4s99bndcsaH1IFlfwIVMBGE8DdiGB0Zd4t73BPjgyF0qAdU/JAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549097; c=relaxed/simple;
	bh=SaoD3bSuQJMmQdxDcGnpv4U9w8yi788aRG5G1QToGxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qyqd8YszcEDtz4rYsLDhHQVV46S5gwU/Y1Eg9BtN1Ojl/5iIFmbFk9d7EsuOof9HT5ED0aaonTq79t6bASprRo64DcDfd1fA2GmVcvYkOCg452WfbWwlVfLXLSJpfOKYkWniGiryDRVsM1ZeFo5zxr3x4ZNH4jeRXoKQipFAtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qsFP7mvC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731549086; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jJKEsgJ/rCjxYBe8kyzM5O+Na50BhXNEcBYzDCwZ1cg=;
	b=qsFP7mvC3p7ykBl1m/LVnlGpxwtS1PUzbCN2s/8BUe2eo0Fi0KFsONs4K4WQYbtJeFnf6tjGN/ddZ5VrXiBIGgKNamiy0arxAL8abKhz496N2StHQjOurLa+lPddB04X1ZZaazHztV1iujcjtWpsrNGta0JEdkVBAc79Gn9RoWE=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WJMVgi8_1731549085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 09:51:26 +0800
Date: Thu, 14 Nov 2024 09:51:25 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next 3/3] net/smc: Isolate the smc_xxx_lgr_pending
 with ib_device
Message-ID: <20241114015125.GF89669@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241113071405.67421-1-alibuda@linux.alibaba.com>
 <20241113071405.67421-4-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113071405.67421-4-alibuda@linux.alibaba.com>

On 2024-11-13 15:14:05, D. Wythe wrote:
>It is widely known that SMC introduced a global lock to protect the
>creation of the first connection. This lock not only brings performance
>issues but also poses a serious security risk. In a multi-tenant
>container environment, malicious tenants can construct attacks that keep
>the lock occupied for an extended period, thereby affecting the
>connections of other tenants.
>
>Considering that this lock is essentially meant to protect the QP, which
>belongs to a device, we can limit the scope of the lock to within the
>device rather than having it be global. This way, when a container
>exclusively occupies the device, it can avoid being affected by other
>malicious tenants.
>
>Also make on impact on SMC-D since the path of SMC-D is shorter.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> net/smc/af_smc.c | 18 ++++++++++--------
> net/smc/smc_ib.c |  2 ++
> net/smc/smc_ib.h |  2 ++
> 3 files changed, 14 insertions(+), 8 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 19480d8affb0..d5b9ea7661db 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -56,11 +56,8 @@
> #include "smc_loopback.h"
> #include "smc_inet.h"
> 
>-static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
>-						 * creation on server
>-						 */
>-static DEFINE_MUTEX(smc_client_lgr_pending);	/* serialize link group
>-						 * creation on client
>+static DEFINE_MUTEX(smcd_server_lgr_pending);	/* serialize link group
>+						 * creation on server for SMC-D
> 						 */

Why not move the smcd_server_lgr_pending lock to the smcd_device level
as well ?


> 
> static struct workqueue_struct	*smc_tcp_ls_wq;	/* wq for tcp listen work */
>@@ -1251,7 +1248,9 @@ static int smc_connect_rdma(struct smc_sock *smc,
> 	if (reason_code)
> 		return reason_code;
> 
>-	smc_lgr_pending_lock(ini, &smc_client_lgr_pending);
>+	smc_lgr_pending_lock(ini, (ini->smcr_version & SMC_V2) ?
>+				&ini->smcrv2.ib_dev_v2->smc_server_lgr_pending :
>+				&ini->ib_dev->smc_server_lgr_pending);
> 	reason_code = smc_conn_create(smc, ini);
> 	if (reason_code) {
> 		smc_lgr_pending_unlock(ini);
>@@ -1412,7 +1411,7 @@ static int smc_connect_ism(struct smc_sock *smc,
> 	ini->ism_peer_gid[ini->ism_selected].gid = ntohll(aclc->d0.gid);
> 
> 	/* there is only one lgr role for SMC-D; use server lock */
>-	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
>+	smc_lgr_pending_lock(ini, &smcd_server_lgr_pending);
> 	rc = smc_conn_create(smc, ini);
> 	if (rc) {
> 		smc_lgr_pending_unlock(ini);
>@@ -2044,6 +2043,9 @@ static int smc_listen_rdma_init(struct smc_sock *new_smc,
> {
> 	int rc;
> 
>+	smc_lgr_pending_lock(ini, (ini->smcr_version & SMC_V2) ?
>+			     &ini->smcrv2.ib_dev_v2->smc_server_lgr_pending :
>+			     &ini->ib_dev->smc_server_lgr_pending);
> 	/* allocate connection / link group */
> 	rc = smc_conn_create(new_smc, ini);
> 	if (rc)
>@@ -2064,6 +2066,7 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
> {
> 	int rc;
> 
>+	smc_lgr_pending_lock(ini, &smcd_server_lgr_pending);
> 	rc = smc_conn_create(new_smc, ini);
> 	if (rc)
> 		return rc;
>@@ -2478,7 +2481,6 @@ static void smc_listen_work(struct work_struct *work)
> 	if (rc)
> 		goto out_decl;
> 
>-	smc_lgr_pending_lock(ini, &smc_server_lgr_pending);
> 	smc_close_init(new_smc);
> 	smc_rx_init(new_smc);
> 	smc_tx_init(new_smc);
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 9c563cdbea90..fb8b81b628b8 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -952,6 +952,8 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
> 	init_waitqueue_head(&smcibdev->lnks_deleted);
> 	mutex_init(&smcibdev->mutex);
> 	mutex_lock(&smc_ib_devices.mutex);
>+	mutex_init(&smcibdev->smc_server_lgr_pending);
>+	mutex_init(&smcibdev->smc_client_lgr_pending);
> 	list_add_tail(&smcibdev->list, &smc_ib_devices.list);
> 	mutex_unlock(&smc_ib_devices.mutex);
> 	ib_set_client_data(ibdev, &smc_ib_client, smcibdev);
>diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
>index ef8ac2b7546d..322547a5a23d 100644
>--- a/net/smc/smc_ib.h
>+++ b/net/smc/smc_ib.h
>@@ -57,6 +57,8 @@ struct smc_ib_device {				/* ib-device infos for smc */
> 	atomic_t		lnk_cnt_by_port[SMC_MAX_PORTS];
> 						/* number of links per port */
> 	int			ndev_ifidx[SMC_MAX_PORTS]; /* ndev if indexes */
>+	struct mutex    smc_server_lgr_pending; /* serialize link group creation on server */
>+	struct mutex    smc_client_lgr_pending; /* serialize link group creation on client */

Align please.

Best regards,
Dust


