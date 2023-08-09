Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085F776891
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHITW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjHITVr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 15:21:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90A44A7
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 12:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl0uBELq99Hvh4WTcp/+EZ/2H8R8mux/nmdVRB2uAqsY/tx15DL+TqUpr4vI1knGLJIhJd6rfhTym2HkC4Lm7tynQ0YpS4eCE3zZFjuWRLfN+Jy4fMr5oehT+l/J30d5Kx7u4vTB40Sf9EtkgYiyKFOLA2MNvHYBZSKV24wCA6/hrq/zbdQkE/VdwNRqGMyWLfq6DvMbNqZwnpDqpoxdY2xtUowT1YDYP8I7OLAay0ia7aQlIvZloF4EDEL4vyu+8J+OvhoalUaVA7q7sndWnyfzIR/e9lNUkXxsgcRDv7BuCmG1mfdoIvtCoKEW72ZTuKZcVTw8ZNGZVOKoZg5EWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLNKWeC+I41tMXnOQnt2G+XR0P1qP/rQNAb6TRB0FFc=;
 b=BH08u4xIEccXo8dO0V1fPUMjKgLQ4UHeL51953cm+g3z4z2jjEngHxod/25K7otPGDMJzyu4p0cTeDoc/QLur0+4yOrWsxlqPxZDXMnqnBlOm1Ohfd8K31opXz38cnT3qAfHEiIV8wZgUJnMxPNrxKqx0guFYlbmkTFi3c8OzeJexYrk2E+lwC8DCU/e1duZo8Ae30ZBcnj44b/67DnvrZtKkEMBW1wsFM8vNrXfuyvdWZXxXQpBc3GB2iIU2RWV92577xGV5I0WehQE7yDx+LL1AnQVpjhCOgX3UpWgPlpffbP/5wqBVJRdv8SvTscXCruJgjSi5Voq+DWAN/C3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLNKWeC+I41tMXnOQnt2G+XR0P1qP/rQNAb6TRB0FFc=;
 b=jWJBxsIVd3PFO5wfSH8+UpjkKMpxEXq0egT5bu6yoW9Jhzvboij5k0L52XRPoADQhnnQ+abD5K3cxo+von3IPZamwWiwOC60WwpGKzDvVps4m9VWQIObWFYRCFq8JZDGGmqCwPO51RoEHnfBVPP+5Y6GpbVtny82zfJJEDHXZwO5HSZdA/jkAFQv25g3wkiYEL8MJH5tUK4gwyzdu9AFdZhkm9nSWvyLzVjD0DQl1MZwBwwjRTjRPc/zHwzVla2z/hgu2VXvT5NxJB7Qw8ZWyP7+k5jpK8ub55X7pJsf4ki6rkJHGjf0c4C2P205+Egw6kBwwWzfsWoah5SswsRBcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:20:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 19:20:52 +0000
Date:   Wed, 9 Aug 2023 16:20:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Subject: Re: [PATCH for-next v3 0/7] RDMA/rxe: Misc cleanups
Message-ID: <ZNPnEUEDCpBOcB0u@nvidia.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f2bf31-0be3-4885-0fc7-08db990dbefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubC1Vk3qD6LUyMCkw9BATCqHueaa1KtIOFbaw1ZiIs/Se68InOFSUkxbQDR8MStMi7L8pSRDDwvlf7PDPWiJJb0OFU0K/6nNyTl/UKCpe/9Zk9YufJPPdYCVzuHlSDgyDffzYIKWoXKjLb1CrW0UQPfiA8KkTeRWaSsPidRLc3Bs4bswoo1AW5BTZmiVUpZ1/ivkE4GqceGj+gWpjoCngGYqmJMkS0ygCPJzSm0YKwzipYyoRJ8H0Rt/KOGbtMklMqVDEzVp9aA8twsqk4OjZOvhJeOXXOKl7mT2fR5JdZMMzmDlckJl1JiywHpj2+QNdTkDNyAZwbOGZr+C4lGbTYYC7DWHINAI8Y3T9hd/FKa/swMqHJX/MSYV69YTax4CzxRqZaynuKeioHMKPluu51Mwr5i35eSQfYz16YjPSqTlAbJyZRBLy8iWW795KmhFA5xP+5/ReRrniNmlWzaXoQ+AU4M2uoQBJD2QdHqfoaGSB0ZehmFqHwcFsOJx7sfD/jjDg+3Lu+SskGIAB5X/kn4lwn2NnHY8AgCTdkdlozqp8X/ccibuLCbg/GdISzAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(1800799006)(451199021)(186006)(6512007)(6486002)(6666004)(478600001)(26005)(6506007)(2616005)(38100700002)(8676002)(2906002)(8936002)(41300700001)(66476007)(5660300002)(66556008)(66946007)(316002)(6916009)(4326008)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOsdZBMt1gY0sCSqFVSTwQMjKTtbwV6M4OFW3AngaH/8KxnxeA5iQznYMopY?=
 =?us-ascii?Q?iSm7XjsaLLmtBC2PAxzyqVoB+s7IckR395t/K9lb92f7NKz2Y7NYPHfg2Eex?=
 =?us-ascii?Q?tX1ddDCVjbLWgubqH0Y5PESSBbgUFnOQiFKir20tWI3JeQoQ5HSEjuGS4GAP?=
 =?us-ascii?Q?SrAeNokKhR/A1BP90B9IK+rPuR382Ro//ujqYOz5BdZkEfl3bPE7qGmPKdT4?=
 =?us-ascii?Q?MNFwJfz2Nyd2btvlhKEdQmWfYif+IGWw7ncMvQznROF9oWJz57rNtg4qjf/U?=
 =?us-ascii?Q?PsuWjxeg1Ey2leRpKQovBti7l4+8fKqrdur7ZlVuo+ypufWCSxoGdprV5rJh?=
 =?us-ascii?Q?npMo1k+xf/TnhUqGemPLQPT0eYyTdl7OBLSyqd1pcHw4FnQFjnHcvQfgx7BP?=
 =?us-ascii?Q?i2cW5ZNY/SoMFKh770U0HFWo9QCESw9qzY7vbYB7B+AYMLwF+yrCc8MhcRJO?=
 =?us-ascii?Q?zM41guH/NkQIzXKpCJDYKMfb6+6YdRjsUawvEOarF6amw8GjXpNar9kwT81k?=
 =?us-ascii?Q?knkueRzvgJqIIPMOoo1BF7V/beaS84UlTmoC9+RkbF0vZy5ogwJTn4lRsd+w?=
 =?us-ascii?Q?m8/H2TrRi8DD8lqvAj2K1bMhs03/Ke7Qc4MlQxfCN0zJfh6EGHIpm/P8bADt?=
 =?us-ascii?Q?s4pYro/T+OukN6KPdbNahlKU1aOc3zU2stA1o8+obFRcBR1OE5lvxKBoMnpJ?=
 =?us-ascii?Q?FKDEitGkGyvHkr9op65/FdwdOGjrTANs+X21mNjH3Eim0sf5UbVMJVykzlUL?=
 =?us-ascii?Q?KZi0MrC0dCCeNVpT5iwUev68DbXsqPrpXZoH5olwk6XW2ro3tu+1mfTvWPvl?=
 =?us-ascii?Q?3WPybCStXNDonrIknF3y1eF3zrX/7/ncFF6Re8b74T/9d3P89elSFbVn9wMI?=
 =?us-ascii?Q?xGg2Xd0ZVinRPSeM7iMe8FCIWUpXeZYGbLmx734ReYo6CS7qx8awssmc+vOx?=
 =?us-ascii?Q?/I6sEuc7hvI/H2GFPdrhxYdxsDplM80HQLmhOPrVXBVpLZp4xnbEjsx4lbu1?=
 =?us-ascii?Q?kzTbyDhJzJMzoX8UZNT2+noAEfRYCJth3Hu752XYVtts5ZvVM3SfeTldAJ4D?=
 =?us-ascii?Q?P9uhbHhfGbOdfYlQqnUodsTlvwcCDnEUu2oeavjYI0ohdnv6XSxaHpsaDTky?=
 =?us-ascii?Q?2/D2W5WlCzlEMpM+miGDHg9Ye4BqjNOAMvX3Pj/f+glKI+ANfm89kn0b2S/Y?=
 =?us-ascii?Q?wPmcMbV/eJ40D/Ahr1jWtkJXJ7tGKpyIVA0AzSvTCXWjgfXje+9Ml12vdgZl?=
 =?us-ascii?Q?JGHTkz5r3e70yIYMviq7NI07z+ObPKzWwYEhIqP1vAC+lHtSkc1P0kaw6pFN?=
 =?us-ascii?Q?ZeROile8xAwzS9LgIhor2KYBCTl5JjAA/O9CBMgRZp8yuO4DilwrJSGAPMwR?=
 =?us-ascii?Q?HN19U4h6/wo9YOs+B+0WHpnSZRqVv/E/e10m3pxxCW73dsfUTJMSEMkJlt65?=
 =?us-ascii?Q?XW0vRHIIg5Wxa2ItzAFsEPrQVSDB20GC8y7ec5zwVy/kQjSdOn2DRSx8iTQA?=
 =?us-ascii?Q?V3Z+twKmrDS36gL0ImnZFHVrb1FHccUJ1mpPE/2rcnCjyGGvMgQw230WP3PB?=
 =?us-ascii?Q?UvMRWmQRtv7druO0Ii500fjplaPa5jLhP2NcaHXg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f2bf31-0be3-4885-0fc7-08db990dbefd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:20:52.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSdmAKNYtt8o7nbkxCRtHGQ5JA46CjalpzELct89Gj1SMOtePLtMTu1T0EeqdDuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 02:28:24PM -0500, Bob Pearson wrote:
> This patch set is a collection of cleanup patches previously
> posted as part of a larger set that included support for
> nonlinear or fragmented packets. It has been rebased to the
> current for-next branch after the application of three previous
> patch sets:
> 	RDMA/rxe: Fix incomplete state save in rxe_requester
> 	RDMA/rxe: Misc fixes and cleanups
> 	Enable rcu locking of verbs objects
> 
> These changes are a pre-requisite for a patch set to follow
> which implemements support for nonlinear packets. They are
> mainly a code cleanup of rxe_req.c.
> 
> Bob Pearson (8):
>   RDMA/rxe: Add pad size to struct rxe_pkt_info
>   RDMA/rxe: Isolate code to fill request roce headers
>   RDMA/rxe: Isolate request payload code in a subroutine
>   RDMA/rxe: Remove paylen parameter from rxe_init_packet
>   RDMA/rxe: Isolate code to build request packet
>   RDMA/rxe: Put fake udp send code in a subroutine
>   RDMA/rxe: Combine setting pkt info
>   RDMA/rxe: Move next_opcode to rxe_opcode.c

This doesn't apply to anything I have so I'm going to drop it for now,
resend it when it can be applied

I didn't notice anything troubling in it

Thanks,
Jason
