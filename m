Return-Path: <linux-rdma+bounces-13038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07510B405F6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE21D563012
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2722EDD6B;
	Tue,  2 Sep 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2RQdsy1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687B20B1F5;
	Tue,  2 Sep 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821398; cv=fail; b=hyzdzV3tVsCiH3m68N5XjkbL1bWk5f5pcPqrvfms1D7I4Rak3AzehSalK0nVy5JIoQAHdM7lzQkMhIZvMFh0NUtegMGS066eCDE65XZaOfNuf4Eq6DIbH7vQKo7KaDGxES3/dV+XYFs914gRurRfWtTDSwJSGSn/KUHGqt+Jj3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821398; c=relaxed/simple;
	bh=481xXnogg0xI0PAS/zL/3jWgbEyUdLEpcNYBWqP2Zms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AwZJXI8l35bMZXWUCYPYcIsu4m4fb2Qap9gx8NHjPwjCMIdq/v7aj8Xc67e2bwd9fjWrXBhIOQQtJp9BnDsoxSp3EHDMdXnYHO5bFTvRjk3OeeLFbywm49e+PkRJMb0IiSOJ8cROjMUaM5IUtnVEnwvNw87qzj1xbzsWvDvS8ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2RQdsy1; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9wkQzKNpKNr7YoCp9//JEqULMOJ7odEhgk2Q3DQpgSd2nuzng1aSAqiUBpjnvdHdSnIov3RJfI3FRYCR/YZOLaC2zih3AhJb5OnSiUFBO9CwtnsWk/R4jtQ9BjpNRFYdAGoQWgF3iqHMHY46dul5VAkRHI2Fz6l5k6dskw/xQR5qfCm1pPoVUMPDXgf/z+IOJ9xAUrcaHTvNvSbeypVEuRLAC/USRXG8jrnYUj3YPKp6naaaXT+CZVJ8H1xeHdlDLa1e4oeKwFN414RXPmBwYWA9FJ6+zEu4Z/2vORzdiudC007FOB0mErqEAP5ZkFh9C/ZSQB8D2n9eIZMfsZlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+Qow4qRuSHkcAHpAqvc2yW+215D1SRosVDTop+mBdk=;
 b=qWZBemB2gV3yio0hLJ8w9nO8FxwiIjpcCS8WerE7rtKcZqGk5GfvXwSPl4HKvL1KtgbEaQGVaPWYDGAGO7vZEhsWSBDDskIE7dDju/3dwSB831WMQQcNSIIBA4+QvRj0qsszTF6eQF4v3mKHi6/Ex0o0gz4ycBK62YHnM2zQGtnhHx44MMtoy+FxJnm5tMwAynlftV7GwV4ZU5uPf663/PqbbGNikJu2zhh4b5g1/00SfPiQfAmqc9VjF/Rkven2vNgG21LGrpuVSK1z6l3SndgbnVJTyYMZ0F/2nEMFctEkNm44RIctPlWgKWbY3GD8VVBrTNKPMeOvkcfhxyjizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+Qow4qRuSHkcAHpAqvc2yW+215D1SRosVDTop+mBdk=;
 b=h2RQdsy1a/3M8R8fSG9IhMHEpb66qBDbCk1XuW1YTXmV0nG15UDiPtBHwMDBRBRNP1IaqeLY6XPeesMzlxKxrM7ZZDSV0pBG1xX/bCYCoHc8GH8+CKaExn0ARovGZuG6PnohDbSm/aOZihOusSIa2ZDHlw2i9ckV+V6HpjGVaEu9Zoh0r9uyX8mPy4mKA7UrgS3d6gR5EKEZxr/JSRyn13zKBJY2Tg4TgFKByX9c0Cr7CNtQoq+0IPnErW2BQ9RnLG5FoQDbDuBrbYSmYDrenmQe+726XlI9zbp8nNyUXy4zTIHsXMUMoO2oiOMxDkQ3vrwDYQUR8jXIHk9sLb1cZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 13:56:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:56:32 +0000
Date: Tue, 2 Sep 2025 10:56:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: kuba@kernel.org, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
	leon@kernel.org, andrew+netdev@lunn.ch, sln@onemain.com,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250902135631.GO186519@nvidia.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250826155226.GB2134666@nvidia.com>
 <d829c4ee-f16c-6cfa-afdc-05f4b981ac02@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d829c4ee-f16c-6cfa-afdc-05f4b981ac02@amd.com>
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a9de13-d6bc-4dfb-b4dd-08ddea2885c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eV3hKjKp/Rg30rjUr8mVloj0MYzsc2v+0BegLw3+ff7Uj9r+pYs5rk9Z+6Ph?=
 =?us-ascii?Q?P/AEEsfNThv3f1/SgYHIp0JLgrZ6TAPrldc9LaVSaG+OBHSuArmQz+s39efK?=
 =?us-ascii?Q?gd4oqfBknTE9zkCny0MlRxwAYGSw+zJR+HtCzFJ2EBpCugOXLU49CX7o6ODj?=
 =?us-ascii?Q?JCEUJMB00+ZqSHRaXt6lJTdpbsebg1dy2AdsUR0aP9ZIGdPb9Q9EpfykY9Oj?=
 =?us-ascii?Q?oiXlxGfSxwPC11RH79zv6btig3ainCi8e4CYlbyPqhmBKDxt02W/tcX6c702?=
 =?us-ascii?Q?sFnlCr8hre+nrLUMlAOpIbeIASko0qzpkuNFIFg/cc9JD8fCKfO6tW3ZqPcL?=
 =?us-ascii?Q?QqdohyqakJ7K4WjE7+LKjlp4pIrN4/LWA3+3ATM2dgsyvvrxo5rgBiibqwbo?=
 =?us-ascii?Q?OkI8lVrdlTDMIZhANives4TF1BEt9BxmvhVFf6N/mSP9yr6DbO9b0DPPbk76?=
 =?us-ascii?Q?w5IgIZ0UnbEkeF6HjDfvwNtEm2kcWw8WbpitPPULKfqXNUqY8z7qPZbYdLx4?=
 =?us-ascii?Q?UK2FnAD5PBOYcqPMPZhh/Pb66QwGXQGx2majWkvZ/xBisWcKBxBzBgALw/Jf?=
 =?us-ascii?Q?BnPGA7m7D7kQn3HsyhFiQRucr7wWZi50b4QUj/y3mP2E6s6HzYTmiI/4lB16?=
 =?us-ascii?Q?xD2p94Rmlx7DKJhZrSdsvA2GP05oXH9DPNJw+zI8e9RxL53lA5ZKtCXm7xj+?=
 =?us-ascii?Q?TG/GWw3nRSixnei7F6nqQNkj/jctfiJyz60l/pdei6AlMOb/Urf6K6OLfx/X?=
 =?us-ascii?Q?2jgcovMz58R/SC2JAlqYfqXWGOtOBwncXydQ2grwgLHBmbxnNKA+7zO0P60I?=
 =?us-ascii?Q?dgeAIUnCuKr69B+bR6qGXpuweG1YKx3P6DX2LiVMvsIltkR3TJs1aCvqeGUw?=
 =?us-ascii?Q?tqCLa6rzajYWhWcRsGWV7+QE9FhER06Qt6L/0eYvtspKhGsNA/EBgVNIMlrn?=
 =?us-ascii?Q?uP0gSMtAQGuUTTtVb8wOtuvZjsT32DcbFm8dfvEeStNX31K/t9vTdgzho1iy?=
 =?us-ascii?Q?euCDgW5NqImrwXP7bGfvAtdiPMkgPzGZvELJrc/PzXxviXvzl/alkzMC69He?=
 =?us-ascii?Q?dnlwj0FRP4gYiJxKhNYMtua7EwnJy5WoLX0mp58kzqwPWkJOzFOan3/6L3ga?=
 =?us-ascii?Q?NJ3mFGsVJm9SCu63dW5GUvKNZW6YsiPAtcHOjxN/Bu3rUKPYJE3SUQnDk+nZ?=
 =?us-ascii?Q?jCUa7VE6v/QbjD1jKEojiVzAjbl4uHL6kQ9sQeuY0zG9dopW4LHbT4gTBl9/?=
 =?us-ascii?Q?UIsT2zGDc/rQiouIan+CurghmF/GTaBwYlLQxKHHd3OuQt/S4K7+BBo02TiP?=
 =?us-ascii?Q?dyz/0ChUDK9SxGAFWXNy2f7qH0QsmAtlspTR7UG9gPsjwYBm2YJQ8WGpHXKT?=
 =?us-ascii?Q?3cPjXIYRcRYHT/V1A4RAI24ZjQBmwj3UP4enNXLJDiOrLsa40w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?peUbMq4RiF06Tr0CiPGxw1qCYAZ4JE4Rip2592JVbXisEQIHVUtsZfYY0O3g?=
 =?us-ascii?Q?Nbi8t1rHXYlFcrzYHAb/+lgqJQdjnz4XSBhfjIcLC7flNvQvJfSGo4LukAUJ?=
 =?us-ascii?Q?WXXZ8BB3T0KNfz0SJHeqN160YptFmDGx05conyakPRAwI8YiiBH+e0S1RtWp?=
 =?us-ascii?Q?0YJLBCWvCGQTzY15gYb/0k8vMdiJgC8Chtu3usWLPahgmdNUfj3r5TsW3S7s?=
 =?us-ascii?Q?TMmi/F9f317qizd6OTNAMLuqXdv4QAr0I1WjrVeVPg8BXuqJLMYSd/k0DKXC?=
 =?us-ascii?Q?wK6sOvTkLQU3z+SO72z9b6BCcMmWjwzYFyUcah0q2NF9GhX0GzMU/qGFX3Qw?=
 =?us-ascii?Q?KXrl7XfOlhlNWyjOCLXQWoeTbnuYw+kTbzc/U4JUZLjvjdGx3OkbVyH0o2gd?=
 =?us-ascii?Q?KeOmY7ioIBkTZIDduU2A4MB8rNCJQsZVZreaXl91w761iUwPiA8bko8ih62F?=
 =?us-ascii?Q?phPKZbQfmanLr82YeAElwKgqM/MFmtDmYBnYtLQ61BiGuafVJtxX3YRaGmiu?=
 =?us-ascii?Q?vKu2zXoYur2FTI3EC+JH9OYbpESDqfAxacam/BtUtNXOgXlqOHG6T2AM0aqk?=
 =?us-ascii?Q?nNwigfR0RVZkQZrLr7wHJ0QBbzhf6BpG0+4XH0rGC5VBVY/vIdGVl8ShtxkZ?=
 =?us-ascii?Q?Xvn+f0wUgItryCPtH++qGb8Kidkm2UDKT/pFGh/cbF5QPyhlX55kQTao+zJQ?=
 =?us-ascii?Q?Q40ICKEOo8kFc+uDJdG1ls2XlKP3RZQYoxr5aykhmsc3e9u/HYPcgIPTPhfd?=
 =?us-ascii?Q?p5v04+9+BIntGqRM5RP+5Ydz4mu6eDP5RV9/tp3+OEgU0/7Bw4vEWW5OgnZ+?=
 =?us-ascii?Q?NwsHxubrozxqtXSntC+GWhVCr3SnG45Ox46shPaw2qknhIxH/H5uN/Y/shJ1?=
 =?us-ascii?Q?5rlQUfSnl/1615HHa+j7PE6S+FeKvofTeb2g+SKlsBmtvGh6AQhDJuAbJYid?=
 =?us-ascii?Q?e1mpDwziwu8gCDtYcuPlF+cFgK0v2WI7j6DK9M4B7f3mRtPjKYkUI/NpPyoP?=
 =?us-ascii?Q?0TcAe6sOjOMlwBPDBB4FjyqmCS4myaXjCSgU8xCOoULvJdOyZTova61xqxzv?=
 =?us-ascii?Q?ONPp/bcW/rJCcm2l0ROiYvmE0PyoDeYH2E+iXqGOvqOQ1KlsIbRUHoDVEXAb?=
 =?us-ascii?Q?25TkUQvcSZ0QzZj4fIUV1npwGCy5ry2+z20M3RbqFxCaBeS3uqFHm4huJ+yR?=
 =?us-ascii?Q?WN5L7dnYXtdca9TF5L+TSTQnb2qy/DgrxRJrH+PozLXsXdzF2YTVLXwNi1Ia?=
 =?us-ascii?Q?T132sY3E5B6GVgt0iRzFiZDC7oobBHM2qM6tGcFu877vwUfmxeAci5MyX79J?=
 =?us-ascii?Q?yrLlpMmtMomskHe59OxzDY+1mDAsKq2l6WLiVLBKMGzLPsZOBTGoBOId7qGO?=
 =?us-ascii?Q?QkZ6c2cC7N6f3jsS1KS0mqLAjQCV34UIiC5TkmuApDfsMjOJZbaEfk3qAcxB?=
 =?us-ascii?Q?TpVYUyKqhc9n/cJ6W3poQYILuXJAKPHBzvnpC/hMfXCALWsZrHLp8IKVYikI?=
 =?us-ascii?Q?jv6jJbNJZ+X2qmm/nZo/vgaltszEMVFtGGYkLWOD74Fm++IHqJ+UMsa1S79A?=
 =?us-ascii?Q?346HZRtvLgV/CGqLcrw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a9de13-d6bc-4dfb-b4dd-08ddea2885c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:56:32.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klOm1aGan93SlRl9aKgxg5c6OASPI3rGOU5yAH8eIcyafXPbq9a0oo+W6fIHZTL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

On Mon, Sep 01, 2025 at 11:57:21AM +0530, Abhijit Gangurde wrote:
> 
> On 8/26/25 21:22, Jason Gunthorpe wrote:
> > On Thu, Aug 14, 2025 at 11:08:46AM +0530, Abhijit Gangurde wrote:
> > > This patchset introduces an RDMA driver for the AMD Pensando adapter.
> > > An AMD Pensando Ethernet device with RDMA capabilities extends its
> > > functionality through an auxiliary device.
> > It looks in pretty good enough shape now, what is your plan for
> > merging this?  Will you do a shared branch or do you just want to have
> > it all go through rdma? Is the netdev side ack'd?
> > 
> > Jason
> 
> I'm happy for the patches to go through the RDMA tree.

You will respin it with the little changes then?

Thanks,
Jason

