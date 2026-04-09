Return-Path: <linux-rdma+bounces-19164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFrcF1uu12kMRQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:49:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454C3CB8C7
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F8B306C7DB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D043CAE99;
	Thu,  9 Apr 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qFfxr5la"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F3A5E62
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742069; cv=fail; b=NqwJzTDXeA+948yrlnIsW9qvKJqTOP85yjlOoJ+buSRrAIv4sJ5nyJUC1s0qWpbi+Pcg5wMrMhTQDVAdM1ahsGTEvfeUdoh6csTzF8sRprUwT1P+ZxL+F6JXIB9o0G3wADtqgW/ziWtCx9/0UXkrWdZtiGibL4cJdZIA/c0/hG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742069; c=relaxed/simple;
	bh=4D3M3Lex+HQ/cvnPlCeoB64fQebqebQeEYooLDVRiLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5MjjsY0JDCBprni4K+uzDMI2tOUbJ6RpdBsAmyJYDI1iyp94MUhh0rYG+CBXku5fJ2qlok2GzyecmgxhUavXPNSnx8aruA59MrvFwmPpL33H45kSvT/kg4VXp8ZczyKAXFI1kNQ4XU3rMWX6jB3mZtqFaImE1UbubhYhm5gFa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qFfxr5la; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpzFHdNS8+YSE9xykAKnqYmiLDhiFE3HokrJQzjdOFth+jg68vMWa2s7E91SvkZ7nitXx+mx5VJU7iuTMQ04m61gzisY+aSLmLf24aRi5pa4pRFymWrUl7rg3sAbea450nuLznefiGY2UNd2J0kyJ1jFx/EAhjdH/ItdMowXn5j0Wf0WBgeMiaZYnaoya8zjy5iOWV0kz70cp/IzZur/3wcej7R2MVh5eGuS05YfioVrUXJPCcclNu6ANtSXf53smJRTP5OgAVaurBVYBWLzBFLcPVqJk4m9AM17q3yj1H0hA5f5IFS7RUEuh5cqc6XPL4fw2Ylq+UWJXoSvYeL3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZSc0KwKDhYEQ7MEnEnncHsI3s0u81tI/gSnsxuCQd0=;
 b=NXl4Vwl3RoKADYMLT1fH/Kl65hXDU6bCZ62AUsWWZSxA1RLbN9B4jqs51eEJ1IW4yUWe1WZyxlDzn+a08cfEQBuy3mvP9hqUgBYAMlpBj3lCf1A+/szyP0ql/1ALuP+AfB8qp6xGJU8dCBjbRA9TMjg5yBrTF5gnm8l2zbbWJJKO5sCZjGyFyauyUiQpnI4uadYegpG/KrcnxPv0Fw1xyWwkZWix/vZGSkrBsWdJB050exog7ntIvBUzkqubakKm0NALYMDCfrINlaFPsILmvApYmkxwaomwDhehjrPRIU0yWxtBwvJd631ajyL4TR0EB7eHrJmXV/tmMOn53edh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZSc0KwKDhYEQ7MEnEnncHsI3s0u81tI/gSnsxuCQd0=;
 b=qFfxr5laDAzpi7bScMsWOGaY17TEqpuDUDahEEFPxTZqr0jfmpltesi3A3tVeYQc11nWmysfsYNQeCjrGYL8C4+4oOIxEBAOrb8kzIQ/QtKA5E+Fp6knOrx8i0w/TgYs+PEYHEfZ6qIY2IBrIBEesFggXNM3AYI0CPJFpjDZ62XhaTbJqgTSqxtRW0ecpuFttdvgC44wiqF2/+toatvpxgs93ftSAbwd7A6XD5xsrMU/37dl+SfP0z4BjmzpNL/uv1Qv9G04ZN4N7F62k5cE2digtsGI6/oDREuLFFBwgcnx8FvUW0CL0+jniYlX9k2OAZMN1fZeqZbaCbIX0kkfMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 13:41:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 13:41:04 +0000
Date: Thu, 9 Apr 2026 10:41:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Add writev to uverbs file descriptor
Message-ID: <20260409134103.GA1851273@nvidia.com>
References: <177325041723.52970.2153579331168741909.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177325041723.52970.2153579331168741909.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 1825e1fe-4bad-4c04-5b6c-08de963da559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	G/PWpyaqO1RTXEU+/AY06vH/0e1/gBJHOTHxAJN3vNZdK1zNEVZGbpfvOTAoTmvjYuveeEaHqVyhOe+NQ57BeHQkXe0rlawnpEYbmy+IusXGzPfE6ev6lP0Dlj7qcbRzwXNxZGgvd3/UTQ/MrzQKZKcxn6aY1d/aP1u4lsGFYnpyk7x32ETfOdG9CQ5fK3MyCluWW74fssiMGXn11yFjunwLfzH2/xwVgvPRbn0qvg+kbVeVXmW5rhvxCMRWEA5RVyGscsjD/e/srK1IuwSwjzdulVPC6nv2wOmggL+GUZPPKkeWBAH7bnaiinhLbmOrcPOtSvv2PfIuYt4uy79JFx/jCqZ07bHdfcISVrcA48l0SdKbBQ7YR02aqTkC3hckSsVTxSnYJHsnsv4YC0KMbc33Rk8z2/Ue3mNHA8B0olvOEELhn2+vvaJyKFs7O98oyfZRug5UeuLft3vdz4rPxbg86sn+duxOOghQCJ2z30T6ovXpNKzii3XGO11pMEnjScc5MjCLr8eGyks0a91P7UeFtZQdw00ZntVNrlSaVoB5/VH5XfNR5+MpIzKs9s3043Ibpoa/UTHD3gbbeyPkRFpiGDCWEIIHxC/8pVLKkZysm6K95j4px9AeXoT7V/4aqcHSKGZtIbSV9odRUnQybQ/EEGdCn6Mg94s5aS4Bx76Owu6hvMKeJHBhzNFqAhv+rTpucLyhNSUSfzl7jXYtpzt0oi7VXTPmtVgnwF/6sjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkGyyMN6CBw81f5BPstTFXyzeWSbwveMwfsAGUixzhf9CvHqngPmneqtAWk4?=
 =?us-ascii?Q?ZoOEpMaIsTNlWuHjTyHJSJTKm3iRXT18nzgU/KBGj2A7triVFMpEYE8LcFTi?=
 =?us-ascii?Q?xS1KF3slvg+1WTT04mQaih0soDDygA7gPbXr9gqFJttUVM8EnYZewQ+dx3NV?=
 =?us-ascii?Q?UqVXo+AH3r7Cs76skXg5+Xw9nehNS72H7XXUBMWZisjjCzbGcmQf9f/m3mN/?=
 =?us-ascii?Q?egDEuqmJlZ7Gt/gI6twwiY8D5qNHHD990nabzP3RxsyaY4ZtQ4CjaYwDgZG6?=
 =?us-ascii?Q?PZfwTNQROZydStq8VVIbUl2JUE+pvnkJCWX6qjY79l4PJWAMxkCf/FFfrN1T?=
 =?us-ascii?Q?6xZDLVODmHG4xZOvJckAPBr8qcOkhn8K6k6gH46v9gr9ZXy38IAeaVWyX7XN?=
 =?us-ascii?Q?GcWXenLJGQTrTg3ZfYUvzcKr31KmSmAxRCZYS/85GXpHDZN/3Cbe+hHp/JLP?=
 =?us-ascii?Q?fVIxWyFJk3w+3eIX4L59jqCtIRGhdZG86ncMnLamrXOt6ZttVjuFnYWo3nfK?=
 =?us-ascii?Q?UaB5Dnge+lNx0StPfNwpc5p0X5SgJ0baHF2cxAUa6ErsR8aE7Jz4YGCgMjoO?=
 =?us-ascii?Q?GpKXOMHg1K5wqa8B9p3WOWZCg9eK2ZNvaWKCLIYu79FhRT7S5BnwtiCezKNF?=
 =?us-ascii?Q?J3rqh6LX5bZSU12sJTRwY+DHnCRG14dA2kxE8g9mVnBtYk5UcxI6dwEXtzhL?=
 =?us-ascii?Q?C6AClgSLYGPB4rQODk7d47kjRyysMdZr7KGJEeKLFjlJT01E1r5tb0kbe9Al?=
 =?us-ascii?Q?PIJ5+26U6q9n+E6Wco0YUv6+XpDwYeN3jm2zDf3sELVZgjHyeoZD3eNhTU4x?=
 =?us-ascii?Q?ZLygPjN1zsyiVkOqdU4IJ/LYebdAcPhLNZrG0iLUbbVcouSeT67w29RrPcXZ?=
 =?us-ascii?Q?LtCiMcg2HLDPOspBRxInjnhy5szDIwsnxx8TSAZNen7WeWkVW48wbNwczlx9?=
 =?us-ascii?Q?MHvonotQN4dG7oCMUA9Bbu4aicsjWg2bqXdHbfkPSJj64TKalYCk7i5WCyIW?=
 =?us-ascii?Q?f8rUD6NYqgHdkhO4iHIWEGDFZiZSEiQFP0dWnJVlN/31x32MD4mymXg8BlJO?=
 =?us-ascii?Q?rEHdNKuZEspptFsaYlVoSUNQutEJTgx7bZa94GFJUyfJ3QX5TAxFowT7SfcN?=
 =?us-ascii?Q?SRk0t2RWh2DB0X60T++1Ol4nmf5qDlssDgxfxQ4vSgsuZ948piik+bQslu1p?=
 =?us-ascii?Q?O5y9Nn8GfK6G3RcNmXxVzUzf5K0s6lmCfcx44qCf+KzaHI+qPmcbGuV5qSrU?=
 =?us-ascii?Q?noundxG1LYN5t+WeY7ThgWIE6GRxnnGO0O+hIdNaJ2h7TzAMdGkhPAXUR97o?=
 =?us-ascii?Q?Aqm/enUNyjAwGQuz6f+ZRcisnOADZDtsdMlj8NzoN4IcxA2fH0456gvs6gZ6?=
 =?us-ascii?Q?pS4MOvnMBTt55ZjD4KDF7Vk1KYDRkrvO4ZMDtB/ioKnWUCGWLpd4T5WO3mYF?=
 =?us-ascii?Q?WaD8QkYlTjtolPCtgM+ZazPl/RqSzVsQoJ+AD+LoQfmQW8sktCUbqcH8RGn5?=
 =?us-ascii?Q?IKQRWQx6fZpjWiFzdnMQ7ZN024vfaEU4OEKfSHJaY5w+OJeG1I7hH0liFKk7?=
 =?us-ascii?Q?KY7ZCPoTJ6kIkjO+a3576WYst02NDfwnzzagLgj3JKwH0x5ZAajBmBSHllI9?=
 =?us-ascii?Q?gKHF/1pUIbHg4EQf1syAp+0RtxeoNqD7kZfBKxnjoQ1DcfLyUuxA9zW0XgxK?=
 =?us-ascii?Q?f/0VQi1/OX4rLcT4q0lCCW5RQpB11UFt5zlEozWMSPVb78cP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1825e1fe-4bad-4c04-5b6c-08de963da559
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:41:04.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxmaCh7n5i9oGKhcPuE3QViqNPWeM3WyTN1vu/DpxyvCdXF+Oa8SvR2ZlBheUTt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19164-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,cornelisnetworks.com:email]
X-Rspamd-Queue-Id: 0454C3CB8C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:33:37PM -0400, Dennis Dalessandro wrote:
> From: Dean Luick <dean.luick@cornelisnetworks.com>
> 
> Add a writev pass-through between the uverbs file descriptor and
> infiniband devices.  Interested devices may subscribe to this
> functionality.
> 
> The goal is to keep all the semantics of the user interface the same so
> it's an easy migration to the uverbs cdev from the private cdev. The idea
> is that all the command and control is still ioctl, but the "data path" is
> still using the writev() to pass in the iovecs.

So the main issue was the cdev, not necessary that there was another
file descriptor.

Another options you could have a ioctl to create a compatability
anonymous fd that just does this writev flow. IIRC this was a
performance path in hfi1 so it would be better to remove some layers
of indirection.

The slower control path can run on the normal ioctl mechanism and just
run your write over this addition FD

I'm not adverse to this patch, but something to thinkg about.

Jason

