Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC814600728
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Oct 2022 08:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJQG7N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Oct 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJQG7K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Oct 2022 02:59:10 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477F1AD85
        for <linux-rdma@vger.kernel.org>; Sun, 16 Oct 2022 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665989948; x=1697525948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fTzU3WjeF2y9jaT8yTBcSfOwMuAHpAItJ/QsRaTE+dY=;
  b=HR2eDMeK5SOjdbXW7Ik5Je431jwnMHImZ24CS6aXKM10y50jxk7LvCIh
   U89bMNdAFgXAoqNLU45WG2N5okSEdYWf2M6CczG8ZjEtlhiJEYES8fW12
   pYeNDoEeyS8JIQ2n5CmaCZ9jG6QAFF+TRdJNo8sFep99f0lu54VswHdXH
   VU8Z00YA6v5hRVDASCdaZq/CstLG4K+OIkYhpd59sfCsFTgdXa5OTeNiJ
   zwVcWjIxe6jnVoyd2hrpB3AJ/TQaVuvuot+TYBoSbaLgxgZ7ETHdtxVTH
   mlvYutwSlY2VcRso65wIEMP7HbZYHxN0BeW2aziWdheaJ2PcbYwuG1o8D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="75877817"
X-IronPort-AV: E=Sophos;i="5.95,190,1661785200"; 
   d="scan'208";a="75877817"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:59:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUK46uoqDyNi86Th1H377w7v9rtyDv+g8RR9GESFr7osZ4+WCCycGd5V/6BeFtlIYQazf71o+Gf/fk/BOfBevVrqwGhmrcoNr7GS8C9E1V/WSKEncxTvvO50928IyldvkSZOxLxA+zVc4rRYeFT/ZAVSomO7fncHz/YtMc84d28+fqL5863ZYfVOOHbDjlM3WR7RAskzxFYJctE+nIqw3jJJtMTBCG9FEfP5LM4u8AhGlGNY4vGkzjWBzZAJTtxE81t7iBiAakyRsNZPzqBqGThkfiNnKbJna57Ty9gER8WBHwxf1I3yNYlhPMTVOP52TYTfI0pLulF6BI+XAgAeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTzU3WjeF2y9jaT8yTBcSfOwMuAHpAItJ/QsRaTE+dY=;
 b=OQQiJ5XPpcqhtxGCSAVGmQ9PqvfWatZ0PKlSrkI3W2Hu4oggqx/Zlw19Cu1OEmzNekcnRo6YZsP23ubTKyqmldpUIgfXgqM59I8kgEaPwNLftWZuNw/S1pXWr/ju/tiyEvENS7xLrFsuFhnGFEGb6Z/4vp4Mzo3KEbTRiwoUGzVgGzOmRUAK6QSk4WcksBSY5BG7RIytZWi1LZ1PixG/fSDtonyDRKxt2gORt5Kj4zu6w812jq0u4eLjn5CMVRNA/UGeNxtcj2mUvNzAEGlLbJx7zeD3NLh9pJI0z4OsM1GGK7xH1pLynm2efeLJciZDDcWZkrvdrGYdQQil+3j8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB6093.jpnprd01.prod.outlook.com (2603:1096:400:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 06:59:02 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 06:59:02 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 00/13] Implement the xrc transport
Thread-Topic: [PATCH for-next 00/13] Implement the xrc transport
Thread-Index: AQHYykM9ecjzxQckj0W3lkf079lrYK3yZqwAgAAg4fCABBySAIAAfOlQgBNlmhCAAjRFgIAFmmLw
Date:   Mon, 17 Oct 2022 06:59:01 +0000
Message-ID: <TYCPR01MB8455FD68BFCF8F8495EF0940E5299@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
 <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <2d0420d9-b2b2-1a23-084c-6104bac18838@gmail.com>
 <TYCPR01MB8455C2E2DCD507C32051E929E5579@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <TYCPR01MB84554785DE728A68EFF385C1E5229@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <8a5dc704-5f10-fa59-6db8-f4e684121233@gmail.com>
In-Reply-To: <8a5dc704-5f10-fa59-6db8-f4e684121233@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: a9f7ead5ccab482eb274fc559137a91b
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMTdUMDY6NTg6?=
 =?utf-8?B?NTlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01MmUyMzFhNS02ZTQ0LTQwNjAt?=
 =?utf-8?B?ODdjZC02N2Q4OGNhYzA3YTk7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB6093:EE_
x-ms-office365-filtering-correlation-id: 4a7d8a29-4c38-4cb8-d043-08dab00d129f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i/Kj4B0eVFRG9glIwalyMDVHEZIQytAvlOMMBQR9F4AUjh6mqiQw5sshTCkFYyTRRBNogZUBG3CPvQtVPoL95Kd3MTK4HJ0hsEv12bF/0XLy2mitbrkSAOyoJIHia3qM8GTaZ6TXvQaglYWTQv6jqIzLKibhQDi2o8ZgikZh1W3V24sni888/ON8EHUAx/CL5ypmnf1cnzFoin/EgN7IdzwZmTlIHYo+NUQf0J5wWBSzrm5/kmiLByEEEQSAnVqWx0hRviFosnQ3W8gIN6Ie5ix61KFTzY51LZDUqru1FWbVIzS9Nvvb0FPVAjaGpQm3w2/K1FhtV/6qzc6p+z4d56iBHNK6/oMU/lbQ62J5Ccop9SlPXOYc9CSFBtU2fPQHkxksaCNVQyYh2qpoPCt5NXp7AN1/9XbXsiiMu/0yH/1cyCVYTaVt7SITfhFq8Q2G9rNtTfSJ/coVG/NK7AHOn9Y55qh47Mm3XSv9OgqVkHoLGoKuzhz2n7ywl2c9t23exzFGTN16+ipbMGQ8/fH+IeuS4FykDFgcoBMBtEsivxMv/tw1wJBFqAzw4qQOsBEIed6EOXfSOIUs7eCQuvnYKK5n5JcBKaR/To62wfwPcOtsZJ4QzCVQWAQieGsHVGw8fMI98CQ4K37qkLsCd71pMIDaF6mmW6nkNrXLA5QCcsC+wKoaWv/Vd4DsTVChF1i/Kb7+MdbzDZMTQwyxKNoj4ijxWgE2r0z7BEb4MYRriVdwNPo09Pkbiw8yTddk8yp/LgJMxVDGi6k7EQEYzQZ6AP8UrbEwg4yq25y/EVDkl39x4dKuR84sWNFLm7fWVNCMB1nplyN/qzhTG3x9hYjERw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(1590799012)(451199015)(38070700005)(82960400001)(122000001)(55016003)(33656002)(86362001)(85182001)(38100700002)(83380400001)(76116006)(66556008)(66446008)(64756008)(8676002)(66476007)(5660300002)(54906003)(316002)(110136005)(66946007)(4326008)(186003)(71200400001)(966005)(2906002)(8936002)(1580799009)(7696005)(6506007)(478600001)(9686003)(26005)(52536014)(41300700001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZIcVVqUGFKVVNlbjZ4V1JDZUJGN3NsRHE0YzN4RUNqZU4wbFVqa0JFUlAz?=
 =?utf-8?B?R1MzTy83TmR6bzQ4K3A1dXN6czdORjI2OEdRZlRUMnhSam9nMFk0WWJlZUdw?=
 =?utf-8?B?Zyt2K01PVlJkNjdzYmpTdkdNQWR1M0JsdVhrNHdlbEhGNlpDQ0UvbjFYS0pC?=
 =?utf-8?B?cW8vMjNoMHhOZzQ1VkNIVG5pTmkxbW4xTUxncHdZZVNmTVZnU3RUdlVXSkU3?=
 =?utf-8?B?QjI0ME5tbHhrOGc4SzdiTlNYZ0Rwek5raDVpblE4cmFKSzhOcTJramtGSW1j?=
 =?utf-8?B?eGJyZDZESWpCaEg2OVRPNDFKaWJ0SEk5bjhzYVY1T2JpMWkzZVBtTS9RUUth?=
 =?utf-8?B?bGE1djlyMVc5eWF5U3FoNlZIbFpaa3pEV05QcHpURTNmZVlBUTVkbkdYeUxk?=
 =?utf-8?B?dVhyVVU3TXpibndTSDFBd1hEamdvQlgxb3dGK3djc2d4d0krZ3RRcHJCek5m?=
 =?utf-8?B?WVpabWZqWE5pTllzZzMwaTJGWUtWK1FvSk9ZanFQVXMzTmZPTmhaa0dMTE93?=
 =?utf-8?B?SFJWZkw5VG5EMGM0bTVFVTdtcXZMaG1sVW9WTVJNY2VCMDc0VG5IUGhJRktM?=
 =?utf-8?B?ZnJvTnZiRFl4dk80ODJoakF0Z0pKU0xJNGwrOGt3c1VnK2NicURhV0ppTVA5?=
 =?utf-8?B?c2ZLK2RJOUt0aTFXRTFZYkswMHVVTjlBRkFmQ2hKMk05bldndXg5cWYrRGFB?=
 =?utf-8?B?QlZiMFQ0YTVCZTV0RXNGbmJkSWV5S3RpSjBmYnpjenZPMTE0ZVdITHl2aUF1?=
 =?utf-8?B?VDlMa0pnTGx2NzZyWkFWWWk2bjBCNWdDR3REN1ZUb2x0OGNCSko0YUZqOERs?=
 =?utf-8?B?NEw5NVVFV1p3ZEZ1T2lNV0FNWjh6WHZPdzRnUjc1L0kvaWV0ZW5adWR4UDJB?=
 =?utf-8?B?bU9vQ1F2cm1NQzBQUHdMODhLM2E2ZG1MZWFURVN4S25aQ1kvU1hXeWRnRnFQ?=
 =?utf-8?B?QnFUSzRqRjZPVXV0aUhJTGRMYkZtemtaT1ZRblAyQUtPVlg3WU05RFAyREov?=
 =?utf-8?B?SFZkNTV1L1NwTVczRXVlODJodnNKbGxVZDJsOTE0ZmtEQUFKVnpncnhPVUM3?=
 =?utf-8?B?cnE0QThTTE8wNDNhb014cFdlOExvVFA2aTYyU0ZQVWlKek5Hd3BIOFo0ZVV5?=
 =?utf-8?B?UFpINVJ3MHVsUElBejh5bkJEdDAzdnhCT2RHalZYYXZka0lNdG5vSytJTHpj?=
 =?utf-8?B?MEJxRmM5NHhwWTB4QU1Jckx6ekxJSnl3WjhETTNKeDZXcmREcWlBWHN6YWVQ?=
 =?utf-8?B?ZFRaZFFzcXZVakpxY1BiZ3Z2c1lMM3F3a2pxbGcyb1RmVGpKNFJIK1VLNmF0?=
 =?utf-8?B?WktQMHBjUkxHUDl5Q2Z4c1U1d3lNUGFqbTcrUjZGenEyRzZOOWdaVVNENHZO?=
 =?utf-8?B?Vjh3UDNFVnBUUi93UFoxZ3VXYmVvd1hYN1IzelU4NFFoNzBlWWhXQTVqN2VV?=
 =?utf-8?B?V1A0RHNBT01XT29UUkwweFJETHdvY290Ylc0WisrcTZRY0JLZFI3Q3BWSVl0?=
 =?utf-8?B?MlZzWE43aGJ0MWQrakNtc2kveG9uelVWeXFQK1BPdXF4U2xRWXVpWk9Rc3FE?=
 =?utf-8?B?MStMYUFSR2NXQWw0dnZpS041M3NBUkxOWFNOVkt6Q3QrUVM0SFFvT0RpcWZv?=
 =?utf-8?B?ekk0Y3JxYVBpamoyMWtrTDNYYWlKam9FRWF2YVA4akpWdlVqaWUydlVVRmdv?=
 =?utf-8?B?Y3JyOElsK2NHMFNodVpTTm9KQVlkbWJ3Y0ZwRUhMRklhYkpudVZwTW9BTFNO?=
 =?utf-8?B?UGFMM0JPK2xjNlU1YWdaOWFjVjg4N0dRc3d1ak9NUVJ6ZXBwUW8ySTJ6UzhB?=
 =?utf-8?B?d1RVT2Zpc21hUnVHb05Ydm9hN1MvbW8ybDR6WWlFNnZSTEREMm5vam8rN3lO?=
 =?utf-8?B?TFpBQndJbktkQUtmQ0dFdE9HdmZIQWc3ZVhPL2ZoWnpwbStLd2FDdUhONFMy?=
 =?utf-8?B?SWNOdUlYZnRIc3lZODIzT1A0VzBqdDhqZWorbGNaR1dNek9UeTJlN0YvbHVD?=
 =?utf-8?B?Sm5HcUtCTzV6YlFnbzg5NjN3S2I0ZFJuYVFveXNhRzRiNFVILzBrS0QxQWZQ?=
 =?utf-8?B?WlB3cDJNdDlZWVhmcG11akcvUW5SRm5RT2dUclA0NURIY0NVeGg5WDZydzZF?=
 =?utf-8?B?Szl2elphdkdzTzkrUXIyNm1tRkFBVnc4ZU1JMFZ0dmh6NEJ1NW9YTFFyMmow?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7d8a29-4c38-4cb8-d043-08dab00d129f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 06:59:01.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJTpS+tNCRCP9HNKU8sdo1jWlwv7EIl4WoynfcGSz/a4kf1dKARqxDy8+fgjX0l8+7qbAMQKd84UrNCSP594FDCVQjulgE32T3atjFVBYZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6093
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBPY3QgMTQsIDIwMjIgMjoxOCBBTSBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT24gMTAv
MTIvMjIgMDI6NDEsIG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbSB3cm90ZToNCj4gPiBIaSBC
b2IsDQo+ID4NCj4gPiBJIGFtIHJlYWR5IGFuZCB3aWxsaW5nIHRvIHJldmlldyB5b3VyIHdvcmtx
dWV1ZSBpbXBsZW1lbnRhdGlvbi4NCj4gPiBDb3VsZCB5b3UgaW5mb3JtIG1lIG9mIHRoZSBjdXJy
ZW50IHN0YXR1cyBvZiB0aGUgcGF0Y2ggc2VyaWVzPw0KPiA+IEFyZSB5b3UgaGF2aW5nIHRyb3Vi
bGUgcmViYXNpbmcgaXQ/DQo+ID4NCj4gPiBEYWlzdWtlDQo+ID4NCj4gPj4+PiBUaGUgT0RQIHBh
dGNoIHNlcmllcyBpcyB0aGUgb25lIEkgcG9zdGVkIGZvciByeGUgdGhpcyBtb250aDoNCj4gPj4+
PiAgIFtSRkMgUEFUQ0ggMC83XSBSRE1BL3J4ZTogT24tRGVtYW5kIFBhZ2luZyBvbiBTb2Z0Um9D
RQ0KPiA+Pj4+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNjYyNDYxODk3
LmdpdC5tYXRzdWRhLWRhaXN1a2VAZnVqaXRzdS5jb20vDQo+ID4+Pj4gICBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmRtYS9saXN0Lz9zZXJpZXM9Njc0Njk5JnN0
YXRlPSUyQSZhcmNoaXZlPWJvdGgNCj4gPj4+Pg0KPiA+Pj4+IFdlIGhhZCBhbiBhcmd1bWVudCBh
Ym91dCB0aGUgd2F5IHRvIHVzZSB3b3JrcXVldWVzIGluc3RlYWQgb2YgdGFza2xldHMuDQo+ID4+
Pj4gU29tZSBwcmVmZXIgdG8gZ2V0IHJpZCBvZiB0YXNrbGV0cywgYnV0IG90aGVycyBwcmVmZXIg
ZmluZGluZyBhIHdheSB0byBzd2l0Y2gNCj4gPj4+PiBiZXR3ZWVuIHRoZSBib3R0b20gaGFsdmVz
IGZvciBwZXJmb3JtYW5jZSByZWFzb25zLiBJIGFtIGN1cnJlbnRseSB0YWtpbmcNCj4gPj4+PiBz
b21lIGRhdGEgdG8gY29udGludWUgdGhlIGRpc2N1c3Npb24gd2hpbGUgd2FpdGluZyBmb3IgQm9i
IHRvIHBvc3QgdGhlaXIoSFBFJ3MpDQo+ID4+Pj4gaW1wbGVtZW50YXRpb24gdGhhdCBlbmFibGVz
IHRoZSBzd2l0Y2hpbmcuIEkgdGhpbmsgSSBjYW4gcmVzZW5kIHRoZSBPRFAgcGF0Y2hlcw0KPiA+
Pj4+IHdpdGhvdXQgYW4gUkZDIHRhZyBvbmNlIHdlIHJlYWNoIGFuIGFncmVlbWVudCBvbiB0aGlz
IHBvaW50Lg0KPiA+Pj4NCj4gPj4+IEkgdHJpZWQgdG8gZ2V0IElhbiBaaWVtYmEsIHdobyB3cm90
ZSB0aGUgcGF0Y2ggc2VyaWVzLCB0byBzZW5kIGl0IGluIGJ1dCBoZSBpcyB2ZXJ5IGJ1c3kNCj4g
Pj4+IGFuZCBmaW5hbGx5IGFmdGVyIGEgbG9uZyB3aGlsZSBoZSBhc2tlZCBtZSB0byBkbyB0aGF0
LiBJIGhhdmUgdG8gcmViYXNlIGl0IGZyb20NCj4gPj4+IGFuIG9sZGVyIGtlcm5lbCB0byBoZWFk
IG9mIHRyZWUuIEkgaG9wZSB0byBoYXZlIHRoYXQgZG9uZSBpbiBhIGRheSBvciB0d28uDQo+ID4+
Pg0KPiA+Pj4gQm9iDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4NCj4gPj4g
SSBhbSBnbGFkIHRvIGhlYXIgeW91ciB3b3JrIGlzIGluIHByb2dyZXNzIGp1c3Qgbm93Lg0KPiA+
PiBJIGFtIGxvb2tpbmcgZm9yd2FyZCB0byBzZWVpbmcgeW91ciB3b3JrIQ0KPiA+Pg0KPiA+PiBE
YWlzdWtlDQo+ID4NCj4gDQo+IEkga25vdy4gVGhhbmtzLiBJdCdzIHJlYWR5IHRvIHNlbmQgaW4u
IEkgYW0gdGVzdGluZyB0aGUgcGVyZm9ybWFuY2UgYW5kIHdhcyBzdXJwcmlzZWQgdGhhdCB0aGUg
dGFza2xldCBwZXJmb3JtYW5jZSBoYXMNCj4gZ290dGVuIGJldHRlciBpbiA2LjAuIE5vdCBzdXJl
IHdoeS4gSSdsbCBzZW5kIGl0IHRvZGF5Lg0KPiANCj4gQm9iDQoNClRoYW5rIHlvdSBmb3IgdGhl
IHJlcGx5Lg0KVGhlIHBlcmZvcm1hbmNlIGNoYW5nZSBzb3VuZHMgaW50ZXJlc3RpbmcuDQoNCkJU
Vywgd291bGQgeW91IHBsZWFzZSBzZW5kIGl0IGluIGFzIHNvb24gYXMgcG9zc2libGU/DQpJIHdv
dWxkIGxpa2UgdG8gc2VlIGlmIEkgY2FuIGVhc2lseSByZWJhc2UgbXkgT0RQIHBhdGNoZXMgb24g
aXQsDQphbmQgYWxzbyBJIHdpbGwgc3RhcnQgdGVzdGluZyBhbmQgcmV2aWV3aW5nIHlvdXIgY2hh
bmdlIHNvIHRoYXQNCml0IHdpbGwgYmUgbWVyZ2VkIHNhZmVseSBhbmQgcXVpY2tseS4NCg0KRGFp
c3VrZQ0KDQo=
