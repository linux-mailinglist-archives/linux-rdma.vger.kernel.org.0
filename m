Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A496468E7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 07:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHGJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 01:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLHGJp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 01:09:45 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 22:09:43 PST
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3018659C
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 22:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1670479784; x=1702015784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ZPkIK7nxtCkRu6chr6oq0mdelmjjFIInx6rBvdklWI=;
  b=vR1DlFe8BB6viVUhQte3iQ2P7OaBRp7CNzOyoy0cgRs5265M6mwUO+NO
   xWJ8gHR/j4odoRpeRacdlR9v7V1hRi5w8VQ/CWePr+8cFiDbWGUNsD970
   c7IdxludcfpJwmOffDkKl6kgoO3We2iw1RqGPd3+5cD6YMM2BkztiiZlr
   F5Wmb6hWLdtx//8MlaNPfsL30QJ7Wq7SIczKQnaYtoKwqsNZeKTLESpdw
   ZLPKIzTAqBgyVno9RDyApKEdQGVOjShsq3pP7O/cB08j6iuC2ezKQu49Y
   ARQefR8+RgMQ3nOl7nxV6Ob79adoHspEoaxjJzjaup7POKbiwXnl3XpmS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="71669997"
X-IronPort-AV: E=Sophos;i="5.96,227,1665414000"; 
   d="scan'208";a="71669997"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 15:08:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m18gmPhogpWWCx2a/8LSYBvk12la8TyhJ5npsgdDTKTEiPzxQC+L3HNHqVOHHkauCyM68KkZLJoSaaPb0RKA3R1h0I9hP4zXIpY0rf37vwH+1SndpJ5w6mntX4GMBOhmZZLLlBFaEkST1JUD+VYkox7k5XdUFvmV+sFhXDpfmCpB4A14qv800eZdTg/x9lWc7/O9hSlSe2F11CqgjuZndvijlixl0lExXMWZWgA4ypV0V3fAngS66Ubj2h3ltK+h1OdkjasPwg0X766ZWD6UTM2XxA3kQ1wPS8HrMqzi6FfZo1gKM4ZDKnmRb8FKjZDQM8lPL7rO9hIg4HZ/5LAIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZPkIK7nxtCkRu6chr6oq0mdelmjjFIInx6rBvdklWI=;
 b=NSo5lvG1oo19CpFizVrCB+RxlNcJ3r6KpAGR/8lD6SYa4Q3rdjAsJ0OtbOzrBFwQ2MsilClPJcdmntpv3qf4FadQL7v3ANZqeRlyDkPU6FGLBvmdq3HLwVfIbbolAwKqyeRSw5n9glUTjSIivffomjBQwsMvri5cnX9+F+4Pp9zQJ/tNk91+Stg+x6HGRStMYW3qcpbTRY58JL6/cL36Bx+B3Hzqd92aONypGqA9bmDmI5vdHD8vjY9SLBwxB3Cdt4spqGKfD186UaC74KQpVlslGSpAsIRWvnGKpjMgZ2H3pss6oMKkC6urwudEL6o4jeOLjD4OBHT3+xAphYJM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB9573.jpnprd01.prod.outlook.com (2603:1096:400:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 06:08:32 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63%2]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 06:08:30 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Topic: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Index: AQHZBj2Sj1D5ymiA606IrAf+LL5o7a5jHvwAgABOM5A=
Date:   Thu, 8 Dec 2022 06:08:30 +0000
Message-ID: <TYCPR01MB8455576D21C033F8694EA5A8E51D9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
 <Y5ElLH2Lyw0466fK@nvidia.com>
In-Reply-To: <Y5ElLH2Lyw0466fK@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 0155b0ba640546c3be3e2cd8d43f0872
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTItMDhUMDY6MDg6?=
 =?utf-8?B?MjZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD02ZjJmNzcyMC00ZjBkLTQ0NTAt?=
 =?utf-8?B?YmYyNC02MmU2MjIyNjNmMTQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB9573:EE_
x-ms-office365-filtering-correlation-id: f91212bf-292b-4e88-1959-08dad8e2a156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pkbi6W1wpcSyihFfJZoX7vPi1G7z3qklSlpnu7BDZ324D+YVcx07k56UNVnGP/Nqd7uUVbuBXjVe8ic19O537N2oLUiSKSjVETXLFWzecniFQmFW3PPqNL9j/5rUmRP6NCfkWPWn8Ed5ySLl0V5Dd758ce++sUQZEfssVq/SHtyQYSIyGtWGyMCoyID7YF1/e0tqWEvQrtA2EQYHMEbjYLtjjOvgL8muUj5HpXV2b8yg67UBi+wWpRpkhCpg6wLf/p+0MfBCetmqgniVu4xLvq5Bs9yNgiPADpNk6hiCVKFQinGEiAS2UuYqGJrCNUL1c5RddC49yHbXvs+m22sh3FQLVsSr/Zh4OPgL0/zOCABogeb6EEf651QVK4/hO1JTnYJx3wBS5GgerXhcSQvXKmt8kYn068rq+FjvNkncDJI1SvON9mQnz7opcRWXYLTvu57Ty7WrzAKJE6W7OTMFlzD7PWM0aiLFAVUNSKjuJb7IODU9AEjXlnlZFUYGkPfnjjt64iqNwAd6O4QtX+lnkKqNEl2eoxyoIWSi3AVC3b0CI3qJKTiH3Nphhj8o6513opFHK1AizEemgnYMOWODH5iNpdFyf5zp45MC42/Hkcx1cCQLYLvBg7HfLAShQaxrAGczdQIYsMm8wqseNfgNTg6gtAZt/8YFuVhihniyNxPZLlcUe0CEV03HnzL9b+zxBdpzdbD5+hkuj+QuoeXY/Sf5tQ5FsQSNhhZ0dI9hfMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(1590799012)(122000001)(83380400001)(86362001)(8936002)(82960400001)(2906002)(5660300002)(41300700001)(4326008)(33656002)(38070700005)(186003)(52536014)(26005)(53546011)(6506007)(7696005)(9686003)(64756008)(478600001)(55016003)(66946007)(38100700002)(6916009)(66556008)(8676002)(66446008)(54906003)(66476007)(76116006)(316002)(71200400001)(1580799009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3RubWFZREptZ3pjMlhTNElFOUw5QjhJdFg4L1dzR1pIbkFjcmZ0ZVkydExU?=
 =?utf-8?B?ZlJONkdlWVdoMngxQzIrM3BwNVltNWdHeUNPeEVpaG0xcWtXV2dQL0k1dzd5?=
 =?utf-8?B?Y3VGN0ZaZ3dCLzJWNklmZEw3RldNTVFyOFV0YlE4TE1GZEJIcjVrN2VFSGZM?=
 =?utf-8?B?ak45RmxGYUhkd21LQXgwV1V6dC9TTjlmWFdieS90V1lxRmFJaG5Pbk8rOE1k?=
 =?utf-8?B?TUxGcHdwRzg0ZFU2eUZMZ3lmRjZaSE1rSEloNlJkWVBTSWZrcWNGWXVCU3F4?=
 =?utf-8?B?b1dVSFVOZFAxTkx4ZEU2T1VQRUNkbi9NMjZQRW5hdHA0NTVza1crYkxJRWlE?=
 =?utf-8?B?cW9NblpOS3hyeGhReXhqNTdQOUpua2lLL1FNYURmWlRtRmdVd2x0QnZlaVJC?=
 =?utf-8?B?d1ZoN2VxbFBnbG0yMHg5MjRTajZXaDU3UFUrbG5JTCszdEpSOFVtTnk4bHR2?=
 =?utf-8?B?OG1sc1JodU9PKzhIazFpTDljT3BnNHlBcEZDcmhUMlBHb0N5Q09GS3hSdEpM?=
 =?utf-8?B?MklIbU1ranZiOWVudDRndHFiVncyT2NxeGhXKzRCTGJFYXJqY3RZeHQ1MGZm?=
 =?utf-8?B?Q1NlVy9uSFpQUTdyVEhSd0twR1RnRHNzQUVvMGx6Uk51Y29YU2Y1aml2bG9p?=
 =?utf-8?B?K0ZHTXZEZGFodTMxZlJHZTBBL09tTXRBaktCNVBsWU9ZaE05QWtWVWM0USsv?=
 =?utf-8?B?Yi9xeG1hMXI5QWdUdDJCYVQvSWJLbks1TnlxTHlOcDN3Rm1OcGVRdEM3b3h1?=
 =?utf-8?B?ZmxRMlhNNzJqUDB0NDZKY1BNOTRhUHllQU5sMmZWTE5IM29tUmp0Zm1zRnlr?=
 =?utf-8?B?Zi9VMThzU2pGUXl5V2RJMTFQbEdKd0QzVkI1aHYvejlOa203RDNGYVBCZHA4?=
 =?utf-8?B?NmkvZFV3SFlFL293aWU1ZDFpYmhmU3g3WllxZlhSb2t6dzRDUjNoZGtIdGVw?=
 =?utf-8?B?aVhza1M3YWlTZEpyTVpvRVBya3B1MW01aG0xcEJERDMyeUhxMkE4NHJHM0R4?=
 =?utf-8?B?dzQxNGNxWEZFOWlKRU1xUnpNV2FIaGpxdTlFS045U1dqMHdIWE1DeElwcmVv?=
 =?utf-8?B?NGt0YThVRmVOaVpvdjhxSHVJS3h6VTQ0NVRQMkFNUFRhTnNCTUoyOG53OURp?=
 =?utf-8?B?SmdBTEtlTGdseVVaakd5RGZUQmN2RGJ1WlVqNlJaWEpRT0tLVlcxRTZ4T3NZ?=
 =?utf-8?B?RUZpZHVLbGtydXFuenJLME9HOHVwUVI0UjRxY0cyc0I3M3VNT1ZmMGRKanpS?=
 =?utf-8?B?Y09nZzk0MExUcmZYRmh3WGFWcWQrWlJzRnVxRWZkZWMvSDMxbnNTNkF6b3Rv?=
 =?utf-8?B?N05JK3pCZ0NrU081YzN1OXoyZkZPNWlEOXo4bFdCbmluZVpiTlNtM3dpZmpl?=
 =?utf-8?B?OFBMTnQ0WTdYRTNqanhrNlhIL0k5YXFXaEVXY1B6VjBKVktzWlpoS2xnUUV1?=
 =?utf-8?B?UWR6VVhiQjBZUEVGeFlxTlZrV1BKRklHSHNWNndsSFRhcVl0SDZKV1BoR2Rw?=
 =?utf-8?B?Vk5VN0lpN3lJNXdsVmtYdDlkZUNWcjcrZUVaeVY4bXdmdXJqMmltVk9ad0Jj?=
 =?utf-8?B?WWZwQldUSWNiOUppQUlDZHZoZ1VoTHpXZ2EwaW81OFpud1lEVm0zNkQvUWlN?=
 =?utf-8?B?VXFXb0k3b0ZETlR6UHc2Y1hpbTRpNFZyNGRiS1RkcUt6ZlJQYmZwUHBiekpX?=
 =?utf-8?B?N0Q4ZHFHdkdxSFBGWDZ6OWxJLzYvVy9XZEs0OGNVWkdWQ0Vaa2UrWnR4L0lP?=
 =?utf-8?B?Z1ZadC92amlPREZuczgwZWxYVHpUY2YrOWNxUnVJdWpCMlkxKzBKSkxKTVJO?=
 =?utf-8?B?NVZXNXdPUElZazBhU3BIalRpUVFIVzc0NENwZlM1c1gvVmN0alM5dXVmZ3Jx?=
 =?utf-8?B?dTNYaldXNkh2WG5Eb1U5aVBCci9VVjZxVDJQZW5GQ2Q3ZDM2RHAvS1NpbHJM?=
 =?utf-8?B?Ry9VbmhsUlFwdjZaVEFZM2MxYVBQK3VXNzN0MkUwdTRTVlB5bExNWWZmMXdq?=
 =?utf-8?B?U3dZbXhSazJteVYwRFZFTHhIUyt1UmxqVVFlall0QzZYdXhMd1hrNzNCd2sw?=
 =?utf-8?B?N2kxcW92dmV5czlrWWRWdHZxbGNXNFFvbjVQRGpqVkVvQzZrUUZhdE1zdWxG?=
 =?utf-8?B?S2FZTThKbjdWN3dkTEFjeElIaVlCYmVyeWFkM0gvcmM1SWNKcGlEcXFpYjNy?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91212bf-292b-4e88-1959-08dad8e2a156
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 06:08:30.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I9+fv/NOa/+YBjnAw9M0yKOn46CvL4Tzz4sEBJIuw49W2HhwqfD49/xmQ4PurKroy3ZdRn8pjcWC9FLZ+3KgR2olmQuO8Mg4/mfenTi8BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9573
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBEZWMgOCwgMjAyMiA4OjQ0IEFNIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gDQo+
IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA4OjAxOjU3UE0gKzA5MDAsIERhaXN1a2UgTWF0c3Vk
YSB3cm90ZToNCj4gPiBUaGUgY29tbWl0IDY4NmQzNDg0NzZlZSAoIlJETUEvcnhlOiBSZW1vdmUg
dW5uZWNlc3NhcnkgbXIgdGVzdGluZyIpIGNhdXNlcw0KPiA+IGEga2VybmVsIGNyYXNoLiBJZiBy
ZXNwb25kZXIgZ2V0IGEgemVyby1ieXRlIFJETUEgUmVhZCByZXF1ZXN0LCBxcC0+cmVzcC5tcg0K
PiA+IGlzIG5vdCBzZXQgaW4gY2hlY2tfcmtleSgpLiBUaGUgbXIgaXMgTlVMTCBpbiB0aGlzIGNh
c2UsIGFuZCBhIE5VTEwgcG9pbnRlcg0KPiA+IGRlcmVmZXJlbmNlIG9jY3VycyBhcyBzaG93biBi
ZWxvdy4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyByaWdodC4NCj4gDQo+IFdoYXQganVz
dGlmaWNhdGlvbiBpcyB0aGVyZSBmb3Igbm90IHZhbGlkYXRpbmcgdGhlIHJrZXkgaW4gY2hlY2tf
cmtleQ0KPiBqdXN0IGJlY2F1c2UgdGhlIGxlbmd0aCBpcyAwPw0KDQpJIHJlZmVycmVkIHRvIElC
IFNwZWNpZmljYXRpb24gVm9sIDEtUmVsZWFzZS0xLjUtMjAyMS0wOC0wNmIuDQpUaGUgYmVoYXZp
b3VyIG9mIHJlc3BvbmRlciBvbiByZWNlaXZpbmcgYSBwYWNrZXQgaXMgZGVzY3JpYmVkIGluICI5
LjcuNC4xIi4NClRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIGNoZWNrX3JrZXkoKSBpcyBq
dXN0aWZpZWQgYnkgIjkuNy40LjEuNSBDOS04OCIuDQoNCj4gDQo+IElCQSA5LjMuMy4yIHNheXM6
DQo+IA0KPiAgPC4uLj4NCg0KVGhlIGRvY3VtZW50IGlzIHByb3ByaWV0YXJ5LiBJIHRoaW5rIGl0
IGlzIHNhZmVyIG5vdCB0byBxdW90ZSB0aGUgY29udGVudHMsDQpzbyBJIGRvIG5vdCBzaG93IHdo
YXQgIjkuNy40LjEuNSBDOS04OCIgc2F5cyBoZXJlLg0KU29ycnkgZm9yIGJvdGhlcmluZyB5b3Us
IGJ1dCBwbGVhc2UgY2hlY2sgdGhlIGRlc2NyaXB0aW9uIGJ5IHlvdXJzZWxmLg0KDQpUaGFua3Ms
DQpEYWlzdWtlDQoNCj4gDQo+IFdoaWNoIEkgZG8gbm90IHRoaW5rIGFsbG93cyB0aGlzIGJlaGF2
aW9yLg0KPiANCj4gSWYgY2hlY2tfcmtleSB2YWxpZGF0ZXMgdGhlIHJrZXkgdGhlbiB0aGlzIGZ1
bmN0aW9uIGNhbiBhc3N1bWUgaXQgaXMNCj4gbm90IE5VTEwgaW4gYWxsIGNhc2VzLCBsaWtlIEkg
dGhpbmsgaXQgaXMgc3VwcG9zZWQgdG8uDQo+IA0KPiBKYXNvbg0K
