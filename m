Return-Path: <linux-rdma+bounces-19163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ImvIPar12kMRQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:39:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811333CB5DB
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27E67300B8E6
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449134405B;
	Thu,  9 Apr 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKAH6roY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547B33BBA2;
	Thu,  9 Apr 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741927; cv=fail; b=NKiAsHarYbeZhGB/8rdZMnlYWY44IDiqRK8owhlJnyacgGL+IPxODWlNhA5OWnLENimBdo7RHc26dpCw02VzqohaaWSnfswhWQdH32qaplHN5Y0mVyvXLi7kGydKH7uYK7q91+DGLwQ5ioj7AzPP3PvDXvex+ybVGOz397Aw5uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741927; c=relaxed/simple;
	bh=xYi/6Rwn+3IXWBCgw/ffIBMhtrEpCshp4RTr94FNmoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRbJlvsxnEDQi0jyKIfHtpsvFwzc2T9+108aZXi3EM1V1udroZUad+DKgzXEbeuMSKDWBY0E2jfad5D0wLOz1a8Y7bpSu5hS0DJSQ/fHhspmEp8UQ9wML7xzwgPQ9MA2CB1uyGwig3vVqOnAT/krbkrRJO2/buiw8veu/Wu8K/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKAH6roY; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9CeX9yvWEsle5zzvxK/i16vndRCa7sywtFBXLOeYoXqGJ6oi8tJKAFAvsHd5OzrLpSaUi2yqcwc53u9kA17bPelb5C0wqgkPba3chOhDtlLo3zIANCcxmevHnd0I4EBRMlkDI/GSO655rqBK1lcU2xptMQ9K3KIhKyyQsFWwXMA4Ay5KB2sgdPd7jSFDW4g9evSs/xIM5Qzbm8FbarVvsSx4gttYjwYyAnRLkhv4EA2rqCSpaDpnwfPVR2XJz/IXKYaf6urE5kbRyowf8ALUphhru2uSPxF+nG4HSw8tVt70EdJE3yi+DhIWGfiX+LozE8FAlVGP6rj8sa5dLu9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UViUveNl/6yUhxypEM3fhcf5Nzi9Ub9BqCds1HKY7zU=;
 b=bP3IsMt7U2DmThESR8EXspdjEgLlVZ+jXPpvzZEFv8DaPji3xOh4KAMoYDH2On5XwQEU3X/SEZCBJgf0hCXLxikic7GGp6Y9e+O90zA+BH3CEysxf1puToJwfwQyc1Do37WZUqntYGKHTF0WPNa+XfbCcD+eeBy3pEbxFEd/QwrPGn44j8ykRrj4hCguJNbpxtcK4/TnzVddmyLwAgOwoITEY0TJv1r0D4knnBrh3Lbb4M1QvqylPpN7Qjta/PuW7watsxwKW7XfHc0QXcqpwpDh+DMZoEDIOH6ncY0JR/doZ1QzXmUbSlhOGkRWCB/kfnra1Dyzi0yf+zoEb3AfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UViUveNl/6yUhxypEM3fhcf5Nzi9Ub9BqCds1HKY7zU=;
 b=FKAH6roY7rgHrdHujyfaVlfnNF97o34ZPiOEmmZKxl4hCmcQj5yX1xz5Lwi09zSlHULmGGu/PjFbcYwl9cZsFBzwjgQl4N9xtuCMYlh5hXbnBBM8C5poNq6GNttslkaMMGLFY9wfZxxwo+dWnQDbTc/7oAH+F6ofblPcGSrpQkRl2Yr1UZnlTyt/jbkEAfzoaPPv+84hZ3588s/9UMKFI4pBZOUDz4VR5rjkl/2lkSqnSFTpxBvbFhRHC7j2lAVFY4hKljTjk4kPV/F3wzu5MMG4bgDw01HYwQAPdB96yU5Od4pBrCP3YaMZ8eR6CqcuZnAJcnmHqUCG5FNujP06kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 13:38:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 13:38:42 +0000
Date: Thu, 9 Apr 2026 10:38:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: UC QP support for UAPI
Message-ID: <20260409133839.GA1848866@nvidia.com>
References: <20260325101843.1893866-1-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325101843.1893866-1-kotaranov@linux.microsoft.com>
X-ClientProxiedBy: MN2PR10CA0034.namprd10.prod.outlook.com
 (2603:10b6:208:120::47) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 80afcfc0-ef2d-4994-0027-08de963d4f61
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nekCF2hRDcSngDU6rlRQeq/SMeKvOAty8QeGA7iYDyXQDqJrQHMLWBXCtdaj6ypuSz7a1KaWu9Un7obEDL2+L+sUG60TPK/MGs0C/4EpP/eV748ivQtaF5XrIhVx/P9HBvpD4126cMiVKoXu5UAOP1JAq/LH12ofOdInM8nox/Z+DTtnl8n8bvN8krQb1XhIdUIRF12wTcoHhtgzfDvFSRl3fCfuK4ysti5PlAwrqVOfE4/GXt5dfsHCnLvJr/uF1MQyrT0npDWwkFytKs7GC3yVh6BurVUzeLKOUCHtSjQpPGBYJGWut/TRTdsjF5384QzyH4aayqbBq+Pyzxaljk7OSRDvVxnpY8gOYtMFEZG81yIMSZ8yZkGDRmTgxxCxn8yv1JcL9YEH9+6+LzEcbtAHB5BHXknrcOu5tByugi9rMJtG+vvTAsapB3dJKxxa6Y/5tDw6VF+Tu3oPdP4XiG/mB8g515Pe+8m9W4rBH/KL5QS87wdRsVWM9UraiSBt54Uixlqe72T0d1x16UerTE+hr3AiQfa0tMF8F6+n4BcO9ExTPUnnoB8r0cuinLcHzP2Q9llaehE2R6DgYNM+R99oRmXFoZI6ltFEh6yHxD93c3fPJP5cgulP2tmYWZQr2MTDsndypWsvrpvvHFvBrVpx7qWU7n19df03Z7FD4CfImqDV26pIOH+ua8QYDTAqafh7KJpt9L2hqhJQH98a5ySf3ol5HIAe8NXanPUwW7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6Jl1HWaVUd4bQtUIBslBSRApPjKvaPKrjLnZE1pIgS+A8XiTvXPUIsruPV1?=
 =?us-ascii?Q?kROKjH5CcPpOfGlYJ1+hbZesE92LJLV1CGjFkshO03Y0k6na2SMqjrCdoE7N?=
 =?us-ascii?Q?4gq5LJ1jB52KCOMVSg6oUH5o+4PCoZ1G97Tww4LoogEqKMbrWmuAzwHbeOAS?=
 =?us-ascii?Q?GoQiu17BICqvhgWhLz7GQev55y7AWYqcJEe6slCiMF3lQ9O6qrcgMBiAoxHX?=
 =?us-ascii?Q?EDc0XW0GgeLDhFLmeHETAJahhmDJdtXEFDGEKHgCghz4ny+KqJPMZ2q3wgMc?=
 =?us-ascii?Q?nEGDFNCD5hDnK6BDqkRua8T96BvHILtte4qDspUZO2w3n6aBXSttKFhWgvbb?=
 =?us-ascii?Q?1LqCT8WGDz2YG6949AK/VBq0hhRdUX+xMAX2x7fORfCMZfqTB09OPrDMnxNe?=
 =?us-ascii?Q?Oa5waptlkOOT6gLu7z7H0oI/VYu5IOtAmNbgkxTi3OH1H8WQaeR/oUDRHA17?=
 =?us-ascii?Q?LDeCm1uDUm+a41CJKe/kNPynpDMl2gG/UDHOuii2Af2L7uLPDSHNEyMYfqmH?=
 =?us-ascii?Q?6i/Pd0axBtOB7jr9VLERNYq0pYqLiAkqcEkGs8wZOTV5/jhdY54lmscu5rzq?=
 =?us-ascii?Q?2I8nmuigiYjJ0M2FAkc0+4xaUSS7Nz8vsq2fR2Lc50LosXeR/pL4w78f5RQU?=
 =?us-ascii?Q?4ofsu6AKmGHr6HOrkD98vrRU25DHyKz4woR+62ONXu9ZnvCFpKaMBq/9e3gS?=
 =?us-ascii?Q?eORvE/KSMEyXzLaHgZ6+2kEGdsDRjEFEX1/Jg63wrq8RaTDPZR+sNCryZqM8?=
 =?us-ascii?Q?IYrFDBCMVQqhGzwAnLT3NVDiR5kIyGhB8UMxlZaSzTWeO9uNT2OD4VWhcdYe?=
 =?us-ascii?Q?bgyVkUwPVEmvCoae3Xs8Cl2MLfUvoi9ZBpPef7DWqJQpH2navKLtmTfsVrnz?=
 =?us-ascii?Q?OhVs0JKATpozX2xCBQCkvMMVDo+iecmjuKHhrPtvt/0LF189L5m/2/QYCOzM?=
 =?us-ascii?Q?aEWVv242KIhOtGHOqCrOtZNcVQvIoHdxIB+U6nCY9Y+91VJOq7k8FXoxQUoT?=
 =?us-ascii?Q?ujJ++bWDU8voo+Lmv33NK5D8K0aAqXe2M4QbKQ79axSZs0VpPJ4dqvPkxs7o?=
 =?us-ascii?Q?J37+laCLnbESkR5Ep0jjtv+fCCPhfJM+rbHkkhkZ+HHz3Fx8OeFWTbbJmdLY?=
 =?us-ascii?Q?ULqvJnpvr/Wl88aIQ3yILPB23B73XMYkF9DVRumJcNj4CttIjZvrU2AB9tMa?=
 =?us-ascii?Q?5hl+QeaiD8w+X+761OC+TDz5kJAqX1+0VFlYOytPJKdZjA2+36Pb8DczT57G?=
 =?us-ascii?Q?KoIFlkW85EJ8C2T/bEeRmIlc/ny6j7YImOKcr0DB+mgboooGXBVDfqedm1i0?=
 =?us-ascii?Q?FrXbqekXhKuytiqHyIF/zBiue5G8c/4/n3PPt0soXwjjkA1963PKsAjxdXp9?=
 =?us-ascii?Q?eGZtoP7VOnrF6vBUBMk2TV7Xvq4oMdhXVy9bL9q51N32fHpObgidx89dLFtv?=
 =?us-ascii?Q?QFxSh2HS9VTK4HfUz1sW1fRGsZ0LW3ej5abYVMvaBB9P/39dIQvwrtz7N5E0?=
 =?us-ascii?Q?emkKhp/9EOlqOmvOjMMeLlsibxaGy7Rcc48Hc6yjAQ0HfbbtSsC8xYCIJ29N?=
 =?us-ascii?Q?tKDEmto9eCr5gDgDSIJFCenfhDo8hRyrcFRLr2DRuwAeZi+Ov8S7FVB1uN6n?=
 =?us-ascii?Q?RevQuRqzoaPQolB0/uWZaSA9qo5A/JCPS8jlucbnQ1lQxCRTySW60NQwYcT8?=
 =?us-ascii?Q?kkOTMBeVmONkTM7LnXydXBPzyFy32IAWKTFCWKbK4+BF+RkC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80afcfc0-ef2d-4994-0027-08de963d4f61
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:38:40.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y/B+t7amkOvUFjCFSo63VYEyUSihgxBKbZi5RbxII7SGusAbQFNLgc+NHeSQ5Wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19163-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 811333CB5DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 03:18:43AM -0700, Konstantin Taranov wrote:
> +static int mana_ib_create_uc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata *udata)
> +{
> +	struct mana_ib_dev *mdev = container_of(ibpd->device, struct mana_ib_dev, ib_dev);
> +	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
> +	struct mana_ib_create_uc_qp_resp resp = {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct mana_ib_create_uc_qp ucmd = {};
> +	u64 flags = 0;
> +	u32 doorbell;
> +	int err, i;
> +
> +	if (!udata || udata->inlen < sizeof(ucmd))
> +		return -EINVAL;
> +
> +	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
> +	doorbell = mana_ucontext->doorbell;
> +
> +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> +	if (err)
> +		return err;

This all needs to be revised to use the new udata helpers

And you need to audit the driver and set
IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA before adding new uAPI changes

Thanks,
Jason

