Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD696078D0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJUNpg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJUNpd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 09:45:33 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4B14C53E
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666359924; x=1697895924;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yWWne4g6PHif5zZ6F03BhPx0zTULEGk1qy3d2EKENdA=;
  b=uKGNPGjbl9qisJDt9zgHiN+SvGPGJo0JCgQAnuwiwyKBoAKWcdaYhZqm
   b7q4OaRvXnz/UGLAo8Peo1xHnPl1OgOy0wtB/RhrM8hY9AKf5ydNZShVd
   YTN+soFsqRoAkxWaFjamVRM2p5ZI9E/JxI1F/+dkPqhen+/hqsCx1bVjn
   yFXO+0n/ReX4eQGBCHgb1tYoKIJorEso0uU7F5ZaF5sjKpRNrOsMTv7MH
   HMXZzZbFkhGBM0fueFZHWbZXbcj9t3N5ZqMjzUumiMdfgunJ8X4kxL7WA
   ea9aLbi4TkdKV0r8/fYPCSdX3OLL1uL/C3m/tJoL1D4xKs3kdxOMXGtun
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="68299332"
X-IronPort-AV: E=Sophos;i="5.95,200,1661785200"; 
   d="scan'208";a="68299332"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 22:45:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2wb/Jaw4SQ+CONGmNTI1MHpS/uyTEL+DdKgORJ9peUmkJ1TJ7JHTmhXUjx3SfDY2BiAQNhzXhikmHZ7O7Xiz5SPGgmaychy6SxJRnz41BPxh066zLXudxGzdgA2o3or4DvQfRgyJGRJ94Fgjp6PiRkAqC+Y91yp7Xr17+spp7P3vqiriNY6lCYX79gTO3l8LEo1rwSuR/V/SKqZ/jdqN8IHu4tjfl1qzPzMLqprYZUmnoPgpmjvsNe6Hh/NJBUwEnGp741EJ8UZ0o7wH6bal5x6IyqjQ39tJbgG04ng0gpyOCkc+9yE33zP6YDpOESBySrTBxX/W3moNaxpy23GEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWWne4g6PHif5zZ6F03BhPx0zTULEGk1qy3d2EKENdA=;
 b=e1Mi5pjFvFE3za9H0az4zKjgnWcOLsBI8GaURMhkJPCuykUtE+caAU4z1EGi9o6sWESqNwO51mi8HC5A7KFD6kIUfjHkahP/zb7ICnBa5YuyL14kYEV7NUitWfE7fE3xNp36a2PIqx03MDk9kaXcoscn+WHrGCLfy5TrvmUixqgRakZCQOthfFJUnDdnsdofQrzlgr3S0L/VvF9UVS0/Qzmmm8DV5p6BCA3BluZWqfBpI/xmTGsuRd5L5rgJMvlEqv4VLytuEkW9CHBxfeTzPgiCFEBRxOrwrtF1IXuh1kFpAgO0iQn3JIP2MJICSsjSL4Hfrx2jMeN/O9LvW3+INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB9376.jpnprd01.prod.outlook.com (2603:1096:604:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 13:45:18 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 13:45:18 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Thread-Topic: [PATCH] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Thread-Index: AQHY5VNb0lyLutnGB0iW4dRclsGMfw==
Date:   Fri, 21 Oct 2022 13:45:17 +0000
Message-ID: <20221021134513.17730-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB9376:EE_
x-ms-office365-filtering-correlation-id: 6081cc13-b603-4ec7-05bf-08dab36a7d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgGfyQB0ZmWO05zX8ZYKZ3qnv2JaBxvXNlceJ97DtqhQ88WK4AkXdEwjE/FtpYexXwvZnjFzNn1jrseJi1NnzuPx743fMiT9LYB8x2xq4lZglvcl6gVVEvK8HjaB4ofwJlIQmkul4v1a8R4PbN0kNomXFworIqCRmRG4ZtaZvghWG5oZ8kxZ/ne9TTW8/eNGlplXTtaV0ySNrA+9P1b1N+t5p2MmXcLfkg9CaI1plSaSBIqZLIY5PhETEdeF6q53ETQZU4gP1PqrnUMrSzQ54P20E5/nKe2CF/S90cZGhmaOYFeHV7uo4FH+2APMlguqO1L7hXuWOzfYEval+nt8ID7O6XfEmpU9pqQIVdxlljq2lys0f63aklpz8+/scfGdV5XZa800Lwsud2rSRjUF6gvJJU+vFh9Jrh7gjXJhswHe7gpC7aNdE414U1LwvLY273ppkkhwrVYUNLbJs6FYVy6P4gZQAqDaNbiHMnbvKeZ04tsMI75cjsDt1PENnd8XkPepp8k1TyG6uL/n3J9+f5X6mSOiecsr3g6fSFuU/cNnl1JpgVl8zAAde6qBTOa63N8WrV4ZVVp4MaXOpmrkDYO9ORzzjcKW1FqhCPybmieoCCgBGFZ3v2VH1UcdB45Fnz8v5JDtn9doiwFuqQeLkIRXGelXy4ANB0kNSjJ5hC6EF53lU4yMJDSikrqtXnnY8CwkSbZWBcBqHCXsyDFms+m5Ylkbkd6c69PGPIUWcYDIJsbPwfeFkVM4YX0xB/eIgTOiude8Etoakk8/tcHlS2KjkS2nRSDShawm17Ibu5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(1590799012)(85182001)(83380400001)(8676002)(91956017)(4326008)(64756008)(36756003)(66946007)(66556008)(66476007)(76116006)(41300700001)(38100700002)(122000001)(66446008)(478600001)(6506007)(6512007)(26005)(71200400001)(316002)(107886003)(6486002)(54906003)(6916009)(1076003)(86362001)(2616005)(186003)(1580799009)(82960400001)(8936002)(5660300002)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NU9FbzFENFRaRVBwbjlTTVNHVkRCNjZrN3EyMmhCd203OXNpZU5MWm5mMjFO?=
 =?gb2312?B?cmhuZDNjU0NyQlkzRzlXRFl5SExBbXBLK0lGamh2eTllTm1CTXJvMk90cERY?=
 =?gb2312?B?eWFrRnpCelozUHExNWtOQVlLQWM4WDU5ZlBuTWdBMVFWZis3ejhVZ0xUSkp1?=
 =?gb2312?B?eUpBQjJBWVlwcnpVOTdTRlI0eU5RcHhNYkdqOHpGWjMrc0srRDR5ck0ycURq?=
 =?gb2312?B?UEpBTFhIS053MzV3NVF5U2Uvc3ppc3dZM3F2Wjg2N3c2ZXFCVTVRMWJpcU5o?=
 =?gb2312?B?TGxMVTlwS0NsYytoNmcxRTlHbVpXd3JjcjFvZjRZS0I0VGlSVDBENXQrNVVB?=
 =?gb2312?B?cmw1NFRJQ1ZqTDk3Tnc0K2dHQTlyYkNSRHNyaWc0bC9mMnJTaDZERGxDbFUz?=
 =?gb2312?B?UXlrRlJyK015aDFVUCtzTCtuM0Z3QVU4TUJtYkc1a1ZSaGFOZFRNZjQySkVW?=
 =?gb2312?B?bzVJcXFJOFhGOTV2ZUdpa2M1YUFQMUwrU0VBOUxGODN4QlhneGlvcmYyNHc3?=
 =?gb2312?B?Sk1qa3RTdVc3cERGanYzSjBxNUhSYk5NSlBtejRuMWVnYzhUVUdua015OTdk?=
 =?gb2312?B?OWQ5VnFBOGxoK3hPQ3hRdGNZeU9lK09SbDJVYTkyUlJac052UnFSemsySDFk?=
 =?gb2312?B?NDM5bmFJK2RzYy9VVWFNdTBRaFd5VUZHZUhIVjRISDNTTkpwQlpjekJUdU1G?=
 =?gb2312?B?VWd1bHZ5ckl2RXdqSmZlY2ZOTDdPVVE0ZTNOMlk4TWVXWXRUeWJ3ZWpxbXkr?=
 =?gb2312?B?M3A5YWJkTDJyYkhWdDV5d1l4Q3YrMlZUQUZwT2hVczd2aWFGZHVENGM3U1Nt?=
 =?gb2312?B?TGw1bWx2RXR1NHNqNlR0bHB6OXRuS2FKRWV1SGVYVkhnSjRKeEQwTW1TUEha?=
 =?gb2312?B?ZTJNQVNBK01SRTM0ZnhpMEJQQVhhd2VudTJucDAwMkVtei9MS0l6OUNXcGh5?=
 =?gb2312?B?Q2xhaHNOMWFubkpXT2dsQmFKdGQrdHpHVFk4Wk1BV09hakdOdldqY1J5VlZK?=
 =?gb2312?B?Tk5WQXNxZnJBajZGZHU2TW01aFJnM2JoYVNLMXp0V0s0SGJhNWtkbmdpUTZs?=
 =?gb2312?B?N0hRQ1orRVlveFVYbzJMajJNTzBUdDZmc2dzcUpkZ0Q4UWx4blpiQ1RhNHBH?=
 =?gb2312?B?VEhEa0NjcklCZ1dQamFTVWJqa2dpV3ZOMGtzWlNwNHh6T09pU2dqbDRFd1Fu?=
 =?gb2312?B?TkIzQ3FBci9QZ1BQTEdLWlJ0K3QrN1MyRmtnMG1Ld0p0Q3BPYWdIZTJ5U1lK?=
 =?gb2312?B?SFJuemtYeEtHaC8wUzE1Uyt2U3NzSTdLYlY5OXBiR0xIbGdRQ2RscGlQdU84?=
 =?gb2312?B?Tk92SGo2RGpCOEFuVlE2Rm84M3F0S09wRkM5NnBjcG81ZEk3VGY0ZjRtaldD?=
 =?gb2312?B?ZWlVRWhxOEdacVlyRC9XVy9jWWVJcktmV3QxTWhyN3lTTit1M1cvU2h0U3Iy?=
 =?gb2312?B?MzRZZ2t0ZTNKTmlHRzJDMzA5V0ZqWXBlUDN5YTRQU1FtYmFrT2pEcXpkTXhl?=
 =?gb2312?B?cHdmVmt4QWNMTStseVg2dS9nZW1ObUgxZ1dSOURxZUxUUzhOc1dkcjlKdjR3?=
 =?gb2312?B?cWVaU0tQb0JXUTZIT1p6bWh4cjB3ZzloRm1mYkw3UHc5c0lCcnIwWnlJcStO?=
 =?gb2312?B?dDJQWXZjR1NmbjNMQWdDZnM0TWFyd0xzV3E1N2xBeG12aUZ4VC94emZRYndF?=
 =?gb2312?B?enhuMkt0WFBPV2FRTVFEbXRjekN1RTlrKzFmd2VoUWRjSXpqVWdVNnVUdC9P?=
 =?gb2312?B?aVpsak5FUnFJdFFOVDZwU3cyVDhSVU9kcVVkcjhMZXJwNXZVbkd3Z0gxK25K?=
 =?gb2312?B?VW9KcDBQSy9HcU53cXVDM2F1ZU1tei9EZFI3VFJWZ283QTFicmhvUUkvK2E1?=
 =?gb2312?B?NkgzR01YR3dib3oxdVRWaVdUUFVWendqNjc4cVI1UmNZekhyc2JoNzFqZnFh?=
 =?gb2312?B?V253bkt5cTI2aEw5YnpiVUV0S3VvVEJrM0JFbXNieDZVRHdTUG50SDF4WkFU?=
 =?gb2312?B?Nm1BMVZoREpYSk9uNDBPazNYaU1XVEdqL2U5WE5QemVZZ2ZSYm5QLzk0YVJE?=
 =?gb2312?B?MlJWWk1QREQxTFhwbStROTgvVlVEZ2Njcm1jYmtRYXRlMXgwWE5MRlFmNWoz?=
 =?gb2312?B?UGhDNlRGUC9IakNHbGpxU0k0bUpPRUVzRFNMVE4yeTNFUGs5L01acHpSaEpt?=
 =?gb2312?B?eUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6081cc13-b603-4ec7-05bf-08dab36a7d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 13:45:18.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +C2qiVTAk9VksJlWOrSlnxISiPanykz0Q6IK8EjE/hunb+dxppjQ5yHzbr9R2jFQ77e3JBN7Flz6H6nBBbfDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9376
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIG1lbWJlciAndHlwZScgaXMgaW5jbHVkZWQgaW4gYm90aCBzdHJ1Y3QgcnhlX21yIGFuZCBz
dHJ1Y3QgaWJfbXINCnNvIHJlbW92ZSB0aGUgZHVwbGljYXRlIG9uZSBvZiBzdHJ1Y3QgcnhlX21y
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0t
DQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyAgICB8IDE2ICsrKysrKysrLS0t
LS0tLS0NCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oIHwgIDEgLQ0KIDIg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX21yLmMNCmluZGV4IDUwMmU5YWRhOTliMy4uZDRmMTBjMmQxYWE3IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KQEAgLTI2LDcgKzI2LDcgQEAgaW50IG1y
X2NoZWNrX3JhbmdlKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgc2l6ZV90IGxlbmd0aCkN
CiB7DQogDQogDQotCXN3aXRjaCAobXItPnR5cGUpIHsNCisJc3dpdGNoIChtci0+aWJtci50eXBl
KSB7DQogCWNhc2UgSUJfTVJfVFlQRV9ETUE6DQogCQlyZXR1cm4gMDsNCiANCkBAIC0zOSw3ICsz
OSw3IEBAIGludCBtcl9jaGVja19yYW5nZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHNp
emVfdCBsZW5ndGgpDQogDQogCWRlZmF1bHQ6DQogCQlwcl93YXJuKCIlczogbXIgdHlwZSAoJWQp
IG5vdCBzdXBwb3J0ZWRcbiIsDQotCQkJX19mdW5jX18sIG1yLT50eXBlKTsNCisJCQlfX2Z1bmNf
XywgbXItPmlibXIudHlwZSk7DQogCQlyZXR1cm4gLUVGQVVMVDsNCiAJfQ0KIH0NCkBAIC0xMDks
NyArMTA5LDcgQEAgdm9pZCByeGVfbXJfaW5pdF9kbWEoaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9t
ciAqbXIpDQogDQogCW1yLT5hY2Nlc3MgPSBhY2Nlc3M7DQogCW1yLT5zdGF0ZSA9IFJYRV9NUl9T
VEFURV9WQUxJRDsNCi0JbXItPnR5cGUgPSBJQl9NUl9UWVBFX0RNQTsNCisJbXItPmlibXIudHlw
ZSA9IElCX01SX1RZUEVfRE1BOw0KIH0NCiANCiBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3Qg
cnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KQEAgLTE3OCw3
ICsxNzgsNyBAQCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQg
c3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KIAltci0+YWNjZXNzID0gYWNjZXNzOw0KIAlt
ci0+b2Zmc2V0ID0gaWJfdW1lbV9vZmZzZXQodW1lbSk7DQogCW1yLT5zdGF0ZSA9IFJYRV9NUl9T
VEFURV9WQUxJRDsNCi0JbXItPnR5cGUgPSBJQl9NUl9UWVBFX1VTRVI7DQorCW1yLT5pYm1yLnR5
cGUgPSBJQl9NUl9UWVBFX1VTRVI7DQogDQogCXJldHVybiAwOw0KIA0KQEAgLTIwNSw3ICsyMDUs
NyBAQCBpbnQgcnhlX21yX2luaXRfZmFzdChpbnQgbWF4X3BhZ2VzLCBzdHJ1Y3QgcnhlX21yICpt
cikNCiANCiAJbXItPm1heF9idWYgPSBtYXhfcGFnZXM7DQogCW1yLT5zdGF0ZSA9IFJYRV9NUl9T
VEFURV9GUkVFOw0KLQltci0+dHlwZSA9IElCX01SX1RZUEVfTUVNX1JFRzsNCisJbXItPmlibXIu
dHlwZSA9IElCX01SX1RZUEVfTUVNX1JFRzsNCiANCiAJcmV0dXJuIDA7DQogDQpAQCAtMzA0LDcg
KzMwNCw3IEBAIGludCByeGVfbXJfY29weShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZv
aWQgKmFkZHIsIGludCBsZW5ndGgsDQogCWlmIChsZW5ndGggPT0gMCkNCiAJCXJldHVybiAwOw0K
IA0KLQlpZiAobXItPnR5cGUgPT0gSUJfTVJfVFlQRV9ETUEpIHsNCisJaWYgKG1yLT5pYm1yLnR5
cGUgPT0gSUJfTVJfVFlQRV9ETUEpIHsNCiAJCXU4ICpzcmMsICpkZXN0Ow0KIA0KIAkJc3JjID0g
KGRpciA9PSBSWEVfVE9fTVJfT0JKKSA/IGFkZHIgOiAoKHZvaWQgKikodWludHB0cl90KWlvdmEp
Ow0KQEAgLTU0Nyw4ICs1NDcsOCBAQCBpbnQgcnhlX2ludmFsaWRhdGVfbXIoc3RydWN0IHJ4ZV9x
cCAqcXAsIHUzMiBrZXkpDQogCQlnb3RvIGVycl9kcm9wX3JlZjsNCiAJfQ0KIA0KLQlpZiAodW5s
aWtlbHkobXItPnR5cGUgIT0gSUJfTVJfVFlQRV9NRU1fUkVHKSkgew0KLQkJcHJfd2FybigiJXM6
IG1yLT50eXBlICglZCkgaXMgd3JvbmcgdHlwZVxuIiwgX19mdW5jX18sIG1yLT50eXBlKTsNCisJ
aWYgKHVubGlrZWx5KG1yLT5pYm1yLnR5cGUgIT0gSUJfTVJfVFlQRV9NRU1fUkVHKSkgew0KKwkJ
cHJfd2FybigiJXM6IG1yIHR5cGUgKCVkKSBpcyB3cm9uZ1xuIiwgX19mdW5jX18sIG1yLT5pYm1y
LnR5cGUpOw0KIAkJcmV0ID0gLUVJTlZBTDsNCiAJCWdvdG8gZXJyX2Ryb3BfcmVmOw0KIAl9DQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuaCBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCmluZGV4IDVmNWNiZmNiMzU2OS4uMjJh
Mjk5YjBhOWYwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVy
YnMuaA0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuaA0KQEAgLTMw
NCw3ICszMDQsNiBAQCBzdHJ1Y3QgcnhlX21yIHsNCiAJdTMyCQkJbGtleTsNCiAJdTMyCQkJcmtl
eTsNCiAJZW51bSByeGVfbXJfc3RhdGUJc3RhdGU7DQotCWVudW0gaWJfbXJfdHlwZQkJdHlwZTsN
CiAJdTMyCQkJb2Zmc2V0Ow0KIAlpbnQJCQlhY2Nlc3M7DQogDQotLSANCjIuMzQuMQ0K
