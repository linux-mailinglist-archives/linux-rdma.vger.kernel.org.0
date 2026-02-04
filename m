Return-Path: <linux-rdma+bounces-16495-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDDBId60gmnwYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16495-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 03:54:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620FE1087
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 03:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D5430A94B8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9892D9EC4;
	Wed,  4 Feb 2026 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CW8waM/i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D923643F;
	Wed,  4 Feb 2026 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173649; cv=fail; b=cJ+p/z41JNWX0+GdRthnjLYeYsDWxBTh+rcXl/+AOksmqTAEpm6EgUzwFz9oh/PyvBV7JCoUZF1oTeidt6+mpTGtoHWmTi2QpO9BOevDF9dB7aA11zWIquaV2TNtIx/XL31M19HdlIi5fVx3A+J3dCJ41xN3qunPM3p4vhw04iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173649; c=relaxed/simple;
	bh=E10Q4K+/ubIyIPG2B7ddoD9q6w5nPgDaYKKp0wBgamg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ij/4O7MMhWl8DAQkkKCoMdcLvlbN3nQqqfXgWYCk9U4BeM34mw2EkQXgSv8dbasjIcH3X9+MDNYTD3lrxCgzEzx8uAgc2msjPjXPKaA3ATC25Had8lfoImRwmQohxraxKuAyVsq17qU7cQGMgd1QaXOGS5oBGSRiGqqfpnUpEkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CW8waM/i; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvr3MCPCbE/ZeIlMUAANLBftgqVsMZvxMP7b875e+lwuSgOj33Ogftz4IMgkmJuEMinR7jTWJA6t4JtOeBRE5lDITXF0NPvIJgH2QTgV4xvc/CUIdy1mt1mCj75WEsFnBiaeF7PvNSmFOX7vEhafZvNZmlu+po0cAD+BWu/GGwf40IPxQUU7/1BRw8vdXUDsk3E6BaK2hVLGQZTN6zGVlZK4kQ1snhHfEdPScqcmSH/jsDyI2ZcowDM9h8FG5rU7Kxdp3mTfkDWiRuJlcFEmmVdLpTr6g2oTusPFBgr+tuag3kMvmMtozgHQAeY7atJnzrkJneib3rvzc1vCu8dg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E10Q4K+/ubIyIPG2B7ddoD9q6w5nPgDaYKKp0wBgamg=;
 b=CB9aPIkvrLJwK6mGVNMrdAk2LPLMQSIoJqmobLq+Xe0FZBuKSnpNdwVd4ejmwk3MbS3o6/drQ77NA9mTiZdMaJ8ce+penx3UsLe2ILf8z7RCWWkb5vwikDJ4wox1wm1HAOrvvpgYzK2oxl2Ot69UF4NoPQ4x8i9OXdPqLTCCTBA+etmjL3a9i1bkw8fUSovDbRhS4k8RftvsCSE5QaBq9/nV7/9GyhkLYHt1Qw4GS3bva1d6v4DH+r/mGDe6ssBbUkPLDkk0kNr2EAuuRR+FQ86LmH/afpjLEc+OSjzfGdqhHl8b5uwbQTMtDU77tANslfk4Qig51DdY9nzmw3KWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E10Q4K+/ubIyIPG2B7ddoD9q6w5nPgDaYKKp0wBgamg=;
 b=CW8waM/iloJlSeamyNdV9yrOzmp3Qi4PJg93MkrC0RV3EB8F8tlYGHpmTeU+WClAfTEpMOvuHNdkl+RYM19AAoUFahsM6qABY0Edit8mXg6CVj6axqmQy2gVlDBuDLPN3KdqI+391qf+5JlXXMDNRlNPZENq57S75AOgzdNZws8ExEs9PHkzdYGGcqwalGzlTFm+aMKWnFLR/BkPigPAQbIVFMeSJbu+Me4QKpgKCrLY3V+RSS8JjCIlvVBFkh93xIfLtfTFffpY4JUUc8w2BFz7n6lBRkhyzphoO0Y4XxVZn7f12BugpYBr+XD3QD4bUawk54JWyHql/Md0DrGiow==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 02:54:03 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec%3]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 02:54:03 +0000
From: Parav Pandit <parav@nvidia.com>
To: "chia-yu.chang@nokia-bell-labs.com" <chia-yu.chang@nokia-bell-labs.com>,
	Tariq Toukan <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"koen.de_schepper@nokia-bell-labs.com"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v3 net-next 1/3] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Thread-Topic: [PATCH v3 net-next 1/3] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Thread-Index: AQHclSfKvZjxW2KAPk2pDxG/edoY2LVx1+Kg
Date: Wed, 4 Feb 2026 02:54:02 +0000
Message-ID:
 <SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
 <20260203161126.2436-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260203161126.2436-2-chia-yu.chang@nokia-bell-labs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: 6e292166-5631-4328-4a34-08de6398a793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjB6dEliNHIzcDFiQ1c2NVVHUUN4eFRXYVlTOWovOXZXankvT2l1SG56QXdK?=
 =?utf-8?B?a2pPZldBcGVFak16Uk1BWExDalBxdi9adDNpNzBTNEhPWVZUSzNhSE5Rd21n?=
 =?utf-8?B?QzczME1DdkNqNmxQUjZTdy8rM1RlL2pZWDkwN09tTWlRL0xiSzJoakhCN28r?=
 =?utf-8?B?NFVyeDEySXNxNFFXdTBjOW9Wc0RHWlRYYkVKWTZyQVMzY05QTTVEVXA2d25T?=
 =?utf-8?B?cjhnTzBmTDV4VExtb0Zyc3YrQTJzTVd0K2E5ZHNQcldYZ1JBQURUVjVZZjl4?=
 =?utf-8?B?NWlkeFdDaGRSdjA2VjRBTGlSemt3NzExNlZGUWNaUFlsUVk3bGRrK0pMWUdP?=
 =?utf-8?B?MFRqaElHTUNmRmovaGFCbnVGNTJlNDAzZUFObHZFRHZyRnk3ckU3bk9VOFl3?=
 =?utf-8?B?SG5KNEx6VmZmdGg3WEtPOC80L25TSG8yYjkyNUYyQkkxR1RiUE9qZ3ZPR1hs?=
 =?utf-8?B?UzJrclNCbWRzeUVqa2ZaWlZFN1J5VGNiNys4aFFZNU53M3FqeStlRU1BM0l2?=
 =?utf-8?B?dGt3SFZ1RGZLdFpYMjBQN1lVRmdkRmFkTW5sY2FBMHJSR05ONVVLM3lNb3Ja?=
 =?utf-8?B?YSt6L1pJR29yYkdUQTNZWDJnN2NnNCs4anVGTXZvR3NpSTA4RjR0cE85K082?=
 =?utf-8?B?bEZiZzlyMWZrZDNFaUJWNXRVUlU1Y0diS2NqcHdpQXVOMXkwZzRndUowbVFk?=
 =?utf-8?B?SEllN1NLWFVaem9sVEVERmNINTlteFJkdzZDYXlYaUM4clVuOHdMTlIxZCtz?=
 =?utf-8?B?cnoxQTZtYU5TUzgvOHNwaFJiTlUvSU1FT2FFeGwvS3hiY3dTZk5JL3J2MU5a?=
 =?utf-8?B?aEFnWXR4dDZSaFV4R0h0TzU2UUtkbEg3azRNd3B4aWV6YUFwbkcxYUhjaUhW?=
 =?utf-8?B?S2s5dnpNNUpobndKcEdLZVM5OEc3SFVHYmtEcTYzMWNmdFFZOHZicUVIM2Z1?=
 =?utf-8?B?a25tZ0QxUkcrNkVPQklrL2ZWaXRpcUFaaDJjc0JmNVJzK1M0dkZuTFJLWFRo?=
 =?utf-8?B?d1FZamtxVmNhZWJSaHQ2bjlCQXNaMnU2VXZ1ckIvMVFjL1B1SW9ablBkT2cy?=
 =?utf-8?B?UjUvRmJHM0N5RkNBTTZ6cVRJS0RPWWhpZVFxQWhMZmVRNzJUa256eWJyTW9J?=
 =?utf-8?B?V21wR1MvK3BKVnN6VE01cnhwY2VzRSszSnhRYjRBejFCL1NvdENJeFordzZZ?=
 =?utf-8?B?N0hOMFNXbHM0eVpiTWU1Wkt6NmZFNUZuK3VMT2ttbTV0bmFHTzNiZVJvZWlT?=
 =?utf-8?B?ejI4aVV3TjB0c3ltSzh0Z3l2VGY0YzkrcWV4bWRqY0NnNVExbnNYOWJhQVY0?=
 =?utf-8?B?YmZSdk12Smd2ZjBZOG0xV2N3dFFYR1l0Y1lDRjRpTFdSUEJtdFRNRGJ2NUg1?=
 =?utf-8?B?cVFnbVI2eUlFWndmTml5aXZ3SkxxNnFSSlh6d3NCMnBzNU5raWR6dDJRYm0v?=
 =?utf-8?B?S2dDV0IxTWxzM0NFVFBtNks1K2tkWk9KQm1INWI0UUhOeFQvNi9qZlR4NHE0?=
 =?utf-8?B?WnZEWXp1RmFIRHdWT3V3QmtYVW1CemZKZ3JhNmJQNnVBaWtkazRGOFVEZUwv?=
 =?utf-8?B?T2U0TXVZSnhtRmszZGF5N1U5M2FJRkY5R3oxOHJJMXgwYUFIOGlmNjBHQS9y?=
 =?utf-8?B?dGhuSU54aExWZnNBMjZ6SzdNREtrRFFKeXhrc09oOXNmM0hxMTN3OHo1TjF3?=
 =?utf-8?B?QjNGdGNEYjZYMXJoYUM3dytHODNCMkpqMW1RNTlzTUxWZ1hnalRrZU5kSWNK?=
 =?utf-8?B?WGJnbFFlQTlsZGdjODRzbkdWV0E0ZFo4MXlpbTBvWFBmc1crNW5WWksxM3U3?=
 =?utf-8?B?aEl4M21jN1Q0OGllVEhqK1loMGVGalgvdFB1SEZlMWNhZFpZOGtWZisxdERZ?=
 =?utf-8?B?SEtHSVRhcmhXazVaRnFpZ2F1dDY0ejBLZS9UK3djMjF6Q0VaSTQvZFEvQ1VP?=
 =?utf-8?B?Y3lsdVZBNWd0cFg1aVNJa0NpMm1XV2l4bHpVbkFJOUI4VXZnRXpFbEJZUFEw?=
 =?utf-8?B?ZStJNE1sa0ppZVBQK0RDUURCeExkQUxJL2E1VHB0bVdaaGU0dEhtN3NYd0lh?=
 =?utf-8?B?SDI0U25WdU1YU0RjczNMSTk5RVE3R2d1bktPSEdtWWI3S1llQ1ZsZkpOUGN6?=
 =?utf-8?B?ZzBoL3k4S3NCUUx0NWhBSEFUR3FOTlIwS2ZCYnBlRWlLNjBwcjF5cnRTdDNo?=
 =?utf-8?Q?NSGJmPug4WUuAUhCi7LH7Las2GTF/U50Gp+449LbUGR9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QngvaDhabG10ZUQ0YXVZWitjeHhwaU84Z3RmdDdNWENMektpMjV2SmZWVVhX?=
 =?utf-8?B?eUNmR0YyUWN3dmtuUytHUHlwbURXdCtSd1FPY2Fob0lPWStGUTR3cTV3TCsv?=
 =?utf-8?B?R3ZXc2FFN0VYdXcwM29oVDR4SUxSY2dzREUwSVphYUs2dVpSVUlEYlhic1VJ?=
 =?utf-8?B?THVPVnI1bC8vclM5S0FaVGk1eDlmSDVkM1RqZWhXVFBPN1FROTROZmd5S3ZQ?=
 =?utf-8?B?OEdsM3IxRUIySXRqc21qNU9MMkU2K0ZvL0ljeUJpeDNPZWxTRjNaVmNNUkJa?=
 =?utf-8?B?cExXS1Znb2x1VzBHNHJFYTBTQW1NclJIYjl4MVpndHFJUGZNU044Sno1bmRv?=
 =?utf-8?B?djFRMXhHZGtzdk5oOGgzVXRLODdwcStJcEF2MDlaa2RzNEpFTmRUMjhXUVlR?=
 =?utf-8?B?c09JQWhONVV0TWdaU0hWaXBsbHBRN0cyeXJJU21pWFhJejg1RHhpZTlPUkwr?=
 =?utf-8?B?bTdvRHFuSlRScktnQWpyZWh5SE9rR2M2OWIraWo5WWZQSnZJK3JCc0gvQk5D?=
 =?utf-8?B?dnZKc2NMeFVmVW9BZWdWMnJXRk9yanR2RHZleEJlUGcwek1VWW10RkErbEQ2?=
 =?utf-8?B?N3l4Z2JzdUhDZHErVVUxOHhZMkhyMmtyUzMrS3JIVk14ZVhXcnRNKy9xSDd4?=
 =?utf-8?B?V0c3eUU4eEFBbHVnZHJVUmdoKzJDaC9vTk1DcGc1QmNRNDVBQTd5V0hwU2t6?=
 =?utf-8?B?TmF6cFhFbjFESFk3QlVMckR2akZ5K2s2cmgwb2hQdWd1NXE5UzFlM2pwODNL?=
 =?utf-8?B?VE1vQVJlWHRrV1drUmJveDdZekdBWWtaWjIzT1hvNjVMdFozdTBRT2hPRHRQ?=
 =?utf-8?B?Vi9MWFc1bldJOGNQTWRkelJEU1gvMmtLK3NqUFZQUjFtV0I4b3I1T1JzbG9F?=
 =?utf-8?B?dGRLaTN4ZHFLdTRZelhPY0dkMVZSMUFUUDVvbUlGbm0yN01XL0JVWGJCZ1F4?=
 =?utf-8?B?cmE1V3kwNXJaVlo0amg2dUxUbW1ZK1ZqTGZBWXBtVjZYRVhTNCt2cElLVkhk?=
 =?utf-8?B?VWNEeUZHN1FTVjFPbnNidGdZSmNWREpXeHNlL2dtdW55TWVuOGRjR292WElR?=
 =?utf-8?B?Q2tsODhQNmV5UXc1UjJMWXRWVUZEK2RENGdodGhYd2tVMFpGQTArVDlWU3pu?=
 =?utf-8?B?cUlUZUdCVElCTGlrTE5mdDRQSlkwSDJRaWhTZVFhTENVMEZWTHB6YXlsMEhH?=
 =?utf-8?B?ZmIyVHpYeVdIdXB2ckE4ZnhHekdxLzdtRXN4N0paOFRDWVFWQXU0Ui9LdGZQ?=
 =?utf-8?B?YkU0aUFDWUFpM2pzbVJIZk5wUXp3WGU5WVRnQm5VS1hHdllvS1FFUE5QSEk0?=
 =?utf-8?B?S2w1TXRvaG56d1ZNNndTMTZFeE14QmVuWXJyenhMK041WEJ6YUR3QmZVbFFJ?=
 =?utf-8?B?Tnh0ZzhQaTdOYVpVSnJzSVZ2QXYxVDVaTkNxUjhCY0VGNWFVdzN6SVhPeVZ0?=
 =?utf-8?B?bEcvc2MwUEFScGF6YjRiMWJiUlN0RkVnV0ozUURXcnQ0MndPQmd3TEpFcWd5?=
 =?utf-8?B?Qm5DUTdzV2dRS08zL1hTT2ZmK2c0cU5tYU5LMGR3MytJUk5KODNxQ2R3V0w1?=
 =?utf-8?B?OWhvRWllVUxVTUZJb3JQZFNsd1lWeitxQmNYZ3M4dlZyYnAzejhnNlE0U2ZB?=
 =?utf-8?B?TjQreVZKRCs3YnlvSkY5a3Z5bEx1TCttVWtqSUJLTTJ2T0UxSDYrZFF1S2xG?=
 =?utf-8?B?c0YrcDdwTWNHLzhQc054SHM0OGxoclZOTnpER3dOR1dUVDRRcDNXK01EOTYy?=
 =?utf-8?B?NzZUMUlXTGRlSG9xb2hKUnZMQk1nVHRDQkVTbFdCT245N2Q5MUNlcDRONzZi?=
 =?utf-8?B?M0NPbDNDUlV1YWFGNkRlVUI0WUxJOWx4SGZJc01kbVc0b3h4VGhNZVowaVRP?=
 =?utf-8?B?Q3hTSWRMSDdLZzRVb2pBYUp5WjYyQWE2Z3dlV0N2RlpqbTBPSUZjajVrRUlU?=
 =?utf-8?B?OE5qdFR5cjN0MVhnOEs4UFcxY29idGxVbStvbVdkcER4MHdzaW9aVDNQWHlr?=
 =?utf-8?B?VjExRFJ4Vy9MWEVUUlk4RlJwUEZPRDNMZVpBREpiWDd3QXBVdlh3am5nWlBS?=
 =?utf-8?B?NkRwVGZQdndUZHczNFJ5QjVSNXNBdmtCcytxSTRDeFVFeHR6YUl6empncUZF?=
 =?utf-8?B?SGpRRmZGVjM5QUZsRmh1K2VLbTgxUFlqS0pGZHNtWS9jeUtuTWhvaTFzTTdh?=
 =?utf-8?B?Q2MxT2I5c0pUYVQ1SE5BL2RsTVZjVzkya3UzQ25YNTBhdFg2eVZWTHhCSnVi?=
 =?utf-8?B?QnUza3Q3ZlRrMUdLRkduaHhNOWVsdVl3bUVrRlJ5ZW5Cd21XL2RKYUxQbEYw?=
 =?utf-8?B?UGtyMFJkQytDRjZtNlczdUJUVGE0dmZpc1h4S2FMQ3Q0dXQ3YlRrNlU1RFB2?=
 =?utf-8?Q?zn0XD6qqSbUVBEy55F59foQcqwOFsXF29GrSy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e292166-5631-4328-4a34-08de6398a793
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 02:54:03.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7H0OVFSw1qy0REP3YDwg1UHrrATUx6wyxbLV+Eo26vuQf1n8Sza1Iau/8znjX0qUiXNcsTXSzTMVbnizoPL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	TAGGED_FROM(0.00)[bounces-16495-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,SJ0PR12MB6806.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 2620FE1087
X-Rspamd-Action: no action

DQoNCj4gRnJvbTogY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIDxjaGlhLXl1LmNo
YW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+IFNlbnQ6IDAzIEZlYnJ1YXJ5IDIwMjYgMDk6NDEg
UE0NCj4gQ2M6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHYzIG5ldC1uZXh0IDEvM10gbmV0OiB1cGRhdGUgY29tbWVu
dHMgZm9yIFNLQl9HU09fVENQX0VDTiBhbmQgU0tCX0dTT19UQ1BfQUNDRUNODQo+IA0KPiBGcm9t
OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+IA0K
PiBUaGlzIHBhdGNoIHVwZGF0ZXMgdGhlIGRvY3VtZW50YXRpb24gb2YgRUNO4oCRcmVsYXRlZCBH
U08gZmxhZ3MsIGl0DQo+IGNsYXJpZmllcyB0aGUgbGltaXRhdGlvbnMgb2YgU0tCX0dTT19UQ1Bf
RUNOIGFuZCBleHBsYWlucyBob3cgdG8gcHJlc2VydmUNCj4gdGhlIENXUiBmbGFnIChwYXJ0IG9m
IHRoZSBBQ0Ugc2lnbmFsKSBpbiB0aGUgUnggcGF0aC4NCj4gDQo+IEZvciBUeCwgU0tCX0dTT19U
Q1BfRUNOIGFuZCBTS0JfR1NPX1RDUF9BQ0NFQ04gYXJlIHVzZWQgcmVzcGVjdGl2ZWx5IGZvcg0K
PiBSRkMzMTY4IEVDTiBhbmQgQWNjRUNOIChSRkM5NzY4KS4gU0tCX0dTT19UQ1BfRUNOIGluZGlj
YXRlcyB0aGF0IHRoZQ0KPiBmaXJzdCBzZWdtZW50IGhhcyBDV1Igc2V0LCB3aGlsZSBzdWJzZXF1
ZW50IHNlZ21lbnRzIGhhdmUgQ1dSIGNsZWFyZWQuDQo+IEluIGNvbnRyYXN0LCBTS0JfR1NPX1RD
UF9BQ0NFQ04gbWVhbnMgdGhhdCB0aGUgc2VnbWVudCB1c2VzIEFjY0VDTiBhbmQNCj4gdGhlcmVm
b3JlIGl0cyBDV1IgZmxhZyBtdXN0IG5vdCBiZSBtb2RpZmllZCBkdXJnaW5nIHNlZ21lbnRhdGlv
bi4NCj4gDQo+IEZvciBSWCwgU0tCX0dTT19UQ1BfRUNOIHNoYWxsIE5PVCBiZSB1c2VkLCBiZWNh
dXNlIHRoZSBzdGFjayBjYW5ub3Qga25vdw0KPiB3aGV0aGVyIHRoZSBjb25uZWN0aW9uIHVzZXMg
UkZDMzE2OCBFQ04gb3IgQWNjRUNOLCB3aGVyZWFzIFJGQzMxNjggRUNODQo+IG9mZmxvYWQgbWF5
IGNsZWFyIENXUiBmbGFnIGFuZCB0aHVzIGNvcnJ1cHRzIHRoZSBBQ0Ugc2lnbmFsLiBJbnN0ZWFk
LCBhbnkNCj4gc2VnbWVudCB0aGF0IGFycml2ZXMgd2l0aCBDV1Igc2V0IG11c3QgdXNlIHRoZSBT
S0JfR1NPX1RDUF9BQ0NFQ04gZmxhZw0KPiB0byBwcmV2ZW50IFJGQzMxNjggRUNOIG9mZmxvYWQg
bG9naWMgZnJvbSBjbGVhcmluZyB0aGUgQ1dSIGZsYWcuDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6
IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErD
pHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBDaGFuZyA8
Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiANCj4gLS0tDQo+IHYzOg0KPiAt
IFVwZGF0ZSBjb21taXQgbWVzc2FnZXMgYW5kIGRvY3VtZW50YXRpb24gZm9yIGNsYXJpdHkNCj4g
LS0tDQo+ICBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIHwgMTUgKysrKysrKysrKysrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZmLmggYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5o
DQo+IGluZGV4IDhiMzk5ZGRmMWI5Yi4uYzU5ZjBjZTQxNGQ5IDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3NrYnVmZi5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgNCj4gQEAg
LTY3MSw3ICs2NzEsMTMgQEAgZW51bSB7DQo+ICAJLyogVGhpcyBpbmRpY2F0ZXMgdGhlIHNrYiBp
cyBmcm9tIGFuIHVudHJ1c3RlZCBzb3VyY2UuICovDQo+ICAJU0tCX0dTT19ET0RHWSA9IDEgPDwg
MSwNCj4gDQo+IC0JLyogVGhpcyBpbmRpY2F0ZXMgdGhlIHRjcCBzZWdtZW50IGhhcyBDV1Igc2V0
LiAqLw0KPiArCS8qIEZvciBUeCwgdGhpcyBpbmRpY2F0ZXMgdGhhdCB0aGUgZmlyc3QgVENQIHNl
Z21lbnQgaGFzIENXUiBzZXQsIGFuZA0KPiArCSAqIGFueSBzdWJzZXF1ZW50IHNlZ21lbnQgaW4g
dGhlIHNhbWUgc2tiIGhhcyBDV1IgY2xlYXJlZC4gVGhpcyBmbGFnDQo+ICsJICogbXVzdCBub3Qg
YmUgdXNlZCBpbiBSeCwgYmVjYXVzZSB0aGUgY29ubmVjdGlvbiB0byB3aGljaCB0aGUgc2VnbWVu
dA0KPiArCSAqIGJlbG9uZ3MgaXMgbm90IHRyYWNrZWQgdG8gdXNlIFJGQzMxNjggb3IgQWNjRUNO
LiBVc2luZyBSRkMzMTY4IEVDTg0KPiArCSAqIG9mZmxvYWQgbWF5IGNsZWFyIENXUiBhbmQgY29y
cnVwdCBBQ0Ugc2lnbmFsIChDV1IgaXMgcGFydCBvZiBpdCkuDQo+ICsJICogSW5zdGVhZCwgU0tC
X0dTT19UQ1BfQUNDRUNOIHNoYWxsIGJlIHVzZWQgdG8gYXZvaWQgQ1dSIGNvcnJ1cHRpb24uDQo+
ICsJICovDQpBYm92ZSBwYXJ0IG9mIHRoZSBwYXRjaCBiZWxvbmdzIHRvIG5ldCB3aXRoIEZpeGVz
IHRhZy4gTm90IHN1cmUgaG93IGltcG9ydGFudCBpdCBpcyB0byBoYXZlIGZpeGVzIHRhZyBmb3Ig
Y29tbWVudC4NCkJ1dCB0aGUgbmV4dCBwYXRjaCBvZiBobnMgYW5kIG1seDUgc3VyZWx5IG5lZWRz
IHRvIGhhdmUgRml4ZXMgdGFnIGFuZCBpbiBuZXQuDQpTbyBjYW4geW91IHBsZWFzZSBzcGxpdCB0
aGlzIHBhdGNoIGFsb25nIHdpdGggaG5zIGFuZCBtbHg1IHBhdGNoIGluIHRoZSBuZXQgYnJhbmNo
IGluc3RlYWQgb2YgbmV0LW5leHQ/DQoNCj4gIAlTS0JfR1NPX1RDUF9FQ04gPSAxIDw8IDIsDQo+
DQogDQo+ICAJX19TS0JfR1NPX1RDUF9GSVhFRElEID0gMSA8PCAzLA0KPiBAQCAtNzA2LDYgKzcx
MiwxMyBAQCBlbnVtIHsNCj4gDQo+ICAJU0tCX0dTT19GUkFHTElTVCA9IDEgPDwgMTgsDQo+IA0K
PiArCS8qIEZvciBUWCwgdGhpcyBpbmRpY2F0ZXMgdGhhdCB0aGUgVENQIHNlZ21lbnQgdXNlcyB0
aGUgQ1dSIGZsYWcgYXMgcGFydA0KPiArCSAqIG9mIHRoZSBBQ0Ugc2lnbmFsLCBhbmQgdGhlIENX
UiBmbGFnIG11c3Qgbm90IGJlIG1vZGlmaWVkIGluIHRoZSBza2IuDQo+ICsJICogRm9yIFJYLCBh
bnkgaW5jb21pbmcgc2VnbWVudCB3aXRoIENXUiBzZXQgbXVzdCB1c2UgdGhpcyBmbGFnIHNvIHRo
YXQNCj4gKwkgKiBubyBSRkMzMTY4IEVDTiBvZmZsb2FkIGNhbiBjbGVhciB0aGUgQ1dSIGZsYWcu
IFRoaXMgaXMgZXNzZW50aWFsIGZvcg0KPiArCSAqIHByZXNlcnZpbmcgQUNFIHNpZ25hbCBjb3Jy
ZWNlbmVzcyAoQ1dSIGlzIHBhcnQgb2YgaXQpIGluIGEgZm9yd2FyZGluZw0KPiArCSAqIHNjZW5h
cmlvLCBlLmcuLCBmcm9tIHZpcnRpb19uZXQgUlggdG8gR1NPIFRYLg0KPiArCSAqLw0KQmV0dGVy
IHRvIGhhdmUgdGhpcyBjb21tZW50IG5vdCBsaW5rZWQgdG8gYW55IGRldmljZSB0eXBlIGFzIHZp
cnRpby1uZXQuIEl0IGNhbiBiZSBmcm9tIG9uZSB0byBvdGhlciBuZXRkZXYgYXMgZ2VuZXJpYyBl
eGFtcGxlLg0KDQo+ICAJU0tCX0dTT19UQ1BfQUNDRUNOID0gMSA8PCAxOSwNCj4gDQo+ICAJLyog
VGhlc2UgaW5kaXJlY3RseSBtYXAgb250byB0aGUgc2FtZSBuZXRkZXYgZmVhdHVyZS4NCj4gLS0N
Cj4gMi4zNC4xDQoNCg==

