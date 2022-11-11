Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6B625372
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 07:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiKKGPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 01:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiKKGPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 01:15:17 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 22:15:15 PST
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE292FCF0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 22:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668147316; x=1699683316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S2vZuu/g/j74SOclJ2dJoH4i1ksiqlgKsmXZgj9Qukk=;
  b=BFcWRALts5+UipSDry9wYg/ccJQud1ZsTcu+pSSROSv63DWEcokame1C
   ZGd7GiVHKUb+nGgos6rRfOZY3viwPTGWfFspHaZmKoQhI13eOVmBomd5A
   vuRK5HE/I4QHQtdCFw0s+WugF+jW+5FbhVycjhQ77T0ZtS7cEYC95b1nn
   KYHigst2j9CaOhbMBXG6fVMViivB/T3uFKeCuQrtWbhvqQbnrXJxlJXuO
   7O7PJ0bx1WI0bbH4ROsGPid/MQK5gy7bSgFzRVwmmfBvvUu0QhOw1OP3G
   WVE4PehMm1lU4JPgLC2o3wYzpQf7EW1AyHmaWR7h8iFIJeav8EPQE3p0M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="77597475"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="77597475"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 15:13:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+24bDRWYEzRIW5aCJnuFwq+Bmr+hfFjhBkE3FUXADA5yBvy6xduMUTR6thRzhINb4kbVJKld6j3D6f2M5uvJCZLA0Zef8BgAY14aqcz9UOvspILCjh35pJoYVX3C09ygIuTXlSGmhRGGr+pRhry2Urinj4QEmVI9a1uSwI4CgPVkiwE3mlaT6KTAuHAmK++rBJpiUBA99ZS7N4dz/aKhgQ9QzF6LgGrkBWQu0r+iaPJlX7QwuoAi+t/VYxU8SEMvTsbHztDXbQeZ/BrKeh1fmKrdRJKlcisQrN8wh8JO9LNT9k209Z03TAarOVeq/xTvMlEdedtUXcWiuieFle4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2vZuu/g/j74SOclJ2dJoH4i1ksiqlgKsmXZgj9Qukk=;
 b=krqIExh08yXAjjsaseiiHZv0qjfQpI7nH2XNWKtmRAG4Ej2+L5bR+bAjF6e1ZMpsxGnMFi1Nco/VRCY0ZIErUCMMqR33ovpTQCAwkX3Hcyq7wiSaG7y83a1+ehQz9vfbHIKw+rlKPSfaK0/+fHpa7TdbieLTXuXcHyxpLyD0CIuUJ1SCFmu1iyQh93ptW7zF/CSzZIv5/czqJEjUKW2UUI7dqYaMoOO7aVoLfnKzBbwtWwJYo/Gbhnnx/gwOevdcC6vAMBNxdQNVeTW1/cLVqdcoqmsW4O+roRotzI6dYG/2atQPXMuTgtJK5UiWvxQmkPaGdyFDfAMBYwBJ6LQa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS0PR01MB5873.jpnprd01.prod.outlook.com
 (2603:1096:604:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:13:06 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:13:06 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: [for-next PATCH 0/5] iova_to_vaddr refactor
Thread-Topic: [for-next PATCH 0/5] iova_to_vaddr refactor
Thread-Index: AQHY9YZoV+24zeGlWUyzGb2h+LfvG645PkWA
Date:   Fri, 11 Nov 2022 06:13:06 +0000
Message-ID: <a7decec2-77d9-db4c-ff66-ff597da8bc71@fujitsu.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS0PR01MB5873:EE_
x-ms-office365-filtering-correlation-id: 425b5bc4-26f8-4b63-30b4-08dac3abcc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozjA5njybL+Bw0KMW1qFeQijnRn2b9PATq/+eiycBPg3d1y81cT8CscGN3l9lY9bZgHJpITxq8WCGLLYtOVpxP+LRNQJLBsHxt+mcNBcyw4zSbdkRRLrE29YJPJQOjMjXsLvVC0CtqruOxRHz+b+7i/A2is+OOLHIllP1AxATUDPUVMc1SrJPlq9YAM5z0Kgq3mqvnGQKy4Y/CztBGCoYRABgJl8/arZWICp2S3idNoR9aUtph4nC/T+3BksJY81x9hD7oBg+wd2MJqM0EueseC0UJlfbnrZJut3izBS/1/ZPlK3pLGm7/yUZzwktKnbbTxqxa8fyl957AEm0nGHM/2d1OGC3v6SW0bSQkxdyJ5O2AWYLfZTis1TA/mN2ovwvhZGigD+ca44erX89IfYl3ZgrWHRDdFABNUlDKQJjbkrADQ53TElR38/icSsFsS/G6f1oxZL4G23bMKuqEyD2PSsz2WLZyodJBYexYAeDrMDExuiBsXpJ1qS2AIVrYLa9yUat5JMmzbf8JkksNjnPEfAGWbpBQDZoGxD7G94AEzsePBfFzoepazNMVY+ziceSwJBkg2urEvtXIpHevz5ZtyweA0htRsyQUDxnzcyViyUnqWcBWSYBxkrN6wfTPeMhdsHGzPpjh6JlURxaX03rqRtH7kDrOgC5evgzMhXNIO1redA1Baj/Py2x3sCLGKpTZV7A+LGRF2m1Wwk+f+5MUcmamlzTy9JD5g6voyef+WAP2Y7dSpaoBP3XmHHRsR+mWqlsiFimDZmrnn1nXR7gImee1nkzN3yBnKgGQ8oUj/I7isKePzO5keVWE7WnKzFoOkaww6B2PINCJ9YIXOsI0xPM85njGw/bADCZ4Ahdc/X7FokqLK2XbK6DdQGf3Fc3Qm9X8xbxui37/OZb8xWHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(1590799012)(451199015)(122000001)(31696002)(86362001)(2906002)(4326008)(107886003)(38070700005)(6506007)(2616005)(66946007)(53546011)(6512007)(54906003)(478600001)(38100700002)(316002)(26005)(66446008)(110136005)(76116006)(64756008)(6486002)(8676002)(966005)(66476007)(91956017)(8936002)(66556008)(85182001)(5660300002)(186003)(36756003)(41300700001)(83380400001)(71200400001)(82960400001)(31686004)(1580799009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE41MzhTMnNyZSt5U0dNL01JQVgxQkVTa0lrRktrcVBFQmNmUjc1RzUzbEp5?=
 =?utf-8?B?UFdYWHRGdWdhY01YRExiY2NWU1hIeEhiYjVpbTNmVHRsLy9Ba3VPcStqcjFM?=
 =?utf-8?B?YWtsWUJRYWphL1I2NnJuOUluSk5Ra3NpNzR0bnVuUURoYWRNWitWSXBGdFdR?=
 =?utf-8?B?RzBwRWJuWFpjU05HR0YwSk9VT2ErMUppaHNmOSsyOUVNRVlacXhnWWtYWEhL?=
 =?utf-8?B?eU43SE8wV0grdnpTT2dXKzU3a1ArdVZzL3NTL3QxaE1PY0lORWl3QkszYkZP?=
 =?utf-8?B?ai9lNEo1N0tZb3VEbGRLOFpoNTFOTlFVRGwvQ054NzEvZnduMmIyeFdZM2cy?=
 =?utf-8?B?a3N0djVwcG10bU83cCtSOXlFWExXeXJFbXBoNUVTL1ozVnlJdkduam14RTdq?=
 =?utf-8?B?ekhiZm1EOFdoRDFzU1hCNFp0dmpmeGJWZGNaS0tjMDFJaGIybExGcUxrbmFZ?=
 =?utf-8?B?M29iRGpzenhKWER0bU1ObHdXWWo4VjhvTGRnbm5CSVN1TW1YbEUvSmJsYzRO?=
 =?utf-8?B?VkgyckhQeHNPRUU0N2E5c0IzaktDY1FMNnhiOUpJOW1MZUhRU2pYcXpZaFhP?=
 =?utf-8?B?N3dpNE5neEpsTHJaUEFxZno5a0o4K2g5WG1uYzBkQ0xMVm00cEl3ZS9DaTZX?=
 =?utf-8?B?V0FQcDFyTnhpcHZndmFlaWp0cTU4K3RmVnh4S0FCaHhGelZWbEMrM3lnVGlF?=
 =?utf-8?B?ajROenE5aXZnRms1NFNzUmEyRjFVUDB2YWtRM1ZYVEtGNUhMV2JEVWJZWkh5?=
 =?utf-8?B?b3V3ajFQNXl4MmtzQWdMbG5RbWIzVlZJZ005MEI4WWFQY2R6TEdLTHVhY0Fp?=
 =?utf-8?B?VHBjRGQzdzQ0WHkwclBNVmFLWVZWNng4VDhqRlVSWkp4dlNBSUFEOFFwYyth?=
 =?utf-8?B?UzdaUGk1OVpWbDR6SUlreTl0eHUxWm1rL2x6a1FyK094OXJ0eHQvVFZHOHhW?=
 =?utf-8?B?NS9BZExMckxtSkNKWjcvejYwYjN0N2czdXlHb1htWGIrSVBhczdWQUc3Z1NB?=
 =?utf-8?B?R1dSM0xpU2lHWWVNMzlQNTlNV3h5VDc1dXNQQmpaQ0xpa2N0MFhySldGV3ZZ?=
 =?utf-8?B?ampPOTBrdlF6VWkrR296S1I2TVJUb3AycEtLYmxCMkl1U3dUaWsxTGlRTUJ3?=
 =?utf-8?B?ZlkwdEVXTy9VVXpxTUpoNjNlbmN1aXVUaUxYU0xwRXFlN1J2VEpqblVMcGwx?=
 =?utf-8?B?UHNjdjdCdzZlV2pSZkhoaitiZ0ZoZHRqNXExWEUvOUtndm5iWml2RlNpOTU3?=
 =?utf-8?B?eC9KZ29HeFNDUkFQRlFtNDVRTHYxUHphbU13dERxUER0Zjc5ak1iSjVWalcr?=
 =?utf-8?B?NHEyYWltT0hDYk8wTzQ2bnNQTzV3WWxQMjY0enZCVk1tUEN2Z1dFTWEzVWJz?=
 =?utf-8?B?bVRYU2U4N1N4RG5RWUh3OGpMeDV5TURUbDBYa2N2ejVpeEVhVVpSZHorQXFR?=
 =?utf-8?B?Nm96SWZzVjRQREJYL2pUWHpaU2tpTXlOZnUyaHNFSWRMRENjUlBJTlluWURQ?=
 =?utf-8?B?MmZnaU04Y2NQS2drZldVbUE1QlVwcThlaXdnSi9rLzE5RVFKYTRHR0s0ZEh5?=
 =?utf-8?B?QndPV1dUK1JtZzJtVS9IeTBHYUJCcWN2cFpzN2k2cXpWWi9JS0pLemJvK0xO?=
 =?utf-8?B?bldaVWQ2RURURDFVTlZaazBXU1lzaFFHV2pDRmxON1dDUUV0NFJRU0lDRTBa?=
 =?utf-8?B?VCt2UEJiclNCbXlmanhkdlg2VFBGVHZIbTdxNEdMSzNLeHRQRzNza1kxZE15?=
 =?utf-8?B?QW81ZmhkdmxCZ1RFMVkzU1Z6dlVqMWFsWnhqRmExTkdiWENRaUsyWEkxM0RP?=
 =?utf-8?B?cmFrdW41Yk9IbTNUU2J1Z1RUSFloNFB4NXhENXpEcXFJd1VSbGl6M2czOU5i?=
 =?utf-8?B?cjJYQWkzbnhwYlk1OWlTOThQOGhIa3MwSGh5RFZmbEZPc3QrMkhLaTZkRHR1?=
 =?utf-8?B?bkszUUhoOXQyQzltSjdwMDYxUTV4MDRURWJNdzlyd0p3YnhMbjN4emNkM0o0?=
 =?utf-8?B?MzFkeGJtTUV3RkVnazFlYml3RUZsTDM4MklIRjNqU2xVTHlkZ0piNzcvT2sv?=
 =?utf-8?B?TFhHdG0reTBJUTh1SGZmektBOUQ1TTR4aVRmSFFJaG9SUDVNbzMrSFp6cXk5?=
 =?utf-8?B?eWJNa21qYTlTOUthUVlUZmYvcTVLcDUyN0dsNFpxYVY3aUQyNFBXaHdjQ0dO?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A684E250BE40BF46935CFD38091235B1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b5bc4-26f8-4b63-30b4-08dac3abcc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:13:06.4491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp81VFIcpxrG7Vuf9d0g3l2iNIr8oN0mhZ5wmPpF9xWy2lfvN2wHuwXeEBvxAgmlxcaSQa5c0scs4snvHVcshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5873
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Q0MrIFhpYW8NCg0KDQoNCk9uIDExLzExLzIwMjIgMTI6MzAsIExpIFpoaWppYW4gd3JvdGU6DQo+
IEJhY2tncm91bmQ6DQo+IGlvdmFfdG9fYWRkciBqdXN0IGxvb2t1cHMgYXQgdGhlIG1hcCB3aGlj
aCBpcyBjb25zdHJ1Y3RlZCBhbmQgbWFuYWdlcyB0aGUNCj4gcmVsYXRpb25zaGlwIGJldHdlZW4g
aW92YSB0byB2YWRkciB3aGVuIE1SIGlzIHJlZ2lzdGVyaW5nLiBCeSBjb252ZW50aW9uYWwsDQo+
IHdlIHNob3VsZCBtYXAgdGhlIHVzZXJzcGFjZSBhZGRyZXNzKGlvdmEpIGV2ZXJ5IHRpbWUgd2Ug
d2FudCB0byBhY2Nlc3MgaXQuDQo+IFBsZWFzZSByZWZlciB0byB0aGUgcHJldmlvdXMgZGlzY3Vz
c2lvblsxXVsyXSBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCj4gUmVmYWN0b3I6DQo+IEluIHRoaXMg
cmVmYWN0b3JpbmcsIHdlIHdpbGwgZG8gdGhlIG1hcCBldmVyeSB0aW1lIGJlZm9yZSB0aGUgdXNl
ciByZWFsbHkNCj4gYWNjZXNzZXMgaXQuDQo+IA0KPiBwYXRjaDEsMyw1IGFyZSBjbGVhbnVwIGFu
ZCBwcmVwYXJhdGlvbi4NCj4gcGF0Y2gyIGlzIHRvIG1ha2UgYWxsIHN1YnJvdXRpbmVzIGFjY2Vz
c2luZyB0aGUgaW92YSB1c2UgaW92YV90b192YWRkcigpIEFQSS4NCj4gcGF0Y2g0IGlzIHRoZSBy
ZWZhY3Rvci4NCj4gDQo+IFsxXTogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
cmRtYS9tc2cxMTMyMDYuaHRtbA0KPiBbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIyMDExODEyMzUwNS5HRjg0Nzg4QG52aWRpYS5jb20vDQo+IA0KPiBMaSBaaGlqaWFuICg1KToN
Cj4gICAgUkRNQS9yeGU6IFJlbW92ZSByeGVfcGh5c19idWYuc2l6ZQ0KPiAgICBSRE1BL3J4ZTog
dXNlIGlvdmFfdG9fdmFkZHIgdG8gdHJhbnNmb3JtIGlvdmEgZm9yIHJ4ZV9tcl9jb3B5DQo+ICAg
IFJETUEvcnhlOiBpb3ZhX3RvX3ZhZGRyIGNsZWFudXANCj4gICAgUkRNQS9yeGU6IHJlZmFjdG9y
IGlvdmFfdG9fdmFkZHINCj4gICAgUkRNQS9yeGU6IFJlbmFtZSBpb3ZhX3RvX3ZhZGRyIHRvIHJ4
ZV9tYXBfaW92YQ0KPiANCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaCAg
IHwgICAzICstDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyAgICB8IDEy
OCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Jlc3AuYyAgfCAgIDUgKy0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV92ZXJicy5jIHwgICAxIC0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJi
cy5oIHwgICA2ICstDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCA4MSBk
ZWxldGlvbnMoLSkNCj4g
