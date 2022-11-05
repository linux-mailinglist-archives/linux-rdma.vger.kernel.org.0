Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB561D929
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Nov 2022 10:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKEJij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Nov 2022 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKEJih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Nov 2022 05:38:37 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Nov 2022 02:38:31 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC691EC
        for <linux-rdma@vger.kernel.org>; Sat,  5 Nov 2022 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667641111; x=1699177111;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0/BH9JIvG6waqFp6fBc1l+wf0C5J9pLmhknSaVhvxRw=;
  b=EFFeOrZ5Uv6HDnwGW6XhvP/6XU+gn+e2918ZlBXrUwNQh3mxiIlRmmB5
   Ve3fap1/RLDjCUxFqr+NfATYIqi3P7I6dn3ACShqVzynno15dDZwB3wW/
   QwF3kOjg7BRJDf2gHcjAYkOelzlcKn4yuwmolsDy+jssZ0dL7IW5l+wGk
   Uhq5n8ZcW0H4pcgzawUCLQWshO8WPfBF2u3gLjQ5W0AUyRVZk6PNW3pyt
   Qfj/F0GkUSuc5DZoYS/c/aEEj1F+xLMsGeuydtc/ZogLveEGtjqwYTyTF
   QIf/MFujGOhhMY0L9ExwUrFhagqAC1mIaIureamGA4Aehzmi4lkOL77xe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="69173863"
X-IronPort-AV: E=Sophos;i="5.96,140,1665414000"; 
   d="scan'208";a="69173863"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 18:37:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc9MqSJyf+mIrqiQYOLSrBVWfxFHdrDIr4vYxcBXQhefYZWM3rwrUAG3Tre3w0WXuay3caqSBKcVc2bBLk/QOBLtIcBOr4wv78/NeUX7Q8YL95NkfNFRT5fYyuB/BZFR+A3EpbBkS2Hu/qE1foxqLS7FOmHwhN3zezQUQc4bFby1jFD2qIa3IFETdO37oEL6PNzTmIbvxAy9NsxIZHf/hm1fkPp57rVkNWuEFP0Qsiqf/SbCu9g2XSJ658EupLPDVRXBs3hIz+8fJhqmjkE711gABz+SaWuOnJiHKGGcMSDsoXPs6f//f+JCUPX+/gFCTHozUBWY6Wp8u3pNzNzTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/BH9JIvG6waqFp6fBc1l+wf0C5J9pLmhknSaVhvxRw=;
 b=ex2UMTouL2lZnTTLZ106yfrdIP11bft57rDvCl3pEpyAZVtKZolX23r8oZymAqUE8rCQKV4k6wIxGbdCQ9K0V04S5BMEZXILtNt2p1XuZZTnDrnKLOcLBuCYdhGIbeFJ+zqToVhDHd6ctiKghQxoPuQNP6XPBjqHD5+T9fnyhlOGQ8PM/5m2dMeqyqDbP9v01iunPHObeIBJrWlMkpgjdid638HIGFMlzj9V+bJ7wyutHXpgWFTHMo1zFFsgMrZkDJwuHS5Dr9QrQvEIO3FO7pnem7FMpyoPLuSgcnjVfTmujZOQ6O3HTXsHoX2jc+1ZXDGeg3PSQH5wOHRo5MOyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB9783.jpnprd01.prod.outlook.com
 (2603:1096:400:20d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sat, 5 Nov
 2022 09:37:19 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5791.024; Sat, 5 Nov 2022
 09:37:19 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Implement packet length validation on responder
Thread-Topic: [PATCH] RDMA/rxe: Implement packet length validation on
 responder
Thread-Index: AQHY6qxhzJTaAv9wEUS9pHBlPlHj9q4wHwqA
Date:   Sat, 5 Nov 2022 09:37:19 +0000
Message-ID: <09db5954-a1e2-e164-edf2-319cb51bb7cd@fujitsu.com>
References: <20221028090438.2685345-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221028090438.2685345-1-matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB9783:EE_
x-ms-office365-filtering-correlation-id: 7fbbde03-1310-482c-a8ce-08dabf11555c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3Ticbpzr3a5zqUN5Moe/jf2zC1WotQA/kAMPfr2ILBeeyFC3CVPCGiRnXDJh/W7FUdzjgwdlee/DaE6drIiFGJMwJ9MHjy51G2CWbHsyRLfxUYmuzeiCBl+ait7L98NpH+0xOgcczzegsXgWwq2G2pIz6PpwUxdFRMuGth/tbUeKwmpnthzBGt3DR2ItyG5IEcwemzUHaq2lTSMYX9pt4q72aaCwgt3CYu2qdFEsO7zscgkUsFGfbLw/vtHbU97HxKmtSPPysAHY/UU5Am+7oswVKi+CxMx3VGaNUbQ+tPaV3A3JagxsgrAvAovQr5ZaiuVdrMmBJwf6QzAiwKkAOFjDNXEFXHjMdNoR1OE9TPAGGrvNJ9wDbIrYb8e6uMiDo0Wa2I0lutTzNtes0BcJj5pCobKM7dKJqH+2gLwzdovDcKAVzIEtg61ebdCvgOe87TaGYUn/3guewxCrXjphX5x/Y6DNKDEwxgRH5k31w/8QuBN2dRhYTpKe4i9gzms6+RisDif6svRTtH3Fmd+rXJCrmWrqcUzzykhYCQq74qfWWFUsfHSbKW7SDaW93EOBwmUllW2OjiH3OG37hVPe/DDt6tSVSEqEiD3bLWRI9MF1XmMdA+u/nd/ZlFRpBn1edd0AOHbZFFE5RgBq2T0R+DDMe1nldOtOF0895rwskkB89sVFq+mldutYKza1oVi8ZxS5iZg270UUdV906G+lVWCf2ZI8i12NyMwefMz9+ofVd5cjp+N8qFPXGvNObUto4WWFxfLVgyvB/OczZC9n0zYrw7CJXHY3oaqBFA0TfwnffLTpd38sbOB2d+Wc5U14EdylfRMKuTsoq3ktUpisnIlCHmwbbu2jGZ8k0QrmLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(1590799012)(38070700005)(31686004)(478600001)(6486002)(71200400001)(82960400001)(38100700002)(122000001)(31696002)(86362001)(26005)(2906002)(6512007)(316002)(8936002)(5660300002)(36756003)(41300700001)(1580799009)(110136005)(66946007)(66476007)(76116006)(66446008)(83380400001)(6506007)(53546011)(85182001)(66556008)(8676002)(2616005)(186003)(64756008)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blBURWFsOU1COVNXemt4ejZMREVCZWtHN2FiaFFYUjZsVnNpcGdYck5PMGZ6?=
 =?utf-8?B?QnFhWFhKTU5SQlNQcVBxbE9ZZWVWTlBKbTkwcy9FQU5HUXcydmhjNzJKR3A3?=
 =?utf-8?B?d0krMFIrcFlPL1YyejB3cjVOaHVtYnF6VS80ZWxvMXJ4eW1XdWlXWmpBRXFH?=
 =?utf-8?B?eHpKMFZEWEN3bWszNVJtd1BIc3RWNmRFK0ZaMTRqKzV3MkIwSFFlRzZnelN5?=
 =?utf-8?B?Q0VyRkxCRExZYTFwTXVybW9VemN4cmpGZy9XRGpXUlJ2M2J4WS9DVUxkbVk2?=
 =?utf-8?B?SUNLOHV4d3UvQ3JUUWdBMG5Ra1pqQlV6OGtnOG5BdDl1YkxjdzlNeGRvVW9T?=
 =?utf-8?B?MUwzYXVUUmkzRWQvT3RyaXFIcm8xU25MOGNFcHpzbFpqaFA1cE5RL01tVURm?=
 =?utf-8?B?T0tCL0xWS0o4TXRvUXV6eWdJNU1hNXpST0VHUVhTQWYxbWhkeGxiTUFYc2pp?=
 =?utf-8?B?c2NSdmxmQXNSUjRjMlNlNS85bnQyTFg0L0prc0xqS0FPUjZEcnorSnVoNEt3?=
 =?utf-8?B?Z3FnREZNWlRhRHd1V0RmWE9QcXJucHBqM1EwOVFnRTkrMzZjbms0MkY2S05r?=
 =?utf-8?B?ZE15djNQQ25zUUQ1TkdrYm1NQ09ObXdkS05Ib204M1cxb2h6ZmIwUEg5aWJv?=
 =?utf-8?B?WWdpcWRaTm9YMVB4S1dZaFE0NnlTTDJzK3ZiRXJrYWZHczBUdVdRUURFUlpJ?=
 =?utf-8?B?MXozZ2tzcTBaZEk1eVdHNk1RaEtmcklZNmJlR1hkSlBMR3hiWlJtSWpEN2NW?=
 =?utf-8?B?UUdkcmhWRnlqWGRLQWJmek82OXpoMEs1azlLYkVoY3UxTk56ZjJ2bTRWbndi?=
 =?utf-8?B?Q3JYY2RST05manI0MzhBaU5IMHdtRGpoNFR1dFNWYktZNlQ2cDRyeWJjL2lB?=
 =?utf-8?B?T0UvTEFFOGNQMWpFNnBlK2MxbEVGVjNtZVp1ako5NUtGWk1GNDFPNHQ5ZXFR?=
 =?utf-8?B?UXZibHo4bWZzTHpTb0l5dTFEaWFKQmkrQ3F4VzlPWjJHMG0wMkdHWGlNOVZR?=
 =?utf-8?B?UkFJaHR2N0ZSc3NTN1didTVrMXlJNzdnMm5LcWprQ1hEaU94YWlQMnRyN3Jz?=
 =?utf-8?B?cDhMZVBxUDVUTWdNSGtOKzFjcWVtVnE1dlZhTU0vbmU2dEwxTFBLN0pxZFBP?=
 =?utf-8?B?TnVKNENuNmFuTUNxN0F3NmlvWWV2OStzZjRFb1VMZ2RDanhTZWMwOHJZVjli?=
 =?utf-8?B?UElxVERVWlNyVS8yTitDVVgxcjRISUdxL250c2EvaUhIU2VaV1hrZTJpOWpH?=
 =?utf-8?B?VmV3RWhkNFNtWlhDM2QybzY2dmNJNW9NNXQveXQ0NGs3YVdJaEV1dmcyaUxB?=
 =?utf-8?B?ZzFyaHZMZUFvYkZkV3NtUEU5V0RPU0VJakVDdnRiL2dXZERXNElnU0dMWngw?=
 =?utf-8?B?NzNyb1JXYmVuL1Q4S3JnVjhHQVdYeHRRaGZkcUlPdnhUY2hpYytWSFhHR0VR?=
 =?utf-8?B?WC9lN1ZKd2tjbWMxd2pYbWs5SFhhNzN2VHlUWXFXa0xyRFRUWjZhOHNaSmFm?=
 =?utf-8?B?SHJTMkZtaG5vYVFKRHNkRkU4QjEzSUNoZ0dMeGZWQldWMDJWOVhlWGhGVnRM?=
 =?utf-8?B?Zk9GTnVKa3JwQ3o4ZFNBM2RqLy93TlpLckxDa1BjZUJzM3FKSUhZMUVQTTd3?=
 =?utf-8?B?Y1lVVm83U1VyYnlQL1g4L2dQdlJuMk94amZ2bHlsNzh4UGVxVmtLS3BELzNq?=
 =?utf-8?B?aVZXaVJ0MzI5Tk50cDdzRXJtRmRTWlljYVhpN1ZNV0xGdFh4UnFVSExxSXdQ?=
 =?utf-8?B?MXpHMGo4QTROQ3ZIYnFYV3hHZjhZcU9wRHVWTlVWL1hZSVU0eEpsLzI5QnBQ?=
 =?utf-8?B?ejkvZlVqZUpDRk9zZGZkVzFycFpwNmsyQzZWcGtwOVl0VkVrZ1FnZkF6dTlQ?=
 =?utf-8?B?MUJpTWc0Y3V0N0dhSEl0Nmw1NUpWZGx5Y0JCTHBObEE2bUZyS3ZXbklUc0dz?=
 =?utf-8?B?eFRHUU9qc0RuM3RLaUhqSWl1bHZ2d25jTkx5TEQ1ZStDYndzTytvRW43WFcy?=
 =?utf-8?B?bVJEUjlIRVYxc1VYVXhTNG15TFNHbGpuNDBqSmlVdTdaZ1NEWFdoNnlGWlJq?=
 =?utf-8?B?Yi9ud2E5UGhFNE1FQUt3V0lQK1VOaXVkTHh3V2hKczN1bG5xYjFxVUdPdmQr?=
 =?utf-8?B?MEwzd1VwM01TcmZGSGN1S2J0d2hRWUw1MlBvMFd1bHhsZ3dZYXphM0VjVnk5?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90D810E7CE70C74AA0EF2E1F666F5962@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbbde03-1310-482c-a8ce-08dabf11555c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 09:37:19.3519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUxwhP7Ywt73gc5qVjRoLkkUbLdUQceCH8SunKo4ELMUUyXmdZ7wgG+QQ3+ejUY7inuU0K0LNVcqFqbKHHE4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9783
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiAyOC8xMC8yMDIyIDE3OjA0LCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+IFRoZSBmdW5j
dGlvbiBjaGVja19sZW5ndGgoKSBpcyBzdXBwb3NlZCB0byBjaGVjayB0aGUgbGVuZ3RoIG9mIGlu
Ym91bmQNCj4gcGFja2V0cyBvbiByZXNwb25kZXIsIGJ1dCBpdCBhY3R1YWxseSBoYXMgYmVlbiBh
IHN0dWIgc2luY2UgdGhlIGRyaXZlciB3YXMNCj4gYm9ybi4gTGV0IGl0IGNoZWNrIHRoZSBwYXls
b2FkIGxlbmd0aCBhbmQgdGhlIERNQSBsZW5ndGguDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhaXN1
a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gRk9SIFJF
VklFV0VSUw0KPiAgICBJIHJlZmVycmVkIHRvIElCIFNwZWNpZmljYXRpb24gVm9sIDEtUmV2aXNp
b24tMS41IHRvIGNyZWF0ZSB0aGlzIHBhdGNoLg0KPiAgICBQbGVhc2Ugc2VlIDkuNy40LjEuNiAo
cGFnZS4zMzApLg0KPg0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8
IDM2ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3Jlc3AuYw0KPiBpbmRleCBlZDVhMDllODY0MTcuLjYyZTNhODE5NTA3MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBAQCAtMzkwLDE2ICszOTAsMzggQEAg
c3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfcmVzb3VyY2Uoc3RydWN0IHJ4ZV9xcCAqcXAs
DQo+ICAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfbGVuZ3RoKHN0cnVjdCByeGVfcXAg
KnFwLA0KPiAgIAkJCQkgICAgIHN0cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4gICB7DQo+IC0J
c3dpdGNoIChxcF90eXBlKHFwKSkgew0KPiAtCWNhc2UgSUJfUVBUX1JDOg0KPiAtCQlyZXR1cm4g
UkVTUFNUX0NIS19SS0VZOw0KPiArCWludCBtdHUgPSBxcC0+bXR1Ow0KPiArCXUzMiBwYXlsb2Fk
ID0gcGF5bG9hZF9zaXplKHBrdCk7DQo+ICsJdTMyIGRtYWxlbiA9IHJldGhfbGVuKHBrdCk7DQo+
ICAgDQo+IC0JY2FzZSBJQl9RUFRfVUM6DQo+IC0JCXJldHVybiBSRVNQU1RfQ0hLX1JLRVk7DQo+
ICsJLyogUm9DRXYyIHBhY2tldHMgZG8gbm90IGhhdmUgTFJILg0KPiArCSAqIExldCdzIHNraXAg
Y2hlY2tpbmcgaXQuDQo+ICsJICovDQo+ICAgDQo+IC0JZGVmYXVsdDoNCj4gLQkJcmV0dXJuIFJF
U1BTVF9DSEtfUktFWTsNCj4gKwlpZiAoKHBrdC0+b3Bjb2RlICYgUlhFX1NUQVJUX01BU0spICYm
DQo+ICsJICAgIChwa3QtPm9wY29kZSAmIFJYRV9FTkRfTUFTSykpIHsNCj4gKwkJLyogIm9ubHki
IHBhY2tldHMgKi8NCj4gKwkJaWYgKHBheWxvYWQgPiBtdHUpDQo+ICsJCQlyZXR1cm4gUkVTUFNU
X0VSUl9MRU5HVEg7DQo+ICsNCj4gKwl9IGVsc2UgaWYgKChwa3QtPm9wY29kZSAmIFJYRV9TVEFS
VF9NQVNLKSB8fA0KPiArCQkgICAocGt0LT5vcGNvZGUgJiBSWEVfTUlERExFX01BU0spKSB7DQo+
ICsJCS8qICJmaXJzdCIgb3IgIm1pZGRsZSIgcGFja2V0cyAqLw0KPiArCQlpZiAocGF5bG9hZCAh
PSBtdHUpDQo+ICsJCQlyZXR1cm4gUkVTUFNUX0VSUl9MRU5HVEg7DQo+ICsNCj4gKwl9IGVsc2Ug
aWYgKHBrdC0+b3Bjb2RlICYgUlhFX0VORF9NQVNLKSB7DQo+ICsJCS8qICJsYXN0IiBwYWNrZXRz
ICovDQo+ICsJCWlmICgocGt0LT5wYXlsZW4gPT0gMCkgfHwgKHBrdC0+cGF5bGVuID4gbXR1KSkN
Cg0KQXMgcGVyIElCQSBzcGVjLCBpIGRpZG4ndCBzZWUgYW55IGRpZmZlcmVuY2UgYWJvdXQgdGhl
ICdwYWNrZXQgcGF5bG9hZCANCmxlbmd0aCcgZnJvbSBvdGhlcnMsDQoNCnNvIE1heSBJIGtub3cg
d2h5IGhlcmUgeW91IGFyZSB1c2luZyAncGt0LT5wYXlsZW4nIGluc3RlYWQgb2YgcGF5bG9hZCA/
DQoNCg0KVGhhbmtzDQoNClpoaWppYW4NCg0KDQoNCj4gKwkJCXJldHVybiBSRVNQU1RfRVJSX0xF
TkdUSDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAocGt0LT5vcGNvZGUgJiAoUlhFX1dSSVRFX01BU0sg
fCBSWEVfUkVBRF9NQVNLKSkgew0KPiArCQlpZiAoZG1hbGVuID4gKDEgPDwgMzEpKQ0KPiArCQkJ
cmV0dXJuIFJFU1BTVF9FUlJfTEVOR1RIOw0KPiAgIAl9DQo+ICsNCj4gKwlyZXR1cm4gUkVTUFNU
X0NIS19SS0VZOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBjaGVj
a19ya2V5KHN0cnVjdCByeGVfcXAgKnFwLA==
