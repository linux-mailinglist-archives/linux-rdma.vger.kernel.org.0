Return-Path: <linux-rdma+bounces-4162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE49944CCA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5483285AFA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80C1A4884;
	Thu,  1 Aug 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJLSCHKY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC146137748;
	Thu,  1 Aug 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517557; cv=fail; b=adCdmwmY25HoV5qUGOZuB6Pb+W8Dg3HN9ptlxkV27DQWizl8tejurQiQaTuWk9EIeMy7V54DgZotZoycJxsPJhedIt9jPRnsV0W0lqLc1VJQ/TV5kep0dhSS6x1PUf6VC4MR4nAnwKV99yvjfiAvd0zLR8va/7XP7RM5SWah4X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517557; c=relaxed/simple;
	bh=dVDL+dbzBfcK+nchJ7WTeb5QWYJedJgjVeswhOXpO7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=snxdUSWpjZ5Y94iWq8Vu49HelPP0b9yvN6fuULJPlxnQU6dFrhYayuiqhlHTFUuACSc6JFioApegOq+85XRBjJ2p+d6bWHV3Ds4pglm5vZQZB+zgx3MI2MRp7m3AsnFsLzWlkrjw7cjd6g+QNEzznDNT2qjnytV+NKESzylUDZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJLSCHKY; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNAYrFIyCyyFLeikTddQ/CmVzXjA+FFUgiRoDbD+/Bkz3Ianb3ZoXfQCBJXd0781lJiIxgzaH14v9/zS8gmzCKsDJ4E7y0QWZ9UXimDiyT3RA5lh90B+70VTXGBawtWQJTP388f1nDfs5csE0tRkcgW7ZEQZ+km99B1W9Q8he8gJd3FZo5ttHDR77Mq4QffO4BaEiNpjPo/U9ksDzrdMbnzYSilKXbARXBzOWYrNGqgDb2571JT4FbjJixRgiRMzeduLEvPuJ/yOHmNwuObe0LOLoDBXYnh0kpXolWk3gvx8A4kFbtwhfXrgsvDtE5EL0caaL6/5xiIIFmqxjObOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR6z6kV61rtoRBIO+bwbx8qBrhZc5shcS0D2XcQ0DNw=;
 b=ZMqutvFML74xOqKul8A16CxbeZM7rjIFwVkOsv9GOQ4D1fFAf9ifUAlhSd5mm1EoGzoZEcDT2SSvM0HIA5E0wZtMI6Ij1FC9mLdbhSL1kK/QWMJy0plev0z5EnEGQVB93sgtKXqqtDzZifl+98kCHzWj0nNzcZBOGHJQlVN6zMrdGi0v16sRPnOgzg/IjXng1N8Ktlui4Hyw7sQ6p2Q8Uz70jDgdEYJDNwJExFbmX4Gcg7YT8YI/SZfdEms4U0Lm6fdioC0IEVHY9tcLlW2CBT1vJQ7AeSKDD/t3NitHyeNCNUlB5R2IgRGp0is9mLWLNdrooq9sPzyPrzR/4BNsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR6z6kV61rtoRBIO+bwbx8qBrhZc5shcS0D2XcQ0DNw=;
 b=YJLSCHKYZO2PZLQl7UQrxLkwL+XcEC8vetStpt8yePb8hc9J6DjHmw114w+b2dMFk737DS3rUstcrKNs8Z7jFp3xOQZ1l4j8LkeUZIwjZjBqmK+rTIlu3a4i0MFcORpX4EFzS/fZ8BesrukppgjQav6Z7mmYe3HiQaPd10a3umZ26LnAZbIrb3AVGpPePqgvUEv03H0DHBx7O9VhUw2K316/Y1O2rUYTCa50tmp3pE7nOLfknaKc1rcOVoD8457/B0V1CJSdoUrXfCSznt8k447mkgjrwdjqdov25GyR6lYON7MZpg09xwXzwy/jhaeeFkhgkNcHY0WZ56cHxSWfaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 13:05:48 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 13:05:48 +0000
Date: Thu, 1 Aug 2024 10:05:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240801130546.GB2809814@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726160157.0000797d@Huawei.com>
 <20240729170553.GE3625856@nvidia.com>
 <20240730182808.00003af7@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730182808.00003af7@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f26ac3-d55a-4609-c065-08dcb22aa978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JAndANpoQ18LLtSDeBL+YzQ2uFTSX+GMvtE+pclMB3vXStdlFCv8hBo7TDwY?=
 =?us-ascii?Q?rD9Pu//2+xf8Q5ucpiXlcqGCeeRREyefXFOlEvB2Hfo5gErcuItT9cs8A0Aw?=
 =?us-ascii?Q?nThIQZqxbCJoX5yqhvPfXRdQqoycigDXBqz78fUAToHtimFAKLRz3/5cOi01?=
 =?us-ascii?Q?ovvVo5Mmz/zpbE4+SDNcJr9oyxxO4zdUp3pvL9WXBfkR3OUk8TduiQJv2lUg?=
 =?us-ascii?Q?fAN/fOjqUSEOTP3zSFEzHnHln4Q0QrbPbf72VBZ257DEik/dgMhiUwgOz0aP?=
 =?us-ascii?Q?pnGymiEE14Tjq2RvSP3ndRht49e3WHu7+16WhZhMvtbIXwthPB3xNk0DJD5I?=
 =?us-ascii?Q?ulSPGby+U46j0gZC30sCSzq/Fts+0s2me2nz6xiQVMeMNVSq6wqObuehKgPa?=
 =?us-ascii?Q?z0J8DkIVpnS+zfSK7DqPlLSkZuIuQAONEfCZC3KmybTfFdqf1f3v94nwtSyM?=
 =?us-ascii?Q?pim6lnVqkx0eMPrQvHaKlpJaXzirMRFOM4IbO2rmrcECy4QWkeDTUsH7KaQ3?=
 =?us-ascii?Q?cWxgW+s6s2Bhc6PX2gVsiqT3XUiSd+hiidP1BxXpoJhNIwG6Kqey/SoCVvfC?=
 =?us-ascii?Q?+PgdS2/s2+ZCqbU7TM3H1kUj2nJmLS0UDax5n+KjRf5XTn5Jc8iFBdYqCaTs?=
 =?us-ascii?Q?Qd75uDzM67w/5/VAllsS+mgAJM63M4XRf4mFzlMxVGELdj0AZ4rlDgTECbsa?=
 =?us-ascii?Q?xz0PEwCAMGTXJVNb5BRAG4PArEo7Vh6SLBmmOF8m3S5gkHuJXBq8RA/Mtfrc?=
 =?us-ascii?Q?BwsrcI3et6Wpx+gqc/bzaIBCBoBhb+FmpLuGaluI03q2AxZ3QicazOP90+7o?=
 =?us-ascii?Q?fTobgEHJGTcKoy20zWI8qkWP0n0QUYyQkF5mC26ThcGuo/5vGAkS2KXexvUa?=
 =?us-ascii?Q?JU1CiH271Aw6hOynsYASXV+CUubJXFzZU6w5cHSXJ/zfLL54GFVPpStRcFNB?=
 =?us-ascii?Q?BuMjKjHZUyHRjVy90ezwaYz8TFKZrLlk9Jji6QrFHTZYh0v0wSCHT6YejS5C?=
 =?us-ascii?Q?ylzUKQFY2JE6tipiJh6e9wEnCwqMJf6lGPgarbCZD1Eq78C7/ldw9vGDmqPy?=
 =?us-ascii?Q?CdJsWF1dQTfzKzUsZux2TPeiSVxJDQimvUEtk6yBRVhgW+PbfWLlCO8cQpkm?=
 =?us-ascii?Q?5xXAwnzovaKTb2gtCGHm5SkDNV7/U3YRZzwyFkrfBLZdd2pQCLdTigc5Pt8C?=
 =?us-ascii?Q?j43U2/d7yISX7TuJUUcHVBT7dxXi9rGQZTUTH9XO01p+u+vZa7htzkuDkm20?=
 =?us-ascii?Q?262yb9lG80VzcGYtQDmcwv0c9imGkzcTjH/vMWR4sa9umWvisnG0gqG+cAwo?=
 =?us-ascii?Q?z0+pZ3/xsOoSN2CihvbpYjxAKOTj+uSWLDjui8mc8XCMyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xP3lzca/3RdxktLkZTGuAO9tHdfbbOaE382WrBqp2LB4D4mQHcnlmd2n7sVv?=
 =?us-ascii?Q?cSC22cjcWsNGl5CTSxa2hENZINtPk49Ba7e+o6wIKQfGFh+AgXQB0vKnHp1s?=
 =?us-ascii?Q?xHpJRRE2e+Z61EuPGxb3rmfCttu4JTa0Pj0VfmCvKgDi+ijWkfUWPpI8Ry/F?=
 =?us-ascii?Q?HLOPuIw3pZhI/m9xmEE7WGKZtKrPkNxT9rRuHn8nPpzxusd9FsAwA+9jpsgo?=
 =?us-ascii?Q?vEOu7vjSO3y76d9IoJCDCOvG5Wd+p8CbOWrrBesmvXdfnC+lBNQD1nRXNOty?=
 =?us-ascii?Q?VGaj3LxGP5HUhntRUl9AzcbqxO0cetCMTyBUKUmrHLfdd08PQok4GibROsTj?=
 =?us-ascii?Q?sZYWpzAhsMOhrV+8IqPAHxn16xRH1t/y8TMC8bbT0RWAQoHjCkmEM4Nb4p0q?=
 =?us-ascii?Q?OOX7Ic4+N1eZMo2o7H6Xq764y1bm3ERkCTij5GlrnhZaCB6CTv2Tx6V70qg6?=
 =?us-ascii?Q?yMJJRb/2JDQ9UBH0SyYr1jxyZdsUxIDTGqxWSYwXXcxbkllrS0zeD6jKfEQ2?=
 =?us-ascii?Q?PopN1vtq6JLog+iiCKP2VM4r5BWG/Gkx+p9Q7/jPBQ0Clw4RR5xsCr4RO6/1?=
 =?us-ascii?Q?Nn08CeerWyzesLpJy0HlriGfe96QYe/tT90KsstUnnap8yAa/uO9p+p/Kqor?=
 =?us-ascii?Q?tuUrCmLyD491cyB6OnaGkraNUW1T/wYlKiqdUL4kbaUXEN2+/7C3XOGT2akW?=
 =?us-ascii?Q?W5s92qJy/4krhFlRRCdBWY9m5BThvMV2e06T/qruDqhfuUZSVl+NhhwFjFMg?=
 =?us-ascii?Q?WkUacmPrlfOgZ0io5FMUExlmxtwqkqKMRoozvwWIFXuyNOfNm75PoSLGSOlC?=
 =?us-ascii?Q?aaamHO39+tJtgZrIUp8uKs/lzS8HvSbl8oBKsGyA2VCKa+sb3F9dmc50WSjn?=
 =?us-ascii?Q?JIrLYhcRgZSwRpiLcGu+/4nv+wOxYflY/5idUAJab8ujVgFdi9PjJc+CNB3W?=
 =?us-ascii?Q?fYzQnLyQrlv7UF9md9O/phaybgbbyl44upSDBncLmeOWHLCqmEJ0GfPP37Ru?=
 =?us-ascii?Q?DhRZFGsW3hsYxkJh9+ng27+LN7GKO8FzS8DDUUN5XLgGUrS+e1Ru18ktAAlW?=
 =?us-ascii?Q?KNPFjiscvH1hmEXsCAPR8zjnSqTm2trIOFvzzzEgFIlY5eeJ+qoFEdXTKYAx?=
 =?us-ascii?Q?Q0AGtH6v30OMnHU4aoxhh1OA7vp7nFtvRZJzrDiYdNDNh7yCUQYeH/T9HMgA?=
 =?us-ascii?Q?a92GpvAiMv3ploeZ5R9ZcqFMjLstVBUDxxZNy5LJ4P/3YoIr76BN4TCRBUJk?=
 =?us-ascii?Q?dNnSKU6ulAUnubkLKkhW9oz4nnAJ/25/4k14WaY6swsVAmKBf8QwTrP2g07S?=
 =?us-ascii?Q?L/R57fXHj+M8zwB74gNYhVRhwnOL+JAFMSpc37XzTFYiJfUs3Mx0rBR5VVAY?=
 =?us-ascii?Q?VYkd3poubcXpPgJ2+C8RumT5ypk0r+2hMz6wBgH7Gku9IrEll2TnFhyNe8xN?=
 =?us-ascii?Q?ElPaafmiWPhIlgTxesRUElW5pTVGUydz9LxqzaczYz0z1shFh6Dr923I2IO4?=
 =?us-ascii?Q?fbNhyzWN1mjcSrijEjW+xWVZqTK9RmN0lU5mUDeW7Bxs9Lcm9CFe2f9plZBb?=
 =?us-ascii?Q?SqZiy3BEcOFDuJYDb2QXJ0wWhbcIIZ+MSh+E4GFO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f26ac3-d55a-4609-c065-08dcb22aa978
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 13:05:48.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgcuJESmNSK7jyk6Et/rFe81oLqaooWvyi5OlPfpUyP1IuBaLU3d/yUpdRa+F/wN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

On Tue, Jul 30, 2024 at 06:28:08PM +0100, Jonathan Cameron wrote:
> > And the basic userspace pattern is:
> > 
> >   struct fwctl_info info = {.size = sizeof(info), ...);
> >   ioctl(fd, FWCTL_INFO, &info);
> > 
> > This works today and generates the 24 byte command.
> > 
> > Tomorrow the kernel adds a new member:
> > 
> > struct fwctl_info {
> > 	__u32 size;
> > 	__u32 flags;
> > 	__u32 out_device_type;
> > 	__u32 device_data_len;
> > 	__aligned_u64 out_device_data;
> > 	__aligned_u64 new_thing;
> > };
> > 
> > Current builds of the userpace use a 24 byte command. A new kernel
> > will see the 24 bytes and behave as before.
> > 
> > When I recompile the userspace with the updated header it will issue a
> > 32 byte command with no source change.
> > 
> > Old kernel will see a 32 byte command with the trailing bytes it
> > doesn't understand as 0 and keep working.
> > 
> > The new kernel will see the new_thing bytes are zero and behave the
> > same as before.
> > 
> > If then the userspace decides to set new_thing the old kernel will
> > stop working. Userspace can use some 'try and fail' approach to try
> > again with new_thing = 0.
> 
> I'm not keen on try and fail interfaces because they become messy
> if this has potentially be extended multiple times. Rest
> of argument is fair enough. Thanks for the explanation.

I'd say try-and-fail is just the universal option, if there is merit
we can put cap bits and other things to positively indicate increased
kernel capability.

We have quite a deep experiance on this topic now in RDMA, and there
we've been doing both options, depending on the situation.

For instance you might introduce a new API that returns FOO and extend
a prior API to optionally accept FOO as well. A cap flag that the new
API exists is useful [1], but it is not for the prior API. The
userspace can just blindly pass FOO to the prior API, and if it
happened to get a non-zero FOO somehow then the kernel must also
support it..

[1] "try and fail" works well here too you can invoke the IOCTL with a
0 size and you get ENOTTY if the IOCTL is not understood, and another
error code if it is.

Jason

