Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415DF493293
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 02:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350777AbiASByj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 20:54:39 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:43078 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350776AbiASByi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 20:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642557278; x=1674093278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CtY3IlcR/iN2mH5Bm5f7ViNxrqktGR+/+cY6enRANh0=;
  b=PGqLwhanovJ9Vd8rgL1iduotaVNWrcuNcGe5yT3alt9MS9wfdnX1kxZy
   L90YCBiXADm/x/c98ZZnco4oeHEgHsjbK30o3phY/3j4jYij1WzeDe3+4
   OWJmWVMTAjJipWbVNwZVwzXe3b0fBx7WQ/bEHC/3qQx7pyL8yfyv/SC8T
   rRGIGmEotIXxlpRELKMVvCxPmFx6uN48mcLI3zMf0C0XfDYz/XVnLlx0V
   Ykrti5xBEv2eUZmVqwmE3rdeTtN++Lb6SBVbUkqwGgB88oENDWuZp4EGb
   1dZ6aQY8/IonmBklLz8nXXps4zXUHxVuOsTjgi9Ir1SDgvnR62XL5fVh5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="47896894"
X-IronPort-AV: E=Sophos;i="5.88,298,1635174000"; 
   d="scan'208";a="47896894"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:54:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyGzd/3PYVTkfjFUW1RylvZElrTU1jcehBUv2+Wt5/u4j1MmOm4WQzmNCaJ2lCor/dUnPspBo0MzO9XKHCgMcIH4CsQCmgnbI0rNFDzaEYOJ9JOhHTnPqfsfai5ojdx5jPiI1tA1xMd3IyBhDptuwUpkwquDrBLxBV2d3l7SlnpAD3Nplv33umUrOrdIrx67o4FIR2P8QKyOGImuEKrBU2youdpvVuiuH4uWCDunXT3pV19+TxizsZ7J26+4aE6ZN71MOiakW3T60274FPHp7fLtMRtpAQx8lA8gk+bBMNEofeRH9ww71nVZNDIz2QUncBEnH9xvLPCcivZd+Pg/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtY3IlcR/iN2mH5Bm5f7ViNxrqktGR+/+cY6enRANh0=;
 b=n0lcML367uyKt/B3F7kg8Q8RqYytZYc7hfWReXtVBbRUmMbecyWw/f+q6csYuL+568NYMvgI32iFzQ3VREg+6mfGC4fybsW4Mfq+AVw32VvyX9m19Z1fqlfBr/YFCUrudmxrze21uzuLlZVGSlYVw2sfxdIMxjrkOavdwo7XbkWh0DFrCxvwprL8Ks5YEbhgxYOrxRGxzDwNQyI7AkpT277VWs0mUS6SRtWsuzt5x+TMrK1Y8QRW87nWt+d6/fNErIsQCaYraTFIkp8xDMI8GA9HxKrAtLi8yWqv30xMGF3ddNlln1kvtBG0OWbXjkuRTQV/4UR2xV5ti6nWujow2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtY3IlcR/iN2mH5Bm5f7ViNxrqktGR+/+cY6enRANh0=;
 b=eyKTnq2wB62PkPXUObpOgvcue+kyMhEb/qjAPO36d7NbmzAwS8qQL1pjNL/dMEarKyFH7lgidNd7lJ0tYHpsb7ntg0GrISSDRAju4xJdcsPfD18vr1EqOkHoI7mZXt9lS4wCtul0IqBwatVIl4JMDm46rPbneVugxYrEI3ZcSE8=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB9361.jpnprd01.prod.outlook.com (2603:1096:604:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:54:32 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 01:54:32 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUI91epBJvsUKhqFcN98TGpqxnOIUAgAE6fICAAExOgIAA31eA
Date:   Wed, 19 Jan 2022 01:54:32 +0000
Message-ID: <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com> <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
In-Reply-To: <20220118123505.GF84788@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa4dfa72-85d7-43d5-47b6-08d9daeea309
x-ms-traffictypediagnostic: OSZPR01MB9361:EE_
x-microsoft-antispam-prvs: <OSZPR01MB9361E32534CA91B72ACAE1CBA5599@OSZPR01MB9361.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyeK50XLi4iv2CrM80DX3x8JE2ZAUFnKbaLoaGoULytiIkzue3C1a9Uj5LMz88mqpXONUCE9sMRWaSIgoLzLeqGOUOk8yb5sYWroNtSwDNTE7QBnplvtBgVDeRicQSDYFhSnRxESoYpKx0iQkRR0qkDGKjb0gWPBFthdeluwgUG7vmw2g1TF1SITFkpxDOWHRbZXdxnc2NP6539Jw7dp4auzuS6rwH/Ro9IO1SLaOrIEa5eZfKK1IUoGIzMSHiNHyfov8ezFhe1KVIWGymZsJU41JhkVuK/z56DX8y5mlaZua7Ox7PYNQ3i4SGdrWJRc5oCO90HxM0Wt1161oNk60VIjqrUEb92xgYgrp46nOVHImVbfcg9UYmEfmN3ZDn7OgY3iFQrmamfZX4SRBeGWqgfeGT7UiHEn+i3NrPSwCE3n/Pe7sU2llleJAyGcmy6H1BYXjbareCQreXjvF/miom9yiGIseShFS88KvU+w702vKK5arVizlfeXG5GsY/PwcJA9GMXDAPdvIBbIAkMsSRa9BwYIZlIJNqlHpy0kam7PdyVB04ucW4rmGYM1FNDo4n2G3sdzXJTD2y0+F0AI6K44hOfn+ekjsmC1Gp4q7m0gwikIR1ckssanUz1YlUaln4qhIHirB+5zIwXwh9c6Lzrbrd8V286MdKmLhEgt2Lr3h67B+ESZ8nIaPuXnD49SekA2IEM1blOhxeb8TAPPBs0DJWu77o5NpBS9N+V2Qg1AUIlXTzYdY16QyADwzVa3NdQbHnuB1ReCWu3ASAD94Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(508600001)(186003)(26005)(122000001)(38100700002)(86362001)(2906002)(6636002)(2616005)(31696002)(85182001)(6486002)(8676002)(6512007)(8936002)(91956017)(66946007)(66476007)(64756008)(66446008)(66556008)(36756003)(71200400001)(53546011)(6506007)(316002)(76116006)(38070700005)(31686004)(110136005)(54906003)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGdyZFV5UDh0VkNFY3hUS25GV2c0amNYMElUaXFPbzRTc1IwTjkxR3ZMaEtJ?=
 =?utf-8?B?Z1RwdzlNOEVLU1FUZ2tKSXEwQjFMZmc0Zk9uRzZ3YzlRajlzTjIzbUN0QUlD?=
 =?utf-8?B?OVN3eDJmUWhqeUphV2xVRG10WnpkUG1wd3gxMmFkMDBFTnFPNE5pZitzb2lz?=
 =?utf-8?B?UDJWZjdMMnVvNzgzRHJXUnRwNjFjZXFWMktkbnhLdFpmTUI1OUNKZ0hobHNh?=
 =?utf-8?B?bXdTVyticlFmczBub01wdUxEanlybmpXeFFYMUIzMmZXazdpWmYrbkxheGQ2?=
 =?utf-8?B?L1pSNUVWWWJZVnF0a3N4RG9kbk5FdnNMRWt3a2VGMTJPYS8yNUVBbVM5WEda?=
 =?utf-8?B?cmFzTFl6SXZJL3hkYXNwaFBJTUIyM0hJWXBRMnRVdXhWNlFEdHJueWs4M04y?=
 =?utf-8?B?M0tSQ2JqTjluTG9ubEhHeXcyNExPeWRsc3ZsYzlXK0pQMXBSdk1uai9zVVB5?=
 =?utf-8?B?NGNPZ2w0b05TVWMyZzZjS2RxM00vVkN1UFJsSHF4V2FRSVhBNnBzK2NXV2Fx?=
 =?utf-8?B?K29GTldZWWU1dFpaRFMxbnIwL2RPWnNoeSt2d0xZS0tITlR3QXhEQmx3L0p0?=
 =?utf-8?B?UU9sd3VuT1BxZGpIcjR3NXhackNiRmVUUmxreUdDQUpuQitFZWdwT1c2bTVP?=
 =?utf-8?B?N0pHKzNzSnY4dzY5VHFHNkRDc1NIcmhqN2szNEtTaWRxSEdMbXpCZzRzb3Uv?=
 =?utf-8?B?cVQ1RjMxUUg0NWcrOHc1YzFEM3krK21xNGpNSHFTUVVKTVpYZ1JYaTF0aC9L?=
 =?utf-8?B?UWp0dVBoc3I2OHBnUzV5eDQ5U1Vtc3E3TUxsNkdISjRPN2x6bS81WWM5aVEy?=
 =?utf-8?B?dFkxeG4vM1JrQ1pBelJkK3paeTFCeStsRkZuTGhIZ3dKcFF3SXdGODM3c1gw?=
 =?utf-8?B?MDlPajF4RTFSNUVQWTQ0STJFQUpPRU5lYWVPOVBqRG9qS1pBcTA4dWdtVFcz?=
 =?utf-8?B?dWljWmJNamJGc0lDc1MySy9hU2dkNXE2YlBHaytvUzF5enIrOVVYUU9hNERm?=
 =?utf-8?B?cFdyUkYvM2dQVFZubGhTMWZ3SzJXaW5ubmM5bHpLeEJNLzMvbE9KbExta0l5?=
 =?utf-8?B?M0tCRjF3bnB2elM0Q0tKVUJjdW5DK3NpZFExcGFxd1NzbkdBMFlUQTA5VURp?=
 =?utf-8?B?VmxKUXNVOTBIUUtjeW11TTdGOXRzcUcxYXhEUVpPWkRQTmVQeWJFR2k5Sjk5?=
 =?utf-8?B?cVVORWk4WXJEOEVjNkhKL0k4REgreSswemVtZ2ZlaG1oMXFSRDNUN3h0em5D?=
 =?utf-8?B?RSsvZ0pLeDgrOXlXQTdXbTBjVWZYazgxbHFFbVVKNjNuUDVabkh1MVZxeUdo?=
 =?utf-8?B?UWROSkpZeExLOFRHWi9pSE1jVWh5aURDeGtlOEx3aHI3RllRakR6VG0wZEY4?=
 =?utf-8?B?eWg3bTFIY3BtVVNWL0dEWVRLRm4xUWk0WFFUTjhPNVZNS204TGp1MEJKcmw5?=
 =?utf-8?B?MFNmMkdCakYvZWZBUkRoTzB2eEVSRkpjbDJBanJrUE9kdjFXcWVvVFV0b2NJ?=
 =?utf-8?B?NC9RU0M5aEoyaWI1WWkrV2dvYnFmNU5CM0tJcjFGOWVkcmMxRXBBcXZRaVJP?=
 =?utf-8?B?czdyeVYwbGNOOUplTk4rRm1KNmlaWHpBRWVXYkE1S1AwZW1heXJFQU8wSGxC?=
 =?utf-8?B?ZkFkbkg3UEhQQnV0Y04rRytPQWJRRy83cHZieUNMRDFlLzhid3ZTcmVuajFJ?=
 =?utf-8?B?ekVhdllyZ29sV1I0RTFmSHl4ZGFIeXNUUW1nRm9nOFduL0tqbGxaOXd4eWta?=
 =?utf-8?B?cm94OG9mSUU1dmZ6bm11VXFGWnBmSjlSeitxVjNPNWFFbTdBSThRNW5ad21v?=
 =?utf-8?B?S2lIQmVmdTlZdTh3cDhQekc3eHljNzRLM2IyZEN3MlVJbVM4aTZqcllidG90?=
 =?utf-8?B?OFU0ZGl3bm9OajFaRHpMNmloNHhkWEJ1RUcybFEydmE1dG9sT2F5d0E1UWVM?=
 =?utf-8?B?M0NRVUtQR1JYa1pwTVFWcDByMDR4QkhFc1ZEcTZzUmpZd2Q2ZldNMlJDY0tp?=
 =?utf-8?B?cUtpQy9QYTEzVmcyTi9KQVI0YWR5aEM0SG5CbFFRT3VQWDF0byswNmxPN0FG?=
 =?utf-8?B?L3oxZzdmZEVJUndRdUx0UDk2djVoNnk1eXF5RW5MSURzZGptMTNpUUMwRVZK?=
 =?utf-8?B?TWNUYnZsTVIwTmc5SW1aNjlmb3hBLzAyRHNXYWdUVVNzNTFMeU0ydmdsOXhy?=
 =?utf-8?Q?D5TeFvQH+5dj6917L1T8G+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76FB2A83EBBBEE42811C09DCE72A8F0F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4dfa72-85d7-43d5-47b6-08d9daeea309
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:54:32.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orLxnL/7SPc+OBIJ1MB1wwXlJtSwxdmgY7cEcG4Quhlxpe/e6vhmyPQtbQ4qob5S81vex4a313WxP+ObSOwecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzAxLzIwMjIgMjA6MzUsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVl
LCBKYW4gMTgsIDIwMjIgYXQgMDg6MDE6NTlBTSArMDAwMCwgeWFuZ3guanlAZnVqaXRzdS5jb20g
d3JvdGU6DQo+PiBPbiAyMDIyLzEvMTcgMjE6MTYsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+
PiBPbiBUaHUsIEphbiAxMywgMjAyMiBhdCAxMTowMzo1MEFNICswODAwLCBYaWFvIFlhbmcgd3Jv
dGU6DQo+Pj4+ICtzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBwcm9jZXNzX2F0b21pY193cml0ZShz
dHJ1Y3QgcnhlX3FwICpxcCwNCj4+Pj4gKwkJCQkJICAgICBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpw
a3QpDQo+Pj4+ICt7DQo+Pj4+ICsJc3RydWN0IHJ4ZV9tciAqbXIgPSBxcC0+cmVzcC5tcjsNCj4+
Pj4gKw0KPj4+PiArCXU2NCAqc3JjID0gcGF5bG9hZF9hZGRyKHBrdCk7DQo+Pj4+ICsNCj4+Pj4g
Kwl1NjQgKmRzdCA9IGlvdmFfdG9fdmFkZHIobXIsIHFwLT5yZXNwLnZhICsgcXAtPnJlc3Aub2Zm
c2V0LCBzaXplb2YodTY0KSk7DQo+Pj4+ICsJaWYgKCFkc3QgfHwgKHVpbnRwdHJfdClkc3QmICA3
KQ0KPj4+PiArCQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNBTElHTkVEX0FUT01JQzsNCj4+PiBJdCBs
b29rcyB0byBtZSBsaWtlIGlvdmFfdG9fdmFkZHIgaXMgY29tcGxldGVseSBicm9rZW4sIHdoZXJl
IGlzIHRoZQ0KPj4+IGttYXAgb24gdGhhdCBmbG93Pw0KPj4gSGkgSmFzb24sDQo+Pg0KPj4gSSB0
aGluayByeGVfbXJfaW5pdF91c2VyKCkgbWFwcyB0aGUgdXNlciBhZGRyIHNwYWNlIHRvIHRoZSBr
ZXJuZWwgYWRkcg0KPj4gc3BhY2UgZHVyaW5nIG1lbW9yeSByZWdpb24gcmVnaXN0cmF0aW9uLCB0
aGUgbWFwcGluZyByZWNvcmRzIGFyZSBzYXZlZA0KPj4gaW50byBtci0+Y3VyX21hcF9zZXQtPm1h
cFt4XS4NCj4gVGhlcmUgaXMgbm8gd2F5IHRvIHRvdWNoIHVzZXIgbWVtb3J5IGZyb20gdGhlIENQ
VSBpbiB0aGUga2VybmVsDQpUaGF0J3MgYWJzb2x1dGVseSByaWdodCwgYnV0IEkgZG9uJ3QgdGhp
bmsgaXQgcmVmZXJlbmNlcyB0aGF0IHVzZXIgbWVtb3J5IGRpcmVjdGx5Lg0KDQo+IHdpdGhvdXQg
Y2FsbGluZyBvbmUgb2YgdGhlIGttYXAncywgc28gSSBkb24ndCBrbm93IHdoYXQgdGhpcyB0aGlu
a3MgaXQNCj4gaXMgZG9pbmcuDQo+DQo+IEphc29uDQoNCklNSE8sIGZvciB0aGUgcnhlLCByeGVf
bXJfaW5pdF91c2VyKCkgd2lsbCBjYWxsIGdldF91c2VyX3BhZ2UoKSB0byBwaW4gaW92YSBmaXJz
dCwgYW5kIHRoZW4NCnRoZSBwYWdlIGFkZHJlc3Mgd2lsbCBiZSByZWNvcmRlZCBpbnRvIG1yLT5j
dXJfbWFwX3NldC0+bWFwW3hdLiBTbyB0aGF0IHdoZW4gd2Ugd2FudA0KdG8gcmVmZXJlbmNlIGlv
dmEncyBrZXJuZWwgYWRkcmVzcywgd2UgY2FuIGNhbGwgaW92YV90b192YWRkcigpIHdoZXJlIGl0
IHdpbGwgcmV0cmlldmUgaXRzIGtlcm5lbA0KYWRkcmVzcyBieSB0cmF2ZWwgdGhlIG1yLT5jdXJf
bWFwX3NldC0+bWFwW3hdLg0KDQpDdXJyZW50bHkgUkRNQSBXUklURSwgUkRNQSBBVE9NSUMgYW5k
IGV0YyB1c2UgdGhlIHNhbWUgc2NoZW1lIHRvIHJlZmVyZW5jZSB0byBpb3ZhLg0KRmVlbCBmcmVl
IHRvIGNvcnJlY3QgbWUgaWYgaSBtaXNzZWQgc29tZXRoaW5nIDopDQoNCkRvIHlvdSBtZWFuIHdl
IHNob3VsZCByZXRyaWV2ZSBpb3ZhJ3MgcGFnZSBmaXJzdCwgYW5kIHRoZSByZWZlcmVuY2UgdGhl
IGtlcm5lbCBhZGRyZXNzIGJ5DQprbWFwKCksIHNvcnJ5IGZvciBteSBzdHVwaWQgcXVlc3Rpb24g
Pw0KDQpUaGFua3MNClpoaWppYW4NCg==
