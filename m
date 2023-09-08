Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0C79826E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjIHGhN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbjIHGhM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:37:12 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 23:37:07 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0819AE
        for <linux-rdma@vger.kernel.org>; Thu,  7 Sep 2023 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1694155026; x=1725691026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOH7NJ+EptC9xj1sfI8xIq2DDnDu7P2cTOfvEX86m7Q=;
  b=k8VaiBc+kbl8wX/rAq8fW/+At/fWyb/8JwWytLtZ5jMeyuos4Ie5+lY3
   cKEzXVtENadGeh7A9H0tVdufiw5cF63FEklmVUDIjGrvFDzK0bQ1firpT
   4URGhbPNyE+PqYf+9Kdps/fqSC6orrmHmsxDWlwZZQeq2RCieik1Htlif
   OtglB+t2T+rFcs9F53WgEJBaixl0OnbAnr/XhETvSv+KqusrMZiIO7jMD
   8cV4TxquqVaBe9GvL+CefvV4R/A+Awb2fN4WtsC3Mv7hwlurkmnQ9oIxf
   uftNmcnbmlfY/0j/GhjdjjtMaY+Gc8u6GecpY6ZfstDYd3R/1oFUA2Ru8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="94486395"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="94486395"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:35:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f880beAR9bUrEUDviQdSU1rM+Cj4tU1jMRbTgxzKme5jcJthRjpGFCy/4svwbpG1g+U+7+3HWwsEjjqbCqGa4EOeyp5Knqjql/t3OfZ4PmUTICIi4g3EJRBP/N8mxvymK+RlV74GcRGXdkX0bls4ksk62qtNj5vXhcoa3ROXFz3a+UzQY3B6J9NloenQEJ0lCCrRJGgufO95/jDM58F3/p8viY0+nsM9kEtScs1FdNRtMLPOeHvvgqK7AGNdnuF7tzL2D/nmWHtyEyCvwZwoKrjuodhHELy7DKqbQygM7vbNEttnwp9MW5Hq7zyJtzmvY7o0obSfhSJbD2ZkOCL62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOH7NJ+EptC9xj1sfI8xIq2DDnDu7P2cTOfvEX86m7Q=;
 b=Aqy1hAr1hkswO+pD3UZzPCgMKCI+knOX37CkZStGt77197iLWeZCojqu3LxYrswip1f8D73ZDpGnXnsnMKXF+KnRkXKGE+iyO2ThKee/R5MQn1LuKIVMitcwbbuuO1SrA1GAsQJP2siT6RscHQp1IEuDajEDhcWjAmSBDWfCZvhshl0xdImkPHgucj18zCAdOy9I3LKTF5WVLMrQHTSaTazFUDXW9rRc0x0GnhEmBS+MDkU2JkSe22uLUFQlzKpiLn3A1tfMDmiKpUUdV0mYFBWFvWRWQYIWJ8mdzWGUp05Wv0cDF6lOvVOrosJj6/4u3iS8znhzM6Vyyx5knANmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYAPR01MB6122.jpnprd01.prod.outlook.com (2603:1096:402:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 06:35:57 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 06:35:57 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "'leon@kernel.org'" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Thread-Topic: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Thread-Index: AQHZiWHk3vu0fY0WZk6pKVA05y4OS6+HgXaAgIggEaA=
Date:   Fri, 8 Sep 2023 06:35:56 +0000
Message-ID: <OS7PR01MB11804464EB36E9E9FE02CA59BE5EDA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
 <ZIdGU709e1h5h4JJ@nvidia.com>
In-Reply-To: <ZIdGU709e1h5h4JJ@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NTA2ZGU5MzktODE5My00YjMwLWE0MzMtYWIzM2RkMzhh?=
 =?utf-8?B?NzI0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0wN1QwNzowODo0N1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYAPR01MB6122:EE_
x-ms-office365-filtering-correlation-id: 2542cfdf-7b09-4953-3202-08dbb035dbac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JT3G2dJh8OXJxavt37dDKXcxFanIyar9rJME+rTBoXdFjBa1BrnLwmM/mn9rK0MdL/jQQQIM47AvXrhwDhZ82pncHc+/JDu+fxxU4J9G3P/9O89ivtYII0yWKe6/6I75yIVd5qPcmj4VzBVL8WtZrfGQ4CMaD1lRIfoX9mSjzX3hGTmOzwRnQoKFGNN7QNgMDltEggiraIXqbO5kW29fCCpqoSH4MXOOE652WZ+bJ8G0epuaM4PVQ7iJWoa1DwAg5vsZwgWzIrGt7vxiETVYIgbDZeuHYWaqVTPFdX3oJVo7d6Q3NJhJ+hN+oQi21lLkiqxPkV2liAdww5b6vki+EXEXxR07zgXHe3VndiFnm6tqZ0zB1vALZ57VS6b00RVCYMVA16y2zRvY1ABUeAgDFjFGAZUvw40G9QeSgbpq6hg/Rq5iIKILW26Vyr7lzZnJGbMN23qj70NtQAoWfpyz8/Qd1eTe7AtWEZGdaa/hPbV0yeYZhdTLfxYjMUUycVrs4mLhOMk7SXOfrti6p18K/nw5Xs7yfuD+AFYw/Bx0fG/A8+daUzG4KN4N27qagAd/8WSUZf46aTLyegzlXzh4XPd/kDCPilnIrsXmBKRqR2OZRRTjL8SAZL3B1u6N/CBwgTLbf4a0FfcK43+6dqW3Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199024)(1590799021)(186009)(1800799009)(1580799018)(71200400001)(6506007)(7696005)(53546011)(9686003)(83380400001)(76116006)(107886003)(26005)(478600001)(2906002)(66446008)(64756008)(6916009)(54906003)(66946007)(66556008)(66476007)(8676002)(8936002)(52536014)(41300700001)(316002)(5660300002)(4326008)(33656002)(85182001)(82960400001)(55016003)(38070700005)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHVrOFIzSWJFZ0NnQm1nNHkrQkRDclZzd0lXdFVFcCt2UUY1ZUdVMzJyWnV5?=
 =?utf-8?B?aHVkS2NlQytuQTFORlJabStGb1l2THpiYzlIcmE3UEtJNkV0UUxvWmg1Rm80?=
 =?utf-8?B?RmhmZVlWd0ROSEJiajA3SXNpWVpRWTdwTVU3N3FJNyt2TWJ3VVludFVRMHVw?=
 =?utf-8?B?K2VTbWorano3RFZleGR6eFo1dlcyYUwzSks0Y1E1VjV3azhGTHU3QnNhUkc2?=
 =?utf-8?B?b1gxdWxoVTdKYkhKK0N6MGJTdEpDR0hnOVVwTWdUWVc0bitxanFYaHF6aUwv?=
 =?utf-8?B?UGYxWlVUd3hieGI2cnVFSUxFK25JQWtVb1BVaEFEdk9kejI0bmNXMjMzTVNl?=
 =?utf-8?B?eXBUK1RpamlMSnZNLzZ3YkduNW1ScnMwTlpJNlIzTGF2cE9uMnNaWVpOMnpR?=
 =?utf-8?B?V0dZbk02ZHZNSmdjTWdtSks4Ym5Eb0JrWTVodVFSaXpjRU9DVHpBd2Z1TEds?=
 =?utf-8?B?UkN2U0hrcmF3aktTcTdGMVU2S3hyUEtSek9PTlIwSHF3U3dMa2xJcHJmbjc2?=
 =?utf-8?B?VVd0TW13aXFrcDZCL250N3QzVGdsbDNWZUU2R3hKWFl2dTBuZ1BMaDkwMXRu?=
 =?utf-8?B?cFl3eTlMUkF6eW9rcGJQRzkyRXRTTEIrRFVwNEZROFBZWXdyMldqTnJZS1Jw?=
 =?utf-8?B?b1JJR3J1Wk5mQWlzWEw5c1c1TnVVdmFscG1nc2k1alBjcEU4cmplMUZmaXdv?=
 =?utf-8?B?bjVaZUtxYmN1MEVRd2orNi90Q0FKT1BiUDNzYkl1M0N6UzZ0NXZhZ0RUSjBE?=
 =?utf-8?B?QU9pZU5GNmsrVWdoNXBYUHFPZVdxdkYxVTk1QzB0QmpWMGpYMEdUNDc5dE9q?=
 =?utf-8?B?b05IdEhXQlJLUVBXeDcyZW5zUkRQVW9pd3JNeUtWZUs1RTN1ajdieGI0Wm9x?=
 =?utf-8?B?Z0Zkd09FSDVjeHhjMjJXWGdaNlpWSm5aUkl3RmRibXpqcGRDRiswcFRqaGtw?=
 =?utf-8?B?eTR4WGF6MHcxaGg3akpzQmtDbi9WcEQxdi9ucWpXaEhSTkN5aktQZzg2cXFo?=
 =?utf-8?B?YkFVZWxxVVlDNFJoSnBSTHhFSlhaR3lualdFaEhrTkJJRGcvZ2xxNGw5ZkVa?=
 =?utf-8?B?a0RBY25uV2NmaFlFY1M5WmZ6cE14c0NiSWczWXNJSXBmMzlrT3JPSVo1MFpu?=
 =?utf-8?B?NmxHZUYyMExEOTRMOHU2dmlEY3BKVVppUmV5OXhOdGcvYjByVGNzTzB0QjBZ?=
 =?utf-8?B?MEtzdUJVMjVYMUdrSFdDN1AyMGhValQ3aTEwWGZucHZaanJrQ1hrcUtnUi9h?=
 =?utf-8?B?UkhlZ1QwaFZTdjJUd3dpcWIralNmQ3NsTmsyek41ZUNNWmRFc3Q5MW1peHZs?=
 =?utf-8?B?b25VbVBaTnJQczAzL21CVTNxeHN2aWtPUmE4Q2UzZTJqMnBOaUcrMWNWRVF5?=
 =?utf-8?B?bzlLTHdJTlI2anpCOWVNaGg5a1hUN0ZtZ0Z4YkpvWGovL1c3b21HSTZrU1ky?=
 =?utf-8?B?ZzhqSEQzKzlUa0Z4dHJReUlycUtuaGRjbGJua3lyNmJLQ3A3dkowTmpkRmNU?=
 =?utf-8?B?TmVIREQwTDdjTDlvam1xRGFsek1kWFA0TVk2TzBQUS83aG8rVm5NanpyMU9M?=
 =?utf-8?B?VEVuWGkvOGc4RXpMYjQzWjJkNVhFWEx4NXNqdWRackJROTN4aW1HRDlZeFd1?=
 =?utf-8?B?R3pGZENEOHhralJReW5HK0FzbGFlSnBsakhLbS9OMWFKY0hQS3I5WGVITFRq?=
 =?utf-8?B?N0h3N21yTmlrbS9pSzY5UTYxdjU3WVhjT1VmOStFRFU5anpyOFdkemZrcG9E?=
 =?utf-8?B?QzNDRkRJY0c0TEY4U3ZQazZpcmlQMThJWnNPWjFsOEpOQmFuSHFQZndLUmQr?=
 =?utf-8?B?aU1XR1FNUjJjOXAva0dmMGhIQ0FLMjNXcXdHVHhaczZnYlZZZFdHdm1aQlFU?=
 =?utf-8?B?bTRXVkduRTh0cURUTWpWckFMMXRzYjRnNUlDNE54Qk9JL3dTQ1MycVF0aStI?=
 =?utf-8?B?cVNhRVQ4K3JYeWtpMUFyNjd1WlBlbDVKZW1va2luaVZaMFNnWktxQTVNNkFs?=
 =?utf-8?B?eVVIdFR5Z3drWllFZVpLVktSME9CWGNsOXNzWHkzbnhrNGMxVUMvc0tMUmNS?=
 =?utf-8?B?djR5b3NjVldCME1QUkpSbjNWa1BVbjlpSGlwbXpubW5YRG56UjFKbUpkVlpw?=
 =?utf-8?B?YktDT2NvZTdON2ZuYjluNkx5TGxXQW9jU2o0VUdlTThGRjFCUnIvTDVUWXlD?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gDKnZYkxBo5HwBxzSdAg7acE51WnK62lM7CMUv04oIaT5DBkJrSuIQPstydyROd/lHnCbMO2k2Gj0Lfnt52ia466b0+L/9gmwoKXzsdLj8BuEwauW2KJt3JMlnpTvtLQ3bmzsrA5sESfm5VcSFBxU67ZAX1lhKzbU0DdXG9g7plFFFWnccO8BdBHmaaWBCGI141m1IOq0pAZ+e3QrWe/z25Ky0VMb5dS7hT4NQXKiiKX/acXY23IWvifgpxfIweAxvbSKLcGDRY4xlgiVnLY7sh9i3nQY/sTbUIibFgph/JJtLIVzpXxbWC9pdDACnFeLI2g3MT+njx53coTWSMIczIN/zTUYK2+/lE4FKq9I0JVsNiCrfXm4+uJYStmYpGvwonDFZCXKMCpsSjbnRSn9hCLFFBUeWxitxX9De20TKmfeSk3F1Xp5bSX0TbqLbuUB0e4xKdayFotlMreVRCq0nEi6AJaVMxUFokIppvsIyuDzCJL32pfDxgTqLIzw6yd9oigcElaGIOCw2IlKJwm2GjXHCJ9OJL6Ug28mssv7+Y7lnVOtSZg+Q+FID+oRCGBs8azUuO3WpAtXy3ImoJsl+blmtQFp42ueucIRKFRacQtHt7tBczLP1cyapZD48nYrIYEF5Ou/1P3VtFXg8rKSmO7qJZOoPludOwZPtG3nxbaJfZf5e0sHYvNS4lcZoacstT5fKodfmKv/1ZKfW4X9FaARqeBlEuUbF1snESJx3OcIaalC3kh/O4PhqD52JKtlbinIri+rWO8jQhwsZvSgXdsA2V7LzhhORnASLUqDonOTWh7vOiWWq8PTePnipYFMNFcHvoRDn2nwWFnaFCcsTiF89KyrUrUf5hhLY4EYkw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2542cfdf-7b09-4953-3202-08dbb035dbac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 06:35:56.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YseGHyHB+ixLXgALE4iJ7UWC/cOaqWhxyT2v6VnVf5dBHchNjovVxRSRIMkwcRJbFSNi/43RBqpAS73CVWYjj4x9q5YxSvCAwpHxSZCU7Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6122
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBKdW5lIDEzLCAyMDIzIDE6MjMgQU0gSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBP
biBUaHUsIE1heSAxOCwgMjAyMyBhdCAwNToyMTo1MVBNICswOTAwLCBEYWlzdWtlIE1hdHN1ZGEg
d3JvdGU6DQo+IA0KPiA+ICsvKiB1bWVtIG11dGV4IG11c3QgYmUgbG9ja2VkIGJlZm9yZSBlbnRl
cmluZyB0aGlzIGZ1bmN0aW9uLiAqLw0KPiA+ICtzdGF0aWMgaW50IHJ4ZV9vZHBfbWFwX3Jhbmdl
KHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IGxlbmd0aCwgdTMyIGZsYWdzKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgaWJfdW1lbV9vZHAgKnVtZW1fb2RwID0gdG9faWJfdW1lbV9vZHAo
bXItPnVtZW0pOw0KPiA+ICsJY29uc3QgaW50IG1heF90cmllcyA9IDM7DQo+ID4gKwlpbnQgY250
ID0gMDsNCj4gPiArDQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsJdTY0IHBlcm07DQo+ID4gKwlib29s
IG5lZWRfZmF1bHQ7DQo+ID4gKw0KPiA+ICsJaWYgKHVubGlrZWx5KGxlbmd0aCA8IDEpKSB7DQo+
ID4gKwkJbXV0ZXhfdW5sb2NrKCZ1bWVtX29kcC0+dW1lbV9tdXRleCk7DQo+ID4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcGVybSA9IE9EUF9SRUFEX0FMTE9XRURf
QklUOw0KPiA+ICsJaWYgKCEoZmxhZ3MgJiBSWEVfUEFHRUZBVUxUX1JET05MWSkpDQo+ID4gKwkJ
cGVybSB8PSBPRFBfV1JJVEVfQUxMT1dFRF9CSVQ7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAq
IEEgc3VjY2Vzc2Z1bCByZXR1cm4gZnJvbSByeGVfb2RwX2RvX3BhZ2VmYXVsdCgpIGRvZXMgbm90
IGd1YXJhbnRlZQ0KPiA+ICsJICogdGhhdCBhbGwgcGFnZXMgaW4gdGhlIHJhbmdlIGJlY2FtZSBw
cmVzZW50LiBSZWNoZWNrIHRoZSBETUEgYWRkcmVzcw0KPiA+ICsJICogYXJyYXksIGFsbG93aW5n
IG1heCAzIHRyaWVzIGZvciBwYWdlZmF1bHQuDQo+ID4gKwkgKi8NCj4gPiArCXdoaWxlICgobmVl
ZF9mYXVsdCA9IHJ4ZV9pc19wYWdlZmF1bHRfbmVjY2VzYXJ5KHVtZW1fb2RwLA0KPiA+ICsJCQkJ
CQkJaW92YSwgbGVuZ3RoLCBwZXJtKSkpIHsNCj4gPiArCQlpZiAoY250ID49IG1heF90cmllcykN
Cj4gPiArCQkJYnJlYWs7DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgbWFrZXMgc2Vuc2UuLg0K
DQpJIGhhdmUgcG9zdGVkIHRoZSBuZXcgaW1wbGVtZW50YXRpb24sIGJ1dCBpdCBpcyBzb21ld2hh
dCBkaWZmZXJlbnQgZnJvbQ0KeW91ciBzdWdnZXN0aW9uLiBUaGUgcmVhc29uIGlzIGFzIGJlbG93
Lg0KDQo+IA0KPiBZb3UgbmVlZCB0byBtYWtlIHRoaXMgd29yayBtb3JlIGxpa2UgbWx4NSBkb2Vz
LCB5b3UgdGFrZSB0aGUgc3BpbmxvY2sNCj4gb24gdGhlIHhhcnJheSwgeW91IHNlYXJjaCBpdCBm
b3IgeW91ciBpbmRleCBhbmQgd2hhdGV2ZXIgaXMgdGhlcmUNCj4gdGVsbHMgd2hhdCB0byBkby4g
SG9sZCB0aGUgc3BpbmxvY2sgd2hpbGUgZG9pbmcgdGhlIGNvcHkuIFRoaXMgaXMNCj4gZW5vdWdo
IGxvY2tpbmcgZm9yIHRoZSBmYXN0IHBhdGguDQoNClRoaXMgbG9jayBzaG91bGQgYmUgdW1lbSBt
dXRleC4gQWN0dWFsIHBhZ2Utb3V0IGlzIGV4ZWN1dGVkIGluIHRoZQ0Ka2VybmVsIGFmdGVyIHJ4
ZV9pYl9pbnZhbGlkYXRlX3JhbmdlKCkgaXMgZG9uZS4gSXQgaXMgcG9zc2libGUgdGhlIHNwaW5s
b2NrDQpkb2VzIG5vdCBibG9jayB0aGlzIGZsb3cgaWYgaXQgaXMgbG9ja2VkIHdoaWxlIHRoZSBp
bnZhbGlkYXRpb24gaXMgcnVubmluZy4NClRoZSB1bWVtIG11dGV4IGNhbiBzZXJpYWxpemUgdGhl
c2UgYWNjZXNzZXMuDQoNCj4gDQo+IElmIHRoZXJlIGlzIG5vIGluZGV4IHByZXNlbnQsIG9yIGl0
IGlzIG5vdCB3cml0YWJsZSBhbmQgeW91IG5lZWQNCj4gd3JpdGUsIHRoZW4geW91IHVubG9jayB0
aGUgc3BpbmxvY2sgYW5kIHByZWZldGNoIHRoZSBtaXNzaW5nIGVudHJ5IGFuZA0KPiB0cnkgYWdh
aW4sIHRoaXMgdGltZSBhbHNvIGhvbGRpbmcgdGhlIG11dGV4IHNvIHRoZXJlIGlzbid0IGEgcmFj
ZS4NCj4gDQo+IFlvdSBzaG91bGRuJ3QgcHJvYmUgaW50byBwYXJ0cyBvZiB0aGUgdW1lbSB0byBk
aXNjb3ZlciBpbmZvcm1hdGlvbg0KPiBhbHJlYWR5IHN0b3JlZCBpbiB0aGUgeGFycmF5IHRoZW4g
ZG8gdGhlIHNhbWUgbG9va3VwIGludG8gdGhlIHhhcnJheS4NCj4gDQo+IElJUkMgdGhpcyBhbHNv
IG5lZWRzIHRvIGtlZXAgdHJhY2sgaW4gdGhlIHhhcnJheSBvbiBhIHBlciBwYWdlIGJhc2lzDQo+
IGlmIHRoZSBwYWdlIGlzIHdyaXRhYmxlLg0KDQpBbiB4YXJyYXkgZW50cnkgY2FuIGhvbGQgYSBw
b2ludGVyIG9yIGEgdmFsdWUgZnJvbSAwIHRvIExPTkdfTUFYLg0KVGhhdCBpcyBub3QgZW5vdWdo
IHRvIHN0b3JlIHBhZ2UgYWRkcmVzcyBhbmQgaXRzIHBlcm1pc3Npb24uDQoNCklmIHdlIHRyeSB0
byBkbyBldmVyeXRoaW5nIHdpdGggeGFycmF5LCB3ZSBuZWVkIHRvIGFsbG9jYXRlIGEgbmV3IHN0
cnVjdA0KZm9yIGVhY2ggcGFnZSB0aGF0IGhvbGRzIGEgcG9pbnRlciB0byBhIHBhZ2UgYW5kIGEg
dmFsdWUgdG8gc3RvcmUgci93IHBlcm1pc3Npb24uDQpUaGF0IGlzIGluZWZmaWNpZW50IGluIHRl
cm1zIG9mIG1lbW9yeSB1c2FnZSBhbmQgaW1wbGVtZW50YXRpb24uDQoNCkkgdGhpbmsgdGhlIHhh
cnJheSBjYW4gYmUgdXNlZCB0byBjaGVjayBwcmVzZW5jZSBvZiBwYWdlcyBqdXN0IGxpa2Ugd2Ug
aGF2ZQ0KYmVlbiBkb2luZyBpbiB0aGUgbm9uLU9EUCBjYXNlLiBPbiB0aGUgb3RoZXIgaGFuZCwg
dGhlIHBlcm1pc3Npb24NCnNob3VsZCBiZSBmZXRjaGVkIGZyb20gdW1lbV9vZHAtPnBmbl9saXN0
LCB3aGljaCBpcyB1cGRhdGVkIGV2ZXJ5dGltZQ0KcGFnZSBmYXVsdCBpcyBleGVjdXRlZC4NCg0K
VGhhbmtzLA0KRGFpc3VrZQ0KDQo+IA0KPiBKYXNvbg0K
