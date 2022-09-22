Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708B5E6BAE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIVTXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIVTXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 15:23:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A894BD02;
        Thu, 22 Sep 2022 12:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvxPBE2dPUpyZXMVAk6bGndGViJgfJHs5phZse+vsSB0ZTn/tGlNQoGF6KLY8UhQYwa76Ss4qyJWmrGSt8yzm2XMFgUAfx+q7vcs3IsSEo1pOCt9vRkLHPoe4KuvvdQ8OB0ATZxuAUvj3EukR2K/RIDtIQl2Vnob8/IhMGu/cVOMNeYaYS86cekL4VWk5nklqSNbi5mnscMwjAk1XrkuF9gw+3biw9/hKFFCsUPik1fSjzendowmIASaI2TLHB6x2bHfRmZBN2tskL1Z8YTKFg5YdkRV6LQFcZKtwIpden7B2RfpGNe3F5PWI3U4LXp7R8JydNWzOvDXTj0S0lqDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl90UaH2BKdJpU5MV6KOoqPze/4l3Hb87d9No1/REL8=;
 b=O8yZIN00N5eN1s0jtLv5FPZ1n8D4Q/CZHpjv4fAiuzWKicWpVl4rJL1ODGN+pr35gGDsNiebPHwrAe1DaPXVDFdDe5N2eazYckzNG2o6fFJi5iuzc49ouq9YV0y+sWCH3+rrOvCKMkALAoEnf9TLgJx/W4VHiMNI8pZWz5jBeCByz8gGj3nwLsNmMm9/eXIuJ/TXz+syXMRsxuXttnpn5h/g8akDrPb38Rmn9JnwHg5+YKxCfP74oPE2z1U5/ctUssXsj3sDOhfsHxkAPZzMUaj+9XmYmquI1bb9sTAjokdSSAl+gnmP4+eMNSUR52NDSwIbqSZi8V7SOY8s/LgVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl90UaH2BKdJpU5MV6KOoqPze/4l3Hb87d9No1/REL8=;
 b=QNp1Ntenw40F9j6SEXuMK7PY/7pNGjU9clQU1sNtEkHgCDIJhzD4OLVfc2CrpK3BLN9GyxSB6/sgRfm1yumAynQepNpo5E81xDYZv9d3OxyOrJBVVqtMLqxIA/wklPZDMNfu0m4UJ2CBFu6Czmca0I3YHxc+biAllTDBTP+KvSeM80t0+A1A7J/ruK2VbaE5HhzeG0+MoZy1oTQWq/XqOONqhnyjZqFzr0yvyUfz8ohnz5I4Syq/1cQC7dDBcGaQAj6K7DaxQyP5fN7G1MjEZYl8m3WmzYddlqJ9DbV7PmI1D1VB/FfB4omgUVrgYK4Rmbp/1JIwjrGSWwI2aJIDMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.18; Thu, 22 Sep 2022 19:23:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 19:23:28 +0000
Date:   Thu, 22 Sep 2022 16:23:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     jianghaoran <jianghaoran@kylinos.cn>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Re: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT
 mips kernel when enable CONFIG_RDMA_SIW
Message-ID: <Yyy2L24vHouLEipe@nvidia.com>
References: <SA0PR15MB39191553A6C95FB96FAB7146994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR15MB39191553A6C95FB96FAB7146994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fe41c3-6982-4a0e-0c40-08da9ccfedb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYIjvt86l3eh2V6ZgPIIisVA3UpFtu/Pw3SUF1tRB+q9fZ1dTR3Zk22YiPYWtGIzsR3eMpMEW9hYAFD94tto88ZHKPNcPN4qCp7l8Fyn5AcJ7sHRG+jP9MvIGgP5doJGF01buymK0YjTG60ItT5kd7MIXvM7uqAlFGpvvntzrSdyp8U1rvgNyV9PBKEtj3id12p3dk3bLr1XhlGR0+6wpX9QSQxv46BKNOFLBHBSbMtJQuJC0f7HtGQuU3Eq4LcU1Kceo8IuePhR1GuexRw4eIRPzHEqK6eZ8tB8BAotIf5VPtibRfCiZfU462YozdURMT4Ftc/AbZsHYJhBSnGDrEHAGCGmv78IiTmmZaUsujhCK67SBgZMXXJN+HjJfCvFpuq95bdyTbj5fwFRIabM/baJOPfANvorB9miKmIID3BjWRh58TZEu+nNTzOPnmNttOspO1QTWm/WH6WSW4lo9kNqpsonItfZLxwU1HfIE2ZOfeVM4BpShlyHB2dUCpnKNUfstXrg4LueJrwfKlCLNcUoNOC0L5uNQ821s1WeqiXG7MwpCk7AGW0gSvgIqcNxKZpB10IdaqK3p/BuaXFMC8mwSrMlb9/OHho6dlP4Fh9xw0uZdGXQ/nSVGiyESs5QzIxGpB2lUmfHaQJ6u2cNKO20QaKn29bR9uHAStBqCpI91j0BPwf56eirIfJmLGyBKrwwsbvGWFzZba/smE53rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(8936002)(6506007)(5660300002)(86362001)(8676002)(4326008)(6916009)(54906003)(36756003)(66556008)(66476007)(66946007)(41300700001)(316002)(478600001)(2616005)(2906002)(4744005)(186003)(6486002)(38100700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zpEiYA0GWeJEv2FuNzkdQsIjcMDyyfubX/hw6XL2SbPWdy7Gb9PLHkhTrUjg?=
 =?us-ascii?Q?HABPwFKfmF1+le3os/oN7zWhkT8n6UeyT13mAaS00xaZtVOb4DJuSCQUx9zi?=
 =?us-ascii?Q?xgl4eYIkq6McbzD1HTyyGYqGh7NqCmH413OOeoGzBT2BboRYpY7L1+HZBEo5?=
 =?us-ascii?Q?8VArAYm8MCGxkcjLmJmnLSal1kR1/b5tuYgQeIIs3+2dxuahzKhCnu9OqhfC?=
 =?us-ascii?Q?ZZoJfmeoVOixnKFsghFPLJg1F+k4DKpWhNpm6dov7nGTx8fvlFEjUkm8thT4?=
 =?us-ascii?Q?wu0Q99W9dl2Rm2MhkiybZV9NzIRj3cLEpJQuvd8ZDsK/63ccxVlP7846vNrV?=
 =?us-ascii?Q?dvk433z4EMpCl3qYL4FjM+bt5u33l7wRX5+cVzJPNWWlVR8nUYokxWMXA+J5?=
 =?us-ascii?Q?2b0yNjmL6k2Un8+TsIaSsblYXmDRgk7d4khujp+bZ9km8uOiBn1jBDGNWkvF?=
 =?us-ascii?Q?j4pehNXScFxo5Q8aPjfw/35dl4JtLrejZHkxj1yQ8FuaomyH3oHnncET5dT1?=
 =?us-ascii?Q?KnIBLQbmH6x/mP8Noc+ujIMueMgrC41FAeZE8Y0cjxnMRRuzfwBp7rSDbfhr?=
 =?us-ascii?Q?AHfpCmoidCVzELuEgPG+pCQN710ZUBtjiYzCvUvw7+1iLoOi3Tr/opgN1CcI?=
 =?us-ascii?Q?jrO8vPC9sCONE3Q0qNdf5Y2yG9TKmxlMJprE8x8T0kJnBOBq7ORNICPNvJmn?=
 =?us-ascii?Q?Vx1BN3bXAEzfX/EDonJ5Ihzr7n64SmbprEfT7XPfLuMVFoAYZCcfGcBShQFi?=
 =?us-ascii?Q?OWsJxXleIg0Wyf6GtBZeRvCdl05GZHajyFP1y0zYVd2ZSfGcyeiB8WGxmjkT?=
 =?us-ascii?Q?Oa6XinNoPlqTU4dVYW48psD5yUpLs/uhOedH4Nwa+B2sPcobKi2cJLCDIc/L?=
 =?us-ascii?Q?FJTkA3MnaK0b8bfF92MYA8OLpo+7LedFf3v7kLEFJAq3Uk5PW4W0YmoipoS9?=
 =?us-ascii?Q?qme3/fT33L+dl0OPbvAgc+SnDjoHWxZSrOWeNaGWMnGrmucjbuG9Xohvhhqc?=
 =?us-ascii?Q?yUpcXuh2335us7KxNVAnWbAE6LmFyvt9HRcFUuyHdcfVWh0P1FGmuCDhxLdt?=
 =?us-ascii?Q?RngOtgKNVXK8aswOVuJyhec9swJ938pKnqUAZjggkrIv9fw9WfPS8wAorKAR?=
 =?us-ascii?Q?WiDdC7MtEvCXkOmD0AB5xTdAJ9x3uRlTiBQRD1WSBBPC4Mzt5PdIy1ZecF0U?=
 =?us-ascii?Q?T12R37zcjpiEPxDhHAsorxaN8I9fVSjLJLeMRFIlMLgN7ye+DXtlksdmKZDr?=
 =?us-ascii?Q?ak1Oy6ZuvNvgfZzBiHL+VzsxuayBG62YaMU5U74wgdbJ9IYAimq1Hj1z9ldr?=
 =?us-ascii?Q?HG3SGMJ3u60joFctraAV70UJhXzLCti8Fq+okeO05oXBBWwk/CBSu6sN5koL?=
 =?us-ascii?Q?Bb2v4QvhVoUfVluM2gYbzw3CnpkhVAYjrqqL7+fPg+bXbMFYXhbO+SBIU7TD?=
 =?us-ascii?Q?LZRUICQBe3wFmM9z0+MumqNzH6O7hxzfrwPTJPsoo+EnjB9KpL3ZBILUX/bu?=
 =?us-ascii?Q?zAu3SFRRfNC/lAuynTsxCQ1fu8dvUYAmGZMXT4uWxVPWeO1WopmeflLAfV/z?=
 =?us-ascii?Q?Nq4H5WT1ew5yc6Y4jroZzMPvU7Gxni2JRvWLP1bX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe41c3-6982-4a0e-0c40-08da9ccfedb4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 19:23:28.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPeQ3QnmbxZ1glB25syrpH8Mi6znWW7esi9TKgdH7e9UgLaWp5BKO1PC5CUQ+tjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 22, 2022 at 07:02:54PM +0000, Bernard Metzler wrote:

> Looks good. It's the right patch from Linus W. which got
> merged, as your lore link points at. You seem to have looked
> at Jianghaoran's patch for the same issue, which came
> in almost same time, but was not taken.

Er, so this is just a dup in patchworks, OK, punted

Thanks,
Jason
