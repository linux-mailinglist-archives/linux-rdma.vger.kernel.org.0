Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858434545E3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 12:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhKQLs7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 06:48:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12152 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235513AbhKQLs7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 06:48:59 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHAQb8g002136;
        Wed, 17 Nov 2021 11:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TGNoMpIAOM1/ohQKGvWtxNuz5IidqZnKwf9XcToAN5A=;
 b=Y0w3kBPZaMy2NK184Zk8c+uewkwicE7TBHbHEbs0XQYipmggBj4rMiR05dKPM39USmPj
 0fKahvyNCatKO+7YiujVRH+VIcuj8OuHUWad3aSMWq40Qy0zgqrQwQyuVIjBT+Uw6hfK
 0Lv5QgAgSgU6icqLcXAc/XnB2h+lU/FIVC6zmjIEzT/ZAhXgxYvQXhYPEpDfRL0NC6EV
 jvOQI15iuavYLURrcCNapdZN9Bw8ZiMEqrI62zMVd5NU872eNoXwKFzQH8lNermDc01D
 xASvYi6ajY+J30c8y1pszABfpb/EdUlUa70vaACA7HUlePa3ef7WqycZpCkVAW59cx1q 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3e7bqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 11:45:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHBehm4099862;
        Wed, 17 Nov 2021 11:45:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3ca566u9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 11:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jghtgl5kA4JAyRdwck1i6mlEOo2mjOum110Gn8+cgiEAPYYXXEr21ev70epjAa70S6gVTo2GPoQ/K47U3ntYyCbWye7qz6CtzZrm3+vNHu1gEcSo4Ef5SnU0XLkv3jvmtbSrPxAGktbf/wmYz9zzf6zduLbTfSbyWbb4vuQjhrCJ7Y5us6YPSp6jWZGvx7f5OpjEZc+cjc/hPXzya2vf2hXIG+Jh6b2/HCb9BUTi12H2KRGERoYKf9Ot+sNRAdWXjjD4vKTk1esmiiZHVD+TAWUo8+axp06jX7HoyqVdHaMAfzdR0UWJn9OmA6d11GnJUbOWaLqi5k14cQM//VPSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGNoMpIAOM1/ohQKGvWtxNuz5IidqZnKwf9XcToAN5A=;
 b=P4uDrTX3S8MBsWhsHA9IUhLZGigWLrlU7oZdXxzm3G6Q8Shc7gZAR/TXZJdiql+fcNbf9BFbpXoI70saypRW6xtgpwlVkfhLP5z4sePptZOl9Erx9k8RvfNf+gyJmuGtN+JQ3u84PLcOsO22KUi/mtG+/HyHOQldJvG7AtOOEB4PFI81f1EzUbEN3ig9+uri4pk955jmfYiqwUN6zmW3aeIr62aGqT0/aYLrwKGfP/a/I1LpqpV+fWFzICNDtDQg2dqGQ3g2e6M0a+Sq+aLlgQrWAf9WfL6tA0+XeNJCKVaYyz7+luB3NgI6kqIAnlKTpBwhjSDqRn7Dc00JGF6u+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGNoMpIAOM1/ohQKGvWtxNuz5IidqZnKwf9XcToAN5A=;
 b=QFeipQkARJk5iv3FyhoP3NYO4V3cKD02KZcOsevE93uiGITHZWmFZDaDbFYAlm2HNXxg1d/2mBGjUez0JiBZQ/cP3L1utMnrMGM/gHKuB7XuorGhG+5axz6diN98y4OGUuw4ll3K5bhtTlCa1dK/Am/6XNLl80VZ7ltu6F/1Pzw=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 11:45:49 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%7]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 11:45:49 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/hns: Validate the pkey index
Thread-Topic: [PATCH for-rc] RDMA/hns: Validate the pkey index
Thread-Index: AQHX26O9n1eHFDuUPEaIHv9/vodVs6wHmgwA
Date:   Wed, 17 Nov 2021 11:45:49 +0000
Message-ID: <26672F24-3F75-4F41-AD6C-08AE482DE55F@oracle.com>
References: <20211117111009.119268-1-kamalheib1@gmail.com>
In-Reply-To: <20211117111009.119268-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc06f771-77f6-4fc2-016b-08d9a9bfcce8
x-ms-traffictypediagnostic: PH0PR10MB5796:
x-microsoft-antispam-prvs: <PH0PR10MB5796E051156B91A93D6491DEFD9A9@PH0PR10MB5796.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/Jz8jlseFIECRZH/bSs7/MrOIFUgxhDpJHR+rt8EaCdY9yaJ2FhGTtHFdeXaCmljBXceRqAA8U93vVz69OpkGqfPrEjhCywIvoGe/3p8zExTSRf61rrn+5Jbb8FbvZBKQaEB5pxjOLohav1yvbKgf5fJMQfNR11cfBaDmg02oa2c96mELvz66/P4EBH8aRDPDWiysOEhtsz1i64+6Zyc5Oy0hQe0qX2LYbIo7yoPmUK4KpYBIaySM3TYOHWEEHN49/7u0genWvS40OthE1d7083Vgf5fpRW0BVYnTmfz6Xg5RyKo1V276G71veRmPOU2cIls9K7GRnlUD4Qo/KT+Zc3Qy6LVyy6nZ5rfAhh6T5L3bPkvRD/VbJ9skas19lQ8tHNqVHo4kLNgHbJ/bGX7Sa7XW+dqSIeSHhEPEND4rj7nbFFKfRdYxUvceXaQlaUg7lbv0SNTjmuQe/hj/a/2bjcU62dueAHPh3hv30WrTowPPkY+j8NNR3GRX8dFRGWX55G6Gxp30O904dN396MvWgM5/8tQZwWoZ7lL9bcIQ3LWMt87GcG/Y5ygB269iTuCOwxiq+ixuh5kW+WBPS1ZWVQNSoIppVQmjA9gBeFjnIfgsfaHmzpc4A1VgowCY0GixmclYI9AFVXLQg9yWhXKKPwJT3LN3F2cOv9sn1a2mIm5pLyo8lHkFvQX1gabCovlWRF6vnvvKOrrNRFcNbscRlFX1b3ZrpBZFLsXmsXWf0xvFt3v10Lvu6dzTwq6dKc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(26005)(2616005)(44832011)(66946007)(8676002)(33656002)(2906002)(38070700005)(6486002)(71200400001)(76116006)(8936002)(36756003)(6512007)(316002)(66476007)(91956017)(66556008)(64756008)(38100700002)(66446008)(122000001)(4326008)(6506007)(6916009)(53546011)(186003)(54906003)(508600001)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXJxU1JLalNwMjhlY1ZPZEdFLzNJRUFYWW1rZnZ5b2pRZlo5NUVVNlNSYmFy?=
 =?utf-8?B?U2JDcmJObk5UYnA0ZVFXck85MW9iQUl1a3pBNWdXS1hqQzdoUnFQU2Q4RmtE?=
 =?utf-8?B?TnZIZnRhbHdFVXJWcGpRSFpkeEhxNkg2OExWT1ZyazFNbDZBRTJyNUV4aWFp?=
 =?utf-8?B?UVVpU1Y3djZWMjNEb2dNcUxERis3RkR2MHRuQng1ek9uYzUyVm1KNVhRK3Aw?=
 =?utf-8?B?LzE3UmJ1QndNaktodnl3UE9hSWFTYmpxS0JueXo0ZS9wMFZZTFFOZVQvV0gr?=
 =?utf-8?B?ZWtNcnBOaEVpbzVYc2JUUUh6c3M0V0IzTzRyTU5WdG5nbnlLZ3doUEYvZTh2?=
 =?utf-8?B?dlZXVFR1dU9KZ1B1WVhIaEE4ZVlZbjZRMit4T1IzQy9TNE16TUFCSGZzaHJr?=
 =?utf-8?B?elhwam1VcjQ4ditVbXZDaFpzKzl2anZneVJuU3BSWjBVbHRndTRoSWt4Nmph?=
 =?utf-8?B?a09RYmdhM2VwNERCZ2p0bVFkQzB2cDlMcW5RTE8rMk8rLzhvdTRJeWlST01K?=
 =?utf-8?B?ZUlXZ0JjOC8rOTdSbkRCZXN4VjVVT2V5YnlzNlltMXp3elIvd0tuaG10UFpH?=
 =?utf-8?B?QkJTUHQxcHlwVnB5NnlvMUdOWHVuRndxNXZQQnZDeGhUUnRneTlsaSt1R3ZV?=
 =?utf-8?B?ZDZ3eHQ2MWhPYlFmazF1M0VYL2NLN25jeWtzU1lLbDFPby9XZktvY0xoZXA5?=
 =?utf-8?B?bHdPclEyekJqeUpQdTIzU2pVemhVaSt6aUNXNEkrWWVvSVhnSFA1TXhSeDlW?=
 =?utf-8?B?dEhWejQ0TzhJQnE5MXZWR1NWNC9kNEMyTDN2TzcrVURGYzBPajVyTFdwNVBE?=
 =?utf-8?B?Qm1HWkpjWGV0ZUJURGdmdmdtdXcweS9Pc0k3NXBtMWU4TnJQTlFzb0pqKzBt?=
 =?utf-8?B?SXJ4K2hlcjlTb2l1d3d5dTlDelMvTGRQS3RVbjZYM2lMVkMrb3pkMFpGeVVH?=
 =?utf-8?B?Z05FYmJMaVo1djBWUkdLeEJGQnIwTlQ5T2lHTzBuTVI0NS9nUWcwd1ZpVkEx?=
 =?utf-8?B?YTdUYmVLOGtoZHFKQ3d3eXB5cEF4eUVkV2F0ZjA0Vm94ZHBndldTNjhFSmhp?=
 =?utf-8?B?QVE1bldFSmgyV3l2akxRbVhWaGNsVUd6ZU03Q2RzNjF0T0p5M1JHZFFVK3BO?=
 =?utf-8?B?VkNlWlVWUmNJeUw5MDZFaVk4UVJyUkpYdEdpMWQrZkdwRUFudExpOStWNTRH?=
 =?utf-8?B?dGY4RVExZXc2aW90K0o0eUtZRVZPOVBBOTdDekVHQ0sxUTUwY0hKaVE3SWdp?=
 =?utf-8?B?UXRrZzdqY2FKMU5FbXVycThkUnpBWlM4bmJKR3JNV0hTb3cwN3lYaENQeThF?=
 =?utf-8?B?d2ZCNmJGY0tNSVE5eExaQlduQkIrQ21qUUVVbFRTSjFHQ3BxYmFYUWpBQ2pK?=
 =?utf-8?B?U3NLcGx5c01HTGpMSzA5UnpYdjZlTEhSNUZjV1oxU01TN0dhMHU2V3VJZzRo?=
 =?utf-8?B?ckdIcGU3U2JMckg2amJzTWVnUUVUeld6V2c2d2RLQjBMdnRQMHFxTDRtNWxC?=
 =?utf-8?B?dVNoZ0JPQW5HQXdQR0tieGpiVktYWCtKVjREMDhmTi9PT0xTY2trd0MwQ1FC?=
 =?utf-8?B?S3dhZjAwK1A5cUhvTmJna09RSWoyM2tIMTczMW1nZE5SSXZza293Z051SXE1?=
 =?utf-8?B?N09VNHR2dllaM0NobWF6OEdFUUtQTlRHQUVBV3BIL3F2ZmhkSXU2VVhRdE0r?=
 =?utf-8?B?V2VvOWVnZWdNcHdWcGI5a0J6cmJVSmZ3U0JGTE1ic1dSakVVNE1iUG9MbTlV?=
 =?utf-8?B?QmhYU2hHaGtxbmN3aUQxVy8rTXF4TlQwcU9STmZDcnFuWGQ3RnIvNW1OM1FV?=
 =?utf-8?B?SkVISmxGOFRTUU5nMkwyQXpld0hkQlNDM2ROMWJ5MHhTQ2xtUXd4TThxeVhM?=
 =?utf-8?B?ZjlKV3pudXg4aU1GODhydXlnc1duMzBWSDhmQ0dZQ1ZRWEZVQUUxZ0JlWnVm?=
 =?utf-8?B?bEtHN1ZlaVhGV2thcWRpNjVRS2RqQXZTYXJ6L2h3dUliRnpMOUJwTis4U1FY?=
 =?utf-8?B?SWJzbU1vT3R1TFRJWjNDUmo2NGVOVmFqZWc3ZlJ5MHljY0FSd2xRSmVuRkdK?=
 =?utf-8?B?S21ZRmNwOEEzZWllQVVYK1hnaDZkZUkyZGRYRGpXb3N4RmJhVGVMVHQ3K0pT?=
 =?utf-8?B?QWx1WTlpNTZQTXFta1k0U056WlhnN3VFQWpxK0ZYdm51VEowSTVIMHdjeU9n?=
 =?utf-8?Q?GLLnzFVP5VhmNB+T+QxABo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A480FD6F67C5A47843F2E26E176BEE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc06f771-77f6-4fc2-016b-08d9a9bfcce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 11:45:49.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQY1oyXKU9zOIeRPAKFqMPtmiECiX0Y29zdOU5SwLpOYRJgnZ7JrsUQZR+6s9HgGDoqSBum8c/HdAdm1uAkaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=870 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170060
X-Proofpoint-GUID: hS4baq9figB5UnT-gqmtCR4ZxTu8bNgm
X-Proofpoint-ORIG-GUID: hS4baq9figB5UnT-gqmtCR4ZxTu8bNgm
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTcgTm92IDIwMjEsIGF0IDEyOjEwLCBLYW1hbCBIZWliIDxrYW1hbGhlaWIxQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBCZWZvcmUgcXVlcnkgcGtleSwgbWFrZSBzdXJlIHRoYXQg
dGhlIHF1ZXJlZCBpbmRleCBpcyB2YWxpZC4NCg0KcXVlcmllZCBpbmRleCA/DQoNClRoeHMsIEjD
pWtvbg0KDQo+IA0KPiBGaXhlczogOWE0NDM1Mzc1Y2QxICgiSUIvaG5zOiBBZGQgZHJpdmVyIGZp
bGVzIGZvciBobnMgUm9DRSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLYW1hbCBIZWliIDxr
YW1hbGhlaWIxQGdtYWlsLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9obnMv
aG5zX3JvY2VfbWFpbi5jIHwgMyArKysNCj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9obnMvaG5zX3JvY2Vf
bWFpbi5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2hucy9obnNfcm9jZV9tYWluLmMNCj4gaW5k
ZXggNDE5NGI2MjZmM2M2Li44MjMzYmVjMDUzZWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9obnMvaG5zX3JvY2VfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9ody9obnMvaG5zX3JvY2VfbWFpbi5jDQo+IEBAIC0yNzAsNiArMjcwLDkgQEAgc3RhdGljIGVu
dW0gcmRtYV9saW5rX2xheWVyIGhuc19yb2NlX2dldF9saW5rX2xheWVyKHN0cnVjdCBpYl9kZXZp
Y2UgKmRldmljZSwNCj4gc3RhdGljIGludCBobnNfcm9jZV9xdWVyeV9wa2V5KHN0cnVjdCBpYl9k
ZXZpY2UgKmliX2RldiwgdTMyIHBvcnQsIHUxNiBpbmRleCwNCj4gCQkJICAgICAgIHUxNiAqcGtl
eSkNCj4gew0KPiArCWlmIChpbmRleCA+IDApDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+
IAkqcGtleSA9IFBLRVlfSUQ7DQo+IA0KPiAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjMxLjENCj4g
DQoNCg==
