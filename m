Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275C7758B24
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 04:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGSCIl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGSCIk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 22:08:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9456D12F
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 19:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boJjw2cZJqZZIOoUys/CrJAOx4caGYk5Ez97m7+QfDoFcg+zq3TUR7xgEd81QmbXx7a7SCb3r0f3fypJlcXZXeKWuePMKkj6G7wEDnQVThh6AOSrToWYlTK8ylsk+PlcYKGyuz8a0Atg9XQtDeMSibLG5l7fcdb9MPszK1nNOfjXbb8LdjfOfsI6K8vliHS3iwbVApB3IhLCoAMFrzxQgKZho5R4ucevomssfSApq31b35Ea0a8SakVkdkcu0yuVN80zlTX05oLOAEsBMc+2QWtikxE0lgaeDi5QJuJn/Wa5O+nTQMivOrl8DN4/iPAy6MG9lhLjiJXq07QZxkUePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vwI3HSSkLdyJRahS7lkCIUHaRp7tln7yYZ9I7t2EXE=;
 b=jsRfkE3stlp37OQIYVyhJOFw7+oe3oBHFm+Ar6shO0s0DOSz3F2f6YcAsEKy9z3YsiV0whuyuqqbVqa9XjSQEKIIBE3wiv7dFbNo/vUd6GxmO1aEKnJMiFjGo8Gkq8KOVYIgHUblrr9z+cWgLKCHN475CVO88Yf93GbhXi6kABe5JhnPu2xvp35gKwcR7gAU+3LxLWUe0P5JtMkfpHuYbYUgu2Xh287z4FpGzIE97sUuleiMVKS8FlQ99pS4jAxV/LRzNGs2y4ay0yUpkftNh+O18cdwY943Hy1ZRWHCQkqSbicrtDXRnZ1FtcbX2xCtE4UDIrTTnN+E1ewxKMs+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vwI3HSSkLdyJRahS7lkCIUHaRp7tln7yYZ9I7t2EXE=;
 b=ELRNEm1XN+dWAVgYqw0hQOhk/+JPoXiHvAtD1g0eycZSfXBtpBlxBMWjygs3kDe50pxd1in3bLW9S66ulf29hfLB7BfdvLSeCAWhfN15EDWKRF/TBIhyqDVPssbZKnc6/PQUlsGU4huCfjxMJ6KKRNDrmczx9/hz6veLUSszxMlgn84Ku8CVnKi19GZIXSUhFdG8RvtepExgaHcDSl2ya7VnilejhTKdcQwNjhYZOEsMuXhcagdK8yw7iqvs+wtLsba+hIX9nHH1MtrcR5XYRTWC0CGl8rEgzOJS0jRy7JTAb+AEUgxQAWI3uWJ/6vWHHAZfdFrmzUBuIrbVWc6xlw==
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:08:36 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 02:08:35 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     Jonathan Nicklin <jnicklin@blockbridge.com>,
        William Kucharski <william.kucharski@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: mlx5: set_roce_address() / GID add failure
Thread-Topic: mlx5: set_roce_address() / GID add failure
Thread-Index: Adm55ey/EGEFEcSgDEOfhlvtCuI8yg==
Date:   Wed, 19 Jul 2023 02:08:35 +0000
Message-ID: <7256cf0a-4a4e-2c28-b74a-21026769d43f@nvidia.com>
References: <CAHex0cr5NVCpERLfudrTk-rhHez0uodnkbj5fp5X58zh3DFvfg@mail.gmail.com>
 <64BDF3A9-86BB-4F55-8F28-161C7B92ECDD@oracle.com>
 <CAHex0cqHgjRuxjGX1=t-OFUv6=5nMuVJE+oC6w2FC2p-OQichg@mail.gmail.com>
In-Reply-To: <CAHex0cqHgjRuxjGX1=t-OFUv6=5nMuVJE+oC6w2FC2p-OQichg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7495:EE_|MN2PR12MB4582:EE_
x-ms-office365-filtering-correlation-id: 635b4313-f80d-48e2-25cd-08db87fd0f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNtltrvsC4o+XBsj3kNl/JdO5xXDj0qDWBKkNotZMMVL/dEaKJQe76hUN8X6Lm6+CJoLI1gfEoV6gizvLdSBhKizOQnRIpz6JltJHqShQkpL7RhuvATTBdknpEnQLYQkySQKGD3MnXc3yRcVVzmOEw/4+8HlDssFVUkeVoFV5xCXHb9XDz/PJGcUGn9pthtw8LkpO3CcR6/iJgWqYXB/eF0bF4EV95qdpK5dPS7gPKJtI9p+9C6UKH+MMhkm2IQpntsqzRC5VaapbD0AHp4DQpHWwQ9MwMPAIoEVDgNa3aDLCkC8k8pf06cFp4ZoEc7apYZPh8fKSNooyKTRlkVcBmNDb0ToiCTBmlIOQn7OnXlqF0Cyss5rN9lkHVfcBbUjCvhiR7uya1HPY3kufFo85vw48jjGAPtbs6hnQfchnD6dC6VE3NU9wVAD41e9yJmhCRHByVDHeNny+Um+tUTPV3kNPCXYJerlQhWenf8LTf5xh/yzL1sDZi4BbKJ/tdpR6ALX8P7/eRoYoMx2/LelIly70riLZsqtOFT00aLg7KRTAUwq0Vhq8Ne+pV9fg27n/GysuXuabkZ5yIKo4YicbtkKj+s+WgEAnsa+fkdDqobTXPhvnQUhTJQVK5oL777+/8CVER/vsRr3b0z61/p8/SyQVCG1q17YmRBQetBrtRmdwtlqTbjv83ecCC9l8Bqh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(26005)(186003)(53546011)(6506007)(6512007)(36756003)(83380400001)(86362001)(31696002)(38100700002)(122000001)(2616005)(4326008)(66946007)(66556008)(66446008)(66476007)(64756008)(316002)(8676002)(31686004)(41300700001)(5660300002)(8936002)(2906002)(6486002)(71200400001)(966005)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnpqSzFFU0toWXBMeEZHbTVZdEZnZHZIbjJJZEJzNGhTMW52OTI3K2ZscW9Y?=
 =?utf-8?B?b1d1bG5lYXpRWGh5bHkzaUQ3TkMrK2NQeWZPZjNkZEdadXVjZWhPdTBHWmw1?=
 =?utf-8?B?VTlvTmUyTEh0YVFkZ1dVY2s2d3lLRUJBS1haRnljQ2NHVktuUnM5UUpleTAy?=
 =?utf-8?B?bUp6THVzbjJOUGxsSGpoZVVXTFlERU1laWJzVW1MQ202WmlndXU3anFrVXAx?=
 =?utf-8?B?b0UvL3lIalNEbldQbnJaeWRVK3dWQ0laY3NVU1FrMVJscUd5OGxreDJLK2FM?=
 =?utf-8?B?RTd0ZUZkQjJSWFdxSUtEcjVza2xCZ01qNjh1VzUzdlpFejVnd3VWMG5nZ1NJ?=
 =?utf-8?B?UVRJMEhEVGZaZTlsT1hTT0hnRmVEME5Mejg5eTY2U2JFVlo1M0ZBNzdRZE9T?=
 =?utf-8?B?ZUJyZVA1a1AxQWhoOHkrd3FlK0dRalltWW52aTk3VDJXdlFiU2VjV29BM3lu?=
 =?utf-8?B?L003Sm9wa1ppVmw4cHVGbHBCYU1vcXJZSEpLUXgwOFo5dzZvMXFSVG5nbGRV?=
 =?utf-8?B?TVNJZ25CRTJqeFFObllBNUJZR2ZNRFIySTVyLy8zdy9xNXhTR0FQdU5sdk1k?=
 =?utf-8?B?NWJZN2gwaEQ0R244YXBzV2JoZjVIOWRCSXVmRkpjZXZxRFcrTzBXQnZIQjUy?=
 =?utf-8?B?NjdETTFuMENwUlFHT0JmWUVaOEU1NGI3WUhwU1orSzE4MDFMZ2puWDE1dXVL?=
 =?utf-8?B?WnlSWExXRVVMQlMyZi9YWVNkN3U2THMyN1psVmowUlhrVjRQbFQwWStXWDJL?=
 =?utf-8?B?djlrWDVSRjczNmlxY1BmNVREcEVITzQ5TnJkeVozeDRYOTJlRUIxTXRaR3Fz?=
 =?utf-8?B?UW12STUyaGV2eTREWENnSCtjY0NCck5OK1BuWk5weUtFN2t3M1JzbUVFWEoz?=
 =?utf-8?B?dVpBTmFNckE4UTNUSFZUeFZ1OE9RdXZOL3llWTFuMkI0c01hWkpXSVdQNnIr?=
 =?utf-8?B?T1YzOTlPVVVzVlFrQU9tT29vSTE4cFpON2JhUXd3SW1wOXZLN3dpTnJNbzZp?=
 =?utf-8?B?ZXpEMElMVGxkSzhjeWJoN0R2SUFHV1ZTRWRJM3ljSXROc1BUYnBHT2kzU1ZI?=
 =?utf-8?B?S3VaQWJORnNnb0xvbjlrdWRtOVVrbHNKaTBZM0J3QXViMFd2c3NHcnhkZ2pQ?=
 =?utf-8?B?WE9nZEtMVWU4VGNObGxWeUhndjNabXY0bTR6dXN6MzVFbnduaWNhY2lZVGFO?=
 =?utf-8?B?em9hMS9Ka3Vwd1dRbUpGRHo5dVdlQS9qaWJ6QWJKRitta3hvNWEzNFc5aVNL?=
 =?utf-8?B?RE50K0w5ZFd0bEtnV3VWUHR4akMvcC9OV3RHMmljWTB5eVFHRTBsTnBmak1h?=
 =?utf-8?B?R2hTRnBUemYwbUpERUo4WlZzU3lydU53Y3J4M1JveStYaXFPRDNVMlZnc01X?=
 =?utf-8?B?UGIrckRjY2FycDVFOEhVSVg1YWpvWXpxU0F2UGhaMFBORjNYZUdBak9nMjdF?=
 =?utf-8?B?a2w4RnlETFdMRkVaRXcxQk1mWXdJV0FnL1duTDdXTzhnTVpYTi9iSWpIWjNq?=
 =?utf-8?B?UjU5SmFDanlrdlZUVE5FY0Z3bFhUV1hzZld0cVNaRTJGQ1Z0Y2dKT0dNVHlR?=
 =?utf-8?B?d3NORUpuMkM5WlZkMUc3dDNkbnpWVFBuaXdpRzJIemlyT1ZGU0pIWTk3aG1T?=
 =?utf-8?B?eFBsc1QvbUVZeVBQQ1MvTGF0L0pBZFNKTU1zTzhZdWtvOW5kT1l0UnBsREZS?=
 =?utf-8?B?cjZxbUZmUXhtbUVLT0N4SllsT2I1S05aTUJ0eUZLaTEydFkveWhzYngrcFhG?=
 =?utf-8?B?WVV0aFhtcitxV3lpdy9IZTdjQlJ3b0JrV0FaNUVqZ1RyNGxvRzhaS3ZHb1E4?=
 =?utf-8?B?TThTQWhCUktXbWpFRS9WVXFaTTVKZEhrSGkwV01FeEJpTEZKVCs5ME83N1V4?=
 =?utf-8?B?OExvclIyOHBXSlFsYkZzd1RUaHNYUkVQSWY3NElyd1A5cXVla0Z6ZkNTM0I5?=
 =?utf-8?B?am5idnVLeXBxbTFxN294RWpFQ00weGRNQXU0c0g5Q0pnOEl4a0xCV3RTSkh1?=
 =?utf-8?B?d3M3UEpnekJScXJLdlhtSkZYaTAzeHBac2RLS3Bjdjhoa1FwSzYvQXp5eEd5?=
 =?utf-8?B?SVZpTzYyR3BaVnlhYlUxUXlQYmEweHppeC91emFQQXZ2MFp3Y1BUbVlGU0tZ?=
 =?utf-8?Q?gUkuVyu+h7QlhZSgDT1OljCzR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D10D44673DB60146A3235125BFAC5A7B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635b4313-f80d-48e2-25cd-08db87fd0f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 02:08:35.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owTKPsojSYGA2qFCcaRYDfdYdcmbOYH0+zTa4DJZwYDDltiZ3UOWnUXyMMy3u1aT5vhfiYvfEZedWgakeSRHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNy8xOS8yMDIzIDk6NDAgQU0sIEpvbmF0aGFuIE5pY2tsaW4gd3JvdGU6DQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gVGhhbmtzIGZvciB0aGUgcmVwbHkgYW5kIHRoZSBsaW5rLiBJIGJlbGlldmUgdGhhdCBpcyBh
IGRpZmZlcmVudA0KPiBmYWlsdXJlIG1vZGUgaW52b2x2aW5nIF9faWJfY2FjaGVfZ2lkX2FkZCgp
LiBJbiBteSBjYXNlLCB0aGVyZSBpcyBubw0KPiB0cmFmZmljICh0aGUgbGluayBpcyBjb21wbGV0
ZWx5IGlkbGUpLiBBbmQsIHRoZSBmYWlsdXJlIG1vZGUgaXMNCj4gcGVyc2lzdGVudCBubyBtYXR0
ZXIgaG93IG1hbnkgdGltZXMgSSAidG9nZ2xlIHRoZSBsaW5rLiINCj4gDQo+IA0KPiAtSm9uYXRo
YW4NCj4gDQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDIzIGF0IDk6MjjigK9QTSBXaWxsaWFtIEt1Y2hh
cnNraQ0KPiA8d2lsbGlhbS5rdWNoYXJza2lAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pg0KPj4gWWVz
IC0gaXQncyBOVklESUEgaXNzdWUgMjMyNjE1NToNCj4+DQo+PiBodHRwczovL2RvY3MubnZpZGlh
LmNvbS9uZXR3b3JraW5nL2Rpc3BsYXkvTUxOWE9GRUR2NTkwNTYwMTEzL0tub3duK0lzc3Vlcw0K
Pj4NCj4+IFdpbGxpYW0gS3VjaGFyc2tpDQo+Pg0KPj4gT24gSnVsIDE4LCAyMDIzLCBhdCAxOTow
NiwgSm9uYXRoYW4gTmlja2xpbiA8am5pY2tsaW5AYmxvY2ticmlkZ2UuY29tPiB3cm90ZToNCj4+
DQo+PiDvu79IZWxsbywNCj4+DQo+PiBJJ3ZlIGVuY291bnRlcmVkIGFuIHVuZXhwZWN0ZWQgZXJy
b3IgY29uZmlndXJpbmcgUkRNQS9ST0NFVjIgd2l0aCBvbmUgb2Ygb3VyDQo+PiAyMDBHIENvbm5l
Y3RYNiBOSUNTLiBUaGlzIGlzc3VlIHJlcHJvZHVjZXMgY29uc2lzdGVudGx5IG9uIDUuNC4yNDkg
YW5kIDYuNC4zLg0KPj4NCj4+IGRtZXNnIG91dHB1dDoNCj4+DQo+PiBbICAgIDkuODYzODcxXSBt
bHg1X2NvcmUgMDAwMDowMTowMC4wOiBtbHg1X2NtZF9vdXRfZXJyOjgwMzoocGlkDQo+PiAxNDQw
KTogU0VUX1JPQ0VfQUREUkVTUygweDc2MSkgb3BfbW9kKDB4MCkgZmFpbGVkLCBzdGF0dXMgYmFk
DQo+PiBwYXJhbWV0ZXIoMHgzKSwgc3luZHJvbWUgKDB4NjNjNjYpLCBlcnIoLTIyKQ0KPj4gWyAg
ICA5Ljg4MTI1MF0gaW5maW5pYmFuZCBtbHg1XzI6IGFkZF9yb2NlX2dpZCBHSUQgYWRkIGZhaWxl
ZCBwb3J0PTEgaW5kZXg9MA0KPj4gWyAgICA5Ljg4OTA5NV0gX19pYl9jYWNoZV9naWRfYWRkOiB1
bmFibGUgdG8gYWRkIGdpZA0KPj4gZmU4MDowMDAwOjAwMDA6MDAwMDphZDNlOmUzZmY6ZmU5Mjpi
MzFiIGVycm9yPS0yMg0KPj4NCg0KU2VlbXMgdGhpcyBzeW5kcm9tZSBpbmRpY2F0ZXMgaXQncyBh
IG11bHRpY2FzdCBzb3VyY2VfbWFjIHdoaWNoIGlzIG5vdCANCmFsbG93ZWQuIEZvciBtb3JlIGlu
Zm9ybWF0aW9uIHBsZWFzZSBjb250YWN0IHlvdXIgTnZpZGlhIHN1cHBvcnQgDQpyZXByZXNlbnRh
dGl2ZSwgdGhhbmtzLg0KDQo+PiBEZXZpY2UgVHlwZTogICAgICBDb25uZWN0WDYNCj4+IFBhcnQg
TnVtYmVyOiAgICAgIE1DWDY1MzEwNUEtSERBX0F4DQo+PiBEZXNjcmlwdGlvbjogICAgICBDb25u
ZWN0WC02IFZQSSBhZGFwdGVyIGNhcmQ7IEhEUiBJQiAoMjAwR2IvcykgYW5kIDIwMEdiRSAuLi4N
Cj4+IFBTSUQ6ICAgICAgICAgICAgIE1UXzAwMDAwMDAyMjMNCj4+IFBDSSBEZXZpY2UgTmFtZTog
IDAwMDA6MDE6MDAuMA0KPj4NCj4+IEZpcm13YXJlIGlzIHVwIHRvIGRhdGUuIExJTktfVFlQRSBp
cyB0byBFVEgoMikgYW5kIFJPQ0VfQ09OVFJPTCBpcw0KPj4gUk9DRV9FTkFCTEUoMikuDQo+Pg0K
Pj4gSGFzIGFueW9uZSBzZWVuIHRoaXMgc3luZHJvbWU/IEFueSBhZHZpY2Ugb3IgYXNzaXN0YW5j
ZSBpcyBhcHByZWNpYXRlZC4NCj4+DQo+PiBUaGFua3MsDQo+PiAtSm9uYXRoYW4NCg0K
