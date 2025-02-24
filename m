Return-Path: <linux-rdma+bounces-8043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA3A425FE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 16:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9575618959F5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31A158858;
	Mon, 24 Feb 2025 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWpbU8dl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C9189F57;
	Mon, 24 Feb 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409903; cv=fail; b=uou76ra/78UrGenDmNvApE+rSrFNqzu+l4tn+L6ih9omkezt9F+toa6Mg7NLGUe+jyD6Rax/AusR96ixEuSL1glBdii1JYNjwN6IjZYffa2qISePi0mC2gSQKzNDI/aZq2YPS384nUOuJdkjptfvHRemLEwKk+SYFI8OrQPQY5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409903; c=relaxed/simple;
	bh=hTPGhS6EPPAUh34zZnbd2k4r7U7bPgpdBjw6odnlvwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAY2GHsN84JN2FfDfdfgm2I/S8tLYevnGfZYqXjlSzSpmUKlv4YGvzfqVM0GtLFOzz5YgkOpC5GTSDTfF/fcMpBI5/iNwm/4LER8xaoqAiCxATeUGfHXnF2AoPwzoyspfGIAyYDiJSYOBAh3VI7yUdiK52jsfaHz5DxPFSVOtSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YWpbU8dl; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO9GxU0hO64NAD8pySauwbA8DyZW69eSXOpISrHgLKcNcj8UK6m1Xedc1a/8ZolhEpjKUYprMKMADaz9Kpj2zFpJwKK1X7FUufWw/kUhiKxJJxDe3SgGKdnv2uopciip9bnQsSu7jCZdT7jVSothLmzKJNf/9LX2YC/xBACo5so6tqvxBhxbGUTE6+o2wBHbGU75VwrLTM7eIv91BdMSwgQH6wjba3l4JkOGgdKxbYADB9FeNiD3rUOZrIG8hGLoQrAwi/s1rfN08o7JvjWrdXe2jcmq99pqtjliIp/aUez/412OzHEcmXJn+YwzkUQDEncCF0YQ5XKGi+xBzAQbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbcDnvgnyfQBlWL5cFNDLIjcR2f/D9Hx0zYT7kFEzD4=;
 b=APVdjUpxWJpP4DieBA9J/ejD3AJHg3V9IX9MAmJVF1cHv4olH7gqNyWMyNTZExOg6OwsWj24mSHMy4pcAU0SztjbsOlJOF4PRmhU1UR8c8ZY/saeUMHMcy3VjaGphrs8xNCPPf00Xemtk6hHTGKH0RxHWMxOaAqSyY6KznhhCfKO2UEA82lyhbToo8t3zDclB+YyChtP5szWGjz1wNrQZvPXe6bziPb0+F4kI3m+z+6el/Nr28y2LqAixkKbmXOhteM0Pkxzdfo+piP519lnzVKvnvz58HnJkVKXD1p+4ncpszR2DjQQwqCbdmaVe/JasmCjNopoXzs041wtj7AKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbcDnvgnyfQBlWL5cFNDLIjcR2f/D9Hx0zYT7kFEzD4=;
 b=YWpbU8dlCCpEsZ4Hu8AGyfWrB9ba/CGq8DDBABVqZA+5U+Nvnghnr6qCc0yU1HWZLst29bzp8SpaD0NTjh/cbiOpKvp5HCzQfpiXkKg88VnE0O9kHVnj2WjMy6/UPqIaV+//Z2IBJvlCQX662LwFVt/WJMC62asFaNzGBZk//YWbBkjPbEsce+9Tj0bEugKVi06HUSsR5VDDSZ3xkQSash2Q+nj6bguBM/qRMGCOd5JcSEzIMhDSDTo6yv5Tm9zL7EeOwj6mWsoQtrGg0O2RYxPhP8G7lrVoqJinAUkAKZ46DaSPsUi2se5HqeU42u0h7mA3LzGFDyLpl9lb3gt4Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:11:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:11:28 +0000
Date: Mon, 24 Feb 2025 11:11:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@mellanox.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <20250224151127.GT50639@nvidia.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0475.namprd03.prod.outlook.com
 (2603:10b6:408:139::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: a31317d8-8279-43bf-7754-08dd54e58364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?79MspTUaYcgsJ2VMWYeusmsYU1Oxsa1XQpXF76klkNSlXzuZxEc7CCD36H1a?=
 =?us-ascii?Q?UGODHKuU8sjMkN1vBbtm0mmonI2h/B3Y/zzrMwYeuLfcdOje40Jr+IIkzzp0?=
 =?us-ascii?Q?13BHFXLZPEUDxnrr+ViW9nwrhirMVuCb5Y0u18q80Xd992y1xNgPnPgZOwLf?=
 =?us-ascii?Q?GWZKVXZIbwgJGMxjFxrRRqsOKowndTTIen0CZuOqrKVCiVZIlAuJAE5nG7bB?=
 =?us-ascii?Q?KL8vC/jnczUsl6SuAxRkeImk43a8kp9ER4OdB+RCarQ7gf3YAKFbmgNyB7Hj?=
 =?us-ascii?Q?AL1tWepis9SmwygEW2QMXEJNyozIBr4ai9ujQYRR2UGpGF8xY6cDN4kcFz7L?=
 =?us-ascii?Q?0Z6SLdekz3p1IyQcFy/EqJWtM65ceATJH+YdLyIuslMOkCkQyHAYOqdfWX2c?=
 =?us-ascii?Q?OhV53aKsLr1pOV9iD5mbveEqZQvyhTwYMNtkW8Xr8xMVifEVM3Jka5um1sk+?=
 =?us-ascii?Q?rvbDRIw4dP1tdceFJBJGEhM/mrL7/K8Ms+kyNxK4+0k9r/rvuHnJIlI21U6e?=
 =?us-ascii?Q?PKZ1E9zf3kUckQAxvass7KRxOBd3gnJhnBVTDZFQrDW3XIp7ySdavcZjpUNZ?=
 =?us-ascii?Q?9g+HJIy1Fgse8xn0O5S/dRtJ7q0FYUROS/ZoEJw6xEYT+8tG5upvhgey8fB/?=
 =?us-ascii?Q?UY0ClvJC0Fd/SY8CZnZTvBgA7BW+/WbVZ6n3U0HMQkOY2XnXEb5ucJQcrvnH?=
 =?us-ascii?Q?htxg/NfZXzWsXM14czkZSkdGhOfpm6Sf2TK4pnBnXsDLFHC0yrz0ZM7GsulU?=
 =?us-ascii?Q?8bRq9J3vswJXhovBFSQwUW3mqi/STTBKdoKk6Q/IV8YJqiv9/GNeAYWMAu9Z?=
 =?us-ascii?Q?mpIvHG8Pa92vYQlKhlaoZSxUjBpQOWe0cZ4dOdDpvk90wJdvtaE47IcRC+pa?=
 =?us-ascii?Q?7XmZbDdvkkJljRWCiVk/c1kwy9avTM+POMs33AkYC2lz5vUGGeRH5E/T+HeU?=
 =?us-ascii?Q?izqWo9AAuI5oFkPKwpKQzfLCaFOdtRx2vcvACJua0S0hEkDpmd0CnACBS0P1?=
 =?us-ascii?Q?SAMcva/1UtCQMLtbh7INrmHNe6wI4BRUj5253Gd4UN97BT39KC9wVf+dpjhN?=
 =?us-ascii?Q?62YB4Bht2fZ53WoS5zrCfUv4O5RRACD62wizV5crdVy9WFvQ+XTW4m6r8srd?=
 =?us-ascii?Q?1oag0T7CQRaFYFGMWgAE2gFlrH+OLU8lLZpJUsPucX3304Csw79L9EJ6sQgR?=
 =?us-ascii?Q?KHI2wdIx4Wkx5Z5f9UH+OZF0utr4umrzGmxvf+s4zHIkdv+UX9gggR3TqABa?=
 =?us-ascii?Q?jlt3v82N98IMmGtxZacP4W5G0TtjY9t+SkqLKdm7J871ttxGoJOgt0pdYafE?=
 =?us-ascii?Q?XNq8KWIs/BEiHeWez/Oq2JHrmqalZyJmAr4AhxEkfs5334UfNYwSR9uY9qY7?=
 =?us-ascii?Q?hjFqH+gBEdFg5eD0LYimfNdXbn8S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9BqlsAHDiZtNk2qZvyVe2SLl+3nBOP+z9uDy264gVCLrv9CvTanFBKcjYxS?=
 =?us-ascii?Q?87sEWw/fIX133sewsimbjzHj3MWYhZ2Mg+EnsHNdh1fI7eYJRYM5OZJ+yCxP?=
 =?us-ascii?Q?k/ZeVhXyi8q/+qt8vpLm8dtGEl3ctblhcRQwrzpmTVeQmzjIe5/UHXPJ51ji?=
 =?us-ascii?Q?XwVvxQc96n2hATku2B0oL8uU4IEBd6Gu+GtbPipj+zCRZ0e9Tu/IaG8j8/gC?=
 =?us-ascii?Q?hf/JsFTSP6HEnRsXXREs7ehuW2dR3P7GUsqncdjeNtAr0Q98dM1RP58RnapA?=
 =?us-ascii?Q?44yh0XIe0Ksj88M9lBAyiz1H+QvmcBkfFFxoWs8qhPcz3cmW1WsPQV0mhYH/?=
 =?us-ascii?Q?zCBacWc0GE3hwfLT8yes0l8Y8lEwTohACwjOFd+nExrOHBlKTIs+XthJaWQ/?=
 =?us-ascii?Q?yyKG6KTY+6a4E93hwR8wcexrqeogYKy5lX6yTGxi+jHi94bJQ0e4aourB8As?=
 =?us-ascii?Q?mUbX4/r5yMTYnXyb28YkiCAlvFQAUjdonKlsmOH3ZjOZk8XGua3rXUx0Ea7Z?=
 =?us-ascii?Q?dYvX1jlbJ82yOiSXeFcu09L0LMpyYOFnagEhREn/qLs9ud31oBhLAYhnD73Z?=
 =?us-ascii?Q?Pns/DZRsCJdMnlf4Asz1yKuTLCG9BeeAWd9qpgfasnOECGoNVvrECqxLtgq1?=
 =?us-ascii?Q?Ck3+mNRPgSTD9CLRbmc9Qw8S2KfoJerwmTR98SUplyN/7pcT/j+L0YY4RgFh?=
 =?us-ascii?Q?Z1JYcF3nNg3H5enmk6b+oleakbMB0OIYhm5k+r9dtWCdlQgqKj9ubivEnwiw?=
 =?us-ascii?Q?5nkbxHsHsZh4BOydWUG21gVDgW9qhMCW6WeCabwAU6wYt4ljRt0ThxNIza9i?=
 =?us-ascii?Q?Rqo2kVmSrtgPxUod/KNfEmT7usvTlLMpIPdOZINoFWa1un84D0fLAmOYk/0P?=
 =?us-ascii?Q?vwCE+GXzc2wN9bjUvZHp+jjRO7iIwfmRPonyA1tyh4//zX4oQFvNZFuXk2zO?=
 =?us-ascii?Q?N9xQS8SEbIMz1sfP7cCauNVZ1IjkkxiXdse5QSUNpSnTRZfxialvHVgB/4kV?=
 =?us-ascii?Q?SzGDMxvp5jEQ8kEG2Yz/2fFr3IYbF45DE5uls5X9jg9zAUBKWrBQzcphJ9rw?=
 =?us-ascii?Q?zlTNaHPUC5sJVXl6Gu8mNDQ+/wacGRYCIgUi2+z895pUBS6gzbyro+ge6GdK?=
 =?us-ascii?Q?S2b1iGESN1SSlTpMv9AP0NYMEDAkP3iG/skdhCO3Dt/DsYRd9nCZLnduVKey?=
 =?us-ascii?Q?8vIB2UYNA9ba6KbZZr0a6uaHtUr4s9CRCJn96CxSLB2e89kDC1fRepMpJY31?=
 =?us-ascii?Q?kjqmPPF/bpCuxeMJf0mT24eO4+0VBNBEL5ZQk5IEGoRekuogK8t1c+sZwHqj?=
 =?us-ascii?Q?wJN+owoL0M8Q7iZz+Y6qIFTsEdjsNGzpv6UFIU0llgJsiYbcPERDMVUZMw/H?=
 =?us-ascii?Q?xYib9ekSxmGPa1esQIo74MqFXADe/huMAvNI9/ZS6M+iHrtPfdg4I+dntNuS?=
 =?us-ascii?Q?v5Qx2O2RmXbwUGI1iRNGHjkTVIrvB/fqx1rs12dp5l7nSW49zhL8seK7RKFP?=
 =?us-ascii?Q?51mGGGVH7pPj/7q6R5bAF9VaKVQUpW/sc/XWzHH83WFbxjOg/ORLTJr07zZA?=
 =?us-ascii?Q?+rQJA/L9tYno5H8wIXs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31317d8-8279-43bf-7754-08dd54e58364
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:11:28.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI1Y6Sl6AUBu0twsk05M5PGwAiEvOqSLV6nSVFHZ5qrZVOPo7uunwtBCEUdEnlfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975

On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> renaming ib_setup_port_attrs() to be generic.  To utilize the group
> initialization ib_setup_port_attrs() needs to move up before
> device_add().

It needs more than that, somehow you have to maintain two groups list
or somehow remove the coredev->dev.groups assignment..

Jason

