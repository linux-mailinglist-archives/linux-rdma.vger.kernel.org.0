Return-Path: <linux-rdma+bounces-8745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68DA64EFB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6AF188D588
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789F2397B0;
	Mon, 17 Mar 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YNbIRjZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF3156F45;
	Mon, 17 Mar 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214819; cv=fail; b=kZmMDjwfxgNMt6jkNaHawydAgL0jXXKnU76tV1O7MsK45MDjo1SICbDARuDBeclNXXH7UrTsdvapfFGudbv1tT0PMGFQlImYGErqP6Mn3rloDL/X66651kJgC1PXKD6hQJo44qSCyNAlzCfAblU/rS32YfnavoV316yKD89vbd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214819; c=relaxed/simple;
	bh=/9T0M1waPRcJzQF2bjtkRBokRkcSgkqJ+4Z2/kJkHY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fu82HBFZLmGk6z2rz24r1aBsS3Gpd2BLL4VDwDCopbInYLUJesepJ3kMz9UH1drzUpUvoo7QSgm7YLKnLjPsmXQUCl94iLIzRjkK3tCfLvyJrcMB4L4eQ2ggddkj6fb855idTlKCJIRHygBOVqfk0NmW4hgsnbnCdnKrYCwBtuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YNbIRjZT; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM1I/yjtMtWr+ZAxNv+d4c413p9o4KZBzTtpLsgICIg2hiFg/vk00ezSpMed5HGwH//wpC36ETDqG7SS/NqepFuRu1KHUncIoDXQRDYGLIbG9UwKCRfLqShHvTSgJpko4352oGZcypeyIYak1r4EKm4IvbbDPvWfrKomHapB1nMGZ7QakHDeIkMHR1ytrDWJkmiVhGDCGTZxD1C9lqYZkRI3ARfEi+IIazDOpF8NB10P2B4xnsZnTZcDFoS9e45RgZu8V697zyz+yZIaAkHC0nF3FUxwITbY3FDcteGJjwX8+rOvi5dzTTGcK42RNoJAE6ATTTQE+WDc28Do+QdfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9T0M1waPRcJzQF2bjtkRBokRkcSgkqJ+4Z2/kJkHY8=;
 b=sevV/LzS+tLiiMTzc3gWJq0Iipz0asiJZEZb1OzVrNUZLTN/vEvK3VNyOc5ML8O5+t0kMJcTBUKykb0RNtJTL51TjlLU27qFJW9jmCEJxhhzEyk1LKsl/SUCSmg3efbCLM1hVAxzbDxX9g/lY6PLDcVLwCeugBBeWr+ADm3qBuXF/pSw6F/unG4oVYQGKQACBl987qZJCrCBzphrJn+sjMl+c4gqO48RjpqKZK2/2TFy5nn59SOS/xwAhIhVYUUwlMlYh40FnHEf+pJHftgbdJLWQuGc/Qbskrbg8kakOvWXn7L+LkWY2EUTtNmvxhNDt/jx/xZBAV4//+1n0Q0gdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9T0M1waPRcJzQF2bjtkRBokRkcSgkqJ+4Z2/kJkHY8=;
 b=YNbIRjZT8Z/2My+jgihvhLQqv2w8mzchf2CYE3nRL2yJEoMirAstSk5A+s2zjcLydNUcJl/BFfnAPt95qmFFH2XYDmcLchcPk4GyTejFccUZBxniOMMvwNiO+8CDYyPGkIEdwEciF6yvzC1t/gucFA4daONSADYGdNMTz9+PDURc0/QgOXR08D/tIAm2jb5C0NOHSEN5+0q9bioLzNBnr7rsh7e1lGolAL4z4nHuWRmR1hGq3db/M83SxRTGL0Pihp2P+wbYvh2T/szF1kcOlmN7bErA2h+xMXM13foMjdS7pf9vGV+laM+6873m1gyb39LObiX1JFRRqmNRB16/Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:33:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:33:34 +0000
Date: Mon, 17 Mar 2025 09:33:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250317123333.GB9311@nvidia.com>
References: <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 33245ad7-d1b4-4aab-273f-08dd654fef0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFcxh0XizH8F+0TdH0pChBCkoP4vtaxnW4r8+JXiXNUgrKEzmxhUJ5ar9bYN?=
 =?us-ascii?Q?FyyA1Ks3iC306qNKaai+mvP+44PE7L+Ydz9vzXtfbT/ph/hjbtxeazCj4siG?=
 =?us-ascii?Q?zBxa+03jmsTK8x10csesy+1fVa8boCh6taXxwAmPJTBU+H7vhtHq2EgBsXpB?=
 =?us-ascii?Q?86JlC5IG+eO9/v9x8dqDCfHusFAkqi1W7ryFV/0LHMddagG/oJRv7RWEMNSc?=
 =?us-ascii?Q?qYSL1W3J04iKUlqxdkarmBN44tufYrimrTw4X7/nrs96f1rYZsapUprCeJv0?=
 =?us-ascii?Q?qaeAKL77YoxUi4MNT4va8+HQuujLEdOKlSnyQ8XmXz2gGOpJQ2/boY1FUwvX?=
 =?us-ascii?Q?aPyEl58zJL2A7BoC0xyZzMATMMUVk7/USPEGIV0dcKlmYHbDW6FnjFO1oACT?=
 =?us-ascii?Q?yK0FrKkqF6sHv4FymvrCfA9KFMc7bqDpbiUKaOyyD+fOlysJBXzHvUB8yesq?=
 =?us-ascii?Q?CFBgKgJZuL0Eg9qj4T6CliejaiVoM7WtV6eGP+U7+p2z23KD1SpaZyd1FmiD?=
 =?us-ascii?Q?iFfwpSYRAfOaGzKR+cf9WOcn30BprMHEkuHgvbBYF+I67DGrAuRyiBd0hZri?=
 =?us-ascii?Q?n37dVfh6sbOE8iws9s4aVA//UQoPU9lRlmv3X3dB4fI1rgeBZSxj1KwiVR9h?=
 =?us-ascii?Q?/6pIqzQ2E6cyor6DMzwjB0JFFF3DGX+N8VK8jZmqNrI3p6J77n+cPSaalE7I?=
 =?us-ascii?Q?BRr/sAXEzFFvfJCECycuFSzSdBQ0ZxEF++N0Ohe4+5/Dvm/iU82z+337w+9N?=
 =?us-ascii?Q?C8/xRoawremeb67YyBCHhAkynMpq8G9DOYCaBE++5ozMhRw2AVuOsRP+2Rrp?=
 =?us-ascii?Q?JqOpOlhZ/F8S4LQoaFyThagfTJTCXOrACGDtv1CiJ+q2zmCJUB+apiFeJIIc?=
 =?us-ascii?Q?uY3zprqikhz4h8+3j6Uc06clIxL8Dp2JZI4D9HC6MhpsaQ5JDUy+1bK8CrtI?=
 =?us-ascii?Q?crX1uecHLDk0NWmLwYMqUEg8o6og9lA0O2Gf6o6sqmBtDGK06slDvjlK1uWQ?=
 =?us-ascii?Q?pm+JRqc1uuVIPtESMM2JHbF8Aq1OT2SeL8i9pCNm9iC6ILkHKBVR+8Vm6YD1?=
 =?us-ascii?Q?JdO/DXMezu4a45ImSMbzic/lpepeTC7xH4xN1LgejxM+TgK0H4fxWsr2fmwJ?=
 =?us-ascii?Q?j3vehIVQ1iCeZwZIU61MbuAc4C/9HW53yYXFkMi1jUAOy0pRqsiVHhYFlDMQ?=
 =?us-ascii?Q?Q9nvwJl29zsQMljzD4x/wLfd3AHNeYDKxYaq4nSQ3C8n20weX5TtxYuEo+ai?=
 =?us-ascii?Q?b+ZCzwBXOCIcFjmm3damuLz6NBWsL4Fai6Etkq3r8zBeoOxHIhhEDWwxEdE7?=
 =?us-ascii?Q?phnCYwP7Fdxc0OuXCLVuMToSK1QHmm/NCzmes+RbNuFQKgxLsNrPMN4euCm+?=
 =?us-ascii?Q?xW0ze28SBUkD4nhaTVDXTBuRu6Ww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9sVutwX/IGUQvS8qLJv0Y3Rj6Rq8ijwdfUmnMoQsxt5XSvqVPv8fQkUOTZu?=
 =?us-ascii?Q?bL8MuuvWbGgUnF8uIFwRfG/vdMiXGBC1kyXBLvVxEAbtkwwP7Obw/2u1KaIO?=
 =?us-ascii?Q?LKjZMzdMFq/NpQIulaxsUo3+vY7gIJYAcyjinw0tbgzMQRz5AUTVi3b10bnO?=
 =?us-ascii?Q?UgBci5yYIBdR15uLBac+G+m+rIQe4bFhyfuQTskzqwElIG1kp93MtzF8WJQ5?=
 =?us-ascii?Q?ODQbsmONYzH78ac18igG/D1r2C60rNBRtLgUxZhY2DFooBe/P8WUptcD3YWS?=
 =?us-ascii?Q?a+k+u8ude/32bqgA6PZyKzd4z6Po0RU2ZMWsAcbp2eREmwpsoKMyFO0I0uB9?=
 =?us-ascii?Q?CK3ElsLtC64PWUKWOWdd46OHUrCS3zDnJS/4CA9OWXTfKxlH0IcOeH4LIu4u?=
 =?us-ascii?Q?LCJDHlK+amL+QBR0u89K/Jq7tVj8S67PVjmIXs+KCLuOJIdCVW77j0hnVL0h?=
 =?us-ascii?Q?AcbBvgp7bhRRt37SOoD3B1usAC0yfxv1i354zSA3xhrmj69EPXWcHVEw9LY9?=
 =?us-ascii?Q?nB+KkY3r/5ofOcutLHjjcZ5OV1+hg6KPmruQb9H8l4Amuy4r9hgg0cG0LUT7?=
 =?us-ascii?Q?0nzOG7NBsmIvwYKZnY6AFBUIY/ghtUWt8dplpEZuXy09eXt7HmU0QtzAQPgj?=
 =?us-ascii?Q?jDzyeyUPkjRmPbtZXF74uEnhy5HiNN2ksIWQNyT3s3c2weCyynDC5RAm+AqR?=
 =?us-ascii?Q?Fpuz68Gr6HvaDySHx1rsEwOE7g+s9fzAXz9lONq1w9P/fS0LYf/i/QCIaxda?=
 =?us-ascii?Q?tBk2/ghQmKzSwaM8rpgh8NIehuTGyOYiLuRkY15gmB18sBd4QUCkJTboB3Rk?=
 =?us-ascii?Q?vITWHr8BG1aNTHhxR1Szsy/n7ZlXUk47LIjd5KtRY/cGNchILjB6+fhm9f+Q?=
 =?us-ascii?Q?3u06YYBOvubDwC4++k/tq8LiRiAflnGmlXPtq0JZJVDjjHF7L1MksJqL6ohH?=
 =?us-ascii?Q?7mdBTbzjGSvUoEKT5vjQC5wx46CbJt7VGPU682kyNSNLX3f/ZF0a1lUyM6ZO?=
 =?us-ascii?Q?OPU9Evk9IQxXjYUvNyxOkea+w5UBTosg9l0UebhVhu5lZ1pjHk2RXJ+N03Tf?=
 =?us-ascii?Q?e4Qtit1inbmcWhOqWPP0earSmWGuBi1gT7HhlNSYp63Bgj+P9P3bTE/lfW/+?=
 =?us-ascii?Q?jDO2jLfF684cS5aWLz5+vULI/Jutk2+500vqh7OkdD2eeZF1iTYxCIt3Rq7U?=
 =?us-ascii?Q?2AvykmiYSENxMkNEHIfre+nao9x7DyxpD2MMU8Vsoaw9MM4DFAXSe8xTe7Am?=
 =?us-ascii?Q?CUI8pUoKdaeNu5xXL9Qy/1JPav5rEWmiOhUvm0Rg10fGnZIqQt1DU2fVEj2P?=
 =?us-ascii?Q?px+YkC9JZERWHtnFiJqV/0HOFxmRF5MGZk6BcVCsnWX1hjMX7O8z0Ixrtxfx?=
 =?us-ascii?Q?jY7iSe9waCmfMmixRhWLe+UxAY0nkDumaLvTgBLG8V3JIPM3UEIGwlYNxcEz?=
 =?us-ascii?Q?4Vg2K3sgfXu7s0jdna5SNznQmTWz13uZU6tmSGmj3zCUBRugTjtwa/U5rACj?=
 =?us-ascii?Q?oEgAu0mNo/WQhCSVlG0TvfrQ5/94BAeDv9y5NZ9ay81fiP2ettPcgY1M6HVI?=
 =?us-ascii?Q?NiPQbf92b5NBn1OvfsY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33245ad7-d1b4-4aab-273f-08dd654fef0f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:33:34.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 363fMJNKF/NbHkuEZO1ZHABh5Kx6i+WkdCi3Odj3wmW+y3h5SLSHuqcIIV84WuLC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

On Fri, Mar 14, 2025 at 11:09:47AM -0700, Jacob Keller wrote:

> I'd throw my hat in for drivers/core as well, I think it makes the most
> sense and is the most subsystem neutral name. Hopefully any issue with
> tooling can be solved relatively easily.

Given Greg's point about core dump files sometimes being in .gitignore
maybe "shared_core", or something along that path is a better name?

Jason

