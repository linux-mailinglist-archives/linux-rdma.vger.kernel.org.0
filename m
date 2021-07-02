Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657423BA0CB
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jul 2021 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhGBNB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jul 2021 09:01:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13672 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhGBNB1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jul 2021 09:01:27 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162CvOxb029629;
        Fri, 2 Jul 2021 12:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=i+FRkZT4VFXt/1RdHz/gKm6t2okRXQSJRsskc/b8NnI=;
 b=tkVxtNCVFPqmHtm7cPBztjH9WfGHpBMyq2InpVgqsgqoajnMd4XRrE3H+AREbDNRJ7dU
 PfRgdm+lSJq2m0HEakgz0JgLuMSwbw0Y/v00bBxjAK7SkRHJ5M8LwVUFaLCyTkBcwrEe
 gR+UuiBGnVfAWTMlQSo8QLhD2k1SO2LHNXuZO6XCLL3GNzyR3xmEndeiyo1hhtR8vhjy
 lbQ7OdXDbgRN+7L2wJlG7WEIFl/hOTQTBEE+43dPen71wA+OfeEeWpRgUZ3V282cXiln
 AZHt4Nb0i7zyj+3DNgaXGGl2IcKA2cANVrJZUOpHkl4pk9KRAxlNB73EeVeDxglwOLC1 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39htf6rv6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:58:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162CuE8a048033;
        Fri, 2 Jul 2021 12:58:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 39dt9nt6a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS+JoAekfzyOsGpbfTK1v/OBI3RxLNQbRR79w8gydWVbnZ8m0uc13JteDMOGWCMvwn7fffF1mU74MtlZP5VsfPWXAM9bh+SH9/B1Hri6ScfolB5HaRHd+/ZsbKyewXDMcB6cGIofD3Do0yuDDZTUR6x770JV8uFHAagVCbkUfErU/8VDZU90wHIaiQZk+IhQd/ULI0F67sMVxu3KyomImI4vz5FUtW20W1IT6//FIlw2imfPB0NdkRNSqhG+NsmD2+duyy1EXpTXY5CE+QxuIzNDRyBQBSDwFkwX4+i1U01v1WCG5qw7uRxnwEM6eO0Nq35w8dXAHSpLAwDdNe1exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FRkZT4VFXt/1RdHz/gKm6t2okRXQSJRsskc/b8NnI=;
 b=h5T25LbPCVD2iD3jXTwbxVoS9P3wTOMAnFgInOWwa1KLs/avLahCE+sqokzKJhON6vxmRNDfQtluAZNohx5kzCvT9dZ8eY0OLWEIiPYLyGNlvsCZ0wlhKRSS1Rdfxf0KKnRJizaDLzXsb4lWaZuisrb9lMg6/TMxfYniMXUL7LU7s2nabwJvD/wU8s16hrAgqJFtP26sezhyA8uWo8gdNqvOcK0NqV3RLe0N/sPxjmgPjkN6YIbpOkOf2ZRbBGiio/0tUwCdqoVAScYSKQSRKL06ER/flk0D/EqsTXhXrv9GBMwaRULcMzniZkjWk8IBJiuzWW6LDC7aZyFSGXCU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+FRkZT4VFXt/1RdHz/gKm6t2okRXQSJRsskc/b8NnI=;
 b=njl75+PcjRbk7uVZZhiby3IC9V/sU/o77iQZKJ4BYyWwwlj4i/6Cj/pk0UeiltvFrlUnwVTNHUKVoNVENfNJreOLTyrhejsnx2WespnegaGp37WtH1RKC+i2H2qmqzZccSfBwC4nVrA4pxcLpUt7N0TaHWZTrCQs2zoK5aIhFCA=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR1001MB2380.namprd10.prod.outlook.com (2603:10b6:4:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Fri, 2 Jul
 2021 12:58:40 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%5]) with mapi id 15.20.4287.025; Fri, 2 Jul 2021
 12:58:40 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     "ice_yangxiao@163.com" <ice_yangxiao@163.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Thread-Topic: [PATCH] RDMA/rxe: Remove the repeated 'mr->umem = umem'
Thread-Index: AQHXbz4TfqeorHZAzkuXSPDyyuxW36svpXiA
Date:   Fri, 2 Jul 2021 12:58:40 +0000
Message-ID: <98F0E5B6-12A4-4303-9060-6D8232DF2694@oracle.com>
References: <20210702123024.37025-1-ice_yangxiao@163.com>
In-Reply-To: <20210702123024.37025-1-ice_yangxiao@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f70673fb-80ae-4570-94f4-08d93d591d8c
x-ms-traffictypediagnostic: DM5PR1001MB2380:
x-microsoft-antispam-prvs: <DM5PR1001MB23802FDD7E8F3121F58367F2FD1F9@DM5PR1001MB2380.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfztClmvqmEyoeL5zq60ug/Ro0RhsEroK5q0SBQdwSJ+He3mO4nDjRlvz0m0LFp0pEwaM9XVG53cLR6nyipmmJiWty2q50aTb1+sC0vHAFmrfKcjofzx6c94J72vhpbeVhw7jbzHvQRphLt0fvkBVkTbqErQyTeWx23eiea6tWhktZNolzEzshOJ4EUDEMA9AcxX/iTwrd7x0bMMRhfuvHXoJ4Buw8UlJB52t5ezNEnLod3X1MbQ/KvDOCSoF9T93gMpy+s93idJFYg9+DoBgUoCefUnarj58S+TEhc498fVvk1bF4m6AHN/LtufTkU6FOQtdkeiVjblWlj4XqcGgeVE7w/wFxFCljFLXg5rpCLh46jpyzCIB3UFktpGv2yq+/F8tyWpCOuJokhYJ/ReFvi+4EpW0GS6/yrjL3okaft2lLQX5rPcEvSYW/GyQ4jt0tl2RmvE6D61Xu6oScRr8KQGOi+mKZCo4a/xuaTNE4Pc6uS4+j52h95Yvhy/Dq+cUNSUrJe5Y0m2Hmk4V82hqUaWs6vGCByOB7a6yRygZKKk8MSIvJjkwn1JMSOSbr02N2xaAwjvnpd+DLJLWAy/Md3tYwXOTL5M7dgHzxAy4CLgZwe3qlYVzc18+U2dQ3pnd3VdqRxEQGykokAVXLB6B+xdz4FyCadBFEr9cbxIq+82/5mDm7dqvyIX4xLWOOfW6n19oW5oTWV70n0diQZvbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(478600001)(44832011)(38100700002)(54906003)(186003)(36756003)(83380400001)(2616005)(2906002)(6506007)(122000001)(53546011)(4744005)(316002)(26005)(66574015)(66446008)(6916009)(64756008)(71200400001)(91956017)(4326008)(5660300002)(76116006)(66476007)(33656002)(6486002)(66946007)(86362001)(6512007)(8676002)(8936002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0VuU2pKdmhiZDRQRk5Od05YZHFqc3ZTaytKVDRHWmhwb2NoeXo1ZVdQQ3ho?=
 =?utf-8?B?aHlPcDkxdU02RCtzUyswM0tmcjVpdkYyU2VNbU9HY2hGbGRQeGpxMDVTUjBj?=
 =?utf-8?B?enlhOFhROVpjeEVyb1BEY3JTanBxaXdpTnpJVkYrZmZDK3dLb3haNWFFVXpU?=
 =?utf-8?B?YnJway9oSWtIaHlOVXRyM05TcjVrYW41RlVXRkVYbU9tbjJlVWdxVHBpY0Z0?=
 =?utf-8?B?Smh5RzJpZS9kcEJNUWVlcGRoaENmL1BpQWJCck9JQXlsRHFJSUQyMFo4Rnhq?=
 =?utf-8?B?d3RVeEhkUGRzVlBtTERNUlFIVXFHbjg1SjdRNGt3SWVmUWVLeE11Z2wweCto?=
 =?utf-8?B?VG5NT1BkMWZqeGNONCtIZ0t5UWdHckdyenBwcUJ6UCsvcVBZZXNqYmsyRDVF?=
 =?utf-8?B?T3pHQmViRVJLLytMRlF3ZkIwUkZmZjl6aGhMZDc4dXdsWTVZSDZzUXJaZWZX?=
 =?utf-8?B?RjhDdmhyOExwbk5MTUZ6bEluUzk2NkQxUHNLMjJKU2hUUkQ4WCtabjR4N2sr?=
 =?utf-8?B?bXBCU0YwUE1TdUNzMlIreDdjYzE1K1RIcFZkMGdoUjk3bndiNzhkaXc4MUFR?=
 =?utf-8?B?elBoTjduMHU5cVBZZGlCVUNqeDcwaFprdjdlSm5ETTY5dTh6bXI2UnRjbzEv?=
 =?utf-8?B?aWNOSWE2SDJIT0YrbkxWTG5EV1VTMkROaVNQM2g3VjhKN2hVcUt3d1E0R24x?=
 =?utf-8?B?NEExVCs5Zkx4S1RTdFV3dTJrQ3MwdGpDZ3pTTDk2NjVta2xOL2ZoQXZIczRv?=
 =?utf-8?B?MERXSm5iV01Xa1Y4R1duTzdJYlBNWTgvR3hwb2tNM2IwZHp1MUhJYytiUjhD?=
 =?utf-8?B?cklBMUJkMG91d0oxY3VOWE1Yd2pYc0M2T2JncXJqbHpOUnVPeFNWanZNNnE5?=
 =?utf-8?B?TldkU00xZGhpSDQ2TW9YMUNoUjNJdXZhZnlDa1lkai9PbkZMYy90NjU1bXY4?=
 =?utf-8?B?Q1FhVmJQcW5TNGY4YkVvYXhwZmNxUmRWOUhOd3Vjd0FQaHZzcXg1aXlFa1Q5?=
 =?utf-8?B?WHJETy9tcURXVmtueEM0djZMTjIxRGFLZ1dYTzRITGdkTmtzMVo3b1Z4eUlj?=
 =?utf-8?B?ZjQrelVJWEZ2NXZ2VUlTaEIzcGtZallEMUtWb1RwRGFZVWtWTEtPRC9lQkJB?=
 =?utf-8?B?ZDRCNjN4REFzMDZjdHYrRGJMbTE4SzNLRzNzWVp4bXczdlUrY0w3L2xZYThC?=
 =?utf-8?B?K0l6bnBub0liK0dEWS9IS1RYd25hZzZ4N2tiaXJWUytZS2FuYlQwY0pWRVdj?=
 =?utf-8?B?ZjJ4VCs0dTEveGNCdTFPckpMelRUam8yT1lHVCtTZUUxY2xHbktpU1VoYm51?=
 =?utf-8?B?MXJVcDlRQW1tajFkWGhuSzBjQkwranFhUkwrUHdaODVRWVlKZjBtaEM2Zm81?=
 =?utf-8?B?NDlOclNUVWpycnAxOVg3aHFKd1FpRUNUUjAzb2tQRFd1VThnWFlHUE9ud3Uy?=
 =?utf-8?B?czA0Q201OFNiOGM0dklWQXBJclp4YjZBaHhwMTI4MVkzWkN5NVc1RlZqcWo5?=
 =?utf-8?B?Zm11THVqNHBHSmYvNWVBY3crUHYvS3F5ZCtZcCtIdWNnL3ZYeEtqZU9BM1pm?=
 =?utf-8?B?ckF1MTFNWmx1MU1jOVhCb2w0QmREUmpMdkJWQUVHa3k3UW1URExHbWF0Ni9V?=
 =?utf-8?B?KzRmV25ZL1l0SWw1anV4ZXpDeUJJcnpGVGpZNFNwVlp2VnpQSGNvVEk4VmUx?=
 =?utf-8?B?SEdlS1NjS2lRamsrSUx4ZU4wenQ1bFJFbXNlcGE0RkV2djc2UThZTloyd25G?=
 =?utf-8?B?N0NydWpDbTVFSXRvd1JwMitoVjYzdFgvMDd5N1VvQjFLRmVFWVAxUWFUYVhu?=
 =?utf-8?B?di9xU1U5WEsvS0pNdFRnUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B721590FC9FFA43B6B8BE6059A0FE98@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70673fb-80ae-4570-94f4-08d93d591d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 12:58:40.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAEf2vp4g5rjPh4mkPL3QVoFz5Frhjf6Zlv+vva7ypHnpzhaGzwMXFBT4L5eh4IuDMjtH2Op5PI9qQ3OdDwEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2380
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020073
X-Proofpoint-GUID: ncsJj33nczuUtKtLcEwYCK4R_9N24G3L
X-Proofpoint-ORIG-GUID: ncsJj33nczuUtKtLcEwYCK4R_9N24G3L
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMiBKdWwgMjAyMSwgYXQgMTQ6MzAsIGljZV95YW5neGlhb0AxNjMuY29tIHdyb3Rl
Og0KPiANCj4gRnJvbTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQoNCkxHVE0sDQoN
ClJldmlld2VkLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQoN
Ck5vdCByZWxhdGVkIHRvIHRoZSBjb21taXQsIGJ1dCB3aGlsc3QgcmV2aWV3aW5nLCBpdCBsb29r
cyB0byBtZSBhcyB0aGUgc2Vjb25kICJnb3RvIGVycjEiIGluIHJ4ZV9tcl9pbml0X3VzZXIoKSBo
YXMgYSBtZW1sZWFrIGJlY2F1c2UgbXItPm1hcCBpcyBub3QgZGVhbGxvY2F0ZWQuDQoNCg0KVGh4
cywgSMOla29uDQogDQo+IA0KPiAtLS0NCj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYyB8IDEgLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGluZGV4IDZhYWJjYjRkZTIzNS4uNDg3Y2VmYzAxNWI4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gQEAgLTEyMiw3ICsxMjIs
NiBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IHN0YXJ0LCB1
NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4gCQlnb3RvIGVycjE7DQo+IAl9DQo+IA0KPiAtCW1yLT51
bWVtID0gdW1lbTsNCj4gCW51bV9idWYgPSBpYl91bWVtX251bV9wYWdlcyh1bWVtKTsNCj4gDQo+
IAlyeGVfbXJfaW5pdChhY2Nlc3MsIG1yKTsNCj4gLS0gDQo+IDIuMjYuMg0KPiANCg0K
