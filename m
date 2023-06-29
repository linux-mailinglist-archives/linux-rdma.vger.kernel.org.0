Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79182742557
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjF2MGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 08:06:16 -0400
Received: from mail-dm6nam12on2133.outbound.protection.outlook.com ([40.107.243.133]:26977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231821AbjF2MFx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jun 2023 08:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N685RIRHpJ7/FlQgozuV/hx/UX+MI9+OLNK4yUa4jFSKhlewgp+MrJ7dQOYt8s+wm1sQ3EyYWZBzC750ZqAxZVCpSySB5GXetw2G5sNgXUNNkb6O8PI0Nrey7L0rKyUKPUCE9zW5qYwXC/aNKcyDI0mcAUWso3j+zJwKXwyuQG3LB+AO43q48DNOXHyl5DYCmkzHdWjv6rCcouk+YJMgbNHh9BYHnOME7ykDMXdEXyxb4ADPQUmN5zoRMwXKQBpr8XzDrmBp3fm/b91e4rroU3uwLOjVABRbRWSmJOdVy4dhdai1K5CLXWAorrzESMdu33I0UM26veBTocusHVjP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnF9vhyeJTwU6Fu0ZZda4zjV2De7B5aWUALkoj+TO7o=;
 b=CB3oa78Mo2XQV76yfz+VpkRkrjejjxnGqv1m87M+CUgS05BbAXNp/k0JNcoLrRSYphBnjPrm9ZVrJSLeWde9Bqd5y9HOdXausptm1LSq+4o3sZzJCwu1N85QsSYQZWHVkN87eenSPuypfldvJTn3IAGDms7MSb0AzE8I5ewR7eBzx12fuwQ3z4bJBZg0SQ2H80VwQki+Lj7cXl+uTEwUwohlH/7CVz1lWNAd5IV/iHppuyYaVN1YgMAFT6oGTYL29q138ZKdEmwInqXT+lg6dNrl/QfnkJ3y+A4y7B2rG/pKmT4aOlbKXzPou4+/4bJXD+q/b/CaONLRgEWV5ctMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnF9vhyeJTwU6Fu0ZZda4zjV2De7B5aWUALkoj+TO7o=;
 b=Ji4MWqeeZQFiO7TZqGKrF00dndHaUHEaZ2nHkvVcGwHUYKCoRo9WAFRq6pJF9jUhgrcfbct33/TkYKZd+hSRRZECyPbbXSz3Fx4YPevqV3aMnlBDMqXbMbc+5p1ehvpFFX3t6gj2nT1OMiwgQE7dQhhqPdQ8b8xN8tjuQjGDFrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5990.namprd13.prod.outlook.com (2603:10b6:303:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 12:05:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 12:05:49 +0000
Date:   Thu, 29 Jun 2023 14:05:41 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, saeedm@nvidia.com,
        leon@kernel.org, lkayal@nvidia.com, tariqt@nvidia.com,
        gal@nvidia.com, rrameshbabu@nvidia.com, vadfed@meta.com,
        ayal@nvidia.com, eranbe@nvidia.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net 1/2] net/mlx5e: fix memory leak in
 mlx5e_fs_tt_redirect_any_create
Message-ID: <ZJ1zlcJ/opBKA+5R@corigine.com>
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
 <20230629024642.2228767-2-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629024642.2228767-2-shaozhengchao@huawei.com>
X-ClientProxiedBy: AM0PR06CA0086.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecb00ac-1c08-4f6a-77bc-08db78992d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtbMK3vKjvczfRIat62TEqKHA1H0xVK7qdvw0/9072Vgwfa+o9IgCyw8buLtUxbF8Ee7nxP/gkig0dnO1Dp92HKiQs/YzC7P49VzPIwVa+2aUCdtDX39h+tqOl6VeOrHBlfVJ2AlmQ1IqKj44MKgZs71G7j4l56CbZiMQUrpP2jSnKBxBXosIejpPuJNx6CzYoBPEPdvTdv+4g1j/w3O8NbcTDutTQb8pwCVqff4jJP9T4OtR6W1jL733/Qo5jJfxCad4ARWDZIXvP/59D3c7rOUie0P23uscUYqQrxnPevE/VjjOZIM1gT7wBXEd2BWfkHstjeKfV1gdXo8vp0tpV/SDf015s7uuCbahungTSkomFBdgnlh6EKjdJk7giHLqnfCIHPaYVcZn3fcy0r6YGAdrsM+7keEOkSghBPnMSCWRbkLCqwrY8zaXORiQnurLSxUYpLVS7AWxgMoPpS58FZZ0aI3SpWnz5bKoUnLdWGKSShlOcq3/pIlTOgLu+7yOkzeWaP2HUS8aoEqVNhcDeeAZN5SV82YjZSqw5FwOS5usY7PVe1F1OkuGy0WInSlibScP6cN/AGsIu2tNCF2HqNN9zEH8Q4hrsor+x++fjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39840400004)(396003)(346002)(451199021)(6506007)(36756003)(66556008)(6486002)(6666004)(2616005)(4744005)(6512007)(186003)(2906002)(478600001)(44832011)(86362001)(316002)(7416002)(5660300002)(66476007)(66946007)(8676002)(4326008)(6916009)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQ2DK+RqMZoWQkDSg8Y86z5aQobaCIm3f1omqhacwpn7cNn9XPt66ARB+uZu?=
 =?us-ascii?Q?gz6qKyJ4p3PJc7Zb4lnk08iZo0DrYOStqEY5NiaHwzlCLTt6Yl3FEErh8qBn?=
 =?us-ascii?Q?tx5rKuJNGw0vr40fuI1az42gKG1Q8HujXloN4Hf6aVEvS6cq3ogtvzKreKzE?=
 =?us-ascii?Q?/8HTyI0dZaYE+z7OH+0BsyYJkoLZRpE8dMBQO+r8ybDQl5As/t15U6ZREMSf?=
 =?us-ascii?Q?rumFsZ01kEI0nCT8NUzIMCHyRZfPGUCJ2PaJoArNZetk2E4+mb7U7f1+OcSQ?=
 =?us-ascii?Q?mT7l3c7fXavw/EhId5f02dfqRwD3Ah9TGvzyHjWe7GRc9dsKkF/+lxNnuCeT?=
 =?us-ascii?Q?8wp3P6Iy8AUcxMWLhQGGqLSZ5mVKLOzTyfa5l7CAcqWeF/bEDm3VXkN2Z2nH?=
 =?us-ascii?Q?txn5jZrhH51N6sNP8p4xKTo9TNNsIE1FqrNmZ+sAEw4Rm7THjpMArvcZpN6P?=
 =?us-ascii?Q?S/Us0n1tVp9BdNn+T8Q4rVsmKhQ5xLy8Iy5dQFtd5lAyQWz83j552TSmqsEa?=
 =?us-ascii?Q?0YV51jDuxPHr7243+59CnfMYUCxIm4hCvGZ7Rg7FkL8//+VHY1C/mWcRmmDX?=
 =?us-ascii?Q?hZZAP+45O8SZ1+u0xIdnFqkTfarFjmyjxbRIWZ/XczR45zzmErAGP9QaBcWk?=
 =?us-ascii?Q?LdL/eq2dobr49Ycn6Asy+Lbn0/G62uysH9FfLh/Odhj2WKQYwvOlY05yxpJt?=
 =?us-ascii?Q?jhIpcJkNJnlp4t1IqZ/hu/47Ijd9BhRSlu5GtGpAlvUFn7npYnWViDxnutRb?=
 =?us-ascii?Q?D7rxDD8weVsfZAggRWP1JKP4855G0B1l2qC2OaAmdu9LFm8EumUdYICR6HVo?=
 =?us-ascii?Q?O7qn5xA8oVw2c1D/fczH1Mv2Acd4fqZXqKVUxG5uX3kTLzs+tmR/S0xfgNN5?=
 =?us-ascii?Q?rCHA2YILikqfohieg00X2pUnn/81QC9/DhcjDTF07CtrdfKJC3nxxqO1nUZ2?=
 =?us-ascii?Q?KSRj+KOZe7rNc9x+iId40mD2AnSKrrdlTOvJL0Fyqx/qBAy6Y5AwRPWcBQ7J?=
 =?us-ascii?Q?3cGMR/3alMLmLOlpSqgwcoVKbH0tHWXRC+vIGE591WM8MZL1v38ShPiNVlFB?=
 =?us-ascii?Q?bGKacv7tlktmUTp1XFgfjZTma+9DhCbHBbOStlRFAg9a3IwYZE9wLI3wMzwL?=
 =?us-ascii?Q?+OR6MeswONQpQRG/sTTgZPomWbypMm5A+2yad24BaVWFk/Qq9OmStL5ohdgP?=
 =?us-ascii?Q?/br8dYB0IFtJU6WXITdmkXJHRy1bzhq8CXQkxZ5LxNGla6QzFXIkcxXySmJ2?=
 =?us-ascii?Q?lmaCzDCqqWbOrGnaJi4lGK8umynQ8zumgHE3mkQNTQEpoZNTxEilIEOdm8Ut?=
 =?us-ascii?Q?169WPhWAbaR+Ef/s5tZPxhmqK53/Nl8YDdiYioOk9cvAmbIGc4a2wAwJO0ln?=
 =?us-ascii?Q?rDl9SyPfNkL08z5h48lVqrL8tPSDmmdEBRiLERdpBS9pJIO9ebyEBJ44p1/P?=
 =?us-ascii?Q?CSbnMh1kte9iLfsdYTecMBep7HwULSGNoWw2ZVsDVpJLjJs28TAea0At3WCc?=
 =?us-ascii?Q?bLYErow16zBT3nkrJfu9F0BX1AyNWPN7ztBHLC8BqxqBWHCOWYq4QT9Poc8Z?=
 =?us-ascii?Q?o1iKdlfO+244W2Gu0wkxVTz7Hm44FhP4wSmMHWgx+UE5APh3FptG5VuJFDXX?=
 =?us-ascii?Q?fiw9YwdDA6CGRHQeA3fTZOZ+fSGgOycVtrBSPTlb9u5WwtGxLYWNrlp5YZnA?=
 =?us-ascii?Q?Upt+5w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecb00ac-1c08-4f6a-77bc-08db78992d75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 12:05:49.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0i4cwSv00kLYzBo0xfoLECjIj6gwHQv9lusEoQY2Zqce46s5KclUJi+zKJAm8Iv/cSZjvbreo7e3ijjhlyZsRkkdubCjkZjwYqKEOp1fj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5990
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 29, 2023 at 10:46:41AM +0800, Zhengchao Shao wrote:
> The memory pointed to by the fs->any pointer is not freed in the error
> path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
> Fix by freeing the memory in the error path, thereby making the error path
> identical to mlx5e_fs_tt_redirect_any_destroy().
> 
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
