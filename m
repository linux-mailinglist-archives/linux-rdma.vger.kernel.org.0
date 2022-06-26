Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780D55AE90
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 06:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiFZDte (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jun 2022 23:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiFZDte (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jun 2022 23:49:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2077.outbound.protection.outlook.com [40.92.99.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC1713D7D
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jun 2022 20:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzRrtKJA4OJZEPy06WQIekC7582ot1a/73czHlBVsi0yRFjwYs+zkx8fWZr0eUPzXWBeQczPVPNqXiFzM6H/B3243m5Ir1PMyPQ+v+fq7GZreBPQLDokYdHur9GHaGJOEZHZxCqs1FM1aRaQwYE7ep+yg0BUyRoLMMJPTix4F2zlS65MkgqOA09/XVwyoK7Tqh7H3f3Gp3pbrqylihbX2NR06HL9BrRt+K/McnDrVF6h8V185gedz9JiEFEhajvHvNnJlfEugrekwZvFRil0vxqc4vpkVkI4bPX5StHalhDJp2NbWmrC1iUMgKGW+3DDa2ymJ6Fe4NLFFfnTtJjfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MycQf78sbXjifrHSfX8+1m9UqQew+IJkSvhTvKv37A=;
 b=i8w+yS9cZNWSKdb4HZwQPiTfIkNjPUAy/GjJeA6e9xaWDzlB6DBhkdPlHjbVlQy8wZOFlpiOzdQUHQZg7kq8BELskHO+0MIgZg2MPtb5yeh18gNrikHl65RFjINmWAzps2yDETAn5UKp4Jl6z+Gh030auMZiI5czAKTzPnt49nP2tZg/sgINHLg6GTbK+QYTyOJh0bJtQSx7xKyaPkec8YNym35PJEHzd3A5I5Dpr31h7NzrDAtP9Cd8GzljJt/dlWIdw5NZf4C9LYdz2yCUPL5k0HUS2KNN2T4n3add3dbGoTypIGZOBP365qG07KM3ZR9cYAo8o9RUldhuaVjW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MycQf78sbXjifrHSfX8+1m9UqQew+IJkSvhTvKv37A=;
 b=N7UegcXpAQzmilFm8DK2N+ki+VgXcXMvXX4ngL8zRAykMNwZSurXnl02Ox5QtKaoq0GdyUy/ZLmII6kigPa3BL+jRFBIjX7H7YQCzITQPWCtiJFTb4QvESzbZ3Fwsn/GLbExHyrm7b1AQ5ohDsW+2v4FAe3i8SvXcM5jXxnhFEj5bmOxA04ENBUrRRmVa81FHI6AaguJORFQdYq2N0M+kbpwMH1Mqx7LlIRMtobYnQdA9OsAA2JpqEx3p3G1mldFfVJUsrgSOzNsIMGiZa0hFmWmG75/qHtVIeFO9WM8pxH1+U3GzyUmIvWpOg65bOMzZid4AhvMH2O8ia33wzDDIA==
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b5::13)
 by TYBP286MB0256.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:802c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Sun, 26 Jun
 2022 03:49:31 +0000
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e953:584f:b349:5552]) by OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e953:584f:b349:5552%7]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 03:49:31 +0000
Date:   Sun, 26 Jun 2022 11:49:21 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     linux-rdma@vger.kernel.org
Subject: pyverbs: rdma_connect/accept with private data
Message-ID: <OSZP286MB16299D300C8880F6E27AB2A5FEB69@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [to1bUcC3/STtPhsecf668+4/5UZXS+8y]
X-ClientProxiedBy: PAZP264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::10) To OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b5::13)
X-Microsoft-Original-Message-ID: <YrfXQXRxk6GFo4FB@gen-l-vrt-307.mtl.labs.mlnx>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d109a9-c974-434a-17e1-08da5726dff2
X-MS-TrafficTypeDiagnostic: TYBP286MB0256:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM5lPZNQ9atBz7dZcVIgUBhKrBKTfcCiVtOwfLJrEZRgf6h+CTFdVerHbw9NqSQc5xwPPXNSrEHlR5BYa76xWHFBLfCtrA0JrTcN0Nry4DgMAyjuhY7k2TYEasJjBD4tcOiyr3tl6Eg2fQNWPwbpMbJp8nd5x+eJxZG1ufXJm9B72987cHOJsTdbuotDa75P5zKFPRDhm44NCLuiGq+809t3P6Pc30PgvOb9coUTxJR2VA2LQo0swmRHKOJmpUmnIqj7i1Z7Ubth25SVG7h9EJ5hZ2H2MQW2qYhg0n66Oq34YbmgFmqBP5W60zpjqpBdDmgZq0oQQ6vLKZhHkYQf+6OtzdihE5l7x2Fqs784r/fj5VYNrX9eBw772doggpYmahGSOvYF0ltVQBolneTN1ZO36quqjgCwwX0pjTvK5eVfRCKsAphvzphdagsnWCGlscN8tokwTraSKCyq3CmUjU4rmPF2cKk/hEvMfCoyAj2/j0lOBu5nr0EiqBSL1EH/GEYVhwsDq2yiUIAEI4M06n13rs8EEHBFQc+FJ/DSXNihyh77IYM327NOm6CddKUD/3P4c6jfOEZy7uzIkjfGt0fklMiZMUNfxaqVLdQ/JF0Dj6kg8QqH6/ZMuESSoCeL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJjOdLCJF+/uCsAvUNUFC/SCD9Fi+9PWCBDNUzuqAS0L29VrTq5CISQw2+Hi?=
 =?us-ascii?Q?ZztWcn2vhIVfpPLf+WuxHZ9wOPMQOO54cdiozx+GzDnG/ZWmjyFBvGjkhVQc?=
 =?us-ascii?Q?lT6tIAaXwo81JzcSVr4rcvDIhSTyQokucTpNcr8wbvPKs8LscfWs60IcAiW2?=
 =?us-ascii?Q?x8GKtwscenCAujLqea2BvdK8I9Ggcka4DPhPniiDfIPL7RmrApd7Vm/qX1Tx?=
 =?us-ascii?Q?U8gISvFviWukVNgB+ZfUhuMWz5zUFiwcGsUGikdj8IQosdpieEtR3kQJurnB?=
 =?us-ascii?Q?23jQQZpQYrXaU8RH23t7ViXQMLZOTe3bbM0PmhxvxoLNv9WpdjeCu0lwnb8x?=
 =?us-ascii?Q?+Onsu2DnWThiaxhzcUm7r5bIDp8N4JjuWVAnGdToGkkWAoR0hX8w3gE5plbp?=
 =?us-ascii?Q?U2KqQSs72virUpux/3P+64CtI3Cv6RGDEIBUiGE1BN45a3aUsdwWeURSJqwO?=
 =?us-ascii?Q?vsQ15JpSZCMvBUrdSqbx/JjHun6vWAy+u53tGpguUsFUWTewtvxKtwUooZuj?=
 =?us-ascii?Q?iW9XRYAw6ttnfnF6DxCmTf6MB9P/RWSVAUHG2IdzXQjLey3WZZITxP3Jq0gU?=
 =?us-ascii?Q?JGQ8jYK6PFw5nJP4iobKmXuxqb8RUEDOYzz7I+zRSBzXxKr8tLw/jyXaKhTc?=
 =?us-ascii?Q?hYFDJfEr7/JQoxUFEUPNrZ3t0BMmGNyf+oYXE3GVomYxyxuFUApkhBhZVVPI?=
 =?us-ascii?Q?fGd/3fFVqgcsNSzmPHj39UqekRCkMLnftYM70FzfGyadX1ELstRwQqmkj0XA?=
 =?us-ascii?Q?sgrOzZUP9dLkapQuJ1yQOGKXHNDYPaGsdykYJx+awCKPPUpSMz/2L38PHX0o?=
 =?us-ascii?Q?cqHlIj9j4CR3otyAmaP/h5/jdKRPGDhUoHuJzTl8JuwmynTccaVdM0+86q50?=
 =?us-ascii?Q?yR6vMnQHsqy5Nbu63OL22/OdbOkoxvy8mHnEJNR7H405xQXmm1bInI7D9e3t?=
 =?us-ascii?Q?yaZ8mVaTz4a3fU8FzMz1DtLd7DnrhVhrVwu9hg208jGEfKPN5Rp1jSb6oigM?=
 =?us-ascii?Q?tMponvVhcGXFw+dFoT3J2idsqS5G+kMNlySwbUa7X/Qr/R3OET4UAX54lV/1?=
 =?us-ascii?Q?QdPsAcVfgdbIKTSibYp2ez39kE6njXtMMWZ+rntOMdJqS2KlvykIeVmmafF3?=
 =?us-ascii?Q?3weVnsbnkT2DUuy2nMkRLYMkGW0hK8b9VYSdOfG5qXZvcgSmxE43iN5IjR2s?=
 =?us-ascii?Q?Jp8w1sgjYsvVl6HGKXvb0ywSsqxnUHhJjUaRwMFvGdpOlk8+eXW1UWhg5Z2J?=
 =?us-ascii?Q?UuKrRDC9aYbpRjRGRBwoblxUmxn7TR8Vv7dGazOuA+sf+9AyXoyR2hR5nw8Z?=
 =?us-ascii?Q?4oc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d109a9-c974-434a-17e1-08da5726dff2
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 03:49:31.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
    Does anyone know how to use rdma_connect/accept with setting private data in pyverbs?
    I'm wondering how to set the private_data member in the ConnParam::conn_param.

    For example, how to set only one uint32_t varible in the private_data?

B.R.
Changcheng
