Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE493661F37
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjAIHaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 02:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAIH37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 02:29:59 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326F12A89
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 23:29:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj7ZLOu5ke5Gr/S9t516BdrI9GA0nUfhs5oW6Gkvp9PYs//fGfg8DGZar4qu+nN2MmBJEcNhffJS6jrG+izsijyOJhwvdmJCxJq1aYNk+2nXxLxL4RF11cobSJJOX9p82G0ZLvWZB+oZAghDxUb9fQNCWtqYGjtDb78yl3MvaQD5EXw9uAkikpqo9V+vspeRtWXAh12MI3V/U0axwK5XCnDE55+qyRFph1F6X0VhiHBaYez739+43xYm/yyToTJQ8BYN70pZ2nXqcil0Gjp2xnagm6oIDcoXaUwF+zH4qRpYV4p+/OE3qa//5YbJ5PovJ8zgw2rU/v0hA8NepR77fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrwtDn2WCX1kCiEXDBhiy5WnVi+gZ4oSdsZkSLgIuEE=;
 b=WhSmQqP/yrHHkasp+MubDEP/VsieqL5XiS0ayJLWJDjPiC9rm9HhYN5QpGVad4m91jk4Q4zYAHuKeJFl4KuqtPcc+xxhdMCNiOICuLjyzCUJenTUUTmVfMeA96Oe0bvvL4zQF9eOM/GpBfpn807L6XT2bSZBrCLWZPne70PWBnryS0yUC7rCjO1vBiRHXCmIbuQ1UO2sIoC+qSVCRhK6EHq3Ze7WTVlltnlCZ5SrVXZrqEqnMRcmA37V41RemBFmojXo2Fx9DyD9GEcyH2VYUTj709R7/PJqh3e97htpihrMtwLHE09fWAv3QOnQho0WJBN5aoQdporJkPjaLsvFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrwtDn2WCX1kCiEXDBhiy5WnVi+gZ4oSdsZkSLgIuEE=;
 b=Bo9JMCCsZ4HdP6bulWiRTa/lW4IFiA1TVqprijPhKN8IvRWfDc29uxtLExfK5KaN3SMZO6OTaFj2SgIu4jr3Lf2qQm61B211eR9auCjV7481gXVcSSnW4nR8IcVf+xxzzgdPiDVLX+nCfWc3d3JG4dOLtJRlFTRKRumhdr+LOF9ufW+ELdA3t//P1DCa8jFv+YlozaRcVpdSl5zX21hInktaiB+Ph8RhTp+KdDvdeO+FPFKes7chS2l3hRuVnCr5tqkrSjFjTIR9UWy/iqlp/vU1ps61MQhNZUyxcIWN3q2PcDuYtsvu2aly8dKmCQr7rpnB+Y2yOIqp8ARDeINHAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:29:56 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::3970:b84d:7db2:f789]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::3970:b84d:7db2:f789%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:29:56 +0000
Message-ID: <719a7efe-e94e-b910-1935-ed3a3e42390c@nvidia.com>
Date:   Mon, 9 Jan 2023 15:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: rdma_create_qp_ex fails with EINVAL
Content-Language: en-US
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DS7PR84MB3110FCA7FD0A05FE103DD85495FB9@DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <DS7PR84MB3110FCA7FD0A05FE103DD85495FB9@DS7PR84MB3110.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:820::34) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4778df-622a-46da-9a35-08daf2134e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbgSbZkNE5rrRpKw5XNTxYdyZvhlQ8noUWlQ7m+ZI8U2aX9e7qB9veaG9F48vmqtMrPhudhCC5x/JcN9AY0bZWPPt/Lylz1MFL1JdT9x8msLKnmBVYTd2OZhN8AMlDiwTma2Dg6AIWJw1uO6d4zXe17wDToGx3SswF5SwdzJkrxDMY2lbBvjdDJecXBEVE13cHZ0bDhXWmFkt0WLB3BHU570SsUtVVwCDbLflXVv+axycjMtURL99wHiX5YoZUQN9pOsKRbyXV5fCNGE6kD4gl4GWRUwDH4VBTkJQegU/6JKhKUIpFf+wggOn5oJp65jlo6gp0gD5cN5ZcRm5MEBnsN/cW8L+/aFPdMwWX8R6FwXpPa2ZQ3d5cJL65Q56Lu8WkKNXrZUVCMyx7lqTMQ2jCdGYmWRQ8/WeU0X6DEIVbXBKxNn0dQ+GKO7bD8Wdo0n3pBLc0ba4OysMc4mzlNvfR+5e7Qe9pu+zbY07dSWRkrWcH5FcjfkvIpi/dS7++2x1cSXH5imsAptvIfVBbTPw1AV2pf62hHG6PA8liE3CYMm/dggirJf0p/cfEr1jfW1xbbSIWO1qQTsgCXuxKoR0Hy2CIjD8T+eGZBZDbFPXQUMLORe6lnvjd5ggLUcQ6kX4wF5zY6EFDaaY++6PgEGQDo+g4aXMBtCZWIKfA54r6h6eSucj6Qp/F+/mXIHH+GNbKg+73/YzeICOMPRIWYSYJvwrFFUVQJU4vQ1m4j5Sy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(53546011)(31686004)(6666004)(2906002)(6486002)(478600001)(2616005)(26005)(186003)(6512007)(5660300002)(316002)(296002)(83380400001)(8936002)(36756003)(86362001)(31696002)(41300700001)(110136005)(66476007)(8676002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5UUnZQOUphRHA4WHc3OWhGTEJLNHdzTkRIRVVEK28wYUJnRExNQzFSa0p2?=
 =?utf-8?B?TWhqK2xyVUlkSnZ5OXVUejdNMnB6ejlPVnRQdm00V1daMkJDbzVTZjZmdFlm?=
 =?utf-8?B?VTZVbWdENXBvaXRpSzFkczN4NjdnSDJEclRRdk16MmVWSWEyU0h2QnFtemNR?=
 =?utf-8?B?dmhPL0plZUp3c2wrTWxkSmhQdURQOXkvbjV2R0w1MWRmS0EyOWxiTXFqYjg5?=
 =?utf-8?B?ZFJFdU5uSnNaVzdhaXRVZVAvVVNvRnRnTUhRVnN4RHFUQzJidThCaTZMSUFO?=
 =?utf-8?B?Q1paVzcxeUMxcG1ZeUVKeTA5UDN0a2FINjA0NXlPL0grNzlOdzNTSFh0M2lT?=
 =?utf-8?B?MytadFBBZmcwSnNWZkh0eVlHNWpaa09rdDJmclU2TUEwNnVKb0haSGV0RWJl?=
 =?utf-8?B?WXI5WVBlVTIxRzEwMnptbllxYS9idEVaRlp6emYyVTVzRVZMUFo0MisxNWNy?=
 =?utf-8?B?RmdKQlJibklnR0ZGdkViQzRHRjRjZGFVdzJLT3hkeWN6djJ1bWh6ZUZlSlg3?=
 =?utf-8?B?bTFPZm5uWnpqVEVJaG80M0NPNHVLSnE4bElTSDJGV3FYYnN2YnBOK29ONGJE?=
 =?utf-8?B?SDNyRDUyZjQ1ajRUYTRNaXdZYnJvdFVTVjl5Njl5dmlKS25rNEQrZEVrV21o?=
 =?utf-8?B?OG1oTGVCQ1FDazFONmo2Y2w4QTU1OXZuUnFwR0hQUUxsZWVEbWROa014Ujhr?=
 =?utf-8?B?MnBjbHdGaE5MaEtXbTEwQkRGN2EyalRqVTVtLzRIVVJ2RzNxY3RqaDluN0R1?=
 =?utf-8?B?TjAxTUF3MDVYZ2U5K1RjejM4VlQxbzlFQUR3ekp4QXNwVjhUU1VpelY2S0o3?=
 =?utf-8?B?dlFZWjFTQWdCcDR1SkpPWEdqUy8wb0k0eXJ1N1JXeHFKazNrZFphMW5XYjBu?=
 =?utf-8?B?NStGSERyWjN0SmFiR09WeXJKU1hrL1BYemlkSkJqTm8wSm5CRjNOUGtZSTkr?=
 =?utf-8?B?MjVody9CdUxrZ2pkM3JEeXpzcFk2bTIrMkprQ21hbGZjUnFuT1YxYnpWNGFt?=
 =?utf-8?B?MzloajZvbS9wWXFpbHdqNFJRRGtMaXdYL0ttQjVjMkgwcFlPa0pUeW9zV0hM?=
 =?utf-8?B?Zk5kQi9GVjR4dVMxYmtLMUVtZWxHSlJna05UYVB5NVo2VlpRaEVFcHZtWEtk?=
 =?utf-8?B?MVBOYXJnUFRDa3FhSGM2QktaOUlRVXJHaENqRjRyS0RSR2ladWNlSmhrT2cw?=
 =?utf-8?B?K3h4NEVQaGJrZjduTXkvR3BjQ2Z4RldQbnBaL3hSMGNYMHFtU1R4bWppdmlt?=
 =?utf-8?B?R2o2S2h0U3prMzBKVjFYZFNLZGM2Tkk5R2ZRSzZjb25EVUV0Kzl6Rm9iaThs?=
 =?utf-8?B?TWxoakx3R3BJWkM0WmQramRMYy95UGEwVmEyK0h1QTVoM05VTVZkMU15a2Vv?=
 =?utf-8?B?UUV1T0ZjYWRhMEtneDRLMUZTNFZ1NHlxRkYveHpYOUJwRGc4RU15bCtVTDMy?=
 =?utf-8?B?N1VkUEJTUU8vTy9qUkVObkFvYnQwOVpUa3RLa1dOYk54eFRyREkrOGhUdklT?=
 =?utf-8?B?dWRRQmtLVFo4RHpyM3BRTGdaYUhmTU9YV0NHSkZpU0FyaXV2THNzN1NsSTNZ?=
 =?utf-8?B?WG1jbS9vSWVJdk1BaUZ5Z1NGU3lRenR5RkxrTUVNNzZFM2hySmtXbisrMkJD?=
 =?utf-8?B?M3V0eC9aM2FwWWhXODJka09RbWY2MFFaaUUwMHV2ajkrYjBuQmpXUElmWVlJ?=
 =?utf-8?B?N1FBczVhUDVkTU5mV3hUOXV1ejdKcVNIT1FVM0V5Q1pzc0VzSTVUU0FqelBE?=
 =?utf-8?B?YXVBYWxQTHI4Rk1WMERXbnBKWUtUN09odWtaSTVIVEZkYS9aVjZISU5IdGUv?=
 =?utf-8?B?NnFNd2RYcmlad0NheHY0b3ZsMnRMbjVGSlFPQXc4ZlRDWmpGaExuSGJYbHVK?=
 =?utf-8?B?N0VOSk5NbWVjQkYrMkMyVHAwMEJuR1FzYVovVzBSL21VQys2Y2FlNklSYkZ5?=
 =?utf-8?B?NXNyYkQvb1lXSUFLR09ZSy9XOU5uTkJRbTVyTk1XSzFjcFRTRVVQOTE3VXA4?=
 =?utf-8?B?OXRaVk5UZ3pjZ3NGay9FUFRXZFY0SG1jdUljN1dvQThPeFBIUDV6THNSalRU?=
 =?utf-8?B?bjNscWM3UjcyMkllUk5jQlhWNG0vMVA3ckhUdEFuRXhCNnY1ek9ORlVkNmMz?=
 =?utf-8?Q?duM4dsLkZ+WX88eg+MrJDDXoT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4778df-622a-46da-9a35-08daf2134e2b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 07:29:55.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0BtizQxFlEkYC2weVdox22BZhS255XhSGyERucb/K/ZSek4okyY6efh4PSsjZgAgsvh+hkhg7E+CF2oFOR8ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/7/2023 6:13 AM, Haeuptle, Michael wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> I'm running into an issue where rdma_create_qp_ex returns EINVAL and I was hoping that someone could help me understand what is going on here.
> 
> The function that is actually throwing the EINVAL error is the write() call in rdma_init_qp_attr (which is being called by rdma_create_qp_ex):
> ...
>      ret = write(id->channel->fd, &cmd, sizeof cmd);
> ...
> 
> It returns -1 and sets errno to 22.
> 
> Note, this is an intermittent error and not always reproducible.
> 
> The setup and scenario is as follows:
> - SPDK NVMF target on Debian 11.3 with top of tree rdma-core libs
> - NVMe-oF kernel initiator, Debain 11.5 (no change in rdma-core libs)
> - There is a switch between initiator and SPDK NVMF targets
> - The kernel initiator is taking to 2 SPDK NVMF targets via DM and round-robin (I don't think this matters)
> - On the initiator system there is a 512k block size fio load against 48 NMF subsystems (2 target apps with 24 subsystems)
> - When I kill the SPDK target and restart it, then I occasionally get this EINVAL on one of the queue pairs
> 
> It's unclear to me why the write call is retuning EINVAL. The file descriptor should be valid since I see the same fd in later qpair creation requests.
> 
> Any insights are appreciated.
> 
> -- Michael

Maybe the cm is in a state that cannot do init_qp_attr? Do we know what 
is QP state and cm state (need to do sniffer to check what is the last 
received/sent CM packet). The file descriptor should be irrelevant.
If able to debug kernel maybe debug this function:
   drivers/infiniband/core/cma.c::rdma_init_qp_attr()
to see where this EINVAL is returned and why.


