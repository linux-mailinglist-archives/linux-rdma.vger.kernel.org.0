Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3C6E707E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 02:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDSAnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 20:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjDSAnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 20:43:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3A6A59
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 17:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2/gaE4cbqWf9PyciTMwbIwIMajZiNI/Oakti/P65W5TEzcG+5dt2ij9vihLa19rSvLiK24GJKFURuoS9tO3kBEgojfly/Hg75NN+zuw+zj1a0X0ocOqC4cAeB2IU/K1/wwQgWUaFy8htqh4UlIoAVXn/mf+bAmtIdVXBp7j83Fz22y3Y2nJpUZudJK+UUhoW7zLuzljjdcy3ph9+48Kqi6Ht1sVZWx6kAlVNPSMopCtdzqkmdCCf0BKka2Fvrsz7j3WJoTHzujvo9wzQDtp3vlbRu5qwRUNMZ8qfjMkMBt2Ii8Uy/dmfM9vwENulmgpvqKHAvhk57GSJ2IgWdKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKrD5P0o+sJmNtxbnQ1kIUSq+tVLgHYOXO7InQb7AfI=;
 b=OdW3wjr22sXiU1vproVQrCSniL8Z1MWcfyircBSh/BdTt3pNrq/0jCymoQuTpidhffuPNWkXrxvrxmCtBrT9McF5FTDSWE9HcH2TQX4Qi5lWpBnEVQ2M1LYgSYPumxnRY/2D+x2trt/zKfViiD9E5i0QLbPHxorTkZgG/ln1zNkc6VVHDg9XbkgYIfDEJ80rnFm1oeqUerQciNr7JCYYq4oFKHtu6JMLbVQ8E0vKATd4zPUkiawnVUicZPXjyhGvjJex27teZ1N60GAsTNP63liuYNvvweFLKJoiq5223MY8cphvs+yEGHfU4FlOl++2QDLMMkh++jhl5uWP5rjxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKrD5P0o+sJmNtxbnQ1kIUSq+tVLgHYOXO7InQb7AfI=;
 b=Ph3uPlfy3ud/MMmILLkXtALPbYwxL7GTnW8JMPCzZwNfwUVmbto05TX62v2AbsJhtTa90XeSCBuJ/a3utHorKN/9rpXjUeCH4OQeJrOT3/+fqlN/1lYpjTFIBqccm9LKSCbJHaCb4N8XOmUq6F1U1gYpNEYICALFGJWX8QDiUX86eLKyUxgNeOCV2reV7xpd7k9lCf5TtDwA4iy95gP9FDwY0ziYoHHdsv7cscD2BICru7t10Ic1EHdB8Zi4PwNr21/zKuZ1wWEW03+FwtHKI4ZBibLXnaFP+d+UK4KjM902CanYFWdHvrFA7wrEq8dbbpbPhoHO54No9njRxxygTQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 00:43:10 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 00:43:10 +0000
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
Thread-Index: AQHZQDq78euIxrtulEiTJiby3UJy1a8oRlKAgAA9FwCAAK1xAIAAXqEAgAAARcCAACvLAIAAC2OggAAAweCAAARiAIAAAHBggAGEiQCAAAcDgIAAAqYAgAbUQfA=
Date:   Wed, 19 Apr 2023 00:43:10 +0000
Message-ID: <PH0PR12MB5481BD928589FE9219B3582FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <29e1ed5a-091a-1560-19e5-05c3aefb764b@linux.dev>
 <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
 <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
In-Reply-To: <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: 788610b1-2d71-4732-76b1-08db406f0ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2APHPtYBsLk3erWcNBSc3PI7MxJrTiE1CKD0h7OmYAvQLZC45ErUp0pUkCu49QISt2b8roXvdVQKyuz6r5eawQ7sH5a9UKM1ICB5MpS2f1DdjMZBPkEnfankeD2cBN36pEmbox3L2JeqtW89ockau0cHL1sQfgVMxlB/beUxRA0tvfOrPzPtluMNOiCTM/yS3ZwV/vMJk2R8Eyx5sV0ZE8a5IiY22V2c5KWnaT0RLY6z4Se0AXVs/0XIHS3XH5SMTtuasjneBSffwO32jUCR5tRMrJdrml1SZR2cXwGzTtBv0nBSoRaX8SmzxyAVIz/U07Y4bFSdHj3dNHXLIh9jWlp7U9+G3MhAdlF4EKWFvtE8lJ6ITb+lqDa3il/TvY1OChWl3/SDV8GvjcoXyzGOlvjssnEZVEyvKvljJcCVtel9omoe9nsQdVnsZx3kvIZT3cbkK7j+DnMESGpGrnmZsI+2/vjnGTackIx6o3L4Zz9aQy/iwbPMzZj0LXNmrzH7G+tANOmdmRk/iTojVVMBZSlQybhohEti2CBGMQFVu+olh1RJc6UiKiY264a+JLKheYRfnQPNmUf0LWgDsNh9omSmAZ9Tn4GhLIZ4HuHphG1XntVe9FE7CiUyS7OoKC/X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(7696005)(76116006)(316002)(110136005)(54906003)(66446008)(64756008)(66946007)(66556008)(66476007)(4326008)(33656002)(26005)(6506007)(9686003)(122000001)(38100700002)(186003)(83380400001)(5660300002)(8936002)(8676002)(478600001)(71200400001)(41300700001)(55016003)(86362001)(38070700005)(4744005)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWwvY3BUVDAzQXE1U2dQVWFQTnA2UUM4WWkyVEFKZ2VXczRRRkVsRldDRVFG?=
 =?utf-8?B?Uzh4VHhOcjgrR0g2djlBR1NKQ25SY1c3MTRrM1FGTS9oMEluaGtHWURwWkdM?=
 =?utf-8?B?Rmgyb2ovaGxjd2ZjK1BLZnhPOFJGcC9CbWhnUlVaMDhYVVorQ1ZyQzRMSENX?=
 =?utf-8?B?SkdTWHpXTlRTMGFlSXdLYUdwc3k1c2pGNWpUK24xSU1oZTlzenBLVi9aTG5q?=
 =?utf-8?B?TmpoZDdzU21hWlZoNFVzRzFPNzNGRmkrcjVBaGZnZjA2dlltSmNrSXhtdDVO?=
 =?utf-8?B?aUU0N2FMVWp5ODZTY05mQU1vQmJJOHVKeU1OM3JQUjJZSlhkZzdjUmZKTUpC?=
 =?utf-8?B?QU9pR0hIL1pEdDFXdVNybk1iZG9VeGRaeHBZVFd5bFh6NUFUSk4rUWFTM093?=
 =?utf-8?B?dkJia2s1N2hFR1Nma3hZTWlGNDh2bWkyakZ5TjRscG02NTJrYjV5QXcwSWNs?=
 =?utf-8?B?Q3l5RGxyampyS3owY2FIUFpkWlNsUnNZQU05YzRaVU1LU1RjTk5nKysxUUpM?=
 =?utf-8?B?VHVEUTVXT1BmQUs4MnRjYk0xQng5dDViYjYydUJoUndtT2E0eVVTWlZQZURN?=
 =?utf-8?B?YWdXQUpzMmZVNnZRSEZlU0dqSWZNQWdmZjZjb1ZuOE9Db0dVenlYUlRwVXUy?=
 =?utf-8?B?OW1aNDRyRnh5RUt4TzIwVGZjeVFQVTV4UStXVjBPdzBVb2pxV2I3YUVKYWlZ?=
 =?utf-8?B?SzFzRVdkb3NPc1dvMUZGa3o3U3hoZjFza2g1OE1lVCtQVGl6Snk5MmxTUlJM?=
 =?utf-8?B?WERkcXBYRFZzY1ExUm1EeU9ObVdCL3BoOWZFdWtJZDhsanBVcEdiNEk4Q1FK?=
 =?utf-8?B?a3RjaVdwcHdobUNXdCtKNHVDeSsySWQwZXQxMXhnOUpONDlDbm56M0k1L0kv?=
 =?utf-8?B?OXduWFk5dHpVaXlRb1VRMkNPNFI3aTkvQVJ4YXhxQnZ0ZW1oN2pLZ1FTK25p?=
 =?utf-8?B?bVlWdXk3SlFPRm9vZ0R3THVSWmZuK2Y5ZGc0VlczdW5LczNxSW9ncHBhcFhz?=
 =?utf-8?B?RXdKdzMxc2lIWGxZNTNLSHVHNllvejlabkh6Z3l3dEtXNjZnb0gvN2FGazUw?=
 =?utf-8?B?TUdKcVE4aU5aRjlsRmxiVmd4OW4yRWVnSXdpTzg0N1VtaExaVnUyVks2bWRR?=
 =?utf-8?B?MXZCVXVCNDVXZW1xdnBvN1BXaEgvOFVOSkJUTUI3aEp2djB4YVFQekh6STUy?=
 =?utf-8?B?UjlmSkZNOWxBbGJxc21LSnd4c0lIZGFIR3N0Ryt5bjdXWFFmZTRVRUI5VEpm?=
 =?utf-8?B?T05rTGpBT3VIN3pWakFteStsL0JLUU1pZ0NQNmgzRk5DaVF3WTdiU0pOS3Ix?=
 =?utf-8?B?ZmpJb0hOYll6K2x3aXpKb25XR1ZFV2txUWJ5M0U3b2NnYlFPUW9DZ1REVmVF?=
 =?utf-8?B?MWZ2RlorK3pQelJkWjl1aEEzZ1E3RVlCekI5NWNRZ1h6WERnY2Zsa0ZTN0pm?=
 =?utf-8?B?cU1CRVFIOTR4eWdQL3lzTzltVUpzMitKMllXNk94NThRS2pzLzhHZURKN3Nx?=
 =?utf-8?B?ZFduNHZnSHh4VkRDS0hITTRIR3hQcUtmYUFMZE91eFNVcHJrdHpJRjBJNjQ0?=
 =?utf-8?B?Zk1KSnQ3UldHUDNXbmFaQS9ocGhnRHVzQnkwMUZ4M3lkYzNTMDdnTHgzaVE0?=
 =?utf-8?B?d1JlMytqR2xzdTc3cllhMXpKOHpQY0JZOUxRSmhNcVN4U3dESExQUUdOYktx?=
 =?utf-8?B?NHBacmpPN1NaRFl1OHArUnBSMkhreGxOcUhPb2JTZHlYcWxsMEtMcklUZUhn?=
 =?utf-8?B?M1oraEJzZCtmcHc2aFBwZ2NFQjJVTEdSQ08rL2VHNUtMc0hGM2grd3B2dkVk?=
 =?utf-8?B?cmdKQjN2cDZ0aVh4cDQ1aHRNTHNkRjNKcVdrcTJMcXROK2FQSTBoSzRDMkRn?=
 =?utf-8?B?Wm1jYzc4WU9nb2daNFRlV1JYNnY0OXE4bXljMEFCRzU3RVpkZ1hJcjNCdjF6?=
 =?utf-8?B?dkRXcCtRZWxta0Q2cGx0a3NpTmt1OFB2YVR5WndBWVVtcExLY3NONHVDNnN1?=
 =?utf-8?B?cENvcnZHeTU0OWxsUzg5RHQwSXZ3b1E4d3hwNXRSTUg4bVZIZ2Q2TXYzamU2?=
 =?utf-8?B?Tk4xQk9TeVExSGQwZlNydG9JY2pMV3FIZ0ZrMU5hNGZ2Q1Iwcy9EWFMvUUtw?=
 =?utf-8?Q?f12w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788610b1-2d71-4732-76b1-08db406f0ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 00:43:10.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txADFjwa7PdUP0ipNa/ZOE62OqcgHPvJbBY8+zMHsKuzryseivzFIEq4Tbqv2K8hZRUdDYbwseByUA1U5gNl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogTWFyayBMZWhyZXIgPGxlaHJlckBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgQXByaWwgMTQsIDIwMjMgMTI6MjQgUE0NCiANCj4gSSdtIGdvaW5nIHRvIHRyeSBtYWtpbmcg
dGhlIG52bWUtZmFicmljcyBzZXQgb2YgbW9kdWxlcyB1c2UgdGhlIG5ldHdvcmsNCj4gbmFtZXNw
YWNlIHByb3Blcmx5IHdpdGggUm9DRXYyLiAgVENQIHNlZW1zIHRvIHdvcmsgcHJvcGVybHkgYWxy
ZWFkeSwgc28gdGhpcw0KPiBzaG91bGQgYmUgbW9yZSBvZiBhICJwb3J0IiB0aGFuIHJlYWwgZGV2
ZWxvcG1lbnQuDQpUQ1Agd2l0aG91dCBuZXQgbnMgbm90aWZpZXIgbWlzc2VkIHRoZSBuZXQgbnMg
ZGVsZXRlIHNjZW5hcmlvIHJlc3VsdHMgaW4gYSB1c2UgYWZ0ZXIgZnJlZSBidWcsIHRoYXQgc2hv
dWxkIGJlIGZpeGVkIGZpcnN0IGFzIGl0cyBjcml0aWNhbC4NCg0KPiBBcmUgeW91IChvciBhbnlv
bmUgZWxzZSkgaW50ZXJlc3RlZCBpbiB3b3JraW5nIG9uIHRoaXMgdG9vPyAgSSdtIG1vcmUgZmFt
aWxpYXINCj4gd2l0aCB0aGUgdmlkZW8gZnJhbWUgYnVmZmVyIGFyZWEgb2YgdGhlIGtlcm5lbCwg
c28gZmlyc3QgSSdtIGZhbWlsaWFyaXppbmcgbXlzZWxmDQo+IHdpdGggaG93IG52bWUtZmFicmlj
cyB3b3JrcyB3aXRoIFRDUCAmIG5ldG5zLg0KPiANCj4gVGhhbmtzLA0KPiBNYXJrDQo=
