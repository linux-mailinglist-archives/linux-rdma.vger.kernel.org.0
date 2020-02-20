Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75E916650D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 18:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTRiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 12:38:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39998 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgBTRh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 12:37:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so3452611qto.7
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2020 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XzH0rPeW6bv9CCnzjAkFO7oGgVhkvie6vm5dlJdz7v4=;
        b=FOVMIiTQ0ZcDhbuUc8BT27A+FXnWyR0v0AuX+NxoEu/d/Rc90Io1TAX5q6KkVg0HdU
         nc6Jk02vxe9CyAPpwBSdfPoAP/uj3NdyOYXf+I4qxsOBcgoh0jzG4skbGGRkzGLS1+o4
         MSgVmmakkoxjiHied0g7K4A0pfF7qamIkzw6P3gK34Av9qP5tkv4+1cEWQPqPJlVjRaT
         N06vrGjAPi+GpwFETKkPmhtM9ldMdtjdskg4mLfWhE4Tw1hLRXw4cHzKx/WiYMz4lMZp
         0CGA48gYCSEk4oxR9sO9qi6CCBNNV+//V+iESXI9kY8W/7yhSm8HMrhFYi7TExEIbbXa
         Ebsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XzH0rPeW6bv9CCnzjAkFO7oGgVhkvie6vm5dlJdz7v4=;
        b=ovQUXkoVbG4KYXETzYh8646KLlLePTKswVU1C0YJyZVKL31iXx1PQQ05U0sGYNGFHw
         hcB/cnlPLHp/3LQxS9yxYDZuLTl1ZNmGjnR2gEFCC4wJ7Jw9vgOQfeaARAYHRCYTiMtP
         IqALbenPCS0gWNQeob7I+zvgo5ELk0SFRxTBcxHJE+U3PaFup+//cFbhRYMWgJFjZ6gY
         1WmvemMcSgOrOkcxpg60jvXx5CIMbkErKeFJaw0xuIcg0izJzB63jw4tKTUPZTQXQg0s
         X56L3YC3JxJvlgETRbm76VRuVk9rPD6oO3kQNa+aMcv6XfkF0ZAk48SzAva/kw+Q4eiy
         pQeQ==
X-Gm-Message-State: APjAAAVfTloKi1tNI2V9CMO701uXfNPEhSXg1RvIH8YLslJF0E51NpU+
        yCf4juQhb5pcEsI1yRYmAMccug==
X-Google-Smtp-Source: APXvYqzJcChAAVcMvWxoXqrP6gBnVZgis4KBsMhJ7IMRIwWToAOdPw0oLFuVctWE6y+4LHaHIHcG/A==
X-Received: by 2002:ac8:2bf9:: with SMTP id n54mr27342437qtn.280.1582220277650;
        Thu, 20 Feb 2020 09:37:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g62sm137633qkd.25.2020.02.20.09.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:37:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4pls-00057K-M3; Thu, 20 Feb 2020 13:37:56 -0400
Date:   Thu, 20 Feb 2020 13:37:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] IB/core, cache: Replace zero-length array with
 flexible-array member
Message-ID: <20200220173756.GA19347@ziepe.ca>
References: <20200213010425.GA13068@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213010425.GA13068@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 07:04:25PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I squished the four drivers/infiniband patches together and added a
few more, see below. Applied to for-next

It would be fanatstic to follow this up with some analysis to find
cases where sizeof() is performed on a struct with a [] flex array -
these days people should be using struct_size() (interested DanC?)

Thanks,
Jason

diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 956b3a7dfed7ed..403d8673a2f9ea 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -79,13 +79,13 @@ struct ib_mad_private {
 	struct ib_mad_private_header header;
 	size_t mad_size;
 	struct ib_grh grh;
-	u8 mad[0];
+	u8 mad[];
 } __packed;
 
 struct ib_rmpp_segment {
 	struct list_head list;
 	u32 num;
-	u8 data[0];
+	u8 data[];
 };
 
 struct ib_mad_agent_private {
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 7d06b0f8d49a00..e8e11bd95e4296 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -707,7 +707,7 @@ struct mpa_message {
 	u8 flags;
 	u8 revision;
 	__be16 private_data_size;
-	u8 private_data[0];
+	u8 private_data[];
 };
 
 struct mpa_v2_conn_params {
@@ -719,7 +719,7 @@ struct terminate_message {
 	u8 layer_etype;
 	u8 ecode;
 	__be16 hdrct_rsvd;
-	u8 len_hdrs[0];
+	u8 len_hdrs[];
 };
 
 #define TERM_MAX_LENGTH (sizeof(struct terminate_message) + 2 + 18 + 28)
diff --git a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
index cbdb300a47943a..a2f5e29ef2264d 100644
--- a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
+++ b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
@@ -123,7 +123,7 @@ struct fw_ri_dsgl {
 	__be32	len0;
 	__be64	addr0;
 #ifndef C99_NOT_SUPPORTED
-	struct fw_ri_dsge_pair sge[0];
+	struct fw_ri_dsge_pair sge[];
 #endif
 };
 
@@ -139,7 +139,7 @@ struct fw_ri_isgl {
 	__be16	nsge;
 	__be32	r2;
 #ifndef C99_NOT_SUPPORTED
-	struct fw_ri_sge sge[0];
+	struct fw_ri_sge sge[];
 #endif
 };
 
@@ -149,7 +149,7 @@ struct fw_ri_immd {
 	__be16	r2;
 	__be32	immdlen;
 #ifndef C99_NOT_SUPPORTED
-	__u8	data[0];
+	__u8	data[];
 #endif
 };
 
@@ -321,7 +321,7 @@ struct fw_ri_res_wr {
 	__be32 len16_pkd;
 	__u64  cookie;
 #ifndef C99_NOT_SUPPORTED
-	struct fw_ri_res res[0];
+	struct fw_ri_res res[];
 #endif
 };
 
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index a51bcd2b439128..7073f237a94938 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -2381,7 +2381,7 @@ struct opa_port_status_rsp {
 		__be64 port_vl_rcv_bubble;
 		__be64 port_vl_mark_fecn;
 		__be64 port_vl_xmit_discards;
-	} vls[0]; /* real array size defined by # bits set in vl_select_mask */
+	} vls[]; /* real array size defined by # bits set in vl_select_mask */
 };
 
 enum counter_selects {
@@ -2423,7 +2423,7 @@ struct opa_aggregate {
 	__be16 attr_id;
 	__be16 err_reqlength;	/* 1 bit, 8 res, 7 bit */
 	__be32 attr_mod;
-	u8 data[0];
+	u8 data[];
 };
 
 #define MSK_LLI 0x000000f0
diff --git a/drivers/infiniband/hw/hfi1/mad.h b/drivers/infiniband/hw/hfi1/mad.h
index 2f48e69536290c..889e63d3f2ccd0 100644
--- a/drivers/infiniband/hw/hfi1/mad.h
+++ b/drivers/infiniband/hw/hfi1/mad.h
@@ -165,7 +165,7 @@ struct opa_mad_notice_attr {
 		} __packed ntc_2048;
 
 	};
-	u8	class_data[0];
+	u8	class_data[];
 };
 
 #define IB_VLARB_LOWPRI_0_31    1
diff --git a/drivers/infiniband/hw/hfi1/pio.h b/drivers/infiniband/hw/hfi1/pio.h
index c9a58b642bdd6f..0102262343c0f6 100644
--- a/drivers/infiniband/hw/hfi1/pio.h
+++ b/drivers/infiniband/hw/hfi1/pio.h
@@ -243,7 +243,7 @@ struct sc_config_sizes {
  */
 struct pio_map_elem {
 	u32 mask;
-	struct send_context *ksc[0];
+	struct send_context *ksc[];
 };
 
 /*
@@ -263,7 +263,7 @@ struct pio_vl_map {
 	u32 mask;
 	u8 actual_vls;
 	u8 vls;
-	struct pio_map_elem *map[0];
+	struct pio_map_elem *map[];
 };
 
 int pio_map_init(struct hfi1_devdata *dd, u8 port, u8 num_vls,
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index a51525647ac86b..c93ea021cf4939 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -833,7 +833,7 @@ struct sdma_engine *sdma_select_engine_sc(
 struct sdma_rht_map_elem {
 	u32 mask;
 	u8 ctr;
-	struct sdma_engine *sde[0];
+	struct sdma_engine *sde[];
 };
 
 struct sdma_rht_node {
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 1e2e40f79cb205..7a851191f9870f 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -1002,7 +1002,7 @@ void sdma_engine_interrupt(struct sdma_engine *sde, u64 status);
  */
 struct sdma_map_elem {
 	u32 mask;
-	struct sdma_engine *sde[0];
+	struct sdma_engine *sde[];
 };
 
 /**
@@ -1024,7 +1024,7 @@ struct sdma_vl_map {
 	u32 mask;
 	u8 actual_vls;
 	u8 vls;
-	struct sdma_map_elem *map[0];
+	struct sdma_map_elem *map[];
 };
 
 int sdma_map_init(
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 6257eee083a1a3..332abb446861a9 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -73,7 +73,7 @@ struct tid_rb_node {
 	dma_addr_t dma_addr;
 	bool freed;
 	unsigned int npages;
-	struct page *pages[0];
+	struct page *pages[];
 };
 
 static inline int num_user_pages(unsigned long addr,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.h b/drivers/infiniband/hw/i40iw/i40iw_cm.h
index 66dc1ba0338900..6e43e4d730f4c4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.h
@@ -85,7 +85,7 @@ struct ietf_mpa_v1 {
 	u8 flags;
 	u8 rev;
 	__be16 priv_data_len;
-	u8 priv_data[0];
+	u8 priv_data[];
 };
 
 #define ietf_mpa_req_resp_frame ietf_mpa_frame
@@ -101,7 +101,7 @@ struct ietf_mpa_v2 {
 	u8 rev;
 	__be16 priv_data_len;
 	struct ietf_rtr_msg rtr_msg;
-	u8 priv_data[0];
+	u8 priv_data[];
 };
 
 struct i40iw_cm_node;
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.h b/drivers/infiniband/hw/mthca/mthca_memfree.h
index da9b8f9b884f3a..f9a2e65e2ff59a 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.h
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.h
@@ -68,7 +68,7 @@ struct mthca_icm_table {
 	int               lowmem;
 	int               coherent;
 	struct mutex      mutex;
-	struct mthca_icm *icm[0];
+	struct mthca_icm *icm[];
 };
 
 struct mthca_icm_iter {
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 70be49b1ca0528..7ec8991ace673e 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -77,7 +77,7 @@ struct usnic_uiom_reg {
 struct usnic_uiom_chunk {
 	struct list_head		list;
 	int				nents;
-	struct scatterlist		page_list[0];
+	struct scatterlist		page_list[];
 };
 
 struct usnic_uiom_pd *usnic_uiom_alloc_pd(void);
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index acd0a925481c95..8ef17d61702214 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -63,7 +63,7 @@ struct rxe_queue_buf {
 	__u32			pad_2[31];
 	__u32			consumer_index;
 	__u32			pad_3[31];
-	__u8			data[0];
+	__u8			data[];
 };
 
 struct rxe_queue {
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
index 4480092c68e097..0b3570dc606d24 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -258,7 +258,7 @@ struct opa_veswport_mactable {
 	__be16                              offset;
 	__be16                              num_entries;
 	__be32                              mac_tbl_digest;
-	struct opa_veswport_mactable_entry  tbl_entries[0];
+	struct opa_veswport_mactable_entry  tbl_entries[];
 } __packed;
 
 /**
@@ -440,7 +440,7 @@ struct opa_veswport_iface_macs {
 	__be16 num_macs_in_msg;
 	__be16 tot_macs_in_lst;
 	__be16 gen_count;
-	struct opa_vnic_iface_mac_entry entry[0];
+	struct opa_vnic_iface_mac_entry entry[];
 } __packed;
 
 /**
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 5359ece561cad8..6fabcc2faf1f08 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -309,7 +309,7 @@ struct srp_fr_pool {
 	int			max_page_list_len;
 	spinlock_t		lock;
 	struct list_head	free_list;
-	struct srp_fr_desc	desc[0];
+	struct srp_fr_desc	desc[];
 };
 
 /**
diff --git a/include/rdma/ib_fmr_pool.h b/include/rdma/ib_fmr_pool.h
index f8982e4e9702ad..2fd9bfb6d648cc 100644
--- a/include/rdma/ib_fmr_pool.h
+++ b/include/rdma/ib_fmr_pool.h
@@ -73,7 +73,7 @@ struct ib_pool_fmr {
 	int                 remap_count;
 	u64                 io_virtual_address;
 	int                 page_list_len;
-	u64                 page_list[0];
+	u64                 page_list[];
 };
 
 struct ib_fmr_pool *ib_create_fmr_pool(struct ib_pd             *pd,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5f3a04ead9f593..bbc5cfb57cd2bb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1876,7 +1876,7 @@ struct ib_flow_eth_filter {
 	__be16	ether_type;
 	__be16	vlan_tag;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_eth {
@@ -1890,7 +1890,7 @@ struct ib_flow_ib_filter {
 	__be16 dlid;
 	__u8   sl;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_ib {
@@ -1915,7 +1915,7 @@ struct ib_flow_ipv4_filter {
 	u8	ttl;
 	u8	flags;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_ipv4 {
@@ -1933,7 +1933,7 @@ struct ib_flow_ipv6_filter {
 	u8	traffic_class;
 	u8	hop_limit;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_ipv6 {
@@ -1947,7 +1947,7 @@ struct ib_flow_tcp_udp_filter {
 	__be16	dst_port;
 	__be16	src_port;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_tcp_udp {
@@ -1959,7 +1959,7 @@ struct ib_flow_spec_tcp_udp {
 
 struct ib_flow_tunnel_filter {
 	__be32	tunnel_id;
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 /* ib_flow_spec_tunnel describes the Vxlan tunnel
@@ -1976,7 +1976,7 @@ struct ib_flow_esp_filter {
 	__be32	spi;
 	__be32  seq;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_esp {
@@ -1991,7 +1991,7 @@ struct ib_flow_gre_filter {
 	__be16 protocol;
 	__be32 key;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_gre {
@@ -2004,7 +2004,7 @@ struct ib_flow_spec_gre {
 struct ib_flow_mpls_filter {
 	__be32 tag;
 	/* Must be last */
-	u8	real_sz[0];
+	u8	real_sz[];
 };
 
 struct ib_flow_spec_mpls {
diff --git a/include/rdma/opa_vnic.h b/include/rdma/opa_vnic.h
index 0c07a70bd7f61d..e90b149fe92a0b 100644
--- a/include/rdma/opa_vnic.h
+++ b/include/rdma/opa_vnic.h
@@ -75,7 +75,7 @@
 struct opa_vnic_rdma_netdev {
 	struct rdma_netdev rn;  /* keep this first */
 	/* followed by device private data */
-	char *dev_priv[0];
+	char *dev_priv[];
 };
 
 static inline void *opa_vnic_priv(const struct net_device *dev)
diff --git a/include/rdma/rdmavt_mr.h b/include/rdma/rdmavt_mr.h
index 72a3856d4057f5..ce6c888f7fe754 100644
--- a/include/rdma/rdmavt_mr.h
+++ b/include/rdma/rdmavt_mr.h
@@ -85,7 +85,7 @@ struct rvt_mregion {
 	u8  lkey_published;     /* in global table */
 	struct percpu_ref refcount;
 	struct completion comp; /* complete when refcount goes to zero */
-	struct rvt_segarray *map[0];    /* the segments */
+	struct rvt_segarray *map[];    /* the segments */
 };
 
 #define RVT_MAX_LKEY_TABLE_BITS 23
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 0d5c70e2d8ab33..5fc10108703a43 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -191,7 +191,7 @@ struct rvt_swqe {
 	u32 ssn;                /* send sequence number */
 	u32 length;             /* total length of data in sg_list */
 	void *priv;             /* driver dependent field */
-	struct rvt_sge sg_list[0];
+	struct rvt_sge sg_list[];
 };
 
 /**
