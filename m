Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0E60EED0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiJ0DsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiJ0DsU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:48:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A8A8378
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js5U6XtoeG1/3fLw4zOZzhym8UdVDMTBR+ifYcEGof55+rZ8roN6wOOdmIqxk5b+Y6Fg5J/HkTZKahZz19b7SK2PTeIQKC78oezwmafeHyK4uGngdRoDbuWjD8zMV2eNWccvjTfpoYelWCsH1SJC0/PLSqYpC2uRW1nXAVRVOyGMn+mQkA9TFSeIcvPSVHwJM7YEo7jLWQuD3L1H4FZkvGW/FRmO61+tsLnLW3x7vogHM9MZXFj08qx2AGHwNsPsH5ppNB4uzL8nbkPqiRVneQKJVZPZfkH7vPfGIrO1BNIdgiuje7mOmkcl4H4TFBogtQBVa3eyz7f2ePh8uo0PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXjUw5iAUOiWZv9far0haZ4VD8ZN2ONp5A3plRz8u/0=;
 b=HXPtYhQm7j69iC+qc/zCORAzogfAOTYaNdK8J8KsoorrLwbpRbBFHDe6jdYEq3zmiWaHZXr4II6KE6HThFTbQJMGnO48u1ywNlYtk4joE/aKm7+yoUgtjLfsRzMud67DJf9UIxTpNSDq4KNKGImidn/9EXV9wDvrKZOyt/DtEE2FqZfBrvoYkpx96sFT/6lgba1OxKisQmMfaGafgrx5YzWjdgSq9Vd9Fmv/0JbRFS/k8uqGleXy598ROPlTur7zy6vQ8Loo4R2Ig/iTwchC0n0z6YM+R0cYUGJVFZ6Uk9qwkaU447dH3CkUIwtxXIOxFk3tEnMZ4WRVbqQBsUCPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXjUw5iAUOiWZv9far0haZ4VD8ZN2ONp5A3plRz8u/0=;
 b=BpRDMEoZJ2uAy+/NCg1Z+I+/Bn4s3GXlfXfucCT78oq3HZ3xCoSMBYLEWP82J7Q4cLawwOgdP6PGm+KzFdpS6NDCSMtwkQk/exn4DlEQgZt4VSVFprbjD86UygkYjnXq6dcP0LlLkERgN7pLRkfLlx+gdg7P0a1iig5yycEGVcOn/TrovqLMJyu8xrF/5ZHVU71MK/PFiNVpvFSWkxnbkJUtqx/azdwg5Fyg6HFjh2YU72nCM7/LNQwRTpGZFh6CIboBMuHJ/W2GBzaeGikx9VjY8diDL2fRj4vsLM/DLhCz8+S7rtlGgQeAGxBVbtA9LDMEuz/rEaDAGWBAnW/fwg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 03:48:18 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 03:48:18 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1CAAAKNAIAAAC4AgAAF6oCAAAAm4A==
Date:   Thu, 27 Oct 2022 03:48:18 +0000
Message-ID: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
 <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
In-Reply-To: <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7952:EE_
x-ms-office365-filtering-correlation-id: 5e3fc29e-80b9-4ebc-e471-08dab7ce15ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQAke6UyaB8BMwuT5xbi+l4VE1oC3hFyeJzhA0ctHTOfqVhu6pQMP+8vt+ZZM0vWrrG2CCfgLZSfHI8ic/fj/ZhT6OaCpMKqvQO3A/cglfJgfN48ITLBvksEquBggYwANJKcA5sQ3iZCkA9k1/IRFTN33z+7Zgoiw2u2bdyxdL7rbi5Gf55wqrElz3IVo35b2r3syAsLfxpePdqesXjQU7B3Ngujc0ZmJeaECJueTkw/xutVvtCcUyZkMuSgkcj471nGlnMC/lipYIvWOXH7qfPn4jDQd1XJ3tkMs4XjUAcotKUuar4pjwwf/mJluxyEA7fBMKcDs37FR7jpWyKwVt0fW2C/u+p2gZ3tjHV74vHalz71UoToO6mRHdeuq/SVtqrywPkrXcIYsmNROgaQ3qUDSTRsw4rnorMFRvWTBsTd7MYOa12I8jsEy6sHJ+n2Wuf1ltOuLOAdochnyeaFymULCujBgN7gMkSTM0Ie8U671/DyWbjfENwZ5aJmLP+I5QImS9JODritblhnWaTQ+S1JNIXJ8fgieDeUjFDOIgF+n6RiI0RXnNf64xOG9HVXju3kHRjW6vI3sUKrHDG1l4eG5Ahi8nv9k11VrIAQ3z5OyCsEPbrpcs/rcf3CQwtGzCqGVjXdxp0epi2IN09MD2aMYC3NCP7S1zQf3yGaPikkeCGdIqP+FV1RnbFCvznnlHRaO3kvM08C+/dT5pATg82q60wM7LeR/O8ZyB0sa80REOg0Rp+ARa/KgHOq7BnihjL7uRxIkiqrZnBkf8JyZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(64756008)(122000001)(86362001)(66446008)(41300700001)(33656002)(478600001)(38070700005)(186003)(66946007)(316002)(9686003)(38100700002)(2906002)(8936002)(76116006)(52536014)(8676002)(26005)(66476007)(7696005)(5660300002)(66556008)(6506007)(71200400001)(110136005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NhaUVManh2SGVJcmtTMDNneVVZbVpsV011ajROUUlSTS9wRFR2ZERRUTlE?=
 =?utf-8?B?U05RTE5ZS1FCcWJvL1F0emJua3QxbUE3VitMakRDbkZhNXcrTVVXeWF5WFlM?=
 =?utf-8?B?bVF6WTMwMUtrUFRobmNpc3lZcVlsT3NrQkx0bjRiQTAwdzU0dCt1a0JHek9Q?=
 =?utf-8?B?Z0RHWldnbWRIczB5MlFyNnFDUFBUMFdPUDlsSzMyVEY4RG5BUW5wUGw1N0J5?=
 =?utf-8?B?K2ZmaEExWGc0aU5EVGJzaDh0UWZGT2wxQTlQTGtCTW1BTFUzNkQ2N0pmZE0w?=
 =?utf-8?B?eG4vM0pHMVJpMmR5VE5zYzJaSFhvM0prRVR0RThEeTVIS0xnVjlVMWl3M1gz?=
 =?utf-8?B?WWtvQ0ZZODdPZXJrV2IydEp1d3F4TU1GMnFFRW45QVdEWWd1N0ZrdUtBeDJt?=
 =?utf-8?B?ZTF3MGxOcVlZRmpXMVlsZnd4RjlMTVpIOU5vMTd3U0Ryd3VYeDNpTCtZUWtt?=
 =?utf-8?B?emtCMXkvTTAwdXRwVTAxTkhZNmw2OStIZ1V3S1lieW01cXgvdDhhNzFjcGxM?=
 =?utf-8?B?eVVNd2pQWWVkL0pzWWhLU2Y0eFRJY1IrdDIrekU0dFZ2amFKOW95TXFkZ1Fr?=
 =?utf-8?B?UXJyVVJvWFFzamllTlMrd3BWT0MvekI4MnRlUEVsc0xFNjJWZzNIc2JkV0Fy?=
 =?utf-8?B?VmtMSld0QkdTaXA5bXBVdm41eG82eWFDRmh1WURGNE1SbTI2VGFhc0lRNjdL?=
 =?utf-8?B?dkhDVWVCczU0TjlNL29tUUZKTVhESkhialZ1MDJ0Tk5jMXh6VTMzSFRESjlW?=
 =?utf-8?B?bFpTZUhrWGJwcnhMT0ZORCs5czJuTXdhNzVkdmlJeCtIanNDd01vZ0pic1px?=
 =?utf-8?B?WUxWWTZvcVR2ZmxZTkNJdGR4T2JlT1V4NUtCUUtPVEdzSmt0THMzSWRiRm4v?=
 =?utf-8?B?aXdUUEphTDdrMzJ6MGxadmRIanNzNGZCaVB5OXJRQVYwa0R1T2xuSXpTRnA4?=
 =?utf-8?B?NFVHZTdsbzFUMmlZbnFPV2czeGdFdW5mRHZITUM1RlRkOVVsUy90TmlyUE5o?=
 =?utf-8?B?aFk3MTRtLy9QTHZHQlNxVEo1UWtvb2hQYmgxTUJoanpNbEFYMHFEemdCNWlN?=
 =?utf-8?B?bEZ5RFBnRkJJbHpXdnBRQk1pVi9ReHZuU1R0SDMrcWxrcnU4YldCa3dvdUQv?=
 =?utf-8?B?L3BybjFCS3VhOW94NDJEaHJIN0NVcDBuV3FjSDllZ2N3QlA3NGQwMlRuQUpW?=
 =?utf-8?B?SkZCSjFzVjZLb0Viamp6bmlBUFM4d2EyVlZrenhjamtUV1BjU3V5QUdBcTFJ?=
 =?utf-8?B?VUNja0xaWFJDdm00RFhlWVpKdFoyTllLenJmckVJbllrY2FQUi9KdWg2Q1Rq?=
 =?utf-8?B?YkwzUERseDlubzBrMUJoK2pCVVZqTVNIQkovc3YwdGR5MURJZ012emNhUWhE?=
 =?utf-8?B?dnRuOXErVEF4Y2tDWjNEY2psWUxVYVc5V1JXamt5Tk0wSno5VXFZNjNEblpP?=
 =?utf-8?B?aUljMnhzUTRhQ2tLZXFjQkZialRiZ3ViUGNPSkRrWnR5eVlIRzJteFpIVGVL?=
 =?utf-8?B?WTJBUk55YWpNbWpkSzZEaW42OFRsVXVwc2dnVnVUTi8ydGRWbGh4NkZOY0pV?=
 =?utf-8?B?KzduWHZOTTVwamVPMFJPLzcvcytoVHI4SERrTVUxa0xlbGxTaG5scWxFZXp0?=
 =?utf-8?B?N3RqZ0x6UmJMRkM4ckZsQkRvSDFzQmFRUmlQbjFyR1ZuTzBTWmdiVTIycitK?=
 =?utf-8?B?NFBrZVRrU2xnZmQ2ZWhCWU52WFkxYUY3YjJ3cXpMMUNDSkJMenV5dnVHSUVm?=
 =?utf-8?B?cTE5VkNUekZuVUFWeVN3cHRuekJ1REszZ0s4QXBFMWtFRXlGNzdhZWpQRkM5?=
 =?utf-8?B?ODJuVGIvTGRQTzhuK05MaGNGZnU2ajhaeGl1alFkdXB0bzl3a2tNQWtHZkto?=
 =?utf-8?B?TXNSOUw5UjQrdGhWQjJOWGlJQ0swMzdNZGNnTXFzTksxNys2eEVhMkd1VHhl?=
 =?utf-8?B?NGhmZnpnZHc2V0tUN1Z4U1YwNUtMaG5YUTNyRGp0Q1RMU2FIYXNrTXFaSWtL?=
 =?utf-8?B?d2VPWi94NDE4eWl0Mlo4eHFhaDloY1g5RGFlbmw4SEhBQXpFYmF5cEtxaGta?=
 =?utf-8?B?OFVqakVhNTF4SEEvS3c4Vi9McHVOOGlQNUV6UThLY05hQXo3SmFDTG53ZVk0?=
 =?utf-8?Q?NRro=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3fc29e-80b9-4ebc-e471-08dab7ce15ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:48:18.4845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 657ApOV9vyAJBVA4Ra2N6evj9T7+ElMrqcgG1TYwHJLp5oAg5mVsmubiUuXkCtLaz2RewvvKWcRrMOo6iWbh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IHlhbmp1bi56aHVAbGludXguZGV2IDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4g
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDExOjM5IFBNDQo+IA0KPiBPY3RvYmVy
IDI3LCAyMDIyIDExOjIxIEFNLCAiUGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlhLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+PiBGcm9tOiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFuanVuLnpodUBsaW51
eC5kZXY+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAxMToxNyBQTQ0K
PiA+Pg0KPiA+PiBPY3RvYmVyIDI3LCAyMDIyIDExOjEwIEFNLCAiUGFyYXYgUGFuZGl0IiA8cGFy
YXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IHlhbmp1bi56aHVAbGludXgu
ZGV2IDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDI2LCAyMDIyIDExOjA4IFBNDQo+ID4+DQo+ID4+IE9jdG9iZXIgMjcsIDIwMjIgMTE6MDEgQU0s
ICJQYXJhdiBQYW5kaXQiIDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gRnJv
bTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPj4gU2VudDogV2VkbmVz
ZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDEwOjMxIFBNDQo+ID4+DQo+ID4+IDIuIGVsc2Ugd2UgYXJl
IGluDQo+ID4+IGV4Y2x1c2l2ZSBtb2RlLiBXaGVuIHRoZSBjb3JyZXNwb25kaW5nIG5ldGRldmlj
ZSBvZiB0aGUgUm9DRSBvciBpV2FycA0KPiA+PiBkZXZpY2UgaXMgbW92ZWQgZnJvbSBvbmUgbmV0
IG5hbWVzcGFjZSB0byBhbm90aGVyLCB3ZSBtb3ZlIHRoZSBSRE1BDQo+ID4+IGRldmljZSBpbnRv
IHRoYXQgbmV0IG5hbWVzcGFjZQ0KPiA+Pg0KPiA+PiBXaGF0IGRvIHlvdSB0aGluayA/DQo+ID4+
DQo+ID4+IE5vLiBvbmUgZGV2aWNlIGlzIG5vdCBzdXBwb3NlZCB0byBtb3ZlIG90aGVyIGRldmlj
ZXMuDQo+ID4+IEV2ZXJ5IGRldmljZSBpcyBpbmRlcGVuZGVudCB0aGF0IHNob3VsZCBiZSBtb3Zl
ZCBieSBleHBsaWNpdCBjb21tYW5kLg0KPiA+Pg0KPiA+PiBDYW4geW91IHNob3cgdXMgd2hlcmUg
d2UgY2FuIGZpbmQgdGhpcyBydWxlICJFdmVyeSBkZXZpY2UgaXMNCj4gPj4gaW5kZXBlbmRlbnQg
dGhhdCBzaG91bGQgYmUgbW92ZWQgYnkgZXhwbGljaXQgY29tbWFuZC4iPw0KPiA+Pg0KPiA+PiBB
bHNvIGNoYW5nZXMgbGlrZSBhYm92ZSBicmVha3MgdGhlIGV4aXN0aW5nIG9yY2hlc3RyYXRpb24s
IGl0IG5vLWdvLg0KPiA+Pg0KPiA+PiBJbiBhIFJvQ0UgZGV2aWNlLCBpYiBkZXZpY2UgaXMgcmVs
YXRlZCB3aXRoIHRoZSBuZXQgZGV2aWNlLiBXaGVuIGENCj4gPj4gbmV0IGRldmljZSBpcyBtb3Zl
ZCB0byBhIG5ldyBuZXQgbmFtZXNwYWNlLCBpZiB0aGUgaWIgZGV2aWNlIGlzIG5vdA0KPiA+PiBp
biB0aGUgc2FtZSBuZXQgZGV2aWNlLCBob3cgdG8gbWFrZSBpYiBkZXZpY2Ugd29yaz8NCj4gPj4N
Cj4gPj4gUkRNQSBkZXZpY2Ugc2hvdWxkIGFsc28gYmUgbW92ZWQgdG8gdGhlIHNhbWUgbmV0IG5h
bWVzcGFjZSBhcyB0aGF0IG9mDQo+ID4+IG5ldGRldi4NCj4gPj4NCj4gPj4gc3VyZS4gSSBrbm93
IHRoZSBmb2xsb3dpbmcgY29tbWFuZHMuDQo+ID4+DQo+ID4+IEluIG15IGNvbW1pdHMsIHRoZSBw
cm9jZXNzIG9mIG1vdmluZyBJQiBkZXZpY2VzIHRvIHRoZSBzYW1lIG5ldA0KPiA+PiBuYW1lc3Bh
Y2Ugd2l0aCBuZXQgZGV2aWNlcyBpcyBhdXRvbWF0aWNhbGx5IGZpbmlzaGVkLg0KPiA+Pg0KPiA+
PiBJcyBpdCBPSz8NCj4gPg0KPiA+IE5vLg0KPiA+IENoYW5nZSBsaWtlIHRoaXMgYnJlYWtzIHRo
ZSB1c2VyIHNwYWNlIHdobyBleHBlY3QgdG8gbW92ZSB0aGUgcmRtYQ0KPiA+IGRldmljZSB0byB0
aGUgbmV0IG5hbWVzcGFjZSBleHBsaWNpdGx5Lg0KPiANCj4gV2hpY2ggc3BlY2lmaWNhdGlvbiBt
YWtlcyB0aGlzIGtpbmQgb2YgcnVsZT8gV2hlcmUgY2FuIHdlIGZpbmQgaXQ/DQo+DQpFeGlzdGlu
ZyBBQkkgZGVmaW5lcyB0aGlzIHdoaWNoIGV4aXN0cyBmb3IgbWFueSB5ZWFycyBub3cuDQpUaGVy
ZSBpcyBubyBMaW51eCBrZXJuZWwgc3Vic3lzdGVtIG9yIG1vZHVsZSB0byBteSBrbm93bGVkZ2Ug
dGhhdCBhdHRlbXB0IHRvIG1vdmUgbXVsdGlwbGUgZGV2aWNlcyB1c2luZyBzaW5nbGUgY29tbWFu
ZC4NCldoZW4gdXNlciBleGVjdXRlcyBjb21tYW5kICwgdXNlciBleHBsaWNpdGx5IGdpdmUgZGV2
aWNlIG5hbWUgImZvbyIsIG9ubHkgImZvbyIgc2hvdWxkIG1vdmUuDQpPdGhlciBsb29zZWx5IGNv
dXBsZWQgZGV2aWNlIHdob3NlIG5hbWUgaXMgbm90IHNwZWNpZmllZCBpbiB0aGUgaXAgY29tbWFu
ZCB3aGljaCBoYXMgYSBkaWZmZXJlbnQgbGlmZSBjeWNsZSBzaG91bGQgbm90IG1vdmUgYWxvbmcg
d2l0aCAiZm9vIi4NCg0KWW91IGFyZSB0cnlpbmcgdG8gZGVmaW5lIHRoZSBuZXcgcnVsZSB0aGF0
IGJyZWFrcyB0aGUgZXhpc3RpbmcgQUJJIGFuZCB0aGUgaXByb3V0ZTIgKGlwIGFuZCByZG1hKSBj
b21tYW5kIHNlbWFudGljcy4NCkl0IGlzIGltcGxpY2l0IHRoYXQgd2hlbiBjb21tYW5kIGlzIGlz
c3VlZCBvbiBkZXZpY2UgQSwgb3BlcmF0ZSBvbiBkZXZpY2UgQS4gVGhpcyBpcyBwYXJ0IG9mIGlw
cm91dGUyIGZ1bmN0aW9uaW5nLg0KDQo+ID4gSXQgd29udCBmaW5kIHRoZSBkZXZpY2Ugd2hpY2gg
Z290IG1vdmVkIGFzIHBhcnQgb2Ygc29tZSBvdGhlciBkZXZpY2UNCj4gbW92ZW1lbnQuDQo+ID4g
Q3VycmVudGx5IGRlZmluZSBzY2hlbWUgY292ZXJzIGF0IGxlYXN0IDMgZGlmZmVyZW50IHR5cGVz
IG9mIFJETUEgZGV2aWNlcy4NCj4gPiAxLiBJQiBhbmQgSVBvSUINCj4gPiAyLiBSb0NFDQo+ID4g
My4gaVdhcnANCj4gPg0KPiA+IEVhY2ggaGFzIHNvbWV3aGF0IGRpZmZlcmVudCByZWxhdGlvbiB0
byB0aGVpciBuZXQgZGV2aWNlLg0KPiANCj4gSVBvSUIsIFJvQ0UgYW5kIGlXYXJwIGFyZSBzb21l
d2hhdCBkaWZmZXJlbnQgcmVsYXRpb24gdG8gdGhlaXIgbmV0IGRldmljZS4NCj4gVG8gUm9DRSBh
bmQgaVdhcnAgZGV2aWNlcywgaWIgZGV2aWNlcyBzaG91bGQgYmUgdGhlIHNhbWUgbmV0IG5hbWVz
cGFjZQ0KPiB3aXRoIHRoZSByZWxhdGVkIG5ldCBkZXZpY2VzLg0KPiBPciBlbHNlIHdlIGNhbiBu
b3QgbWFrZSBpYiBkZXZpY2VzIHdvcmsuIFRoaXMgaXMgd2h5IEkgc2VuZCBvdXQgdGhlc2UNCj4g
Y29tbWl0cy4NClNvIHBsZWFzZSBtb3ZlIHRoZSByZG1hIGRldmljZSBhbHNvIHRvIHRoZSBkZXNp
cmVkIG5ldCBuYW1lc3BhY2UgYW5kIGl0IHdpbGwgd29yay4NCg==
