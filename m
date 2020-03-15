Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DF185B48
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 09:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCOIsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Mar 2020 04:48:42 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:45895
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727756AbgCOIsm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Mar 2020 04:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T572xbQqGCN6AlZIU24UKxs5Lewx3D6+sELJxMJ10NXDgYTfh97tsFU4E9yALiripDAOx3Dr8DXF2Ni3ECSqWO0mfpB9euE4yfJ0/zRwni416VXoP33PgEjJ9uxPLw9Z402sT49Ha54/0FLh8m8KdNED6Oe3YI3mgo0jbjYumWpc2dioQUntRA7UYvzTFMSHWc2IDO1GFqRcsurZZQ7+2mGmDQqoVda1hCbBbI1Xyfv/pxL0P2Z/j1J1prZN/dFhONRQjReo9cmAUOO4rnMcaJaXHZSmPtiE4TL/jm1nTxy/ugfBdm7bsHbF/bdCMy6KyXCepaJWj5mevSCjFEuPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv4FisMs5NrSuwUWB9J1+73UaQwY1EnwQkeyjGbd34Q=;
 b=U7sSjSFqrpSgLQqmDog8wt3m/2DZUpXQuLOgGgxy9dr4jFovCy7Br4el+cKTZ7Kd6qZVMOVNUrTjDZ0/QIIozGf4unCRPsvuxG6VajxMu+OszYWONkZrtpZTbATTXf930fPaOTJPHQwa3XJLHGNubaZ1sKEfb7zf/wpT8wipVp7wT+GBFFMC+LkhavFpl9RDWbDxhxkvDqtfO6ACXsTQd6t5foMR7mjK4359voTqfnY3IlJBVrc8Z8CzCvY4Bp7R/u8ewpjM79GGppj6ImVQGbZMUc+sOamtxjyYx6E7eeLajR9qkmiCx8lEi7lATnvJvCAzhoYhKzWOVkwYFjjuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv4FisMs5NrSuwUWB9J1+73UaQwY1EnwQkeyjGbd34Q=;
 b=YD9ECGoYFbWM1ILA7LpOJgAzqTCK3+Iayq1zkT82r4HOsyIyhpUtxyQThmocrLE7po/DoWltGuJ42eR1gqRrJiWqWF2a7yL+4XkE6b9xKdS8VO5UIug8GkpymvwJU3iv+5d0akdJ9MQyyZ93P04Ps6A0UdasfpzLn4/o95Ndge8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6136.eurprd05.prod.outlook.com (20.179.2.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Sun, 15 Mar 2020 08:48:35 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2793.023; Sun, 15 Mar 2020
 08:48:35 +0000
Date:   Sun, 15 Mar 2020 10:48:33 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     rdmadev <rdma-dev-team@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Rupesh Girase <rgirase@redhat.com>
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt
 to fail connections served by target LIO
Message-ID: <20200315084833.GA8510@unreal>
References: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (193.47.165.251) by FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Sun, 15 Mar 2020 08:48:35 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 792befa7-520c-4ac0-6197-08d7c8bda5dc
X-MS-TrafficTypeDiagnostic: AM6PR05MB6136:|AM6PR05MB6136:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB613630F1201658B45FBCD338B0F80@AM6PR05MB6136.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0343AC1D30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(2906002)(956004)(86362001)(52116002)(6496006)(1076003)(6486002)(81156014)(33656002)(8936002)(33716001)(8676002)(66946007)(66476007)(54906003)(186003)(26005)(16526019)(66556008)(9686003)(478600001)(6916009)(316002)(81166006)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6136;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PDN7BO2vsifLswBrHzavZcCh0a9bSc7Ah27J17K05xljHXj9oQnmANMxOEbdYgzCoZOHGkQdiNdIdhFU12jKs6cu2+AXSxhRO87yaWA2zVxkP4cOgqsaIMPcdl7LPBImW2urJwIWgYDbHysKZsUBODFE+96i/RD6mtymngwd32LD6cgArTKYl8yvxx53ebO4FeQPTr4BTxtHHbSAOFJdOFslaiTBxgpxrbWSywi1pKL+Nht2E3NsU6EyGrhpS5dYtlTbBLn18IYnZXVhdQuQAqu4U9d8vCxEYNyeIgKJRFGa2l3BTEejdFjg+VPpGaNcVUe3wQZOEaLwlIGUkaB7cXlj1CtIA7QdPGFElc63MxPx8j2ox7hOWijUG4pBVKDDwnXFIcMFZlDR28Oq51GUqpSWInuFuzzQ6G9/NYFxx6qRttsiXNCVk8/EcC6QByd
X-MS-Exchange-AntiSpam-MessageData: 4ipzA3jfh9hUAkdKk5gI3uG9Dgyl58OybRb9y8ZU/uRlcW2337B35yLAUCDNlv2XQdzUpaOvXo+40xCnp0BYuid8PpaPocRBimOlk1Q61azxTbEKXjkM0yuHEfuLZ4q6aAZq8J7e7Wm9VPO5t/8+GQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792befa7-520c-4ac0-6197-08d7c8bda5dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 08:48:35.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR0VbYiDsyGSCiIM9Wh5Dd2xHUwcgJbv/gN48SlMv1E6AWss/q2SQx4d+xSLzkmTDAYXpXLswMufPzUpfv3HPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6136
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 14, 2020 at 05:30:00PM -0400, Laurence Oberman wrote:
> Hello Bart, Leon and Max
>
> Max had reached out to me to test a new set of patches for SRQ.
> I had not tested upstream ib_srpt on an LIO target for quite a while,
> only ib_srp client tests had been run of late.
> During a baseline test before applying Max's patches it was apparent
> that something had broken ib_srpt connections within LIO target since
> 5.5.
>
> Note thet ib_srp client connectivity with the commit functions fine,
> it's just the target that breaks with this commit.
>
> After a long bisect this is the commit that seems to break it.
> While it's not directly code in ib_srpt, its code in mlx5 vport
> ethernet connectivity that then breaks ib_srpt connectivity over mlx5
> IB RDMA with LIO.
>
> I will let Leon and others decide but reverting the below commit allows
> SRP connectivity to an LIO target to work again.

Thanks Laurence,
It is very strange, according to our HW specification (PRM), there are
limited number of fields which can be overwritten and it is determined
by the field_select field.

From the PRM:
" A bitmask to each field in the context which informs the following
• In QUERY if fields are RO or RW
• In MODIFY indicates which fields to modify
Each bit in field_select has this information for a specific field in
context. Value 0 - means RO. Value 1 - means RW. ‘
field_select bitmask
Bit 0: port_guid
Bit 1: node_guid
Bit 2: vport_state_policy
Bit 3: min_wqe_inline_mode - used only by vport_group_manager
to configure other ports (not its own vport)
Bit 4: grh_required - Allows PFs to determine the VF VPort type.
Bit 5: system_image_guid - allows vport group manager to modify
the system_image_guid of its VFs "

Bits 0, 1 and 3 are handled in the code.
Bits 4 and 5 were not set before too.

I'll take offline with Max to see which extra field was RW without
corresponding field_select field.

Thanks

>
> Max, I will test your new patches once we have a decision on this.
>
> Client
> Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1 SMP Thu Mar 12
> 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> Server with reverted commit
> Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP Sat Mar 14 16:39:35
> EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> commit ab118da4c10a70b8437f5c90ab77adae1835963e
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Wed Nov 13 12:03:47 2019 +0200
>
>     net/mlx5: Don't write read-only fields in MODIFY_HCA_VPORT_CONTEXT
> command
>
>     The MODIFY_HCA_VPORT_CONTEXT uses field_selector to mask fields
> needed
>     to be written, other fields are required to be zero according to
> the
>     HW specification. The supported fields are controlled by bitfield
>     and limited to vport state, node and port GUIDs.
>
>     Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> b/drivers/net/ethernet/mellanox/mlx5
> index 30f7848..1faac31f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -1064,26 +1064,13 @@ int mlx5_core_modify_hca_vport_context(struct
> mlx5_core_dev *dev,
>
>         ctx = MLX5_ADDR_OF(modify_hca_vport_context_in, in,
> hca_vport_context);
>         MLX5_SET(hca_vport_context, ctx, field_select, req-
> >field_select);
> -       MLX5_SET(hca_vport_context, ctx, sm_virt_aware, req-
> >sm_virt_aware);
> -       MLX5_SET(hca_vport_context, ctx, has_smi, req->has_smi);
> -       MLX5_SET(hca_vport_context, ctx, has_raw, req->has_raw);
> -       MLX5_SET(hca_vport_context, ctx, vport_state_policy, req-
> >policy);
> -       MLX5_SET(hca_vport_context, ctx, port_physical_state, req-
> >phys_state);
> -       MLX5_SET(hca_vport_context, ctx, vport_state, req-
> >vport_state);
> -       MLX5_SET64(hca_vport_context, ctx, port_guid, req->port_guid);
> -       MLX5_SET64(hca_vport_context, ctx, node_guid, req->node_guid);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select, req-
> >cap_mask1_perm);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask2, req->cap_mask2);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask2_field_select, req-
> >cap_mask2_perm);
> -       MLX5_SET(hca_vport_context, ctx, lid, req->lid);
> -       MLX5_SET(hca_vport_context, ctx, init_type_reply, req-
> >init_type_reply);
> -       MLX5_SET(hca_vport_context, ctx, lmc, req->lmc);
> -       MLX5_SET(hca_vport_context, ctx, subnet_timeout, req-
> >subnet_timeout);
> -       MLX5_SET(hca_vport_context, ctx, sm_lid, req->sm_lid);
> -       MLX5_SET(hca_vport_context, ctx, sm_sl, req->sm_sl);
> -       MLX5_SET(hca_vport_context, ctx, qkey_violation_counter, req-
> >qkey_violation_counter);
> -       MLX5_SET(hca_vport_context, ctx, pkey_violation_counter, req-
> >pkey_violation_counter);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_STATE_POLICY)
> +               MLX5_SET(hca_vport_context, ctx, vport_state_policy,
> +                        req->policy);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_PORT_GUID)
> +               MLX5_SET64(hca_vport_context, ctx, port_guid, req-
> >port_guid);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
> +               MLX5_SET64(hca_vport_context, ctx, node_guid, req-
> >node_guid);
>         err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
>  ex:
>         kfree(in);
>
>
