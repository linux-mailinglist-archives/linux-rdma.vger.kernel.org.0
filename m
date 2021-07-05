Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26AA3BB8A8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhGEISo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 04:18:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6154 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230000AbhGEISo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 04:18:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1658G4AW023045;
        Mon, 5 Jul 2021 08:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TepcPOwYC4dSW/mpXoHYfs8nTxVxsIPiDDaXLFYrzCs=;
 b=K93DGO8PPjMlLsYtBLW2w30uMdY1tg21xvSX20JIGUGlhg09GRPXTHPiiP1XhMVXR5ZY
 KRIqzGrVfGwqS+KKW6OSXzWMZLU/NuTbrHyuGvLnp2TPjZnlRxvI0LYl+Ijh02mrQqOU
 QEDI6R6477L9iMLycBXUPszfiYNKIO9/kIYYW1Ls9wMlxazQzaEhlfApvG/liMpFDKMv
 Zw6q9iXWs2djMwJ/z2hdgdkjQiUzIrmJm4E9y+xelfHbI+VillPDeyqiuXWo1okXgvOY
 +jThir5NXQE8VnVC1eKN1EV1hX+oJ6BAsDC3vPpWFgrTw63P0x0tE/mAnP2hzx+aTMVU dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeg1j01y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 08:16:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1658AP7M165499;
        Mon, 5 Jul 2021 08:16:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 39k1nsrmeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 08:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2bi0kVrPSaYRyxqFB/xY9/2x3dePw3iPgjLlOEBcv9f3zHQb8VksIaeNRSVB/wEoQLkrRYwjiEV00x8jU8T0hbdGzr3ePfamudrh2GHa40wej727WPKs3+lhtrG3titKLFVj0cy25hs56uAGNy7XYcIGg2/Uqr/N5/H8ZSpNX4f3F5MEvuDPwyPHfs2uzDLNqQt8rsmrYCc+8euwHUqlutj/ES+9mYe7Jamuj6srCpcaaG41fMxOU42X4gYWwTWwX6RLjbKg5sLYcNM+aDNBDNTKI4DNZP9DzFLFEgZgR84I7DW34kN1TlxPSR5mjug2DEMqhs6xSc9XU9/uCiZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TepcPOwYC4dSW/mpXoHYfs8nTxVxsIPiDDaXLFYrzCs=;
 b=lRJenpr6yMb+N7ZJo9rGL8Ze/rkQoCaBjglKNuQ6jVmimWE+DSBalcZEdsDmFMEVYIwZmVORZvLf8hYM3kC/Ud1wVuCXLF+KrEuGRDHGgx6+7/xBTPqOMHmStANiAfaEE0jt42xjWSvQP+s2JVtT7HWwTHsOr/sPsd1foKb7KxlKN2YVfrtsGgpLnZk0s2ws8T0A1X/RK0/fFFCRjQtk5F1BimpTu8TcexqIGfQnK7jCLrYbEfJTDc6BiLvkHO/JMoHgL2I6xJ0QsfGCeQcI5qHEUw8gG9OLLhjhAqk/I4n9fjKW48GpCgWVnaTLqyF4vvoJ++63MjzZCAGrJPMjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TepcPOwYC4dSW/mpXoHYfs8nTxVxsIPiDDaXLFYrzCs=;
 b=HV/Di9kwx/RWdmCm8jVVxh3Ec8HrMOIoqcLFy32gSuhoQoKsfvkRStLomCrhVpsoBlolUexUdtuorM/O1W67ufGsYJvWP0UR0KYDJ6I0azNLoC+/ACmdEqvesGwhIl8RQobW1uqLMGLchx4LuFLAkgCyDQNpl7kNjMK7SKhSHuA=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB3419.namprd10.prod.outlook.com (2603:10b6:5:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Mon, 5 Jul
 2021 08:16:01 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 08:16:01 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Thread-Index: AQHXcSU4qkk6csRmHEOkD1wzCNoukKszvTqAgABMdIA=
Date:   Mon, 5 Jul 2021 08:16:01 +0000
Message-ID: <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com>
References: <20210704223506.12795-1-rpearsonhpe@gmail.com>
 <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
In-Reply-To: <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4351e678-9382-4199-a333-08d93f8d2034
x-ms-traffictypediagnostic: DM6PR10MB3419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB341996764F1B68BA7424D84BFD1C9@DM6PR10MB3419.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hytezv5fn2aFz1lZLYKzVe0xG6u6VKEt6PKB3DLKsJ80e3aRIP3uyBkznR4i2Fw3XPb9OZ4xd5sY/07Y+xrTACK/Bq0swDTILS3lTevJmXIZ0jpvB7UV+xEKVGajYKcj37vwW5lkKKlRQdVEMaZaqWM97sAomMVKJ7kGbCi2cI3xL18Q3qCoLP5ZlOKWDoiF2w0N073u9m6cbR3XbWajmEcDzOKD3CTvIfX9jKeZdoMNnnuPT2KVD7afz66UJXoaE/37cbNQZwlFh13LeO7HuJ2yCCd9JVVvU5d4Bb88Ec1+LE58VSIxDd/ViLL4fQAlmeaaYSoYIrtMCeG3GXU9BcxzBSNppT7+M0KhrI+rOawQDufb9cQpIdCchDn5DmmrnR+WRsZaVme6S/tDAxxXriV6QV83P7wMOG9Ncwc1KRB8Id0CjEu8sRe+NrL/7gyh7zPpG2frCs1LxjMXsWshRGkapY59svL9gczO9m8cJZW0TH9RdIJamlT7RweT0V8ikd/WpJgoCXNRw3m/rWwxDdmCRaj2H4lJBUfhTIK75Xq69Ln3fbnVKH7pxIMp/I7L29/BkWBByRjElIULiQHBUPFTgb/i2KxOAqh3srnSFAUUYiOUe3PGpF6xw57smfACWhx6SO2ozvUpN/6xK6ffJBojr0lO6SvQF3m7265DTDxyrPfWcx4BLkgzO7rTOOgZqlX/HQ2WSM8VA/tPjC6pUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(83380400001)(2906002)(66574015)(33656002)(316002)(36756003)(66946007)(66446008)(64756008)(66556008)(107886003)(53546011)(26005)(8676002)(8936002)(76116006)(91956017)(478600001)(71200400001)(6486002)(54906003)(66476007)(122000001)(38100700002)(186003)(6506007)(6512007)(6916009)(4326008)(86362001)(2616005)(5660300002)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjZaKzlYR0s1YUQyRkxrVGNKbUpmWDNMMHBkSjlSVEN1bUtXVis1dTZuejNo?=
 =?utf-8?B?Wm56UjFGQ1FFdGwzbkZlSzFtM1JRdkdWTlYza1RnaGtjK0prNkduOWtXYUls?=
 =?utf-8?B?emt1TklJWGZsVnRKQ01kWndTRTdaRFRnZGJLTDNSNW5qc1JzWGhKRllhWEJO?=
 =?utf-8?B?Z1dYQUhJV1J1K3NoSkVnSDZMeW90cEFOaGVSckl2K3FPdkk2Ujk2MHNFelRR?=
 =?utf-8?B?aGw4WG01em5jandOUlArdFFYNHBqNnVQREdta21rZmZHeHlLR05zQzhqeVlW?=
 =?utf-8?B?ZkJzcXpPN0ovWWg0M3VYd0F0dVdpZ2ZzeWRBdHk1cXVYdVgyeDFiVHdwY09a?=
 =?utf-8?B?Z25nRnFhMWtRVHh6S1lrRUFKbHJVaUtnNEI3U0tlbW9pbkNEUysxQndqYVJL?=
 =?utf-8?B?UFFzeWVWNkNwRE1SNi8wWERoOGJCejBpRGp4OG83V0RZVUNUdzU5VWJyVTRF?=
 =?utf-8?B?MGMxcU9pRVhOQ3pGallsRUcrU1VBMU5sOUlDT2R2c1c5ekowWUZtRXRsNlZ1?=
 =?utf-8?B?NEZsS2drTVhUOFJ4S3BORHQxNVo5Z3hReDJqc2JRZXZ2RmFrb2tnQkVMUWtx?=
 =?utf-8?B?T2ZUUUlLcUJJMkJqT3BFdXhOL2hVVk1uSkNrRjB5NjZOQzdob0l2UXhGTWZl?=
 =?utf-8?B?OERqQnhHRXRGZWVOeU9jYlVzWlhVUUhYaHNObmFpZ3lidVZyL29ndWRuaEc2?=
 =?utf-8?B?ZVBqUEZ0Z29NcFJQSzErUVcrYkM4NVFUbUt3QmJnbUF4ZFdVSlRhRnJzNVFt?=
 =?utf-8?B?dFd6MHpCVW5XbnFjVUpGY2FXd040OWQyT2xvemVSSHlneTZjTzlJSjl6Yndw?=
 =?utf-8?B?b0tFUkNjN0lhV08wcXdUb1RzV0t1SVRHblJOdU85QUhzQjR3VkNadXE0VUxW?=
 =?utf-8?B?dkZVTStXb1I2TFZ2K0c3ZGxBR1dZRWRSNk1NZzhFWTRWRGgwaWJIckhJZVFG?=
 =?utf-8?B?Z0pTZ2Yzdmx5aVBQam5VODZuVFlqMmg1MmQrL1psc2JlRFZ2WUxqZjhzSFV1?=
 =?utf-8?B?OExMdURROW02VlhENFRTNG1JSUdJOUh2czlaVEpXcVZtK0lHSE5NYjhGcDEw?=
 =?utf-8?B?YXg0c2tPRXhzNTVPeXNPZEEyOW1jSHhUNGo5K21CWXlud3lzcXVPZG9NVC9I?=
 =?utf-8?B?STlIUGE3SXIwU3pGaEwxV0hFQWc3MzhZVUxWbHQ2Rk5kd2hCWUtlVUthbzVQ?=
 =?utf-8?B?c1NnN2NiK203bWxUZ2JaNW9NRjZrRHdCaU9jZVlvczRBdit4VGJKamxRMUM3?=
 =?utf-8?B?TWNqeXplcG14cEpaWndQTWdJeHpvVTNGanJBaExVL2daNkdhRjNlNEJDYU5T?=
 =?utf-8?B?NW9jVVpzTVJ3a1RUSlMwem1ZRXRub1FSRDZvTmtIMGo5NHM4ZytSUzhrMy9z?=
 =?utf-8?B?Q2pXeHRqM1FEV1doSzBzRUdVQmJ1YkdkeVV0UVptdzloaXkzVlR2RlpNc29z?=
 =?utf-8?B?UzRMRm90WDE5YThERDgzbFdtczVoK0FOS1JWLzBTR2NrZFNSQXEydmJYdGRk?=
 =?utf-8?B?b29sWmpubW95bk5JR1I2QWhlYk1hamlrNGtDWmlTUElyeXU0d0Y1emZjOUpL?=
 =?utf-8?B?WkhYNWFKS2ZvTkN5VTFzTWkvSGtpdWIycE1JcXRqNWpTajByQk1BcmlEWkg0?=
 =?utf-8?B?SnhhN3VpU250UUF5NGhXZEN2MXB6WENrSnZLb1ZSUXlJWDJzelg1Y281ek9Y?=
 =?utf-8?B?aTJENVlYakc1VVBUSTNMandQK0g3ZWw4RHdmd09XdnY2RC9YRHdzTWNXSFFy?=
 =?utf-8?Q?IMu7SAy+l6tOxLcWnpFL7OXaWJ8IDPwaKNwRkaU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAD71E370DB1C469A14DF6B26483885@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351e678-9382-4199-a333-08d93f8d2034
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 08:16:01.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVJVIXZqEJKvFNjg4ZK1Kq9MgI04dyedeB4YMWbI43LVgpPWRdilkLpY9f3Bdrj6riGHHnKjVSAnxQ9TXBhYFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3419
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050043
X-Proofpoint-GUID: Pek089W4o3AqlEMbEVfkJ1cxvdHP_xoL
X-Proofpoint-ORIG-GUID: Pek089W4o3AqlEMbEVfkJ1cxvdHP_xoL
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNSBKdWwgMjAyMSwgYXQgMDU6NDIsIFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21h
aWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgSnVsIDUsIDIwMjEgYXQgNjozNyBBTSBCb2Ig
UGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPiB3cm90ZToNCj4+IA0KPj4gSW4gcnhlX21y
X2luaXRfdXNlcigpIGluIHJ4ZV9tci5jIGF0IHRoZSB0aGlyZCBlcnJvciB0aGUgZHJpdmVyIGZh
aWxzIHRvDQo+PiBmcmVlIHRoZSBtZW1vcnkgYXQgbXItPm1hcC4gVGhpcyBwYXRjaCBhZGRzIGNv
ZGUgdG8gZG8gdGhhdC4NCj4+IFRoaXMgZXJyb3Igb25seSBvY2N1cnMgaWYgcGFnZV9hZGRyZXNz
KCkgZmFpbHMgdG8gcmV0dXJuIGEgbm9uIHplcm8gYWRkcmVzcw0KPj4gd2hpY2ggc2hvdWxkIG5l
dmVyIGhhcHBlbiBmb3IgNjQgYml0IGFyY2hpdGVjdHVyZXMuDQo+IA0KPiBJZiB0aGlzIHdpbGwg
bmV2ZXIgaGFwcGVuIGZvciA2NCBiaXQgYXJjaGl0ZWN0dXJlcywgaXMgaXQgcG9zc2libGUgdG8N
Cj4gZXhjbHVkZSA2NCBiaXQgYXJjaGl0ZWN0dXJlIHdpdGggc29tZSBNQUNST3Mgb3Igb3RoZXJz
Pw0KPiANCj4gVGhhbmtzLA0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4+IA0KPj4gRml4ZXM6IDg3
MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQ0KPj4gUmVwb3J0ZWQgYnk6IEhhYWtvbiBC
dWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVh
cnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9tci5jIHwgNDEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+
PiAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+PiAN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPj4gaW5kZXggNmFhYmNiNGRlMjM1Li5m
NDliYWZmOWNhM2QgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9tci5jDQo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+PiBA
QCAtMTA2LDIwICsxMDYsMjEgQEAgdm9pZCByeGVfbXJfaW5pdF9kbWEoc3RydWN0IHJ4ZV9wZCAq
cGQsIGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1yKQ0KPj4gaW50IHJ4ZV9tcl9pbml0X3Vz
ZXIoc3RydWN0IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+
PiAgICAgICAgICAgICAgICAgICAgIGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1yKQ0KPj4g
ew0KPj4gLSAgICAgICBzdHJ1Y3QgcnhlX21hcCAgICAgICAgICAqKm1hcDsNCj4+IC0gICAgICAg
c3RydWN0IHJ4ZV9waHlzX2J1ZiAgICAgKmJ1ZiA9IE5VTEw7DQo+PiAtICAgICAgIHN0cnVjdCBp
Yl91bWVtICAgICAgICAgICp1bWVtOw0KPj4gLSAgICAgICBzdHJ1Y3Qgc2dfcGFnZV9pdGVyICAg
ICBzZ19pdGVyOw0KPj4gLSAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBudW1fYnVmOw0K
Pj4gLSAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAqdmFkZHI7DQo+PiArICAgICAgIHN0
cnVjdCByeGVfbWFwICoqbWFwOw0KPj4gKyAgICAgICBzdHJ1Y3QgcnhlX3BoeXNfYnVmICpidWYg
PSBOVUxMOw0KPj4gKyAgICAgICBzdHJ1Y3QgaWJfdW1lbSAqdW1lbTsNCj4+ICsgICAgICAgc3Ry
dWN0IHNnX3BhZ2VfaXRlciBzZ19pdGVyOw0KPj4gKyAgICAgICBpbnQgbnVtX2J1ZjsNCj4+ICsg
ICAgICAgdm9pZCAqdmFkZHI7DQoNClRoaXMgd2hpdGUtc3BhY2Ugc3RyaXBwaW5nIG11c3QgYmUg
YW5vdGhlciBpc3N1ZSwgbm90IHJlbGF0ZWQgdG8gdGhlIG1lbWxlYWs/DQoNCj4+ICAgICAgICBp
bnQgZXJyOw0KPj4gKyAgICAgICBpbnQgaTsNCj4+IA0KPj4gICAgICAgIHVtZW0gPSBpYl91bWVt
X2dldChwZC0+aWJwZC5kZXZpY2UsIHN0YXJ0LCBsZW5ndGgsIGFjY2Vzcyk7DQo+PiAgICAgICAg
aWYgKElTX0VSUih1bWVtKSkgew0KPj4gLSAgICAgICAgICAgICAgIHByX3dhcm4oImVyciAlZCBm
cm9tIHJ4ZV91bWVtX2dldFxuIiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIChpbnQpUFRS
X0VSUih1bWVtKSk7DQo+PiArICAgICAgICAgICAgICAgcHJfd2FybigiJXM6IFVuYWJsZSB0byBw
aW4gbWVtb3J5IHJlZ2lvbiBlcnIgPSAlZFxuIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IF9fZnVuY19fLCAoaW50KVBUUl9FUlIodW1lbSkpOw0KPj4gICAgICAgICAgICAgICAgZXJyID0g
UFRSX0VSUih1bWVtKTsNCj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjE7DQo+PiArICAgICAg
ICAgICAgICAgZ290byBlcnJfb3V0Ow0KPj4gICAgICAgIH0NCj4+IA0KPj4gICAgICAgIG1yLT51
bWVtID0gdW1lbTsNCj4+IEBAIC0xMjksMTUgKzEzMCwxNSBAQCBpbnQgcnhlX21yX2luaXRfdXNl
cihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+
IA0KPj4gICAgICAgIGVyciA9IHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1Zik7DQo+PiAgICAgICAg
aWYgKGVycikgew0KPj4gLSAgICAgICAgICAgICAgIHByX3dhcm4oImVyciAlZCBmcm9tIHJ4ZV9t
cl9hbGxvY1xuIiwgZXJyKTsNCj4+IC0gICAgICAgICAgICAgICBpYl91bWVtX3JlbGVhc2UodW1l
bSk7DQo+PiAtICAgICAgICAgICAgICAgZ290byBlcnIxOw0KPj4gKyAgICAgICAgICAgICAgIHBy
X3dhcm4oIiVzOiBVbmFibGUgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciBtYXBcbiIsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4+ICsgICAgICAgICAgICAg
ICBnb3RvIGVycl9yZWxlYXNlX3VtZW07DQo+PiAgICAgICAgfQ0KPj4gDQo+PiAgICAgICAgbXIt
PnBhZ2Vfc2hpZnQgPSBQQUdFX1NISUZUOw0KPj4gICAgICAgIG1yLT5wYWdlX21hc2sgPSBQQUdF
X1NJWkUgLSAxOw0KPj4gDQo+PiAtICAgICAgIG51bV9idWYgICAgICAgICAgICAgICAgID0gMDsN
Cj4+ICsgICAgICAgbnVtX2J1ZiA9IDA7DQoNCldoaXRlLXNwYWNlIGNoYW5nZS4NCg0KT3RoZXJ3
aXNlOg0KDQpSZXZpZXdlZC1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNv
bT4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCj4+ICAgICAgICBtYXAgPSBtci0+bWFwOw0KPj4g
ICAgICAgIGlmIChsZW5ndGggPiAwKSB7DQo+PiAgICAgICAgICAgICAgICBidWYgPSBtYXBbMF0t
PmJ1ZjsNCj4+IEBAIC0xNTEsMTAgKzE1MiwxMCBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1
Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+IA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICB2YWRkciA9IHBhZ2VfYWRkcmVzcyhzZ19wYWdlX2l0ZXJf
cGFnZSgmc2dfaXRlcikpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXZhZGRyKSB7
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIm51bGwgdmFkZHJc
biIpOw0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpYl91bWVtX3JlbGVhc2Uo
dW1lbSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIiVzOiBV
bmFibGUgdG8gZ2V0IHZpcnR1YWwgYWRkcmVzc1xuIiwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOw0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIGVycjE7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyX2NsZWFudXBfbWFwOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiAN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgYnVmLT5hZGRyID0gKHVpbnRwdHJfdCl2YWRkcjsN
Cj4+IEBAIC0xNzcsNyArMTc4LDEzIEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVf
cGQgKnBkLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPj4gDQo+PiAgICAgICAg
cmV0dXJuIDA7DQo+PiANCj4+IC1lcnIxOg0KPj4gK2Vycl9jbGVhbnVwX21hcDoNCj4+ICsgICAg
ICAgZm9yIChpID0gMDsgaSA8IG1yLT5udW1fbWFwOyBpKyspDQo+PiArICAgICAgICAgICAgICAg
a2ZyZWUobXItPm1hcFtpXSk7DQo+PiArICAgICAgIGtmcmVlKG1yLT5tYXApOw0KPj4gK2Vycl9y
ZWxlYXNlX3VtZW06DQo+PiArICAgICAgIGliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4+ICtlcnJf
b3V0Og0KPj4gICAgICAgIHJldHVybiBlcnI7DQo+PiB9DQo+PiANCj4+IC0tDQo+PiAyLjMwLjIN
Cj4+IA0KDQo=
