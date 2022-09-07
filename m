Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCA5B05D8
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIGN5t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIGN5s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 09:57:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6056A8CCA
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 06:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXLoVvmhRI+YyvOOD41QPTuUmvt3d3c7jfinF1yrbGZkVVwL+KZLyqN+RI+bSa1gdIhAyJbf/iD4TsQCWGFirYQJzLYUFSHXFR+Ul/nFfw9jhgCoZVdPuQxrqhZtQ8lZIcj4JXDAUoxD7x9cZPcdz3KZ4mbdEbXmG6C0sKIrrGp7e6Velgud9Y5LunVDcDkiDTdKVK9wq4cUaNF9hsB+CRw480L/Sk79teMrf8mX+rUgWY4SNAHRPncJ2rEaq3Vu5lrYE0hPMcXFpJcqLxbMC1JsLywcPa1AFzQN+7JPVIO5yA+DdS7p1olTUaXFZ0oA4y3DQW+KpAJfZBF6wrarDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfGWk0UlKr/06lG49iQGeUaXxXol0K/GUi6MIpZit10=;
 b=Pv/GyDZ7jQQhsn3186fSZWEoCw6GCNnHGovm9FtjgdGKALhaTvNkBIOHTBJOOq1mgS66alih315IPZa46VR39kXrzT4mPzjK/MJI9ro4uoYmo+uN3PDzIBSj43TSXVQkQ2LrzgLFPltPGNQGKJEff8tWnKDuZcA6D2PBxHlHcTdPTX3vBINwii+//7/X4mrTTx1ll9tu5sGEHXltI4cSTe3emAcN7G2fzBteFHL/6zb+puRC1iy+aWD6fkT6rChLSGBDGjCE50TNFsCY7udGOxB5U9rZG9X8L2wmi3gzdBP/QRwxsy3TMYAzDIXmMWrPE+zuJERLGic/+71EXfY6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM6PR01MB4282.prod.exchangelabs.com (2603:10b6:5:23::23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Wed, 7 Sep 2022 13:57:45 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 13:57:45 +0000
Message-ID: <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
Date:   Wed, 7 Sep 2022 09:57:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <Yxih3M3rym7Abt0P@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0449.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::34) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db14469-0672-484e-a29f-08da90d8f0ab
X-MS-TrafficTypeDiagnostic: DM6PR01MB4282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJiwQBsfDvxvbwEm5HyiU9Gjlfta/2OgwLYSu39mFEnMePpmbKZiWB6rFw8exWg35Sm4S+5ZZNo3YnUvhVlR9zlKXhGTwbz4nBk09JDTnqfVbcoJGgpStSNzF8jYwBb90oGWmyxYgA72H6AQgOhpkeh/Sel78RpfWCfaHGXolzmiqY4jOLHIHMB2kV3aAuOTFiJ/w9leQ36cciHAQF5ARQG9ZXTCBN6eRvKLIFi3ho/qQK1N7Czmio8dTWfYreIZTqC97kRyyv8rAzYgP8r2aGt6mlk38O8sr7nP3KZ7UT65NBsMeBTXeA054oNjEsIQO06eDX6nKoEYbxC9P8z/pE46xC2btbcAmeUDrGAHxvFkAecrtn2MuNMLFkFe9x0Bt/rnzY+jM16usizeC14brMfGAY7nXjP8sVUtR0mkFUIH3kV5Og+Y99KX1eHS8fVPD7aZ8t41RvbUAKkUl/hVL27tSTPJZdW9ee7Ti7i68nwqzAjmwQT1QT6fgqyjjiT4K+1VhUAyPa8BVAFpzFKp7vpmbTrBjHsYVcw0WBhDkEb77vOzCYrux1F7V01kiYRQYpC3HqJ/0RDD7ApsnPURuIYq9jxx57rFxt3vEChvsi6WDtcphYUD+4wKNMXNspMkIzCMbVaxRtTMZJ+Veiha0fILe3SE1QsUavYuq4YEA6cwcMC0idMhSaCBaQLFMyHoRDJcnkFpnNapz7oll/JOuRfGrtunGxHHzVdRVscXr1Q5aRnG+FlpYimD3oGmt6mQnT9IY/T5qr/pv2hsjnrrr0+g67pcxWqTIZQMJn6gwVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39830400003)(396003)(376002)(346002)(26005)(478600001)(8676002)(6506007)(66556008)(66946007)(66476007)(6512007)(2906002)(41300700001)(36756003)(86362001)(316002)(31696002)(4326008)(54906003)(52116002)(6916009)(53546011)(31686004)(6486002)(38100700002)(38350700002)(2616005)(83380400001)(186003)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FJaW5BNHJ4UStpY2xET1M5WDVJUmhoTElKOGd1ejNsWDl3LzMyaWtxeWgv?=
 =?utf-8?B?cmpvVjJZYVEwODMrcW9YK2VNcm9MSnp6WmU5dXVQRGRHbDBKTFluRk5ZU1ZR?=
 =?utf-8?B?Y2xVRUROaThmNGRVNVJ2MEZXRWxwWDYwMTJQbnRZNC83Y3JCblRkTUZ5cFhK?=
 =?utf-8?B?RFJaVEUzM0xpYmdNZXR1ZHZtT0Z0bDQwZWpJRzNuZG1OQ3BGZlVjbytCYVpZ?=
 =?utf-8?B?dEEvTUFUS3N1RnAvRnQ1NlZzMXJnZFF3QkVNcHJsQTFtTDBRZ00zMmViYi92?=
 =?utf-8?B?dm9qWEtlMU0zNHU1QXo2ZjhoU2J4YkE1SDQ0VnFHOTZYVFZWQmw5eVJhS2Fm?=
 =?utf-8?B?Q1dXbEtQbm85Zm9iM2NoWmxmUTBydjhzR0ZJejVadUFKb2E2L08rcC8yT3o0?=
 =?utf-8?B?YVIwT2VXQXByQkxrTnZjdS9Kb2FkcnBWTi9PYnNrQS9DN3lIVGZWNWVhcmtz?=
 =?utf-8?B?TEJ5K3h4NGdRT1o0NXV2aVJvNzhZbXFrV0hHY0JzS2xBRFYxVzBkSVBpRi9X?=
 =?utf-8?B?cHdaSXRMQ2xzbjRScy9QaEFrVzg2aUZWaEVIMWE5TkZCRU5uamJyUjU1V2po?=
 =?utf-8?B?eHhNQzRoMHVYNml3S1JOTDJRT2xEMVF1ZXpnZ0ZkUVM0L1N1dkhHSHk4VVFF?=
 =?utf-8?B?dktmTSsvVnhaallNN1QrWFozSW5sb0R1Tjh6QWZxSG9TWnJucDZmV3ZrZ3Nj?=
 =?utf-8?B?alhpSWpBMGdzTnFoWVFrNGJ0cDd1Qml4eHE1MFFrMGpHOFFncG9oeWd2R0V1?=
 =?utf-8?B?K2h1TmxJSnhiekdiVTF4MmRFb2VWc3ViWE5ac1FBMjdJVVEySSt3bE1HdVM3?=
 =?utf-8?B?dkdXaE9WdUlmZGdjdzRKZlJaeGkzVFJFUld6QzA0UkVRVE5HMXJWUkhYOGJI?=
 =?utf-8?B?WUg4S2V6UXozQmNqY3hGNWFhaURlVGovWm5CZjBFSG5hUFdlc0VyTXQvQnhG?=
 =?utf-8?B?eG41N3dTTVZrSEpINVlaeDFma3o3NFg2VFJaSUIxeTFXd24rYmxwMStxcHhL?=
 =?utf-8?B?ZkpHMGVkUUEvSGM3Uyt4Y25mNW9ZTWExUVdSb1FPSCtrVzM1K2VUdkxJeWNo?=
 =?utf-8?B?SjVrN1pSV2djRU5Ia3prR2JaWU5wbnQ1TnlJWTdlU2FyK1FORFdDdXNjV3VC?=
 =?utf-8?B?TzJoVElma0o0VUFDdW9UeVhVT2NNa1Q1Uy9HamJJRFFaQ3JNeTMxYjA0UUcy?=
 =?utf-8?B?bHhjR3FoRVF1TjRtcjhndTlHMWtPc1ZoaUw3NU5mcVd5ZEJqcU9KRGkweWdI?=
 =?utf-8?B?dmpZZWFLVVgwYXIvaFNwdklTeTJmbWxRaVkvUmswQjJ0MnNZc0dGcjBmUk1E?=
 =?utf-8?B?d0ZIdXRTZ21PMU13VnBKM05iTVNIdjlYSGRzSHJVTVJHeXZRL1QzUGc2V0Vl?=
 =?utf-8?B?TjdHRjcxL2JyMXFwUkJ1MlJnSlVNY3Y3Q3JtNzZMK3B1Z05pMmFBb05BclhL?=
 =?utf-8?B?WTA4aG9pTWpMampIVXpmMGMzQk9qeHlOaXYyV1FLdXFxeGhSUEdkbjdFSzg3?=
 =?utf-8?B?dGVpVnJDVkYrZDkzTXF2NFJFTi93Rkt4aGJHTkZjc2srVWpaK3l2N3RVMDVo?=
 =?utf-8?B?U2hSazhTbFVBd3BlMUs2TUg4OTI0dFRGTTNlK092NEN1WlorNlhiRW8wKzRs?=
 =?utf-8?B?eVRLZnFRNk51K0FzRGk3SWg3MDdFT05LcVkyemhUL3VObGdjNmJmSHA3S0lY?=
 =?utf-8?B?bEd6eEFkSjJoVHpDQzA3MFkwaThLZjRkbHJLNVpncmZYNU1kRjB0S25xNFQ1?=
 =?utf-8?B?WngzQTUrbUZFb1dLSUtZa21JSDF4VEI2WThpNVZLMnRta042czlmNzIrdy9F?=
 =?utf-8?B?bGc2WGJoVnpkb0dYcTdBUWJEeHhVOFQ0S1NEYUovWE5mS201bUt0UUVyOVF2?=
 =?utf-8?B?T25RUUpHTm5BQjNGMnVYZnkxc0tVdVFUWU9HRG5tQktvVHZkQ21uZjBQT3R3?=
 =?utf-8?B?ZmRKS2tGUTRwNVNGeHpEQ0ZvbEVGa2NUbStaNkdYcFNNcmp2a1JKY0hrb0FP?=
 =?utf-8?B?cGhOQ2hIYkJWM09qdTJsSFMxeUlPb1VyRFU2aXZnQnR3cWUvNW5QMlNPdHFz?=
 =?utf-8?B?dkdhRnNNeWpjNjI5eDZOcGxMY0NucEF4a2hkb3VZcWdCRWYwTzlscmVVZWw2?=
 =?utf-8?Q?jrKCDjNYTge5dL0hzttNYJtRT?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db14469-0672-484e-a29f-08da90d8f0ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 13:57:45.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuAzoQ0bPB+PhXDtcgdZVp+qLNxioen+Dx7I7jm+B8Vm+sUqeOPOXyvMTlXN8LEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4282
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/2022 9:51 AM, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 09:45:07AM -0400, Tom Talpey wrote:
>> When loading the siw module, ib_uverbs is needed so that consumers may
>> access it. However, siw references only inline functions in ib_uverbs.h,
>> so the kernel linker can not detect this, and the module is not loaded
>> automatically. Add a module dependency to ensure ib_uverbs is present.
> 
> No, that is not how things work.
> 
> Modern rdma-core will auto-load uverbs when something uses it, we
> shouldn't have things like this.

But, it doesn't, for the reason stated - siw only consumes
inline functions from ib_uverbs.h, and the kernel linker has
no clue.

You can test it easily, just load siw on a laptop without any
other RDMA provider. The ib_uverbs module will not be loaded,
and the siw provider won't be seen, rping -s will run but peers
cannot connect for example.

My workaround has been to add a modprobe.d file, but it's a
hack and very non-obvious. Is there a simpler way to allow
ib_uverbs to be auto-loaded for siw?

Tom.
