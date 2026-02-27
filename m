Return-Path: <linux-rdma+bounces-17270-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKVYFWzvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17270-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2F1B1693
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF6930526D1
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDB2D0602;
	Fri, 27 Feb 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpwK12Wr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285429E101
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154691; cv=fail; b=m5/fkCh0+hvW3uCCqm4SmtItVWNRujmJBnm4SvYT7Zhg6jM2F1y6XRIATGA9Uf1veJTysG3kwZ5BjyTaPaenhi871jD9PRR4En6hHl1eOxxmYNg2eYq/ZMBLei7rSK3a+ltD54Tx752WWnFDkAlOprXCgGNPNUd7cPH7ISkrQMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154691; c=relaxed/simple;
	bh=lB4kH6sYMZ3W5qTvQs6PJJ5RDlDSS8NSukbb+WSqRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LERM2MLRBTB4LQLSiMzPDtQsMWTJ+p6AGy/N9UhM5fGauXnuUTLq9sYDh8qIogT7GuaB2vLCoh77J7AilHMVh2+bAdaNp1M+oWJNhb7sFSWm52ETLFEMnJf1nWHjTwxpBIPQi3PDjkyUhcRyTLxCwRZdoZeQJoCHQFx3KqNC0Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpwK12Wr; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTJbaZnn0kuXR2rDXJhMJ0RQC0ZRgs3+2X/2uhpqva0x2iter5M47gu5qL8dxQ5T5eRlMLMj/ey7uVlm6PMlOdRXjNyiFOOQm/9D4FpMDWVITuZ/oRpOuTWtiI3bu5axdlFwL5sp+i5sHMaaRawi+L2gDwEj9KZKajZdlj+SIggrapstDPeLKFcMNN18d/lmCo22m1m3y9/hu+6R48bbOVHo3wWWtJxuXGc51CSrfgEf+p2owQB3kvHq/WQ6o9r4CujZT6yS8GmACQQLxRPihZUwloc6IQGP/T2sbVtw6gbqKS7vkct4fhYvTNsSWVPgYv8A6Jhmpz7IJW6gjQxSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXmT9aYIfZwBd5de8hOOcguNZSjIvcZXCCOJPzq6u9U=;
 b=QQQqnO/Xzf0jgaSQOdCxnVZyRx2B8KbCSFpegdako2Ni9g6BCP9Iaoc0d87XLJ/JJxcw2kBhTIUh+9yhQkh+O8+r96YlYyqsO2yhFOGt9hgxnJfEyC/goU7EJaYK3mM5tHnLqCLPifujnJOBEai1Zl9nGorwGJB1HUfuDxT7sDgOg9lCIZunUnYcfjdp8VCThZgwUBe0MyZUaSz5r6a4byf1j6W6X+ZLqxiKpAABRSj8PnDH3ETxg5rdgMAvlshxlv7bahx8vAxvOOec+4tQpr5bBe1ZWYXRn4gy+DFtydvqVCUEzs1NH7qcC2tywdy5OYxbfkXVI9ryPhR5n/tBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXmT9aYIfZwBd5de8hOOcguNZSjIvcZXCCOJPzq6u9U=;
 b=CpwK12WryOH2RdBomKwBFUwS0b9XAj4kuB+BYzesJ1d/VEowu/ZIvreHaMouYY0r4r20J7jOLyrQNLYlva7e/7eFlBon8h/PR1kVNv/JvRp7tGgbKhEgNVTHTWJVHfCLYEHWe4L1K1+lVatQA5Sy21FXC1SrDekKcnWPszJ6302EJdpw76WE0I9ZFXa/RW8ZsWizdFRxDbuptz73XkogBeNOFpU+IoXe5nK2Ybb+c9eKwRTQkfpZPdzbqeU0+85r34qWYKHumGZMmG7ScMDUuWD7i36eTptOokCf+oBAObYpfGFULoZEVKbAcHfsH++ZJiH6ka/DK4RXFRrkY1fgsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 09/13] RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
Date: Thu, 26 Feb 2026 21:11:12 -0400
Message-ID: <9-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:208:fc::46) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: bc389b40-6ead-4f65-215f-08de759d1d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	M2sOf7a1YKC6MDuooHdFDR41PIeVkhRm+zgBS1RZQD45Gatc7lmaChCR4gyBlxMPM3GfZq3+TiSUTOPmOZBrAwoolkBu3/AkXbS0gcfd2gnKjKkvQNW35hrsNqprFPVug9eu/5rAqkJQJ6zd5+lo6G4OYvO32YYEsvk/MXHIrvrXpMMJk/xbdJa8SkFAfc8XBY5RzrowU8Qdfb6CElGRBRzOAk7/DiQN9diTeHIkZD0Kn+MbzG9+SsBeDgO18fT9FqD7HsKb5hYjSzBGuCtji5acgnXhYkCsRmStd7mrV+VfE085vELb5J8qz0Y7a3wOrhbHXgpdBFc0p9djdprdRm4x9OZW3aUVgJgN4XEqI2nYc7K4LtVAuu0LXJgaomOu/CLB1MsHCvpkLOI5l84Xr76NWSLmq5ELA6toMCZxBCzOLX9A5kOdxfjBo1LipqMw/ayW5PifRyE/hru7S38Ki99cjsLR08FVrLTRpqEPV7fdl6nJyT+GRU5CNNwuKCobyp6Zr7oc4lc6DNZWqrnC1zDZjeXZd/ryTxPYN2YjByPnYRZ/6xXSM1rEFSsFZtnsS4TT8T60bt31IcBCPhHR+2y5Qjif+AAAJfUYIZSQLp0KXNDxLNXJ00OqmO3MyyzLrDjgDOMc6qR4MERzc7aepTPkq5QXddDvuvis8+vXS6ir9HET9EynJ9ljh5yx0/27TlSSfIb3LceAPEzbqYeqzbBsLFmlCIXyHq8h/VGUeQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRrbcOBm1GMHN8z4LP3ihtIM6SAhjhvBhx66bSQ9MlceZO5/VdvWkK+Tuji7?=
 =?us-ascii?Q?VW+1hStK/lTUy+PMTM8wdAQKFGVfCAjh/DgPljRXd6yKY+jdgO+hkoR/Jn0K?=
 =?us-ascii?Q?QTYsFDgYIzC1SSJ8D+uRGG1vK1cJKSWovKyj/xr0NE4PW6mK5lWXjeZG5CfU?=
 =?us-ascii?Q?lU9etoKvViyoOWwSmja+8bgayusAolOHZnGADEAwVPaJi2Ox2s7K6EhxeN6i?=
 =?us-ascii?Q?eOV4bYicy/2/UCPdJ91Cl7/5EWAWMwV86c6ADJbCBd1ypOVWIB8HVGTQ0pqg?=
 =?us-ascii?Q?7jOGLryQg+td6SxPjCNeH1/Mw/HIfkAcC7UWWhadKh1yajakOKdX95l6yc2o?=
 =?us-ascii?Q?+H8KlJuks/3A/6MW7Lc1PCX1wniNdzCGkp0o/+PcUxsLEzKAsUkdV/qExnJu?=
 =?us-ascii?Q?/6ImsgSbRZaO9wmtTshdgt+rL5XtCtIPgEf+6qYHwxLkW6szCGynb07uycNH?=
 =?us-ascii?Q?GBqUjKSiLX1yI0uvYIAD8QOzj2wLlRAvSLbgr14JLRcGzK89H6Qy1LAJ/pLG?=
 =?us-ascii?Q?97Y+5K+Ef1iFVn1/FO7PxWhbYxpMdMFxCl+PYMtzU7X+NS76PUF8rJg7EkLE?=
 =?us-ascii?Q?KGKPpusSwYhSeVFNLS5U+z1LlJQYczHU3tEOHxRCAnPiNioIwifpoju2ERzI?=
 =?us-ascii?Q?J01fiztSJQpGL9wqbDmpjcP3MzucGEiaK+hlmygIUI7rLZA7WLSBJ7WoJb8D?=
 =?us-ascii?Q?PJi5mb8o7gOH8WKy2VtSEW1XxlkILIMbM7s4sHrGc6Ia3DN8s52WuiznM/qS?=
 =?us-ascii?Q?6duQB1S5iEpO9fFjBf5zPI+D/l8qbtmvXA9O5EJ3GLoeREf0i1OhVvHONKtd?=
 =?us-ascii?Q?7/fcr0RdrGNedrg5u4wBzXFtdx027I9y3odpTO0D6LqFu2Phx1TVcDz2efy0?=
 =?us-ascii?Q?duwt/P2nSn0BSZtQvD7ILYLcoq6LewC2aI8/iTCgCQ/JDYpXeawlwVlHhADW?=
 =?us-ascii?Q?FEP4Q/zjbP3ExEfYyj3xfBKkR0aAlkqonvk+7ohnHszBRQzA692dyeZkGbWL?=
 =?us-ascii?Q?6UDD41/xG1bCNygC3H9ib/hjKHWluv4EA3WUKrNKWaeXA/KtZ9kni6af/Op2?=
 =?us-ascii?Q?8b6kp7Mp7EtvKD42nWg+IeaAwHQYxfnVPzS0oiOxZgz+vx8Oad4F95G1G8OX?=
 =?us-ascii?Q?aOiuEEi8wGo40Bf2wpnKZ30SO9+IdWP6NN+olsGV+wYL3iOXecTvlqx3I4W2?=
 =?us-ascii?Q?J9cctFvOvlanM1hGpB50c3VSmSwA4glT9/S97uw9Bb7+dfGc4hUo/6/UKyU9?=
 =?us-ascii?Q?ctn5n8FkQ1EXD0komsaqS9oh5A2PoN+uOl2p8wOPM7vXl7phWnVUt1X8m4wZ?=
 =?us-ascii?Q?kEPjK7b+5gAJxAnFGTnlDfPdLFu33z2H1DVXOILSPYAoDYe5rUgC/k9fyRRe?=
 =?us-ascii?Q?4YTyi5WO/9P5dlCEEFkYlgHI9SImpJZ5F7zZA/26YCokTi5eHQwJH0SkEK/e?=
 =?us-ascii?Q?WBz7EiZbP/XCmulrZcsXFl8GA0E0Dff029PSh33Am1pAQB59mHYY32rCC8B1?=
 =?us-ascii?Q?Qch3tKNCDgm6YSPB9PfldIMK6zd9z1gUzZcvy607KKFuBpWB70IJqW8bQe2J?=
 =?us-ascii?Q?5uUVPeqgVWEvcTTnF4pxyoev2TCvFaa3DeSzvbx59jkqDssgp81PK8VHbQFO?=
 =?us-ascii?Q?0FbJp9BTV5KeOiathQVt8SyNcnMblKNvvsuICBE+MnFTADhg/UPqePn3h8oX?=
 =?us-ascii?Q?py4VTKb7RyNlo7LkLfKnhpf9SqtU4XlxRsG1akJqjZm6rDAEsC9bCH46XlP0?=
 =?us-ascii?Q?Nqk6zRPWgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc389b40-6ead-4f65-215f-08de759d1d07
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:19.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r47UbjV9rPQtAmDNXnaCDdUbUtvxQC1qWYdS7FclHLBbklNX2AYwUFi+EByfkk+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17270-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,broadcom.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 13B2F1B1693
X-Rspamd-Action: no action

If drivers ever want to go from an empty drvdata to something with them
they need to have called ib_is_udata_in_empty(). Add the missing calls to
all the system calls that don't have req structures.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e1d72ae8261192..6d751febb28c8b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -190,6 +190,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	size_t outlen = (udata) ? udata->outlen : 0;
 	int rc = 0;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
 	       min(sizeof(dev_attr->fw_ver),
@@ -692,6 +696,11 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	if (udata) {
 		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
@@ -720,6 +729,10 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	u32 active_pds;
 	int rc = 0;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	pd->rdev = rdev;
 	if (bnxt_qplib_alloc_pd(&rdev->qplib_res, &pd->qplib_pd)) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate HW PD");
@@ -834,6 +847,10 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_ah_init_attr *init_attr,
 	u8 nw_type;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	if (!(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH)) {
 		ibdev_err(&rdev->ibdev, "Failed to alloc AH: GRH not set");
 		return -EINVAL;
@@ -995,6 +1012,10 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1843,6 +1864,11 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
 		free_page((unsigned long)srq->uctx_srq_page);
@@ -1992,6 +2018,11 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
 
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
@@ -2109,6 +2140,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	unsigned int flags;
 	u8 nw_type;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	if (qp_attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;
 
@@ -3126,12 +3161,17 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	struct bnxt_qplib_nq *nq;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
+	int ret;
 
 	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
 	nq = cq->qplib_cq.nq;
 	cctx = rdev->chip_ctx;
 
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ret;
+
 	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
 		free_page((unsigned long)cq->uctx_cq_page);
 		hash_del(&cq->hash_entry);
@@ -4078,6 +4118,10 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	struct bnxt_re_dev *rdev = mr->rdev;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Dereg MR failed: %#x\n", rc);
@@ -4186,6 +4230,10 @@ struct ib_mw *bnxt_re_alloc_mw(struct ib_pd *ib_pd, enum ib_mw_type type,
 	u32 active_mws;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
 	mw = kzalloc_obj(*mw);
 	if (!mw)
 		return ERR_PTR(-ENOMEM);
@@ -4313,6 +4361,11 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	struct bnxt_re_dev *rdev = pd->rdev;
 	struct ib_umem *umem;
 	struct ib_mr *ib_mr;
+	int ret;
+
+	ret = ib_is_udata_in_empty(udata);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -4497,6 +4550,10 @@ struct ib_flow *bnxt_re_create_flow(struct ib_qp *ib_qp,
 	struct bnxt_re_flow *flow;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
 	if (attr->type != IB_FLOW_ATTR_SNIFFER ||
 	    !rdev->rcfw.roce_mirror)
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.43.0


