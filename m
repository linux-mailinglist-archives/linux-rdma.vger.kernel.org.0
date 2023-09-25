Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4617ACF42
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 06:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjIYEsy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 00:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjIYEsv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 00:48:51 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 21:48:42 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45A101;
        Sun, 24 Sep 2023 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695617322; x=1727153322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOK5cV8HriOzhsaRVcFW285Mw9HH3B//28pKRzKw3VE=;
  b=Z9FKGv0lurP3FB+lHRYBjYWhq/UZsbdvNTdRrEfFH+57OIxOa0ejn66/
   2kmPBqvB9QrmQrP8BEqLy5/WTN381Xd2x7GB6TuyP0X3AZSer7SaZQ84k
   XX8DPygRopQHQi81WO4izLXyZ5ArtF6DfpqW47KFGsF4DVNC7wuwPyEf+
   MY49tKe3cGW3a2/3DT97CAfs/h4B0Pyl/mzzJ+611FH7jS4LUPdulVELg
   PE/entpUCeAJ6KJWbnf8G1o+8JwVwyVba4kPrdfBY50AsQUN8HIr1rnlM
   f7IGdngInoUbn4LpMZ6zmCmenkv55Nx6FR3zBQ4O52MrKvAzNwmEeyvUe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7652895"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; 
   d="scan'208";a="7652895"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 13:47:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCj9tDgFAjOPRbX1cOUpnUmqwzLoJEupBfzQ8F+Mgf95ijalBR5vxM4A6X/6OPHZHrI21HAEbuIK2nmwODR6M0l4UNekeNcnXLWhzYr3gahaXLQCsUBBy6ycOxrt8ijkEt3wuehyBHkNl7uTiHkYmo7fxJzRLOzZw/kPDijK2R8LBsPIiptgv/Y5juS9ip3grVymUI73o0TUpAod+hcfeEAVwTZWuMUsiVNqO17Bd8OmA7gKvuokBM447JcYkrKzXKtFPtSY/0MmKx4NnwSwcWg0iY9GytPFtotZs88V/YNdCndEea0dp1Odgor7Ke03aXKoK9ziX+mRD9zTQzNR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOK5cV8HriOzhsaRVcFW285Mw9HH3B//28pKRzKw3VE=;
 b=eJExmjbZpLCdsrAN5pwJVw/5VxSVRM2wGzhV8QlKsJsBKUcaNMGhTQ68og4SATgKwVCgQCRRRUPacxe2pn8tE+B6JEC6FEVNjFQSTaTibzpd0000VagvLeQiENm0+ekz1s+8W5oi+FTAfyNo58mEOzTPChMC8I4ZuPWi/IH4/uVwjsms7Ifj0JaACQb3xgnxjfbvW9xn/qTnIUp1/+06JWVhAzBFKb302RrbvFCQYhAs+qRcFuOUMsxziNcwPuCaSi26oSX33Yjh+MLrYDe+PccgQ+rMWMgMcBFb4tofdOz6LPRxywTfMm/vyPBCziUMRa7hoXTOaLlrqZ2jH+/SAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB8509.jpnprd01.prod.outlook.com (2603:1096:400:172::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:47:31 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 04:47:31 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAIAAQSmAgACo/YCAAKqdAIAAybuAgAADVACAAAvRAIAAARmAgAAB7YCAAWLiu4AACHmAgAHFvwCAAgi0AIABpikg
Date:   Mon, 25 Sep 2023 04:47:31 +0000
Message-ID: <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
In-Reply-To: <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9N2QxMzNiOTItYTgzNS00MzhjLTk5YjItMGJmMGVkYmIy?=
 =?utf-8?B?YzFhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yNVQwMjoyODo0NFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB8509:EE_
x-ms-office365-filtering-correlation-id: c20d9e66-c55c-4853-50bc-08dbbd828710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDB9xwwO6HYzteme4vGst4zTJYy4PUCuAFVsiRP2L4PhQDJMjXLShN0qSrTMLdcHRA/CWUlB3cNpzsh0caw2o0CwrvfArdqgO2YRre0atnxsOrKfsh/zQFi/jfM4eSeKndaNwYZ/jpdkEfNf7lY5awcypUoFXvTpkf7EcYmij3C2HxSstAHrXJorzVWxbZuRG44LvJ18LUVcNe7NrgHjo0pHnmxsh+7eNwmebikaiDTDXqsZSMg+VZRaJ9XgxbFJQixdhC4qLGhi7ZSdOqGuuS7Pengw6LT3uAW8ximiD3cQIix7oaVj2ZuBlHo3bw3ZG5g4fxsfXXeg7mzBNcn/zu4OM9LLCJfJ1FURIHP4l+KVNyL6ngG/AR7tb11L9Y99SpIoX2JewcTS310blREDv54JZetJjA7Lge7VOi6oS07n3tyekpf+RyEF5vUnUv+1B6zJIk9r0ekeAQxtD2DpuwYHyyazJKBLPMrpqkvGTp3pa9OO3ix7g9hsEUI1a3819Cw8c9zYe+ttsZ60ERZB2g/bqBeP16RvlcID0kIfdK0IYkekjBXDVnpID0+iRJL54RkXjoIyb76LodrrtILJJPuyx2CGx1c+MspiGbJRTY68vcRkVN12A2sMPfx6cgtoPGn92dVNut5Pl4RjDqgaSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(55016003)(1580799018)(83380400001)(26005)(8936002)(8676002)(4326008)(478600001)(966005)(52536014)(66476007)(41300700001)(66446008)(64756008)(54906003)(66556008)(66946007)(110136005)(316002)(76116006)(5660300002)(9686003)(53546011)(2906002)(7696005)(71200400001)(6506007)(85182001)(33656002)(82960400001)(38070700005)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHRWMGpaaVpPdjJKNERNU1RTRGthT2YxSVd4bkVHdHBkWnYva3pPQ0JRem1L?=
 =?utf-8?B?andvdjdvRXNLUkRxaUViZ3ZZRkg3MWxkRjF0b1c5UGZzWVpVdFRraW0vbHdB?=
 =?utf-8?B?RDROK0ZnS2pka29zSXBvR3I5YUx5M3RBdjJOZWw4WkZOVUdzaTl4ekZ6TTZy?=
 =?utf-8?B?VlZGbXlNU3lmTWh4dTBZYmt1NlJDWGYvTHhxYVNrcmxWeDl4T1Q1d2F4dmwv?=
 =?utf-8?B?eTNCS1lhTzFUSU1JZndOVkIrdmU3dlcvalZkQXRZbmFPK3ZhWExWWkF6VW44?=
 =?utf-8?B?SjNFbmFlckhQSlZjYkNSTldOdlJVS2Nhc29MaFQ5cWx1dWhBT0VHVTFkMUhl?=
 =?utf-8?B?ME9zNTljRUpXSStoWm5KdWE0dnh4eUt6eXhXNHRLQzR5ZWVJakh3dkdRV0tN?=
 =?utf-8?B?cEdFSWNKcXFUaHoxRytFZkNTSXZHaFNhSlVIQUVWeFhlNkdjZ3Y3aHlzZHBy?=
 =?utf-8?B?d1Vkd2tqSnBaUzJEeVVPZGtQSHVJU0JVeEM0Z3BQdW9vRHhCTDhOWEU4VG5R?=
 =?utf-8?B?V1VzM2dpdTUyb3JVTXJiMFdtNmRFWUdxZzVlTUR4M2FQcFBIVDdCNGpTanBR?=
 =?utf-8?B?WUVVaTNrWStqT0ZqWnVEVjU1ZVZaU2tFVnprMUYxOEsrSzBJSmR4RmFLd2o4?=
 =?utf-8?B?ZE9ROHJCZXYxdnZSSnVvVzdZNXMzblVhc0UzRENrQWNlZ3MrdytqdHc0SmhV?=
 =?utf-8?B?SFU4YlR2SlhuNUlkMWZrQWVqLzlGenFMT3IxanVKN21RMXlIa2t1TmtQL0ZU?=
 =?utf-8?B?RllXckNlelNNWHp6WjJwMTNQVk5Fc2lYSEZ3RGZ5S0R2Z2c1eXJ4QXp3b0dX?=
 =?utf-8?B?TVlzRTcvdHo3bTFseS9mbElzOC9XK1JHaVNjR002dEc3U0NEeTRiSEFTS0hr?=
 =?utf-8?B?QUV2WmFxK0NrV0J0MHVtTU9YVzN4eU1ibGlja1NRcnVQcXh5MXBFVzV1MXJO?=
 =?utf-8?B?ZUVaWVRUZ3ZVQ0R1R0p6bEZkeHJjbVl5ZG1rOGUxNUh3d2NRY2xaV2t6aktW?=
 =?utf-8?B?T2FwRG9jTTkxOHBQSXcrQkx1dEFmT1BPSmNBdkNHckRTYjJEN0p3N0FjZktE?=
 =?utf-8?B?Y0ZHdFZFa2psSzhJdjh2QStTUy9XcTN4dHA3N1pWUzFsaUNqcTJrSjA1d0VO?=
 =?utf-8?B?NC9XenlSZmllZFZkclBZMUNTYzRoUW9HbXc5SGpnTnV5MnRYK1kveHgxb2Nn?=
 =?utf-8?B?cWNhQ05MU3hZM005QWU0Y0RoSS9nR3dnKzJndEFjMlJwYUREQnZHcm9xeXRh?=
 =?utf-8?B?SkxZcTZ5SzdtZkNQQXNMZ0I5eGJBUGkyTkt2T0g2RmFqbEY3clpFak44WVhR?=
 =?utf-8?B?U1ZXckZBQ1loNjlvQVVEMFd5UExpTEpCWjJBbFMvQlBnV0RvMWMrM0RIR0Ro?=
 =?utf-8?B?Vk01STRyRTQ5SnNUeTgzRm14TlRqUmJJL2d6T0gzY0NERDErR2pabGtzM0ha?=
 =?utf-8?B?cUppSk5KWlJPN2NvUTYxYWthZ0xlcWZreGV3Q1VQbzNScGpNNERuc2dSOVRH?=
 =?utf-8?B?SjFyb0RVVDE0ZjRwZGtXUEJKREVOclMvb1hEWExXcEpoWTdiQjkrTDRKOEZw?=
 =?utf-8?B?bXFYRVVxMTR6YkIyVGNjRThBUENkZjFLeGN3M0t3c2h4TytUQ2plQVQ4OUR2?=
 =?utf-8?B?bFdHcTR5RzdVQzcwS0tGWTRmTno2WjE3M1U2QlpEU25lL2hUU3RSbG9UOFJD?=
 =?utf-8?B?NVRQQzZCdzNCbDlMaWdHSkloaXd5dm9NUUkyOFZxdS9kcEdlV2FXZzEzSVFP?=
 =?utf-8?B?d2JuelA0RnRBS1A1aGo2ZjBHQy81MWZkRFVkcFdLTThqTXM5SVpDWkxwREVp?=
 =?utf-8?B?VnZHY21FQi9zVWdUb2xseHUzNkxRb09haDI1TmRkUHJXVTRqK0pqQWVQZ0xZ?=
 =?utf-8?B?Sm9qZmUrdnRZVU1Qd1c0bFdsamJtaXhSOW1Tc2VZTVhiNXZEbjdrb2hQcVgw?=
 =?utf-8?B?UU96T3krU2Y5NytGQXZUQ05MQ3F4cVEzUHhxd1d4eGZPZWNUbUsrQWJKOGpy?=
 =?utf-8?B?Z3dXVWdobng3VWdVMU5Zei94QzNYbnM5bmtZWncrVUhqcm9QK0owU2ZCUlV2?=
 =?utf-8?B?S3ViT1dmM0hzakJUVmlaY0tFL0QzMkJ4cEIzaVExc1FGbGRBRHBXQmtWOHlZ?=
 =?utf-8?B?U0JQNWl2NFNLTysrR21YMjhCMXVkQTAyYlNLbE1Wait4MjF1UEdRUzBFUit1?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /lUemw4U0Et19cWakriQDl+t9jJe4EiREwdmxYj79MnyPfmP6Fhh0yDeyRSALBtIkbOHp4j0LneHYmogM2EsPhCLBX4ZipwDnLlUExDlEpI+07mP216WcmIM4Aq98iIVMTQXjK0mbdeW3wJu9wy/Tt0yv8lQGf6iaf5WMQeB8mEtellloWtrXWp3+Ak3C+mpMlzdnIJ4qwZl03XNihYUHmfhzu6KA1bkfLkldm3hGp/Hxvvd1PckFnvQRpT4RTqGV+fVsWDNMv4ClRx4EYmUKlH6qP3kOHmc65LGJnHC9tn8Levy6chGL6Kl50aJ7nrjuzCMS3JTh5kNuAB79cCc2PpeLFsr+0lOABcNCjV+fchBqnVG+q1hT3nb2xWq3bwRPIOLd7SfGgrU3k5r1ejCRKwCGKV9Xl/gPw8xBVUb8e1oCE/L/6c+0PYkBvrGfcA3OVG0rwGIcYg5Sj1IOrf8iF3N8KCkoKyBQ3/sN9u3A/Sq0QEawRL3neJk+aGZkqw1CCEhISez2kcaj63727EsVaClnit3FHIuOuWdZPl1OOy9bcH/ZlBj6x7GDzplkeuwLGHAY9fE0Ilt8222UAcNPORdbDYB9vueR9jChBzZMJcefyQ0LIHaoT3epuY/vuQvvjivyPufJmxfM+8+ok3Dj7DtWUWhr81UeUG2wIyFOFHwDHm+HhdVKurNP6o4C2NmNRLwQe47Grmo2XL57UpEJlBS5RO80n93ftfRh9mJnhMWiB0AArXGo6LzrMtV8t+yrgR4JKocKkXwgHt8acdFYnQBK83b/402FTlo/3P24ZH5pLH0duMzQOuSgJk/50VmiRJr/ZWnP/d86FBWEtR1NSIXnG2Qu5+T6VfGZTqkc2Hnhk6f2A2Go5oDAl4Fu5DH/Nu4r6Laue8y4MYp0SDtJmnbya9UNE6YNqwAycqNPJI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20d9e66-c55c-4853-50bc-08dbbd828710
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 04:47:31.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HRgRsEvYrirYa3FiMn4fx/YyoE0WqwXRHh5Zpo7g4cm7EO0qbhEmbbWpKKONFwJjNGv1+65km3AGPXyKwb77eo5GcN7c0RdcsRLXcUs8tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8509
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU3VuLCBTZXAgMjQsIDIwMjMgMTA6MTggQU0gUmFpbiBSaXZlciB3cm90ZToNCj4gT24gU2F0
LCBTZXAgMjMsIDIwMjMgYXQgMjoxNOKAr0FNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFp
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gOS8yMS8yMyAxMDoxMCwgWmh1IFlhbmp1biB3cm90
ZToNCj4gPiA+DQo+ID4gPiDlnKggMjAyMy85LzIxIDIyOjM5LCBCb2IgUGVhcnNvbiDlhpnpgZM6
DQo+ID4gPj4gT24gOS8yMS8yMyAwOToyMywgUmFpbiBSaXZlciB3cm90ZToNCj4gPiA+Pj4gT24g
VGh1LCBTZXAgMjEsIDIwMjMgYXQgMjo1M+KAr0FNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+ID4+Pj4gT24gOS8yMC8yMyAxMjoyMiwgQmFydCBWYW4gQXNz
Y2hlIHdyb3RlOg0KPiA+ID4+Pj4+IE9uIDkvMjAvMjMgMTA6MTgsIEJvYiBQZWFyc29uIHdyb3Rl
Og0KPiA+ID4+Pj4+PiBCdXQgSSBoYXZlIGFsc28gc2VlbiB0aGUgc2FtZSBiZWhhdmlvciBpbiB0
aGUgc2l3IGRyaXZlciB3aGljaCBpcw0KPiA+ID4+Pj4+PiBjb21wbGV0ZWx5IGluZGVwZW5kZW50
Lg0KPiA+ID4+Pj4+IEhtbSAuLi4gSSBoYXZlbid0IHNlZW4gYW55IGhhbmdzIHlldCB3aXRoIHRo
ZSBzaXcgZHJpdmVyLg0KPiA+ID4+Pj4gSSB3YXMgb24gVWJ1bnR1IDYtOSBtb250aHMgYWdvLiBD
dXJyZW50bHkgSSBkb24ndCBzZWUgaGFuZ3Mgb24gZWl0aGVyLg0KPiA+ID4+Pj4+PiBBcyBtZW50
aW9uZWQgYWJvdmUgYXQgdGhlIG1vbWVudCBVYnVudHUgaXMgZmFpbGluZyByYXJlbHkuIEJ1dCBp
dCB1c2VkIHRvIGZhaWwgcmVsaWFibHkgKHNycC8wMDIgYWJvdXQgNzUlIG9mDQo+IHRoZSB0aW1l
IGFuZCBzcnAvMDExIGFib3V0IDk5JSBvZiB0aGUgdGltZS4pIFRoZXJlIGhhdmVuJ3QgYmVlbiBh
bnkgY2hhbmdlcyB0byByeGUgdG8gZXhwbGFpbiB0aGlzLg0KPiA+ID4+Pj4+IEkgdGhpbmsgdGhh
dCBaaHUgbWVudGlvbmVkIGNvbW1pdCA5YjRiN2MxZjlmNTQgKCJSRE1BL3J4ZTogQWRkIHdvcmtx
dWV1ZQ0KPiA+ID4+Pj4+IHN1cHBvcnQgZm9yIHJ4ZSB0YXNrcyIpPw0KPiA+ID4+Pj4gVGhhdCBj
aGFuZ2UgaGFwcGVuZWQgd2VsbCBiZWZvcmUgdGhlIGZhaWx1cmVzIHdlbnQgYXdheS4gSSB3YXMg
c2VlaW5nIGZhaWx1cmVzIGF0IHRoZSBzYW1lIHJhdGUgd2l0aCB0YXNrbGV0cw0KPiA+ID4+Pj4g
YW5kIHdxcy4gQnV0IGFmdGVyIHVwZGF0aW5nIFVidW50dSBhbmQgdGhlIGtlcm5lbCBhdCBzb21l
IHBvaW50IHRoZXkgYWxsIHdlbnQgYXdheS4NCj4gPiA+Pj4gSSBtYWRlIHRlc3RzIG9uIHRoZSBs
YXRlc3QgVWJ1bnR1IHdpdGggdGhlIGxhdGVzdCBrZXJuZWwgd2l0aG91dCB0aGUNCj4gPiA+Pj4g
Y29tbWl0IDliNGI3YzFmOWY1NCAoIlJETUEvcnhlOiBBZGQgd29ya3F1ZXVlIHN1cHBvcnQgZm9y
IHJ4ZSB0YXNrcyIpLg0KPiA+ID4+PiBUaGUgbGF0ZXN0IGtlcm5lbCBpcyB2Ni42LXJjMiwgdGhl
IGNvbW1pdCA5YjRiN2MxZjlmNTQgKCJSRE1BL3J4ZTogQWRkDQo+ID4gPj4+IHdvcmtxdWV1ZSBz
dXBwb3J0IGZvciByeGUgdGFza3MiKSBpcyByZXZlcnRlZC4NCj4gPiA+Pj4gSSBtYWRlIGJsa3Rl
c3QgdGVzdHMgZm9yIGFib3V0IDMwIHRpbWVzLCB0aGlzIHByb2JsZW0gZG9lcyBub3Qgb2NjdXIu
DQo+ID4gPj4+DQo+ID4gPj4+IFNvIEkgY29uZmlybSB0aGF0IHdpdGhvdXQgdGhpcyBjb21taXQs
IHRoaXMgaGFuZyBwcm9ibGVtIGRvZXMgbm90DQo+ID4gPj4+IG9jY3VyIG9uIFVidW50dSB3aXRo
b3V0IHRoZSBjb21taXQgOWI0YjdjMWY5ZjU0ICgiUkRNQS9yeGU6IEFkZA0KPiA+ID4+PiB3b3Jr
cXVldWUgc3VwcG9ydCBmb3IgcnhlIHRhc2tzIikuDQo+ID4gPj4+DQo+ID4gPj4+IE5hbnRoYW4N
Cj4gPiA+Pj4NCj4gPiA+Pj4+PiBUaGFua3MsDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBCYXJ0Lg0K
PiA+ID4+Pj4NCj4gPiA+PiBUaGlzIGNvbW1pdCBpcyB2ZXJ5IGltcG9ydGFudCBmb3Igc2V2ZXJh
bCByZWFzb25zLiBJdCBpcyBuZWVkZWQgZm9yIHRoZSBPRFAgaW1wbGVtZW50YXRpb24NCj4gPiA+
PiB0aGF0IGlzIGluIHRoZSB3b3JrcyBmcm9tIERhaXN1a2UgTWF0c3VkYSBhbmQgYWxzbyBmb3Ig
UVAgc2NhbGluZyBvZiBwZXJmb3JtYW5jZS4gVGhlIHdvcmsNCj4gPiA+PiBxdWV1ZSBpbXBsZW1l
bnRhdGlvbiBzY2FsZXMgd2VsbCB3aXRoIGluY3JlYXNpbmcgcXAgbnVtYmVyIHdoaWxlIHRoZSB0
YXNrbGV0IGltcGxlbWVudGF0aW9uDQo+ID4gPj4gZG9lcyBub3QuIFRoaXMgaXMgY3JpdGljYWwg
Zm9yIHRoZSBkcml2ZXJzIHVzZSBpbiBsYXJnZSBzY2FsZSBzdG9yYWdlIGFwcGxpY2F0aW9ucy4g
U28sIGlmDQo+ID4gPj4gdGhlcmUgaXMgYSBidWcgaW4gdGhlIHdvcmsgcXVldWUgaW1wbGVtZW50
YXRpb24gaXQgbmVlZHMgdG8gYmUgZml4ZWQgbm90IHJldmVydGVkLg0KPiA+ID4+DQo+ID4gPj4g
SSBhbSBzdGlsbCBob3BpbmcgdGhhdCBzb21lb25lIHdpbGwgZGlhZ25vc2Ugd2hhdCBpcyBjYXVz
aW5nIHRoZSBVTFBzIHRvIGhhbmcgaW4gdGVybXMgb2YNCj4gPiA+PiBzb21ldGhpbmcgbWlzc2lu
ZyBjYXVzaW5nIGl0IHRvIHdhaXQuDQo+ID4gPg0KPiA+ID4gSGksIEJvYg0KPiA+ID4NCj4gPiA+
DQo+ID4gPiBZb3Ugc3VibWl0dGVkIHRoaXMgY29tbWl0IDliNGI3YzFmOWY1NCAoIlJETUEvcnhl
OiBBZGQgd29ya3F1ZXVlIHN1cHBvcnQgZm9yIHJ4ZSB0YXNrcyIpLg0KPiA+ID4NCj4gPiA+IFlv
dSBzaG91bGQgYmUgdmVyeSBmYW1pbGlhciB3aXRoIHRoaXMgY29tbWl0Lg0KPiA+ID4NCj4gPiA+
IEFuZCB0aGlzIGNvbW1pdCBjYXVzZXMgcmVncmVzc2lvbi4NCj4gPiA+DQo+ID4gPiBTbyB5b3Ug
c2hvdWxkIGRlbHZlZCBpbnRvIHRoZSBzb3VyY2UgY29kZSB0byBmaW5kIHRoZSByb290IGNhdXNl
LCB0aGVuIGZpeCBpdC4NCj4gPg0KPiA+IFpodSwNCj4gPg0KPiA+IEkgaGF2ZSBzcGVudCB0b25z
IG9mIHRpbWUgb3ZlciB0aGUgbW9udGhzIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoYXQgaXMgaGFw
cGVuaW5nIHdpdGggYmxrdGVzdHMuDQo+ID4gQXMgSSBoYXZlIG1lbnRpb25lZCBzZXZlcmFsIHRp
bWVzIEkgaGF2ZSBzZWVuIHRoZSBzYW1lIGV4YWN0IGZhaWx1cmUgaW4gc2l3IGluIHRoZSBwYXN0
IGFsdGhvdWdoDQo+ID4gY3VycmVudGx5IHRoYXQgZG9lc24ndCBzZWVtIHRvIGhhcHBlbiBzbyBJ
IGhhZCBiZWVuIHN1c3BlY3RpbmcgdGhhdCB0aGUgcHJvYmxlbSBtYXkgYmUgaW4gdGhlIFVMUC4N
Cj4gPiBUaGUgY2hhbGxlbmdlIGlzIHRoYXQgdGhlIGJsa3Rlc3RzIHJlcHJlc2VudHMgYSBodWdl
IHN0YWNrIG9mIHNvZnR3YXJlIG11Y2ggb2Ygd2hpY2ggSSBhbSBub3QNCj4gPiBmYW1pbGlhciB3
aXRoLiBUaGUgYnVnIGlzIGEgaGFuZyBpbiBsYXllcnMgYWJvdmUgdGhlIHJ4ZSBkcml2ZXIgYW5k
IHNvIGZhciBubyBvbmUgaGFzIGJlZW4gYWJsZSB0bw0KPiA+IHNheSB3aXRoIGFueSBzcGVjaWZp
Y2l0eSB0aGUgcnhlIGRyaXZlciBmYWlsZWQgdG8gZG8gc29tZXRoaW5nIG5lZWRlZCB0byBtYWtl
IHByb2dyZXNzIG9yIHZpb2xhdGVkDQo+ID4gZXhwZWN0ZWQgYmVoYXZpb3IuIFdpdGhvdXQgYW55
IGNsdWUgYXMgdG8gd2hlcmUgdG8gbG9vayBpdCBoYXMgYmVlbiBoYXJkIHRvIG1ha2UgcHJvZ3Jl
c3MuDQo+IA0KPiBCb2INCj4gDQo+IFdvcmsgcXVldWUgd2lsbCBzbGVlcC4gSWYgd29yayBxdWV1
ZSBzbGVlcCBmb3IgbG9uZyB0aW1lLCB0aGUgcGFja2V0cw0KPiB3aWxsIG5vdCBiZSBzZW50IHRv
IFVMUC4gVGhpcyBpcyB3aHkgdGhpcyBoYW5nIG9jY3Vycy4NCg0KSW4gZ2VuZXJhbCB3b3JrIHF1
ZXVlIGNhbiBzbGVlcCwgYnV0IHRoZSB3b3JrbG9hZCBydW5uaW5nIGluIHJ4ZSBkcml2ZXINCnNo
b3VsZCBub3Qgc2xlZXAgYmVjYXVzZSBpdCB3YXMgb3JpZ2luYWxseSBydW5uaW5nIG9uIHRhc2ts
ZXQgYW5kIGNvbnZlcnRlZA0KdG8gdXNlIHdvcmsgcXVldWUuIEEgdGFzayBjYW4gc29tZXRpbWUg
dGFrZSBsb25nZXIgYmVjYXVzZSBvZiBJUlFzLCBidXQNCnRoZSBzYW1lIHRoaW5nIGNhbiBhbHNv
IGhhcHBlbiB3aXRoIHRhc2tsZXQuIElmIHRoZXJlIGlzIGEgZGlmZmVyZW5jZSBiZXR3ZWVuDQp0
aGUgdHdvLCBJIHRoaW5rIGl0IHdvdWxkIGJlIHRoZSBvdmVyaGVhZCBvZiBzY2hlZHVyaW5nIHRo
ZSB3b3JrIHF1ZXVlLg0KDQo+IERpZmZpY3VsdCB0byBoYW5kbGUgdGhpcyBzbGVlcCBpbiB3b3Jr
IHF1ZXVlLiBJdCBoYWQgYmV0dGVyIHJldmVydA0KPiB0aGlzIGNvbW1pdCBpbiBSWEUuDQoNCkkg
YW0gb2JqZWN0ZWQgdG8gcmV2ZXJ0aW5nIHRoZSBjb21taXQgYXQgdGhpcyBzdGFnZS4gQXMgQm9i
IHdyb3RlIGFib3ZlLA0Kbm9ib2R5IGhhcyBmb3VuZCBhbnkgbG9naWNhbCBmYWlsdXJlIGluIHJ4
ZSBkcml2ZXIuIEl0IGlzIHF1aXRlIHBvc3NpYmxlDQp0aGF0IHRoZSBwYXRjaCBpcyBqdXN0IHJl
dmVhbGluZyBhIGxhdGVudCBidWcgaW4gdGhlIGhpZ2hlciBsYXllcnMuDQoNCj4gQmVjYXVzZSB3
b3JrIHF1ZXVlIHNsZWVwcywgIFVMUCBjYW4gbm90IHdhaXQgZm9yIGxvbmcgdGltZSBmb3IgdGhl
DQo+IHBhY2tldHMuIElmIHBhY2tldHMgY2FuIG5vdCByZWFjaCBVTFBzIGZvciBsb25nIHRpbWUs
IG1hbnkgcHJvYmxlbXMNCj4gd2lsbCBvY2N1ciB0byBVTFBzLg0KDQpJIHdvbmRlciB3aGVyZSBp
biB0aGUgcnhlIGRyaXZlciBkb2VzIGl0IHNsZWVwLiBCVFcsIG1vc3QgcGFja2V0cyBhcmUNCnBy
b2Nlc3NlZCBpbiBORVRfUlhfSVJRIGNvbnRleHQsIGFuZCB3b3JrIHF1ZXVlIGlzIHNjaGVkdWxl
ZCBvbmx5DQp3aGVuIHRoZXJlIGlzIGFscmVhZHkgYSBydW5uaW5nIGNvbnRleHQuIElmIHlvdXIg
c3BlY3VsYXRpb24gaXMgdG8gdGhlIHBvaW50LA0KdGhlIGhhbmcgd2lsbCBvY2N1ciBtb3JlIGZy
ZXF1ZW50bHkgaWYgd2UgY2hhbmdlIGl0IHRvIHVzZSB3b3JrIHF1ZXVlIGV4Y2x1c2l2ZWx5Lg0K
TXkgT0RQIHBhdGNoZXMgaW5jbHVkZSBhIGNoYW5nZSB0byBkbyB0aGlzLg0KQ2YuIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvNzY5OWE5MGJjNGFmMTBjMzNjMGE0NmVmNjMzMGVkNGJiN2U3
YWNlNi4xNjk0MTUzMjUxLmdpdC5tYXRzdWRhLWRhaXN1a2VAZnVqaXRzdS5jb20vDQoNClRoYW5r
cywNCkRhaXN1a2UNCg0KPiANCj4gPg0KPiA+IE15IG1haW4gbW90aXZhdGlvbiBpcyBtYWtpbmcg
THVzdHJlIHJ1biBvbiByeGUgYW5kIGl0IGRvZXMgYW5kIGl0J3MgZmFzdCBlbm91Z2ggdG8gbWVl
dCBvdXIgbmVlZHMuDQo+ID4gTHVzdHJlIGlzIHNpbWlsYXIgdG8gc3JwIGFzIGEgVUxQIGFuZCBp
biBhbGwgb2Ygb3VyIHRlc3Rpbmcgd2UgaGF2ZSBuZXZlciBzZWVuIGEgc2ltaWxhciBoYW5nLiBP
dGhlcg0KPiA+IGhhbmdzIHRvIGJlIHN1cmUgYnV0IG5vdCB0aGlzIG9uZS4gSSBiZWxpZXZlIHRo
YXQgdGhpcyBidWcgd2lsbCBuZXZlciBnZXQgcmVzb2x2ZWQgdW50aWwgc29tZW9uZSB3aXRoDQo+
ID4gYSBnb29kIHVuZGVyc3RhbmRpbmcgb2YgdGhlIHVscCBkcml2ZXJzIG1ha2VzIGFuIGVmZm9y
dCB0byBmaW5kIG91dCB3aGVyZSBhbmQgd2h5IHRoZSBoYW5nIGlzIG9jY3VycmluZy4NCj4gPiBG
cm9tIHRoZXJlIGl0IHNob3VsZCBiZSBzdHJhaWdodCBmb3J3YXJkIHRvIGZpeCB0aGUgcHJvYmxl
bS4gSSBhbSBjb250aW51aW5nIHRvIGludmVzdGlnYXRlIGFuZCBhbSBsZWFybmluZw0KPiA+IHRo
ZSBkZXZpY2UtbWFuYWdlci9tdWx0aXBhdGgvc3JwL3Njc2kgc3RhY2sgYnV0IEkgaGF2ZSBhIGxv
bmcgd2F5cyB0byBnby4NCj4gPg0KPiA+IEJvYg0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gSmFzb24gJiYgTGVvbiwgcGxlYXNlIGNvbW1lbnQgb24gdGhpcy4NCj4gPiA+DQo+ID4gPg0K
PiA+ID4gQmVzdCBSZWdhcmRzLA0KPiA+ID4NCj4gPiA+IFpodSBZYW5qdW4NCj4gPiA+DQo+ID4g
Pj4NCj4gPiA+PiBCb2INCj4gPg0K
