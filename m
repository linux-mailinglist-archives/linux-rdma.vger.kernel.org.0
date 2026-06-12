Return-Path: <linux-rdma+bounces-22179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 24w6BOoVLGp1LAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 16:21:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD267A1F4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 16:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Idpp5c1N;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22179-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22179-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A0830CDC4B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85653812C2;
	Fri, 12 Jun 2026 14:21:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930F31ED7C
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 14:21:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274076; cv=fail; b=Zl66RK8YyZEJFPH7AhSwlih7N9/eYkxYTSh41vxQaB26Lfc3eLkv563egDD6YyUlhG81ZO3PolM3iEIbOM12Licf1v8a3y0OLWesw+37beulQgVIG2AYO5DkcUsS60V/RIyzer03DODXFgLEI436oJXnDbLzAkFsqWTZ6QIIGGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274076; c=relaxed/simple;
	bh=wVRQWykWwDrWCZJIWCP3zrfKCgQTtuouWFK29nUYMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XG9c5+u3aayQv3AkMuzbuioCr9+nEJMVZIcfu504CmuVceBydLWyQdOrPNvkyOyBdcVkBEr1bH0YVIIViLPNsbwTJ2Gi18+eDid6bdw6hz+WloazchciLbYBVbwnqP+4CXjsEFCJU5PuCCqPW9QKKFvrAZux5gQEqg0NbG3/vVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Idpp5c1N; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdbVAaUSszre6S08et2ydQ7C3/G8jmgl0u8S32zu3nN+ecSYv4i2+Vvxal8+N6WWDExfhy7RKmXiqUEcDzS97J/TtwpKZwPecNxJ3cql4R38HKFjbh0lZ8hswiQpMzR4b2JURyfiL6vIn0vAKv4t5FNYzv5Pdb/+MzEQhxmzcUibkWycYqyFCe7KecoJAHfJ3OFxyZIFnqGkdPJAL8EJWRTzdYfoqIHzlP4RuY6anbdvGYUdnJ1fuQ3AMUjG8u8sxlh/qz7oU+UKUyIlDJYsorvmohcW9Q3wh++RD1gKZCiwk8dnc+Wl5pl7DaJDCJJuaQDru67wsRvNg9z0WuqzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fea6Z8OB5tPJnpzUr06WiI1ZUk+DIeuALHgnjyCyc4=;
 b=rOMPUQEbHW3nJ9D+mpnfnwTYZzqQpZQTZhxjrpMABRcUiTEXeM190LCHgfZm1gXoDY6LC4EcRSD07LY3dT0oHrTcuk6xrqSHGcm3q7pok85OL2KIFljSJVmD99KCpg1SiEhjMLbyaHHByMQhSSZrmt0spEsmqoIIppgEmbG6HFVqoZKe2tfj0hu3vS+RhGBf4tGMKj9MVOlimcIDNzk8sinryjz9M/4eOjXv74TdrHmtZpWQUxPpRkeTup3/SU04FFj3QVWVPMPlJLI1mFpCWi+ZS8vIxRJ0gbObNBS6bEMwNKOxcOFWwYDyKtDItkTkrtK8rE7kHYiHFVEoTQ99VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Fea6Z8OB5tPJnpzUr06WiI1ZUk+DIeuALHgnjyCyc4=;
 b=Idpp5c1NUUnsILn0qg+irXdmXG06Psm18p9mQJRb+HXru6zvquC/0h9NuZ4+5wkrZNdpMTI0tyIXYhFDrcoAYiy2yWFyVlOWgSdqGZZ1Zw0yXwH8BBbOu7vwEWBKTtfAfhXUGbJnXkXMgaUvEnUwxYUQpQNr2VIEO8gvSiC1W2vKMGTY/dtGgbxGPI+wYnON58naAwxy5VX1NKhD6VuZE7DlkAwd8Fyxu8LHh2x3hJnRtDozgCAaHrzwsdjQQZfvLuhYzINQhk2e5tcZJEw0csAVvv1Lg3sAO3PdfByNN4ai7FFgTDwuJT1cLcwt3T3P7MA4ZdSiCCfRzOsn+TuqCg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Fri, 12 Jun
 2026 14:21:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:21:10 +0000
Date: Fri, 12 Jun 2026 11:21:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] ABI: sysfs-class-infiniband: minor cleanup
Message-ID: <20260612142109.GA1879774@nvidia.com>
References: <20260612122611.183127-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612122611.183127-2-manuelebner@mailbox.org>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 555ce535-3d97-4f25-35ce-08dec88dd9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6/ZKbYb76z9UTeX7WjVj+5fYOWNv3qFrHXSwL4NSOoCzo436PYXTy8AdYOxjM0n6NyYcrHTtzHeZr7rIpSIMTrkPR86+dHpOVHrHRFnQZxtIA4xsMyN91GwmT6n4cVUdHi+iRYTgoAARiP40AyXEu0JK4RTtVc91WTfQ8UM19VWev8vpwK2yzxWYo7ig++VZF+XOJnzOhpbFW2DXvRqpb/cezAxeQlVGC7ZeXR7iBq4xJYVMUyIex3txcQW0cbq4XjZPJRIR0VonuJg9LTICqOm9OElPL2hxht/YO/10hGOTM8bZLMuIAaD3sGweLoTlXMqVhdjGHc1Rx1MekkpMKb1uKKp49QGXPOlQlyZxrgycFGK7HbetXM+bGpLfOrQan4TxcCmjcZw+IJ7ZnWa+XKsvHOk2qp6ush1geujiVhPCU+MXjgcxg/6oBcJXj+tsubBtKfVXKEjJ89rbIo1jeE3qRaDYl6DHhzAST6vIj1u2QuTmW2wGwaEOUXyG3vf3ik2JhVYtERWpedoEdBEmkbBcT1mvbTDUMEaC74+whuc7Ew0rHMSBq3GnIFj5jRnyjqeIbWRuU7sg+/23M7ZK0EywsIhjUpMkU0Vlkz3I3ji25ilotARY2VBKlkgBKS+HwHq2InrD/WyGbrvs+a9a9Nx7/QSrup6Qs+GyujbtqU/aloTCdiYZkJoKhlNv4j2Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UWGZmvcXOlugbhDs9bSq8MpFlMmeLdKzH0XLMpaBbfspACz1fn7wFekA2luz?=
 =?us-ascii?Q?yV/Cj7r56kzqEvysM9nrpBCaA7YcVTg/dSD6rtct+YHFb/SarlLjEEeYpHDA?=
 =?us-ascii?Q?hg4uA1oQ7CjNOgVYz9DBNhjaU00s5/mZ2Q8ZJcXs6ma7sOOh5lEeIV14u+Yv?=
 =?us-ascii?Q?LSb8Wot9Gk0hfqeRyk8fjVfdRl9LvYP6Q1qGFHtLQHGWuG/+SZ4iUahWSnHU?=
 =?us-ascii?Q?skrGewTz+3a6LIXawjFSMvy/F20P25svO4KttConbo2MMYsY8G1QACOLV74a?=
 =?us-ascii?Q?yaeJWoUCGzLkM2rdQrNZBJ8HTRfL3h7B5ZPy5pJJJ5WEFp8Nit5gnQNcq0th?=
 =?us-ascii?Q?BABtgjaCkg2bwT1NrCE3YIPZHjFw52OLW92JVdXUSj5OuC9ldkYUBeY7zYtT?=
 =?us-ascii?Q?jmAuhTHttsb2lj4Z7zdNYm1n0L1E6dVIhg/D+Sg/zZPhQUzTxjTDhi2Zyaqf?=
 =?us-ascii?Q?LnjtQ/ZFdmdcGnU6pTCnnUV4no+lHX1blc/ZDGUbhifg2GcE7ouJCgrk/E02?=
 =?us-ascii?Q?9RRI7AUKOZB7XmW/F5vRnhSjZHVikEIg/mw91t1kAiyabwophIE78tOZC/aT?=
 =?us-ascii?Q?z9Yh+wkiCmSDYGrT0B0C14hxk5GF0sIcPxevPoSIq22g1HEk+MAn0jTYGVYU?=
 =?us-ascii?Q?rmXZ52njVKqi7V3XTVfRpYryCopFTvwI1CAtRADdV/zflU7PXaqJQxMJgUlx?=
 =?us-ascii?Q?Bubh4wwTmXyq0XQEOTILIMdGAUHNcCUTGSJmIJWkm6FVeVq+mSzDSxGOQPov?=
 =?us-ascii?Q?fF+4yRFBYztGBbBAxZa4ik89lCfFv36v0mZ6WZxLfbjE638oQSxav43p8DMC?=
 =?us-ascii?Q?VYkEuJPjvUzOz1Rhqz0q3113ZPn8AJ06WeMa15Umnn8YAZcycI4AOh7t6HwW?=
 =?us-ascii?Q?g7XIZuXIUho77TwTU4jMM5offAgcEv7stCZSEafhokXnKAx/eWRfR1SgFepx?=
 =?us-ascii?Q?Gb/u+xJlwusXGndjjRmLfgGC4WEHmyUv4g0gPXQGM9BKPtkNNs68eT0CQnEI?=
 =?us-ascii?Q?0tTHId0yhXB07/eQk9SLlq1KunV1eCOoLahZj94ZyJAR8In7TgNZFBmAeZrL?=
 =?us-ascii?Q?bJXtAw6C1l9gZCp7F4H/iWeF897PUGHuNMg9BtFepE49n3PY1n1HuFrmjQgh?=
 =?us-ascii?Q?JAnyonBKdtU5rj7Q5Uvd8rAIz6Qjkg8nntDvqKZjSiFwlecBvtn8Z9juLghL?=
 =?us-ascii?Q?qAATEhTpmo/XeVHkfmNsSRYu0gpnfWLSvaQa2uvw5lTFdZzrat9bejFDkoVi?=
 =?us-ascii?Q?NIsZM0xv7FRhbshoxQbRAAjZp3Xv7PooXzM0bMR3zgvCe0Br4NiiwHEyXZvV?=
 =?us-ascii?Q?vdBezcyGzb2MyA4i2MvHLDVrflHiRrvuenrFuC196031n34bBwi9+THlXCn3?=
 =?us-ascii?Q?q91EgmUNO5gQY8ju51j08QzEQ8vaPq47qYW5+12RqzrTxKjmJdp9HrTxCB1F?=
 =?us-ascii?Q?G6ZzB4FfJapWMyddJVmR81FXzmQiFIY9D5eLQboZWFpF1ghGIzSCPjcYDEoh?=
 =?us-ascii?Q?QR4a1S1ImDA211shuQIQK0fiX5R9JKprU+GLwTFWS4hi9hT+hzNJrsd3BzdJ?=
 =?us-ascii?Q?vZDrMMq7RGUzQKRqa86pz91aelPTXYE5rbjG/kWPUjvv99sV+qllsSA+0Zch?=
 =?us-ascii?Q?dBOgLeyMPHOz5Npu+nwPf3qb8sfJ/NuyaH2TITNR2cn3AwJhTHdLhtJZLdBi?=
 =?us-ascii?Q?kv3Xb3qoS5d68XtWSsaC2Shd6++haEt+WgvHxuU/403AFCPu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ce535-3d97-4f25-35ce-08dec88dd9d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:21:10.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kw9VJYkhSnESYjwEEivdcfCqConmM/lIb7PefzYsFZRWPHrA/HZA7spr1nowPIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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
	TAGGED_FROM(0.00)[bounces-22179-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58BD267A1F4

On Fri, Jun 12, 2026 at 02:26:12PM +0200, Manuel Ebner wrote:
> Close parenthesis with ')'.
> Add '-': 64-bit counter.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
>  Documentation/ABI/stable/sysfs-class-infiniband | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied

Thanks,
Jason

