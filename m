Return-Path: <linux-rdma+bounces-7810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C85A3A807
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD991895962
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E121EB5CA;
	Tue, 18 Feb 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzunmSmC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A521B9E8;
	Tue, 18 Feb 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908326; cv=fail; b=kc8nNCHzuwtDzEjVbyeVYuTzBDKU9zytIA4gBGN0w7Kz0hG3TqQN3Vc0NAUhq0uJ0KRQNDx+883ZDmI6bV59Ca2PSvtLB/R1Ds1w38hmMescx0CqSXLjl/BkXsmBsD6HWfN5ZcOANErq+wyMgusrU/5qGGFCCxxtlPBKwhg8jfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908326; c=relaxed/simple;
	bh=PjFxv9zbmTj0uq7peyCJVDKAP0n5VERjCwkjAQ1XzUM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdJ5ow8n7y/uI8IGRVhxpWGJgKHrxiTXHs9sKWoIKScHDIsQWIpcV+TOJEY+VWGPbLtCteLwAxAfw1MBLucz6I0HtuKHuCu80ncdIE5gOzrqRONbU6GORXej+uDS4aaTMH/wbR6Hs1vNgC3x5zcpvWN+7dgZaq2L2jye/ZEWp2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzunmSmC; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtFwFgogjgLmXxxMbh21YF++KqXim8LwrWUGl/4WTKjo7zOJ/eQV5O+rPIpHMLJOaibXxuDKyfV8vc33ZAxGVYH3D4PK6sukd3IxKKMO1Ykp+skP3DXYKsVtcYd8DnE5HdFV1PFFUoDkEYRbX1qPRyPwEQKTt89Vy/5DTKL2Oh6dCn0yVpaM+ByV2G4LfBAv4FjCVhcHAbmES2/N7ZiShrnCH8XVOY+2PavMqQO4fUp+9/ygOl6cezYD6Wr/pKRHpIRy3FmEM1Ugha+6xpnRIvq7cktS7T6NDVe/hfQDwfRdyVyp38BqUHXhiHJEbFyKuEK9SQ6KPymGd52iqArlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvPYIwS4TJUwKjNkmyfwaSgiOORnHiXTIp09IJlpQgI=;
 b=iSrFCBeE2fqThRvhK7BWkTsrZHAioKCNWwF8iue3krtHyPqCsLo2hKU58RtWSN/9Oymh2BTyj7btmsM82QGvgHaGAQFJrQiFdDXlnaWKrqRf4+xKGv/RrdsLOjZzZwbqRHQKhXh0vfdGbSscCH4T06QWZJX6HpasbSuq9f1XJPazQ12Qi8ikoWSlrlBGYBrsSkqDgjgsXTngBw09ab4xrrTggkmz2Yqze2vCLF8PxRItFxxCBe9K6iXcClSjQgTsvXZB32OxHbYHfiVQhr4iEdjyhmt1al5RxoxoEXkqGppfZeAnpR4y5X51tB/LDbVKUX4BErNy/18o/u1n3C/p9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvPYIwS4TJUwKjNkmyfwaSgiOORnHiXTIp09IJlpQgI=;
 b=YzunmSmCZT8y8OR2XRw82DaEyPbwENvH4iTP26dec+xcjagbG0lNxnH3nBZkI01dSD7QlzCrRAGEenn0L+AshTeKeIyDD7lilbok12WElNymlZTcrY+u/as9kJshXX8VV/wIxbK6AQHxeV9qbRybp3c8NzOLLelbFP28t/s6mwFNAdGBj8Lo+q7lPIUpVNEHlgZDKfZLoh0U/UHnN7tnNyrXJwb9UpF0D5VIt4IB4F6dUtHHGQzVgXApwUey3ar/N/lu2wEwB3Dc+WKvVAaKRD3p9BSBRIeVn6IIxW/J/B10x+YCEtX6HYyTeqiEU8gjua7pP5P8+R48kecG84jSSw==
Received: from SN7PR04CA0201.namprd04.prod.outlook.com (2603:10b6:806:126::26)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:51:55 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::93) by SN7PR04CA0201.outlook.office365.com
 (2603:10b6:806:126::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.22 via Frontend Transport; Tue,
 18 Feb 2025 19:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 19:51:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 11:51:37 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 11:51:36 -0800
Date: Tue, 18 Feb 2025 21:51:32 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <saeedm@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<brett.creeley@amd.com>
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
Message-ID: <20250218195132.GB53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211234854.52277-4-shannon.nelson@amd.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: beb3a8f8-3285-4efe-1f0b-08dd5055b297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?71pQIXj6kOf1YcDEPuRvH8jvROQeNSMG1eYNrpkj/iM1g2K+W57FH9a5RXaY?=
 =?us-ascii?Q?Y+IwjD1HOYWUGTIxgn+fC1ZYfVkEyUVwH4m6tjiYx9FCdnbZ139psP7JqfWb?=
 =?us-ascii?Q?K01R8d5J5Gp64d/gW58bNZVNk+RMIrICr7PDVf/MCBc9I2S5l4MFupsRhzl1?=
 =?us-ascii?Q?CTao1JDId/tdddt9y1OXD6Y+kGcUDbyAEqgFzfmFI7+eQvFaWB7T2BvgfGYT?=
 =?us-ascii?Q?OGjqrKbgwENqbDrTP5jA81Y0WvZpTBoWvnT+dCaai5ggf+bYgrlHdzWPaRhT?=
 =?us-ascii?Q?G1l0HL3o9MvaxGbdNaAAsiQm6VK6NmE8t4VcX813mr6XhriOC1M9L8RdxQxf?=
 =?us-ascii?Q?ri8P3wIZNbP4Ei+TnA5D//GNNWl9ZXJ2Y3Hbee6LtvPR9mU14Hh93lrwQwiu?=
 =?us-ascii?Q?ZzpEnHpmxTtabNpvaJUbreQFRaabtE5zIvgpLUov+o84I2+rEfYkfMAtRIY2?=
 =?us-ascii?Q?QPTc7CDWWR+4s++zXGKtEjdN+D3wH7yJfpkeCcQuDso77nTnIGz0yuTBOtqd?=
 =?us-ascii?Q?Y9X2CgB7iMUJ3n9RLhUdMXB7QvonTyde3HZ1bLDzk7ckl7ZmZwTFi3IrxfXV?=
 =?us-ascii?Q?DbACw1/hOF010MXbB/jLX4BJB81DfEV3zX7ZwspAwwdzvlUxCai+1vNXX5pN?=
 =?us-ascii?Q?ROvT1Eeps89r8KXgirVVoZJvgpxzUTNZdOiA3q6LKeQljOIhOi13DqTKLQSd?=
 =?us-ascii?Q?Q912o5VE5aWBxtppj4hB/9xG47rlATRKuoQWSR+q8zxbN0SalJ6nKQ0ypMDy?=
 =?us-ascii?Q?hzAkN3h5cvqKAEGZfCyGyXTMQCOEHmXi+3R1PKX5daap/cYWpaSmnAvldVv3?=
 =?us-ascii?Q?OMxlJi+ytuOZtDXhAT6Is4dPWUsIgSKi3QID72g758rVbJJb7QCwYHDopYFZ?=
 =?us-ascii?Q?JCn5BTBd3SajRV34a4R4kXf3SRRyahmOUtwU54KlCC9gHCTmWC9R04DYhmdK?=
 =?us-ascii?Q?1hvSyFI9lhtOHR5BLSLxsQpt5+1kfT8GWEky5mdltBZryyg3wXQZu7lge4FC?=
 =?us-ascii?Q?N5aq8eLHB9Nf4XCwfFq/p0792ry53829lacIPefb8Xyo8cnBKSGAesQfX/Du?=
 =?us-ascii?Q?BzPiJWW8bV0drcgxnvX4cCdf7RPtl0qc/j2CYG54gFdbQwFjO6B/5I7m7U1q?=
 =?us-ascii?Q?wZZ8z+hmLsmg5fCUR2oJwu5rxL7Y+8rAzTbr5JE2+k1/R6mXs2SnVhrstZvw?=
 =?us-ascii?Q?Dv3xZNOjAG1rrHznMtJA96hcGOT184EsBXNX9SipU1zhGayrQA3+VfXuEhrP?=
 =?us-ascii?Q?v1NESjPm8W2Px8lokujfTZljDYn9qZIQQwGkZ9Bz0oZVQ4yIxNJvpGfP4O0u?=
 =?us-ascii?Q?vm5KX3HOJqEONxg0tJO6Y+ANzulH2A3i7dciO4N8j0CHZ44D7Uv+9wt7FF0Y?=
 =?us-ascii?Q?M2SP3zbBhZWK4BPfg6de5l6NQGtog77hcNONTLc8WbvVNVtxvVYubHAHby9A?=
 =?us-ascii?Q?ggIDO/kiME+rCH9nVc9bFk3Ru/Esz/hgbwZm5uJ+eD0LT0S/aeulcoxF4vBD?=
 =?us-ascii?Q?yM5kncQksAxNmvU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:51:55.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb3a8f8-3285-4efe-1f0b-08dd5055b297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

On Tue, Feb 11, 2025 at 03:48:52PM -0800, Shannon Nelson wrote:
> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> devices.  This sets up a simple auxiliary_bus driver that registers
> with fwctl subsystem.  It expects that a pds_core device has set up
> the auxiliary_device pds_core.fwctl
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  MAINTAINERS                    |   7 ++
>  drivers/fwctl/Kconfig          |  10 ++
>  drivers/fwctl/Makefile         |   1 +
>  drivers/fwctl/pds/Makefile     |   4 +
>  drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
>  include/linux/pds/pds_adminq.h |  77 +++++++++++++
>  include/uapi/fwctl/fwctl.h     |   1 +
>  include/uapi/fwctl/pds.h       |  27 +++++
>  8 files changed, 322 insertions(+)
>  create mode 100644 drivers/fwctl/pds/Makefile
>  create mode 100644 drivers/fwctl/pds/main.c
>  create mode 100644 include/uapi/fwctl/pds.h

<...>

> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +	struct device *dev = &uctx->fwctl->dev;
> +
> +	dev_dbg(dev, "%s: caps = 0x%04x\n", __func__, pdsfc->caps);

This driver is too noisy and has too many debug/err prints.

> +	pdsfc_uctx->uctx_caps = pdsfc->caps;
> +
> +	return 0;
> +}
> +
> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +	struct fwctl_info_pds *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->uctx_caps = pdsfc_uctx->uctx_caps;
> +
> +	return info;
> +}
> +
> +static void pdsfc_free_ident(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +
> +	if (pdsfc->ident) {

It is not kernel style, which is success oriented.
If (!pdsfc->ident)
   return;

However I don't know how can this happen. You shouldn't call to pdsfc_free_ident
if ident wasn't set.

> +		dma_free_coherent(dev, sizeof(*pdsfc->ident),
> +				  pdsfc->ident, pdsfc->ident_pa);
> +		pdsfc->ident = NULL;

Please don't assign NULL to pointers if they are not reused.

> +		pdsfc->ident_pa = DMA_MAPPING_ERROR;

Same.

> +	}
> +}
> +
> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd = {0};
> +	struct pds_fwctl_ident *ident;
> +	dma_addr_t ident_pa;
> +	int err = 0;

There is no need to assign 0 to err.

> +
> +	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, ident_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map ident\n");

This is one of the examples of such extra prints.

> +		return err;
> +	}
> +
> +	cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
> +	cmd.fwctl_ident.version = 0;

How will you manage this version field?

> +	cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
> +	cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		return err;
> +	}
> +
> +	pdsfc->ident = ident;
> +	pdsfc->ident_pa = ident_pa;
> +
> +	dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
> +		ident->version, ident->max_req_sz, ident->max_resp_sz,
> +		ident->max_req_sg_elems, ident->max_resp_sg_elems);
> +
> +	return 0;
> +}
> +
> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			  void *in, size_t in_len, size_t *out_len)
> +{
> +	return NULL;
> +}
> +
> +static const struct fwctl_ops pdsfc_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_PDS,
> +	.uctx_size = sizeof(struct pdsfc_uctx),
> +	.open_uctx = pdsfc_open_uctx,
> +	.close_uctx = pdsfc_close_uctx,
> +	.info = pdsfc_info,
> +	.fw_rpc = pdsfc_fw_rpc,
> +};
> +
> +static int pdsfc_probe(struct auxiliary_device *adev,
> +		       const struct auxiliary_device_id *id)
> +{
> +	struct pdsfc_dev *pdsfc __free(pdsfc_dev);
> +	struct pds_auxiliary_dev *padev;
> +	struct device *dev = &adev->dev;
> +	int err = 0;
> +
> +	padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
> +	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> +				   struct pdsfc_dev, fwctl);
> +	if (!pdsfc) {
> +		dev_err(dev, "Failed to allocate fwctl device struct\n");
> +		return -ENOMEM;
> +	}
> +	pdsfc->padev = padev;
> +
> +	err = pdsfc_identify(pdsfc);
> +	if (err) {
> +		dev_err(dev, "Failed to identify device, err %d\n", err);
> +		return err;
> +	}
> +
> +	err = fwctl_register(&pdsfc->fwctl);
> +	if (err) {
> +		dev_err(dev, "Failed to register device, err %d\n", err);
> +		return err;
> +	}
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
> +
> +	return 0;
> +
> +free_ident:
> +	pdsfc_free_ident(pdsfc);
> +	return err;
> +}
> +
> +static void pdsfc_remove(struct auxiliary_device *adev)
> +{
> +	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&pdsfc->fwctl);
> +	pdsfc_free_ident(pdsfc);
> +}
> +
> +static const struct auxiliary_device_id pdsfc_id_table[] = {
> +	{.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
> +
> +static struct auxiliary_driver pdsfc_driver = {
> +	.name = "pds_fwctl",
> +	.probe = pdsfc_probe,
> +	.remove = pdsfc_remove,
> +	.id_table = pdsfc_id_table,
> +};
> +
> +module_auxiliary_driver(pdsfc_driver);
> +
> +MODULE_IMPORT_NS(FWCTL);
> +MODULE_DESCRIPTION("pds fwctl driver");
> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 4b4e9a98b37b..7fc353b63353 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>  	u8     status;
>  };
>  
> +enum pds_fwctl_cmd_opcode {
> +	PDS_FWCTL_CMD_IDENT		= 70,

Please try to avoid from vertical space alignment. It doesn't survive
time and at some point you will need to reformat it, which will cause
to churn and harm backporting/stable without any reason.

Thanks

