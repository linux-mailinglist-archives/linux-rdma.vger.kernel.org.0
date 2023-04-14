Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00736E204E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDNKKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNKKC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 06:10:02 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45781FFD;
        Fri, 14 Apr 2023 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681467000; x=1713003000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oRjhfa3VcxpFQOhLR5Uay8Zq9VKlm/+kdG4Lp7Mli84=;
  b=qfh02LimeIrjbli7FNxaTPSSppyjxXlBrTjI2z9ukiMMaEl5piRLtVt9
   fZEFmhxC4ZqhqUZOwYqrnixQ/dIaiwN5A7iZWzoTsFehyU371nKMBATQg
   Lh/I12QaVunfhCiA4VshkB+yuYK6yB+iP/zsBSKBIo+Pn33hYZdKonPQ4
   25s7mJuOKl1cEtmXJXvishMzPpHrsW5bk3TOc437HsRZytoGvmqN31W0O
   x4Bt8nmSOH9fryrHgv9kGKIx0awepf8FatJYbxB1rPNLzuAIbMOMmPNZO
   Z5QpTzDMEpjX9EB8iOlhOS3NTQLxmqP9ZyM5iRWBIcAygF3uHI97RehsV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="81976690"
X-IronPort-AV: E=Sophos;i="5.99,195,1677510000"; 
   d="scan'208";a="81976690"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 19:09:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDE/V4diLR+K8ADucSBvoTU1bPhWqc6Yleqq7ZVxqxAgJm6nlDyCZKr5Me5FooWNRzZyT70P/iAWCWwPK/hbJ/c4WTUWN0VP+940nE1Kx2td++fmV+6yMXC7U6aPqsnmOfAcsrhxdDaRTGsNcXpozb8/cKzqqcoXwuUPdjxec3swdiUZN/B2B/KYhM4yRVyOYKwvtgh+zNsnbSwqlg1ByqPoMlp2xUyffmZL4S72xyuTwkkisdY9oAMc0pXBXQyUhHUwwPNvyBjJCX0W/aAlKkuL+VLZMqkPOOBfOsuy+MOITEdm15uvs5GFrRm0oaiecmBMQbE3MkdUQr78esElVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRjhfa3VcxpFQOhLR5Uay8Zq9VKlm/+kdG4Lp7Mli84=;
 b=kjB5gKfSAgQVion6I4cc70bK6yUQZXl+lmIklL1u062acdS/pc13lR8iapStWebomx16B/UDZwQdZAtYQ7HJLLPyAZuwxl7Cond8JGy3Iff/Adk0dh3KidCCFRdeKNwSEU4zVUnKSa3PmoDdn8h7o23KLmzMWefc+cPFMNEGirBkip3b4n1VomtXzAZcdqwWjYa57Aqe9hBYgVx4paNeGtavTYNpgu+OdmlB3IK8+UrO8oPhwKR1jL/+vPcE+X6S2LhdVR2tHVxeqYvjfiaUBwu6Nzg/JttCk/vfvbF63Mv0/V8zgZkJOS7DkGMHkcNpSuyhk1CpFYJ+Nk0vHFaDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TY3PR01MB11412.jpnprd01.prod.outlook.com
 (2603:1096:400:371::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 10:09:53 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::be7e:badb:f87e:ec60%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 10:09:53 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>
CC:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgAFGcYCAACCfAIAAB46AgABElwA=
Date:   Fri, 14 Apr 2023 10:09:53 +0000
Message-ID: <71935de6-e3c1-c719-4e66-19242af51ab7@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
 <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
 <bfa3317b-656f-9a3f-9564-4dbb1bbef3e3@linux.dev>
In-Reply-To: <bfa3317b-656f-9a3f-9564-4dbb1bbef3e3@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TY3PR01MB11412:EE_
x-ms-office365-filtering-correlation-id: 65c7714f-c3e2-4571-d02e-08db3cd063ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvTUYO0Kp0yFOtvZ9jpX2jvI8Fq5eFs/xCLIpSUbXSoBZJQP1i5nkfaVxJR26IH9yPb7SvjlQch07ETGWXs4zHlpEmozNZW8P/6dQh8J5cJ3tyoHCmprQ27OCgmJ9FqpbmGqBYBV8M/EAVmctK+oqzifbGJ5B8nTviweQEuETJt9OipFxfcRNi9fsmK4NL7T/E7f00FTlMEA3neKY6q3BvnT8EPZBNbUmbRVyGNUC/EMmJIhaXwd1byVd7WUOh/2RwAJjmz8ZtftNe5fzJKxkjLKGmV9IoZOvBAzDkGNGakt24J9zf4iGLoaxKc6QSKPuXAaz2QPlC+s4vL2W/SLzIC7NqG/lQyCcwq7Hw03OOhwomz07mDKh7duedeiW3gQqryIrzGy9Hbqe3N3uc4VdCbKd/MyEFVpO8MkWE0jTVlrCDBW5M802yvd57rjMyBHNrbpSDw7Bi5+4rwqUeRgMfJLYG2P48kxXerMX36f8QF0HGGQeWbN1XKKPPF8Ha7gWVwkTHOSu0+O2Hzx4guEooJjSaBEWVDU1934J0DvohtZsDAhSO4/nV5fEyLK2sasejuhAXm6qxaqQhKXvhis/rxrJ3xhMgLL9bGPXo7ef5b0CY5j9YxM96Ou6Qe4fnVRcmHV/MbwthoCAyA00Ta4hQLZaPmlj8nmenxFPfQCq/74XoIXzyCxNPqbzxV3BH12Y+YF8+AqJz0GDHIFirCFWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(1590799018)(31686004)(66899021)(1580799015)(36756003)(38100700002)(5660300002)(85182001)(2906002)(38070700005)(31696002)(316002)(86362001)(8936002)(8676002)(66446008)(64756008)(122000001)(41300700001)(66476007)(66946007)(4326008)(82960400001)(66556008)(110136005)(966005)(91956017)(83380400001)(76116006)(186003)(71200400001)(53546011)(2616005)(54906003)(6512007)(26005)(6506007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWJQYlN4NnNEbk8vL05xcENvT3BKUVI3N24rSGdkcXNqVDNwdVFTU1pDbGlU?=
 =?utf-8?B?U0VwcEtFTTFlZDhITUNRYWdGc1J3ZUtocDZNZG55bEZ1SitRR3dmaDlsYXdD?=
 =?utf-8?B?N2tlcnROOE9SY29Qb3VzblJvdTdvMDNteFU3dHAzWWI0OFUvYlVUeW81UmZs?=
 =?utf-8?B?V203TkdtSStNQ1U0djk0ZUxYUWJUMjgxKzRBRVA2RzJYRnlhNHFYSHVXclhV?=
 =?utf-8?B?MlhlT3RnR1k1L2pNZEJxL2hFOWw4RFZVMnNYaGxLODFOenVmaDRRZENaSG4r?=
 =?utf-8?B?SWJTVmpRNElRZlVac2NSbEtiNy9iTjZZWVBQOHhYWEhqUGdhZUx6Qlh5amQ0?=
 =?utf-8?B?R0FTUlZvWkRTNFFiRm5tTXA1YWFSRlZPaExhTGpYWW5lbjE2VWc0Nk5mNjFx?=
 =?utf-8?B?ckFsNmptUjErT2orQUtmZ1BYR1NOOXM4NDhiTk5OQkhDME1PUDFGVEVZdU45?=
 =?utf-8?B?ekROZ1AwbUNSZXEwTDZMYnNCNHhtZEZ4RCtxeDZQR0lYNTZpR056YUhTS1ZY?=
 =?utf-8?B?VGxQUmdsanJnNDVhelFMNUJZeDRYV0JoeDFCS1hZTWR2N1h1bnRvRXplODAr?=
 =?utf-8?B?YlF6WjFHdXRaM2pqWmwwSkdTM3g0ZExiQ0dNRG5GWXRvSWFnTXdieklLenN1?=
 =?utf-8?B?cVZtbHBJbmVxUjkxMHl6Q3JrWlFHQ2VwMVkyRHpNMGZ5K0ZVNjZCSkVVY3ZK?=
 =?utf-8?B?U0ozMEQyWG9SMDhmMldRbHlONEJoZldaemVYNFY1R242OEFicUllSkVkWlAw?=
 =?utf-8?B?MmE0N0tUaEg3MWMyRFIrRWNIS0U2N0FTZE5BdkNmYzZtazRQR21sRVNOSXh4?=
 =?utf-8?B?ekdmTnpTa2RMdlBWWEJ4NE5TU2xaWWRwSEx4TzY4WFc5Qlh0d1ZYci9OMmRj?=
 =?utf-8?B?Z0lSZFA2RWNSUXJXdTk0S1JEWHlxb09DZkZxMlRJeHdHeVMrL3NDdG5SQWJK?=
 =?utf-8?B?WTl3eVI2S3RLd0JYa2ZRSnZTNlhuVDJVTWZMMEgxcHNhQnhla3U1Wnh2MGs1?=
 =?utf-8?B?WFptYlhkOXpTWmcvbWoza3dvSTRhb3hYZWV2Y3RETFA3emJZQzVDS1RMK3FJ?=
 =?utf-8?B?SG8zd0xBdHM0eHJqazZHTWthckJ3T0NabnNUVGNvSnd2ODBxQ1NpNmxSd0l5?=
 =?utf-8?B?bW05WXFYcE1NRHRpWGlsZktWQ3RiUWh0dVFyRmRQVXFqWlFVa09OLzcxVThD?=
 =?utf-8?B?RzNvcWpWM2lPQm5yckpvV2tqMG9iTG9NVzhXTldrWWxxTWRaVERJRGs0UGF5?=
 =?utf-8?B?K1NUTklnSStveFpRZzliTElsS21Yc3crY3VQYlg2SzNnNTdqQ2dwRjlqSzJa?=
 =?utf-8?B?UDM2WEtHc2FQbCtlNSsySWxxZnZZczVPVjVpNzQxZ0lpRnV2R1RvVk1FZlZY?=
 =?utf-8?B?RFY4KzgrazlLYlQxZitGRGtFeDByZEdMWGQ2TTZnbU1DcjFGWGlIT3RxQ0o5?=
 =?utf-8?B?bDNBRjkvbDdOSjVWOHRnU2ppRWc3Y0YzanBQOGUzT3FXREhPL3hwOXRpY1pi?=
 =?utf-8?B?SVNHR3l3UE9tUlNFdXdSMEgzaitqRGF0cFI1ZXJ3MjBVM29ZaGl2STNybnJI?=
 =?utf-8?B?WXpRaVRQaFdCREVjUG8rSGd5eXlpU1p1R3VjTnVQc01qV0wrdHZvalluQ2VQ?=
 =?utf-8?B?MWRJRXVGWjZoeUNoc1hCM1ZVSEtUZHYzTklSR1hnQktzb3FwU2ovQ25hTGdW?=
 =?utf-8?B?UTgrRFZoYkJXTVd6US9sVkZEbEN3bVZkamszWXI0aG8xVTlMUDdjUVlWYk1s?=
 =?utf-8?B?TFQrU05kVk9hdWF2L1gxaUxqb0x0anR1N2xyVDNRcmx3YVF6bGFUSkFNdEpF?=
 =?utf-8?B?RmxtTmV4S2JGa1FZTElYYit1cHFoM3BvQ0hPYnJiU3NkUmpQZkE2SXZJR2tn?=
 =?utf-8?B?dXNRT2s3MWVrcDllUWxHeHhteTVOQkpZR3MvZ3R0T1dtcmFOYU5TcGpYekYy?=
 =?utf-8?B?Tk54R0VwS0tDb2VUNVRwVXJCeVZkQ0RtbExpdWdLQlRTbTYweG9GUldhRVYw?=
 =?utf-8?B?eHd5YWVEMUhBWE93RC9URWU4eGt1ZXZXRG5nVlpjdzI2M2J1NzBuSkphWC9t?=
 =?utf-8?B?VWh2NzhUQWtOTkNFUnkwYmduSTBrWnRjbUtvd1VQMXFWNjVhNks4NnFxN2tx?=
 =?utf-8?B?eG4xNEpOd0JhU2h5NDJTS2lMSHNtQ0RCN2RwcjdJZkFPRk5TUnQ2T0k5VHdo?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <870ED02D5739C445844DD7F539EF8AE9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ViqBsxerNxNJjGmKNziStJUHswRRs21ya5LUatmmfNGdQFgui06KGPwTJb82ZkX7DN/DaG2ETEuR7+nxHo5peWTCgDvK7nA3PpiOxeTy5VYyoZekkwQExXiTvz9E5+STw+TuZPXkP6i9KhLgTdl2xZdYiwlWoj/doopgkq2+HsNeS/67wt7XvYSixKnRdacvpQgKwMrdDwmDRb1tjMqNJ2c9mGThaJX8nggmyoO4MDR36ryUfSIk5+ol062vW7sbodHGZqw1tRkfxIvJyQNx0Dsz6/nWWAkn7Hzlub4LR51LZ310h9LEYNhaceuXlKrkesA8kDiwb58BUvB45AWwUu8hEhA/BkOZbgmbJXbwVMtAHk9sqdiQ7hgkU8DG31YnsdqjWJivlfnYKaWRex+KWir/LkqcW9MRLLAkqL64QbsO99PeI/pEddBUgv52HwKP+RNmnPVe2xf6LcI6StJRQAG1+QxHiM09MQYrUksb4wA6vMqbLAnCjyhJndMYOeukCo1V2utPtrppoVMgdSkSPHXXfX1SXxVOJEHXBA37C+MLIcM0ZaQ1UeG+Yf5tTfFKbufPu1FUWKqRRSPtmz7PKsjbAMDh0ygHmEQY9SQcrmyMK6U5GOvs2pg9l3FVWiyCZKo7z5vrPuUgv1zPvRvHVUgPS86KhDWbmSSeViCsKRUl7D6jYffGVn3yrHkFqCxPLX3GR5z0kPmJlmuDa8WAWqpClVedhoAdAJjRsG6d0I6xBqF2phbhfXB55Ik1403bc/28a18cYGKgojnMb0kqeMLEuTrX+noG8hhDBTeeHfZrclUxO0j4ij1RBVCKnk2tHjfeJbCkyG/sLM7Qa8eadDG5ztXqIS7dnrC7OSTArYttNiGCOtST0h7OAKCW7/Is
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c7714f-c3e2-4571-d02e-08db3cd063ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 10:09:53.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oixVzYwbqinp4eA7xiVFfq1Hfus2tU+uu4iQ1PkuigiV9dCBdIBw9kEu+pSUH8S1vgg5g+5r1OF1WvILsT6ZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11412
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzA0LzIwMjMgMTQ6MDQsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gNC8xNC8yMyAxMzozNywgWmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4gT24g
MTQvMDQvMjAyMyAxMTo0MCwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4+Pg0KPj4+IE9uIDQvMTMv
MjMgMTY6MTIsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+PiBPbiAxMy8wNC8yMDIz
IDE1OjM1LCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPj4+Pj4gSGksDQo+Pj4+Pg0KPj4+Pj4gSSB0
YWtlIGEgY2xvc2VyIGxvb2sgdG9kYXkuDQo+Pj4+Pg0KPj4+Pj4gT24gNC8xMi8yMyAwOToxNSwg
WmhpamlhbiBMaSAoRnVqaXRzdSkgd3JvdGU6DQo+Pj4+Pj4gT24gMTEvMDQvMjAyMyAyMDoyNiwg
TGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+Pj4+PiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAw
Mjo0Mzo0NkFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+Pj4+IE9u
IDEwLzA0LzIwMjMgMjE6MTAsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+Pj4+Pj4+Pj4gT24gNC8x
MC8yMyAyMDowOCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+Pj4+Pj4+PiBPbiBNb24sIEFw
ciAxMCwgMjAyMyBhdCAwNjo0MzowM0FNICswMDAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+Pj4+
Pj4+Pj4gVGhlIHdhcm5pbmcgb2NjdXJzIHdoZW4gZGVzdHJveWluZyBQRCB3aG9zZSByZWZlcmVu
Y2UgY291bnQgaXMgbm90IHplcm8uDQo+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4gUHJlY29kaXRp
b246IGNsdF9wYXRoLT5zLmNvbl9udW0gaXMgMi4NCj4+Pj4+Pj4+Pj4+IFNvIDIgY20gY29ubmVj
dGlvbiB3aWxsIGJlIGNyZWF0ZWQgYXMgYmVsb3c6DQo+Pj4+Pj4+Pj4+PiBDUFUwwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVTENCj4+Pj4+Pj4+Pj4+IGluaXRfY29ubnMge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fA0KPj4+Pj4+Pj4+Pj4gwqDCoMKgIMKgwqAgY3JlYXRlX2NtKCkgLy8gYS4gY29uWzBdIGNyZWF0
ZWTCoMKgwqDCoMKgwqDCoCB8DQo+Pj4+Pj4+Pj4+PiDCoMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCBhJy4gcnRyc19jbHRfcmRtYV9jbV9oYW5kbGVyKCkgew0KPj4+Pj4+Pj4+
Pj4gwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIHJ0cnNfcmRtYV9h
ZGRyX3Jlc29sdmVkKCkNCj4+Pj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqDCoMKgwqAgY3JlYXRlX2Nvbl9jcV9xcChjb24pOyA8PCBjb25bMF0NCj4+Pj4+
Pj4+Pj4+IMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIH0NCj4+Pj4+Pj4+
Pj4+IMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBpbiB0aGlzIG1vbWVudCwg
cmVmY250IG9mIFBEIHdhcyBpbmNyZWFzZWQgdG8gMisNCj4+Pj4+IFdoYXQgZG8geW91IG1lYW4g
InJlZmNudCBvZiBQRCI/IHVzZWNudCBpbiBzdHJ1Y3QgaWJfcGQgb3IgZGV2X3JlZi4NCj4+Pj4g
SSBtZWFuIHVzZWNudCBpbiBzdHJ1Y3QgaWJfcGQNCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4+Pj4+
Pj4+IMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+Pj4gwqDC
oMKgIMKgwqAgY3JlYXRlX2NtKCkgLy8gYi4gY2lkID0gMSwgZmFpbGVkwqDCoMKgwqDCoMKgIHwN
Cj4+Pj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqDCoCBkZXN0cm95X2Nvbl9jcV9xcCgpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqDC
oMKgwqAgcnRyc19pYl9kZXZfcHV0KCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfA0KPj4+Pj4+Pj4+Pj4gwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqAgZGV2X2ZyZWUoKcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPj4+Pj4+Pj4+Pj4g
wqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGliX2RlYWxsb2NfcGQoZGV2LT5pYl9wZCkgPDwg
UEQgfA0KPj4+Pj4+Pj4+Pj4gwqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXMgZGVzdHJv
eWVkLCBidXQgcmVmY250IGlzwqDCoMKgIHwNCj4+Pj4+Pj4+Pj4+IMKgwqDCoCDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0aWxsIGdyZWF0ZXIgdGhhbiAwwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0K
Pj4+Pj4gQXNzdW1pbmcgeW91IG1lYW4gInBkLT51c2VjbnQiLiBXZSBvbmx5IGFsbG9jYXRlIHBk
IGluIGNvblswXSBieSBydHJzX2liX2Rldl9maW5kX29yX2FkZCwNCj4+Pj4+IGlmIGNvblsxXSBm
YWlsZWQgdG8gY3JlYXRlIGNtLCB0aGVuIGFsbG9jX3BhdGhfcmVxcyAtPiBpYl9hbGxvY19tciAt
PiBhdG9taWNfaW5jKCZwZC0+dXNlY250KQ0KPj4+IFRoZSBhYm92ZSBjYW4ndCBiZSBpbnZva2Vk
LCByaWdodD8NCj4+Pg0KPj4+Pj4gY2FuJ3QgYmUgdHJpZ2dlcmVkLiBJcyB0aGVyZSBvdGhlciBw
bGFjZXMgY291bGQgaW5jcmVhc2UgdGhlIHJlZmNudD8NCj4+Pj4gWWVzLCB3aGVuIGNyZWF0ZSBh
IHFwLCBpdCB3aWxsIGFsc28gYXNzb2NpYXRlIHRvIHRoaXMgUEQsIHRoYXQgYWxzbyBtZWFuIHJl
ZmNudCBvZiBQRCB3aWxsIGJlIGluY3JlYXNlZC4NCj4+Pj4NCj4+Pj4gV2hlbiBjb25bMF0oY3Jl
YXRlX2Nvbl9jcV9xcCkgc3VjY2VlZGVkLCByZWZjbnQgb2YgUEQgd2lsbCBiZSAyLiBhbmQgdGhl
biB3aGVuIGNvblsxXSBmYWlsZWQsIHNpbmNlDQo+Pj4+IFFQIGRpZG4ndCBjcmVhdGUsIHJlZmNu
dCBvZiBQRCBpcyBzdGlsbCAyLiBjb25bMV0ncyBjbGVhbnVwIHdpbGwgZGVzdHJveSB0aGUgUEQo
aWJfZGVhbGxvY19wZCkgc2luY2UgZGV2X3JlZiA9IDEsIGFmdGVyIHRoYXQgaXRzDQo+Pj4+IHJl
ZmNudCBpcyBzdGlsbCAxLg0KPj4+IEkgY2FuIHNlZSB0aGUgcGF0aCBpbmNyZWFzZSB1c2VjbnQg
dG8gMS4NCj4+Pg0KPj4+IHJ0cnNfY3FfcXBfY3JlYXRlIC0+IGNyZWF0ZV9xcA0KPj4+IMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgLT4gcmRtYV9jcmVhdGVfcXANCj4+PiDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAtPiBpYl9jcmVhdGVf
cXANCj4+PiDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgLT4gY3JlYXRlX3FwDQo+Pj4gwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIC0+IGliX3FwX3VzZWNudF9pbmMgd2hpY2ggaW5jcmVhc2VzIHBkLT51
c2VjbnQNCj4+Pg0KPj4+IFdoZXJlIGlzIGFub3RoZXIgcGxhY2UgdG8gaW5jcmVhc2UgdXNlY250
IHRvIDI/DQo+PiBJdCBzaG91bGQgYmUNCj4+IGliX2NyZWF0ZV9xcOOAgC4uLg0KPj4gwqDCoMKg
IC0+IHJ4ZV9jcmVhdGVfcXANCj4+IMKgwqDCoMKgwqAgLT4gcnhlX3FwX2Zyb21faW5pdA0KPj4g
wqDCoMKgwqDCoMKgwqDCoCAtPiByeGVfZ2V0KHBkKSA8PDwgcGQncyByZWZjbnQgd2lsbCBiZSBp
bmNyZWFzZWQuDQo+IA0KPiBJc24ndCByeGVfZ2V0IGp1c3QgaW5jcmVhc2UgZWxlbS0+cmVmX2Nu
dD8NCg0KWWVzLCB0aGF0J3MgdHJ1ZS4NCg0KDQoNCj4gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y2LjMtcmM2L3NvdXJjZS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9wb29sLmMjTDI0MA0KPiANCj4+Pj4+IFRoZW4gd2hhdCBpcyB0aGUgYXBwcm9wcmlhdGUgdGlt
ZSB0byBjYWxsIGRlc3Ryb3lfY29uX2NxX3FwIGZvciB0aGlzIHNjZW5hcmlvPw0KPj4+Pj4gT3Ro
ZXJ3aXNlIHRoZXJlIGNvdWxkIGJlIG1lbW9yeSBsZWFrLg0KPj4+PiB3ZSBtdXN0IGVuc3VyZSBR
UCBpbiBjb25bMF0gaXMgY2xvc2VkIGJlZm9yZSBkZXN0cm95aW5nIHRoZSBQRC4NCj4+Pj4gQ3Vy
cmVudGx5IGRlc3Ryb3lfY29uX2NxX3FwKCkgc3Vicm91dGluZSB3aWxsIGNsb3NlIHRoZSBvcGVu
ZWQgUVAgZmlyc3QuDQo+Pj4gTGV0IG1lIHRyeSBhbm90aGVyIHdheSwgd2l0aCBiZWxvdyBjaGFu
Z2UsIHJ0cnNfaWJfZGV2X3B1dCBjYW4ndCBiZSBjYWxsZWQNCj4+PiBmcm9tIGRlc3Ryb3lfY29u
X2NxX3FwLCByaWdodD8NCj4+IE5vdCByZWFsbHksIGNvblswXS0+aGFzX2RldiBpcyB0cnVlLCBz
byBjb25bMF0ncyBjbGVhbnVwIHdpbGwgY2FsbCBydHJzX2liX2Rldl9wdXQoKQ0KPj4NCj4+IFdp
dGhvdXQgdGhpcyBwYXRjaCwgd2hlbiBjb25bMV0gZmFpbGVkLCBjb25bMV0ncyBjbGVhbnVwIHdp
bGwgYmUgY2FsbGVkIGZpcnN0LiB0aGVuIGNhbGwgY29uWzBdJ3MgY2xlYW51cC4NCj4+IEFmdGVy
IHRoaXMgY2hhbmdlLCBjb25bMV0ncyBjbGVhbnVwIHdpbGwgbm90IGNhbGwgcnRyc19pYl9kZXZf
cHV0LCBidXQgaXQgd2lsbCBiZSBjYWxsZWQgdGhlIGxhdGVyIGNvblswXSdzIGNsZWFudXAuDQo+
IA0KPiBCdXQgcnRyc19pYl9kZXZfcHV0IHJlbGllcyBvbiBkZXZfcmVmLCBpZiBjb25bMV0gcmV0
dXJucyBlYXJsaWVyIHdpdGhvdXQgZGVjcmVhc2UgZGV2X3JlZg0KPiAoaXQgaXMgc2hhcmVkIGFt
b25nIGNvbm5lY3Rpb25zKSwgaG93IHJ0cnNfaWJfZGV2X3B1dCBjYW4gYmUgY2FsbGVkPw0KPiAN
Cg0Kd2UgbXVzdCBlbnN1cmUgZWFjaCBjb25uZWN0aW9ucyB0aGF0IHRha2UgZGV2X3JlZiBkZWNy
ZWFzZSBkZXZfcmVmIGR1cmluZyBpdHMgY2xlYW51cCBwYXRoLg0KU28gdGhlIG5ldyBmbGFnIGNv
bi0+aGFzX2RldiBhZGRlZCB0byB0cmFjayBpZiB0aGUgY29uIGhhcyB0YWtlbiB0aGUgZGV2X3Jl
Zi4NCg0KDQoNCg0KPiBUaGFua3MsDQo+IEd1b3Fpbmc=
