Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC460FA1A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbiJ0OGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiJ0OGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 10:06:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CE42D41
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 07:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSPuY5vzMvJtckdhj1dj9iesZ0NEfhDEFWCkXefULSaubxFwoVZLQVbCS8t8LUx5qzC+WVD+RaCn8w1+kKFsaAy1GMizSyE1RRHf5BU06VOlbqQcXLm1Bc+NToR59KU8kwy+tKRFby8uBsvqaEKgg/OXiYGcc8sS5cTWLbRREDRBrI+a4RGjTCkTwlmgTn9HN1MFlzevoO/dN6PNUiX+UsDqJLU+Nlzoz130S8AIQbAbIJD6xx2ReTq0bOELaDtJ0nMqn1Et9N9XaPmoITGXHlMnXJ3+Q+D7RkZW64Naw/jZTDKA/SkxJb4RjFfzWabBTqkIfg+jQTTPQGyFw6NdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkJPrB77YQ2P3WxtXnG6ywCVbn3hV1LpSdtgWjNkexk=;
 b=FAnpUACzPVaQ5mKkBbhmtJtL7Bif9kS3dA1tCLW2NbBKoK8OxsaIu+kfMRocrdq9q+/c5Ja/2otu/qaDDDZeW9KHyQipTKhVuRj8TOIBMl9CyCIr/Djqag/tacGdeR71zaOpavNYrlK3EB0U0xwbXN7Vo/Vx9lQvb8VDn1MrmNAyhi1qcm1YUCv0FG2aeAbHztkcXI1MDCLB7yqt0vE6+VvYxsn4CqjMtSAy7z1njnkDQU0pDD8kb6xRhPCFptp4pf4W6aZfVioOg3yqXya5aqusFgq+qg1mTqGWUfnehsokIjlZ9ZYCCMaRaJov+ZaMsyiSsGndvvTviLeb5WhJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkJPrB77YQ2P3WxtXnG6ywCVbn3hV1LpSdtgWjNkexk=;
 b=I9IgS0EW03MAtHlIKRs9Hp5+St/3JdfARkceG0BQNdciFDd8JUyqU7eAy7PFMaddv+nNdnxnc+TlR7DYkvvD7qeFHyPVnuPKCY7GOBSt+NfV1Cql28fQ76Xl3wluaOXdsgEl5rSewTudjUUoByFKU/DG7vl+L6hly4AJcHYWlESBlAnj7ZNzAKqgIrkrDFheqV2nWtd+nxBkKlPaH4VTFYVkSrqKB6Rr9sr3i59wpCkVwbS+IueF1FUmLmpQt20CD0dxEKr233TU4TJsCc6IUKCNjr9xE6xtv5tb4k4eq9Md3f3Ms35Z6juMsjsTQf2jMqM6gri6kta5nxTuEyWwXg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 27 Oct
 2022 14:06:10 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 14:06:10 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1CAAAKNAIAAAC4AgAAF6oCAAAAm4IAAJ6kAgACEhgA=
Date:   Thu, 27 Oct 2022 14:06:10 +0000
Message-ID: <PH0PR12MB54811A129A037D716BFD934CDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <7f5ed21ac410646aba93aac875a0d8a8@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6217:EE_
x-ms-office365-filtering-correlation-id: b971cb16-7008-48c8-b558-08dab824667b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiLiGsyJoisx4cHdAn5KW07a2R3sG/jDI2RjdzGesngigbrstGFDXI9tvjEDmD3iqsO9qGnf9nPScVrSptsjJznThAeNhwkA6UoO4sjvYfCcaE3CQi0e9JorK0IqKjbGCW7hHv+3s6u2P4zR+3kq7hQwx6ytob7HyGQRhbw8xrYn+syTi9az/eb/8wcGwI/AvVCSKoWkpmHxahZ+9uKWK16jGaNMRgPsbieErmVUN/YFiMYw5AQqEpzWQbrWeFfrhUxxAzSYdLEXn+nnpiAthJ8jsPaVzRxufpJmiOKi7pM+yQfrL2c9kALhsz2m1MNwG3bG36adedEXtdRM2eud0WN2ssBwRu9XAy1V7CpRHkRWAdOoQO58McjMJwpoLtkHdcVHQ/Bgk4v4sipgfN6ZPvx60LlnSy28lVS6TVHgL5A7AjQfQnQ1UYixHKKxcRdbqHCSMjfrn3cCHEke4Pt9W2VFJ5gRh6dfo5DUwEmEB5VootuTXz6L9dcnqN2nzRs5Invp4/Kh09n7X81maJ4M+tNWPim5GOjkVkI+M5ByWiZp6aG8QtTriBbOZjsa50Tiie9vGRqWZ9MwqRonbSfOTuxpU+RsdgyVeGt+Y5xbJ9OtpYmSuAKnw7YLt/iYj+aLadRb0oObsgB0CTdK0Xe3fU+1XoF7o3XY2+n0V7iNDA+bPYnSDSKQuH+O/qx2NajhSbZnyAcQ499J5ZTUEYYJQ+/OTpx6RqdsYLtLrvF6EgLsMFnWHzg2rJB8+qESSbbn4FhHqc5/CUXNnf/mUD9SBuCbEYULz7QrNgO+SntGvSY7vnDUUbwGihKKd8u0+ml67XGpdpHW/JxIDUTtxvfYS8SkbZunqhMDAYyuQGGU4lHWJSu7NgREi4Wmp9TXh6ZW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(122000001)(66556008)(7696005)(2906002)(6506007)(71200400001)(41300700001)(38100700002)(110136005)(66446008)(66476007)(64756008)(76116006)(66946007)(53546011)(33656002)(86362001)(55016003)(478600001)(966005)(186003)(38070700005)(8676002)(316002)(9686003)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXUzNExkVDZKMHRPakNReU1sa0ZLNlpsUVFvUkdkUDVoZHF3ckRaVTFWb3dH?=
 =?utf-8?B?Nk85dDhoRWFRSGxvUW9xWlVybUo0VXNZWFRSL1RVdGREaHRuVUZCdlgvckVK?=
 =?utf-8?B?ekJESnVVaVhINkxhbWRUdkVsSDIyUzJRdlZ4dldRdmxZcFV5bEhYaHE4Tk5m?=
 =?utf-8?B?QmxBMkpQL2JiZ2d6S29GaytaN2hVSk9sYzl0anVWc0VvdlpXbCtCMWhEY0wv?=
 =?utf-8?B?WHBZRW9KRVNZNGZKZmk1d3RMWEFqbzRwQzNSMnJyeDY2blNCQUJwc0F0aWR0?=
 =?utf-8?B?TTZMOHZVZWZhZ2JGdVFSSWxZUkR2QVhZZG1aWWlmRFg0SDVxcjZRRllBWnN0?=
 =?utf-8?B?aXhDRTJiOXpaK1BlL0NzbDJxTnpybEhqZ3YzYnpjYkUzMFNoN25PdkFLQ1NL?=
 =?utf-8?B?TEF6QnlSQkdDZUxNVkN1L0xpOVlCZnVoVm51QTJXL0RDc3ZXMlc2YWNXYW1j?=
 =?utf-8?B?VldRNGlSUVpGcHNuWDIwWHl4QVJ5QnE4RTloOUJsZXJvbXE2dThoTmczUGxJ?=
 =?utf-8?B?TyswRk5NRHJaZ05FaldyM1dBbklYTVVYalRNcHZuYzJ1L2pCSFlPTFAzcUdw?=
 =?utf-8?B?aUR3RFUxazNBK1lnMXhHYnVGbHZ4TWhXVnBqSG0rekoyRFlnRDJ2QTNLOWp4?=
 =?utf-8?B?WHlzeHBtZm02WVJDS0hIZnZZOS82NEloN1pKb0dSUjNDcmZzemZaZ0QzVm40?=
 =?utf-8?B?akxTU3Nac1ZFemZTYkJWWGM0dmthMjU2a0duMGZzL2VtTjJlbnNaMXpUZ25I?=
 =?utf-8?B?cnZCSGJrTkIwVGd5MWZUVHJZck1oTUovb1hZbXQxUmpITFVwanRzekxqU3Rk?=
 =?utf-8?B?KzhyWTY3TWtuRVFEZWMrYlYwbGpsbEk3Q1JBVFJvVGRRRGFWU0VqN1VKQU1W?=
 =?utf-8?B?M0lEZ2ZZbGthc2YvWTZWMHd4WVFqbnZqNVZGS2t3Zzhlc1paaGZwWTRDdytR?=
 =?utf-8?B?b2JIa1hiUVZCZnVBVnJGUkhnWDJQSHlSY1VjWmQxUTgwbFR3UlhTb0pNdk1X?=
 =?utf-8?B?R0dycWtMTDBId2ZWQjU5eHI0NWFXTWlwRUlqY0RaQmcxeVdXbmptRWZ5NFZl?=
 =?utf-8?B?OXRldlhJM2xjVzF6QUZUbEdaYkJEa2p6UlN5TUo5UHZsZnJiVDZRV1JTN01k?=
 =?utf-8?B?cXZwVzVyVkgrTTd0NGR2ZnJiUUVHRTBKaWtpSFRFcVRINFQzTnkyaUtZYTZm?=
 =?utf-8?B?WC9jaFVhYmtjSmtJenlZSlIxUVQ4cVVjSkhRdzR6bkx1Z05Id0o1ZnFlS1J2?=
 =?utf-8?B?NDVNQVBvRnhKUG4zdVhsd0UyZEdsMzN0cm5GNTFFNHFrWHk1UXM1MHkxczlq?=
 =?utf-8?B?dHFOVFhYRDk3UFhpRVo0bHdvRXQvSEd4RzhaaGZvRzNYUGNoYjYxeVJXcDgz?=
 =?utf-8?B?a2toOExtRE1LQkFQR2xOVXRDUkR1NFlhcUVFQ1NSNG12WjVBOUVhNklTbGxF?=
 =?utf-8?B?WFdCUFFSSitOc1Z3WkczNVc1eVd1d2YzRkU3RFlHZ05xUHVRRmgrTjU2UUZz?=
 =?utf-8?B?c3NWbGFjUWx3NktkL1JwcithRENGbEJqa0g5WHhQUi90eXV0SW9Gc2crZ3Q5?=
 =?utf-8?B?MkN0RitkbjYvV1piMG50QkliUFBNU3BWY0tFWjVTV3hibG84cHh2a241Tlp4?=
 =?utf-8?B?YjMxWXlwbnlFUXA1b3I5bjNCb1dYRFJXNUxuSmlPM0ltZUx0cXdoTmN1eC9t?=
 =?utf-8?B?S2x6UGFCVnFXV2VYZ2Z6d0UvbDNtWkY0d0taQkllOWNDTjgrNTE3M20rb2hm?=
 =?utf-8?B?dnFTUVIvOTNQcWdNU1ZhdVZqaWFyUitMVXFudVk4cVQ5bGNseXI3Nk5uNzY1?=
 =?utf-8?B?dERieVd4bldiTzV0THc3R3RndkhwQzRtVEpsckhVTjlwM0dLai9kSGxVNEVp?=
 =?utf-8?B?RENBeEs3OTBCTnFYRXFkQlpYeG5DL3hvMU9NSmkrdndJMmtiMUJ5emtNeUll?=
 =?utf-8?B?TFpCZGR0Nllld3VoOHNFUTZ1NGpNSWU1cG9uckc2OXJnU3NXNW9CVmV6ZUhq?=
 =?utf-8?B?K3J4YmRFUlNxUDJXSW13RDBSRVlHM0VHY25naGY0MlFJem1OK3hqWkRJOGh1?=
 =?utf-8?B?N2d4MndWaUg3dm81R2NNdWllYVUrUlVjTUZLQ0w5QUxMeVlnTFJ0c3ZNU2lP?=
 =?utf-8?B?TDBCQ29aNmFVMFlFc0VwUlU5cVZEdEJsM3JkS0ozS0FiRXJWbnFNRHVTcFVY?=
 =?utf-8?Q?6jPqdmusKkGED6qZRIz7Xz0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b971cb16-7008-48c8-b558-08dab824667b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 14:06:10.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8RclGbsnDfi/oTmxJUNgPNhedUzpP8twMYekLhyLA3Hq1iZLQzvZwH63sg7QYpkhFf/5Ol1XPr82unlAs/UMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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
U2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjcsIDIwMjIgMjowMiBBTQ0KPiBUbzogUGFyYXYgUGFu
ZGl0IDxwYXJhdkBudmlkaWEuY29tPjsgZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbTsgWmh1IFlh
bmp1bg0KPiA8eWFuanVuLnpodUBpbnRlbC5jb20+OyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVs
Lm9yZzsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC8zXSBSRE1BIG5ldCBuYW1lc3BhY2UNCj4gDQo+IE9jdG9iZXIgMjcsIDIwMjIgMTE6NDgg
QU0sICJQYXJhdiBQYW5kaXQiIDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+ID4+IEZy
b206IHlhbmp1bi56aHVAbGludXguZGV2IDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4gPj4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDExOjM5IFBNDQo+ID4+DQo+ID4+IE9jdG9i
ZXIgMjcsIDIwMjIgMTE6MjEgQU0sICJQYXJhdiBQYW5kaXQiIDxwYXJhdkBudmlkaWEuY29tPiB3
cm90ZToNCj4gPj4NCj4gPj4gRnJvbTogeWFuanVuLnpodUBsaW51eC5kZXYgPHlhbmp1bi56aHVA
bGludXguZGV2Pg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjYsIDIwMjIgMTE6MTcg
UE0NCj4gPj4NCj4gPj4gT2N0b2JlciAyNywgMjAyMiAxMToxMCBBTSwgIlBhcmF2IFBhbmRpdCIg
PHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBGcm9tOiB5YW5qdW4uemh1QGxp
bnV4LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0
b2JlciAyNiwgMjAyMiAxMTowOCBQTQ0KPiA+Pg0KPiA+PiBPY3RvYmVyIDI3LCAyMDIyIDExOjAx
IEFNLCAiUGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+
IEZyb206IER1c3QgTGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+DQo+ID4+IFNlbnQ6IFdl
ZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAxMDozMSBQTQ0KPiA+Pg0KPiA+PiAyLiBlbHNlIHdl
IGFyZSBpbg0KPiA+PiBleGNsdXNpdmUgbW9kZS4gV2hlbiB0aGUgY29ycmVzcG9uZGluZyBuZXRk
ZXZpY2Ugb2YgdGhlIFJvQ0Ugb3IgaVdhcnANCj4gPj4gZGV2aWNlIGlzIG1vdmVkIGZyb20gb25l
IG5ldCBuYW1lc3BhY2UgdG8gYW5vdGhlciwgd2UgbW92ZSB0aGUNCj4gUkRNQQ0KPiA+PiBkZXZp
Y2UgaW50byB0aGF0IG5ldCBuYW1lc3BhY2UNCj4gPj4NCj4gPj4gV2hhdCBkbyB5b3UgdGhpbmsg
Pw0KPiA+Pg0KPiA+PiBOby4gb25lIGRldmljZSBpcyBub3Qgc3VwcG9zZWQgdG8gbW92ZSBvdGhl
ciBkZXZpY2VzLg0KPiA+PiBFdmVyeSBkZXZpY2UgaXMgaW5kZXBlbmRlbnQgdGhhdCBzaG91bGQg
YmUgbW92ZWQgYnkgZXhwbGljaXQgY29tbWFuZC4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBzaG93IHVz
IHdoZXJlIHdlIGNhbiBmaW5kIHRoaXMgcnVsZSAiRXZlcnkgZGV2aWNlIGlzDQo+ID4+IGluZGVw
ZW5kZW50IHRoYXQgc2hvdWxkIGJlIG1vdmVkIGJ5IGV4cGxpY2l0IGNvbW1hbmQuIj8NCj4gPj4N
Cj4gPj4gQWxzbyBjaGFuZ2VzIGxpa2UgYWJvdmUgYnJlYWtzIHRoZSBleGlzdGluZyBvcmNoZXN0
cmF0aW9uLCBpdCBuby1nby4NCj4gPj4NCj4gDQo+IEFuZCBJIGRvIG5vdCBmaW5kIHRoZSBydWxl
IHRoYXQgeW91IG1lbnRpb25lZC4NCj4gDQo+ID4gVGhlcmUgaXMgbm8gTGludXgga2VybmVsIHN1
YnN5c3RlbSBvciBtb2R1bGUgdG8gbXkga25vd2xlZGdlIHRoYXQNCj4gPiBhdHRlbXB0IHRvIG1v
dmUgbXVsdGlwbGUgZGV2aWNlcyB1c2luZyBzaW5nbGUgY29tbWFuZC4NCj4gPiBXaGVuIHVzZXIg
ZXhlY3V0ZXMgY29tbWFuZCAsIHVzZXIgZXhwbGljaXRseSBnaXZlIGRldmljZSBuYW1lICJmb28i
LA0KPiBvbmx5ICJmb28iIHNob3VsZCBtb3ZlLg0KPiA+IE90aGVyIGxvb3NlbHkgY291cGxlZCBk
ZXZpY2Ugd2hvc2UgbmFtZSBpcyBub3Qgc3BlY2lmaWVkIGluIHRoZSBpcA0KPiA+IGNvbW1hbmQg
d2hpY2ggaGFzIGEgZGlmZmVyZW50IGxpZmUgY3ljbGUgc2hvdWxkIG5vdCBtb3ZlIGFsb25nIHdp
dGggImZvbyIuDQo+ID4NCj4gPiBZb3UgYXJlIHRyeWluZyB0byBkZWZpbmUgdGhlIG5ldyBydWxl
IHRoYXQgYnJlYWtzIHRoZSBleGlzdGluZyBBQkkgYW5kDQo+ID4gdGhlIGlwcm91dGUyIChpcCBh
bmQgcmRtYSkgY29tbWFuZCBzZW1hbnRpY3MuDQo+ID4gSXQgaXMgaW1wbGljaXQgdGhhdCB3aGVu
IGNvbW1hbmQgaXMgaXNzdWVkIG9uIGRldmljZSBBLCBvcGVyYXRlIG9uDQo+ID4gZGV2aWNlIEEu
IFRoaXMgaXMgcGFydCBvZg0KPiA+IGlwcm91dGUyIGZ1bmN0aW9uaW5nLg0KPiANCj4gQWJvdXQg
aXByb3V0ZTIsIEkgcmVhZCB0aGlzIGxpbmsNCj4gaHR0cHM6Ly93aWtpLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbmV0d29ya2luZy9pcHJvdXRlMiNkb2N1bWVudGF0aW9uDQo+IA0KPiBUaGVyZSBpcyBu
byBydWxlcyB0aGF0IHlvdSBtZW50aW9uZWQuDQo+IA0KPiBUaGlzIHJ1bGUgaXMgZGVmaW5lZCBl
eHBsaWNpdGx5IG9yIGltcGxpY2l0bHk/DQo+IA0KV2lraSBwYWdlcyBsaW5rcyBhcmUgbm90IHRo
ZSBkb2N1bWVudGF0aW9uLg0KTWFuIHBhZ2VzIG9mIHRoZSBpcHJvdXRlMiBpcyBkb2N1bWVudGF0
aW9uIG9mIGlwcm91dGUyIGF0IFsxXSBhbmQgWzJdLg0KDQpbMV0gaHR0cHM6Ly9tYW43Lm9yZy9s
aW51eC9tYW4tcGFnZXMvbWFuOC9yZG1hLXN5c3RlbS44Lmh0bWwNClsyXSBodHRwczovL21hbjcu
b3JnL2xpbnV4L21hbi1wYWdlcy9tYW44L3JkbWEtZGV2LjguaHRtbA0KDQpBcyBJIGV4cGxhaW5l
ZCwgdGhlIGV4cGxpY2l0IHJ1bGUgdGhhdCB5b3UgYXJlIGxvb2tpbmcgZm9yIHRoYXQgc2F5ICJ3
aGVuIEkgbW9kaWZ5IGRldmljZSBmb28sIGl0IGNhbiBhbHNvIG1vZGlmaWVzIHRoZSBkZXZpY2Ug
YmFyIi4NCkJlY2F1c2Ugbm8gcGFydCBvZiB0aGUgTGludXgga2VybmVsIGRvZXMgdGhhdCB1c3Vh
bGx5LCB1bmxlc3MgdGhlIGRldmljZSBpcyByZXByZXNlbnRvci9jb250cm9sIG9iamVjdCBldGMg
b3IgaGFzIHBhcmVudC9jaGlsZCByZWxhdGlvbnNoaXAuDQpJdCBpcyBmdW5kYW1lbnRhbCB0byBh
IGNvbW1hbmQgZGVmaW5pdGlvbiwgbm90IGEgbWF0dGVyIG9mIGV4cGxpY2l0IG9yIGltcGxpY2l0
Lg0KDQpBbmQgY2xlYXJseSBpbiB0aGlzIGRpc2N1c3Npb24gZm9vIGFuZCBiYXIgYXJlIGxvb3Nl
bHkgY291cGxlZCBuZXR3b3JrIGRldmljZXMsIG9uZSBpcyBub3QgY29udHJvbGxpbmcgdGhlIG90
aGVyLg0KDQpBbHNvLCBhIHJkbWEgZGV2aWNlIGlzIGF0dGFjaGVkIHRvIG11bHRpcGxlIG5ldCBk
ZXZpY2VzLCBwcmltYXJ5IGFuZCBvdGhlciB1cHBlciBkZXZpY2VzIHN1Y2ggYXMgdmxhbiwgbWFj
dmxhbiBldGMuDQoNCg0K
