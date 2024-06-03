Return-Path: <linux-rdma+bounces-2787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703C8D8688
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0C51C218D2
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C961353FF;
	Mon,  3 Jun 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRaiPf60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37843131E33;
	Mon,  3 Jun 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430015; cv=fail; b=FzLEc8V25ZscOf0zNfd79MmYre1bWq5KHfdk608lsy5Cd+895mEIfcczo9DEgmhnRGQoRV+8RyMJ+dRQFYuSnKCwRjU/r3NDYXB7Zp89kzaIgbrPNTxfmctn5gcamwltTKwhn0mFSsxVNXqKKAkDFOVX8QMlwcMnrETGZ0SxxCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430015; c=relaxed/simple;
	bh=fbgX+Nyt7kY71w9xcORixppx9MgoGB69W098xJk/EAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHLaT8k7YLdsI8BIeuVpVjCVKUUhM110MvlyLvGBALxU7BmeVTxDLvw+EU87txGa2FKPzFZWBVnlO3sbE3ojGLC1rTvli5+8ftn8Pt2utnRQTixvWpkFKP3eC8cs+katNWtqlfqbHPNmQexumre7kif25u/3qKH+p5xmr9BqgcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dRaiPf60; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ittivMfQdKEBg7TCE+Z64gKTzOt5jtaFVwvqIA86nlC7u/AiP+xHSbfTTUqQjvnq7JIpxU5eKKzifsjbO4zAbqfLpL580zESagc+xF24/39XIp7hhp2kQh2za0bnuh6YD31erhYJfihNRcZSSxyb57TrW5Sh4XO+A5PkUt9m3gVTiDDQqUeOIvbgNNw/6OwYlhpNZkI2z8m/02Ql+FMG+v+kKkU9Y5IuWyhUoxVTYj1Ts26CcLKkNl8ks2QWMBeK/lccSNUs7pH3rg/oian/BTJKKe9zOXJTMWKwNYUxzi/SD99jVZede9iZTGOsYW88gFc3INT3lK6BkesxEZd0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQOymlnr7phvCmJdHapc5xBAi9V1NAAiP03KmhkrAC8=;
 b=mmbnoOQdtti+UXuLBRK4VLpQ/iqN2UqWPckUiBcku8BZ0tVPgwG98PeDReEoe2odTYb4wv9yI8ySzFuKktwyEIo83E8jPrtyZ9PJ7soITQNymKEIUm0FaG8VNEOT07scKUuQAzp98S9iRrMzsWihQ9DtNb/65eCV5i/rk3sIuz9y4xIVEdgEn2pjFrkEvIzbVHV1vFK3GF9Qg9MGM9DlgOxeYHXCJdHL/bx8mr4ZR5L5jvSI3pthS20pVb7GcWEC0cYN7lBgJhU9n4fcqYtTfrrR9ImhWJOeaUnwyBK/mZo0WcGO+HDH+czX4o4MwhiPWvedwq7TFD3T+cTmJJZzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQOymlnr7phvCmJdHapc5xBAi9V1NAAiP03KmhkrAC8=;
 b=dRaiPf6082yc+IZamm1Zsifr8Q1ksRZrzkMPpzT0xjNwbhlcxx0MC6P5elhxsXQGHQZkkjejuqS1l5yRwA7md37iaHpqlpjkmCHo+vZ7Jc22v55pxw4oYQFoBkK3lJyiaNkc+Obr1HrIjkgKejsKDpmbtpSQrZvYu1NnEfVcbOBhmlxXvBWsTJCquAf6OmYX2WVfrcnwoPit8zYSo05BZtaUPDB42/vJ8c0P+QSVIAnaLFgze8QK3wO6ibR3cbLKQRWJP7QR8nq0vXgWBbbTY88qPbKpH4yITB7J8LZTuKMYKXz66aBvxWbctsZVFG6sgH+K7ku0mRewqBELIlF8UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:27 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
Date: Mon,  3 Jun 2024 12:53:21 -0300
Message-ID: <5-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: b146e37b-838e-4a4f-5d46-08dc83e54e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?kArUCnQsRr64GjWROLLA83UT5ggf9iMYC8fcX9vVhD9GbR/P9VEw3cIBibwt?=
 =?us-ascii?Q?UhYf7wpHZGFDAKr6UatduZ26Wdy0Un1La2Yj1iO73Gu7xuN0MT0WPNnBwVSQ?=
 =?us-ascii?Q?gde4JZjiD0WfTeWTjIduZV5uh3XgwxqerVdTcn5N94JU4r6l2iRqZlQooH3z?=
 =?us-ascii?Q?91jzJv2hSH6e2/mCUJiSh5O/YXbPwf9VonBMuTgfO5fSySHOzBqEFwoQ5oSI?=
 =?us-ascii?Q?MUvHGlek0eFYsxV7RFTuP4XQBwk3OKpn4vTmG3Dkjf39A1RpcugFARJsitFU?=
 =?us-ascii?Q?BmzVbz69CKRWd6yRqFLoz3wHbO/BwnT2ag54o/8eXb9N1grkWUwBVHO7RcEK?=
 =?us-ascii?Q?A6t/DmgMU1l3IJmHPEya/g6uBNew+3FASQAKrLOKkCRsnqfR/qDEoa+CAdUJ?=
 =?us-ascii?Q?veR6m1e6nXLkNf0jRog46OSY5rOWdkqo9thuzp9D7O0Rec+Hy4MEyn4QIMdU?=
 =?us-ascii?Q?EEntzGHGVPYOQiFVLYmO30A0VcClFYb2iz+vh2KTRwhWrQCu/kugdcS2O2/F?=
 =?us-ascii?Q?rmEUyEsj4oPErzPC9kK5gyluOdKP5jn7l1IBh9vM0X9Vvu+AC98LC1w3Caem?=
 =?us-ascii?Q?3iYmqIVqBPdaCPwU1hoBkN2qWjDBMN2tespnVJIGxJkyaPo0/4KNjiZvo0Zj?=
 =?us-ascii?Q?6x5XPXmMYHOpWQnaTG70jBeEOZvzw9LbJcpgATma3JxsGaiEAkQ70YPPGL+t?=
 =?us-ascii?Q?VvK7q3FGt7jkIPHHTEdKqZQEI+f8JvmQJFU4q3CAQSbiJzWta7pxVKkUIgeP?=
 =?us-ascii?Q?47UPYGAI8e3SbzNuzQHcwr6qLj3VthcqkWnUYxLWFDWtJi+rNod/qrAIk10U?=
 =?us-ascii?Q?ejWrNGt6vpl+MBJugQ291I10fGFLSNvFP8vW4No5fsEC2VTi0TCGdaCWUw5B?=
 =?us-ascii?Q?HiGFXjdupWCrAACTV9/npyP1yqbFgpE0g0KsQCikJ9BmbMx0rSePv0w5AQOC?=
 =?us-ascii?Q?B/c2WxBk9sMPfpGzo1G9PYwYeIJaxWVXrDkh1yAoeBTrCcU7Dn3qZdnEJUo/?=
 =?us-ascii?Q?llJOtZ01NM5lQpcszM57s3yrtkbmUhp3h05/2FdmN1FNEbEQcS0JaRUhyCyJ?=
 =?us-ascii?Q?47gL+xNgK3mgWIt7TVJJHMxTHT3ZknXolLGtlLxXXsDCiE7otUXebFlykgg2?=
 =?us-ascii?Q?9AmZSP5sjxHjmAQzGytv4250aaOmGDEI4bY9hIGf/mA74CfnvUIJjDaTU5Jb?=
 =?us-ascii?Q?FSWy6uWpkcM+5tKkJboUYJ5fYEC2akTJNEM/LM6jTS2pfV/4+3slHmz+HBj2?=
 =?us-ascii?Q?GOtWcQ2LOpaWJFkSOh0JSkDaI4lTGYvFTnkXXfxxLTJ8xvZBT7HVFGiXO5gF?=
 =?us-ascii?Q?ov50FF08Ai6VjARGIsRNZdgD?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?H8H9hMOK39MV6SQjfMhusmgrbKtKJPP9kghMqentDDgmiatpJH3txtQqEYc6?=
 =?us-ascii?Q?lXjE20eVnX8LVPcfwWr3MikGOu+U7DKlvopfXg3FARmW2cRQBW29xcINNF78?=
 =?us-ascii?Q?1ouWYI7k4jFHMb/mR6yx3O0Jp14sefThesfku+RARGQ2lE5MG4Lv3V1G7CfQ?=
 =?us-ascii?Q?AvlrOjqki39BBUA9N/Xe9h1NgdTEBW3ay+VMQwu6Nn2kfLpf8Spe+bZmPxnN?=
 =?us-ascii?Q?tMsN8MUY79UDPXYzgbfEIpBzDnoIuYYfkjNtlkhK9F42QczihaMvVrHhaoxC?=
 =?us-ascii?Q?woCpH8JH502eQn4SQwT732o2/1su8alM0akwqhhSL6tclgcTYCYkhMofG9f/?=
 =?us-ascii?Q?QTcW5GhWGu59jukez6/p+zkW5JIQNgxWLMvF3E3pQ6AqZi3f4RtAZf+3vG3I?=
 =?us-ascii?Q?Xr+QNCTAg8z3AdhETM7aFoSbqKyi3muc5l+za72MTlAOQxJ3gspkb9G+oVbn?=
 =?us-ascii?Q?mb5RjCLgsFrznhtjYSEKavSxv8xDHAILI5E0fxSQdRXK9A9mfaOo9qRVISes?=
 =?us-ascii?Q?5VBMMJV2Gh+IkVgXioFQAhk7zFl6ENpBln6nwgCOmdlPrnG+VmSDte7x5SL6?=
 =?us-ascii?Q?vAM/u3e74l0WPbe8TZp2j2kbCnNiBia78JRqN4/cK7u5To2R3BZHUNq3mkjy?=
 =?us-ascii?Q?Yf7ZoYnEtB6MabehyBj3jldsvrmd1cOlLHoaM3J2HSUFs93ezuhQLumWlbkA?=
 =?us-ascii?Q?5fFYDMZgDEh3xcIrWVfbR4zgagafZfKyE5Lv09NwRmoavvMAKNFo0L0gz0m9?=
 =?us-ascii?Q?2O/fIMxo6Oi4miq4D5VRIi2k+P/NHHxKqv7ac1GVW0enWyPye+XvsiVUxR3I?=
 =?us-ascii?Q?qF2F9dMTsHGGaqlvJ9608KLBR9oG3B4RkAI1jg8n4qJgjnn8WhYRFdqET6kQ?=
 =?us-ascii?Q?8Th9kEx/gfWNMkoP/g7BwZUEHYehIvPUCaewJBKhu3cEsfEj+ddVyTppPp0h?=
 =?us-ascii?Q?ClTsOtMvbumiqgHkkzt0wY3lPzij0X8dtNWZZ61s8nVSkKxhqslmmC7QiWqY?=
 =?us-ascii?Q?b0HjI6nVuw795qu3E7uBQAXG+7zNBJujNuJnzPB/XyEu6Qg5uIMFZ58T3a3n?=
 =?us-ascii?Q?Q32+mbmtwgidHIYRXgOCt7iCG/MvUv2jqlyyO5rhSl9l8vAtc51BDM0Rms5W?=
 =?us-ascii?Q?t7lByn+Ce9ySIdsKfC5XPGsOyza7/ofeu9He/qN0m+I5BFGnsAtOhLqwQopa?=
 =?us-ascii?Q?ubcLIR9Z54bq6kEOgHc+UkruWXGfEsWzFOBhCsFt8k910u8BK0Ww4uixxoI5?=
 =?us-ascii?Q?7m/uGLyZbwGQ+wiX646oyXivVEA5Xe0edBBF9cQXN2egwIY8373At6tq612x?=
 =?us-ascii?Q?6zJ1f/NTN7mJGhKqFzdbhA3UsBxCBbceMopkJqrNcQzAS7ZmfeP4OP6ud1Js?=
 =?us-ascii?Q?ql89V9DjU4crBUBnGPZRqJWPQjMAMC9pZbv7P2dXCN5fhog46sIEK/WSPWt2?=
 =?us-ascii?Q?fLMN9saujguGaWdVt1kNTmdRQlFVJWjfA5JH0EhcY/EVcFDx2EVR3EjY79mz?=
 =?us-ascii?Q?tJ9CGMtxv5+5mCCoNDL/sNTPXHXmtMD/QCBptotr/jAO22T/PoXCNwtABNdM?=
 =?us-ascii?Q?hrqlLTa5KaEsIAL/mLguE2o/c3I+q7wf+o9xY6H6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b146e37b-838e-4a4f-5d46-08dc83e54e05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:26.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6MYPO4sL3xCsd5mn6ETXcSaOAcvpdgSdyusEb7RYjp4InfJKZJuHMJ3doMVEcnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
firmware. Drivers implementing this call must follow the security
guidelines under Documentation/userspace-api/fwctl.rst

The core code provides some memory management helpers to get the messages
copied from and back to userspace. The driver is responsible for
allocating the output message memory and delivering the message to the
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 63 ++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  5 +++
 include/uapi/fwctl/fwctl.h | 66 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 10e3f504893892..a9d4b764832bb8 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -8,16 +8,20 @@
 #include <linux/slab.h>
 #include <linux/container_of.h>
 #include <linux/fs.h>
+#include <linux/sizes.h>
 
 #include <uapi/fwctl/fwctl.h>
 
 enum {
 	FWCTL_MAX_DEVICES = 256,
+	MAX_RPC_LEN = SZ_2M,
 };
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
+static unsigned long fwctl_tainted;
 
 DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
+DEFINE_FREE(kvfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T));
 
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
@@ -76,9 +80,67 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
 	return ucmd_respond(ucmd, sizeof(*cmd));
 }
 
+static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_rpc *cmd = ucmd->cmd;
+	void *outbuf __free(kvfree_errptr) = NULL;
+	void *inbuf __free(kvfree) = NULL;
+	size_t out_len;
+
+	if (cmd->in_len > MAX_RPC_LEN || cmd->out_len > MAX_RPC_LEN)
+		return -EMSGSIZE;
+
+	switch (cmd->scope) {
+	case FWCTL_RPC_CONFIGURATION:
+	case FWCTL_RPC_DEBUG_READ_ONLY:
+		break;
+
+	case FWCTL_RPC_DEBUG_WRITE_FULL:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		fallthrough;
+	case FWCTL_RPC_DEBUG_WRITE:
+		if (!test_and_set_bit(0, &fwctl_tainted)) {
+			dev_warn(
+				&fwctl->dev,
+				"%s(%d): has requested full access to the physical device device",
+				current->comm, task_pid_nr(current));
+			add_taint(TAINT_FWCTL, LOCKDEP_STILL_OK);
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	};
+
+	inbuf = kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
+	if (!inbuf)
+		return -ENOMEM;
+	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
+		return -EFAULT;
+
+	out_len = cmd->out_len;
+	outbuf = fwctl->ops->fw_rpc(ucmd->uctx, cmd->scope, inbuf, cmd->in_len,
+				    &out_len);
+	if (IS_ERR(outbuf))
+		return PTR_ERR(outbuf);
+	if (outbuf == inbuf) {
+		/* The driver can re-use inbuf as outbuf */
+		inbuf = NULL;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(cmd->out), outbuf,
+			 min(cmd->out_len, out_len)))
+		return -EFAULT;
+
+	cmd->out_len = out_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union ucmd_buffer {
 	struct fwctl_info info;
+	struct fwctl_rpc rpc;
 };
 
 struct fwctl_ioctl_op {
@@ -99,6 +161,7 @@ struct fwctl_ioctl_op {
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
 	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
+	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 9a906b861acf3a..294cfbf63306a2 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -26,6 +26,9 @@ struct fwctl_uctx;
  *	out_device_data. On input length indicates the size of the user buffer
  *	on output it indicates the size of the memory. The driver can ignore
  *	length on input, the core code will handle everything.
+ * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and return
+ *	the response and set out_len. rpc_in can be returned as the response
+ *	pointer. Otherwise the returned pointer is freed with kvfree().
  */
 struct fwctl_ops {
 	enum fwctl_device_type device_type;
@@ -33,6 +36,8 @@ struct fwctl_ops {
 	int (*open_uctx)(struct fwctl_uctx *uctx);
 	void (*close_uctx)(struct fwctl_uctx *uctx);
 	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
+	void *(*fw_rpc)(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			void *rpc_in, size_t in_len, size_t *out_len);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 39db9f09f8068e..8bde0d4416fd55 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -67,4 +67,70 @@ struct fwctl_info {
 };
 #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
 
+/**
+ * enum fwctl_rpc_scope - Scope of access for the RPC
+ */
+enum fwctl_rpc_scope {
+	/**
+	 * @FWCTL_RPC_CONFIGURATION: Device configuration access scope
+	 *
+	 * Read/write access to device configuration. When configuration
+	 * is written to the device remains in a fully supported state.
+	 */
+	FWCTL_RPC_CONFIGURATION = 0,
+	/**
+	 * @FWCTL_RPC_DEBUG_READ_ONLY: Read only access to debug information
+	 *
+	 * Readable debug information. Debug information is compatible with
+	 * kernel lockdown, and does not disclose any sensitive information. For
+	 * instance exposing any encryption secrets from this information is
+	 * forbidden.
+	 */
+	FWCTL_RPC_DEBUG_READ_ONLY = 1,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE: Writable access to lockdown compatible debug information
+	 *
+	 * Allows write access to data in the device which may leave a fully
+	 * supported state. This is intended to permit intensive and possibly
+	 * invasive debugging. This scope will taint the kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE = 2,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE_FULL: Writable access to all debug information
+	 *
+	 * Allows read/write access to everything. Requires CAP_SYS_RAW_IO, so
+	 * it is not required to follow lockdown principals. If in doubt
+	 * debugging should be placed in this scope. This scope will taint the
+	 * kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE_FULL = 3,
+};
+
+/**
+ * struct fwctl_rpc - ioctl(FWCTL_RPC)
+ * @size: sizeof(struct fwctl_rpc)
+ * @scope: One of enum fwctl_rpc_scope, required scope for the RPC
+ * @in_len: Length of the in memory
+ * @out_len: Length of the out memory
+ * @in: Request message in device specific format
+ * @out: Response message in device specific format
+ *
+ * Deliver a Remote Procedure Call to the device FW and return the response. The
+ * call's parameters and return are marshaled into linear buffers of memory. Any
+ * errno indicates that delivery of the RPC to the device failed. Return status
+ * originating in the device during a successful delivery must be encoded into
+ * out.
+ *
+ * The format of the buffers matches the out_device_type from FWCTL_INFO.
+ */
+struct fwctl_rpc {
+	__u32 size;
+	__u32 scope;
+	__u32 in_len;
+	__u32 out_len;
+	__aligned_u64 in;
+	__aligned_u64 out;
+};
+#define FWCTL_RPC _IO(FWCTL_TYPE, FWCTL_CMD_RPC)
+
 #endif
-- 
2.45.2


