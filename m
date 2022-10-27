Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590B460EE57
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiJ0DLB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiJ0DK5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:10:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA28A98CF
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCXx9973qmWeNg+abz/5wn1yp2VxF4QaCzkapjsFe3TsbJVpM2MDzOzMx6N0JPXnzWT6EBYbsqgWA/fcAHBqN9yXWK1zkZP/3dRoc7WJavvu55aRbjkY1HwbmLa0dqhdcR/pIu2Nna+OQNM7BYQTCNgCupNkqAw6+d87i3dFl9MCyExC+Cm0RsO4QydLGYcP0bX97mutjLN7ATJfW+aFqFE8mR+Z0on354n/g092Zu9gheRHzXceTouOAGRKCA5ESiV/kYNj9G2VHxrClF0dHGicTvbFOYKRqW/d48JmhuruYCqO5I3KuoB465QR7ym0roJhdLZbmmOjJmILIhBcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG7KDpYvX6tBYl0DqS0bAm/8yEMY3+pS2qcE1pstBH0=;
 b=CgaJfXhTZ4O6scuP86YDm4ulFh+j9zHynZiGUEjMYGBwaafTcFZcncCL0/hCmFitjG669elHmJt5OC3Cjo/bHgTd/VMR5WTgD3Un2BJGYwzNKEJn+jKL09RGo+Kri3MbQRmKXbBSfijIYk4kdFkySHfR34JCYt1yHrXrjbhqycDgu7OPp1Jh9ans6lL/f2CdcvfHnHSjfnMwwusIHZWGPuqsiXEE9zUB+pcnBSVMSO9R9oNgjNCZs51BufNZmkJz8Ee79ct2/zJnd6BvkGBW2CtoRvrtaEBBYeB19aoKMNofbrGB0jdqOua4l9Agy7MeeRCwzpzMrepV4mfawqFkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG7KDpYvX6tBYl0DqS0bAm/8yEMY3+pS2qcE1pstBH0=;
 b=sVJfsiWmfBQaZRr38l+tAa84An21fC0HRbV6Fddtd8V3iBPalrruQRC28QLvjZmFyPgowhdsRE/Na8Np7USBlNxR0N9VcCBLpT0xow9wMI3BhJdcpirF8MwCkG7PQrjj23d2nysa4UPVETKdxdHnOv52yVIN7QRVmjP7MSOiznxWo7Fh2vq1LcmV2iSk4OV6T9JDOxvKKGoxmI2IzslVSVtjjcnXdd79To+EDBD/Z/BXNR5FlEP608BpZs3GVn1czwx3H4evmbxkjvUWlvFhxeJYxXt9MAvj6EwY4/hpdG+UW6KyYmpOrAygIu5L3oBi+zKqYll0KwMDnlxZQa3Png==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 03:10:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 03:10:54 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1A=
Date:   Thu, 27 Oct 2022 03:10:54 +0000
Message-ID: <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
In-Reply-To: <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4924:EE_
x-ms-office365-filtering-correlation-id: 66e3f77e-6f35-473c-4302-08dab7c8dc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYpCo81ggQRcSto8J3BTqKLRqwNSQq5LGnIAONP3NWhAX+Q59ZDvQwxN0cBUwXwN/v8pR+OhYtdg8TFCWHPHKAZLpfrbl5NQDhU4GdlaNdD9uwzSomuTpzNSAZ7ZBrNxMuZb3luJ4nR9ouEdYe3GnO0p1v0r3Ic+WydXJRROomy16Z+Uzj5fV4LrD24EA++NgYyjFUXwV03DKnRfdwI1/QEhdM8xCtJPmynug1VDfKodUAPzcI8A8EjzXNdijFmDYJktm3aSjt1wREgoTfBEwg+EI6n1Y/jub1ztEDWTYq29AQVuuAeF3Rw/CmfnUW0ovTPPbqsDTCmSVHlmcw/iY9g5dMAjNOQq3RydK4P+qfEUDpDS2BGP4wBdF3e0t23qx5UYvgH5KVVb2tfV6xs7KEFsv+byz5VUJf9t6gsJ4qP1/IXanJ1CCMuL1KswZh37AcKH+P0oyjz24pfNOo/c/gKDYPVCRi23YdZ8x5h7JwB8YTRTaKGGyjt7etcDFQVvVPfnJK7RdTVDfysG4bx/Hq0UnR0aw0TfGlaxQjIJGmz3BG4vlLigDYDcGa0Rim4oHFniNNy8gfYQH+d7Bv9NaJSbPzfyLIq4bFzIOjmhvgXPR9Ch2M0Ov7xYqHGLWBm7RcCvcCp0j2V8fDLc3Co90rm1Kdr5aLEr5lt9PpcHCkOUcmgL/loK0ob5nbn9uS1SS9+yuKFhrx2qr+Ek5wsDDGq/wOEXthJPlQcfTQvJ2yJtucWJkkchD/VHRoyddQocqZU7G93D6oKXoWj7PgDUQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(41300700001)(9686003)(2906002)(26005)(186003)(122000001)(38070700005)(38100700002)(52536014)(8936002)(5660300002)(76116006)(478600001)(55016003)(71200400001)(6506007)(86362001)(7696005)(66556008)(8676002)(64756008)(66946007)(66476007)(33656002)(316002)(110136005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXZiaTVJN2xFVHJNYkR2V1pLNXNpY2IwTEVxN205MkI4MGhCZXNYWVdlcnlw?=
 =?utf-8?B?ZEVLOVFIOVh6MHFzZDlpRTBUanNscWQ3dVBMWU5kSWhQRlZJaTN6MEVHZ3FN?=
 =?utf-8?B?Z1lzWmpUYnVwWno2TkdhcGw3WExqZDhITnJLUDJhajE4a3oxM2haTDZaeThm?=
 =?utf-8?B?czdzZmx3TjZXS2VNcVBBeXJJVmZRU243MWRQVVNURGpFdmxKSm9NUjdaTjlm?=
 =?utf-8?B?TkJzbmR1RS9hUmJQYmdiRk5mem0xUVo1SnhSMHNmVzZuMTJiaHppTjhhdC9N?=
 =?utf-8?B?eHFYMklweHlCRExZWjdZa2F4MHRTenJSWHB1Q24rOTB4TWVxU0N1VW5DSnJ5?=
 =?utf-8?B?azhBOExuaUdXM0F2dmF3TEloMkVObjFuRXFqOHlkRnFjN1JxMUQzSEdML0tD?=
 =?utf-8?B?eGZIdWZSVi9XU0dodVNrdWc2MC9wbW5MeGdldFJFaUFtMUVsVDBhWmIxQVh3?=
 =?utf-8?B?VEFFM0lEVWdKRzFqeGZWUHBXUmlrMEdabGlYbGVERkcrbksxeGJlcDF5cE9N?=
 =?utf-8?B?MWF0SWRvSExXZkR3RDVTaHM1RDlCdVBhZUNHRUpzdUx4S0g1VzhEZnlQRWVS?=
 =?utf-8?B?cnhTRVNWbm1qcFdGQVplY0ZZVENTYnR2TGdvNmtxdzhRSHpPUWxUODhPQzg0?=
 =?utf-8?B?eTBPRm9IVXhhdGpXVTRTTGdDeElLMXFPZ3IxNHo1cVI4bitEWkRMcElud2w5?=
 =?utf-8?B?dVdyalQrTHlJU2RGakVkMjVsVkxXVit5U1pSQ1JLWW43NlAycklicVVuL1JG?=
 =?utf-8?B?cTRNMDdZSTdsVWRZZktOeGhndUpXUElYcUFXOEFKMytKUWJ6VzJNMWJUejVJ?=
 =?utf-8?B?TU1JMzNGMlpMMW4yeC9wTXhsZnV1ZzRzcVBJZHIzT0NjR1VKMUZEZEJxOElZ?=
 =?utf-8?B?Mm9KWFlxNGlQNU9XemZlcjl2OUh0WnZQb1lSelFVY05xUHplbk9sVGg4WDJS?=
 =?utf-8?B?ako1emFSKzRyMWQ2amdtUloxaHh3blE3dXF3WDhBTHJaNWVnVnkydVE4MVJS?=
 =?utf-8?B?NlBOYllQT3FwY1BoL0k1cFN1RnhQNnNCc0lCanBZblBWZldlMkc3SmxoMmNI?=
 =?utf-8?B?VzNNUEF0aUE1WXJGSmdka3VZUitsZ1BDUkpuYTE3cXBJc1p6czBiblRwVHow?=
 =?utf-8?B?emRSQ1cydnFxZm04UG96d2hOUTF2Ym9tVUxKUk9lOExPUTd4citnd01DVmQ4?=
 =?utf-8?B?VnVlQTAyQ0JQQUhjWTBNd0g5alZ5c1lmWTlWUzZzTEpDNnh2dWNBSUZMZmxi?=
 =?utf-8?B?RkQwMWpSNUl1ZjdvVVNCVmFGSXA2MkFhdHdodkwxMFpySVFRam02YVhTRGpp?=
 =?utf-8?B?cmdpVTJTTHM0U3N2azkxQ0VMdkk1UG45T2lKdCtTVkQxT09FclRzUjZ0M0lk?=
 =?utf-8?B?RXZ1ZHNHZUVkV3BreE5mZjlNNVVwd1FyYzIxbHZmNCtpSHlkcE5vNFNvRlNI?=
 =?utf-8?B?RHRmQlc2OERtNGRLeW5vZGZ6UkErZkZOSVE0N0FNYk9mem9TaWJmRjJBT0hB?=
 =?utf-8?B?b1hjYytFYU0xMGxvUWVkWkpWTGlWZmxERHUvNW1Jem0zVVJLeGpEN29SeXMx?=
 =?utf-8?B?dzdpN3lpODlscWMyVStLM2l5bzgrOFlYdVh0TEFQeE4xRVo5RUwrV1ZpcmVp?=
 =?utf-8?B?ODN6Z1Z1K1dJZzI0SGh6aGZGV1FvUWRHUng3Ni9IQnhKMDZtUFlrKzJDTlVT?=
 =?utf-8?B?c1FsNEZlb25pMTdvVHhkdytYME92dSt3QnVGZEhpd3BJNStvdTFUaGNlc1J1?=
 =?utf-8?B?RVZkRG5zdlRYWUNnTVp4UUNWOXVMRW1sYmZLeG5qV0dpSXM1OEo1NFhIcFNE?=
 =?utf-8?B?YjhUM0poeDB1RzI1cUNTNDY4R25kR0xMdkI5TFZXS1g5bllHR3ZGSmlkYUxa?=
 =?utf-8?B?YTJmSi8rR2ZqTkllUVZINHpVZWkzSnpFamFxRENpRFM5anpHeXI5dlFhQVBz?=
 =?utf-8?B?UmpHSFRZYlZUMmQrVEI2c1NPYUFVUWNUVDlNT3dYczhwbzk2OE5UWld1blFs?=
 =?utf-8?B?aTJvRDdVc1NIYmxsb25yWEFhVXBHUjJVUjdITUZnTkVnZFhtMkU5aU1Ha3JY?=
 =?utf-8?B?UjUrclgrQW9OWjM1clIyQVlMbFdGYUo4T09iMUdhM2s0K2NIWHE4R3Qva2tz?=
 =?utf-8?Q?6kys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e3f77e-6f35-473c-4302-08dab7c8dc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:10:54.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2inVozApLwob2+z0fsHy9oJtB94bAqZLozK9sLDsvhjEm5et5yfBli0uzx1+wuUex8sDYTtGVBODWhX5iNLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAxMTowOCBQTQ0KPiANCj4gT2N0b2JlciAy
NywgMjAyMiAxMTowMSBBTSwgIlBhcmF2IFBhbmRpdCIgPHBhcmF2QG52aWRpYS5jb20+IHdyb3Rl
Og0KPiANCj4gPj4gRnJvbTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4NCj4g
Pj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDEwOjMxIFBNDQo+ID4+DQo+ID4+
IDIuIGVsc2Ugd2UgYXJlIGluDQo+ID4+IGV4Y2x1c2l2ZSBtb2RlLiBXaGVuIHRoZSBjb3JyZXNw
b25kaW5nIG5ldGRldmljZSBvZiB0aGUgUm9DRSBvciBpV2FycA0KPiA+PiBkZXZpY2UgaXMgbW92
ZWQgZnJvbSBvbmUgbmV0IG5hbWVzcGFjZSB0byBhbm90aGVyLCB3ZSBtb3ZlIHRoZSBSRE1BDQo+
ID4+IGRldmljZSBpbnRvIHRoYXQgbmV0IG5hbWVzcGFjZQ0KPiA+Pg0KPiA+PiBXaGF0IGRvIHlv
dSB0aGluayA/DQo+ID4NCj4gPiBOby4gb25lIGRldmljZSBpcyBub3Qgc3VwcG9zZWQgdG8gbW92
ZSBvdGhlciBkZXZpY2VzLg0KPiA+IEV2ZXJ5IGRldmljZSBpcyBpbmRlcGVuZGVudCB0aGF0IHNo
b3VsZCBiZSBtb3ZlZCBieSBleHBsaWNpdCBjb21tYW5kLg0KPiANCj4gQ2FuIHlvdSBzaG93IHVz
IHdoZXJlIHdlIGNhbiBmaW5kIHRoaXMgcnVsZSAiRXZlcnkgZGV2aWNlIGlzIGluZGVwZW5kZW50
DQo+IHRoYXQgc2hvdWxkIGJlIG1vdmVkIGJ5IGV4cGxpY2l0IGNvbW1hbmQuIj8NCj4gDQo+ID4N
Cj4gPiBBbHNvIGNoYW5nZXMgbGlrZSBhYm92ZSBicmVha3MgdGhlIGV4aXN0aW5nIG9yY2hlc3Ry
YXRpb24sIGl0IG5vLWdvLg0KPiANCj4gSW4gYSBSb0NFIGRldmljZSwgaWIgZGV2aWNlIGlzIHJl
bGF0ZWQgd2l0aCB0aGUgbmV0IGRldmljZS4gV2hlbiBhIG5ldCBkZXZpY2UNCj4gaXMgbW92ZWQg
dG8gYSBuZXcgbmV0IG5hbWVzcGFjZSwgaWYgdGhlIGliIGRldmljZSBpcyBub3QgaW4gdGhlIHNh
bWUgbmV0DQo+IGRldmljZSwgaG93IHRvIG1ha2UgaWIgZGV2aWNlIHdvcms/DQpSRE1BIGRldmlj
ZSBzaG91bGQgYWxzbyBiZSBtb3ZlZCB0byB0aGUgc2FtZSBuZXQgbmFtZXNwYWNlIGFzIHRoYXQg
b2YgbmV0ZGV2Lg0KDQpTdGVwcyBzaG91bGQgYmUsDQoNCiQgcmRtYSBzeXN0ZW0gc2V0IG5ldG5z
IGV4Y2x1c2l2ZQ0KJCBpcCBuZXRucyBhZGQgTlNOQU1FDQokIGlwIGxpbmsgc2V0IFtORVRERVZd
IG5ldG5zIE5TTkFNRQ0KJCByZG1hIGRldiBzZXQgWyBSRE1BX0RFViBdIG5ldG5zIE5TTkFNRQ0K
DQoNCg0K
