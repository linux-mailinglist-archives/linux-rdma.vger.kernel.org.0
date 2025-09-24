Return-Path: <linux-rdma+bounces-13619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E2B9A1C8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D89A3AB91E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6A280018;
	Wed, 24 Sep 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZwHSa7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8942D9EE1
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721948; cv=fail; b=TM/j8CCSU7BouLu8OViChbR9wOwF5Mp+kwYqW048gnsHQxb1A8ejdQPV/wDYVpdRVjnLxuxPoYWYhS4lVoPlMqoIfGsWX/RY+WXm1DHrV4iarQBAChjSpN4r4vIbCLZ9ezuilRflULsulRsdsBkKvM7DYU4vFwHleeubnNwWqFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721948; c=relaxed/simple;
	bh=G+yD0oPg+sbTgraFNCsxnTacHrgGqdXnONjHHZ5COEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kKHWf2lrabxqZvRnUFoy/xYReOYtAQBPUvBZCX7YHpPxiV1K4FFT/5KaR0KIzaT7m1U4QZZek9C4ZzL897xsvAL8a+jFVvQ1CJVb7uhovAeoPu0VY4r75XHsgogSXjIU1m0X4sqrHynfgBnBL9lmIBJBZDMWEnrkmmibYWMSHqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZwHSa7s; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih4n2v6MI4C7csKbK+fp5N1dHsC/kH5VBdl/OZ+l+YP5nTEY/PgVqvL+5qenldLH7+7cAUSdJi7J9VV2XWPA2yDJols8S4Ce5COvdjzQgDxX3ZPsh0N2qezkvb0rKkC7qw7bYM37OyOA4zVNl7Er8q6TIYVKpVYxTYxeAXeRjPESzl24babPbhx0+xwKoKxOpZpes7xtgWA9U/GSGxu0hdFi0PmJXkReol+unEVHH8SDfnJGHY4kO0LSuG4bV23KRsUbJ/xOF/LhhYU89ETIu7PMZLTgmEoU5MbAeUcouWFfmgDd2NfXy7McnN41i2ChcxY4RbYyINMduv2nttUpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8yy4hCaNCGdTIkZ2uEXmH3ZgjNw4y21kKRe2ygT+pE=;
 b=Kn1b8Y/m/7gA63YakNgHjCS7gKRWnts9vfJz5hiVSUWKsYnGuSwKr6wc1Zdj1bDRq6N7sKYiJ9JdSAJAWwLOJPleYztp2aFBItbnIgMAA9RZbOxAHPVgHnOcTKOaFTvbEsESn3gU+J9LR8Rdl6PkoCB/LD4lPum+K4W7G+V0wyqJ7Ty1kC7vhvqfyjQUjcUHJQW/AFS+PMGfU7pGad2D+s+F9v6abTSPhvnpxv11nl5rCq9kdEuXAdBliZ15Y3eqzsiqJl4CjQHtRkn492SpjT8TG0BFceNpYQxZaoBFbwr3OC37sR3CWEb3DZx0JhOAdxIIkrZ4z36Bpw24cfH/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8yy4hCaNCGdTIkZ2uEXmH3ZgjNw4y21kKRe2ygT+pE=;
 b=QZwHSa7sTl2FhoieAYODI1ZXKHAkowwQPdHDQijaNBFDQlcCrqqxKeldduJkeiHLH6qHLHD5mjjEXpS8zJm+s5Ec5H7d6XCToIYfSaO630Km5ldo0+y7jyQB40YgELHVplc2fTGkh1WR/pQ+BXm7tMJMxCq4T1EOebib5/lwLuDR+XydVZvkva9h1JaiDc3T6pt9YT+2NYvsFr6T//KybBTe0eSJlCsgkusxtpwb5f9j+hJyHANSXEWxKydgzbU4Rk2oD82D5nLJvibOGmOsFnY5MFPfx3tJ0kUtZwgoDor3dXqq2ScEpmUnMNEqXHJycxkMFSsNv2sNFbtgvDY7qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:52:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 13:52:23 +0000
Date: Wed, 24 Sep 2025 10:52:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 0/2] RDMA/bnxt_re: Update RDMA hw_counters
 sysfs interface
Message-ID: <20250924135221.GA2673981@nvidia.com>
References: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923062657.981487-1-kalesh-anakkur.purayil@broadcom.com>
X-ClientProxiedBy: DS7PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ad163f-62ad-4a78-5452-08ddfb719694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcpbJB2ZOXVhSWXZo4U1IN/243ohprB/qq6w1Fibubn4eOw2WnUjpU6a5Zq/?=
 =?us-ascii?Q?f+UBIzHwZUvFPsJpvzIvRtCK5or/dZQ6JcHMCD89yr4KoriUQ5bD7uDKfIvo?=
 =?us-ascii?Q?pKX18zVjHOxaCJ3iWvFO0JUP9NrMOjnR2pxjdMH62Lm6DzihgvuV1Sn1bz6V?=
 =?us-ascii?Q?6xYT92wUyze2k2WSo+T+Gd57O40C9Z1Sh7zhY/pEdb43Cdf5YkJjjng/YIKd?=
 =?us-ascii?Q?WCsxKVqTzMi4gBbxHjLMB/zqHJ58cL3s6fgbVwDuX0C6ychJThpCxSRInC2V?=
 =?us-ascii?Q?M7VjdtkHlpZkgHs2IxifgeM6rb/BVDlP+zmY103qNoCoTS/Kga9L+Z0fi9/f?=
 =?us-ascii?Q?p+k7jlnJvbDx3cdPhaBJgG3QqPUbHSwtdP3GOq7LjGQPrCyPWYDfxE/JYE/x?=
 =?us-ascii?Q?wRPP8NKIokz5MwpgCSkoiGw0p920FTF6cUbVrlxqDk5NGsP44iRGHYWBK02s?=
 =?us-ascii?Q?wz1WnVKq5L1/FrkJL02iNJWl6SntPnMAF33La0SYnu1jHHLxS9hehbyw0/G2?=
 =?us-ascii?Q?EZWmQl657PgsBw2beSPvlsVHJ/xA5HHeiC+7rQuqvC7OYizjjHWR5izCScdF?=
 =?us-ascii?Q?gXV1UdBRkr7sZm6HuC5em3Oazu1Tize2QIVFAQtQs+O3pYTOPPrG+wiOh3iR?=
 =?us-ascii?Q?kpWFFC1C4k7cwMK00rv8tzTYA+QApLruudW30yxlRdiDNiYlnYlacQ4d2+Kq?=
 =?us-ascii?Q?vX+j9A7+7gKMOd0UqqnL0QA4xpsSKQ4Uj0LJu/gglu+YIKPjYgNACNhdKOuD?=
 =?us-ascii?Q?4Nf67C0AATs4GZURjhs//OTz6YvueuzBzGFO3mF1LFXip4Irjh3SGOyP2lR5?=
 =?us-ascii?Q?cpbu+LTdTWOpyDdhjbqrQYQLZB6y5cRPLMib4cxxn4rvlug/e+uZ/k39/5AK?=
 =?us-ascii?Q?XcrW4umqKF7naAWHBCf/USS4/SStsfl6OHAu0T7uxA6HaDGCBn9HCA+eCMHl?=
 =?us-ascii?Q?8NG3jgF8u/GQFt0sQg+N8HKZb5YTpaYp674YqptLYP4kcVuRnUOtVPqT56lM?=
 =?us-ascii?Q?ERg66jeNKpcm4UcW+NSnqWt9e/Ui0q2piOSqt0WUNV//VeHmWh7aLhSjw06I?=
 =?us-ascii?Q?Iioo0CzsSXwFFuHwWRIkhKVXRImFcSGIdhyyQDVTry3UvBfrSrlt0JPov1tz?=
 =?us-ascii?Q?io9awRD9Ze45xY5275xKD3ds3XB14WnNvLm/V9WhPrZePbkv+QKfkvpJdSPk?=
 =?us-ascii?Q?0YexY7RScUPB1fPv0TUzeri2ZgBCwGe1E2OYEAA9eARk9HrbnP7/4sNWnOia?=
 =?us-ascii?Q?hy0xnoSKwVjxd4i/3VFq3zeWF9JBunMGnKO05zE1IU5PPn0/XBHzyzbGxntK?=
 =?us-ascii?Q?NKVueAI/u+xLcNdTISF2fhwSDGwHMYVxcMvrmUW1NIgYRPy6XYfJ3klNdKG6?=
 =?us-ascii?Q?LJhOrCC/Hti8uilxz0XjpDhU11PpAvnASwMAPEatUd5PpVPwM1unXFINc20J?=
 =?us-ascii?Q?ltOo+4p/zNg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKbdcBbOOkkjL3mYY3oT+yJiF1Q5zHQfUxsNQcGfzCmFbrKARckTABI/KLEr?=
 =?us-ascii?Q?fJnUk9c1UtTEf+n2OPf+T7lj4YjL446qWrYE3NBfkPcU3zuvolJTLy04V1Ku?=
 =?us-ascii?Q?Kl9fMMOrRLQMdOdnQCDVclQ3mTmM1MoB4gMNNeqTOzyyvF9TsidbFdriAhA/?=
 =?us-ascii?Q?EWiQF8Sdm7qp4d1vA13e2FhgAZBRWEqAY7OUAZQLgzNSPDUYeyrNMm0Dr0o/?=
 =?us-ascii?Q?IxwPsCXNJvkFprYSR2gObh4TR9PSUmKV3kr8i4IJQMp5wdMrRgQHLQJn6g+p?=
 =?us-ascii?Q?qNu0ViDJAxdPY4aAAZFffT3u96PxjKspmAc5J04usH8SQpwKrbVQIxwMghId?=
 =?us-ascii?Q?cfyVJi8YbVdL86DPyEq7uF/rGZooXSCpjUJT2fIYhsz5bFy5pUDJWCY0wAj6?=
 =?us-ascii?Q?Msgg/tMF5PcS077dboJ5IA3zCAGAfSXVykczzPy1vHIfYyOMPinnhjP00hjo?=
 =?us-ascii?Q?NR6y0GeaoiljKhsKxWUmwbuTspmE9tfIUE8SVM8O0/X7AzrbKzTDHdQwYKXU?=
 =?us-ascii?Q?9y4XWPJWNV8PbZc6iPN4xTskgBW6OBq+qIe1IAPIwdZm/kTuQux/+anR9iEo?=
 =?us-ascii?Q?mbFMnsa1sSD/92yWz4QsyYGUOfSpXFoHSUGaiI10c8u/BgjPPmxVzako/mC/?=
 =?us-ascii?Q?r4jAkizZmO+z+S8rZNb4e0stWeVVZEBFmfafMg+pylhAlCozd19M/YpHJh+i?=
 =?us-ascii?Q?9xnU1VItNKKpOIcoLq3A3rfBDwAmKmnAxI/x1r4N1ibt9XaEtlzr0TI8j/pl?=
 =?us-ascii?Q?2xxEXKq6Nrkov247+1yVRCtM6o6uFcibHDOgl74azCmbFjs6PRa9daioVxPA?=
 =?us-ascii?Q?aOkF4QOW8i+0Xq3rTPG+mf0t9dqHOx/8daKa5bbikY0OwOZJwJ+ezwqcq5CA?=
 =?us-ascii?Q?Mpbqs6BmrupOUcVCl2dQUtgkVoPEQtJCztR3CVtOJEwwRFZA3txdRUMcuBic?=
 =?us-ascii?Q?nB1BxtU5QMk2rfZzxUDP52yF8zJIc/powaEqsI2W7OYadDgHCq1Z5h35vkZa?=
 =?us-ascii?Q?N1vVdxX4y+A4CCSe8rYtMXaajRzvBdzi4GGbMtso2R7O7o4SNOfRJan9R23+?=
 =?us-ascii?Q?j/pt6cp3unAmU/xpsF8rwLI1/3Dvi6g+62vq3RsGP+5ebU64enG7T1s37KO6?=
 =?us-ascii?Q?M0jOdHDSaKGJ01yKdjcB4IjcQWV1N+zaTTSDMjN8ZBALcxLYZ6idasQWMDDk?=
 =?us-ascii?Q?nXufm3WZb9WTsJafV5Vup1ElXrDiNMRvSKnJzSA/pcCWbWsZbJb24KIBTtCP?=
 =?us-ascii?Q?GHg3gOPUOufrNEqq+JhEJDmbVF45cXKP3HPSv0/eqXu7+0bYU9SHXp/JwL9L?=
 =?us-ascii?Q?96U4v896+b4kCeuvh4nI+H/oSrbwS1Ryh5tfbMYzO6Bnv0MSYKvFMQfujwM8?=
 =?us-ascii?Q?zvZrE4Zq2n9fkXhZIEHFg2ZLxEcKjQ37IGyGkIDDTPCCHbQJYLzNNlolaAvo?=
 =?us-ascii?Q?5m8G4m60MfOoV7+bTjFrpIA8TupvQtB/75EpkchIKvvV3Vz/WJlsmX4tkGo5?=
 =?us-ascii?Q?gelYFrHccxv7Mj/Wm+ME6Tx7HLT5IM/5N/5mnT0KXfoC3fzXhLTSNnG/kv4i?=
 =?us-ascii?Q?djAOtD7FJdvTaJodeB9a0OPvR1eSGyXCXwvfSj3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad163f-62ad-4a78-5452-08ddfb719694
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:52:23.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAJaDKrvxKJsVEYazm1X+LO5MOz5mlM9eSyNgGhaFxC9dw1U7q0Y/USRxL+26R/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

On Tue, Sep 23, 2025 at 11:56:55AM +0530, Kalesh AP wrote:
> Driver currently exposes many non-hw counters through the RDMA hw_counters
> sysfs interface. This patchset cleans it up by removing the non-statistics
> counters from the RDMA hw_counters.
> 
> This change ensures that the hw_counters sysfs interface contains only the
> true performance and error statistics counters.
> 
> Added a debugfs info entry to expose driver specific counters.
> 
> Anantha Prabhu (2):
>   RDMA/bnxt_re: Add debugfs info entry for device and resource
>     information
>   RDMA/bnxt_re: Remove non-statistics counters from hw_counters

Applied to for-next, thanks

Jason

