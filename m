Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07DD56B120
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 05:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiGHDyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 23:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHDyW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 23:54:22 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0074DDD
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657252462; x=1688788462;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0RCSoOMbrCLvKfz3oEftVRzYgfh6dkFI+BIdnc5mUnc=;
  b=nwYuQXnVyYrqzbRi9VOnfefn68/i05bTJQAfVLJhG2xwLCUkAzxTFZ9a
   ok8ToMCXbL8djS8hMwgEw4Gpa6zNuZCNHNOalwBfQELqz5s3DEVEnQ6uR
   3OkbtLlhhDQLzs7hOhsw0WmSs2V/PAzVpUlb4PPOiJmwPXzCRyKL2DH+K
   g/YYeEc+nkL6dDV76z8Je643PnjkrN4XklBdx1oJNGAnkFUqd51CR6fX5
   tw066JNpB1HBDghC62PgpnnjLS2GOn/6TOpF2mLgNGc4kOW5DWStbgOgH
   SHD1gmqEDOZ0FE18mKv2Q+D0qVrwe0MfpwABG5sXpGWUXlcO/tg3ZviQW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59851259"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59851259"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 12:54:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGYMjoJECYZRwTRSFrPTkl5dCw2IVCNuw5edNZHsf7gApdtIPBN67Ig5v9U3Bc5lLWKFMY6JRwyG4VPEwe3HendR5YKhLvsBq4oHQ09ATCi4rCMso57+bdn0ZS9rvlbALnPNqQu7vXQSCTj6a21XCPBOHRO8W25cwhF8IDK1DAIzPHzgQsi37ocD8+L83SSIHg6xQEgc51xYB3i6uk5kdzyMi2zQcH5HXmlZA0G7+AkxY4VCOhJo+3Xp8pEGqDBemq5dBrAn1ieShiiEiZr5nBCMtlMlqBw6BMy6hZudi7ZnE+BbhW7rIiMXAHHTTrx6/BXCOodIqHWdY3coijXDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RCSoOMbrCLvKfz3oEftVRzYgfh6dkFI+BIdnc5mUnc=;
 b=PlJ1csO3zPweEh7FV5gBTHa6No4p9gwLVqAP27hz65VwPqtPV4wZ/e14RxymwnBt4ZEAC0ujSNzXa7m7xmXjKHrfF8bXoy0jX3OR/oKDDrj1kpVG7mjh/X4K20LDdg33l6pKewF8KG9xLQ3jW34AMXgkso6yfKfifxRp+GnxbsudZ9MCgL08wuEeVa/7Cf3u+A3gYjE6rh0rwa5umkjdrfGhFnLGkDQdkvAco75WcVsnIsgrgbfQZN+25+YuWTsIaFCnLBC0wmJcAs5BS9Yqc5j4q2AZvtmbgB5mS9L6R0R/lLT0r+0i3wCaTrS/AEeVfTxZwy3j6oSU0EyrJ7LFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RCSoOMbrCLvKfz3oEftVRzYgfh6dkFI+BIdnc5mUnc=;
 b=fh6JftCNLAmVprem2rnX9Cn8phJbOgz5wscO3LZPSFuO9y1cgyKdu3haz001hJ67gPqGrxSoNlEDUuCGf7cyQ6vCpX+uRW2AKeRzuwnD7sfIRAIge9/IYjpqq6ENiTBGBCECYnIjd4L4Yy4PFXkjhcJ9zSm79+7j7pFZUk/3m+4=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYYPR01MB8150.jpnprd01.prod.outlook.com (2603:1096:400:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 8 Jul
 2022 03:54:15 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 03:54:15 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Topic: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Index: AQHYkmumKN2BRNLSa0Whwv+Wxmj3sa1ztzKAgAAgvQA=
Date:   Fri, 8 Jul 2022 03:54:15 +0000
Message-ID: <ef65f814-1ba5-ab16-0d55-bf804e2c9e49@fujitsu.com>
References: <20220708013934.5022-1-yangx.jy@fujitsu.com>
 <dfb4b44a-41de-3149-1e8c-98c66b603eb5@fujitsu.com>
In-Reply-To: <dfb4b44a-41de-3149-1e8c-98c66b603eb5@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387899ab-9e7f-4ccc-9808-08da609586d7
x-ms-traffictypediagnostic: TYYPR01MB8150:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLlPr6P8SL/Wr3zvSRIQm4NpyX5FVUbmoYJY0I78dE1lInwxr7WJIIvFKHvmZVgbK4aYnAHqRrbDz1s0QKUnwJfwAXjpze/1SI4Gq3CvJtOPg0uqBfG8bWMlGjnSmbjY3iPruq8iBjm9rWkT/VkxyyEz1MWFGCvsu+nTBTodUGxIIl5959ZMnnCIGRcKPf5HmY3IvaAF3DcVQOoKTo4mh0C8eoiCR+9eNDm7nGSNlaOFeWcFpKLuX68maBajoRqpx+xBpEdBN6JPjwGjNbjQ4AngI+Nsd2HNrmNR2SNED844oR458umFlvoukKubfxg9vmfDj0hgMS7hEAEw8ZN9BSrauRPtg+Nj23QD1ZX4QLTppUNFrWuYldj6WZeUi7O/whx3B+VM8vJfm87OXqEomC5Iq5zmp1gUE3ncKHY2eOGgJA4/sbxallbsM9nlMQVxboj0/XUSzWLqm1ydpUCTXNZoLQpsvv58UOs22WD6+B+SgRshH95wCAGwrq0wvZXNBYcTBZcLfMdRIxVip944XnVZ68M1DvoYd3C14FliRM0xOuqE0TscuLZ0wb9VMy3zQxCsibUyaW70N7/YkjHCEOSBeoCanmllZG5B6ZYyI6oybXCZvEsNSRpFFpIEsRBXPJBO2+GJpgI8xexE8S7TEuXB3uNLd7OpFJNd6DmU6E2o6YlIJaMFNwhF8iz6IhaDGpk0+uQUWiExBDBF0BXOzrE8oWyEGcvDvlLlWBUx1T6uqMz/dTE9s29s8UBTfmc1J8j86RY3dGrk8nFjRJHKOJO4BKsuMuKR2c6wCUCieUpKNwkmhjnoDVEQjV1w2M3ARHfjJFwSRmm2zcSmJOSD3KKR3lZaIt8FZbK09qDRXILh8bR2tQUidMGLBZo+62CN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(186003)(85182001)(6512007)(36756003)(64756008)(76116006)(8936002)(66946007)(66556008)(31686004)(66446008)(71200400001)(26005)(66476007)(2616005)(83380400001)(6916009)(91956017)(8676002)(53546011)(6506007)(478600001)(38070700005)(38100700002)(86362001)(966005)(82960400001)(316002)(41300700001)(2906002)(6486002)(122000001)(5660300002)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVjL0d4T1BrRGExY3U3S0xjbWYrQ21RcExUR091VEFvd2Z0OGpjZU1yS0Yz?=
 =?utf-8?B?MGIwYmIwSEpmNTE3b0o2b3FMUXhud3FBc29uREkrRG9La2pkaFNNcHkrTElM?=
 =?utf-8?B?T0Y3QzNRTEV4L2FiMlhpajZadDFCTzc1Y1hDZTdMOEhPWnAxOU1ZZ1BjM29q?=
 =?utf-8?B?eDJOUWhzaVpKU3dPLzdiOE9FQjcwUDMrcEdLMVMxZTRxY3BQdjJvQmhhcGsw?=
 =?utf-8?B?YXhtSzNRaXI1czBVK29QbVNJYkxFUHpwKzVJc3AzVkFmZ211YWZKS1lWdkhH?=
 =?utf-8?B?dTk4Rk9Jd1lqWGJOZTBJby9jOWJaZlZrSzJhcnIySTVxVGx6d25uMzZFUGZx?=
 =?utf-8?B?a0NyT3BaSTNzeVVHaWY4ZVFLTDhQR3NjQ25RTkY4VUx6bDRCSTNkR0xGWlpX?=
 =?utf-8?B?ZEFseGtJUWVobDEySkhXdWlCRXZVT3lVZTl3T2N3cWxtVlpEeUFydWFYWEFF?=
 =?utf-8?B?R05mYVp4QVFOMnpjNytWd2U0Zmw0SE05TGNaSWFTZXVNSUZadzRQaXY1Um96?=
 =?utf-8?B?dS92ZkppaXlKdytJS1pWcjJZUVRaUzZYa05Vb0hLeHZ1eUVic3YwMzlDVnRk?=
 =?utf-8?B?elQyaiswd2kyNk1DZmxUdnVqMjFGbld5QWp6YjlWU1BuR1BFOHJ3K2gzWEVJ?=
 =?utf-8?B?RzVUTUEyN3JHUDNtSW11dkVpbGhkTDF0Q2RKTkRrcitWamhYT2g5Z204ZW9I?=
 =?utf-8?B?TEZzeW5pR093dFpmY0RLYjBBakdTaE1JNFg4UmVIdnQzNmtZQ2V6dndrTGVF?=
 =?utf-8?B?Uy9ScWluUFcrWjZPRURNRVE1YzFXbEFFSnM2NmJFSkxHMnB6M2NydXoxaDhK?=
 =?utf-8?B?VUIzQTV6Z2RsUC9ObDZRVk0za0xMb25nMWVIWHpCQlJoS2JIdERBcXN0a2VN?=
 =?utf-8?B?djRxU2tLK2w1aEMyOVBKaDJsRkR6M0NRZTVoNXEzSzFZdnFHOXhjNnN4Sm5k?=
 =?utf-8?B?azlERTNyRkNwSmdGbFd2R1k1QUlQVjU0eWFSTThvR0ZEaVVES0IyVkFLN3RI?=
 =?utf-8?B?ZjdFSHNuRmFXb0NnclJZYnhTRmxOMXZWNzc3aHdhaERIZlR3bHdMZFhuSkNK?=
 =?utf-8?B?U0pmZE4zVzRkeHNmNGRLN2pKTm8vb1dZSDIvdnQ1LzlLQVVhMmk5WmxKQndP?=
 =?utf-8?B?Q2ZEZ1BmTlc2SW1mQ1pRWHVhTVhLQ2dRaVdOZEdPaDh6ck9zZG1mOXB6SEhO?=
 =?utf-8?B?S0s5VHBqVnF4WXFSbXRhL3FMei9rT293YktIanZMT1NDdjJnZklaMUwxYU5W?=
 =?utf-8?B?dGFZR244RE5aRU1CcEdDSWxZeUU1NTkyNmN0YUR5ekhrYzdsOGN6c2IyZUZS?=
 =?utf-8?B?Vy82NDJ6UjdJVExPOVJ6WHhuQ2g2RHk4bk9NY3Y0aStzUUg2ZFhVeWJvdk81?=
 =?utf-8?B?cE0zSXlOcVhuamhuNzVleTVWWHRBS3RmcGpJV3lDSzN1OW5oRGNMMjFzZHU2?=
 =?utf-8?B?VWJKdWtKNXBGNHpML0pqdnF0YWhGZ2FpSmxHSEphRkQrYlNpM0Y5MjlnNDFJ?=
 =?utf-8?B?NEVQeU4yOC9RTFJtZ2tJYlp3WVRvekJvbU1udThIaC9NT29YV2w1enFtdU8w?=
 =?utf-8?B?RC9VRW00RkU5Ky9sRDF3NE84NWtFZmdHd05Icmdwa0oyUTlOeDhrUVlGdTFz?=
 =?utf-8?B?OGJoU0hUajVkT0VkVTZaRW9JeFFqM2luRGdtczBlMzB4MlF1YmpjWERFZEJo?=
 =?utf-8?B?cXRpTDdyeTNBN09TMTNvSDhqcjdySTBWbVdSRVNRZUV6N3dIbDFLRGF5Q3Bs?=
 =?utf-8?B?T0tIcSs4dngxb3FHQmx3dm9Zc0V3ZG1id01lVVllMkhKVmMvakIrSEg2U1pS?=
 =?utf-8?B?TUV0ZTZyTmdWQmIrRjJVVzZKRm13UEk5WHZkSno0ZTZkZUc0VDNQYXJLYVVl?=
 =?utf-8?B?Rkxxd3ZSVmNBM0dJUHFZUGtqT2d1TGV1bGxmNGRwVU4zeXd5ekNSNFBFSzNm?=
 =?utf-8?B?WG1aalJBTW15SkVIZDJZUXRkMXU4MWl4SkNUc2NIUldEcmFtdFFtLzY3dUJv?=
 =?utf-8?B?RER4K0lSS0t4YzNUTnZGK3RhcEg3K1pXbHRmRWh1WHpoY1ZvTjRZVzBjSlJr?=
 =?utf-8?B?MnlUZXltWHR2S3FTQW13cmhhNFFGaWw0UE43VFZGWmNtbnViaWFYRTZ4Umx1?=
 =?utf-8?B?L1dtMnFxVVM4NWEvbzF6RHdrdHpDT1YvYVJad1BxWnhTMngvaURZYVBXRUhi?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5CF45F127CE494EA0255F9637C21EFD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387899ab-9e7f-4ccc-9808-08da609586d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 03:54:15.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSVcA2p4YXqwas1qFHh9H0LLJrUoRMRTPdf0qINr35UYIoBAqo74kNTgYA0lalJR24StcoM01U/r32qYXumjnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8150
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzggOTo1NywgWWFuZywgWGlhby/mnagg5pmTIHdyb3RlOg0KPiBIaSBBbGwsDQo+
IA0KPiBJcyB0aGVyZSBhbnlvbmUgd2hvIGNhbiByZWNlaXZlIG15IG5ldyBwYXRjaGVzIGZyb20g
TGludXggUkRNQSBtYWlsIGxpc3Q/DQo+IFtQQVRDSF0gUkRNQS9yeGU6IFJlbW92ZSB1bnVzZWQg
cXAgcGFyYW1ldGVyDQo+IFtQQVRDSCB2NSAwLzJdIFJETUEvcnhlOiBBZGQgUkRNQSBBdG9taWMg
V3JpdGUgb3BlcmF0aW9uDQo+IA0KPiBJIGhhdmUgc2VudCB0aGVtIHRvIExpbnV4IFJETUEgbWFp
bCBsaXN0IGJ1dCB0aGV5IGNhbm5vdCBiZSBzaG93biBvbjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtcmRtYS8NCg0KU29ycnksIG15IHNtdHAgc2VydmVyIGRvZXNuJ3Qgd29yay4g
SSB3aWxsIHJlc2VuZCB0aGVtIHNob3J0bHkuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0K
PiANCj4gQmVzdCBSZWdhcmRzLA0KPiBYaWFvIFlhbmcNCj4gDQo+IE9uIDIwMjIvNy84IDk6Mzks
IFhpYW8gWWFuZyB3cm90ZToNCj4+IFRoZSBxcCBwYXJhbWV0ZXIgaW4gZnJlZV9yZF9hdG9taWNf
cmVzb3VyY2UoKSBoYXMgYmVjb21lDQo+PiB1bnVzZWQgc28gcmVtb3ZlIGl0IGRpcmVjdGx5Lg0K
Pj4NCj4+IEZpeGVzOiAxNWFlMTM3NWVhOTEgKCJSRE1BL3J4ZTogRml4IHFwIHJlZmVyZW5jZSBj
b3VudGluZyBmb3IgYXRvbWljIA0KPj4gb3BzIikNCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFu
ZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX2xvYy5owqAgfCAyICstDQo+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9xcC5jwqDCoCB8IDYgKysrLS0tDQo+PiDCoCBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXNwLmMgfCAyICstDQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbG9jLmggDQo+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X2xvYy5oDQo+PiBpbmRleCAwZTAyMmFlMWI4YTUuLjMzNjE2NDg0M2RiNCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+PiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KPj4gQEAgLTE0NSw3ICsxNDUsNyBAQCBzdGF0
aWMgaW5saW5lIGludCByY3Zfd3FlX3NpemUoaW50IG1heF9zZ2UpDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbWF4X3NnZSAqIHNpemVvZihzdHJ1Y3QgaWJfc2dlKTsNCj4+IMKgIH0NCj4+IC12b2lk
IGZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcmVzcF9y
ZXMgKnJlcyk7DQo+PiArdm9pZCBmcmVlX3JkX2F0b21pY19yZXNvdXJjZShzdHJ1Y3QgcmVzcF9y
ZXMgKnJlcyk7DQo+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgcnhlX2FkdmFuY2VfcmVzcF9yZXNv
dXJjZShzdHJ1Y3QgcnhlX3FwICpxcCkNCj4+IMKgIHsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jIA0KPj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9xcC5jDQo+PiBpbmRleCA4MzU1YTViMWNiNjAuLjllY2I5ODE1MGUwZSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCj4+IEBAIC0xMjAsMTQgKzEyMCwxNCBA
QCBzdGF0aWMgdm9pZCBmcmVlX3JkX2F0b21pY19yZXNvdXJjZXMoc3RydWN0IA0KPj4gcnhlX3Fw
ICpxcCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgcXAtPmF0dHIubWF4
X2Rlc3RfcmRfYXRvbWljOyBpKyspIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCByZXNwX3JlcyAqcmVzID0gJnFwLT5yZXNwLnJlc291cmNlc1tpXTsNCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHFwLCByZXMpOw0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJlZV9yZF9hdG9taWNfcmVzb3VyY2UocmVzKTsNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUocXAtPnJlc3Au
cmVzb3VyY2VzKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBxcC0+cmVzcC5yZXNvdXJjZXMgPSBO
VUxMOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoCB9DQo+PiAtdm9pZCBmcmVlX3JkX2F0b21pY19y
ZXNvdXJjZShzdHJ1Y3QgcnhlX3FwICpxcCwgc3RydWN0IHJlc3BfcmVzICpyZXMpDQo+PiArdm9p
ZCBmcmVlX3JkX2F0b21pY19yZXNvdXJjZShzdHJ1Y3QgcmVzcF9yZXMgKnJlcykNCj4+IMKgIHsN
Cj4+IMKgwqDCoMKgwqAgcmVzLT50eXBlID0gMDsNCj4+IMKgIH0NCj4+IEBAIC0xNDAsNyArMTQw
LDcgQEAgc3RhdGljIHZvaWQgY2xlYW51cF9yZF9hdG9taWNfcmVzb3VyY2VzKHN0cnVjdCANCj4+
IHJ4ZV9xcCAqcXApDQo+PiDCoMKgwqDCoMKgIGlmIChxcC0+cmVzcC5yZXNvdXJjZXMpIHsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgcXAtPmF0dHIubWF4X2Rlc3RfcmRf
YXRvbWljOyBpKyspIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcyA9ICZxcC0+
cmVzcC5yZXNvdXJjZXNbaV07DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlX3JkX2F0
b21pY19yZXNvdXJjZShxcCwgcmVzKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWVf
cmRfYXRvbWljX3Jlc291cmNlKHJlcyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDC
oMKgwqDCoCB9DQo+PiDCoCB9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVzcC5jIA0KPj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNw
LmMNCj4+IGluZGV4IDI2NWU0NmZlMDUwZi4uMjgwMzM4NDlkNDA0IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+PiArKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4+IEBAIC01NjIsNyArNTYyLDcgQEAgc3RhdGlj
IHN0cnVjdCByZXNwX3JlcyAqcnhlX3ByZXBhcmVfcmVzKHN0cnVjdCANCj4+IHJ4ZV9xcCAqcXAs
DQo+PiDCoMKgwqDCoMKgIHJlcyA9ICZxcC0+cmVzcC5yZXNvdXJjZXNbcXAtPnJlc3AucmVzX2hl
YWRdOw0KPj4gwqDCoMKgwqDCoCByeGVfYWR2YW5jZV9yZXNwX3Jlc291cmNlKHFwKTsNCj4+IC3C
oMKgwqAgZnJlZV9yZF9hdG9taWNfcmVzb3VyY2UocXAsIHJlcyk7DQo+PiArwqDCoMKgIGZyZWVf
cmRfYXRvbWljX3Jlc291cmNlKHJlcyk7DQo+PiDCoMKgwqDCoMKgIHJlcy0+dHlwZSA9IHR5cGU7
DQo+PiDCoMKgwqDCoMKgIHJlcy0+cmVwbGF5ID0gMDs=
