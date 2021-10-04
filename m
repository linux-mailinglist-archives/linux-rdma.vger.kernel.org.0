Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7036421374
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhJDQES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 12:04:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50904 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236294AbhJDQEQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Oct 2021 12:04:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194FUiOQ002173;
        Mon, 4 Oct 2021 16:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oi1+0+dBZX39U/Hp2AyQXc9XU2pOKtmwk+BGt5q7E4A=;
 b=AKxSqLA9pmtmbPmjHf5htUpJmdqwFV4435SMRlRTFtSkTHF9sbBsaV9wM4OGom19HMq4
 lk5Tv1E1o3YOS2Cg251n6i/K2bzkCFeTfUUbDvKq0ZMzt0NWlRP45NOLY4z/Skr6zyog
 5G8UJG+58V1VlnhQHeP6GioBluy6FgqUZ2oBrcFIEWQT3K3OmXPJTsdo9tb4CXzhcm3E
 MAFjgcuwa4etewyI/0LHUZTauxBvJNpQTW23m2TophzLvBsR5CA4i0tdKeH12NLKpu8A
 /80qmGdAeR84R89r+WVZDgDcBe5EgFqtNn1ErZ3pgavje5Lq4GDF+SPQ48ZyD1WtNOig kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43drbe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 16:02:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194G0cv5113317;
        Mon, 4 Oct 2021 16:02:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3bf0s538t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 16:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VndZQwq0amEoJKYr1z+ChmBGOdeRxXjeeSLnHRrwwJ9wGfBmVTrZY8TN5i8HBPS1MvlsJ3TMpic0HQ58Y3hwweYEXOIyloY6BBRtbT9bCX1qL1G+bQFnDoK+3SJ8q2LRa6vyXWyAcc/cvUsM+g/ZCjKIM5HoPVdMTVvliGFZW3zUE3mxasP4Cig7NCRbZnlv0cFIn3YtBN4KqJB/aGSgxxeh+hPgMEa3AoCgGiCDttHlOkADT7xwZVFcqme9cvzDDta3GZNXjh9o2hsE3LiVC1Hgf/5794r/9WQK1rq7yK1ZHCsrP/lUVSYE3gQCH3frwRj7pS4A0/mxy5uls5tE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi1+0+dBZX39U/Hp2AyQXc9XU2pOKtmwk+BGt5q7E4A=;
 b=Budv7i7257b2eQB106DJYPK9OLy1+54sL/un2zohLD6uy8P0T530aZcrcMS+sWoxJTaMcvtgVmXsYYzoPx9kD7KyPXjCCNW4nlBUJHYAZnZjIYRvbDxn19r8i4TiF5NluWno38ffr5fXXmdlgBB8pPvJAJrte1kKl/f1mOSzPuKsgmNaNjw9vMTVKCB63WbGfTFEZdf6m1q4PMPqh9N+7AGuB9Eai/791zi7fXln49gXvf8Wwe2JYr8azMjAPxP9+2R3qkaFkkx+4/chvVAKaW9J7wef8v05X9f6bR7v/EzJfT6k+8X7yyTXX9OQozqxKHm5Zd/LZiTJx4UJoTSMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi1+0+dBZX39U/Hp2AyQXc9XU2pOKtmwk+BGt5q7E4A=;
 b=SsMxoh0y28RxROF7cxGXXF+xvGPlC8Vhi+wY1OeHwNErCL41f93+7xAinYWxN/89anRylDxTrwrplrgDu1Cb9JRGjWmPsHgzCgIzMi22l3/CvUpz9uZHxev/FyGUbw+4mjcpLhwMJPbN4KZk0C695lFWuHb3en1kVicPaU1MEOg=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4440.namprd10.prod.outlook.com (2603:10b6:510:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 16:02:07 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66%5]) with mapi id 15.20.4566.019; Mon, 4 Oct 2021
 16:02:07 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
Thread-Topic: [syzbot] BUG: RESTRACK detected leak of resources
Thread-Index: AQHXuR1Mng7SBYlRlUq/oXyFf+LqJavC0YMAgAAB74CAACyuAA==
Date:   Mon, 4 Oct 2021 16:02:07 +0000
Message-ID: <4F4604B1-6EF7-4435-BB12-87664EF852C3@oracle.com>
References: <0000000000005a800a05cd849c36@google.com>
 <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
 <20211004131516.GV3544071@ziepe.ca>
 <CACT4Y+bTB3DCGnem7V2ODpwgmiQdGuJae+h93kfniYn1Pr_x2g@mail.gmail.com>
In-Reply-To: <CACT4Y+bTB3DCGnem7V2ODpwgmiQdGuJae+h93kfniYn1Pr_x2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 828b3acf-1cea-4308-1bc1-08d9875050f5
x-ms-traffictypediagnostic: PH0PR10MB4440:
x-microsoft-antispam-prvs: <PH0PR10MB4440EE73583E4E1041E7BE08FDAE9@PH0PR10MB4440.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTjK89lgaUbii9VnBFf8pYeqHi00cpNfxOoL4KvW3sEM94beSKGd5rZrp7nmg/20YHe1dTTl0PXFoY9NGlwa6+AvkiJ8S8LoladaVf0K5GjFyuLiCDG1k5tn3IqjnGb9AYPGVZYMa0G7u1TNZALCKmsd6MBnB4MJYq7TZe6kksE2FivmM79As3mDrf8bRDpjvmWaH073qIIVErbtWhTiix9Ok4fauUsxRXTBpre/QC8TTHzbgyTQgCm03Xa7z70YedwHwhX4ixA9Ny/WDXTdLabtjab+NppS6Pf/HL7oi2MwiWkr4SYsSx2bcDFareVsEnTKuflOYmqzFojVrR4tkW/QSHYjIyfOuD7LPh16ZGpd1XS/8LJWzeOfxZBU5Kyyq6ZCix/0yMe1YH7u63zPeEcPBuM1ygonI8zsOgoXCs8CbcarGdMUC/SEJS6bNPKO3Z4ACTWjonb2kW71IoWvgnxNzkLWFfm4uouhONq9WzktQMtEDPst4hGzOgQgDNMzV5n2FwG5rJPV7b6aX0T8R9fZD3AxtsMKPveAqrpfvuH9TnSWecU9lwiPDCYA+we7pBPpcAdI/B30aKjDk1ULw2JPA9iFJjMbkdHPzTonQpnfK7gcx2KdSz+YLAYNwHtjIENkcBx2BagqURxAeDxZ6rUjOyi7QsWp87qXd+dbMs3/nyQUZAtsMv8Tz63nOp6m0snNHC7qRKBL9uAk79JrrbgWB+at0XTBrW1SqWrqUb6zURRr6v4eR7gg2JaxdKzHNkhPNCY8U9OER4Am26Dx1r3wyPTIRT7a9sKRy/w0iEqoBYTOXMiNrTF5rjftOB6WEWDmS/kuD9jMu+3yx4GHyxW9CaLOvW8QlziloE5wy4P1upkt32yMHPUgA1kd48aL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(8936002)(36756003)(33656002)(6506007)(5660300002)(54906003)(53546011)(316002)(38070700005)(508600001)(2906002)(44832011)(8676002)(6916009)(66476007)(64756008)(186003)(66446008)(86362001)(76116006)(91956017)(66946007)(26005)(4326008)(71200400001)(83380400001)(66574015)(2616005)(6486002)(6512007)(66556008)(122000001)(38100700002)(99710200001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJCaHlhOVlJYVdVQzh4eFFqSDhMa1NicHJraHk0V1V5ZHpDUUhvQnlaclVE?=
 =?utf-8?B?Q0V6eFZGN3NYbFdlWENnT093T2taSEZWcWVURzVGb1ZsTjFiSExxVFBYcXB5?=
 =?utf-8?B?Uk9Belg3Vy9ZYi9FRksxMEJuVmYyZkJvdlp5Tld2WERza0t1ZmluTlZudEo3?=
 =?utf-8?B?MTlRM3E1dVJqUlo0dnFpZnpCYkV2WWpDOStiL3Q1WU1yVE9LT3VoK2RwQW50?=
 =?utf-8?B?eDhObEh0enY0MmFENWtwTjFpcllpNC9IdVR6UUI0Wmt4ZXl2MXpoNmpuRWFI?=
 =?utf-8?B?Qlkwb2NrTVUyU1poZkIyRGF6bXY2Zk1wZG5USXVXTmdVSTRVUWZmb1ZWSlI2?=
 =?utf-8?B?U2ZtZ2swNitpcDMvdUxWaTRvQUNvMzZjUk9oQTFyYWErZUdzbDhCRE5PQXJp?=
 =?utf-8?B?Wnl2RDk1Z2ZLNlpqMXFKRmYxWnpiTVI5M283YisxU3NXUGEwTmpCa3FSRHBE?=
 =?utf-8?B?NWVWSGN4ajc5c0NCVERyL1p1cE90Q2dZdTd3SFIwVWFYUkNLWFpHVWFqaitw?=
 =?utf-8?B?bUlDeFgrZXRTT1NJdVZhcjJaeUZhTlp2aHFNcFhIWXp1MkV3NjlqN2VxeCta?=
 =?utf-8?B?NUZ5aWwrRW5aaWdEckFJNGM1UExGVE92bXR1U2lSM0tIV1ZlaGw1T1JlV0dE?=
 =?utf-8?B?Mzc5M1V2bmVuMFc5aHJXQ3I4T3JyVHdaZkorbWgvb3JZaE1EZEpEY01uMFU4?=
 =?utf-8?B?eUE2OEs3Si9aNFIvL2IvK0Fhb2pXK2ZZNWpZTzM4Rys3STBRNU5rSWJIaTdh?=
 =?utf-8?B?K1ZmUVY5YUwvMDZlV0c0aHlSNmVaN21heHBwNGhaWC83NjNBQXg4a1RIdXJn?=
 =?utf-8?B?b251VURHTEpMY1dSdXgwRW8xTGR1c2ZIZjk4c1lzZ3hPVzZkSEZ0aW1rbTVL?=
 =?utf-8?B?a002Sy9IMkZ0YTFnQ1MraEZHaG4rWEZzV1BCOTJXb1FPT0dweWNqWXdTV3dn?=
 =?utf-8?B?QjZJVzhTYndid3h3VEJJYnZTUEltaVdSdVJiL1gvNjJsMFVqdG5Rd1Rua2Vm?=
 =?utf-8?B?eFB4aVdsRmx2WmdCTUpDTkdyL0RrQm1lWkt4UTlHUDh4WG00QjBDWjFRN1pm?=
 =?utf-8?B?U1RpdlRaVVNOc1plSGlvdW5kSWRBQnpzaGt4OE91TG1GY203RTFGZ3NNK1ky?=
 =?utf-8?B?dmZlT0NrSGF5eVIrWDdOUytoM2RjTGphRVc0WWNLSldzUEJEcDNXL1ZuTEpX?=
 =?utf-8?B?eElZT3JWMnNUa3VCSGIyS3Jzd0NXeFM0YW1kdG5WZ09pZUxvLzlrRThNOE9n?=
 =?utf-8?B?TFZvakhLdFdWcVNMb1dSei9nblNkY29iSnQ4ZDVXbHNyRzVnRHBVdkxlY2NL?=
 =?utf-8?B?ck53MktFWDFocEdCMkNyMU51MTRNL0N3N3FwWk1LbEVXOTZJM2N1M1cwR2ZD?=
 =?utf-8?B?S2hPSlJjZ2pmT2ZRRE9NQXV1c0NJaUcxck85VVdzTitXQVlYWlFJbTJaMHRU?=
 =?utf-8?B?dytraDg0VGdpcFhlR1J1L2xNalFCTXVvdjdRckNBTmdkMTVRV2lBYVRpYU5W?=
 =?utf-8?B?RDRWN1ZuM2I4VjJ6eWQzb3p0bDZVenh1aWVCRGtndmtLOVRvNFg3bHNuNHky?=
 =?utf-8?B?Umw0WUROeTBiTlVicW80a1pDU0RHVkZZcnlrUXJwQXJYMDdOVU8xMHd2TTl6?=
 =?utf-8?B?cmN1OE9wYUd3YjFnM2VGVmJHOHBHZ1BpcGpLSEtnMEdpOGl3Um1wVUs5VzNp?=
 =?utf-8?B?OGdPRCszN0NwWlFXSzljWUo1V0ROYzd4ZUUvOGc0UVQya29RWmozUnBRMWd5?=
 =?utf-8?B?VWpQQ3AvV2NSL3hTZkcwSEF5NTZ0dWI3YkpCSnJ3R2M5dnRYcHdGMk9YckV4?=
 =?utf-8?B?QkliMDMveUdyZVROaXU4dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B30FD4FF34728C4C83E610FC1A0D7253@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828b3acf-1cea-4308-1bc1-08d9875050f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 16:02:07.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4OXfKfizoyIAtlC4oIVDZutqa/NdDesNUg8kWBrnkwB/A7Q3+pQObeFknGd1eBrA/ZtKj+coX6qUFzxNQ2Vzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040110
X-Proofpoint-GUID: _gtMoPiUzr-MRecXojSZclk_jF14S0yv
X-Proofpoint-ORIG-GUID: _gtMoPiUzr-MRecXojSZclk_jF14S0yv
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNCBPY3QgMjAyMSwgYXQgMTU6MjIsIERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29v
Z2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDQgT2N0IDIwMjEgYXQgMTU6MTUsIEphc29u
IEd1bnRob3JwZSA8amdnQHppZXBlLmNhPiB3cm90ZToNCj4+IA0KPj4gT24gTW9uLCBPY3QgMDQs
IDIwMjEgYXQgMDI6NDI6MTFQTSArMDIwMCwgRG1pdHJ5IFZ5dWtvdiB3cm90ZToNCj4+PiBPbiBN
b24sIDQgT2N0IDIwMjEgYXQgMTI6NDUsIHN5emJvdA0KPj4+IDxzeXpib3QrM2E5OTJjOWU0ZmQ5
ZjBlNmZkMGVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBI
ZWxsbywNCj4+Pj4gDQo+Pj4+IHN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGlzc3VlIG9uOg0K
Pj4+PiANCj4+Pj4gSEVBRCBjb21taXQ6ICAgIGM3YjRkMGU1NmExZCBBZGQgbGludXgtbmV4dCBz
cGVjaWZpYyBmaWxlcyBmb3IgMjAyMTA5MzANCj4+Pj4gZ2l0IHRyZWU6ICAgICAgIGxpbnV4LW5l
eHQNCj4+Pj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gv
bG9nLnR4dD94PTEwNGJlNmNiMzAwMDAwDQo+Pj4+IGtlcm5lbCBjb25maWc6ICBodHRwczovL3N5
emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD1jOWExZjY2ODVhZWI0OGJkDQo+Pj4+IGRh
c2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9M2E5
OTJjOWU0ZmQ5ZjBlNmZkMGUNCj4+Pj4gY29tcGlsZXI6ICAgICAgIGdjYyAoRGViaWFuIDEwLjIu
MS02KSAxMC4yLjEgMjAyMTAxMTAsIEdOVSBsZCAoR05VIEJpbnV0aWxzIGZvciBEZWJpYW4pIDIu
MzUuMg0KPj4+PiANCj4+Pj4gVW5mb3J0dW5hdGVseSwgSSBkb24ndCBoYXZlIGFueSByZXByb2R1
Y2VyIGZvciB0aGlzIGlzc3VlIHlldC4NCj4+Pj4gDQo+Pj4+IElNUE9SVEFOVDogaWYgeW91IGZp
eCB0aGUgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoN
Cj4+Pj4gUmVwb3J0ZWQtYnk6IHN5emJvdCszYTk5MmM5ZTRmZDlmMGU2ZmQwZUBzeXprYWxsZXIu
YXBwc3BvdG1haWwuY29tDQo+Pj4gDQo+Pj4gK1JFU1RSQUNLIG1haW50YWluZXJzDQo+Pj4gDQo+
Pj4gKGl0IHdvdWxkIGFsc28gYmUgZ29vZCBpZiBSRVNUUkFDSyB3b3VsZCBwcmludCBhIG1vcmUg
c3RhbmRhcmQgb29wcw0KPj4+IHdpdGggc3RhY2svZmlsZW5hbWVzLCBzbyB0aGF0IHRlc3Rpbmcg
c3lzdGVtcyBjYW4gYXR0cmlidXRlIGlzc3VlcyB0bw0KPj4+IGZpbGVzL21haW50YWluZXJzKS4N
Cj4+IA0KPj4gcmVzdHJhY2sgY2VydGFpbmx5IHNob3VsZCB0cmlnZ2VyIGEgV0FSTl9PTiB0byBz
dG9wIHRoZSBrZXJuZWwuLiBCdXQgSQ0KPj4gZG9uJ3Qga25vdyB3aGF0IHN0YWNrIHRyYWNrIHdv
dWxkIGJlIHVzZWZ1bCBoZXJlLiBUaGUgY3VscHJpdCBpcw0KPj4gYWx3YXlzIHRoZSB1bmRlcmx5
aW5nIGRyaXZlciwgbm90IHRoZSBjb3JlIGNvZGUuLg0KPiANCj4gVGhlcmUgc2VlbXMgdG8gYmUg
YSBzaWduaWZpY2FudCBvdmVybGFwIGJldHdlZW4NCj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUv
cmVzdHJhY2suYyBhbmQgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPiBtYWludGFp
bmVycywgc28gcGVyaGFwcyByZXN0cmFjay5jIGlzIGdvb2QgZW5vdWdoIGFwcHJveGltYXRpb24g
dG8NCj4gZXh0cmFjdCByZWxldmFudCBwZW9wbGUgKGRlZmluaXRlbHkgYmV0dGVyIHRoZW4gbm8g
Q0MgYXQgYWxsIDopKQ0KDQpMb29rcyB0byBtZSBhcyB0aGlzIGlzIHJ4ZToNCg0KWyAxODkyLjc3
ODYzMl1bIFQ4OTU4XSBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBfX3J4ZV9kcm9wX2lu
ZGV4X2xvY2tlZCsweGI1LzB4MTAwDQpbc25pcF0NClsgMTg5Mi44MjIzNzVdWyBUODk1OF0gQ2Fs
bCBUcmFjZToNClsgMTg5Mi44MjU2NTVdWyBUODk1OF0gIDxUQVNLPg0KWyAxODkyLjgyODU5NF1b
IFQ4OTU4XSAgZHVtcF9zdGFja19sdmwrMHhjZC8weDEzNA0KWyAxODkyLjgzMzI3M11bIFQ4OTU4
XSAgcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMC5jb2xkKzB4NmMvMHgzMGMN
ClsgMTg5Mi44NDAzMTZdWyBUODk1OF0gID8gX19yeGVfZHJvcF9pbmRleF9sb2NrZWQrMHhiNS8w
eDEwMA0KWyAxODkyLjg0NTg2NF1bIFQ4OTU4XSAgPyBfX3J4ZV9kcm9wX2luZGV4X2xvY2tlZCsw
eGI1LzB4MTAwDQpbIDE4OTIuODUxNDI0XVsgVDg5NThdICBrYXNhbl9yZXBvcnQuY29sZCsweDgz
LzB4ZGYNClsgMTg5Mi44NTYyMDBdWyBUODk1OF0gID8gX19yeGVfZHJvcF9pbmRleF9sb2NrZWQr
MHhiNS8weDEwMA0KWyAxODkyLjg2MTc2MV1bIFQ4OTU4XSAga2FzYW5fY2hlY2tfcmFuZ2UrMHgx
M2QvMHgxODANClsgMTg5Mi44NjY3ODBdWyBUODk1OF0gIF9fcnhlX2Ryb3BfaW5kZXhfbG9ja2Vk
KzB4YjUvMHgxMDANClsgMTg5Mi44NzIxNjRdWyBUODk1OF0gIF9fcnhlX2Ryb3BfaW5kZXgrMHgz
Zi8weDYwDQpbIDE4OTIuODc2ODUwXVsgVDg5NThdICByeGVfZGVyZWdfbXIrMHgxNGIvMHgyNDAN
ClsgMTg5Mi44ODEzODFdWyBUODk1OF0gIGliX2RlYWxsb2NfcGRfdXNlcisweDk2LzB4MjMwDQpb
IDE4OTIuODg2NTY2XVsgVDg5NThdICByZHNfaWJfZGV2X2ZyZWUrMHhkNC8weDNhMA0KDQpTbywg
UkRTIGRlLWFsbG9jcyBpdHMgUEQsIGliIGNvcmUgbXVzdCBmaXJzdCBkZS1yZWdpc3RlciB0aGUg
UEQncyBsb2NhbCBNUiwgY2FsbHMgcnhlX2RlcmVnX21yKCksIC4uLg0KDQoNClRoeHMsIEjDpWtv
bg0KDQoNCj4gDQo+PiBBbnlob3csIHRoaXMgcmVwb3J0IGlzIGVpdGhlciByeGUgb3IgcmRzIGJ5
IHRoZSBsb29rIG9mIGl0Lg0KPj4gDQo+PiBKYXNvbg0KDQo=
