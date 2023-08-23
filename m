Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D2784F11
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 05:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjHWDFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 23:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjHWDFA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 23:05:00 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2365CCB;
        Tue, 22 Aug 2023 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692759899; x=1724295899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=masfyXokBIpmHWmv05HlYYKHx8t0+vnv6aiJbdsIH88=;
  b=cf7XuXhHoWcuzuQHkYh7YvCRVTzL6k+PF2nkz7cU0LaqaogUaQ0S7eOt
   zjWa3QojrE8CP5rczQgiwq/147XrtGOGjL0ufoG7nn1JgOhYnI21B+xyj
   xnRk+Jdikvpibq2k8n42BRndmgRMt/bIhysXUBbdXsdIwrpSDX69UHA3P
   GC1AMJqMIJ7/GhnXP2AO9fCxV6W3qOCTFbauEQISLJZ0dUpGHwDiEUmlj
   Dd1zKw0++nPDEUctXNKiDX65ZcK0K0E9tHPSacWD8eomILs49fL9R9yLo
   eOzSq7E+g3CtSIhcswUlz8NfV3DtcKl1HkqgtBdifXkppIiieJ623Q+hz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="93029335"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; 
   d="scan'208";a="93029335"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:04:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWfx9B7OkXRea2GWMiPuMtVxy2x4dfIfoSLmx0x3O6Yls22hEGm3NZNgT95hWmYWZSNT8Ynf8R/2xc14CZPbAAQF9vMIljVt7VxaS43iHOJPxSe0/Xj7g3/m2DpL37zrKEX/n7TvpvO5+xkvDuFmtO15f6q/8f6RwzMqzfosxhq0G3az4EWa/UDV6eTxtplFsCS9e1OvZ2+lHqN5MVHzTr2YlneiBqnGqHzXyvMGD9Ox/gxdG4HYj5U5CbV+mb0JQdZShO8NxT+eVdqW5HLGDELjaC0WvyT2A9/MYod8u7n/MS5QzjjeZa3jKUZ11tG+H0O4GP9jgvFB1OItBKZW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=masfyXokBIpmHWmv05HlYYKHx8t0+vnv6aiJbdsIH88=;
 b=cTeDWBVa5wTunHUC9A40/hGmyPK5Vx+oNnJRXy9/Fr0ejQtITJhduoRccClfW39mqUbCiMOI2mDk1V7v1BIyFqyvJcoq8Qlw0/0b0cjRtD9fc8uXQtsd/Y60EcVSLalVD/BNs2P52ZlQim5evlafS/FhKDBRciRPYThInoriAhyWLLTNM4tpsP0s9mqeaXT6epBfDANgQEPLRXB8NoHbyseCeOGd0SLdjytKaBajAQN9PovEvHJVIMGXR7rg3Po2l+jM4QG3bKGsN8W1pTzQ423nEVCg6obNnvAMOAfQ+vsKHS+tmO5xllGU22om9Ej4bwfWdzKmo3aI7K2DgvrB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYAPR01MB5657.jpnprd01.prod.outlook.com (2603:1096:404:805b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 03:04:52 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 03:04:52 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdeUKk57k5Lwkqt11UK4BLVm6/3LIMAgAAF1wA=
Date:   Wed, 23 Aug 2023 03:04:52 +0000
Message-ID: <07507497-afad-d39b-8514-11651283dd51@fujitsu.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <OS7PR01MB11804CAF2115EA88678B1B2AEE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB11804CAF2115EA88678B1B2AEE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYAPR01MB5657:EE_
x-ms-office365-filtering-correlation-id: 67163e30-c39c-4c9b-c11f-08dba385b85f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaaiNY26ksnMt/iGmDwcOKdfvKl2f2oJT1Bpxm/WQqh7krYjrC1qBT+KX43vSxV/i0f7qClmIiFrbyV+I3l/KlrKMz8/iV25vl2f4vDseNbUYmgfoEx3OIODXHV5RzdvmRgejPpuEYP2QhHbB3Vt8I/wXFJS6GdqAb/qet/mhbwNDEgsbmZAfCHV0YgNeWuNnNHvpWh9OxH2q60es05jVuvB53ucBWOZq0tH2fP4aeuf32zymlsd40BJRRiYz8XHXIu5wWJdTTdHUCqeNuAwiQA2aCOKo3iEUzfZzng+W4KKJaZLphPn+jTLa60zFLPx2didodUcMIQYz2qlI20BwwNuiEGdQZsMCpRbMa6yIPL6pNIG/8hERYNhWRXxXp5lEnJjTzHRFlkpN1HseicTX/HnoIQtEoBmrvxoDaDmTIZ8HqQG0KLlethG14rbIjnwhiU/rneSWXZLnaveaeSrgh7R6PHLI2Z8MY2L/z6b4+37QUebN5iBNj1AYYtV9DTDOwIrycRx1ZSvNam/TvvIYKqpvLnkuqMcHde1ScxXrzOrPHYZ2QDR4PpDvF+SkIg1w5OuXP42NQ7m7dGCQ3XP1qS52tSSmZOeliMTGE3WhLCre1Oj2EudicxGGk70hoAoTh6+E1HL6Yuq1aNSTRWGWO4/9stmm73U+pvAQnxUoM/pPk2WDNLBtCeQAoPAFhOHY6gfVYc16xjk/89auIx/Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199024)(1800799009)(186009)(1590799021)(83380400001)(478600001)(122000001)(26005)(31686004)(6506007)(6486002)(2616005)(6512007)(53546011)(1580799018)(71200400001)(86362001)(5660300002)(4326008)(2906002)(15650500001)(91956017)(66446008)(66556008)(82960400001)(66946007)(38100700002)(110136005)(76116006)(38070700005)(64756008)(54906003)(316002)(85182001)(8936002)(41300700001)(66476007)(36756003)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIyTU1reEdJdUxRVVFkOGZILzN3RFB3SklqZ2tQZFN5MUxzMnBtTkM3VXA0?=
 =?utf-8?B?VDFYaS9KSER3Uk1jZHljTUs4TEFSWVRDSUtUMnBsVkY2OXY4dFgxYU1Gbkxm?=
 =?utf-8?B?T1R1dmZLMlczQ0ZzY1RKUCtlbEtjQ1RWT1Zic096Tm0zQ01kWDUwS1ZyWFBm?=
 =?utf-8?B?YVJLU0Z0OTZGK2VuN3hsY3FnOXdoK0JQcDRqdkRJSWUvNWdmaTNiVG1mK01T?=
 =?utf-8?B?ODhEVWZWRmFuQVpJcnY1elVOUUtJZEE3NTBINEtYbE9NMU8yb0ZNMUpxV3BS?=
 =?utf-8?B?QloyMHFOcTJ5NGpYZElSeEhmRUpuNDQxY2c5T3MvUy9mL0RFVklrWEFtTmNV?=
 =?utf-8?B?SVRocGxMaXNHd2l5VURuS3R0ZVZ1UlVidC8zZWk4MFBMS0UzWTR0L0Q5ZWcw?=
 =?utf-8?B?VHJPQkh1SVVWeVN3eExxbFhjS1Q2aENkcTZuaGhPUDVNdllXOWxtSjhMNHJn?=
 =?utf-8?B?RFBxYmpIc21GeENCem9ROHRXRkd6c1pBTjBYeUM3eC9PaStsY3ZzcTlud0FW?=
 =?utf-8?B?UG1HUG5pTGczamEzSnNpdGY3dy81YnJYWTZnbTNPcndtV3dDNHhHeU5pVTNx?=
 =?utf-8?B?aWhBTlNIMTE3MjVRdGJRM3NIT0hGVktxb1JIMDNQOTg5RlZWbnFGOVpzb1Iz?=
 =?utf-8?B?OXZ6YTNKNVRwUURHci9Camt2TXB1aU9zeHdIOUFkd1RlT0E3VUVxaXc3NW9O?=
 =?utf-8?B?L1A0SXg1alUxOXdWRDM1VWtJeVp6VkNkcVMvcGFjRjcxZWNSbW4zRlpxSGww?=
 =?utf-8?B?L2RzcTRyU3RsUmRMdkpKTDlkSXFiUXhEQ291c3BPTi9kcjJKWjFVcWVzbzN1?=
 =?utf-8?B?THhnSDRCMTFrOW1uUnFOZ2liOFNOYWFDM3FvQmlOekNpQS96SU1oZ1M4dlV5?=
 =?utf-8?B?MUVIL3lzM2lLbnhHRmxPdkpsWk1VaTI0SEtQYlRYRkV6NGlNR2lrZTlDV000?=
 =?utf-8?B?RVJDQ0V0eTdlMXJCTTFYRm56QTU1dldHMXp2UGx5Tll2Q00vdmNDZ3FFUnRS?=
 =?utf-8?B?TWp0RVFhN1A1WE5ZRC9xS3NZWGdaaVBqR3ZERVozYnBOZzhZNjdZT0JQYnkr?=
 =?utf-8?B?LzF3UDF3Mlh3UjlkQ0ZCbXNkczl6bU9HMGUvT2xuaGlENkZHZ3NNcVkrdkl4?=
 =?utf-8?B?bjA3RTBjUG5JVGlXWXpQbzhyNXNldEdRellnT3djTXpzWTNvb3FWa2NCVWY4?=
 =?utf-8?B?d0wzdUwrRFhWdWo3VTBWTEZiTUF4YjZjNGhreUdVOTBvbGNDU1E1SWtpN2N5?=
 =?utf-8?B?emp6bjFyQ3haZWJQejNzNkl1VFJrZk9VbWZlYlNNam9mM1pHWWJzTnRxSVBF?=
 =?utf-8?B?UG1SN1VHbWpFbTVBVFlQbm0wUnRhbk9KcEtmRFYyWnJaN0N3cUJHb3NLL3BD?=
 =?utf-8?B?SkJJS0U0RkhYT29xcE5CWWk2aGE2WEhhQjhpdGlPV2lXZlp4K01sdk9zWXBn?=
 =?utf-8?B?Tjk4VUhtbXVPcXJUK1FwUFAwaDRMdEt3WmhBOS91Z0JXQThXVDhGZFpyOW5s?=
 =?utf-8?B?VkFIUllkNWk1TkdXK1d1QnF6WCs0QWxKZDhnRStDSVg2UXB2ZjFyV2NscHBS?=
 =?utf-8?B?OERYNnUzVmt1anEyNU1GSktsdEY4NFh1b0JCSzIydGQ0TzF6QW1TWktFR0lQ?=
 =?utf-8?B?Wmt1b0R5akhDU1ZiczIwNTFJOTZnN1pTTk1sQ3ZHTkNuU1U3NWJvcDIxSW5z?=
 =?utf-8?B?Ync2NWhHQ2VXU0MrSVZvQmduMnVWZjFaU3N2aXllNzFWbmtqTUp0SWkxK0tv?=
 =?utf-8?B?UVpQOVJtUHB3WllOby9FTk00Z3NHb3JRR2dLNUZtYVgwanlJNVpLVzEzeVVw?=
 =?utf-8?B?QW5lR0UyNlNYVkU5MXMwRjVZbWQwa2VPMWRDSDVWQ3FaM1hNRkN2M0FMS2dF?=
 =?utf-8?B?bDI4VTFUNXRYQ1FZcCtwc2NGcldOaUd6bkRCb1c4WUdNcTVpamFWbXBYNUhv?=
 =?utf-8?B?UHFZK3c1U0NGeGw2bGNoem1NeVJaNXBlUDIvUHFKa0lDbWoxcXZQYkJEYW5U?=
 =?utf-8?B?TmV5dzB5MWxkZStibFRXaUJ0dEN3NWlXK29udzc5bVo4YlA0NiszdXlKeVdH?=
 =?utf-8?B?bUl5TGtybEM1VTdleDZhMW0ya3ZlcjNscklNZnN6WWswNjR6OCtYeHdLRzNn?=
 =?utf-8?B?ZTRobzd5MDNaNXZHMG1MTGh2SUxtKzdPREo3d3c1Q0ZIVGU4NncxOXduWVVJ?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F879640D6E489A45A3C3919E33A649A5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vX1p53fKA3fCGlWvQKo7GuaZGE0CcglS6kbhSd8Rypkx63Cdl6wUBLLkzlWdXx+gZemksX9qjVQkVM9qAyYjSqItdk/8rUX+tqhrySDmyXBTLiwF28EF/wXA6HpFhwA8Hk38ijpJJNJ67E2fnemWhZ1chG6hfEqGBHDkYISno9S+ernzL8MOU5O67/4pahtv6hOOMbzKxrIOzn6IACstESBFihZ00DjBerJDtMNdv3Ggq5VppTJ0XH8V5o7ASZzOLVOrK6Rl3NsFHTArm+8kafE8+pcXG56v2gz4xR8hZP/6AxirC50CF90maXTNRS25f9qm8V064hCEzJRXnnn9vmuMFswi5Qx+XcetLswETNKS8CTcq3+v0DUBbVNHTFEQbg0/tcjWPG/kcpqStbJdREMpuaxaKJNjweSjahMUuWeORUSDXPwbq7at8F3AZ+pYU+C6lc9fEY1Hpxk/YT6DBf0eoQCsEK6ynB8f1T2mrjkEfV3lNGRnfgPqSC4Yo6OBKjxgd+Jklzwl1onqrg9db6AcD5U9+WtPDefaRuWgKbKIR/syUacKitXFbg03AM2WqmtqwI2oKBhX6gbrLHb33PDMkuBgzbt21bpYbTi3JEhQ4J/Duo5uTaNXBb7QvfezE1RZjHMyyd7Y3ILhhSy2GKrdnGJ0fMugoqBsvyRNZz9jeH8Skd98OOLxDNA4ftH51NM74z4FD621BCCQ5y80mSbKkEhVW8Wir3Es110hPurUmGLPf5l31Dd1kWp7dVmGkK7sBL1IeJLinGPCESAo9HRnb6egRxQahHDLeprSPR3rB+ZL0aS58yFmjgItL+Gmt2SsNTn0YSTtbsQDJi6+14uz5Hrug7wgjWhgdtyjlvs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67163e30-c39c-4c9b-c11f-08dba385b85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 03:04:52.1898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mPwTV32q1gUQkPRB1xXbXnWhGJoKRWnNXdt+9s8obeDcnFQXEfknKVY3HSwg0WAW6BrnBx4eVkuxHpqcI/36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5657
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RGFpc3VrZQ0KDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcsIGJlc2lkZSB0aGlzIHBsYWNl
LCBpIGp1c3Qgbm90aWNlZCB0aGF0DQp0aGVyZSBhcmUgc28gbWFueSBwbGFjZXMgbWlzc2luZyBu
ZXdsaW5lIGluIHJ4ZSBkcml2ZXINCg0KZXhjZXB0IHJ4ZV9lcnIoKSByeGVfaW5mbygpIHJ4ZV9k
YmcoKSBhbHJlYWR5IGF1dG8gYWRkZWQgbmV3bGluZSBpbiB0aGUgbWFjcm9zLA0Kb3RoZXIgbWFj
cm9zIHNob3VsZCBhcHBlbmQgbmV3bGluZSBieSBoYW5kIHdoZW4gYmVpbmcgdXNlZC4NCg0KQSBy
b3VnaGx5IGNvdW50Og0KIyBnaXQgZ3JlcCAtbiAtZSByeGVfaW5mbyAtZSByeGVfZXJyIC1lIHJ4
ZV9kYmcgfCBncmVwIC12ICcjZGVmaW5lJyB8IGdyZXAgLXYgJ1xcbicgfCB3YyAtbA0KMTQ2DQoN
Cg0KaSB3aWxsIGRvIGEgYmlnIGNsZWFudXAgZm9yIGFsbCBvZiB0aGVtIGxhdGVyLg0KDQpUaGFu
a3MNClpoaWppYW4NCg0KDQoNCk9uIDIzLzA4LzIwMjMgMTA6NDMsIE1hdHN1ZGEsIERhaXN1a2Uv
5p2+55SwIOWkp+i8lCB3cm90ZToNCj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgMTE6MTMgQU0gTGkg
WmhpamlhbiB3cm90ZToNCj4+DQo+PiBBIG5ld2xpbmUgaGVscCBmbHVzaGluZyBtZXNzYWdlIG91
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyB8IDIgKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+PiBpbmRleCA1NGM3MjNhNmVkZGEuLmNiMmMwZDU0
YWFlMSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4+
ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4+IEBAIC0xNjEsNyArMTYx
LDcgQEAgdm9pZCByeGVfc2V0X210dShzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1bnNpZ25lZCBpbnQg
bmRldl9tdHUpDQo+PiAgIAlwb3J0LT5hdHRyLmFjdGl2ZV9tdHUgPSBtdHU7DQo+PiAgIAlwb3J0
LT5tdHVfY2FwID0gaWJfbXR1X2VudW1fdG9faW50KG10dSk7DQo+Pg0KPj4gLQlyeGVfaW5mb19k
ZXYocnhlLCAiU2V0IG10dSB0byAlZCIsIHBvcnQtPm10dV9jYXApOw0KPj4gKwlyeGVfaW5mb19k
ZXYocnhlLCAiU2V0IG10dSB0byAlZFxuIiwgcG9ydC0+bXR1X2NhcCk7DQo+PiAgIH0NCj4+DQo+
PiAgIC8qIGNhbGxlZCBieSBpZmMgbGF5ZXIgdG8gY3JlYXRlIG5ldyByeGUgZGV2aWNlLg0KPj4g
LS0NCj4+IDIuMjkuMg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3Vk
YS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA=
