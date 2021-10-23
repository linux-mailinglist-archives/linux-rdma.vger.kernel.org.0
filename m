Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABC543845E
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Oct 2021 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJWQuq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Oct 2021 12:50:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53490 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhJWQup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 Oct 2021 12:50:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19NFJc9N001638;
        Sat, 23 Oct 2021 09:48:23 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bvhwqgm4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 09:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI+qmDT9vJhu6t1RTMJhD4Jn64AcyV7Z0Rx3AQHaS/UcSQ1Q3sxPcrRvq2OE5FTWnPNESHPEtoj27o3giZXmnyQ9r1AJYjuxZpwPGVr0cwIJ4ZAE7GXJvhCtCYBa0U+g8n1BMB1T0Hb5if0QuOKvFDvabTAGBYzjTCphGlNxfIMOcJZijuZoX6ZuhdiHFYWWM3VxzxiZhfMcdrGVnbkey40f4kQus7rKL03QDE5CnTVTfJLHGHVHPLc/8ZpLaddNl8Wmju5CVNOfLsD3Lssf/nCxuvRbDrwCZYSKnNAIM/EcjWdkESthamH2Thg8DRZZUYzyOU3GHb7HAJLDMKv2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGyFJuZ62aWAAsFq4DTNZp+YNsxS8qUwCz3JOxl+qXI=;
 b=ZiAAyaHUwA2W+JRmVm97eT70UN7A7Az874PsPMOd5sOH6Gty49CoofUE0M4jK2O8T2L675KD/0kLaesTkuf8ymV+qG/h5V1S7FvscEJx6ZZpespp+MUsZmwoBzQzcm8VxMB7q3RA5V08AdjgyQKUjYKTyJYoaQWU3NKdyg363IEi3Q9A1dl1iyiMinf3v6bcgqmShcEjCE+sQAfdS/yoDxslUrG8Tp+qBajoJ7d2S+z6rxI7Lm+BFUB0Y5GzHa2/NYL/s/emcueGZmz/cf+AN/2iSDcHpcWGo4l81WfvG2ncijy40bUt9Z1Slui1DcNwB/dSkIeN0kkKxs/GEogodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGyFJuZ62aWAAsFq4DTNZp+YNsxS8qUwCz3JOxl+qXI=;
 b=VwvTgWqxFmFGNrybI/xJG3ttXuHhm7NQdd4h9USPsn/kQ3ZiryFaDALeoe3vzLeqa2ynhNLSE0d566osMktj2BvxPnYCmgR1Lbpke9DL3tT9uNcyOS6jBkjgk1y4t0cgTAjvhmWzpwJhoitBGx2Tdu2d0IwaRqaEL3A0pcix1Tw=
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9)
 by BYAPR18MB2520.namprd18.prod.outlook.com (2603:10b6:a03:12d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sat, 23 Oct
 2021 16:48:21 +0000
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::d06:b37c:6f9a:ed3d]) by SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::d06:b37c:6f9a:ed3d%7]) with mapi id 15.20.4628.020; Sat, 23 Oct 2021
 16:48:21 +0000
From:   Alok Prasad <palok@marvell.com>
To:     Kamal Heib <kheib@redhat.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Shai Malin <smalin@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: RE: [EXT] Re: [for-rc] RDMA/qedr: qedr crash while running rdma-tool.
Thread-Topic: [EXT] Re: [for-rc] RDMA/qedr: qedr crash while running
 rdma-tool.
Thread-Index: AQHXlmBGBRsMJ3OmxkGy5CMGsVVjGKt92iiAgART0wCAXV4WAIABolnw
Date:   Sat, 23 Oct 2021 16:48:21 +0000
Message-ID: <SJ0PR18MB39003BE2195CEA019CBF9091A1819@SJ0PR18MB3900.namprd18.prod.outlook.com>
References: <20210821074339.16614-1-palok@marvell.com>
 <YSDpuTIsM2gL1h7e@unreal>
 <SJ0PR18MB390083F8ADF0036D6647F75DA1C59@SJ0PR18MB3900.namprd18.prod.outlook.com>
 <559f795c-c1f6-efea-fbe6-15fc02768a6e@redhat.com>
In-Reply-To: <559f795c-c1f6-efea-fbe6-15fc02768a6e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43af68cc-c060-4c3c-af04-08d99644ec4d
x-ms-traffictypediagnostic: BYAPR18MB2520:
x-microsoft-antispam-prvs: <BYAPR18MB2520ACA313D5A1C7522D7B93A1819@BYAPR18MB2520.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrMNfFtvR04Cgpvcd5QiMZBKRsSkLK7TwxsAB/OJrl8Ny8iwM4BedncknJzumhN9yGcMKy0uXrg6lLxtxPHW1wO0zGNHgH+CJ1XXKUQgl5XMCW2PNZ0w8DSt1Al+lxI0JJAEcX0wJroQ2owysQX6bwIA+GTJ2FZHBv+dkc7TZCASINYTs3Nex1H1IxxDCgH/Vs/XTscRwS+7/bev03anzj7TxtIY3cbkMB26Dt+P0oTLGfonsexqyLbekxnkQxSESGAt71zHTZ6gGGHf4TZktGE6OrTAPjn7BsX7dRjRdQcaQ5PuvcokO66PvhmmFFVf2sXCcuzhW31MRCUz0AbKvACyXGApzGClgM/7j9inq61e2O7QR1UBQvwiN3gXScEj4p90T1+L5SjCWAocUqD5DAaGV49M6h4G9a1yhUl6HqqHkXICwNzrd8ne2JzFfLd1ZUvtWaRJWvlIK4QVJjV6ZbEPIs/Mu1M0HxUuaV3AzqcYI4PZRyXca7af7grZZgYtTiSFhfsc6Tb3Wou0S5yFIcL1qj+SnafnGWd9L/htKtE6+925tREWxZHorUZPt4l3NexOpMzAZDh3j7y87ZxNbeJb/Gt0BSuk08QZ/2Gnbss4pUc3oJT0dzAQDaPZ1x+gIfw+Q0JbHddf5xqg6jLfQ7+6GA7c6MMQH3yUwunAp9PrhslXq5jrxsJMsjxgkpVx0nG+9K70J+50asuWA9rCPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3900.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6916009)(71200400001)(508600001)(7696005)(2906002)(316002)(55016002)(53546011)(26005)(38100700002)(66946007)(66446008)(64756008)(86362001)(122000001)(66556008)(66476007)(6506007)(52536014)(76116006)(9686003)(186003)(8936002)(38070700005)(33656002)(83380400001)(8676002)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkV0ZktsYVAzMGZaOEFBeUFoUlJOekRCZC9GSjZkbXByaEVEai9RUkpoblZu?=
 =?utf-8?B?NHlOK1JrUk5CN2pCcDZmS0RwaUhHTXRaMTVRclB0NnpqbjlPbXcwQ2I3Si9k?=
 =?utf-8?B?UG5IQXhHcWRkWS9XRWNJSGJqZWo1N3lBQ29iQ1lNU282bkhwZyt3QVhZSnly?=
 =?utf-8?B?QWpGTnJVdFFiWlRHMlFVYzRQeE5BNUJDOXlzUlJ0QWVwMGVnWkdMb0lVaWRW?=
 =?utf-8?B?WG05OVRlb3VFdGdHNUxHWFk3M01Xd3BzSERLeXlwQjBuN0RLWGhnNGh4bllu?=
 =?utf-8?B?ZysrMFdaZ3grbklFejNzNkxVUVlMQnIwSm9BMmJ2UksxUk5tNzdJVHRQcW5x?=
 =?utf-8?B?dml1TVA1ZHo0ZXo2R0JHZVNvQW5jbHovZVFHNUloNEkzd0Z4RHFENnNKQURw?=
 =?utf-8?B?RjZvaFNSdmlnU3ViSVlnV1llWHpYQ2tmTGV0UDBYUUlzdFdnUnRPT1BkcC80?=
 =?utf-8?B?SHoyTzVBVGdxNENGTngyVkF5WVpCRVVTQkEyZThrVm53QTdrZy9lazdlQWZU?=
 =?utf-8?B?WmpSaFRjbEoxOHhtMi9jVS9KTlJnQ2NlSm9QSVFzdnBqV1ZodTJGY1JiSFRQ?=
 =?utf-8?B?WHpmY2JlRHIvVXVRcitvZ0dialRhMU5zYnJ3bFFEaXhPSUZ2ZlZYa3BEem15?=
 =?utf-8?B?TUlTSkl2cFVXVUZHRDk3eWh2d05KK04zQmQxWWlnU3c0NWJqQjZEWUpxN0Ry?=
 =?utf-8?B?RExlbnZENU82UkJ0SXA0THBXa0owMnRGeU9QeHRYY25FRzNUMEZwL01wT0dk?=
 =?utf-8?B?ZXUxTFZnOWIyQyt2SjhDRjRYbEg1QU9FeTUxaEcxOGhnaEJaRGw3dTlwVjNk?=
 =?utf-8?B?eGx4cDJJYWZsQ21lRisyU3Jub0h1ajhHUHRzNnVxRUtOQ2ZzeU11KzZxb083?=
 =?utf-8?B?YW0zdjN4Q2Y2MDdMMTBPdG41ZXRnZW9xTlpyMzJsSHRpSUkyV3kvSGt0S1NZ?=
 =?utf-8?B?YS9DZzVaKy9PamZMLzhvUW9CMUtHQzZaU1lNRklYWG9RYXJveEpISVpCRjls?=
 =?utf-8?B?eUlQay84MC9pTmtEenNiU3ptellOek9VSjdFOHJ3Y3hzQWVvZWR4c2YyRzBD?=
 =?utf-8?B?aVVoUStaZVFLbE9vSzBuT3VEM2pDOVNYWFlmOVExY2JDNG5Edm1oTjJhUkNw?=
 =?utf-8?B?Slk0L2psVWlRUDhNNGJTSzBoZUs5VFk3YkVTU1IvMU1JNlBreW1uMlQzemw0?=
 =?utf-8?B?RXdtMHNNM0oyNmIzNVdVbmVUbDJTcE45M0ZOZ1ZKNlJrZVpGUHpIcWNvRnlj?=
 =?utf-8?B?ek52REUzZEkyWlJLRG5pMnh6bTVMblJKa3ZBOUxHS0FlVkw0MHlrQ293NTV1?=
 =?utf-8?B?R1RJbTNLNUl3UXBDNVlFaWtVTTNUN0JoOFd4Ym1pd0hwQ1AzQ2xFdmhiTCtS?=
 =?utf-8?B?SWZxdG0xWkpOUkVPdVV0eDhSdFhrVDlpVEFkTkc5Tm9rYy94eTlPQms1S1lD?=
 =?utf-8?B?NjgwYzV2aG5nOTdReCt5REdjbmIyUmZpSktLaHNIUnRpcXdKTnlYLzFKYWdj?=
 =?utf-8?B?QUFlTlhCOEs1VGREUWZjZTdwWmxibEVCQUxKVHRMQlBZNStjYjZOSDRLME5E?=
 =?utf-8?B?MjdJVlZvdXJSVUpvOGZyVzFXMHptcVpid2ZHeWRiMFV2YlhpWEpKNzM5N0FE?=
 =?utf-8?B?RGxUblhVRWpIS0Q1Yk1lMzdrenlOSVdmY3oxTTdQK29BVmdSVW04UkVVM2NI?=
 =?utf-8?B?WE1HY0JVOFpnb2FGUGhlRnFkSjU2ZWt3TjhwbXRlalU1REowb1dYcE55b1g4?=
 =?utf-8?B?eU1MTnRzelU5eFkxM1B5OTEwK1E2VFd0eHlsYXRzcm9tV1NyZzRKNnlCY3gr?=
 =?utf-8?B?ZlVjWVQ1V1JoeWJsNWR5ajZrQXBGVEJFdG9vTStqZ214eGRtZkhNTnBpVUlz?=
 =?utf-8?B?RTNIeDVwWEdhSlJMUXlvNzV4V1gzaENIdnVqVzd6Q3ZjNzdaVlQ0c243aGVB?=
 =?utf-8?B?U2plRDljNEt5amtHWFNSckRVUDhqMWF4a2h3eE54ZmVTeDlpUmRJdExqR0sw?=
 =?utf-8?B?ak1GVXFXR2l2SEFQNitvKzZJS3Y3aXZSbjljbDVqeVhqSnNSNU5LR1RVTVBt?=
 =?utf-8?B?cjk5a3EwSUNiTjJOaDkwemhEbXJJdy9saEtkMEhlMGpvK1Bxdjg5Mkg2dUhM?=
 =?utf-8?B?c2lxWjN3S1N0KzZFUDBLeUVtUEpyeU5wdm42WlBza21vbXc2SUU0bDM2d1hL?=
 =?utf-8?Q?hPPaBAAcu3YRwON8IqGNgKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3900.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43af68cc-c060-4c3c-af04-08d99644ec4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2021 16:48:21.4140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 055EP1xqJ70+ePIuHOR9AJrhqUXhhST3v5tIr5osKvNeZkYmASDM7v7WwXbATToCFkUAU00Nv+xo8xNVIHotHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2520
X-Proofpoint-ORIG-GUID: I9FypV7Gs-WpRh1A-pjry0VHaV3pSMto
X-Proofpoint-GUID: I9FypV7Gs-WpRh1A-pjry0VHaV3pSMto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-23_03,2021-10-22_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYW1hbCBIZWliIDxraGVpYkBy
ZWRoYXQuY29tPg0KPiBTZW50OiAyMiBPY3RvYmVyIDIwMjEgMjE6MjANCj4gVG86IEFsb2sgUHJh
c2FkIDxwYWxva0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6IGpnZ0B6aWVwZS5jYTsgZGxlZGZvcmRAcmVk
aGF0LmNvbTsgTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+OyBBcmllbA0K
PiBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPjsgU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwu
Y29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW2Zvci1yY10gUkRNQS9xZWRyOiBx
ZWRyIGNyYXNoIHdoaWxlIHJ1bm5pbmcgcmRtYS10b29sLg0KPiANCj4gRXh0ZXJuYWwgRW1haWwN
Cj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IA0KPiBPbiA4LzI0LzIxIDA5OjE5LCBBbG9rIFBy
YXNhZCB3cm90ZToNCj4gPiBIaSBMZW9uLA0KPiA+DQo+ID4+IE9uIFNhdCwgQXVnIDIxLCAyMDIx
IGF0IDA3OjQzOjM5QU0gKzAwMDAsIEFsb2sgUHJhc2FkIHdyb3RlOg0KPiA+Pj4gVGhpcyBwYXRj
aCBmaXhlcyBjcmFzaCBjYXVzZWQgYnkgcXVlcnlpbmcgcXAuDQo+ID4+PiBUaGlzIGlzIGR1ZSB0
aGUgZmFjdCB0aGF0IHdoZW4gbm8gdHJhZmZpYyBpcyBydW5uaW5nLA0KPiA+Pj4gcmRtYV9jcmVh
dGVfcXAgaGFzbid0IGNyZWF0ZWQgYW55IHFwIGhlbmNlIHFlZC0+cXAgaXMgbnVsbC4NCj4gPj4N
Cj4gPj4gVGhpcyBkZXNjcmlwdGlvbiBpcyBub3QgY29ycmVjdCwgYWxsIFFQIGNyZWF0aW9uIGZs
b3dzDQo+ID4+IGRldi0+b3BzLT5yZG1hX2NyZWF0ZV9xcCgpIGlzIGNhbGxlZCBhbmQgaWYgcWVk
cl9jcmVhdGVfcXAoKSBzdWNjZXNzZXMsDQo+ID4+IHdlIHdpbGwgaGF2ZSB2YWxpZCBxcC0+cWVk
X3FwIHBvaW50ZXIuDQo+ID4+DQo+ID4NCj4gPiBJbiBxZWRyX2NyZWF0ZV9xcCgpLCBmaXJzdCBx
cCB3ZSBjcmVhdGUgaXMgR1NJIFFQDQo+ID4gYW5kIGl0IGltbWVkaWF0ZWx5IHJldHVybnMgYWZ0
ZXIgY3JlYXRpbmcgZ3NpX3FwLCBhbmQgbm9uZSBvZiBmdW5jdGlvbg0KPiA+IGVpdGhlciAgcWVk
cl9jcmVhdGVfdXNlcl9xcCgpIG5vciAgcWVkcl9jcmVhdGVfa2VybmVsX3FwKCkgaXMNCj4gPiBj
YWxsZWQsIGJvdGggb2YgdGhlbSB3b3VsZCBoYXZlIGluIHR1cm5lZCBjYWxsZWQgZGV2LT5vcHMt
PnJkbWFfY3JlYXRlX3FwKCksDQo+ID4gaGVuY2UgcXAtPnFlZF9xcCBpcyBudWxsIGhlcmUuDQo+
ID4NCj4gPiBBbnl3YXkgd2lsbCBzZW5kIGEgdjIgYXMga2VybmVsIHRlc3Qgcm9ib3QgcmVwb3J0
ZWQgb25lDQo+ID4gRW51bSBXYXJuaW5nLg0KPiANCj4gSGkgQWxvaywNCj4gDQo+IENvdWxkIHlv
dSBwbGVhc2UgdGVsbCB3aGVuIHlvdSBwbGFuIHRvIHNlbmQgYSB2MiBmb3IgdGhpcyBwYXRjaD8N
Cj4gDQo+IFdlIG5lZWQgdGhpcyBwYXRjaCB0byBnZXQgYWNjZXB0ZWQgaW4gb3JkZXIgdG8gZml4
IHRoZSBkaXN0cmlidXRpb24NCj4gdmVyc2lvbiBvZiB0aGUgcWVkciBkcml2ZXIuDQo+IA0KPiBU
aGFua3MsDQo+IEthbWFsDQoNCkp1c3Qgc2VudCEgVGhhbmtzIFJlbWluZGluZyBpdC4NClJlZ2Fy
ZHMsDQpBbG9rDQoNCj4gPg0KPiA+Pj4NCj4gPj4+IEJlbG93IGNhbGwgdHJhY2UgaXMgZ2VuZXJh
dGVkIHdoaWxlIHVzaW5nIGlwcm91dGUyIHV0aWxpdHkNCj4gPj4+ICJyZG1hIHJlcyBzaG93IC1k
ZCBxcCIgb24gcmRtYSBpbnRlcmZhY2UuDQo+ID4+Pg0KPiA+Pj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gPj4+IFsgIDMwMi41Njk3OTRdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAzNA0KPiA+Pj4gLi4NCj4gPj4+IFsgIDMwMi41NzAz
NzhdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjcyMC8wTTFHQ1IsIEJJT1Mg
MS4yLjYgMDUvMTAvMjAxMg0KPiA+Pj4gWyAgMzAyLjU3MDUwMF0gUklQOiAwMDEwOnFlZF9yZG1h
X3F1ZXJ5X3FwKzB4MzMvMHgxYTAgW3FlZF0NCj4gPj4+IFsgIDMwMi41NzA4NjFdIFJTUDogMDAx
ODpmZmZmYmE1NjBhMDhmNTgwIEVGTEFHUzogMDAwMTAyMDYNCj4gPj4+IFsgIDMwMi41NzA5Nzld
IFJBWDogMDAwMDAwMDIwMDAwMDAwMCBSQlg6IGZmZmZiYTU2MGEwOGY1YjggUkNYOiAwMDAwMDAw
MDAwMDAwMDAwDQo+ID4+PiBbICAzMDIuNTcxMTAwXSBSRFg6IGZmZmZiYTU2MGEwOGY1YjggUlNJ
OiAwMDAwMDAwMDAwMDAwMDAwIFJESTogZmZmZjk4MDdlZTQ1ODA5MA0KPiA+Pj4gWyAgMzAyLjU3
MTIyMV0gUkJQOiBmZmZmYmE1NjBhMDhmNWEwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZm
ZmY5ODA3ODkwZTcwNDgNCj4gPj4+IFsgIDMwMi41NzEzNDJdIFIxMDogZmZmZmJhNTYwYTA4ZjY1
OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4+PiBbICAz
MDIuNTcxNDYyXSBSMTM6IGZmZmY5ODA3ZWU0NTgwOTAgUjE0OiBmZmZmOTgwN2YwYWZiMDAwIFIx
NTogZmZmZmJhNTYwYTA4ZjdlYw0KPiA+Pj4gWyAgMzAyLjU3MTU4M10gRlM6ICAwMDAwN2ZiYmY4
YmZlNzQwKDAwMDApIEdTOmZmZmY5ODBhYWZhMDAwMDAoMDAwMCkNCj4gPj4ga25sR1M6MDAwMDAw
MDAwMDAwMDAwMA0KPiA+Pj4gWyAgMzAyLjU3MTcyOV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+Pj4gWyAgMzAyLjU3MTg0N10gQ1IyOiAwMDAw
MDAwMDAwMDAwMDM0IENSMzogMDAwMDAwMDE3MjBiYTAwMSBDUjQ6IDAwMDAwMDAwMDAwNjA2ZjAN
Cj4gPj4+IFsgIDMwMi41NzE5NjhdIENhbGwgVHJhY2U6DQo+ID4+PiBbICAzMDIuNTcyMDgzXSAg
cWVkcl9xdWVyeV9xcCsweDgyLzB4MzYwIFtxZWRyXQ0KPiA+Pj4gWyAgMzAyLjU3MjIxMV0gIGli
X3F1ZXJ5X3FwKzB4MzQvMHg0MCBbaWJfY29yZV0NCj4gPj4+IFsgIDMwMi41NzIzNjFdICA/IGli
X3F1ZXJ5X3FwKzB4MzQvMHg0MCBbaWJfY29yZV0NCj4gPj4+IFsgIDMwMi41NzI1MDNdICBmaWxs
X3Jlc19xcF9lbnRyeV9xdWVyeS5pc3JhLjI2KzB4NDcvMHgxZDAgW2liX2NvcmVdDQo+ID4+PiBb
ICAzMDIuNTcyNjcwXSAgPyBfX25sYV9wdXQrMHgyMC8weDMwDQo+ID4+PiBbICAzMDIuNTcyNzg4
XSAgPyBubGFfcHV0KzB4MzMvMHg0MA0KPiA+Pj4gWyAgMzAyLjU3MjkwMV0gIGZpbGxfcmVzX3Fw
X2VudHJ5KzB4ZTMvMHgxMjAgW2liX2NvcmVdDQo+ID4+PiBbICAzMDIuNTczMDU4XSAgcmVzX2dl
dF9jb21tb25fZHVtcGl0KzB4M2Y4LzB4NWQwIFtpYl9jb3JlXQ0KPiA+Pj4gWyAgMzAyLjU3MzIx
M10gID8gZmlsbF9yZXNfY21faWRfZW50cnkrMHgxZjAvMHgxZjAgW2liX2NvcmVdDQo+ID4+PiBb
ICAzMDIuNTczMzc3XSAgbmxkZXZfcmVzX2dldF9xcF9kdW1waXQrMHgxYS8weDIwIFtpYl9jb3Jl
XQ0KPiA+Pj4gWyAgMzAyLjU3MzUyOV0gIG5ldGxpbmtfZHVtcCsweDE1Ni8weDJmMA0KPiA+Pj4g
WyAgMzAyLjU3MzY0OF0gIF9fbmV0bGlua19kdW1wX3N0YXJ0KzB4MWFiLzB4MjYwDQo+ID4+PiBb
ICAzMDIuNTczNzY1XSAgcmRtYV9ubF9yY3YrMHgxZGUvMHgzMzAgW2liX2NvcmVdDQo+ID4+PiBb
ICAzMDIuNTczOTE4XSAgPyBubGRldl9yZXNfZ2V0X2NtX2lkX2R1bXBpdCsweDIwLzB4MjAgW2li
X2NvcmVdDQo+ID4+PiBbICAzMDIuNTc0MDc0XSAgbmV0bGlua191bmljYXN0KzB4MWI4LzB4Mjcw
DQo+ID4+PiBbICAzMDIuNTc0MTkxXSAgbmV0bGlua19zZW5kbXNnKzB4MzNlLzB4NDcwDQo+ID4+
PiBbICAzMDIuNTc0MzA3XSAgc29ja19zZW5kbXNnKzB4NjMvMHg3MA0KPiA+Pj4gWyAgMzAyLjU3
NDQyMV0gIF9fc3lzX3NlbmR0bysweDEzZi8weDE4MA0KPiA+Pj4gWyAgMzAyLjU3NDUzNl0gID8g
c2V0dXBfc2dsLmlzcmEuMTIrMHg3MC8weGMwDQo+ID4+PiBbICAzMDIuNTc0NjU1XSAgX194NjRf
c3lzX3NlbmR0bysweDI4LzB4MzANCj4gPj4+IFsgIDMwMi41NzQ3NjldICBkb19zeXNjYWxsXzY0
KzB4M2EvMHhiMA0KPiA+Pj4gWyAgMzAyLjU3NDg4NF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDQ0LzB4YWUNCj4gPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+Pg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogQXJpZWwgRWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4NCj4gPj4+IFNp
Z25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxpbkBtYXJ2ZWxsLmNvbT4NCj4gPj4+IFNpZ25l
ZC1vZmYtYnk6IEFsb2sgUHJhc2FkIDxwYWxva0BtYXJ2ZWxsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+
Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcvcWVkci92ZXJicy5jIHwgMTcgKysrKysrKysrLS0t
LS0tLS0NCj4gPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L3Fl
ZHIvdmVyYnMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xZWRyL3ZlcmJzLmMNCj4gPj4+IGlu
ZGV4IGZkYzQ3ZWY3ZDg2MS4uNzk2MDNlM2ZlMmRiIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL2h3L3FlZHIvdmVyYnMuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL2h3L3FlZHIvdmVyYnMuYw0KPiA+Pj4gQEAgLTI3NTgsMTUgKzI3NTgsMTggQEAgaW50IHFl
ZHJfcXVlcnlfcXAoc3RydWN0IGliX3FwICppYnFwLA0KPiA+Pj4gICAJaW50IHJjID0gMDsNCj4g
Pj4+DQo+ID4+PiAgIAltZW1zZXQoJnBhcmFtcywgMCwgc2l6ZW9mKHBhcmFtcykpOw0KPiA+Pj4g
LQ0KPiA+Pj4gLQlyYyA9IGRldi0+b3BzLT5yZG1hX3F1ZXJ5X3FwKGRldi0+cmRtYV9jdHgsIHFw
LT5xZWRfcXAsICZwYXJhbXMpOw0KPiA+Pj4gLQlpZiAocmMpDQo+ID4+PiAtCQlnb3RvIGVycjsN
Cj4gPj4+IC0NCj4gPj4NCj4gPj4gQXQgdGhhdCBwb2ludCwgUVAgc2hvdWxkIGJlIHZhbGlkLg0K
PiA+Pg0KPiA+Pj4gICAJbWVtc2V0KHFwX2F0dHIsIDAsIHNpemVvZigqcXBfYXR0cikpOw0KPiA+
Pj4gICAJbWVtc2V0KHFwX2luaXRfYXR0ciwgMCwgc2l6ZW9mKCpxcF9pbml0X2F0dHIpKTsNCj4g
Pj4+DQo+ID4+PiAtCXFwX2F0dHItPnFwX3N0YXRlID0gcWVkcl9nZXRfaWJxcF9zdGF0ZShwYXJh
bXMuc3RhdGUpOw0KPiA+Pj4gKwlpZiAocXAtPnFlZF9xcCkNCj4gPj4+ICsJCXJjID0gZGV2LT5v
cHMtPnJkbWFfcXVlcnlfcXAoZGV2LT5yZG1hX2N0eCwNCj4gPj4+ICsJCQkJCSAgICAgcXAtPnFl
ZF9xcCwgJnBhcmFtcyk7DQo+ID4+PiArDQo+ID4+PiArCWlmIChxcC0+cXBfdHlwZSA9PSBJQl9R
UFRfR1NJKQ0KPiA+Pj4gKwkJcXBfYXR0ci0+cXBfc3RhdGUgPSBRRURfUk9DRV9RUF9TVEFURV9S
VFM7DQo+ID4+PiArCWVsc2UNCj4gPj4+ICsJCXFwX2F0dHItPnFwX3N0YXRlID0gcWVkcl9nZXRf
aWJxcF9zdGF0ZShwYXJhbXMuc3RhdGUpOw0KPiA+Pj4gKw0KPiA+Pj4gICAJcXBfYXR0ci0+Y3Vy
X3FwX3N0YXRlID0gcWVkcl9nZXRfaWJxcF9zdGF0ZShwYXJhbXMuc3RhdGUpOw0KPiA+Pj4gICAJ
cXBfYXR0ci0+cGF0aF9tdHUgPSBpYl9tdHVfaW50X3RvX2VudW0ocGFyYW1zLm10dSk7DQo+ID4+
PiAgIAlxcF9hdHRyLT5wYXRoX21pZ19zdGF0ZSA9IElCX01JR19NSUdSQVRFRDsNCj4gPj4+IEBA
IC0yODEwLDggKzI4MTMsNiBAQCBpbnQgcWVkcl9xdWVyeV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAs
DQo+ID4+Pg0KPiA+Pj4gICAJRFBfREVCVUcoZGV2LCBRRURSX01TR19RUCwgIlFFRFJfUVVFUllf
UVA6IG1heF9pbmxpbmVfZGF0YT0lZFxuIiwNCj4gPj4+ICAgCQkgcXBfYXR0ci0+Y2FwLm1heF9p
bmxpbmVfZGF0YSk7DQo+ID4+PiAtDQo+ID4+PiAtZXJyOg0KPiA+Pj4gICAJcmV0dXJuIHJjOw0K
PiA+Pj4gICB9DQo+ID4+Pg0KPiA+Pj4gLS0NCj4gPj4+IDIuMTcuMQ0KPiA+Pj4NCj4gPg0KDQo=
