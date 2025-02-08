Return-Path: <linux-rdma+bounces-7577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50BA2D28B
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 02:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DF93AADED
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43972E406;
	Sat,  8 Feb 2025 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="byrcKPiJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61B29A2;
	Sat,  8 Feb 2025 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977413; cv=fail; b=mJMQoSsd979joMMy7R4GSlavHG9QfSEfX0xI3eLz+l+gDEpr5aWZWCY07hhQWs4vSpLW7c2jB13S4LKp1VebeLR139Q+7jSv8XMM60EFoBl58WLqtoJwJMbjLIkP9ZhcdlmeOOgNF6FqRN8PkdExxx+DQMnmwBpQlVEKdP9ref0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977413; c=relaxed/simple;
	bh=XW/tLtUuDnLMYc4hjc4DC0qIYw38o+PRMwGzW+YlhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pYoLEX6mQz69onvNRUTztYFVQQzkbKLMjL9Kn0zRjuD1gW9sszaeeZGVr1l6d4o/1BwpzJFIwqj2f1oi1cIxzgGuPZQbRqTkB87THHYIbuRSPXE+Se7a3Yvuf0vucmJRrq+VEZ06JBYH0x4lzdnxzL3Yp3l4Qi+OVQQtELkhSnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=byrcKPiJ; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtU1Q61k1grrjGnBTAWYlFmHkw+xVVaMB6z+nWeFVRARTgFU/DvOtUaLBj0FB9B+bzB488G5DwPflpCKIBok5arbTkTDKsfR2L46VxqMX++dSGAw6lhV1mFxilFivo0l8VOo0FbWCKQiDg8mY51r+od9T2eWaOh+l292QldQhsgvZ6aD01A5OhguqdCAVZN4OUObXrdIHQU6rhdaOyX6X3uBMAbinTD7qhlWzha4fvrjFfW6Pe/ty2/V/nSZrDrs9EDLFCk3Bz4Ig+CYAEkT8AtEFnKDWr1O7wXJFNaFYp7agQwAzv77+BCjfehUmtP2uk8AMUrDzzQlKqQJ+Ff4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW/tLtUuDnLMYc4hjc4DC0qIYw38o+PRMwGzW+YlhqQ=;
 b=VNaU7XBoVFWJ5TdnezCMp/Z2aEgeyXCZ/Y8f+B0U5+mxgx+P7sFbt5sylxomAS2gUNmIOxW7Ol0Q8KuKsBqTaJk6ZGQAJJjHO3F+AczlAEQW7Uuryb8STskkP7BPfBelwgHza/CTB6PKuoGIsE2NC83crvGCPas0mkuEj/+2zSxsSMyUZmpKFWosmOm64vkMjntb4McSERFBzbPAN86dhb+aFjAhbQf5VpTLdPw8cdaanBMMxehMBS+UdQtHtk9c179JNWyK36LTumyftsJuSn96/Og9AkYVC5jJqFqV9NnMxgZaGbYOht0WXm0V2sgQ30Yl4FeGDg4/K3BTj+t6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW/tLtUuDnLMYc4hjc4DC0qIYw38o+PRMwGzW+YlhqQ=;
 b=byrcKPiJKKoLeYysZ42hTR2RwCPgIldnjgqXETkpKME3qHvwFfPvYxrYWa23gB1wfqIei1hdnJbZGuUyG6wS9uTmVEPdWbxB8P4ygmF9c8ERs+wjCFdR4svnx3VfKEuwxEUzFqcVOKrSobQ2ATz45qmL6GQ5yz3PQQsSUHfESADn1CAvaxcdL1YI/1DVdS/PIFtZdHHM6efjTp5e+G26Y2KdajPoqSG7UhO7fthxo3asJeVRuV7NDbdkYuuuvKomTVLeHf0bTsyZD5KXPwZO/1xlmEerNvGsl/0ihypqqCncoFYwf/CrqG8da7ZEmoqlvEEjjPtysrosnW3hcGdXvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.28; Sat, 8 Feb
 2025 01:16:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:16:48 +0000
Date: Fri, 7 Feb 2025 21:16:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250208011647.GH3660748@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207135111.6e4e10b9@kernel.org>
X-ClientProxiedBy: BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: da19e8ad-d84b-415a-fa0c-08dd47de42a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FjVJy11BMnLhpeCh0wRIsk9rL/WhlAiZwfZSjTZj1fcoE0c5OtOoCyGQor3j?=
 =?us-ascii?Q?+vg+PMracrwRh9CKfXtS0Cm9kn5tEks0VwgyUc8KhZg9mY/8dgBiaXpkKjIN?=
 =?us-ascii?Q?0t4yBVpHfkNWHVr5Z9HVu5oUtJAtVUfJGOHnzCASZn12lnYksIGuRh78Yokn?=
 =?us-ascii?Q?95xQ2XcdSccI+ivImSLmhnEYAflr12KzdXGVhaWq0cf1K4YAOJMhzLZrCos3?=
 =?us-ascii?Q?5LS2aA+jNO87Z+NZfZHVyfyICkzSduTMn9sQeuflu9QgI1J83700KkF+L6WC?=
 =?us-ascii?Q?PBNIISu/5c1v6ATIAFM6iKxZktRo7pW6WhyXn1EJiUoN3+fAamJ/yzIVWGF/?=
 =?us-ascii?Q?FTbdSqZ9sgyd9leQ5+t0CPmN6WsW4u7mg0nnWIr8NRsUjnr7a+1GqdQDaZol?=
 =?us-ascii?Q?8IhaDkTojj+RSfqEnO18/gUJUeah5H0jJIoRVZNF694s1H7tnJEgZJUEOyrk?=
 =?us-ascii?Q?1ME+aIl8rUa7n8UHiv4bDaiu/erqLw11HIP0iRkkjOE/hp30kV6QHFQVQbfh?=
 =?us-ascii?Q?UB1UwWOlmYCq4B8sYy36/1mJJWwxSYpfeaSYV1xum/xqjR62EdUWUm846RSF?=
 =?us-ascii?Q?uadIRbLbIPKxMI74WbLoSGhxkoGccOhzTKSSSqXVhOA6Tl0VvcdFQZ+OxU3/?=
 =?us-ascii?Q?Ixl1NK6bJwLEoJJw6O4gljYQ+HFQ1Q6tqqFBQv76u08eQpTGY8773XDPCExi?=
 =?us-ascii?Q?46tFnWUfKgCcyyV7X3JbnOncBxSssbtm0+T+dftDmqS423Ia1glXsXwSVGAV?=
 =?us-ascii?Q?6LNN6G8h65Q+JlBFOJHxrdZ0vf69Q6KovzJVYXe1NJdfy6+UAs7jX42v9gPe?=
 =?us-ascii?Q?aDgMQDobitA32tQVdKObCKORnKg1ygF05QeaXzBg3LXvz2FpIu61fuygYu6Q?=
 =?us-ascii?Q?2g2zZR1fDL7dQczKtEyfnDW77FJzj4ngx/IEh2psRNKtGCXT576y3EIzMHjN?=
 =?us-ascii?Q?J6xZkorFKAOkwnDaU2fZaWOzN4cASK0s9gsL9BtUJcYF9tqFXY9WghjCTvQX?=
 =?us-ascii?Q?pco/+gyGKxN0d2j8B6f5AgUxxajpgbB2ME8eqBUFPwpJjI+qajtscsB1CCYh?=
 =?us-ascii?Q?IobddoC7qqEwPBCWaIZhI/HjbgxKWau5/FEptDkwgBj4lgEMALaHU/LIiCnr?=
 =?us-ascii?Q?IqscbwH391Y7IE9zEQhdoCl7+o2llcCnEuRotlq1lAo2zerUXO74T1hrga0Y?=
 =?us-ascii?Q?so9vauiLnrDhZKccilJuNagary88ZuwtH1d3heaclB28K+9ZYztET+lLS+BQ?=
 =?us-ascii?Q?NroJTPhiOVslkUEfnIjY+X9Z7YVgSo527zXxjDJEeQnIiYrZbIlcI8rjyn1a?=
 =?us-ascii?Q?wk87zBNyVXfFnH3vdPPdR+LtTO0OiCvMfekACAydhnMsqeuNIfAiBfkyue3t?=
 =?us-ascii?Q?n1ipBb0tvyNSJh7u5Mr6qGoGrzQw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYCWp6HpzsrtqjANVe9kjU8noWGRq8wiYlZlyLR4HVwweeMFTayR+I/qg42q?=
 =?us-ascii?Q?9Saf5zuuqtZy+Y9bmwPouYwqhUxUCUmIuXZP/yoPWtuKeszzoEDe5PWxPxCf?=
 =?us-ascii?Q?2dbZp5/EgdJyIbrwK5FQAv7xjrXYeCvM6iLvc7PoCK/lKUNvvZ8l3NN1PjTt?=
 =?us-ascii?Q?/gbGHFugL0egK6XObyc65YLh84ognVkv+MOyz5fPb1TCDjV3Jp3e3dLNZV5C?=
 =?us-ascii?Q?FScI1bWNFokAn4LQ0Uk+aSkMpC9fvtPOfDwdbGkonuJkE+73j82v9Xewitl9?=
 =?us-ascii?Q?pvpvGFa+cbybUp723aXQ8x/XuEPHRTUxHowy65UuAE46xnDViSZ9s79kbFG1?=
 =?us-ascii?Q?+9Bwu1Aq69+1xU/XO3f92jZICLFRg7LdUQsMdr6LZTeJpknSpYEl9K4P8lap?=
 =?us-ascii?Q?r9OVo2Gtkcx8GTJ7GX4gUQgVwRXA9xICgN4mrJ0nkqMiW3ED3jgaBG9Nx3YG?=
 =?us-ascii?Q?e9pioTBbFLPVuS1M+r+zdbGH45JQT/XytAI9OqzvNMcbHXiXxWJjyh4HcAUG?=
 =?us-ascii?Q?qSrZHYwfJwEsI+G1N8rhxB8ludkPrxtfDoGlfyidF/9fQsRzC2abpkV4Jfgv?=
 =?us-ascii?Q?aJ6ftF/NqKI0jnnhMFipF1sAufI4cTIgleObVIo/Po0quUSxfstNkLr+VCmf?=
 =?us-ascii?Q?gOeMzwq0Dn2S4HG0aYZXqm104/mbqtcwp3W8Q088kHwKlZSJPoOc/fUAKIb+?=
 =?us-ascii?Q?W0prWIPpnA+RMQuqql6U5+NGvL9lmeN18RXe3MjjdJ0BvEyAa3O6rC9SSwcw?=
 =?us-ascii?Q?Y5RIsseSO55Wupc/3+nme+ecfCd8N3G+sMQ3NnbWiP/meTMRCDAGdxXLvYFU?=
 =?us-ascii?Q?6wZoMqQPedWsnU7+r5HRutI47WfBK48wbx4GnXcgZEpjruZLp3nNedQS5GXc?=
 =?us-ascii?Q?Cx85AXB7ltxdOf5QQOfZomZx0ROJdxI0e0UstK1lew5Szc5vZZkfbGAPAz1t?=
 =?us-ascii?Q?gruv6pi8Q/ZGg5EorkPOInsNJfIbbiPyE+XB1GMwFtA3xvBdUJBmUNw4Tzog?=
 =?us-ascii?Q?iMCHc+JvGL5H5bcg5Sule2l1Ik4Rq93XBaVp1ShwwNOVgOn3MbQD+6sGTDxt?=
 =?us-ascii?Q?XVTGT3mmWkD0G73A7efOehLpCfLoXzZKKAMGPSQCwy9WEpsWrJzN6Bs+uWCg?=
 =?us-ascii?Q?H8jIFNN7ktbvMzsuTQomuGjVAiPch5yJBqoNbeyWgl15Kmdduhf+HSengtQh?=
 =?us-ascii?Q?juLgvVm9Y+NItL+/5dvrDRfr3cRP6JxEKL5jGv+KvN+Ve8b0etS6ZOswTdEC?=
 =?us-ascii?Q?ZAQoICaGPYoyoPA2YK/lB3gNYeKd4zhjDPCSGG+GSCw0W1rQoHcLOU04Yht1?=
 =?us-ascii?Q?qQmjEF4L72piulZJjqoOYBb3WUNwv5z9Zy54Tym4SVdcm/cJm7/3Z+WsD/Q9?=
 =?us-ascii?Q?D7K6L5ZX5F3hLTnI3omqhnq7aWZcLDG04gAqqyMhDFYE6f3h9RzF+n+2q5Lf?=
 =?us-ascii?Q?m7GNYDU7vw6vLUI4vHhZ/c6MQo+Za8fN5cTuidOZmtzd9orxjgBXemcEFV48?=
 =?us-ascii?Q?vD4Tbc0gu1vp1h41QRfK7HAWVZifjWIV+TfJpMB8kywsItWy0LkU1OTNfXFr?=
 =?us-ascii?Q?LgrDl8CTiDnYvCM0gb0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da19e8ad-d84b-415a-fa0c-08dd47de42a8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:16:48.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Toi1vZNjTAmXyqcwqm3+1gPmfvyC2rrqpHynUgCgIxFZXL7iS8yMbtL1QmWrW5Ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:

> But if you agree the netdev doesn't need it seems like a fairly
> straightforward way to unblock your progress.

I'm trying to understand what you are suggesting here.

We have many scenarios where mlx5_core spawns all kinds of different
devices, including recovery cases where there is no networking at all
and only fwctl. So we can't just discard the aux dev or mlx5_core
triggered setup without breaking scenarios.

However, you seem to be suggesting that netdev-only configurations (ie
netdev loaded but no rdma loaded) should disable fwctl. Is that the
case? All else would remain the same. It is very ugly but I could see
a technical path to do it, and would consider it if that brings peace.

Jason

