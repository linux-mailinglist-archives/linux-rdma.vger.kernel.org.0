Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619763BC1F0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhGERC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 13:02:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhGERC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 13:02:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165Gtsu1008997;
        Mon, 5 Jul 2021 16:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=d95vRTSNHSoH4xxolDxqDSoNCUPmV6hLFWXWbp50EvY=;
 b=XwSCEiDfABZv6D2ulXLBA8IshHxbLbsDOJQPWFCMj6vIiue6OviA7CefMTof6MPIQ85Z
 G2iaSoEcvalAWQSvMY1Mx1aHLKXQmtja6nI4MskmfFQjbBD4mTak8KvDefTjVbasvowv
 OYxP7sHJIPTerFeXIOu9V4wWqPCPFTMVZ3IHFRIZdLkFxLcBH6fVZ8qNBP5iTq+oAt7o
 6afQAerZxUFn6r/5idM5nw/GlPy849c85xZ6UiEGZBeXY7B0Tj7g/zzN1Qy+PKwPmuPJ
 rdwknCrBqAtNb5+fC8iFWt5b/mZ18cPtu6sVw6Y9kJvK+S/4CGNMl2zczyJ0O6ujP7S1 lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mh87ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 16:59:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165GuDsY105709;
        Mon, 5 Jul 2021 16:59:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 39jfq764du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 16:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQzkQ6bIJjSCL6OULOKYvHBiR+nIfy/3iLn1FhLVRYBBh77g6omrxNKD3Idv4ij/ZBIp5sdGnY9BkibKJCYxu/FlLZ+nzuaN8N28h2VFXK7oQDf/ieUBjQIC1M3bF4dsllmpWHwPUEzgK52bgK+zWJDurlQZRnTSLEVhzUUwmvgOh3DfY/IedFUiXyi5cP4WPYJMnkEQeTDJnpTdCyvai5VTMphq7Wyazs9PpfuKVVHr/gYHe5A7qbeZ/CKlcB+wBD3vyaEK+Vxms6Wr+aY1BYZsmZAEA/HNsCAFEa+zw9+F8lz98Iu12d+gAr7+sowdSq3vRzxKLSR5OhGYUylUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d95vRTSNHSoH4xxolDxqDSoNCUPmV6hLFWXWbp50EvY=;
 b=a8pF0ShKuh/ETJRZj37EgwjAuyvBMDheKs25zVjGk98/M5R24+AVqNrCKwhG3lN8QNNNWZKbtuU4ruOcAoESgXgYje9lDTdh40AgGhQYnjs+2mg1yrWY8eaiuA2vNqcF/0rWTIPenAb9yLaWeda7Ei2xCgUPJj3JKT38zdlUV0mg25ywxvdFtkxybu/08p07fKTeEuj+yengV0nGtwUyvMk/3NiRPoNKVkZSbrfk71v4haxVYIuc1rEI9gW1eSZDAcP4VSEBlLYlzNFk1CNmuW4hzHnZXBqyZb4EKnPu1lXUDi1PxS7MvVxoBymJxV/CsgEaEggkBrqNflOgldxbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d95vRTSNHSoH4xxolDxqDSoNCUPmV6hLFWXWbp50EvY=;
 b=IrfHzebgDXhvE5KAnJxmh3IZs+NYwtdnqjmjqklg6k43LuZB90JLInjrdb6sFIybWPJous6mAiRS0HvoF/gudchy6F+vA4dkDFqDUHRN93TUexX2Empny0G/cfD8O+RrBEnzJxLZnoa532jCEMZSlC1SwgOSbRVmLxbgWU0HoPQ=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB2939.namprd10.prod.outlook.com (2603:10b6:5:6d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 16:59:44 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 16:59:44 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Topic: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Index: AQHXQa3Y4CAWkou9VES/lh4Y7MmmMarc+byAgAAeRYCAAAWSgIBOOSGAgAma8wCAAAlKgA==
Date:   Mon, 5 Jul 2021 16:59:44 +0000
Message-ID: <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
 <20210705162628.GT4459@nvidia.com>
In-Reply-To: <20210705162628.GT4459@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acbe7598-a042-43c8-d0c6-08d93fd64a08
x-ms-traffictypediagnostic: DM6PR10MB2939:
x-microsoft-antispam-prvs: <DM6PR10MB2939B1BB7221F6D46A05752CFD1C9@DM6PR10MB2939.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FIx65tHtOVVtCoOQ1yaGYWNmMXGKLiXU21fGHwuzNCNdUJ/LPzpo5+sfa+NxtGPWK0tgta1qD2bGKnEKdtWDNavLSAHiD1Y3YRgzW7v6CGLiK9eLqEU9+7CXWHv1E8mLTjjeZ7YMLZNZ6NYNodj0+novM1/mWHgXU8aN/JmZxfkC6vTCDenm/7rza1wdleh6i5oQY6JYEpphADUcLvlrruCMPVLZ5Oq9LfICGHWOG0A5I6R8SHwer4hhpOq9UzxtoN/nstIRpb+BzL+t0LZajruKZDqp0wdAF991S+sCMiJ1xel5iHLi1co+jnKbxpoaE+J62AqoMpPCNFIUjefppOH3X+DDeVs22jwlUndt10LZiwkoMzIkaQVgfrnMXW+WzXvaolIaw68wSn2wU3r9jVipZgEmy2wilRPMyaclC3RQvnJLA7HFIR+oYqOa0qQY8HoujIVIxwjwJg9jAXK2ZF+RlnRmnICp16Bdi4m6KQR1OgNTkArKwEXpJZWmomBvFYvRzaRL0a0fpnucv3tU2JhYRQsgL4vvDYIdo/qrHzw2w8AzPtLun1vjd6120Q9r7BCG1pVgjTOnwTFaenlO/KW03FXky26cB4LAXVUW4j9Pi9RsoZLEyMMtnOMfYweuHUOJvCjzGh93b+htrSla8WDNaL8IJl+wFHim65xbhAE1sVLmkkHyTwsgOR69V1NowTXU0fV9RqMQ7uKT8hbMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(53546011)(33656002)(44832011)(36756003)(8676002)(71200400001)(6506007)(66556008)(66446008)(76116006)(6486002)(64756008)(66946007)(66476007)(83380400001)(15650500001)(91956017)(5660300002)(122000001)(478600001)(6916009)(6512007)(316002)(38100700002)(86362001)(2906002)(26005)(8936002)(186003)(4326008)(2616005)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHZtUGY0allLVTZJQmlKUlY2bTFmL0g2aXJTa0plZEs2Q2VpcG5oc3ZXS2tv?=
 =?utf-8?B?OWIzckNtWEZXcTdkRzVjMlVOTG85a05lbVppM1BZb2ovbFRDRGIxQUlmZHox?=
 =?utf-8?B?YUJod1FyYk5ySFpnY3hDTFR5ZzRSQ1Y4ZGljRUdGWnlQNG5YU01ud25kZG4r?=
 =?utf-8?B?Uk9iUXY3OHdkb0czSlV2R0dFc2tCTEZQTXdrUGdSZjNheWFBajJjcHFONEcx?=
 =?utf-8?B?T0FtY1VRN2NEZkZ2RXlpZUFIN0hQWXl5OFFaQ0s4bzNuYS80QXd6Zi90MWE3?=
 =?utf-8?B?YlUwUXRmdHgrRnU5WTIveFlpMU0zWVpRcThKQzNhRUpCVDBqY3l3Tk52V2dK?=
 =?utf-8?B?R0ZFR3Fmb05GL29zalJBc3RyVW9BZVNNbFNFZkZBRnBpcEpZY25lS0VKaEla?=
 =?utf-8?B?d3FETzNubmU4Y0NWTVY3ci9sRFdBZW1IZkR1MUJscVZjWmFFRDRDUW8wN1ZW?=
 =?utf-8?B?dGh3cnJzZldVVHVGajRiWWRzUDgvKytLVm90elU2cVcvVVNVM1J1OEpqaFha?=
 =?utf-8?B?MEdQUGh3bUxGcGcwc1RqR3JqQmxUNlIrZzc5U255d0d2VkhnNXF6cWxGSHJt?=
 =?utf-8?B?cU1CT1JYcEVXSm93L2VvZzhsSEN3UTNMenJzSTlySzM1WURHTzFDekdBck4z?=
 =?utf-8?B?YktzdWdMQTZ4eTEybjIvcXI1ZmlLaXc3aUdTdTZEdmpSMnE0bEJ4VjVUcUdU?=
 =?utf-8?B?Nm04aTZrQjRIK25kM0d5bm9qS0o2UHczYkEzQm5LbDNJZEpiNEJBREZpR2or?=
 =?utf-8?B?Yk1kNlB5MXQyeCsvcGg2cVVFZ2crMUhGdkN3TU9JQ0liL0JwQnNVUE1NQmFF?=
 =?utf-8?B?SVQ2Smd4YlAyT09DQSttSEZCY2VJUCsxZ2k4N21DNjFWUXdvckdRN0ZqckRt?=
 =?utf-8?B?UDJIL2kyallxUExvTno2VG9tT3Y1Q01aeURkRzJDY2REQ0JhZkUyZXlkS004?=
 =?utf-8?B?NlRTbndlaWgwUTQ3eVJhMllGOEVqN3ljSElPdFpCYXBIZXZ4bEpMSXM0TXU4?=
 =?utf-8?B?UG8zVGpoYlJpWDFXWExpQ1NFbUUrRGI1SXkyejcwTHN0OTBOWWRzYzVzTkh0?=
 =?utf-8?B?Y1JnYk9UYlBXcFRiQXpEbXRMTGJyQmhPa20rV2NBTUtLeHdLa1BSemZZZTNs?=
 =?utf-8?B?bUc1aWk3NlZjc0trTTNvUjlzQzlyVTgvcFVXZGJxM3BmMDZPQkE5dXVZY20w?=
 =?utf-8?B?d3EwWGh1YVE1WkpvNUJ4ZUc0ODZjS3VKa1U4ZVp4QWR0cytROG5WREJDa09h?=
 =?utf-8?B?MjY0ZHBaN1Y3YUVmdzA1WEphRzBBMjFKQ0p0d0l3VDE0NkZtNWprdWN5TFo2?=
 =?utf-8?B?OE5wZUc5QzBCOTZBUFNPelhqTFQzUjhmR3FyOHROejg4clM2Umtpd2hLK3kv?=
 =?utf-8?B?SDVSVmxmcmQ1Mm1QdExQSXR0VXZiZXBVekVwUW9meTQwRjFNVkpTbHpsWVdD?=
 =?utf-8?B?RHJOYUtEMFFPR3FHcHhaMG9IaVhDWGIrUjdNRDJMQ1gzbGVET3M5bUJoT1ls?=
 =?utf-8?B?VFJGY3hWTWZYd2hSVW9HVFc5aU1OVVBCa2R0QlNlOEpzV1JMbTlBRURoK2Fj?=
 =?utf-8?B?UENud2Z0RzlRU1dQR0srR1JCbGhkOENaNDZITHF4eTZkNlg1alcyQnZvd1hQ?=
 =?utf-8?B?cEtWY0tnQmx0dlQrU0FJQVZ5UlgrYVh6Y1lRaXNId1FiNnpPRTQ2dmRpNVkv?=
 =?utf-8?B?SmVnM1haTTlGSnBiTWFpZ3ZLWWlIRnZ4NVlReURLSTNrT3lLcTQ2UlhxUERW?=
 =?utf-8?B?cGNCT1d6cXdqcUdLQm1JR3RSZWtWdk5BdUxRZ2JqZE5yNmNtZnBzUklyUG4w?=
 =?utf-8?B?T3hhWlEyZlhiRUlLYmVyQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52E544E3B59BB4F969B8C3673E4547A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbe7598-a042-43c8-d0c6-08d93fd64a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 16:59:44.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bva2oiYFX2MIMyTXEQyjLQYOkRtj+q9QddTX0HVCL+oVbM2WLqz6CwwrN3cR4wW75E0BNsQFKdR5qYoelAN9Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2939
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050090
X-Proofpoint-GUID: VJS0TY7NHmt1dhpRjcXVnuw2xuSXYFeJ
X-Proofpoint-ORIG-GUID: VJS0TY7NHmt1dhpRjcXVnuw2xuSXYFeJ
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNSBKdWwgMjAyMSwgYXQgMTg6MjYsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMDE6NDU6MzVQTSAr
MDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0KPiANCj4+Pj4+IElNSE8gaXQgaXMgYSBidWcgb24g
dGhlIHNlbmRlciBzaWRlIHRvIHNlbmQgR01QcyB0byB1c2UgYSBwa2V5IHRoYXQNCj4+Pj4+IGRv
ZXNuJ3QgZXhhY3RseSBtYXRjaCB0aGUgZGF0YSBwYXRoIHBrZXkuDQo+Pj4+IA0KPj4+PiBUaGUg
YWN0aXZlIGNvbm5lY3RvciBjYWxscyBpYl9hZGRyX2dldF9wa2V5KCkuIFRoaXMgZnVuY3Rpb24N
Cj4+Pj4gZXh0cmFjdHMgdGhlIHBrZXkgZnJvbSBieXRlIDgvOSBpbiB0aGUgZGV2aWNlJ3MgYmNh
c3QNCj4+Pj4gYWRkcmVzcy4gSG93ZXZlciwgUkZDIDQzOTEgZXhwbGljaXRseSBzdGF0ZXM6DQo+
Pj4gDQo+Pj4gcGtleXMgaW4gQ00gY29tZSBvbmx5IGZyb20gcGF0aCByZWNvcmRzIHRoYXQgdGhl
IFNNIHJldHVybnMsIHRoZSBhYm92ZQ0KPj4+IHNob3VsZCBvbmx5IGJlIHVzZWQgdG8gZmVlZCBp
bnRvIGEgcGF0aCByZWNvcmQgcXVlcnkgd2hpY2ggY291bGQgdGhlbg0KPj4+IHJldHVybiBiYWNr
IGEgbGltaXRlZCBwa2V5Lg0KPj4+IA0KPj4+IEV2ZXJ5dGhpbmcgdGhlcmVhZnRlciBzaG91bGQg
dXNlIHRoZSBTTSdzIHZlcnNpb24gb2YgdGhlIHBrZXkuDQo+PiANCj4+IFJldmlzaXRpbmcgdGhp
cy4gSSB0aGluayBJIG1pcy1pbnRlcnByZXRlZCB0aGUgc2NlbmFyaW8gdGhhdCBsZWQgdG8NCj4+
IHRoZSBQX0tleSBtaXNtYXRjaCBtZXNzYWdlcy4NCj4+IA0KPj4gVGhlIENNIHJldHJpZXZlcyB0
aGUgcGtleV9pbmRleCB0aGF0IG1hdGNoZWQgdGhlIFBfS2V5IGluIHRoZSBCVEgNCj4+IChjbV9n
ZXRfYnRoX3BrZXkoKSkgYW5kIHRoZXJlYWZ0ZXIgY2FsbHMgaWJfZ2V0X2NhY2hlZF9wa2V5KCkg
dG8gZ2V0DQo+PiB0aGUgUF9LZXkgdmFsdWUgb2YgdGhlIHBhcnRpY3VsYXIgcGtleV9pbmRleC4N
Cj4+IA0KPj4gQXNzdW1lIGEgZnVsbC1tZW1iZXIgc2VuZHMgYSBSRVEuIEluIHRoYXQgY2FzZSwg
Ym90aCBQX0tleXMgKEJUSCBhbmQNCj4+IHByaW1hcnkgcGF0aF9yZWMpIGFyZSBmdWxsLiBGdXJ0
aGVyLCBhc3N1bWUgdGhlIHJlY2lwaWVudCBpcyBvbmx5IGENCj4+IGxpbWl0ZWQgbWVtYmVyLiBT
aW5jZSBmdWxsIGFuZCBsaW1pdGVkIG1lbWJlcnMgb2YgdGhlIHNhbWUgcGFydGl0aW9uDQo+PiBh
cmUgZWxpZ2libGUgdG8gY29tbXVuaWNhdGUsIHRoZSBQX0tleSByZXRyaWV2ZWQgYnkNCj4+IGNt
X2dldF9idGhfcGtleSgpIHdpbGwgYmUgdGhlIGxpbWl0ZWQgb25lLg0KPiANCj4gSXQgaXMgaW5j
b3JyZWN0IGZvciB0aGUgaXNzdWVyIG9mIHRoZSBSRVEgdG8gcHV0IGEgZnVsbCBwa2V5IGluIHRo
ZQ0KPiBSRVEgbWVzc2FnZSB3aGVuIHRoZSB0YXJnZXQgaXMgYSBsaW1pdGVkIG1lbWJlci4NCg0K
U29ycnksIEkgbWlzLWludGVycHJldGVkIHRoZSBzcGVjLiBJIHRob3VnaCB0aGUgUEtleSBpbiB0
aGUgUGF0aCByZWNvcmQgc2hvdWxkIGJlIHRoYXQgb2YgdGhlIGluaXRpYXRvciwgbm90IHRoZSB0
YXJnZXQncy4gT0suIFdpbGwgY29tZSB1cCB3aXRoIGEgZml4Lg0KDQoNClRoeHMsIEjDpWtvbg0K
DQo+IA0KPiBUaGUgQ00gbW9kZWwgaW4gSUIgaGFzIHRoZSB0YXJnZXQgZnVsbHkgdW5kZXIgdGhl
IGNvbnRyb2wgb2YgdGhlDQo+IGluaXRpYXRvciwgYW5kIGl0IGlzIHVwIHRvIHRoZSBpbml0aWF0
b3IgdG8gYXNrIHRoZSBTTSBob3cgdGhlIHRhcmdldA0KPiBzaG91bGQgZ2VuZXJhdGUgaXRzIHJl
dHVybiB0cmFmZmljLiBUaGUgU00gaXMgcmVwb25zaWJsZSB0byBzYXkgdGhhdA0KPiBsaW1pdGVk
LT5mdWxsIGNvbW11bmljYXRpb24gaXMgZG9uZSB1c2luZyB0aGUgbGltaXRlZCBwa2V5Lg0KPiAN
Cj4gVGhlIGluaXRpYXRvciBpcyByZXBvbnNpYmxlIHRvIHBsYWNlIHRoYXQgbGltaXRlZCBwa2V5
IGluIHRoZSBSRVENCj4gbWVzc2FnZS4NCj4gDQo+IFNvbWV3aGVyZSBpbiB5b3VyIHN5c3RlbSB0
aGlzIGlzbid0IGhhcHBlbmluZyBwcm9wZXJseSwgYW5kIGl0IGlzIGENCj4gYnVnIHRoYXQgdGhl
IENNIGlzIGNvcnJlY3RseSBpZGVudGlmeWluZy4NCj4gDQo+IEphc29uDQoNCg==
