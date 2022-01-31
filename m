Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5E4A3FE5
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 11:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiAaKOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 05:14:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16772 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232024AbiAaKOp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Jan 2022 05:14:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VA76dH025836;
        Mon, 31 Jan 2022 10:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BtoX+P8xpuRvq/zpfUejPZaDyG4J04LhSZwY6R/fn9A=;
 b=Z4/TrdLSuJl3t3f1bZ4pSHerofqcVHC17uS8cM3PLon7FWZhBsVCKDY+UWiOqjVTk9n+
 nTLH7OB887u8+ICmE5Z/2tKZHslezzwnRJ9Qxlc3iiU3sLXvO3XKeFDldqVydc0cnV4U
 GIPAWsKXZ6gFQxZWe/0UOfWuDWKmtrx3S4p23DK/dJ4OylwiTISKXkMs9M3LVQzExhu3
 GIrAEB9cBoqwi2OBPvsBQ7w5IPx/ovLXPlfyy5RFV3feiEWcJMB2FveIhZ1RuYhEX2Sq
 f6T3BJKnUgGzV2vdivJoLI95x5X4wrNs7x/kw3+6OSKe/iz8OSdosSG2ZrlUkbhUWNIv rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvx4uuhcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:14:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VAAXGi048389;
        Mon, 31 Jan 2022 10:14:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 3dvy1mbtaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA5XB/9lubn0z+5irEwD8z5+4eIyhfmW1dS+Hun3ZC66jdAVQJ/Nx4Z6DS0a4dKkElHi+GkFRRPn1rELRfPz7Kok1uwVhJDUQOkn+AzivzQ+jYSNVCZXZkTks3bDG/+Z4/iE+RFAfZH5DXIMJwltJyHAV1su34KAamltFXqqJNwTOwKTeUPtgA8oK95/oBkN8GMdlsh3M8mJ3ZqdUPSjkC73zuokrZUaGEcjk5TignCAkWBL9qQ8bI+4jlrFtJvhus/XFoeGI8lXqdQp0Q+4IMKJuwY5YskyXJAzFTWbSbBasmJ8NaLyWM28lHxZ34NagjTEhAdecHvPBxOYxj+zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtoX+P8xpuRvq/zpfUejPZaDyG4J04LhSZwY6R/fn9A=;
 b=Cuc5ZHEOu3YGJ9EMgaCDVvcjgnRDLxmyQdEgnaGqu0qceau5c7afxiYuf5Pb/KT1s5fBp7IjZuxoGUSnMnKpDbF31Lt4XEQP8+xheDTR8J40EtsWHfwx1CMQrzJTlRoWDnhbQ4t4KMvX5uoyE+qeMEI9eIj9QV914Wq/KLjT1fO1lmzKe2U0YwGl20iKaYft+YviseKUM4SaA1mMiU/fAoKEuIX3RMpoTQq4AmZlTx6s0H6LdQh69Vh17+S9Pl5P4Mv/T3YBQhX6ghhxwL6geZPIT38elnaC8uwC85CjcYKe5HXMhtZVlFipZWpVw0a/6gLVdSQo7H4ddscpyuBreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtoX+P8xpuRvq/zpfUejPZaDyG4J04LhSZwY6R/fn9A=;
 b=eCHIJOMEXSixumpBREd2MwNpL9ybH5pnA2FlggaEPR8JCvQJpcWOp1oQUbunF85MZQGgPxH7J0SvQ38AR7aaknTFrVo2KpAf2L/YPwSYtIIgyBeunTf2ToGKDL5SDTlObYhaBoPHnlZs3mfWBxs0TcY1EnawL/MWi3ziiGLsbuo=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by BYAPR10MB3349.namprd10.prod.outlook.com (2603:10b6:a03:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 10:14:38 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%5]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 10:14:37 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Don't continue event handler after
 memory allocation failure
Thread-Topic: [PATCH rdma-rc] RDMA/mlx4: Don't continue event handler after
 memory allocation failure
Thread-Index: AQHYFodvS9L/5cPK/EuJekMEqIAKH6x86aSA
Date:   Mon, 31 Jan 2022 10:14:37 +0000
Message-ID: <EC96B5E9-9B6E-4C37-8C92-90BFD7A36500@oracle.com>
References: <12a0e83f18cfad4b5f62654f141e240d04915e10.1643622264.git.leonro@nvidia.com>
In-Reply-To: <12a0e83f18cfad4b5f62654f141e240d04915e10.1643622264.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765286d1-589f-4fe6-84b5-08d9e4a27cd3
x-ms-traffictypediagnostic: BYAPR10MB3349:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3349B2099A43522DEF19277DFD259@BYAPR10MB3349.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/aiuNalUJZO9NyE7e87g1tV78tdl4IsPgkwpuIjNtHWYi78vGbjIKNW4M/lg6oWBy20W9ZXsZnIhvcOKiA7mLVHmJv88VGKK22MvBfKIUGjiwHoOovOLQ7cV4qHwKAkmAM4yg4YKuBehxO0dE0DMXyg0nut4yNxPGoODV90fIDHIiCbNQRqCare6dDKUMH6Wt5nLCH0K+rQJ+ulsZYENKF2yLuHzu54CBMBAlbtJKoKoEquu9XVY1x34RFDOJvcD9Me4DRKIVi3h+fdGpMU1wv8HsgxF8WgV7H8C4LvZU8oW4TlrIjWbYqg3uiDiagWC52QmeiTJqrEHTTRjEqC3sGm6KmR1H3P8mGoa0KAgcAmKN2wMTCM8t5YNtW0Ic60bSnVSGohMIJuR9wYfGVo9ZythjL8b6okuMDp10CPjogsvDULPFoh7ucEuLW9n8pw3wAGJRx9PFJyigqD8V73mGiwRrtXM0DSEkHxHN9hg5Zi6++gCUqtHNXTJupgUa1H2rG+DLIwGCds4SXNcxC8YGhHdrGAv6WC1fV4mY/G8Evr0DwViv5cUBcA/XsOCfSmvPzCOJcOmcnT/o95jTEPKb+50a5eu2n99LsdsogH23+KyK+dKoTTpcf6JJ8wy2ru9kBtNNwCWi5iW5QXg5XicGKNeGywhcPZMYjsW27P1/JOiXFwNFYcAuwCXLrx/kJheLD9erkwGo7twObOXJ/AnI2alq79ThdCQX5qhUlykNkWRTWLSkoTqil00In/O8BS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(66946007)(66446008)(66556008)(76116006)(316002)(64756008)(4326008)(33656002)(5660300002)(2906002)(44832011)(6916009)(36756003)(54906003)(8936002)(91956017)(53546011)(6512007)(26005)(2616005)(71200400001)(6506007)(6486002)(86362001)(508600001)(186003)(66574015)(83380400001)(38070700005)(122000001)(38100700002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDhMSFZaU2VzY3hkN0w4TGMzZTc2b2hUZXd0SEZxVWxxZmlEeFpHR2JvaStW?=
 =?utf-8?B?a0UxT0NKOGRMZ3RNay9Nci82V0dJOXJCemxzZFUwSnhrc3NJamhNRFQ5WHlF?=
 =?utf-8?B?VUE4MHFZLzY1VUdWQ2lhbkt3dVp1am5GZEhUSW9uSjRQNEVzaWRqYUo1eHkz?=
 =?utf-8?B?WFNld2ozWE1Ma0QyT0VOeWdVMTBPNG4yK1dtWitPZ01DWXhMWUZBYmdxcXNx?=
 =?utf-8?B?MjBReWpieStwaHkxNzdrd3JGZVFDWnN6VEZYY05FaDUxWTlaeE1aOHVZQjFo?=
 =?utf-8?B?MldrbVQvQklId0FJbDhCSVpmc1I4cVNpRmw1bXRsMm42U3pVTjQrOXh2R1cv?=
 =?utf-8?B?UlZpeWRjM2RZNS94dHUzU3dPcmgxRXRqQ0pDSlBobHBOR3BpT2lnbW04OWFV?=
 =?utf-8?B?VzlXNHk5QnNnaEZsMWFPa1RVdjBYTEVLVjVXdVBsdkZWSHRpZWJ2U2ZMaVpx?=
 =?utf-8?B?NFJ0eW54bHRnN3BjVDU0QXcwYTdwYlRneldyYmF5YmpZYUd4Z2ZOMTR4SmFM?=
 =?utf-8?B?ckxqQUZ2SWFIb3dUWGlOMWx6VTNJZlBzdU5TVmowSlU4VnAvU0c1QzQyWWp4?=
 =?utf-8?B?aWVCeUhOUUFPSmdITDJvK3h5T1FvTXRMK3F4WUVURko1bTg5OUdEbXhZWm11?=
 =?utf-8?B?UkkwekorMCtpRU9TT1lmYndROU84dVBBS3lZZVJFZ3MyWG1oeGczVnVkanRP?=
 =?utf-8?B?NUduQzBmSnNxbHBKNHpVYTBnQXNBTmpHaGVjNXp2THJ0QXlBZ1RSNk5OUFR4?=
 =?utf-8?B?aWRqR2ZhZWNyZ2xPYUhuWkxwcHNNc2JQNkRNRHlEbEFuUElPYWZqR1BxeHlo?=
 =?utf-8?B?cDZGTk9vakpFTGpVeFV5clY1b0IyY3NlS2p3Um5kRjZLY1lIeHpFdmF5cVNr?=
 =?utf-8?B?TVZaTlIrcmFqNno0VkNjRVZ1bkxnZ2MzMTAzK2tMaW0wRlI1eHg5WHVYZzZj?=
 =?utf-8?B?U3dQK3JTNWFDVmVPbkFKcHp0bk9YQys1aXdPLzVQTlFkdTFrWVdwdEt5bVRs?=
 =?utf-8?B?U0cyajdaWENxMGFqby8rNmxGSWxNU0NnSHAyVW5Sa1Z1aUVJbFNpdEV2Qlpw?=
 =?utf-8?B?MGVBTm5TVFRGVkNzemJ6Ymx5N0ZUTG1nc1lCQWYwYnlJMUsxdDBnZnFJUExB?=
 =?utf-8?B?NndCeVhIdkdUZ09OZjltUEV5QjRsZWNxblhPcHZNM3ZDK3pzOEI0MmpIdXE0?=
 =?utf-8?B?Vi9Mc0NtRUdLWSttbkpUL0FFd1NQK1QxTmV4bndYckMyZ0xGWTlmUjAzU244?=
 =?utf-8?B?VGdkNmt4Vm16VmhCSEEySWl0Z0JXQmt2Y3ZwQk04TU12bWdYdS95VytNYTU1?=
 =?utf-8?B?ME9IbmNkakIwOHNYOUg3aDhQbEpRLzBsdXRwUnpkcDIvdUZxai9vNzgwR0hH?=
 =?utf-8?B?WUczTW00R0xGQmZhQ2NsOE1NSEJNYlBnM2x0Z3ludEFPMnlaOWthaVd2OGJl?=
 =?utf-8?B?RThBRGZuTzgvdGtVU0NEWEJhSW0xTDVONzBHYTlRYXFJUUZGcGxOT2dwcjg5?=
 =?utf-8?B?S2pCWnlQa2JmV2pQNEpwNUpnV1JTSW5Pb1M3eFVwQ3Jrc28rbHNMSHA4bW9i?=
 =?utf-8?B?ZmhBT2pMc1VCRVdGK3dOdjFvUHRZcHZzWEV4RlRyY0NtdzVWZC9BdDdVWmJk?=
 =?utf-8?B?eGFqYkpobnN5SEVIcjVMNnZtUjliSkZFQlNMUnMzNGFKWUthMk9Cc1pGbXRa?=
 =?utf-8?B?Uk1UWjVRU3ZDN0FqY09KQU96cmlERzlFQW5sYU1jR1RPRzdXelM4ZVJ4RWR0?=
 =?utf-8?B?ejU1U1BmaVlwczN3UlJiSnFPSTJ4S2ppdEpKTkZ0c1ZsV3FpN1d1cU1tYVEz?=
 =?utf-8?B?Y1NxTENLU3F4VitJZHFLYUUvdW1abmhQcCtMSEx4MCs5M0JkdWZRaEpJT1NF?=
 =?utf-8?B?djl0ZHFaQzJEMUR5U2dCYVpiL3NDWXpTcU40YWpKSUVqUGd0eTZ4R0ExdWcy?=
 =?utf-8?B?cCtRcktTaGNTdTR4VkxmNWxTaWh3V3ZCZ08xcTFkcUI1OTZBSzloczlqU01l?=
 =?utf-8?B?NlU3SFdkazk4UTk0a1VieW9naU5WeXl6bUtWYWZiYTZYL0pkQld3VjZjRkxl?=
 =?utf-8?B?Znh1WFNDWDk4Y3V0ci9MYytxcVBHNlNqa2tsUncrWEZaN09JZEVQUG1NOTVY?=
 =?utf-8?B?S1VSS2FhZDA2b2xlMTBVSlU1QytIMlJ6KzI3TU9PWm13ZTRhcms3Y1prRWNj?=
 =?utf-8?Q?/HVkiMSdDROifKSqJxTHp9U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C83381EF4CED45BC8DF87096663FB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765286d1-589f-4fe6-84b5-08d9e4a27cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 10:14:37.9081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RK5j4JyFvuWMNn58tzCdEoojCBTUlsAnPtuHTKC+eYyV4VSlavL16V0/FqF2z5puynpA1i01BTDH8XR0Jm6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3349
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310069
X-Proofpoint-ORIG-GUID: h-kfFfR0JfutfnHxWiz8k7hbgTjZObhX
X-Proofpoint-GUID: h-kfFfR0JfutfnHxWiz8k7hbgTjZObhX
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgSmFuIDIwMjIsIGF0IDEwOjQ1LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0Budmlk
aWEuY29tPg0KPiANCj4gVGhlIGZhaWx1cmUgdG8gYWxsb2NhdGUgbWVtb3J5IGR1cmluZyBNTFg0
X0RFVl9FVkVOVF9QT1JUX01HTVRfQ0hBTkdFDQo+IGV2ZW50IGhhbmRsZXIgd2lsbCBjYXVzZSBz
a2lwIHRoZSBhc3NpZ25tZW50IGxvZ2ljLCBidXQgaWJfZGlzcGF0Y2hfZXZlbnQoKQ0KPiB3aWxs
IGJlIGNhbGxlZCBhbnl3YXkuDQo+IA0KPiBGaXggaXQgYnkgY2FsbGluZyB0byByZXR1cm4gaW5z
dGVhZCBvZiBicmVhayBhZnRlciBtZW1vcnkgYWxsb2NhdGlvbg0KPiBmYWlsdXJlLg0KPiANCj4g
Rml4ZXM6IDAwZjVjZTk5ZGM2ZSAoIm1seDQ6IFVzZSBwb3J0IG1hbmFnZW1lbnQgY2hhbmdlIGV2
ZW50IGluc3RlYWQgb2Ygc21wX3Nub29wIikNCj4gU2lnbmVkLW9mZi1ieTogTGVvbiBSb21hbm92
c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCg0KTEdUTSwNCg0KUmV2aWV3ZWQtYnk6IEjDpWtvbiBC
dWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQoNCg0KVGh4cywgSMOla29uDQoNCj4gLS0t
DQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L21haW4uYyB8IDIgKy0NCj4gMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFpbi5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3
L21seDQvbWFpbi5jDQo+IGluZGV4IDFjM2Q5NzIyOTk4OC4uOTNiMTY1MGVhY2ZhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWluLmMNCj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL2h3L21seDQvbWFpbi5jDQo+IEBAIC0zMjM3LDcgKzMyMzcsNyBAQCBzdGF0
aWMgdm9pZCBtbHg0X2liX2V2ZW50KHN0cnVjdCBtbHg0X2RldiAqZGV2LCB2b2lkICppYmRldl9w
dHIsDQo+IAljYXNlIE1MWDRfREVWX0VWRU5UX1BPUlRfTUdNVF9DSEFOR0U6DQo+IAkJZXcgPSBr
bWFsbG9jKHNpemVvZiAqZXcsIEdGUF9BVE9NSUMpOw0KPiAJCWlmICghZXcpDQo+IC0JCQlicmVh
azsNCj4gKwkJCXJldHVybjsNCj4gDQo+IAkJSU5JVF9XT1JLKCZldy0+d29yaywgaGFuZGxlX3Bv
cnRfbWdtdF9jaGFuZ2VfZXZlbnQpOw0KPiAJCW1lbWNweSgmZXctPmliX2VxZSwgZXFlLCBzaXpl
b2YgKmVxZSk7DQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCg==
