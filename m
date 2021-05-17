Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33956383B4E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhEQRcU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:32:20 -0400
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:20321
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236191AbhEQRcU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGYjhaDjnpMVp9CviZ/zOrGLW48PCh4+R1WwaOBN8rw/3WZjmfMDB1D7z/xB/5HFVxzlY5B5ZMR/roI+qQ4W3ZblsTiLJz4FP/1uBZiWNCZCSHTngiMvKY6EbCAE7fcCUJANHLZeOOipdHZ1la2ONJHK5emJeMlY8FUEPYp0u7OcjyhTceDPAf0YCdpwSqRk7D7EBWUePIAVesfrATh3VVJhRTpcazOL703UNQPlPFlGP43h/MqE8xTyuGqHPo0Dv+NhwUdps9yCXa16N04J4x5pzKBW5ikWIpnzRmL/mfEJJ8zX9RAbPYXrxhvb79meTEVd1vdQkzyEzbf+9HW4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1yUBDjQRJciiZS0ocX1DSa1ugutoQRL4noWT4QQx0I=;
 b=bevJ0Tmqwd7apBvKN2DyLKGAkxo1lpYO2EMAMeJAvElOrxgRxXrxsLif17gTYbb8Opcx1OhPq607GIPPelPzTzjmA6CLgRcmuaffcAIkXOCqL1I0YwIhUEoYwZdP5B6VIlsnzU69AAN1figX8pnaSs9hp2tHyJPeT7fZ7rKA8hVTXGsp+enRRmZheH8+e2/QAdKkpztYqC8vSekCLLQyzkvbfvd4LUYwKroxseIBVh3fVzzehep7ARo/6EXJ+diU1E3J8uiQSuiXJenVBX2EMb3+KmpiqCN0u7XnUbv1+qybKVJ2r2v9z/fbfwNtN9OWg0f2T0ZfClrLcUFE+2MaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1yUBDjQRJciiZS0ocX1DSa1ugutoQRL4noWT4QQx0I=;
 b=QKCcoIh5K0uRKykJ5ta7grkCKzeBkAI+xEU+uOIjL2uEBb79szKN0VVnkULfb6ATf5q1No8jA0E1m+0PnHrm+p786R3QCY8/NdcgdB+Je1RAjZazP2np5y6J5yGzHI6vMLqicLMHqyK1Db8G4bl1L+eXotq5Cw0HiCAaHKn6JFU+vBjRkysEURldrUVBMpNY4vtjWl7GE37M978FpfkdcfRBjgPZ3Rgd1UPwoaj91gNFnsb1nXGWSOj1/ZBLZ3xlvLCfKnGlL3OoMkTLuOxPC3a2Ojgdx+uGJeq25hg6bjNNUuJHOK/R/wo8hE+1SIWeKNdQyGLHCrBI6e/zvPjmGg==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 17:31:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 17:31:02 +0000
Date:   Mon, 17 May 2021 14:31:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 09/13] RDMA/core: Expose the ib port sysfs attribute
 machinery
Message-ID: <20210517173100.GT1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <9-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <YKKkFyHwki9R1Wkc@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKKkFyHwki9R1Wkc@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:208:fc::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:208:fc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 17:31:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lih52-009PQI-S2; Mon, 17 May 2021 14:31:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb74b4f-8534-4c46-d8e7-08d919598abb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3018A75331F415E6D9EF83E8C22D9@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyZYlmK7b6r8QT6MYSdlVrMlxWsndgWcg6M6YML5yppQI5+5yM2ff0qKop0gTvX+JrDT7h1w3CHCGOWmrGLLHEs+7HaUVySHKYavZ7A7Tmz3u1HpefIiwXjWfiximKN4+2vfbVwxnMUe1IHidnToKcD+xOcDjL6MDOj+mNYOa7IzP7Md4R/9Gy4W/HB0TxuYaLISCLovEuERtqjxM5EKMDtaW+R45TTmBeq14kuT6ONEt2k2qNIHj2ptaK+DYQXAs7XtVBXUDoOJf8KgqcWLmGg4QBuZWVzLf/AcKQEb8qP8T05Cfrbw85ZTdgoqvEsoqXEsC5pqOHHIrHD8j7QOp7OKVzFelKdvzAzaoLH7wQKOUXUYlnRXfzoCKhhP3yi/QOkUeT5kQ3ZIBzyoOcx2g5lcwoncNw9nj7n7qv5sPheCJtKkQn84OaMGT4CUA4tNJ2cstw0BUnaPDCgz6mDW7xWJiESjzbvR2Aai3geFrM14OHCAGVJZGYlMzpIxu88R0bDdrV3f3KZcTZ2Jp9DDFJ+aFSORvCWekCerD8afQ2FVAKfg42PaEi2n+BY+dcuz10RlEl3cZctlKO69Ts32SFpYE5/TDrzcV92V/TehyQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(5660300002)(316002)(186003)(2616005)(38100700002)(4326008)(54906003)(426003)(86362001)(4744005)(9786002)(6916009)(33656002)(9746002)(83380400001)(66556008)(8936002)(8676002)(26005)(36756003)(1076003)(2906002)(66476007)(66946007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZyrL7aygGQMzwEK3ZVtZOXZYHc50yo97mck/gEkYGcGVrzEXgBkiaT7xTbYn?=
 =?us-ascii?Q?U6xauDXOFgR2VcbK0Z/c0oF/3KLMwlcI5GycgBbdH1R+JRVdQW+YXkGhI1W3?=
 =?us-ascii?Q?BFwleKGp3890bxOO+F+FVcUCOG7MpXzviMbW+fcNwudjDPMwzcIbES8q4+5X?=
 =?us-ascii?Q?4/szIAvrgMpaoKiNW4gTdnCH0O3KvvHKv6xt0nJuc2jBzjofwMJkVhDjbR7k?=
 =?us-ascii?Q?eqP4/PWw+f5ujwvq7kxNUEo8gbTv/LMCLGqtzT4nJk7auAPmux/H7IpBce67?=
 =?us-ascii?Q?p3NrENkyZwyRNmsHIGJcNGwUytCyTbapqKUPsdqefKhpOGn4j6fVZ3WOWabl?=
 =?us-ascii?Q?T7T7YA7VoisurR+COMlyWPsJuRggiYpmTOSCFvrIU+K/7WzNJb0y39N54Vad?=
 =?us-ascii?Q?uxOxO/0Y6fxVf4Ho4gbxzwInwk6n24QEk8H22aoNPQrF+ReVfxYitKM2l1y7?=
 =?us-ascii?Q?V0GlNUwxgUhC2mlTaPjkZLVe78p/03j5i3xGzrjr23EycjkJOBzn2JrkqAPx?=
 =?us-ascii?Q?j4qVQ7y8iLzOTS4Egxohu9UxgU+MThX+kzCuzdpY3hyTpSORnbvAHt3Q8iXX?=
 =?us-ascii?Q?WNhOSYvRqHHpm2+Ejar2FvyE4jr0rWMkwD9/98Txjmy6kO9LfZTDOWz4Fst0?=
 =?us-ascii?Q?lAbZyRYgiJTj1Wiio8/9PiU2emVe6RXuPeCxNYT3rVZ1+8pghi5StEO28e8k?=
 =?us-ascii?Q?KVh5YtWk7+cVTmWJoA9Cu/VKklhTxz8jBrgq/A8r+ESetzmS2NG3aBNFmOMg?=
 =?us-ascii?Q?hA9v24ODa9j1WAblBr3uKBEwvhSDqXxZuwERewDjhk8WsW22pzepHau/5L1T?=
 =?us-ascii?Q?gtRhkw1P3zyruAbGNvDOWyXiJY3vwmrexH7f8y4kvS2IsOd8oaV6ZIakUjgm?=
 =?us-ascii?Q?je560wjkB2h6JQnFKxnGQM7eAY8ctWjRnHpCfmjyYf+mDUnEo8g5jFOcnthl?=
 =?us-ascii?Q?LWLUaGSkOEv7BJO9qyuzVXwidayxl0gVHreuAgWIbpbNrx3INWmqxvG56aEB?=
 =?us-ascii?Q?K5wcozUY74RKRfPczo4iO4by7ed5G1PYL8nubI31LjdEAsFqpmijZNScMb9G?=
 =?us-ascii?Q?rw1J6wcbgT/mMn2dNKx0/8vIdYT3k925qnDtj39Z4i5AxIGCMiv7XqNlTdIs?=
 =?us-ascii?Q?dJocZr4nkbm2HA8XsISZMVS7wf+9XrFBIUxJXIsmN5VT4RDV3WSNyCZ2wmcd?=
 =?us-ascii?Q?dckwmb5MHlT0SvNdhcfotHcKNqg0foberWvvrhrumd/L0AWLrsCSMUuO91w5?=
 =?us-ascii?Q?JTGpQzguWUGELgOPjO4umAKUkDPgsstJKjG0uQblSwqpOIxXd5NlG19JJcDR?=
 =?us-ascii?Q?yvdYhj2w8uGvt904iJ1PWJ3t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb74b4f-8534-4c46-d8e7-08d919598abb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 17:31:02.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJtoD2pG4QKHT1yFFqTmaj0VXXsI9p0b7XK/XsuQr5Ap0YIGEENjRHaZ2wETqMSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 07:12:55PM +0200, Greg KH wrote:

> > +int ib_port_sysfs_create_groups(struct ib_device *ibdev, u32 port_num,
> > +				const struct attribute_group **groups)
> > +{
> > +	return sysfs_create_groups(&ibdev->port_data[port_num].sysfs->kobj,
> > +				   groups);
> > +}
> > +EXPORT_SYMBOL(ib_port_sysfs_create_groups);
> 
> You are wrapping _GPL symbols here with a "convenience" function, please
> make these all EXPORT_SYMBOL_GPL() so I don't get nervous.

These functions get deleted in a following patch once everything can
be switched to ops->get_port_groups(), which provides even less
flexability for the driver to do things wrong.

The whole subsystem already uses !GPL export so it is very strange to
see a GPL symbol at all:

$ git grep EXPORT_SYMBOL\( drivers/infiniband/core/ | wc -l
310
$ git grep EXPORT_SYMBOL_GPL\( drivers/infiniband/core/ | wc -l
1

Anyhow, if it makes you happy I'll change it.

Jason
