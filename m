Return-Path: <linux-rdma+bounces-4467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2830495A47E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B61C22818
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365E1B3B1C;
	Wed, 21 Aug 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HANrX9Ba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19AA1B3B1E;
	Wed, 21 Aug 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263877; cv=fail; b=c3VECPaXEUHbh4BlpSRvQEPiub8WiqvvbiOADFSf1oteAuRnRG24/ZJpGqVWZCzH1aWUleuRW9+3dbof1qP4Sw5kMxwsZIHnP7cS7Ev5EA5rvyaA5KcOqqwFJ7bZwhQokvQ1eCT7QRLtpNF/YkHCfqtjRPLMKaTz8w4Ig3NTS5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263877; c=relaxed/simple;
	bh=7s/and8BXraBp71fi3DNBKEfyJr0wkY/KfWCV83+/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JTqCV+D/aNkrkyR+oynBFgK01wAXNmF14Oj0NeTU9wh/TuCs8pOMdgu0jkrSl2SGe6b1Nckm9cEtImUWo1Itvo82phF2TFhsDXHCk6bBdZNg2FHPXff+fS662xv8bXswENIal/9/QmgPYxgIP+etuoMrDWaxyt4l0LDZLib2Rsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HANrX9Ba; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsr7rHOyw3PdjNYVhywYjYJDmp+1soo4pwcKa6R1SQGSh6f3T2vExIXKYLajdDwe88N++cLJfFmeS0MTzVlvmabJ+6Fth4yfqhwXMWTGTD9PZUWb5jymejoRl5U6tEJXTqRZ8gZQr2F8hr8E6OLXhwYptIRcNoEmEFbSThrvGSBXaH0Lt1YUlhp9R3wVUbqIrb8IkGRhicIAfl2e0ugMEtGzUk2hVEun946joDk9ZzLThP4LeLvqzl1yFSWZ0ckz8k0PB8aREib9MLv0Ceywq7lAuFj39nNvG22hrKZK8SP8uAf4HoKv52Iuw4kh2/M6NQGkDWocfRACtfW7kHa/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEUWLiiQAHCuFRLv4wGXlP4tgdUWXnqU126nn5BDbz0=;
 b=KyY4HxDafusO8fqmdd4kfmvWQF7yc7JiMjkKex7b3JO+1QhtFAJ9RbmZU/3nvtFSAUne5iygn4mIaX/BofSXSf7UD0IX3XPWCwtuWKJGJjYWFKOlFJ/msPgnrtt1NbzDSZJrwlegxseVi49MpVKbDBhpOeN0DiKMmNfnZufPBB9am9kqJ0ICFlUQGNAPy2N8EfZZScs8a/2lPCa2LGkI+lde137TIojbvz5ACnaIJNCiWPWile0Gmpju7JiE4ozSumo34OVj0Sr3zjLS8iXkfP/SJ6Q22kG0qeYM5/nFx0piS9azvo+v/ox3mQU8HZi8q2i4tKy/hucs3lu/S6Jmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEUWLiiQAHCuFRLv4wGXlP4tgdUWXnqU126nn5BDbz0=;
 b=HANrX9BaHcoxCTc0t/11i4m2Am+is3vOXt8lDv3xGkUZDnEUbH6Uam/HKfGphwTzvMxHXYDTP2lE0K1FmhQs0S0jDIgvM/a0DZX6MFz0EsfdUoF3GM/HiOQWr4ln7mYQSt/B//Bgptr7ISvJRJsv13RD1sNyrDI50LFUGxN2GS+c5DRZeOD7v2j9nD4WSV7dcTXiAxWMKj0qlJjulvzjO/Kgh8ctZO4XQECKANtL2NkT+6cNIXJVEyrWMkyRDR40rI5nYD8W+GOjF6PGdOk3B0E9fkAUip/fePphfntBixSZzymdWGYUk0wxChaACDkbjK/XzLpAC8HCJ8cwmNiV6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 00/10] Introduce fwctl subystem
Date: Wed, 21 Aug 2024 15:10:52 -0300
Message-ID: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0674.namprd03.prod.outlook.com
 (2603:10b6:408:10e::19) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: f88886b6-890b-46f9-9309-08dcc20c9e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQxggQy+hNL3aEbGnS1PCzZoSJhct2Hilo7Z40fp2pUB+Vx53a8dWm0ZwbiO?=
 =?us-ascii?Q?1LoNQy5DQ11ISR3nPTAaEF1u93JdwBabeYPmTEj61mWyqQ0bi1lsEkOFdG7W?=
 =?us-ascii?Q?WLP2uubVenmQPr48prx+0PJhCzI0+gKBFJmzKvDOAdWgOmqtsxK1nYRecbgw?=
 =?us-ascii?Q?CPxn0fNiaxGhCxn/Z5swV2WtyEEIrpQ3fEP9uq4FL7PyNIHETnkw5o3gFOdE?=
 =?us-ascii?Q?W/QkD7mvtWOto08atlyht5JWtGYlyC7bhyPVYcjto3PuBQrSgK89WzUZe9LW?=
 =?us-ascii?Q?bk7PHAm+ui1HYflcW1UNWy2ro6ZSM3KDV6bRMCX0OCdS+q2ljFFKfutJv/7K?=
 =?us-ascii?Q?jTTo9to8yjAKYTLPQxavw/05n6u6Zdoma1byzhNb3AqqknywpJLbBkhf/FNQ?=
 =?us-ascii?Q?KJPArYSdD9rdXga5XlDh9lVnkliQurZ2ff2sGl4ZUXufBMIQlEWg+vnEJhsm?=
 =?us-ascii?Q?Z3CAHRLvEeSL6obj1CO4UaXXjE0qyA626nMqkwZ+AVu/xs15xsK3grQUPMXY?=
 =?us-ascii?Q?8l1rlt6MWmv+XZZZdCkWDXtNRq9AJopQTbXMA24GX3BbINQIn9ZB84xRbcT2?=
 =?us-ascii?Q?ZkKdeQ3wwQJEF/HabeSNex0xMYXm6voShmXQsGdn6hcpNzn8TaS8WSvtQxAe?=
 =?us-ascii?Q?gKX9gTjYsaf2yuifq93ikuc4S4Bbe1QQ/dlmWgwCdlEvVoZpiBO80o/OWi9P?=
 =?us-ascii?Q?Z3dGtMZFK6k7+KQL6W0NEcT3ElXXDmvUJHSy1RTwymsjsnVQSWvMnOzudmsO?=
 =?us-ascii?Q?cDIl3XxRLhHPLkRUCqzECn1Yqxs+QeVd0b08aA6Pyib7pAZDbGtHpGDgQ8z5?=
 =?us-ascii?Q?N2a0cLvY/gc46WJghVCH4PKhnSq/sJTQpOIM2VCPqzTMpOteo+SrgrSlixYN?=
 =?us-ascii?Q?XWhpZBf3LUbS6wRqJNyaljyOkB+HnDM1vGmTAbkrWnHfSlrm0zZmo3D5tmEg?=
 =?us-ascii?Q?U7yL1ET/85TtnG0cMLqwOR6KC3HMSCSNsRPUun8LTxhCzmbaOZwYLpAXfW5m?=
 =?us-ascii?Q?4aszy9Pbco7R2sck++Wv0w7F+3RZBiCerWX8DCBHkKNtL0yx5EN48O8jKibK?=
 =?us-ascii?Q?CAMnW/s0Sevl4lVVtEkUkOmoBCkC2IyQ2fMYBH/DL82UcNcyoC59NrdIxSzx?=
 =?us-ascii?Q?KhZDTO6E6Mj5IS7QhNhz4RUXYFrpoUL9SNw07EhcoDJnNm3vgDOPdJPyxeUr?=
 =?us-ascii?Q?QOM5A6qQc6Pyx5ksDHsd7/xAm+dEnqo6shsMZf9Xz08ksVfKOHxxgR2/FfbQ?=
 =?us-ascii?Q?O4xbQ0wpCXFw6tAgnjLp0YLW4cdKZZLpvMvzAJ0fHrp2WQG9v2yAhnsvWYy7?=
 =?us-ascii?Q?leFXwE2GriU+Yz+hQdHS2DzJ/JIHdMxpwAE9mLn3AMXzvX3GjHA5Vo8+yNDh?=
 =?us-ascii?Q?zRkk6Qg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2BQ1A7wCp6cKC3ZhGv4SbQCTmrYf5qyBCMA21ETTTPVByUswl9eUptdbmTMW?=
 =?us-ascii?Q?8aSsvM+/BQMOmO7VFE31/K4/vBDWSrmdoTsqC2Os1k+x4kkBqkI6LZSkmhTs?=
 =?us-ascii?Q?5m81zHaGPZvDY+3UeDEbub4ljPgVi37God5tk08hZUyXHFkSJ+51bCBoqYC7?=
 =?us-ascii?Q?/I6H85QkB3Hcp11Xnv5zP7EDe+MCZphn1VZjF084obxwxGvAS/KMzr+R63UJ?=
 =?us-ascii?Q?WVSuLmXzY/ZgDoC+e7ydp9pr1BhEbGcs0b71bvZDK1hnlSH4TXBBqkwM5q7V?=
 =?us-ascii?Q?uOARSe/s2GxmyQmyn/mlkQWu9AyjLBlhMAxluL6nLAT5HHi1VEiGDP0f/uxu?=
 =?us-ascii?Q?uFFupyPDbMWeOykkmEdvBQuh25LNWtt1vF7+ZGNv+bEDilxn8Mh033lJ0jFO?=
 =?us-ascii?Q?zvzOiQKCc4uvxrp+h1Jk82wz7YqkrTyFjqrw6g8/vEeJJ1v+Qv2yLueoNNB3?=
 =?us-ascii?Q?qgGOv2By+Dqa6rSWS+hbQEbVKOqUxiVF7glZAGq1zrO9sHTVWvYXcv45wZsk?=
 =?us-ascii?Q?OOYxsMXukv6ssllVqZ4K3Osn7XPFrNHtpsY+bUuMl0FHwXqkdnpSTlDIJylK?=
 =?us-ascii?Q?g8V6eoe3kPd47VDuRRp6iNXyg9Lg+nM8bHFeIh/hzI8lPyhUDnmx0vq6l7uA?=
 =?us-ascii?Q?X2npQF+jL5jN+3NU+nHlQIB2W5ONxvA3DGQSCHCXNkOYVet5K5drBZ+4xlPj?=
 =?us-ascii?Q?5xDKMWjn0yeR/l3QFXsGJYrLkfR83FLxs7ovj6pCCqYqxYwzq4AKtOvnBqQu?=
 =?us-ascii?Q?VY0SS4kNqB4myLUp1YXvpvmuTXJw6NPxWrBjYAeNRG2fkWgtE32/7XETFJNO?=
 =?us-ascii?Q?C6dZRST9MuJa86/Yi5p2P1SP++plwXXy1zicptys+UvdEbOLEs54P6i/koOW?=
 =?us-ascii?Q?8rPcV8oD3Axfyp/CTiTrH5QWLuiy3paeiCRMi1gH6he/+a2MxUfJuCg89pHB?=
 =?us-ascii?Q?wDeTuo4WIzBlj/Dw0BoYFz4o7BUa1DENjAh+VjNmhMGbZGfCk8QinByb4P7i?=
 =?us-ascii?Q?nK9e2GM3Tc+JphfH+KjcqRsG2F75rJUHTv7jSXaagiLqDAdpSx605XGyDhYX?=
 =?us-ascii?Q?pAeQbO0uHHH/TS+b+ZoDhhlMZ8Lr0C2U0Sjhi2DSmJQ3LO82HFSMwc6yRZo8?=
 =?us-ascii?Q?qXoCTMiB3Znl4A7y2FlZnvjhL387sjCgFbnbzuuurcijRBOvoNItoW+B85Xw?=
 =?us-ascii?Q?uxZz9Hy2CL4ngaGM4MQ5VODSmalQlOvGYwXT5oMngXj5umn5eV6e1KUxXJ5F?=
 =?us-ascii?Q?097d60ILtKxLCAY08nLSk9iauhKvdHRUyaIs0OgGwydeGIGQ1mzYi/b2bFxi?=
 =?us-ascii?Q?yTMsY4uRgqZb/hZiXf0VU7ThFYd6/me7Vha9QIUHthDc4ughK9k55Sg8+5V4?=
 =?us-ascii?Q?x/9Q+JCyPkABSNFTMB2RnOUmlXE2urbBCzLZFxvluMLU9FCQmaDyWnDj8lpR?=
 =?us-ascii?Q?moiCgKrw+5eeKUydhE6vhOtTa+5idFzwruUkbw1ovR1bb/BRs1Kw8oSS+Xta?=
 =?us-ascii?Q?flCDlPLkzmiTtLatIroldNZZK5CWvN1jxsqTSQQ4+PiymmgkYBLruqbu5/Mt?=
 =?us-ascii?Q?016lOyUPtgWbklptB3bJBzjirLxL8t/SogOLotrO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88886b6-890b-46f9-9309-08dcc20c9e56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAhcxasGXLHW+qolaRpJpJibqc/3s2+s+FWRQxw6gRjtFkSsFp9Je5CVTiT5hHR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

fwctl is a new subsystem intended to bring some common rules and order to
the growing pattern of exposing a secure FW interface directly to
userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
exposing a device for datapath operations fwctl is focused on debugging,
configuration and provisioning of the device. It will not have the
necessary features like interrupt delivery to support a datapath.

This concept is similar to the long standing practice in the "HW" RAID
space of having a device specific misc device to manager the RAID
controller FW. fwctl generalizes this notion of a companion debug and
management interface that goes along with a dataplane implemented in an
appropriate subsystem.

The need for this has reached a critical point as many users are moving to
run lockdown enabled kernels. Several existing devices have had long
standing tooling for management that relied on /sys/../resource0 or PCI
config space access which is not permitted in lockdown. A major point of
fwctl is to define and document the rules that a device must follow to
expose a lockdown compatible RPC.

Based on some discussion fwctl splits the RPCs into four categories

	FWCTL_RPC_CONFIGURATION
	FWCTL_RPC_DEBUG_READ_ONLY
	FWCTL_RPC_DEBUG_WRITE
	FWCTL_RPC_DEBUG_WRITE_FULL

Where the latter two trigger a new TAINT_FWCTL, and the final one requires
CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
would be responsible to restrict RPCs to the requested security scope,
while the core code handles the tainting and CAP checks.

For details see the final patch which introduces the documentation.

This series incorporates a version of the mlx5ctl interface previously
proposed:
  https://lore.kernel.org/r/20240207072435.14182-1-saeed@kernel.org/

For this series the memory registration mechanism was removed, but I
expect it will come back.

It also includes the FWCL driver series from David:
  https://lore.kernel.org/all/20240718213446.1750135-1-dave.jiang@intel.com/


This is still waiting a 3rd fwctl driver and the CXL side to finish some
of its development. The github has the necessary CXL precursor patches.

There have been two LWN articles written discussing various aspects of
this proposal:

 https://lwn.net/Articles/955001/
 https://lwn.net/Articles/969383/

And a really giant ksummit thread:

 https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/

Several have expressed general support for this concept:

 Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
 Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
 Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
 Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
 NVIDIA Networking
 Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
 Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
 SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com

Work is ongoing for a robust multi-device open source userspace, currently
the mlx5ctl_user that was posted by Saeed has been updated to use fwctl.

  https://github.com/saeedtx/mlx5ctl.git
  https://github.com/jgunthorpe/mlx5ctl.git

This is on github: https://github.com/jgunthorpe/linux/commits/fwctl

v3:
 - Rebase to v6.11-rc4
 - Add a squashed version of David's CXL series as the 2nd driver
 - Add missing includes
 - Improve comments based on feedback
 - Use the kdoc format that puts the member docs inside the struct
 - Rewrite fwctl_alloc_device() to be clearer
 - Incorporate all remarks for the documentation
v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
 - Rebase to v6.10-rc5
 - Minor style changes
 - Follow the style consensus for the guard stuff
 - Documentation grammer/spelling
 - Add missed length output for mlx5 get_info
 - Add two more missed MLX5 CMD's
 - Collect tags
v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com

Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Aron Silverton <aron.silverton@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Itay Avraham <itayavr@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Leonid Bloch <lbloch@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Dave Jiang (1):
  fwctl/cxl: Add driver for CXL mailbox for handling CXL features
    commands (RFC)

Jason Gunthorpe (7):
  fwctl: Add basic structure for a class subsystem with a cdev
  fwctl: Basic ioctl dispatch for the character device
  fwctl: FWCTL_INFO to return basic information about the device
  taint: Add TAINT_FWCTL
  fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
  fwctl: Add documentation
  cxl: Create an auxiliary device for fwctl_cxl

Saeed Mahameed (2):
  fwctl/mlx5: Support for communicating with mlx5 fw
  mlx5: Create an auxiliary device for fwctl_mlx5

 Documentation/admin-guide/tainted-kernels.rst |   5 +
 Documentation/userspace-api/fwctl.rst         | 285 ++++++++++++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  23 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/cxl/core/memdev.c                     |  19 +
 drivers/fwctl/Kconfig                         |  32 ++
 drivers/fwctl/Makefile                        |   6 +
 drivers/fwctl/cxl/Makefile                    |   4 +
 drivers/fwctl/cxl/cxl.c                       | 274 ++++++++++++
 drivers/fwctl/main.c                          | 414 ++++++++++++++++++
 drivers/fwctl/mlx5/Makefile                   |   4 +
 drivers/fwctl/mlx5/main.c                     | 337 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/linux/cxl/mailbox.h                   | 104 +++++
 include/linux/fwctl.h                         | 135 ++++++
 include/linux/panic.h                         |   3 +-
 include/uapi/fwctl/cxl.h                      |  94 ++++
 include/uapi/fwctl/fwctl.h                    | 140 ++++++
 include/uapi/fwctl/mlx5.h                     |  36 ++
 kernel/panic.c                                |   1 +
 tools/debugging/kernel-chktaint               |   8 +
 24 files changed, 1936 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/fwctl.rst
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/cxl/Makefile
 create mode 100644 drivers/fwctl/cxl/cxl.c
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/fwctl/cxl.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h


base-commit: cd0c76bee95e9c2092418523599439d2c8dbff7e
-- 
2.46.0


