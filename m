Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25054F9AA7
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiDHQdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiDHQdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 12:33:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905741DEC0A;
        Fri,  8 Apr 2022 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfVHXqeSF2GFIxM/d+PyxCCrcIY8BudShVAW4uZFOAfPDsmNOfvRXrJuGybUO8LRjWN9Rwgf2bwzlY8JyLeJGL9jgS04qnakejmpOGBqZ9iNdewrbOJPeesvT+OtcGNLoNc0rRorHuHEF7wci79sC+1RxTruWVaLsiBr82YORXxQLq69yah0Lu+U4noIhnBMVY0jz/8QBPr6Oo26PlJYVOW4UV8gohnHLzyxJNgZcx4X/N8PFn0rcqJOmmDM+k/QvzSowJ1jg8CavClafziK2fktWiwGdeEfhhIovj01hXiNYQbcpOgrBZMY7KUDTa/sqQufEGtFxGdNNa9leFBgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H57VerlsJscYWoksEzSWMWx3rPmbSRzu+IDZKBL9Di8=;
 b=PZ1DKLqgZZ6YvXTIhPh31m+bxloIpjtliJNOdvVd4pWDQaWhPBy3WO7Qz82H17ri/xvLd2a2eRvdzrI2Y/aU3PNC47uYT9VvVYwuFq4up706Nkv1+Wp1iB2E3m6ldm6Fg7T8VmIEKajpb1aoHDhbjz3R1+k89hXf2J/BnIje9aWdkq7zHYbmvTZw5d+bqRP8aMDL3QsnNDvUdE6/ynWPvc8wb4KZUV9QxcQ7djp2FNrD2OZkGqbxPka+TmiNTH4hA2uP69Fjph1jG+hUsn15OF2Znt0JItt2R1uYbdnwu1bPYZ79pfGceWGqvqpaf4n4CPXXJvey9qn08nxJhvryKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H57VerlsJscYWoksEzSWMWx3rPmbSRzu+IDZKBL9Di8=;
 b=qeIo5rwmjKf0AVdbgSN+7j1xlibQ/JuUjxTbEyGHUJBbz81YcxcCmWgmNic4X3VAN1ODkTMfvvxSfUvHGtrcIbvFtx91C0jtUpizAIdIAP/mEg8K22kGg3PCdffXbyPWOcIIdenRj/I0v5Y3QRyeq5pVsgki5PUBZhonludfUokhU3rDt992QxkcN5LHA3gYTaarfHdTbSES7CNqZARWZCyMqisA+4j+p503ENAn0bZVlpYE2w6Z2UkKfO3HOzbHrdHFHSVgoRwRm6u0oyBE8ks58reL0T0FWBerFEn1+Nly9RKK5ftPks4FVfil2yVFOOlqDWjKsjRllbaTt3h3Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 16:31:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 16:31:31 +0000
Date:   Fri, 8 Apr 2022 13:31:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH] IB/rdmavt: add missing locks in rvt_ruc_loopback
Message-ID: <20220408163130.GA3612543@nvidia.com>
References: <20220228195144.71946-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228195144.71946-1-dossche.niels@gmail.com>
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cad2559-9b74-4c8e-8541-08da197d3d51
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53559271B982A9F7AF961ED0C2E99@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52Qi99LbZfDUlzZvtwyz/GcsfM3DWzEaEtbjyFfAiEL2fTmU0PN42EBaTN0inDtVNfx8LaTvIQdXGmqxyx7PEEUFkDJ2qn0Dsf+brIzF5hsUk0UqJPtUV0ZPKKhmYGqX/I4x0YK/iPMZXexGIR0D3q2D8kdOUU7ayWQxZVOIq26bjR1ZWPmd5ScZRrg+E4CBy1lVT0YF6byLhTOS8xFyn91FSOLAKRgRrnD0jr8I1hfwcFEz1fFZ7j+9GtojanJIkXn6BDMB1xSGeRaKtQUBht23GWatCiGSbEPmpTfSBFZEPW60IpRkFSXTln/JISNqq2L4NwDJ5NtNhQgzQzgAPiw6xYCuvfNZdIBAxtEZme6qH+KilSrCLG5dSi791+8pTHPxbhdS8expTVtntbrhJNurW7zN9EOy3C37FBvKMIANVjT8rEweqj89gwD8I6vj45sC7jxR4cSSqHGUMK4WsWh4lNBB0TgFa7pE89HWTs8efqvBQX+dTsFGiXUp3f1msSq/PffMiP5xpdc34YzrDYaRhDiKeg2GPPe14xgZd1giyAIzz/HV/3rda1TZzpRj8KV+iXblbU29z3DSH+PTAKNJy7wDb09l6is99RNkHd2/uA7oic51p9uxvU1cxRJ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(1076003)(38100700002)(26005)(2616005)(186003)(8936002)(36756003)(4744005)(33656002)(5660300002)(316002)(2906002)(6506007)(4326008)(66946007)(66556008)(66476007)(508600001)(6512007)(8676002)(6916009)(86362001)(6486002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRs9r19hLuCOUF+tkTO9V5aTSOywk9ka+37NFwK27jwWcwJNftWKk8y8XICQ?=
 =?us-ascii?Q?OaVb+lTeooeyriwWy/gl6ltyBFNPzItZkv5szmqV8FMa6Tdwk9evTYjV9njx?=
 =?us-ascii?Q?YuWodkNMRJY43Rrx93KFxzMU3/zY/bELduUV9usseSNZlxDvf+/1H/7rejFH?=
 =?us-ascii?Q?YOU5/VYMZJYh+CUXImGDAT+SrKKMvWf/ixmUbefrjvxQ8+mRu2umAoW+JSM4?=
 =?us-ascii?Q?NQKF6afnOjNCKY0Xgi/SCcL9xp8t+Py3W3U0f7HK0itE2CegG2w4a2ZHQJw4?=
 =?us-ascii?Q?gqHTwXk1i7LLu1/yWbH+A443zy3T22ssp9zVbSudoggIo08jXCV5qWcfnJ1T?=
 =?us-ascii?Q?tDMCEOyrbsiItTAU1LmIvwJnaOMB38JFubiRkES9ZtxB8QCRATNd7QNp8bGD?=
 =?us-ascii?Q?PEP/AVB5vxJrrO/Eiyo3hncBw3fKOhggyK85kAvKyKo5wGdeegoZaDU+Ad7K?=
 =?us-ascii?Q?T4MYIOgJYuh9bJ0TP3GAa70naJ6OLEqJJuhS5TMRoQ0GjrECfoSKdWuk1xv2?=
 =?us-ascii?Q?70bcGWYT16UddHbPIFOn7ukrUlJLbYrRpi5fpgrqov51tflt9cEpp32D5rt7?=
 =?us-ascii?Q?j1Ubl8IxRrOM2U5f4OXaMa8TbWyorSo8vmzBHXLcZlTm2aXaVhT9GXOkSjaq?=
 =?us-ascii?Q?J41fXcfHj8VXgWZVnjQZfvsTjRa/Chg02nOqjRij3Jp7WiV+mwV1aflgXF6k?=
 =?us-ascii?Q?7UYqZE5ds62xw1isiyo8X5o8zwdTzX/C4t2UwbpX/gp3x/VxW8oX046AAIww?=
 =?us-ascii?Q?KgG/CL2AlQ4HM8surBNlbhWHztLtu5na64BAxHDJQI1yXtzD9/N/pRwX6xCk?=
 =?us-ascii?Q?RY9g/xKfx1T++VSV7F1peyI9n1sXzA/FblWsGqNM4/KCQmxs53A8Zy9MyC5D?=
 =?us-ascii?Q?JlhuLD25FPwfBIL5F0JKgttUi7jdx4NFLd5mRMsdFlrzeVznj0lRRZEoiTG1?=
 =?us-ascii?Q?+k3jqG4lFDz6I1B/WMjiTvF1D7AtJoLRIt0k/9FjEBAvxaLTh/5LFG/Whk/3?=
 =?us-ascii?Q?ch1PreIDGvGhC4KlfL4NJpHJni2SGOHk2VwfKAJw7CKjygXzRM3lE/RpQpen?=
 =?us-ascii?Q?flsLFVR3XnduCBVeyLXKl5q3CY2v7Pz0+N73C+RH3pH7VkKNpbcFOH+FtfIS?=
 =?us-ascii?Q?KJH9Dif9ctKDg4feKqW8KokDLau5UkmULqSVfNCY9uZbKcZQoNeFMHtD6DxL?=
 =?us-ascii?Q?nUx+9on4YT44jv4aRABWFJtEI/WwPP3zX3leeSeTGaL09rsALLh9hi0k6Dcp?=
 =?us-ascii?Q?tx+50h8gv/ynmUd7sVjc92ARXpnkd5wf4nuVovjOqAHrotyueaMETQ3L16wF?=
 =?us-ascii?Q?8AtrwbJMqRHCVHrkLjsER0MBTvx/DEjW7n/fKFP0Mxc45p3KPJnqdDXGXJY1?=
 =?us-ascii?Q?yKN6Q3iJ1r6iPIy2xW0DrUGQrUM02KGaZiKHlLrY+FxvzK0FYUkRjr91CM18?=
 =?us-ascii?Q?vWvCWbfIcP2bY1Yqf5jjhGr2cl2W/WOVXR8XJP4ZqyQGvpiMVznBkXy3JLCh?=
 =?us-ascii?Q?FlsuoTaS0ZVpysDFuC4eKVWSiS9Y+dYtzPagKTGiA1b3JZ6gzNtCHgqptkUB?=
 =?us-ascii?Q?Gz6CWi2L9373Tw0T93TjdzUuiQj9035I5R3vuuIGcM+3/l4CExqvfAXvF9hp?=
 =?us-ascii?Q?edsVelC4aoIeCFrFbUOsUgrkyPtXFb6mNIDj7mmaHnPXQF8WocxtbAi4lW9e?=
 =?us-ascii?Q?BGakMPcjcnR6kJPIvkll0v2unXAmtLhfKs5jpQIf45MZsVwN7o+mJl0Lsudi?=
 =?us-ascii?Q?5zub8hnUPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cad2559-9b74-4c8e-8541-08da197d3d51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 16:31:31.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiZwP1OLUAnbKVYcZiBjSTPSiDLfkvdlTD1gPi17R3Oyjq1KTOBZYrjHjy7WYPDW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 28, 2022 at 08:51:44PM +0100, Niels Dossche wrote:
> The documentation of the function rvt_error_qp says both r_lock and
> s_lock need to be held when calling that function.
> It also asserts using lockdep that both of those locks are held.
> rvt_error_qp is called form rvt_send_cq, which is called from
> rvt_qp_complete_swqe, which is called from rvt_send_complete, which is
> called from rvt_ruc_loopback in two places. Both of these places do not
> hold r_lock. Fix this by acquiring a spin_lock of r_lock in both of
> these places.
> The r_lock acquiring cannot be added in rvt_qp_complete_swqe because
> some of its other callers already have r_lock acquired.
> 
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
