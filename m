Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923423A5BD2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 05:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFND3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 23:29:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26430 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232234AbhFND3a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Jun 2021 23:29:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E3R4eS003247;
        Mon, 14 Jun 2021 03:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Hw9TRLrxvdpdujVDMMzJirV9OICy4AmTWEU6cvq4KUY=;
 b=vQsCcgpH8n9H28jAh38k/2D/9qTV3QISSFnvaqEnkONsyvQnAPSQF+224Mq38So7JBOG
 H61NxM4DVDv3jPcRFDVOzSMWnKCOQRyMWevyPKeWoXdKxXQzcqgw0WY0rjbkTpSuDTAv
 cDhObaMe2szmE5o6u4t9WW63dm2ifAkmM/mJdFZPqmcAk1ltNmlul5L9xqqu41GWbbzd
 4tEUIGbpnaw9C8XbbE70t89iWL7HfNZ/VTGuI/73egLX/b6BhzTLXyjA1GhzPZ9JDBEB
 O7w9kGWuTLojEcSHEIY9MZiabgOIZEE1qMCVNEVdU9L0mq+zKUlFe8SgCE2dHq0Z7Xxr KA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 395t6ug242-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 03:27:04 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15E3R3lb012820;
        Mon, 14 Jun 2021 03:27:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3959chtw4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 03:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LspWqBrfHpZWFMkVLHH5KwSjQ0F0/XbIkxRiZfxPNBrOr4sURdtYqP3A7BJMKAvSn2rhqPnqaebkpZw7MylJ/TWjJH44tBHYwozSvq3Rm3rGt9K1AWwwJ2hCo/CAJ78zuF8xbpFK3Fu8tVRQrdGeghohLbxKcyo7tgNmh3NojERyuYMMB6YtEZZunATL33J5E4KuWstswSQ3fPKpo+20sqh4AJZOPJfwANSyiw9Owo3ZX2VIuJbcI7roS40R84nylvyGGNRWBeMtRznBZo5TP9dhegkGN0YnQmH0x8ojzoSe0jMUcMoxYqvZ3MYc6YSTqRflyH3JVyPGrjo1IB0qCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw9TRLrxvdpdujVDMMzJirV9OICy4AmTWEU6cvq4KUY=;
 b=cpa1/fzIlSYQTsmot3IxaaFqT8nKtwPae2+hFqLvqyNRZWcPwBC3dNFQXP0wKzFCR/HvxTWgoO1qbvFqA+UQHACx5GOQnNOOhaeZD9t/+mpjEqaCezenJv/zOqlNnnIXpPXlorks+SkeiA7XABnN8w5K2oEyOE0vJ+Xk/qbWcYt1RxuCtC7zNyZQcyGQruEfq0vxRfIL6NK84dVat72/iB4LC06PbxFjNYxSfrtGRdGmr9tqBA3uJSGXjjvwPxo9EdXQ5iwxI+Kb4vgM/JOsjBloSC8dM7+Sqg9+eTpBXoU5lfPwcREyrc80hhYGqpqT4N6wfDmaP7wWZcoDx/7eDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw9TRLrxvdpdujVDMMzJirV9OICy4AmTWEU6cvq4KUY=;
 b=PTThjpUxs5EI39/o8+MUHNLqC4OCWheO7pYDXNA0o7d5rhkP+eUgvSgUuDsjT50/hUYwsSPYYlRJ9OXRzc+K484JYNBOE1vNgbJ3j8LB/QePNJHGHzHsn2LIwotfhpNRBZtrBN+zMznSbmgowJZWt4ySHCJO7Xapg8aMioCQJdU=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1349.namprd10.prod.outlook.com (2603:10b6:903:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 03:27:00 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 03:27:00 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 10/15] RDMA/cm: Use an attribute_group on the
 ib_port_attribute intead of kobj's
Thread-Topic: [PATCH rdma-next v1 10/15] RDMA/cm: Use an attribute_group on
 the ib_port_attribute intead of kobj's
Thread-Index: AQHXW3XC7qLq8SZSTkiH41zCfEamxasIV9WAgAAefoCAAAclgIAAAusAgAXurYCAAA5IAIAEZf6A
Date:   Mon, 14 Jun 2021 03:27:00 +0000
Message-ID: <92A96585-DAE5-46C5-8D2A-2EED92F75FDF@oracle.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com> <20210607121411.GC1002214@nvidia.com>
 <YL4TkfVlTellmnc+@kroah.com> <20210607125012.GE1002214@nvidia.com>
 <8685A354-4D41-4805-BDC5-365216CEAF40@oracle.com>
 <YMMb9NZ0nHRTullc@kroah.com>
In-Reply-To: <YMMb9NZ0nHRTullc@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0437c7f4-2120-4639-755a-08d92ee445a5
x-ms-traffictypediagnostic: CY4PR10MB1349:
x-microsoft-antispam-prvs: <CY4PR10MB1349D98C8A85555D402018E0FD319@CY4PR10MB1349.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT7HDaLrG8ZKbVsmBUrwQ7GXzNaQLkOeD9oIrkJlwLxg4CvlwwvA8x2BoGKO6KwfE3syAXO2ZSC1SCzVrHy0VqT4ekkZEVKUcc4kEFP2E7jycxfdxteis0ROHsCVa1VzGNA7kusY54bazMMg3gB829Y8ld14ra4f+FmoopXoMbQy9CtLbaNLWkIBphnjejgb/+7YHV/Bkpb0I7C6ZitirZcmejFFXhxgofeuxFXXbc0jvzCyRXv5ht2sycaTaWHGqSDej2kCYDsA/3DgChtdKQl+eccecr76HHEQDJJscqPKV41xhBQ/3dC/E+Mg9xCdN/HOD//IJHqlRWEoSjVXMhZEdAPm1ChaPZjc6PGV4YH7+eLA5vY2FlcY297DVmlW5vuQg8UTYjerX/s85iakLJRCO2Y9ylVxPggym/zMKufYqhIeUWNqGso97+W2HWw6u9qfIs34FOr6/d4bNpgdbzCEEKTuawQ3/pklXMnOZ2/YlsdEWS6YVenlJAGlAO3qnfPZzO2bCiTVUR9a9HBuT2sVHSvcHFqppOoD9bvm7BF97jTj5sPBu/kEY5aNbdHdsAfLFcslagqk/WW5IK42AcRs7IyT/gDEKuG+2A7Yjq//UvxfYF9P5EbYQnr3vSqvy7vcAM3dqDQfL7qAXnjGYtuc4AM3SSDLDtloAhTE2uA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(122000001)(8676002)(64756008)(53546011)(38100700002)(71200400001)(66446008)(66476007)(66556008)(8936002)(66946007)(6506007)(76116006)(44832011)(7416002)(91956017)(5660300002)(54906003)(66574015)(33656002)(4326008)(2906002)(316002)(26005)(6486002)(2616005)(6512007)(6916009)(86362001)(83380400001)(186003)(36756003)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHVMVjdKeDhXZDZDanY1dXhMSExVN2ZwZnZWbXI1eHp2RGlTNzYxSFYzS09V?=
 =?utf-8?B?NURyWXlTODNjMEx4U0FMNlZXMnl1RWxCZFlwRjE4SVZEK0wxZ3dvSXFFeElF?=
 =?utf-8?B?QnJaMkp6QVRnbGtMN3NZYy9jaVVnS2oxWnQ1Y1Q1N2lLQW56dXIvb21sSmpn?=
 =?utf-8?B?VFIvMmttZkxkeDl6c0pHSmtiUlFaUVdYZk9mMTFKUHhDdCs2NmpEOGFGcGNZ?=
 =?utf-8?B?a3R0aGk4aGIvR0hJcVR4WUVoY2FaUUdOTEtUdUxKeGVZclNMRHJnOENRdlBS?=
 =?utf-8?B?d04wb2lpN28vV0E2NWlrUlJVVmE0aWYyMDBob2JWemxBS1g1bEFSTG8yN2lG?=
 =?utf-8?B?Z1ZRUnVnLzcvRUZjOUFSakdBbnBKRE5oVWs2VVdEUmphOUY1dU0xdVlzSkNn?=
 =?utf-8?B?eDRGZHNLKzRCMm5sbW84K3dScGJDOHNEWnBmckJnbi9yRVJISnQ0WUhWbUc1?=
 =?utf-8?B?L0Nyb0NtdjgrSVRXajNwbG9QRkdKSlBBZ3IvWWREK2M1VE5lRVZ6Z25aR29E?=
 =?utf-8?B?WVg3SDhKSHFnYkJCdjVYZTFRUjAxT3ZqajNSU2huSzhnOGUyaDZZNGZhZklI?=
 =?utf-8?B?ek9xNGxjaGZRMHRnclgzY1JwQUVYdWNSVVV6R0tIZDMxUXQxK2tvTmgrOW4z?=
 =?utf-8?B?ZXdaVWV1UDlGclFqQ3krQzZkWEh6YkdlSkloMFZSRFVacENneVZJY0UrazRu?=
 =?utf-8?B?K0dERHJhcVB2MXlmZDJoQU1mWWN2ODNJcGUyMjBBanRhWWNiTG83cmI3SUxi?=
 =?utf-8?B?MkVLaWpwWm1wOUticTBiaXB6YVp4Qm9jYzNhVHhXVmRlMlpkY1dTTUxYMm84?=
 =?utf-8?B?QmM2TVNCWkdCaVlyQUhwS0Z6MVQ2eGVqWE1oV3p6SHZsUEsrUFBoMTNWYS96?=
 =?utf-8?B?b09xZGkzNUl6VjJmMmsrR09LcDJFRjVKOU11K2xTenpJSmRqaTNhMzVjdzJU?=
 =?utf-8?B?WnFIY2paY2pYUHc3b3RNcDJQU1dEMUNZbTgvMjdwZ0lnL1FJekQ2L0JoOEhy?=
 =?utf-8?B?WFJTRG56NFIrN2YrNmN2VGk5ck9kZ2RlKzZBeFJXUDFRa3ZZMUNIL2xFZEh2?=
 =?utf-8?B?US9OZ2NUL2lKcDR6UFRPa3puY1dsZnBqTWtmZXY3T3BVWTF4UVArQmVNQldh?=
 =?utf-8?B?S0tDZ0hWVFR4R1B3dzZOWmRKWVRIUWltQ21QZjZhbGZldW1zOHNVQ3FFeTdS?=
 =?utf-8?B?VVI5dld5bzZZSkZQTHRwZUJKbTc1RlprelRibVk1OFdWOGJ5Q09KU01sS3h4?=
 =?utf-8?B?WlFiNFFISXhwVW02VThrVkVPSmxpR1RSMWxRL3ZTMHZ1bzRCNStqVHkzZHhi?=
 =?utf-8?B?eHFueFdrODkraTEzeEx3MHRRYllMVTVTcGZoeEJxZUFoeDcrQmJsLzhYZUJW?=
 =?utf-8?B?RDh4T0lGUnpQYnNnV283bUx0S3Z5RUF4K1FQazhLcGh5S096THZKUGVPVmdV?=
 =?utf-8?B?U0RoT21USllZVzZlcXFhTXZZcUtCY1lOb2NUa1ozc1hOcDltdWk0dU96L1dO?=
 =?utf-8?B?NU44eXJjc1ltYW1hTWtORVdkak94bXJReWc0MHZzQmRYMVVyRzVIK2oxQTAx?=
 =?utf-8?B?UlVKc2xPUGJyNzJpTFNDYmFaSHlSc2Fsc3E1YmtKckZWd0tGMnNLOVp6RE5y?=
 =?utf-8?B?dnQvTG5WbStYeGgrRWRlL0JwVktYQ1l2OUE1Z1ZhKzB6NGhnb2tKbGsrNVRv?=
 =?utf-8?B?RmRva0tYd0kxMUlKVW50VVUxZ05rMmt0UmRqbmt1VlMwaDFMMGxQUjNRYmZT?=
 =?utf-8?Q?8KYEYqcznDdBEGmfqXmmdSkF7EyhQafyBRx92WN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B93D5F9C79B9F54981114C347DBF968A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0437c7f4-2120-4639-755a-08d92ee445a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 03:27:00.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTdbWU6vaJAOf7z6X4b2gQbWlgng384+MtgyAv5UE+vAyNXoCz7i4l5CB/8IGzoI8girW5gFw+fhS4G70xBjGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1349
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140023
X-Proofpoint-ORIG-GUID: N1KDN3HUx4q3aP90Gqy1RQIuZ70wWfL8
X-Proofpoint-GUID: N1KDN3HUx4q3aP90Gqy1RQIuZ70wWfL8
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSnVuIDIwMjEsIGF0IDEwOjE2LCBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEp1biAxMSwgMjAyMSBhdCAwNzoyNTo0
NkFNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDcgSnVuIDIw
MjEsIGF0IDE0OjUwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBNb24sIEp1biAwNywgMjAyMSBhdCAwMjozOTo0NVBNICswMjAwLCBHcmVnIEtI
IHdyb3RlOg0KPj4+PiBPbiBNb24sIEp1biAwNywgMjAyMSBhdCAwOToxNDoxMUFNIC0wMzAwLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4+PiBPbiBNb24sIEp1biAwNywgMjAyMSBhdCAxMjoy
NTowM1BNICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPj4+Pj4+IE9uIE1vbiwgSnVuIDA3LCAyMDIx
IGF0IDExOjE3OjM1QU0gKzAzMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+Pj4+Pj4gRnJv
bTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRo
aXMgY29kZSBpcyB0cnlpbmcgdG8gYXR0YWNoIGEgbGlzdCBvZiBjb3VudGVycyBncm91cGVkIGlu
dG8gNCBncm91cHMgdG8NCj4+Pj4+Pj4gdGhlIGliX3BvcnQgc3lzZnMuIEluc3RlYWQgb2YgY3Jl
YXRpbmcgYSBidW5jaCBvZiBrb2JqZWN0cyBzaW1wbHkgZXhwcmVzcw0KPj4+Pj4+PiBldmVyeXRo
aW5nIG5hdHVyYWxseSBhcyBhbiBpYl9wb3J0X2F0dHJpYnV0ZSBhbmQgYWRkIGEgc2luZ2xlDQo+
Pj4+Pj4+IGF0dHJpYnV0ZV9ncm91cHMgbGlzdC4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFJlbW92ZSBh
bGwgdGhlIG5ha2VkIGtvYmplY3QgbWFuaXB1bGF0aW9ucy4NCj4+Pj4+PiANCj4+Pj4+PiBNdWNo
IG5pY2VyLg0KPj4+Pj4+IA0KPj4+Pj4+IEJ1dCB3aHkgZG8geW91IG5lZWQgeW91ciBjb3VudGVy
cyB0byBiZSBhdG9taWMgaW4gdGhlIGZpcnN0IHBsYWNlPyAgV2hhdA0KPj4+Pj4+IGFyZSB0aGV5
IGNvdW50aW5nIHRoYXQgcmVxdWlyZXMgdGhpcz8gIA0KPj4+Pj4gDQo+Pj4+PiBUaGUgd3JpdGUg
c2lkZSBvZiB0aGUgY291bnRlciBpcyBiZWluZyB1cGRhdGVkIGZyb20gY29uY3VycmVudCBrZXJu
ZWwNCj4+Pj4+IHRocmVhZHMgd2l0aG91dCBsb2NraW5nLCBzbyB0aGlzIGlzIGFuIGF0b21pYyBi
ZWNhdXNlIHRoZSB3cml0ZSBzaWRlDQo+Pj4+PiBuZWVkcyBhdG9taWNfYWRkKCkuDQo+Pj4+IA0K
Pj4+PiBTbyB0aGUgYXRvbWljIHdyaXRlIGZvcmNlcyBhIGxvY2sgOigNCj4+PiANCj4+PiBPZiBj
b3Vyc2UsIGJ1dCBhIHNpbmdsZSBhdG9taWMgaXMgY2hlYXBlciB0aGFuIHRoZSBkb3VibGUgYXRv
bWljIGluIGENCj4+PiBmdWxsIHNwaW5sb2NrLg0KPj4+IA0KPj4+Pj4gTWFraW5nIHRoZW0gYSBu
YWtlZCB1NjQgd2lsbCBjYXVzZSBzaWduaWZpY2FudCBjb3JydXB0aW9uIG9uIHRoZSB3cml0ZQ0K
Pj4+Pj4gc2lkZSwgYW5kIHBhY2tldCBjb3VudGVycyB0aGF0IGFyZSBub3QgYWNjdXJhdGUgYWZ0
ZXIgcXVpZXNjZW5jZSBhcmUNCj4+Pj4+IG5vdCB2ZXJ5IHVzZWZ1bCB0aGluZ3MuDQo+Pj4+IA0K
Pj4+PiBIb3cgImFjY3VyYXRlIiBkbyB0aGVzZSBoYXZlIHRvIGJlPw0KPj4+IA0KPj4+IFRoZXkg
aGF2ZSB0byBiZSBhY2N1cmF0ZS4gVGhleSBhcmUgbmV0d29ya2luZyBwYWNrZXQgY291bnRlcnMu
IFdoYXQgaXMNCj4+PiB0aGUgcG9pbnQgb2YgYnVybmluZyBDUFUgY3ljbGVzIGtlZXBpbmcgdHJh
Y2sgb2YgaW5hY2N1cmF0ZSBkYXRhPw0KPj4gDQo+PiBDb25zaWRlciBhIENQVSB3aXRoIGEgMzIt
Yml0IHdpZGUgZGF0YXBhdGggdG8gbWVtb3J5LCB3aGljaCByZWFkcyBhbmQgd3JpdGVzIHRoZSBt
b3N0IHNpZ25pZmljYW50IDQtYnl0ZSB3b3JkIGZpcnN0Og0KPiANCj4gV2hhdCBDUFUgaXMgdGhh
dD8NCg0KSHlwb3RoZXRpY2FsMzIgOi0pDQoNCj4+ICAgIE1lbW9yeSAgICAgICAgICAgICAgICAg
ICBDUFUxICAgICAgICAgICAgICAgICAgIENQVTINCj4+IE1TVyAgICAgICAgIExTVyAgICAgICAg
TVNXICAgICAgICAgTFNXICAgICAgICBNU1cgICAgICAgICBMU1cNCj4+IDB4MCAgMHhmZmZmZmZm
Zg0KPj4gMHgwICAweGZmZmZmZmZmICAgICAgICAweDANCj4+IDB4MCAgMHhmZmZmZmZmZiAgICAg
ICAgMHgwICAweGZmZmZmZmZmDQo+PiAweDAgIDB4ZmZmZmZmZmYgICAgICAgIDB4MSAgICAgICAg
IDB4MCAgICAgICAgICAgICAgICAgICAgICAgICBjcHUxIGhhcyBpbmNyZW1lbnRlZCBpdHMgcmVn
aXN0ZXINCj4+IDB4MSAgMHhmZmZmZmZmZiAgICAgICAgMHgxICAgICAgICAgMHgwICAgICAgICAg
ICAgICAgICAgICAgICAgIGNwdTEgaGFzIHdyaXR0ZW4gbXN3DQo+PiAweDEgIDB4ZmZmZmZmZmYg
ICAgICAgIDB4MSAgICAgICAgIDB4MCAgICAgICAgMHgxICAgICAgICAgICAgICBjcHUyIGhhcyBy
ZWFkIG1zdw0KPj4gMHgxICAweGZmZmZmZmZmICAgICAgICAweDEgICAgICAgICAweDAgICAgICAg
IDB4MSAgMHhmZmZmZmZmZg0KPj4gMHgxICAgICAgICAgMHgwICAgICAgICAweDEgICAgICAgICAw
eDAgICAgICAgIDB4MiAgICAgICAgIDB4MA0KPj4gMHgyICAgICAgICAgMHgwICAgICAgICAweDEg
ICAgICAgICAweDAgICAgICAgIDB4MiAgICAgICAgIDB4MA0KPj4gMHgyICAgICAgICAgMHgwICAg
ICAgICAweDEgICAgICAgICAweDAgICAgICAgIDB4MiAgICAgICAgIDB4MA0KPj4gDQo+PiANCj4+
IEkgd291bGQgc2F5IHRoYXQgMHgyMDAwMDAwMDAgdnMuIDB4MTAwMDAwMDAxIGlzIG1vcmUgdGhh
biBpbmFjY3VyYXRlIQ0KPiANCj4gVHJ1ZSwgdGhlbiBtYXliZSB0aGVzZSBzaG91bGQganVzdCBi
ZSAzMmJpdCBjb3VudGVycyA6KQ0KDQpIb3cgbG9uZyBjYW4gd2UgdGhlbiBydW4gd2l0aG91dCB3
cmFwcGluZz8gT3VyIFVFSyBpcyBzZWN1cml0eSB1cGRhdGVkIGJ5IG1lYW5zIG9mIGtzcGxpY2Us
IGFuZCBzaW5jZSB0aGUgaW50cm9kdWN0aW9uIG9mIFNwZWN0cmUvTWVsdGRvd24gQ1BVIGZpeGVz
IGluIDIwMTgsIHdlIGhhdmUgYmVlbiBhYmxlIHRvIHVwZGF0ZSB0aGUga2VybmVscyBydW5uaW5n
IHdydC4gc2VjdXJpdHkgZml4ZXMuDQoNCkkgc2VlIG5vIGhhcm0gYnkgdXNpbmcgYW4gYXRvbWlj
IDY0LWJpdCBhZGQuIFllcywgaXQgc2VyaWFsaXplcyB0aGUgcGlwZWxpbmUgYW5kIGxvY2tzIHRo
ZSBjYWNoZS1saW5lIGluIHRoZSBmaXJzdC1sZXZlbCBjYWNoZSBmb3IgYXMgbG9uZyBhcyBpdCB0
YWtlcyB0byBmb3IgYSBSTVcgb24gaXQuIENvbXBhcmVkIHRvIHN1cnJvdW5kIGFuIG9yZGluYXJ5
IGFkZCB3aXRoIGxvY2svdW5sb2NrLCBhbiBhdG9taWMgaW5jcmVtZW50IGlzIHN0cm9uZ2x5IHBy
ZWZlcnJlZCBpbiBteSBvcGluaW9uLg0KDQpPcmRpbmFyeSBhZGQgd2l0aG91dCBsb2NraW5nIGxl
YWRzIHRvIHRoZSBpc3N1ZSBhYm92ZSBvbiBzeXN0ZW1zIHdpdGggMzItYml0IHdpZGUgbWVtb3J5
IGRhdGEgcGF0aHMuDQoNClVzaW5nIDMyLWJpdCBjb3VudGVycyByYWlzZXMgdGhlIGlzc3VlIG9m
IHdyYXBwaW5nIGluIHN5c3RlbXMgcnVubmluZyBmb3IgeWVhcnMgYW5kIGhhdmluZyBhIGhpZ2gg
ZnJlcXVlbmN5IG9mIElCIGNvbm5lY3Rpb24gZm9ybWluZyBhbmQgcmVzdXJyZWN0aW9ucy4NCg0K
DQpUaHhzLCBIw6Vrb24NCg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==
