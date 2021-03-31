Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030C73505A3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhCaRjB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:39:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCaRid (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 13:38:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VHUPLw115005;
        Wed, 31 Mar 2021 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7LuNnzNbQovUM3KUIUJ6psiKW/b55941B0GlLDN35DA=;
 b=X5edR0QjquQnxkN7+mlj6qWk78lqdUCdKJgTt/qdVL5fn2huLYd2Gj5hZ8rdxHJrAaA5
 FbCBP2Ct15JqTfpjDmm7X2ZFbhAvNxZqv1p/AVMO8Mi2bOqZ9oq72UUm3PJGt4IDaeUM
 Le369GRSvxLVDaxKqFo9LeF5X2BnIgedLwBs+iB2Pq57/Ixdk6lCn2QVV6dLjqTUCPUH
 YRE2vCagjwQnhqktR7b4Hwegf40ZOtnWJcq7TSA+/s65n9RCCRHOX+ltPPHN2wQksNBI
 nvYMuGX2Ftx/JtC4nynjaWDgm/dVlhzuBoQ+mDHJH3LDV336hGAPVZfeainCkReIzJoZ rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mp06sjs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 17:38:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VHUsgw105060;
        Wed, 31 Mar 2021 17:38:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 37mac8xrrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 17:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+3/IEGAnlRw7K/hhdZ4FAhOblKHn84MV2JfyV9f5JY8kShOO5g3qN4hejpyGw4nSoztgXPU6pB6Lcv0BZwBBnN1lSj8RMeIrJAlFpf+1TKr7Sq0xy3AOHW/7LEjuVTy/00z0QnRVys6Y9WU4sWQ3BB6CcWVI+lASaEUs58ns1GdODrXPpyglIwTxRswc4AcXOAxr7UUfpE+5aRtIAgEvyuu4CE0cmbaOZL/b3OPYyLH1k0Y+Ox0HVyC9J9xxUSJk6k+HxgT8gvvEMrKqKhpvunNWy6/LadsmwYegqI8r3JBid6P+eHBynwL8csRGqbkZ0aJkYaeFpQNMMWTMWubQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LuNnzNbQovUM3KUIUJ6psiKW/b55941B0GlLDN35DA=;
 b=g2JsEUDbaCNhIeBVGTVP7GaWUEI9W7n4S9tbCsGcRFLbk4BMSnBzFs0ubYz3DJrm3qc0e/TerpNcXaXv2938080L/qz5PG0drmkPvxoXHGmekQ+6u8rZqsQg5x7VYmGn7WoQiSP8yg8a6hWEutimO5qIFqyPfxmyMo0nL9BGiyF3Qt67me6TP+sB+dAGIMmakp98SJYVoJkUO4bOgf8gT/6Ppbfv6IhL1mIdzVxN+JE78oIjvi1Ul2Y0Dn0M+t1DzACnpnTrMJA/PKhkW4b47KfUWoJlcKfCRiUKBsms0ZF0KCdCiRwJx9AYytyi0g2jtgDc62YiP6wZgCzZ1NInWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LuNnzNbQovUM3KUIUJ6psiKW/b55941B0GlLDN35DA=;
 b=oXKqQiYOUoIY/DzvjszTTwvRMulmLlhQh41vxHNyLhyuDb1jR1A5zwBd+XMS3nQHrnqrK78/FFEJtro4FEkdp3F678cw9m9/ZsrExJw4Q5+g5gUKiCRU9guvbHaLawLcbPnhc+5ePvk6ajrEF4wML6tJxD1joaGT7BWUx0s7l5c=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1829.namprd10.prod.outlook.com (2603:10b6:903:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 17:38:26 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 17:38:26 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Parav Pandit <parav@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKAgAAEsICAAAU4AIAAAFYAgAAUwYCAACcUgIAABzQAgAAA5QA=
Date:   Wed, 31 Mar 2021 17:38:26 +0000
Message-ID: <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210331173514.GO1463678@nvidia.com>
In-Reply-To: <20210331173514.GO1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 829de1fe-dda0-4396-b6ab-08d8f46bca77
x-ms-traffictypediagnostic: CY4PR10MB1829:
x-microsoft-antispam-prvs: <CY4PR10MB1829572147EC57676C54AF36FD7C9@CY4PR10MB1829.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7d7L1LJLi5uOie+O04z6zRDAR3trTZeNdCEfSVbNbEs9hI1z6mNo2fzhYeCHo8a33P35cF7iX91SDIsKVEvrmMqlCwKO+nlNcv2pPbIXuowJbYR6KM+1wkQn2MObr6PudAw+XHYYUJlQOc8fcze/rg/Xctm069fkTznZcibSD81aR0BB2zNKBQX4Dj0WTlnJjy0SdqsbNvsAT3oHIdn01wnnDelni/72B16PfScZJdUfh+Gew3moaP/a6x3cG+GnAJWE0adxK5MWUC8rLlSHYTXmpJDb0RnIIJbmlo9/uE8U18OAX2473DJUWsjI1sVJCIM2rvQNGgnNKNWKNOOw4WELQiMJBqQyKAEvOx7/nIhWY3oMI+OOa+HAsZGzch8f9HieH90Tl6Ot30ye+IsdnptDKT0NMYEDGq2cgCup2emGJwxRjAOfbr54ALnsVfSL7KHcZtJsxLZh0sa5OSKxkUbKaDg4Q7701+kLyOUgvPwvsA/9aCDclSMiXZ1lR4ZqmgDCvjFx0TINpiZp1ntIGJL9x/uGMJYwpsA9JnZYZEI1v1RNBS2o1YIQ0xdpVlaniCmiDniZ/jhS0Nf7ipOdkzDGHLLqLNm9IVb61cOWP+cturTcjFq2PXsJPvabLYzdKIOYYFcIMhmEkC6hVG00NegGRQFn5jT1mTj+nN9oOuuC6gF9j0A+KkKjGNFoEA9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(91956017)(38100700001)(8676002)(76116006)(33656002)(316002)(71200400001)(36756003)(6486002)(6916009)(2906002)(186003)(2616005)(44832011)(66946007)(54906003)(83380400001)(26005)(66556008)(66476007)(6512007)(66446008)(64756008)(478600001)(8936002)(5660300002)(4326008)(6506007)(53546011)(66574015)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a09KTm9WbFdRNlFaNUlLWnBKaTRrU1IvczlTMStXVlJGYzNzcEdZamVDUC9X?=
 =?utf-8?B?YW1qaVdhd1NVK3dieFRjQWNZcFM4RVRtQVY1VnIyMWRzUE1qL3pIU0VrczhV?=
 =?utf-8?B?aUc0R2JKQ0tJb0xpK2VCY0tPak8xcHBEdWZlaUlmNkhSeDdZdGFEdjFJZWxm?=
 =?utf-8?B?MkhDVTFKSEI3Mit5Nlg2aFBsZHB5Z2pTaXlHTGZoTldoeEV1cUJpRmg0dHZy?=
 =?utf-8?B?N3F0am9hdkw5bGlZM1Z3Y3Z4Ump5dURyem93NTZYU3hmd1htcWdxNWFvUlRS?=
 =?utf-8?B?ZnA0QUFjc1VqUGxEbEwzZVZzdXRzU0o5TGQ2clVxc0dMMzBQazQ0eWg2TGFP?=
 =?utf-8?B?cmVUcUVBQVZVdXozczVKVHZ2TjhuRW40ZDYyRzJTN3hyejA1bWQwa0tzUzYz?=
 =?utf-8?B?WTg2SzB3d3pIb1NlOHF1aHp1UHByRFJ1RUFPclpLejZrUHRLTnJEYW52Z0Ns?=
 =?utf-8?B?a0F3Q3N4c3A3QkVDcTg2QkhOTDNZR2Z2NnVVV1RtSEJEMGtOeWpzTExXajN5?=
 =?utf-8?B?dDF3N3FjVm1kZlRld251d2taNGRRTEhadHBHenh2QmhLY1lSUmh4Rklhc3or?=
 =?utf-8?B?clZqY3ptU0R1YjV0UDF6cUFDUDlydTh2WGRlUmJPTDdacGpLT3I0bzdGOCtE?=
 =?utf-8?B?VldyL2pEa0RValZaa3FvMDlpelVjL1pITDNWcVFoL2FpWXhFR2doN1JjdjI3?=
 =?utf-8?B?YzBvc1hxUXNXcEFVK20xSzdwWDgvTFdoajhhYTIvb25sRS94dWhYSnlXcWIr?=
 =?utf-8?B?cGx1Zm82QmZzQjl2eEY0Zld5OXVDNlJkbXJiT2FNcG1NL0tudjYwL05YeDl4?=
 =?utf-8?B?cFp2MlB5bjNYNTh5QkJBSGVSVDlpZjIwTDZZRk9tTVJqREhWUnNlZElnWHlX?=
 =?utf-8?B?anVQQmRXS1NkMWExS2h5NzRJTE1MMW0vMmRMYURxNlNGOGttQS9XUDJkNkdx?=
 =?utf-8?B?UnNQYmVlN1pyOWZBazNQQVhVNnBuUi95c0FsUlNGY3A0TVEvWThnZklrSWww?=
 =?utf-8?B?N2tyN3Q2YnhDQXNpWDNIZnVvN0Qxc0Rpakt0Q0dhYkZEcFdMYVRxaDBzNVpr?=
 =?utf-8?B?NTNZdENlT29hYTFHbzFFVWFBMXZ1ZFZHVGNlUGo1NXYzTW5Da1hXaVduVEZD?=
 =?utf-8?B?U0Vmd2I3MmpncnlJNkRWVUJsZG9FanByNVZlcGkxbEVQQVhMbWYyZWN1ZVhp?=
 =?utf-8?B?SnN5aktWVnRycDVIR3RTdkxsMG0wNVJ2cmpYdm5ra2Z6UDZub1BNbUkyQWQ0?=
 =?utf-8?B?Y0tvYk1salN6c2YxTU8zdVF5c3NUd05tdnZlTGtvMmp1MG5XZUo5amJqNDJD?=
 =?utf-8?B?R0VKRitwYS96aU0wK2YzdnRUcng1RFVhL05sa2xxSzU5T05KcTdZMTA1MTg3?=
 =?utf-8?B?bXNQWWxwMHZqbnhqdHN3R1dreWpiK0ZXbTg4Tmh3Tmt6bVBoTDdoaXJRSk1S?=
 =?utf-8?B?M2xScmJaUkpwUEVOS3kyekZIcTA1MHlSUUtudytaMGxDdjg3ay83aXZhWUxa?=
 =?utf-8?B?YU9EZzR1TUlVL0Y2OTVWSlpkaDlvdlhJbEJQeVArUUoxdWFPczhoeTJVVlFW?=
 =?utf-8?B?SGhITllCa3NlM1p1SENZS2dzTm1KVTNNcS9OcDIvcGpFRE8rK3pXNVFrREwr?=
 =?utf-8?B?Y0llcnRXVTNmMmVCTGVxVlNNakl2YlFBV1VpMzY3Q0hqa0tYM2sxa3lEczhQ?=
 =?utf-8?B?OVh3VHNPMmN4VG9DamlMUGhaSmE2L0tUVnJ6SmdCV1dFb2JPSmEya2lCOXhU?=
 =?utf-8?B?dkVyUDFOdHVOQkV0VFF5eGphSlRXai9lTkJ6cnhhOTQ1TFR6ODZ5Szh1UWQw?=
 =?utf-8?B?QlRPdEZtb2swd3NuRUh2UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B314F1359BC9840A51081D320337A13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829de1fe-dda0-4396-b6ab-08d8f46bca77
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 17:38:26.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+E96bXVt4vY/cJRtu5wPLXP3uZ00f++pGqvmU3p6s7q44yCkjtNa2YNfL/mJFhZCpBVxbj/6wAxbX49zAG+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1829
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310121
X-Proofpoint-ORIG-GUID: umk-X2TQ0SHpjM_QHBNBm9L-2NfojIC0
X-Proofpoint-GUID: umk-X2TQ0SHpjM_QHBNBm9L-2NfojIC0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310121
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE5OjM1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDA1OjA5OjI3UE0g
KzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gRnJvbTogSGFha29uIEJ1
Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNo
IDMxLCAyMDIxIDg6MjAgUE0NCj4+PiANCj4+Pj4gT24gMzEgTWFyIDIwMjEsIGF0IDE1OjM1LCBK
YXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIFdl
ZCwgTWFyIDMxLCAyMDIxIGF0IDAxOjM0OjA2UE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToN
Cj4+Pj4gDQo+Pj4+Pj4gQWN0dWFsbHkgSSBiZXQgeW91IGNvdWxkIGRvIHRoaXMgc2FtZSB0aGlu
ZyBlbnRpcmVseSBpbiB1c2Vyc3BhY2UgYnkNCj4+Pj4+PiBhZGp1c3RpbmcgcmRtYV9pbml0X3Fw
X2F0dHIoKSB0byBjb3B5IHRoZSBkYXRhIHRoYXQgd291bGQgYmUgc3RvcmVkDQo+Pj4+Pj4gaW4g
dGhlIGNtX2lkLi4gPz8NCj4+Pj4+IA0KPj4+Pj4gVGhpcyB3aWxsIGRlZmluaXRlbHkgbm90IHNv
bHZlIHRoZSBpc3N1ZSBmb3Iga2VybmVsIFVMUCwgZS5nLiwgUkRTLg0KPj4+PiANCj4+Pj4gU3Vy
ZSwgdGhhdCBtYWtlcyBzZW5zZSB0byBoYXZlIHNvbWUgcmRtYWNtIGFwaSBpbi1rZXJuZWwgb25s
eQ0KPj4+IA0KPj4+IExldCBtZSBzZW5kIGEgdjIgZG9pbmcgb25seSB0aGF0Lg0KPj4+IA0KPj4+
Pj4gRnVydGhlciwgd2h5IGRvIHdlIGhhdmUgcmRtYV9zZXRfb3B0aW9uKCkgd2l0aCBvcHRpb24N
Cj4+PiBSRE1BX09QVElPTl9JRF9BQ0tfVElNRU9VVCA/DQo+Pj4+IA0KPj4+PiBJdCBtYXkgaGF2
ZSBiZWVuIGEgbWlzdGFrZSB0byBkbyBpdCBsaWtlIHRoYXQNCj4+PiANCj4+IFRpbWVvdXQgdmFs
dWUgZ29lcyBpbiB0aGUgQ00gcmVxdWVzdCBtZXNzYWdlIHNvIHNldHRpbmcgaXQgdGhyb3VnaA0K
Pj4gdGhlIGNtX2lkIG9iamVjdCB3YXMgbGlrZWx5IGNvcnJlY3QuICBUaGlzIHJlZmxlY3RzIGlu
dG8gY20gbXNnIGFzDQo+PiB3ZWxsIGFzIGluIHRoZSBRUCBvZiB0aGUgY21faWQuDQo+IA0KPiBB
aCwgeWVzIGlmIGl0IGdvZXMgaW4gdGhlIHdpcmUgaW4gYSBDTSBtZXNzYWdlIGl0IGhhcyB0byBn
byB0byB0aGUNCj4ga2VybmVsLg0KDQpCdXQgZG9lcyBpdCBnbyBvbiB0aGUgd2lyZT8gTm8uIFRo
ZSBSTlIgUmV0cnkgdGltZXIgaXMgbm90IHBhcnQgb2YgdGhlIG5lZ290aWF0aW9uIHdpdGggdGhl
IHBlZXIuDQoNCkjDpWtvbg0KDQo+IA0KPiBKYXNvbg0KDQo=
