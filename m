Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6617E193D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 04:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjKFDrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Nov 2023 22:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDrH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Nov 2023 22:47:07 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96449B7;
        Sun,  5 Nov 2023 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699242424; x=1730778424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XDvk1dCGm7Iw+MidqV1ot2fgLj54zH9Y6+KFREjAcxI=;
  b=YLc1RwXD64jVqGYlO5s4/JWcDU8i8/HEO0gz5k3iEBUXlZTvfA85rGDp
   /o7VGkaZxNCI6QP0hZB/ipqatLU9RP7G4kejvAzVOfXUdNJQIZ1iSFBsD
   3jBZeiX65jECN9FB2QuMMy+W5mLdhQAP1k3t1ckI/Ai3otdXNk4V+GtCp
   1aQWxpoe5JqXJJbCOOF/CnV1juC76DdEAVDasJTHPH/hMyi82c/Dc46rW
   TakaIdcC6qjrbS3QUGGOzTO41TDoIm0maE0JgSk9y8TwOw+BsSd/9jGR3
   pUCCxmM6KWDbpxePSg1jdOoxRjis8SV96G58TzpeoRUfpZxqm7KSoZstA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="12464079"
X-IronPort-AV: E=Sophos;i="6.03,280,1694703600"; 
   d="scan'208";a="12464079"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:46:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDoq3TpSw/4s2/vXIy9Iz1M40jAPlWsbXjRfitEizDCFz1FskcueUjRggT3F4YZT5wskO7Po0oQHreWWhI0/74HLGTYWuIBo+0k4AD/mpr6iv7OMdvsrmWndVB6L9xfJpThGuTM9Qi48PhnW+3xg1pLVPmp/c9MdUtQsJ8EdxvU0UOe8/fKl3OY6I7+MZqsC6p2TWfdKGTCbW8c1fP3O9dJMCyHSOfffCutk74BHYIe+AI6Kj6cZMoU4h0+oQIt9Nyih/tbALRSB/1F5Pb45qw/ZayArynm9YGgzmHz+SFNrRHmKsFq6+J2gbE4pvuSs1Biu6+JwdfmYHPtEw1ISSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDvk1dCGm7Iw+MidqV1ot2fgLj54zH9Y6+KFREjAcxI=;
 b=HrqvWlSDdsH5Qay9DIiFdMQeYcF49jPXKxulckxEjc6mA6gEoF0BQqCVAPDAcZpfs7M3IqryOTHw7+cZLqVnv2lMs/z6a4JHU4l8tztBnvRGxfXMrWgPSHNZGi5gTdT/1th+c5uMk6SUDUJX8OmdRusqtKFQaVcAvF5elavN+mOQn+AV5uly9VQh28e0xTCE8vbkVdX97TwShwYpqhYn0cy2oSocID8o8e8yVXqcMyvB9a+UVhmJjkgSMKeFbp7C2T3ndIPDZevO10+jWUdSMThaGICWsvV/3uGX8PGKU8kpbo8pm1gUOVGSJ9S5nwxBALYorkzpUijx29f9jOIp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB9438.jpnprd01.prod.outlook.com (2603:1096:400:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 03:46:56 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 03:46:56 +0000
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
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBoYXqAgARJ0gA=
Date:   Mon, 6 Nov 2023 03:46:56 +0000
Message-ID: <725846c4-7bf6-4525-a179-91bf9b4a6d92@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <CAEz=LcvrztPxSZj5uiaDe-mdC0qD4km07d8aFuVPOb5dgnHNug@mail.gmail.com>
In-Reply-To: <CAEz=LcvrztPxSZj5uiaDe-mdC0qD4km07d8aFuVPOb5dgnHNug@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB9438:EE_
x-ms-office365-filtering-correlation-id: cef3b267-c78f-4d2d-e7c7-08dbde7b05c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 13O3opjoMtvx0RG+S7wf3KftEFPk/TC0USPYltCZ+B/eT8WWpqqzdaCTe6xQuZ96p2918d9hjekVu9dPBb0AX8YmpzV4Sr4NlfXW4mbCJHiV0sQzINttogkFsAGrXgDDg/RMVlPH1XG2R14lNp8JXzHCgW7fIuRGukzmRiHRhAB2sEBrwmqdKAKwBPRAkGdndYr3kBL4SNhrhDPSZWPSJ/aJMLaDU6fxOpigYtVOKqNhMtwA36tFgC9QWliuAdL2dJvKPcFBd+Y8UF3UBiuFB/ef1JfT2yjcoriesIdFmnhpEpANwXx6FecdhlAdcMA9oNaiPzuXS1RKM0znYoWFp0It5UJIUveyJ/pHw9FAPxz655QddGi8mP2suCYE4zFVsvGOz2s746hNuCbcdglzgKVmSk5VFI79k803ptsUxaFp5AirD2Xc2WzvAiyCNOZgkBxEVPdnmJxEogETlPc3GOVdOQp49Kv4s3EeL6jQMiPgzQHCS9cM/7vbrzIMV78PQ6BjZ5lZriHym3lM2DX+qkK+/38YAhJyPZO3qzcwt5GVeA0qTfopOd6749eV7cXHOpqSmMg4vVXwHExPCX+1KX/ijELhRzS+B45uTzrpP7BMd2DxGuiK+PNo+4zFd3NWLv/zD+WYVC4B6zphKG/4BLtPDeulHp5R/da00/3EUHcDNPmozxLTWeyzmgLxQQQPWWUeAV7iVOf/BY2dHLW8hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(64100799003)(83380400001)(53546011)(6512007)(1580799018)(82960400001)(71200400001)(26005)(2616005)(6506007)(66899024)(122000001)(66946007)(316002)(478600001)(6916009)(66446008)(64756008)(66556008)(66476007)(54906003)(91956017)(76116006)(4326008)(8676002)(8936002)(36756003)(38100700002)(85182001)(2906002)(41300700001)(86362001)(5660300002)(31696002)(31686004)(6486002)(966005)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhsQjFXa3hqU2l1WEhOcWlJSVgzSmgrc2lpaVZvVlBJWkFldU9zUlAyYytF?=
 =?utf-8?B?eFlFaWE4UFJlOXpPWFRmV3RZeUgxQzdkbkZVRllGemplYXE0dXBjTzd6V2xN?=
 =?utf-8?B?eGdBZVdLQVVKUzgvY0wwenlXc3pIdXcwOUhrYVRCOFBhelVpcVExZDRWYzZ6?=
 =?utf-8?B?L1l4bExtdWxYZitXb0xHYXU2SzhHejh0d0sydHpUdDFCM3J2N3R2aHBSWEc2?=
 =?utf-8?B?N1ovMWpPeCt1cDJJZHJQZjVFRkhvUml0bzFuN3VRTDZNY3MxdU44LythaW5Y?=
 =?utf-8?B?N3JaSFhNTmVDQVROYW90T0JFSFVPK1VWQ2M4bzQ2NlpOYUp1UCszNUVrUXYw?=
 =?utf-8?B?RjNad1ZqMjJxanZiTk9YMjBEV1RxRTBULyt2UnBYUzAwZHRUOGlTNm4zcWFJ?=
 =?utf-8?B?TVlxNFg1MExPOWVEd1Z2VzRpc21uK2pnczlNS3FzVUk2azc2eVR3UWJEMHRG?=
 =?utf-8?B?cGRMMDZvWTNzV3ZHQVNzSHRtSlJaem9rMWlPU3lUZmQwNFM5dFRoaGlrdXVt?=
 =?utf-8?B?d0hOc21YY1Q4ZDNuQURJS0JwbHZrcXpsenJ2VEF3T1Q4MnorZGlJNmdOeUlM?=
 =?utf-8?B?R1J2NFk5b2x5YWV6ZlZRd0wwNFhKUmZSeUNRbDVqMXJoS05UVGN0SG9ERW9J?=
 =?utf-8?B?NEVaZ0dIZHJKV2RKUXdwMC9tLzlZTVFickVaSmFBcXpEbkdsYzdQTkswNTVC?=
 =?utf-8?B?NHZsemZHb2ppNndjNmdYdlpURUJpQWlKTURtcTczTlVFd1lIODFxMWx1cVpT?=
 =?utf-8?B?em5hdkxuTEtYV3FqenpOVjZ1Q3pQcURtOStwdk9Zc2xWeVdNS2Vnd0tUODln?=
 =?utf-8?B?T2RqYVA2UFBnUy9uUWpRVXh2ZjFrc1E5WitGRmlhS1lqOHlWcGd2dnZ3ZGg3?=
 =?utf-8?B?VmlvQS9iZGtBT1MxTTVaWmVhb3dVc3cxbWdBSjkrUlk3c2VRYXBZM016K0xU?=
 =?utf-8?B?ZzlJV1FqTWtSS05Teld5TFQ0V1ZFczRVQUo3RGdKWHBOYzU2UFFEYkpVcnpi?=
 =?utf-8?B?cCtvdklTNzc1VzJzakpBVGN6ME4vY2FRd1lzZGp1aTFSL2ZNSXU0NUNJMjBz?=
 =?utf-8?B?WXFZbmgvdWJEQi9QM1c4VkhUTHZWc0JHWkl6c2lsUUJwNmpyWFJkWC9LMGtP?=
 =?utf-8?B?allaZjBPakhhRzlkQ0piU08yZGxLc3ZpZ2lxQ0kycG0zQWEvTXBTTGhIaTJQ?=
 =?utf-8?B?d1hsaDlxQmVJaFlINXdaMmlWbFNLU1N6SHRCQ2x5TTNWTjh6dEFDWUpxcytM?=
 =?utf-8?B?MHpwU0llVGV5cHI5L3dEY2JydmJocXYvaTMzMzZ5OGVqeDZ1RGRFT3hUeXZ6?=
 =?utf-8?B?NVRreUU1TFlJWk9JTkRiZXdBY3RJQUtNZWpLQURwMFR1VWxHcTY4VXBXdTNo?=
 =?utf-8?B?d1lsTE8wdHVSMWQ2SjRIMUV6NkVlZVZaRzFhNzZYbk9MbVlHNHNJVy9DcXRI?=
 =?utf-8?B?dk5hZGFObDNwUUE2SERya0V5ZFlYZGZkQTNsS1JrRlJLZzNRUTZwV1h5Y1Q5?=
 =?utf-8?B?eFdNNkpmTzdTLy9Ka3hGWTZ5WjM0eDA0SW8zT0JCQU1DYVVtaGhsVnV2T01Q?=
 =?utf-8?B?RHBCRm1JWDM4REYwZERUT2FxREdLeEp4a0xHaXlvZ051akFMS05QOTlOdURy?=
 =?utf-8?B?c0lNMldCbkIrcmJLeFVVbzFIYkZFS3VHUk83N3dUcUNha3dnRzBEK0lqNys3?=
 =?utf-8?B?SGJyZTA1QWRqNkVHMWxzbTdETkdSZkJHem13eExnWnRpeGttYldaWVg1U2Rq?=
 =?utf-8?B?UElwMXNNTGJvQ1o3eEVTSFQxbXNza1pjMHgxZERTNUdjb0V4VllkNGQvdFJJ?=
 =?utf-8?B?RSs1Uk1keHQ1clNiN2NzRVl5STlmMFBvUHJZTjMvRE1kVFpHRDRsZTRVY3Qr?=
 =?utf-8?B?VHo2QmlieEkzMTdtekxoTGpMVElydys0M3ByRWRLYlFleHgzR3N6bVJaaHY0?=
 =?utf-8?B?cGwrL0NUN0FzM1U2NkJYeTVTcUNqUTdjRWNPSmhrWlA2Vnk1RGJGVXJGVy9J?=
 =?utf-8?B?KzZhU01iYzVCeTVzYTlDaDBJWWl5a0dYUWw1Tnp0ZExGMWRBS2R5YWxDallm?=
 =?utf-8?B?SzNMWnV1U25TNWVKZDJ0OWdtcFhnMmovU0RLcjJwRUtkV3ROeU5rbjhuclNs?=
 =?utf-8?B?Qy9FaGFWTzY4b3pUVE5GREF3RlFKMkxqQkZhYW9DVU04aGpXdnpYUlhxY1F0?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2C0F4919246F1439B00E04BF8A90AC2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u3YUI5kqclI139d1dxzbakrXzFhp0GxG7Tl8Al6Y0iTlJxUJZygncKR7rRYe7CkXt9+L0xEYSqZETr5HeCJGTSSvvKftAwJQ6t2dV4q+e/dYO6KpT0l3ek5il+TcdOCxS0f2Vb5xuDnITgm0rPyswKfj70yqkU8JviteV4O/0sZVffJEV3MgMSsc66C4/4v3TkUSyRzbnW/KnjiKY28jX4wszkOYh38eG4xfO5DR9BeTdmfub9cT9Uc+bGJU0XHq9iE6XIzBjM879E/ojP+QVnybvUKwgViT4K4OCE3uIT8B/5IuKMCxQCvrew5u8OQuJsSaTJQeEb/ukcp5yV3NbdYtfO2Dpg7GTqKw+M3x3TAgCHUuLnhdcXaQD0B2A3NCiOUO6iqjB4/ulLZrbAlUOxWkjF6cjnLSAwCZ+6JKsEiYHNvQgLTE1O0HaSXZCoybxWRkBo5/FtwK/CdWuyLC3i/Sdj9fyNEfacJwrTZTZHWXiK9F8AyxsKL6E2jEqLU6yxYyJDWlpHRMFdHuPpzi6BdTvOQ5LACKmvxGF8MzHD+AhTQPl8dmtIxlRdrVp2m8g1JVV4zYNxT4sqVkfCzO9+3luZXlj78Rf6DITWEYxF1jzU1zkI+BfNpGMSCDlqxqxAbbqqcjh0p/mpypRiR6WByfbnNuPTKVWX6PsU7TbxItKUTdENotFsFmCvTnsL+80UM/35fNwuZyRvBBJQOTrJJ+cWfgLRU8pmIPdY/+gNHjFt/fqOh+T7HGx7HCth0xFQHZ1xKd+oEvyr8mC653tPCk160+DNXCJTj7HthTKlhBEB897Do1+/VGuSos7+edsGZBsWX8fxlcqYPGfr1Tq6NuHDUy8xBXEAmuJ3HSlaUpZcrWIVV43HoeGT0DNsITZRzXIV0gOICDtvKD1ZoU1w==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef3b267-c78f-4d2d-e7c7-08dbde7b05c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 03:46:56.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErHnbWVYlYHnIwtZ0YF6kVxpZqNI3TyZ0u4lZAQVfHL0jxw0uP3pDCTUY8lcOyBfdIA/bfDujcZKvEY704WzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9438
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAzLzExLzIwMjMgMTg6MTcsIEdyZWcgU3dvcmQgd3JvdGU6DQo+IE9uIEZyaSwgTm92
IDMsIDIwMjMgYXQgNTo1OOKAr1BNIExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4g
d3JvdGU6DQo+Pg0KPj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZpZXdlZC1ieSB0byB0aGUgcGF0
Y2gxLTIgdGhpcyB0aW1lLCBzaW5jZSBpDQo+PiB0aGluayB3ZSBjYW4gbWFrZSBpdCBiZXR0ZXIu
DQo+Pg0KPj4gUGF0Y2gxLTI6IEZpeCBrZXJuZWwgcGFuaWNbMV0gYW5kIGJlbmlmaXQgdG8gbWFr
ZSBzcnAgd29yayBhZ2Fpbi4NCj4+ICAgICAgICAgICAgQWxtb3N0IG5vdGhpbmcgY2hhbmdlIGZy
b20gVjEuDQo+PiBQYXRjaDMtNTogY2xlYW51cHMgIyBuZXdseSBhZGQNCj4+IFBhdGNoNjogbWFr
ZSBSWEUgc3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBtciAjIG5ld2x5IGFkZCwgYnV0IG5vdCBm
dWxseSB0ZXN0ZWQNCj4gDQo+IERvIHNvbWUgd29yay4gRG8gbm90IHVzZSB0aGVzZSBydWJiaXNo
IHBhdGNoIHRvIHdhc3RlIG91ciB0aW1lLg0KDQpTbyBzb3JyeSBhYm91dCB0aGlzLiBPZiBjb3Vy
c2UsIGFueSBvdGhlciBwcm9wb3NhbHMgYXJlIHdlbGNvbWVkLg0KDQoNCg0KDQo+IA0KPj4NCj4+
IE15IGJhZCBhcm02NCBtZWNoaW5lIG9mZnRlbiBoYW5ncyB3aGVuIGRvaW5nIGJsa3Rlc3RzIGV2
ZW4gdGhvdWdoIGkgdXNlIHRoZQ0KPj4gZGVmYXVsdCBzaXcgZHJpdmVyLg0KPj4NCj4+IC0gbnZt
ZSBhbmQgVUxQcyhydHJzLCBpc2VyKSBhbHdheXMgcmVnaXN0ZXJzIDRLIG1yIHN0aWxsIGRvbid0
IHN1cHBvcnRlZCB5ZXQuDQo+Pg0KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9D
QUhqNGNzOVhScUUyNWp5Vnc5cmo5WXVnZmZMbjUrZj0xem5hQkVudTF1c0xPY2lEK2dAbWFpbC5n
bWFpbC5jb20vVC8NCj4+DQo+PiBMaSBaaGlqaWFuICg2KToNCj4+ICAgIFJETUEvcnhlOiBSRE1B
L3J4ZTogZG9uJ3QgYWxsb3cgcmVnaXN0ZXJpbmcgIVBBR0VfU0laRSBtcg0KPj4gICAgUkRNQS9y
eGU6IHNldCBSWEVfUEFHRV9TSVpFX0NBUCB0byBQQUdFX1NJWkUNCj4+ICAgIFJETUEvcnhlOiBy
ZW1vdmUgdW51c2VkIHJ4ZV9tci5wYWdlX3NoaWZ0DQo+PiAgICBSRE1BL3J4ZTogVXNlIFBBR0Vf
U0laRSBhbmQgUEFHRV9TSElGVCB0byBleHRyYWN0IGFkZHJlc3MgZnJvbQ0KPj4gICAgICBwYWdl
X2xpc3QNCj4+ICAgIFJETUEvcnhlOiBjbGVhbnVwIHJ4ZV9tci57cGFnZV9zaXplLHBhZ2Vfc2hp
ZnR9DQo+PiAgICBSRE1BL3J4ZTogU3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBNUg0KPj4NCj4+
ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyAgICB8IDgwICsrKysrKysrKysr
KysrKystLS0tLS0tLS0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJh
bS5oIHwgIDIgKy0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuaCB8
ICA5IC0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDQzIGRlbGV0
aW9ucygtKQ0KPj4NCj4+IC0tDQo+PiAyLjQxLjANCj4+
