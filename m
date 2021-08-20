Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF93F27DF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 09:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhHTHuS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 03:50:18 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:29989 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 03:50:17 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 03:50:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629445780; x=1660981780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Icymim5SF7rVaE67tIFQWUDtO4Q0O8cJ/+FyEzpOtmo=;
  b=sNQHpkSQHVYhyMi3dVkgaubGIChEAmJZd59nxxu/2wzD3WoYscAAyuMG
   UJtjFO/ORj4mRA7BRVKiYxC+HeAV6heL5U7Gq6ZZn4OULOkhSR+O7oVBR
   9EwyZI/HMpPUOYgIxB9/bnP+m2+ujDOaDMa/pCX79VCemn9XtGcEUguG4
   ZjWWmsVhKoqADaF6xhs7w7bU0Dv7mTr6jkCZM2IJu913J9wC+v2J9JiIM
   5TApWGFt0fHwYu6Y10GV1UU3A/9ziX3U6dcjVpF+K4wcWBZArY36eQtER
   hZF0YTRHXa1h1f3/D38tJ4gPgfMqO0VvIbPkz3w19rGLDP0UiP9b1K2Pf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="37115437"
X-IronPort-AV: E=Sophos;i="5.84,336,1620658800"; 
   d="scan'208";a="37115437"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 16:42:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb1vq4F1jZoQ5kU12VSa4TZqjLKfOSIc34qyyJ5zs1TXG8lwztRahBXWelEcfKOT6ZXMkDQt3EdZUbecJTy4cAFsz2UCDIsJTMhJRniKqvWc1zWptZ/DyuWekdfval2n+JW7UFlCFOkgHBThv+ZcSdvmQcozlE7+rRsJWWDtuqyxMkFey1MQApX0oyL6XXY7B4hGsaOdgEsdUO3acic205NGCozBtVyL74fnyGyAsg+SblNsc7gNChxbN227DlOPwLhBIFxT3NLI8cZ2qIuu/9sCY7+hEHl2EKUXnVQxOtkd2JSrVoZgrGIDvCI0SOIubectZrd0dnLkz3aAoF1WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icymim5SF7rVaE67tIFQWUDtO4Q0O8cJ/+FyEzpOtmo=;
 b=LpGH3DA1wutJyT5r6uv0Qrn3YgBbAwLd9v9COqh0mMF7wiHPbW6nPQuNwS0JIT8zZzK5L512SZngNZpzCtqhUxRKjrsQAhneJ6VrcgyRtLT7fAfjDix/bfr17wD/WYW1w0QEvR0kH8hmT4eST3Xf94YgN8FueXyFCEgvdCi+RCFm//Hvh8IZxNRyHQvJhtEYv0gLQzrgrGNVq0e3u51WfHHZr9XbZz15kynZXb2mdT+ytbX8kZF4dwfU1pKSKEkF3zXlUhFjNbbMthWPn2NMZf7OylHlC5FLsJWrzuyWQqhEdMWzFZwtgpZIWrudMYPr1DaQiggyukYOVtw8MrWlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icymim5SF7rVaE67tIFQWUDtO4Q0O8cJ/+FyEzpOtmo=;
 b=jwUmYGX8jcXm9zL4tD62zz9zOuOV7rEhJbNm6hpv73GbtkWH2bSWhTtm73JHrFyXf64/xXwvu03NPLlaiyYj85UzBBmPAK6nMXiArE0TipAfEr3aDeapIo+7m4fiaQ/TxEAargIRDzkPMcnCXELWwWZaquSsasrqHAbz8cklUbU=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB2771.jpnprd01.prod.outlook.com (2603:1096:604::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Fri, 20 Aug 2021 07:42:25 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 07:42:25 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RXE status in the upstream rping using rxe
Thread-Topic: RXE status in the upstream rping using rxe
Thread-Index: AQHXiJKFs2Uwv9tDRE2C9sy1eEMhGKtih4KAgAACJ4CAAEvmAIAAOPAAgAK4PQCAEUcwAIAB2XAAgAAKroCAAAZwAIAADHiAgABl9ACAAmvLgIAARfUA
Date:   Fri, 20 Aug 2021 07:42:25 +0000
Message-ID: <611F5CD8.2020504@fujitsu.com>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com>
 <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
 <611CBA42.9020002@fujitsu.com>
 <CAD=hENcE12nKdRn04K9Zbd1CyOQureYb44fp9occ=R4P6XrgZQ@mail.gmail.com>
 <611D1A3E.20701@fujitsu.com>
 <CAD=hENeYiTrfxDTAS9UkF8tn7=wa49H0DQuCBKeHpd+L6qM4SQ@mail.gmail.com>
In-Reply-To: <CAD=hENeYiTrfxDTAS9UkF8tn7=wa49H0DQuCBKeHpd+L6qM4SQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 622f8146-ac24-4312-d227-08d963ae0d9f
x-ms-traffictypediagnostic: OSAPR01MB2771:
x-microsoft-antispam-prvs: <OSAPR01MB27714393FD18C54183E33F3383C19@OSAPR01MB2771.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: laz0Jbnxidzhn88WjmgPKPL6+pJLtbyNICnuRt06kCqjGS7dhMqtlVzGOafUpIWd9RodiiMfbXHFXrPtnGgu8tRkRXzSaHQKalBoR9LARx8azfH1znVzpqVV8v4sZWKnFf7NiH55eNjWBqda0sQak3szE+L/Yt+AQtzYd2ZysWld96zANW9A0LbzhxLuv9bDStb6sbSVONSaJIPV3TUqJhFZKqSw55VrGc2J2uu4YsrC/rPcLlxrs/nnybm/psaXop9AdcVvLK0XeyU2tHo/omPA2+C0atS0wbeyR4lhjLTZalt47qtmo2aMjVbTVtauGYWTdUHFDzMES3tgJfOYE3csxtvwpVSlvP6o6K0d5CcT4nFeUiTqnPJvamsdiXsrpClt7Lp1q1e0RO5kve4UqKRrqOGv+fjKhIhejKNbwZCsnD8UkQTdxp8Ks75Z/krZ05J7sUlhlVDE6QwPyMpV9ERxbsSdh85XLA01TLfXqPgkJwyC/5M4pEDF0oj5O/hqd8JJDykagzsL7DAaylJHTcy5OTdLWS4I25QTvWxfETnaQ3+ze1NX5yWNMnYtcoQP/F4enud1JMYaoN7WBSpFcq4qS4WS+icLuJ8/Axy1unVBacLOeqVae1tjmUsWTsPfT5ALAjQh7bGRw79Q9SduAgyyTp3nFLQkonuI/WbeevGK1oW4KzjtHkqR2kT8UkUzZWRKBJWRCBzAdc+y/5rnG4ajw+4JDndnsiP6Ua7Gj6BkilF8U6vapRyayOxk2UqkWRSAj/CipqLYyuCN3Lh81xc99X3nDnkzImgjU58GNAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(64756008)(36756003)(2616005)(26005)(122000001)(316002)(8936002)(87266011)(6916009)(4744005)(66446008)(966005)(66556008)(76116006)(66476007)(85182001)(66946007)(33656002)(71200400001)(53546011)(5660300002)(186003)(6512007)(478600001)(6506007)(54906003)(6486002)(2906002)(91956017)(86362001)(8676002)(38100700002)(4326008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU5TRGdNV2pFc2YvWjdOSHRtS3p2aTNxRVpFZEpMUEtIZVpleTFkMzlnYnFW?=
 =?utf-8?B?YXZOdmlxUHUrV1JLdDE0RURRS1U2UlVjTFM5ajFVc1dxejZKUmpPaTZiWFdU?=
 =?utf-8?B?M3lsQVRzS2xSWjNyeVNtZFV0bksrRUdGWHk0TWN5cUl4QUIyQlhHTm5VY2Vq?=
 =?utf-8?B?dW9tVUNoZVRUTVY2UVpVc1Z3WENVUGVzTGQxcEZkOFlvMlpldlhIZXNxN2pz?=
 =?utf-8?B?V29CK1huYjUyd1ZpWWtrUzZKendyeENQRHdCV29idFpZczNQMUVwcGRiUm5p?=
 =?utf-8?B?SlZQaUUrMjRzVFpUY2dWd3NTdWQ0OTVERVJoTFBaTXNvdmsydUJnK1BCUXN1?=
 =?utf-8?B?SkdweWh0ZmtadnBiM0pDWnppRXlFN2tRVitsWmhaanJrenJndVRiTVROa20y?=
 =?utf-8?B?S1dUVThTQkJwMm1MSktYLy9wc0ZlSnJucTBwK3BVVjZXek5raXJIYy92TVgr?=
 =?utf-8?B?dFhsdkZ6Nm5LbXViWTBubHorSXMvU0ZvMjVwd0tLaXRwZkpTSERKMVAvaGc2?=
 =?utf-8?B?N084RElyVW1zZlhTTzEvK2VEeHNSdzJGTXo2allNOE14OW9pdHd3dHZRMnV5?=
 =?utf-8?B?a1ltVmxZQnhHelVFeFZyMkVWdzZOT2ZFNWRJNUp1dUxhcWV0VEN5N0laMVMw?=
 =?utf-8?B?RkJXUElzTHFyRmtkdkR2aElBT3BhcmdwNDRZR0xFY2VRMU9SdjlkbjdIMHZJ?=
 =?utf-8?B?YnEwcUU1Z0FXb1JWM2ZPeFhsa0xrc0c4OFZCTzVFM0IxTk9mVDZONFB2SXZD?=
 =?utf-8?B?NGNkZ3lkTGR5VFZBSnZPYko5Qmw2Z3VDaGx0cVVBQld6VzNEb2o2bnNZd05k?=
 =?utf-8?B?MnZZS0UvM29wY1pxZmJ1Qzk4dkJjaUVBRDk1emt4elVNMVMyVU5IMjRjcW12?=
 =?utf-8?B?blJkcStuamV2U1h1TXBESkZNK1ZxLzBYR3pTTEMxeVErbzJpU1FiVkthVnB3?=
 =?utf-8?B?a2Jzemc5aTJQNGdpMlMvcS9LOTArOGFQbnE1U3Vod0tWU3BIMmRSb0VnWUE4?=
 =?utf-8?B?N3RRS0hvd3NTSkpPVTY0MTN5R0tHWStnZHZQUzRXSTA5eUluaW1pUlY0UkpB?=
 =?utf-8?B?SG9Odm5YRWoxOEtNNVRLb1dZbUI4andOcE40OElySDlpQk1vZEtxOWxUZE1E?=
 =?utf-8?B?c001TEJXanVLaHpVd3RMRllNU01nUS94VG1FU3JUdG1HNWF1NlhiRzU2bmpM?=
 =?utf-8?B?MFQvaFU0Q3psUGllekxQc1ZoQWNoa291RTdjYm90OGlHSENpNlB1N0hmV0lJ?=
 =?utf-8?B?S2krWHMzZThXRk93OVVzQ0ZqZnlQalIvK05idEg3bU54NEdGVlFEZVpBb0dj?=
 =?utf-8?B?RUI4eFNjSTE1Y3ovUk5NNFNJQnF4TERtMjhmbjhVejZ0YnA0ai84UXpUOXpU?=
 =?utf-8?B?R0pNbHN3cC91YXk0Ky9pbGIvNkE3RHFGMXNrcmdWcDI2dWZGNlVXT0ZRQld6?=
 =?utf-8?B?bUR1SlF2VWtFcW8xMXpvRjV2cVcyL0E5V3RveWdvZCtBczRmc1hLTm45SEEr?=
 =?utf-8?B?OGpHNU1NcUliNG5LS1o4dkJid3BwOHU3ODNGQS9Pc0lHTUJsY0ZkaGlhVm15?=
 =?utf-8?B?NU90aCtFSGhNOHZQN1hyYlQvZkpmRjcyam5KaENBQVQ5elZLa1NtVjBGS2NT?=
 =?utf-8?B?aWZWVlFTYlY5RDVHc3JLdmgwdExUdUFQeVdUZUxYMUF6bGVXM0xlUWF2YWto?=
 =?utf-8?B?b25aQ1RDS004U0x2VnpuRGxSTlN4ZGpQcm82K0NmMkE0TGJsdTVOcW5BSXk2?=
 =?utf-8?Q?35ZIkImooAnGGK825wUqupMUwNLEOcqJiLCj2YV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <63DCA37E87EA8446B243BB1431C4A937@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f8146-ac24-4312-d227-08d963ae0d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:42:25.2896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1OukA3nJqQoc34r6uOHThd93++iGyZTnoyMQJaD+k3evj6uQhPxWZGL9JK5bq+uMJVjq6PLBaKz0CM7xD56dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2771
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzIwIDExOjMxLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBMYXRlc3Qga2VybmVsICsg
bGF0ZXN0IHJkbWEtY29PbnJlPCAgLS0tLS0tcnBpbmctLS0tPiAgNS4xMC55IHN0YWJsZSArDQo+
IGxhdGVzdCByZG1hLWNvcmUNCj4gTGF0ZXN0IGtlcm5lbCArIGxhdGVzdCByZG1hLWNvcmU8ICAt
LS0tLS1ycGluZy0tLS0+ICA1LjExLnkgc3RhYmxlICsNCj4gbGF0ZXN0IHJkbWEtY29yZQ0KPiBM
YXRlc3Qga2VybmVsICsgbGF0ZXN0IHJkbWEtY29yZTwgIC0tLS0tLXJwaW5nLS0tLT4gIDUuMTIu
eSBzdGFibGUgKw0KPiBsYXRlc3QgcmRtYS1jb3JlDQo+IExhdGVzdCBrZXJuZWwgKyBsYXRlc3Qg
cmRtYS1jb3JlPCAgLS0tLS0tcnBpbmctLS0tPiAgNS4xMy55IHN0YWJsZSArDQo+IGxhdGVzdCBy
ZG1hLWNvcmUNCj4NCj4gVGhlIGFib3ZlIHdvcmtzIHdlbGwuDQpIaSBZYW5qdW4sDQoNClNvcnJ5
LCBJIGRvbid0IGtub3cgd2h5IHlvdSBjYW5ub3QgcmVwcm9kdWNlIHRoZSBidWcuDQoNCkRpZCB5
b3Ugc2VlIHRoZSBzaW1pbGFyIGJ1ZyByZXBvcnRlZCBieSBPbGdhIEtvcm5pZXZza2FpYT8NCmh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNnMTA0MzU4Lmh0bWwNCmh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNnMTA0MzU5Lmh0bWwNCmh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNnMTA0MzYwLmh0bWwNCg0K
QmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IFpodSBZYW5qdW4NCj4NCg==
