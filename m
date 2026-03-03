Return-Path: <linux-rdma+bounces-17435-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGnQAh48p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17435-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7B1F66B7
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5744F3038AFD
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97E3845D2;
	Tue,  3 Mar 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGaLNny6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AF384254
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567426; cv=fail; b=RJQ/r5s9iIZ0pOlKkw9AueuUKNQXId41XI7jKwkwvZSQ1BAln32TOTbRGLBG2m/SjMPpbZ9VOKwzJ601vhvBx5sXxXvIARuV2ncXziTGqBEmva8+jxYHKwQ5/RYY7pprALM5Phd11YNQ/Lx/NgtOeAhB/PvDKIXZl7coGFD6YWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567426; c=relaxed/simple;
	bh=EXarxcb6t1muEwmmQQwurZW5aV3a4uSqeYS4Kad9prI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TK1RCkru0omiasHvBWRnYWG3kYBA/2XkflnCroduMZ7O4afaGAQazLnXdUkAQCrO6qtt9ib83X91IK4LhBdB0rjJOrKO284AJhGin7vRRF1LC3QJnTDNKphAbpNxNSOr7I2uTgqo4NwkUlEKmQAPGdYwu1Jo2f9zZEncr8kL6i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGaLNny6; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti8tBJQyHFPZj/kms8Jm0p+Qv8GmbwdJqPJUgScGNRvbxXl3mF7qGX+jXtOSTVIrEuTcHBwLPC3DgZCQLtjL7b/0ak4+jHCo9Nd6RM3W63B1fqJmnaa0Wq/WqtJ2dfpqeDvWAV4hctNJRNehk/ShbWMfPAWiU0bkz1HHAjLuEXLJk81hT10aUwXjAx8yjHBbkQqvUXd5QVAodLCSLnl1fuOZzv+Tk6+sT2Y165UZakrnDSrHq1d8BqvcRpbCl/++tOWcPJa5nGlsoCpFZmEZugDeXxgknHCoszaws4B4ofkcxIAAmpWp8+1/mNSkt6ylwAhDiiQCPk/CCXTpao/RJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxGkuleCjuJyD37okS8sc+OIqJfjelcSi0OFnJO+eGE=;
 b=YWqtFHf0qUVCRovphRKVj6Etx6G+fhIt3M+kj0IlliCdiPsXowSeUkFEbdDZ8Ddo1QiDvIVR02jvk8EtEsVU7Jr+97khcCj+mYjF+drSmP4hK4BFzuxmh4WO6Qx1aOtN1oxr1+XIaFqvTVqQoSfN3ONju1YyHk/bzKE5T3/T8wQjbfLdkI0u7Qf4n0HwlSzmT7rbmeSdtFkKABuqiqgrLAIg/CJMFRxZoec9thwp9ZMAKAxVzf+Fg9jK23agzKWc3So1+RtHPTtIenJarmYS7c8Dsl6uuhBgOt28gZZOOmiJpOrS84O0vMh+mY1utWN8sD5ofLdvtJbxUaRr8BHkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxGkuleCjuJyD37okS8sc+OIqJfjelcSi0OFnJO+eGE=;
 b=UGaLNny6Xlo/9sTiyKKPEVw863fKxVCHMFPu9XikCou+mdeow8JFZKXxJuAb1E67yIKxi6VxQxoPaQOgQ1Mo0AjFrrsNFJRVqp/De0c7WIuFErM0zFHkVn8elxpT9qXySyO4NLH3ApSU50/yW6K22AWBI1z4ox2e9h4W0bMEoaD/os5G8qP0tPINvG+VOGkTLmgNqMDHS8FYOnwp/L0n80LQP22+HHyHKsSDcz58fXGJfRlDWekSc8YyhFJ6ELRI83YV5tCIEYh9+WwfErlBagHJcLbo8hUHHF7BT83UCGcIjDXAUncAyO8xBo62dopUYYD3oLRbGoZVzKQiFwrQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:17 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 13/13] RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA
Date: Tue,  3 Mar 2026 15:50:10 -0400
Message-ID: <13-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: f217940e-25ee-4fe2-f952-08de795e15bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	ZcPWoMuupnVROtkAfnOW4+kNfdsXZ0q7trO1UpFPts50UxZhARS5qwoUCFGiWUuqlTM8kptgMp8iC4Nh3EQ6r2MeIqSpgWlvbQduBKKlZqFHUyDVUhCQBQz2iq4zcTtU9J1SMdqvTVKi1IUuSkXKvLyfg6RJpQsnZp5rqp5OepPnMWYly1uCFqxFFHdD46a/JJ4wygCJfyKO04FoEoe21F6lW71miFsnyvPessmvGqUmLKiVbuyY2tDwHpUUYbB/whDNFOEYcZ8B/YUWGBrNGMvpAcnQ6HgagiKujH1Kelr+Nl7sffelSn5mEy1zXNvPRWFKKu2mp6gXeu3qw3tAJPxkZ4Pq+Hv/FbXxXI4Ssa66dSDibqmGKYlpPK0V/GfjZe/8CmEyBzWd1aZT3mbAKpgy40jAYPGmlLFbKzLm5i0MBnvo0glDqnar/ls4ONAMCPzEVAdVzJQZnhXycMNaoFLAAkFLbhEhIASKuN3EGd0HvvV87PCuHQTz9EMl9ZJ6UW6OmYrf/zW6MJ/D8nz/Es27fIa6jD5P5SCCm7oOmMm1CjSE9nkv+dKLmU+82n9zmL2g3ULgxliHSkx6TiT3+BvqIh4RneBESvV16jRemtvYrj3NX8GbRsJgWa9jarvO7XxRegrDxm5naknehsQ7y8eb6Yi+a02N8dgO/SaJ26EgVJZuxjS/+//nhgabjAcfHtCr2Q7oLi5Ilv/PHO9QNMNnBf53BYGm30ogKEU+UXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ntSWly92gYx5v9UqzeBK1lqEFluUZp57FIpz2Jsp1+QRdVQyqFv+L+SffgEa?=
 =?us-ascii?Q?vc03UpAdE7WzL7OcXKqpho3Sa0DwPcC3Ik/ae8gBbqgh/lyL3q0kjojmPan7?=
 =?us-ascii?Q?FTzpaSmkopXXt/5TaTFYunWi7jCuHSPVHYvWUkxCaeKSNJWtVEPCQP1QOt32?=
 =?us-ascii?Q?xp5uLAeG3wQVJAAXUNpM6CBsHTtQZYUiPCiXt6/Hbfjnl8dk8LaCMEJvm/Rq?=
 =?us-ascii?Q?MA0OxzIdgtJ9dHtxIzmP8tPpcF3LpsZQDPm/u9i1P2KdUOGbaTgjahv/Abj7?=
 =?us-ascii?Q?uHLX0hOAGeX1aPA+LYTP7H2CdPjtoNOeDRW87Z4/6zh88ZSPSPI2cGvJbvqy?=
 =?us-ascii?Q?527N0jqHAVcTi1lZqpDYjDWp3+3TDIJVTTerOgwBxTv9LFlyOlXXTx9IJPs4?=
 =?us-ascii?Q?WdibiYTHQgDJOoouhzjot9RUM6tz6xwf8uTAxGQGyzhG1+O91KEq1LBeqwMi?=
 =?us-ascii?Q?+iwYxqs1+qWxSdjJyuM5Zp5kYYBH8FHDOe60+5+sSOZykAnAK+Ham0PI9a3H?=
 =?us-ascii?Q?7t28xuF8GZHnE3pAZzwL09hLmJWxvaFpjKNl3AirbBB7oWZTLosW71h7fDo6?=
 =?us-ascii?Q?6myrXT+o7UKdfmr8hcj4G2Anu779owb4vgK7fgCkpsu7X3XwZiiQ/0c7xmO2?=
 =?us-ascii?Q?OsXxoCRcqmOVXnt+EPMos2AGzFdhumZSpoo6m1PDcSwNLJQVFFZHsnx1y9dh?=
 =?us-ascii?Q?6+memoVeUx5zTrBEx+dkEXfYIILJsklnHIyb+0uzvFDp3Jdf4owSrsM5Zj9O?=
 =?us-ascii?Q?kN5udoaB7B9jaUkALv7hOZJNgvn9UsL1hnvSzZSk5VIytkEooX8SYGv2BTuV?=
 =?us-ascii?Q?ZjnzbJL2wiM5Qj4TuJEwT0w2/TcTtQQYLfnF7lwyv1BFJo6U8JrOzcAmGbKE?=
 =?us-ascii?Q?RmWGTXDMhtT+5sKi15a8/jJ1Gl1RSuGjCXbfnWU1c3dmMOWHggh5XLRFcDqS?=
 =?us-ascii?Q?ov8qCg25tiSgbDTMvrcez0SfL7N2/nam0610M0JhWyCX6VopMpkLlT6fXsMP?=
 =?us-ascii?Q?DOA2TO7gE8sc8SKH9Fvu73h3wBxSojM1iFDSv5XJFJqkhOhX/dcjtE9+cpUa?=
 =?us-ascii?Q?kO0/TJ5WIQw7R+D5g3S3QV0OHKJApI6qwxK9EU54md41me0SHPUOhCB5Ah2l?=
 =?us-ascii?Q?cp44ZHUVFQMIy7xdUuNtpLOPcWjHleWknclcVv6BIlph50WvU3vQ4EX8eEA8?=
 =?us-ascii?Q?cVKGDMV/jkM9sn9KmcNdcEHpvsaBbqjoZ1SHFJ4DhPmEJEuD2Y30VJOZ/ZoI?=
 =?us-ascii?Q?krwp55Mp8xfWFW7el2vTxxWZ5laFJC7mdqTf5ajVPg1PW6VpWhqM7PHQengE?=
 =?us-ascii?Q?PA7Mdhs+HXMCnnCrOLIRzohbylntZ5WL1Myqjdnqo435tGSsyX3yzlKY8Os9?=
 =?us-ascii?Q?7rYqiszvzX1YZwQuRZudPd/Oseu/eTQ6pT7rLsxkotHT+7GdSGjPW5MQbAV8?=
 =?us-ascii?Q?AYecdN8TZndpioxLM2CeU/xSyrWJG8f04zG4bSVgqY48Up655ZnNNTi36Bs6?=
 =?us-ascii?Q?Fsa+zqfSqDR3b+qh8fx4DrF2XeWSA0sY+yLiss+ruSraV0uQH4iktwKDdmGk?=
 =?us-ascii?Q?oz/+Ls56VzGQNnnNG0Fpn5FB9JAZ4YL62QzAvAHYgQyov47IAx2Sv8m6dkB8?=
 =?us-ascii?Q?CCSmTAwkGQaaxymv4w8ff9M57lIbydhRlpZbVhEB0PG6cv8cgnsrOVLpVz0f?=
 =?us-ascii?Q?MqoTH6uiiUSBVqAZT/nIvJEOQ4mFjqkhbHoEN2+wGX8vmsNuIlQgMh1yQrTA?=
 =?us-ascii?Q?ugYgBGfWHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f217940e-25ee-4fe2-f952-08de795e15bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:13.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCFm2S73hECsQ9MzSfnb1Ip8B1Pkga/5gZzaQzoX18B/qtNjwEt2e8zgOmTtvyuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 27B7B1F66B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17435-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

This flag can be set by drivers once they have finished auditing and
implementing the full udata support on every udata operation.

My intention going forward is that driver authors proposing new udata uAPI
for their drivers must first do the work and set this flag.

If this flag is not set the userspace should not try to use udata based
uAPI newer than this commit, though on a case by case basis it may be OK
based on what checks historical kernels performed on the specific call.

Since bnxt_re is audited now, it is the first driver to set the flag.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c                  | 1 +
 drivers/infiniband/core/uverbs_std_types_device.c | 8 ++++++++
 drivers/infiniband/hw/bnxt_re/main.c              | 1 +
 include/rdma/ib_verbs.h                           | 6 ++++++
 include/uapi/rdma/ib_user_ioctl_verbs.h           | 1 +
 5 files changed, 17 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 558b73940d6681..5b4fb47cbaeee6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2706,6 +2706,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 
 	dev_ops->uverbs_no_driver_id_binding |=
 		ops->uverbs_no_driver_id_binding;
+	dev_ops->uverbs_robust_udata |= dev_ops->uverbs_robust_udata;
 
 	SET_DEVICE_OP(dev_ops, add_gid);
 	SET_DEVICE_OP(dev_ops, add_sub_dev);
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index a28f9f21bed89d..12ca15739cd2cd 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -247,13 +247,21 @@ static int UVERBS_HANDLER(UVERBS_METHOD_GET_CONTEXT)(
 {
 	u32 num_comp = attrs->ufile->device->num_comp_vectors;
 	u64 core_support = IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS;
+	struct ib_device *ib_dev;
 	int ret;
 
+	ib_dev = srcu_dereference(attrs->ufile->device->ib_dev,
+				  &attrs->ufile->device->disassociate_srcu);
+	if (!ib_dev)
+		return -EIO;
+
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
 			     &num_comp, sizeof(num_comp));
 	if (IS_UVERBS_COPY_ERR(ret))
 		return ret;
 
+	if (ib_dev->ops.uverbs_robust_udata)
+		core_support |= IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA;
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,
 			     &core_support, sizeof(core_support));
 	if (IS_UVERBS_COPY_ERR(ret))
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b576f05e3b26b2..7af514524632e2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1326,6 +1326,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_BNXT_RE,
 	.uverbs_abi_ver = BNXT_RE_ABI_VERSION,
+	.uverbs_robust_udata = true,
 
 	.add_gid = bnxt_re_add_gid,
 	.alloc_hw_port_stats = bnxt_re_ib_alloc_hw_port_stats,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e1ba20c3974f08..58af61eae52de7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2474,6 +2474,12 @@ struct ib_device_ops {
 	enum rdma_driver_id driver_id;
 	u32 uverbs_abi_ver;
 	unsigned int uverbs_no_driver_id_binding:1;
+	/*
+	 * Indicates the driver checks every op accepting a udata for the
+	 * correct size on input and always handles the output using the udata
+	 * helpers.
+	 */
+	unsigned int uverbs_robust_udata:1;
 
 	/*
 	 * NOTE: New drivers should not make use of device_group; instead new
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 89e6a3f13191b9..90c5cd8e7753c7 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -46,6 +46,7 @@
 
 enum ib_uverbs_core_support {
 	IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS = 1 << 0,
+	IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA = 1 << 1,
 };
 
 enum ib_uverbs_access_flags {
-- 
2.43.0


