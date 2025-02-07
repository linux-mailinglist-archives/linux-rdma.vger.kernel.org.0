Return-Path: <linux-rdma+bounces-7522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87658A2C66F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85BA3A04BE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282413BAE4;
	Fri,  7 Feb 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UyBzYUmc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70C238D49;
	Fri,  7 Feb 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940613; cv=fail; b=LF3fDLUFW+IlblokAzSTgZfb84tJTHMrhuRS3pMmYjiWPDp2C17ItoBaP7bPI3qaIwMjOE1zwYOKt8TuW49LWooHKKbDEvdnol9G+UXks6ohq2ldUF8FZaIsrEa8rIFtgP+WuIBt3NwSw8yw4aVrF8LSjxJi1ER9fG1PQy9826o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940613; c=relaxed/simple;
	bh=wNB6gmlavCXwYj7nZTT9UZnSKorkTuAeclRvt6icwro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFMbJU6d7hJPUldR5+a6IUdLvnAaOBcOWqPpn66E1U5S9ncTWCJoI5g9N3/uEbGso/NRwRoOf0WeddQ0llEnMDG/weVNy6MM5weTFpw97TKLWSNBfuamgVqVWpBxqnLznfaWFbosS3Nf0Elc3AlsRBrWbOOMQR8g1V2FgjitrFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UyBzYUmc; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSZV41NDsRxmSo1sfRDt7ilz/qY9GWAdzpK7GIrwoVGjUb85jWw8KpySrjRxCe3xNiNCOX2K26vPc5B4FmGopnj37tDOdVyfwL7rhISfKilX9pOsZbmGGwzzH+p4kSLBL8RMCXvUI1uDWoSk1NZ3x50wldXiO3DNuylLueZnEoJvHAWBDsc3U7rxhQ+6tMUfhbARLiy69HbNfdCQschUP1j3sdWIK9cVd43y3UVvKCAO7fMuPwCI8St/iQ4IuSML28roKfcU4RNpdIsKJNogRApTFT3UdmWl36dO5l5JHL4YisIPx8ZX9IB90xKPy+oMnF28A0ovUVcyrpOYS1Q6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNfucIOIXZnmU5qxjrXcZ84qjtYXFsFzLZhDWiqnsJI=;
 b=MFzIOMkbwc49b+KUV4tlIMIDJP4z0UDa4IKF1rCBGVqBZUflXDKvQsc9Yu65U/ac1yQRB1c8xuqChl3+ebM61bhHTow80nfG98k4tlrA+8NK2855WFzJHZIGMkuduYR7LDV68YNhyzJgepHXag/cJAfXVUgJ6Kjuw1Y5m1sgNzJqfpwcWm40i0iG4uSpt6gYeWn/XwS+bviygTCDwjMgxFQ++9BN2jZUKc98VeATkMyUXrP3i2LPUSTKJlrDQOb34kdNUwmbcIamncfMLozj43u9i3If8vSOW8CqTAgjL44OgquvEMq8un4Rh4FwMyrc7wfz98p5Q0KDF3zeD1mIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNfucIOIXZnmU5qxjrXcZ84qjtYXFsFzLZhDWiqnsJI=;
 b=UyBzYUmctZMmH5VMdOyPCBHPdAyKpo568H1f5kKa6xn+enQKKGAjN8TNSLQoXsBkeZT1hxoXvAFKFf2/VFm6twuKoWSV3fq8EMykao6X/ryUijrmvB7bWo0GR++vz00b3ELZcVbmnPPPWJxopM8Yuhjs91QzBZ8ZxmT0fr1ckYiRrRLQoJw/T76iagRy7sR9fy1mW913DOCCd6+w2bB3QoECz/SqSzFCcIwpJJcejXD2MgcYQ7ejIVJkA/MrmtOMylS1DvaGpQLh3msrPXYwfugW5I4s6VTkuR0tVSJGNTFoCRNnr1XkuJhfBBs4Bzs82gkijrwrH7Dt4/JZbS4jKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 7 Feb
 2025 15:03:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 15:03:28 +0000
Date: Fri, 7 Feb 2025 11:03:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 09/10] fwctl/bnxt: Support communicating with bnxt fw
Message-ID: <20250207150327.GU2960738@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <9-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250207145923.0000335e@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207145923.0000335e@huawei.com>
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 202660ca-411d-4ee8-a3a9-08dd47889411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fba9JpykWAKrnmvMd3Hrp4EBTTFa9INp/Q6e+3j1LPMGOZ9qPk5AOJUe0PwJ?=
 =?us-ascii?Q?IV4W9Z1GhYcqx00B0MbJYfB1wK+hfAI4xsxF68CnbfPpGRganKxddJ6SYMmB?=
 =?us-ascii?Q?W87wDr7oi/hYaAvSUA7soTmtrNyp/j37ZciZzyFMXVHndioAb6DSY8SQIOfc?=
 =?us-ascii?Q?Lkn84lea+JGXhhClYP8DNf0ZEyMpMgVMgGvRQ6Q0ozVmJFOcYD1AKBXU0iGG?=
 =?us-ascii?Q?8JFc1K1qlfwO+ymLSPh7rlmQRflMG7Qq6TcVA/McJh8QsvmuhNy1+RkruY2J?=
 =?us-ascii?Q?HZKM3COqa2zdYM1Nx7Q0yiUHmOqlZBqmrhyyUHpftMmtUIau0ZNQvP8HPPw4?=
 =?us-ascii?Q?9BF0xCMEVMp7K4xssf5ail3oJ4foEyDanNHOhjsvTtY/bVzkSLNUpgEsLqdz?=
 =?us-ascii?Q?h5DDkw24OCK/8BeahdeFnYlXZ/voFevNgUffFcyMrS1QlwNO8R2AU7IL93tD?=
 =?us-ascii?Q?ssLUXPCuBnBGawaR+nd5JtivSIYdaDRY0sHPHh+tg2aAN9jYfSNTtIW6SJ7D?=
 =?us-ascii?Q?e9tFYr4z9Ccx98fFFz6PMQBg1TUfUb97Rb4Xi7sypDs0ZmAPNOIH/XR7WeLh?=
 =?us-ascii?Q?EAmoyBBqigG3di6IzZdyYD1KbLHxpYnK2apb5fheWebA3u/kZuH1ZjuwswYK?=
 =?us-ascii?Q?LNC1++B61rMIoITrlhZct06gJfU4XKlF2Wn9d0Lw2ZfXQGt9RncpLInzw0ly?=
 =?us-ascii?Q?AjL7s0w3JO3dgg23PTMkxzOZ4CXBo6sX+1QbEGESNQC6YQAIwd/L7a4sQzf6?=
 =?us-ascii?Q?LDFY+NFyULRO23W9bSWdNVbuWwBHGKd/W1yuKroPR1TBrbU9XzyggJS5r7da?=
 =?us-ascii?Q?6y1k8C3p5I++3D+8PWvMW4V/C2sQGhFvytjjsyCyYfZE+AdfN5o6u2T2VAkf?=
 =?us-ascii?Q?3X2+1rTdg6VaV3SrK8LcEB/ym68RU0WrgEieYE0BwUlXYvWB2YE09mHLnc+h?=
 =?us-ascii?Q?6QaeAASfD9q3Zw9dOq4uQ9otItjiXeaBMA+MZkWd/TF9fxoIKw9FRRsjotbI?=
 =?us-ascii?Q?ReR0EUB/9zlYEhslUzVD79t+3n2xJUTvHkWqJ16ki+tLU3WnM1yQ9e0cdZyp?=
 =?us-ascii?Q?/VuvW78W4lTdjjBOkzrp2t8hEHvJlNxkh1tLX9SuciOLSenvXeuR+zCRXxTY?=
 =?us-ascii?Q?8279XUzspCA2hNWD/5OwOKI+ydo5PJDFPNHCuKNFh5Ym1btkpkaFrlsfG0PO?=
 =?us-ascii?Q?8al+nIUT1J3WM1xXA2yY/UGbge1qRjM6Pn9Ags5eXlcVbW46n6CfB1AJuI24?=
 =?us-ascii?Q?UA5UTWIOqlaxitRRwbS+UFjbpZxWsyfC+xLmX6pkuh+tXUvEy0kEJDWBgUt5?=
 =?us-ascii?Q?etO5TxDwWFhB8EsO0NmNZeHGWWBRsMR02bmyUEKsyt9E+uUeupjBxj5eSCIb?=
 =?us-ascii?Q?/PCxYoIO2poYzBBVtjP49AgL6n54?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2EoSPTVzSMzMMBOCsdGsP4Ws1ZCDEzfXeOpEC8gQB5/xU5Qhezwaa4Ao3Omr?=
 =?us-ascii?Q?hTbJgTcIqOzBjtZz0yPc66g2H8wz/R17VIBfeQRugNNaWeywtwUa8gOMb9dV?=
 =?us-ascii?Q?tir6IYylN9LmTTEvtiEMF0Zu2oWMJNTUGxCk4iUv3pi091TCVMQ8xrstx7fD?=
 =?us-ascii?Q?uER14QqX63Kqwb7C5AneMiLukY0kTfe+V86NWk1h1CymJz3sK8E6us/K24Ax?=
 =?us-ascii?Q?MMhY6f2cB1BR5tBlS91d/HcbQQEyoSFmHqwMeXB2WbxWGaLlKGueiYhIDY3Y?=
 =?us-ascii?Q?PO95FU08TYXBncRV6Uizd4tQNW3bGPG7vOevO7Y8p05INA1y0YseujvVqHLy?=
 =?us-ascii?Q?0plIHo9okKvl5D6fjhzjplP5QjBaKodh989oT4KpxG87eqfCcw9TbeZsellL?=
 =?us-ascii?Q?fnL4MUWjNioLMcFgs+8+wy2SY0CeYQ0CCPa2cuPOhDbvFPdwAB0LvhylRQ9c?=
 =?us-ascii?Q?oWYKp8BNLdzQ0xnVQe5PGnPvH6bGMoKGsr0wPI9A3OLEHs1BFQKWCWmXndYm?=
 =?us-ascii?Q?bo7AFgPItLEbP6oBOvtunS0tKyhsH4TUrk8arkLPC0OSUQBsGtUtSRfx9ZTy?=
 =?us-ascii?Q?SMWkmJszZSL5TcKB47MwyfizeuZRSlJub+D1wBDVYyHQfw3KwxqQ8NhCMmQH?=
 =?us-ascii?Q?iJ1hn46OVMR72R6dmHKtN6tP1r4fkuguHE+soJCRxTy7iAS7MszKUE69DnRi?=
 =?us-ascii?Q?PT5uvTmuARpNoksIUZ18idmtLW7oBRN11+f5vOUtDoKbr8GESkkz4u/ayeuE?=
 =?us-ascii?Q?lpQnJRsxF+phEsqGu/5CwPQ9Ivebso9po5rBMNOHHhdpudPuOi3whKYicQQU?=
 =?us-ascii?Q?qpMbRKOFe7COKV9KySE75xS8mfZ6kZT3colxDiFd1mWWtquobgxsxTXk4r1d?=
 =?us-ascii?Q?BLfmhG1zcoSzJqxSGgDIJR13Dq0lm+ywHYpRfMBKrXUXV0useUiBigAe8rk+?=
 =?us-ascii?Q?SknB/zRiGAus+go/rKWcMaC2od+oNIA8pdj3ZuuZsI5ASb3kG5t8WxXeAtIo?=
 =?us-ascii?Q?7AiBOF7KWaoOoz3LZ1oJBwGDSOE0ron2+UnAzMTF0ay6LFvtv7TrZp0UxuJP?=
 =?us-ascii?Q?mmYs65eavbidrCniUwW5v5ihiEJ/zjioI0RNIQurOghLWZamYsQh+b3dVKbo?=
 =?us-ascii?Q?Ha6HOmuEO2x3oKyqdHv9tMLYR6Z6B7d9Jlu32Ts9P5/DVcDLJhzHkMeMS91I?=
 =?us-ascii?Q?aV1GCtrNH5KNuNrg79/v+v0brkN6FJoIyB4oILcnxOGpjbFLwXzuCdv1il1q?=
 =?us-ascii?Q?lnvdgBXqBTPN+xyAiJY9lU4tfoHuoXD5D2KRvc6TIh/cpoMcoIbxAuWbymne?=
 =?us-ascii?Q?03N6XcGZqa+ACwbTmEeKFvUMJVdRPINDeU+icYsKzv0d5BAG7jI77erCzLtz?=
 =?us-ascii?Q?Hvk5/+YjT+f3E3Xubrv8dKrt34TPdN9vH083I6d8AElRnIaFEUcrYG4I3g76?=
 =?us-ascii?Q?c1tREqEbegjG2bWJ+bf9mqnSC0z7pLWzdNwaeu4Sxap98zzWaQg2MAfZjeb8?=
 =?us-ascii?Q?Bxaand/V5SapQBq4jrXBRX3nBwQTfJVZTHrM7QpryIyc9oakzQS6JxH1DZz5?=
 =?us-ascii?Q?PAevM81g2iygdsW+o/npPMIZNhLR075f6fTPNHLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202660ca-411d-4ee8-a3a9-08dd47889411
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:03:28.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9SITOlFsadAYUh1OfRsPVhCNX4XZgsHswT9JwZsFEK2lAYzwy6DBUvYCJRRYiD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

On Fri, Feb 07, 2025 at 02:59:23PM +0000, Jonathan Cameron wrote:
> On Thu,  6 Feb 2025 20:13:31 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > From: Andy Gospodarek <gospo@broadcom.com>
> > 
> > This patch adds basic support for the fwctl infrastructure.  With the
> > approriate tool, the most basic RPC to the bnxt_en firmware can be
> > called.
> > 
> > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> As commented on below, this one should perhaps have been marked
> RFC given there are a bunch of FIXME inline.

Yeah, please ignore, it was a mistake to include it

Jason

