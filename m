Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB257D08E1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 08:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjJTGzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjJTGzB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 02:55:01 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D50D51
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697784898; x=1729320898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ew/iv6SwzR4Lbe6+dGWPfI9ZTlb/DpDJhrCNeb+mbq8=;
  b=ghMgBHwW5PyfBwimxcLp1wOitWUfC3v+sfGGwiB3vlRfZo5G7YM/Hl8P
   lRs5c5SVk+JWaUhD47ZcIRIITfCuOvZF/yWasObZhxMp4aH8fWjM3pLNN
   +i6UOHyJgJ0aOgFeyGyIDI8RXE52RJLiNzzT+BInQYdQI3IjgX5cflzIy
   tKg0/iEjrCILOrDKtx7mMmE7Xi4vNQ5MoO1zZFn+Kv0TKeF0y8oiGvOEu
   79ZVqQdJwR0+wwiS2c+6pZwMxTg5rqn6+DOnd68Yqqn7VnPiYrf1O4DEw
   EYPrYo/RcSimJHiQIV9BixQo4tq7pORg8jXVD3km1OgxwKAf7/G+nQDEs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="99929715"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; 
   d="scan'208";a="99929715"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:54:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l92NR3uPIScHOGlk5KukYuPvfd1yZF0E45haEuigkdQNu0JIgTEvTKUjafhlzVLFsuMgj9WgFGFlICESZ0f416l2mCKqzTtLFZ8ZyT1y1xHnlGZExwHCgedGj/6I0AXz1UemDH3ZyFmpeEf2oIIskMELj38GoEWcrdKbpMvwaoYnyJvBDIW8cJSqX0HkvGYdMWAJ8P6C6DK9BRTtJttQ5MDgQBmhCjE7Ask8OpI0Iway+k7ApaLZwdMMvQERPuRDQ4IfYUzrjivkXfBpdrQ6rSda3q55tOvC+b0qdFWFFX3v9LsTPjIM7/bTrGuRm6EYW8kRCgezKL0uuzPW6BPTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew/iv6SwzR4Lbe6+dGWPfI9ZTlb/DpDJhrCNeb+mbq8=;
 b=PMKz3S7trveIY7O3Sf1oEZrBGRxzvBs81kf+K1bj1Xpr/zb/e3lDugs7cP9ZbqGRIqCHF2FxWny3MiIlR7sq7LSToMuVAyvy/itdCxkirn5acQ2RsoBhmCqK0brVTBbK+VgbgUph2Q805OTb7r6pGIVj/23IN6F0yeogPdVIKroJr1RQ43f/FNgCqqFlmjjm9JODefH6tSf9f6BbJonXZ3qmkk0Q3MeD9yAnjAUetjL45Uh3VizRPOX3VdEN5Azere0DQIqu/mE6nGcXesg052g5Je+btsFaCGcBxMDfpfeC7pUFQ7CyqU/T1rvQVAvoscA6D5Gidm5ltiglxngIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB9366.jpnprd01.prod.outlook.com (2603:1096:604:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 06:54:50 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 06:54:50 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAADR2gA==
Date:   Fri, 20 Oct 2023 06:54:50 +0000
Message-ID: <e628d470-507d-41a2-92ee-c32b8a8d4791@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
In-Reply-To: <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB9366:EE_
x-ms-office365-filtering-correlation-id: 3d1d2024-656a-47cf-d033-08dbd13974e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EOjRP2nngSHgXsXayWEmVGNo6vvIY6V2i/+ptY9N+7tUya1RP4SMEK35G5BsInsYv1ApL9KRlj1ioh/5vBLV0bVAvcUYX2zJ57KNYO3S/OAfVItT5NL7x6VrRHQUyHYx808Ox+ztWHVMKr2iCJEg22UBjrYuHFlJacZNmRgrV0kfBuX6/APOdsdn8QgWXJxVNjhSOYTgLUJbGtRLwUi0EEJfB0g8IWHpk+KJCxQa64yenzvISWpXRXGUiaW8V+S19hQEnU9S3Jklp9aCfq7bW5C4m5GOeQT6I65kEsTvjQuBOqVDg0Hj2/45fpVa9DT04RpYr32D2JJSuUGe6XnfdaKVY3q1VYP6fdeb4RGipaTNa90vpE1L+5oX6jOy4cRe+RtkHVU+hTBkxVBWtJg55GZNeAqcuZVT5P4kFZa2qHMH7sE8DIlKKRN3Wm0p/U0u571ntO9QEz/fP4FHIEXXYLO+weYci5MoN/sxLYVNWM47KjU3wmS+FQgpnyh1YuyxUb32NwGkUiT9fZL6/WOM/mO0+p5SEFqX/A2NVPFoIjjFXA5vo0S+d37N6UtZQxH28xlsCJLeDPvAg3oZpetq9FTc+/4QKkSqNNBhauzXckUCCCSC/A51uKCENbmTKpnkZd4Ksr7FPcJFlSp2+V7dLJ4r9RBydeZtuYk7rfFfCy5B8/U5dKfODZWg6DAHDK0Zcq5uXl3TtXO7cGObVcpFnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(1590799021)(38070700009)(66899024)(86362001)(4326008)(8936002)(5660300002)(8676002)(2906002)(7416002)(41300700001)(85182001)(36756003)(31696002)(1580799018)(122000001)(6486002)(478600001)(71200400001)(2616005)(82960400001)(26005)(53546011)(91956017)(316002)(64756008)(6512007)(6506007)(83380400001)(31686004)(110136005)(54906003)(66446008)(66946007)(38100700002)(66556008)(66476007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGc4WHU1Z2ZrTlZjTFFlNFBKcUNxcU9YSTBlSnpvOWY3T3RqMGxhcVErUlRU?=
 =?utf-8?B?elE2bUd5R2dZQVoxRDJyRDkxMUhQa3BiYTlMVGJac2RId1hwTEpBVldKREN6?=
 =?utf-8?B?NE5rWFNobmVpcnVyRGZ3SC9HVEZuK25iYlc2S2R3S1VXb1o0MEZLYkM0aG4r?=
 =?utf-8?B?VlZNVWpsMUFpa0R1eDkyTm0wMlp2ejdFRDhOeWVXZXNTeWkvNTMxS1hnN1FJ?=
 =?utf-8?B?YTlCbkkxVTVNd0UzUmFxKy9wTkdOOTRFODNwYWRhMi9nTGZJNTAvemMwbXI3?=
 =?utf-8?B?YXlxVFpISXhjeG8yRXMvaVloWFV4Ny9XOUhEaHM1R0lZQjdHa1QwY2FGWmNL?=
 =?utf-8?B?OXFBczA3NHkrazBOZkNJdXcvUXd0Qm5JREhpZ3Y4ZGp4Yi84UVZNUnhZcm5W?=
 =?utf-8?B?NHNQSUVua1kwcmxIWG1za0N0T2hUODcvZFFlV1BGLzhPdmorbVRlN01qejRE?=
 =?utf-8?B?UlJTMzlaZ1JJNy8waThkbmpzV1pFb3hiYWd6cGtIaXpUVUY1cFU0NHdlRW9W?=
 =?utf-8?B?bVY2RzErNm5YS2kwbDFmNy9QUDlQTEpsc1VWelVscXl3Z2RKczl4R2w0WlRB?=
 =?utf-8?B?OWJTZXBSZUNpL29MQnhZLzRPakFLZ2U3eUZBcllmc3dMenVaRmlnVEphYlRn?=
 =?utf-8?B?eGZveGlmV1hzQ2lqT0ZBVUwwbEwxclRvNit1SXFXWFhaZDFSU1ozQmd2eTJu?=
 =?utf-8?B?TkZLOGczL0Z6ZVI0dkxxREZVSzdrSFpuTm1vQk5OVTNKdVI3akM0T1dLeFRk?=
 =?utf-8?B?TFpTTGQwL1hqUGk0Nk91MTB4VjkrNndiRm9ER2JIVWZTdlRGeFpmUkVYd3lC?=
 =?utf-8?B?Z2tMMk1yVEVlRE5nTHRFeHIwUmg5cURnYnJGWlJUZGRLMFdVLys4K3N0ZHFj?=
 =?utf-8?B?WUl5NS9YaTBCOHczSzA4THE1WmQ3NDZlQzhsTlAzOHIyaWtpM28veXArYk1w?=
 =?utf-8?B?a1hIUUg0OTBadVdMNXA2WnJqYTQyUCtFamtaR1NpK09FR2hMUnJpYmNaaWpC?=
 =?utf-8?B?SEhDdGx0SitWODUvV0lsVlFPM0VycGJNVnE4MjljY0VRd1RPN1B4WkZRcFFB?=
 =?utf-8?B?Q0NpSDNSVDh2NkVucGVBSThhNGhaYXFxdlZDcllsNHJlQ1h1R2FxS2x0UDZK?=
 =?utf-8?B?WHBMMXBES0xsVXVzcjNkYXF6TWxkWHdzSDRjYzVtMU0xSzJwQldkNHBuWk5G?=
 =?utf-8?B?SmtVY2REWTF0OHEzM2w1dmlxd085aVFLYlpWenYrZFdSUXJIcDl0ZHgzbVBr?=
 =?utf-8?B?bXo3RWZYODEyMWd2cDkzYWZCbzRQZFlxaGRnL3RkTEU2RnhUWUZtd1JYVU9Y?=
 =?utf-8?B?ZDBJT0JuVzNESkJrc3VhL2txdU15Z2dneVJQRmJDb2V1VWJLeTljYUdyT0JY?=
 =?utf-8?B?ZnF4L3FRNU1aT3RFSnNtQUN4MDRZdmtMU0JEZmpJcGxOUk5kdTNEWTVMNUNQ?=
 =?utf-8?B?b1NYTk5meUo0UUNoWEpra2xuVXZaRUFONUlBblFuSG1uYnQ4Ykc2eGd4UnBS?=
 =?utf-8?B?ZzBFcXI0THYxb25lRGRvenMwalQ2VFFYb0RCNENVUkpUQWRzQ0E1RXk2bXZO?=
 =?utf-8?B?Tk8zRjlOYnY2RkVORHM3bmFERmM4UmUzZHBaSnRPR0ZrbSt1ZUI4OHZOa1dK?=
 =?utf-8?B?clFTMjNJdEl1R2pzdVkzSGRVWFFwZG5sQ2YvakcyNGhrOUxoWHBydFZkZzVG?=
 =?utf-8?B?bVVNU09qVGlpa2ROa0lHbkw4d2VYejVjdmhKaVVpdTFGQm50S1JEeU8xaWFH?=
 =?utf-8?B?b0UxZGhDZjh3THFOQlJ3UlZHK3lTQXNTY0Y2eFVyRnZZRlo0U0xEWmcxTm5H?=
 =?utf-8?B?dUJSZVNLbGFrL3lEdGhOTG5yTFJVYi9ObkhwcHNmWlhObWxDWUdaRCt4ZGlt?=
 =?utf-8?B?QnZTendTUnUrYjVTeHJzM1pOVTRjZlFGU2pWdW11S2FEcEdOczh4cUYvMmdW?=
 =?utf-8?B?d3ZuQmVIdkMrZkEwcXBmcDFMVitRYjBPT0pjbmJ1UVhsRElPR0JGaXZXV0lW?=
 =?utf-8?B?THJqNmxCNk1YNE1yalh2Qkd3MUVYZmcrc1dWUzJRWGhQU1pQZE9JcWtBZWor?=
 =?utf-8?B?UDdFRnFsdVFPYVFOY1Y2SXhMWkVFYlN0ZGV5bzRNZWhhbWttSU56STBqSFhj?=
 =?utf-8?B?alBKRHgwbzJRL2dDRTE0UVpxZHB4cmFGeGl2djJaSUJia3dkVkRMcnU0VzRz?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <326302DCA4336842B327FB27F3EF519F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3ZwUVF5MUFpMmk5ekpPRW1ibUEwUHdwZlI4TGpTTTYwSTdwN1ZIK05QeGJa?=
 =?utf-8?B?UUJQelFPNUJUS3ZOb3ZzNEpsb1BCdnp1NVpuYnVkSXF4dUJnSjNLU1J1OTJl?=
 =?utf-8?B?SUJ3c0ZKNDkwL01Ea0Faam1aZCtTZ1ZhR00rL0dsWTZFay8yVFBjRjA5R0Ji?=
 =?utf-8?B?YVF3YnJkTXowNmF6eGd0UHRmcElJdGREMnpqNjFEM2pXUHJadjlkUGJzNkVq?=
 =?utf-8?B?OGcvY0NyalhBWlRQNEZ0UWVpdXBoOUZuRnFHY2JzRzlqcUdTMCtzaUZ5MEVB?=
 =?utf-8?B?NTNZT3FybGxTZjJ5L1JnVkxQOWFPUnFvUTlZZ0tMRUQ1bHR5UGhIZnZoU1FR?=
 =?utf-8?B?aVAvbXhXQ05vRGJ5aVR4MVZYYUlhZzFhQ2ppS2N0dWVNczVsZVoySmQ3ZThE?=
 =?utf-8?B?N3JhUGFUMGp5UzU1cE05YS9sWkNiRFpxcm5lLytQUlFlUm1LYWlUMnBZblNL?=
 =?utf-8?B?U0RhNVI0aUs5dWtUc3pOenIybWtzSzBNZnd0QUs2bndmSVpxYVpUcmtHc2sw?=
 =?utf-8?B?TVRSV1BLOS9uZ1ZDOGZLT2c1R2IwTldQU2Y2ZVhmREQ0QWVpUWcrenJrdjJo?=
 =?utf-8?B?ZDdHRVQ0WWpFQ08zR05XbXIxZ3ZmNkptaEZPQ3hWK0R4dlhUekFZQVZoSUNa?=
 =?utf-8?B?RkZ5djVnbHU5UWpoYU9haHU4MTk3OGdFblF2VmFDQ2JaWmZnV3dxcGFvbmdw?=
 =?utf-8?B?QjlKNktmaXhjcm84ekY1TktrUmxGM1hBYnlyTWJXa1dpMVJGaC8xQkkrQUVa?=
 =?utf-8?B?eEpSVHRmZk1kUkRPcFlyUFB6ZkpoWXl6aE02WGZHSXdzeW5mOXhuZmwwYnB1?=
 =?utf-8?B?ZW54dTNGQVlpb1pHbEtWRGJiUkpMK0ZtQzcvaDd5bDFsK3pHVkxHTWRETktI?=
 =?utf-8?B?bXplb1pJN1puOVhVTysvSnpnKzZFWjVxQ0FtcFFQQlNGcVY0ZWVxaTVjaFdC?=
 =?utf-8?B?R040bWlhQ2gwMkVUZzBvbWkvZ29lODZCVldaSWhkWUJRRFFNZldsNDBaV00v?=
 =?utf-8?B?RUc4a3V2NXdhUXdrQUhQd3M4TDF5MEJNUnozK2U4Z1pIWDNoUXIzMEhiWnF4?=
 =?utf-8?B?Y1NWVDZjYUR0ZWk5L1BHMVRRcG13bGNRNnpzVm53TGd2S0J3SWErQ3FCYnV3?=
 =?utf-8?B?KzR2OFhmcFQvZjBZeklGRStBTFlRR1dRU0VvVFlCLytnZGptUWZ5bkJSWVdY?=
 =?utf-8?B?bTB3MjBmZ3VmUHhqUHIwNi9rWWI4T3Q3UE45Z3J1dmJFZHRlcE8xdjQyLzRi?=
 =?utf-8?B?bjBWWEZ4WmlISjhNN3RHUGcvSlVoZ2pTNVBacE5hYjJ3UzJReTc0bUdoVGdJ?=
 =?utf-8?Q?N3TjmesmYNRcI=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1d2024-656a-47cf-d033-08dbd13974e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 06:54:50.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsWbtcu6Xu41sDXIu2UcobLLPwa8vHn+Yv3iEUtGgK47r6gLNdnRv+XUEPy93M+T168SloE84Ymbqmrnk9+iOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9366
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QWRkIGFuZCBIaSBCYXJ0LA0KDQpZaSByZXBvcnRlZCBhIGNyYXNoWzFdIHdoZW4gUEFHRV9TSVpF
IGlzIDY0Sw0KWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBSGo0Y3M5WFJxRTI1anlW
dzlyajlZdWdmZkxuNStmPTF6bmFCRW51MXVzTE9jaUQrZ0BtYWlsLmdtYWlsLmNvbS9ULw0KDQpU
aGUgcm9vdCBjYXVzZSBpcyB1bmtub3duIHNvIGZhciwgYnV0IEkgbm90aWNlIHRoYXQgU1JQIG92
ZXIgUlhFIGFsd2F5cyB1c2VzIE1SIHdpdGggcGFnZV9zaXplDQo0SyA9IE1BWCg0SywgbWluKGRl
dmljZV9zdXBwb3J0X3BhZ2Vfc2l6ZSkpIGV2ZW4gdGhvdWdoIHRoZSBkZXZpY2Ugc3VwcG9ydHMg
NjRLIHBhZ2Ugc2l6ZS4NCiogUlhFIGRldmljZSBzdXBwb3J0IDRLIH4gMkcgcGFnZSBzaXplDQoN
Cg0KNDAyNCAgICAgICAgIC8qDQo0MDI1ICAgICAgICAgICogVXNlIHRoZSBzbWFsbGVzdCBwYWdl
IHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBIQ0EsIGRvd24gdG8gYQ0KNDAyNiAgICAgICAgICAqIG1p
bmltdW0gb2YgNDA5NiBieXRlcy4gV2UncmUgdW5saWtlbHkgdG8gYnVpbGQgbGFyZ2Ugc2dsaXN0
cw0KNDAyNyAgICAgICAgICAqIG91dCBvZiBzbWFsbGVyIGVudHJpZXMuDQo0MDI4ICAgICAgICAg
ICovDQo0MDI5ICAgICAgICAgbXJfcGFnZV9zaGlmdCAgICAgICAgICAgPSBtYXgoMTIsIGZmcyhh
dHRyLT5wYWdlX3NpemVfY2FwKSAtIDEpOw0KNDAzMCAgICAgICAgIHNycF9kZXYtPm1yX3BhZ2Vf
c2l6ZSAgID0gMSA8PCBtcl9wYWdlX3NoaWZ0Ow0KNDAzMSAgICAgICAgIHNycF9kZXYtPm1yX3Bh
Z2VfbWFzayAgID0gfigodTY0KSBzcnBfZGV2LT5tcl9wYWdlX3NpemUgLSAxKTsNCjQwMzIgICAg
ICAgICBtYXhfcGFnZXNfcGVyX21yICAgICAgICA9IGF0dHItPm1heF9tcl9zaXplOw0KDQoNCkkg
ZG91YnQgaWYgd2UgY2FuIHVzZSBQQUdFX1NJWkUgTVIgaWYgdGhlIGRldmljZSBzdXBwb3J0cyBp
dC4NCg0KDQpCVFcsIHJ0cnMgc2VlbXMgaGF2ZSB0aGUgc2FtZSBjb2RlLiAgQHJ0cnMNCg0KVGhh
bmtzDQpaaGlqaWFuDQoNCk9uIDIwLzEwLzIwMjMgMTE6NDcsIFpoaWppYW4gTGkgKEZ1aml0c3Up
IHdyb3RlOg0KPiBDQyBCYXJ0DQo+IA0KPiBPbiAxMy8xMC8yMDIzIDIwOjAxLCBEYWlzdWtlIE1h
dHN1ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPj4gT24gRnJpLCBPY3QgMTMsIDIwMjMgMTA6MTggQU0g
Wmh1IFlhbmp1biB3cm90ZToNCj4+PiBGcm9tOiBaaHUgWWFuanVuPHlhbmp1bi56aHVAbGludXgu
ZGV2Pg0KPj4+DQo+Pj4gVGhlIHBhZ2Vfc2l6ZSBvZiBtciBpcyBzZXQgaW4gaW5maW5pYmFuZCBj
b3JlIG9yaWdpbmFsbHkuIEluIHRoZSBjb21taXQNCj4+PiAzMjVhN2ViODUxOTkgKCJSRE1BL3J4
ZTogQ2xlYW51cCBwYWdlIHZhcmlhYmxlcyBpbiByeGVfbXIuYyIpLCB0aGUNCj4+PiBwYWdlX3Np
emUgaXMgYWxzbyBzZXQuIFNvbWV0aW1lIHRoaXMgd2lsbCBjYXVzZSBjb25mbGljdC4NCj4+IEkg
YXBwcmVjaWF0ZSB5b3VyIHByb21wdCBhY3Rpb24sIGJ1dCBJIGRvIG5vdCB0aGluayB0aGlzIGNv
bW1pdCBkZWFscyB3aXRoDQo+PiB0aGUgcm9vdCBjYXVzZS4gSSBhZ3JlZSB0aGF0IHRoZSBwcm9i
bGVtIGxpZXMgaW4gcnhlIGRyaXZlciwgYnV0IHdoYXQgaXMgd3JvbmcNCj4+IHdpdGggYXNzaWdu
aW5nIGFjdHVhbCBwYWdlIHNpemUgdG8gaWJtci5wYWdlX3NpemU/DQo+Pg0KPj4gSU1PLCB0aGUg
cHJvYmxlbSBjb21lcyBmcm9tIHRoZSBkZXZpY2UgYXR0cmlidXRlIG9mIHJ4ZSBkcml2ZXIsIHdo
aWNoIGlzIHVzZWQNCj4+IGluIHVscC9zcnAgbGF5ZXIgdG8gY2FsY3VsYXRlIHRoZSBwYWdlX3Np
emUuDQo+PiA9PT09PQ0KPj4gc3RhdGljIGludCBzcnBfYWRkX29uZShzdHJ1Y3QgaWJfZGV2aWNl
ICpkZXZpY2UpDQo+PiB7DQo+PiAgICAgICAgICAgc3RydWN0IHNycF9kZXZpY2UgKnNycF9kZXY7
DQo+PiAgICAgICAgICAgc3RydWN0IGliX2RldmljZV9hdHRyICphdHRyID0gJmRldmljZS0+YXR0
cnM7DQo+PiA8Li4uPg0KPj4gICAgICAgICAgIC8qDQo+PiAgICAgICAgICAgICogVXNlIHRoZSBz
bWFsbGVzdCBwYWdlIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBIQ0EsIGRvd24gdG8gYQ0KPj4gICAg
ICAgICAgICAqIG1pbmltdW0gb2YgNDA5NiBieXRlcy4gV2UncmUgdW5saWtlbHkgdG8gYnVpbGQg
bGFyZ2Ugc2dsaXN0cw0KPj4gICAgICAgICAgICAqIG91dCBvZiBzbWFsbGVyIGVudHJpZXMuDQo+
PiAgICAgICAgICAgICovDQo+PiAgICAgICAgICAgbXJfcGFnZV9zaGlmdCAgICAgICAgICAgPSBt
YXgoMTIsIGZmcyhhdHRyLT5wYWdlX3NpemVfY2FwKSAtIDEpOw0KPiANCj4gDQo+IFlvdSBsaWdo
dCBtZSB1cC4NCj4gUlhFIHByb3ZpZGVzIGF0dHIucGFnZV9zaXplX2NhcChSWEVfUEFHRV9TSVpF
X0NBUCkgd2hpY2ggbWVhbnMgaXQgY2FuIHN1cHBvcnQgNEstMkcgcGFnZSBzaXplDQo+IA0KPiBz
byBpIHRoaW5rIG1vcmUgYWNjdXJhdGUgbG9naWMgc2hvdWxkIGJlOg0KPiANCj4gaWYgKGRldmlj
ZSBzdXBwb3J0cyBQQUdFX1NJWkUpDQo+ICAgICAgdXNlIFBBR0VfU0laRQ0KPiBlbHNlIGlmIChk
ZXZpY2Ugc3VwcG9ydCA0MDk2IHBhZ2Vfc2l6ZSkgIC8vIGZhbGxiYWNrIHRvIDQwOTYNCj4gICAg
ICB1c2UgNDA5NiBldGMuLi4NCj4gZWxzZQ0KPiAgICAgIC4uLg0KPiANCj4gDQo+IA0KPiANCj4+
ICAgICAgICAgICBzcnBfZGV2LT5tcl9wYWdlX3NpemUgICA9IDEgPDwgbXJfcGFnZV9zaGlmdDsN
Cj4+ID09PT09DQo+PiBPbiBpbml0aWFsaXphdGlvbiBvZiBzcnAgZHJpdmVyLCBtcl9wYWdlX3Np
emUgaXMgY2FsY3VsYXRlZCBoZXJlLg0KPj4gTm90ZSB0aGF0IHRoZSBkZXZpY2UgYXR0cmlidXRl
IGlzIHVzZWQgdG8gY2FsY3VsYXRlIHRoZSB2YWx1ZSBvZiBwYWdlIHNoaWZ0DQo+PiB3aGVuIHRo
ZSBkZXZpY2UgaXMgdHJ5aW5nIHRvIHVzZSBhIHBhZ2Ugc2l6ZSBsYXJnZXIgdGhhbiA0MDk2LiBT
aW5jZSBZaSBzcGVjaWZpZWQNCj4+IENPTkZJR19BUk02NF82NEtfUEFHRVMsIHRoZSBzeXN0ZW0g
bmF0dXJhbGx5IG1ldCB0aGUgY29uZGl0aW9uLg==
