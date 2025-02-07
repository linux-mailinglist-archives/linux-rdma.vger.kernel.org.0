Return-Path: <linux-rdma+bounces-7491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9DA2B6FD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC916486D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8AA9450;
	Fri,  7 Feb 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMJtnyN2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACB184;
	Fri,  7 Feb 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887226; cv=fail; b=gYCvsiKJNghJfYLdP/ZDEfpP6Ebp7HLWujLvNUmHVB5jYwFrz1J5kBmNzo1nVuz3UmjoXO7+wR+gnZIRm6FYY08Qj0A5Vkt4tc9CKe6os9T8sP9ZoO1wB/7CtCM+CR0cF5amWqGF0WE+zZBLIPcYPoalyDwsNmi6Azxp7+bu3zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887226; c=relaxed/simple;
	bh=t1Hk9TcUPaz6tzZt3m3zt5EekizdJaBuJ+wKgp6BVeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pX5Ha/TKYoSsurQHwuxhD1Kjkkcc8b/SWvDArKoUmT7ui2Lah22N98j/ELdwq7++74PQxgrG6K/8huyxhmn0SZJ5yk+VeLtAWAmtT+THhMB52GefcU/V/3JJ994nBdT9qJhIceadd6d2ZClnYr3Q/JNCFpGovbGg6/sSG8+Smww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMJtnyN2; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCK5QzsoU216QWWlz7Tqw0IvwYGgDaxXO4aHOucNbMc3cq8ndD+TNprDTO5Mvuy/DPg3i7BvXK1E9cbHCQGZ6OWL5GJVPCO9d3LRQnGjYxqlulp3UAJsJtg7JQ1I7Ove09mQV6ZDq0XTwh5JSg+RTasoiQ0x4pgfT932xFaUrvCqtK45jd94OoKylvENs9O2pWmmRAsN1fzJjaC6iZ52F5IiaATgU6Elt6o5LSjazngB68bo5ritCOaFfKSW1CsTBywbqp/E06MqmJOXlD6M1g7fZ7YAVnh0jV+1sildOoeyam2kXviKfkB9YzUD/Jalk5tJkXtuL+tbbb7rEvIbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4pQnpu/UFochfKVaWD7hHC7WygK2UxM4M5/Rxm7Qcg=;
 b=TJosncdKZ5ARUI9AjC9SLstIL1WbFBfLUBBJL2FsBKDRICU+0jU4aGXR4ymglTiuHCV+TlSD2lpNTa4F8LVD8MWyTG3mFWwiSjkj/6GInOIfu0nnBRuHDUXDiVgO6kAS0HFmLCT+qmYWpXzEAD/q7HOQjfN0IYmBi5NHB27bU3702eCrtE8wK4591vOb/FOrtwi/jPEUwV4lRUvUQ4OMkPKGVVTtdHXCCBqD/YRZVOQi8V7zkzlsSiWj8/nuv9qu8yaNYOq2d5T+npmFRf9EZ+g7wMXKHe0qN+JC6V/yhPOXC7EyGKKjwKnMKKNe+DV+4/GOsSnzrf8FwGjk5bkJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4pQnpu/UFochfKVaWD7hHC7WygK2UxM4M5/Rxm7Qcg=;
 b=PMJtnyN2g7+PUkaXba6oaaiGfsTxtuWJBJ72ixiXNr1PbIj6F48LXwxE0Gkgx3i55rnp3rZ/ZmylY1MjrFCmCIZjn6gJ5UScqHBHIWE+ogghO29VwQCbFaptBsULe0At4CnOy5zxRBW8wXSdSfgzbBKcpEidOffR5jtWd1c1ei8aJS8VeFBGMXf3Dw9NbL30k2JhTddnHkiX6ACiLxwCWmFfuiHfsvgYAlt6zi1Qjko3TuKPCJaAzJLfN9tbUyNhvleCtswWw+jySszUCQbxYdnfuAMnQh6IL3O/2v9HZVw5sa0bYlX0UGYrTdaK7rS+mmcBazjt5HehxVti/ZBPxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character device
Date: Thu,  6 Feb 2025 20:13:24 -0400
Message-ID: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed3183b-b7f8-416e-9b6b-08dd470c4275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bb8IwGGrRpoKJTxNBS+GA1jwjP+VbeQq8PJrNRjtOAkKm4cJMRDYsQ57Ain8?=
 =?us-ascii?Q?jB6JrxLem1dEHRsKUJm/gppfw5cpKYb7+7IbM0s1SqnCjtt+WWOQgXtsiIlD?=
 =?us-ascii?Q?5uvtFQqVLvedLLwCPO6LHb4Y4DSV52M5z1vD9LdWIeCC+Rqa9lYOjX/Tm0Ag?=
 =?us-ascii?Q?TKJOvk6sok32sT/GRL/xQI+KHldPkeVuBGi4X9XFV/888C/u7GF1NGsD4WdS?=
 =?us-ascii?Q?rd7qHyutOOSQEM/JIv8NWoysZdOvxR9OX59FO7YmJ+o/pyI4ukVR+5OG6k7T?=
 =?us-ascii?Q?jrpmCh7dp6Yecyx4/bQlKn+JWoTmaGgxg2S6Y7aqGAHNqpGmmrEZZxfw4rn2?=
 =?us-ascii?Q?EjZWz5hxfCEiUsFmqRaisuMG1L4CpZUMSAfOt9jhN32h92+jE2Wd3oWuUlCU?=
 =?us-ascii?Q?hV95kfaW8dmZQOMR1NDTmotz9QxmWwUMA8fzTbvCjU7jFZosZlhHOJSj+FQi?=
 =?us-ascii?Q?YPYz/wr5uaJj/1wUqTCra/AfdLFb9aEqUDrnHruCAld2kkyOvPWHn/shA0Hz?=
 =?us-ascii?Q?HwuYN8XqLtZ8OQDjxRjnO2vsUzUH+prGoi0tHOLeoWldIsBj+SSlb9rJdtnX?=
 =?us-ascii?Q?nbnKGXBe4qHgT7asefZ5KRrDDG/LhB3LTW8yKO7oitBYwuJnKIVjiSqrw3Sk?=
 =?us-ascii?Q?L0fkdlnvBMRi1cggmGtdLkOy/x28wIXsoKRN7QlZ6Nku16YokqQMd/TNSw+n?=
 =?us-ascii?Q?r/m6V29AKc9qjGExO5d3/hS1EFLYY4C5+bnurCjUCoddOS3fjUDtRm1atG/f?=
 =?us-ascii?Q?AXkBj9xcLcTKHp652hEh/8L0EZ5Lpj/PcekPJE7spfIXZMIhg+q+ea7bMyAb?=
 =?us-ascii?Q?NI98JMtqL6CVoKSWJwlB2t4li/11bPaqbC1BG8mNDbjpXHM1VYoRpvGXN+iD?=
 =?us-ascii?Q?NWRbO3qZ2yYsbG8KIoiyAw3S7DedX9CClMGpbHzUo4yRzfM2FxfAI5y8KAX/?=
 =?us-ascii?Q?cpiL0Q873xPNK6iCYqu079BA63uu06omp8nHyIl/qae2SDBQeFd9BBi+gJVf?=
 =?us-ascii?Q?XADU0SPf7tMGFwTfQ529Btsd447WMnQrndVW/iNWHvhygW2DC6g6FEnqJKVO?=
 =?us-ascii?Q?NwYVEcu5rXP4nMhBgt6EsXGiyQpp5CZtsClZeDka5Jdm71TizMQogWZZYy6o?=
 =?us-ascii?Q?ozvRo7RGHeEL9ZHdq8kpWmiXspQjvXambWFnsa6CsMpJUbt4qvg/07f6c+uE?=
 =?us-ascii?Q?kRcNpNGfrLduOZcXukpNYiAaTIuTVzj7NhtMmUDabh5Gx94XjMfj+eGzC07m?=
 =?us-ascii?Q?WJ7EcVEhsju8cDmSWp21/+V5LoAUI2avfdVE1zZ3KkEStvh1GmEuGvMbQ4Uy?=
 =?us-ascii?Q?V0JYek0MH6ERTA/Tjy7EDxN4SwsIZqDvVj4L7rsrgnwesb0l868X29ef5PYT?=
 =?us-ascii?Q?72DUvkhTMSDxxe3z0RSq2DfQH7U2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oay+yOxu4ZcI16GYNe4SH1dSHrcNuu4PrdrCBYGqGxWwXMcgHtkgvYgJA28/?=
 =?us-ascii?Q?+51UtLjgFDqkfE6YnDrJUetVuIrGm+1WsbffRtzq9/vk5A275rWA1eQ8wpL6?=
 =?us-ascii?Q?snv+NiO4dPRyOvqVe3EesND4rdIRSLrAIc4cTuuHYZvWBV2YLgeEgijkvoE6?=
 =?us-ascii?Q?+4mdC5NelTlXf/CBXSwwMaiKBi0KSXhjnQr1tXHiTxEZ8m9LPEJ//LjhDJXS?=
 =?us-ascii?Q?vlNpVuqTYy4IC9TpO1UgcD1Pqa1TmXXwm3Xn4tu0MvXliDfXJGcKj1cakT8a?=
 =?us-ascii?Q?q9czuDJnCsOP5aOHyaqIeSxpKOMam+3yJsx4kSUjUcYdK/PDrmRarhPRgB9R?=
 =?us-ascii?Q?aTiqd3D0fiX3TLHlTt7NbeLlkR6/D1p3Zb6VDgdq+3DW1A47JJ3yruwqn1p8?=
 =?us-ascii?Q?2BOWtUh7hd3v1Oo8YDsoA6u8Ij2QVZuWqbOBMAuuwOX6jblCHLmpGfWvvtvN?=
 =?us-ascii?Q?fBBxMu832rX3Em/7GNXsbVZzN2Yz1V+vi/ZfzTIN2XP8JYi86EeyKLn1Iiyd?=
 =?us-ascii?Q?c41Zod0KQc8ov8xjrA4eWXEKNSE/28ruRppIqfQA8aQ0B+TKFeRhnsDlZINX?=
 =?us-ascii?Q?GygwKhfS86bNlNBa6XaLm8cc3u3x43j/VfaGB8Ti942+F+QqU9dbCaQ3Dx7k?=
 =?us-ascii?Q?MulmyxuuQyie6u80SExmaOcQMNeNErvlSjuVrQG755jFv1VH+rCZKtDjmvix?=
 =?us-ascii?Q?ktfpQvmw3N1h1il3o2xcjY7Wp0FeGeFqjQZ7zVcQnCvk7SmL2ZNEFKVc1W1V?=
 =?us-ascii?Q?fXcU+iK5ivwavtOOpbmpOnpWPFepInEziBr1VrF+BKwVTpSUY0stTH7XO26n?=
 =?us-ascii?Q?EylbUV6N3qVAxltKocNKA6U3CnpZdDxFtdoRGfRNN/G8Aq+Ks968JHOxjnNp?=
 =?us-ascii?Q?G5j6+l+09sSTIKcC+460N9gso5EGyxjKCNGynybn10Rarhj1YrlQtOTV/xJF?=
 =?us-ascii?Q?8g+2vQZW/Td5qDEKdlZfuw2M+ZEL3TSVyTn/DwvryDmi41HjTtp00FcYEEL3?=
 =?us-ascii?Q?0f8r+KmR+e6b+KLrrSnxG4H9gY9uk5fH4Bb4HFNws8a9EsE7N1LCCheUMIUl?=
 =?us-ascii?Q?cqjVcANrhdY49pnU7QeZa346RCXYfQtPOumGA+jSfEBGjoX/rHiSRblJhqh9?=
 =?us-ascii?Q?ASsApQ6oKGVKS+SMdwWRuwXYrGOJFeGVKDlJ3V12+PNzgs7/71qEjU3jq2xI?=
 =?us-ascii?Q?uKgB5TH5ldI74B3+c1uHkrx5J6AaeKfCX24Y0z6xTYWgAmN6fpFXcqRVw60Q?=
 =?us-ascii?Q?nQAV1GTJkJMbt3CUmC3V5C4vNryD//puebfU7ett6NTufGasQyrU77rNhT17?=
 =?us-ascii?Q?W9T3PCAvTpFSr69xy2pBhPkfV8eOLAkQ6fLzCFFrsOtc7qIbrU7JuRsGA/tw?=
 =?us-ascii?Q?QPZBDjbULSQVGpr0coaGMkz03PKOrXuBi7ojZGGYOrJTo9DmlhvLcU+bdxU/?=
 =?us-ascii?Q?zcjFl/Ybu0O8FI1NrYYB26O4e32XR0XInycGCM7WdzQ0qT6dbpz8R1+s4XrN?=
 =?us-ascii?Q?qhzblWmFnfIwEht3w63fOnzIqKwEvPLr3wq0r0apv2eQRsthBAzsFckMH2Oe?=
 =?us-ascii?Q?3okdrGYjSLba37twz/tf/KgfbOHkRTRhU1UhiJBR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3183b-b7f8-416e-9b6b-08dd470c4275
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z82tBXt8Yu7flH2PBFXfVQ6l3GUaXAa0FXCdVPGyMM3YyHrO1XqIDwc2LGxhxoHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

Each file descriptor gets a chunk of per-FD driver specific context that
allows the driver to attach a device specific struct to. The core code
takes care of the memory lifetime for this structure.

The ioctl dispatch and design is based on what was built for iommufd. The
ioctls have a struct which has a combined in/out behavior with a typical
'zero pad' scheme for future extension and backwards compatibility.

Like iommufd some shared logic does most of the ioctl marshalling and
compatibility work and tables diatches to some function pointers for
each unique iotcl.

This approach has proven to work quite well in the iommufd and rdma
subsystems.

Allocate an ioctl number space for the subsystem.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fwctl/main.c                          | 145 +++++++++++++++++-
 include/linux/fwctl.h                         |  46 ++++++
 include/uapi/fwctl/fwctl.h                    |  38 +++++
 5 files changed, 226 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/fwctl/fwctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 6d1465315df328..3410b020a9d093 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -331,6 +331,7 @@ Code  Seq#    Include File                                           Comments
 0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
 0x99  00-0F                                                          537-Addinboard driver
                                                                      <mailto:buk@buks.ipn.de>
+0x9A  00-0F  include/uapi/fwctl/fwctl.h
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index ff418a77f39e4d..5f30adbe6c8521 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9564,6 +9564,7 @@ S:	Maintained
 F:	Documentation/userspace-api/fwctl.rst
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
+F:	include/uapi/fwctl/
 
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 34946bdc3bf3d7..d561deaf2b86d8 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <uapi/fwctl/fwctl.h>
+
 enum {
 	FWCTL_MAX_DEVICES = 4096,
 };
@@ -18,20 +20,128 @@ static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
 
+struct fwctl_ucmd {
+	struct fwctl_uctx *uctx;
+	void __user *ubuffer;
+	void *cmd;
+	u32 user_size;
+};
+
+/* On stack memory for the ioctl structs */
+union ucmd_buffer {
+};
+
+struct fwctl_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct fwctl_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
+	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \
+		.size = sizeof(_struct) +                             \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) < \
+					  sizeof(_struct)),           \
+		.min_size = offsetofend(_struct, _last),              \
+		.ioctl_num = _ioctl,                                  \
+		.execute = _fn,                                       \
+	}
+static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+};
+
+static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct fwctl_uctx *uctx = filp->private_data;
+	const struct fwctl_ioctl_op *op;
+	struct fwctl_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	nr = _IOC_NR(cmd);
+	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
+		return -ENOIOCTLCMD;
+
+	op = &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+
+	ucmd.uctx = uctx;
+	ucmd.cmd = &buf;
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (ret)
+		return ret;
+
+	guard(rwsem_read)(&uctx->fwctl->registration_lock);
+	if (!uctx->fwctl->ops)
+		return -ENODEV;
+	return op->execute(&ucmd);
+}
+
 static int fwctl_fops_open(struct inode *inode, struct file *filp)
 {
 	struct fwctl_device *fwctl =
 		container_of(inode->i_cdev, struct fwctl_device, cdev);
+	int ret;
+
+	guard(rwsem_read)(&fwctl->registration_lock);
+	if (!fwctl->ops)
+		return -ENODEV;
+
+	struct fwctl_uctx *uctx __free(kfree) =
+		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL_ACCOUNT);
+	if (!uctx)
+		return -ENOMEM;
+
+	uctx->fwctl = fwctl;
+	ret = fwctl->ops->open_uctx(uctx);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &fwctl->uctx_list_lock) {
+		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
+	}
 
 	get_device(&fwctl->dev);
-	filp->private_data = fwctl;
+	filp->private_data = no_free_ptr(uctx);
 	return 0;
 }
 
+static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
+{
+	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
+	list_del(&uctx->uctx_list_entry);
+	uctx->fwctl->ops->close_uctx(uctx);
+}
+
 static int fwctl_fops_release(struct inode *inode, struct file *filp)
 {
-	struct fwctl_device *fwctl = filp->private_data;
+	struct fwctl_uctx *uctx = filp->private_data;
+	struct fwctl_device *fwctl = uctx->fwctl;
 
+	scoped_guard(rwsem_read, &fwctl->registration_lock) {
+		/*
+		 * fwctl_unregister() has already removed the driver and
+		 * destroyed the uctx.
+		 */
+		if (fwctl->ops) {
+			guard(mutex)(&fwctl->uctx_list_lock);
+			fwctl_destroy_uctx(uctx);
+		}
+	}
+
+	kfree(uctx);
 	fwctl_put(fwctl);
 	return 0;
 }
@@ -40,6 +150,7 @@ static const struct file_operations fwctl_fops = {
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
+	.unlocked_ioctl = fwctl_fops_ioctl,
 };
 
 static void fwctl_device_release(struct device *device)
@@ -48,6 +159,7 @@ static void fwctl_device_release(struct device *device)
 		container_of(device, struct fwctl_device, dev);
 
 	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
 
@@ -71,14 +183,17 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 	if (!fwctl)
 		return NULL;
 
-	fwctl->dev.class = &fwctl_class;
-	fwctl->dev.parent = parent;
-
 	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
 	if (devnum < 0)
 		return NULL;
 	fwctl->dev.devt = fwctl_dev + devnum;
 
+	fwctl->dev.class = &fwctl_class;
+	fwctl->dev.parent = parent;
+	init_rwsem(&fwctl->registration_lock);
+	mutex_init(&fwctl->uctx_list_lock);
+	INIT_LIST_HEAD(&fwctl->uctx_list);
+
 	device_initialize(&fwctl->dev);
 	return_ptr(fwctl);
 }
@@ -129,6 +244,10 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
  * Undoes fwctl_register(). On return no driver ops will be called. The
  * caller must still call fwctl_put() to free the fwctl.
  *
+ * Unregister will return even if userspace still has file descriptors open.
+ * This will call ops->close_uctx() on any open FDs and after return no driver
+ * op will be called. The FDs remain open but all fops will return -ENODEV.
+ *
  * The design of fwctl allows this sort of disassociation of the driver from the
  * subsystem primarily by keeping memory allocations owned by the core subsytem.
  * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
@@ -136,7 +255,23 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
  */
 void fwctl_unregister(struct fwctl_device *fwctl)
 {
+	struct fwctl_uctx *uctx;
+
 	cdev_device_del(&fwctl->cdev, &fwctl->dev);
+
+	/* Disable and free the driver's resources for any still open FDs. */
+	guard(rwsem_write)(&fwctl->registration_lock);
+	guard(mutex)(&fwctl->uctx_list_lock);
+	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
+						struct fwctl_uctx,
+						uctx_list_entry)))
+		fwctl_destroy_uctx(uctx);
+
+	/*
+	 * The driver module may unload after this returns, the op pointer will
+	 * not be valid.
+	 */
+	fwctl->ops = NULL;
 }
 EXPORT_SYMBOL_NS_GPL(fwctl_unregister, "FWCTL");
 
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 68ac2d5ab87481..93b470efb9dbc3 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -11,7 +11,30 @@
 struct fwctl_device;
 struct fwctl_uctx;
 
+/**
+ * struct fwctl_ops - Driver provided operations
+ *
+ * fwctl_unregister() will wait until all excuting ops are completed before it
+ * returns. Drivers should be mindful to not let their ops run for too long as
+ * it will block device hot unplug and module unloading.
+ */
 struct fwctl_ops {
+	/**
+	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
+	 * bytes of this memory will be a fwctl_uctx. The driver can use the
+	 * remaining bytes as its private memory.
+	 */
+	size_t uctx_size;
+	/**
+	 * @open_uctx: Called when a file descriptor is opened before the uctx
+	 * is ever used.
+	 */
+	int (*open_uctx)(struct fwctl_uctx *uctx);
+	/**
+	 * @close_uctx: Called when the uctx is destroyed, usually when the FD
+	 * is closed.
+	 */
+	void (*close_uctx)(struct fwctl_uctx *uctx);
 };
 
 /**
@@ -26,6 +49,15 @@ struct fwctl_device {
 	struct device dev;
 	/* private: */
 	struct cdev cdev;
+
+	/* Protect uctx_list */
+	struct mutex uctx_list_lock;
+	struct list_head uctx_list;
+	/*
+	 * Protect ops, held for write when ops becomes NULL during unregister,
+	 * held for read whenever ops is loaded or an ops function is running.
+	 */
+	struct rw_semaphore registration_lock;
 	const struct fwctl_ops *ops;
 };
 
@@ -66,4 +98,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
 int fwctl_register(struct fwctl_device *fwctl);
 void fwctl_unregister(struct fwctl_device *fwctl);
 
+/**
+ * struct fwctl_uctx - Per user FD context
+ * @fwctl: fwctl instance that owns the context
+ *
+ * Every FD opened by userspace will get a unique context allocation. Any driver
+ * private data will follow immediately after.
+ */
+struct fwctl_uctx {
+	struct fwctl_device *fwctl;
+	/* private: */
+	/* Head at fwctl_device::uctx_list */
+	struct list_head uctx_list_entry;
+};
+
 #endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
new file mode 100644
index 00000000000000..f4718a6240f281
--- /dev/null
+++ b/include/uapi/fwctl/fwctl.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_FWCTL_H
+#define _UAPI_FWCTL_H
+
+#define FWCTL_TYPE 0x9A
+
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl interface follows a general format to allow for extensibility. Each
+ * ioctl is passed a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOMEM: Out of memory.
+ *  - ENODEV: The underlying device has been hot-unplugged and the FD is
+ *            orphaned.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+enum {
+	FWCTL_CMD_BASE = 0,
+};
+
+#endif
-- 
2.43.0


