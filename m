Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC00575D41A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGUTSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGUTSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 15:18:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC930EA
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 12:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kleAON4eFiYkiOugdwUaR/NwsBJeYbbcb1NoYmDQSwh2WM3I7FceiUb2f71wzy2RphQbLaSPVYp5fZ8MbujXPvcAlnMMqV3bqzMzNoOXWO+Q0hzR0nSOVTm+oXhfStgNM9BQatQYVfdUZjKzYu/G6YQCIygMnQCPGvKX8jmsMsgPQhUIE0MyV35jysLiJDLfAVnxOupNEG/LkUWxDQL2P3gMi8tGVqUkmSLUXO2NDKuDvbPJXEhvoP1vg5lHj5kIm/65nxh/9aErPk6vNiasr3hwEsATzSu53tlcG5Xv7zfHfbhx8yET48bqG3U3v7SiiZguTqJBL2dcnK5hfgI0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXXuZlUV+pLTBk38fcGtBLtSsZfGQWP305G9HUQUvgY=;
 b=mZqZIPhBaSC2WutodM8QT5h6QG3fc+YO5xYqIRPM5dtd0sf6JuJlRLHyMde6eos69KK0udZzac8RNWul0chRNdMXuyLd2vlw+tG8DqxDCcVwZvaVBf7QAbKSKchrQ2QXdN9VAL+kqEDrJNatC6f3USeZ58H/juHt3ZAVPJD6S68HRaM5lOD197CE7pFYMHBxWMgvLyl47uT8TYovsov5o38Vxq28BzThel2mdVlII7dkN4CKSZ+fujqZR9Bv1z9qX01aeFLNnS1NdBegeMiRIUQZ2ohfy7GAR5xV+fyGtNCSgOw0yN7bjbMh+7FZkNA6zD5RBSbMa7p2NoEYxzHjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXXuZlUV+pLTBk38fcGtBLtSsZfGQWP305G9HUQUvgY=;
 b=byDnMT4qoKHfjggk5ugy+9T33sqw+O7RwziOA1WczIplCmFxKNbJWC20zF/LH2H7YH279OkOl5GG3D38Uf3+rKq1HHdJ5OsTsTfaOcNGFHmShn4yeLG9i4JD0mF6l7IgrymRFR3ud0dhE6wg//q6xzNBik0EogqIEv6RfGOAXBtkfws4wtNgP7/nYhJCQg5d7eLj7N+1w9vS/eZ14nGc7MQMr5adCwQ/81OsQyAwGuFRUGSqKD5Ee/O5nAea+3xNuRXJIWOx4x6g/bjbvr70eYbHy93GKaH7bne7WvnDvoZS2I0IviOITi+s4aZtvkHkIJm4OmwH7lL/2inbX06UdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 19:17:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 19:17:47 +0000
Date:   Fri, 21 Jul 2023 16:17:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com, michael.chan@broadcom.com
Subject: Re: [PATCH for-next v3 0/7] RDMA/bnxt_re: Doorbell Drop Prevention
Message-ID: <ZLrZ2EutRlQKqeR3@nvidia.com>
References: <1689742977-9128-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689742977-9128-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4cfb99-04e6-4342-0f57-08db8a1f2b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NHbRd0vqud5nfOAgq4+0vVVOdLT+yNE70isnFNL0XfBKHCEsNS+6eDhm/FuJhujA6KBoVFH1V4A2AAsVhph1jrVs69Xc9lZ+bF0iSi1oDUnf3YIISfA18YXMGZ3qCpnbg47XCUrvTZL8t3gJY3efG2Gca/++vrC0I/SxT5nMK4wQCkUe/CqBj5OGQRmJ1qla3+OQ8lneC0Y6wR1x05JxZd+Rn1lz/uRl3D5H+wow4PxPYfTtGcg21PSeo93/RWY0d1M7nkdJzOlNPt126KMDTDemXsKGzxQJWUpXLu7O9ITg/3xWQVSXNXI54d5yMypRxyBO+JKeqX7118D8q9JWJRtAlZZZGUXajwVJMFCCAbQRei25JE2ffxxE1yVbwKfpTgPhmHUXX0Zuqbi0nPdnvX+wZOUt5zAzcJlCK//Z9BbvmctV3kyWwwEFf1n82IEDe63KOPKzeMQBEgX5rYpaEfLjIvuREuW4QqTaszHATD/ZQ6MAqNJCiXZQtg1Q9AWrrBSRnoP1HGPzpZvKo3/xeXmoMpurgWiBhKPRNlPGzHza4J9irpkp77ZCxZI9qAWDjY0YaIE1V/1tWmDD9qJwcpXoc0EThcBB9FkAb0xZ+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(6486002)(966005)(6512007)(6666004)(83380400001)(2616005)(6506007)(38100700002)(186003)(26005)(316002)(478600001)(66946007)(6916009)(4326008)(86362001)(36756003)(2906002)(66556008)(66476007)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ju80ED/lsg7IveDR+iQg2RACdRlEIJx7D9gtG9HA6QowDX1IVLLh7AqbQTjj?=
 =?us-ascii?Q?GLfsoXAaGi54AYVe8tBnOxzt60FeocJZCpwD+IOkXARpEJ7HvMwy+6/LRAce?=
 =?us-ascii?Q?bhVhMQ+wKKBU3EmYfk0dW0b3IzTQzRU07IwOLtlKoN9Q0grFcxF2pjnsnJyu?=
 =?us-ascii?Q?u+ipyixXCcueJBn/coRkSLWl7aXWKKoLYjb3DXnR/mjWvN9Jg5Pu4G37lRgk?=
 =?us-ascii?Q?+6H/ar8Q749R35Yiqe2O2XqNBLhabWgWR1z3zFqdh6lv2g4uRoj5JaS0SLDg?=
 =?us-ascii?Q?TtHQc5YzWihQwfip6Gh9Uk/RVzh2JHk0iAb47Q1gqfGyOOiouA/t8SUDw9d5?=
 =?us-ascii?Q?qxzuDwy2bozld1FORAkSTxGDMlJO9i6+bNmbU+DrA748T22mqKTrnL3yUK9d?=
 =?us-ascii?Q?VGp0kq/PoN7fHldrGx8eYV4Qvy10Yu3qXBF/Bm9LTh+2E5lj9PI5ay5KqQb5?=
 =?us-ascii?Q?EXm0F2AE7eis2uoAEumY3W3QXhO8ykbVKlUIaFAyl2/LoEVwmjTrAVlvpRyr?=
 =?us-ascii?Q?6nOJDR3pFDwRMC/hnbCkXphnWRXhJqc7fKOVCOc0DUUmoGKBnlNb1GilKlLT?=
 =?us-ascii?Q?OxYTcPEN71+I+5pffiRA24LfBptW6JBWazeHDpD/+r704Zj34kLnWzlJoLPI?=
 =?us-ascii?Q?kDoBMHJRFgGifhRGewqsu73pv1WK5jzwwNkYRs2VjUy7Kdv5qdGNjJGZRrEm?=
 =?us-ascii?Q?407uohl2kdbN9KJ4z4cfj7shzegB63VxYn7RzrdpuDrR+9kxDHsQAw2cmBff?=
 =?us-ascii?Q?oXfTu3PXVkOJfXC51dfKAEJ1XbNsPw/0qPottMDaFgqjIDVYHesGA39/ZwPp?=
 =?us-ascii?Q?vP1RCM8OLVIujfwIz8nj5Z4gagmrGmhKgcqkoAaWUPmNZHKCdkYtwMA0TrT1?=
 =?us-ascii?Q?JYV9fCT4Sw0PGspkqUMApxtoH2qPd4vn7s4+J6mDYUVNhOWszK5SpVRXWHjD?=
 =?us-ascii?Q?yPyw91YkIzQZx/M4UCfRr7bs+nglOdE1koY8wkDTQ7W01JnBANhu9VPIs2P4?=
 =?us-ascii?Q?/QAuYZc/MpX5YSBvHAvxciOJQ/b7mZOr3dq0TjfXue8ux+yaS9gt7p2C7o2y?=
 =?us-ascii?Q?H8b2n+sttaXVglPoystH7zEXk3gfpf69BJ2Fv5gmbe5HEcOSg/AgSB/RJM3L?=
 =?us-ascii?Q?K1/UYUzEw5wAzLTGJ/pP4a43fECoYPIc6YHOsu9bZU5WNq1Prv6Q8suWSFY+?=
 =?us-ascii?Q?cltgcNJFT5WDcZlbz6jLH03ggiHWURwlTXxVF0pF1ZgCLXigDQ9XmTco1Swo?=
 =?us-ascii?Q?gy2Mqr5Nhyc8zObUN+EwJJ6Biz41JaiE6zneiUr3KdLXi2TcU2pedV52/fKi?=
 =?us-ascii?Q?QkuBEFmRZ5TPcOoXV9pudyPZ4Zo89fG2gWRxjDb06W1DT20hR+p48fmfMJan?=
 =?us-ascii?Q?keSmnSTbbTHdFJ3YX+66HRiEy9J/E/PHdXqpwXIRc93UJZFDnKr6+7OGVTgU?=
 =?us-ascii?Q?HmegtfUoibJEOdU3j19bo8fH5UfIXtDaR7tT/KgDoTMrxwaeUjegFsecEt6X?=
 =?us-ascii?Q?TAsSzRE2u0dsxt0mxnROAUbL6Fa/764dkZtY2+9xnKrxnMc/W3pOWCa9kfG5?=
 =?us-ascii?Q?d6mkbXoDaMCvT9ptnhqukQKD/Rs/Bg+pKV+pvL+f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4cfb99-04e6-4342-0f57-08db8a1f2b32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 19:17:47.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdDoZgEI4UpXi0EJYVWVV3RHJPqHsocNyapetIcptvBYcaCjNp2K/3Nm3szuzICW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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

On Tue, Jul 18, 2023 at 10:02:50PM -0700, Selvin Xavier wrote:
> The idea behind this series is to prevent Doorbell drops
> on some of the Broadcom adapters that require Doorbell
> moderation. This is achieved by pacing the doorbell writes
> into the hardware FIFO. The rate at which individual doorbells
> are written needs to be dynamically adjusted, because
> it depends on the ability of the hardware to drain the
> FIFO and on the number and behavior of individual
> doorbell writers. When congestion is detected by the user
> library, it notifies the driver and driver adjust the
> pacing parameters dynamically in a shared page, which will
> be used for pacing the Doorbells.
> 
> Currently this feature is targeted only for user applications.
> The corresponding user lib patch is in the pull request.
> https://github.com/linux-rdma/rdma-core/pull/1360
> 
> Thanks,
> Selvin Xavier
> 
> v2 -> v3:
>      Fix the build warning
>      Reported-by: kernel test robot <lkp@intel.com>
> 
> v1 -> v2:
>      Rebased the patches on top of the latest for-next branch
> 
> Chandramohan Akula (7):
>   bnxt_en: Update HW interface headers
>   bnxt_en: Share the bar0 address with the RoCE driver
>   RDMA/bnxt_re: Initialize Doorbell pacing feature
>   RDMA/bnxt_re: Enable pacing support for the user apps
>   RDMA/bnxt_re: Update alloc_page uapi for pacing
>   RDMA/bnxt_re: Implement doorbell pacing algorithm
>   RDMA/bnxt_re: Add a new uapi for driver notification

Applied to for-next, thanks

Jason
