Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAE3A8625
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jun 2021 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhFOQP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Jun 2021 12:15:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57038 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhFOQPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Jun 2021 12:15:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FG7btb024318;
        Tue, 15 Jun 2021 16:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5dHz4AGEjHgoxHPcdUDK0zb5lKnrfat+F3HzS6+ZWfU=;
 b=0TT9GZkDkg6UP0OpTy2GXVGJrtBtf7h3R3l5yFZYLA8oE9TQjyC56BNwhJPNCOcS8iG4
 wB9Vj+uuseapzYxe06/POUayWXhXmRZrD3dDB8kT5iBUER1pJZyQSmGO/Isth7zT9b5x
 CBCGuDDUrClYQdEEQBkgzjN74bUgjAIdNUbnAYCAP8Iouuf7USKhWVHtg5OPsWosE28u
 c3yIBpvOrUVo/mnh+1yYypSRlkMyovtqP/fmRiLBPgD6lKiF20MRukXglPFEaHrgIH7l
 NON+bStfdLpQ+N9J/qwYTdZYTCa3j59OJ0dbHti+HVAJcdzgFj7hARYhXfdiSNDgXxvt Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x9qrxfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 16:13:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FG5QQ5005622;
        Tue, 15 Jun 2021 16:13:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 396wav5af7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 16:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQiv+I3GcTu+WDKfJJZvuCBKPGQFgiSspTRb7b3TXWOBCg4vhsAaFMovgfnL+E+CRaMrnPE7uVxfCchXe59DI2xg4xu4+RTto5RYaHpbbOF3YOiOZucn+sabwK1CQhUQS1oRkulUKNNDWylMkR+Mn6+aFvgbBBHwHuznddeGw7u3cTCoJQEQBt+pgZIOAmPCxv5jexJDQkPeLd07QnUuabLaHfbdXUrVPz6mmDAOr1fQMgD0CjzTofKgQ/8s00zbFcIP7YxB/xKbordeJtIvAHlM+/LwChX2F+Cp5HMoQsJNxVCIGXJr8KuiOQYr3IZyqlwUtxQ3E+Dopp/36gBjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dHz4AGEjHgoxHPcdUDK0zb5lKnrfat+F3HzS6+ZWfU=;
 b=MwB4/UnMdCUV4oATSja7BDrO6eWBd8GHVw2KdW9yW+BBV7PYDLu6jMktdVdeyferzXeUd96fNIynwoncCqrrkIK4nxBGPn8xYN+1dxhKw3Jvwqw6Gwwxg2CXLXAfN/2qjt56y4Id6jOUkeAQd4dc0lUBcUGV6+YQ2K4pluD6uVjNKHo3ZTrbQEIbAPNYY8s9seswWlLqa3YZ07GsT6RFOImzpQG2tzHAz3aGM/PF6WHKPGkSDD6G+E3HfOS8pgdD6ezhif8kDRimREQFKIYg2XQtHc7wCGzCtcV0o/Pof/3bCgs7mlSyeqCvc0V+AVosOFq8zHxW4wSnV21N0yhAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dHz4AGEjHgoxHPcdUDK0zb5lKnrfat+F3HzS6+ZWfU=;
 b=FpOBrGyl2ZBbi7SypS21EmMzGajx0KxfPocXlO5Z9Wn+/FTQshyWZthjxTLKkZAN/cRDanMsglm16ywOEuZhefCPCYBh7ucqRj1EXoO//HCkAYoYoPpEr6PtKj6wfvC00x5AclrHMu1YLZ8qURl26iCixBWzcpR6nrDm52VwHNA=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1461.namprd10.prod.outlook.com (2603:10b6:903:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 16:13:14 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:13:14 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Topic: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Index: AQHXXPQdh88l+xVVXkWdtTnBVCg426sLWyGAgAAN5YCAABS+gIAHZCwAgABBEgCAAJfiAIAA1DSAgAC5roA=
Date:   Tue, 15 Jun 2021 16:13:14 +0000
Message-ID: <427FB96F-2550-4106-B8AD-EC589C1FD82B@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com> <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal> <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
 <YMcEbBrDyDgmYEPu@unreal> <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
 <YMg111mLzwqu8P0o@unreal>
In-Reply-To: <YMg111mLzwqu8P0o@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f3fd428-f5dd-40c9-88f5-08d930187ae4
x-ms-traffictypediagnostic: CY4PR10MB1461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1461627CE596E089342FBBA2FD309@CY4PR10MB1461.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUFQUmpRCwxYeev3hJA1uNzgH4BZadIOnrPOtBCqKhldxwvaqZCAJXvO3xsscOoldSCtg1bZ+yP/01CyrWq2Y8D+CDoCrzNlL4K2bSJhw6Q6iIHYTWBgs9RKBXRwB1fKzarMAtoR4ZKI1hLcFsMhJv3vGIBBrLnMac8mp064ooDJwyqi2vOgGYSeuEfjyT4zFxd5yl3JbAVj2PHCVwoK+k8aTkCaicZSOcPTpOy84itXt65DqGAO/1qRYcGfXxEtM1MHT3uclhP/gliXUcFisHGivwD2cQgLHc0SmmCv+k2CitbdWBBxFJV6teJO8b1wxwhoOWrb359IeURBjiUnm+xAp7et82Tdm97JLl8T4GicqPCwnJtzxOh0q4GVAA4dGpo7RkPGEhMZKtjYFZaXzjAvNP7gVdXhvFh4bF4RGrY0uvnH8yQE4/KTI+utAEsfVB2AFKD/ekJFjkPoXDIULuPXj0SyrOSz7nHbDNMVmUlowrFZ9Y6onXstjY4ngoZN5z1MYni4cgSn6dGSY43E6R+j8Pbb3zVIX7puhfmzG5upUtpsstlVpXFDKirMvXRlCHqs65z6dgYvg2tI4cJ8+hAYaW9vI/QlKahnz+KBIMRjhXwWJcTZeq56dlz4SCTF7yjjICbauRxC8ryJim+6XlvrXwOtM+IJ3eAJy9Zi9lw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(36756003)(4326008)(478600001)(83380400001)(6916009)(2616005)(66574015)(6512007)(6486002)(44832011)(2906002)(8676002)(8936002)(6506007)(186003)(53546011)(5660300002)(71200400001)(316002)(66946007)(64756008)(33656002)(54906003)(66446008)(26005)(122000001)(66556008)(38100700002)(76116006)(91956017)(66476007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkozWXR0QVVVeUVUZHFveTB0ZFRiRWZpWUcwbnBnWXM4dkQvb1VxSnc4a0h1?=
 =?utf-8?B?MmpmZVgvaFJNUVFLaFZhSkRDbENieHdDTEpDY2VwYjVrL3ZpMGtNdWVnbS8z?=
 =?utf-8?B?UDUzcGpDdFVzQWJHQzhZMDZIM2ZQeWxnNE9hRDRaZlFFR2Z3aGFaTCt1Nzc4?=
 =?utf-8?B?MXB5amZLRGlEM0xSbU44eVY5T2ZrRy9QZVk3RGpGT0JsZHpGZCtKMmxzVTE2?=
 =?utf-8?B?Si9oeEJXT0VlY002Ny9GM1RCam5uS2lsQnJKbmlyNUsxU2QzblVPTUZFM2NG?=
 =?utf-8?B?Tmx0S1lmSGpOY3ljZGJNQzQwRWFHbG5XOHJCdThBaVlpeTlyQ1JCZzJlZjBV?=
 =?utf-8?B?OTkzVHFIamc3UU1haGN2dzJ2ajBTYjRwRUNidnIwYUhQOUkycHVaSjdFSmJr?=
 =?utf-8?B?bWJtQTMxcDdsQTA1RXJpc0kzczZJcE9lWnlwcWdnQlM5MTd0L0JBcWVTNnkz?=
 =?utf-8?B?SGRsTFZDVmw5S25WaUI3WUsyWUg2cklValVxTWNoeldjTFVtQkdwSllxOEI5?=
 =?utf-8?B?MHY4Z0VSUFV4WEo0Z0Fic2FZa0RxdDdYQTJGOHAyQ3ZZcDB0Nm5sRm9VY2Mr?=
 =?utf-8?B?RjZwckdocklXWXBqSEkxZVRqVzQ1SmU0U1RYb2YvV2hQc2ZDbDAvbUNqZGc5?=
 =?utf-8?B?dzFVKzRyQlN4Wncwd1FTb0NNc0xYQ3N4ZzQrdnFTeEF2bkd2RnRISUNVZVlM?=
 =?utf-8?B?WnJPSzNZOEtjVzNMR0lYQllLSHRpYklXOWkzVUVTbEwwNHhnenVxcm5VMndJ?=
 =?utf-8?B?S3lNTTUrTWQzQzgwR3dlNkMvSm9pN2R1YkpHd3JGY3Jxam5BVWp3Nk53VDdm?=
 =?utf-8?B?eUVtY2hlMS9NbGJ4WEVkUzFZU1gyd05sanEzQ08zazREdGF6akdpRUJDNTZ1?=
 =?utf-8?B?dVQvNnZaOHZNQTh5YjhXSmtxbXJPRmVRNDcxWnc2UnoxdUd0V3RyQTZvL2RQ?=
 =?utf-8?B?MUJ2NVBVM054c0NKN1llVmNsYjRpdjZjWnpIMHlsWHAzVUJ6UjBmdmNLYnlz?=
 =?utf-8?B?M1lrZXVUODlURUpBZnlsYUUyTmRSZjg4S1hILzRJeHJZMEpNSjRmWGlLWEI4?=
 =?utf-8?B?MFBGVFh5NXZtcU94RndWU2JiME8rNE9HeGl3djVDNTVya2NmS3F3YnVnZTJP?=
 =?utf-8?B?YkQxeUc4MVhrWjBhejhlbkZ1TVpXNngweDZuZFFrTUo3eEkvdE9FRWxHTzJ2?=
 =?utf-8?B?dkFNZHYxaUlRbUpnREhkeXFhTm5JdGJFNElXMlBLS1JleXJiWkV4QlZ6Y1Rl?=
 =?utf-8?B?ZnFyeUFvMmR4bjRFTmZ6NGxaTWRvbTNOZ3lZR3FVWC9HcG92Sy9SSUh1MVlR?=
 =?utf-8?B?UUxQSVA3SlpMVVR0dzRxVnpRbUdLZkVsTTAzUXpFTllrR2lleVRwRWM1QWFB?=
 =?utf-8?B?YjNtZjhKTmdmMnZNY0NCcVA2ekpQVWF6WnNIZnRVN3JObDZKOGFURUVyNlFi?=
 =?utf-8?B?cERHdkNvNCtVZU53aEllSEdYTXd5UXpnTmZldVJnNHl2c1M4TldYQjhicUtn?=
 =?utf-8?B?Y0xnYkszOGdSeGxqNWo4dTFNekRkVGVVRFZPYlJweFpnbnlFRlFHVnN5NS8w?=
 =?utf-8?B?NnQySTMzZSttYnNKTkNwdnZIY1IraWMvTU0yU2kxOHJtZ1JqcEVEbU1nQ2Ry?=
 =?utf-8?B?OW4yTHFVR1JxRHBYUytIdkRwSEZ5UEJVaU12cDhMaUNGWDFFNEdKTUJsWTdT?=
 =?utf-8?B?alVCb2RlajN6TXV0RDhYWjRmUXZMRG44WEk2ZnVTT3RyWHJXcElMdy8wZmFn?=
 =?utf-8?B?d0ZTL0tPQXpPZDdRM3cwMGhuamFKYnhNaDVKWmVOK0FjNTE1ZkljczRTL2xk?=
 =?utf-8?B?dTZ2TzlXTThQTStpWmp6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <557C605D1E99954A8C790C347332D533@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3fd428-f5dd-40c9-88f5-08d930187ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 16:13:14.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UNLg+9WTAsLMwK7ynKm5UAAinjI8czHLWfcZuDbfDgPCRz0Kk4CzNd+82LMN9ffqFK7jHvAlEOpP8uF7liHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1461
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150101
X-Proofpoint-ORIG-GUID: BkwCwwR-Wv8fn3hj15-ynVB9UtVbSlvF
X-Proofpoint-GUID: BkwCwwR-Wv8fn3hj15-ynVB9UtVbSlvF
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTUgSnVuIDIwMjEsIGF0IDA3OjA4LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAxNCwgMjAyMSBhdCAwNDoyOTowOVBN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDE0IEp1biAyMDIx
LCBhdCAwOToyNSwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIE1vbiwgSnVuIDE0LCAyMDIxIGF0IDAzOjMyOjM5QU0gKzAwMDAsIEhhYWtvbiBC
dWdnZSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gOSBKdW4gMjAyMSwgYXQgMTI6NDAs
IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4g
T24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMDk6MjY6MDNBTSArMDAwMCwgQW5hbmQgS2hvamUgd3Jv
dGU6DQo+Pj4+Pj4gSGkgTGVvbiwNCj4+Pj4+IA0KPj4+Pj4gUGxlYXNlIGRvbid0IGRvIHRvcC1w
b3N0aW5nLg0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBUaGUgc2V0X2JpdCgpL2Ns
ZWFyX2JpdCgpIGFuZCBlbnVtIGliX3BvcnRfZGF0YV9mbGFncyAgaGFzIGJlZW4gYWRkZWQgYXMg
YSBkZXZpY2UgdGhhdCBjYW4gYmUgdXNlZCBmb3IgZnV0dXJlIGVuaGFuY2VtZW50cy4gDQo+Pj4+
Pj4gQWxzbywgdXNhZ2Ugb2Ygc2V0X2JpdCgpL2NsZWFyX2JpdCgpIGVuc3VyZXMgdGhlIG9wZXJh
dGlvbnMgb24gdGhpcyBiaXQgaXMgYXRvbWljLg0KPj4+Pj4gDQo+Pj4+PiBUaGUgYml0ZmllbGQg
dmFyaWFibGVzIGFyZSBiZXR0ZXIgc3VpdCB0aGlzIHVzZSBjYXNlLg0KPj4+Pj4gTGV0J3MgZG9u
J3Qgb3ZlcmNvbXBsaWNhdGUgY29kZSB3aXRob3V0IHRoZSByZWFzb24uDQo+Pj4+IA0KPj4+PiBU
aGUgcHJvYmxlbSBpcyBhbHdheXMgdGhhdCBwZW9wbGUgdGVuZCB0byBidWlsZCBvbiB3aGF0J3Mg
aW4gdGhlcmUuIEZvciBleGFtcGxlLCBsb29rIGF0IHRoZSBiaXRmaWVsZHMgaW4gcmRtYV9pZF9w
cml2YXRlLCB0b3Nfc2V0LCAgdGltZW91dF9zZXQsIGFuZCBtaW5fcm5yX3RpbWVyX3NldC4NCj4+
Pj4gDQo+Pj4+IFdoYXQgZG8geW91IHRoaW5rIHdpbGwgaGFwcGVuIHdoZW4sIGxldCdzIHNheSwg
cmRtYV9zZXRfc2VydmljZV90eXBlKCkgYW5kIHJkbWFfc2V0X2Fja190aW1lb3V0KCkgYXJlIGNh
bGxlZCBpbiBjbG9zZSBwcm94aW1pdHkgaW4gdGltZT8gVGhlcmUgaXMgbm8gbG9ja2luZywgYW5k
IHRoZSBSTVcgd2lsbCBmYWlsIGludGVybWl0dGVudGx5Lg0KPj4+IA0KPj4+IFdlIGFyZSB0YWxr
aW5nIGFib3V0IGRldmljZSBpbml0aWFsaXphdGlvbiBmbG93IHRoYXQgc2hvdWxkbid0IGJlDQo+
Pj4gcGVyZm9ybWVkIGluIHBhcmFsbGVsIHRvIGFub3RoZXIgaW5pdGlhbGl6YXRpb24gb2Ygc2Ft
ZSBkZXZpY2UsIHNvIHRoZQ0KPj4+IGNvbXBhcmlzb24gdG8gcmRtYS1jbSBpcyBub3QgdmFsaWQg
aGVyZS4NCj4+IA0KPj4gSSBjYW4gYWdyZWUgdG8gdGhhdC4gQW5kIGl0IGlzIHByb2JhYmx5IG5v
dCB3b3J0aHdoaWxlIHRvIGZpeCB0aGUgYml0LWZpZWxkcyBpbiByZG1hX2lkX3ByaXZhdGU/DQo+
IA0KPiBCZWZvcmUgdGhpcyBhcnRpY2xlIFsxXSwgSSB3b3VsZCBzYXkgbm8sIHdlIGRvbid0IG5l
ZWQgdG8gZml4Lg0KPiBOb3csIEknbSBub3Qgc3VyZSBhYm91dCB0aGF0Lg0KPiANCj4gIkhlIGFs
c28gbm90ZXMgdGhhdCBldmVuIHRob3VnaCB0aGUgZGVzaWduIGZsYXdzIGFyZSBkaWZmaWN1bHQg
dG8gZXhwbG9pdA0KPiBvbiB0aGVpciBvd24sIHRoZXkgY2FuIGJlIGNvbWJpbmVkIHdpdGggdGhl
IG90aGVyIGZsYXdzIGZvdW5kIHRvIG1ha2UgZm9yDQo+IGEgbXVjaCBtb3JlIHNlcmlvdXMgcHJv
YmxlbS4iDQo+IA0KPiBhbmQgDQo+IA0KPiAiSW4gb3RoZXIgd29yZHMsIHBlb3BsZSBkaWQgbm90
aWNlIHRoaXMgdnVsbmVyYWJpbGl0eSBhbmQgYSBkZWZlbnNlIHdhcyBzdGFuZGFyZGl6ZWQsDQo+
IGJ1dCBpbiBwcmFjdGljZSB0aGUgZGVmZW5zZSB3YXMgbmV2ZXIgYWRvcHRlZC4gVGhpcyBpcyBh
IGdvb2QgZXhhbXBsZSB0aGF0IHNlY3VyaXR5DQo+IGRlZmVuc2VzIG11c3QgYmUgYWRvcHRlZCBi
ZWZvcmUgYXR0YWNrcyBiZWNvbWUgcHJhY3RpY2FsLiINCg0KTGV0IG1lIHNlbmQgeW91IGEgY29t
bWl0IHRvbW9ycm93LiBUaGUgbGFzdCBzZW50ZW5jZSB5b3UgcXVvdGVkIGFib3ZlIGlzIGFtYmln
dW91cyBhcyBmYXIgYXMgSSBjYW4gdW5kZXJzdGFuZC4gQnV0IHRoZSBpbnRlbnRpb24gaXMgY2xl
YXIgdGhvdWdoIDotKQ0KDQoNClRoeHMsIEjDpWtvbg0KDQo=
