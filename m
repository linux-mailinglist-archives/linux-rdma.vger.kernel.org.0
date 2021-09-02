Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCC3FEAAE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhIBIgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 04:36:02 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:17572 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244387AbhIBIgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 04:36:02 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 04:36:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630571704; x=1662107704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OzJVkHY6QdPc/VBU6yFIsSHeii4/qid9HdOl56kONkE=;
  b=D7ia4NnwFLwr46RJXkVOUXxCoQfEHuop5EZT+AreGfwD18QHgM539k+8
   xNtx5sqq2ife757lRbNJAbplilFXD8oZiRhcqDHhwosFRA02tDdQ39lhi
   JAmDjvQcjeEX1mP8eQZKllcmF0BnCwT7vFUcuQfFaKuL7Tz585AlHGdoZ
   dPKgVy87SUU6btZbnwB5zPHXVrJC5+Jzdwd2P9xu+I6K1o1zVrCUVMQKN
   Ft4HmfFfpkp8LwNuX8rF6fIHGS2nXm09z6lS1WTpJ4AOEq9GXbOYTiBws
   mYSrdtSv9zSlDUEsB6Lo0ROL+BlwocizGByLfjEoRauuxgkgvY+QDONVs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="38572148"
X-IronPort-AV: E=Sophos;i="5.84,371,1620658800"; 
   d="scan'208";a="38572148"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 17:27:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+3TkrAFEJNb7Q1fSNRDqswZ5HCYKRrar+Kzp1W0UGUllta14LhErEuo/PAFIaae4Mwnyv51rjKqNk3aiubCc3xuSnf8iUFJ83WHZbrpNns7sC1FTpHqPt7oG665aC5z52mKCP8m7tS/crt0WyRx4U7kGCriOA40yG+9T6GPnMJWaXqXokGjyF2YXrKI9HapThQnxUNH3DDl7197HAsF2nYYrKlg0WPewfRwHQbREltn9z4u9nfv2XsPpsRPfg6gTsHe7k74m+OjkxwNQNs3SpcPOtyZByqts+kcCQ813vfz0sdzyy5VQpM3tGban5VvhgmRup1XfRmsMjgnuSI4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzJVkHY6QdPc/VBU6yFIsSHeii4/qid9HdOl56kONkE=;
 b=MdQPRaEGZxhLETy7YJxihr6udiERKw1rWKECMfA4yTBKU6sg4iagVY24rbEAzYg/Q92LQO+fmvqkKnmEBArCl1KGu52NIk4QA/BGvhTTyivm5WexLNH6M51MeYZ4HPoaIIZKXq2Bohtrd/mmXooy/v9hb1FxOpjKKBl79EdiLWbM2ExMkJtOZVImSW95uyhHW7t3HX6Cg4trB7wI0wOXkcNBtKsiiDra8dCXIDvPEHDpAbOTC96rXt1bnA4Mbqguu2mOiZGlXCMR0+qmQ7sneFW/V/kVpoImI/Bu+ylfEkariUv+tTbG9lsmvcviqHsXi+yUk31wmAS5bz6kVFVzSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzJVkHY6QdPc/VBU6yFIsSHeii4/qid9HdOl56kONkE=;
 b=bBXzlHwq42Clghn1nLtZR+slhQYDVhwf3LJMgBmc0bPtwE9hCoMyH/BU4sQwJ4RmFh6DcJ+d8SBFHwysrilqKqqdcrZl5oFcRShGd9rgQOXWXitx6YKcbYgroVzci4umWlCZ7lPOTe2Ao8XPjlG0TJCI3Tp9kELPKLzHDJEufc0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSZPR01MB6583.jpnprd01.prod.outlook.com (2603:1096:604:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 08:27:50 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2%6]) with mapi id 15.20.4457.026; Thu, 2 Sep 2021
 08:27:50 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Topic: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtyBf+AgAOEzwCAAPqWgIAJ3fuAgAOtywCADH1NgA==
Date:   Thu, 2 Sep 2021 08:27:50 +0000
Message-ID: <61308B01.9050706@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
 <6122FAE1.4080306@fujitsu.com> <YSYQ6hLAebrnGow6@unreal>
In-Reply-To: <YSYQ6hLAebrnGow6@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7df6a510-db94-4ada-f3c8-08d96deb8d8b
x-ms-traffictypediagnostic: OSZPR01MB6583:
x-microsoft-antispam-prvs: <OSZPR01MB658333F61066980332D0B61183CE9@OSZPR01MB6583.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMg7CaNvOlkdQmFTVZ9s9ASXBvjc6S2sN6shICDKozaC0hBCgvUNEUV4uB6YGZOqoqgljHKkISGqipguw+y67vML+KvkZqmt0x8e8M7I338/PRW2qXyoQrKXI/CdgTBEReXpgjT6m81+/9UUV641WRl9DEWDLOrvwW/fp9Fn0d7+GOQBV7AW3eAQH3IB+vm/hQPlAfDFVTb3DIuo9sAvd7zMid4r/u6+XuVrTxTE5lcus8zTVdLfjdtpL6hAJ2MEOrysVRUpJehiXBdiKY3RFSLzMf+zKrFWS47DMD+EACkNSe1jTispYOxXHhrdlbIDdbRCNU2YwhzX36N6rNB/k2Fxvri5s9TX5BXTdcZA4w9EvQI6EmdD61YTvKiuDu8lDlazhiuU3SrHKvbx1cU0XhOrWQ2l1ci1nbWuKugtMLumI2ptPBNKxefqhFpmNYNLUeR3Lt4MyInyS+SpYx4VDy8vYX1wNhCFyUbB/irwGZX5ovyKEoiSfE+QANeF90t8pewWD4is1AO2IFIAPVo9TFQgXqnC5HITuEBCe8NYudd4MiQkyYL7lvUFs6DcGjaDh3z8QBqKEaBN6gchyliUoEL8L/zDHn1tKHgswL83Wwl2KMiy1ahUASLGcWixtf+nbHG6Qbvw+ya5O4YPIM7StSUsJMr2IV+ScD5VNVT6Yt0MqdZlQa5FA9GYVVjnzPtsu+r+sDye/t/zCmFxA8zFxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(186003)(36756003)(2906002)(26005)(53546011)(6506007)(38070700005)(85182001)(66446008)(64756008)(66556008)(6486002)(4326008)(83380400001)(66476007)(71200400001)(8676002)(33656002)(2616005)(316002)(86362001)(6512007)(8936002)(5660300002)(54906003)(87266011)(122000001)(38100700002)(478600001)(110136005)(66946007)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZaMzNQUTZBa0M0MXRPRmNUVDNybEswZmRzWkxxR2hYWVJIeHpKNzZJUFh3?=
 =?utf-8?B?TDBGZWdaNE4yRVpYV1dQTGV3alZYaXB4aTBBM21sNS84VFV0M1ROYmZLYWE0?=
 =?utf-8?B?VmNBS0U0WmYzTUYwb2ExNklqazR2VmRPa1RwWnVQcGV4NHFlWVNGOVVHbVVh?=
 =?utf-8?B?UlIwelRWbDJJdFlmcGJhOU82QkxySE1FM1RhL1Y3bWI5dzJNSmlUaytpOXhy?=
 =?utf-8?B?TnlsU0xHLzVYNlRXK25LT0UxT3RRdlQ3THpXUkd1QWc1dFFnWEJGS1VnM1Yv?=
 =?utf-8?B?S1JMMTRsbFVBM0o2eHgzbnJ0TWFucGliZmxwWXY5UU1KVXQwa1VVdEhuM0ZG?=
 =?utf-8?B?WEhrdjYzL3BwdlEwOFNEMnFoUDBIQU5ic2FTNFZhQUo5RXpRZEw4TGthc1Fn?=
 =?utf-8?B?TE9MZ2g5Q0hIRjhvR1h4dERzcXRDTmNvc2pKSG5FejAzNWJWNUt6R0ZsZWhl?=
 =?utf-8?B?UnZPZllvV3JFUGxCUEhXaVkrcFVWRlNlWUlGWExveTJaQXlpcTM1SHpaeGo3?=
 =?utf-8?B?VUMxUXd4em1yVjQrenRMNm80a2FBWktGUU9hcXVRN3VUMm9OSnJ6RTdEUGY3?=
 =?utf-8?B?RWNCMGFKM2hZd2k2QUYrcWM0b3FFeG05L1dScDVZZG1jMjJjWVBzVjlUWG83?=
 =?utf-8?B?cFlOUXlyblVuL1oxWXVmWmU3b2dzYk02dmpoQnFTUGxRYm5reTFLR2hYV0JJ?=
 =?utf-8?B?VG0rKys0aGpuOXR0c1VzVlZ2Tk1hWGowUWlzbnorbjZBL3dnRzlSbmlLL0xS?=
 =?utf-8?B?czlKbXJPdWNKanc4NXdlTnlJc1RpRGFTdUc1UGV3b1ZSQWR1VmJsUlNkTytH?=
 =?utf-8?B?NmN6TVRWSEt5R1MwNmh5ZE9aMW9DbWU2V0NiV2J4blA2TUo5d0ExaGVEMGNO?=
 =?utf-8?B?MlBwWkVxa1prU3gwTUtKNE5vMkdsQnF5MFk4endERVpZME1uNWNta2RvU2tl?=
 =?utf-8?B?Zll2bWV6SytlRjV6Qzk1M0tsVFlDTnRSUVJPVG9Ba3ZpREhxS1ArUDlieFo3?=
 =?utf-8?B?MTlkNVM2OUF1WmdmdXozdmZUL2x1K0p5VGpsYlRtUjhHY1JRY1UwbEhLR2ZU?=
 =?utf-8?B?RVo4Q3JnQ011VG5PdGNhamtiZmVUd25VUUlqUnNKKzdOd3ZvMmpIaFdWUjEz?=
 =?utf-8?B?anNBeXg1V2hablliYXNZb3g2RUozczFSd1duaUxYQ0Uwd3RVZ24zNS9hR3Nx?=
 =?utf-8?B?c3NOSXpXTG5aZ1dWS3Rxdlk3OUNtay9KZkR3SENFRmV3eitiUjhhU000OHhs?=
 =?utf-8?B?ZlNDMXdISTlVS0VJNDNpRlJEZTBQcmIxVEZwR2JQRWcvYWVObE5xNjFiL29t?=
 =?utf-8?B?WTVpb2xPYjB0NDFKQ0ZiODc0c2JXUklYZ1JvWTFtY2ZUY00ydFRUc202MWdi?=
 =?utf-8?B?Q2plTHFJRXQyTWpXMlR4ckFWRzRqbnpuZ2ZSRmJqSmp1OHRWWFdHeWcwSFZI?=
 =?utf-8?B?elVobVh0TFNmQlFtUGM3VkhaaldqNm90dGg4RHFHQUJGcUg4M1Y4VlNnM2ls?=
 =?utf-8?B?ZFpwWXJpaXlGU0t1MVE5Z1AxbjcrWHp6bVhlMmZUZzlteTR4SG1GMkhpaDZX?=
 =?utf-8?B?YzVUQlJsU1JrMVJ6eWhwWmNOR3dudTBZWE9kV0NGak9kRHVTMXNBNlJWYTZN?=
 =?utf-8?B?Ymo3eUcxMWo1MXozQ1pIeExZM0FnRzl0QWVDbGxJanRlL1ljeDN4eW1kMDU2?=
 =?utf-8?B?SkpXQmdsQmdTdWVwM2kzN2djUk9xQldsL2lQWGF0N1VLOVVCeEVwQWFXUTRT?=
 =?utf-8?B?WEZkTUl3ci91Sit2YXpjZEhLR0hmbXQrb2F3Q3BjSkRGaVEvQlo2Q2grZHVM?=
 =?utf-8?B?WWRqU3JkZDdDWnZKQi9vQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <20B7D3B95717C245ADC6A2AA26107DE6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df6a510-db94-4ada-f3c8-08d96deb8d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 08:27:50.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XewrK3wtKxPC1aR17PrweSrOcl4MWxZKB+stw5uvcnd1Jzhy9b22FU+peZ+y015Mdfz6H+EWOI8Gpm0NEadxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6583
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgWWFuanVuLCBCb2INCg0KUGluZy4gOi0pDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0K
T24gMjAyMS84LzI1IDE3OjQ0LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDIzLCAyMDIxIGF0IDAxOjMzOjI0QU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gSGkgTGVvbiwNCj4+DQo+PiBDb3VsZCB5b3UgcmV2aWV3IHRoZSBwYXRjaD8NCj4gVGhl
cmUgaXMgbm8gbmVlZCwgSSB0cnVzdCB0byBaaHUncyBhbmQgQm9iJ3MgcmV2aWV3Lg0KPg0KPiBU
aGFua3MNCj4NCj4+IEJlc3QgUmVnYXJkcywNCj4+IFhpYW8gWWFuZw0KPj4gT24gMjAyMS84LzE3
IDI6NTIsIEJvYiBQZWFyc29uIHdyb3RlOg0KPj4+IE9uIDgvMTUvMjEgMTA6NTUgUE0sIFpodSBZ
YW5qdW4gd3JvdGU6DQo+Pj4+IE9uIFNhdCwgQXVnIDE0LCAyMDIxIGF0IDY6MTEgQU0gQm9iIFBl
YXJzb248cnBlYXJzb25ocGVAZ21haWwuY29tPiAgIHdyb3RlOg0KPj4+Pj4gT24gOC85LzIxIDEw
OjA3IEFNLCBYaWFvIFlhbmcgd3JvdGU6DQo+Pj4+Pj4gUmVzaWQgaW5kaWNhdGVzIHRoZSByZXNp
ZHVhbCBsZW5ndGggb2YgdHJhbnNtaXR0ZWQgYnl0ZXMgYnV0IGN1cnJlbnQNCj4+Pj4+PiByeGUg
c2V0cyBpdCB0byB6ZXJvIGZvciBpbmxpbmUgZGF0YSBhdCB0aGUgYmVnaW5uaW5nLiAgSW4gdGhp
cyBjYXNlLA0KPj4+Pj4+IHJlcXVlc3Qgd2lsbCB0cmFuc21pdCB6ZXJvIGJ5dGUgdG8gcmVzcG9u
ZGVyIHdyb25nbHkuDQo+Pj4+Pj4NCj4+Pj4+PiBSZXNpZCBzaG91bGQgYmUgc2V0IHRvIHRoZSB0
b3RhbCBsZW5ndGggb2YgdHJhbnNtaXR0ZWQgYnl0ZXMgYXQgdGhlDQo+Pj4+Pj4gYmVnaW5uaW5n
Lg0KPj4+Pj4+DQo+Pj4+Pj4gTm90ZToNCj4+Pj4+PiBKdXN0IHJlbW92ZSB0aGUgdXNlbGVzcyBz
ZXR0aW5nIG9mIHJlc2lkIGluIGluaXRfc2VuZF93cWUoKS4NCj4+Pj4+Pg0KPj4+Pj4+IEZpeGVz
OiAxYTg5NGNhMTAxMDUgKCJQcm92aWRlcnMvcnhlOiBJbXBsZW1lbnQgaWJ2X2NyZWF0ZV9xcF9l
eCB2ZXJiIikNCj4+Pj4+PiBGaXhlczogODMzN2RiNWRmMTI1ICgiUHJvdmlkZXJzL3J4ZTogSW1w
bGVtZW50IG1lbW9yeSB3aW5kb3dzIikNCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmc8
eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgcHJvdmlkZXJzL3J4
ZS9yeGUuYyB8IDUgKystLS0NCj4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVy
cy9yeGUvcnhlLmMgYi9wcm92aWRlcnMvcnhlL3J4ZS5jDQo+Pj4+Pj4gaW5kZXggM2MzZWE4YmIu
LjM1MzNhMzI1IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL3Byb3ZpZGVycy9yeGUvcnhlLmMNCj4+Pj4+
PiArKysgYi9wcm92aWRlcnMvcnhlL3J4ZS5jDQo+Pj4+Pj4gQEAgLTEwMDQsNyArMTAwNCw3IEBA
IHN0YXRpYyB2b2lkIHdyX3NldF9pbmxpbmVfZGF0YShzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCB2
b2lkICphZGRyLA0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgICBtZW1jcHkod3FlLT5kbWEuaW5saW5l
X2RhdGEsIGFkZHIsIGxlbmd0aCk7DQo+Pj4+Pj4gICAgICAgICB3cWUtPmRtYS5sZW5ndGggPSBs
ZW5ndGg7DQo+Pj4+Pj4gLSAgICAgd3FlLT5kbWEucmVzaWQgPSAwOw0KPj4+Pj4+ICsgICAgIHdx
ZS0+ZG1hLnJlc2lkID0gbGVuZ3RoOw0KPj4+Pj4+ICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICAgIHN0
YXRpYyB2b2lkIHdyX3NldF9pbmxpbmVfZGF0YV9saXN0KHN0cnVjdCBpYnZfcXBfZXggKmlicXAs
IHNpemVfdCBudW1fYnVmLA0KPj4+Pj4+IEBAIC0xMDM1LDYgKzEwMzUsNyBAQCBzdGF0aWMgdm9p
ZCB3cl9zZXRfaW5saW5lX2RhdGFfbGlzdChzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCBzaXplX3Qg
bnVtX2J1ZiwNCj4+Pj4+PiAgICAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAgd3FlLT5k
bWEubGVuZ3RoID0gdG90X2xlbmd0aDsNCj4+Pj4+PiArICAgICB3cWUtPmRtYS5yZXNpZCA9IHRv
dF9sZW5ndGg7DQo+Pj4+Pj4gICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gICAgc3RhdGljIHZvaWQgd3Jf
c2V0X3NnZShzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCB1aW50MzJfdCBsa2V5LCB1aW50NjRfdCBh
ZGRyLA0KPj4+Pj4+IEBAIC0xNDczLDggKzE0NzQsNiBAQCBzdGF0aWMgaW50IGluaXRfc2VuZF93
cWUoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByeGVfd3EgKnNxLA0KPj4+Pj4+ICAgICAgICAg
aWYgKGlid3ItPnNlbmRfZmxhZ3MmICAgSUJWX1NFTkRfSU5MSU5FKSB7DQo+Pj4+Pj4gICAgICAg
ICAgICAgICAgIHVpbnQ4X3QgKmlubGluZV9kYXRhID0gd3FlLT5kbWEuaW5saW5lX2RhdGE7DQo+
Pj4+Pj4NCj4+Pj4+PiAtICAgICAgICAgICAgIHdxZS0+ZG1hLnJlc2lkID0gMDsNCj4+Pj4+PiAt
DQo+Pj4+Pj4gICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGk8ICAgbnVtX3NnZTsgaSsrKSB7
DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KGlubGluZV9kYXRhLA0KPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodWludDhfdCAqKShsb25nKWlid3It
PnNnX2xpc3RbaV0uYWRkciwNCj4+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQm9iIFBlYXJz
b248cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPj4+PiBUaGUgU2lnbmVkLW9mZi1ieTogdGFnIGlu
ZGljYXRlcyB0aGF0IHRoZSBzaWduZXIgd2FzIGludm9sdmVkIGluIHRoZQ0KPj4+PiBkZXZlbG9w
bWVudCBvZiB0aGUgcGF0Y2gsIG9yIHRoYXQgaGUvc2hlIHdhcyBpbiB0aGUgcGF0Y2jigJlzIGRl
bGl2ZXJ5DQo+Pj4+IHBhdGguDQo+Pj4+DQo+Pj4+IFpodSBZYW5qdW4NCj4+Pj4NCj4+PiBTb3Jy
eSwgbXkgbWlzdW5kZXJzdGFuZGluZy4gVGhlbiBJIHdhbnQgdG8gc2F5DQo+Pj4NCj4+PiBSZXZp
ZXdlZC1ieTogQm9iIFBlYXJzb248cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPj4+DQo+Pj4gVGhl
IHBhdGNoIGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo=
