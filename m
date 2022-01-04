Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FBC48399D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiADBGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 20:06:34 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:48943 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231493AbiADBGe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 20:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641258395; x=1672794395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KOKDR9ol/kqU585q4U7QNmz0t7rz9bvdOS5MW0F6lSA=;
  b=qGfAUMhgYR2KNj4qLC8ixfXJdQh2HY9gHTdh6Xvu2EfTf+PVb8+7xyZj
   lvbSEeeTRP36Bxw00YBV+gJubxw0+5z+gUruS52GJFaCDCY9sJ+p5vWD8
   RfJtcvqGATe/tTLUC02QOmdg945bkjYA+5MMltvx6yuxnAmZ0fnBtVswl
   gwoGCcGdnjfdLNBuQ+tuDErg0ko6fHYyMrEo+2/nAkEsFUWWlKVOv7yCK
   pwcoulWBM12tu49berUNasrbi3BryLlsCeb6FjJVKN0ORIXQehuf1s+01
   b2KqgI6afIwu2bE8VLa6USyQCqT0QdM8vPQid+x5kk7TVsmp5Y72oem62
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="46917945"
X-IronPort-AV: E=Sophos;i="5.88,258,1635174000"; 
   d="scan'208";a="46917945"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 10:06:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwLV00ItEYuyla7jeuQ7W7QzfWRDGWN3XznIoRr1ijBG5/rl9yvpgU8aViXIWttXpJeNcrDYE7uzEIiQ+4lJynOaqDsCVDOApVjMBbDCbCLNXiDMTNqxs6XDzRmj8WY5XTNNXbWf4Srm/5EzJgh1HByk9SZcEwGrtfJk4MXL4LTU9wfw1mIyQvLFs6sapPlJFTec1xvUr0U3yokOV+6rXswXc907TbJXIhq0/7sf+Zd5plu3ow2YoDQyPgflvSIzuu1u2rZq+6Ozr41+cFXZ7xg6WoUWpd19Y3vCGSMn/cR/BFFNUALAN+oFwH/CFYjR7lGBJpxkfwlMsWcnBIV8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOKDR9ol/kqU585q4U7QNmz0t7rz9bvdOS5MW0F6lSA=;
 b=JNCBgAeoW/2/s4DWOlsdrFyAqzpX3LMluqmTdEApnVG088Vzety5Ay0d9+TqLbcqEUoANaO9y0msDfE49QqJ/ygnGnj4mvtJFINfpzT8PjKZTfLRMlurBEEoaH8lIm2xbx6bJlcVAvkHYr3l8iNyGkR9PeqdwfwS2P0KvNctg4ymJ10FiUg40bEZmo9A+rAn4eqRYuZghLk0Deq5mAGhBI5pF0NE+WDArK1UzjmM2RDdSbYaY32unAEbGbJZicgboJ1ar9FYPIh/EyK/h+BvC1rXjQw2sT2OA1MDWlltzsoUkBrPIOnebA9X6NKjqZ0854WOy39F14RY9oxpqCrQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOKDR9ol/kqU585q4U7QNmz0t7rz9bvdOS5MW0F6lSA=;
 b=Pez3DA8l/+Jz0YFoKQTSRxPmniAEWOoyu3QDlVUBd2zLB5er8wN0G/j0E7qGohAc+N8CVyF7dmpRs8DRc8jpuFuXUNCrS9rApUh9c5fCkXPeorQ3mq0C3JmVZuPVI/uVls6YuK64IPgfZ/IZiDutB2kjJhYYLHjgmZq28Ni3LL0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB3894.jpnprd01.prod.outlook.com (2603:1096:604:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 01:06:28 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 01:06:28 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH] RDMA/rxe: Remove duplicate WR_ATOMIC_OR_READ_MASK
Thread-Topic: [PATCH] RDMA/rxe: Remove duplicate WR_ATOMIC_OR_READ_MASK
Thread-Index: AQHX/Vs6g8MajmAIJkKtgLl8Gitzj6xRNCMAgADfvgA=
Date:   Tue, 4 Jan 2022 01:06:28 +0000
Message-ID: <61D39D92.5010503@fujitsu.com>
References: <20211230085610.1915014-1-yangx.jy@fujitsu.com>
 <YdLh4octT3FNnI28@unreal>
In-Reply-To: <YdLh4octT3FNnI28@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8242a79e-58b9-42a7-9cf5-08d9cf1e7003
x-ms-traffictypediagnostic: OSBPR01MB3894:EE_
x-microsoft-antispam-prvs: <OSBPR01MB38943282B5AD1D3DC63EBC11834A9@OSBPR01MB3894.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9cGKG2UL97cZIeGKS8Y3gCiNWuXhG7ih/GqqpyGRD1PCwtte3Ks9+WXPMGY3JlJRrN+2F35uMCRZQSRrGEHxKr3u2ynhmrvNjITKwJIWHZf4RRICqEcU8B4SlILCKRILDMhWRw8eYKgHt+lMX3mkZ4x8gZtxxs06wnkLm3DQorZV87OxhBelzbE4sdPkZ3bRa/IdvuFvf9yP41U1hqn40kht/nq+KaNgICoapXpVId1ibb7WKuUaQAoGtWoiGfg9JxbBRcdeqcCAFTIUcs6/wFrj/T+dBLCIlp+B6btmOLL8hQq6srYD/RBCES4smARXdS8fpJTJdRTWwTaXj7tUnHJNk0gO0CdqtpuIr5YwWqa40xxqdBQWKJNg63SAEAXh15bKeCIjSQxamTJskl9G5Zk78XCMKZIqn/nEBqYMRXXBTaumsAf4W+1Q4G/x88ilbn9XzH0afF7W4c4xLb2TFYu96cstY5fV0QXe6bTXiUCOn2nLNUwAgcSA08MA0+Ngempk3cXTiXAhoUaL9fMpPK7b+Jhky0kcWW4A6gN7WKdOoUJ+XfvdqByNkOR5CbcZB7Y46ThWaa8P/1gZT3my9N8xQQ0wjQE0hbdew+3DZmQrQEYAQJn/Q81h12UtpjOxtV9T+SPRye5ooWBo+UAHl3Qa7ncOw1M7gQxtQ0LmkSWkcas3XA+sU6NskIiyD9xovQcczxUazZV821rIScPvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(64756008)(6506007)(316002)(6512007)(66556008)(2906002)(83380400001)(558084003)(91956017)(38100700002)(6916009)(36756003)(71200400001)(85182001)(33656002)(66446008)(8676002)(38070700005)(66476007)(8936002)(4326008)(26005)(122000001)(508600001)(2616005)(76116006)(66946007)(54906003)(86362001)(186003)(5660300002)(82960400001)(87266011)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bkdmNzdCWVlaV0puTml2Um1FV1I0aWJoMTdjVitZbmIySjhLZ0g2MXd3UllJ?=
 =?gb2312?B?M0g4NE1lMGM0T2ViMTBTcUlzSTdObmpCU1llcUZ4ZXhybTdXeW5ibklzdm1B?=
 =?gb2312?B?blc1d0FnczMrdFI1bVg2bS9Ia2JqWXd3UElMRDgzK1NQVk04R1p0MG81MVBt?=
 =?gb2312?B?T3NVR0J5Rk9KRmJIWW1iaWk1SXpJbitFZS9LT2YxUitVT3VFNGszWlJweDA2?=
 =?gb2312?B?RzlnRUEvSmJhcGUrUGxQY3AwcWVCRUNBV0JOcWtMQTYzTkptaVN6cWhNbnFo?=
 =?gb2312?B?WGVxZllNb2ZzNDFNRjB3NW5EOVd6MG5SeWFqT2hIaGFHa09WUW5UUnA4b0hN?=
 =?gb2312?B?QnZzNmtxZGJWeFJMVXUvdDdhR0tQKzRzdmp5WVNIamlXVWROaDI4QUtVamN4?=
 =?gb2312?B?cFpjRTZWWHJPdXFWd1Qxc2p2WWErQTZnaGR6anJYbHZLWjFiTVhDY1c4M2pT?=
 =?gb2312?B?eFZMQllRVGdkaEN2ZXJJTWdvWFdndTVWbHJpa2hUZlZMd2FRM3BINlN6cUJT?=
 =?gb2312?B?YnNGVDJZZjJUTDQrOTd6OEJHKzNpRUJuM3NUdjF0SFJNbW1VcU9VR0tTdDFY?=
 =?gb2312?B?YTg0T1pDelVwbExFa1NiaUlLa2FMVGtVUE5FSzVOOUJRelM5YlRJeHNVWVE3?=
 =?gb2312?B?eFNHYU10RHNGcEVzai9hSmx2a3ZEeEtvSDQrbWxjQ1FDcG1acEtiOUhqeTc0?=
 =?gb2312?B?anJZRXU2MXpIbjdLMEdVeW1LbkcvVjhvaFN3dmdVSGE1UFZqZnorVWRCMExU?=
 =?gb2312?B?ZThoaHUySlJwNnhvaEg1eUVVeFlKSjZZMnBwYnY4V2U2Z2dIcFkwS1B1RmR0?=
 =?gb2312?B?MnhMcThwWTJoalRnTHlWSnZKb2x3ZC9nY0txNFpobTY3Tzd3c2FlaFVlVkhy?=
 =?gb2312?B?eDNxenZLT1A0eTVSUk1TTmtKU2R1VTE0U1Vzc0RtQVIzeWdhMldNSmQvak9F?=
 =?gb2312?B?S3BJRXFZZlpVaFhuRGhEUHp6cU5RaEZqclBDWjVBMTRXSkZWM2tMaUhuem45?=
 =?gb2312?B?cFVZOEY5R0I1dzd5Mlhsa09hTUZoMGJDVXJkbmd3UXNMV0Y1SWp0bWxUdlN1?=
 =?gb2312?B?VGJONmx4cXJsTHZJamhHL29hMkVtZE9vVWNSWVZxcWYrcW1vV3dycmpSczNs?=
 =?gb2312?B?RWM4aUZ3YmN5SVNvSU9Oc2hZeFFBVzY3Tk1EbTZ2V01OZGM3VGNRNGRLd2x6?=
 =?gb2312?B?V2kxRE04cndoZVZ4WENTL2ZpUlJTNGtUNkw1OXlyOUVEQk5kb1ZBZjRZMXhY?=
 =?gb2312?B?eEphRXJpYmY3K3lHbTYvV3J2RjYzeDNyYjJFODNjWXBVL2d3K1NGNURJZEZm?=
 =?gb2312?B?R2s2VDVsSDI1V2tVMFA3UFJhYnE0K2s2OGpidW04VlZKSjBERkFDbVd1R2ha?=
 =?gb2312?B?RU9qTS9TNmZnczlRODBTMmpqNjZXNStDVVZkYTFUVEhkRGl3SDVFM1AyVkp3?=
 =?gb2312?B?RTJSaXVBU1ZRNVVIUTVmbDVyN3M2b09keVI5QW53NUd0ZC9FanNRTExYN1Bm?=
 =?gb2312?B?TnFxaFllNFM2Zmd3SGdkNjREZ0tmMTNITmN3dE1EOGRTa3JJNEFRY1BFT0Ew?=
 =?gb2312?B?ZC9kUHUvcTBGY3lSQTMyUjRWdHVTdkUvUmZTa1VPMFhyY0padHJ0d1BGUE9P?=
 =?gb2312?B?dnhJRWU1Z2x4MmFXRERLS2UvUHZBNDZBSUowUk45OURWY28rY29jTVZNTzFK?=
 =?gb2312?B?d1hncTZFOFB3STlkcml3UEJ5Z081M1E5QUlNcnI0TEJQL000R2NyUFZKR1l2?=
 =?gb2312?B?eFZIdldPbDUrN0JwRmRMQmJuaTBZUmkyRXhXbm1kelFCYWwyQXlYQzlUbFo4?=
 =?gb2312?B?YytKSk1GbjZTc2lSU3loOTlHbEp0cVkydmoyNE1ab2dVdW9ucC9aTWRzYTZT?=
 =?gb2312?B?anZZQXBsSWNHRVVtMFY0d2ZxVDBLMHJOd05OVEhPOXdSbGpWN0h1YyswemdX?=
 =?gb2312?B?L3VZTGZMVkNUeXpSSmR2dTNmb0ZBQUNTZHpGNHpkMzFqTm55ZzNTVDNNN0FQ?=
 =?gb2312?B?YlNaMXR5VTlpR0Y4RlNNQ3pycE1QMDIwWkxEcFMvbit0Z3ZEeGVWb0svc0hR?=
 =?gb2312?B?L2Y5M1IyYUVmb3RIc2c1UHUxaEtuMThUR0E1YVE2Z2pjdTFnN0VJMSsvRjJa?=
 =?gb2312?B?WFprekhFTXhQQzlCODVmQnhmeFUvcjI5OUpscDEvMXVQbkNhWWNaTWVZWTJT?=
 =?gb2312?Q?1U/HLY3TaleOD2BYIbaeoRc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <4A181A18474FB14FA994D0E50328E8EF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242a79e-58b9-42a7-9cf5-08d9cf1e7003
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 01:06:28.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lx1bP/+z1yXuKG+32aMw7Zd0Psh88ix8vvLzlG70JruQcQJYNyvUZeVkYqJDq0pfQDuZkVaaJ0hkJxRpybhFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3894
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzMgMTk6NDUsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gSSBzZWUgdGhhdCB5
b3UgcmVwbGFjZWQgV1JfQVRPTUlDX01BU0sgdG8gYmUgV1JfV1JJVEVfTUFTSy4NCj4gV2hhdCBw
cm9ibGVtIGFyZSB5b3UgdHJ5aW5nIHRvIGZpeD8NCj4NCj4gUGxlYXNlIGRlc2NyaWJlIGl0IGlu
IHVzZSBjb21taXQgbWVzc2FnZS4NCkhpLA0KDQpTb3JyeSwgdGhpcyBpcyBhIHdyb25nIHBhdGNo
LiBQbGVhc2UgaWdub3JlIGl0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gVGhhbmtz
DQo=
