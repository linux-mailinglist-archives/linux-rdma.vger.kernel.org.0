Return-Path: <linux-rdma+bounces-13676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7877BA4956
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13CA3B4DCB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295F23C51D;
	Fri, 26 Sep 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmnmqxqL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDB23E229;
	Fri, 26 Sep 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903351; cv=fail; b=exebRAFivFEoKVxFgQwZ2HQaoj5XABwktinzOjajnv6Ld/XEO8o3buOWj2HFFQieFzDakm+wJ2BiJeYuVKgKLBg6+w6cqFAc4HHmfU/gYNFducW6k6zu2DJj7+S6xEImBLWK0i9lCDlqVlScUkdmF1SE3df8/vqx2tMvaiVaaCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903351; c=relaxed/simple;
	bh=Iiog3U8LHeHARz8D5YZFeodkEoaHPw+jNmMW/95douQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDA/h5yqrIttpP4hqnRW75c+a5IaDbD+SC3//JWA+oU+A/76TOkrTwJem/5AAGHFA78rIjgUqiTkSw2H4FdT4jZFN8S4R30ZQYHugxlgpRX6h+b1wLekz+yua50E4JY7KesFnc9aqv5DrCbXNXZ2sgnIvQll8ut7YBjFtvZr+p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmnmqxqL; arc=fail smtp.client-ip=40.93.196.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIMP6lxhgOUPukoNBWROmJSANx0vA5VnFn9t2fE+/FMo1Dmz0dxyTaeiUNSb6JnFkQDeRsBByoPr9m14ukUOOhUg3QsLrBMu667I1NZpNYGBSRnmr6a8S/l572mYi4BfoIgnHtrAgpQ902ZRqI1MlLhlxFMJoYV0+fMTUCAAVass6890TCQzRR8tyO0tv+1r019bnXsKUb7/D7FQmcyakMA6pqPHCGyOkbaRIBd9YrENHDjanmzVdexln77dDk1IldO5M1tb84NKmLSJs5djfbde4gqQ/m/iwbGXLIdQjrR6jHM9pr3hvk6qQdRHjquTXEwFA+e50pMWFxEzgtjdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+vaHEAOnP5QOqyWVhseTlXot4aaXfNtBJF/9VBmyD8=;
 b=dXpNBrh+Iam0f4IS+9qJxQzKvb6ulMRVhTCCiuYtUzlWKQzy4f465bW1YN7+LaMS4bf/rGlvm/cxa7rljmEIlHHC6WReM2rdKOYJ+Pou2bKvy1RVsFcQ1OAEVppc2zlJDHzEIsf7GS5v7I42SjIfoS2EHKIDkKykOxkOOFAesKPIpc1Vov8XxR3Nf50LHr502wJqJpSW7HXEUVKth49glSFB89EBydsfqxLtSSY9BgRcGRebVc/17/67qAHNC1sd2ZHH69GZ0uZN8pi91Tu8CYqW0b3vOfKCtqpkmbn375uhmxfj1hICAc/UdMkL8hoyLEjuT94ChuH7V2pyEDeEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+vaHEAOnP5QOqyWVhseTlXot4aaXfNtBJF/9VBmyD8=;
 b=DmnmqxqL2q3Hhvw7Dn2I0GYWe1NLPia2zDqmbzQh8s3+fAxJO/TWRABOTkSQzc1K5gM31mQU0R4VW6u76hUFd/B020acfau4NCjcuGZTcTUots40dnm8tmaqFHc2fORcF8TigE7b4vUFvgZGSVaO0GghzoGjMWXFuxDdHxynT5oSvhSQ3MbIN9LxbhIKQzCCux5f+fqkCW4jn5uCxT2L4WDJ3Rrr4Z/2NGnJVQQt3m5iDlLZbeCq47WrfOAslzo+BnlL0BRF9kb9z7n6OFsFtkX13aChzeSpTL/yMO9ysSKVKmbho1bE1Um0pNnTqb+LEEvk+WCa0dV5GI2yWW6Buw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 16:15:47 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 16:15:47 +0000
Date: Fri, 26 Sep 2025 13:15:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/ionic: Fix memory leak of admin q_wr
Message-ID: <20250926161545.GB2827732@nvidia.com>
References: <20250924142123.18344-1-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924142123.18344-1-abhijit.gangurde@amd.com>
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 414cedac-87b4-44d4-5d79-08ddfd17f3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvxyUy+c2srQWxA4URX9DCu+MFQTgjjqOUVwC59HpB/JRs1lPahfdNI80VLQ?=
 =?us-ascii?Q?u1yWqlsCeXwxY8Wa0gsjVb+ykqUrbULB+w2rUFjW9V2qxhYjaz4GHrA7qyvh?=
 =?us-ascii?Q?O++xsEufTRxHLZSmakShEOM/p/O4EsODciXSKUW/N14Gu9tdHXINl6ze5/oh?=
 =?us-ascii?Q?zk+AVXxw57MxFyIPRZQ9e6P+jsE0buH6DU+NQclhXJrTkGqHqaZPZyhMFK5A?=
 =?us-ascii?Q?IdsxEWonD/4/G9EZHsudhWSuevnQLF1kGlhPLuvspPeRi8hv6PPrn8rD/IxZ?=
 =?us-ascii?Q?u6ZTYoCZFxGqkKpe9FWGgBBBFFa40WyNIOy9GMnBXYKUVh0mMNjQ1YCKwKIX?=
 =?us-ascii?Q?/dLliKJvlEQrNub8TVcpsfHHyEOLMHJNcIU58++sJab+50TsbJhl0tkQx/7c?=
 =?us-ascii?Q?Cd7DDNgtDjjksZcfUf3PwqvnBkPWSUWdGrSA1aa6COGohdKAzci28yjRm55C?=
 =?us-ascii?Q?vo1XbOVq9nqlpjxQu1uB1D2jBaUDBjYqvbTurzF5XhVh7EQhGMQxcIT0WW4n?=
 =?us-ascii?Q?RN4Tn67h5CQmtBkeCW+uHkJMe3Ka+A2kjnYC2WelleYeb/rd4WYjYaiU3BLD?=
 =?us-ascii?Q?t9GjBmmNJy73NfTQbizpaI2EGs5m69cgKzhrCbvboBrbbTsWmRoyakyv2B+4?=
 =?us-ascii?Q?ufafuBpmL8r9s7X+jO9S1MoJBgo+0S6V8BIzmmLN/xzjKTl+8lK6TZDP8NNy?=
 =?us-ascii?Q?iCNUss7nBcwjJQ8bRogAjHodNNG/3bZoSUtos9euxAKL9pKgOP4m6CHWlWgh?=
 =?us-ascii?Q?47DQJNUXB03L3OfOu+ZDcyXHfUZoFFR/DXlHlDeJC3fy2rziTWXLQLi0mxNe?=
 =?us-ascii?Q?znVEBPVIWQr/vFoYe6YfkPLgHWHCnFoUOgzbix7hWKOrassQu/OOPebRlYji?=
 =?us-ascii?Q?NN2+BEEEHAL9tHGFEIFVG1SRHzAPtsgqHeZptBsSNSB7Wdm4Do81UbyHNO4p?=
 =?us-ascii?Q?BH1rnW5z9mJ9fxxtKIlIkfmn+FlXuHHbCDy9zU9pgw9FP+JbJOdHooqH9g3F?=
 =?us-ascii?Q?+F6vXQeTTok3BxKwqAcuVNVoJP5MubRkv9piSFRfQI0dDO373maJbWx6w/Iq?=
 =?us-ascii?Q?oVfct26T2penyb5IitAXhrLyuBwufFXVknCcnfx1v+6veYluDapxCd/N322p?=
 =?us-ascii?Q?dgAqNB1LaNoykQ50hL6VZdlJgjRZdT2ZgcI2Wxe8eORGw587zRAk8YyKIBWu?=
 =?us-ascii?Q?2tfCSf9/PgFKMDmESDgDfcR8W51PCZ+cBm4X36D+7CEtxg/SIrwY1UPteq9D?=
 =?us-ascii?Q?sxCVLPojUxsafC3t54KBd4ExBmy39SAgXoA6Q4p4KKhi75jn6q6+0sTegW5g?=
 =?us-ascii?Q?C6TkVKt/mLwxrp/zZqaY6fl55Tb/IvRfnm+jp2ovKE3y1rOUNQ07JOYhtKqh?=
 =?us-ascii?Q?dnTnu5OZW+bmY0NDvBqDh/sTuQUkzJVmFyTjqa0pk3ePoUqf6Xzo0OF9MFXH?=
 =?us-ascii?Q?EKDFQM+Ga740IF2ckc1yxaovBwGg4geo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pklA1b7MzOfErVfg7tu1/yJs5+2WOwnF27dT0BQ0bEuix64LdswmrDeYCoy9?=
 =?us-ascii?Q?fro6Ok7SrRipmMaTLDjBvoDqiYixgueAKjEJ7TsswMtS0+/zgCzz1vB0oy/O?=
 =?us-ascii?Q?zueYwq+9a8haB9FZcb5nWKjQRWFd19x2zOqeSbZCFiiDOZanoe2SjnrGsYT8?=
 =?us-ascii?Q?RCNT6tcfj9K2KuZlyNpa/X212bsQhjtY/wu4GV51/Mhbm+5TG9Yv3Fz1xtMW?=
 =?us-ascii?Q?LjfWRzcONtT9ookIcIOm3wHKJQQvA1y8kUFiLlvaojDXrWsZVqaOQDPtDtne?=
 =?us-ascii?Q?yPUFN5LlqhIwn69Ogoo7TOdNGH3RGYldcQBRWYR6J14pk/yWEOjb6RMtjK/N?=
 =?us-ascii?Q?ERqdOhiYQzHDDl96RUTngqyy5R+ki8ppmQUJNQRG96p7ph6SSTOqsZWOLJBX?=
 =?us-ascii?Q?2K3GvN6u9Aoxjsgbp2XothX/Z1R+jNIQsB6a8WvfvTvH/aw4Bp5wDsxVtA6j?=
 =?us-ascii?Q?nImqRd7DtfXWLD59hXZfRpOF6YeSK4Bn0+yDoyhMMYll162tTfVbqpb11zJ2?=
 =?us-ascii?Q?5r890zpdYU8Cmuhly+XA1Mc1Iguh6YVn0/3ae0bpKGvR7VwlTVud4Ej6g39r?=
 =?us-ascii?Q?a8riU5k9rT1aXHp770KzjgkP+jZb+5jEeiEXrNotQ/tpAILdU/m0qCnSMZvB?=
 =?us-ascii?Q?SLcAs3q1aRs8IFsCYocK9BYh7B3J0S5fbxjLYfyEnrd7a3CwwwqZezTYmYg7?=
 =?us-ascii?Q?wd+kdpDIFiXtB4HK3UTBoHRcIuj9/FOAv03DJz2YoFrKYPWcSOugDHOfKA57?=
 =?us-ascii?Q?o5MhUNSGQOvJCINqGCQ5gF1+1pk1ULP+IS3fYD4laR/c+Tr4DICp4yI2K1Hb?=
 =?us-ascii?Q?tA/mz57i4+7soWtgQmXBFZm0uWHTzzPITM47ngQ64rUN5F/22q+bQnXzbNav?=
 =?us-ascii?Q?RyQ1HnaQ7Yrg2N6/qh1Foz64SKpfLggbpV7fCAj0MDd/e153+hY18TbNkuQU?=
 =?us-ascii?Q?6WHDnnTBmDfljyxJLIV9ekR+cyGQxj0vNhv1Vieqe/gSMhbTn9bK6jlUVdp/?=
 =?us-ascii?Q?rNU4Xj96bnKeA7YVNwCT84DE/1Mmyz5C68b9/YINtqC70fyhRmJhQnWKnqTX?=
 =?us-ascii?Q?teiU2ElsLbSUVBTd5d88haWI8vac45sjmScKlAqwI1BQio7ighXkm50ORNZ0?=
 =?us-ascii?Q?avat+hcXR/NXLsabuVnpqYURtSyLkVzzHf/SURwDPAv7dcI34FJzVvILQJSQ?=
 =?us-ascii?Q?UdVOrZhT5SVrD1YJEk/kFFHalOJQDmsXGQAjxDVgHiZwtXXthqiUIfeM5YNs?=
 =?us-ascii?Q?efYoBf2XNdpMtize7QuvGSxNILEGkmm5OWSTsdeA5udtei/RECxXhK1U8b0R?=
 =?us-ascii?Q?OiuOh461v+9Qa2FtWRSx33bvyiqLpqVf0TM/tON8M/F9QpAnFPmVna+tsPD1?=
 =?us-ascii?Q?OeJKr4XSfAzLrKRDi6SP8sjN9sCNrODzI6MLNg3EuDg8C/JFTi0Lg7ZQdpaD?=
 =?us-ascii?Q?DwJMzo+n73CfjBE5364y4NDO8BDZldjKx72rhvex7VnVVtiBwtg3XF35Uro9?=
 =?us-ascii?Q?2chj/TNz27fkZ7MJwW66Xxo6kUXLBuFGlGv6gCqZSTL5R64tq5/wGOidmR7M?=
 =?us-ascii?Q?MzWPpA9bKdVufxSlpro=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414cedac-87b4-44d4-5d79-08ddfd17f3a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:15:47.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhbUaDwT+nq5GVuh7f+u0nMmxrfe7M4zBOVYgHppH1i/FJifQKS+vP3aBOeNVMNt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

On Wed, Sep 24, 2025 at 07:51:23PM +0530, Abhijit Gangurde wrote:
> The admin queue work request buffer, aq->q_wr, is allocated
> via kcalloc in __ionic_create_rdma_adminq. However, it was
> not being freed in the corresponding teardown function
> __ionic_destroy_rdma_adminq. This results in a memory leak.
> Fix this leak by adding the missing kfree(aq->q_wr) in the
> destruction path.
> 
> Fixes: f3bdbd42702c ("RDMA/ionic: Create device queues to support admin operations")
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/infiniband/hw/ionic/ionic_admin.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason

