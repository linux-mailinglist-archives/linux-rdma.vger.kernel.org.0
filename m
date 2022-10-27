Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA660F6BB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 14:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiJ0MFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiJ0MFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 08:05:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09D6B8E7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 05:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgisG049pIiXAPzsPrXH6aHHDQ7/WrRLnX1ddZ8tY0jprTJjYhIMgn/ym8acVzXKUoYtN4Is8eJhdNdzv086J9SFIGwLOo2DaLMOQ0Cpp+nMumE/61qHQeBKXxLdy+nnhUdvTSNjw6gFmzr1FPQfw/yvn53pJgLQ/QXrLqdDgd9UIaPbMBgsqNofkRV6fbadNHoEKH6uBAch2QAMIIvFVSUVU5oehZc+J4mtvP8CcVyz2o1qrcbbP6v2KonBPuEe2koF7YtP6IO3BDSj+IrfdXGYGd2ZDogVyd5kGk+Ib34D7aMhU6EZWVXfwo8O2zfniwioPulG3u0xieZu7cn1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhAkeWBuQ8ClTu+DhyNV1Rzx2v1YgaI9qVIq/mqIt2c=;
 b=UF7NqkZC78XNP8YDYSWZ5vGLpjZwsL4fMGU2br98TTx+iumCGxZ9VtWpbq7skhwjerbN3G/piolVTiaQzNze8X2E/HtRKWspgBB9VeANdRRAJeiib9BOBd0QhGPJRre+ON0/vrbxbnl4nO9I4re+ZKv6oZWimto9rGoHOE3GxouSdnN+HqU8nGW7XKa8hhu72CVnqjQhOL2JzjELOiJs1CFzxr4rakS7Ufc9SpNTAuXMuBev1ye9NYpSrCD69YbxsF36A9zElpIZYf1SslJjlKhTZP+ZItzP5rZJ3tFUVV1Cp4Z86tCcbBtZ5+8j5/h4gr7rYC8+uSp41yFvJU+Keg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhAkeWBuQ8ClTu+DhyNV1Rzx2v1YgaI9qVIq/mqIt2c=;
 b=YnPRQ7+Bdjtk44FQ4ILOstdOQL8XLpl5LdA7n62ZqfrNf36HOlsfzOD63xteDCdONzJsdGW5OtsGjhr9PwU3ncRWiAxn8Vzxpq0agvOve8LfNgJXtet7NCyBAo9AjegZRDEsvEONm00z0i5j6Tg8+PomYkPRsFVU8WRcbCJVOv5Mo2orWEXmPnPG+rCA2nHALUtqi4bRuPJuj38fEsbBOwdnypoLfPYNh7pS72DbM1ZyJXwezjv0PRf4mz78gH5N6PwBA2cNpfalOhcZ4Ah3SO1coeoMAhRggnx9OxGLs8dBDLDWpxaoiqQNVA9QUAa1vkodRrWvIE0tY2S7azycbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 12:05:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 12:05:09 +0000
Date:   Thu, 27 Oct 2022 09:05:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-rc] RDMA/qedr: Destroy XArray during release of
 resources
Message-ID: <Y1pz9LYGUScO2Zpt@nvidia.com>
References: <3af204a14d3dadf4102cd55ef50f0d927bb97884.1666871711.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af204a14d3dadf4102cd55ef50f0d927bb97884.1666871711.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: f538649c-9854-4c56-5d71-08dab8137e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAP8/vOPOoMvm/+vdjQu3R+8KSPqIwDXciJfP5QfyDsWoM83CnHsrEsKyEWNzU17HIlGsiMGlQw4TMecb8/PFDjcMaY14sdX7dgtYOnqcNRGQe/u5gcaWvp1dHYGSoIlTSPcGBa7GL/GGrBFryYb0Pc+z+j0c2vmenXst8nbCaiqSDFJrY7TYKDwoeRWM2M7TqNlhcmfizFB3vUrXewtApeGDHc6CZ73gNXWK01S/LrRaUIGd2WsO2ahs7/mNJ+OG9p9BffY+pB+bO+ANAZ3Sl5DlgMst9fV6+0EtT5KcYJvI+QOPM87iER8cpnbcZ61/iYivgegApazBr2N24BzMwemeg1lh3DOmw2d9VtvpaAzE/w07mnk/HS2uHlV0yEjuoYVTOcc6lGsuQEQwttEvYEmQB6ye3UZf+GIBybSJTDips4G8bI6ixs2C1yBF/EFHOBR6UsMiZ/vFhi3zAW4lZAy1l5YmmqXOB0+Zw5QOTYsnE9ehsCEAohVmcOSdCeMAe26GVJWK4dMZdeybQEHWro+jxDanXBfe2TTA9Y2sqaUoLnFIbpWA8mw6j1tEC0n7Tbq8//tg+2YpyWdv1oJvi4Wz5tdCwkdTfI5OMM27v17JW1wMZsyPxgwZcRbZ8HvO5P5fAyErMAgQFPnAGYYhFdQn1nQ1+Rc+hzNKVtidzuPrcceaX4N1PnY9yDCQLqBA4OAJVcoWWCwqDEwiNTmkXaK6EHm3v91dIk5x2J/85+rEYbMaEPqHX60n4oiEFX4bxlcHxPNoFab77OuTonQuWwxVwBDuZ5p+S2ZUukYBAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(478600001)(86362001)(6486002)(966005)(8676002)(5660300002)(26005)(6506007)(6916009)(316002)(6512007)(66946007)(2616005)(54906003)(4326008)(66476007)(66556008)(38100700002)(41300700001)(2906002)(4744005)(8936002)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SusfsC2x66RF6tGPLk80DiU5fBBEXpSGV9kJVCvrJmzFdv8k/HIIL8pJooYw?=
 =?us-ascii?Q?91UC5b/D33gxkpP2FMDliJFV29TDk1eZTvHiy5XTzqNPmYiOIugQAdWRbiuK?=
 =?us-ascii?Q?UZPZnsN3153391FejTvsJRmnoto8rWIw3QXw2czUrllqsYqGcfMFHfoaxJKk?=
 =?us-ascii?Q?79gCSb0efDRg3yYzJ6Uf/uiRVEC3ZdZ279DJoLdV+QHOTF76fpOgCyRrdN6q?=
 =?us-ascii?Q?XWn3Pj+Il9f8n0GdP9G1G4VtAw3ZtGILjeUlOzbKnDvjkxkP6hSufvZnoy5M?=
 =?us-ascii?Q?8nMIKblRxww39QzfYN93BfzEHPMEf17kNhkrdThd2lMkeniwiH9I6RGnH6DZ?=
 =?us-ascii?Q?ugu5hd6mQDDNjkGwzp1Co/9mg4LaEVD9Gg8my6HZi/R7wf6WQzQQnTHwPEiI?=
 =?us-ascii?Q?T3ZMRVM1nuYbttGH7/2on1uE0339aAPY9bWGcrGdCfkr21tJNv2blUG6kp0+?=
 =?us-ascii?Q?M9JnvYt46TGZ5GR7HyDMq9Eb595J0T65pyzYDp7Jzf4Aw6WGx3UEm9bdHgfi?=
 =?us-ascii?Q?VGxb3q8vRE+DjNGcX9PMSt3ubGOjsDpPeTyiITmaKv0KbJk2i08yHB9xe8J3?=
 =?us-ascii?Q?wXsfRX37CLzRBSS9TJIiEbQBA9Zuqk6fZpkYuFPYjvfX7mHjsmueyyXwNi6c?=
 =?us-ascii?Q?X5VRiU/jVfSPwacnDApzW7hBkFK9bWi48+RjjAud4KafJ4lrdC+/IfxRTgLD?=
 =?us-ascii?Q?MyZvO6ALmGvKujImuO4y5Mh5e4V0l2V/1ZvX01uq6TZPDudsCArpTgqCJK7X?=
 =?us-ascii?Q?FNAKnq6URGJSkZ+pHfpXj/apzTQMSewdgqC5S2tzsDJrwvavipo9vkNdWQez?=
 =?us-ascii?Q?cPBxEMhs858wYpxZiSN1DXf5kbiTRmbiKDgaEsu3RCaOCagcbH1wPZmUixOj?=
 =?us-ascii?Q?1K/Q+4s9szx6qpKXqaxhiykrtPXRTBlN1ASm9AwrYTFCFFA0vvFe2Sxa4w8T?=
 =?us-ascii?Q?RzGlbr4hT3vM6nQ+28ErBYms38iIps9tzk24h0nSLSgjnmvL++vNzN+IRC9Q?=
 =?us-ascii?Q?8xSKB5aWChKmXL77QaMl5YqLkCy8ba0MnhotWmv4H60+79IiIhdJxiibBKOM?=
 =?us-ascii?Q?65g+BHIIdOKcbDz2Wp+U2bzf9vuJxN/K4S3RVLZJtLK0uMcfybZ1GKe6byKR?=
 =?us-ascii?Q?F8eD72zMRsY7rw7lCG30QJVl/hOOYMCshbJlrPcb3HEtb3cnMeCtkP4yd7aN?=
 =?us-ascii?Q?w1qUMvku93Yd+amyaC8vvWpvzUpT+Effpvq/jxdsciYre0E1MroGrNSbRKq4?=
 =?us-ascii?Q?hDtScmjEvNEIN2ELUUTHYw7EiUZu6dWu8/kAw8jfV9i1WUHnDZLSAjbJeuWz?=
 =?us-ascii?Q?HkJpp1LkrXvTcRnj7K/LLgFeuGZ21oK4YHKs18FjQlpGGPAJh341ipyuUrTW?=
 =?us-ascii?Q?dYWlghC1kzKyGxsBX93QDVVytthf5sdlQIWQLOCf0nvRV1mNKKBXDsB4b4BF?=
 =?us-ascii?Q?liUb2HRPzxzfAjqLptd+91uz65oTi/+jlXCsaNcWaZxgMHgihx9Ep41EzsAX?=
 =?us-ascii?Q?/1lY2hx/TDSiL+FRCEOHKVel/p4iMRKqttXuFv9+R3FleRKA3u95GOwohkpF?=
 =?us-ascii?Q?BJHxlS6i32MMBv8yJ4w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f538649c-9854-4c56-5d71-08dab8137e70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:05:09.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6iQlF2TrBr2FxmhTveASSslnIe3uXYpjVjaPF6G9TIszC2cOqInMiTXebttp94o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 27, 2022 at 03:01:16PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Destroy XArray while releasing qedr resources.
> 
> Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> I'm sending it to -rc just because of dependency on
> https://lore.kernel.org/linux-rdma/166687129991.306571.17052575958640789335.b4-ty@kernel.org/T/#m0e945baa7f2c87ede9f1711c992889602ede7875
> qps is empty and nothing is really leaked here.

if qps is known to be empty then this should be WARN_ON(!xa_empty()) -
destroying an xarray that holds allocated memory is never correct - it
will leak the elements

Also, this isn't "for-rc", so it should go to -next. With a dependency
like this the patch waits until linus merges the rc branch and then
-next merges linus's rcX tag to resolve the conflict.

Jason
