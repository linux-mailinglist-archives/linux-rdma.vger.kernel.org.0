Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325A74EA55A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Mar 2022 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiC2CmT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 22:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiC2CmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 22:42:18 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 19:40:36 PDT
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E31615FDF
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648521636; x=1680057636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QAMa5HbwLMt9D4kwUnYxriA2ZZDNlpwp1T28ePrdR+4=;
  b=K2m59+pjrZJ2q6aJBfFGJ/EAgH2wOiVWWPCng+ze8E+PqVcNuCKMBhfj
   FG/WJcl5LTUbwZa2CWJcqPY/P5SYf/8xxj2jyFDpPp1wMzcNanWCsaGzV
   z/Bh/mCNpCuPcW9H9xuD8cthFnWzMoRW/dHDzqIhgz0vA/OO45auUca6P
   ReRSi/IPQnxWPXQsE+muy38wdczMOV3WkeV/Tf/htiQu/I/33AYP9zufj
   zJWBJ52hXz334ZFutQVo9c7/7aQvRyP+4yOzxIdUTJ+QcBcQ8ypS4FAAD
   et9RZEqegh9EIIcUPE6vrOSEznZtAwG9tWZDZdiC+JGaCO73lrueKhn7s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="52549378"
X-IronPort-AV: E=Sophos;i="5.90,219,1643641200"; 
   d="scan'208";a="52549378"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 11:39:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8ePVwQYa40TURD+pZjouHNEHJUlCXPXGFQEJxZ1eKvX39Jfw+QIilGoElAXnZi63iz/ThUkeM7XA5b4X42ipdawfLWNa9F8K0u9XXwf3J2KE+oiD4YIYrG9bi9QQfNR/1iElOKRF5CMhbwpSsvo9W1bIK1jPsY7hkTkKoOTJMXSllWo7O/l8RWtq9OFSOfYyWIInH2PIqlzeRbmN2l8+t5idxvrM/R1v79fiVcwipF6z29aE6i+eWOJXSkNskYtIPC2yTvzhAqkp6loq7gqn+G3RLc6FmkdXTMFqoTXDBWJiY5fQdb22tLkQDwgKy9kBxQDTSE0xomuc+m/u8ru/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAMa5HbwLMt9D4kwUnYxriA2ZZDNlpwp1T28ePrdR+4=;
 b=K1HIalMFS5EIOHvS8VbAbuKr+PJuT9qpvdfEDtWkGeWri1SfGjnZfVCfVVLKTQlIuSRqvZ+Tk33AHNEAYdAp7GzUq2h0RaYw+zV853p0akZ3r7ss5K7D7uGksvRAbTjoqk+2rLeqwb5QXPi/jMf1oSQ9pwrlStikIA1NVjlKvfDEwEwwp95T5vMf7cF+8+HErz0DTuCK2xshNSwJrkrtntw7GTiVsiExOqteB2FTyQwP97iYg2JrkgdJPD6dkZRfX9BkGCPMFsem4UYi8Kr9rno7/nYT2cE+PUfJgwtIi/4OaGn5MSRreth5QuMkETRw3QQ0CKiYlv+y7ULK+W2FXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAMa5HbwLMt9D4kwUnYxriA2ZZDNlpwp1T28ePrdR+4=;
 b=l9Iw2rOtnYAgWChha7Z02O/oJDpg88SW05421gFx7Uvqn/ojQMTc7MKqfFJbF7J3Yib5zn0i5YVUKT8XozC+CIY+doJLF/k649pIi+wJj4jINjB1qqKoW79wedwAXEey2MlKdb5UvlkJh0mFxp8AhuOmfIzk5O0J0toB+wXN2ds=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYCPR01MB5821.jpnprd01.prod.outlook.com (2603:1096:400:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 02:39:26 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 02:39:25 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Topic: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAhy8oCAAMLcgIAGCbqAgAAbZwCABIBiAIAAGdCAgAD6qICAAACxAA==
Date:   Tue, 29 Mar 2022 02:39:25 +0000
Message-ID: <e3f67e89-fdec-5d26-27e1-c41675bbc74b@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
 <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
 <20220325132252.GB1342626@nvidia.com>
 <470872a3-3191-905a-f1f1-8452455d5ca1@fujitsu.com>
 <20220328113947.GG1342626@nvidia.com>
 <a733ce1b-70bb-10ac-6d62-361f6ee88ace@fujitsu.com>
In-Reply-To: <a733ce1b-70bb-10ac-6d62-361f6ee88ace@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 642e2cdf-ff0f-446a-8d51-08da112d5729
x-ms-traffictypediagnostic: TYCPR01MB5821:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5821382A88AEA495FB35DBE1831E9@TYCPR01MB5821.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBEBtuseRJMZB31p24ZR/jZujTyIJY0zxL3sLje4RYp/BJ8e9yX+8EUJV5Y+1HzOQrj9gjPXbMOyCUSv4oW8jpDswXGrYEUdLD6Q+FZRLegq6Y2eHZi2oGuvPpnx3nG5wn8EjYEhXj+wBk6PrDgdLL0XJwU308UVjWLSUEhLkun1Ku+osvXHMVezeNAeOLMgSROkmSJYc2YeklimGtWuO9a/jthBdjiv55lnzGLnWj/rcS0SJu8x1YZrydAdCIedIWYg4IlZUifp5Xua9ab2CSdnjESW+tYMg4jxYcNq9XqhnQedG/NY0bPciJzGMX4NBsNZmleB1yHM6k1/95pWLSr4INJmgPtBvi2OWOri8fXbskfsJera049DsApvj3/loDr43CMZMthTrdiviZsQh6uRA5A7CEzLBIP+d5ELCcWu1tW1rIn7x/Xn/eGDxur4m9hIegT4ELh6HAiSy0qMcA8+Neg53EG85Z9+tqIhuQZanREh2TBKHSUdmfwi88hGhWXBNwipN7rp/J6akFUoDqjvUFS/aq/Albj/lxpGvnlHx06DVMIeeb+YC+F7R9IejL4iawQ2v6nl7RCfvAgoSop7xvsFJ+qyV2WUlsQp6KnKl8lTt0Z/rh+gOGw3hhsUbztE2XhrTDbVvsRpeXhuO3MXEFeTlvVhTyXbiHy/dBPX5gz6Lqe+G2+hYihGllDfKo629FA4EkGlzqvO1Z6Vp5aU7Z2IZ6fBdDSQz9YNwz2SheATEgmYSsrmapjDZ/x+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(8936002)(31696002)(5660300002)(83380400001)(86362001)(66476007)(64756008)(4326008)(2906002)(91956017)(54906003)(82960400001)(36756003)(6506007)(66556008)(66446008)(66946007)(508600001)(76116006)(6916009)(8676002)(2616005)(316002)(6486002)(38070700005)(31686004)(53546011)(26005)(122000001)(6512007)(38100700002)(186003)(85182001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtSNzNVdUd3YTk0VHM1TTQramdKcVFiOHpwQ0t6eVJsOHU5OXlKa1VjL2ha?=
 =?utf-8?B?MWJObnc0YTRwSUVGa09XdEZrMFh0Zm9RQzN6MkZZdG5sZS8xSzNwbUkwbHJZ?=
 =?utf-8?B?YkpZWWZLbTZBaHB3Nm0zWlR3OGZrTWgrVlZtWVJSUjVuUzM1b2RYakZTdi8w?=
 =?utf-8?B?NnRlakNhd1ZLVzFhL1BMU1VWaEtkclJLU1dMNVdIbDh5ZTZqMXVad2xSWVBz?=
 =?utf-8?B?UUpBeVc3WE9VRHRJbzMrY09EU3A2dmRqRWVpek1lQThlV2hBMktGcmhHNFda?=
 =?utf-8?B?Q3RsL1Bsekk2ZGl2TXpqcVA2cUFIN3h6NmxaMC9na2EvcTE4VkZzSHoxVkVJ?=
 =?utf-8?B?Smk4YWhmbUJXUkI5RFhqV1dqSHloOUtMZEpmSEZnU2JiTEJoNHZXNWloeWp2?=
 =?utf-8?B?M2wyaE9tV1BldHpIejcvQnIxbDViNkRqYlNBT3RQbTBDT1NiWkJIUEFQYW5r?=
 =?utf-8?B?MVZGS0hxY2hzYlhzU2twcmRtRG1wNEowb2Z4alJHc0RZY2xUZ1YwNG9Vd3hp?=
 =?utf-8?B?SE9vK21ybXZGalBmRXEwZVRqb0RLVmFqZ2FNaWFqZjIrVTVGbjEyT3ZIUlFO?=
 =?utf-8?B?eVkySFRIUGxGTUhLMUhRd0NFTlFBdHdvejN5UXFPU3BwSFlvcitEM3BxL2x4?=
 =?utf-8?B?azI2M05mRlExTldpNVlieWRZL2JWOWdTY0dwQWZJdFJ6TUphZTFRajZuQU9J?=
 =?utf-8?B?bUNCWW0zUDFVaXNTNDh5Zzl3M2JuYWtmZ29DNUp1L093elVWSmJpam5EQzBt?=
 =?utf-8?B?R0szSUxWR2VJL3VsOXcxZjBVUFZWWXZLSTh1cFdwYXZXK3owSnFBcTNndHpl?=
 =?utf-8?B?RzhQdTFjNGZtamtVaEJkT3phU2ZRbGl0cWt0MWFDWUhZcE1Va1Q5blNhNU9q?=
 =?utf-8?B?RXZsMjNRTmRVT2xHMVBvNmR1WDc0UXZiS094NnAvVTlYS3JnSlA2YzUyY1JU?=
 =?utf-8?B?OWNHb0Z3bG55a3hHb1BuU1hVOUlhaWUrK2ErdHZnRDB0YytCU3Z6YlU4NkV6?=
 =?utf-8?B?cUQ1MEFMQy9hRWxxdzVlRWc4cGRQbUZsYmdMRVVhdnhzeFVLc1lMN292eFNh?=
 =?utf-8?B?MWphMXJjaklhUFpodW81L2hCTW13Ym1OUFFjd3dpcjVYRnRVTGdxcXBYRFp4?=
 =?utf-8?B?bExsWFZoZ1M4SFBWdDhLTWhkeFNNb0lNZlIvUFA0R3dZdEExcEFPYS9TRndw?=
 =?utf-8?B?TWR1Vk43c216a0dmK0l5cTV0dW1HVlZiYWdkY2RiYW9mTEFUVHhUQkhibktr?=
 =?utf-8?B?bEE2WndKT0hRN2dLV2NhMWVmSTkzYkN1ck5vWlM4U1VLMGwxRHlha3BXNnJX?=
 =?utf-8?B?MS9aY0VTYWtBYmZOY1lrSDE5cmpNWitJWkI3NGxyMnhNSmI3akU4dlVnTHRX?=
 =?utf-8?B?UFhwNnFqQkdSNEVSc2NOaG95Y3dZcktRTE11ZkF5czdsRFFxNEk0OHpoTW1E?=
 =?utf-8?B?azgwTkQ2dFlaZElhb0lVbWY3SklXNG9kcStGYy9jQVRxU0oyNWd5QmpCaEFI?=
 =?utf-8?B?K2pzQWxtU0p6cVF3enh6eHFYQmF2clJ6SHpzZW12ZXdKQmxkMmdING51RkxW?=
 =?utf-8?B?eXJHMnpkelBqYWg5QlFabTBOTjdyYlNHeXBYeE9QVVNnRklIN2kwenErcmxo?=
 =?utf-8?B?S1ZVeTJWTWhzMGdvN2UzcmNTV3N2VmN4aVMrb1lHREJhZ29OQktOcFc3b3RO?=
 =?utf-8?B?aTA2L045OEFkT3gwVzEwTmxrZnlubVB1Y3lkNTdDUURxOHBrZkwyWkxEUWRY?=
 =?utf-8?B?TVJBS0VWQTYxRmo2SStwU0lvNnpCUVdYaEsxOHdkOTdsYlVYNW1tN29yQXlN?=
 =?utf-8?B?TzhCN2poQjluVHRmdndTSlZvRUV4THl1VlZQbVBSckE0VXlCY1BadGowM1VR?=
 =?utf-8?B?Nzk1bExqZlhVeWJINTFIUnpNNUxaRlJSRHdpenZiZHFsd3hxRDZpZG9PYWxR?=
 =?utf-8?B?ZjZwWEZjbDM4d0tzU09ONjBhWDVKd3Z4RGRqeWhqdlk1SDl3N0p3VmVVZ203?=
 =?utf-8?B?azIwOVBpM1lXNXgvWnpidDBNNzB4c1JZYmF6ODFZTUtqTzVWdktaNEdLVGxj?=
 =?utf-8?B?SFh1Nmk0Q255SHdWaDA0ZE43ZWRNMzQ4cE5oZ2lCaGtmT2pja1dmSkc2ZFMv?=
 =?utf-8?B?SFJXZkoxc0paVnpsUDlUS2hvZjJaSDNSMTA3RTFrbjByd2cvS3JVSitPbk9x?=
 =?utf-8?B?Zk9KZ2lmenlsZkhvM2QvaEV5UGV5bC9Sc1owVHBjZnlEczhZK0djejJVTHBG?=
 =?utf-8?B?c28xRVFLV0VUcCtjei9ONnExTUNBb2RHV21WMDVPTW9EUGNnTGJQbGQxckJl?=
 =?utf-8?B?ZjM0VXpmdDBSN1Y3ZFhRNC93TG9GeENad3V4VE5zTW9hQjExempXNWM4NG5h?=
 =?utf-8?Q?ZjOzVwixu9yyIhHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CF8321607E7AD45B81CFE225855D04B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642e2cdf-ff0f-446a-8d51-08da112d5729
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 02:39:25.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zlF2kEHTwx2ZlL8w2Kz+rO5u+MtZ6c0idtV8/d0Q/SHNInCguqgb18TMPsHXmGnOU2lVrZS57cIL+wKEV+LHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5821
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI5IDEwOjM2LCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4gT24gMjAy
Mi8zLzI4IDE5OjM5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiBNb24sIE1hciAyOCwg
MjAyMiBhdCAxMDowNzoyNkFNICswMDAwLCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4+
PiBPbiAyMDIyLzMvMjUgMjE6MjIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+Pj4gSXQgaXMg
bm90IGdyZWF0LCBidXQgdGhlcmUgaXMgbm90IGFub3RoZXIgY2hvaWNlIEkgY2FuIHNlZS4uDQo+
Pj4gSGkgSmFzb24sDQo+Pj4NCj4+PiBJIHBsYW4gdG8gb25seSBkaXNhYmxlIHRoZSBrZXkgcGxh
Y2VzIGJ5IHRoZSBmb2xsb3dpbmcgY2hhbmdlIHNvIHRoYXQNCj4+PiB1c2VyIGNhbm5vdCB1c2Ug
dGhlIGF0b21pYyB3cml0ZToNCj4+IElzbid0IHRoZXJlIGEgY2FwIGZsYWcgdG9vPw0KPiBIaSBK
YXNvbiwNCj4NCj4gSSB3aWxsIGRpc2FibGUgdGhlIGF0b21pYyB3cml0ZSBjYXAgZmxhZyBhcyB3
ZWxsLCBsaWtlIHRoaXM6DQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5o
DQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KPiBpbmRleCA5MTgy
NzBlMzRhMzUuLjg4OTUzZjljMjZlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcGFyYW0uaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9wYXJhbS5oDQo+IEBAIC01Myw3ICs1MywxMiBAQCBlbnVtIHJ4ZV9kZXZpY2VfcGFyYW0gew0K
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IElCX0RFVklDRV9BTExPV19VU0VSX1VOUkVHDQo+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSUJfREVWSUNFX01FTV9XSU5ET1cNCj4gICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCBJQl9ERVZJQ0VfTUVNX1dJTkRPV19UWVBFXzJBDQo+ICsjaWZk
ZWYgQ09ORklHXzY0QklUDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSUJfREVWSUNFX01FTV9X
SU5ET1dfVFlQRV8yQg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IElCX0RFVklDRV9BVE9NSUNf
V1JJVEUsDQo+ICsjZWxzZQ0KPiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IElCX0RFVklDRV9N
RU1fV0lORE9XX1RZUEVfMkIsDQo+ICsjZW5kaWYgLyogQ09ORklHXzY0QklUICovDQo+ICAgwqDC
oMKgwqDCoMKgwqAgUlhFX01BWF9TR0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgID0gMzIsDQo+ICAgwqDCoMKgwqDCoMKgwqAgUlhFX01BWF9XUUVfU0laRcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHNpemVvZihzdHJ1Y3QgcnhlX3NlbmRfd3FlKSArDQo+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3RydWN0IGliX3NnZSkgKg0KPiBS
WEVfTUFYX1NHRSwNCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4N
Cj4gQlRXOg0KPg0KPiBJIGhvcGUgd2UgY2FuIHJldmlldyBhbmQgbWVyZ2UgbXkgY2xlYW51cCBw
YXRjaHNldFsxXVsyXSBmaXJzdC4gU28gdGhhdA0KPiBJIHdpbGwgdXBkYXRlIHRoZSB0aGlyZCBw
YXRjaFszXSBiYXNlZCBvbiBpdC4gXl9eDQo+DQo+IFsxXTogW1BBVENIIHYyIDEvMl0gSUIvdXZl
cmJzOiBNb3ZlIGVudW0gaWJfcmF3X3BhY2tldF9jYXBzIHRvIHVhcGkNCj4NCj4gWzJdOiBbUEFU
Q0ggdjIgMi8yXSBJQi91dmVyYnM6IE1vdmUgcGFydCBvZiBlbnVtIGliX2RldmljZV9jYXBfZmxh
Z3MgdG8gdWFwaQ0KDQpTb3JyeSwgdGhlIGNvcnJlY3QgdmVyc2lvbiBpcyBteSB2MyBjbGVhbnVw
IHBhdGNoc2V0DQoNClsxXTogW1BBVENIIHYzIDEvMl0gSUIvdXZlcmJzOiBNb3ZlIGVudW0gaWJf
cmF3X3BhY2tldF9jYXBzIHRvIHVhcGkNCg0KWzJdOiBbUEFUQ0ggdjMgMi8yXSBJQi91dmVyYnM6
IE1vdmUgcGFydCBvZiBlbnVtIGliX2RldmljZV9jYXBfZmxhZ3MgdG8gdWFwaQ0KDQo+DQo+IFsz
XTogW1BBVENIIHYzIDMvM10gUkRNQS9yeGU6IEFkZCBSRE1BIEF0b21pYyBXcml0ZSBhdHRyaWJ1
dGUgZm9yIHJ4ZSBkZXZpY2UNCj4NCj4gQmVzdCBSZWdhcmRzLA0KPg0KPiBYaWFvIFlhbmcNCj4N
Cj4+IEphc29u
