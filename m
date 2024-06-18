Return-Path: <linux-rdma+bounces-3282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136390D8DD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358ED1C2321C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F8745ED;
	Tue, 18 Jun 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMD82j6J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C24D8B1
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727232; cv=fail; b=kOqx86yOlOQGZZ+kWarOiKNNZVCwt8N5CpfAdSC4CQG6sl+YUMd50sUDjRM5ncWz0dK0QbubaSgy5eoM9WCMNrJMgB270h1hLFTQGjcAsk2ZYpEek2vRguxgG2TCK66VX/M2iu6jX/le6LSxaT0YaNJVqoX0X3G53WRMBUUl9tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727232; c=relaxed/simple;
	bh=1kk+xSbAUigxpciI3J2OJTRv23m8AxPfOeAiEHs28YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZLA639RmTwQLYr7Z3aEeAy22cIdY+MLyRjvlrsyneZtUotQa5591YnIhQ9Liaaj9Zll8bQU0MfaiSgxJe6K8i+gQqos29PTn/WQazPzGQnSxVWYZdVwTilCoTBRfpak3w7Ydjm8/6GbXFxDSYSf+jQeNk9pWUBDDmPiopfaaMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMD82j6J; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJbhOtZPV+ApCrZS8rTW0+1jIwSdebuGVCUIN3EYr0LcjG7NCg8EGCAi9qn9NErzQ2SoD2qUY7vGallaFW7U+CRPbvaghht9h9QBpIF/mAQYd9ILqyTIJzszp7Crox0yP7jINP3fUDc9wpiR1/8LD6o81nGKqEXRvk3LV/SkTZLZLCzarDNmJ/0koXuac9+IogpeRTWBx8X3GSKiLONysUus5Wokg9O/V+Q8wpQuop3TuGguELt8wRl5hP8ax6o4k0/OPHLiWUwfFLW1k2gYvb7yltQLW0BF4O1YyamHw3Q/0NR8xxZOjSr5n8mUSM+mMZon4d5w167XyUZQgWm60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yxPTYfrS7uy51BsrP6vafEn8Bkqhk9hNJHqCs4mrYA=;
 b=nuqiHN+R+WCHYu5K/5CSb8acmwZfOaYlq0AfGsLnQkKZtNmz8ui3/h9kfs9AtK6Iig+td+35oBhthJIN960oiKjcpeAZsrDw+gcph/DZ8rsMtNwz4TltApjKDbu9RDoruG63Dts4Zr0Sz3FFI8IcCYVOr+BlExm/4x0cPONYb7WpSxGT4DyJ4y3HwfJtMZMsM/6uwlYHEuMlq0Tr6RhFl3+DiafTClcsdomBNvCLXV+Vcb/i6Z+Zqgz6pTwq5IemH638/7EXzlWuBsOpumQ+VwQjPZA3DWHpYdzIVO5Zuclw9cog6ETZpOvawxwRYtLljkWes17LoUScEtobTLcnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yxPTYfrS7uy51BsrP6vafEn8Bkqhk9hNJHqCs4mrYA=;
 b=MMD82j6Jq4jUhn+cqtzDjPzbTsjtoau/glcryBIN75leo7GZ/9ciVMBkwa1iLftw1ZsQeS49EfPXvmDFMLCXp5jjejTTFN50kOTn/KHt17QIUxpN5+wGhbF79kxysELOPlKCB+pyIAzNkCsdhHcdGP7OSWPU4nenXfZs0kH7i+lTwDvm9spJgqkZMO+PYyVu6gSRMEJgGyAylHVBXqGZ2zPRBHeXP5aIaS2x9f6xI6tf6hdWwe+YKLWXwfMTG26LL5MJq8dKlv4YhIOdmaL2HaZaQbejl0a8bIDAs73q6/BWACIC3W9EtjlKSoKA7ACoY+T/mifIQOIGAR9HCOCl4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Tue, 18 Jun
 2024 16:13:47 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:13:46 +0000
Date: Tue, 18 Jun 2024 13:13:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240618161345.GD2494510@nvidia.com>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
 <20240617201003.GM19897@nvidia.com>
 <20240618050557.GC4025@unreal>
 <20240618130854.GB2494510@nvidia.com>
 <20240618160559.GH4025@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618160559.GH4025@unreal>
X-ClientProxiedBy: BL0PR02CA0080.namprd02.prod.outlook.com
 (2603:10b6:208:51::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: a8097272-d8f0-4cd7-92c0-08dc8fb1a1c6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6pHWasvMtdZqqfarHhfQ6xlMzyoAcIRlMXTYNuPdrV987xEbu+NcQ4ace4I?=
 =?us-ascii?Q?H1iXuo/m4p6Ss7ITVi4PeRLAQ6K3TWGeQ0V73eSz2GmPGfck96SmcTmktwN3?=
 =?us-ascii?Q?bLOMYj881yHt+4VEdOmRzgZszy6XUWuXVpx9c/EXaSF/Pl6tA3qDYHFwdaKP?=
 =?us-ascii?Q?29zbqxjflrCw5Yvk2a4uvWk7EczCdJGVOIKFeSYaHXsFgcnffh0J+Gcwar0d?=
 =?us-ascii?Q?qBoLSJvVDgbZpp/QHvPXFCaBTNTOYYvafU83zotxi3wjPUT6yUsfkU533R9Y?=
 =?us-ascii?Q?NKXVHWT7Wt/liT6n8HjINXY+MMIGZXuJ0F3Pq6GAS1Xg1x6FhW7o1YZgjrsQ?=
 =?us-ascii?Q?9oT3vazy9ZCWBlgy6jrWbsxJrBqRE2UG8EVGtTd7WqMeLcacUFldTyfv1sw2?=
 =?us-ascii?Q?KWK2DSJ8TjP1g0ti9Eh7W1MtC645zYkYF7e1dHG4c+a5RYgByE04dJD3Yjk/?=
 =?us-ascii?Q?sMATFu8IGA8lvCXAU2lpUowl3JhPKTF8w/NILQPiLhPH69XFxKO0V3kW8wD4?=
 =?us-ascii?Q?rKBs4KOCIG7lAGG6bi8NQFYwu7m+aOt8MU4cc5KuK8N9YKT/aVM1vFK2JGoJ?=
 =?us-ascii?Q?DuGB0dK9mD1LfGeox5f4JCxekcffN/Ls4gYCLGh4csOiWW2Fpq575iqQqOUf?=
 =?us-ascii?Q?2hEnc1KA4D7ANrIvUgL2lhzJTA2qLp0D1z6gPHUkrr1f0+8dtjVEC7lKd7yl?=
 =?us-ascii?Q?HZUL0fLYdMAN25Wdf+8Xyk3IO6N0TYs4vNq1lcaEzQPiGQo6+VojQMYMOz+E?=
 =?us-ascii?Q?/6RSzQf1+cPNahj2vLiOPfDd8kOkUs9A6OdcRs2OpKHapcFNNe3tBabeQ6yB?=
 =?us-ascii?Q?D4APQNqAkRfCupdSTfvoRewwjxZQcD5v5ynMNhoZH0TGuYlczY3VbPUx5lyq?=
 =?us-ascii?Q?D/TWF5IYN0kpbHRqsV910lo2L6yLmPO0YcZVZt2o0P+jOu9DGlLkOugWSC+d?=
 =?us-ascii?Q?zBtyNPmyC85IWP2t+lS0AubvGNYY9zoNi8GDBNCccTnMpnE2dQdXPPY7RA0Z?=
 =?us-ascii?Q?P1GXDauv0AaM54AoGK/E0y0SdOmeqBiB8F1jQRzQaSAuRiwJew017wavTXwR?=
 =?us-ascii?Q?zjUiZbXRCQ2WwyktD7yWG0AZIN9a7BgeHvoAYKbPatjU62gauP0PjCQEsLot?=
 =?us-ascii?Q?KQDY0IZqcIo2+uCbCqZuUv8nP//PQuRioXwLGWK3c4Tr2SrE/P0RCd/G9iBZ?=
 =?us-ascii?Q?044gpqOpy0+rR7wkP2BK8bdiQiODIHDe2cznAT+oFZF0yT/erEwpmMRuBkId?=
 =?us-ascii?Q?RIZEkzeNcnTGOWa6gM/8t5MxtrgHIotspOEiCq5Q3PS3awhFfJOdVLw6mz3+?=
 =?us-ascii?Q?7tBlLStsJKAbAKv09iBAWZIE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Fcna9C6CHkpn7YNGw3bBWb14AGHLxR1jR0VRVfsR+nx6Ra9KRWuhgQGqAVH?=
 =?us-ascii?Q?Bli3ziAJEzzI7giCEZwlzhPGBwfhXS/wiAJCZS9+echTWleWbqFQPxOZbX8z?=
 =?us-ascii?Q?IENjlVojqV3xJvXVyBoHo2AIla3tJERuyet3KjfORDHpxz9xSg1lLiN4bJvl?=
 =?us-ascii?Q?DgEEj9JNzFoLLHKnJ6mSXzwaqukGAjrwLiwTkJnXxa4fskCd+UmVINZnZauR?=
 =?us-ascii?Q?A9uRDrOlMoy3thRbMF3XqKTb8i4nhg7pXqAGGjQKR6B0ICCrMtK7gfIY+0mG?=
 =?us-ascii?Q?8+EF/Ubpqp3LykouHxwSRdQwV1XqNEKQChQ/Atuabj119qIODZFb2pa8wFu9?=
 =?us-ascii?Q?yPSA4UfDt2Rvl0O3PVCWD2/LJ9Ab6lqSUoHeqrBCLaY7793qmuNxcaYa5Uzs?=
 =?us-ascii?Q?bPZMX/VLxj/Oz4zO6ByF1pN2Vo+/H0d5NEc9pHdsae7D0vcBBk4lF2VmRw6w?=
 =?us-ascii?Q?CsII811gJptvAawWVStpRwWeWXWgW1UnHkyD1nrpzaLt0BORvjbE1Bamf/Y0?=
 =?us-ascii?Q?n7I6BhYLLUBRRvFBC6AERKK89radwWr+wCzxNjqLzHpdKPQSQDwxTIZ9VRZC?=
 =?us-ascii?Q?kR5GFkNXjSSa76pdWodDv6riy47pMzLdko3KLg9OaC2WO4JAwgkgJ0JVp0YS?=
 =?us-ascii?Q?OVusRAH/NC6p2DZjQETRH5Py1iWAe2jdmuSjKsxCpYNrARRPUCzRXPvRmloD?=
 =?us-ascii?Q?583zWSmIk9rWZSLs17JrXE30s41l713Kfb0vdSEupRGx+BpaZ3v7W/SRA+bF?=
 =?us-ascii?Q?n+HlSeYRIZvG5imc1R0TriUzSTchsONmxUYRLUOJSnbsIfuYI2/Mg+g6dQ1R?=
 =?us-ascii?Q?+b7V4E5CUwloFCL0bZIhC/hGBClQCA5mNSM2bD6XyVLOFJHZBw90kx5et1xF?=
 =?us-ascii?Q?x3ichTNgL78lMn8r0PCHQDL8tFNZ4BAgo5SfvZP/AB4mFSnv2aY8tlWZbbeK?=
 =?us-ascii?Q?8E1GjauwHP6o9CWrrTc+qPh6AA94+RWfA+dSRRyqsmC/cnVAaXVUUfRNI+DQ?=
 =?us-ascii?Q?pRP1eRFzhY9Xp+Xi5N/f4CcmBxoRGjaqNalMi/kgRo2vv0E7wMqvaOpE8ls+?=
 =?us-ascii?Q?uEy/UpS0nN+gdjZUseZpjS82DsOU3bb3YuLnBMg1LxTV7gD5G87jSd6XZBav?=
 =?us-ascii?Q?wOFLpghpmgG6HwD3+CIGSmWVj+E5HJkYcyoQ9r6PxuygnokB4ZY2rxSYqMFJ?=
 =?us-ascii?Q?lz6qhHdPC74sLUgoMQpMkqnRzZSLPuRSJk3FyBn8VE/U4qjbjMkpJYjZttYO?=
 =?us-ascii?Q?11Kr4nk10qbn/OZ2gJusCaTT6Nwr7zgiPWpJO03Onexloy/rpen9TC1q1OIK?=
 =?us-ascii?Q?iCUxeVbu/293MFU3K6yOy2zeWhDEQdAXfqZDpglSogjrT0oqEIrUuSzLTSKT?=
 =?us-ascii?Q?2h7PFRv6bDz47C8OA+wxGL2IK9AC3K9FLSVqWvc6CkBGwa14XTjdUJwIiLKO?=
 =?us-ascii?Q?v52NNHCTmK2JQamoW3qgAQrr8PN6C8AkT8XM0kB3Y8s/fZ8H0kHbtoRIe0nx?=
 =?us-ascii?Q?6dzH3zEwXXzpu+3xany9QNdtUkvZZBxIhJtIcPlS1ddMcolcTNNuuz+6V9PP?=
 =?us-ascii?Q?7XeC1r5aRaK0rJ4LlYExvdeAMRvuF6xnO3mpDUaL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8097272-d8f0-4cd7-92c0-08dc8fb1a1c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:13:46.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS3Fsk8mFbbCZWABq5p7LrrAEau1UspxyVZH/KOf5AgPekIw0OddtOhvyjO7YRaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077

On Tue, Jun 18, 2024 at 07:05:59PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 18, 2024 at 10:08:54AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2024 at 08:05:57AM +0300, Leon Romanovsky wrote:
> > > On Mon, Jun 17, 2024 at 05:10:03PM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> > > > > On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > > > > > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > > > > > 
> > > > > > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > > > > > >  enum {
> > > > > > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > > > > > >  	UVERBS_ATTR_UHW_OUT,
> > > > > > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > > > > > 
> > > > > > The start of the driver's attributes is not a "UHW", the UHW is only
> > > > > > the old structs.
> > > > > 
> > > > > I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> > > > > to emphasize the namespace and the position of this attribute as
> > > > > relevant for existing UHW calls.
> > > > 
> > > > Well, calling it DRIVER_DATA and UHW is very confusing when it is
> > > > really the start of the indexing for drivers that use UHW.
> > > > 
> > > > A better name is needed
> > > 
> > > UVERBS_ATTR_UHW_PRIVATE ????
> > 
> > I think it need to have the word "start" in it, because it is the
> > start of numbers, not an actual number itself.
> 
> UVERBS_ATTR_UHW_DRIVER_DATA_START ????
> What do you suggest instead?

How about:

diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index dafc7ebe545b8d..e9322f66cd2dec 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -37,9 +37,6 @@
 #define UVERBS_ID_NS_MASK 0xF000
 #define UVERBS_ID_NS_SHIFT 12
 
-#define UVERBS_UDATA_DRIVER_DATA_NS    1
-#define UVERBS_UDATA_DRIVER_DATA_FLAG  (1UL << UVERBS_ID_NS_SHIFT)
-
 enum uverbs_default_objects {
        UVERBS_OBJECT_DEVICE, /* No instances of DEVICE are allowed */
        UVERBS_OBJECT_PD,
@@ -61,8 +58,10 @@ enum uverbs_default_objects {
 };
 
 enum {
-       UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
+       UVERBS_ID_DRIVER_NS = 1U << UVERBS_ID_NS_SHIFT,
+       UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
        UVERBS_ATTR_UHW_OUT,
+       UVERBS_ID_DRIVER_NS_WITH_UHW,
 };
 
 enum uverbs_methods_device {

And recommend replacing the open coded UVERBS_ID_DRIVER_NS all over
the place.

> > It is also not PRIVATE at all, this is just in the device specific
> > space number space, not the core space.
> 
> Private in the sense of driver specific, like net_priv().

It is not a private, it is a namespace, that is the naming that was
used here.

Jason

