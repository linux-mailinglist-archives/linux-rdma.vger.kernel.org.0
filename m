Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9B235D744
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 07:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbhDMFb4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 01:31:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50202 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhDMFbz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 01:31:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13D5V0GP185678;
        Tue, 13 Apr 2021 05:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NqOkdPhSxBQRS46ryB+PhhBvGYbtfxVXW2kbPhK0zVc=;
 b=keBtP7bzFyUcAojaifk+9xhOyivQgs56cMmUIswOQbC1rogmYGT4mJpT/Mf2hvvxSrZH
 c6u1H4DaKJ+dFpcpXr+NiQ5sVC44cA6WD0Rfr9r9r8c1kJUJsbhDYGs4ok4imJmQon9G
 1iW/h1cdCTDPlT+a9sP+LSHm2PCAAgReX7myKHSdGWNb8pNp+oGdwfAMGp/+B17sxHUF
 H+pkJ25WbZbp/j55zWwMiAmxtQ6ctO5468P3ei2OpCKRZTUAnD3qX25Q72atWRdOEVjB
 Bvff++qpcsSmoj0jZ9Hi6sNl/z4kvjA19mPjs+eoB6xKn/xE+8oqHMts1zr6sjla1v2a 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbdwwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 05:31:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13D5QVeB089385;
        Tue, 13 Apr 2021 05:31:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 37unkp3a52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 05:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg/yt/kqdN6rhgIkIcH3wUeHdH6qGY+tgjsS7aXX8Mov8kG5QrE5ysGDm3p7AGkrfo6XimSCBkDoP78mHV5xvy05p58ffHOwgxdfjWr1bwSppsFSdMaSZBbhr7JaFA58h+6vUON5cLNZ1OcU2dJEP4py/zsFDUuUgF2tq5x55HSTSlhI9Z4ukGfry4F+txkkY1tcBwcKG4GBIPUEqlOmWdMTK5/OLks86p8m2eu+Jt3Nw/zntwV44c+DmIYjBOCGRhboZJkLM9OuufmzCMXno1eZsjxQEPx0w2zN3XzamvmJkEtT1wugO+LT359nH0FHUZ/c9RMBlN2V9d+Vtmpemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqOkdPhSxBQRS46ryB+PhhBvGYbtfxVXW2kbPhK0zVc=;
 b=m+ktx6hKaCXiBIPeETZR9y01CjjYBI31ETHnB5QZeyIbIdBagDU8KnJ75DtoDIf4XAPeL1IP/8TFaS1/FMmyk2TbMFY3ni8nqei1Xl6ckdcXu23UiXV3TGPo9q1MOoTRszyF2bAIxBgR13xmbm2gAfs+3/jpXvKFl5vaaxYhvFno3bvs/VS2E0oa0XCUf0kUDAo0wYs/c7NBK0JgkRJ6S2/nExlfT6NnBgULoDhwBNCSFs0eW5WiN69bLP1+ICeQZmQIHPvlsaU2T4MbstFunoUqRDS3h8uD0IZLwlNWyaqscj/PJJOUqogbk1crF1YLVVDP5j8qHN3MKb7gRAiQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqOkdPhSxBQRS46ryB+PhhBvGYbtfxVXW2kbPhK0zVc=;
 b=LV/KgFKvLTSbWObiSRT4JJhOaut7lfxQH0A7VGhAadTtzyWT/biC2DLRXs914lf3uBQP9oMTAUFwFsdO9o5MKxTLLckiCJ+urG3lCnV9n5EzOQG3y89uRinEwd84SUpUqnh/8cHPU3lSMMck+HinE0/JU3zKBVVoGrWjo7tarrw=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1991.namprd10.prod.outlook.com (2603:10b6:903:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 05:31:25 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4020.022; Tue, 13 Apr
 2021 05:31:25 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Gioh Kim <gi-oh.kim@ionos.com>, Jinpu Wang <jinpu.wang@ionos.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Thread-Topic: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Thread-Index: AQHXKuGKRnd/MczQpESwCGw5yDth46qnbquAgAloroCAAAUlAIAAA4mAgAASuICAADu1gIAAyEUA
Date:   Tue, 13 Apr 2021 05:31:24 +0000
Message-ID: <1DFC1F4B-FF53-4AA8-B5FB-9F57B378339E@oracle.com>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
 <20210406123639.202899-2-gi-oh.kim@ionos.com> <YGxXD/TODlXHp2sK@unreal>
 <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
 <YHQ/7MTKGD/UO4pW@unreal>
 <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
 <CAJX1YtZJ3sJy5fu_6v-sbqx3yLsPTh_SbvRQo9Yz1k48KxXpCA@mail.gmail.com>
 <YHSErWp/Bi0kpBty@unreal>
In-Reply-To: <YHSErWp/Bi0kpBty@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ce9a6b-5bdb-4126-d1a0-08d8fe3d613c
x-ms-traffictypediagnostic: CY4PR10MB1991:
x-microsoft-antispam-prvs: <CY4PR10MB19916C21155310DECBF27209FD4F9@CY4PR10MB1991.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvdovI856579peKN/QA8UwK2sgJbq+5xcMYt93+au8EPr5mfobdooHj2e3sEdg2SC7Tl/WCBylXcZUFGj1pvflupMwudcBlAhOf+HjGDiRP/mQWhBVGldyvS+WXgmdQYD1RTwE5xN+2/zB/AHJ3QHz3p/EtgJAcxX0E6I+6JpUym6h/LUDU5kl9+Lyu+fHl0aIm88g5vnYqL18Lrp0n37zuHyLVdZHUy+Kl9aB46h2S3OKMFcZb5F89uR5KR3ZWpkXJ9YSO95MR7IPIkYrEwRnZ6kUqz3drfz94pECrULhQLPj7Jc+jacs9fW/zFGL0CrVKxaURBLB0h8mNISt1alOl0qRNQMmZ7md+8TN4egNIvLZMa0crCtZSQKVbCs0haPHnr5ySiAndohm+5UDmtkvu4mql8EXl9ruyO9z6rT1zAZl8lPbl/vz0dMIXkRN6+0Se/eDhuPIty4H4rKSXRRa6c/2oeJrZtw/3mHUEcgPDmHU0Cudjh3ykXjUlVb1hLGcPCclyRbKGusEWdeid9vRAYLmCvSAuyMx2tEhLowOwe2Z69+fzsAUikVOuOrRiMA+tWuIx1z/mvtRNnHJZYxXLz8BpTHQBNC6XGWs7AfPKU+m25OnKflqwqtNeMhflfDdJlVDl054acBc6rRTSBBfzHCfr3zOQyXQh6Az0rF/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(39860400002)(366004)(376002)(66574015)(8936002)(76116006)(54906003)(66946007)(316002)(91956017)(53546011)(6916009)(66556008)(6506007)(66446008)(38100700002)(36756003)(66476007)(86362001)(2906002)(8676002)(6512007)(33656002)(71200400001)(478600001)(6486002)(4326008)(26005)(64756008)(83380400001)(44832011)(5660300002)(2616005)(186003)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NWVkNTVibjBFZjR4aWoxQm5lUFFqOHVlUlZMeUNGKzBCc2cvVjYvYjdJOEo5?=
 =?utf-8?B?SkpRYmhrMVlvTkN0YnFNSUxxOUkxZXNaYTV2ZHQ3UzkvOEh0SmFNVzFLMVZ4?=
 =?utf-8?B?TmJPUjcvbXEwb1o5R3loeXJYZ09tcnhJQVI2U0JuY3k2aXF2V0NUZGpQWlRp?=
 =?utf-8?B?TDV2M0lLb0l1ZS9kZ0l0MjRDOWNia3c0a1RBVU5Cd0tzbi9QS3l1cXdwbHBw?=
 =?utf-8?B?VTlxRVdqUDRaK0FxTHk1blpzYjZ0OFZWMXhORDB4ZDFBMzEwdU0rNnZIc21I?=
 =?utf-8?B?ajVpNVJMeVZlR0ZPOWJsSldJRHpNYXpuYVVsTE90ZWo2SGxsQ1JOYkdVMHlt?=
 =?utf-8?B?aGlodllyOWtsTVZnbitSZzBieWJKRmZjMGRLNEFxU2lOVGdjYVUrdjY0OVhq?=
 =?utf-8?B?SWMxM1JRT2ZnOXdyT3ZBeENPcnM4akYvalpkVGRvM3dWUDhhOHNicUQ5aXhq?=
 =?utf-8?B?UUZvSHNXeDJlUDVsNk9ON2ZGTkFvemRReW5UOUlxbWZ2dmxDVllJWE9aS25J?=
 =?utf-8?B?N3FhSTIzNEtqSVp6bUg3Vk9VOEp1ckgzaTZSaDVDUWlkTTcwZUlnbWcrbHpu?=
 =?utf-8?B?M3E3UTY5UDMyNFArckJQYzNPMEh4SkE5WG12VngyWWRiZDM4RXRTUUFtK2ZX?=
 =?utf-8?B?YTVRNE44M1oxbGZtZFpvSSt0K1ZFZ2oxNDhaVFlqVUJ4WERMczg5K2xjaEVJ?=
 =?utf-8?B?VkMraDhlMVlFV3VSZllIZnZla3JYRnMyc0o3VU1Ma0Q2eVlxa1dsRGZpTmJV?=
 =?utf-8?B?Q0tWZWhlVjVPM3FjTGJ6aUd4SG01QkdMc2RyaURpdEVyaVg4RmZlMGx1eU4r?=
 =?utf-8?B?MEJjYWpVc2hveDQ3L2ljL1JnZ1RFdjV4dFI3YWp0VUtRYzNTT2diVW9Xc3Ba?=
 =?utf-8?B?ZTY1WjV1T1ZvMHI4dWI0L3JnVUpYMjFVQ3dFMWc2MnFreCtyTzBKdVkwcUJT?=
 =?utf-8?B?c1Fyd283SHBHajdKeDRpVysxNXBTUXk2VWFZbkNUaGdTUlYrby9xenBHT2JG?=
 =?utf-8?B?VkcwanJvcG1OSDVOY2FsSEV2ZXU5L1owOVVOc09WV2RnUUVGNGI5QkxFTS9I?=
 =?utf-8?B?RjF2TTdXZTBrY1YreEt2WlhXNU4xV0ZHNGk0NGg3RGhVNXppR2NIV05xUG9o?=
 =?utf-8?B?M2lpUmFCNitFRDQ0djdkV0I3QjBlcEdLUXBjYWEyVWFZdWVBYnFhNEdvTWx0?=
 =?utf-8?B?RWY3WXZMdXlUN1k5em9KcU9JWUF4b1lYYXpVdkFic1NNaTBiSFN6NXZaSUZS?=
 =?utf-8?B?VmtYS2pScGxuY3VaNSs5NkVXSmJ0cUw5TEpaMWhlSFFxeXd1QWJlOHQrSG04?=
 =?utf-8?B?bkFxdWNFV1RLaUx2U1hHdjd6enJSeWlPdlVzVFdKcGdJbzRsZXk5VzNXNVpK?=
 =?utf-8?B?TUthUWRFdUt4WjNobEx3WmFRTFFDRWU3Zzk0eENoWEpDdG9RTzZ0RnFlRjNX?=
 =?utf-8?B?eDQ3eWt1emhCRGtTU0pyd1Job1ZFRlhOSXE5UVRrajhIM3JyU082SDlNUFhp?=
 =?utf-8?B?YUlaSHNndDZOOHQvd3FmY3hYL0xaWVV3U0loUWVaR1R3UzA5SlF5UW5iSVBC?=
 =?utf-8?B?Qlk2RmFEMmcvSlB3ZW41VVNFSkNEbWdhdFgzNmgvOFlEc0Y0Y05TSmdrOTNO?=
 =?utf-8?B?ZmRuSGFJL3VVd3F1azdoQnU3M2FyeXZqTjJkbWo1clFOeTBvbVNUZ2kyd0tj?=
 =?utf-8?B?cHd1ZktoR0dZMlZtNThVajlGQlRVS2NiYjJua3U3SGtTTmVmR0drSzZWb3k4?=
 =?utf-8?B?Q05VUm0vSVg1dUlBZHBlVGpCOWxlMmdQL3FEUk1JRC9kYlRRV29qTjNVcmw2?=
 =?utf-8?B?Vk5TTnhJcXJneDRDeXRLQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD6081710422404E9A50A7C08AE61FAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ce9a6b-5bdb-4126-d1a0-08d8fe3d613c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 05:31:24.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNOECIE1688QKzTYvFPpf4YatBJfEMjgFEtGOBRHhFIruvIb5nBTd33e+BOfMI3fZHRFlJt92gzex28KTvV/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1991
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130036
X-Proofpoint-GUID: gFQazgX7zJPiZS2EqvVxbABfquTnkIXk
X-Proofpoint-ORIG-GUID: gFQazgX7zJPiZS2EqvVxbABfquTnkIXk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130036
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTIgQXByIDIwMjEsIGF0IDE5OjM0LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEFwciAxMiwgMjAyMSBhdCAwNDowMDo1NVBN
ICswMjAwLCBHaW9oIEtpbSB3cm90ZToNCj4+IE9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDI6NTQg
UE0gSmlucHUgV2FuZyA8amlucHUud2FuZ0Bpb25vcy5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9u
IE1vbiwgQXByIDEyLCAyMDIxIGF0IDI6NDEgUE0gTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4gT24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMDI6MjI6
NTFQTSArMDIwMCwgSmlucHUgV2FuZyB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgQXByIDYsIDIwMjEg
YXQgMjo0MSBQTSBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+
Pj4gDQo+Pj4+Pj4gT24gVHVlLCBBcHIgMDYsIDIwMjEgYXQgMDI6MzY6MzdQTSArMDIwMCwgR2lv
aCBLaW0gd3JvdGU6DQo+Pj4+Pj4+IEZyb206IEdpb2ggS2ltIDxnaS1vaC5raW1AY2xvdWQuaW9u
b3MuY29tPg0KPj4+Pj4+PiANCj4+Pj4+Pj4gQ2xpZW50IHByaW50cyBvbmx5IGVycm9yIHZhbHVl
IGFuZCBpdCBpcyBub3QgZW5vdWdoIGZvciBkZWJ1Z2dpbmcuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiAx
LiBXaGVuIGNsaWVudCByZWNlaXZlcyBhbiBlcnJvciBmcm9tIHNlcnZlcjoNCj4+Pj4+Pj4gdGhl
IGNsaWVudCBkb2VzIG5vdCBvbmx5IHByaW50IHRoZSBlcnJvciB2YWx1ZSBidXQgYWxzbw0KPj4+
Pj4+PiBtb3JlIGluZm9ybWF0aW9uIG9mIHNlcnZlciBjb25uZWN0aW9uLg0KPj4+Pj4+PiANCj4+
Pj4+Pj4gMi4gV2hlbiBjbGllbnQgZmFpbGVzIHRvIHNlbmQgSU86DQo+Pj4+Pj4+IHRoZSBjbGll
bnQgZ2V0cyBhbiBlcnJvciBmcm9tIFJETUEgbGF5ZXIuIEl0IGFsc28NCj4+Pj4+Pj4gcHJpbnQg
bW9yZSBpbmZvcm1hdGlvbiBvZiBzZXJ2ZXIgY29ubmVjdGlvbi4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IEdpb2ggS2ltIDxnaS1vaC5raW1AaW9ub3MuY29tPg0KPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBKYWNrIFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPg0KPj4+Pj4+PiAt
LS0NCj4+Pj4+Pj4gZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMgfCAzMyAr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQo+Pj4+Pj4+IGluZGV4IDUwNjIzMjhhYzU3Ny4uYTUz
NGIyYjA5ZTEzIDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0
cnMvcnRycy1jbHQuYw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMv
cnRycy1jbHQuYw0KPj4+Pj4+PiBAQCAtNDM3LDYgKzQzNywxMSBAQCBzdGF0aWMgdm9pZCBjb21w
bGV0ZV9yZG1hX3JlcShzdHJ1Y3QgcnRyc19jbHRfaW9fcmVxICpyZXEsIGludCBlcnJubywNCj4+
Pj4+Pj4gICAgICByZXEtPmluX3VzZSA9IGZhbHNlOw0KPj4+Pj4+PiAgICAgIHJlcS0+Y29uID0g
TlVMTDsNCj4+Pj4+Pj4gDQo+Pj4+Pj4+ICsgICAgIGlmICh1bmxpa2VseShlcnJubykpIHsNCj4+
Pj4+PiANCj4+Pj4+PiBJJ20gc29ycnksIGJ1dCBhbGwgeW91ciBwYXRjaGVzIGFyZSBmdWxsIG9m
IHRoZXNlIGxpa2VseS91bmxpa2VseSBjYXJnbw0KPj4+Pj4+IGN1bHQuIENhbiB5b3UgcGxlYXNl
IHByb3ZpZGUgc3VwcG9ydGl2ZSBwZXJmb3JtYW5jZSBkYXRhIG9yIGRlbGV0ZSBhbGwNCj4+Pj4+
PiBsaWtlbHkvdW5saWtlbHkgaW4gYWxsIHJ0cnMgY29kZT8NCj4+Pj4+IA0KPj4+Pj4gSGkgTGVv
biwNCj4+Pj4+IA0KPj4+Pj4gQWxsIHRoZSBsaWtlbHkvdW5saWtlbHkgZnJvbSB0aGUgbm9uLWZh
c3QgcGF0aCB3YXMgcmVtb3ZlZCBhcyB5b3UNCj4+Pj4+IHN1Z2dlc3RlZCBpbiB0aGUgcGFzdC4N
Cj4+Pj4+IFRoaXMgb25lIGlzIG9uIElPIHBhdGgsIG15IHVuZGVyc3RhbmRpbmcgaXMgZm9yIHRo
ZSBmYXN0IHBhdGgsIHdpdGgNCj4+Pj4+IGxpa2VseS91bmxpa2VseSBtYWNybywNCj4+Pj4+IHRo
ZSBjb21waWxlciB3aWxsIG9wdGltaXplIHRoZSBjb2RlIGZvciBiZXR0ZXIgYnJhbmNoIHByZWRp
Y3Rpb24uDQo+Pj4+IA0KPj4+PiBJbiB0aGVvcnkgeWVzLCBpbiBwcmFjdGljZS4gZ2NjIDEwIGdl
bmVyYXRlZCBzYW1lIGFzc2VtYmx5IGNvZGUgd2hlbiBJDQo+Pj4+IHBsYWNlZCBsaWtlbHkoKSBh
bmQgcmVwbGFjZWQgaXQgd2l0aCB1bmxpa2VseSgpIGxhdGVyLg0KPj4gDQo+PiBFdmVuLXRob3Vn
aHQgZ2NjIDEwIGdlbmVyYXRlZCB0aGUgc2FtZSBhc3NlbWJseSBjb2RlLA0KPj4gdGhlcmUgaXMg
bm8gZ3VhcmFudGVlIGZvciBnY2MgMTEgb3IgZ2NjIDEyLg0KPj4gDQo+PiBJIGFtIHJldmlld2lu
ZyBydHJzIHNvdXJjZSBmaWxlIGFuZCBoYXZlIGZvdW5kIHNvbWUgdW5uZWNlc3NhcnkgbGlrZWx5
L3VubGlrZWx5Lg0KPj4gQnV0IEkgdGhpbmsgbGlrZWx5L3VubGlrZWx5IGFyZSBuZWNlc3Nhcnkg
Zm9yIGV4dHJlbWUgY2FzZXMuDQo+PiBJIHdpbGwgaGF2ZSBhIGRpc2N1c3Npb24gd2l0aCBteSBj
b2xsZWFndWVzIGFuZCBpbmZvcm0geW91IG9mIHRoZSByZXN1bHQuDQo+IA0KPiBQbGVhc2UgY29t
ZSB3aXRoIHBlcmZvcm1hbmNlIGRhdGEuDQoNCkkgdGhpbmsgdGhlIGJlc3Qgd2F5IHRvIGdhdGhl
ciBwZXJmb3JtYW5jZSBkYXRhIGlzIG5vdCByZW1vdmUgdGhlIGxpa2VseS91bmxpa2VseSwgYnV0
IHN3YXAgdGhlaXIgZGVmaW5pdGlvbnMuIExlc3MgY29kaW5nIGFuZCBtb3JlIHByb25vdW5jZWQg
ZGlmZmVyZW5jZSAtIGlmIGFueS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K
