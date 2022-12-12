Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526064A2CD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiLLOGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 09:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiLLOGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 09:06:14 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67193E082
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 06:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9iN09qa7QNDFWGluNOcczQeGMf70jjzOnCcaCh0gOQeXP6gIbIPnZ3n45bf/mONO7RXyBXzpLRtQCxk2jWMUp5Cy7XBEXYyOV0r7DoyHzS2gI+kcUFIgchYuXDZWRkX4ANyG2AtTbtw3EwM7hSpfU4gESH2vBYhvQzEo2TN6XY+Yc3UFym8CO0M0l6po0TZUlI9ajrqea9hrvaw8jxIiRi0nNpnFZCZ5jGXy3yIhH0olROugHZ50kLspR7V1r5LMkbPDcqLcQe4HNZta7Moj3U3Kbs92+Et/k/vzE9Xa+d6EPPgbh6OCD9jj0hGw4xIoS7rW6slW2pj1SndAmSQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K+y5zHnIO0iaRC9OGRJNLigZ2O4oXtjMYOsE2w7p8Y=;
 b=F5qoJN0jpA0FmhRhBmKXQPkFdjDKiCLnl9NDLoi8r+Ulh8n68IVi+Pxm0WPVBgKLA4ybmRuMovzFS3ilTYhDbQ5NpcB040fCG9ykzeYZ0ksW/7o7sf6TiGlvANwBnT+FT96U2Vw3PsYzfI2Akej9OKPX0jgGuE+HhAqjVe09uS7G6qKGXtzt16slO3nqbMIZK/gxmurlOGfsItATCcPZFcGTf1FAf0wDvp5dveh/8kpLhtYzSpom/yP/AndiScg9X6JXyaK93ntoMt3cGDeKP89w3CEsIUbW9eFd1LV1FiqbkC01+u9Z9lvFsGdFlscuKjzadvpnsDwUeskjGpFc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K+y5zHnIO0iaRC9OGRJNLigZ2O4oXtjMYOsE2w7p8Y=;
 b=nT9kBiKOlLNzdEdXnQ+BGTmyIie637Tzym0NB2kCmAWMm07JswyVnLGnk2uPdsd7hcZybO0vdzwvrkN2nleLPb8ePKVc05uBFsHEyFmumtoG0BrrRv+9oDSg2TyixRdL2SWFqnan7UhFG5Zy103TOixWP0VOTD0TGHGji0Ho9jyHtFqmdKFAYJE1PhNVmoSXXE6DpTRYOZkKwoWdlLZydQjfqDbRBQ7J73XxnvbGKUjvSoEzjt92z6nr/m4bSJ1yHWJ8znaFqCxqvVld/FIn767Ji9PZoLde/eo8FquODwqTjaOQqRp/oCxbbq2U8z6cqe9HbxfLkLxds23a4tcc8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 14:06:11 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96%9]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 14:06:10 +0000
Message-ID: <486d8fe0-96ff-a670-7bf5-be04cafbaedf@nvidia.com>
Date:   Mon, 12 Dec 2022 16:06:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
 <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
 <Y5cv+z6cYWUV3ara@nvidia.com>
 <1a852181-8b9f-5f30-2c4a-fb3cb79802af@nvidia.com>
 <Y5cz4hYrK8EqgN0h@nvidia.com>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <Y5cz4hYrK8EqgN0h@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: beba5bed-83d2-4d8b-00e4-08dadc4a057e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgkeOoDBwJiJV3Sz7w06E/CPxEESHCj6wB11MZejS0yHaLZz6vCeHF3D5/CVd7B0l6jjqms86SWbRGbf+BF55TlYJoLsIEiIR7SRjYfGJTSDgFP8rAsJwyPQfl+i7eqFrUbRWN8JxhfEk8WaEf9WWvaCT7qdgh+jVkyl+y9UC5vJTKqXOM24AzNnFx6maaDJlMUu8xNl1KKPcmNhzILYhu1EsnX1DpkQhn/IakLtvJAT/bju0mFe2DcPsOdpxS7BMIeNNYrvs47TEfbUxJX4Bddk00rjqELRZU+B6PneSTvwW00Uotlt2Sy+5SpaIBeysVM15nhJqaBU+7AXToM9mjiawMO9aEtimOjJQny1guhjHfaPDWRSKSwy1P/GEemL6grlMxLOrNWfg55nqCnO2EBc0XEXiW5lIB+cqH0PFMURAyBauVBKIcvr+U7OuvvqmDwHaoGEJzAefBrJxYNrv6YOQMEgpwEXR4e5A4xVzd1PjQjjRhdyaoPhzjL8osZK0MOWl5Elk3nRzalo2e2EceZEiI0nl3ISfnNFZvU3XOvaQTWhYW/LRht635Hm+0SVFtnxQqva08Z1VuRkLraKjAmqfPdYTchmrFkaGvZ9+u41GJiy3yeCaWGlExng5MNSSnP0hgi3m0egMylOEQWVITdSnsM6glrhc+Y32m5ywxWLYT9+wCiENWsxQVw+SHUYMAGOr7dc5P0TrntLmhuVFkU9G6Kze1W1sAe+3Oh/358=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(8676002)(31696002)(83380400001)(86362001)(38100700002)(2906002)(66556008)(5660300002)(8936002)(4326008)(4744005)(66476007)(66946007)(41300700001)(26005)(6506007)(6666004)(6512007)(53546011)(2616005)(37006003)(6486002)(478600001)(186003)(54906003)(6636002)(6862004)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVVdlhSSGZSaHRhZnFuYTRyR1g4QzBYV2hVa1lRSkpCVHdTWmhSUDJjZUtF?=
 =?utf-8?B?cE0wR3dncEV5a0ora1dqdTZ3RGxseDFSd1VWNm9BK05yam5QcXJROGJwR3B4?=
 =?utf-8?B?R3dWcCtlbDllOXVhaHNvb3J0ZUpPaitNSHZJTzIveVNZRm1hRG1GaWRxZm5n?=
 =?utf-8?B?YWsxN2lhYVpnUUd1RVJia1NoQ1E5TW00dXdiQUNOZjRQR1JjN0lMSVI1ZFVn?=
 =?utf-8?B?WFFDMzcvWWpmSXBCRDJhOW84bUhvbHIwUy9rNUM4bktXYTlsYndTNnlzZjN6?=
 =?utf-8?B?Zy9TUTdhdzBHTUNOdGpoU3VPd1E5cmIyeVd4dW8wV0xSYUNqS2xlZVlxTlFl?=
 =?utf-8?B?UlkxWjJweFZCbWhmeGVTY3ZCY296N3cvNWRncjN1ZXhvcmphYXk0b3JaZC9s?=
 =?utf-8?B?TTd6cGhOQVl6UEFqcVN5Z1hrUTFQaTBWTXoxOWg4eXRobUhrWWtzRHo4UW1y?=
 =?utf-8?B?QTNZbnFpTzBESm01UlllTVh4d2prWG55b0U2QUVFVlY2d2RBaldaZnBqK1E3?=
 =?utf-8?B?UTJhanNkRmRON2lHYlZwQiswNGF5QUJaSkxLMm02elAzMU9VeVA3MzhYbUlu?=
 =?utf-8?B?RHNaVHFNWW9uWkovZWpKZmRGajFaSXBlcG9tV2k3aHNTSDAvK0VJc1BxL01G?=
 =?utf-8?B?VU9aUGhkYXk4TUx3Y3JGZmliV0NMQkR0SWN4WUFGc3ByazF6OExrbTQ5NW9S?=
 =?utf-8?B?cThmYkdURXlJSE1IaXVya1R1M1ZvMnBtRXpOY0p3VEFrQ2pZVzg1TTVqbFAy?=
 =?utf-8?B?RjZpSTQ0dndzNzNOVnlsLzl1SHdXalk5TlJLalBtcWpRcnZsaFVCcVNobWUr?=
 =?utf-8?B?UWthYXNOeVFQa01jaXkySjFDbmI3RG0vZ1pPSzFtMjFrN3dKR3RaKys5NW1z?=
 =?utf-8?B?cUhGUFRldWZ6YkNpaExrejladmxXemMreVkxaWhXVzJQVFZVeEV4YWZSa3VW?=
 =?utf-8?B?cTJHcWMxSk56RHdOeVRSZ3NySldibEk4NWVvWll1NlZMYTlRWVAzRkJGMkFl?=
 =?utf-8?B?Mjczc3FUT1JsMWhyVFVMYnlJRTJYa0lnbi9uSWsveW5QQTFmQmhFM1NjM25X?=
 =?utf-8?B?aDZySGJ2d2c5UFVoYVR0ODF5bnF4cWFuL1BXb1VwdEJ1Nis1MHdxZCtFeFVK?=
 =?utf-8?B?SlZyMWszUkRuWVplZk9WYjRzWGdaZHJlUjQxdzh6aXN1c0Z0ZzRUK3RvUFdW?=
 =?utf-8?B?NGZMU3BRWTh5a01WSjFuQnBTMEhmMDdIRW5zT2FsdFBLV1JIVVNJNC9LV0VO?=
 =?utf-8?B?bWVjcFhxUVN1dGJzRDlmdzFNSHlXcXdWK05WVGtmOUJta0JsUzZXdy92TVJG?=
 =?utf-8?B?MnpWS00rWmxBVWtNd0RkK2FkNUVpNU01Q0pucERVMktlV3U4RE9jbmFpU3Nh?=
 =?utf-8?B?bWMycnM5YllpSmJnWXhVVVFhc3lGODZ3d1NYeWxWbk1jcEV1OVpyVE50NkZD?=
 =?utf-8?B?VGl1QlJKbmlQYURxeW9CcjIvcjl5NURJblFQVng1REtOR2k2M1pES0RrcW9l?=
 =?utf-8?B?WGtaWE1NY3c4SnM1UkREekdleGhXa0lUd3BBcjIxaG9KOFRiMjJMeVE4UVlW?=
 =?utf-8?B?VHBOc1lSNTBrTzVWdXRuQVh2dFE2RTVMQ0FKNU9vQjFkV0RDcFVnanJ0S2do?=
 =?utf-8?B?SWFmRmxQK09vTGNmUG4xYkZhb1dxSCtpL29WbmZadEpKbm9uZmIwMFU5TWxN?=
 =?utf-8?B?cVpEYkNIbVZiQjRWZUdRKzJwWEtOU0dGOHArYzFsYmdkZGxvSlVNSFB6TWZT?=
 =?utf-8?B?Q25yQlFkRFN1a01ZRFR0MUhFejJ0UjFZdG5NRHF0TXVGUjNMRldzQW01dk9P?=
 =?utf-8?B?eXlHSkRVN2UrZ0JTNUpnRjFGNnJFajRFcXZEMkdzWVhjOFRNSmZEK3hEcUpK?=
 =?utf-8?B?OHhhSXRNZUZ5VXNOTnRYY1ZBODVyclhIQVJsc0xuZUlvenh0QVVQSnA1RGF2?=
 =?utf-8?B?cWF1U1BFSHJzWXB5ZmYwZDBrVVZwQXA4Ky9xYzRNWk1YeVZiUElnZko0QXRn?=
 =?utf-8?B?UmRKUUkrRzRnQzVvZGUwNWFzbm5yMnJ5R1dUN0N6RjFzVWVTVkorcThvdVJ1?=
 =?utf-8?B?YXl6bXNkdklPdlU2YXZBckdBYzlrVjN0cTZqenhLQ2pOazJ3ZlgxR1hRT1g1?=
 =?utf-8?Q?ULwPb2SfUfllA8A4V64bgc5mS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba5bed-83d2-4d8b-00e4-08dadc4a057e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 14:06:10.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0G/D8biQFedlmGh/SSd4fWzgPBNM2HnYeKMi8dfx8KvuwSGnSoPitdDdh17fjc0pVmlIzk5hmd/66J4vQeLqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Btw there is the easy ugly fix obviously, which would be this patch + 
locking this function with the tree spin-lock(to avoid any race).

I'll check however if there is hope for a better possible design for 
this function.

On 12/12/2022 16:00, Jason Gunthorpe wrote:
> On Mon, Dec 12, 2022 at 03:55:37PM +0200, Patrisious Haddad wrote:
>> Agree, but changing the control flow of this function is really problematic
>> , it was even tried before if you remember commit "e4103312d7b7a" , it got
>> something to do with port allocation, I'll take another look over the code
>> to see what other options we have though.
> 
> Yes, we've changed this function many times because it is badly
> mis-designed
> 
> Jason
