Return-Path: <linux-rdma+bounces-3458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E9915A09
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931211F239E9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ACE1A2C1D;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJfHQwzk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D31A2556;
	Mon, 24 Jun 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269266; cv=fail; b=fDwGBRC3sQtASnzQfEEFTyyLNJn6dJzK++EHdTC4bzX98QMhDX0XpielCPKJ7Ex1UlKWYbqNfs7d/EaU7IUwI19EehHR5/rxizUE1Mvlqghz864tQtmEShaQ9IfT8A4KmemNabws3eGdsH181x7FUgetZbamTUjH7U0uwsk2NB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269266; c=relaxed/simple;
	bh=M+Sp6BgrRIack3VPn5wtmaTUXuPES3c0KPMUpzuQgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcMO+imFFS/hD0IEpSESBrM+XetKJajMkvpSc1mvQCEVnD4BDYUBuxNn/dysHb4fDrgnrNSNxeQgylQhRdtnruQlOVz+jPtshDgVBF5kd8I8kTkC8Oc55n8YUq5RmVo/3KX8JmXOsR802TX5fbN1YNf9WBRhLcHakCbaSO46RWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJfHQwzk; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9TNmJ/Yj9iNh3pnvJDeQU9ddLJBSrchtNix43DwAv/l/LzqxZ4IzgquBBf7jWc9Z+TkP7v3a4vr9RqaVeVHzwyaCAKSLORB+cL61a/HAsXb7VANm4Jn8HGrTrRYvxBZUnOazn9wspjDDGmPVUTFFQChMcCnzrYraLPcJyx95naDFl/PsaLcSWqB/Psr5X2w49wzUuzmEihxEFTwO3Ez+OO11wjPogBMGaeAVptx8SstT7Y/OKgg0S1bWkI2HARrK51e40HoAECN4FhSPj//qfVkfROzORG2sCGnExGr/5Q8cgNuisYHClSXoU1lcyF7YLXWrGGSXcuply/BL7e6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahCe+PFiQm/4yjM3tCQ2bSPwGrCMGl0a4eA7ToK9U2M=;
 b=nBwmXMy4CIKzl5f7yaNRKVeh7aysNO39CQmK6GzfZKhgfTymC8vNi+lqVvlCxDkuirHP+hNFmptjDt9IwM/2+XtVO2WrK1SJ6Jb2EEflz4XmlqBbAuMESSKBFoKpOzOyGidneem0ZbB3m2wwunqQ1t15PcMn8/5pOWKjf3MeXUMqQ7ORsSF5TlRd9Q+C+8MNZ3/jjU6JdKOMW8g8u3M/hzs5A1UNMJBE3y0Q6MCMQKzonIFz3ebhp0BpKomUcBotEmE/kWSFlwvgpIhwiioYb8ceNAbH7hgyMUAxOPvZ1mGLVAfl7doyrhuR+DWLVPTrneJpyIvDxIaQDXgLHDywiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahCe+PFiQm/4yjM3tCQ2bSPwGrCMGl0a4eA7ToK9U2M=;
 b=LJfHQwzkrNGMSOhJIT+A+RoMXHprjwASO1rABMFy5jJl+26HwtTBavqg5f/XwdlAuJzjNIgraFU6YZn9QoTFxeaqbMD1Sy0+dTdEUCEmJh1ZIPbxtjs69syNxBrvN4QoptJNc9Wyu+mnW2eXScWe5xCBQhyVY5Jt9Biizz1hY18u2ViLnz26Efrm/ktI8EyE8fpFycUF0bN/OSscnb9hjYoodyDpu+AiTOwi+dgBR3dabk7qOZ2T4J67keSqhOK/kgiTL9Iw5Cr6Sh5PRi+iB5fIqBsuiPXJNU0v0UgutRliQnp5bmx/MbCwzzcv6mKyaGp6Bv3j/xVeQVA2LOzEdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:37 +0000
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
Subject: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
Date: Mon, 24 Jun 2024 19:47:29 -0300
Message-ID: <5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: fa15bd64-3495-4fe9-1ffc-08dc949fa2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Or43nQCznv+xqDd8sAMtdPKAb+y8DN8yI3Hu7lk5tlglLMRT5A26MgZ7tICn?=
 =?us-ascii?Q?pFzQY8rT0vlkhhauyh7Er8teKvsIiTL50unrdfv+MNcXNYa5unAyA11x0klX?=
 =?us-ascii?Q?aZl8XI+87G5Wp4Zp8+nAuPQ43qsWO2Hom85i6etAdX2sZA0ZrgA8WF/vgJr0?=
 =?us-ascii?Q?eobmjf++/E4+6rrhguKEDCoVAUoAetYQd1xEwIuWIyD8zrfcSz0J1IiAgMAF?=
 =?us-ascii?Q?kyY+K/jdJyvDPGFhDv6CbrpeZQpAsvIBTv0JROXldxN2I+NUBdbElXRmrXX8?=
 =?us-ascii?Q?+L7R0V1NsKG3gY3yavpAVdVDKCoMZ94wiE6VXI2aFE7/ch+1PgDFvA2OfU+S?=
 =?us-ascii?Q?PKzvuenqI/6rl7RuZXLOTyh2+sOBvs9bFVoMGdhZrG0Pokx0Hz2VVU2UeM19?=
 =?us-ascii?Q?juV3vJYhH4NeGltMqGanKqcG9iyZhi3u/k779Cer0scez8/Q7JyRYdZcmOiI?=
 =?us-ascii?Q?M9vYSmT8YTcu32xK30wx9maa0MBQAz/Si5Np3ltnFA0P50fcSr/8meCpSi28?=
 =?us-ascii?Q?jYVGoKkmclA9Vs3GG/xhjqSI7ierm8VnCpiPdO38gpDkyCjGJn+Y5Eh+gtBr?=
 =?us-ascii?Q?JIWUX3SQcviNBEf9TkKo/BSZJtF2Oh3hZXWUPk+ZlCDF5zK3JzphpNZnu8QM?=
 =?us-ascii?Q?+MBloISlc1MdtlmUO5+0UID4gon/M3UKeOXwKcwoTYwh0SKStT0g7eo8UyJ0?=
 =?us-ascii?Q?ejRTumBPxHLDnWv/1pxci5ertDiXXAuwgzqmmIgHb14c4Udt2STlqvioi0DT?=
 =?us-ascii?Q?dco51lWCmhtpdVZZU++IIr3YfovU4AIhaTg7cf7aItbuaKldc8SjciNhbJun?=
 =?us-ascii?Q?O3rGWCeiGzoDxZaZgHOT61YRjGI080rihDvhhii1JIWyi2P+MgSTaPdRHnJn?=
 =?us-ascii?Q?qt9jgoSxd6cE9gDGDuIlJ3WG36RLtGk1mhfRcNAZlN5vxR9epOBhLSgq2yTF?=
 =?us-ascii?Q?68Ipwp13xsmfaOqni0xbG7KOopEKBR6xVmkbiP5KxmwNPXV5a7yxq3dMzgGS?=
 =?us-ascii?Q?j1Z5TkTALjILhYyu5JOYnbxfEnvRmSKKGMolsTdRJsjXPxgr6zYw6mW2SXDd?=
 =?us-ascii?Q?pBaVB87ZQXa+4hWPg/98kdv0mwssmC6YIA7qVG6zDnLbC8IhRq/skvfKnQg6?=
 =?us-ascii?Q?rJsy1i/ogVzWtYYP8jZ5Bsfw6qvY3C0OdXun8K16DwSVTqw4AsJcHKS2wJNB?=
 =?us-ascii?Q?em+1OAHchlgptF+RypeG9g5+WJ4BkcdO811AQ44WQS9AA3KNycNcybDJ3P2o?=
 =?us-ascii?Q?Ih86tD6OthmtWlDb1y4qLM55ZfFmHFlR81etslUGGaZFSQoXobCy6KwMmb71?=
 =?us-ascii?Q?c6/zb1dUvAIcKqKvd6NvtLauKFaEusaDAQ/8+IVDjME5/eNEnoQRiAUeu45L?=
 =?us-ascii?Q?ixo6Cr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrQjO1wx6SWXScm46wXppHFkBxhsCVxBgaiTRWeStsUoi0I8pnu9UgeWnh9W?=
 =?us-ascii?Q?eHvs8mi83XiDvXkcZ9mG1KWjgLJcf/svVkAUZ+Jbdks7dR2FmvVbW4msCe58?=
 =?us-ascii?Q?39DtiLFSzwai1LO2mcnmFs/50oHI0ScsJG7wIt0sLtOetT/uiC3qZ1dUb2md?=
 =?us-ascii?Q?LQE4ygjhcTi/QDMIqqhh4h4UlHpj7uZBlSAPgesA0t7HrWEL4B2nq+xGJ/33?=
 =?us-ascii?Q?SVQ8CyjGXTR34dSx1UeWVQhQLg9dXTKHtILnlj7pKGMBIAkkLqQ5Ug4jyhtk?=
 =?us-ascii?Q?iZMSrgsWq6ELnTaE/Gchqz9sTaOROotsRab3ovXjYDBOfwqBP3vTfNjaEGCz?=
 =?us-ascii?Q?44EXQtMGyhpOir5K/Wt0quqOdoFPMZZzvHkfzGfRE5aadNY2NFVgkUQCWsL+?=
 =?us-ascii?Q?1ding+bUXuulN52L3VdwM+N3WNvIDJhmRTdAEfNshE+8bpNxnH5aARnS3+oE?=
 =?us-ascii?Q?z7n/kFtV97bKs471yE7hPY3v/2faXdc3M7XnzVHCSaq/x0znAU2bhdWHxYXj?=
 =?us-ascii?Q?71M/SC+bbn1NcZVN2m5/WTXaUMeU8uB3MWHaMnZWVo/wfpD9woTuWgbW1eB0?=
 =?us-ascii?Q?qA7UDlAZIzVjnhsfya+0bag0QGNdMT4asmThAhgP/KD+T87+P+WSpGBnZezR?=
 =?us-ascii?Q?Jn5aJu74QQdWx/UJ+157lbAfDuaeuwVkOrZvtu0zMV5r9VblTB8iqmaVaSEx?=
 =?us-ascii?Q?D2nXqfCyM1Ues8jCSCKxo+RlsMVp5McBgC9zCIpctvEbseeTRKw84on2uwEC?=
 =?us-ascii?Q?owmH+HfV+1GRe/zSuP+x7+ttLndXEnVCYI5lMZ2uze9KgH8a9LCmpUbX+sPh?=
 =?us-ascii?Q?698ViYz+j9Go7sRhiv4tRbQKAEFITUBI9rNgqlJ0SBd1rn3k638UU4RyVMgM?=
 =?us-ascii?Q?pkmO4rQj6p+JX7m9F8Nchras+U6q/lGXshfI5vhK/2Y6NRdP7OhUXC/cAGE8?=
 =?us-ascii?Q?fAgHmv9yjQfFLLlowU3OLziR1xmOkmz7v7KPm8K2pTM9Dkb6+Idjt29OOHvP?=
 =?us-ascii?Q?wmhEU3t6BantCj7meS9ZJ3n3ALBMwUrQzsK3tsXnZNW/eyHc0mHsST0Fl8Bu?=
 =?us-ascii?Q?IV8ecvR24voBR5wbB7dxoTmc2ecm06EerVwSklEAOAMVyXep38S4tsH/L+de?=
 =?us-ascii?Q?ZuqkLPpuBSm04T0HDd77mJwRSdrGFzCjNc/90OPpWCQ3mMIesmUGC5mU/22n?=
 =?us-ascii?Q?nwqDrYduzVZBR6tGt9H+5KuU/Hk1uAqM69fkAphrgkzSGYUky9Xm0A/x/3ll?=
 =?us-ascii?Q?BPyucO6uhh6UeS4WUC+6EmAIGUdrsvKZAkJloaMqGAze5pYL5wqlIsONp/ec?=
 =?us-ascii?Q?D/UQxvApsq3NFc/cbwfMAWTrv/+7WTAteYkEoJO64R81Cs1xngOOnBgxwNTD?=
 =?us-ascii?Q?J2KIjClDhjGKkT2PjXE9nCH0Lzbj48M9Cj3TfSO3pzQt5i6cO0PgQVo2B0bs?=
 =?us-ascii?Q?B2EMP7W6+y/IYKEzMEdZVL1oSL6yyG7nCcG34LPKIUb3Gzu4I2MSZjxfdQck?=
 =?us-ascii?Q?yVtpiOHTA8potVpasrQTgIF6g3TRK8XzqeonutEvnN0FyUNsI+lWBey7iURC?=
 =?us-ascii?Q?GD+t2zrPFycaBYBDXDNO7RN1uIFsCLUG4VI73CPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15bd64-3495-4fe9-1ffc-08dc949fa2fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:33.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xhd8pyVmhCnEcwQmRGA2vzWT4J1JBRmKa3zvHEvxy2+saHzBQ0ZUbPeo+za7rW1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
firmware. Drivers implementing this call must follow the security
guidelines under Documentation/userspace-api/fwctl.rst

The core code provides some memory management helpers to get the messages
copied from and back to userspace. The driver is responsible for
allocating the output message memory and delivering the message to the
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 62 +++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  5 +++
 include/uapi/fwctl/fwctl.h | 66 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index f1dec0b590aee4..9506b993a1a56d 100644
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
@@ -75,9 +79,66 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
 	return ucmd_respond(ucmd, sizeof(*cmd));
 }
 
+static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_rpc *cmd = ucmd->cmd;
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
+	void *inbuf __free(kvfree) =
+		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);
+	if (!inbuf)
+		return -ENOMEM;
+	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
+		return -EFAULT;
+
+	out_len = cmd->out_len;
+	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
+		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
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
@@ -98,6 +159,7 @@ struct fwctl_ioctl_op {
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


