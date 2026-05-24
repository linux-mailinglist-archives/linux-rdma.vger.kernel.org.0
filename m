Return-Path: <linux-rdma+bounces-21213-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH4DLKFfE2ow/QYAu9opvQ
	(envelope-from <linux-rdma+bounces-21213-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:29:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836E5C4237
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C88303009B22
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D44321F2D;
	Sun, 24 May 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QW41UW5c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880318B0F;
	Sun, 24 May 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779654556; cv=fail; b=ruwjn43HL7jfIVs4OrMdHxc9XUJwwB0GTxD9HlCPDmQO9Pz6sOa8jHfCye/K7a+fAlCB+/zVVjB5SqBLaQYKqzAWRpGUGcXwtX5H93ENgDEHzVL2w5q5b65ROfT9dAQC5hVqbIAGaBAkDBFX7mhEx40oP8p2QiMjxFZHEsVjRhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779654556; c=relaxed/simple;
	bh=dJZlwlnHJmFNIY52orpr0dvKikngi+XL6Yy0Qg1Rr2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXKCFFXbUKaVgrfdfmWdGPecVwqH2HiKuisoINGPnUSfcI6Wx8z7/cINd1tDunOx1eS2QL/Uxl2RN7plb9r3hqNsqjlovl5SijjHWPTRYlnDoY4YXfUklxdKxJZvwlFoF353mc7RG/rJ9wfNMRmBiqsJQa9IAkOQYmjui2w98hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QW41UW5c; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbzTKvrRfo+s/9IE29MMqomrODmvCnZza6f9WcjMFC2JKqWfbWW4YTaz5Gkje2f3RlGAjcRoU/8a/SglTXYxlF+q4SJdWl/Y+eKNlcXb2eycBRfqzuJGE6JCryXEBehSjxAQ45snckGiAGa+PDFsVZUi1Q4eLsUsz1H1S+Z2G3SbfTn2ExyA+mqL8rd1Eg4xPPnp2vaRIupN29NiDAnsCRXYW4OPfw8vxaqDXIzbgkD5+DJ7KUuegVW2WFTcfx1FQff63/vjrzH5DBtPuNFzNRz/VP34k0FfsekpURmQ/jvkjiGGiauNQhZES5bZszaNTAo3HiM2qvFEQ8sQO6/6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDKCZYT2HKwlcrTtDZ8yIAuvnR5Xx0GODnTuI6S0RPw=;
 b=JUmmrC4UR6fEXWPTcQ19ZnS26JJmvvezwLuwEokNyuBCdJsBspvTXTBCiumUCWtlfcvJBbPZ4wmRQzrlF6PJKY17XpD97m+/B8zbQB9OHaqpllL3rG3rq3Q72P9PFFpC/KCFxNXC3MBJ71iysE98hZ7pwSZstKDU1MoLsUGn2HKo/AIAq96EZKz1vO+xwdtYCbB97FpBYBHmE+UuB0NfNe5nxNMh71YvyqiVtCs5kdAC7YJYiP8IdZod/eAz7nJgP/Trae9dLXJboGN2kmGtgtNXc358g6Tk+85TehIhA7xbnkXMzc8GTMJ/DloL8MYvo+Ee2ahJfmFyIqyNBuPnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDKCZYT2HKwlcrTtDZ8yIAuvnR5Xx0GODnTuI6S0RPw=;
 b=QW41UW5cs4D5PYmfo0zATlx4A7XEc7G8YuGRBUO+YLet/L3BjrBgeyLexgJ3KLFEFciyUKjL7MQKir1qVqKMyZXH89hE7PzhV3BdkaElgvjp0jstvJkpYKhnrxNMeVYJ25jZ0h0ecDGgKoKiPio6wnReEZhEHDwsTfn9jIIKhPQX0LBGb/040umQ6CDOHoErBbZOPSU5i25X8sD4BTT1IDkwMccskdIYZTbrJnidY/pwQBmddh+USzJQo8u1QlwxXwGGqBopvtbwxM3g55GxxdnJf2KC2bM1xQci+lOQYzQK8TqTytDgSzrqLy5gmOuJ4LO1g+KvKx3Y4GBjSKirtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:29:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:29:10 +0000
Date: Sun, 24 May 2026 17:29:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Message-ID: <20260524202909.GA2105954@nvidia.com>
References: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
X-ClientProxiedBy: YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: ec12c702-3ab0-4ce9-2f72-08deb9d31c86
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	Iu1LDUmcpXCe9LQ3qKMeVG6PKgsQ38xReJ1TbDlSb23kCfCHDW5H1uvSxM4UtMIN4cXc8xxR0NszUzwuByuhzXk9GxXZEMJIPU6N3ibE93cWIp564H3sXtQg9lbw3zQSFU+EEI101/ws1+3SxFXn9F0pbdYu7ao0irkwfHjRBxon/n1DwuE/u2bFDVXzt2JugO38ctUDP3kP4/+xcADqqID8ZqrjGM5Ugbu6baAGjBPwf2nwGwId58y4wYwjOyovJeLU+5h3x0ARAxautTBaBYfuWxVXGvySTMJi3+N/Ur9cu03sfqVhl6vCQRpZ2zNFxsX2P8pOgOee+ZGS+UY+0tcUVTODHFwfqVBX9XicPohK5fe3AJ7OCjZtyjmx6jOQt7l+TzUH1Ao11s+s5XLRyyB67Rj3EMs3XZblTgCbYz3RbLU6aXsdtp5Qx9tLO1/9GGt6uOJXqfAk/er9VcLMzq3C79HLVE9HVr46UWN5wSlpySiEzBhodSkAwAIzHUi2SpwcPgD5B9Ih2LH+tF+CyCvnVacAzVQjHqGo4hAuYqrJ+kiuGYxsJAyTHI48lBIUDld4KC/lcvGQud5eDpSDbODzQGnJNvI+vUfL+ed5hao5w4+5cMIIm5rM29UIbh3bWNlQWjXPlv7VHFFwLAfZc8q5ip8d410/tyfEzl7zJNKSQJPYlmZtyi2ExqB/+Lov
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ao1ECUEwEFHNqFbbp2McCojOG2iRrNv41OKe/zg7jLn9i2fABzzQUwmNxQyy?=
 =?us-ascii?Q?IZ2t+hgpcTNSju1IMVcJ9TCdjg/IRv4lQUixqo96Lp4zlskve549hC3enFDV?=
 =?us-ascii?Q?+xZsPTghkRZ3Fe+294TKMDG7WmxrGkDegIhHCGPXBg/Z5sJtyCBzLePGgA0d?=
 =?us-ascii?Q?JMnSNTr7kMhKC8JK66716NVwQ2h1R5Gea6RrA+6QtAqvQekq309Cb8+e2WER?=
 =?us-ascii?Q?gaF4OIz8YvDrt7GjTvAn9S4HqlMKZ6NLwTJch1vaFTAzc+veTOqAH9j2Rc8Y?=
 =?us-ascii?Q?HnAC7wXiCPHTgJKKRJa2OTq1VpoReoUiKW9CE4tn0cQeq61ZqZEQnNj7O2dg?=
 =?us-ascii?Q?d/53JXsHOjNERUtnOh4AOciuHAL8FHyHBS5q5sUmu19P4DVQe67/bdTGzXMR?=
 =?us-ascii?Q?KPOKMrUvEvvnn4zs8JNRp15O3+M5zQBIA9kCCJ8ZWklmpUe2vi9fHG22QnGo?=
 =?us-ascii?Q?GWom6CnMzTP3Yw3nt182+ujgAcbFSIrdbtZkqxnP+LOI/Jacg8kEFSRUwhVp?=
 =?us-ascii?Q?CNMVVZV0swSCoMIBr5kwv1pT88VGfhAwjD+lga1b1/q3noo0ArKt4GZSRqg+?=
 =?us-ascii?Q?EtD45rULUKsqWEd3+Hh2nm8hSrGLuqtAC9icIdHJR6cdYMpGKvlDO0iDK+Q/?=
 =?us-ascii?Q?UQauS+KGlM/YHCFN7MSnqSk4RUkwfAgKOA82QJyQSCQ4lo5qv0PcxavhFl8N?=
 =?us-ascii?Q?zLxEobfQNA2szNaLHRryfkNzFZsvzugVFLnhbMQ0HVpZW/GyzVUSiPzAGvdp?=
 =?us-ascii?Q?LJ6g6GWxiQAkg9jolWUmohdeQWNE9NHaRT002FCEdCLlkPX+nuEPQW70x0bg?=
 =?us-ascii?Q?Rnqavp78YaISDN6uPF7m6xeedlQn+EU4L6N36rKNwrCuLR0ff8pnRm9zEMhO?=
 =?us-ascii?Q?CjzBQR8hCNd2dVrR25PXLG1NU51ziecUnru8y/lNJK2oNpSc+gJL6pPVpP9F?=
 =?us-ascii?Q?fhgbtzbXF2ysi0EHaUTuAqZ3mvy+IE7h2+EzZ++P67/eB7vr0/1ciBCVLc7U?=
 =?us-ascii?Q?H7rmH5cdqz/tRQS5Axd5A7M4XgXeDmGphN9zKgPM9eqd6OYN99vXHLiNTiSA?=
 =?us-ascii?Q?yTOnqfk6rmFa7+8vHTbQ97e1FA2jIPpy+T/GkVfEouDI3H8jvED8f16XloOd?=
 =?us-ascii?Q?jY1eJkgRgZ8nLAZrAvbDkF+kFYLA861QLp7quhIbVt9sXw03sBYsUPPEdTEn?=
 =?us-ascii?Q?ujbFgo5kNeaselXx/r2p+rNLsyYuR72aDLwYXHyj/ORRUn47HTwhVaXfI8Ky?=
 =?us-ascii?Q?7bhUZwiZrPHdPtyTnYgb3dHw6k5vho2U3AN7qbO82ZacRyGiyA4mS3k3IEaF?=
 =?us-ascii?Q?rGBUSBoUryGdrMI+06QHaw1zd0f65kXvkqbMr5LsNCay/ArJ1W4ZTsK97pXq?=
 =?us-ascii?Q?y4Y6PGmRvzCrll3UK2zmiPX5C6lgE+o30WEHEn2BYOTkNTl9GfpzXIXur0B3?=
 =?us-ascii?Q?Z2wPJRd73cR4JTw0JChQY9R8KsKgWLQpshis43YQKP6F6u3TFQgTsIyuGMbl?=
 =?us-ascii?Q?HIWB37MUkkduaF4RQTdY3nSNmbvKs/OgxN2SqjpHE5iR3s6dSyK6MN+sqn5R?=
 =?us-ascii?Q?55SjKwF1dOjV8L69Mn6xBbK7q7PzagNfmtkaAiZ0fuDP9ELA7gyO5Bdu3JtW?=
 =?us-ascii?Q?/+mGz91F3/IWWK9BFnKPu3fE6dEVvaKxx0/ymvnhx3gsVCr4MmNsKU4y3Y+9?=
 =?us-ascii?Q?GeLdeyxEOCkn8uN/vZmYuV5IlIttd2q4KcBDDZbgmdYJFE2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec12c702-3ab0-4ce9-2f72-08deb9d31c86
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:29:10.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycXxU+rufN1Ehh6ngEehDY8AkwqNYWr5kU2U22HTpB5XjWyTgks9u9wHx4U2jY52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21213-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0836E5C4237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 02:40:56AM -0700, Konstantin Taranov wrote:
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
> 
> Replace hardcoded IB_WIDTH_4X/IB_SPEED_EDR with ib_get_eth_speed()
> to report the actual link speed in mana_ib_query_port().
> 
> Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next thanks

Jason

