Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323866A0C8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjAMRdX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 12:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjAMRcz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 12:32:55 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2092.outbound.protection.outlook.com [40.107.95.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91058B52B
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 09:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z953gjMrhhJZVzwbLX55YVxHdcvtB5ObVsbdbfCsQbdPZl/4RbxxvZfN+9YgI/RbkGiReJa0sfQ7aypbdnOsW7yrE8Cir2wmh73p5JqjDZ1gVdlcWvsEugI66wGaJjQ+mNY4RzaPfjKr+i+pnOaf05xaoA7TLzll8UXpL8mLOsjMs65R3KX2PoX52C4VjaT1pCXkDzD9enro6mGnkqB8yNoT8x6jyvO4LkRWRRYgH5SgfvitrbHFlxgAPgxa6k7Acdu651n98meZ6UoCE3/a7BJPjYD7z3ACcnHrNUDX2bRe7dBVxdzxUJN4+sV2NsVETMkGs1mv7XZCE5b3HmvChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPCgZBaLL17sPABMgbdohT8kekaRBDZbN2Bvhw1V8iM=;
 b=LTD4j4rUO2eK5lWWazw9ISPWndWS8yHbkO4rpxQ9i2etbrDipye4i8EOHEy4olyOnSaTlMRej/NYT4MAUKcDnzbWsx1BiTmCJIrFNONelf/Vv2ypRPGwpBCcIiECNwLYi213nY67mpCR3d0tpZwPjicEeDmvtQqZQelDJ93NKU7+qHQD7MNgv7n3AKq6TR3cNKvUZe4moRdLmrjup/oVGc1engk8tGUa+/rkN1WM6teivXlLbqni3EMMtHnmYFVHizmZ8LCu4QyEBiwjTME6Wyk05mXVykqSA7/v5/a3eTjWMugmITVotNqiqOBmmFO2pNv3q3IYKy0pzQFPPqRk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCgZBaLL17sPABMgbdohT8kekaRBDZbN2Bvhw1V8iM=;
 b=hIQ6pEqcFVSCDn3Jt1iEX+xYjO5VVV6uD4iO9hiDuGIn45gG0nQVuraGSNwoOs1GZxPpXyvo1DFeAWFsNImPdLngUAY9IhKKnTFbsxNZ9Fgq1OSF2cPFB9C19nVk06WorqK6FZTt6u2XoBVGRWbySWS0uu7R0WtK5LatqT6/Am1nBgBskjjHaY1vlmsh7Hpo1ap7zoY2XWriBMExOeHJ07EPihcPIYb9Flz0BV1/ziVtc/tP9k58RynsSdPJzBoo532viEabV7HlMyXtKru6XgHOSPUa07Jpz97LWcfsW6u5jV3VtCOcyhO8sPQFxbBXARNrvlXIuASdZ5qHg10fGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 SJ2PR01MB8193.prod.exchangelabs.com (2603:10b6:a03:4f6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Fri, 13 Jan 2023 17:21:53 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 17:21:53 +0000
Message-ID: <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
Date:   Fri, 13 Jan 2023 12:21:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
In-Reply-To: <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|SJ2PR01MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 549aa0e5-f8f0-4685-a5de-08daf58aaa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhrEWEqWhjmyDgaTNTh7g9VhD9Ea9i59O+0lUVkcxneXkmC9Xxj2125BAYGVq7RlXiY68FRDKvzfMozdKMeqZIzYR3B087G+RP4Un4Mqjlxr0yFpMcGn6OT/zvED85t/OqETGQYqU7PYWGwXOEcPqIN7259JqYiNLkSIPHLSo+bACP/TkK5QdLnDpf7oK6Q75ZUFBVYn9qzgNFJnnM9dtDwDAlIoJufQHM0V3WEzWff4A0ynKZdHV+bsJ1WBZUZ8l6CFaNNGKkN562IYreVtkB4IImaSYKTfgk45HurfS4027XIAuJ4DeZT8wmeGm0j4mBFQ7keDkvgku6DSe3pLI3SsxLjcFxZGSX/wmdmWfVUkRG5w7um7t32Tk53zl2XBjjH7Vb8ibLq1cIXuuQfM4Xqz24IZ3kudPPyaS1RH8vD4/0QtjJmuf7avPi6Sih4UiGwLmFK0QGTecl+ygJcyB9eOQjRi9gJYmt7KnKIcvMfD8pNGQexpl0BbxdMM7slo8keUz6Vjv4dFmXbOn4KHT4s8br8W8fjKtqIOha4Q3wmp0hIJqhQRxNTtvJLRIzsEzAJwNBIlMFuhoEvs/J88Zesf1mIK/MBv+3+IYVsHnBbykYq0ffOwR0+v409nMxQ8I84yPo4G+zKd5G3XYdFr2r9BWaTnKmEjGxsP5LAOH4KXo7d0ah08ROgxHeZd/JM6mnQyUeRmeexudiJyViToxpdvgsGFrqaWHAgepIyjyFVjYxIW2/+T3WamTBG3kXxU/ivxP0Wv4QGhdaVti7aV0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39840400004)(396003)(451199015)(53546011)(6506007)(38100700002)(38350700002)(2906002)(31686004)(36756003)(186003)(6486002)(26005)(966005)(5660300002)(2616005)(44832011)(4744005)(478600001)(52116002)(316002)(6512007)(86362001)(83380400001)(41300700001)(8936002)(31696002)(4326008)(66476007)(8676002)(66946007)(66556008)(6916009)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNCZnZZdzlicGV1eTE5MWR2aGVqZmJ5dEpHcTJ4ZERSZm9HNGFEdUZWWmhM?=
 =?utf-8?B?aUxtWDl6SUxkYnpxYWFPdkFtSk5xcUQ5eDFYcUZNV0dnTlBmVFFoeTczaG02?=
 =?utf-8?B?bFJ3UFkrd1Y5Z2xpb1JwemJCd3RsV1RrZjlzalZYbmlaS3UwY0dxUmlxL2ps?=
 =?utf-8?B?ZGxSQ0Z5ODRveWt3R0FZOExwZTNXaUhGMVdRblp2RXROTDBnVUJXQnFHREM4?=
 =?utf-8?B?VE83T1h6bmkxWUN4SkQwc1ZqdGx4RUo3UWdLZzFhczdrcXZmSytRTkdjRC9n?=
 =?utf-8?B?bGd3a29CenZsNnQ5QkZlOUwvWnpKZkc2REdiTGUvODI3ZmF3UHV0dzNWN3dG?=
 =?utf-8?B?ZmUyaXlmdnU2aXJubk9VNWhoNVJkbU1XZmM2S3BPUnRjZnp0S2FpaFFQVEhz?=
 =?utf-8?B?UlhxSmZWaDd0bHpzVkY5Zk1XcVEyR082RTdtaTAwNFIyQ29vdHUzcjA1ZGNk?=
 =?utf-8?B?SmdyYWxmeWV3WENjNXpMYkpPeXlOUDFqdllWK0pBcXJMUjhiUDZDcUdEM1JM?=
 =?utf-8?B?NzJQU3dENGVXekVDaUxKdnphQ2FUTVpMSy9IUm5UNDY3VlpPaHE1aEdnb0tP?=
 =?utf-8?B?QnRtUWZoSFV4UEVqSUlGQnRiZnptemRIcTV5ejR3QnNDUGFML0tub3BPQnpl?=
 =?utf-8?B?WWlXS28rVWhVMjd1eUdCTUxkUTRjT05jZ2JrRktXWWpBMUpMVEFuV2sxNEhN?=
 =?utf-8?B?ZzFSREovZXVFUHRHQXlaOTFVeXVKSXYrb0poSUVST1FyT3c1QnpWQy9yOHZi?=
 =?utf-8?B?Ri83UUtXNUxPdlZvNTdyKzF3L1o1cDNsUzd3bHZ5eTNpeHVpY01HeUc4QnRS?=
 =?utf-8?B?YjhhZFJ1d3ZHdEV6bm5JancySXJtYVEwcDVEbm9HeHNIOFF4Mk9UdG14UFFU?=
 =?utf-8?B?R2xHZDlKNzlwWHBveXVXRVRpUVVOU3V1Nm9LNW5Ja0VKRGZ6cStsbWZlS1d5?=
 =?utf-8?B?QkZxaVNISy9EUUxSMmZJSnhGcXBCY0NmbTBLamhrbXhseXFNUXRCOWM4UlpL?=
 =?utf-8?B?UENDMDUvTWhUa1ZzaU9CaUt4b1ZjWjFBQk03azdkVEZxTHVwWVNpYXpHOVlx?=
 =?utf-8?B?NDBjMDZuZkg2dVpFMDVFb2lhekhsRytRamFIbzFGYVA3WkFPenltL0hKajFD?=
 =?utf-8?B?RVQ5Sy9iM1V2aGhzQjk0d0djNDVUS1JjSjIycFgxOFdQay9PVVpiWmt2Zmsz?=
 =?utf-8?B?SEhTSVJRMU1YOXEzTStzUXE0K1M0eVhtTU50ZUlXVEhVM1dmeERqZVB4eEg3?=
 =?utf-8?B?NkF3bzdZTmdvY3JIclZjTWtiQ1o1eTFrUzZGRDExTmNPMXphMDN6djBxTnNP?=
 =?utf-8?B?bUx6T3pwZXgzSnV1a2k4bTMrSDlHUmo1WVh2cFpDUkhqZHZVVDVBOFk2TGtp?=
 =?utf-8?B?M09paUUzUThrcHcrODhSeG5ma3UxM2NlWTRjQndiY1Y0elRqQW9wa3lTb2x2?=
 =?utf-8?B?R29nc3hGdnNFQmtQSlY2ZStJdS9iSWZtVHV6TWFXTXljTzZ2WGJocGJ0TTAv?=
 =?utf-8?B?Rm5WclN2c1NiN3lKYUhRcHFXOU1EUFBhUGRGd1VWNm01YUxRdmhvZWNTK1pq?=
 =?utf-8?B?R2hPWk1ZZkVXK3BFQXlCN1UrSUNVUVEydTRIUlBKUklyRTNXeGl2bWZSRWt5?=
 =?utf-8?B?STNzcUN5S3FRTC90OWNhM2FrWmJqWEZQM3hYVVg2V1QzOWdLNXVveStzZmQ1?=
 =?utf-8?B?ZUdMVmdSMGIzcFNIY2txVUN1NzI5S2Z6dGV4cHJzbE43ZkFZVjJCdXNHZU1E?=
 =?utf-8?B?K2ZjN1krRFpNOXNxYTFLMldUeUt2UXdXd1FHRU1CVGdhSUIzd0JVY2c5WVRl?=
 =?utf-8?B?UXBjNXczNGN0Z2RIZmUrUit2eUliTU1kUHllYUxyZDB1MURxZUFqdmlyRUZZ?=
 =?utf-8?B?Y1VORUtpRWtWTDRTckNrejYrWlpmOUpDNm0wT2gyZW0yOTFGZVMvVTRPZ2Rt?=
 =?utf-8?B?YWNqTVNsTDdXVnVIWjBLbVlIOVJMWjBYZWxKSkxIMGRuS3pjZGZXT09IeVho?=
 =?utf-8?B?M1haYk56ZmY0eWdsK2lqUlQxa3pGaXRDT1NabUJIVFRocUl3amlmWkQxU0Qv?=
 =?utf-8?B?TDRYUlplM2hxTExINUZyZys4bUhpUEFRWG9KZG9SdEo1eFJkTnhJUDNPeGpN?=
 =?utf-8?B?eXllQ05MVjFLWDJraHNXblQ1ZFNWeHJSVUJUc1ZyWUQ4bHNzSGVPbkFHN1Uy?=
 =?utf-8?Q?NKBSwZmuTBhYQfGIVurFjZY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549aa0e5-f8f0-4685-a5de-08daf58aaa1a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 17:21:53.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJvx607MmCFG2IIUbEgQtRMTxW6/qZZBsMoNyeZpOW0RKlJZ9+Z7XnTuJVraCk9E6N1n+JpwLOW1Y8KpOmQAU0of0+VqRJdqOqBrre8XDcKiPmjfBlAU0FEhbmdSmUWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/10/23 4:03 PM, Dennis Dalessandro wrote:
> On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
>> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
>>> Dean fixes the FIXME that was left by Jason in the code to use the interval
>>> notifier.
>>
>> ? Which patch did that?
> 
> My fault. The last patch in the previous series [1] was meant to go first here.
> I got off by 1 when I was splitting the patches out for submit.
> 
> [1]
> https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u

As a side effect of this, can we pull patch 2/7 from this series into the RC?

[PATCH for-next 2/7] IB/hfi1: Assign npages earlier

should go with:

[PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer invalidate race

-Denny
