Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0445A5F6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKWOqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 09:46:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26258 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232316AbhKWOqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 09:46:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANDx2hg004412;
        Tue, 23 Nov 2021 14:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EqL+KWx0DKRwNUsnJxXhyYCRXAy38IH9zjzoUARZWG4=;
 b=GeZ1ShAZcASQx6K2uhaScTTTp3vOts4VtZAoWWG3KaQZsm4uwz5hhWaSnyeUGY8JUCfC
 M+vkCKtGAUGeCFospIdqIAfev413ihQwq3NB1AOJJYHIqDjDJF/dGvPR16XcSTyRNulG
 ZKIiI8V2UVns2Mfup0OykgAmQiH6C86nE+MXoRkrWsWwQQ5nTIK+S0CKb+lA9Wo2Apu9
 u7wa62Jqjr4liEArEzpgmMFNQ2Ca5S9dcGic9ZDf4fyrgh07RufuDMg86fhnXtggzdJg
 cuXlxJSJIwDLgRycq8F9ZKG1FldeEH7CukijEoduqakqc3MvqB2GwtSC5zmTGAsGapRg gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg3059gnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 14:43:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANEKnAr178310;
        Tue, 23 Nov 2021 14:42:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3ceq2eav5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 14:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKkgkTPeZBgCSU1YRHRIPSQr86ICGY8PvXJoOezLftQIjndfaNbn7K1O1OuVWt/+raoQnBUgoXCkvFv1gs2pUn86eADd27gNL3s8xfPu6fdvcylNImVgP6HsesSppis8rrVbvySbw4og6Ove5Eb8Mfd8LhdQI7u+OpzgzGZHCfr4THCvMQSozo9U3H6d8RPJdb5iJ+TbmodBikHzsMrZFHRPpOKS95viAjZj0NgsNt1J6glZOEKPtUOqWYxIE1ZfJdX3nb+Ukn/Mex9sSlBgZg3DJ2OWrVxBHtbKltjt3SLpAxq3R2ufNdAE10rUK69OZj8pIygknyueZJE00VJSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqL+KWx0DKRwNUsnJxXhyYCRXAy38IH9zjzoUARZWG4=;
 b=KEMdhup5oad0kvPtEwYL/rjHHkVoNg48BSmxm7wqsrZ3GB5WN5hz1I2PSzRl5m/JQgE4JPF/t5UfMdTvtjN/OdfPbRHpWlAe8teFmNCa3vl517p7udXSJjMpH+A2TxRqN0Ftt3jC68gGOx4Z2Pdd+FO5L+MHJhET3Z1yDO0kqyRWgQgjIbKfokJg8jU9eRib0J8E8XWyFju8c0oFt5AdMnxkzOJa2ZpPA+5EohjSuqhjM1jhpckjllVN528j9N9NSDHbh8S7R/8DpUm04u+1rwlPAKJPfmjPV10vDHujWutYoEj5An4vLeuerEjIoMh3tCQNcpRKvMpJY/OLn27jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqL+KWx0DKRwNUsnJxXhyYCRXAy38IH9zjzoUARZWG4=;
 b=r4/E5xNVmoHC0PlKuhbonMKUfj8zrKHVD/KXC8ALVytxGZ1nyHbu6O3y0EbXdmddqt9jT+I5kbe4NiJnrf+XUzlG/xRhATCdj7CzjRzXI3Ypps6idClTZ3oIrOyF+HiXv4NiB3van5793VDp/9Uqhzy0gX/C+LfUKnvGmIt4m1I=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by MWHPR10MB1758.namprd10.prod.outlook.com (2603:10b6:301:9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 14:42:44 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::7d4a:284a:f0b8:1511%9]) with mapi id 15.20.4713.022; Tue, 23 Nov 2021
 14:42:44 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Jack Wang <xjtuwjp@gmail.com>, Doug Ledford <dledford@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: Two announcements
Thread-Topic: Two announcements
Thread-Index: AQHX3L7mLBX64A7lEUGAxKXofPqToawNscYAgAMvRoCAAFYDIA==
Date:   Tue, 23 Nov 2021 14:42:44 +0000
Message-ID: <CO6PR10MB563525E2CB8E2300524B89F8DD609@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
 <YZoJrPGtQJ9e3v9K@unreal>
 <CAD+HZHWjAKp2Qht7OQgYT6Uu_MjTrgXf_YEDCLHHeG0hh=yyAQ@mail.gmail.com>
In-Reply-To: <CAD+HZHWjAKp2Qht7OQgYT6Uu_MjTrgXf_YEDCLHHeG0hh=yyAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38028f4c-5af9-4bf5-a333-08d9ae8f82b0
x-ms-traffictypediagnostic: MWHPR10MB1758:
x-microsoft-antispam-prvs: <MWHPR10MB175858557BAEF41ED733D733DD609@MWHPR10MB1758.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q83YXeyznK/iVOwRuar/SUjC0iWoM7Iuh8p/WxBiK9e75Lwe+SRu/WG5/VQwHXdCboS0eFtSzXpJ3p9mOv3xRZc4bZsVw/4a1MhzLD51U7DtpNtVaQFByUgZhJLZnGzBguTUvmrPUCn9S71ihohOylwKF/khqsbEUjbIsmWc/EgTzLz8BaZ/W2xTDb2a9LHxlLn0UeZs9lOcIzd/JpcBeyIjIRS5Zp60IEZt6phf1o3+IktNHoHcVVC+S/9mPjNvHNhFqV79KT9Eg+UM3+AqPFeNGiqGot/33kuhVjedg2dQqNeG0eQhG/ywOeWkxfovzkgVq+pgP9hyxuYsExoBpsFlYF1GnglJa+oSTOBXELSeVuE9kzwISTfI9TVfzn4Xvz+Bn47LDGMGrcI0aAhkFyS2fS3L6Y6/ij3dpHz8pF5ht7ND44pqQnUg9RgmHy6IgbOOnXpk8PiOCO9yHXh6JGCGVoup5GsAvoHL4/5h8xPVeHwS8XKw4uCTPGitJWcR9sBtwXYVWkD/8Im0UWLueduHBfOxfZZfkM+/OyZ1aS5TecyOucLkwJNQ8fMgpZdG3BDMAPRoEr+laTEzRJIG3EgA+l1QQhESCcmfumOBkd5SvI5dGE+GU9D6AA5lAoBI42UDrRk9e+szlryhnZJg//Qpi1/PI3PS2462hAWSOzhI9ufvuMXPH82ivsogaLefIeWGqd98KcYrJX08KCTh/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(26005)(55016003)(33656002)(186003)(110136005)(4326008)(508600001)(5660300002)(54906003)(2906002)(6506007)(86362001)(71200400001)(3480700007)(53546011)(38100700002)(66446008)(83380400001)(7696005)(7116003)(38070700005)(66946007)(76116006)(66476007)(66556008)(64756008)(316002)(52536014)(8936002)(122000001)(4744005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtZSnprRkR1U3MxaXVQQ24zN0x5cnJLS0l6c0tGd0swSEREVEUreTRScnhn?=
 =?utf-8?B?enNaY3FjeHhzM0p0U3NDZGxidmdZY281d0pJUElPMzl3NzdhTnNxWEpWVzh3?=
 =?utf-8?B?K3NGQjl6YWd5d3FtQ0wwOUVQZUxBd1hVR0pScnRaZGljSWxDUlIyUlU4QTVw?=
 =?utf-8?B?YjFFUTVxd3NyK2JXWE9KTE04WlNEckoyUkdZSzlveHdxY01rTFpFYjlCekZW?=
 =?utf-8?B?MXd1WXJ6dUliQkszdGlrNVJqU2k4alV1Nkl6WU1EQzQ3dDZHaVAwc2xPSStm?=
 =?utf-8?B?WXNIVjZRNjZLU0JLU01ndS9VcTQrdm9FL2lsb3kyc2wyeVRuMWdVcy9rZUlv?=
 =?utf-8?B?NTVnOHh5blJ6UlNDc3pOWTl1a0g1SzltNGpzSG9HYUxOcHVpTXhnMXYzU2t2?=
 =?utf-8?B?UDBReHd3cFdVWlZMVkMrSzhWV0FiR29kUSt4NVBleWNxQ24xV3NKdHVESEdm?=
 =?utf-8?B?RHFlcDMwTkd5TkEycHFSWmFZK3l6SS9aejhaR0IydzZNNUVoZ3pDMXFoUjB1?=
 =?utf-8?B?YzRVY3BYNnprOGF6Zk5yem9rS29SWi9XNHViWklhdm5yM3ZuRk5KWHF0b09O?=
 =?utf-8?B?VU9pZUdGU3M3czJ2djdCRS9XUFVYbU12aklleStBTzU0YjVxYXgyVnJhV3Jr?=
 =?utf-8?B?V0Jtcm1SQ3dkeDFSOVgrU1AvYkd2WUgyaEd3VzFmdWswbWNEY0U4N1Nya0dL?=
 =?utf-8?B?eStGRkk1VlhSeWhGdGM0ZnBpS0pWTHlCN2hwV0laYmhwaHh5M1BtUUR1cTBJ?=
 =?utf-8?B?NmZXZjA5djBVVEM1NmtNVHUyazRVMWpuMFJwRGdXd0p0MlNZYjB2L1BMN0lX?=
 =?utf-8?B?dklsZ0ZOeHBHcjhJQWwzQ09icGd4Zk0wS3FXZ3FjRGM5QnlyaVQ3aHFoSzJj?=
 =?utf-8?B?WjV2TDJhTUFYQWN5Y2N2cmEreWdjZ0hJekhHQnEyZGYzaEFKUEZLL09iUEhH?=
 =?utf-8?B?UzV1ak9IZzVBMDM5aHU2YXlORloxKzgrUVJieWNqbG8rMWpSTWk0aTgrN0Zz?=
 =?utf-8?B?TW96M0tvSjFFUmNHeWNrUVBtZCtJd2NMWTA0UlFZRjFxcWhEODc2NnVTK3dt?=
 =?utf-8?B?S3Z0RnhqTXdmNm1neFN5U0M1bUx3ZFo2aWRoTmp1N1FHbDJNTldJTGZwbmZE?=
 =?utf-8?B?VlVuQjArY0hyUjZxZkl3cDIrS0F6VEJ2L0diVDYwZy9TT3JMYXZ6eEJNWita?=
 =?utf-8?B?elB1LzBLOEU3U3QrMVNTSWNSa3Zad2NnQ3FteGtpZ2M0NW1CaHJ1RFVmWFk5?=
 =?utf-8?B?THlJT1NQaWlmdkdYZXp6VGdjT2E5WldFZWcwMXhNdTltQThkQ0dkRDZnempX?=
 =?utf-8?B?eHlyTmpYUDUyUzFaUThpaUFNZmJ0REZTRDBLdUJaa3RWNUtwby9qRnpqVVZF?=
 =?utf-8?B?V3dTbncyNThsZ2k4WHd3bXhoREVRV1oyRE16eTVOei9USC9uNi9GNUN6Ty9H?=
 =?utf-8?B?L0dOcGZQcWZZSCtaalh2dWl0SWNvUDBuUmZ1aVBiKzV0RE9iMEptTFI5YUdp?=
 =?utf-8?B?ZVoyZkNlY1cxOEY4bktCRituRURqWFdmTnFkRU5sWEIvYWtXQUhEa05zcDFw?=
 =?utf-8?B?M2IrelJETHl2U1o3cExNMWlhbkN4T0ZzMVN4bFpSaUlNalpaQzJEbForejVz?=
 =?utf-8?B?SXZTWmxwQW1FY1VvdlZXcjl5SGpmNXQ2V2NGR0w1NDljclFnZ0s0L2cxK1ph?=
 =?utf-8?B?TzJTTy9Td0xhVm8vdlh6dFV1WXFpSmhmS1ZEWEJFME9nRkptbEVqMGFzK0Iw?=
 =?utf-8?B?Q29lL05UbmFUdmNyL2prZ0JyZG43QlVVbUtweDVuWWVlOVlUeU1nMFhFOFJt?=
 =?utf-8?B?clJnVlpnVFgwZmtsb004Rm83dVJXNHZOOFZtQnkyKzNpNWlKRnFxbGZNVCtS?=
 =?utf-8?B?bmNRR3RuUDNtK08ySDRnN1grWW0wUnBOMWNWQmpsME9rZi80S3ZmYk9nWTZ0?=
 =?utf-8?B?TDFzdFZ0OHJ3ZlIxVHhSR212VFFIZkZtSjNXcjVxblp0KzJLalY4ekZaWFFw?=
 =?utf-8?B?VEJ3dnpmS2svenlySHZ5akZkbkNpTVJXSEYyYW1VcitwaS9sdzFoMkxXWWtT?=
 =?utf-8?B?R1djV2l3bTY2eXVzMUU5RzNhOFlNaW15OVV4YVdNWjhmSVVzR0VnUmhkak5q?=
 =?utf-8?B?dWlYK3FuZWhid3MvT2FOSlVaajJVWHl6MGRJZEVFc3UrOU5KcUNqTE5sZXhx?=
 =?utf-8?B?dEN2OHhPaXV0UUdPNkFjczQ1S2g5bmxxSmcrQTZaZiswKzV0b0NmOEJhN2RJ?=
 =?utf-8?B?ZTNUVXVrd0k1UlpTampjZVcza2lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38028f4c-5af9-4bf5-a333-08d9ae8f82b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 14:42:44.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+SSia6Jdit+Jc1OyS0YxlNgZfc9HrKOVy3C/TU+eyETk11o6XQ/vN21lzxFsWBcYqYsbG1iLJlJWjTtf5XudturrLLzjWPdQSsSOygXsZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1758
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230078
X-Proofpoint-GUID: n1H11x6MgMz0fCz4iklLNoac0xdd5wPz
X-Proofpoint-ORIG-GUID: n1H11x6MgMz0fCz4iklLNoac0xdd5wPz
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjayBXYW5nIDx4anR1
d2pwQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjMsIDIwMjEgMzowNCBQ
TQ0KPiBUbzogRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPg0KPiBDYzogTGVvbiBS
b21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBSRE1BIG1haWxpbmcgbGlzdCA8bGludXgtDQo+
IHJkbWFAdmdlci5rZXJuZWwub3JnPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFR3byBhbm5vdW5jZW1lbnRzDQo+IA0KPiBMZW9uIFJvbWFub3Zza3kg
PGxlb25Aa2VybmVsLm9yZz4g5LqOMjAyMeW5tDEx5pyIMjHml6Xlkajml6Ug5LiK5Y2IMTA6Mjjl
hpkNCj4g6YGT77yaDQo+ID4NCj4gPiBPbiBUaHUsIE5vdiAxOCwgMjAyMSBhdCAwMjo1NzowOVBN
IC0wNjAwLCBEb3VnIExlZGZvcmQgd3JvdGU6DQo+ID4gPiBGaXJzdCwgbWFueSBvZiB1cyBoYXZl
IHRhbGtlZCBpbiB0aGUgcGFzdCBhYm91dCB0aGUgYmVuZWZpdCBkZWRpY2F0ZWQNCj4gPg0KPiA+
IDwuLi4+DQo+ID4NCj4gPiBUaGFuayB5b3UgRG91ZyBmb3IgeW91ciBkZWRpY2F0ZWQgd29yayBh
bGwgdGhlc2UgeWVhcnMuDQo+ICsxDQpUaGFua3MgRG91ZyBmb3IgYWxsIHlvdXIgZWZmb3J0cyB0
aWxsIG5vdy4NCj4gDQo+IFRoYW5rcyENCj4gPg0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBEb3Vn
IExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+DQo+ID4gPiBHUEcgS2V5SUQ6IEI4MjZBMzMz
MEU1NzJGREQNCj4gPiA+IEtleSBmaW5nZXJwcmludCA9IEFFNkIgMUJEQSAxMjJCIDIzQjQgMjY1
QiAgMTI3NCBCODI2IEEzMzMgMEU1NyAyRkREDQo+ID4gPg0K
