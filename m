Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709EB4F9CB0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiDHS21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiDHS2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:28:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB91B72F5
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 11:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI+40tVUS6JELay3NrzKCqmQ7mEcbeWAruj3+mnfGwIt4CB+jsd4VUQfedO2Obwt93C1YCdM04WcrrTIpJF1kh565PAUE75G4KCn/JldrMwohYDq0Grxq67QNCGZl+vVarJTP/4rz7bPJhGRiUhv1jSxsIBFHFupLUk4M9AagXGPuO2iBmcq5QrH1vgUT22uWye6+l3Iivgob8V4rck+GPecdUhq1og8jR37u6JBMBeGCVQ0Nsq9EJN63MdJdug1tCd3rQNGXRsRR0EJgkzA7SneSNd1R8f/ApqZCE7IlC1Z+Jta9zjio/pv3ih1HK6Hqzzj7PePnQ2WDQmXBVwJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B5MxUfyAEvF4EAwkawbZjG9O6lcEypdxThY5n4AeEA=;
 b=CXLUJDDtD4H1yOLqWUwHKEq0k1jWUdXTqhaezjFwHV+SX5PTvCiUyXHKtY+cI8gcw84zecfWQQpRgpe3wIGRKuiVXjQNOku7UEgSWi7sJFIgfz5/cx/HTS7qgyTYwq5Ok5ka/jhA0s8ZeOm/a0vZ14uncgz8zmX0qDZopnCSM0eoDOPlDmcePlW2da5iF8P9OUUCIxu4d2OZEC5vlU4VFBmS82PXJwdT8cTJDoobFahsHqcXpBAV25G7pSCgBPfdcbBI6CNB21mo4UevKQmOalkbzkFu8dAaNFNKQ9sfANXulnZ7eiROby8uir71DO2+qWPgNQx2ez9mFy+QLx0JlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B5MxUfyAEvF4EAwkawbZjG9O6lcEypdxThY5n4AeEA=;
 b=OPCIuT7sHNPR7nFYGuMoUaotwI6XA10OI6AbKcD0pwz2wuSf2Q75nqAvZKhMP1+r5SzQJsEE7RxjJe7jYmXi44TbsLLHbI/1qHVrf393BR3j/b5EnCKrH/gETVq12xs27SwfDMfCJhnuxPd2WILusrwqvJN8RgcWAseqfPQ1cK9RoWfKqDDY/qIS9fSFyNbVub4BtTthmOfFTV1n7nMSCD5cWYOOLgTCwNf+9zIbJF59qYJHVswhvO7/5umQaxYs5vG3MoqJVUflKV3EvjYoZ73HnDAghGPn0+Odd0oks1VVIEFBSalJwnOmoSp0JANm9FIPNsD6AeZBxbWCmwBJ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 18:26:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 18:26:18 +0000
Date:   Fri, 8 Apr 2022 15:26:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     rpearsonhpe@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid
 opcode
Message-ID: <20220408182617.GA3648486@nvidia.com>
References: <20220408033029.4789-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408033029.4789-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 949eceb5-f848-4671-3091-08da198d4629
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5636:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5636D8ADCE51A7C42BE163A9C2E99@SJ0PR12MB5636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2y4K5L+klBXqctPI0uLMjL3Yqim753gLtnLogUl+d1b8pVbs0rONDWAucqYhTGmLwdsYvGNB/pAC+lggxqtJ5SV6va6SRKIVRvIS6o+VDIgcV9M5hzzjvaqbdn2LdoJ0sY9aHiXQJkJfL78mnPnVbBzlPzxHaCtk2q+KFrT+jV+NpN0uajPKUgwvy+85DhPevUEcJ/jM5EAHEjuDphMm+M3F+LjYUf/H/D3X38KLdGLVCr09CWtnHAhqWpI0mK3vriR+nHF7dwofOGCaj9JBh56LHkEEvE/qsFOE3zaXw/PtntIuuy+IjttczUJk/rKcow/Eth++Y2qHt3a1mVr98VcKfuBavElWN+XDv0vx4EF5N1qHg6IrnsGJdL5BCya0c72FiF5XIvsurZd0og/C5FaxGPAlK/JX+AjAcnofmY38MhUQqdVYFVBZ0P3N1WKggULxDfxI8lqYW+JD1PEIii8SbQmYGxkhDWQ1tT8dB2ObvVqRFGgatrmuZNKRxQ41VirdPx/uVSwhCMsSvr0qajIaY4vkHIOifuYXVvj9b7riZb20kzIJK0r5sFOHxfsqE5lzLoa9f6jPlv1AjEh7mmxsJzG5ZdGyPUxMExNr+Hcnv4TJxMfhXKfFVCapTnyAWlb0XyOIuwieMEC1RYDEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(2906002)(4744005)(86362001)(8936002)(66556008)(66476007)(66946007)(36756003)(186003)(5660300002)(26005)(6486002)(8676002)(6916009)(6506007)(6512007)(1076003)(33656002)(508600001)(2616005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/q72feeOE4tLTQGvGF7E74iD0JnFojS3lnfcZtBTc1QZyjXT09GnGIZoJcqW?=
 =?us-ascii?Q?ZIr9ozwdMA0mpvUXYtKUxC3IoLgpcGMQ27Yq3iZHakz5vxf9KQb02S+zDF3X?=
 =?us-ascii?Q?vk3oB6AnfpAh8As9yEKtmPXeyNp+bR91g5dB5Jr8gAXz/4kvOR3zmJE9Zm9O?=
 =?us-ascii?Q?TFYumv/Ylzr849Gs4vimcres2qFFLEeBxrMQI+vGK6DLwGTUjwfXxNlQJVN7?=
 =?us-ascii?Q?Q5dQ9xFggz9FAlkMAGVhPKKs4245fpqRwuNnXGZvluWb/TzGlTz7V4Asdj44?=
 =?us-ascii?Q?zRlOdqLuh3cGSXTSHJHCVU6oDvhuS5GFSqKEeR1ordCM2LlHCDCuecgzCuRS?=
 =?us-ascii?Q?lsaAaB/JJEUr/qTIZyaYa9fluxWm7C4Ra65DP/wuXQUrHidjmYszCzmwYU66?=
 =?us-ascii?Q?VjmBr5+CZI2XGZ1nuHPutgW9FmbXL2PhrQnVvDB4055i39BZwdu7fs60G+HR?=
 =?us-ascii?Q?M72806VQJcmaiMr09gpF7zFoNyeyBDQxWD+/MuM3hSHhiui16TRa2OxNj7R4?=
 =?us-ascii?Q?bErDEx/IbB2prJrSMqEMDP0IR+2xMMyFJeAlxACZ/zTU686MjgRGDq/KooJo?=
 =?us-ascii?Q?VLOKCbfcSE+mWeRpzAMzaRQyaahweE4CNzlh9qYOZGfgnaXn8f3dcNh87Kic?=
 =?us-ascii?Q?rFPW6hkorEqV6DJJsO/oS9cchru+gzjA3IN3pk2S/14N1KlVk+VqwKCVdUWR?=
 =?us-ascii?Q?T16ZZgIMrMttHFLzOafiil5MFVmPzL2luU2Uv/2HTvUpAiU8X4gwVxxXwYyU?=
 =?us-ascii?Q?TsRwyncEk3cH6jdyqTpAG+vDxgYEtpHiTRi2etiGuFHS9DnhqKjy/hyEZM1l?=
 =?us-ascii?Q?tSDhCp2wFRwqdeoc68pMv5GerTjoW4sddYHUhpy7qpr4t0vhxc8RvPyPGewb?=
 =?us-ascii?Q?kxNxoJArZbAzlUBWHV2PrzJXSpa+16XT/OGalsx0IkWTEkVMESqIWNxHihuH?=
 =?us-ascii?Q?GN5LI2TJzZpto/Y9V+t0LS7g5jgGPTbcjtOxkzcVj0uk8lPyoSNv3uhtdpQz?=
 =?us-ascii?Q?84w7ljktr4mUIm364cKhtPD2xyeOhtA/sYUdr8hT+7Awj3T5PEjou6dnMN+M?=
 =?us-ascii?Q?WguwgqA8JZSvyKedZ8ecc+stsXQUws8/vA7xB+VQC5i+ADmodwrHjydkV7KM?=
 =?us-ascii?Q?Z4/xGTGpbnReduwaCm8o6EeR3U2zn281q0f07bF4o0R7BdYYwtenKF+3BYVy?=
 =?us-ascii?Q?M/MEXCaRuKAvD0wzKBMmzrtmHEHLRn2aZyqb91cSy+fL4g6oCX7aBK0tTikg?=
 =?us-ascii?Q?ainaoExKwomF9B2G9JILzuEbjDUyw+fjsJIyytlkJ5CvvSfVlqg8d7BlhZ5J?=
 =?us-ascii?Q?C/cF0ye/Y09thB0Z+aBZ1mvVt3SL87YBB9EF7WPnLhtuw85V7u/ZW9JN4MBM?=
 =?us-ascii?Q?zYwaC97MRg+3WwiSlHG1CZe42C3EgPQiiWkx1GeqRMnkRq1tYTr3XuAxx23M?=
 =?us-ascii?Q?usGqOorlH6P0GqBiD0YvsqdnbpYyTuAo5arrvp0vi712vzpmjLiIV/b+GNRA?=
 =?us-ascii?Q?BbnRPjEclfJCxhyfZA9V2O2lRhwzRQIYEvYw2hexco8288qlrTZzAeM/GtoZ?=
 =?us-ascii?Q?wHoGwBnfSjCj510qxumhsQex2kn3IpMapfKiWAsS9LaDfufPsB/A1Dcfq8K/?=
 =?us-ascii?Q?tvWZ7P4v5rnW6zVrMehk8wOrXBrDj0xw4tIyv20bSxzEb8CfA36eeaUpBm9z?=
 =?us-ascii?Q?cq2nX9OgfH3aKvq4lOxY9ohwrLRWmEO+mFxRqcy9w3wjSO1mOAAk+rZhYx/f?=
 =?us-ascii?Q?Pxmol3deWw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949eceb5-f848-4671-3091-08da198d4629
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 18:26:18.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEcKiTIDTKpWRjx/cPd/IZiVBtV/E4smLjnRh5qVtaH3/P12M3fZQoKP9h4i3sfz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

On Fri, Apr 08, 2022 at 11:30:29AM +0800, Xiao Yang wrote:
> Current rxe_requester() doesn't generate a completion when processing an
> unsupported/invalid opcode. If rxe driver doesn't support a new opcode
> (e.g. RDMA Atomic Write) and RDMA library supports it, an application
> using the new opcode can reproduce this issue. Fix the issue by calling
> "goto err;".
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes line?

Jason
