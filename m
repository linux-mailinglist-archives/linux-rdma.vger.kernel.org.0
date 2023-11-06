Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C77E1D98
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 10:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjKFJzj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 04:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFJzi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 04:55:38 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEC6A6;
        Mon,  6 Nov 2023 01:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699264535; x=1730800535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w30ohtVQCnNuJMAyIfLDtJ57NvzAamb1v5vyDM1MbOk=;
  b=tlx+up5O0kQNe4PKLVtvdlnB/GUg+TfuEjQhoLyaB4Wbe3Zx/A70h8I8
   UuRe7ubm+60xGvcj0R4tyUuCVdNfSOffv8zlg/4AanEchClZ6MGvhBSvU
   EgSuvhlkAxCFe1kU1m8jDP27lmq7ycH0S9/lfyQdgMyWewzBGrkYIp3C3
   8QuGISc9iaMkn0HUk5WUJnw4gaVJg8+Pc6vNnVON6N1jjjk5Og+ReLiEY
   a6t5dAq7JfzF3KoyHT+gS4B0utLL8YJIEJArrVf9VqsqkQFlWXu1a93y+
   4czeZq+rm+KfHmMebDIkKzvnGZEB+OfVb/Z5HTRaf4NGxO+2GZvdjnjw9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="101500192"
X-IronPort-AV: E=Sophos;i="6.03,281,1694703600"; 
   d="scan'208";a="101500192"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 18:55:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHChE3PoRotlFupY8fAxY8Potky2WWWwA1ARwl7g+nTtskMbH43Lh0Vdhhdkl32hf4blQXXNEQuNNAkPzXtL7im7MM/HHEu7bkhpybNe/sxTddSGnVvY8zuwKw17knDf4iSOOGIMg71tAOQDwt+BqvGzhTeYafYCpuDQptClja3VOTcgrjf0uj7usKzNOiVuRbCFKQMmlCvGmVigHB45L4QUdDCeiTJ1gykVT4PKpp5SuGgw0DPGXDZeN5N3KlZHGbaHY+FacPCsz2lDa0QGQKEnHkBgQLFB+YFfXlSFPK1VUHCLaBxPPw8M0+tIY8xaJe182JfgomV6ZkJThoNqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w30ohtVQCnNuJMAyIfLDtJ57NvzAamb1v5vyDM1MbOk=;
 b=fHKVAzxjS6ZNvzEYHF3HIpLMOjVnfHW1xWwdouD26l3KXXTEhRSyxkGlrnTY7DmXi2K7vbc1zb9LYdzYww2MAmHA6WWyhjzgNHpmQ08H9IQ9x8BIaD1TVQiqVipzA3KD50ipfiynIpk0OtomTo+qsKq/Xjo14MRqLaqHuS3ZCPo1Akr122DT6/fto7q06MKD2tqB5yWYeWoxgUBeJJ5ZOclUKJw8LeqNXrkBugNwCDYtKJ7r9iwo4b7dVX9XSN68JB6WUCcWi1InO9BrYb8qfyscL1y/qf0KmL8doQsS4Gp4adIgqj3ZUWUSrmp4q1nJZy31uRs0EV+cyl7cY4NGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYAPR01MB5578.jpnprd01.prod.outlook.com (2603:1096:404:8057::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:55:27 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 09:55:27 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Greg Sword <gregsword0@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Topic: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBs8fkAgAAaloCAAAW0AA==
Date:   Mon, 6 Nov 2023 09:55:27 +0000
Message-ID: <f4b7cce6-ac65-4ffb-b972-5e784db939c8@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <27a06d26-4443-4349-801e-c09da0d57884@fujitsu.com>
 <CAEz=LcuKpkTfGZ44Kf3YamK=roa-OC=j47ZcHeLsuFe+FqOnaA@mail.gmail.com>
In-Reply-To: <CAEz=LcuKpkTfGZ44Kf3YamK=roa-OC=j47ZcHeLsuFe+FqOnaA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYAPR01MB5578:EE_
x-ms-office365-filtering-correlation-id: 1330ab56-9b97-4cbe-8bac-08dbdeae814a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSADzdgjZOsOXCiSFokhsGeHLAv4RWuQ2XN3MkfJ5NIceFJFIcv/JwxiTrPE1FTMJbE4X0wC4qrrBOSZNyAMIFIQi1DgGRcLEmoMrriM/z0aOI2edX8x0l0nYufwUu2CCC3REGrtOrScbkEufGIKzAgfU63f5cqLtzKF2eNdrAqvoCX5mIpEeN8yQT2d4xIXEqLEoX0yM0RsVi5KmycZIeTuXQ8KCGLq0bVAfgWImsRmM6jR1/WA+nMNX8OxLu0ypKt9JOmwd+HyXIqsz7ucEqYuMuNwjY041Zfnze4sdfJJXT6StfvDh/U7kJG9epWkFqKjW5EweIT9pfofBV2fC2Ou1rf+VM+NEflLA2VqTMe/qzgBmn/z241510knLWYHoQRMa4LJFIpCpcbTM3Icy7GV6g9wTSochWCnBFBbgPR+L4HR0pFZDmMFYkPODBIU8ctNmsWdZPIzXbNsI16u5T2RADrNRXg1kQO8xtR7HJkOpoGMkYqWRIAbEpouNIruAuHXx/vzULnYgarKUZWJScpLXXZiSEvYgRJ8fFIFZ3sS3pv5+ao9dL3TQZT+Q1n/swbmVmoBGI0+2MQCqX5XhykISyE2xAFZnsPGyOeHrjjCt3JiiXcAIztJYkbggGfPaBMBKgJNArMcWpUtYcwMPOeIRnWd5D0kFcFiNXRaOzq9JSEzdNeUZvGipC8a2OmV8jXFYelNIbgLwpyjPt3yhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(1590799021)(451199024)(64100799003)(31686004)(1580799018)(2616005)(6512007)(53546011)(6506007)(478600001)(966005)(71200400001)(6486002)(85182001)(38100700002)(36756003)(86362001)(122000001)(82960400001)(31696002)(5660300002)(41300700001)(2906002)(66476007)(66446008)(64756008)(54906003)(83380400001)(26005)(66556008)(66946007)(38070700009)(91956017)(76116006)(316002)(6916009)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2tIVVpIb2FsbkpRZFVBT3pQRWlFNHZ3T1JDZU9oczY2UjNXclpYRW5wejhy?=
 =?utf-8?B?eXlMRjlYQnRDcnVkek9nVjNDTm1YQXNRaEtXc3p0NnhIVVdNelYvU2VtWkFW?=
 =?utf-8?B?YlQwSHA2ZjE5ciszNjI1MUlBZFl4eDZnRU9XdTR5ck45Z2x5MU9WZkRxcFdG?=
 =?utf-8?B?OVVVdEg1Z2RQTXNIRWsvcWZXQW1XY2U1bFdXdXk2YnV3WVZ6MDYwNWx4VGtP?=
 =?utf-8?B?NTZKNWtsNEZVVkhjTENKamUyZE5FOVMzenVzTzlKSmFBdldrb095ZUd4R2Mr?=
 =?utf-8?B?a3BCUjEwcVV1V2wwSHc0RjM5RmowWEsvUklyemZUNTFMT2xyUlF5RmxpaUpV?=
 =?utf-8?B?UlhIS3U2a0c1T2lQSkxOVWJCcWlrWXFpeVRUVThpZGtqbW1iWmpLSW1FUWk0?=
 =?utf-8?B?RjlTWmdoejlQSGFaQ1dIYjN3MTNZYm5YUTJjK3htK0dFc3VvOXl5RDh2VzFx?=
 =?utf-8?B?enN5VjIyaWNZcnRwV25TS3lFVnlTNWhTeDZlK0xlU3JjUmdndHhTbUxzcG1F?=
 =?utf-8?B?NTdCbHBjRENSaHFyb000THFPSFpMM3g0RFM3TEd2bXdlUmRlUEdsenBWMzZ4?=
 =?utf-8?B?TFpOSUdEZlB6YW5yeUZIaGdGcTcxQmUzeVkxbHo5a1o0YXVRaXpuVWo1a1Z4?=
 =?utf-8?B?MnBPd3VCVU9uU2hZUXhPVlc2WUJvRGpvQmJUNkt4NjRVaCtiREFxUlhLZWFS?=
 =?utf-8?B?V1M0a25Vb0pQNGhOV2FvMVIzekJ3d2dNYUpZVXZzUTVFSDZtdUlJYUliSmFn?=
 =?utf-8?B?QmtWY1BIK2IxaEFXdCtpZnorNU1wa1lSejMxdlR2TC9IQ25vUkNmR2p5c0th?=
 =?utf-8?B?NHp4QXJ2SjJOMDRDdzVKOGxIMlNqbEdXTHVVc2g0ZUU3N05DdU5aKzZ4cW5p?=
 =?utf-8?B?WXEyd3ozb3RGbDZGWnlZZ0xscEVRMXBLSUpYT0ZUU01EZDRxYjhpbkNydXBL?=
 =?utf-8?B?Qys4OENtQXcwM1ZiNXdEVzZDQWZNbHQ1b1Q4NzAvcU0yUmJnQm9Gdk9Mb2Zp?=
 =?utf-8?B?L2w4REZXU01SQ2ovcUJqQ0EvcEIyKyt1Umpld1FwbzF4b3pmdVFtbGFyWXFG?=
 =?utf-8?B?RElEdDBoUXJQMmJwK2NFdm11ZnUwQTMwWTE3VXBJMXlseXlqL0t0UnBCVFRu?=
 =?utf-8?B?VVVQNXZoSTFLb0x2OENCempOY1Q3amszNVIrMXg3RVlzdUFWOVliQTRaTWhC?=
 =?utf-8?B?YUtmQ0tkcDlmZ2Npa1o4b2EzUFFrVmppcHlQdlY5SE5ialQ2R2Z0dGFIOEpN?=
 =?utf-8?B?b2ZlVzgyQmp2bmFLdmZWTjJSWXpEampUdEpCeVhXWTdnSFUrS2RUQy9OTTUr?=
 =?utf-8?B?MDZ1alNraHZWWk9BVWR2d1J4c05yTndEcDVqcGF2SU8vZHJPcDN0cEhteGR4?=
 =?utf-8?B?WTRhRlpQL0hRV2JEZTMxZ2hramp4cllHL0tJTDVkRkIrV045M3YzUEw4Tjh2?=
 =?utf-8?B?TDRPNHVRTzJBdU9zUjQwNUlTdm1EUmVVakhBNHBpa1B6ZXdZb05xd1MwaXhj?=
 =?utf-8?B?dzd4aitLczNSSU9zazBsT3hYaEU4eHFmR0dXb08wdlErT0xzVEp2VDJwMG93?=
 =?utf-8?B?b3AvVWlWdVhsR3kva0VERFV3aENxcHR4SktsZ0JPSDZaNlpIUjFRU1Y4MHNI?=
 =?utf-8?B?eEtVMzBuTUVsbi9GdkR2MlRRNGdVdDZ5ZGRoTEJhTTFjU2lQK3dOaUxPQjNZ?=
 =?utf-8?B?MllRWmNIQW9TUmFJVHorMEc5eUUrK3NRdXZPUnE0aGhoa3cxL1E0clFza3Nj?=
 =?utf-8?B?QzlOQ2pTR2NLd0o3a2Uzd2RvcnBQL2dHeGl6eWN1NWhDSVdwWGNsc1RWaFB3?=
 =?utf-8?B?NFQ4UStBYzNnWmc4Y0R4UzE5VS9rNHRZaThqSzlPOS9MYTNBV0RySzR1Unhn?=
 =?utf-8?B?VEVaT0YvV2JnSzY4ci8yRlBRS3l6TStuYlVTRmpIdzJNZ0xlU1V4Q3dvVzRQ?=
 =?utf-8?B?cXNzS1NrRXlDeUw3ekZ5NzVzd0RsQURlM3VKR21uK1NobGFYTWY5TE1VczNO?=
 =?utf-8?B?OVRRMEJvWFlucmhEOWV5dFg1bUk0RXA1TTE1a1ljSjg1VndQbU9hQXVPMDdK?=
 =?utf-8?B?RGRjQThrb0pTVEFsbWNLMkpBdUlFN2NVTDloUVhIdDZjQ0MzT041N3BucEds?=
 =?utf-8?B?UmthUTYwTXIxU09IYmlaWk5INHc3TG1FcGJITkZLZHhWcVJUTjRXc3FTSVI1?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28A8E1DF2C97EE4698281AF7D153CBF0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XChrfU4jEB6cP0PkhVI2899Uk3urRz4sxD2V5nrSNkYjPIq57RfDuwC/40xDRwtfKcv2iOxi9b4bs5N/T1yME0bZGIAnXxG4DEnaBvzpTuFHv3ujTQAWowp1OY9xKoUBHUFyfPdhtd78kJRYFwSEfd86uc49PkbQ4ZaCG35TpH4z7uUbF7aIbyUMO74Mi8zHXIQL8EsvNCpfn4IcHyx7nGYUwf9U7Qtx5G8aCHZa1PQCVvZ2LG2yjvZCvZ5CyQZriBdrw/1bloYxUAmHDdGFoa+8J44OlWIEILBSVHXtCi1A9TRGlCo6KCaMrxSohuA2u/ClMWRO+nM9tGEW4D4/dyAztVL/sLH0LPWqNApHw6kZgsNqWXRwNLISH6pietPBtWBxH6K76tEQA1IxxaELPD9em1tHk8zrGaMZNgqsX5Qt/2dm14oSqoZc6t+rYKz8cJ1QZ7sCCFv4uXTx88kRijJwrPcnZU/CeKGbsP34tzpmOytd8cCv+syTk6M76BtHF/oaqFQ0WJLhZx51cElyeODzrzX4IDPohelbEk/8AZfGve69WNuQjF9Rm8bP5un+GUe7+XxeTBqQfuQQ1kbrWLpJ4ECpf97SzDsToQkGQw6s7gh9n35St/TD460lw+RXjeJoSA5pu4hTrduGTuakRd8aRWG5uUcStFtP7kE+IujTYBKS4Cm48E7+4z6wpyFea5LSGsMqSKdEBr3xETZNF4YlcDZA0VUM/pEZaEPbWYmifc8ILLo8QLrdX2Bs4d2jDRu/27a2QLq369XzFZ1wbeWRRwvJmW/Z6t7K2d2Xo7y97vBHVBo6H39mX4Q0Mf0YOE//8tpI9ILwDC8teVOcoEz6fNcK0FasLwDaJZhdbBpeOJXhi6vE2DwfNzmsn43gdgQ0gEiG7vOC4GHthxmeuA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1330ab56-9b97-4cbe-8bac-08dbdeae814a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 09:55:27.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdrQ4ZaLXAoOVlbu1JlNg0avLRQ0ZXBGufbhVAiLE7fZyfAoxgyCy8KS65nOECecybJ7lf+PzTYRi7xk3SkeJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5578
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzExLzIwMjMgMTc6MzUsIEdyZWcgU3dvcmQgd3JvdGU6DQo+IE9uIE1vbiwgTm92
IDYsIDIwMjMgYXQgNDowMeKAr1BNIFpoaWppYW4gTGkgKEZ1aml0c3UpDQo+IDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gVmVyeSB0aGFua3MgZm9yIGFsbCB5
b3VyIGZlZWRiYWNrLg0KPj4NCj4+IE9uIDAzLzExLzIwMjMgMTc6NTUsIExpIFpoaWppYW4gd3Jv
dGU6DQo+Pj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZpZXdlZC1ieSB0byB0aGUgcGF0Y2gxLTIg
dGhpcyB0aW1lLCBzaW5jZSBpDQo+Pj4gdGhpbmsgd2UgY2FuIG1ha2UgaXQgYmV0dGVyLg0KPj4+
DQo+Pj4gUGF0Y2gxLTI6IEZpeCBrZXJuZWwgcGFuaWNbMV0gYW5kIGJlbmlmaXQgdG8gbWFrZSBz
cnAgd29yayBhZ2Fpbi4NCj4+PiAgICAgICAgICAgICBBbG1vc3Qgbm90aGluZyBjaGFuZ2UgZnJv
bSBWMS4NCj4+DQo+PiBRdW90ZSBmcm9tIEphc29uOg0KPj4gIg0KPj4+IFRoZSBjb25jZXB0IHdh
cyB0aGF0IHRoZSB4YXJyYXkgY291bGQgc3RvcmUgYW55dGhpbmcgbGFyZ2VyIHRoYW4NCj4+PiBQ
QUdFX1NJWkUgYW5kIHRoZSBlbnRyeSB3b3VsZCBwb2ludCBhdCB0aGUgZmlyc3Qgc3RydWN0IHBh
Z2Ugb2YgdGhlDQo+Pj4gY29udGlndW91cyBjaHVuaw0KPj4+DQo+Pj4gVGhhdCBsb29rcyBsaWtl
IGl0IGlzIHJpZ2h0LCBvciBhdCBsZWFzdCBjbG9zZSB0byByaWdodCwgc28gbGV0cyB0cnkNCj4+
PiB0byBrZWVwIGl0DQo+PiAiDQo+Pg0KPj4NCj4+IEl0IHNlZW1zIGl0J3Mgb2theSB0byBhY2Nl
c3MgYWRkcmVzcy9tZW1vcnkgYWNyb3NzIHBhZ2VzIG9uIFJYRSBldmVuIHRob3VnaA0KPj4gd2Ug
b25seSBtYXAgdGhlIGZpcnN0IHBhZ2UuDQo+IA0KPiBEbyB5b3UgcmVhbGx5IG1ha2UgdGVzdHMg
aW4geW91ciB0ZXN0IGVudmlyb25tZW50PyBEbyB5b3UgaGF2ZSB0ZXN0IGVudmlyb25tZW50Pw0K
DQoNCg0KPiBEbyB5b3UgcmVhbGx5IHJlcHJvZHVjZSB0aGlzIHByb2JsZW0gaW4geW91ciB0ZXN0
IGVudmlyb25tZW50Pw0KSSBkaWQgdGhlIHRlc3QsIHRoZSBrZXJuZWwgcGFuaWNbMV0gaXMgZ29u
ZSBhZnRlciBwYXRjaDEtcGF0Y2gyDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiBZb3VyIHBh
dGNoZXMgZG8gbm90IHdvcmsgYWN0dWFsbHkuIFBsZWFzZSBkbyBub3Qgc2VuZCB0aGVzZSBydWJi
aXNoIHBhdGNoZXMgb3V0Lg0KPiANCj4+DQo+PiBUaGF0IGFsc28gbWVhbnMgUEFHRV9TSVpFIGFs
aWduZWQgTVIgaXMgYWxyZWFkeSBzdXBwb3J0ZWQsIHNvIG9ubHkgY2hlY2sNCj4+IGBpZiAoSVNf
QUxJR05FRChwYWdlX3NpemUsIFBBR0VfU0laRSkpYCBpcyBzdWZmaWNpZW50LCByaWdodD8NCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IGluZGV4IGY1NDA0MmU5YWViMi4u
Mzc1NWU1MzBlNmRjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPj4g
QEAgLTIzNCw2ICsyMzQsMTIgQEAgaW50IHJ4ZV9tYXBfbXJfc2coc3RydWN0IGliX21yICppYm1y
LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnbCwNCj4+ICAgICAgICAgICBzdHJ1Y3QgcnhlX21yICpt
ciA9IHRvX3JtcihpYm1yKTsNCj4+ICAgICAgICAgICB1bnNpZ25lZCBpbnQgcGFnZV9zaXplID0g
bXJfcGFnZV9zaXplKG1yKTsNCj4+DQo+PiArICAgICAgIGlmICghSVNfQUxJR05FRChwYWdlX3Np
emUsIFBBR0VfU0laRSkpIHsNCj4+ICsgICAgICAgICAgICAgICByeGVfZXJyX21yKG1yLCAiRklY
TUUuLi5cbiIpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArICAgICAg
IH0NCj4+ICsNCj4+ICAgICAgICAgICBtci0+bmJ1ZiA9IDA7DQo+PiAgICAgICAgICAgbXItPnBh
Z2Vfc2hpZnQgPSBpbG9nMihwYWdlX3NpemUpOw0KPj4gICAgICAgICAgIG1yLT5wYWdlX21hc2sg
PSB+KCh1NjQpcGFnZV9zaXplIC0gMSk7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bh
cmFtLmgNCj4+IGluZGV4IGQyZjU3ZWFkNzhhZC4uYjFjZjFlMWMwY2UxIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KPj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KPj4gQEAgLTM4LDcgKzM4LDcgQEAgc3Rh
dGljIGlubGluZSBlbnVtIGliX210dSBldGhfbXR1X2ludF90b19lbnVtKGludCBtdHUpDQo+PiAg
ICAvKiBkZWZhdWx0L2luaXRpYWwgcnhlIGRldmljZSBwYXJhbWV0ZXIgc2V0dGluZ3MgKi8NCj4+
ICAgIGVudW0gcnhlX2RldmljZV9wYXJhbSB7DQo+PiAgICAgICAgICAgUlhFX01BWF9NUl9TSVpF
ICAgICAgICAgICAgICAgICA9IC0xdWxsLA0KPj4gLSAgICAgICBSWEVfUEFHRV9TSVpFX0NBUCAg
ICAgICAgICAgICAgID0gMHhmZmZmZjAwMCwNCj4+ICsgICAgICAgUlhFX1BBR0VfU0laRV9DQVAg
ICAgICAgICAgICAgICA9IDB4ZmZmZmZmZmYgLSAoUEFHRV9TSVpFIC0gMSksDQo+PiAgICAgICAg
ICAgUlhFX01BWF9RUF9XUiAgICAgICAgICAgICAgICAgICA9IERFRkFVTFRfTUFYX1ZBTFVFLA0K
Pj4gICAgICAgICAgIFJYRV9ERVZJQ0VfQ0FQX0ZMQUdTICAgICAgICAgICAgPSBJQl9ERVZJQ0Vf
QkFEX1BLRVlfQ05UUg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCBJQl9ERVZJQ0VfQkFEX1FLRVlfQ05UUg0KPj4NCj4+DQo+PiAqIG1pbm9yIGNsZWFudXAg
d2lsbCBiZSBkb25lIGFmdGVyIHRoaXMuDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGlqaWFuDQo+Pg0K
Pj4+IFBhdGNoMy01OiBjbGVhbnVwcyAjIG5ld2x5IGFkZA0KPj4+IFBhdGNoNjogbWFrZSBSWEUg
c3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBtciAjIG5ld2x5IGFkZCwgYnV0IG5vdCBmdWxseSB0
ZXN0ZWQNCj4+Pg0KPj4+IE15IGJhZCBhcm02NCBtZWNoaW5lIG9mZnRlbiBoYW5ncyB3aGVuIGRv
aW5nIGJsa3Rlc3RzIGV2ZW4gdGhvdWdoIGkgdXNlIHRoZQ0KPj4+IGRlZmF1bHQgc2l3IGRyaXZl
ci4NCj4+Pg0KPj4+IC0gbnZtZSBhbmQgVUxQcyhydHJzLCBpc2VyKSBhbHdheXMgcmVnaXN0ZXJz
IDRLIG1yIHN0aWxsIGRvbid0IHN1cHBvcnRlZCB5ZXQuDQo+Pj4NCj4+PiBbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL0NBSGo0Y3M5WFJxRTI1anlWdzlyajlZdWdmZkxuNStmPTF6bmFC
RW51MXVzTE9jaUQrZ0BtYWlsLmdtYWlsLmNvbS9ULw0KPj4+DQo+Pj4gTGkgWmhpamlhbiAoNik6
DQo+Pj4gICAgIFJETUEvcnhlOiBSRE1BL3J4ZTogZG9uJ3QgYWxsb3cgcmVnaXN0ZXJpbmcgIVBB
R0VfU0laRSBtcg0KPj4+ICAgICBSRE1BL3J4ZTogc2V0IFJYRV9QQUdFX1NJWkVfQ0FQIHRvIFBB
R0VfU0laRQ0KPj4+ICAgICBSRE1BL3J4ZTogcmVtb3ZlIHVudXNlZCByeGVfbXIucGFnZV9zaGlm
dA0KPj4+ICAgICBSRE1BL3J4ZTogVXNlIFBBR0VfU0laRSBhbmQgUEFHRV9TSElGVCB0byBleHRy
YWN0IGFkZHJlc3MgZnJvbQ0KPj4+ICAgICAgIHBhZ2VfbGlzdA0KPj4+ICAgICBSRE1BL3J4ZTog
Y2xlYW51cCByeGVfbXIue3BhZ2Vfc2l6ZSxwYWdlX3NoaWZ0fQ0KPj4+ICAgICBSRE1BL3J4ZTog
U3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBNUg0KPj4+DQo+Pj4gICAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbXIuYyAgICB8IDgwICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0K
Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggfCAgMiArLQ0KPj4+
ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggfCAgOSAtLS0NCj4+PiAg
ICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPj4+
