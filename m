Return-Path: <linux-rdma+bounces-6754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D61F9FCF79
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7B91639FA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864F51C2BD;
	Fri, 27 Dec 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xsU+4led"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7D2F28;
	Fri, 27 Dec 2024 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735263249; cv=fail; b=bXswm6goBbXOQLeTu/pxLEo0IXF5mJDCv8aKGKQaCaSbryIf1dTIIDFl5VTNmjCr6+twJok4hATORXN4+m+lx7rCWaeC29AnF3oFO/bENqXADFfcU1ZHT/ojOjAA2tn+dU74z9BVUCJN+vPClQxgF6Tln20lJ7+ATXzjIYp3nQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735263249; c=relaxed/simple;
	bh=xW0fIoRoa3oKpFA4WNNR0r/X5mXWv3L8IvtJW9XVVYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPewyclTCVbocDgNAacKfqn97cIMPQXTsfqFQWjUKmK/ut1s7eJ2dTDbbZbLZUHYYQyQvPigEAbxaGFCy483XqfiHwl0ecFdS6hsPF/w66nzCVfzMMumC+lLcgYexM6NpZCDD+OSAStR5AdbjWjeGIGD/Tgx9PrqG+6xFxxW7IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xsU+4led; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735263247; x=1766799247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xW0fIoRoa3oKpFA4WNNR0r/X5mXWv3L8IvtJW9XVVYM=;
  b=xsU+4led/ADpkKY+HsfnD2d2tIcjQFCfeuF0GNFp4ncSibnGGTZpkNMf
   mbc7sWjoRHZfVM8SyQl6H2Lp48Bgxai+IpLRqRCquhT08WfPQIpV+aCO2
   elf2iRSxpFGGVla9jbY6MayPBAYir35nhMjODi4fslFLIiHCAARD1xT4L
   3XHIyLUHyeYUDlTO23cm0TRjqNV0TdXkLlm9S39uDrtZ5eWeYzyboZLXZ
   5/G8doF6Px0XVZzMmJRa6tXDTFpVQd4osacyKEh79ziJCMWnklbckxrqt
   4ozVplaU7kqOpZHQ2G3Y2MJxN9o5PmQmQjBynqTvp8o0G0l/qX9bH1UXC
   Q==;
X-CSE-ConnectionGUID: s60h5MIiSu2jrOjPTrubcw==
X-CSE-MsgGUID: wb37+32TQQqH1EsiNqT5Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="52766769"
X-IronPort-AV: E=Sophos;i="6.12,267,1728918000"; 
   d="scan'208";a="52766769"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 10:33:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQucVldMnlM38KZMwbFhznOXxV2P1rl0nxDHow/1+HYG0Qhx7AtEak5yXYsS1PQvEGxJRru2odqxJboU8A4WCS9lPtmpfmSuHMaz4rFRZ5ybnHnU8gLKEmki83E9HIXi4Xx93cJgrn8i5xBO31ejlVUYzEpn/Q2w1YrkLSzDq2RUsIlQBoNzCo1+o9Q5BjZ4EmnkkzqI3zeyBN4ZBFYngoqSw4vdidp0ho2pL7n7KwW0gdPSVNTEeTFe/g4dPD0oZIJA+791jP3eamD3h/DBATp5JSzxYoDmfYGpMAiGAqk8+AbCtc/d089f/mH8r03W447GQTe0eFWoGELF8OO60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW0fIoRoa3oKpFA4WNNR0r/X5mXWv3L8IvtJW9XVVYM=;
 b=TW0dy/Yh9cGqkv3FyyuylW2SwoNqCDq5jzVc5ZgMSrh4/BfZ+Z3DSdQ17yF3BlKbqrVZO0l/Eoej1GyES/BFtTRPexkGtEnvPei5ENyedz5jM8+oK5cl+SScpBmVsz4jhsV6TBFWzA2ur8c7/4Ml0kib0SB6G48uPupFFvrocyWXMSWK308fPrLShYo1gCH4nu81sTXZQfwlAq9LGsK69gOQxyhMXe+kWAADSCNAAS5jBn1pQ1pBa7DJEf1C+oAtWpnRe27Li0lpLJTbFbjglACaGOBPsKRc9Ux+V8vyAVyH+p5GwR8tID+bWh2xUJmqcuJp8DZZEXXkYfgGYHYe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYVPR01MB10734.jpnprd01.prod.outlook.com (2603:1096:400:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 01:33:55 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 01:33:54 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/2] [NOT-FOR-MERGE] just for testing
Thread-Topic: [PATCH blktests v2 2/2] [NOT-FOR-MERGE] just for testing
Thread-Index: AQHbVrDD8O7kFLEkH0q8RnEvpa6X7bL4g4aAgADN3IA=
Date: Fri, 27 Dec 2024 01:33:53 +0000
Message-ID: <50adc0f4-371b-4061-b14c-1ef88cc9485b@fujitsu.com>
References: <20241225093751.307267-1-lizhijian@fujitsu.com>
 <20241225093751.307267-2-lizhijian@fujitsu.com>
 <fzj26m4oig4yd2qffkcz6j5xblpqmcvtiln4d7l5ru2cdizjfs@nxhi2lvif7qk>
In-Reply-To: <fzj26m4oig4yd2qffkcz6j5xblpqmcvtiln4d7l5ru2cdizjfs@nxhi2lvif7qk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYVPR01MB10734:EE_
x-ms-office365-filtering-correlation-id: 08691b92-192e-4587-0c6e-08dd26168632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFZ2N21Kd3BQTXBrWlRpaklQOGJIaWtqVnkxNXNLUW9sWnVQRGViRUtaa0da?=
 =?utf-8?B?MzNjRVZob2l3QkpGVHlUc3ltcGRNOXRMWkdPbGZNV0JmS3RkbFo1VU1OMkNG?=
 =?utf-8?B?R3QwYU12R3hMdFFGTSsvc1ZSTFpEbUU1a3N6UGpBRVRQWnBKU05OeU12cVlt?=
 =?utf-8?B?ZFozbnBQYmJBSEpTRlNGRDFxYzBrQjV5azNYR282ekhxREZYaHE2dGNwdmp5?=
 =?utf-8?B?ZVcxTzRkREZVRE5jV2hrbCtUWW53RVhxR2Q0d0U0cGZUR1JZVExxd0piaTYv?=
 =?utf-8?B?cStoaFlnSnlGTmthUTFqbDJoWUcvb2dhaDZjUHB6VnhCZzZCTythQjJDOWJi?=
 =?utf-8?B?R05FdTlaSDZWcWlEL0Q1ZXpTUmg3NkRadjNqSEFneCt0MjNxNnZ3d1F1UWhQ?=
 =?utf-8?B?c0NRQ1UvdDlVclVMb2VNUWNROHowTmtWZzhuN3ZFWEVWWVBGck1sZWcwMWZ5?=
 =?utf-8?B?MGNneUZkWUkwKzlMbVhpM3Nsc2hnOUtIVDA1Tk9CVXdsaVhoYnUxSnVhSk1y?=
 =?utf-8?B?TjZqdDFDbm5xekRXeHFDY3ZHeUl0U1BhQWwwUnQ4UU80U2hMNExiOUlzbk51?=
 =?utf-8?B?enp2azZZOGFYSEc0djdSY2lSZFc0RUhsd0dySkhVMjdWd0FMajlMaldkRStV?=
 =?utf-8?B?Ri9ySklzK2xGM0lGU3pwR0RmR05rakxKUE9meXQzRU5yRFRWc1RrSm9HTDRJ?=
 =?utf-8?B?RmdWd2QyMjFSVzl5d3F6WlhVV2VSTCtUUi9ST1dXanZGdnJXY0dMYkpwT1RI?=
 =?utf-8?B?aTE3cFJTZm1JRytqZUhGZDY1WFA5czduMHRoMW96MmhPUGl4SnVZOHB1SlZp?=
 =?utf-8?B?T3VwNmY4YjZISk5ubGQ4M0E0dDQ5dUtNMk5LVDNGL2VuY2VRRGtmdTdSZUFK?=
 =?utf-8?B?M1c0MHg0K0RJNklxZ2pielhmZkt1NU5PbGRwZ1JaTGo3RjNPYnNGV2d6YXdR?=
 =?utf-8?B?SUR6UkxCbHZxZVFrelJNbFNKOUljZjN1UHNmaHA5cmhsUkEwNDE4RWZta0ds?=
 =?utf-8?B?Zm9NWmlyK00wZjJTQ0lUVjNscmZVdWVlQ0laQysxWE02M3pka01BRnd0Y2pT?=
 =?utf-8?B?L1ptc1ZZelpFUUNsVHZHUFRMc1dRTUxuVHJ5MVQ0VkhaNmkzZ3Bna3cyR0hv?=
 =?utf-8?B?QVJBU0pOSDRjdzd2QmYzNzZhZnJjYU5jS2NVdjVwT0kwd2VneGp5dkVvMHZ2?=
 =?utf-8?B?dkZJdFlNV0hnaFVSbmNMNTdvY3VkSVJxZEVOUlN4RkZVYVFFOFJKaWNrbXF3?=
 =?utf-8?B?a2JIYVNObGlzejc3em5kMEhENVMrTXBsTlZRb2laNEdqdXNtTFRhS1g5eGpk?=
 =?utf-8?B?cm9HbW9nTnNlRkpWZC9BRWlkaGQzVEpKREZCVFIrZ1NGUVZtRUxuNEliVVV6?=
 =?utf-8?B?WkVoSTd6V01KdHVIeGlTNmltaFpjWVRpK2FnY2lORnlKUmQ0S0hDUTJZTlVK?=
 =?utf-8?B?N2tTUUNBanJ3NmVEaTRmT2poOXRoQWlpcSt1MEhPdDMvSitYaGJnUGE5VWRK?=
 =?utf-8?B?U1VHVk9vOFRheG55dEhwbDZibmNGUElnODZkOWVieXhOM1VudENLaWR5VWJa?=
 =?utf-8?B?dE5SYU11TmI5V29BNkNBRnpsVGNaUm9uSTI0NDZlM1h1REpkcU1rdnpINmlX?=
 =?utf-8?B?djhteWFTMUxsZXh1ck56c21UaVBTNkwvczZ4UVpYSmhQMGIyU2xHVXp5U2xh?=
 =?utf-8?B?VGR6Y0dLT1UzNmlrZmc0VWZheVJJemZqUXduRVVpZ3V5VDhBRERtRzdycmk3?=
 =?utf-8?B?YWhMcUErL3JTZEpPdFBqbG1jQWJiRG9HY2xaRkUyNDloVmZHUDhTazY5djlu?=
 =?utf-8?B?OXNuVzV2UWFDWkhiMVdjY2VVY2JsZDN0QXJncWx3SlpZViszSExzeG9EM21i?=
 =?utf-8?B?SmRUVHMzczhUbnQ1emUxRWg3YXV6YkhyY3l4ZUlPRncyWjhkMUlNbEhTcEth?=
 =?utf-8?B?c1VydTFsdEtLOEovTERXN2VrY1liSGpyRHk5N2RjREptT0VNajdRTFU2djNK?=
 =?utf-8?B?clI3aGg5NmV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0E1SVZtRS9sYnVnRmlxaFBHWi9DWUV5RmxEalZFSk84bDA1YnNVTFVWV1Fz?=
 =?utf-8?B?bnBDT2J4YjZKMHNKckluREFXVlFEaUkwNlMwWUhwTElvU1V3ajVNWmJrTC9y?=
 =?utf-8?B?R2M5SXd1eHdTKzRidWV0RzlBZ2Jad2hic25hK0tJeWFTYnJEVko4Q1JZMFkw?=
 =?utf-8?B?dkx4MmtSZG9meXlwLzRBRjlraGpHREpqemsyckdoQ1NpSW9VNzlvSWVQMWtq?=
 =?utf-8?B?VTRGS1hJSUcwU3I0RVd0OUtUdURaeVJTRlEvVUhPdjRLUllEUithOUEzTklP?=
 =?utf-8?B?a1AzaEFzd1kxeXhWS1BzTDlEVFAvVmVRdm1JdFRHRXNvY3ZsTnRsNnBSWmRo?=
 =?utf-8?B?Rk9wckROQThaMmdoSm51VGVMbE41Z1lRbWZvTGo2NElwaUJvUmhRbU9RRjJr?=
 =?utf-8?B?TXM2OW9YU0VlTWdmaVRETUtFOVJwQ2tlYnhzMFhGL285ekpXbkwvaHd3UFpO?=
 =?utf-8?B?TTVKS1pzTXAzQXZJYVBaL2QvUHpVV3Y1VmpBNVNSZUxKelJFVitydElXcTh1?=
 =?utf-8?B?dzJ0U1cxNGRzQUdrbGc2UUFBMk5BRkJPRWphdFhyeEJqdVltREpoVmRJQmVH?=
 =?utf-8?B?V2MzYjZrZk9FOFRacDdIRFZyV2M2YWUrdldiK3Rsa1pQbHdyR0JBVzZ1Q3hu?=
 =?utf-8?B?OUpYbGNHYWxiUXJabktMZmtrQTJ2cXpXdmFPRFVTRm1hMWlKdlltT3UrNllp?=
 =?utf-8?B?S3J3dHR6OTN2ejJDd1pnTXRhQ2VMVEVKRWNxYVo5Um9CMUxZOUwxNEl6UDlZ?=
 =?utf-8?B?WFVaLzhXVm1VZTFNTnBsbzQ0dVVrLzFTVm9JUnJrUGxvd2RMdHZqV1N5cVZ0?=
 =?utf-8?B?UjB2bzA5cUxOSHFJVkhDK3YvdXZKZ3ROR3FzZlNPc25IY2JkeWcvMjQ0M3pP?=
 =?utf-8?B?R1lkcXduU0NiT0RDczFicW1VRVVVa2RYRXdUN0w0VjU1OFZuck8wSUdaQk9o?=
 =?utf-8?B?U2hQclBJSzhrdWxOanVRc0JTeFdRcTlyU0dNaUp2Ylo3MFlZbmJOZTZsNUNB?=
 =?utf-8?B?OERqZ3k2NWNUTWZ6RURWdHpuRDRRayt3Mi8wUSt4dm10eWE4NWw2SzY0L0NV?=
 =?utf-8?B?emhOemtuOWZFTm1nVERWMVF3U0FaN2Z4TUFoMGtHbDVON1NhdmVTYThQN0dz?=
 =?utf-8?B?MjlFU09CTVQ5MGFxdWhFUlpSUmlqek9OcDFVZWNNQVQ2bjF1dnNYSHhCL0g4?=
 =?utf-8?B?QlV0WFJHbGJhRUhiVzJaUzRYZ3lOWXUvMk5BQWtxVkRGZWJ1MjlKcG5DaGRL?=
 =?utf-8?B?R0JWWEJ6WWpMR0ZxbjBJa1Y4VmMrUjBwYlBkNDBONkxXa2E2ZHNyWk85RUMz?=
 =?utf-8?B?MHJ5eTBRYytaVFhTdlJ5RWRSdUpJa2Z4L3Y2Q3FtcUNKZFNMbXhvdW8xaG9a?=
 =?utf-8?B?NnhpbzViay9MVkVtbUVsZ2pxTmw1SVF3YitYNndySm5SM2lpSTdRbm1zTWcx?=
 =?utf-8?B?RVdRUUhrMFFaMnk3ZVlzVDBJTWxYaU1odC9BOWtOdFZlczFycVFhckdUNDRp?=
 =?utf-8?B?bG9xeDE3U3lYbk5BYU5kSXhnZkFzNG9Jc2M5MzlzRzI2UzZVZjZ2ZXFGeWh6?=
 =?utf-8?B?S3I4YWd1b1U3ZDh6bjZ5aHhqUjIyQzJUNVZPWk1WYzlueFdqNGpNSTduM1hq?=
 =?utf-8?B?SDBYNEpGSktId3ZpTnJIME5HTzRwdXcvQlpVbzBYYkhvT0hCc2hacjJHYXp1?=
 =?utf-8?B?eFJtVkdpZHF3dmhHS1ZoSXFaMXEwYU9qMnNWb2U0dk5YcDl2bzlxdXl3Vkoz?=
 =?utf-8?B?bTRZOVh2KzRTdWh1dmhOM0lBTlIwekJHVnVqWm5YQmp5MWlGWi8rRkN6WkhF?=
 =?utf-8?B?T216TVZOT01MQXNQZkY5TWFBL1J4NjVMVE9rbEpueUJYYnVEZ1RHdjhtUlky?=
 =?utf-8?B?akppRGRZeHR0T2hjOTdyMExPMmNkWlNyMmNlWWJYS01JbENwemtHeFIzQUVQ?=
 =?utf-8?B?V3JrR2l2WlhwZkF3SS9uQWUwVUpManBHYjlQMmRGYUVTajgyQjdOSHhzbmlH?=
 =?utf-8?B?aDQveTBuVkF4Wi94N3lUVHF5TndCWFk0S3IxbE5qaDVxSXdBNXI0ak1wSEl0?=
 =?utf-8?B?emhMc2ZtMGFBRFQyclNkWVBxeWxiNWVaaDZRR0NmSzkwZUk5SHNSVmV0cUlT?=
 =?utf-8?B?NWdPSmw5UmlkZFdqMVZhZ0s3OTlHMUc1aFNVaWN6WEhnTlpSV0pBQXVqcXNP?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98FAB30CE5B2484D836D93F332783BF1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehqxjHONyPwL5Bh5UGrPNNc9poUHgS3vgowjelDWtSZCeu2cpiPlL2X0kmTGjyzyj/oYCbLuioCLZbqgF6mP+NQ0kk+70MSxsnrPUracW2Hstqvc+iCwHuGPretoHBJVQlOT4BRAO8qcDPG0M372Qhan3UudoPJ7vnUqYwzcLzK1HpTQT4ZUOn/2CTQ4bA38jCZYmlYP51cJUNfYn7SY0KVuMOWA9/hdo0z1pmEW8q0CYoNJVhvS886p9g7NaMTXxH2DNM7++UdVup6JObdCS75A+mIkFnHjmP+YgwlSNk2TdPDSYbsXIRypbp1v6zfI3ywzT+lpDjeBETtIZ1iA7z57xlE1JdsEBjmDC4naqfjzCBmKuCo1JwfQNXPelZHwkX1oEGOmuXFUChdEwAriI9vvxp36XQhotiUeXIb9bAlwMGOE5k7k8JlnrQQhpOqDya3GSxJxofCvw20VP73wWclWwvwhPPrZ+BsJ8KKrFkyMBov7ILUHYARDj9zGejvek2YCiDwsG/X9zUdayTSulRG1gVe1SSZKA0AQmWy+JfIrz8Hu9nbDYQjPwOzvMIw2tDOIWb/SDOCTSP0y+Ikrf+pPkm41tGsvLZNOyg6E6MaBpt0+RYFOL3jYIYdF9lbY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08691b92-192e-4587-0c6e-08dd26168632
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 01:33:53.8740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLtY1CC27qs7X7fMT19iPpXLtQW4dE4Y8aKf7E3yEBQhdOSwpxdxEOMqfUjV2IzdnKZKNIs+8rc9vmQfigW5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10734

U2hpbidpY2hpcm8sDQoNCg0KT24gMjYvMTIvMjAyNCAyMToxNywgU2hpbmljaGlybyBLYXdhc2Fr
aSB3cm90ZToNCj4gT24gRGVjIDI1LCAyMDI0IC8gMTc6MzcsIExpIFpoaWppYW4gd3JvdGU6DQo+
PiBIaSwgU2hpbidpY2hpcm8NCj4+DQo+PiBBbGwgeW91ciBjb21tZW50cyBoYXMgYmVlbiBhZGRy
ZXNzZWQgZXhjZXB0IHRoZSBzdWNjZXNzIHJhdGlvIG9uZS4gQ291bGQNCj4+IHlvdSBoZWxwIHRv
IGNoZWNrIHRoaXMgcGF0Y2goW05PVC1GT1ItTUVSR0VdIGp1c3QgZm9yIHRlc3RpbmcpIHRoYXQg
Y2FuIHRlbGwNCj4+IHdoZXJlIGl0IGZhaWxzIGF0IGluIHlvdXIgZW52cmlvbm1lbnQuDQo+Pg0K
Pj4gSSB0ZXN0ZWQgaXQgdG9kYXkgaW4gbXkgUUVNVSBlbnZpcm9tZW50LCBJdCBhbG1vc3QgMTAw
JSBzdWNjZXNzDQo+IA0KPiBUaGFua3MgZm9yIHRoaXMgZWZmb3J0LiBJIHJhbiBybmJkLzAwMSB3
aXRoIHRoaXMgc2VyaWVzIGluIG15IFFFTVUgZW52aXJvbm1lbnQuDQo+IEl0IGxvb2tzIHN0aWxs
IGZhaWxpbmcuIFBsZWFzZSBmaW5kIHRoZSAwMDEub3V0LmJhZCBmaWxlIGdlbmVyYXRlZCBbWF0u
IFRoZQ0KPiBrZXJuZWwgd2FzIHY2LjEzLXJjNCB3aXRoIHRoZSBmaXggcGF0Y2ggIlJETUEvdWxw
OiBBZGQgbWlzc2luZyBkZWluaXQoKSBjYWxsIi4NCj4gDQo+IEkgd29uZGVyIHdoYXQgaXMgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiB5b3VyIGVudmlyb25tZW50IGFuZCBtaW5lLiBGWUksIG15IFFF
TVUNCj4gZW52aXJvbm1lbnQgaGFzIDQgQ1BVcyBhbmQgMTZHQiBEUkFNLiBJdCBydW5zIEZlZG9y
YSA0MC4gSSBhbHNvIGF0dGFjaCB0aGUNCj4ga2VybmVsIGNvbmZpZyBJIHVzZWQganVzdCBpbiBj
YXNlIHlvdSBhcmUgaW50ZXJlc3RlZCBpbi4NCg0KTWFueSB0aGFua3MgZm9yIHlvdXIgdGVzdGlu
ZyBhbmQgdGhlIGtjb25maWcuDQpJIHdpbGwgbG9vayBpbnRvIGl0Lg0KDQpUaGFua3MNCg0KDQo+
IA0KPiANCj4gW1hdDQo+IA0KPiAwMDEub3V0LmJhZA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
IFJ1bm5pbmcgcm5iZC8wMDENCj4gY29ubmVjdCBvaw0KPiBkaXNjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0
IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5v
dCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBv
aw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0K
PiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0
IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5v
dCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBv
aw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0K
PiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0
IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5v
dCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBv
aw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0K
PiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0
IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5v
dCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBv
aw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0K
PiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0
IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5v
dCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBv
aw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0K
PiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBj
b25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25uZWN0IG5vdCBvaw0KPiBjb25u
ZWN0IG5vdCBvaw0KPiBGYWlsZWQ6IDEvMTAwDQo+IFRlc3QgY29tcGxldGU=

