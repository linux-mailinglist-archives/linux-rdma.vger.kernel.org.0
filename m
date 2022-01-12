Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72148BDCB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiALD60 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 22:58:26 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:3525 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbiALD6Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 22:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641959904; x=1673495904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FK8T+ko+i4XC5TAl7a+iG7DLhkFDTwYAaiOeIqY+G5k=;
  b=wRYGGSIbRWBlHF369QqG1RAktTzPaKV8Z+cBiq/xCLdeFXopsllFNu9o
   glp4r8S9b/pYk5kOvlX14O7sopR9qUv7cEqtWL+GmMdlSXTdZ/VODf8O8
   7p40cYnCCkDneADQ5gDb7XRbaCLajBtkYZ4c7QSmBjLN/xSYIKAITm606
   Y837Tcy2CZHgSPlHLuf9SbJsxEyv4ZR9TbVZ91r40twqoZ31Grj8+xm71
   v3bXcy49jhXOWzeILuGwe9lMzRPJverpyRAkbK4FLjCh4LUqo5m5vfFId
   CUO26zIi3IDjqWiwSYrzqA9CGFtVsGBSfaQUWXJlGvBNh2pzRL+PqsAW+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="47733686"
X-IronPort-AV: E=Sophos;i="5.88,281,1635174000"; 
   d="scan'208";a="47733686"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:58:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4kDUFlB9O3yuyp+OQKw1gu+Cb+vIowy//kXwWaWHUE763Liz+0CMd4Qcwsjrp1neS7c5GghccqTJzurwzh1P2IM36MqD58jMdqCbm1y66VqgprMJ5/zYa4nIlUfULbymHLwKAa1JMEcLJgFgPG8V6WaCggFff/uklq7T0u4X9i9/kisTCWHicFE1tZ3Rllztj++5XdBIMHOwGw0HzZrf3tLQgUg1RyMpGnOeXiADSL19upjfhplJRs0xOLh6CFiXOSU/3hFqhWm9opb7Xk6zvNcIi8QFdj+zL/eoDqilh76/z7i97RTpGT0JIROrCjOAvvREMruoCy4dNpsKb2mVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK8T+ko+i4XC5TAl7a+iG7DLhkFDTwYAaiOeIqY+G5k=;
 b=XRyp5NJ/SOrG3t15acW1aIjdwg9WioBDY0Fg4JxgL5JDZid9Hm+xMvEvfpexB5Sst9Uo4yvFBBJsMJYtYSnCSX7QW6AnyTp+EEpg7sSwmznmoaIqQd9rYLXi7HNvzHFnmdA/NAywByALGjRgIk/ZPKUIvFPrSRCotBug76OC8j3XSnjYhp5lYxea78U27zjxQTeuxwZKFsFdx1AyLUP7VcnX0TH08D3UarPOAPqRa7ZefCFJq8Sncn/ypQwHl0rTxIpiXNZ7F5gsQAKG5yJmo2E9p3Q3AqmeTGpF1l+xpr5Q0wMti4FxUu59VrcYgAmGVoQF7Tp+ZedY+KFVAiJXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK8T+ko+i4XC5TAl7a+iG7DLhkFDTwYAaiOeIqY+G5k=;
 b=ZVoq9ZMlPAHpFTTXpGMI+YUlZsM18z6+UCElwSpCsA1N0TUBaW/SiEfPefMGxErYOWK5jfJ1dnJY/JnB1f/OqgBrlQzDKo8L9onxnH7e9h4NrdVLT1n+Cx3R4paq5W0qYybsvLncUefnnVelTXAh/dpnmW7vGP55m6lMDwonZq4=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB2484.jpnprd01.prod.outlook.com (2603:1096:603:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 03:58:19 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 03:58:19 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Topic: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Index: AQHX/GaNtF/ypvfLdEmpN5TwUFz2Y6xVMxeAgAJNfwCABElJAIACMCkAgAAJtICAAKg9AIAALHmA
Date:   Wed, 12 Jan 2022 03:58:18 +0000
Message-ID: <61DE51D7.5050400@fujitsu.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
 <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
In-Reply-To: <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df142a12-396f-4839-b7fe-08d9d57fc4e2
x-ms-traffictypediagnostic: OSAPR01MB2484:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2484F90BC59A100C25EA5C9A83529@OSAPR01MB2484.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6STeQlp6XYNFK4xON3N+d0l0osBdl4XHXK2Hses/s03+QEx3z3bQuEfb/VBJmD2kT7e9+uYHQ8CR+U6gSfV3F4EsEKOCi7l65I1dwIgeTpct2fZagGX7StaHDBSAyNM0ro74Cb24ld3ox1xPJRoMRSxyO9HD1mGWdbbV2OhBGjjGejV7/ZERRXQz/Gau5Cn8DuiWXekGFOnvHdUbvNElt1W0taYrBRVoi67x5D0059MU152cvufqbJYQk2y1hp65sDAM9R9b/j9Dx42ydtTIIvERhXKJcflndJ9dC9pgJx1umLZbaqq6Chirc4oul5xD7xdP3u8HYGO9YQmOc7gSSNKyBWIt3810Co/vNkMJoDgvCIVgnyz3VnBnK0fNiq/Vrpix7GqDDdBYrcBeR2n0etmNjgTVv/rpyWy5+4TGelbruWVq+85OF1lnGQGJu3ROxCAltnAnW68BbrepCKF0+Sc/DSxv8ijBqAXdSxhzHDR2w4uvYBMyd8iXEqn+W/+VYztTL2gfXbXjumFqoKn9Em7DJ2eKdTkSb7OR/WXhi0NuBTGmp/WIOfP9cAgUZ3gZXkBEk7rIDJFL0qDMPG6o1NcrKumLtkch3CXO6cwzrQePalxYU/5GQaGrvwUJ85T1oARcA83OOhiV6QR32ymKs1a4pvx7bdAwE9W8G8NVLc/zV4T2hAlvb9NDWsGH6jzg9W1rSfkioGA2bSY6M3uh1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(66476007)(66446008)(66556008)(38100700002)(6512007)(85182001)(26005)(71200400001)(6916009)(508600001)(2906002)(64756008)(8936002)(66946007)(186003)(76116006)(91956017)(82960400001)(4326008)(66574015)(316002)(86362001)(83380400001)(122000001)(36756003)(54906003)(87266011)(6486002)(8676002)(45080400002)(33656002)(6506007)(53546011)(2616005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHozd2lVRmtFTVh4KzMvcWZOMlZ1RDB6WFl6SXhScHoyS3FSZG5aZjZZUlJR?=
 =?utf-8?B?T0VPWlhpeGpBT0ZZemxIWWVQbnJvZGtETlRGVTRnQkJkS1ZycG04ZERQc3JI?=
 =?utf-8?B?NlhveGVZeU1mNFVWbEN3L0tLci91SmtJenlaS2psN3dYbGQ4TWd5Qm5mSWlj?=
 =?utf-8?B?TG8zTWEwMStGK3NJcndMQXgxNDQ3OWx0Rll3TUNBUGJ3c1daTGluSVYxNzIz?=
 =?utf-8?B?cnRucGlmaW5TNWFqUEloSXZiRk1VS1dpOW44YUpGR2swSDN6VG9QRWtLOUk5?=
 =?utf-8?B?NjBHSGQrOXVpc0F4RkdJK0RSenNScG9yUmxHTDZqTXZ3L2hsdzh3aHpZeURs?=
 =?utf-8?B?bjhPNGt2S01FOVZZRjlCKzFRWnhJRlZ2cFZ4TnNVL0Z4UC8xaDZ2dWIvL3U2?=
 =?utf-8?B?UldLVzRSNWhwZVlCOVBEc3VOaGVSVmRONnhyeVRVOHFrbFNqSnovblNycWRr?=
 =?utf-8?B?dnNMSlAwMkF3bk5JU0ZTbTRLT0lqdlB4aExRaW1CaTFKc0FaZ0FLa0RqbUZa?=
 =?utf-8?B?ejVOWUIxR1ZhSEJab3I3eVVJNUdZQ1REbXBJSDlvbDhUaENXeEgzMTdUaXFS?=
 =?utf-8?B?N1BEOHBhbzljeUtUQWtqU2NnZHRFai9yZ1Jjd2FjNWRZMVVVckt6OGkrL3Mz?=
 =?utf-8?B?aGZVV3F5RFlCc09MSDVGNC91blJuajhEa3dZTmt2K1E4SmhIaDkwZDJIOXZt?=
 =?utf-8?B?aFdJS2gzNmsyRExmOUoyR1YwaU9EdFV6Sll0VUNzcjhPdGthTjd3UTBFWDdx?=
 =?utf-8?B?UDBTeE9UOWJ1SDJJaFEzc2pUeS9ESVltbFQwWVJmNmdLeTN0b2xha0JJNmRr?=
 =?utf-8?B?UXdqZjJPQURnRGtzYTNCRmkyQzA0THdNN29Pb1o5WWgrVExkaHFLeFBlOWtI?=
 =?utf-8?B?K3g1N3QzQjg5dnpUdzdpTzlFU3UyS3ZHdjNodGZaRExYS3FtZVFpalA2cWdt?=
 =?utf-8?B?S0thZnI3eWtqRys4N0EraDFIcExCY0lSUlFHWnhsb08reFRKVlU2aW5DK3hJ?=
 =?utf-8?B?cldYV2hKT21ZQm10VW9YNzIvSGFZcXdZMmtqM2JpTmVsT0V6eE1kWU1oTWFJ?=
 =?utf-8?B?eWkwTjFaYXQwckZ1bFhRMGU5RldxeTRnNlNHQUJvem56U1MrbDNHR0tsckc1?=
 =?utf-8?B?blZFajJuRmtGdEs1Sjh2OTBuK01SbEF4UVg1RHRMTTVzRUNoWS84MHBoWHRW?=
 =?utf-8?B?QjMvUUJtV2s0aVZybC9nYjJGbWdGdFlWeE13cXR6eGI1TEZSUWpNVUdSZlFt?=
 =?utf-8?B?bmVWbjRpTTkrNDI5eDllQlp4Q1JYWC9paWN5UjhuZVdzWFd6b0xEMmMrSjR0?=
 =?utf-8?B?QXc0b2JDd0JNZEpOMENmOUM3MnJMTkQ4WEZaME1MYlpPVTNpUkJWQXhBZ0Iz?=
 =?utf-8?B?cXNpc1NhaVBNZ29TVS90S2x3bWlpdUE1UUhxQUFzbEJ6bElMUVZURkwrd2x3?=
 =?utf-8?B?TVc1OXc1UjhZYmxqQTQ4c01KSTYwd3FTY0NCSGpPMkNGZjQ2SGYycW1naVJE?=
 =?utf-8?B?djgva3pZN0pqUE5LVDFlclkzZXJuTmxvNStyZUhkZUI2bXQ3MDBWWXBmM2th?=
 =?utf-8?B?b3VRTFQwSzNKdGxHZWcvYTY5OTBLVlZMaFVFNTRHNXJkN04yenZuMUZ4YXV4?=
 =?utf-8?B?YmN1ZXR3ckxDSlQzaEdjVzRpTU1QT1BpckVzbUVWV1FuSXBjRDh0aFFtcXp2?=
 =?utf-8?B?bnIraXU1S0pqVGVKdE1nUWVCNnA4S3J6K2pnaVZ2MkpHRGhpQjVndWthR2FD?=
 =?utf-8?B?R2x4U3cvR0IrMktScWlSWENPeWdzREIrdWdaQStzMVVSRkF5Wm8wSlg0Qys0?=
 =?utf-8?B?VVV5L3RDem1qOEljeDAxQVRPT0c1aGdqOXVYNSs2MUUyelFqNU9XMEY3aHRk?=
 =?utf-8?B?YlpYdzA5R2JlTU1wMVE0QTdyQ0V3TDZkY2doRkFiQm9wUC9kWVFGczlmTzdp?=
 =?utf-8?B?ZHBQVkRDQ01QV09uaHJ6ZXFTSmRGckRpTW9JTjZ2TnJpTWg5SGJyalg4UzFT?=
 =?utf-8?B?ODk3MHdBclp5RFhKWHgwMWVvS3QxYTF5UnBlSGtCN1lCNWtYMzA1a1VDNzlT?=
 =?utf-8?B?eUdvMEZNZlZldFBhblE0UkxqWjkzY2lkbWJGL24vdUt1b0lyQVVWM2c2N1Ra?=
 =?utf-8?B?Qk9hZ0lyYTN3SDhhYUcrNXdZSzNDcDhyLzVnKytBL2R3ZEtKcEFzLy9WdlZE?=
 =?utf-8?Q?y2eDeqUmFC8P+UElx7u/i7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72648AA085D65742978EE4E661C5449E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df142a12-396f-4839-b7fe-08d9d57fc4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 03:58:18.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91artotq4WmGhoyrss9IlkP6Xx87939tQoo1gdK9lCBUhKKgPbEA+KHdFCB+7NpDEmbE4vNk4PJO4GZoq/OM3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2484
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzEyIDk6MTksIFlhbmp1biBaaHUgd3JvdGU6DQo+DQo+IOWcqCAyMDIyLzEvMTEg
MjM6MTYsIEhhYWtvbiBCdWdnZSDlhpnpgZM6DQo+Pg0KPj4+IE9uIDExIEphbiAyMDIyLCBhdCAx
NTo0MiwgWWFuanVuIFpodSA8eWFuanVuLnpodUBsaW51eC5kZXY+IHdyb3RlOg0KPj4+DQo+Pj4N
Cj4+PiDlnKggMjAyMi8xLzEwIDEzOjE3LCB5YW5neC5qeUBmdWppdHN1LmNvbSDlhpnpgZM6DQo+
Pj4+IE9uIDIwMjIvMS83IDE5OjQ5LCBZYW5qdW4gWmh1IHdyb3RlOg0KPj4+Pj4gSXQgc2VlbXMg
dGhhdCBpdCBkb2VzIG5vdCBtZWFuIHRvIGNoZWNrIHRoZSBsYXN0IHBhY2tldC4gSXQgbWVhbnMg
DQo+Pj4+PiB0aGF0DQo+Pj4+PiBpdCByZWNlaXZlcyBhIE1TTiByZXNwb25zZS4NCj4+Pj4gSGkg
WWFuanVuLA0KPj4+Pg0KPj4+PiBDaGVja2luZyB0aGUgbGFzdCBwYWNrZXQgaXMgYSB3YXkgdG8g
aW5kaWNhdGUgdGhhdCByZXNwb25kZXIgaGFzDQo+Pj4+IGNvbXBsZXRlZCBhbiBlbnRpcmUgcmVx
dWVzdChpbmNsdWRpbmcgbXVsdGlwbGUgcGFja2V0cykgYW5kIHRoZW4NCj4+Pj4gaW5jcmVhc2Vz
IGEgbXNuLg0KPj4+IEhpLCBYaWFvDQo+Pj4NCj4+PiBXaGF0IGRvZXMgdGhlIG1zbiBtZWFuPw0K
Pj4gTWVzc2FnZSBTZXF1ZW5jZSBOdW1iZXIuDQo+DQo+IFRoYW5rcywgSGFha29uDQo+DQo+IEkg
YW0gcmVhZGluZyB0aGUgZm9sbG93aW5nIGZyb20gdGhlIHNwZWMuDQo+DQo+ICINCj4NCj4gQzkt
MTQ4OiBBbiBIQ0EgcmVzcG9uZGVyIHVzaW5nIFJlbGlhYmxlIENvbm5lY3Rpb24gc2VydmljZSBz
aGFsbCANCj4gaW5pdGlhbGl6ZQ0KPg0KPiBpdHMgTVNOIHZhbHVlIHRvIHplcm8uIFRoZSByZXNw
b25kZXIgc2hhbGwgaW5jcmVtZW50IGl0cyBNU04NCj4gd2hlbmV2ZXIgaXQgaGFzIHN1Y2Nlc3Nm
dWxseSBjb21wbGV0ZWQgcHJvY2Vzc2luZyBhIG5ldywgdmFsaWQgcmVxdWVzdA0KPiBtZXNzYWdl
LiBUaGUgTVNOIHNoYWxsIG5vdCBiZSBpbmNyZW1lbnRlZCBmb3IgZHVwbGljYXRlIHJlcXVlc3Rz
LiBUaGUNCj4gaW5jcmVtZW50ZWQgTVNOIHNoYWxsIGJlIHJldHVybmVkIGluIHRoZSBsYXN0IG9y
IG9ubHkgcGFja2V0IG9mIGFuIFJETUENCj4gUkVBRCBvciBBdG9taWMgcmVzcG9uc2UuIEZvciBS
RE1BIFJFQUQgcmVxdWVzdHMsIHRoZSByZXNwb25kZXINCj4gbWF5IGluY3JlbWVudCBpdHMgTVNO
IGFmdGVyIGl0IGhhcyBjb21wbGV0ZWQgdmFsaWRhdGluZyB0aGUgcmVxdWVzdCBhbmQNCj4gYmVm
b3JlIGl0IGhhcyBiZWd1biB0cmFuc21pdHRpbmcgYW55IG9mIHRoZSByZXF1ZXN0ZWQgZGF0YSwg
YW5kIG1heSANCj4gcmV0dXJuDQo+IHRoZSBpbmNyZW1lbnRlZCBNU04gaW4gdGhlIEFFVEggb2Yg
dGhlIGZpcnN0IHJlc3BvbnNlIHBhY2tldC4gVGhlIE1TTg0KPiBzaGFsbCBiZSBpbmNyZW1lbnRl
ZCBvbmx5IG9uY2UgZm9yIGFueSBnaXZlbiByZXF1ZXN0IG1lc3NhZ2UuDQo+DQo+ICINCj4NCj4g
SXQgc2VlbXMgdGhhdCB0aGUgYWJvdmUgZGVzY3JpYmUgaG93IHRvIGhhbmRsZSBNU04gaW5jcmVt
ZW50IGluIGRldGFpbHMuDQpIaSBZYW5qdW4sDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4N
Cg0KUmlnaHQsIDkuNy43LjEgR0VORVJBVElORyBNU04gVkFMVUUgc2VjdGlvbiBleHBsYWlucyBN
ZXNzYWdlIFNlcXVlbmNlIA0KTnVtYmVyKE1TTikuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFu
Zw0KPg0KPiBaaHUgWWFuanVuDQo+DQo+Pg0KPj4NCj4+IFRoeHMsIEjDpWtvbg0KPj4NCj4+PiBU
aGFua3MgYSBsb3QuDQo+Pj4NCj4+PiBaaHUgWWFuanVuDQo+Pj4NCj4+Pj4gQmVzdCBSZWdhcmRz
LA0KPj4+PiBYaWFvIFlhbmcNCg==
