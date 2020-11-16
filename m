Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0A2B526B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgKPUXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:22 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:28922 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732296AbgKPUXV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb80000>; Tue, 17 Nov 2020 04:23:20 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:19 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNI+jFMK33P5lThssz4KfklKgMsB5wnvSmttWxtEYRf2O+5szZL5QADFbh2Oko7PIjzrdSPjjcy4+83sInpmkST55WYVQWXulGUMmTpxeJlyA4sEo7AHHoXL4jOgIzaxSmyPMjKflOpYTbIaFHoS3Zb2EGU9USCF2ZhIF1iwPgLWPL4Sk5vI10KjkbgHFatGcdKEzdyvpR00W0T6viFh5ZyQNHXsC1QBK2tz6o0jB41aYKqlt+GScTuQH6VhoCLYm/MKaryA9v5IP4ssXIU09MzwuVrxsZabSUsXUbpZgUFoK/E0RkYjC0iZbebpNM6dgJpNcz2XE/xb3lkpVh8V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if9llFioi97RFZAFVgXd9vTymvGMX0KR2j54ZpT+ZVI=;
 b=kzKRcE6ydNOU2J6JIuFeU+B6PNtb35wofJ3o9fUWyZTN3qFJmK8kml8ngNiAhkz78aU9Eu7dUcjiFYNR0gfFH7Z7POpe3n4BTYew3zI3RVhVd0Hzrlvfaz/rn2lGGgc3y+thI0jgCpF4PRVTZYwrgzVlbsOe8mnptUzyP3FWQKOug1swygAFowE7FS8wEHBb+OILWM25ELX9tezhZ8P0bNyqMNMJG5zdCeBG/dxs/rlXGzptT/rF8hHKoFtuTLsWx687ZV8taoZrOgLDsjHbaGlIu41JiYqSZGB8ks+VGkVhZxZms55gdf2lX2idVYcWteRGVdh1k0T4kdoK1k7+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/9] verbs: Add ibv_cmd_query_device_any()
Date:   Mon, 16 Nov 2020 16:23:03 -0400
Message-ID: <2-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:c0::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:c0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Mon, 16 Nov 2020 20:23:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l7r-OA; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558200; bh=8QQ1pUmlvvGcCPSTSwih+uFucHwaDEeekeWuKEelfps=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=it6lZL0ryFDo010hV42bAJ4vx7S6b5h1scvTrbXT6qOQmgvPusMiaFT42on6Ga3wo
         1LrhjA6arh4l8K99m+fLR0hvGBvgRsAV/WQwnf0qzgtNN968v/mMm5B2k3R2roOMqJ
         FAvlQQ73SkEhn1YCFj9aNXhpkpOBhEC6xSyZCdSCPhZ07me508B+EXdJQzUCrXaupV
         2Uk6ds4q35VlNRiuhjsEHtjyI3Md+opvJ/Ll5AmVSuaAnLRpIzAYnUbsO6r7IoU91g
         9DKf99Sajs2Zh6ZsiniYa0n8E2vnfUa2xHb/uW8UZN1XbAXfLafmeMkN3UPMFM7jgv
         h1xIXZeE7eTLg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This implements all the query_device command flows under a single call.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/cmd_device.c      | 155 +++++++++++++++++++++++++++++++++++
 libibverbs/driver.h          |   5 ++
 libibverbs/libibverbs.map.in |   1 +
 3 files changed, 161 insertions(+)

diff --git a/libibverbs/cmd_device.c b/libibverbs/cmd_device.c
index 6c8e01ec9866a9..0019784ee779c1 100644
--- a/libibverbs/cmd_device.c
+++ b/libibverbs/cmd_device.c
@@ -35,6 +35,7 @@
 #include <stdlib.h>
 #include <dirent.h>
 #include <infiniband/cmd_write.h>
+#include <util/util.h>
=20
 #include <net/if.h>
=20
@@ -516,3 +517,157 @@ ssize_t _ibv_query_gid_table(struct ibv_context *cont=
ext,
=20
 	return num_entries;
 }
+
+int ibv_cmd_query_device_any(struct ibv_context *context,
+			     const struct ibv_query_device_ex_input *input,
+			     struct ibv_device_attr_ex *attr, size_t attr_size,
+			     struct ib_uverbs_ex_query_device_resp *resp,
+			     size_t *resp_size)
+{
+	struct ib_uverbs_ex_query_device_resp internal_resp;
+	size_t internal_resp_size;
+	int err;
+
+	if (input && input->comp_mask)
+		return EINVAL;
+	if (attr_size < sizeof(attr->orig_attr))
+		return EINVAL;
+
+	if (!resp) {
+		resp =3D &internal_resp;
+		internal_resp_size =3D sizeof(internal_resp);
+		resp_size =3D &internal_resp_size;
+	}
+	memset(attr, 0, attr_size);
+	memset(resp, 0, *resp_size);
+
+	if (attr_size > sizeof(attr->orig_attr)) {
+		struct ibv_query_device_ex cmd =3D {};
+
+		err =3D execute_cmd_write_ex(context,
+					   IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
+					   &cmd, sizeof(cmd), resp, *resp_size);
+		if (err) {
+			if (err !=3D EOPNOTSUPP)
+				return err;
+			attr_size =3D sizeof(attr->orig_attr);
+		}
+	}
+
+	if (attr_size =3D=3D sizeof(attr->orig_attr)) {
+		struct ibv_query_device cmd =3D {};
+
+		err =3D execute_cmd_write(context, IB_USER_VERBS_CMD_QUERY_DEVICE,
+					&cmd, sizeof(cmd), &resp->base,
+					sizeof(resp->base));
+		if (err)
+			return err;
+		resp->response_length =3D sizeof(resp->base);
+	}
+
+	*resp_size =3D resp->response_length;
+	attr->orig_attr.node_guid =3D resp->base.node_guid;
+	attr->orig_attr.sys_image_guid =3D resp->base.sys_image_guid;
+	attr->orig_attr.max_mr_size =3D resp->base.max_mr_size;
+	attr->orig_attr.page_size_cap =3D resp->base.page_size_cap;
+	attr->orig_attr.vendor_id =3D resp->base.vendor_id;
+	attr->orig_attr.vendor_part_id =3D resp->base.vendor_part_id;
+	attr->orig_attr.hw_ver =3D resp->base.hw_ver;
+	attr->orig_attr.max_qp =3D resp->base.max_qp;
+	attr->orig_attr.max_qp_wr =3D resp->base.max_qp_wr;
+	attr->orig_attr.device_cap_flags =3D resp->base.device_cap_flags;
+	attr->orig_attr.max_sge =3D resp->base.max_sge;
+	attr->orig_attr.max_sge_rd =3D resp->base.max_sge_rd;
+	attr->orig_attr.max_cq =3D resp->base.max_cq;
+	attr->orig_attr.max_cqe =3D resp->base.max_cqe;
+	attr->orig_attr.max_mr =3D resp->base.max_mr;
+	attr->orig_attr.max_pd =3D resp->base.max_pd;
+	attr->orig_attr.max_qp_rd_atom =3D resp->base.max_qp_rd_atom;
+	attr->orig_attr.max_ee_rd_atom =3D resp->base.max_ee_rd_atom;
+	attr->orig_attr.max_res_rd_atom =3D resp->base.max_res_rd_atom;
+	attr->orig_attr.max_qp_init_rd_atom =3D resp->base.max_qp_init_rd_atom;
+	attr->orig_attr.max_ee_init_rd_atom =3D resp->base.max_ee_init_rd_atom;
+	attr->orig_attr.atomic_cap =3D resp->base.atomic_cap;
+	attr->orig_attr.max_ee =3D resp->base.max_ee;
+	attr->orig_attr.max_rdd =3D resp->base.max_rdd;
+	attr->orig_attr.max_mw =3D resp->base.max_mw;
+	attr->orig_attr.max_raw_ipv6_qp =3D resp->base.max_raw_ipv6_qp;
+	attr->orig_attr.max_raw_ethy_qp =3D resp->base.max_raw_ethy_qp;
+	attr->orig_attr.max_mcast_grp =3D resp->base.max_mcast_grp;
+	attr->orig_attr.max_mcast_qp_attach =3D resp->base.max_mcast_qp_attach;
+	attr->orig_attr.max_total_mcast_qp_attach =3D
+		resp->base.max_total_mcast_qp_attach;
+	attr->orig_attr.max_ah =3D resp->base.max_ah;
+	attr->orig_attr.max_fmr =3D resp->base.max_fmr;
+	attr->orig_attr.max_map_per_fmr =3D resp->base.max_map_per_fmr;
+	attr->orig_attr.max_srq =3D resp->base.max_srq;
+	attr->orig_attr.max_srq_wr =3D resp->base.max_srq_wr;
+	attr->orig_attr.max_srq_sge =3D resp->base.max_srq_sge;
+	attr->orig_attr.max_pkeys =3D resp->base.max_pkeys;
+	attr->orig_attr.local_ca_ack_delay =3D resp->base.local_ca_ack_delay;
+	attr->orig_attr.phys_port_cnt =3D resp->base.phys_port_cnt;
+
+#define CAN_COPY(_ibv_attr, _uverbs_attr)                                 =
     \
+	(attr_size >=3D offsetofend(struct ibv_device_attr_ex, _ibv_attr) &&     =
\
+	 resp->response_length >=3D                                              =
\
+		 offsetofend(struct ib_uverbs_ex_query_device_resp,            \
+			     _uverbs_attr))
+
+	if (CAN_COPY(odp_caps, odp_caps)) {
+		attr->odp_caps.general_caps =3D resp->odp_caps.general_caps;
+		attr->odp_caps.per_transport_caps.rc_odp_caps =3D
+			resp->odp_caps.per_transport_caps.rc_odp_caps;
+		attr->odp_caps.per_transport_caps.uc_odp_caps =3D
+			resp->odp_caps.per_transport_caps.uc_odp_caps;
+		attr->odp_caps.per_transport_caps.ud_odp_caps =3D
+			resp->odp_caps.per_transport_caps.ud_odp_caps;
+	}
+
+	if (CAN_COPY(completion_timestamp_mask, timestamp_mask))
+		attr->completion_timestamp_mask =3D resp->timestamp_mask;
+
+	if (CAN_COPY(hca_core_clock, hca_core_clock))
+		attr->hca_core_clock =3D resp->hca_core_clock;
+
+	if (CAN_COPY(device_cap_flags_ex, device_cap_flags_ex))
+		attr->device_cap_flags_ex =3D resp->device_cap_flags_ex;
+
+	if (CAN_COPY(rss_caps, rss_caps)) {
+		attr->rss_caps.supported_qpts =3D resp->rss_caps.supported_qpts;
+		attr->rss_caps.max_rwq_indirection_tables =3D
+			resp->rss_caps.max_rwq_indirection_tables;
+		attr->rss_caps.max_rwq_indirection_table_size =3D
+			resp->rss_caps.max_rwq_indirection_table_size;
+	}
+
+	if (CAN_COPY(max_wq_type_rq, max_wq_type_rq))
+		attr->max_wq_type_rq =3D resp->max_wq_type_rq;
+
+	if (CAN_COPY(raw_packet_caps, raw_packet_caps))
+		attr->raw_packet_caps =3D resp->raw_packet_caps;
+
+	if (CAN_COPY(tm_caps, tm_caps)) {
+		attr->tm_caps.max_rndv_hdr_size =3D
+			resp->tm_caps.max_rndv_hdr_size;
+		attr->tm_caps.max_num_tags =3D resp->tm_caps.max_num_tags;
+		attr->tm_caps.flags =3D resp->tm_caps.flags;
+		attr->tm_caps.max_ops =3D resp->tm_caps.max_ops;
+		attr->tm_caps.max_sge =3D resp->tm_caps.max_sge;
+	}
+
+	if (CAN_COPY(cq_mod_caps, cq_moderation_caps)) {
+		attr->cq_mod_caps.max_cq_count =3D
+			resp->cq_moderation_caps.max_cq_moderation_count;
+		attr->cq_mod_caps.max_cq_period =3D
+			resp->cq_moderation_caps.max_cq_moderation_period;
+	}
+
+	if (CAN_COPY(max_dm_size, max_dm_size))
+		attr->max_dm_size =3D resp->max_dm_size;
+
+	if (CAN_COPY(xrc_odp_caps, xrc_odp_caps))
+		attr->xrc_odp_caps =3D resp->xrc_odp_caps;
+#undef CAN_COPY
+
+	return 0;
+}
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 87d1a030a39c2d..e54db0ea6413e8 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -460,6 +460,11 @@ int ibv_cmd_create_flow_action_esp(struct ibv_context =
*ctx,
 int ibv_cmd_modify_flow_action_esp(struct verbs_flow_action *flow_action,
 				   struct ibv_flow_action_esp_attr *attr,
 				   struct ibv_command_buffer *driver);
+int ibv_cmd_query_device_any(struct ibv_context *context,
+			     const struct ibv_query_device_ex_input *input,
+			     struct ibv_device_attr_ex *attr, size_t attr_size,
+			     struct ib_uverbs_ex_query_device_resp *resp,
+			     size_t *resp_size);
 int ibv_cmd_query_device_ex(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size,
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 7429016aae0f02..c1f7e09b240ab0 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -204,6 +204,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_post_srq_recv;
 		ibv_cmd_query_context;
 		ibv_cmd_query_device;
+		ibv_cmd_query_device_any;
 		ibv_cmd_query_device_ex;
 		ibv_cmd_query_mr;
 		ibv_cmd_query_port;
--=20
2.29.2

