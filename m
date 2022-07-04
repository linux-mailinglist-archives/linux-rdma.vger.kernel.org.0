Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F08564D7E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 08:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiGDGBy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGDGBx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 02:01:53 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B46568
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656914511; x=1688450511;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=kI9q7/sKz7Z2MDn0uuTVbT8NX07rvCTgLpvc4XghnY4=;
  b=OnZuY2Izax2fvf9zLFmvULvdl2qnmK0WJSaX3+P8v3MwRNLGFSiuv2WH
   982qqIoA1FJhbxCVdDpS2zjVbiAeY9iDl5UzZjPCx/v3LR6q2bS0fqvS0
   i/vVutKhc9MKn7dExuQfsi1WyeBZIuQwJJStRpLZf0KU0Jw+z7a2JTOS0
   nwzciENIWVSKJ9PoscHzigShdVt91DEfK8/8MpcNsbTJXz+DbzwrqpoMB
   7Vaok1cYxrnWDSBsT8GPISkPcgWRfzOz3jYx7S4VCI9lYEALLS349vzFI
   ZLf4qAoxBxdeIaN5k8W/daKydEpPu4oYEIltHK16RqtuTj4i+1UgpWTSw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="59663599"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="59663599"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:01:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZxWmIqpVUOCHmgMGRfmSrMmC2XMCZsZ7xi016KRyTciv+lWevPcNERIgzOFatYjBSsfFbzpwPJsHbiwKAgmidrTrpc3gFjJbfczbHrmSVZ/5+CW/9qnq3rNMqwwCd9I58B73t2fCTwLvT3szOVtS22RjVt8YVxoLiWhsJzy5zvhl2v/gExAIq07BPDgjrsJQbzVC8+0Ub/MMU1kFwMKbdHrN0hAVOIVdQvjp0ygO0HT8HM9jyS0ODSspnJ8KPc9DeYu8BFxNQ7zZMyJCHihLyhdfoHbQA/7/mHy1ureAE1ZaaRzHhCmWCOexEf9RrCBPLoATKne76USk3xw7LomAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI9q7/sKz7Z2MDn0uuTVbT8NX07rvCTgLpvc4XghnY4=;
 b=FSHh0skrjOeIyYiVt2zWoiTg0BGldB5ytbrM8WCCE/goTs9TAqzHOCSuCXITGBiZEqjJ/veuwjOml95vF/qQq+LAjxg2cPDOE9mPqdC4bMuKZ4VqNLtk8Eo2d8gkJugNMLstCrRG8QhhfqLghdTcyO3oJ/W1kntV0h1UHQJrCdYlzsqEf5p6HSJ+SxlrVPqeBFwjbReKT6YAt7/nYzR2nwRjEIm7/yd6uOZ17Dmf6GMaWzZs/7NnqqdkfKz78wSGFVSfv7S/+aV+IL2pGMUGAsue9+fawb72w5fM0+cZvmqYMYnx3BaMnAmYgnSVtej58saF12WUny/viHJMyYI15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI9q7/sKz7Z2MDn0uuTVbT8NX07rvCTgLpvc4XghnY4=;
 b=W4+/owc03anFEL6GBJSuiSlyiC/81RKYaf7qE51LZqaf+49Q+a6I+TyOnBHdr7FHU8o5RrUePVSN8An5NC7yeZ1R7+WS0JiGRi/m0qJ9aMXdcA2HbFX5/Hi/L7+pJ/yy4/RUiCkJaVz9/TNOBFAUogU43bQJmmeqslf0vCciZTc=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY1PR01MB1753.jpnprd01.prod.outlook.com (2603:1096:403:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:01:45 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:01:45 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH v4 2/3] RDMA/rxe: Generate error completion for error
 requester QP state
Thread-Topic: [PATCH v4 2/3] RDMA/rxe: Generate error completion for error
 requester QP state
Thread-Index: AQHYjRE+iGnVIQD7sEOrlc16O1v8e61pJo6AgASWYYA=
Date:   Mon, 4 Jul 2022 06:01:44 +0000
Message-ID: <aadf1276-6a38-ee9d-0950-7c9a423a3a31@fujitsu.com>
References: <20220701061731.1582399-1-lizhijian@fujitsu.com>
 <20220701061731.1582399-3-lizhijian@fujitsu.com>
 <92e2fb9c-d0a0-79de-1788-7e15d3a5390f@linux.alibaba.com>
In-Reply-To: <92e2fb9c-d0a0-79de-1788-7e15d3a5390f@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b305a55-7b78-4c1c-a393-08da5d82acaa
x-ms-traffictypediagnostic: TY1PR01MB1753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7p8nitXjkX+KsHrmFLgOWMNPhiwdTRpqjUlte/i8Ex4glC27S+sQ6u3RqMZr4KIcGSxCCLybbeDeZ/bo9vI4VTuH40uy2to93HazztqdZxKgzKWb9rqPITVqZX0mbVE+hU/Gphb+c+DyfKmP0h06D+h+KCdCwBrSH1IHpbDlGyfpAYC10ymBKg605/TWwM/BnMr+YuvdI1RFGs6/rXEx26+jbcFkjdYTIXMqTd+qyXBHqdYfwvmgPpFf1yA5isV1ytoA6eKtgYVZMS5e634ZKyiObowFKK7J7ezjNB7l1OiIxTbIuZZ0w06mCTlcCOCEOJazhjJRIkycQLAvVNASEZ1r/7vnyA2RzXq/xNMl6jPTHp+R+6R9PTSEIGNUmnfqLWtktBS4c25aS6e8OSb6eR5b0nbwbA9MZDszNS9+dQuzrDQnWBliFN1szShNWj9FEaodjifZQy6q3pSOgFKIkNMEYAgdtRwG+vQH8/KaBY9PY1I3HoMKg1n446q/oTyV0VDI0fDlQXXGiEe6Rru/nwYd/Z5Kj+IVMJWdRaZ8rd70JW9f0w280TtJaMaZlx7WElGUF9av2TBfdCRJRoIjGUlDpqwDusYDf4LmztzrDJl39pSUklHXBDDQTqV3xelltBbooCSjWVOhQYqqsbrXqrtOXBg8qCO27hPcwIt6KO+salNCVBu12qWvCaZwIQvulXwJT+Vee8DD3D0Bzoe6LNiH7j2XimxvMcE9Txw4ILnQ+SX/j5biT7Q+a7qv4Ol4XmrHBRWNCIWje6gfrs0YdUzy3DUesqLJ8t4LRgZI8JQsEwYS9+z4WS/g/3akhV6vd54NJAdNAZ+nJHzNDc/Coqie/NkERt0VYGi8X3uUw1eH3GiQpZiV2o/OQKqBotW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(2616005)(186003)(38070700005)(38100700002)(64756008)(36756003)(71200400001)(8676002)(66446008)(316002)(31686004)(66476007)(66946007)(76116006)(110136005)(66556008)(83380400001)(85182001)(91956017)(53546011)(5660300002)(31696002)(6512007)(6506007)(478600001)(6486002)(8936002)(82960400001)(122000001)(86362001)(41300700001)(26005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ZManRqdXdNU0JiOUVtYnNUblVzQytoQWtOV0xoT2d3Tlo4Wm1hYkRZaUZp?=
 =?utf-8?B?VHdUa1hjV1pxWDErVTkxZ3dVL2l5N3MxbW5UYjlUbmJlR3hnOTFGbVV4b3Vw?=
 =?utf-8?B?WGdHYkdQbGpTang2dVdMNFNqMDNWaFRvRzJXUWZOQ0QxckgwdVJSTitZeE9z?=
 =?utf-8?B?Kzc5K2Q4MU9IMFYwUUhiU0Y4SWcwcEJ4UGxteGxnRWdHVXQyTkNOQURnQXBj?=
 =?utf-8?B?U3lmTU04RzhoUFp2L1E2cDk1VW1sd2s5a21aWXJMbUdOVTc4YldYL3ZtTXlS?=
 =?utf-8?B?UFdLdXZsZ21OMko1bVpHYU41Wm83VzRyT21MQjIySXdwRG8wT0pKNUJaZ2E4?=
 =?utf-8?B?OTVqMHZTcDBWcVRLSExVKy9mSEd2UjVsL1lORUJGdVRTRW0zVyt0bzdueGJl?=
 =?utf-8?B?c1AxRHhKeFZyNEI1TTFhTmYzWi9XSSsrdzViWkZBenoxcWZmZFNPYXZIQTlt?=
 =?utf-8?B?Z0JHTjhlT0VCY2FKZXppM0FlSW9DaWwxY3RHdTFla1J3UHh5bUpOQmdnMFgy?=
 =?utf-8?B?MzNBRFZ1Slk4SmZDb1ozQU01T2Iwamlnb2Y4dHIxU2tqM0hIelY1aU9wRTZP?=
 =?utf-8?B?MEFuYUk1NTlDQ21RS3RMZDFNZlczdUQ5K2VKbmpoMGpyOTgzVTFUdDNyMHZD?=
 =?utf-8?B?SE9uREp6MldEYjBvM0RpYkZCOGk4ZzhoZnpON1BEVHJ5aERwK1BEdFUvVHps?=
 =?utf-8?B?bEp5UDdXdG1PQ1h4RlFpazZucHF6QkRhaGJZVlQ5ZTVnVC9Rc1lWMCsvc1Zm?=
 =?utf-8?B?d0gyeS9UdGszU29xT0tmMHdaSUVkbmxiMlIza1lkMzRodVd4ZFpSTzBqakZi?=
 =?utf-8?B?Y1lwZ1RKUkkra2wzOUdoMUpVRTJCeGpNbGh3cWpieGY4ODFSbytVamhtVkNY?=
 =?utf-8?B?WFUxNGNMTTRNd09hTTFyRjVHcHVJTm9yYnBUN0VaNE51UzMwTmlRajF6S0lt?=
 =?utf-8?B?anF4cURtU0JQcnpFOGxiN1AwZnpHaTM5bkZLMjlFRXNSb3QvdzhXbEhXdnE3?=
 =?utf-8?B?WGYzMzd5Wmg2dVlkSzBqTGFrYmxOOG5tTGVYZTJORHJWZmVRUzNVTWhxNytX?=
 =?utf-8?B?eVliNklCK1dTVVdOSGVMZEVxZDRhT2xZQU1FVWxicnh6NCszRlhWR1JRNzlx?=
 =?utf-8?B?enFKSkQvcEJveDVBcGYwR09NZGdWV1pEZHI5V3ZrNHY4dXhSNnl5WHhHTUVJ?=
 =?utf-8?B?V200Q2trVGsxMkpDN3RjTXc0MGtjN3ZmdXk5eW0xWDlFb3Q0Y0Z5dExWZ3Ur?=
 =?utf-8?B?cDV6UkNhZXBPN1ZiVFUvMzRRc3RZaHR0SzFRdGV2d1EyV0lldmZyRzRqS05Q?=
 =?utf-8?B?SlFxZkJrYlF6WXdVWlFmVVFTWmF1RklTL2cvamtHdThUdjd2czBKNEEveVpG?=
 =?utf-8?B?aCszNTNGNkpKeGZkRUkyVWt4aVVXRWJEQ0ZWQU0va3ZFaitGZW5kcG12UTNs?=
 =?utf-8?B?TW5Pamt3VDA2MndZcjU4WUQ2L3NXME9UMDh3RVJxRmRFcHBtakptTURLUFdk?=
 =?utf-8?B?KzNhNjJmOE5ZWDdxc3J1NEszakhVTVpIaUdDZVZUOXhPMGh2ZjNrREpsZUha?=
 =?utf-8?B?SkREbDJoQnBRM0wzRnZhbEswZ2o2WXh2emxiZXFsQ1ROS3psSmZqOEhmcDNK?=
 =?utf-8?B?MzErWEVCTnJpNitaYU42NDdITHBJMmxFWFhFUlhoUnJnMyt0N2R2QTdaSzA1?=
 =?utf-8?B?ZU9NQzRueE5kblI3L29JeWU5TSthb0ZNYjhXeUtHRXhZQ2l3Z3hSOTR0Zks1?=
 =?utf-8?B?a3JQQ1huUkJ2ajl5VHdqUnAxbTUweWZPRHFhYVRzM0RUN0lWRDBucXFRRTF3?=
 =?utf-8?B?ZU05RWQ3aFpVamNvZmdNZkNzdW94QlZCdzFlUTA5cGZkUWlVWjBzRUwyNnRU?=
 =?utf-8?B?Q3FVS2NiSVFVYkt3WDRFR1oyOXlnaG1rdndSblNBTzd5M1Zyc3h1UnpSa0dK?=
 =?utf-8?B?NWtudDhMNGpqeDdSNTVqL0RHSjF3VzZURzlGb1ZNSkJ1TmhTTXB5UmdRa0Ur?=
 =?utf-8?B?bktmdFV1cHFHU3RJSGVERXhOSk45WHRUZVQyTDlDTFJHZUpjZVZIMmorc0tR?=
 =?utf-8?B?QmxldDdmUWdUS2dhNGJLeUU1MmtvZDNHb1hDclFaVk9hVXFZY0ZRYUpoT3BP?=
 =?utf-8?B?YlYrV0NYN2UvbEFGUUIyNS9CaHN1YnAvNy8yYU8yQjJvcVZNcXVYaFVjYXdN?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA1EC12957808479BD62C0BB13F6B22@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b305a55-7b78-4c1c-a393-08da5d82acaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:01:44.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdiMpjBUiSctIW6HHWnSgg2zahM8Zmwwy/2jn2ItxQopbuWFbDEEPQ2K/K1epH3yTCx0jMwe2VNN/uhEJS49NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAxLzA3LzIwMjIgMTU6NTgsIENoZW5nIFh1IHdyb3RlOg0KPg0KPg0KPiBPbiA3LzEv
MjIgMjoxMCBQTSwgbGl6aGlqaWFuQGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gQXMgcGVyIElCVEEg
c3BlY2lmaWNhdGlvbiwgYWxsIHN1YnNlcXVlbnQgV1FFcyB3aGlsZSBRUCBpcyBpbiBlcnJvcg0K
Pj4gc3RhdGUgc2hvdWxkIGJlIGNvbXBsZXRlZCB3aXRoIGEgZmx1c2ggZXJyb3IuDQo+Pg0KPj4g
SGVyZSB3ZSBjaGVjayBRUF9TVEFURV9FUlJPUiBhZnRlciByZXFfbmV4dF93cWUoKSBzbyB0aGF0
IHJ4ZV9jb21wbGV0ZXIoKQ0KPj4gaGFzIGNoYW5jZSB0byBiZSBjYWxsZWQgd2hlcmUgaXQgd2ls
bCBzZXQgQ1Egc3RhdGUgdG8gRkxVU0ggRVJST1IgYW5kIHRoZQ0KPj4gY29tcGxldGlvbiBjYW4g
YXNzb2NpYXRlIHdpdGggaXRzIFdRRS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IFY0OiBjaGVjayBRUCBFUlJPUiBi
ZWZvcmUgUVAgUkVTRVQgIyBCb2INCj4+IFYzOiB1bmxpa2VseSgpIG9wdGltaXphdGlvbiAjIENo
ZW5nIFh1IDxjaGVuZ3lvdUBsaW51eC5hbGliYWJhLmNvbT4NCj4+IMKgwqDCoMKgIHVwZGF0ZSBj
b21taXQgbG9nICMgSGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IC0t
LQ0KPj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCAxNSArKysrKysr
KysrKysrKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3JlcS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+IGluZGV4IDRm
ZmM0ZWJkNmUyOC4uN2ZkYzhlNmJmNzM4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3JlcS5jDQo+PiBAQCAtNjEwLDkgKzYxMCwyMiBAQCBpbnQgcnhlX3JlcXVlc3Rlcih2b2lk
ICphcmcpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdBSU47DQo+PiDCoCDCoCBu
ZXh0X3dxZToNCj4+IC3CoMKgwqAgaWYgKHVubGlrZWx5KCFxcC0+dmFsaWQgfHwgcXAtPnJlcS5z
dGF0ZSA9PSBRUF9TVEFURV9FUlJPUikpDQo+PiArwqDCoMKgIGlmICh1bmxpa2VseSghcXAtPnZh
bGlkKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGV4aXQ7DQo+PiDCoCArwqDCoMKgIGlm
ICh1bmxpa2VseShxcC0+cmVxLnN0YXRlID09IFFQX1NUQVRFX0VSUk9SKSkgew0KPj4gK8KgwqDC
oMKgwqDCoMKgIHdxZSA9IHJlcV9uZXh0X3dxZShxcCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KHdxZSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogR2VuZXJhdGUgYW4gZXJyb3IgY29tcGxldGlvbiBzbyB0aGF0IHVzZXIgc3Bh
Y2UNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyBhYmxlIHRvIHBvbGwgdGhpcyBj
b21wbGV0aW9uLg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBlcnI7DQo+PiArwqDCoMKgwqDCoMKgwqAgZWxzZSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGV4aXQ7DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH5+fg0KPiBJZiBJIHJlYWQgaXQgcmlnaHQs
IGEgc2luZ2xlIHN0YXRlbWVudCBzaG91bGQgbm90IHVzZSBwYXJlbnRoZXNlcy4NCg0KR29vZCBj
YXRjaCwgRml4ZWQgaXQgaW4gVjUNClRoYW5rcw0KDQoNCg0KPg0KPiBUaGFua3MsDQo+IENoZW5n
IFh1DQo+DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHFw
LT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfUkVTRVQpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cXAtPnJlcS53cWVfaW5kZXggPSBxdWV1ZV9nZXRfY29uc3VtZXIocSwNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFFVRVVFX1RZUEVfRlJPTV9D
TElFTlQpOw0K
