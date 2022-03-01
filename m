Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928684C90E4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiCAQuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 11:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiCAQuC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 11:50:02 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE240E63
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 08:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU2rDXZ/3MOAOQy4+M4XgBA+NDfXQeRzZWVGeDD3QIMre0tmzqS6JA0m1RDayMIrLdL5MV5gX/AWi5NkFqlBCKVvddltP51+JmdPw1R916AjroUZZaQkQ6vDec7abng5VSACnTqmUJVEIXGoUAj/3wWlZQVUTBqTKoxngrSjbhO8cTOkmp35psTsZF40fBxc47nootdzG4/o9wZkETVICqeHWvd7lWxmohJDIeg2C9u4jBEYNkfID558V4I4BKB0Gfz/2r8Pb/KITtrz5R0ohPlmAyBFA+8SgaBTLFvqDbyMqzfx634rQFE7ntm0DYULEJ/fnvezapD6HYxxICEh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owQNwLvP3ixXxe9Rw2Uw6ro29Tb1GgRqsaFmBZPJuwg=;
 b=WHdv9d9VnFGXgAVUkGPLnFIPWQvtUrIhsygcoV5PNCOk64zpNYAKny5oipeLz/Mz9PJpiuXQORL0C/7bKKZWVKzCDY5f/l7Ub3I3ji0ndCRqgSeUCxCpQrRLL7SfQg3LqcZGQ4EqLSQrwFgDP3I6+hsr+zaj8AV08l3bYp4KRbRjoWA9Hl/nWEqxdFmV/x+sCvDy1mC9WWwqk+W4iKCfQ09xnCQwOwhCCJY9b6u4TWeB5hPXb2D/+hbXxlIGKBM9xsqoeJwNgeUk3b9Jky1tEaEZqSGZJ0rj3MHPAUZ3CxEbQsbE9XIrzbsplO+OrbhqoDnsOR76x/BWdwU+Cq01pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owQNwLvP3ixXxe9Rw2Uw6ro29Tb1GgRqsaFmBZPJuwg=;
 b=NSZCN0+TdlkJXasJp0EJ6+0HQ6rKRtP1okJAucEEEdeIMGMxW+LZa3GuW5pYtRA+aT0yGcdHAlrSFZvHgY0vK3Xsxt/Axl5eO9rOfGAniBWqxd9kSAf/YlttW7pRPi9D2N1FgNoViZMFx9/qahM7YlmOgdHcCl0jrVN24C2Yx5N95jZgahrvQZHEchpQEET5hJjZga5P5FnMIJpLKnhXKpXtbWZwH9c4yxhCWV8W8eK3kR9ruN7zthWLG2/PdukFF2t3biTljA9o6mb0wrv2BVQib4OjDU9HvT97lO+dAxcUmwrZaTrr4DbzAabtlomoqduICpc7QdE94sUx9u3H3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BN6PR0101MB3172.prod.exchangelabs.com (2603:10b6:405:2c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Tue, 1 Mar 2022 16:49:13 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 16:49:12 +0000
Message-ID: <42673e10-e828-fd6c-b098-2638cac6bea9@cornelisnetworks.com>
Date:   Tue, 1 Mar 2022 11:49:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH for-rc] IB/hfi1: Allow larger MTU without AIP
Content-Language: en-US
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:2d::15) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c33c814-e56a-4d7a-b500-08d9fba369e8
X-MS-TrafficTypeDiagnostic: BN6PR0101MB3172:EE_
X-Microsoft-Antispam-PRVS: <BN6PR0101MB3172EA75326BE3AFA7579E03F4029@BN6PR0101MB3172.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84hCDtxFYFiwejdNd3cLBpJxcc3DEQG+/fK0AWlAHM8XZs+GMG5clzcas2iAImc+W2IvwoxPo3xdaEL/UiX04miP09phFJtHFdN2teBN3bqctlLwcvoy1ZpJRAbO6gSxpIaRuDu/UXNh6T+NA4t8OerLkHVbB2WoVkkRe1ZwZFlJaJfJjTmrTRvzthFeZwBmlK1ouWHJzQAlEf56Wla6uT4aVxHuq3VxqWNGJeAYOV3iVwbTESY1+gSGjOslv5c7JTTCdEYzwap6YWMy/PgxlAd4QmeFEkhD5WrBOctZtjdBZsE66GG8YFctE8/mwvVmaoO0MehA/ctU1t1vaU6NOnQuG6cWuBw4h2M0L+fIT5zejPKmI/FG4wlGfnx33+K80KXHUr8YXPftGmxbRFb2zyNkQS8DMRsvp2y7oxK0b0J96EziXFV8KwbIiQCrBZNZXWUH2HPrshHJbwW+ZTHqu13Wv4bn+1Y+zrUNjLjExxTQjEbMGp54J3LdYHtnR7y2645rqzUc4GnJcsq4U1bFn2a/X70VhCZBo5Bm8y2G165Ub3qg/a2fPXqb4Puap+FTO9ZOAwLN0YVr0Vy7LneUGaxyR8L4weZgopABBmhHA8pB8KmtmKpaZVZYVVmWPBKiFDJARw4qIf0/zZCnvSdDNiB6l/hoWXiSfa6fmg9qKVecyTnvsl/iBZO8trz58Asn/ao7F0dvdEAOxMwkJzQbIwlUupV0oy+apr8Y7GjmWwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(136003)(39840400004)(376002)(396003)(366004)(2906002)(316002)(31696002)(6512007)(36756003)(26005)(2616005)(6916009)(186003)(8936002)(6486002)(44832011)(5660300002)(508600001)(86362001)(53546011)(52116002)(31686004)(66476007)(66556008)(6506007)(6666004)(66946007)(38100700002)(38350700002)(4326008)(8676002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHFYTU54U0htMDJmOUExZ09Kbm9ZY0l3T1RTaFh1L1grUDB2SUM1WDdRMG5i?=
 =?utf-8?B?aE5HL2F1eHlwYjNJSXJ5TndKbEZmcDlUWDkwOVFUdUM3QWdhNDJHcVFQcTlN?=
 =?utf-8?B?bTUrMStFM1AreWJyMVRpWS9ZMk1SSzNGQ09LSFMyT3FaTFMrQjJwVUdNVng4?=
 =?utf-8?B?RjkvN0FlTXJKUWhKV0xkbmlYLzNPcUdQM3JBZ0NvS0VQSkFnYjE1dVBlZDlm?=
 =?utf-8?B?WkRTRnE1SkIrWW1lZ1NvQjJPcGtCVXNKUm4zNGFQSFZtS0ErRk5YZmx6WEpI?=
 =?utf-8?B?VFF4U1dDY0wyQldualdlUEdrbzVvSi9nc2NzZGkyUGJrWGhXMk16QStLYWFz?=
 =?utf-8?B?WW9QeUNZNkg1WjFQb0lVaUsxWWlmL3dNZWtPTkExZUN4MmppemVUdGsvNUdY?=
 =?utf-8?B?Z05FWlM1ZVNidFFoOFRKOFMxaVduK1FsV1c1VjlRUC9ZdXpzN1ArTjUrNGxS?=
 =?utf-8?B?V2ZEVDF0ZjhyN2FDNlNldTJnOE5MdC9SbUNaSks0U0lvWkdlbGhzSmJDK1lr?=
 =?utf-8?B?dXJacU8zZE9tcGtiMERreEZIYnA2KzFxV25HeVF0MGlEQ1BHbDZYa0FaTzFS?=
 =?utf-8?B?TkZOY2xGUEVWT3ZkUFVtY0FtRGxWYjVBa1A0dEExZ1Fuby9FdXBYSTJ5SlFX?=
 =?utf-8?B?cTQwVUwxYWdINXAyQk5VeU9TYS9rdkYvblRHbjJSeXdJQ3RYdUE4OXQ4YzFy?=
 =?utf-8?B?MEdTSmJvWFVneVhCL1VMclh6b1B6cVZ3bXZhR3l6cVBoMENKVldpcFFHeXQ3?=
 =?utf-8?B?VjFTQmdyNGNsUzNFRjVndTBFbCt1eklQUXFSdU1jSWhRbFBqbG5HOHlqb2xF?=
 =?utf-8?B?TVBjS2xyckhpa0w1VHNSRThGWndNWENlUElNS0dZRGs2bW16ODZrZXBWSndM?=
 =?utf-8?B?RFpxYWMybysrd2JqdEh0MnFha3ZPS2syRGZlQVllUnBiRS9rdmUrUGF1OTNs?=
 =?utf-8?B?a3dYR09qekw4UTJWZ3lqWlptZVdpcEdCSXBhMGZxR1lWM2xic2RLSWNRSUxp?=
 =?utf-8?B?eUxMZE94TGtQTHZTZUYwQ1lqdVMrS0FGTTh6dklEbVpQSGlROG5FSFNiVWFN?=
 =?utf-8?B?YStVTlJ2N2UzamRrVGtvdzFvUTQzU3RNTFN1Tko0Ukt0Z1pIS052QUorelFn?=
 =?utf-8?B?Uk1TUnYyS2RXTUZQanByOVc2VTljdUxwdnNqM3VDb3FnVmFOVVVIMmVjVWls?=
 =?utf-8?B?WXBMemhFQlJ2LzFpVlJCTWpQVkIzcTNWL21BbGw4dmh0dU1Kb3JxWnBQSjdv?=
 =?utf-8?B?and6aElwWUY4QXhWM0wzSHNzeWFhNFVwNmZOT1RoVitFV3BQL2I2STFmMlpB?=
 =?utf-8?B?MmV0RGREQ282QXgrSDRLaGEvdmx2bXQvNCtEeTZZa0M1QXJlWUJKTVlTZ0d1?=
 =?utf-8?B?eW9GbHdVeUczY0VGNS9IVDlDd3lydnhyeGdpNnJwRGZkUWUzbFpMb2Z3UWZB?=
 =?utf-8?B?VGdIaHZLd2grMjUvanFwNmlQb1ZWSGZ1Sis0UTQvOVdYSnhhMmZsTzZ0OHUz?=
 =?utf-8?B?WDNySVhSdTVUSGtJakpiQ0xOSDBiVzRTeVVrRjdBUlI4aFlFd1FoUm9iTWxS?=
 =?utf-8?B?NWRkTWFyeWI5VWdQOGxWTFVNS3Npb1VjUm02VWloY0NHSG1mYlgvV1RFR25j?=
 =?utf-8?B?VkhQVUJEUHFGOW5CY0xpYXZSOGVpeWhONytxMnRtUklnMkVtV2RmUTMzUzlu?=
 =?utf-8?B?REEzNzhWelh2STcwNkovNVV5KytNS0QvbmZRTHVhQzVCQWJKQVBTVW0wbE1r?=
 =?utf-8?B?SmV4b3hkcWVmTGNYbFVxTDYxZE5EQUhnZkNhVEJPK0pIZlNOVGxBZitGekZD?=
 =?utf-8?B?Wk5uTUhuK0Z1LzFzUmpvUXhTS3BqMlNFMzdqOGhSZmJnc09wZUJXOTh1REFN?=
 =?utf-8?B?Z09RUkxDampQakJEM3FDN3RhSEVSZkY3Qk0xeU5hVFBpeWZaRE9YOFA4ektZ?=
 =?utf-8?B?MVp1Q2EvN2V3dmdJdktUb1RwTUdUV2RQcHZrbWRiamxNcmxXMXI3S0p5Q0VW?=
 =?utf-8?B?Ri82Z1grNXZDSXRzMS9qWnRUVlVVcU5BU0tsM3hSelJHbGU5MU52eUY3WWkx?=
 =?utf-8?B?OUhzUnFJWGJjc1lOVVdsb3c4SkpsdWpTdTVqYllIckgrS3QwMEZ1cTRBZFpv?=
 =?utf-8?B?dzNhTjVlbXVkOWNmUExPR25YTmFsOVk5NjE2ZFYvanZhOHpJWDhETkJYSUNB?=
 =?utf-8?B?Z2RWYjhaSHBIdG5BSVZPQU50WkFuU0ZtQ0EraEFhbWplb1FsL3NlbWVjQ3Uy?=
 =?utf-8?B?QW9ZbFFYNmZHUEZ3ZXBsNU5SRkVpNUdMc1JEeU8wckVUajgwcW4vajV1WTZV?=
 =?utf-8?B?NzFSM09lc1RNZFBaQlVaNE9jd3dWYUZUbXdnbE1oSUZZRkp3SFdqdz09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c33c814-e56a-4d7a-b500-08d9fba369e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 16:49:12.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIu3tsx88bihmjqgGBdvjV/4CRFgpljLQW57W1WRoxPBP2OqvC96oy3yrvwhBg4oBNGl+zIUeNdxvdM4lrmDTdB3L42UCda2FN1Syq/yP/x9F04knlnfnxS/ZoJzUfvh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR0101MB3172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/8/22 2:25 PM, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The AIP code signals the phys_mtu in the following query_port()
> fragment:
> 
> 	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> 				ib_mtu_enum_to_int(props->max_mtu);
> 
> Using the largest MTU possible should not depend on AIP.
> 
> Fix by unconditionally using the hfi1_max_mtu value.
> 
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/verbs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index dc9211f..99d0743 100644
> --- a/drivers/infiniband/hw/hfi1/verbs.c
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -1397,8 +1397,7 @@ static int query_port(struct rvt_dev_info *rdi, u32 port_num,
>  				      4096 : hfi1_max_mtu), IB_MTU_4096);
>  	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
>  		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
> -	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> -				ib_mtu_enum_to_int(props->max_mtu);
> +	props->phys_mtu = hfi1_max_mtu;
>  
>  	return 0;
>  }

Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")

Can this just get queued up for-next or should I resubmit with the fixes line above?

-Denny
