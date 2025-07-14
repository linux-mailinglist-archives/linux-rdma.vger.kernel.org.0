Return-Path: <linux-rdma+bounces-12144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93054B04584
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8435A7A4617
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18030260582;
	Mon, 14 Jul 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OcO9uElq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144125E813
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510786; cv=fail; b=tYYjyHnm5vXUcLBH3aVJLUqiirRe/2qtC+09AvDtiIiCUrYSzGmVN6Vwpsi0lqryMPteMGw8fTtnKGslD7MZOwiRNFxm4DPf+T+b9pcl7mDgPt+qiF2mimAzTmjtnfE3XmH+gTppsBwGFiei/m4TlNLgGTDyFGNvoYNLRIYZPL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510786; c=relaxed/simple;
	bh=5Dzca47wlxVG1WNwXWozXeFBtfahhhFb/K0biQCpSlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFcM16RVyLwVR6CD70KMNfewck0679nJGTIjld48XydRqPsrPXIdLPg22dVbr2faHYVlpVwnmTC7Q6sX+U4PMHQ9Q4qXHLUmN+ekXzZZEX/gZu95ST/MqnpicL06so5trB/j2FJnqKq+/0zwHY4GdQSUp35v23tGysrQEJDQtwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OcO9uElq; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w44/7TC4nlNtqxWo/sRtBOE+K63KDLoCD+UA56x7THeWZxy/1W2OkyO/rnI3GkcZtRu/cu9/YBpGv6RrUvgGyuN6MD2g25F7qEdCqsdi24Vm0X315vjmikI6ep2JM8ahTXdAguv2fF/kqByz8uqJKyCJCFzEVEyo2zrBoBV/+Unz9wKfyJ0trlzuTc7nCX5fM4vUUV8UjJxSG2WZJiLmvrwsKBukd9cRvzVZvvVHkV1HeLa1RCBWvF/6ksyv7moDQvHtj2Ki0dFJ+gt7JiS/MkTJasObq1CihYHb4RG1+6cvUj4oyCqJwW/yGqAYqIePLx3bION8h1vpB8X4Jb7abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/nirHiP8WDzzRgYwXRSsOpocZGcxShy7fO6s3SM9cw=;
 b=vzT/mL4CbnlUc3F5Zpb52OLF+nH0pYcTaDqXcI4qo5ZDeITymF64+nnLbdtXIPWIXaYDjZ29uwoZVW9U6HPZKvFT8Az38L48vWFLfE68eFG0DNmLpS0Sc2zcv3qNfENrbJyZ4zf8AWdJXZ/7Rx14povV5qbyngUGHnhDCOzxINcCIPAUfjFD1svzJvRpTSjmcCbAJBevHCVZMZRru5wXKOsewHKkHx3Y/fbA/X9lwl9xcwJHK26dBphZnjMVXn9Ljhf2otItmJJ7vCzps+cwFA0OK0q6E2qZdiiIYfzyV2nE6Un1H/Wtl8zCBKYfAuxmdGWI5XuNGEe6DJwZ+TWV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/nirHiP8WDzzRgYwXRSsOpocZGcxShy7fO6s3SM9cw=;
 b=OcO9uElq/XWPtJlGiYKqjh1g8UHQwQ835yiGVKRJGxKdQfLxW+uO/GFi7JmjgI1F/8ZzQf0URM+F1UDYZikXtnSCX6DuR4bq5Md3dggqwQYbT5OLGIXETN7BcntIwDBhEvbVaO7uwsMJDCT4YZZeWbtKxxHuzLDKxCRDXbMSM6tR6nKwfI74VR65f0PVe4m3qTJc8ejbxG3SWZURJVaAJ+VVKauKroehTjdRJ+3A0YVBQMJ5YJSsqleSwJv5zuzB/obonBkSf8LuKhpkFxYBdwMGfrauu/x8UgJg9bi8N3mOy8wQgfS4FfouA87ubIDQhRaQ+zmBKcIgWLK+/F93CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 14 Jul
 2025 16:33:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:33:02 +0000
Date: Mon, 14 Jul 2025 13:33:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 4/8] IB/core: Add UVERBS_METHOD_REG_MR on
 the MR object
Message-ID: <20250714163301.GE2067380@nvidia.com>
References: <cover.1752388126.git.leon@kernel.org>
 <10def41b658ca56f28f77472e3460a802ee09053.1752388126.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10def41b658ca56f28f77472e3460a802ee09053.1752388126.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR20CA0038.namprd20.prod.outlook.com
 (2603:10b6:208:235::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ebca83-5bed-4b60-532e-08ddc2f41a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9+bRH/VjUciw7Pgpj1WPdWVr17VsUcISoSYtg8gJmvu/fCvcHyU06muiHhQ?=
 =?us-ascii?Q?85QwzpyHtO7ElrAT4E4s+zVAbtlTZzVtn1kLtxctZMlMxZ7/5U5OjKEJmh8j?=
 =?us-ascii?Q?VpSUfmat4XTs/y+RJtdMSEu3QryejnmfvEmlY8soXVBTI/DnSI668c0E06Cx?=
 =?us-ascii?Q?YdiE8f6C78WR+z1CHa04jJJgjnrMggUIFPnDq70tJtaxvxZqCvU5wXeaMUEK?=
 =?us-ascii?Q?3Q6MrzryKeo9g3yN0ux/9uhPv7cyuxmvF3HP2fb7rIghe7M5pnVveaApIMar?=
 =?us-ascii?Q?Y2ipsKnqYYxXW0Xmjq0dqsuE4ZVvJtuHYfaAvCHcbKx3aR0YFoxwwWb1TLE1?=
 =?us-ascii?Q?izJN18TZPB9yxO7prAwRrG0/hBKpDadIAx27Sk38nxTjGQLAIPOARjNfPtdK?=
 =?us-ascii?Q?/8SxhLEgHVYiRhDl5anQDn5Vo1ra3v/ztG+zkRwxrCbhrTpU1Wv+qGIgrrcV?=
 =?us-ascii?Q?PRLRpMyJ7/eMgQi6xm2S0nuTwmwIYJQtDUlh1eZdfpswNKJuB9gO4yNG0M/6?=
 =?us-ascii?Q?uOTXohQV37KL1Q5pxoHYv+0D0UjYA8ftSEpn2F1RtnqLjsOsN2bqlk46apvd?=
 =?us-ascii?Q?xg8vAP35trDZrb104FPjEAtadCeqLTJSYJ05ppPJzv06wHy0BXYkwkxdCD9S?=
 =?us-ascii?Q?/vVwmoBtvdeabjQBQV6eQtx53ybHZ1Y570bl6VISv0BvTy7Wn9OIJshIG3MD?=
 =?us-ascii?Q?ZdnweCSikWm6bT2udEs6FaC6TV5mctipBSVURnQdsq1MNrUKPhcINXqTPJQm?=
 =?us-ascii?Q?cBef5ejVhbUruJvG889mPAr82+fegyyLsaOHxPBSQbcKm7jvsLAMA7NEjrHo?=
 =?us-ascii?Q?NBSYXkGeN/NIpd5P5nC7bsJRlHGN0dFLyDiy51xiCXvJtZgXV2+hRUtnXWgA?=
 =?us-ascii?Q?kHhx8vQWTcpROnf2cProGjBlmjKzsohEXUklPMs6Qiy63vi6DP78OKbYiJSy?=
 =?us-ascii?Q?/lfwtnQSOVUg8uqqwFWDS1r7yMBVy+ls5F5OeikbUM5FDsntS70iUFvdcovP?=
 =?us-ascii?Q?dq8j65ujyuy4+qUYalVNYoNGsnptUmEpBIiAPpOERab3qeyGfUdcec+Y69fa?=
 =?us-ascii?Q?lgJgfBO740vpqC9hgXQWR2V+14hvFA7knbXeHztIJrSs9MTHpypPvMyvIv19?=
 =?us-ascii?Q?9OLI+9+4MczIgQynlD61Ais9JaBDIwquJLJ6EHBCrM35PKuG6F5CG6f96R4m?=
 =?us-ascii?Q?P+fjYiKoAh9UL4DOCYPba1xFFQYteI8dsh2/1rxZ/rSb0fzZiyuD92YK/pM0?=
 =?us-ascii?Q?P0odiIxLGRpiAyZ4vXTsI5A4ta3STjGvWCz0jqnJ1of6SBaZaq5/U5EHiHhc?=
 =?us-ascii?Q?Wumgj7Xu5zb7cD1JHNziLaahG8wcunygHU2OpKtOGyc3X7saAx0a4jzjoZfq?=
 =?us-ascii?Q?g05PyyxrlLgUT8QgIZ0ocwxiZv8jb1OBwdiZu4DbLieVCtteoQ13ao2BxwEI?=
 =?us-ascii?Q?5SeS4UugCxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0vpvviOKL+g5YBemAHyAf0JtEZiKrNRWFDNPV0GLWRJ2dqRMWCdMB6AqIooT?=
 =?us-ascii?Q?7K8uxuNr8HccTCYGgOTSAwN1Fi5USljsgoSVN4QsLjm0FvsuhEYvkoyGTdyw?=
 =?us-ascii?Q?AmW7/zhNInC9rMEmsCan7sMErKlt74sH7GZ9+MM6/JxQQCKcvlEhcDDWbJKV?=
 =?us-ascii?Q?eeHsbyUhrFeoh6OEq1wigoVLuTKh54lPQlCSBh0VNJcLlVzKvDxBzQacT48D?=
 =?us-ascii?Q?/g5yUSo/5E4Qs4/+BrKyy+tiya5F5BcZ4myYeelLjH9sb8djxi8bpzY7a21l?=
 =?us-ascii?Q?DFjY0xs/Jz145srgsfhr5Ahv6A0ZCd2WKtlXsomqv6aTK/dPa2+NjN1/xm/L?=
 =?us-ascii?Q?0Ya/tJd23jiHcCfnu/t81OhJ/2TiyfSbqA8EA6zXph6QxF1TYMV7Zhr18PFH?=
 =?us-ascii?Q?fRXB/1HIpmUkWaeXhyj5Aeo/n36Mu+OEiKt5zKo/KXP6wNDRVYAONXl76ZTd?=
 =?us-ascii?Q?KBX4t2dSTC3Wh0tTieUlobCiOAefz9upATALvm55kBoQQDNsZDvxa61ifP6J?=
 =?us-ascii?Q?msPY/C2IF166HVEVObB9QlWOep7fHoaqx3+Y3q6lq8EibZJrQ5VRi7ISXUXz?=
 =?us-ascii?Q?PGVh8ZlS+dkzdzaqEd5hA2Tq3VXHKdr5rNyL4hvodXk6R7kk5lvTnttSEZ8a?=
 =?us-ascii?Q?kUTJtAj/IQYyi/6nWXI1S2Zr2QC/lRYzpiYLhsyIRpST9+6cf4WGf/vt+1YP?=
 =?us-ascii?Q?IkrB/wQqxm/DuGShyw3wYOtcPMeWu11QN6xN9H29rF9266ifubPnHosWoUOg?=
 =?us-ascii?Q?dhB7sKc6R3PjGEYUAx5VWINaTXkPSEKGvS0S5Hz50MUe/dwE4EpSzjv7Lk8s?=
 =?us-ascii?Q?XY0K6OuatwghkSivyvIFijMhItVGi8go8W0KEKEc3Fawl5s0SJ5/HJ6tAtUi?=
 =?us-ascii?Q?62cpfCObEob1p4D7fQ02st5DEIkhEr+3E1ftHEEmlKVD45nWTHnivxXyrkdI?=
 =?us-ascii?Q?+nZKY97oYqKFyAcn4xYwN5mIWPuZjfRguuf3Svt/oKLWCJjumSYQqaoy2EmS?=
 =?us-ascii?Q?CICoFWXRCq1nGg2Zpdw/gb00POJrNd1PCp2ncO5BJwFQNBpYBfJPWutvFOGq?=
 =?us-ascii?Q?PhZOCUtdIJSzQfdb1W2xQE/18f1mfGKT4wG4S7HqvwmX+R2K6/yYMADvUx08?=
 =?us-ascii?Q?dme3r7mCFhCMa5V+QTdd797uFckxaOyfeOLP6z/ZrhwPfiD6I8bISZMXWIwy?=
 =?us-ascii?Q?eMC6MOY8pFbQNoZOIOupSz7Rb2/w/Zd95fJ9vtF6pI1akAwLkdNCp22vzXOK?=
 =?us-ascii?Q?jBxDO1nyaTjuCLaYNE1JMznEJ3PUaqnkKbkj+56qNh1xZxflw3f3tMgpfi2H?=
 =?us-ascii?Q?8f8WHfAtT8fLVUNcxU8UxM/tFLoQDEY643nM1BjnTtuznCfX/qT+oZT9ZuDI?=
 =?us-ascii?Q?NyB0GzsAOD5IehPaBmR0zo1dOxudknZY3QfsgCwj79ke2AZVAr+RBvqaEUHT?=
 =?us-ascii?Q?jlMtXGd34SZi766fUivl99lMNlNqa/HvajbYYjwf3LoUcf6kIKxRsPDDmYVn?=
 =?us-ascii?Q?H1VN7/X68zhhd4cluH9hfmyj0HQTB9Zl/tdNR59onnI7VsnU/fv12ngUa4kU?=
 =?us-ascii?Q?rWtVbdQQSIxQm3nI7JISWfUR9QbZN39YTfYSZ6c2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ebca83-5bed-4b60-532e-08ddc2f41a16
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:33:02.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clT8fyK9c/IJxYIB4cyRLiuTrWFqbWPyqxLd+ShoAEHgcZLEb0kMqQtbF9CJWEpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On Sun, Jul 13, 2025 at 09:37:25AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> +DECLARE_UVERBS_NAMED_METHOD(
> +	UVERBS_METHOD_REG_MR,
> +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_HANDLE,
> +			UVERBS_OBJECT_MR,
> +			UVERBS_ACCESS_NEW,
> +			UA_MANDATORY),
> +	UVERBS_ATTR_IDR(UVERBS_ATTR_REG_MR_PD_HANDLE,
> +			UVERBS_OBJECT_PD,
> +			UVERBS_ACCESS_READ,
> +			UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_IOVA,
> +			   UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_REG_MR_LENGTH,
> +			   UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_FLAGS_IN(UVERBS_ATTR_REG_MR_ACCESS_FLAGS,
> +			     enum ib_access_flags,
> +			     UA_MANDATORY),

Another patch is needed to fix this, we should be scrubbing these
issues when doing new api conversions:

include/rdma/ib_verbs.h:enum ib_access_flags {

Needs to be in the uapi headers.

Jason

