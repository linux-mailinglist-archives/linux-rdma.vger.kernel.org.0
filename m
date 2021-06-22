Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B43B07F4
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFVOz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 10:55:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhFVOz4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 10:55:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MEqHX7009452;
        Tue, 22 Jun 2021 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nzbebNiDb9wYtbIStoCB/mOMvV1ZvIEvwlIvF4b1ehA=;
 b=yk10j2Ow76TBWGqcpLMANICfPf28V92JBuBK5sJzuBoZrTEyH0SUl2yXe69487DODHbb
 1kNn402TY2/WAJyYgMpIoVos/btJ+pzpXi4uz0xyx966fMcPu43KA/AIdi0SbJcNJq3+
 pD8HX/XxXpkVuwmTK/1WZN6YZhUs8c4Qr0dU7xAk4T4N52BGOGi9Q+3LxlnGApeYLEyY
 srGEnOFgJB3cwqNGWi006wgAUfh679kVRsBZKHsQNG9B0O1mXHjNGSNehB9Zmk/aP1Eb
 MgU8TioiuxKxrdaM4osS8kRsa3cY6slhLSEyzXgj7yBtpiV58sXuF2jTRqtLBy1zf/of Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39bf94rfm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:53:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MEprcl189776;
        Tue, 22 Jun 2021 14:53:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 399tbsve4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH/M2wgXE9N2tpXbm/ym5BQj6HVf3aMGcra3CCmDE/S2HpqtOrqi44BWaSvfDFt0n/h2/QizKOSyfGH2vDlUsqr1PXI9R5ONlzq+qBbPirYy+9r6fmepKumnJx3uYvoUy8JqrlmXCJjhN0Kf7bcZ9/HNc5gfP04OKd7v3lgRjuWEWKfEA3lh+0laU5EL3ap8FKW2OoCrRaeFswtTWEJ/BasAzAIUay+pnuK91iXOW02IKl0l1k6Piw9Dgr5w/UGpJro8MBMrsF+Ki1nbSmkqpZgByXQLjj93KAQ8yrVtICO8ZCBpDnrzsXDVnu9eq9N0SUswM/XTjHiU2oc2PeDbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzbebNiDb9wYtbIStoCB/mOMvV1ZvIEvwlIvF4b1ehA=;
 b=bj6BsdR+RST1Qq3oCX6PS0j7SXRPgf7zmAooIQHm0Za7PM7C4dtjo843TjDwj3lQZVfck6+LDdYK2u+jyrNleNlQ2itBaGLmPOBAkKALi3YPrVjYtte+m20QjSsbxskp+P4eh4a1K8fqPPXYv0Fa7CTSj2PL0fL1BYHYcUOsBAzPQyS4u+lP9aUzhyw1Py7/5cBrXAmTnJhw3UYZEiE3HYlPz8NpUi6R+FaF5fTFKLiOrkdDhywBYKmMmKkD0K1hdI5TMIFvqJryI2Y9Ktsjg8F+peQdw4Z9laWuyIoe5bZd01Dl6RaPOTzCHrxKyBwcGK9XUefzkAI9MrTvGid7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzbebNiDb9wYtbIStoCB/mOMvV1ZvIEvwlIvF4b1ehA=;
 b=Qumf4hzE3Iywg+z6+Fk1czkZaES/XP+P0vQFkU77TReA3qUj/F9xwblTNV82z1mUdBp5xrvlAFchZz236LPABUwqyle4P0U6ZJo3NO88BVr+HRml8M+3eJ4PN47gnAUK7YjfS13qxHDfZ0avSCqaM3vVlDvzsoqSk7PWLT4GqVg=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1671.namprd10.prod.outlook.com (2603:10b6:910:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 14:53:33 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 14:53:33 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Topic: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Index: AQHXZ2ltwmtxE48f1kOxv7jbPUT9RasgHDmAgAABsQA=
Date:   Tue, 22 Jun 2021 14:53:33 +0000
Message-ID: <23AEB866-AB67-4148-93B2-90D785EF1C8F@oracle.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
 <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
 <20210622144729.GB2371267@nvidia.com>
In-Reply-To: <20210622144729.GB2371267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a2aba9-69c3-47bd-330c-08d9358d81eb
x-ms-traffictypediagnostic: CY4PR10MB1671:
x-microsoft-antispam-prvs: <CY4PR10MB1671A1A040B12DC975282D2AFD099@CY4PR10MB1671.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2x+mP2YR8ZK8EjIPPayPEGycyVZwNWA1dpjd0c1kZEHxXRdYSLGo7FwZ6UhvaXkAvq8+FYVdSqGJmLfRjypXRHyZ3oa4jciA+6niAfw5Gigg/kohuMeBucBlnLHYnrLQTHHnjJgVtfPsJ76EmflZK+4jvb76zPLT5R4y3f5uc33ntspGlL+an7Jm7mV4bUKa2zoxxcQWc9ObAIVCICqGMOG+3s/xnMWlECZiFJ6vsMP4Ma8hIxBo33AvtOtjRQBt7Bq4PEf/+BGFG0yzAi2AOEJzHqM+y0GDJgvmC4D5+0Bwzk/aJ3o4eHaoZQDt3V10LblnFBt/pQ5IUb7Yonfw6eEKWMUTO/zddGEStv/Y07O8ljumBbXpAJ4S+PsF6Bvbu7K5jgFIi5zueLhRsuEcKunS7u62/3kAGIhKjjAwvhNSNGmlRJ7rFY0m+/qEOIpXw3oO5b7QgFSeB/VzwTxFzfyweecduwcMUSRHxY57ADdyM6DSYMGr/Hnola0jSxrs4pz0Ov3DVFQAaff8KA6x6+SpTRmhtOEHnSds5IW9cVzS2XrWxM3eCKYSqDyL4sw9AL05ePPzuf21CdKNvw/XWvwmTdhBFhpdA4qvA/y3lIncGXqUVAXnli8AsE8jLx8HUbGlF1d+A0FMQIwQN4pX4yRZ31v/hflPZZReCa9V60KTG1V2mJxTtJ+IbVT1J117iEv0b9wGmTePknBE5j2VOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(6506007)(33656002)(66946007)(4744005)(76116006)(91956017)(6916009)(6512007)(44832011)(53546011)(66446008)(64756008)(66556008)(66476007)(4326008)(478600001)(71200400001)(316002)(6486002)(2616005)(122000001)(8676002)(8936002)(36756003)(54906003)(26005)(38100700002)(2906002)(186003)(5660300002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnQ3WjZ1bHRZM1YyQ0JQdlVjalZCV3lVWkdSYkh0OGRqNW1sOXpJSG5WL3FW?=
 =?utf-8?B?T3FlMWo2c0M4L1IzcE9QNjJ2T0NkSnB0QWpubDZVRGp6Y1pObm1ramRBS0pI?=
 =?utf-8?B?bSt1K1g2aHB0WnNEYW10SmRxbUl3amdYT29SOW81cnlyd1hlTVV3cDZEYXhj?=
 =?utf-8?B?ZkI5eW1yOXZmNWtkRWZJR1REWmJJSFJvM0JoSUoxZitwajR5R2lWdFJTdkZz?=
 =?utf-8?B?clIxSmcwRDdjSlkwaUY5V3QzMmpqNnFYZi9nYU5oQjEybDEwUnZ6OHVoWEtR?=
 =?utf-8?B?dDBzTUFGSXpYWnQ1Zm51VWQweHU3dDJSU0xSL1V3SGVUVWVMZktsSytkSmlo?=
 =?utf-8?B?VUR2MVZOT1FMWjJFSm9nREtWWWNqVXoxRDdtRUZWSmhzaVl0T1hyZWJHZGlj?=
 =?utf-8?B?QnFQTWtNUy9XbU5TUkFOQ2NOcjZJcW5GVkhlSmtEa2dEakNVblNqUjJUVi81?=
 =?utf-8?B?SVlDSkx2WnVtbDdZMFV4N0ZOaWZPYkZzL0dZcVp1WGprQWg2c2s1eVBIVVl3?=
 =?utf-8?B?NStoQUdNSTYybjVJdTVhSzZxc3ZYc1NBTVd0bVE4cmJvVWhZVHVMbFMvT2VS?=
 =?utf-8?B?ZXVQRVFzT2VCalJTRGY5ZjlLQUVoRzBRcmhSSXA5Ui9NdmQ2VUV3cmtPZ0d6?=
 =?utf-8?B?bUFDaVp1aWdXYzZza05HbXJlMlozdnZPNFpkcGxVakZJVjJvcjFtdlBCRkE1?=
 =?utf-8?B?aXU4Unk1TEVNUWk4OWttODBFV0FWWnFhTGlCYjlVaTlLeWxDWXNiU3BtWU5n?=
 =?utf-8?B?M2h2anNyWWNHblg0S3AyelJoT2M0YUdiK3hkVTE2LzBzUTJHcXZhZ1VOenpy?=
 =?utf-8?B?cW1DTWNmblM2d3lMMFhJUEMwS29RejNIQlRFdEQ4TzB5aGl4L0xaYjdqT25U?=
 =?utf-8?B?WS9WaGR0RDdKUVJOL2J3d2JtRmR0Ynd3NUk0cmxMUGFNNmo4UEt3MGZSRHdo?=
 =?utf-8?B?QVpTbitieE9pZVFBUzdDN0tvbVFkVE9zZFlTVHBsOUtvRU1PRFpIM1htdTFn?=
 =?utf-8?B?ZU5LZWw5RnRaSGlCTEg3TFUyZGM0Qm1rTGVsOU1FRTFWQ2psMU5MVWtnYVFE?=
 =?utf-8?B?aEVodXlrMUpaaDNYU2twbDBsOTZXcm1pUEE4WWNsVnc1am92cDZ1ejMvdlNH?=
 =?utf-8?B?OXlmNFFYWUF4V3g4SGU4dUNqck53SE8ycncrUkI2dUpOZEtxZlRpeFdmdHNI?=
 =?utf-8?B?UHloci9CZ1pXdXhmZzVDSms1MzJ5L3pkcXdLOVhrVG9hOVZScnZDZHhCS0p4?=
 =?utf-8?B?RHZ6eFVsbitEQVg0UzlhYkNPaVQxZzRjUUtnZVRvMFM4aUIzbC9yWmNLdmc2?=
 =?utf-8?B?d3NEckpMbzdwTkVIQzhuRVdoWE9DU2NaRGRPcUlMQ2pBbjJqNllRenFlN3Zt?=
 =?utf-8?B?eEF2WUtDUEVxMmR4cGhzMzIwRGlKOS93TXJuVlhTMFF0MjQ0MXZXeC9udGNs?=
 =?utf-8?B?RHVFY3Zub29nWXVxMDZ0ZGVSR05qc1FZRzlTUlY5TFNhQnVwaFJ1R0g3czFM?=
 =?utf-8?B?TllDVVV6ZFdqN1lJQnBPc01CTG1kb0Y1andKbTA5SDZ0eFVyc0dXTTEwdjJ0?=
 =?utf-8?B?TU56ZmtvSnZIamNreGFGZlQ2S2JQT3pwWFVtRExnRmRabExyVnV6dHpvQkY3?=
 =?utf-8?B?WU1FODRwZGl6ckVmT2RHa1dyK2Y1Z3RTMkp5bEprMFM5bU5pNElwZmN6bGVm?=
 =?utf-8?B?dFZJRjV0dWQ2YVRkZmVEUEIrZHVDaUs5MHFBbS9WRzlrV00rUnExaEt6Zi9R?=
 =?utf-8?B?T0t6S094dkh6MjN0RDBZaTNRbDFVMmIrTHhYVzdqdEZTU1d2RlhmS2FFZFFC?=
 =?utf-8?B?Z3JNdU9LbnBzTFRuTEJ0Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <516D984B064658488FA05C42760DA038@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a2aba9-69c3-47bd-330c-08d9358d81eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:53:33.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIMmQsQacWhyAHZ+9IVkgUq/ckoIPXg065+eJpTLh4jWEj4DjeYE+OyM2Zw/N4S4mKY3k5G7xzqTYUFNs/9+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220092
X-Proofpoint-ORIG-GUID: 0PB6yFkRdCvtx9m_ZS23YXUFdYfFE7O9
X-Proofpoint-GUID: 0PB6yFkRdCvtx9m_ZS23YXUFdYfFE7O9
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDE2OjQ3LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDAzOjIwOjI5UE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEluIHJkbWFfY3JlYXRlX3FwKCksIGEgY29u
bmVjdGVkIFFQIHdpbGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBJTklUDQo+PiBzdGF0ZS4NCj4+
IA0KPj4gQWZ0ZXJ3YXJkcywgdGhlIFFQIHdpbGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBSVFIg
c3RhdGUgYnkgdGhlDQo+PiBjbWFfbW9kaWZ5X3FwX3J0cigpIGZ1bmN0aW9uLiBCdXQgdGhpcyBm
dW5jdGlvbiBzdGFydHMgYnkgcGVyZm9ybWluZw0KPj4gYW4gaWJfbW9kaWZ5X3FwKCkgdG8gdGhl
IElOSVQgc3RhdGUgYWdhaW4sIGJlZm9yZSBhbm90aGVyDQo+PiBpYl9tb2RpZnlfcXAoKSBpcyBw
ZXJmb3JtZWQgdG8gdHJhbnNpdGlvbiB0aGUgUVAgdG8gdGhlIFJUUiBzdGF0ZS4NCj4gDQo+IFRo
aXMgbWFrZXMgbWUgcmVhbGx5IG5lcnZvdXMgdGhhdCBzb21ldGhpbmcgZGVwZW5kcyBvbiB0aGlz
IHNpbmNlIHRoZQ0KPiBBUEkgaXMgc3BsaXQgdXA/Pw0KDQpBcyBJIGNvbW1lbnRlZCB0byBNYXJr
LCBubyBVTFAgY3JlYXRlcyBhIGNvbm5lY3RlZCBRUCB3aXRoIHJkbWFfY3JlYXRlX3FwKCkgYW5k
IHRoZXJlYWZ0ZXIgbW9kaWZpZXMgaXQgd2l0aCBhbiBJTklUIC0+IElOSVQgdHJhbnNpdGlvbi4g
QW5kIGlmIGl0IGRpZCwgdGhlIHZhbHVlcyBtb2RpZmllZCB3b3VsZCBiZSBvdmVyd3JpdHRlbiBi
eSB0aGUgKG5vdykgUkVTRVQgLT4gSU5JVCB0cmFuc2l0aW9uIHdoZW4gY21hX21vZGlmeV9xcF9y
dHIoKSBpcyBjYWxsZWQuDQoNCg0KVGh4cywgSMOla29uDQoNCg==
