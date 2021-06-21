Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BF3AE52A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFUIrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:47:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUIrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 04:47:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L8fGPY032314;
        Mon, 21 Jun 2021 08:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=74jUkfClQRJ/8njM6XK1XsyOOky9POFwm4UtntoHSFE=;
 b=Biw/OwaLo+6/Q7ajl2rr+QdNR5hEdosek4LHlMFJ25tKZPzkLzDr574SUbdhjyP82Qqx
 rBX76ykyWwFwZDNzSNowtzsr4qj0Rvz2P16pHP4vVblnaIYPNDtsJKFwZ52XPRYCybBQ
 8flfVtzQ7VlYT+rix1T0fccnOLt18JqvIlgFgGz+9jSDDSAdmRzsqLnGvSZFhOfLDuYH
 ss3f5+qApzuN+NB8br2Qm/TO0/Z65AM6N2Nlwu8hWlmK5UxPF/cQXwlLhw1Ll6Hwaie5
 Zl8mVrE9YyRxbg0CIdrxQQbK8+s8vJmVgGOFSTZks9J3Zk/aif2jIQMo7CnSqADRy4RG NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39a65th3mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:44:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15L8fMux101464;
        Mon, 21 Jun 2021 08:44:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3998d5ff2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzNj4tb+NgVO+G13N6KWYJabSDCvHueFFl2BI5mSNtba+UIjmW0lYhCHlR2iEI8IS+uP0/arIZmEIY5AJ/iz5+9r4aWY1kYiCSGKECc5qzgjoQtH+ajDyUYRhcmUfkiT8jaepUJQIT/9jDXcybfTgWZCODqVTGXHdtkyC4yWcDJz+xl/+snTQ5jVU2mJsoqT1J+qUkHPDi8X7Qol6vKOiHmMz0Ld0zZWAyN2VS2SjeAqxQ2y1VYD0mfi2YyAVi4FnaODBioRexcTV7P15eqCFvk1QH4n4LsZj/8JWEH5h6PJUqy0tpaqlloY5qUZivLf+O4kEeivRP5NBLr3QBH4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74jUkfClQRJ/8njM6XK1XsyOOky9POFwm4UtntoHSFE=;
 b=X7Zm50bJYSYxa9O+bilGl6hX7WQQI7dQFAXblVJA6sk2bgQmtrugQovlH8n5ouj+hRBJVdIsEYe4lnipb3OvLb1aaWRHobSWga/0q5fvcnnMZ28sdqNVG7brUwdKcdatME6i6tkV5YDq09KNnwmt/X1CVB+wJvt/tR4cODWUtjOMbfVS7p2ogcIHMqpC2rSpXS0d+wTGoNhUI/YO9kA3UqJuM2HRR1Rp3/PYl+6llLs6Ky3gmwrW4UqzKrzR2W/k0A0OfisLZMIkM1mbD0I3lKdBEvzvqfGh33bHgPn3x6i3Jxmq64t3TJpb8amEC++ThtiMBlDPqtQDWT0i5fMFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74jUkfClQRJ/8njM6XK1XsyOOky9POFwm4UtntoHSFE=;
 b=PQhmuGdF3mV9Qbk0M6VwCsCIgS5LSwN5QIb6POckRArKNIp/hefXzTX/Cem/Eh00J2kk5TMrSN1LgBHwdAZliwzPgok9ER5uOumtYbUTqkZH3RDqTsjUQ62CIMPXKG4CB4zS+OizD/kbd0VrA6xU+eN82Qqwq3cHDjz9qWAm990=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1271.namprd10.prod.outlook.com (2603:10b6:910:4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 08:44:38 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 08:44:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Topic: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Index: AQHXY4/9tgmALgj7ckyob56jJS8GkKsc1c6AgAFWZgA=
Date:   Mon, 21 Jun 2021 08:44:38 +0000
Message-ID: <BA591410-6EF9-499C-B383-12A0A550D46E@oracle.com>
References: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
 <6e6e93a7-f59e-8c67-c5d1-e6a64a556a54@nvidia.com>
In-Reply-To: <6e6e93a7-f59e-8c67-c5d1-e6a64a556a54@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0549f55-3df1-4aa2-f13a-08d93490ce09
x-ms-traffictypediagnostic: CY4PR10MB1271:
x-microsoft-antispam-prvs: <CY4PR10MB1271FEBF31F802397394933CFD0A9@CY4PR10MB1271.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwA9ZVLhZolzmkzt+IloZU1v60/zVUW1KwZiDFQRoCJfy7yBLGUdVeFjomIpV5qsj6nRHBCTy8x4t/3zIW8pn5i6cfavli3lZHIfOkRfjk006gfFtfcMDfG8olqC0KqXsOVGOx9LU3JTF2dxdDVBMsObVUxHDSPEqmX20fdqKJk6n+//d/y0kXn8DQqFhiHVNImMcIW37Rc6lw9jPc7gtJf0SHUUho5b08bnyu7wF71KhgcxxG91HSyIFloKYRiQrh6BYuAqsr9yZkfxvongWcmNhnIleg8NPYRzAfVUgG3emaz0XIlzyLH1M6bOiMbZkxbvTGwoOLKZdgF9dboJAWKJigPmMGUBKqFzNCEuE0Y/N8l9hswOrI91fUVWTsgeoUch/JH8QKoe5yY3n8D4chi96QEpfPq1fw03Q3aXkym2W9sXLCmeaDq/ee3nxdN8+x51rG4ySYrechxa6N1Vby8lXeT9mizc8E+pb2/gH7CQZPsZoby/U3nZNCWF1E7gTRXYPHK0cEIO1ckiHVp12prXMn5Wuv2nTNfWlgK1QhsRPjetCBJbqQBiRpLkR8UqezmjBPfqM+SyrMl3PXlTUzWuE3vZ03Yx1+6IBM91XM40LKkKxPKE3DojfvGpQQNSWm0v498oRnUozMuSd+IbC/5KGh1wcczMjyCLyf7gnQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(33656002)(316002)(6486002)(36756003)(44832011)(66446008)(64756008)(6506007)(86362001)(83380400001)(186003)(2906002)(66476007)(66556008)(53546011)(8676002)(26005)(5660300002)(54906003)(66946007)(76116006)(91956017)(66574015)(2616005)(71200400001)(8936002)(4326008)(38100700002)(6916009)(478600001)(122000001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blcza0FjeUp2bHYrL1dPMjl2dUJ1VGlXUU5YOHYvQkdrRVY1SE54ZTVEUXRs?=
 =?utf-8?B?ZmZOS2lOMGxLbDZvOWlhcFhDMWJleHkwK2FRV2VVbFVoWllBL2orcHJpVjc5?=
 =?utf-8?B?c1h2clRnTG5DTFgrR0srZDZhcmR2V096b0dNdkJhYU9rMDlmUVFhVnVzOTRa?=
 =?utf-8?B?alhab0VKdVpDMU94TXNzTjROZkFCZEdCNlRYYlBsODhmNmRuOUc3Y0ludmNv?=
 =?utf-8?B?MVo4L3lwVU5DZUV2SzZ5NTVMNTNnOU4xTmZjQk9QMmV5ai9ZUGxvQWZkWDlT?=
 =?utf-8?B?Q2xpR2pYdnFLc3VhNExPOUJKa2xjL3JDclg4MUtOMW9IR3BFTGdtUnhYcGJq?=
 =?utf-8?B?Q0g1QU5NS0pSVTlJUjhUbE5PeDZWcWdKNXdWTk1xRHBucHY4Qm9iKzBDSjdq?=
 =?utf-8?B?ZXUvUlQ1dzQwRGNES0dpSTRSbDRYeTJVb3hhSXhPS2tHQXFqOCtsTjdOWDJn?=
 =?utf-8?B?TFZjY2NwNUZtUTZ1OTE4ckI3TGNiUUI3OGxWQ1RlZUJINTBxNGpTWnFtSUd4?=
 =?utf-8?B?STRCYnJOUm9RYkdzSDNxcWtneU5oNUoxbVM3OWEwUnA5VjIwQ2dqbHE0QURS?=
 =?utf-8?B?MWJmWmsyL2swMDJjSXdzcG5pVEpNQ0VCa05wY1JMUEVVRm5IREMyZHdsalRy?=
 =?utf-8?B?Z1h6QnhrMVZqaHliM2llSFNPb0tKcTE3R3Zid0NZcnN4T0d6MUdvbSsrbFNP?=
 =?utf-8?B?WXRTMERTMmZWZmt3TXNRRXBDL0ZCQ0praFR6MUlrMmluZ2hFcFRWQmYvSDRZ?=
 =?utf-8?B?aGlaeGlMK1ZqTUh0bGNodVk2elVsQU5tdnF5bk9kMHRrOFlyU3pCeFV5YmFK?=
 =?utf-8?B?bzR1OGxyOGdUZkN1RW1RUnNlT29DVUpjR2J5Z0pOUzVvQUxEZWhJUkpzcWhl?=
 =?utf-8?B?MU9maC9YTmNrdjFLendhNGlVaWdMdFl1ZUhXajBuY0dtV015SHIxcVB5VlVm?=
 =?utf-8?B?ZGdPT2tQYVZsZjUzMGFXa1RXR2ZmYWdxM3B0dDBBT01zcUh1dHdzc01ZV1Bj?=
 =?utf-8?B?YUxpbVRFdTdsZkE0ZnM1MUMySkY5TC8zV2VpSzYvaG5LbTdlN0pwSVRGRm13?=
 =?utf-8?B?Nm9xMlNXM05xbTFJaUN2ckdldysrUDBRd2lSc2FsdVJyU2NxbWp2akZPbzI2?=
 =?utf-8?B?NlFGZ1ZoV3o5S0ZvY1B3V1I2VVBMOEFQM3FYUHZ1WisrSVlzbkZFSGxtY2xB?=
 =?utf-8?B?T1dPSzg3Y2todGdKRGRqK3VhVjhIbnJOY25YN0Nudmk5RnltbFRRZmNVbWhw?=
 =?utf-8?B?UmtjRU1WL0NGWWtmaVdrYVZVeWxXVjNXcG1qaHZ5MnNNMGhlai9YZW1GbEpQ?=
 =?utf-8?B?TWtUODJmcUE0UWVDZU9LOWw1L2lsL2NTcGE4ZnFaeGwrM2RUbUZIclQ3TWpn?=
 =?utf-8?B?RmExYWVZTlVodzB6K24waThpdVR1c09pZnVPZFhSYjBaRTlBRlIyNUVVZUxK?=
 =?utf-8?B?VGpVL3ZMZEdVb2lDanlaR1ZIM1h1a1ZRVFptYW56SVVZREl3Q04vVWZ3WnlE?=
 =?utf-8?B?OVlVMWc4SzdFTW90Y2ZIVy9JNzdzNzBQZEZzRHhFL1E1TmdZWE54ZVF0RFdh?=
 =?utf-8?B?dFNZNzNubjJRQ2VUaVRNUVBIcVlWaHhEL3AzQlBsNGV1T0FRTE45d3ZpL2Rq?=
 =?utf-8?B?bFgxdUdCdDN6dE5MN0RjSlNsWnJYQkdKZ1d2ZlIwTkVuZTkvVWF0bm1Iajkw?=
 =?utf-8?B?aWVVRHo4bVZ3QkRjSThyMXo0Vy9OL0JBQlFkSm1EVEFvc09JTnpGNnJJWnRY?=
 =?utf-8?B?bnhOU2QwR1BNaXhZcFZZdEcyU3UvaGxLWFJSSEpqRXpJUWFmMWlkZDNPYldM?=
 =?utf-8?B?dmR5UjlGYng4MjN5RjZoQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <25A8C4ACAFC5AD4EBA38B91D48E2F51A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0549f55-3df1-4aa2-f13a-08d93490ce09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 08:44:38.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbNQj+OOSFLXKVTl6wCScDwiieMYZVgcVFdXiVutugUBTRTsA8Xsx1Ho3I3OGWD7H7NO4EokvnKWOkybJ7e65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1271
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10021 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210050
X-Proofpoint-GUID: SG7QZQh8C1Kgu8ITnby1WsoyBxEbxFIC
X-Proofpoint-ORIG-GUID: SG7QZQh8C1Kgu8ITnby1WsoyBxEbxFIC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjAgSnVuIDIwMjEsIGF0IDE0OjE5LCBNYXJrIFpoYW5nIDxtYXJremhhbmdAbnZp
ZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA2LzE3LzIwMjEgMTE6NDYgUE0sIEjDpWtvbiBCdWdn
ZSB3cm90ZToNCj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+PiBJbiByZG1hX2NyZWF0ZV9xcCgpLCBhIGNvbm5lY3RlZCBRUCB3aWxs
IGJlIHRyYW5zaXRpb25lZCB0byB0aGUgSU5JVA0KPj4gc3RhdGUuDQo+PiBBZnRlcndhcmRzLCB0
aGUgUVAgd2lsbCBiZSB0cmFuc2l0aW9uZWQgdG8gdGhlIFJUUiBzdGF0ZSBieSB0aGUNCj4+IGNt
YV9tb2RpZnlfcXBfcnRyKCkgZnVuY3Rpb24uIEJ1dCB0aGlzIGZ1bmN0aW9uIHN0YXJ0cyBieSBw
ZXJmb3JtaW5nDQo+PiBhbiBpYl9tb2RpZnlfcXAoKSB0byB0aGUgSU5JVCBzdGF0ZSBhZ2Fpbiwg
YmVmb3JlIGFub3RoZXINCj4+IGliX21vZGlmeV9xcCgpIGlzIHBlcmZvcm1lZCB0byB0cmFuc2l0
aW9uIHRoZSBRUCB0byB0aGUgUlRSIHN0YXRlLg0KPj4gSGVuY2UsIHRoZXJlIGlzIG5vIG5lZWQg
dG8gdHJhbnNpdGlvbiB0aGUgUVAgdG8gdGhlIElOSVQgc3RhdGUgaW4NCj4+IHJkbWFfY3JlYXRl
X3FwKCkuDQo+IA0KPiBUaGUgY29tbWVudCBpbiBjbWFfbW9kaWZ5X3FwX3J0cigpIHNheXM6DQo+
ICAgIC8qIE5lZWQgdG8gdXBkYXRlIFFQIGF0dHJpYnV0ZXMgZnJvbSBkZWZhdWx0IHZhbHVlcy4g
Ki8NCj4gDQo+IFNvIG1heWJlIGJvdGggYXJlIG5lZWRlZD8gRS5nLiwgcXBfYXR0ci0+cXBfYWNj
ZXNzX2ZsYWdzIG1heWJlIHVwZGF0ZWQgaW4gY21faW5pdF9xcF9pbml0X2F0dHIoKT8NCg0KSSds
bCBnaXZlIHlvdSB0d28gcmVhc29ucyB3aHkgdGhhdCBpcyBub3QgdGhlIGNhc2UgOi0pDQoNCjEu
IEluIGNtX2luaXRfcXBfaW5pdF9hdHRyKCksIHdoaWNoIHNldHMgdGhlIG1hc2sgYm90aCBwbGFj
ZXMsIHRoZSBtYXNrIGlzIHNldCBoYXJkIHRvIA0KDQoJSUJfUVBfU1RBVEUgfCBJQl9RUF9BQ0NF
U1NfRkxBR1MgfCBJQl9RUF9QS0VZX0lOREVYIHwgSUJfUVBfUE9SVA0KDQpJZiB3ZSBkbyB0aGUg
b2xkIFJFU0VUIC0+IElOSVQgLT4gSU5JVCwgaXQgaXMgdGhlIGxhc3QgbW9kaWZ5X3FwIHRvIElO
SVQgd2hpY2ggd2lsbCBwZXJzaXN0LiBBbmQgdGhlcmVmb3JlLCB0aGUgdmFsdWVzIHdpbGwgYmUg
dGhlIHNhbWUgaWYgd2Ugc2tpcCBSRVNFVCAtPiBJTklULg0KDQoyLiBJIHRoaW5rIHRoZSByYXRp
b25hbGUgYmVoaW5kIG1vZGlmeWluZyB0aGUgUVAgdG8gSU5JVCBpbiByZG1hX2NyZWF0ZV9xcCgp
IHdhcyB0byBlbmFibGUgVUxQcyB0byB0d2VhayBzb21lIG9mIHRoZSB2YWx1ZXMuIEJ1dCBubyBV
TFAgY2FsbHMgbW9kaWZ5X3FwIG9uIGEgUVAgY3JlYXRlZCBieSByZG1hX2NyZWF0ZV9xcCgpLiBB
bmQgaWYgb25lIGRpZCwgdGhlIHZhbHVlcyB3b3VsZCBiZSBvdmVyd3JpdHRlbiB3aGVuIHRoZSBz
dGF0ZSB0cmFuc2l0aW9ucyB0byBSVFIuDQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQo+IA0KPj4g
U2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+
IC0tLQ0KPj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIHwgMTUgLS0tLS0tLS0tLS0t
LS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE1IGRlbGV0aW9ucygtKQ0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y21hLmMNCj4+IGluZGV4IDJiOWZmYzIuLjkzN2U0NGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbWEuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y21hLmMNCj4+IEBAIC05MjUsMTkgKzkyNSw2IEBAIHN0YXRpYyBpbnQgY21hX2luaXRfdWRfcXAo
c3RydWN0IHJkbWFfaWRfcHJpdmF0ZSAqaWRfcHJpdiwgc3RydWN0IGliX3FwICpxcCkNCj4+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4+ICB9DQo+PiAtc3RhdGljIGludCBjbWFfaW5pdF9jb25uX3Fw
KHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXYsIHN0cnVjdCBpYl9xcCAqcXApDQo+PiAt
ew0KPj4gLSAgICAgICBzdHJ1Y3QgaWJfcXBfYXR0ciBxcF9hdHRyOw0KPj4gLSAgICAgICBpbnQg
cXBfYXR0cl9tYXNrLCByZXQ7DQo+PiAtDQo+PiAtICAgICAgIHFwX2F0dHIucXBfc3RhdGUgPSBJ
Ql9RUFNfSU5JVDsNCj4+IC0gICAgICAgcmV0ID0gcmRtYV9pbml0X3FwX2F0dHIoJmlkX3ByaXYt
PmlkLCAmcXBfYXR0ciwgJnFwX2F0dHJfbWFzayk7DQo+PiAtICAgICAgIGlmIChyZXQpDQo+PiAt
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+IC0NCj4+IC0gICAgICAgcmV0dXJuIGliX21v
ZGlmeV9xcChxcCwgJnFwX2F0dHIsIHFwX2F0dHJfbWFzayk7DQo+PiAtfQ0KPj4gLQ0KPj4gIGlu
dCByZG1hX2NyZWF0ZV9xcChzdHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHN0cnVjdCBpYl9wZCAqcGQs
DQo+PiAgICAgICAgICAgICAgICAgICAgc3RydWN0IGliX3FwX2luaXRfYXR0ciAqcXBfaW5pdF9h
dHRyKQ0KPj4gIHsNCj4+IEBAIC05NjAsOCArOTQ3LDYgQEAgaW50IHJkbWFfY3JlYXRlX3FwKHN0
cnVjdCByZG1hX2NtX2lkICppZCwgc3RydWN0IGliX3BkICpwZCwNCj4+ICAgICAgICAgaWYgKGlk
LT5xcF90eXBlID09IElCX1FQVF9VRCkNCj4+ICAgICAgICAgICAgICAgICByZXQgPSBjbWFfaW5p
dF91ZF9xcChpZF9wcml2LCBxcCk7DQo+PiAtICAgICAgIGVsc2UNCj4+IC0gICAgICAgICAgICAg
ICByZXQgPSBjbWFfaW5pdF9jb25uX3FwKGlkX3ByaXYsIHFwKTsNCj4+ICAgICAgICAgaWYgKHJl
dCkNCj4+ICAgICAgICAgICAgICAgICBnb3RvIG91dF9kZXN0cm95Ow0KPj4gLS0NCj4+IDEuOC4z
LjENCj4gDQoNCg==
