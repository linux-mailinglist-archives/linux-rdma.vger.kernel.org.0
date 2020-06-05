Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD71EF0CD
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2020 07:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEFH1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jun 2020 01:07:27 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:29594 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jun 2020 01:07:27 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 055571v9011282;
        Thu, 4 Jun 2020 22:07:02 -0700
Date:   Fri, 5 Jun 2020 10:37:01 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: iSERT completions hung due to unavailable iscsit tag
Message-ID: <20200605050655.GA23608@chelsio.com>
References: <20200601134637.GA17657@chelsio.com>
 <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d316fdb7-4676-0bb9-c208-b06e43d46534@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi,

I assume you are using SIW on both target and initiator.

And I belive you have a workaround something like below, because
existing iSER target won't work with SIW as both ISCSI_TCP and
ISCSI_INFINIBAND transports tries to listen on same IP:PPORT.

diff --git a/drivers/target/iscsi/iscsi_target.c
b/drivers/target/iscsi/iscsi_target.c
index 59379d6..d3347ab 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -739,14 +739,12 @@ static int __init iscsi_target_init_module(void)
 		goto ooo_out;
 	}
 
-	iscsit_register_transport(&iscsi_target_transport);
 
 	if (iscsit_load_discovery_tpg() < 0)
 		goto r2t_out;
 
 	return ret;
 r2t_out:
-	iscsit_unregister_transport(&iscsi_target_transport);
 	kmem_cache_destroy(lio_r2t_cache);
 ooo_out:
 	kmem_cache_destroy(lio_ooo_cache);
@@ -769,7 +767,6 @@ static int __init iscsi_target_init_module(void)
 static void __exit iscsi_target_cleanup_module(void)
 {
 	iscsit_release_discovery_tpg();
-	iscsit_unregister_transport(&iscsi_target_transport);
 	kmem_cache_destroy(lio_qr_cache);
 	kmem_cache_destroy(lio_dr_cache);
 	kmem_cache_destroy(lio_ooo_cache);
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c
b/drivers/target/iscsi/iscsi_target_configfs.c
index 0fa1d57..32b3c64 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -234,7 +234,7 @@ static struct se_tpg_np *lio_target_call_addnptotpg(
 	 *
 	 */
 	tpg_np = iscsit_tpg_add_network_portal(tpg, &sockaddr, NULL,
-				ISCSI_TCP);
+				ISCSI_INFINIBAND);
 	if (IS_ERR(tpg_np)) {
 		iscsit_put_tpg(tpg);
 		return ERR_CAST(tpg_np);


someone may ask iwpmd should detect that ISCSI_TCP is already using that
same port and should map to other available port from tcp portspace, but
this hold true only for hard iWARP case, for SIW case, iwpmd does not
perfrom any mapping as SIW runs on top of TCP kernel sockets.


Please share if you are using some other workaround to handle this issue.


Thanks,
Krishna.
