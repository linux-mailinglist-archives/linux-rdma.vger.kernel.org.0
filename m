Return-Path: <linux-rdma+bounces-16868-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHTIF1Ucj2lQJAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16868-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:43:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC391361C7
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89F83017C1C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F434D4CB;
	Fri, 13 Feb 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jk+yCBk7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4634EEE1
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986557; cv=fail; b=uOkFPyvEyHQ6He8OnLTBFAdeNS5MHOJDkjiE253arI64CzZfPGOZTQxCNwJvF4m/AZFhEnpyho7+K9Yl4+YkncyTQWIddw4Y8mVwqf+OnTFNgdd2r5i+28aQRTcrvGZmUUItAZjWvp4iMz1xONipEfntIsUfrp5Kvmhe+aXgVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986557; c=relaxed/simple;
	bh=tQkkyGzxWnOp3aNd181Fg+jdIWK3c0fnPfQVSCTlQ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9C9I9pTD3mig4r4lyUS0p4IDCpHLPMnCCyvgOlqdAZzUo3Zck82pa4bdJOhmNdzY2dD67zZw0U0A9WHGOlZ45l9uXJBSezG6vhMdxd0yHFHrKoMf1UznaM4vRTp+DJzJPx1mY4Fy2rT+O0XrP3UVyDVCP2e7DoBdL3WVB4J5/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jk+yCBk7; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gag2K5oy13+oyqvwYlXx+wOvsCslmF94xOif6R4MfyM70FW5WU6sIt+NOo097F4p+wTFOB5efNC36O8yljE7pWndc/QVdSfcnnhA2vAoJDchNX+ar8ZUrdLmX7D8Tcu0jYqeSpLzlpINhvP0XCrDfD8UKRScuHbyZrnb9gpZInyAP/gWpD3/UlwCKrs8OUT543d0MHcmrPw2CdMyZtAy8LCuVk1lAs+NZB20DTpRmV9oqweopo4sFp13sn6776NqImEKBznvqB666+ZbPU6vKsuRQBkXlWMrbreT5mY/48U/2/qVNJy/t4q+ffgN8UqwfwsmSNnfCyfiDP8/C6Bv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/2bcaPNGOTiW3of9cfvKGEkHGeNkDcXJ5Lin0Pp/+Q=;
 b=ric36Sp7gAKrRuYewYJcaBw6xJ9nr3X3h5dJzsIHChxkc28ENcW2IkJtnfobU1Eqlp0EKBfgU0a6I1G4pocDwskMQRjoblgc5y7frdcO+EQSbaf7rnK4o9Vmwind2kXJTuyQs4DIBh0bcChlzzowxfiQI38MQVlxLfP1Swxun5U+j+ABU2WZz/6va9jrzUTssdQilteFPfzXQM8MeAPigMgbTKimNnB7Q4BbnwcyrlUi/1vmP/QWrAxc1+rDgwBynmydGdJysAc/AV8qdPM2qdq0wkBh7pJaq8ARO2pnwu7ocHXXF+Q9jhikE3uhGQA935Z+lRtiK+E31v9QrjOlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/2bcaPNGOTiW3of9cfvKGEkHGeNkDcXJ5Lin0Pp/+Q=;
 b=Jk+yCBk74u5H/FXG8y+q6y7zsIt1wpPNreVLXnOPafZVqLK8IjulJPAOw0KSAytX7BwXqfmFFM18w4f8s7XNu0/MDRqWsQDZqumUJhPnW43ncAOW+oulFsJ5pfMPmSAfzoiJFNaGPNZqrjDKA5UJJZX2LWS8VPtyYW5hESwlQjQ0/Bs2Upn8ADgTJbsBgAe5VWjmA1cP/54GrW8KrALOu8Ep7WDoSJUE4JcpCvFLMecCunSof2zPvwXaQdtQIUnXL/1bUj9KV5qs+S1oM7s0lwr2PplTcioKdu3ZaA0f7oGWjrLyHNzGpVFwiDIcsYRE2HeBK4DSOFMxz4G1cJR58Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 12:42:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 12:42:33 +0000
Date: Fri, 13 Feb 2026 08:42:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 09/10] RDMA/bnxt_re: Use ib_respond_udata()
Message-ID: <20260213124232.GC1218606@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <9-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213104024.GN12887@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213104024.GN12887@unreal>
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: e64f1b24-4340-43f8-b3f7-08de6afd5b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tzm1Jnho+qlt9F7DRLl7jInEAkucLNES7AmIHCKUS/n2DaBdANvraoT90eZU?=
 =?us-ascii?Q?Dhtf/xOQlZGytiUxbrrwK+3542oK6V7SKLUS4nx27CdFiBdD2jgGKGOrbu/2?=
 =?us-ascii?Q?lfTEXy3l6wESIWXGrylzYNPXGDmivcpJ6qUvBSYZDWqqxQd149n6Om/OIfAv?=
 =?us-ascii?Q?2X97sItqY05FWHyn21CTrIFnq54hdkN6lU2aZYjKAc6SOd1cjoNbNbu1BhQ8?=
 =?us-ascii?Q?NlvUUEHONU+NE5/IdEuNYIvrTlWva+4StNRKihCeBmqIAlDmqnfXQLRB++/d?=
 =?us-ascii?Q?Xe+shkAeeEbFgKLwQOVMGRX2KN2Bw8bJJyFV5U551k1qT3L6CeCQBypTKDaZ?=
 =?us-ascii?Q?H59yjL623Yeylhe8Q2whq7dx9auPxTG7JTDFUL9SURpiFi3yykxvK2p5V+3Z?=
 =?us-ascii?Q?vWJm+EZyrubCDYLM9MzIHo+pZ2JtRm609wccjIvTLUe0L9pwBKpHns/Gs6Lt?=
 =?us-ascii?Q?9tFb3EhW8UrjwDkhL6ncHVLMq8KORwH+lIGPk0oZxbqqPx0kTOL4snnZDbW9?=
 =?us-ascii?Q?Buii+hUxZHbzKwxNcja79oBSXaoCbg0D6r0B/fTz8tRwoNSGlCCAwERJHX+i?=
 =?us-ascii?Q?3TBs0Kk9S4xSIMwpJJEW7E3y3p9E/wUkylVDhtMdHNP8kXi8MB/R3yZq5K4X?=
 =?us-ascii?Q?6KPBpJhUoL34PJpME8UTw3UsCHN/tKWsH4FVUMcY29CE+YA4/wWN8DbfXv/c?=
 =?us-ascii?Q?2/GHoUAZlWqySl1X+8IqcVQVcocHHE6EezcBENNL/TuzhrgexueDt9qysl3m?=
 =?us-ascii?Q?tPvtWmAmZ/1llTMGWxXFYQ0sCXIUyUEEi++ItkpzAFPJzyovr5xmk4bjUOb9?=
 =?us-ascii?Q?M/oP5yr6jhN0eYzgvqQey/cXdAAH2wv6mr7ucyFtVYU5JeDiqu/sUGmmo1pi?=
 =?us-ascii?Q?ljBq0KB3ehAZACtTpgJ9dFHGXLL4FoAPvYVbZ8nnM8VqTlJ8F1IPWm6phY7w?=
 =?us-ascii?Q?1kZ3xChauEwAWpWngNihyAS/8HJHr5Dm55RSrfJasffd9Mo4jPh6gfZswbEt?=
 =?us-ascii?Q?5szaCRpaz5iaz+febEQ0v+LJO2JEvRzPkbdS2Wn4dEfnq4Y7E0bnZQXMSmsh?=
 =?us-ascii?Q?qJxgFk00AHJCKhMWZXmf7Kl/X0kNXmO865PjJExzfNpT8eGywIUjkxx/aON6?=
 =?us-ascii?Q?8MsJhOloIZb2ux97stqVR/ENSWrrYqkcuUnqS73dAcUXfRYNMtp3mrUITJHd?=
 =?us-ascii?Q?VR6EWsyuQJT+MEmYMmk+SCm3Bey/jKnsgLyQ8vyr9tS/KQQvnGnJer5+Z2mu?=
 =?us-ascii?Q?qRFO+KbybFEzz0j+0AefQP7gpZc9H5MUv/6WnONhS/m8O+V77i1G1d0lJ6F2?=
 =?us-ascii?Q?vrJ3wl7sYu8L3xjVOBin/nXNnT4gtEzJ/pyPRf4Zi4F5jFXF5j9PRrh2AP6P?=
 =?us-ascii?Q?lkULAY1vpQu/Lk0TSDs6ZX7K6MgzJaLA5IFdy134uno7whz/prpzFJ+spEwk?=
 =?us-ascii?Q?gmIU0ZR/7x9Tk0ShgEIjvubEE9brHYy70RTuDYJnhzptReBqQ5vWXwJT17ml?=
 =?us-ascii?Q?cNRE4g1K8FW7cviKgc7K9jZ7xsQ6nDXdUYFGWlPq2B7ubqXwuhyd/O8txWvZ?=
 =?us-ascii?Q?+JMKFnd0ouoogdlnrLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+LDUbkr7EhP1O9zD8k03ORig7ghu3Y0w1g2i0LR737CiWld0eTnLBMnPOHr?=
 =?us-ascii?Q?g8w112CDsigpAOiiAUxO0BFbxPnkbUxqywA4zjO071+oulBb1CWd9f8cOT3X?=
 =?us-ascii?Q?NO1WLrq3HV1UWQRdclYS+axWJn8YsPsDKKXe2HewqPGZHnGnSAhxdrbXJW95?=
 =?us-ascii?Q?qMb59ZHyP7Syg1RkmLifMADIrOtRU20/wgQXeoUhlMDsdkkRrtk6UbO+pzJj?=
 =?us-ascii?Q?ww9FY7Iu5vck3vVa8EPKrn5+uekC5Tb/J9t1y8EenNWC8cZB0hcIUG3T6RKv?=
 =?us-ascii?Q?xpyJyXfcxbDtQzmh4515ImMNhJajEGbYXOz0XokFTmSUJhudcPYQZ1BCw6Wv?=
 =?us-ascii?Q?xlTKKHeoCEV8WStGzfRwNXWJyCxO5sMwIEoGOTDb7bDq6coLNHouuvBkfC9U?=
 =?us-ascii?Q?rSpn+318pBJWninLU6Uq2/ixhJQs3PU6MguTz61+KRVaHjxHtITl0n9J6cPt?=
 =?us-ascii?Q?PVEcaOBQnTNTav3R643MAFbEyMvNLxtAXJG3OGhTOvJUDp4Vsp9EKFgPcOyr?=
 =?us-ascii?Q?9BiogqWTmWlrm1rPs0vPW46b0je6kMN12ijNf6qJShFfhxgx0biOfGxbktHp?=
 =?us-ascii?Q?4vcjlHlhW3gRDwREGbQ8KZqe9nzLAK0aJf9fcxePCMSImzw11uc9MmNTxWOI?=
 =?us-ascii?Q?7vvJRwZWcKhzbVwyolF1vYBIN8+2wwrG8rYqWrfOknIjcMqInpc6NzQByCTj?=
 =?us-ascii?Q?ra+UCJAvJCiRmD4WR2p4Yq9JqdHnsjcpzJMHsraJ/asXA+LMbaR326hq9n5p?=
 =?us-ascii?Q?YwdzDN3FTKos6YILX0tjtbaNoWkb/in+GQ8d6dNfP2FGNhMPoEL3SOX/fn41?=
 =?us-ascii?Q?740s6uBNkQoJrt35q9m8SewveATIValg7LRuVUhTgoiAlAGoIwHTk4fg83wh?=
 =?us-ascii?Q?52oRmJ71iINegbWXkJB66s059jOkFCD9U7QMsMy4DP5hCQyIvg4kreerPne4?=
 =?us-ascii?Q?SpM+1l9tE4uOSp0edBrrdJem/9BLlWb6KFn14vf3uGYkV+7AkiAN8dIDl3N2?=
 =?us-ascii?Q?8o1J3KycIZPDA6eM9IRZkW3SKmkTE4ZDIDswnZrRsgnawahYRfQL2o8W3uk9?=
 =?us-ascii?Q?w40YuuULX57UcF5Me1do22dNDCKx3jp/xeHKy2AqpWpTvPDutJ3ixtgEVS1c?=
 =?us-ascii?Q?q459CrTUd9gcOjoffkxwW6kPfrt0MYLZViEAet0Gv0n26snwQI1S8C1DtZm2?=
 =?us-ascii?Q?FwAFYfwfBQH9+iiRNusdvJDtZ5XJlSWVMs9XXAbbGddbDGzKwixhzmEtAlME?=
 =?us-ascii?Q?TWZr+Qwz9zAAIvG/ODhbBHnIFc4aL4VQesNCYGAAHWhuGl3Ic8v+bXte/Vf5?=
 =?us-ascii?Q?m61fy13xxvs7XAuTSvfOfj1+9N9gES0lUGGz5mPc7VNhRn/iCm25APBrw3JI?=
 =?us-ascii?Q?rln9B8z8EoWrLKdnWRT43n2df/+Ytdm9ctxUfll3ly+AnuW5eWClYmmCLywB?=
 =?us-ascii?Q?5MDmL4Gmkr1RBS50AtikbeU9pFlkjIUzspp08JpGnDYRkrQNt6/2yoAfhxFn?=
 =?us-ascii?Q?yI/J1gbHlOwIIlt4io2lQkZaf2c8pFaCBNfau4rvPvwHiEoWTHp4AIobURbe?=
 =?us-ascii?Q?MkBJm2+s+mhmELwQIJobdAkuFYUy4csQM3XoLKBiA42XD4mh/cZBQ1L3uGjj?=
 =?us-ascii?Q?QSAuPCizxzaoLQnq4ESdRXvUR9f2eJT4+cDnojsfnJbLT445LcCsRGuczEpE?=
 =?us-ascii?Q?6EPIP1I0w5Idq4nmlJF6wBDlnYeyMgppUHPJAby8hwm/jJJhpcTH5BUIbXSc?=
 =?us-ascii?Q?ozEFgnjTtg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64f1b24-4340-43f8-b3f7-08de6afd5b96
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 12:42:33.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvVfWddWZcbAEk6+EPGg2crQZjIZlIsL5zCpvl1wECGbmStdqxsXXwhi/iNrR7Mt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16868-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: BBC391361C7
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:40:24PM +0200, Leon Romanovsky wrote:

> > -	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
> > +	rc = ib_respond_udata(udata, resp);
> >  	if (rc) {
> >  		ibdev_err(ibdev, "Failed to copy user context");
> 
> Should we move the error message into ib_respond_udata() and remove all
> the corresponding prints from the drivers?

There shouldn't be an error message at all. I didn't try to remove
that stuff.

Jason

