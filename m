Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56119484C3E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 02:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiAEBua (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 20:50:30 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:42309 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236962AbiAEBu3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 20:50:29 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 20:50:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641347430; x=1672883430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0hZ+7rf0wmLpvjHs1C38qmStYfIK5cBPaDqsK1tBiI8=;
  b=SCPlDEzoG8yM+7m8jwgLKu9fjd8UcPo4GQ+cGWWzos7HKo5NtLXErkjs
   tSwPR3YTmBFj7hh0QINXV0PDDeN6+GqdDprtJttZHtPDLarYM2EFfnFD8
   JOykyFAGsT4lcpWVqElr5QEsIRbtEbF+vbxWCwLcqyGQYJrlfGPJ7mOgI
   mzifCvo5kWIGjxqn7MlJUsf5SdHwTuy0h0is5l0FOLK6SjElgc/lM7Uhz
   toKF34GcM8h3yAOg8IcAKCXFi5e0SAsCkpyjTAtJCyKoqwEmmuTh302ZE
   hj9fUkX2KFrtB+Xsl4DQUj3FXgjT6RBWfeSnj+ovMMDb/vbtoRN0JO7GA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="46888061"
X-IronPort-AV: E=Sophos;i="5.88,262,1635174000"; 
   d="scan'208";a="46888061"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:43:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOjJ0noECtKYZY44TqpbDn66mu1wFxtkRlI/PX0XiCRFeFLB/d99blWyBzQBjKW3/chPvdfQfyLhytKcD+GkFAfIKA6o1VUaa14XREXpJcSkyuZ+WEcYuOABNbwp/KLjlSwDE261gC0oLPCgHnzLT3W5ksXfa4YDKHTW81zbcc6R7QphG/rTMwwZC8wl1SGNQRZXi41c5tu0TTEOWAVt5MdrRRNhvR7iuGerfDkPZkq3F2K4IAkyI12PT/LLh7uwMDQGAjck9iiIV1MrcYmTh0Bn21V7JyW1ndTAp120MjjZ4BKOhcw6LHHDhD6NPrzDYdIvYYK+5EZlFHOyKEtSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hZ+7rf0wmLpvjHs1C38qmStYfIK5cBPaDqsK1tBiI8=;
 b=kEzbn3RcJtSzmnTkjLJ7prq9lWTE4Xp5GTv7bET24VW9ZQUR4p1xznRS7IN1gOm2kzDJCxfPrRLoiszpGTF9lDQQ45JJ5nqx42YQsBSAp45oWnxrueQEvyarvWd9GEEGQ6SxVI7zel7CbwLtFODwf9bATgp7RDsly86T4+XEYWlZbsIhpZQIfeb4GbDe4RbZ2zkGNlWibNpTCvINKoGjzLfj2Jq2dDnc6O3LPuhXS1AbePsqtTyb1/qOWCZuai5vRWv2O3lYaG8++BU6DYKHKkU5qT6tlIbxljNvw3UBphKJeVH2oA+OHhpaPneZuqmuoVmUurmWBGuxHiGb6YqmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hZ+7rf0wmLpvjHs1C38qmStYfIK5cBPaDqsK1tBiI8=;
 b=ZvchLojtC1P4qy0xmhH5g9d4pk6kfOp3vS88RCnpNGgXS1aSYdRyg7DrHZDCZ2d/xGlciTc/pVMmc3YIXN2CTv3+MYtauNGXRGQ/rgGX/5F56WqS8c5sNz/wRs1QSfrNA4HrI6e8qbgn53nk1hrgRFM47a6CGnYKVgWa66MVNOs=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB8222.jpnprd01.prod.outlook.com (2603:1096:400:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 01:43:12 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Wed, 5 Jan 2022
 01:43:12 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xTHASAgACXtIA=
Date:   Wed, 5 Jan 2022 01:43:12 +0000
Message-ID: <d78ef78d-4a57-16cf-00d0-9b129f1eaad4@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <40fe1dc1-1ef6-63cd-267b-21f7498cd203@talpey.com>
In-Reply-To: <40fe1dc1-1ef6-63cd-267b-21f7498cd203@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382126e8-4ca4-4649-844f-08d9cfecbc19
x-ms-traffictypediagnostic: TYCPR01MB8222:EE_
x-microsoft-antispam-prvs: <TYCPR01MB82224951BE6FE3760F64BE99A54B9@TYCPR01MB8222.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:181;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUfI+meQA7CTDAAUbStlAt73u6Rd2DXm8HPJdOMPTUasRcBHNip008305Gi5+vJ3R93WUAzM9Tz2RDJQ8iP22ZOFPHCijARgFHvM8yUQ1oOGIJjkjnq2taXnyc1vg13xRG0NXlAWesfU132SrK/h3GSTs08zdpVJanqV4B7PrOdqs4H9hD0wMk/ckx9lG/emU45CKp4ntEE+q/P6ztrOUV5HXBwikMguKAY+HMBFs6bqoNKOtu+ecGiB0KToGMrCDwxSQHEJJSQ6UFTgqFSXC8s0qiEVHVg75GerVS7fzp8Nd8qJYit7NErKFslwLReOScrW48lXkreo4/kmFFAfAdR6SSqGy7rVaGdpKZX5X9Ij4Nu8Z6zpk1fE5BTYA6uThbs22BpPbKuvHzY9ijgLzk6u4ZLlUHVPozj+JiU4auXfjY/0eyUu3UjphldWDPDzJif9DoEgC7RUt3/EjmxP/UGnLHIIBOv0QiqjJGgkT167V8oSnoXsMrOoTQOmUeR2Jb4Nxpxz+RIxw0OqMr4NWjltZi++e5xPHlo8NZQNyyE3xaBr5BjsTvno2J5VVbYbiP3UwmokZVKJck0VjmQ7SUNaWJkFAaNgcNvwxUaG4vQi8sDf+0Y/l2V5oSeNAEBTGTTiT0g3mxkkV3CcZrmvmEAjDhh1yotawZW3uVUwodZ4H+1qmcqmYuxFvlHHFAGG82cWz676bkw+VF1ISFI1Uros1GyNX9Q1+e0SU5WPaToM3lHGkI3mJI7FfU5JAJOTHdFBTHVB4c/lHdCDPqIgN7r+HjZCB7N/InfCj3TiaPr1lTkEndJWR7p3G24MJGDBfM3Dgnzyd7PAZPqTeG+Q/PDwIXVfREFmIzyrcLsgOMYzGVqKVlIsFiYiEwY9IJBmYhQxm+o0RN4oO2wfUPB0dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(6486002)(66446008)(66476007)(186003)(64756008)(2616005)(316002)(86362001)(66946007)(107886003)(6512007)(31686004)(66556008)(76116006)(5660300002)(36756003)(2906002)(26005)(53546011)(8936002)(6506007)(71200400001)(110136005)(7416002)(966005)(4326008)(85182001)(8676002)(508600001)(122000001)(38100700002)(31696002)(82960400001)(83380400001)(54906003)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhXdEt3b2ZuK1BOZTQ4ektYVkJmNnB0RDhsTnVZYTRwVTJUamo0c2xtcG5n?=
 =?utf-8?B?cWVWZ3hpYks4bFo5eEdtR0RxK3pjbVVaZGU2bVZFbm5idi9OU09EeEVTUWs1?=
 =?utf-8?B?N3JIdzc3UUpuYzdMMnRKT2gxZnBnNWlsN2hGaStHZDhIZkxNeGZWeDlZMjdm?=
 =?utf-8?B?amR6QTJYSUdlTVh2UzlsZDVXa1ZobXdwQks4UG9uOTZzYXBLbnJ0cVVwZ2pQ?=
 =?utf-8?B?VGpIRkJYUE5XblJiQUlZdnlSUmg1MTNVeU1xb1FmbFEzR3JyOW1RMUhIcS9I?=
 =?utf-8?B?VzNkcCszc0VjSDlVZnZqVytsZlJnZmc5Sk1qZGc4TSs4K2sxZ01RZ0V4THQw?=
 =?utf-8?B?c2VERExrZXk1S3pEVDQ1MERKWjNqMTdpMU1wb0VGd0JVS1ZkZGJZTUZ3WUd0?=
 =?utf-8?B?Y2xtM0g2dktiTkdLeDBHcXBCbk9yLzZIeHRLMmtIZitKSDJPOHo2YzdNaHlH?=
 =?utf-8?B?SXMrVkFTQjVxK1paYlZxcEkxWklGK2RVbWRpVlBKalBmNHEreVpuNjRGUCt0?=
 =?utf-8?B?WXV2WGxtblE0VW13M08vT0d5bWlnbHhLTXNLRmNsQ2h4OEtOQ3JxcHFNSDIw?=
 =?utf-8?B?UjgvTkgxV3dUdGI5NTRJNzJMRWczTkZlNVUyWTJmTUhEdlZCR1lTR21KWVQr?=
 =?utf-8?B?d0txTWRPM00wMVVxUVVTSFNpS0huMjB0alZRWk5vMTNIaE9va24wSFZRaGg2?=
 =?utf-8?B?dnFobnVWUDd3Nm10OEU0RHBPcGs5QWpCNEhjaDJxMWRJUGxsMnUrWUdtMzRQ?=
 =?utf-8?B?QWNRaXgwbDNZeGdXRG9DOWRTVU9BQk1lb1V4d3VMUUNqZmlqdTZRNHlWbHht?=
 =?utf-8?B?MWhCMUhrQldjc0ozUmVmVUo1VnVNbS8rVmpHWVVwdnFUN2taWk5rSU5QWTVW?=
 =?utf-8?B?cUdFd2ZObkx5dWxJYVdVR3JiUWVyRDZjeTB3RnVGMjc1bWRNa3JhT2FEdU1Z?=
 =?utf-8?B?Y0psSjhvaVJXYmduWW9qQmJnY1BmeUt2Rm9wcnk4aVd4M25UaTdRc3B6bS9q?=
 =?utf-8?B?TTlBSldGMERyV2kzN2VzSGR0eWlmSHNZUTJSVE5RN3R3b1o3VDlXako2bVBF?=
 =?utf-8?B?ZjYvaGxSeStLNXJnVTZVRjZVaFBjNm1EZ0JmR1BRTHdNSEVNOStmZHlXZFlv?=
 =?utf-8?B?WjlVN2VRQ1dqRWJ2SDlCSnFWdm00dHBPWXFOWU04YlN1ZE5Fb29BdjZKbysv?=
 =?utf-8?B?L1dxVk1DZFNmNVNUdm1rcnByeXBndVVRUDB5eDMvRWQrSXl5aFlYSUFaalQ2?=
 =?utf-8?B?OVRkeGM2YzNDRjA5dHdxY0lJdnY4dU5EbUh3VkRvbFdNZnNyZTFCTTF2QmtB?=
 =?utf-8?B?elRuYzZNYVAySFNHVjBPdG5INW55Qlp2QTZrZzdrQmk5RXZuQzY3QTUvUTdi?=
 =?utf-8?B?VG5SN2l1Y3dENE1QSHMvaUNYSk15RmpwbW9qNjdyWFVGZFM3MWcrMmtsUnov?=
 =?utf-8?B?b2s1M2g5bThVWmtEb0FqenY3Wk16eDdKamxnckp6Uy92QTVZdlRUQ1BPVkxW?=
 =?utf-8?B?NXdqUFJuUnQwOTNsdzRmNjdTOW9CVWNrNXhVdmhCQUZYSjhab01YMVZDZ3dw?=
 =?utf-8?B?OXlreWcxeVMxNVRzcThsM0RJVGw2S0lnQm1iMnJMK1J4Q3pZTHZCQVVKdDFp?=
 =?utf-8?B?dWVGQVF4dFlWeng0NS9JNitiUkhEd1NCTzN3dHZxb0xvYy92NTBzSFVwaDhN?=
 =?utf-8?B?czUrU3o1a2pqSUlHL0pKQW91NVJER1RFUkdFNUoraEJmR09vdU9QSE5TdTl1?=
 =?utf-8?B?WEVoQkZwNkh4a0ZXNjNCN25qc2M1WDJtQitqalRXbUZXSURrU1FoNjlZYUtS?=
 =?utf-8?B?ZW5OUTR2cTJsVllzMit3WktFcU9IZTBETStYRE1xRDBmaWdzSXZFUE9ocUlM?=
 =?utf-8?B?cG5KUkpnNkdTRW5ManRIcW1yMi9yeUVZOUlndVNxZ0M3ckZsZmpuUC91Q3ht?=
 =?utf-8?B?dTErTTdteWVDaC9YRlAwSHVaYzkyMVBtdzluTTluRExWZmlTS0ZvbVBuQ3Iw?=
 =?utf-8?B?SGdkVHpkM2ZQUEY1cmJiQWd3STc5bDgxdGY0dmQwOE11anZXSGFZWnN6YnNy?=
 =?utf-8?B?YmIvSVgzZEpJN3huUGozeCs1RXlDMFhMRFFPUUJzRnErZ3lSSHhJOFdLUEd2?=
 =?utf-8?B?emFBenBsSWtYMVAwa3ZEdFJ5bW9SdWszd1VyYzhHTU5JM0FMeVZpWHBESWF0?=
 =?utf-8?Q?3WvwqSgtU7SzojrCD6mqgDI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93183702014DBA43AA708D3920D7E1BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382126e8-4ca4-4649-844f-08d9cfecbc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 01:43:12.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rjY/7DzXRDuqv+q0Acdkff7cwT2RKcLsk1fRng0fOdA2RkSzud7ZooPu25z4WaZrUPGm4+mR7dP1rzqzHryYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA1LzAxLzIwMjIgMDA6NDAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+DQo+IE9uIDEyLzI4
LzIwMjEgMzowNyBBTSwgTGkgWmhpamlhbiB3cm90ZToNCj4NCj4+ICtzdGF0aWMgZW51bSByZXNw
X3N0YXRlcyBwcm9jZXNzX2ZsdXNoKHN0cnVjdCByeGVfcXAgKnFwLA0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByeGVfcGt0X2luZm8gKnBr
dCkNCj4+ICt7DQo+PiArwqDCoMKgIHU2NCBsZW5ndGggPSAwLCBzdGFydCA9IHFwLT5yZXNwLnZh
Ow0KPj4gK8KgwqDCoCB1MzIgc2VsID0gZmV0aF9zZWwocGt0KTsNCj4+ICvCoMKgwqAgdTMyIHBs
dCA9IGZldGhfcGx0KHBrdCk7DQo+PiArwqDCoMKgIHN0cnVjdCByeGVfbXIgKm1yID0gcXAtPnJl
c3AubXI7DQo+PiArDQo+PiArwqDCoMKgIGlmIChzZWwgPT0gSUJfRVhUX1NFTF9NUl9SQU5HRSkN
Cj4+ICvCoMKgwqDCoMKgwqDCoCBsZW5ndGggPSBxcC0+cmVzcC5sZW5ndGg7DQo+PiArwqDCoMKg
IGVsc2UgaWYgKHNlbCA9PSBJQl9FWFRfU0VMX01SX1dIT0xFKQ0KPj4gK8KgwqDCoMKgwqDCoMKg
IGxlbmd0aCA9IG1yLT5jdXJfbWFwX3NldC0+bGVuZ3RoOw0KPg0KPiBJIG5vdGljZWQgYW5vdGhl
ciBpc3N1ZSBpbiB0aGlzLiBXaGVuIHRoZSAiTWVtb3J5IFJlZ2lvbiIgZmxhZyBpcw0KPiBzZXQs
IHRoZSBSRVRIOlZBIGZpZWxkIGluIHRoZSByZXF1ZXN0IGlzIGlnbm9yZWQsIGluIGFkZGl0aW9u
IHRvDQo+IHRoZSBSRVRIOkRNQUxFTi4gVGhlcmVmb3JlLCBib3RoIHRoZSBzdGFydCBhbmQgbGVu
Z3RoIG11c3QgYmUgc2V0DQo+IGZyb20gdGhlIG1hcC4NClllcywgdGhhdCdzIHRydWUNCg0KQWN0
dWFsbHksIGkgaGF2ZSBkcmFmdGVkIGEgbmV3IHZlcnNpb24gbGFzdCB3ZWVrIHdoZW4geW91IGZp
cnN0IHRpbWUgcG9pbnRlZCBvdXQgdGhpcy4NCmh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4
OC9saW51eC9jb21taXQvYTM2OGQ4MjFiMTYzZjc0ODM2ZDUyNzYzODYyNWQ0MTRjN2E2MmQwMCNk
aWZmLTFiNjc1YzY4ZDJmNWY2NjRhYmVmZWEwNWNiZjQxNWY2MzA3Yzk5MjBiMzFhMTNiZWQ0MTEw
NWM0YTg0ZTAyNTlSNjQxDQp0aGUgbGF0ZXN0IGNvZGUgaXMgbGlrZToNCiDCoMKgwqAgaWYgKHNl
bCA9PSBJQl9FWFRfU0VMX01SX1JBTkdFKSB7DQogwqDCoMKgIMKgwqDCoCBzdGFydCA9IHFwLT5y
ZXNwLnZhOw0KIMKgwqDCoCDCoMKgwqAgbGVuZ3RoID0gcXAtPnJlc3AubGVuZ3RoOw0KIMKgwqDC
oCB9IGVsc2UgeyAvKiBzZWwgPT0gSUJfRVhUX1NFTF9NUl9XSE9MRSAqLw0KIMKgwqDCoCDCoMKg
wqAgc3RhcnQgPSBtci0+Y3VyX21hcF9zZXQtPmlvdmE7DQogwqDCoMKgIMKgwqDCoCBsZW5ndGgg
PSBtci0+Y3VyX21hcF9zZXQtPmxlbmd0aDsNCiDCoMKgwqAgfQ0KDQoNCj4NCj4gSXMgdGhlIG1y
LT5jdXJfbWFwX3NldFswXS0+YWRkciBmaWVsZCBhIHZpcnR1YWwgYWRkcmVzcywgb3IgYQ0KPiBw
aHlzaWNhbD8gDQptci0+Y3VyX21hcF9zZXRbMF0tPmFkZHIgaXMgYSB2aXJ0dWFsIGFkZHJlc3Mg
aW4ga2VybmVsIHNwYWNlLg0KDQpudmRpbW1fZmx1c2hfaW92YSgpIHdpbGwgYWNjZXB0IGEgdXNl
ciBzcGFjZSBhZGRyZXNzKGFsbG9jKCksIG1tYXAoKSBieSBhcHBsaWNhdGlvbnMpLA0KdGhpcyBh
ZGRyZXNzIGNvdWxkIGJlIHRyYW5zaXRlZCB0byBhIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MgYnkg
bG9va3VwX2lvdmEoKSB3aGVyZSBpdA0Kd2lsbCByZWZlciB0byBtci0+Y3VyX21hcF9zZXRbbl0t
PmFkZHIuDQoNClNvIGkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBxcC0+cmVzcC52YSBhbmQgbXItPmN1
cl9tYXBfc2V0LT5pb3ZhIHRoYXQgYXJlIGJvdGggdXNlcg0Kc3BhY2UgYWRkcmVzcy4NCg0KDQoN
Cj4gSSBjYW4ndCBmaW5kIHRoZSBjdXJfbWFwX3NldCBpbiBhbnkgcGF0Y2guIA0KY3VyX21hcF9z
ZXQgd2lsbCBiZSBmaWxsZWQgaW4gcnhlX21yX2luaXRfdXNlcigpLA0KcnhlX21yX2luaXRfdXNl
cigpDQogwqAtPiBpYl91bWVtX2dldCgpDQogwqDCoCAtPiBwaW5fdXNlcl9wYWdlc19mYXN0KCkN
CiDCoC0+IHVwZGF0ZSBjdXJfbWFwX3NldA0KDQoNCkJUVzogc29tZSBvZiB5b3UgYWxsIGNvbW1l
bnRzIGFyZSBhbHJlYWR5IGFkZHJlc3NlZCBpbg0KaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5s
aTg4L2xpbnV4L3RyZWUvcmRtYS1mbHVzaA0KYW5kIGl0IG1heSBmb3JjZWQgdXBkYXRlIGlycmVn
dWxhcmx5Lg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IFRoZSB2aXJ0dWFsDQo+IChtYXBwZWQp
IGFkZHJlc3Mgd2lsbCBiZSBuZWVkZWQsIHRvIHBhc3MgdG8gYXJjaF93Yl9jYWNoZV9wbWVtKCku
DQo+DQo+IFNvbWV0aGluZyBsaWtlIHRoaXM/DQo+DQo+IMKgwqDCoMKgaWYgKHNlbCA9PSBJQl9F
WFRfU0VMX01SX1dIT0xFKSB7DQo+IMKgwqDCoMKgwqDCoMKgIGxlbmd0aCA9IG1yLT5jdXJfbWFw
X3NldC0+bGVuZ3RoOw0KPiDCoMKgwqDCoMKgwqDCoCBzdGFydCA9IG1yLT5jdXJfbWFwX3NldFsw
XS0+YWRkcjsNCj4gwqDCoMKgwqB9DQo+DQo+IChpbiBhZGRpdGlvbiB0byBteSBvdGhlciByZXZp
ZXcgc3VnZ2VzdGlvbnMgYWJvdXQgMC1sZW5ndGgsIGV0Yy4uLikNCj4NCj4gVG9tLg0K
