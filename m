Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7183D784ED0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 04:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHWCoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHWCoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 22:44:06 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8115CF9;
        Tue, 22 Aug 2023 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692758644; x=1724294644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1e6kCV2Q7yTHeYNq4V3HsHJAQKaGpQpDH+9JIuAWNsM=;
  b=i+D5u3RFThJHK2XlGSaGigGkRENUBPkqvwagdy5Kcj8doNhgzNPJHrmB
   4Iwy8ySn+25JHYjJI9KjYvGUoe2EkEEjI2UsoVHQ7Wyul4BbCcQST6ejt
   zp/DwmfygSQnWlw3pEcASkDiov4HN5LxRS8KcTxt89ZBqRuViIEQ60xbW
   nm6NufHaPL6R+2/vGhdipHwnjwEwiwbIA5ZJTSYxmGy6db27ccQ00aY4g
   p1IqIJU3XTTh1iMdRzAGrcvMA57v0g0HpfWwuzWIybVTcWV5Jm8cTnyJv
   35tPF+En/fgCtJ2mjUZ3d5H4qvIRT73NXVXMCQADTsUX7LZXjITpHNPNF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="93211133"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="93211133"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:44:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPbenLckep41KL1bw6k7YHIZkYjNJzjxdYcNQibSIQgSxy4U2APkQGMC4oYGcMzTIkhSxcjgTdBqa1f4jXIrFtbCxAXyjuWIri1uB/Y3gI/esLRryqDsXdYi4bxykrDXr7y7EB7YVZdnvDtPGOfC/eCbb94pNymVdfdciYcLcErvFCAOIWs/rw5+t09jrlN7zpJW0esrJrmKrsB3QFgW6GRqrGVxIPhi4/zGSnFU+/afO2ZqvRizIYWZvpPflCWZn/tdTnXF2kWMnaBS1ytNAsIfnuuJIfaXlvgGOHVFKILaBuSjKYdHZEzT+NJ5d8wCVYH8U08NvhIRip37CaPOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e6kCV2Q7yTHeYNq4V3HsHJAQKaGpQpDH+9JIuAWNsM=;
 b=GcK1yPBFWMoz/ULv3x/CEC2/ue3/BTRMsKLiLJ/C0mKEzzpqrqWA2s/fCMKXLWnJHXhoXBApYYS1nrsgWScu/eHkkwnXQ/OjSmoH3/XyEWjAH9+CGK+nX3Qv9DMpmicRuCOvziMuBzuADB3QVU4NyrJj//EliFLq40HlYOfWjq4Ekqqt1bY+ZTV7Kls5O7AjJ4MmzCEuhVABOrBIK1DjNsMnGMupQ+fW5iyfmMuIerW5nyl4HB3YUEXz4gCNQAL6nYQ38gDY23GNh/Cn+eSFMSEmdxLsbT1gVaU6X6ScG3amTfgL7CT6A1Nkf/PWopogiRBOCyK/JCuiZwZpXKa7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB8673.jpnprd01.prod.outlook.com (2603:1096:400:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 02:43:57 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 02:43:57 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdpgNSw3ndasU6QgtsG1HLb0q/3KT0g
Date:   Wed, 23 Aug 2023 02:43:56 +0000
Message-ID: <OS7PR01MB11804CAF2115EA88678B1B2AEE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
In-Reply-To: <20230823021306.170901-1-lizhijian@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZGNjOTg4NGYtZjY1NC00OGRlLWFlMzQtOTM3YjRjMjUy?=
 =?utf-8?B?ZWNiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yM1QwMjozMjoxM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB8673:EE_
x-ms-office365-filtering-correlation-id: ce397bb0-7c6b-4f6d-b96a-08dba382cc21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eib4sw30kFcNTXNzuHtxL6NNp14YPEQ+3atmj+RvbvPk8qZuvtRaRz5kK0KCZqz/RObYyBvQ0COAFOkRZDdciMb51eXEKrb7x7y6kewb9aH0JSpwAD7fxqAstixDBF+9u4b0Enlh42jRckelSRacLWQEMwdj2n31mnTFJGeV3W98vlHRQDBUxC+vEjGfWOc1hY6Twt39yyRYJiYs0OWC/09GHt3os8ly4zWFNniXtSoJGR8pQ5kiCLJbcYfPfc02ZirJ7KPaiDW4oZpM7o32njD+7+LzjZT36z4JqQD51ygRlFBxsUL0d8KtX0xfGqnOxhaP9jIZqY+HugjEeC+C+xbFw5FeooIJuh3JmiKC9RBQCsfkWKL4HBO/1CN3Xi/n+XKiStawBNErwrTPWdwutMNfBQHaGGN2bKvtQWIGwTIlBNcIWSKGd/WQLhYNv02LVM8+MeR5Me70keehAdXXCYHUM+lXqPib3MDKq2qUYo721nvrTEpbSj7oifC/Gh7wmwBRLsP1SxzEejKsOaP6RdqudNTIv59D+vB3XqQbw0EnXwKpjT/c/tjW3U1iExRh3XgifhNp94YQGti2Q+VGcsw30d+mm2IhbkT2exnRkW36/mZqq44ifyg6s9YCxZQ3Wu+55StKl18p4WfN4D1/nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(1590799021)(83380400001)(478600001)(122000001)(26005)(6506007)(7696005)(107886003)(55016003)(1580799018)(53546011)(71200400001)(4326008)(33656002)(4744005)(15650500001)(5660300002)(2906002)(52536014)(76116006)(9686003)(66556008)(66446008)(82960400001)(54906003)(38070700005)(110136005)(38100700002)(85182001)(64756008)(41300700001)(316002)(66476007)(8936002)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXNaaVdtekpua0lqNzRTb0ZyOHNNMS9HbURROXFYMGtlbWJNeU1IQ3psMk01?=
 =?utf-8?B?anZWd2x4VHhWbDFaRGNjb2FyemZCRVpIS1prZktmT0NNRUFPdDN2d1Q1b2RT?=
 =?utf-8?B?d0FCT0hxaEowUUE2aDlEc0NwVUg5N3o3aFJTdlBFbXVwSzlLVjJZU09LRFFT?=
 =?utf-8?B?TmI2cEwyd0pVMm8zaWlJUHFDM2lUMDVCMm5VOExmTHlYT3lMbjFOZmx4anhu?=
 =?utf-8?B?ZzZzRC9pREVMNzJ4OFNGc25GbVBvTERqd1RCa1FFNDVlNEc5TloxLzVUemVh?=
 =?utf-8?B?TmpzSFBqV0FIZ1Y1RGlaOVREem5nQ0xlNlQvS21CZ0svZTJTT2dHUlQzbTQ3?=
 =?utf-8?B?b0V5MzduV010cnJySUo0NzhleDFPQ21zdXhYR3dNRTNyaThSYXFjekFkTG1j?=
 =?utf-8?B?SEl5aGNxbUZaZjBYTHNJaW1iQStCU0xaRU5keWQyc0ZEUTdMWUlCTkM0MVlW?=
 =?utf-8?B?ODM1NFlzajVhbW9yK3c2TDFJRzFGbmRHQ1ZMeDBZWFUwL3A4VlhCOTJDK0lm?=
 =?utf-8?B?bDQrUE55Q2RLdXpZWWsraEE0eGFuSVpCT2kray9UUktCSU5HUEdsZFk3QWRj?=
 =?utf-8?B?djVCQ1dPTWdEWnl3Q2hTeUlSUlhNQTZpK3dzOVI3OTIyU0dHUGEra3g0TFhH?=
 =?utf-8?B?dmNwczRJLzJIVEREQU9GajhEMnZLKzRzZG1EbVI0cDlSYUNKdFlxenZBODk0?=
 =?utf-8?B?dDZhdUI0cUZESnJ3bGM5WXpJRkM0ekRXYTh6WlY2K0ZmWjBSeUwxWldYUjdT?=
 =?utf-8?B?MVIxVDFFT0Y3Sy9sbFBOZXJiaXpsZVdxUUFwUm4rWS9aQmluN01GaXlPQ1dl?=
 =?utf-8?B?T1FQaWUrSzIxWWNRWEk0dityclg0M0duNGV5UTNqdUxhK3JreDFla1NLNWpC?=
 =?utf-8?B?b29vYzJvRGFaYzdWTlRRdFpOQm1nUlRoQ3hpZDY1VGhHSE9BRUhUQVlLNnpS?=
 =?utf-8?B?ZVViZ0Q1ajhleGsvd0VNTVJsaG1PWGc5aDJHQ3dnUmlWV2N1QWx2bmVRNTgr?=
 =?utf-8?B?N3F3d3lDM3EvNUkveW8xbXdWN0RTc2pRSUlkRXZ0R2VSYjloVGprL1J0UFlV?=
 =?utf-8?B?RUR0bG9oSTZDOWVPL0h1bHd6N011NHQxRVFLbGo3SEJMdHI5cmYzY3NkK3A0?=
 =?utf-8?B?Sm8zY012a2RNVExYQm5OV2Jnd0VyLzVhWjFvejhSM2NuZ3hRQTBkQnQwYXZq?=
 =?utf-8?B?KzYraGl5NjRYdEJDWTMvTHMrUTZ0RmhiSzRRT2k4Q2pZM3gzU0Rvb1NMV2sz?=
 =?utf-8?B?U0dGWEpZWUxxSlFpNWt3a3grQXdFSnVmYTFnMnZFaU5OMmFBQUpMSWxEMVBT?=
 =?utf-8?B?RkFtdVhQSjV5YStWQ1MxVFZKZFFoMHRsbnpNQkFRdnl3TVdQZ0R1K0h0KzlB?=
 =?utf-8?B?V3BxTWEyTWRlWkVETHAxenVqb3VIYkl1T0JIeWFOaXl4SC94ZVAxemdhOTg5?=
 =?utf-8?B?Z2R6VWhtZDNXOEFVTjNVQ3RubTJqZUg0aUxMV3BYN1doNE45azhubEJ3N2l5?=
 =?utf-8?B?Mm9IN3J1aXZnQnNHZVNRdUhSQS9EdEFFdmIyMmYxVmJjejJJZHl3Mm9pNnp3?=
 =?utf-8?B?bzFxYmNCTGp0bDZLRnR3VFhJMDJzL2tJVmpjTnMrczZYZHlwazlCYjBwd2RN?=
 =?utf-8?B?QWwxbWdaV1RIdmlrYlNLbCttU0FYNSt6VkpObkVpTHBtOFFsOXZTeGZVWGR0?=
 =?utf-8?B?b3cyMFR6NGFzZlhncGVLblU4TlBDYk5GMHplS1ZVcHFRcGdsZ3BqTWVRMFNJ?=
 =?utf-8?B?RSt6MElKNzVqeEJEOTBoVEtMYm0rZVoyZG1NMDU3eDRTNVlFTW44SXlXNlJs?=
 =?utf-8?B?b2x2S1F1TmJ1TENObTVtNlVQM3Qzc1FiUkNVcHFMUmpINVp1Y0ZUekszV2Ja?=
 =?utf-8?B?YlBRZWVTdFJWYXp4L2xRK1lmcWZDOWx4dFZieStkYmlhTlp6bDZTSkh1RTF0?=
 =?utf-8?B?dEFvclk5SDc2ejJZZVorTkU1aWxybkZNdUpyd3FUWGtrd3FhZ1Jpd2o3MkpB?=
 =?utf-8?B?UW16d05mWkZJQlA5U2piVC91b1VTNEk2NVliRm8zbnFWNExDeUtNWmtsZXJW?=
 =?utf-8?B?QVprRXZ5WVcvVHdLUXpIbFhZKzYyWDFjODEra1FwVS9GSGtFdEVUNFVQWlht?=
 =?utf-8?B?MjRjWkp4cUkzenJqNGFGM09KbmhCWk1xV0txcjQ2SnNjVEtlMG1TVHJtNzBs?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bNOkiEcJh2QXKVwuwyVQ/Xga1y/16Mtkjjpoe8Uy2+VtXJZRQUKURXISRCQTTRBO00pjSaG6qvhA3o26XnETqO9Vm+ayEOW2mc663r/5etCyAAH6zAVMve3GLf2rlCVIsbnI1hsJNxCga8npEe5VBzDoXv1zvdCHGzz1bGQvDfdgwEXGuC5U3WlzUKgAW9PlORRWPCQ4DYfSCqDIEX405Q+z+o/PtBTec0/s38YBxNVaJA098Jm/GLKsnuielO3ydmJmKFXiwNdskAvVWkd0lreMntyV/WzUgxG/0w5xlFUDxloU3hzxFaCXe/zLx15JfOEfnRh59t07XfBB6SLowtpFnnzCGI/SJ2yVs38++3TObHHbEWGjrhSDmJH9ehuULWFOeJhWlREWhtGDmudilnliRpkblC0MHgo37iBLafyiClO+ySg8AvUYGBG7J64BX8zP4TTNMa8htpzE5OG4oup9WVTOSnFm/VAjTGago5j+hTWfw6g3ybjyEgk3JZE0BnTmF7oavtgp0Ok4wIb5U5L9MmJCx8IJSYxewJ4Xy1nw6/pWj4guWciV37l2lE2M/GOKJoZDyGNJRd/QcRA2tEz2cwDxzuJRXbSE0vAOaGKX04zqCcX9YrJpqQJZ1Godx5K/fc64gX/wPMddWNSH+ZDapDN+VHNDCSO/qEGhrhHgEPiAcdcpODb6KXhv8Z5lKoYddoGy68lP/Ads95zdXs0NLffrYZnjImRYWjenqHpaP24Q0fi5JMKJbG2xP+55AqCg9ueva5WRXPyQrxRCKpthcUffT19h4E3wNFx9rrcUr5JeE8AcmfN8l65SRfKlTDN/JlsHrLN6Q4djUWJZd6F+SvOAvYVhtxTNGLeqnik=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce397bb0-7c6b-4f6d-b96a-08dba382cc21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 02:43:56.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPdMM2z7GZob7P7vW+VbQTNIuHsS/UCZIc6UGtWKHLbOlAF64vXm0hmmBWCB2MClYu6QPTJNLBeHQddUYCn+es2lAI1vi2fR0BBnV+F83/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8673
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMgMTE6MTMgQU0gTGkgWmhpamlhbiB3cm90ZToNCj4gDQo+IEEg
bmV3bGluZSBoZWxwIGZsdXNoaW5nIG1lc3NhZ2Ugb3V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPiBpbmRl
eCA1NGM3MjNhNmVkZGEuLmNiMmMwZDU0YWFlMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGUuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZS5jDQo+IEBAIC0xNjEsNyArMTYxLDcgQEAgdm9pZCByeGVfc2V0X210dShzdHJ1Y3QgcnhlX2Rl
diAqcnhlLCB1bnNpZ25lZCBpbnQgbmRldl9tdHUpDQo+ICAJcG9ydC0+YXR0ci5hY3RpdmVfbXR1
ID0gbXR1Ow0KPiAgCXBvcnQtPm10dV9jYXAgPSBpYl9tdHVfZW51bV90b19pbnQobXR1KTsNCj4g
DQo+IC0JcnhlX2luZm9fZGV2KHJ4ZSwgIlNldCBtdHUgdG8gJWQiLCBwb3J0LT5tdHVfY2FwKTsN
Cj4gKwlyeGVfaW5mb19kZXYocnhlLCAiU2V0IG10dSB0byAlZFxuIiwgcG9ydC0+bXR1X2NhcCk7
DQo+ICB9DQo+IA0KPiAgLyogY2FsbGVkIGJ5IGlmYyBsYXllciB0byBjcmVhdGUgbmV3IHJ4ZSBk
ZXZpY2UuDQo+IC0tDQo+IDIuMjkuMg0KDQpSZXZpZXdlZC1ieTogRGFpc3VrZSBNYXRzdWRhIDxt
YXRzdWRhLWRhaXN1a2VAZnVqaXRzdS5jb20+DQoNCg==
