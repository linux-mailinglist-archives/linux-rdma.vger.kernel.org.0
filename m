Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C806EAE2D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjDUPjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjDUPju (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 11:39:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E562C19B2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Apr 2023 08:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyK9J2XFWARPB8l4DpKBbttfX6QVc9aK+r2AteQdAG/wuz3wdeMZq3Al8hSz+iM8YJoJRfPUxomV8rsIgA94WmlJG6l3/W6g6S2HOu8NN9YNrNgBAC21rcLjRdMTs1xoQcy18IQ4RiSmKjXi81atJspMIofp8XxQIp30n+auoZSmFYSQpKWQ0FTIoMwckbPj71ENF4mxfMntoIM/MtpRBCkc8yHBFli8xSHfsh1d35E1yqYN4RX0LurfSrg0TcpdEu5a0vc+X3hRrSMd0MRQW4cfvkWBUBkuN6gSVJ1vCbYREUZS+4+obt1QDYWxpBS//XoEuCvqLbwomw6LeMPFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izX69CpkPz7ICCx64p/E71JFyBh7i4u4VthHb4QNBfY=;
 b=l1SzPUtx9ra8cF36xfam7iKphz2rArwnoR/kh9LmaBvr1YvSFKm/6YSa0kk4qPzWSDyrI2+Z0CjGexk38uD1eUMbqCabqolJMNc+WZNz0fJi3yimJNkkxsKvSQD20Ak9j/TnF6V5OKWK5dj7jjT9ChVLiVyPeohfpS+7sggsxVwO5TWoqiSxIGTlzSrqfKY9QJmT3YjiKodmVYD6Bq6+h7mJ05UbhqS9mWUA/ibRkxiAUwUb+G+19ZA4zg8QPgnOE46SAIj0GehJ+EKEDFA72hnFYw3JvmHgpn82rklMFEexDGz5H24VrWciOM03smCei+U11wsoiMFqvNsUW080VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izX69CpkPz7ICCx64p/E71JFyBh7i4u4VthHb4QNBfY=;
 b=XOJh0H7gKy++VVXOYscf3oX+plqoryInDC1ySx5Eqmbgsp0q5six/GYRlLqHl2EVwr+DE1/ioBTLYPBBAPflZXWpfG/yoNvkcmRrFIvgghd1Ezb4YtCtgL4C9Nj/w+f9QivedyDOgs2WhM1rxysgzkJOTgGEykthHgN9A7FCOnjEeEHOonnRW27iZZLnoS2FBLxDG3YoiwXqLA+Z1gtYgBorQmEyFQi4U4jLx2T/XqNQ4BuTF6BFYxCgCdy9WjUwZspFal3H/JHmJfjM738IIOj0DptwSLm/RjvYPMZutCHtrO3vD98wqftuvaqcm/cybwyj8PYNrXItGAa8TCOKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 15:39:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 15:39:46 +0000
Date:   Fri, 21 Apr 2023 12:39:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, monis@nvidia.com,
        yishaih@nvidia.com, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Use correct device num_ports when
 modify DC
Message-ID: <ZEKuQLGpE9gws9N9@nvidia.com>
References: <20230420013906.1244185-1-markzhang@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420013906.1244185-1-markzhang@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 98873851-fe3c-44dd-8e90-08db427ea24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nimMoIuIcl78WKpftn7lejJwOFIvF+lSfJ4omge4HPIzrzqhLS3YWuqRmo8KiXXnjg+vF1u2bBoI6LdGFheKKwu5OT7UzCUD7qmTz5yp7AznzXF2d52zq4LiaJ7XydFvvSShWMkJwoJ6Eig6ysHyL4zbSJr+DmImo+mffnDOL+fVgYl9zslzWaxht+v+1tcbwMLn4PzpqZDx2ycnR4QgyrQLBFFQNDnVztqGL9w073Ntp2hFyiK5ZVFCZXZ9601g8hbTDRYG9qELhRkdYiBg0Kqg7ts7KSDeBKPHHAlawRRXsHcHUQPHPTLvObHDdFHMU6DnquEZNgxrlX3tQMA90pqkatmMqe5OTvPAYjNYTA2tFmoQMALMVc7sUTZTpkqkiJjsw4Ndi+o/T0lVZlIQEU6QhR5/gNXFLEeOSusTX1ge2rLsMKjG6zFZfSDIY4M3XRcrPlWgAUBI+2ZL3OTP2Q7t4V5Ke45rDHOqq+U5nvZEL8MPZSBFRpdkm+lCmzCJ0ZdRdk0ZbP3qFzDRaph6wzYUddKg7QHlafNn4TbcGpOt+7AbDs+6ioddP/2ZOLbn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(2616005)(2906002)(4744005)(38100700002)(86362001)(37006003)(478600001)(6636002)(316002)(41300700001)(66476007)(66946007)(66556008)(4326008)(107886003)(26005)(6512007)(6506007)(6486002)(186003)(36756003)(8676002)(8936002)(6862004)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUZMr/OnMIRgLH6EH2yDqK4CKjieJD1qZqx2V8IFOMJs925wzNMz7fhR6WSE?=
 =?us-ascii?Q?KGFZjiX+udHg1BPZmvndoFNNO/hR0i7yiaSUbCQIb2nk27DHmsYUazAaMItD?=
 =?us-ascii?Q?NnVNmsMrQ3vcRAQJ6T0eHRR5wXxJqh63pyWLI+dZcQVTn3tYzgoMUMPjDGTj?=
 =?us-ascii?Q?6D0yxKpnU/Kz1U+j+UMeWQjq1ydXYiuoUiIqT7v7zPvDb0lBalZYvhLWns0C?=
 =?us-ascii?Q?WprRZH9Fy0N/CiupBruPyzQMv5p0ADoFYEeqvKoEQDn0QXv3UJUOJq5yiRYi?=
 =?us-ascii?Q?Q8M3plIhUP7akiwmDq2c9P6XCs+j/qaeUI/Svt4F1ZcKfiI8hIn204OjKACx?=
 =?us-ascii?Q?HLZznxf+KHugk5nZqnxKTUs0CIwgfCUKpEUoyo+BtPmiCpwJzsv5Z9UzwgQe?=
 =?us-ascii?Q?jiwXWj/5t0JM3jWf+UV2iw6nrR0mZxPp3qh4OPXo1oIP0ZblTxJCRRmhzZSY?=
 =?us-ascii?Q?iKhyhD2bcTJetc7r1cAqaWFNSXPAHyWgf6DwSq8KhQSE1EosZJbWjT4wizQm?=
 =?us-ascii?Q?jd4Vn2MS6FJQ/BB9loW8pnifvSIVkNLSSHwpcc5vlC/gap/zT6VCim2D4Wjn?=
 =?us-ascii?Q?KG2bZ7X0gwqZQvszkUvC6FDpxF5TwIj9Cupz9KLOEt5lWql/BDeDH9kbEKRy?=
 =?us-ascii?Q?hW6N3ECjGNrowygg1f3QwZA9dhWs4g83MTpcUTLfqxW6sYOUbEZKpwXpdp3s?=
 =?us-ascii?Q?T2Yx44vrZ8T3WSKNjP1R2Lbf6sgt7Lq4Jj9gUbOdD0zdWFSyloqxRu40J7VN?=
 =?us-ascii?Q?v9Kukm4dL5RFeg7F2xH4enjhBU7+uLBKtllLTlu5JK2Nz34WcakgLcoixosC?=
 =?us-ascii?Q?z9FYixnE+fEKJT34toTrRRN6mwlJ0d3hvhR8rrBilM4PbUwG1gbQ1KGjpijq?=
 =?us-ascii?Q?t69UQqBQRnrj+zyZDjpd3xcVAxjoqKzzrAw5iu3qb6SkIU5VtGte/DYITXmH?=
 =?us-ascii?Q?Y9eDW9W/CRM19SrXKIHjQW9Gvzwb8OZeInmamNYU3vGZqYDFhY/kIAtMc/B7?=
 =?us-ascii?Q?WHQy1JTLK+35gGEozf8BQ02Agy7GowEJN00oWaqmEGTILtD/WtHEPaLuWZt1?=
 =?us-ascii?Q?jvVKoswMS+py9C2nqEpBDAyPyXKFQC4ULTWIa5Z4c8a4Uw5xn1ZiTgUfWK73?=
 =?us-ascii?Q?q+YB48UiUS5Qg78VHS+/eQ3GIE+kTrJhhg3CVllEn+EZkmnD+tWfliraRqrs?=
 =?us-ascii?Q?c/4NdoFN7d3+luGn3VKJGrlJDE+PZo7gtRPRW6jBjRwi6n+TfzOh37IWA0Fw?=
 =?us-ascii?Q?evpEXzDkfDck/wVqf5jnSOfabmXq+hfkSEBDxfzEDi4Afeb0VD/veZ63fNzA?=
 =?us-ascii?Q?/RUGdQ+qHgQnKJkUW2He4HZFZ8J5nYIFKGt/psw1Box3268bq2FDD3iO9fPz?=
 =?us-ascii?Q?lUlwtNiCUVeA3Lggw+t+RwQvJbuZR5fwDvXEkVOjyPwQiRb/7T/CxKYuuV3s?=
 =?us-ascii?Q?Qnj4rvD8AYCVNsXRNpIpskwOAXx/DBILxyywPq9VGA51VpyKvjxmYK5tvMcq?=
 =?us-ascii?Q?AQIR+Jkjg1/Mv0o2k5MBf8Akp7CvKtRwjNY/VVqww6ZbO2ouLAnTJ12six1W?=
 =?us-ascii?Q?DO+ssIqyI7rmLGMzxQDnbGcFgOuNNe25SvtjLR1a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98873851-fe3c-44dd-8e90-08db427ea24f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:39:46.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGwX9PhS63hiGXYuOmavYmjmcr0/tqJbHpEKr4a0l5fC8gmVyFapskCDgfPJ5MfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

On Thu, Apr 20, 2023 at 04:39:06AM +0300, Mark Zhang wrote:
> Just like other QP types, when modify DC, the port_num should be
> compared with dev->num_ports, instead of HCA_CAP.num_ports.
> Otherwise Multi-port vHCA on DC may not work.
> 
> Fixes: 776a3906b692 ("IB/mlx5: Add support for DC target QP")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
