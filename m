Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA135E967
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDMXD6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 19:03:58 -0400
Received: from mail-eopbgr690083.outbound.protection.outlook.com ([40.107.69.83]:28236
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhDMXD4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 19:03:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxJzJRUYrKZooRMjrl5LuNNi3JbccgmuUOWAN0CDYSNIDMUJ/4eCPTiFIDbqCHj8EYQvKe7w+LJvqfsAqp7NiFvVIxw5V16zpIz3e63m5WvurL7Uu5bmRCB+/NoiV5V+QPrAd6ABM0dSINztYpQBk+Z+mZxlfQgsI9Sw4im708h03tyXiuLqOpIv5Vn0p5YkB9T34DTf1PVbPlS1YHeQAnPmE8cvAqEj/6dWgNa/krOr676mDjQfUIgECACmfakdrfrTK2lEbekn0UwB28mHMMJKnG4RPfkurMQM/EQfmRdtSy204BTMRHEH/nbOVlUvNhyzuXZQ8zr6gNQvFx7bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVkEHQkrIfjUp275vVf70eox7NDSzkHEndGqrUP3hDw=;
 b=iCRpGLRL5iykut//qHadeRKop0w08tF/BHtKfz9y5egCICAE52ZqRsDRUbXqv832f9tDpzAH61C5vXPbXUivOnRPJzTYqpdRdxZFSBCRPhF4T9n0e0UEOkIZkeN1NVq6vcRfIxligA/Skdfg4K2uGNlDRPwzhQsw213J4P3zuZBaZxat7ljKTj3xEn8mIpkVy7xxfUN2+AWBlgLegOcm3exzpFBwkz8BkDVEO6n1LlG+9TkDGqFJHEO79XzfJRUZWmFKYhceT2ocp3nrG1U9mYNqa0b4wASekNLjVI5uVI9cr69QeZdRmZsIp39KOwZWMnoNUvhuWvinyU5RfGkKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVkEHQkrIfjUp275vVf70eox7NDSzkHEndGqrUP3hDw=;
 b=nHVICtLotGeXEybSQ/1+/RDk6fplCd+fiIKFRKkBlvfA53hO8VvTjt0Vx8I+ZV9sYmAZY/y0BRjB0GlfwPqZn2pAF3y1kzBadGzccrn4In6XqwtpBRZGhoPjTc67MkApaHCQs1TOu4IYLqQhyPxRzFq0bkWy9Q2EC32YzBmrlKbj5G6lRfv19hIumSs7o6js2lwfHXJ3C4GFE/3IG6K1zEZ0AZx9hFSTJa7iUKydT0fA2l7HmqfY213Lit6vtmxpceZ6fgKoY2MbHW0Tnrl7n3/WqIrNX1swJOZrNHI2LfpELA1ai2xCCxcX+Dzn8Cgq/FuW6vgZUFafjt++lrDlZA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 23:03:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 23:03:35 +0000
Date:   Tue, 13 Apr 2021 20:03:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/6] RDMA/hns: Support RoCE on virtual
 functions of HIP09
Message-ID: <20210413230333.GA1381237@nvidia.com>
References: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:207:3c::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 23:03:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWS4D-005nKi-59; Tue, 13 Apr 2021 20:03:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47510dc2-4186-4848-8ea7-08d8fed05db1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40111989189389DF3178F19BC24F9@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luqfJzKFzeg4pk+LwT0Be1HHzesJM7N9T6rYh3Esd0GhoLn/IWEOGfWcNBhFiYAsbjUrg3z3PB4XjD6kZ9drMxIHFnLJGBf/+KT1IePTp/US9vbd63frOBMkfBKBpQpYUUnIhFaz7H2QFYyBSdKihl2CL6R4pwgNNK4VVBb1kGeGcQJ2MBXAHZNYKsDyPB7TlIfUr2BvWIhIql1JQtBmaeETkyGaazsRcVWlyc35KqeJitYDwpBMh1rjHEbZfJzCnFtOrKyhaxCA5UQd8nBPoHehR7MUomGbeD+vvn4nJaln8LrgkgEc7zDQWvp9oW9UYOU/fCW1N3AAhKQqWW9/VGYNd5KUVAahhh/ZGLuZJhImTecb9SCSA+34TARhzhXiqvc7Ugb+MzHJWHaQV8ozaQcaUkyjTHLAX7QRAxTs3EvaeVT/hPLuA5skOcmmP7mh5qoDrFKkB+Y0xTw7UQGFi6xLFu4n67CIPkUPI2lkWnF9ubiGUjS1gJz+DIkTaEVg3dvSKRZdT8TISFEcS1jcfmJB0XjCdbV7QXME3mNZjUsf5bAjWCBbga0Egoyf7I+Hmg+ZgCgi4N79xaxtr8W5+9iH6l2dLIQsMJyd4uBVduMpo6IL3665NqVSYCm0TFg4xp11/hN4feFgfv+fBO5GiSETkP2gwfkv1KMi3qHsYB5Z8LM6+v1ZVDabVTeXyDbI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(38100700002)(33656002)(6916009)(66476007)(2616005)(9786002)(66556008)(26005)(36756003)(478600001)(4326008)(426003)(2906002)(8936002)(8676002)(186003)(966005)(4744005)(5660300002)(9746002)(316002)(66946007)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1txkrurVzgM728UhJgAjkJ4qbV7nc1E1pdiTU/v43gn2B/zWTA/dgv0Xhn4n?=
 =?us-ascii?Q?jXX/L4y/TAvWdLH1pbYH7EJvPyTIS9vHye/5WoSEPBgGIolkh45y42sstmFL?=
 =?us-ascii?Q?DWqJNQ5g5ccoOaQU/dCXCVtbXKW4kqtIHBU5ogE/LaFxMkvrC/CH/dJ2Acxi?=
 =?us-ascii?Q?kmqfwb0MT8pwQcyC4JEuz3Ba2nacM9Xcj8DW+kOH5L1hF4hmuJYWryradWT1?=
 =?us-ascii?Q?bkMagFsZ+sJQuDe2pwTqlbPclb9PuuHWGCdsF//GKIlfKlKuot29alkeT7yv?=
 =?us-ascii?Q?3MswZ4cL8E57Z8jUTg+MKiMKYjVpX4vBPlPkPJRiaofV1dqOe6uRqWrYg2Xo?=
 =?us-ascii?Q?2nrByVNim79Anv6lLXLrzJdMYxn9OhPH54O7f357HVSUMDl8jI1EO6T43kDq?=
 =?us-ascii?Q?3EB23R16SOxTPv79/AxenvlDZFIRJozRc2z5899L7e+lM2Mg2qnJ627s364m?=
 =?us-ascii?Q?SHg8xJsDIAE8PoU4zZspx3ZO+cRixAjbr5FG1t2ROskbFKP9aR8SSyWGuX+W?=
 =?us-ascii?Q?W2ZYjxgA02ZKRq13ezABLQ8iGque3/GsJyIdklIxFePItEvl+2s8CxcpyzqI?=
 =?us-ascii?Q?nrzmGvmMv9x/oEEcS6RrPsoo68JjdHS+EUg4ZYBQe85i7IcQ4Z3JfdyA+qPk?=
 =?us-ascii?Q?VtbviueieRDozscQkE9CkEHbw4rJqKM7pmAaTc6GctBhw8V5AlPyvJ3QMrkx?=
 =?us-ascii?Q?OiiZ1kCA+nzev/svSyXLTA+LmLH+1dsCV43x4XDLlyvBrWLZGsoxjySQFLa8?=
 =?us-ascii?Q?NwDOSf8uVB5T/e0uYw/6FprpUoZ1ZsR7EtstrJ/4QDERNcsheXsnfhJDp+g6?=
 =?us-ascii?Q?ZQG92IVcq/JUA0JXx/BCEKMima0jDswNe/dTGDYjrHyEKSpREpL0syRzM39u?=
 =?us-ascii?Q?R8ruhOK9R8G0dn1mglnIe+zbnJnpU6sWymER6garaqv9A9f5jLgVbca3pijD?=
 =?us-ascii?Q?SLOJsQSYEo4ih2n1gfJitpDGChGEWExJvjyC9gCBiIgBNLfkt6sMESUxgZA4?=
 =?us-ascii?Q?2PyxMv9lGi81cemnuBfU6TSUfVyYWQIySJmj6n9MniFiE59K4cQBjg1aD16M?=
 =?us-ascii?Q?S7ZTEDVCLmgUOXDba2w0qd3SYpVNYTmhZdSeWoySzMsNPN7SOJcq7CzIVUif?=
 =?us-ascii?Q?TA37XgoBCWeS9bD48xuJF6vVW9J4WXiI+UJ/oumxAQawS4tvanMc1oskIa6a?=
 =?us-ascii?Q?pnEf/otsQbVD1aWJiKCD30Jbl13j6x8ss4ughoJnrRZ7jlHSA9MJvM2uckeq?=
 =?us-ascii?Q?T2D9v4Z9xeTfFgB1sm2oP/9R7bmgUPxU+gZohX4Lh3KB0ju3C0uNh1Fgh0Tf?=
 =?us-ascii?Q?SJbMKd0J7jTHjES+QKy/t8iKwju2n6NiB5wCP6q6x0V8zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47510dc2-4186-4848-8ea7-08d8fed05db1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 23:03:35.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHVUhil09Qxbhv1pP4GG2kF8Pr3v0faw/o97JPvV+NPqIfNt3N7rbI5bJCMs3dhn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 09:25:08PM +0800, Weihang Li wrote:
> This series first do necessary refactor on function's resource code to
> reduce the complexity of subsequent patches. Then the RoCE support for VFs
> is introduced.
> 
> Changes since v1:
> - Simplify hr_reg_read() by FIELD_GET in #1.
> - Link: https://patchwork.kernel.org/project/linux-rdma/cover/1617353896-40727-1-git-send-email-liweihang@huawei.com/
> 
> Wei Xu (4):
>   RDMA/hns: Query the number of functions supported by the PF
>   RDMA/hns: Reserve the resource for the VFs
>   RDMA/hns: Set parameters of all the functions belong to a PF
>   RDMA/hns: Enable RoCE on virtual functions
> 
> Xi Wang (2):
>   RDMA/hns: Simplify function's resource related command
>   RDMA/hns: Remove duplicated hem page size config code

Applied to for-next, thanks

Jason
