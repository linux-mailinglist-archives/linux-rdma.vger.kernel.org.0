Return-Path: <linux-rdma+bounces-7000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D6A102AA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F1B3A338F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE3284A6D;
	Tue, 14 Jan 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ1+yvo4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B21D5AB2;
	Tue, 14 Jan 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845517; cv=none; b=udeZZa+SC7PZ/VhsdaXTFvCKk7bIQSN/RItnFa3JR4b7OqkRHZRCxUTIRtsKVj1fXSYEE3cykdSMrhrEihuCom7X/cnNQae2gvYeG2FQSwncjYwoVOkKBjf0wTrhRUuWawUSHIZ5h2JUx0o3J7XW37myor1sF6alMDddDhqCRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845517; c=relaxed/simple;
	bh=F8NQ5S2qctuP6WfgHg3ftRT8zixg+7C/eUO+d4uebRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFahEUfLW2u1Olu0OCX+loTw6+US+wkSZdwxI52VbWeSPPOO5+5V917CAUM0IgOB4UGNdErbJTvolNLIqsFZz0EdNrUO7QMdTO442y0SWh5oC+6qe1EG71dK+hnICOe4kcorwvUYudKra/rCu0l4mpcYZdXATMlPrGtNZ8WL9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ1+yvo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799C5C4CEDD;
	Tue, 14 Jan 2025 09:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736845516;
	bh=F8NQ5S2qctuP6WfgHg3ftRT8zixg+7C/eUO+d4uebRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ1+yvo4GoKIreXyCc59GlSWvezx6l6bPVHrWKm9xcxpGJtRxB4ixIWbiTGof0zDR
	 zHMVNKT6hppbUqKJFUnMisDBW8qEJY3SlYFA7E9Iw29NTYeFpjvaY3MZbNPEKQYlfK
	 VuB0ZODOdrdip5ZUHdBo5mVWjYJG9w+hOEuFhABnDYffCv0b27QGpARnTpGBbTWaGa
	 TKXbVwXnWHCqi14iZFUJY4at9RrSWJ9vDc+KlMoyQmUIfvC4eDAtsdvLoy1S7TX7qY
	 CDo0gjLKg0TVfixJ0sq1a8UlTZXTvmQNGLez51grpl6iPPG4OZZ/Q2PAPkwJ/ltG/w
	 wyMpC89LRVhzQ==
Date: Tue, 14 Jan 2025 11:05:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH rdma-next v2 RESEND 0/4] RDMA/bnxt_re: Support for FW
 async event handling
Message-ID: <20250114090510.GF3146852@unreal>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>

On Tue, Jan 07, 2025 at 08:15:48AM +0530, Kalesh AP wrote:
> This patch series adds support for FW async event handling
> in the bnxt_re driver.
> 
> V1->V2:
> 1. Rebased on top of the latest "for-next" tree.
> 2. Split Patch#1 into 2 - one for Ethernet driver changes and
>    another one for RDMA driver changes.
> 3. Addressed Leon's comments on Patch#1 and Patch #3.
> V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com/T/#t
> 
> Patch #1:
> 1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_events().
>    The ulp_ops are protected by RCU. This means that during bnxt_unregister_dev(),
>    Ethernet driver set the ulp_ops pointer to NULL and do RCU sync before return
>    to the RDMA driver.
>    So ulp_ops and the pointers in ulp_ops are always valid or NULL when the
>    Ethernet driver references ulp_ops. ULP_STOPPED is a state and should be
>    unrelated to async events. It should not affect whether async events should
>    or should not be passed to the RDMA driver.
> 2. Changed Author of Ethernet driver changes to Michael Chan.
> 3. Removed unnecessary export of function bnxt_ulp_async_events.
> 
> Patch #3:
> 1. Removed unnecessary flush_workqueue() before destroy_workqueue()
> 2. Removed unnecessary NULL assignment after free.
> 3. Changed to use "ibdev_xxx" and reduce level of couple of logs to debug.
> 
> Please review and apply.
> 
> Regards,
> Kalesh
> 
> 
> Kalesh AP (3):
>   RDMA/bnxt_re: Add Async event handling support
>   RDMA/bnxt_re: Query firmware defaults of CC params during probe
>   RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event
> 
> Michael Chan (1):
>   bnxt_en: Add ULP call to notify async events
> 
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
>  drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   2 +
>  8 files changed, 307 insertions(+)

Applied with the following fix

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1dc305689d7bb..54dee0f5dd3f5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1802,30 +1802,22 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 
 static void bnxt_re_net_unregister_async_event(struct bnxt_re_dev *rdev)
 {
-	int rc;
-
 	if (rdev->is_virtfn)
 		return;
 
 	memset(&rdev->event_bitmap, 0, sizeof(rdev->event_bitmap));
-	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
-					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
-	if (rc)
-		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+	bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+				   ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
 }
 
 static void bnxt_re_net_register_async_event(struct bnxt_re_dev *rdev)
 {
-	int rc;
-
 	if (rdev->is_virtfn)
 		return;
 
 	rdev->event_bitmap |= (1 << ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
-	rc = bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
-					ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
-	if (rc)
-		ibdev_err(&rdev->ibdev, "Failed to unregister async event");
+	bnxt_register_async_events(rdev->en_dev, &rdev->event_bitmap,
+				   ASYNC_EVENT_CMPL_EVENT_ID_DCB_CONFIG_CHANGE);
 }
 
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 59c280634bc5f..3e17db0a453e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -373,9 +373,8 @@ void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
 	rcu_read_unlock();
 }
 
-int bnxt_register_async_events(struct bnxt_en_dev *edev,
-			       unsigned long *events_bmap,
-			       u16 max_id)
+void bnxt_register_async_events(struct bnxt_en_dev *edev,
+				unsigned long *events_bmap, u16 max_id)
 {
 	struct net_device *dev = edev->net;
 	struct bnxt *bp = netdev_priv(dev);
@@ -387,7 +386,6 @@ int bnxt_register_async_events(struct bnxt_en_dev *edev,
 	smp_wmb();
 	ulp->max_async_event_id = max_id;
 	bnxt_hwrm_func_drv_rgtr(bp, events_bmap, max_id + 1, true);
-	return 0;
 }
 EXPORT_SYMBOL(bnxt_register_async_events);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index a21294cf197b8..ee6a5b8562c3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -126,6 +126,6 @@ int bnxt_register_dev(struct bnxt_en_dev *edev, struct bnxt_ulp_ops *ulp_ops,
 		      void *handle);
 void bnxt_unregister_dev(struct bnxt_en_dev *edev);
 int bnxt_send_msg(struct bnxt_en_dev *edev, struct bnxt_fw_msg *fw_msg);
-int bnxt_register_async_events(struct bnxt_en_dev *edev,
-			       unsigned long *events_bmap, u16 max_id);
+void bnxt_register_async_events(struct bnxt_en_dev *edev,
+				unsigned long *events_bmap, u16 max_id);
 #endif

> 
> -- 
> 2.43.5
> 

