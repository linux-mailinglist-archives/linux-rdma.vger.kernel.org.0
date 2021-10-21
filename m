Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C124360D7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJULzf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 07:55:35 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:44417
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229765AbhJULze (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 07:55:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVTetJwg3ktUKK9YfEp293liBhD9f3F0YvMoPjoaQwOP0zRVihhktimyRfM7ZRUKkw5n02dHA1gHYE1War72z1/8g3JYqN+36KPDymKTtLITmcfyrDh9kqoqep4VOR585onCXG/NdA5eeQc7JX+/kIzbzh5arI2UMrl3sV0qawBQQbv6Pgfmrl14Qu73jmzuWXtF4hIVHdWlHantX3uu8mevitJGJiweRZoYw4CCCFYqpbQYh/j+tBgSKHlGw+mJ4tSLkf6mBI+WZKKyE6v4JbDiB6pwrBUX6Wx3Ik9IfY6lELFtxLgK9ABZuROkLEFsehlW9N5HpC5ucV1xbXlD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH9FfRC2cAuLWp43r8+eqSoqiaofWZ8k53w+WPBjW38=;
 b=K827pWiJiUELyRS1o0X8ALXg0wEFhevEnuq8ZXElEhk029ZO4VaoQSTv+3wA1T9xfMFurVJTnXhJPcU3HYYWNEfAWvdPlYrXNgvxANzn4hoibmAaoV5z5SYil73fW887r94yinmA3SQgU+Dhzq5829NmEfS1Olgx5o2a4ySaLhHBnlQZsj5YgSP2yrsjtHVGtGFD02qpzN11EJL4Soz6EJcqIIcuXxOLEz6QDwOBDWXsTa/GydLVHGcgfeZy/JWU8udE+7R+dNbL7hU5OhL1f2BUDxpLxnlyfBJAhJ2V0I1OEj/TJpYL03AmuzrEGx7h/Vq8nqh8ObhJDUSBvFaWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH9FfRC2cAuLWp43r8+eqSoqiaofWZ8k53w+WPBjW38=;
 b=iHwtkC3SLDOj3IIKafGyipyT8WAVQWRhgVAnCDB1pDK4YKToAxCXWyO1jezWV7wexYkr0Jc645uUtNoxnuCAmSANCtQRjOWSRt2EGGzEmi2y4qBHYooXmBCyYYNA7bNGqXE4wZ+WkmmkERordOxGSA0cGAkvjuXjRZu5XbZ5qhchElgpPvIJWtsed7fHkn//YQHr1pZRiM4lLw2I/YCdvRx0uCEvDRA8JwAWbk1qHON+HM9xSNDFPoIHgPgbPQ0pAlFgQginGz2LUAExBcug/GiHU20x9SGCrq4RToA6E726BKAfx4pGv/WdJLVB4PGvLpkxGk//Z+3bP+uVXoACJg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 11:53:15 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 11:53:15 +0000
Message-ID: <05c793cf-0652-de02-038e-2785d98574ee@cornelisnetworks.com>
Date:   Thu, 21 Oct 2021 07:53:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH for-next 3/7] RDMA/rxe: Add xarray support to rxe_pool.c
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
 <20211020220549.36145-4-rpearsonhpe@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20211020220549.36145-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:208:a8::37) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from [192.168.40.173] (24.154.216.5) by MN2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:208:a8::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 11:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 876f2c47-9dea-4321-145f-08d994895dc8
X-MS-TrafficTypeDiagnostic: PH0PR01MB7287:
X-Microsoft-Antispam-PRVS: <PH0PR01MB72876C92D83669AFD2DBECE1F4BF9@PH0PR01MB7287.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+OOzupU7dxTcFP+HmKRUgr1/kS1nf4RdVQBWCuvmsfzMazcmL4V2HCl4COD0DI3TD8lYdgtaQmfsrgO3KQCriV/V+54Y8GZPg1Jl2X51OGjrd/qy7BkJ6Z29rsz9v0xg5XBsTDJWJ+6+smgXrd0qLSuY9rJNXd7RKJXI9Z9+MH5ZY6uUoMDYJNx26LTPXUKVAT4cPavbCNchUBRyWcT/tTFQrTl9xlSxqCk5de70jGwgdoeGMTIuP1O1yatHODl+cSDOe3hVrz3d4IzsVH+kEt0bcXHvnFGMx8UksiloGzxSP/4q3NfnhDuV5C9UACb5RmMn+h4wV+aDQI6rovbHDqTAvIugKh57klrCis1DJJXEXcJBp5mHCU0DVOUjW3jGqGFcV0TOuWGk85zLsuG4hIpACgtN1CfJMdnB00r6W70UEGROv8oFgkXvf7PxNVMkHgoft6DN8mzlkO03JFjdzwR7gdkGPvt8E62Slmb4d+ukH4uOfB7r9s5g2n7Zz2deXrpURrpJUwKUYbzRfX23A164vRzYfynxiN6SjQ1dFz7AttyD/tWOf+C0jMBzNVegl5d3smAOF5KHDLXRaZJjWn49MxDfNeiqzKK2BpS69QO7FXqXilTRqq9DVmut5mBCOZpN19CmUn0gCZk/p4deooNs2wdjOEqL8F5xMLX6WwX6P+6NmOFTYGbWCt8Hnw+v05EXgOIe7lgdmg0RLti/Sw8nnxI4HA+vlk9+h4cYplTzeWUJb1M6RWprhJs14ckcbfcqoOpQt3RvGRU7WwqMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(36756003)(8936002)(2906002)(5660300002)(6666004)(8676002)(66556008)(52116002)(66946007)(316002)(44832011)(26005)(38350700002)(66476007)(6486002)(558084003)(186003)(53546011)(2616005)(956004)(16576012)(31686004)(508600001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25ONDF1UUZnWGpRSko5QVNFMWJ5bzd3S3JEMlA5ckEreWFqczhWQ3RvVXpz?=
 =?utf-8?B?QzNGMkhsVzViQzk5RCswcVJOQU56MEZKa0tUYzd2Y0syTjNYWk90RWthMUFE?=
 =?utf-8?B?L29IbGVEYkt2aEZPQnpjZC8rb0tZWFMwTktVT0kwVzlLN0gyWnpuL2R5Tm1i?=
 =?utf-8?B?ZUpVWEo3Tmo5b2IyeXR3SjZDSUc0MlZuOGIvQndQQTN6TFhuSmhUeWtaMFN2?=
 =?utf-8?B?SlpVWDZHalRKYmZTcFR5VUhiY294aUgrbUVNKzM1cEI4S0NUV0FaWEpzb3My?=
 =?utf-8?B?UDFFQ3R6eEdaYWRKdnlPUFdWZENCcHlwNnVZaUpVMGlzVW96ZTlBRlpmeVFB?=
 =?utf-8?B?Vm9DRGNnN05ZN3V2SFhFOUtzSlFxRGp1eFhkdUZjSEx2WTFsSm5vVkFvTTdy?=
 =?utf-8?B?S01zV3BUeXdsUEVXSFF4alpVeDNRTUU3L1pTczd0U1luQ2JEK2tvYmNyM2lD?=
 =?utf-8?B?c1UzMHg1Y01vYkpzL2hMTW1WT3lFV1hHbitmeVR4blJPOTVwc25ETW5pNi81?=
 =?utf-8?B?Zm0xWjgwVzF4eVpnZWM2b3U0ckIyYXJBNFhtN1BCVjZLcTdDeEJlMXcwdHdu?=
 =?utf-8?B?TTh0dS8wT3pXc0VwK0d3b25RbVNoQytBSXBIakpINzNxYnBQeFR0UGl2SUYv?=
 =?utf-8?B?T0t1OGozNE80OTlpMjBUUmZ5ZmtiZndBaEVRMjR0QXlQcmFBOU1WaHJHbHJB?=
 =?utf-8?B?dUJEUlhVT0F4WGNMa1RGdFUvMjRBMzNHMWcrOEVsT2diVnNrRWgyRE9zNXFq?=
 =?utf-8?B?YTd6TmlzVzBpenJjME9xOVhIVjF0ZjNwaWdKMFhQUTRyWXgzc0hNN2FzcXI3?=
 =?utf-8?B?WGNSbFlCODluc0dwUDdabW1IOC9BZ2NlVXltUzR3M2ZhUTQ5ODFtUDJvaHVW?=
 =?utf-8?B?djczcTVVbkx1clJ0TUpFSTJ0SWpOSTk5NHg0MnpZanR5Q2kyOWlZV2JQMXdS?=
 =?utf-8?B?SW9BV240N2tKMFZTb2VDeVlodWFHeS9VTFVaVVBQc3lRRHRpWXpUVFJLY1A5?=
 =?utf-8?B?ZU9ySktqUEN4bjZHUVlkUjNlU1NOWnpHalA4SldNYnRsUGY0a29jNzQ2Mit6?=
 =?utf-8?B?OWZhaWpjdTR2aUVzUm9FKzZPNnZrTDk5WmxDaXVxN2ZQSnk1UUFaUjJQQjRM?=
 =?utf-8?B?TDhJaWZsZXp6L2hMeE93R3NqREUxS2FOZzNtY1BESFUwRjRBNDJNUnVqV3NT?=
 =?utf-8?B?UXFZZWR5YmlTRXlZTjJnd0FnRDUyR014WlRFM2xPWkFzUytsTmlRWWg5aklC?=
 =?utf-8?B?cWROU0tGRlBxT0daY1UyT1BYSmJ6bTVJSGdJdVdWQ3pMWG9wVTA3bmJpY1hT?=
 =?utf-8?B?enBNM3JFUU1kWVlsNEJTU2x1NHpyRWE3OXZ2djgwWm4rZFJJOUpKVlFoR1Ay?=
 =?utf-8?B?MUZhcEdVN1JWVTgxRlRlVzg4TDJaV2tCcnRwN2FqMDYwWm9zUjhqZmo0Q2xV?=
 =?utf-8?B?OFp5aHV3VlpiTlpXOXpiQXU1Z3dlYTFIc1Q0NlE0SXdqdE43Z21rYWF6b3dT?=
 =?utf-8?B?TE9nYnJsaWVLbGErM2U4bm1DdTk2amFwc0kyaFdIdmVqeGdhY2tRVUhmN01U?=
 =?utf-8?B?Y1k5V3VsWjdnNTBPbXBmS2FnbWdnaGdaL0lwZlA3TFNTWGdycGV4NktVUXV3?=
 =?utf-8?B?bjJvVG9qM3duWGZld2FsMjNLa3hTM3M1M0NWa0lBblpNRFhNamRPdWtkYTBI?=
 =?utf-8?B?NER0Sk8rYWptNWQzWHZMU2RoTVRiazZsRjhQS0FJWWFidHBhbG9QSm16Mmg1?=
 =?utf-8?B?Y0Zab0t4SVJpS3pjM0lBZjB3VGtGRE42QUl0dWR1QVZhYitUeXdIRGpQaG9r?=
 =?utf-8?B?cmlPVFd4ZWI3aGpmVGZlQkk3YmRsandWLytLMDdqRVV2aVZzSkJsQjZNZFZp?=
 =?utf-8?B?M29sWnI5N0dEM3lob3QzVXdPbGx1ZllkR0lpcEt5RkYzNFExT1NaRmxXS1Rt?=
 =?utf-8?B?L2dMbUlLQmlqYk5iSkFvZVJmZDhxVkJuK3hiTHhpSFlFaGEvZFF3QTdOOUFk?=
 =?utf-8?B?SEtwOVFSRUZRPT0=?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876f2c47-9dea-4321-145f-08d994895dc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 11:53:15.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddalessandro@cornelisnetworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/20/21 6:05 PM, Bob Pearson wrote:
> -		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
> +		//.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
> +		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,

Assume you meant to remove that comment line.

-Denny
