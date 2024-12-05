Return-Path: <linux-rdma+bounces-6311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AF9E6085
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 23:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C472844D7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 22:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EA1CCEEC;
	Thu,  5 Dec 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdlVELOB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35B1BBBF1;
	Thu,  5 Dec 2024 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437718; cv=fail; b=Z46xUGfq4oKQv27hIUP/m/bTaLYLWkEigBttXGWvpZBhPECndi7cGoxt/ZzmQAQ82L8wIua0v8FGYpQgP0v/Hs3bSiw2jUlU2mthdAJxWSuxI02rPAknjqijn7p9AU2y4FHOnSDMa33T6G2VfjTTI830POV6FpFkk07qIl+zgvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437718; c=relaxed/simple;
	bh=kcSdxvp3SYXJ0OpBdZVJp2g9WqpM0fNuI1+ly/F7X8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMWcqPVo07J2oADdn11YRrO2+B4zx6m6Ceptki/NZ0hy8Z3DeJkbkv7RgtqaZ+Fe57N5AFadsvaxo4ecXaGws1JJLuwDo44esvOY7WoTn5d2WwDW/q4Gc1dS8VWP3NxAZeTtBQRqOzfPBhonYY5RKqKAdb9ZjpAzT2KgBpiBehk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdlVELOB; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsSuNjDTGkAhr2+Q94Fqxqj+wBvx7jUZoS6ePZb1uMCWCAcSSqnCV/hYlAPuqG8g5DuIz/MkBF2wZuBtkP4EufalVi8lskHToumhUzMNNmUtaFZ5VWb9tzjVVbb+zsKjqo+OdYHFaZbeMiqkd6sxuBFwkAkFu6Yq3H3cj9/qoC4/gjCMu7RB1QSNQd/ZaCj2Z4OHi7buG8E1AZk3eFKfIMgx5HotYzl6Lj2fjD1kawECtlRC5fRBNd8fv0r424hhsCpnHGeNEzGsepZFtlTEiKhNKv5DNu7vdSuK7uSqXIRpeyzksTpFyGWMAvqMcGJlU+QuZSBleZgnpjiDrB+T2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDE+yoe9DAu/7lu2qoDY0E6nQSqm0GKyrloG1PAIK4k=;
 b=L+jU5jueJj1KJUc6/+dK43I6xQAKLG1DhzlpKlr782+hLkGPiBJmZnMBnonxn4/nLhp8A1T0VVxqoA93XJ9k7kyIDm196rDJNE1JervMPL5RO8Vn3H8zw96KSM2wGOsyZpjsQDTeqqXHQrdWmIJxGZJ7PAnAnydYyRhozQsThKurG2BY2OR5t5cWDR0sVf9wXSVmwpfHZFAPItpa+4m2uzlN7gIQhXRQUD/lnRtz0HNs7hObYJlmSnWVdvpQ8baZ4cYgIedUY4bXEN7pmnebtminqjFl9yNX1/JGVZrd10IImFH7ATNfe301MbyWWScTE+bUntd/B8AkVrxhkvAmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDE+yoe9DAu/7lu2qoDY0E6nQSqm0GKyrloG1PAIK4k=;
 b=LdlVELOB1L+L2j7Yn/fDBhWk/Nv2aK8VQSd4uX9OIqSewZj31MD3yqBx82KNtLbffSql6JHTx9vhdNqTEF7NBbHmtMwDFj+VoS0hz7zsdB+D4qQMf4Q4WkwBdrP31sy0Jt+dQPiScnnK8mgpof8gRrIwpdZ8+4ivxaDcHgYDKeE=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 22:28:33 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::5e) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:28:32 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:28:31 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>
CC: <andrew.gospodarek@broadcom.com>, <aron.silverton@oracle.com>,
	<dan.j.williams@intel.com>, <daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>,
	<dsahern@kernel.org>, <gregkh@linuxfoundation.org>, <hch@infradead.org>,
	<itayavr@nvidia.com>, <jiri@nvidia.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>
Subject: Re: [PATCH v3 00/10] Introduce fwctl subystem
Date: Thu, 5 Dec 2024 14:28:18 -0800
Message-ID: <20241205222818.44439-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 399d8a69-de59-4dd3-7f71-08dd157c26e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciSMmkViiU0xqSIbbcyvmq4Xqxu9+L3OLi4Azcv9qID9gXFe6IZzFkZFuhNT?=
 =?us-ascii?Q?16tSlwOQG7m7uK2QYOTAuAsPTAVy2teZHCorCCchXz9eMCC7NkyUIgut2mbi?=
 =?us-ascii?Q?OhsVYyNzswFj9JBy9YTcVW8WIAJhYVdG5H9tB4FQHlfqgPCZU0tw0GE9OL3/?=
 =?us-ascii?Q?ezV3C5+9Qsv9Ps+1IE9AyVVNl+vGOzMIgsky5CIhu/6dVXj2/IDApSyzxlCK?=
 =?us-ascii?Q?tnnfDPW5YxFL4ILLySvAvI3b989zkjkUiH15mpOXUFTWj2ey9B9Fbk+vstJG?=
 =?us-ascii?Q?i2hXmaLj6q1SItuUE2oYQFABYgfHfyzrqFxw2pdv0vNh5N19hs5as1ud7ys9?=
 =?us-ascii?Q?XDiPyYZrskwQ5jdtKO6sRExdls5RzRDovQQUKK0NAKdQL4v94DorcJ8T6OU7?=
 =?us-ascii?Q?6nQJofoX/kEad1qzKPcmseJcwiX8pi6ZYwVWPYPp1et9D3XXAXFYvXp/GRQ+?=
 =?us-ascii?Q?31mo8aYAs6DCon5v/+nT5CuYUDRkShKUOq61zyjVU3rSA2fwwezHoFccD74Q?=
 =?us-ascii?Q?UNXgx2oGEqmjfWz5Q0X6T0HEZEqCV9tIRADvI5vYkl82yD5J+czZa23H8q7G?=
 =?us-ascii?Q?E01m1tDnHgwqnJjtSpDCGvam09SxrVDu5OiJD9FnOpjAwWg4hd8XQWqTUM/H?=
 =?us-ascii?Q?YLhWP0gQqP6il3VChUqvcdM9yVDeiANC57nVPs8BL6sG+oGPig998WgSAnTN?=
 =?us-ascii?Q?lxQM/MQX4bNzHpYw+8dfmTCUMrUuNlXtNI9PcJk2HjT7ok3tE2zrcoLrbXj2?=
 =?us-ascii?Q?xXgYqM6bBnVsDEsSTLgM0dR0V837avDqZahU7nMxyarDMQn0Ku4xRr6B+Wiz?=
 =?us-ascii?Q?Vw5z45SGHhld2aILyOKcHSR+syrvZ6PPgBBmnMAB1jVJwtUhc4l29iqotJm3?=
 =?us-ascii?Q?6sIQGq0ZxBr/BxzqtsLdE9ntVCWNZ0igXCfcK1APneZxXNo1eecv6lu778W4?=
 =?us-ascii?Q?ia8LQok5FqY3EYuA6mB395CaQi8GujLZkYABncrvMzCXvAqBJ+13uITVDzaA?=
 =?us-ascii?Q?Y4RbSlsXzuPdwYNWg/kL+jxmf7/1CKuz92f4ww+lzo7uYQ8vg0nyBGJoXkvj?=
 =?us-ascii?Q?rHxdIqVCOW5Cw1y76pFtQcUd8CBt7KIDZB6iTZzY+vFDFIebd46c74ynHNY/?=
 =?us-ascii?Q?TfZrLJ+t1f/GIKO+VxMsFKAKaxwfk8XozXOBElzS56johvW/x5U+fSuwBNiK?=
 =?us-ascii?Q?EURXNa9Z6knIOFZWu7T2gyTBAJA/+mVjdur6Wasr9MI18PiRPE/dqOC0P41c?=
 =?us-ascii?Q?PGdgTynRzRhNaJvcCUmqIwzanT2jt7tL6dHlRl83pHWr9d6Jj0gpkMh1N/JI?=
 =?us-ascii?Q?feHglWBqjuudFYg99xmZ7W/6oErxyVlml6gmTLZ8QKAQRnPY4hLITUBqVSKn?=
 =?us-ascii?Q?BS4gVzPE3/hR6A5cON/vj2n8XioVg3VyqWq3PGHI+dQ4qRJI/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:28:32.8243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399d8a69-de59-4dd3-7f71-08dd157c26e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

On 08/21/2024 3:10 PM, Jason Gunthorpe wrote:
> 
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.

[snip]

> 
> Several have expressed general support for this concept:
> 
>  Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
>  Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
>  Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
>  Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
>  NVIDIA Networking
>  Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
>  Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
>  SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
> 

Hi Jason,

To add to the support, I can say that we're building an fwctl driver
for our Pensando DSC device and likely will be able to post our first
RFC after the winter holidays.  This will include a couple of updates
in pds_core for support of a new auxiliary device, and a new pds_fwctl
driver to link that to fwctl subsystem.

sln


