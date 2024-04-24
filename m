Return-Path: <linux-rdma+bounces-2052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B48B0716
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD4BB25DA7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794015AD9E;
	Wed, 24 Apr 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mBvfB71Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4415A4BC
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953777; cv=fail; b=D5OtPAQHMkj1qDnZWBjGDErtKyU1LIa14YlU6n93zd8a0v4Wn6XIoqD5JlNB0+SqwdMccRUvt5T61sdrEqfbf3bjUbx3cNBdQrmzSV1q+nN+94HHrbym9DHb/67YmmXJ8K8XZ5aLN53VmwaD/4BQGhR8n7gyea9MUkhc1Gi6WOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953777; c=relaxed/simple;
	bh=QDCdHctWW4ggopmgM6rfY4RyroJ4XaJ3EJhFOB8Ge90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LnuQtVjWCFRFc1oggvQhn8YAVLb3HZTjs+v1M39mbPoPyOSw5mRK0t7jqxcz4061vBP+McLMpTsF/Q5s4cWbbyM7cjbrNsuSB7PG/bdHJIolQ+kWF6r9cctKbv4pFsYQvV+KjyvCN9e4hwXZmvs9mEQhaglKNHnuW9+2ZU+YP58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mBvfB71Y; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171]) by mx-outbound16-153.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 24 Apr 2024 10:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3My5/6sqwo91eECNKJelnegQApyb0VrCTrjRQnMLSHfwwam7OFg5KgBKO/nHm93cq8w93dcX6S8H0mvP47surZZcSv1bjvpqVNJWbatzujc7Ys47SDnWIj+sp+3R6mSGlODohLA+/8PsE9DEkD62hTjXUKQRn0/QvDzAziiWiuTftZj+rPxsm6n8MLdwk4BT7HqDVb0fgU8MzOGoMmQRjGk66Ei+3IIdjBXfhFJHmuDdEs9KaFE+Z7cPTy7Eo91dCQN6PlYEUrb9h92qjOiuwYVWcxuvvcexHMR7/GgzKGYghlFbraIV7Zfrepmn9Ofo9UuDndN/KIYRK8hoGAi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAiBJkGuyOZ5xv9jaEYy4bdvgpBS1bAR649ZxF1AFkg=;
 b=PNm+8YWqJY5ZK/lwavyfIvDN0OeNdIn83PECZcUXl8yGygRC/GQcIrYnza3cAw+8QvyDeYINf8DadZv3pYBSwHJR/GZYkPRDu+PFs4X+mg2A8EgtbfaaQMqkb/BrXmTJ2hJYhLXDYejLpeJmT3Y3IUhxBJIsP6VINj1gggfGpCoWdmcK1zWtl02nb2S7OIV6Ge/sEQ8feUCrNzT29kxT+5eATuVwxoN6m5tQO1kIlDJPRTSqUcY/AsIFGzUJgheeSAMeqBu+xCyguVVqRTojUK7YAvxTcxwDvqK3OzzuJYnhon+mxOaQ/N2MloH0YrD+Fv0aO/kRdJSaydxWap2/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAiBJkGuyOZ5xv9jaEYy4bdvgpBS1bAR649ZxF1AFkg=;
 b=mBvfB71YEEpMYkDfDVIw2FRQX1Yb39KsaA/Pvo6YhLJoXSVXIbLiz5lEdo5yBpvg2FhfXOgl/KddU2nOJYJ8eqkO7Y4z+PeHMjP0c+KHmcXfu25eh1UHHsk6h9YkCuUrup/RKJ/HVG3RCV27BCD8gNihfmIv+CpqnAfTgRhPFEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by LV2PR19MB6103.namprd19.prod.outlook.com (2603:10b6:408:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:41:51 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::956b:a5db:c859:cfa2%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:41:51 +0000
Date: Wed, 24 Apr 2024 10:41:44 +0200
From: Etienne AUJAMES <eaujames@ddn.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>,
	Mark Zhang <markzhang@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Gael.DELBARY@cea.fr" <Gael.DELBARY@cea.fr>,
	"guillaume.courrier@cea.fr" <guillaume.courrier@cea.fr>,
	Serguei Smirnov <ssmirnov@whamcloud.com>,
	Cyril Bordage <cbordage@whamcloud.com>
Subject: Re: [PATCH rdma-next v2] IB/cma: Define option to set max CM retries
Message-ID: <ZijFyA4kwybRAVjL@eaujamesDDN>
References: <Zh_IGG3chXtjK3Nu@eaujamesDDN>
 <700c19e8-ae4f-42f0-a604-9e33a9a94dd3@linux.dev>
 <SN7PR12MB6840C6A4973B3E1885DAB971BD112@SN7PR12MB6840.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB6840C6A4973B3E1885DAB971BD112@SN7PR12MB6840.namprd12.prod.outlook.com>
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|LV2PR19MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcfb547-2f17-44d6-eb44-08dc643a62e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aedkljJgvDkL8epVsk3PULDWasGNs4zXs2IOWL/Og4YB8q+6EATbcMKp8zFi?=
 =?us-ascii?Q?kcYtmGvNDNlEywt9cRwNbuASGLWS8mAlwQEfevxZ/h+LcpVG7LNL4Vz6oDTv?=
 =?us-ascii?Q?iHJ7lRhufD40l6e2XKGl3Gt3z0iRodKTMti9Zf6N/vhCHBqmOmpfcn6i5x0m?=
 =?us-ascii?Q?0F2wlHbhFEjvMe2KHjNDyIHjkhSpjIaC8blmKl+SRCoyn0YtmWqllVkjTV8I?=
 =?us-ascii?Q?Lsk/KG2jheMUoi/7Hf/GWamY4aj5Rm+RcsYMeQk4pjFN08/Qmn1APyh+l57J?=
 =?us-ascii?Q?2svWmNpDc6eXFRijBjeRgwNfs69ebaQEDm/j1OnRkxkbzCkva7+0GkJ0kSo6?=
 =?us-ascii?Q?8LhygND7o8TTEUaIQP3bjGVGDLEB3PXmXIfNO2FTrGNfuLRkGi6o61ujtc1y?=
 =?us-ascii?Q?SYNxgE4Xb5/KLHVRhoDkGfXlKFSH1/9Wi2lkFldbjiWgGCPRKeDm+ZMqSxsb?=
 =?us-ascii?Q?z2j0BCs8xIwLvRwZ7CbrOAbR5FVfSKfZdLEuP6nuU8xbW4Z9NIDPxeZL87L9?=
 =?us-ascii?Q?lSqVWP8Okg+wMsSkS1sBhtVICedRr31Rtt6sSHLwZGtNRtwtcMTIHaeRUlGd?=
 =?us-ascii?Q?tm4m3ScsXuFUhSE63roZHNUUJ6uXUbeVovzIxIphR57SAyuatpS/OwAPZzXY?=
 =?us-ascii?Q?NjGJlSEfbJuaucrh58Pe4Z/mlpLRsy1FDQJciAylTFYk49p279fdZPrgtVWf?=
 =?us-ascii?Q?qRudsBvwRcTsUJ/AwKao4JAtHlpwCMoOQ5xncSNlFAGeIEhkV5O5X9mos4F0?=
 =?us-ascii?Q?NDFG/BRmXIULcRCHUTpWw57iFK2RCvGpMCLNYjWyBR3GRCeIlIm/x1R+pdr7?=
 =?us-ascii?Q?i/qg/yvoZNNnnkZ5/7HazgmNdQh1uftzXtjBA5kZukuIcRI8xw6nQ/j9QqiM?=
 =?us-ascii?Q?RxlPVPvvYVi2lHBlMSfvmW/pw/IrNIqvyQ+OxIWo2OS5jLuIO4ojbujnPTtQ?=
 =?us-ascii?Q?JxHpwEqL0VerLSWEheWKkHiNKeBPfP97VScIYWXGQLkZLM7cJSE5Mrt46eFr?=
 =?us-ascii?Q?rMVmdY2+TMhzClZVlnwr88Hz++AOMxxNvYF6P/HnVUngV0Qd22FCjYMb7vS2?=
 =?us-ascii?Q?gUoNJp2JeFA3seSMWP6cT68SOEAE3UTnLpqEpVQxHkNaFeuyw7nN0bZQI5Gn?=
 =?us-ascii?Q?KvtRogGNsN1FDGI1CY4ZXWtApiRTHwJR4bhuSgoollD+WPGKKXy8CTXIr3v9?=
 =?us-ascii?Q?yDO8As9rQkQBrLmJvjLLV1HE91j7CCJFPDY1fEYt0tRHZz5XeoPCgiaqCgQO?=
 =?us-ascii?Q?ODut9uQ5I+MVj1tc9yw1drNYFFqNoNjof+syPzDnoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VEk9glubxFo7ytwizXFFSHXMeLH6lsUfzTUTB60hRy0L69a+41LzzapxSriM?=
 =?us-ascii?Q?8lG5nMaZuUsb3M3tMKyaiKPJxZSFuLdRL13jUjllMtEYW3rqWcjtvMGzWIm9?=
 =?us-ascii?Q?r6bGaVCOaj1gMuCgj3LQoEFUrEx2QBJemQUipUjuX5y4JGv0Cc4CVpBesAEK?=
 =?us-ascii?Q?/Tb7pNRpsQDIRs06xDQl5jhTJw3Q+kQWDs7aL0jeL2Cgy343z07vbbqPsm2e?=
 =?us-ascii?Q?U9ab7BOdaCPlWh4iJyGZGzXTHRrsbBEACJk7j0qHirDBtU4sV0ePPwhsmlOh?=
 =?us-ascii?Q?dCOpUIblKNIAgCbpHsqoxrRmp5E5RToSn3ZPOM7R/EKXtAfpHGHG3qwEc5V9?=
 =?us-ascii?Q?ViQmpAiqGQ3rmOjtAenVo/cwyMiyWWNLpMbZq3ZnPYNhMnS4rHGd6/g9LLte?=
 =?us-ascii?Q?dJbOhXrT88u1QRh++1N+lOjg6/8AlK2+5yTAJq1pIt/+i5pBbMe/QpaVLkGI?=
 =?us-ascii?Q?2TLYN4bRldoNKivfyYy787cPR0CS+qZLb5UVpBsV+LJCkC0n8eNwLnbLmr9m?=
 =?us-ascii?Q?hvD73bjTicb806OgWO3C5d/heEUOLcQbsNuzka0Kjztz03gueT1TFaW+GkxE?=
 =?us-ascii?Q?m/i3nnl+SliQ2YF22ZY0uRiLq+9jggtYNFY+G58HfGeue4e1KDnHKwBqL1ux?=
 =?us-ascii?Q?IR2vHzqr6uggE5/QaK81aUgnHFhCIBmyOg3S+shFnHVPV5Dh40n2o9mwfblD?=
 =?us-ascii?Q?8Ex3zB7TT58I5hM1BoV9J7uzDNxyIThZcU8zXnI4FhQJ7jW6GaTGjXRkWEHM?=
 =?us-ascii?Q?YmsqtAYhuLILKbVid/UBMpRHNmpDkai+iitCKfygh7LLWZEtM9KP/6Xt29U4?=
 =?us-ascii?Q?NspDvbliG8WGTSxlQnxwLKQlCooXHagl02DD5rqJfk8rK3rYWPeOGqsJeZXc?=
 =?us-ascii?Q?Dr8/4+u1Uk/n5aucjHvtODrZIb+Iu54z591it7WYamAoaGEkuWYXCWtplUJB?=
 =?us-ascii?Q?pIwAjGG77LZZO2kXWHBrsW06S+YEaBfZL1aCxyHFrZC3PfmjhKLVd1ZIk3XO?=
 =?us-ascii?Q?+DrCSbDE+DsgFar0tN9wSVHNS4VoJ/uoAOnxDgpTo6WOAWzWFdcBAEYM77jV?=
 =?us-ascii?Q?4+lUj/d7uXYF3Xn2FNIE8NZcCPUd3U5837qqGIYtLBII+aWM9wISyXpzZOSG?=
 =?us-ascii?Q?Dq9Ae8inKgS35PWNFVFgKryDIuGOGjEQRc3efGkwVUzi4a0WCC/xwHUs8U+O?=
 =?us-ascii?Q?+1qTeU/aMZ0OfzIinnOa0YOO6PsbvJ/TwyB5GQxIpmsGBsqSamkAScX+L7rH?=
 =?us-ascii?Q?usSIMofDBuOp7LYp60CgOvoxJlzEKCrnkrLn0kG5sTX+UK/rcJIocFl6Nu/R?=
 =?us-ascii?Q?hLa1NA8WvRO3lulnf0mcIZpQJ1aqDrn8TZqf4pUaAjaP32uGExkmkL/OKzvi?=
 =?us-ascii?Q?qNg5vqISrQWMq5aM7lsfl2lHf6GaiKrYoDaC8afNrAFeKdCJ7xqcOhYyfsdL?=
 =?us-ascii?Q?jrf4/xrKYaE3oOtULHo3YJ57seMxyEkzctrFVxTUdSCv0IGkQeGcG230FdJG?=
 =?us-ascii?Q?4cGVapklSKDzSgeWpZvtwXufmItha66U7LSf5dDkps+k4V1PXRlqIOFvFctg?=
 =?us-ascii?Q?Yag3zDiMfUc3TbQ6VxllzIckcBMhX2gp+BtbDFnkjm+JnqMMgeC/pR54W+Wl?=
 =?us-ascii?Q?auEW1XErSBUFgtTDTlqoFBxUKF/b6Uz9t2kIvuGe0Q6t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xpXG8Se63fqOhn90VkTyPxBemje+JwX1G9C6GS1bYLnQTkfc8Lv9xaAuwiqXwLrnSY2Mor1yg8oTtD3h2QtUJ8CPR6e1SEPHbxMwvwnr3e3H78R7pGlLJ8QA/PgpR4D5+L5WiNxktatVUpiw2quKGdtJOV81aMt6qMZOdd1sOYQSdSXZ98W2o8Jo1OsPak0T25m59QcsO9Wb4YjpZX3TJBB9tO4cMq8Gc7EaTZWxdpQS8C/pHzyUAmqPeDQ+6UKo7SI+/8ulH8i5HO9iO4fRIdxTnNAYK0htuy59TsTcHMEduCZEF6ZHXSZKXbrtePMVZuE0RHD33XQHESz7fQ8uNlaS61qWB988GMnZ6xnxrK+/ew63jEjzUSA/2VvzsOzfJDu/4kPHcZIJHcAtrX6Gwx/9XwQ0TzGh2w3iCxvVGQvA4SRp7WLB8v5hMa8AdToWQonznYjbKoZ4+mBpIVnzKypVStzajr/c0A5LT1cBhW+7IF19IWVPQZEzeqT+y3gpGyqO3xrGiBmPNa+qfOLiXhJmgz6mSKNvTCIrMhvsqxQ32o20tMdvlCcCgJPWiBVXgSuoA0Uu8p5VeNACuCciuDwdtZM4nqGgzyDBqrWx3AB3gvMLUvSI3PPm5oVGHSsv4gDXNzMn0suo4XTIZQY7Kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcfb547-2f17-44d6-eb44-08dc643a62e8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:41:51.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFaLZeE/npCZZfSz0HZGdbRrb0+3AD7NRS7/w+0LNn6GytSZIjTVz9GoX4W8bO0k0g6uYRt/QqBm/j4+DNCv0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB6103
X-OriginatorOrg: ddn.com
X-BESS-ID: 1713953773-104249-12787-63079-1
X-BESS-VER: 2019.1_20240412.2127
X-BESS-Apparent-Source-IP: 104.47.58.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYGlkBGBlDMPNHS2MIyOTnRwD
	LZMMkiNdnU0tLS0MjSwsjAyNzY1FSpNhYA7cRDjkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255786 [from 
	cloudscan9-99.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

> > > diff --git a/drivers/infiniband/core/cma.c
> > > b/drivers/infiniband/core/cma.c index 1e2cd7c8716e..b6a73c7307ea
> > > 100644
> > > --- a/drivers/infiniband/core/cma.c
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -1002,6 +1002,7 @@ __rdma_create_id(struct net *net,
> > rdma_cm_event_handler event_handler,
> > >       id_priv->tos_set = false;
> > >       id_priv->timeout_set = false;
> > >       id_priv->min_rnr_timer_set = false;
> > > +     id_priv->max_cm_retries = false;
> > 
> > max_cm_retries is u8 type. Not sure if it is good to set it as false.
> 
> It could be initialized to CMA_MAX_CM_RETRIES, which would allow removing max_cm_retries_set.
> 
> - Sean

I have no objection. It makes sense to have a *_set field for non-constant
default (like "tos" value) but not here.

Etienne

