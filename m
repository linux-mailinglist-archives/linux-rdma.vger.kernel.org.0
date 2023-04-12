Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229056DE8BE
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 03:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLBQy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 21:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDLBQx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 21:16:53 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 18:16:47 PDT
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF0449E
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681262208; x=1712798208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c7WWwCk05+nGBGA0TYQLpJZYkESr7V3Wlrm39S/x5rw=;
  b=WW8uN90TDtQlDD4Cn83SkiV5VzT4MuThxC4BMG8NWWwRHG8ax71flGfK
   qPm31t9BE0F8VL3zEZ2jGBjfEvaUSWHO3KGIOPlKsya556QhK5qWZUGi0
   HT16zhrjt6Pbz7/o2mauHsjU20b/7gLJlbY34Ts/KtUQOBOellRnTzjNM
   2tgkCsRPIcMxFSWz7FdNdlsh6S9iFX6pI2ZwWFa0GNI5PQa1jrqLS/xNy
   XX+fgESpBXXVCa3S4YNZu3ZZ5Qj2mAYiM/rFGTap9Lkfqt0M4Zwf76tcr
   Y2sU5NChBPBdOOl5M7WLuN1JpDDJqGgyiy7Z1HtRM4gBktuZJy55KluyW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="81365942"
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="81365942"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:15:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9k16oLdthtSrApDrsqw9y+VGzbff/4BLbOXRaPJbCsbIFq5W7yHVTI/BAFIq0cwMDhOQNpZyok/VmB+i8QOYTwfo3vXD77VsJ6ST/tGwMI3sJ7bG3YM1WAQqmasdQI/c/rJDk4UuA2mpNoynBzrN0sw2lDhjYWDYV8W4QOVOrM7dwaEFtzzWRLnvX7VBIhYmNm69Cb2qIQrK79xyPCnoBd9Zi+QgyvXlq5E2aGhtVqFdxfWfRQ5PZFlAlmJBA2A9qzp5G4g2CBMhXInWic6U9BCVego3Wx0gY/f0KqA+FDHHpEB+uPWp4tFxvYckldqHR4CVaFYtHog/0LUHnNgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7WWwCk05+nGBGA0TYQLpJZYkESr7V3Wlrm39S/x5rw=;
 b=aKvTle8eliATBmyGVy1tGQsVBGPO+s9at70wnV0hfEMPZUvrH4536X81ymZzqebzwonusllkJY4UcBtZ+qv3vZRfiL5xo0DlbIovLzCx+gv9t/rfItQ1RmiaLHOArKja7eh9iqHH+wHwQqb3klfeCaKT46/+9+BMejw0dPVGgVwz9diyJLscvwepfJK6O+2Ld67Miy6Ug1ZG4G+Ty7SwY6CTdRV/GomYSYGuvAKvtRpZJ/RwX3rKVwoAbHBaZn3f1OJwp+O457Md1t90iXUFyEt2nXNBq6BzKgVh01ljCG0xl42uAPeU1Ic3gLiCGcpXM/rc2FnU0sLqv0zRtet3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::14) by TYWPR01MB8495.jpnprd01.prod.outlook.com
 (2603:1096:400:173::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 01:15:37 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::39d5:12fc:889f:d28f]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::39d5:12fc:889f:d28f%5]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 01:15:37 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyIA=
Date:   Wed, 12 Apr 2023 01:15:36 +0000
Message-ID: <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
In-Reply-To: <20230411122651.GV182481@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYWPR01MB8495:EE_
x-ms-office365-filtering-correlation-id: 6709b309-3a2a-4d7b-7a50-08db3af36c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUZH8p16Z1sLrC/Gg6pIEc68BuuLqplF7CMCkb6WQhQWPgFM7qOxiVSO4qehSzx7HSadmpVZcBvLKmEmOIWyq3h+T9aX8JcvcLRqUV9zSSV01SH/IeJuq1mw6CXfYkphEFQjFtqThsXCXsqNvCoQHj/QP2kJJ9OH00G7cwvW4FNkbWHr/v6STOsvq/3rlKmZdqchiVOEbAQiM4nqhfDERxg47qvFOVcPIGJa1yO7jGNzrhFTN6Ko5AuCjaaYcpKAvT70WHp1xwn8RVuuPv95OmFtrVp2SzNKNTzvFnsC0D7un5BSb4hGrEbw8GHqcHbPBPHd+O4sGDPlKh2Wj9AMKzrymCMDtZmczO2sScFVaXvfM7dg0BgWg/qvsfapO5bN4/9d5rscKd/zWGMvs2Le1DBXP6i79/n5NAmemGcJA33PrdIyVwSOuqkGau6SKHo3Ewd0a1CVh0q71pwML0qjbTOIGIL6otWjP9WR/0PUTJfq6Cu+gDSuaXhJrdasI5zz1aaZDpDjv7kIM5qmfxxUU5ePVSZ/UbcvOR5yQNnP1NKHXnOdai2E7FgFYZm8aKTP2X4roIrjlwXax5lCfgF+CGDZzeJjQKw7oxunW1cQVBn3ehgtmTkKMbIJeZNT6PjdKXrRtNQUx7HJm2MomjZQLnDtb4BhBptcUa7eE3L6x1idhqGz4XR2oXOqvSVqI585yu9tTKIecNaofN066nSAuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10927.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(1590799018)(45080400002)(54906003)(478600001)(83380400001)(2616005)(186003)(26005)(6506007)(6512007)(85182001)(36756003)(53546011)(38100700002)(86362001)(122000001)(82960400001)(31696002)(38070700005)(6486002)(71200400001)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(66476007)(64756008)(66446008)(4326008)(6916009)(31686004)(2906002)(8676002)(8936002)(5660300002)(66899021)(1580799015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWtLZjlPWUxQOGdhMzhJbm9hZ1FRK2MrdlIvdllzTUhsS0Z6d3NMK0JJWito?=
 =?utf-8?B?QUVKS2dKaUtCVm5QYmQ0aHlZMVlGdDZlV3lnc0dEMVU4cG5xNDFPV0t1bDB0?=
 =?utf-8?B?TlJFbHpTc1FKUE1vVXFOdUFmT3l0dVhaNC9vc2lCbXJZQXpBcGVJdmc0dnNz?=
 =?utf-8?B?OEI0Q2Y5UVZrN2FZR0Zwc3h3d3Z3UCszbVU2aGdrYjFqTDJONlpNL3p2cnpn?=
 =?utf-8?B?T0pqNnRVajBUcTZvZDcwZlFKVjRPRnEzM3E3azRxU3dTek5ZQ2Y0MlFLVnkr?=
 =?utf-8?B?RXZJYktHN2xPQnJIVVBiTWNMNE1aREN6Zld3VEVUTzVmdGhoc3pHWmpEYlkr?=
 =?utf-8?B?VVFGYjFMalRvNjhZSWVVOXdlY1dybXM3QmRHMys1ZDFkcWxtbWViVEpKTklK?=
 =?utf-8?B?MVIzaUJqMi9WNXAwN2psaXF4Z095Z0JBV3F3b3BHdHhhYkJBRkc1TDd3UUxo?=
 =?utf-8?B?YUZLWDdrY3hGbEdFSWE0azhwa0JjNmNrZkVwNGtFaGIyTGdPWE0xNXhEZGNj?=
 =?utf-8?B?blE4QkcxakZURmVUTWhpdXJxQzBFaU01V2RJRGdqSGU0U2NTeHBmdlh6Ylhm?=
 =?utf-8?B?d2FjMy9Sd3cyN2t6SCtuTWpaRjIvL2hmZnBlclF4MmJuMTVUTy9Zc2ZER0VR?=
 =?utf-8?B?cWM1a3BjdlJzQ3A5RVZpd0hQRDFJbDlXbGxmSDlSV1lWY0l2UWQ1VkcwVUh0?=
 =?utf-8?B?YW9FbGdOYmZuTUlGQlAralhwcVJiNWI4Y25MQnhQRVh0RFI4c1RNMitBWUly?=
 =?utf-8?B?ZTBQZW1LWVFjWEhhNE81MlBTMVp6M05vRzl6TFBSY29jMVhNa1F1VXA4QXVN?=
 =?utf-8?B?aXI2M1A5TkpjM0lua21sNzZMYnE2NE1NOHNPVWdCR2VxQ1d2bUQ4K1ZMMFNF?=
 =?utf-8?B?elZ0TEI5TUc3QVJJaGRHRFVMVEU1ckFPQUo5UnBNWWxpVnJOUy95cXk1QzlV?=
 =?utf-8?B?L3VhVTRBQ05IYmZ2bTVaWmtNK29lbitMdUhQbHVhcVRDTy9NRjU3TGloUHJQ?=
 =?utf-8?B?ZzN5ZFQwLzhHNWFjNFBjVkZSN3RETThSVDRQNm0vY3hjWUlXd1hmd1dMK2dy?=
 =?utf-8?B?Q1RBWXBYZStwSVluZUxNNDZ0eTFhN1d3YUVHRWp3Mm5vR05jWmJvemdTOXY4?=
 =?utf-8?B?cVpmN0ZxRmN6Qnl1cjd6SllRMXV3TGJTL01KUVVUdEhHaTl2OVZBSnlhL2N3?=
 =?utf-8?B?ZXRNQkNDWWxPU3Voa0E1SVRJN21JSHFxTnNqNkoybVdVUVJUZ0hzNStNVkZY?=
 =?utf-8?B?VExMMldwK2RwQUFnVlBDOU5LQmtTSW1hMktqSmhyZE0vcnRMb3kvckp3SVhx?=
 =?utf-8?B?UDk5ajluVFFnRnZzL21DZTVhMlltRTlra25xRjVKV0FHWmRMTlVjL0pwMnNU?=
 =?utf-8?B?MXZEQ3ZBcW55VW16cFpsMG5WQnFpcmp3T1h4NGdMaGdhMHNHaFlrUVNOVjNw?=
 =?utf-8?B?aHlIWEtGOThYWUZ3MUpsVFlQb1MzUXV2R1kyNjgrWCtPVWtKT0lzd3FVa1Qz?=
 =?utf-8?B?eVM4WXBRcUJHR21kMFpLaHFaS2RMK0pTRytBallkZGFJMVRwVEVWK0pTS1BM?=
 =?utf-8?B?K2tXdEY4V0tEUVdaSUo1WUxJZTFCbE95ZTEzWkdxQlNmeGF3d3d2a3BLQ09F?=
 =?utf-8?B?dWtkanRFVlhaTG1jVG16aFNxQ1ZBbkFQemFSRFBDMkpUbTk2SDBWMjk2bSsw?=
 =?utf-8?B?ZTM0SStBQzRjYjJFTHhvazNBM2dmbGF4VGR1R2RWZ0NPc20rc3lxWG5TM0Nm?=
 =?utf-8?B?Vm1UWXA2bkpYNi8vSHYvdnlzUTlrM1IrNzdibzZUYnZ5bXhtM1U0TThTclhy?=
 =?utf-8?B?eGtlanFHS2tSVXh0Tnp1YXhJN2I3eVJPQTFKSkR3bVIzL0hndjRWd3hQWlpn?=
 =?utf-8?B?VE1MbFdubVl1Q1h6eXlMT0VVTDhuejNJV3Q3ZFJTbzhVOElFWmJVYWFJRFQ2?=
 =?utf-8?B?amNpY0JBeDNJbmRPV3FIU1gzY1B5L0kwZ2tiNkpsTTdhRk1HWDhvQi9PbURP?=
 =?utf-8?B?TnRxWWhFYXg2MVZUeSs4ZnIzd1JsOEVSMFlUQTNLdFNXR0xPSEJDWnFscmkz?=
 =?utf-8?B?ako0UFZ4NzFzZHVtY1dHZm5NS09EQW9wNWp0VHlXODFsUHROWFBrVEQ4UE9o?=
 =?utf-8?B?T0xSajVXWE1zWi9UZTFlZ1JCOHZBaUFscHhnQXdHZ3g2bTRjSEUwbm5iYWNY?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FA26D3D2CBFA144B3867D5CD1F329A2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DMYBd4RisNYJaXsALxUmNGHlc4gn6g8oU3Qi4vFBEBqlOgELU0X7FtLF8E7JLF14QYO4LMbllHczoC+wnCA3Ngscctaiix0OmBPpKwlFEusAhgRggMhoUqtlvIal29eRcS+FUKzEVr85jZvLlyBvGZ+8KaXgREJC/vrWE171A90u7OtARs1kSCatzydA32mL56lL/zW2ljB+dD5OJZS42b4N3iMMAaVmkuk9fHU+G2104bFO3mAD653/iJYlpzOxodKWMacbjqGfDEsneXF1uX9zcvveKwbH8YSQVgp8cmOHuZ4PlwuNO7YmlV2kCqxdsMxh24nWePusqKFeE+I2V4ZXjnsZexxgmi8Mbwts2E4sedlBb7cS1eoAlN9TOuGA4zEIxnIIq7IVzHkZbUShPyACT/eoHQXDxRBylWFiyRKY7ZmShD+3gGGiWdjKPI7PfBVC+ywEuHsYU7a5HAEwGaXz/rJvtjLu/+icXj59ZuPnvVMek3TEmDKJiXCwhIcXb7MaIqHbv35llnXTs11wS2SBcTU0N7K86BGvLIoxxErMNXqJa4BjyQ9xpngMWhZcd6beosto+Mi8GD4bNfaum0nZaBQZOdUljEoxFgUzawRt7Y3tn7UP3jvBuSCz5zW3b0ebLkOtDAHb9CqBKdTsPtsCRTDDcveq3lMuirF3sVpX1z6L3D0+LbhMafVsiMTD/TLGKsm3uPPyc2pxez/WNusd8Ei/TDt3pv6bPYoui8DXlc7afkCz9PZ4kNTBNTWT258gMGTgK6FrLpMxwYWDYVvUvKMvwx3lI3c83+lWJLbKL8h1/cD4jFfe9hxMLlJUBMg14a0DK+dh1m1I9RU6E02H1DCWqlM2nmePuGiCnfDwF3APvCozP6YQAMiNZDAC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6709b309-3a2a-4d7b-7a50-08db3af36c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 01:15:36.9112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGSvlCVM+UhGx8CwYxM1tSJzZEaYSvw/38onwkukDwiCRSY9NzLZoGpOvNYemM/t1fPXOvqh04DeM7CeJr4RPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8495
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzA0LzIwMjMgMjA6MjYsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gVHVl
LCBBcHIgMTEsIDIwMjMgYXQgMDI6NDM6NDZBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEwLzA0LzIwMjMgMjE6MTAsIEd1b3FpbmcgSmlhbmcgd3Jv
dGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDQvMTAvMjMgMjA6MDgsIExlb24gUm9tYW5vdnNreSB3cm90
ZToNCj4+Pj4gT24gTW9uLCBBcHIgMTAsIDIwMjMgYXQgMDY6NDM6MDNBTSArMDAwMCwgTGkgWmhp
amlhbiB3cm90ZToNCj4+Pj4+IFRoZSB3YXJuaW5nIG9jY3VycyB3aGVuIGRlc3Ryb3lpbmcgUEQg
d2hvc2UgcmVmZXJlbmNlIGNvdW50IGlzIG5vdCB6ZXJvLg0KPj4+Pj4NCj4+Pj4+IFByZWNvZGl0
aW9uOiBjbHRfcGF0aC0+cy5jb25fbnVtIGlzIDIuDQo+Pj4+PiBTbyAyIGNtIGNvbm5lY3Rpb24g
d2lsbCBiZSBjcmVhdGVkIGFzIGJlbG93Og0KPj4+Pj4gQ1BVMMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBDUFUxDQo+Pj4+PiBpbml0X2Nvbm5zIHvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+ICDCoMKgIGNy
ZWF0ZV9jbSgpIC8vIGEuIGNvblswXSBjcmVhdGVkwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgYScuIHJ0cnNfY2x0X3JkbWFfY21faGFuZGxl
cigpIHsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCBydHJzX3Jk
bWFfYWRkcl9yZXNvbHZlZCgpDQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgIGNyZWF0ZV9jb25fY3FfcXAoY29uKTsgPDwgY29uWzBdDQo+Pj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCB9DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgaW4gdGhpcyBtb21lbnQsIHJlZmNudCBvZiBQRCB3YXMgaW5jcmVhc2VkIHRvIDIr
DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+ICDCoMKgIGNyZWF0
ZV9jbSgpIC8vIGIuIGNpZCA9IDEsIGZhaWxlZMKgwqDCoMKgwqDCoCB8DQo+Pj4+PiAgwqDCoMKg
wqAgZGVzdHJveV9jb25fY3FfcXAoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8DQo+Pj4+PiAgwqDCoMKgwqDCoMKgIHJ0cnNfaWJfZGV2X3B1dCgpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgIGRldl9mcmVl
KCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpYl9kZWFsbG9jX3BkKGRldi0+aWJfcGQpIDw8IFBEIHwN
Cj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlzIGRlc3Ryb3llZCwgYnV0IHJlZmNudCBp
c8KgwqDCoCB8DQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGlsbCBncmVhdGVyIHRo
YW4gMMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+IH0NCj4+Pj4+DQo+Pj4+PiBTaW1wbHks
IEhlcmUgd2UgY2FuIGF2b2lkIHRoaXMgd2FybmluZyBieSBpbnRyb2R1Y2luZyBjb25uIG93biBm
bGFnIHRvDQo+Pj4+PiB0cmFjayBpZiBpdHMgY2xlYW51cCBzaG91bGQgZHJvcCB0aGUgUEQuDQo+
Pj4+Pg0KPj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+Pj4+ICDCoCBybmJkX2NsaWVudCBMNTk3OiBNYXBwaW5nIGRldmljZSAvZGV2L252bWUw
bjEgb24gc2Vzc2lvbiBjbGllbnQsIChhY2Nlc3NfbW9kZTogcncsIG5yX3BvbGxfcXVldWVzOiAw
KQ0KPj4+Pj4gIMKgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPj4+Pj4g
IMKgIFdBUk5JTkc6IENQVTogMCBQSUQ6IDI2NDA3IGF0IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Bvb2wuYzoyNTYgX19yeGVfY2xlYW51cCsweDEzYS8weDE3MCBbcmRtYV9yeGVdDQo+
Pj4+PiAgwqAgTW9kdWxlcyBsaW5rZWQgaW46IHJwY3JkbWEgcmRtYV91Y20gaWJfaXNlciBybmJk
X2NsaWVudCBsaWJpc2NzaSBydHJzX2NsaWVudCBzY3NpX3RyYW5zcG9ydF9pc2NzaSBydHJzX2Nv
cmUgcmRtYV9jbSBpd19jbSBpYl9jbSBjcmMzMl9nZW5lcmljIHJkbWFfcnhlIHVkcF90dW5uZWwg
aWJfdXZlcmJzIGliX2NvcmUga21lbSBkZXZpY2VfZGF4IG5kX3BtZW0gZGF4X3BtZW0gbmRfDQo+
Pj4+PiB2bWUgY3JjMzJjX2ludGVsIGZ1c2UgbnZtZV9jb3JlIG5maXQgbGlibnZkaW1tIGRtX211
bHRpcGF0aCBzY3NpX2RoX3JkYWMgc2NzaV9kaF9lbWMgc2NzaV9kaF9hbHVhIGRtX21pcnJvciBk
bV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kDQo+Pj4+PiAgwqAgQ1BVOiAwIFBJRDogMjY0MDcg
Q29tbTogcm5iZC1jbGllbnQuc2ggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA2LjIuMC1yYzYt
cm9jZS1mbHVzaCsgIzUzDQo+Pj4+PiAgwqAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQ
QyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTYuMC0wLWdkMjM5NTUyY2U3MjIt
cHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPj4+Pj4gIMKgIFJJUDogMDAxMDpfX3J4ZV9j
bGVhbnVwKzB4MTNhLzB4MTcwIFtyZG1hX3J4ZV0NCj4+Pj4+ICDCoCBDb2RlOiA0NSA4NCBlNCAw
ZiA4NCA1YSBmZiBmZiBmZiA0OCA4OSBlZiBlOCA1ZiAxOCA3MSBmOSA4NCBjMCA3NSA5MCBiZSBj
OCAwMCAwMCAwMCA0OCA4OSBlZiBlOCBiZSA4OSAxZiBmYSA4NSBjMCAwZiA4NSA3YiBmZiBmZiBm
ZiA8MGY+IDBiIDQxIGJjIGVhIGZmIGZmIGZmIGU5IDcxIGZmIGZmIGZmIGU4IDg0IDdmIDFmIGZh
IGU5IGQwIGZlIGZmDQo+Pj4+PiAgwqAgUlNQOiAwMDE4OmZmZmZiMDk4ODBiNmY1ZjAgRUZMQUdT
OiAwMDAxMDI0Ng0KPj4+Pj4gIMKgIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5OTQw
MWYxNWQ2YTggUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+Pj4+PiAgwqAgUkRYOiAwMDAwMDAwMDAw
MDAwMDAxIFJTSTogZmZmZmZmZmZiYWM4MjM0YiBSREk6IDAwMDAwMDAwZmZmZmZmZmYNCj4+Pj4+
ICDCoCBSQlA6IGZmZmY5OTQwMWYxNWQ2ZDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogMDAw
MDAwMDAwMDAwMDAwMQ0KPj4+Pj4gIMKgIFIxMDogMDAwMDAwMDAwMDAwMmQ4MiBSMTE6IDAwMDAw
MDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAxDQo+Pj4+PiAgwqAgUjEzOiBmZmZmOTk0
MTAxZWZmMjA4IFIxNDogZmZmZmIwOTg4MGI2ZjZhMCBSMTU6IDAwMDAwMDAwZmZmZmZlMDANCj4+
Pj4+ICDCoCBGUzrCoCAwMDAwN2ZlMTEzOTA0NzQwKDAwMDApIEdTOmZmZmY5OTQxM2JjMDAwMDAo
MDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPj4+Pj4gIMKgIENTOsKgIDAwMTAgRFM6IDAw
MDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+Pj4+PiAgwqAgQ1IyOiAwMDAwN2Zm
NmNkZTY1NmM4IENSMzogMDAwMDAwMDAxZjEwODAwNCBDUjQ6IDAwMDAwMDAwMDAxNzA2ZjANCj4+
Pj4+ICDCoCBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjog
MDAwMDAwMDAwMDAwMDAwMA0KPj4+Pj4gIMKgIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAw
MDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+Pj4+PiAgwqAgQ2FsbCBUcmFj
ZToNCj4+Pj4+ICDCoMKgIDxUQVNLPg0KPj4+Pj4gIMKgwqAgcnhlX2RlYWxsb2NfcGQrMHgxNi8w
eDIwIFtyZG1hX3J4ZV0NCj4+Pj4+ICDCoMKgIGliX2RlYWxsb2NfcGRfdXNlcisweDRiLzB4ODAg
W2liX2NvcmVdDQo+Pj4+PiAgwqDCoCBydHJzX2liX2Rldl9wdXQrMHg3OS8weGQwIFtydHJzX2Nv
cmVdDQo+Pj4+PiAgwqDCoCBkZXN0cm95X2Nvbl9jcV9xcCsweDhhLzB4YTAgW3J0cnNfY2xpZW50
XQ0KPj4+Pj4gIMKgwqAgaW5pdF9wYXRoKzB4MWU3LzB4OWEwIFtydHJzX2NsaWVudF0NCj4+Pj4+
ICDCoMKgID8gX19wZnhfYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4MTAvMHgxMA0KPj4+Pj4g
IMKgwqAgPyBsb2NrX2lzX2hlbGRfdHlwZSsweGQ3LzB4MTMwDQo+Pj4+PiAgwqDCoCA/IHJjdV9y
ZWFkX2xvY2tfc2NoZWRfaGVsZCsweDQzLzB4ODANCj4+Pj4+ICDCoMKgID8gcGNwdV9hbGxvYysw
eDNkZC8weDdkMA0KPj4+Pj4gIMKgwqAgPyBydHJzX2NsdF9pbml0X3N0YXRzKzB4MTgvMHg0MCBb
cnRyc19jbGllbnRdDQo+Pj4+PiAgwqDCoCBydHJzX2NsdF9vcGVuKzB4MjRmLzB4NWEwIFtydHJz
X2NsaWVudF0NCj4+Pj4+ICDCoMKgID8gX19wZnhfcm5iZF9jbHRfbGlua19ldisweDEwLzB4MTAg
W3JuYmRfY2xpZW50XQ0KPj4+Pj4gIMKgwqAgcm5iZF9jbHRfbWFwX2RldmljZSsweDZhNS8weGUx
MCBbcm5iZF9jbGllbnRdDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgwqAgZHJpdmVycy9pbmZp
bmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMgfCA0ICsrKysNCj4+Pj4+ICDCoCBkcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3J0cnMvcnRycy1jbHQuaCB8IDEgKw0KPj4+Pj4gIMKgIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9y
dHJzL3J0cnMtY2x0LmMNCj4+Pj4+IGluZGV4IGMyMDY1ZmMzM2E1Ni4uNGM4ZjQyZTQ2ZTJmIDEw
MDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMN
Cj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQo+Pj4+
PiBAQCAtMTY2NCw2ICsxNjY0LDcgQEAgc3RhdGljIGludCBjcmVhdGVfY29uX2NxX3FwKHN0cnVj
dCBydHJzX2NsdF9jb24gKmNvbikNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVOT01FTTsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoCBjbHRfcGF0aC0+cy5kZXZfcmVmID0gMTsNCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBjb24tPmhhc19kZXYgPSB0cnVlOw0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBxdWVy
eV9mYXN0X3JlZ19tb2RlKGNsdF9wYXRoKTsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgd3Jf
bGltaXQgPSBjbHRfcGF0aC0+cy5kZXYtPmliX2Rldi0+YXR0cnMubWF4X3FwX3dyOw0KPj4+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4+Pj4gQEAgLTE2OTAsNiArMTY5MSw3IEBAIHN0YXRp
YyBpbnQgY3JlYXRlX2Nvbl9jcV9xcChzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQo+Pj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgIHdyX2xpbWl0ID0gY2x0X3BhdGgtPnMuZGV2LT5pYl9kZXYtPmF0
dHJzLm1heF9xcF93cjsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgLyogU2hhcmVkIGJldHdl
ZW4gY29ubmVjdGlvbnMgKi8NCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgY2x0X3BhdGgtPnMu
ZGV2X3JlZisrOw0KPj4+PiBXaXRob3V0IGxvb2tpbmcgaW4gdGhlIGNvZGUsIEkgd291bGQgZXhw
ZWN0IGRldl9yZWYgZnJvbSB0aGUgbGluZSBhYm92ZQ0KPj4+PiB0byBwZXJmb3JtIFBEIHByb3Rl
Y3Rpb24uDQo+Pj4NCj4+PiBBZ3JlZWQuDQo+Pg0KPj4gU29ycnksIGkgZGlkbid0IGdldCB5b3Vy
IHBvaW50LiBEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPj4NCj4+ICsJCWNvbi0+
aGFzX2RldiA9IHRydWU7DQo+PiAgICAJCWNsdF9wYXRoLT5zLmRldl9yZWYrKzsNCj4gDQo+IE5v
LCBteSBwb2ludCB3YXMgdGhhdCBjbHRfcGF0aC0+cy5kZXZfcmVmID4gMCBtZWFucyB0aGF0IGhh
c19kZXYgaXMNCj4gZXF1YWwgdG8gdHJ1ZSwgYW5kIGRldl9yZWYgaXMgc3VwcG9zZWQgdG8gcHJv
dGVjdCBmcm9tIGVhcmx5IFBEDQo+IGRlc3RydWN0aW9uLg0KPiANCg0KDQo+ICsgICAgICAgaWYg
KCFjb24tPmhhc19kZXYpDQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQoNCldlIGhhdmUgYWxy
ZWFkeSBkb25lIHN1Y2ggcHJvdGVjdGlvbiBWVlZWDQoNCj4gICAgICAgICBpZiAoY2x0X3BhdGgt
PnMuZGV2X3JlZiAmJiAhLS1jbHRfcGF0aC0+cy5kZXZfcmVmKSB7ICA8PDwgZWFjaCBjbGVhbnVw
IHdpbGwgZGVjcmVhc2UgY2x0X3BhdGgtPnMuZGV2X3JlZg0KPiAgICAgICAgICAgICAgICAgcnRy
c19pYl9kZXZfcHV0KGNsdF9wYXRoLT5zLmRldik7ICAgICAgICAgICAgIDw8PCB3aGVuIGl0IGJl
Y29tZXMgdG8gMCwgUEQgd2lsbCBiZSBkZXN0cnVjdGVkLg0KPiAgICAgICAgICAgICAgICAgY2x0
X3BhdGgtPnMuZGV2ID0gTlVMTDsNCg0KDQpCdXQgdGhleSBhcmUgbm90IGVxdWFsLCBjbHRfcGF0
aC0+cy5kZXZfcmVmIGNvdWxkIGJlIHNoYXJlZCBieSBtdWx0aXBsZSBjb25uZWN0aW9ucy4NClNv
IGluIHRoZSBjYXNlIGNvblswXSBzdWNjZXNzZWQgYW5kIGNvblsxXSBmYWlsZWQoY2x0X3BhdGgt
PnMuZGV2X3JlZiBpcyAxKSwNCnRoZSBjb25bMV0ncyBjbGVhbnVwIHBhdGgoZGVzdHJveV9jb25f
Y3FfcXApIHdpbGwgZGVzdHJveSBQRCB3aGlsZSBjb25uWzBdIHN0aWxsIGFzc29jaWF0ZXMgdGhp
cyBQRC4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiBUaGFua3MNCj4gDQo+Pg0KPj4NCj4+DQo+
PiBUaGFua3MNCj4+IFpoaWppYW4NCj4+DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gR3VvcWluZw==
