Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80707E6444
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 08:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjKIH1D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 02:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjKIH1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 02:27:02 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE8F271F;
        Wed,  8 Nov 2023 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699514820; x=1731050820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8fUOnMUynWrAFsCu4WpYhnCmxM8LAv7/E6FvI6571Gc=;
  b=EgL2950lq42IBz35tlwXjsKivb9cKlFnzpmZ5P1VvqQoWJ1SjtZ0nIzk
   QginB4ynrqlk6tu8naDwOMHMH7+NlOyaNhqOqYJsNq686SfttR65Cv8IT
   HQUz5+JHUlxF01Sxzadyy1bIU3dp19xOFsNbdy9T/Ot2Hz5QxG3BYRdCk
   P3vcYjP5sr3TyXjfpA/lwDFTt6wxwox14ol2Mj4Kdqy0t8GMU0m65RzT6
   DM98qgIsCNjWAjnlmYyBiUoHFKYMal1/B1gnvm2Ypz5IMYHZs8k/yVlVD
   Woe5RlgGa1ZaokaHctVghchw+/wowhUcUipKWEPuCAkwysKdAQ/CPDAij
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="102102304"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="102102304"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 16:26:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkEIcBbVxNbNgoh31rYy162J3s+urirveGcuRDXEMSH+eDP78VljNu+/7ix2Dbkh3u6aWGe2k9iflLf6gwrZak2+8GgSKG7w7jHK3asbA/CNd8YkHSgt+QuhUF4EoBktNZX+r2Rd3yCm61bzBs77h/5pgXQt718XOWWrK9YjJxLMwrGzJy5/3o+vd2BtsTg7aA/h5c7lSrcSQwqeWaW7kmbNxCtnA7sCsk/NF+ukhpzWIi9KA/uEC6inW7SXYFblgYHN/SA+sYIOPzH6ehIPf+oiSEJijdfm2bTz+lPQj+9kt2UbtTg4quaIvCCaX/zR1pFCIm+XEyv0H6ltbaKfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fUOnMUynWrAFsCu4WpYhnCmxM8LAv7/E6FvI6571Gc=;
 b=fsesu+OOZ6RsYg/PqXE8WgutFFFnRp+Wsro4JthgN80EsTFLmRubsw2KpvrHuRHcoZjOXsZ0SAoSDAeyM/RT44ZG9yWmjFiuV9+7XCKf2cxZYpZUcB1Ej88wZClhSz1LGwP8SAzYG549+f4/GvIjhjOpow8PhHAkJwEEfjCe2mD7Q/HQ9PFRIaGqv1+/nIgTIkV7u1CNULbABtwbhU6GBEsXddyyYV1FBBjCPEMCyaqxQXjVxrbafE7PzHb64Kn+5SPbePIHDy1bKBrQ0yBu0xntM3Kh2l7uieaMy4mARZP/LeaJxY6krhN8igDfe8AhPLuRma/QGllTpoFq7EOeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB11656.jpnprd01.prod.outlook.com (2603:1096:400:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 07:26:51 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::16d1:f1e:a08:dd5c]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::16d1:f1e:a08:dd5c%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 07:26:50 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Greg Sword <gregsword0@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Topic: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBojwMAgAQh+4CAAKUOgIAD9VmAgABRlgCAAALBgA==
Date:   Thu, 9 Nov 2023 07:26:50 +0000
Message-ID: <760a3da8-9494-4573-91a3-97f432fce484@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
 <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
 <c736ddff-8523-463a-aa9a-3c8542486d69@linux.dev>
 <037148c3-c15b-4859-9b82-8349fcb54d0a@fujitsu.com>
 <CAEz=LcvVEBgW3f4q=ucuhLwNvD0xcunKLw+fLWSFbp14SUVNyg@mail.gmail.com>
In-Reply-To: <CAEz=LcvVEBgW3f4q=ucuhLwNvD0xcunKLw+fLWSFbp14SUVNyg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB11656:EE_
x-ms-office365-filtering-correlation-id: 064da10e-e5f2-4ed1-7dd8-08dbe0f53d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tseYP6HPFpsboy8CRP+3mbAlAFJ2caIyd4CRc9HFZEOgPJUM6Yxuw6+MSbbRNrNxRhsBfaa7mg+DMoA3aDPH9Fh8q2yIQWqIDks9SzhMq+FL69amnIWyoT6Ci+v8PG6geHvQ3CANPdAJQwcIC1jCatcVWyRiS8iZBRkM414yrHJagEVwtr1NoXTY4/nJdXpGqvR7FJ04bTIwZOQQPLOW9LmihlHdw1HJbjsHUef2LNMRG5JklBXuwbDqgmpCeYLLQra0L7iIoLWNLw6dS7nCjExjlvUE629egtf7IT0FStVkSDwy33LWsfc1499RM0VD0GXiCbJQR3j8rX9Me5Vv8/antc/fD0sOuIcatsAi3gHJLxfcZ9bUdpi5mJJ6bsbg8XUrm1pPAZ7yXyc2t0YVvWDvH00hhRQvHrZT14aASJCq5S2CR3aNlX3ob8RFcyrky58rCdSvhRcWyqcbV+BKri2f3ieEnTz7WFQ3WZL/sJgY4XSU8akP7CL7+RRbKs7ERjc9UNTN0rSoHNcQp72Nu9EQW4dmqHllnJ+ccKqtSYaa6dRD01VsWiABGnB77AthVgnKqHukfaTKEJi7FsoR+kiq4nu9VTQCzzyXOWL0gSMw/dDbATU4YKvcKSehBlQO9aruazQFRIjBbk0gDqM9Wr72AMrKb91kRYc5FbcWBxoPgqWR5ragTLPtEJn1Rwtz5odd5qV8azp0Ob5pnMgP9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(1590799021)(451199024)(64100799003)(6512007)(1580799018)(82960400001)(83380400001)(2616005)(26005)(38070700009)(6486002)(966005)(478600001)(66446008)(31696002)(41300700001)(36756003)(8676002)(2906002)(8936002)(7416002)(5660300002)(4326008)(86362001)(85182001)(91956017)(66476007)(76116006)(66556008)(54906003)(66946007)(64756008)(6916009)(316002)(6506007)(53546011)(71200400001)(31686004)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBMbmZ6eXluL295WGRpeGh4eVRMem9yUmZ4UmhjNm9sSGhMQjV2UGtLaUpV?=
 =?utf-8?B?RVphUDAvVkdJY04zOVF2Y0lvMlFrZ040YndyR3ozTDArOExBTnM4NE9aZW9z?=
 =?utf-8?B?bCt4NXRPSEFFTGJNb3VIWDhpRC9ibUN3akNVaDhYTlJFZVlmbEdHaUg2bXRp?=
 =?utf-8?B?S2lVa0JyVWR2eU5QeGtZdVBFT0hTZ0lrQ0h3Zm1XZ3ZrUUJub3IzRGJDdXpt?=
 =?utf-8?B?R3NvcG1yTmVOYU9XMTR5WnVVb2I0TnV3eHd6QjZXSEVVSS9zVy94TS9YclFK?=
 =?utf-8?B?RmlsTGFuYUxMNy9IU3hqK01IZU5qS25tdS9GQkdSd2VZYXZHVXlGdUVFeEZY?=
 =?utf-8?B?SkgrMkhReGIrOEljc3FSSzFPL2JFZ25mWEVsbFR1U0gweGlFRFFiTFpPazF0?=
 =?utf-8?B?M1VISXlUcVBXa2tXTTVmYmgyaFZCdkg5Q1lLV2FFSVJKZ0dkb0FQdWEvaUxv?=
 =?utf-8?B?RW40MXhUVkFQSFNBUS83RlcwZXhORytVOXZQZk52WFp3VUdOUlk1eWJEK1Rm?=
 =?utf-8?B?TXRiMHhTQWMxZkYwT3pBU3BnQXZ1ckhQOWd2bTYrTlMwdjNwdy9oZXNlNDBI?=
 =?utf-8?B?U050SEREeVpuU1RtQnZnaTJpVlg0RVBtbTNkTkRjb3N4eWFmMlBJM0crQXZX?=
 =?utf-8?B?SVpPMk1Ka2tYUVcrY1JMd3RpV3hXb3M4VHR1ekRJanVMdUFVNElkdis1ZTl1?=
 =?utf-8?B?TGFaNmlLNUdkT1g1UVUyMFVsbGsrWFhjbjMvQ0Rzb3JUNU9ITmZFVjJFTnp3?=
 =?utf-8?B?REJyN2g1elVVckNaMHB2c3M5ejhyVzl3ZFdhMThNL05DR2w1RS8wdUJ3b0lk?=
 =?utf-8?B?cGVlUlhSMVN2Y1VralpETnkzRzM2cjdxRGkxYm43cG82aXlqd1JONG9KTFBN?=
 =?utf-8?B?R0N0R0FsLzk2U3BQVlBzbUlQSEVGdDFHM0xUZ3VHbnA4ZTcxZ1JMZmlNZWcr?=
 =?utf-8?B?UWJhZVpUckpMbTJ1UFV2QlUrbmh2T2pzeEpIK21iRWhDL3hwalpJZlJjL293?=
 =?utf-8?B?aEd2VU5CTm1oVUluWHQ1dGM2d1NWemRGNUFFcGlNekNJVlVyUkNkREUxZjMx?=
 =?utf-8?B?YXJtL0FHa1U4a0R6M0JOcUM4MXU0NHUzNXBZQ2JHVUdSamxwVDZiSDgzMG1U?=
 =?utf-8?B?V0diT1JoSDJqeWNjcWFYNDMyNnFpaHlEYUNpWFJzRFd4NDVlczBwWEFiMSs1?=
 =?utf-8?B?b2ZmdWp5OUtvNldoTTBDSms2NFFqQTI2YVhsdDE4a2J0M1JLbHJUWkJtMXh4?=
 =?utf-8?B?TU5vT1RrcGJWV1hwTjZCRyt5aHBqNHc1ODlpZk1wUXpBZmJzYmE4UDRxSytl?=
 =?utf-8?B?cWdHMDJ4OHhhTFBCdXFyM3I4Y2NlODZCRFhuK3J4bFBEbXhhOTFDdmF4RHZX?=
 =?utf-8?B?MmdtRFZuTVEzTXZsMjQvb2NaZHA2VGJ6U1pLZkROVVVqVC91MFNWOUwyM2ZF?=
 =?utf-8?B?cE5HVTJLSG02VlV0V2pvekdJMTgzeEVFWk04MUVUelVMVXNneE05Q2V5M1lK?=
 =?utf-8?B?RjFRK0VTeTBtSFFYT1pqbm9ST0d3Q3hvaG9MSVJZZFFaMjVWOWZUaDF3NmU3?=
 =?utf-8?B?KzVzTWtyNHVYZXRsODY3WVVzcVlUOTBaSUY4OEYrTWJyNzIwRFA0K29OMTRU?=
 =?utf-8?B?aWNJbEtLZmluNWQzNFRVdm40MkZ5ZWN0YXVUSjFKNUZzb1NiRWZOS2tPL2Zh?=
 =?utf-8?B?YTlObmVtS3Q5dnRMWEczZzRCc0FIVDlQaHZYZUU0OFRxakVEYXhVcUhZWkFJ?=
 =?utf-8?B?cEE0cUFEeUJTVG1VRk9YSE9WZTBlRUk4TCtqY1ZtRGNUbkpLUkVsdnVPMnlk?=
 =?utf-8?B?aHQzRUJ1Yjk0dDhWbGlGS25QMWRXYzZqQTVnb1JoNC9oNjJqL3pTL1F0Zm9N?=
 =?utf-8?B?ajk0WU4xQm9GTkNsanFTZVdMaG9xM0ZYYWxPdmdkZmMrdDdZYmpSVDB0NFcr?=
 =?utf-8?B?b2J6cXRja016ZVBOZU9GdUZkYTRpZFdMU2xGN1dsOTgycHhFOHNxLzJhVlIx?=
 =?utf-8?B?dTYvNGNDV0dpVDM4d204MGNscU9QU056eW9oNkN5Q0NXODgvamJXeW05aW5N?=
 =?utf-8?B?R244U2dyMmRxQ3JTUFU4OE5QZDlqekU5ZVlkbkVINi92NzkxSjVMOGhMdU1B?=
 =?utf-8?B?dVRvbTlXNG9mb200TWdUSXRYdlRGOVVMb05RN3B0dG1uNFVqUkFDMko5Unlp?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6E462A0E7C39479923CDB32286F813@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TkJQc1c4VjZhMTBrVDZkbEhvZjk3d05wOVZLNzM4TVQ2Q2k1Z29kalZJcWVP?=
 =?utf-8?B?MnJSUjU3WmZYVHZPeU1ETEFlN0ZzTDVRakQ4SVpaamp4TnF3UEltWkhhZ01p?=
 =?utf-8?B?c0Z1bEY1bHowam1XRDc2U3BxZkQrZmI4TWZwUkowY0Y0ajFUMmZNY2VpcFZO?=
 =?utf-8?B?ZkJFeGhDZ3dZcXk4VEFudjkzTU5KbVlRaE9qeTY2ZlFYZ3NyNjl1blF6MlVS?=
 =?utf-8?B?bmg5b3dWZ1JjTEljUGpTcGs2clZaT1kyeWRrTDRqK29DN1UrNlZsYW1BUG1m?=
 =?utf-8?B?dVl3YUVWaVVBcE1Jc093djUwRzdMY242eUNieGxVWVJYU3RaMi9GWTg0S2ZD?=
 =?utf-8?B?MmtleEFhNVgvZnUxYkdaODh3QzYwVnVySFBTcFVoSU5Rejc2NjdkczJpSzk3?=
 =?utf-8?B?a0NENHJETjR2ZTF4NG1vcmhqWDExWFZhUkllUjJYbU5obmVHdWdtbExCa0RG?=
 =?utf-8?B?aDF2TUUvU2NGWDY5YmNHQUg4UXFFSEJoZ3FzM1ZCRUlyQnpSQThDaU01ZTVJ?=
 =?utf-8?B?aTlkM1huZXU5cnJKcFpqQ0ZvOWdjeTd3ODZ5NkFObDBmdlJ0dzNTUHU3RFBZ?=
 =?utf-8?B?OWJlTVkveDNjN1hKVURSMTErS0lmYUoxZDN3YnVzR3ZyQlRnRThjNCswVmN2?=
 =?utf-8?B?RHF2YzlzVUZ2SDR0NVdQUUVYRFlVREU5ZFVCTlg2bWZ3alZSYktkd0Exci9n?=
 =?utf-8?B?MzlhVDJsZ0hVVk96VmVrZzlkUFo4UFozVjdwZy9KUGtTZ3F1K05kTE9RN1B2?=
 =?utf-8?B?NnZDK2JQL2d1dFlBVkIxSUxqa25FZE9peGVmOUZUQmcxOVgrTmlyOVlpSHNP?=
 =?utf-8?B?YWhVTUswNW5yVzFGRDRGd29YbGZTQzZMNXI3VGRvZjZKdXUzMVZlYTErUHdT?=
 =?utf-8?B?dTZvaHY4amRtSjYwVlNCeGJBVWcxaE1seU1ySDFyRnNnNyszeW5CejYrSVp3?=
 =?utf-8?B?bUR2R2Z6VGhiVGlqRlNyeVcvSTNRSks2RDdIU2M4dGZWbGJIN29hODZ1QnRq?=
 =?utf-8?B?WUNSbitocEloK2JrTmszVlJMNnFkY2pHcTc4Zml0bzUvekJRSS9Qa1VwQmtP?=
 =?utf-8?B?eVhIbkg2eXNlSkR1dDRpL3RLbFR3c0ZQaGtDVzF0L3FvQUZ4MGNuY1MybDB4?=
 =?utf-8?B?YzdGQlp4QXovQ3czZlBlNmppMGU1aUZsYm1lNGNIWnZTMXZSNkFLelpGYWdm?=
 =?utf-8?B?cCtxZENDMkNBb0o5TXNFaXJYZ2VFbFArR0MrOWFQTXRQODVESGdqTTk5cnUw?=
 =?utf-8?Q?BfT7aVEfIEaJjSo?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064da10e-e5f2-4ed1-7dd8-08dbe0f53d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 07:26:50.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IE+6D01E7E/3EDw3NYf794uE3N7AEH5sCtSqPTUTHajDMz/CgycbURQd7yNSYqLsbyRDk3yJfbTvWS0uAD50yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11656
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA5LzExLzIwMjMgMTU6MTYsIEdyZWcgU3dvcmQgd3JvdGU6DQo+IE9uIFRodSwgTm92
IDksIDIwMjMgYXQgMTA6MjXigK9BTSBaaGlqaWFuIExpIChGdWppdHN1KQ0KPiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDA2LzExLzIwMjMgMjE6NTgs
IFpodSBZYW5qdW4gd3JvdGU6DQo+Pj4g5ZyoIDIwMjMvMTEvNiAxMjowNywgWmhpamlhbiBMaSAo
RnVqaXRzdSkg5YaZ6YGTOg0KPj4+Pg0KPj4+Pg0KPj4+PiBPbiAwMy8xMS8yMDIzIDIxOjAwLCBa
aHUgWWFuanVuIHdyb3RlOg0KPj4+Pj4g5ZyoIDIwMjMvMTEvMyAxNzo1NSwgTGkgWmhpamlhbiDl
hpnpgZM6DQo+Pj4+Pj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZpZXdlZC1ieSB0byB0aGUgcGF0
Y2gxLTIgdGhpcyB0aW1lLCBzaW5jZSBpDQo+Pj4+Pj4gdGhpbmsgd2UgY2FuIG1ha2UgaXQgYmV0
dGVyLg0KPj4+Pj4+DQo+Pj4+Pj4gUGF0Y2gxLTI6IEZpeCBrZXJuZWwgcGFuaWNbMV0gYW5kIGJl
bmlmaXQgdG8gbWFrZSBzcnAgd29yayBhZ2Fpbi4NCj4+Pj4+PiAgICAgICAgICAgICAgQWxtb3N0
IG5vdGhpbmcgY2hhbmdlIGZyb20gVjEuDQo+Pj4+Pj4gUGF0Y2gzLTU6IGNsZWFudXBzICMgbmV3
bHkgYWRkDQo+Pj4+Pj4gUGF0Y2g2OiBtYWtlIFJYRSBzdXBwb3J0IFBBR0VfU0laRSBhbGlnbmVk
IG1yICMgbmV3bHkgYWRkLCBidXQgbm90IGZ1bGx5IHRlc3RlZA0KPj4+Pj4+DQo+Pj4+Pj4gTXkg
YmFkIGFybTY0IG1lY2hpbmUgb2ZmdGVuIGhhbmdzIHdoZW4gZG9pbmcgYmxrdGVzdHMgZXZlbiB0
aG91Z2ggaSB1c2UgdGhlDQo+Pj4+Pj4gZGVmYXVsdCBzaXcgZHJpdmVyLg0KPj4+Pj4+DQo+Pj4+
Pj4gLSBudm1lIGFuZCBVTFBzKHJ0cnMsIGlzZXIpIGFsd2F5cyByZWdpc3RlcnMgNEsgbXIgc3Rp
bGwgZG9uJ3Qgc3VwcG9ydGVkIHlldC4NCj4+Pj4+DQo+Pj4+PiBaaGlqaWFuDQo+Pj4+Pg0KPj4+
Pj4gUGxlYXNlIHJlYWQgY2FyZWZ1bGx5IHRoZSB3aG9sZSBkaXNjdXNzaW9uIGFib3V0IHRoaXMg
cHJvYmxlbS4gWW91IHdpbGwgZmluZCBhIGxvdCBvZiB2YWx1YWJsZSBzdWdnZXN0aW9ucywgZXNw
ZWNpYWxseSBzdWdnZXN0aW9ucyBmcm9tIEphc29uLg0KPj4+Pg0KPj4+PiBPa2F5LCBpIHdpbGwg
cmVhZCBpdCBhZ2Fpbi4gSWYgeW91IGNhbiB0ZWxsIG1lIHdoaWNoIHRocmVhZCwgdGhhdCB3b3Vs
ZCBiZSBiZXR0ZXIuDQo+Pj4+DQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4gICAgRnJvbSB0aGUgd2hvbGUg
ZGlzY3Vzc2lvbiwgaXQgc2VlbXMgdGhhdCB0aGUgcm9vdCBjYXVzZSBpcyB2ZXJ5IGNsZWFyLg0K
Pj4+Pj4gV2UgbmVlZCB0byBmaXggdGhpcyBwcm9sZW0uIFBsZWFzZSBkbyBub3Qgc2VuZCB0aGlz
IGtpbmQgb2YgY29tbWl0cyBhZ2Fpbi4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IExldCdzIHRoaW5rIGFi
b3V0IHdoYXQncyBvdXIgZ29hbCBmaXJzdC4NCj4+Pj4NCj4+Pj4gLSAxKSBGaXggdGhlIHBhbmlj
WzFdIGFuZCBvbmx5IHN1cHBvcnQgUEFHRV9TSVpFIE1SDQo+Pj4+IC0gMikgc3VwcG9ydCBQQUdF
X1NJWkUgYWxpZ25lZCBNUg0KPj4+PiAtIDMpIHN1cHBvcnQgYW55IHBhZ2Vfc2l6ZSBNUi4NCj4+
Pj4NCj4+Pj4gSSdtIHNvcnJ5IGknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgbGludXggTU0gc3Vi
c3lzdGVtLiBJdCBzZWVtIGl0J3Mgc2FmZS9jb3JyZWN0IHRvIGFjY2Vzcw0KPj4+PiBhZGRyZXNz
L21lbW9yeSBhY3Jvc3MgcGFnZXMgc3RhcnQgZnJvbSB0aGUgcmV0dXJuIG9mIGttYXBfbG9jYV9w
YWdlKHBhZ2UpLg0KPj4+PiBJbiBvdGhlciB3b3JkcywgMikgaXMgYWxyZWFkeSBuYXRpdmUgc3Vw
cG9ydGVkLCByaWdodD8NCj4+Pg0KPj4+IFllcy4gUGxlYXNlIHJlYWQgdGhlIGNvbW1lbnRzIGZy
b20gSmFzb24sIExlb24gYW5kIEJhcnQuIFRoZXkgc2hhcmVkIGEgbG90IG9mIGdvb2QgYWR2aWNl
Lg0KPj4NCj4+IEkgcmVhZCB0aGUgd2hvbGUgZGlzY3Vzc2lvbiBhZ2FpbiwgYnV0IEkgYmVsaWV2
ZWQgaSBzdGlsbCBtaXNzZWQgYSBsb3N0Lg0KPj4NCj4+DQo+Pj4gIEZyb20gdGhlbSwgd2UgY2Fu
IGtub3cgdGhlIHJvb3QgY2F1c2UgYW5kIGhvdyB0byBmaXggdGhpcyBwcm9ibGVtLg0KPj4NCj4+
IEkgZG9uJ3QgdGhpbmsgaSBtaXN1bmRlcnN0b29kIHRoZSByb290IGNhdXNlOg0KPj4gUlhFIHNw
bGl0cyBtZW1vcnkgaW50byBQQUdFX1NJWkUgdW5pdHMgaW4gdGhlIHhhcnJheS4gQXMgYSByZXN1
bHQsIHdoZW4gd2UgZXh0cmFjdCBhbiBhZGRyZXNzIGZyb20gdGhlIHhhcnJheSwNCj4+IHdlIHNo
b3VsZCBub3QgYWNjZXNzIGFkZHJlc3MgYmV5b25kIGEgUEFHRV9TSVpFIHdpbmRvdy4NCj4+DQo+
PiBJSVVDLCB0aGVuIGhvdyB0byBmaXggaXQ/DQo+PiAtIEknbSBub3QgZ29pbmcgdG8gInJlbW92
aW5nIHBhZ2Vfc2l6ZSBzZXQiLCBpdCdzIG91dCBvZiB0aGlzIHBhdGNoIHNjb3BlLg0KPj4gICAg
IEZlZWwgZnJlZSB0byBkbyB0aGUgY2xlYW51cCBzZXBhcmF0ZWx5Lg0KPj4gLSBJJ20gbm90IGdv
aW5nIHRvIGZpeCB0aGUgTlZNZS9ydHJzIGV0YyBwcm9ibGVtcyBpbiB0aGlzIHBhdGNoIHNldCB3
aGVuIDY0SyBwYWdlIGlzIGVuYWJsZWQuDQo+PiAgICAgQnV0IFJYRSB3aWxsIHRlbGwgaXRzIGNh
bGxlcnMgZXhwbGljaXRseSAiUlhFIGRvbid0IGRvbid0IHN1cHBvcnQgc3VjaCBwYWdlX3NpemUi
DQo+PiAtIEkgZGlkbid0IHN0YXRlIFJYRSBzdXBwb3J0cyBQQUdFX1NJWkUgYWxpZ25lZCBwYWdl
X3NpemUgTVIgYmVmb3JlIHJlZmFjdG9yaW5nIHJ4ZV9tYXBfbXJfc2coKSwNCj4+ICAgICBiZWNh
dXNlIEkgd29ycnkgYWJvdXQgaXQgd2FzIG5vdCBjb3JyZWN0IHRvIGFjY2VzcyBhZGRyZXNzIGJl
eW9uZCB0aGUgUEFHRV9TSVpFIHdpbmRvdy4NCj4+DQo+PiBXaGF0IEkgc2hvdWxkIGRvIG5leHQ/
DQo+PiBKdXN0IHN0YXRlICJSWEUgc3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBNUiIgPyBUaGVu
IHBhdGNoZXMgYmVjb21lDQo+PiBSRE1BL3J4ZTogUkRNQS9yeGU6IGRvbid0IGFsbG93IHJlZ2lz
dGVyaW5nICFQQUdFX1NJWkUgYWxpZ25lZCBNUg0KPj4gUkRNQS9yeGU6IHNldCBSWEVfUEFHRV9T
SVpFX0NBUCB0byBzdGFydGluZyBmcm9tIFBBR0VfU0laRQ0KPj4NCj4gDQo+IFdoYXQgZG8geW91
IHRha2UgcmRtYSBtYWlsbGlzdCBmb3I/IFlvdXIgYnVnemlsbGEsIGppcmE/IG9yIHlvdXIgZGV2
DQo+IHByb2dyYW0gbGF1bmNoPyBPciB5b3VyIHBsYXkgZ3JvdW5kPw0KDQpNYXkgaSBrbm93IHdo
aWNoIGJ1ZyB5b3UgYXJlIGNvbmNlcm5pbmcuIEFjdHVhbGx5IGkgYWx3YXlzIGNhbm5vdCBnZXQg
eW91ciBwb2ludC4NCg0KDQoNCg0KDQo+IA0KPj4gT3IganVzdCBrZWVwIHdlIGhhdmUgZG9uZSBp
biB0aGUgVjENCj4+DQo+PiBUaGFua3MNCj4+DQo+Pg0KPj4+DQo+Pj4gR29vZCBMdWNrLg0KPj4+
DQo+Pj4gWmh1IFlhbmp1bg0KPj4+DQo+Pj4+DQo+Pj4+IEkgZ2V0IHRvdGFsbHkgY29uZnVzZWQg
bm93Lg0KPj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+Pj4gWmh1IFlhbmp1bg0KPj4+Pj4NCj4+Pj4+Pg0K
Pj4+Pj4+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FIajRjczlYUnFFMjVqeVZ3
OXJqOVl1Z2ZmTG41K2Y9MXpuYUJFbnUxdXNMT2NpRCtnQG1haWwuZ21haWwuY29tL1QvDQo+Pj4+
Pj4NCj4+Pj4+PiBMaSBaaGlqaWFuICg2KToNCj4+Pj4+PiAgICAgIFJETUEvcnhlOiBSRE1BL3J4
ZTogZG9uJ3QgYWxsb3cgcmVnaXN0ZXJpbmcgIVBBR0VfU0laRSBtcg0KPj4+Pj4+ICAgICAgUkRN
QS9yeGU6IHNldCBSWEVfUEFHRV9TSVpFX0NBUCB0byBQQUdFX1NJWkUNCj4+Pj4+PiAgICAgIFJE
TUEvcnhlOiByZW1vdmUgdW51c2VkIHJ4ZV9tci5wYWdlX3NoaWZ0DQo+Pj4+Pj4gICAgICBSRE1B
L3J4ZTogVXNlIFBBR0VfU0laRSBhbmQgUEFHRV9TSElGVCB0byBleHRyYWN0IGFkZHJlc3MgZnJv
bQ0KPj4+Pj4+ICAgICAgICBwYWdlX2xpc3QNCj4+Pj4+PiAgICAgIFJETUEvcnhlOiBjbGVhbnVw
IHJ4ZV9tci57cGFnZV9zaXplLHBhZ2Vfc2hpZnR9DQo+Pj4+Pj4gICAgICBSRE1BL3J4ZTogU3Vw
cG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBNUg0KPj4+Pj4+DQo+Pj4+Pj4gICAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgICAgfCA4MCArKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4+Pj4+PiAgICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCB8ICAy
ICstDQo+Pj4+Pj4gICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggfCAg
OSAtLS0NCj4+Pj4+PiAgICAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCA0MyBk
ZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+
