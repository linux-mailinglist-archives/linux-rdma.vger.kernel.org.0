Return-Path: <linux-rdma+bounces-8890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D7A6BA3A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 13:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F119C4CC0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1062248BE;
	Fri, 21 Mar 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qyju83D9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A71E7C05;
	Fri, 21 Mar 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558479; cv=fail; b=h91txybWfiHBMKpHUAOzdZaFvi4aWrR8ctqz5vlxvWtiR1eM60CTy92C5fWUiO8+UKE2eWRQ3EKUvZMkDeC1wJ38u9bjwGXxgVuotH/BNkDuNxJEk9qpUDaVcMIsOcqmM8G28Fdl9VqnZgU8IAq+WiugM9wYXt3RUKp5kmFKhH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558479; c=relaxed/simple;
	bh=qFXNNNRh/ardbjksf+jvQYK5rtLk81Dm+hJo/We35R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=coRlJpgWWDwBhhZc8jkW/ZQF+h6g9c8756e2BazRe0BhkOWw26uSXQKMpuO7FI1grZv9cjiv5VZX+pKNjcmaFOWg/j9dyRqdv8flbSWZmu6vxs0WutIbB189+GnqCQHmF+X16ggsvGWtAILgVKJOhh0uxEDIR5dLYEmKgq2z8Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qyju83D9; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKCB2c+X/w3ooiNI2FcocQ5lDLc7BpWnTbqifvoAYBtjwBGC0CacLPXCk4ElRlv0F+uRhsGQpmV0sqg7RPsf0lKBZaXFIrTxFBRE9Ravoz4cDtD9CUwqzlBkQjIknhvxH02GTB8SGmlBjUqVT8rFGSAqLOWamQ8clC4XY3aPnubYtBuP5iOqI4CYVgqIl1K6PbiWP/txYRvizsED21d+RarEFp3V/rNrHVBuiL0anpsLm+ME8xZEMF4KbHsR22R2mxfYeEbV1TfjOpPKDQ4FZmpMbTRAv9lXevch+pp7/+jkEJ9+eTu3yqaMRc4t/6yXJ2n+zX9B0s2FcsQ2FWXQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSQq81NDCYvcHcgwOL1AqAlo07+Dy2tOgsD+tb3toQ8=;
 b=ZQbck5JCQA6o9deaRxKO6OKVrGSA6ChSdnu41hx2M2PZxdLp6i6lpF+Z6xtBlSz++EbndhfD8CxNa8HrAYxt0++8tA23kC/Ia2YHxrQcCGb+vvp80IQoAJhoWpU9/IZaiWS1qkpVZYDhOuFfhPFLNIddgbwSSWJtm0Pu/xW695o3XTM3SRp5MXo5xvloyZ3KEVe7riyiMKMXrSv4By/2eq34HYXUwOPjUB1OiV5p4pXnuhdAVDquA67Db8TOJoqdQceYMzzNyYJ8KgQjAtW47VK1cQnzQ5jZW6ypqPPg5uWWOeoqY9jFsPdVnKk9GCxJIaIJBLJdyJOFvYN996Otbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSQq81NDCYvcHcgwOL1AqAlo07+Dy2tOgsD+tb3toQ8=;
 b=Qyju83D9S+Nwyx+DKJJeXwGVhLMhzjU0ga9BLJj5g0O1ClhxyCczgKq8Vif0qcxjk8fCtoKV5+Ns1EFrjT3Dth/vF6B1ZxeH0wZkdL82pkAr5Z+oRtUiflEG8Jr7f81hKoUfaQ+PLQtvFS0BkDFJUz8S+L3kEyIULBiPvEc2yyMnLUEjKP2jGTH+R/d7BTUsVJgCzanRrkhtcN5SxE9LjHfJ0QU8oWq5UWJmHmAYiytrZ+wIecbYpETKVUDbOZOBdc4yHm+hoZ6oYH55qVoS7N1U80EvT7ThlTElqELUMUHupZvO47rKE7xQ0CrwhkdZPtrh1d6Y3FQidTKHhq26ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 12:01:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 12:01:15 +0000
Date: Fri, 21 Mar 2025 09:01:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Sean Hefty <shefty@nvidia.com>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
	"roland@enfabrica.net" <roland@enfabrica.net>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	"davem@redhat.com" <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	huchunzhi <huchunzhi@huawei.com>,
	"jerry.lilijun@huawei.com" <jerry.lilijun@huawei.com>,
	"zhangkun09@huawei.com" <zhangkun09@huawei.com>,
	"wang.chihyung@huawei.com" <wang.chihyung@huawei.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250321120114.GW206770@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
 <20250320143253.GV9311@nvidia.com>
 <DM6PR12MB43132490CF7D1CC16AF6D42CBDD82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250320201200.GL206770@nvidia.com>
 <508c0841-8b39-4891-b373-3ff82b239ee2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508c0841-8b39-4891-b373-3ff82b239ee2@huawei.com>
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 971e5f67-4435-460d-2e96-08dd68701509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8z6U8UjarbjzDmq3JNqKGdIHhzbDI4G3hUCgbXJJH0TrAXiHtTDh8HvQcQ4q?=
 =?us-ascii?Q?urQb/92ssFpEWyz5A7yAs71MeG720KGaChIjo1TDpbf6+qygGCv/bPl8u53f?=
 =?us-ascii?Q?U0DzM3Fol4bBWBOgDj/4E9G6Hj9bKtdmRCKoPbovvA/w5dBX5iOY341MbyOt?=
 =?us-ascii?Q?T801B4Cwat6+ipnpySNc4avHZ450gFS3pROnfP29eXE5mpi0UR0FwqDqVnUn?=
 =?us-ascii?Q?1tQ4tdwr2L+fu6RndOYdqBuyO8DqcrXM01MSndWYdz9fA7x82BlN+F1FpXIE?=
 =?us-ascii?Q?Oj9rlz12MOqO4L5hnqzATq+uHCZmBmb054KcC1+/fs6sbIjVYrlE44AQ8tYD?=
 =?us-ascii?Q?OiAnD7pqynmaxLs3OUWtCfcsPC0uzw/BdcKhjpSMEgx7AQ6KFqwgIz2nTnKg?=
 =?us-ascii?Q?JHIvCrzL80E9WAhF/4H1zc+BN0ZY9i9daGlvR0pa7T9hPpFjV0yKScPK4G+e?=
 =?us-ascii?Q?4SzdQFfK1rBJqHIwN2sPMUe8HDVc8Xfoyg7O/HP/+ehJh/wTAA7EVAuJrpC+?=
 =?us-ascii?Q?OW69hiFjBxJIQtLRu9WqKQGgdGLwqEAabzzvliBXKjcqUZpljO3NykndY/9i?=
 =?us-ascii?Q?WhAAQ3akvn2TDbGTuIEyDwwUHarBgegW2d92Eo+sAd22hi8VlPXG1+3Lkdyk?=
 =?us-ascii?Q?gsCFU9cSc0cCT/Pd/oOrDAEKft0urR71SHoefNWIdyZM+Nk0gzuKdtc/cHf1?=
 =?us-ascii?Q?sGjWYuQdul0ykDV4j0p3NgYN4mS8Dd2CvTpvCjDgAba2CF1RqY2/vWMJn4ag?=
 =?us-ascii?Q?PTnZYnod/Pn53Ki9GGrv5MPwfdoTbeKx0/Qq1UHps4ufvUF3pSRCdo78Jyd1?=
 =?us-ascii?Q?YLUbg84MvrTNgPHJPGkWm/7BKTl8wbjlhU4AmdHWK7g93L2pjcWmqoWGb/If?=
 =?us-ascii?Q?9kb1ykuBxLcLcpe6jPY7/j2oa/0Kux07qLpL+8TkzZ9rnI5xi/6z1m0+wqup?=
 =?us-ascii?Q?1xKrfoGnyggNF0K2wOdNpBcpdKmwp+cA9s7jT6fkQ8cQrWEETXqDqnls9t6Z?=
 =?us-ascii?Q?l8rgGl03I4JhM+ck3pi3Y8+zBGz+xkAvpciLDi4tGFRBqptYxHRwm3uQvt4J?=
 =?us-ascii?Q?gg64amS8qwBNkvTkGwvMRlYdKylPSV1yn+B1yyx3PUEdjw06k6qEXixhF7Mj?=
 =?us-ascii?Q?A4momXcgctQe4a0BUSNf2lB8GkgufBncOfR9MYM3ekW4LqaAxxbOqouCbxSV?=
 =?us-ascii?Q?FPm8as5eBnyJqucWb/zR2C8jmqIx9xoXKquJKlVaAJ8BTUWMbQ5epBAGy06+?=
 =?us-ascii?Q?mCMkzmvrsNXoc8VLB8Ac0+FOKWXGBWAI6a392XKXVrf68U6r9OHPUW/vgY1t?=
 =?us-ascii?Q?apTtF53bpyEdeXc0aHe1tsQPGbVbqOTxt56Sh+O6iSYaQhZ+9dEIjZjzsR7o?=
 =?us-ascii?Q?0jYImBDin2J0eK2ckMSZTNQ9Rw2D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uA6SOAHRhJky9PhGP+UMGjRnUFfD//5GeKrAPLjlxQHFsGQCo7pCjPuM7Yw?=
 =?us-ascii?Q?DD4uG8DWgOtEUq6iz0sCS1jTo29qmAztLOgPbEKPVoxbn04ve2Y0BGOIl3WN?=
 =?us-ascii?Q?wqw6S5Bh5sudErVu8m14tBFsF9itHtcVrEz2ob3FKSTAqyDJlQxrvM3OXjqd?=
 =?us-ascii?Q?nTnfvcTpH3lKK7nU8pTmMTy6bSq+oCgHMca8kEIecZK2e/IfrCRgap4NIHpE?=
 =?us-ascii?Q?IRg9JZkQ9IHGNDxQLqNYdlIeDNvHR/aSw+tmG+xrKKenlwgX4BDU8axVQ4op?=
 =?us-ascii?Q?s1wwr7RRSgv+z/3tSEXPYiOL5uoaRiwXDgwGwyg5WTiSQ3gwlSxJOzPzxOL3?=
 =?us-ascii?Q?z8WJXYyc7F8NQYirPzpTf0GNVkNubzFlXRaiawxiwseKy3UymAYrvE19ssi+?=
 =?us-ascii?Q?UbZRjp0I8Cq6mzf0lb1Vj7iht1q7y7jeJyWcb4sO+/HzElV+vXxPm6IO4G5g?=
 =?us-ascii?Q?xTWDibNqPWo2y1rDUEBw1FmuoOqGCXBplyjNN9Icfzhxehz1q6xIsWw0+zXN?=
 =?us-ascii?Q?QTQ5FL0DnXaaCv2uC4tMZuHTn4JfNowkUzQqgwGjks5Vdci2EMvRz+HrWV7f?=
 =?us-ascii?Q?Du+W3Z+TnV1lxzlA3tS3z8IqLVmsxJ8wpkjpcaE2fb81WglfJ/kb8jKW9F4I?=
 =?us-ascii?Q?Wqb7bfmYDpz6Vu1i43wrPyNU9lXV5wvF0P72uCEmFbermrKNPJr1UmggONHi?=
 =?us-ascii?Q?UA7JGjJ9VA30MUBj0f5HXVx4XBA3JNm947a3F5EUCGC1bWSnOzs32UxrwBRQ?=
 =?us-ascii?Q?8jXtd+Ty2FDVFR54PzQKcGPW4gks7kfEEOQ72Ol4Y4xeKmBhFPxom8wWHuZI?=
 =?us-ascii?Q?4bKsOhqGM5B9/efG7SCQyKzXgoozp/nTxgIpO9cwH07f0piLsf3O3fiEHSIC?=
 =?us-ascii?Q?ThlyzoRbGZiaC6/LEFLpZ7MBaBMh+/JfN9cLGu30V3jNaykOgZEpZQWOfl1J?=
 =?us-ascii?Q?WzWOuQiwOg1L8pgtWaTRGk+P7GFHVI6P/mMliRNQsOx0o0IAsZXPZuWFQAPF?=
 =?us-ascii?Q?W5NA0wLT7VXu58cVnvqaKFNCfATiZgMpUNuwNAoVbcPrJGQr/NJUvzPW8yvU?=
 =?us-ascii?Q?soDBLdMjPcRgHcgNnryQw/qFgT7Erd+xmRmElHokREnMpLwDPek6Z63/Lb6b?=
 =?us-ascii?Q?P/MuQLwJvFhlUc5YLogjOsXUUk2MVtowVKYJHO9tfx1ZPFRyPdd36N5los3H?=
 =?us-ascii?Q?gr0387Oo1Ft/QlPpBtSPt4yOrlD+RixbNMoeb+notvG7Vo5W1mMAjJKj3SKO?=
 =?us-ascii?Q?qkvakJKDNSNbTwR+oV6ut441SX5nBoB74eSaBrG4yD3aFm/oMiRtc0FJEwVG?=
 =?us-ascii?Q?yXLXX4+nO6pJsjz+aG51GgrodibNQDvkJOw6T0/6k6bHMUUu3PbFpkJGflde?=
 =?us-ascii?Q?Z5tC99Cf61ObdmOlbS57WPyqT6lYy/2/QuRbiDjoMzBkB2W0n9lEMUdv6/eR?=
 =?us-ascii?Q?S7sGzWZAdoS5ij0h+Az1O9z8iK/lbjTMiR0cqoIZO8XHgtpKB+FFvAD8eFQt?=
 =?us-ascii?Q?MMaxZbnLKn1roOAf8wx7O6VZQiYami++OKH9w21zrnYbsCTNWesaufZIuFSl?=
 =?us-ascii?Q?aar7NbhwrWppWTCLepD/MjAs6hKas33KoUSbA58J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971e5f67-4435-460d-2e96-08dd68701509
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:01:15.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YOX1idTf8oaIkSNdTu11LmPNmy2nPrAvLrHvz6zVo43cXdb/or3XD9omM3YKu5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

On Fri, Mar 21, 2025 at 10:02:09AM +0800, Yunsheng Lin wrote:

> > That's at a verbs level though, at the kernel uAPI level we already have
> > various ways to do all three..
> > 
> > What you say makes sense to me for verbs.
> 
> I suppose the verbs is corresponding to what is defined in IB spec, and
> verbs is not easily updated without updating the IB spec?

Not any more, verbs refers to libibverbs which is largely constrained
by its stable ABI contract as a shared library :\

Jason

