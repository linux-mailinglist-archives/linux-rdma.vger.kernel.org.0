Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE58375056
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhEFHop (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 03:44:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhEFHoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 03:44:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1467eHH0145000;
        Thu, 6 May 2021 07:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AvwhquHve3Uf6ht1yeRCaGK1fWHJ43dD96y8GjGhCY0=;
 b=CTAbNsDQqz6GMc36JKsFszlTATtxWY23/Jt0C4NVqE9powz0WSchKkTvIiMwRQRzxjyp
 H5KtxI9tDvoGWGADfPj1LIbtOAhXQCfbf92Q+KShibL8LcSW23IeT+oz6zyR7VVzwR0X
 UGh+li9ZuE+Vk7y0OVPSTmTbcdtbP/ul8L89uy5x7AcXQqTa3Zq1VuRDjMz4YSNwf4Dc
 UTdC9OHfZz4/sfnBDJxVTHJLgo3mSRDRDLPIGWFYdp1CypeXt/YdxXVOttKQoknOrr4b
 gr/UDy45Z5ZDwMKu+ReAYF5axh/L/HckA7ggdR8m7Kg13H/5Nuki21HsXf71FoQ9UpP1 yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38beetm2pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 07:43:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1467fIMD178803;
        Thu, 6 May 2021 07:43:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 38bebux5c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 07:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVKQ06f/525LK7B0ivCvUwv1qCGQQDZPGWwsrp9VAyk/v2t37/veyvumGKiet2He673TVof6Eb/DNBOBxE03AjoFFegVQMtIQPW1/G1a7FeNAC1E0GXEllGxAp/tiiUDHqTu29yZE0/yYVuy/KAsSV/Ry7lgWA/RvxhTQAAoMJgBtVfGBc1Kz3SNU42Ur3kJQBs4CsjHVHNryT9NiUQFvwmVHPBJtEg5FVo4raC2ItSyXU2Zop4VXmn+l8d94QnQmBPSJbtKVAVekOObVB76BJlL3gsoicWhiDsKL7gmW0uMo5iprXtqybx/KI3FAYUln/hSOYPekRBc7WC7K9U+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvwhquHve3Uf6ht1yeRCaGK1fWHJ43dD96y8GjGhCY0=;
 b=bngVp/Eq1EsH2SKNy34VZu3eA2oQ/WMFUJZLjyAZZlfnPksA6n9OySkxmhjM74lKN30v7nDDtNOF+pYvbDpSmMkigoXeChFU9GI+ma/WEVocphW3zQ9bShaDMXhzlrPCxkB2mArc7c1Hdz4mAmZXlnHE6/bCQ0xbXydoJTkKKzEG0a5Ep64yHfz90rpfE1LYF+xepe9g/ul9o+eEcJOkOyMSoJf3OD7GMZJHP2Kga+FVcj7oPLZKSySCF0FbjYs8tPLWYed3sAPQyK6JgyBTTjO6eQF3Q0QKP3burPOlzbjdeSBxOWpCZJqdEZTn6+B4ljrSo0a+eBmy3fLstbhrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvwhquHve3Uf6ht1yeRCaGK1fWHJ43dD96y8GjGhCY0=;
 b=myJpGI5lmzB8I0pRhHAkcCibXGvX4CmZw6ET+FWu31YpGvaHHJ8Mm9wkbO2OvaYbrWetjzR/RvJyiyEoiIPif+bj63/wdGk7hT6VXV8eTgjIJaCDexKw+0VHMeh6Im/ei1Dq7lcadSVXkerQZcAQ42mt6b4Xe8CrgitrOzC29CQ=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1990.namprd10.prod.outlook.com (2603:10b6:903:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Thu, 6 May
 2021 07:43:38 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 07:43:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Topic: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Index: AQHXQNsoKNg9ZANZeEOoJCtxKjVql6rWEVMAgAAEAoA=
Date:   Thu, 6 May 2021 07:43:38 +0000
Message-ID: <1DECA786-C769-481E-B1B3-573528F8425F@oracle.com>
References: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
 <YJOazOU65fI/WMwN@unreal>
In-Reply-To: <YJOazOU65fI/WMwN@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58141de4-f1d5-4df0-6f28-08d91062a96f
x-ms-traffictypediagnostic: CY4PR10MB1990:
x-microsoft-antispam-prvs: <CY4PR10MB1990F589CCBAE999EB7756DCFD589@CY4PR10MB1990.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZHpWAniRzaXDI0e5HNz7RbDhK1zbcQue9gZPBW6UXYFipfkyH3Vp5iaiuPLWRckU8e6UTb7rsHe+lfouu8XclEqaBuOTakqy5FYC6hEYwMwGhzkfPoI1sdQWIdnkgIrOH5ly2Tz5jBb4YnV86A96/CGMLA4COM3LKrOnTzDp7ME84BMGQ0sQoyZ74eZBHbz1TlKxeFl7lZWGKsAJYaOzHMtHeQ2YlTka3L/oCFFTThNVc5e7j4dYkmwOJl1mKG6OJga5Ay0O4rOU9abEBfJOMUNBZktrFJeiClV6q74F+ZNJKiaXCwta7rozq2Nm/1+O8NpO0Mg6N5QVeuWhs3OW38NN0iGpv+s6AHupYZnhhY2QWCYBmJp2rbezbcX3TLCDDyx3IAQjcUgH5BYlEcMJvhl6jFgogXECQOzvaIyiD5W5OeAV4NLnhIAUsl18aM2waxIfapu5MyLCHxDXxEScTdqZ6JToSTjtC061QhYKZgb+MPEWqk+6vweCSzGOQVQ0gLYmySUmqcfKTeVllfszXELfQ5tsMv4JQGBSXG7BQ1sx0T89rA7XMeyy9iXhu/Bg5ekaywu/g/uhuIiOKPwdi28gmM2HR8PnFGby05MLXoZV5K9W3QkR6yp2U6y+S9jxfWsdxD3SQLEVzV3+Y2N6/X6OrkdXJjK14HJM28yQJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(366004)(136003)(478600001)(66556008)(6512007)(6486002)(66574015)(15650500001)(36756003)(8936002)(33656002)(66446008)(91956017)(83380400001)(2616005)(6916009)(38100700002)(64756008)(66946007)(66476007)(44832011)(76116006)(5660300002)(71200400001)(26005)(6506007)(86362001)(8676002)(53546011)(316002)(54906003)(186003)(122000001)(4326008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V3pkZGF3aWNUeS93SEI1QVVROE5YdmVVR1Z5OVBNMFdyblNDTlU3K21iSlZL?=
 =?utf-8?B?KzFZczZZODRWM0lpVjNjS3NuRk15NGx2TEdocDEzY0F2bkliRHQ5dmxEZFNU?=
 =?utf-8?B?Vnd1NVY0RXNVNUpPQ09QRFJxdWwzck03ZjZMa2xXL3hHazJ3WlMrSmhFeU9j?=
 =?utf-8?B?TEtvYTUyeE5PL1JBWUFDdlE0MFA2Y3ptNWQ5aXh6V0ZsTS82eGQ0ZlBYYkYy?=
 =?utf-8?B?ZDF5bHYxYmRTQ2E3RGZYcTNJbFBTS0hDbDErMUphaUhXaGR0eWhmdk53bjRr?=
 =?utf-8?B?Y1ROMXhpZTF0WUpKMGpKWGhmWURTNjc1NU96Y2pkNlk5OFZydWR0S3BzOUN2?=
 =?utf-8?B?RjNBYjR5OVN2SGZuSTZvQ3pmV2ZnMm5za0pCZDR4RlZUMHZEWFlDZlhJbmZS?=
 =?utf-8?B?b0cyNElBbGlIcDNvVEhGTWV2bnYwQ2ZOVXZqeHVDaytWTGoxWFB0MkIxVzlh?=
 =?utf-8?B?TTBFdzNXczRLamVJU1BOZlBLTTIwY1p4Sk1wTkMvV3lrT1hPOFNTYkJCZ0ha?=
 =?utf-8?B?QkZwZzRMN0JvK29ZK2JJcjA0VndQQkxZcEhEek1MR1FOSTFqMTZFR09zV3ZF?=
 =?utf-8?B?ZFVDd09XOWMvTTdKSzVyQVVpSDMwbDZhU3l5eVNEWjlCM1c4MkZrVGJSUzZ6?=
 =?utf-8?B?YXZtNkpvc2U4blJkQkUvNFlSWVdZV1R3bFlLVEl3UkRFUlNVbndJOFMrZFY0?=
 =?utf-8?B?aVdMaWZyVi9RekJtVkJUbGVPSkdYYkFMdmY1UXU0cTgvNHI3cjBaNUFUVnFw?=
 =?utf-8?B?bm9tdWI1SUNTUWczdkRvS3RDTWR0SmZQUnlWNmxqV09obHdERUtrSXhOV0hm?=
 =?utf-8?B?VnhjMHA3OG4yWnovaWZoeUpPclJIRjlBVEJLM0tMQllyU0c5MUIxWHJMWmNx?=
 =?utf-8?B?Y2lmZGFiL2NVQU5VM2RhUjRVdFFTWTl3NDQrMnlrMGMvUmkzeW1zdTZTOG4z?=
 =?utf-8?B?dUJUcVQxUUJBK2g3c2QvWHNMbzBjaFA0RGxQeGYweGcycDJMc2V1b2lYaUFI?=
 =?utf-8?B?c3FsZWVPbjg4Z21jSGR4YUpYUS9DeklleXhGNExKdGh0TlYvU1hpUlJlTFJD?=
 =?utf-8?B?aFNFcDdIMWxiTEhuYjlBTS9IU1o3VXM2T0lWT1JrUHRrNFE1djI5VTJ6L0d4?=
 =?utf-8?B?WDU0b0xoY3dxMGhza0plUWpURXE5S3Y5N3lITEYrRkNJamFWa2pzcWJpbFN0?=
 =?utf-8?B?T3pCMmt4dU8yYzNhd1gxRWl4TWdQaXFmcjRhMnZBbGZpczJMWlkyMEVSRmlm?=
 =?utf-8?B?NElMVjdCVCttOHB6ZzBhSmF1b0wvWE9DY3MxaDZmNzJBaXJMdG9QeHlSVXZC?=
 =?utf-8?B?MzdqRWxuRk0vM1h5Z0RtRnZ3OEMrTFhZdG9QZkszTTlCaXhqb3EweWNINVFs?=
 =?utf-8?B?ZjJNR2tvNXRDZDY3SGFDMFNoNERSZ2p3QUJabHhkelJ0Rk9RUktoT3ZZMjk2?=
 =?utf-8?B?WUtKZEdqUXFmK2M4eERwZHl3dXllcWhGdjFmVjFIcjhieVFnd09YNk9KZzRE?=
 =?utf-8?B?bm0vQU5QMWJsK2ROY1paNzlzYUc0RXM5M2l1K2lmS25mVkZHZTVtTEs2UTdj?=
 =?utf-8?B?SGVaamxUVGRjVkVSNEhCWEhzRnMveDlQU3hYNks2SWtST2ZweTMzTUlNYUsx?=
 =?utf-8?B?YkgrT0VPOWxVK3RWVUdyYXFOeDVIb2hpK2hiL3p4T1MvWkxPOEFleWNSSHkv?=
 =?utf-8?B?VzVNbmVFTUtWeGVLeW8zZWpJSU03aUozMzB1cG1kSU90NmVGd2JrVjhMb2pE?=
 =?utf-8?B?YW1Jc2h6RE56SlY5V2VuMk1PdW1YTTZLWmRmeWtKaXpaTVErRnV5VXpYUjBT?=
 =?utf-8?B?WUlhSFFIL3Z1YUhHSjlDZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD9504B822CF1E439C5BC28147EAA89F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58141de4-f1d5-4df0-6f28-08d91062a96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 07:43:38.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8GF/fdKdB4PcRE0dYMbFvyzeoGyGdCmBea4Tkpmac65PkkR0Xmo2gssZbYiyZymsj8jBTqTXwQ4xC4zrCnT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1990
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060052
X-Proofpoint-GUID: 6RYjUn0Cnyh_mS4sEiqPEtrfLnk1FsRD
X-Proofpoint-ORIG-GUID: 6RYjUn0Cnyh_mS4sEiqPEtrfLnk1FsRD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060052
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNiBNYXkgMjAyMSwgYXQgMDk6MjksIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTWF5IDA0LCAyMDIxIGF0IDAxOjQ2OjI0UE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEJvdGggdGhlIFBLRVkgYW5kIEdJRCB0YWJs
ZXMgaW4gYW4gSENBIGNhbiBob2xkIGluIHRoZSBvcmRlciBvZg0KPj4gaHVuZHJlZHMgZW50cmll
cy4gUmVhZGluZyB0aGVtIGFyZSBleHBlbnNpdmUuIFBhcnRseSBiZWNhdXNlIHRoZSBBUEkNCj4+
IGZvciByZXRyaWV2aW5nIHRoZW0gb25seSByZXR1cm5zIGEgc2luZ2xlIGVudHJ5IGF0IGEgdGlt
ZS4gRnVydGhlciwgb24NCj4+IGNlcnRhaW4gaW1wbGVtZW50YXRpb25zLCBlLmcuLCBDWC0zLCB0
aGUgVkZzIGFyZSBwYXJhdmlydHVhbGl6ZWQgaW4NCj4+IHRoaXMgcmVzcGVjdCBhbmQgaGF2ZSB0
byByZWx5IG9uIHRoZSBQRiBkcml2ZXIgdG8gcGVyZm9ybSB0aGUNCj4+IHJlYWQuIFRoaXMgYWdh
aW4gZGVtYW5kcyBWRiB0byBQRiBjb21tdW5pY2F0aW9uLg0KPj4gDQo+PiBJQiBDb3JlJ3MgY2Fj
aGUgaXMgcmVmcmVzaGVkIG9uIGFsbCBldmVudHMuIEhlbmNlLCBmaWx0ZXIgdGhlIHJlZnJlc2gN
Cj4+IG9mIHRoZSBQS0VZIGFuZCBHSUQgY2FjaGVzIGJhc2VkIG9uIHRoZSBldmVudCByZWNlaXZl
ZCBiZWluZw0KPj4gSUJfRVZFTlRfUEtFWV9DSEFOR0UgYW5kIElCX0VWRU5UX0dJRF9DSEFOR0Ug
cmVzcGVjdGl2ZWx5Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtv
bi5idWdnZUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9j
YWNoZS5jIHwgMjUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
Y2FjaGUuYw0KPj4gaW5kZXggNWM5ZmFjNy4uNTMxYWU2YiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL2NhY2hlLmMNCj4+IEBAIC0xNDcyLDEwICsxNDcyLDE0IEBAIHN0YXRpYyBpbnQgY29uZmln
X25vbl9yb2NlX2dpZF9jYWNoZShzdHJ1Y3QgaWJfZGV2aWNlICpkZXZpY2UsDQo+PiB9DQo+PiAN
Cj4+IHN0YXRpYyBpbnQNCj4+IC1pYl9jYWNoZV91cGRhdGUoc3RydWN0IGliX2RldmljZSAqZGV2
aWNlLCB1OCBwb3J0LCBib29sIGVuZm9yY2Vfc2VjdXJpdHkpDQo+PiAraWJfY2FjaGVfdXBkYXRl
KHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSwgdTggcG9ydCwgZW51bSBpYl9ldmVudF90eXBlIGV2
ZW50LA0KPj4gKwkJYm9vbCByZWdfZGV2LCBib29sIGVuZm9yY2Vfc2VjdXJpdHkpDQo+PiB7DQo+
PiAJc3RydWN0IGliX3BvcnRfYXR0ciAgICAgICAqdHByb3BzID0gTlVMTDsNCj4+IC0Jc3RydWN0
IGliX3BrZXlfY2FjaGUgICAgICAqcGtleV9jYWNoZSA9IE5VTEwsICpvbGRfcGtleV9jYWNoZTsN
Cj4+ICsJc3RydWN0IGliX3BrZXlfY2FjaGUgICAgICAqcGtleV9jYWNoZSA9IE5VTEw7DQo+PiAr
CXN0cnVjdCBpYl9wa2V5X2NhY2hlICAgICAgKm9sZF9wa2V5X2NhY2hlID0gTlVMTDsNCj4+ICsJ
Ym9vbAkJCSAgIHVwZGF0ZV9wa2V5X2NhY2hlID0gKHJlZ19kZXYgfHwgZXZlbnQgPT0gSUJfRVZF
TlRfUEtFWV9DSEFOR0UpOw0KPj4gKwlib29sCQkJICAgdXBkYXRlX2dpZF9jYWNoZSA9IChyZWdf
ZGV2IHx8IGV2ZW50ID09IElCX0VWRU5UX0dJRF9DSEFOR0UpOw0KPiANCj4gSSdtIG5vdCBzdXBl
ciBleGNpdGVkIHRvIHNlZSAiZXZlbnRzIiBpbiB0aGlzIGZ1bmN0aW9uIGFuZCB3b3VsZCBiZSBt
b3JlDQo+IGhhcHB5IHRvIHNlZSBpdCBpcyBoYW5kbGVkIGluIGliX2NhY2hlX2V2ZW50X3Rhc2so
KSB3aGlsZSB0aGUgZnVuY3Rpb24NCj4gc2lnbmF0dXJlIHdpbGwgYmU6DQo+IGliX2NhY2hlX3Vw
ZGF0ZShzdHJ1Y3QgaWJfZGV2aWNlICpkZXZpY2UsIHU4IHBvcnQsIGJvb2wgYWxsX2dpZHMsIGJv
b2wNCj4gYWxsX3BrZXlzLCBib29sIGVuZm9yY2Vfc2VjdXJpdHkpDQoNCkkgd2FzIHRoaW5raW5n
IHRoZSBvdGhlciB3YXkgYXJvdW5kOyBpZiBhIG5ldyBlbnRpdHksIEZPTywgZ2V0cyBjYWNoZWQs
IHRvIGJlIHVwZGF0ZWQgb24gSUJfRVZFTlRfRk9PX0NIQU5HRSwgdGhlIGNoYW5nZSB0byBzdXBw
b3J0IHRoaXMgd291bGQgYmUgbW9yZSBjb250YWluZWQ7IHlvdSBvbmx5IG5lZWQgdG8gY2hhbmdl
IGliX2NhY2hlX3VwZGF0ZSgpLg0KDQpCdXQgYnkgYWxsIG1lYW5zLCB3aWxsIHNlbmQgYSB2MiBi
YXNlZCBvbiB5b3UgcmVjb21tZW5kYXRpb24uDQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQo+IA0K
PiBUaGFua3MNCg0K
