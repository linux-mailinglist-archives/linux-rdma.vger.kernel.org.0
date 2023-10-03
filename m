Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0E7B5E3B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Oct 2023 02:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjJCAbS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 20:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjJCAbR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 20:31:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B3DA
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 17:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8LKw1jpANibhLgWx6o7igi0y5lnKLSaDileij9PEOf/jQaKhtslsG/6RsXTyHkYCy2A1H2Zst1By+nKn8OFMwxrZUnu042zbpGKDhb9LzbzbOSdb79CY5eKGNYqMuY57QmUE0ymkQ5wp26FmZKP++zv+CocCXuO4qHNARGa/BGG3xtdezsLGnx1ECMBMeMO5S+jH+rouprCQcwz+r3of5jtaz+o81ZjyH3bNetG2yDXDGOI7DUUs1LKbg0GJxDvtd95USe3KyfEnc0x19r/3w/FvVj4P4VnxORooGpx5ni+r+D2lhKvW2mLbB1wfT5C9O3LOfhVYiPjWNYdr3cZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXGuEV0rMKLO+2GKw7jqNnspYIP2yiCCMYLsyyzvLdU=;
 b=FXZ5zP5BHUJ4uH2stNGDnrPL+PGEJDrXVkPCaLrOQ6nKL3yEwKYjb8CJy1/R2IQBRO8Ewjh8TAkjSzq0tRv4wfCu+iw2zMpDuyBFKHmyOkAysZ5SnI0SkgpmwIPXNUH2o2NlcQt/B+DVLXkI1ctxQlXkya1HQqXStjyWwVTc3ow0mlyWZcrc1oKEzFOO+8kRWwJvAHOBqA3JEflpeLxjew1GTr4Y0SzdK0WVzX+SIvUABOyQd1skm75XrGA5iTt+TWQDI/mjHXm4p6OlgERmbT2raA9e7vsx2Mt8E4cR4SkkZRIJklznCjTHv2b1C1uTgJf7+L4zf6/BTdSBXO8Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXGuEV0rMKLO+2GKw7jqNnspYIP2yiCCMYLsyyzvLdU=;
 b=DD7XNbidsw7OW8j9TBP4wK0Tl9DzL1OHcP4mcXEl0sK0DJwKgzSk34XcCNlgJ1GQIQCNiuiMeS0e1NxJew6ODc6RgmFi1DaAfMzRoM+O8FgMLrY86EIOoFak4lTBVw3ZNBeKD9Dxo4ReHa6EcQHoiz7JdlNGmKajahhGqAsxu9YeBqxrn6Ogu2ROWLr7YNsPmL1CnRjuy/2E2pqxMvR5x4SuEwL/aLegir4vg0r8928Z+r/Yx7NLqMGkPxJk/pAdfL5xHksC7aqB7+ilqxBc7hk74NcUcbhBilVzCnJjmeInF39CA5ErmAxAu8FQAjsdb4BimmRAVEw+GP/9QJeJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 3 Oct
 2023 00:31:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 00:31:08 +0000
Date:   Mon, 2 Oct 2023 21:31:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Add support to re-register a memory
 region
Message-ID: <20231003003105.GB682044@nvidia.com>
References: <20231002234917.202-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002234917.202-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 068139a4-c23f-4a11-8871-08dbc3a8091b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnZs7OeZ/tTV7XWH6x3NtRmfBE8ffoUJwixXolW1cR7T0nQLIS+b9T8fP1AXrDdjqQEF0aFvkOThDmkFhMkAgguF+If0ASYJfZDBMAUYleC+TWHnoLDNlHKTsyjAtKAs/5CxkugKSXhGATUG8yqz0u9jVi3485Xnip0hKdaMuqu0M+n5t9x9XUVymkzx6Ent++EMHuxGQWfS0kTX3gsj3lXi9+LJNjs3Lf+GfEyoPxNIAKY7pHDgxC7l65a0vJEOGtj7BNzQb6nIeyzu+knArKiHCKv5vMHWtupWzbdXCSM9MLU6qj3Gzdc/HvSX8s6vy6TPy+0SKzHY6c+0mGuJ8Opld/LJ+9LvJe+cc+auV+BM1FqE4XmHFcdm2pFsSuxBe+4ptsaGDmFZgCIf0AP4+28inVO3nIV7U/GJsoPJI5qeE7zSPYkJWvzgixiF8mpxdpuQiKSy4uF7jZDUTdqf4xA4q6JaMNb/zxZ6PzfF0DKcnxpwuAemHYOiuFOBwD0B69w2wdGWWWmJxVaGVzBy5OI7TSXiZuKE+CZl28PIbOfZksz/Yf+Fyv0UXgU7JR8QRTb1FI2vELlcUCb9T+0hKUpA01qF1crMK6UG+++pFZNMu8U1KSsgAAoI+wKDzfzb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(8936002)(1076003)(8676002)(5660300002)(4326008)(26005)(33656002)(2906002)(4744005)(36756003)(83380400001)(86362001)(38100700002)(6512007)(6666004)(6506007)(6486002)(478600001)(6916009)(66476007)(316002)(66946007)(41300700001)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QsVeHQWZ+DMzIvgluVesOu5YpLKMaoZiUcWoweXOl+ngBiGEJ8/7mdzMvlu1?=
 =?us-ascii?Q?nomvppvxpf54gShnEDqzRSpetTYbOubnktY9u7sx8iR+bOputymt0SvEauW8?=
 =?us-ascii?Q?IOYen/vqowSHFAmJ1DqIuLNvoZaaUIxqXmOCk19UT5me7j+c0v7NrmfHJYXq?=
 =?us-ascii?Q?axDXsWKt1gxRR0sCsR60MgVYTogWAf3utFeSJbdLDSjtc0MPH6Lx7aW1NyZx?=
 =?us-ascii?Q?thLLk7G+1QMXTTKi4x/0bfHMlJRkZfOOkgBT+SYxsOU8IdNQnV3cipTsJkm7?=
 =?us-ascii?Q?FI43Xmknm9IMrqpeu5IbA6yfIFw5ykc72+8Q+VEW0NyZ9QJKxAK3+MWuTXYD?=
 =?us-ascii?Q?deRzSUhqnCQzAx1fzGAVURMXsMcoxdWSxhZMLNkQ8jeonNHNFrkEyU8/KNN2?=
 =?us-ascii?Q?JuE2faGv3vMtLIW4lBD/g3Jv4AnPQIihJCoGtQwiboq/mhs/yP0AaGHNpYvE?=
 =?us-ascii?Q?40nf4YL7QsQjLT0N3lGmdjxIhgXtLrYlBJG2fdmlVcJbwYHzABPwsgi0dhHG?=
 =?us-ascii?Q?1TiEkQYW1UpKpM8jds763V+DRmwwPn87M/eU1rUTO9SjJOUdjHYlKvn3rrrA?=
 =?us-ascii?Q?rhdHxpnCuMDedZrlHIjMJYOVG4zETsA/MtvhhpY0qh8JDpQB4qeV2sTpJLz+?=
 =?us-ascii?Q?2ZxoUJmra5FJ6ybInoJ5vgbBI9PMfWppPvaDuLK4JxBXjJZJfR4jGlbHkzzv?=
 =?us-ascii?Q?41cbFk7hWwqlvh6Kn8aKt8cEsPVB08vaKmC917Tvxgy+T+t9VKSKgXRCq0Ez?=
 =?us-ascii?Q?KHThT/2ujaMwyRazNVemf14rSomY/oHcCocNhov9PljT88lwkIGybghCQkgz?=
 =?us-ascii?Q?1FDfngxmTmUevfQDm/LdwxuJXkB0BWSplxPmVPKmNo/bFdYKKlcgCL5yfBii?=
 =?us-ascii?Q?PUiR5NqvdMzg2SSPHE7jHY5ufqNh4+Hbrhiu6MR+1C3w8WLUOgrz4CmmkPsx?=
 =?us-ascii?Q?pC8Jl8sBO+2grEXDVLNv6COd4xtl165BaMY0uBibnNnOca8XS/YHCWdCfa23?=
 =?us-ascii?Q?tSuLPZSEiDxm6YT+z8zIxJGuj3DVcTTTHsyRTztKN4ri8WlS+kJXBsrI/0Ha?=
 =?us-ascii?Q?U/qtvov4wn9W474KtRV7gFg88n1mcDW2pqUQ+2jt5WCfTe9fI+DnYQg0qxqW?=
 =?us-ascii?Q?B1yPGpnQ05riaxm2sCNVSg42BRBpIlZ7rrxyBKoLvk2xexcWh5k7c6xQjHTi?=
 =?us-ascii?Q?kYHO2jp37FchiOoFKjEuXDKlZxRVTPbBbLkKGQU1ZuZp9nBk5Ri0satT6G4m?=
 =?us-ascii?Q?N+51ydHI9mRW73s/n9SkLxaAR24akHJw+wTTWjL9k8a4Dm+bD2eoJYggekCc?=
 =?us-ascii?Q?YPfx5yCmHYNscvkqbH6pDyu50erD1SbNqlxUMeEVJKv8FBDxcC4IDZYqwf5J?=
 =?us-ascii?Q?4I+u5fnLmJSXLFFLBAzy2tbdH6a8hfmK+n3bXp/RoczQfSFP0skv+dOp+D6D?=
 =?us-ascii?Q?cv95+1yTGT95PmoB1kWvV6vOuvj8gUSmwwUiEFUyHPp6q0m5KUIA8s6W6hpY?=
 =?us-ascii?Q?z4ta+LEMZnFaPwpedqfA5lfSrYfh0XifXE7mIpc3S5Xr6pImw3W24sZdDnLJ?=
 =?us-ascii?Q?DagMDUQAHNmfZwTktw0Y4b4UrQYZbd2zRvmwwAmw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068139a4-c23f-4a11-8871-08dbc3a8091b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:31:07.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KAo9M+gw11TM4hAfwe72ou9JT2v8WTIbu0GXebOZ88nrpNEnsJqfKJ5khBltAJL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 02, 2023 at 06:49:17PM -0500, Shiraz Saleem wrote:
> +/*
> + * irdma_rereg_mr_trans - Re-register a user MR for a change translation.
> + * @iwmr: ptr of iwmr
> + * @start: virtual start address
> + * @len: length of mr
> + * @virt: virtual address
> + *
> + * Re-register a user memory region when a change translation is requested.
> + * Re-register a new region while reusing the stag from the original registration.
> + */
> +static struct ib_mr *irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start,
> +					  u64 len, u64 virt)
> +{

This should just return an int

Jason
