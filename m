Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9074F82C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGKSxW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGKSxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 14:53:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F11BB
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 11:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBpfMzvPU606fpqnoJ7mBPb5ytD5a4oHQGbL+SFIqI3kDyne5k03EEKGLVBi2ulmJ2GwvV46O5a9PleJQuZSohzSy7eF/bZRqrhIGD5fTKeSuBfGacpAitjix6jWUhbkkexXPxZ3Yd61Rnbsj7OO2cIQ7E0VOpe+86ckCsRLA0RWm8Eu46CRwRjXBKwwR5qiR84RpZtDd/B2aL4XMP+KdTuenGvEQetf10B1k8WvnMIh6BVni7AwDNbgu4x9DC2Kldm7Ncxl4GOQk8zIeoigzJCZoQqj2dcl4Efxs89GEuQ5owmdtQQfkhc+oQDpu/9jn4RAy8k/CINFcc6hmsR5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5eGjMiGe6x08TA7e7Xh5ISoOWa040o1b3amLXZafZQ=;
 b=IXSS9451syqtmQX4d6G4xKDuMvaBtrXD7hJkZMcjMaFzAoNFGoe5ijq8SSfjHJnxVhOSL0lxou3I0muqPHGts55F06tRLhB1ToGogNaoWJGglpwH2uvSshVRWMaiqhPUAgoqlr+h4DXmKUXH5llx5+oHeVqT6i0CHx4myG4Z3hWjpwdTCog7MSql7DCxqAiP9oMdYNpXkK8K8bP/D392Qgl6hKyn8Z47BaTOF3DcE/43hGLZLqFJ2AYf+7mpiGn84GRpXyt+8gAg8NmZcpr8a7aK6ESs1GnfV3341fPCFETvysJBc0dgCyBlvufU3n5LNcMX7b4QrQzrT8ood/hFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5eGjMiGe6x08TA7e7Xh5ISoOWa040o1b3amLXZafZQ=;
 b=VM0h+P4X+isO3xzEJ6Pl4+KrfqMaEQkgaYqLT8pL4l5BXg2SMk+qlciZQV+EqVel2BD7pnLj8sjxysbgXxQ2L9caA0vMZPVR4N7GJg4GcRrvA9hRE7O/6Km9U7G9TxwcMHNMvd741oZc87NaAPRyi65SW6HHDLJp+jLJ89aZi9PzR3Jj7vEwrotmi932PnfUajb0V7Sp3I7YtGM6yiL99X7TcbCkQjkDVccrgWUGBQFAFd+YWYWArodqzx+4sjJXBf6fcJ8GxnY4QitnmT3yHXArB35wUbUlqFiO55ZOqWmP4ojawSHuT/P0vNldUHebW4OpfE1lWLkqV1m9geYklg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 18:53:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:53:18 +0000
Date:   Tue, 11 Jul 2023 15:53:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     phaddad@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] Revert "RDMA/core: Refactor rdma_bind_addr"
Message-ID: <ZK2lG5p8OkGQVU9G@nvidia.com>
References: <20230711175358.1313-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711175358.1313-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: YT4PR01CA0395.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d13b7e-b0c2-47af-fb8c-08db8240171b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Mh5fG/mZIc3Udqkv1rSyKPiF1LrULC4jbaKb3c7wupxDG4k76Jfm9XIEv7uhHqJDDVTPCzdslapfSwz5+kJyZG/OMP5Uxdjf04Sk+PBQQweDetJOZiFpox/eWLS8bPW+B497+WIvxZWqKQchGCQR5bqEDQgmxvIKCkYnNlLS2zOLJkhKKkk4dJtC/VV7yLsyR2HiWVPy//QI8UGWJmq93AmlncF+1W/Q8YrAEsDpSEXA96yznVw7qxq8RHzrdNYrRZeN2TAIOhULDTsbkyMcgRSdHBkTIkNjl3ZDKQDf8xZYhYD1ziHiFNlE9vdZBMGQJ5Uu3viPwGRFzP9M6gHeOC5eshGEudO2oxQeU0ossoYFJz/QAgk+uI1Ee3pFZMeTFu50Vq/NpVb20i4PlLvfy+qLSudhPPULyWSQT11wnFnsL4koXLu96vnkRh2J06x4L/117P/jwSCiHs71koilM+Lf0X2K+LWXXi6mkv6PPojGg8i60OC1tVPF1sPKVTNzRxUZzJ+w18oxmXdftHS/Zt6WVMSTmYZM+yUA0iDQw0N9TGWF49Zp7AQnKapjYJs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(186003)(2616005)(38100700002)(5660300002)(8936002)(6666004)(6486002)(86362001)(8676002)(478600001)(316002)(41300700001)(66476007)(6916009)(2906002)(4326008)(66556008)(66946007)(6506007)(26005)(6512007)(558084003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9ZOMOy/zjRoN71Pu5PfMxptKjeB6JEMWzxbkTaOtjIptJGcMs+OJhZYW89h?=
 =?us-ascii?Q?nAtVoMKgpC0vCShzwLvVLg+/Tuj8iH1/QpgRnr2YqwXAyFkyTJxvwq0kYydj?=
 =?us-ascii?Q?2JiIv3yY/wV/8KcKKQPpkH20/cgSRF1c4s+U2y1G+TyBNuoWszirMYHxbCGb?=
 =?us-ascii?Q?wtdo0P0zYWmOqxUzC0/UnOPOjoC/tLWUAB4h2o03UnNyvrtse7A6KrAGqm6J?=
 =?us-ascii?Q?BETJXlAaE3uScvwmn2SphiaJQyu78ds9qZqZwzttNf+EMe2gTDu/ec4VgfSA?=
 =?us-ascii?Q?GILDnLZ5n+uDRHSbekv+QdCHGSZepDfeouGzlcxt2+bngXO7UA0NrXxC7sSk?=
 =?us-ascii?Q?LTfexnkYsUL7kjbvvalRWbFMGPXS1bCbpPWKyg177feffSCjxUwgqjZdHRio?=
 =?us-ascii?Q?X30QrwyraCNNoM1wZn7jh1XrArgz93VblRO6obx2KVCQJVdpXymEuuMSoYv5?=
 =?us-ascii?Q?GOnvRqNVyejWbDZZxxChHy+jqpc+HFDzDlXQKm/20gV9W3sDxXYTFXQxmQul?=
 =?us-ascii?Q?KKRspoYYfj1gPeP/5rpx8GMYk0CMd5aQx0Qju3nXAEAbfNxxBeEiCnEU12bF?=
 =?us-ascii?Q?Gp/VtGnyZmjxi3U7sogRt7S8UE2B/+l2QLavwNLGUfqG7B0ZagO3JKNNlsWR?=
 =?us-ascii?Q?k4ckpP0SAASCZYwp0VOsxPVXb0KwegFXNN4w1U3wv2x30tL3Nrz1QN1ek9+Z?=
 =?us-ascii?Q?pZSNn+yOLzAvHxrO1k22Ev+LcyAUfDN35d8l/bf2h3mYC3q/zKSRHAvy4pk8?=
 =?us-ascii?Q?1WnH5R+9M+wDnXy3Jsz8bOctKIMYksUJeJAXykDADow7kTp+q/cdO5TUsIIH?=
 =?us-ascii?Q?aBe7dk6FjBwg1p0NEcBdpGnjE+RVgN8Lxa9hq3ida5hUAG34BK9FYFmzWmcE?=
 =?us-ascii?Q?2dUy6BN29zQQt7GagUdmPwrwEhXiIThzm+cLwpsH9I0mqL6cCWqW9G9NEx28?=
 =?us-ascii?Q?drS3Sl0jwiaNee6h7InfkqXIG4HFqvjL4Zz3wNyPXwLINdPb2o/K6R2Gx8GW?=
 =?us-ascii?Q?bPOrvHlsC4eBJ9Qt3ZhAJ/gjCgMo9RXTr9uBjZjgJ2eArFEcTTaCwxzON7NB?=
 =?us-ascii?Q?+xaC/uG90e3HLKjTZewGQ3lNEJeXmrs46vtN6Pt0bRyC8POetYs/MfxDNsLB?=
 =?us-ascii?Q?nwYvFp3nW03BxW/uWiK+vMVkhrMgAaHtWAXoukHUhzd+4dXa3H16rRB5/d7G?=
 =?us-ascii?Q?kx4mbfsc/8pHpyOkgXvhTpFlMyTtfLztHytrBsbohre3rGIKMlxmsSeR0wdg?=
 =?us-ascii?Q?YzakU+yalqxS2lhDAnfyXueNDXgGxnYLfG3/qFlTO32ky8c+esEdLTw1FXAs?=
 =?us-ascii?Q?QTsb49U4iYz1pFC6Ply5q4D5vM0jYmAwefT4DMXr7C6ijp+6fL/v4hjc0uRH?=
 =?us-ascii?Q?mFVIG7xT73cP0kZLEDjO3CCQzeyorLDSi6s20NO62LLZB/Cl1+rogIIImjMF?=
 =?us-ascii?Q?ul50ynA+Hxs9vvK1+eDDEXHI0vFPtXuYxBen+e3zZP1U90cIY27VI4pTU6/R?=
 =?us-ascii?Q?XGjJk/aQNLf3SATBqCihO2gcPxXmF8smD+L6zmK1lA+e0VHpe725I8KLbSHr?=
 =?us-ascii?Q?3IuQyeDm1Tj2XTZsR2KIT0qXYLKdyQoySZxQ205Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d13b7e-b0c2-47af-fb8c-08db8240171b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:53:18.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PKTyi4TfgP0AEc6T4jXmcTfps6QLrqSskOJMBBZqib9K8Lm9mXdDIxeZHcMuGcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 11, 2023 at 12:53:58PM -0500, Shiraz Saleem wrote:
> This reverts commit 8d037973d48c026224ab285e6a06985ccac6f7bf.
> 
> A regression is seen on irdma devices on certain tests which uses
> rdma CM, such as cmtime.

We need to fix it, not revert it..

Jason
