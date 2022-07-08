Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56CD56B052
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 04:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiGHB76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 21:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiGHB75 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 21:59:57 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273E73900
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657245596; x=1688781596;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=JSrqdCwnMeyQEhpHGqivjvORCmY6tn00HNcqbBOVLIo=;
  b=fdCcyiuDxB3aT17rwtdkjjtuoX+his2taNnwy9+Yz1Bx14gDbPsj7dsq
   nnCo1/gKn1oFeVYfXh5abToYcRPgEZYlg3jZBe/oJArswVvTPJ3jJgZHz
   PreigcQ/s3wp5/Vz2OUAwvmI5W/fbSSip/tL88JZB6N55jOGC+6WfnX8/
   dGdYQhdELqdNoQT3RbwFr93ET84+rImqsXsrg+n5i+kkdeMpRTy9FN6zS
   o1/EiWWb1BD2ELd9A+yJ87YH6L6TuWIoXmRXPxYGGPiDESgQWeMVRPP+J
   b8PUPhT2QBl4KnDJeontgqUXEBXCNjMw8b/4+kmUfDuXceZk7Pwy/DaNe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59901855"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59901855"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:59:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV8/PzcTOwBMn6PBQjebnwNP3xSINsaOD1nrAUhY2X2pdsPW8sOu0eNk1dw4i3BN4dBSYzTZkjV4ejqkxZ0XjhDX8HYLEy4RwpJrcM6xQMlwE84ckK4EBF2Hw1VGzBZwKCvn1iNdbVl8Qo1wPcfDClEeBmqMN6uCYSgaRAk8NPwteNQcwuDyNQIMATlFMsvjbbva6TNTir78NCbbfbt3fsotI1TES1g9iDgGpKjSF2UbL/h4NG0x1ybnNujxbnAwNFflJ9HPBUOHokC4KRDruNkCOB18IOijQAM/LR34BmothpnbNoQlQiM3TmFP9PTkOxR9ct/9XAJ/9BLz77dRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSrqdCwnMeyQEhpHGqivjvORCmY6tn00HNcqbBOVLIo=;
 b=U2Eme+tzF7u5n4fK+xrPwgoVb+Cy0zSXTC47dHpZHFHuDf8Jb3YBjvLfByHBZCHrB42lVmL1sVTwF4OotpZWKeXadZEdJ5yOsTBjXP0ccVikzunaY1gYwGFY4i1wc+MbnV8tg4KRzenTKmyv3fKuajc32eAbcFVtnF7fJG/0UT+9+/09Yx3u3pHigUyHjj5/HSRWC8wnEPzyScz+/jmf/gVPizo5clahQIpTmZUbGq7vJnc09Hs1PiTfGrs4+nORF/dotTgHWINH5WNRFDIIVn+y5LEYcr26roo9KZeL10nZVby01xpMkRshClgORJte2+Vs5spqdd5/C5OVB7ohLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSrqdCwnMeyQEhpHGqivjvORCmY6tn00HNcqbBOVLIo=;
 b=h0seIZlSKuipKF3J3up/nzsdQWcnNZszgrd3i/0M3+sKMqDXVwlIgrsUpqwRnS6PCu2vfTVdk5WQLZcnN/ANHdKGy4CMsfrZ0I56CHX42w8ZGbAn9ZPIU8rysTPCcqkqmvD5KRHbyxI31qnJ7Lj3aXTTvtTbDGnQoqpoxZQT8o0=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSBPR01MB1781.jpnprd01.prod.outlook.com (2603:1096:603:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 01:59:50 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 01:59:50 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Topic: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Index: AQHYkmumKN2BRNLSa0Whwv+Wxmj3sa1ztzKA
Date:   Fri, 8 Jul 2022 01:59:50 +0000
Message-ID: <dfb4b44a-41de-3149-1e8c-98c66b603eb5@fujitsu.com>
References: <20220708013934.5022-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220708013934.5022-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 131a817f-2319-4cc2-fb13-08da60858b35
x-ms-traffictypediagnostic: OSBPR01MB1781:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+qXroN9haFvB92zS42nZQ5oQGIvXyfDZK1j9pv/0EdOJ4gVa5hxg11+zq0BC1X/13QzVMUQJ0CJKd0nRxAGDdriOZUNpD1JJmgV5kt4hcGrsXiO58iX5vbI3vWo5a/LzwkODruGFVv8rX8BwPdjUT5sv/fUbWGy7rFzd49NdLy9Ieg//viGZZ1XCi50i/2wK15fiygBckV0+PqTqHXLRWt21aQQrFZ0Zb1U10wVDPNAjZUsewIOTzFpzSZ8PrcjDmCzMcMHlOzSh80XjZcP/GqCe/SxyuKZVRi6x/AlfoOYL2jopRgUwQEwB2nPmOcV3KvWypNiORU/M9EAxPkT6xmsJSYoxkjbuJrQWyT4N63pml8XzJ64PV8jmWnSA0/7/ooHeBLyFPNEnV+VJweQ0tf55gb97U2O5K3ubzMBYVkkf1LcZcMyv6osK2CMpvMgtGm5T8ZYYbtsal4Kgir+gcbeBBpnDKtlCyh2IQ9gjHTi4KcM+WarxNvUrswV22J9qlUrPRYrMhO7M7itGAREwaWQV5+5hFWmPx2pAnqB2BuhH4v4qLAoSdMLny5EZfdGI0tQ4CBuZ9/cCMw8anoLo2XUv5/qiha0CUwecf1M2BGYYvLH1c8X4nIWb1ZKElWFpVa0c4unA/XgxtNreuJvgbb4Ky/h+5SALTGqkxAy8Ki7lfzMPHfcCHGR4lzozLRikYvIkCJA27L33+FncBxP5PpvFngDG5O20K8C8Z3ewwfNQhheBiomDl5QSWaifiZMXcP9Tv5cQ2VJX9jvl+g/6ibId5CIiAn2XA3m10MsOTbKf/8nznVQeNa40EsT+98yjOeg+4uPn17n2/ECHKqYwh183Z/3PlNLBf/7iYxvbVW7kEmQlP+GF0UWjLJ8vAGT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(36756003)(85182001)(186003)(2616005)(38100700002)(31686004)(2906002)(83380400001)(66556008)(5660300002)(71200400001)(6916009)(316002)(26005)(6512007)(53546011)(38070700005)(478600001)(66946007)(76116006)(8936002)(8676002)(122000001)(966005)(6486002)(6506007)(64756008)(66446008)(66476007)(41300700001)(31696002)(91956017)(82960400001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZ4NGNwdmY1bHRWaWF4T3NXbVZMRkdXS0xRcStBVGdOaDVXcFlOaUtGWk5U?=
 =?utf-8?B?K1l3ZXdJVURlejduSmNLWUxVT1BMaGc1OVRPR0VhbmI1Q1IweUVHVHhLVVhk?=
 =?utf-8?B?K0tkN1UvM3FlNml4OVV2d1JrU2R3Z2lMVWJiR1Z5VFRlajhmK3p5MjdjckRX?=
 =?utf-8?B?UWd4Skc3L0dWQnRUN3hzR3lTdXpzOHVlL0sreWd3WDJubmFnQUJWcTlJN1Nk?=
 =?utf-8?B?Zkp6NnNwbWVpcnFMYmFIM3Rmc0tPaG9BWWIrald2bHpjTnJXUlV5MUp2RGFW?=
 =?utf-8?B?eTZkRVhRVDZIdndjaHRMVWJtWEZwMllJdVNodm84RE1VZXE3ckNhN1d4VHJu?=
 =?utf-8?B?dlZIS0ZNQmt5YzdaYi9GMjlpUzNvekhIcW1wU3FNVEVZdmxQNXZWUHozQXNN?=
 =?utf-8?B?Wm5mcFp5dW1TYjNSZmtNeUs0UXpzMGxZbTBZWVNIMzJIQklQYTZWMzk0SndY?=
 =?utf-8?B?K0pYRFVZTEZ6RVREZUlUUHFxWndpc1VnYjVsWndmN2dJYWJ6WDlrdWRzdzR1?=
 =?utf-8?B?VGlYVldyeVdHWDkyeWEvaGQrWHExRDZ4TjNwMDVSeFhSV0F4aTR4R2FoSXI4?=
 =?utf-8?B?eGx5UHdtSUdHVWlYQmNQY2lnQ3JzVU9MNjEzUUZvb2NtNXdCejdqRGw0V1R4?=
 =?utf-8?B?eHlwdCtXRjZxRnp3bUFWaWRGQ0w5WFAweGtnTU1jeDZldWxKd2hiTms2TEZj?=
 =?utf-8?B?OFd5N2tKK2FJTXdLcHJwTWprc2xYUk1pN1V4MGJyajhrYzdrRnhnS2cvTmQy?=
 =?utf-8?B?bGpjVmlXb0hZTmFSQkNQSXdKOVBudmxJU251cDZMMWhwZHZ3dmlpKzZjd1Ez?=
 =?utf-8?B?ZC9NV20xSXVkelA3eFppNUNDL01zZ2U0VGhmZ21GTUtBL0k2MVRBdzB2RStu?=
 =?utf-8?B?QnIwbUFTMGRQTUJtRWVQZU5jZUpzTjRUTVIyanp0NXdsNnYzVUsxUGNMWlhm?=
 =?utf-8?B?YVlnaE1NdUZXekRRRlZlRUJPdnNCNHhZZzMvVjVLL2YyOXU4TWdJYVFpaEtZ?=
 =?utf-8?B?RDJ5SHdVZlhMOUlVTnFTTmZIYnozQzJSZ0JNQ0c3dXZXUk5YdVpweHg5cGJX?=
 =?utf-8?B?WnVkdW9UMjdPSFAxek1hMUcxR3JxbGhOM2NFcEY5cW9vNy9ybEg5Q0RrUFZ3?=
 =?utf-8?B?Q2dUbHh2RXVyQnpjZ2drSWpTS1hyKzVtVS9YVlhUYnF1VHhHSnVEa2ZsQW14?=
 =?utf-8?B?SkNPcDZ6ZnRqRUZabTFQQ3lhZWpJRXdacDhKZUc3UDBVTUZzSmJSeWhNQ2E5?=
 =?utf-8?B?b29zRjRUdXJkTy9KL1E3cThTYTBaT2lZNkZQUEVpeUlQTFBxT3VKTHZJZ1RB?=
 =?utf-8?B?ZWU2dmhZbStxeTdEMTRMZW1ES2pCMFhOaEJYZ2E5Q01pc0JuT3YvVVJqT2p5?=
 =?utf-8?B?bmF2RFhldy9DRXlhWjBTRWdKVHJLckdhSmZ2TXl4SU9pZzJCT0RVRVRLRFph?=
 =?utf-8?B?S1NuSkxCeUNMVk9ERGdqeU5uajFXN2QramlkcU1GaDR3YWpYcWd3SGZ2aWFH?=
 =?utf-8?B?SDdQRG1IMTFRLzV2WitORXpXaTBYZTlsMWFSclI1Nmk1QzVPY3BXNUpER0Iv?=
 =?utf-8?B?UWlnRVFxNXBmMWcvaGl3eEF6S3hNN2lmK3hDbEpCNDZrVWFxWkxBTDRHVVQ2?=
 =?utf-8?B?anJiSGlCZGJydVhtbWRmRFIxQWpCcjhocCt2VFppRXR4T0s4OWFJQTBxTmZp?=
 =?utf-8?B?bHY0VG9aQ1RlQjIxMCsrZHhvVG5Ya2g4RzU1dEt3QThxYUJXL0RUcVFUbU5x?=
 =?utf-8?B?OVpkRGNQMzd5ZjBvWDkwQjRTa2Y2cDdYaGV5QWpaM0JyZGVTWE82cnh4cDNP?=
 =?utf-8?B?NUJ2SnNrUTE3ak93UXF0WFN6QUR1TjJPbVMvODFja2pVZjkvR3BRZ0VadGds?=
 =?utf-8?B?OWRhUThzdFp1Y0VuOUxacEdCeU9kamN2ZDNFdEpKNzh4T3pSNWxGNllGaG8y?=
 =?utf-8?B?bDJrTHVnZDJPL2QwMUVSbjF1UU9sMEdtVGRTVVdQV0J6NEVDNTlGcjlPd2gx?=
 =?utf-8?B?bXE3azNXVFNLSTk0VC9BVFkvRndMTTZDYmtWV0JqeExaMzhwSm83SjRPL1Zq?=
 =?utf-8?B?N0dTSFlrZUJoUXNCVmp1M2pJREp5RzNCaXQ5UFZ6N0pVelFrT0R5WGVDTUpD?=
 =?utf-8?B?MHdEM3FWMVRpdE5tbk1aWlFkWnlURkVzS3NYUGx4eWlKL2VXRjBtZVdZT3FT?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CDB5D4038AB0C4F866858B1284B8DA8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131a817f-2319-4cc2-fb13-08da60858b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 01:59:50.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqp9LCADxzd0toQ79yrpljYc1S8jonJbDeWcugjbspu4ZZrSCGHeS/aKU6FEIHDimFB6z85PADDtPJa3/jpOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1781
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgQWxsLA0KDQpJcyB0aGVyZSBhbnlvbmUgd2hvIGNhbiByZWNlaXZlIG15IG5ldyBwYXRjaGVz
IGZyb20gTGludXggUkRNQSBtYWlsIGxpc3Q/DQpbUEFUQ0hdIFJETUEvcnhlOiBSZW1vdmUgdW51
c2VkIHFwIHBhcmFtZXRlcg0KW1BBVENIIHY1IDAvMl0gUkRNQS9yeGU6IEFkZCBSRE1BIEF0b21p
YyBXcml0ZSBvcGVyYXRpb24NCg0KSSBoYXZlIHNlbnQgdGhlbSB0byBMaW51eCBSRE1BIG1haWwg
bGlzdCBidXQgdGhleSBjYW5ub3QgYmUgc2hvd24gb246DQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1yZG1hLw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCg0KT24gMjAyMi83Lzgg
OTozOSwgWGlhbyBZYW5nIHdyb3RlOg0KPiBUaGUgcXAgcGFyYW1ldGVyIGluIGZyZWVfcmRfYXRv
bWljX3Jlc291cmNlKCkgaGFzIGJlY29tZQ0KPiB1bnVzZWQgc28gcmVtb3ZlIGl0IGRpcmVjdGx5
Lg0KPiANCj4gRml4ZXM6IDE1YWUxMzc1ZWE5MSAoIlJETUEvcnhlOiBGaXggcXAgcmVmZXJlbmNl
IGNvdW50aW5nIGZvciBhdG9taWMgb3BzIikNCj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5
YW5neC5qeUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfbG9jLmggIHwgMiArLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Fw
LmMgICB8IDYgKysrLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5j
IHwgMiArLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xv
Yy5oIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmgNCj4gaW5kZXggMGUwMjJh
ZTFiOGE1Li4zMzYxNjQ4NDNkYjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX2xvYy5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xv
Yy5oDQo+IEBAIC0xNDUsNyArMTQ1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgcmN2X3dxZV9zaXpl
KGludCBtYXhfc2dlKQ0KPiAgIAkJbWF4X3NnZSAqIHNpemVvZihzdHJ1Y3QgaWJfc2dlKTsNCj4g
ICB9DQo+ICAgDQo+IC12b2lkIGZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHN0cnVjdCByeGVfcXAg
KnFwLCBzdHJ1Y3QgcmVzcF9yZXMgKnJlcyk7DQo+ICt2b2lkIGZyZWVfcmRfYXRvbWljX3Jlc291
cmNlKHN0cnVjdCByZXNwX3JlcyAqcmVzKTsNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHZvaWQg
cnhlX2FkdmFuY2VfcmVzcF9yZXNvdXJjZShzdHJ1Y3QgcnhlX3FwICpxcCkNCj4gICB7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jIGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPiBpbmRleCA4MzU1YTViMWNiNjAuLjllY2I5ODE1
MGUwZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jDQo+IEBAIC0xMjAsMTQg
KzEyMCwxNCBAQCBzdGF0aWMgdm9pZCBmcmVlX3JkX2F0b21pY19yZXNvdXJjZXMoc3RydWN0IHJ4
ZV9xcCAqcXApDQo+ICAgCQlmb3IgKGkgPSAwOyBpIDwgcXAtPmF0dHIubWF4X2Rlc3RfcmRfYXRv
bWljOyBpKyspIHsNCj4gICAJCQlzdHJ1Y3QgcmVzcF9yZXMgKnJlcyA9ICZxcC0+cmVzcC5yZXNv
dXJjZXNbaV07DQo+ICAgDQo+IC0JCQlmcmVlX3JkX2F0b21pY19yZXNvdXJjZShxcCwgcmVzKTsN
Cj4gKwkJCWZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHJlcyk7DQo+ICAgCQl9DQo+ICAgCQlrZnJl
ZShxcC0+cmVzcC5yZXNvdXJjZXMpOw0KPiAgIAkJcXAtPnJlc3AucmVzb3VyY2VzID0gTlVMTDsN
Cj4gICAJfQ0KPiAgIH0NCj4gICANCj4gLXZvaWQgZnJlZV9yZF9hdG9taWNfcmVzb3VyY2Uoc3Ry
dWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByZXNwX3JlcyAqcmVzKQ0KPiArdm9pZCBmcmVlX3JkX2F0
b21pY19yZXNvdXJjZShzdHJ1Y3QgcmVzcF9yZXMgKnJlcykNCj4gICB7DQo+ICAgCXJlcy0+dHlw
ZSA9IDA7DQo+ICAgfQ0KPiBAQCAtMTQwLDcgKzE0MCw3IEBAIHN0YXRpYyB2b2lkIGNsZWFudXBf
cmRfYXRvbWljX3Jlc291cmNlcyhzdHJ1Y3QgcnhlX3FwICpxcCkNCj4gICAJaWYgKHFwLT5yZXNw
LnJlc291cmNlcykgew0KPiAgIAkJZm9yIChpID0gMDsgaSA8IHFwLT5hdHRyLm1heF9kZXN0X3Jk
X2F0b21pYzsgaSsrKSB7DQo+ICAgCQkJcmVzID0gJnFwLT5yZXNwLnJlc291cmNlc1tpXTsNCj4g
LQkJCWZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHFwLCByZXMpOw0KPiArCQkJZnJlZV9yZF9hdG9t
aWNfcmVzb3VyY2UocmVzKTsNCj4gICAJCX0NCj4gICAJfQ0KPiAgIH0NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBpbmRleCAyNjVlNDZmZTA1MGYuLjI4MDMzODQ5ZDQwNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBAQCAtNTYyLDcgKzU2
Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgcmVzcF9yZXMgKnJ4ZV9wcmVwYXJlX3JlcyhzdHJ1Y3Qgcnhl
X3FwICpxcCwNCj4gICANCj4gICAJcmVzID0gJnFwLT5yZXNwLnJlc291cmNlc1txcC0+cmVzcC5y
ZXNfaGVhZF07DQo+ICAgCXJ4ZV9hZHZhbmNlX3Jlc3BfcmVzb3VyY2UocXApOw0KPiAtCWZyZWVf
cmRfYXRvbWljX3Jlc291cmNlKHFwLCByZXMpOw0KPiArCWZyZWVfcmRfYXRvbWljX3Jlc291cmNl
KHJlcyk7DQo+ICAgDQo+ICAgCXJlcy0+dHlwZSA9IHR5cGU7DQo+ICAgCXJlcy0+cmVwbGF5ID0g
MDs=
