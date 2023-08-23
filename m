Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1C0784FD8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 07:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHWFMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 01:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHWFMB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 01:12:01 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 22:11:54 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA6CE57;
        Tue, 22 Aug 2023 22:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692767515; x=1724303515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fbtfHDiQzJhnZxpO+QWvZEeXINPhk2K4vxYLzKscRdg=;
  b=EIY3nZ9AgTOHEhyzC8t9V3BuajZwMQIJ0ZDmruZ7HlBuAmW31NUrG0hr
   v+UpVpdImF/8VHsJqJrwv/sKOP0XhPcAzpehi4Lfh1Yj0EpMWSOa4xGg2
   Rlbv/EQm05xs68r1413AvRV19t3pS1SyEIjhKIlZSlH2jNjs+4kmpvPhX
   +sIMvjB7Lwxs3MWlRYEdl2e1A1ien5rgatutIvCr+OllfGUFQYt+WMFVF
   s4hH29iEnw0+jokqwoT0zypyng+Bi4vwaE5JXm8QQZA8DENAXuaJWIACK
   12a2eRXdl3YL4U7GwqBF7ePINS+EYFdjzXqGc9AEqGOOc5M00DGqKOiPV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92985380"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="92985380"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 14:10:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYzM3tGnF7bp1qlte8fV9aAIqADSqzbVo21ifcoY8V5ycdpH7O+F+DiUQyHsj7fkyWh7drh5kZj2cH3AhQi3/j43+IbWYF+ToYqEexn3yDCXk7IGRFAqILqisv9Z2R/cZwXlJEi/F46nHIEjsGewmA+AdpRPHw61uWP/OzSgZ1vsNR1hF2y5RNZ0yyaO4Nufu/OGWWKFrO62+rkcqBfYszsSKWtipI8xlELO1YZLOIyhHe14IcHsRNTQ8NKH2+slJZ9BtrbPUVOeWXB9+UeIE3loxZpuXtCWCurLWRdTfnk29WRPL3wS+zcrNFEjZaw+0dwcgSm9Uq1Zz4QN2wQf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbtfHDiQzJhnZxpO+QWvZEeXINPhk2K4vxYLzKscRdg=;
 b=Ih97mMw+aN3An2wzmw1dNb2lhP5xMbnqMb/bVm/+HmGDZpCJPWjxwtvVQT8ljBPjnm9nxs/Nr2eypeu+TkpARSeiMtA75SOssPbvRh8Fb6OBm9iCiikpa0sxUn+qMozXF7FP4hUpjZfgzuiQRJEuBo8f7Yo68dxSq5LQuQ8xQ3dBFlt2QbNlR+k75UPRZ6DbE5tkcVaWShwpTzXit4ColVJR3c9Ic9TsdJW4uyWYPB65RrkbnkAPEialefOaEAxjdWM/iXI0klnbBmpFlppTnBge9QjtXTz1qF4TQkx9/DYPdX1QNN3pevD+prGS/9KcEAnfns5mBLKB4dzl1auC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYAPR01MB6187.jpnprd01.prod.outlook.com (2603:1096:402:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 05:10:43 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 05:10:43 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdpgNSw3ndasU6QgtsG1HLb0q/3KT0ggAAJHwCAAB/aoA==
Date:   Wed, 23 Aug 2023 05:10:43 +0000
Message-ID: <OS7PR01MB11804C33AD975437010DEC0C1E51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <OS7PR01MB11804CAF2115EA88678B1B2AEE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <07507497-afad-d39b-8514-11651283dd51@fujitsu.com>
In-Reply-To: <07507497-afad-d39b-8514-11651283dd51@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZjhjMDA1ZGYtYjA1Ni00ZjkzLTg5MWQtZDBiYWRmNTAz?=
 =?utf-8?B?NjE5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yM1QwNDo1ODo1MVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYAPR01MB6187:EE_
x-ms-office365-filtering-correlation-id: 42d27912-e2be-4720-3eb8-08dba3974d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiDTdXAGqPqPT5Mouxhp8Hcw+bWXr9tqHKgRqgmMYBk8VQe85/oYuTaztfnGRZC/oym6Hl2nHuvuPvaxtXD+y7uooLjmyTz6b9PNGLxQu66NaICM15dJAvMvwXJjffAAOV/v7G/ws0FnrnWNDRDttJzNruPYNC87MeqvM48t/xqRkFh2ZMPZ5rBP1oMg4BOZbhxT2CMODS5CyhrID/SXFDN20Rpx6Z9BU2LITO5iDbIJgxLzQFpFQ0FKj+dyntpbW/Sxw2TWSJl05Wtgv4vOVU7RzSknV0zzdsRc7bnU3HGtSu8GGAkSwgCFaRhfhS3X+cCF5SoVphSzaDNbKOCD4AXctvroKfuNzzNoPx57t2PC002EFmmIlRBk0I0F1s71fNuAs0uUQLMI0sODyzVZ4ixCHIpM0TSaID7+U+OPbpkEcEzRapcJY+i6rIsylXZuxq1zIz4ImcsZQNfRxmfUHLKoHs/3gNI3cknVRaz8v0+W4uOMeDrAPmim/rfvJcUjAqrxpQ7+sVxags12Z+M0sVTOxwD1RczSw9lOQlJsY9rTA3sFx2gtsL2FmhmPNR8sKZV1T5DJDvdVDvswvs/c46hqDZ8/iIbC9ekCf0zS3P34DqjJ+5JS8K3trjpaxRR6SzBqTidJgdMbfXdB2Euf1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(186009)(1590799021)(1800799009)(451199024)(15650500001)(1580799018)(38100700002)(38070700005)(122000001)(71200400001)(478600001)(82960400001)(86362001)(83380400001)(53546011)(9686003)(7696005)(6506007)(41300700001)(55016003)(26005)(54906003)(85182001)(66556008)(66446008)(66476007)(110136005)(76116006)(33656002)(2906002)(64756008)(316002)(66946007)(52536014)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2YraGk0VWdJWDUvVW1xaElOYWRSV1lzWSsyN2FvbG45eVFPcmFxSXFtSFJo?=
 =?utf-8?B?QjlSQklKYXExV05IOWtXR1ZwZldSSXdlMjBoU1VMcnFXajJsWnA1NitOeHlq?=
 =?utf-8?B?WnR3cE1GbDFxVUxJaUNiZnVOMHVEbExFby9FMksvc05CbzdOQlI5RXJzMTF5?=
 =?utf-8?B?NnkvZ0JSeW5pa21zc2QvQVBEd0lGU2FHOUVLb2hyOG9SVTAzQzFUcFMxT2RI?=
 =?utf-8?B?YmxxTE4vY1hyV2QwWlNCQUsvWTlXRjVISkVJcE90T0Y5Y1B5R2NlYWZIY3RN?=
 =?utf-8?B?UE5QVjZUNnZNNGQ2cGJGZTNqcXZ4Smo5Y3VkaHhUc09RV0pxUGwwWTd0OXIx?=
 =?utf-8?B?VnFtaG5uMVRrUEpPSi93OU5XTHJTZ0ZLcUoyRXVMbHMva1dGWGU4c2hLYTdC?=
 =?utf-8?B?YUdPNzREeXBoQ1ROZ1RjOGdEbnQwWGgrOHJnbmZsTXVMbHZ3L2FJNktwMG1x?=
 =?utf-8?B?TW9LTGdwZC9ZbUordktqejZ6cWtPVTFJbDNBZm9QR1FBWmNpSFk0RW9pQjhQ?=
 =?utf-8?B?V3k5ZEl0d3hPajY0MmY3WWkxSWN3MnEwNTRORmhZWXI2T0tlTm00OG1QZ0JN?=
 =?utf-8?B?V2k2MkFlQ2Nkakhia3kxS09wWWxuTCtPQVJTVDV1dU1aT2RQYWE5WVoxbWZY?=
 =?utf-8?B?ZkdhOEgycjhndVdiekRUejhxTFdONnhjSnRQZlA1NFZqSnloaUp1eHNxQjJ5?=
 =?utf-8?B?OEVJeXpkdnhJcW9PY3E4b1U4QkVpUjNGTlVpUEk3TzFCY1VhM1BLVHVQQ1Jl?=
 =?utf-8?B?YVBERzNKWWdWVlg5VUxVUVhEak5GV2xMdDdtZTBRZ05KME9ubnJFNUUzMzNW?=
 =?utf-8?B?M0NpanVENUNITWdpUHNEWUFTZlhjY1VwRDhGU3NodTErcVQ0aVV6Zkc5VlpE?=
 =?utf-8?B?c0lmYnVlYUU3SStmV082aDRoMi9RMmhNTTZXdGhIeUNENllWWVlWZjR4K3JP?=
 =?utf-8?B?NG1VTDZGZ09iMHh0cFMwZXZzUmtvV2FJdnp0ZXhjZE82bnM0bnY5K3FhWGoy?=
 =?utf-8?B?a3ZCWWw2Nnd6QU5TeDR3VTZEd2NyaFFhZ1k0aDgzR2ovTzk3ZGM0b2NpZW11?=
 =?utf-8?B?VVJINi9zRm5VditENHNTMEVjM3ljV0h1QlNTeG4xcnJMK1dlUlVqekQ0NnV2?=
 =?utf-8?B?TzhiU0Z2YXZJQ21zbVpHZmlHWjBDa0pUbTdSWFFPcVNnTWR6a3pNeHpSbjRW?=
 =?utf-8?B?S3BwcEN0WTdjM3JqTWxPdXNsU1g1TUpIWGNST1hVa29OcjJDRjNJbzQ4UXdr?=
 =?utf-8?B?MW1UUmIwcklsUmFxTzhNemJNWkxVbWRIVWtkVG1OeXNFN1h3dWl3NnVuNDBn?=
 =?utf-8?B?NFhFdENaRnFBME9iSjRRSEZMeFpSNXJkaklMbGJtbVZrQW9OWUlmOS8rZzdY?=
 =?utf-8?B?NUNyUkNaaXNGeEV6N0d0bGdTZVRqZnlsUEl2R29TbWEzS2hoalVuWXFUWkZZ?=
 =?utf-8?B?ZFVKRW1uV3RkelAzbXQ1a21zaUFvQmplU3ZKWVRURUMyTG4zQnhEMndPT0NH?=
 =?utf-8?B?UFBzcWNMeVNEdlhLMk9BQ0VjaW9tVUd5SlkvcU9Oay9tc3ByTjBBTHNLYU5X?=
 =?utf-8?B?ZUpIcGNKZHV3SzZQdGRhUHNOWlNVMzlJYzJJTWNoY1RvNnV2YjBWd21BMXow?=
 =?utf-8?B?cU5OUDc0blJWNElUVEdjZ2t5dHZCWnRjMnZPMmR2dXkzMmdkYVBwYXdiVzgx?=
 =?utf-8?B?R2I5THNYZkI3cGNoRFB3cldJYVZONFI0Z2ZDS2o0N3NMN2x4ZWNTcGt0N1Bi?=
 =?utf-8?B?TUxNUVFSUmtXY0hoU2xncCsvam4vMkRReVRYekJsN1lMUjJyVXZwYlpleENL?=
 =?utf-8?B?UzloeHVqQmJhV0ZDRGl0aVVYVWk2Ym1ldkZ5NlYvVGtQY0lOSGdwSzc0bkJa?=
 =?utf-8?B?NlBqZERxWVVnVnVQUzRZK3VvQk1tTGRaNSs5L2hEQ2pIWWpHYmhSaWpZeGla?=
 =?utf-8?B?TzA3MGd1bUFKdHA0Y3JWYzNUMmVzSm1zWWtDRkdPczZ6SHFxc1dYWGlDOWlU?=
 =?utf-8?B?ZWZaSzdZcDlWSXgzdmsyVjRIV2h2b2hBYS9hOUdjelI5NmlacU1vcWhRekVv?=
 =?utf-8?B?SmVnOGl6V3Z6a2J6Vkg4YXpDajVMRkJHc3puR0M0cmRFcWlSU2M2NFdLRElL?=
 =?utf-8?B?dmdPYzhBMW9XZDJkdSsvV3RzTFp5aVc3RUVUV3M4MlFuT3lsY2xicCtOVzhV?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e8Ru1nqIw7kiXshL5X3VDame7P8zezT7hT2UPUTKjZhxEv8BhzNGB4Nb5lgThxG04f0MaiS90ckinsMv7wnbusK3jQFmm13H3x7ykwPXPsG7FP69v1YqFJ/mzabVw/Sr3VvNKufjBPqJUVqf6Hp8kgpNKBb4xEQbq//gXKASCkYIIcbRmc3uUkrDB6eevZGIR1xKXTma0oYZZdOUEdqsFITxs19LHQdSsJur6UOto/6Jyriz64GUUMUaz1tAyk/iNrzt6hAjXadHAl5aL5YlBTOjHGlLOzaHrlszK2JH1ont/txNlviGgTbXHnC29/g7nBL+FB4g3gdZEoDkRC5r6GmtMCo0pIhuoeD+AV79wcXpT/4Dfvm/tUFBCNljjycK+OgbfxlcYP6o9PNRNPdIN1o+m4QKinLjmtzxiq8YRiJJG38nI8bma7GvbmJIPRqVyJDmRqsLJ+KNw/BT3RmipZrh838Ul/xvB0iu7Yl6CW35AxN92ED15e1/NGglsvxF0NuhVonwpVzLENoO0yE5LkcX6MvLfr3Bm4ZOLNSr8mtgJvbuTvGL6eGhikBU2oTpv8M25PFHqfx1AwET9eVMn9u+RP9qWoafVBCCOSrQgUoVwUmfhvwyZDV0Se2qu1VUiy8aGP7VYjguJvib/U1PO1chylK3CAk/Sc1DLm6zaYmCxxlV5Ny/ZsZs4maKpaOo9gUvySoykVvtRnZyGNnSIE12KeWiNYTsAkjGAbxy4aY7x3yWd9yOICWAwIyTpP2RyvBT3catuaXRrm+4ch2tAlqf23XQ7rdniehFENfM5sg+6jQ+QiRAewFcEU/Jz6kzxuCRcWzlzOMBJMYOhd0/tocb/LMhNMBxuPaffswmJow=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d27912-e2be-4720-3eb8-08dba3974d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 05:10:43.5238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5wcdugwpDTtcHxzonowOdzwYgQDzw2/y6e04BKs/ajbzRy1sx1iSb8Aak/ZtjHXs56xdOvuyh4KCDBiak/kWcAc/4sxtw3U+WaaqeLs5p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6187
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMgMTI6MDUgUE0gTGksIFpoaWppYW4gd3JvdGU6DQo+IA0KPiBE
YWlzdWtlDQo+IA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJldmlld2luZywgYmVzaWRlIHRoaXMg
cGxhY2UsIGkganVzdCBub3RpY2VkIHRoYXQNCj4gdGhlcmUgYXJlIHNvIG1hbnkgcGxhY2VzIG1p
c3NpbmcgbmV3bGluZSBpbiByeGUgZHJpdmVyDQo+IA0KPiBleGNlcHQgcnhlX2VycigpIHJ4ZV9p
bmZvKCkgcnhlX2RiZygpIGFscmVhZHkgYXV0byBhZGRlZCBuZXdsaW5lIGluIHRoZSBtYWNyb3Ms
DQoNClRoZXNlIGJ1aWx0LWluIG5ld2xpbmUgY2hhcmFjdGVycyBzaG91bGQgYmUgcmVtb3ZlZC4N
CkluIHRoZSBrZXJuZWwsICIqZm10IiBpcyBleHBlY3RlZCB0byBpbmNsdWRlIGEgbmV3bGluZSBj
aGFyYWN0ZXIuDQpXZSBzaG91bGQgcmVtb3ZlICdcbicgZnJvbSB0aGUgZGVmaW5pdGlvbnMgb2Yg
dGhlc2UgZnVuY3Rpb25zLA0KYW5kIGFkZCAnXG4nIHRvIGVhY2ggY2FsbGVyLg0KDQo+IG90aGVy
IG1hY3JvcyBzaG91bGQgYXBwZW5kIG5ld2xpbmUgYnkgaGFuZCB3aGVuIGJlaW5nIHVzZWQuDQoN
ClllcywgdGhleSBhbHNvIG5lZWQgdG8gYmUgZml4ZWQuDQoNCkRhaXN1a2UNCg0KPiANCj4gQSBy
b3VnaGx5IGNvdW50Og0KPiAjIGdpdCBncmVwIC1uIC1lIHJ4ZV9pbmZvIC1lIHJ4ZV9lcnIgLWUg
cnhlX2RiZyB8IGdyZXAgLXYgJyNkZWZpbmUnIHwgZ3JlcCAtdiAnXFxuJyB8IHdjIC1sDQo+IDE0
Ng0KPiANCj4gDQo+IGkgd2lsbCBkbyBhIGJpZyBjbGVhbnVwIGZvciBhbGwgb2YgdGhlbSBsYXRl
ci4NCj4gDQo+IFRoYW5rcw0KPiBaaGlqaWFuDQo+IA0KPiANCj4gDQo+IE9uIDIzLzA4LzIwMjMg
MTA6NDMsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+55SwIOWkp+i8lCB3cm90ZToNCj4gPiBPbiBXZWQs
IEF1ZyAyMywgMjAyMyAxMToxMyBBTSBMaSBaaGlqaWFuIHdyb3RlOg0KPiA+Pg0KPiA+PiBBIG5l
d2xpbmUgaGVscCBmbHVzaGluZyBtZXNzYWdlIG91dC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jIHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlLmMNCj4gPj4gaW5kZXggNTRjNzIzYTZlZGRhLi5jYjJjMGQ1NGFhZTEgMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4gPj4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPiA+PiBAQCAtMTYxLDcgKzE2MSw3IEBA
IHZvaWQgcnhlX3NldF9tdHUoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdW5zaWduZWQgaW50IG5kZXZf
bXR1KQ0KPiA+PiAgIAlwb3J0LT5hdHRyLmFjdGl2ZV9tdHUgPSBtdHU7DQo+ID4+ICAgCXBvcnQt
Pm10dV9jYXAgPSBpYl9tdHVfZW51bV90b19pbnQobXR1KTsNCj4gPj4NCj4gPj4gLQlyeGVfaW5m
b19kZXYocnhlLCAiU2V0IG10dSB0byAlZCIsIHBvcnQtPm10dV9jYXApOw0KPiA+PiArCXJ4ZV9p
bmZvX2RldihyeGUsICJTZXQgbXR1IHRvICVkXG4iLCBwb3J0LT5tdHVfY2FwKTsNCj4gPj4gICB9
DQo+ID4+DQo+ID4+ICAgLyogY2FsbGVkIGJ5IGlmYyBsYXllciB0byBjcmVhdGUgbmV3IHJ4ZSBk
ZXZpY2UuDQo+ID4+IC0tDQo+ID4+IDIuMjkuMg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERhaXN1
a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA+DQo=
