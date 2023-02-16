Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16DB69995A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBPP7c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 10:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBPP7b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 10:59:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7A4CCAB
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 07:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4vDW63jwvddtpFzdUbuOtD7WJ4Ieb95O4Lhi3JhgstB2nh6G0ngxD4LO6SWBspAvRBWKi+gUvmzQCQ5+qJF0tvIsLInk7W4ePeHe+6jvqsenS05eKGbQi+Tquayxtql5iT153aQ3yHeek2ZeCwOFAIf+1F9RLsu84LmVy4w63UDKMd38+YJEE05HasSE2gmyKnN7KGQSut4MOy4ziG2+lVfhk8NCcB/1JulGd9Iws/pbXjXPdpu2TFzam23nsxUDUdcONJ6vo4X55l4KmG8jOkceFN4OxvRUoidOdYqcnvZcZXdT9sYCrqhosT0pXJ4omqXgl/mS/xNAI9H7bKIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0lvJfrplMfJLN9dOwFPV9Ysdh3NU6AeAaBGn7yseB8=;
 b=HbCR9twGQWu0zcKcRQsxVsbaxeEq6jTmRcM7JRUBcShiykgO5+EjWM35llbjtVKqIeZY/gnnIdperrtMecwgvzdoZ0gCey+mZGF0GOnThXtqY+KJBc7mCg1C/4oF5gsQ2zIPQq/5sb8YbjeSDcIFeOXCejCC/9SUHC0x5wub+iiCkHlrHjLdTeevSwZTjYTbXlTjzHpj1KVwfEzPKN2fWeGvV9O/gPNiFTWjOK0cCJYwF7CaVvPVQG1oaz+MSAHsmtEqAjf9+6DBNexCyZttQ+6eGpF4RcLFDvxtYynFOm24bNwijogjZCCERaO59dswGADjq358xyGWoDax8F08Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0lvJfrplMfJLN9dOwFPV9Ysdh3NU6AeAaBGn7yseB8=;
 b=fuYvT8HpitD7qgBLEY30GMzXFFvvmbuPn7XVBW4qBPyDeaN5GTXaA1stRKLio/uS0KOaTEjywxCiXXl3DG4LQjHtoLDMQOXwWAEOJqKXLSjkRY6HcjZDWsI1LjtiK60M/FCM8JpfZQ/dKQeVPcU7PoSU6emDK4Hsjbdsb4FnRxmquo0Uac/dkmmWRR7LaEIw3LBQEyJTjODyev26gILciqC99x/pIyoWAyWRwRH+v+k0Q3x5OU4G84/iIGVA0zP1ELa9WENULgN/wm/vw+D80E6bu6SWqU72bYK8vMKK6RngQPKAuLCvAAiR7o4ioVLA5kCB8yWT2/v21m/fUxhyeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 15:59:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 15:59:27 +0000
Date:   Thu, 16 Feb 2023 11:59:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, rpearson@hpe.com
Subject: Re: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Message-ID: <Y+5S3uivQvdJZ3qY@nvidia.com>
References: <20230213225551.12437-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213225551.12437-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb3373a-c681-459f-f82f-08db1036c83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/Y8tDr5LIkmY8Q5kOPCcLDLgBuS+mYFoAO1CIrma73LDNOlsrPxtIucp3+YjqekBKAvFVvkuNprxKdNbGauL3z+A7CHM8Mr98Z8KGGHy+thrMYJKr8N5r+vQayhfO/EyXe26Pt+QQ9lHLQXioZJAq5YRw5LT11dvNV46/HbufyER7wi7dQI4cmQ5vQg3jM+m6Npl8uACHgxVVtmz0e4qScqQNjs9huFHlkOnQOAMjJDdsqy7wIhcb1BCL+OL7a8pfClLj+v1/83IA/EtSOrsu2qGZ3tT7NOzEySRAbxjTddaecTIoMRmUb41Flg+TmA73054Oa85Q6rRRg77fruoM7Loo7GDIuJl5OJheMUH7Q0A2v6yOPGDb/1UcOWYJ1Cg5EB437UG8tvI3kcQlP6/0LyOqn2Y+9AuqOzXrwwkqysfAsPaTwS+k3sGEKuNrc/09s6Ap3s5FkWPKGmGtzycguuUCLZY8kfxTum9jkh+sc3NUJLSlQ87SiSwRwN/VbgMVuNqriN1IfFc7CpJBAfMVz0CMl3TT9IjfMIMrqN3wQsW+Dm/zqdOsRi6YaLKdUJ06s4gRKnaCiaPdGPHtI0ESF8jK0+zCRlmyScFPqwXsXFbvuonQ59xQFR99mXiBPwV2Dc7xiBO9qHtVafaNNQUzcadEjqMSIuH1gyomlNLEzsuO5XI2kRAgrD/x9CtuBB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(41300700001)(8936002)(478600001)(6486002)(316002)(5660300002)(4326008)(6916009)(66946007)(66556008)(66476007)(8676002)(2906002)(36756003)(38100700002)(83380400001)(26005)(2616005)(6512007)(186003)(6506007)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwboVfA7NpGyNijej0sV5MwQlaAuMoFsbh+xBnUih8H0XL0BxrqtG5FJ7wom?=
 =?us-ascii?Q?5mKtrkfFvlfYlDvXUINWr5F6DAz4EPJlUI8oDNCJSaj4eeazBtnxilMD8YRW?=
 =?us-ascii?Q?V62vzJIxs1kV4YqWGhWTJwj++a2l/E8vouP/4Kl4SyueA6kp0rqQ/dDFGSnc?=
 =?us-ascii?Q?R6EztpkTjRAumKnZgEOnaD+DADSnQkMh7pZad63aZa3msniPQ3Pi/RmlxXTb?=
 =?us-ascii?Q?lPZ5cmOVldtoeyAWbSBa/2B+kpb/Dp4PhDyXdhSMLhOyce1YX7eBVpxi8R7j?=
 =?us-ascii?Q?KF1TXpJWIsoz5rDggJaFklpFcamewxlJHDiOdEiBJ3lDUplD9d7pBZGcK6GZ?=
 =?us-ascii?Q?WnLaj8H6cZ4Teee10C4UTXeJ+49Go3k9ACuZDHLrV82Rlkn9ElZlCc7guf7U?=
 =?us-ascii?Q?lDMOnKUmjsLDSP9BWuBDCvdnUP79w411ZzT4Ua5dDawW+OGyVTYKj17nohs0?=
 =?us-ascii?Q?wW70hX+KOCrvd/JelEpzo/5EJRnf0K3dYwGNgdnPjX2y6K99EChzL7QFGwA3?=
 =?us-ascii?Q?xKUO1PtrTpHfpYud/aB0xafCztsOtKQ0UJJ0/jYnm4jV82Swd+2zCo53+qhP?=
 =?us-ascii?Q?/mJBB+H4n8tb4df3rl7DD+2/5pxPHaE4Bp65HZ7v5+hB29s+BgUmz3SI3Tso?=
 =?us-ascii?Q?Nor3STdGyRfjeT8diBk+wzC7MpnTq8NUgxQC4WdsMYfg++OP27xNyl0cDVlC?=
 =?us-ascii?Q?7yeZz8VfwIzu+FQOVJAlvtrCuGffdyiNcCcI5RYxMHzZiRMHGmO9O5jU3VJ2?=
 =?us-ascii?Q?JKr4+4/5znkpMzsmiWYga22sb0i+pXLDA6mjnGAOvJWEU1IeeQIs3E+9UrjV?=
 =?us-ascii?Q?ivYeq/eSsnhiCijdV8PvwML+JBGyPtmBQn/FFUGwWL20X6P8g3rPChhMZVIN?=
 =?us-ascii?Q?1YXqwmXq2RnqwLf0MitvWRQQuu8//N7GmWU377J+popo5wvbB7Kw/6HshSXN?=
 =?us-ascii?Q?b3lrWW4/i7ia0p/z7F1s6AaZUJ9BJSWq5uCSMsb+mBxInm0jDQay4dh+xrje?=
 =?us-ascii?Q?OvHvFB1/fjVvP/vs65vDFcmXgdir7vsSsKPz2Gu8Nb8LW5VfU1DrfRdeS7I4?=
 =?us-ascii?Q?2TEeqlcsLr0o8Kwz+Wcj0x5gDhifAx5suHvI8nhgDPmiEMc8QXjawezCYZTn?=
 =?us-ascii?Q?05ovB0WIuiDIb9RHFBogvD+VZJdRTIhJGwZROJTGUNtvX6WTnDRoB4hfdepE?=
 =?us-ascii?Q?sNk9wFmo7+t6OrJL5vsPKfPLhrK2QSuzA9y3VCAL9Oq9si6koggoJdH2OOmT?=
 =?us-ascii?Q?8v9gzPZjOXFMCv3so2EEaCct8Zdjz7ZcXFddD4GMl6lpPMkj+J2UK0xFQg+0?=
 =?us-ascii?Q?4r9ydnMpRadd8UV0MtBBlU+7g4zpC4CsqCpSCT8ksKst2tpzX613VDTgYxyG?=
 =?us-ascii?Q?0xGIQb2WKjp1SWuB+bbHg6IJCENQU3iw+gsOt0sNGU9Egyj52Jz3J/yxzL1v?=
 =?us-ascii?Q?Wfh27fm1vfXmlVGFBoyX+QhWgw3sPKeSQwk1FlzUbcCcZkvC+YCV0rxwCRwh?=
 =?us-ascii?Q?n+reAXv2FKzNKb3oqskDc3U6mNaOj0We6lzK9BILp0QxjH6GpgBiD3dFsKtG?=
 =?us-ascii?Q?yGBO6ZLUJAhFFjjl+dFHWUAXqt/OkpOXfUfada6H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb3373a-c681-459f-f82f-08db1036c83f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:59:27.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d1fEfWZQwhs7SGSjSv+EGpP+nQNFBROQnoBz68L0QRKfft3J3FaOo6iLATgQI27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 13, 2023 at 04:55:52PM -0600, Bob Pearson wrote:
> Currently all the object types in the rxe driver are allocated in
> rdma-core except for MRs. By moving tha kzalloc() call outside of
> the pool code the rxe_alloc() subroutine can be eliminated and code
> checking for MR as a special case can be removed.
> 
> This patch moves the kzalloc() and kfree_rcu() calls into the mr
> registration and destruction verbs. It removes that code from
> rxe_pool.c including the rxe_alloc() subroutine which is no longer
> used.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>
> Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 46 --------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h  |  3 --
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 61 +++++++++++++++++++--------
>  4 files changed, 45 insertions(+), 67 deletions(-)

Applied to for-next, thanks

Jason
