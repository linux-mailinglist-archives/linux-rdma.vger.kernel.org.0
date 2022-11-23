Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388D635020
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 07:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiKWGNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Nov 2022 01:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiKWGNU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Nov 2022 01:13:20 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B541E0C9F
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 22:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669183999; x=1700719999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a4I4bev5LNsO4dLMW/IyJu+CtH0Rr8RrzWtqIpHx7LA=;
  b=m2FCKb9NLan//lEwsJDiRMVoq8dROlMqqQ2Un6KO4bx2sAvekbnoD0DV
   iLKx/xfg8cczGF8w73SX2/558Et3S4xKnnY3DCN+2MInbdbamrtMLBoco
   pTqE3rooDuRH6DAzIykX2CPihYu+ccp/Ow49uDObIej+OZ/jQiiFdY6VC
   g6Hl8udJJ4Aq53gwhkqxEZ06yKkLKqUnR1F+Nzx8pLVVsHugAHQJUgLcW
   Dmvjl4D6QTd7qUDuO3dSoqSAn4+Oy5F3HmDbv9H5Gli8m1wR5gtO+Srba
   QWbubLuRJ2MBL4t9oTxhqWt8iiHVckIH+Jc//VQU3dZn9Hkrw+sdwLdHY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="78966820"
X-IronPort-AV: E=Sophos;i="5.96,186,1665414000"; 
   d="scan'208";a="78966820"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 15:12:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6IJykPkkQosQqYTiajcjW5WGOIdpA8WU8mzW7D0xgDYtKOQII7Xtu9+FWTTpwddqDrBkdtd3rlauyhkARleRgkkFvj5cw+PnThqJm76XyhdGD24augnqypMAoN+Nk9YsxFvBklYagHd0DQhIBynmV68/7h8l+avYH7Nh8JcfmvjveC6i0slRgPhrTrvSy4CAP5VJrbb5PACA4/ZveygYIGXXSi6bkfVAjgg5i3HPmjYh7LlFipNYipFmT3qqB30cfuLRXks24/bK7cVHbMBlbG/DY8QPhb8Dbf+426GPJxwLZJxnRHaNAxmUtCis03iOfdzc4zRu5esOEJAgazXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4I4bev5LNsO4dLMW/IyJu+CtH0Rr8RrzWtqIpHx7LA=;
 b=jsouJCnUutdI2oTan8+JIIFllUNb4lBJREpyc291ZbuENIZWu6/SNLDHVAe2OJT1EwtinQal8LLjX0gHr1gAattG3SZrbAs3nPf2/xCk/03c+rbSfljAZwLx9xOxIbutIhFHWv6cfXEwQBpdVqJPJzstsnb0+mvpwCUc8KcLp88NWUuaw475D9auu7v3/nAab99CV/RvxcWi9BkEamH6Oey4/VPpA4yDHoS7zQAu6ughTk2BwiTZIxC+FG9rM203zHJnoNHrzQQjhKyN4RYQBpZINMPdzjewyX5qQb65KHb5ZsHQPKT+WqBl20Jed8OCAIjQzxEMz9EMDq4zm2Ypmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSYPR01MB5333.jpnprd01.prod.outlook.com
 (2603:1096:604:84::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 06:12:05 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 06:12:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 04/10] RDMA/rxe: Allow registering persistent
 flag for pmem MR only
Thread-Topic: [for-next PATCH v6 04/10] RDMA/rxe: Allow registering persistent
 flag for pmem MR only
Thread-Index: AQHY+ZRFbuytOeh5Gk2a5xGGAh/JVq5LD0yAgAECjwA=
Date:   Wed, 23 Nov 2022 06:12:05 +0000
Message-ID: <51ce238c-7870-581e-8d29-5d802e4d7dcd@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-5-lizhijian@fujitsu.com> <Y3zgzyMN71AmIFPI@nvidia.com>
In-Reply-To: <Y3zgzyMN71AmIFPI@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSYPR01MB5333:EE_
x-ms-office365-filtering-correlation-id: 7aa93e4f-2af9-42a8-1941-08dacd19a556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xF8MyRP49R0+sOevzokIF/l8rIIsEje1olM+E226TUeaytjmBwbfRVm63D72P7d2A2Vlmqlqv3qAJBoLahuH9ipF/LaAld0Ndc/jon21Feb1PEvHJCRDX9Na2akC2hkFXMaZJu1daCDJHL0uzBWyo4in6C4PBXYFmD1oRxvo8kyQLSJzRRWR5uyHcupNrpkvscneHDmCNUSYikLof3En6wKobQ5Xi9AVXguI6jM4pjeyfiE7eTTOzXYL87CyVKQfPDuJtc/Z8M6hlMtvW1FyDKNTMmozw6nPmNKEMDpfkzM3PlRz2f4P/RLwOWYPEIlZTICYjCaBE8R+9C3TUe5JxwU6wNdcsb0N3Hnfzu62Un4v5+XN965OSEwW4cW4KLViPiJt8aGpOReb3M43kTSCSY31/glzE5Nx7/mO9dWrjpCLM6xe2Ah7QoQsyn98/w4ne/CP5njJ7F+6U96by5ujTHBN6Y2rrthSb1aQ5OKhjqJ2kSVRz+W0oEJJssQKGjsKgGPXyrbEmFuxiHPuigkyOirCnxt5P0QQXARDxkpa6ZqBJQHTTYscMyqW9VnD6/QEiDK8X7j9feiDO4EnQEeaJFJW7AGUBchujfWflbgjcfQVTJAiRetSdToAHH3TXcxpvpuXSBbbK9DQ8PY2jp4ta8iBngAAzmfxxao7MMfD21ypx4uGmoTLi5AxGs8qVi/oW4XZwEcqSDc35Lk4Sa85pEXT7yZxjaA4r1NdQHpydctqNy1IlLQC0oJjypYO34wepZsL9FwVES1HESPANkEs+Qt3P522pvku+WeXNLNJ+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(1590799012)(451199015)(82960400001)(122000001)(38100700002)(86362001)(6506007)(31696002)(38070700005)(53546011)(5660300002)(71200400001)(186003)(26005)(66946007)(6512007)(76116006)(316002)(66446008)(6916009)(64756008)(2616005)(91956017)(478600001)(66476007)(6486002)(54906003)(4326008)(83380400001)(8676002)(66556008)(4744005)(8936002)(2906002)(7416002)(41300700001)(1580799009)(31686004)(36756003)(85182001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBOWE4wNUF6cStkT295WTN5S2UzcEYwMG0rSXBFajFlcVFsUmxnMWF1OG0v?=
 =?utf-8?B?VDMzOE44RnNETDRTSU5tZEJIWDVYakNHR1ovckVCdTcyWlI1Ykprd0hRQmZT?=
 =?utf-8?B?RDZCSXlrV3VwWkw3MW0wZGlHdzQ0RWJDL0s3dzRkRmtvc1c3QW5sWWI1QWdx?=
 =?utf-8?B?WkdpL3hrWTFubDBRNjhlYmFLOWdnaGhlSUxJRXRTNmprdHRXanpCcFR1RHN4?=
 =?utf-8?B?UndMa0tObE5jY2RaQ01YblZqSUtxYk8xYmplSk9hVERJM25MeDhuUVkrZjFL?=
 =?utf-8?B?UkFpeEZ2dFdBZTBwUzJBeGRwRVl2WEgzL1hzK1o5ZjhINXBiU1c1QjBvVVpt?=
 =?utf-8?B?TmpHUlQ4L0txVGVBdUhtaFhOdmdaQ0h1dkQ2NXJCSElKaENITXVxR3lwRW1O?=
 =?utf-8?B?Z25DOC9ZcGVjdEVqZ2FBb0xic0Y4ZmRJeSszRmpIZUxIaHppV0VJQ3YybHNU?=
 =?utf-8?B?b3lOWXdtNFVmakdzTlJ6cWFEMW1lazFXUmFVRVh1MmxwTDRFQjlEQzJEcm1F?=
 =?utf-8?B?YUJUMlBGM2NOQ3ZzeGsya1J2aGNtbzlKQlQySTVnZVVCZU56S1lYL3QzMWlK?=
 =?utf-8?B?N3Z1ZXdnOFdGMkRERzdJdDQ0eXowbEptMUUyeW02OHRqbjRXbjRPOVBqUTRV?=
 =?utf-8?B?QWhNbGNZY2d6Y1FxamhLYUpQM3VCNDdwZlRrV3RyeGVMZ2x3ejUwcEs3bFFK?=
 =?utf-8?B?YzRDcnd3T3JQZnVQNlVuOWJ0MGkwaDEzZGhMZU1uN2xCR3IzODJXRmV6Qlpo?=
 =?utf-8?B?Tjl3eDlWRU1ZZFIyRjBEblhTV2I0MjBoRGJpbEpLVUl5TGdiajNxOHgvSnZ1?=
 =?utf-8?B?Um10NzVHWm04UXgzbnYycE9yK0ZTbEZmWkVJenZjNUI4cDBBR0hlUFhlZElD?=
 =?utf-8?B?NHg3aVgzQ3EyUG1hNEdQVmR1NmxteWUxSWxIeU5kNVRnVDBzc0xrMmxvVHp0?=
 =?utf-8?B?VSsra2QvL2NrRGJYcDdTeWZGaEJUUXZ1YUVsUjQ3SmRIeFcyVG8yUjNNMStZ?=
 =?utf-8?B?S212Y0FUMEJCcnJTdmx1SUZIU0s1UFVhY09hMmk5NytXTmlncFRZTDBpM1Z3?=
 =?utf-8?B?ekRIN3NvbzM1Q255eEs2VysySFdtUEV4MmpIL25DTHVJUzdhZmgrOEJXMHZt?=
 =?utf-8?B?UFMwR1ZJNWF6V3pFeVFPNEMvVmFHN3V1SnVwOWVTVERmOWlZeDg0TDRuRzhT?=
 =?utf-8?B?cXJTTGNKaUZhS25sdFIxZnE5UXlianN1eFFzbWs1c2t2UlRNeDN1UFFWK0NY?=
 =?utf-8?B?M1dIWC9QQzBXTk9oditacm0wVVJHc05kWXFqNVlOR0MvUlljWkpOZ0N2cThh?=
 =?utf-8?B?YTZmUGh2Z1JZVzIxSCt4UVF3TytMWDRBQmtVR1BFeHdvWXozQVdKMHdaSU5s?=
 =?utf-8?B?RzN5UEdkbzVudXZodDFWdEFadTQxRFd4bHFZTlpVaDRwcGxONk55cGVyVzlI?=
 =?utf-8?B?b0U1YWIyYjdXTDgyM3dzeTJDeDk3KzdOMGE5QlBKcUtYdWo5N1d6T3JBZXh1?=
 =?utf-8?B?RGlKQ0tkcDlLVHFqaXV3eGZiVm5SaVhXaGJEYmtFRWttazh2TzIwRm1LUXpl?=
 =?utf-8?B?ZWhxd2cyWDI3VC8wclFzcTRHalRUZ0t2ODliTldTM1JCa1JCaXQ2Nmx6cTFS?=
 =?utf-8?B?dzc5d0hpMUVQRktJYUNzZUlZYnhvZjJLa0svQmdJY0tVcUpjMFViMklmMjBS?=
 =?utf-8?B?RHRhdVpPRndlbmFvVjRLZnlYeldCdWRJS3hWUElyQWhPVStjK1VEZTMrSWE5?=
 =?utf-8?B?UFovbU43b1pla2FlenRNTzlxbW54ZFE2T1kzZmhIRjNaNFdZOE5zUlFKeXdy?=
 =?utf-8?B?UmdVRXFaVzFaUitaMG1zdy9MMVdSK2ZWb2FmazhIUm1ybDBycGowZkNEMVMr?=
 =?utf-8?B?NXlneFN5cTYvUjg5WmdvOEgvMGRkdnhhdXlTOWVwVHdjTTl3ZVoyTXd0SUor?=
 =?utf-8?B?aW1xQ3AxaFU5ekExeklRMkx3SmtzZHF0bzdUcDV5TFNva1QzNllBSmN0VTRW?=
 =?utf-8?B?YUJBcWVDd3dHalEwQzNlV2NPR282aU9tZnY3cUl1Z2MxOGM3aU9jS3F2cGwz?=
 =?utf-8?B?VzRlS0MrSUttZXJGTWUrbWx4RndHNjBIWVNFSjFBazZyUEJxcWhWblZzU1RT?=
 =?utf-8?B?K2s2Y25aTms3MktOaUdSNW9nRHdPcGhZUGc5Y0EzNzdCYmUvQSs0aDU2STB6?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64E83165879B3F4880C1A2823E1E9AE3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MldCTDB1QkIvK2pjS21jbVNDbytEVXdITlhoMDRncTdya0V5NkxWTnRSQWRj?=
 =?utf-8?B?aDRwQ0FMOHZaMEdKLzFQZ05uNE81dTkzQ3RqaktFRGdLSDlOdjIyS1F6MlBV?=
 =?utf-8?B?RUlpN2wwN3BTRWJUUE9SL1M2QlM5NThuUTVBc1hhck9qaGpOdXBueTBBZVRQ?=
 =?utf-8?B?M2loYmFzN0pGeHVnVU5ta1ovNlo3b3BYdkJaSVBUblpxRy9TWU00eGlCamd0?=
 =?utf-8?B?YWhuZjZyTHNiMDA4NHZaK3QyQXBHVDVlOE5OdkE3dVQwbjdnS0UzR2syTnJZ?=
 =?utf-8?B?WVpBanhDQTk5NzRKZUlsaHo0WnJlMEk0Yy94YVlVMERWWllzL25CcE15WmF4?=
 =?utf-8?B?VERvMDNXa2RXeXJmckk3a2p1RzA0QzJObUlmR3Z4OUtHUXl5TDBNQWRQY0pM?=
 =?utf-8?B?Z25oOElHRDYxSUw0cDVYSXVDeXNnK05uM28xSVk3dlRmbWJPZnZyMUliL2Na?=
 =?utf-8?B?cHRYZEJhQ2tMbWs2c3EwbjRMdTZFU0VUczNieTMzbVhLdWJ0N1lycTZmbWY2?=
 =?utf-8?B?UUxCSDc5RnZVNTZhUXB2dDFyZHJRUHJtcGVMV3lFd1NBUTRyclpJejlsVGU4?=
 =?utf-8?B?VHVxQjF3RFdvUVhyNUNPVkhNbVgxdHdVTnZDR1V3MXVOamlicis5OUxIZlRj?=
 =?utf-8?B?MTh5T0swUFB3SHFEZVZwWUNoKzZzVWJTMDRhcmF5dUlrN3ZVTjNpTDVKNERN?=
 =?utf-8?B?cmZlSU1ud0JEU0ZqZWtKSk9NTHkwdktZd3lHNjIwUit2OEFKSklDRTVqRGlh?=
 =?utf-8?B?OUJaT0s5VVFtZ1liUGVJT1lzOFV0UDVOVVhwbEpoVmZ1T0FpT1NBZmY5dHpk?=
 =?utf-8?B?bTV1QkswYmhZVEFXY2d3dEdiWWtLYkViVW83UG9KQjhQeFhRUGtyWDZMQ3dp?=
 =?utf-8?B?QXZNOHBqbjA3dUtITXlhZlkwVU9jaGtxRWwvSG1SMXdVd0lscGlydmxzVEc0?=
 =?utf-8?B?ZFJoNnhJLzdYOXY4UElxU2tSL092WlFaQ1lxL1lCdzdCTGQ5cHhielB2OElL?=
 =?utf-8?B?bC96cmhlNDVXbHkyT0NMT3MxS2oxem9EWHFwNFNmMHFzR2tXakVRVDJzYWNI?=
 =?utf-8?B?dGYzakFEN3NIbXphYmtTeXpHNlByTVAvYkxVL0pmU25pWEpOWUxROURZamU3?=
 =?utf-8?B?ajZXZmFZbWJURHFJV21VUFFxTmttamNrTW5oUWl4MlRSeWJtc3ovWkd6bEVj?=
 =?utf-8?B?WHI2TmNHV3RrcWJKdlI3OWtYT0Jvc3J3UWV0eHdFM0pUazVVdkF1ekFlNmpI?=
 =?utf-8?B?WW1VQU83NEpWbk4xaDJidllhNjFtbW1OUk12eXdKUWZ3YmRibWkvUVR3L20v?=
 =?utf-8?B?M3ZpMGlNSnkwR0lTZklxcHg4dEJTaXBzWVNSK3lIWTNkcElNMWxoMFpsTGQv?=
 =?utf-8?Q?wPjOxQmuXoUFvIfNpYDAV05hQ0lrcPok=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa93e4f-2af9-42a8-1941-08dacd19a556
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 06:12:05.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8jYZTXej9j1v3PYLr2XfXRwBROUb6eRz5fg3C/ScpCHy1SCdnj2GySr2X5k1Fk5inpBpHaDuVLKqfl8SOx3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5333
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIyLzExLzIwMjIgMjI6NDYsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2Vk
LCBOb3YgMTYsIDIwMjIgYXQgMDQ6MTk6NDVQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
ICAgaW50IHJ4ZV9tcl9pbml0X3VzZXIoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdTY0IHN0YXJ0LCB1
NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4+ICAgCQkgICAgIGludCBhY2Nlc3MsIHN0cnVjdCByeGVf
bXIgKm1yKQ0KPj4gICB7DQo+PiBAQCAtMTQ4LDE2ICsxNTcsMjUgQEAgaW50IHJ4ZV9tcl9pbml0
X3VzZXIoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92
YSwNCj4+ICAgCW51bV9idWYJCQk9IDA7DQo+PiAgIAltYXAgPSBtci0+bWFwOw0KPj4gICAJaWYg
KGxlbmd0aCA+IDApIHsNCj4+IC0JCWJ1ZiA9IG1hcFswXS0+YnVmOw0KPj4gKwkJYm9vbCBwZXJz
aXN0ZW50X2FjY2VzcyA9IGFjY2VzcyAmIElCX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5UOw0KPj4g
ICANCj4+ICsJCWJ1ZiA9IG1hcFswXS0+YnVmOw0KPj4gICAJCWZvcl9lYWNoX3NndGFibGVfcGFn
ZSAoJnVtZW0tPnNndF9hcHBlbmQuc2d0LCAmc2dfaXRlciwgMCkgew0KPj4gKwkJCXN0cnVjdCBw
YWdlICpwZyA9IHNnX3BhZ2VfaXRlcl9wYWdlKCZzZ19pdGVyKTsNCj4+ICsNCj4+ICsJCQlpZiAo
cGVyc2lzdGVudF9hY2Nlc3MgJiYgIWlzX3BtZW1fcGFnZShwZykpIHsNCj4+ICsJCQkJcHJfZGVi
dWcoIlVuYWJsZSB0byByZWdpc3RlciBwZXJzaXN0ZW50IGFjY2VzcyB0byBub24tcG1lbSBkZXZp
Y2VcbiIpOw0KPj4gKwkJCQllcnIgPSAtRUlOVkFMOw0KPj4gKwkJCQlnb3RvIGVycl9yZWxlYXNl
X3VtZW07DQo+IA0KPiBUaGlzIHNob3VsZCB1c2UgcnhlX2RiZ19tcigpDQo+IA0KDQpHb29kIGNh
dGNoLCB0aGFua3MNCg0KWmhpamlhbg0KDQo+IEphc29u
