Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BC758D61
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 08:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGSGC4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 02:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGSGCz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 02:02:55 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1E1BF5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 23:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1689746574; x=1721282574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0dtx1znYexKNmYl43CNY47Gp8tsxXzXoiNBGLbHmTbA=;
  b=odL2XuqlXJj4CYdEvjsOR2m3soytweraB75jPiT8dLUHOk1j2ewYZs9L
   EC6+Pc7S0ZeXz2kdEfiBvEcGxEhioeTZZcBqDvq5nlpYuvxxU79WN0Nl7
   Ird9/M2Vx4yF8fQ7Ff9BBGFZmI0d92cDmkZZG1DvbhJqPYVs/lK6oRf/6
   rtP3EaSRVbP/qZyZ9coWnn0DppczwEqoNABhHLYm3n6Un4VsEuC2X0Zug
   /eS7/onEUjpZAywdUCbF3xw0j4gLUrO0xlAaj71iNPvQbVq7FztYTaiSD
   UrfQ6R8PhixB6s/XB1lDoA/PYH1588GtHzZMdVXXqAuRMOBMMncJrhAjK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="90059673"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; 
   d="scan'208";a="90059673"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 15:01:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8F6UaPUOKxe9caUUrrGOasQiLachkJUP/7M0M98DriZLrlsaf5ArZqi41GDwu2Mi70iXDgaYVjqtIilwsN5P+9G0lu5Fzw0IMYCXj1SJTOA5MDVLTOLhBkuXgr+t/CY7AtoRswyHymcAa3eKa7KRRyFU52qQB0kGWmDkkYZIUWX1EtKSmjfXCZR8tHkUaiO1CncLmpVRJViBNHyOGJClgQwKhmVuS/cFlO2/UixJRoxTXn2ZJkOcv8BKM0qr5tpNQogr5qzPzCp5QIl07NYgB/MLOrclXkgOGk952oQfO9tfEpG+VOer3QWiU/8x3o1sgD6Xxfg4v27h1ZPzUfvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dtx1znYexKNmYl43CNY47Gp8tsxXzXoiNBGLbHmTbA=;
 b=fuptli17dP3ZsP/Kdox+8q1/bkCLIBFn22Q735oXMSu8m1pUSr9OJ5b0Y0Ot5nlSIbpxjb9Chr6b4HYF5+NsrmLiKusTpRJ0+NFz4uHk6UahRoDVw15mgjHmkr6J1/1Q/Iv1m9L3GKHEkRVvrpYGG2HdvhkCu1DVN5L6IJ0esI36YN0tsiqX7024kTm0uiuBYNOsD9SwrpS6143iA2NpvpSWlzLlQVCxWbxcbpTM7UN+xSuOOb14kCaxBBBJmNccoQMnyHn+/aSxZGmSyi5TpajKFiNXR3q4VyJ8LzK+SXSX5Gn+JA+zcFtfNIQV0rnNsacjBjlzJ7/+wKcbP08sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB10724.jpnprd01.prod.outlook.com (2603:1096:400:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 06:01:43 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::8ce7:52da:acd8:c28f]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::8ce7:52da:acd8:c28f%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:01:43 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Thread-Topic: [PATCH for-next v5 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Thread-Index: AQHZiWHk3vu0fY0WZk6pKVA05y4OS6+HgXaAgDl20lA=
Date:   Wed, 19 Jul 2023 06:01:43 +0000
Message-ID: <OS7PR01MB11804F6BAD06DF239AEA5C3E1E539A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <25d903e0136ea1e65c612d8f6b8c18c1f010add7.1684397037.git.matsuda-daisuke@fujitsu.com>
 <ZIdGU709e1h5h4JJ@nvidia.com>
In-Reply-To: <ZIdGU709e1h5h4JJ@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDctMTlUMDY6MDE6?=
 =?utf-8?B?MzlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1jNzg5MmZhOC03MzEyLTQxOWEt?=
 =?utf-8?B?ODA5NC1lMWY2YzI0MTUxN2I7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB10724:EE_
x-ms-office365-filtering-correlation-id: 2bfde308-327e-4203-c6bb-08db881da086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxeW4f5jNb53lzdzNxi2hM9O+L83ZPp/aXL+TtWqQmaxztETQXfxyoYfxbQq83VpM806T2CK3CB4a5v3gxfZr8XnJkdhGkBRyR1Adk5V6GN+XYHzQythABw1wNJSjEnD91d8oBXrVVkp6wkwvCpgYI1Z5sTeHa6lF89g0nA2N4ONRTqrJLBY9PubNWe3XOCMt9rdFW5h6C8PCHPz7wO5HE6N2Iby+DZM5/OgdL37fcWHVgmgtGu1Quri9XJE9kKpZri7DbvVrVj06HICCQjc7efi3WF8bxwU/zVzygV91bYEFaEt0Qcz8vv7yi9pCZ2Yod628ZlBwRiJuJrCA7dbOCnOU582+bK78E7NQssGhcgs0v2kASbMMB2MOMVG0MzCoxf+H+XGZtDLRUA1t0Mn6to0ZfWgmojvtu+Ocm4Gn8yyCy81uJNlE4nxVkRFMhvIyJKKin1LqlAyeWcj8mr7Eir7kPIhhSwRrGi7K5KlHG9hYClDGKBtZJZhX8tXpbxxp6ZiuePvqY8ErP4dWZ/L3VdwODBO5x6fw7AslTVnIkcVqYftNg9FxO3Ze++0TkGILvpeKFrhM9KGmQOnDsuRo09vedGwHMN8m+ozKdN8Dl+mUpb4AK8KMO252SL9pgDzqaisS9FEKMEHaEcWO9gUmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(1590799018)(451199021)(9686003)(55016003)(1580799015)(107886003)(53546011)(6506007)(26005)(54906003)(85182001)(38100700002)(122000001)(38070700005)(66946007)(52536014)(5660300002)(76116006)(2906002)(4326008)(316002)(64756008)(66446008)(66476007)(66556008)(6916009)(33656002)(8676002)(8936002)(41300700001)(86362001)(7696005)(71200400001)(478600001)(82960400001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW43NmIyVmpHaXJzUnptRjB0WFpXc0hhN3R4c2RHdUVzcEVZdDhNUHAyZDRa?=
 =?utf-8?B?NCtvT3pCeDNNeUVYNHNrbW5ZdEVvRGY2dWErZzlzdlRYN3p4ZGoxSW01VUtV?=
 =?utf-8?B?RzRmS1VBY1p4dVlEd3B3cytRcDlxUU11dHBidnBDc2lZRmxmR1ZWeXdnTGIx?=
 =?utf-8?B?MHBPMzM2Y29IMWxDNmZXVklNbGJSSjE2ZXJ6dHRrc1Z2ZHAvbFVGdnRpTGQ2?=
 =?utf-8?B?RitMamc5NDAvOGxlUXNYRGlrcmxXOEI3TzVvd0VqNVZwVlBUVU9mWVcxeXlO?=
 =?utf-8?B?R2FpalhqQUtqV29sMEx4bmZ5N2RyeDM5L1ROWEtpeHBDeWhDQm1md2pLVmdu?=
 =?utf-8?B?bElrc0g1QkF4aTQrM1RuZEFjbnBxZDRaT2pqemU2c0pSaGVPdUtNbXZmT1hk?=
 =?utf-8?B?Vk1aaVcyNkRVemNtZjlLdTdEN2NGazBlMGcySHJaVVpjTTY5SmQ3Z013clcz?=
 =?utf-8?B?ekFweHExZXNxODlkYjVtR2Mvb0NkdGl1bmUvVEh0UFFWTjdWMUk0UGRueEpq?=
 =?utf-8?B?ZkRCVTg1TzBJLzJXVWF6RGx6OFk5bEVmWk5FdzVZakpnV0JBa1hIMWFxVkp0?=
 =?utf-8?B?R3dqeGQ5enhkZkpyMTFQM3liQ3VHSEdyNGtLUXB6OGRXVWFka292Y2hWeDFh?=
 =?utf-8?B?R0lhVlVsSVJNbmdyOEtPdXJTbzQxaFNQSUpIc0tIOGtaY3J6blFESXNWM25o?=
 =?utf-8?B?K2ZLOGN0bVB5MDZLUjRoYkQ5RXlmcXZ2SytoUUZFcnBzVTNFcVk4NTRNcUZj?=
 =?utf-8?B?K2RsYWM3c3FGdWlhbjkxd05qNVhzUi9ZcHA2cjVsWGtTL1FZVldjeG9lWEVm?=
 =?utf-8?B?TGo4eitTUzcyMmVnRkVTLzZTS1VOZEhibWR4eFFXQnlIUWFldUNKc3N4dXdJ?=
 =?utf-8?B?UzdBL21icUZtQnIwQ0w0R0NiVWVSN1NBalY1QTJRa29xcnk0Y2t5K1Rudk5F?=
 =?utf-8?B?UWhmR0xZQUtuQ0QvaGFXT2dLOXNPVU5RcGJES2lValEvU0lEVkhEY2ZiVEZm?=
 =?utf-8?B?TkdWM3Z6WmY3QnhDdzExWW1VcVVZMnlGQWxKbUtSU2ZIUWozUGJBVHZKcHRj?=
 =?utf-8?B?cFRTUFYwL0YwaEYzNU1BLzdkdVpxdXdvRTc4Y1J2d2t5U3dKeEtGWmRnTnRT?=
 =?utf-8?B?aWZTem1OUXhuRVR0VDB0WmRYR0txczNOQmV1TWxXeFJDaFVrVzZHUE9pNlJL?=
 =?utf-8?B?MG5GNUJBOGc0Y2E3NWxCS0pEZDRtUEwvS3ZjbGUxTXdTUlZUY3AzVmJOclhN?=
 =?utf-8?B?Z1J0Nkc3c1c1ak9rTGhPalJhKzJmbXNENmtzMkhBTjR1bStxMi9Bb0pRSW9J?=
 =?utf-8?B?NmRLRk14SU9zdFUyeFNCSGc2cHIwNmF1czhZelFoSXBLVkorQmhuOWZac282?=
 =?utf-8?B?Q0JnTkNsSThWNlU0YWM1dFNjNWNRN3MvK2hyQmhyRGcrRDRTemx6VEFzQ0hy?=
 =?utf-8?B?dlBiZmc1Y0VSUGVLMXZYa2NnMnE1emhEeFg4RGdzUVdFYXFQR3pBVHhHZEFw?=
 =?utf-8?B?UE9DL3hkaFVPYzBUbTFrbTJHNzFKMEdhaEZiMnlaekxKQWN1SXZqNmtIWS9o?=
 =?utf-8?B?SFRWc0IyWVQ1TmxpRkpmUXNyc21NejBFWWNnNVhFNGJoeFhjMnNERURqcldv?=
 =?utf-8?B?clFIeTAwckJOc3doL052WFh2dTdwMWVZdDE2T0RocGxrT002UDhRbXVPOGJR?=
 =?utf-8?B?Y2dxQlZxUjk0QW5hUC8zYktIalQyRjZTRDRodVJnMDZqOG1hakxJM3VjL0tM?=
 =?utf-8?B?cndScHZHNUhiV1p2bWZSWFpYRytNQzdwK1RKVVBYOTNIQjlQOXNwMTdaYUdF?=
 =?utf-8?B?b2R5NHlPYmFmM3NQREtrNjgwZFYyOGhObng4Q2l6SUpDMlRWdnltelE5MGsz?=
 =?utf-8?B?c2JjVWJ6ekU4cmtEczllakVNY0w5OHo4VGFiYWIwRThtSXZnV09QaGJTV3l5?=
 =?utf-8?B?MklKSVZEOXBVWTh5QXJXUzFmNG1vS1R5YlM4SEIwWm9iMi9yT0RhOFNKSmtD?=
 =?utf-8?B?ZmVSYWQrZmltR3BLcmRoaXBoWVhweHY2K0E0SjZJMUtKUy91akVnNUlmRHRC?=
 =?utf-8?B?akNmZ3JwWFdydlVmVDN5dTZzaTJzU25ycTZSMW0zMUdXYzlnL3Fqc2MxcFc3?=
 =?utf-8?B?ZWJiT0FZWGdXdlZjd0lGc0dQTUlYcDBNalBvS0tid0Q1Rk5BYzhybTFXQTk3?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2l1qQI1CduUqYoXC5N8NaZVPOVg2C5xA1Ms6HvTEs18OA1MuWPEFW9UxG6yoFIAwf1JHj8W7M5Fcp+5vLq7hlJNiVuZv92bhkKNR7IOLIVTEwve5kt6XqsOTmW38ky8AQcTkjzuK+ZV1vvJCJm4PUYfBVrgzzw0EN8OBD8ymXxJGaQah4WDaCXr5sTYp90XjNIK6ooJkoSHBqux2uHSYes4TGukFnBC5dW9mGhRXO1SPCAwIRO1GEYLEHiIA8JbOwjVnbcLC6yqduUReO6GNaO9I3MOKSQ5iYeXZheoIJvzFTgX8ZMbquntU61e6rJES4Q6BG8XBR07rkOehn2HY/VA2mBoBPmDBl460uIaaTkJXAefb6tuuXHfV/ylfvOIgbuBnaZgb8ULkaAwQbvdEBjyaB/DfJ7APfTDlBZKAwS3rm7suG/N22dv5MruTQAu3N5vD+dBUa634g9kUiLY4J8I4vtLvU/ELLU+f9HMoPPYHpUmFKzGEG5e3YQEQI5Te5Qibwzrgy2H3yam8F5HxSSyR83yiRosZAP+ykT8oeaubW6oItMSGlz5qgCUu8L4Ko03OoPq9S/GhizqeIdgNNlSN305IWcNiBEbBZ8g9A6M4vMqVPQ/rG4a/I8+Xm8nsuIaFWno1EYKEUieMD4hf8FS8DqVNI8wlf/Krp/I+BqOLnhyqgP8vDlDEvNbKqd1zbJlhNSxNnGN6flRjuwbl2BN8o2Pd2JfLrftSA/MPUkIuSZU4dVZS39fem8i9mD8Agikx/87UpXTjebKMKekrbo7Vjo8jqQjlRBzk3A+JhNt7O9ZoFl8AFpHkJSo3LI4PELODnEvD339GZZ/GG9x0IQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfde308-327e-4203-c6bb-08db881da086
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:01:43.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rtpLZJxZff+AJSgfsCa4C9s9CkdQOufgilKes2+eqiJnowxZlCpCzSiq3eEGUafAHjHaxCqjLjt6ZvWtDCg7GsDguRlLs+4pgQgi8r+Vqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10724
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBKdW5lIDEzLCAyMDIzIDE6MjMgQU0gSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiAN
Cj4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMDU6MjE6NTFQTSArMDkwMCwgRGFpc3VrZSBNYXRz
dWRhIHdyb3RlOg0KPiANCj4gPiArLyogdW1lbSBtdXRleCBtdXN0IGJlIGxvY2tlZCBiZWZvcmUg
ZW50ZXJpbmcgdGhpcyBmdW5jdGlvbi4gKi8NCj4gPiArc3RhdGljIGludCByeGVfb2RwX21hcF9y
YW5nZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIGludCBsZW5ndGgsIHUzMiBmbGFncykN
Cj4gPiArew0KPiA+ICsJc3RydWN0IGliX3VtZW1fb2RwICp1bWVtX29kcCA9IHRvX2liX3VtZW1f
b2RwKG1yLT51bWVtKTsNCj4gPiArCWNvbnN0IGludCBtYXhfdHJpZXMgPSAzOw0KPiA+ICsJaW50
IGNudCA9IDA7DQo+ID4gKw0KPiA+ICsJaW50IGVycjsNCj4gPiArCXU2NCBwZXJtOw0KPiA+ICsJ
Ym9vbCBuZWVkX2ZhdWx0Ow0KPiA+ICsNCj4gPiArCWlmICh1bmxpa2VseShsZW5ndGggPCAxKSkg
ew0KPiA+ICsJCW11dGV4X3VubG9jaygmdW1lbV9vZHAtPnVtZW1fbXV0ZXgpOw0KPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBlcm0gPSBPRFBfUkVBRF9BTExP
V0VEX0JJVDsNCj4gPiArCWlmICghKGZsYWdzICYgUlhFX1BBR0VGQVVMVF9SRE9OTFkpKQ0KPiA+
ICsJCXBlcm0gfD0gT0RQX1dSSVRFX0FMTE9XRURfQklUOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4g
KwkgKiBBIHN1Y2Nlc3NmdWwgcmV0dXJuIGZyb20gcnhlX29kcF9kb19wYWdlZmF1bHQoKSBkb2Vz
IG5vdCBndWFyYW50ZWUNCj4gPiArCSAqIHRoYXQgYWxsIHBhZ2VzIGluIHRoZSByYW5nZSBiZWNh
bWUgcHJlc2VudC4gUmVjaGVjayB0aGUgRE1BIGFkZHJlc3MNCj4gPiArCSAqIGFycmF5LCBhbGxv
d2luZyBtYXggMyB0cmllcyBmb3IgcGFnZWZhdWx0Lg0KPiA+ICsJICovDQo+ID4gKwl3aGlsZSAo
KG5lZWRfZmF1bHQgPSByeGVfaXNfcGFnZWZhdWx0X25lY2Nlc2FyeSh1bWVtX29kcCwNCj4gPiAr
CQkJCQkJCWlvdmEsIGxlbmd0aCwgcGVybSkpKSB7DQo+ID4gKwkJaWYgKGNudCA+PSBtYXhfdHJp
ZXMpDQo+ID4gKwkJCWJyZWFrOw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIG1ha2VzIHNlbnNl
Li4NCj4gDQo+IFlvdSBuZWVkIHRvIG1ha2UgdGhpcyB3b3JrIG1vcmUgbGlrZSBtbHg1IGRvZXMs
IHlvdSB0YWtlIHRoZSBzcGlubG9jaw0KPiBvbiB0aGUgeGFycmF5LCB5b3Ugc2VhcmNoIGl0IGZv
ciB5b3VyIGluZGV4IGFuZCB3aGF0ZXZlciBpcyB0aGVyZQ0KPiB0ZWxscyB3aGF0IHRvIGRvLiBI
b2xkIHRoZSBzcGlubG9jayB3aGlsZSBkb2luZyB0aGUgY29weS4gVGhpcyBpcw0KPiBlbm91Z2gg
bG9ja2luZyBmb3IgdGhlIGZhc3QgcGF0aC4NCj4gDQo+IElmIHRoZXJlIGlzIG5vIGluZGV4IHBy
ZXNlbnQsIG9yIGl0IGlzIG5vdCB3cml0YWJsZSBhbmQgeW91IG5lZWQNCj4gd3JpdGUsIHRoZW4g
eW91IHVubG9jayB0aGUgc3BpbmxvY2sgYW5kIHByZWZldGNoIHRoZSBtaXNzaW5nIGVudHJ5IGFu
ZA0KPiB0cnkgYWdhaW4sIHRoaXMgdGltZSBhbHNvIGhvbGRpbmcgdGhlIG11dGV4IHNvIHRoZXJl
IGlzbid0IGEgcmFjZS4NCj4gDQo+IFlvdSBzaG91bGRuJ3QgcHJvYmUgaW50byBwYXJ0cyBvZiB0
aGUgdW1lbSB0byBkaXNjb3ZlciBpbmZvcm1hdGlvbg0KPiBhbHJlYWR5IHN0b3JlZCBpbiB0aGUg
eGFycmF5IHRoZW4gZG8gdGhlIHNhbWUgbG9va3VwIGludG8gdGhlIHhhcnJheS4NCj4gDQo+IElJ
UkMgdGhpcyBhbHNvIG5lZWRzIHRvIGtlZXAgdHJhY2sgaW4gdGhlIHhhcnJheSBvbiBhIHBlciBw
YWdlIGJhc2lzDQo+IGlmIHRoZSBwYWdlIGlzIHdyaXRhYmxlLg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCkkgYWdyZWUgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gaXMgaW5lZmZpY2llbnQuDQoNCkkgdGhpbmsgSSBjYW4gZml4IHRoZSBwYXRjaGVzIGFjY29y
ZGluZyB0byB5b3VyIGNvbW1lbnQuDQpJJ2xsIHN1Ym1pdCBhIG5ldyBzZXJpZXMgb25jZSBpdCBp
cyBjb21wbGV0ZS4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo+IA0KPiBKYXNvbg0K
