Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AE5FF8E3
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJOHAe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJOHA3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:29 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFEB2C138
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817222; x=1697353222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NeCYmGxkqhrYiF2XPUliL7Jy4PA73vbLQMF31snSS24=;
  b=vPtg2VGRQyVLaorx3nG37zjn49QmGmaH5RqcM95WBRFuz1KAtk0Mk8Ck
   F5GB9IgJncFJ6vw8MmLD1m2Cy+Uv25V2VO03omNxKrXNWvrUzA4BZsvGg
   iFNWa0qMyT/kPnSXZUMu3+VkLMMqZ26GtnGrHPRyJrD2ZHFddueVq3GcR
   ZqubfbVP1HpaCoFjbMfyBhcn+3gpzw7M+EN+QeDsDS/zlY/Zrdzb9qXEL
   DRVX7G31MYPskeHB2kqWLBfFPe93yf2KcCoSxNrF3MAwq+2K1dosxZ3Xj
   03uV5o8FEfx/SJNISvTwkItJk7pVU137XiO/9L24oDNHUinsr/R2xY9Z7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689755"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689755"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c499JLi6TG5Rre3T8Eb7HQW218kT6NJSBsEAEEX6YRYOjCKKKQ9XlALqrHtsSbnQ8jsEKk3kQj1y2XE8Tu+tZnzetQXaeUFcR4/JEfWt0dwcwHDWovLoDksNxWOClupKlATz2PQyCeYXkSn0Ed0ZA7YysdigVkuvglhf09w7zwDbjTCd7+VNtdB6LjOwD7A9ufpEtN7tiXZBM2d8M+UKnPnmYZNlrZXYlkEGm1eytvJ/e7SiDN0jp5MWx8Iq9TU5IWI7yolkvoBqjcvIcJXOCBDxKXnmnIAsydxqiMy0IKN018Olj/6FEZSkbl7i+KesmxQ+aKyFODmCTs8d6nTKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeCYmGxkqhrYiF2XPUliL7Jy4PA73vbLQMF31snSS24=;
 b=lVSzTNjHqpNLAsBhtFV5SSI6QO+0brjbUbEffGwg/kpfGdiyJt2J/HiqIiMITk7DQAzRSSpXSwAIOukvVW+zIKdkkLUq7Exu6fYqDS0yzeB6wl/RvEPWD/+ukJ/wKFweW3nZa5UKRVndvcPuZ7HOSUCFo6VKAfG06uFRwWN5BGgAckm/vRuwZHZA5xV8+LRLN6t12KAcKkMzuKnt1taPoj1m9HQyMKfgN22ji6MfplH1rjSNNidLUp8H5z4DjUPJwZpd55ItUpBaeqAuP5DsAfbaCUXpm2jugLOxqBjSYvymCM0l/pTAgcta6QtwofrxBcZX3hNLjlL6s5lxloDp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:08 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:08 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 7/8] RDMA/rxe: Implement atomic write completion
Thread-Topic: [PATCH v6 7/8] RDMA/rxe: Implement atomic write completion
Thread-Index: AQHY4GCMCOXD8vqMvE2EvZQxyfbfXQ==
Date:   Sat, 15 Oct 2022 06:37:08 +0000
Message-ID: <20221015063648.52285-8-yangx.jy@fujitsu.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: ca26f850-1ee1-42a8-bf9d-08daae77af0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qroStfwo0u4yXYQxMvsGES41oySS0Lcs8hP71X/9VzUFYfIh1L0YlkwXJPe4YK87mp84yWhkLET1zDsZvTC4jXIPbMid0IRTWgthsmDgrBwIpK/YpPp/8HwwD8ip8PaHIRhtyP7g5Zj8MDPArhQJ4VkVpxpF1KccuItK+vW49QU1unfgOlt8pFJqWAbNDCI3irlIUHYKzWVR79iwRxvXxQ/cnzLzViqQ0mRLaC1ueEHdOpSh83NW7a9e2w99L4ZTjPIv7+P49A7Ih3WfRVeBa7MAtYK+BXtY0qRRfJo8wqDmrA18/nBukAvjID6guHlWFDN9vYPmHF4xgY0fqj6s1zvhi1IE+0yWHAd0ksEG2D8fGvJ9hV6L3tG7fpCiOnam7lazv7IzEAZidL2Cc0yfTMxx0Iggh/sjJxdDtI2ApsTZHmThIn5GXTEKjXC7hP5M5dy3GOS+ltv91EtT6m+Ifd1DYFpdbUpH9131z0j9880pgzbATeNNKyr+r4EMs1QUhmw1shZFgPlSyou7X5EzvlkTmWyBiEO1ftqiOfCnnVDy7Ok89acHLv8vYGNCYwfh8z96gdpMBw+44I0Dyagdt78/umYtHbgFbWEfpJuig0W3WXFXxYrNnLtVbuIVS4iHBKMRrORkVtuudYwBvgdFxcQjiNRskuJ/g5hW41I9hiKnTueJjFx9Px+xxc72b/NvUitT+0nsDm4grvHeoB5n5Nmu42b4Yk2pQZZTh79S/ouPQNOH60IIF/We6Nucv+DosTY3cawZDsUfLYIfAxjZFQYbSEe482Slw1W6FKZLzj8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(83380400001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NTIvQjYvOXNOd0gxQVdqa1BrdzlQTlZGakdXaWMrdzUySEFwaitqZU1nTjQv?=
 =?gb2312?B?SFNGem5aOWNRMlJkTThMalRDcForRUc2MmdjR045bGNVajVUZXFrWW5GdlU5?=
 =?gb2312?B?MnFjMmJtUHhWeGRpdVloNTYwYzdISUZJTElzMDBOTThsbXI4YkMrR0JxQnQv?=
 =?gb2312?B?ZndTRGt5a0ZmemlQb000YzB4ajlCeG9hNjM0SE5HNmhzenp4NFpxbyt5cTly?=
 =?gb2312?B?SDFFMi9VWVV0Rk9QRGNrK01LcUZ1TWtua1FJeGVHMDNzUzJpR0c1TVJ6MW1x?=
 =?gb2312?B?dGhjbEl5YTM3T2V5dzZQdEw1Z0o3aEx2eVAxTGRlT3RORU5SWVhTdjFJT0tN?=
 =?gb2312?B?S1lNMml1bmMvUnlnVzZQaUxWV3NOKytXZkp3aEF2SmhmeTVBQWlIb1hrNGJn?=
 =?gb2312?B?ZnFQaitiZVdicEV4MXRmZzVkMjd2MS8yQ2ltZ2ZOYkdUZjhQSXRuTDFRdXVq?=
 =?gb2312?B?SXUyZ1h5NFphWXBNcWtpZElnNEZ1c0U4WVJ1eStkZjl4YTRWWVhZK3dYZ1dr?=
 =?gb2312?B?QmZ6bG1TSG9sTFNzM3VnRVB4QjhBcnJkazNyWHNnWDZzUkJoOGhNTGl3aVRL?=
 =?gb2312?B?ZVVRNFRDNVp1eHB2dkxaTjRoL3JkVzNEWUY1eER1TWM4SzdlbU42d2RwUlZs?=
 =?gb2312?B?eFlObmVocU5ZTDR5aGVXM0t5RlNJNkM3V3kyK0luNTRmK3hYN1VObDdvd1hU?=
 =?gb2312?B?TzVwREZKRk00Q1VQMDJOeG9TT0huTnlaMVcwZjFKYXRnTWhmWmV0K1RnUWNN?=
 =?gb2312?B?UC9RSkdVZHRVNXJRdmM4aS96K0xpeHBSK1JML0M5SUV1aGR3Y2VPN1BZclBS?=
 =?gb2312?B?ZHE4eWRqTEdSZ0hWU3Bxb0YrQStUNnlEcmh3REE0SFNVRnZhT0RFQWY1MGpm?=
 =?gb2312?B?NXo5Vm5kZDJ0QU5kY1VhbEFPUHZoY1pWUTZOQ3kyRlYzRVBXb3FyVitlb0tC?=
 =?gb2312?B?RTFSdjhWMmZZUFBXSlgyRXRKTUE1V1orUzZ1VitTMm9KWDBsVGx1KzhIZU5T?=
 =?gb2312?B?OUZ5Sm1tY3YxamcrMzVPZmNJVS9Za1NZSXBuM244a05YQjh0N1ZwMmIzSXNC?=
 =?gb2312?B?WUZwOGgyWDVlQzJmNXdwSDJCWEp2b0ZLMVNINWE1NWRXekN0TWxvckhJaXBj?=
 =?gb2312?B?MXprN0Z6RmloZW9ZUWhBYlcvTnlGSEJvL0paVFdsb0VwSFdCS2E2NWVVZE4w?=
 =?gb2312?B?bVY4VytYQzBmVkt3RkJ2ZkFYQjlEWlRNV1p5VGNxNjhyNmFiRnBoT1AvNGp2?=
 =?gb2312?B?eXArTU5LZVJHNGtic2MvTEpVQkl0L1JKb0lTVDViM1BCN29KQzR6QTh0WnV5?=
 =?gb2312?B?ZzU2S1ZBN2NTYTBLdDJTbDVyT2xNRkhhVm83Mm5WZlIxQTcyZXd1Vk13QUpS?=
 =?gb2312?B?YzFGUEVBMW9sd3NjR1hDWm1UODhTVnl0TWRrQ3BhMVBXa1RHd2FsUzJUUURk?=
 =?gb2312?B?d1hkaE9XanFBVEhVdXFyVTVLNnZ1emxhVTRieG0vYzF4VVIyanNHV3hVaVdu?=
 =?gb2312?B?WnNOY0lDc01PWlFTQVVVZE4vUmRjK1N2dkZoTEozMlhYcUdqNEdDMU9CdFh4?=
 =?gb2312?B?NGlTUmhvRW9uU0RreVEwQW0rOGNnNG5KMktUcXFFQWhjc1NsTHZLMXJKOUFy?=
 =?gb2312?B?L2puWnNvUTVtZDZqcmlrekhGQ0VHVnFqNGoxeFVhcGhwKzRmZklrNmd1bmMr?=
 =?gb2312?B?SGMxaTJEU3BUeEMvWWZ5WDg4Zlc5YzRaNjVDWTFmeUlWajU4UDV5eGk3MW9L?=
 =?gb2312?B?YUNsQXRXRWhrd3N2YTBXbVlkM0FXQ1M4aWsvMzFxbGFKQWNrbC8vQXVzOE80?=
 =?gb2312?B?VVF4MHJVZTVWclNtSlFVUkd6Y3dBTnVFZWRjYUlDMHJqRUE3bjN2NWNSc2d2?=
 =?gb2312?B?U0Z6SlNldjNrYTNBZHBFb1lDRDRsOVNpZ1BEMWNkTWhQT3lIeTlFN3paWDIx?=
 =?gb2312?B?OWFmNDJhSkpLNENSU3FOOWNNMHAwNEp0NnNvWHdBZnZIZTZNU05lQ2NSano4?=
 =?gb2312?B?b2tDVW5jejZYL1hKZVMwaytvZmhLK3BvOXFzbjdOZmFpQnhqdjMxTXovc0Jt?=
 =?gb2312?B?b3U4M1ZKTkRpMGd6NTBDT1ovZlZqY2RWUVkxT0FNYUdSYVdtSTA1TnlVSjhh?=
 =?gb2312?B?aVIvdzRKU3VaVlF2MG9nU0g3N29YU0RRdW1yekYreHpzV2lWY3ZvUWZUTGhm?=
 =?gb2312?B?VGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca26f850-1ee1-42a8-bf9d-08daae77af0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:08.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXCJVRsYxdIEsZOOTJtDZnaB78Bf5yFXBtQ2puH3JNMGJVJ6Patgp+PmjLY5WoFNc1sjBPIw+iiZIZb7n9VoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

R2VuZXJhdGUgYW4gYXRvbWljIHdyaXRlIGNvbXBsZXRpb24gd2hlbiB0aGUgYXRvbWljIHdyaXRl
IHJlcXVlc3QNCmhhcyBiZWVuIGZpbmlzaGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcg
PHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfY29tcC5jIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jDQppbmRleCBmYjBjMDA4YWY3OGMuLjQ2ZGJh
NmYxNjNjYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAu
Yw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jDQpAQCAtMTA0LDYg
KzEwNCw3IEBAIHN0YXRpYyBlbnVtIGliX3djX29wY29kZSB3cl90b193Y19vcGNvZGUoZW51bSBp
Yl93cl9vcGNvZGUgb3Bjb2RlKQ0KIAljYXNlIElCX1dSX0xPQ0FMX0lOVjoJCQlyZXR1cm4gSUJf
V0NfTE9DQUxfSU5WOw0KIAljYXNlIElCX1dSX1JFR19NUjoJCQlyZXR1cm4gSUJfV0NfUkVHX01S
Ow0KIAljYXNlIElCX1dSX0JJTkRfTVc6CQkJcmV0dXJuIElCX1dDX0JJTkRfTVc7DQorCWNhc2Ug
SUJfV1JfQVRPTUlDX1dSSVRFOgkJcmV0dXJuIElCX1dDX0FUT01JQ19XUklURTsNCiANCiAJZGVm
YXVsdDoNCiAJCXJldHVybiAweGZmOw0KQEAgLTI1OCw2ICsyNTksOSBAQCBzdGF0aWMgaW5saW5l
IGVudW0gY29tcF9zdGF0ZSBjaGVja19hY2soc3RydWN0IHJ4ZV9xcCAqcXAsDQogCQlpZiAoKHN5
biAmIEFFVEhfVFlQRV9NQVNLKSAhPSBBRVRIX0FDSykNCiAJCQlyZXR1cm4gQ09NUFNUX0VSUk9S
Ow0KIA0KKwkJaWYgKHdxZS0+d3Iub3Bjb2RlID09IElCX1dSX0FUT01JQ19XUklURSkNCisJCQly
ZXR1cm4gQ09NUFNUX1dSSVRFX1NFTkQ7DQorDQogCQlmYWxsdGhyb3VnaDsNCiAJCS8qIChJQl9P
UENPREVfUkNfUkRNQV9SRUFEX1JFU1BPTlNFX01JRERMRSBkb2Vzbid0IGhhdmUgYW4gQUVUSCkN
CiAJCSAqLw0KLS0gDQoyLjM0LjENCg==
