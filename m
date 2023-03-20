Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557836C1319
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjCTNTg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjCTNTR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 09:19:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C81B338
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 06:18:50 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KDCDGk008963
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 13:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=fyp1xyXmEqwonN41ySTWg2njdSWojvkIwLe/F82GIhI=;
 b=JKikTdETvUJJZY/z28lfa+87WBaKfL2deq+y86DyDqH5hmvwPS4Sd5MjfFiDSxU9D5t/
 9sG2Cp1Flla9qoH+g9Ajpa4v0AsgjhZNK0POx/+9swUsAmt91jCdfxQFQCT0uFTzWXkt
 HKN3wLZrMYCT938BJ45n2RqjLmOqjBqPb7TsXM0T1lld3fJnSzbjNYm/VXzD+CbzDk9X
 uwFekIngZpkrXkYDWjOVHhfDPhrV62KEvsx3uj7cGU9oTGuvn/r3dT0GAcH4+hbUhKQe
 bwzFk+Yxv4eiP+ykBvzt8bYD45IPn+rbixCKyoGTbqLN5SQZe8fWGyeETUddRad7cSay /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3per5hr6ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 13:18:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32KDD9AC014599
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 13:18:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3per5hr6f9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 13:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMYP2oca9TP7YKSN7ONzGWh7bRpNYBWoScQqY0mDxOuJuD8o+xFNWVPNkHtO9IbxylG5EU0vbeg7LQWwRTE6Re0hon80aPO51Ae8dCCSrRNhhIh7flZRIZEDoQUeK1oNnLpjT2nA1hLW3JB/uq6XjZzWncO4McQycdBBgFw/JK4OZCyNz5Ordy1MsxFHnN1kIRCyQmUooj4ew9nz8+P3Vo5cnS0f3Z0Z0OVrHAYBGG4eKzwl4GUS6SiP/RmDCX3xQuSCk9akp6/MmZxy0d4YYmVWqszemGC4o57R22guOF7PxZqUXEJkjumpmuJML3rdKKHQcZXBCYPEMxdzFygE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyp1xyXmEqwonN41ySTWg2njdSWojvkIwLe/F82GIhI=;
 b=Q1vbL9bxfjHk77s8jv/4gBBud5yU+P8eK8HA43iUD7V79X95Ml1IsvZJIsX4j2Ihevr0du9Fy+5QPq54RkRIQZ9CLYEtSRjKOuN5qEM1pqI+ywUeLdNr9apESqr68YRDyBuCwVBXsvFn6xnHlD1a0dzlvNSfe1a6cSaGIbS8/CdPglKnv4znkKrTtDc3F6Y16b66yqokMQICF6VPIWMw3DTd+p9ch7UAj/GYy608sV6yjiQ4ERyUV8+2XFdAJSmmkAtdSp10NbthW8NoRbw0WQu90Uh77wiCRGxy/g7ZF6XKmTv1l1xf3SGlet3On2fLaeAn6KmzdvdQVTBU5ibmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by MW3PR15MB3932.namprd15.prod.outlook.com (2603:10b6:303:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:18:41 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:18:37 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     David Howells <dhowells@redhat.com>
CC:     David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
Thread-Index: AQHZWxxfewgZ8p+FCUuQ0QJVgyZJH68Dl2NAgAAN4gCAAABSEA==
Date:   Mon, 20 Mar 2023 13:18:36 +0000
Message-ID: <SA0PR15MB3919386FFE75212C8B315C6C99809@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <SA0PR15MB3919CF7A2996702BEB68E3F799809@SA0PR15MB3919.namprd15.prod.outlook.com>
 <SA0PR15MB3919A01D3E69110345ED0EC799809@SA0PR15MB3919.namprd15.prod.outlook.com>
 <20230316152618.711970-1-dhowells@redhat.com>
 <20230316152618.711970-9-dhowells@redhat.com>
 <1716675.1679310535@warthog.procyon.org.uk>
 <1833343.1679318002@warthog.procyon.org.uk>
In-Reply-To: <1833343.1679318002@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|MW3PR15MB3932:EE_
x-ms-office365-filtering-correlation-id: 6f4d8c27-e6f0-4a84-e90d-08db29459d28
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LViEyTwyveRiTIBgpfC/7JfAjEz4MHLVN5IsXUMA/xp1xx+NyjIz4718mIy3V5hhFZ4apVljqCQvg0R5JqZsLB0V8JG55u+zV6ZVGZ5hEN27OI/1JQvVNuxZQr9anziPWD7XTqoGBRfBQZbVEv/ic80Qmp+EfQdSKt6J3hGbKNui7+fyEpqjl4h+wBrgEH+LWb3wjl+rUl+6PWyOEZexsSr/hEp061Za5Ac2AfKkdru53WCnzfRfyHNU1QJeMqkuJaxUjO+NsTxLE/CXq4oEk0WfMJERekQ7G58LGHqvB8BGSaw7oMv+oK5FU06naQYo1Jan+wDVP7Qe4+7alJkUDiUNb5bZTgw/D7YESnEBNSPajHf/5sNMxqbZlVNpwqAmR2y4yOoD7i+d5tp8HAvB07S/nm8THt4v60mdRsDUcT7gaph2VHwha7oHPK9wjQ0xuINgbqJVQ3LSu/Dgb+IZNx0u7Q0glfOW1WKviJo83BaA+5Ck6c5ZCtGn08WxeQR/FZoqnlzn4NRKCYhgr7UFHM6Ol5EYH0+S96YqZAWLLsuwRsNdv3Dq72eSXvwK18iHILT51tTgHCzLjaRJtf8PR4eDyUOlfjl9sEqoh3y4Pw7AJENHUM3Wcl2ec6uZEmTi2b6t0Tz5BRDM/iv+GR5GmElc7mchNl9fzYGR7Ydn7zw30f5Z/yWgPrpHiDEHMoNSXIDH64TS083DD83c2TQ+9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(54906003)(64756008)(66946007)(76116006)(66476007)(66446008)(478600001)(66556008)(6916009)(41300700001)(8936002)(52536014)(5660300002)(8676002)(33656002)(4326008)(38070700005)(86362001)(7696005)(316002)(6506007)(186003)(53546011)(55016003)(122000001)(9686003)(2906002)(38100700002)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZKNURNeXVveFlzU094VERtYUF6NU9HSjFxQnFyMlNGMmFZemRZYm1SZlBC?=
 =?utf-8?B?bzFBY2VHZmg1MjhhdnpjZXlmUFpBTXplVC9laE5JMmcxK3pqdFpWVCt1ZStS?=
 =?utf-8?B?dmdqNlp1ejR0WTB0eXgrKzFYV0lheTNJdTd4SitVekF5NW5VZ1d0djlEbU9E?=
 =?utf-8?B?Z1BWdXlDVGx3dG9OLytrL0RZd1p2NnBWZnN5enFkRWEyNDNxdW5jaGNsU2M5?=
 =?utf-8?B?UmhraXhpc2pSOXhyWGtpMXRNbjJjLzBoa3hLM3g0UThyRkl2UWxpcHc1U0hj?=
 =?utf-8?B?eC9iaVRTcVdReVNyRVRNbjZjNWFORml2b0cxUTgxalIwQ2FYcENrcDZMbWlv?=
 =?utf-8?B?QmtkSTZGbGxlenE0SjdHek1jLzE0YzgrQ1o2cEhUV1RSTFZKemcwQ05PK1ND?=
 =?utf-8?B?R1oyVHVVcUswbXJHTEdQbS9RcytVaERBeXI1T1QxU1pmMDV5ZXBUZGVlSW1u?=
 =?utf-8?B?cGxRR2ZYUHAva2NjdURnZ0NwTzV0NTlZOFZ6eGxtUkdTeXhHVkRPUEsrS2tR?=
 =?utf-8?B?aEhLdjJEY2R4aFlNbUxaZFVOMlVOUDVaMXpkZ3h1d0JhZ2lWRUducHpya1l3?=
 =?utf-8?B?bnFZMFozclhBU0RsclY3NzEzUjI3TC8wQ0RqbEJlOVU4QW44VU1zWGwzdWJv?=
 =?utf-8?B?MWc1SzcyeUI4TUt1c016ZnYwc1RTVzJVSnFxWWp2NGpQTzRhWC84ZUYySVFV?=
 =?utf-8?B?elRoTTJzR0ZUOVJVSGRhVnd0ZWF6Mk1FSE53NnhBZzBodVR1YTJrV1FMb1J1?=
 =?utf-8?B?TnRPeFFFOStLSjViYmFyOUpVbzNTQkdQMzhSN0JSTUwyK1RMQUQ3SDBCa2pu?=
 =?utf-8?B?S1Y3emp4dkJKYkFnSmwzOVB3NERyeVdLdVovYWFGSTc1WHNhTUR2Q0ZCRFRu?=
 =?utf-8?B?aUxscWFhK3VYQnlLS1EveWpEZWR1QUt0RENaTC9xeEFjdnF1R2RPZkRCM2hx?=
 =?utf-8?B?Y2NYWVJtNjJobGNEdGJMY1c4MWo1VC9uL1ZjNDh0N1RINmFVbVlTallrQXRX?=
 =?utf-8?B?YldJWnFoeVFNblBFcGN4aW1zRDUzenBYTjlvWUU3bWxJbnlkZDFwbVhrdGwx?=
 =?utf-8?B?VEl1cHp1MmhvTUFCWEl6NGVSQi94UTVKd2t1UEV4aFliZVZ4ZDV3Z0xGTTdL?=
 =?utf-8?B?NkxnQldTa3FwVkl3MUJ3NytHR0d3MHhvVTlRSTdKM0FnYkg3dHVZMkxQVHhW?=
 =?utf-8?B?N0pFOVdrT0ppWjBRM0JUYmZBOXNJbUsxUDZudjk1ZERaNXA3VERlbzNNWG5V?=
 =?utf-8?B?Rmo5NUdsVUlUWnl1TjdicVQ4bHhIL09obFdzVXFVQmhlaGZLTzlyRmNSQTVl?=
 =?utf-8?B?SlRXaTc4SkF0dXhZVmM5c1NPWEVpeGR0TEMrQVlROSt5eW00ZXlWWExTbjNw?=
 =?utf-8?B?SmdZMlZ0dis3b0grczY3Wnppa3p2UXJ1N045SUpvNjhIRElOWWJNUmZOamxX?=
 =?utf-8?B?ZFdYVEFYUDdCL3UrcEM3ZzBmczdaQXI5S0hCWXR5R0gzVGt3SThTOU1TbEVs?=
 =?utf-8?B?dmQrOXlQT2UrZmFQYUZaWDdZWEt5cDMya2FOczRJa1I5cHZvTFVxZndkZzht?=
 =?utf-8?B?S0JzQUxsQ0diOGRwbkhLSk1oNTZERlFOWlQvckE4ZERqZXkwWGRQVHRLS1dm?=
 =?utf-8?B?QkxucEdvTXJDTmxCbWFGSVZTNXhVWHpQdUY2K1VpaEZxOXBSUFJ2YXBvU053?=
 =?utf-8?B?eGw2TU1UekgrRVVwTFRZelFhVHdjTHczeW5FWGFFQTZvdjFuVDNuRDRqS0h6?=
 =?utf-8?B?Q1RvNjRoTVM4Q2lvRGhyaUI4K3EycGIwc29oemtlQm1OeWdrZVQvTHluSkZp?=
 =?utf-8?B?dkhKNWlEYnhXemlCbytDK3c1WjY3a0ZOL0RwQ1hHYXdONWdkMEpDRmRSaS9q?=
 =?utf-8?B?dFh6UnBnOFpUeXRSeEhjVlFIWHhpV1BERkdrb1RVeWtWeUUxVkk1aFdyVC9X?=
 =?utf-8?B?cGVlUWVmbkU5OW1RcGR4cW5zVVhzem14YkdxN1RvUzhBQ3p3bGhCZlhVQXRZ?=
 =?utf-8?B?SXRyYTNuU1JndDRsdUZoVnY4aGJLeDVCd2laQjJ1UktWOHVIbVF5My8xMlBn?=
 =?utf-8?B?OXp2elZjamxYZWZTOGFWZVlFU3p3TWlKSFk1cmp3Q0NGTHVzZHVoMjg2c0Ir?=
 =?utf-8?B?MEsyRHRNWE5iSE9xc0pEa2MxTlZ0NHpIR01YVXFZYzZLYytqNU00YTRJeVc1?=
 =?utf-8?Q?cQ5/i/a60IevNtHhtnUrxVY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4d8c27-e6f0-4a84-e90d-08db29459d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 13:18:36.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVPiOdgvW59WKcJcoge2w5Cuyao9PoVJ+5CuvMUrKJUUcPE1kv8asd45AMGpftyCCQLGOkn8nmG6UWKOirc5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3932
X-Proofpoint-ORIG-GUID: 7gQhv5ydhquhqiXybxqWq4JTDqI7kSkC
X-Proofpoint-GUID: jKRrLZDdGmMu87k0BSbbtTZ4jvUR8i3Q
Subject: RE: [RFC PATCH 08/28] siw: Inline do_tcp_sendpages()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_08,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=414 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSG93ZWxscyA8
ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCAyMCBNYXJjaCAyMDIzIDE0OjEz
DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IERhdmlk
IEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+OyBUb20gVGFscGV5IDx0b21AdGFscGV5LmNv
bT47DQo+IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtSRkMgUEFUQ0ggMDgvMjhdIHNpdzogSW5saW5lIGRvX3RjcF9zZW5kcGFnZXMoKQ0KPiAN
Cj4gQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+IHdyb3RlOg0KPiANCj4gPiA+
ID4gQmFjayBpbiB0aGUgZGF5cywgSSBpbnRyb2R1Y2VkIHRoYXQgemNvcHkgcGF0aCBmb3IgZWZm
aWNpZW5jeQ0KPiA+ID4gPiByZWFzb25zIC0gZ2V0dGluZyBib3RoIGJldHRlciB0aHJvdWdocHV0
IGFuZCBsZXNzIENQVSBsb2FkLg0KPiA+ID4gPiBJIGxvb2tlZCBhdCBib3RoIFdSSVRFIGFuZCBS
RUFEIHBlcmZvcm1hbmNlLiBVc2luZw0KPiA+ID4gPiBkb190Y3Bfc2VuZHBhZ2VzKCkgaXMgY3Vy
cmVudGx5IGxpbWl0ZWQgdG8gcHJvY2Vzc2luZyB3b3JrDQo+ID4gPiA+IHdoaWNoIGlzIG5vdCBy
ZWdpc3RlcmVkIHdpdGggbG9jYWwgY29tcGxldGlvbiBnZW5lcmF0aW9uLg0KPiA+ID4gPiBSZXBs
eWluZyB0byBhIHJlbW90ZSBSRUFEIHJlcXVlc3QgaXMgYSB0eXBpY2FsIGNhc2UuIERpZA0KPiA+
ID4gPiB5b3UgY2hlY2sgd2l0aCBSRUFEPw0KPiA+ID4NCj4gPiA+IEFoIC0geW91J3JlIHRhbGtp
bmcgYWJvdXQga3NtYmQgdGhlcmU/ICBJIGhhdmVuJ3QgdGVzdGVkIHRoZSBwYXRjaCB3aXRoDQo+
ID4gPiB0aGF0Lg0KPiA+DQo+ID4gRGlkIHlvdSB0ZXN0IHdpdGggYm90aCBrZXJuZWwgVUxQcyBh
bmQgdXNlciBsZXZlbCBhcHBsaWNhdGlvbnM/DQo+IA0KPiBLZXJuZWwgIlVMUHMiPw0KDQpJIHdh
cyB0cnlpbmcgdG8gcmVmZXIgdG8ga2VybmVsIGFwcGxpY2F0aW9ucyBvciBjbGllbnRzIG9yDQp1
cHBlciBsYXllciBwcm90b2NvbHMgKHVscCwgbGlrZSBuZnMpLg0KDQo+IA0KPiBBcyBmYXIgYXMg
Y2lmcyBnb2VzLCBJJ3ZlIHRlc3RlZCB0aGUgZnMgd2l0aCBsYXJnZSBkZCBjb21tYW5kcyBmb3Ig
dGhlDQo+IG1vbWVudCwNCj4gYnV0IHRoYXQncyBhbGwuICBUaGlzIHBvc3Qgd2FzIG1vcmUgdG8g
ZmluZCBvdXQgaG93IGF0dGFjaGVkIHBlb3BsZSB3ZXJlIHRvDQo+IC0+c2VuZHBhZ2UoKSBhbmQg
dG8gc2VlIGlmIGFueW9uZSBoYWQgYW55IHByZWZlcmVuY2VzIG9uIGEgY291cGxlIG9mIHRoaW5n
cw0KPiBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIG5vdGUuICBUaGlzIGlzbid0IGFpbWVkIGF0IHRo
ZSBuZXh0IG1lcmdlIHdpbmRvdy4NCg0KSSBsaWtlIHlvdXIgcGF0Y2hlcyB0byBzaXcgYSBsb3Qs
IHNpbmNlIGl0IHdvdWxkIHNpZ25pZmljYW50bHkNCnNpbXBsaWZ5IHRoZSB0cmFuc21pdCBjb2Rl
IHBhdGguDQoNClRoYW5rIHlvdSwNCkJlcm5hcmQuDQoNCj4gDQo+IERhdmlkDQoNCg==
