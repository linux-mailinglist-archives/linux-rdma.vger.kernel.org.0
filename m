Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538C3050AB
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 05:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbhA0EWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 23:22:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43582 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbhAZUbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 15:31:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QKT8x1138208;
        Tue, 26 Jan 2021 20:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RaSzkUIk9NN9f0LEPlbBZNKhaxDrgQ6p9zTtOQspYFo=;
 b=YHgIysZDBM2ta+snJsx88SjKF2I5itlqqs97+BLtquO8EnfaBL02C1WerkNjHPfBRnsn
 1zCOIQyfshKB6ZOIA4vl1lnxoMUrRdZrj0bwXw7Nhwu1oadveqmc80bfMy8M6JGCzB0P
 pVoh+6DbFLC6mVoVj6xy5P4cFo6rfZGiHS73bowGt98mw/W4QVrkUe9Tc61Xy/IPR4eo
 lFfj+Z08AcOd2wIDfoiMyCk1h5pbKtUpcs5Oyt9vBrZ65naDp7eucrW1t4cK+JXnpg6F
 +YPz5UgoFbMpM5zn+4w9Kdmnb9x+JBLM6BiuVI90MpuyZJ7/tCuaUT+4GVUNXN1vGwVS SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3689aam500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:30:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QKQW0n160955;
        Tue, 26 Jan 2021 20:28:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 368wpyd2g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbybl0pdl5TfwLtRiHmggERv5B/7hlC1DWamS+Tcb22qmkeSASuOkWV+1zUjizgpDWaSbKdAdZJhb4DOUBK4xCyIevesRdEL7zXHcJ/xEVFd/lR6GW3GRCf55VFJsJ3Te/LMnnLrfqcVJvCYfrq3hdBVKhwvorFOQOjQyu2zOM6ViVpfl15wdMfvNaR9EYagc485JYtdkCm0ftuuSZL4MbEpWHonOWBnCAZbWL1Rdll9qOccMO0AocfEWpfO0JHrTAJa8EszBLZQTiQMaDWLBqjH3YZSzUuRu6aDnQfTHwSx07cAZO6GV4ZO6I46cOyvLPVx8UI7uWgtU6ecUKPEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaSzkUIk9NN9f0LEPlbBZNKhaxDrgQ6p9zTtOQspYFo=;
 b=KJV/MfGAtl2T2IGEOI4c9NPls/PbwG/EeY4Cpva4eVD1hWWlGXvzXtRQ38tuCEVbuMFvwaLFdrzE4BzsSJhVcfCys4YjOGlmJFV3J/4tS1Xk/cWxn1aFYbxPrn/AXjvwUGC8MUyPCtDZtVHkOy08Km2PJeojKgZudODPghBJ5CnlKS091jsNRB+8+KNYTmRNEqH5dwntWFZ9FQ22T1ENU6mo0OaLQ/7mHVyVkt9wg7M1Da1kO5cOOPr9Obz8yiMv2jrcCnJdxtBjeoInOVYJxmOMfchPwmBUdhzLWzTxbTFVjfR8mah0xXTRGqxx3WlTr0h1zxz7xxRPpXkevc7b7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaSzkUIk9NN9f0LEPlbBZNKhaxDrgQ6p9zTtOQspYFo=;
 b=DXJsuoz9yXVkOvf0i6mIDbLWfKYwiD5qUwCwkzBh5tyiqmLVFTI7uhHufiFVAgzGx61vulGl/3TIiTi4sMPWefRjWLt01W4yqc51DAzVYnYtKqS8g75fnAlGPW+owTDFxzsPEFjeBNgWvCUZow0qDZoUOYvClj17foqNIQXKb9o=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2216.namprd10.prod.outlook.com (2603:10b6:910:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 20:28:18 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::3163:8bae:8ec1:2113]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::3163:8bae:8ec1:2113%11]) with mapi id 15.20.3784.019; Tue, 26 Jan
 2021 20:28:18 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "valentinef@mellanox.com" <valentinef@mellanox.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Topic: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Thread-Index: AQHW8B2EFFpDwAYD0EGnoNjWohUt36oyYseAgAZSsQCAAa3bgA==
Date:   Tue, 26 Jan 2021 20:28:18 +0000
Message-ID: <6F3F22D0-2E85-4505-9179-2D2699EA2E2E@oracle.com>
References: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
 <20210121181615.GA1224360@nvidia.com>
 <CO1PR10MB45162B7BD3F61C91C0867213CFBD9@CO1PR10MB4516.namprd10.prod.outlook.com>
In-Reply-To: <CO1PR10MB45162B7BD3F61C91C0867213CFBD9@CO1PR10MB4516.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a2b646-4f03-4994-f18a-08d8c238eadb
x-ms-traffictypediagnostic: CY4PR1001MB2216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB22163FBFCA6D251FCFD850D2FDBC9@CY4PR1001MB2216.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKcKiXWzsQfhwmsOPbKlFJd+bONd2+fPaigoSPY5UzibTcqVPF026OkbrWjj5TW61R0ssZwtn1xgvivai6r0odiwEIsbsEjgN8X+3nrvZhlmZ2F6C9H088VWhwt75jnS6C7z1EP4GY7RC9G4xy2hLPUkGOIoFl9YwP+t8vbtK7VAhTjlK6vUb1qMwW23NM35ssxJFj8Akre0AVi/n65pNOc2XbMwkhWeGyoVoQ9m/wzc8UJ4xgBATrHH3EZAITMLfXySOFOOhEcjb6oBI75UbEIk82bK7lzt7uU0zjGxOlqA+v6KLmk3H0XdCvQ0hnLk2aXmzBxOA4F/hfvF5hQUgW6UorE/covFmP2XTk100V0TSfNHM9r9LlsCAU/78iucdfMFPT1GcIr7F7iL4InZDZv4QHc9J5HYLg9BsCpkzaZqhPmDP1h0kS0BHY29kPEW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(54906003)(91956017)(66946007)(66556008)(66446008)(2616005)(66476007)(76116006)(316002)(64756008)(5660300002)(107886003)(6916009)(186003)(44832011)(33656002)(2906002)(4326008)(478600001)(66574015)(6512007)(83380400001)(8936002)(86362001)(26005)(8676002)(71200400001)(6506007)(53546011)(36756003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VXBYRkV3Z0RvcmpIcE94aEh6MkdEZFhWWFI0TEVzKy9SL3pGU0pIV25DaU9r?=
 =?utf-8?B?RnFFZDlwYTNETjk4NCtCWVFRVzFrWjhNbGpmTklVMDFLamVJMG5vVVZpcmU0?=
 =?utf-8?B?OGMzaS9ENE9SaFRhK3ZLMHFCcjFXQi9mZlEwVlpwaXZFdDFYd3A3RVBZOVpr?=
 =?utf-8?B?bVRxNzJGV3FlNHdkR3RxZ2J5WTM4VzBPZitEVzFrMHZJWnNDRkN4VDI3S3dl?=
 =?utf-8?B?TnRKMWZiY0lNVXQweHowMzloZCtXa0l3aDU0TzNnNUh4WlVRQ1BFNHkzUUJT?=
 =?utf-8?B?WDZoUnhjemkxQ1ZaRmFCcnR2WjZCcnZNYjlXTVUrbERmQVNGOUtzZ3ROSTZF?=
 =?utf-8?B?Tk42b1BYamRhM2F3bTEyLzYzc3VTbWhLWlVFc09hMVB0U09DajY4dWNBdlJh?=
 =?utf-8?B?TXpyazczWWNHMHhqK0NlY3lHa3g4SHBKUnluMWpmRUtPOTFuRm1BeWt4Sk1G?=
 =?utf-8?B?eGlwUXd3aVJnUzBJWXJpbkxBUFlUei9heWR4dzRnTVJhWTZvWTNvb0t5ckd1?=
 =?utf-8?B?SUdBRTYvYzlRZlpIQ3U2eURxV2l4RU5IMHNkQlBSN1JsSVpYNmNpVk5uckEv?=
 =?utf-8?B?dm8yRFlpeTNDb1MrTjdTMUFFWE1DOVAxZVRNTHJPczRjSzcyZk91REliekp1?=
 =?utf-8?B?UzV5OUFBVVNSRWlDNkt0ekJqMDI5OGNJTm9xMXlCQ0ZwYTBabHNCbndDa1lv?=
 =?utf-8?B?dGJiRU1NRUVYeWpLenp1QzA0U2ZFSGhBTWxnSW1mZ0xzUTg1L2JPYVRyaHBo?=
 =?utf-8?B?eTZYVkJvNDlFQnFhNCtPQTgyaFZqakRkOVZmN3RYZy81Z0VDd3drZWVSOFM4?=
 =?utf-8?B?aU1DMFpYQlpKcHZTUC9PcEZ1bVpmZkIyMnEwcnBEMFpXZTc3ZVNtVzBxRFVM?=
 =?utf-8?B?T2VYdTZ6UG9vTTlnbkNWbnRNZFFIZ0IxQVNiKzlqKzFPSU1JTFk3YUpnQkgv?=
 =?utf-8?B?cE9YbWpWZWJxWEZJNVlvZlJUMnoyVEZjc0JBT2RucFdydThqSURXRFBPWGpp?=
 =?utf-8?B?Qkkwdy9QMmZqUWRlR3pFUXVLR3h3T2FqckJkSWppOXNQNDh3K2xvOTI4MDR3?=
 =?utf-8?B?Qldrd3M4TmphK1V1OUJnWGxzMXBKVlgrTGl4MTJwWnMvMEFjMWlPL0dNSlh2?=
 =?utf-8?B?L3BCU0JhYklVOS9wOGxDeWhBQ2J0THBvcUhNcXZGWCsrbm5TY1hyZWJzVE03?=
 =?utf-8?B?cndxSW9lamIwT21wdUJZY2g1TmxOUUsvNzZ6ajBNd3Z3WUNXdWtROG1zb09I?=
 =?utf-8?B?V1dvc3pOUVF1MG5ZbEVKdlluOVZJNUFWTVNZMmpHczNDU3RYUUdQWXR5Y092?=
 =?utf-8?B?S2p5RVdNTHg3OW9QUmt5RHErM3BuWXJPZHF1TUk0UzRaZmV2YWN3RHJXMVR6?=
 =?utf-8?B?ME1LOW8vblpNdVY2VGNYU3NOZlN4VGFCVEtjek5NM3hoQkc2NVBDSU4yQUcv?=
 =?utf-8?B?alpIcE82Z216SzgxNzJIOElINXpiRjVsYUc3bkdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11E07478F074AD47B9473EDC78CCE6B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a2b646-4f03-4994-f18a-08d8c238eadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 20:28:18.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84Wkob/6duqX35wOnP9qqSh+WKKb4KDQ2rAi8f2aqd8Q/knfvanj2PpnzuEWJdAobIBHXclIernziYlWf7jjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2216
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjUgSmFuIDIwMjEsIGF0IDE5OjQ5LCBNYW5qdW5hdGggUGF0aWwgPG1hbmp1bmF0
aC5iLnBhdGlsQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFRodSwgSmFuIDIxLCAyMDIx
IGF0IDA5OjUwOjAzQU0gLTA4MDAsIE1hbmp1bmF0aCBQYXRpbCB3cm90ZToNCj4+PiBpcG9pYiBj
b25uZWN0ZWQgbW9kZSBwcmVzZW50bHkgcXVlcmllcyB0aGUgZGV2aWNlW0hDQV0gdG8gZ2V0IFBf
S2V5DQo+Pj4gdGFibGUgZW50cnkgZHVyaW5nIGNvbm5lY3Rpb24gZm9ybWF0aW9uLiBUaGlzIHdp
bGwgaW5jcmVhc2UgdGhlIHRpbWUNCj4+PiB0YWtlbiB0byBmb3JtIHRoZSBjb25uZWN0aW9uLCBl
c3BlY2lhbGx5IHdoZW4gbGltaXRlZCBQX0tleXMgYXJlIGluIHVzZS4NCj4+PiBUaGlzIGdldHMg
d29yc2Ugd2hlbiBtdWx0aXBsZSBjb25uZWN0aW9uIGF0dGVtcHRzIGFyZSBkb25lIGluIHBhcmFs
bGVsLg0KPj4+IEltcHJvdmUgdGhpcyBieSB1c2luZyB0aGUgY2FjaGVkIHZlcnNpb24gb2YgaWJf
ZmluZF9wa2V5KCkuDQo+Pj4gDQo+Pj4gVGhpcyBpbXByb3ZlZCB0aGUgbGF0ZW5jeSBmcm9tIDUw
MG1zIHRvIDNtcyBvbiBhbiBpbnRlcm5hbCBzZXR1cC4NCj4+PiANCj4+PiBTdWdnZXN0ZWQtYnk6
IEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogTWFuanVuYXRoIFBhdGlsIDxtYW5qdW5hdGguYi5wYXRpbEBvcmFjbGUuY29tPg0KPj4+IGRy
aXZlcnMvaW5maW5pYmFuZC91bHAvaXBvaWIvaXBvaWJfY20uYyB8ICAgIDQgKysrLQ0KPj4+IDEg
ZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KPj4+IA0KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL2lwb2liL2lwb2liX2NtLmMNCj4+
PiBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvaXBvaWIvaXBvaWJfY20uYw0KPj4+IGluZGV4IDhm
MGI1OTguLjAxM2ExZDggMTAwNjQ0DQo+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9p
cG9pYi9pcG9pYl9jbS5jDQo+Pj4gQEAgLTQwLDYgKzQwLDcgQEANCj4+PiAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlcGFyYW0uaD4NCj4+PiAjaW5jbHVkZSA8bGludXgvc2NoZWQvc2lnbmFsLmg+DQo+
Pj4gI2luY2x1ZGUgPGxpbnV4L3NjaGVkL21tLmg+DQo+Pj4gKyNpbmNsdWRlIDxyZG1hL2liX2Nh
Y2hlLmg+DQo+Pj4gDQo+Pj4gI2luY2x1ZGUgImlwb2liLmgiDQo+Pj4gDQo+Pj4gQEAgLTExMjIs
NyArMTEyMyw4IEBAIHN0YXRpYyBpbnQgaXBvaWJfY21fbW9kaWZ5X3R4X2luaXQoc3RydWN0DQo+
PiBuZXRfZGV2aWNlICpkZXYsDQo+Pj4gCXN0cnVjdCBpcG9pYl9kZXZfcHJpdiAqcHJpdiA9IGlw
b2liX3ByaXYoZGV2KTsNCj4+PiAJc3RydWN0IGliX3FwX2F0dHIgcXBfYXR0cjsNCj4+PiAJaW50
IHFwX2F0dHJfbWFzaywgcmV0Ow0KPj4+IC0JcmV0ID0gaWJfZmluZF9wa2V5KHByaXYtPmNhLCBw
cml2LT5wb3J0LCBwcml2LT5wa2V5LA0KPj4gJnFwX2F0dHIucGtleV9pbmRleCk7DQo+Pj4gKwly
ZXQgPSBpYl9maW5kX2NhY2hlZF9wa2V5KHByaXYtPmNhLCBwcml2LT5wb3J0LCBwcml2LT5wa2V5
LA0KPj4+ICsJCQkJCQkmcXBfYXR0ci5wa2V5X2luZGV4KTsNCj4+IA0KPj4gaXBvaWIgaW50ZXJm
YWNlcyBhcmUgbG9ja2VkIHRvIGEgc2luZ2xlIHBrZXksIHlvdSBzaG91bGQgYmUgYWJsZSB0byBn
ZXQgdGhlDQo+PiBwa2V5IGluZGV4IHRoYXQgd2FzIGRldGVybWluZWQgYXQgbGluayB1cCB0aW1l
IGFuZCB1c2UgaXQgaGVyZSBpbnN0ZWFkIG9mDQo+PiBzZWFyY2hpbmcgYW55dGhpbmcNCg0KSXNu
J3QgcG9zc2libGUgdG86DQoNCiMgaXAgbGluayBhZGQgREVWSUNFIG5hbWUgTkFNRSB0eXBlIGlw
b2liIFsgcGtleSBQS0VZIF0gDQoNCj8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCj4+IA0KPj4g
SmFzb24NCj4gDQo+IFRoYW5rIHlvdSBKYXNvbiBmb3IgeW91ciBpbnB1dC4gSSB3aWxsIGV4cGxv
cmUgYW5kIGdldCBiYWNrIHRvIHlvdS4NCj4gDQo+IC1NYW5qdW5hdGgNCg==
