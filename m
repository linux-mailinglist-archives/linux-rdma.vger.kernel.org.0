Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8F6E122B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 18:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDMQX1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMQX0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 12:23:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AC8A5F
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 09:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9Hw12A+Y5gzwcx7BTu35dzBgAPOLjCFOFJvtxkY9CqRJsa3ViFL0gOa54EqzE+Lha66cYqqy4yaN0o83wn/73ZVvH12uf65/IM+NpWAvYRMBqBOz3PRK8MEZAo08K2Ro0RkzKZVGdSR24I+P+PdrtFNVC+/OxvN/vsVonXk4bvLeIuNBjx71z3F5vMNgXKp+gbyofJvYSx3gj9R9C+HMTqXKXN3tCeqRPluubKV9Air/A5LcmWgWT3z6LKBaVLMyEpsHKIJ6utJIEH3+bm13gZc1bUbMOQ2oiXE9EkSpPN0YOOaM872SUqEKnfS3zPYFCprDYGvQ2HJSlzye2SlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoP+jlNe/Mfc71YLAzDcFZrutBPQSIkQEjwvB8KH0Y0=;
 b=ULJ+e5nNFt86DcIraYXhxwjfSDHcoEZlc3F4xB9FvmdMgljZx+EUIIjnHTObRKR5bcSqdtXg8+kSGr3qgQ4FniK1tmRI9ofIPOctCIyxwUOierLXrXS/nV3uslWy+m4ITXs7FGq2WOZhq8S88iAHN81X+OuuL6+kcHhomPBQAMDQBGY2YhmWKE5lxYFQxCSPxpaW12WLRwkCKrZ5Gto7MEyKSiyMjcEN9rRYkJDFJVDiS1IxBbLFtgjJZV6+lm97FQJRrKpruPHT/kEVx+4f/RlNb06JNoOSgHXmC4PcLtKWz/EIqzWTi2ff2xfB+E+i19h+YYEjYhBd4GO/gztNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoP+jlNe/Mfc71YLAzDcFZrutBPQSIkQEjwvB8KH0Y0=;
 b=mHVwGPXrry168qI5a9+9Un7U/5eZWz9374/pKyEv7byqWlkq/lMEDYJIGxva1v1Ve5XL4qEQi2ecRKm+A2vDxw8Fg52ftY2USeJBBGWf+iPGxS6aoOd/4wamtzNykI2jAPhHp8w2kdNad16CcMwR9wYab4tZtloL9Pa7xKfcDV+DVgkqgV63DyiFf8ShPWykXRrekx+BH0YyGHHOEptmuMz1IFEAfjb9a9NWz6XeRrzqGvPT8lwg6a/OTyudHOQCac/MPMjX+DJpeCD1m5g8etg+8JICfBvj4s8afu8/iSH3i/6H8r+AIicel502emDCpaNGX1pSBfwBENnQ/iwCoQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 16:23:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 16:23:22 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Mark Lehrer <lehrer@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Topic: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Index: AQHZQDq78euIxrtulEiTJiby3UJy1a8oRlKAgAA9FwCAAK1xAIAAXqEAgAAARcCAACvLAIAAC2OggAAAweA=
Date:   Thu, 13 Apr 2023 16:23:22 +0000
Message-ID: <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7526:EE_
x-ms-office365-filtering-correlation-id: 40f9e108-350e-44c7-db1f-08db3c3b66b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uJ/nYZPa6p3A3DTkgcMiAx9dq2AAuHnY+P62vFpuQ0COgqWk/KJqdhGL5BMW93+cLh1BTs0ka6oSxOluegoPazA3XOkcV3SfLieZ0t9Khs0Bqp3rSjyvRGLMiySGSPGCG7Ee/d/+Ym6k2jA27wL/LwzDppGP37EnjHYN60flq7xOXhveQB1pk7AwH5iPIrgSBy6doNE79Hhy17eZXYiN44z2i8LQGqZRfr1co09TnrsnR3NU8PTW5SC3PPYFqCREPbOpNzkn7zP0DXIjkwh8WaiFZe0/VKGXYxNcQZbJbMFYM5kf8XSSLFHWDQSDtbUit3QJ4B9kKIC3Fbr5d86UxY2JrXzIw8kkVLW4iF+Z4uDrZQbkP/epX2e4N49vAMajHlt7pIJwwk44DbatZu+hITgJn4QVVM/dlA1enXnxWHs0kHasoHrnXOf+BQw22VHmTeiaDfZ84nstOsYn+u8bctaj8kOnzWmXDHr/xs3q6WyxAaoU8ZmagX2x0aYMzDdtxsOZsPQN7GFQTAeI64i9TyA8l5p5D++ASxCIUA7FnkClIh4kKetXVdFP79X5+c1WRQ/FnCQcpS5DAfPRgGqbscVwh3cqzRUCz5ZKcdS9AhISqD4X3AAorF0mRWSh8+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(316002)(83380400001)(41300700001)(54906003)(122000001)(33656002)(86362001)(38100700002)(478600001)(38070700005)(66476007)(7696005)(71200400001)(76116006)(6916009)(8676002)(4326008)(64756008)(66446008)(66556008)(66946007)(2906002)(2940100002)(8936002)(186003)(52536014)(9686003)(26005)(6506007)(55016003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWM0YmY2T2ROd1ZuVzlzRVg2OHhxN01sczM5RzVDZ005SC9uT0MxMHhFTXNM?=
 =?utf-8?B?bGJITXgraU5NSFNBWDRMM1lPTDBKUWdNTlpwdWtldkoxRTd4K2xXYlNtblQ0?=
 =?utf-8?B?MlEwR1lBOXhCWDhkQk5JQU5KcEtET3B0WmNGS0s2b3RCMmsyRy9wUWd6Qmdx?=
 =?utf-8?B?aTBsQ2VyWXNXZzg4WkFkSW1QTklGbHpYN0lTK1JGNThDc2VZTUc5SVl2ZElk?=
 =?utf-8?B?QWpRZXJ5U0xVZ2VqallCa2hZM215bFpOOGQ3S0Fvcy9zWnFsdnF4a1phcUlp?=
 =?utf-8?B?TWtzd29KN3I4My8xSDh6eWdYL1dPS1Zla21QTVRhNnFZTlhWOVZuOE5LK013?=
 =?utf-8?B?VXliWEJjMExKYzNVOFp0eG16ejhEbXllL2VxdDR6VlYxb2dvemVwMGpZcU9T?=
 =?utf-8?B?eUhQbXZwUEVDOTRVaWxOeU0vQTJITFZJRklmZEo1N0FFV3Q5ZytXMUExK0Rt?=
 =?utf-8?B?UExlRVlqbW05SlMyT2Jtd2lxK3Y3Q09Ja1BtQnpCbmNYaERMRlFZRy9MR0ty?=
 =?utf-8?B?d2psOG5za3lraVRYcUdnKzE4cndrSitjOEpDL0l5NGVyOUJiUzlGazdHVzZE?=
 =?utf-8?B?Y3Zuc3owRTgvWmhFd2lobmZrWDZINXRpQytjRGVBL1FwNDFBeE9ZL1YrWEpm?=
 =?utf-8?B?UXordkFzcmJ3a3plU0JyS29oQUxKdnlZd2N2V1RRSktMUU5GbjFqOStuOGxP?=
 =?utf-8?B?TCtzU01mNEZrbTRYVXZPUXVyakxXa1poL0FiYkVjOVcrcHdXaGtKNzB2OVcz?=
 =?utf-8?B?MUF5TFlzTVhPeGtkelZrZWIrSlNCb25SRVFKY2VrdDhLMXFSQkZGUmYwVVc3?=
 =?utf-8?B?RnlwWXlFK2V4Sk5Ub0dJdGowRVphR1pjZTFVOHdHdjFZeXZHL0VQQ3YvbHUw?=
 =?utf-8?B?NXVkcmRNc0FFdVFiNWNYWUZCcGtxK3hDTzFGcWF6Y3RqcFpPcGNNWXUwMm16?=
 =?utf-8?B?N0hmbERQZ0N0Q1V0bGVpanRXblNqU25uVVB0ZEN2RkdOQ0h4eUE3d21CL2Nk?=
 =?utf-8?B?TThmQkZPclBZM1lLa01XdEJJaHEwN1VuakJBSjU3NGxsTE9CMUJSQjU1UDUz?=
 =?utf-8?B?SVVwZ0lJTG9aNERkZjJLaWpHUnpwcVZ0MlpEQTZydUVCK3ovRlUzam1URnJF?=
 =?utf-8?B?M2krV2ZGNnlBWnhaNTZRNUVKdWJQQytFV0REK0RWcUtpcTkzRno0Zk1sRDlT?=
 =?utf-8?B?SGwwR0NzZWZ6ZlZ5MzJCOFloNW9oTjBsQjVQamw4VVkxZjdFQTQ5M3lkMVpq?=
 =?utf-8?B?aXVMTktnN3R5M1pMTmtSS3p2TTIxZ2lSZWFzUmVwQk9lNFRiN29GQlZlMm44?=
 =?utf-8?B?MlhvcFRoczdTWldOcUZUNW9sYkhyMHdpQTROVWJCV0xiV290TUFBUFVzRmFu?=
 =?utf-8?B?dDA1ZXhWTXQzOGxVNTBoc3FJSXpQZEQ0VTNja3hOMGpJeUhYSHBieU9FYk5J?=
 =?utf-8?B?SVpBV2tIQVVnL0F2WmRmYy9DYnI0d1ZNdlB0SFcwZUswQXRncmFMaXR0QjBn?=
 =?utf-8?B?bXM5TDE3cTVqZzBZOFMwVGlPUFhCOFNLVjYrQlVpVGw1L3N0STZuM2l6SldN?=
 =?utf-8?B?VzJOTlZhNThySVBHQk1rYTFGcUdGbVAxaElMSzFEeHhqY0NtVkxWbzhxajVP?=
 =?utf-8?B?UENESXFCWEF1SWZJQlQwYmNvdm5HaWFOVC9QQThSbjBENC80SU0wcHU2OFlL?=
 =?utf-8?B?TmN2OFJRSndkSVoySHg4c3htbFZhanpxUFhnQ0U5cTc4K1ZaVFVjWHNiUDd4?=
 =?utf-8?B?MHM1em81bk1YUlhuOTZ5Zkh1Uys3Qkx4S291dGpGMmI0ZEdLcW5hemZMY1JS?=
 =?utf-8?B?T1Ntd0NDWTdweVU5YnIwbjVkWER0dEJSY2JPaEIyK3NrLzdTVEJ2S1RzN0cx?=
 =?utf-8?B?THpCTzBxVjBlMkJqS2xjbFIwRXBjTndVaGc3dzFLbktDTDM4NWZhWmhkZFQz?=
 =?utf-8?B?VVNBT3YwY1VuK0lrNUZjYnU0Wm15NHdyemw2aGZWVkg2YTVQamJ0NXE4MzJY?=
 =?utf-8?B?ajZpbXF6TklpQzdEeVBWK0Jlbko4TUxhWktyVy9adXY1NnBFUXZGMmJ5Zkc5?=
 =?utf-8?B?ZkJuRmR0a21CcFg5N0NjYjczNS9kWTlFY0UwRmk1MkxPYVNSUWRqTDBRK3Js?=
 =?utf-8?Q?OLbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f9e108-350e-44c7-db1f-08db3c3b66b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 16:23:22.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebL4B3OajX6sPx1aa7YLLa2UWP3tKoJN57z+6dmrc7lje9kUGk4N2NSD417zgZDGaklTgzAdAtIDBO/pYc99mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEFwcmlsIDEzLCAyMDIzIDEyOjIwIFBNDQo+IA0KPiA+IEZyb206IE1hcmsgTGVocmVyIDxs
ZWhyZXJAZ21haWwuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMywgMjAyMyAxMToz
OSBBTQ0KPiA+DQo+ID4gPiBEaWRu4oCZdCBnZXQgYSBjaGFuY2UgdG8gcmV2aWV3IHRoZSB0aHJl
YWQgZGlzY3Vzc2lvbi4NCj4gPiA+IFRoZSB3YXkgdG8gdXNlIFZGIGlzOg0KPiA+DQo+ID4gVmly
dHVhbCBmdW5jdGlvbnMgd2VyZSBqdXN0IGEgZGVidWdnaW5nIGFpZC4gIFdlIHJlYWxseSBqdXN0
IHdhbnQgdG8NCj4gPiB1c2UgYSBzaW5nbGUgcGh5c2ljYWwgZnVuY3Rpb24gYW5kIHB1dCBpdCBp
bnRvIHRoZSBuZXRucy4gIEhvd2V2ZXIsIHdlDQo+ID4gd2lsbCBkbyBhZGRpdGlvbmFsIFZGIHRl
c3RzIGFzIGl0IHN0aWxsIG1heSBiZSBhIHZpYWJsZSB3b3JrYXJvdW5kLg0KPiA+DQo+ID4gV2hl
biB1c2luZyB0aGUgcGh5c2ljYWwgZnVuY3Rpb24sIHdlIGFyZSBzdGlsbCBoYXZpbmcgbm8gam95
IHVzaW5nDQo+ID4gZXhjbHVzaXZlIG1vZGUgd2l0aCBtbHg1Og0KPiA+DQo+IA0KPiBzdGF0aWMg
aW50IG52bWV0X3JkbWFfZW5hYmxlX3BvcnQoc3RydWN0IG52bWV0X3JkbWFfcG9ydCAqcG9ydCkg
ew0KPiAgICAgICAgIHN0cnVjdCBzb2NrYWRkciAqYWRkciA9IChzdHJ1Y3Qgc29ja2FkZHIgKikm
cG9ydC0+YWRkcjsNCj4gICAgICAgICBzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQ7DQo+ICAgICAg
ICAgaW50IHJldDsNCj4gDQo+ICAgICAgICAgY21faWQgPSByZG1hX2NyZWF0ZV9pZCgmaW5pdF9u
ZXQsIG52bWV0X3JkbWFfY21faGFuZGxlciwgcG9ydCwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eIE52bWUgdGFyZ2V0IGlzIG5v
dCBuZXQgbnMgYXdhcmUuDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBSRE1BX1BTX1RD
UCwgSUJfUVBUX1JDKTsNCj4gICAgICAgICBpZiAoSVNfRVJSKGNtX2lkKSkgew0KPiAgICAgICAg
ICAgICAgICAgcHJfZXJyKCJDTSBJRCBjcmVhdGlvbiBmYWlsZWRcbiIpOw0KPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIFBUUl9FUlIoY21faWQpOw0KPiAgICAgICAgIH0NCj4gDQo+ID4NCkNsaWNr
ZWQgc2VuZCBlbWFpbCB0b28gZWFybHkuDQoNCjU3NCBzdGF0aWMgaW50IG52bWVfcmRtYV9hbGxv
Y19xdWV1ZShzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsDQogNTc1ICAgICAgICAgICAgICAg
ICBpbnQgaWR4LCBzaXplX3QgcXVldWVfc2l6ZSkNCiA1NzYgew0KWy4uXQ0KNTk3ICAgICAgICAg
cXVldWUtPmNtX2lkID0gcmRtYV9jcmVhdGVfaWQoJmluaXRfbmV0LCBudm1lX3JkbWFfY21faGFu
ZGxlciwgcXVldWUsDQogNTk4ICAgICAgICAgICAgICAgICAgICAgICAgIFJETUFfUFNfVENQLCBJ
Ql9RUFRfUkMpOw0KIDU5OSAgICAgICAgIGlmIChJU19FUlIocXVldWUtPmNtX2lkKSkgew0KDQpJ
bml0aWF0b3IgaXMgbm90IG5ldCBucyBhd2FyZS4NCkdpdmVuIHNvbWUgb2YgdGhlIHdvcmsgaW52
b2x2ZXMgd29ya3F1ZXVlIG9wZXJhdGlvbiwgaXQgbmVlZHMgdG8gaG9sZCB0aGUgcmVmZXJlbmNl
IHRvIG5ldCBucyBhbmQgaW1wbGVtZW50IHRoZSBuZXQgbnMgZGVsZXRlIHJvdXRpbmUgdG8gdGVy
bWluYXRlLg0K
