Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198031D4FA7
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2020 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEON6R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 May 2020 09:58:17 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:13947 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEON6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 May 2020 09:58:17 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 04FDw38I027628;
        Fri, 15 May 2020 06:58:04 -0700
Date:   Fri, 15 May 2020 19:28:03 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation
 of GSO usage.
Message-ID: <20200515135802.GB15967@chelsio.com>
References: <20200507110651.GA19184@chelsio.com>
 <20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
 <OF8C4B32A9.212C6DC0-ON00258567.0031506F-00258567.003EBFFB@notes.na.collabserv.com>
 <OF5AE22DD2.A8A5C20E-ON00258568.004804AF-00258568.00481A8E@notes.na.collabserv.com>
 <20200515135038.GA15967@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515135038.GA15967@chelsio.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here is the rough prototype of iwpmd approach(only kernel part).
Please take a look.
diff --git a/drivers/infiniband/core/iwcm.c
b/drivers/infiniband/core/iwcm.c
index ade71823370f..ffe8d4dce45e 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -530,6 +530,12 @@ static int iw_cm_map(struct iw_cm_id *cm_id, bool
active)
        pm_msg.rem_addr = cm_id->remote_addr;
        pm_msg.flags = (cm_id->device->iw_driver_flags &
IW_F_NO_PORT_MAP) ?
                       IWPM_FLAGS_NO_PORT_MAP : 0;
+       ret = ib_query_qp(qp, &qp_attr, 0, &qp_init_attr);
+        if (ret)
+                return ret;
+       else
+               pm_msg.loc_fpdu_maxlen = qp_attr.loc_fpdu_maxlen;
+
        if (active)
                status = iwpm_add_and_query_mapping(&pm_msg,
                                                    RDMA_NL_IWCM);
@@ -544,6 +550,14 @@ static int iw_cm_map(struct iw_cm_id *cm_id, bool
active)
                                             &cm_id->remote_addr,
                                             &cm_id->m_remote_addr);
                }
+
+               if (pm_msg.rem_fpdu_maxlen) {
+                       struct ib_qp_attr qp_attr = {0};
+
+                       qp_attr.rem_fpdu_maxlen =
pm_msg.rem_fpdu_maxlen;
+                       ib_modify_qp(qp, &qp_attr, IB_QP_FPDU_MAXLEN);
+               }
+
        }

        return iwpm_create_mapinfo(&cm_id->local_addr,
diff --git a/drivers/infiniband/sw/siw/siw.h
b/drivers/infiniband/sw/siw/siw.h
index dba4535494ab..2c717f274dbf 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -279,6 +279,7 @@ struct siw_qp_attrs {
        enum siw_qp_flags flags;

        struct socket *sk;
+       u16 rem_fpdu_maxlen; /* max len of FPDU that remote node can
accept */
 };

 enum siw_tx_ctx {
@@ -415,7 +416,6 @@ struct siw_iwarp_tx {
        u8 orq_fence : 1; /* ORQ full or Send fenced */
        u8 in_syscall : 1; /* TX out of user context */
        u8 zcopy_tx : 1; /* Use TCP_SENDPAGE if possible */
-       u8 gso_seg_limit; /* Maximum segments for GSO, 0 = unbound */

        u16 fpdu_len; /* len of FPDU to tx */
        unsigned int tcp_seglen; /* remaining tcp seg space */
@@ -505,7 +505,6 @@ struct iwarp_msg_info {

 /* Global siw parameters. Currently set in siw_main.c */
 extern const bool zcopy_tx;
-extern const bool try_gso;
 extern const bool loopback_enabled;
 extern const bool mpa_crc_required;
 extern const bool mpa_crc_strict;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c
b/drivers/infiniband/sw/siw/siw_cm.c
index 8c1931a57f4a..c240c430542d 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -750,10 +750,6 @@ static int siw_proc_mpareply(struct siw_cep *cep)

                return -ECONNRESET;
        }
-       if (try_gso && rep->params.bits & MPA_RR_FLAG_GSO_EXP) {
-               siw_dbg_cep(cep, "peer allows GSO on TX\n");
-               qp->tx_ctx.gso_seg_limit = 0;
-       }
        if ((rep->params.bits & MPA_RR_FLAG_MARKERS) ||
            (mpa_crc_required && !(rep->params.bits & MPA_RR_FLAG_CRC))
||
            (mpa_crc_strict && !mpa_crc_required &&
@@ -1373,6 +1369,7 @@ int siw_connect(struct iw_cm_id *id, struct
iw_cm_conn_param *params)
                rv = -EINVAL;
                goto error;
        }
+
        if (v4)
                siw_dbg_qp(qp,
                           "pd_len %d, laddr %pI4 %d, raddr %pI4 %d\n",
@@ -1469,9 +1466,6 @@ int siw_connect(struct iw_cm_id *id, struct
iw_cm_conn_param *params)
        }
        __mpa_rr_set_revision(&cep->mpa.hdr.params.bits, version);

-       if (try_gso)
-               cep->mpa.hdr.params.bits |= MPA_RR_FLAG_GSO_EXP;
-
        if (mpa_crc_required)
                cep->mpa.hdr.params.bits |= MPA_RR_FLAG_CRC;

@@ -1594,6 +1588,7 @@ int siw_accept(struct iw_cm_id *id, struct
iw_cm_conn_param *params)

                return -EINVAL;
        }
+
        down_write(&qp->state_lock);
        if (qp->attrs.state > SIW_QP_STATE_RTR) {
                rv = -EINVAL;
@@ -1602,10 +1597,6 @@ int siw_accept(struct iw_cm_id *id, struct
iw_cm_conn_param *params)
        }
        siw_dbg_cep(cep, "[QP %d]\n", params->qpn);

-       if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
-               siw_dbg_cep(cep, "peer allows GSO on TX\n");
-               qp->tx_ctx.gso_seg_limit = 0;
-       }
        if (params->ord > sdev->attrs.max_ord ||
            params->ird > sdev->attrs.max_ird) {
                siw_dbg_cep(
diff --git a/drivers/infiniband/sw/siw/siw_main.c
b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..28c256e52454 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -31,12 +31,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 /* transmit from user buffer, if possible */
 const bool zcopy_tx = true;

-/* Restrict usage of GSO, if hardware peer iwarp is unable to process
- * large packets. try_gso = true lets siw try to use local GSO,
- * if peer agrees.  Not using GSO severly limits siw maximum tx
  bandwidth.
- */
-const bool try_gso;
-
 /* Attach siw also with loopback devices */
 const bool loopback_enabled = true;

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 5d97bba0ce6d..2a9fa4efab60 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -661,14 +661,19 @@ static void siw_update_tcpseg(struct siw_iwarp_tx
*c_tx,
                                     struct socket *s)
 {
        struct tcp_sock *tp = tcp_sk(s->sk);
+       struct siw_qp *qp =  container_of(c_tx, struct siw_qp, tx_ctx);

-       if (tp->gso_segs) {
-               if (c_tx->gso_seg_limit == 0)
-                       c_tx->tcp_seglen = tp->mss_cache * tp->gso_segs;
-               else
+       if (tp->gso_segs && qp->attrs.rem_fpdu_maxlen) {
+               if(tp->mss_cache >  qp->attrs.rem_fpdu_maxlen) {
+                       c_tx->tcp_seglen = qp->attrs.rem_fpdu_maxlen;
+               } else {
+                       u8 gso_seg_limit;
+                       gso_seg_limit = qp->attrs.rem_fpdu_maxlen /
+                                               tp->mss_cache;
                        c_tx->tcp_seglen =
                                tp->mss_cache *
-                               min_t(u16, c_tx->gso_seg_limit,
                                tp->gso_segs);
+                               min_t(u16, gso_seg_limit, tp->gso_segs);
+               }
        } else {
                c_tx->tcp_seglen = tp->mss_cache;
        }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
b/drivers/infiniband/sw/siw/siw_verbs.c
index b18a677832e1..c5f40d3454f3 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -444,8 +444,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
        qp->attrs.sq_max_sges = attrs->cap.max_send_sge;
        qp->attrs.rq_max_sges = attrs->cap.max_recv_sge;

-       /* Make those two tunables fixed for now. */
-       qp->tx_ctx.gso_seg_limit = 1;
+       /* Make this tunable fixed for now. */
        qp->tx_ctx.zcopy_tx = zcopy_tx;

        qp->attrs.state = SIW_QP_STATE_IDLE;
@@ -537,6 +536,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct
ib_qp_attr *qp_attr,
        qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
        qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
        qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
+       qp_attr->cap.loc_fpdu_maxlen =  SZ_64K - 1;
        qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
        qp_attr->max_rd_atomic = qp->attrs.irq_size;
        qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
@@ -550,6 +550,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct
ib_qp_attr *qp_attr,
        qp_init_attr->recv_cq = base_qp->recv_cq;
        qp_init_attr->srq = base_qp->srq;

+       qp_init_attr->cap = qp_attr->cap;
        qp_init_attr->cap = qp_attr->cap;

        return 0;
@@ -589,6 +590,8 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
struct ib_qp_attr *attr,

                siw_attr_mask |= SIW_QP_ATTR_STATE;
        }
+       if (attr_mask & IB_QP_FPDU_MAXLEN)
+                qp->attrs.rem_fpdu_maxlen = attr->rem_fpdu_maxlen;
        if (!siw_attr_mask)
                goto out;

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e7e733add99f..5bc3e3b9ea61 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1054,6 +1054,8 @@ struct ib_qp_cap {
         * and MRs based on this.
         */
        u32     max_rdma_ctxs;
+       /* Maximum length of FPDU that the device at local node could
accept */
+       u16     loc_fpdu_maxlen;
 };

 enum ib_sig_type {
@@ -1210,6 +1212,7 @@ enum ib_qp_attr_mask {
        IB_QP_RESERVED3                 = (1<<23),
        IB_QP_RESERVED4                 = (1<<24),
        IB_QP_RATE_LIMIT                = (1<<25),
+       IB_QP_FPDU_MAXLEN               = (1<<26),
 };

 enum ib_qp_state {
@@ -1260,6 +1263,7 @@ struct ib_qp_attr {
        u8                      alt_port_num;
        u8                      alt_timeout;
        u32                     rate_limit;
+       u16                     rem_fpdu_maxlen; /* remote node's max
len cap */
 };

 enum ib_wr_opcode {
diff --git a/include/rdma/iw_portmap.h b/include/rdma/iw_portmap.h
index c89535047c42..af1bc798f709 100644
--- a/include/rdma/iw_portmap.h
+++ b/include/rdma/iw_portmap.h
@@ -61,6 +61,8 @@ struct iwpm_sa_data {
        struct sockaddr_storage mapped_loc_addr;
        struct sockaddr_storage rem_addr;
        struct sockaddr_storage mapped_rem_addr;
+       u16 loc_fpdu_maxlen;
+       u16 rem_fpdu_maxlen;
        u32 flags;
 };

On Friday, May 05/15/20, 2020 at 19:20:40 +0530, Krishnamraju Eraparaju wrote:
> On Thursday, May 05/14/20, 2020 at 13:07:33 +0000, Bernard Metzler wrote:
> > -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> > 
> > >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >Date: 05/14/2020 01:17PM
> > >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> > >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >nirranjan@chelsio.com
> > >Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental
> > >e2e negotiation of GSO usage.
> > >
> > >On Wednesday, May 05/13/20, 2020 at 11:25:23 +0000, Bernard Metzler
> > >wrote:
> > >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> > >> 
> > >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> >Date: 05/13/2020 05:50AM
> > >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> > >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >> >nirranjan@chelsio.com
> > >> >Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental
> > >> >e2e negotiation of GSO usage.
> > >> >
> > >> >On Monday, May 05/11/20, 2020 at 15:28:47 +0000, Bernard Metzler
> > >> >wrote:
> > >> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
> > >-----
> > >> >> 
> > >> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> >> >Date: 05/07/2020 01:07PM
> > >> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> >> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> > >> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> > >> >> >nirranjan@chelsio.com
> > >> >> >Subject: [EXTERNAL] Re: Re: [RFC PATCH] RDMA/siw: Experimental
> > >e2e
> > >> >> >negotiation of GSO usage.
> > >> >> >
> > >> >> >Hi Bernard,
> > >> >> >Thanks for the review comments. Replied in line.
> > >> >> >
> > >> >> >On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard
> > >Metzler
> > >> >> >wrote:
> > >> >> >> 
> > >> >> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
> > >> >-----
> > >> >> >> 
> > >> >> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> > >> >> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> >> >> >Date: 04/28/2020 10:01PM
> > >> >> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> > >> >> >> >mkalderon@marvell.com, aelior@marvell.com,
> > >dledford@redhat.com,
> > >> >> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org,
> > >bharat@chelsio.com,
> > >> >> >> >nirranjan@chelsio.com
> > >> >> >> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental
> > >e2e
> > >> >> >> >negotiation of GSO usage.
> > >> >> >> >
> > >> >> >> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000,
> > >Bernard
> > >> >> >Metzler
> > >> >> >> >wrote:
> > >> >> >> >Hi Bernard,
> > >> >> >> >
> > >> >> >> >The attached patches enables the GSO negotiation code in SIW
> > >> >with
> > >> >> >> >few modifications, and also allows hardware iwarp drivers to
> > >> >> >> >advertise
> > >> >> >> >their max length(in 16/32/64KB granularity) that they can
> > >> >accept.
> > >> >> >> >The logic is almost similar to how TCP SYN MSS announcements
> > >> >works
> > >> >> >> >while
> > >> >> >> >3-way handshake.
> > >> >> >> >
> > >> >> >> >Please see if this approach works better for softiwarp <=>
> > >> >> >hardiwarp
> > >> >> >> >case.
> > >> >> >> >
> > >> >> >> >Thanks,
> > >> >> >> >Krishna. 
> > >> >> >> >
> > >> >> >> Hi Krishna,
> > >> >> >> 
> > >> >> >> Thanks for providing this. I have a few comments:
> > >> >> >> 
> > >> >> >> It would be good if we can look at patches inlined in the
> > >> >> >> email body, as usual.
> > >> >> >Sure, will do that henceforth.
> > >> >> >> 
> > >> >> >> Before further discussing a complex solution as suggested
> > >> >> >> here, I would like to hear comments from other iWarp HW
> > >> >> >> vendors on their capabilities regarding GSO frame acceptance
> > >> >> >> and potential preferences. 
> > >> >> >> 
> > >> >> >> The extension proposed here goes beyond what I initially sent
> > >> >> >> as a proposed patch. From an siw point of view, it is
> > >straight
> > >> >> >> forward to select using GSO or not, depending on the iWarp
> > >peer
> > >> >> >> ability to process large frames. What is proposed here is a
> > >> >> >> end-to-end negotiation of the actual frame size.
> > >> >> >> 
> > >> >> >> A comment in the patch you sent suggests adding a module
> > >> >> >> parameter. Module parameters are deprecated, and I removed
> > >any
> > >> >> >> of those from siw when it went upstream. I don't think we can
> > >> >> >> rely on that mechanism.
> > >> >> >> 
> > >> >> >> siw has a compile time parameter (yes, that was a module
> > >> >> >> parameter) which can set the maximum tx frame size (in
> > >multiples
> > >> >> >> of MTU size). Any static setup of siw <-> Chelsio could make
> > >> >> >> use of that as a work around.
> > >> >> >> 
> > >> >> >> I wonder if it would be a better idea to look into an
> > >extension
> > >> >> >> of the rdma netlink protocol, which would allow setting
> > >driver
> > >> >> >> specific parameters per port, or even per QP.
> > >> >> >> I assume there are more potential use cases for driver
> > >private
> > >> >> >> extensions of the rdma netlink interface?
> > >> >> >
> > >> >> >I think, the only problem with "configuring FPDU length via
> > >rdma
> > >> >> >netlink" is the enduser might not feel comfortable in finding
> > >what
> > >> >> >adapter
> > >> >> >is installed at the remote endpoint and what length it
> > >supports.
> > >> >Any
> > >> >> >thoughts on simplify this?
> > >> >> 
> > >> >> Nope. This would be 'out of band' information.
> > >> >> 
> > >> >> So we seem to have 3 possible solutions to the problem:
> > >> >> 
> > >> >> (1) detect if the peer accepts FPDUs up to current GSO size,
> > >> >> this is what I initially proposed. (2) negotiate a max FPDU
> > >> >> size with the peer, this is what you are proposing, or (3)
> > >> >> explicitly set that max FPDU size per extended user interface.
> > >> >> 
> > >> >> My problem with (2) is the rather significant proprietary
> > >> >> extension of MPA, since spare bits code a max value negotiation.
> > >> >> 
> > >> >> I proposed (1) for its simplicity - just a single bit flag,
> > >> >> which de-/selects GSO size for FPDUs on TX. Since Chelsio
> > >> >> can handle _some_ larger (up to 16k, you said) sizes, (1)
> > >> >> might have to be extended to cap at hard coded max size.
> > >> >> Again, it would be good to know what other vendors limits
> > >> >> are.
> > >> >> 
> > >> >> Does 16k for siw  <-> Chelsio already yield a decent
> > >> >> performance win?
> > >> >yes, 3x performance gain with just 16K GSO, compared to GSO
> > >diabled
> > >> >case. where MTU size is 1500.
> > >> >
> > >> 
> > >> That is a lot. At the other hand, I would suggest to always
> > >> increase MTU size to max (9k) for adapters siw attaches to.
> > >> With a page size of 4k, anything below 4k MTU size hurts,
> > >> while 9k already packs two consecutive pages into one frame,
> > >> if aligned.
> > >> 
> > >> Would 16k still gain a significant performance win if we have
> > >> set max MTU size for the interface?
> Unfortunately no difference in throughput when MTU is 9K, for 16K FPDU.
> Looks like TCP stack constructs GSO/TSO buffer in multiples of HW
> MSS(tp->mss_cache). So, as 16K FPDU buffer is not a multiple of 9K, TCP
> stack slices 16K buffer into 9K & 7K buffers before passing it to NIC
> driver.
> Thus no difference in perfromance as each tx packet to NIC cannot go
> beyond 9K, when FPDU len is 16K.
> > >> 
> > >> >Regarding the rdma netlink approach that you are suggesting,
> > >should
> > >> >it
> > >> >be similar like below(?):
> > >> >
> > >> >rdma link set iwp3s0f4/1 max_fpdu_len 102.1.1.6:16384,
> > >> >102.5.5.6:32768
> > >> >
> > >> >
> > >> >rdma link show iwp3s0f4/1 max_fpdu_len
> > >> >        102.1.1.6:16384
> > >> >        102.5.5.6:32768
> > >> >
> > >> >where "102.1.1.6" is the destination IP address(such that the same
> > >> >max
> > >> >fpdu length is taken for all the connections to this
> > >> >address/adapter).
> > >> >And "16384" is max fdpu length.
> > >> >
> > >> Yes, that would be one way of doing it. Unfortunately we
> > >> would end up with maintaining additional permanent in kernel
> > >> state per peer we ever configured.
> > >> 
> > >> So, would it make sense to combine it with the iwpmd,
> > >> which then may cache peers, while setting max_fpdu per
> > >> new connection? This would probably include extending the
> > >> proprietary port mapper protocol, to exchange local
> > >> preferences with the peer. Local capabilities might
> > >> be queried from the device (extending enum ib_mtu to
> > >> more than 4k, and using ibv_query_port()). And the
> > >> iw_cm_id to be extended to carry that extra parameter
> > >> down to the driver... Sounds complicated.
> > >If I understand you right, client/server advertises their Max FPDU
> > >len
> > >in Res field of PMReq/PMAccept frames.
> > >typedef struct iwpm_wire_msg {
> > >        __u8    magic;
> > >        __u8    pmtime;
> > >        __be16  reserved;
> > >Then after Portmapper negotiation, the fpdu len is propagated to SIW
> > >qp
> > >strucutre from userspace iwpmd.
> > >		
> > >If we weigh up the pros and cons of using PortMapper Res field vs MPA
> > >Res feild, then looks like using MPA is less complicated, considering
> > >the lines of changes and modules invovled in changes. Not sure my
> > >analysis is right here?
> > >
> > One important difference IMHO is that one approach would touch an
> > established IETF communication protocol (MPA), the other a
> > proprietary application (iwpmd).
> Ok, will explore more on iwpmd approach, may be prototyping this would help.
> > 
> > 
> > >Between, looks like the existing SIW GSO code needs a logic to limit
> > >"c_tx->tcp_seglen" to 64K-1, as MPA len is only 16bit. Say, in future
> > >to
> > >best utilize 400G Ethernet, if Linux TCP stack has increased
> > >GSO_MAX_SIZE to 128K, then SIW will cast 18bit value to 16bit MPA
> > >len.
> > >
> > Isn't GSO bound to IP fragmentation?
> Not sure. But I would say it's better we limit "c_tx->tcp_seglen"
> somewhere to 64K-1 to avoid future risks.
> > 
> > Thanks,
> > Bernard
> > 
