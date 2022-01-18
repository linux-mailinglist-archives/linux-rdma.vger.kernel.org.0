Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3F4921F2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbiARJER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:04:17 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:33891 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345151AbiARJED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 04:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642496643; x=1674032643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CIBa7UFT6i3em5tVDmN4iddWl1zHhv9Bm1Hka0jQbSw=;
  b=ImaVsQF7bLGZ8ZZt8BzxaUtg8Qtg8SVVKgsR66M84Qz82SFthxzvXPEt
   iVvSXmnxS7U1KvzJLtQP59UW/cE2qt/pjcEhc+agcPnDzTViK0ROkQ5DE
   ++Sf/rvB1CqSO18kD3PWyehU2WkBdW/Tar6BdJvy/RlPv+ITyfcX1ib6G
   W2yeBLIPzb5IqMTMHTC2sZwZhdxQ1vGcDn2yqgrJXpC4RzRieGDo/O/Yr
   1ClCdwA97N1Erex3lPZZmx12echmLZix2+opN8T0vGBH82VwlZYJlKTh3
   f+fXyj3dZ3qy/2/osf5BCFzfKe9T1f0RMi0tQc3YdJJlakWicgoAafkvm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="56125300"
X-IronPort-AV: E=Sophos;i="5.88,297,1635174000"; 
   d="scan'208";a="56125300"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:03:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+e5RGlPTYYyJDVriE+P50esre53phJoMrqSHhRTNbRy2vgzMZLqfLBvvn2EWVv1XOlACFYTEls8zWugLWEl1OwaRTz5aUUAALVv78YsyH5h0oQbayBY4yy03eiRTKM+JBctwDpbTqAQGZwKQH+wCbC5igs0z8VEd15X7xg/Xz3RHzhUqexhp/W3ERLnh91AkR9o4L+LXNkzrVvnQQyvq5Iicbpza1+3MW4YiGVO7GQbE/5oDGe0hyVioxhevUdzlC93GHhSIo9RnOW4+z/Gh/ktQqz8kLU50em3Oksznn2xZLdkwgAEBKQTqilNEjLprk9Ek7IvL5kbwkhr1hV41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIBa7UFT6i3em5tVDmN4iddWl1zHhv9Bm1Hka0jQbSw=;
 b=CQ/kijqZxIkLV4uE1UPTIum1Fqy1ZWW/NY1pNf3xc1jj/xc623PXpJBMve+O6YMOS82UCfe/LWhIchyRYtsSALwN22xq/II0CB0A/lOfgqvBNSIDwfcSfHfB2QDbaCxmjH5bnUlw+DP59Dhd5ENcWc9m/mHFVW8I+Vt77lnJVtO/OKfJ9VM+JyggZSJjoideUNVVICA5KgCBopMVe14KMfTkiNOCvLNTZsXBTCHg7bgd0rNDZeZ37Wp0fBmRPuhcO1rLXtLQYpiB5QYyGSmjOPYqKdH9TCaLtqkq/BlLIxfcXOTpmlqo8y3LXJ0a+md7aTtXqV9nQ83m74I5ndSNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIBa7UFT6i3em5tVDmN4iddWl1zHhv9Bm1Hka0jQbSw=;
 b=lLQbQKUYEb/1rtcmraCMADCvuRKik+Q7h3uU2ZkvTgPMkjphyavdeED4hSTuqaYLQriuh+7szuGK3fvwo3lDoJ8s9CE5N0/YaoPar85VD9zetMKbofpA4HVE3s2NEIijY8nlM+nwCQ6rGpeLtZ/0eClSe75BBMojbwCvc46qPHU=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYAPR01MB3133.jpnprd01.prod.outlook.com (2603:1096:404:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 09:03:55 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 09:03:55 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE7PYCAABCKgA==
Date:   Tue, 18 Jan 2022 09:03:55 +0000
Message-ID: <61E68279.7040406@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com> <61E67499.4010408@fujitsu.com>
In-Reply-To: <61E67499.4010408@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72dbb819-4078-4ce6-fede-08d9da6174b6
x-ms-traffictypediagnostic: TYAPR01MB3133:EE_
x-microsoft-antispam-prvs: <TYAPR01MB313382DC6926BB640AFA884283589@TYAPR01MB3133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSpwWY7bpBgXijgNXc5WpvZ+EsFwRy/h9Wfw7jv8NM9khNIzW2WsDb1OaobKL6isky2uVC/+y22AhWvcAojgEYKxHofclMDl/nMTwoko1QSUQBfZw2Pj+axEfIfAhBnW+XoAdVXZ5ueAarJYTY8Wl6gvjXvPNcELqRMA4F6f4aFpe0zpkvEYAkzqHvw2/2W9R7/MF2/PX5M5sluvnEMLkh/sbK3/QN0sBYMlz+jHko4pyqLqOJa7rkeigk+LP4C8Zu5sYJs6hkwZvGsAhsCxk+N6EJ3l4mHThSrSbppLbe3xKii11SnjHe5T7cSK3o2qizymiPZlduQhhG11B4S3dcA8CXCXTeA1ojdnRcUqAroM7o4EdKsL1xo3k5/cj4NSDcKAak/aMsBOqcJrZfw+tUBJ/i3650ODvKu9EpEkRHrlHjEOHKinoCpoZhQGYmv/n9PWWh3OQJwF6InhzLLTUeXqtcAu2p9SfYRdXmeewYtEPrbpmFgatdb37bNKCu0BupORxEEAYpcvcH1Pfh6ddNyfuv0G0vmx44Q42E0z0oCwBEURZY/Ufv/GPrsUxSztrBRPx0OPQajzm7Qo1hcQMEf5tlcr3LFsjsbHAzJXdNkV+JLTEByUiYhRaH5w5sSzraA4vZiy1F4foBMWXdvwgJsm2XsnmGqVT0BsPPluWs64UDdi4zj6MZ9H4I7ug0l3OuG2qOwGosSSyYAN+S8oBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(4744005)(76116006)(54906003)(91956017)(316002)(186003)(38070700005)(87266011)(122000001)(66446008)(33656002)(38100700002)(2906002)(508600001)(66946007)(6916009)(66476007)(64756008)(66556008)(6486002)(26005)(86362001)(8676002)(36756003)(4326008)(5660300002)(2616005)(6506007)(8936002)(6512007)(53546011)(71200400001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TlJ2Tkh6aDMzTFpjeVFGV3psaHR5c0wzZktqcTdmN1pETW1HdU5lN3VDVlBM?=
 =?gb2312?B?SHI4WDhjNVpGWUhKMitLcVIySFdieUxKWnBMUjNDWm1yV1RYL3VCdHJMci9u?=
 =?gb2312?B?V2c1RENjYnh4NlFaN3hJaWZDQ0hnTjgvUW9vZmpNbC9saVVXbW0rcGNMQUFI?=
 =?gb2312?B?TExBME5KOWhrcUFzWjhvSStHVVNpSDRrdnRuUjg4aEdWaGVGaWJSRTBaMWQv?=
 =?gb2312?B?YWtFQ0N6bWFqbGZ5MnVWaUpXZm1VdTkwSFAxdXZiblQ4OVlJbUhMem1UUDdH?=
 =?gb2312?B?aUZBcDZacjFRWktIVVBzeVYwN0hENm5IQUtkV3dsSGhpRG9EK1pxK0ZRdEMz?=
 =?gb2312?B?a2NCNTI4YWlYYnV4Wk9CYkNJSG9BS0FIZzhZWnNhZnhlc1BqTittQkxUa3BT?=
 =?gb2312?B?Ump2aGZIN1BqV3RySVI1djA5b0QxWXZTWnVPc3BIdm5LYjRJd0RYc0ZGN0No?=
 =?gb2312?B?Q0dVcDdXQ1NHM3NlM2hjZ0w3OExHRm9NaXZBQ08yK3h0aVlIcGdjUytiNmtY?=
 =?gb2312?B?YUhWYU41RnVQQmdCVEpFVFFMVjJWN0ZJODJrVnZoaVF2c2lUSDhCWktxNW9D?=
 =?gb2312?B?d2Q4THVuZlQ0YUpkdXYwM2hGU25LSmhTcTVnNjl3K2c1Qkt5UnBqVXRoUnk5?=
 =?gb2312?B?M1pRWjUvT3c5Ynh4ajVoM2FzSHUxOHZxdDZiQU0rZGxkcEltVHhyQ3R0RXpa?=
 =?gb2312?B?ZFBsMjRXeTZ4UEFwVGlPTlpkVkZZdlloUGZheTNKR05iaEovQVl0eGpsMXpE?=
 =?gb2312?B?L2FFRDJCN3poZFhOWTh3THk5aU9aTWc2WXFST3JZR2hvV2o0MExCbkdTOFFr?=
 =?gb2312?B?MXUvcjN1dkpEMUc2OXQrdHczY3AwMjh1OWZZWWZGVFdjY2thb2Fld0dhSjRS?=
 =?gb2312?B?MG5tQ3R2ZEkwaXJ6ZE91ZEFTWDhQaE5wT3VrNVhyOEdwQWJleHcxazJWS0FO?=
 =?gb2312?B?MHVEZVZMdlp4WW5YVHhFNUU0VFpFWW13OCt5TjBFMDBaenpDakluZm85cHZy?=
 =?gb2312?B?R2d1Z2hucTNzMWh1aXlxNUdCRUd3ZkpoZ0Y1c2JvK2xXNFRBNHJSSngyd09V?=
 =?gb2312?B?djhub09meXY1ckMwbFlBT1Ixc2FzY2FRYnZGWGZJMXB4NGlFYnlxN3RzM1NG?=
 =?gb2312?B?VzlDeTV4YVdXRGVSeDAyZWRuM0NxSmVsQjJoR0g3Y3lRUGhvdTRXblJpTUgy?=
 =?gb2312?B?Si92SGdjcjArSnZwNHduWnluc0VZTFBzVmZMMmN4Z21PR25tNmRXY3daa1g1?=
 =?gb2312?B?eVFnQUNXVGlQaVBrY0RFTXFXc00zZnlOc3RxY3FiSGN5L09BZkR2SGJuRDBF?=
 =?gb2312?B?K0VxSXJyTmhtU0FmbkxxR3hCeE0yalFuVFc2UHJLMUR6WjBuMVM0eHNxQlox?=
 =?gb2312?B?RWQ4MlVOdTdYOHB4dHA4UWNzN1VZZ202WHhXZ3ZOQ3o2MTREN284bVQ0d1A5?=
 =?gb2312?B?d1hTQXpXbStXY0pCSEY4NUFlSjhPbTFCZ3o4ZzBKWVkweFNycVFrMFdmQkEr?=
 =?gb2312?B?SEpCL1VpWmZOa2RQWnVvZ3B1U1pLZk52UW9CU2ZpOFI1NVpKM1VFQ215cWJ1?=
 =?gb2312?B?Tkg0UURwaktySDhXOWRCSXFLMmxGZm8wbXNQaFNZbUN1bUJJTmY2MlJXYjN5?=
 =?gb2312?B?SGV4MVM2SmRNcjdTNFE5aHFSaXY3TjRJbFA1SGExSkNHeEJKWU5aQkV3Vm5h?=
 =?gb2312?B?SzNnR1ZaU0phSVBaYXFzRGZLbEVkd0pqYlBsU0RkNngvWTlOMG52ekQ2alhs?=
 =?gb2312?B?Z2N4Zm9LWC9pVkJYcFVvVS91S08wZ3ZmNy9QcDJjT2ZtMjlmVVhuZS9qTDVn?=
 =?gb2312?B?M1NJbEFqOG05ZFJISE1SaStLejhTRG9pcnArQUtwNzBtU0lRTXhXOHlDdkJD?=
 =?gb2312?B?ZmNtRHFyR2ZOS3BsaE5ESXEyYXZ4N3k1ZERXbWdxWlhHTnkzdWR3MnovVWRB?=
 =?gb2312?B?RGxzZEhXRU9GV1YvWVViVFBsOTJrUm5mQStEN1NhTmdpYktzVmZnQzBGcEIy?=
 =?gb2312?B?TXkxYVFBamFOVkdjckI3a0xPcE16bS9XbnNab1lJNlgwekVHcVliWXdtaTFY?=
 =?gb2312?B?SXNoczNPWDEzVzJ6T0VaSWlCRURYendxTmthcUhBNVpFbzhweDlOMVBCZEZH?=
 =?gb2312?B?d2Z6RllWSEhlNXVxbVVFSTd6ay9kbEpucWhlWlZ3aWdsaUMwSWlMbHdBeDNq?=
 =?gb2312?Q?5X6GyX5dRFMScJnTXQH7ncDlYImr9reGqlixTCaeTln4?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <CD103A5B90728D48B8F1F37AD53593AC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dbb819-4078-4ce6-fede-08d9da6174b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 09:03:55.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjeC2PGZEOkI7aObEftPTXIUt8+jBYl644mmZT02MkFwhKtMVB4ZXNRbDjf7PPWE0cHjgBjOWNOxdKctLGdjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3133
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGksDQoNClNvcnJ5IGZvciB0aGUgZHVwbGljYXRlIHJlcGxpZXMuDQoNCkJlc3QgUmVnYXJkcywN
ClhpYW8gWWFuZw0KT24gMjAyMi8xLzE4IDE2OjA0LCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90
ZToNCj4gT24gMjAyMi8xLzE3IDIxOjE2LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiBU
aHUsIEphbiAxMywgMjAyMiBhdCAxMTowMzo1MEFNICswODAwLCBYaWFvIFlhbmcgd3JvdGU6DQo+
Pj4gK3N0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIHByb2Nlc3NfYXRvbWljX3dyaXRlKHN0cnVjdCBy
eGVfcXAgKnFwLA0KPj4+ICsJCQkJCSAgICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPj4+
ICt7DQo+Pj4gKwlzdHJ1Y3QgcnhlX21yICptciA9IHFwLT5yZXNwLm1yOw0KPj4+ICsNCj4+PiAr
CXU2NCAqc3JjID0gcGF5bG9hZF9hZGRyKHBrdCk7DQo+Pj4gKw0KPj4+ICsJdTY0ICpkc3QgPSBp
b3ZhX3RvX3ZhZGRyKG1yLCBxcC0+cmVzcC52YSArIHFwLT5yZXNwLm9mZnNldCwgc2l6ZW9mKHU2
NCkpOw0KPj4+ICsJaWYgKCFkc3QgfHwgKHVpbnRwdHJfdClkc3QmICA3KQ0KPj4+ICsJCXJldHVy
biBSRVNQU1RfRVJSX01JU0FMSUdORURfQVRPTUlDOw0KPj4gSXQgbG9va3MgdG8gbWUgbGlrZSBp
b3ZhX3RvX3ZhZGRyIGlzIGNvbXBsZXRlbHkgYnJva2VuLCB3aGVyZSBpcyB0aGUNCj4+IGttYXAg
b24gdGhhdCBmbG93Pw0KPiBIaSBKYXNvbiwNCj4NCj4gSSB0aGluayByeGVfbXJfaW5pdF91c2Vy
KCkgbWFwcyB0aGUgdXNlciBhZGRyIHNwYWNlIHRvIHRoZSBrZXJuZWwgYWRkciANCj4gc3BhY2Ug
ZHVyaW5nIG1lbW9yeSByZWdpb24gcmVnaXN0cmF0aW9uLCB0aGUgbWFwcGluZyByZWNvcmRzIGFy
ZSBzYXZlZCANCj4gaW50byBtci0+Y3VyX21hcF9zZXQtPm1hcFt4XS4NCj4gV2h5IGRvIHlvdSB0
aGluayBpb3ZhX3RvX3ZhZGRyKCkgaXMgY29tcGxldGVseSBicm9rZW4/DQo+DQo+IEJlc3QgUmVn
YXJkcywNCj4gWGlhbyBZYW5nDQo+PiBKYXNvbg0K
