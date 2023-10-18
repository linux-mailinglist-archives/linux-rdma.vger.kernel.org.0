Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908907CD1AD
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 03:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRBLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjJRBLu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 21:11:50 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D0B6
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697591506; x=1729127506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/CW2B0gPloGI/p7kfIMo70sypB+Z5R/5ky8NjbR0eFY=;
  b=gi19ytwId711Bi/1XJIxlZBZFFn9vBLNVH9xfPsfGxhulfUAPZlXFA1q
   y23pYSJq+mOxp+rZG8t0Kvo6lPOcQ6+zYrRDIa+rvoohouUL8F1E6GP0X
   DsD6ggU9MNhjBRlndNhCzdBRXwV/XGiCF19JPr3xNMUev5YTInG8WTkuk
   Txi023tQvpIgEntrqhQcAHp13mnxIsgrVigeJlQ3vhthxJJsQnFJl1oxq
   q0rv/MCB990THrzjU4Bi22sDrDhKV57FNuvOOiWjbfV2NlzEz1MRmxSH1
   u7YmMtGkIcuqwyCL520h4u+az/fK4526dj42EbhUPm0uqbhbOjS/Okb9Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="99557963"
X-IronPort-AV: E=Sophos;i="6.03,233,1694703600"; 
   d="scan'208";a="99557963"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:11:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWsrPIoXtWWW7EP7/t+Xrsidq5pjrg69n1PWnu0LmvOcYe4tqhlBxMWVNXmsjZt5GmtVp2OKEr+vRPtWRDuRKvHPr2WEk97+HvjPH5dacsKcg0GDyXdAGGVd8fEoiZ5ara5FaPTbwTfjOZqOruOC38oFwDCQd1zn2iTRX+uM4nwdpSxqbcZ2eSw7OXT8kmnKJ3Sn2P4VCDIpZcu7o63xZQY9CqEhx+k3m6oXeUM4aCJxcOa74s8PHEd5bts5jwrhJmUvnZ4QFLJ/20u8MSHe5ilW8ENMTzcP/rC969DmHi/IrG41l4mjO0uYAJSL+00be6X+m3bS8RowQcGeGCg1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CW2B0gPloGI/p7kfIMo70sypB+Z5R/5ky8NjbR0eFY=;
 b=EDuiKsRVpBKtYQH5BwqE8T9zOBKzbL8zZ2Cz5wbv+yBc/KOgWeFUrEzzhZOSRjM+EijkDIPj0+FDnvhO7fRMZu2RX/G8j/EqDrakyDlmv9t6OrEG00MAj/zD0/3PO2bhg2k2nOJ5ZI/AfR6zBJ9T/bFZbXEh2SxET0qGmaVCdDNZ4Qy0ud7uUSBF2KUEginpF6E7P0M7OLJeUEhR5PcRG3lXpQsIGiyMk9RmpoOYCP1bZJieff42jyiT6qTdEdvN4+sFsKYuJTiciTcrI9SH4BDszq8OwEjliTkYUgrJITyACjVDhCDaQwzP1e5MJDAq2yMjPIUvReqFm+58xmR+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OSZPR01MB7796.jpnprd01.prod.outlook.com (2603:1096:604:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 01:11:25 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 01:11:25 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno on
 failure
Thread-Topic: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno on
 failure
Thread-Index: AQHaALwOG9DiWyvgHUuLIo7t+ThLO7BNnvS/gAEfmIA=
Date:   Wed, 18 Oct 2023 01:11:25 +0000
Message-ID: <c6f747e3-7e2a-41de-8ff4-63e00bbf1de8@fujitsu.com>
References: <20231017053738.226069-1-lizhijian@fujitsu.com>
 <874jipd6e2.fsf@pond.sub.org>
In-Reply-To: <874jipd6e2.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OSZPR01MB7796:EE_
x-ms-office365-filtering-correlation-id: ca99edff-c30f-4515-380f-08dbcf772623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UM6fu8kw2IVNcBcqI5DQvjUQ6fzjbI2J6l2PQTop0jeFWQHVFOz7f0KP6KRP5P4YsDRJSaIMb3wk3UOPqXjG0XEPR5UheKmAw7rm9RuCCftRIh3vUav9/V4Cigw9QubrB1eiIA7m8OYJagCUk3zKRWCZZgThtMWVtioYiffoaWMqrwlZOrRHBLqTl1TcrFAd0vwZoYOgv0L9trTl4fDGENsg4K+hnUDG8dP/dbNxhjfZpOgp7s2gK3Q4LlzcN2u5JdU6scSrOk2dNl+tQWryWFwEau9n8q+JSzyQc85hNi4tRewfVj6iLYb71G7KMuU/0RW3fl3quZV6Wd3h7kwhOz22u2J/gEgVskCBeUDKs8QsMulPrcfXjOJhtTv9n3wtelpqXxXw5z7wj6sIbbosRDGAttaedkhNfGvGLror9Do2PK9N7JQbDYFII3+Isq4Ogx5bLAUWCXLZBkb8isK5gm69WKZTYGokwrZxLmvirU+OVkOQuglGIpeF3gfcGNdDlscYMTY/MOdTrWXmp6bc3nB3EnXVCBryWYaHn+8G/wewplUUPWDBVfknpwtTL7zjJXYe2BcF00aRvYMtUSMoTv5OfU44MzDRaO5RDDn/o1hQ+w/U4hDc3+3cRI54BarDcxjHbjMuDAWqsQbzZCUGJCB2uvAnm2wmvS+nROTiCmF9Z9Pu31iwtdB/yQVxK8ECirNvvOeZXnUOFnOdqyPbHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(1590799021)(186009)(1580799018)(26005)(2616005)(71200400001)(6512007)(6506007)(8936002)(53546011)(83380400001)(41300700001)(4326008)(8676002)(5660300002)(2906002)(6486002)(478600001)(6916009)(54906003)(76116006)(316002)(91956017)(66556008)(66446008)(66476007)(64756008)(66946007)(122000001)(82960400001)(38070700005)(38100700002)(86362001)(31696002)(36756003)(85182001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3hWVnprenMxdE41SmdvM3hYajZGU0ZGcXVEcU0xOFhzMHlRdVVBa3IvVWJh?=
 =?utf-8?B?azVxNEVTbFZXOHNEYURBT3grdVRsdlR6ZklFSXR5Yy9iQjhXMkd3RmRGUmkz?=
 =?utf-8?B?MGN2RkJ3c2FHQitzVysyQUxteVhHVkxnU29zUUJqdTFIL1poZk90WnpSVTk2?=
 =?utf-8?B?VjFtT1ZKMUVPOHp2Vkc2TmVGSDhTQWlFbmZueU9ZL3VBVitpL01Qelg0V2V4?=
 =?utf-8?B?OWEyY0J3bnJRWXM4ZU8zTGVlN3RJRnE5aXBrYUpBZVNmdThNTWNtekdKN2hq?=
 =?utf-8?B?TGphWktMOU4yUlhUcTAyZUFadXBPczBNc0hlVStkd2srcGUvMDhrck1sZzdZ?=
 =?utf-8?B?ZGE3QmZOdXpJN2VJUmZjbDYrQVdIUkpQc01DNi9JOGZpcUFQM1NjUTBVRmIx?=
 =?utf-8?B?Y0JJTUc3Y3VmYWVkb3ZuYUllZjdiSWZnNm5PMjUxWHZJOXJLMmdlc0tXWUcy?=
 =?utf-8?B?N1d4RDhyMS9wSmVYQUhoUmgycDZlQmRCTmUvTGl5c1hSaFd2dUxmTzdKV3hR?=
 =?utf-8?B?Snhqb0lndE5hY082TFp2L0dOV3FCWHllQjEyN2FndHNDcjlldDk1R01BYkFF?=
 =?utf-8?B?WmU5aVQxcWRXMElpTlVJZG1RbWQvTkVuOFZ6eTIzSE52NTBOUW41RTQ4UGhm?=
 =?utf-8?B?ZmMwYW96bFZkZFlRYzFxUk5IZm9rWEc3d0xZN2tBSVBIcjZ3cFdST3hsbjdM?=
 =?utf-8?B?b3VIamhNTGptWkhaRXRUZndXU0YvY3J4MmVUMnNWMHg3SWRkZGRsclovTE55?=
 =?utf-8?B?TXY3NG9SWVN4TDUxdFRxVlRwY2dKbnJmQXE4TkpibUZyZUhaMVBTM2lvenk4?=
 =?utf-8?B?ZXMxZXQ0b1lmTXZBNm0rM1ZBa0lSWnBvSXMzY1Q5aFIyTVVDWWZjVmlTRyt4?=
 =?utf-8?B?THFhNlNzNnh1SFNVMjFTWEJzc0N1MXVFakZzaHg0TlQycHY1V0ZWbFJpbW4v?=
 =?utf-8?B?WE4vUDJrdERyNWVlVVFYaS9SVUttM0k1WC9rMk56cTc2dkpsZnNUUjA4L3JO?=
 =?utf-8?B?K1haK0hpT3JaMS9EdDNSdk4xRzdhM29DVDNnUGM3SGtHd3NXRWFPa2xvcVli?=
 =?utf-8?B?UlpYaVBtcy80QWtlcWxHREQvZ3VaOVJKaWxLcVNkSlM4RG10T2ViMzY1bnpH?=
 =?utf-8?B?M2UvaFZ1QVpaYTNBZVZmUjBzQkFleWROZ3Y4NjZneDh5d2tsVStvT0lUb0J6?=
 =?utf-8?B?dlNxUm5UMHVCM0k0V3l3djZBWjkxdXA0SHZFeTZrN2pTNENlMWI0S1hRbm9t?=
 =?utf-8?B?a25LaWNFVXVZSWYvWForSm9GSGtaNUpzWVBQYkRQVzJFalpXWUU2VVZMT2Iy?=
 =?utf-8?B?MGF5SUN2a29JaDBEQ1Jtcy8yUDV1emxlWDdVOE9DSE1IcjZ1UEtUblRnSSt5?=
 =?utf-8?B?Z1pGS3FaZFZ3VnlFMlYycW9VSFRKZ0tGZ3pPS1R4dkFGTXJuUkJlZ3lKVHJ5?=
 =?utf-8?B?QnIxMTJLcmpRa2hrYURwaThDalRlbitHTnpEeG9VNDVaUWVkUnQ4VTJSZzA0?=
 =?utf-8?B?UWJwdm9Oci9OMUNPSVpQN0lNekh4Sk44TTZTVUNsUHE1SWoyQXpseSs5QVYz?=
 =?utf-8?B?OG1lSWZNYkRvVk8vR0RlVHdydGgrYndCUE84bzNQYVRHWFhEYURSc2R1RGpC?=
 =?utf-8?B?OCtDVk93UXdhczM0Yy9vNFBLdEVuQTJkL0NzNVNMRTdrTE9tanZqMDh5WTh0?=
 =?utf-8?B?eklrSm5nUUg5U0RETDRJc0lRNXdhajFua0NGMTRqM3d2bnZPeGhFRVZ6TktK?=
 =?utf-8?B?Mkg5cWdsZFp3eW1DNHVXQjNhV3kwT1E0Q0lxRG1KRHRQaG9EaDNPSi9IYnJy?=
 =?utf-8?B?OWFSUFZDTVZjU3NYNUpmVW1HZmVYTG8vRjB2a1hMQzl6ejVPVVpLdGFkdG9U?=
 =?utf-8?B?dC83bEhpaXd6TUpBdkx3UnhKS1ZQWWQwTW84akpodzNSSTBlVW1JZDk1VmNJ?=
 =?utf-8?B?QS9mc2txMDl3dlc1R3JNVmxneWMvbGNJaDNMbFI0alhpT1hiempMM0N1V2Zu?=
 =?utf-8?B?MExRRS9NYmkxZ3BlZ3Y5SVpwbGxnZHpxSE5HTmtPdlhvSC9OMFFaL0dUWkRB?=
 =?utf-8?B?YzhaMUJnakpveEhFMVpJTDFxcU05YTdPbVU4YWYvL2pVVHgwQjJvNnZaNUp4?=
 =?utf-8?B?dk1FU3lqcWtBRnhsd2l2RGVtaG9BV1ZtcEY4ZTR3MGowV1hJUkhDN2xUUVVt?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D81DDDA095EA74CAD6CE9DEE9861CB3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LqH5ViQ1cTuX5trI7TnuFc6ubMxteQKVESSffaEyIEYDSOpdTZ34wLvQBvYsaEbBWdHtwYCZP3ICzD0l83HGf8LoRQqyLG9dLq8g5STiaaM+djNOfhhTJiEr+NKLzsTNwvi5WzYeEuSd0UOp3PSnVy/HyjpBMBs/I32unmWnPdPwn1dibmeZuUrBCWpASX3Jckdu5+e9zNSfbeiInUCvHED9oP8vNGTJpRb+MT8K+io0yUvrLHjIG6sTRefA3f30iMuEYMXCm8pLdX33p8awW9B0DSb7dc+GoyGHJVNm1Ujil1yq0cvAKoEIxMP18MaehxNBIX445H9yG1qHy1hIftH/slUbLcF3wJNy0GC02fIBigfexOPuaOcF4UbvJYy3F/e4kdFsC/IAM5vBRSOftx5U48FT3s03SS+6EbKsVfDQ+++cYqlIyKnbLwvyEbt3FO+VmH7vqrrM9AsBQFwbPX2q1mB6KsDVtLplEPZG7WBugc1PZPtaE8BrEueVPBp9DpsxgaNpWtT662h/m+w046Ot5r+0aTAmt8KitXSsYJZIOIpkupQf1QOgb9+WlAhMOEY0FGpbbDAiAbn98uzLQe0kEktsh5nRT17hBVqdCbWxHVnXf1KhWB2tIEz9Lqtso44LctuUQmnsBBjHsE4mUO+OMn7K9VcAyxJJHXNGDCisCjSi46KNX+OM/S3rAE2ezDO5GNvJ8EKHQEsKytDVM1alPpeEWEuj+R8jOwdHxlKCmiCVr8rv/IFh/iLx+CVy+jIXdzHEx2xT2CMGhGIhkzEBQNw7mokxibrfS29BpZ+4rNZ7FzjP2dz1RHPvrP2ro3G6yGMcHi2eqVLpSgbbog==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99edff-c30f-4515-380f-08dbcf772623
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 01:11:25.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgPz9PigZ53CX3sLUi7YPVWjM5UXLchVGSkwvrEVCZSt79S7yao+TNedPNH2hfHwOUtRHf2LUQbm6k+/ZVFrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE3LzEwLzIwMjMgMTY6MDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiAnZXJybm8nIGlz
IGJlaW5nIHdpZGVseSB1c2VkIGJ5IGFwcGxpY2F0aW9ucyB3aGVuIGlidl9yZWdfbXIgcmV0dXJu
cyBOVUxMLg0KPj4gVGhleSBhbGwgYmVsaWV2ZSBlcnJubyBpbmRpY2F0ZXMgdGhlIGVycm9yIG9u
IGZhaWx1cmUsIHNvIGxldCdzIGRvY3VtZW50DQo+PiBpdCBleHBsaWNpdGx5Lg0KPiANCj4gU2lt
aWxhciBpc3N1ZSB3aXRoIGlidl9vcGVuX2RldmljZSgpIC4gIFBvc3NpYmx5IG1vcmUuDQoNCllv
dSBhcmUgcmlnaHQsIGlidl9vcGVuX2RldmljZSgpJ3MgY2FsbCBjaGFpbnMgYXJlIG1vcmUgY29t
cGxpY2F0ZWQsDQpJIGhhdmUgbm90IGZpZ3VyZWQgb3V0IGlmIGl0IG91Z2h0IHRvIHNldCBlcnJu
byB0aG91Z2ggUUVNVSByZWxpZXMgb24gaXQuDQoNCg0KDQo+IA0KPj4gUmVwb3J0ZWQtYnk6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBsaWJpYnZlcmJz
L21hbi9pYnZfcmVnX21yLjMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9saWJpYnZlcmJzL21hbi9p
YnZfcmVnX21yLjMgYi9saWJpYnZlcmJzL21hbi9pYnZfcmVnX21yLjMNCj4+IGluZGV4IDhmMzIz
ODkxLi5kNDM3OTljNSAxMDA2NDQNCj4+IC0tLSBhL2xpYmlidmVyYnMvbWFuL2lidl9yZWdfbXIu
Mw0KPj4gKysrIGIvbGliaWJ2ZXJicy9tYW4vaWJ2X3JlZ19tci4zDQo+PiBAQCAtMTAzLDcgKzEw
Myw3IEBAIGRlcmVnaXN0ZXJzIHRoZSBNUg0KPj4gICAuSSBtclxmUi4NCj4+ICAgLlNIICJSRVRV
Uk4gVkFMVUUiDQo+PiAgIC5CIGlidl9yZWdfbXIoKSAvIGlidl9yZWdfbXJfaW92YSgpIC8gaWJ2
X3JlZ19kbWFidWZfbXIoKQ0KPj4gLXJldHVybnMgYSBwb2ludGVyIHRvIHRoZSByZWdpc3RlcmVk
IE1SLCBvciBOVUxMIGlmIHRoZSByZXF1ZXN0IGZhaWxzLg0KPj4gK3JldHVybnMgYSBwb2ludGVy
IHRvIHRoZSByZWdpc3RlcmVkIE1SLCBvciBOVUxMIGlmIHRoZSByZXF1ZXN0IGZhaWxzIChhbmQg
c2V0cyBlcnJubyB0byBpbmRpY2F0ZSB0aGUgZmFpbHVyZSByZWFzb24pLg0KPj4gICBUaGUgbG9j
YWwga2V5IChcZkJMX0tleVxmUikgZmllbGQNCj4+ICAgLkIgbGtleQ0KPj4gICBpcyB1c2VkIGFz
IHRoZSBsa2V5IGZpZWxkIG9mIHN0cnVjdCBpYnZfc2dlIHdoZW4gcG9zdGluZyBidWZmZXJzIHdp
dGgNCj4gDQo+IFdlIHNob3VsZCBkb3VibGUtY2hlY2sgZXJybm8gaXMgc2V0IG9uIGFsbCBmYWls
dXJlcy4gIEkgZG91YnQgaXQgaXMuDQo+IA0KPiBpYnZfcmVnX21yKCkgaXMgYSBtYWNybzoNCj4g
DQo+ICAgICAgI2RlZmluZSBpYnZfcmVnX21yKHBkLCBhZGRyLCBsZW5ndGgsIGFjY2VzcykgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgICAgIF9faWJ2X3Jl
Z19tcihwZCwgYWRkciwgbGVuZ3RoLCBhY2Nlc3MsICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fYnVpbHRpbl9jb25zdGFudF9w
KAkJCQkgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChpbnQp
KGFjY2VzcykgJiBJQlZfQUNDRVNTX09QVElPTkFMX1JBTkdFKSA9PSAwKSkNCj4gDQo+IF9faWJ2
X3JlZ19tcigpIG1heSBjYWxsIGlidl9yZWdfbXJfaW92YTIoKToNCj4gDQo+ICAgICAgX19hdHRy
aWJ1dGVfXygoX19hbHdheXNfaW5saW5lX18pKSBzdGF0aWMgaW5saW5lIHN0cnVjdCBpYnZfbXIg
Kg0KPiAgICAgIF9faWJ2X3JlZ19tcihzdHJ1Y3QgaWJ2X3BkICpwZCwgdm9pZCAqYWRkciwgc2l6
ZV90IGxlbmd0aCwgdW5zaWduZWQgaW50IGFjY2VzcywNCj4gICAgICAgICAgICAgICAgICAgaW50
IGlzX2FjY2Vzc19jb25zdCkNCj4gICAgICB7DQo+ICAgICAgICAgICAgICBpZiAoaXNfYWNjZXNz
X2NvbnN0ICYmIChhY2Nlc3MgJiBJQlZfQUNDRVNTX09QVElPTkFMX1JBTkdFKSA9PSAwKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gaWJ2X3JlZ19tcihwZCwgYWRkciwgbGVuZ3RoLCAo
aW50KWFjY2Vzcyk7DQo+ICAgICAgICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBpYnZfcmVnX21yX2lvdmEyKHBkLCBhZGRyLCBsZW5ndGgsICh1aW50cHRyX3QpYWRk
ciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWNjZXNz
KTsNCj4gICAgICB9DQo+IA0KPiBpYnZfcmVnX21yX2lvdmEyKCkgZG9lc24ndCBzZWVtIHRvIHNl
dCBlcnJubyBhdCAtLS0+Og0KPiANCj4gICAgICBzdHJ1Y3QgaWJ2X21yICppYnZfcmVnX21yX2lv
dmEyKHN0cnVjdCBpYnZfcGQgKnBkLCB2b2lkICphZGRyLCBzaXplX3QgbGVuZ3RoLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgaW92YSwgdW5zaWduZWQg
aW50IGFjY2VzcykNCj4gICAgICB7DQo+ICAgICAgICAgICAgICBzdHJ1Y3QgdmVyYnNfZGV2aWNl
ICpkZXZpY2UgPSB2ZXJic19nZXRfZGV2aWNlKHBkLT5jb250ZXh0LT5kZXZpY2UpOw0KPiAgICAg
ICAgICAgICAgYm9vbCBvZHBfbXIgPSBhY2Nlc3MgJiBJQlZfQUNDRVNTX09OX0RFTUFORDsNCj4g
ICAgICAgICAgICAgIHN0cnVjdCBpYnZfbXIgKm1yOw0KPiANCj4gICAgICAgICAgICAgIGlmICgh
KGRldmljZS0+Y29yZV9zdXBwb3J0ICYgSUJfVVZFUkJTX0NPUkVfU1VQUE9SVF9PUFRJT05BTF9N
Ul9BQ0NFU1MpKQ0KPiAgICAgICAgICAgICAgICAgICAgICBhY2Nlc3MgJj0gfklCVl9BQ0NFU1Nf
T1BUSU9OQUxfUkFOR0U7DQo+IA0KPiAgICAgICAgICAgICAgaWYgKCFvZHBfbXIgJiYgaWJ2X2Rv
bnRmb3JrX3JhbmdlKGFkZHIsIGxlbmd0aCkpDQo+IC0tLT4gICAgICAgICAgICAgICAgcmV0dXJu
IE5VTEw7DQoNCg0KSXQgc2VlbXMgdGhhdA0KaWJ2X2RvbnRmb3JrX3JhbmdlKCkgYXJlIG1pc3Np
bmcgdG8gc2V0IGVycm5vIHdoZW4NCi0gZ2V0X3N0YXJ0X25vZGUoKSBmYWlscyAvLyBFTk9NRU4g
b25seQ0KLSBkb19tYWR2aXNlKCkgZmFpbHMgYW5kICdyb2xsaW5nX2JhY2sgPSAxJywgc2luY2Ug
dGhpcyBjb25kaXRpb24gd2lsbCAnZ290byBhZ2FpbicNCiAgIHdlIG1heSBuZWVkIHRvIHNhdmUg
dGhpcyBlcnJubyBiZWZvcmUgJ2dvdG8gYWdhaW4nLCBhbmQgYXNzaWduIGl0IHRvIGVycm5vIGJl
Zm9yZSByZXR1cm4uDQoNCg0KDQoJCQlpZiAocmV0KSB7DQoJCQkJbm9kZSA9IHVuZG9fbm9kZShu
b2RlLCBzdGFydCwgaW5jKTsNCg0KCQkJCWlmIChyb2xsaW5nX2JhY2sgfHwgIW5vZGUpDQoJCQkJ
CWdvdG8gb3V0Ow0KDQoJCQkJLyogbWFkdmlzZSBmYWlsZWQsIHJvbGwgYmFjayBwcmV2aW91cyBj
aGFuZ2VzICovDQoJCQkJcm9sbGluZ19iYWNrID0gMTsNCgkJCQlhZHZpY2UgPSBhZHZpY2UgPT0g
TUFEVl9ET05URk9SSyA/DQoJCQkJCU1BRFZfRE9GT1JLIDogTUFEVl9ET05URk9SSzsNCgkJCQll
bmQgPSBub2RlLT5lbmQ7DQoJCQkJZ290byBhZ2FpbjsNCgkJCX0NCg0KVGhhbmtzDQogIA0KPiAN
Cj4gICAgICAgICAgICAgIG1yID0gZ2V0X29wcyhwZC0+Y29udGV4dCktPnJlZ19tcihwZCwgYWRk
ciwgbGVuZ3RoLCBpb3ZhLCBhY2Nlc3MpOw0KPiAgICAgICAgICAgICAgaWYgKG1yKSB7DQo+ICAg
ICAgICAgICAgICAgICAgICAgIG1yLT5jb250ZXh0ID0gcGQtPmNvbnRleHQ7DQo+ICAgICAgICAg
ICAgICAgICAgICAgIG1yLT5wZCAgICAgID0gcGQ7DQo+ICAgICAgICAgICAgICAgICAgICAgIG1y
LT5hZGRyICAgID0gYWRkcjsNCj4gICAgICAgICAgICAgICAgICAgICAgbXItPmxlbmd0aCAgPSBs
ZW5ndGg7DQo+ICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIW9kcF9tcikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpYnZfZG9mb3JrX3Jh
bmdlKGFkZHIsIGxlbmd0aCk7DQo+ICAgICAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICAgICAg
cmV0dXJuIG1yOw0KPiAgICAgIH0NCj4gDQo+IA0KPiBUaGFua3MhDQo+IA==
