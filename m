Return-Path: <linux-rdma+bounces-3932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ADE93923F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E58282694
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320716EB40;
	Mon, 22 Jul 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBrDdy+X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E261598F4;
	Mon, 22 Jul 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664256; cv=fail; b=i6v1+shhoIKuIu5OWWC5K0axDCJu7T8FfKtcH/y+8j5k1QjcjYrVzVTvWTn6p8x6xtlmPPDnQM2zBQKlRF5xXMpzZ+VsnbcM5WpIJayaFqtUQcG2VVrjhJ63SQRXBxFknVwF7dkqJ7y6CcSYG1I1YGw+Xp1/jQ1SiNiGEQxHh9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664256; c=relaxed/simple;
	bh=CYxVVKDjIl2QkTgf+nPgfLltiYr/yaUCWUwtF911fqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ryw9bXT8iq1/a6IsgP3+GFIPyVwRdvIQcNmFD4V+crRuOh8LqBwOLzpv9PtWsqxJup3ZVC9kNQA4rO4rMivZkNAQwLy3bUULQbzQRBwyznOWtp8YA/5M6jGUPnXdBLDl5jPi/F/ktePwpqdvIilS/LeGKjrKz5+TfvevhSYSKuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBrDdy+X; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BssVWwC9CZKuUdvyBnw08sBmFnbhjTaoyrtVZBjtpa2mNi1mM2C2GXFxhZ+Fa6anvlwE+0OOdOLQTCnG2qlSeWRiIF7oipNdoIMczbA97Fbq1yMBVTuFioN5wgnv1c1GdJ9JxiZLcgnC8INpUiRFRvELSIqTQwiA0Cd72l0r4tYYIHB4EBYjsUPVPFAAqmD8lLHxmc0qECvFGsdcQ7wH0QLn45NHLFqTka5sZNHBHWSl+qPUK2xWrEA1BGBIGgPnJ8okX6c48Ftdl8Yj6U222eUJPF3V9FduSwH/4EXgbtRYdp+kQ/6Zs8LTlXamaM4R/qabefq8CFzEa4QVAttv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah9ti+BudhgtD8dLMqV8Z6VRTbLhW+z/jtSXyxQ6IJ8=;
 b=YBxkSrezBm3166wJ+oOQ0/9LBt5Mq9i2qbY+ZArSER9tkJ+ELKZGu3YcBDdLOQRraMee+Hf9d0xAV0vrQWTAbJU/ns/IDnBN7j8pl+ctSTY6Tlb0ay1fJ5E42PHZqfNzYU2ymsFStJbRCtJSilEGWkX0yryw++tgtJHU76eLWCeYRCB+y7YKs5IpzBlatfUWckZeMEJCwvqDYvEgFwdZ0wCk1smbp3UJGUAxla8OxLBfc0pMcOkWAYaE7Dren/I9UrSi9WOb+DEZaKAQSG6hIFgbpDodAw8cnzNyi1RIpNjqPzDGCeLvaeHczQaX19EvhpN9mNJfynJ0EV8Ir7oVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah9ti+BudhgtD8dLMqV8Z6VRTbLhW+z/jtSXyxQ6IJ8=;
 b=cBrDdy+XyRnIJycwbIoGlnYcRtGPMXmS7pDOzlhzhKwd7EFD99V6ycHkw+PKhVuaHv5DEMweOfUjCJjsU+wCDhY1F9dGa48R/t+EXUhDdfhVdNnq5Y6N5pL4qR7ThTq3VaurioZWIWSUhwS8J4/0q8T5AGwCdVuxSy8PCO29L/F0sIw4T4PJBT70qPKAYWssT6h26pTo9LQ3CdYZDeSNBKnVezi3wq6UngqofD0IpOCwttzuQTpOCkV33CG54sPHeXHHqBvKdWe/Tvk3gPDwNxgPsE6iAXbsNrKYWVPDaXLj0UPNvR49r+Tl6mGnMAXOpoEahp44hVoeeK0YXrrT+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 16:04:11 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 16:04:11 +0000
Date: Mon, 22 Jul 2024 13:04:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240722160408.GJ3371438@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <ZnpLz_w0sKmYNVFt@archie.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnpLz_w0sKmYNVFt@archie.me>
X-ClientProxiedBy: BL0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:2d::30) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 05366737-524c-4b74-f2ed-08dcaa67ed05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnrwZ79NAvNYvzddpRJmwMH96tXeowdzTWvn6hKnQ849rSaa2WBokAOYChO1?=
 =?us-ascii?Q?tpC7ANudDGLDKfm+FE3z1v0O7cr3cvil9YPkk8GjtIr9KjpZjBYXZzYiVM7Y?=
 =?us-ascii?Q?5lT7cysEcLSGduqTZMXXiBOzy4ydJ5MAZIHlji2DxoJXO4XdcF9+um2LBi+y?=
 =?us-ascii?Q?H293d728RrVajUcSVRjjEXDQcSgOVwArM7Qgy9FhIrw7vkmfhZPb+wv14P/k?=
 =?us-ascii?Q?8/yj9W92IrIuLg74I6nYA0ULsQ/7b/mMnVelLEHnjfW4MKjTaMUcw2EZLZ/s?=
 =?us-ascii?Q?89jMd7FUE6DSMINkyihil+Lnkr4DR95eMZJSX9pqwe8+rso23Igjo8TAfeO/?=
 =?us-ascii?Q?hEfq7r3C+Kw3jHYq4QtSZsW2zcw3ADCnGMWtdh4bBrB+eWJ4ITeISuznchaj?=
 =?us-ascii?Q?Rc/VS9WBE2DZoJCgoQkbgE+HxdmzWVPmOi+ru36AiLDdHeYzKlCGfbssB7qP?=
 =?us-ascii?Q?rSMEUkSQeCBTEXkvgqfn4hg+xEg050BOdwhIhW7t3xdlhPjBSr553aw3M9BZ?=
 =?us-ascii?Q?hnq8TB+AGXA3IqmQxdDtB5Nks5Lae/jyaAXjZa3EsRfnzqiyEM0MwvhdAIVf?=
 =?us-ascii?Q?guEl2LnKd0YK41+QqYIZ6ALdITEguBjW34wgsdw0XPxRxYrON3PaxGrn+FO8?=
 =?us-ascii?Q?dQLV7Hm+7OQSi6Et1uoD4zHwQpy4pr3LfrXPQOsxGlpHw67mIqjY9zAvtkPf?=
 =?us-ascii?Q?9o3EOLQyvCcwJycLOvAoG7IrcA8X6WN+LGWzhJcqLXkEPvmoSQOfjEBqQW07?=
 =?us-ascii?Q?isWuiKTgNwyJ+XbD4JSLp7blJhKxguFyIYte2dWDD3XYkyvN9WVUQM5iSnfp?=
 =?us-ascii?Q?dAlCnJH+d3IGxSgE5seDh8qdQtVwMwTuvL8EIjrN2x7KN0N84XIyz/NdQMnj?=
 =?us-ascii?Q?PyKirHo2bsOCfm/DUmYG4cykoqsvSwQT5HlhHgUbDCGndXEXbthzXXZH50p6?=
 =?us-ascii?Q?t89wnWoNUFS3qw/eGXjpA6MuQqKEmlG8+7kJbvO+Ll0yZJ0Gt8tzE4mzYyej?=
 =?us-ascii?Q?Gvpu+0O4eHJ7vadelTHtUY6Os7LkRKKKPf6NbD+Q87ORVYe+wr7mx+7MSqi3?=
 =?us-ascii?Q?GJQXkjwYemIQcao6VnAfKa1ic7BeDLXmMCPlKhjEbb5T4XKNTH2KTVw3Ntpq?=
 =?us-ascii?Q?y2hemGJE4JNOEot7KPFRx1143c7grdwgRdutcHQ9MF/iszUCJuHL+fp6bUXb?=
 =?us-ascii?Q?pmKFrY9HeD5nTsNHjwtT4JOW8SU+mJxXto2YVbq5xRHiMkmi0r7PfK9W4M96?=
 =?us-ascii?Q?vtowGFDekVk+h8EZGbm5mHyo4uw3wp8NhBxqbxXLaQWxhiknUoKsOsGP9Y4d?=
 =?us-ascii?Q?wyel6jCKBcrgwTrAsWUl53KN6VENJs/cGWL4hItJngsmYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvS0DY3X/rUseq1Td+7jJ9Vbh190nMutbsB1YxYWBvpK/Nls1XZ2UDSW34XA?=
 =?us-ascii?Q?VzI8c7EDIq0AZhRDEaK7WqSj9n4qqLUvGqbgk/cN4GJiJ2aDIUCJGvMH+R0h?=
 =?us-ascii?Q?2Rwa6OIK25A2bBUNmLaI+M4jdcLzJzNtrSXIofODKaICu4J865GgvNyIl+g3?=
 =?us-ascii?Q?cu/5/EP4BvRxmVXFB0xiXoCw7o5H5Tzo9QM8WDsIEPh//ifGg+9B307ejcJy?=
 =?us-ascii?Q?x0ubeZ0FayanwBayTPZj85d5QTG9phk9S5K+2BLZ+zg62RkG3bYLL6oqWkMZ?=
 =?us-ascii?Q?mHWo4Z3UizNFMnQF3vOPS7qTwWFFeURO38ltzBufUkfZrEvEv/zz/72VPHYt?=
 =?us-ascii?Q?gX/E5fR2to+QgbVB5YBLSIS3oqTTNZ4hzVxb9NIILcHUOuNTMayj4vUebpYV?=
 =?us-ascii?Q?ZFWsev4TnSt0kz6FA7OqkJ2qJLLa3jsFPZ6XN5UokB2aJnDwIpmaYMNXdNX1?=
 =?us-ascii?Q?xsumfjCNGemInkTGURKozOxtAHsioCVGigx0retxO28buwsEe4UZZXtB3HRP?=
 =?us-ascii?Q?aA3VIrmqy7DqSexCRpQh2mP0AcXSUZmqWmOzdR9aCRSp1oThk5+nEFJAq2Ww?=
 =?us-ascii?Q?kYlywqr0dMoYSljHYtq/82d5RnN8rPMW6SoZNE0mA37L2JC28RxGmbsxbSoR?=
 =?us-ascii?Q?961TXxHHu9ttHMyEJj6ry/Tz7KYryIi4WFelgidvDWjkfScGTWf1yoPH7O0f?=
 =?us-ascii?Q?SU/dGPqpozKd3CJVTqXnoqsE4bgryBWbF7TKYzYaZrzpJ0SiR/EIbhM474S1?=
 =?us-ascii?Q?4bZuyEGxvsOz7a/Kz15Ni1uEG4rTTeOExlYJzZx2zoHS3vOuE/2DjRXwvOx/?=
 =?us-ascii?Q?Idr3RFC8IgloXY5HjDGkxD5irNt6l58lprn+gwVora1i+tzU8U1VT8WA2u3E?=
 =?us-ascii?Q?hnUUywjgyFx1BFfItmY93Npc+iiL0Qk3DLYJUTqTF8q0SoVrsnnHJ1s4QsaQ?=
 =?us-ascii?Q?Ntq5TIxpUuGpfr5R6VuLrpcMSacey+9f/rm7t+smLnldZ2QikAgN9HVXF3JH?=
 =?us-ascii?Q?KacKhu90Mxynp/ZTrd+pixzsPHZAG1EMUfgNyN1X/6UFdSySl64dcx9Q1dmZ?=
 =?us-ascii?Q?Dpe1TIrPYSUdZW2fOw2EvSrL9VVT/Q6IOH/iNdaY8TTgQ92/+WSb2w/1Ohh7?=
 =?us-ascii?Q?u5VOqDr0tazENc1qR9IgZMWA5lf9ZTGuZb9EKjvmKxck6ndnv/Ul/2Nyj10I?=
 =?us-ascii?Q?MV2fnL7bQwgRQ/I2xTR8A7hbcoLo6fpAEE19HF2E8SyQDQR12KXuHNxp295k?=
 =?us-ascii?Q?Jt40uS+uYmv45FOI8L9DtdDj4juutOhgQYHBdOQh75YriwrlKWh0/at1WOJi?=
 =?us-ascii?Q?NeoDIFQdOzlLqBV/GNLcHLPhyjCiTFaHjTHK4CQV3vw+bs2FSzA53tF/zPGJ?=
 =?us-ascii?Q?ieJn1MZgkUJFklaUu30LH8zk+weTp9K9lba5nqTgfRWXe4Lk/M9+03lz8n8a?=
 =?us-ascii?Q?WZcnGkMYjmSue9seDhihqk33HpIV5a8+Asf+BjRioslcgQwOFjXaJLnjqwPq?=
 =?us-ascii?Q?jyFgCnP/DOm4ySwQo0Bmh09wHdD/vQqnhkg9EVfgAou9JrHCZIj14UfN5Win?=
 =?us-ascii?Q?lW5lM7RPcybEJvbZnVw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05366737-524c-4b74-f2ed-08dcaa67ed05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 16:04:11.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loW7WlKNyzmC+DefxXLeBRqptgbqGLHcOZckCyc/GYudrVpgOJB4FXqW3BLa80lP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

On Tue, Jun 25, 2024 at 11:47:11AM +0700, Bagas Sanjaya wrote:
> On Mon, Jun 24, 2024 at 07:47:25PM -0300, Jason Gunthorpe wrote:
> > +/**
> > + * fwctl_alloc_device - Allocate a fwctl
> > + * @parent: Physical device that provides the FW interface
> > + * @ops: Driver ops to register
> > + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> > + * @member: Name of the struct fwctl_device in @drv_struct
> > + *
> > + * This allocates and initializes the fwctl_device embedded in the drv_struct.
> > + * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
> > + * failure. Returns a 'drv_struct *' on success, NULL on error.
> > + */
> 
> Sphinx reports htmldocs warning:
> 
> Documentation/userspace-api/fwctl:195: ./include/linux/fwctl.h:72: WARNING: Inline emphasis start-string without end-string.
> 
> I have to escape the pointer (while also cleaning up redundant wordings on
> error case):

Got it thanks

Jason

