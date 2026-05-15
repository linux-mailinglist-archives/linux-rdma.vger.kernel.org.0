Return-Path: <linux-rdma+bounces-20776-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOlNM0xjB2q90wIAu9opvQ
	(envelope-from <linux-rdma+bounces-20776-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:17:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A493556087
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C220831D61AE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167E3FF1C3;
	Fri, 15 May 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBdzyCeF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF23F4123;
	Fri, 15 May 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866218; cv=fail; b=B2oEzYhiTEtGoVN5Nfz0S0zdPZGaf2Hf5s+uqpQoQwEwB58aNCeDIjzf3ZH544AvQhlveXdpC9i540q/hyZgjJAaVHDQ9XN0yIQ+eSAQa4hR3qCgR1ZPaFgV5LpVeQNve4CwmauNOUY20RJTn9KL2j0/LQxpr7tScXvBgq8Ui90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866218; c=relaxed/simple;
	bh=7wVO6pjljpjB9Qrv36KzgjuLUlnDFSUNq11YYWEzuMM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C7uQ5X3LLQbaOgAnE7OCDyunT6rd5FggW4pzEVAdXYBw6LOlnLIS4yVAfPuhni47TjVYc9sjurQC3r2Z790bPF+hGYRPOZRhiOFIS/Kv5Cy6h3+ZeOQpXgG/UY5yQL1KodmPv30s+8L2w/PeouysR1/IykC744+l2MMBvkLfryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBdzyCeF; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io4BFYzGhb/J8TCTVsJyyW470EEUv4JpZVkdyy33Jx5WrNA2Ef+/jcwm5GKepJ15TbFJuiVtq3XeqxUtUOhbvlXKvO89YCJ+fLyN3+QPv5YEUrp+OTYjI+be85NA2s9pW48hcXxPfjsekb2n+jmvahynqzRPrT8y+r8wvMyDYMb5Dydjlm+v30Ht4QJMn6MLmLepKFU1BzQSn4JUXl8w0kCDnDdg71gdHBzjtrgJdnEOcWMkla3XXAAqr6nyg9Z8SV68ThDYgrd3G2U2ZEXvT+CP1KzRlaRjGPfcBUf8QF3ui3btVrtHw+WN9lovOFO0c2srn7GjKsNLOdM+Dp4hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3B2DNm/gKf04gTuN8Jf/Ryvp3VTJz85FbAZh/zXLoU=;
 b=hEGGA62Y+r20mPGS6xsquAOXAInj+JK+MNEvaql6UoEVNY89wZh3349tzR4PhckyagV5e1UQgLp1fkb8IBdNg2r78xCLd6CP+RslTueemccDmmlmB6OCHD5oAC2iNXhUhMZZST0bpEVMXtWHYCdehxuhOYTS2EEd640CD9VX9aw5ImJrfmlEVNvXsOw0HLW2yA1q5oYsZ5yPx4o0lUDOQstv0yNOoB9DlXxmCiyzN9uEN6qurqqXQuwivp9ryEVlVVJImjsy337niUUHD7sUTtGF/mb+psfvUc0VF7FYI8mvxN1D0hWaMArF9v0DazzXgGIa6vLzD/ihLUZiZkef0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3B2DNm/gKf04gTuN8Jf/Ryvp3VTJz85FbAZh/zXLoU=;
 b=cBdzyCeFlwLj2hNJbuBRA0NCGl3VSUpDKLg8sdMGVe/eiA0IVJwN5WueGrgZpAbM4ASoGVRopN6HyNQd7GKhXcaQtG2I41dcw5+fKHyn8feUxc0Aruied2H8SvxxJswG8yKanZ0P6BOGCvBfSMgV9tvYfcRiditmjUuzytVXbJduaMsi7T6RMxvLwLF/RL34VRceMERHCBa1Kqmes3ttd6goLtl6AMgv6Ni+SBXhvnzAT/dEGlUVXjHh3SuXinGLarQwNGjfdJPUbSBKJh3gwqFoxvwc4fdRmBn5sZ9Xk5UEi8QMiUtPuAllbk8kKaUJ5zu5+i93m17E3829UPUCfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 00/11] mlx5 support for VFIO self test
Date: Fri, 15 May 2026 14:29:57 -0300
Message-ID: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c3457c-726b-491e-0198-08deb2a79c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	2XtgMRcxdx6UfrtLnwm9RdattvUHf52OncKKKUn6VYwYSR6DUWzCX6G+6nQzEM6HYBg3pAJN7bo4B1qM2JFuSuGkT9Nudmq5PJ6GWjEpXNWt6hdvQ9nLLC+cVHJPQTEe1hnSbFVeiQDU40At3ue+pDkuzFWfpXHOcmyrwhFvoa4qqkSp3oSIUr1M7TiMzFyles8/KxWkkDcNUqCtSKVXEJru5hMIuR8iz8t9nqs8ATeOFxBGU26HDgc8RCRAr5yK39TzxODaLb4OImhFXFohf5riQuxzMYfX8xtqGLP50B4Vz2sSczqYdSCXol6SwL3mmqH7qzFjrEAWioCk/kBFkVH/LVZTelmIJiH7f2bLG9OvJmVVaQsmLF0Ai/ChHcJG54D8DxDoZhKuHgZhIIpW3ZCgcHmLS3JlfdAZarEdCxiZOODGk5X6rqWVh9QKNZ4Ut8nc/wucGz2iHHu/21eaMSlqIqFMUPgVjDpjrOb+k12rmCouO9DeHG35kRZL8OsYJWk1mFfLBlwriyrhNJCGM3/d3NKPxfVOtNi0i7bAN1dsExC7Se3nxFLQdNhQ7M/Ewv3bc3+f9OLESpf3Lic8wqB+uspEMRE4/mg+36wET9zyk2uO8+hYsREMb4GwUb80cqSVaoZ78VKCFaZ25A3QFsi4IhtXw+Kx+E/JLAyHMuCnohu7MhEKV0oPSuUC7xEvShuyzVJdqC6VjE0c8pkCS55sK1lko4tLiXMRqPSlPKtnUw5opGcCgYVkRWLQrjND
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAHkZeIHfWWGUOYeApnej7AIwI+wYUrkOPSzgonI2o9SDO4omVS8OhZj2XXo?=
 =?us-ascii?Q?DxPcA4eJTuDzeIxMtOV31yycUsaW+VXtN9r9pkIjxuH9KRaQiv/3mIOY+D1T?=
 =?us-ascii?Q?5OYB0trc/JiplAIexkj8NtwK1ki/LOrfal3USUdj9HbQ3YMieZ9W4J2rDmKE?=
 =?us-ascii?Q?pViC2XIYWBZaIF71GRYpGbPxtqgnMhjcNrKxcAajhtKAiViAV8Pn6aKC4p7B?=
 =?us-ascii?Q?RX0Pwy3bIJuf7ynO1lj8Ix+KKzpKe2Winf6XcpL4T0+npTmMGoUho9bxAslC?=
 =?us-ascii?Q?t+NSU4l95CfA8US+eMFDbblVHF2tav6EZ9VJze1gdnZsKfIhtGENlDPzySnX?=
 =?us-ascii?Q?RhMRyJDOvKr2EZJ4j/B0jbBkoJ4P0/sZVctFguy3NPUFrdjcXrLZLXEoBRPV?=
 =?us-ascii?Q?oLO/ZOFY1tmV/IOJ2IAKlqTiuq3t823mUhEzXzIIyp6o+H2DIumpOgNFZaff?=
 =?us-ascii?Q?a8/Kit96hdThAMujKHacq7cjfbMFhpZpAwCbrI9Xhvtezudf9ZO2Trl0NZwC?=
 =?us-ascii?Q?cErtN+CkpiE+ypBo1D4vNxbyJPW3cw2yw46+ZPqFRULwCYlWcJIFdKDHZZiM?=
 =?us-ascii?Q?zJTb8c7u68wsPCV9CQwoLEDucI4rsoWjNc+eda3c42if2SJgao4YtQyy8iVM?=
 =?us-ascii?Q?Au7E69Wx88sjkSrJpNgr408MCqUPMc9TQnSauJV9pklu7eKhZm4e9FlbDgp9?=
 =?us-ascii?Q?QWvYupQZPJM0hX1/wQGT8Q7PMAUdoGbbR+EvNwiVaVUcn5lVLlZbJnEVBGfg?=
 =?us-ascii?Q?2SE8KTDv6xPV1wqMd/NRXLlRSOM0yqNUoiJ4f4pWedL875BondTsne4Vw2AT?=
 =?us-ascii?Q?l290au/nSfVVGzjTqJ9dmUhsUbSkSpi+R02m5QfQeL+styp2i7k+4OO+6A6z?=
 =?us-ascii?Q?qdD2VtddA4KRtZ+f+CuTMzOZAZsmLHvvIMQpaMeygNFYtw4EoOrQlX8kZS8k?=
 =?us-ascii?Q?5ZrR9frcb3VQgs7MSqRRo7kOQKytT6Wu3MB+1JmsqNatIAxpj6ysRk08vMQz?=
 =?us-ascii?Q?qyenWW4GWgeDz7Xao63TJNzQbsFcqzLWUwWisv5ZeTMbTyndTmi7DLyUCP/N?=
 =?us-ascii?Q?Bv/qKLeAbvBjhGqx1+mXv1S5eIzACkZcvKHVixZRgT3Fkfs1iZEdcSSu3CL8?=
 =?us-ascii?Q?9rptxdSdqQjl3KY4GFrxCdalpAMyGm4BXNFniZs55g9W802l8+Jk4Y4tcqQ/?=
 =?us-ascii?Q?hngwbkkQH631Rapb5XllroID2iQBPB+dpyK8NXgvPdqmW33pxWYdVKFmdTWX?=
 =?us-ascii?Q?9EpC5itc2G2sjnbs9/+rAAcSJBq+W9jFrNqOZTDqnP1QHEcMsk5dPiASr64D?=
 =?us-ascii?Q?vwDJe1A+ArCmFNhQZegIL/52i876jfHIbcIPfiSxDgXnvh4Zalti1BPTOAMd?=
 =?us-ascii?Q?lbNzioAvoX9Vej496HrwCYjWTEye5QVZbyRpdbWpNVTNQS0ObTUjO/zL6PwZ?=
 =?us-ascii?Q?SfGby05XdG4jIm+c6pW+hha4Fyb/MURC5vaJYi3X+E5LrC5XpTo6DrB1PGWU?=
 =?us-ascii?Q?1VUD3g+bzTfIa+IdpuF9MwzN9/4ZW9s0NInJ9qKPpVl70HuXM0DfkrB3Iofq?=
 =?us-ascii?Q?mCBPxu/+zlv/hvDYT59gwOMsxgdVWald9IuHKK6w+Y/2ahL9eMSTsP0TiYKr?=
 =?us-ascii?Q?X8/zy6dCLLSMPvqwqHOZP0U6JeWhGKzsdiOuXX+NdMhGBdvX0GRfl0dwOn5R?=
 =?us-ascii?Q?TTAkD0asAQBmzGdIfjfcKxoVehtTXHCtlm94yPxHkeITPqsE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c3457c-726b-491e-0198-08deb2a79c9f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:09.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBT44VxWstakl0Gr2ApwPF+1vZvlWlQUVE6rWPOXSTTkgNgu1vU33gt7UkaPdcRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: 7A493556087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20776-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim,msgid.link:url]
X-Rspamd-Action: no action

Add an mlx5 driver to VFIO self test. This is largely a remix of the
existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
to issue RDMA WRITE operations which effectively perform memory
copies using DMA. Since mlx5 has a stable programming ABI this
should work on devices from CX5 to current HW. The device FW must
support the QP loopback configuration.

Also support send_msi by arming completion events of the RDMA WRITE
to trigger MSI delivery.

mlx5 device startup is very complex and most of this code is just
booting the device, with a smaller amount for operating the QP.

This entire series was coded by Claude Code in about 4 days. It
used about 4.5M output tokens, 30 individual sessions and 5600 lines
of AI-generated .md files. I spent an annoying amount of time
de-slopping and cleaning its work product to make it presentable.
However, previous VFIO drivers have taken on the order of 1-2
months to write, so getting one in a week is pretty remarkable.

For those interested, the flow I used was broadly a prompt sequence
sort of like:

 - Hey Claude, go look at the falcon series, VFIO self test, the
   mlx5 driver, rdma-core and some PDF documentation and make a
   plan to put mlx5 under the selftest.
 - Write an rdma-core application using the built-in VFIO provider
   that can do the required memcpy operations that vfio selftests
   wants.
   (This resulted in a 1k loc C file that compiled and ran the
    first time but had a few bugs related to device programming
    that the AI resolved.)
 - Replace the rdma-core components with open-coded versions to
   create a fully stand-alone program that does the DMA memcpy.
 - Review and audit the thing.
 [Pause and de-slop it]
 - Make it work on a PF too (this is surprisingly hard!).
 [Move to a kernel tree and copy all the .md files and .c program
  it made]
 - Hey Claude, look at all this stuff and make a broad plan to
   actually build a VFIO self test.
 - Here is my 1 sentence advice on what each patch should look
   like, make a detailed plan to make a patch for every one.
 [Pause and polish the patch plans]
 - Execute plan X then commit it [pause and de-slop each patch,
   repeat].
 [Review and final polish]

v2:
 - Rebase on v7.1-rc3, drop falcon patches
 - dev_dbg checks the format string even in non debug builds
 - Sort includes
 - Adjust comments/commit messageas
 - Use linux/pci_ids.h
 - Compute the driver.max_memcpy_size the same as mlx5 kernel driver, it
   should be GBs now on most devices
 - Put region_size into all drivers instead of allowing 0
v1: https://patch.msgid.link/r/0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com

Jason Gunthorpe (11):
  net/mlx5: Add IFC structures for CQE and WQE
  net/mlx5: Move HW constant groups from device.h/cq.h to mlx5_ifc.h
  net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
  net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
  selftests: Add additional kernel functions to tools/include/
  selftests: Fix arm64 IO barriers to match kernel
  vfio: selftests: Allow drivers to specify required region size
  vfio: selftests: Add dev_dbg
  vfio: selftests: Add mlx5 driver - HW init and command interface
  vfio: selftests: Add mlx5 driver - data path and memcpy ops
  vfio: selftests: mlx5 driver - add send_msi support

 include/linux/mlx5/cq.h                       |   10 -
 include/linux/mlx5/device.h                   |  231 +-
 include/linux/mlx5/mlx5_ifc.h                 |  178 ++
 include/linux/mlx5/mlx5_ifc_macros.h          |  185 ++
 tools/arch/arm64/include/asm/barrier.h        |   18 +
 tools/arch/x86/include/asm/barrier.h          |    5 +
 tools/include/asm-generic/io.h                |   28 +
 tools/include/asm/barrier.h                   |    8 +
 tools/include/linux/stddef.h                  |   10 +
 .../selftests/vfio/lib/drivers/dsa/dsa.c      |    1 +
 .../selftests/vfio/lib/drivers/ioat/ioat.c    |    1 +
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 1928 +++++++++++++++++
 .../selftests/vfio/lib/drivers/mlx5/mlx5_hw.h |  114 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc.h          |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h     |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_macros.h   |    1 +
 .../lib/include/libvfio/vfio_pci_device.h     |   10 +
 .../lib/include/libvfio/vfio_pci_driver.h     |    6 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |    2 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |    3 +
 .../selftests/vfio/vfio_pci_driver_test.c     |    7 +-
 21 files changed, 2508 insertions(+), 240 deletions(-)
 create mode 100644 include/linux/mlx5/mlx5_ifc_macros.h
 create mode 100644 tools/include/linux/stddef.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_macros.h


base-commit: a9fe1263579aef5796ff68538b24e228ad0665df
-- 
2.43.0


