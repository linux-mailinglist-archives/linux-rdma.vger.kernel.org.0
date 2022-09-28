Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085255ED523
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Sep 2022 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiI1Gml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiI1Gl4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 02:41:56 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 23:41:39 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64A1E3F2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664347299; x=1695883299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A5qnoQ9qm80e3PnR2L1BITfNx5jqc+Gdu8kZ6FioO0c=;
  b=p6vBOIv8V+0QYxmh9x5WLP+2/ZFQnSnwV7uyamyV/TvcCyCW6/RTY1D0
   q9iAijh2lDH0SRuKgtFj2zawA1WZZc83fl+qdYCPCD8G2bOQOd9jWyLut
   FzJUsfUR+EF9tqy7FRpvqbooq88a18QUoluRe1iMM+BrnTqE3IjLof4i7
   L9ygyTUkZmWsvOZCc815CfneHrxf9LzaunMjzlzQeYlK/r/IqRcEvfy7i
   +A/E1ezwslm0zSyhhNDB31XpKta5lz34ug5Npze6iT6mlLI2g40pvYsoY
   2j4R/14NxqIxBRCyuFrgbuG1L8IzJWMc0qepk8XPCGBU/p+BCjPuSOD6O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="74288899"
X-IronPort-AV: E=Sophos;i="5.93,351,1654527600"; 
   d="scan'208";a="74288899"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 15:40:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNeq2yEQxGooefINxYHn554V7HUdd/J3Wl+3E5Xc3f0TDFCshc8A5O/Fn+OKKmzKy+MZVtdEfBLpKanFNzO/vh0mKEzYjlsW7MZ50GFABuubaR3UT11e1g/Rvpdi5bA4abzQa/iuUT1aerJFE/wn9NxAVwep8JuzLWk6HKC/haskqqILELEkUf8WvWWoBH7fjyl0Lv37CdtGE35+iXCobTw7E5IYkIY0j50U52mdHGEnJG3/8LOHmN0e6tPi+7j/RNm3K/ZB+ekkpqKb0yqZKqY1zXOhAuSeQ6ExOKIWMOViqNPi43Zkz2Q5cFMU7ylgsLCp2zuVZVeyV4DYebuS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5qnoQ9qm80e3PnR2L1BITfNx5jqc+Gdu8kZ6FioO0c=;
 b=hhGMhr0STniqljXRIFmk0ox2Q+Ig2v3P45VMBGYbztsMjfI4RdDrDNoR9Y48Y1Klhs/O2D1ahUKDv3mffq3Vv/B+YGeVRCO+EJ7x3XVlRTzfyuXzOOMVFS0YQytoNSHRcp6cln+RfNJ1Mt3xvRwHWu0mFncIIcULxsIWQq9ruRIQfJ02SGy583l5Fs/oQ9fG65503gxrPFoyUDEtSvHeID3RmOjMSxQnLurYgns2Sb3a/7Duje+s/YnBcmOrs1MYtKtCGXVTI0Wd6pWlSrDMT5MGXDcjIP6y+rsDuwFd4mtF4Xd0QH3BMXeV1ImxEJ6G4qgBJN8g5XFHZ4y69BBNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB8903.jpnprd01.prod.outlook.com (2603:1096:400:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:40:15 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d51b:780b:2b6c:9c4a]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d51b:780b:2b6c:9c4a%3]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 06:40:15 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Topic: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Index: AQHYwmPAjFT9wyoflEKiuh64EWqIi63Z1kOAgACFygCAARD/0IAA0IqAgBgjDrA=
Date:   Wed, 28 Sep 2022 06:40:15 +0000
Message-ID: <TYCPR01MB84552F7598F695D0C7CE16EBE5549@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
 <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
 <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <4a9f2b42-f230-b951-f03b-588b94cd39a6@gmail.com>
In-Reply-To: <4a9f2b42-f230-b951-f03b-588b94cd39a6@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 8d731a38a30c4e7db4038d958e5ac61c
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjhUMDY6NDA6?=
 =?utf-8?B?MTJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mM2FhZDZhMC1mMDBmLTQ2Nzct?=
 =?utf-8?B?YWMyZC1iNDk5OWM5OTJlY2Q7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB8903:EE_
x-ms-office365-filtering-correlation-id: f84fbcfe-cf18-4635-6238-08daa11c4d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGM4ikguWegIuGnGc1cNl3OgDlgXgMtIwA0Ig0B0ZuvRFHHAArrO84qsUP750wW1Qd3Luw32N5OKPL4evDc43g4r2XU1s+dVFt0DSy2GvK5AZFxO8bIcXEKO7FinGtIYRebqH5f288oyJabIt8GmakUMwO6B1w9y7ZRoURs7nC0937dXbQ68fVj1zcY30N7hhqmhVNy/s7qcc6wZoXFNNbxK+GwltWqNVTmtkJE+41nnOKnk29nbdAJ/DVjAjxPSdMeROQGsrHYARWrb6rlouMEGPYbqArVBhvPgCuEZrQpf0cp68a5gHBWo/DvZrtgShQbd06GsPEmetdYphuzGv7NyTjcUuZTiclZ76wg4P3PHlP/k69CY4DIcZqmuehYB5u6GLxrv23mV0wNRRhFvJ1SrHQ9VSp7SDv0xidZgcHBTaItMaTC7MweGyQbuSIDUNsf3BeHe6nLVCVwE2WrZZWMtWDGB4GnsCeOhNymZXfEsQQgwRyklkcDKY9XwVl80xxueDoc7K/u4Mijrv3lXai5v1vRtwiiwSAesxd/vzFq/ODCvnDuYUOK/0JdJyOg5mF8R+3jvZyUIpoMWS1mudkKHey8f3jSNrGgxf1/ZrxhDYQ1LmlJAx4Er4pRVhYTP2DIbPzwO2Q4bvqpZq0/QP8r45DJHmb/5Y3CKEdXn64CemvlORiLH7e2iYWJiVg7d5IJaRTtL2O8sg2Crav1jKrWzYtPOtChlZxSE3XdlKn8FnKrO/QOpm2wHohG+Wz1CQdJCCVEGVZggc4up7M0OcXavlnygYXjjbtj5RGuDoTEq9ZFvd0XU7/fFHNI0emaOVcMhQWlj4qhckBJkduLe3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(1590799012)(451199015)(1580799009)(478600001)(5660300002)(107886003)(8936002)(86362001)(316002)(53546011)(6506007)(82960400001)(7696005)(110136005)(186003)(26005)(52536014)(85182001)(54906003)(55016003)(66476007)(66946007)(76116006)(4326008)(66446008)(38100700002)(64756008)(66556008)(41300700001)(9686003)(2906002)(8676002)(122000001)(71200400001)(83380400001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lwL2s1QTgvWGU2U3RNQWw3alpYZDJ4emwvMldkUFVvY0dVZXFGdm9rYTE2?=
 =?utf-8?B?TGpucHhjbXA1cDlCbkZJV1JYa21DbWwyL3ZIM3czWVZNaWFLTTRYWXRkamkx?=
 =?utf-8?B?NmZmMzNpdzh0aFl4WmR1MzZWNTZRWGtCUk52REkvZmxFRDc4TlFFNlUxbnhI?=
 =?utf-8?B?RUMwS3hjWkE5a28wN01pQTc4OS8xNWRvM2poYjN6VkR6VjJReWdQUWZCWWpM?=
 =?utf-8?B?akNmRkZEd1VBSXI2Wm10cFQwd2pEL1FpNnpnZ0F3RHgycVBnT1c2SkFoUXF5?=
 =?utf-8?B?Wm5IWmhKbWFwVjM4dWxVencxZG95bGlYVEZKbStPUWphSU5UeTVDb3Brb20z?=
 =?utf-8?B?ZDJPMndzbUNGUzZvN0l6UUwya00vZG5UL3VuckNBMVR3cWRNWnV2U00rUFoz?=
 =?utf-8?B?aUJzOWFaVnZlUVJSb2M1bmlxaGlJWkJmNWxVcGpnem1iNmlMNmtSSmwzWFdI?=
 =?utf-8?B?OTBhaFFPdXlTMzNpZWRVamtscDBSNnBFSldKZGhlTjlwa3QxVlRFRTJ5WjJY?=
 =?utf-8?B?K1NmR3dwdjd6V04vRmNTRk5zNFdlQnRYZkg1VGNvOHVlNlpuamJmTENjTzR1?=
 =?utf-8?B?eVBqdTZ2MTZqTmFwa2hqY2g3Y3kxSXN5UkxCNnN3UTJDek1GL2JIL2FxUGx1?=
 =?utf-8?B?cHE3M1cyYnB6dlltWFQzMlpmd1VscHZjZk5WSVRSa2NBRlpyQ3FhZ3UyOGsr?=
 =?utf-8?B?dWxxK3huQytJNnNXbmU4enVWR3BqdjNEUkpUbkJxMWxrYWlVZHNCbTNDaFc3?=
 =?utf-8?B?enRXWHZ5YU9zOXBUNGpKenkwMnJpWVpCQmFkbEU0QkdMSHZZcmVvMFpCR21l?=
 =?utf-8?B?NGdLVlRBaFhIR1RhMVFYazJLdkJ1bUJNbllQV1dndktRWTNJOEhHWmZ3ZjRV?=
 =?utf-8?B?UCtlM2hhaHZYTFZSUVJ6Y0JGYlZ5MmpIclM2TkFuQnpCSndjY1JHcGRXc1ow?=
 =?utf-8?B?enEyekxRbXpicTVldDhNZkg1bnl1TjltbGtNVW1zODg3TDJhMmRkcGFlaGp6?=
 =?utf-8?B?QzhDWjA2QjJiRjdwc1VtVGVkZGN3c0xUMWVxQ1VKWmxlUGZsNm16NWFRV3E5?=
 =?utf-8?B?UEszVUcxTksxQzhTMUFPNVFIOEg2aEFGbmFCOFRUYnMxQ0lvcjdoZUlUeEww?=
 =?utf-8?B?V0NxeTBPdWNCTzA4SmJBU3dJaytaQUdveHhYdU9QV3JjcUNqYVBwNW9idVdC?=
 =?utf-8?B?ZGhQNWhzdXB0UW5McXlwSGFhOHpwN0FMSEtuYTZXUlZuQjFlaWdodkhTSTRD?=
 =?utf-8?B?aGFkbXQ0NnhPbXVTWW5KdTY0UkVXNHVyNFNwbFU5eXhWc1JHZlNjZXduV2Zr?=
 =?utf-8?B?ZjRQSm9jNjBFd0FKRlN1M2FyOE42dERjNjRSUm5uSWJEUkFmcmlReU5HcGxk?=
 =?utf-8?B?UDhIR3V3K0ZPWDVXQnBBQ0xXdFFLRUNVakFaZElnT25SWlZXWDVMckxKazVD?=
 =?utf-8?B?WDVuOVZVUEpyZkxHWktaeXpjcHExK296ZUNtZUpCK0t5Q1RzeEI2OHZzK0hz?=
 =?utf-8?B?VlpCNmEwNldzdll4TGI5WEhLTnlMYjcvdVhsSXdUUjREdjdlK0dSZ0VLZUtj?=
 =?utf-8?B?U20vQjZTOUVyVktKbWdhOEQ1UmJIemJ6YSt6dzFrcE9jWTdTOG1wVjczUStX?=
 =?utf-8?B?eHZxZjU5UXhxZ0J1eWp3VkxJMmQ5THJuQk5jV1dyNElQZjN5K0RKVVBJbmY5?=
 =?utf-8?B?M2JWN3hlOWRoT1h6RXVCZDlYSVFzRlZoU1kwWE00bldBemFHaE05b2VjNUly?=
 =?utf-8?B?UDdVQmdHTXVOVkVIK1d6bHg3ZGZmZDdPdkozTnBmcTBZdjBzYnF3cHE2ck53?=
 =?utf-8?B?R250REdnRXlUSTlvdnZZTDMyeDFuMkZaVHhucXBycGhjQ25YczhEVGc4UjRT?=
 =?utf-8?B?YU55eklpd3Q5bFNUcC9TYk80UGg3NVh6cmhGNnRUbWhydFpYK2VlZmdDUmkx?=
 =?utf-8?B?bnNmQU81WllaZW50Y1JZTHJnbXBNZ3VHaFAzNGc1RE93UElObENUU3VUSTJG?=
 =?utf-8?B?MHNQZGJCOWU4bHIwNDg0MEpkN3FPaTR2VVFYc2EvT2xob1JNempoRGM0N1JJ?=
 =?utf-8?B?ZXdJbTlYR0ZUeUtlbk9YWmpUS2JvSS9CTTdqZXZtZ0hjQmJlS1pkS2tQTDFS?=
 =?utf-8?B?L0hzWDBWbFhYc3hLbitrV3E5VTlNbHVzNXlZcXJFR1dueVpQb250U3BRaU8v?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84fbcfe-cf18-4635-6238-08daa11c4d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:40:15.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtYodgzqIWNW4QnIugidy2m4Px53QTD0CnAU0ALBTpukWRmizu2+1sew7yOT1MDlWiUFtJPDHxS2RuTAXeS5THFrWmGLqEJ2zEQBENvgO74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8903
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RGVhciBCb2IsIFlhbmp1biwgYW5kIEJhcnQsDQoNClNvcnJ5IGZvciB0YWtpbmcgbG9uZyB0aW1l
IHRvIHJlcGx5Lg0KDQo+IE9uIDkvMTIvMjIgMDI6NTgsIG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1
LmNvbSB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAxMiwgMjAyMiAxMjowOSBBTSBCYXJ0IFZhbiBB
c3NjaGUgd3JvdGU6DQo+ID4+IE9uIDkvMTEvMjIgMDA6MTAsIFlhbmp1biBaaHUgd3JvdGU6DQo+
ID4+PiBJIGFsc28gaW1wbGVtZW50ZWQgYSB3b3JrcXVldWUgZm9yIHJ4ZS4gSU1PLCBjYW4gd2Ug
YWRkIGEgdmFyaWFibGUgdG8NCj4gPj4+IGRlY2lkZSB0byB1c2UgdGFza2xldCBvciB3b3JrcXVl
dWU/DQo+ID4+Pg0KPiA+Pj4gSWYgdXNlciBwcmVmZXIgdXNpbmcgdGFza2xldCwgaGUgY2FuIHNl
dCB0aGUgdmFyaWFibGUgdG8gdXNlDQo+ID4+PiB0YXNrbGV0LiBBbmQgdGhlIGRlZmF1bHQgaXMg
dGFza2xldC4gU2V0IHRoZSB2YXJpYWJsZSB0byBhbm90aGVyDQo+ID4+PiB2YWx1ZSB0byB1c2Ug
d29ya3F1ZXVlLg0KPiA+DQo+ID4gVGhhdCdzIGFuIGludGVyZXN0aW5nIGlkZWEsIGJ1dCBJIGFt
IG5vdCBzdXJlIGhvdyB1c2VycyBzcGVjaWZ5IGl0Lg0KPiA+IElJUkMsIHRhc2tsZXRzIGFyZSBn
ZW5lcmF0ZWQgd2hlbiByZG1hIGxpbmsgaXMgYWRkZWQsIHR5cGljYWxseSBieQ0KPiA+IGV4ZWN1
dGluZyAnIHJkbWEgbGluayBhZGQnIGNvbW1hbmQuIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIGFkZA0K
PiA+IGFuIGRldmljZSBzcGVjaWZpYyBvcHRpb24gdG8gdGhlIHV0aWxpdHkoaXByb3V0ZTIvcmRt
YSkuDQo+ID4NCj4gPj4NCj4gPj4gSSdtIGluIGZhdm9yIG9mIHJlbW92aW5nIGFsbCB1c2VzIG9m
IHRoZSB0YXNrbGV0IG1lY2hhbmlzbSBiZWNhdXNlIG9mDQo+ID4+IHRoZSBkaXNhZHZhbnRhZ2Vz
IG9mIHRoYXQgbWVjaGFuaXNtLiBTZWUgYWxzbzoNCj4gPj4gKiAiRWxpbWluYXRpbmcgdGFza2xl
dHMiIChodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvMjM5NjMzLykuDQo+ID4+ICogIk1vZGVybml6
aW5nIHRoZSB0YXNrbGV0IEFQSSIgKGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy84MzA5NjQvKS4N
Cj4gPj4gKiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yJ3Mgb3BpbmlvbiBhYm91dCB0YXNrbGV0
cw0KPiA+PiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1l2b3ZmWE1KUUFVQnN2QlpAbGlu
dXRyb25peC5kZS8pLg0KPiA+DQo+ID4gSSBhbSBhbHNvIGluIGZhdm9yIG9mIHVzaW5nIHdvcmtx
dWV1ZXMgYWxvbmUgbm90IG9ubHkgYmVjYXVzZSBvZiB0aGUNCj4gPiBkaXNhZHZhbnRhZ2VzIGFi
b3ZlIGJ1dCBhbHNvIHRvIGF2b2lkIGNvbXBsZXhpdHkuIEkgd291bGQgbGlrZSB0byBrbm93DQo+
ID4gaWYgdGhlcmUgaXMgYW55Ym9keSB3aG8gd2lsbCBib3RoZXJlZCBieSB0aGUgY2hhbmdlIGVz
cGVjaWFsbHkgaW4gdGVybXMNCj4gPiBvZiBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IFRoYW5rcywN
Cj4gPiBEYWlzdWtlDQo+ID4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBCYXJ0Lg0K
PiA+DQo+IA0KPiBUaGUgSFBFIHBhdGNoIHNldCBmb3Igd29yayBxdWV1ZXMgKEkgc2hvdWxkIHNl
bmQgaXQgaW4pIGtlcHQgdGhlIGFiaWxpdHkgdG8gcnVuIHRhc2tsZXRzIG9yIHdvcmsgcXVldWVz
Lg0KPiBUaGUgcmVhc29uIHdhcyB0aGF0IHRoZSBjaGFuZ2Ugd2FzIG1vdGl2YXRlZCBieSBhIGJl
bmNobWFya2luZyBleGVyY2lzZSBhbmQgd2UgZm91bmQgdGhhdCB0aGUgcGVyZm9ybWFuY2UNCj4g
b2YgdGFza2xldHMgd2FzIG5vdGljZWFibHkgYmV0dGVyIGZvciBvbmUgSU8gc3RyZWFtIGJ1dCBm
b3IgMiBvciBtb3JlIElPIHN0cmVhbXMgd29yayBxdWV1ZXMgd2VyZSBiZXR0ZXIgYmVjYXVzZSB3
ZQ0KPiBjb3VsZCBwbGFjZSB0aGUgd29yayBvbiBzZXBhcmF0ZSBjcHVzLiBUYXNrbGV0cyBoYXZl
IGEgdGVuZGVuY3kgdG8gYnVuY2ggdXAgb24gdGhlIHNhbWUgY3B1LiBJIGFtIGludGVyZXN0ZWQg
aW4NCj4gaG93IE1hdHN1ZGEgZ290IGJldHRlci9zYW1lIHBlcmZvcm1hbmNlIGZvciB3b3JrIHF1
ZXVlcy4NCg0KQXMgZmFyIGFzIEkgbWVhc3VyZWQgdGhlIGJhbmR3aWR0aCB1c2luZyBpYl9zZW5k
X2J3IGNvbW1hbmQsIHRoZSBwZXJmb3JtYW5jZQ0Kd2FzIGJldHRlciB3aXRoIHdvcmtxdWV1ZXMu
IFRoZXJlIHNlZW0gdG8gYmUgbXVsdGlwbGUgZmFjdG9ycyB0aGF0IGFmZmVjdA0KdGhlIHJlc3Vs
dC4gRm9yIGV4YW1wbGUsIHdpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHJ4ZV9yZXNw
b25kZXIoKSBjYW4NCnNvbWV0aW1lcyBiZSBjYWxsZWQgZnJvbSBzb2Z0aXJxKE5FVF9SWF9TT0ZU
SVJRKSBjb250ZXh0IGRpcmVjdGx5LiBJIGNoYW5nZWQNCnJ4ZV9yZXNwX3F1ZXVlX3BrdCgpIHRv
IGFsd2F5cyBzY2hlZHVsZSB0aGUgcmVzcG9uZGVyIGZvciBhbGwgaW5jb21pbmcgDQpyZXF1ZXN0
cy4gVGhpcyBtYXkgaGF2ZSBsZWQgdG8gYmV0dGVyIHV0aWxpemF0aW9uIG9mIG11bHRpcGxlIHBy
b2Nlc3NvcnMgYmVjYXVzZQ0Kc29mdGlycSBjb2RlIGFuZCByZXNwb25kZXIgY29kZSBhcmUgbW9y
ZSBsaWtlbHkgdG8gcnVuIGNvbmN1cnJlbnRseSBvbiBkaWZmZXJlbnQNCmNvcmVzIGluIHRoaXMg
Y2FzZS4gVGFza2xldHMgYXJlIGxpa2VseSB0byBydW4gb24gdGhlIHNhbWUgY29yZSBhcyBzb2Z0
aXJxIGNvZGUNCmJlY2F1c2UgVEFTS0xFVF9TT0ZUSVJRIGlzIHByb2Nlc3NlZCBsYXRlciB0aGFu
IE5FVF9SWF9TT0ZUSVJRIGluIF9fZG9fc29mdGlycSgpLg0KDQpUaGF0IGJlaW5nIHNhaWQsIEkg
dGhpbmsgaXQgaXMgYWxzbyB0cnVlIHRoYXQgdGhlIHBlcmZvcm1hbmNlIG9mIHRhc2tsZXRzIGNh
biBiZQ0Kc3VwZXJpb3IgdG8gdGhhdCBvZiB3b3JrcXVldWVzIGluIHNvbWUgc2l0dWF0aW9ucy4g
V2hlbiBJIG1lYXN1cmVkIHRoZSBiYW5kd2lkdGgNCm9mIFJETUEgUmVhZCB1c2luZyBpYl9yZWFk
X2J3IGNvbW1hbmQsIGl0IHdhcyBiZXR0ZXIgd2l0aCB0YXNrbGV0cy4gQWRkaXRpb25hbGx5LA0K
dGhlIGxhdGVuY3kgaXMgZ2VuZXJhbGx5IGFyb3VuZCA0MCUgaGlnaGVyIHdpdGggd29ya3F1ZXVl
cywgc28gaXQgaXMgcG9zc2libGUgc29tZQ0Ka2luZHMgb2Ygd29ya2xvYWRzIGRvIG5vdCBiZW5l
Zml0IGZyb20gdXNpbmcgd29ya3F1ZXVlcy4NCg0KSSB0aGVyZWZvcmUgdGhpbmsgd2UgbWF5IHBy
ZXNlcnZlIHRhc2tsZXRzIHRob3VnaCB0aGVyZSBhcmUgZGlzYWR2YW50YWdlcyBzdWdnZXN0ZWQN
CmJ5IEJhcnQuIFdoaWxlIEkgaGF2ZSBubyBvYmplY3Rpb24gdG8gcmVtb3ZpbmcgdGFza2xldHMg
dG90YWxseSwgSSBhbSBpbiBmYXZvdXIgb2YNCllhbmp1bidzIHN1Z2dlc3Rpb24gb2Ygc3dpdGNo
aW5nIGJldHdlZW4gdGFza2xldHMgYW5kIHdvcmtxdWV1ZXMgdXNpbmcgc3lzY3RsDQpwYXJhbWV0
ZXIuIEkgd291bGQgbGlrZSB0byBoZWFyIHdoYXQgeW91IGd1eXMgdGhpbmsgYWJvdXQgdGhpcy4N
Cg0KSSB3b3VsZCBhbHNvIGxpa2UgdG8ga25vdyB3aGVuIEJvYiBpcyBnb2luZyB0byBwb3N0IHRo
ZSBwYXRjaHNldC4gQm90aCBvZiB1cyBuZWVkIHRvIHVzZQ0Kd29ya3F1ZXVlcywgYnV0IGFsbG93
aW5nIHNsZWVwIGZvciBPRFAgYW5kIGltcHJvdmluZyBwZXJmb3JtYW5jZSBmb3IgbXVsdGlwbGV4
IElPDQpzdHJlYW1zIGFyZSBkaWZmZXJlbnQgbWF0dGVycy4gSSBzdXBwb3NlIGl0IHdpbGwgYmUg
ZWFzaWVyIHRvIG1ha2UgdGhlIGNoYW5nZXMgb25lIGJ5IG9uZS4NCklmIHlvdSBuZWVkIHNvbWUg
bW9yZSB0aW1lIHRvIHBvc3QgaXQsIEkgc3VnZ2VzdCB3ZSBwcm9jZWVkIHdpdGggWWFuanVuJ3Mg
aWRlYSBmb3Igbm93Lg0KVGhhdCB3aWxsIHByZXNlcnZlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24g
b2YgdGFza2xldHMsIHNvIGl0IHdvdWxkIGJlIG5vdCBoYXJkIHRvIGFkZCB5b3VyDQpjaGFuZ2Ug
b250byBpdC4gQ291bGQgeW91IGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHM/DQoNCg0KUmVnYXJk
cywNCkRhaXN1a2UgTWF0c3VkYQ0KDQoNCj4gDQo+IEJvYg0K
