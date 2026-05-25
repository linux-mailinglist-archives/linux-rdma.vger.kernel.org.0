Return-Path: <linux-rdma+bounces-21242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJRCEVRxFGqXNQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:57:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3925CC92D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7E3300D443
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F43F44E7;
	Mon, 25 May 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/iHokRU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E799202C48;
	Mon, 25 May 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724288; cv=fail; b=WFDtwkVIimZ1TTxRQHI78uOJF7wxqvb2mTtb0ZzYbBl8hgT167qPfXTCbDdpzAisyZjCoxUJQhsSJs3JhEEf/lK6mcbIoqrjUCQhSYUHaHaFXdyrStATtMmFDL+DsfJiUVpMxS4iBdFYOp2cWQlPbY5TBU5t5dxVgerMtdKqmLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724288; c=relaxed/simple;
	bh=uQidvUfmryA6zkK5w6jtTo+e00o1X4QGJN6jDsKIQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sjQt/5I2mwTwDyAusOQPL3EnHnGrbCfkgHN8PNkTi26lGFMBxl+F7U0x373qJWQtX5NsXhlnvjKhMMOvZm2o/LEW+n9JM/d4POw613TffXiBl6DPVP3m8KYttFPTzDgw+nb/lJyFsvnObF1YKaqx2KYCk8Ar38gru0n3v/vqFXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/iHokRU; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j40Puc47Laakde10dQOkToaFLAl+4Tr2yHFd4tVqBGBtAZiWLeqbbXNGaThb2WHyJiKfwwU8ILbVOS2va2FGknCrakWXjsBe0OKov5qq8PBt2TBprjc6WDkS5wJn21ZlgUDhqqSC1DgN4yedGtWYEydwWruFEw3xChQkpoR0QHg0qMfSFMQu8vV9TGhXTlttDVn/J8h/w/6/Y1AMdc85KircEZss8cu58mrYIfhucA0bvEYHccn/Cq/kk0MulOWuc+sBF4sUsPyJROPbRm0yI6XI1DEpIkvHIfcDaCQy6FxtazXncB6guux5WXsgIZqff4aW8VfjNmF6Ii9NrIjvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjd4o5ls00i3IAy/PWNbdCENLvmqP0Y6/rssnLLRMUA=;
 b=nxYe7+oLc49cQj0qeWOPqnJKcqYam9GQpuSxWIVTvMVTxzMDIK8upWUNy16B2z5973BEtFaYaBveNuORIZWKz3uM7x944Yyq6qwZlC8HaIFsHBHRSlBkra5qLwXprsdD7MFtVWIHiCfnR9/kwln+YW4iI9w4fN+hakNsU8u221rwBkMFet+GP813PkCsmRX3a605govkk4RZ8cg12eN2pyCOIVLeWCNCP2JSMBtW2UBh40zjjeOuhqxOuLGAgF0Ifz+DZ2yUhVBzqxgnIkZ2hz69wdUlEjvUy/LF057l4fWEy7ScywEqHtEH3/mwjaUp20GwqM6b1FqeNOPEOW+rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjd4o5ls00i3IAy/PWNbdCENLvmqP0Y6/rssnLLRMUA=;
 b=a/iHokRUIMBYpifIC94xkNPlQ3ZwYhPH3mbCM94JGCc+Ucjpq0c8chC627EXhiDXtBbm8+MOgDnUDkvm/Zy1fAHcOgb209F/oqGADMvt5KdMK5mYJswoexb5McdIdl/cLvhYidSFtMIiz4tmQ4HBJpeF7EnyQQMpSMsZ7W6uLn9xU46msN3+0gEPeteOD8Nh5+fa9NwLVfK++3wds4A2CzKKLmFiCLN0d8i/lKB9AbQe6FTEEi2dyBxG2bJxcLOgv1PyjeVoT/oPJP3y84rb+cQn35+jAB/u0ET17qsAVVUCkJODJ+rSbUNejsGNmMiChGjd2oS3QAOmnkBgzZqaSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 15:51:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 15:51:23 +0000
Date: Mon, 25 May 2026 12:51:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: fix dead empty check on head->root in
 setup_root_hem()
Message-ID: <20260525155121.GA2486765@nvidia.com>
References: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: YT3PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: d82cab8d-60b5-42de-0fdc-08deba75785f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fLyPZgnbjUOm8H5D7p1j7XiHtHN5CIDHDoFQo018XGvi4NERprmzKJXn91OZmb3odzZC8Au+Sgku2nwm2ey841c0ce2XgGFNlrQx9Er+YWomCK9MUbqU2EFZa6EsgwK7eAFl2eJS8oFjAT4x2se/T5NVmrfVOunhyJ/YVktbw+B/Wv4WA1ClXLOQuHT5m0ZF95vZWC9DXEuS9Mux9LrwRQaZCI35Yh3LAKKAU1IJrEs4T9UL3ShM3zyIUtQqDIESakVlUVtn9HLgzfLNHoJohCQmquNuH3XNbRhrwQOiqvQLOv/Xp2ZbWbirHBHLupDeHamPjyr49TVxCAfrwmrhLi+UjMrhESzJHGsYk5MRf7NXJ5B1inuDIlitqh/EImQVjCLgclBZaaZ7MT+pXL9BD8lnY54WMuCUMobG+MbQglFP64ifQh19K0zkYqldz6OxXlnc5N6EXfyBohdMN1XJGdMhozFKZbnNJD/aFGGk2swcB2LW0TjEJ18LxUHxQyBCp+hGN/j40eQUynPC3Ohk+s/OeiKqPc6J7Pk6FmLojyZc84bfOAGRy40uGmXNYjSjnCDcKrQjCpiNUosgItyPyKep7F66SDSXzdqfMHdHSA+fU8xvjKS3aRlhoP3BDfrF0WczfaEyC/F2Udw0lyHWAFSxSlLJS6Em2VCrDYayaayDVMP8NmM9M0RQV1nQaeM5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7BTX8yyrEXjnhZkY5AsZ8Vk3fOk9p7AfRGXVtn51AXyo9MSchQT/t8MQfP0?=
 =?us-ascii?Q?v1sBvXowgfnz8z3VfffG9S6lMlQCG1EkwZsM0zwIdu1JTC8BdR6rgFDTDXQE?=
 =?us-ascii?Q?4uMwcfyOs2zgl0DxlyZVPDRGXvkd/dgJfA+RclFFuNA7x3RvHnXoQFDRwcs+?=
 =?us-ascii?Q?vziZhwkLIWzVl5DX7eEyC2BdcTxXlphuljKlZIVRVDEci9KeZamEie7AffYZ?=
 =?us-ascii?Q?N8FfM3pLfKzMF1w/yEk9ozsyLEc1Dgv+YuqwMQZTMQ88LebolnZkdGJgvmue?=
 =?us-ascii?Q?44TgpH8yLJ3pVL/fYIqzijJpYFrge6oSa4MePKgobqsxZIq/8fvI7sotaEN+?=
 =?us-ascii?Q?WIkyixPibv/8xpQt+fNDHPK+QwEUNQ+MQPqwqfIz9CyayDyqsvdaAL+qwwl+?=
 =?us-ascii?Q?CSBQ8+2DfmKnF251wwanWv8s1gjQrDAnKNnX/0MZAn4MyfEx0G/pOtS84+Cm?=
 =?us-ascii?Q?MhFkafdMZAIltM4plYpe573u+YZ1h6Hko2u5kVQSr070Z6fi/XqG0K7WWsOg?=
 =?us-ascii?Q?ZdOP7sq6aqZR3oxS069ExNLGs2OFqHidz7uMo3kC5jh5thMhO01oGl7LtvLf?=
 =?us-ascii?Q?5QTT4425UbNO9XQE8MRelp2SfiBL4Ibl6XnzuJ+KCDTXq/imaBkr/oBHtqsS?=
 =?us-ascii?Q?y0EbYTI0tDUowISA64mBipiGL0Pt8PVHzIr7ebfZHmcfYu3SPg/vr0QzDg8o?=
 =?us-ascii?Q?fLmzDnE3Fou0OqYYz72j3dQSXx/fcVByJIpkNAJobmdCSMf3pH7U5dgrVtY8?=
 =?us-ascii?Q?grpM8Q4yeQQyHyxDG5CSKg4BvXd3VvLvAHDQualmfq8med9qJgQKjkxXT1iA?=
 =?us-ascii?Q?xh4B4jgbYGyCdZr75b9Y1TDVE1mdLELsi7S8VySUWj5gxanKL7hXsER3TlJ7?=
 =?us-ascii?Q?vxukfrmBD80It+UAlrc+uhrGQeRrs2PYtU/nS3fZgaYRoaoaAh8sMAeRA5zE?=
 =?us-ascii?Q?7HGl7ilgtqvgfwoxStJGjcEi4RMjRM10T8rp3hUazlac+dwULGpAqvk7wUul?=
 =?us-ascii?Q?ojUkLt0saknkM3xdSuLk096YCV2RfVD5nMgATJL2q6e2ARqDeLOjh9Jpfxv7?=
 =?us-ascii?Q?ao7vH0xs50u356V7wERwHZiJTHRl97QmX75BZKdBMv2CkdSJbAJnZjlaJJUz?=
 =?us-ascii?Q?nrNqiJ99rkJxi8/u7esJiBNdtpoxHSAfsFJ5RDBvEQe4uhBtRck8qHrJWfAx?=
 =?us-ascii?Q?sDauJjWSmsR0tW1j0gCtZ2fDOrdMHuXzjFNlX7xItgG93ojbBRcof/NaQPyh?=
 =?us-ascii?Q?qS30Ht84QMnWBTR/4r0W1q/a87c8+3AiAFMiPXBzKhOtIHf8yoJ0XVk+opd6?=
 =?us-ascii?Q?6JL8dIiysMvJKnqo8QjfRkPyt/yogkqXxuDNfxFJRe1VUV49EfJRmRBA1o0i?=
 =?us-ascii?Q?nhakIoFIu+YMmTDRRjXhnJeub6AbrzrTfhPBSAf4LnwwiCUmzMHWvMYNHer8?=
 =?us-ascii?Q?mI555w0PYuY6hS8Rrj2eODvXjcYuYE5dvYGJz9mmLtkvOybSFVxGoFjF1qSa?=
 =?us-ascii?Q?UGvnW0XPT2nSyWR7kYOrJAX3Yitj41v7gNG2/3OFtpqa8WdwhPhdZmhjliEL?=
 =?us-ascii?Q?QgiCKz3O1AKVf77iTdyWidKGh0jrvLbdghvEJaotD4PEiIQjmV0Wb1LycyXE?=
 =?us-ascii?Q?5eD0u/RIfHudPJLoO1fTH/Y0RZ0HhO+2h9uhNuBIf4AZsW8lWVd1mTLbCGxv?=
 =?us-ascii?Q?J0h+AupnABrw77mY16QrBtdcGmYgG6MBLOho01A4+b9QNkfQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82cab8d-60b5-42de-0fdc-08deba75785f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:51:22.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKKCrf5r+7wK1qUWOAw95VH/ANK4aXmOf6sYtmaGZOqfUVfHLPsK+Pom9zb8vdLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21242-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: 9D3925CC92D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 09:20:45PM +0800, Maoyi Xie wrote:
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -1267,8 +1267,8 @@ setup_root_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem_list *hem_list,
>  	int i, total;
>  	int ret;
>  
> -	root_hem = list_first_entry(&head->root,
> -				    struct hns_roce_hem_item, list);
> +	root_hem = list_first_entry_or_null(&head->root,
> +					    struct hns_roce_hem_item, list);
>  	if (!root_hem)
>  		return -ENOMEM;

Delete the if, the list can never be empty. The driver immediately
adds an entry after initializing it and never removes entries

Jason

