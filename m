Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154B63EA854
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhHLQPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 12:15:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54610 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230270AbhHLQNI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 12:13:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CGB5pG016272;
        Thu, 12 Aug 2021 16:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WnB4yE+8qSCksqilv4TBV6t7MMoSDCqCGwIJo105shk=;
 b=Wv/5yXuJz5KpigRu4KoGG24CvW0J+ml8WO3VqDUKeu/DvGp2rfUrQEeMtQIFiLMZT+SG
 Essmowm54sEMqv0jeF1YokBTWtVjgwJFiWLHnd1mbo1sbNQUAQsN2NKZN+bHQijxfaUH
 84n03FogIfEWFEsj5FylpJsKgs+fCVJSf+3jWY9CAdeZSSary2TCEBBI4rr1EytEj+Ac
 iBI11akGxDWBnKfdwGNRjRGsv+g8Jfej3KiCt2gDYEWBg6I+RofUSO289rUSAa0r9dZq
 YUUQlPYAmazPfcaWwW8Ey2D6pFvz5GCz8z9XppHQTEw5cVw/kx06HuGyXWujsGLbKag2 kA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WnB4yE+8qSCksqilv4TBV6t7MMoSDCqCGwIJo105shk=;
 b=Rh9CixrUQkfNr9+LIYcXUieODwLJPkFvPTqG6EFXni362cikndRiiJQ0iY65MQvCpXHM
 x2IW81ZuJmoexiW5kYbSuVe0b4klpRzmmULCEG3wP1KLwEBhqVbGCtxgPoC0Y1U3Crat
 uuSkDjtyGPwlZvwD9vOg1kdlKlGtV9kpTIsmuWoxqPIAsMI5ryqUTxbvDpYKZQ7Y+M4Z
 xq/kdPSYnkayWf7Y5bcVCQAiQr9cY+a97mng5/XLVPiQqMmcObsfjCcC+sbHzpCofyeg
 8wWbuSoI1mAxrhiywqYslx7bv4c8T3M6Gx+4VFfmO2nK2M+4YHOHJhChZNhJIE7JqPVe aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aceudu9qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 16:11:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17CGAdiT145714;
        Thu, 12 Aug 2021 16:11:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3abx3y48pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 16:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwD2KmpNPK+rgoyESh2Iqsup3RD0+4BEQOB2C1Xf5OW+Mb9TrlDluQUEipchpc6W0OA1vsIxFJH+Axn02ire2iDNDZZn7vdWYsufa0iNiypXxr1nlp8RD57+Wd5E7zxv1jKbCbKUCSefOH11N6VGoljxK7oMiFzcBIlTzVBWEFe8rSUetI2C4Cm4K14U8790a+sS/cFLy7hThGLsaMkO1WgfzepOS54F0ixyx/TvQCX9TEKYQQlnUnQKY7YFVpfJp4EDr1oYwr1Oo7J+/qrn0uRl8859/QSQ51L06FJLqVzpntDfRscmf9exNStMYrgNkClK4uFjEdWC7svm3mszwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnB4yE+8qSCksqilv4TBV6t7MMoSDCqCGwIJo105shk=;
 b=AaLEY/I5KVBnt+F5g7E7zFQUP4LoXW4BR4fnlYViI9jZ/SPl0Q9l6QWpst5T4XzXEnwKnQpcg/RI3+rPl2FFMHltgjbOWlqbtsVAL2dWMldvowAZ+2w9P7ZCTy0FrVtjZVkWhvXJojqSTUo0D4A/ignQhx/rmUl7oIkog3/K6T9Pst74pZQB2WwSeARqC45rOXABCwuOjKI+IdZsIl+DeLQWO5GPDVxkjSzT3YbOJV07x7Q/sDI7UQjOAkjuy1ETqevQtQecaD9T8e/9jryiQoej0j2IIid6UZpM1YHkq8HRuCoSn0ZIPwg0pHwqOVDYfH39DmZB7DWHhcOY06dGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnB4yE+8qSCksqilv4TBV6t7MMoSDCqCGwIJo105shk=;
 b=C0iDSs7KEAvic1EiS+QhKiino93zsEVaF2UQZGt4DaQxG/HeU4cvgqfbCuTGG4P9wg8w1bkfC9wg6n7Ku9uULEIM/iG4SJcdehrWbtY2yA5OxJa38OfsRQqNkJtgHU59WQ6ViQF4VrlVNzrewLcOHt1PrgrH12pdQkT8OEz1IgQ=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB3756.namprd10.prod.outlook.com (2603:10b6:5:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 16:11:53 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%9]) with mapi id 15.20.4415.018; Thu, 12 Aug 2021
 16:11:53 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/core/sa_query: Retry SA queries
Thread-Topic: [PATCH for-next] RDMA/core/sa_query: Retry SA queries
Thread-Index: AQHXj5CO8nwyDcx2GUqGZzqT7AqMCKtwCmQA
Date:   Thu, 12 Aug 2021 16:11:53 +0000
Message-ID: <ED24C343-35CD-4E08-AFCB-70EB089FF792@oracle.com>
References: <1628782891-26471-1-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1628782891-26471-1-git-send-email-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8564c515-57bc-4af9-1e8b-08d95dabe642
x-ms-traffictypediagnostic: DM6PR10MB3756:
x-microsoft-antispam-prvs: <DM6PR10MB3756DE5E74A0F4A4E7A9A397FDF99@DM6PR10MB3756.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UskgRqv8p2gCLHg0IFmu1WEFE+J2Dn0znxKZImhflRG2WxphakJw8jHx1P9TTGrv/X9DN9wgXaZcnN/30VyETC/LH83ue8UO4J0+P5muQmjKEpD8HE/5heBqaN8h7TQL0C4dIKqpDm8mty3Xozyk2BhLJv3zblJvGT55meK5b+LkK78ZfdrvY1I/z3jewWUNB9Tt4F/bW1Q4q0YCaUlMron0DDDhZ2+DASYE2CSiBqVFkpzT8zZKw3W+Qf/aEUyqMJLwOnbELTrMWKogEFOmc8IXZn7UxX6RuhiF7L1NgD1mfSPmae0S1bzpA6B6GYi4CeOwKgy98ct+DHu/WhZHQn9PhSNEtUPrcnr28PFnfTrwe+eQmk2EgxHkP3f+BKZ6MKNkaltz4cZ3hMqxM/xRGTERSdrA09bD6XcEMEfgygZiPEnpzQBRcg3sJtKGLdhfYvEK2Gntk3kUgMlsDoVzjnFdHhlqk0pp6f9+jLa0u1BpZIOhWVYjXIGyNjlTX8qNnctEcWjZsMOJjzoml2vx5MYifiCp4drKTKXKUklrYDzCLrja95eYwGYNTExvVkRupGzltlGQ2TUHm9QFNTvdziWTLYioF9cYENXWAIfVbBUpkGb2PdUqu6iks7YVd932h6naYSeZzCp7JrASMg0pt3oO0TRxV4ZNsx/UeGFswCwN9cP9P//LswtOVgAiihcQOGzSI+8+AwJ5g9FMhBsH0tMvRSl5jS9AydbkWFRSFr/ELwocuQj0J58BtbdpGBM6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(86362001)(110136005)(36756003)(316002)(8676002)(83380400001)(71200400001)(6512007)(2616005)(66574015)(66556008)(66946007)(66476007)(26005)(2906002)(186003)(66446008)(6486002)(44832011)(8936002)(5660300002)(38070700005)(33656002)(6506007)(91956017)(38100700002)(76116006)(64756008)(53546011)(478600001)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2lmaDBUbmFPc2VHTXJFYUh3T3lId1NlaElQMzJEWEh1RmhWbGdNNWFQTW9J?=
 =?utf-8?B?NjRWQVVWNnQ0MHZaRWI3RXdRenk3YjVXNGVtcktaK1NFT1BRdDJ4OHdveHBi?=
 =?utf-8?B?d3BEbXZ3VmwrWlVXRGlENnNGK3BMamVGRDZGbjhvRzdzY2NTTGY5NnBacGlu?=
 =?utf-8?B?MEdEUVgydzBPMGowWENLVmdDYkhHNS9LVlUxa0FEa2NjNXNRUE5WWEFyVVFS?=
 =?utf-8?B?cWM2Z1V0bTlDT1pNUFJ2QkY5ME5Oa25RMHd0Y213V3FGZTlVS0R1UmF3VXo3?=
 =?utf-8?B?a29RYTQyanF1N2ozdjZiM1E5RHRhTGx3czFpNE01K2dWRWtBZ2w1ODlPUlhM?=
 =?utf-8?B?cGU0UWVibUVIZTZKT2xiUk00elc3RlZYVW5pNWJ2VFlHRUxOYmVCRldjUHI1?=
 =?utf-8?B?aUNyYnNJbzZ3OHZkMUtMQ0UwVExuRlZ6YkRmVTB1Um9Cc0FwNklyV21velhk?=
 =?utf-8?B?WTBCTUluYlBUVXVsMUxyN2FidGtWZU5DSSt2bWZQRDB0Uk0rUTlTdVV4VHJS?=
 =?utf-8?B?d2lDd0FubWZNYkpZcUtIbStZTHNqM1UyRFZEbU5nTXQrNHg0RTdJNVhKMHNU?=
 =?utf-8?B?NDlUZlFFTUc2MlJkWllCUEcwT3cyRXNjbDB3L0JYU2djMGZGUDd5dHVOOGta?=
 =?utf-8?B?UTF0VjhOVTVYMzUzM2NpSUExbUpsT2JOZlQ3Y1BFWFB3dzBGVjVmVENGV1hy?=
 =?utf-8?B?WkNpSUpnb1ZxeGxsMDhIWk9vZ21DTGsrMUdZK3BVUUhLbVdWRHNBN1FkQjhU?=
 =?utf-8?B?cmhZQnEzVzJ1OWJTVGovT0gwRFpac0xUUXhoQVcwU2V2MSswK0FrTHlESGww?=
 =?utf-8?B?YWJhNjBzNDkrL2hqYWw1UTNRdE8yalhPWGdZUjhaclFXR1BySERaeE5zVmI2?=
 =?utf-8?B?WTJaeE5jOURzVHpXTHBRVlR0VEhqc05XbWIvMjRid3dqVnYwK0lZR2x0a0Rz?=
 =?utf-8?B?VXZBbk1iUnFvRUd3b3NLL0tWdlZQQkdiYlo0YUFZNXZBNDZZNm9QNnFyRXhJ?=
 =?utf-8?B?N3psR0UxWW1lcldaOG9uSmU3ZmJVV0ZHZk84ZjFRMWUxekQ4bmZGMTA4WU9D?=
 =?utf-8?B?ZG0ydTF3dkpZbnZZQ3NDQ0JPNEhPeTlmT1F2MkZqNFByemhuZ09MZlQ4QVFl?=
 =?utf-8?B?amRjK255UHVKc1RucWd5ZzlVbTg4d0tIVUFINkxyQXJBVEJkZzMrV3QyUkhp?=
 =?utf-8?B?clF0Ym54MlhFcHFRc0tkNm9CMkpoaDdXN0NZWmlTaXRMajcvTHAva005eEdU?=
 =?utf-8?B?QmxmbXc2eTFoOGVvQW5YbzB0azlBeUVGdytXTUxSbWJpQWNuanMwaTQwSzE4?=
 =?utf-8?B?UXN1R2dwNW5YdmRiVlpMRFpGeXEvY1NkczA4dm5MTVcxZmJSOXREN1ZMeWty?=
 =?utf-8?B?aXJmekRyMzU3TU80ZkhvYlU0b0o1ZkdqZU9oZ09lc2VvWU5uMVZEaS9leDNk?=
 =?utf-8?B?aHZLYzkxcTBsYUc0eHhPejhkaVpkeDdKZGFpSjJUSXdnUVN0d2txVmNGK1Fx?=
 =?utf-8?B?U1lQano2N04ybXVDVGFtUVZVWmp2ZEZ5RmlDaWN6TXYrTGhrcVJRMWVVK1R3?=
 =?utf-8?B?MEl5c0d2RCtDajRpdWpNRXYzRlk5SkFaKysrZGhPaWNLbXI2OURUU2FiWEo4?=
 =?utf-8?B?NzZDeEROSCtxbkpwU3NvWm5mcFVXOEozYUE4U29RSkNZejQ2T0drOGFYeGhR?=
 =?utf-8?B?c2UrV1dpaW95dTlpckw5bEllRXFGVW5xRVV0M1J0Z1RWUGxxU3B1OEg3MDNL?=
 =?utf-8?B?dDBhNExLWXBpUVU2WjlSZEV2K0o1eXR6OGhWRTRPTVpZcHVwZE50Z1BZcWQw?=
 =?utf-8?B?RHUxMFYrcVNPeXRKWisyQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACC25ADDAEBDB641B285478D8B1CCE5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8564c515-57bc-4af9-1e8b-08d95dabe642
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 16:11:53.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRJ8X5pQ6WrZn3UMph4Nd7j1howB5J0IKgmEUDd8vNfplfqCMXvp3Bqbjk8J/oKoS5fAQXD3QB7vkiDcfafwfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3756
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120105
X-Proofpoint-ORIG-GUID: MAH4BpIQRo5tLD3AIC3fPl4cvaPLP6Ad
X-Proofpoint-GUID: MAH4BpIQRo5tLD3AIC3fPl4cvaPLP6Ad
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTIgQXVnIDIwMjEsIGF0IDE3OjQxLCBIw6Vrb24gQnVnZ2UgPEhhYWtvbi5CdWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IEEgTUFEIHBhY2tldCBpcyBzZW50IGFzIGFuIHVu
cmVsaWFibGUgZGF0YWdyYW0gKFVEKS4gU0EgcmVxdWVzdHMgYXJlDQo+IHNlbnQgYXMgTUFEIHBh
Y2tldHMuIEFzIHN1Y2gsIFNBIHJlcXVlc3RzIG9yIHJlc3BvbnNlcyBtYXkgYmUgc2lsZW50bHkN
Cj4gZHJvcHBlZC4NCj4gDQo+IElCIENvcmUncyBNQUQgbGF5ZXIgaGFzIGEgdGltZW91dCBhbmQg
cmV0cnkgbWVjaGFuaXNtLCB3aGljaCBhbW9uZ3N0DQo+IG90aGVyLCBpcyB1c2VkIGJ5IFJETUEg
Q00uIEJ1dCBpdCBpcyBub3QgdXNlZCBieSBTQSBxdWVyaWVzLiBUaGUgbGFjaw0KPiBvZiByZXRy
aWVzIG9mIFNBIHF1ZXJpZXMgbGVhZHMgdG8gbG9uZyBzcGVjaWZpZWQgdGltZW91dCwgYW5kIGVy
cm9yDQo+IGJlaW5nIHJldHVybmVkIGluIGNhc2Ugb2YgcGFja2V0IGxvc3MuIFRoZSBVTFAgb3Ig
dXNlci1sYW5kIHByb2Nlc3MNCj4gaGFzIHRvIHBlcmZvcm0gdGhlIHJldHJ5Lg0KPiANCj4gRml4
IHRoaXMgYnkgdGFraW5nIGFkdmFudGFnZSBvZiB0aGUgTUFEIGxheWVyJ3MgcmV0cnkgbWVjaGFu
aXNtLg0KPiANCj4gRmlyc3QsIGEgY2hlY2sgYWdhaW5zdCBhIHplcm8gdGltZW91dCBpcyBhZGRl
ZCBpbg0KPiByZG1hX3Jlc29sdmVfcm91dGUoKS4gSW4gc2VuZF9tYWQoKSwgd2Ugc2V0IHRoZSBN
QUQgbGF5ZXIgdGltZW91dCB0bw0KPiBvbmUgdGVudGggb2YgdGhlIHNwZWNpZmllZCB0aW1lb3V0
IGFuZCB0aGUgbnVtYmVyIG9mIHJldHJpZXMgdG8NCj4gMTAuIFRoZSBzcGVjaWFsIGNhc2Ugd2hl
biB0aW1lb3V0IGlzIGxlc3MgdGhhbiAxMCBpcyBoYW5kbGVkLg0KPiANCj4gV2l0aCB0aGlzIGZp
eDoNCj4gDQo+ICMgdWNtYXRvc2UgLWMgMTAwMCAtUyAxMDI0IC1DIDENCj4gDQo+IHJ1bnMgc3Rh
YmxlIG9uIGFuIEluZmluaWJhbmQgZmFicmljLiBXaXRob3V0IHRoaXMgZml4LCB3ZSBzZWUgYW4N
Cj4gaW50ZXJtaXR0ZW50IGJlaGF2aW9yIGFuZCBpdCBlcnJvcnMgb3V0IHdpdGg6DQo+IA0KPiBj
bWF0b3NlOiBldmVudDogUkRNQV9DTV9FVkVOVF9ST1VURV9FUlJPUiwgZXJyb3I6IC0xMTANCj4g
DQo+ICgxMTAgaXMgRVRJTUVET1VUKQ0KPiANCj4gRml4ZXM6IGY3NWI3YTUyOTQ5NCAoIltQQVRD
SF0gSUI6IEFkZCBhdXRvbWF0aWMgcmV0cmllcyB0byBNQUQgbGF5ZXIiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiAtLS0NCj4gZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgICAgICB8IDMgKysrDQo+IGRyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL3NhX3F1ZXJ5LmMgfCA5ICsrKysrKysrLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbWEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+
IGluZGV4IDUxNWE3ZTkuLmJiY2JhYjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9jb3JlL2NtYS5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+IEBA
IC0zMTE3LDYgKzMxMTcsOSBAQCBpbnQgcmRtYV9yZXNvbHZlX3JvdXRlKHN0cnVjdCByZG1hX2Nt
X2lkICppZCwgdW5zaWduZWQgbG9uZyB0aW1lb3V0X21zKQ0KPiAJc3RydWN0IHJkbWFfaWRfcHJp
dmF0ZSAqaWRfcHJpdjsNCj4gCWludCByZXQ7DQo+IA0KPiArCWlmICh0aW1lb3V0X21zKQ0KDQpU
b28gZmF0IGZpbmdlcnMuIHYyIG9uIGl0cyB3YXkhDQoNCi1oDQoNCg0KPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKw0KPiAJaWRfcHJpdiA9IGNvbnRhaW5lcl9vZihpZCwgc3RydWN0IHJkbWFfaWRf
cHJpdmF0ZSwgaWQpOw0KPiAJaWYgKCFjbWFfY29tcF9leGNoKGlkX3ByaXYsIFJETUFfQ01fQURE
Ul9SRVNPTFZFRCwgUkRNQV9DTV9ST1VURV9RVUVSWSkpDQo+IAkJcmV0dXJuIC1FSU5WQUw7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9zYV9xdWVyeS5jIGIvZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvc2FfcXVlcnkuYw0KPiBpbmRleCBiNjE1NzZmLi41YTU2MDgyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9zYV9xdWVyeS5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3NhX3F1ZXJ5LmMNCj4gQEAgLTEzNTgsNiArMTM1OCw3
IEBAIHN0YXRpYyBpbnQgc2VuZF9tYWQoc3RydWN0IGliX3NhX3F1ZXJ5ICpxdWVyeSwgdW5zaWdu
ZWQgbG9uZyB0aW1lb3V0X21zLA0KPiB7DQo+IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAJaW50
IHJldCwgaWQ7DQo+ICsJY29uc3QgaW50IG5tYnJfc2FfcXVlcnlfcmV0cmllcyA9IDEwOw0KPiAN
Cj4gCXhhX2xvY2tfaXJxc2F2ZSgmcXVlcmllcywgZmxhZ3MpOw0KPiAJcmV0ID0gX194YV9hbGxv
YygmcXVlcmllcywgJmlkLCBxdWVyeSwgeGFfbGltaXRfMzJiLCBnZnBfbWFzayk7DQo+IEBAIC0x
MzY1LDcgKzEzNjYsMTMgQEAgc3RhdGljIGludCBzZW5kX21hZChzdHJ1Y3QgaWJfc2FfcXVlcnkg
KnF1ZXJ5LCB1bnNpZ25lZCBsb25nIHRpbWVvdXRfbXMsDQo+IAlpZiAocmV0IDwgMCkNCj4gCQly
ZXR1cm4gcmV0Ow0KPiANCj4gLQlxdWVyeS0+bWFkX2J1Zi0+dGltZW91dF9tcyAgPSB0aW1lb3V0
X21zOw0KPiArCXF1ZXJ5LT5tYWRfYnVmLT50aW1lb3V0X21zICA9IHRpbWVvdXRfbXMgLyBubWJy
X3NhX3F1ZXJ5X3JldHJpZXM7DQo+ICsJcXVlcnktPm1hZF9idWYtPnJldHJpZXMgPSBubWJyX3Nh
X3F1ZXJ5X3JldHJpZXM7DQo+ICsJaWYgKCFxdWVyeS0+bWFkX2J1Zi0+dGltZW91dF9tcykgew0K
PiArCQkvKiBTcGVjaWFsIGNhc2UsIHZlcnkgc21hbGwgdGltZW91dF9tcyAqLw0KPiArCQlxdWVy
eS0+bWFkX2J1Zi0+dGltZW91dF9tcyA9IDE7DQo+ICsJCXF1ZXJ5LT5tYWRfYnVmLT5yZXRyaWVz
ID0gdGltZW91dF9tczsNCj4gKwl9DQo+IAlxdWVyeS0+bWFkX2J1Zi0+Y29udGV4dFswXSA9IHF1
ZXJ5Ow0KPiAJcXVlcnktPmlkID0gaWQ7DQo+IA0KPiAtLSANCj4gMS44LjMuMQ0KPiANCg0K
