Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4923AFDF9
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVHhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 03:37:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhFVHhP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 03:37:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M7VU1L010291;
        Tue, 22 Jun 2021 07:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1mKvQ+ZmzWI5F8SegnPaHNHYWK7gVolN67/pQg55Z5c=;
 b=RtYIhAWcc9WI/+TDvBEAbkh0sQwqOxTXsiyK9InIEXQ/DHA4CX0J7+x9sgbmgxcOnDsk
 AjjWvliVq3VQNslgCRuq+17Hmm3KN2Z85utY7lUQSrFR31PMZOblSZgCgo+kDTQjKMBt
 vguMUcu1OQWyiyal0za61bYG1kMmVOJxdsiPYO1VEqTax4nFOCs36mV5G2ob5T1YKPGv
 ZqGP3oSflj+kWwr9s+emkkQ2QQwY3+I+RUcWfEFeWuMJp2cK7JhBZngtgV8QyeKjVwN1
 tCQkezOcYzd2+m1SBrohPF8bhuykdMVW8AyGQ2grFbLeKF+RLWQJuhswBquk7I4OCG/Y mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39as86t3h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:34:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M7VRxb128161;
        Tue, 22 Jun 2021 07:34:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3998d6yv81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:34:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR/RwAoimYty9SKjfVJ7hR1cYelMfFzQsjkLpHkWfyMRdLMvTXW8w+mINHS4RfsQCzRt7bTq5XJtDXTXgoXArciqWc4P/xB2b0leswvJxizn3AqcaHk3I8NLaT+ourDuN7LkNupdJZBYfKtBJO3Yp1K7CQb9Gzbw0BAPo/AzR/dCki4SInLG7D2ocMaldrcU+xo+kRvprNfpea8bowyL4aHpyX/JxsRSgihdXJQSK7YXiFUSg/SuXO8uBO/jNL1jroLprPC5s4SEu0Kdt4H6vVwtgltj53bbZFmg6yF7FRlEe6AK4I8mj06vymQSoeQVrqwS3vC7VlNOEE2zwdOH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mKvQ+ZmzWI5F8SegnPaHNHYWK7gVolN67/pQg55Z5c=;
 b=D7jBeyWwH8xq/9x2DBYQGigWzhatFqXVnlZ0rCF9UtB+QMbiWqrcJWc2fyht1GF+p0KbUtgStCoOc+DGCQWsUkEzwy7cNTcpXJKjJN/d2LBG2qAWKhHRt9qcitm1mkDdWCj78nAG3BsSYA1L4lN/F73EmdvVhOhDbyy6pWZ9rKIFpEaekSQ9JHONeWJA4jvMFN+iWFpRYueYJtzU4I+bmAuFYb/AFO0FFM6dxqQKMQqggOl3RU1bW12gRqrtftccyfbpKwogrVh7C6hyrVoP5h7l1qBqUMs4x7et4OBVBLZNpfWk+s8xI2uRrGUYFqegUKdcWXQ5bFMSVHUgPpUMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mKvQ+ZmzWI5F8SegnPaHNHYWK7gVolN67/pQg55Z5c=;
 b=V6Y3twl9QZQ6WF907fjTCGdxLXr/fsKNbSP3Qqc2y3ub2UyyL2UmcPaOs2BHNiMLlBmfz6s9zYALa7DtnXpJHN82xAYXNvXNeIvLl/a3izg3Q+X+hA6CA+AgZLPtmxPTYxdKercd9FWNkjqqmS1FpwkEi4lVH0/TR5MQG9Hd7Ho=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1687.namprd10.prod.outlook.com (2603:10b6:910:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 07:34:48 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:34:48 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsej9MAgAAPW4CAAADBgIAAAS6AgACEEQCAAId/gA==
Date:   Tue, 22 Jun 2021 07:34:47 +0000
Message-ID: <8CD791BA-F945-4F4F-869A-1625E7F95648@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
 <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
 <20210621153255.GR1002214@nvidia.com>
 <E45662B9-4E10-4620-9718-F11BBE36AAE2@oracle.com>
 <20210621232950.GU1002214@nvidia.com>
In-Reply-To: <20210621232950.GU1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32366376-9e5e-4367-ed48-08d9355036b8
x-ms-traffictypediagnostic: CY4PR10MB1687:
x-microsoft-antispam-prvs: <CY4PR10MB168726B2D4098F7CA8111FB0FD099@CY4PR10MB1687.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuDLE2S+ytNY0pcTt0ZkGlbGpu3aDA6tvNhphDJkZzNlGk8RTdgkSVmLOs8OtA2sDl+a0Yl7tojwfcQYdgNRw5xX2rRs17Q06ItOgNMeSHL5AOduOQL8o4q8B2ijCIyzYuhz+/iavH9vMvwJqnlsL5ljJPSbDNBtyP8CqG1lZPdkfkwUByFUlLoNTJ6vK11owO3pKeG6PXy8K6EEXVqFgtmeJgmsjZ+sT8KqQOsvqOyqoqDG7C4YGjKTynOV/k3WFd3T3wGoNkEI6Ox/zyXhHyfikmvjpBshFwu2aOjr83CaQ8VDqJhGVUGFPJFP+VQUazi3mCs22U3S6iDNHV2TJeL3Intwc1BQjp4wZCsczY73ZJfsLJD01cJNiITpybMbTqq5XrET1G+gQ9SFhdHntS/d0geSTItqIk1GpsrVTiNPyOUT1aO/N3zi/PzkCyIn/8gNbJB9Bj2bXuj7NE2jeGvKkhri/+eG5CYKcjirDfMz1SrxLlbUhEgehOO4xsriKUNi6gw6SXV/YvntNPyRG4yHjJUDbvt4YBhkgpW3P3kzbdVVWMWsfo+doFgqfCMS0wRck9dXXBAn7CkN4Cb2TLo9UDLC9BfxwOV+v2eRpW6FSpkEjp1N3CP0xpPkYHHf6Y02UcoMmxZ3wOmK6DZwjGayw5uyWA8MiP79x5lXH2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(376002)(346002)(136003)(396003)(6486002)(44832011)(316002)(6512007)(8676002)(71200400001)(6916009)(8936002)(36756003)(186003)(26005)(6506007)(66574015)(64756008)(66946007)(54906003)(5660300002)(76116006)(91956017)(2616005)(478600001)(122000001)(2906002)(66556008)(33656002)(83380400001)(66476007)(38100700002)(66446008)(86362001)(53546011)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlBaVBJamx5SFZMYVZrdEhGTytqK1NOK0x0M2JheVA4SHpkelhHSlZVeWE0?=
 =?utf-8?B?NTNkVmxEU3lYMThxV1BRYi8xaTh1NVllQ0crUUN6d3U1VURGUzR1a09Yc2RS?=
 =?utf-8?B?c3hEWTloUzRMVGtCR3dMN29aelNnbXNwNzJ5djNwb1lXVGRLS3VpUXBnL2NU?=
 =?utf-8?B?VkgzU2lQQlJ5QUpSamtRZUY5ZXowSlBNTGpRd1hmc2pqN1dVSjUxZFQ3R2hj?=
 =?utf-8?B?UGduendhTk5rKzVGbUs1YmdlTVZQNmdkdk1JU2xaTVB1Q3UvVEttSGYycHJY?=
 =?utf-8?B?QitDUkVHandqY25uLzJzZXkvYkM3emxwWW91b2ZUTlNpaDVhSkxIM0lhQ21Y?=
 =?utf-8?B?bjFQRzdOZi9tY1hieWIwUFlsak9BN1VIaXFicm1RZS9QcWhjV3pnUkdVY2xC?=
 =?utf-8?B?bTBFU0NpcUh3eHIzUXhOZDZjR3QxTHhLU0RLQWhORlBHMEdNMWQvR3M3TXFY?=
 =?utf-8?B?eDFKQ2ZYcFYzSFB4ZUt4Y2w1dDBybk92UER3am52UW1JSG1KOU5uazhXdlEw?=
 =?utf-8?B?VTdUalBaanBWa1VNVnluWUh0cXFXVlR4RHNkK2xENkIveStIWWY0WEdSTEJQ?=
 =?utf-8?B?cUFsdG9IcjRtbUNjWm5mcDVscmVqcmRTc2MyeFNUVDU2V1B1Wk1kS0ZxL3VK?=
 =?utf-8?B?d2w2N0dDYjN3K2puRnRybFpKazhWdklmeTBkbFR5cVZEQ29uNkYrbWI5bzNK?=
 =?utf-8?B?bW1DQS9uUnhxbFRqMHFGelZjOC95akRLY25rOUpaM1JaQndsT0MrR3VRa3NC?=
 =?utf-8?B?OEdzSXVsUldvaGt2QXlReGNIYkRKMWw3YWl6NTBZaTdhV1VXeEpGbk9MbHpw?=
 =?utf-8?B?Rmg3UzJJQ1pIK25BYXpLVkVKb3VqWlhVZ1dnN2U1Yi9TZmVYcHNjdjh6TmNH?=
 =?utf-8?B?OGtsN05UZktxYVc1UjhYUkxDaW9mOE5tSEoyblQ2OUFIaXNVZ0FkdFZha29Y?=
 =?utf-8?B?VzlHdEtXV2Q3cjFCcHRRWXdoUTh0SCtueGp4RlZ4czBuYzROVnNnekw0Z1M0?=
 =?utf-8?B?WkhJeFNUV0gyUWptRktiajB4NDZOQjVGbkVRdHBOL1JGTUJRWUtYdjMwY1Zn?=
 =?utf-8?B?eiszaUN2L1NLci9LQUc4YjNXOHlLcVNVUlhSNStNYWtSNUJlZzZzRVFSWmFW?=
 =?utf-8?B?UVVjU3FTQWpndk5TTjhNQk1GRkVrN2c1ekxvbWh1RjY5dzJZZ21BcFQyejJY?=
 =?utf-8?B?eFNiMG51Wm96Y1p5Zmoyak9ueXNvdkRZQm41MDZRK052MHZqZHhxdlBJZEJq?=
 =?utf-8?B?Z1l3amx0aUtjRXhSYjYvWmt0MkV2U284Y3dKYUlIS1c1QkQ3OWxvL1VWVm9V?=
 =?utf-8?B?NjV4ZXQwT2pXd3djd2srM1FNdzlZVXE4cTg3SjhSMGlVdXh1S2s2VWpScFdX?=
 =?utf-8?B?eE16SWVndnB3ajZNc0piVjhRMTlmdDRHWjdIWkxETWVLdzZOTE5VS3VKQkVv?=
 =?utf-8?B?cXZQZWRMd3BPTktWdU9JVFAzZ1UxUnZXcXNtbnp6cmdGYTRvcXpzcm82Ri9U?=
 =?utf-8?B?d0Jwc3NLV0YreG4wU1dDZmRyaTlKaEFVdzNDNUpGTlRwd1dsUXpNb1ZvM25J?=
 =?utf-8?B?NjF1WHRqM0c0OTdZTWNDam91QUtMaHZjaWl0UDAyc256b3dYOUNyenlOMmlQ?=
 =?utf-8?B?T0R5SlVydkxsOVJqdGdBZThaYWtSSEpKN0tiS1FrZVBndTVFaHphblZkRGxi?=
 =?utf-8?B?eWoybmpTZFF3LzMrTXB5cmpiRFdTaCtidjBHUFZuYmh1RFlFQ2V5Y2thWDdE?=
 =?utf-8?B?dk54U09zT09UdzEzcU5mWnJCd0F2ckFOaldwTmJvM1J2ZkRWUmRjd3VkOVov?=
 =?utf-8?B?Yy83ZitYWjBzMUtWNmg1Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9CF9069135A840B555AAD8D14AA3D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32366376-9e5e-4367-ed48-08d9355036b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 07:34:47.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvHie+rTC+M3YT4xS6+hyNIO3idRQBetvb7vWAj36AFGyJC5sdInurtCFjGwJdxBeo3YiTSjynBB8upz2nNsWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220046
X-Proofpoint-ORIG-GUID: 0yt_jsobz8PVJ5nROoMrhyYO3im5kIA0
X-Proofpoint-GUID: 0yt_jsobz8PVJ5nROoMrhyYO3im5kIA0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDAxOjI5LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVuIDIxLCAyMDIxIGF0IDAzOjM3OjEwUE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMjEgSnVuIDIwMjEs
IGF0IDE3OjMyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAwMzozMDoxNFBNICswMDAwLCBIYWFrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIDIxIEp1biAyMDIxLCBhdCAxNjozNSwg
SmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9u
IFdlZCwgSnVuIDE2LCAyMDIxIGF0IDA0OjM1OjUzUE0gKzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90
ZToNCj4+Pj4+PiArI2RlZmluZSBCSVRfQUNDRVNTX0ZVTkNUSU9OUyhiKQkJCQkJCQlcDQo+Pj4+
Pj4gKwlzdGF0aWMgaW5saW5lIHZvaWQgc2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdzKQkJCQlc
DQo+Pj4+Pj4gKwl7CQkJCQkJCQkJXA0KPj4+Pj4+ICsJCS8qIHNldF9iaXQoKSBkb2VzIG5vdCBp
bXBseSBhIG1lbW9yeSBiYXJyaWVyICovCQkJXA0KPj4+Pj4+ICsJCXNtcF9tYl9fYmVmb3JlX2F0
b21pYygpOwkJCQkJXA0KPj4+Pj4+ICsJCXNldF9iaXQoYiwgJmZsYWdzKTsJCQkJCQlcDQo+Pj4+
Pj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVtb3J5IGJhcnJpZXIgKi8JCQlc
DQo+Pj4+Pj4gKwkJc21wX21iX19hZnRlcl9hdG9taWMoKTsJCQkJCQlcDQo+Pj4+Pj4gKwl9DQo+
Pj4+PiANCj4+Pj4+IFRoaXMgaXNuJ3QgbmVlZGVkLCBzZXRfYml0L3Rlc3RfYml0IGFyZSBhbHJl
YWR5IGF0b21pYyB3aXRoDQo+Pj4+PiB0aGVtc2VsdmVzLCB3ZSBzaG91bGQgbm90IG5lZWQgdG8g
aW50cm9kdWNlIHJlbGVhc2Ugc2VtYW50aWNzLg0KPj4+PiANCj4+Pj4gVGhleSBhcmUgYXRvbWlj
LCB5ZXMuIEJ1dCBzZXRfYml0KCkgZG9lcyBub3QgcHJvdmlkZSBhIG1lbW9yeSBiYXJyaWVyIChv
biB4ODZfNjQsIHllcywgYnV0IG5vdCBhcyBwZXIgdGhlIExpbnV4IGRlZmluaXRpb24gb2Ygc2V0
X2JpdCgpKS4NCj4+Pj4gDQo+Pj4+IFdlIGhhdmUgKHBhcmFwaHJhc2VkKToNCj4+Pj4gDQo+Pj4+
IAlpZF9wcml2LT5taW5fcm5yX3RpbWVyID0gbWluX3Jucl90aW1lcjsNCj4+Pj4gCXNldF9iaXQo
TUlOX1JOUl9USU1FUl9TRVQsICZpZF9wcml2LT5mbGFncyk7DQo+Pj4+IA0KPj4+PiBTaW5jZSBz
ZXRfYml0KCkgZG9lcyBub3QgcHJvdmlkZSBhIG1lbW9yeSBiYXJyaWVyLCBhbm90aGVyIHRocmVh
ZA0KPj4+PiBtYXkgb2JzZXJ2ZSB0aGUgTUlOX1JOUl9USU1FUl9TRVQgYml0IGluIGlkX3ByaXYt
PmZsYWdzLCBidXQgdGhlDQo+Pj4+IGlkX3ByaXYtPm1pbl9ybnJfdGltZXIgdmFsdWUgaXMgbm90
IHlldCBnbG9iYWxseSB2aXNpYmxlLiBIZW5jZSwNCj4+Pj4gSU1ITywgd2UgbmVlZCB0aGUgbWVt
b3J5IGJhcnJpZXJzLg0KPj4+IA0KPj4+IE5vLCB5b3UgbmVlZCBwcm9wZXIgbG9ja3MuDQo+PiAN
Cj4+IEVpdGhlciB3aWxsIHdvcmsgaW4gbXkgb3Bpbmlvbi4gSWYgeW91IHByZWZlciBsb2NraW5n
LCBJIGNhbiBkbw0KPj4gdGhhdC4gVGhpcyBpcyBub3QgcGVyZm9ybWFuY2UgY3JpdGljYWwuDQo+
IA0KPiBZZXMsIHVzZSBsb2NrcyBwbGVhc2UNCg0KV2l0aCBsb2NraW5nLCB0aGVyZSBpcyBubyBu
ZWVkIGZvciBjaGFuZ2luZyB0aGUgYml0IGZpZWxkcyB0byBhIGZsYWdzIHZhcmlhYmxlIGFuZCBz
ZXQvdGVzdF9iaXQuIEJ1dCwgZm9yIHRoZSBmaXggdG8gYmUgY29tcGxldGUsIHRoZSBsb2NraW5n
IG11c3QgdGhlbiBiZSBkb25lIGFsbCB0aHJlZSBwbGFjZXMuIEhlbmNlLiBJJ2xsIHNlbmQgb25l
IGNvbW1pdCB3aXRoIGxvY2tpbmcuDQoNCg0KVGh4cywgSMOla29uDQoNCg==
