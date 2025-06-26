Return-Path: <linux-rdma+bounces-11651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D8AE959E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5973B2BD2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 06:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E02264AC;
	Thu, 26 Jun 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUMj9UJD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EE5dB0Cr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0B204F73;
	Thu, 26 Jun 2025 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917873; cv=fail; b=S+HH70QKPJa2rWP8lypZUYJgvOeI+uLKlfIj/lOKIT7r8a3tsK7dchBmIFZlTuvYMNOa+3wa00ku7LEXweOZQ7YYY2ZUq0cSUlDRKVCyp/ExkRi8VtF6jJ2UMBJvY81wPMxI1M/IGTdWtnYtcAopzQdRp2Tbg63WLToxlhSeZds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917873; c=relaxed/simple;
	bh=Qtr2O4r4BTtqVfL91bEd0oZiImw7EOfK1w0mlqeCx2M=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=se0Z9ENZyu7UurfoIWhJEdftoQyOfH7+aKgE3Or5OwXVZFfZPtc4ErE37fHzhXZ7inP19Zn9qtbUe5KT3sPE3/upa23qau4jWaG6ltQqTtoBRqtLedoSXmgFkt3NpTgZ6dQpiry2Rr0pIFHTi6VVa1k87uYovdCo+zhN31KfOS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUMj9UJD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EE5dB0Cr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PLBaGh022842;
	Thu, 26 Jun 2025 06:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mwKdhTAi7Q3MjZM7
	RqDSM1owlhXjtyWhrHnIENJh9vc=; b=MUMj9UJDVY0eM6cdAFHeDRLbuQiJ4ENo
	gBzfYStCgvAM4cYlNIyEr6p4x3T5ccmuLKWpPu0M0Cbc7GT18siuCaV4UZDwyqUs
	6UvIO43rDFuhpz8kPkE+eZPlV/+52sT692AUZFDZygSm3JlvbFVcDzolfoj61XL+
	Y34N8l4NjSiNZVKloGcE79B01+wAY8DJK8V8wpusPKkb0Tr0jB46E8SNunI8jPGn
	D4o5QPAebjpvdq03b1WeujoYGPuorZztcElRtNQ390ASgTYhyAqF9EoqCTmFBwZq
	cKK1PPnsw9lOqXXdQHC+FphZJKmsj7HoNDLGT6PzUQFt3ZBzhW88Ig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5qyp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 06:04:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q5VSxT013424;
	Thu, 26 Jun 2025 06:04:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvyj2vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 06:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9DAZsdAivX+cfQhzAmg/CsacdwABN6rgmYbB/kgjKOZbMEbIdJtF9aeORQhqWRC+1U93jG35wrZp4vdtECL24QAMKujEIkEFsBWhnjV7ZOtLlhoP5hf/1BvLF8LYnaznd2jN+NzDWghlE4dyHYdPzJo3Ga834YmWlQsLHGkKOUvjAkoQOIIN73PAydvkSSLv3h47UHeOsofGb8JwsfjLlj+LuU6HfD+s4YU5K+BdIblDrw0VOu3zgiyM5tCm3MP8TTQlWbX+MlQKOV4Pvq7PLAYOT24t7DwWCOV3HYWWEfTTqTUz3MbsaLnulBz6g5WJYPKyteVd7HVwAjm42n7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwKdhTAi7Q3MjZM7RqDSM1owlhXjtyWhrHnIENJh9vc=;
 b=BIfeCPlHKxYhXDvoT4UDC/JAVXr9yYuqOvZNYB1YdTnkLWZldKUQwW703NJKaZJqPSpfiG0gnkCZzVO3WV/gIxVX6mGCmezXJYb1PdC3+Mq4g+QHHzeFm5nwOxsebhn+bBBJufhMZky5IhFFqZcX8pPMwO3P3k7kl8Uj652D7mYNqCdD0iBR/CZJtaW4rA8MSilUfpR8wu81ILYIebSDLdAZ09PRwpyhQHHIcFME5jAU+yCs6hBx+Pe6Gan3b5/YjHIuksTfjzC2gTPzkOO6AE0d9ftzXAXphhtHl/kwIAUL8YpuhlzBPBFSUNUZ31CLQ0LTpAz8HsxK5/nr5exWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwKdhTAi7Q3MjZM7RqDSM1owlhXjtyWhrHnIENJh9vc=;
 b=EE5dB0Crw89XvtoYAVqn1L3setiLmF1lIcgoaWQ2bIfcBo62OWDZsnkP6fZhfxdt0KcdgLTI73qIeUhn+ZF8VbU6G67Kp8plEIwmbx3dtE1K/BliDvW+T6HnB/TFtkqOwxzjFdbmS1RR2np1yASF0rrv+WV7WiWc+1llLiKqT/o=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 DS4PPF6AF3BF859.namprd10.prod.outlook.com (2603:10b6:f:fc00::d25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 26 Jun
 2025 06:04:16 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 06:04:16 +0000
Message-ID: <f4e25a98-5d50-4c9b-b891-c4ac042debd9@oracle.com>
Date: Thu, 26 Jun 2025 11:34:02 +0530
User-Agent: Mozilla Thunderbird
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
Subject: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
 <leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "shayd@nvidia.com" <shayd@nvidia.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        Qing Huang <qing.huang@oracle.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::10) To DS0PR10MB6056.namprd10.prod.outlook.com
 (2603:10b6:8:cb::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6056:EE_|DS4PPF6AF3BF859:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fbb9f5-e23e-4720-9870-08ddb4774813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckhkKzJBR1dBN1RsWFBmMk0rU09EYmt4SmpUeTdrdzNqT004YXh2QW56WW5u?=
 =?utf-8?B?ZnAxakViYTU0ZUcxRXMreGIyMUlZYy9UOVlWaXpkNkMrbHFxbXVCakxUazBj?=
 =?utf-8?B?N0l0QzRhMGNHWFkySjJ2dkZXVnQ4Q0hKR2JxYk5PcDVmYk9FTy9MMzA5dzJi?=
 =?utf-8?B?REo1SE4yRndNL3RuTTBiYklWaDhYYUhxM1FPK1NrTWM1aDllQ0JQRE5TbE9j?=
 =?utf-8?B?VDAyRnlpSlRhWWl4a1BsVktaR0MyNGl1U1dBcUIxcnhCUWRLN3AyU3NmakRY?=
 =?utf-8?B?b1VZK1JVUlhNclArd1daak5UTkNFZTB1NUVGRHFQQndueURzYVFUeXJuV1k0?=
 =?utf-8?B?VThHWktVTkc1TVlsQW10SWFJdUd4bGxrQXgvQU5LVUVWVW5yUWF0cStucDRa?=
 =?utf-8?B?eTBqNCs3cHhOQkdrTyt0cmFwVVdQU0lsWWh2SVJJelVCaUNPcDRCV3YxV25D?=
 =?utf-8?B?U3pTSTZJNTdSTGE4K3BLVU5tWUY0R3V4Vm9PQ29xVklseXU0cGpWbWFLZGY4?=
 =?utf-8?B?b2pCRk10ME1BY09JdXJPdWE1dzdmUmJGVWhLcWZVbHJ5eXcrUG9qMjB5ZkRt?=
 =?utf-8?B?MnNvd0tvMGV5UXBoV2I1RDdTUkhFN29Dck8rOU92VFdsbmlPSURIYTM3TVUr?=
 =?utf-8?B?YU5uQWpZM3REdjJxL0FlOFRCTHNpbkcxZXdYcm43UlNaYllldWErejFHU2J5?=
 =?utf-8?B?RzFnUm1uQ2dvb01YRC9neW1tQnpQQVA4RkUwSmlubU92OEp4bUF5ZnNLQStv?=
 =?utf-8?B?dVdudmRJNTlzVjhwblM3WExTblB3M01ZZ01sSmsyZzZkTTgvd0NnejhxdTBZ?=
 =?utf-8?B?U1FsL2FxV3VNVWtidUtBVlZBSWhhaU1CUFBKMlluS2Y5SG40RzdDekpCeVhP?=
 =?utf-8?B?TzYvZU5Qa0tVQW5WOGVZQkFnbmp0OXlQZ1MrUlREeU0zMU0rTTQ5UG5pNjVM?=
 =?utf-8?B?cDU0SVkwc1RZc2loTmZqOThROGRGMGliSjFrNUtPYTFUZ2lJNTR0SVkxZHU2?=
 =?utf-8?B?S2FpT3JwMEtVN05ZbzIrbzNEcUhiUlorcE1ZRWZ2enNCazBkNVVFUEhRVHVT?=
 =?utf-8?B?V1h3WVJ6aFhLc2s5WTZFa1ZBWW9BUjNvUTBkOFl4aEpsWHFhYklWQ0FlWDlo?=
 =?utf-8?B?eElKWVRBQTdCQUI5NndDai9uYmNBajdHTFl5dVhPMm9mdTRhR0tpL25GVHpF?=
 =?utf-8?B?Qm1peGM2TEpnMXkyeVNqb0FHSGFuWHhPS3FRTzBodFlHdmo4QU1CTmRXZzdB?=
 =?utf-8?B?YmdrRW5pYmRIWFhta0RyYTJFSkhjYnJaQnBvT3lLWk9nbkpMbUFJZjZ2djln?=
 =?utf-8?B?L2xqNVhWdHYxU2NlRUlmdHJKcERqV3FtR0MweXU1Q21pOVdjbEtqN1RwUGhu?=
 =?utf-8?B?UFdrSm91V05mSWZ4UWRsdXhPYU9UbE5pVHhFcFE3OGhXVmpweWtqQkdkRnQw?=
 =?utf-8?B?dGlsMXZrYTRJTkJBaEJ3SjhkNm9GQUhjeGhRTG52dTRaSittS0Jsb0xPckN5?=
 =?utf-8?B?OFovaTVDMWt4Vk1DY3E3eWV6TC9FMzJjUW9MMm1ZbkhUM3lIRllLMFdnUkRJ?=
 =?utf-8?B?UmN6WGszcnhKazZZWVBybXJ1QlNnamtrclpPNEtvUi9IN3pMdkxyYXZ3Z2hV?=
 =?utf-8?B?RFBvWDBjNXpKSjJQWHBKVkFtNm4rdUJwTXdJcmVFMmJrb0tXazJaY3NzYmtS?=
 =?utf-8?B?UFZRdURmQlZTcTFBTjY5MzVZcDZTbE1rUnRLOXZDcTB5ZkZjaldiTmdGR3ds?=
 =?utf-8?B?U2d3TlFSZWNMMXZ5STl4TUsxNkZhRHpJUXVjbzc2V29EbWdObFk4M3RsK053?=
 =?utf-8?B?d1F5QzdWVHE0MTZDM3FXclRxRmphVVk1QmJ4MEk0MHJyMGV5L2NtREJVbVlh?=
 =?utf-8?B?QnpVb2FmUlJjSFhVc0MvT0gvaEdVRVcrRlhyVGJ4UUs4Sk5LY0NTajEzR3Q5?=
 =?utf-8?Q?C/TuF2fu8Wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBSVEVkZlZ2d3FzR0svYVkyRUMzY1Bjek1HS1QvWGlONjFMeC9VeFZMQ1NG?=
 =?utf-8?B?RHdPSXNBS0RyUENnQ04rd0t2TGFMdHFZMnZqZWhHWGdKcUhmYmFGVC9KdnAw?=
 =?utf-8?B?QUs4YzYxNXY4UUxqNExNZFd1OVpUeHA2bExlRVhBR0sxL0hVb0svWFRFOWhq?=
 =?utf-8?B?Q2sraTRVQXN2NWJMZy9VYWhUMGhUcE1mODdTTFVIUmdlS2ZQRW9sRStSQzFo?=
 =?utf-8?B?Ui9xSExZdjk2dk9URGhFYUlBZm9LK3JEVW5TVldpM2xlYmN6cVBMV0tNUDhs?=
 =?utf-8?B?Z2ExY2x5c3ZqcW05eXdXRmFJeE9sZk5rdlM1ZXZHNFd1TENnbG5NM1FmWVQ5?=
 =?utf-8?B?b2ZsS2RPaGhFb0NWUWZJMHF5WUQ3MVNEbi9SdHdHZStYZ0FSVHB2bXlNNk5s?=
 =?utf-8?B?QjVURzhHdHFuSllQRGhqR0MybDNWRS92MkFwbk94SmczQzFvcUNwbHZGY3VZ?=
 =?utf-8?B?QlhXVGVrUVNzdUZiT1BUNDYwMFc1UDFqbFY4MURpOWtWczZVQStVN3hwdVlE?=
 =?utf-8?B?dlkxd1k4V0drNExBSWZPWTc1Q0E4RHdtSzZmM01XTkY5YTlBMldSc3VjM21V?=
 =?utf-8?B?dWJEQXBwSm9PMGVlRUphUmtoTXRRNE5pdFZyamV0dEVXbDZFaG91MVIyT3lS?=
 =?utf-8?B?dUh6KzA3QjZQU0hockdaK3JMYW1Bb2pQMzMzTkdmVXdSZjNxTVkrd3p4Tml6?=
 =?utf-8?B?QmI2WFgrWlV5U3ZET2xnbnJHcHd2K2ZFb3dvRnQzcHd0SFRZL3hkcjFLakhK?=
 =?utf-8?B?SVVEY2lQemQxamtXSWYrQ2JBemprb0daUEtlODBmcm92RUJGYjkwc0RNNUhl?=
 =?utf-8?B?Ky9xUnJyVE5IZ0VjSGJWTlY3cEhLUnN2VW9pYkpvbmhWZnpjcmtuK0xub3Ji?=
 =?utf-8?B?b2RKeFhqS1MrSGpyRDM5clN3M3ltb21HMGJsbTRFbUZRN0R0eGhWd0U2Zlpx?=
 =?utf-8?B?RGRseVgwZmVLc0tvaFpFaTlsU1hyTkdCbVBMRUpKY0IwZ3BnT2lTTWNHdndI?=
 =?utf-8?B?eVhLSkkreTBpRFJuOUVMVVdIU2hCYWtHeWYwL1BMMVZnVGw2UUxwR25KRUVG?=
 =?utf-8?B?dVgxZTJMUjZFSTNIbW5GT20yWWlnM3hMNUwveGJURUVlWGVxRkhha0VTQjcz?=
 =?utf-8?B?V2ZkemIreUFzOUJVNFQ2NklDMjNsUytsMEF4VGRSQnpENmVBNUtiMi9NQ2Nx?=
 =?utf-8?B?aHNZTEFtUGptSkkxbjFjMzMxbnNjbkJxSFdsclY1eHpmbm56cXNBU25jKzdQ?=
 =?utf-8?B?NndqK0NUbEFDRm1YWFJqMnh4NCtQcXl4OXptMDZUV2dvckJoVEhUTzlNYm5G?=
 =?utf-8?B?YTA3VGdGQ05pb0IvUVN6ZzQrNEg0U1RvMHk1dERWY1o4YzR2d3doL1p3VDlH?=
 =?utf-8?B?T1dVUjV0R0FOZ01UVlJ3KzhrK2w5TmFzcmR0U3d2TWU0b3VtN1Joa1M3SE01?=
 =?utf-8?B?c08wZlhCL25QWk93WXRkVWp0ZmdrSUhMaHZETTdJb2xMSHEwWlZ2S3pFekJU?=
 =?utf-8?B?R085Q2JsMExwc0thU2RIYm1MSU5hNkNEY3lsN1hGR1F3dHNHMXd0c1ZwMVRM?=
 =?utf-8?B?a2tUNlphMU95WkZXVXlnemx5MzZ2b2J5SWdpTHd0QzROcEZBOHQ0WjdGSnJ4?=
 =?utf-8?B?cnp2ZmF1TWhmaElaWXdDNHVTL3Z2VDBVZ1BKRDJJRi9SR2RYLzlkVmM0cFAz?=
 =?utf-8?B?dTE0bHpzTElSSWcwaWtuOGZVRWcyc3QxanRxK2NaVjZxNmgvVDlRMnlxZ25l?=
 =?utf-8?B?YUlKc3BTQjh0SEZRQS9MQkJXZ2x0bkdFQnQyUXMvRmNxNngwSzhLcmZwVXJK?=
 =?utf-8?B?Y01LaXludm8xSzlZcjJTWktCMlQ2QWdyY2JwbkJhdCtWWmVWZUhIaVVUVUpK?=
 =?utf-8?B?dlh6ZkNtczNTRU5VR1ZnWHd6WmJ6dlBnYW94TVh4TmxkQ3dHUkdZNXZ5Q1Ew?=
 =?utf-8?B?eFl5UjZaZmZsQytOcWtxMUs0S1QrZW1LcmM2Y1JXSEFqa2UzUmRUZGg1cEJL?=
 =?utf-8?B?a0hKZ0lkdnVMQmI0ZHAxRkI1NkNYZk9vN1FTY05HazEybktCVmdMTGNwTWpT?=
 =?utf-8?B?OWQ1QUc4K0h1aFlvSXMzWXEzMGF2M2s3YU9GclBkejZFVktEYStOalI4bUZh?=
 =?utf-8?B?UWE1WmJ2UWc4b1lrOFVSOEpqVGJ3VGUvZ3NySEQxTnFQNmh3M1VqQWNWTVcr?=
 =?utf-8?Q?u5BY5qSryvuiIAVQnQrJ+m0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bz755kC0OaVMS/LH0oMqUckiixG0DvJ+qrYwfh4RkKDiHtKo6TD7Ac9tfntsG5mi9Ct0fU1h8d1VzdSIL/z/qNc6nIA4jTtQ6l75m8O1MnwrPwKZf7fZc+giPoix1sV3/g8SBi0C0G9nNXcFACLzHqmQVSsUGmsU+cW5DdjdmCDpGXOf7PFE4R1mVG//ci3tsNvl2ZnhijLOgE+XFTWnZ3wwl7mS6gpAYsmneh3TzGS4DZL34vIBHbWjKnKKdNAHYFgd/V/aXebyUkcKPK4sovIXpfvzkwytRnVmj0V5phmKoiEo8+Lr+vfHSnwYahsCC7hlHuqu6WdpXNvW2WmTm2QK7dFX8Vz381hujjvCa6MyK8eZlh0CK58VPr0OJcbvTPBG/9AqqX0ygOUW3qq1QNG6iMALt0KGjFhBoUZ8FHEElRwBBly9XEFvH2UdDWhzAltkWjNAw3RcwOwCgwo0pqU/GiyrV+6SdDYYSgf09JDRFpexI7CEykd/dDoeyOwvRXID4BQu//fDRLmlgnpwlG8QHLzs2zb2cCTvsHSUHubwEVO7EPsN11CyMlrZAMannbb4ZNLkdD7RPtQYP+iEOmbf4TH7RiedPH5XtryHe7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fbb9f5-e23e-4720-9870-08ddb4774813
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:04:16.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlQazAkO3pxF+6efgnQbOyKY1IJLbHoDC9W4Bh8bypAU6x716VEQuPTYFkhxEAReqCH81KrIsPCLtiqg9V8LjKnDFPamXxBBJ5UTRr51yRH5Q2SSL5oiQPTbEcKYfhZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6AF3BF859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260047
X-Proofpoint-GUID: RL7hS-KrBly835NjJYgdcFUUmxvlCKur
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685ce2e3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=ZYKq80_RobotJUz1yaYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0NyBTYWx0ZWRfX0ds/Mk1MUCzi s/pg21xdtTcTycOH77VUhxHaqirRP7FNXMgb3MdBwaSkQ7DKktAS6ZjNtSARYKIm3xK3kYQcKyT amwAxb6ANW/3AiSBF43aznrW34Xr/GGbMEg+P3q9gJrKhGwBolRC6mT5UP7iTQgbIeKkFmmwNFS
 pVMk+4Vj627cnT++VAB4tNrUcv4NIphnCTgPFfJq2Ck/D999VEE7KHbI19sm9jDreaZ7IwB7OMB cR3LaOHUldwEd/sGlmv7nf7xy0aexVwX/4gC9VfsvkE0rIwpvnQw+NcZ0KlBCN3zX1mcZr0uPlM 2LOM+OpaLAXN+xtR1RsBGAPuDAbvWf4wuszpIt7IL0Lx6qNsq1uQHueDwxdCDsIM3FW6OEcTuAv
 6VSLjWPLjpvJFIpfzSNc8QSey81hnb5FbaqR1/0lEwZ2mMu650vImDexydEYwbFraeY4awq7
X-Proofpoint-ORIG-GUID: RL7hS-KrBly835NjJYgdcFUUmxvlCKur

The mlx5_irq_alloc() function can inadvertently free the entire rmap
and end up in a crash[1] when the other threads tries to access this,
when request_irq() fails due to exhausted IRQ vectors. This commit
modifies the cleanup to remove only the specific IRQ mapping that was
just added.

This prevents removal of other valid mappings and ensures precise
cleanup of the failed IRQ allocation's associated glue object.

Note: This error is observed when both fwctl and rds configs are enabled.

[1]
mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
trying to test write-combining support
mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to 
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while 
trying to test write-combining support
mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
request irq. err = -28
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to 
request irq. err = -28
general protection fault, probably for non-canonical address 
0xe277a58fde16f291: 0000 [#1] SMP NOPTI

RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Call Trace:
   <TASK>
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   ? __die_body.cold+0x8/0xa
   ? die_addr+0x39/0x53
   ? exc_general_protection+0x1c4/0x3e9
   ? dev_vprintk_emit+0x5f/0x90
   ? asm_exc_general_protection+0x22/0x27
   ? free_irq_cpu_rmap+0x23/0x7d
   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
   create_comp_eq+0x71/0x385 [mlx5_core]
   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
   ? xas_load+0x8/0x91
   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
   mlx5e_open_channels+0xad/0x250 [mlx5_core]
   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
   mlx5e_open+0x23/0x70 [mlx5_core]
   __dev_open+0xf1/0x1a5
   __dev_change_flags+0x1e1/0x249
   dev_change_flags+0x21/0x5c
   do_setlink+0x28b/0xcc4
   ? __nla_parse+0x22/0x3d
   ? inet6_validate_link_af+0x6b/0x108
   ? cpumask_next+0x1f/0x35
   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
   ? __nla_validate_parse+0x48/0x1e6
   __rtnl_newlink+0x5ff/0xa57
   ? kmem_cache_alloc_trace+0x164/0x2ce
   rtnl_newlink+0x44/0x6e
   rtnetlink_rcv_msg+0x2bb/0x362
   ? __netlink_sendskb+0x4c/0x6c
   ? netlink_unicast+0x28f/0x2ce
   ? rtnl_calcit.isra.0+0x150/0x146
   netlink_rcv_skb+0x5f/0x112
   netlink_unicast+0x213/0x2ce
   netlink_sendmsg+0x24f/0x4d9
   __sock_sendmsg+0x65/0x6a
   ____sys_sendmsg+0x28f/0x2c9
   ? import_iovec+0x17/0x2b
   ___sys_sendmsg+0x97/0xe0
   __sys_sendmsg+0x81/0xd8
   do_syscall_64+0x35/0x87
   entry_SYSCALL_64_after_hwframe+0x6e/0x0
RIP: 0033:0x7fc328603727
Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed 
ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
   </TASK>
---[ end trace f43ce73c3c2b13a2 ]---
RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00 
74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31 
f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
kvm-guest: disable async PF for cpu 0


Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
---
   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
   1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c 
b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 40024cfa3099..822e92ed2d45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool 
*pool, int i,
   err_req_irq:
   #ifdef CONFIG_RFS_ACCEL
   	if (i && rmap && *rmap) {
-		free_irq_cpu_rmap(*rmap);
-		*rmap = NULL;
+		irq_cpu_rmap_remove(*rmap, irq->map.virq);
   	}
   err_irq_rmap:
   #endif
-- 
2.43.5



