Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90341D1FC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 05:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbhI3Dvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 23:51:52 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:6032 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347975AbhI3Dvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 23:51:51 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 23:51:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632973810; x=1664509810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5SgmUAFlhXiaMEXuo932Q/vh6QVLndE1VkL1xDTfweM=;
  b=x7biwtqMacTSwYnKgIPRGeeKW3d3SdB9BTV/PlWuKbGV2c95MMY66I1X
   YaIExblDm+JCT2O+QMjt+SPC9qfWzODhuXxHPeWkxaFYbnwCzY5fRDm54
   ytZV5Nhwa1r1O7Epy/7dUbL4K7cHugi783q5EHpVCeNjQXPaeG0Lr7Y2q
   b00TjAeuBRzdJo8sci8++qmegRsaHm2af1/+xwnK1ENiKrGhUy/IDQUO8
   lASlFm4yHRjtaN/YkrcsZTOH/ob9bd4aEamuGkOjh8jp/gbgMvonJbR9y
   4f/shGHYAXN/R+x7ZGO++QP8tWrSCAoAzdkCSMD37UdMjaxEqFbhum6Cc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="40100741"
X-IronPort-AV: E=Sophos;i="5.85,335,1624287600"; 
   d="scan'208";a="40100741"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 12:42:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCk5KClPgxRBFFEqsgsOTOazVXYAu+RvDjHicL7bBQMWlG0PQwnIkZCj9TW+d84HWQXm/xWgJlRZJGuvLaHxL8tCE8Jq2NkAmE1iJzS+fotUoISGqXi3a6gY6/x8DZECqNInEXGLajC6ZwQGwGNxL+9OXVPv3ncD6JHuzkYWX5B8g5DH/CEoS1yu/5QoIl8nx/LcBz9Sm9XRxmF5ZkxLgu5d2BD8oNU3FLiESt9o0xuPgiQN8uxJKO+6ESws4Lz5ZIRj1Eg5D0DTLcjCdulI//4CSGJIhyztgAiVR+GEl1+ombYWeXu+I3kvwYRo7JQ6nU0qMu+/eoIML9JH1cDfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5SgmUAFlhXiaMEXuo932Q/vh6QVLndE1VkL1xDTfweM=;
 b=k50xieFdFuULx5BEhPak5bjXJGo4wXiYY2X85zxlbji5tbeiCDEDEQc0zNJenMcp5ba2Jw479wIbX1LgXQOwdUVOeA0/ZHOxnsD+Y4ar/N0j+zeEPEMwgirkckujBvJrtuTyraMB2gA6HhZP6jtWivyAj3pEUuU07ppWKUJoqqDH2LvvD8SzYGKZQ/Vnsp5XFDSkRI8s33UUQSwvsasP7hOeH6tZhMdim94hTXIldr3gR9ZMPhS4w/HH4Taird+ix0q6ZHSZiIeMlcykAsKmQlp03Rnq58ONajGw2Cd7Zb7hehPolwHV76NSghuPQuwvkTkc/RwsesDWdCr1JkN4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SgmUAFlhXiaMEXuo932Q/vh6QVLndE1VkL1xDTfweM=;
 b=pUaqi2IIQpI3elZfCOhUahREzgcOKWH3OI+CSbtioxCb7xYpuHNucdIiutoX/8mJ6tdbmXombWxQCLCkI0x5TpQ2MkBe7KLx/Q/R0ase2HKK0DuSRhZrH2Xrxnw3w0pvl9Pdk3qJOPuukrqy8ASgWrFzg6EEV+W5XZWe0+o5/FQ=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6952.jpnprd01.prod.outlook.com (2603:1096:604:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 30 Sep
 2021 03:42:56 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::dd46:3948:5311:4bbe]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::dd46:3948:5311:4bbe%5]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 03:42:56 +0000
From:   =?gb2312?B?WWFuZywgWGlhby/R7iDP/g==?= <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v3 0/5] RDMA/rxe: Do some cleanup
Thread-Topic: [PATCH v3 0/5] RDMA/rxe: Do some cleanup
Thread-Index: AQHXqvSCWiVfCqmWkUS3CqdKUEAva6u5mc0AgAJqy4A=
Date:   Thu, 30 Sep 2021 03:42:56 +0000
Message-ID: <6155323F.2070602@fujitsu.com>
References: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
 <20210928144810.GA1674100@nvidia.com>
In-Reply-To: <20210928144810.GA1674100@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd11e88-d2de-4de4-578d-08d983c463ee
x-ms-traffictypediagnostic: OS3PR01MB6952:
x-microsoft-antispam-prvs: <OS3PR01MB6952CFE8A74FD9596982559283AA9@OS3PR01MB6952.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qZ4Shffm8S89KsTbBVkKyP3DEw/gutkj5UzbfGiR2kQ1/qfbdYVw0HK1iToxkaXAlTkukE3UQbEoYyRpg/hO8L4+cAgRG+0OEpvvUhzSYiEMMT3M+tFlLOagKEmqs7KjfBCp0B/SWa2WNqhZ/cM4Cxtidm0sF9aTx9uSTwXpmzdIbzsK92/ayw0JGvjjTR7Y/GmYLVAzWfMhecWahWSR9jPenpBgaisVkHlBttZ0M/uzU0O7fThjenLywRebJO5QuCniAqXT7JKSJ0UxEpk5Py93uC2vlGFWZp7t3TRPW2ptPQcwhbR+vm2G5UX94azPg5jjKrhNKwfDZVgnhSFxSD3jeKkM1yWErqXt3kd6CVv3zaYrEYZV9OOooiHCoKjHJPfW3MJLhLKBudTR9HDOzBMPvsB4wR2wSJqt0IpT2rkvxX/rmf9P3FzYj4deVfuZQTyMFRANp14HoqqwHIl1i1zxXPa4h0S+n6YSmIGJ4TNiIOR1+qncDrSFHdePchn5XrcFdJ5AtkiWS0iOOVjSrWsbe9fvLoy0CjcwKHrnro6b7db4iCZHNKjANquz3BrX8aZL1WWbieKgpGh7sZfykAlZLRIOFR38aePvC/7tOqhvpcWssJ+bUoSuwJqLFKsfDqDvuOfTJTwgwlKaa8VDt+VljlG8ZrPiAK5Mqj2gY2FNh5+kIdORn4Z7tPAmVo/8y3/Vh7nhtX38R8mYOO8onQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(33656002)(4326008)(8676002)(91956017)(53546011)(2906002)(2616005)(71200400001)(76116006)(6916009)(36756003)(6506007)(6486002)(316002)(122000001)(508600001)(38100700002)(66556008)(6512007)(38070700005)(26005)(85182001)(8936002)(83380400001)(54906003)(66946007)(64756008)(87266011)(66476007)(66446008)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TWVHZHU5bCtTZEhvcUNxMlRNVkRLZHBrVnF1Ym52dDBhbjNReVFQMEdIVDM4?=
 =?gb2312?B?bFRHYTIvN0ZXTkFPaEs4MVNPQmwwVjlOVHNSQUkvYm1ad3dLVXY0SEMvMnFp?=
 =?gb2312?B?c3FXRyszVExDMDN1aTRlY3FJZzdkT2lYd3dzOUlFRkd6RFR2ZG55dGt5TXdZ?=
 =?gb2312?B?OWM5TGloaUFOVDlNS1YySkRkazdBZmFpQjUwYU12THkyQ2crRWtQemZHMjY3?=
 =?gb2312?B?SHZDekRZR1prbTBqSkNKQUVsZGZVT1dPTitIcGErRmN3NGpRTzl0NXFHVVJF?=
 =?gb2312?B?eUFvM1BXTEM0dlZtdVQ5OFV0Y1hKQjZXYit1NjdOWlJ4MCt1ZGExS3NxQmRF?=
 =?gb2312?B?WUdOTmtRRVVNRmVUSTVJNFJvTFZlVGVQMUhTb2x1VUg4TnN1djBmS3NoSitt?=
 =?gb2312?B?WWlGRG42c1dKNnFUd29sWjd5aktvb3dJdFlRY3FOSVgvd3NEQk5QUHNjT0Jx?=
 =?gb2312?B?QmR0aytNZ1krMkdsSkZ0QUNma0tSQzkxUTlISHpYclFzNGxaL1BEdWtzYmVW?=
 =?gb2312?B?RnBBN3JFcnZpWVZPakVDTFZJZVVBQzMzWmVkdTVrMW55TWtiNjFPdnBsMXgy?=
 =?gb2312?B?K0ZZbEVxcWZuTmltbW9zZ3M4d1dESXdwZUVwb001UXZNSkxKeGNNUDFIbXJT?=
 =?gb2312?B?R1p4NHpQZS84U2dQSk9jcmNwRmJTMmx0YzhtNWExcVQ4a3dobnRQbjZBVjkw?=
 =?gb2312?B?MUYzdEhxTzR4Yk1LRGc2TS9mRnZ2L1hJSGNzaUpXbmx4K3o2bkJlMkJ0NFFz?=
 =?gb2312?B?U2p0V0ZzaEU5b1VQcWtnckhXZGhhak5NRzMzaXVzTHNrYlZvVXF2R3VHYW5j?=
 =?gb2312?B?eTM5R09hd25XVUZhV0JkWDEwWDlDVkUvdGF5dnlBVWtROGQ1SEZlckdlN0VE?=
 =?gb2312?B?RkpXb2I3cC9nc2F1VjFQMHU5RzJvbWhERSsrdHVpN2ZjSUg1c00rbFNWdyts?=
 =?gb2312?B?Nlg4MWFRSUlWM0oxcUptMkIxdWF0eXNIcmtBczRsOUJmcjg1UnBQYUFtSlhw?=
 =?gb2312?B?YnMrQ2s2QlZIakpNSUFaVUZ0SWg2Tkl1R1pxYS9ZaVY1clNKUXJ4WWVjMlpC?=
 =?gb2312?B?NHhOY2REWVEycFc4OVdQMXd5VU5vd1NXRHU2UkxEbEVrS2phdksvMVBsanR1?=
 =?gb2312?B?L1pndTNLTFNlZlpveGpucEVNN0VKd1VPWGI5Q0t1ZWJyaGxHb1lWTnJ5aWdJ?=
 =?gb2312?B?dWt5OXVXaEQzaDhUSE9mQ043ZnlmYzhMZy90ZVdpUGlneDlwcHEzTjNWSXZU?=
 =?gb2312?B?emVaa1V6UkNrR1VWSUFsYUg4cHJKcE14V1l1RXdsb0ZpaDl3MzB2ZEpKbDNt?=
 =?gb2312?B?VlBtZ0FaYXVPNVVJeHlZd1FlcFpUMWpONkttVWlBOFRpb0tGSGpjQ2haUGhj?=
 =?gb2312?B?YTFOZmU4NTZOMXlQU3U2Mk4xOFV5RWo3YVo3ZFFKUFYxWEZIRGVXZlhqaXg0?=
 =?gb2312?B?ZVp5V09ySnBNTE9xa0Z1M0VXdUZxaW9yY0R1Ti9KY1g4bDBPb2hHVUpZZVFw?=
 =?gb2312?B?c1NWb0ZUaGpFNm1LQzFpVVVqKzR6UkJvcWlVQTlxeUhRdnFJR0g3RGtpY212?=
 =?gb2312?B?bWFtdWFPQUlZYmFLdDJNS1pVSUg0cmFtd3ArNWF4aE5iSGxLSk5TQ0svaWl3?=
 =?gb2312?B?aUhMaW82bWZqV3dVb2dnaTZsTmcvd2FWdXR1OVhPYnltbERhV2VoNk1LOW10?=
 =?gb2312?B?WTZyMVNSaHBwckNRWWh3d2lUWHBMeXoxT2wrbThxZzdXdkJIMEViQ0liMXhn?=
 =?gb2312?Q?iX8YHaxQgFQShu4WNZ4QK5jxRUnUhl+uvA9xecd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <2CB61C72238EB14697EFCC6879695214@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd11e88-d2de-4de4-578d-08d983c463ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 03:42:56.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tORy0l19n0e8EhzJYNB7CqJwhNwSL1MF/NwgrO5inSiG/RL18y06yOEtkyP7/GAn+n5YNDyVU3whkZ5T+KVxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6952
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS85LzI4IDIyOjQ4LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgU2Vw
IDE2LCAyMDIxIGF0IDA4OjQ2OjQ3UE0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+IFYyLT5W
MzoNCj4+IDEpIFJlYmFzZSBvbiB0aGUgbGF0ZXN0IGtlcm5lbA0KPj4gMikgRHJvcCB0aGUgdGVy
bmFyeSBleHByZXNzaW9uDQo+Pg0KPj4gWGlhbyBZYW5nICg1KToNCj4+ICAgIFJETUEvcnhlOiBS
ZW1vdmUgdW5uZWNlc3NhcnkgY2hlY2sgZm9yIHFwLT5pc191c2VyL2NxLT5pc191c2VyDQo+PiAg
ICBSRE1BL3J4ZTogUmVtb3ZlIHRoZSBjb21tb24gaXNfdXNlciBtZW1iZXIgb2Ygc3RydWN0IHJ4
ZV9xcA0KPj4gICAgUkRNQS9yeGU6IENoYW5nZSB0aGUgaXNfdXNlciBtZW1iZXIgb2Ygc3RydWN0
IHJ4ZV9jcSB0byBib29sDQo+PiAgICBSRE1BL3J4ZTogU2V0IHBhcnRpYWwgYXR0cmlidXRlcyB3
aGVuIGNvbXBsZXRpb24gc3RhdHVzICE9DQo+PiAgICAgIElCVl9XQ19TVUNDRVNTDQo+PiAgICBS
RE1BL3J4ZTogUmVtb3ZlIGR1cGxpY2F0ZSBzZXR0aW5ncw0KPj4NCj4+ICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jICB8IDUxICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jcS5jICAgIHwgIDMgKy0NCj4+
ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyAgICB8ICA1ICstLQ0KPj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgIHwgIDQgKy0tDQo+PiAgIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyAgfCAxNCArKystLS0tLQ0KPj4gICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIHwgNDEgKysrKystLS0tLS0tLS0tLS0t
LS0tDQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggfCAgMyArLQ0K
Pj4gICA3IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQ0K
PiBUaGlzIGRvZXNuJ3QgYXBwbHksIGNhbiB5b3UgcmViYXNlIGFuZCByZXNlbmQgcGxlYXNlDQpI
aSBKYXNvbiwNCg0KU3VyZSwgSSB3aWxsIHJlYmFzZSBhbmQgcmVzZW5kIHNvb24uDQoNCkJlc3Qg
UmVnYXJkcywNClhpYW8gWWFuZw0KPiBKYXNvbg0K
