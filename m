Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA23B4781
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYQlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:41:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhFYQlg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:41:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PGa1cJ025926;
        Fri, 25 Jun 2021 16:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5S0tVOtNYHqg3VR5VtxinYsx9vz3WTw24R43+XiXNBE=;
 b=jSUQFg/gLV1z6xKLJJyUqe54aEKlYbIryye3aazRe/InyCRBwoSGqL4Qpk6pY6uLdHpn
 GvgW4xMeGZtzvoNo+LQmnzj26+2D5DiR7pErazLS4ZMGvD5sTGqnwNtO7488jWyfpaUa
 ryPDh/QRwmLjUY8oFFHHM/aOVKFae/R9a60/8L1j6r3zsYU/SsP/vOPPUe52CPckf0M8
 60RCN9FvxLa24dL/rpumu7jqL7LkJK6QnelbsZ/x6SkxJLpm3a0/M4sI5sonPKiWk057
 6hWE6h4hqCbPhZzI9HW89zFxjTxtIyOmtBW8+cqVgbY0my4WKNIGSYhf0MpoOEkql8Ld Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2kxsrd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:39:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PGZSuf129778;
        Fri, 25 Jun 2021 16:39:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 39dbb1p8rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 16:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWwVFgwlZeyo+bBIkzNaUf3TX1VvVXnoT+KyjYpB8E4cumr1UuJfuA5Pu652fUFQO6RzxsQXQt16yg9qd1rE6XBw9JpRsle5Mz1LZjwI3ZS5C+pIucvrW5r8HrNZhAQBdkT17y/wZb8yNSfR9pZyE0xcHqstPuzaKaycOkQYLiFaVqvHNGK1F0CkdpIeDmF+5E67qVmOLzFkLJOn6ZLXnAISoe210nDog+7V5PFmsR89mUGpzSBi760On/pE2A6LDXXGT3xle2H1PpiIi9PilL087u/rJYnfBchbzS8gRwXsxrYw6mVccbxb3U9Ff0fLvkEjU4oFBLm/nUJOS3Gbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S0tVOtNYHqg3VR5VtxinYsx9vz3WTw24R43+XiXNBE=;
 b=MKUwUf2rJKJkwky/+Pj4Uf+kFoHlkHcsieP/LxgasEAmIOWGGo9fK57BnbL2px/+jUqv7lp9y7DE8aYxaG36vILu2zzGNfBjYsw8iPKMmkrbrXAJfn9ehub3RXYwtIFWL6JpQ8BPxmTPsJVucLU5ZVgSKY1zxWTaRVfukSADAaWWkIu+1gx65yOcRXKzlvNTVkycTmPVc7BM1pmsu0Ps4IDFkECTznjEkPf9pU2Q8WUHMeLLNc/+UpA87XDTDPPqoQfDwczJr/a2C1iC5M0M0K5RuTF+2b09G9yBT2f4FFAiEoEMisWAGbb0viXEU6dcia/7fk6yfYKFNegsAYgY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S0tVOtNYHqg3VR5VtxinYsx9vz3WTw24R43+XiXNBE=;
 b=CfEF3rORifNGzUD5s2foHb5z3JEhBrEh6ZA5bG9Ugz6SMFC2J5tGzgyvVjYAAH2y3hbyrtMV6POltx5O9TMFylNFMExmL+f3Bp/652DlySgQyhJi2cSbu/Mpj0pGb8UVzfcmybrYfsQPZ+FSP/zwqCGrD5jTxJU+dawX2+wfbl8=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2182.namprd10.prod.outlook.com (2603:10b6:910:48::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 16:39:08 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:39:08 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc v2] RDMA/core/sa_query: Remove unused argument
Thread-Topic: [PATCH for-rc v2] RDMA/core/sa_query: Remove unused argument
Thread-Index: AQHXab4CDaSnqBom1Eiq1ts3cM663askzeQAgAAf2IA=
Date:   Fri, 25 Jun 2021 16:39:07 +0000
Message-ID: <4F6E15E8-A145-41F4-A393-CAB8EBC3D850@oracle.com>
References: <1624624257-3677-1-git-send-email-haakon.bugge@oracle.com>
 <20210625144506.GB3001725@nvidia.com>
In-Reply-To: <20210625144506.GB3001725@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a4eb4ab-c5e3-4d8d-4ada-08d937f7c0ca
x-ms-traffictypediagnostic: CY4PR1001MB2182:
x-microsoft-antispam-prvs: <CY4PR1001MB218272C6FD0DDA3E74D29474FD069@CY4PR1001MB2182.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzzviEEFQv0ltW9QD4pWImDehf2BTEvX5r9BYLYj03RViRmpPIlNRO4dnjkUgB7gftk9Zs9VmwzPT/kWNDi6MkkHDRQYRpgY4PNceeh3biez5Eqq/LqMjcI9rpDfme/QhVLaliRKo67Zb8c3EgRg6Y1I602ViDG7C8rLhljJWtRS/wNwpy87tzX1ozOZXxNc3RiwuM1bS/uO5V8WTE7i1Y2PyMaTQ/stIkf6TUpW0hi/Z1cjETwXjhpBaS4BsTAW6iAS1DtlV5YAKl3b/xwVnLBqQtExMwWV1yqcrQwo7SIPXbsrX4jpy9WyK3O68T3t2Gqb0M6Mp7Zw7CfpxhmkYrRwm+feG6FrLhC8PXNf9MZT957M1uAEidYM9VP7lY5E2BRVQpgHDsqdpObXIsRSgYvoS1P4S5ftnq2KfHf8wWeoMRSV0+RcfIJdCvE2QvWNNJMdOezYT7D71u7gW2z+d1drxnMv5HwV+U/gXZ4MP3VBcvP/yuY0MbF+2BrybUIUAYO/9SMXkT4RXfI5rek+PmSjYLOaXJIqaSS/ooo81SPzsPrjufK8uhxMLDQxOm2WJE6SuH1WEVnFkzNH60oZn9W85b3HrEHRt1Ul6OVSzzSJF5oI2i+6SrR2Q+DMwAshvuMDILcRItcgd4RmhO+S/EDtjqQeD10ciKzFA0Z098A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(8676002)(6512007)(26005)(8936002)(33656002)(4744005)(38100700002)(478600001)(6486002)(83380400001)(36756003)(122000001)(316002)(2616005)(76116006)(44832011)(66476007)(66446008)(64756008)(6916009)(186003)(2906002)(4326008)(54906003)(86362001)(71200400001)(66556008)(6506007)(5660300002)(53546011)(91956017)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTVKb3prQlg3YzY4eUt5cG1JdjhtNXo0OG93Z3RUeEpZdjRTV0QyNnhRWm5v?=
 =?utf-8?B?dVhGdm5INitsNlpIcUllOW5Fdko4VWwvVnkwL1dRbUdrcEQyRUVmdmppeUoy?=
 =?utf-8?B?T1hkbDJoL0p3eHNOTGVDNldvSmxiZkV0dzFaZ2dEQ2QxYUhxVWZoTmtySWZu?=
 =?utf-8?B?Mnd3V1lRcW5lUVVrZU1oQWtzK2lXZzBGT0ZlVXMyMmwzSU9iQndIRHlIS0JQ?=
 =?utf-8?B?aXdzaGxFUGhjcytPNlFmemIwby9HOWdKVUVpU0NVdTA2WXJaYys1UTBySFVN?=
 =?utf-8?B?ZGdtc09SdDBwY0RFMlpidVZKVGpXQlFPODdTYW5neUthS0NNOEVTWEJKc2k4?=
 =?utf-8?B?b2szTWJ2NjVHRURwdm51U2VzeHBqbGJabklFb2VWSjZGRVRJbnk2aURoblBB?=
 =?utf-8?B?VmoyaEttQm1yNkVRaFdZVlB6SmJmV1VkZnBLVzJSSTFRYlY3bWhhQ1U5Yjhv?=
 =?utf-8?B?bzI2Y0N1bzB6SjJaMHovVllVOERHSStDRXRWKytyekw3YjZVVzNNK1BZdWRN?=
 =?utf-8?B?Mk1Nb3hPRVBTRGR2SzgwbUlDYWw2eEk4Y25CR3dPbi9MU2h2QjdjS0Qyc0RD?=
 =?utf-8?B?VWJGS1hjUHZLN2N2L08yV3NyS2NVcXM0TUdQRStHVGpKeUFKSmFsWElhTy9P?=
 =?utf-8?B?aWVEK2JEQ3haQUxtMWRBVXdTMXdyZEl2a3IrZ3BKTjdvNXpyVCthUzJCN1hM?=
 =?utf-8?B?NW5TeExJZUcvWnlPT3NTSXF6WWZ1SEh1YSt3cWVFcDNEQWtnZVdjMHlLMWtT?=
 =?utf-8?B?WDljSVAzSDFtSmtNeGVXRHpRenhQM2owUW5wWkprWGswSnNBNTJzQXNWUEJO?=
 =?utf-8?B?ZURrMFFjZHdldVFKMDh0UVp1NjZpTWR2eDVkZHA4Tkk0M1ROOEtxU2tzNGlz?=
 =?utf-8?B?ZDR2UURFbzk0eTJad0JJb25KaFg5VEFSNVBvZVJhWW0rb2VvR1R4b21xRXhR?=
 =?utf-8?B?OWQ2bzMxTXBFNGlmNmQrdUZnUWJZMFpHRVplY0p5OW9yMkV1bklFVGRHSHZG?=
 =?utf-8?B?amRSRWIybDFFd2Z6RTkvQmgvQXFxRzVPaGFnMDdxelBYL1VPQ2dOd3ZPWFpv?=
 =?utf-8?B?T2lwMHM4Q0l6bTZHWjdSSjZtQk1VVFNpQnpiUmlIVVo4cFpMVUhxemtEMDVK?=
 =?utf-8?B?ZVg5bnpOaWZlSDNETERlT05Fc2RzSklqNDJFZGZpYkZDVnEyVm9XZkJRYVlD?=
 =?utf-8?B?R0duclhzNE9LU2RFNjEwUVJSUUIvOGZhbWQ5dVFiYzRrUmp4RnNiSHpoS0R6?=
 =?utf-8?B?YWd1SWZsWWtBQjdEcmhESE85QmJMUCtlTEVXZ1RkcHc4VFNKNHVZWmpmYmdS?=
 =?utf-8?B?UGs2dTVDcE8vVEVxd1ZzeGx6Z0pIbWRGT3hCVGd6MyttM0gxY1M5OCtRbGlE?=
 =?utf-8?B?QjBUUzh6UDBQRFc5YkxUSFpMVlJUNWVId2hFeEVNa2V6TGw5ZU14U0pJOWsv?=
 =?utf-8?B?ckwycHkvYUdGTHN4Yk1nbERtbzNpNkp4SWRmcHVUK0dLeE13Q2g3RVZKWHMy?=
 =?utf-8?B?Z1VIV0Y3K2ZQM2NkdmxDc1B2U0J2RTdKOWJ2eXJ0V1JNbmREd29IVGdHZHJT?=
 =?utf-8?B?Q0ZlclVsMzZmZlI1VHpuNDFyd0dKWDMydHVNNlBHaXpvRVUxRFU0Y2VIVS80?=
 =?utf-8?B?ZmhnN3JKVlpoUHdrMnlMSHdtMTBZYnRCcXJDRzh5QzFENndHWnJGWGlrVVo4?=
 =?utf-8?B?ZE1tUU96L1E1UjRETFhMNUhDQzFyZVJsQXhWNHBlVVBxcTU2T2RnWHlaZXhZ?=
 =?utf-8?B?dFliSEpHR2pLRk5HWmFsRmZaS0t3d0l2dHlnSTgzdkt2V0d5d3JTcFIxSDFt?=
 =?utf-8?B?OEgraGlGL2RDeldsTEpEdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6654E9EC06E7B6459D837234893BF22B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4eb4ab-c5e3-4d8d-4ada-08d937f7c0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 16:39:07.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNysNa0LoiXHiFG6dT6QMOwDke+vbr2zGKOACOhJ1kNYIx+Qip86e3o1tn743HEHcj6mSbGewCLJDmtjQGAnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2182
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250098
X-Proofpoint-GUID: 3mfmbxKf5ra7GtQfnAx28x2mbZUt7m13
X-Proofpoint-ORIG-GUID: 3mfmbxKf5ra7GtQfnAx28x2mbZUt7m13
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjUgSnVuIDIwMjEsIGF0IDE2OjQ1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSnVuIDI1LCAyMDIxIGF0IDAyOjMwOjU3UE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEZpeGVzOjRjMzNiZDE5MjZjYyAoIklCL1NB
OiBBZGQgc3VwcG9ydCB0byBxdWVyeSBPUEEgcGF0aCByZWNvcmRzIikNCj4+IFNpZ25lZC1vZmYt
Ynk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IA0K
Pj4gCXYxIC0+IHYyOg0KPj4gCSAgICogRml4ZWQgbWlzc2luZyBzZW1pY29sb24sIGFzOg0KPj4g
CSAgICAgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9zYV9xdWVyeS5jIHwgNiArKy0tLS0NCj4+
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBB
cHBsaWVkIHRvIGZvci1uZXh0LCB0aGFua3MNCg0KVGhhbmtzIGZvciBhbGwgb2YgbXkgY29tbWl0
cyB5b3UgYXBwbGllZC4NCg0KDQpIw6Vrb24NCg0K
