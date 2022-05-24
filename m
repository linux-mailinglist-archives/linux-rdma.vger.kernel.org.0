Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9854532B19
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiEXNT1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiEXNTR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 09:19:17 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16359968C
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653398343; x=1684934343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kqcgTQDkJzykiytbHvqgVx94bowcmTeKRKMlHEFBnw8=;
  b=eMDy3UIW+Jz3Vi8rbr++1rmhtJBQO4FetCbPYNH45d7jYw4olZs1ESKB
   PHbB7sCm7tLMXcJbJKi32FsayhWWyQ+D9jjQ3LtCUVynriTDQWaAauPaF
   gw1xubNg4qmc2jBF1fVNu1/2P5Mi5e5I3c4+DaSmCbZLgp9mzgduAV+jw
   XjInp0SiWstrRhV5iFvRrXczdfTb+1A162/gy5AsoF5xcZws4w2cxZMH3
   64s9Ph5N5HmviHzgSQPTj80ESN8nf4x0WfO1aiS1vDsYqn+q6yK9TUo74
   X8EfH7t2sqLLiVcZhd+5l6yuzsqQwWvO7IQhgzd/vwX7dAhQDZH1zr9to
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="56638236"
X-IronPort-AV: E=Sophos;i="5.91,248,1647270000"; 
   d="scan'208";a="56638236"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 22:19:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia185UbHYaV2qw25TdckTc/3gj6Q6x7sBcBFrZO9OtUtj9/lRZrdvEhP4YnpV6vHyoiGz9GAOOFrHc30Na6VdO99xKo7bOH5e9OKKf87Y/+LzKg5+QzCwelxPAHehJjsycUjkkQbOiScGbKmJ7S5BkSEWbUSbu9jOkVjTOzHx4S6blNOghhuFtwH5QqvRJp5Tq7SDeaYobtJVsYRLAKO7MFrVqNG8vSPWzXeZBgxbJcFoAd2EmoHPuBHO2AsL+sqCO/vTbBxpXunQxa5dsjndVfypW0btARvcpqldDDuhBtukZ++0ZjF+V7SUvWJ8CvO7BsI3I48rvAafD5E/GA3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqcgTQDkJzykiytbHvqgVx94bowcmTeKRKMlHEFBnw8=;
 b=ML0oB33on7n0uEDTDDxHcmz+pO67bBAJcMjUEEn7UxCDbDWlXjJow4pob6P+FtweERaHlx64U104RM2IZadXRTpFaSkWH3PZbxDBsO9d6AOplkM3WyO8bBNdryDltgnklKEjgvf7LOzIG+ns9+0Sll7qLDl+Qce3cDOx4+PPAIVXJHu7Tf4B9QvyqNsnhKuNzzyfKZZhfvEnUMK78dmh/yoNYFviXFV9W/sjBLq5k258+R3xRKttpv9zgp7/QQDGnJt3fm7fT2tMoAxYVX5V68JIar4YCVh4hthoP+o5S31EoX8XqgFy65wnvemINr+XcuWnl6EPCJJ1fsl4t4SflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqcgTQDkJzykiytbHvqgVx94bowcmTeKRKMlHEFBnw8=;
 b=UwrTOInuUaKWz28wQetsNEXTxo5ZFmLrqYw320tu4HmFwbBk7CzJZ0wM4G7E1Msmkhpb+BEGJMIDxY4V3TYP+qjm6hVy7FCqEvvIIX7eTIN/q79eLh2C6fdqFTpmV0UyawFHClx41bcFeqmv6hG9Rqk4oUtxq6mLVTHcevg43Ow=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB9302.jpnprd01.prod.outlook.com (2603:1096:604:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 13:18:57 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930%8]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 13:18:57 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: null pointer in rxe_mr_copy()
Thread-Topic: null pointer in rxe_mr_copy()
Thread-Index: AQHYTVUc6Php4HPWmU+teIHR8aj8P6zqK1AAgAAFmICARBYQgA==
Date:   Tue, 24 May 2022 13:18:57 +0000
Message-ID: <84888208-ac2e-115c-43d5-2ef211948c78@fujitsu.com>
References: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
 <CAD=hENdM=VEF4MM_L=W1PtiX=x2s_kucMLc41WWmK-6c6s2Nrg@mail.gmail.com>
 <CAD=hENet+KQe35eqXabM+EpucHh3mYypUo4H8S-XmwNPcOv4+A@mail.gmail.com>
In-Reply-To: <CAD=hENet+KQe35eqXabM+EpucHh3mYypUo4H8S-XmwNPcOv4+A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d4f7913-bdfe-4910-012f-08da3d87f554
x-ms-traffictypediagnostic: OS3PR01MB9302:EE_
x-microsoft-antispam-prvs: <OS3PR01MB9302C3809623D12A5A2C139583D79@OS3PR01MB9302.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMCuy6+czBPsYef1Nf6xo4UgRjn/Go8X6wflVOujGuIq+tUAWotWMDnjvh8++Z66JH4QLD/QWx9qEdr7vbt+FaC1N9cz4yJ+dQIxCn6v/AVsbL5GiOR6ht/0rCQeuEOLYF+AGalxRvsgBbE2oXE3Q9JjArHXSvAayIdQ9Y5WSzjaATNSewR/u2cMcZfHQsFLTfh7YQ0vf40pl7+GlQK5/PuDD2ilj6h2sZ8rIyjt5L0pR/xBFjp8gh0ouNfI935MTlpCiE1USEuz5na91TysShx6EPxC+mZKhKW7tDHooAn77k2sj6ntBx0nG6XO6ILpAma4Pf8z5xvA9R7ugftYX7UNTau3DtX594dzaR/qwbbhra6bxnw1Ms0j4rfkwnZmwXP4YuetfEhoI/U2o8XXWplmoHEAh3XnWhxnMC21uM01lpNg+XGn9Aj1oRXit22rg2FDCP7wlbGi3vrwLXnTvOSYIr0y7gCYYkpty+sDungA7vp0EFwVR+oiIQgJGRUizHSl3Ed0uzYmv/E4AfK5i+S7mWNPrSrfQxkagnUIzYAPM+Z4CCu61C6XRbMcjYtKTRJZoLOu/RS49wtER3huDNQA3ausCCS02e0JAumUo8ADpLuPeCTdLdq8Bbk97n8RqHc1Fw5QwpMoYEdaePd1K4O8R8+LE4NbyFkl7bdL8chNmw0km2WHXGirjBObqmXccFI8FsJHRRx3oXcoTU0t1PQoCgvmrOhRGiNOM234k5TCAQK1NWKk2wbsYcSNfCq9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(8676002)(66946007)(64756008)(2906002)(38070700005)(38100700002)(122000001)(91956017)(82960400001)(76116006)(4744005)(5660300002)(110136005)(8936002)(66476007)(66446008)(86362001)(316002)(6486002)(31696002)(71200400001)(6512007)(508600001)(186003)(6506007)(26005)(31686004)(53546011)(36756003)(2616005)(85182001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzlHanF5L2hOOUgreXlnYVhnL00wVk94NVRUWTJxLzhRbFVDMUY5KzlmYUlM?=
 =?utf-8?B?dnpvVHhqeDJTZkc1STZka2xESm9tU0FFR1hDYndOZEphTlplS1M0cy9NWEZD?=
 =?utf-8?B?WGVEUW50YUE5Nmh4WU5iN25aVTJ2a2dFK09xSStPbTc2cUZNdFpRbzkvNFpn?=
 =?utf-8?B?ck5kNkQ4QTZ0YTlEbG11Ui9hRmh1RmpmR0tWS0piN2lmY05EK2dpaW4zd21Q?=
 =?utf-8?B?cXpRZ0NFQ2N2Sk15dkFsU00zMnFTYXRRSEdQWjlQTm1BTDBEUnZhOElmdHJl?=
 =?utf-8?B?dWtObG0yenFVQmR4ZU1JQWpYSUNobDdBaFdwbWNiUlJyaTl6Ky8wNUZYUjc1?=
 =?utf-8?B?dUNJZVBBTFdhN1hzZmhhVkl2TWxEZHp4ZFdYMlRiVXRRejVUVXhzVnIrcTBW?=
 =?utf-8?B?Zk1VclZVME92SnN1a2lFSkJ6TlFuYit6MEVXckE4T3ZxMWllTCtnckRHNFFl?=
 =?utf-8?B?cFY0dGpRZWcyR0FsZGFzUisxNnFiRzZBT0FJQXBCL29HKzNid3RjcnZVbld5?=
 =?utf-8?B?MnNOZkgrZ1Q4NUZaeVRQZXpPTVRBUDVWZDhwZlE1NGhINkRGaWh4TUR3bHJV?=
 =?utf-8?B?WlhtL2svT3QwQmFMOEl3SUk3TWxTcE5uUFVIc1djc0hvdTJkaHhoQThRSlBE?=
 =?utf-8?B?eTBRQXlQT09vaVJPaTNuazJ0UEVhRWJ3T2lCUDNRVHI0cW9tTy8wOUsrY2Zt?=
 =?utf-8?B?TVBLVDg2VzVoTEpMNW52R1VISFhrTU1VbzdzMDdDY1hZcFNoNHJ5SW5WQ3FB?=
 =?utf-8?B?aU01bGpRN09HallDb3lRWEZQMWFycWk1OHRzUjQ5OVdTRThuY2NtcU42S0RJ?=
 =?utf-8?B?TzFGYXk4QS9yRDgybFFmTnZUTnpORi9JT0JsZS9SM3B1MHdqRnNLYmhpb0JL?=
 =?utf-8?B?NThzL04rd2d0QUlEUE5ZdUN5a2RsRXRwTUljejFSZ0lWRS9UUHhqTFh3cDhn?=
 =?utf-8?B?NncwWmQ1bVFPaVpOK3d3WSs5eWF1SzRWbk93ekJsb2pZM3N4YlhEUklvYnNZ?=
 =?utf-8?B?a2RTSWhJM2JPeUoxcmtjQ3I5S25UbFB2bm9nSW5SOEZpdUlGSEozYlBtcUl6?=
 =?utf-8?B?K0Q2SG8ya2ZFWFVuVUNOeXF3S0JDZUllQmVVeVNpeHBVUUF5OUg1YnJ4bUZT?=
 =?utf-8?B?eG01R3djaVQ3ckZiUFdjbHd2emp2KzR4Z2E2YXZ1ODRQSC9hampZZnRkdEhO?=
 =?utf-8?B?NE5kOUVTbi9kWThrdys5RnJYVXNSM1Y0cWp3bTU5SXFabHlISGNJRERMZTFC?=
 =?utf-8?B?bW1QdXFYaSs1bnljdU1oaWFOQk56djFNRVBacTRTUzhlTFpTcXNaN2lQWklU?=
 =?utf-8?B?WWJSZHF0SnpDWXFwenVmaUtmckl4YlJPL3NHSWd3R0duVHF5akFoMmZEaUpN?=
 =?utf-8?B?R0VXTE1wT29FZlAwRldHTGRQeU5OZlFWbXNldndwcEtHdmtJT0Q5TTB6bVla?=
 =?utf-8?B?aGRmZFVqR1JGazJjRnBwZHJXOFo0NGdvSDc2NUEreHlZVkw2cVhnL3hqTXhP?=
 =?utf-8?B?K25zZVBtNENaY254eHNFaVl4UzRINUkzMHZDYXBQTy9ZR2wzaVhydHZlNEdR?=
 =?utf-8?B?N05wQnBXQkN5NFJQMzNOZG1mWnNibWt3YjNpWHFPS1lqd3Fpa2ZTckdJU3VD?=
 =?utf-8?B?SEhRa2xYS1NMajVEeUJPVHErbHZ1aE54NmVvZzEzUDRkNVdmVW9IUGtia0JW?=
 =?utf-8?B?NmRKdDBtS04zYXdFREMwOCtINWNjaTdOczYwV3Fpbld5eTdRdjVPWDdOaWIx?=
 =?utf-8?B?WWIrWGduNjA3RWE5c2xMZ3I4SjBwTE45OEtHdHBhazdGR0lnOXFVQkdGdmhw?=
 =?utf-8?B?RVhhdzVaNU1EWGh2UHNsVTFVL0R0YVRRc1RhMmpudzlUYVpBN2JXTHBEODNV?=
 =?utf-8?B?cXZNenVnYm1GTjVnQXdLS2dNdkdzTUhzbFh2eWd6QWMyUjNRTXVLU2llS2d3?=
 =?utf-8?B?dE9tN2V0UEs2cWZVMVptU2E4cjN1d3U3RXl6cU9JVFhLd09BTHVZMjh4RjBr?=
 =?utf-8?B?NUZ4L1NrUHRXRkgzN2ZBTmxRbERFZS9JOXZwUUZhRXA5clVwWUlQckVCbmpr?=
 =?utf-8?B?dTJqUWp4bGV2NGkxWCt5Z1Q3WERWQzB5SE5QVEZ3OHZqcFVUcU1ubFJPSDZm?=
 =?utf-8?B?RkpIY0RLYUxDV25NZzdqVVlBaXVUTFZBN0dlVnRvdDRUQkFuR0xCMVkybWVX?=
 =?utf-8?B?eDRMMk8vZmhsL3BobGJURlhuWFFpSXhqZ1lBajZQdlh4eE96bkpvalB0ZVlF?=
 =?utf-8?B?N0tnYnJmVmpvaytRa2ljRjNvOEZsdm43aVByTC93eHB5cFlJelA5NVhXdHlL?=
 =?utf-8?B?N2xJalFLYkRBdUxXQVhDZ0ZvR284K0JzckZsZnV1UzV3MjRmSzdXeWxrdkoy?=
 =?utf-8?Q?jHMVNL1fJ7IbpcAE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96041B7BD3A4E1429C16214D22B8EE0A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4f7913-bdfe-4910-012f-08da3d87f554
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 13:18:57.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EddmLagvTcVdQ7a5cqRwZmxPtnDaM3+wiFyEQ/zzxH+9t03ZXqDRNyNgD6/Fkwd8ReXwPlkfHxfpMzwbC9riJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9302
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzExIDEzOjM0LCBaaHUgWWFuanVuIHdyb3RlOg0KPiAgIDczOCAgICAgICAgIGlm
IChyZXMtPnN0YXRlID09IHJkYXRtX3Jlc19zdGF0ZV9uZXcpIHsNCj4gICA3MzkgICAgICAgICAg
ICAgICAgIG1yID0gcXAtPnJlc3AubXI7DQo+IDwtLS0tSXQgc2VlbXMgdGhhdCBtciBpcyBmcm9t
IGhlcmUuDQo+ICAgNzQwICAgICAgICAgICAgICAgICBxcC0+cmVzcC5tciA9IE5VTEw7DQo+ICAg
NzQxDQoNCkhpIEJvYiBhbmQgWWFuanVuDQoNCkkgd29uZGVyIGlmIHRoZSBmb2xsb3dpbmcgcGF0
Y2ggaGFzIGZpeGVkIHRoZSBudWxsIHBvaW50ZXIgaXNzdWUgaW4gDQpyeGVfbXJfY29weSgpLg0K
DQpjb21taXQgNTcwYTRiZjc0NDBlOWZiMmE0MTY0MjQ0YTZiZjYwYTQ2MzYyYjYyNw0KQXV0aG9y
OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KRGF0ZTogICBNb24gQXByIDE4
IDEyOjQxOjA0IDIwMjIgLTA1MDANCg0KICAgICBSRE1BL3J4ZTogUmVjaGVjayB0aGUgTVIgaW4g
d2hlbiBnZW5lcmF0aW5nIGEgUkVBRCByZXBseQ0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmc=
