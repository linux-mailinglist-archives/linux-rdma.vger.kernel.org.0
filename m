Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3A2B5265
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgKPUXU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:22498 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgKPUXS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:18 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb50000>; Tue, 17 Nov 2020 04:23:17 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:16 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3PyxubbWodDRaMqF6/YLelCJ6zmMlw4ConUV58IjT8o9UTQERQlYKGet2cY+JgnPsEXsc/knDPURmOesB1VOt4ocJKEa7SJT91hAxqse2YtVtC0VvubzG0kBzn5xT+/m7bWs+IvKf93KA7D888MwJs7Y6FLxprHLRScjauvCJDCoPQADPmqfrM+z6soyYB1d2PHbIgT4maGleJEVMIAGlUG8ySxQh7pO5X7TCBNaCwQGrKgat0ZBTXSVfxh3VO1L+dujHxWuiRIGgrGPnuyxLfGV7PEh0UUmxFacCSvkAW2WltG0DwFKvpvbPeQ/1wSfydYwMTUXLHjbc93lzfn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D4lmO6fFVwKi0hfYsbAKvh4vaN/YbN75GVEjB+LyC8=;
 b=OkShcwmRtSsg+ZTNqyuDP7cKsA8RNCz7ODnYFgRZGiN3HTfnx1VLtL9b6o8B/qiiXErdFdm7/Uaz9qekyKDWw5WSvAQISpxmqfsG1KFlMHN/dOLHNJ8jWkRHpbTmWN7iJlHzW3AjbNXApebYAzbjqsO3AxF6lwA3NaBLorSJQuQKM3J15++7CwlK7zIC+orV4RX7R0Ek+NF2dZbW4lxcRJvGV60Y6247j5Uoxr5eVCYWpTi/CV36zc1e63mwbGTEx3mEygINtm8lqhN7TNRrh5eAFAnoEUz2/XV2G086P4adUAL2DikdMIA5EC7YYDD5E1woXBDkAg1E/r+YjET/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 8/9] verbs: Remove dead code
Date:   Mon, 16 Nov 2020 16:23:09 -0400
Message-ID: <8-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l8F-Ut; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558197; bh=Ds8LhA3ff12qYdVtifdyU6rA84OwjurspIjk629ojLE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=ShvasIgdevdkGZU5z7tSn4NSFtyMaw5FRQ5hTzbtA07Gwk9jtrmq27rcPtkN1iOjg
         5Mo5I+50WIHP9y3I9YWbIo33at5/ZlBoaEtPC3dQ1fVdmALrweJI3sfJYwYUB0nv9Y
         H8Eq+Wrlo7e8127taKoo4OUWSyxtE0V1iu/177X1pfj6C3E7oPzz542FHpxplFUb+j
         flMSGnkisASNgsfzvCmoESg/tzkswpMxOAi8phaGZxErir/15SaphdgAbuGrV9KIWx
         FA+BV1nlYWKFerDYbUwW4wN84BxaJQNqERJH1ZMMQ2FBINV51WezejZJat49g62v4W
         Mx2llLCG3G6uA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the old query_device support code, it is now replaced by
ibv_cmd_query_device_any()

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/cmd.c             | 99 ------------------------------------
 libibverbs/driver.h          |  8 ---
 libibverbs/libibverbs.map.in |  1 -
 3 files changed, 108 deletions(-)

diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index a439f8c06481dd..ec9750e7c04eb4 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -44,7 +44,6 @@
 #include <infiniband/cmd_write.h>
 #include "ibverbs.h"
 #include <ccan/minmax.h>
-#include <util/util.h>
=20
 bool verbs_allow_disassociate_destroy;
=20
@@ -113,104 +112,6 @@ int ibv_cmd_query_device(struct ibv_context *context,
 	return 0;
 }
=20
-int ibv_cmd_query_device_ex(struct ibv_context *context,
-			    const struct ibv_query_device_ex_input *input,
-			    struct ibv_device_attr_ex *attr, size_t attr_size,
-			    uint64_t *raw_fw_ver,
-			    struct ibv_query_device_ex *cmd,
-			    size_t cmd_size,
-			    struct ib_uverbs_ex_query_device_resp *resp,
-			    size_t resp_size)
-{
-	int err;
-
-	if (input && input->comp_mask)
-		return EINVAL;
-
-	if (attr_size < offsetof(struct ibv_device_attr_ex, comp_mask) +
-			sizeof(attr->comp_mask))
-		return EINVAL;
-
-	cmd->comp_mask =3D 0;
-	cmd->reserved =3D 0;
-	memset(attr->orig_attr.fw_ver, 0, sizeof(attr->orig_attr.fw_ver));
-	memset(&attr->comp_mask, 0, attr_size - sizeof(attr->orig_attr));
-
-	err =3D execute_cmd_write_ex(context, IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
-				   cmd, cmd_size, resp, resp_size);
-	if (err)
-		return err;
-
-	copy_query_dev_fields(&attr->orig_attr, &resp->base, raw_fw_ver);
-	/* Report back supported comp_mask bits. For now no comp_mask bit is
-	 * defined */
-	attr->comp_mask =3D resp->comp_mask & 0;
-
-#define CAN_COPY(_ibv_attr, _uverbs_attr)                                 =
     \
-	(attr_size >=3D offsetofend(struct ibv_device_attr_ex, _ibv_attr) &&     =
\
-	 resp->response_length >=3D                                              =
\
-		 offsetofend(struct ib_uverbs_ex_query_device_resp,            \
-			     _uverbs_attr))
-
-	if (CAN_COPY(odp_caps, odp_caps)) {
-		attr->odp_caps.general_caps =3D resp->odp_caps.general_caps;
-		attr->odp_caps.per_transport_caps.rc_odp_caps =3D
-			resp->odp_caps.per_transport_caps.rc_odp_caps;
-		attr->odp_caps.per_transport_caps.uc_odp_caps =3D
-			resp->odp_caps.per_transport_caps.uc_odp_caps;
-		attr->odp_caps.per_transport_caps.ud_odp_caps =3D
-			resp->odp_caps.per_transport_caps.ud_odp_caps;
-	}
-
-	if (CAN_COPY(completion_timestamp_mask, timestamp_mask))
-		attr->completion_timestamp_mask =3D resp->timestamp_mask;
-
-	if (CAN_COPY(hca_core_clock, hca_core_clock))
-		attr->hca_core_clock =3D resp->hca_core_clock;
-
-	if (CAN_COPY(device_cap_flags_ex, device_cap_flags_ex))
-		attr->device_cap_flags_ex =3D resp->device_cap_flags_ex;
-
-	if (CAN_COPY(rss_caps, rss_caps)) {
-		attr->rss_caps.supported_qpts =3D resp->rss_caps.supported_qpts;
-		attr->rss_caps.max_rwq_indirection_tables =3D
-			resp->rss_caps.max_rwq_indirection_tables;
-		attr->rss_caps.max_rwq_indirection_table_size =3D
-			resp->rss_caps.max_rwq_indirection_table_size;
-	}
-
-	if (CAN_COPY(max_wq_type_rq, max_wq_type_rq))
-		attr->max_wq_type_rq =3D resp->max_wq_type_rq;
-
-	if (CAN_COPY(raw_packet_caps, raw_packet_caps))
-		attr->raw_packet_caps =3D resp->raw_packet_caps;
-
-	if (CAN_COPY(tm_caps, tm_caps)) {
-		attr->tm_caps.max_rndv_hdr_size =3D
-			resp->tm_caps.max_rndv_hdr_size;
-		attr->tm_caps.max_num_tags =3D resp->tm_caps.max_num_tags;
-		attr->tm_caps.flags =3D resp->tm_caps.flags;
-		attr->tm_caps.max_ops =3D resp->tm_caps.max_ops;
-		attr->tm_caps.max_sge =3D resp->tm_caps.max_sge;
-	}
-
-	if (CAN_COPY(cq_mod_caps, cq_moderation_caps)) {
-		attr->cq_mod_caps.max_cq_count =3D
-			resp->cq_moderation_caps.max_cq_moderation_count;
-		attr->cq_mod_caps.max_cq_period =3D
-			resp->cq_moderation_caps.max_cq_moderation_period;
-	}
-
-	if (CAN_COPY(max_dm_size, max_dm_size))
-		attr->max_dm_size =3D resp->max_dm_size;
-
-	if (CAN_COPY(xrc_odp_caps, xrc_odp_caps))
-		attr->xrc_odp_caps =3D resp->xrc_odp_caps;
-#undef CAN_COPY
-
-	return 0;
-}
-
 int ibv_cmd_alloc_pd(struct ibv_context *context, struct ibv_pd *pd,
 		     struct ibv_alloc_pd *cmd, size_t cmd_size,
 		     struct ib_uverbs_alloc_pd_resp *resp, size_t resp_size)
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index e54db0ea6413e8..33998e227c98ec 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -465,14 +465,6 @@ int ibv_cmd_query_device_any(struct ibv_context *conte=
xt,
 			     struct ibv_device_attr_ex *attr, size_t attr_size,
 			     struct ib_uverbs_ex_query_device_resp *resp,
 			     size_t *resp_size);
-int ibv_cmd_query_device_ex(struct ibv_context *context,
-			    const struct ibv_query_device_ex_input *input,
-			    struct ibv_device_attr_ex *attr, size_t attr_size,
-			    uint64_t *raw_fw_ver,
-			    struct ibv_query_device_ex *cmd,
-			    size_t cmd_size,
-			    struct ib_uverbs_ex_query_device_resp *resp,
-			    size_t resp_size);
 int ibv_cmd_query_port(struct ibv_context *context, uint8_t port_num,
 		       struct ibv_port_attr *port_attr,
 		       struct ibv_query_port *cmd, size_t cmd_size);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index c1f7e09b240ab0..672717a6fa551e 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -205,7 +205,6 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_query_context;
 		ibv_cmd_query_device;
 		ibv_cmd_query_device_any;
-		ibv_cmd_query_device_ex;
 		ibv_cmd_query_mr;
 		ibv_cmd_query_port;
 		ibv_cmd_query_qp;
--=20
2.29.2

