Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F755A737C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 03:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHaBss (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 21:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiHaBsq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 21:48:46 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 18:48:44 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2546DA3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661910525; x=1693446525;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XBa+9vKjKHkdD9svs8WBrNd/oyhJ1uCO8pmHKgBu4Gc=;
  b=KZkBFHa5CVHCNEESl6BeTuQxEB77x+enAr5v+CaAe50o0UVWekyfQbya
   4Djv37rDceiDSKmyQTdzO59NQEDslibdYLPhmXizSufUYOT0LvPxa5Vc2
   QWss3Uw/MW3F4CjElfcMVOy4/uBVAcL6xwwqtQkh0tON8lgKO6SmBDPUK
   SdwiRtW9F1yDEg3wQYvg27W8RgwzY20zobmvfdMHTlmxgyt8Zz19XhJis
   EaETcyEIBOhbArm7i4vpnl0TCP/GcHosPifqSYYqieVjC5O9JMJ6M7UK0
   K41ZiRHzHSPsC6jmys/hPX7BWj1C4mKd6FGRZUFh2AqX2/QPyGoLQL7tu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="63935526"
X-IronPort-AV: E=Sophos;i="5.93,276,1654527600"; 
   d="scan'208";a="63935526"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 10:47:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP7BjDA7egQjeUgjc3Xrv2pf6wI2k0croWTK7E3YaUnURh3TBg39pf6KDa+qUieu/eV3CihxrUoqNSMRei9IYP+gG0My9x5IkfSNp817XAEeLIgTC83JrDrVk/cG+nGAycehCGnHfDzm+zkYZbshZdYb03tgGDY4rea0jDaE4bnFTK0UWrwbNIvb4dgKfU2RxloO3ZAfMMxNrKCNS5Qtv0ir0J/YkQjwUv+m8D0vH9HCWZRO1TLoBRCBBn0VNm79CwvX5jduivgYRgw2jLwQ/67Vw1cRxwvPRByD3wxumKCkGjSnKHEii+8jA2lH4PDUOu6fyG4UquwkUV+878NopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBa+9vKjKHkdD9svs8WBrNd/oyhJ1uCO8pmHKgBu4Gc=;
 b=ii6KpCU5EauGs7DYn+wSsBSPkr4hsyT0J8FNWbX9FBsHSAc3qt8KtXwEAwXGDvEo2UlTh28a7O8dBU3NMazdwZsljQKozHB2FT7p2kpATy4yDMPnJ5OsJ9LXs6JqOIIGc7+YzOK8xyHxJedBJqwQ8+WZX8IshtBcyqtaoGmC7NpkhdJ2jvKAb37XXNwwi7tGIKnVB4EiRUgsRgQttPxkFNYsOSl9mnHUzTQFBbpjWAeXEO38aRtTd4X9OPnC20/1vY7peOQOv/gAymsgJAQ/FY+pQmSEzVjc9vL6643Y1C8fQ9Sl8p3yfjiR9b21xQx6l+BZUTN+qlIQg1pS42rUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYAPR01MB4397.jpnprd01.prod.outlook.com (2603:1096:404:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 01:47:34 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:47:34 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Topic: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Index: AQHYvNukv4zzfaSRMEm9MHXMyi33Ug==
Date:   Wed, 31 Aug 2022 01:47:34 +0000
Message-ID: <20220831014730.17566-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d187550-e131-465a-c4b4-08da8af2c699
x-ms-traffictypediagnostic: TYAPR01MB4397:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQxInG40ZOQamBrrHnR0XnQl90c+/qzep7/aAqi5612yWqJoELfNWseaTkcISylp9buemzrLgRYias8EWVzN49jMdSeFcyPncU+gFTdJW78yBDTv0986S17YVcYYnj9ZEOZWD5k+9kCLQbvBSn8Cv47uCrduw2BwK7HhlAuwJrTIFs1mWUl26itl8fB20ta8UwtkLHlMV7ARx+gKOQx6MvgoooLIjxmtIwYvgxKVorlh7GcH3yqRa29ztP+UBwPYsw+CTTzCk4vheITDhDQDC4OoOb6CFjfXWGQt0btGJeJR/BQvsS4nWl8fGD2DYyQBIRKC3o/hKbHjE9HzrlYe2t0CSU53i+xYWT2Eh+l8PbwGhDerBavn2Oxf0bC+SbxVm+hWhwCy8Ltx/WL/jGW+5O1eCOhDL5pGiZM+vX5Km/Ku/mPLmFoAS9DlioTswiByqPqP0gWAKFQb1I/hR7xjILHFSKsSvCX1b8bhb3zPo7ey0kzLd0juEqGBDNjZaoAaRYSK6eEToB9jiqbsVgodsVPJEZcGyfoV35mP2yFXyBMAJyDHw/Fv3GyG1fvsrqMjlU3Acg3lFe85rzEfuyCQKEqZmeLOGgtYH2X5WEhD3BJdx5EkNxmMAsZqJ39MindWoKAB/5H9uUwl3yb52+fLYviWg95l7XkU6w2SoeLHqCmVxXmQaB54Yar7h/bdVPeUzK/HXyJJHffPKRm1VgcGD75I1O3mIbNelLeL2OsLydQoaQt30GDK10G6gjuxsBTRVBQ8YnmI02PQY8HmsK0SnuFpbJOt8aICHxog1hBGwI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(1590799006)(66476007)(122000001)(76116006)(86362001)(38070700005)(82960400001)(91956017)(54906003)(66446008)(66556008)(110136005)(8676002)(66946007)(64756008)(4326008)(41300700001)(5660300002)(8936002)(38100700002)(6486002)(316002)(1076003)(478600001)(186003)(2616005)(71200400001)(2906002)(6512007)(1580799003)(6506007)(36756003)(107886003)(83380400001)(85182001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TEhnL1poRGJyMWVTc3kzR3loT25LSE1GN1ZIWUpDMFc2cFduZXNWMTJ2NzVa?=
 =?gb2312?B?TXhEMW1ZbHJBNU0yQ3piLzZLVWxTZnZVU0F5anNQRTcvR1pUQ3MvbXpsL1Ar?=
 =?gb2312?B?c0MwWGVjakRSNUVmZng2N3ZHNWhZREpyeDk1SE1VN3lVSkdySW9HeG1EbDFm?=
 =?gb2312?B?NkNwck1jbzh0L0NRMjg3cVhBU1Q4UGNZcGlVYm0xbWlMaC9wM0svK0F1SXlY?=
 =?gb2312?B?MVh4a1dYR3ZRNzREb0x5eXNQWUw2dU13ZWVaWUJmeWJzRkpzSUNNNmc3dGgr?=
 =?gb2312?B?S3U2eU5BTGIvME0xRTBUcmJEVG9TUnMrRTNXWkFCZ1pqWU1seDJyeTFtSVJy?=
 =?gb2312?B?UHpKM2pKUlFkVHJjV09EZmVQVWRtdFB1bFFwYkJ0RG9BR3BtNWFpQmY1Rzdl?=
 =?gb2312?B?cWpFSWVIRnU2MVlVWkRuZVY4YXhSU1I0a2NHY0RCLzh3ZXRHT29SNE1zSEpP?=
 =?gb2312?B?dGMrU1V4ZXc2U0hEOWJ2TTBIVDk0Q09rZU4wQUcwMXlab3ZkR0wydW9rZEk2?=
 =?gb2312?B?NVZOUStUWUhpUjVLUzFqdURTaWFvK2prYmxNalZaelFPNnZQOVc3Z2EvSnJY?=
 =?gb2312?B?aGFkejB6Yzg3K3NtRXpKUUdZT0hxcmdIZDkyMC96d3RldnRwWDlXYjFKOE1D?=
 =?gb2312?B?aUdkTGxSVmRYWlJSVHlQU3JCNVpiL1lnQmRhcjY1WlRuN1dWTTBDdTN4NmRz?=
 =?gb2312?B?cDhiTEs5MzhNQ2lheGs5bUNjRmNScDFVZmlCdHJMRFBsS0xpb2t6OTk2MTkw?=
 =?gb2312?B?TWhwWi9lN2V6YUFzVng3V2xvWWNPT0Z6cFNjT2Vpa0paMTFHTnlsVkRsNFNL?=
 =?gb2312?B?VUdITFNhdlpzSHNucDBEM3BFNHQ0Ri9wYmhhVHhPRkhsR1Y1Ukt3VEhKbHRV?=
 =?gb2312?B?ZU9oTy9PVG4yZWtwOTN0K2hoRERWQmZtc2FZc3cxTDlNdGRxTENpN2t3MU1N?=
 =?gb2312?B?NjhTSms2Tk9yd0dsemhGdWRwNGxmdWwyam9RblFJZzBJMjk3T1htL0FyOUkv?=
 =?gb2312?B?T3Q3aU5ycGZlMmhiOHBzMEIreUVsS0c4cG5neFVWbHlnb0R2MUlnb1V4dzRy?=
 =?gb2312?B?N2krTkR5WVhmNDA4SWlDNzI1Z3h2TnZJQTdzNFB1SXZ6NHlKcFdaNC9Vcjls?=
 =?gb2312?B?NnFqcklmUXBDTlh3U0hRc2RaUHpzc3dmUkNSMHFodUNEcXpqVisxUFhVdjdD?=
 =?gb2312?B?NHRiK1JaYmF3d2FlZmdSWTFtVGw5aDZFS1VIYzFsSnZUNTM1c2syTGFiVXE4?=
 =?gb2312?B?RjVURm91b20yYTNiR29zc1dWZC9ZaXRoZ2VGcFFuME1xeHlSMjNyNjIxcVB0?=
 =?gb2312?B?LzJicHJ2b0h3eW4yUThDanRtZGlFWEhXbjJQdlpHbmYzSmZ4QUFDZ0hRdTJr?=
 =?gb2312?B?aVJqWm96L0xGYXpzTUZwd0NrZXhhUFNSMllQQ1Fmd0p2dGhxVEVoMHQzRnFD?=
 =?gb2312?B?bzE2c1RVemZ2bC9KanptNmF3Sy9iVm1saGhmd09hRysrcHBqRXdydjF6ZWxH?=
 =?gb2312?B?UU8yUW5YK2V5VktmU2xGR280WU83bzRnMFZXYWdWWkRYVVNReGxuU0I1UTNr?=
 =?gb2312?B?OXlsT3lvekN3Q0t5eTNwaUlFQUxYWHVmU2ZJSDFsR0w3bTQ0aytzN3B2ZWE2?=
 =?gb2312?B?eWNyNzgxNUhuY3BkQmdKRkNxa3pvQXN3QzlTTlBpS2U3dnhRUnovRDlqTGpu?=
 =?gb2312?B?dmhlK3RFcmk0c2N1R1RBdlJLN051emZpWndVUGsrak5UNHVYNEloUGp2Mmdx?=
 =?gb2312?B?MXNWVm5LMTNiNGhobklpdG1NY1RrMVpmWXBURU85b2x0Q1ZxazV6RXJyTXRp?=
 =?gb2312?B?eWxmYWpvdVdHc3cybThVcGJRS2dkTTF6K3FyZjJhc2hCVU9ERlZyZ0xMS3pZ?=
 =?gb2312?B?TWdaSFo2bXNHUHlzNnpQWlZMcmx1TWpYVDVaakFsenBzVUU2RVBsa21aVy9W?=
 =?gb2312?B?UGpKZCtkdFpEVmh3bVd1RzF4WkR3aHhmQkRvVzY1Tm82UkVyenRsNTUvMHBz?=
 =?gb2312?B?bXBkZ0lHOTBac1N3ejBYdXZPTlhEclpodk5jWXZGQkFSa2QwRHV0K0V2eXZk?=
 =?gb2312?B?MS9RTlBlTyttWEg3YXgvNXgxWmhkVW0rSkpCZlgyaVFEWUJreTNCc0w5WkNM?=
 =?gb2312?B?TTNvRy9PYVRzbUVIbFFRdld2WDBuN2Zpa1FKUkhwaFh5M0RCRlBvVmFLUTlL?=
 =?gb2312?B?SWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d187550-e131-465a-c4b4-08da8af2c699
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 01:47:34.4875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfl9nRnrVZy38i+GLXx0z7gGj1kUnTdyMIk4SZLYbIUVwOwzIIzAiHbuBAvToA6Czhf/XGejGwiQQUol9M5RoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4397
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBjaGFuZ2UgZml4ZXMgdGhlIGZvbGxvd2luZyBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlDQp3aGljaCBpcyByZXByb2R1Y2VkIGJ5IGJsa3Rlc3RzIHNycC8wMDcgb2NjYXNpb25h
bGx5Lg0KDQpCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAw
MDAwMDAwMDAwMDAxNzANCiNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1v
ZGUNCiNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQ0KUEdEIDAgUDRE
IDANCk9vcHM6IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KQ1BVOiAwIFBJRDogOSBDb21t
OiBrd29ya2VyLzA6MUggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA2LjAuMC1yYzErICMzNw0K
SGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1Mg
cmVsLTEuMTUuMC0yOS1nNmE2MmUwY2IwZGZlLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQN
CldvcmtxdWV1ZTogIDB4MCAoa2Jsb2NrZCkNClJJUDogMDAxMDpzcnBfcmVjdl9kb25lKzB4MTc2
LzB4NTAwIFtpYl9zcnBdDQpDb2RlOiAwMCA0ZCA4NSBmZiAwZiA4NCA1MiAwMiAwMCAwMCA0OCBj
NyA4MiA4MCAwMiAwMCAwMCAwMCAwMCAwMCAwMCA0YyA4OSBkZiA0YyA4OSAxNCAyNCBlOCA1MyBk
MyA0YSBmNiA0YyA4YiAxNCAyNCA0MSAwZiBiNiA0MiAxMyA8NDE+IDg5IDg3IDcwIDAxIDAwIDAw
IDQxIDBmIGI2IDUyIDEyIGY2IGMyIDAyIDc0IDQ0IDQxIDhiIDQyIDFjIGI5DQpSU1A6IDAwMTg6
ZmZmZmFlZjdjMDAwM2UyOCBFRkxBR1M6IDAwMDAwMjgyDQpSQVg6IDAwMDAwMDAwMDAwMDAwMDAg
UkJYOiBmZmZmOWJjOTQ4NmRlYTYwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KUkRYOiAwMDAwMDAw
MDAwMDAwMTAyIFJTSTogZmZmZmZmZmZiNzZiYmQwZSBSREk6IDAwMDAwMDAwZmZmZmZmZmYNClJC
UDogZmZmZjliYzk4MDA5OWEwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAw
MDAwMDAxDQpSMTA6IGZmZmY5YmNhNTNlZjAwMDAgUjExOiBmZmZmOWJjOTgwMDk5YTEwIFIxMjog
ZmZmZjliYzk1NmUxNDAwMA0KUjEzOiBmZmZmOWJjOTgzNmI5Y2IwIFIxNDogZmZmZjliYzk1NTdi
NDQ4MCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCkZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBH
UzpmZmZmOWJjOTdlYzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCkNTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCkNSMjogMDAwMDAwMDAw
MDAwMDE3MCBDUjM6IDAwMDAwMDAwMDdlMDQwMDAgQ1I0OiAwMDAwMDAwMDAwMDAwNmYwDQpDYWxs
IFRyYWNlOg0KIDxJUlE+DQogX19pYl9wcm9jZXNzX2NxKzB4YjcvMHgyODAgW2liX2NvcmVdDQog
aWJfcG9sbF9oYW5kbGVyKzB4MmIvMHgxMzAgW2liX2NvcmVdDQogaXJxX3BvbGxfc29mdGlycSsw
eDkzLzB4MTUwDQogX19kb19zb2Z0aXJxKzB4ZWUvMHg0YjgNCiBpcnFfZXhpdF9yY3UrMHhmNy8w
eDEzMA0KIHN5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCsweDhlLzB4YzANCiA8L0lSUT4NCg0K
Rml4ZXM6IGFlZjllYzM5YzQ3ZiAoIklCOiBBZGQgU0NTSSBSRE1BIFByb3RvY29sIChTUlApIGlu
aXRpYXRvciIpDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29t
Pg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3JwLmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycC9pYl9zcnAuYyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC91bHAvc3JwL2liX3NycC5jDQppbmRleCA3NzIwZWEyNzBlZDguLjUyOGNkZDBkYWJhNCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jDQorKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvdWxwL3NycC9pYl9zcnAuYw0KQEAgLTE5NjEsNiArMTk2MSw3IEBAIHN0
YXRpYyB2b2lkIHNycF9wcm9jZXNzX3JzcChzdHJ1Y3Qgc3JwX3JkbWFfY2ggKmNoLCBzdHJ1Y3Qg
c3JwX3JzcCAqcnNwKQ0KIAkJaWYgKHNjbW5kKSB7DQogCQkJcmVxID0gc2NzaV9jbWRfcHJpdihz
Y21uZCk7DQogCQkJc2NtbmQgPSBzcnBfY2xhaW1fcmVxKGNoLCByZXEsIE5VTEwsIHNjbW5kKTsN
CisJCQlzY21uZC0+cmVzdWx0ID0gcnNwLT5zdGF0dXM7DQogCQl9IGVsc2Ugew0KIAkJCXNob3N0
X3ByaW50ayhLRVJOX0VSUiwgdGFyZ2V0LT5zY3NpX2hvc3QsDQogCQkJCSAgICAgIk51bGwgc2Nt
bmQgZm9yIFJTUCB3L3RhZyAlIzAxNmxseCByZWNlaXZlZCBvbiBjaCAldGQgLyBRUCAlI3hcbiIs
DQpAQCAtMTk3Miw3ICsxOTczLDYgQEAgc3RhdGljIHZvaWQgc3JwX3Byb2Nlc3NfcnNwKHN0cnVj
dCBzcnBfcmRtYV9jaCAqY2gsIHN0cnVjdCBzcnBfcnNwICpyc3ApDQogDQogCQkJcmV0dXJuOw0K
IAkJfQ0KLQkJc2NtbmQtPnJlc3VsdCA9IHJzcC0+c3RhdHVzOw0KIA0KIAkJaWYgKHJzcC0+Zmxh
Z3MgJiBTUlBfUlNQX0ZMQUdfU05TVkFMSUQpIHsNCiAJCQltZW1jcHkoc2NtbmQtPnNlbnNlX2J1
ZmZlciwgcnNwLT5kYXRhICsNCi0tIA0KMi4zNC4xDQo=
