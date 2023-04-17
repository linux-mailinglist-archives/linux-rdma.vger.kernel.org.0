Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6D6E3D5D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDQCSf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDQCSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 22:18:34 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55BB2136;
        Sun, 16 Apr 2023 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681697912; x=1713233912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kYVmmUBRv/ZwDx73bPw83grawECO+Tw34CfAXNnDNbs=;
  b=T7NoY92hHO55SqzkmK0J2fIJYs044JGs3Xv1S2a6EFfOUwNVi3avYyhz
   dD7kzZTDDgZSKsEQIYMWlSweUnpEExnYdKR7Aj2mRwwdkbrMCkuEo4RKs
   VjmaoVwdmOSE3G/bSrIcoJiw76ATMydarIdaNBNry0gdLXMsxeNXHC5fU
   LmlV/2WUmY56sP5MWr2sjwDDVoHmHLexCZxVUbwoS90jd8D912FB94iD2
   RxP9h3qzzwGIs1PvR3hOgETvEuJBY+VsS2sDBF5yDeAnL3A9sdx9xVj1O
   cnUxvgYkZPktoCb5C4qMPWawpbTg0LtSJxirEcrHghvXaTgz4kV4M4FOm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="82080917"
X-IronPort-AV: E=Sophos;i="5.99,203,1677510000"; 
   d="scan'208";a="82080917"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 11:18:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSihjteis88H7m6u0z4bZZrEcAe/9JNuNW5E1qTMayzbh6fNp3zjAg0zLuM/ESIJRAiS7C3xTAbM7i1UImjQrSzqBguk40jc39jK0Pfc4LXVPAIgN2YVb7UKatz3y7k441wMp9VtIzPKIZvtmzP/wNbftiFfbXVsyblSl76CoWZrD4qfsOaSsRvK75EgQ9I40U7HO6mLSCCWDPDNB6dXi+uMylnTlzZV4IFIZ5mneYxByiRc1MeQZWhDkdd85WJJaXrP71X+62qMQ7TVsg6ZriYqDBy9StKLyOKCbJNK9W7ayeIJrGmjgAnE80wK3o6JPaaPZ4YLLSHbqVJ/aFGDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVmmUBRv/ZwDx73bPw83grawECO+Tw34CfAXNnDNbs=;
 b=ipkFxh99bp2mVlV/M4x74BFJLc3KHwo7H/bQnvEsz8LtXk/FV/AVTDC1iM6xOMUARKGJL+Wg/wViPfMlVBsWUmGH3RkGt63lKYIrQtDWPztMTdMspdlFwJoEDKDso56byE8sYlNMMrtqYPCmW6JscIFsVNYFnxWBK9mI4QwedhHyLEkbSu7T5xacaxBGTPuQDw1om0Ko5mRXVFemDyPdzMNkUswrWw8xtWZs/uUvgt7tPm9ztQEVwzrzGhkndpfS1mwGma8oQmAi+kYWl4rpawFO+scRLi7CZhghdTlkITWoVxNJEjY7FyphylRQd0fR38jiUo13KZVy7TL2vUxtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYCPR01MB10667.jpnprd01.prod.outlook.com
 (2603:1096:400:294::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 02:18:24 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 02:18:24 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCA
Date:   Mon, 17 Apr 2023 02:18:24 +0000
Message-ID: <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
In-Reply-To: <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYCPR01MB10667:EE_
x-ms-office365-filtering-correlation-id: 94881968-f798-4740-e380-08db3eea05f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ECaiO8FkUgJ3H+pH4hYPAIp8fuAw/0XBH8a8c+EdLFo0IOgMFJ8+y6iysuEj+Un/bvuqUOX0ETaLabjFNTVW0dHwGZR7Ancho7Rh9D2lfyI3bA/p94RbghLK4rYxJdcxejxWF5Vf53c2bkxMf0rWUDIfty0Y8X8vmEfhqgkfwczg3mOSg3jfwHqPdKu/eIte43Bcp5dl8W1e5zTFWD60Zn6uUSBaYFzwA2sr0wyygUUSJ1s5Ij4upPn3w9Oen+0BzSEnhJEs8j6RBWgP0a9QvZsy2KoyN5HA5cQB24hZly5n+BSsnqSLsk3DAKTHbrq3tgwiSbkr6epOc+amxXfm9oBuoazaF9la4eCRai0BL1iCgMSzFWM5Lr/LX5q74QEXtD55SwJPv2XoFNdsPSY6/MnovSP1STY2M77i1QIdsii759PsFw/WLTuGZ9xeZAU9m7oQpwT9V9Oy28sIuysK2As+7nEaP5NlT0qUyfxUhsJWTvbiH9RNXlPV5FBVqlbnU36Fw5pyJs7k9xzzqN1EVIOKzpQxfcbOcDnRiduN3nlQ9FNVCc2uV62PXyMVi+Qwi3qgKoRN3ElKzJk6EBVSpFKZ/uzpHUjbuqVMvC0aIWzdkOmqQF6H9fCFRSco4/HxubvrjQ9XsKt7Li3NgJIE5IHt0ax3Nvavq072vNsJgBsAkKpqGcaHf/9Wop3LojOluzcRM8MenKmvmx7lox46A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(1590799018)(54906003)(110136005)(31686004)(6486002)(71200400001)(478600001)(41300700001)(316002)(82960400001)(83380400001)(91956017)(64756008)(4326008)(66556008)(2616005)(186003)(66446008)(53546011)(6512007)(6506007)(26005)(76116006)(66946007)(66476007)(5660300002)(2906002)(8676002)(8936002)(66899021)(38100700002)(38070700005)(122000001)(86362001)(31696002)(1580799015)(85182001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVM3a1lCK3VqWXQyL1lGcXZ3aUVLZ1RZLzJ3YmpNNlJsUzZ6OWVlbyt1NHhy?=
 =?utf-8?B?VVZ4Y0l4dENZVUwyOWdnMlA2d1FtdHkwbnVXckRGb0RLbk9oWjRjZWw2SVAw?=
 =?utf-8?B?NzNMTFdaUE13TWExTEhJOWt6SExJdVB0RktOZjBRNjkyTUdPNFVocXV4ZTZr?=
 =?utf-8?B?U1FQTXZ2Rkhwb3pqOElLcXp2b0ErUTNjL2ZEVEVDWCtrcjlGZHZHck5pb2p6?=
 =?utf-8?B?WG5ZeUd6emphNDcvL2R4MVBxNUhNQlJveVZxOHZDQzFXcFFwTzZyYStrSjZ0?=
 =?utf-8?B?MjJ5UWloQVlrSjFYRnQ3eGtZUkhoMEZ4WHkrQUYxOTNlb21UUFVkclE0Mmpk?=
 =?utf-8?B?Q3paejdRWUtEL3JUaitKYjFkajJFTzBUVkU5bTdGSWdyMVNkK0VwOURMaDNQ?=
 =?utf-8?B?aHBjeHJlSmF0eU9KZVB2QTRYN04wbloxVS9rcTFsdjNFQ21EQkFqQkQ4VjlX?=
 =?utf-8?B?bytpVVl2REJvTHpueHZmanJOa00zUkNjZXV5amYrcUY3MFh5YVJ4L2t5NmxW?=
 =?utf-8?B?SlpTMTJIMldjZFZyNFpKNW5PdEp5NlNKM3NPSzRXYWdreW9MWm9RNU9SU2V2?=
 =?utf-8?B?dkNTczBoVXAzWHI5L1NYbnBzYkIyWjd6RFJVTE0raTRvTGcwQmdiOXU2WTZ5?=
 =?utf-8?B?Zm4zdkY0YkU0RVpraXYxNyt0dWxraTIvTzRkM1FPdGVlN2dxc2ZSSU5ndHJt?=
 =?utf-8?B?YnYvdlhQMDdyTGNyOEJhbFpvZlNzL1dqZ3gwdGFTVmhseEpjRHNvRG9XU3kv?=
 =?utf-8?B?cmpacmRpMEtLRHloelgzUDIwdDI1R0pXZVNzVjdpNUdwS2lpUDZjUi81SDl1?=
 =?utf-8?B?dmZxSkhmemJCbUlaRGg2RnovRTdsYTJxOUxDRUpGM2VKMzF1NHFsVTQ1UjNo?=
 =?utf-8?B?ZU80ZUU0VkZubytJdURpZE1qbDZoMEpKTEZBZ1J1WXVxbXF6S2JMMWdPMW9W?=
 =?utf-8?B?OEVUZzVhWFRmQVRJM3pGVERNa2dXam1jcldJQ2xGbnJnSGVadkRzdWtUS0Nx?=
 =?utf-8?B?ZUNjYkkwTzMyQkNyZ0Nmd2dseEh0UFZTNUp2Mml4eTBGQmxPd3h5Qm5JM1pS?=
 =?utf-8?B?MjZDM3dYeHdSaXNKTSt2M250bndnelEzVHBEY1hOenNkRk1aczVDbTVsL3NL?=
 =?utf-8?B?SStYWWN0MG9qRm8xU2VrMHhDbWxMSVg2MHNmS0VZeDA2enJQaExlM3dlY0pi?=
 =?utf-8?B?MWtUOVdFRCtFTG42dW5xV0tlejZ5WXR6SUhwbmFjRFFQUGt6MzRkcDAwam1O?=
 =?utf-8?B?ZjdjR21DNTNBMGN2c0lWd1g0SFRhbzhURE5oSWtiQk9aSy9kSHQ2Ty95K0Vr?=
 =?utf-8?B?bEVwazJPSVZpU3k5TW1MYXJkb3gxdCtEWVJoSTlCNVJLa3lrQkNsNDM3NUFO?=
 =?utf-8?B?NGhCOTBMZS9mTFI4d0Zka2lsb0NVOVRhcmYxQkFZeEZJOEs5YkdXOEhUL3FF?=
 =?utf-8?B?ZWdOaWNkODFXbm9oQ2J0eGNtN0tRVkF0VlR5NXhoQlJvN2N2SzhPRThaOWJr?=
 =?utf-8?B?ZTRxZXVqUDQ4Z1BTRi9VQXNJdHRtMTRJcndBTTU4bTVDeC94T09SUHpMNnkx?=
 =?utf-8?B?UzM3K3JjMU1GMWhtd2hUblZkbE5iOUkzZEZWWlV4djY4V0pXTHNtdzJNcGcy?=
 =?utf-8?B?dkhXenJqcDRiMk1xeDVINURXKzFMK09QaXBMeGlEbDBwQ3J1Y1Y0WVo0ZFlH?=
 =?utf-8?B?ZUw4aG40WERoc3IvQjJqUnhqeXI5aTZYN2pGK2ZKazdDMndrNHV5SkRNMGRj?=
 =?utf-8?B?MmlZd3QrZkVNYmZsVXV2ZmRXZFVITmpzUzRLRm52dkxTVXNWMVF3dm0yTFpW?=
 =?utf-8?B?ZmFGdkMrS0Q0WHR2V1A1WkExbHZ0WWJaRzBLOHdXVUJzWjRsSnk4MW0xcW90?=
 =?utf-8?B?eXZoTC9UUlE3VTVhQnU5bVBHU0ZHdkwzT2djb0g4dFp2MWhJVk52M3FBajBH?=
 =?utf-8?B?aTlXV1NocmV5VXoyVmRxVzlvajVhYUt3dUJZUFFqUDYyOHlIZnoxMmIwWEZn?=
 =?utf-8?B?SWc3dUU5ckcyOUxSNXBJWTQzZ3dkaC9XWW9nTS9NVHNYWk1HcERzVyszcDhO?=
 =?utf-8?B?WU56dEc2SEwrVHhwYUR6d2l3SWdFeElKTTF6eDF0QnJTVGFidklhYXlkZjA3?=
 =?utf-8?B?ank4dHBIYjkvTkdhTHZMUmNGTTR0aC9iWkFQa3ZiOVNIdzhYYUx1Si9GZDFn?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1D20CA7C6B6F14CB38F455D507B4DAB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kNWsWJDLIE4MBRW7AvYa2kDTZsF6+jApzh+6ZUzHyBmLCMcPqaS4e7ByR/LF++yuc5VUrsBMls1qkI7OdE2JfgoPS8wDNBBM5rx6vLlZ+h2bAmvGJzkmPqsPtDhIyXhgPjjM80WrZLjiVb6Eo3ziOL0b9/nYRZcZECnlmWITvuNSg6DOIlv2nk1veKm3hVmymfirUAAdxF+q2T9brIBfXWnECJz0t5uUcuS/D4MVlCdWjEDHrgWcDiBRUOpu9MaI55QQfD6iX0B9UFXgp/NNieu96j/n5JsYOPitDmJQo3Osov7hlbpbIwduXRYaOZvFflLPTf/UxwBTXKTQdh1b79HPGdD+lc9pBitSEp3IYyUbXEccx/EpX+qIY6RDtusbbpeTKytQXSI9pFyCv5Uhtor2c22pl6Tdv9SX16MHl4jv56K4DRAOubkOBoGnDKLW15dXVOnzDu2F7LemW0IZyetWqFnkCM4M6iCqIzlZ6sbIbzp/aRWhw8WJTPlUkFGmrPGg/4aawuI6vGunenXjc4LN60MbsYuGl3UMXmwDTyoXiFtkzdyhcUSOfWNro7KwAXSUy5mHH1bLEe+RNvnupvLUs/5xZetST/JLLdfwBAQJSz85RrrElsXt1/xPANZTv+diavnw8w6pr2IGkVnKRDKnqv0AhuK3Pw92tzSABnClTAmqh5h9fj2Iij7i5ghuTfyvQIScjGeNKyRjHJlde/OyZnUuuFoXpx1lpQ3nJF2R1RT3R+2D1jIbZY0Ihzen+VBoI9b2tzjMjU50QIBAirEJXcDZskIPPANOtHJGWEVwtOAmQIhsHp6Vy076VCML0vdEKBpNIarfLi/D8UjtcPS2YcfgnlUmOM3vjjUnanz+gDBd3qMsuYoeNjsy3Tqw
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94881968-f798-4740-e380-08db3eea05f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 02:18:24.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zyio89VsSzFilUW29CTPMgDdaTGBQHmDKVKvzhjqHJOarjtkSwfxti3pK26yPi1jW3fBxzyiktk+RnWUoMj4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10667
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzA0LzIwMjMgMjM6NTgsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDIzLzQv
MTMgMjE6MjQsIExlb24gUm9tYW5vdnNreSDlhpnpgZM6DQo+PiBPbiBUaHUsIEFwciAxMywgMjAy
MyBhdCAwODoxMjoxNUFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pg0K
Pj4+DQo+Pj4gT24gMTMvMDQvMjAyMyAxNTozNSwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4+Pj4g
SGksDQo+Pj4+DQo+Pj4+IEkgdGFrZSBhIGNsb3NlciBsb29rIHRvZGF5Lg0KPj4+Pg0KPj4+PiBP
biA0LzEyLzIzIDA5OjE1LCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+DQo+Pj4+
PiBPbiAxMS8wNC8yMDIzIDIwOjI2LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pj4+Pj4gT24g
VHVlLCBBcHIgMTEsIDIwMjMgYXQgMDI6NDM6NDZBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRz
dSkgd3JvdGU6DQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9uIDEwLzA0LzIwMjMgMjE6MTAsIEd1b3Fpbmcg
Smlhbmcgd3JvdGU6DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gT24gNC8xMC8yMyAyMDowOCwgTGVvbiBS
b21hbm92c2t5IHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIE1vbiwgQXByIDEwLCAyMDIzIGF0IDA2OjQz
OjAzQU0gKzAwMDAsIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4+Pj4+Pj4+IFRoZSB3YXJuaW5nIG9j
Y3VycyB3aGVuIGRlc3Ryb3lpbmcgUEQgd2hvc2UgcmVmZXJlbmNlIGNvdW50IGlzIG5vdCB6ZXJv
Lg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBQcmVjb2RpdGlvbjogY2x0X3BhdGgtPnMuY29uX251
bSBpcyAyLg0KPj4+Pj4+Pj4+PiBTbyAyIGNtIGNvbm5lY3Rpb24gd2lsbCBiZSBjcmVhdGVkIGFz
IGJlbG93Og0KPj4+Pj4+Pj4+PiBDUFUwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IENQVTENCj4+Pj4+Pj4+Pj4gaW5pdF9jb25ucyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4+IMKgwqAgwqDCoCBj
cmVhdGVfY20oKSAvLyBhLiBjb25bMF0gY3JlYXRlZMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+
Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIGEnLiBydHJzX2NsdF9yZG1h
X2NtX2hhbmRsZXIoKSB7DQo+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqAgcnRyc19yZG1hX2FkZHJfcmVzb2x2ZWQoKQ0KPj4+Pj4+Pj4+PiDCoMKgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoCBjcmVhdGVfY29uX2NxX3FwKGNv
bik7IDw8IGNvblswXQ0KPj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgfQ0KPj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IGlu
IHRoaXMgbW9tZW50LCByZWZjbnQgb2YgUEQgd2FzIGluY3JlYXNlZCB0byAyKw0KPj4+Pg0KPj4+
PiBXaGF0IGRvIHlvdSBtZWFuICJyZWZjbnQgb2YgUEQiPyB1c2VjbnQgaW4gc3RydWN0IGliX3Bk
IG9yIGRldl9yZWYuDQo+Pj4NCj4+PiBJIG1lYW4gdXNlY250IGluIHN0cnVjdCBpYl9wZA0KPj4+
DQo+Pj4NCj4+Pg0KPj4+Pg0KPj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8DQo+Pj4+Pj4+Pj4+IMKgwqAgwqDCoCBjcmVhdGVfY20oKSAvLyBiLiBjaWQgPSAxLCBm
YWlsZWTCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgIGRlc3Ryb3lfY29u
X2NxX3FwKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+
PiDCoMKgIMKgwqDCoMKgwqDCoCBydHJzX2liX2Rldl9wdXQoKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoCBkZXZf
ZnJlZSgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8DQo+
Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWJfZGVhbGxvY19wZChkZXYtPmli
X3BkKSA8PCBQRCB8DQo+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcyBk
ZXN0cm95ZWQsIGJ1dCByZWZjbnQgaXPCoMKgwqAgfA0KPj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RpbGwgZ3JlYXRlciB0aGFuIDDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
DQo+Pj4+DQo+Pj4+IEFzc3VtaW5nIHlvdSBtZWFuICJwZC0+dXNlY250Ii4gV2Ugb25seSBhbGxv
Y2F0ZSBwZCBpbiBjb25bMF0gYnkgcnRyc19pYl9kZXZfZmluZF9vcl9hZGQsDQo+Pj4+IGlmIGNv
blsxXSBmYWlsZWQgdG8gY3JlYXRlIGNtLCB0aGVuIGFsbG9jX3BhdGhfcmVxcyAtPiBpYl9hbGxv
Y19tciAtPiBhdG9taWNfaW5jKCZwZC0+dXNlY250KQ0KPj4+PiBjYW4ndCBiZSB0cmlnZ2VyZWQu
IElzIHRoZXJlIG90aGVyIHBsYWNlcyBjb3VsZCBpbmNyZWFzZSB0aGUgcmVmY250Pw0KPj4+DQo+
Pj4NCj4+PiBZZXMsIHdoZW4gY3JlYXRlIGEgcXAsIGl0IHdpbGwgYWxzbyBhc3NvY2lhdGUgdG8g
dGhpcyBQRCwgdGhhdCBhbHNvIG1lYW4gcmVmY250IG9mIFBEIHdpbGwgYmUgaW5jcmVhc2VkLg0K
Pj4+DQo+Pj4gV2hlbiBjb25bMF0oY3JlYXRlX2Nvbl9jcV9xcCkgc3VjY2VlZGVkLCByZWZjbnQg
b2YgUEQgd2lsbCBiZSAyLiBhbmQgdGhlbiB3aGVuIGNvblsxXSBmYWlsZWQsIHNpbmNlDQo+Pj4g
UVAgZGlkbid0IGNyZWF0ZSwgcmVmY250IG9mIFBEIGlzIHN0aWxsIDIuIGNvblsxXSdzIGNsZWFu
dXAgd2lsbCBkZXN0cm95IHRoZSBQRChpYl9kZWFsbG9jX3BkKSBzaW5jZSBkZXZfcmVmID0gMSwg
YWZ0ZXIgdGhhdCBpdHMNCj4+PiByZWZjbnQgaXMgc3RpbGwgMS4NCj4+DQo+PiBXaHkgaXMgcmVm
Y250IDEgaW4gY29uWzFdIGRlc3RydWN0aW9uIHBoYXNlPyBJdCBzZWVtcyB0byBtZSBsaWtlIGEg
YnVnLg0KDQoNCg0KPiArCWlmICghY29uLT5oYXNfZGV2KQ0KPiArCQlyZXR1cm47DQo+ICAJaWYg
KGNsdF9wYXRoLT5zLmRldl9yZWYgJiYgIS0tY2x0X3BhdGgtPnMuZGV2X3JlZikgew0KPiAgCQly
dHJzX2liX2Rldl9wdXQoY2x0X3BhdGgtPnMuZGV2KTsNCj4gIAkJY2x0X3BhdGgtPnMuZGV2ID0g
TlVMTDsNCg0KQ3VycmVudGx5LCB3aXRob3V0IHRoaXMgcGF0Y2g6DQoxLiBQRCBhbmQgY2x0X3Bh
dGgtPnMuZGV2IGFyZSBzaGFyZWQgYW1vbmcgY29ubmVjdGlvbnMuDQoyLiBldmVyeSBjb25bbl0n
cyBjbGVhbnVwIHBoYXNlIHdpbGwgY2FsbCBkZXN0cm95X2Nvbl9jcV9xcCgpDQozLiBjbHRfcGF0
aC0+cy5kZXYgd2lsbCBiZSBhbHdheXMgZGVjcmVhc2VkIGluIGRlc3Ryb3lfY29uX2NxX3FwKCks
IGFuZCB3aGVuDQogICAgY2x0X3BhdGgtPnMuZGV2IGJlY29tZSB6ZXJvLCBpdCB3aWxsIGRlc3Ry
b3kgUEQuDQo0LiB3aGVuIGNvblsxXSBmYWlsZWQgdG8gY3JlYXRlLCBjb25bMV0gd2lsbCBub3Qg
dGFrZSBjbHRfcGF0aC0+cy5kZXYsIGJ1dCBpdCB0cnkgdG8gZGVjcmVhc2VkIGNsdF9wYXRoLT5z
LmRldiA8PDwgaXQncyB3cm9uZyB0byBkbyB0aGF0Lg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+
IEFncmVlLiBXZSBzaG91bGQgZmluZCBvdXQgd2h5IHJlZmNudCAxIGFuZCBmaXggdGhpcyBwcm9i
bGVtLg0KDQoNCg0KDQo+IA0KPiBaaHUgWWFuanVuDQo+Pg0KPj4gVGhhbmtzDQo+IA==
