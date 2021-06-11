Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE553A3D11
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 09:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFKH2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 03:28:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35868 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231410AbhFKH2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 03:28:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15B7HtlE028892;
        Fri, 11 Jun 2021 07:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CMkyUat4pUgpwaM+HKSRO5lXEWq0T10504FFytQlFiY=;
 b=K/UuE3oDcRrk3oKYi2BnEhaBXNQB4cQlZFTe2tDKx4AjvlSa2pgVwLbujpA4v/S5X/9o
 X3RvmlKVCalmJs9MUtHT795NBSKAApAPIIZK6lHOMm0wtyJapsFCzzmCMFRY3bBtZom7
 /CkoBFIeg14dNtsfkgzaqmgRHY/KBFR+VlzXykpst5v4z3UVFywh6KOBahf8s81ImCoh
 iEjUa8m8r265ieD9alK1tD2NNizb69MDE8ZNgStKMQXc0X4EAGjAJM6FZtrK+rth8WFz
 RZxlug/TFlo/zEkHXmtKlDmLv4z9fXlogT35BiJlOlndDbbAIUcMZ5pNanOngvW+WIoZ 9A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 392ptc8wfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 07:25:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15B7MLbO067034;
        Fri, 11 Jun 2021 07:25:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 38yxcxagyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 07:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGHldnMQKlhpdQE7Xwia7K3XKW3Zx88I/b7uoWKHOvFGHaQDk1Y5C152WXWSfAU3ttzhNSmCCK0sfCNJtXqSgKM1RuAVgGPwpfJH+d+UImrzWyywwOeAD47h5W1c42ufiVvPdew1+QBT+qphfpzMvyHNSOl5pnxn0CwnF7AyrPAylSUr3cWvl6v9HSBYJ08Gb6mRFCUFO/5S2J8s/ghyU30xur5iRSvM8hsvRv0UxwCdUTTTD+77+QscUm0nIRy42RPJmCdlJaBFht2ZJRLYakpJK5J2Tx08k7qdeEkQFTRNYIJMXphG0w0NxqiV6ZaEZmkZDb/pf6neFAIFg5RdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMkyUat4pUgpwaM+HKSRO5lXEWq0T10504FFytQlFiY=;
 b=elHpUHApWEefHA8KyVf4WkhKtSxHTaiVq55ekPN2YHV1Ed40Kcm++Icf4K1BFdNJOuMAZk4guzP2+CtnxTHo9qc4I1IwbN9eyN8PDHJKd9r9OBLCzubDKKdTB4uWgkb2M5Y98FZQAGYNCRhrgmhbNks8SYY0kSerIqgAuEhEhY4+MgNFwfiZXyiu1b5vAzIGjIBQTG8TUZc6BmXIyakcMw1W8cx3axKHyBxS4CmF+raPSqhLTTCNdL1mbBWrxqEA06wNvquOis7Z5mZ1Wf+Tnrl7Qb5RPf3AbxdcfIApjWviu2pY481YfN9SG1NKawq0CsaMOJWdG1gTHwnRUM8Pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMkyUat4pUgpwaM+HKSRO5lXEWq0T10504FFytQlFiY=;
 b=w+JYbjKnVm/XkqMGk2z9mhPirDjmtVKVQz98wNHrCFuRmQgS9d+qcULmMyQcMbhH9BICwHet32/S30po7nPLHUTbEwHOQnH7pspAzqPbQCZ5xjXNuLzFsEl76N/4CSiDZxDl0wZHPWU695Z2DRK8K+yhLOa0EgdtA9p++6gQdzg=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2405.namprd10.prod.outlook.com (2603:10b6:910:3f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Fri, 11 Jun
 2021 07:25:46 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 07:25:46 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHXW3XC7qLq8SZSTkiH41zCfEamxasIV9WAgAAefoCAAAclgIAAAusAgAXurYA=
Date:   Fri, 11 Jun 2021 07:25:46 +0000
Message-ID: <8685A354-4D41-4805-BDC5-365216CEAF40@oracle.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com> <20210607121411.GC1002214@nvidia.com>
 <YL4TkfVlTellmnc+@kroah.com> <20210607125012.GE1002214@nvidia.com>
In-Reply-To: <20210607125012.GE1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71585832-8e39-4945-2436-08d92caa2158
x-ms-traffictypediagnostic: CY4PR1001MB2405:
x-microsoft-antispam-prvs: <CY4PR1001MB240556C4F5746804A7BD7AD9FD349@CY4PR1001MB2405.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBBoAygkmBQCTPetqGTNYwseM6C0a3QvQ9d0DnH2oAGmPNSZP+k7vVdbOhjD8fr3gSc9T8qiiyjN33w2StlOWJRtd5u56+gas1XBXKFgV24P+2yh36+83I8+M9NEhZLHMZnyc8j06/q1mh7z4go9e44PM4FHyIGuyUyyk37AqJBASK6228YNQZf6vwj6h9N/sVvUhULJyDjV7SJ6lS8lYUr+S335Y/BIvsFsmKagU5oXjmL87VyPA1CfnwEexF9jxe6AsVXUf/yayv+t0bp6BgylYlnxU1G4w12zvBfDJnixzcmJy3b/rfY6dIywDBg0vBkWPyX/53uzPYzPsooZZPrYTGmEQ3XZRumw6llvUwxtjCCCJjEXG/5F3XMBpUMP3tSku4rxDCKjFQkbeiuUnV0gfrWkHuR6PyPJxEtbygpVGDVRVdqvv1zFUb3O/bYi8mzMuFUlCL7oESJ/lIyKJT9AU9jRaD4jMalkGkL91Qjc/1WPO0rCyZ695IA0dTIOGlXkzUFXZZqiHOHJDYpiHlU/uqB0PwNc53oio9uMcsApZgN5QN3DV6i/Di4hjbjM1GDFbvcky5GihzruvhptzcIlElYGJwplKBA/YE/n0kPIFbF1XdjRgpx7urOB9KTBpgpT+cqoOzlfere3XhKZSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(36756003)(26005)(186003)(8936002)(6486002)(44832011)(2616005)(76116006)(5660300002)(478600001)(6916009)(33656002)(83380400001)(66574015)(316002)(53546011)(6506007)(122000001)(2906002)(4326008)(54906003)(66946007)(64756008)(86362001)(38100700002)(8676002)(6512007)(66476007)(66556008)(71200400001)(91956017)(66446008)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WElpeWZCaHZPYU1FWHVpMGtsY203VTNKR3RQQWRaWUtSY2NXMWI4MlpWbzVi?=
 =?utf-8?B?VHN1TThOVkhuWEI2cHF3THc5dzYzUVpNS250d0htUnFDZDN2a09ZY0xzSjJw?=
 =?utf-8?B?ZmxkeFlLWFdod3dlTDBvSU1NWHpiRmpBR1AxdzYzdTJEUndiM3FpRkZVUGRH?=
 =?utf-8?B?eE5VQStCUlVwamJ1YWUzOHAvVVBOdW1rbVMwSUxpcTlPbXk2MXpQVmNDbXMw?=
 =?utf-8?B?Vjg2bStEOXFPZU51akl3SEZDUlNFSDlZT0hkeDdMdVB1TnM0MkNvMFc3WmRG?=
 =?utf-8?B?bEFmRnZVaTU0ck80U0FWQXhhZERoYWxPYTdpT1lCc3VLbHZJVnpSR1ZHMTBO?=
 =?utf-8?B?QzlNQmNCYjMzY0Z6cm5FQUN0UnJYWnpjanZRZXlqajJON0ZKalhhOUltekJM?=
 =?utf-8?B?N3pZQ3N4VU1mbGIxeXliV1lBY25rWG12VkNCQVU4eHhubG5aTHpZRi9NYUVv?=
 =?utf-8?B?YU9WaUJmNlU0dXVJd1ppNXptNlhGRXVqNTRKb2N4Z3RSS0U5QWZMWjVEZElw?=
 =?utf-8?B?aEI1c1NnSjhjWkQ5OTFNditLbCtxMUpXMytnOGxGR2k1VmU0bmRHd1RUVkxV?=
 =?utf-8?B?b3FVakpLZk1KckZWQXRlVi9TSHh6VW94WkRUR2tvcEIrd1JsL1FTZUlVcVFn?=
 =?utf-8?B?Z2RGaVBsdDJLWVowUk0rS1FaZzNRZDJqa2tjRG96R3NhVy9qQUkzZlJCd1Vl?=
 =?utf-8?B?WnJ2OVdLZlRUUEQrZGZpV01oUE5XVk5kVUV5R2txTlFOZ1A4VWl3N1FreHRl?=
 =?utf-8?B?NHZldlcvZzVlNVNrN3RkVzNwbDJad29XY1NjTHVnejE4ekZzTXlqZXRPMTNE?=
 =?utf-8?B?cnppUjRkd3ZZRlFuQ1FZSEp1ajYzYTF1TWhWWjNXRmgzai93UHc0K2l6Tkxz?=
 =?utf-8?B?YndndWdrTUxUZUxZS1BEVVZmM29td2s2cnR1N2QvcGllTWwxUEpkOFNwVzNv?=
 =?utf-8?B?Y2xUdEJLODlaYlpsaW1MYS9DaS90Qmc0cDNqQzlsbTRvclkzSUJxOEs2eEF4?=
 =?utf-8?B?WWRma1FlcXNEcjkwNENUVS8vZUViOVFXcmdYY1pwVVBJQWhxNXR6cUE5U3B0?=
 =?utf-8?B?a0JuN1JkdVIxV1VxKzBqOHVacGIyVEdzLzI0SUVPb1NVVEJtd2FNMkg1RU4y?=
 =?utf-8?B?Z0MrbDdGd21Wb1dOcURoZXQ3eTZiZysvaG81NnM2VzdSQ0VybDJQbGxla1kr?=
 =?utf-8?B?NGhLV1VUMFlDWkI1M1pkeDEyUmFsc2JwNS9KeFFmMGdxN3Jxay9RS0NrQzhn?=
 =?utf-8?B?TTlXcnlGTWhtckFzL2xBZW96Y3FjY1BXa2VaeFF5Uk9EbmZsQW9pMitESitM?=
 =?utf-8?B?MEl4TkJxTUNJWTdtREwxaEZaZmFNbDJ2c2VzM2czTXlzblZ3SE5rWjdNeFlJ?=
 =?utf-8?B?K2N6VFBWQ0RmQTRlclU2RTdGdEdaamNvV1g4MnVybVFYZHNLOUo1aDJldUxD?=
 =?utf-8?B?enMxZVlMK0h6a1ZMckkzZFBqUEt1aEZrVjAxdEpoV1c3VXEwL3dXZHNPeFhh?=
 =?utf-8?B?ZzIvL2dSaXRTUmFxUXlQNHI3MGk2Uk02cjhoMHZxTjIzMDVkc3hCRHZCSDZ2?=
 =?utf-8?B?aENKRXRxY1NGT2Y3cUZPYTk1QTRvb1NCVFdJaVhCYVhvbGVPSDRzTmd3Ujgx?=
 =?utf-8?B?WCtFbXU3SHZkYWpWaFdUL1lGN0lsYWM4MFRDdFpiZU1ITUYzdWx1c1p1VFRY?=
 =?utf-8?B?ZjdpR0pENmE4OVBmTmJuUG1MeTl4LzhrMWJRRjBHUTgwWHArWHZKZGxnaUZk?=
 =?utf-8?B?QVJpaG5HNmxudkZQSjIvNkFVS2RVc3I1ZWMrRHZtQU53ZXgrZWEzT1VNMkZW?=
 =?utf-8?B?YzR3UkxaaFBrV2g2YmZodz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0783AE6A5334944C8E5D957DFC4FACD3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71585832-8e39-4945-2436-08d92caa2158
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:25:46.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfejVyMqGX7je8vo8Ip+uEwl8d45xSsuS4Y/tvVzWep/vI1ShOmqSM8PiC5pRz+oDOULcAUhhQG7DFAPoz/zTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110047
X-Proofpoint-ORIG-GUID: Lu35C3htlG_rft2Ajuu9p4bvTasC86xk
X-Proofpoint-GUID: Lu35C3htlG_rft2Ajuu9p4bvTasC86xk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNyBKdW4gMjAyMSwgYXQgMTQ6NTAsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMDI6Mzk6NDVQTSAr
MDIwMCwgR3JlZyBLSCB3cm90ZToNCj4+IE9uIE1vbiwgSnVuIDA3LCAyMDIxIGF0IDA5OjE0OjEx
QU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+PiBPbiBNb24sIEp1biAwNywgMjAy
MSBhdCAxMjoyNTowM1BNICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPj4+PiBPbiBNb24sIEp1biAw
NywgMjAyMSBhdCAxMToxNzozNUFNICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+
PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPj4+Pj4gDQo+Pj4+PiBU
aGlzIGNvZGUgaXMgdHJ5aW5nIHRvIGF0dGFjaCBhIGxpc3Qgb2YgY291bnRlcnMgZ3JvdXBlZCBp
bnRvIDQgZ3JvdXBzIHRvDQo+Pj4+PiB0aGUgaWJfcG9ydCBzeXNmcy4gSW5zdGVhZCBvZiBjcmVh
dGluZyBhIGJ1bmNoIG9mIGtvYmplY3RzIHNpbXBseSBleHByZXNzDQo+Pj4+PiBldmVyeXRoaW5n
IG5hdHVyYWxseSBhcyBhbiBpYl9wb3J0X2F0dHJpYnV0ZSBhbmQgYWRkIGEgc2luZ2xlDQo+Pj4+
PiBhdHRyaWJ1dGVfZ3JvdXBzIGxpc3QuDQo+Pj4+PiANCj4+Pj4+IFJlbW92ZSBhbGwgdGhlIG5h
a2VkIGtvYmplY3QgbWFuaXB1bGF0aW9ucy4NCj4+Pj4gDQo+Pj4+IE11Y2ggbmljZXIuDQo+Pj4+
IA0KPj4+PiBCdXQgd2h5IGRvIHlvdSBuZWVkIHlvdXIgY291bnRlcnMgdG8gYmUgYXRvbWljIGlu
IHRoZSBmaXJzdCBwbGFjZT8gIFdoYXQNCj4+Pj4gYXJlIHRoZXkgY291bnRpbmcgdGhhdCByZXF1
aXJlcyB0aGlzPyAgDQo+Pj4gDQo+Pj4gVGhlIHdyaXRlIHNpZGUgb2YgdGhlIGNvdW50ZXIgaXMg
YmVpbmcgdXBkYXRlZCBmcm9tIGNvbmN1cnJlbnQga2VybmVsDQo+Pj4gdGhyZWFkcyB3aXRob3V0
IGxvY2tpbmcsIHNvIHRoaXMgaXMgYW4gYXRvbWljIGJlY2F1c2UgdGhlIHdyaXRlIHNpZGUNCj4+
PiBuZWVkcyBhdG9taWNfYWRkKCkuDQo+PiANCj4+IFNvIHRoZSBhdG9taWMgd3JpdGUgZm9yY2Vz
IGEgbG9jayA6KA0KPiANCj4gT2YgY291cnNlLCBidXQgYSBzaW5nbGUgYXRvbWljIGlzIGNoZWFw
ZXIgdGhhbiB0aGUgZG91YmxlIGF0b21pYyBpbiBhDQo+IGZ1bGwgc3BpbmxvY2suDQo+IA0KPj4+
IE1ha2luZyB0aGVtIGEgbmFrZWQgdTY0IHdpbGwgY2F1c2Ugc2lnbmlmaWNhbnQgY29ycnVwdGlv
biBvbiB0aGUgd3JpdGUNCj4+PiBzaWRlLCBhbmQgcGFja2V0IGNvdW50ZXJzIHRoYXQgYXJlIG5v
dCBhY2N1cmF0ZSBhZnRlciBxdWllc2NlbmNlIGFyZQ0KPj4+IG5vdCB2ZXJ5IHVzZWZ1bCB0aGlu
Z3MuDQo+PiANCj4+IEhvdyAiYWNjdXJhdGUiIGRvIHRoZXNlIGhhdmUgdG8gYmU/DQo+IA0KPiBU
aGV5IGhhdmUgdG8gYmUgYWNjdXJhdGUuIFRoZXkgYXJlIG5ldHdvcmtpbmcgcGFja2V0IGNvdW50
ZXJzLiBXaGF0IGlzDQo+IHRoZSBwb2ludCBvZiBidXJuaW5nIENQVSBjeWNsZXMga2VlcGluZyB0
cmFjayBvZiBpbmFjY3VyYXRlIGRhdGE/DQoNCkNvbnNpZGVyIGEgQ1BVIHdpdGggYSAzMi1iaXQg
d2lkZSBkYXRhcGF0aCB0byBtZW1vcnksIHdoaWNoIHJlYWRzIGFuZCB3cml0ZXMgdGhlIG1vc3Qg
c2lnbmlmaWNhbnQgNC1ieXRlIHdvcmQgZmlyc3Q6DQoNCiAgICBNZW1vcnkgICAgICAgICAgICAg
ICAgICAgQ1BVMSAgICAgICAgICAgICAgICAgICBDUFUyDQpNU1cgICAgICAgICBMU1cgICAgICAg
IE1TVyAgICAgICAgIExTVyAgICAgICAgTVNXICAgICAgICAgTFNXDQoweDAgIDB4ZmZmZmZmZmYN
CjB4MCAgMHhmZmZmZmZmZiAgICAgICAgMHgwDQoweDAgIDB4ZmZmZmZmZmYgICAgICAgIDB4MCAg
MHhmZmZmZmZmZg0KMHgwICAweGZmZmZmZmZmICAgICAgICAweDEgICAgICAgICAweDAgICAgICAg
ICAgICAgICAgICAgICAgICAgY3B1MSBoYXMgaW5jcmVtZW50ZWQgaXRzIHJlZ2lzdGVyDQoweDEg
IDB4ZmZmZmZmZmYgICAgICAgIDB4MSAgICAgICAgIDB4MCAgICAgICAgICAgICAgICAgICAgICAg
ICBjcHUxIGhhcyB3cml0dGVuIG1zdw0KMHgxICAweGZmZmZmZmZmICAgICAgICAweDEgICAgICAg
ICAweDAgICAgICAgIDB4MSAgICAgICAgICAgICAgY3B1MiBoYXMgcmVhZCBtc3cNCjB4MSAgMHhm
ZmZmZmZmZiAgICAgICAgMHgxICAgICAgICAgMHgwICAgICAgICAweDEgIDB4ZmZmZmZmZmYNCjB4
MSAgICAgICAgIDB4MCAgICAgICAgMHgxICAgICAgICAgMHgwICAgICAgICAweDIgICAgICAgICAw
eDANCjB4MiAgICAgICAgIDB4MCAgICAgICAgMHgxICAgICAgICAgMHgwICAgICAgICAweDIgICAg
ICAgICAweDANCjB4MiAgICAgICAgIDB4MCAgICAgICAgMHgxICAgICAgICAgMHgwICAgICAgICAw
eDIgICAgICAgICAweDANCg0KDQpJIHdvdWxkIHNheSB0aGF0IDB4MjAwMDAwMDAwIHZzLiAweDEw
MDAwMDAwMSBpcyBtb3JlIHRoYW4gaW5hY2N1cmF0ZSENCg0KDQo+IA0KPj4gQW5kIGhhdmUgeW91
IGFsbCB0cmllZCB0aGVtPw0KPiANCj4gSSd2ZSB1c2VkIHRoZW0gb3ZlciB0aGUgeWVhcnMuIFRo
aXMgc3R1ZmYgaXMgc29tZXRoaW5nIGxpa2UgMTUgeWVhcnMNCj4gb2xkIG5vdy4NCg0KV2UgYXJl
IHVzaW5nIHRoZW0uDQoNCg0KVGh4cywgSMOla29uDQoNCj4+IEknbSBwdXNoaW5nIGJhY2sgaGVy
ZSBhcyBJIHNlZSBhIGxvdCBvZiBhdG9taWNzIHVzZWQgZm9yIGRlYnVnZ2luZw0KPj4gc3RhdGlz
dGljcyBmb3Igbm8gZ29vZCByZWFzb24gYWxsIG92ZXIgdGhlIHBsYWNlLiAgRXNwZWNpYWxseSB3
aGVuDQo+PiB1c2Vyc3BhY2UganVzdCBkb2VzIG5vdCBjYXJlLg0KPiANCj4gSWYgdXNlcnNwYWNl
IGRvZXNuJ3QgY2FyZSB0aGVuIGp1c3QgZGVsZXRlIHRoZSBjb3VudGVyIGVudGlyZWx5Lg0KPiAN
Cj4gUmVwb3J0aW5nIGEgd3JvbmcvbWlzbGVhZGluZyBkZWJ1Z2dpbmcgY291bnRlciBkYXRhIHNv
dW5kcyBqdXN0DQo+IGhvcnJpYmxlIHRvIG1lLg0KPiANCj4gV2hhdCBnb29kIGlzIGFueSBkZWJ1
ZyByZXN1bHQgeW91IGdldCBmcm9tIHRoZSBjb3VudGVyIGlmIGl0IGhhcyB0byBiZQ0KPiBxdWVz
dGlvbmVkIGJlY2F1c2UgdGhlIGNvdW50ZXIgaXMgYWxsb3dlZCB0byBiZSB3cm9uZz8NCj4gDQo+
ICIiVGhlIHNlbmRlciBzYXlzIGl0IHNlbnQgNyBwYWNrZXRzLCBidXQgdGhlIHJlY2VpdmVycyBk
ZWJ1ZyBjb3VudGVyDQo+IHJlcG9ydHMgb25seSA2ISBJIGd1ZXNzIG15IGJ1ZyBpcyBhIGxvc3Qg
cGFja2V0IGluIHRoZSBuZXR3b3JrLiIiDQo+IA0KPiBKYXNvbg0KDQo=
