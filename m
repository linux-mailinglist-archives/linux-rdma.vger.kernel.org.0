Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566133502B4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhCaOuP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 10:50:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhCaOtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 10:49:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VEdlGC060375;
        Wed, 31 Mar 2021 14:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=md94XJEg0C0Oz2Y+17BZidC61wXgy1iejvvRURI5hVM=;
 b=rsja2soViKq8Vak98no5y3MVbgdfhQPj6xcheYDzPlbwQBpRK08Bt8xnHDhgk66vLeUu
 15g2a8Lq8vOKbl9xEObHJvlSeM8FCZSVhYXUh1D/90GslIAlc9r1be0C0+sg/YesjZWm
 RupIDdDZyjdU4nJlvacYCmftwtCraRzJiVH9Jnl5GnRyEpSGXQpldDSj9ZYorvvgoaIZ
 VZUDordNAF27St9bNWF5kCm75N704H5WexBCFgo4z4yGndzcaUoD7n4sgaLscV2eIJYs
 Cbs4VasJV73YAXWU4uUoHTHLOuf6DZejb36/1jvxCikeQkBruDJLCvq7lNMcn6ovllLN Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37mabqth1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:49:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VEesRe175022;
        Wed, 31 Mar 2021 14:49:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 37mac8rtm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 14:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1VplO6vvidUurzszBpilQerluimEQqXDzfnCWNM3jW5ViK0Qs1Llfwzt3t9pW0n8LDZbH+TC5gT/LC8GdRmh6AA22AwggvLpNvKa8a6F0L+FGbXUAfj/2OSqz0BFv0nUf9pm/r+VWpHE5mKKFAoRlByDRMAstD0EehvDmKIcEXyZF5FnrWY0mpDT7kONmZdX95LNBexSYo1gKdLWtGbH5PQIrWeAR2ZSoQdQtudD6/SdNvVJRi+RX/P4+RXZdVHFn5lQ5P6BYn6RWiQnR0ZUoSn6+8Xj5C/Ta5uWq6/gCies5SGRpqKuiyWpWMMybdPEC4ZNZQ15QpaE24BJmdIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md94XJEg0C0Oz2Y+17BZidC61wXgy1iejvvRURI5hVM=;
 b=bofFvfOOHyn8mV+acE06NIE8vibSpEniNdJikgxvsX8IkCPPOQeY0oFShzwylzHhsDlFRAGEKociygxXonwW3d2U5nys/I4cpcO2X5vR3MRfxcsFZztbMDZSK8k2JEk2aHcm4MKZiqgny5TQQv3mZxy8UVxFUUOti7vopm8KNVxUTGowTBwZqQgD4hgJ24vIBnRZ3LL5cDckBJYB/XXc+IYgQ0+T6IjcYCecQDM8lr9nlrkhpQB5Ey3OYdQJ6PXnFVKImu0JxeTIYxG1gnZSi3/TVrtOG4zl19VUFfaKwRoas83FfZWud5DTYhFvzwVYzmn9UKPLvAql6pNgGQehQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md94XJEg0C0Oz2Y+17BZidC61wXgy1iejvvRURI5hVM=;
 b=nyjVLcjA40liXeUveNE8eoCgZYFr3cNn4S6UnDTFVkR+GmgGUsbza4XCy5rYtuiXGwa67G+pMK62ObBe//uyy7WqUBj6l+DCwU0gTCYph+KdsSe3gRlnNxm2ubYW5iFzInEIc12xtLX1f9FuqAsJYJutVUFYMixVnN1G2cqsiTY=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1303.namprd10.prod.outlook.com (2603:10b6:903:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 14:49:36 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 14:49:36 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKAgAAEsICAAAU4AIAAAFYAgAAUwYA=
Date:   Wed, 31 Mar 2021 14:49:36 +0000
Message-ID: <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
In-Reply-To: <20210331133518.GJ1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b2fa48-0977-4dda-7277-08d8f454348b
x-ms-traffictypediagnostic: CY4PR10MB1303:
x-microsoft-antispam-prvs: <CY4PR10MB1303AD0A7B0725DEE861C18DFD7C9@CY4PR10MB1303.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: og8+myvUKevliH6mr38lzSP4n+OZVy21XahX8z2jEpXJ7jaICNpAu+TrDDCmv7mK5DR5z53PT1irC8BbonGIhqzjqDhR1SrpaZfCDrMMiUZvu4dQIHww0XyGtbXRDmgLdApPSn4+stook5HIc1P5PCoWm7mJa81v+x1+QbrEVEE3NSHM7suChNLvln7Dpf2rS9CPgoOXzr7df6Kg3+x7uoFzHnrSHktQjmEH5jJ97Oc91Po5O+5Td6a/2gAUjhE2Ov657m1ifyuSGZWKG7/qv8ErT1yZFAtsluxKq7Nw/I+a6dHcaUrIUkhv1E+CgwjDno4U/lhvHv3OODZ1h5jrzQnUZrdj/MEpG27XQHIYYoRRTj/8VO6jl2/WhimoM9rpCcDxXqrzTChiX4tBMhMREYAXFT85MMZWD94XvCSjgK7kzkYQsitA2GW/eyelR3XKn8QdaIiZatL+H+tz2ff6gxl1SwaIhLRZcOqBF9IBpZqG1ZVkVq5VLoynaGJnm6qOsZsSDqMd5D/ZnjmIL6AKc0MuMPFN8MOhwSSGLtZJcY3o0qo5Cxssska1h0XXTT7IQv6q2u22vd/pbQjgp5yD9OIMOsQw8jo6ZnVxRv8MGnswqYuKIidbtSwQE0EQvD9llYsWP+w+Q9UK/nLWfZQ1WlAtg7S6xicJzEhto2eeuIBqoBhkUGWdJXXm30Knmx5n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(8936002)(86362001)(44832011)(76116006)(6512007)(4744005)(5660300002)(6916009)(38100700001)(2616005)(478600001)(4326008)(91956017)(6506007)(316002)(33656002)(53546011)(54906003)(66446008)(66946007)(66556008)(66476007)(64756008)(2906002)(26005)(36756003)(8676002)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0FxNGNtN1ZMY0FWM3lTRm5BdU1qUHJWSFUyUFRGUUxRdWpnUWZvTDl2cmRB?=
 =?utf-8?B?dmRMcnQzbG80VUFrWFJvRnVWelJUaVhOSlNQMXNueUcrREFvdldBaUxEUHhy?=
 =?utf-8?B?TUozR0pONHc3QWVMWEdwcXNHMlFHOUF4SVVrcUUzRkNyTjlvSVNKZEdwaXlK?=
 =?utf-8?B?aGkvckJNUmJDN01nNllJUmVkTk1DRVA5cjRTZWJtYkZ3Tld3OHpIVUVSdEo2?=
 =?utf-8?B?eERTS0VnTDY2a1AzQncxYklvYlliVVJLbmxlbVNIT2JkT0p3QVFxalE2Mlhp?=
 =?utf-8?B?YmN3YTZLbE1MdWxWVlJRdE0vNldqenB4TDRVbCtDbXNOZUE1V1JKT3VnUWFm?=
 =?utf-8?B?K0x6dkhqbHRnSC9meVFjY1lFTkN1MWJickZKUGhSZjZpR2liam5Eb2UxZXR4?=
 =?utf-8?B?VjZrYWtTOC9idkl6NTNxcUwvTGg1RCt1ODh5K1Q3Q0l0a09MeTdYUlVKd1M2?=
 =?utf-8?B?VE9vTjcvNS9RQmZXUys5b0xHS1pFY0RFR2M1RmNsbXhDUU5mMWR0ZW02OThY?=
 =?utf-8?B?OFE2SnE2NXFUNnlDRGdQU2pSeE1adk9wbkdvazRaRk52Zzg3bkQvWDdKbi9N?=
 =?utf-8?B?ZVNQK3VaWDNnTkVSaEk0MTVJcExoMVpRMk8vd3dnclA1MTNsSGZRQU10Nlpj?=
 =?utf-8?B?NFFQT2hRM0JXSFJQQW5CeHFxM1dTeE9kZk9PSWxCMnhUYy9paE5wZWt0RXc5?=
 =?utf-8?B?NlltejlKYUNqMDhDZ2pZdUxHa0xYVTE1NFYvLzVxZy9MZVZDWUdPSk81WjJa?=
 =?utf-8?B?K0g5TG0vMFBMOUlkS3MzTWw5NmhmSXhZRk12dWxzVjhKd0tHbHhWSXpxTU43?=
 =?utf-8?B?dGp5aEdYU2pMTmJUdWlwVFQ1WHMvSEE5NkVvUlRKMHNseExlbkFMdURuTHZn?=
 =?utf-8?B?V0ptUkkrWWplRnA1N0RSdjVzRUlqVnB0dlAxa3kvd09MN2FncHVJS2dGUzZa?=
 =?utf-8?B?ZXVDQXJmbHZoT3pzQ3haZVRWRmg2a3laa05oMG51MlUzU1hzOEM3OEVqZHQ2?=
 =?utf-8?B?SmdseGI5NkZDZUtFU1J1TllVNXJJTEI2UklEWG1zajFod2dKVGhrRERoNWhY?=
 =?utf-8?B?cU0yZUxQSDhFRG9rR3hvdW9kc3pOb29ETm9VMnIxNUdwMHJjMnhHMTYyWG9B?=
 =?utf-8?B?a0s2MllHZ2RVVUVNSjdKWnp4MGZXSGJua1dERGZUSnppTUpZc2treDl3SVB5?=
 =?utf-8?B?aUVPaU1kZTZqMHRLZjJPL0ZmZEVUUktqenlxL3RLdVhocDh0ckVEM1NCZ2hB?=
 =?utf-8?B?MXdPTGtxcXlQckFLUi9lSUZ5MFFqSUtEelhRQ3BrbUUvSldPcXA0V04wOEdC?=
 =?utf-8?B?VjdzY1V3VkpOemROd09mSnZ2azh1cFMxYlJwczJ0RUtHbUlvY2pvRVJPRERK?=
 =?utf-8?B?VGdNa1Fvalh4eTNlM2JPR2ljTzdwMkZsNHVsUzJabFBENXNzelVacUNlcEtU?=
 =?utf-8?B?cVBENDd2aSs4bEVwcExXT1kwRGFZcm9Ma1F4ejEyY0xySVM3bUFLbldiM0Za?=
 =?utf-8?B?elRRai9WMTlYRmZLZk1qaE9xN3NkT0ovOGxWV2xFc2FBcnM0ZmxSb0t4aUVM?=
 =?utf-8?B?QkdMbkRldFA0UGhQRkNFSXdTVVpJYlk3LzN3SHkxWXZ2T05YNDRNRkV3UHJs?=
 =?utf-8?B?VXhpY3BlTHFWb0NqOEovTlJNOHIzbUxrM1ZtWHZPK0U1OUV0SGhyZk1uZlMx?=
 =?utf-8?B?TC9Wb1Z5U2x0dU9UdnduVlczblpyZGI3RGNWK2FPbXNja0xCVFdtWnJvUVRw?=
 =?utf-8?B?WXM2ckhNV1grZ2JPL1lVVU4xdmJ4SFpETXk1T2dmM3FWUSt0WlEwKzNWUitE?=
 =?utf-8?B?S242ejVmWUpKdnM4bi9tdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <11FEEE30DC85564FBAC4C5DB0265358E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b2fa48-0977-4dda-7277-08d8f454348b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 14:49:36.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zamxvl96/lc/aapyDaSzfyHjwEci3RJ1wtl51J624Pq3b83PzKJt448d27tuFcuUOpOeEFb0HL/imq4pfarbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310106
X-Proofpoint-ORIG-GUID: TaMhcHKyK-KgIAficExuB4F4LH2s1Xd9
X-Proofpoint-GUID: TaMhcHKyK-KgIAficExuB4F4LH2s1Xd9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE1OjM1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDAxOjM0OjA2UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4gDQo+Pj4gQWN0dWFsbHkgSSBiZXQgeW91IGNv
dWxkIGRvIHRoaXMgc2FtZSB0aGluZyBlbnRpcmVseSBpbiB1c2Vyc3BhY2UgYnkNCj4+PiBhZGp1
c3RpbmcgcmRtYV9pbml0X3FwX2F0dHIoKSB0byBjb3B5IHRoZSBkYXRhIHRoYXQgd291bGQgYmUg
c3RvcmVkIGluDQo+Pj4gdGhlIGNtX2lkLi4gPz8NCj4+IA0KPj4gVGhpcyB3aWxsIGRlZmluaXRl
bHkgbm90IHNvbHZlIHRoZSBpc3N1ZSBmb3Iga2VybmVsIFVMUCwgZS5nLiwgUkRTLiANCj4gDQo+
IFN1cmUsIHRoYXQgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBzb21lIHJkbWFjbSBhcGkgaW4ta2VybmVs
IG9ubHkNCg0KTGV0IG1lIHNlbmQgYSB2MiBkb2luZyBvbmx5IHRoYXQuDQoNCj4+IEZ1cnRoZXIs
IHdoeSBkbyB3ZSBoYXZlIHJkbWFfc2V0X29wdGlvbigpIHdpdGggb3B0aW9uIFJETUFfT1BUSU9O
X0lEX0FDS19USU1FT1VUID8NCj4gDQo+IEl0IG1heSBoYXZlIGJlZW4gYSBtaXN0YWtlIHRvIGRv
IGl0IGxpa2UgdGhhdA0KDQpJIHNlZSB3aGF0IHlvdSBhcmUgc2F5aW5nLiBJZiBpZF9wcml2IGlu
IHVzZXIgc3BhY2Ugd2FzIGF1Z21lbnRlZCB3aXRoIHRpbWVvdXRfc2V0LCB0aW1lb3V0LCBybnJf
cmV0cnlfdGltZXJfc2V0LCBhbmQgcm5yX3JldHJ5X3RpbWUgYW5kIGNvcnJlc3BvbmRpbmcgcmRt
YV9zZXRfe2Fja190aW1lb3V0LHJucl9yZXRyeV90aW1lcn0gZnVuY3Rpb25zLCB1c2Ugc2FpZCBp
bmZvcm1hdGlvbiBpbiB1Y21hX21vZGlmeV9xcF9ydHIoKSBhbmQgdWNtYV9tb2RpZnlfcXBfcnRz
KCksIGl0IHdpbGwgYmUgYSB1c2VyLXNwYWNlIGdhbWUgb25seS4NCg0KDQpIw6Vrb24=
