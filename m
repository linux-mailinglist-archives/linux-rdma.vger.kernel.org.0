Return-Path: <linux-rdma+bounces-2847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F288FB951
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A148B27421
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2234146D6E;
	Tue,  4 Jun 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOOHbd5h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46233F6
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519004; cv=fail; b=aXfvbcyrfMhSOKv0FYLy1p8fpjypPTudBSXHjAwik2ZfGVQIc3gm6fI364KNArqyBTkmS9pt/r2wuLWwWto9c+mOnGYbSirGNUhvpaSTu7PbgFoGm5M7yBRBCczPOW1c2OUGvmvWL+ZW11IwqjLekDAIdpc3kyeSC7Ay30K0ZWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519004; c=relaxed/simple;
	bh=GwUa+21+wuCKV+s3nklNES2SwmzRHFVyD+r2O6VsXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VmXFTWFpKUFNmyPrBhZgsfMvXiC/vV/kJiV9bFPLIv9wfO09hOsI7sb9YXcQBjBcCA8KloFPD3zyMPV1/RjDRMOy/SwRzcpti50fnO0pTzE1PazrZcVuiLBbmKBqRfUTcwzcYpRx8tqiCLxwHdZCFxaBszVrkiHGEFDkgm1ooTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOOHbd5h; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsG9IncKl3znocLA3RI2428X8BzF0ToZ07Ln4n5iKGBEGg8Uag3MFIj/CorY/qrpb0+xi5K16SSEFTA3mj+VsByeubYD4ZAuS60m8Gw+YkmRqUqgfWewHiV/tOd3lGUXD3LVJOO02fEYxv4cMDr3olC1Os0+IgtsMt2bwJ284cjfbeNujlBIwswOQf0avtBgZp8FBHROwSQziW+fkD0kHSXyH3AlJICLR5GIAuUKrfckqEB2x2cOAALsPc0DdbJOdbrvn66sD8fV6+Ok4XY8/I62bqUtUEGxyb4lS+oyo6BC1aybaXXz/DFgy8lDY+EdR5JJ9/d4dw3rgn75Ixbfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwp4V7NafFj5Das1FqUflK8friA2ccvRkv3cnANXIdE=;
 b=Ui9XwLYAjHJD2m5qsIzPnQIy1DJ9s2c3guV5DE8GXlLq8wdDoCVnEWFsO/5wKVaXgd09xEItiylKcEYqWdALW+Jf8QMfVXCopjihi/CAPDFRr8DkMubszxbjgD+6XHFzuH2XqNm2SWtb8GsjN5yhFNYstn1hbWbWC8H0hbz5C6a/aVHLEb7WRfMlLn/7kHOW9wiRpYXuN+rrMrjVe6bKTmyap6tdhosLqqarSGeCpQUByXdGwqnKyPX2YsV/PqkX9b2WwYB4VxcpRFeQy4xv+3XcWJ1GCbKkBnznk+ailKrWxnVqU7Oboh6t3zLKTJwzZaa9/V+sicGuN2WMRewnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwp4V7NafFj5Das1FqUflK8friA2ccvRkv3cnANXIdE=;
 b=OOOHbd5hmTn//VP3gK1KpuJkqcfgIZ8Kwp8zoRgNARBq7OPKrH5gO8rk9wmh3Ul2WfuHqNZgaAzsRm2qt7SqhPiP42lG53CD6ULj5CPDTY/lFm6u4MB24GFqvNyBWXoN4NsoptVKb4kQqLe4J8QIxNk2VOA0lPlWnkL3n8U5RDsKE/EDCrs2PE1S0/NWc8ma/2/jClE/rSbXQTc/a3/DLlzhfZWlTfd785ah21mD/Q20UZETlx9cBa0ehHs5Aq5pVtz9Jv8ngN5qIR9JdSkWoeuUSIexpEpC4l8Sa354GOC88tvR+/sQsqLTZYdvSfbJzjff60AwVU3sQ511dxkONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 16:36:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:36:38 +0000
Date: Tue, 4 Jun 2024 13:36:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak
 is detected
Message-ID: <20240604163636.GK19897@nvidia.com>
References: <cover.1716900410.git.leon@kernel.org>
 <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: a33b5527-ad49-4b3a-f5ec-08dc84b48163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fsGdO4ZTr02zClojFE9E3dm3487TYrlKPNmdBArBgoshdojMCh/7nAfs0Nim?=
 =?us-ascii?Q?bM9tkQgM1n5vVEwJtLn/0srYdwhy63DrUL99VXVPxdaMOknPXsx/rJNHoja1?=
 =?us-ascii?Q?IoURbrC3Uj507ljw3kXUaN0+o20TBLmIpSbiiwTvyQQfl+gWs5Ngg78mmNEJ?=
 =?us-ascii?Q?EfwTT2Mo0IIW9HC68bCkaUYFV3Uumtmxvbw8cjISI0VUmAO5QLDwmllTOOOp?=
 =?us-ascii?Q?bmRYjEOoFKlJVjZQqAl687vwbdMN81w9Z2B9o9PGGFHahjTfBdMScWsV9/DS?=
 =?us-ascii?Q?0M+jD9qDeP6me9i0xWHCIH+VMWy1uU+WsCtn9sd0RjK60bSzgLBgDUOxIKrt?=
 =?us-ascii?Q?bVI4WkdVHmD0+LWjy+2weOYD1/aUiCrwdphkw09CEkXkzg2WpctuylejPUpH?=
 =?us-ascii?Q?lU4ly7nrpM7Fyh7NGyJR3/uDIYs+BlQxzMdOixkMuQEsDUvpEubbVXMU4v99?=
 =?us-ascii?Q?BYPKTtLw2PwwB8DrG8zZbJrgybMGu6WdXpM5gr2BVf9voWFrLVjFSuS94E2/?=
 =?us-ascii?Q?49wZIb8pGScOmXDzVSQlG9tbwX0q1PcXU24cgFjMh+m+JvMYtuQVTe432O2j?=
 =?us-ascii?Q?MH7QCpHwsaQX7ARUzGN71eO6ldDsq2N2RF609jvkU34xy0vqdFgxkysPL/Y4?=
 =?us-ascii?Q?UIRasPJQymPiGTltm8g1+w2U94NSkpM8/Krd/JOjaklO6ICVSg+MRv5Iczz6?=
 =?us-ascii?Q?vL4Al0EpEv9OSLVEj/AT7/o7oYSaio31Snh3rgq1buJEpGBxsEespcUTgE5E?=
 =?us-ascii?Q?3np/iw+ZCSpm9DvqeR+zckbwGOitBEmggwVwUocPuClWKOT6d3LgCBq5SvC+?=
 =?us-ascii?Q?7xg/Z+KyBQ68VFBVm1CYVlvHqpjSXA8fbCR8F/MC1ouEDosxqLa5+WAazV3W?=
 =?us-ascii?Q?0mIsaagPfOteUmumopuwHZfo6m4rBL9DTunHepDEk9wToZUGcy38YZsZXqdY?=
 =?us-ascii?Q?F+sDK6z/O82mzesCYb0yHNhGoxsZ5Hy3zxoCSN+sDu+elvVdtX+/4Fi1OMde?=
 =?us-ascii?Q?dBbEBKoLUyRVhYNllwgXF0tS4GoilZrq4R50AmOCGZKUF7KU+UMRYeHLmd59?=
 =?us-ascii?Q?xgjaJFeKGCIh+7IiuEwrVJuH6PPUyJ9aLihryO3RChrgP+tmbSCMVdHp9koA?=
 =?us-ascii?Q?t9Y5xUAlF7Ug6mUOvsqhkdwqvpEaopT08oW7+ebl1FZ3nkGPkAzjoXg4K0FO?=
 =?us-ascii?Q?sLOiY9AyWAmNagIZYrw7lRhJTW756MsFTc0oTRe+X921JJv3CKTObsI9RjYE?=
 =?us-ascii?Q?RsVAmWN1iZ0En1wuoLXPjN2HwswoVl2cODN4NST6eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffRKpxpCaLnJmLZbamjChzhL9xEgQRxNNOT+9JpsWiWiUHVaHSLX9UYMNRZJ?=
 =?us-ascii?Q?5ReL7xQaG1XExVkyIVwa2enbN1YCWYhaHtsF264UfboPY9XcTpTSNx/CkoZx?=
 =?us-ascii?Q?+E6BlV2vaKAp8QKAGKEQeXH46UHOtiGuN9a5RJtdkALm8T5njrDmlznwul5b?=
 =?us-ascii?Q?MGvLfix8jejX55eTCRwLfi7LeyAd7buyB29LszS2GUZ2CpXKmkFmFIsHSDyZ?=
 =?us-ascii?Q?cwnhplCrDDv7htII8Mx7dHPzn5K8oHspwmAFpysyOfVIHi8nBkEv9xosoMX3?=
 =?us-ascii?Q?jURVEelC4SLNM9r7JZswhwu9T3d9dQ2Gw/RTxrpoKL0+u9ZGqiyEDaiGr6pL?=
 =?us-ascii?Q?INg7cBdY3qrING0eNv0hzIBJy/8oBsL5nip2c09qREH0nsRmC4hQNdYrZ7pV?=
 =?us-ascii?Q?64Px9X4SMsOYfdf+zX8Vn0wtCvcpIVWCzigFJvdoL7Phkst/eNE1k41sanee?=
 =?us-ascii?Q?HnOOlB1OrKtkrbrxRI0Neb8os9Rhy7c2lMdnLWcu9C/uI71BeWFVcfJjHlwj?=
 =?us-ascii?Q?yzM+aoXvi3S53w8a5v8uFcZ9uWmDpoPyKXVmi1IcXQAGmIlpBHc8+z24blwn?=
 =?us-ascii?Q?6h+/KzYSzp6x7aK8o8H3B1zyLViuE4iFVYS3hzxxcO5YeN3ija+WU+JIv0+w?=
 =?us-ascii?Q?iNnTt7EYSKgHOgoi0A1NtiNmpolCCvpUTWL1AYVOAoKMSVziKZn/fJGANaSv?=
 =?us-ascii?Q?KZGoO9skewI4pLn3weOfPKZoVOszvTSYcqlpY9ll3piyk+bhmCFDHurv82sv?=
 =?us-ascii?Q?qq9Nv7p9vEV5dBvf9h+SVZwUoi+50p+NtG6YGSyhZXh4KIWEnycz+TIvJdWw?=
 =?us-ascii?Q?UPxLRfdzJVP4JQxlRHI3UmOst+G1WGIE4XTU4EVNxTVbpARJDy2sXFNUxXbh?=
 =?us-ascii?Q?90ts3eSKqUfQ+h0PX/W3H42g9dZe0zRmvLl6zbF6uJFY5Pokh8nVu1T5v/eN?=
 =?us-ascii?Q?RvK9PUDxhteNqEuQ/LlEHL0ygqI+E/5o5vAlrB7f2cOHtR1TQJXdm45HJUSa?=
 =?us-ascii?Q?2YP6ZYBz/KyT3wfcg9vLhIiqjUEKZWrZCPx4SzVZvqEIXZbxWcphGrImniqm?=
 =?us-ascii?Q?fXa/IIW5TorHwMdxgIl/gkSW3C1QFQ4Os6FLBpYO8rMEtT4xBzsB40w6gqVh?=
 =?us-ascii?Q?6VDMiwVDmOSs87dfkxCP/19Y+X29kOQwLC0UpoSHTdw7WH69tNFyIIIJJnb6?=
 =?us-ascii?Q?iSoIupGcyg2lQrGOD0T8jRxXLiPEAetNEClvc2TKtX+4mMpwKt3xzn87XTmh?=
 =?us-ascii?Q?KZPfG/4Q1f1i7lB2NJTqzWS8sF2cyRCwFvurDFBd/T4EqlIJZwuvT9+2izer?=
 =?us-ascii?Q?JHATcGG+9GaFYlPgzYHspAJSVVgTK3dCHN1AMkLNRxnGmca8OxGY7JfwNzpk?=
 =?us-ascii?Q?UW7uOgOnT9yoJkD50Kzjhq7ASel2qjpIEu99nUMcRjlXacmdlY2Mj1dYg7ew?=
 =?us-ascii?Q?cdKXop8FDaYFm89pGR6UDpoPZZD1YX7ZVdgZvFk7jHbICZHEsv1UhEOaeDfB?=
 =?us-ascii?Q?WCEZIzD7jOfaUndk18JmoxVHTa+Ur+Y4K1S9KbLez+oFJ6GmOfvhbzGilZqd?=
 =?us-ascii?Q?I1AOqonsxfuy5ulfUtw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33b5527-ad49-4b3a-f5ec-08dc84b48163
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:36:38.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgikMDIGHBDsTl+NZuS9jr922swtGHlPhznllxvDIAIPwUAD4tfBQ91GUwKhic1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

On Tue, May 28, 2024 at 03:52:51PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> When the table is released, we nullify pointer to GID table, it means
> that in case GID entry leak is detected, we will leak table too.
> 
> Delete code that prevents table destruction.

This converts a memory leak into a UAF, it doesn't seem like a good direction??

Jason

