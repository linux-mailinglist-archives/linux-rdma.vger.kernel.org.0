Return-Path: <linux-rdma+bounces-16906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF3vHDPakmnKywEAu9opvQ
	(envelope-from <linux-rdma+bounces-16906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:49:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FE141AC2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B81B330099B3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857620C012;
	Mon, 16 Feb 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IPY38TyV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634815B971;
	Mon, 16 Feb 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231788; cv=fail; b=k1k8NHq2xFPf3x2MUYE6ltrgMh+dWtE2wHWlsqUiQGc16h4X86W4W5AniUIfOYKGByRMw9yi1GG/czWy8LJHM/shMihFCbTMSVZtBWyA+1eBvesRkREls6DtILGB1NlD8Of3YqudY2z/uEzKQBDiPsNJCPWc4+a63HB0qjiFcF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231788; c=relaxed/simple;
	bh=08vBqgXPN4OoarErDEmVCz0OYcIAyZdFIRqQ4tXu1zk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jPtt5pZ2Ul0wRAbrsWh2neoE9IL49mueu3J7Xz0xpIoh98rEr+9/x/Hurl+KvsYogVSQvtk3O9FuW5shmHOfcBxdq+WS9rSCpERmvOxMvm4ceX8XP1QDTCOqGDr5DqEbjFnceXfc8tN422pesaoF2rwBZyAIipCJ2su14xYfSxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IPY38TyV; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuZVG3tBd8w/otkEzce8Zfguf15axtlefOEzxzNI43/SNb+D95W+k1MO5IuX4Ls4/sX48cpwsZpriYrH6pYuPeGMhalIRGKnz23M9ajJFOVWNXPSTU2L+/BizD79Pb9wU+TV+hzZL4LkO5mQQKK0YEiiLE9SPZtWs2y91fi4zmvU7Rfqg5rpYi6qj3VIXSZ519XY2Bn+yh0nn1K3XYt336GkZHZWjE3TdKZfxRjGUvTqDO8Kys9i31WOzvF+FYdqp57T/oGkKrDAAxZwa0E4rsqNTD4t1hNuiOzmlpfNsozMwjMJzc0Ng0bH5MoPO/VtGb/urbVzMrsoH3GPrqFgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08vBqgXPN4OoarErDEmVCz0OYcIAyZdFIRqQ4tXu1zk=;
 b=RlYFwDKE//XD/1vCu6wiuh6fsVKuvPO/o0Dw19WRPAjKvWL+H/rrbeUMxvup5Lw4btvrhhyfREchj7bmpDLdrSNA3r8cdtpocFRzWZIeViJyxcNw7m7VW4/bT8Dzn9w6pHKzALQJys7BuiFw/SIYm2xLr2urRsJv33BHduaqdfkO1MiEQY/9Dpwv/b2xAGikI+g4rMX/x9R+A1JIXI7RBrjfiZ2fJ31g0v7DcehzK/0+UQkO5LLxn56rgBoUV8LIMeX2vyJi1ND0pIF5PsmXhtkCR3tLwtZqfp577EhMz8FQbp5j5tBE/P+TtxKOzuaUDKEUU7zLCzXTYD5UKOL66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08vBqgXPN4OoarErDEmVCz0OYcIAyZdFIRqQ4tXu1zk=;
 b=IPY38TyVUOVTI/9XEiXYVoM0/QcE81cnh53ScON4JtoJ/C7adHdJgQcoHa/eWWrTQFfjdmwCbbUvIvcH8P8iPkPM0vtktP2Bnp3cmIHjISIcUzTHdTYEhfkAgk9wpaRH8+NecYOPiSoFon2Pssn+cGY4QHvZqqy7bk3wZrws2+EwEYeBw4lOc937rqS/FfGQ2GT7s4uFs5kGtwnzvd/NRvQa9ta/zVwm1KqQuK6PhoJSBuwtUF3/ZNSlE+quQ8HENgWB4mgiqbV8gR7CO47wXApIq6rVAAK9b9zBIdlGpPABW7wvjnR3NGuT/f7D3r2XMd2lgCjB+Exu+QblVjoSlA==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by DBAPR07MB7016.eurprd07.prod.outlook.com (2603:10a6:10:198::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:49:43 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::2572:d79:2e5f:7a3c]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::2572:d79:2e5f:7a3c%6]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 08:49:42 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "linyunsheng@huawei.com"
	<linyunsheng@huawei.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"parav@nvidia.com" <parav@nvidia.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"leonro@nvidia.com" <leonro@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>, "ij@kernel.org"
	<ij@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, "Koen De
 Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net 2/2] net: hns3/mlx5e: fix CWR handling in drivers
 to preserve ACE signal
Thread-Topic: [PATCH v2 net 2/2] net: hns3/mlx5e: fix CWR handling in drivers
 to preserve ACE signal
Thread-Index: AQHclqomOL/zR7mXfUqhaI/JE3OhlLV70VEAgAlDU3A=
Date: Mon, 16 Feb 2026 08:49:42 +0000
Message-ID:
 <AS8PR07MB79732D13D0914F7F68EE37A7A36CA@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
 <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
 <ad37a4f4-7a03-4293-a8c3-1f0bad2f2489@redhat.com>
In-Reply-To: <ad37a4f4-7a03-4293-a8c3-1f0bad2f2489@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|DBAPR07MB7016:EE_
x-ms-office365-filtering-correlation-id: ee531c26-4ee0-4884-cfb1-08de6d385412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bW1BOGpvNjJ3bG9rT3hpTEhtZDYxMXQ0TUh1Znl2WUpNZEtOeVl4UnJkSTkv?=
 =?utf-8?B?cS90b0lQRjNwMEJOVjMvMDA1Qm0xb3lLQm5UUjZ3ZFNoYndHVDBNVjM5REt5?=
 =?utf-8?B?UVZwY21FV2NnYm5hU1ZQZ0I0ekp5cnliWlFKUUpKKzNoMUd1RW5TT1JBNHlI?=
 =?utf-8?B?VDhodUlIcXZkWTVKMzBETmpqNGxjUUNxd1JuL3lITjdTQ3F3RmNMR1VrcGZJ?=
 =?utf-8?B?Q2FNaHVTb2Z4WEtnQWdGek13WjFpMHNCSW91NHFnNDNMQkFqR2xFREozN2Zr?=
 =?utf-8?B?VDJmZG5GVmE4TE5PTzRKT1RXWW9lY3U1dlB1eWo2d0NuY1Rnc0hJSWV4Vm9s?=
 =?utf-8?B?OEVScU9OTzBvOFg2MzBjZnpYWlFhZWdXVHpSL3l0Ykg1VGJzaDJ0RTI0MjFy?=
 =?utf-8?B?WHhFc09wZGhXWS9sdGR2NnZPNmVWTHZYS0NHR2VoRC84MlRIa2pUZW1xZGpt?=
 =?utf-8?B?UTM3akdhNytFTUhpamUreUNmQS9zb1YyNTBhRG9IRkY1Qy9lKzZsdG5BTzNq?=
 =?utf-8?B?blRBWkdJRTNCdnlEK1lLMVFFUGZoeGphcWF3NkVINFJhRkJXQmNxWXEyek1K?=
 =?utf-8?B?U1RyQS9CNTNmdTJLbHEzSEZWREVwZ1c5eENTRjVSbkhjM3o1YzNUbDQyZ1Fl?=
 =?utf-8?B?SkhBMzRvZzJ2V01XSW42VHlZVnFadXZEQ3hlM2hxZWFSOWhQSitDQzZyVWlZ?=
 =?utf-8?B?SE9wMVlPVGR4OXR2VFZSTFlRUXpwZ1FPTVAzdEJZdTNqcVVyQm1RVGwvQ0Nt?=
 =?utf-8?B?RGdpZi8yV1NZZzU4ZEpZZGNidUZqdGdKZ1lYb2RHZE5VQy9lT2pPUzM0L3g4?=
 =?utf-8?B?NitvaU1TK3p3akdmYWJhVXloVG9yL3NHU3Q5VjhQOGZ2eHFaNktHQ3VWY1Jj?=
 =?utf-8?B?QUFJRFFHL3dYWVVyRG5OMEFjbS9SOStVZHlrQ1JhTnhJOURjVGtNeDJNT1VQ?=
 =?utf-8?B?NXZGUG5KTTdhbWo5Um4xTGZNRkx3Z1RZOS9uWXk3SDM2WFQ3OFJHUGJkWC9X?=
 =?utf-8?B?VDRMK2w4SUhuMnBRdU5OS2NzWWphU0lMOVY5N0ZGN1BqT0grMXJTTklHMElD?=
 =?utf-8?B?SmFNa01yRG5ycS9ud0FSdTc4R2NYVDBIUkNxRUp3Q1FKTVJEelM1NWJjNDFX?=
 =?utf-8?B?ZzFySDVQbmJQbzZFbzIzdDd0MjJ2cW9PVXEwdVBKcU10QkJONURSbmVJSnMw?=
 =?utf-8?B?cHM4eFNDUEZLdHBNMXZwMDlUeUtBTi81dURLZFZ5TmpBS2tJcHhkUWhrMUl3?=
 =?utf-8?B?cnpqdnJQWm02Z3ZmbEtpcmRBOTVXYjc2d04yNnpNQ0hUVjBNRXFMRE9Lc29V?=
 =?utf-8?B?V0N4M3djemZKdDRWU3crdTU2MGdkUWlBcU5RdllZVlRieTR2NWtIOWhvU045?=
 =?utf-8?B?RTFkMkRsQ2dqb3hSYTRYeUkvaEdZeWZRbU1GQ1VCcGVVUExONWoyU21YUi9T?=
 =?utf-8?B?UWZrZTM4Q3YwUWh1RVF0RGJodUhTWW9udTU0U1FuU1VHdGxMNGtSL0RVd3o2?=
 =?utf-8?B?Skt5bWZYYnhuUGVEMm9MVGRZYnhaczR1ZFpHQktPY3I5NkpwOXNTT0wwam5j?=
 =?utf-8?B?WXE4VUpvbFJJMEl6L0xWR1N2NFZ6Y2hxQlgwZGlvL3cxK1FTZEpuQ2dscUtq?=
 =?utf-8?B?bkVmYXZHeUFlNFJFNHNMeCt4QS9FOFhEVHJTMkJBa3JLR3FxS01zdHdJQnA5?=
 =?utf-8?B?VDRIUVVwam5jaERZQVZmTUtFSCtXY2hSdCtMdkZDd2JmQ0t3QU1UaVBubTJh?=
 =?utf-8?B?K0I4NjZpdklReU41djRUU1pCbTUyRm9sQnEzcGtNYjVyNGNVZFozajhQS1RN?=
 =?utf-8?B?VXZBdVFlUlBFUVlqVGxxTnNhMG0xMitnNE1kaGdhZVpOdUhmWU1RbTAza1hL?=
 =?utf-8?B?a2RHT2VvaS94OEhwMDZkUWxDeVg4L1ZHQjlybVdya2wxWHc3dkgzUnBCakly?=
 =?utf-8?B?TVVURXl4d2VUZjV1QXowbEg0NlB4c1pjRlp1dTNkNngvZFdZNHg2cUNqQUpz?=
 =?utf-8?B?VFdMRmNKRzdmOHoybmlnTm03bVRVOHFtdEF3cnVpckNxamd3dy94MkllSHVX?=
 =?utf-8?B?TUhLSmN2Skl4cDc3U0w0MWlNSDRKb25maUtBTks1Nm1iSHU4UnpSbVZIaWVm?=
 =?utf-8?B?UjBha1M4ekpBRnVVZEgzeHJjTnRjZXpiN3FQMVdXSEJVWENlYzh0dGRySXQx?=
 =?utf-8?Q?RTdbjXDjG+uSM1BhO/F0xhAXAMnnPNsagJddK1FVsP6m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REVIYUhlNDNjc2s0WkFaVmdibFhUUUpvZkRqM29EOE5LR0x1YjBLTHRQQTlM?=
 =?utf-8?B?ZHZ6Vi9ocEkyaHFnV1YwRUw0czd6TTIxQUw3VGNiS1BnRHR5YTM2UVNZVFdR?=
 =?utf-8?B?Mnk5NlpJRXY2dVZBQ2R0VWJKZnFkVmlTMVY4VmF5S3BOcVhlcVFzb1pFUURI?=
 =?utf-8?B?Wm5RTVoxVkU4MkdDR3ZFeXc1QkliYk0xRldoOVRwRGdENHpXdlVUb0FieHFt?=
 =?utf-8?B?Q3c4ZTkwZmxDbG5hKzFxR3VoRmFBT0ZpYkhoS0VzTkpFQzRpcTJ5YldlaExR?=
 =?utf-8?B?Nng3UGl6V0RFWjdTSUtaVHVjeDBlN3hTNW01OW1ud2lvVmVUQjhIaWoybG9W?=
 =?utf-8?B?YkJ1STkyOGlhNVN0emF4ZURlL0lrUDZEbnp1eXVza1BqOXJtaVB5ZTlmei9W?=
 =?utf-8?B?QmkrNWNsTGd5VSt0TE52aHR5SEg4VE8xdU9RQkdMRlVJUUYyMjV5TlplWmRV?=
 =?utf-8?B?SkN0dndmUkxJbno5VXQxUFFwRGs1bHN1MU9pSGRxMjhvOCtEeHo1Q2swWXVP?=
 =?utf-8?B?a29MNmlvRHVGWk1TelJIRDZTbkgyek5mSkdkOFVJUkFiKzNSTWtwQ3NoTWJi?=
 =?utf-8?B?K2g1RS90SkZibUhxamVkdmlvZUlQZEg2bmZlaGdITVNGUjdSaUZrcTV5Vmpv?=
 =?utf-8?B?VVJJeWs2dk9uNHBNNGxkT2J4cDlDWHVYRGt0bVJVODF5MEFnQmhaWSt1V0R5?=
 =?utf-8?B?M0RzVGp2dnRETXdxZ0t4dVd6QU1TSnRLSVorVkJuY2prcFFySXVTeXJ0dEhV?=
 =?utf-8?B?RFF3ekU3WjVLalZNeU04dUFZRG1PeDBoVUs2UU4yQ24vbU5JcTczUUR2bGRm?=
 =?utf-8?B?M3F0VEIrc2V2Tzc3NzFCWHpWZS9mMWFCRDQrRjloRWFmd0loRnRYNkhwZVBu?=
 =?utf-8?B?YmpuQWNXMXphTjB6aGRIbENWZEg4bnlJZVpNcHhjLzhFZGNWZnREdE5HcEJB?=
 =?utf-8?B?V3poSk5hclZjZXA5V0RQWis5QU1PNVRwT3RpdUJZT1E5Sm10SUNsUGUxSXIv?=
 =?utf-8?B?N25lRjNIaVExK0Y0b1UyRWJjU01ZaEErczFuUXYxaDR0Nzk5ODd2aGFvQzYx?=
 =?utf-8?B?Q2hsbGtSczE4VUpuRmo4ZGh3NzNVb0ZHM3JoL0llZW1RVVZReEpIdWNiMU5F?=
 =?utf-8?B?b0ZhSkRja0dybFpvcEhteGFjdllOMEVhTUpOZkRYQUhwTHRRMHdlNzVRM3A4?=
 =?utf-8?B?dFcwT3lzRUROd0l2ZE5zR3lycGpjcVFyOG8vUjNVd3ZpTmp4aHIzcXNwcnpo?=
 =?utf-8?B?N090bTlsdHFXRWNkaE5UWm5EdHRwY3J5SDRTdkxza1RtTWRnWFhmMG0rcnlH?=
 =?utf-8?B?RUUxVGRQUkxQdUd1ck9IZVNPcmR0Z3NQVk5rdW1raDNUOEpMTTdKZmlWWDE3?=
 =?utf-8?B?R256YmlNUFJuakxmV1UvUyt5Mnd2dWZRbzRkb25ISE9aQUkzRFkyb25rU256?=
 =?utf-8?B?VE52RTBJTGRabTgra2VlMForYk1QSFV6ckw0c1huMnNSSEk0clpRZ2gxM1J0?=
 =?utf-8?B?T1JDRVZvWGVHSC9KVWZmZjV2UzkzMGN1ajF4U0k3ampzVnZXa0YrSDI4UWZE?=
 =?utf-8?B?K3YremFxenhkaDJ4bzFBdW9uL1o3ampVMWdlT3hrNVZyb2xkUGg5R0QrVGNz?=
 =?utf-8?B?VzFDeDhvS1BwK3A3U09vNGE1b0g3SEg3M3VXN1dmTVFXTndDUTVZaGFIRHgr?=
 =?utf-8?B?TXdMMGJ5emdRSmh3bUluaERYUXJtV2dEU0hweWsyRTdSOGxGdXo5aWJTQ25X?=
 =?utf-8?B?bU8rZjBPcHM2ZkMvSTZXQ09lY0pYZTVXdUFDTHVVQjJ3NXJrU2JFdExVaVNV?=
 =?utf-8?B?a2NIbm5NZkhPQi9pM0IvWnBlNzZnY0RubU5LQ3FNWWM3UlVvSVpoUTVycmNs?=
 =?utf-8?B?WDNoanpaUUhlVWxuMDdIZnk3TEFEQU80ZEV5OWp6VFhwa3F2QnNVWTRHclpB?=
 =?utf-8?B?V29nM05oOHI1MnpNa2NnRENVUEM1M3dLQ1RiWXI0aTU1Z3dkWWo4SjdONDAr?=
 =?utf-8?B?ejA5ZGNTK3h1K292N0tqaTFRM0pIcStqSTR3U1d3TStTb1g1bzFFbnpHUkYv?=
 =?utf-8?B?NWIyT0I2NlA0Z2tybEtjU2ZvRWhhdjNsb3pLVEZJbGpXK2FqVmlvdTJxSWYy?=
 =?utf-8?B?emRLWndLSDAwZm5yTCtnYUZFT3Zhellia3hZQ2VHdHFnWWNERzcvWVNublV2?=
 =?utf-8?B?Q3pWT2k4NzJTanJaYUFKcTQxRU5zRHZrSkIzeU5nYXpZMThodzQ5dEd0MEVw?=
 =?utf-8?B?ODh3d2tKSExYS3J6aXZZTWY0UzZxc2kveFhWblBMYm00NUVNRmJvdmlheTRW?=
 =?utf-8?B?cEdDZXhRcWNQWU8zMjZtYUllWHNQNy9OVlZoY0g1WVhJdnJLSjhuSlNlVlBI?=
 =?utf-8?Q?T8LEqG1KWBe50+Qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee531c26-4ee0-4884-cfb1-08de6d385412
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 08:49:42.8947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY8Pe9/tD36N5GnHvwkqai4ud4mCABUr2I761gBg1cwloiC2pjpClT+bmykQBEOZnGu9J8EzhnoUkWkkwQKZTRkd0UraSMMzDkho0HeSdLIXfuZq8y88MVBx6I5uH70M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB7016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16906-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,huawei.com,lunn.ch,nvidia.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E25FE141AC2
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxMCwgMjAyNiAxMjoyMSBQ
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBsaW55dW5zaGVuZ0BodWF3ZWkuY29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7
IHBhcmF2QG52aWRpYS5jb207IGphc293YW5nQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyBz
aGVuamlhbjE1QGh1YXdlaS5jb207IHNhbGlsLm1laHRhQGh1YXdlaS5jb207IHNoYW9qaWppZUBo
dWF3ZWkuY29tOyBzYWVlZG1AbnZpZGlhLmNvbTsgdGFyaXF0QG52aWRpYS5jb207IG1ibG9jaEBu
dmlkaWEuY29tOyBsZW9ucm9AbnZpZGlhLmNvbTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsgaG9ybXNAa2VybmVsLm9yZzsgaWpAa2VybmVsLm9y
ZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5k
ZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBp
bmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nv
bi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29v
ZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiBuZXQgMi8yXSBuZXQ6IGhuczMvbWx4NWU6IGZpeCBDV1IgaGFuZGxpbmcgaW4gZHJpdmVy
cyB0byBwcmVzZXJ2ZSBBQ0Ugc2lnbmFsDQo+IA0KPiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBl
eHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0
aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIDIvNS8yNiAzOjE3IFBNLCBjaGlh
LXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20gd3JvdGU6DQo+ID4gRnJvbTogQ2hpYS1ZdSBD
aGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gQ3VycmVu
dGx5LCBobnMzIGFuZCBtbHg1IFJ4IHBhdGhzIHVzZSBTS0JfR1NPX1RDUF9FQ04gZmxhZyB3aGVu
IGEgVENQIA0KPiA+IHNlZ21lbnQgd2l0aCB0aGUgQ1dSIGZsYWcgc2V0LiBUaGlzIGlzIHdyb25n
IGJlY2F1c2UgU0tCX0dTT19UQ1BfRUNOIA0KPiA+IGlzIG9ubHkgdmFsaWQgZm9yIFJGQzMxNjgg
RUNOIG9uIFR4LCBhbmQgdXNpbmcgaXQgb24gUnggYWxsb3dzIFJGQzMxNjggDQo+ID4gRUNOIG9m
ZmxvYWQgdG8gY2xlYXIgdGhlIENXUiBmbGFnLiBBcyBhIHJlc3VsdCwgaW5jb21pbmcgVENQIHNl
Z21lbnRzIA0KPiA+IGxvc2UgdGhlaXIgQUNFIHNpZ25hbCBpbnRlZ3JpdHkgcmVxdWlyZWQgZm9y
IEFjY0VDTiAoUkZDOTc2OCksIA0KPiA+IGVzcGVjaWFsbHkgd2hlbiB0aGUgcGFja2V0IGlzIGZv
cndhcmRlZCBhbmQgbGF0ZXIgcmUtc2VnbWVudGVkIGJ5IEdTTy4NCj4gPg0KPiA+IEZpeCB0aGlz
IGJ5IHNldHRpbmcgU0tCX0dTT19UQ1BfQUNDRUNOIGZvciBhbnkgUnggc2VnbWVudCB3aXRoIHRo
ZSBDV1IgDQo+ID4gZmxhZyBzZXQuIFNLQl9HU09fVENQX0FDQ0VDTiBlbnN1cmUgdGhhdCBSRkMz
MTY4IEVDTiBvZmZsb2FkIHdpbGwgbm90IA0KPiA+IGNsZWFyIHRoZSBDV1IgZmxhZywgdGhlcmVm
b3JlIHByZXNlcnZpbmcgdGhlIEFDRSBzaWduYWwuDQo+ID4NCj4gPiBGaXhlczogZDQ3NGQ4OGY4
ODI2MSAoIm5ldDogaG5zMzogYWRkIGhuczNfZ3JvX2NvbXBsZXRlIGZvciBIVyBHUk8gDQo+ID4g
cHJvY2VzcyIpDQo+ID4gRml4ZXM6IDkyNTUyZDNhYmQzMjkgKCJuZXQvbWx4NWU6IEhXX0dSTyBj
cWUgaGFuZGxlciBpbXBsZW1lbnRhdGlvbiIpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlh
LVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+IA0KPiBJTUhP
IHRoaXMgc2hvdWxkIGJlIHNwbGl0IGludG8gMiBzZXBhcmF0ZSBwYXRjaGVzLCBvbmUgZm9yIGVh
Y2ggYWZmZWN0ZWQgTklDLg0KPiANCj4gL1ANCkhpIFBhb2xvLA0KDQpTb3JyeSBmb3IgbXkgbGF0
ZSByZXBseSwgSSB3aWxsIHRha2UgYWN0aW9ucyBvbiBib3RoIGNvbW1lbnQgYW5kIHJlc3VibWl0
Lg0KVGhhbmtzLg0KDQpDaGlhLVl1DQo=

