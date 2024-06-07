Return-Path: <linux-rdma+bounces-2967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1498FF85F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 02:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031B32871A2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDA1FA4;
	Fri,  7 Jun 2024 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gph9Gtpu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32C363;
	Fri,  7 Jun 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718575; cv=fail; b=T0Ikol7pEVMoY3Iibd54fIhK/56cENeNU5xq353M9IdZeODnFW1U5YAA19pAyHVJnCvzDL7JMaW0sBQlkmsw0mjEa2jq+3ujCcLhqodkw6f/T4tHwk3bw2ROY71tOVo2LLRvgeLA/Hmm39Ac2Q0cDJHoBbdLQkHdqFxuG44hDv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718575; c=relaxed/simple;
	bh=T4wl31n945cT/DsfEu1QLNNKX/HrEthKEaIeD5VUlIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DoUtNAehweY5hc++7VtV+kdigooU6ALQ2CjpbIeRQ1SWpuET66N0wfITtGL3ecRZNEh9SmIsOJKqmPsXJUy8I+rvcGhY5xgU8hryP7BRM05fzeb1aDxAK6FdPjzzPFS3JaANfiVMjuN+7SgvTntvdpvaXQ4HXevB1ojRMvUf4bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gph9Gtpu; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ/7U/1hcW8c+R9A2gGUxMSjaf0NDPc0S5DTdY3es0+T9ovUfTAVkjcwNh5+JWD9v53ocgXl7kIgKSz+11QZq4RGvwEVXK+NUV0ScKpg68R6haNxFJXHibR3Su0jI0R1Xface1M+JKeaCA8igoAyBliG18/57HK1lOaLKYsVjEBuOPyZbAaUHd6/73sllLLaktxxRpodPg8cgPft/UGlKV8m3oUCtoltHe9D6nIrZ7zA+aUQErC82leb8X6VO8rvY4+JtlUwVEK5BewCiHr8fYDQya1aoeRpvbDSXgHFBCmA/XjrpwUJPEuF++TdJBbIKEmDqIsESbVwxPOFgwYJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNYJltVcln7oOkXpYZAAucyVEY2Z0dbD9DlIE+5jYu8=;
 b=dcKG6YoQhBcMYE8u6XT4qs6++hGck2H1d9TgzegeQfhWnl8LpUYkq+h7K0xVJ+wIYI8waFuh3Es5ucl5ENfZVM654+2JIKQlJoK4hqO6AxBMJmcZFJ4I9MN5ACFdxhojzf6A95fmQnJHjR/wLghsVpx0bIHWnqyBIRd9pB1AdpY9azHRFInhxDye47Nn65QkpHnkZZ7CmEDzx3gH8kYudlqy9gYllvxNVJOQThdElM2fIfbT/kvupVsd5V9fOVXfV5B49zCDIXf+pGWv4QCij/aBQd5PIne4YRBm+COFNMT3OhAnBpeENqnmYlh0zIYnZQ5woVog5pZEvYOkTLzRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNYJltVcln7oOkXpYZAAucyVEY2Z0dbD9DlIE+5jYu8=;
 b=gph9GtpugwGl+fGYPHmwPkgVzqJHCJkvlt8yPocnUIrbBU9nHh/5I40GeKi3makhLcaXBfXtmyRFs/p9FjXHQPwvJGYpz5ZKbb3fjxdcsf9zGZEDlctXd8I1SN65vKvbrmnU8iXpKjLuOEEh7RDylxfBBAJCLRS5Nwi0qg0Xh0gZVl4kJI3YO0BR9sx8ohJC6E81dSaiVmR4steMDBezAG921CIuEMKhPAKP+gcRKk0B0UdRRAfcCmIM8fc8iDg80XKTkOpzt3kEd6SLaPtnMoAFMoelt0mJiBnCl8/Q3zQXQOJpQ5/b3GGNEAB/xnDra9JaJ1UFNCJ4fi//sG+40Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 00:02:50 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:02:50 +0000
Date: Thu, 6 Jun 2024 21:02:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607000249.GH19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240606085033.GC13732@unreal>
 <66623409b2653_2177294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66623409b2653_2177294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2aed1b-42fd-4b62-3756-08dc86852be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9M1bKz1ORB2XV1p4oejpRu9q6dUJ0RhvPHGcTsf6ww6rSo+/z1HTjq3iCxJ?=
 =?us-ascii?Q?Rq5J5CsYz9r6bA1TJyQdvoYGYsfcYf+qaEPYj0HOw+fWjXCOwxxmYW1CnOFk?=
 =?us-ascii?Q?KU0fZSvXJ8aNVfjcfmGTGbJSUcKdmR+jrDTTpe8CrkOJU+bLkERsBZtg3sSY?=
 =?us-ascii?Q?LFS0Qg3fhBBGYvaztotVvE3AdqgCYVydaXJmF8CaQ2t/3ZhdMkoeUEUnhXKO?=
 =?us-ascii?Q?cxgpxxKKCCQJx4ut/op0X3hgFVbUhK8wfc6i5O+jAvmh6DDxKxjj5kAAHWHD?=
 =?us-ascii?Q?r1fJKSj3MUora3SO4Vgi7e0rt0gGHjaX0WH2ZB4O9G+y2zmvKglS6x+yPStI?=
 =?us-ascii?Q?suhig2q2dH6lJ43KIAM7+4a4KPP9w5wtDY8wkc+z+XLLHrTdqO22dElMgxq8?=
 =?us-ascii?Q?fTo1n03pRaPOyCL/LejMSsnlv5qcip7lPYXaDcEXMEtS3c9tIra+t+EzGN2S?=
 =?us-ascii?Q?VUW+X2+z91/1IKkkPVudjm3g1oR+HPiOrrroLyF6k3ZUANJaQZ1ArdkYV3a3?=
 =?us-ascii?Q?0PhW3X/2raPnOW4KI+xXmO+lfZq/afdMwP+QMx1vOLx5vCn1Hre7tDYTTjX5?=
 =?us-ascii?Q?CJj6hdkenEhAWujeGUnNlDorvP2Yfs5r9od/a+nDwe4Kkq1VwekhbLVgKrfM?=
 =?us-ascii?Q?vO3gJeFPol/6TSOfI8pM2dxwkUfPsIem+SUlP/RTXhXdCHJOIY4nwrpvxDbH?=
 =?us-ascii?Q?WTKgZjf8DKnLaA5Cftf2wdbijFcpN0ndlNcjMXvPab9txY7qOWJDrD7L3KV9?=
 =?us-ascii?Q?4UMypB8M6wTZZU2HLOyuGfZ0lNktKA6aIBpqkEbWvb3E39/XvVi3dEKUc1JX?=
 =?us-ascii?Q?RHM5MNWm06lNrmROKDBTGnqsB/FD4rquerW9hLxkZ6IHFqEJzFK6m47s9gdg?=
 =?us-ascii?Q?cUqpBy6q66H0f/Ndip5Nz5hxvPcfPhHHjNO2RKaXQtmHmvNdD+ItCjcATia0?=
 =?us-ascii?Q?Np/ydUDiX2ZqEO6roysMqSqR9w48vj01oQzzzhJ31ZZUmNI8dkYzHqKvcdnX?=
 =?us-ascii?Q?QkJdTl5wuRkBgWE+HAy885EhA6eCVXkVUStTv7PQA/JOkCc08ABYmbyJopEn?=
 =?us-ascii?Q?tnD71nW+9S3uvEyrSVmEvnG086dTckNei3J2LIWmI+CCFsagzoAwP1bZvqbR?=
 =?us-ascii?Q?A6C7mD92mHYECz7f7z+eBxv+NOKRMqYPmxlwZcs3AS+XZoIImFYB9ZIsiDoL?=
 =?us-ascii?Q?qD277J6VqgzAHr5WoQyR5avWFiFA2zcrTnZ47IOk1vdgQqxmm/0nPLo9szoh?=
 =?us-ascii?Q?ZxdRkQ2AckqKeq8ieNU28tfqH38RCt0XBQ+RTdQMFO5W5/mzTQ2LuFqVrygM?=
 =?us-ascii?Q?PvozJVmeUDU4bCaHG5MZJwkS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/RD2stdwdANz6a6+iNigEVYoZfKwGHrVtFlxWJokwpgEQ0HOyDuq3Jh3+9NN?=
 =?us-ascii?Q?4p+buSqrJVwySL2hQpGRqQLmpSYiJrALVSVTai9cp5hMJ+/4KVwIUNTwM6KG?=
 =?us-ascii?Q?kb2fACfsZPKF3JkDgeoRLn93kjaWKp69o1InLvu7dseuZ6XU2yjN9TR+xSrM?=
 =?us-ascii?Q?5yMWbeIJMBV2Y9R6lB+4aGzlPuJmfcLfPWq6Zwuk98mVI07wyqXzJu9D5W1L?=
 =?us-ascii?Q?flI1P0DyCKFOXUh+WijMi7T0WJqzB27B8ZXf1hELPd0koVkgMDxMXbcUjRfp?=
 =?us-ascii?Q?1fXDKQLrK8JBrMXufrN3O9EyR1qm0goCPWmxzEEHQYBadjsKDVsZK6+n8rpQ?=
 =?us-ascii?Q?r1NMkOgwLJYN5Y7YpUAMx4h7Uosj8I+2ehi/Neb6pIlIFPpbMvI+myGc4rj/?=
 =?us-ascii?Q?o3ViHKMnPxwvvfUcgVkGvd0jgKrRO9xeTYAH/E5spF29ATPdXBHg6/BcGA22?=
 =?us-ascii?Q?4wiOvYa2ethxVtWta9dhX9njm57vR4qrp+Tsw+/9OAcRBrLHvDMYZ1fAVD3z?=
 =?us-ascii?Q?IVlSE+crD6Lf0nKfPWWi0gnsOeNQXct4Q9/X6enyzQdsN7oo1l1Su9Pr2BMg?=
 =?us-ascii?Q?55uObpA5b5yrS0Au6fyBmoBKwxxYU9LF+gKcvIhOURuDpN3KZ3qNEFtl9gvX?=
 =?us-ascii?Q?ZRajecXu8e6W7IGQw9jhNQOKBFtm5dKp2ZqZPDbcI0sBsTAe89DsthLvAYLv?=
 =?us-ascii?Q?fZJ3klTcXGM/WsXVfaV8vfrOzNu1Ht2g27CbxQUb0gut+GvMLtv4YJdSeo0Q?=
 =?us-ascii?Q?QwrkReAlDwcts8kMIOIdAfPv59hcb12q3ju7BTm9is4uKnebcXLq1/h6Gaj7?=
 =?us-ascii?Q?QA+nKZ2f0Gewyp1U+v4ywWWsFfbmOfQ/j6r9wfwCp/0mpsOsHYJ0mdMwRwli?=
 =?us-ascii?Q?DdiDboBxcHMhFQHPF4ptRoLV+EOWnOLhhHvT3yen2AZjxW53AvGGGknadd1r?=
 =?us-ascii?Q?rqz6dFJDSGgVMg6Jrh8fWKcEbL9LGUEbPs8Fi6qJwFH1a+q4fTTIi3oq8iQd?=
 =?us-ascii?Q?njOs/QVB3/Ss6amEN+vkYDN91L3JUqlyBLb6GsrkV9ysGzpvKSCF2+j6jYqp?=
 =?us-ascii?Q?6xkc2vsTfe+ICw/EAYKdfKy71Pw4wuaYBPz4cgU5YOilDPcE+XIa35At+6Ie?=
 =?us-ascii?Q?K8d2sJ0j+jY3V+g3VW7BObiHdvT7IYUDoBgWl4svvbAS1br71l94QzMSdyX0?=
 =?us-ascii?Q?lmEJdd1xIkacU6OK4LoN9ycVkYqumZAXIlS1C3xcYlPGK5gIdLKYcEjV15aE?=
 =?us-ascii?Q?u3rHhQKw+XpovVvmrwiOu1KpzHaWQ0CQ6i9u0M+eEUsEb/64tqaYsR1qDj7i?=
 =?us-ascii?Q?PffYgq5LUs/UHZXSrITOtdVH8kNAm6BAuZQRS8NFycF0kdYUieGurMTGiqk1?=
 =?us-ascii?Q?zOEXZ6Iyaj+mNGFtWOx10vmsvooeDvgArEmKvS8KAxFssXNGkQDjMv0wY0sf?=
 =?us-ascii?Q?vSYWJHtBnIQwpIMskMoDbqa6gISWUtSQhAb2Ng3OEDX34CCYrER3XSXm7v57?=
 =?us-ascii?Q?ygCNptrPxfbUJ8z7PEdFKtRUL+fTLAJXksPyP+UnWSaa3UUZXf6k68rQR1nz?=
 =?us-ascii?Q?4wWifU/XxBTBxycxG34XEoWAZws6XaNp5g430oll?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2aed1b-42fd-4b62-3756-08dc86852be5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:02:50.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7xwaJD1gU1aCow1KIzyjFtaC8BTgVNA7SpVBMupd6+j4zsKaMnPd8Uz4JTSsaLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172

On Thu, Jun 06, 2024 at 03:11:21PM -0700, Dan Williams wrote:
> Leon Romanovsky wrote:
> > On Wed, Jun 05, 2024 at 09:56:14PM -0700, Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> > 
> > <...>
> > 
> > > So my questions to try to understand the specific sticking points more
> > > are:
> > > 
> > > 1/ Can you think of a Command Effect that the device could enumerate to
> > > address the specific shenanigan's that netdev is worried about? In other
> > > words if every command a device enables has the stated effect of
> > > "Configuration Change after Reset" does that cut out a significant
> > > portion of the concern? 
> > 
> > It will prevent SR-IOV devices (or more accurate their VFs)
> > to be configured through the fwctl, as they are destroyed in HW
> > during reboot.
> 
> Right, but between zero configurability and losing live SR-IOV
> configurabilitiy is there still value? Note, this is just a thought
> experiment on what if any Command Effects Linux can comfortably tolerate
> vs those that start to be more spicy and dip into removing stimulus /
> focus on the commons, or otherwise injuring collaboration.

I like the idea of "takes effect on _function_ reset". VFs and PFs
both often have configuration that can become current once the fuction
is reset. A VF is usually reset by something like VFIO while a PF is
usually reset by a power cycle.

The fact configuration doesn't change until reset is, IMHO, a very
strong barrier from making some backdoor into a subsystem driver.

Jason

