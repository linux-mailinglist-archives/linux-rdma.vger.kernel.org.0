Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8634241BE39
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhI2EaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:30:17 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:46338 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhI2EaQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 00:30:16 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 00:30:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632889715; x=1664425715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uPU5soguXIFkJQ2PNq74NKQfm2QPTMb1vfJyTD8QZV8=;
  b=dwL9fzlcq3948wo54CYZGcrgsxnlk5azaB9SvzbYlXLMWu8ww0YvA2JE
   VEd7PEw4532oRDhgmgbWmwTy4g5EHxX2KuwKKsfYxM4xMmYo1zDZZi8Yg
   DtTuu+3AWEeeHWJGNdNukobMuVGQ7lXEOKd13UoUYa8Xkz53hLsA7yDAl
   UbeCPbSqG8+JUiMFa2bkPvso0f4wSZJ5k4F6fes5xmR25ZY3dqDuVfYw0
   4UvIv6M2ZviwKO7uxdVD8yTalzpf7x1NmGwJr8H1WohUFhP0AWI5eDwtx
   5ymzrCSejv+KM4Ze9EcMfqH8TIOpYVM7bnqTT0QtDNZd74B16m12w7kB0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="48005085"
X-IronPort-AV: E=Sophos;i="5.85,331,1624287600"; 
   d="scan'208";a="48005085"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 13:21:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/DP7tPohu64JNvrU7/ErQzNT7e9BlqvpVWnlc90Gv3aE/08413RVYebORaUty0ND5oWGFDlUOegLtQBcEE+jwA6tMnhhcmmsjGgShi+4Ii00awwHvWcA6db34I11612s9gWKQDimxARzWExHlUIIVTtxta3wgaOFrPPpXoCN9SlDFS+1NnSzYpmr5z4CdYIQXbvYJgHyJpUSBuTfmn8z1x+kJhafDIzpEEf0Br8oyhNgYTa4Yh2N7/LlS5RYs105/A7g7qB2XriMsGCmbrm85reBf5X0O9aDRD4QEXuW3byaMmjYjVw+aVOAygz5LPHOX4hf0imfQKKlOa9sBKCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uPU5soguXIFkJQ2PNq74NKQfm2QPTMb1vfJyTD8QZV8=;
 b=W44G7bn6eFuqG2UmVIvy79kUUUazVAB2CdrODc4+Y1epfnQlYy4/Nr2s3Q9R9xI28Kan/OQf9MbNVU2pPN3bbLZqmeCa1h7MK28aK6fXkkevDKasfzB4wioO0Qbygt+AO+Mw3xPjFJA/MNHrBffQAKZ7c5W/zx1W63/LcDCI1TujedSccAI72bBhvlUKhZsEATi1kMTqSpryu0RrJ1H1e1LXNvhDSZcDTZDoo/92z1uhtJEcH6Tf5Xe+ueZU/SEGLXBWqwz4O6EEWR7X2oiL6vBfyB2M4t1JR3ACFIOPn0CndqqZUDHR3Ipy8Nrpq7tDtJzCNqVJY3Wej98G5Hk4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPU5soguXIFkJQ2PNq74NKQfm2QPTMb1vfJyTD8QZV8=;
 b=gloiGi5gzkW6YLnfPCyvThaxC0Ds7zSx84aQ1vtxvRn9QUAE1u9a7kgD9KJTMOM9ONK8MhPXLlaaIml9QjLWsQVm84a6xQnXonc5oNI/zipLHTtsscxaFXBCfCD8g3zr/4cnjleSFh6sY9j4SoUp+5bvVMkX15Qni8jLyovmex4=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OS3PR01MB7995.jpnprd01.prod.outlook.com (2603:1096:604:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.22; Wed, 29 Sep
 2021 04:21:19 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::bca0:815f:1da0:911%6]) with mapi id 15.20.4544.018; Wed, 29 Sep 2021
 04:21:19 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Topic: [PATCH] IB/mlx5: unify return value to ENOENT
Thread-Index: AQHXoJ/HyxlES6SvX0+PJ4+/45Jv8qu6kX0A
Date:   Wed, 29 Sep 2021 04:21:19 +0000
Message-ID: <e2decb1e-8776-5192-e3ec-6d700faa019d@fujitsu.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e5a698b-1b94-4165-97dc-08d983009684
x-ms-traffictypediagnostic: OS3PR01MB7995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB79958A8378848F5A701A9199A5A99@OS3PR01MB7995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Kr5UUM0K721KMV+XdNwdE9/ULL6iBP9rVJb8WhFOoezo0gl5vVp9rgDSUhHjaVY97b4Fk+k4CntO5sf0hnubbYlfAY5OPnMdBAZfbd+SgKEp6/B2QVldottAOaMJBZZAv6mo3gyre3lo+KM+lqtjwJ3OAHtlceHWSJI/ZX5wR77noq2QRw3yzLcjdigoEQ2YgshWjS2YJ97PUquKvjYCW62YpMiPdNgr8nf89TaANcq80MQ2OuSTxnr3fYw0UH/nQ9wSUUVy2a71JSgR71kPl9k0ajY/xsasc/F7DwbExKL3D8C1XEXCCv8PJgU+PqbdNQOT2B6edenGKri93AL1J2A6Amb9lQSMXTES6zjS4A65TAqYA+Nb4/V1ycZ0q25eEm/Ih1eppOikUkJrJxVsKN62lPZ+wAZghKcqTq1q5Hmc5xkDx8oYwkvmZsCHNx7+2BuMY67/WSM/h+8MNqSL9HVtM+5mE3MFkOFTxP2WissKqhPl4ysvNcVVOH6Ibqzw/Bj0q7Zd3E48CAZtSrSkR4iAA9Owz7DOCZBv1kiW0ZmBJBUKdBkGE6O4DUd1HmKLy+sFdbDNEX1/hMEpiqkZpjwVCSt+nrJbQDW8E4DrQessk8drrHjAws6bW3wwAGgdPts+XPHHVRY41qFWSOwIerErAG3Z7UjoeJnxILSXV0YdCsLLSLSAG9nBqTEDLLo+nd0urIWpok6cYIH6e0I875Rj16KJYYjdiy6ACmSvkf9qpmuyxXeJfzROhlKYizS0rW6wYrXQmu5IVKp4l/nMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(26005)(2906002)(122000001)(38100700002)(86362001)(186003)(107886003)(4326008)(66946007)(6512007)(6506007)(83380400001)(5660300002)(36756003)(110136005)(66556008)(66446008)(91956017)(76116006)(66476007)(64756008)(8936002)(53546011)(8676002)(316002)(31686004)(71200400001)(31696002)(54906003)(508600001)(38070700005)(6486002)(85182001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVo5bDVadmZzV3VIZzdoN1N2amRINmIzTG5Xei9jSDZSQmFGUzczankraGdH?=
 =?utf-8?B?VnVkcmdYRW5HRVArdEdpeHE3YlpMUUNMNjA0MklHNFVQQTlaUS9RVVI2REpn?=
 =?utf-8?B?aXhRL2NEVUY3Nm5venNpUWtjRmVOc2lNeWRRWXhLMlBNR3VZT2VDTEtvSVJ1?=
 =?utf-8?B?azRxSUV0NmQvRy9nL3hFaXJMVDc1aG9aSWRnRGNMYktKQkhLZEtDUnpURmtk?=
 =?utf-8?B?cFRIZFlhYW16S2Z0LzJka0dPQk5jZ2t5OEZ0bnJKU2x1bkgveUtBNjFBU0ZM?=
 =?utf-8?B?djh2NlZVSzE4SVNxc0NlV3lmUSt4eWdML1JjTnM3M05GV2cwZGtjWHhFYjZJ?=
 =?utf-8?B?aTd3Q2hOdVFsMzBjVTNGU2s2dUhtcFBOdjJKTVBmSTBTeDFIMTZieGkyTnpY?=
 =?utf-8?B?aExORDlsb0tyajNGc0tmZ2QxZU0veU5hZ2FCWXJNRU1rYzBCWG1ZSzJzckVl?=
 =?utf-8?B?TjBvU1NMQ2FkVk4wbGxLNXN3VEFqNmsrS1RjdGEzcFBEWFpSeHFlUXJ1REg2?=
 =?utf-8?B?RkhXK3JzRVlUN2owMGk4RHlIV1NsUk1JQUFqYW5DanNTVTlMNkpnZmJXSzZF?=
 =?utf-8?B?djFqZ3kxVlZ5ZWJ2bWMzY2ljT1paNWFMQ1BVdW1aQ2ZQUmxvWXcrR2JYckFy?=
 =?utf-8?B?OGh0WTFyYkNadjBSWm1RK0hoa0NZMmorbHlMdmt1Nkg4dVNRNEhxY1ltV2Q2?=
 =?utf-8?B?VEY4WDB1TkZzcml6Rm1wV0pOQThia0ZFaTlqZUNRY2FGb0VFNVE4cGpNL0d1?=
 =?utf-8?B?c1NxM09pOFoveDl4UTI5M2Jwd0dSZkVtM0tJVEtpcHEzY2hjLzJmTHBhdkhw?=
 =?utf-8?B?cVEzbjhYUG1UQU9HbThFU0NGTlNnMUo5T3VDcHlrZlVNR1E2ZXpQS2xvTElE?=
 =?utf-8?B?YnRVMjkvUDJRQW1Qb0VyZlFwSEhRTEp4eXRVamJYSVUrRzg0WWJ0VDFwd2Zi?=
 =?utf-8?B?OU5abFpYMHJQd3I2d0IvOFMrQXlKZ3V4L3FadklvUElReFdYUnJKZTVyMElm?=
 =?utf-8?B?QTNYc2pjMzVzOVFEV0o4bndlRjJjNzRhNW9JZzNzaUJSUjY4WVJtaW1tTXZN?=
 =?utf-8?B?QkhDYTZtSWZ3d3BoZFF1bU5uWW9TNFJuK3FxM0FXMVJpUU9Rbmw1cEgwV05w?=
 =?utf-8?B?bGJaaWVqVmhDcVdRb2JZZHMyY3lRbUtXVlgwRVJNN2JnL0UvTnBmVzJBYWJN?=
 =?utf-8?B?UWVvVHljaXVFR1dxc3krK3loU1BUQlZ2aFJLekpyeEVGa0MwZldXUmVBbjRP?=
 =?utf-8?B?NERmbjV0VjViWEM1RzkvN2M4RnVac3VPVjdwTXlzR01nVGl4MllBS1pPZStj?=
 =?utf-8?B?NzNKSVB3YmNUcVBpSUlkdm1Dc3pNSkt4WXF2WDl0cGtNaHVwYzRVdnh1ZTZz?=
 =?utf-8?B?bzFIaFh2S2MxYWswTHhPNWx3NjJhT0gzWnVUVHFjL2xlOTR5WDlzRFRxYnpn?=
 =?utf-8?B?dTRDd05NVEN4Q2VEeE9lMEVGVmdCV05KTXg1Znd3YS9MNk1IbnhsVnd1NE5T?=
 =?utf-8?B?VldJUEROOUFLT2FHeS9UcDJiekFxY1BEVTNHVFJrSFNWSmovcEl2WjNxcnd6?=
 =?utf-8?B?UkFVdkVKN3pRNm9YdzlKUFI1c1M0MmdhOGMyUkVrRUV1SHQrdDZrK0QzOG9q?=
 =?utf-8?B?NURyZmgyL0xJVHZFVkM1RjhWM1dxVGZjU0dlNUlWWWVJQlFjVHNUN2FwN1F6?=
 =?utf-8?B?MHZXTW1yUFJmdlNyZjBkSDZDRWUwS0xhVjFCTC9yZHVQZnh5ajdnT2dWdVZT?=
 =?utf-8?B?Snp5WVdhWjFQTkJjVGRLWExPdFllRXF0R09QbENEd0p0SGhyOFFyWFdWQkxR?=
 =?utf-8?B?Tkh6S29FS295NVZXa3FoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB238D8E951E1F4CAF15BDF15FBF5DC7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a698b-1b94-4165-97dc-08d983009684
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 04:21:19.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rlCS4mA6gMVdc6U98gtdoTmlFktvtnQ0+1r0zyWGqhyJvAZiPI18Jth0VrtP2nuJR9aZdBiofWf51qg5WtHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7995
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cGluZw0KDQoNCk9uIDAzLzA5LzIwMjEgMTY6NDgsIExpIFpoaWppYW4gd3JvdGU6DQo+IFByZXZp
b3VzbHksIEVOT0VOVCBvciBFSU5WQUwgd2lsbCBiZSByZXR1cm5lZCBieSBpYnZfYWR2aXNlX21y
KCkgYWx0aG91Z2gNCj4gdGhlIGVycm9ycyBhbGwgb2NjdXIgYXQgZ2V0X3ByZWZldGNoYWJsZV9t
cigpLg0KPg0KPiBmbGFncyA9IElCVl9BRFZJU0VfTVJfRkxBR19GTFVTSDoNCj4gbWx4NV9pYl9h
ZHZpc2VfbXJfcHJlZmV0Y2goKQ0KPiAgICAtPiBtbHg1X2liX3ByZWZldGNoX3NnX2xpc3QoKQ0K
PiAgICAgICAgLT4gZ2V0X3ByZWZldGNoYWJsZV9tcigpDQo+ICAgIHJldHVybiAtRU5PRU5UOw0K
Pg0KPiBmbGFncyA9IDA6DQo+IG1seDVfaWJfYWR2aXNlX21yX3ByZWZldGNoKCkNCj4gICAgLT4g
aW5pdF9wcmVmZXRjaF93b3JrKCkNCj4gICAgICAgLT4gZ2V0X3ByZWZldGNoYWJsZV9tcigpDQo+
ICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AY24uZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9t
bHg1L29kcC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUv
b2RwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYw0KPiBpbmRleCBkMGQ5OGU1
ODRlYmMuLjUyNTcyZTdlYTZmNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3
L21seDUvb2RwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvb2RwLmMNCj4g
QEAgLTE4MjgsNyArMTgyOCw3IEBAIGludCBtbHg1X2liX2FkdmlzZV9tcl9wcmVmZXRjaChzdHJ1
Y3QgaWJfcGQgKnBkLA0KPiAgIA0KPiAgIAlpZiAoIWluaXRfcHJlZmV0Y2hfd29yayhwZCwgYWR2
aWNlLCBwZl9mbGFncywgd29yaywgc2dfbGlzdCwgbnVtX3NnZSkpIHsNCj4gICAJCWRlc3Ryb3lf
cHJlZmV0Y2hfd29yayh3b3JrKTsNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCXJldHVybiAt
RU5PRU5UOw0KPiAgIAl9DQo+ICAgCXF1ZXVlX3dvcmsoc3lzdGVtX3VuYm91bmRfd3EsICZ3b3Jr
LT53b3JrKTsNCj4gICAJcmV0dXJuIDA7DQo=
