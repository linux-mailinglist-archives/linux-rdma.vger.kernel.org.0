Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E083F1A4E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhHSNZ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:25:29 -0400
Received: from mail-mw2nam08on2054.outbound.protection.outlook.com ([40.107.101.54]:60481
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231826AbhHSNZ3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp6JDaYUw5R4t/jTs4A4LNu2UgZAt0bxRWXKg8wRwJA/jO5EVNY1Ql/oyr3p5tz8jZGCZR5FunisyW3GIyHKe5hcMIY0XX0peKNeJ0HuZlaXDz+oNce8tEEKbDqfI/Mo1B1MOZvkzxANx8lD943sV+fAz7crRcPY0ub7kEuBtqkZRI3P9izW/SQJvjA7WxoACs6VwjPOqoSXPM68VXTY8dufDC7QjiZJqCXfgLiwuSXiPiPZNKSfWGMSTfBz55R21ELJ8QYaYYCWXnGNrZ9/1gz0pfu+116qLmx0DZ7OzfXITbfs+DHfCezdsclKebOyxgh3lU7EfoZagWaH6cjEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxgz8v9zsXm8VFb+qUx3ckZiUcdJcrpHFjYFBzDimO4=;
 b=YRcuQWXvHy+lFEHImR35errFz7IQP/hHnw53p52dloyfVrL/iP6DS2Q1dVpXKQ5u8tx1BWJlRqXnaZKhsH2kd8SUCZea7y8LWGK7rrnxh64Jm73lBieHd3+P26IJFw3raRZwsmb9wvhpHFGjCzM5wbLX1bj2y7VieD6dKWpGg4EyIrJS8sqv2Hb1m2xcpcHjmnt+LvhS2TOknWNJkRylAsdwObNHwkPstkOoHVOKvq7bntFJjo7jIBkmXhJpd9XtKNgJ2DQ7J0oPL7r///8W1b7h9ZkuFMf5ovYW7anKE3GHVCVKZHRUienL08qk+j0+a9vA/TfLXJdM+Q8EYKvriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxgz8v9zsXm8VFb+qUx3ckZiUcdJcrpHFjYFBzDimO4=;
 b=VlKFOuO7QVJz6CuOPFbZEmbLjHFMeHA+2KetBWWQwt6nRMew4cTVnp2GbKv0xhib/M47oQ+ci35LdyvTwLtEH0OM1kUI3D04HP23QFmPsfLmEJX3DTOVkQdhU0c9stuqqzthl2Uo4IE00osUXa53xAdFcmkbWisqLS5vPiAs3ImjD2ow7ALb05KqsM4QomxEfXGFqn9Akozjbo9lLHgwm6X1WHNa6U+iiq4eqS97AYdV00vO5SY8VAhV0IywfkeeRRpd+U4/BcFgfEKXFUh3lhlxiqfkV3Icx0VQsFSZ8TGmdHMk4E/9sA/Yb/KUq6cYLj0bdpXauiVp7RV5HFSDlg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Thu, 19 Aug
 2021 13:24:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:24:51 +0000
Date:   Thu, 19 Aug 2021 10:24:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH for-rc] RDMA/uverbs: Track dmabuf memory regions
Message-ID: <20210819132450.GB282811@nvidia.com>
References: <20210812135607.6228-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812135607.6228-1-galpress@amazon.com>
X-ClientProxiedBy: CH2PR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:610:56::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR14CA0050.namprd14.prod.outlook.com (2603:10b6:610:56::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:24:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGi2M-001BbE-9a; Thu, 19 Aug 2021 10:24:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615e859e-ef66-4403-8cc4-08d96314b998
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5207F2E171304D348EF0A5AAC2C09@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05Xbmhl9cDWXsAC5OuLIcHWc85ePq9EcLH101HQX9rGCkf6sWfIVPi6YSOaqkj6golh2JKv4pPLYt80RLvbmRm53/1LxfVk1ZAPut60KQIjMrRFhGC5mYk0XROPB2eT+Azljnb8M6uhplVdQjGyDnTLMBYvsm1HYKBOnzV4idtF43BySd3hzKaJ08xgucpd5PJrxgIFetmkLwbT4VrFm5+8rcsqKPW09h+ws5+GKPtYHXC5J5UX93OhZIti66tnNIOQSBRNdM/P87isTtYkYjTwb2rpWafZtGoyB7p4uQBgNnJ5JS5/AfVNf7yUg9LL+FmHmMy00+mH9aBYsO7HUy314MRWOhISe0TSClWwFBXrXOYO0N6EMwwEaaqTTv4B0HYodpUkuWT97mBo0rjrkuHR1lxStdEMs0bpTqn3WHRPGY7BJk7feFyMvd2MdsoMBERXWVV/XK1TxibpmCBWCiz9VJeNeFhHPWdng2VDO76tWUwFLGIL/utHjZEpnAaQlhccP7S/vrgPC9I7CtAcfNNYqkmQIQLNjtC1poR8a6d438w0zK7PwZZD3SzpabI2oASBNro3XVKWGW+0EBh+7Ni9JDEDxGQQtrG7+76/dDJE/nyvslP38hv6PaULnEaja9DgCFFc9u9Nwa/CmsymazKMdUa7GA2Spl4VKWR67LuNZRak/JGYUXIxc8Lb+aGQJWVxtmBS5HuRps6s2zui/wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(8676002)(186003)(33656002)(26005)(4744005)(5660300002)(426003)(86362001)(316002)(54906003)(107886003)(4326008)(8936002)(36756003)(9746002)(66946007)(478600001)(2906002)(66556008)(2616005)(1076003)(38100700002)(9786002)(66476007)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUecl5cXZS5Y5g3IKs7NcKE/2br15KRWbcUzHDnypk03F39m5T8RyDm7YT57?=
 =?us-ascii?Q?Lvuvhf+dtLPaSrMq1/W4hiNb+ywcyqoOdLxs8J1bv4YOPRXa2Dk66eyS32X9?=
 =?us-ascii?Q?XtkDu6WHnXzTUJ2jKRLYeUc+HfYdmcaqULr88jMkY+qYlRtCx+akiiflkxnI?=
 =?us-ascii?Q?yv+qSQtIBrq6Hv2IGjvonftVi9nx+mgGm8+tj1pVddDu5OnyxEXKnwiWnjFv?=
 =?us-ascii?Q?lhGIc+xviQyWFcdEQzQs0D9pT+3iIyuZltmsPO8HkgMdeT7VEATDlZtAKG2e?=
 =?us-ascii?Q?HTIbCQRoclseXP1M9n3h+5K/Vg1HuIyGLh8ItZWIkdBNIHmKafaavWcN6SN0?=
 =?us-ascii?Q?CQQ5abFMF4WM1ZqjgGBTMuHfDb/dtfY3K3e4xkBmQywuWh8HUbyWy3nQjsW9?=
 =?us-ascii?Q?f4OlvxVkvDgh2IwJbErxqCUQpKhwJb/CrzxmrlXJuNqdaomEL+o/QGc4AEWY?=
 =?us-ascii?Q?tnCKuW71H1OCGCkayz8Boe1BJgpeY+4T5PP5pLQsUPfVre56Bn5X3VIxg9WV?=
 =?us-ascii?Q?52gdsMHOK1TIxBIVQivWUz9ieVdlK0Q7yOlw0jMJ+JJN+tLkQYcGjbTdQBzl?=
 =?us-ascii?Q?xSrXNk+e3rCIjyn9hu/4g3EKZDQFbk7WmtdrD39uXbwu0q2gAeeH1549LmC0?=
 =?us-ascii?Q?tt4jJ7Fih/e3QVDmC99CbT+dUcS+NSVImJBr0B6l+W3CFCpA7jO5ZfGpX050?=
 =?us-ascii?Q?UBa2ckFiLxM61TkFWs6DU23QwVesOGNhZRHUuOjLvliyNvMpht+K6S2GmsAu?=
 =?us-ascii?Q?Q9j/Aa2ZgKXusVMUhQMdvm11qi8yoPDT9UoNGBqYM/OBQDcjIgf97gby83TJ?=
 =?us-ascii?Q?dsL038HdAwhU9kC4PPVXa71ULRUg/N8zF2/hrZL0+6oYUxYBzQ9TDhx5dKc/?=
 =?us-ascii?Q?ZayU20JlqDiEdQMYFc2lM3tIoPmRs5OaRBm2Ua4c19WvpYfPYrzexM5sKkMl?=
 =?us-ascii?Q?yNVJyAwyThZHDr7vmEoFeqrpGMSUU/XmbGYPYFhwC9SiKdoNrod7Voo2Sg0s?=
 =?us-ascii?Q?OCEIXiDcgUCZnSupAJOfBLjTp1m4vaCS1mXO9PFnHc6zKhEokkpI3GtMZ18/?=
 =?us-ascii?Q?x/o5RlwNofZbVD3NCcP5f3J9JfI55qQGhSkOqmajCWKzUkL1vLtTaj5NY5Ur?=
 =?us-ascii?Q?/qgHLx3qEIa1x3/RaS4ycZevxr+74H54ZALk/FkqhP51wLv4zzu+6JdKwvtT?=
 =?us-ascii?Q?C9lKL4//wY52zGpx3jUfmmBp0L2Br/GTn76mMCHFRP/tGQBkXCTM23HwHNpf?=
 =?us-ascii?Q?qx84YCRZNdAMEhPYvv+v9GtqQ0ubSFXg9zKXVjmFBFzH3+9iI3nrwNHfrb8C?=
 =?us-ascii?Q?5Hs2jbQakgt56bsSskhF/kUR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615e859e-ef66-4403-8cc4-08d96314b998
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:24:51.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9K+g/zgYVI+Qv6mqSsAn7O1yzdWpUQr1DlbJUJBGMOY2Z9dh35uvI/oiC8v5v9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 12, 2021 at 04:56:06PM +0300, Gal Pressman wrote:
> The dmabuf memory registrations are missing the restrack handling and
> hence do not appear in rdma tool.
> 
> Fixes: bfe0cc6eb249 ("RDMA/uverbs: Add uverbs command for dma-buf based MR registration")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_mr.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
