Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14B53467D6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhCWSia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 14:38:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60172 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhCWSiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 14:38:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIPM7L009556;
        Tue, 23 Mar 2021 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MWGatN1iMWvoU9TiSq77iY2Cl6pGA+u8c55bfZN4es4=;
 b=P+SZfzhAM5GQbkTFZgyLziv+815ezVbjBLrnGbKYNHnmhrxLdAceUFcEW5TTrXFuRlbF
 svKzTGrwHfFpchiiVjw3qtl1KOBQawgZpJ7eZa5+PtfgxdnISH1R/DgaHV/roZFcp5he
 06xwWU7szQCMOiiB20reqBBhHOfjLASi4YlZLhumCk6reALPCrO6uv0UrZWcnxGvQqHB
 9P9oFcxp9cKU6RfOImElBKrYmYtFKskmGoNw+YQPd8I70rLxADJ3EmX2OThgLGzNhIVA
 ofaUXgcYxjHuxHFepZjUrP75n2HSoVEdUcM2hxYgzcqU5K/HRE+FPYS2UoNFv4IGaKbJ Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37d90mg6j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:38:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NIP9oG023126;
        Tue, 23 Mar 2021 18:38:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 37dtmpv5gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 18:38:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggh4/4KjyPhPUT0IAVLbGBLSXVxh6afItZfW22aRe6REGk3N2LikaByQSFX1xGzzgRuh5bZzWVJHvwny0V/W3My5Y8WJR8oINNpfcTJ5obvI6PGmF1Ll9mRvokQR6E0uFchWXbV/jAdYbWgbgaX4Yz+jtDyll2nimgm7r+IvhhP9eDgLTHdZe0sb7qV1jiJN26Ph9WbZAp5jdc4U0fYFth33rSbe04IjVgwEWz819izUfLBxswdyyjSEibfStD0Ds9Vog0aTbYceBzCLw1IWba29XRh42bkGyXboVNHI6sdmvXcz1RfTyGRWIi4hSTHC5ZI/4vf0lDvhkN8VvwkhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWGatN1iMWvoU9TiSq77iY2Cl6pGA+u8c55bfZN4es4=;
 b=PTGZX4xT0GMmOC0sP8gm3E04ysToBqwuoVqftvVCpthN41i51OhPxMu/OH/zZcztimJIZ2EpbpRLmbE396Bf5y6YQShQdjqlG2UBeGe3AglgoYGY89ri76ifkTUXvjNiFT0UFXg9JQ93lIcVPeouc7CtinzjX97btDQDUgeHYf7dhYuxp2ohctqsfEcIlYAFCZpr2KE3acFgHylzHBRD1vdw+XAce2uTvqOK5DoqfcErQjeAxG+e9UXQfp6kdDth7oXsXneo1Ztsm0jjzaxW2NdOoT698qfqE3VokdPkzwXrpVOBBGbx/DBwKXMCpCLwnUcQPUwsMSD86qZ+WexIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWGatN1iMWvoU9TiSq77iY2Cl6pGA+u8c55bfZN4es4=;
 b=Yt9+IbAUp0ygL8mx4+DDTHAph3/zHZdj+IIgXnoOpsXHtbGjRL1be+7qdS+nNMCeVyK+PMFAdYummSfrD6k5GzqgENlaCYwmGiSYY+H4ohU+xb1BEvyJ67jsKfagePC4tvmfrfELXx96kQ51JeyHmSrXZVvRZuk6w+GTHoM0csI=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1302.namprd10.prod.outlook.com (2603:10b6:903:27::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 18:38:17 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3955.027; Tue, 23 Mar
 2021 18:38:16 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Topic: cm_process_routed_req() does not resonate well with RoCE systems
Thread-Index: AQHXHCvyugjSuECPqUSo/S5N1vnDPqqLarQAgAZ8IgCAAAgwgA==
Date:   Tue, 23 Mar 2021 18:38:16 +0000
Message-ID: <2DB21D39-B563-4745-83FC-AC3AD10D8BE6@oracle.com>
References: <566B6781-C268-4B1C-A359-44B2FE14B91A@oracle.com>
 <D96DEBF5-042B-4B92-A512-EA6757020960@oracle.com>
 <20210323180856.GL2356281@nvidia.com>
In-Reply-To: <20210323180856.GL2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63b069b9-2278-41fb-5481-08d8ee2ad29a
x-ms-traffictypediagnostic: CY4PR10MB1302:
x-microsoft-antispam-prvs: <CY4PR10MB13025B52CAB96A4566AAE10DFD649@CY4PR10MB1302.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4/cTXzQHUJF3KIsCOKMKoqNBzDt1PxKBkMtLFN9I+nfJjSk/P6GG0MxVlfk8cnoJmUmIDqz69mH4LqyD3DbUK/8GWzpUF8i4yz98cJhKSbYuHoeXg9B/FZLkn/dg6cVpl2lxx1fLhffEc76Hu026PihiktAslCcvjoQZyhVgRlCHDK+kefg6QUntRVYYnvK1OttjC6EJTAEyJN1nKoNCEq3e1df80C/N5cFK6zraKWo0KEiHLi8Xl94pphuCP8RnGt03btR075RpYQOvjCMgjrNVq6TFq7yreTtBW6Q0B6XQidBLSZKIl789ku7D39cqiX+xdQDudqRyrKMgVnBBcfI61oRZKX/M6DWpJxVwZ0cxMxtLHcK1DWhm/rTkv2DW+JxTGbI+KFGg+/rXXhR4b/StQ8HrQ49fod9PtHIfsbGr8iY1OSKFu+Jr5H1zZPmpIC3EswlzC8bOfsBjXOMeqTni7LDymoFgbclI+qF9xkwoKZYWqzwIODxuvgybTXllI9xi+byS7amqdBoE0BTtHNnSqXjg35eqss1FZCGTHPQ8NBpDzmz7HQ7kqXQ24SYq1PKyBR8Rj7VQWXKhQ7E1OKF9WXfz0mR7Rw/sSbTD57eiXAzzwjfgkoQFhSIooGy5si6GAydeFCJ17r3SAlIL4ISgetMBIvOhrGvZyZTEWieJuRDjVj5qdQ5KtXxOHJT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(64756008)(38100700001)(54906003)(66946007)(2616005)(66556008)(6916009)(316002)(66574015)(478600001)(6486002)(66446008)(83380400001)(5660300002)(6512007)(2906002)(8936002)(33656002)(76116006)(53546011)(4326008)(86362001)(66476007)(91956017)(8676002)(186003)(26005)(36756003)(6506007)(44832011)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UzNsVnQwR25NTzVQT1NMQkdzcWtZYlpkbm1PSksrbUM3UDRTSXdMNFhSUUNi?=
 =?utf-8?B?VC9nOE5hVVBmRmk1RHRXZFBOc2N1N25EejIzSEdBM2VnTkFBZ2FjNGFNL0kz?=
 =?utf-8?B?RStxTFBxUU5nMFBzeW8vMDd6T0xmWGY5b2lFNkwyL0ZCR3FrRDRYVW00NE0v?=
 =?utf-8?B?OWxpcVM5d3NSRHREaEowaDU2VGRXcDJ0aFRzMDcrLzNMdVp3Y3hrY3c0alZt?=
 =?utf-8?B?WnNiUXU2MmdoNkNPZ2J3V29kQjBFOVRab0g5alFxYjE5TjN3THJ2UEpQSWRv?=
 =?utf-8?B?QXJQWEhqNk93My9qd3V1blJzKzZET2dCOFRHdFo2TDkybjVrMlk0NUxmbnA3?=
 =?utf-8?B?VDM1YkxUZjJwU3VkNVlKOFVJU2JYSUtCaVlHcElkd1gxMXdkdmxEenA3ZHl3?=
 =?utf-8?B?bmZsSTBDU2ticFl5Q2FXbUVWUVlvVGtlU0U2RGJwTEdRT2lhVkY2b0hQREVD?=
 =?utf-8?B?YlUvVlJsdzBiaDB3Z2Uya1o2b0xtU3JtWFhWeEdOZS9PM3hBWURVaUk3aTlk?=
 =?utf-8?B?SHAyeEVFaTgrb2xCRjFmMHhKVkhzbHN6WmErZ09IR1FlZVdiTmhSMzl2TE1t?=
 =?utf-8?B?MjBabnArbjF0TUFQS3FnTWM2Szk0aURuTVl0bzVHR3FQTGRSUGFpT21PRVFW?=
 =?utf-8?B?aE1SS1Ywb3g0T25TQlRYQ1AycHRGSGRFU2x1ZmJ3WldCWm82NlFUckJQU2VD?=
 =?utf-8?B?dTNFRVlHS0wwU0xTVitrTGYzSFJmZWwrRnVaSUQ3Nmd2Z3BFZFd3SVU3ampT?=
 =?utf-8?B?b2srNjFEYzFFcFgxUzRFRTJkNHNvOFpQMHpmK2d4Vm1XWCtncDg3SG9nVHho?=
 =?utf-8?B?UzB1NFlUN05MRDNjUHV6bzhCMEM1RXZ4TjRxVFpQTlRLTWk4eWxpSWxzeEpD?=
 =?utf-8?B?RzB2ckdZcklERWNuZ25ZKzJrdFIyZEdJWlFGM1ZqejI2dEcxSUU0MncxdEZo?=
 =?utf-8?B?SkovQ2dXcW1NS2padmFLOGZNNjFzcFh4eHBnWlJVUWE5eGRVN3pyQnN1T3Zq?=
 =?utf-8?B?T2NFSUdacE1qNm9LQzdzbTF6SzYwVEpObzdHaGxRcnhpN29ZbjYvWi9BR0Rk?=
 =?utf-8?B?VjJiZjJRQ00reEdMeEc0SStQT051TTRtQlJRTlZ5aUxIbHFLUUd5bWZvaVli?=
 =?utf-8?B?d01pNjU3MjFWN1FzTFg0VzdJa0RYY2hwSTNCaDNkQTkwWHc5ek5OZk5acVhs?=
 =?utf-8?B?UUg5cWNOK2NZdmJCbk9iVk5jaURSbFEvc2tFcklCdXBHc2kxOXJyM3VwZ2hu?=
 =?utf-8?B?ZWMvQnhZSXNtYmg5Zkl0NHZ4M3JHekpIMjlIc1dmTFdXTEZoa0REVDU3cHkz?=
 =?utf-8?B?WVNJeW40VW5ka0VUOVBUWVBweTJ0NFFHMW1HZkxYMlZITFREUUFiTHgvU2M3?=
 =?utf-8?B?WktDK2xnZXdtTGxlQ2lIRjZUdjU0bkRaUUVLQk0wclNka002Z2hnd2JNdUJN?=
 =?utf-8?B?TWJzRzlsVzJXRkJhUStPalp0K0F3Nm8yV0VENSt1ZHg0MHdQZHlCSDZMRTc2?=
 =?utf-8?B?bGUzeERLNmN4MFhKMTNkdFdMM0RVallrd3NJYjgyTC9oZUtHWTBUUi9BcXk1?=
 =?utf-8?B?ZEJ1Z200TFBjTUdveDRUWFJHaVNrRnlnSVpqaC9JMW9HRFFDTW5hQmE1eEhW?=
 =?utf-8?B?RC9KZ2NPcm5CNzcxY3Q2R21mYXUxVGF6cHcxQVNFbVpMQS9ZWWF6TE0yVVlE?=
 =?utf-8?B?ZXR5ZGhJcTE0UmtLbm5vVEdHam1WTXAvWDlsTkgwcnNPaVA3K2VybkREVk4z?=
 =?utf-8?B?SEQvVlUvdmxMaWtlWHkvN2RZMld0b2t1VXFXbFJaQlJWVEdHUlFHNTVlZEJx?=
 =?utf-8?B?dmJWckd0OHoyWjRPZFVsUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C559927A20ED446ADE32F46174FC64D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b069b9-2278-41fb-5481-08d8ee2ad29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:38:16.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U72SYWQfpv8HHvxuPdAYYUYncxFvgszqltcAeTqwsXreV+4ZOUMAGW/rrwNDeFVgVtwCz/l9CBm3FGUa63K7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1302
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230135
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjMgTWFyIDIwMjEsIGF0IDE5OjA4LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDAzOjA3OjA3UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMTggTWFyIDIwMjEs
IGF0IDIwOjIxLCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+PiANCj4+PiBXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgUm9DRSBzeXN0ZW1zLCBhIENNIFJF
USBtZXNzYWdlIHdpbGwgY29udGFpbiAocGFzdGVkIGZyb20gV2lyZXNoYXJrKToNCj4+PiANCj4+
PiBQcmltYXJ5IEhvcCBMaW1pdDogMHg0MA0KPj4+IC4uLi4gMC4uLiA9IFByaW1hcnkgU3VibmV0
IExvY2FsOiAweDANCj4+PiANCj4+PiBUaGlzIGJlY2F1c2UgY21hX3Jlc29sdmVfaWJvZV9yb3V0
ZSgpIGhhczoNCj4+PiANCj4+PiAgICAgICBpZiAoKChzdHJ1Y3Qgc29ja2FkZHIgKikmaWRfcHJp
di0+aWQucm91dGUuYWRkci5kc3RfYWRkciktPnNhX2ZhbWlseSAhPSBBRl9JQikNCj4+PiAgICAg
ICAgICAgICAgIC8qIFRPRE86IGdldCB0aGUgaG9wbGltaXQgZnJvbSB0aGUgaW5ldC9pbmV0NiBk
ZXZpY2UgKi8NCj4+PiAgICAgICAgICAgICAgIHJvdXRlLT5wYXRoX3JlYy0+aG9wX2xpbWl0ID0g
YWRkci0+ZGV2X2FkZHIuaG9wbGltaXQ7DQo+Pj4gICAgICAgZWxzZQ0KPj4+ICAgICAgICAgICAg
ICAgcm91dGUtPnBhdGhfcmVjLT5ob3BfbGltaXQgPSAxOw0KPj4+IA0KPj4+IFRoZSBhZGRyLT5k
ZXZfYWRkci5ob3BsaW1pdCBpcyBjb21pbmcgZnJvbSBhZGRyNF9yZXNvbHZlKCksIHdoaWNoIGhh
czoNCj4+PiANCj4+PiAJYWRkci0+aG9wbGltaXQgPSBpcDRfZHN0X2hvcGxpbWl0KCZydC0+ZHN0
KTsNCj4+PiANCj4+PiBpcDRfZHN0X2hvcGxpbWl0KCkgcmV0dXJucyB0aGUgdmFsdWUgb2YgdGhl
IHN5c2N0bCBuZXQuaXB2NC5pcF9kZWZhdWx0X3R0bCBpbiB0aGlzIGNhc2UgKDY0KS4NCj4+PiAN
Cj4+PiBGb3IgdGhlIHB1cnBvc2Ugb2YgdGhpcyBjYXNlLCBjb25zaWRlciB0aGUgQ00gUkVRIHRv
IGhhdmUgdGhlIFByaW1hcnkgU0wgIT0gMC4NCj4+PiANCj4+PiBXaGVuIHRoaXMgUkVRIGdldHMg
cHJvY2Vzc2VkIGJ5IGNtX3JlcV9oYW5kbGVyKCksIHRoZSBjbV9wcm9jZXNzX3JvdXRlZF9yZXEo
KSBmdW5jdGlvbiBpcyBjYWxsZWQuDQo+Pj4gDQo+Pj4gU2luY2UgdGhlIFByaW1hcnkgU3VibmV0
IExvY2FsIHZhbHVlIGlzIHplcm8gaW4gdGhlIHJlcXVlc3QsIGFuZCBzaW5jZSB0aGlzIGlzIFJv
Q0UgKFByaW1hcnkgTG9jYWwgTElEIGlzIHBlcm1pc3NpdmUpLCB0aGUgZm9sbG93aW5nIHN0YXRl
bWVudCB3aWxsIGJlIGV4ZWN1dGVkOg0KPj4+IA0KPj4+IAlJQkFfU0VUKENNX1JFUV9QUklNQVJZ
X1NMLCByZXFfbXNnLCB3Yy0+c2wpOw0KPj4+IA0KPj4+IEF0IGxlYXN0IG9uIHRoZSBzeXN0ZW0g
SSByYW4gb24sIHdoaWNoIHdhcyBlcXVpcHBlZCB3aXRoIGENCj4+PiBNZWxsYW5veCBDWC01IEhD
QSwgdGhlIHdjLT5zbCBpcyB6ZXJvLiBIZW5jZSwgdGhlIHJlcXVlc3QgdG8gc2V0dXANCj4+PiBh
IGNvbm5lY3Rpb24gdXNpbmcgYW4gU0wgIT0gemVybywgd2lsbCBub3QgYmUgaG9ub3VyZWQsIGFu
ZCBhDQo+Pj4gY29ubmVjdGlvbiB1c2luZyBTTCB6ZXJvIHdpbGwgYmUgY3JlYXRlZCBpbnN0ZWFk
Lg0KPj4+IA0KPj4+IEFzIGEgc2lkZSBub3RlLCBpbiBjbV9wcm9jZXNzX3JvdXRlZF9yZXEoKSwg
d2UgaGF2ZToNCj4+PiANCj4+PiAJSUJBX1NFVChDTV9SRVFfUFJJTUFSWV9SRU1PVEVfUE9SVF9M
SUQsIHJlcV9tc2csIHdjLT5kbGlkX3BhdGhfYml0cyk7DQo+Pj4gDQo+Pj4gd2hpY2ggaXMgc3Ry
YW5nZSwgc2luY2UgYSBMSUQgaXMgMTYgYml0cywgd2hlcmVhcyBkbGlkX3BhdGhfYml0cyBpcyBv
bmx5IGVpZ2h0Lg0KPj4+IA0KPj4+IEkgYW0gdW5jZXJ0YWluIGFib3V0IHRoZSBjb3JyZWN0IGZp
eCBoZXJlLiBBbnkgaW5wdXQgYXBwcmVjaWF0ZWQuDQo+PiANCj4+IEkgaW50ZW5kIHRvIHNlbmQg
YSBwYXRjaCBkb2luZzoNCj4+IA0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20u
Yw0KPj4gQEAgLTIxMzgsNyArMjEzOCw4IEBAIHN0YXRpYyBpbnQgY21fcmVxX2hhbmRsZXIoc3Ry
dWN0IGNtX3dvcmsgKndvcmspDQo+PiAgICAgICAgICAgICAgICBnb3RvIGRlc3Ryb3k7DQo+PiAg
ICAgICAgfQ0KPj4gDQo+PiAtICAgICAgIGNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFfbXNnLCB3
b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0KPj4gKyAgICAgICBpZiAoY21faWRfcHJpdi0+YXYuYWhf
YXR0ci50eXBlICE9IFJETUFfQUhfQVRUUl9UWVBFX1JPQ0UpDQo+PiArICAgICAgICAgICAgICAg
Y21fcHJvY2Vzc19yb3V0ZWRfcmVxKHJlcV9tc2csIHdvcmstPm1hZF9yZWN2X3djLT53Yyk7DQo+
PiANCj4+ICAgICAgICBtZW1zZXQoJndvcmstPnBhdGhbMF0sIDAsIHNpemVvZih3b3JrLT5wYXRo
WzBdKSk7DQo+PiAgICAgICAgaWYgKGNtX3JlcV9oYXNfYWx0X3BhdGgocmVxX21zZykpDQo+Pj4g
DQo+PiBpZiBJIGRvIG5vdCBnZXQgYSBwdXNoIGJhY2suDQo+IA0KPiBUaGlzIGRvZXMgc2VlbSBy
ZWFzb25hYmxlLCBidXQgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSB1bmRlcmx5aW5nDQo+IGlzc3Vl
LCB3aHkgaXMgYW55dGhpbmcgaW4gcm9jZSBsYW5kIHRvdWNoaW5nIHRoZSBTTD8gQXJlIHlvdSB0
cnlpbmcgdG8NCj4gdXNlIHRoZSBTTCBhcyBhIHByb3h5IGZvciB0aGUgVE9TIGJpdHM/DQoNCldl
IHdhbnQgdG8gY29udHJvbCB0aGUgRFNDUCBpbiB0aGUgZW5jYXBzdWxhdGluZyBJUCBwYWNrZXQg
dG8gc2VsZWN0IGRpZmZlcmVudCBUQ3MuIEFzIHBlciB0aGUgUm9DRSBBbm5leDoNCg0KPHF1b3Rl
Pg0KVGhlIFNMIGNvbXBvbmVudCBpbiB0aGUgQWRkcmVzcyBWZWN0b3IgaXMgdXNlZCB0byBkZXRl
cm1pbmUgdGhlIEV0aGVybmV0IFByaW9yaXR5IG9mIGdlbmVyYXRlZCBSb0NFdjIgcGFja2V0cy4g
U0wgMC03IGFyZSBtYXBwZWQgZGlyZWN0bHkgdG8gUHJpb3JpdGllcyAwLTcsIHJlc3BlY3RpdmVs
eS4gU0wgOC0xNSBhcmUgcmVzZXJ2ZWQuDQo8L3F1b3RlPg0KDQpRdWl0ZSBzaW1pbGFyIHRvIGhv
dyBJQiBMaW5rLWxheWVyIHRyYW5zbGF0ZXMgdGhlIFNMIHRvIGFuIFZMLg0KDQoNCg0KVGh4cywg
SMOla29uDQoNCg0KDQo=
