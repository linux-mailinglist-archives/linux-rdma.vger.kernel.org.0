Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6842027F0
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 04:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgFUCQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Jun 2020 22:16:41 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:28151 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgFUCQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 Jun 2020 22:16:41 -0400
Date:   Sun, 21 Jun 2020 02:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1592705260;
        bh=4YBxVKlhyHZQxJB3VAj8Gb2s9ehdz4PQjYY97CtsIpE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=HWdmiMGZOKuhvX2vHWJxhjL/58spR3Fhv+nN5glv+RON4QCJGr00p15SGbQ1avDx5
         u9C4TQSLwSGWpEPUhKF11FISRpWzrc12b466rjFgqlGp/56WO79A1CCNErOTriNqSl
         7aEdTrJp3WDGXvCJFlPY4HwBGpsCbFks7lRnPzPc=
To:     linux-rdma@vger.kernel.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     dledford@redhat.com
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: Fwd: [PATCH] infiniband: correct trivial kernel-doc inconsistencies
Message-ID: <5373936.DvuYhMxLoT@laptop.coltonlewis.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Can someone please accept or comment on this patch?

----------  Forwarded Message  ----------

Subject: [PATCH] infiniband: correct trivial kernel-doc inconsistencies
Date: Thursday, June 11, 2020, 1:45:06 AM CDT
From: Colton Lewis <colton.w.lewis@protonmail.com>
To: dledford@redhat.com
CC: trivial@kernel.org, Colton Lewis <colton.w.lewis@protonmail.com>



Silence documentation build warnings by correcting kernel-doc comments.

./drivers/infiniband/core/verbs.c:1004: warning: Function parameter or memb=
er 'uobject' not described in 'ib_create_srq_user'
./drivers/infiniband/core/verbs.c:1004: warning: Function parameter or memb=
er 'udata' not described in 'ib_create_srq_user'
./drivers/infiniband/core/umem_odp.c:161: warning: Function parameter or me=
mber 'ops' not described in 'ib_umem_odp_alloc_child'
./drivers/infiniband/core/umem_odp.c:225: warning: Function parameter or me=
mber 'ops' not described in 'ib_umem_odp_get'
./drivers/infiniband/sw/rdmavt/ah.c:104: warning: Excess function parameter=
 'ah_attr' description in 'rvt_create_ah'
./drivers/infiniband/sw/rdmavt/ah.c:104: warning: Excess function parameter=
 'create_flags' description in 'rvt_create_ah'
./drivers/infiniband/ulp/iser/iscsi_iser.h:363: warning: Function parameter=
 or member 'all_list' not described in 'iser_fr_desc'
./drivers/infiniband/ulp/iser/iscsi_iser.h:377: warning: Function parameter=
 or member 'all_list' not described in 'iser_fr_pool'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function p=
arameter or member 'rsvd0' not described in 'opa_vesw_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function p=
arameter or member 'rsvd1' not described in 'opa_vesw_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function p=
arameter or member 'rsvd2' not described in 'opa_vesw_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function p=
arameter or member 'rsvd3' not described in 'opa_vesw_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function p=
arameter or member 'rsvd4' not described in 'opa_vesw_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function p=
arameter or member 'rsvd0' not described in 'opa_per_veswport_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function p=
arameter or member 'rsvd1' not described in 'opa_per_veswport_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function p=
arameter or member 'rsvd2' not described in 'opa_per_veswport_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function p=
arameter or member 'rsvd3' not described in 'opa_per_veswport_info'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function p=
arameter or member 'reserved' not described in 'opa_veswport_summary_counte=
rs'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd0' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd1' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd2' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd3' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd4' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd5' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd6' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd7' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd8' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function p=
arameter or member 'rsvd9' not described in 'opa_veswport_error_counters'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:460: warning: Function p=
arameter or member 'reserved' not described in 'opa_vnic_vema_mad'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:485: warning: Function p=
arameter or member 'reserved' not described in 'opa_vnic_notice_attr'
./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:500: warning: Function p=
arameter or member 'reserved' not described in 'opa_vnic_vema_mad_trap'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 drivers/infiniband/core/umem_odp.c            |  2 ++
 drivers/infiniband/core/verbs.c               |  4 ++--
 drivers/infiniband/sw/rdmavt/ah.c             |  3 +--
 drivers/infiniband/ulp/iser/iscsi_iser.h      |  2 ++
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.h  | 23 +++++++++++++++++++
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/u=
mem_odp.c
index ccd28405451c..5e32f61a2fe4 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -152,6 +152,7 @@ EXPORT_SYMBOL(ib_umem_odp_alloc_implicit);
  *        ib_alloc_implicit_odp_umem()
  * @addr: The starting userspace VA
  * @size: The length of the userspace VA
+ * @ops: MMU interval ops, currently only @invalidate
  */
 struct ib_umem_odp *
 ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
@@ -213,6 +214,7 @@ EXPORT_SYMBOL(ib_umem_odp_alloc_child);
  * @addr: userspace virtual address to start at
  * @size: length of region to pin
  * @access: IB_ACCESS_xxx flags for memory being pinned
+ * @ops: MMU interval ops, currently only @invalidate
  *
  * The driver should use when the access flags indicate ODP memory. It avo=
ids
  * pinning, instead, stores the mm for future page fault handling in
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verb=
s.c
index 53d6505c0c7b..a3761d432a79 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -988,8 +988,8 @@ EXPORT_SYMBOL(rdma_destroy_ah_user);
  * @srq_init_attr: A list of initial attributes required to create the
  *   SRQ.  If SRQ creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created SRQ.
- * @uobject - uobject pointer if this is not a kernel SRQ
- * @udata - udata pointer if this is not a kernel SRQ
+ * @uobject: uobject pointer if this is not a kernel SRQ
+ * @udata: udata pointer if this is not a kernel SRQ
  *
  * srq_attr->max_wr and srq_attr->max_sge are read the determine the
  * requested size of the SRQ, and set to the actual values allocated
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdma=
vt/ah.c
index 40480add7dd3..75a04b1497c4 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -90,8 +90,7 @@ EXPORT_SYMBOL(rvt_check_ah);
 /**
  * rvt_create_ah - create an address handle
  * @ibah: the IB address handle
- * @ah_attr: the attributes of the AH
- * @create_flags: create address handle flags (see enum rdma_create_ah_fla=
gs)
+ * @init_attr: the attributes of the AH
  * @udata: pointer to user's input output buffer information.
  *
  * This may be called from interrupt context.
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/=
ulp/iser/iscsi_iser.h
index 1d77c7f42e38..0fd8c243ec67 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -353,6 +353,7 @@ struct iser_reg_resources {
  * @list:           entry in connection fastreg pool
  * @rsc:            data buffer registration resources
  * @sig_protected:  is region protected indicator
+ * @all_list:       first and last list members
  */
 struct iser_fr_desc {
 =09struct list_head=09=09  list;
@@ -367,6 +368,7 @@ struct iser_fr_desc {
  * @list:                list of fastreg descriptors
  * @lock:                protects fastreg pool
  * @size:                size of the pool
+ * @all_list:            first and last list members
  */
 struct iser_fr_pool {
 =09struct list_head        list;
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/inf=
iniband/ulp/opa_vnic/opa_vnic_encap.h
index d324312a373c..f64519872297 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -118,12 +118,17 @@
  * struct opa_vesw_info - OPA vnic switch information
  * @fabric_id: 10-bit fabric id
  * @vesw_id: 12-bit virtual ethernet switch id
+ * @rsvd0: reserved bytes
  * @def_port_mask: bitmask of default ports
+ * @rsvd1: reserved bytes
  * @pkey: partition key
+ * @rsvd2: reserved bytes
  * @u_mcast_dlid: unknown multicast dlid
  * @u_ucast_dlid: array of unknown unicast dlids
+ * @rsvd3: reserved bytes
  * @rc: routing control
  * @eth_mtu: Ethernet MTU
+ * @rsvd4: reserved bytes
  */
 struct opa_vesw_info {
 =09__be16  fabric_id;
@@ -150,12 +155,14 @@ struct opa_vesw_info {
  * struct opa_per_veswport_info - OPA vnic per port information
  * @port_num: port number
  * @eth_link_status: current ethernet link state
+ * @rsvd0: reserved bytes
  * @base_mac_addr: base mac address
  * @config_state: configured port state
  * @oper_state: operational port state
  * @max_mac_tbl_ent: max number of mac table entries
  * @max_smac_ent: max smac entries in mac table
  * @mac_tbl_digest: mac table digest
+ * @rsvd1: reserved bytes
  * @encap_slid: base slid for the port
  * @pcp_to_sc_uc: sc by pcp index for unicast ethernet packets
  * @pcp_to_vl_uc: vl by pcp index for unicast ethernet packets
@@ -165,8 +172,10 @@ struct opa_vesw_info {
  * @non_vlan_vl_uc: vl for non-vlan unicast ethernet packets
  * @non_vlan_sc_mc: sc for non-vlan multicast ethernet packets
  * @non_vlan_vl_mc: vl for non-vlan multicast ethernet packets
+ * @rsvd2: reserved bytes
  * @uc_macs_gen_count: generation count for unicast macs list
  * @mc_macs_gen_count: generation count for multicast macs list
+ * @rsvd3: reserved bytes
  */
 struct opa_per_veswport_info {
 =09__be32  port_num;
@@ -294,6 +303,7 @@ struct opa_veswport_mactable {
  * @rx_512_1023: received packet length is >=3D512 and < 1023 bytes
  * @rx_1024_1518: received packet length is >=3D1024 and < 1518 bytes
  * @rx_1519_max: received packet length >=3D 1519 bytes
+ * @reserved: reserved bytes
  *
  * All the above are counters of corresponding conditions.
  */
@@ -347,16 +357,26 @@ struct opa_veswport_summary_counters {
  * @veswport_num: virtual ethernet switch port number
  * @tx_errors: transmit errors
  * @rx_errors: receive errors
+ * @rsvd0: reserved bytes
  * @tx_smac_filt: smac filter errors
+ * @rsvd1: reserved bytes
+ * @rsvd2: reserved bytes
+ * @rsvd3: reserved bytes
  * @tx_dlid_zero: transmit packets with invalid dlid
+ * @rsvd4: reserved bytes
  * @tx_logic: other transmit errors
+ * @rsvd5: reserved bytes
  * @tx_drop_state: packet tansmission in non-forward port state
  * @rx_bad_veswid: received packet with invalid vesw id
+ * @rsvd6: reserved bytes
  * @rx_runt: received ethernet packet with length < 64 bytes
  * @rx_oversize: received ethernet packet with length > MTU size
+ * @rsvd7: reserved bytes
  * @rx_eth_down: received packets when interface is down
  * @rx_drop_state: received packets in non-forwarding port state
  * @rx_logic: other receive errors
+ * @rsvd8: reserved bytes
+ * @rsvd9: reserved bytes
  *
  * All the above are counters of corresponding error conditions.
  */
@@ -447,6 +467,7 @@ struct opa_veswport_iface_macs {
  * struct opa_vnic_vema_mad - Generic VEMA MAD
  * @mad_hdr: Generic MAD header
  * @rmpp_hdr: RMPP header for vendor specific MADs
+ * @reserved: reserved bytes
  * @oui: Unique org identifier
  * @data: MAD data
  */
@@ -467,6 +488,7 @@ struct opa_vnic_vema_mad {
  * @trap_num: Trap number
  * @toggle_count: Notice toggle bit and count value
  * @issuer_lid: Trap issuer's lid
+ * @reserved: reserved bytes
  * @issuer_gid: Issuer GID (only if Report method)
  * @raw_data: Trap message body
  */
@@ -487,6 +509,7 @@ struct opa_vnic_notice_attr {
  * struct opa_vnic_vema_mad_trap - Generic VEMA MAD Trap
  * @mad_hdr: Generic MAD header
  * @rmpp_hdr: RMPP header for vendor specific MADs
+ * @reserved: reserved bytes
  * @oui: Unique org identifier
  * @notice: Notice structure
  */
--=20
2.26.2


-----------------------------------------



