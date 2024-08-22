Return-Path: <linux-rdma+bounces-4492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB98295BA8D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2969B1F23AE5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099B1CCEFF;
	Thu, 22 Aug 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTN/kzoT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC71CB147;
	Thu, 22 Aug 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340886; cv=fail; b=IuIQ5X/gkVD97Ipbxx73nsq/DjToQ1CAIgBzZ3QwApL343jOK59EAQmrEJ8RqNIoj/zK28nyGoyNjO/ypYDQdyYv48sHCPV7gi1Y8qqx7qdO7f+8EKINXhaUkF2rG0OFDmqndxcCUhLlGRNVa3Q5hSgapPPePLhsRMZOWk3d2gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340886; c=relaxed/simple;
	bh=mnOrv4abXCJR0YPd8Ge1wCF6LdnFYrjwocEN9pBquL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U67wWNwsEDxSSg3kZF6TpVwnqtB54R5IaHgREAFUTTBGwN5lf3HGi/xBWwFsT5xEgLYcxh82OH+3EynsJerANKsk8Iopa6nYgHoIk9roiK5YgWY4Ikol2PQ7DwqDrNkS3w0lvanuhViQ2ZCE0NSI/jN9osjF69n4rBB1lmGFooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTN/kzoT; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+V2QCAzU2MQyjEm3eHvlpqW+G55v7GgXVUlg0eqG+0MZu3zxTHkgJ4CdFPBEz9qjIdnwFXgeSlfpCj8HiEomosEOqoOesqXkLEdpU6OVMFtkNBzbEwkgVimYqUjZS68a1a8eqirwyW864XuJn+AL11Eb0SeH38uTWn3FoPXrZSPsuJSvaJDfF6NgD1x+6ZfM35F8D/hJPhXurFoltg5zLtViVEACSz8q3zxQAjOLyqJi443NP40gT+mFVH94Kkv3QhusgUWQGbZjPbcu0VL2wHrs5S59QxHxY/BBjNzphIq/rZi5FGM3SDbaQQ2sD+TOJZgF+GBt2bls4sglVBjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcHJBe8kM1pKWn/rLMVDrWvWsHHvhEhx+3oK2rWzII0=;
 b=Ay+m2coUe3ey1dQCkUfLptrfFgznwvUoyaULm1qUApUfx3YGu9qNr/jBNBSLgZhZGC/Ubu5B1FpxnAngqFbcbQvHDKJZrFLdQPtFvqxq7EF1e4efZjK4vtQrs9QpS75LL4Fm+oxl2kVJYnyph+pX4MfUHwCm8qoegkKxiJM/swKNFsu0jn4nk/6wfCMc50r7x8R2tjDhlhaYfBopyDIQWI0ESVqFJMoyy5A+BGBH6gNexhswVIU6fclxoEBJLgQ31nIbIje6r3YWKKM+mwD3qy6QDWNuXZcl4jjrwkKDDweP0r215FThdukzkuyt7LGmuGs8o4fAY6UgnlZYYKZVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcHJBe8kM1pKWn/rLMVDrWvWsHHvhEhx+3oK2rWzII0=;
 b=mTN/kzoTyzU+QSfhy+z8LrsZPYGe0CwBpcKCfpP48sPlwZb1S9m+h4BsAATsyA+IAF8zngsnqk+ZK3Ge6+W8KEmSIYGDPHXVBg4WrL9r2eTqopTg/8O/IY6hZa8AszW/rkPVdIrXshDIZx1/ix0kJaRJJ6HOEr1NVcnC1eJcV73nTRi8jHIxTOSnOqPATSufGM6QGQjSivvIuPx3EQNAyIZw+CkGprxIr8BZNrLUQ6+3Fr3j5RWC1RGD98Z4AoosXudrS4Y/nbnW5QYLdDRyZ3p6K0gpN5Rodz/TKYPVIErEk9idezwz1/BY7QYa0SQrkdzKgDXEdgVBC6bU+RUWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 15:34:41 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 15:34:41 +0000
Date: Thu, 22 Aug 2024 12:34:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 04/10] taint: Add TAINT_FWCTL
Message-ID: <20240822153440.GQ3773488@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <4-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <2024082226-unbent-clarify-564c@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082226-unbent-clarify-564c@gregkh>
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: ae38815b-05aa-4f5b-c716-08dcc2bff09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9/PpPbc7FnDwHXskMAskL0fAXGSax12FbxR6EiEVD/emAZSkpZeTjRvbD9j?=
 =?us-ascii?Q?zYL5XFpSUnsmO4090TGOxUWDbE+FxiHpTXJG1XcdvnBxzSKHNlOGQCeLiDFB?=
 =?us-ascii?Q?B/QwxOhcdsRyePvC3bKSr+vXBnbz71yyGwy/GcEDWK56q3w/WAxrpw9Z6BlA?=
 =?us-ascii?Q?betlUJsytd+ELyvAipvN2Qa5e6higdWY9f8QjNFq/hcYaSFQFpIyGwKnXL/q?=
 =?us-ascii?Q?pLBNb93QG41pyILBtROlhX2i7W5oQTg4R3nHdOE4aR4VjyiTjs9RX5NsbbBp?=
 =?us-ascii?Q?k1WEb8xxA6nBjvDsEW/GizDHAPjgvnOWScEz8J/qSjkIQRmlIqp20Y6abumd?=
 =?us-ascii?Q?fSi7H/4FQqp2nxtMCLmVGakX2h9ksRZkctV+GS2UA9BoYCp732oLHElDOY09?=
 =?us-ascii?Q?M/iuJ22jgUU7zWG/qMbxSRr1MSZ8vV+p0zIktSRPdLhkx60/n7KTXHThLrLS?=
 =?us-ascii?Q?rKzQhhD2iIdM0+q7cjt5/+TFtA6oc72LZLQ5lVYR+Qi8u78k5O+4+6S+oIVg?=
 =?us-ascii?Q?DUSo25DlxLQxUjUzUXmjoleXeVBnZcRFnH42WH1KkilUTbLBpRVzI63w7sL9?=
 =?us-ascii?Q?xcx+fHUMHKFxM8Vj4nsooG6X+nh6s1h94cdTeLWvpTfBGJv987kcIYNb3s4g?=
 =?us-ascii?Q?lGPG7LpDYpPPnXshMG+xJ5rMbKSNl/Sz9SAifZQcUQConFPy5w4Cyy4JtCK/?=
 =?us-ascii?Q?piXZNUbO+ungy+mNlWkLe1dVPNrYOD9Pw8fYIrBxCGgf1yEG3W8PGuEKW+56?=
 =?us-ascii?Q?/SpJ6Hb/7SxP2R9NIDUoU5amuFkIMXclqYuC+HJgjy9S/iwbkJ/B0/WFK1XB?=
 =?us-ascii?Q?gJqoW8WaaTw2QwsEZEDXUDZBARyHI6/dYUH/kw7RyRVS6qQeWRiTOVmM8Y/o?=
 =?us-ascii?Q?3atlgCKFCRqrNmV5j+54xPM44geL1jJoxD8xL4m4AMuijsAa+pTWACG05Hhk?=
 =?us-ascii?Q?Y/mdfebGWjyTuS9HEIgR0pYwxcigcUwBxsicmsb+mo4aD7cgLwSNVDQCxzOq?=
 =?us-ascii?Q?3Phw1H3NmdROnRJX8yWQGIy+/F8hAgnCaZaKS0zzlxmZ6zfPixPkFJCdFy2h?=
 =?us-ascii?Q?CJs0MiCP7+YnBdZ/oDfxOWcuEOoj67fKRg80QCWQs1UuKHqrAuq5NmIJivKm?=
 =?us-ascii?Q?pMMqJc5qEiRWlVop6AEyZBfC/kJ79Fhaoq1jWFgY1vbTOLQwTcFxOjGZQQMi?=
 =?us-ascii?Q?4971x1v7VYRQPAQFQOobedXBmE2t1i7UFkrd3jJabolBJVh/zB6oTGQNUBkM?=
 =?us-ascii?Q?iC6oJGDQWR8JzBwZYYmWgwEilpl/9z+jjIn7r+Rk/dA6VAkKIbb9DLIrK9f4?=
 =?us-ascii?Q?KYeOJUhyy0tnJywKlHFRng765X5lnvFRpJlVo61+n8TCBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sm0zNpo3aDutPbjPAqob4bm7RQA6qzXB5gc2suF4To/MJAVhAutvP3BqPUYb?=
 =?us-ascii?Q?pse1tqEyNGZIjMkG5f1JvWUKi7MvDpVwYW10dC9GJCB5pSd0v7Ko0JIX+tsI?=
 =?us-ascii?Q?Hp1DIYN6r7DnGsOLiDKgKPB7aUv1urOohthmqFx19KEy92Li6MtdSt/RNpiD?=
 =?us-ascii?Q?/lcokHRQreejXROVqdbgHvM1nqQJegoidxrUFx7QomtLO63GjbPbSsE6OgeS?=
 =?us-ascii?Q?lS+tkyIC4Xfg9ogRvXNsWilwLw80jMyQ0FkL+C2XuaOUOMlF3hFLJNl/rZiV?=
 =?us-ascii?Q?Lf5Ztk/859jmF3bC2lVkuSaFTftA175nhCBlY17qOm0dpH7zqNtjuJryBQ7p?=
 =?us-ascii?Q?WHWaW++joKJfxheoxpVmKY3UdoIbCNkvqSsQJ7HUUuBWPajRH5gxBDoS8mEb?=
 =?us-ascii?Q?pUBMTkqUaIYGPKNqlE8d20rWDBoEvoVwe6onhBKXJgt3hmwfUs8b/o/o0jQZ?=
 =?us-ascii?Q?2rdEUf4YRkkhjEDQFSXr+gpDAUVWkfxzUQNqHlHbwcbohmYl/2vaSYB3ZkW4?=
 =?us-ascii?Q?CvUW1VeWJCeybKp7AKJFfJH2paQJk5e2fvSFnS/th8Hqzgc5gu1QyUBHF1tF?=
 =?us-ascii?Q?Yi0SKKDmdJ8keA/CP5jSautA6Z7OP0anVXI1SuNB6GJX6eRobTSSyJUckc4S?=
 =?us-ascii?Q?lYD0uz5+vBqZ0Mb+GSQAGVRP5TclcJ0D/VNsgkGS8zu+1SVF9TisDwmi/QPp?=
 =?us-ascii?Q?Lk67nZeww+G5fSZH8NGrzJ/sKhcBp8Q/fPN93oDfd46pZ77fBinvXepJqPtx?=
 =?us-ascii?Q?BlWpYk55YRB1CZMG3Hdcmdp9xVgm4GRqG9DbAgGUykOrCWpeasA3MOt0c6nq?=
 =?us-ascii?Q?NQNZUswa56VT+b+lyUhtZp5+nieFW9dQ1hobUTBxFrEIvnEooiNut1wPGP7f?=
 =?us-ascii?Q?LNo7+NvhGPQ+viAY3LZzxgPYbl2eu0mhGCHsHp2OEqNhH2KwYP7RpPLzbf/H?=
 =?us-ascii?Q?g/4Ud18iI1rYrPf/4d+rsOXW2juFFR62nbBA2+aRA7gb5tUcVGFFJIPvQQtg?=
 =?us-ascii?Q?sKWqffkXJ9hH9yEHM6nOPg+7qjvTPR17h3jhLXYPDG/3FEiKmtYt8h5+1Vbe?=
 =?us-ascii?Q?2xvvLw+ZIP7fB455Pqc9+mqtl7jKQpNQhACpksBNamdZx6MZl3Egm75VoPmH?=
 =?us-ascii?Q?52kEHJz7q4OzxxXcG+Eew/5DfMtIsILXQJGl15eqtqtW7fYZKdx6Dp9674xT?=
 =?us-ascii?Q?xidjWaMlE+f5tvbmBcwPjKJVJ9iUYB/VjQmKX5QMKX4KG4ayedgQX6RoYEd4?=
 =?us-ascii?Q?COT6Etjy6AvblL+3c2M5v62mAweNi3SrRmYWaf66P4o6kRxjdEoJfeqMuUKo?=
 =?us-ascii?Q?EDBgjUD5CNyGDZwroR7JlkrQ2aTI74sy4/W8Wk8lez0tOZL7UpxrIRujyW5R?=
 =?us-ascii?Q?HVLAnuX686SrEXfP9m3A9kbmGtj+B8CWcE6YxDqf5eMcQAqePW6iUrv2qcR5?=
 =?us-ascii?Q?qJzxwX8lUpAIJVnb2d1T2eN6kI3VvBJriqAiKfN8fhIv9Hmmr6VaF0Q5nsep?=
 =?us-ascii?Q?lEqmAanLokmdowbqou7vlJCwXXBb3riuAch3Pt+WERwxe0JQUsC+f3wVdWjZ?=
 =?us-ascii?Q?JGpMUpVP0azGWgI8qSrmW2YDxaBSSpqc7zTy9kEq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae38815b-05aa-4f5b-c716-08dcc2bff09d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:34:41.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuXyKJxsIYJ0/n3Gws3VOjq95/ybKwLw9dsk64mvrZEw0tW06vyys9LycZrHflRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361

On Thu, Aug 22, 2024 at 07:35:20AM +0800, Greg Kroah-Hartman wrote:
> On Wed, Aug 21, 2024 at 03:10:56PM -0300, Jason Gunthorpe wrote:
> > Requesting a fwctl scope of access that includes mutating device debug
> > data will cause the kernel to be tainted. Changing the device operation
> > through things in the debug scope may cause the device to malfunction in
> > undefined ways. This should be reflected in the TAINT flags to help any
> > debuggers understand that something has been done.
> 
> I know naming is hard, but the word "fwctl" is rough, don't you think?
> It's become much more than just a random driver in the kernel tree, it's
> now a taint flag and is exposed to userspace.  So I think you need to
> rename it to something that is at least pronouncable when talking about
> it (i.e. something with vowels...)

Okay, that makes sense to me. We could also choose a different name
for the taint flag.

Let's see if some people have some ideas, I don't have a ready
alternative..

We've just been calling it "firwmare control" in conversation

Thanks,
Jason

