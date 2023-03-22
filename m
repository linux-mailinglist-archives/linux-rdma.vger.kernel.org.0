Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493E6C535F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCVSOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVSOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 14:14:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADB61897;
        Wed, 22 Mar 2023 11:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEdfnGwJhAGjIABpaC2Mk5IOA0MriJbOatJ/5Lg921F6TBBsX0pnaSFcCdCJS0RKd9kQ/frKeeuIydc016sqAu/obBFXL9glsKXo3N8jymZ5gyZ4fmXq68wpmgmgw5a0GiIRMnOGUZH4wVgnAHI8bzOONQfvP0Y9G2YeKQyV6YbQiMNJyqDwOT+p7pzwp5waOK38OCZI/tzzrEm03ZmhdBD6Y80iJcWTsGgxARlZmtuOeZbIzg/XkLi67vVl4JtpaaDcbFwdp/4nvbIXnxuEi6L3XOmB5RcsDy3jMlKobHRIphp3C9OrvuK8BYSEgP8CrLRi/fkkjKGZ+/AB0x0qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsU6zMgugdbSwrhZSqil6LLbB66MRDHg1WYgVomhVQE=;
 b=E2X2IUUMcZtJeE2ogkvz/30N1Z2GpTLv5TO4q7y5SwwM3zqKwkUqTGj+R7WKK9jU1xqVlEp3yXOBig6aMZSOQLqWATwaFsiNhkBX6QiUDekhvl6crbp/22dhbAZfUBryfF6JmEWvU+ONvb844QWQ1DAI5coGifw3F37SGny6KSEBqXeQxlGBaDt3WqnsKzS/Kiw6BxQjXm9lanz309YW0BIgNJ0ML7OSGkHqwBGWlpZPsZPB50wT9LCFfXS3S/YPXWyH3ULSCTQi5z31fZESPX859v0eMQXNDCM9zyA63VVyTUi5NoSnG4PeYZKWx+iGoKca0eewcQQZRNVe/mBKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsU6zMgugdbSwrhZSqil6LLbB66MRDHg1WYgVomhVQE=;
 b=JDMklHB3s8/PG85rPT1AapXpSIYs2yuJD6Y6/AXtdwsvvm2wpmiWWDxgDrR06IT9z9u7LCXb/4n6CaD/gIdTbE7CbEJWGQFZIJ1FB34pKM6JUB7X2POWlSR7r2yAyUxuT31GZS9BmC2sNRNcChjhPDMZE/rD2Cjo3YxMWiYH44fKNQgobTGpsHmDZkTb9nvnasWj/+Eu4/XKRPWv5Smt98cBqD4vekjEXfwxviM4PA8Vd47ZWlYL8uyeSWDygQTIEyYiadxumA/bllB1jUnLX7p+hLz0g/xHs2jjfZGmMRY5Vh+TNS/GfyoQaOu7ogpxb7sLIvKtR1nYHwD9UsgDFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 18:14:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:14:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Thread-Topic: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma
 devices
Thread-Index: AQHZXLsKHjYMnEpKYkmjsZYFemgSBK8HGsSA
Date:   Wed, 22 Mar 2023 18:14:17 +0000
Message-ID: <28cee6ea-3802-aaf9-755f-3cdedd12d2b4@nvidia.com>
References: <20230322123703.485544-1-sagi@grimberg.me>
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5298:EE_
x-ms-office365-filtering-correlation-id: bb6f5f7e-712f-468b-977b-08db2b014023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNHC3oilGUL2LYRQbJpQUDxQykpCZ2Y4mywbN7J8JNvickL1tQtrLZ0NA0aTgZ+NBQVjrgGneyfIaxQbVHsX5GgllTbq0vUm/pW/GUsYgl/z+o/HwIqofYYBiq7vTi8OyjcjJehHM8tzVDDtE+UjoYeigFHphg3ss3U20xjlzeyirrZfPhfGIS2kYhpgIlqm4durZX4aquv9bZyMSiwd9FwIlLHHRY3ERTeuiJkkcIy8FygHZdX0dK0Kiy3ywdJ0wlzKnluorh0QjEIi9C0fAMt4kFWTJ2ULnEKpqmHGr/D/KKI1VzDxh2iLHiO13ZQFAMVABCu5nc+pOXzJqc5+IQG5vkklmbDFBYL3i47Ue2rhY9q2MzNy5GR19ZGoERyIhpyk+FYwdA3AMYUSznFxs0F/behtlzFRlksWhJOvvxcVyGwSGL7goDwLTNBWRb+7e1sXe0l793f2qMP96UvqfAAhtMhD26+OlFDss85lHSn/5NdQ06o/MJn87CYlxD2ZFlq/KVbW2gx5wedYnQEs7wtjRive1irUg2QcV9LL/khP/kTgD9EV2xmA4KlrY4xlQ74jJ0WeDbCmTtNtfuUWv4C/KfjC22l/E6nUFWqou/Zz1mjlt4Axx5o7lJ32L6AewED6qVCe7+FWT0eTxZ0tZa8cSkGw5c8BXQRB+iMdIqDcdh8HqFjNN2yd9CUIjwFOhSZkaz4ViZk3IiF6dX3sJ3HYBJJ/FlfMHB9UpYZE597uP59cTFNT6JQ9l9sUyVgkl+xb4pD6sK5kqRwZG3rC5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199018)(86362001)(31686004)(2616005)(6486002)(38070700005)(26005)(6506007)(6512007)(53546011)(186003)(71200400001)(31696002)(38100700002)(478600001)(122000001)(2906002)(4326008)(91956017)(66476007)(4744005)(54906003)(66946007)(8676002)(110136005)(64756008)(316002)(5660300002)(66446008)(8936002)(41300700001)(66556008)(76116006)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlJCQTF3UWdiZG53QXk4L0FIY2lFYWNJMFZUb1dRZER0TVpqeVcyOEJoZys1?=
 =?utf-8?B?ck9US2g2TUZVaWdqYUVGK1dsa3hQL0JwbS9zUkQySnJXd1poTWV4WThSOHZa?=
 =?utf-8?B?dkIxZ2ZyVXVSdTJhT0RSazhwTUNqRFYxQ2lWN00rVUltUDg0TzUwU2U3WVpz?=
 =?utf-8?B?dS9hczZqYkdSdXdGRHplQnZTZXd2MnA5N0NyckFoVzlBbXpYWUtkODh4VEFP?=
 =?utf-8?B?MTFRR2x2d1pDTGNSTmdONS9xUmt4NVlFVVA0clJYSlo0aFFxTlRZOTIzRGth?=
 =?utf-8?B?Q1ppdnRsd0o3TzJiWUFLTGg5WU9NTUtMbkxLbk1xdG9uMFVBZ3NNTTJWTjRW?=
 =?utf-8?B?VEFveUdsampVUzJFNHFMWEZWNDB2Zyt2dDhQTFZVTU5aYnIwbnhyYVpXa2t1?=
 =?utf-8?B?bE1IYmtzN3ZBMmR2aURZMjBQc2FUakw2ZlczVjJMQ25DUEtUSklhUG8zM0Rt?=
 =?utf-8?B?V1M5L01MOHpHTHJydTRpcWc2UHdieGpCSnY2Q3Brc0ZRWkJCUWZreVlOZmZq?=
 =?utf-8?B?dVVaQVYzQm84VFVvYldCazNVdlN0UkxtWlZHTEszaEVSc0FoVHVhZWxMZ0tz?=
 =?utf-8?B?dGpDMnZjVGhXRys0QVZCamVqeGROcWcraDRaMEltbitPN1RpNDBSbk1xd3dq?=
 =?utf-8?B?S0NyendDQy9TVXQ3bTJiMFJwZ3RNdS83WXdtSkRzN3grMEg2WDR5aFBxOVIy?=
 =?utf-8?B?YUY3OFdiYXhQV3FrZXZCSHJmL1ZRam5aQWxBVmtnUUV6cFFMbkhrcUU0d1lB?=
 =?utf-8?B?VGhpNkpCWEh0UjRaTjFGMDZJeFNPZk5CZ3BnQUhBdXRDYzZyVTdTSVZneExY?=
 =?utf-8?B?NXlpb0hPY3RMZjFEdTV1dmV0ckF2Z0pwUmRnRTFiYk5FaU9vOW5XNkw0TTM2?=
 =?utf-8?B?YkZGNS80SEJWZmdWVlpwUUxWZmw5VXVJRlZtU04zU3J6ZFo3ampRcW5qekxl?=
 =?utf-8?B?UVYrcjlYdHBOdDRldmwySktQYzYwTk1FbjRWS0hoenVJM3AxcG5PaU9vdXB2?=
 =?utf-8?B?dm56dis2Y1R6aTd1cDMyUnFSZFhLampnbUhHOURHbFhidFdlQ0ZRaXh5SThn?=
 =?utf-8?B?WFNEN0ZnNmVFb1ZaUzMxb1QyS1pvWmYwTmwyd0lBNThBRlJTVkFRa2JtY3hM?=
 =?utf-8?B?ZkdPQk5hTDVSTm5McjI0ZWNIV2ZMU0V1SURzZTZLb1NJRFZQQ0p1K3d5cGdQ?=
 =?utf-8?B?MXN3L2NJbXlaUWRnaC9MMlRLTzJqb3hoTDNtc0haNldBajhyNkZ2UndmUGpH?=
 =?utf-8?B?WFhHUHdpWG9qRkFOMTVDU09vNGlDWHV1cVBlQVhtRmEwVCtjNlBocEVGL0NE?=
 =?utf-8?B?aWRUMURhZHNnY3QwSXBLS0xHVkd3ZGExWnpnYlFMam52a3hDaGRNenpQUHpl?=
 =?utf-8?B?MGVwd2szTmpyYm9jdjZQNUc1M1BrQjJrUFJtQ1FpTmwyb01MSnkveGduNXRk?=
 =?utf-8?B?T2NTWDZhMVh1Q0Vxb0RpYjZoOThxclUralNTbzBDWkFTb3RFc0VoLzFnbkZj?=
 =?utf-8?B?TktiQjVNRXFZd2lmQjFkNm9ZVGFaQUxwQ1BpNDdmWHdiRTkrU0tnL29RNzRT?=
 =?utf-8?B?RzdoSjJ3U3cycU1EV2FiaFNlNHJsT0Fta3BhSExVdkNobHRQWlovZ3VBa016?=
 =?utf-8?B?bkF6TnhmT3JCYmU4bTUvUnBIOUl1Zmw4WjBmWHlvL0w4a3lSKzIzVjlpY1Jz?=
 =?utf-8?B?aGZWMmU4bVZlTm95VC9lM0VIaW93bWRLeWZQb041RTQ1T0orek1Qdi9peHpI?=
 =?utf-8?B?Z2V3bUZ3bklNZUtpR2IwSkdVVFQ2ZjI2Ly9DTm1TNytHTFRaRHA3WGcxVUNo?=
 =?utf-8?B?cFFZVTlkTE1pamFiVFVtQ0p4eXdkcGtpWU1QYisxM3p4VTl4RWkwNXdnUDJQ?=
 =?utf-8?B?QWdwT3cxcWx0bjVDSjdOWW85OFVlNVZFWHRTSkRGRVhjaEFNQjBub1poNW9R?=
 =?utf-8?B?aE0rMmpqZFFuOEZ3RXFBUVljWEZwZTVXOGNDV3ZSWWFJUVl0dkZRQ2VDcm9z?=
 =?utf-8?B?WjhyUzkvbnl5bENNank3TFBhMndPbTlnV0JkdHFtUW9QcUFLYzZnSk9CQVFI?=
 =?utf-8?B?YlBKaGMxc2NPc0xMbmZEdTUzd3ZNcS9RSWlCV2ltWTRhWE95RHlXbUVRbGhP?=
 =?utf-8?Q?M9KkYAOcGN59Z2d0+Xti2f6AG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CD4E70615934468B626F4B8D65F667@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6f5f7e-712f-468b-977b-08db2b014023
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 18:14:17.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQZ6EoKGxxZltg4MWoRNRQw/d/lcQV7rLJlPtTb6AQ86c5x0wg3L8oObOtpKahLk+9e+Sg1CItikBRAM3YrOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMy8yMi8yMyAwNTozNywgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gTm8gcmRtYSBkZXZpY2Ug
ZXhwb3NlcyBpdHMgaXJxIHZlY3RvcnMgYWZmaW5pdHkgdG9kYXkuIFNvIHRoZSBvbmx5DQo+IG1h
cHBpbmcgdGhhdCB3ZSBoYXZlIGxlZnQsIGlzIHRoZSBkZWZhdWx0IGJsa19tcV9tYXBfcXVldWVz
LCB3aGljaA0KPiB3ZSBmYWxsYmFjayB0byBhbnl3YXlzLiBBbHNvIGZpeHVwIHRoZSBvbmx5IGNv
bnN1bWVyIG9mIHRoaXMgaGVscGVyDQo+IChudm1lLXJkbWEpLg0KPg0KPiBSZW1vdmUgdGhpcyBu
b3cgZGVhZCBjb2RlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPg0KPiAtLS0NCj4NCg0KQmFzZWQgb24gdGhlIGRpc2N1c3Npb24gb24gdGhlIG90
aGVyIHRocmVhZCBvbiB0aGUgS2VpdGgncyBwYXRjaA0KdGhpcyBsb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
