Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7504D3AFD8E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhFVHJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 03:09:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36000 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhFVHJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 03:09:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M6vL91023270;
        Tue, 22 Jun 2021 07:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PJH5RCyxVS61zee9x9D3boyt11J9ZF9wv28v4cJ2QnY=;
 b=KB7kC/EmMFyGXaX64OjjQBELFz4BNUH2rCryht51gPSjyQGL5EJ9kBMHklBrj5EJl5zS
 YpBOGU/UEyTmNT4sQvADd7l2Ix5VrGG62Pc/36tU1QHkfSJsg5OatiE/7cyrh5vT6wrK
 AVB8l3Sri2Ih9rjycoNKK7/IFfJpOns9A+eKeg2ka2lJ3VlH6UpJhQ/LVJsYl+xoKxYq
 jjneQSWYZMmVz/OD672KVFcJwZ4Ne2jnZmeTAxf0ecg4tWv3jo+/ikQJV+8khakA6Yys
 cyoJ7D5dW/D/OEXmpYpi5Ik758cQf5k1Oe1ay7Szu3D8LlJZrpjV2t9MXQWlREKDIXoI JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39as86t1ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:06:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M75CAW038113;
        Tue, 22 Jun 2021 07:06:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3995pvrp0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxCqKPahoKvyqa1k9/ankCI/2ui4Yy3fj7GrbtJX+IdBwTAN0JY+LUgUD1jGJc6t2908PwnmPiI4TQ/ZKnTV0m+BM0efIE4nReH/NpfaIfbq8Bd7o2LC1dif2ph/PDNTA7SG9YXibVXX9Tw3XxigJYdf1L2ynjanxmfIW1HPlWq6bPmvMVl1X3shVxga14w6Jx1xVLHU09AoX1H738qCoLEtaTNIfykgx0gj2ZE6Ohm/ZdQkzKCnPJRUBgL+BJlAE12lJfLGsJv3FKiBJkNLp9F4Qvo4Q1rAvxgxjb1fW4CdTDWXCeZkj0xSZLpBlpKWTWvhDY4ACB/voFN7grPgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJH5RCyxVS61zee9x9D3boyt11J9ZF9wv28v4cJ2QnY=;
 b=Bjt8wzWzks1sK8fz4mkyDRG1x6yld647TCfomfhiX9HfIi/uj5lb3hNKu6MweaYbIA8ZbCJZFsqU11pwP0NZoh28u9Nl+e6M1yLE+ANwH3Jtoa6J6j4mPL518An8VbjaChJGg6x2ew201BngU0FZsw2n7d8K8QcpUATIYJUEOciWzV9RIlqUlai3Rs+urAdWZCggsqHPKAsgayba+hgrfvtzBC8ChR5kJ7mWD4Zw95pxpoh5KwHJfPxygpDT01hoIjqd5bq1tBT53YrGLaJPObwZ4zG+yJ9P2Tt5EXbbgPwTCPrxK+gXdDmHP9q6iQUsP6DMI9A3BiQtaKC+lTEh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJH5RCyxVS61zee9x9D3boyt11J9ZF9wv28v4cJ2QnY=;
 b=DbOFl9sxHbN3SJGy3kNDnEsx1FxOAcpf6PtNzjLTzZDklBvdg0gDUPO9Z2rTxWAUxe4w6+dRNZQE0oCDqmV5ZTi2Adc4MK1SJ/jw86PXSMxJiJ3h3Etxj31X7l25OKY3BOx6Z7fe/KF3fRLvLpuM7C4so0PmqaBMEfb79tgiB1s=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2390.namprd10.prod.outlook.com (2603:10b6:910:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Tue, 22 Jun
 2021 07:06:37 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:06:37 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXY3iqQ+lwecvXsUKE5x7HSp6gYKseEhgAgAAToQCAABoOgIAADqSAgABAsgCAAAXOgIAAA+QAgAAMAoCAAPB9gIAADggA
Date:   Tue, 22 Jun 2021 07:06:37 +0000
Message-ID: <0D40D447-2320-48DB-8053-4D487A6F25FC@oracle.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal> <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal> <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
 <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
 <20210621151240.GQ1002214@nvidia.com>
 <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com> <YNGAN4eGYXkrFMCg@unreal>
In-Reply-To: <YNGAN4eGYXkrFMCg@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 596a9c09-b119-47e1-dd7c-08d9354c46ce
x-ms-traffictypediagnostic: CY4PR1001MB2390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB2390B971C2723F745EB6E67EFD099@CY4PR1001MB2390.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qusNNmOChOaJpHb2xBx9tAt8I+NPOD7xnQe4+ZfUwGnwHi4ZRww/I+ZOHTITCZuRG76QNv9dyAxdGcebWljO4QPwJvzDLiNQzitDYMIId0H00ilyP7YgEKkkPOdi+im07n3dgMklqis6xJ7AXSCrrJIMgCIT0p5hreAEqJdSOJoQ8luGGu+JqZnL21g3ji7adOgTV6shOALfVTU4KAdwubtTA5kg6y6DM4fCENVquqKE3ilgwjwPQVUD8Hdng53kF/YHLrU+CT9l6g1LSXxOUn/7EhgvtIR5UIrPRN2q2PjOQV7QArg4kviGynVRkrV4KA+SrUqHcdM/A8pTGOkdGe2XFGTADqm/y6RUiMhrHu5LJQbEx83AcBzcVviqTozMB/KkpHtUJSrB8dmQjzFxX8yQqMpAXwuccBjURsarYZgMWdFdR+hBIZLTqyDKJFDzj32fu6RC3C7A0BiLp+OhpwbwK53+A5Yc8ztZ41O3KXM9OPQ9CDTAOY0FXznHILWQy6x3XM7eQ+Z1K3ECGcjicvZso/obDLtHsJk9rICs1/h0/duC0wFR2tMCkEQMOTGD04Hh0uEGEpf0UeCdoZinjLt13rlFAvpb9qidAHt+xbOaCuBeXsNDgYyeirfunTA4PWiaPspyZX6l+WblTqYqQ9/2kzcfy+d9miwoIlli02firqI8sDWyDqIQHK1gcnHxUb/bAVwTyP6tcoL/fRoPfB6zWjK6nCzaJRfoVUZEbVX0iV+xdo/QlE4vzd60DtAGxMsqMwWiaL3CKUsyTRUtwg4tFc1mj8ONl27KLiXlTeCIfB7h2tiiyz8zSm3Ugqnn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(53546011)(6506007)(2906002)(122000001)(38100700002)(26005)(8936002)(5660300002)(8676002)(71200400001)(54906003)(186003)(2616005)(316002)(66574015)(966005)(4326008)(66556008)(64756008)(91956017)(6916009)(6486002)(6512007)(44832011)(107886003)(36756003)(66446008)(76116006)(478600001)(83380400001)(86362001)(33656002)(66946007)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVBTm5SWkh3dXpsbzdPWml1eEFsY1BQY0tHcHlIUkZoSnh1ejBtY2c3NEM1?=
 =?utf-8?B?eGFDNUU0YUgzOVpKS3lxZkRmZS9mQ3JWazBsYkg1V3ordTdzNVJLaDlLWDFR?=
 =?utf-8?B?bUY1NVVGK3M2VDRqTXZCMlVwWitMNUZkNk5UeE9Ua2ZvamhFQnFFbENmcnd3?=
 =?utf-8?B?NmZHYUNnU2o0NGFRS0JuelYyMVdmclhPd1VlSTBJb3RYbGJTOVRFalIzN2dx?=
 =?utf-8?B?ekNFYlNiR1lwQnRNSTVZdXl6bmp5dmdSMXNDVTd3Uy9pK3RYSUMxWXlQOHRP?=
 =?utf-8?B?RlJ3NitDbFl2Tkk4SjEzRzdJNU5SUHNiL0lid0gycEM2bXpIOG9mcGFWQ3da?=
 =?utf-8?B?ekpEUGRiUU9NSDZEZkdLd1hBRXZOMUtQMk00ODZNdkhIYUw4a0FYQ0J5aVhT?=
 =?utf-8?B?ampNZzFRSVpodFpzZFBxUmlhMk1NNjAxN2o1cThHSHZERUxmYkpJUlZIdk92?=
 =?utf-8?B?YkhobkROT3NlQkZ4MjhweFpIOFUyZ21acHVNWGpnUkQ2MFlKRVpsWVZ3b0Jx?=
 =?utf-8?B?T1pBeXNlLytYZE5tL1Z4Ty9udG51NkVCdERVQ01DamdSQUlIWkJLTkNuZ3My?=
 =?utf-8?B?ZUpyWUNTc0FUekpEbTd3bisrcXh1akd0OXJnUGlCYSs4clg1bEhpWnpJbXk0?=
 =?utf-8?B?UXFhL0Fud1RYNDNRdFFubDQvYkkrY29JdlNmV0hrMUxUYytJdGJaTGtQcjFM?=
 =?utf-8?B?d2FOM1YvalZhNHd6cTRyQSt5dmhQSTdYZTRhTXJBNDlVV0wwZlgxWjlKN2pW?=
 =?utf-8?B?NUF0M3ZodjdDb0xnQlVncHZhOTJ5UWhVWEFLbktQQ01aSkJCR1RRSHRtd25D?=
 =?utf-8?B?UkE4Q0lHOCsyVlovMXExVlFLVVY2c0ZjRVBFNlBTbTczODVEVHU2RmcrWkU2?=
 =?utf-8?B?WmJhZlZrWmpYcEtLc1c1YjFIRmRMVUpNV3VPcGh4VjJGend1MWx0RDVtTFpS?=
 =?utf-8?B?M1k3K0pBZmR3ekd6UGVwZllZN2pMbVlWbzNFYm1SMmJBZCtVcVUrTnZhTDcx?=
 =?utf-8?B?T215NHdOVmdXejJxbkpkK01sSjdEVE5rWWYxWlJFK3hUaE9RYXd4NEtXYnhB?=
 =?utf-8?B?VEtpMXRWcExmZGtRTXh6VXZsbUwvc3F0QTZraGxRQnpUWjVBQWl6WWF6YVYr?=
 =?utf-8?B?YmRyUWVPb3ZMN05zSkpSWHd6MmoyTWZkaWFSV2lYMFY5cmtVczRzUzA1cGlP?=
 =?utf-8?B?TDFhVXowZzNDWHdWSFY3Mys3RU9wMWFSS0xQZ2o0anNsNG91YkNZaW9IbU5H?=
 =?utf-8?B?dWNIWWpRRTFaOTVOZkZOeU14MFhZbTBpcWhwN29CT0VrREhrYThRYXZGL2tG?=
 =?utf-8?B?eGtjejdpVGd6UDh3bHIySlYrUlMvL1FRRjFJUGxtQzYxL3JnaGZTQXhwaHhk?=
 =?utf-8?B?UVVOaml5N0J2TDU3aFBqSnhDeGtlWkEvbWswb3pnZFZBTEpwdHFvaXBEM25y?=
 =?utf-8?B?eVZHc3Y3LzM4L2s1KzR1bzN4clJoRHpGQUZJWXVBMEtHUWhOaUVpM2g3Vjhx?=
 =?utf-8?B?ZUQ2UU9iYkt2cUk3T2dSZXkxNXNlZXJ1bGU4bDVrWkFsdkhCeVhld2RqWnUz?=
 =?utf-8?B?ZzdRTzNVODBGdS9FRU1tMTI1cjIvNFByeW1OT200cWlLNW5xTDJBT2pPQ3Aw?=
 =?utf-8?B?L2NxMTJ0d2d1SytMNTY5alppdnlzR3liTmdkSStzWVp5NmlYRFpZU2ZSRDhD?=
 =?utf-8?B?WlFEY1Q1TS81akZXT3dHc2g4aCtEdUVZRFdLdDZ5SVJLb2lKSE1sTTY1S2Fr?=
 =?utf-8?B?S1hCVlZOa1pNRnZjRHcvMkdHbmFnUkVseGJwUDNCSXRiWGJjeWtQUU5UYUVF?=
 =?utf-8?B?dDdwd3FXaUZKV0RkN0dqZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB2A81F09FE9B9449C512B070C165651@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a9c09-b119-47e1-dd7c-08d9354c46ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 07:06:37.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUcF5qD36B9m0kwfyy7YiTubf1K5kexCfOTzxtjR5ufIeHI3ztkQZAdO8e4cUNOz3Xy5gr97ckzCSpZ44bHNPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2390
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220044
X-Proofpoint-ORIG-GUID: oJmvcSthgg-cRQDZpSzfL_vjJF6j4ybG
X-Proofpoint-GUID: oJmvcSthgg-cRQDZpSzfL_vjJF6j4ybG
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDA4OjE2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAwMzo1NTo0MFBN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDIxIEp1biAyMDIx
LCBhdCAxNzoxMiwgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gTW9uLCBKdW4gMjEsIDIwMjEgYXQgMDI6NTg6NDZQTSArMDAwMCwgSGFha29uIEJ1
Z2dlIHdyb3RlOg0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiAyMSBKdW4gMjAyMSwgYXQgMTY6Mzcs
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBP
biBNb24sIEp1biAyMSwgMjAyMSBhdCAxMDo0NjoyNkFNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3Jv
dGU6DQo+Pj4+PiANCj4+Pj4+Pj4+IFlvdSdyZSBydW5uaW5nIGFuIG9sZCBjaGVja3BhdGNoLiBT
aW5jZSBjb21taXQgYmRjNDhmYTExZTQ2ICgiY2hlY2twYXRjaC9jb2Rpbmctc3R5bGU6IGRlcHJl
Y2F0ZSA4MC1jb2x1bW4gd2FybmluZyIpLCB0aGUgZGVmYXVsdCBsaW5lLWxlbmd0aCBpcyAxMDAu
IEFzIExpbnVzIHN0YXRlcyBpbjoNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMDkvMTIvMTcvMjI5DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+ICIuLi4gQnV0IDgwIGNo
YXJhY3RlcnMgaXMgY2F1c2luZyB0b28gbWFueSBpZGlvdGljIGNoYW5nZXMuIg0KPj4+Pj4+PiAN
Cj4+Pj4+Pj4gSSdtIGF3YXJlIG9mIHRoYXQgdGhyZWFkLCBidXQgUkRNQSBzdWJzeXN0ZW0gY29u
dGludWVzIHRvIHVzZSA4MCBzeW1ib2xzIGxpbWl0Lg0KPj4+Pj4+IA0KPj4+Pj4+IEkgd2Fzbid0
IGF3YXJlLiBXaGVyZSBpcyB0aGF0IGRvY3VtZW50ZWQ/IEZ1cnRoZXIsIGl0IG11c3QgYmUgYQ0K
Pj4+Pj4+IGxpbWl0IHRoYXQgaXMgbm90IGVuZm9yY2VkLiBPZiB0aGUgbGFzdCAxMDAgY29tbWl0
cyBpbg0KPj4+Pj4+IGRyaXZlcnMvaW5maW5pYmFuZCwgdGhlcmUgYXJlIDYzMCBsaW5lcyBsb25n
ZXIgdGhhbiA4MC4NCj4+Pj4+IA0KPj4+Pj4gTGludXMgc2FpZCBzdGljayB0byA4MCBidXQgdXNl
IHlvdXIgYmVzdCBqdWRnZW1lbnQgaWYgZ29pbmcgcGFzdA0KPj4+Pj4gDQo+Pj4+PiBJdCB3YXMg
bm90IGEgYmxhbmtldCBhbGxvd2FuY2UgdG8gbmVlZGxlc3MgbG9uZyBsaW5lcyBhbGwgb3ZlciB0
aGUNCj4+Pj4+IHBsYWNlLg0KPj4+PiANCj4+Pj4gVGhhdCBpcyBub3QgaG93IEkgaW50ZXJwcmV0
ZWQgaGltOg0KPj4+IA0KPj4+IFRoZXJlIHdhcyBhIG11Y2ggbmV3ZXIgdGhyZWFkIG9uIHRoaXMg
ZnJvbSBMaW51cywgMjAwOSBpcyByZWFsbHkgb2xkDQo+PiANCj4+IFllcywgZnJvbSBsYXN0IHll
YXIsIGxrbWwub3JnL2xrbWwvMjAyMC81LzI5LzEwMzgNCj4+IA0KPj4gPHF1b3RlPg0KPj4gRXhj
ZXNzaXZlIGxpbmUgYnJlYWtzIGFyZSBCQUQuIFRoZXkgY2F1c2UgcmVhbCBhbmQgZXZlcnktZGF5
IHByb2JsZW1zLg0KPj4gDQo+PiBUaGV5IGNhdXNlIHByb2JsZW1zIGZvciB0aGluZ3MgbGlrZSAi
Z3JlcCIgYm90aCBpbiB0aGUgcGF0dGVybnMgYW5kIGluDQo+PiB0aGUgb3V0cHV0LCBzaW5jZSBn
cmVwIChhbmQgYSBsb3Qgb2Ygb3RoZXIgdmVyeSBiYXNpYyB1bml4IHV0aWxpdGllcykNCj4+IGlz
IGZ1bmRhbWVudGFsbHkgbGluZS1iYXNlZC4NCj4+IA0KPj4gU28gdGhlIGZhY3QgaXMsIG1hbnkg
b2YgdXMgaGF2ZSBsb25nIGxvbmcgc2luY2Ugc2tpcHBlZCB0aGUgd2hvbGUNCj4+ICI4MC1jb2x1
bW4gdGVybWluYWwiIG1vZGVsLCBmb3IgdGhlIHNhbWUgcmVhc29uIHRoYXQgd2UgaGF2ZSBtYW55
IG1vcmUNCj4+IGxpbmVzIHRoYW4gMjUgbGluZXMgdmlzaWJsZSBhdCBhIHRpbWUuDQo+PiANCj4+
IEFuZCBob25lc3RseSwgSSBkb24ndCB3YW50IHRvIHNlZSBwYXRjaGVzIHRoYXQgbWFrZSB0aGUg
a2VybmVsIHJlYWRpbmcNCj4+IGV4cGVyaWVuY2Ugd29yc2UgZm9yIG1lIGFuZCBsaWtlbHkgZm9y
IHRoZSB2YXN0IG1ham9yaXR5IG9mIHBlb3BsZSwNCj4+IGJhc2VkIG9uIHRoZSBhcmd1bWVudCB0
aGF0IHNvbWUgb2RkIHBlb3BsZSBoYXZlIHNtYWxsIHRlcm1pbmFsDQo+PiB3aW5kb3dzLg0KPj4g
PC9xdW90ZT4NCj4+IA0KPj4gT2NjYXNpb25hbGx5IGVuZm9yY2luZyA4MC1jaGFycyBsaW5lIGxl
bmd0aHMgaW4gdGhlIFJETUEgc3Vic3lzdGVtIHNlZW1zIGxpa2UgYSBzdHJhbmdlIHBvbGljeSB0
byBtZSA6LSkNCj4gDQo+IEkgcHJlZmVyIHRvIGJlIHN0cmljdCBoZXJlLiBXZSBhcmUgc3VibWl0
dGluZyBwYXRjaGVzIHRvIGRpZmZlcmVudA0KPiBzdWJzeXN0ZW1zIHdpdGggZGlmZmVyZW50IHJl
dmlld2Vycy4NCg0KSW5kZWVkLCBhIGZhaXIgcG9pbnQuIEJ1dCB0aGVyZSBhcmUgcGxlbnR5IFJE
TUEgc3Vic3lzdGVtIG9ubHkgY29tbWl0cyB3aXRoID4gODAgY2hhcnMgYW5kIG90aGVyIHdhcm5p
bmdzLCBlLmcuLCANCg0KYzgwYTBjNTJkODVjICgiUkRNQS9jbWE6IEFkZCBtaXNzaW5nIGVycm9y
IGhhbmRsaW5nIG9mIGxpc3Rlbl9pZCIpDQoNCkJ1dCByZWFkIG1lIGNvcnJlY3QuIEkgYW0gcHJv
YmFibHkgb25lIG9mIHRoZSBmZXcgaGVyZSByZWFkaW5nIGZyb20gbGVmdCB0byByaWdodCwgYW5k
IGludGVycHJldHMgYy1jb2RlIHRoYXQgd2F5IGJldHRlciB0aGFuIGNvZGUgaGF2aW5nIGV4Y2Vz
c2l2ZSBsaW5lIGJyZWFrcy4NCg0KSGF2aW5nOg0KCWlmIChleHByZXNzaW9uX2EgJiYgZXhwcmVz
c2lvbl9iKSB7DQpiZWNvbWU6DQoJaWYgKGV4cHJlc3Npb25fYSAmJg0KCSAgICBleHByZXNzaW9u
X2IpIHsNCg0KYmVjYXVzZSB0aGUgZm9ybWVyIGlzIGxldCdzIHNheSA5MCBjaGFycyBsb25nLCBj
bGVhcmx5IHJlZHVjZXMgcmVhZGFiaWxpdHkgaW4gbXkgaGVhZC4gQWZ0ZXIgYWxsLCB0aGUgY29k
aW5nIHN0eWxlIGFsc28gc2F5czoNCg0KPHF1b3RlPg0KVGhlIGNvZGluZyBzdHlsZSBkb2N1bWVu
dCBhbHNvIHNob3VsZCBub3QgYmUgcmVhZCBhcyBhbiBhYnNvbHV0ZSBsYXcgd2hpY2gNCmNhbiBu
ZXZlciBiZSB0cmFuc2dyZXNzZWQuICBJZiB0aGVyZSBpcyBhIGdvb2QgcmVhc29uIHRvIGdvIGFn
YWluc3QgdGhlDQpzdHlsZSAoYSBsaW5lIHdoaWNoIGJlY29tZXMgZmFyIGxlc3MgcmVhZGFibGUg
aWYgc3BsaXQgdG8gZml0IHdpdGhpbiB0aGUNCjgwLWNvbHVtbiBsaW1pdCwgZm9yIGV4YW1wbGUp
LCBqdXN0IGRvIGl0Lg0KPC9xdW90ZT4NCg0KU28sIEknbGwgZW5kIHRoaXMgaGVyZSwganVzdCBz
dW1taW5nIHVwIG15IGFyZ3VtZW50czogV2UgaGF2ZSBMaW51cycgYmxlc3NpbmcgZm9yIGxvbmdl
ciBsaW5lcywgY2hlY2twYXRjaCBkZWZhdWx0cyB0byAxMDAsIHJlYWRhYmlsaXR5IGdldHMgYmV0
dGVyLCBhbmQgY29kaW5nIHN0eWxlIGFsbG93cyBleGNlcHRpb24gZnJvbSB0aGUgODAgY2hhcnMg
cnVsZS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+IA0KPiAiVGhpcyBhZGRzIGEgZmV3IHBvaW50
bGVzID4gODAgY2hhciBsaW5lcy4iDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJk
bWEvMjAyMDA5MDcwNzI5MjEuR0MxOTg3NUBsc3QuZGUvDQo+IA0KPj4gDQo+PiANCj4+IFRoeHMs
IEjDpWtvbg0KPj4gDQo+PiANCj4+PiANCj4+PiBKYXNvbg0KDQo=
