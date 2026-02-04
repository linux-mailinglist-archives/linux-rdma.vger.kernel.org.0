Return-Path: <linux-rdma+bounces-16502-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMOpHiL4gmm2fwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16502-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:41:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03AE2C48
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0833301947B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005938E5E6;
	Wed,  4 Feb 2026 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jlJeMy2b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416F38E5C8;
	Wed,  4 Feb 2026 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190873; cv=fail; b=EsiMk1pCFCnJQDtiAMThgpFwJpStahhB5lmkaMaMsaHcl5U91AWOX6gDYTbwlgY+Kkk/c2SpuZvDHiNUo79V+r5a/36VYLo2R0szxzCUmrlpy/IVV83s6pcXLorSK4QCc8c3gzEUw5PTx+LK9sI6l04zDVKmbgiIVzdOYFqm/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190873; c=relaxed/simple;
	bh=3KSIXAaJP0ZrY/9oPvLessCzy8Y2l5bclfoeeYavOa8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3MBwX7ZAfyDK1QrhZEtkUwFt6i8LWKy7sa7BBGuRqUL5r1o/2J4Qz7Sl6jawZV4M8XC+xONWSCubXr3ByRRrR/5OPPhBVxOiXi21JRbZMaRMzpamR1ph/qsJDgHlBEVRuGKRaDaAwr0IH1k0iFLOrZqtfpp53vpwD/BF4wAl2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jlJeMy2b; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtQDzFRkXRJcXnEWZh1ZBlCYihavU2dk85+5b+V8FbdUosA8CbPJybxxycSTeZ2Hpqes2CHkVRrwqFfedNbhJMe5lxF1wkIKllCL/3A6LFVBFCNhqMuv9xAqHEsD4vrzOyG5PPzZbUafeFI5JxDBcX7rfBjx2dd21BmN1MwsNEZ2k3olpdApFV5nbk0umU6ITXeVk8/lFS+MhTxLJtEJsLo7NVKFuMLQYp5pdXZ4Ztpt0cSgzkbNno4kts9xlpgcCdQAQquZjX7URdRmZxaUByCHlolaMHvT7g9puN0BJI4ieyih7mvIxkcJKbzqp+byggrg88DEDN3tiTNHYNtKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KSIXAaJP0ZrY/9oPvLessCzy8Y2l5bclfoeeYavOa8=;
 b=W2pyAciKZTM3CTXvSm1lBOsMToXVXOf4wlde3nUn1lA1UyZqNZgVp9GnK0Uy9zXpCmyNEsXqUu+86X8nHIE9TTYx31UvYYBiD+zZCd9Ly7jOkdz4dGtXlNm/0Z23YIBZu+q5+YLxgAjJS4Y7twT3NDOLcLDMmFDbmWP7XBNzuFIXms87Z+XYxYZ3IXImySf/loFzvVsZcSrz3E9HbBylKqjVuzkchsSQ8iVC49WESWc8SJNQcRI4r5YsNOzK/lMl6UhIm8s8SPLqSO9ZFGKKTM55+UI2GbANwnuauWXOkCUo/Da9lT5lx+9hSDwQsG4CMAwroQA4eg7mCuZdsF5Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KSIXAaJP0ZrY/9oPvLessCzy8Y2l5bclfoeeYavOa8=;
 b=jlJeMy2bFBD3LFCCe7xfSyCGui3Y6auu17HwSAm0+B0tj42breI0NJ/xRzNMl26QnqKjiHpNMk0Pve2IDzyog3D+9mPyUdI7UI37HyTkhwG2KpC8zAlIGAjniTc1Tw0O+1mFjjINM7przxGfO41lBsVrDmzv4mLLN/AiWNWJEApDtVc0qsSTpfEqJ/sACGp2AMs0eOo+fqjG0t6igQ4jZgVFBIzKfBGmDfHnufc4F678CANdynlFB0bgKPxjATqRCJWtxaaDoXIdeDj2co+z2HG7ouYeDqL3tjblGS68UTvrr8jPIOjCHeyWUohLC60A8Mv6V/A9sCbPDFAaET+XgA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB9975.eurprd07.prod.outlook.com (2603:10a6:102:38c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 07:41:08 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 4 Feb 2026
 07:41:08 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Parav Pandit <parav@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"shaojijie@huawei.com" <shaojijie@huawei.com>, "shenjian15@huawei.com"
	<shenjian15@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
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
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
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
Thread-Index: AQHclSfEqcIInlKmj0Kw5LD8RrSGP7Vx2LkAgABPY0A=
Date: Wed, 4 Feb 2026 07:41:08 +0000
Message-ID:
 <PAXPR07MB7984A4151F79A09D8D418A4FA398A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
 <20260203161126.2436-2-chia-yu.chang@nokia-bell-labs.com>
 <SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com>
In-Reply-To:
 <SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB9975:EE_
x-ms-office365-filtering-correlation-id: ba309143-bae8-4b1f-3851-08de63c0c289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0pkRGsvVmFRY1BqSmtoYktsTGpPR3Q0d0oxWTloQUxVYllhTDZYVFhLS1FE?=
 =?utf-8?B?SWNDSHJhbGRxMjNVUU1pbTBzZDBqWTJQWVJBUW92K1d5RFJ6VXVuZTVhSk1C?=
 =?utf-8?B?VHpxcXVYZDBmYjg3M1N5WCtpeUFZbmlDNzIrbnNyMnNYT1BYaVZtc3laM01z?=
 =?utf-8?B?UWJmUS91QkdNcWdwZFJjOGl6YzEzc2ZQdmpoek5Gd3NiUHowTGVDVHpCNmZz?=
 =?utf-8?B?QXgxeHo2djJ0WXFzZ09tK2VqRXlvdW56MlJUM1cyNURVUDZ2T24xNUEwRTA4?=
 =?utf-8?B?SjdtbTV1NzdENzJRQ2JXVVRGZTR6a0F3U2REVlRnVGlSRTFjNU9uZ2txcVJF?=
 =?utf-8?B?ditrSFVPODh1cHlnTlkvbGRVZjlLN3R3QVdkZHJkNWYzV282S2RGZGRBRWxZ?=
 =?utf-8?B?UEJVaHZPbXdIOGlhRUthcXN6WU16ZFlkSng1UkFnaXBLTFlBNzhWU0Jnam9z?=
 =?utf-8?B?dnNMSWNpck1zT2lpS21hMVpYYmttQS9YZGh5bEFDbFRpaVFscjJXbkRxZnJa?=
 =?utf-8?B?VS9GY05oMG51emROTXBCeXdvb0hLRFg5WnMzYTI5aXIybzRQaVFaODJlc2tH?=
 =?utf-8?B?dlNYSkFWRUdZOXlzai9XeHd0aVJIRU1UZElaR3BMUnFCV01RZVQrSGlEWjds?=
 =?utf-8?B?MU5tQ3l4Rk43cFU2RDhoOE9EZng3NmRjaEdiYUo2YmdTMUlKc3NBSmxoczdv?=
 =?utf-8?B?dW1NNlptbG9XWHJVQjJtc2dyekN0QW1sVTI1bTJVd0hTVFhKbklYSm1xeFFW?=
 =?utf-8?B?aFJCTUZ3ZkxJR0hjb2pJdlVLUXdDd3VBMWRYeVFRZFpNZFlnQVc0Vyt6S2F4?=
 =?utf-8?B?UnBXMW5PdkNhQi9zV1RwNVYzVjJhaU5tdVZsNUloNGNPeThLcFo3VmRCMnh5?=
 =?utf-8?B?SFhYK05PMXZSeVRZNVZtN1VrRFhjdSs0Tjg2SkxZTVo3a0tsRFVQVFZpMU5x?=
 =?utf-8?B?SUFPVG1qcWNnUEg4R2szbVZqYkQwRDc4dG9xVGN6QXZCVk9ZZWlMOHltQUtj?=
 =?utf-8?B?YUNTNWJ6emRQU2JCSWlKOU4reUpGdHVRWWFaZXNiemZzeVY5bWJrLzVRV1BE?=
 =?utf-8?B?ZEJ1M0FlMGNIL3RpUWQ4ZVgwVnhpSjBpTDhDSTBIVU9VcVdlZjRKMGYyL28w?=
 =?utf-8?B?S0EyVlB0YlZYQXdSVTMzOEdRNGFsTlBFdDdxeTh2b1czYys5ZXZUVU5lS1Qz?=
 =?utf-8?B?NzBSMFJwSWQ5YnV1QUFOT3B5eXlPNzlPUjhUaVVhcElrRzE0OGxhWHQwOWtX?=
 =?utf-8?B?dEdZZm9aaGVzakpSU1dlOUh0VlNaMWJRcHRsMDZXVWR0Q3podmpRL3BMYWhK?=
 =?utf-8?B?eld1ekNPaHo4WE9YZXZILzBMWEhzNk5rbmdFZm96QVpwcUM1eFJEbFBCK2hu?=
 =?utf-8?B?NGNkbWNlYkRpVC91UlJ3bWNhNFBYTEROMXZibWZyQmtyT3NqbkZjd0dNUTFI?=
 =?utf-8?B?QVBGWkZucmFqalRwUDYrSEhWTll0Zmd2YlM0UmgvZGYwZU1HaEdqWVFWNjBj?=
 =?utf-8?B?bFo0MDEvNmZwZ1hNLzlIUlY1U1h0U2t4b0pLZUI5bUpIN3cvQnRycDlWeFMy?=
 =?utf-8?B?bDZ1b3BEMnBLZXdnMkxPZC93eTJUZmRFOHRUUk8yNk5HQW50c0d6ODFtQVl5?=
 =?utf-8?B?SjVGTDd2WkU4ajNxckVsRHhZa1JIaUhPdjRHeGpYRExscmZQbmFkbnExbFdk?=
 =?utf-8?B?U2ZhNS9ETnRVSFBzN2xjZ2RGRjVuWUdUcTNLTEp5RDdXZkNWMXZTUEIwMXRO?=
 =?utf-8?B?bHEzMDBaNFFESURpeTlTeGYwby9xcW92cENSaTQ5TTFUNVgrUC9Ka3RwQ1Nu?=
 =?utf-8?B?WDhDaHJTQjg5d0laYWpwbWx1NjVpWjZmN09pcjhFR0M2WEM3UnZBaGZsYk8z?=
 =?utf-8?B?cHZvSDdDekFCSk5rL2lDbGdDVWhTTi83YkV4enRZTVI3MzBCaTVLNUhyeFYw?=
 =?utf-8?B?TmhONHJ0L1I0QXFKYUF5NmJrbjF1ZDBWR3ZpUE5YaU80cFpMNnNGZ1VadkNI?=
 =?utf-8?B?RWE1NFJwcVQ0QXBxODBkTXpIakZIRTYzdlNuUUd5ajR2RFkrTkJsRXFST0Ra?=
 =?utf-8?B?NGtKTHZpcFo3Mi8xTWdwek5JUHpzR1huNkxha0NpVWhEeVVoMmlHSEMydEZs?=
 =?utf-8?B?UjE1NXR5bmVrbVVxdlVualpUMjh3a0JjRE5tSWYwaGdmSU9KYWRFcTJsSy9o?=
 =?utf-8?Q?45nLbwuEIh9wbnve+RC9PljA/v1nvejP1AWyk3ie/Gcs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUtsRXVISjFPWXM4ZDRYelk1Y0JTd2d0N09DRUVtSHp6TWRnbzZib0JPazRD?=
 =?utf-8?B?dS9uaURBK3NLTndjb1pxaVJFUGdDblBZVUdOcEI4M2ExSldPYXREcGpHWTIr?=
 =?utf-8?B?SlpFN0VlcEQrM3JHRWFLNGxtTHFlU0J6M3NqVDFLMUI5S3lycDJhWlRlT1hG?=
 =?utf-8?B?blprcjl0Zmd5dDN1bnZic28yY3NJd00xeGJ3K3hoMzZFMHp0TkFGN2pEZG9j?=
 =?utf-8?B?bHdxTXZHRmpoSWZveHlzeFNydkYvZkdaemIrejhoOWNSVEpjWlZkWTlHRmlQ?=
 =?utf-8?B?RllTSU9QeVJvWnYxTExzRDRZeUFIelZlajhWTjhldWRlOTA0bElYSnVKb0E3?=
 =?utf-8?B?RFJ1R05mMGVnNXRXVkxOVEZKc0tzdW4rNnNjMXRoT0ViV1lGNWh3akFJRith?=
 =?utf-8?B?cTdiYkxCNyt5eSsrNTJtWXlnTS8xTzNWNWFpTFRzcm9hd1AxcFlBWVJVMndo?=
 =?utf-8?B?SWNpRFAvYVc3TStia1pLRDlRT1l5UWVnNFB6VW8wUUoxcDRwREFwWFFmQU5G?=
 =?utf-8?B?TmpVWm5XVy9QUVNjNm1RbFY5R2hTd3hlTTdNbWhoYlZIVkNGSzNMZFVyMStk?=
 =?utf-8?B?MkV2OWFyYWd2bW5oRkVaTWRnc2JVVGJpL0pTV1lVamhqOUoxb2RaQmh2bWdJ?=
 =?utf-8?B?UXVxWHIrN3FwdnNsS1MzVC9ISWtSQ2ZIUDhOcDRMNWpGdkJoR29Gb0ZRT29t?=
 =?utf-8?B?djhCNkxvNHp3NHNpYk9IL3lRQWRJeXltNUkvSU90aHExNmY1QWEzYjRuTW9M?=
 =?utf-8?B?OU1OZlljd3k3QlJqR2pFc1pCcjd3SDR5YlZraHl5OWhDMkczRFJvczBlOFBi?=
 =?utf-8?B?NFRWWmtsK3p1Lytxck14NFR3ai9Sbkc0QW1jMnlaMDNheXZ1cFFNaEhrc1hq?=
 =?utf-8?B?VGhpSGgxa2I3SEF6dTVUVjFJYmdwZ2k1dERZcDRMRjlQNGFqaURlU3FHUnA2?=
 =?utf-8?B?bnc4K1JOV0hRZ1F1YldzUFJoeXM0eU91WFRwVXloWjlJbFk0ZkFtTG5VS0h6?=
 =?utf-8?B?azQveHdoSmhDczZjdmkrNTFVSmF3a3pzSTczU2VxUWlTTklsczVKdEx3cU1J?=
 =?utf-8?B?b3NRYWh2WGhYR3JnTlRSWFFEbmpYbS9IY2d1Z2xhY09abGNPczNJZXpNVlBl?=
 =?utf-8?B?ZXEvQ3ZRVTVNc1lGeWtZYU5SVC80d2RBNGtkOE5wa3k2ekJycnJpZkVxVEI5?=
 =?utf-8?B?Vjc4clhrdjQvbUFBR2xIRWlxYyswS0ZFOFNoL1FZN2hzUGZhN0RXc3FxWTRp?=
 =?utf-8?B?TkRhVlhkbFgxcXBRZ1hrV0NadnRKeEhGVElxcjFnZmNoQnpXdTZxYmQvb1Bx?=
 =?utf-8?B?REE4Qm0vZzR4bXU3Z3JLR1JHVWNaemoxZmp5S20rUWRUcUp2aDYrNTQzUXpT?=
 =?utf-8?B?NzVzUjQrQkJCYlZjYlBIcUV5SXVhaDFMK1czNU1zbkUxclhsMUJIT1ZKeTd1?=
 =?utf-8?B?azd4REg0ZGczQmhUYnJ2Y2p6ZCtmaGlEaWtMczNCVEdlQ1ZQY0tzWm55ZG1r?=
 =?utf-8?B?ZE5HY0Mrd2V4V0dkZ1J3REtENkMreHN4SkRUVy8wTmswdjI1Vkc1amg0VTRn?=
 =?utf-8?B?VTA5TjdrSnF1ejNUMGNONkdBVFQ5bGVhbHViZFE0Q095Q2JYSTE1eE5yYXVp?=
 =?utf-8?B?T2RsTklIeDE3T2dwMHlaempGaFRURjZ4QXg3QXhicEU0RVZGYlZSSFUxQ0Vr?=
 =?utf-8?B?OG1MNk5BdEJSenJZOElEbVlNLzVkV0E4aitNY01EVXZtUkVQQTZDQ2QvNEZY?=
 =?utf-8?B?WEhMVmYvYllPZzBQMFZTYSsvUnkxYXlRYjFWS3MyL2c1Y2hLY3J3ZW5xaDZo?=
 =?utf-8?B?a0oxbkZkRHordXlCcUJ2K04xaU5ZQXowZDRIVlMzL2Z4UmZTeG8zTFJzYytF?=
 =?utf-8?B?WTdvdm9sVnhMYnlJalFsNzdkWDQzbCt0d1NKYzZpZmI3dlBBYzk0ZXJqZUR2?=
 =?utf-8?B?WGhuNnluS0lvQ2lRQThpR2ZmZDVrV0FpZVlPb3JUdmt2U0tadmFkdkFEa1R0?=
 =?utf-8?B?dXJMT2YvRStadVRuaE45aEhmRkR1dVVYZW9ST3gwODdHcFFUcUtoNlRidDdK?=
 =?utf-8?B?bWJ0V1JnRnk0L3JQcDJxc1M5bHlnQ1oyd1FOK0RZZGJxcHdlUk5YZTdQbis5?=
 =?utf-8?B?dk03N0FUeDdRdHhlbE5lczlLdjRSSWNDUXBiMkwzU3N5UUlqQzNRbno1eldP?=
 =?utf-8?B?MmRtZmZkNkpBcXBLTGpDcVdFaUdNZ0FiYWhYTHNXcFQrQWtRdVMzVkZYUDJK?=
 =?utf-8?B?eTE2WkVjSnE4UHNoaWZjQ00vQ0RWbmFKeGFSK1hQNGR3c2F1WXpVbVNXOUdq?=
 =?utf-8?B?aE51cGFYR09mUU5NbUFHQkNCVXNBQWpWNjRkYzFuZ3JQa2tLRHVRaHJSanEw?=
 =?utf-8?Q?FIO03kxTZ0qL2TWM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba309143-bae8-4b1f-3851-08de63c0c289
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 07:41:08.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElzHBHOTXOGgqQ3uPhCVoapwyFxOw+9Y0tGbYT7w0oKKANgD/sjfllBrfZPO3lwyN5XUvEzoOAIaL/ATZlP6QJQUJI7qEOEFdoSyU6g4jeL7t9EUAbjUcdw2eH6COTmm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	TAGGED_FROM(0.00)[bounces-16502-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B03AE2C48
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXJhdiBQYW5kaXQgPHBhcmF2
QG52aWRpYS5jb20+IA0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDQsIDIwMjYgMzo1NCBB
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlkaWEuY29tPjsgbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7IHNoYW9qaWppZUBodWF3ZWkuY29tOyBzaGVuamlhbjE1QGh1YXdlaS5j
b207IHNhbGlsLm1laHRhQGh1YXdlaS5jb207IE1hcmsgQmxvY2ggPG1ibG9jaEBudmlkaWEuY29t
PjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsgbGVvbkBrZXJuZWwub3JnOyBl
cGVyZXptYUByZWRoYXQuY29tOyBicmV0dC5jcmVlbGV5QGFtZC5jb207IGphc293YW5nQHJlZGhh
dC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsgbXN0QHJlZGhhdC5jb207IHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1z
QGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGdvb2dsZS5jb207IGJwZkB2
Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBnbWFpbC5j
b207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3b3JrcGx1
bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51czsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdt
YWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2Vy
bmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsg
bmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9z
Y2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdl
bWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5j
b207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBj
b21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2
MyBuZXQtbmV4dCAxLzNdIG5ldDogdXBkYXRlIGNvbW1lbnRzIGZvciBTS0JfR1NPX1RDUF9FQ04g
YW5kIFNLQl9HU09fVENQX0FDQ0VDTg0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0
ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBv
ciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlv
bmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiA+IEZyb206IGNoaWEteXUuY2hhbmdAbm9r
aWEtYmVsbC1sYWJzLmNvbSANCj4gPiA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29t
Pg0KPiA+IFNlbnQ6IDAzIEZlYnJ1YXJ5IDIwMjYgMDk6NDEgUE0NCj4gPiBDYzogQ2hpYS1ZdSBD
aGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+IFN1YmplY3Q6IFtQ
QVRDSCB2MyBuZXQtbmV4dCAxLzNdIG5ldDogdXBkYXRlIGNvbW1lbnRzIGZvciANCj4gPiBTS0Jf
R1NPX1RDUF9FQ04gYW5kIFNLQl9HU09fVENQX0FDQ0VDTg0KPiA+DQo+ID4gRnJvbTogQ2hpYS1Z
dSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCB1cGRhdGVzIHRoZSBkb2N1bWVudGF0aW9uIG9mIEVDTuKAkXJlbGF0ZWQgR1NPIGZs
YWdzLCBpdCANCj4gPiBjbGFyaWZpZXMgdGhlIGxpbWl0YXRpb25zIG9mIFNLQl9HU09fVENQX0VD
TiBhbmQgZXhwbGFpbnMgaG93IHRvIA0KPiA+IHByZXNlcnZlIHRoZSBDV1IgZmxhZyAocGFydCBv
ZiB0aGUgQUNFIHNpZ25hbCkgaW4gdGhlIFJ4IHBhdGguDQo+ID4NCj4gPiBGb3IgVHgsIFNLQl9H
U09fVENQX0VDTiBhbmQgU0tCX0dTT19UQ1BfQUNDRUNOIGFyZSB1c2VkIHJlc3BlY3RpdmVseSAN
Cj4gPiBmb3INCj4gPiBSRkMzMTY4IEVDTiBhbmQgQWNjRUNOIChSRkM5NzY4KS4gU0tCX0dTT19U
Q1BfRUNOIGluZGljYXRlcyB0aGF0IHRoZSANCj4gPiBmaXJzdCBzZWdtZW50IGhhcyBDV1Igc2V0
LCB3aGlsZSBzdWJzZXF1ZW50IHNlZ21lbnRzIGhhdmUgQ1dSIGNsZWFyZWQuDQo+ID4gSW4gY29u
dHJhc3QsIFNLQl9HU09fVENQX0FDQ0VDTiBtZWFucyB0aGF0IHRoZSBzZWdtZW50IHVzZXMgQWNj
RUNOIGFuZCANCj4gPiB0aGVyZWZvcmUgaXRzIENXUiBmbGFnIG11c3Qgbm90IGJlIG1vZGlmaWVk
IGR1cmdpbmcgc2VnbWVudGF0aW9uLg0KPiA+DQo+ID4gRm9yIFJYLCBTS0JfR1NPX1RDUF9FQ04g
c2hhbGwgTk9UIGJlIHVzZWQsIGJlY2F1c2UgdGhlIHN0YWNrIGNhbm5vdCANCj4gPiBrbm93IHdo
ZXRoZXIgdGhlIGNvbm5lY3Rpb24gdXNlcyBSRkMzMTY4IEVDTiBvciBBY2NFQ04sIHdoZXJlYXMg
DQo+ID4gUkZDMzE2OCBFQ04gb2ZmbG9hZCBtYXkgY2xlYXIgQ1dSIGZsYWcgYW5kIHRodXMgY29y
cnVwdHMgdGhlIEFDRSANCj4gPiBzaWduYWwuIEluc3RlYWQsIGFueSBzZWdtZW50IHRoYXQgYXJy
aXZlcyB3aXRoIENXUiBzZXQgbXVzdCB1c2UgdGhlIA0KPiA+IFNLQl9HU09fVENQX0FDQ0VDTiBm
bGFnIHRvIHByZXZlbnQgUkZDMzE2OCBFQ04gb2ZmbG9hZCBsb2dpYyBmcm9tIGNsZWFyaW5nIHRo
ZSBDV1IgZmxhZy4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogSWxwbyBKw6RydmluZW4gPGlq
QGtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5l
bC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bu
b2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gLS0tDQo+ID4gdjM6DQo+ID4gLSBVcGRhdGUg
Y29tbWl0IG1lc3NhZ2VzIGFuZCBkb2N1bWVudGF0aW9uIGZvciBjbGFyaXR5DQo+ID4gLS0tDQo+
ID4gIGluY2x1ZGUvbGludXgvc2tidWZmLmggfCAxNSArKysrKysrKysrKysrKy0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1ZmYu
aCBpbmRleCANCj4gPiA4YjM5OWRkZjFiOWIuLmM1OWYwY2U0MTRkOSAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmYu
aA0KPiA+IEBAIC02NzEsNyArNjcxLDEzIEBAIGVudW0gew0KPiA+ICAgICAgIC8qIFRoaXMgaW5k
aWNhdGVzIHRoZSBza2IgaXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLiAqLw0KPiA+ICAgICAg
IFNLQl9HU09fRE9ER1kgPSAxIDw8IDEsDQo+ID4NCj4gPiAtICAgICAvKiBUaGlzIGluZGljYXRl
cyB0aGUgdGNwIHNlZ21lbnQgaGFzIENXUiBzZXQuICovDQo+ID4gKyAgICAgLyogRm9yIFR4LCB0
aGlzIGluZGljYXRlcyB0aGF0IHRoZSBmaXJzdCBUQ1Agc2VnbWVudCBoYXMgQ1dSIHNldCwgYW5k
DQo+ID4gKyAgICAgICogYW55IHN1YnNlcXVlbnQgc2VnbWVudCBpbiB0aGUgc2FtZSBza2IgaGFz
IENXUiBjbGVhcmVkLiBUaGlzIGZsYWcNCj4gPiArICAgICAgKiBtdXN0IG5vdCBiZSB1c2VkIGlu
IFJ4LCBiZWNhdXNlIHRoZSBjb25uZWN0aW9uIHRvIHdoaWNoIHRoZSBzZWdtZW50DQo+ID4gKyAg
ICAgICogYmVsb25ncyBpcyBub3QgdHJhY2tlZCB0byB1c2UgUkZDMzE2OCBvciBBY2NFQ04uIFVz
aW5nIFJGQzMxNjggRUNODQo+ID4gKyAgICAgICogb2ZmbG9hZCBtYXkgY2xlYXIgQ1dSIGFuZCBj
b3JydXB0IEFDRSBzaWduYWwgKENXUiBpcyBwYXJ0IG9mIGl0KS4NCj4gPiArICAgICAgKiBJbnN0
ZWFkLCBTS0JfR1NPX1RDUF9BQ0NFQ04gc2hhbGwgYmUgdXNlZCB0byBhdm9pZCBDV1IgY29ycnVw
dGlvbi4NCj4gPiArICAgICAgKi8NCj4gQWJvdmUgcGFydCBvZiB0aGUgcGF0Y2ggYmVsb25ncyB0
byBuZXQgd2l0aCBGaXhlcyB0YWcuIE5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMgdG8gaGF2
ZSBmaXhlcyB0YWcgZm9yIGNvbW1lbnQuDQo+IEJ1dCB0aGUgbmV4dCBwYXRjaCBvZiBobnMgYW5k
IG1seDUgc3VyZWx5IG5lZWRzIHRvIGhhdmUgRml4ZXMgdGFnIGFuZCBpbiBuZXQuDQo+IFNvIGNh
biB5b3UgcGxlYXNlIHNwbGl0IHRoaXMgcGF0Y2ggYWxvbmcgd2l0aCBobnMgYW5kIG1seDUgcGF0
Y2ggaW4gdGhlIG5ldCBicmFuY2ggaW5zdGVhZCBvZiBuZXQtbmV4dD8NCj4gDQo+ID4gICAgICAg
U0tCX0dTT19UQ1BfRUNOID0gMSA8PCAyLA0KPiA+DQo+IA0KPiA+ICAgICAgIF9fU0tCX0dTT19U
Q1BfRklYRURJRCA9IDEgPDwgMywNCj4gPiBAQCAtNzA2LDYgKzcxMiwxMyBAQCBlbnVtIHsNCj4g
Pg0KPiA+ICAgICAgIFNLQl9HU09fRlJBR0xJU1QgPSAxIDw8IDE4LA0KPiA+DQo+ID4gKyAgICAg
LyogRm9yIFRYLCB0aGlzIGluZGljYXRlcyB0aGF0IHRoZSBUQ1Agc2VnbWVudCB1c2VzIHRoZSBD
V1IgZmxhZyBhcyBwYXJ0DQo+ID4gKyAgICAgICogb2YgdGhlIEFDRSBzaWduYWwsIGFuZCB0aGUg
Q1dSIGZsYWcgbXVzdCBub3QgYmUgbW9kaWZpZWQgaW4gdGhlIHNrYi4NCj4gPiArICAgICAgKiBG
b3IgUlgsIGFueSBpbmNvbWluZyBzZWdtZW50IHdpdGggQ1dSIHNldCBtdXN0IHVzZSB0aGlzIGZs
YWcgc28gdGhhdA0KPiA+ICsgICAgICAqIG5vIFJGQzMxNjggRUNOIG9mZmxvYWQgY2FuIGNsZWFy
IHRoZSBDV1IgZmxhZy4gVGhpcyBpcyBlc3NlbnRpYWwgZm9yDQo+ID4gKyAgICAgICogcHJlc2Vy
dmluZyBBQ0Ugc2lnbmFsIGNvcnJlY2VuZXNzIChDV1IgaXMgcGFydCBvZiBpdCkgaW4gYSBmb3J3
YXJkaW5nDQo+ID4gKyAgICAgICogc2NlbmFyaW8sIGUuZy4sIGZyb20gdmlydGlvX25ldCBSWCB0
byBHU08gVFguDQo+ID4gKyAgICAgICovDQo+IEJldHRlciB0byBoYXZlIHRoaXMgY29tbWVudCBu
b3QgbGlua2VkIHRvIGFueSBkZXZpY2UgdHlwZSBhcyB2aXJ0aW8tbmV0LiBJdCBjYW4gYmUgZnJv
bSBvbmUgdG8gb3RoZXIgbmV0ZGV2IGFzIGdlbmVyaWMgZXhhbXBsZS4NCg0KSGkgUGFyYXYsDQoN
ClN1cmUsIEkgd2lsbCBzcGxpdCB0aGUgbGFzdCB2aXJ0aW8tbmV0IHBhdGNoIGludG8gaW5kaXZp
ZHVhbCBzZXJpZXMgaW50byBuZXQtbmV4dC4NCg0KQW5kIHJlLXNlbmQgdGhlIGZpcnN0IDIgcGF0
Y2hlcyAod2l0aCB0aGUgc3VnZ2VzdGVkIGNoYW5nZSB0byBub3QgbGlua2VkIHRvIGFueSBkZXZp
Y2UgdHlwZSkgdG8gbmV0Lg0KDQpUaGFua3MuDQoNCkNoaWEtWXUNCg==

