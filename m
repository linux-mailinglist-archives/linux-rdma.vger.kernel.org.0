Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6D584493
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 19:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiG1RCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiG1RCx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 13:02:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488F7390F
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 10:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLtdsMvf48xCQlVG6PuB5ajSI5zqwFV7VuD7mWzxWJ0aeFn3jASHyIV6dDvxtL0klqB/TTznwDKL+9g3mpg9NPqD+vVYInYA0z1tU+LHhtZQ8Lzx9L9Y9gbNfqQTEUUa7Y81PDeNQmwu8+kY4dfTTD9ErZE+IBIwFKGVdrzGpLkZN8c6HvnEnCKCm9k/Bpulq5GIzFDlqpYBzTjJpY6mJ+CNXQ30S9PQQtH+J+dZSQVoBL3P77rUO8cZ9e2aBx1LhHExCUfZRugNb2jNrKArM1EB/7s1X8j2oMMT9Il45WHYc78w33INxaychLSv9ei8LVpFX4X0V6/P6wFR5a5YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jU/vIUeNXYmiWPB08DXdvMuhv9CxWUX/HFvtpAKsWQ=;
 b=g0LcAeKO9c6/1O4WVRvzkRbseXk68YbFAgjqfh462qT6tdrNJSXbnd7GuX9kltM1SAzDB7Re5Ys6YgGXgcbVj4WJkRU7Le1iyZiWjrHLMHPXAd8RoT+4U3CTllz7m5CH7mN0EPz46mwsQ00o3VOzagNGMl26hsL3Mo1J8iYTELtTLpy9PAzb30ujUQVlwZd872LR4UfLJ0m2JvuGik4xGmwzFxWsX3TgF+gLWg46VDoEmIima6XYTHanKY9tdPKzR3Y/EI9RWnDzvmc2o0PQkMONhrpLHvfZRA7+SB4KNxNbGiVHZoaPgiPHPbfWsPLgTpzprKI1jlvaVZc9ZID+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jU/vIUeNXYmiWPB08DXdvMuhv9CxWUX/HFvtpAKsWQ=;
 b=MkFumiTg42BJ2x1QbobZepx2NvFrc8X9AN/ekWI1qypVLmGu7hRNwzBZSlvniEc2LWZbS5KsiIFb4/G4cYy9Bfy2/AQV6QOnbfN8wM7u28KH5YxY5i86Ja1ykULkGenkMsIz7eJ/b14FtlMT4vnvF9qV6rrA9nygkD+IzT+v9HKZacveerzkD1xE5F1Swk8MeDXXNBLi5c74ZFUlBWR8BmBglNb4TCbtlF0tpkCG5RGVZcvkewHCmClynGvjKij0OijjWrwRJL/NKNCj1OYu0jDABZOsfrVHiY+gjCYKrodnV5TpHnrASDjaY++qehW8EgtcVviqkfUJsHi1Wmn2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:02:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:02:46 +0000
Date:   Thu, 28 Jul 2022 13:38:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix qp error handler
Message-ID: <YuK7lpdGA3e+1jBs@nvidia.com>
References: <20220726045631.183632-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726045631.183632-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9013d574-2b9e-41a4-6a41-08da70bafe96
X-MS-TrafficTypeDiagnostic: DM6PR12MB4548:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4q9WOcBKdCfpxilr8Vw91VzuhZ5lZ+R5q2AjVrEWDryxNgMFBd003IkiYKfMcQa8biOYmuL6PrJ5IRCrI5nsng59HPIs5KogT2MCnshSolTtsux8njOuEKc08tDiDfEkhcYN3MKqm8+hjTeTzTna6EyZvt1GewL5BBHcyvRt+r3HGtoKfzz5FTz8dF7ZK3xqlDY11pTRsLYVFo/snhWB+h6W4nzFJpIxtuYdyPQd9/uWVDvcIoDY3vjDqZBBxiDhgU3brEm4mQpsNt+g5GCwQmJTBuwN0cWhtNwLoXJL3dbqOYlDhAWFk67Sqz8n6LRr7FuQDHViqtoOVtNSHgepgzup2ISlcVRg1Ht7FmJihzJkLLWQngqPvpv7QXpFhAgtOV6RJy+3r2IyH6BgYPmFXoUfWf3rOmHYhnYC/eKyo3nltuN57DAPmgbOBrCSG7UxXx5a83gqJzoDJvWKKHeD4dKr72m6yHGbyJ4VsSzctAfxTt0DrQrtf/GoBI7CD9yIE3wG1URcUW+fJtcWQh+uCPacJTwqqYQRFGWLDpMmrrEZgGMAfBEhr2COGtOEc/LDluVxaARcnUKdeHCH0A4WM/L8mbrD/rSnYnuvOctUL/a9vJu6qQ82Lzel8KS0D/LX0AKQcRUOzwwYixTGmXa/sbkpKrwk/zTmRTNgcCvNYyOD2uiuFVdI71gjN1XQnVUgIpJNwbygxfDExnAGxmpIO9/uaBg+4UMxzh+dlMGRx/tk+IWxPUQKq+DEUB1CNgpHu5MBLnGXluwC1FBSvlvEtIRC8vf7AIV74zdT28wZkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66476007)(8936002)(8676002)(186003)(83380400001)(6916009)(66556008)(316002)(66946007)(5660300002)(4326008)(36756003)(2616005)(6512007)(41300700001)(6506007)(2906002)(4744005)(38100700002)(6486002)(86362001)(478600001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1YL7MujaEc9BcdYZOSXTvlaobHwO6/XN31crxSE8Ls6OwJfsIFnEQe16nHa?=
 =?us-ascii?Q?YIQqMA0/QmYp+mtJ70w9bWUQqY4ft2RDCRbvU+vwvLU5uvKRdm/ob7vdDQ9k?=
 =?us-ascii?Q?d+zb/JgKu/wLMVldy4prNbn6b3DHutAxglDNV7TRv2vgN5ITT+wpWdRIZ6sQ?=
 =?us-ascii?Q?ODUdffGMBmf2qCw9bfePg2O7BSTDANMseynB+5r9rlbwOsyPIaUVqydLGUfI?=
 =?us-ascii?Q?Nfq8/drBAmR+pCmKv0ncepf5i9FFXw8iGz7/TGp5+vTFfgh+bfpDrSmVYyXp?=
 =?us-ascii?Q?Yj14g02kJPTdaZAWIBoVHjpH1GmLz+mH3ABBGTlI1a04xj5WYJVbpAdUuui8?=
 =?us-ascii?Q?AxanA7E1lxE8egxXGk3+YK3uS21vaNa9UcpK/xfgUbnVdvTDGx8K/pEkYBcq?=
 =?us-ascii?Q?kz/Ng8qNS1F2Ve3vu61JgfJyxCrYomSbe5We2VgK8/EeV3jKYmyXGvd/k474?=
 =?us-ascii?Q?WyMYYV76mDjVUzgGE/aFNu34zJq+1Y8X5AQt8s17XCantKuz/p76zOsUDUUY?=
 =?us-ascii?Q?ng4NoHV+d/RZAfa3TSnbJ7A2hHy1SaWN+pWLnLPDXfkXBbTkHBoz1b5Q0RCx?=
 =?us-ascii?Q?PRlWadVIryEfBmrFesde/X5VZtDTdXLnT0YYqjpzL9jsuZALv2VPXx7v5Fzd?=
 =?us-ascii?Q?dgiruoLXABevGduj//XgnawH3QrfByIrebxJRiZwDHYyT5cat9qCg0XDyTsv?=
 =?us-ascii?Q?f37g3VWjt1yHmItgB/Ie5Skf3gpP43aY5PoBMu+/WhpSN5nz8XHupZzSQ3SO?=
 =?us-ascii?Q?VDBn7petLnBvsXGBnceYg7cWuuKeuL9Qn4OsP9bMb37/Zm8NSro8BQmAsPF0?=
 =?us-ascii?Q?CWNBSCB3T/CGZmPSshTaFptR76czhlnSRJpekj3/XoQ+gcWhWR0M55t+ZULk?=
 =?us-ascii?Q?CPCsGrFXRixK/jSuzFKqPJTcskAZJ7pWe5orYnbqkgdx4JGS2rJoUz7LxWd7?=
 =?us-ascii?Q?vdbhknRBdBtpelBV5cXxjQ5viLqcRfK5uSe+p8ypZQWxB0ymPVc48+2blW9p?=
 =?us-ascii?Q?TASGsfzZlQTr9Ogs1RN1uYK7KEs+v/kNGntvWbXl0xdQ59mBZvMAy+2TYBIm?=
 =?us-ascii?Q?cXCWcCd42PRftpTfiMUeVi5lpucHAuPO8+BDTfRD8oHEaVsAxwROwO6Oc8Y8?=
 =?us-ascii?Q?E2lLGRFYThrO+lBZ+6h8P7QiYPv4z4HGEnI9IeqVej/B9dUBiwir7lffGWOf?=
 =?us-ascii?Q?nft0NkffeVDl2oQeLtslhE8FkD9+gqmqQmjl4PZKw0lIHv+D2RRqFTOn7vts?=
 =?us-ascii?Q?FxrhY5UgcLd9xL+KvEKFOnQXndVvP66a7t1Rn+iTp0IaMnSp6bT1nKdd+1zr?=
 =?us-ascii?Q?hk7FqLDgVhrCQMqB2dbazPaj2yUf5thVmkVRaso0U4ZN8wuYjsdSdwHVKoNa?=
 =?us-ascii?Q?Iw/R17jEs2OvXfMyZ6hmt4ChdyQMjaqLxYod9HBggvfLU/k8/YkX/3tCCLoA?=
 =?us-ascii?Q?/HTMklMjAPZYJyzXxP3pqK40bHRUsD02f1UBWh932rOEL1FRkVUctiKzQDks?=
 =?us-ascii?Q?/lkz6VswHy3KO2Wg9oTsiQsMeAXa4twM1w9rSHTxV7iIKq+UXH3k73zZYHOp?=
 =?us-ascii?Q?m3/jnNMJgi76NF6VJ/pwS3H7KKpMNzDO31yrbI2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9013d574-2b9e-41a4-6a41-08da70bafe96
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:02:46.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AZHvPY5bjxprRdB40rboZZCWXSVHVk6VwWAY7/RiX1XI8tnF8DJxSrifcz7kGUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 26, 2022 at 12:56:31AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> About 7 spin locks in qp creation needs to be initialized. Now these
> spin locks are initialized in the function rxe_qp_init_misc. This
> will avoid the error "initialize spin locks before use".

Explain the problem completely please, is this triggered in an error
unwind case?
 
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com

This isn't the right format for reported by

Jason
