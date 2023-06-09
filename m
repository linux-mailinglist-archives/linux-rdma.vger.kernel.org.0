Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B172A017
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbjFIQWU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242169AbjFIQWT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:22:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF92D44
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYwFEkI6YiRyQ1RO9OAiJw8vtOeyKlC03zjwSoFF4gd0+ujK1bqszlkCuvhG8tGwpDn7I+BcgoXtEyUQQbrMHxZpN/fRVTJilbBXsRNdpzaI6cEM4AoVQxAu6V4NtoTnKcqrtjcnpv8cfdc918bfNuS0kagbPLRYJamd+WgGKrQ8FzgT6Bs/ixRu50vcXJvnwSRQPWb7TP1Io6cImfPSK2sqbovuUTDkmO1B23ZlEzOnl1JsL2ZIF2PiK6+1vG+VqhnSFhaLFKNcoJ9FFLSNL0mgrafYymqKwax1FzLwOwziItUhlG2UwLXM+Qkxo61vBNAbese7rkvuE4eIHXOTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrDi981Cx9TXbmovQIOfIN6DljDlqa+GHrVlbZEFLvs=;
 b=N/6n6xg5i9qhax4ItSxbL4BJQqGWvUyDlSczAe69t++eRl1QbT2vPtXcB7mT0BYYZ2R9dmgKLAx3/gJddbR7/yHSvmOluHwZ63jOv2Y1JBjSwGLJ5V2MkFyLRe7BuGgKopcIiZSPbn269G+KUyiCy4pZjHwki6A3+upNzzk3gtqZpxAeIUfN6iBJCIIkrvPbQfANh9HP5Luq1ZKPwG/YhK+Ne84rpijZRmpjCTMZodEIKHCi9igBlVUi/ewCttTCciRWzg/gy50ssyBh7Jmc3wVAn3feFXDncUwdoaw4mXDfdO8YBQJBTAH9nhLfEgcl33ERMC/VwzIhTPsKZ6lIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrDi981Cx9TXbmovQIOfIN6DljDlqa+GHrVlbZEFLvs=;
 b=MYYtNX4rj+DsJGIPetfsGEFL3JmbP8n84n0A5vEcAyfZPUkjJ65ovnbKbshcn3lUIPrX719WGX7CPH6R55qrk6KMzgfHAfmazyAgQmBaXqQg6iQVh2tLIVBw0jl3AEDXvU5dW8CmyTfWXrkm0x5FrbBXN1jcf5uF/CZe6C5dckmcbslz3ZumZM6C2PfZMUyBAa4bUdlrP59zct6kCDIHkvu0EAGhfjT6vGkjLxiN4zts9yazcO5UOp0F+VgfvrBXMwiGm8/iAHQ9FT3LIK0Ky8W/X5Y15cjsgiKFwxTP4E3W67Ou54aYpadw7b0a6HkHkWzjUVcfQrI30QZ/u8d9yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 16:22:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 16:22:15 +0000
Date:   Fri, 9 Jun 2023 13:22:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] Misc cleanups and implement rereg_user_mr
Message-ID: <ZINRtUDu1J5Kh6hf@nvidia.com>
References: <20230530221334.89432-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530221334.89432-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: CH2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:610:57::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2da48e-1fd7-4cd4-56ef-08db6905afd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3cL8x0rv49NPdAbjACu62CE1LhRszqpcWmAV1dNqIYOEoZWSfEVArQSHrZpFO77prGZLG3ocHekfVcA7wA+HBYN8mmKh+EhMKzSHeE1ZViFrR9+nsbwz3ZJ1MHRIcuAixQVwucY+7oIi58623qrdzLv8gP+kfBHE3ZQTVQ76UxA+wTW/3y6k8W+sGGEKr3fFuS+srTMbry2N9pnzXcFRh7twwieWijObqcGBXrW/cYdP+uyl91awQ4poLHTDWagZ85D+P2K6zif1tVr1e4zGvn+qBwiIGRP1paaMVBPfmH5/DE/mGKBzoPQ+5T8vMB0vQVaeTqIktGnfpQ7MuplL69MM7nxG3oIGk0xsyLtMzdj1BeZpPonX7zzcUbL1AHOiQ4z8F9HbPbnNgnTaWnF5yACA+kmBbGyazLfqzPmy5S/k7Sm6f+3lTw/ci25DdWBOMRoZ2LpRoyw7m63Gtz/phkrEAwRzYfSAGiAlbJQihiC2/Oqn4PV4WBmB3d8mjNRAWGckaAxklIfkMrVTid9oL2zVK8swy9YO7v0rhYKQ7Yuq8+DXoK+yqxoMDzbAo+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(2616005)(478600001)(8936002)(4326008)(66946007)(316002)(6916009)(66556008)(66476007)(41300700001)(8676002)(38100700002)(186003)(6486002)(83380400001)(26005)(6512007)(6506007)(5660300002)(86362001)(4744005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6PH1ncsIDkjYNSlRNbvBiHDIrMzcLevmB3eQkoyNQ9FfsyGYAGQBAbU9m8c?=
 =?us-ascii?Q?LR+eER6ILfxyPmbT1K2ec58D7AS8e2Y+lLnYud4Vc/2tXlp8na6NC7XQjjSM?=
 =?us-ascii?Q?pDwDzKAWvv+I4vqiukzzjLeYUfNOWtu9vyue0QW2nQkrxyzAJpQM8rL/Xm05?=
 =?us-ascii?Q?b8g9fVrahX4pRM5jHuCAQzbbPfqiC9NqoWkx0bxb9nx8JHj0zP7uK7Tuk8lE?=
 =?us-ascii?Q?pgC6U8o2s9VYKMSfE4H3N1O75AIQ1LiCe7/nSQtaOh5IzsdVGvWuNDbm+EWx?=
 =?us-ascii?Q?Ke/4xFl7uW6AYG8K1GwKpTRYjsC8OQ+aqNGbCoHwaKbcBexdh2tcr0zMlTBg?=
 =?us-ascii?Q?EJVbxqESAF/tLYXRkogACNzP1K4g2ncPwTpIQgiR6bQOhwwhKAgmpKDN7YIU?=
 =?us-ascii?Q?BYEbsRWIYkWpttx6h6qVSslwh8ftUHXVZrAgTE/BCcAhz1YLWjiyqqMkB2Z9?=
 =?us-ascii?Q?/qxd9DPQXGQvuFxz4CBB12uJpvC5VCwCB/kfqd0N6MjWcEaE1B6/uhnjEOug?=
 =?us-ascii?Q?B1Fbbnjjf2YJBvrL4K4/zI1uugAj1rZCtjVqEiFzuMGBEk56rVhqTLVzQgV4?=
 =?us-ascii?Q?0BNYRGnr7iQwXfkpBoam6IVj5QLUTnQyZSV2OkzJdnq7Iq5at7bxznWhSOGf?=
 =?us-ascii?Q?jsN6vRFMtY9mlku0KQdNOsuyWn4USSvHPwZyPhmnUqh+jWk1PlRm5Mm1f/yx?=
 =?us-ascii?Q?4bThrUrwObOYP0yzlp+9UWaHs/Rd87S0X5/wMwwDbyZYfnBy9WatGeAS320c?=
 =?us-ascii?Q?UBFu5uhIaw/5lpJjcVHCtfSvCH7m1+d2ipM9KD+nfjaSwYcPgcqvBAF/jR/W?=
 =?us-ascii?Q?JIiunsDNXHScMJ3VrRUD7SoG7cyP9JLHkU19PlE0D9SMoz12ipaSooFz3rGa?=
 =?us-ascii?Q?NNsKiMColTqtIOxAZ+bZ8+H4DaKiAlqb6reTvT3T9SiZl2TxwkpPsI/17iWg?=
 =?us-ascii?Q?sAgQYgF4p5yZ19s9wf14/HMbYeuHXcXYemsYh5bkvKOV0BTQLz0oohDEC5wB?=
 =?us-ascii?Q?FaWaNoLes3jMrKFvlxFD6f78vmxg2QHUqSA78xt8eOqOKIUsGI/vpVsivT9t?=
 =?us-ascii?Q?gb4ZVlkK+twNhHdqCihW57bi5h3tmkRquPYWUaIcgYNBK3yz0fntR0EA60RQ?=
 =?us-ascii?Q?b/174GRWt/DB2Dw4NmUErFKeHs5BdouTvnaz8PjoAIyC0rejkOfFYZ9WSSCq?=
 =?us-ascii?Q?JS2gS6TEHGjr/joBoBIYio5/vAFhxtwWgD0/j0GjGAkBJkZr5+4jZ1UWzV6d?=
 =?us-ascii?Q?P58OR5+wCtrKtNRiA0ZbrLIkb299M/7yfb0c6vP52S31mwc0pzmyK5fJmFw1?=
 =?us-ascii?Q?cPxtkxw2wth0kegivtojoK1bBHTySTl3Nr1+WdR+s0LA/oDsl85Q9hpN/T8n?=
 =?us-ascii?Q?rWm/rGiScpzTAaxlkV7pdOTkK/pE1OFvnRWsovkGtJPY9F8xrQ8Rsakg7rtl?=
 =?us-ascii?Q?0Jp6frd5szdi6zwPnUVBPnNLTHhpUiTip1V0MCXFDZLbV2tUrqfWiY8UPUxE?=
 =?us-ascii?Q?VEV82BXNDMsHt+cYnZfeH8KRQaKXYf5TsEVeQV9/OGrWDBaHObBrijf/W2Tc?=
 =?us-ascii?Q?7eVva7XuAYuicfVNZ7nJwzPjH7i2rEBnVLWcCwxT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2da48e-1fd7-4cd4-56ef-08db6905afd8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:22:15.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHcaXOdiqq8gyhoUaNaPOoJ26WjdAETLfHzIcJVRPmBZeoFDX4TjNDWXhYRFHRB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

On Tue, May 30, 2023 at 05:13:29PM -0500, Bob Pearson wrote:
> This patch set does some preparatory cleanups and then implements the
> two simple cases of ib_rereg_user_mr.
> 
> Bob Pearson (6):
>   RDMA/rxe: Rename IB_ACCESS_REMOTE
>   rdma/rxe: Optimize send path in rxe_resp.c
>   RDMA/RXE: Fix access checks in rxe_check_bind_mw
>   RDMA/RXE: Introduce rxe access supported flags
>   RDMA/RXE: Let rkey == lkey for local access
>   RDMA/RXE: Implement rereg_user_mr

Applied to for-next, thanks

Jason
