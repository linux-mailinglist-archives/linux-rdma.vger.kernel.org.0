Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC344BA51E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiBQPx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 10:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBQPx3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 10:53:29 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FEDAB;
        Thu, 17 Feb 2022 07:53:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2+yCxLQLU7+KIKKguDVR0IEcq7PVmAkjuNc0IxVC3As/aiq+39JULm+7DH+6YMMpQZw8/SujtnaxM5ZHdrrvR4Go8WnEShCYD5wucgZhw9HBKSyp7lfwpxOeaZAYWsV8FkniZz3pGWqUnK4cOxccS3bef39ceppYBSgluQamWTJ/3zQvPxcstQc91Szx25QFXxlUGPBTr25EeC4bVEDuF2mSoTwvmzWAp+M2W5wnZSZhpZpI46iSSqky1H/nzrkfMECBOjfeajKLnHhI5xlIorTssiRIpeWSA3Iw5p6ncENI2U2fU2nXu2JztbNYcTBqfPppuz4Ud3x/hHf0GAeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep8qLWG0YSgzfW+FS3Vmkcr/szXSac5NJ8eGYA0ht9w=;
 b=joKO0xeWRnetPlK9HQFij9wgiEaP56FbAlKuEDQBRW3cTYbzZBXO9n43eoLbjnN32JbUfAfM0H+WchbcvBkxu4E5WggIFQIQMqKiUJImDopzJkRO8WGTPsSnq8DsRkzLSVOCBQpQ6X82Zf4VTg7+QvZ7YbSr1HolSFKZQw7ZkwHJzC1OOB5uHYF7i432ONvqcWVDTMkXFBHhEIAsHGvaWUoyt4hvN5u7QYXTjYSm7flP2SOy3ejZamDYxT+HrWN2lrv4VzaEogjizBvIUWUxmJeeSx0nIe1JKe1b5yDySQFbI08pszZrC/eTk350w+afaeEf99v56/V+Ud09dNR3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep8qLWG0YSgzfW+FS3Vmkcr/szXSac5NJ8eGYA0ht9w=;
 b=OpTYZL3N0orQ3EoeII2LbBAhAbxTX8WJMrT8sQHt00grP7USbRiJVcPijoB2kegFvYr/mHRSVBd5o+5L4rQjHsBvvBWpmoRz5ERY06UBZuE/5G0SHLBF7L6h03H8uQSpcVIrEBV1NgBYg5tuB6Wt7sSiIeH1jICm8GMs1eqRhqUJyARGCkuBl0sKfrcV+fW2/1YphUzUqd2evMgTL+mWs3wm5Bqonfmd1Nm5Ud8zpr9hGaDdnbUPx6MxeLtFn/V2/wretfdxe/Y2/ZFHTqObpOOXAE+D4uxltOV1Cr8/wYvTGM6jAp4Mwfjl0QM27yvQ6L/+0u2A2DatidlYJoJJCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MN2PR12MB3503.namprd12.prod.outlook.com (2603:10b6:208:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 15:53:12 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%4]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 15:53:12 +0000
Date:   Thu, 17 Feb 2022 11:53:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc v2] IB/cma: Allow XRG INI QPs to set their local
 ACK timeout
Message-ID: <20220217155311.GA1432970@nvidia.com>
References: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
X-ClientProxiedBy: MN2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:208:23e::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a373a6-09ba-4992-635f-08d9f22d9a2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3503:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB350342246F03BBA7162F0CBBC2369@MN2PR12MB3503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXtdn4k+7lrR6vEIlS3lS8t2akGijn+Unb8cNxwkcCPek2/vFTtAuV3xGmDHREzSCvB5baiWK5mkkW94iZLY9E3I9XiT/3IJzOMzAgV4ATJ5Qh6y4p8xN6eIaEUF6DtSZjUed0uh0+QGjoq1ujSKCrUZxGz8fw7eof1dZIpSyfmAoqSC3e+TS2wKJ//GORzRdE3OIIdC5h2Hp9t8rljmUGewaex+VKL1n2Tk396O9CCkE2LD68nixUdXTRpLNIEmx6vEUJe/54UREQ8xbBvzjTLHUzkxws6m705bnecS4aga5PER4OqTpt6ifKyIVtDPA51psTnZyJdZW56i4Clbs8b6g2IflBvA4wYA5NdiYdlCrIQYs9aLM0dyIMx8BgtSW4cgNi6+7fdb5b5F0jt0vZpp5WZGnkDwFz7PpPm/DSZwp+LgaN3OZ+8esnoDieGz8t7fw+EN2uWaN1kckQlP6WQlk6BT8kjla0GxNVGG3g+yH4G+NorqC9jGwdcw9LaBWbuvQeFJO9+zSOUHgxkCCyD7sXp13gWRHlFfq50gVo6hKV4O3PEc3ClS0Ps6gOYYeGP/7l12kaWPcX2AIyU0G1oMcSbf61v9WTqqxEzBGdeSrMKo1npHSWXyvScMEMR0I/Z0nWukltPUaXDDud3lWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66574015)(66476007)(38100700002)(316002)(8676002)(2906002)(83380400001)(4326008)(33656002)(6916009)(66946007)(66556008)(8936002)(86362001)(26005)(508600001)(6506007)(1076003)(186003)(4744005)(5660300002)(36756003)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekp5TWdFcGRRaytqQUFpdHJ4T2lVWFhzWGtPQWNxaDZJQ3dCZUNiRVFjRWFm?=
 =?utf-8?B?azBBd0E1NlNEbGUyWmtnOFY0T2hxN0J3SUNMMjM5VkJTNjlwcm5SLytER1FQ?=
 =?utf-8?B?VHlIWmt4bnVHRmZ1MVlraThHYnd0c2kxNTB1NkxqMHE4V2hTelhxbmtySHM5?=
 =?utf-8?B?aGNLLzlZZENRNUJUcHUwdytYQkhxa3N4TzV6M2FqdmI3Q0pwODR0QU5YYjho?=
 =?utf-8?B?amtaaE9IazljY2Fldk9BcHBsbE5MMDVOOWRuVGd3KzJHYW1yVzl0Qk90cTBN?=
 =?utf-8?B?Sm4vckZIS05YS2ZyUGo4cWhxQzNOSUJVQk9zUmplU0ZjRXRwMC91T0dWZzE1?=
 =?utf-8?B?c0J6LzMrRkhTejRaWHY0cnl2R25QUnl0aUtRTWlUS2pTVVNUY2dNSnk1SWx3?=
 =?utf-8?B?TnY1NndodWpiOHJUVGlIUnRxSE9OWHlweWFrUE1GMjZnVlRET082ZVEwNHVK?=
 =?utf-8?B?NktIZ0NxdjIwd2F2V0krVDNZRzFGMzk5Uk1xeTk4S2FkSlMycnM4bzdmZWgx?=
 =?utf-8?B?a1Y2d1ZyTU9NMks0OGRsTGROS1d6MGlBTU1nZ1dnTzg2Y0lDMTZWQnVTQlM4?=
 =?utf-8?B?R1BzZHZGMjlmcmhKRnZsUEgwQy9tVitEOXhUdUxyRlhHS1loSEQ5WVJSUHlu?=
 =?utf-8?B?WTJLamwyNkV0UlpmM1REOUNPTWYyM3Q4czlTWWpYWjQvUXlNWVF6cUJ6ekFV?=
 =?utf-8?B?QTJOOVRsMVhKK0trWXBoT0czbXJYTnlqcmh4ZVlrTHB2cWJwdWM5dVZUY0pL?=
 =?utf-8?B?dlpGdUlIQlRHMHdhdHltNTJHQXpXR0U4Y2pSQTYvRjlsdW1DN3U3Z1BpQ1ZN?=
 =?utf-8?B?UzBGOG9DWUthWE5vSnNJc3ZlOTNkUHZhRHUrU2E4NFZyOG5RcWFxeTZIbkdK?=
 =?utf-8?B?b3ZTNENRVEVMQmtSZEcyaHRkdlVDZEFlV3FXR0RqQUozSVFSNGNWKzRkZHdo?=
 =?utf-8?B?ZmlVTmFMZXp2SVQrd0U1bmNXczg2VEZTOUxkbUx0QnNjU3htaThBcjY5U1l6?=
 =?utf-8?B?enZocXZZNGNJNGV3TlJmdFpGelRUcXROcVg1R0pZSEU5VzVjS2IyVitSL0tl?=
 =?utf-8?B?UHc1dzRaR1g2WXlWK1NBdS9nMjdkZlpFdXRHTmZZSkdzbTdYakhROGRsdllI?=
 =?utf-8?B?cUNNU1IzaVMvQTZDTlhGWmlwSk9NQkFKQnhmSnQ3T0p1Nnp4SjFvcFNlMWhl?=
 =?utf-8?B?L2tvS3lNWWhzK0lvZW5ScG5EYlViaDVuNkg1MVJrSmlwdEJyQ0RSRHNDTGI0?=
 =?utf-8?B?ZndnQTNRYzBjYnJYeFNRUWxwQWM0cTYzZXkzWDFZcExGSFBtTksxZlJrQkda?=
 =?utf-8?B?aEhxK3ZKNTNwbUFqdGh1ZmpmMnJqc1RFMmkvWWdPTHlPOWx2Z29hc2x0U2Ex?=
 =?utf-8?B?TzhzeXpsUi95Zkc2K2t5M0JMLzA2SXpTZTdvcFRna1NPMGdLWkIrZGRrTDhL?=
 =?utf-8?B?UlBKRGo1NVJLUmxlZDFOcjFyTDlKN0JzWTRXblI3cDVYdzU1VDIyVGp3dlk2?=
 =?utf-8?B?VzRsbTFjV1RwVGRvVW93RGRKQ1FxT2lUOVg4d2RrZXFlOExaOTFTdlYwcEJ2?=
 =?utf-8?B?L2Z0UFZYU1oxeG1uSkZYcDU2ekFEZGZuMWcvRE1BSGhRUnFseWtld2RFcXhi?=
 =?utf-8?B?REpxcXJHdU9Ga3dGUmQ2WlN1WGlpeUMvZ28zazk4VjN3UjNwOGd6a2Q5MU9r?=
 =?utf-8?B?UTE4M0R5VW5GNlNkcUVCRTdzU2R3WDJJUHc4bDBkVUFmUkFOQzdkd0pSTk5M?=
 =?utf-8?B?c0RDbHVabElnUW5kNXlyRXpnSzRZck53VCtaay9uSko1b1lNRFd4M1JEVTc3?=
 =?utf-8?B?SDhMbDZWaFlTYTlWbWowWUlyN1ZCdlJ1K2tjVXVyVUllT1RwdVhmM3ZFK1Yz?=
 =?utf-8?B?KzlidzJBRXhJd3pUMDhaQ2VBWW1FYVJDaWJNMnVnV3RadGorQ3JLUDFSY3U3?=
 =?utf-8?B?SnJwdUJYZEJxTXF4Q1lQM2g5djJJa3pHalh0czRnc0tsR29RLzhqb0FnS1Jz?=
 =?utf-8?B?WHJHUUU4cUJOVU5KdEFnWUVzT1dydXZNV1JtUzdmY0JwU2d3WTV6by9EdlUr?=
 =?utf-8?B?Q3VFU3Y0Y0dCZ0pTYjVqcjgyaGo4R2xoZ1BWYXZISEVSRWx5TWl2K3FhaU1D?=
 =?utf-8?Q?C1/A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a373a6-09ba-4992-635f-08d9f22d9a2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:53:12.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vp/wQYg/gb47p9kesKZn7dBj2IxMYlSscWQ3fJRpp4yXWD9Lp1rLKPtAvOM6LkPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3503
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 04:39:35PM +0100, Håkon Bugge wrote:
> XRC INI QPs should be able to adjust their local ACK timeout.
> 
> Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Suggested-by: Avneesh Pant <avneesh.pant@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> 
> v1 -> v2:
>    * Removed WARN_ON as suggested by Leon
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
