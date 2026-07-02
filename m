Return-Path: <linux-rdma+bounces-22719-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sek6MpSqRmonbQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22719-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:14:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29E6FBE47
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:14:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="IN/fekq7";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22719-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22719-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1E1302D5CD
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F83339844;
	Thu,  2 Jul 2026 17:15:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8223EAAD
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:15:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012548; cv=fail; b=RUNfV3DR/Am06MUO2ggvtD1D8+FI8jyFxmsCJV43caPbVV4OWM3lZoM3YA5b3uKpAj5iACR763xMBK2oaQkDn2t/GtrZH2ERa6S84BONxBwYM/mgqskGT+H11MDvz9IY4wRdSkzAODhOSvLUrNI0ljLyB1QSbwG8/4cYSiQwOJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012548; c=relaxed/simple;
	bh=s7uRLYviYZdLgXiYcquAfWU1BFdWlRawi3TBgEA0/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vEhEl7o4sY0SLO4rdjqmlXUL2vxQMvVT/HY459pCOMV1Nux90be99/+ePmKPzYEuHCE3i0W27/3Va8ufJ2lxBBWwfCoNRYsurM0DhELktDCrvX9FLZn00KpwbMxYLd0aQLcBeg+RcHG3S5q26px2zfTAzztYomOHiihooAPZDww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IN/fekq7; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KT0S2/SW488M4IM20VK3UxMm4a4i0IZT2XelXzuxZxsnEdXMwZuaukgRQ3liPW/X54QrFOhkb/WwjqAwN53q1afHrrNDNcsHvIgjhGyapKOXvRfPHGRoUJwk1Lj/SIYwerBk4pAn21/QeMgMzgoPh9PTk1fqAaJN3HKDOZqccofjKlTQ64ujipQJFTS1bmSBwjC/W9hDCVuH4+jdOFuGwLv4fm71XjaQWwbUi0ZT5R1GFQYrWpqzsmD4BvtieUT/7OvXOGT1jkG4lQ9w1IP6DwlhXnvra3Jt5jEjUHeKy5BjHVUkcs8aV/8hVdK+Lh1UP26AV2NaRHw5tlg5hkrojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGbPfCfD2FpuB3GtkpROzqBv2DLWSf5G2hqdB94NwBs=;
 b=SlLjlranDopfJGhLWOk1uZB1UI2/5to0vonPgOduL6vYyEi8SxBxrXt+CLC6Nau1IviZwE4Mgojgv8ZQmLxIgCPiYmJhkUHhZ3AK/o2W2p4dbdZkF0L/SfpRJbTVQ/Pb1c7xoi/Rx0+zg9WYYkVqAKWJmjCBhKA8/DlYZxX/8hvEcJ8Skxfhl3han4hVKKCYICm93N7xlvFjh4le0bNr3yCArHvEpUeqeOY4aAqhuENBnS+7x5SvSzMkFxzSKfHvzy6pR2l/2kC6lreMKAorq93Y57LEde8C9fp+Y/Hq/iownKMUT0iEMUZMoxHvBPCzhxgngQacIO3q3iwKpF9fWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGbPfCfD2FpuB3GtkpROzqBv2DLWSf5G2hqdB94NwBs=;
 b=IN/fekq7MAkcyk7Np0TYfzTFxLCSfet2dMW9RO+npp5NSbugLh5nB6RnmNHV/tYaZj3t+rDbuFJ5Usqy7klCBYBu7dw5PVrzR0giW6AAuG6986HlGjsF/MYghVkbMNvElYA1OGt1CXl2D6EAh8QvqZhksa5Yqx2rdfz3+nMqnHaDZLCXfT2XG550SJFGFxGO+WhSDt5KMgLArI2vHG/Z6F2mTosXOehc5yvTyajeXBf75R+5XdYtjyUx1Sdz16JyWh7Z6MCNDKNwebmm/fKgYR5vrFn7sW4ZstQwHhJOjGMS/FxSRRJZ6y7HjSQmeVkIC0Uq7vM0SjX/OEPh96GX8Q==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:15:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:15:37 +0000
Date: Thu, 2 Jul 2026 14:15:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/irdma: Prevent user-triggered null deref
 on QP create
Message-ID: <20260702171536.GA1502298@nvidia.com>
References: <20260617164013.280790-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617164013.280790-1-jmoroni@google.com>
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5b6c72-50aa-4d5f-7f77-08ded85d88f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	1pE7ulPnu+3v2PteZ7NC5YzLtHP8ANYAOlQlb9Pabp85qEtoIqZhxPVDKoRvhwxT4ilfvrwiqmLRFvZ8uUaIZYcjJy7fo3fKtJUDwj6tzVJS/8w+oaUMeDRzVGkQE/xCrGap7Z3hvaoDEpmQRVuECicdN1YWFsKrRaVrMXrsmHKkDBdlppBX+E/vsvtOzW5SPGhqCKNLpFIzi1y/CYiPzY05qAYtYZJeyFE1uvw2eo7B7ygG+VuKQWb0Nhsowaef1iOvm87rwhJmavMHJBAZqWCjTZrSp5gmiDbuxAloPcLoLVNMti6IzuWdSZWA0PmknT9wOqvWB2RgwTCDFIGqnvlWu8mMZ057ZC3wDDEEMAuCJnt6bZER4lk+dcVzSDRJ6mUny6SaQod0jqVHwchEipRABsZW+xNgwoWOJ7YXbhp1VgXiOitIMubazWB6rQHodBuaphfnMqqxhakpusAVQbQwGQeWfK7gej1Iez5snH251l0A9QM+Zfyb+x7MKnEMIep9uq4h9iJJmdq5c12p5MGipvPm+rumTVeykZGIJlcc+zO7pm0Pd5oCDlouTD7jM/cI8Zyiz5jdvxyHndgwk2O4OYh1fICZYVNg4hzx3RH2bJZVv8mWrRw1zWXu+eyj4wX2k9IU2Z7lqh0AKaY5VQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bokjTfhhk/hQuJyg54vBZvCXU20PI/CY01cCbcsYOZ8vHjvV25W5jva32fo2?=
 =?us-ascii?Q?zUrmGaDTexioYsOpNubD3/dQlfn58j/92FNGs1Ryxa+XMJFGazmrBwZkL0mo?=
 =?us-ascii?Q?oQu+I1Gle6x4TSYc1ZxD6FFZ0Hak9DMM0hBktQjAoLf6kGHwF0A6Hgnuz47E?=
 =?us-ascii?Q?WiTBt/QKhzXxx5nTXBo5JICSiNWfO6oQWdxVblB6TPy7UvPIlqPstNiLQ6P2?=
 =?us-ascii?Q?aIZQ6/ZNwKUUFiPd4S5YVrhZosJ8qz3ZATKccCpMOkvm/HxrkBXeBVuZ8DCa?=
 =?us-ascii?Q?fYVUVS5J3qFcU4RQdXaS/AAjzEuWrr8XQoDZfkPRl1692cxZB4NpOuA+WUkS?=
 =?us-ascii?Q?FzSxejmEv8UQfPjlhIuS9T9Da3arSRm6rHRLiRuqBJqBKYzyN/PNrQiZYvGV?=
 =?us-ascii?Q?qyKHaH4pnBnekRHW3XLjycR/6s98Q3N2BkZe5uCRq6cyVumTAygFuGttL5Ry?=
 =?us-ascii?Q?vhBT4pkUUug8iK2HXCJihpAV4Pw/T1gQRjtwWIeiylrJas4gzVOm7vLnq0bw?=
 =?us-ascii?Q?ZRjVD0q5s/UXUtjk4Wv1ZspjX+AXV4taeHVo8V0S256dQghJoMeyl3xBon9J?=
 =?us-ascii?Q?42FhFU6eUb6LPE9Jf4fSOIdfn8IWlBq9SITPpsn1fb5mvVuLlNFJxnF7coOJ?=
 =?us-ascii?Q?zGUsplmmwU/m5ckAmCAdLl4XQDQswpI1oDcgaEJgjPbcwWq4uvhBc/lOOv+a?=
 =?us-ascii?Q?AYFMPyCnx04u+BjcmtrkR+i9jKbfmCozGx7VRceyd/PFlgaFqE36e4bKmNLh?=
 =?us-ascii?Q?JDmjdNQgFB46TCBdXc7YXM0/xJ05eo/oe+TT8VqmUn6+3lHEPHQFI+5aX+PL?=
 =?us-ascii?Q?Cx6T2TtW+l877vqjQA8hpjZkQNeAq5+bCwB3byWiWytul5Rvsct85KV79ARI?=
 =?us-ascii?Q?Cu5X7FVstGEZsTBODC+FrMQ0ulUeVDEw2coXcyQ4rd5GZ2v0nO2GO1LrnvDR?=
 =?us-ascii?Q?UNxIgmT3hMCKfMw2K6W6frOnP2eN0tx46FTAsEZWVFAS5l/lPpX5zGEz0L5i?=
 =?us-ascii?Q?eKAig38eJumyizAZKn0A0axzGJwb+gRP3tbL05LmaP6iZPFNk97kIMeJTDM6?=
 =?us-ascii?Q?ZpJP0Ik7KPEM7okNn0gA55HcXNpu6zM7XOcGPI8O8atbkA7S7gW8Q9zR5UOR?=
 =?us-ascii?Q?LcvXd6AQYVAounLSVqTmR7LNjVSwcccG+csrnNmN6JQP6wmSKXV9YBT5acHV?=
 =?us-ascii?Q?e4f/yIwhy3UCQwpPZtvtzEH4Wzt1LyWp34Nqc80h+hZQ+p7RI/ZzFC98tleK?=
 =?us-ascii?Q?OxwTDsWsyrV4fTX7nSKsauV4qzieWIcUvOBonriH0bco2L7EeTncLy7bL+zS?=
 =?us-ascii?Q?o7GrgnF+msbcqBZqPf8QL4nMOhxe13+eaGyzy7ySZWRQEY8rnLJ4sLj+Dknf?=
 =?us-ascii?Q?3KjYuxMiCccgWdkp4POdOnGWdwcR40cKSywVODsk8azS0FNkGHkZ9xgSZlw5?=
 =?us-ascii?Q?8VOPtjRaFX6Ws2ugXKIYtlYF/NMOrzaTfjXJPR7a66Ts7QT+H04P7LagPPiW?=
 =?us-ascii?Q?wQctSWZ1kf4CNZD4B7qsKwzPTULnZsKM9hYvRFsAONg5Qo9vQwcZOOIcqh1w?=
 =?us-ascii?Q?lTpl8pYureiyzKlqkQE6mRSRfmeq/AmgojrzQe6sfM2BfigMOLe1y0YoMSTK?=
 =?us-ascii?Q?m6kLLXeHlhZ7ZI9D6DpACvmSbzCdegwRnIsa51860jdXb2wU4z6HdBp9Br2+?=
 =?us-ascii?Q?sLJ81+hH3MIyVd1P3Wv3yN8HZCHWRErnbzc2yCPLDtLapcCW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5b6c72-50aa-4d5f-7f77-08ded85d88f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:15:37.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYd7bMz475x+dzMiCOAbmgzP9oFyL9dDRlXImSXONege7cNW0PHPoug3X0SWJsGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22719-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F29E6FBE47

On Wed, Jun 17, 2026 at 04:40:13PM +0000, Jacob Moroni wrote:
> Previously, the user QP creation path would only attempt to
> populate iwqp->iwpbl if the user-provided req.user_wqe_bufs
> field was non-zero. The problem is that iwqp->iwpbl is
> unconditionally dereferenced later on in irdma_setup_virt_qp.
> 
> While there was a check for iwqp->iwpbl != NULL, this check
> would only occur if req.user_wqe_bufs was non-zero. The end
> result is that a user could send a zero user_wqe_bufs value
> and trigger a null ptr deref.
> 
> Fix this by unconditionally calling irdma_get_pbl and bailing
> if it fails, similar to the CQ and SRQ paths.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> Reviewed-by: David Hu <xuehaohu@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Applied to for-rc

Thanks,
Jason

