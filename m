Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC939A1FF
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFCNS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 09:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhFCNS0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 09:18:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D2960C3F;
        Thu,  3 Jun 2021 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622726201;
        bh=Eao1Fk5zhAqEghrBtVz+h4jzFX1GujkoQ8FJycUfGa8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jl539L3zqNn/WpgKoPGTbkLUKnjw5BhKenL0Mvyu4jDmoD+CUhlurf7XXqYuzmXha
         dRzZXyNaEb1CvS/18ylXZiaUyHLMZPU1gZepmYDFa1KDOwMmyp9OzhdA/xYbX3SE+r
         KNoR32C5mK7lyPM2iu3NN4YGTScbXbM6AHvpQkE66ucCdKa+boIY/Twe1LtbvAgHKe
         kgW+SJSifUlEwCGHASIZQMzMFzA8wQ6EnmXmfxAUwAceARrwXIFzKaPu7DblKp3GEK
         h1xEZo/1752BWnPgNf8p6OGkR6SlquBN9CSjcnJxoFdoR092VxGOCCV6BRVJ+Gb+IH
         y0t+slKTgzchg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Sagi Grimberg <sagi@grimberg.me>, target-devel@vger.kernel.org
Subject: [PATCH rdma-next v1] RDMA: Fix kernel-doc warnings about wrong comment
Date:   Thu,  3 Jun 2021 16:16:36 +0300
Message-Id: <8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Compilation with W=1 produces warnings similar to the below.

  drivers/infiniband/ulp/ipoib/ipoib_main.c:320: warning: This comment
	starts with '/**', but isn't a kernel-doc comment. Refer
	Documentation/doc-guide/kernel-doc.rst

All such occurrences were found with the following one line
 git grep -A 1 "\/\*\*" drivers/infiniband/

Reviewed-by: Jack Wang <jinpu.wang@ionos.com> #rtrs
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Changelog:
 v0 https://lore.kernel.org/lkml/635def71048cbffe76e2dd324cf420d8a465ee9d.1622460676.git.leonro@nvidia.com:
 * Rebased to drop i40iw
 * Added Jack's ROB
---
 drivers/infiniband/core/iwpm_util.h       | 2 +-
 drivers/infiniband/core/roce_gid_mgmt.c   | 5 +++--
 drivers/infiniband/hw/hfi1/chip.c         | 4 ++--
 drivers/infiniband/hw/hfi1/file_ops.c     | 6 +++---
 drivers/infiniband/hw/hfi1/hfi.h          | 2 +-
 drivers/infiniband/hw/hfi1/init.c         | 4 ++--
 drivers/infiniband/hw/hfi1/pio.c          | 2 +-
 drivers/infiniband/sw/rdmavt/mr.c         | 4 ++--
 drivers/infiniband/sw/rdmavt/qp.c         | 3 ++-
 drivers/infiniband/sw/rdmavt/vt.c         | 4 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++---
 drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
 drivers/infiniband/ulp/isert/ib_isert.c   | 4 ++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c    | 4 ++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c    | 2 +-
 15 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index eeb8e6010907..61380583d2a6 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -183,7 +183,7 @@ u32 iwpm_check_registration(u8 nl_client, u32 reg);
 void iwpm_set_registration(u8 nl_client, u32 reg);
 
 /**
- * iwpm_get_registration
+ * iwpm_get_registration - Get the client registration
  * @nl_client: The index of the netlink client
  *
  * Returns the client registration type
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 7b638d91a4ec..68197e576433 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -186,12 +186,13 @@ is_eth_port_inactive_slave_filter(struct ib_device *ib_dev, u32 port,
 	return res;
 }
 
-/** is_ndev_for_default_gid_filter - Check if a given netdevice
+/**
+ * is_ndev_for_default_gid_filter - Check if a given netdevice
  * can be considered for default GIDs or not.
  * @ib_dev:		IB device to check
  * @port:		Port to consider for adding default GID
  * @rdma_ndev:		rdma netdevice pointer
- * @cookie_ndev:	Netdevice to consider to form a default GID
+ * @cookie:             Netdevice to consider to form a default GID
  *
  * is_ndev_for_default_gid_filter() returns true if a given netdevice can be
  * considered for deriving default RoCE GID, returns false otherwise.
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 5eeae8df415b..c97544638367 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14186,7 +14186,7 @@ static void init_kdeth_qp(struct hfi1_devdata *dd)
 }
 
 /**
- * hfi1_get_qp_map
+ * hfi1_get_qp_map - get qp map
  * @dd: device data
  * @idx: index to read
  */
@@ -14199,7 +14199,7 @@ u8 hfi1_get_qp_map(struct hfi1_devdata *dd, u8 idx)
 }
 
 /**
- * init_qpmap_table
+ * init_qpmap_table - init qp map
  * @dd: device data
  * @first_ctxt: first context
  * @last_ctxt: first context
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 3b7bbc7b9d10..955c3637980e 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -736,7 +736,7 @@ static u64 kvirt_to_phys(void *addr)
 }
 
 /**
- * complete_subctxt
+ * complete_subctxt - complete sub-context info
  * @fd: valid filedata pointer
  *
  * Sub-context info can only be set up after the base context
@@ -841,7 +841,7 @@ static int assign_ctxt(struct hfi1_filedata *fd, unsigned long arg, u32 len)
 }
 
 /**
- * match_ctxt
+ * match_ctxt - match context
  * @fd: valid filedata pointer
  * @uinfo: user info to compare base context with
  * @uctxt: context to compare uinfo to.
@@ -898,7 +898,7 @@ static int match_ctxt(struct hfi1_filedata *fd,
 }
 
 /**
- * find_sub_ctxt
+ * find_sub_ctxt - fund sub-context
  * @fd: valid filedata pointer
  * @uinfo: matching info to use to find a possible context to share.
  *
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 867ae0b1aa95..9e020bb6f405 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1764,7 +1764,7 @@ static inline void pause_for_credit_return(struct hfi1_devdata *dd)
 }
 
 /**
- * sc_to_vlt() reverse lookup sc to vl
+ * sc_to_vlt() - reverse lookup sc to vl
  * @dd - devdata
  * @sc5 - 5 bit sc
  */
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index e3a8a420c045..0986aa065418 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -312,7 +312,7 @@ struct hfi1_ctxtdata *hfi1_rcd_get_by_index_safe(struct hfi1_devdata *dd,
 }
 
 /**
- * hfi1_rcd_get_by_index
+ * hfi1_rcd_get_by_index - get by index
  * @dd: pointer to a valid devdata structure
  * @ctxt: the index of an possilbe rcd
  *
@@ -499,7 +499,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
 }
 
 /**
- * hfi1_free_ctxt
+ * hfi1_free_ctxt - free context
  * @rcd: pointer to an initialized rcd data structure
  *
  * This wrapper is the free function that matches hfi1_create_ctxtdata().
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index ff864f6f0266..e276522104c6 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -993,7 +993,7 @@ static bool is_sc_halted(struct hfi1_devdata *dd, u32 hw_context)
 }
 
 /**
- * sc_wait_for_packet_egress
+ * sc_wait_for_packet_egress - wait for packet
  * @sc: valid send context
  * @pause: wait for credit return
  *
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 601d18dda1f5..34b7af6ab9c2 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -101,8 +101,8 @@ int rvt_driver_mr_init(struct rvt_dev_info *rdi)
 }
 
 /**
- *rvt_mr_exit: clean up MR
- *@rdi: rvt dev structure
+ * rvt_mr_exit - clean up MR
+ * @rdi: rvt dev structure
  *
  * called when drivers have unregistered or perhaps failed to register with us
  */
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 4522071fc220..1111eee8d05a 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -984,7 +984,8 @@ static void rvt_reset_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp,
 	spin_unlock_irq(&qp->r_lock);
 }
 
-/** rvt_free_qpn - Free a qpn from the bit map
+/**
+ * rvt_free_qpn - Free a qpn from the bit map
  * @qpt: QP table
  * @qpn: queue pair number to free
  */
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 12ebe041a5da..3749380ff193 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -144,7 +144,7 @@ static int rvt_modify_device(struct ib_device *device,
 }
 
 /**
- * rvt_query_port: Passes the query port call to the driver
+ * rvt_query_port - Passes the query port call to the driver
  * @ibdev: Verbs IB dev
  * @port_num: port number, 1 based from ib core
  * @props: structure to hold returned properties
@@ -175,7 +175,7 @@ static int rvt_query_port(struct ib_device *ibdev, u32 port_num,
 }
 
 /**
- * rvt_modify_port
+ * rvt_modify_port - modify port
  * @ibdev: Verbs IB dev
  * @port_num: Port number, 1 based from ib core
  * @port_modify_mask: How to change the port
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index a4f9220161ad..b3dfa973b377 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -316,7 +316,7 @@ static bool ipoib_is_dev_match_addr_rcu(const struct sockaddr *addr,
 	return false;
 }
 
-/**
+/*
  * Find the master net_device on top of the given net_device.
  * @dev: base IPoIB net_device
  *
@@ -361,8 +361,9 @@ static int ipoib_upper_walk(struct net_device *upper,
 }
 
 /**
- * Find a net_device matching the given address, which is an upper device of
- * the given net_device.
+ * ipoib_get_net_dev_match_addr - Find a net_device matching
+ * the given address, which is an upper device of the given net_device.
+ *
  * @addr: IP address to look for.
  * @dev: base IPoIB net_device
  *
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 136f6c4492e0..b44cbb8e84eb 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -761,7 +761,7 @@ void iser_conn_init(struct iser_conn *iser_conn)
 	ib_conn->reg_cqe.done = iser_reg_comp;
 }
 
- /**
+/*
  * starts the process of connecting to the target
  * sleeps until the connection is established or rejected
  */
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 160efef66031..8634c83067da 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2397,10 +2397,10 @@ isert_accept_np(struct iscsi_np *np, struct iscsi_conn *conn)
 		spin_unlock_bh(&np->np_thread_lock);
 		isert_dbg("np_thread_state %d\n",
 			 np->np_thread_state);
-		/**
+		/*
 		 * No point in stalling here when np_thread
 		 * is in state RESET/SHUTDOWN/EXIT - bail
-		 **/
+		 */
 		return -ENODEV;
 	}
 	spin_unlock_bh(&np->np_thread_lock);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f1fd7ae9ac53..948eb51026ed 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -915,7 +915,7 @@ static inline void path_it_deinit(struct path_it *it)
 }
 
 /**
- * rtrs_clt_init_req() Initialize an rtrs_clt_io_req holding information
+ * rtrs_clt_init_req() - Initialize an rtrs_clt_io_req holding information
  * about an inflight IO.
  * The user buffer holding user control message (not data) is copied into
  * the corresponding buffer of rtrs_iu (req->iu->buf), which later on will
@@ -1221,7 +1221,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 }
 
 /**
- * rtrs_clt_failover_req() Try to find an active path for a failed request
+ * rtrs_clt_failover_req() - Try to find an active path for a failed request
  * @clt: clt context
  * @fail_req: a failed io request.
  */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 5639b29b8b02..658bf4e1f732 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1308,7 +1308,7 @@ int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
 EXPORT_SYMBOL(rtrs_srv_get_sess_name);
 
 /**
- * rtrs_srv_get_sess_qdepth() - Get rtrs_srv qdepth.
+ * rtrs_srv_get_queue_depth() - Get rtrs_srv qdepth.
  * @srv:	Session
  */
 int rtrs_srv_get_queue_depth(struct rtrs_srv *srv)
-- 
2.31.1

