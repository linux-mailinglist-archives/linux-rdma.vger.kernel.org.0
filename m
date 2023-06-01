Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6771E9E7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjFAQKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjFAQKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 12:10:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7018F
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 09:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPAkkYBhSBaPYvbrHJlFWHqoLG6NK/3Noagomgpezp2IYeRgy42s7XWJmrImV8bdHQtTtSpO+5AprjtCWvL55kkt4a1sxzFkuDvn+puZXnxwJru0x90p1evb4eoYDbMWg9vaNtZWgbskWOZPra3iF9GrROoXF3FPw518eXFw2dJn5x8FmLAkzRxMac7irYCm5QXRHdIIIRonWTVuIQXJV3qYrXl97OoTJDbsNWW01UmKmBprwIchgXUcnmbnPPKFI2u1q5TBBgmEa5M8iQpMfTEDdMBfUmat1FH4Bsj5qOZ67wLAd4oSlO+iJxfoeIUOSZNf1MCB/ez5cvcAhSdWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixErn+rYHv1i1pbbIa6uafc+5iaW2h6wC/mDTr43t3Y=;
 b=iVZSCyCeaFEHzANvGsCEoREXePfhyf+E8Xh9+6HsWk0f1AfFx0qrnOimcyypvaZhnXuSd7dRsl/TsoXw18ESgz9U9PjYB+r32Tf6F3/vtXLCO2SiXnQqmx7ucqEmzmOtTRl7ln+ySQeNLtr08u7eEWHTPAiDb1RVqtPE1hIKDfxEjvspKQanQJ2q/5WiKMP3w4ouNLKvh0GqBDh+EnsLzxWVDz91GFC8oH+e6jE2YMmaY6vHQAPRz1Lu0SfNTwVP3m9Ulant2/cVLsTjzNTer5KkaWCgF1a1DR8aPcrRgHLf9WZTaVk5XejQ/X/ffUymLYd89vz/nk4ziRhRM0yFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixErn+rYHv1i1pbbIa6uafc+5iaW2h6wC/mDTr43t3Y=;
 b=oOQgKKZCH6XoPffHYvZam/LF53Fw+eZqu2QOgSc0K2qb3YW16lHDCwvWlOL4Ka0AfLm8QTlsdaBGcBJZ018sl29txHt6BLO5S6Gw3bcF/vT0bSafl126YgWOxbhxdvPYqbHry4YhvxJPIPssMAsi24qVunyODsMMjPWp8hDtt+P+9H2+Gmll5htZLzX/d3itjdiM884WRY/CO/mXnPC3gt2hnvAG6iuzl+KOjOSAlGDUTX3GK7GoXZWMO0LhBkmJU+GlbPcQiONRcuKSo8CYlX4y/Vog38g+Jvy0mP1WVD8bQE4+6OH7bJnNXByTnmACX5Czfr295m4BEwS542QDOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 16:10:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 16:10:05 +0000
Date:   Thu, 1 Jun 2023 13:10:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolas Morey <nmorey@suse.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        zyjzyj2000@gmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: remove dangling declaration of
 rxe_cq_disable
Message-ID: <ZHjC2rJdI87YE5ME@nvidia.com>
References: <4f20ffc5-b2c4-0c11-2883-a835caf01a94@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f20ffc5-b2c4-0c11-2883-a835caf01a94@suse.com>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e890a1-db8b-4c57-0107-08db62baa9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNstPflZkbDsRJy+FAQD98C9TGZ8DHE3UGDgudEElZM2/FteyNHjuWjY1Ys59Vr5dCkIY8MGKuF3e8haCrMIzL+LDcJpKgzDkzJPZjSSiBpe1p89zP8BumUvoiVLHshP1XuXAqWbeVTQqkFgdDcJZrrNM0I4nZyUDxXjWHoZn0LK2aq/TarC5wlFwAplJ5nbNMB0/LHUhWZn6XGdVXiAliK5MsfVHFRutDfua6c/FZ/hQUIrGszSpiLmEcWyPXNCW/NoQyTAumN19YUR5q263gv6zEV7IvWwiJ3WBp2TzlwTNNGyNwoTt8qLigrSjSjtBlGB1w3VO3zqvPVGFXMZ9ffEJvopTZJBIsWeDsVJIYageYdtUr5wS5Q0i28yaoIv8EwM98fdzTkc0mqcVCfOPOl96++shNJ1Vm7dHWMl2nSfMpjnKe0+78IuCLvloeBr0rAu3qKz2Vz7XUULRV1KvgKtljdHU/dvwpYzzqesbbRPaiTVIuEoyxNz7JHHQ+FcCAsLxOkZre1/0sWAldxwFx5EyT9D4X8STfoSnUJcx2/tfX8BRykbHTMjczpfjooG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(26005)(41300700001)(38100700002)(6486002)(6666004)(186003)(6512007)(83380400001)(6506007)(2616005)(478600001)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(316002)(5660300002)(8936002)(36756003)(2906002)(4744005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4uUU/nX18nhNIDCvGVTWuSrG/+zlT9vR0RXPb4OTEUbliAVPniOOuVvaQ8V?=
 =?us-ascii?Q?0zfSiHzq/1ilCu3n+RLbYnZEZkBBzrQHc0y+46aoau+Kr9YE9nYULWF1Bx94?=
 =?us-ascii?Q?/TUuk682AkjwC2GkX3unorXukL0o6GjKWg7Im/Dws0r7+EC3AJjiAkjNZs/s?=
 =?us-ascii?Q?xSt9dvhdPirc7pfSeJMSVnUW5szyN3obMLU9+DEWEif1XkPs2qnQxZDfeDha?=
 =?us-ascii?Q?eKz3q+I5/k1kVwWdC/C8iyERjYaRQE7fwDVm9/CEKimT2ciWdOnikloR5PWV?=
 =?us-ascii?Q?pj33jW9ry6gXiFq3z1LsqPLI5RbO9/tUdH4/WozV9SEcyvlelbgu4LgnzwzP?=
 =?us-ascii?Q?2iZGcXtUmVFcIacR+MZLZnzjBlIIAO+qMCHR3G53pmHegzY6YwXiRwPF8DDR?=
 =?us-ascii?Q?n3T94r39ysbERQ1kLiVO2wujMd//+v3ixjHNuDLo/9RJIkaAVma4BpHAHfMg?=
 =?us-ascii?Q?h85jj5K9cv5BqxJgsKq1210IT9GLnckvIHDYb2zNXlp9b/FRowBlKhiPczcv?=
 =?us-ascii?Q?J1tFsnzoN4g+mCySrSOJveauWd/wjygzHmT9sl06TVTgFvXkkF95JEb5JykD?=
 =?us-ascii?Q?jXeb+GVL6q+MaNccylT/LJUxPojxN4yxa7jOYt/Yo6oXHDF+sJZzoSgHT/jS?=
 =?us-ascii?Q?Q1Gp2Zqxjh9vMuZNxVYIAAdspOCEOteLfCnqY8axQS56Tg/V5x3k3pwnz7cu?=
 =?us-ascii?Q?xtQfZrH+8sLJKs/JwboVz3rTYRlTiBDKkJXibweZa6u8KYHYhoOiOhVmx/94?=
 =?us-ascii?Q?0saqjSOVCn9+qB+1CpHBR0DgZ1XUMd6aWqvKRNAvmyewcYWd0JxoVjTDb1hV?=
 =?us-ascii?Q?n/dUyyL+tMyqgZ/Dxzm1N+TQEqYD93JGDz14K9667o9nl2wrNuFlWsusYiaB?=
 =?us-ascii?Q?teQI0xcCCuGDob2NLE8Yp6jyhAxpqfcU+X4Ib/1sDntsAE1uOftf28yWOLm4?=
 =?us-ascii?Q?lKWHKnPIHO6krh+L6nU/YRJMhg9LLClCJQAu/G6zol+uyXobjZh68uT1YaUV?=
 =?us-ascii?Q?nZhzYbl/XAw06e3PawnK8T06IgV2cgUn5mLbCfAvKfz4sVArI/GHOf8N+mDU?=
 =?us-ascii?Q?4l6AtO3IgwHD1wMVa0fcP6auK93+dp5r4wa8hhWxw3Z7t6Xw8JQEzJJ8bH5r?=
 =?us-ascii?Q?isn5KJVvfHK5DdhSQLNH2dNyOZYADDx4N6dzsIn+YwSsURtfC3LM27sKELt4?=
 =?us-ascii?Q?WAm+CQsTbQ7m8yW1sNgvm/SDSh4SqNwWViLSvVpoKXf/8zX0Im/e3gPP+zmQ?=
 =?us-ascii?Q?BAcpMRezxBqTXITaOugJFNEV4XPGad5CVz7N8jFetOma/mZRxGVYMDlp9SFd?=
 =?us-ascii?Q?9Khypo5jnjZcXPYnLohVLOALD8Mep3VdwrZMn7+BSnPmYNessmc+rMZfob/S?=
 =?us-ascii?Q?hhmJ79wZg7OzdFg09G28//SXh5Ruyzm68opvjiEjETPNoPefW+KHY6FW7xH5?=
 =?us-ascii?Q?myJFCZzz1k5vFOiOrHAq9zon7TSJYRU0Ef+TC6gUW4+KC8Ssb5EZZzT0+6rK?=
 =?us-ascii?Q?iPkyzeOjCwpiyX6kXzLMVs6uHtPFvM6N3NbVYRjx5eqJm+iz7ucBDPeXFHA1?=
 =?us-ascii?Q?evqqbmcsnYdsFpMKLZXzSrNH50jIK+U08+rkRExC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e890a1-db8b-4c57-0107-08db62baa9df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 16:10:05.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAQHKxucq8BXuZwyTalOI6loFFDNuXF1v3NHFhJuFoIpkrqcDD6yIGBSVKVP4iLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 24, 2023 at 10:52:20AM +0200, Nicolas Morey wrote:
> rxe_cq_disable has been removed but not its declaration.
> Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
> 
> Signed-off-by: Nicolas Morey <nmorey@suse.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
