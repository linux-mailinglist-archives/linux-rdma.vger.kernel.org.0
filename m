Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552515B160D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIHHzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiIHHzr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 03:55:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BDD5AA0A
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 00:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEssJ64g6G3M+nCboVRSpFZgc/Gx8lqtASoOqL43nvUDjvBbtd6HAvI02fVcXWEb2lKBNq4+bZSpGqmSsrqXfot5D/4LgyXN1tdOD+ppanyTZoF/U5pOg7xI7qJmXe3RppgtLLPfjaZT8TmiSqHbGT7nFnTvzw604JU+iNf7WiYfvyl5ddJc7JhOUgEcHnbEc02guRN93Bq2Zg1zOSZ3PdHWVPtcak4M+w+s+iGFWRfRgy9qGf1tkXXDVfI7UqXH/j8fbx3IGbkL5lTOOORmiak+LI0d1MRZUVMEiXUkCLxoeW/ppuAVFQiXwhKEDPz8sKHgIzqb00bK9pA84Tr7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyiCfVHlfuanGUDXqSKLYwSYyG9SKvMnL1yDmg+A2/Y=;
 b=APy7ggxEV5TkJLQ2ofN2jdAn38QEQelzzmXHJzx5Vjur4Y9r2OVGzMlHHDo/lCMkgCYCQIsiAyn3iWPdAhmKQOi48amr5O6XX9IGuwBrgDWVpkxJ5+qdtiMlPu1RivRgxP0U11z0V9WBj6lS6YNPMXdBr+pBaJiMssRwT1l08GQE6POXx11mbWUq7tC+tf8Z5o7aoEYp32ZmhW2AogEPEuWDPNXB8dV4gqBXI4xnA4jzrjzzGnLLnfuhTMrgtJPimEhzXbpuQ8zOtoATBJFfFn+u5/1wrr1qh3uNsFmHZK1XydX3NFpHuYoTMmkaWHe+ysLO+ggh/dHgDuys0y82Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyiCfVHlfuanGUDXqSKLYwSYyG9SKvMnL1yDmg+A2/Y=;
 b=JI6JnrnxRqSCpolWTcpUKQxKe8eXdzrkj4HNkM2WdpIjN4Bii5feKR2k4qQcucB4/NOqw0BH96IWDzDvaSXmy0UWJcwedVdccZpTWc9aIrWIXCZyWot8cxtxSxi5iddTyX5JWLlrlFU9ZQrLa9m2IVeA/8m/nk9zJlo2tFqDqQZKZjfj4QPiL4zq4KFEq95X7xmYjY6ik1r7E8tAYGVf0hGBxf3ih/LBQosTDuba9OlWf4ctPf7pB0SLMlXUEz5nmh1mfAQh1h3m9IjLOUjt1TZdvbRQZK8+XT50sy5DD16PBciNse5OF3mCzxCc8CbwF6Gi0COqounZHNFxSWpMWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 07:55:43 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::f153:51ec:41a2:843b]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::f153:51ec:41a2:843b%4]) with mapi id 15.20.5588.016; Thu, 8 Sep 2022
 07:55:43 +0000
Message-ID: <312c6e21-2013-578e-41b2-7a83c02fe7e7@nvidia.com>
Date:   Thu, 8 Sep 2022 10:55:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
 <20220907151818.GA26822@lst.de>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20220907151818.GA26822@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::27) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5e3232-2fe4-4da8-863f-08da916f8785
X-MS-TrafficTypeDiagnostic: SN7PR12MB6864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmqFNH8BendyJbF+5LQs+dc1ZR6BulPagNPWtRGq9P/5G65+D9LWubuca0we68QLfOXyzVwIoIgwECOX3uaThZI0g98SbJy+my/9ggxWWUF5pNYbWgINH3zHqPGcNOumUEoQCJ50nPoIqztc/xYpJYU06FK4lKPwcpTyGr6yIby4qKMzVbYqNd8W0itBUm3+kYUPJLVQUpZDBdcHvpWA8yuYnbdMcAe66bQqmfuOz2i/3XYBvVJ2FLsvly41emk8UeN2kAeC8DkFwHALa9NMIZOxk6Ez+1Mn5jGC0IczG+/CPv2fwvOHjyW5+ZdOiC4TzlYGLowgI20eOmBhtG/wkSM1tCruJg7wp9JIqNuS71PH5zIoHGslSXcS7JKdKCGkuZqo5WlkrrobxPBPZtNcUJ+75ckPYGlh0X5KUr+rR+Qd+rcfqHA9RKKdz5bBvd1ZtjE108hEqgzmQjD6Q8VweGyyEzi0HkOvctWAovoxaVCP4VUGJj3iPsiPaS7GB7cl1n7W97sNSQKkIpqF00n1E0y2M4s/QU+r2h/EMqyvZqJOaa94gj5sllcGEIBd06cEUtMj7qlnZzI+kYUK5KtVVKjCBRUZPxU6I2Juhh7yXTpJ1Cc1Xrqc2sP0lfqH4yVpidqQ/t/JWk/BgbRY6PSrqfVUeAZF/p6AFyx6ITmbk4D34gzJvpTz0Qe5RI0ktbWT4h+0NUsZAZ1uyWehIUREiX/kW8+WX4+cIFYzvFHhHxnASbE5kxi2LPOxbNmvWK1z4A52zRTv/+HPssBxbl5fRd8xbg1MPdq+gCoTsLYwAGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(8676002)(26005)(36756003)(8936002)(5660300002)(186003)(4326008)(6666004)(31686004)(478600001)(31696002)(86362001)(41300700001)(53546011)(6512007)(6486002)(6506007)(2616005)(2906002)(38100700002)(6916009)(66476007)(66946007)(54906003)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFKUWhhclMxaTVlK0JWUit4UDFnWjNScnM2ZTlWY3FxVDZ4Z2FheGdCbUto?=
 =?utf-8?B?a2FIUkZ4OEtDS0VCQmdSUm0xblRBaG9FR2w2RTUrUEtOZ0kzYlZPbWtYNHNN?=
 =?utf-8?B?MkdlaWlEZm9mNFJMWklGQmhoUkFscjZxekNQYU5LYXpmeitEY2NGdURVZWEw?=
 =?utf-8?B?alp1TDdxUWxHbCtVYnMzM1dDR3RJbnVzZWxsNktYVHRRd0dLNlZuc2RRRkpj?=
 =?utf-8?B?WU0xMndtbXlmOU43WGZCNEJVTU9LNi9BRzhTa1lWeFpIWDhhazc1UjhIeGZ2?=
 =?utf-8?B?QnB4eTQ2NVpmbVdod1BCa0RvZlpWUFhzYzZFSWdkZDFMRWErU1J4YTJ2R0c3?=
 =?utf-8?B?SE42L0hoMXFYdDNhK2NZMUpzbUY1T256dXgva3RjdkZlZUNnZ1IxdkpJQWNq?=
 =?utf-8?B?d3RyZjVKYlFYMGl6VDU5SytVVFM1aHBtd2NHQnh6bDcxUTZsMFJxVklzVnI3?=
 =?utf-8?B?aERKRStKY3MwMXVneUx5bFc4R1V1YmtlbTRDQmNMRHltTk1HMmd0TE5VTUxx?=
 =?utf-8?B?NTBMNjhreTdkd3oyV2cwczZhKzBzSWxBTHZJKzJtc2YrM2F0VmRLMXZwZlNQ?=
 =?utf-8?B?eVp2dTBoNklQZm01MUUyOWZZajg1VFA1cnpVL2pPRUloMER3MWpqaVBvaWJq?=
 =?utf-8?B?dmdVMTN4cXFMZE1ESUVCNDBMSEE4K2xoK0g5VTZ2YW5NMFZLZEQ3MzlpaDRm?=
 =?utf-8?B?bXVDSTBSUURON0psekJxYzBZcmlBUFJQK3VIK3EzV3pieDh2ZCtNeEVGSVky?=
 =?utf-8?B?RURhKzhyTkdIRTl3MUtsZ0VqejFkSFV1NU1WcEljQ21qaVkyQVpOTzZBL042?=
 =?utf-8?B?UWRaNVowUzhqQnpsUmVaOFdyVkdXRk5zUXdMakptOHBDekh6TGJiaW1BdXha?=
 =?utf-8?B?RVlvYWxjZ2ErdjVEQjNSZDBiYmhzT2VDTC93cHVYZXloSTJCUlNzS0FIME9L?=
 =?utf-8?B?M2IzcmNFNzFKVi94WWFCR3dQaGJ5eWNrOTNLRUV4aGtpM0tCRjVmWVh6WXBw?=
 =?utf-8?B?bGpPbmw0ZG1GYjFDZ0QwbGlrWENkNzY0QVhnRDNUaWhpV0Flbis4SU8xZ1FX?=
 =?utf-8?B?bUpIZldtU2ttRHcxME5vZXo1VVFrWHJQZnY3Tk5SSC9najg3S283ckFlUzVl?=
 =?utf-8?B?SDRFMHhwTFIwMDZmZnlscWx3R0pUOUJickRaVU1HZjNFV0x2V29HR3p4azhk?=
 =?utf-8?B?MnNDaDlYSHF3NGlocWI1UkUvRGxoM3hidTY1SEVsdTFucFhmTnhzS0poTmcw?=
 =?utf-8?B?MnVLeVVndUNxNmdOeE1xd2JUa2JOR0hVd05zVEVINDMvK0NLUFdMbndHZDZw?=
 =?utf-8?B?WmVBemtXbGRWVjVkamFXdDVQOXhLL0RJU3pDUWtHVlZHNUdheXoyV1ZJOVQ1?=
 =?utf-8?B?RXlXZEtaTFV6dTE3TWlSQVJ5eUZSM2NyYkNhZzB6ayt3eXd3c1JVanVQR25X?=
 =?utf-8?B?Vi9uNDNvZU8xV0xMTmNuakhYdnVkMmlNUmtOMTJYUnFQdVQvaFJIeTAvN0gy?=
 =?utf-8?B?NEhoNjJqSnlUTE5TUisrYXFLV09iWFN2aVY2bmZMVVB3bG8zLzdxTFlxWHpl?=
 =?utf-8?B?Uk8xOFEzbXlYK3lxUDRPbW9ncFJjbDArWXRUOGdOeGQ2RTBUMUZoUGZpeGpN?=
 =?utf-8?B?Q1lleGFqMUwwZlEvOUgzMUFRcHkrZ1dWVnVBbERlcytGb3pTK3ZGenhEZHU1?=
 =?utf-8?B?NGxJS2dsOHRTTkltVFIxUVF3Q0RCajVFeDhTYXNSZWhLWU13dmY4N0c2UDVY?=
 =?utf-8?B?TlBCRjY1LzZOd2Erd0txQVpMQWxtU014YmVVakFjbHArQWc2QnNWaEd3SU44?=
 =?utf-8?B?S1Z6Y3dqQ09VMm1XRjMybHJPa3l4Ni9YOWM4VFlhMXRPNDVmQUtvSDdZOXJ0?=
 =?utf-8?B?emgrQmxUbllKeFJpSElEODJWQVJZQkdXT3lKd1VMOC8yQ2Z0UHRyVzlhYWt3?=
 =?utf-8?B?bnMvdk01QUxRN0hCYjgvZWR3S2hxREpLZFdPNVh0WXNoZ253VE5WMjVFZ2Y3?=
 =?utf-8?B?NTQrS1R2bkhUakVkZmY1cXBzaEdMV3dZeHYwM3VhbU9IRzU1TFFYOHlwWUxu?=
 =?utf-8?B?VVBZMEJycmZjZXQ2bDZpaTIrdTdaRlVTcDg2ZnkvQjZQOGZ6bEJRR01leHRo?=
 =?utf-8?Q?yx9+DGZjEQSqdTzkjHK0zBbH5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5e3232-2fe4-4da8-863f-08da916f8785
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 07:55:42.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jva6UweEE2FSTKrMcPbDd7q3aGQyEoz2ulmiV/twojLVeGmXXqh3OTrfRzIPZBtBHG6f7t0qxDRTHSrRF9puEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 07/09/2022 18:18, Christoph Hellwig wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
>>>>
>>>> This entire code needs to move to the rdma core instead
>>>> of being leaked to ulps.
>>>
>>> We can move, but you will lose connection between queue number,
>>> caller and error itself.
>>
>> That still doesn't explain why nvme-rdma is special.
>>
>> In any event, the ulp can log the qpn so the context can be interrogated
>> if that is important.
> 
> I also don't see why the QP event handler can't be called
> from user context to start with.  I see absolutely no reason to
> add boilerplate code to drivers for reporting slighly more verbose
> errors on one specific piece of hrdware.  I'd say clean up the mess
> that is the QP event handler first, and then once error reporting
> becomes trivial we can just do it.

I would like to emphasize that it is not just about slightly more 
verbose error, but mainly it is about an error that wouldn't have been 
reported at all without this feature, as I previously mentioned error 
cases in which the remote side doesn't generate a CQE, the remote side 
wouldn't even know why the QP was moved to error state without this feature.
