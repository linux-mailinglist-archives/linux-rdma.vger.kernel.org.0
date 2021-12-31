Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A20482281
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 07:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhLaGiF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 01:38:05 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:21835 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhLaGiE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 01:38:04 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 01:38:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640932684; x=1672468684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wg4LhvUilCnXKMGyD1UAu2J+TyutFfnSLwuTyehLDDM=;
  b=bHvKLFjSMc0bkDYbDuXmu8nDMDvSPmTeMbh6p3O42B8FBQOX/bqrv4Ls
   iltFB6fmI8ZB4PE7L4nmhR6jH3vHLenOuFBeKWHhj2073N4sidX6s2jFX
   aB/CIfJLhWe5OOE46Qc56dxgOo0v82nf7O5TfJyjjTjXx6ddxp4ifG4hD
   mxtaboHKoeM3MujFlFiKtRS3Q4HDWXaJh0b38/Qg7o9Mw6LCyQL0l+Kpv
   XV61tal8Wv8O17F1i/eYuowtjMmL9I5Ja5WV8vfD4jm6x2++ArZBADbMv
   bXrJsn/nD31wW0McrndYMW96j6J5Nn8xI0VTxsSzGxBDvtWyDESwhsmLC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="46859069"
X-IronPort-AV: E=Sophos;i="5.88,250,1635174000"; 
   d="scan'208";a="46859069"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 15:30:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJjH1vdCdyGU7OocS7sjifs4lg2vK+c0fdZsuEl96FE3FdkckNVFebeRw9b3wG7GYg8Di/N44RGHGxxJ4uxYqtc0D3DEAdLfvJnOIeGY8bWMZ+mGiknnFmg8WSNsLofzJ6300e1TiOCriHsum4ud159fOamHYCagEqJ/3wV4uBAu774XOqVaJ2EIgUzDfFobzwjaN4zKsi7cP5pFSrdRsboVfDFKeYaa6H1wCNPhSwlKnQi3CJ2ZDo/OqOuCCHw7n+d4f3iTf0bUv7YKmgHOKjMITzj4cKlu8phHv87HRKoUDx6Ktw0RqeZ0D1VwVIMAcF9iyGVUsyo4Xoilz1+1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg4LhvUilCnXKMGyD1UAu2J+TyutFfnSLwuTyehLDDM=;
 b=lcp5KRC/CbVPC9LYcn6jsiEHAMxFZQVKyFwcXM/HhL3q9hIydUw/KlFpMkADbLPs2xvpphsMegh+y1fsHbg8DH6+Bnc9Sd6y4Y9hbHIGg+qPKTkZ59SnUXWTtMoCr9JmW9HVCe+BtaJWu+EuKTrVaEXFR8SjtpwzBoqBEci3diR0NHg8erBRFEvJXht2Fb60dQEx/mHqvHPiJsjHjcLskVaKtkshUSvdl/9gj6yxmn7UaQhL+EVIY36KXyp9oZYVhFHMLTNEwOCUvK8MCiWFcQI0H/yQqe9yT+S/tni/Cq4ov+C1X8xuDwiIhQaoZZNEAjj4Ix5xSTNeNuxiTd1dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg4LhvUilCnXKMGyD1UAu2J+TyutFfnSLwuTyehLDDM=;
 b=UQd66gOrUGkjAZGDnluTRqSSHHkLJAuoojDFOOyOTkCQGy+FJ02FK6tYvD5y+l/Z5M/SF3e0tOPm+JRsh0XBOjAz8yqQKKHmdGCmWKP2+cDNf8lkxu+HLeip6cjE5lIx5w9/l2Umi+80w0q40ofEn4BBf7eTmMQUk4RxKREibzY=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB2536.jpnprd01.prod.outlook.com (2603:1096:604:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Fri, 31 Dec
 2021 06:30:50 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%3]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 06:30:50 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>
CC:     "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQaxLae+AgAAndACAAJOUAA==
Date:   Fri, 31 Dec 2021 06:30:50 +0000
Message-ID: <61CEA398.7090703@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
In-Reply-To: <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50f16921-3201-4558-c475-08d9cc27167a
x-ms-traffictypediagnostic: OSBPR01MB2536:EE_
x-microsoft-antispam-prvs: <OSBPR01MB25363719B7A2FF850326A1BD83469@OSBPR01MB2536.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oY66wDefHJgl+LyOH84SALmKvaECrY/NDJVCo8c7NN+DIjas//BsL5Ker3Uf2DNYxA/t/hZx4f2wDPGTKX55Eym1TuiTPraSeDCafm9Sf2BwxvXfRbv67pQJGqigvPsq2D0DYDO4NODl0tEPikjl8ZRSTl1JTH74sIgr2rDHu5loZmeyTrtYXJFsVUen30Z5j306fqIR95/5QAgR1d0xSBCTCSlI+OX3DA5HU5vOqEK3x9+wZi+LE36D5OLO6kRZY1eozpRqeSi4gRLHT06xbjk6fXwFkf8TDtS3u0e0yvmIZilipG0axAs6Ymgy0Pbh5kHVoepOyIooZNImev9+VyRKvfuWAooeBWzR5G9EfR1pXLBW0m3+u6XexGLeH3eL2u2BGfijOTqDwt7YQYhVQBwWzJiUIKI7jsv0x5dHuXHTYkOiPzevl50v7ZXfZ3ii/etznKlMGoHc4wIRKgxr+P73arOzPBRMPeNYkQngb38kxPPwlOEuZRNCPMtoFPhCpb9KcC0Q45Wrh2dKKI1nEPeNNjBbstBku914esnyBYfo1mofhqjlZHzyCwpjstNBBwgzJJqAITl+p0yP76d9Rw3WWuUyYGs7tfMq1B/2Z+0QDBcRJFSzWdTOJS7BRJ5oxPN80CybQOgxFpYIUDhmco236CoMFSqCi8POGb6H4A8E3UPm+ZLCuQIduTFBpzqLB1lX7z4qC2dv3fDhhgZKfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(87266011)(26005)(8676002)(54906003)(4326008)(38070700005)(122000001)(66946007)(83380400001)(82960400001)(33656002)(76116006)(91956017)(5660300002)(66476007)(2616005)(86362001)(186003)(8936002)(66446008)(64756008)(66556008)(316002)(71200400001)(6486002)(85182001)(107886003)(36756003)(38100700002)(6916009)(53546011)(6506007)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS9oQXhGajZMclVVdHh5b2g3VzZqTFcrK2lsbGZnelZBOFRIZWZJNFNtcUFq?=
 =?utf-8?B?ZUgzUlFEMGk0QWlUdFdtc0xOMGVRN0ZqMUxuMFRCSEljOHNjQlJJYitINUo1?=
 =?utf-8?B?NUphYXVldnlKdTQxY1k1RzBReUd6d0liYWtHOVNRbXVja1VZTlJDL2pGWDFG?=
 =?utf-8?B?WGYwaDdDVngzUTBYK0hQMTd6NTh0ckc5dExXZGRKVzBaa3RLalVpdXh3Ylcw?=
 =?utf-8?B?aXFndzBka05Od2lsQkYwMWdUNlpqa0J3SW8xUnRpL2lHY2I0V1hFOGthWG5k?=
 =?utf-8?B?c1pLNGNFOENZUHU1OHN2ZFMzakZIVEJrRXc3N3hUMTRjS3NRcFRFUk8wZFd5?=
 =?utf-8?B?RTFXN1k3em1RVitMWG42a3JhTXA5a1BCMFhpWE1NSUpRVGtjTmg1cWtVWmpK?=
 =?utf-8?B?ZTdWdmdYK1I1YlpieEt1WTkxeUU4YlBEaVhyU3paRG9nSUEyZDBkVHUwWlNG?=
 =?utf-8?B?TGpjejdnTjB0QnFDTUJqOXhVODIzRk8rNE04ZE14dlFyUERRM2pjTjE2UFZO?=
 =?utf-8?B?V1F6L3FSQnlIWk9NOXBMZzd4TXg2eGZkWStBOWc5Zm9ScFgvaVdWWmg3QTgr?=
 =?utf-8?B?blQ2aCtBTnlwekw0b0x0Y2RwaG9BMzJrTDNYUmtUbzZudkdrWnF1dEZJb3NH?=
 =?utf-8?B?YXRFdHJPUzZvMU5RN1Q3SlNmRUJMTEhWemVuNkJZb1BsajMzT3FzWGFVVWRj?=
 =?utf-8?B?K0xCVnpTL0dHYXhHcjN6NVUxYVdMTnJEdG9yWDdCU0tsUWs4Z1ZCTVJvcTlY?=
 =?utf-8?B?eW5jaUU1L2N6ZGp0S01nci9ManhjaEE4b0M0TXllcEtTd29nVXJ5YjhPS1ZC?=
 =?utf-8?B?S0V4UkZaeDROUnlOdHhWa0pqa1VxS0tuVWJZVWlsSEhWOE9GSG5iM21iV05L?=
 =?utf-8?B?aEt2M0NzYlJHR0k1SHdZVmc5VUVyRXU1c0laWGpoY1JyRHkyOTNzMFYyb2pK?=
 =?utf-8?B?OG50TWVtNUVzMDNLU2RWOGJqcXo4Njd4S254MEw1Q2JPdm1WUnhjSkxWUFRC?=
 =?utf-8?B?Z3V0THlKN3dqcXBISTRXT0txY0dVSnYrOWVqVThtZjhWMnJ1N0hvSXZ1R2tO?=
 =?utf-8?B?M3FWN2lXSWlyRm9YMk1Wa0pMN2xFcUZGZ2F5MUlCMDc1ak1VT0RDUWthMWQv?=
 =?utf-8?B?SzJkTkQ2M0gxVjBRNy9FWnliSmcxakpyK0tTS09NK0M1OVBVUkJSdTNQbjNi?=
 =?utf-8?B?clRObXRhMzJCUVVxM3NxT2k2eDZrMDVEZ0N5SEZTN1FrSTBiN1BEYVR4dFJT?=
 =?utf-8?B?SkMwaVI1eGdlR2V2dWZVNFlYa00wZU9DcGRHSTZ3ZzdmS2swMW1mV2pFOFJ3?=
 =?utf-8?B?dUExWkdzZE1sVDV5TlVhczNWcnJ1WFBCbUY4ZXM4S2J1U2FpMDZzT1crcURh?=
 =?utf-8?B?eTFVTkZjaVhscXZGRm9TTEhUanRlUTFXK1hXZ3YxbTFEYytPZW9kNG1YMmVR?=
 =?utf-8?B?eDBJNng3akRsencvd1hwNTdxSW82ZnFOWkgvSUdrR1hXamdrNUp0YjdacE12?=
 =?utf-8?B?OHJ4OURZK2dVMHVRd2FodCs5eC8wSWtkTmE2VXJZckhyckJaR3pRbjBBLzJW?=
 =?utf-8?B?UXZZc0gzREdWbVU4UXZKeC8xbVIzZUl3NTIxMkdnVHhLZDZ6R3Q4eFRkeHdr?=
 =?utf-8?B?K1JWcHl4a2JKRE16NzFsV2FuZSt5dEpVMU52MUhNckQ5NzNEdXU1bGtIc0FS?=
 =?utf-8?B?OXFJVE1RKzZzS05zbStKR3VGYzZaK3JMc1dVRFR1U2VhNmtUVm5pWTBIby9R?=
 =?utf-8?B?L1RIVTNkZS83S1ZONUNmQjBPMzNELzNJcjI5cTNzVFpWU29TTmN3WjhybktR?=
 =?utf-8?B?YmtKbXIvdHJIcnBEa0NvNEpLSlo2OW54L0dIYkt3c3BwR1oyTThJbHNzN05V?=
 =?utf-8?B?ZHIrR2J6R0hCUFJJZHdOQzZRZVcvWjdkN0dsZ0s1ODE2eUYwYXkrbzNSUmFU?=
 =?utf-8?B?OUlCYWZJbHpYaDZGSWJUNW9zTnZPRFRrcHgwOVZpZUpyU3dGamFtbDRDbE9K?=
 =?utf-8?B?R1VEYjFpYmVqdTRyY3VxMWQ0Y0hyeVN4SnFudURpR05BNWw2cktXekpRTWto?=
 =?utf-8?B?YjFGaFpla1ZrS25EYW4xMGFFVnU2YjRkalZ6VlROajZDMnc5dWJqc3lETnpP?=
 =?utf-8?B?KzdYR1QzUVAxQzdvQUVYZE1ha3R6OE95RkNxSy83aUNzMHNKQW9SL25lYXp5?=
 =?utf-8?Q?64YZGcHfoUtwGXu55ksGqY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48AD230129BC024C8F4EAB598AF2B0A8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f16921-3201-4558-c475-08d9cc27167a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 06:30:50.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QX2cVJKiQ2fqs68jr7LKmNsucnUhOb7dCSzJ08vCHR6eAPFTkvEjYkC3qVK0DtGka7sAfQD/K7A17xOp8dBzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2536
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS8xMi8zMSA1OjQyLCBUb20gVGFscGV5IHdyb3RlOg0KPiBPbiAxMi8zMC8yMDIxIDI6
MjEgUE0sIEdyb21hZHpraSwgVG9tYXN6IHdyb3RlOg0KPj4gMSkNCj4+PiByZG1hX3Bvc3RfYXRv
bWljX3dyaXRldihzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHZvaWQgKmNvbnRleHQsIHN0cnVjdCAN
Cj4+PiBpYnZfc2dlICpzZ2wsDQo+Pj4gICAgICAgICAgICAgaW50IG5zZ2UsIGludCBmbGFncywg
dWludDY0X3QgcmVtb3RlX2FkZHIsIHVpbnQzMl90IHJrZXkpDQo+Pg0KPj4gRG8gd2UgbmVlZCB0
aGlzIEFQSSBhdCBhbGw/DQo+PiBPdGhlciBhdG9taWMgb3BlcmF0aW9ucyAoY29tcGFyZV9zd2Fw
L2FkZCkgZG8gbm90IHVzZSBzdHJ1Y3QgaWJ2X3NnZSANCj4+IGF0IGFsbCBidXQgaGF2ZSBhIGRl
ZGljYXRlZCBwbGFjZSBpbg0KPj4gc3RydWN0IGliX3NlbmRfd3Igew0KPj4gLi4uDQo+PiAgICAg
ICAgIHN0cnVjdCB7DQo+PiAgICAgICAgICAgICB1aW50NjRfdCAgICByZW1vdGVfYWRkcjsNCj4+
ICAgICAgICAgICAgIHVpbnQ2NF90ICAgIGNvbXBhcmVfYWRkOw0KPj4gICAgICAgICAgICAgdWlu
dDY0X3QgICAgc3dhcDsNCj4+ICAgICAgICAgICAgIHVpbnQzMl90ICAgIHJrZXk7DQo+PiAgICAg
ICAgIH0gYXRvbWljOw0KPj4gLi4uDQo+PiB9DQo+Pg0KPj4gV291bGQgaXQgYmUgYmV0dGVyIHRv
IHJldXNlIChleHRlbmQpIGFueSBleGlzdGluZyBmaWVsZD8NCj4+IGkuZS4NCj4+ICAgICAgICAg
c3RydWN0IHsNCj4+ICAgICAgICAgICAgIHVpbnQ2NF90ICAgIHJlbW90ZV9hZGRyOw0KPj4gICAg
ICAgICAgICAgdWludDY0X3QgICAgY29tcGFyZV9hZGQ7DQo+PiAgICAgICAgICAgICB1aW50NjRf
dCAgICBzd2FwX3dyaXRlOw0KPj4gICAgICAgICAgICAgdWludDMyX3QgICAgcmtleTsNCj4+ICAg
ICAgICAgfSBhdG9taWM7DQo+DQo+IEFncmVlZC4gUGFzc2luZyB0aGUgZGF0YSB0byBiZSB3cml0
dGVuIGFzIGFuIFNHRSBpcyB1bm5hdHVyYWwNCj4gc2luY2UgaXQgaXMgYWx3YXlzIGV4YWN0bHkg
NjQgYml0cy4gVHdlYWtpbmcgdGhlIGV4aXN0aW5nIGF0b21pYw0KPiBwYXJhbWV0ZXIgYmxvY2sg
YXMgVG9tYXN6IHN1Z2dlc3RzIGlzIHRoZSBiZXN0IGFwcHJvYWNoLg0KSGkgVG9tYXN6LCBUb20N
Cg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5Lg0KDQpJZiB3ZSB3YW50IHRvIHBhc3MgdGhl
IDgtYnl0ZSB2YWx1ZSBieSB0d2Vha2luZyBzdHJ1Y3QgYXRvbWljIG9uIHVzZXIgDQpzcGFjZSwg
d2h5IGRvbid0IHdlDQp0cmFuZmVyIHRoZSA4LWJ5dGUgdmFsdWUgYnkgQVRPTUlDIEV4dGVuZGVk
IFRyYW5zcG9ydCBIZWFkZXIgKEF0b21pY0VUSCkgDQpvbiBrZXJuZWwgc3BhY2U/DQpQUzogSUJU
QSBkZWZpbmVzIHRoYXQgdGhlIDgtYnl0ZSB2YWx1ZSBpcyB0cmFuZmVyZWQgYnkgUkRNQSBFeHRl
bmRlZCANClRyYW5zcG9ydCBIZWFkZShSRVRIKSArIHBheWxvYWQuDQoNCklzIGl0IGluY29uc2lz
dGVudCB0byB1c2Ugc3RydWN0IGF0b21pYyBvbiB1c2VyIHNwYWNlIGFuZCBSRVRIICsgcGF5bG9h
ZCANCm9uIGtlcm5lbCBzcGFjZT8NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+DQo+IFRv
bS4gDQo=
