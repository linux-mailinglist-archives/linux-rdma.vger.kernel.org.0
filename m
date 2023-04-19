Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E486E76C8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjDSJxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjDSJxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 05:53:22 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AFE7;
        Wed, 19 Apr 2023 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681898000; x=1713434000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aWI1Qu+aqY4Gjfk87Z+t7WHNsSbgYm+QaBfE/+UHf3w=;
  b=rqd0LXOV9GoDzoljR4/1lVPHc+dsDLpv/1zIRuSiKMJ8Znh615kNhswd
   FMCqsbfHPvURfNhfHzgIK0wyLTNejIRn9ObLfbfJojUj4QwXi3vzgQDEG
   hHPKk8XLwy9fa5nDnXhC897l2tA01zJG0aI0YLQH9+S3Ho7I1nM13zUPI
   e8ebuWycWg9OVy+N2aUsAT5iaAkYPffrddlF3DAYI1XehvF13DAf4AHb2
   vl28hZuc66auBQEWe3JFBydIRGjH0I8A3y6BSToijDvfsigrmKOWQbxBc
   LQfRD/mGs4PM64qgu6Z+vgPPesODMoqUsPqz+xFVN8TCEtOaP7ANEtGfs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="82357849"
X-IronPort-AV: E=Sophos;i="5.99,208,1677510000"; 
   d="scan'208";a="82357849"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:53:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq9Ful3ShgLQRUiwBWdPkiBn18DGYCXOpbJkWGqNCJLtCiLOCE7hVF/A/avR/v6UWsGaF8Wq+sdV4vlOMUhfbSLxcMAie4o/y1+sNN0VhrW+DlKZhNZlmA9+H3KxkpfboKRFT7dkmdO3uqTIaS4hsIvFMn4/d5R8Ejaq/zoY+GcJ2VjaCVGWtY0MuXvl2/M93WajM9Mr12Pv/W1OaTHFSCBFF8WP87if+XUD6myJk9UAe69g+MB2QIf0ej3H2qNbfettYZnt2OYuzaK2aRitfCguQcxMxfLFgCf+IOWct2YMghNEd6lvW3F5DQ67qpiNBFvfJjwXMCxohSYhnMXnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWI1Qu+aqY4Gjfk87Z+t7WHNsSbgYm+QaBfE/+UHf3w=;
 b=nTNuZvLsTOF41lSBIKBne3+Heo6kGQYzXOCdHppF2yxgkQGzk/NZsz1FT5Vq/pd0/cmZ/lBDjHQspW/uIS/XXJC+hwwiG4xneGAtGMh1q/eHtBPN/yDdIcqm1JWtBhFHpH3F/6HSVStTCw1zRr8A6MQdKe8zSzVE4Kn17bQm0CJhPlqUGFojfJ70yNxSzjtkoeufmJSdu97OhQ/a7UqxSSZeTh+4DqwhXO/Vea0k72PbgdOrA8pvguO953IzxskWHconDjYd1nhg3uki6cXCVMf0HBlqqs26k3stEBQG4k6LJTQXozHlHQF2uuDyDKsVUoKtqjvTF/uvuykrsv5xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYYPR01MB10496.jpnprd01.prod.outlook.com
 (2603:1096:400:2f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 09:53:12 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%7]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 09:53:12 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCAgAEIcgCAANmvgIAADtcAgAGyw4A=
Date:   Wed, 19 Apr 2023 09:53:12 +0000
Message-ID: <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com>
References: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
 <20230417180452.GG15386@unreal>
 <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com>
 <20230418075706.GB9740@unreal>
In-Reply-To: <20230418075706.GB9740@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYYPR01MB10496:EE_
x-ms-office365-filtering-correlation-id: c6071e6d-5abf-48a3-b1f4-08db40bbe381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQ42MfQA1iCIEGUPO+5u61w/sKCjJ0tLK3aMHKxyecqqkzvqWyEXmDMmX5z/+3c7gJ5e+BSGHMFgTuYMbv4qUhITH/MwMmq1Agc0tDq8GtEeh0shgeN7Y56bEaH+ILvWe7qypvduLTWk7EIaT5hOhEz3+S3n1dpauyNRVzkSr0YO+yVm8E/7xHsTypHQSGF0KP3fNB1gU+q3Zs87N4NzVxRMpky7MUtLdhf47zSSX+Cf2TlQ52MI7wYzCuzyLntWN51fWcf0reXhemyINTW6EV47aSicCcO1MAGl5F2tA/x0boit3B84ZTwBBH+bIGJ1TQsrsOeuVm9Mt0YRK5aPLonCo/vJkIU8iHl72wNduADxpoSkxFQhGCtsZ53+oTMcuQ3pexN+pITxpP5jnPr8k8B0Zl3+D9lH2PGWPr5Nr43w1Upf+St1iYeOD3CFKEaNJwwlqS26Gh3vbgJA6tQKaMz5MPIpm7Y0evqxvMswiFcUb2SbY5y/fPdFLv7MRgOkobphGyvjlMgR7W5P3kdVt1OeYdfcc5rho0ERFVN+WjynB0mD2RY3rb3J7hfx1lUXm+GrTxWI0XIeRr+86yLRIti5LKw0fkf/TbInOtOJMEEkOSOVvYNmFnLOxxM19fPVydvYFAo6z3dEtVdBdoQeRjjm/I92VdIZV1rfpJSuxB4KNstC+zVbGpnCH8uxLQvFhhtsk9DV7UrmElPd3OI3Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(1590799018)(5660300002)(86362001)(2616005)(83380400001)(31696002)(53546011)(6512007)(122000001)(186003)(6506007)(82960400001)(26005)(38100700002)(8676002)(38070700005)(8936002)(54906003)(478600001)(6486002)(316002)(71200400001)(41300700001)(91956017)(76116006)(85182001)(36756003)(4326008)(6916009)(66446008)(64756008)(66946007)(66556008)(31686004)(66476007)(1580799015)(2906002)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGlkdHg0Y1RRcG55d2RmNHpSeWVWZGswakhCMkQ4LzVsQ2EyaHN5VE1YdUE4?=
 =?utf-8?B?NVo2ZStkaHU2cVpER0JST29oRUFQUUNGZUNlb2VEUnNVTmxFY3lENTl0cTZw?=
 =?utf-8?B?NStNOTNKRUF5czhlSTdNZy82V2cvQ2VLSm5uK3pSM0dRRjNwNXpCZHlheFh6?=
 =?utf-8?B?VFpFZ090SkFvdTQxZ1pJYURSVXN3NkxocjhGbjIyOGlMdm1JQUhvSXdnNFha?=
 =?utf-8?B?U1VHc0pyNWZ1V2RCWUd6c3Z1YmxPbE91WEs1SldJNk1GMUlYV2hrZThFRFpO?=
 =?utf-8?B?RXIvRUFwQm11a2drR24wV0MxR0QzaS82NEt2Syt0U054bTB4elk3TWxYL0ZR?=
 =?utf-8?B?OWphSVRocFhzRE1HRlpiWGNZMzJNV1NKbDJnRDlZYXJYK3UzQ0xRTi9pa3Jx?=
 =?utf-8?B?WTNhTWhqc3ppSjNBN3RJNXJzQ1pYRkJ1SDZkV3cxSjFQNEpsZC9JOFAzMEdO?=
 =?utf-8?B?Yis1T3h5T29HOHNSYTFXNzRWbkN6OEtCQXV1MUhNdFVZdTZId0pCMzBYdlp5?=
 =?utf-8?B?aVdPekxDWWtnOU1rSzVnR0c2MU1YNGhZSVRLdmJuSlU4V25XMzJVTnc5UDZX?=
 =?utf-8?B?QmxrS2U1U09uSzc2d0REWUh2aDVyTkpZVXNqSDhZV01kMHBRL25SdUZNbWZo?=
 =?utf-8?B?ZjBXdU5BRExRekpFcEs5NFBNTXB2OHVsUHVVZTNUTXc3alo5cGpFMk9kZ29P?=
 =?utf-8?B?QXg4aVV2UmtuMGRjdVdJaWNzTWxQeEFnODVBMmg2Y0wyK0QvSXdhZ1dMZk8w?=
 =?utf-8?B?SkRXbWx0S0QyQzQ2MXJuY1lpeVZUMVpaallsMit3S3NTRnlyYVRnZFhkMisz?=
 =?utf-8?B?aXI5Y3NyeEhzc1o0dHJzTE1zMUNYcUVHbnVBWTNZQnN4d0k4ejNUMldGeVU0?=
 =?utf-8?B?bFpKYmZQUDBmUm1hUWNxYm1DaHB0Q1oyMGJNTXlGZktjbk5ITDlPZkFpaE9T?=
 =?utf-8?B?bUhmN21yNGVENE9ZTDZ1ZmkyamRhV3VGNEtFaTdCT0N3UTkzdGJUMDdPekNz?=
 =?utf-8?B?R1ljc0ZVYlNtSFpId3VEWCtnK0dCNlVKL3JvRWlkdlNUUHRDa1hkV29mY01N?=
 =?utf-8?B?ckx2YUtnWEVlY3QzRWZMT054b0gwS0V4RFkrNEVNb0VDK1I4eGNURmFtMDk0?=
 =?utf-8?B?cHhZcnJ1K1JPNjIwaVYvOXl0V2pITno5emwwRXZoemdvaTdiQ0pvaWg5clZO?=
 =?utf-8?B?Z1Jlc243L1lIYW9MUDhUNG1EZWV4dzliVWk1ZEJScktvOTU5em5HUW5nbnF4?=
 =?utf-8?B?THA0dFdOTTZHTGx0NFRlRkp6NTVua0Nzdnl4WVludGlrekE1SksrWlVaM24y?=
 =?utf-8?B?QmdaWkFFU0VLYVFmZmpLVFovdlpQK1lrR1BrRVRrYWxlazhXVWtFSVpURzVF?=
 =?utf-8?B?bDkvNllvTG1IYklBYUxqbjlJUGtiazRBUXphb05OVTZwNFhmRUFUU3RWOEcz?=
 =?utf-8?B?M0JXMnB1dnlHQ09sNkN5QUlhTEkrMXR3WURKM0lrbk9ZUDBWdy9NVk83ZTRm?=
 =?utf-8?B?SnM3YUhMd1lQWG4vZksxeWxTWDNOTDVaOEllYy83WkgwMmhWb1J6N3dVV1FK?=
 =?utf-8?B?bjVtTTNGMnpyc2I3Vkptcjk0dTN6dW1kNmYyMzl3SmxpOHRMQUcxanFiZm5a?=
 =?utf-8?B?a0dWZnlZbnRUdEthWERQVjhwVis2NVRlL2FQWXllM29aQmkrazJlWnB1bVNl?=
 =?utf-8?B?emd4SlhwbGdHbHBJOExyMnduN0tyWjltNnRvQVFvRzcvaURmN1ZyNWJ4NFZp?=
 =?utf-8?B?eXV0T25jZm43S0F0QUVxbzVQSTVjS2VqWjlHd1p0T0pPbkJWMGc0Y3EyYUF0?=
 =?utf-8?B?U2ZZRTVBaUtNUnV5RWJSRkRhT0lHMlRvdTROeEg0czUyNlg5SVZQOUNMYnV3?=
 =?utf-8?B?am9tLzlMRU9SdVlzMHBOUFUzWHRpUFBaa3VrdC9zTXVuNzBzUzlINnF3MjZr?=
 =?utf-8?B?R2ltQ1JNYmZSM1gvSHNzWjZRUE4xK2I0b1VsTGdta1NiR0pSQ01NYktEaUEz?=
 =?utf-8?B?cU5tUEpFWmU4VmdvYWFoR1MxUFJiYWhtenE2eDJKb1lFUlBWSkxOK0YwYTNW?=
 =?utf-8?B?cTVhT2Zvd3UwZmFROG9pRXZjOFcrSjYvaEg3TGxnWERkQUFyMTJoODZudElG?=
 =?utf-8?B?UDJ0SmhkUnlvVjVaWWNycFNKQnlvendLdzBwTjVtY04vNWlNNWZ0cS9oTzlo?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8AB5FD787749842AEC05CDF53331825@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KFuOk6azFkWGLQxt7Mi8ODdQHuw3Pq8MqkaMpgvUFYscSpXYIokeWsTRB+/efnuoEjndqaQZ7DT2BAi18s56ZUdXo5H2kQR8BfcyTTCMmORY4Fk4KeaR/lABmOdeaXqPS1WpIt/nJYfNE8gXLM6Hs/5L9DJ4Yq/gbiQkdtew9CWVeQNt4gMEFV/smUJwpImOYyF1axuJmE1i/odZGiE5jUtZ9kQLc1VhHE6Qwcnz01+NC7GovXCIdW5l7ptg9wtUEgc1ACHh4dcZlQZFO94wBfiFh4wtWrpCPUmpA9ed4e29A18uSkJyni8ysJ5FfMOerNPBdQg9ld040vuIAZRqqxtgbB8mbSH215yxTo1y0aKe5o7xOcVyQd8T1b0KGcEou+z0wn+fj144aD/9g428Z31Pbe8DSKxshyrjmd3n4G4X3uDGXU+IdERC8vCtxlSuPtH/F/bObwxiJbsTyFS3PAVUTvfo4ItGOORocfy5aEquqlkAJoh/Wz1HEJHM7GvGrq6cLmQ5VecdlcMau+rp15UpTi2arad4/dzoJDveRTzVGc1kfZc1vzeToPE00owAGTVfJdbjDcJM60KjTcJt2yMpmH2lJ2ob2MpiF/Hy+T2uJ4sXtlUQ+6CAvP+i1kNkuU3fx4MPBFKe/5qQmsMgIDP3/wWt0AM0eAB4MbuQpeq5JUKEO/hWvsOmzRbw7gMN/LxumbMiqTnlFezo4ogRljDUvTjb7g6k1e4hc3XpK+cu+EPYvoZh1UbVQ1KCVC0E/5SVX3LxdbO+EWJy5wHZWMiMfrCoUcgV4YICWUCXIMS5FKpnWyDC+WVy9wAtEzKCQBOkh8/L0zk0BUCh/teOklSq7/tcCB7O5bNP1/kK5TQ/izrbTDu4gempqOV5X/kT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6071e6d-5abf-48a3-b1f4-08db40bbe381
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 09:53:12.3008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pU2JMTlur0FVbxEXsm6uqrmDpODeK/zfYt4JPxFxxgSHMvmByhp1IWswFLEKNs/qO6ON9VfYigQqzYazGF0CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10496
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

TGVvbiwgR3VvcWluZw0KDQoNCk9uIDE4LzA0LzIwMjMgMTU6NTcsIExlb24gUm9tYW5vdnNreSB3
cm90ZToNCj4+Pj4gQ3VycmVudGx5LCB3aXRob3V0IHRoaXMgcGF0Y2g6DQo+Pj4+IDEuIFBEIGFu
ZCBjbHRfcGF0aC0+cy5kZXYgYXJlIHNoYXJlZCBhbW9uZyBjb25uZWN0aW9ucy4NCj4+Pj4gMi4g
ZXZlcnkgY29uW25dJ3MgY2xlYW51cCBwaGFzZSB3aWxsIGNhbGwgZGVzdHJveV9jb25fY3FfcXAo
KQ0KPj4+PiAzLiBjbHRfcGF0aC0+cy5kZXYgd2lsbCBiZSBhbHdheXMgZGVjcmVhc2VkIGluIGRl
c3Ryb3lfY29uX2NxX3FwKCksIGFuZCB3aGVuDQo+Pj4+ICAgICAgIGNsdF9wYXRoLT5zLmRldiBi
ZWNvbWUgemVybywgaXQgd2lsbCBkZXN0cm95IFBELg0KPj4+PiA0LiB3aGVuIGNvblsxXSBmYWls
ZWQgdG8gY3JlYXRlLCBjb25bMV0gd2lsbCBub3QgdGFrZSBjbHRfcGF0aC0+cy5kZXYsIGJ1dCBp
dCB0cnkgdG8gZGVjcmVhc2VkIGNsdF9wYXRoLT5zLmRldiA8PDwgaXQncyB3cm9uZyB0byBkbyB0
aGF0Lg0KPj4+IFNvIHBsZWFzZSBmaXggaXQgYnkgbWFraW5nIHN1cmUgdGhhdCBmYWlsdXJlIHRv
IGNyZWF0ZSBjb25bMV0gd2lsbA0KPj4+IHJlbGVhc2UgcmVzb3VyY2VzIHdoaWNoIHdlcmUgYWxs
b2NhdGVkLiBJZiBjb25bMV0gZGlkbid0IGluY3JlYXNlDQo+Pj4gcy5kZXZfcmVmLCBpdCBzaG91
bGRuJ3QgZGVjcmVhc2UgaXQgZWl0aGVyLg0KPj4gWW91IGFyZSByaWdodCwgdGhlIGN1cnJlbnQg
cGF0Y2ggZGlkIGV4YWN0bHkgdGhhdC4NCj4+IEl0IGludHJvZHVjZWQgYSBjb24gb3duaW5nIGZs
YWcgJ2hhc19kZXYnIHRvIGluZGljYXRlIHdoZXRoZXIgdGhpcyBjb24gaGFzIHRha2VuIHMuZGV2
Lg0KPj4gc28gdGhhdCBpdHMgY2xlYW51cCBwaGFzZSB3aWxsIG9ubHkgZGVjcmVhc2UgaXRzIHMu
ZGV2IHByb3Blcmx5Lg0KPiBUaGUgaGFzX2RldiBpcyBhIHdvcmthcm91bmQgYW5kIG5vdCBhIHNv
bHV0aW9uLiBJbiBwcm9wZXIgZXJyb3IgdW53aW5kDQo+IHNlcXVlbmNlLCB5b3Ugd29uJ3QgbmVl
ZCBleHRyYSBmbGFnLg0KPiANCj4gVGhhbmtzDQo+IA0KDQpob3cgYWJvdXQgYmVsb3cgY2hhbmdl
cw0KDQpjb21taXQgNjFkYmE3MjUzODRlMjI2ZDQ3MmI4MTQyZDcwZDQwZDQxMDNkZjg3YQ0KQXV0
aG9yOiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQpEYXRlOiAgIFdlZCBBcHIg
MTkgMTc6NDI6MjYgMjAyMyArMDgwMA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgUkRNQS9ydHJzOiBGaXggcnhlX2RlYWxs
b2NfcGQgd2FybmluZw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICANCiAgICAgY29uWzBdIGFsd2F5cyBzZXRzIHMuZGV2IHRvIDEsIGNv
cnJlc3BvbmRpbmdseSwgd2Ugc2hvdWxkIGxldCBpdCB0bw0KICAgICByZWxlYXNlIHRoZSBsYXN0
IGRldi4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICBQ
cmV2aW91c2x5LA0KICAgICAxLiBQRCBhbmQgY2x0X3BhdGgtPnMuZGV2IGFyZSBzaGFyZWQgYW1v
bmcgY29ubmVjdGlvbnMuDQogICAgIDIuIGV2ZXJ5IGNvbltuXSdzIGNsZWFudXAgcGhhc2Ugd2ls
bCBjYWxsIGRlc3Ryb3lfY29uX2NxX3FwKCkNCiAgICAgMy4gY2x0X3BhdGgtPnMuZGV2IHdpbGwg
YmUgYWx3YXlzIGRlY3JlYXNlZCBpbiBkZXN0cm95X2Nvbl9jcV9xcCgpLCBhbmQgd2hlbg0KICAg
ICAgICBjbHRfcGF0aC0+cy5kZXYgYmVjb21lIHplcm8sIGl0IHdpbGwgZGVzdHJveSBQRC4NCiAg
ICAgNC4gd2hlbiBjb25bMV0gZmFpbGVkIHRvIGNyZWF0ZSwgY29uWzFdIHdpbGwgbm90IHRha2Ug
Y2x0X3BhdGgtPnMuZGV2LA0KICAgICAgICBidXQgaXQgdHJ5IHRvIGRlY3JlYXNlZCBjbHRfcGF0
aC0+cy5kZXYgPDw8IGl0J3Mgd3JvbmcgdG8gZG8gdGhhdC4NCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgICAgVGhlIHdhcm5pbmcgb2NjdXJzIHdoZW4gZGVzdHJveWluZyBQRCB3
aG9zZSByZWZlcmVuY2UgY291bnQgaXMgbm90IHplcm8uDQogICAgIFByZWNvZGl0aW9uOiBjbHRf
cGF0aC0+cy5jb25fbnVtIGlzIDIuDQogICAgIFNvIDIgY20gY29ubmVjdGlvbiB3aWxsIGJlIGNy
ZWF0ZWQgYXMgYmVsb3c6DQogICAgIENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQ1BVMQ0KICAgICBpbml0X2Nvbm5zIHsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8DQogICAgICAgY3JlYXRlX2NtKCkgLy8gYS4gY29uWzBdIGNyZWF0ZWQgICAg
ICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
YScuIHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcigpIHsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICBydHJzX3JkbWFfYWRkcl9yZXNvbHZlZCgpDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICBjcmVh
dGVfY29uX2NxX3FwKGNvbik7IDw8IGNvblswXQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICB9DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgaW4gdGhpcyBtb21lbnQsIHJlZmNudCBvZiBQRCB3YXMgaW5jcmVh
c2VkIHRvIDIrDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCiAgICAgICBjcmVhdGVfY20oKSAvLyBiLiBjaWQgPSAxLCBmYWlsZWQgICAgICAgfA0KICAg
ICAgICAgZGVzdHJveV9jb25fY3FfcXAoKSAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAg
IHJ0cnNfaWJfZGV2X3B1dCgpICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICBkZXZf
ZnJlZSgpICAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgaWJfZGVhbGxv
Y19wZChkZXYtPmliX3BkKSA8PCBQRCB8DQogICAgICAgICAgICAgICAgaXMgZGVzdHJveWVkLCBi
dXQgcmVmY250IGlzICAgIHwNCiAgICAgICAgICAgICAgICBzdGlsbCBncmVhdGVyIHRoYW4gMCAg
ICAgICAgICAgfA0KICAgICB9DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvdWxw
L3J0cnMvcnRycy1jbHQuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5j
DQppbmRleCA4MGFiZjQ1YTE5N2EuLjFlYjY1MmRlZGNhMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
dWxwL3J0cnMvcnRycy1jbHQuYw0KQEAgLTE3NDMsNiArMTc0MywxNSBAQCBzdGF0aWMgdm9pZCBk
ZXN0cm95X2Nvbl9jcV9xcChzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQogICAgICAgICAgICAg
ICAgIGNvbi0+cnNwX2l1cyA9IE5VTEw7DQogICAgICAgICAgICAgICAgIGNvbi0+cXVldWVfbnVt
ID0gMDsNCiAgICAgICAgIH0NCisNCisgICAgICAgLyoNCisgICAgICAgICogRXZlcnkgY29uIHdp
bGwgdHJ5IHRvIGRlY3JlYXNlZCBzLmRldl9yZWYsIGJ1dCB3ZSBzaG91bGQNCisgICAgICAgICog
cmVzZXJ2ZSB0aGUgbGFzdCBzLmRldl9yZWYgZm9yIGNvblswXS4gSW4gY2FzZSBjb25bMStdJ3MN
CisgICAgICAgICogY2xlYW51cCBwaGFzZSBjYWxsIHJ0cnNfaWJfZGV2X3B1dChjbHRfcGF0aC0+
cy5kZXYpIGVhcmx5Lg0KKyAgICAgICAgKi8NCisgICAgICAgaWYgKGNvbi0+Yy5jaWQgIT0gMCAm
JiBjbHRfcGF0aC0+cy5kZXZfcmVmID09IDEpDQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKw0K
ICAgICAgICAgaWYgKGNsdF9wYXRoLT5zLmRldl9yZWYgJiYgIS0tY2x0X3BhdGgtPnMuZGV2X3Jl
Zikgew0KICAgICAgICAgICAgICAgICBydHJzX2liX2Rldl9wdXQoY2x0X3BhdGgtPnMuZGV2KTsN
CiAgICAgICAgICAgICAgICAgY2x0X3BhdGgtPnMuZGV2ID0gTlVMTDs=
