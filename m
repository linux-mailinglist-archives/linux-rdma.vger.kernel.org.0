Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CE408646
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhIMIS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 04:18:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237754AbhIMISY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 04:18:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D6huvD015088;
        Mon, 13 Sep 2021 08:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l6mjGcU5SoIdsUryLoxEQ3R7qhIKLJbrdsVl1cJEs8Y=;
 b=0K2yuogY/2FsqCbU+9SFFe8VjhekFfrBDejMEbxWu07xCd8VQ2en16WXeSH++CWrXsQh
 pYOdq76LwfdZ6Z3SAGi1MWX7CmGtN/kjWlw/0XdZcnvzOG7pWRbaHsqxgzcPkLw9j6ix
 pGrW5uMnTGwfzOr1EItvHup83CiIC9eMBjY8RP5zZF2P0/tO3iMkI/J4a6L4z66V31ZP
 oZaRGVawDQ0/VccSgvBcqvMKedMdJAEp/Atl6r1VoDm9WsLWwwBAzo1ADmI/nObq+foG
 jROnoHbRHpz11irSuTtoP6mA3FFEQN3TMo8aym3ClT5wo1ddMdNrA6nLIe5JvmxEfiQt eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l6mjGcU5SoIdsUryLoxEQ3R7qhIKLJbrdsVl1cJEs8Y=;
 b=NTbinll5K0UdLGCBhN5nh70ilG+F5yClKmz5TJzBXkuU9g63ajouf2U332pm7cN0TnKf
 9Ntv3DnaCDv9lJ/m4Lf/aaDvMCkcy6TkkBay6ib0tEepJcKkm/ITwdL+pcTHGVf5i47t
 SIrX3b89Mc6Cm7cg2We0nVKhOTLk3adsiDafBTKIq+egspJLR4ldEpSA+PKYPlakXl21
 7Ea/3exJtsXD/51sqhMITfsHehsmLBYnHoO1g2Ru/ljzAsbjXBsnH/RvCz2zSlKgErLr
 B7qzweyLbTGNyXgMMAn9NP5xZZbRzwva1zG3WQQ9NP0eNq7Tg//xLFCcXGUO+R4mYEod Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1k1s9nr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 08:17:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18D8GJCN159846;
        Mon, 13 Sep 2021 08:17:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3b0m94ct9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 08:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoiEEOuLSXXX9Smw3LynvCERPAoyBBbrDeQJqu/xEffqsd6u5U2YRs6Y0xx3aOsJDJaNZx7IuIDmgBwn7DgW/V3Q3ilWYPbG4fF9Kcu4l64lqdPslfCmWI/8CQKvx1XWn4Jp26kagYuSqsg8iSrgJTKjwpa6KJibLeYSTGWUyytydWNfTX+32EaoyfmYtVmnmWqcslzNdryQPLAUgulyZUsRn1ObV7m1BPopSvEkmQMfIfKO0u8OFidqKpaw4C+SiuNlaGc7Kp7e70kgBxUVi9c/eO90mLw52EIEJf5IqlLCrtLZC49lBKq49dj0d9uKbXguJyecoxbxpu3RAfxo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l6mjGcU5SoIdsUryLoxEQ3R7qhIKLJbrdsVl1cJEs8Y=;
 b=jPXoi2KPgJPNvyRbY1tTdlenM1Hfdtudhg7kgzJttqbrtq2Zrf2+TO9FysipBZaSrWOcddIEdeWa9OtMKmFxmMvUVWFHWcPglquc3mN33TwsjOCG2S6ya2vXqmhvLMlDy3TApR2ZQpG9R1DNXbJUeCd20LW33yWeEGL0MVf8RJzTR5Pg4IGH6FU6Gh9dkg2vTlamV5C1wMzNUZVi/w+6W5Wr5apF5ue5HP2CxJP4BRAJZ3FdwPPm8VtfGFjvd3D4DV03qsfKRbm//8ZwvM6RWBSWSRWyBGQfTWSiwnZrvcOGdm6u/il/AupbvnPY3rA/Yl6AUw8FUG6s+rSfW3q0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6mjGcU5SoIdsUryLoxEQ3R7qhIKLJbrdsVl1cJEs8Y=;
 b=uXluN62M1R9Eb7RKy68uExu6eDDmqE9Jtl95mL2sd860YCXDa15fFmPsxRnOksKSUw8LQr0CpVCDRxEViyBRH86ccYKtuCZZ8Tuem9Hzpv3F2ICGwlVr4kgI6Q70ChVxUzOkTzE9uL5j9zghKHyFU3xEuea7af8RNv10zcAcyYA=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM8PR10MB5415.namprd10.prod.outlook.com (2603:10b6:8:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:17:00 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 08:17:00 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Thread-Topic: [PATCH rdma-rc] RDMA/usnic: Lock VF with mutex instead of
 spinlock
Thread-Index: AQHXqHYVzpw5iH5J6U2iOHiH9rCYa6uhnoWA
Date:   Mon, 13 Sep 2021 08:17:00 +0000
Message-ID: <ADF1D118-A29D-4B32-9D25-F3B1768C8924@oracle.com>
References: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
In-Reply-To: <2a0e295786c127e518ebee8bb7cafcb819a625f6.1631520231.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc1f6c98-7583-41c3-6207-08d9768edc6d
x-ms-traffictypediagnostic: DM8PR10MB5415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR10MB5415342156A8CF661A6ED4B5FDD99@DM8PR10MB5415.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUwF7ZMYZLRPoH964LdbpRQo0L6PzGHddcE5B9GCq/lk4ADA66A2paSjSs0fF8LlD6iE4/wBu85RTL6QxzZcZo59O23HuxV+pge4Wh4MnBUSE0wMLd7W1gEDNeuwItQ9PweKJDO5f0zRK7oGeg21TRrDUBgarE5FWVXEyXYzrvih7RWWT9yAVWYNJ1AG5SdhJW+xJ6+2rlynA6ybB+5zyw9xIgFzMSijndppHOvXxmLLyI/ZoxaQXe3jtp4x/XM0csdl45Cvwt7xhiVynzkAJG1ITF5qcs5bJkK1kir9ZhOl7pWXAX6T2Ya/AeerK3RQ0+bbRWXdBLsfOh1kqeuSu8GycBa4e63MuW3P4aSeq9Kf3t4LGdmSYsuyEYi0FtCczXzxNrXfT9/QHBXse5deb6baOq9bKnVeA7yvUZbAofvnEWmlzts07J4Nb/yCjwEtX+laF7MjoMWBkGt3cLVYN7o7bTMzMDO8wI025LMuZBvKO34yD0HKm6qS7aZCEGH/ywjAqbOouoWeTeza5k0IDzzon7SwLVH1wKhIf7wKlqsV994SHgozChmpLexV4Ml1XS//9eEvtfVVtl6/7HZ1ZfaMMUuDiSze7ukyhambSPjgO9w/E6iCjeRst6k0qPuhycfGnif49PwXTGcUj1487HOxcWtRPS6sdlm5n44DOVNmi3xPoCgFbb79kDSJIQunY5mVI6X0Q/sKyiGFinbpUQmV5oPvyzjhaa+M8mf0BHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(478600001)(44832011)(6486002)(2616005)(53546011)(91956017)(66446008)(66574015)(86362001)(5660300002)(54906003)(4326008)(8676002)(186003)(8936002)(36756003)(38100700002)(64756008)(66556008)(66476007)(83380400001)(316002)(71200400001)(38070700005)(76116006)(122000001)(6506007)(6512007)(66946007)(33656002)(2906002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djdhUE9kTnAwejZUUXNrZUJpd0R1QXA4bDFvS0JqMmxTVG9ldVU4MjdVN3Vl?=
 =?utf-8?B?MXZzKzNXaTV2aHR6N2J5UEFKMFBBNit6MHJYTmJkN1lxbUlhNTZuZTZSODZs?=
 =?utf-8?B?cklQRVlSem9vbjlEbFVRZVQ1MUlObmNrcnVzTnRSN2ZzcHJkVm5ZeExZU3VR?=
 =?utf-8?B?MGJFMGFCYTltQ0c3T0dFTkxXSVdUMEtHZHJ0RzBudjI3eU1wOXp3SE1RdlYv?=
 =?utf-8?B?NktOcG1wQWx5UUllZUpTbXZTZzFqMkRST0RidVVTelM2eDJSM2xtY1oxTjJ2?=
 =?utf-8?B?QlFZeXMrb1NIV2h3R0t6Nm5lcGQwMXhwSkdGenZvcGVYb2FrbkFlSmVHVEhx?=
 =?utf-8?B?eEFjejNUbFd4QzgwUjNSZ1NoV1hFY0x6ZGRVSjVDYW1IVnJrVTRxd3NCdFo4?=
 =?utf-8?B?cmxHV0kvYjFsNENReU9Cdy90MVloaVlJMlY4bVlFR2hSeFlQS3p4UEthK3dw?=
 =?utf-8?B?bnVaK0VMMFIrNElVSUVJTnpCK0doNU8yVHhxa2NzRGNFZVZ1V1E1Sm01WGho?=
 =?utf-8?B?U1hVNFdsREM5ZGtrYzB2b2ptYW9TaVR5Y1dXa3dvbGJJNEwzRFFEMEtxbW10?=
 =?utf-8?B?NmZkUmNPZ01yOXpPbEdOM0QzaVRYcHFYM3lsUWRrNG1raGUxT2JVUFdLQ2Rt?=
 =?utf-8?B?ckNKRzVwcGtoQjJYazJhZExJbk1mb2FsaFNKQThUZitrblVrRzgvWjFRTFFq?=
 =?utf-8?B?MEVFOFlhNGJBSERBUGpBNnFFcnhRK0RaN1ZqVlZHbDYvbzdpeHh3MnZJY2NM?=
 =?utf-8?B?eVZwcHV1T2F1TE85T3hsd25RVGhJZU02d21tUEtZcFJneFRzaGdZNGhCVEVr?=
 =?utf-8?B?b09td3JmbGpLV0NxbjgydTYrTVQra3E0NENibVM0V2F4NWJpV0VRejhFdUxa?=
 =?utf-8?B?WUFWd29ySzc5TUZZeFJiVTloZWJ1cnY1UFE3YWU1MzhPUE1IdkloTWR5RlJG?=
 =?utf-8?B?ZlB2aDA2WnRzeTNIKzcvYjY4bVFNSjNRNUJyWHB2M3NwUDZpRCtrclk4dmx4?=
 =?utf-8?B?TWRJM3NERFZ3cVNGUFBzY0RhVW1tWTZCYTFzZS9uRGJ5ZTlkUnl0S056WlpO?=
 =?utf-8?B?alJ5UzNuRDhGelJtSndzeVYweG9aWEc5cVprS3V3ZjkvM3VnWkgrLzhhNGx4?=
 =?utf-8?B?OWdyMFhpU3VVWndrUlVkMzdvMVFTR3ltTlp2eXNjVEZNZEpocEUwdTEyQnMx?=
 =?utf-8?B?TlRNTXl0TmdRSGw4bTVuWVU0WVBtN3FqbU9aRG9qTDZ3cUpQWExRQWMzWEha?=
 =?utf-8?B?dGJDVHBYc3NRNU9yYi9OMDVkakF3ckc0ODlEbXlHL0pOamRFZEVXK0Y2ejQw?=
 =?utf-8?B?Z0xXMHV5V20yQXNaYlpuelhjMFJZdHd5MHhNWHdSMUQzd3RoWm5Fd012ODh4?=
 =?utf-8?B?Nm5venRUV2hZK3JRQ3FEQUFXdkI5UUhaV0h3eEV5eUtheFZPTEc4RThSVlpk?=
 =?utf-8?B?cUE2RThkMTBMdzVWbDNRbm9ENHRvS3orbk03OFVTTFo2UXZNY0U0SjI5RVFo?=
 =?utf-8?B?dEFOOHV6YktTK2duaU5oakErYWdXaW1nNW1oc3A0TVJxWTI1dUVSVFN4SG1x?=
 =?utf-8?B?SHJvNTh3UFVMejduMi9sVG9WeXRCVU91SDF3blczMGJ2Q3d6ZVRseVVrbHpE?=
 =?utf-8?B?VlQ4ZkFiMFFuRWVMNnJBUngxYUwvZFhZSVlmdGJkRWhORVFIZDkrUzFKTkxK?=
 =?utf-8?B?Z08ybSs2QmJJQVI4R0dpUUkvWVBnUVV5YmFkZnlCeHdUTFZhSWhkUG9XZjE1?=
 =?utf-8?B?YUZlaWw4STVQMUZCRXhiZkRUNDlkYU55bVc2dVkyZEpLZllFc0VjRFZYZ1Zs?=
 =?utf-8?B?T1ZrYjI5SXE1K0FSb3NnV2Y5aW5MZ2tmM2dicWJ0TWZ0aGFnOC8vQ1phbm1p?=
 =?utf-8?Q?a4QmNSRz5xKI2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D3697F728E1F49AF19E81083308CD9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1f6c98-7583-41c3-6207-08d9768edc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 08:17:00.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkdWuJCZaolLCpbxXh9qXIiXMH0LxughHpIfGEyB+fR3lWCQR3RUyXln3cdUgpVMn5OnLpeRWzh+lPoe/xfn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5415
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130055
X-Proofpoint-ORIG-GUID: Dko9aH5ggTrcPSwki80cdyWnwzyG_FeC
X-Proofpoint-GUID: Dko9aH5ggTrcPSwki80cdyWnwzyG_FeC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgU2VwIDIwMjEsIGF0IDEwOjA0LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0Budmlk
aWEuY29tPg0KPiANCj4gVXNuaWMgVkYgZG9lc24ndCBuZWVkIGxvY2sgaW4gYXRvbWljIGNvbnRl
eHQgdG8gY3JlYXRlIFFQcywgc28gaXQgaXMgc2FmZQ0KPiB0byB1c2UgbXV0ZXggaW5zdGVhZCBv
ZiBzcGlubG9jay4gU3VjaCBjaGFuZ2UgZml4ZXMgdGhlIGZvbGxvd2luZyBzbWF0Y2gNCj4gZXJy
b3IuDQoNCnMvR0ZQX0FUT01JQy9HRlBfS0VSTkVMLyBpbiBmaW5kX2ZyZWVfdmZfYW5kX2NyZWF0
ZV9xcF9ncnAoKSBhcyB3ZWxsPw0KDQoNClRoeHMsIEjDpWtvbg0KPiANCj4gU21hdGNoIHN0YXRp
YyBjaGVja2VyIHdhcm5pbmc6DQo+IA0KPiAgIGxpYi9rb2JqZWN0LmM6Mjg5IGtvYmplY3Rfc2V0
X25hbWVfdmFyZ3MoKQ0KPiAgICB3YXJuOiBzbGVlcGluZyBpbiBhdG9taWMgY29udGV4dA0KPiAN
Cj4gRml4ZXM6IDUxNGFlZTY2MGRmNCAoIlJETUE6IEdsb2JhbGx5IGFsbG9jYXRlIGFuZCByZWxl
YXNlIFFQIG1lbW9yeSIpDQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVu
dGVyQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJv
QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2luZmluaWJhbmQvaHcvdXNuaWMvdXNuaWNf
aWIuaCAgICAgICB8ICAyICstDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY19p
Yl9tYWluLmMgIHwgIDIgKy0NCj4gZHJpdmVycy9pbmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2li
X3ZlcmJzLmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+IDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2liLmggYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvdXNu
aWMvdXNuaWNfaWIuaA0KPiBpbmRleCA4NGRkNjgyZDIzMzQuLmIzNTAwODFhZWI1YSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2liLmgNCj4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2liLmgNCj4gQEAgLTkwLDcgKzkwLDcg
QEAgc3RydWN0IHVzbmljX2liX2RldiB7DQo+IA0KPiBzdHJ1Y3QgdXNuaWNfaWJfdmYgew0KPiAJ
c3RydWN0IHVzbmljX2liX2RldgkJKnBmOw0KPiAtCXNwaW5sb2NrX3QJCQlsb2NrOw0KPiArCXN0
cnVjdCBtdXRleAkJCWxvY2s7DQo+IAlzdHJ1Y3QgdXNuaWNfdm5pYwkJKnZuaWM7DQo+IAl1bnNp
Z25lZCBpbnQJCQlxcF9ncnBfcmVmX2NudDsNCj4gCXN0cnVjdCB1c25pY19pYl9wZAkJKnBkOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2liX21haW4u
YyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY19pYl9tYWluLmMNCj4gaW5kZXgg
MjI4ZTlhMzZkYWQwLi5kMzQ2ZGQ0OGU3MzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9ody91c25pYy91c25pY19pYl9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L3VzbmljL3VzbmljX2liX21haW4uYw0KPiBAQCAtNTcyLDcgKzU3Miw3IEBAIHN0YXRpYyBp
bnQgdXNuaWNfaWJfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiAJfQ0KPiANCj4g
CXZmLT5wZiA9IHBmOw0KPiAtCXNwaW5fbG9ja19pbml0KCZ2Zi0+bG9jayk7DQo+ICsJbXV0ZXhf
aW5pdCgmdmYtPmxvY2spOw0KPiAJbXV0ZXhfbG9jaygmcGYtPnVzZGV2X2xvY2spOw0KPiAJbGlz
dF9hZGRfdGFpbCgmdmYtPmxpbmssICZwZi0+dmZfZGV2X2xpc3QpOw0KPiAJLyoNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY19pYl92ZXJicy5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL2h3L3VzbmljL3VzbmljX2liX3ZlcmJzLmMNCj4gaW5kZXggMDZhNGU5
ZDQ1NDVkLi43NTZhODNiY2ZmNTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy91c25pYy91c25pY19pYl92ZXJicy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody91
c25pYy91c25pY19pYl92ZXJicy5jDQo+IEBAIC0xOTYsNyArMTk2LDcgQEAgZmluZF9mcmVlX3Zm
X2FuZF9jcmVhdGVfcXBfZ3JwKHN0cnVjdCBpYl9xcCAqcXAsDQo+IAkJZm9yIChpID0gMDsgZGV2
X2xpc3RbaV07IGkrKykgew0KPiAJCQlkZXYgPSBkZXZfbGlzdFtpXTsNCj4gCQkJdmYgPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsNCj4gLQkJCXNwaW5fbG9jaygmdmYtPmxvY2spOw0KPiArCQkJbXV0
ZXhfbG9jaygmdmYtPmxvY2spOw0KPiAJCQl2bmljID0gdmYtPnZuaWM7DQo+IAkJCWlmICghdXNu
aWNfdm5pY19jaGVja19yb29tKHZuaWMsIHJlc19zcGVjKSkgew0KPiAJCQkJdXNuaWNfZGJnKCJG
b3VuZCB1c2VkIHZuaWMgJXMgZnJvbSAlc1xuIiwNCj4gQEAgLTIwOCwxMCArMjA4LDEwIEBAIGZp
bmRfZnJlZV92Zl9hbmRfY3JlYXRlX3FwX2dycChzdHJ1Y3QgaWJfcXAgKnFwLA0KPiAJCQkJCQkJ
ICAgICB2ZiwgcGQsIHJlc19zcGVjLA0KPiAJCQkJCQkJICAgICB0cmFuc19zcGVjKTsNCj4gDQo+
IC0JCQkJc3Bpbl91bmxvY2soJnZmLT5sb2NrKTsNCj4gKwkJCQltdXRleF91bmxvY2soJnZmLT5s
b2NrKTsNCj4gCQkJCWdvdG8gcXBfZ3JwX2NoZWNrOw0KPiAJCQl9DQo+IC0JCQlzcGluX3VubG9j
aygmdmYtPmxvY2spOw0KPiArCQkJbXV0ZXhfdW5sb2NrKCZ2Zi0+bG9jayk7DQo+IA0KPiAJCX0N
Cj4gCQl1c25pY191aW9tX2ZyZWVfZGV2X2xpc3QoZGV2X2xpc3QpOw0KPiBAQCAtMjIwLDcgKzIy
MCw3IEBAIGZpbmRfZnJlZV92Zl9hbmRfY3JlYXRlX3FwX2dycChzdHJ1Y3QgaWJfcXAgKnFwLA0K
PiANCj4gCS8qIFRyeSB0byBmaW5kIHJlc291cmNlcyBvbiBhbiB1bnVzZWQgdmYgKi8NCj4gCWxp
c3RfZm9yX2VhY2hfZW50cnkodmYsICZ1c19pYmRldi0+dmZfZGV2X2xpc3QsIGxpbmspIHsNCj4g
LQkJc3Bpbl9sb2NrKCZ2Zi0+bG9jayk7DQo+ICsJCW11dGV4X2xvY2soJnZmLT5sb2NrKTsNCj4g
CQl2bmljID0gdmYtPnZuaWM7DQo+IAkJaWYgKHZmLT5xcF9ncnBfcmVmX2NudCA9PSAwICYmDQo+
IAkJICAgIHVzbmljX3ZuaWNfY2hlY2tfcm9vbSh2bmljLCByZXNfc3BlYykgPT0gMCkgew0KPiBA
QCAtMjI4LDEwICsyMjgsMTAgQEAgZmluZF9mcmVlX3ZmX2FuZF9jcmVhdGVfcXBfZ3JwKHN0cnVj
dCBpYl9xcCAqcXAsDQo+IAkJCQkJCSAgICAgdmYsIHBkLCByZXNfc3BlYywNCj4gCQkJCQkJICAg
ICB0cmFuc19zcGVjKTsNCj4gDQo+IC0JCQlzcGluX3VubG9jaygmdmYtPmxvY2spOw0KPiArCQkJ
bXV0ZXhfdW5sb2NrKCZ2Zi0+bG9jayk7DQo+IAkJCWdvdG8gcXBfZ3JwX2NoZWNrOw0KPiAJCX0N
Cj4gLQkJc3Bpbl91bmxvY2soJnZmLT5sb2NrKTsNCj4gKwkJbXV0ZXhfdW5sb2NrKCZ2Zi0+bG9j
ayk7DQo+IAl9DQo+IA0KPiAJdXNuaWNfaW5mbygiTm8gZnJlZSBxcCBncnAgZm91bmQgb24gJXNc
biIsDQo+IEBAIC0yNTMsOSArMjUzLDkgQEAgc3RhdGljIHZvaWQgcXBfZ3JwX2Rlc3Ryb3koc3Ry
dWN0IHVzbmljX2liX3FwX2dycCAqcXBfZ3JwKQ0KPiANCj4gCVdBUk5fT04ocXBfZ3JwLT5zdGF0
ZSAhPSBJQl9RUFNfUkVTRVQpOw0KPiANCj4gLQlzcGluX2xvY2soJnZmLT5sb2NrKTsNCj4gKwlt
dXRleF9sb2NrKCZ2Zi0+bG9jayk7DQo+IAl1c25pY19pYl9xcF9ncnBfZGVzdHJveShxcF9ncnAp
Ow0KPiAtCXNwaW5fdW5sb2NrKCZ2Zi0+bG9jayk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZ2Zi0+bG9j
ayk7DQo+IH0NCj4gDQo+IHN0YXRpYyBpbnQgY3JlYXRlX3FwX3ZhbGlkYXRlX3VzZXJfZGF0YShz
dHJ1Y3QgdXNuaWNfaWJfY3JlYXRlX3FwX2NtZCBjbWQpDQo+IC0tIA0KPiAyLjMxLjENCj4gDQoN
Cg==
