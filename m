Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A66E1291
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDMQmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDMQmW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 12:42:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF983E4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 09:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze2MYzn+P00kfx3AUPC04uR8hohKOMy8GO2Nb7PGWr27Bge8PGDysMu6xUT0JrRZg1X0hek5aqL37j2ud/z3F5sQ/TzIMnJsfoNBkTYw/TpvOSKqXw1k6WBReF4dLtOO07KbN0xc50SiomTLPHPKL3xvdMIrfIHeLzAkfmpEF7pf5pJW/rTUdJd++bfJftgVLjpszIoHdjluLlfdTAhmsVsKbQDiuiLZ/XwHhLxSxjPckz1aQdjYdDbwLh3Jt9gi3dfhmIzWUIgZSfOK1hzl98Vk0c1wA1o86g7LyeG4oTUTLOepLHDrV2StK7FXYQXXtktm+H3LDTz767Bor5co1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd4KGcJO+fN9z67CFnjbdcpUmGc3zkr00rTcjezkt7w=;
 b=DsFfF5fatJkpOLHNVMvWkO7kLBVCiWumxYzBnYCmkHx3vPnyCT9l8LZKxI5LXTN/RkGIfHCK23U3rLavU7RIXjtY93cgSL6NOjn4GSD3o/AZMYsFjxV4VDoPClqUMLfeEkJkc94RHLCeEh0aOXFRq3dhrpRlZfUcf7NjyHAeAmhCI1HZVwo23i8prvfvEKe1ol/mtjfIJ8dewLgUN8YffSf8F3fGt6TvU081NKtm1fAO0HpQvYt1xMvoc2YzISXHYjCzUTKkggCFOYv5dT3S6eUerTBHpO3eDRwAzuV4BZIl9sZBbsQVYTM1lFRo6pmoTFF6+4hYBooVNY7ohTi3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd4KGcJO+fN9z67CFnjbdcpUmGc3zkr00rTcjezkt7w=;
 b=KhTAc2iaeUIVwhbRk4E/v0aZhO4HdRpr+jOKMuaEINWXP58N+qtXpxefdHdMdg9a0ISIUE5EDxP7FI2UPOv5gWM7iAsvr336bRLVzh661gRKn6ju+nHuC4S2pT2UkbrH6272V5cHGxBsYqewabXx4f3bxhEOqd8TfY49mYXdfltU5VNMgwO1ARtWyEwswtYv2OuUU1MKSfQyekjwkrnRE5kmFQqVn6FnN+3IxMa6lvR5nB19sdjDABxcDuHPcrHxeXljy7QnAdYGwIDl6YMzsVfiNVyOfzHfzRS/scX4xepNlBpeCbRStTV+/ue2HLWGLpTtdxfe/khcRH7MczNyCg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 16:42:18 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 16:42:18 +0000
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
Thread-Index: AQHZQDq78euIxrtulEiTJiby3UJy1a8oRlKAgAA9FwCAAK1xAIAAXqEAgAAARcCAACvLAIAAC2OggAAAweCAAARiAIAAAHBg
Date:   Thu, 13 Apr 2023 16:42:18 +0000
Message-ID: <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
In-Reply-To: <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6140:EE_
x-ms-office365-filtering-correlation-id: a96c955f-b747-42fd-ae28-08db3c3e0b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGxthDudRjIiSIS746SUvh6eWv+d/XtRv3yzbYpTVC8ZDOq9W2sWYmOLL+wSl4JL9UxZNVD2bCH5+Vawv/w1ZlmXd07VkrSQmR1i4cJ7Q1EtN4DWXwaHnRyLkGKj3U/3/LK4a+nRruNciJGgfh8jfeGpEC5W7nfPzvmaEdmuRLnfJ0qXkzcflsLJ+xiHZTObW4OrRAhftbxOPNxJKxSRIS0D7oOL7IAvfevN6pOwY9hgf9I5SYUJMogqPeP5HV3pVDr0CSg6c+DW1S63q+Bo9cFF3kzHAuVya9oD/TZnzFOZ9iRfI/Tw5vrEt3wiQNwLI8i45uX7Tjt9QxFboSvHmGiWJ3eioTYB8v1NgooCCu8o6+rxdi45iQmPvqaNVTjKDaGx/qph0urFTy01hK/enXhtWjXxB60Ik560CqdfH7xAfqFG6w0NDmCJVf5HOAbj6MXoarJROrlu919ySsNCR2+SiT6zk/xhvK8mO7Yo9NOeGrmZc3DrFA7p8iQvZDMmQq216Nb0VNy5FU3h2Rbq4Jn7vZhgIukaQyeuuvjAaQZW7l31mXVDma8ibmmcnMJhr59jHQqn8K25qEFNnNvmsDeXgMUQE3nkxnK6kWRIdgZtr/5dleylIInCdzXChRqn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(5660300002)(41300700001)(8676002)(8936002)(52536014)(38070700005)(55016003)(4744005)(122000001)(2906002)(38100700002)(7696005)(83380400001)(478600001)(71200400001)(33656002)(186003)(6506007)(9686003)(26005)(86362001)(4326008)(6916009)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk81VlIvZThBUWtWMmxKQkVwNktPa0M0Uy8rVDhKNzhid1Fvd3dxelBzekZk?=
 =?utf-8?B?UUNUQVhma0FWaXNDeWFrYndCSkRWb0dNd3hkc2lMM052SHN6dm4xWFBzNkdG?=
 =?utf-8?B?dE1aRXpKTTMwMUx2SFF5SEk4c1FEaFpiOHdWVTA5NE5ndFROZjQwM09INEZ6?=
 =?utf-8?B?K1l6QkVqWVd3ckNCNjRnVnlLMEJDQ0dHdFh5TEFkRXI1YzgzeXJJbkNUcEQv?=
 =?utf-8?B?bGpXeVlSNmoxVHFuVmNaZTljUlQ4WHdMd1UyaXl0V2c4dldtbmxuY1pTZ0Iz?=
 =?utf-8?B?ZVVhZmJ2b2wrREtLUldTWFhoRFVoaG5XS2M0QUJaWXd6NkhETHBNME1SZ1ZU?=
 =?utf-8?B?eUZ4NC9LOXE2dWo4VzUrc1pIU3B0ZkUxbGFvRzNTOVFnU3I1cE5xZG5JUHdB?=
 =?utf-8?B?NVhRRTA0RVNVVHpRZ3ZOTElPT095ZmU1ZFRoZjBIdGFGSkc2OVZzZDRXMUZX?=
 =?utf-8?B?ZG5kR2FRdVkxem1BRFVuTlVxcDRaTGVQenUrMU1TN2d4bmVjNXZoRmxuQU5k?=
 =?utf-8?B?b2V3RmRWeXN0MmRYcG1BV0d2WWw1ZDJOUmxSR0VTWklQVVdvRjMyRTVWUWZS?=
 =?utf-8?B?K2hmaG85NHBMOVk3SGl0N1dERzdtVzdrakVYMkFLTWsrZk9rVzlWdFVXRE5F?=
 =?utf-8?B?TUg0eHc4aE1JSFVjQVg5c2pLTlI1YzhPME11ZTh2QTQ1TWw0SElEM1RCQ3dn?=
 =?utf-8?B?ZzVETTBQY0NiSHgyTWZZaHg4NTFaZFlKZm9wS251RldJM3k4a2tGdXRacE9D?=
 =?utf-8?B?Y25KRXYxQjV4VUVuZzUrQ0p1T3pLSUhaTStzREZUSDcvUyt5a2J4eWQwMlE4?=
 =?utf-8?B?M1k2YmlheWhpcENTbWFsN2VLcTlhSkpNcHc1c2UzVWtIa2VOaitMTzg0RVVX?=
 =?utf-8?B?NE9BZTBzU2hRUjVwdkxTTFhzNHVsOUpsWlJ2UUVxblo2LzZxL01pT2d2RGRz?=
 =?utf-8?B?eFVzdzJYVlZRYlA0SU9DUjJHUzhncHV0d0Z5TmdmRmhDTTdFZHEzNWRBczlU?=
 =?utf-8?B?TFhzWW9pSG50YW1JcVdkNUVjbi9rbHBvSFdpMlQwWjZ3MUpmdkI5cGtqOC9x?=
 =?utf-8?B?R1gwaVlZem5ubjRKQUJOV2JZUEVlSWQ3U2xVWURuejROaUdzZjdLNlpMWkJx?=
 =?utf-8?B?RU5VYXJaNHlFVThKcHVnV0d1QVRyYytTNjEvV0N2N1MyK1drYzdia0lwUm1M?=
 =?utf-8?B?dHM4NTQzNU5adzZDdTJ1bFhHR1lyZjlEVkZZckdBd1VpMGhvd1JpYm5Md08w?=
 =?utf-8?B?QTBSWndsaDV3bGI0blJmRUlXQ2VZYmN6SFRXcTRoVnhyTEE0cllraTNnYW5h?=
 =?utf-8?B?eHRVaGhoRlVLSW9PN1BRdXE5VWZoRGpQRXo3S1Q4Z2k1N0FDaWhSaWtVTks1?=
 =?utf-8?B?cUtOdU5KM0o3dnlXcllsZXMwLzJweEJCUGRLUXZsUnlta3UyUGFyVlJ6R0pY?=
 =?utf-8?B?UmJRdC9VYWUvS3gyZ1dTdTAycnZKVjBWRHl4SFMzZVZoTEc5OE16WEhBaStx?=
 =?utf-8?B?QTJKenJLRnkxSFkzL2ViT3NFVGdibi9jZ3h5UnZoUU9MUUEvQTNQNkY1S3Z3?=
 =?utf-8?B?cVJqcFZXREdYOFVnVnRzUXNPelVhNGNTdUtPdndoQ1lOMGlxdjczTGc4akha?=
 =?utf-8?B?YXhzMThFa1J4bWFObzgwWFBYaVVmbGNtNkM4MlZZNkdBSlpsRDd6UnlBT3py?=
 =?utf-8?B?c2JiTUs3T3lqVVVudm9nYUxqS2NRdThWSUpHZHppbjFXNUZ3RG01WFRQQVRj?=
 =?utf-8?B?NnE1RjlkWmVzVklwM3JyYllNcW9NcnZTWW51eFUrYTJXd2kvT2pOODRZby9U?=
 =?utf-8?B?c2ZUUVZaTU1yZVdvay85WW5NV0crUzE2a3lFVCtNZjloY2hvNnZhRGlDai81?=
 =?utf-8?B?aHpZeVhYZ1I1TlpPMitlYkVlMnk5bitVQTVOaHk1b083NCtCVDBEcHdBNHlD?=
 =?utf-8?B?a3ZqTWlrVk50MWowQTVrZXJVNldxcUhmWDhMQmtaOW1wWTFNV202eTgvRzdj?=
 =?utf-8?B?ODZLSXprMitBZ3lrVGVWZ1JHVTBJZnU2V3RtV21uQTN0aGJhQ0x4LzdVVjdu?=
 =?utf-8?B?NVlVazBxekVPMEk2WGltYi91aStISnc5SGFucml3RTF6dEJHSUpleHFjVkRF?=
 =?utf-8?Q?hJ9c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96c955f-b747-42fd-ae28-08db3c3e0b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 16:42:18.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+G8NsUUC806HzsLxEiY/dA9UJ2K/1FLAueQVc+8szOBu+nu8vxrfivgFKxIogtWg22SDFSfJQRUI566+uIHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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
ZGF5LCBBcHJpbCAxMywgMjAyMyAxMjozOCBQTQ0KPiANCj4gPiBJbml0aWF0b3IgaXMgbm90IG5l
dCBucyBhd2FyZS4NCj4gDQo+IEFtIEkgY29ycmVjdCBpbiBteSBhc3Nlc3NtZW50IHRoYXQgdGhp
cyBjb3VsZCBiZSBhIGNvbnRhaW5lciBqYWlsYnJlYWsgcmlzaz8gIFdlDQo+IGFyZW4ndCB1c2lu
ZyBjb250YWluZXJzLCANClVubGlrZWx5LiBiZWNhdXNlIGNvbnRhaW5lciBvcmNoZXN0cmF0aW9u
IG11c3QgbmVlZCB0byBnaXZlIGFjY2VzcyB0byB0aGUgbnZtZSBjaGFyL21pc2MgZGV2aWNlIHRv
IHRoZSBjb250YWluZXIuDQpBbmQgaXQgc2hvdWxkIGRvIGl0IG9ubHkgd2hlbiBudm1lIGluaXRp
YXRvci90YXJnZXQgYXJlIG5ldCBucyBhd2FyZS4NCg0KPiBidXQgd2Ugd2VyZSBzaG9ja2VkIHRo
YXQgUm9DRXYyIGNvbm5lY3Rpb25zDQo+IG1hZ2ljYWxseSB3b3JrZWQgdGhyb3VnaCB0aGUgcGh5
c2ljYWwgZnVuY3Rpb24gd2hpY2ggd2FzIG5vdCBpbiB0aGUgbmV0bnMNCj4gY29udGV4dC4NCg0K
SSBkbyBub3QgdW5kZXJzdGFuZCB0aGlzIHBhcnQuDQpJZiB5b3UgYXJlIGluIGV4Y2x1c2l2ZSBt
b2RlIHJkbWEgZGV2aWNlcyBtdXN0IGJlIGluIHJlc3BlY3RpdmUvYXBwcm9wcmlhdGUgbmV0IG5z
Lg0KSXQgdW5saWtlbHkgd29ya3MsIG1heSBiZSBzb21lIG1pc2NvbmZpZ3VyYXRpb24uIEhhcmQg
dG8gd2F5IHdpdGhvdXQgZXhhY3QgY29tbWFuZHMuDQo=
