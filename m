Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B15784EDB
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 04:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjHWCqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 22:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHWCqu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 22:46:50 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B091A5;
        Tue, 22 Aug 2023 19:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692758808; x=1724294808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NksGTIwX08X93/0Me0wto3vFKMN28DuWJ1flS94bQI0=;
  b=ARo+9vAzFVFbDsmFV1E0QUPBMhl87tB32BoAUFkGPU+WBfw30jngmfB7
   4F2Ydu1sk41W54BXB2oP2UhCrO5Vmd2mEjs7TZoa1PJlvRwJ+8HnQJAuS
   QCMNFMZ9gZB6slGfDotPjeVlaUmQMlCzDga59IFi0q5lOoSCx+psEJayZ
   b2WuMCgCqeVjZmZS+DL1fEGMosqdxsgqA172jDx7RM5OiNBJSt6UaHNt/
   mAUTqC8ogjBKCamrj21ZFuzLiVr1nAHuoroHls7ogVnQyTg0boKP0G2HO
   WOLFNQOIe+ZfaD/HC8NwJrMsXoDkUS6RBdxJSBq/t2Txk7DzXm6xxaOJY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="92767012"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="92767012"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:46:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGRaABqaJyxQWQo9JohcqjoJEDv3ehS6s1HKTaI6j/jeeMyx2J5z9aNQ3goedym8ew62fTyA+BsF3w2tiKR/WWoa783NpDquZCac3iTHUssrq0dMig96y9vqe6eyrbAEfY9IO6zK2kEDjToC5Ge9eqoMuLRejsVKtCn5iuq8Zcdia3alr98jri0N4/B/TrYdc8DZPH9x5D8Pz5IuanWVMm/5b3Yg6nM1vX1rm6RXzTUq5D75TAocezVzBAphk72yZgfv6pKsrGddnSLrCDaJeBhgerB2vWgrsylVzLFmBs+4N9VjgkaDf2SPZqhmOlchttpOxJiIZqJA95FGeElvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NksGTIwX08X93/0Me0wto3vFKMN28DuWJ1flS94bQI0=;
 b=DA0mzBmhYuy1JraVTcVbqMuZbHnhHjmhXJCi1Hb55+TwFV7CC3mhfZ/T6S9D10y4Tt6occufKwSGnnT6+Oie28c7Qjd7Oo9KJ5YD2Vh7Avjaw/ZcuH7n232ZE5FxeiN5hADyLRT2JCyz8pBY7YhCJyAZe6392BVTMjxqtCWmg4DRS2OXZRKc3Sc1Iw/E+7wkSESWLe997wLhxpNu7lExEEiI/khK1T7LXHD2034bJs+VrrWf6L1jzXCLChUu62+woVjQQvgBK5mVJltxCpKNiEFd0DzkFEXmpmp2PYfJyp72tD/OK7InvsdFUsrVDy94UOqj7ythxMDX8187LbW/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB8673.jpnprd01.prod.outlook.com (2603:1096:400:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 02:46:40 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 02:46:40 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH 2/2] RDMA/rxe: Call rxe_set_mtu after rxe_register_device
Thread-Topic: [PATCH 2/2] RDMA/rxe: Call rxe_set_mtu after rxe_register_device
Thread-Index: AQHZ1Wdy5GQm6GmU50Ku/DLPSWhEr6/3LI1A
Date:   Wed, 23 Aug 2023 02:46:40 +0000
Message-ID: <OS7PR01MB1180411196785FFF5ECBC2965E51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <20230823021306.170901-2-lizhijian@fujitsu.com>
In-Reply-To: <20230823021306.170901-2-lizhijian@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDVhMTZhMjMtOWUyNS00YmM5LWFhYjgtOTcxMmM5MWUw?=
 =?utf-8?B?ZGI5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yM1QwMjo0NDowNFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB8673:EE_
x-ms-office365-filtering-correlation-id: a991c8c0-d3f9-4edb-8884-08dba3832dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raG5InhQcUQWZ5koIhiKombBoaDEXvic8sv7oMXUFSn1JVDzOIW5xUro/y2fRQwFOzb5k+wxWoOFPwy+dZTDmD+bYwtJwX9uUb4lLDkt4sGG1xwCVVqaeVNzON+JwvsLBAS1jLbWUq0hrFYlW893tRIvh82OdB4PQDsU8EjoyIeItjDlC9nR+2HzmsPbOfT7Hta3bNyVgguMJkbeaMfOrxwYGefwuLStaA8rifI9FoVg7Z/rXe2+xYuZwAyS9faGf5gpC3xZF13qOzdhCtmUxBRaZFTz9PtDQ1Z59UAb33iEZ18KhVmpBgtk93OkRHjqId+fgoEMWOqdbYbISEB//72AaZuBo3PJLLrQXplejO8dxU9OWJuOfawrvPPoz5Vsh0AtwlYdgt7ijpfVc7izSfzfrwPfalLM1ZlR1ihzBroGVvaQrXwwo84EtscX5Nz+JkCH+QNI6MJE06fXNgYnI52Wjw08CyTlurG4eyNfQpME5xQAQO5lkJ8uwZM+zBsnB5xMbD2odwFh4p3TkN43sxcZXYLlk5ccx8EgNj5A80nrYSY2A9BOsSvlxgDxfGPnHQB1pk2lZGV9acS3+Sr7mywzMuTkBDYsWHXqnmE61DX+Z7NLSsjl8N1Wy/t+MSTTQnZwm1Y4d0qpmSI/lmEBbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(1590799021)(83380400001)(478600001)(122000001)(26005)(6506007)(7696005)(107886003)(55016003)(1580799018)(53546011)(71200400001)(4326008)(33656002)(5660300002)(2906002)(52536014)(76116006)(9686003)(66556008)(66446008)(82960400001)(54906003)(38070700005)(110136005)(38100700002)(85182001)(64756008)(41300700001)(316002)(66476007)(8936002)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emkyZzAyVDAzWnBpYkFCNjhoQ0RjK0dqS0trVU5mRE9RNG5QblZ4S1hsU0dY?=
 =?utf-8?B?b0ROd1JiK2NDNmx5TzNBbDlzdXUveTV5UVEyWDlBMk4vL2FsMlRxZTNzUXdJ?=
 =?utf-8?B?eVdueWtCelBlelFnbmJQZlVLMFo1UkJUQXJQRTNGcmdVUWNJK1FjT1lOTnU2?=
 =?utf-8?B?NHk0R0E3aXVJV3kvZjdXVXVPUU9pR0I2MTN6ZlJwTThuV1pRTU5jdHp2Y0ll?=
 =?utf-8?B?cVEzME9LTVJzbGFUVnFwc3RjMjY3c3ZnZFhDeGorc01VOXV2aDN1Tmk0Vk9L?=
 =?utf-8?B?anB3RjROYjNNZFE2Z0wxVnB5bFlvbkhaZ1pWeXIreWUwMFBRUDljanRmUDFk?=
 =?utf-8?B?VU82NFh2OHFLOFM4RFMyZzRoZzJGWFVZZGVGTDFEM2UyUlRzeW9aMXpqWFpv?=
 =?utf-8?B?YVlHOTk0bjhXZ3pEOG5rZnF6T1ZIRjF3TVZxaU10U2d6eGlPcW4vZzltRHJX?=
 =?utf-8?B?SGNsYzdyejdoQlBFQ0FGRkZ2VlJaSy8yQ1VlZ0pxd2pLdXp6aGhVQXlhMjJX?=
 =?utf-8?B?Q094VE9ualFXVkxpRC93cFN6d2h6R1UxQXRsMVI2MGovaEhFay9PbXV3b3Zx?=
 =?utf-8?B?eS9icm9ITVBpbEZpdC9xZm92bnNjTVNBMWZXcFB1czdyeVRkZEJ5NlNvSVNa?=
 =?utf-8?B?cFh5dGcxSDk1SVJCLzlLUSs0WS91ZDVGOVBSTE0raFIyTFB6Q2ptK25yemli?=
 =?utf-8?B?aEVKVDdzdDUxMHJORFVOWWdlTHRmM3lVd0p0RDh5NGJDVzNVNkNETW9JMzhh?=
 =?utf-8?B?b3NRWm42SGxmVUtNT1Z4SlA1RENKVkIybExVc1cveXZUQnJmUUc0SDNvc1F3?=
 =?utf-8?B?L0FwV1ZUNEFJZFc1R3VXTnVvblp5a05zMW1GRHNhakFweFBmTnRFMmxYeXYy?=
 =?utf-8?B?d2tNMzRXV2lFRjZaT3ExblN2a0tGYUpsRTZ0Rk1WTDB3R0NPMk1lNHNoMFkv?=
 =?utf-8?B?L2dKd3R3Y3FSUWdDTVpUVG51akFYbEVUdWtCM1lEUmQ2QlhBYmxBMWcyQmVs?=
 =?utf-8?B?Z25oRCtpZndaRnptMUo0eE5abHlWaDg3WEVTanlxeEllbUFKRDlSZjdyc3gv?=
 =?utf-8?B?ejhxZ0NlKzc0U2R2NTNiUWRaYmtFeWtoRjQrTmtEVVgrOWdLVkJUMTVwaHFZ?=
 =?utf-8?B?S2J3djQzQU1xblRkdGJCTXcvV0Z2bU0zdUttcTRLYmMwTWVpdlV1WEVNcDJx?=
 =?utf-8?B?d0tuK21yV2cxeERISDl6c0pKUW9ieHFUdGprdlh0cVpmREZidUNzWFNqRjdG?=
 =?utf-8?B?V1F3S05wSVl5UjY2M3hGYjVsMEtzQSt1OXRuS3Fmb1ZGdUtjRHYweVZVWk5E?=
 =?utf-8?B?ZW0ybmgrWVpFSlE3cXBZN0swNkNzVGxMbnM5Z3hGNDN2R1lxR3lzUWxKYlJD?=
 =?utf-8?B?U2sraGNDS0RFN0UxblZ3MDNJWjNCbUM5REtUTGhXYnVPUldlc25CRHg1UG9p?=
 =?utf-8?B?UkdSRTUxMm5wU0RMN1R0eStYZzZ4T0J4bVJyS1UwWU04dFFuK2JkTWwzTkNv?=
 =?utf-8?B?c2ZvREpHR2VCUGdUM3NpeGpQeHNzdmEzckdHS1VFUGkrN3ZtdVhLTDdMclhE?=
 =?utf-8?B?UkdtYjRMQTlHQm8zVzgrdzZBRzM1eUh6cjh1R0F5MmsreWZ2VFkvckk5Tkt1?=
 =?utf-8?B?SElLbGJmMVNxT0xZN2xSR1V1SVJ3dElRbXRCdUtRYzlxbnc1c0YzYVM2OE5k?=
 =?utf-8?B?akhBL3YzL1Z0SGFrTHphSXpzNGZ6dnFFODFwaFJKMlluZ3RHYzNndDlrZ1JT?=
 =?utf-8?B?N21FUjV4RWJZZGRJb3VFRDl5ekRmSGxHNmxwaGNxZUNDUWk3ODJ3ZnVkb2Vw?=
 =?utf-8?B?K09nWUgyb0NYR09rbDBrdVI1WjU2UENhYWVQNTFaRCtxbnpKYThQOUtmNnEz?=
 =?utf-8?B?R0lLcFUzYStqUU02UDFKYjF0ekQveDNQOFBSY1Mrbm1Pb1pGRFdsdm9TY1dV?=
 =?utf-8?B?dEZGYjJLOGY4MThkL0FVSk1VQlZxSHh0WlVPZUpiK3VCWitRRUZKaEtZZmlU?=
 =?utf-8?B?L2RpWmhsNHFRTnlYd3A1MlFvc05MdEdHaVVRRW5aT1BZOGtISXY1U28zMkZF?=
 =?utf-8?B?cXBkR0RHdTVqTUNGZEZ2eEJ3VnFJd2dKM3JkOEVtS2RVQWlZc09DSlNqV0Rk?=
 =?utf-8?B?a25BaEsrRnpyMmxHK1krbUdHRkh0akJtbk1WQzlCU1UzRTBvbHJNdDA4bWNO?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wi046YyBR9e/9oczRp8wVfOC2fx9bdes1cbpuqQpJfRV4IAGjRAxEgd98k4faCOtn7gldg9ZfPj3M2Ff5BkrNBfBSaBfGLOkC4MDbEZKbBeampjp+UeIn//K0c01+WfWc+iwwi7fPaLp7BZ7yPh3fooxS83GlJTDiJGQJctXOOUPDyhJfm9PgYiJiIBtMZK6pprxXnT7Z3X0ZyIERkAsvwGGWEYX+Q3x6/5lztR9K5UCiQbeUIK/3Zb5L40Uk2Xq33O2gEx2B0PNE+2uXVXLm+PrjEdBBAfP3FYd1ZN91Re/6LaxVaNLXXmnek8/XJ2162F3fVKToBOPfipNlWitsLkgFQHGhKr4u4XNVoC1aeqTA8t7Mui6DenYSF1slGhkGWKhHwvaFsuUP+jnXHxcleulMFaHvV0NmLy7nhDE1ye/wv2gXSY7MqqAOjY6JK937E+G6Lsl9qoEI5XtTIy+WEYZ9I9A7vGJ/sZB9LbGtf9nVOWp2KhtgU+ABbXBb1Vn3hiBrL49W3ArvyY/q5cMj7temSZfanBQv/j7YJ9GPIRrfG+cQI61CzTgD9iAvPAwFBxrw2bORCSbRCbhyB2RkU/wQg2UoRK0zUGnYdTz7Re4Ey+rqtT06jkoC6qfXf1/B1E1LJHgH0LFEi9WqamekqEEC1uNKMxGUxZrEcS4rkK+BO5yBt2e1tEJfQR7zH1e1XtCqR1QmwMF82l0xKniLvw7p4CgJ2E0BD4iazCL8vCPwlVEFZqxTSsWAIRV6RAJONFYM8Qpt5WT3HPcEUbmPSCQR0bW/f5iUtsiRWFGMNUk36zUhEGoem9gC4ytjMlb+9KImJxNe3xKt+eI4VC5tUmE5+eEu5StqsuJQgISukA=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a991c8c0-d3f9-4edb-8884-08dba3832dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 02:46:40.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSgztJ1cnwrKvK9jNvehD1qH331dA17dtaJ52LjW2ZZopFdR3xlHlzi0cOq4ec5gTc7wUfc1MZ8uaI6bNQn0et7ya5Ed9qGSYHcXXNyi15s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8673
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMgMTE6MTMgQU0gTGkgWmhpamlhbiB3cm90ZToNCj4gDQo+IHJ4
ZV9zZXRfbXR1KCkgd2lsbCBjYWxsIHJ4ZV9pbmZvX2RldigpIHRvIHByaW50IG1lc3NhZ2UsIGFu
ZA0KPiByeGVfaW5mb19kZXYoKSBleHBlY3RzIGRldl9uYW1lKHJ4ZS0+aWJfZGV2LT5kZXYpIGhh
cyBiZWVuIGFzc2lnbmVkLg0KPiANCj4gUHJldmlvdXNseSBzaW5jZSBkZXZfbmFtZSgpIGlzIG5v
dCBzZXQsIHdoZW4gYSBuZXcgcnhlIGxpbmsgaXMgYmVpbmcNCj4gYWRkZWQsICdudWxsJyB3aWxs
IGJlIHVzZWQgYXMgdGhlIGRldl9uYW1lIGxpa2U6DQo+IA0KPiAiKG51bGwpOiByeGVfc2V0X210
dTogU2V0IG10dSB0byAxMDI0Ig0KPiANCj4gTW92ZSByeGVfcmVnaXN0ZXJfZGV2aWNlKCkgZWFy
bGllciB0byBhc3NpZ24gdGhlIGNvcnJlY3QgZGV2X25hbWUNCj4gc28gdGhhdCBpdCBjYW4gYmUg
cmVhZCBieSByeGVfc2V0X210dSgpIGxhdGVyLg0KPiANCj4gQW5kIGl0J3Mgc2FmZSB0byBkbyBz
dWNoIGNoYW5nZSBzaW5jZSBtdHUgd2lsbCBub3QgYmUgdXNlZCBkdXJpbmcgdGhlDQo+IHJ4ZV9y
ZWdpc3Rlcl9kZXZpY2UoKQ0KPiANCj4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIG1lc3NhZ2UgYmVjb21l
czoNCj4gInJ4ZV9ldGgwOiByeGVfc2V0X210dTogU2V0IG10dSB0byA0MDk2Ig0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlLmMNCj4gaW5kZXggY2IyYzBkNTRhYWUxLi5kMjllZmNlNmU1Y2EgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGUuYw0KPiBAQCAtMTY5LDEwICsxNjksMTMgQEAgdm9pZCByeGVfc2V0
X210dShzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1bnNpZ25lZCBpbnQgbmRldl9tdHUpDQo+ICAgKi8N
Cj4gIGludCByeGVfYWRkKHN0cnVjdCByeGVfZGV2ICpyeGUsIHVuc2lnbmVkIGludCBtdHUsIGNv
bnN0IGNoYXIgKmliZGV2X25hbWUpDQo+ICB7DQo+ICsJaW50IHJldDsNCj4gKw0KPiAgCXJ4ZV9p
bml0KHJ4ZSk7DQo+ICsJcmV0ID0gcnhlX3JlZ2lzdGVyX2RldmljZShyeGUsIGliZGV2X25hbWUp
Ow0KPiAgCXJ4ZV9zZXRfbXR1KHJ4ZSwgbXR1KTsNCj4gDQo+IC0JcmV0dXJuIHJ4ZV9yZWdpc3Rl
cl9kZXZpY2UocnhlLCBpYmRldl9uYW1lKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4g
IHN0YXRpYyBpbnQgcnhlX25ld2xpbmsoY29uc3QgY2hhciAqaWJkZXZfbmFtZSwgc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXYpDQo+IC0tDQo+IDIuMjkuMg0KDQpJdCBtYWtlcyBzZW5zZS4NClJldmll
d2VkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCg0K
DQo=
