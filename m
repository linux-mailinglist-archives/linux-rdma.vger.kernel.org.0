Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0C3BC185
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 18:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGEQSt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 12:18:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhGEQSt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 12:18:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165GDxae018828;
        Mon, 5 Jul 2021 16:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6fCN3MmU1finNPSm34QCQq0+Ch++u3X1Hr76pu5tToE=;
 b=f2YF/25QbrRAE0x8zo1pXewoEA5Jqp/RJKZGtgUtaQQYbySGxZGCYQxve3ZYLSbUxxrH
 BGAq5IIDgAZeUn+N68WLQ6OQuuYdaGIJEc+ILKtx6r5SIDpoPIz+5KR59LnAkhqJ5W1a
 SY04BokiDsrPvsQ8pHGwEjBStE6u2Pres++IyBk98bl1reSI2ryUklc67gcj8mHC9sTL
 ywW0VBTbYOSrj2Bii9WsFsgPZ1HUh0xPkjKjxJveOXtXB7tfm50vXjmgGyKVqHNkqfPW
 W5CFX7F/p/5R6bg1HzCiz/qqmmKgouFC23/cXdcZZgu043V80Nts1tp8DJCUn9sLloOr dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mh8630-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 16:16:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165GACxX194643;
        Mon, 5 Jul 2021 16:16:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 39jfq744ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 16:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqHZdRATK3bDb/GGwL6nJoRcYBgjip31l+Zo2Vo3gkPXp/Ab8BPSe1t/2/QP9TEIi4BSnta4N62HtnWo/oIL3MQKR5IuMiNIAd4xKQ0KYBfoy8pqNikI0qhQXofn8OIcI30lJC7s8w00JQi7GCTP6wGi7nXqiFtx/+8veT6PYLqlIpuSv2kA7Soya4Q/V4gKdX7EmhOLULaJ3X7AiinC5v7jr+ZhEy6l6aB4XD5kAUTe95c/YBHjSxHK/r4VLQnSQyCdAecxhuxRVMvyTcuZSwp0X2TNiiqcePwhsWAsfzr2gGYRcNGxksQoQ1sfwg79k8rC4s5S25g24yO8AII7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fCN3MmU1finNPSm34QCQq0+Ch++u3X1Hr76pu5tToE=;
 b=AtOVUsKnuTZy819Aqh0W2ISxChd7TdZPg+HHYNFJlipBsCmjxaUz8prAcJRbI2GuA9BncT4FdohT4gTufjQrrSHjsFBTrAKq6Y0tYI0LO8bI4tyHHcI0THNMJmVL401F3NqJbKs+c1quJth/frN+JYMddofa5unFIkH5/3izmvbHR3iM2IE8J9vSP/AkKttM9Y/4TxFk2BAlgeSryPKwqNSO14Bw9N2zOPd7bqYaOtj8GvB6jRZMy+csvP0Sn4G/vNyCrgwnydFGo6VlgjB4dPmTm2qv8DTKaWtSBrXIN6cSFb5PA7EAbaoAbqoeolyza9xyCbQjNx0GezUmSso8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fCN3MmU1finNPSm34QCQq0+Ch++u3X1Hr76pu5tToE=;
 b=bHWjbtgzFyswkZCK1C5fm8YYf8YxfwzUekns9DOle6pVofBOIXwCqcqgvS7B3pVkFVwy8bDG7Q5Znbd8JVG8C1Y218UVwIZFm04YxaSe+2xTGZ22RIxUCLxo9ondPwbqa7A8gFuLJyhSsOLoChqEc5P0FFda3k7urSLkKADnDvA=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB1820.namprd10.prod.outlook.com (2603:10b6:3:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Mon, 5 Jul
 2021 16:16:07 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 16:16:07 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Robert Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Index: AQHXcSU4qkk6csRmHEOkD1wzCNoukKszvTqAgABMdICAAAVqAIAAdrUAgAAKBIA=
Date:   Mon, 5 Jul 2021 16:16:07 +0000
Message-ID: <056CB5DA-EAD8-4E6C-9252-CBEF22E3D731@oracle.com>
References: <20210704223506.12795-1-rpearsonhpe@gmail.com>
 <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
 <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com>
 <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
 <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
In-Reply-To: <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 739397f3-b7e3-4c26-c9e7-08d93fd031e1
x-ms-traffictypediagnostic: DM5PR10MB1820:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR10MB182082F25705893375762A10FD1C9@DM5PR10MB1820.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YX6cb9TuznwczLhsQHFzixLCyg1OBFu7X1T1FX5Lp10fscSTUYvPM4kTZ06WYxU9WDA+/ofma/aMkx+c8IGkMBz/FIvidavIOjPaUMK1LfxxObR83CuJsld3MhXna9cQUXmbH/qZjKWFWDRErjtR04LN1CgcN/x1gt3q/5nq8XC0HdV86wGC6RedugYShSPmfza/22WUzcimjuw6iNrPD39t0rUjW7UL+ukxE8lyPIZ00dcPTl8c5S+7cPyFqjFDKjjCrFiOHf/6fs8jsvRB9QPyS60/wSwIxojR4J54jWKSpp5t4Z4qCiRtvJqkr/qb0KIP5kv9/3Xku96YInQtcXvhEBx0ktW5dLWRKXDUoeEW1qCwKWS6w1DyEAeTSaX44YDk/zKa/cv0J9zt7vXCi0SW8ZozC+qLOXruMbsPpguZk7q/3mZCbdwBeTryM3owD5hEOhLGQodrSsn52Eu50jMWnaFvlf5pryQoWLBkQzMFkjh/dShNygoOoMC4dsjpenj7fIKM+3pBSyh9H4vy/ALwgNY0Ih+5YEIGonpk2GktshLBMjaEjk1PXDunCOg8zf7UJlhJDtlMENPnz+MEjMYxxDzyeMOo5yl7JoLTjhrXdluooWHWrr6SHkwQChHk+1aoLKPJWpckwtd3E4e3LOXViV7RLFbZ18cLmerPjbIHcNYp9K4UWJn3FkGqEN0Nh4B6IW0QFosaqbVoGUBz5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(2616005)(91956017)(6486002)(8676002)(76116006)(44832011)(66946007)(8936002)(2906002)(66446008)(64756008)(478600001)(66476007)(4326008)(53546011)(6506007)(26005)(83380400001)(5660300002)(186003)(36756003)(316002)(33656002)(86362001)(6916009)(38100700002)(122000001)(66556008)(6512007)(71200400001)(66574015)(107886003)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHdkK2tCc2tTTXQrMWRsbmFUYW9YckdJVlhGViswdzVybS8xS1haUUtVTTlO?=
 =?utf-8?B?bEJGYU1pNVA5R3ZyMVp2ZmlRU3hjYUhOMjMvQ0FxVTE3WC9maHBvRkdwc2ZG?=
 =?utf-8?B?TzAwRUdsK2tTbGhQL0w0Ky9jSGZaT1hCRlk5Sm11cXhVRW52Q0h6UkxiOVhn?=
 =?utf-8?B?ZTFKNVFrdkNacWRveUJ6SnNCQXA0OCtCVUl0dXY3dGRzYmV5VjR6czBHYWl1?=
 =?utf-8?B?Wk9aeEpPam91RXlBQklxclAxNlQxaytCNElLcGxWazU0WE94MEo1TGtSNVpL?=
 =?utf-8?B?SlZYOG5vOUlKaGFlZDhCNWNqZ1hXdUR5RVhtcThNZVd0ZEpkZi8wQUhubURF?=
 =?utf-8?B?bjZuVmdEdWJSbmdiclBYUHdUVGxpUjdIVEMrYnZwdWZYKzZBd3RJUGdmMlNT?=
 =?utf-8?B?ZjNNTjFab1J3MEN5NktISlUycXJHNTYrcThnUm4vY1NuRGxCeEdCaWYvNlhi?=
 =?utf-8?B?V3JPY2NVdy81RDVtRnViaVBOOXhEVVRWQlNpYURKam9RNGY5SGt5dC83cmFX?=
 =?utf-8?B?bW5UcTBlWjgxV0tjRE5wUXg0RHNKRk5lYXNSKy9xR0dXK1dySUJrSWRtTVBV?=
 =?utf-8?B?eUJoQk9KbmFzbE12eDhrRFF5d3VnYjRXbjlFYkI4S0hKV2dqaXYxbTVTTEdS?=
 =?utf-8?B?Zk04Rmx0K1JqYUZ3VjZiQ0FqKzArb3cvSjFFaCtNNERVd1RpSWhLUDljSHJ0?=
 =?utf-8?B?UHhKMEZicHRjMWNZbS9KcmtNUk9VV0ViY1FRbEhCaWgyUlRNZUJQZmhEL2hx?=
 =?utf-8?B?SFpsbCtEQlNGU3RMVC9mRFZ4Y09xekliVk10UzVtOVQycmN1dHFIRVRsYTYw?=
 =?utf-8?B?dG1ack1hUEhFRWtlNEl5aHJTNG1iS3NTSnVhYkcvajN0aUFJOHA5dkpUVXFG?=
 =?utf-8?B?UHFiZ1REZGZta3R0dG1tcWhKUm80R0UrY2tTckVIKzJUbW9SVldtVy92eWpB?=
 =?utf-8?B?MGtqa3NnVVd5cDR3MG5MWnJzQ0NyMzF6VSt4OVdiT2VoN1g0amc5WHNMdElr?=
 =?utf-8?B?a2VUNW5OK1BnQTVuUXhhNmh2MjVtc3NINitVbGlwRDhaa3p5MnBKTml2bUpP?=
 =?utf-8?B?RTVMQmNmajErUmQxdE9kOWVMbjBMaVpWOHVpcUszRGpmTXI3dCtKd2MwUERV?=
 =?utf-8?B?dndOTlorYUFYMTRVcDkyNGtnTCtRNWgzbW1VczNzay91NDRLRlhtdTJsVVp4?=
 =?utf-8?B?TUpPK0V3OUJvTmM1MHlQaGhleGljRUZ2SVZPWGJpOWpMUzhiWEE1S2tudnhP?=
 =?utf-8?B?eGk5b3g5YkNSTENEK1NhMWwvM3FscElNU05GY2ZCY2pvdThzN1NMd3NYN1Zr?=
 =?utf-8?B?c0ZhcFRoTHFteGJ1bEVOT1VTK2tWRkxOV1Y0ejNGN3ExQUw0aWFRRlhmRE5z?=
 =?utf-8?B?Vi9SZkN6eURoa2tlTUlidis4a0EzWmwrazliWURGa0hSVDVWNGEya1VXQ3dz?=
 =?utf-8?B?ZUJzVjk4RDM3WGFsTG1JaUdWS1hnZUExeWFycFNXSjIvNGZLV1RRQ3VSOEZJ?=
 =?utf-8?B?azY0UkdDQXlZZjA3WFJiNGU3NHpMOCt3OHhGK2Q4ejlkQjFmOVduZmhvbHRB?=
 =?utf-8?B?RElzeENPOWxneDdnQ0FNNzBkTjFvdlJtZHlUaHFFNzkwT2dPSDhqVGNzYXVP?=
 =?utf-8?B?YUwvQlcvN3VDUUNSeCt2aWI5UlJEcW0wb2MyNkZIVjJST2x4VEtWcWc5TWZ4?=
 =?utf-8?B?RE9KZUo0aXZWb1Q1bFFHK0VIdUtibG9ra2dLYTJpL2dEdVp2aHJxemc4UllP?=
 =?utf-8?B?cHU2VDBORUU3K2UwS0c1andRMk5VT3Nxb1lxRC9HUkprQTRjTFBmazlUbjVK?=
 =?utf-8?B?bTVsVzd3OERabllMQzhKdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6555A4E353C0AD46A0B632AA69467A7B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739397f3-b7e3-4c26-c9e7-08d93fd031e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 16:16:07.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8WhwwOoB8gZA8oT3VZ1lYoRPicpvwmSZnLPyPInqLjN4Yq2ZZnskstroiI61jBn8eRRf88i3M3RR2YUnUEL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1820
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050086
X-Proofpoint-GUID: wpGDbm6fWwAoKkYh10OZjOIir2ZQ-MMh
X-Proofpoint-ORIG-GUID: wpGDbm6fWwAoKkYh10OZjOIir2ZQ-MMh
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNSBKdWwgMjAyMSwgYXQgMTc6NDAsIFJvYmVydCBQZWFyc29uIDxycGVhcnNvbmhw
ZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSmFzb24gaGFzIGJlZW4gYXNraW5nIGZvciBwYXRj
aGVzIHRvIHBhc3MgY2xhbmctZm9ybWF0LXBhdGNoIHNvIEkndmUNCj4gYmVlbiBjbGVhbmluZyB1
cCB0aGUgY29kZSBuZWFyIGZ1bmN0aW9uYWwgY2hhbmdlcyBzaW5jZSBpdCBkb2Vzbid0DQo+IGxp
a2UgZXh0cmEgc3BhY2VzIHN1Y2ggYXMgZm9yIHZlcnRpY2FsIGFsaWdubWVudC4NCg0KT25lIG9m
IG15IGZvcm1lciBjb2xsZWFndWUgInRyYWluZWQiIG1lIG9uIHRoaXMsIGFuZCBhbG1vc3Qgd3Jv
dGUgIm5vdCByZWxhdGVkIHRvIGNvbW1pdCIgb24gbXkgZm9yZWhlYWQgOi0pDQoNCk15IHByZWZl
cmVuY2UgaXMgdGhhdCB5b3UgbWFrZSBvbmUgY29tbWl0IHdpdGggc3R5bGUgY2hhbmdlcywgYW5v
dGhlciB3aXRoIGZ1bmN0aW9uYWwgY2hhbmdlcy4gSWYgdGhlIGxhdHRlciBpcyByZXZlcnRlZCwg
SmFzb24gd291bGQgc3RpbGwgYmUgaGFwcHkgYWJvdXQgdGhlIHN0eWxlLCByaWdodD8gQW5kLCBp
dCBtYWtlcyB0aGUgcHJvY2VzcyBvZiByZXZpZXdpbmcgc2ltcGxlciAoYXQgbGVhc3QgZm9yIG1l
KS4NCg0KPiBJZiBJIGNvdWxkIGZpZ3VyZSBvdXQgaG93IGliX3VtZW1fd29ya3MgdGhlcmUgaXMg
YSBjaGFuY2UgdGhhdCBpdA0KPiB3b3VsZCBmYWlsIGlmIGl0IGNvdWxkbid0IG1hcCBhbGwgdGhl
IHVzZXIgc3BhY2UgdmlydHVhbCBtZW1vcnkgaW50bw0KPiBrZXJuZWwgdmlydHVhbCBhZGRyZXNz
ZXMuIEJ1dCBzbyBmYXIgSSBoYXZlIGZhaWxlZC4gSXQncyBmYWlybHkNCj4gY29tcGxleC4NCg0K
Oy0pDQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+IEJvYg0KPiANCj4gT24gTW9uLCBKdWwgNSwg
MjAyMSBhdCAzOjM1IEFNIFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPiB3cm90ZToN
Cj4+IA0KPj4gT24gTW9uLCBKdWwgNSwgMjAyMSBhdCA0OjE2IFBNIEhhYWtvbiBCdWdnZSA8aGFh
a29uLmJ1Z2dlQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+PiBPbiA1
IEp1bCAyMDIxLCBhdCAwNTo0MiwgWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IHdy
b3RlOg0KPj4+PiANCj4+Pj4gT24gTW9uLCBKdWwgNSwgMjAyMSBhdCA2OjM3IEFNIEJvYiBQZWFy
c29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBJbiByeGVf
bXJfaW5pdF91c2VyKCkgaW4gcnhlX21yLmMgYXQgdGhlIHRoaXJkIGVycm9yIHRoZSBkcml2ZXIg
ZmFpbHMgdG8NCj4+Pj4+IGZyZWUgdGhlIG1lbW9yeSBhdCBtci0+bWFwLiBUaGlzIHBhdGNoIGFk
ZHMgY29kZSB0byBkbyB0aGF0Lg0KPj4+Pj4gVGhpcyBlcnJvciBvbmx5IG9jY3VycyBpZiBwYWdl
X2FkZHJlc3MoKSBmYWlscyB0byByZXR1cm4gYSBub24gemVybyBhZGRyZXNzDQo+Pj4+PiB3aGlj
aCBzaG91bGQgbmV2ZXIgaGFwcGVuIGZvciA2NCBiaXQgYXJjaGl0ZWN0dXJlcy4NCj4+Pj4gDQo+
Pj4+IElmIHRoaXMgd2lsbCBuZXZlciBoYXBwZW4gZm9yIDY0IGJpdCBhcmNoaXRlY3R1cmVzLCBp
cyBpdCBwb3NzaWJsZSB0bw0KPj4+PiBleGNsdWRlIDY0IGJpdCBhcmNoaXRlY3R1cmUgd2l0aCBz
b21lIE1BQ1JPcyBvciBvdGhlcnM/DQo+Pj4+IA0KPj4+PiBUaGFua3MsDQo+Pj4+IA0KPj4+PiBa
aHUgWWFuanVuDQo+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBGaXhlczogODcwMGUzZTdjNDg1ICgiU29m
dCBSb0NFIGRyaXZlciIpDQo+Pj4+PiBSZXBvcnRlZCBieTogSGFha29uIEJ1Z2dlIDxoYWFrb24u
YnVnZ2VAb3JhY2xlLmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxycGVh
cnNvbmhwZUBnbWFpbC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX21yLmMgfCA0MSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+Pj4+
IDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4+Pj4+
IA0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4+PiBpbmRleCA2YWFiY2I0
ZGUyMzUuLmY0OWJhZmY5Y2EzZCAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX21yLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX21yLmMNCj4+Pj4+IEBAIC0xMDYsMjAgKzEwNiwyMSBAQCB2b2lkIHJ4ZV9tcl9pbml0X2Rt
YShzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpDQo+Pj4+
PiBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1NjQg
bGVuZ3RoLCB1NjQgaW92YSwNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICBpbnQgYWNjZXNzLCBz
dHJ1Y3QgcnhlX21yICptcikNCj4+Pj4+IHsNCj4+Pj4+IC0gICAgICAgc3RydWN0IHJ4ZV9tYXAg
ICAgICAgICAgKiptYXA7DQo+Pj4+PiAtICAgICAgIHN0cnVjdCByeGVfcGh5c19idWYgICAgICpi
dWYgPSBOVUxMOw0KPj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWJfdW1lbSAgICAgICAgICAqdW1lbTsN
Cj4+Pj4+IC0gICAgICAgc3RydWN0IHNnX3BhZ2VfaXRlciAgICAgc2dfaXRlcjsNCj4+Pj4+IC0g
ICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgbnVtX2J1ZjsNCj4+Pj4+IC0gICAgICAgdm9p
ZCAgICAgICAgICAgICAgICAgICAgKnZhZGRyOw0KPj4+Pj4gKyAgICAgICBzdHJ1Y3QgcnhlX21h
cCAqKm1hcDsNCj4+Pj4+ICsgICAgICAgc3RydWN0IHJ4ZV9waHlzX2J1ZiAqYnVmID0gTlVMTDsN
Cj4+Pj4+ICsgICAgICAgc3RydWN0IGliX3VtZW0gKnVtZW07DQo+Pj4+PiArICAgICAgIHN0cnVj
dCBzZ19wYWdlX2l0ZXIgc2dfaXRlcjsNCj4+Pj4+ICsgICAgICAgaW50IG51bV9idWY7DQo+Pj4+
PiArICAgICAgIHZvaWQgKnZhZGRyOw0KPj4+IA0KPj4+IFRoaXMgd2hpdGUtc3BhY2Ugc3RyaXBw
aW5nIG11c3QgYmUgYW5vdGhlciBpc3N1ZSwgbm90IHJlbGF0ZWQgdG8gdGhlIG1lbWxlYWs/DQo+
Pj4gDQo+Pj4+PiAgICAgICBpbnQgZXJyOw0KPj4+Pj4gKyAgICAgICBpbnQgaTsNCj4+Pj4+IA0K
Pj4+Pj4gICAgICAgdW1lbSA9IGliX3VtZW1fZ2V0KHBkLT5pYnBkLmRldmljZSwgc3RhcnQsIGxl
bmd0aCwgYWNjZXNzKTsNCj4+Pj4+ICAgICAgIGlmIChJU19FUlIodW1lbSkpIHsNCj4+Pj4+IC0g
ICAgICAgICAgICAgICBwcl93YXJuKCJlcnIgJWQgZnJvbSByeGVfdW1lbV9nZXRcbiIsDQo+Pj4+
PiAtICAgICAgICAgICAgICAgICAgICAgICAoaW50KVBUUl9FUlIodW1lbSkpOw0KPj4+Pj4gKyAg
ICAgICAgICAgICAgIHByX3dhcm4oIiVzOiBVbmFibGUgdG8gcGluIG1lbW9yeSByZWdpb24gZXJy
ID0gJWRcbiIsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKGludClQ
VFJfRVJSKHVtZW0pKTsNCj4+Pj4+ICAgICAgICAgICAgICAgZXJyID0gUFRSX0VSUih1bWVtKTsN
Cj4+Pj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjE7DQo+Pj4+PiArICAgICAgICAgICAgICAg
Z290byBlcnJfb3V0Ow0KPj4+Pj4gICAgICAgfQ0KPj4+Pj4gDQo+Pj4+PiAgICAgICBtci0+dW1l
bSA9IHVtZW07DQo+Pj4+PiBAQCAtMTI5LDE1ICsxMzAsMTUgQEAgaW50IHJ4ZV9tcl9pbml0X3Vz
ZXIoc3RydWN0IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+
Pj4+PiANCj4+Pj4+ICAgICAgIGVyciA9IHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1Zik7DQo+Pj4+
PiAgICAgICBpZiAoZXJyKSB7DQo+Pj4+PiAtICAgICAgICAgICAgICAgcHJfd2FybigiZXJyICVk
IGZyb20gcnhlX21yX2FsbG9jXG4iLCBlcnIpOw0KPj4+Pj4gLSAgICAgICAgICAgICAgIGliX3Vt
ZW1fcmVsZWFzZSh1bWVtKTsNCj4+Pj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjE7DQo+Pj4+
PiArICAgICAgICAgICAgICAgcHJfd2FybigiJXM6IFVuYWJsZSB0byBhbGxvY2F0ZSBtZW1vcnkg
Zm9yIG1hcFxuIiwNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5j
X18pOw0KPj4+Pj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3JlbGVhc2VfdW1lbTsNCj4+Pj4+
ICAgICAgIH0NCj4+Pj4+IA0KPj4+Pj4gICAgICAgbXItPnBhZ2Vfc2hpZnQgPSBQQUdFX1NISUZU
Ow0KPj4+Pj4gICAgICAgbXItPnBhZ2VfbWFzayA9IFBBR0VfU0laRSAtIDE7DQo+Pj4+PiANCj4+
Pj4+IC0gICAgICAgbnVtX2J1ZiAgICAgICAgICAgICAgICAgPSAwOw0KPj4+Pj4gKyAgICAgICBu
dW1fYnVmID0gMDsNCj4+PiANCj4+PiBXaGl0ZS1zcGFjZSBjaGFuZ2UuDQo+PiANCj4+IFllYWgu
IEl0IHNlZW1zIHRoYXQgc29tZSB3aGl0ZS1zcGFjZSBjaGFuZ2VzIGluIHRoaXMgY29tbWl0Lg0K
Pj4gDQo+PiBaaHUgWWFuanVuDQo+PiANCj4+PiANCj4+PiBPdGhlcndpc2U6DQo+Pj4gDQo+Pj4g
UmV2aWV3ZWQtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+Pj4g
DQo+Pj4gDQo+Pj4gVGh4cywgSMOla29uDQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+PiAgICAgICBt
YXAgPSBtci0+bWFwOw0KPj4+Pj4gICAgICAgaWYgKGxlbmd0aCA+IDApIHsNCj4+Pj4+ICAgICAg
ICAgICAgICAgYnVmID0gbWFwWzBdLT5idWY7DQo+Pj4+PiBAQCAtMTUxLDEwICsxNTIsMTAgQEAg
aW50IHJ4ZV9tcl9pbml0X3VzZXIoc3RydWN0IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxl
bmd0aCwgdTY0IGlvdmEsDQo+Pj4+PiANCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICB2YWRk
ciA9IHBhZ2VfYWRkcmVzcyhzZ19wYWdlX2l0ZXJfcGFnZSgmc2dfaXRlcikpOw0KPj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgIGlmICghdmFkZHIpIHsNCj4+Pj4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJfd2FybigibnVsbCB2YWRkclxuIik7DQo+Pj4+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfd2FybigiJXM6IFVuYWJsZSB0byBnZXQgdmly
dHVhbCBhZGRyZXNzXG4iLA0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19mdW5jX18pOw0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gLUVOT01FTTsNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnIxOw0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGVycl9jbGVhbnVwX21hcDsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4+PiAN
Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBidWYtPmFkZHIgPSAodWludHB0cl90KXZhZGRy
Ow0KPj4+Pj4gQEAgLTE3Nyw3ICsxNzgsMTMgQEAgaW50IHJ4ZV9tcl9pbml0X3VzZXIoc3RydWN0
IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+Pj4+PiANCj4+
Pj4+ICAgICAgIHJldHVybiAwOw0KPj4+Pj4gDQo+Pj4+PiAtZXJyMToNCj4+Pj4+ICtlcnJfY2xl
YW51cF9tYXA6DQo+Pj4+PiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBtci0+bnVtX21hcDsgaSsr
KQ0KPj4+Pj4gKyAgICAgICAgICAgICAgIGtmcmVlKG1yLT5tYXBbaV0pOw0KPj4+Pj4gKyAgICAg
ICBrZnJlZShtci0+bWFwKTsNCj4+Pj4+ICtlcnJfcmVsZWFzZV91bWVtOg0KPj4+Pj4gKyAgICAg
ICBpYl91bWVtX3JlbGVhc2UodW1lbSk7DQo+Pj4+PiArZXJyX291dDoNCj4+Pj4+ICAgICAgIHJl
dHVybiBlcnI7DQo+Pj4+PiB9DQo+Pj4+PiANCj4+Pj4+IC0tDQo+Pj4+PiAyLjMwLjINCj4+Pj4+
IA0KPj4+IA0KDQo=
