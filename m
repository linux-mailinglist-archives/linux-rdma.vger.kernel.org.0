Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497313AEBDF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUPBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:01:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62978 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhFUPBJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:01:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LEvI9s007530;
        Mon, 21 Jun 2021 14:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=t0t4krLNa0x2gIriH+fz0ztR01N3pUE0CUftyEVAyZ4=;
 b=z/cSKRrq9OygjTcVz4+aUUugjpaMIPqJP7jpczOh8Y3HgcWV2sMt/ynhzKY1kGkx8swA
 C/YPzVq9dIE6Duw+YOg1jnblxmk4Q8U5vY+doXNq5T2DMHGw4f6oLzc2/66D5AZUOj9D
 ey1yvFIf1I87v+DRdGRDd0EFhiw8quSxAUpo2gunoB2kc/EhvQUYCo/qrc83wVszkDUh
 ccxeFr2LeyX4BSmwbN30Qc55FWaYbuH0x3QHF/7z+4XNRgSgiS9oFoZI4ubCdUC1JcXT
 weKdClPtVPJpY1T+/gTgtgN26Yl+ny2Zx9Qs8iTMdHNGqY2igfvywLpDRdDqpLXqffuX iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvrr53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 14:58:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LEt9da140942;
        Mon, 21 Jun 2021 14:58:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3995puq2yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 14:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISYWZWZUFxoCKEkDz1tbvBPbSuUMEVO1hgBzW6GdGeM7s3I1XOaANT/RAY/NAko395wyfmfeeE6RQzGr1bD/INFFGK8XWle95E3RAVjTjJRf0jke36y9qlDOn5hhr7UqRBSHssXABkpzWCOnch969Rk8c1XL7FJaFQYG4CTuqybLCAV4IbzRZeMGzGXgtqhdAt7hXIQ0mI/W4vkYo32Ozglrm23Ry3W1PftBYOcGPyur2sqNuo2mSc95PJ9rn9F7Mq/TfBKkaVsixtKo0tGS8XyQm2MhIlx/RYwbHcmNifYWE4JkpXL0X6pYzzAhQ5u/+zXC0NPBebthS2G6UCB4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0t4krLNa0x2gIriH+fz0ztR01N3pUE0CUftyEVAyZ4=;
 b=Nm/KeTqCTGT71AaEbaI8E2owEJfmOWagnpjTyV+dac7JtDWhBJQMOsVhfwQBL6AOyKv8xb8/9Ym4HVWmJ+tdcKlRFjILo60NEREc2MW0rSVU01f1+CBJtuQD8nl/BekEd6FVc+lWMtDnTpdAnmS17O8s7sVug5OHS9CUXTQ1p73FXtg45S/cbNzaP+joO7Kkv3zeE0rDXBwQ6L+btd/zxnnK/Kf7RfOB40oBmzDIAiWLcKBcqP3WgvAubZ+TsE591SJvo/0KQWDAxqcfZ7vmPXeO7JkdgM9BwYxdehMuhTq6OQrf0g1qyXoqUStiH5zd2DVeNF/WloszXL2+gI6R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0t4krLNa0x2gIriH+fz0ztR01N3pUE0CUftyEVAyZ4=;
 b=jbLCpH5bbY5zwbPGORSy+Zrq3zI2z7/BTYq272zRq2xyeYC2+WmgvJ9r3/G32CmGTyaLVZizopd3F2zXzs9wIB0pZ8gLBL7jSxpK2Mk8Z4ox21CVCOLa3nfP5gXmfvhUVhr3X3jyfrQWTn80QXhnF1fuBfvde/rZGcN6tGJD5nU=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1335.namprd10.prod.outlook.com (2603:10b6:903:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 14:58:46 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 14:58:46 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXY3iqQ+lwecvXsUKE5x7HSp6gYKseEhgAgAAToQCAABoOgIAADqSAgABAsgCAAAXOgA==
Date:   Mon, 21 Jun 2021 14:58:46 +0000
Message-ID: <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal> <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal> <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
In-Reply-To: <20210621143758.GP1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a94a250-0511-48b7-6de3-08d934c51210
x-ms-traffictypediagnostic: CY4PR10MB1335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1335B0F76AB5818719E4AF92FD0A9@CY4PR10MB1335.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+Vv6yAn639ufuSk8AjE0NViqKpwGc1IM9R+JOrmxEjq1MlqTC7U61inKsaor6m5Hc/GcnKbKClWR+ZYe7EeZSDqoybf16+SEqX3Um6wDz2PUzjUh2rGXDJrEKphNVNWgBBifyvbD+SWa0Na+YXQ6eodgYVLOQexiaGzL4m474txrrO+i+4rZFEsd2g2HZ1D3cxi2WwmdVThAcDSQxC16d2kok5GqTjBmXikhdrGZ31soCkl4TjtNXGFKuAYYFRjycSTbqX6ThCr7TF+9LOeuKOf8y7hiagTndJ3YcPbKP9jRdlsoQhJfSOjcENHxBAe1A4SLCsxV4YZESjxjp5YxMV9TIxR4r2BeAUSS2vnL+NoIYyqwSLcPs0CjOJQozJmkoyDk1YQtSpXwuj4JZ6WA2GkDLJ4CS0qyY5//RSovs8Mc2BFesClUjd3K3U2mtAxVhYpT4G7e0PqauWWMFmFcPjSe6Qhum76lpQP3y8FyvWRpNDsbpQ7G8ljSbgo9hLSXAy0BCD3o8mkKWvIudU+MHJEi6AH/W1sZZ/suxabsncvpBcs2Dg1Aq3XFNlUpK/6gCBMxcSv+HnNx0VtmuIQZZrAi2R+bvobPyyOAOMts35zNbySZjZppbVeV5OKtOGy/mBC2Ye+3yNJlbnfhrZJn42Xp7rW4FAf+6BjIL8lmA+3iR7L5woYQy9NtdIDxb3dy9LDyjJCroWB0H6O2ZOL7lHTigGRClDxqzbpYiz9CarwcTflEqBz7UCdS8fOooXQKPUNQFGR9Sx3yiGKM01Qag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(66476007)(66556008)(966005)(26005)(33656002)(4326008)(66446008)(53546011)(64756008)(6506007)(2616005)(8676002)(5660300002)(6512007)(122000001)(38100700002)(186003)(76116006)(71200400001)(8936002)(36756003)(2906002)(91956017)(66946007)(316002)(86362001)(66574015)(6916009)(44832011)(478600001)(83380400001)(107886003)(54906003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5mdld3RVdUbDFLb0NIWk1lM05oeE5zOTNFajFVNTUvdHcwdHphMmRuVW03?=
 =?utf-8?B?dFBaOHo4MnFpRDRGV0NyRlBPaVNJNVZnaDNQMGVtbHEvTVFSR2IybGJQTjVE?=
 =?utf-8?B?SGVsZlN1Wi90Rnk2QUZhRXVSc2Y5MEVTQTVVbFM0QUlsWllKT1RrdURrRDlI?=
 =?utf-8?B?SC8xNllRWDIreVpycTR6VVhwenIycFVrYXdlN3hiNmlCdWdXa081Q2ttZnRk?=
 =?utf-8?B?OWtqNFBpTzQxaC9yUWJjdkYvaXlSUlZGZlBJNDhPQlpLN1BuV3pxTEhabjJr?=
 =?utf-8?B?R2J6dVJCZTJaRWRERjFBaFBRSTRQLzZOTXVhUU1MeEtVWFY3SUdqdkRxU1FP?=
 =?utf-8?B?ZnJEV0M5T1B3bEJOZnlJTjlxcTM0c0tiR2VOeFNGTlNWSDYrOENpQ1JjbHNx?=
 =?utf-8?B?SDQ5Tk9zZCtoWWNsNk1PTHlhdm5jRnNIcVducXQ0M0N2czdZMzROK2Y4TnFy?=
 =?utf-8?B?anV5dFg4UWd6WTlBOWtuNGF5VzhUR2dQbG5rTDQ2V3ZsYStOYTZ3TmN5R21h?=
 =?utf-8?B?aEZnQWZmUzkyTUxDdk1oUWtTTkF6R1BuZDVZUjJXemtEcmNaU2tnbDZVMFJT?=
 =?utf-8?B?QkwyR003Z3hXRXROLzJmRnJFcFJZZFZMRzgyY0ZibzRpNmxOa1NHZFpQYlo1?=
 =?utf-8?B?TTNtajNDUU1YYk9SbFZia1d2SHZRVHZndmVlVmdQbDhnQVdTeUUrb2NwVTQ1?=
 =?utf-8?B?eEc5RUlrQ3BUdFJNZ0FTZzV2WTcyMlJzSlVuam5WcVJ1UFVWZHV0RG1WVFZG?=
 =?utf-8?B?cytueFljZUFWSkh2cG9wem5RYVgzRTd1bDFKa24wVTFuSVpnS3RJSEtIVXJ6?=
 =?utf-8?B?SDVJRkk1S2ZWRHhDMVpZQkVkOXVFQWpSUGJjclN3YXdLYUxpN3Z0OUZEUHlp?=
 =?utf-8?B?WE1FVTZmdFduaUxJS2JGczlrajlzWXdCSEVhcUJBclgxcUc3TDJZWWRqMmk2?=
 =?utf-8?B?b0luM1gzcHJyQUlGL0E2dzlIKzJXVEprRnkzZWpxQ21qVXpmRHdNUW1sVGRM?=
 =?utf-8?B?cW5RT1ltZ3Vmd2FOTDdYRU5GWm8rVGhpK3FSaGhaRVVEc3pueVczcG1KckY4?=
 =?utf-8?B?eUE2bkFSV0RDWDFVcHgwOVRNWVFoN0tKYWN5azQ0QU55RElnNW4zOFNSRjJB?=
 =?utf-8?B?RWIzK3RGY08wTXUwclVTR244WGFFZ0tNSWR6VVVqTnFCQUJRV0NkUEdFY3dp?=
 =?utf-8?B?OXl6bUZURmRzNTgrcU9YYVN6dzFIdnJtTCs0US9USEx4UXlrTjZyUUdKWm43?=
 =?utf-8?B?bWlybks5TDl3ZVhscDQ3S3JST1ZOTm03U0JsKytBclVWR25BbEJJejV0YjhW?=
 =?utf-8?B?VnlUeGVHblljaGl6OStEZFJrVUhmbmJDWmQ2QzZZdmk2YlZIREc4TjY3S1RI?=
 =?utf-8?B?SDBMcVhFU3BvMUZJUHVVbGwvWWxEZ3VpR3BPRkYyRGRCZ0xkYi8zaXAyUFY1?=
 =?utf-8?B?VVpuOHhSaWJTeCt3T2pOUmN1SnJOZGxOc29aZkNuTjcwNzl3Rmdtem9zRHdN?=
 =?utf-8?B?VU9YU2Z4NE5mOUo1ZllHR0tCMEh2STB6Y2poZGpzWXBpYXZWQ0t0WXVTRXE5?=
 =?utf-8?B?RXllNS94Tlc3OVhkQnRPemhscmVnWWdBT1kzNml1WVkzTC9vbGF2cTIzeXQz?=
 =?utf-8?B?TEtKbGVQTDNCYU4xQWp0aDAvOEY5V3BNNWVCUjlHU2xoU2JZK3Z3aFpBZmJI?=
 =?utf-8?B?ZnBINld5ZDE2UGRFeEpVSnFBUnNiT2pHYnRieDJySFZ5M2NJV0FGUU1Tc3BJ?=
 =?utf-8?B?Y3RaRDI3STZpdnVQaU14TWpTTVRQRHJCWDdkNWFQNWpLSHJaazFVU3hwR2xx?=
 =?utf-8?B?YkliQk1CQ0YxejAzUjd4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A48F34002CCE7C44AAEDB0B0D7DBCCD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a94a250-0511-48b7-6de3-08d934c51210
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 14:58:46.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAQcyja6AjNyJzfj+bbwUWtjGI8P9FQ1LrztFp5W1Wb64TEQh9zHp+6xIUHMZLgrzrdzLW2fR4MuePg/7B3CxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1335
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210089
X-Proofpoint-ORIG-GUID: cxqXBRtz6pJC0nZ9kt6Yb7vElFdzLyWG
X-Proofpoint-GUID: cxqXBRtz6pJC0nZ9kt6Yb7vElFdzLyWG
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDE2OjM3LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDEwOjQ2OjI2QU0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4gDQo+Pj4+IFlvdSdyZSBydW5uaW5nIGFuIG9s
ZCBjaGVja3BhdGNoLiBTaW5jZSBjb21taXQgYmRjNDhmYTExZTQ2ICgiY2hlY2twYXRjaC9jb2Rp
bmctc3R5bGU6IGRlcHJlY2F0ZSA4MC1jb2x1bW4gd2FybmluZyIpLCB0aGUgZGVmYXVsdCBsaW5l
LWxlbmd0aCBpcyAxMDAuIEFzIExpbnVzIHN0YXRlcyBpbjoNCj4+Pj4gDQo+Pj4+IGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDA5LzEyLzE3LzIyOQ0KPj4+PiANCj4+Pj4gIi4uLiBCdXQgODAgY2hh
cmFjdGVycyBpcyBjYXVzaW5nIHRvbyBtYW55IGlkaW90aWMgY2hhbmdlcy4iDQo+Pj4gDQo+Pj4g
SSdtIGF3YXJlIG9mIHRoYXQgdGhyZWFkLCBidXQgUkRNQSBzdWJzeXN0ZW0gY29udGludWVzIHRv
IHVzZSA4MCBzeW1ib2xzIGxpbWl0Lg0KPj4gDQo+PiBJIHdhc24ndCBhd2FyZS4gV2hlcmUgaXMg
dGhhdCBkb2N1bWVudGVkPyBGdXJ0aGVyLCBpdCBtdXN0IGJlIGENCj4+IGxpbWl0IHRoYXQgaXMg
bm90IGVuZm9yY2VkLiBPZiB0aGUgbGFzdCAxMDAgY29tbWl0cyBpbg0KPj4gZHJpdmVycy9pbmZp
bmliYW5kLCB0aGVyZSBhcmUgNjMwIGxpbmVzIGxvbmdlciB0aGFuIDgwLg0KPiANCj4gTGludXMg
c2FpZCBzdGljayB0byA4MCBidXQgdXNlIHlvdXIgYmVzdCBqdWRnZW1lbnQgaWYgZ29pbmcgcGFz
dA0KPiANCj4gSXQgd2FzIG5vdCBhIGJsYW5rZXQgYWxsb3dhbmNlIHRvIG5lZWRsZXNzIGxvbmcg
bGluZXMgYWxsIG92ZXIgdGhlDQo+IHBsYWNlLg0KDQpUaGF0IGlzIG5vdCBob3cgSSBpbnRlcnBy
ZXRlZCBoaW06DQoNCjxxdW90ZT4NCkkgZG9uJ3QgdGhpbmsgYW55IGtlcm5lbCBkZXZlbG9wZXJz
IHVzZSBhIHZ0MTAwIGFueSBtb3JlLiBBbmQgZXZlbiBpZiB0aGV5IA0KZG8sIEkgYmV0IHRoZXkg
Y3Vyc2UgdGhlICIyNCBsaW5lcyIgbW9yZSB0aGFuIHRoZXkgY3Vyc2UgdGhlIG9jY2FzaW9uYWwg
DQo4MCsgY2hhcmFjdGVyIGxpbmVzLg0KDQpJJ2QgYmUgb2sgd2l0aCBjaGFuZ2luZyB0aGUgd2Fy
bmluZyB0byAxMzIgY2hhcmFjdGVycywgd2hpY2ggaXMgYW5vdGhlciANCnBlcmZlY3RseSBmaW5l
IGhpc3RvcmljYWwgbGltaXQuIE9yIHdlIGNhbiBzcGxpdCB0aGUgZGlmZmVyZW5jZSwgYW5kIHNh
eSANCiJvaywgMTA2IGNoYXJhY3RlcnMgaXMgdG9vIG11Y2giLiBJIGRvbid0IGNhcmUuIEJ1dCA4
MCBjaGFyYWN0ZXJzIGlzIA0KY2F1c2luZyB0b28gbWFueSBpZGlvdGljIGNoYW5nZXMuDQo8L3F1
b3RlPg0KDQpJIHRoaW5rIGhpcyBsYXN0IHNlbnRlbmNlIHByZXR0eSBtdWNoIGNvdmVycyB0aGUg
bGluZSBzcGxpdHRpbmcgSSBkaWQgaW4gdGhlIHYzLg0KDQpBbmQgbm93IHdlIGhhdmUgdG8gZXhw
bGljaXQgYWRkIC0tbWF4LWxpbmUtbGVuZ3RoPTgwIHJ1bm5pbmcgY2hlY2twYXRjaCwgc2luY2Ug
aXQgZGVmYXVsdHMgdG8gMTAwIGNoYXJzLg0KDQpQZXJzb25hbGx5LCBJIGRvIG5vdCBzZWUgdGhl
IHZhbHVlIG9mIG9jY2FzaW9uYWxseSByZXF1aXJlIDgwIGNoYXJzIGxpbmUtbGVuZ3Rocy4NCg0K
DQpUaHhzLCBIw6Vrb24NCg0KDQo=
