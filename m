Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0992035E0FD
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhDMOJ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 10:09:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhDMOJ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 10:09:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DE7njG014980;
        Tue, 13 Apr 2021 14:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5Zwkrt0QGGzt1KWEi9J6GwwYCU4Ru2uoSx3wf8xeQN8=;
 b=oUwCPRFhl8djXXPr3wOt0CX7wq48a1Fs1y8Hx82Zp07UdoJJn8DMqVH+bUEB3Ho8VAGg
 UhV/On6RfK9BNqPiTXjkZROlCLRjXQfvLKfSuuj5SyULrAyr/YDuccscyd12Ury9F+on
 9PDX9XGfn0axoyVZPaJWm6maI9YItEV9oC94XAajf2H3mmjHKDTp3QuXzYDrTlNNfOfn
 Mks/doX9X7jtaVM9/owZyDHIBPz0TUq9Ml43/A8F+dhzkUAGPyGcDVTxBQghzeXUiIot
 gWeEqeYHHaj/LrpBdZQTI9eRnEH67tQ1GQrJTGWw/132GDGC+BOz7Uih9FA7OZFhV7dj 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erf7fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:09:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DE7lK3023251;
        Tue, 13 Apr 2021 14:09:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by aserp3020.oracle.com with ESMTP id 37unwyu71x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqeB4vjXs6mwUcyKfNxo9ujQKMLyohGUH1zbT/Zcx4/dez78Dj/hOTaOPZ983HXevstHUjOPuebT85hXA2ON/B8uWGC0zSbamgGUkj1wlhJXnizmB88kjF1RxG0H2EfSXbfAAp6H6IJm84RJxFCoJvbbD2lvSMjzoNmJLBTVggvjIsDYCO+mUVwncGVmDn1GLDJylTgoSRFYiMs+u97XKgSb0wNbGq3CyDGKN5509RP3VpDu5HaIc9OAlDwiRfY2J9Wgm1XKL+MZLBK5zyxVR30ZYu8C/UYnpjm31qIguTC5H5OiHE/rCXUV04ldR2CUy+IwPehF9AAmvt4uSZMpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zwkrt0QGGzt1KWEi9J6GwwYCU4Ru2uoSx3wf8xeQN8=;
 b=EzzLBG560gBMqUFuCpY9xIDD0eFdYc1ZeraLv6KbpKfUWiXmHUIef/K5oAmMIaMpUkaHonFEVVWkgi80mE2AuZIogZOvFvfsAd6Khn7FGz6hXdJKX9FNFXvrJ1yF445S+cC4WYqL85nEEgKhKf6NmGPdlbNnx0q672nwFXpVjVadMqD4RfYLYErRiwt1RZYrJEbsw1VLFNkIP38jObnP+eU53CMP8K22J5CJK14lGDz16m1aDljbsuX8wicLf2ip4TwJdjxxea/ofC6GmN+ghb6CvUfLyMBsJ8mw64Zvv7tNXGbDrIBbvkTso7e4tKwCt2Y0FeiboJ29JrPM+vnBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zwkrt0QGGzt1KWEi9J6GwwYCU4Ru2uoSx3wf8xeQN8=;
 b=UcYL1HpNCJEb25AmdClSw+LBFxAbFEIUkI8bLe8Jn8ePstycQT+AftnZX2pUNB5lBA+zk9o8rtUiDnb4AZl+pFuKJRrIpaqOtfVPmMMQcs8sOatQB7BgKHmy4bNkXaMhTB18wfrwhGL04tEOx6vdx5F5dPK71UxI53AvCt8Alug=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2215.namprd10.prod.outlook.com (2603:10b6:910:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 14:09:29 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4020.022; Tue, 13 Apr
 2021 14:09:29 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Hao Sun <sunhao.th@gmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Thread-Topic: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Thread-Index: AQHXMBZIafaMKw9Gbk+37nMf6bUO+aqycySAgAACcYCAAAChAIAABtgA
Date:   Tue, 13 Apr 2021 14:09:29 +0000
Message-ID: <FD5C91B5-8E07-4CB0-A08B-5E0D1E2A3B04@oracle.com>
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca>
 <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
 <20210413134458.GI227011@ziepe.ca>
In-Reply-To: <20210413134458.GI227011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bed59fc-0556-4f14-6278-08d8fe85c0c4
x-ms-traffictypediagnostic: CY4PR1001MB2215:
x-microsoft-antispam-prvs: <CY4PR1001MB2215A33BB472EDB72B0A0BE0FD4F9@CY4PR1001MB2215.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8zEVqqTmJu0AXfxCfmnstnzcItzsA1stVzquJ5yd9wasQjUSeWyT0wD3VeZIEXz+6A/TmK5AcEyo0MpzfBic+M8IBPsykDIF8VbZI/jny6hHDERccaJXEn1H8x0CaA78OpFzOWyDHAj10uVzIpVkBE5tuO4/hgM8xxcV7wKRZO3v6j041pgslDQPTWDoYcDGlGnqS8jFw2zgSXDh5Mg7dVgt7MQpmj9caeEHA/HRNVffwx/LypTjA0VVwXR5YyrIqT4qe0DyZLoxGoKT/MzDNS5OrX45qT4L+8aGpXskLeLb2cKVnBCnkNWCCyL1ZrYMwj/ZCzKQSmlJIeUKstIjhVI+mq2rI39h7MZ7oUsQ2mWZpGW1Zva3z5/aBqGXcPuKJIbwwE3C2Y1MN+ORkGrOLCKFp3HiroKRSpvV7SFi1daIlJqMDOUEg+y375v2r3KStklGlb0J04QZfZUbbeXHwyWaG2cw1qYgeByM26CbOhBqczFdgwmt5gxySKW3YEO3jhXZHzgPGWXbmnlizZZ/URddveIvJbMX4qypr2e4/MLX8GVQG9Ky1tTFzJWViK08fdyiqDbTtAIfaa7rHHssrXLROPN6DnYYRj83xk0FIVsRFWUDoSamUzEzwhFEhTHLNE9rFyaTNJ5VvU84d2SK/gOzd0LuQ1ELZ22+NBcpPDyojWh12tsqaSkAalPIGr1tQHBDULtI+hyZdwEOU19rHshBLeNol2aI7ZShyiTwZf6zSEPJAeaLEBnfW8iw3AK/ijlbApr7MGk4Qrhf2+5Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(26005)(83380400001)(966005)(186003)(478600001)(2616005)(8936002)(66446008)(38100700002)(66556008)(44832011)(66946007)(66476007)(53546011)(4326008)(2906002)(6512007)(64756008)(6506007)(91956017)(71200400001)(8676002)(6916009)(5660300002)(36756003)(76116006)(316002)(54906003)(6486002)(86362001)(122000001)(33656002)(99710200001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHcrQUJjUTFEUkFnaDZ0K2YwektzYVdtd3oxWEk2OHRGSlcwQUpKbWJWRmZy?=
 =?utf-8?B?NmdpaWpwWXNqZFdzajBwNTcrQVJMblBoNmFtdXgzWkVVcmpkRnY5eEdjRnZr?=
 =?utf-8?B?cFVwY3hzYnByYXJCeGM4SVJ2aGZUL2lzUGpmQWs3V1hJdmlKdjRYME5ZTTlJ?=
 =?utf-8?B?OWM2dHFSTDlickl2aHd2MWQ0SUdvcGZUOGt4ZFBPQ3FPK1ZKV09LREl6eFlJ?=
 =?utf-8?B?RXBqT21NOHRoS0xvd2E4UldqNFlQaEV4VG14cy9TTFNBbGdKUVBtUmNDMHY2?=
 =?utf-8?B?Vjk1Q09xMWJ6Z3NVTHdiaHFyaEdHYzcwaWdsTnFxK0Rhdmw0bmxtNU9JUDNm?=
 =?utf-8?B?QnpaUjYrMkpuRTFBaW9LeDF1Q2RmSk85NjJ4cWVwUkhkOG5YUm9CbC8zcDA0?=
 =?utf-8?B?Sm9acWlJMkNENkFFMXd4K3g4Yi9WdlNtN2VUWEtlSktnSU8yUFozOWs1NVd6?=
 =?utf-8?B?TTVTdm1FOHFwUXlEUG5MTGhLVnNxZmUrVko3dU1PS0ttY0hJV1JLb2ExVVA0?=
 =?utf-8?B?VU9UZTZ3RnRQclRHK0dwYW5TWE1sNzNsdmhtNWx1a1ZxYWFNb3lsSDVJUHBy?=
 =?utf-8?B?eEl0SWJ1TzgyQitqTUtwemhGVXBjejdwUkdtZVZvRWtIelZQYXVkbzhDaGQ4?=
 =?utf-8?B?ZVBzbTY0c3N3dDJsNUZhbUdiNkpMY2pZZTdsa1FhT2Q4b3RlQVl0RExSWlc2?=
 =?utf-8?B?NmFEdlNuQ1JMam5qbUNKbXEvUnR1SlBvT3RSTHJYaEhMZmxuYTNFdG9hdk1B?=
 =?utf-8?B?ckR3MTBLdjYvTmV2VUwvSVR6YWtjbVdoK2FJam16cWJtLzUzT3dNNTdiUEZk?=
 =?utf-8?B?VGQwOE1pc3UwMzgrOVhFK2gzYXN4cS9nQ1RxR3lvRThXMFJkOVZYZmNvL2wr?=
 =?utf-8?B?bXZzZXF4QVFiRHFxRGRwWE82WWFQOWhJVWZjWnBtdjlnTXJkeHhJcFZNK0VE?=
 =?utf-8?B?Z2hlL0FuanlRVjErMVR2S2Y0UnIwK2lONXA3ZG5UVGZJSUJicDQ4dmVYV2hx?=
 =?utf-8?B?YmZyV3ZiTHBCUlJMTEYyU1l3RzJMN1g5NDB6NVlMZGNJR0gzcEp5UURPYnFH?=
 =?utf-8?B?TmxDeGVGMDc4OVRLTnpTTjh2WENBQWJvOFpmdVJkSzk2VzRIRyswL1dVempM?=
 =?utf-8?B?WFhpSzZxV1YwM3ZyVThwblQ5UjhhTFAzajgzVGVTYzhIK1czS3NCekNzWGtV?=
 =?utf-8?B?aHpCbzczZEwyUVgySUpCUHFhWEp2ei96SFphYWNrVVZacVJuNmZJMTlPbmhh?=
 =?utf-8?B?dDVTQ2ZKM090UW5hYjc2OEFXMWd5TjVEV2Q3Z2Z1YmtUOHF3UWl5SFk4MGFl?=
 =?utf-8?B?S0RyelRuNFlzTW9waGNJbEFQT1FlZXl2UzVOT3F1Y3RsUlgxSXlqSkNKbElx?=
 =?utf-8?B?eUdnamhoRDMzclJVdm9kL2ltb1ROck5HSVRxZXhZWTk5Q3NmcTdEUHl1MXg2?=
 =?utf-8?B?YWx5NDIvVXBmVXRHUEdldm1HUlBBUTliYk1ZSGtWQ1NnUGFSY0lPWUpYNWEv?=
 =?utf-8?B?cGJ4U0xUdVE1dVRZSG45K3NPUXFVUEhDOC9xMEdTMzY3aEJyQm1iTFRXRWVM?=
 =?utf-8?B?dm0xK1Zza1VTVkprZ3lBMWh2bzI2NFArR1kyQjdaTUxlVFFRYjlmMG91TlZ0?=
 =?utf-8?B?cFF5bzhFQ2xraVBUd3B5VGVCOGp5cnpVTWhNWDhYVXhQZW1mMlMvQ05BNmpF?=
 =?utf-8?B?VThFNVlBQXhmQXZ5bnQvUVpSQ0pxbDhRQUFLN2VLWjR0WDRVN0VjM052M3Fu?=
 =?utf-8?B?TDBuUUV3anBSbmR2MVpYcVdZZG9aTXRXanYrZ1FBcjdoLzd3T0FVS1FQNGxI?=
 =?utf-8?B?VDhFU1pBN21HbE8xdVhEdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C41A0D9D99D8264C9CBAE9DCED1F0201@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bed59fc-0556-4f14-6278-08d8fe85c0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 14:09:29.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy8TML+Q4KJjBGKkDogWYtMj3fooWyLKdIb+lPfvn42nr3XfiKDUs0NsChf0XxbPAgfYFgFNcerkLLsgVyydwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2215
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130099
X-Proofpoint-ORIG-GUID: JDI4sh8U2xgdNMA5GM7m8arjxKyLiCY5
X-Proofpoint-GUID: JDI4sh8U2xgdNMA5GM7m8arjxKyLiCY5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130100
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgQXByIDIwMjEsIGF0IDE1OjQ0LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCAwOTo0Mjo0M1BNICsw
ODAwLCBIYW8gU3VuIHdyb3RlOg0KPj4gSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IOS6
jjIwMjHlubQ05pyIMTPml6Xlkajkuowg5LiL5Y2IOTozNOWGmemBk++8mg0KPj4+IA0KPj4+IE9u
IFR1ZSwgQXByIDEzLCAyMDIxIGF0IDExOjM2OjQxQU0gKzA4MDAsIEhhbyBTdW4gd3JvdGU6DQo+
Pj4+IEhpDQo+Pj4+IA0KPj4+PiBXaGVuIHVzaW5nIEhlYWxlcihodHRwczovL2dpdGh1Yi5jb20v
U3VuSGFvLTAvaGVhbGVyL3RyZWUvZGV2KSB0byBmdXp6DQo+Pj4+IHRoZSBMaW51eCBrZXJuZWws
IEkgZm91bmQgdHdvIHVzZS1hZnRlci1mcmVlIGJ1Z3Mgd2hpY2ggaGF2ZSBiZWVuDQo+Pj4+IHJl
cG9ydGVkIGEgbG9uZyB0aW1lIGFnbyBieSBTeXpib3QuDQo+Pj4+IEFsdGhvdWdoIHRoZSBjb3Jy
ZXNwb25kaW5nIHBhdGNoZXMgaGF2ZSBiZWVuIG1lcmdlZCBpbnRvIHVwc3RyZWFtLA0KPj4+PiB0
aGVzZSB0d28gYnVncyBjYW4gc3RpbGwgYmUgdHJpZ2dlcmVkIGVhc2lseS4NCj4+Pj4gVGhlIG9y
aWdpbmFsIGluZm9ybWF0aW9uIGFib3V0IFN5emJvdCByZXBvcnQgY2FuIGJlIGZvdW5kIGhlcmU6
DQo+Pj4+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9pZD04ZGMwYmNkOWRkNmVj
OTE1YmExMGIzMzU0NzQwZWI0MjA4ODRhY2FhDQo+Pj4+IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL2J1Zz9pZD05NWY4OWI4ZmI5ZmRjNDJlMjhhZDU4NmU2NTdmZWEwNzRlNGU3MTliDQo+
Pj4gDQo+Pj4gVGhlbiB3aHkgaGFzbid0IHN5emJvdCBzZWVuIHRoaXMgaW4gYSB5ZWFyJ3MgdGlt
ZT8gU2VlbXMgc3RyYW5nZQ0KPj4+IA0KPj4gDQo+PiBTZWVtcyBzdHJhbmdlIHRvIG1lIHRvbywg
YnV0IHRoZSBmYWN0IGlzIHRoYXQgdGhlIHJlcHJvZHVjdGlvbiBwcm9ncmFtDQo+PiBpbiBhdHRh
Y2htZW50IGNhbiB0cmlnZ2VyIHRoZXNlIHR3byBidWdzIHF1aWNrbHkuDQo+IA0KPiBEbyB5b3Ug
aGF2ZSB0aGlzIGluIHRoZSBDIGZvcm1hdD8NCg0KSG93IGNhbiBhIGNvbW1pdCBjaGFuZ2luZyBh
cmNoIG02OGsgcHJvdm9rZSBhIGJ1ZyB3aGVuIHJ1bm5pbmcgb24geDg2XzY0Pw0KDQoNCkjDpWtv
bg0KDQo+IA0KPiBKYXNvbg0KDQo=
