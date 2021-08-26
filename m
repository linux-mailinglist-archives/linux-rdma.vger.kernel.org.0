Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52003F87F1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhHZMuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 08:50:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232506AbhHZMuf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 08:50:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QBNhgU006459;
        Thu, 26 Aug 2021 12:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BBMDTwyJ2QyWf8kAtyetZISNm2MneHfFMfZa9jd8Nog=;
 b=l2g3CpQulyLklaMBKTAOKcWmv0wSjhCzCMD/OIFs1c0JL8bwEKUzparRHEjy7ng6ujy2
 kMAKPFoKglJNnuweYRYm0fdAlSHgsVfsK8qLUU7sACpYXO5kHucueB7fio0w4w+awkih
 kQIZAAcnTctlIYjYE8KCravmcSJAr5cnmCnpuI2qGLtxk2oN37bcgifAxMyWdxqp0fwk
 4viftYmButret/W6cqQnlVPsXFjzAp04BMbpbit+LBeI8ydkLIccJpkwlDUCuvHS4lWY
 ZZvZHWE9aL/cIDKfLoq4oLMyG83ChIeD3hgMGnz2tX7owwBhecEUxUp+1tSUWpLuZrXh fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BBMDTwyJ2QyWf8kAtyetZISNm2MneHfFMfZa9jd8Nog=;
 b=Hsg2acgo+dDQD3AgGT9ITpUGJ6jqrBVH6hKOL8SuA/9Znv80RV9UTfrlengZ30oGgjSf
 5i2huRkfCgZd55DO85dVRbt+FZHqHY4G1raaov8UkrbocNlQlDAx6s5dJEy2w19fZ4tD
 8FtqnkCq9LiY5Jx5taGBcqRrDkpe7PEG6c4V+z4HwhuxyrGO5JU0kwTSYnTNuKwTmeRK
 mgbM57s/2bAMckOL2mObfBBGxyI6cbPiRMc6C68SUTN5/nMe91P5HRqm7X1Jq1vUTZHG
 RCjnTpZ8qwKxPMfYo9xWfog5u/scPAIBiLBx6lJbIs8mtR7JSsM+NicyHrOc2vdR9/8Y jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5h4d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 12:49:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QCjYOa148280;
        Thu, 26 Aug 2021 12:49:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3akb8yygad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 12:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW3xqDRmvvOGpeDA0iUjsaIuK4gZFnP1i6OtxbfMZOaEc32mEmTREP7hl6XJdIydvje9UBfSKWJiJzbe6kLfZDdaupRzQYpgJjzYnsF6bgQcSrC3WROX2oozUA+7BwO3zqwTH3Y19TM188E+1IiGkeqgUfWLEu+OvaV63yDBSopIu4+nNrWhyTd6Q6N8K5DrxKMdfMODtSbcnBjVMFJGG8z0B32NXh5N5JrPAONqBxSGcg+DMZXX38d/KO/ysVmAn+aWkEmdx2NvZBxlye0hOFmiNAO/I6kI3M3afzWVfdK6VDd9o+wb+OvjRYP0F+isOwzl1BqCR8/ib1Rs/chpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBMDTwyJ2QyWf8kAtyetZISNm2MneHfFMfZa9jd8Nog=;
 b=LOqAZEhRZJBT76FtkA6wcKSCkM6EIxRM1MXGYhYYbf35oUiX2BDPJ4L9OUbIwVWK8msXmLpfDz6VJ1QDCbggshBB5rMqHOKB0dCzfZLhdH6gJ+j00i+PAMc6iAs1+QIoUQyiTEAClcSg9DGFVgmuPWiLWkAyFdqnvzowQ7pOzWge5ri3SMbCTn8fF2wDrkSnliblErAyedMudseLUsMfeiaaATqWmMiLo3QT/pe3uRxM4flynAf0bFkLhBiAY87OQijG6TyJMlqt3MSWqjfCgoSzh+TBzienV8eHeOGHs5u2mKbXDnsey7xq6wwGi2XVK8H7qAN6avTPKRlc2ImOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBMDTwyJ2QyWf8kAtyetZISNm2MneHfFMfZa9jd8Nog=;
 b=Y2hssehISosaHQbNVa5fNhAsz/mGOrHb73eKLBdf2Lvx/FbZgGQ/cbBZTzTpz1uldQo8cF7L6GLXxDplg6oOjoy9kMeXaJPYbphEhmATi8aPMoembUpdBhGOR+z0jopAT9K+ZVIk/G5DsoZIcJtl24tpAJd7UIRwj1LVzg26x6g=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB2009.namprd10.prod.outlook.com (2603:10b6:3:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 12:49:21 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:49:21 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     kangning <kangning18z@ict.ac.cn>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Fix one error in mthca_alloc
Thread-Topic: [PATCH] Fix one error in mthca_alloc
Thread-Index: AQHXmmlymSRVuliPtkykmSOQpv2oxauFvL+A
Date:   Thu, 26 Aug 2021 12:49:21 +0000
Message-ID: <9B14AD95-E5D5-4141-92B8-F9BD5AF99AEE@oracle.com>
References: <20210826105215.2001-1-kangning18z@ict.ac.cn>
In-Reply-To: <20210826105215.2001-1-kangning18z@ict.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: ict.ac.cn; dkim=none (message not signed)
 header.d=none;ict.ac.cn; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 512fdaa9-48f1-42a9-07c4-08d9688feccf
x-ms-traffictypediagnostic: DM5PR10MB2009:
x-microsoft-antispam-prvs: <DM5PR10MB200937C5D38EDCFA5BF53DA3FDC79@DM5PR10MB2009.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqUk/CDFKLDEg8M7zFM1OWlofhfT+XwTZOBCdjCwCuqIxFa+LFxh+V2uQhO0OYz7drLTODsajhO5uZjoMuwhloczJC12v7bWNzBntYusTmnhOiPK+1d6QimBGwzyVJkfl52Wm9pu4NjlQsKcgSXN/wzL6xF2h+u9IFIUIrdHFlc9zdHIpZ9MYsGI8MxT5lxNXfW/8fW+OmervGLRbH2m1RQHNP2keItRCsbGnnku5WCafNIxQP3fcl5ZQEXe56glOB5ju/gHWf2zbrpT04e0EbZTLnZfqm45srH9kcEvpUBaiZmUShLqe0916rLECH6KZxFIFjeoaswodyDMma6F0HZMwILZWGbG7Zr/uIlXMVUlVECWqtBcWIW0vyKog3t4nJEGUW+jMVm37QH7Rq50rx+25yHYRsacbU31p0ZAWqp8EbYTAL8jMsJ4aINlY1Rxq4Mlq2ftCsGlEhigha6PKnldu5u3Dc+5Mz1IwhdPLEZR5FqxWhGgLkIIJE78zJl07GvQ5jouJD51q6QPugmkVOCmLdHCLSD0K2hMOtBIyn5eH7Cr5Kb7KNAMSBJAekX+QdkMqwGi6PBt9KM2OjRp9ecAHTwEc/QRyV5uUPQXE5YPyuupW9utQw6HJfpRs3wTajBKcd5UE7NqF+zL31YwnA6mGplTtyTD6i0HtpmghixyTj+9ZGjbvFwaBeyU7AZULm9wSgU+S5ZCRh4DTWYvWnv7AeSoRLk+BqfT0g+BGHOFORhC9OfTGKgcN+S5F9aL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(66946007)(71200400001)(6486002)(91956017)(36756003)(478600001)(5660300002)(26005)(66476007)(8936002)(66556008)(66446008)(64756008)(76116006)(6506007)(44832011)(8676002)(53546011)(6916009)(6512007)(86362001)(2906002)(122000001)(316002)(4326008)(38100700002)(186003)(33656002)(38070700005)(2616005)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0c3MVV3bnBPdEl0TVgyZjh2N1RLdXpMejIrckJZcSt4V2R6Vzd5OW9aV2o3?=
 =?utf-8?B?bVZvM2hWdkRRelB0eXpqc29SUFgyalZVWkdZUytiU2VqTytvZVVwWCtQZ0t0?=
 =?utf-8?B?SHNkR2dadm1lWHRGdnVobk1OYzVHQmVGMFNrejlpdHUrZ1d3RXBZdUo2Z2hB?=
 =?utf-8?B?aEtEb1pzMVl6allXZEhDNFQvRTA3RWhjT1NQcTAwbHhjQURGWS81UE52TXh4?=
 =?utf-8?B?RjhGRUxVdlMxeFFOTDcxQTQ0Vms3bFE0eEZxbVRJT2NpdG5qanlySkFHQ2V0?=
 =?utf-8?B?SjRNaXgwQVZKOG5CNFhSOGd4RXM0RXZTY051dVJ3WjZiWnZqV0VoTi9Za1E5?=
 =?utf-8?B?M0p6Y2EvcUtnd1Z3ZUg0STZmMjUrWmtVY1FtWmJnT0plWHU3WjJDRzhGRUtz?=
 =?utf-8?B?ak1NeC84a3BYL0c3OGpHYklJYXFVK1dRTkRKZ2JhcTIwTGhpcEQ5bHhHZmFY?=
 =?utf-8?B?b1FST1FYRTJDNWtFRzY4WWp0R1lSNC8yU2NjYlNEQnFUbDlFZ2wreWNYb0ts?=
 =?utf-8?B?blJrcEZLUkhNZGo0MG14bU9SZlZ3NXlGczhSdVR4UHZxN1R0ZXJlM1lyb2pn?=
 =?utf-8?B?MzVDOUJGejdnZ0pBdTVMeWwrTlMrR1pRMUhZaUlRbkh4MnI3VUpBcnpjK1Rp?=
 =?utf-8?B?bTM5TlFkdzg2UmdqNk1IdC9iZUFJTE5EMFFJeUpQOXEzeGpsbEx3Ti9YL0Nh?=
 =?utf-8?B?S0tnbGg3YTRGd2xBdmsrQlFvdEMwR1dXTFNnTnY5OWlFeXVYdk5Mc3lmNndm?=
 =?utf-8?B?TnFRRU9kYmFJRGVFdXBURDk3bjIvQVZYOXZCSmZuYlVDcmd0aGFrU0YydHF3?=
 =?utf-8?B?MjJnMFdxMFlOV2VVbnVJZ0VCdTBjWi9sTEVsRGtjenpWRzRMUGNMSVZEa0Zt?=
 =?utf-8?B?RXd3djVudlplNVowVlRmcnpOQ3ljZDEwUU5SOXpzT3E3YXkyU2VuT1BncnlK?=
 =?utf-8?B?Z0ZNTWNmdUxPSHA2R2lUSFpLMjNpNVM2Qm9DMFROdzB4V1hkQ2xtQmk0Snk3?=
 =?utf-8?B?Q0pZbmhNem9JZlJ1RHRPUWVHaEJ1aTZyakZTZEowZmZOUDd1UjlyOXZyS3JL?=
 =?utf-8?B?MGpJbUxGYnNMVHY2ZzkybUVzWUg2MDFwUmUwT0ZhODJqdjM5Y3N3QkR0TmE0?=
 =?utf-8?B?bjJFWEs1RjFYR09IV1NJWkRGVG1vRHdPZlg0K1hLRkl5OHR0S1NqNW9FK2Nt?=
 =?utf-8?B?OFRESm5rb1dkT1JHVVg3bCtRWk9yYUNhZlpsZm5yOTNTNGg1dVNIc1pubWN5?=
 =?utf-8?B?dUFkalMzQlg4R2NpUDlBKzY5T0x2VWowZjdFMERZaTFscFQ2MVVweGUxOWM1?=
 =?utf-8?B?TmRLS2hSdy9ENzd5bHRsMEpuMUtsY2hzaWdNampmZS9sM3ViQWlJWG84V0RV?=
 =?utf-8?B?UmRadXljYnBYV2ZFdjFtM2lKc0VKVHBzWXRmcW5ia3VDc3dROGFoOVFrN0l4?=
 =?utf-8?B?TmtUdSs4K3Fqck1IRDNuZUY1YjFMaVNXWUZwNnQyNktwY2pxejhwVHBmeXdN?=
 =?utf-8?B?dVdteTB2VVJhU2wzdmx4aXQ1UlM1Yy9OTGJLa2FXbDk4T0RVVlJuY3RsZ0Z4?=
 =?utf-8?B?LzZkOHMwMDBJQjNTZzFCYk9tUEpGT0NMMVduMk5zbllKclNhL1Z2SmNkeTNT?=
 =?utf-8?B?TmV2T09oZjN3WUxTME5Qd2F1VEFlS2tFUnZLdnFrSTYzdXhXREplQ2VWZ1Rl?=
 =?utf-8?B?cWRpL3dvUlN5ZFF6anJySnJMTDIyMi8xLy9IRzlxc2RzVlRreFkxMjdwdVc0?=
 =?utf-8?B?eTVhWk93S29sM1g5TkhDSFJDZEh5ZHBzalNKc1BHejhyR2JkYnUvVlpER0Zp?=
 =?utf-8?B?NkE0dnlxYXVLNjFjbTROdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8576F4B39C56F42B4A10E3737F06C49@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512fdaa9-48f1-42a9-07c4-08d9688feccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 12:49:21.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hjhl7XTNQ1DIjXpxotEbhrClPrtP+12gkhiPA/0t98KpyqG2I68fhHB8jUQqutFoemInSE4+pOIAntIqevo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2009
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260078
X-Proofpoint-GUID: 158Yfbob67MWfg8hbNdwh8BXRmdD4Fus
X-Proofpoint-ORIG-GUID: 158Yfbob67MWfg8hbNdwh8BXRmdD4Fus
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjYgQXVnIDIwMjEsIGF0IDEyOjUyLCBrYW5nbmluZyA8a2FuZ25pbmcxOHpAaWN0
LmFjLmNuPiB3cm90ZToNCj4gDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tdGhjYS9tdGhjYV9h
bGxvY2F0b3IuYzogYWxsb2MtPmxhc3QgbGVmdCB1bmNoYW5nZWQgaW4gbXRoY2FfYWxsb2MsIHdo
aWNoDQo+IGhhcyBpbXBhY3Qgb24gcGVyZm9ybWFuY2Ugb2YgZnVuY3Rpb24gZmluZF9uZXh0X3pl
cm9fYml0IGluIG10aGNhX2FsbG9jLg0KPiANCj4gU2lnbmVkLW9mZi1ieToga2FuZ25pbmcgPGth
bmduaW5nMTh6QGljdC5hYy5jbj4NCj4gLS0tDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tdGhj
YS9tdGhjYV9hbGxvY2F0b3IuYyB8IDQgKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L210aGNhL210
aGNhX2FsbG9jYXRvci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L210aGNhL210aGNhX2FsbG9j
YXRvci5jDQo+IGluZGV4IGFlZjFkMjc0YTE0ZS4uZTgxYmIwZmNkMDhlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbXRoY2EvbXRoY2FfYWxsb2NhdG9yLmMNCj4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L210aGNhL210aGNhX2FsbG9jYXRvci5jDQo+IEBAIC01MSw2
ICs1MSwxMCBAQCB1MzIgbXRoY2FfYWxsb2Moc3RydWN0IG10aGNhX2FsbG9jICphbGxvYykNCj4g
CX0NCj4gDQo+IAlpZiAob2JqIDwgYWxsb2MtPm1heCkgew0KPiArCQlhbGxvYy0+bGFzdCA9IChv
YmogKyAxKTsNCg0KTm8gbmVlZCBmb3IgcGFyZW50aGVzaXMuDQoNCj4gKwkJaWYgKGFsbG9jLT5s
YXN0ID09IGFsbG9jLT5tYXgpIHsNCg0KTm8gbmVlZCBmb3IgYnJhY2VzLg0KDQoNCk90aGVyd2lz
ZSwgbG9va3MgZ29vZCB0byBtZToNCg0KUmV2aWV3ZWQtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29u
LmJ1Z2dlQG9yYWNsZS5jb20+DQoNCg0KPiArCQkJYWxsb2MtPmxhc3QgPSAwOw0KPiArCQl9DQo+
IAkJc2V0X2JpdChvYmosIGFsbG9jLT50YWJsZSk7DQo+IAkJb2JqIHw9IGFsbG9jLT50b3A7DQo+
IAl9IGVsc2UNCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0K
