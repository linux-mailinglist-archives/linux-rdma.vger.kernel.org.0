Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1C6E0DF7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDMNFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDMNFM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 09:05:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB071704
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 06:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYxN0p2LLXZnzAO0AmeAmaishvsHFw69TZKLrY1o7o4uKQ9DRd25s5l4LiPEZYFrj+0gCI1jRkkBzdYW0KTMKP5USyMTvf6ViRPnXWoeXazMUji9qMBFZB9QIukazGaWLn6XPEIrGk0Qh3tsMPI27+/AeJMBXUaaeIIMlTEKJKPH86UZ1HX2PgwNgJmhsL7sG2pNR9strB2igK2ly+dUSZ4q81um09KjZ1+Zaxd7fRXJflOY9lY/oXkpqaC8x2mMSI7Ovrng278zoF+VYHOZtaQIjXIqUZEuLAKmyhIJP0ELkqZljEDhacNLvuy8tiYkRDp52fc/j3tNO2vmixrIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sityJQkVvc9oIsrZzchONJTlBOcUDfUEatOcvt9jGVw=;
 b=ZMF5eG7qMffAIcC1FriX/wMhmhC19q6rovnlIfH8vBH+zcSaEzrVf0r3Phq6T3Ps6+VNkLzlMv0woASXa2Z2aKKhwntJaly4yNtsAVncXSNncVyZMXgJO5AaqsVeWU5pr/VdHnWlK4BdXCy94b6A8NW7maMh5GzQpbV6mc5oMkF0RU2hnrrfUiOUv879WWJ0uvIVmjk+BBGSErXsSS3rTnXFuHjlZLWJ3dAgv1Q8nCuMeC9FxaJ23KrdHT9a/b+BTYr2wQJPQU+QpLBlPgCT9ILYcGBnkyxOvoWDjor17ETkJRlkESxPny4Q/RbSmTKr6GF2fvRwpgKCsLQiJz3aYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sityJQkVvc9oIsrZzchONJTlBOcUDfUEatOcvt9jGVw=;
 b=kBBZl/DkdFBfIu1xz0kFUos4kUBJeChZWSDR8s3JXAMX+Xkp8qT29omFAeeIfjJF9dKNtvDwYsHvrJMxY/5ylysFED3OtwxjDbBwQ2C1Yqj2nFEaoKgizc1qvutz8CJEGTqr5OVXBcIZO6Yx7MnxFkP6lMTsPi4Dlq2N4ElYQxIDsAw47Y+xcEh5/n7fcn9GAZeC2WsGttMF1xTmHTc2wh6sLtAEmG8vuRRHstvPT3leyhLnOk9J0faEim3AvGZVIKcTCWDEE95lP54HP483ztGjCkYqSdpJw8zXV3mxiwWjRNOv9jEbYKFpOvOgsHOT9NsMGet2Jxc2GMeRkPvftQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 13:05:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 13:05:08 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Mark Lehrer <lehrer@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
CC:     Zhu Yanjun <yanjun.zhu@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Topic: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Index: AQHZQDq78euIxrtulEiTJiby3UJy1a8oRlKAgAA9FwCAAK1xAIAAXqEAgAAARcA=
Date:   Thu, 13 Apr 2023 13:05:08 +0000
Message-ID: <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
In-Reply-To: <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB8023:EE_
x-ms-office365-filtering-correlation-id: 626de79f-9055-47bd-4c22-08db3c1fb560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDMzWbb5N3074ICDtBu4F5WILEm9ng5ky4pNgbeGmj7Ok/2xEIPTiCIVCvems9R09wizAVaHLS2a49eUE8L0FappAhnQddC8wa0eDEDeOrnASvKUpgcjfmtH30NtSLqz90bef6VFfvO5JO5R1WTBO85YPxSDOs4z2WcMoKv1xLfQAejmcBZG7+jcJGV2N7Y6ln0aV8r7UujyiJkRdOklFZM2Iad58VPQds6Tmx4EnToqy8Q1DNyYSSnIdFvfjn4pwkfY8itNb1mqOBKR5WoBZRPoFKJetf8dUs67qZVQMn57qiOD5mv7YKPqkKg7zWD0En5a3OemQ35WwsZq978wRpYZi+NdXDiijszVaDo/jUAOk1op6YAxAlFiSr3eDLOWnQy0CbEPzV1Ltjenhsk/8xDO5caDUYla1PU4yI8iwoizlq7B/L9GXjZpME68SsLuH64XScLc9bZ9Il+bqO3m+OP2F8lCV3p+Q47kiY/sM194zsxg94/84A2Ov8Pr+j5Afb7eyRg87+AXhJOvRR/KhMFuE1FeNMHAM5ZJCTp1+7HuD06L7/WA4ZzkTVmjomaPXmsMJARCHxOrvBmMEEt9jbv9bA/AxBa7jyfrLyU/BzsT9R9z3qwC79nZ1wJaVoOG3dbDOqayKrAfPokheYilN/Z75yYUzP0RoAamUVQuUK/NDLOgrbUkJ9f4DQZxe8kQ2WsPjj88LpJX6C3Sk351Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(26005)(8676002)(186003)(8936002)(38100700002)(6506007)(53546011)(9686003)(478600001)(316002)(33656002)(54906003)(86362001)(76116006)(66946007)(110136005)(64756008)(4326008)(66556008)(7696005)(66476007)(66446008)(71200400001)(966005)(55016003)(41300700001)(122000001)(83380400001)(38070700005)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vlh0MzQ4UHRpMlZNWTI4KzVja1gwMVMwYXlNMzVMUFdhNmVCcXRnMTMwTldX?=
 =?utf-8?B?TENhNGJDZDhLM3dwN3dZdGtRVGQrcXdnNCt2ZUJDNGg2MWw3dFlmQ2tCVXdZ?=
 =?utf-8?B?Mm9EQ3FNODJUQnNSS1RwWGRwdnp4NnlrR25WMmJUR1dRa04vN3ZSMGJEd3NV?=
 =?utf-8?B?NU52R3lnSDZpNGw3YThySHYvem9MTlBSQlFacEozQkEwcVhIbkVhSU9pSlZw?=
 =?utf-8?B?VnkvZVJmY1N6Q1g4bVdsQURlZmNMbmRwcS96Sm53TndlYzArQUlFOC85ekpV?=
 =?utf-8?B?MCtXaEMyTVJVOTErNnpEQnNZb0h3QmRXUGo1em9mL2VrOGFOblhtSEViY3lQ?=
 =?utf-8?B?OHlSaEgxbEJrZHU3citJRjZmYjgyQk0wYmFpelpqamZVMjRuS2p1QW92T3Nw?=
 =?utf-8?B?OXZmYkNocmRHMFh1YklOSUMzUS83bzUwZHVOLzMxclhRYTVySmVRUHZqZjhr?=
 =?utf-8?B?ZDVJdk03N2tveVJDejRkLytQdEsrWlA2dEdwbzNWd0Z2UjE1VTdXU0FpOU1X?=
 =?utf-8?B?djFFc1Y1MTZidE4xNHl3bHg4akhveW9TRGdsNkRDa3djQlN4UEtBNmRDVGo4?=
 =?utf-8?B?QkFtQUQyM1ZuYy90ams2SVBrZ1ozMFpuTEJMclJsc2Q1am5wVEp4djVMN3RM?=
 =?utf-8?B?OFhyNjB0T1M3eDQvL1pNTWdObUxSRkFobG1reXkycU51YmdFYVN5Q25VMVpE?=
 =?utf-8?B?Sytia09mdm5pckpvYkNRazVScnBXdXZMeFU1WVB4UGpZY0ErUjR5TXY1YWNh?=
 =?utf-8?B?bjZTaC9vT1VrTmgyU0ZyVFlKeHlORFRMSE0yYzFzeG1UTnNVMTZ3aW8wMXhG?=
 =?utf-8?B?cVJFSlN5cy9FMU9xenVsUHRqZTJQNXYzU2pEanhKa2hNc3FaOW5IRUFDbG9D?=
 =?utf-8?B?aDluS0d2dUJCNEdaeTNUTGFRdE9Mc1kydzlBUENiOWFOclU1SCtFK04yNXho?=
 =?utf-8?B?N2k5OGhJUFdEM1dKQ0k4bUsrdUZhbTM1MmU1b2NlT3pyOHp3cjR0amNJeDgx?=
 =?utf-8?B?L2o0VmQvK2V5NHU0SXRHWlRVc2hETmFBSDI1amwveUlLenlWTG1EYmtqYUdQ?=
 =?utf-8?B?Z0hQTWxPSDhRYm1zdi9BNWtONUJSRXRZc01rWWtRdDk1WkY2MlBhd0ZRVitk?=
 =?utf-8?B?V3RHSjlldm52azY4cHVVaWFrWm9xQWtPZENuRHBSWm5RMzU0NkgzMGpPYVFL?=
 =?utf-8?B?bDZTeVhiek0xaml3cisxNHhCanE3YkZCVXI2VndKSVF2WTBHYzB6UzVLRUI4?=
 =?utf-8?B?MHNsZG9zTkN1eVBSamZDNVRRWUFTdi9jQVI3bWgrc1lOTWJzNldFMnV6N2Jt?=
 =?utf-8?B?N2EzRjdKdm1BVEhPbjIrVmllcVJVdVZHOEo5aFVFb1JNTVJpNjZ6WVhzalB6?=
 =?utf-8?B?MW5RM0I4V2YzbW9ZQnJBc2tyL2lndGdoWUIvREJXcnBpK1pZenBrQ3hZbnRT?=
 =?utf-8?B?Q2E1a1BHSXNoOFZaRHBPeStaR09OWXVPSmxhRzRmUFJMeXZFaGJ3NmpIRjBu?=
 =?utf-8?B?Q2lGUlpvdjZVVjV6MkVVK1lETHNVMmpDZzNQUktrSkpVYXBXcXlCaE5WQUpK?=
 =?utf-8?B?NEY1bWE2Z3BJQ1VmTTVFeVJRVFZZSWNYZE5WeXpBRmY3UTRkSWdKZlU3QTBp?=
 =?utf-8?B?TzkxdXR2TWExa2hOMEFwWllxaDdrREplUklMbTJpOEI3Sk1ja25sZHN3ZU16?=
 =?utf-8?B?VTZTOFc4dWRnNmtjak91WnlUMFVBMm5TdUxMWUswejcxZ1lKRGRLcXpSY2tn?=
 =?utf-8?B?RVR6OFplTU9MTGU1Q0ZnSmhXZG1qcVpzeDF5L3F5QXFPd24rV0ZIQXFEZGJV?=
 =?utf-8?B?QUNsT0IvQm5taDVaalJtb1MrKzUyeVBOOXdiYXlJQnhSYlFmZDBNUU5jaUtM?=
 =?utf-8?B?dndGVDJlcVNjTldHZWdNL0dwcHFGVEZzSnNDWHFDOUJ0a2hNSGZwZWFxKyt5?=
 =?utf-8?B?OWRENjhlTkxieFE2NTFDQTVPeXV5S0svNjBaTS9oVzEzWFhQc3FxQmFCWmg5?=
 =?utf-8?B?bHhrbWNhRlhPbmZMdmN4RjZ5T3U0dW82SGcveGduY0pRQmNjYzExMzN6bVJk?=
 =?utf-8?B?Y2ZHTGJrUlZTbXBBRzNyZVNwRzdPemlxSjF2TWVuWkQvaStaazVsVU9aZVh3?=
 =?utf-8?Q?K70c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626de79f-9055-47bd-4c22-08db3c1fb560
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 13:05:08.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88r3HR/nDW+qRM6mxgYYoen3ILacbaV+syIYti4iEDJs45OxS71pe0r4K9GXX9WNVzqRNTorfpBH8O4n2OnDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogTWFyayBMZWhyZXIgPGxlaHJlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxMywgMjAyMyA5OjAxIEFNDQo+IA0KPiA+IERvIHlvdSBtYWtlIHRlc3RzIG52
bWUgKyBtbHg1ICsgbmV0IG5zIGluIHlvdXIgaG9zdD8gQ2FuIGl0IHdvcms/DQo+IA0KPiBTb3J0
IG9mLCBidXQgbm90IHJlYWxseS4gIEluIG91ciBsYXN0IHRlc3QsIHdlIGNvbmZpZ3VyZWQgYSB2
aXJ0dWFsIGZ1bmN0aW9uIGFuZCBwdXQNCj4gaXQgaW4gdGhlIG5ldG5zIGNvbnRleHQsIGJ1dCBh
bHNvIGNvbmZpZ3VyZWQgYSBwaHlzaWNhbCBmdW5jdGlvbiBvdXRzaWRlIHRoZSBuZXRucw0KPiBj
b250ZXh0LiAgVENQIE5WTWUgY29ubmVjdGlvbnMgYWx3YXlzIHVzZWQgdGhlIGNvcnJlY3QgaW50
ZXJmYWNlLg0KPiANCkRpZG7igJl0IGdldCBhIGNoYW5jZSB0byByZXZpZXcgdGhlIHRocmVhZCBk
aXNjdXNzaW9uLg0KVGhlIHdheSB0byB1c2UgVkYgaXM6DQoNCjEuIHJkbWEgc3lzdGVtIGluIGV4
Y2x1c2l2ZSBtb2RlDQokIHJkbWEgc3lzdGVtIHNldCBuZXRucyBleGNsdXNpdmUNCg0KMi4gTW92
ZSBuZXRkZXZpY2Ugb2YgdGhlIFZGIHRvIHRoZSBuZXQgbnMNCiQgaXAgbGluayBzZXQgWyBERVYg
XSBuZXRucyBOU05BTUUNCg0KMy4gTW92ZSBSRE1BIGRldmljZSBvZiB0aGUgVkYgdG8gdGhlIG5l
dCBucw0KJCByZG1hIGRldiBzZXQgWyBERVYgXSBuZXRucyBOU05BTUUNCg0KWW91IGFyZSBwcm9i
YWJseSBtaXNzaW5nICMxIGFuZCAjMyBjb25maWd1cmF0aW9uLg0KIzEgc2hvdWxkIGJlIGRvbmUg
YmVmb3JlIGNyZWF0aW5nIGFueSBuYW1lc3BhY2VzLg0KDQpNYW4gcGFnZXMgZm9yICMxIGFuZCAj
MzoNClthXSBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW44L3JkbWEtc3lzdGVt
LjguaHRtbA0KW2JdIGh0dHBzOi8vbWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjgvcmRtYS1k
ZXYuOC5odG1sDQoNCj4gSG93ZXZlciwgdGhlIFJvQ0V2MiBOVk1lIGNvbm5lY3Rpb24gYWx3YXlz
IHVzZWQgdGhlIHBoeXNpY2FsIGZ1bmN0aW9uLA0KPiByZWdhcmRsZXNzIG9mIHRoZSB1c2VyIHNw
YWNlIG5ldG5zIGNvbnRleHQgb2YgdGhlIG52bWUtY2xpIHByb2Nlc3MuDQo+IFdoZW4gd2UgcmFu
ICJpcCBsaW5rIHNldCA8cGh5c2ljYWwgZnVuY3Rpb24+IGRvd24iIHRoZSBSb0NFdjIgTlZNZQ0K
PiBjb25uZWN0aW9ucyBzdG9wcGVkIHdvcmtpbmcsIGJ1dCBUQ1AgTlZNZSBjb25uZWN0aW9ucyB3
ZXJlIGZpbmUuDQo+IFdlJ2xsIGJlIGRvaW5nIG1vcmUgdGVzdHMgdG9kYXkgdG8gbWFrZSBzdXJl
IHdlJ3JlIG5vdCBkb2luZyBzb21ldGhpbmcNCj4gd3JvbmcuDQo+IA0KPiBUaGFua3MsDQo+IE1h
cmsNCj4gDQo+IA0KPiANCj4gDQo+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDc6MjLigK9BTSBa
aHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IOWc
qCAyMDIzLzQvMTMgNTowMSwgTWFyayBMZWhyZXIg5YaZ6YGTOg0KPiA+ID4+IHRoZSBmYWJyaWNz
IGRldmljZSBhbmQgd3JpdGluZyB0aGUgaG9zdCBOUU4gZXRjLiAgSXMgdGhlcmUgYW4gZWFzeQ0K
PiA+ID4+IHdheSB0byBwcm92ZSB0aGF0IHJkbWFfcmVzb2x2ZV9hZGRyIGlzIHdvcmtpbmcgZnJv
bSB1c2VybGFuZD8NCj4gPiA+IEFjdHVhbGx5IEkgbWVhbnQgImlzIHRoZXJlIGEgd2F5IHRvIHBy
b3ZlIHRoYXQgdGhlIGtlcm5lbA0KPiA+ID4gcmRtYV9yZXNvbHZlX2FkZHIoKSB3b3JrcyB3aXRo
IG5ldG5zPyINCj4gPg0KPiA+IEkgdGhpbmsgcmRtYV9yZXNvbHZlX2FkZHIgY2FuIHdvcmsgd2l0
aCBuZXRucyBiZWNhdXNlIHJkbWEgb24gbWx4NSBjYW4NCj4gPiB3b3JrIHdlbGwgd2l0aCBuZXRu
cy4NCj4gPg0KPiA+IEkgZG8gbm90IGRlbHZlIGludG8gdGhlIHNvdXJjZSBjb2RlLiBCdXQgSU1P
LCB0aGlzIGZ1bmN0aW9uIHNob3VsZCBiZQ0KPiA+IHVzZWQgaW4gcmRtYSBvbiBtbHg1Lg0KPiA+
DQo+ID4gPg0KPiA+ID4gSXQgc2VlbXMgbGlrZSB0aGlzIGlzIHRoZSByZWFsIHByb2JsZW0uICBJ
ZiB3ZSBydW4gY29tbWFuZHMgbGlrZQ0KPiA+ID4gbnZtZSBkaXNjb3ZlciAmIG52bWUgY29ubmVj
dCB3aXRoaW4gdGhlIG5ldG5zIGNvbnRleHQsIHRoZSBzeXN0ZW0NCj4gPiA+IHdpbGwgdXNlIHRo
ZSBub24tbmV0bnMgSVAgJiBSRE1BIHN0YWNrcyB0byBjb25uZWN0LiAgQXMgYW4gYXNpZGUgLQ0K
PiA+ID4gdGhpcyBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIGEgbWFqb3Igc2VjdXJpdHkgaXNzdWUg
Zm9yIGNvbnRhaW5lcg0KPiA+ID4gc3lzdGVtcywgZG9lc24ndCBpdD8NCj4gPg0KPiA+IERvIHlv
dSBtYWtlIHRlc3RzIG52bWUgKyBtbHg1ICsgbmV0IG5zIGluIHlvdXIgaG9zdD8gQ2FuIGl0IHdv
cms/DQo+ID4NCj4gPiBUaGFua3MNCj4gPg0KPiA+IFpodSBZYW5qdW4NCj4gPg0KPiA+ID4NCj4g
PiA+IEknbGwgaW52ZXN0aWdhdGUgdG8gc2VlIGlmIHRoZSBmYWJyaWNzIG1vZHVsZSAmIG52bWUt
Y2xpIGhhdmUgYSB3YXkNCj4gPiA+IHRvIHNldCBhbmQgdXNlIHRoZSBwcm9wZXIgbmV0bnMgY29u
dGV4dC4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBNYXJrDQo=
