Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F7970944D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjESJ6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjESJ6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 05:58:48 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 02:58:37 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EE107
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1684490318; x=1716026318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hFC7TR36C7fDVxXxPj8pGZz4zKGnGVoOgySDIDCYskY=;
  b=lmvv4EFNq2tliGRoVTWy82ybk24ZYqJqIPOzlhSbcMPhTI3b3gNaaT/Z
   8vQ+141a1qrGLlqQYqtRJ4jYtjMrZXHMCfmZqJc5x0e+SD0ez09LkVwR7
   Jqo/etQce1r0JQb976i9jRyHCY4k9KsO/YSJ8QL4vb/AHGRfWJvY1l042
   845nxITZreZ+Rn6NKAz2H2Y2hwdO1mwpW5F+na1itzZgJi+jtvoXvdpO2
   EbE75TO6akhz/aOMfBlegCGC8o/g387VPwuruFkKjIVW9HR7ZcSXGwm1s
   jojhDNhuLCW4jBCxfaur405VZ3gDpF06UDt1J3pxdyMaIjuoLbFyaXATq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84977847"
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="84977847"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 18:57:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8UNpIdEnsg1Cm6vbdUeN2gLNF2Vavhk1nhH4kH4rY3eldjZXuN11mrCCfc2eHwqGHOeVPI50SCExUU0DbyJ9zy85qM5IbMjoUsWNRWzpwqUDlacjOtBAs0BxGgtLr1TK60wDzlbkJ4Peup+WJA5nOIdXauWamwapGOkjuER7eKC6HbEQCaTGCMPpFOl3f1phqRVa1bajdtvNk1IVkrJj8Gaz8EhErj6sKG0T6uhMWTGHx8sFMZOarcPh8uFMPJ1dlvh2jlQo77ZVUphmiDonEh3PZabKtqaufRYF8pVu82LC44KsNfFJPxAQY/AgDnIcnvRYMteG0AZbmrhcwar2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFC7TR36C7fDVxXxPj8pGZz4zKGnGVoOgySDIDCYskY=;
 b=kxdybyVGSmR7joGqSLP8MNav5UO6FPSCyC4SEWUrlYGkv2Cs4ZPMS6nXx//sZccJleB/j8VZTUqZhxK8/s1wX+Tw002k49sPaVVEcutNW1T74DfAg9BoTWs0U9gv/Z0y+8/W1rClh59WE8LYxcNq5bjEGpW5zodiDTGzxUzSzjVLNCf6QyT5emKlbIHUs+/Zninmbn6vKbplN2Q1kosx6uIza2NDj50XCdpfBuwruCZZZ+Rnu+VVVjpHjZ/3mkffAIT077Ldi9YNAZ0Biqu8jLzsSha9oGVv4pO+cNxyPFxVtKzvFsOuGSAdbvk5Jr9X3IFXaHjqSztrmJFRfPZBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB10244.jpnprd01.prod.outlook.com (2603:1096:400:1ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:57:03 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:57:03 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Guoqing Jiang' <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v5 0/7] On-Demand Paging on SoftRoCE
Thread-Topic: [PATCH for-next v5 0/7] On-Demand Paging on SoftRoCE
Thread-Index: AQHZiWHavU3AIltup0CvWDzSh43W+q9hJysAgAAgoeA=
Date:   Fri, 19 May 2023 09:57:03 +0000
Message-ID: <TYCPR01MB8455648A5C9DFFB37FFB172FE57C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <0f12adcd-0112-3b0e-57b5-ecf707670bc0@linux.dev>
In-Reply-To: <0f12adcd-0112-3b0e-57b5-ecf707670bc0@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMTlUMDk6NTc6?=
 =?utf-8?B?MDJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0xMTU5YTY5My1jMTc3LTRkNTIt?=
 =?utf-8?B?OTAzZi1iNWMzY2QwMGZhNDE7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB10244:EE_
x-ms-office365-filtering-correlation-id: 46c87d45-ddbc-43ae-3f24-08db584f657c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpxWUlsoDTdPR4twD4qasAvBNPgDg85N8wPMV4zTsp5kMlrFIyYr8l9DF2Ht/c2A4KptjE2grJQA8ut1j9/xyrohOlyMwvK7GbkKJue6JScqcVucZx9qYAT5JK1M+k/GlEQIPCRi6QTT4W87F+sZ0IiCMYaBzN1YSzbtH6C3JYi4N+XPpDJY8QRG5CE9Y43PusK/cly4fy7N87CYVHbYAAbEF0E7ABtVSQPLP4///1+qUzcmG9yT4Cl5bgKS/FGfNe/GgNaWPQuGu6E8+h8PS07Tl1K8OWkNL5BqH9fbXtjvDJDIVxllHdnRlTSUWKW4GkmNgRgUFM+nhGtaVoiQg0t/0GLOuxMTOPS+kZ0GI7r9rronF1pZfplDOX2CsrjXqLsQwm0GG3T4PnUiqnqPL6zjVeGS+6vmV4r6bi7Sr69scg609Qz4A/a4gwENAvrKCE561IJc2bi/7yzxCbrgMuAslqnyLSuPTk8NT6yzwwIojTlPskijA5UllwLKuBBn9hw0yCCWxNoSKp8kZ5rjUefXYCZZ7chr8R75ZMOA9dtJ9xsi8wr/NePLd0m3g9xklYWYO1KgeCC9M6rRLNY9zuqQa4HvtZNQUbGz/sbbQylkMi7WDleB+/BNSFK/srvW8833CESWFlikjmp+tcXNsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(1590799018)(66556008)(66446008)(2906002)(64756008)(8676002)(66476007)(52536014)(8936002)(316002)(4326008)(76116006)(66946007)(1580799015)(5660300002)(41300700001)(86362001)(110136005)(478600001)(54906003)(55016003)(966005)(7696005)(85182001)(9686003)(26005)(33656002)(186003)(71200400001)(53546011)(6506007)(83380400001)(107886003)(38070700005)(122000001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUQ4dnRkTE5oMlZDQ0ZmMTlxNXpuS3NiNkZPMm9xaVVHUzIrU29MaG55eXFZ?=
 =?utf-8?B?ZnpKRzBRZkJxNWNhajVOMFE1cjFQTXl5NS96N2NmZ1RBNHhmZlJUS1VLc1Bz?=
 =?utf-8?B?RkZScW5BTkxYMUM5N1g2OXFhMXJsMFBvVjh6QW9rOEN0elZEVWtZRzQxL0Fw?=
 =?utf-8?B?emtjb3VWM1FhcXBZbFFkWUM1VDkzWUxnQXVHRlVPbjBJRnR3UXJuWm5tSE80?=
 =?utf-8?B?RTB5UUtmVnVoOEE2UzRZM2krcXVNUEZDTm9YbFpuTlVyaXMzS0FMKzJGMnRH?=
 =?utf-8?B?a3I1YStXV3JHaFRvaCsvRXJkK0lLclZUd3E3QXBZK25NLzVwM3Q1TzJoTzBE?=
 =?utf-8?B?M0d4M0d6a1BvWk9taXlMQWFFNkxTL1NDTFZrZ1RLL2RuWnF1RGliT1dsRGlK?=
 =?utf-8?B?eURpTXl0TFRXZjkwWFpOaUZGVlQ5UmhSbXJCMjVhM2ZmdVlzODFSaTBVcVFt?=
 =?utf-8?B?ODhORit5cDR4bEZQeUNhUXlqcGkxeFRPanZuNGRjR2VYajlKbWVqelF0Sjc1?=
 =?utf-8?B?eUFtWng5d3Rwc0FBN3RjOUNtSkJ1RW5JVzhxRisyK01POVVCckJiVjg4ZUNy?=
 =?utf-8?B?a2s5eE11UWFjdWl4NmFqdkRFNW1yYXlOZk00VlQxVm5EY0djSXBsZ0xlVHQ2?=
 =?utf-8?B?SWJuT05VUjA3eHMrT1VQWWtRYWJFUEUxT1FnUGRLOTN3SjdzUFhsQXU4Y1Bn?=
 =?utf-8?B?SENsUDNiY3BpU1pTVWY5V1hLNWFudjh0Q2FFWnZSSXhkNTZXRWE1WGVtem5I?=
 =?utf-8?B?OTV6akFYZmIyYm96SE92UU9nYVZWdU1pK3M1LzRlbFVOTzEva010TWZlYzZo?=
 =?utf-8?B?blpQOUgxZTVPODRPUEJMVndURTkvYVZxWnl5ZjFmTVlDODBOeDBuMEkrKzlZ?=
 =?utf-8?B?bHRFekVXZmtDMi9FV05PTForTkkrUlJWdzNtMG9PeFZMWm1HUWNDU2pJMkc3?=
 =?utf-8?B?a3l4bTBXc0tEV1JJN21JbnlCNHB0aUlZbE9YUUZZdnh2cjJrUStTall1WVow?=
 =?utf-8?B?L1NqM21lMDd4Q1NOTTRMMzlvNERVZDBaOXVXU2c3dkZxTWpyNnpsOUhsSWlE?=
 =?utf-8?B?V1ljS2RRZHNreTNUblQ4LzFYdmpMaHBsTUY3LzRxRmJpaUJ4b1FOa0MwajlZ?=
 =?utf-8?B?cGpNNWdXd0ZIWm5ndk1LWEdQb3dJRTZNODh5c0JMVDIwYUpzMzF0NlRKb3pL?=
 =?utf-8?B?THd6dGtqUVBmbjJSaG5PM3M1SHlJTHNndGhWditZN1NscGhUaW1zN1hMazZo?=
 =?utf-8?B?RlBCU3llcUdSN0h1NnV1eFBsQ1BQdDhoK1NGMGhTRHRjOHpDNWYxK3VYRDNv?=
 =?utf-8?B?VTkzbE9sYWxqVk9HaWNhbFNpNG1PWEJWdnZ1bW8xVmg1WmhweDgxclozS0FB?=
 =?utf-8?B?Ujd0U2dIUlJ1dmkwL1FEQmk1aXNrMkxZTVRoajM0SVlUZ0x2U2dBbWNiQnBC?=
 =?utf-8?B?SkJYOGNzVDJINFE4V1JVY2IzWHVaNVVwdnVrbncrNjgvY0FZZTJEMEt6Z3FS?=
 =?utf-8?B?THhzM2YxalpUVGtBM2o2c2tueWNJbXB1MmsxM2NwVWRPVVlRcGFDM2x1NkZE?=
 =?utf-8?B?aHRmR1h6NHUwQmJ1Sis3MnJPK0ZlS3JXanlqSVEwYjk2SlN1bDVqOWExTjNn?=
 =?utf-8?B?L0Z5M1VWOU5FcUttSm9YR2Y1aDdRRCtQOHFsR0p5YTRNQVR1UUxySVVuNUwx?=
 =?utf-8?B?M3gxNXZtYVQvSytVdW1vdnJWVG5KeW5yMzJLN2ZxL082R1R6RThyZFN1UG5o?=
 =?utf-8?B?TlcxZGNqQ2R3TFhsbzhjT3dwalRzV2Z6WXZFSUtoVW9pSWl6MHBhVTBNUVFD?=
 =?utf-8?B?VnZDdHpSUCs5K3dHRGpWZGxlemRKWEFEMmFvcjgrVmhCbEZ6SGtDNkFraTBY?=
 =?utf-8?B?cWJ2ZjdCM0hVZ0RoRjg5bWV4ZTgwTHFIRVUyM1RZbUtqaXN5czFRQnhMZnNK?=
 =?utf-8?B?WlpOUFdMd0trWHZMaGY1MXZCeGVveEpETWZBM2VtUG9rSEZLcUtxU2lTeVdo?=
 =?utf-8?B?TFR0N0ZZNzhMTEhKeXFJQ3ZySjFIK3htMXBaYXIrU29POEoxZDJHVWJPQUxP?=
 =?utf-8?B?UGMyU2QyMllBMG1sUGluZTdkMlVpTTNhWFZMSlRoMk04MmpCMm9YTWVuM2hu?=
 =?utf-8?B?M0pxOVFTMFJYUFduZVJXRnJ0dm5ieUhYRmJ1dFZZMzlxN0lENlBhME1XbWhi?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RZu4sn5vs2HpBfs+x3tqZGaSaNpTPm4DXr5Ru7OsrqrlfzK7rd0weHjFLbb1pBPKwtEt6EDZ+tLKFWMKMFoUFvyxWSIsM7mgxsTmBRdl2VKNtSRyC3r49fsRAySIxQVIERryyRk3uXjyyoJcXygUDnjKUiL43vpxdJyBbLwz+GClpJ7NtCSdUzb4apwauCeVuV9fyuwA4EiKkUnCriJannQgdRb5Jyy/NWEb1vcrIQaealfpyWU97wVkxjD+PA5TLN9/51bJSnvK/rlid27IDuLHGz2YFndUNzKLiVaspKM3NRLlhUzp4+uuBL646aj++nuf/4CTYwgUmcTfeprsc+U+VMye4lfojEnXeQEIveJTtmdKnqTWAFQdHBJmXsIpsIuCcvhdD+4nT6Ps7bPL9QyQxQX6ZEqTfn18wn2HnPYo5JSwkU5AiTo1LeYREN5CQD44u7qmEcc36QkhEyS3TiVGunDYSwAJeAg3RNbX83yY3IVhNvXCS/fmWRNhWLHT7U02oedS/D2W0fmNNorBWJbdMuCQb9B6t7cDzUr0DBdwBh/fCWWNUQXr1BnVBAWB4qjws0adwGlYfodscwuvmBKHLPbAHBc947/xil0j5/k3A0lpGCrsbWOJu66oBCS26Ku/nJPdQBeW6KEsj2BjTBDAhkOqDz3J2TjRR6sgG+9z80QNHGH88OrqzPKQ+Xn0lkT2pPp9r3Urjt9JA7oTfcUARdKnu58E3cPw54aZ3C5hGUKOrdofdappm74GdMCnyWdNRFFtsw4AO72NZa+bI3tE5lR2qCDfhnWq7Hbx4u9vOi89sMmzgajSC7HcMfneB4Qmnk81/6xQqQYr5BWkwcnuVGCjEtCzCxX/mEh5DGU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c87d45-ddbc-43ae-3f24-08db584f657c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:57:03.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dr5yQwiUgEkOsTxrpjjHrCa2Crqgay5zu9ZZQkEWVSG6jdINTGFb1xlt/JRUc0r/heEmL2PqRHpCgZiBYM2lob49SKYtnoO6Q01N28JHtVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10244
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBNYXkgMTksIDIwMjMgMzo0MiBQTSBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiANCj4g
SGVsbG8sDQo+IA0KPiBPbiA1LzE4LzIzIDE2OjIxLCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+
ID4gWzJdIFtQQVRDSCBmb3ItbmV4dCB2MyAwLzddIE9uLURlbWFuZCBQYWdpbmcgb24gU29mdFJv
Q0UNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE2NzE3NzI5MTcuZ2l0
Lm1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbS8NCj4gDQo+IFF1b3RlIGZyb20gYWJvdmUgbGlu
aw0KPiANCj4gIlRoZXJlIGlzIGEgcHJvYmxlbSB0aGF0IGRhdGEgb24gREFYLWVuYWJsZWQgZmls
ZXN5c3RlbSBjYW5ub3QgYmUNCj4gZHVwbGljYXRlZCB3aXRoDQo+IHNvZnR3YXJlIFJBSUQgb3Ig
b3RoZXIgaGFyZHdhcmUgbWV0aG9kcy4iDQo+IA0KPiBDb3VsZCB5b3UgZWxhYm9yYXRlIGEgYml0
IG1vcmUgYWJvdXQgdGhlIHByb2JsZW0gb3IgYW55IGxpbmtzIGFib3V0IGl0Pw0KPiBUaGFuayB5
b3UuDQoNCkkgYW0gbm90IGFuIGV4cGVydCBvZiBQbWVtcywgYnV0IG15IHVuZGVyc3RhbmRpbmcg
aXMgYXMgZm9sbG93czoNCg0KUG1lbSAoUGVyc2lzdGVudCBtZW1vcnkpIGlzIGRldGVjdGVkIGFz
IG1lbW9yeSBkZXZpY2UgZHVyaW5nIGJvb3QgcHJvY2Vzcy4NClBoeXNpY2FsIGFkZHJlc3NlcyBh
cmUgYWxsb2NhdGVkIHRvIHRoZW0ganVzdCBsaWtlIG90aGVyIG1lbW9yeSBpbiBESU1NIHNsb3Rz
LA0Kc28gc3lzdGVtIGhhdmUgdG8gdHJlYXQgdGhlbSBkaWZmZXJlbnRseSBmcm9tIHRyYWRpdGlv
bmFsIHN0b3JhZ2UgZGV2aWNlcyBsaWtlIEhERC9TU0QuDQoNCkl0IG1heSBiZSB0ZWNobmljYWxs
eSBwb3NzaWJsZSB0byBkdXBsaWNhdGUgZGF0YSB1c2luZyBtdWx0aXBsZSBQbWVtcywgYnV0IHRo
ZSBkdXBsaWNhdGlvbg0KaXMgcHJhY3RpY2FsbHkgbm90IHVzZWZ1bC4gRm9yIHRyYWRpdGlvbmFs
IHN0b3JhZ2UgZGV2aWNlcywgeW91IGNhbiBob3QtcmVtb3ZlIGFuZCBob3QtYWRkDQp0aGVtIGVh
c2lseSBvbiBmYWlsdXJlLiBIb3dldmVyLCBQbWVtcyBhcmUgbm90IGF0dGFjaGVkIHRvIGhvdC1w
bHVnZ2FibGUgc2xvdHMuIFlvdSBoYXZlDQp0byBoYWx0IHRoZSBzeXN0ZW0gYW5kIG9wZW4gdGhl
IGNhYmluZXQgdG8gY2hhbmdlIG91dCB0aGUgUG1lbS4gVGhpcyBtZWFucyBhdmFpbGFiaWxpdHkN
Cm9mIHRoZSBzeXN0ZW0gaXMgbm90IGltcHJvdmVkIHdpdGggZGF0YSBkdXBsaWNhdGlvbiBvbiB0
aGUgc2FtZSBob3N0Lg0KDQpEYWlzdWtlDQoNCj4gDQo+IEd1b3FpbmcNCg==
