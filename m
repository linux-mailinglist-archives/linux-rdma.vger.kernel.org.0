Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8B47D27C0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 02:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJWA6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 20:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWA6k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 20:58:40 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF30B7
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698022718; x=1729558718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KF2DvnJbzVLvMCgqXfMpQ+OLIdt/GcYCoSHY473AMbw=;
  b=AsPMU9/rCvKvoOrZTX0APrK7fvjHu3Kq//ZXO9YGexwrL1ta/XRJXYW6
   Sv/oUumz+Ap4Lo66ALy/uw0gnZ0oHZL9WlKF7qCKqpbKsSUFzT32egmgJ
   3kDDobG/m8AwSsbQI+OzTZlwPmK2nTMXsBNNkf+F+wZQNYHPbhgYmdar4
   EeBgujqR3Re2+6V15kPMDhUx7X9U7YTEHLROGzZRWzEvfWNMMzQalBNop
   eVjIVDuiqaDBHTOBVT/mhFJghyC9yOxZyJBV6vvf200jKWegx+IwSk+n2
   Aqmlr6WP58YCSqm6jq2Z26/u8mHmz0u1iOadkWSG9sgvobywSgMUMZnJi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="11133713"
X-IronPort-AV: E=Sophos;i="6.03,244,1694703600"; 
   d="scan'208";a="11133713"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:58:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUNLiMaeVOo4Uhg9owuTXZUlvX4kqf9m5+lLk/HDC1SKUkJkI5dsDugWoeek54nUdEX4KgzYhehYHfCl6KVq+oiio/FLJO5OXfrV6D4gzzGLM33z4GcGRZ/tg6vVXEmCkiXo9Lm6uigzBDJYfeSBBfoJVur66GXlSIWprC8RljftzNC+sVIGIlTvVVwAuytNmqvsbdPKNYkT6mOPWFbZqrl/xWxwG4XUYvuBkw/GGdT+Q3geMfGMCapOvSjEZQzfJTqJPaqQBB4Ka1sG+W2T7iZntLu47uWV/ib1zdUJO64+4Vn6DaSvrKwtlWtQMDMJoT8I7yPzf/sHWvehPntVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF2DvnJbzVLvMCgqXfMpQ+OLIdt/GcYCoSHY473AMbw=;
 b=CTvisu1vtQxqFRQnjMcF1tgstZS7hc/x3Sg3u1KaY8d0dp8C0925T9VgRBTtvobiJtwUn4AUqPFA2m7aNxToK+01RN9b8mDEUwTRIEc3OvlZZC5e//fl45UCDXeSrruQdpXVzGZHvVl5RSACXeUJVlqHwES6goEv4B1gsUT/eMSnVFb5tBGeKp7EOGsEqARtWgQ1h3D3oMDUbzbG0rILQP5RPt/1rHDUoGEBepXihcz2Qo2WGEoyagl4VXWuDxuI3c9oKtSiH80yjV7kBslKoWgpWk/jWbKdyHdUCg1u7nj0yaFvgoKZaUb3HS8F9+fSwz/YlGx7xnNXyr8rcDVyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB11940.jpnprd01.prod.outlook.com (2603:1096:400:3fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 00:58:30 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 00:58:29 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
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
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAADR2gIAAnkqAgAO1JQA=
Date:   Mon, 23 Oct 2023 00:58:29 +0000
Message-ID: <e3541923-0dfb-4afb-b985-f9c1f77ac263@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <e628d470-507d-41a2-92ee-c32b8a8d4791@fujitsu.com>
 <e60407d2-13c2-477c-b663-102e6094c551@acm.org>
In-Reply-To: <e60407d2-13c2-477c-b663-102e6094c551@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB11940:EE_
x-ms-office365-filtering-correlation-id: 4665201a-f0db-41b6-04d4-08dbd3632c20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5jV+uaDGJDTLbHD6GfJtV/dx1kS08XJDLAC8OluWR+2wZ5Y09UWlZFy03yoKoODUSgall5HwLEegL9hSXt6uBJ3MQdVBc8BNE2Im8O0d3yW4QtI1SOZQND/DeDhuFd3xEHmK04MYlMt+Vfdjp1pzFiezJub5UQyIXkROAx/nTu8pSlA20SWcTgcb/01YrbkmnckvTHfbyKFDv9jX7/PKXnaH9vkgcUiVmPq6e1DUJgCudibCFtee9v2aQcWTUZ9q75yPdzwKHF9hbcBKMfDHldk6tS7r53te+BWyWRw9HrBBi2TWWjMpR+L7dK9kaGtXqzz/siTfoyF9zN66ByHSScsgk/DgK26AdA679AJOKdwTFbkxLN++YbiT9Fw4z4YxsRuln4urMf65CqxeVGoTsLIf7tFZRqHiW5XeLqapXTq58RAMSiYiuTBjxIL/OxzrJLI9/LYP1ae5X93/EBNEQu8vfF2wPyKKmD8e1ukfTmh0q14Cg32UcyE2RUyz0/BiZQW5TDNTlg2tXuADTCDvYtjo3E9GkkyiAqWeWvzH1EdIWot6zrS4InFwEgNtWey0DF+snU3LOs0DOhnkN51yoZH4U8FnVqxEflhfdS6j92cUsVTaJazUI4jziKdnu4C/aBrk3u9zX/tL7JwUJalOPkSbtnY9ZJCL4fuePdohLHunaB38yCedA6JW9yT8+77SrH8XHL86oRL5bhqKazU4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1590799021)(186009)(1800799009)(1580799018)(2906002)(38100700002)(91956017)(110136005)(76116006)(316002)(66446008)(66946007)(66556008)(64756008)(54906003)(66476007)(122000001)(2616005)(6506007)(478600001)(71200400001)(82960400001)(53546011)(6486002)(6512007)(83380400001)(85182001)(41300700001)(7416002)(36756003)(31696002)(86362001)(5660300002)(4326008)(8936002)(8676002)(38070700009)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU13MUx0VXVmYXdZNHl2Tm8vQW55SXlRN2NWbGd5TWZKUVhQdFBmRDBZeFdh?=
 =?utf-8?B?NTF1NlhDZlhiaHJXcXJZdURPOHYweUNHMnVoa2RZMnBsUGJDME5IRVhFTEJP?=
 =?utf-8?B?NmEwSVY0Unl2RVExWCtKbkVZeTErYmkzdGVsdGV1TFJUc0RqSHlQaW0xb2ZB?=
 =?utf-8?B?blk4bXFMTU01UzhMS1VyYWNydTQwTzVrSHVHQlVta3pTSzRhdEZZVjRYa3Ba?=
 =?utf-8?B?ejdYcGx5emlBOVNtTDFZYmJRbVlHbEdtMXhhVTlCUU1RMHpCbVBwQzBpU0ky?=
 =?utf-8?B?S3JETEhNZ2ZXOG1qU3ZLTW5hL0toOVJnakNQc21UbW1nVUI5MFZMZk1qaVlp?=
 =?utf-8?B?Um55UE0ydXBmQmt2akpUdTVaNzN3MUIrSkRyV2tiS29CZDMxY0Q3dEluODg1?=
 =?utf-8?B?b3RlUkRsNHRqSFhPZ2xOZGdnOGFyeDdNWG1QS0FHYWtnWmF3UjVuK3hNM1pO?=
 =?utf-8?B?MEU5TFFBRU4weFYwdE40eENHR05MTjlQS2F2Z09sVTF3STA2Kzh0aHdmVVdP?=
 =?utf-8?B?cEFweTUxbG5vT0U1OE9Zdmh3ZUtPUmlnbXpyM2pLb09lL0xYRkhpcHNXRmNo?=
 =?utf-8?B?ZUN4VDV6UnRtZk5MZXovdkpucEVBYlQ3bnhSUEpuM0VXODBhc3JoVWN0RCtq?=
 =?utf-8?B?NGtQSEJoT1orVlpJM1hyQWR6ak5kQ0wzakRLTmJsd2dhNVpvczJINnlHdFNH?=
 =?utf-8?B?YnE3eWZKek9KUDJ6djV4NkpqaWQrSHphcnZYUlRLMGpIVllUVlo2STVEbldT?=
 =?utf-8?B?RkQvUUJKQWVTQnpPN3lJMTZCMU1mUDRFNzJLZ05hL2pGV0dUdTRYYjJ3NDRT?=
 =?utf-8?B?TmhoRmdQTGRYc1V5UWYyYnZWM2FXY0VMaFZPWlNwT3IrcmFWTmpueGNTRm1i?=
 =?utf-8?B?ajVSRzNkeUFzTUtWeU11VUJWNFNtOFAybmlQWHlYMDcvWVI0ZGQ0Vnp0U0dm?=
 =?utf-8?B?V1ZUWE9iVmJpOERoTERiaFBSZjZtTUdxS2puK0lKQkJ0SGFOZWk2ZVdnbWQw?=
 =?utf-8?B?V0tCa1pIZjJZME0yME1SSUdoc1h0aXNaMDdVZ2djUVNHckhLTi9IRGM1WGJT?=
 =?utf-8?B?ak1DMlpsQ2RlME0reVF1aW9BVTRPdmRaZklQS2NXRWt0VlZnemc1N1J4WWlN?=
 =?utf-8?B?OE1OMzZ1a2NtYTZjZnBHcFVldHF2WmZZbjBrbVZRUHhBV1BlVEZxM3lENUd4?=
 =?utf-8?B?d3FqeWhtQzBnTnNBUkxEeXN0TG81RDlyUEcxN0J6by92djAyZUFDTHBTM0RY?=
 =?utf-8?B?dWxJdDNyayt0dStxUlhNN1U0VlR1MUZxd05PM29HaVppRkh6VmVrTWRHT0RE?=
 =?utf-8?B?UEYvbjA5eGVjSU1jcDk1K0FZd3h1dDhVQ1pUNjdwMWtKTzN2OHY3K05Wby9o?=
 =?utf-8?B?ZUlKZk03WGVUU3NleU1QZ3NTSFVKR2pyMzl3YWtDcVhYOG5aRm85L3I5aWUy?=
 =?utf-8?B?RE43OGJXcW9VbWV0Qnd4eXc3ZFhOc0FoVnNIYkwvclp3dWRXSUdpOUdlam9Q?=
 =?utf-8?B?MlNLd0pxbGJ3RURHT0JTenEwbTQwa25vRGRIN29iV1BlYzAyWjVka3V3Mlcx?=
 =?utf-8?B?MklldGYyME92UlFNcWVEQXRCakF0UFVVNWttT2NVTkxzQzhGR0FRSUhBYnZy?=
 =?utf-8?B?c0w0N2dKSXRQTGFEeFVoMHZmQXVtcHhaUUNEdXVCN1BqYTliaGlTMTR4Y0Jm?=
 =?utf-8?B?Y205RDEzNThVTEpuSE9xUW1FTWFGa3VyaFczMHZ6NTZnZUlxRm1tRzd5dVM4?=
 =?utf-8?B?d0M3SGtSWExJTlZCaXNNL2lxbnczd1N5SWs2aUROL0RqUDhjQ2VaMXZhbjNU?=
 =?utf-8?B?TDcxTFpucGxCcVdjRHJ5SDFMYTgrL0k0M2UxaFo4MFFXN3dzNWVUeW5hZk54?=
 =?utf-8?B?aU5tamVnZ0wydFhqSkdGckNISWN5OXVFSk40Y0NKeXl5MXk2SXFuSGJneCtv?=
 =?utf-8?B?dlBlK1BrQUJGWktISzNsdTFrYmgyVDU1S0hzcGtkTnVYUG9abVJJUXd6dk9Q?=
 =?utf-8?B?MnBHLy9nVjdlS3Q1OGZTc3k4OVBqZkMyMnFtOCtKa2lOM01KbkNGcng0eWxr?=
 =?utf-8?B?N2JBWWdwZElETEhkWFVNVllDMmhyRENwV1RVN1VoZEtmQjlNL211SmdYaFl3?=
 =?utf-8?B?S0xZb0FOUzRvZmYxRnYzK2poRzIwSXJ2WVZiRVNIVzR3OGFMaWNtN0RVNGlt?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9D83576904448458984E136068573F1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TTJXNVQ5bVlXditPdEVva1N6clpKRjdpVzQveHF1YlA3YnYwdjRIN1VkaVhh?=
 =?utf-8?B?T0cvdVYyWmlvYnIxUVRPNnJEYXNvWXlLTmxNb3V4TDh1S3J5T0Y1RmFDOGFh?=
 =?utf-8?B?SmR0QWFxTHBCaHRjcC9GeTVWTEROOEhTQWQ4eGJhdkNGQlU0RHQ4VHM3MEgz?=
 =?utf-8?B?OFp4UFJyS1FxM1ZhRUVidjFla0NTSlR4S0pQdHJHa2hXRDRYUllKMjNwZTBJ?=
 =?utf-8?B?cXc4MlRweVordU55UmgrNlRYWTI5amsxbU1CTFY1cFN3S1VRUENPQXoyVGZO?=
 =?utf-8?B?dS9uRGswaCt6eHpkZkdiUktDeWNnRFdaUXZpT1VqQ05YSFpiQk8yMEM2Q25M?=
 =?utf-8?B?NE5JRHAxYXhPV1Y3Z0JqMUgwZU8zTTFta3dvQ2VmeEY5eUh2RnJMZUQ0eE5X?=
 =?utf-8?B?aE1uV3FuVThjKzNXLzNyeTArbjloRVRUZWNNZEYybFVUT3hRSit5K1VyNGx6?=
 =?utf-8?B?RGtuRzNvVi95ZGVKUzE1Ny82L0hoMUlRek9STDhObkE2UitPekh1MkQ2d3Yx?=
 =?utf-8?B?RjN0eHpYcDRpdE1taVZPVEhWSXk1a1cxWXFYdE1pUnNGZ1J5eG01SXZrRU8x?=
 =?utf-8?B?b1JwNUtobHBoczVxWkZaL2JuSTF2MytuT0dJYWltOUZzVlNiVGplOHBDeThi?=
 =?utf-8?B?clVWNGtkdE9uM0pNMi9FRWRXMUZjR3p6bGxMcm4zbzY3cnlVbzMyOHk4WE9n?=
 =?utf-8?B?RnRJYW42QzI2cFpIS2Mra2NhaE04dEI0UnJESDdZd2x4WFRSSlc4TU4wd3Fj?=
 =?utf-8?B?bFp6RTRnWjU2NGFlcVBJTDRmNzJLYTFvQktydE9vdWsxZnJlWjNwOEx4ZFF0?=
 =?utf-8?B?N3pINHVnSFB0eW5xeFdwcmFyMlRteVByUEhSbUc4bk54VkRuOVRWRnFlZklH?=
 =?utf-8?B?ckFvdmVLeGJwTmxFczFRL2RkaHRUS3B2cFROV3FOQkVtczJjb3ArL2w2THU4?=
 =?utf-8?B?VmJXOElMcXRiTXovNlV4OFhWaUpoSXZaczRqQ2hoSytFUEM4V042VkZqeG9B?=
 =?utf-8?B?cVdsRE5vcWxuV2VBczE2UDlLc0hKOFhiODIvNVJsdHFFc0hVTHdjT1JrWjFs?=
 =?utf-8?B?QVRBYkZMQWhnbkF6TEFpM0NOVCtTOEJZMmNhK1QxTWxMN2oydThWNzRiWEcy?=
 =?utf-8?B?OE82STRCYzdxM24rZ2J0RlZFeDdPMG1VRnQ5UTJ6dWpVUmlTT3ZxclhLSC9X?=
 =?utf-8?B?VGxJa1NOUUtUQ2RibktIUGdtRm5HQU91WW1QU0lJWVNhOXZnWGErU2tHK3N2?=
 =?utf-8?B?cnd0dzAzWTJIeFhjWEljd1ZoMkRxSEpnRSt3VWVpSUdQUGVOTTd6UU1KSldo?=
 =?utf-8?Q?aV5bLWkJkqdJk=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4665201a-f0db-41b6-04d4-08dbd3632c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 00:58:29.8245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCrJCOI1NxIt1n2bYZepWvJJgD8n2jVo09kQfefP7yPhoicyQCfwLp6+LllfxvPuUMKWn8/DVHj4edbrGGatvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIxLzEwLzIwMjMgMDA6MjEsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTAv
MTkvMjMgMjM6NTQsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4gQWRkIGFuZCBIaSBC
YXJ0LA0KPj4NCj4+IFlpIHJlcG9ydGVkIGEgY3Jhc2hbMV0gd2hlbiBQQUdFX1NJWkUgaXMgNjRL
DQo+PiBbMV1odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FIajRjczlYUnFFMjVqeVZ3OXJq
OVl1Z2ZmTG41K2Y9MXpuYUJFbnUxdXNMT2NpRCtnQG1haWwuZ21haWwuY29tL1QvDQo+Pg0KPj4g
VGhlIHJvb3QgY2F1c2UgaXMgdW5rbm93biBzbyBmYXIsIGJ1dCBJIG5vdGljZSB0aGF0IFNSUCBv
dmVyIFJYRSBhbHdheXMgdXNlcyBNUiB3aXRoIHBhZ2Vfc2l6ZQ0KPj4gNEsgPSBNQVgoNEssIG1p
bihkZXZpY2Vfc3VwcG9ydF9wYWdlX3NpemUpKSBldmVuIHRob3VnaCB0aGUgZGV2aWNlIHN1cHBv
cnRzIDY0SyBwYWdlIHNpemUuDQo+PiAqIFJYRSBkZXZpY2Ugc3VwcG9ydCA0SyB+IDJHIHBhZ2Ug
c2l6ZQ0KPj4NCj4+DQo+PiA0MDI0wqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gNDAyNcKgwqDCoMKg
wqDCoMKgwqDCoCAqIFVzZSB0aGUgc21hbGxlc3QgcGFnZSBzaXplIHN1cHBvcnRlZCBieSB0aGUg
SENBLCBkb3duIHRvIGENCj4+IDQwMjbCoMKgwqDCoMKgwqDCoMKgwqAgKiBtaW5pbXVtIG9mIDQw
OTYgYnl0ZXMuIFdlJ3JlIHVubGlrZWx5IHRvIGJ1aWxkIGxhcmdlIHNnbGlzdHMNCj4+IDQwMjfC
oMKgwqDCoMKgwqDCoMKgwqAgKiBvdXQgb2Ygc21hbGxlciBlbnRyaWVzLg0KPj4gNDAyOMKgwqDC
oMKgwqDCoMKgwqDCoCAqLw0KPj4gNDAyOcKgwqDCoMKgwqDCoMKgwqAgbXJfcGFnZV9zaGlmdMKg
wqDCoMKgwqDCoMKgwqDCoMKgID0gbWF4KDEyLCBmZnMoYXR0ci0+cGFnZV9zaXplX2NhcCkgLSAx
KTsNCj4+IDQwMzDCoMKgwqDCoMKgwqDCoMKgIHNycF9kZXYtPm1yX3BhZ2Vfc2l6ZcKgwqAgPSAx
IDw8IG1yX3BhZ2Vfc2hpZnQ7DQo+PiA0MDMxwqDCoMKgwqDCoMKgwqDCoCBzcnBfZGV2LT5tcl9w
YWdlX21hc2vCoMKgID0gfigodTY0KSBzcnBfZGV2LT5tcl9wYWdlX3NpemUgLSAxKTsNCj4+IDQw
MzLCoMKgwqDCoMKgwqDCoMKgIG1heF9wYWdlc19wZXJfbXLCoMKgwqDCoMKgwqDCoCA9IGF0dHIt
Pm1heF9tcl9zaXplOw0KPj4NCj4+DQo+PiBJIGRvdWJ0IGlmIHdlIGNhbiB1c2UgUEFHRV9TSVpF
IE1SIGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaXQuDQo+IA0KPiBIaSBaaGlqaWFuLA0KPiANCj4g
VGhhbmsgeW91IGZvciBoYXZpbmcgQ2MtZWQgbWUuIEhvdyBhYm91dCBjaGFuZ2luZyAiMTIiIGlu
IHRoZSBhYm92ZSBjb2RlDQo+IGludG8gUEFHRV9TSElGVD8NCg0KDQpZZWFoLCBhZnRlciBjaGFu
Z2VkIHRvIFBBR0VfU0hJRlQsIGl0IHdvcmtzIGZpbmUgYW5kIHRoZSBjcmFzaCBpcyBnb25lIGlu
IG15IGFhcmNoNjQgZW52aXJvbm1lbnQuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg==
