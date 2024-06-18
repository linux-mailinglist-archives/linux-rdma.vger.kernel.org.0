Return-Path: <linux-rdma+bounces-3267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324B90D0D1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248FF2879BC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9E146582;
	Tue, 18 Jun 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="opoRuY6V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CA18E759
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715760; cv=fail; b=MbdslgYHlnlEOQ6+LvU8fDmvonRu8tY5BLnjBTeaQ5X/yLRpaohLHCt5ZmRI9DqdcPEyOn1DBUv0bWBc0lmxPeVXxApv8QTre7zqwWQ+Pihz3ZjJqh/cUFI+ptt9tleCxbdIaULMXDNyQiOE0N6LjohczmOSm4BWEJz84gikVrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715760; c=relaxed/simple;
	bh=9OVM4gk7VfsmFYk+n/HKMlTkO4zJKOHMhTGZ3jfyDm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E0gsx2NyfnaM12uDf3WigJn5Jyu2SoeuWVMPSRhSOuAgQK4zvZJ/AwvjdJJYgsefEAhTZM9FnavfM4SQDEplUCBkrYN4FG1aLMyISTpzo56AObURTMo5MW/15DTrG9xcCIC3VeyVVRvxaof1ozuTaUgAHodfkkVr5K1b+ajoFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opoRuY6V; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQoZT2VfVSu8l/mrFjID4sLmxmQKqE/kx/hprAt8uo+uum8VREWrh3HCl3HQOIkVleECum6ZVzwkZE1YPa3p8csyr93NTmVNcc5SO0R1bMpBIUwepMvtl18CU82ngokhTmeauYHtoiUyd+ScWsepgs6xs4R04H7VKQ0NWr8U+YGPdJImog1XNrJSDETXp7dY+euX3PlGFJexMyPl+Gb9/I/w0qunI2+N2pskVy4mQNw2Ayj818lBlioOp14mu384BorlNrKZoKr050gxJ1RpNhWpMKZZjCxfgf+Hg67Rm60EB0vbvQ8JHSPQGzcB1odPDW9Cdd6Aizjsjo/Hjqnj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtqWyuM9sUZTLDDG0gtzMwGQhbTxvuhgis0lKoV3h/E=;
 b=bl1t9nqND5EbSOGBnbrTAJodiVLYBnXvaEfCqs+WviHsC19GXw/nzo2eyfsJXRGlZ3VsypUyCzYi4xNwjvskGyyxhdwlqEicKA0fxGEwj8x3cN5EWK0zLWORz4Haoyvz1scBGvxC5qpthOs/lki6T0SKmgF1XqiycSPw9I47T/CLnJ80sTS8W+lZbpm08Y8jmKC2M3PW1agRmbfwqM4oJY2KRMN2AlKBw3XpzB0IdEH+XFd5mzbsHMj1gNk1FTpmYO6JZfN/U1XUI1Pb/ZvU/hb6upbXge3v71295IrgabWUvxXkcxhsZaF2m3l5yXMoU62EfBg3KWgyanVw/kLFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtqWyuM9sUZTLDDG0gtzMwGQhbTxvuhgis0lKoV3h/E=;
 b=opoRuY6VKO7To+kopgLlaysyrDgjBWS0LNxD6z24XjH3c8sSOmUcF2vYaBqsU+PO5VKvI6N74LuHR/i6Pb7lAUgW/zXiajN2S68BLr/L3nbO2MMDCWyHos/VIhsHaAHmiO9JxEVIlqVJc6V3bAnavPH6U/bDhUp4zqjKfQVbDA9al8fUzXRVwQcm04yz2MhPdHdNlvyauldmBmC0EWE/v1s5t/ewZkDmHZnG9hGjBGQ4nGgPeKdPzQWeAy3LW+azybwSYXZdQNdo0HADE6KnZHUBSao6hBR3OwxP9ToA82nbZoDWGToU09hfKGA/JDUS6EjfJiAX6xZQLDAofMy4bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:02:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:02:34 +0000
Date: Tue, 18 Jun 2024 10:02:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jianxin Xiong <jianxin.xiong@intel.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE
Message-ID: <20240618130233.GA2494510@nvidia.com>
References: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
 <20240617135905.GL19897@nvidia.com>
 <20240618120814.GF4025@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618120814.GF4025@unreal>
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: b40eda4a-fe66-4cb2-8a79-08dc8f96ebc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHuohTzQK3WHMpusZy7Y53EDOU2bZjXrpy/NhTC73hQaPbpinA2Mq6w5nN8+?=
 =?us-ascii?Q?3hEISQXfMfTy2oxmmv9RzzyI1THvCy00N6eAY1IR4zXm4DaRNTkEJPEAKK8D?=
 =?us-ascii?Q?Ld6+uIzaBiaPTO2KvJ+3DVkrSdm0PYEMmN97HEMezV4i6q2AJcYJb+fEszkT?=
 =?us-ascii?Q?+aRAteU0rQjLI7IQiAeYKhI1RZTSuWD+KyIO9skjrViIc3ZJbX48TLFD2Zyf?=
 =?us-ascii?Q?vhsTBc2PzUj+7vtpYpe0ZYL/Cu95yGteYqJxzklPHXGIISL6HzrBJJQzdoaP?=
 =?us-ascii?Q?x4EnDe3ZlEkpRpr85dqBEfO+gVfF6LmOctPDma/34L3q44ufW7MpDXO1Li4/?=
 =?us-ascii?Q?zPPSfCqxD7M2yDbRGV4pXwdKFCT9ddJHD17s2z7moUCzZywu1nOv5EL2nG3N?=
 =?us-ascii?Q?KhNqMTKoI9xn01cEMsI6ArBxsc4XmaAbh/PHtg6eRWDj/e2H6fz3kBcH4KyZ?=
 =?us-ascii?Q?UVXk0gGPWvz2RA1Vb4YDkvM4wsN6Asstkp3URN0Dl7+LhzfykQ4fn5GBLhCX?=
 =?us-ascii?Q?jPJI3Etmo18AQ35YrlN28lYogQm0ZLtqzoNgyOw46/JzkxrLFJEbqZlPZRNN?=
 =?us-ascii?Q?uJneP9gVq1AddHLJBHlflT4hbxQGprBp47SG7jyOmbxm10oD1/IxedChjMTt?=
 =?us-ascii?Q?dAzVR2ebuPMnT8GyvXwpaJrgbBGAd94i1NYa6s/6jbNJQa6X4yQp19qso7K3?=
 =?us-ascii?Q?eQYQ0guyI9CozKn9zbb+o5AvWS1EvdVgKbLqZiqgcW1sc76cjWEAppAnQiEU?=
 =?us-ascii?Q?fbnH7iXJ4VIEm1EMqe96IIls4g/riGEgNtPFBI8N0Ink6Lg3fv7Gb/C5DMnJ?=
 =?us-ascii?Q?WdWzCaZlq4I/7oxOHh3FlJqNBPiEhY6JPtohIdrWNnre25HsutShywhVwvVf?=
 =?us-ascii?Q?vDN37PhHM8fFN8v2YTXf3hc1pJsK+5Gki5RRvZDqGGuSNJscRnGUU0PSej8w?=
 =?us-ascii?Q?5pLZ1rS2qpkdDcld0BF33B8CveeYOm0pOdUxu5D75T/orXoNwGln1SrdJ4H1?=
 =?us-ascii?Q?Cqb0Sld4BewhmtibQct9R0tkwRmjfjRFEw8XsX20xSWobOr3b985iATcPBEr?=
 =?us-ascii?Q?KZlH5IyT8ENI/1ctPz14oE1hF/eIecI36kl2BYMrAbHJ+1IJnAi/UtRzbne3?=
 =?us-ascii?Q?D1O+/MCN1rBPBmbRjbJYCdtZH6fYWtwfcnDVaFpUfmifs9wwS3lm3zInwAsL?=
 =?us-ascii?Q?cUCHsMqcFBV6KvEeSyTGbsp7bAr1pWQ5QG7V8PeR5tavjPdSlifUf8VigaKI?=
 =?us-ascii?Q?unzaTaAWd1NE3tQhoQ7mmigIyJB1tmGZ0xFTrQAiahJ9Fbw91ptG5YSLA/k3?=
 =?us-ascii?Q?ffc7oA3i2U7Cc/SOhsWIZCBZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bTKuwqlNcR/A9Iv1OisTZPi+3gROfC74k8oOavAD5etYB882Db3PxGyjf2o?=
 =?us-ascii?Q?bKVna0+bXU7c83UeOvcFpUF1V+NxHt54K2tZOdvS0H/Bkx0zZGb1sVAe8s6s?=
 =?us-ascii?Q?Ia6Tr2lejpJYcUPVQvoHCJOM5Yt4ZttfbKVZrR8TWFzC0MUISZ0Xk0LY7Bgq?=
 =?us-ascii?Q?Dv8tWizDjEpSddnnDh2TGXVzIybtIe4Bdj5byVLgp+yWQeAcTYqeRIZpm2l1?=
 =?us-ascii?Q?Xo8lCfQfIHVNhGWyPWW+Z8gIYYhKSxIiAsmvIakTV4XXVNfyMzZdKLQJ+ikL?=
 =?us-ascii?Q?at4e4+ogO6DnCIsoaCJT25mJP3KFrYik+8J2pEFMBSVgwZ55KVeQ0w++HqiM?=
 =?us-ascii?Q?1b3h5EpriPrYcus1Fkj4N4jtZBLrxJFE4RbRhLI4muDGQFHaclr3WfnWOKDO?=
 =?us-ascii?Q?434Ycy1XIYwyzKYFc10gcI28JVBGE+8bvk3w8iU+zhGAoxlyDQiCPtN68cjd?=
 =?us-ascii?Q?ZK95RNXqDhMMvuKng8MsqLmioTXCj01z+iR1C6SgGcJL4btSeH/zBKAl3fnw?=
 =?us-ascii?Q?g5vUHyB6sDx3lOkkFR9Xws2VvZApqyhKXL/Jf02he8t3c6rXV9aQpAbs9y8n?=
 =?us-ascii?Q?1rIyU9UgwKwF31IM996HNybrFrhqqnM0BCLwWPlLLWZwrY7TBAy1WbCB+a9y?=
 =?us-ascii?Q?l2Nxwb6j1dk4SPZTmRiSF/mwClxgvUgcLymyrixTHtFDtqb+91Lj1ArAkAJS?=
 =?us-ascii?Q?J4j4SbAYDJ0R8fCbTJtdyBJFtElZq7Ysxc7brGtSBCuHsnQ9Pb+/8S+gQkDy?=
 =?us-ascii?Q?lfjdF9E0s+yRR6iX6dKWqT4CJgulocthZ7W1sURY6EvZu76NER2nNzv/eeE2?=
 =?us-ascii?Q?TUwDWGtxjTxj16IWB9yHcK7LwSyqA1ZVCrjk/JXJw3zGyswoinEXXRDuRJrr?=
 =?us-ascii?Q?sMFtoee0B9C8K7eNwdE2Od3dTj+3P5OfAZMtAVts2wG6B+AtLTkZ+uAxhr6T?=
 =?us-ascii?Q?zCNHY/IYm33rTZS0X4lFq5Xy5lA0igvHXRXXlOnXRHvRUaBwLGO05wg/PtAr?=
 =?us-ascii?Q?2du+UvWR2oZxJ6EKj+hmhuxWS2/3a1OdZbjH3HKJGZb62ji1yIsEI6EWjk9y?=
 =?us-ascii?Q?joTCJ13GPdJ2ihSwvboNSw0sH/TeGbQ/C6AJs9XdNWqXzwXf4LRzFStD3Anl?=
 =?us-ascii?Q?y4+QUB/JBoRffHdCpp4sGgP4u62+uSGvV7JWY2khfGwsJYpd/eiczcEBEq9w?=
 =?us-ascii?Q?rU4p4J4MikrkOX8EXi+51DvTGbmA0xepRnGQaLM0mu+D7Yn6eaU6wmaNy8qP?=
 =?us-ascii?Q?LPWZZ2OlKYbXHID30/zBaHSPTLXmyKSWYv2NfMTTWnDvVVouE28rkLa6hdQk?=
 =?us-ascii?Q?HJDBJn68bJ6MflaQOQ0yyj1hO5tmD+9LnEr1yT7swQ2SbAF8q1XIoyi57Q+2?=
 =?us-ascii?Q?LUVcTc7z+H+xHVUtofkNJPcymqLuikoU/nUfG+bFjiNTrL4KzqXfTzKTF2Vn?=
 =?us-ascii?Q?dwAOqyJvFPCZIHSthFF+gigels6ohohOFo0qUXOGr1p3T00An0pTHiWaFedp?=
 =?us-ascii?Q?gwhqHXsGrlF6wo3NPg7ZmiNP5IN2Pybkm/CuZqpURYzLXkcCzL270tZKGI6+?=
 =?us-ascii?Q?iZTMFEkJUfuGgA1dJl8ZXcHw9or09kaxpj4GJa2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40eda4a-fe66-4cb2-8a79-08dc8f96ebc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:02:34.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnmgjHgwQz25yoESftd3GLOyH66hVYclBnNJ23p1v/s7rIuxj4vi8ingGVF65fA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

On Tue, Jun 18, 2024 at 03:08:14PM +0300, Leon Romanovsky wrote:
> > > Set the mkey for dmabuf at PAGE_SIZE to support any SGL
> > > after a move operation.
> > > 
> > > ib_umem_find_best_pgsz returns 0 on error, so it is
> > > incorrect to check the returned page_size against PAGE_SIZE
> > 
> > This commit message is not clear enough for something that need to be
> > backported:
> 
> This patch is going to be backported without any relation to the commit
> message as it has Fixes line.

People doing backports complain with some regularity about poor commit
messages, especailly now that so many patches get a CVE. We need to do
better.

> > RDMA/mlx5: Support non-page size aligned DMABUF mkeys
> > 
> > The mkey page size for DMABUF is fixed at PAGE_SIZE because we have to
> > support a move operation that could change a large-sized page list
> > into a small page-list and the mkey must be able to represent it.
> > 
> > The test for this is not quite correct, instead of checking the output
> > of mlx5_umem_find_best_pgsz() the call to ib_umem_find_best_pgsz
> > should specify the exact HW/SW restriction - only PAGE_SIZE is
> > accepted.
> > 
> > Then the normal logic for dealing with leading/trailing sub page
> > alignment works correctly and sub page size DMBUF mappings can be
> > supported.
> > 
> > This is particularly painful on 64K kernels.
> 
> Unfortunately, the patch was already merged, so I can't change the
> commit message in for-next branch.

How is it already merged? There was no message from your script - are
you loosing emails??

Jason

