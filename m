Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB24F8E5A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiDHDlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiDHDla (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 23:41:30 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 20:39:27 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3053FD6
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649389168; x=1680925168;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5pB1K8MNj/GbsBpq6jNVzCSDDX6v4S+s+A0iOwgbp6g=;
  b=cgROC66tR0kXsAFeOLVX3NaRT1d5rhc0fO6WjkYYjHDPaR2BOCGpBifi
   Quzcdeck+3m1ji9z8+jZn4Be2X876+Yy/Oyubqa6gBHgF5Xt+vbvchWkK
   ek2zp1d8iA+Pois4emLWCuzNzD2utH/Q13NWsNBKM6BRJ1a9oSxYDZZ+U
   fe3t0lCuYRJZdZ2YHBcJYKQ4IUSKv1Ksgs4f7O147pz2zOEW5A3BwYA0C
   sfYep5xD61rtgpBYvxam6Wgmqwqo7UO9C5+4ogsksnDtFk1aCcQvlzyX0
   cbzfSiwec8Mqx5eppIHKwlJlnqONxJECkAvK6xaHUzR87sx6o+6wK893S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="61589949"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="61589949"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:38:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7cmPerp/ls8qdZ5qRmM+3h1EGsvNlsUx+kX/qoJ/0PTf5xxuEqP32nok0m3me7vhXM8szjxFFyEyEDnwhweXWLUp8TpYqvJLBRmDnDoHWyeax0DAiIFl/4m3Roh/ubsL6450fycXxY2idinKtDtkjFTWU2CpHz+kgyMesiLqG1EZ53ZXEcYhmbpiU/exPD4LTa2NJphapuZ2PV+5N/7k6YspfBAeJLY7+pLTagFgt0CeuFpxhTNablTOtah1K47s3IX4JBzbqJCUaVYsAPXA+6bw8DdkNMRB/mPRfxFFoFYJ9QyAfl5xT111SoVnEV1ziYIfvfjmBur5HRarZvy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pB1K8MNj/GbsBpq6jNVzCSDDX6v4S+s+A0iOwgbp6g=;
 b=P0K6gMc5LQZ5BLxBaggQEgcUo08wUUgK1VI92g37NZ7gut3bXBrgKoIJIqUt+m3pHVSF/lTcB6k5RUPFSEMthglZjDcWurZjj5Tw3a38Yyp3HKx/JIR0naLGGXlx0oqvfA2fFTcW6+xewWSh111IvESzI8ElbPEHkxCSYACBFucZiKR3xPLr15gfEWHMOxjy0WbnMiKy7eDMkS2qQ5F0yIZ8DFvzy9kgDqugKsG42Qh5gIe+fJIkWoPq9c+uTp5DXjcoPSIZWSsAifkretv5t8MQlbJroIqsxj9zT9KZMe0A91NbQQXfSoLyw1xb0i/nR/Zml+/pdIGN2awOL0X97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pB1K8MNj/GbsBpq6jNVzCSDDX6v4S+s+A0iOwgbp6g=;
 b=hjgBQ3//HTJpCUxUIBDdIas6iApkwTfCQnL/nPS2z8DGuVQ3YT+4UswgP8opuU0M47N/jWffk8dIEq/VRhOjanlz3JFUZoN+NEI6ZimctctYwj35unRwGuoWJZ3Eg6FZwuDq95U0Wgb7HqfTduoVka3SpuZoFZVdG99VuyJAIh4=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB5910.jpnprd01.prod.outlook.com (2603:1096:604:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:38:14 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5144.021; Fri, 8 Apr 2022
 03:38:13 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: [PATCH for-next] RDMA/rxe: Remove reliable datagram support
Thread-Topic: Fwd: [PATCH for-next] RDMA/rxe: Remove reliable datagram support
Thread-Index: AQHYSsN1xub1YEvFpkGDIkt7zA31MKzlXiWA
Date:   Fri, 8 Apr 2022 03:38:13 +0000
Message-ID: <d089e634-742d-210f-5a5d-dcc142cff5f1@fujitsu.com>
References: <20220407190522.19326-1-rpearsonhpe@gmail.com>
 <cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com>
In-Reply-To: <cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e83697-95b4-4c7b-fa43-08da1911361d
x-ms-traffictypediagnostic: OS3PR01MB5910:EE_
x-microsoft-antispam-prvs: <OS3PR01MB59102F7105798D0B0312AED083E99@OS3PR01MB5910.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJcBswTWDAw1sSFMHs5QTz5JjieN+aLLsvmDpn5wfe4bRvl2yP5rEBxk0LvbBUNupU4HsldPHzwcir+ml9zR3vjZ41AiMI2qyHSG/m1/qVr5wRQsendJKjKRop1gXr4219S8xx+amcwgL0f2c37I2Qjg1+cSLE/k/jCBOJf7EY4L6UMZs62EijHPFbNbVyR/DQBvvRc+clkFj0D9LneIbV7bUQP0htMKZHMWah0jtkFtpA0sqTTmsM6khqzjU4O7FXFrGhj+ft/6mJ2EfkhTQ1UQ6Kj/36zjGCA7gf+1M3iWAk1eMIxpF9zIimqYiRdh5Rlwgcvn2qsMXfvDZB9wwY3UWfW8lO2ylVeBTwzoz+t/LWtOPLCKWNr0HdNU58dmN/QDSD9vCvDAamPI7N+Pf2wvQ9IygqEaSqGMw7XnDKgzyKa/DPGdVdohPbjyqawKAnrL41uk1CZwLlBWQXJtpy8/DOCUVhI4Cp/dGq5Z9wuYO8etceyodtktUZSu8B4ManuEu5SCa1ZE3ZJCuBl1o5qgyB/ATgmZsnCpctCZ3f3ByRpP8pjOo3/Xvrr3saPwC2mFUtV+VYXzrWBjeqY+taw3iWe2bbdcuaBojF4A1RhKLrOPsOzcDH7AZIX3OsWwO9tx0GqHXFNWZnQYwrXakchfvMlp86KC8E224FR4i8d4hDEglfL61JZz1uFnEE7fbr8Vo6Puy0LBpXOSphkzzFuN6FczmgnGbhLQmn/pnPMRKpizSkfZYJoBe0dJutla
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6512007)(6506007)(64756008)(8676002)(36756003)(53546011)(316002)(31686004)(66476007)(66556008)(76116006)(66446008)(31696002)(5660300002)(66946007)(8936002)(86362001)(83380400001)(91956017)(85182001)(6486002)(508600001)(26005)(38070700005)(122000001)(186003)(2616005)(71200400001)(82960400001)(110136005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUg3YUl6NmpWL0dtcHJOeUVpSUdGd0k0YWdYbElKVFlGYlEzVm05aCtpb3ZM?=
 =?utf-8?B?bWxkSW0zOGxtQmlJU1RrOTVndk1wR2VxSVY0eFFTVjBaMGVMYVA4cnZST1hx?=
 =?utf-8?B?c0N3bXlDSVBiaHhyNkdUZHlqMStqOHFzdnNUTTRCVnJRMUZsSDEvK0M1NW40?=
 =?utf-8?B?blZsaHEvYnJwZ3RPZVJFSEQ3NlM3OGZWTGZDM0EvN2RFZnNNaFh6VlhlaWZj?=
 =?utf-8?B?c05MVzUveDhaUVdwajYwckpiM2lZQ2ZvTmZvU0xhcFdFb3ZpUXcyZkpEV3Bo?=
 =?utf-8?B?WDFSVUt4R0tuWDVKS1FWUkU5MDZuU1JLSk4yU1R3dkxmUVM2eVI2VU41UG04?=
 =?utf-8?B?VHBkVzRQMlF3RUxkMmtGb2FOb3lTSTEwcXJlTnRCNGdrbGEvakVCN3kybkxy?=
 =?utf-8?B?Z3RybUJKV1k0ZWdwRVhmZnE0Nk9NTXdxS1RtQ0dNTHpubnhkWnNvc25mNEZZ?=
 =?utf-8?B?dUdDYXNyTjFIRllhbmoyVGd4OEdIZStjOGJtK3d3SlZnejg0NUlzSWxWTVBR?=
 =?utf-8?B?c2d6d0Nobi82SWdXVXZadDUyRXZoUm43U3pDQ3FLNCtPRWRFTWlDNWJmdEFG?=
 =?utf-8?B?MWN4ekh2K0ovQ0dGZzNBeWVqYTJidGxnTFl2eGNnRHRUUHFLY2FpSFVaTjNO?=
 =?utf-8?B?d1llZmtiVW9saWZmMkRhVUhLT1VVa2tucXpUVS9oUmk3QitOQjg2SWFCaTN2?=
 =?utf-8?B?L3Nzak5JUXpjbGc2cWd1M2xCZjNKMkdubnpjanpFQ0pNbGoya1hTTWVYNktR?=
 =?utf-8?B?a1Z6U3Y2UnJsSDQxV2lJalpxUU9TeFhKVnRRaHo4RjR4ZWpUdEtOUnJCNi9z?=
 =?utf-8?B?cFFBKzVKNmUybWVlb2FGcmY0YXJrdHU4ZlJYNnhRdmFOSnJ3bURURmRZU1Vk?=
 =?utf-8?B?VFhhZEhDU0YyRlFOYjFWcUs3TlBhZUs3bWw3S21seGhxR1JaWTVhSElQTlhn?=
 =?utf-8?B?R3AxRURyL2dvcXA1Zlk5SWRLRk9pQit0dzdFV0R3cS9PbFpyNW9NV0tSMjJH?=
 =?utf-8?B?M3VORnl1YVAwdWcyVGoyYkFmRG9OeS9zaHI1alI3Y1NxYjM5VWNvSmhYY3RD?=
 =?utf-8?B?YitEYUdKdHJOeW1ZR3IwRjVKZUpycHFiNE1ZZ1BQaDZvUTN5bW1KdlB4UDND?=
 =?utf-8?B?Z01CbG1jR0pIQVR0SnBvZzBiQXNYS01NV21CY05wdktWbWNFdlAvRmlpQXF1?=
 =?utf-8?B?bW83a2dJdm9EWERqWUhseDN3aFFwVERLdXl1a08vT1dzeEREdkN1dGVnN1c2?=
 =?utf-8?B?OEo1L096bjZUNmlxOHVHanhFNXh6bXJ1dUg1TGRMam45djJDdTR1VzZVM0hF?=
 =?utf-8?B?emZ3Mmtuem9udTBsdXkwSmQyWWJ1WDh6MjJDM3ZkTFpPSmtrWFh2MnUyRWZN?=
 =?utf-8?B?NnJnajFsTWJZdEM2V2djMll6a3ZJVzY2UFA4VUNwVHp2WFlhcDNMc2dQaUYv?=
 =?utf-8?B?emJzUHpOMEhWcWxGRm5kZk4xSVE2bHBzR094RHJxWWw0Z3BDNGcreWRCRWJ3?=
 =?utf-8?B?Y2VqOEdDck1KK3g1MEFKVWsvUis5NnRmemRBdHhtdy9JenpTaEptQUZjelBu?=
 =?utf-8?B?VWNmdUN0YXVET0IxWUx4NHZKakhVRVpxN1lIMU9lQ21DQlUwbC9oTkJGSkxv?=
 =?utf-8?B?emxmeEhyQi9WaGgzM1BadkFObWVaN3pEMGwxM3dkYk9oSFhxbVNjM1pzd1Nq?=
 =?utf-8?B?Q3lGa3ZBNGlqRHM3Q2lnbXJQT2N2Qms1b3JVK1hibDdTOG9vdHE5WEFBU0Na?=
 =?utf-8?B?VHo3S2NXWkQwWWNWZG9hV1FvcURlblArMkRNQmJucTRNZ3VkQ2JNTVk0Zmh3?=
 =?utf-8?B?U1lZc0tiZ1g4aU9MVFdvZ2hrWDdRUkJZQUNYUnNwUkxtTWxHTkRmT29OK3RX?=
 =?utf-8?B?eDlwRStJRDd2QmRqalNrVm1GN1RoMDNsRm5aL2krVWkweW02TUhpcVI3VUd6?=
 =?utf-8?B?c2MwOGplUkdENWpCM1BaMFRVMFAyeHd4Vk4ycGU0dkxoYmFPRngwYmRrS1Q5?=
 =?utf-8?B?U0xabE8vdU8xaldTa3g2dHdIdjYwQ1U1RW1pdzB5OVVaRW1HWmNXdmRudy9S?=
 =?utf-8?B?QmlCRmFmSzI1ZmRrckFEK0JLZm8xaWtFaVZYOEZ3VUlrNnMvcFZxVi9NR255?=
 =?utf-8?B?OXhHck1lOFVLY1RYb2NNZGtZMVg5Z08vMEJDczFNM3p6ekRZb2V1bFU4QnN5?=
 =?utf-8?B?VXluWHdPeWhubUVtZVZEalgyMlZITmJmQnN4NkRsek5UaEpiUU5ZMi8wWWhh?=
 =?utf-8?B?NmEyU2NLNHhMOVJ0U3lTVkVGcnBRVk5YdGR1VmYrbnZOc1hQSGxBVURJa2dO?=
 =?utf-8?B?WXBpTE9NL2YxdElrdHBZNXNZTG1XbmJUYVMzeVJnSkRUSlRMNklrK0xSSHJr?=
 =?utf-8?Q?2eh3v2p7IFE/uxvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39B8F1A6E75EB2478CF02EF165B259D0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e83697-95b4-4c7b-fa43-08da1911361d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:38:13.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIqs/v4oZxEC9ROPY6pi7a6NXCzzFyUaR9XWU+mnUkodsx3cCO5b3k68RyLww2bWfn2klpXKsVA+U+Vm4f5DuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5910
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzggNTowNCwgQm9iIFBlYXJzb24gd3JvdGU6DQo+IA0KPiANCj4gDQo+IC0tLS0t
LS0tIEZvcndhcmRlZCBNZXNzYWdlIC0tLS0tLS0tDQo+IFN1YmplY3Q6IFtQQVRDSCBmb3ItbmV4
dF0gUkRNQS9yeGU6IFJlbW92ZSByZWxpYWJsZSBkYXRhZ3JhbSBzdXBwb3J0DQo+IERhdGU6IFRo
dSwgIDcgQXByIDIwMjIgMTQ6MDU6MjMgLTA1MDANCj4gRnJvbTogQm9iIFBlYXJzb24gPHJwZWFy
c29uaHBlQGdtYWlsLmNvbT4NCj4gVG86IGpnZ0BudmlkaWEuY29tLCB6eWp6eWoyMDAwQGdtYWls
LmNvbSwgbGludXgtcmRtYUB2Z2VyLmtlcm5lLm9yZw0KPiBDQzogQm9iIFBlYXJzb24gPHJwZWFy
c29uaHBlQGdtYWlsLmNvbT4NCj4gDQo+IFRoZSByZG1hX3J4ZSBkcml2ZXIgZG9lcyBub3QgYWN0
dWFsbHkgc3VwcG9ydCB0aGUgcmVsaWFibGUgZGF0YWdyYW0gdHJhbnNwb3J0DQo+IGJ1dCBjb250
YWlucyB0d28gcmVmZXJlbmNlcyB0byBSRCBvcGNvZGVzIGluIGRyaXZlciBjb2RlLg0KPiBUaGlz
IGNvbW1pdCByZW1vdmVzIHRoZXNlIHJlZmVyZW5jZXMgdG8gUkQgdHJhbnNwb3J0IG9wY29kZXMg
d2hpY2gNCj4gYXJlIG5ldmVyIHVzZWQuDQoNCkhpIEJvYiwNCg0KQWdyZWVkLiBJdCBsb29rcyBn
b29kIHRvIG1lLiBeX14NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgfCAzICstLQ0KPiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDMgKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXEuYw0KPiBpbmRleCA1MmMxZDhmZjZlNWIuLjVmNzM0OGIxMTI2OCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gQEAgLTQxMyw4ICs0MTMsNyBAQCBz
dGF0aWMgc3RydWN0IHNrX2J1ZmYgKmluaXRfcmVxX3BhY2tldChzdHJ1Y3QgcnhlX3FwICpxcCwN
Cj4gICANCj4gICAJaWYgKHBrdC0+bWFzayAmIFJYRV9BVE1FVEhfTUFTSykgew0KPiAgIAkJYXRt
ZXRoX3NldF92YShwa3QsIHdxZS0+aW92YSk7DQo+IC0JCWlmIChvcGNvZGUgPT0gSUJfT1BDT0RF
X1JDX0NPTVBBUkVfU1dBUCB8fA0KPiAtCQkgICAgb3Bjb2RlID09IElCX09QQ09ERV9SRF9DT01Q
QVJFX1NXQVApIHsNCj4gKwkJaWYgKG9wY29kZSA9PSBJQl9PUENPREVfUkNfQ09NUEFSRV9TV0FQ
KSB7DQo+ICAgCQkJYXRtZXRoX3NldF9zd2FwX2FkZChwa3QsIGlid3ItPndyLmF0b21pYy5zd2Fw
KTsNCj4gICAJCQlhdG1ldGhfc2V0X2NvbXAocGt0LCBpYndyLT53ci5hdG9taWMuY29tcGFyZV9h
ZGQpOw0KPiAgIAkJfSBlbHNlIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0K
PiBpbmRleCA5ZGMzOGY3Yzk5MGIuLmUyNjUzYTg3MjFmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBAQCAtNTc2LDggKzU3Niw3IEBAIHN0YXRpYyBlbnVtIHJl
c3Bfc3RhdGVzIHByb2Nlc3NfYXRvbWljKHN0cnVjdCByeGVfcXAgKnFwLA0KPiAgIA0KPiAgIAlx
cC0+cmVzcC5hdG9taWNfb3JpZyA9ICp2YWRkcjsNCj4gICANCj4gLQlpZiAocGt0LT5vcGNvZGUg
PT0gSUJfT1BDT0RFX1JDX0NPTVBBUkVfU1dBUCB8fA0KPiAtCSAgICBwa3QtPm9wY29kZSA9PSBJ
Ql9PUENPREVfUkRfQ09NUEFSRV9TV0FQKSB7DQo+ICsJaWYgKHBrdC0+b3Bjb2RlID09IElCX09Q
Q09ERV9SQ19DT01QQVJFX1NXQVApIHsNCj4gICAJCWlmICgqdmFkZHIgPT0gYXRtZXRoX2NvbXAo
cGt0KSkNCj4gICAJCQkqdmFkZHIgPSBhdG1ldGhfc3dhcF9hZGQocGt0KTsNCj4gICAJfSBlbHNl
IHs=
