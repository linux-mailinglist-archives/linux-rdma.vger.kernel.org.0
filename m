Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32786118D3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJ1RGM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJ1REd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:04:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74D107ABD
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 10:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxKV2Tp7T1SZweMtSWYlThNxbMJ799Ao7KxyL8hTI716cy5+WnwqGeEoPLI+jq2YwFEvlC+vCYQxe9Ruo94i2R6DGXFxaigRt20BP4XJNo3p644hhafXuiONO6SCE2oGtIpC22r56hm1a6/BOr67epk1yCH9oiBjxj9ZnhUHL3oacNDeTZdV2A2cA8pg6XuzhGJfHOWELZVlsEwn43egfTManrZEOm7z2PzpETlssqx70xpbdhrjOCT8MQegXlwcQzr4ebxMrrrmjN38TkK5O6cVd+WynrBXaXaaUwAyBmeF5Vw2J3yUbbOrb0tWgEhgIsCVoGgPhwoeXUnrcRoLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTnEJULAGdRfXJ+ZVmD9+E3XGix8jhpOAOWlHHh9utQ=;
 b=X1tWFTxZK3riMhxJf6HJ0D/38bjhwwuEmqB4zGHIU2HvR2a8Cf/H+w20gP7zhzj/FQoRcJ9TCk3n1mhr8g4BDPHmvZjmbmK1mzBbbotKXwS5eE4imctilpN33o/99+xZoPTNJM41zv590u0r108pxrtaQMkzM5RepTCOeKTYFNHtzEY1UuS6BzyT0/0a1p4kcn+nXZTChHBFO56N9KZRin+nqch88N4ID8TRTL2hMGD8P+zaJ6vry06ty4TpCqXzZrvXgnj+gYYBVkohQebGqJfxciKE7MAPhvmgbqglpcekvcG5w63IwKk0uAvotb/NNd3QinntrWLeYmfcm2qVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTnEJULAGdRfXJ+ZVmD9+E3XGix8jhpOAOWlHHh9utQ=;
 b=CUPptqp7NBkrsy78+9DjS75QddLP+gzna17NUwXlu8kKLBKd1/+ZhvuTw/KmeLuW9mbKKxIjVd12HsMQaiqpQ5+0+fomimWJ4euLk4JEUpLz5VIdJvDPdo6RL7XKTksP1jrn+QpQJla2OSkbLXRFQZ0Y0glTDaMhxHxazytvjFjC6CutfqzAxRfV6Y8I92o5/ZgYm214OTPgCcM970H2O9NEK7aKL9lh7z+D9cQM/DUa443cVOtDWTYpDdknknirAACpnVQRatWEUhFIViuZjcm+YeXdZdhnJzlh9C1ls1AMQ3T1Nv0Bet8zFFOGIYXzAsebPgWvf4EKWKPBxSZMrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:04:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:04:12 +0000
Date:   Fri, 28 Oct 2022 14:04:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, jhack@hpe.com,
        ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Implement work queues for rdma_rxe
Message-ID: <Y1wLi5lFAGeeS9T3@nvidia.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b72456-50c4-42ac-8d63-08dab9066fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IpgRLKiZ2RBeRv/SJgmEUVIPIlPwBJ31+y477rAiXg4ca23tFd3aypXtvvyaHTsapckdPHYIoQlRbSAMDAUqjFLK3vV+gC4Jdz5BzwULkQMgbb24NC0Z000BNO8nTMYGiRwYpS8tT3HqE07vGqeTHuxEhGPmmaWvQ8femdPwDSOUGqi57M35hd87RsQMbsxu0F8zwEZBg8Td6JUF1hIxWGKYX3icFnLHY/nvsZucJuvRlun+jA+u9y08oi8CwFllF2yu1infA8bYyTt0SdFfJ890krt0O2jmXoBHyPYEzp8AAeDhqr/E/0A3QaKQvRVrik/CFsQvYaqbnzGPZ6a6ksCayhZbSEQSZRC+6PTlyAeFaKvTDSLNRBD19gsoZ0QKFMHSydxh2Gc4nckYD3JoL6+hrdjB5Sdb/Hrxbn9o2bOQ9RUcQrx8igpK4wIyKbpVOlUOOnZl+ojY0r5lmVJtej/SPYiE7yNN528X4IU/aFjaJ3kpG6iIKbzPyXsaQzBZ7GuKGt2XH3xiNzvuO0aKHuYvFGYC919Fmia0a8R/a/eIiv39BQv6Cd5oitq56er8JUuM5yPMIQqGjOuqA6zNxJ3zd3PLTiIjbuIQu/Adpo+vHahywJq5xFTPlI3kV4ZaqbOzeImXZp0EmUiOGE9VSrMKndL/8u3KEThj4OmKROlpn7x3XkjVjMagHAZkR/vjvC1qSZjwxFoCGeXwzgpGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(6506007)(4326008)(66556008)(66476007)(8676002)(66946007)(4744005)(26005)(2616005)(5660300002)(36756003)(83380400001)(2906002)(41300700001)(8936002)(6512007)(186003)(86362001)(38100700002)(6486002)(478600001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+3U2lwGdtWa2G0Ir8crY3bQ8NMQunB3rjWcuj/0EtYOCRIkx8fj+KUmQ87AJ?=
 =?us-ascii?Q?zMBHS0KneILhkNQplteXYgaX5k5nSWzDYIk6yCY2k0r1hhnGz+3MVAOqiNcH?=
 =?us-ascii?Q?78sWcw/L56KA+q2+2IAOx/6aJTMUPq8P++GfWj7PNRPdTzc0TudSddWL3mCb?=
 =?us-ascii?Q?7ZOlUw553IHUwLmRWFGiUlhzE+uSanDNdsHAbWUqGCCEMGoSZVsIw7/PeltP?=
 =?us-ascii?Q?HXwOJGc8its2O+vS9+XCIHkeERV7TNIOsHHEFRiUpMgSdP4jHlLKBziMKNNj?=
 =?us-ascii?Q?Ra+MUgYutASDM2QSZX2Lx6rzEtAUNVT1/O/XXwJCMUQ6uFv+C/Wu+I87b9Cc?=
 =?us-ascii?Q?fz09gbdP7gP156qw2AyHkh7n9IgnHZqTosxQslc4ARTtNgqtmtJ2sFjnsOUy?=
 =?us-ascii?Q?rXQPsBXLK+EP8ZL59QzxgMjSe5HbK+XBnfNE+5cqBI3GD0M0kL7afNaizjj+?=
 =?us-ascii?Q?ibAleOuzxBHID/rQ1asCgj/zDnf3AZst5pv3vYvFL6s1KCSVAmPxCtDxBS+N?=
 =?us-ascii?Q?EaFX0wvXhTLX9diHXLVKr+4B+HzFP4hNj8aMVuxb0Rkd8UDTbZLP0ktDsj6S?=
 =?us-ascii?Q?74uEFM+YlvCRy4wE5C3NEGTJAEc8fXkCRYlm/thz+Agt5iRcWbPN5Wfnt0LS?=
 =?us-ascii?Q?aYM1SCBjy2ctMg8exj4lZ86mp7aoZHCOVk4sPU5UrD6fR0VZRH9tsXpjq8X8?=
 =?us-ascii?Q?WA47xOdFIZo274Qp5lKGv0RQY7w7OKTAyGDWeUHQCpRU+Y5W5+y/3Bicbcar?=
 =?us-ascii?Q?ZZ8r+XAXracTjXylbCAwkihif2EmVakdg3mSiLOyNQgB1cgrPwBdD+iPl8HH?=
 =?us-ascii?Q?FJbmVcnrbbsadlSOGJm98Y+x8hNWZGGzVwb3lSe7WJlRkDHt9p8T6XmYX8HT?=
 =?us-ascii?Q?OjIsoTNXN7enp15VRLOXKxF4/s/srABfYzgCm1lob6gh4fU2asr//tthcsxe?=
 =?us-ascii?Q?7Ht1dhee0ieRtNW10Ho/SjBi79bsuax1IhgokaGblw5CXYKyAq/kwULzfQfl?=
 =?us-ascii?Q?/M5tujiTUxO6tjG+JTCm2JJb3U5BtrTCKCrVOhfIATlR9WMNzMgK9M3sjLZZ?=
 =?us-ascii?Q?QswM+TMd1tafJVTHdvnMx9Ght83Du2oG4/ilpt7hVfizFjaOWtsYxj8/XDkj?=
 =?us-ascii?Q?ZyzHOB3uiTyKAmFpBvtSVmNE+vDIoyIyzHA2yLgezYPgjxskI+v9omHce13b?=
 =?us-ascii?Q?J+yIkZ6UyDKxpAgx/c3p7/zlL+7pTUc1aGdfCZo0ELftxEWQ0WZDoANCYgzC?=
 =?us-ascii?Q?I0t28t3/P4i4m0qYDN94NL1SRElaHwOCNAPSVyldDYbYDSeVWhETgw5Ipf8+?=
 =?us-ascii?Q?QXwl3CI8t4VQt3EUW1ClWt3fImf1jURGVMObLqgGLOAZKVN6u66BY6HL9d+o?=
 =?us-ascii?Q?8Af21c6y+kQDIHo5aT4NFPcFPbeb+LRnAbWPeo27zCY/GY7S8WJ08thfjmZe?=
 =?us-ascii?Q?FhHyULb505eS3LXUukKO9tldUniSxQdCFa8dM1F2LCgE4NLrKOPuE/FEtK+H?=
 =?us-ascii?Q?1ltSecXkpClB0RlFX8lBPlO8sqjSeCNLCYsDPWfghvk2ZcY4vibuIzpgwIRn?=
 =?us-ascii?Q?rhyBkMblJdlXxr4OoAY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b72456-50c4-42ac-8d63-08dab9066fca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:04:12.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQarkibR1uqgZ0bSwXEfu6SjE1x3jIt6CO/EBXAMvv9p/FVofC0JkuJmepY4cR5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Bob Pearson (18):
>   RDMA/rxe: Remove redundant header files
>   RDMA/rxe: Remove init of task locks from rxe_qp.c
>   RDMA/rxe: Removed unused name from rxe_task struct
>   RDMA/rxe: Split rxe_run_task() into two subroutines
>   RDMA/rxe: Make rxe_do_task static

I took these patches into for-next, the rest will need reposting to
address the 0-day and decide if we should strip out the work queue
entirely

Jason
