Return-Path: <linux-rdma+bounces-2896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D88FD122
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED20288ACC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8427450;
	Wed,  5 Jun 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJ4ozdKd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC821EEE6;
	Wed,  5 Jun 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599045; cv=fail; b=GUO0rVcCW1nJOOfl66ffov7PX6aQ7CLWsqv8A7NZ6fMWMWpfhebEnM9fMsWndGykC4UbozP+OAYCZAZhPP9BrWP1k1BsqJ0nsxucvqUS0oe3PjIkE0zZbmNmDE5BtFjQpoAadXf3qxxxKC/K5CWmL5qwb9zTHrx1/E5hNqbt2AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599045; c=relaxed/simple;
	bh=M5urcPyhz2TMAp1Ki/WWjD9KLoiLg2AiKmNd0AYyJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrpyXCyHwwXBqaP/G/eA8RqLS+NL8Rl4WaGOpGUzcmYm9AINBRv4ml9vgqwE84r1EkVRC6pVx2kOrTvGjrwRnvQeoMzorr6+NQQbjXZtqsNSwoWo0/6bSc/hEP1+g2YTVkUf28ROQLuzmO0WXa/wD+Q9zwq+gFrKL9YSHm/3++U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJ4ozdKd; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX4exyf+USn82XHTJsNQCYT4/KXdBKZCplS+AaP1j44iS5XetX42bByv5PlaUke8cJwEPsZBFFboCVad5jqGTnaDiMtuSB4Ph+z8wH+FN9JiKtulwod+lqbEiewnPPGZ+BiG11g4tRyNSzuWwiv7NCqEoc7vcdjVgdUx/0dfhF9gPO4xebQy2CY4wJHhU9WUZIEjENJN1HE4LyCxUFzf66J0Q2uFkSubEwPw3+Lpqxk3hXnKdocDZbgzwFaw7wg8H+XHrb8CgEzLNy/nbH1P+u6lxmjGS+RKtexyN0fCKFxaZSJ+4sO5VEFgvlvsgMC5ohVKK2W+uPybR6cOybAAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH+9smc84Rvsw0qm7gfKlpVy0EBDgY5hQnAQBI4xlqc=;
 b=W1Rv4IEFa9yHXgNxYwFAwugqqGmXK8vv+6ZgBHlTk9P3Ph2g1ZB55ngtbucqwXibrRbMX1MpDPedtgmirBwQIC8ws6/v+pBPzs1oVwkXCboM+iYcqOjqepblcstdRf4AkcpID0iNtfhfoPLhsxYbEGO+nwN4FDeFKI7FtVsR0Le3NELc78aO+O+HFxr3WsTETjvHK8QQE/z8sbP6shcnnwo9xHwMkdqO2DXyaztjJOZOOMqeMl51aFB/HJ0cCq9R2Q4A+8P0drGA7iwG4BIUGGThoA9H/v+N0fD0NnXLPu+4x0ANb4Nl3LDqXRQQvO6VzxeGkTl7zY9hNjF+QnMBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH+9smc84Rvsw0qm7gfKlpVy0EBDgY5hQnAQBI4xlqc=;
 b=VJ4ozdKdocUeKbPWzTiC4D/wwsGJLoclg3M+btpaDI63Lj2qRqr/ijqPaMlRSXyxL/4ZHBkb9D3+gfFYNZfJUaly6Idmt4n+TEeeoJ3q0vN3h6am+HImzJjnvBsE+9Vsm6ETlNVz33Vsl8b9L93ap8cg2oDZgAeCWaoVp+/Vw1u7QLcyZdWAnlPHUqvfCAXnqiukfhNFqPRV99SpjevEX3x0U4FQeQkBFwcnG985dAIGW6wycz8ejkO8pPxFywFr4v2iUaom3hAc7ECiQkxTWr9/7dVh5xNTEbN0T0Fkn/fe3dDuHWZLr9I9Z7tWlhpXEbxcbU0N8ET6VmYDne5Vsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 14:50:41 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:50:40 +0000
Date: Wed, 5 Jun 2024 11:50:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240605145039.GU19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <Zl-G5SRFztx_77a2@x130>
 <20240604153216.1977bd90@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604153216.1977bd90@kernel.org>
X-ClientProxiedBy: BLAPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:208:32d::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f49f8b1-cb99-4808-6873-08dc856ede8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5VJ88BjbM0oPvz0x6NPXY2NoV7Wyn4vO2szV9LXndMtwebfSseN3DSiEDjX?=
 =?us-ascii?Q?wv/xS7jk+A4O/R4889vOEEBV1Y7CCRpzDLXeXIzsx7PreNhr6cYCRyDE5xyB?=
 =?us-ascii?Q?WJ1yfMiLyekkZ7O0Vkx+KaJsAfUn7M+wlB7B7fWaD7q4q2fWKub+9A1NpQmZ?=
 =?us-ascii?Q?wptl8/b/AOamZ2tbX+PEs8mAX3Ky6rfdroF4IbCUU4PmNSvW3QNc0Eq56u9t?=
 =?us-ascii?Q?oRwe4cFvuooXq4lTBONfzBp0HG10L8HVorntw9l6gNPGcUbN0VxfslV4jKDE?=
 =?us-ascii?Q?i3L7Ov98BGDql85keVPBUpo1RnCbnI0BSI+sRhCycu9K7yvYxhTBk/VTWvq9?=
 =?us-ascii?Q?+lw23Xv+md8w6mRYRV02xdx6RXU4Wnoc+PqfShD79RUoJQCbaOR1zzwMvjT9?=
 =?us-ascii?Q?Qie7j0/Ffyqe4LkvuPd8yXUwZf7mN+alDxo3m0H3gWnpxp/ytLNkgAsQ5bPD?=
 =?us-ascii?Q?R2P3jk0zRiUR1cdJfQovvAdIz2OzbatesrdZHszcms5/0RxXQ6BhzKG2UbbP?=
 =?us-ascii?Q?35EGveT2p1ZJpsdRtYcSdNLtAvzx9goQ0e+4b/ej8TjrdE1N7c6YiwzYRZZE?=
 =?us-ascii?Q?F36rs8cFw8upS0SvXesg8e9VCXunQ7w7oBvMFt04VLQCj89Me1sRmH1HfU6R?=
 =?us-ascii?Q?fV7Doowk+OJz+tU1Ae47vohYnQvhxUXln9Xs92h4d58j6jUcPnwHPrRNZ+R3?=
 =?us-ascii?Q?LqjfYIstA2oKNG4Q8EYUfJf0FrVusbyMhi/hyZzdng0BRI2H5Z1+XfEF9T3G?=
 =?us-ascii?Q?rtxhjbjTMGxq/l2xA6eGiUn/26Uq5o3vJSZEr4EMX73LDkDnfKz7h57OOXhe?=
 =?us-ascii?Q?wSqgIRVMs5gNvrcYtLxBv8X02cY9zWgRgpe185oKOtUozbX5VuoyII1uyVbA?=
 =?us-ascii?Q?DV/nYj0dnbhIKiLSsf4KaG8ONYh7/v2y92nXsmRvicezSAbp3cnQaKU2yeCh?=
 =?us-ascii?Q?yyFK6S/l0Ji4pA8xXOn5H2S4z2EVszdgjOjd1xJS0/KuBY/DrYIA0vJKint2?=
 =?us-ascii?Q?VvDMK8oRh7gpsmoXIhp/DUSm58IaobHA6Mz/1NMq2lXUZwbsysdeWgys06N8?=
 =?us-ascii?Q?b40V3S2xm8Q4PniwNlhiakJNkT/xF+Wb7PEpDoLLRwGd2OCmFHJ0o1aGYlDf?=
 =?us-ascii?Q?IzXecF6dNlQhSr+gcAJLdLsRLKECtwsZWDWAwRk6/ketHcxHaIhzfgikPiLe?=
 =?us-ascii?Q?QlBQBPn30TQY2CZHyDORqxj94C5hunL+9k6Hbz+0rthxT2IXdfnJmq3rAFTF?=
 =?us-ascii?Q?nueFIlVmLP8Ivutr5dRkDNspZEdcu90LFVPumsYq909LKQiGS0uXe1FX3VHj?=
 =?us-ascii?Q?Dv7BBIdnGztk1UwxYFJDiKET?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92NTUwVJfRWLcVlD5ae3bLUXCSfbshxwU+VMVrQIVqVauWF75aICHjK7YjWB?=
 =?us-ascii?Q?ukrsrveKOzzGBgRitDkBFC5nGMPdMl2D0aYZWA7t4ptSjDEH6duQGYAa2qg7?=
 =?us-ascii?Q?nPE5hs07LFtLAS9gCuLnl7jftDNXV/VvQXuhVOZPT0Ja/y0/GTnxhZJn8RyV?=
 =?us-ascii?Q?V4B0GO6ghDteT2fbk9LXDnXFi9ONaHmP8qCS5crvN+WpJ2xrpABk8LJyjSs3?=
 =?us-ascii?Q?sa321wu7wA55toxKsbXtZiSqMUkPczfdQBC+f1eG2f3Mrlvb3W41iOsbvsI/?=
 =?us-ascii?Q?xUUK6vUHFIIWhE5RUkiuwhx5HCAxbABhK1AkZ14iNyW7OIoomI8M5Dq6CrvU?=
 =?us-ascii?Q?K1c7IKre7D/VpwbpAlIzI353g3bS3gFmkvxpfzHSboBImSpPbo1Tqb5Ox5yH?=
 =?us-ascii?Q?sR5lYVNvyvckwNfJS9DBLDbMTEk3qTRbqPPQggDbZkVPne+G9kxw5pmb1z0/?=
 =?us-ascii?Q?sXc6I4Ib1BlGSaGj2nLRVuH+wDnGkQOFkCN/F2FtQUeUJb9ri+mAPCgHXOdj?=
 =?us-ascii?Q?uf3kkIpTNzR7I9nV9JLt/EmfcqRFyQ+tzjS22jEtCavN0Q7MB7ZqTin4FUN7?=
 =?us-ascii?Q?ZYBPDQrvAbSUEvW0OjXSb86LH5es364qOeLbUtuFX8RrXIQaggQjDtWQjbGl?=
 =?us-ascii?Q?g8VAtMXFKD2MzVYpNnTMQ61jOASEgcCKAOO/RfppqQTtOlecGRJz2deFOGPd?=
 =?us-ascii?Q?UGJzBtXgR6CLvpEyiG0pa7F0RbikM8J1OtFP+Sn/UvPdBAxet/u5qRttqGMq?=
 =?us-ascii?Q?kW1MlLdKWdeydvqmAupo08ZltzA0sToVxDZKebj/ECu8cXuwi5BhSEb0rPY3?=
 =?us-ascii?Q?XU8y3m5CpobF2LgtXQHooGTP1F6xvGveIhe8Yx5DRKJvDKAu598LtCvQRbEz?=
 =?us-ascii?Q?NlZwrMzqIpcMF27dXl70DjblHaZXyzcyR/3ujlRgoUuaA7fMLzkMHt58UvHx?=
 =?us-ascii?Q?yefccruoeusze+eMJonfGvXtmrpuk6496asNHzxU6U1p4MVCSYsoCx5fOJMe?=
 =?us-ascii?Q?kmJ74g9GsmUsy1t2Veqpj4oshj70oFRi7ISufaK8s//lQwc41q7QgdFhzewy?=
 =?us-ascii?Q?WDrfxBaNfgPVa+s12v4IWMgSzaAXr1xRKAAsjUaQDP/2g1vzMuuvmh6GCU2n?=
 =?us-ascii?Q?nIJdNjOOPpQI3tZ10NlLNeP0h6DoNm/vBUQHYm6NcVYiG6d++xWbOzuV1Vol?=
 =?us-ascii?Q?TrMaU6ZIEF+/7xvYkt9yZ9eU2srHFC9G/bmkmqqYh5Qm1vI52qj3NuqbARhU?=
 =?us-ascii?Q?0W1sE3mp3gAim+KIjJVBs7EXzyGju1zHGXxUpRfFGDy3OB/5xQJbIuEF6ROT?=
 =?us-ascii?Q?LPKrDqUI1W+hcDbORnHffm5H+UkehjP85VjIE+ax98dgp8cMUBW+waSYyT1g?=
 =?us-ascii?Q?cCdCAxOuIKKDm/XIrTFq2RIc1F99oWDAcLjELcvAH7SYh4BI0TintIOO/GtF?=
 =?us-ascii?Q?WLC0WnbS+8VPRASYR8gRs+WKABcVhueCGVIST2lhauyJlSZZXwJNYSZbQf94?=
 =?us-ascii?Q?9flKMCh7IRN2zPh1ASabHxUK2biUbiJvYVuAyvsInyWEHkDl43sZBLI7Zpy6?=
 =?us-ascii?Q?eRcnUlFD/n+VO9s18ILDOI1GdmnszzR804RB0d5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f49f8b1-cb99-4808-6873-08dc856ede8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:50:40.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fns03nFtdA9goHYoAGDMbIJ0gor8T4heoHzPQVYuOFC41chuHY7izcfpuC9QCh+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

On Tue, Jun 04, 2024 at 03:32:16PM -0700, Jakub Kicinski wrote:
> On Tue, 4 Jun 2024 14:28:05 -0700 Saeed Mahameed wrote:
> > On 04 Jun 07:04, Jakub Kicinski wrote:
> > >On Mon, 3 Jun 2024 21:01:58 -0600 David Ahern wrote:  
> > >> Seriously, Jakub, how is that in any way related to this patch set?  
> > >
> > >Whether they admit it or not, DOCA is a major reason nVidia wants
> > >this to be standalone rather than part of RDMA.
> > 
> > No, DOCA isn't on the agenda for this new interface. But what is the point
> > in arguing?
> 
> I'm not arguing any point, we argued enough. But you failed to disclose
> that DOCA is very likely user of this interface. So whoever you're
> planning to submit it to should know.

This is getting ridiculous. Did you disclose in your PSP cover letter
that all that work and new kernel uAPI is to support Meta's propritary
user space, even to the point that NO open source implementation even
exists yet? Let me check. Nope.

So why this made up double standard for Saeed? Especially after he
already said DOCA isn't on the agenda for mlx5's fwctl?

> > >> You are basically suggesting that if any vendor ever has an out of tree
> > >> option for its hardware every patch it sends should be considered a ruse
> > >> to enable or simplify proprietary options.
> > 
> > It's apparent that you're attributing sinister agendas to patchsets when
> > you fail to offer valid technical opinions regarding the NAK nature. Let's
> > address this outside of this patchset, as this isn't the first occurrence.
> > Consistency in evaluating patches is crucial;
> 
> Exactly :| Netdev people, including multiple prominent developers from
> Mellanox/nVidia have been nacking SDK interfaces in Linux networking
> for 20 years. How are we going to look to all the companies which have
> been doing IPUs for over a decade if we change the rules for nVidia?

That is a bleak way of painting things. fwctl is a developing
consensus on how to solve this class of problems. We get to have a
consensus that is different than the past because Linux dos actually
evolve. All your long suffering IPU comanpies are welcome to use fwctl
with their products going forward just as equally to nvidia/etc.

Amazingly, "rules" are not set in stone in Linux!

> If by "let's address this outside of this patchset" you mean that we
> should have a discussion about maintainer favoritism, and subsystem
> capture by vendors - you have my full support!

This vendor bashing needs to stop. You could have easially used the
word companies and been much more accurate. At this point the
hyperscale companies - your so-called "users" - are much more guilty
of "subsytem capture" than any vendor is, and it certainly has changed
the culture of Linux.

There are many legitimate complaints all around of maintainers being
capricious - it doesn't matter who employees them.

Jason

