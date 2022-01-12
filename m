Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C3348C0F5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jan 2022 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiALJY0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 04:24:26 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:56579 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352031AbiALJYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jan 2022 04:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641979464; x=1673515464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TT97TifCDLJWGOWw3swZ0J3oS98ZbcnWQb0A3+Kjzvs=;
  b=lDeNok5fsgwlz0l1O8nBFmcbhhDXh0tMuMH8s0JY40ACyMHNHXRNT8pC
   EsBUjCxXknVmNK3H6O1hDa4cFRRqYzRJSiNKc12zCfN8DFi7cWeYlGc6z
   EUZ4gst4MO3pNdK1weSS4ZCrdbC6ZWpX0pXjALf7izpagizWXZPiiiSVy
   Cu9IJOYIJJ9jdmaajZH0tMptQKleMarvnl+M9YXFEnX0EteLTCGT4q/LO
   untPntnY94GRPMqLq+Er9uNhWtQ7ILIr4nczaYZel4cL3R8fdiZubarmP
   wcsk+/+U5oY4N7pV3hJft/IVW1I0t6bSCP6RfYjbwGiLsouGeydKUFqK1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="47328048"
X-IronPort-AV: E=Sophos;i="5.88,282,1635174000"; 
   d="scan'208";a="47328048"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:24:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvSbKsV5OEL2FB+J+4WWGe9/yNk+4PAlC7o1qChZO7EPSHjcNw+uYbqj/HFl2kf6jb0aRknO4HytR/zyV9SAUp6P34yFeFv5hN3yR7wuy400+GaQ1/tK/OHvJrQnIS4prr1fkRJyi5iQGijaovRi3vX8MtVL40OloIyJTuTjOppr6Q3ao+47gqQRevPkGoBQcqkwGRz1Lq5XPD/LjNLfLJyIrbXZUeXzL0xSll0UyEVavnFgluBQu/ssLVJG9WWUaUiwtTkPo6Vf/7igKC4fGZr+0tbluMy8o/Q2VKlzfQmT0Mq80xoewuZjCOVsN9sK+R3ZWLq497ZJryw44l+Ctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT97TifCDLJWGOWw3swZ0J3oS98ZbcnWQb0A3+Kjzvs=;
 b=f70dLSg6XLX0e+DTkibXbSMSfE2iSgq1p8qN9Pl99pLkvzcBHgrbJsamjHJC1kyMiGDpNbkQ3K2MNlkie83DqUycdxgMYFLkd0GT0MWVmFMablIw02ZT5qU94pK8ixY72wFf60F3wv52IJ6guu3/E61S2Ip9BorPh76N0S0o/KVMXvSrqAJnVNz8qUCKpNRUqm/jgiv9y+RPH+lH7XiIChLBb6ReqqRIYW9frQI+4PhMOrhvaUs+418gE2eMHity0vlBMf8WSklh6ZjIy91D+7n4fQ3txaOTvxWJLJnGx1JQYnP5QUtBLJqdxfHhohGWQeIpsBvQbPK3k7AFlICdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT97TifCDLJWGOWw3swZ0J3oS98ZbcnWQb0A3+Kjzvs=;
 b=XPPrGXRLdzlB4f+WfYvS2g7dCPiLv16iH6oZ4Q7Vme6DXRPW1oN1S8l2/EOPLaAAZjJ2IYDpdzjtDypEqWBRXYTKYz+ZJgfNQYLk5IFKh3zGtsjfdrbYvZSW9sBO6eV6yzDwWpUplo5Wo3/79+60xAwE5h3grEqQSn8o04FWxiM=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB2484.jpnprd01.prod.outlook.com (2603:1096:603:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:24:18 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:24:18 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbsojLLXTBWKk+I52jDqCmDKaxLkGOAgAC1nQCAAG/4gIAHexAAgAOQtoCAB2+pgA==
Date:   Wed, 12 Jan 2022 09:24:17 +0000
Message-ID: <61DE9E3F.4020202@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <61CEBF4E.1090308@fujitsu.com>
 <0a226c28-9565-55cf-7680-432b28a02cfb@talpey.com>
 <61D563B4.2070106@fujitsu.com>
 <130d8b4d-3565-eba1-c56a-58155d3303b2@talpey.com>
In-Reply-To: <130d8b4d-3565-eba1-c56a-58155d3303b2@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48730e4c-10be-4a4b-5481-08d9d5ad4f13
x-ms-traffictypediagnostic: OSAPR01MB2484:EE_
x-microsoft-antispam-prvs: <OSAPR01MB24848CD6C8C6385113660BD083529@OSAPR01MB2484.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jVsomBupiveohVVr/p9ILS2VAivm2FYkC9sGAgtzvIoPyskwYr5VXP2zTBcE3VEGv9Z+/O1jU6GIO2uam6dsrefsHJ/dpUApuY4UtDAyGLm6Gj7g3GeiawLQQD7CWI/V886/hP0jHSFCMWoFOi10zShNAa8g8cGPtOsXVSFS5inTvaEk5/WDP7tOEcZnKbJZdeAzZR7ohCrGufAJOtqGA+5niLQ9feeaHL7/u02I1VvH01dwvGgFuBwU3piIwSS3lIIgZKUzKsVFOa0VEiYC3Npa+sfqZWRf5vUbzwK9zEzPExZFHeuxFJU28W7BMfd+pyc1XI35OHK8YzEcrnHSfK7jVALKnvOzmjbWwy9vFf3AoqC5zoLHYeYA37tNzUe7ybp3qf52gjJ+COCfBSYKkEHMoZUHtoMk5MegYbFhnvm6OenVxBjsiLMC6y2MYXX++1m8MqzfJkm6QiQR+V+D5epgaBWfFZtytOtg7QE8Ju5daDcgNVC44WeAL+T21FUFh+/IknWSrdpLxckTz+L/S7TulWeB0fOKWq0EWcD01Fgi2gG/yOMJ9fMsrSeT/3DC8BVhLYOifc1l10ehovUCwLxwaA2cTmGkk2CQka98eNOi6Nv2pfCmAVM1oGOcibMrhXkz/t5KrrcLJv2ic5pSLc/3JnNczs/fsKqX1F/33rZxnfxl5ZlZsABqq6o04tqM3hq/liN4mekeh7PWIVxEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(66556008)(38100700002)(66476007)(66446008)(91956017)(508600001)(2906002)(6512007)(85182001)(64756008)(8936002)(76116006)(66946007)(186003)(6916009)(26005)(71200400001)(82960400001)(4326008)(2616005)(87266011)(316002)(36756003)(86362001)(83380400001)(122000001)(54906003)(6486002)(8676002)(33656002)(6506007)(53546011)(4744005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry9KcElhRXJGcE40cWNJUlhTUHZTbFFyS1NUSC9JZFRLOTNGWC9lQzVYWlVx?=
 =?utf-8?B?ZEZjc3AyUW14T2FKVVdScEh4OTBsUEhtb1JXMlQwWmw0b3hFTjBxMkJHYWx2?=
 =?utf-8?B?bzNrWFVUeGN1VDM2Rzd1TllwK2V4TVpJaVNnUXJIWmZjdnlqTlNoRk5heFNB?=
 =?utf-8?B?UlA5b2hydjNQKytscGhIQ3BmQnJRK1laRzQ5WGxkQ0txWlpwdG5Za0kyd2dV?=
 =?utf-8?B?SnB0UWM1VFcza3VGckRxQ1ZxZUNIczdpQnNtNTFMbHpKOTZ2OFl5YWJHdk8x?=
 =?utf-8?B?NnpiQnAwVVpDTzNnNUlYdlBvWEhxYWswRkZCMnpjblU4YkU3UGpERG1OMEZ2?=
 =?utf-8?B?VTByMG1EYkxNa0ZsTU1QS3dqK1NBOFl1SUwvbzNxSXlPbkFrd2hDZHF6TUwx?=
 =?utf-8?B?d0ViV1JTTm90U3JuZkZ6WnhITEtMS2ZnRzJ5U1ppUnpteGNzM2V1dG0wcDJH?=
 =?utf-8?B?Uk5TNFZtcUlMOGF6d1JPQ0kzeGRFYVRFcTJaQm1TQW9ra1crNGxoaE9LWWdE?=
 =?utf-8?B?T3k5Wi9vRnhVQzFCN2FSSTEzMDA2NENOZkdYZnBEb2RIWjBwSWoxVmJtQ1JD?=
 =?utf-8?B?Syswb0NjbjhDWGZtcEN4Ylk0K2lCM2NWMXVaaFNaV2Y0enlnZUpRSjlLK0RT?=
 =?utf-8?B?RS9aTXFEejllYTEvdzZBQnZHWnF3ZmtJb0pqT09MMzdhSjJqdVF0eU03NUVk?=
 =?utf-8?B?emE0WE1pSXovM09vT1JqL29nY1hTZlpwbURBVW1aNXlKd3F3UTRyYW12RDd6?=
 =?utf-8?B?Vm9NV1FZRStmaFQ5cmVydWJkd0VoSko0djhMNmhud05LVi95enk4M0wxekpx?=
 =?utf-8?B?b0ZHWGhGS0tYRVFLN2NIK3d3ZGtLenUzNFp5ckhkRU1yUmsxclZIZlZ0Nmoz?=
 =?utf-8?B?QitTWGZ6Rk1OUHFCYXV1ekdrRHZTOUFsdWpyTWM5U0tyNk1vTDlOUE14c2l5?=
 =?utf-8?B?S2RqSmFGSy9ndlF2NzJub2dianAwTmUrMy9LQlhGbUVxZUVZQmJ3MWpKNHND?=
 =?utf-8?B?Q01pUzlJNU43WlF6bGtNSFpNU3F2NEhMeElITXZCdUxVaFVNczc3bDVEU0J5?=
 =?utf-8?B?Y05Uekk0ZEtabE1UQkRnWG5LVUlpTFNrQU9PeDErSmdzdnNTdkNFT3pUaVA0?=
 =?utf-8?B?WlhRaG9VYWNPN3JuUXBXMHVvK3NqbXNBejU5bkMvd2JMK0VVaGtaSzNnNjJL?=
 =?utf-8?B?dmNmQ1NxWFZOOXlUdGpHQWlIL1A5ZStQLzFENE82VmhiZS82VUplK05vOENB?=
 =?utf-8?B?SHlPd1NZSGsySEM3VzZoZ2pFd0c4M2tJU2tmcjljK282SDNiMVJybkg0TlRB?=
 =?utf-8?B?ZmtFaGRmeWIvNks1QUJxemdyQ1RiTzlReTlESFA5MTFPazY0b24wSzYxaGFv?=
 =?utf-8?B?alVjNGU4MzBXc0RYUitXTS81Qmt3YkJyaG02Wmt1SjlRWGdNOFpHWUlTN0ZJ?=
 =?utf-8?B?NHMxR1FMRXVnOUhLWjVaMitTd29vemZ5bWxreFpnZUFoSW1KeHE4STNLc0Vw?=
 =?utf-8?B?dmtaTE9iRzhsQTRiT2h3Rk0rMElFYWlUSlBRYnhvZW9BV2RqeGwwZThvZzFo?=
 =?utf-8?B?VGpOQkw5UWswL2dQdmNvcnljRTVWNU0zanBkayt5Q1NYWFBORitla3NqUDBU?=
 =?utf-8?B?dTJwWnRhWUtxdVkwSG52bG9wUDBPQXM2eVNUSk5RWGFoVGNyRWVJYjQzc29p?=
 =?utf-8?B?d2tYTmJUbWx3WVZiWURIbHkzNTVwVDVaR2QwMFJrUVZaNEU2aUJPMmNjZkZB?=
 =?utf-8?B?Z05ySkZHVDNqS2RYVS9CWHE3NnEyM3lpZEZtYk1ibm9qUkhJWFZjWTVFR1gv?=
 =?utf-8?B?TjNNTkZXc0wrejE0UWtMSVNadHNRU0l4cUY5b3RLM1pJa0xBZjVyMlBlYTZ3?=
 =?utf-8?B?TStSeHZnMGJUbUw5MXVZa2dLV2pWandYWUVaZEVGcFlNdlJzM1hOMTdTS2J5?=
 =?utf-8?B?b2FSZ2ZNbVR6OUE3TCt6b1ZEZzBvK0VxQVVCNkJRRHg5RThpR29pZmRLeHRi?=
 =?utf-8?B?YWhjSVREQVA2WmFLNEZQSlNrb2Vlaytmc2hEMEdRSFN2Z3VXYUxuUlRGSXY4?=
 =?utf-8?B?RHA5MVE2SGpiVWVDNVBDa1NyWFJPRWMxTmJOOU92enBoeWxCNEwwU3UxQVNy?=
 =?utf-8?B?VUN1M1QwZWNIUFVnMVVFMS9jUXJpejVjNzBCdFdlUmZ0OUNORkVYL0k2N3Jl?=
 =?utf-8?Q?6irD5ZJqOlWV4+V0Kj8lcUw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D4E21E5DE830D41882E75275EBB92FE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48730e4c-10be-4a4b-5481-08d9d5ad4f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:24:18.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTq+J8As90ie8FJaEgwVR5cwRDLWhCEuWX9dQXGu/7zHUu7puyYVMpqXQVAKFqHhVDelB6hRJKUKMk0+a2wzew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2484
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzcgMjM6NTAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+IEFsaWdubWVudCBpcyBvbmx5
IHBhcnQgb2YgdGhlIGlzc3VlLiBUaGUgaW5zdHJ1Y3Rpb24gc2V0LCB0eXBlIG9mDQo+IG1hcHBp
bmcsIGFuZCB0aGUgd2lkdGggb2YgdGhlIGJ1cyBhcmUgYWxzbyBpbXBvcnRhbnQgdG8gZGV0ZXJt
aW5lIGlmDQo+IGEgdG9ybiB3cml0ZSBtaWdodCBvY2N1ci4NCj4NCj4gT2ZmIHRoZSB0b3Agb2Yg
bXkgaGVhZCwgYW4gdW5jYWNoZWQgbWFwcGluZyB3b3VsZCBiZSBhIHByb2JsZW0gb24gYW4NCj4g
YXJjaGl0ZWN0dXJlIHdoaWNoIGRpZCBub3Qgc3VwcG9ydCA2NC1iaXQgc3RvcmVzLiBBIGNhY2hl
IHdpbGwgbWVyZ2UNCj4gMzItYml0IHdyaXRlcywgd2hpY2ggd29uJ3QgaGFwcGVuIGlmIGl0J3Mg
ZGlzYWJsZWQuIEkgZ3Vlc3MgaXQgY291bGQNCj4gYmUgYXJndWVkIHRoaXMgaXMgdW5pbnRlcmVz
dGluZywgaW4gYSBtb2Rlcm4gcGxhdGZvcm0sIGJ1dC4uLg0KPg0KPiBBIHNlY29uZCBtaWdodCBi
ZSBNTUlPIHNwYWNlLCBvciBhIHNpbWlsYXIgZGVkaWNhdGVkIG1lbW9yeSBibG9jayBzdWNoDQo+
IGFzIGEgR1BVLiBJdCdzIGNvbXBsZXRlbHkgYSBwbGF0Zm9ybSBxdWVzdGlvbiB3aGV0aGVyIHRo
ZXNlIGNhbiBwcm92aWRlDQo+IGFuIHVudG9ybiA2NC1iaXQgd3JpdGUgc2VtYW50aWMuIA0KSGkg
VG9tLA0KDQpUaGVzZSBpc3N1ZXMgY29tZSBmcm9tIGRpZmZlcm5ldCBhcmNoZXMgb3IgZGV2aWNl
cy4NCkVpdGhlciBhdG9taWM2NF9zZXQoKSBvciBzbXBfc3RvcmVfcmVsZWFzZSgpIHJldHVybnMg
dm9pZCBzbyBob3cgdG8gDQpjaGVjayB0aGVzZSBpc3N1ZXMgaW4gU29mdFJvQ0UgZHJpdmVyPw0K
U29ycnksIGl0J3Mgbm90IGNsZWFyIGZvciBtZSB0byBhZGQgd2hpY2ggc3RyaWN0ZXIgY2hlY2tz
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmc=
