Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890C13050AA
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 05:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbhA0EWF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 23:22:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49266 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405021AbhAZUB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 15:01:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJxGTn077240;
        Tue, 26 Jan 2021 20:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kDoCifdpUpfnKLXO7vRxwDhTdybqCntcYLuz3qyS+As=;
 b=lgilhq3bv4tnrSjMFCdJGStsik04nE9fhKnkg/pHPJu6VZC7K16DcRLfOPGHSJxcrpO+
 iEafVMTZb/nWGpc7It0hMSCUKW9GR8bEGBFezqlF22seT4tPZALUx31xBlu2fpAiuyVl
 ta9t9aK5wzb7DIq+3NS/Ze9LFYAThWg/PF9cv51bk8nLnBkRMocQ11rQOecXIi24TFCc
 JBuX4sbR7ZhP/MQmk53OsU/6lHApg7a2oCjjoirGtdQXlsyAC+KC1JVgisTGG4M9Wp40
 p5WNd74/MPD5b4Gjz+Z/meAQrQn0l8mD76EDweDKycFZI8vqykE6b/BEsmwAcUx218kM 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3689aam1cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:01:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QJxbJP164971;
        Tue, 26 Jan 2021 20:01:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 368wjrkyfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 20:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzyI6M+TSB4TvOHFjEyPtdqkM9XSO8eiBxjW6RxYDfruTnJarFeg1jN4cF6NX/LloK+krmLkgsBSdO5a+7cRBYJhIidhu+CRnm2hjWBJ+90yom3dijP7QhZosKn94s1s9pwT+zj/O5YZOPpZRrRAN2tSnGVqPDjZBJgjGVnFNn+cFFYqzzucgNUF6LXmfj/wQd8EVnAF2mDZoIXOOJxnQW61EsUDsvDX+p6ihSaL0iPL4KZpktiYkuz/ZUrUkhoho7uNssXpYhJ5S5TivaCumUdOWFg8r2mKJFUZSg5Pnj9PKEobDlBgoyWFE6IjRd9s6Lpu04BVnSUCUN+6nfjfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDoCifdpUpfnKLXO7vRxwDhTdybqCntcYLuz3qyS+As=;
 b=GTud+2kMfRyJJDLiIxie1CYvyZ72I91FBH0ISLiNhBnnX1PHfmaEYQBncc2DHnuyZrFX2cLvY+XDSDKj9aMhwHww6pX7wiWlfyswjzOaz3jO9LIbyMdSR2fA2EHHfwBKJ+c4TqyAuihfdLmdAY4l5IxL5h41YFoCtP7tIC37jF/fpq4dlU7+47Rz3/fcTQgNtSewLMjNfO9sZg3HgAxdneI7/MT5ndygnJUzDc2TJSjxekLasGgqwC09fy6g+TsqwiCDr8rguqHPERfAp/FhiHAThj+JqN6lUUNNzAbHpSygZUKiaJUoc2sl64Io2OOpiXdEmcrSBG2DPhT53vUA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDoCifdpUpfnKLXO7vRxwDhTdybqCntcYLuz3qyS+As=;
 b=y5OTiad+pg9LKIgKtlO9WdxMUlfPM0ybHgVVZJZ8QeVt3QDGbBBEWMKiz92PyZ50b6YfGE7Tt7AHtpi+XGb7iNTEnFFLaWNT8Fz3heogNkvejgShF7AVyjouaJtrxjqsS+wMp1ESgSIDqyy7l48iwuqb6ASUqupbSNcBWQFohN4=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2152.namprd10.prod.outlook.com (2603:10b6:910:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 20:01:01 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::3163:8bae:8ec1:2113]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::3163:8bae:8ec1:2113%11]) with mapi id 15.20.3784.019; Tue, 26 Jan
 2021 20:01:01 +0000
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
Thread-Index: AQHW8B2EFFpDwAYD0EGnoNjWohUt36oyYseAgAZSsQCAAaY8AA==
Date:   Tue, 26 Jan 2021 20:01:01 +0000
Message-ID: <75E58994-9E67-4CD1-889B-77A8B8B5A1BA@oracle.com>
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
x-ms-office365-filtering-correlation-id: e59d2e4b-1a5a-488f-39ce-08d8c2351b14
x-ms-traffictypediagnostic: CY4PR1001MB2152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1001MB215247B15F419DD7542DCCB7FDBC9@CY4PR1001MB2152.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIRN81MaasVxDRUlzI1ZAyQfjfaDDhOi99j3p81TblVFDvE5Uzn+u1Kw3gZDuMMF7Q+D2nj46MZV7SOXXzYMBC6OG52yjeGxlM0sAZA4mZACpXjvTdNDDrZfC2V/Bswq1KQgllUw9kutFxLwNkOw4n966Y+pVKElfXCYCtGrohsGXK9lUokrgfMT/gXnn6wk9XTZAWz7uKZu8/1QhHkIIR5S5u5nq5/Ybc4OSPS5rC+Jw0zdUGIKRlw727IGatTneGTovu50tgI/4vrjA7HmOMgWIbdBCWyexqIhlgn9W1battpOkugkcOaLuzD99W5OytIn+RWUigXZX7QdtGcICCg9ZkVqbZTi8Yg8JtVWp88QQqMC+hDSkWmWk4prZLs+Roi8FJTAagnJ1FNp33soPMe+y2UJ/z/3DcD1Q/ecq8RHNj8KWabgq7F3IFKgk8hdZftYzX7gPpCPBErwheb0zkuXGjHU5LEf7zpzmmKzaKn3FH0O4k2eOfESEVTSAroogtoL6rerVgA9fUrwwxFD9Dvx/59eqb2iwdGQBy7TPMEM2hDUjhyTj95zC0CD1mEg7y7zVZdGixl8wtpEJxc7yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(33656002)(71200400001)(54906003)(2616005)(86362001)(6916009)(316002)(6486002)(8676002)(76116006)(2906002)(478600001)(91956017)(66476007)(66946007)(66556008)(64756008)(66446008)(6512007)(186003)(66574015)(6506007)(107886003)(53546011)(26005)(4326008)(8936002)(83380400001)(36756003)(44832011)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZmhiaE1nTEl2UTZMbWtxRWplZU42UlFqZHBrcm44bHptdUFHRzFDSmw1MGQ1?=
 =?utf-8?B?ZDJsYnZqdE9TZUtkUUdOOTNuYTVrUWFEVkJWalh6NHZ4dUZ3czltdU9Zc0Nq?=
 =?utf-8?B?R2lvZlhpVis1UmdnMmx6UnM3SEFlUnFnVUJzK1hEMVQwcm1ZRTg5N3k1T2ZF?=
 =?utf-8?B?b3d6bXdZK0RhaktIc2h5K2N5SmdZNTFvSzdXaVNFY0MzWEwrakJ2RU1TMHF5?=
 =?utf-8?B?c00rOHFyZUVheTIwQkNJcTdiS3R5UE5PUEhsZDRIUEVQRm5XZ3pBT1N5Z3Jt?=
 =?utf-8?B?WDZ4SmExbkUvRmIyQXBGWjRBNlZ3Zy92aFpZN0cyNVlDcmh0cE9oWmsrcWRw?=
 =?utf-8?B?ZFIza3JVaWtrVE9wZ3BRVUpqZnBRWFBzZkJ6RUNwSHZ5MFRRMEZjZFRPQTFK?=
 =?utf-8?B?YXVLcnFRYmxYdmNldmRXNVdUSkpkZENJUE45UlBib2Q4TWhWb2wwelh6N3lC?=
 =?utf-8?B?ekxTeExWRHZBNVpKdVBGaXFxdCtURlBHRlpLS0xESFQ4a3hHb1dMSW1uUEV3?=
 =?utf-8?B?SWIrY2ZpV3JTbEJIa1Avb0FVTkRZREM5MXFIVWljeUViUUErblc0b0RzVER5?=
 =?utf-8?B?NzROZzJKcnhBSDh0aHovQ2c2bkJRdHE2Z3RMR25hMEg4NCtTRjJzMTBUc0dm?=
 =?utf-8?B?UW5RbXI2TFBsU0lwTWFXOTVrK3BaRXlaWm9vRFg4S01tUC83dUtKOU92c2VX?=
 =?utf-8?B?d0ZpUTNraVljN29mT2kxS0FWVm9QRERwb3k2SEZna0IzWUVBL3JCQkUrd2RX?=
 =?utf-8?B?RHk3bVZleFphYmt0VFo2U3JkU1BuWW93dFJCMkpIR0xRMVRGWGY4dmhTK0VQ?=
 =?utf-8?B?cGVOVUVObWx1OTM4RFNEc3BRMGFJSko2UjRKU3J0RlZuRlFMeWRkbWpxVkg1?=
 =?utf-8?B?SExMVHlMSnRodlBXaGFmajAzVWxMWTBKNHA0N1JnNE5WTTF4ZHg4TndYMnd6?=
 =?utf-8?B?eTVROVdKY1cvamh0U0NwbTczUnZSWGVQWUxJc21HK2lUVUpRaENLMVA2UXVL?=
 =?utf-8?B?Y0N6SUY5ZWF2YlNqSW9OTjhTTzkzaUVYTFU5SHFReFlmOWhRdENqMWplQWNr?=
 =?utf-8?B?bFR0dTFoaDdlOVo2UytFaVcwQThDbnVNZlVaM29Xa1hSNEhnbk9tYmtNNXN3?=
 =?utf-8?B?cG00TjViNnBCY0U4M3JFOHovV2FUa1NhWmtoOHhwUDZiUmZqakZ0eDQ4Y0h6?=
 =?utf-8?B?eEE5LzZ5OTh3bjVtQ3A3cXFMT0p1Qi9SejYwTzJEWkJ0bGRJZUJ1enNCd0RU?=
 =?utf-8?B?M3lxN2dhdkhvUVlzOEE1M0hsNTZPYS95ODJ6U3NBa05nRmFKUkF0ZmN3UVFa?=
 =?utf-8?B?a2xmd004dFJjYWs3a3dMVXFPZHlZQUdOU1cxWk5WQmoxWVFHUU8vMWlwSnNO?=
 =?utf-8?B?c1MvWjJNYW4vVnJxRmR1TjcxRlZ3YzRIYTRTblcwUUhmUXIwaEhNK1FNMVcw?=
 =?utf-8?B?cUdvL0FrWDNIeGFSWEI5Q1hlQXhQSnVyY05EMzVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61E54F97635F624496A1EE9855898915@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d2e4b-1a5a-488f-39ce-08d8c2351b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 20:01:01.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIoiEpt4rm5VT83FlDoIoqmL4FoaFqP3oMBNNxpaNqTgvcmMZpnjTQNltMfBANQ8lhqeDihAHMwKBwYJeyrFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2152
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260102
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
cmUgYW5kIGdldCBiYWNrIHRvIHlvdS4NCj4gDQo+IC1NYW5qdW5hdGgNCg0K
