Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4D4AECE9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiBIImJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 03:42:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiBIImH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 03:42:07 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739BC03E949
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 00:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXfYNMUuuhgNUKnhFmpOXLKMwn44K7juUuspOgKPldHJhKLns3JEj0nGrVaiHazL5GXY6fz/A3vVqX63cH5oAAmMGj6vsCPlL4yuow5tBBQzYPoYheAZyhbvyHquV8sFgpAKGga4oKxdxXiJlHiyUStDiIJT3CyNNgaQkrO886vullCIyRkXZev5ywkn9tcswunV3rZ/ebFgs3n9xSBcPwlLOGuIEyCoAmDYERtAlFTh2ntYeabTj4CTvihocuVyCnKlNEXP1lbSdmMQHNVK7tEW+0Q+XmatgxCHBGiBjIxVDYRRqTvFyIqR8YgO0pSuW3NQVbiHHfHImQRModHQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVOGMd2fu1/RTnal7ugV+22PhaBclwGF6CeB1tY+xxU=;
 b=DEDZ5jUqo+vD6A0EWICFeR0p0I2cGfSw0ROWnjMtWdYPdEqM6ocHCt3ZQlRzRPtCg/xj2Mk8lQMhDvo2XlHnAOYUUsqjCYJURUOXOqqNZQ940USmKfHpRFtRO2FL2NPtMdpKYRFCg/KU/ZoKEbFiCn3nu8cGiHmFxuCbuvow/2+wehC70NcPhhBvQdfTygbXIOy1bOV1usueczkRGSlcYEjkGfJAd7CMMQT7rsbd78RD3DRGUS4XuMv9xSFeoq9PPz1NYQzkXJGTbsHCWcIAqFnuyCbwztSjaQRusIRiASUuhzo9TmmLgUGHIrPgcDahcRl1c7YP7doW3RLQMQYNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVOGMd2fu1/RTnal7ugV+22PhaBclwGF6CeB1tY+xxU=;
 b=shEDq9+MZPdhyqGB8zMCH73qiRZdzjQmMyb6XiXKul+eubDMC5NTrIy25C+v/dknCEGsjlZQS1ppDKiNuzxY0ppphNqkT4mCq6WDfbrMrNQj6N4JBqhNT+YoQacfvPoBJQPBt6/Z++cn6OiAOaJmTr3g2xlJ74Tt1A3fwMP8A8CCgRhN/TFrohjSHZsBVYfEyh/9422r0zUJ1Jl4C1a+nq1Y7yT8sqmkMVa83KuPg3+ks7671coy9nCA+OgrnLhMK469mqMHrqCYiRHeujiYBiVxwRhGkmvlIo2g86p7QJWOQPh/LW1OrQxnMOVRE34wYcVcnmApncoF8pTep3EFjA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 08:41:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:41:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Martin Oliveira <Martin.Oliveira@eideticom.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
        Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>,
        "Lee, Jason" <jasonlee@lanl.gov>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Topic: Error when running fio against nvme-of rdma target (mlx5 driver)
Thread-Index: AQHYHRbxB1j8kCqLyE+mphWtfDRQH6yK53wA
Date:   Wed, 9 Feb 2022 08:41:30 +0000
Message-ID: <62fd851d-564e-e2f3-1a40-b594810d9f01@nvidia.com>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
In-Reply-To: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3308915-30df-459f-f17f-08d9eba7f869
x-ms-traffictypediagnostic: DM6PR12MB4910:EE_
x-microsoft-antispam-prvs: <DM6PR12MB491042779A29FD4B05CD7D2BA32E9@DM6PR12MB4910.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6/ej5x8JSDpf7sQy7xgdaODXNjDAxEZbAOUXca+I9aH2rJMii7qPIByNGxfHjlt/52DW4BKokWRfAZjekuRceciU+2/l3fZJRik22n9FluxqnYHLn4jRKaZRvI+CfvHB5P4EzgBL2GOPXleSqtRitEAqV/Ki+Hb8oaPCTt7FTYbBb1BP3MeNVsIaeJkvxei9mgkJtacJviA6jzR1/P9z4NM640Bxn8pNLFbgKCuNGhqczSTIW/owIHQJeGkBTfnmnrOjYybiiXuEeFaj0nl6MH2fD9sFH4C6utW0jrcwhACgt+mXu0K9n6LvmGQ17efzLwYH1/Ur059f9O8cv0sRofuJm8hHCPWoWXc3zQkYO7jUZ976PfFblASBshzSuO8n5U0W1+0U7Q0tIU4zv3jgw0HdlQCiB25Q+1BGK61PF+PDA3k/wvZ5OSXHQM8seYCdCGGPzszjNvj912mopy0xnurYYFV7/8H5bUwZQk59CAoJNHC8DR/n35u9KxTW8Ns44h10wX8bQwMFbv0l0/q3shJsJXXiG2oC+9H1zQQj262aiM680s3KoDJ6f4ArSMXtRUsxznfXnEHap0Vsv3E9/wL40v8zkddnEMz0dgxWiT1rVpzV5NBu2uTauQ1QB4gnOac6qVgATPxyuQAglVEKxrM1qAmPfOhx9pwlUuhndwkGIvjtEvnQj149/NPSv9iWWaTXMqpL17rIorfhzIaVuZFjQdHtSZr1NV+09Kc6ld8ict8ua5cCkNqBljRpRHvQRiDEE0vGsHcyQhu3fl0Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(53546011)(2616005)(36756003)(31686004)(71200400001)(6506007)(76116006)(316002)(8936002)(4744005)(31696002)(38070700005)(5660300002)(186003)(122000001)(6916009)(54906003)(38100700002)(91956017)(6512007)(8676002)(4326008)(64756008)(86362001)(2906002)(66476007)(66946007)(66446008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdRYzVyOWJwSTh4cHpNSmxwTXRNeVJiR0NjWDhWS2JXaGZlTEMzUXNRSnpl?=
 =?utf-8?B?TW1iNCtOSDlrMC9hZEs3ckt4Njc0Z09TUWNGNzRpblFDZjFBNXNTSG5aKzZI?=
 =?utf-8?B?eTNIV2hJN0JGdU9UZUlPaEZURzBXWHpYcGxwQkI4NFF1dituRlVhZ2ZtQUox?=
 =?utf-8?B?eE9tRGd3QkpnUnRhRTY5VExBVCtVVFlpMXJlRjZ6eTFZTWJTZkNPZVE3bHRv?=
 =?utf-8?B?UFhoV0tMNlF2RU4xbUYzM2ZMUS9rWU4ycUJaYnZhVUM3UFN0RHNBVlFGNVNz?=
 =?utf-8?B?dkhyeE9RcmdzQzNBcnRBUEpIK0F1ZUJlaFRwTUZEOUM2dmFqZ1dqZXU5OWRk?=
 =?utf-8?B?NmlmTktIT0NNaEVyTE1COWVUL2FIblR1Y3dETVNGSTExdjJOT3MrT1RzRko5?=
 =?utf-8?B?YVR3eEZSdFZPei9uV0RPNE4xKzU0VFlkRFNGK0RmMFgxa08yZTkxUEpMdUV2?=
 =?utf-8?B?NFFNMy9PKzZaLy9wL2xYNnAwUjgrNk5nMnZ0WU5FazMzVXhyTGhxRUhuRUV6?=
 =?utf-8?B?aVV3SlArOTZabk5UcXpKMStPcExMcDBNWFJQSE55a3FKTFhiaFlRSEpKdVMw?=
 =?utf-8?B?NTllb1h3ci96MkpMVU90QkYvL2N3bWtWUHNwcmJwelptZmM5ay9vTTBDN2Fz?=
 =?utf-8?B?L0VmNEIxK2tEUGM4ZVp4d2tsR2hjSDJEa0xuWnpWcE5DeEtNTWd6VWxiUVpJ?=
 =?utf-8?B?N1hhaHU4dnNqQkV2eWYybzFjVUtWMjcvZSt1aDlTSlNPZnRoR3Bta2x6UURw?=
 =?utf-8?B?ek1KcXB5Q0pEWlkyS0lEZ21QaTVwYkUwNU9lNnB5c1B4TWpPLzNuSEtVT2Jv?=
 =?utf-8?B?ZzFPZ2JOK0Jnc3pILzkyU3RWZ1hMVjlYSHBYNUYzdDJyemUzMEc4bGlSd2hY?=
 =?utf-8?B?ejlEL0YvRmNLOStUalRXaTFYQjZOQ3BxaUxsSXpuVTdFWXh2KzVid3Fta1JN?=
 =?utf-8?B?ZVViMzZuV1VsNVFOUGNlMlY2eWNXS2VoQ3h5V29mdDVSc2llbUg0azcrdGN1?=
 =?utf-8?B?L2RFY3FjaC9lOGFWWFkrNy8yTW9pWXJVajNvaUpWRzR0UjlRUjVVbm11THBo?=
 =?utf-8?B?QmZSMWl2UWhJZkZZaW52YXpaQmwxMVJFY3FyQUFBdlNpMlc1UW5HLzV0S20w?=
 =?utf-8?B?Vlhwa2txNUZVTnhhcUZqQ3pRNi85NkhlWTBlVUdiYXltY3hOcWJDVTZpS2gz?=
 =?utf-8?B?MVlPV25UbXVJRlRLenJacHN3RUs3eHlZS3QxWkNhOGdHVFRBc3YxWnZvZGRC?=
 =?utf-8?B?U1VSdUtzZlgzNmt1ZWtoc3l4NDdZVzFJaUM0TEpzQWRsRE9CTDdHYkpTZXpC?=
 =?utf-8?B?a2hEcG9GMWNHbG0zSnBDRmNwZUJSOUhwQ2JCTXNwNjRTQVVjS29CejZ4VkdL?=
 =?utf-8?B?a1FmZDJyWHIxNTFaamlsMlBiNm1SRm53UWtGSXJQTGJMdW5ZUW1kcXdBS1ZE?=
 =?utf-8?B?MEJoajk1cDNHdUN1VHFhRVhNbDJiTWgyRnpabjFxd3B3OGZkVlRXNUNDM0Jl?=
 =?utf-8?B?bUE5S2c0VEJZVGRIbExPSXdxTTRXdS9yaTNTT2dtSnZJZWFRejBsakFOaTN4?=
 =?utf-8?B?R0p3NnJiNFBHaUtMRUJsQ0N2aDBzY3Exb0l2NkdJTEgyMEt1andpeXlyVjZx?=
 =?utf-8?B?S2J2aHQ3ZFJ4eWdqRW83czhiZy9nd0RpZ1pjU21kN3U1M3ZkbTBOOVorclFp?=
 =?utf-8?B?Wld0N0kxR2M2dVQ0TzhwanNCT3o0Ull4QlBUZjlER2hMYkxIb1JIQ0ZTUG1l?=
 =?utf-8?B?Z3Bhb1dJbExIbnBDQVh3S0xFcUMvQjZRenRoZDgzaVZzTHVvNDcySXJjVVk1?=
 =?utf-8?B?MXlZQlpTbVRBbjdhVllqaEZkSXpPMmFXd0ZmYTBzK1R1V2g1aHVzYzRVTy9O?=
 =?utf-8?B?dkpKZ24vQlV0bDU0ZnJDL0Vxc3VQenc5akJKeWU5UHVFUWc3bU5IOENHZ21z?=
 =?utf-8?B?dis3b252K2cybU9xREd4eEt4VzNPZk8vdmQ1MXFURmJHU3hRQWRFUGhMcURV?=
 =?utf-8?B?blMra00zUEJMOVk3NG1MMTdmWG5wbk5jRyswRTF2emdLcy84Rmp0a0duRHhs?=
 =?utf-8?B?dTE4dGx5bE1CVkpCYmlrRitRODd3THppamlJWVZQcDNYWHJqZ25NMGJmVTF5?=
 =?utf-8?B?cXRMZWU2K2lDdkRLNXFUVzhvV0FKMVNrV3JqQjBwT3R6bmZjditIeGFpb3Fs?=
 =?utf-8?Q?2sFsH+geVKXQiPUMvqMWBYrVdW93SNqruFiu4e3ICrwC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12F8674CF6350D4DB366044C884075FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3308915-30df-459f-f17f-08d9eba7f869
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:41:30.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNClqvQpXbjsaPltqNL2KOhA6d/l0eBjxcefl+wHjNgTNvnC9uP0mE6M2hr1ohLu0iDjLMnkBeefdpE+x6Duag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi84LzIyIDY6NTAgUE0sIE1hcnRpbiBPbGl2ZWlyYSB3cm90ZToNCj4gSGVsbG8sDQo+IA0K
PiBXZSBoYXZlIGJlZW4gaGl0dGluZyBhbiBlcnJvciB3aGVuIHJ1bm5pbmcgSU8gb3ZlciBvdXIg
bnZtZS1vZiBzZXR1cCwgdXNpbmcgdGhlIG1seDUgZHJpdmVyIGFuZCB3ZSBhcmUgd29uZGVyaW5n
IGlmIGFueW9uZSBoYXMgc2VlbiBhbnl0aGluZyBzaW1pbGFyL2hhcyBhbnkgc3VnZ2VzdGlvbnMu
DQo+IA0KPiBCb3RoIGluaXRpYXRvciBhbmQgdGFyZ2V0IGFyZSBBTUQgRVBZQyA3NTAyIG1hY2hp
bmVzIGNvbm5lY3RlZCBvdmVyIFJETUEgdXNpbmcgYSBNZWxsYW5veCBNVDI4OTA4LiBUYXJnZXQg
aGFzIDEyIE5WTWUgU1NEcyB3aGljaCBhcmUgZXhwb3NlZCBhcyBhIHNpbmdsZSBOVk1lIGZhYnJp
Y3MgZGV2aWNlLCBvbmUgcGh5c2ljYWwgU1NEIHBlciBuYW1lc3BhY2UuDQo+IA0KDQpUaGFua3Mg
Zm9yIHJlcG9ydGluZyB0aGlzLCBpZiB5b3UgY2FuIGJpc2VjdCB0aGUgcHJvYmxlbSBvbiB5b3Vy
IHNldHVwDQppdCB3aWxsIGhlbHAgb3RoZXJzIHRvIGhlbHAgeW91IGJldHRlci4NCg0KLWNrDQo=
