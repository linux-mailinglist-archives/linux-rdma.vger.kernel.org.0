Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABA5321C3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 05:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiEXDxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEXDxh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 23:53:37 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14919C39
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653364416; x=1684900416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a9wyWQXuzUWhk3xNQdvrF1EqBAsrJqNxsExRhRmrod8=;
  b=cAqj/5ftA+K9tr9QtYwMASnBzv33HbdXFgY7kE344Y9Hs9p6xjDWvD/z
   kZ7pCGtIic5IUerAjlAetvjmMKPxQf1vQug92nc39E3QOb550hGtwVASS
   XW8WW2impXYlnDeQU0X/Qu+Eyk1/2p+ml7HmSo/Ey/v3qk8ecR95h/Hh6
   /vASpFqQ4VSJUlIYCinl0g4MDMYqam8YRkSri2JxwnW60haTdjSR5BHBT
   iHg3pHRTuzDQcyNFlmLDpfRctOwJIy/A7RUgUDZEmJYpKKTlDKRWcJ11V
   iQQ5hf4NZE99YE9QBOV+NtW4IxsTWlnmfnh+A4S1k9+k2TUm3awh7Y4Vu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="56405907"
X-IronPort-AV: E=Sophos;i="5.91,248,1647270000"; 
   d="scan'208";a="56405907"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 12:53:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf8TFpcSjunYcH+SzHvcVA8iHCevco9oej8m46j4D8gvZN0KQfyuqs/0xUlVbYCSJZE82g+k+t+Sr4yQzrXxLqd9/xjLnl7zT/tNU3dTIWJrAIgzUiNDMyFZABDfzKaaWfv8xt0KXSUVA07X6oohbdpEDaOU1CFlA3WudGpjGBaGOIVbdXivLmoSAnmBMrkdKKmNgicw/VQlpDcp9HeOj2PqUQxcJbO+QhBpnEzX22ILmT/Zu4GLNpMEkr+vNMSKVqUkRjsNJr5sYPkIOBP1rbaCzW5dQAhVI4LFX2Qx/ZG89NOsqkWNQ/H73kE7zTazj9wAQkZN+HnBjvsvNGSlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9wyWQXuzUWhk3xNQdvrF1EqBAsrJqNxsExRhRmrod8=;
 b=OaWb9aDSPzcrlVguOsdaxUy8EdnQaWs9sL1TFP5KSlhmHzZNYrjh1JljzFUrqt5yMEwt8hpP336sNUT5+ZNnWzsFYT9+HRJh32cJc/bwj94DXZSzr3ScEkDoZ4XJPtPT5VkQhkHYZCXw2LUTRQ3sdzmOlVvIiUgsLDmZYMwME3LPXz6UDX+mtsMcdS92sj7xuf+Eelz75Wy6oMHk6qFCRy60rye0cEvEIvia90kA0Dtu235QCQNL8BCUpsSqIK9LBYJfN0EEO2TiqoF5KIWoSROoLgQtyqANWOR8Btfca2Oml2Mr7Y67Slb9IcJUNVCZHGYTa9OFv05moJ4Gg51f2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9wyWQXuzUWhk3xNQdvrF1EqBAsrJqNxsExRhRmrod8=;
 b=SrVM+BcUPs8AvTSVUyte+G7ThhAKs5Q7Q3Y27vbObU6MQn/oQZ44HPqUxqTIVdxo9q7foLNrxC6Mf5UFxOmh/swOdxxDsatxEr9YwktIN+4dd4dmvH/rP2qqy13Vno5rWqEKTTRMRdx8sNmGEEaqGdMFtRLWxKJ0+h9EFfK6WYg=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB7991.jpnprd01.prod.outlook.com (2603:1096:400:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 03:53:30 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930%8]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 03:53:30 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Thread-Topic: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Thread-Index: AQHYVSDlivMhp6EZyk6izFO9+iNDBq0W+Z2AgBafyAA=
Date:   Tue, 24 May 2022 03:53:30 +0000
Message-ID: <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
In-Reply-To: <20220509182353.GA927104@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a509ba-1c60-4d6f-2997-08da3d38f767
x-ms-traffictypediagnostic: TYCPR01MB7991:EE_
x-microsoft-antispam-prvs: <TYCPR01MB7991C05DED044D0B8F10445683D79@TYCPR01MB7991.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9os5u8f03yoK10AfoRlEfNZbButBb7ivQDYQWoLjhaThvfbmzJhuuv+fdliRzutOidCUDK2NewOFlT2tT6QSd2eCNr9VFjaZMJJaydR9EKn/wFo+XC9IzChONJFlabFECB5dr0H4BzJj+ZoJAgJywpn8zbcjgDg7TFcYjdp8UOMRONMnUon4ACyLtzkfLgSJw8v4NKJzbjEREXTmUZheMsBLpEVS1cNfWMmRqsieF/4ASuDsVt4yWV4Y3JGunfTUqDDzDDMqEZLYC9Vk91NJZa6MH5uXN0+u6rCmIcLjUDRkSyNSzVlBQI4Fgbxj8xRC8expgFJovN6RKkEu5LHsxEs4vKKOSCjOjbtTfm5pmg80K1MjJdkF0m5QK5ApCdOwyHBC0hdNqBQd9YX1CP5PlWYjnxn977R1HnsQgtVS3CeNW7JpVe7nc9riuiRJHX41DDGVD1nz8+J9e+pD3n4QPYUHyUxbSQVbRo9prt6hhPtjZPkOInnsTrGdxF4HviN/mgf+g/4VCeqm5rPx8o6yeKUxpykXLdHJ/kOaTdmq4WLpStHGIwdq9NVnv9vgknlztdBarWRXxwVsvgkr6biGG31MCmGhR4WXYbk/60Srze3V77+6g3UROl+EZ44284JUvjFNQoACY7MCjx4EHJen6eDHkWX578BhgynzIICEoVQrcmdfFgrtrot5ReJHEWXx/JmMctq4QAw30XoU0P5bUmjxy29n/RxrnsvN0nPkFpU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(5660300002)(316002)(66446008)(8676002)(110136005)(66556008)(91956017)(54906003)(4326008)(76116006)(82960400001)(66946007)(64756008)(66476007)(4744005)(38070700005)(38100700002)(71200400001)(8936002)(53546011)(6506007)(508600001)(2616005)(36756003)(2906002)(122000001)(83380400001)(85182001)(186003)(86362001)(6486002)(31696002)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L05Xb29CNnlHanJnSGNCRnZRS29tU2N1MTVVNWM2MUwrbUExeU9FbVRjWDFK?=
 =?utf-8?B?Z1BEcFpFQUpKVXRzeXdCZ1c5NEVaa2xFQ3ptSm9HU0VpVDNBM1FPUlFabDJu?=
 =?utf-8?B?L2J1YkxrK1hVeU1RM1pJVFJZZW5ycVNBNjBtelBNTHRaM09reG5WZlVwWjVs?=
 =?utf-8?B?ODNaeGxyM0U1RWxELzczNG9oczhubzFJZXBNNjJ0SVZ4bjRXWE5VNnk3TzI5?=
 =?utf-8?B?a1UydDZ5ajdZSzhZcXlhenV4WXJ6d3pnKy9TSS9ZUHZEZDFGMmtNQ01OaUZi?=
 =?utf-8?B?eVJHV0dqdVFBUi9jUGJJS2NzVHNpT1lpVVJEK0JhSnYzSjVKOXN3ckM2SXB0?=
 =?utf-8?B?NE1yZ2VpblM3QXF4aHc1Yko5NFUyeUQyakdscmptYlBZR2FsNk9peXJFNlJP?=
 =?utf-8?B?bG9lR3NIbkN4WTN2c0NIaXplZUJmVHo5azhyazRKb3gwVTJmTHFSREttUFFu?=
 =?utf-8?B?eWpvcWxGZUNHM1RjeUEwZ0o5a0MxNm90RU9ocmlGWEhWQ2p5dzVQUE5XdjFq?=
 =?utf-8?B?cGpuODZvRnlCYk5ISUpnR241UWRIdjNvdlErSUpiU0RudEZyYlByU3lDKzVN?=
 =?utf-8?B?VGZSdC9JSC9kbVZqVzdwaHJkMGR2Q0pMTVovQVgwSzUwL1NybHRqVnhzbkhs?=
 =?utf-8?B?SjhSR2ZTSHlIM1BxNWNpUjNiaEVRZDFxMVBCRlpEZGtDUXVCQ2xpVTNvQU52?=
 =?utf-8?B?OVIxOWdqZXBJTjkyY0NpVDkyYXZ3SmhmUlFmYktWNmRpMEFhb1JpMWNpU1ha?=
 =?utf-8?B?UHh2bXBDdm5EL0tyc29heDMyVUpYVWZaZXE1QlVHWngrcW5XZ0FNU3ZKRnBU?=
 =?utf-8?B?RU8rVDNIMG4wWG1IbzJwbzlndXBDSUxjSWNlbXlGcld3WUdXZTVNSmY5c082?=
 =?utf-8?B?cnRHalRTbEp6TXF1N2UwMnhhUlM1ZmsxbU9ZOWRXOFRxdmV3Q0V2THNweFNV?=
 =?utf-8?B?VnplNFlmMXpHc0xRVDF6MnQzNjlTeFVzQ1V0R0c2MEZNQmlPUVpyRE1VdFV2?=
 =?utf-8?B?RnF6Z2d2elcyOGJ0RHpsQXZRY1MxWHd6TmhmL0NCVE5JaDNBczRzTERoNS9P?=
 =?utf-8?B?Y0ZNdjg3cFhycE5oZExkbERzalVadDFaeVRTaThVT3UwVWloTEpRZURxN0xU?=
 =?utf-8?B?RE5rZkJKUmI3UDIxc1FzRHhDeHJPTGh1b0VxdHNydS9IdVM3MmNXNkhObXpp?=
 =?utf-8?B?QzB4WFEzc3NKWEpiRDVGVGZTQTRnTDBTYXEwMjNYeGtOdXZRdnE2Y2wrTk1w?=
 =?utf-8?B?Ri9qZ29BbnRIMzErUGVDM1l1d1dhb29SQWxKeDFHK2loK1RzdytCRDljTE9i?=
 =?utf-8?B?YTBaWTZ4dVR6c2ZjR1gyTUhsOFV3eUE0Y3VDdWN3SkZoK3d5czdnakhRMmhl?=
 =?utf-8?B?bmhsTU16bTdieThqOWZWV3ppdXRYa1AvM3M3RUZzNnFjb2g5MTJxb1ZCV2lQ?=
 =?utf-8?B?ZGMrTzV0b21aZkNzRDZPNjZYS2MrTkxtWXBUTDdyYW9lYzYwNUF3UnRobzRR?=
 =?utf-8?B?TGFiNFgvOE15YzhUWmlVcUpTU3ZlYThJdTdPcUFYdUNDZ1NNQjltU3YzWkZO?=
 =?utf-8?B?eG1Cb2VkTmFYdkhMOVNERjA0Q2JpN29BNGFBUy9rUUdQK1h4VHZSa1l6cWp2?=
 =?utf-8?B?dEdQeEZCMzhCaU9GOFFiU0c4a0ltZGhvb3QwdUQ2aG5BU25JSlR1a2JyWjlm?=
 =?utf-8?B?aTBWTlh5NEcra1RXV0sxb0F4S3kxclZnc0ZZYzVNNlVGVVUvVUZYaTE0Q21w?=
 =?utf-8?B?enkrZ1hWRXhoUWsrY25yQWZZUzBSTXF2ZDJkSUpLUEpJRTlqOS9qOXBpUGF6?=
 =?utf-8?B?YUNodUx5VnlCN0xYdTdJRUQ5OEZWWE5UNC8wc05hUXdMaTNxcU9KbzhhNDZN?=
 =?utf-8?B?bzg1RnRIcjF0YmxYTGFOaTh0eFdRbFBmOUJNOTRCdWNHVVlYTWdCdGlSeWpS?=
 =?utf-8?B?bXFaSENUcndRZFMxOFhOMFp0VnFQQTdTUVRKMGFMTGt6eDA4RVcvVjUzVTdx?=
 =?utf-8?B?am9DdUdhYk5KZXdKSXJIL0dGUm1hUlVvS0J4ZFF5bjAzMUJ6WXR4OUh4Q0ky?=
 =?utf-8?B?aHA2M01jR3FpbFpaTnBncEhXbWhDeVRFM3Fya2taMkIzYWI1WU5jMU8wMENi?=
 =?utf-8?B?NW5JZVp1Nm5kRXRGN3JhcUpCMjA2cFdLMVQ1Yk5VcDl5dlNLUE1FUWlFUjcw?=
 =?utf-8?B?RHNXa1ZXMlVXdC9WRWVmYjJUdURFU3dGTExuL0k1aVFLNGRBVWlTRU04cDdF?=
 =?utf-8?B?VFBCZ0EvditjNXZ4SnUyWVNvSXp3TnNuZ0NUbUYxS2dUaGVjRnJ3ZFdSZmMv?=
 =?utf-8?B?ZWpvWjhJdWRwWC9NeUJKMVF2TnA3RWJaOFRuV0F5Yk5rdmFDL051emlvVGI2?=
 =?utf-8?Q?KrU4KJ9Wb8r+zXIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7183721C0ABB484388C10AFE55C93711@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a509ba-1c60-4d6f-2997-08da3d38f767
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 03:53:30.4386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7OwSXLplwS12o7kNglNdwuu/hJyzvH+TlBxeByyvp4YH7GrjSyhiZbB/R5eFdYS/ITPjWvaRQwxxK/EP7Flow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi81LzEwIDI6MjMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MjAsIDIwMjIgYXQgMDg6NDA6MzNQTSAtMDUwMCwgQm9iIFBlYXJzb24gd3JvdGU6DQo+IA0KPj4g
Qm9iIFBlYXJzb24gKDEwKToNCj4+ICAgIFJETUEvcnhlOiBSZW1vdmUgSUJfU1JRX0lOSVRfTUFT
Sw0KPj4gICAgUkRNQS9yeGU6IEFkZCByeGVfc3JxX2NsZWFudXAoKQ0KPj4gICAgUkRNQS9yeGU6
IENoZWNrIHJ4ZV9nZXQoKSByZXR1cm4gdmFsdWUNCj4+ICAgIFJETUEvcnhlOiBNb3ZlIHFwIGNs
ZWFudXAgY29kZSB0byByeGVfcXBfZG9fY2xlYW51cCgpDQo+PiAgICBSRE1BL3J4ZTogTW92ZSBt
ciBjbGVhbnVwIGNvZGUgdG8gcnhlX21yX2NsZWFudXAoKQ0KPj4gICAgUkRNQS9yeGU6IE1vdmUg
bXcgY2xlYW51cCBjb2RlIHRvIHJ4ZV9td19jbGVhbnVwKCkNCj4+ICAgIFJETUEvcnhlOiBFbmZv
cmNlIElCQSBDMTEtMTcNCj4gDQo+IEkgdG9vayB0aGVzZSBwYXRjaGVzIHdpdGggdGhlIHNtYWxs
IGVkaXRzIEkgbm90ZWQNCj4gDQo+PiAgICBSRE1BL3J4ZTogU3RvcCBsb29rdXAgb2YgcGFydGlh
bGx5IGJ1aWx0IG9iamVjdHMNCj4+ICAgIFJETUEvcnhlOiBDb252ZXJ0IHJlYWQgc2lkZSBsb2Nr
aW5nIHRvIHJjdQ0KPj4gICAgUkRNQS9yeGU6IENsZWFudXAgcnhlX3Bvb2wuYw0KPiANCj4gSXQg
c2VlbXMgT0ssIGJ1dCB3ZSBuZWVkIHRvIGZpeCB0aGUgQUggcHJvYmxlbSBhdCBsZWFzdCBpbiB0
aGUgZGVzdHJveQ0KPiBwYXRoIGZpcnN0IC0gbGV0cyB0cnkgdG8gZml4IGl0IGluIGFsbG9jIGFz
IHdlbGw/DQpIaSBKYXNvbiwgQm9iDQoNCkNvdWxkIHlvdSB0ZWxsIG1lIHdoYXQgdGhlIEFIIHBy
b2JsZW0gaXM/IFRoYW5rcyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IA0K
PiBKYXNvbg==
