Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D53B5E89
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhF1NBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 09:01:55 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:2784
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232598AbhF1NBz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 09:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxlnMTyuFUuP81FA760WTxbNXMjreDsTyeGMn31MADTFlZiE7mzXLbx02K1tvLfzxsandiTgUQRHk2YXermybXLW2o6vJxTgsHQaXseh2WdvBMgclXek3/iUBoO+mD28kJaGUk2J/APX17qwQDem0azvxjrCtM5I0SrdKdv/cH6G8FHppbV4l+j/Kaua5l+1MmDIXEUQmjFn3XayGc8hD08ldpVivOHyePuE3JJp+9ZmHjeE29XiAcBB7HwUz9B4cI2MIh/dNI5MthBQSixOQOdnhqngsk9Nd+VvgX06H5r4aVu9YlpBQZNlo0ktoytQq9f6dR66oHF+p/DyHGt0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXLI5lLkp9m5B9/VcV+3OxgiQNETcRbKT0m9p5BflR4=;
 b=BrzAUrVO9yXPQFrCxX/JLYkWH23W/cEeCTXAdJA+9xsBdmovRBWDRN56aAp9XhEir2g+s3HAz72Gc+VIG7+cwZeaak7aPXapzMpvPq6/Iy3rRKexhEixOQnWl6OulD+6U9qMlgZyAbsXWE6ALmEX5GPkj4q9DG/wtIbk4i1bV1Sgf7x3NZ352HJAnqAZGoqAwXwsVsmGCTpopIL/fOtImKBldONtojZ0lK+OEX6pNCZTqz2A2zxrAjxo1oG/0nrV3VxuV8nRGQD6iCkTxsdzfJk8ju0gZN7oq+Ot1bjImeJZIRWCQ39IG1aFGiJ7oDOGejtw1fsDliMH/lWdKuqQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXLI5lLkp9m5B9/VcV+3OxgiQNETcRbKT0m9p5BflR4=;
 b=I7epm2lf7SvPJ4lLZ9VvXvBAuI7I1HKznjJ4Wtte+AkPtQCp3BRmrvEVMD4mv3/lD84bAIhQjOZrLP/JiwLknBOkjeRqHcRJ4eTUoPk7G5sLyt32eHEEAsm1xpXXIgsuc42CjVL9v/l1DMkrip3gTlQsDYCEzfve+Py8wwixSCXmeIG2C5i4jKv9RGywFTewDKzcBdtDo/3kfQmH1Vvu8eBDixaC8pFEkpqVD1w58jdBjc/3AlWv/hw60skcVrMcS6bjx+0b1SgofTGMH6cbOBKLzT7sqiD/jE/hPv3IvX73k1aTd+cJfpSEy7E/W9rLiUO6Y2xS42z7a8jcL0SdTQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 12:59:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 12:59:28 +0000
Date:   Mon, 28 Jun 2021 08:38:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <20210628113813.GA21676@nvidia.com>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
 <20210624174841.GA2906108@nvidia.com>
 <YNgxxTQ4NW0yGHq1@unreal>
 <20210627231528.GA4459@nvidia.com>
 <YNlcpfdsdJdwMp5l@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlcpfdsdJdwMp5l@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:2d::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 12:59:28 +0000
Received: from jgg by jggl with local (Exim 4.93)       (envelope-from <jgg@nvidia.com>)        id 1lxpaf-0005eD-Km; Mon, 28 Jun 2021 08:38:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424822fa-0853-47d7-7b31-08d93a34902d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB514235DAF3904B2AA090CD33C2039@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZKydhX5O5yU8YTV8JxcK/jmA3UMQdUtqBvrbvebGG1eeyXMQezbhEb4fe6n84A4s7R8QdSJi3XhnRJHo0PnAmSBWYhR01XQ8hzcHnviJuok9BcmJPR627g9R6kOOJkLQBfNNp9E5knR+Y/L8oanCx25olb7+T9PJr6UBZkyBAdXtfrPISbt19ci6CbGcXJzZGy+adzjpbibBX9emBNnYCYLdvv9G0UQPmMInhlZSi+n7Hk5LUZft4dGjizWKHYr6PWd400uSrm+3BN9VOHjWxaPuFNFXP6+lVxfRfwLpceBALrnpzZiVJQZgUtIyxZbJQVP/HLWGRv0p37K7BWVOAByqbRx7VMoJJAp7Xu0A19W/vCUQbppOCAXBqN6fRpLx7PxnYc+SeTEHYxXVuYSpnpZ2NlbAmXzerzYMYQuvIJPLUwRL4UDtw0d7AF982M9hBM41CYSuNUdUbl/juPOC0sUd2PfQBmWnOXt1Il+hcx+WsieCRxNOL03ipXRxTL3zqpK44/mUSaXE6wz5sMKQI/RrGtQupBV0MWVghx7HGH13QTsxbLnYxZqJsU1pdREe/T/2boxLxUln6ZBxmw9kYehncxLr9sO+luppnnRYlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(33656002)(8676002)(316002)(54906003)(8936002)(426003)(4326008)(6916009)(186003)(26005)(2616005)(9746002)(9786002)(478600001)(107886003)(66556008)(5660300002)(66946007)(1076003)(36756003)(66476007)(38100700002)(2906002)(86362001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lC3titLz7FFNFKFB1c2WIdQyLFaU5jri/P6Gidxz7iOSp04hwExCdAPJyiPH?=
 =?us-ascii?Q?JVMUVsSzegsjecnTta3/KmfYM1qwaN0GFy0pCFsahK29US1aUgeTRwMSO+MD?=
 =?us-ascii?Q?2ctyWvL3EgNt4o4r4Q67bLVJLXzAtNzpuicKRWhUcGjxz80TgBWrq+Vjc/6n?=
 =?us-ascii?Q?wY/mRXYS0vV1i29PRTNxnoES4ScTV1OMvuw8f1S4KDHOx7yXLz+RDofdPxnF?=
 =?us-ascii?Q?YRxXeC0pSN2CwyrB2PDA6JE6LXw3xio9DxMIGmRYSwPa9kuR60FkeRDmdWun?=
 =?us-ascii?Q?CaeMiek6N2maFbEQyLfpeOVMTaP+JgoY9/aiYQTmi96xS+FkAsBbgMAAl3fT?=
 =?us-ascii?Q?fCusmcvWN2h3COovC3ZCbS+9E+A2QcN4Kawjuts/A3BskmG01c9zIMMcO6/B?=
 =?us-ascii?Q?7DiEqWXL2Gm4p6ZWL7RYGpM1z2qQf/XXUll97UAbiYBEh/jujBRdSsl/6ifW?=
 =?us-ascii?Q?JSA+4uJ8imwfLgVscFbSuL591e+2HjMcOVbpc13He4xkexC0ZR3Etx4AgKm9?=
 =?us-ascii?Q?yiHkT5tBFVGQYf0Rzuno52/ZAWDKzYXv+5Kdhg+zJHp1/pfCDW2/VYrdxyId?=
 =?us-ascii?Q?BQt/8vXzoI+ZNKuBoAapJs8aGfoO/Uwpro8MkE4VuSpEmHDKVpR1wJ2+DgjM?=
 =?us-ascii?Q?rMS5hyctfV1t9S8iR9cdWXgJpSwvx6EblIu7ftFFxf3PjrFYX/s7pOx8P7S1?=
 =?us-ascii?Q?40J+yxUD3d7jFPACK6aNTWIvhUlOfIzWE7EjFZ4aI3xwXpr+T/Ri7jn2svN8?=
 =?us-ascii?Q?un7omEprqB5ltZ40DKwyJAdzCneIciWQdhdFSg7ruY4Xk1R6OnM+IHEDyXaD?=
 =?us-ascii?Q?6DvizlpgfNrYtEz7W1Y1OKFeHVLOVjkteN4cRTANI6S3VB+yXiAgCSFf88zw?=
 =?us-ascii?Q?ON8AAn7TQzSaDw7XOyV6LBbUOIoz49WxI9VE46aSgMZKiWTvrxD/AuRL1lok?=
 =?us-ascii?Q?Xuqav8DKidEZ8MppDO6HOpaKiGsmUw0wi2DTjU5xYUxt+R8YJw6tEs6A8qWv?=
 =?us-ascii?Q?oJJMB4pAVyrVeMZQLnH4KOJYzzx/qUsn8PCe71HZM8C94eZAxFWGpqgkQsKk?=
 =?us-ascii?Q?FOMn+EIBDxf3Rtf21X7t/y1/RekUw+f5xRTBgLzSlSw+j+7ZdoEFfvpx7FkR?=
 =?us-ascii?Q?ahe+gQehj4KkdONApdhlfg8g19mlMNnnj0v5BdER5fCfwaiVIcwfq7BOrt4N?=
 =?us-ascii?Q?KR3RnTQRYtbOxLc9WaliTssbUOAgjUfxvTeNDzLftv6Vb5t8B1oXWF6O+gvH?=
 =?us-ascii?Q?D0IV+7gR2WYujlJcGXJ/IxnCuKmH4x6DiE++dxh15bu1V/ascgF1MwoPcgfQ?=
 =?us-ascii?Q?uoTqm4nf4drGYJiwUe21DgCs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424822fa-0853-47d7-7b31-08d93a34902d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 12:59:28.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t1kLeTS3PaUIlex/eDQeL0uuElYRbU57UqaXMduxB9wyHwjqUWkef9/B2IzQIgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 08:22:45AM +0300, Leon Romanovsky wrote:
> > The previous code didn't call restrack_del. restrack_del undoes the
> > restrack_set_name stuff, not just add - so it does not leave things
> > back the way it found them
> 
> The previous code didn't call to restrack_add and this is why it didn't
> call to restrack_del later. In old and new code, we are still calling to
> acquire and release dev (cma_acquire_dev_by_src_ip/cma_release_dev) and
> this is where the CM_ID is actually attached.

Which is my point, you can't call restrack_del anyplace except the
final destroy. It cannot be used for error unwinding in these kinds of
functions

Jason
