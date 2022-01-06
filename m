Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8274860AD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 07:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiAFGnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 01:43:04 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:29619 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbiAFGnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 01:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641451384; x=1672987384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l7XYr++14IiVoG+j3G6uYnnjhOa2H2j9OyZyuv5MZc4=;
  b=TBsuRPw6ejYw4fm98d8RL1bi90Yaaz/zuI7t4zPi6LJIpdEoL5DPxAUB
   nt9vA3McuIg+gpFl3jiLiigZYpQWMy8mlAHypWce1ApLa4v+IPJEnbY1D
   kY6MLdEFIdkXhQyj6n8tdQHg8n3BpqRKiVt9WOabCm8H6r5pBl/DSLAF5
   tZIpKFbTIKVrS6wmuOy1OFIncDkn6rc+cHs5xes7s+qkTdDZngtlxJhAY
   h9uvF6pPl73zUA59+jJYdHhjE4GC9lhMsM9OUfO0KE77i2Q05Ovx5FNQs
   1dJAytHkVOI4CjzBZD4VukCibfVqee8/fNMVlXMCDEaUyvEoSt+EcVtLp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47206194"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="47206194"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:43:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuEAlxkUHAChGFj4Rpdx5eyxX0L1usv2JZiWyotNxTZusJMEG5wnDNQ9Ap1ITuUpBdK/UBFQjCt6K1XrGhy0NOxaqyMU7axRw0gaJEIP2fNMa8nPxjWdFHwQQSVWGaBLYLjjgsjEfncW8KqaMFaFdnJJ07XDAhUJbtaziiNTts0jXyWse1BBjHF5Slv2gG8wQTEEZFMGPxHLcQYOZZlUBSzCjl1ayL8rkvhdvXcVNoQREw2jHnzGxfe5XhfRzT3IMVAMW+YMTGHLTkJaeOm/h4L8unMUgOtHmOGu2oryLHvt3XbPgVSMJBOGI7EYe9mZD48qzBpbzXn0KQx9673dRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7XYr++14IiVoG+j3G6uYnnjhOa2H2j9OyZyuv5MZc4=;
 b=biWGIHVvjS8ay6/q3ygFtVhD8up8iT7rozxmvhwzymxdnna/NZWR0aWlNB+qIVMb5AOHv2qgcr4RP+MVcEc55cpB2uc7R4pDdPywUQNBgDvgN3WOxwm2yzqyAF6seuQYI3/97yhwTAX47PUjFFTFM3lEjthVNKf7SorA+ZFNaGiOb8I3t07nme/xKTiq5l3LrdRcW+vc7Wwm8JZq4TG5VsNpLsLBtWLHPnzJ+mXvdCfyYHLHPaKPEK6hN03uwI84r4KXZsHLeTkyzvU5WPtNmFUkM4TNDPaBCHZF6XqEn6v1/hwTdUk7HnsswKe//flWk5kf6C7ipMASzzygmPDCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7XYr++14IiVoG+j3G6uYnnjhOa2H2j9OyZyuv5MZc4=;
 b=m5uZIzSkG1vLljTMqyCBKE/aCq+R3lu7DCRCQydp+iNUpBdbhW/WLB9EA53MZqU6U2MRmr/I4r/TE5qTfngh+ToHhY01VGVX7vFzPH8r8+TwKq9pKuXtqehYcjUBrkYNF2jRcDZy2uNHfUgg5KffB4OaCIrigeqhtnQI3LUBPE4=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7579.jpnprd01.prod.outlook.com (2603:1096:400:f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 06:42:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Thu, 6 Jan 2022
 06:42:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xVMQcAgABoxYA=
Date:   Thu, 6 Jan 2022 06:42:57 +0000
Message-ID: <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
In-Reply-To: <20220106002804.GS6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f126295f-c00b-4f20-43a9-08d9d0dfc650
x-ms-traffictypediagnostic: TYCPR01MB7579:EE_
x-microsoft-antispam-prvs: <TYCPR01MB75796BE0FD59A3137DE39BCEA54C9@TYCPR01MB7579.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsIl9R4dO1aWRZCS+Wy3V8H63cF8qwFBUStICiZZ88hqkxGK37GAPIdfJ+AwwFOCp1e1Pw+lcRYl3CIt/RHnkLnAWBIHERHmn48cxf7eXi4rQjg76S1WGoDpDmKExWDJPK5uCKfZN8hsd2U7RIXQ4sd1RDwSB8cUwTqzKntoueVUas6gJWN9d4euch+Y+HcnMMeoAO2gbPHfzaHsImFVSWJHXJHp1/E/HdT0Wy9w6kB/9+w2DYXQeoQ+2qMgUEfjs74PpBTl0VrLYXOWSGnuTlsUbKDCuxwQyagHDprdtX4wTtxplsrk9TeKDOqzRKK6E1PE6uG8jhr5rCL6t5vuAOl+l6AJYfQ9+NXOvEC6B0FPCLoQA5B+b+8+3TO1b8HleQy/ai6UNYs4RPTPyrSgi1BngKpn1Mski0NSaDCurhn/6THs6ay/X4vUsK7I0SyapIMcoKA/IyBC6vcjJIjpN990YOHtFwBdTZWDDRg9QjbVA/QCRfS55pCJvCydjoO+4bTVra5UTALhMOmtPvtoRG7qiDI7NG3SzTTBkeLuluKM4b23aK6IgcfhaGFczDX1j1nAb66QAy8hhCJjKsywV4ME5ibxkNSDbHQZAETJkRNpXOQkRq3T/9rD4w62Icby2YpO2DYcmgwb4I2wgtW3iedXw2rGb3ee6Dfau1u15/C6K8rpCW+hZbsXMolzcMInfhfczZM2FmaUoOJX8fU45mAOFNJTWfpQsKFY003hbD6Tv7PcSlIH+lPCNsRvllc/uoDg4n4bCp8mECiqMPEmiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6486002)(36756003)(38070700005)(2906002)(85182001)(508600001)(66946007)(7416002)(71200400001)(8936002)(66446008)(31686004)(6506007)(83380400001)(82960400001)(53546011)(64756008)(31696002)(8676002)(2616005)(107886003)(122000001)(38100700002)(66556008)(316002)(54906003)(186003)(6512007)(110136005)(66476007)(91956017)(26005)(4326008)(4744005)(76116006)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBqNHNpczRCcjl4SFU4VndVS25yajJrQXRQbFgvYmFwdnJYZWRWc1dpOGdO?=
 =?utf-8?B?cC9OWGNrMGNzRkdpSmJHNDViWHl3T2E4RFNzUFI5N0Vza29BOGRIaG1TSGlT?=
 =?utf-8?B?bGFFaWlvbU9ET3I3YUJrcTFsa2tuaElOcTd2ZFVqcG8valJWWGJ3aUtpS0NI?=
 =?utf-8?B?dHZrRllHeVlTMVl5cUVTMnhMY1ppdldJdjRUYnd6K20rVWdJeGtnQncrN0hz?=
 =?utf-8?B?aS90L0tDWFZ1aGpZNDV6Q0ZncUVyKytDam5PbG5zUEx5QXhwS2JHTkRqR3FW?=
 =?utf-8?B?aU9hN3Fra1p0dXBNWkRwbWFQK3FHRVN2NU5UTmlzeGVmTGNvLy9LNzlYcEFS?=
 =?utf-8?B?N3RIaFg0OFhSS2FmSVpEVEwyd0V3S3NlVUpNUHpVbDgyd0dROFlQalpFeFpz?=
 =?utf-8?B?dkx5aDhoMmo1OVRRQkVVL2lyOVlhWC9tSDlhWFo2YmVhUjFIeENlZDJ2Q05I?=
 =?utf-8?B?amRWenl0aTZBdnJJdDBFN0F5U0lxSFVteHZPdEhHTVl2TFZwWEJpMFZaLzlN?=
 =?utf-8?B?S0RXbkpyazNraVFydW9KWjlXMGhVY0NKd2RCTXBzZlJRcEt1N0xVU0pIQ1lC?=
 =?utf-8?B?cGowdFBhNVlzV25XRjlrZHA4dUUyYUJMSmZDa2FseU5BbjEyQTdOMERoT1JP?=
 =?utf-8?B?NGJqOUZUeGRWcVZpalFFakphLytKcG9QYlBvK1JhZHd4OVFXU09MUW5kVW5w?=
 =?utf-8?B?QzdmRTE5VmREVjBlTXFsOXduOWZRY2hjb0NISWtpTDRWNjhJQnhmeGRLQmEv?=
 =?utf-8?B?OTVBVlVQVEFaMjhtRmNzYkhjNC9ZZzFVQlZybDNzZlJoRGIrTGlldWQvSFZI?=
 =?utf-8?B?T2Y1R0VoNUQxN29NSmlMWGNBTkhQMjQxbmQ4UGhBcTZpdFZ4Y0Z6bUI2V0JT?=
 =?utf-8?B?RWVVMFZtbFhvYjBSVFVRWTV3QTFnUWNkemNGTU5XMUdrRXJCays0VGIxUGs2?=
 =?utf-8?B?N3RYMnc4aXdFNExlTXo5NUk4emhxY3VIWS9pQnRCQVNxajMyelBMcThvQmwv?=
 =?utf-8?B?ZnhJWmJ3cVlPMTViWDV5UTZEZFVPR0p1RUtRcnRkMGJZVnpGK0lRT0lQU1E1?=
 =?utf-8?B?M0tWT2gwTjJmRllOZ1RhWHpLbk0vWG9BcUUzNHFhM1FYNTFVOEFwamgzcVdK?=
 =?utf-8?B?WmJWLzVtdXF0eGVWbFRRN21iYXZTbHRWV1F6cmZja25JKzQ0Z0JDTndPSkRW?=
 =?utf-8?B?MHVjclVEZ3pwYko4c2F4QW9kZ05BNFBKbzR3OUMyb0ZsZ1JpVHdDdFlqRGQ4?=
 =?utf-8?B?bnI4L3c1M3B3bmtFYXR5ZmhtVzJVRzVXQVFhL0VNZ0pHalF1bENuelByWVMv?=
 =?utf-8?B?NFR2bVd5WWp6YzNmRDk3V2laMlZpR1VET3RiRlVTd3ZrZ2JUZ2xVanc3VHNV?=
 =?utf-8?B?NVNPWVVjbGQ3THM4V2VlaVpLQ2tjVVI2V05ZR3Z3aEpVUzJ6MFBoWk5ZajJQ?=
 =?utf-8?B?c3V3akJMMWZUUlhtYWh4V2gwSG5INCs1RmcxWTBocFRIOXJ0VmtwY1QvRnVG?=
 =?utf-8?B?c0hqczg4RHVBNkwwbGgxY1MrbDNQY1V6d2RWOXVDdjVWenVzTldrNmFaNmRh?=
 =?utf-8?B?Mm5vV1o2QTVkaVpjY1lGTUZkOEIwUTN2YTVnOEJqYU5rQytrVHJvVTUvelJ1?=
 =?utf-8?B?TERSWnN5V0pUZlJNQ3pNQ1UwQzk2LzlQajEvbm1iTXgybDRyRW5ocHloQ3p4?=
 =?utf-8?B?SlZib25DcXhhZ2FXMkJYb2NZNVBxZVhleFFvWmRzckxZNVRmbWpwTitVT0pw?=
 =?utf-8?B?UnNESFZZWEh3dDlUa0loM2xqeDVoNDV1ZVFTREpFMjh3aS9BVUdhdlU2MFZD?=
 =?utf-8?B?WnNRREZjNENzMTNUeXlMSGJJbTluMGswR1ZxMVcvVHFCeGt4Ni9uK0o5S1Rl?=
 =?utf-8?B?a0hsblNuUlFWQXErODNXaWV2bGNTZ0NKOHRBcHdGUW5BdzIyN2dBelU0RGM3?=
 =?utf-8?B?Z2NoQU1HcTdoVjRBZ2UySTg5Z2tGNHNYYU1sV1UwQlhXSTV3eXRMUmNXcHhU?=
 =?utf-8?B?WjlLbllQSXZ5d3ZNTnY2amZSaFY3UTJ2R2RxbklJbDBUZDFSazd6cC9rQ0lJ?=
 =?utf-8?B?YkwvK2hwQkhTc3pWalQ0VEEraTBxY3JraFplclcwNmlUU0Z2R2dhd05RdEoy?=
 =?utf-8?B?THNPQzBVeU1FU1NONmhSaER2eW8rTk5lZU1CeXRCeE5ic3NVY2NsbVJTNWsv?=
 =?utf-8?Q?NWPmAxBWfArRoHCvnTPhIWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EC26F511F6D124CA2418EADFFC59058@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f126295f-c00b-4f20-43a9-08d9d0dfc650
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 06:42:57.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNK4mwveSz+7f0XdpeCjwPmISX3bplyiN3b/qsOabXUjHNL8EQnfGl7DXezhDfLOY104QcIZe/Ix0m/vKduiuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7579
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzAxLzIwMjIgMDg6MjgsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVl
LCBEZWMgMjgsIDIwMjEgYXQgMDQ6MDc6MTVQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
ICsJd2hpbGUgKGxlbmd0aCA+IDApIHsNCj4+ICsJCXZhCT0gKHU4ICopKHVpbnRwdHJfdClidWYt
PmFkZHIgKyBvZmZzZXQ7DQo+PiArCQlieXRlcwk9IGJ1Zi0+c2l6ZSAtIG9mZnNldDsNCj4+ICsN
Cj4+ICsJCWlmIChieXRlcyA+IGxlbmd0aCkNCj4+ICsJCQlieXRlcyA9IGxlbmd0aDsNCj4+ICsN
Cj4+ICsJCWFyY2hfd2JfY2FjaGVfcG1lbSh2YSwgYnl0ZXMpOw0KPiBTbyB3aHkgZGlkIHdlIG5l
ZWQgdG8gY2hlY2sgdGhhdCB0aGUgdmEgd2FzIHBtZW0gdG8gY2FsbCB0aGlzPw0KU29ycnksIGkg
ZGlkbid0IGdldCB5b3UuDQoNCkkgZGlkbid0IGNoZWNrIHdoZXRoZXIgdmEgaXMgcG1lbSwgc2lu
Y2Ugb25seSBNUiByZWdpc3RlcmVkIHdpdGggUEVSU0lTVEVOQ0Uob25seSBwbWVtIGNhbg0KcmVn
aXN0ZXIgdGhpcyBhY2Nlc3MgZmxhZykgY2FuIHJlYWNoIGhlcmUuDQoNClRoYW5rcw0KWmhpamlh
bg0KDQoNCj4NCj4gSmFzb24NCg==
