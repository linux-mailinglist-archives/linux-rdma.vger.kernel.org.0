Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF5785157
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjHWHSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHWHR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 03:17:59 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 00:17:55 PDT
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB57DB;
        Wed, 23 Aug 2023 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692775076; x=1724311076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CAC/bq0zIGRQDujHWxnN3EuUHpVV+1acNWz8YPtc42g=;
  b=ahgCVo8ybak669XAeOfoI+AQ7adhi7CT/GBFF6dsp97vdRzjnySk2Z0U
   0duS9JbaKCz+k+PiEoXHEoPOckNQRTy/DEh4r696YGd7Tw8ix3ktg5Pd5
   pFDq9WyCWzBKWwQECgCl2UF3So1p/6ISMfhtbZAI69WfOI35prUEIEkA2
   ub92mv8YR4XUHxJcg5sQdVtaWqvyCC+W0w65eHGUH4Zz26PyHpU/zFArJ
   JiX8GZfhKla6fveDy81bjMbh9fdJXX0sZREIk7HinfcYEgNfhfCh6Ly6Y
   BEwbKeQaEJ15+oudISO1TMHp3bVKgTbbErIhiMXPRg04eyMkULilx0dLf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92481764"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="92481764"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:16:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMqeetnqen0KR1OkDN9VKlbuO2pvMU9cIZrGNrz8K9dDyzbaA9HnVRh2UnOu5zx2RRwXgjTJWJBLhVakkNi5FpwXQrywePt+oCXmYetq4LmWWiGSJpXFuxfs1Qf6W3vA3XUp7AcrD3QSA66JqnCTpGPQHRkIbcM4PGKVnHcoaVu3Mvyay+30I5ERd5g5Bb9YGbxnuzkFo8LFHtN++U9mQXTDUgmg5DFMeQC4ujcWQMty0PJGV/IQ0P69XK38LjLn3WhvwscKTGh94PMTdQfFStiC7v2nrQE305AsBSY/+DS5hl/H2+1dzBM5CV/OmQ0O0xWxG1vknvd5a2Y+BswKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAC/bq0zIGRQDujHWxnN3EuUHpVV+1acNWz8YPtc42g=;
 b=ho70nGLerShyaNJ7x+f0MPI0ZyKdcLZa302h+bITf00+22HqlWEBJlGg0N26T7mKNSnt3n/AV3yfJn+sNOVa2v3mz9jOG/Sr3GhSLj3dL6dwgf5zezNYgOWA6w4GCL2O9xX3PVtKK43XGdMI8uVkqAFIMuPlwIajztemqYGJPT76sTMHTAANdx/k6+7WZi1JvX1HSpzGXa+IRvOchGt8QK9S8i/bw3vFG96xiX2Q1vjeqi24y9kDy+46QK9XTwaWcAfTRpwwDMDooINEZwV94lVi8nPiToI1w/E895Mj6MlliLoQnVx58J2NZcggYWxa1/bdySdWjwvToRfE6pVtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB8517.jpnprd01.prod.outlook.com (2603:1096:400:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:16:45 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:16:45 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Topic: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Index: AQHZ1Yi6vF1u/D15FECJQTHJEnRCjq/3dd8AgAACmQA=
Date:   Wed, 23 Aug 2023 07:16:45 +0000
Message-ID: <04b5879b-fabf-bf28-5a20-b65b555b72ba@fujitsu.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <OS7PR01MB11804F618EF235291066AE96EE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB11804F618EF235291066AE96EE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB8517:EE_
x-ms-office365-filtering-correlation-id: 02c89706-f484-4364-24b1-08dba3a8e87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bqWhDandL97Bvu59/uDG6UD9clI8/70krzO+UNEIp1yp+Mk2xVWwrd3Y7nJr+PTUZlcMdK75Pl7aFN+XyF+P34vmcQGLUl1gXmuUoRBcW5yGxOy5JBk1x0JxRMfNSmMiXpz6Bh+GNuReYYtz95QVqB2ltbLLxj5j6pin4tcE7dPTireN80L2d3ZHVA9tPCdX4h6fpQ4XHEyXqdwDOVqvfTQ9Xg7Cbxj9dvCr5nV5EnUT0xHFagLKTRn7igdbGkcdm+Qg0C/YGbHiMDWRMbKehdp70gGYuwIPnMy1L0infnSQ+7Ib+H51r+0lbOAXfmVunS9b9KB3JvseUAFEfX16PT5H6LFpbrk3Oal5a08PxmGt041pKe02MNxhO2YNLrakl9Cfe6n8WpuL2dzvfVeMebGLsWJpoacaVNdydUDgxaZNdI/7e4038c2sWqx9qX3wc561cjASlsKvXQnd6jIlaCH8JBW3B2dHRv0lRZfJV8NIdmE3km+4c15/eI3fBQOolNfBTLR9kwbuV4neAPP0RPCRgkByPcUdxW2617b0dvkl+z+ZqV+p2SXaNf15ZVM4+vgOjHRez3HTkvHHNkpFTPSwetzTQj5IsSiA7lOk7PiHtI4Er+EeYkers+kNLBvnik0ctyM29ELfVySuVEOJwHF/h4A3wBNznIBKZL+BLLK5yEGwNZCd+Bk1BdAH3n6S1J3ntKElkkjfvua3Kn4Y4ikP/of8GJ1KouMfDGXfEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199024)(1590799021)(1800799009)(186009)(36756003)(31686004)(478600001)(85182001)(86362001)(45080400002)(66446008)(66556008)(6486002)(6506007)(66476007)(316002)(71200400001)(64756008)(76116006)(91956017)(110136005)(54906003)(53546011)(66946007)(41300700001)(6512007)(82960400001)(38100700002)(8676002)(38070700005)(4326008)(8936002)(122000001)(31696002)(5660300002)(26005)(2616005)(83380400001)(15650500001)(2906002)(1580799018)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJ1a2RZTytQWGpvanRRRFlBbnhITUxPTEFweUdGKzZZUzJJanJXSkFSRlZa?=
 =?utf-8?B?aTRudmhuRXdLMWZiQTVZMXhKMHRwRmpnVElFWk1FMFZDNWdnUUl6UFpPclZo?=
 =?utf-8?B?em9FeGtNaUNTbWFOK0pldzUzT0JtN0JjaGdxMVZyRWR1Zyt3MGtwRENiOUlw?=
 =?utf-8?B?dVVCRFlnQ2xId3R4alN3QVRiMmFqdUlmdkdFVm9FYjNnZFJURXBkaHpwcTJL?=
 =?utf-8?B?TkFaTzM4NHRCNHkxb2EyblI0UVpvU1hHeHNlbC9yeEVpZ2lRczNwNEhGQXdG?=
 =?utf-8?B?UzJFVGN3MkhXd0NOYkhrb0xCYlBGYjIxd1UwVi9EWWRXUzdyZXlld1VMMGR3?=
 =?utf-8?B?eEUvMlBtM1VTQ0ZHam1mZm9LaHJ5c0t2UHZtOGRaVU5hWGNUQzdYS2JMbTc2?=
 =?utf-8?B?clFFQWtMV0hZeUVGcGlqS1NVRzF3OUFUU2hZZnMva3NzQkJURXQxem1rT3RH?=
 =?utf-8?B?VXNlZW0yTTNFTlFBdW95N05HSGYxUXRIZjNDUDE1djVac2NpZTVxRVVOV2tM?=
 =?utf-8?B?SjB5aFIwVXdoMi9MQllIWFJjOU9YR2tpSHN1Zyt6b1dqL1p1eXdNSGErSkxh?=
 =?utf-8?B?eU03K21YVTVLcEJmOVYzY2U4bERqa0hXWW1vb0NndFNIU0xNQTN5OXZ3WnBX?=
 =?utf-8?B?dkJsT2RkYnFRTUdZQkN0VGhxU2FuczdtRTdFRUlxUkMwRTUzQ25PczlzdjNZ?=
 =?utf-8?B?SzVrdDl3MGdRc3dza1lWcmhZQlpmNk5ONVUxSHhzS2JjMW1MM3dNQUR5NUFy?=
 =?utf-8?B?Yk5oWFhSdzdicjY1eC9ra2xwM3dxb1Z1UXViWmtWNllVb0xwS05ybFFCNFhO?=
 =?utf-8?B?UVlEYXdjU1ZmRCtWNUZCOXBiYjVvd2VXdTF5QXJUUjcxOGZkVmk4NWM1dm9I?=
 =?utf-8?B?ckVpcHRFT2hESlpEQktlbkpiYWFReUpvVEN1MkNLLytNZllPK2Q3bmp2djRn?=
 =?utf-8?B?TFRsQ1dXTU1aMEZVYTdSODZJN3NEZmhheS83SkNiQVp2S2Uzd25UbGVlVS8w?=
 =?utf-8?B?OXNrdS9LQVlydUxkdVlsNlU0dXFmQTVuWU8xai9nekhYY0hoR05OTVphUW91?=
 =?utf-8?B?ckFibGwyNTFLQVY1WlhsNnRNTXdYbUQwcm5ydUNheDdZSmVEakRZazRMak1Q?=
 =?utf-8?B?ZkxvcUsyOWZSQ1NRZWRTS3lmQnVBekkzeTd0aVZoR2Z5UnRmQ2xCRStWUTl6?=
 =?utf-8?B?QUh4MnVNaS9BcmJidm5YOXdHcG92UGtxQVNWYXVtWFpSQ1VTa2dMODZrblB2?=
 =?utf-8?B?bGkwTmlsMXFvd1Q2dXNaTThpWEYyeTljOWdsS2pkQVM0NjQ0bERwT2p1Uk1B?=
 =?utf-8?B?dkdYb0tUODhzS2RFamFLa09ZenFKZlcvdWFiemtSMzkvekZCY0VKZFdJRStN?=
 =?utf-8?B?STIzWjYxUk1jR1hMaTdQVVRhR3ZiYWtkam1Rd2JSdnhYd1dTVmRvZXFlZ1FX?=
 =?utf-8?B?QmlFU25UbUZQeXJIVHBKR2FXT3J2OUxKWWdFNEJnSExncm1JMktRVTNtbWtY?=
 =?utf-8?B?VjZPdk5EK2R0OHJ6QkxFZWJlZGdWYjZXRzZqSVBJUEZmaDY4YTcxZ3F4UnNX?=
 =?utf-8?B?MEFTWkk0WmR4UDAvK1Q0eG9aRHc5MjFDVGdNTnhyaWpCdEsvY05Cb3ZySTh3?=
 =?utf-8?B?SXJoOEVSS0phU0JUSW0xOXRvRUIrL0ExR1JueGVMYXJYLzdQVkhGNks1dTVU?=
 =?utf-8?B?UmNabmZtMWJNVFY2R3FkK0FPSXVNTks4WkorbmJNU3hjTUxvVGQrNnNJNXpj?=
 =?utf-8?B?VUdVbzZHN1lDd3JWbVpGb1hTclA4MzdqMkhGZlVCSk9wTGZEZ0ZLK1VOTmxV?=
 =?utf-8?B?Uk4vZ1FQT2xaTVcrcHUzZjlCVXJZSzd0ZDN0Um8wQTk1M1BXdzBKWlpGZXBp?=
 =?utf-8?B?aTd0MVBFSUoxMmRPUUh2bUhBM29yUTUxZExPRDNqdXJqUUd5UHVMcHdvaUN1?=
 =?utf-8?B?NVBVdHliS1BmKythM3I5TVJ1MW5yRk9kclZlWEVnOEZnajdWdmpFU2hGRnpI?=
 =?utf-8?B?KzdOODJzbElTMG5Ob3lmN3U5ZVdJNTV2SmVNZHN5N3FJeHphTTJMcUZPL2xI?=
 =?utf-8?B?WUUxMmI3dncvRjFCdmFRRHdqd1JJK3prZ1pObXNyUHd3K08rMjhpUXhrdWR1?=
 =?utf-8?B?cnBFeEFCRXA1aFJHbmp4eFlob1ZYU2xqY1lBeEp0dGExU3I4MFgxWiszb1k2?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7F3CB65031C5943A49ADDA3128DBA79@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MLCKu9ILkFj3vCGyS8bYrKoPINk+jc7Kc67ozzYHG2QPaydQG3D90R3G00ETzbvbRiv2YUcSArGA/MTADw1t2SNfwhLZ/BgleVnHZDC/pU+2QZBcR7wLJkahQ1J9QjwgR+HOTAdny/nvDQ6N+S/OByinktajjptTfU/tKhoWNNR77R+WKzPqrVItHTmhUvuB11RoMvm7/PyiziqwIvO0jaerpv/htto5GiDfx2ReDqTDSieYGk2nxYmatm7pNFJn+OGYJpOVRUb2eI8USfQQGfciHRXkYblRVAKPR6Ycr4M3DTEVEMdQ4t8WV6NAyhSSIkkKVBAhikjoBqbbpYNlZyz7QN3N/osj/uWnAk8j6w1K9PZzYREp8w75tyRIw/PZ3+aFG08YN9IRAaxgX6axZZQE0HZ042wdrbtiJVK+MekUL7dGgEw59/m8mXufV8XHxS86u7fa+s6nY5r6sA3gN8e/LO6oFIwsQv6KtTfIPu+x/G6U9Y3+Pn6UMgYEpLhDAn+mJrdDRtSDO1ooFmwRAdGkYjnEGEXtRgPv58EVCx1C/85kpMqs1qmfwTwq28WweMkdhzsxOo+2pTYKeJyIhPJdNaWodniitt0q+n/G48f4S7HU7G6jm8N2lGwjMP9LWMDfrerQNJvGgWSiPSwlYO9xoOgr6TWWVtVwnHWiKpP6+FB7z2J4nabDmJ2xNS2ih4P+b9sZF46DDfTHJluZM7bfdn1TkylauDImUwdZfjKrM1ETjK5WxmeCgK3Rn1ia5BqaOhr/EEW2XTTk181JofWsLzG925s2XqQuMIz5RGekpdfK5z8wXrQteHSfZG74+vORpmfgPSnvnpyfauWuhIdsmAONRCzYPKDSWTLqcoI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c89706-f484-4364-24b1-08dba3a8e87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:16:45.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cka5YfxZE+N6tUumSN5Ap7bPc5H78D8FANhOXILmfqN5Ptxj0r91mxihxYWrNQEegFUfe0HACK9ZwYN+XsNWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8517
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjMgMTU6MDcsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+55SwIOWkp+i8lCB3
cm90ZToNCj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgMzoxMiBQTSBMaSBaaGlqaWFuIHdyb3RlOg0K
Pj4NCj4+IFByZXZpb3VzbHkgcnhlX3tkYmcsaW5mbyxlcnJ9KCkgbWFjcm9zIGFyZSBhcHBlbmVk
IGJ1aWx0LWluIG5ld2xpbmUsDQo+PiBzdXQgc29tZSB1c2VycyB3aWxsIGFkZCByZWR1bmRlbnQg
bmV3bGluZSBzb21lIHRpbWVzLiBTbyByZW1vdmUgdGhlDQo+PiBidWlsdC1pbnQgbmV3bGluZSBm
b3IgdGhpcyBtYWNyb3MuDQo+IA0KPiBJdCBzZWVtcyB0aGUgc2VudGVuY2VzIGFib3ZlIGNvbnRh
aW4gNCB0eXBvcy4NCj4gUGVyaGFwcywgeW91IGNhbiB1c2UgYSBzcGVsbCBjaGVja2VyLiAoTVMg
T3V0bG9vayB3aWxsIGRvLikNCj4gDQoNCmhhaGFoYe+8jCBNeSBUaHVuZGVyYmlyZCBzcGVsbCBj
aGVja2VyIG9ubHkgZm91bmQgb3V0ICJhcHBlbmVkIiAic3V0IiBhbmQgcmVkdW5kZW50DQp3aGVy
ZSBpcyB0aGUgNHRoIG9uZSA6KQ0KDQoNCg0KPj4NCj4+IEluIHRlcm1zIG9mIHJ4ZV97ZGJnLGlu
Zm8sZXJyfV94eHgoKSBtYWNyb3MsIGJlY2F1c2UgdGhleSBkb24ndCBoYXZlDQo+PiBidWlsdC1p
biBuZXdsaW5lLCBhcHBlbmQgbmV3bGluZSB3aGVuIHVzaW5nIHRoZW0uDQo+Pg0KPj4gQ0M6IERh
aXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+IA0KPiBH
cmVhdCENCj4gSSBhbSBhZnJhaWQgdGhlcmUgYXJlIHN0aWxsIDQgbWFzc2FnZXMgdG8gZml4Lg0K
PiBDYW4geW91IGNoZWNrIHJ4ZV9pbml0X3NxKCkgYW5kIHJ4ZV9pbml0X3JxKCkgaW4gcnhlX3Fw
LmM/DQoNCnJ4ZV9pbml0X3NxKCkgYW5kIHJ4ZV9pbml0X3JxKCkgaGFzIGdvbmUgaW4gbXkgdjYu
NS1yYzcgPyBEaWRuJ3QgeW91DQoNCg0KDQoNCj4gDQo+IEZlZWwgZnJlZSB0byBhZGQgbXkgcmV2
aWV3ZWQtYnkgdGFnIGluIG5leHQgcmV2aXNpb246DQo+IFJldmlld2VkLWJ5OiBEYWlzdWtlIE1h
dHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCg0KdGhhbmtzDQoNCj4gDQo+IERh
aXN1a2UNCj4gDQo+PiAgIEkgaGF2ZSB1c2UgYmVsb3cgc2NyaXB0IHRvIHZlcmlmeSBpZiBhbGwg
b2YgdGhlbSBhcmUgY2xlYW51cDoNCj4+ICAgZ2l0IGdyZXAgLW4gLUUgInJ4ZV9pbmZvLipcInxy
eGVfZXJyLipcInxyeGVfZGJnLipcIiIgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS8gfCBncmVw
IC12ICdcXG4nDQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyAg
ICAgICB8ICAgNiArLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5oICAgICAg
IHwgICA2ICstDQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAuYyAgfCAg
IDQgKy0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYyAgICB8ICAgNCAr
LQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jICAgIHwgIDE2ICstDQo+
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX213LmMgICAgfCAgIDIgKy0NCj4+ICAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jICB8ICAxMiArLQ0KPj4gICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMgIHwgICA0ICstDQo+PiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMgfCAyMTYgKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0NCj4+ICAgOSBmaWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKSwgMTM1IGRlbGV0
aW9ucygtKQ==
