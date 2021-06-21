Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8023AE8DA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFUMRH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 08:17:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48410 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhFUMRH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 08:17:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LCBDkm013489;
        Mon, 21 Jun 2021 12:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RaWPExH5jeNjZd0SI76ZEsmMdpamH5G6E/ehrtQs040=;
 b=N2zaGy0xhwUyXlcLTBEU5dTRZbtOXtL+sya5BDfKkt+M/SrRkDOa1MC7bEZ43CVXs9jP
 l+hjWutVUxdGf7Lb4eLHjM8amUhF65KqHZQQNd8sGd0WbFlLRkq3lSMaoG4obeyyTI2y
 JIMyIjEUXBVgn8RBoag5UfMqALsNXa0JYLvAtDxWMunwBDzCaZ59azpTZyRlKp3T+wiI
 K1X3dswaBoBlWN1XbPGPDl/buhoqtfWYKVj3nXo8EPWLabm77njJ9OcPuhyRJXbsStxm
 LQUthJYIicsph2cIc5PZXDaDwf4A3bvzFTlRnvWjYwKB75dN7GUb/7g1c+Qwp48bbBY7 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39as86r50q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:14:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LCB9ee177323;
        Mon, 21 Jun 2021 12:14:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3995pugr7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f850/GIZfLIWLJ+Z6ul1cljQbRIpPvyADMtvrwWXf+TxbMy+KzdCid5JYOZcVZURicTkMHUEgjAtUhviFRXZ2SWivtT+x9D6ccexCjdhCz5fTERc6rvJfD0h/2qtOtR+lgrtO/VwIyxt4DIi43yJ3umhviwuhs6/qUJYGbre80r6ewhaQo8lgwQXq59FbFMZFsWnycvBm6DL8bRNzmqcIsNLonqp1cbLxnqqoQsksDjOdyaFx3I463oanT5fM/573BUpb7tniL7XwNHNTvlVJJAKYaUfIvtH5J4Jk9Fp/Gmgzc5DXYeZqzW5d0pdr4t63cyYhtc8piKWxsstXEz0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaWPExH5jeNjZd0SI76ZEsmMdpamH5G6E/ehrtQs040=;
 b=KR1fBJmoIOOpBqytxtsvL/t8kgIwvUc9cYUYO9BBtWat4bh0ca2SwjxxWKwboZU90xWU6ARLFe9qPoewvGpkBF1RkARpigupfQFBIuVnVDyEU7y0IqprelyxzpnxoYFWmd/Xa8QGqAvhO0ELjIQajbu4JzaNFRLw4xjBnIbjDIHFW9bJNfYSyOAq/MMsdPHIiSArdy/xmTm5TGtaNdIqDpHWv3tZmlz9fOwZOMCecyWM+k6YKxgXjBWmbUGwjcdCgyAqbsBC0s34FL6hEZkSrU/iJaPmWz145YLZrIevGoCmNRFk9RjG2+TQU1I5QBbgrPOR2IvMVIDL7QRUyZRDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaWPExH5jeNjZd0SI76ZEsmMdpamH5G6E/ehrtQs040=;
 b=G2qTbOF+r2+9KWEaFLCqbSJcYpTPUhTxGbWnWX4wiGjihVPbH+2Pnab1Vovhok4tSeRvRNQnMMqA5U81JazyFJ4a9kISSJCHX1i2dH1VBZXyf89Nbgi64+eoyYN7evkwwULDgkZJWJb54bUBvWf4eevyn+82xp6y+1u21vbP9Us=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2406.namprd10.prod.outlook.com (2603:10b6:910:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 12:14:46 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 12:14:46 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Topic: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Index: AQHXY4/9tgmALgj7ckyob56jJS8GkKseQ1EAgAAjl4A=
Date:   Mon, 21 Jun 2021 12:14:45 +0000
Message-ID: <6295681C-15C1-4E43-8E5A-A38509234A3D@oracle.com>
References: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
 <YNBk2HcMKlSTM2tn@unreal>
In-Reply-To: <YNBk2HcMKlSTM2tn@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dfb32dc-4692-4be7-1447-08d934ae28a3
x-ms-traffictypediagnostic: CY4PR1001MB2406:
x-microsoft-antispam-prvs: <CY4PR1001MB24066537E54F87785927858AFD0A9@CY4PR1001MB2406.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fzu4C8yKr9x4VXzaTxcSJpyVz8Knj30UolzwU8lRyX7mGolDKIRPqrjX4GZZviDKMI2mcVbN2sidneOwlel01yo8eagQLKWJMGrI7HYJqs4lcMJ5j1jhrnfqUpULWBInLluURoFR9CKXBcmSDF3rC1xw2rUQLZ8+DOmho2T0JmmAxuohpTjF7geICOGypjUP7SAYemCZpOdDJPLSAwF+YiSaW4Doqzc76qW8CjJf1F1J9OLUUF/A/6oLQkrSxGfEMVYNvVkdXYL6AndYpKQA14s4IiN7oAfviuPO52frGtCy+8TJ6/zZabQnGddG+DJzqlC/2O4sVqOlty0BcFH5Y9K45I4j5XF7xkmqDTBXeKJFTuQT8ra5ZOmemcPXFoJ2tfnCUg5yob9W1xrQHc1tY9DeUl5qh2v+2asALoqYQEXZu1vYqSTKn5GKNrdmlrBtZRQwMAFNdtMPoNuccZSQy1Hb2FPlgKKy1N19OrMLPnDlSC88qpUMN1aptjypjJYjVsIwabd0bP885MFkwYZTJfjHAmQQ53BUoUpx+4WSWE5mMVpbJh7elF2rPKKd5mcE5nh7KGsqyJbFJfSUTmJ7flzEMXNlnKDoF7bQWjTxHIiwB97zndADnbIj1S2sRGEMM6z0D189YeYJWD6XZThc2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(33656002)(316002)(6486002)(36756003)(86362001)(66556008)(66446008)(44832011)(64756008)(6506007)(5660300002)(83380400001)(66476007)(54906003)(2906002)(186003)(8676002)(66946007)(26005)(53546011)(91956017)(76116006)(2616005)(71200400001)(8936002)(4326008)(38100700002)(6916009)(122000001)(478600001)(6512007)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmNSd3BCWUl2cVQvN2JGSDlSSW1iNk9WalZGUnV0Rmx4My95clNRMmJQenVJ?=
 =?utf-8?B?S3dKcXQvVzYwc0VjU3crZWtocnZQOEUvMktRWUhHYlp6QkJPM3NOSWxCTlFJ?=
 =?utf-8?B?L0gzekw0WU50RE9DSkxmM3hGcFhLc25FWWRkVEpkMkdhVWJTbGozMmtkdEk4?=
 =?utf-8?B?ZFhZSytCQ0Z0QkxDdUxsQWx1d2FvUDU5M0lVNUFZSkE4cHhNNE9qVVBqblpI?=
 =?utf-8?B?bkJFc25EQW5XNng2YzYraDQvMW9tL2FZRlpvdHpRQzhZd3ZHNTNPaW5CTE1I?=
 =?utf-8?B?VzVzT3NDbTBGODVneG12RjNFZ3RwSDVXckZZY01jY3FHMk9OT3dtVWtPK3dV?=
 =?utf-8?B?NlA0dFBiYjJpUHg1amdtcDlSMVBpa1c1Z1VaWThRcHlRZjhlUklBU2ZkQTZp?=
 =?utf-8?B?Qks3bVJnbDZZY1BHVHh2QThmVTVNTURneiszUlBVeDc5c3FlanVQRlM2b2k0?=
 =?utf-8?B?Mlo1NWEzUWZjdm5zMHU2NGVBQ1Q3UXpxZWF4VkZRSFlUYXdoT0F3eW1qZ3p0?=
 =?utf-8?B?dTJEc0hJUG93SFA2NlpUZEduVDJkY281eUhTbUtBUEF3WWJCTTdOVTdMeVZN?=
 =?utf-8?B?MXVMVTloUURzM3VnN2VEbkxNMVdSU2d1TnVnOEVyWWJKZ1hTQzRUTTBPajda?=
 =?utf-8?B?ZDNoa1pJckhUN1llR3JwRWs5TnQ3NXRvKzhCaE9TWkFLbjVZUnRXdi9JWUR3?=
 =?utf-8?B?c3J3bklZUjhCZFNLcW1OZDllSmFOOEtpM0J3dGJVZ2RuTUpnMnNTUXdqNGI5?=
 =?utf-8?B?eXBsYVFQcEUyRHlFdTE4TU94NU8wSnM2UVZsZ3NFM2FuMm53THdHa3h0WXlQ?=
 =?utf-8?B?cTdvYkp1dWdQNXhoc2tST1ZrRSs3QndlMTFVaEEzTXdMVm5NdlgvdFlVYk9y?=
 =?utf-8?B?YzcwY1dzTVVkRE9OVkFRQWVZa1dhTTgxeHFUb0RmKytyREtKd29BdndPcDli?=
 =?utf-8?B?NlppelY3Y1hMMG45UFF2SjlZRnMwVGRLbUxJRmtKTG1BNytlMXRyeU5Ed1Bk?=
 =?utf-8?B?bG8wcnVCdVYwdEpOa1FmTTBlc1ZpalFXYll5cHdvR0FndU9PbGZEbzIvSnRP?=
 =?utf-8?B?MlBRdlJNb2RqTndlVDA2ZEFYdjdtRlZjVS9Ja3E0M2lOaUZGY2tZMlFsMWtZ?=
 =?utf-8?B?T0tWc3JGcFhzcGdjVi9OK0ROMXZ6WXpGZFVSVkVqTSt6MjM1MHFJd1RTTUNr?=
 =?utf-8?B?cmNUTnNlYy9zbWVDdEZOTW50R3ZDR2hZNnNBK3RCYUZnRk1TOTgvNDZkTUdO?=
 =?utf-8?B?STluLzRYWFpDN3dzQ2VMNHRoQzh2NGlKZGY3YzJZR3Z3am5OODdIMStjZHB4?=
 =?utf-8?B?MXN3TVdTRTA0YnZlYnVLcGg3aTFMV2ZJUGp3RkFMWEFtMTN0akdEUHlFdStz?=
 =?utf-8?B?TUp3V2Yxc2cyaXdVYm1aVWlId0FPaUt3TjVNMGU5S3owSkdDRVlySGR2N1dE?=
 =?utf-8?B?OHZzS21jUFlCRXN1RmgvOXQyUUwzc1hnYWFDdXBaL2V2dCtKWVJZbzFuY0F2?=
 =?utf-8?B?dFVPTnZ0Um0wM0IydFBYSVBILzc0MnBLLzE3YnFoOU12UTZRbW9xL0pZRzN5?=
 =?utf-8?B?VDdsMHd3L3ZIRmFZa2dWV3BLNldjbVU3aS83TExVOTRMOVZKd3JScC8yTjg4?=
 =?utf-8?B?bzhhbzdoOXgzWU5KN2dqTGRlSkJZQjQ4dUJpeFlhVDJVM0k2dnh6Q0E5Nldh?=
 =?utf-8?B?N2RlUHpEdkoxZ25tMW1SZGRXRkkrak5xMFNCOHdKVHdSNXFVOWwzeE9Qa3pt?=
 =?utf-8?B?QldOOUxKRjdsRUgyQXZoTFBaZVBVSEJ2a0lCTHdiMmtEME9zWDdhZW1LSzZh?=
 =?utf-8?B?L3RlSW1KbDNxUGVxTFdGUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <324EB1BEC7BA484E9A0D8A6C2108A35D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb32dc-4692-4be7-1447-08d934ae28a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 12:14:45.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9OUdEXdRmat7pywfOHDnFo3cyB0QGpSa18djueIm482qs8TeRZ5fRomEwobDXwDdCKOLGYWVJJt9Nk7QbsXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2406
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10021 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210073
X-Proofpoint-ORIG-GUID: G-y-ugqgmARcayhnFFXPJYx-xRAy36Rc
X-Proofpoint-GUID: G-y-ugqgmARcayhnFFXPJYx-xRAy36Rc
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgSnVuIDIwMjEsIGF0IDEyOjA3LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxNywgMjAyMSBhdCAwNTo0NjoyM1BN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBJbiByZG1hX2NyZWF0ZV9xcCgpLCBhIGNv
bm5lY3RlZCBRUCB3aWxsIGJlIHRyYW5zaXRpb25lZCB0byB0aGUgSU5JVA0KPj4gc3RhdGUuDQo+
PiANCj4+IEFmdGVyd2FyZHMsIHRoZSBRUCB3aWxsIGJlIHRyYW5zaXRpb25lZCB0byB0aGUgUlRS
IHN0YXRlIGJ5IHRoZQ0KPj4gY21hX21vZGlmeV9xcF9ydHIoKSBmdW5jdGlvbi4gQnV0IHRoaXMg
ZnVuY3Rpb24gc3RhcnRzIGJ5IHBlcmZvcm1pbmcNCj4+IGFuIGliX21vZGlmeV9xcCgpIHRvIHRo
ZSBJTklUIHN0YXRlIGFnYWluLCBiZWZvcmUgYW5vdGhlcg0KPj4gaWJfbW9kaWZ5X3FwKCkgaXMg
cGVyZm9ybWVkIHRvIHRyYW5zaXRpb24gdGhlIFFQIHRvIHRoZSBSVFIgc3RhdGUuDQo+PiANCj4+
IEhlbmNlLCB0aGVyZSBpcyBubyBuZWVkIHRvIHRyYW5zaXRpb24gdGhlIFFQIHRvIHRoZSBJTklU
IHN0YXRlIGluDQo+PiByZG1hX2NyZWF0ZV9xcCgpLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBI
w6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbWEuYyB8IDE1IC0tLS0tLS0tLS0tLS0tLQ0KPj4gMSBmaWxlIGNo
YW5nZWQsIDE1IGRlbGV0aW9ucygtKQ0KPj4gDQo+IA0KPiBUaGFua3MsDQo+IFJldmlld2VkLWJ5
OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0KDQpUaGFuayB5b3UgTGVvbiEN
Cg0KDQpIw6Vrb24NCg0KDQo=
