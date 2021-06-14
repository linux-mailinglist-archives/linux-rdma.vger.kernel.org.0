Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D33A6BC9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhFNQbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 12:31:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhFNQbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Jun 2021 12:31:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EGKwFr100220;
        Mon, 14 Jun 2021 16:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eyH1Qj1ErbSsZ7N/Kr6GBGK/fwUidt30lqCd8txJnoU=;
 b=t1ZhiRjDbt3ufbiqx0b+/P74Nl3Cpp3tHHV3YIO3ftOzfI9GkbHAmEKqw+RPUgSSjymz
 R2Z541cdnu1DVhgKz7Cc3Sio4tj9QWPg3nbbk3mONZBmUUIZgQ2ZOFR915soI2KX2mS5
 Unse1ux9xWl3nbHT5sgop1unsJICWqSGzdj1U8y/JsYSVdc4R4l8Wm4FxAZIkZq2uGF+
 LwQN9XpzzIJAMT9+vLSNkV1mN64P9XXKUSGz9bU7Swr2lcn9jgz81Sm6lma25CyVo4kj
 KkqlS+AdEcZ0lvXMBVys84ZE+kCdK/X3gkcU+Na9dMXuhTSP96Jj6m8bJ4u2wbAEE+C6 Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 394mbsbxwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 16:29:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EGEmeb004095;
        Mon, 14 Jun 2021 16:29:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by userp3030.oracle.com with ESMTP id 394j1tbdjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 16:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvcVk9ILCBK6UNQT8LitUo6O+MoE41gjvwVNkX125509VP6FNDbaOjGMkPfhlU63njjLuPnpzmzXUdtdstJMzWyXSINlQTusGYyq5+0c6sRBqD5TdT6tXL6uKcK9XlaCk9R8MpT879rGhiWWdf04fM7KwRpxN+28Zjze2UJViKVBU0JA2BZYwwX/NS2gQMu/5AqMN/dDstpI0n8fGFX4+KnmokI7AP0y3IfxfTpb0oxYUF7VttMPcHiXIhpKiNxcpJBavEW6+vrkSmtyneAN7iwQs4LypuW2GFXmobrfhTaWn+a97cU+ZiUwlQwOWil7H6mqLh2HEfnzfXlMY7TgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyH1Qj1ErbSsZ7N/Kr6GBGK/fwUidt30lqCd8txJnoU=;
 b=nGTBQJ9xNNdMNHFlPfI9S8lDtGAWdOJ9pfs5AmVQuXL/iYLnR4XSjKgXVu+SU93+1H8v/IwnF+l2T6sVTdyrvxxayRaxgw+RJLFnNdJR7BncqA56N45Wi7r9E61Hv9uCQ0h1TuxNeVdtpCBpAH7BZdqUeaL5sHteMht6jv8WtQW4ufH+sXt2boVBdnQGRvtdIqb86T4D+vCHBtPnhdB9KgX7Cj4I9WhrJSXAxQBTYRt+IJNhGXNl/MAlPFVVJrYeiKdo6HJS5XBpIOQEsNTZPPBTH/JKyvQl68FVAhgoYr8DKAyY4ouMkb+rZtt00CofsmZNoVUNDRn8DNGw1ngQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyH1Qj1ErbSsZ7N/Kr6GBGK/fwUidt30lqCd8txJnoU=;
 b=FaVFDJbRXI8nUFY96bnT5DBC0jdpbSzCVHcBN0/u8a+pp7iij/j/Sp/r7VhOSpMsf0JOV52TZgBgWJWGOKsatGYxRNWWEPRASTDQgvkhuQy36cVoDbnaKjyUpzwHDWitggv/RQnPQ+PSyYYnF+fjSEG7+GhfnEkVua1RyuSHhBM=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB2008.namprd10.prod.outlook.com (2603:10b6:903:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Mon, 14 Jun
 2021 16:29:09 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 16:29:09 +0000
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
Thread-Index: AQHXXPQdh88l+xVVXkWdtTnBVCg426sLWyGAgAAN5YCAABS+gIAHZCwAgABBEgCAAJfiAA==
Date:   Mon, 14 Jun 2021 16:29:09 +0000
Message-ID: <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com> <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal> <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
 <YMcEbBrDyDgmYEPu@unreal>
In-Reply-To: <YMcEbBrDyDgmYEPu@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc876f9-c553-40ff-10e0-08d92f518942
x-ms-traffictypediagnostic: CY4PR10MB2008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB20085F9D0C3D1104D852DF83FD319@CY4PR10MB2008.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELRNEg1fyNSnL2FaK7rS6iGqzYBXTdfj0cRhQ9HDCYKHyPlgEpn3KfoVuWlZ6T3EzSXWgZi38Ix/DJt//28YmKkiaziKTARfojtTYaix0mPSBXZIMkmrrvLKy+oVelbIwn/PaTwjbx0Xi1lBWfDUV4+q6didjU+8E05OwiYX0KRdlBS/oqm9AM4WQaG53zbHJJtLvXBJ8WeWpFu9Z7UQimBZ71dSvT/sVCtECjIsphS0XKbsSlyDONiVSkm+kPqO4zkIhsYTzuHhuli0KtATIWbRlb0pOYcoXaYd17oMM7D7EcZRrUaB/PP5uZFdPtfDbzYxKPHWGh0s6sL+p2gm183ECmDCfanHixLJ3Kdanh87GRdq/mMjrkTrwFEvSO7rZLWdfd3fLOfIBHvlQI0VAIIQ+1MhDNJ1mIzZQsZSNnbcvh5NfWOT4I86GwV5vDA/Tbp9G4jU2E7RhxA22NKY23FL8i/wuQpVFqdOeQUTjP7E0peDalCkzb1YCUAQobzwYcchNmL7aUbjibulLb9LlwtwQ51rYXGor7N/dREXUCW7BQrSoKq2bJ7r0GvBj/7UQ+qLVG7euLw+LYj9WiktL8tMSYsL50WHPvOcaQg3M3hMsp+fgYYNz/sSSnpCIcl6CAJfKQ9LcHaCE43FGRfgKNvrOJwNnAP8bWIyKZUQGPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(2906002)(66574015)(71200400001)(91956017)(76116006)(6506007)(54906003)(6512007)(66446008)(66556008)(6486002)(64756008)(316002)(8676002)(8936002)(83380400001)(53546011)(66476007)(6916009)(122000001)(33656002)(4326008)(478600001)(38100700002)(44832011)(5660300002)(66946007)(2616005)(36756003)(186003)(86362001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGY3MlNiNm40RGJHZGdSZGFZNUhYNjdRdjZMVTVhZENiTjk1RUw4eGlSbk9I?=
 =?utf-8?B?WVVKMGdYZkRRZlFFMGhzVGxFTUgzTjFtNXlEc2ZzK0IrM1BreTBFYkRuVUFR?=
 =?utf-8?B?clR5cVV5MFpFV3Fva0pndHlhNm5BaU9HbHVrN1p5NXdSTnNYWW1LSUl1NGtm?=
 =?utf-8?B?dGNQTUNJaGZySFlvczNZT0ZuQ3VIa1N6ZTRwdWEyOFcwalVkQlpaWGYzYTJz?=
 =?utf-8?B?WFlpTHp1YzRvek9oU2xXR3FldmRDdnd2V2lFdzR5NTUwQWQ1V0xlUFNYOVk3?=
 =?utf-8?B?SkR5cFJzd2FtV0l1b3NQOW9OWVBIR2o4aGplSjRDbDJRbi92cytNdmhSL2ts?=
 =?utf-8?B?OHQ3c0hYelhQR3JYc01aZW4xMnFXbFZWcmJGTlpDUlNOSzJpaytFWjZqazI3?=
 =?utf-8?B?cWg5Y2JUZWhHZGx3bEx2MHM4dEFDQlVwNkN6c3dJcU1TRXE5dmxRYlBGdG04?=
 =?utf-8?B?TUkxZ0x3cjJpaHBmUkxNNWtBdUZwR3JRVklTYm5pSWY5S2FkcGJ4eStaVVVP?=
 =?utf-8?B?TWRPcjY3MGdZWENOeG5QUkdrSktPc3ZoZ1VmZmJIMnpnVlN5MFFtNXZ2UmN1?=
 =?utf-8?B?V3RRTkJsUW9zKzV0SGZrNGpKZEkxaGMwS3RwMHJRZjdXQ1h6dW9ZcEJoN0xu?=
 =?utf-8?B?dWd1U2NNcHNoTFQvRTJKcEx1Y3UyeFQxRWRKWFljSUR0dDNzUzFWREY5eHdD?=
 =?utf-8?B?a01GVkVvc0lPRGVWQ3c3MU14Q0haQm9oaUdGQ0RiQWp6Mm1MZFFERkJMcW04?=
 =?utf-8?B?ZkorQVRkOTB1UnI1ZXpHZmZUNDZudFJKVTFlNkxKV0pMUEd4MndzdWw3OEpl?=
 =?utf-8?B?dVhQbDVuYVhlRVZQVS9ZVWZrWmZkWHhUMjRReWFoWDhUeXUyVGZKWnM5S2N0?=
 =?utf-8?B?YjdoUkc3bk1uRTdxNHVZMXZMbTg2b1R6NGM0Y2ZpKy9lRnB0U2xSV25SSzNB?=
 =?utf-8?B?cnFSOGYvbmNuZitXU0Zadng3UTg4alhtSnY4MkRSNm1IQWM2SzhXYjlqcTVx?=
 =?utf-8?B?TUdCY0dJYVVsaGNaY0dHc2VveUQ3SVhnd1hrOHBkWGNNL09KZzMycFRrMUtx?=
 =?utf-8?B?eTUvVlZnUHhNSy9LdHpmZlhUdlZEeGFZT3FHS0xPeVRTYUpUclZBL0c2dk5l?=
 =?utf-8?B?QzJOdW8vTEdITnVTS0Z0ejJ2c2F1R0lib1NPTVRNVEdDMDIydVZxQ0VTSWty?=
 =?utf-8?B?TFUyTjZxNjJRWFYveldPclZlZzhDUGVRRlVHZTdLVWUwZ0IwbkNCMk9uQ0Zs?=
 =?utf-8?B?K29DZ2VIZ0t6ZC9FZjYyVWdaclNNK25wb1Vlc0FRZm01OEwyQkFEUjZWNit6?=
 =?utf-8?B?SHVSTjYyemJzSk1Tc0gzS3MwdHFLT2hzZ3d4UmpUTXNMMEpveE40bnhWK0Zw?=
 =?utf-8?B?OUhBd2FOV2V5bXdDdkN3cFlXa1EyNTNrU2RZZG1RRmJ5NlNpNEtOVWV6VFdQ?=
 =?utf-8?B?b0VzYlV3bVY2UElCbEhCV2xGK1YwQlNEc1Q5eURZUVB6TkVSc3F5a0ZGc1Jj?=
 =?utf-8?B?d2VNQXYzdG8xcTRhc1p4cHZuZ2JkTFZQNmE2SlhVVjVMY3lFWktCN09ONTRy?=
 =?utf-8?B?dGFPQ3RzKzR0OUp1RFV4cng0M3ZYQUI3TVczQzUrUXc0dTNnOGxrZHhtd3FC?=
 =?utf-8?B?Q1hzWWRnUFg1WkMxRWNNV21ERHBubkkrWVlNSkExTlE5M1ozK0FwQkZnNURL?=
 =?utf-8?B?T3VmZzd3MXJaRDFoUCtiL21udkJFMFpvQ3k5SnlDSnk4L3U3c3J5T1lvTmpF?=
 =?utf-8?B?NTMrSm1nWjg3Y3Bzemh0bi9RRE9EYXU0Z3FacEp4dW1lTUo1eG5pZE55Rkl5?=
 =?utf-8?B?UkdpWVlMdUFieXNtV1Fydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4C20D08A415274F88B73E2DFDF75718@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc876f9-c553-40ff-10e0-08d92f518942
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 16:29:09.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3X2G7CoRlZ9x3AETWlHMlyCgIRveL0SD3c83CcRJ73RLkUfK6FDNp1fd7DcHs5RHSb++P2WglGwU2oPt79eMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB2008
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140104
X-Proofpoint-ORIG-GUID: 0NtYVMBKDe5savc26oX8U1z2zuPtGQNi
X-Proofpoint-GUID: 0NtYVMBKDe5savc26oX8U1z2zuPtGQNi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140104
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTQgSnVuIDIwMjEsIGF0IDA5OjI1LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAxNCwgMjAyMSBhdCAwMzozMjozOUFN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDkgSnVuIDIwMjEs
IGF0IDEyOjQwLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMDk6MjY6MDNBTSArMDAwMCwgQW5hbmQgS2hv
amUgd3JvdGU6DQo+Pj4+IEhpIExlb24sDQo+Pj4gDQo+Pj4gUGxlYXNlIGRvbid0IGRvIHRvcC1w
b3N0aW5nLg0KPj4+IA0KPj4+IA0KPj4+PiANCj4+Pj4gVGhlIHNldF9iaXQoKS9jbGVhcl9iaXQo
KSBhbmQgZW51bSBpYl9wb3J0X2RhdGFfZmxhZ3MgIGhhcyBiZWVuIGFkZGVkIGFzIGEgZGV2aWNl
IHRoYXQgY2FuIGJlIHVzZWQgZm9yIGZ1dHVyZSBlbmhhbmNlbWVudHMuIA0KPj4+PiBBbHNvLCB1
c2FnZSBvZiBzZXRfYml0KCkvY2xlYXJfYml0KCkgZW5zdXJlcyB0aGUgb3BlcmF0aW9ucyBvbiB0
aGlzIGJpdCBpcyBhdG9taWMuDQo+Pj4gDQo+Pj4gVGhlIGJpdGZpZWxkIHZhcmlhYmxlcyBhcmUg
YmV0dGVyIHN1aXQgdGhpcyB1c2UgY2FzZS4NCj4+PiBMZXQncyBkb24ndCBvdmVyY29tcGxpY2F0
ZSBjb2RlIHdpdGhvdXQgdGhlIHJlYXNvbi4NCj4+IA0KPj4gVGhlIHByb2JsZW0gaXMgYWx3YXlz
IHRoYXQgcGVvcGxlIHRlbmQgdG8gYnVpbGQgb24gd2hhdCdzIGluIHRoZXJlLiBGb3IgZXhhbXBs
ZSwgbG9vayBhdCB0aGUgYml0ZmllbGRzIGluIHJkbWFfaWRfcHJpdmF0ZSwgdG9zX3NldCwgIHRp
bWVvdXRfc2V0LCBhbmQgbWluX3Jucl90aW1lcl9zZXQuDQo+PiANCj4+IFdoYXQgZG8geW91IHRo
aW5rIHdpbGwgaGFwcGVuIHdoZW4sIGxldCdzIHNheSwgcmRtYV9zZXRfc2VydmljZV90eXBlKCkg
YW5kIHJkbWFfc2V0X2Fja190aW1lb3V0KCkgYXJlIGNhbGxlZCBpbiBjbG9zZSBwcm94aW1pdHkg
aW4gdGltZT8gVGhlcmUgaXMgbm8gbG9ja2luZywgYW5kIHRoZSBSTVcgd2lsbCBmYWlsIGludGVy
bWl0dGVudGx5Lg0KPiANCj4gV2UgYXJlIHRhbGtpbmcgYWJvdXQgZGV2aWNlIGluaXRpYWxpemF0
aW9uIGZsb3cgdGhhdCBzaG91bGRuJ3QgYmUNCj4gcGVyZm9ybWVkIGluIHBhcmFsbGVsIHRvIGFu
b3RoZXIgaW5pdGlhbGl6YXRpb24gb2Ygc2FtZSBkZXZpY2UsIHNvIHRoZQ0KPiBjb21wYXJpc29u
IHRvIHJkbWEtY20gaXMgbm90IHZhbGlkIGhlcmUuDQoNCkkgY2FuIGFncmVlIHRvIHRoYXQuIEFu
ZCBpdCBpcyBwcm9iYWJseSBub3Qgd29ydGh3aGlsZSB0byBmaXggdGhlIGJpdC1maWVsZHMgaW4g
cmRtYV9pZF9wcml2YXRlPw0KDQoNClRoeHMsIEjDpWtvbg0KDQo=
