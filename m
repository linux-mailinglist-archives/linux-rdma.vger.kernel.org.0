Return-Path: <linux-rdma+bounces-16657-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PzCBt09hmnzLAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16657-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 20:15:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8A1028D8
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBB2E3053EF5
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537E42981C;
	Fri,  6 Feb 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZ02h4+A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA8A429813
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405066; cv=fail; b=PbxY1ky1/vkUO5E2Sw8XQ/k6+PNivmcfuom93X1ptgPECN+LnvqFFCt1iFUQHripcRNMWUsJuZgiB908HLpQDQWSHctBY4Krhmctkh78g0+RYi2HhFM7BYg7tryI2PWn9rKuHyYA0GtaSA25o0WVcl9k0Zk7NSx9VH2JhwX+ET8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405066; c=relaxed/simple;
	bh=oK/Xatc6iFKI9bskiH6MDzAtoVby2oM+j8z9PkeyDC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ijdvi9MUY4xww0nKVa8gZvIaOIeQ2BVHS4ijAFcV6vPOYoKJOzV9CtYmJTpdWhiInvGD+Iu6EB22fCfFm2AiglqgPkI/cqus+/CFv2aZuhpXgAoRpAZzgE7eWA7OEqss/b1n93rPSFoHOTXSxllv1s7yL6mM13iTrW2Q00WF00A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZ02h4+A; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO+SAsXEQbpNWr91Q86N2Q46FN1T3WRGoNpVBWcmBk5M6KpZQy7GTPEJqFlCmv8etM+AcNWPrp7prgykbkqYrWXjAz7GyyY/kC4kZDmW0pvy+sSJ0ZimHjdSnvAEIoK5tMyVnyEUdzNzcU7r0VXWfSdk1/b0N0S2UJ1g2bVuhG9I8nYF5wDRB8ebS279z+atOUF0Ib4AhGk9YyAt62BR7mNTWHlx0/ZcEMFQE5tGJxZf7qgmeAy1ke3Q7Kk1v85TIHG+IE2NAmzvx7pyQ0qsV3LHHTO1ZZYMPYAA2zdZubmpg5i4qW9dtulA6jSZB1EnUTkQt/am3pNEoF58TxhcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCnGMuapkRnphvvJeQHoTXjy50QZLDA46bgtIDz3JCE=;
 b=VMGI7NfQm1ERhx2c6NATYyWhB2L4aA1vjeArQBwEwXr/kCfgZrjBmHY9m20KNqWLkvQPxTKlSk1cULT2pmpUIsJ6DH6j+igMKteteIBKnMQPWfeVmsrbiycFJ85va978NtS7/7Qbp4MS+0wzvMILmxSdemOL6nCCQKM1xuqhLNCCjEF3Mb12BuNFciyzXX4o3tEXUV84xzOJBSaX9Mv+fjAafojU0eKf8Rbgcgh/7QgjAeJCfZbYOM6I0tRugvRsaB54s3Wnc3Y0+MMvJedqIXVGpcgQoafwSs48YFzvacg5vk7wka0/qDfFLZuHbOXf70+fr7tt6I4+kkZieUFTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCnGMuapkRnphvvJeQHoTXjy50QZLDA46bgtIDz3JCE=;
 b=mZ02h4+AEmeoinqorxcRnlB70TRL8EeHSztJbwpOtq5+VAPelTm/N0r0xpX9Yd+ixmsnFLDp9XI1CG0wJwKEZdQp+ud5H2IkFTHv9y23q8sAK9hLsZ5KUVSZuvYNTA/1f5Ky2mlJxKMAszkf8Yv2ry0BbeA36kFj/55Og2oS+cP4WXZBChiTsOKJF/kBpwljsWv/j7yzDGQUbkXPU4ymnl7xQi415Jh9+64N8+YLVikhK4iXq7Zg2U7RRoz9I0dagBmyVn/+TWlXKNysnjTXt1z+deN40Bjd1BoKdUDE3mhlHcUORtqBtTzPWy+jPrH/EMrxuAAlASkI1eVhH+keXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 19:11:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 19:11:02 +0000
Date: Fri, 6 Feb 2026 15:11:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>, patches@lists.linux.dev
Subject: Re: [PATCH 00/10] Provide udata helpers and use them in bnxt_re
Message-ID: <20260206191101.GC1874040@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <CAHHeUGWw221yuH7Ac8hbsVc+dMBC2GDnPZMmAjKMdu36wkY0Zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGWw221yuH7Ac8hbsVc+dMBC2GDnPZMmAjKMdu36wkY0Zg@mail.gmail.com>
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: bb13f698-67fa-47f3-3de2-08de65b377fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxxtMZuzdEBUbgCUJcYL4p/0+GMlm8bsHuG3O/w5cvMRvXvAXPA5zf9lXIhm?=
 =?us-ascii?Q?2PYwHqyn6bPgsif4IR6Bv4Aaq2jsfZ8cvDeNGa/lCXVDx2GsgZHobIGBZUuz?=
 =?us-ascii?Q?dl9HY4YppupvCfBlCGjw2APmYBIwQirXuxg7Ha+BOlwTN/st1815VEB9r2iD?=
 =?us-ascii?Q?Ta52YtxByzPh/uxJdNebA0k7NzXE/6Ln76gBPI4msObPRWPhEjVzKALzemmE?=
 =?us-ascii?Q?VYvFCnRhYxVl+MM7MgGopgq+h5juGyC+OxCRaEE9BUr3Gr1epzg49Dehpw7/?=
 =?us-ascii?Q?zBeC9Ikmk5+XDpwx9yClQpVm+i2WdcFMLph2UJcVN908JE43OshdNaeAsoeq?=
 =?us-ascii?Q?w1xU8Fs3qfP0+kVqM1rA2EazA3wOg68OzagWZXIhPKfFQoIVwaP7TRTf9JHd?=
 =?us-ascii?Q?IxP7y+w+9YbVZQ/SEL2S+6ObKU1JFaczew9HNXfoZ3ZNFUVT3G29FTzyW+C9?=
 =?us-ascii?Q?gL+5//3rPfOnmALzIs3GRgaDlcnP0ItGfFXRTpES+PdcAIQoZ3voNadXGw4Z?=
 =?us-ascii?Q?8IqWOZJPEtTJZHFVkzICFbbEs0AGF1Uu58o27CygXJl5/om/swLDgpqBO5U5?=
 =?us-ascii?Q?OPBfGfzG+fIzK5QwF4rxFsXLwzjwCyh99QJSbyjbnQZ9XyTLuFl4vMKF47RI?=
 =?us-ascii?Q?8OGxOmhwVRvo6WrlD2vyO8siSnnpnLEhXrZ/9gLB116HAmVeDwqwwJ7R7lAj?=
 =?us-ascii?Q?tVvUR+tRuEegRqU/rufjM9xL+PY7tgdEN3XhEU3P0bY90/9rVu0xdD+zem11?=
 =?us-ascii?Q?wKTAyY1NF2i9AyYxWkGRD7bJUtj1bYGB+rzl4lJW7jtGc+4Jx5O6W+wSt4Ms?=
 =?us-ascii?Q?AJPtfLi/TIl+aDmXKVIdwis+JXLfQk/9ZNQWHlFRDDGX43iX5Nyqjpa5hTN5?=
 =?us-ascii?Q?JTzu7AyPjFxjZu0Ea4TD1EzSl8CoxaEO6sMFh9KcVVIShys5V7fCuJd7ps9r?=
 =?us-ascii?Q?iJPHzRTi+ExkVbEcWJp16u+rbDxP0jtPxGxP7JTROIZpHEMv2IriNr5+GcIS?=
 =?us-ascii?Q?Xoi2F5gD2bcZ+G9aQDmDLCxX+S0tMHoKIMp9yxV1xK/HYQsfHc1+6VjQ728T?=
 =?us-ascii?Q?Entg9vjp2hs/vwFbjc7MvMIqzklIiP3y3pR9ybGCafEgJy3D3BxvcovKJZj6?=
 =?us-ascii?Q?vQJD7BKMLlYK6eeOkGPSLBJnji/MI3TNnHY/NiM+HFvVf+JYOdOw+Tmy8UBb?=
 =?us-ascii?Q?xIn6o00+I6mFfEpRAP4wFvGGjNlp7AyO27uP9T0xySUr5FTOjTABkY9uE8ZM?=
 =?us-ascii?Q?sPOPanZu/9EKenG9zhQ3hLrWI4aJxtFX7/nEroQAR8DebbgUXRc5GDu3sJwk?=
 =?us-ascii?Q?Apm8nJvGJO9cyRFDgufflm7P5xyN/mHW4lg6K6ya49nejwyMLmb1MLK5oH/m?=
 =?us-ascii?Q?IkKPKVnbFBmQlyUCPZk1Vr7nUg78G7ybwC8UlaH/fOKXsmlnxxf4vVWuYAPS?=
 =?us-ascii?Q?YO1E4h8v7aA+GsPSGoogzTnMG6c6gecNL3f9/+81MxL2IQ4pJ4xhv4UOGZZw?=
 =?us-ascii?Q?YjqV3yikPH2EodHbTdsV3iETTHu648gFjnh/LLcmImAIaIlMeUpGA3s7pPIJ?=
 =?us-ascii?Q?3ONri+fIxq+KE82gy2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFoFFF7xnZoklsDm69IKChxBnF9fn6NwPjHGuGjUuJXgTxVVfV6OW8b7DGai?=
 =?us-ascii?Q?0K1SzcskMATPlB8dfp3jocL1JMbH7CaYSslNRMk7aMgENj1J8zxz/jIuNKYn?=
 =?us-ascii?Q?kEQSKmoMwfPRc5FoNO6ENZxeshbU8nlhlIBiHMFnqW8k1jkCFU1N6QCYl4fH?=
 =?us-ascii?Q?2j2spmw8eX+akp+zqqB2kKbs8krOW/823wfxrr6lMSa1z6DMH/pW2p4C0pYY?=
 =?us-ascii?Q?jwd9Xos9bFly8EsDEM+LGHl0Na7h+14Rrrnw/X1e+I+ITh6h1ZUwidg5B7P3?=
 =?us-ascii?Q?059wUDw44zMqg/R1l+lQz84hpFuQLnQLLdmjKseSljU0m6iscmx2gVr4NE0G?=
 =?us-ascii?Q?jutsbmTdczJJSI/c3NzI9Saw3l/rhJR+lpvcgvxUk/HZ4cqXGDkLuyjveCvJ?=
 =?us-ascii?Q?sGyI6EqWMxuh1xTHL2b8HL/SWjnwZf6v5Y2K0kiYsfWVd0sIMQY514s2LwSb?=
 =?us-ascii?Q?YPCywtVxKt5ocWMuR3rZRqk4ZGDZgLaIusfZavPWwSvc7BFG7t3754Bf1FD3?=
 =?us-ascii?Q?LKtMC326T8mjIhxSsLCumAUsCUV71920rRiftucFIGgVsEbRvgRPb62t8Xqs?=
 =?us-ascii?Q?okP6pTqiVg/85xjrapsaId0RmbvQNnTCpuEip+kj1c6r1kJJBq5Aq4nDo4TT?=
 =?us-ascii?Q?fb1efQFQ2bK+6ew9W7zH7i2j8Lk2or5qNGcoMc+81WxD3hE4TQK+Nqcgt0HU?=
 =?us-ascii?Q?1NG9lhJzgNElt9tP7Ssv4dCcWSZvJSuqeblph9c198Q2+DgGk4V3Jt/yWbOL?=
 =?us-ascii?Q?qHAumY9S4nsjhJUaa9Adu4B6LaWXUftGDmDCN9NaVdQN9MNmRsc0BifPHzey?=
 =?us-ascii?Q?nL+x679FLJFXcrjGR+nX7TCQ4/fc992MIdXSG895WS+79kH27NQQzov+L8UF?=
 =?us-ascii?Q?Ky+7Nw/tJvt5ttmOgycgZ0B+gPUPZR5BlLZrweW1bouT3xPpiM35ICLX+AB1?=
 =?us-ascii?Q?BNMKAFsZkmLyvEasOR8y2KcSFyRylm1Asmd0gnm3nPZSQrYaC3aavI1ws5c/?=
 =?us-ascii?Q?x8AvDq34Vjb4F8pkhnGkSLCRsY4YK7tXZVGHLu6a+rUaAgD9z2w0ItDjzfrR?=
 =?us-ascii?Q?jWhVO8pxVw7vZOCH6OPs7bo0XtLXJQhmR0rwO0n4BLRN7u5YGwOde2+Eojfu?=
 =?us-ascii?Q?SBNPWsxul5aGZGD2R+oO0tQZ6sGuWbkatnyMjgzZJd+TJV/z6FPqYbk92PgB?=
 =?us-ascii?Q?WZXYrTTVIF/FGUn+CwigFyhDZZTZMFl3RSnctHrEUkX+Izj8hCuhVmJn5WwD?=
 =?us-ascii?Q?UaCweBV08U2OoJ6OVm/4/gaKHnnHtQanbiBKnExdblDzBGCGapyWs8/bmDUp?=
 =?us-ascii?Q?1ZBNAhd0OdxI4wE26MHP4Bi0VPO41x6kirUYboE2raKaojEYv/eY2GO5c/S4?=
 =?us-ascii?Q?KBcpG4U5chx17ji0EFgISXJOGDbWPXHMtE5kXuxP5j6wMduIIqw3O05rAQpU?=
 =?us-ascii?Q?Vc7UTV88RgqMUJzw6lki1zgD5ffASoRigeaEJEhw73QNldu47YulNOUjDtX9?=
 =?us-ascii?Q?jXe4LxDXnkgEQKEEZkUpYre6cChU1OHRkp8fzxdo4Mbc3AE6MPhsQ4oFPtQO?=
 =?us-ascii?Q?sPOPP31mI5T/Nl/u9nGFYPJhALvwWNNofEMD2I7VOBSVZ73Msl3VSLDKIwhl?=
 =?us-ascii?Q?SGUXfhSJ9HlMuh24QsBULCp3u+cLcQdBbYTgUnjtqNBFEVpI4DT6VVnk/bou?=
 =?us-ascii?Q?lm8UJma4AWm71osGzRdiKONMRRxgVi5lcH3dEXxCm5c93M4ud5ZGa6ub15/8?=
 =?us-ascii?Q?4Afg+vebnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb13f698-67fa-47f3-3de2-08de65b377fe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:11:02.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Wlkl4tUBYnqp2BYGYjtPd9eRzI2b9UQzUOSlPQZUD3NmiCZAf3k6WT0UOk5AShS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16657-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: CFE8A1028D8
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:50:07PM +0530, Sriharsha Basavapatna wrote:
> Thanks for this patch series. Patches 6, 7, 8 and 10 failed to apply
> cleanly, due to conflicts with the recently merged QP rate limit
> patchset in bnxt_re.  So please rebase it.
> I applied this series, + QP-dmabuf devop patch, + bnxt_re DV series
> and tested it.  It worked fine.

Okay, I updated the github branches and we can do this first thing
next merge window. If you send out just the DBR and revised more
trivial CQ changes for the other series they can likely be picked up
immediately on rc1 too. Then you can work on figuring out QP.

Jason

