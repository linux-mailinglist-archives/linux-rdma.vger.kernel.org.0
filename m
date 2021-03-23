Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22668346959
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 20:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCWTyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 15:54:00 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:6017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231573AbhCWTxk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 15:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtHTbSld8wjG89FGrMJh+CPkwurw5xezQ33JtzadFcsYFbHlkg6AVdbzyiYgbnE+LXM1ay8mvaH+I6jVQH+ThuWlJjv/BXYsV41JHectWUd0keJfF1ieKW/E8FR1uF0tUqVRlX1Gc3gLJT2gPiHuYdTYtBCceG2snLoP8zI/OYyAZopyDObRJbxLBq5vJmC+0VzlLr7vsMYtR41TR/3h75gS3h86vtlDgJYO4fWDCIVMFGNjOub0Y14P0Gjt09DKm8/FlVP/aBlK7vK6vy8ksLF2HYE986bGMrrAGig+Xx5ZI08u01SXVJ7L+FWGqbTy/d1K7XWQOQcBA2GDVhPFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypNshMJxd6Tn0eM9vxqlmISA/nI1ITxdSUdRKoZwPN8=;
 b=firTI8C6HCbD+f80xWj2aogEkv9u6FPO0tPCl7Kkgga4qyOAUTjOMbAyvctjRdrVmCLxfMhbzpPnwsiFZf/ygGi7CJtgk/yHaGKkTl13YSrhHG72kjh2PE/UDxHOHK5oPunKWFs/CS7o23401ajY3d1uJ3ObaiOdQKE4HAtgmMhgg1VjM03qQJsNcjz38UUhFrDKsJmf/+9pmxM0WOdapywpwWtWaSVh/1tkXtll2VNAaPkEjfhICjrdnmh1wziMxwmMAxyrM6enIKX193RKlUT7dqyq7seRVyBd6M5+T2iFSkh9wN/wDBUUSItrJPzKaY+NUul5oq9XfW29tLvr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypNshMJxd6Tn0eM9vxqlmISA/nI1ITxdSUdRKoZwPN8=;
 b=oGg4d1HfXhehnJuNjRwHxF37Epvf/iU2UMkZnp2HPJhsyyzRZw/7/XLUrmFCx8Kpw9WvCmmhxCHC2ijHXp6Fk6rrS3ZRf+9J6mVzkGjfs7hfY4kVBgE2HpN8w5KfyW8UaoCorIXOVTnXqtY1pOUQwH3jPIlN0gCDPw+p8uA65c4/d33LQQPrJj+aoddzdDhujV5zzs7ecBUqvWI/Nbhzvn1Wtk7gS3aQZEOEb5F6MFYRPG5gsaX+l2Fa/0q9a7LC/an4GwalP8wYaHeUxzaqj19YNN37Ie2gWhwFzs1VDdGfrMVPW7V1TxnrE7HwtvGeSiTCk8J+Xt3bLqGAnVeYJg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 19:53:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:53:36 +0000
Date:   Tue, 23 Mar 2021 16:53:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: [PATCHv2 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable set in cmdline
Message-ID: <20210323195334.GA398506@nvidia.com>
References: <20210307004256.7082-1-yanjun.zhu@intel.com>
 <CAD=hENeugBS6mGMwqMV+zXrOMSZFk_num3wAYRyD6YJhkfXDcw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeugBS6mGMwqMV+zXrOMSZFk_num3wAYRyD6YJhkfXDcw@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: MN2PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:208:134::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 19:53:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOn5q-001fhO-7X; Tue, 23 Mar 2021 16:53:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f777de7f-6c1f-4e7b-8251-08d8ee355870
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3740BCDBBFCB22A2B9011659C2649@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unobwBhnLb3IAD6PUOek3CZcfQ42ZxH21lkOSzWiOCN6b25FYlaHC1lSPJfc2FUkwubAEF9kttw97RpsCfyvDeObxJDL3NpaYmCho6VVhDYeSX96IeyvUKy94BnUF+zqIqL4NwDxAAHzUEzUIeQNOAASdbvsYkLaMjTyHY8Lh6rB6TCgwgZo0pGhglciBu8Dopg3SOiVvxd5sWf/nA4Av0SPQbaMaXO6hcjXYFpUZoBOelyfzy8Cw6N3vbsGzAcoDFd43d3aH50ilohVXmeV86H2CUnB5e1r8SdiF6Rx0hGWqCCHeMCMcRsUH9MTp1Xy9Awu75YV72wHRQJPTehxvEJhNBA3Vai44/CDY9QYnL+KLEae+fdP6zfQJC8Tx1Meg8dlDjbmdsTB9pXHei70qrYVa2yVxqhc1F8bbmvaq8VVXJTKcCNIx2izZ8sUpNfKNKsMVhmlS5Me5gmJSG37Ao4hyGJkF/EA7hZHcqBdu+hb8gpuadyH68TbjO3nnJPXnKwU2+sKopbRjmtIAEGqhQqB/rd9KRyAmjypnSZQYdT/m9uHD6t+BYVfzPB924EYOL7L4uRvXQSiDKLpgcfuPwCAbS3ZylGJO/3FkONXQDJHAQ1SHu/7MhvUCYt1aECplxJCiGtgrehjFWlsfXKnpBMZjLTWRnT9yGha2r5cGh3BpuzmnCT1afvQT2oxXUVI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(1076003)(38100700001)(36756003)(54906003)(6916009)(83380400001)(478600001)(33656002)(66946007)(86362001)(426003)(186003)(26005)(2906002)(4326008)(2616005)(316002)(8936002)(8676002)(66556008)(9786002)(5660300002)(9746002)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LU2mhYJDSkaMvENrJ1WLOi38VfvBMK4aDBu7PyjCqbU7TNMElfT2jJ6wMkI4?=
 =?us-ascii?Q?nDQp3X4Y1RWInbun8zOW/1B44fHlljaRbv0OFqGiJWuJrIKAZcrXuD62sZ0Q?=
 =?us-ascii?Q?al2gSYGwdIeooiazhGa0kg7UdWdxTpqvdolenV58ETKnZ7yHn6yNAlii9g9S?=
 =?us-ascii?Q?+pmU63WkZyWypXwl/45xohrEuHMlhfxveAhavqeykIKK1Qs0TFxMuB//wPoy?=
 =?us-ascii?Q?JzmyXV/qO1ZtggLjttPvNeOQmuPxLRqkWg3N7l1T51v5KCmHIsBL8bpgfToC?=
 =?us-ascii?Q?K9gcDnZIYbip+Zhs0KXZ3IvgUkJfBAQ8tQYIYn6+wkvUHmt1RuUGFY7oWyTG?=
 =?us-ascii?Q?Fsep1WwNB4FJMWxlT6TROmqTZMDPB8F7OK/YpKDoz533uv15jWP5QPfFbwcP?=
 =?us-ascii?Q?vWN6TTM2EOPzbQ4sKsSllKY83sIbBKURWwueW/BsQ7zlHnlC7QSMc1PcVeIy?=
 =?us-ascii?Q?VMPT6ETrzIOuo0en/q5MEAifGFKCkiBq2Xz6wxwjzAShwfP3BlEDcMGpWa8Z?=
 =?us-ascii?Q?mWjn7UUrKWg0L0Mb2CUfsFFea9SO8bX/V7m1eG7jdPJwLmVgyRaYL5a+0Qlw?=
 =?us-ascii?Q?091gJ1JOxLX4LRxBpjsqTxZtqnfByCPqtrvje65GQrKWxcKUD9ddnpvg9koQ?=
 =?us-ascii?Q?Agap/cIQInSnbxI08R4lx7/AylVDx104NFV+uHbudcLvT796nonJlbVUOa8p?=
 =?us-ascii?Q?Cv6ZqDWMYtI/RAD3B0E6BI1VOlNQWouKJQyDc7Fc7UaaYnVjji4qsfkdO4UI?=
 =?us-ascii?Q?6/7MpsqIFdUFv3fuOTBdfMYmwJtJ9WPi0uXcivRF1m5T4m183G66rtEQ9lga?=
 =?us-ascii?Q?I8lLzR6JiQhy7tgatEGdvYWsPF6GPfwlUFHrVwqlVeOCfPk/CF5tFAaaYQDz?=
 =?us-ascii?Q?KjJkLww37WWdwxjNZpcx5XET1iEGMtAoizYDRJcUaMxUCrkAL9f97PTbmC8W?=
 =?us-ascii?Q?VXYveut5yCv6D3SvzRHNZsO7kGG43J0v/FmVodl0H/7Abz6dMdgLyXKLDFvh?=
 =?us-ascii?Q?lTXvcaxfXL5NGg6FhPW4MokfohhTDa2KTHc1rttpXekTy9YT0zJsJ1zA+6Uj?=
 =?us-ascii?Q?7V9qrpYxrh7OIrc2hUWI9dcO0PwsbANy+h/iNt/awwyym3MjCPFGDKIn3U2Q?=
 =?us-ascii?Q?yjUxqlvGJKXijp4A9mg8Vex/WJc9Kf0sOUPCsdsJrF6VF2we0nkkTukPX+1p?=
 =?us-ascii?Q?YzKb1Z59WELEfu7N9a1vhH2zGE4CMa/jD4hRc0NDiA7iDktEBVw2pYdLFV2V?=
 =?us-ascii?Q?AlDWeuves4pP47M9UprEiAuL+DuL+kPw422c53VvUSzdCx8X5v72otTZsM9R?=
 =?us-ascii?Q?1Sw8sZ06DIRRwfhm0asYRyO0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f777de7f-6c1f-4e7b-8251-08d8ee355870
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 19:53:35.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDPq9a/CNx9veaemm9BFiwNplsNoFJ52EmUg8eSFFoDrh4j1jv8LetFNXMofnf/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 07, 2021 at 12:59:07AM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
> 
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> V1->V2: Modify the pr_info messages
>  drivers/infiniband/sw/rxe/rxe_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0701bd1ffd1a..6ef092cb575e 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -72,6 +72,11 @@ static struct dst_entry *rxe_find_route6(struct
> net_device *ndev,
>         struct dst_entry *ndst;
>         struct flowi6 fl6 = { { 0 } };
> 
> +       if (!ipv6_mod_enabled()) {
> +               pr_info("IPv6 is disabled");
> +               return NULL;
> +       }

Why doesn't a similar touch of ipv6_stub in
drivers/infiniband/core/addr.c need a similar protection?

Also do not print.

Jason
