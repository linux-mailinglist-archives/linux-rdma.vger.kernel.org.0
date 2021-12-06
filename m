Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651774698DF
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbhLFObD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 09:31:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16210 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhLFObC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 09:31:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Dqq1U023240;
        Mon, 6 Dec 2021 14:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mDONaNJwjc+0ptbq1Hm2kIh9j19vH0qi4PIOVdswQMs=;
 b=hmr8A9xxcNGY85dpwwRg83ok57bTmooDai8DD6oWoUp6fYhXhaOQ6TDdsxrnYqCCmYmZ
 iulWt/QFDoU2cSCZ5Yom1pUiFChe7kFK6jpj7rdgXnVeUHNbWYV2dN3di2k37aAWrJMw
 KjBn0zRg2TysnVF/kaHI8xC57uxwl7ab7LSaU8cir4AyPpiKxZu31EsuF1QJT/ecJ1R0
 8J4cYpeAJnB+U8uv0GLpHrNN6cLhc2/lbe7mH9g7bIXJ6sWXH/x8Bbsf8FbUiPWPqliw
 Y/C0UdJs5G5vdjJ4gVEYuF/jRJHvr1zWlSPpCq3mO5oJc90df2PgeXwL9NTj/iSddZcv Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqjkbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:27:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6EL6Bw146553;
        Mon, 6 Dec 2021 14:27:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3cqwew2dau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 14:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfRtj0nUGRKy5PBwDPsAkHwudgA3mAuYQyXUJPsVBpj5yByRim13qa5FTm/ROVA5EcHZfHNYN6Mbl4g5fq1DalgNZhDdqfyFTPtesVDjPl8n7A/lzRqGOtquOj7uAhssrmV7EGjZjW9GHha7idpcYn0BM7M/lo4jUSeU7SrP59d1sRgTOaBE7pYMcbCrfxd2f6Oms5gGvhgORVJNCiA560I8vH/CYut3jRMV/XnYRvWbDJszU1YbzFt2/Wr/UXs+EnhFgautscDX8x9X0UXsaqFhksmuLJ1pdYVfWuNGP97KFQIB45HjLUb3CSsWs+VY2qOXxd9rgNQbkAzv1BbhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDONaNJwjc+0ptbq1Hm2kIh9j19vH0qi4PIOVdswQMs=;
 b=CeOYCN8ksVu3Tskd6oHnI6wrVEYoOdAsrDEwZQq0VGiQA7ilcnT4351SrsPRwC1yws/IN9O1srKhGKhz1nJUTWOGGb2CCNEyGbTEP/Z2YgzE5kif/GnHVStozHaj7G4w8YuXRXlR11TZ7fFRAfA/ayH4JS6jM2oZ3McNiOrSu5rCBxedIfm/fd3oL8KsLS/tQupOkVLWyDmxBP4e7oZq5RdAZ8HEKqo5HLNW5FBjKuPyQlrGaDrGEna9qjiEXAuzw+3ekDY3RECPzyRAtwcTEfgNALnYMCyf5xkPq+8M7JXA4v/3gA/5P/n/00CAIJFokwykK3tC6TMOyutYBgRpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDONaNJwjc+0ptbq1Hm2kIh9j19vH0qi4PIOVdswQMs=;
 b=qVHe/sCL5hrecWDqk6ph3HpRxbu3t9etYYrKntj4lMLdNcOgO5jI1MUiHL5yyDA7QEYo07rjMooruxY9qrvj6QxQgPMHK7HvjU1DLWlMxdhveL9drYJkNRneABwJo9lSrfo5XVpU8Iy+icE7iAu0PfT7Pv0Ncm1gJhpKPeG5SlI=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5403.namprd10.prod.outlook.com (2603:10b6:510:e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 14:27:18 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 14:27:18 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
CC:     Doug Ledford <dledford@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/1] RDMA/uverbs: remove the unnecessary assignment
Thread-Topic: [PATCH 1/1] RDMA/uverbs: remove the unnecessary assignment
Thread-Index: AQHX6qyp0XkoLS6ftUu5jR42cMuAz6wlhWSA
Date:   Mon, 6 Dec 2021 14:27:18 +0000
Message-ID: <D8348428-539D-4C4D-8D21-C23C1B0E80EB@oracle.com>
References: <20211207064607.541695-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211207064607.541695-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240b8a51-db67-483e-032a-08d9b8c481f4
x-ms-traffictypediagnostic: PH0PR10MB5403:EE_
x-microsoft-antispam-prvs: <PH0PR10MB54033C0C4272FC1BA3E0688CFD6D9@PH0PR10MB5403.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9TA7iYbx6Je2ZqZwttbxAz6qPbehZL3ljoadr/otDGNqUZEq7o4HxFO+l1IL18/mJMBgEPwMZNu/JLar86HOriT/G/LGTi1PihpiOq2SPOTEGiYE0NGskDr/s1GdgXaV4lZ6xBbl8aFFgHES+fuch81iObbmTKq0hTKJ9MIQ1VDIRkmABMJZuqodeirjPACtxQJoOTaqCWAMgXLSr1mMO9Ftq0Eb72ZnAXVkBnCbVzgoHJ2sbi/eCyAL/D4K4y0+0bcEioGFTsjMemVWLha2x3cagd/uX2I2kra/AsHuqnCP5sHaGzHRsGp0xNJMRIqLdjChfPStkR11yLVgZZyELVzzpzFsw6VkNvLMs64hcGsxNpj1pGKJXhfTYhhza33f+PqRazzUVCgFvoSuNBaFTsTjFrmk5zumpCjZo2gIk9THZhyxRi4XpudpJA9ldbtMRy0ckonkejNHT9ecbLv7BSl8BJMrH7i6yPBulfgI3c7NtiZAQvWFfkvlrUBygBjqYv5KgqovffqBrxU+OCLsT8FimrkxAdLZPXxksZ6if9U4gfim7nTiIwgJQ4t5o0xPoL3iXzVTM2e+RHGdfViTLrLx+/NIx0aazRHQ2GC4PGjG4zif4D68x4AmuDZde3b3YKC4Q4HKS2Ou9c6UpLgH1D4/QDkuU9ADVxb/clKOmf8OWZ+bEFziJ3EQ4iCcwZbi3YZdoHxbsCK7hmdNsZQ41WC7uuirDrsuvEJDqu2RRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(76116006)(66946007)(86362001)(38100700002)(8936002)(8676002)(66476007)(186003)(4326008)(2616005)(26005)(2906002)(91956017)(508600001)(5660300002)(83380400001)(6486002)(66574015)(66446008)(122000001)(66556008)(64756008)(6506007)(71200400001)(6916009)(53546011)(33656002)(6512007)(38070700005)(316002)(36756003)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hXOUFNUHRrak00UDdqa0RzdkxnOWtZbEVVeXlqZk1FVGxUbHgxNDc3NHdQ?=
 =?utf-8?B?MjhkbkNBeEI0aVRiNVhVbElyak92TUJUMTFrVWg1Z1JPdk5qQlJMbnpXL000?=
 =?utf-8?B?YnNqMXp6U1NIazFVb1pWMmFYRll4NENEL2s1SFZhb284TTNaVmNCZi9OKzJT?=
 =?utf-8?B?azhhL1VIUk1VU2dBSERtdVVjbXBBY3NabStlcThiN1RBM0thKzBvZ0gya0w0?=
 =?utf-8?B?QWFrREJNa1hCUmhyNjQ3UXprSkNJTGJKK05EWkNrS0RZWTd6Q3BzUC9EWnZ6?=
 =?utf-8?B?dlRGU0t1ZW5rY1BiYnhtV0lqOUVWM1VJWmtJbUVjOE4wZURhWUZ0eVd4L1JV?=
 =?utf-8?B?Q0dqUDRLS2VTS2VZWTc4bmFBa09veEdtQmhwNzlnWVhGZ2REeVVsM3htUCt6?=
 =?utf-8?B?VURkUWYwZklwc0tvT0x6ZDlQcDV1ais1ckNLK1cwU1h4R1FHU004anprRlZm?=
 =?utf-8?B?ZldHeWtwYThpODhOUWRGcUpZb3Jxam9wMUR1QTB3TTdPYlQ3UUxrNm9TQ0J1?=
 =?utf-8?B?NDF5U2o5RWF1ZlpJT1NOTjMwZE1LUTQrKzlzemZNUmVwSjNtMjhLU3NNODVU?=
 =?utf-8?B?WWhvQjNrMnNYbXA1YlMvSXpvamFUdmVYR0VMSHBsbWdETERwY3ZYNmQrYzkw?=
 =?utf-8?B?Z1VBbGxSSXFiU3Q4SGVuUjVGZzNsY1lERHh1OTcybXdCQzlIL2dpTm1KdDNu?=
 =?utf-8?B?eXR3MW9UOHozZmpwbE9LRktFNDk4Nm5rVmVTd3lRVG9sYWd2Rmx6UGtLc2lT?=
 =?utf-8?B?VnozZHpHVjN3a3dqZnR0NUhHT3ovK1ZkV1haY1VuUDhWWnJDSnBOSm1rSklM?=
 =?utf-8?B?bHFkcnM5YjdreUE1SVYvTjRPTEdyWmZDcjQ2bFBMSzczYm5ZL2J2NVhhTHNl?=
 =?utf-8?B?d3NSZllLM2JyNU44RFVwb0JFeWd6OVgwUGlKSUs4bkxxS3VKbWFnYTlZOENv?=
 =?utf-8?B?aHBybzd2K0lOaVdnS3B1VzhqRTkrVU96OFBJUnZPVElRc2VaaGMzTmkvb0Fq?=
 =?utf-8?B?R3Y1SGpRTnB1TUp0ZjBPOFNxVmVTaDlHZUlRL2RJeHF0Zzlsd2tCeG5LTS9r?=
 =?utf-8?B?clNoQnhxYytzYm5XckF3TFhjR1VLZTV3QlNjM1ppckRLb00wY09QWDltSmla?=
 =?utf-8?B?Q2ZKcTNpNXBzcFJNZ3RhU01La0U3UkdJemFod1ZyVXhOOXJMb2ExT1hqT1Qx?=
 =?utf-8?B?eUk5V25ycDBtMjNoTUdVaUtJVnBUbmtKOXFBWkVld1RxcFJiT1BPckpwZ0lD?=
 =?utf-8?B?clJ0ckxuYUNlYnQyS3B4ZUk4K0pGZzh2cE83aG5CNVUxZDl3RzN1OG9udkZO?=
 =?utf-8?B?L0tvR0VsR0NUR0d4ZU91V3NhQklaVmkrYVpSME43UWxkTkhGYWRNK0tpZXpS?=
 =?utf-8?B?aEsyRDBVOExrUGFNajR3MG1IZnBYSTNqZ3hwY0xLSHpJdnFMdEFudktCK0NU?=
 =?utf-8?B?RVZkSHRtb2w5TnZ3clJRSHg3NjVXOGFqelRIWXhZdVR2RitpMFFEcHNzSVhl?=
 =?utf-8?B?MGJWdWdGMjF2M0ZTNm9nU3VwV1duSkxNY3pLNEhlTU5zYm9BQ0cralE3bGti?=
 =?utf-8?B?aXIwU0RxNnpXV3VTMlZKcVdBaXlmWmJNL0ZDdEpVbVhKelMwRWkxODh2OHNy?=
 =?utf-8?B?YzE2WUw1MEhIWnFVNHhkdTRJemRseEFwOWREZWFpclU1N2hwYStmcmx0b1ls?=
 =?utf-8?B?M0JaUnpWV2FielBlVlpZdEdJcS8rMjZ4YWN1NjNHWUV1WTZBVEVOQ251ZXdo?=
 =?utf-8?B?aVlxdjNhWFpiY0lxZW91ZzZiRHVFUlZ2dlg4bFJjNmJHTVB1RWxibWNuL0M4?=
 =?utf-8?B?Y1pXV2FpRTBCMXlXdjM3NGpXVHFXczN3bmR6K0JhMHhOc0JyMWJMdnZqT0xU?=
 =?utf-8?B?cmxtamE4bjArc1AwRUc3dTgxYm9yWFplZVlTajRIS2xCOWdIRDZrV0t5VytQ?=
 =?utf-8?B?Rm9qQ0UzcnNjWnZHTkd4U0hRQnZJSUd1akdKZWhBUGtOcmV4RmJzQ3ZpOUF6?=
 =?utf-8?B?WmZoOU9TVkxRVWRKNGNUUy9taCt1WStJaEp3SzYxbEpVLzlqRy9nVDRsaUxu?=
 =?utf-8?B?dTV1UHN2WGRmMWhNYk1mYVZUVGtzOGlrRVltcE9nR3BMVzR3Q0o5THRnWkRh?=
 =?utf-8?B?S1BqVmxBYlNGME1ZeW9ZNEhTSFNrYkJvdVJ1cDU5dmM3a3FybERPL3BlT09s?=
 =?utf-8?Q?b8uoTXSacqj7JtF4ZtMKGGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683B856295BFF745A05E9FC47EAC56C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240b8a51-db67-483e-032a-08d9b8c481f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 14:27:18.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6byoIqur5JD9dEeP4LZSpDMbpH/LY87PcwQKvJsQEFV2T8XERur1F78HHNOJM5COn3U7WZ2iUwprBoIw6rwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5403
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060090
X-Proofpoint-GUID: UW6PRayEm_Xdiv1wft7imGsiVzc6cuIH
X-Proofpoint-ORIG-GUID: UW6PRayEm_Xdiv1wft7imGsiVzc6cuIH
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNyBEZWMgMjAyMSwgYXQgMDc6NDYsIHlhbmp1bi56aHVAbGludXguZGV2IHdyb3Rl
Og0KPiANCj4gRnJvbTogWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+IA0KPiBU
aGUgc3RydWN0IG1lbWJlciB2YXJpYWJsZSBjcmVhdGVfZmxhZ3MgYXJlIGFzc2lnbmVkIHR3aWNl
Lg0KDQptYXkgYmUgIi4uLiBpcyBhc3NpZ25lZCB0d2ljZS4iID8NCg0KPiBSZW1vdmUgdGhlIHVu
bmVjZXNzYXJ5IGFzc2lnbm1lbnQuDQo+IA0KPiBGaXhlczogZWNlOWNhOTdjY2RjOCAoIlJETUEv
dXZlcmJzOiBEbyBub3QgY2hlY2sgdGhlIGlucHV0IGxlbmd0aCBvbiBjcmVhdGVfY3EvcXAgcGF0
aHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4N
Cg0KTEdUTSwgc28NCg0KUmV2aWV3ZWQtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9y
YWNsZS5jb20+DQoNCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiAtLS0NCj4gZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvdXZlcmJzX2NtZC5jIHwgMSAtDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdXZlcmJzX2Nt
ZC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdXZlcmJzX2NtZC5jDQo+IGluZGV4IGQxMzQ1
ZDc2ZDliMS4uNmI2MzkzMTc2YjNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
Y29yZS91dmVyYnNfY21kLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdXZlcmJz
X2NtZC5jDQo+IEBAIC0xMzk5LDcgKzEzOTksNiBAQCBzdGF0aWMgaW50IGNyZWF0ZV9xcChzdHJ1
Y3QgdXZlcmJzX2F0dHJfYnVuZGxlICphdHRycywNCj4gCWF0dHIuc3Ffc2lnX3R5cGUgICA9IGNt
ZC0+c3Ffc2lnX2FsbCA/IElCX1NJR05BTF9BTExfV1IgOg0KPiAJCQkJCSAgICAgIElCX1NJR05B
TF9SRVFfV1I7DQo+IAlhdHRyLnFwX3R5cGUgICAgICAgPSBjbWQtPnFwX3R5cGU7DQo+IC0JYXR0
ci5jcmVhdGVfZmxhZ3MgID0gMDsNCj4gDQo+IAlhdHRyLmNhcC5tYXhfc2VuZF93ciAgICAgPSBj
bWQtPm1heF9zZW5kX3dyOw0KPiAJYXR0ci5jYXAubWF4X3JlY3Zfd3IgICAgID0gY21kLT5tYXhf
cmVjdl93cjsNCj4gLS0gDQo+IDIuMjcuMA0KPiANCg0K
