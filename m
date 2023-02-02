Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702F687658
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBBH1K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 02:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBBH1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 02:27:09 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 23:27:08 PST
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67768106
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 23:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675322828; x=1706858828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ThBmQnW+oVUQwbB0Iy56q+TnDDWrKZWYXdPeiuqD8z4=;
  b=obXYjWTTclJ90dHCN22PXGV6iSk/ZlsrsSpvV8Pvb7v299qJEwvgtKER
   ztlcrtVGLRYY6gDf24xDhAwH9mYa/wFb28O5QMEPvExtzR25OqUhHugDV
   mvQIb9DkAiV6bHd8GvU95gp/QEJIj3sqAf4aIOlApzXNbuJn8uy3bgM9L
   9EPB2KQZ+21ZxPb40p2/Xz4rsQLnhm42rWtKe/ASnITrro31jlaYfgeJl
   hUgcs/b3NODvQtWIRVbsqXmLGuVwEa3aHP+vdIApzVGeMitFpbJgwONh/
   OY1qwp7vnowzdm2oNtmL431sfNtE7BIq9AQV+c8TKfCrdTiy6IT0lzRxK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="75717403"
X-IronPort-AV: E=Sophos;i="5.97,266,1669042800"; 
   d="scan'208";a="75717403"
Received: from mail-tyzapc01lp2045.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) ([104.47.110.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 16:26:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYKUbOChO8k0KpR+rMGDKk7RhbfuvikTG2k/Et//9c4rPmx9uGi3Il4MHpmDTUJXguWdCKv033kT7yhFsD/f4/wRKMjmjnDDnpVvHurzSGnX0dEfwnekgGFMj4AKm9xahx3WmwiijPLYQ50qk07K5Z2dbfhtjXq1+U3eBlMQOJwZNTO2EH050gGJBJRl7hveF8fbM7Kme0VoIHPHkVEleTurYofPRcKbLmRo9DKNhTW9Vc1xa9ILI3tQtxzAHxdggez6WxdxDld160+rN90ONQAIM3DjKWFbStPcSKYbhrTxbX+QEx+IWx6QkhFHpueJyzWwbxdA8aatGYB7k5FL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThBmQnW+oVUQwbB0Iy56q+TnDDWrKZWYXdPeiuqD8z4=;
 b=hwzf3ZhQcSuNB/6Gv8vTFBu1U7VhwmxvlL8FUY9Y9WVgaRaW337RsG0fvPRKopFTTv3usGOitiLBvpUwNBixMBkXjzXbHl/cY2BN5TzqkI3azc8tVv6S7oIcY95nKgxkj3eV6GG4qioqkUQnK9UJz/u8xx3j/wIV1ndidvqAvyebkmJf/q3aow5a/RQu8NimpvekZds4dJIlnIcEWCQfyDoJZtLT2K2Ghly1qzuK4Q8R6V5hAgHE4PNjy2ap+mrjOjolUgN7GU530BZQ0e+HQakSP0fofkV8YyPFx5EEHXOIgI46rxBMqUJf+qCOw1JGin2Un2yT8grBJ01OEDmGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYAPR01MB5931.jpnprd01.prod.outlook.com
 (2603:1096:404:805b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 07:25:58 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 07:25:56 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Thread-Topic: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Thread-Index: AQHZNknSEl1MkKz1D0mzVosbk4JcKK664lGAgAAh9QCAAAd2AIAANtsA
Date:   Thu, 2 Feb 2023 07:25:56 +0000
Message-ID: <fe563b74-efff-2799-ceff-af7af7bf9171@fujitsu.com>
References: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
 <6bcba397-f4f1-26df-f8cd-1dbebf111932@linux.dev>
 <d1751eec-3d48-a8c9-1e3b-3263a4a043a3@fujitsu.com>
 <b82cfec2-b679-7c5a-06fe-a540fddda0f3@linux.dev>
In-Reply-To: <b82cfec2-b679-7c5a-06fe-a540fddda0f3@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYAPR01MB5931:EE_
x-ms-office365-filtering-correlation-id: c3578ee2-7e0c-4314-1adf-08db04eeb976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mV2ATwxtPCXYbwdAjo8E95kEVCNO3mOIfIaEag07TWC/0n9IE/sgvMXpya9FRfi7YXihxpV/MTNKSDHNlkJrayqJ4fn7SR+OCafdkNjuUAwVxCh+YfrycRVXIfoJMDfYr3PiA/ObY70fC+vCEwTHRtNIbWhmKMCJsCzuyDUoWuAlAiNG2TAatqxo5Sev6lTDsDU9GfZxysHFXIh7+VKvUvC7oQw9u6deWU7aKlDdw2e5+bhav5fCUVlb/MpJ9bhWojZcl6yP+ApmOMSk7JNbCfVa72HN8gRsrfgM8U8a5sI/sehw7UW8T8P7aYRY0Xyx8mvCUKm+kkOMeLUFktevaBa4SAHV5tsM0M161mA8mXI9RBQ2hHAh3AZ1ua6glB5xr4qepwuDOuNTe3fgBSxHEB7In+hPSJ75hauD6u4ebrG4L6Ib/A3tUsHda077e25tbt1gwpM/26d3t7P1p3F0QSmKk3OEMGtWtNZGx4jG/DYCp7OAfGwUqgJn14VwvDCBgzZMTNz11qcnPFea8qLQHEVhUE1Me7zLWlgzPJcGvcp6ogxnfZFwKHhalig1/sKllqKcCliSG6JzQSGZKfMJboHlEFo6WmYxrFB7G5giYpfpkQgNmT2M9ZQ1BvA0bqi7Y1TBoZtkFNs1YyTJjn1S07HfqylUxr27JtUT5J+DIzprPY9XM6GTt7UC+TxmynOliVPbuF1CDsJ1u+jC3tv6PApWtORFoHlw2mXGTy+vp1jijw/hAmPtFUDQDGHSirANVjoh5wZAgTGXrabiLK4o7lsVvh8AFQhqTNcqqiffDIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(1590799015)(31686004)(316002)(110136005)(76116006)(91956017)(54906003)(8676002)(41300700001)(66446008)(64756008)(66946007)(4326008)(66556008)(66476007)(8936002)(36756003)(38070700005)(122000001)(82960400001)(31696002)(86362001)(85182001)(38100700002)(53546011)(26005)(6486002)(6512007)(186003)(1580799012)(5660300002)(6506007)(4744005)(83380400001)(71200400001)(2616005)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRsd3pGaU1EVUlLYklyVmZHczV4cHJvS0FRMTVXQkE5WitkY0VtZU03bGVI?=
 =?utf-8?B?S1hYbnhPV0JQdWpUK1o3VmMxNlF2eTNMa0Y1enNxd3pHakpqbFZZNmpVZEpS?=
 =?utf-8?B?anE4TkVGOVNYaGsxWm9yRDhOSkhtREZ5K1BPZ2hUNmZtN0pIdnR6TGZsWlI4?=
 =?utf-8?B?U1dCZ3JLbmpncGVGWnUvVlRWV1JPa3lGUi9pVFdJY1dTbTZiZ1dOdlhaMVZ3?=
 =?utf-8?B?N3FvcEZyUVZTM0toN2gzMndNWUNOcXlHaDhNUDZOb3VNL0xTZ0U1c0t1RW9l?=
 =?utf-8?B?NlZiMnJSQkZFcGIva1FxN0hTcnlyN25hWGR2MFNUL1Njdk9JZW9nTXkwUlha?=
 =?utf-8?B?NGh1STVHYVVBaDVUNWdtcUQrUFRSVlJWcFltVFZPeGlRcFgwcmVPeFdxVldN?=
 =?utf-8?B?RldCazNmWmExaFNlUkk0dlU1V2JVdkQ0UE8vUm5rVi80QlAxQjU3SXBvY2hv?=
 =?utf-8?B?Skh0UC9OYy9TNE1iMzhGTGI1NTJYTzJWU3pnN3dxZXdWdEt5Z21UeEMvcmZn?=
 =?utf-8?B?S25uNzhHTUFCZXF2K3VCMUtLT1N3WXE1d2phcjBVbFdmY1VObkk1MFFDcFd5?=
 =?utf-8?B?ZWJYcFQ0UkxVZnFkTHhUelp3VGJGSXo3TnY4aDNuckZtbkRTc0JrallVYkJx?=
 =?utf-8?B?SDJUUmhFazhnZWMyZVFzZDRpTGFQQTVVbXNEdFRCdTdVL3dITzZ2aDZNcXhy?=
 =?utf-8?B?QitvYzZ5Sk1DR0kzclRleG10STJRclNwTTlFeWRWWE1pM1Z3Z042ZDlMUkRq?=
 =?utf-8?B?bE84ZTZyQ1ZJZDZZcWtxbkZONDdRWjhTWnI1M3NjMXZsMkx6a21LcjV5eFZu?=
 =?utf-8?B?MUlObU1CY2FCT1JJTjFwVjBMSG5mTnlnQlQ1Q0x1L0hOZHhQMjRwZHZmSER0?=
 =?utf-8?B?L29RbGhXT2VmWm1JaDJCTDQwcXQ0N3lISFFCNXhRTE1FWmJiL25saHZrWC9I?=
 =?utf-8?B?QVVxdDhDdjlicUFuUXAwdnF4dWxSOUxpQVFyOEZoaEtja25WL1NBbjFRd05W?=
 =?utf-8?B?aUVQbkEweWNwb3pjVGQ4NHFCWjlEVFg5a2xNOUY4V2ZuWHc4NzlFdjhxWk5X?=
 =?utf-8?B?VkVzc3hOZFJnWFI4akpSUTlRK1FLWnNCWGs3V21ESktIN1NlR2xEK2gxWGp5?=
 =?utf-8?B?ZFRHWVdRUzFsOHdMNFhiUDRtVkliZ0ZtRmd0MGpyT05oYml0NjI5MXdkRGJE?=
 =?utf-8?B?TWtmdEdzcGF1bzZicGZCd1cyQjZQYS9RRlBocnA3L2MrNmNIcXJLVnVDazZN?=
 =?utf-8?B?Y1k5cGJBYVBiekpjWGVxVDlJVlozdHB5Nkd6SXlFRXR1MUR3R3lBcVJOajNw?=
 =?utf-8?B?TU1JUGVKL2hXQkxpV3FseHFvY2pjdnk5ZzdtY3NTWWx4Z3lubXpsOU5sYW5t?=
 =?utf-8?B?UlZvWFMvVlFrd0pDNUk1Z3l5eURucGpiMGFuVGE4V3FLVDVZcnYrSmNnTWJU?=
 =?utf-8?B?M3pTVXJ2eGUrTTN3a29jcmxlR2JQaHBIK1duckNYMEF1azZtZk5GWGkvSFo3?=
 =?utf-8?B?WFdPWXhnaC9PSlJRcm03OGZIbjBXY1VxczJTYVc2Y1JKTVpvcmFxVXJ4ZXZU?=
 =?utf-8?B?TzlmRW8xUHQrM3ZIMzZuYnJDekpRR2FqTEVTZnJDbytHYUVtUjZBUSs4M2lY?=
 =?utf-8?B?Z2NIUDA2RGNuMXpGbFp6cUUzTko4MHFuUU54QjZrMi9XaDRkZytUeVJFNHMx?=
 =?utf-8?B?ZzdIRjhxMGRPV1pKempNUVFGbnVQd2kwYWtYTTFESWlHOEZaL2RtK2MzTVNm?=
 =?utf-8?B?ZVhXQU03RnF1TVE2WG1jVXYvZ2laa1JhanVIRElqL0dWaWhoTDhHY0dzb1BT?=
 =?utf-8?B?bGY1T1pndlE2T2NRbE1jdFE3cytNN2RGbklEZytCZjEraGRjMGhZeTljQnB5?=
 =?utf-8?B?T2Vra3hYL1ZLRFN3N3V4QmlPUkhKaklFREo3VTBpVHk2empDM3hBQzJkak5m?=
 =?utf-8?B?UWRrVUwweUtUZWN6TVFYb245SkVPdDRWa3lubWRnMTdZdXRzVi92VE01SkQ4?=
 =?utf-8?B?T1dmdVVncDhUZUlhcHlJdjdCV2M3MVluVlRzY0NsYURiT3RhaVNtSTUyNXRS?=
 =?utf-8?B?b1dITzNjZTJZZEJUa3d4STRpZ215Tlk5bnYyVytxalRPVFNYWkZNYlV5eE1J?=
 =?utf-8?B?VnFObTBMdjJlZmlUS2U2MGJkM01EaHBwSllzcFhZZXJVZi9wZkdQWmZ5aDBq?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88CF27D31C75FB40A0F0BADE244FF09D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NGxRRUrazJkzrMh5VpMQBfK7TVMpq/5NukQwvcXXC2zzaJ2ySSIV/O63Bl12Y3bX9fIedWyXtEhSiXnkTiIfEy41pCo9yu82SEEA1ryvZfpcnfCTyD7phzWa3U50rsuN531LZYRfsQSlmi+obpa1/HwnKKQ+cjEkOFroXjd5mYK9carEkzP/O1q+ryk+pMmN3Kkzgrgg9/5CRe4FDy9wFg6/v6NAAB4amTPLURYrlPXQnrPMphfN7utxmUkMMFbNswoPvKCjmJHZ17FK9TOafH32fTIV51T2k4CZf/yY40EilReQuhiigUw7eTz3a6gt2LnZSPOUWLSW49CPZVtVZYoZ04zrdUAMz9B5mRd6a3JsQTJXY9qUCAkWlsyBxZ2ebCjUh4Syn3cL5d/u0s/SQYJLdhv/zbTUkMv9dY4lQHAUV98TkhTT30ZGtMHylP4GobmbYTPps8vNMXSnqAInTxY0SRWxR21A57pfIfOM0mTSYNFVBaN/wyD/u3QOiWiFcOq/5zNec0mwyhVmLOLkyO4QM2OJ0WbWv0LVS2U2oyAbsuxV/G5pjya4aRuYvlM+JrSYAKS9vvQ/a8rEcScCwmYaPAcJzXrd0Fs3tnHLmxmqRS3kxU3L8WZc3jvohe1ds31bkEGuZLxJPxegz3tsh565+gvhm4k86BMdAvQLZx/r0R+jLviQI8JY2sjCrBjrzh57BUeDMKaozIfACHksqJmaUtlF5m1JAVEioGO9fjWWVTDsMNfwC7mHAW/jczy9sPMY9W+lQSwnJo+skoMyr/qP3XinxkBrv/RlZNZneXYUmMyZCZo2HNXRLA0w/yiZWw57iUmUluCkLv7pof9khoed5lYx9YNsdBmcBB2/CC68LhHXGliT7evAMh/qpHwP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3578ee2-7e0c-4314-1adf-08db04eeb976
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:25:56.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23lvexOfjEhcOHSlwMuxhX0qJNgwb3oYr3EF5Yv3jlDvq4K6KxoPgqCP4xPNE4v2juBEGmH6OwrKjzTONbY0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5931
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMjMgMTI6MDksIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+Pg0KPiANCj4g
U3VwcG9zZcKgaXTCoGFsc2/CoGhhcHBlbmVkwqBkdXJpbmfCoHJ1bsKgeW91csKgc2NyaXB0LMKg
ScKgZ3Vlc3PCoGl0wqBtaWdodMKgYmXCoHNvbWUNCj4gcmFjecKgY29uZGl0aW9ucy4NClRoYXQn
cyB0cnVlDQoNCg0KPiANCj4gJMKgd2hpbGXCoHRydWU7DQo+IGRvDQo+ICDCoMKgwqDCoMKgwqDC
oMKgZWNob8KgInNlc3NuYW1lPWZvb8KgcGF0aD1pcDo8aXDCoGFkZHJlc3M+wqBkZXZpY2VfcGF0
aD0vZGV2L252bWUwbjEiwqA+wqAvc3lzL2RldmljZXMvdmlydHVhbC9ybmJkLWNsaWVudC9jdGwv
bWFwX2RldmljZQ0KPiAgwqDCoMKgwqDCoMKgwqDCoGVjaG/CoCJub3JtYWwiwqA+wqAvc3lzL2Js
b2NrL3JuYmQwL3JuYmQvdW5tYXBfZGV2aWNlDQo+IGRvbmUNCj4gDQo+IA0KPiBPcsKgZG9lc8Kg
aXTCoGRpc2FwcGVhcsKgYWZ0ZXLCoHJldmVydMKgNmFmNDYwOWMxOGIzP8KgSWbCoHNvLMKgd2XC
oGNhbsKgcmV2ZXJ0wqBpdA0KPiBmaXJzdC4NCg0KV2VsbCwgZXZlcnl0aGluZyBnb2VzIHdlbGwg
YWZ0ZXIgaSByZXZlcnRlZCA2YWY0NjA5YzE4YjMuDQoNClRoYW5rcw0KWmhpamlhbg0KPiANCj4g
VGhhbmtzLA0KPiBHdW9xaW5n
