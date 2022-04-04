Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878F94F1B84
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 23:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354274AbiDDVUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379503AbiDDRQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 13:16:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2105.outbound.protection.outlook.com [40.107.92.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4613F77;
        Mon,  4 Apr 2022 10:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3KWSJi8i39kNEXn9Mt7+CMS0kni/zH9aYL/hFnaY7ZDaCCmdswE8ItRZdK0TLUmp5iQwitvvhoY0Rf449xghX8yM/XlFu0OaHucxVC3RKh2CX+WYU2JnyMeCRWlf3O3uQj18jJOajYsaUZ8bGklUCgHAjAlpcvKKeUC5LyH9cdOrLU6yvnQG5GeQtBU/cVqL9Q47SdybF8A5U/QUw+I5RcvV0YJiVYfp/TJbiwvzCqGgPJbuFsp5NqIMeHaNV4mTo9t5o52ffOXr+edZONLnDuTgZ8G4dhq3mCGNWXEj8tw5lYZMqouPp0D4qx/LoCEEnJGTYKuDVMm8FqXBXoYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P9+yzcrOb7RRv18J7mcoDmo57+zBpBKXRPwRsZPGaE=;
 b=CgHzCC8i1YXosiMaRg5r7iWmkRx8dBNZTIb03NusSZ0gGl+akeCGMpTCCjZDC0J73+1T9XK1dLYWQdsvxlUUxK6AYbc2Wa3qRb60EeTn0WPZ2yRbQn5PBITwDK8btWMDWGxi4kZzHT0uoMb3xdraXn8644RyVt0V2dFWd3une5e/kHJN5Kq1+9JplF/tbn08nkLqS1LKLdsQWOVSRoQt3CzkTlJ/bGQcTUAaFKqD7pJ3FACm74F/qaXIfMd7zfEnfLf3AxYKiS5St85Zi6DYQ0HGTcWY20HCImjq3x4NwEUks9auzeTpidC5R1+fO6gDQI4nm4+P+eY/2xpiK3zE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P9+yzcrOb7RRv18J7mcoDmo57+zBpBKXRPwRsZPGaE=;
 b=HeEQ6meS7g9XDvXX5fossfsWwCnuEZVVOLbixZaP+vO+YWkEVeaUn3BZIdeOiHcYj9+yFM3AXR8EY5sa0eL5PTX2AfWdDjmlDBscRfwXT0R+kMU4OT+n6roggSSOPDviTEbQ6jbg4awYYM/TNp4ni3GZ57eES1cGfipUBHcxjGUaVcReuAT0I6Ng/T9xtlfG4cQBjrP2F2Csp0UlfZZfRDNwGRirpf53BNXfl8lbs0HEjC/wlep4pHMZuanLNl7dvgP56jpJBUDxeMX124KPWYbVxGldaoRUJbkHVe8pxQJYk1Ss9Ha389Ar+V2LI9dkLz8YAGVvMApuCuMnoapTYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BN6PR01MB2835.prod.exchangelabs.com (2603:10b6:404:d1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.16; Mon, 4 Apr 2022 17:14:54 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875])
 by PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875%6]) with
 mapi id 15.20.5123.031; Mon, 4 Apr 2022 17:14:54 +0000
Message-ID: <36cfda2f-f35a-c86e-4d65-76d0956a8c6a@cornelisnetworks.com>
Date:   Mon, 4 Apr 2022 13:14:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] IB/rdmavt: add lock to call to rvt_error_qp to prevent a
 race condition
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220228165330.41546-1-dossche.niels@gmail.com>
 <20220404134209.GA2905506@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220404134209.GA2905506@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::19) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b33ea2e-54ce-428e-d770-08da165ea2b2
X-MS-TrafficTypeDiagnostic: BN6PR01MB2835:EE_
X-Microsoft-Antispam-PRVS: <BN6PR01MB283512CFEA15A886A04726F2F4E59@BN6PR01MB2835.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7f7yyrL/iHyttywCy5PMYWmCWw866rs8zTzz9Ox7v1j3gF8HOBHnoZRRsisDo8R517l3p0dVz3z30DDJt4RjMT71nZd5MUA27HhstD8cALkG/blwMzqPjx3MnIq4HbawQM6O1q/9aftg2gj6+ScvwwRDRNlTZyMRBwzl1F21SoVQ7/GjqwFQDO/TdIWFKvjNEUI1GwANXvfVFX2ohLyph0St8H4UfiDyXgyVYqnRNBOV/04+6t0FM2O7wClj7kjgUIrfToZO748CpyO1M6/vGXIR45P7ETKHWh/R+X7O3JoRq9w6kOfttp5t6KpnWk7FdjRmQBnLPrFV3scQdsWfM8ADdBXRqF4b3ePLL2AONGmeltJROXhzBRjTTWJwkdZUXvmoKrBhG0Ev3SFrTfGZQIrLiXqDZAxww2TYFpU+NZ/C3oaPx/B7Lgq+hHA+Ssv9MnwvGyBUVNlF/YpoZNV/UqPeE0PB0tZMWzY9Nu5jXDx7N13nX713fWUtFRY/re1m16V71Dv4BbL+AG+T64bvjrQk7fsvFqO/dPM60Vo+ZZ5kt/O+fk/KzTv9ssn5TZe3t9IYiARtJ+qpl4QkuWHKfciknB0K9SoDQiJyP2sH8XxbCemyCaMWy8dlYEbV6GkKTumnR8MCP1exBLen9MWPuzwxK8kVD93m4woibCbszMoK6hmw9iAxV+23nTle5cfeteNbO6YGKUiKsoPIFATaCl0Rjo46pymezPZ2L1yixRY7Wr30yeqDzxXtovT3OnHziK8lmXfo2zAmDOd6ueCCgSXTGS47gCNELjmC4uJ7pwVEyyPCV4nb6wAxtSaJ/Uc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(366004)(39830400003)(396003)(8676002)(53546011)(52116002)(8936002)(66946007)(66556008)(83380400001)(6506007)(2616005)(44832011)(5660300002)(26005)(186003)(2906002)(4326008)(6512007)(66476007)(86362001)(38100700002)(38350700002)(31686004)(110136005)(508600001)(6666004)(6486002)(966005)(36756003)(31696002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FJS004N0J3aHdPbGhIQ0Y0ZzhlR0JsQ0NadVVibGZDWmlDS3dNYWUwMk9T?=
 =?utf-8?B?OWRzcllzZXBzYnE4SmM5VVQ4YWNqelQ5VWdxbE1kMnVndmYxUDNGaWR5M25x?=
 =?utf-8?B?YXN0aEw5bUZGeGk4dGFtTWZ3UTJjTUlBYmo3K0hCRU9aWG1oaGlEVlZNOXFn?=
 =?utf-8?B?OXA3c2pQU3IvQlV4YmI0eHBrUzZCdXZMWU5Za2NoWnluYU1yWUhFZ1JibDZ1?=
 =?utf-8?B?R3A1VDUvclhlUFVROGtXU3NYNWN2UzlnMWZLZmRsaXMvNG02NllZVU90blJv?=
 =?utf-8?B?cmNlUGNQMWlhVm03SmxaWGtLeXVTNEhpT01KK2VxNk1iak00d001N1dybVor?=
 =?utf-8?B?aWxwbWNBVGp2S1lmT2FSakdSKzdyL1MxWEphVlg0WXFzRHBxVjM3UThVS0pD?=
 =?utf-8?B?bUJTbFlvQmx0dndoSVprV2NXNXIzR1BqdlRMTDd2OWhXdUg1MDJ6NmphNWVq?=
 =?utf-8?B?UWtKZUhSa0hSSVBmWDRDclgyRlFNTzE5MUJDWE1OQkkyZ3Fsa2ZGRE1KSVZz?=
 =?utf-8?B?UjRRcGwwVUMwMWIwQmY4Y21hWDR4WjNpcXJ6akJxdzZSTFpqbDFJTThpK1NL?=
 =?utf-8?B?a01UNngxam9lSUFtTU52STZwOElnRWkrc24rUHN3ZWZWZG1IY051UEpJb2ZH?=
 =?utf-8?B?NWhNN08vWkpUWitPVXE0cW1PbkduZDR6U3BrZkdBNlo3ekxjVU9YWURYQkdx?=
 =?utf-8?B?YzBqUnB0Lzc2ejhSWkM2SnRHeXhrUEM1NjFzbUplcWliblJjZk1ZdWJCNTJv?=
 =?utf-8?B?cDhBaHZRaG5wakhaeVNYdkI3K0J3SnJ4bW5Qb0dGeExEdGQ3K2htR2p1cjVM?=
 =?utf-8?B?ZFBZUmZtQmhTUVljcTllZ1hoK0FvbmpEMjhFaGRod1kxemVNTms2QnJZYmdP?=
 =?utf-8?B?bHhwb1hyZHJhSUMxS09mMU8yNEhQSUFYc0k1S0pLNUNFdml2QlozQzYrbER2?=
 =?utf-8?B?UHQ1TWZvVmJiUmtRa21KMUVzaE9wbTNnckF5cGcwZVRyZXcxcE5Uc3EvZjE3?=
 =?utf-8?B?L3FrV3M5SVI2NFdZS094N0JGNEE5eEExS3ZwK0Q0cG9qRVlweWFmbG5yNlMr?=
 =?utf-8?B?ckdtMEl0Rmh1RXZhTEN4MFR0RHlZMXBGS2VWVEZldWdxUTM2VWQyZVg5NWlD?=
 =?utf-8?B?b005ZGxWQVlZandRR1JWU1hIWWNqTThBZTk2MytXWGZIVTY4ZStGeVVWdDJh?=
 =?utf-8?B?dWNOdENTb2Q1dWxKQ1hmVmo1T2pjaExUV2ZabWw5d0NtdVRuZFJwemRlV2Jr?=
 =?utf-8?B?OVlSNlM0NW9TRnY3NnJZMVF6L05CV2E3WmtMdHhoNnpWMWFyNUNvNlN1VXp2?=
 =?utf-8?B?NEE1M3pvRllsRGtYOERhTEFGbDEydm45eHVEWG5PT2VhaXJKYlRVUzJNRWRE?=
 =?utf-8?B?c1o0b3BucUVCNWU0ZlUrZXlINnROK1lQc2QrdkhCbTBKYWZqdG1BT2NyVW1t?=
 =?utf-8?B?WmNkcVErNVVuRCsyNjJBS0dNQWJoZ1l6VC9jdlVrekNEKzJJVDR4QlJHTGg3?=
 =?utf-8?B?eWgwSUZvcXZQaGhvd0M5TFhyQ1BSSkJRZmhrZGlnSmxzelZycG9ZOGRPSzU4?=
 =?utf-8?B?MmVXNDN3MS9IazQzQjV4ZGh2TjlaQ3IyaDQ5clNKYmd1TGpmM29oZGF6YWRR?=
 =?utf-8?B?UCtSYnRxZTNJUVJES3UwOFdvTXh3THFURU9Ub0lLaGMvbTVpMGt4WFN6TEhL?=
 =?utf-8?B?c3duWXJqSVZ2clZ1QVRJUUlCSWVMNmlKVldjRmNxMkpCME11SzR6cG51N1E3?=
 =?utf-8?B?bjM3QmZqZUxNMHBOcWxUcFA1dStidXRMaU04dUJqYzZ1NTZuZzlpSUNlOStn?=
 =?utf-8?B?dkxtRDlxOUcyRVJVWlJrWGkrM2hhbnM1OEhscUxtTmNRdTNxWGlpc0NmTURt?=
 =?utf-8?B?ckxsVzRhTVAwc1ZXam9yeHNVRjQ4WjJtNE9iS0RMS3Q2TXArTGkwaGhtWm9o?=
 =?utf-8?B?VklBR2QzV01FOUt6YkZUL1ZTV0tBSWptM0hXNWJUWVh0RGNLTko2NFF5dHUx?=
 =?utf-8?B?K01VZTY2L1JrdGNxUkFpanVoNGNlTTVDcG5HUWFRT2N4ZWFrWXFVNlB1Q1ZJ?=
 =?utf-8?B?WEUxVjFCdzBOYWxBWjBSN3FsT202bmRzN3k2blVwbmovOFpTTTVqdjhkSUU2?=
 =?utf-8?B?bWs5ZUJJbG1HbFVlRDloVHRVSWs4QmF4RnJIKzBpaEk4Mk9ZSngrR0s5bWpQ?=
 =?utf-8?B?aXFJL0dmQkM5b0FXOUtNMEphWWxHa0tjT2Exakk5dnlvbG83eWwvNnVaaTVy?=
 =?utf-8?B?RjYyV2d1QjFFQTFyOXlVdUtxQ1ByZ3dHZS9jMU9ybWFzb1NqbjNGMGhwQlNI?=
 =?utf-8?B?TzFmdUFwQ3BueTVuRVFOUHp2TEpLdEk3SE40ck8vcEZNRFpDcGdhdjNsaUtQ?=
 =?utf-8?Q?bRs4VLFzch/MYCXDO6h4UMSjv5K39wbG5fiyh?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b33ea2e-54ce-428e-d770-08da165ea2b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 17:14:54.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkWVbkA74XIDopc68Vz0/uDhtYJiRtWvpvqvkzCPCnQZlnHOhgl8VTgQy1xEdgOdTEvNc0WO6qQBChABBmbnWgT4nakRqd/gVZKfJPMgM05oj2TCBHXsHsoQEpTIgUy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2835
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/4/22 9:42 AM, Jason Gunthorpe wrote:
> On Mon, Feb 28, 2022 at 05:53:30PM +0100, Niels Dossche wrote:
>> The documentation of the function rvt_error_qp says both r_lock and
>> s_lock need to be held when calling that function.
>> It also asserts using lockdep that both of those locks are held.
>> However, the commit I referenced in Fixes accidentally makes the call
>> to rvt_error_qp in rvt_ruc_loopback no longer covered by r_lock.
>> This results in the lockdep assertion failing and also possibly in a
>> race condition.
>>
>> Fixes: d757c60eca9b ("IB/rdmavt: Fix concurrency panics in QP post_send and modify to error")
>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> ---
>>  drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Dennis?

For this one:

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

> And this too:
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/20220228195144.71946-1-dossche.niels@gmail.com/

I think is correct as well. Not thrilled with the lock, unlock, lock. Stuff, but
this whole unwind code needs a once-over so for this patch as well:

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Thanks Niels for finding and fixing these issues!

-Denny

