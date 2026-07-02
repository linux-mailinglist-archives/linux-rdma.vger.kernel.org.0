Return-Path: <linux-rdma+bounces-22724-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ifbvIpihRmpgagsAu9opvQ
	(envelope-from <linux-rdma+bounces-22724-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:36:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 220366FB7AC
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:36:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="hmLIQ/h+";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22724-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22724-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 831E03009089
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D5318EC1;
	Thu,  2 Jul 2026 17:36:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55D348C6C;
	Thu,  2 Jul 2026 17:36:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013782; cv=fail; b=T70iwTbZgDS76zUspfLs/6dlPxVGCzKzJiu6uopPeUpwBFaIEEeCenREBHKX+u50TzRwijTiiaRAD6AAc32Nbsyf0HPoaaoDlLDklwi6WZ93yhpMEg5gXySE+8VllpRMd/DnqM94wz3GbHypR/wM4dilrTYh+EYPuu07g10fu8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013782; c=relaxed/simple;
	bh=3XJkuxfLK3y3SanIW0RSaVYc9nKbo5FIlyB9ojXJfZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ph8Ci0mBD64Y8gm+2hZVywvto3K6xk2QUlyYYKk0vDtyq8eAXwuLq3JRWZ805Xn6jO7JJ9VFkcGKNXWGKexFfZOUZpTfcz9nsMmF8O0ynklwC47npQJa94kVuolMzQF+fbu7xJpK9z8fyz/AKX+KpFyXCHLGTY00sWChU/tEPFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmLIQ/h+; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8IDYbZgPhwUgI4Sripw/uFWrY8bobWKIUv+2hC6T7yYcOc6E5SuMd8+10CpeUEtLvo4fwZ2PILCXhtZ6ffkLrEtOxJhOrhPw4dpCRh4VVvwlXv1qhsBUvzmjH6gGRaKqsomWHWFz3IxkkP+YlfikpMSjKJGwQB6sLq7tmCVSzLvyUHpfP9FP6QcesGFqCsJnL3QzFr4u13Z7wfZg3VhI6BfTSuody4d8G/YEjthn72rWUTzQ6qXfVeJIz22D4HHmpg7RruG6qaJdZlA/DlX3HX8GFyHmARf/9vVDQsWC22q1FqUJc+bPodshiCbXqoFQv4RcAzIyKLAqihbjR+vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO0hIU2Ja+vV+C2M/dC0zmrIvNncrQcFPDytiuOWPHg=;
 b=rzR0c7O543/G2V6GyJMOmfT4jZp9soBa2UM3kQFAG4atu9PRsYiD8Wa6acQjdm9UI7ZYZjttsPLc4UWiWup7P6Un5FL5Zh0zreoPeSCtu79GUTWvBMz8cR4aQpFnzv8fqxPXnmGXX/FD9VBLxDechVnXduxV7b2oDHmRoQmB2NxMq7qIy+aVfm430VUBMgqjFNr7PSZ3fjRyRlyaf5wokLJV48zY0KIb2H9p+0tI5XEj3AELjplQGg0JSZeiQ/K8qPy86rgK5I3p0kj1ZW1fujrXf/WjoDCBiTD+OW2ZCGkhp6HZFNfD/2obr7jhtobTy1Oj2Y6qtc7+CLAEsjMjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO0hIU2Ja+vV+C2M/dC0zmrIvNncrQcFPDytiuOWPHg=;
 b=hmLIQ/h+iHn+c55i5Q0a9ZONKVSgjtlVLSQAw83xaUUT7VlLOY/S2O8h6L5EwwmdXcY7W2tAVzsXv6U3npbab7S94VF0yao0ECic3fBRPgkt48dobXIYIQr8YZcTBb309cn9UxMzleoZZKAIHoCw7YpZHje8hF5u6igKAfGRDyLNxBfEQrWdwhTYaWPvKHcn/W5ZngFBBZlLf906wUJFgdvZozT2a4GdqREL8K8JOkjU3EChYUOFZp6+OxrtouML+QZIy7bzDZ1P7bomv1CIdwzMJG95mVCrBDW68cxRI/IHZTqQ5+cQMHRUunxzPijWtAclCR7I9c7TN1MK5G4RyA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:36:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:36:18 +0000
Date: Thu, 2 Jul 2026 14:36:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Remove kernel-doc warning in umr.c
Message-ID: <20260702173617.GB1515240@nvidia.com>
References: <20260629-kdoc-fix-v1-1-735a90dede7f@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-kdoc-fix-v1-1-735a90dede7f@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 06608b1b-1137-4701-f298-08ded8606cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZjY5V0o1ABRmr1YXy/HlkYMWqUWhd9gQA6gtCq1QMfrrKTtSa1ZZelrf5fJXvngA5Bhq1wuMNKmCNy2ATT5ewRw7cx7yAFh34MhIXyTQIUlHem3ZVVB1d3T7arChM07/VxJb8KHsVG971xDh1I/+PoHjU+BbRDPFrIfPRnl2vFj3S/zwKGgLZ9nzbX6BaEmTXo9uMP04j/3mb5ifyqO0/qTu9Zj9DwauIu6R9ywagdn7hoiMU7K9JVtS20cj8gxPGapuPM057QVP6h0cVjI7uxbRP88/zr0wJUntgvHK6XVYEi7r3sFjR/K0BIwuHrCA6mC2ygwGkzubObu49+KNM1h2jz6kj/stacFv0R8HUHcfvCZoRwdWf9shWSis7AinK06F4lSRWIVjnW7Uz8qz5Tcx0RbRtCkWiryZtoqvmC7Fs8b4sw1PYsYeeQHqWMoyojfSiFWLlDEH5793a6TIZbOp/i/zvB454L/F4y9L6yvFHLC0UilGAYvDf1GsWGRbkVhC+at0oemmDm4LVnA3Cu5x6HUT8aOxIm1wNQJihqzJy9lkqvj3t8VD6dwsNP6JN/e5mJu5u71vjx4x/yXZ9Z9KguTKFtx0yRFFxYBLSquWWBKBIjXfXR7Y5PYToJwLULwhfnk2ml1a9WRj/18I1NaAdAWa6GizCN6levFZKQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5JcbPh3XdYBpnFWXovZ0wi0+lnK2AJINPIrOe2zOg0QJRDqtGjLIlz4xfmb?=
 =?us-ascii?Q?FJ37PTd8C9AX+0z6/hzFrBSm4fbHzSSwAJd3MD+Zy48P5G8/hi63I0Mwxpmo?=
 =?us-ascii?Q?82Hzy15Xnw6gVwc30vNX2/L69q3g/5lBvvcI5ZUzu2qVEP6rgaIzRmr1vYPl?=
 =?us-ascii?Q?mC4DfTARRs4bMs6Q/228KC45JK2unrIxko9A4GhHpSax477Zpt1JQih0nEU7?=
 =?us-ascii?Q?3J7zIIuPaknrN7mKSyxof8Tcgck9F7GTBTD2nQ3y/tFbRAA89TgtOSbtJ+Ca?=
 =?us-ascii?Q?5RQBO5OlaOqLnUj8ix+jJMxM/8Ok8MFbjeJQ4exAIQvaAjbGv/I54VbCLZx8?=
 =?us-ascii?Q?BeOzLe2Wvy6Fy4x8jXhES3pdlceRnCxT+yADHWQI+oAFmjhCFBLifO4n7EUG?=
 =?us-ascii?Q?/d7Tk6SzA33IW4RkCL6lG8eLtDTsBnnjCk0o+5v9GRpVkXmMhWQarSIKfK8I?=
 =?us-ascii?Q?YdKpxMfK2joU2E70ywOsmX5hZXr5mHvUmrbvbMYp/2HdSY0ELOqQiAmzqjap?=
 =?us-ascii?Q?ntosltofCKEK92w3F5yDEQTAJ2QpjJNXECCeAkLoP2UEk3oLpsNAGhgj4UEk?=
 =?us-ascii?Q?zpR0uxiRLKbQny+jIUpzG8uH+Lovpbx6iY+pZaSsjBbBnADUPL5QzA021sNL?=
 =?us-ascii?Q?PG0+6Gq+iLj1ET+80knhy8Ul8K9w77Bfwy9sg/mPnJGybm9ygZ5C4oPvLfrY?=
 =?us-ascii?Q?ltyHKcZV44g9BYlJg57kBX1vRh4kL5J7q24Pll12b1vkaN0hYwC4HZ78wL3R?=
 =?us-ascii?Q?Z9hsfxXydk3kiiOV6dHY0f7I2Ej4Fa1OHafFpQoUi1FdKEGd8cDhhZa/0Clp?=
 =?us-ascii?Q?Po/tfmVFqieDFjaUzQ2McjWO7oa8EGLNZsc5ys/LgUqoJULZpvhac+hKJz0V?=
 =?us-ascii?Q?6TPa26PlqzdUS0K2KFojPY74sF3CaMQhMsXjDlY3vqkHosxwxdCWhVzmBja2?=
 =?us-ascii?Q?YWpdSaQtQeulfS70Fe9Z78uW7jUEEp45sOMV8CSjxiT9B+4hOlJFD9KICGZ7?=
 =?us-ascii?Q?1+BpjvJccSAfdI3d3p+RPjGA4ecR81kKuDdaubjvk3UmC+NQAt9eHHL+Nzj0?=
 =?us-ascii?Q?QVJDfbyPzYGlrB2oLgMz2G7IFx2431tcPyHC1apagI/H12sbb87ERibpl77Z?=
 =?us-ascii?Q?nMk7x5TCDxLoBlOxrCFZJzSnqV/X5kOI1dpfh389BMIZ3sPsnp+mCF0Dc7fG?=
 =?us-ascii?Q?b//lDsX14Horf3WZxQHUIxfLfci96Ch1/sOdMLJXhp3sfP+bSgJJFcjs0XUW?=
 =?us-ascii?Q?LGmKlaxW+Cmkzy8aLKbCcRzfI8hEJ6MX8F3IZ1GEjpSWoJ6uRKaONVnGkIFk?=
 =?us-ascii?Q?cmj2SxqoHd8bMgLicSubX0XMOeSxr/7o4JelwwKLGqm3vVwrTXfwIUt2DkFb?=
 =?us-ascii?Q?kGAh21U6KqfVRpKQAR95mSVuSKlfj33tQidjaMUrj9qmNuAnR9nOfazWsrxb?=
 =?us-ascii?Q?S2xQy4KmJhJpVQpe5kqIVFOqikQccQ+KRiQuPP/Ff5414tWUk6VBmm1xhbbJ?=
 =?us-ascii?Q?/5iQSxcBf/V9ABd6A8H12nQvl+ZC/wj2wNBFYg4q7mV0d9IjGtHGstA6AT4l?=
 =?us-ascii?Q?IqwldyPyhNl2eNeqpd3WeB8mUutLPsWOuF5cky809CtSz6bUDHJYEvrUdAaC?=
 =?us-ascii?Q?jNwXyl8lAB1ZQdAY03UIHB9W07NM+UD1VQS08FY7TjLgp1lqrn5OcVy+DI4R?=
 =?us-ascii?Q?PtNBShq8WSl0hwHkoUPCl18HnfJFfD2+EzyEp9MRbqVeOaVU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06608b1b-1137-4701-f298-08ded8606cba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:36:18.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFkLVcysYO6zQssid25Wjvo9v4qNIqdQd13FYQxZA6abJpXBg4dPXipljqMgoLNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22724-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 220366FB7AC

On Mon, Jun 29, 2026 at 12:15:37PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove extra asterisk to avoid the following kernel-doc warning:
> 
>   Warning: drivers/infiniband/hw/mlx5/umr.c:986 This comment starts with '/**',
>   but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
> 
> Fixes: e73242aa14d2 ("RDMA/mlx5: Optimize DMABUF mkey page size")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

