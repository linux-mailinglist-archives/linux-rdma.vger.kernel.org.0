Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7361091B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 05:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiJ1D6y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 23:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiJ1D6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 23:58:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E6D8F53
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 20:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDJ2x2AS6ndhFA1t2o9EzQJPDHW0ZQc0N3SKF8yCH2OVbq5mEhtgnAabbnra9Ni+R8CkQxUJHuJTnlpqaPCp00VBdUpR3KmSJ0Ut9TV0Ug/v88tgVGrwEOKiNUCdDZSr9Ml0ruRIi196CndAdxtHD1zmyLA4cLANoS+L5ePxwQQnyPDB7SInNlY5Qmir6BiYFsgJL6p3Xkgtt3LCczfROQ1b71fqFkW8ExS5CJSqzqTFywFdbUWNVcWSZTSXjt9rYMBAYjcWoD0lvRzkIswBbKRW9reJxqTP6+Dl+O0qXhzhym+XwESlZJYIrdAOwQxOomoHM7k91348ROkyjwgWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp8jjoOvjj9QWzUmsOCWXjpg6KecXTHGb/0CzjyGtyE=;
 b=lEzGntMUEuXKvC4j+0hprQBJdkWTDN2SfojtAgZI77Tng9NlAw31ph/+SolUZ0yPmAdzA2GVM7YW2lo2pobba9sT/F/WCJzvSftpTDRxEwPyqra+ZkIfdh3mk6tKU74FIjeFy8TSL8CN4tE7WOS14uDkoRYG1JEyQYf7nqAg9emf7Q8yuUF+TW28W8t7vioGbU0owMrG/spfFKqvweTeecPxQ2FWZNfc8dWzrmqM6TGF2u4Z86h/sI4cRzyArxJ6ttRbdh60XuN7BBkKwBlN0xSLhZhwmR0CScHiQXZgcY2+ichHeZ3OtRTChwPp0trRUStoGL01UVc9iPeJ8RKyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp8jjoOvjj9QWzUmsOCWXjpg6KecXTHGb/0CzjyGtyE=;
 b=aAqyjNoGQBpX7qGPKs84r765vdAAIfwRoOAnNoS/0ZuwkPhddBYTL+vFYp8D15xSmKSkEdZ/qT3Tzvn17DiliWgl8BeXhYL6r/6ri1un8OIGnuXkRXJJHwPDNo1V3KlJmD5onGirbR2wq9tZnjeKh0WTV5DHDN7EUDAJdfDJ89k08GU6N9YeSNk7TJzpjni9o0J6fGZUODAkhdeGLPAVCMCHJK4vzK7tu3qVJE9+qjlMoJCFB1S3OSPQYevNI4U15wZpq6CzET4S8ZWLAhGWarzuzrcm4tMA7G3nxNm8zz9cO1sNhlUSQyI8EXEmnZnKoo4U5LhxSyAniG4rdyCbZA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 03:58:43 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 03:58:43 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1CAAAKNAIAAAC4AgAAF6oCAAAAm4IAAJ6kAgACEhgCAAOEMgIAAALIAgAAHJYCAAAAnoA==
Date:   Fri, 28 Oct 2022 03:58:43 +0000
Message-ID: <PH0PR12MB5481389EE22F7010FCA87C3EDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481AA6E4D5BBAC76E027458DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
 <6d841d006c9a79d9ecb1b1bae8d10a28@linux.dev>
 <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
 <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddd5fb94-127a-0fc2-cadf-7a0f24fa0d15@linux.dev>
 <PH0PR12MB548174B0CD9E7DA82DF9F25CDC329@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e6115b24-811e-ff61-23d3-bc3e93a4d12c@linux.dev>
In-Reply-To: <e6115b24-811e-ff61-23d3-bc3e93a4d12c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6434:EE_
x-ms-office365-filtering-correlation-id: 8de274de-9958-404c-70fe-08dab898b496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mU/6SimXRqDOw4AzQX9YWelh53olcENBm1euhBVJx1KOcKZQAQV9YCkKWfK09pfLblopGqyQyzdSKtZq9FMFAjyUVMtHf/4t+3yfHzwMYPXhLCRCZennYIYwgjvDhmZ47vJKB17uIHgP1/pUqKwXfa9D2tlqv0vFzhPXD8LDFwA+oHYLV57tLQ2LOSoi43nIb8mYy7J3gNPcmfbgXXbTVrLOBGad3pxD6wyhZyQIw3ACDiimYnV9pC4XAAvzcLctkHdxGTKLBKcd2sknuQiokDCGWI5NlK40jOMmQTq+44gbT8P8I7sYoj3e+MhCYRsVXB3wG/2A7aX50xiMSt0SOeMYJsEiMIDXtvDDKCcwP7FubwgKGaNMTUTmhcTimvsjLSw1PpiCZDrY58gPoPRrKWF/JwnTlFFS1NQdyqqsmdRTqkoJFocnrz3ZN/pfzU1qLIuUUZIQSkMkeNcnjmNOsrhZzE1cHd1PwQqu1oEPro9IWugwTpnfJq+7yuwTFw2fUv5YzR1YRh3ccR6NTqifznlsGHmsmxpBHdY33Ow4wIf0L+ViVomPyRBDuQvRMq+92ko6XfxO8IOCnQvrT7mdP2sm7UXqd2nIO53LFRMMuIllu69jsqtvehNR4b2shyvaBDFLAz0eipTmi7r3sxBOdnRcS26bV06Ph5OtgaKjcNO52lZBBXUT349I18TivktKpnUrH9cQA87gADbMZJmwRbNKsogR4BGULzjeJrSRCzHDDAyBkZTGyfHLs0qoLybVq0j7QXcJGWPdMS+Zl+oF1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(26005)(55016003)(9686003)(38100700002)(76116006)(122000001)(66946007)(2906002)(52536014)(66446008)(64756008)(33656002)(66556008)(66476007)(186003)(41300700001)(38070700005)(8936002)(316002)(4744005)(71200400001)(5660300002)(110136005)(8676002)(6506007)(7696005)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXM1U3VMV3BtL3BHQWJrL1pHc1VUWEZHM1JRWjZmWkFQaWRIUnFZSVYycFZq?=
 =?utf-8?B?QUorYWszUTBMTUZsYW9DQythb3NyTUNyYUFuOHJSMXRsUTdVV0pHdFBRKzFj?=
 =?utf-8?B?RW1TMXl6aXRadjhneUtqNDZPaHRLemZSMjQvS1NJVjBWR2l5dHlpR1ZHZXlR?=
 =?utf-8?B?ZStuK3ZTK01DbldaMkNUaEdkWVBFOHUxYUdrenRXU0lqNW5Rd0MvRzdHeXpU?=
 =?utf-8?B?QldZQWx4bmd6Q05MN2swSGZBakRKUm84eTl5ODFWWUdFUU56TTMxVk9PRGxi?=
 =?utf-8?B?a0JBcjdmbHVUK1dpNVBFaGJib0trNjdOQjE1cXRkNVhPUVZPQzF1NDFxQjlO?=
 =?utf-8?B?czV0aG9ERW9hNmo3L3FNY0F4aVBEcS9LM1FiVHAzRG9PZHl4TDRtQnJpbEth?=
 =?utf-8?B?TC9CdyszYXlJLzh6ejI2Tnl2bTN5WXo5Z0IvLy9wK29hODhqU25iTUczWElG?=
 =?utf-8?B?ZXQxVlhEZkNVZDdsbm8xMlBRc040aEtLbi9rRGxla00rdEEyeW5JU0lqdXZo?=
 =?utf-8?B?OU5NOC81ZVFPZmRqTkpJdDZna1ZyU3FqQXBQRVU5aU5xTFNvTFl2MkVSTUp2?=
 =?utf-8?B?Q0I2N3gvZG05K21CZzF3eTE1eGVZdFF0QnhYdEcxTE83ZFFZOTdOY3M5aUlp?=
 =?utf-8?B?aERRWkU2SzBWNUF3aW9FSDY4WStibTdvWmdaZ0ZpcnAxeC8vbFVwTjAzU09T?=
 =?utf-8?B?cFpUQXJETHcvNSsxeWNYQXdHLzVQR2xnZW9nSUVOeHQ4MXlhdEZvS04xcFdl?=
 =?utf-8?B?VVY1R0ZiNTB5Wjc5b1RRckN5SVJTdjRXTzMxKzhxYkpoZXk2VnREN2VnMnJB?=
 =?utf-8?B?dnRWNjk0WTdQZUpFQjlCdCs4VGN5WXgwQ0N5a21NSEN0UkJlTUVVblpGMlBU?=
 =?utf-8?B?Q2M0T0RNL0h4OCtEYWo1Q1hHdHZrcmVITjhGMElzUkZlckpSdExWVFNrZUdD?=
 =?utf-8?B?WFVJaFF1ZWJhQTI3bDl4eDVTQVo2Z25QNXhLWWpmTVVFWGQwc0FYbnNyL2pC?=
 =?utf-8?B?OUZheXdadFlKMmVLR3lKL29aeWF6NWNCYkZoVzU5N1pCYVdjVW1hT0NsNUNR?=
 =?utf-8?B?MW1TTFRvbUhmVEZEdlpDWkZuTGZpZmY5cmVlWUErQm9CRXNHRzY0alI4bEtr?=
 =?utf-8?B?d0RmRVhHWXZqMlMvMU5WR3F4Nmp5RkFid08zRkl3NHRVZThjYWo3d2NLYWJQ?=
 =?utf-8?B?NzNYay9GS3NqWmxESC9KRERoMlZkMExZTUc2b3VtMTFOREFmMFhUaFlNYk9R?=
 =?utf-8?B?UDgxMGFCV2c4N1dieEhMRGIyRDZSdlVQcFE5VGlUQ2FDWnJ6TTgyR1UzNXpN?=
 =?utf-8?B?QmU2UXc3OEF0TkF6ckJOS2lWeWZvQUN2dkpETnNjRUJUSk5rWXJpb2F1WkNw?=
 =?utf-8?B?cUpEZU1SNVpON2dnMUs3ZWJhVW03ODRZRGx2UWx2Y2xMRDVxSVo2cnhvMW1S?=
 =?utf-8?B?V1NXRzNuTFhrWWJCM0lmUkNtS3RuZEEyVE1xR0VtRjdRbVJNWG1NM2V1STJz?=
 =?utf-8?B?ckZreVQ4SU9YVExKSUN4QmtqOUlxaXZDTlRwaFpTemtJWVBGcFNwTkFubmVq?=
 =?utf-8?B?dWpzTy9BZnZsV0dZR3B1ZjZJeWcveHVpa2Q4Y0E4RmFRa0szU0xwemR2U0N1?=
 =?utf-8?B?U2dtMHVPcHZ1bUpBNmRMd1dJUlZJdnJ3WUw3T0xPVDlzS3ZJdWl3R25WaEVG?=
 =?utf-8?B?YjRla1o5dnNROUNLeWVTM1B4Y3dGVHQ3bEpWeG5KSzFqSnhnUVFWUlZPYUxU?=
 =?utf-8?B?WG5tc3R2UVJRRVh4aVJGM0NkZ0E0MlQxL3VSMDdWL3BHQUdaUUo5WURNK0Vl?=
 =?utf-8?B?a1VsZHRiWG9JZWN4V2h5MEM5b3VDbUVydDYxMisxT0F0eFFLelBaaUtPQ0Rt?=
 =?utf-8?B?S2Q1NWpSVXFnUFRZbmh0VHBCWXNuYk1URGw0WEdmT1VkWFNYWWttWUJkMVU0?=
 =?utf-8?B?UDNNc2NRZXI0UzJJd1F6dUVJSVR5Z0pGREs1TjVjYURjWlcwWE5tdU1KS2NR?=
 =?utf-8?B?MXRCSy9CUjBJUHg5cmk1L0NjYmlYK2hKcDNsb2ZmZkl5YUFLWnlMbm9sUWtY?=
 =?utf-8?B?cjk5TktzYzA3QjZjcHgzZGlSdVZmbXRqUklHTDl0UzNZMFdkNVVEclNObStw?=
 =?utf-8?Q?ofIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de274de-9958-404c-70fe-08dab898b496
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 03:58:43.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL723xZXz1IeoxLUOyUx/hcRyerHwMi03e/F/EtrPFyedeK4gYtY4vMHfIav4vbHZALyzEgxXGqMkVBCDmCm7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IFlhbmp1biBaaHUgPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciAyNywgMjAyMiAxMTo0OSBQTQ0KDQo+ID4gQ2FuIHlvdSBzaG93IG9uZSBp
cHJvdXRlMiBleGFtcGxlLCB3aGVyZSB5b3Ugc3BlY2lmeSBhIGNvbW1hbmQgb24NCj4gZGV2aWNl
IEEsIGFuZCBrZXJuZWwgb3BlcmF0ZXMgb24gZGV2aWNlLCBBLCBQLCBRLCBSPw0KPiANCj4gV2hl
biB5b3UgYWRkIGEgbmV0IGRldmljZXMgdG8gYSBib25kaW5nIGRldmljZSwgeW91IHdpbGwgZmlu
ZCBjaGFuZ2VzIG9uIHRoZQ0KPiBib25kaW5nIGRldmljZSBhbmQgdGhlIG5ldCBkZXZpY2VzLg0K
PiANCj4gT3Igc29tZSBvdGhlciBjb21tYW5kcyBsaWtlIHRoaXMuDQpUaGF0IGRvZXNu4oCZdCBj
b3VudCBhcyBJIGV4cGxhaW5lZCB0aGF0IGl0IGlzIG1vcmUgcGFyZW50LWNoaWxkIG9yIHNpbWls
YXIgY29udHJvbCByZWxhdGlvbnNoaXAsIHVubGlrZSByZG1hIGFuZCBuZXRkZXZpY2UgYXMgbG9v
c2VseSBjb3VwbGVkIGRldmljZXMuDQoNCkFsc28gd2hlbiB5b3UgbW92ZSBhIHVuZGVybGF5aW5n
IG5ldGRldiBpbnRlcmZhY2Ugb2YgYm9uZCBkZXZpY2UsIGJvbmQgZGV2aWNlIGRvZXNu4oCZdCBh
dXRvbWF0aWNhbGx5IG1vdmUgdG8gbmV3IG5ldCBucy4NCg==
