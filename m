Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850672C5FE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 15:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFLNaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjFLNax (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 09:30:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B8FB
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 06:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztm4FNlXfb9EsrotizH/Vj56o/75tclA56ogQ9A2Eda7W9CnZ1nkAP/rlRUAqwLfvoRsoOK8mXPNBPYNM8QUqXgoLXe49B1JkmzAPMtDZoylQ4iwdPfRqw42Kc3GylrZ/kf8rc5XnyCpmoQzN7dHihHqzf0Fk2cY6jV/hZ9IXondFvqItWsU1jRvSiRKNgvwRUAaS0wrzs3xHm1BTdV1QO7tdU7ungNWNz+AD5WK0m2B7tFKZw/xQYPLzDVN46WSmxhPKaNL1/ea+WnHdwqJ6+Sz9xCJIx/f2/22FwzcI0TyIcmqNXDbvR3E1AWVG8rCD3b62k3VRCZ1uHpghEX2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4is3gykj7qRoGQFxpV4SHPr/xOKWioM0TKwh9mWNoSo=;
 b=bFLSaHhhRKhcFB/QxzgLVwgKUmNtINqtzmZ0zZmgAcR8Gk/ztUhsaCpaGPH7uK7aHnS7xPs0OJMZh6pK0aY9cURCIZD2Q92/+QwOf7X8KX2207U1OOW7S7Np+HgfLYT+7wfV373CgqUyUptDO2AgSYOTGHyLTvM6Gr98bMjK40Gk1xsVCLt3G8QR5nd3qw6FYUN+ItkK28b515khYJ7c1nmJLxZkXxSgsojuxz/O7v+x5tZ0o7EzLrV2EljR1qU6RPUO0jjwv0a+lMN1sXCOYWNQgmAbMXFH1eaZuDXE53/6Ps2ZnJ3SmMDsjkXTzOcZzhvXUR0fGeRRg1SGCSQMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4is3gykj7qRoGQFxpV4SHPr/xOKWioM0TKwh9mWNoSo=;
 b=ud50qd7xOIQ/5CyJFJRv9C5YTbnlrxF4GYszNnoqHCGKzw4HCXq5XQKqdMVcRd97fy0mBa0lxwky2frBUJmH+i7lEruf6QggL2vadwEvV7eSq+AmobnBZ186wJ9h+1vsb0NGw1eiFZxphN3YwBF2OyBxG/fjX2vUGWvspPoOIj/lP5Lytoh0vtw4uv4eNnk2HXcFsRHpdfS+o2L8XUjBQa65qaCZm5Tr2HL/TJI03bReuYHsCkqLza87TtQVmLfoa6HLK4ZZ4nFcd8S16u040DP0vazfTLjBH3IzE1oVhoNje02WZDbYVN8ML/N0vdosls1DY896KGjjr2p8vf01yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Mon, 12 Jun
 2023 13:30:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:30:46 +0000
Date:   Mon, 12 Jun 2023 10:30:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Message-ID: <ZIceBDrARRE4sG5P@nvidia.com>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
 <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
 <20230612061032.GL12152@unreal>
 <3E4B9E99-4B2F-40B7-8B14-D0A18FC01B4D@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4B9E99-4B2F-40B7-8B14-D0A18FC01B4D@oracle.com>
X-ClientProxiedBy: MN2PR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:208:19b::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d453d2-3441-4297-79ec-08db6b493a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djuv/d1PPhw70Bd+Z9mVCWIozxtgzOyU8KYwsrR9Z/CXIm2Z5iJwGALz/k1I7xtl9eq3QI10xtNfRgudavqhnjwqglTiHJfgGE4TqALktt/c3NmXA81x8nPQNWnlmZnzSKm4jlAgxifks5WjKp5ff3P6r3KqMkCa58AoSO9Ya1z1qdoGomHP6+ugH48LwG3+uUGoVSFWaTA4wWfVhYZpvTtDMMg/vIrkqS7klE1PbaMVD3I77Rodv5N+h9dAxZpNqgbdQrBFRu0151OCQcT8nJkeRWnEs2OCHSS8YolfzStzJYidtvHU0R7KHaqrIlJDSGN9yDu8KjneLI977jSAfn2uE0tUak9H2RmmGL7zVVttmx/IdaMTQtVZNxxMwqUSqduwF88EF9c7WvvpyMSVFPdp+OOctCjwpJ9FoVUeliQ8Ncmpm4pKlHdI/yUvFgw1NKm9shv+quXqU/BZ0NhEjgOPLURgcNhIjZYPF0ztJywWaWu3s9GUEXuTrj4eZsKq+ZLK+ePQtQLkva+MOS+3w0JQti2jTQ55yCI7pogtdbkgl9ghlRXBcn6Ic/CcUL/7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(36756003)(86362001)(2906002)(6512007)(26005)(186003)(83380400001)(5660300002)(6506007)(478600001)(6486002)(54906003)(2616005)(4326008)(6916009)(8936002)(41300700001)(66946007)(66476007)(38100700002)(8676002)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UE6+MtV2Y1/U9WxII4hGxcbie9hno0xDbKT8UFL+U1U38LBDDPvT2XgjFdSe?=
 =?us-ascii?Q?wavADt5vJaRmTu8OhLT8eZpiHEuqKoddoH7LoAVDprQ+juC9l3f+kFF/dItH?=
 =?us-ascii?Q?2M1AeM3SSBWzQY/VNgkmYYdPT/p4XTyF+83Uh8qeDJ3NK9cGafNEyACRmeM/?=
 =?us-ascii?Q?xWYDEUhk8vr9RRwxSaY8LSFrlpQhWFYrEE2QoZ9EeRdh7WHVNbWjkZA+Pn+f?=
 =?us-ascii?Q?JLN/95k7zxDFfjBFYPSi29wTXZKnvzd0opIK+cr6G3I5Lh0XR5+GU2JTZUvL?=
 =?us-ascii?Q?eYiPgDUXegZtKbcnWIQ7oPGceBRNtqpA33QssJye4imKSYslJH//rlROO2+8?=
 =?us-ascii?Q?nqbe6ZwsnBVA6CSNw0tz2KE2ocbskl2sBP+HSYbBwN4qurKNQCf3FhpnVtFM?=
 =?us-ascii?Q?pK6xrRQpoGXyQlG87xZ1H0Yp050buHKG7+CgHlLxvetc2wm5nnlc8ypL3F/8?=
 =?us-ascii?Q?wEsTg6zVy4+EWnntTWCGSAAvzTgjEaaKRkjp7jOb/tleIxmAwVEssOWTWu+B?=
 =?us-ascii?Q?25pZ8h8+cHzaxj5Odgv0EeBPalCBq892Ii9lIBqr0DkjSXoOnnbq1Ngi6mc0?=
 =?us-ascii?Q?Qi+fTJYek72WzMdosXaYgas9Q43qD+W+CYF3W02dcKlbi248Sl6lRNG6lhxf?=
 =?us-ascii?Q?NuXFTezDpEJMn5elC+h4KHG+Z4GNxh2VyIXkK5Y6rACFSTKKqPBc7RTLKBTQ?=
 =?us-ascii?Q?LtPeQc1mhF7m0r2McWVuaF2Du3INdsNI89SzIemr43gvMy4IHyE3mVuLkINe?=
 =?us-ascii?Q?chAgTbUIIUSTPDADocX+nOXoTukfa2APXK+IvAuu9C48nNveCDgP440YgQ52?=
 =?us-ascii?Q?pUIkv4g57JBlA3iIy7EuPfYbxiplnm1K0wUtWRmKeIHQP27Ppenm4wnGqLr0?=
 =?us-ascii?Q?vrAFVWiJ6FX6q6W7QUtPfHwqLWxPPQ3rvS1iNKA6JAFS8+vSssQq0TVFnpD7?=
 =?us-ascii?Q?Y7PdN7XZkuqp2qLxeu1us2ELrQwziRhfAAvdbifxFnbToXiVTSCA+j8aEant?=
 =?us-ascii?Q?2dYPhSrFK578xoALy1Rfkh5ZkCL52I6yMDUu+SKRXNtRBaNmgIsL5svygoP+?=
 =?us-ascii?Q?UokRj+SwacBFesdSLE2y1Y3rgOucVBsBmjHnThN+AHrhN4V7cc37gl9diPsg?=
 =?us-ascii?Q?gxNwbWuMZbwKn0N9KDff3YN6HYJ1HT3atKB+PAcjfKwHAZc91xYAEYn/MvnI?=
 =?us-ascii?Q?rFGzo67U4bsx0R4bWIFrKVOhEjB34uMLpUOJL5cMpZS9b8OS7BuLIEH+Q7Ze?=
 =?us-ascii?Q?3WJdCIsYz+3vAAkZ48P40G9yVQ6MOCg9qT0CX7JOjSjyMeCq0gTzXoPG470G?=
 =?us-ascii?Q?PKy86cre2JJ5BXdBl0xl2kfB3H+Nge6Uov0w8OUOKtnXXZQYoV3jdXzDiXck?=
 =?us-ascii?Q?+SsMmQ+Zt+5tAaDvWifhH1SFHNVTtA06LToK5CMqUyVrLKGMKhZd9zQtCjhd?=
 =?us-ascii?Q?Yo7tdorUJKkB2ajbJCcH6CMwiWdxQtT2M37o8lChF/WdNVBPnrQTkxz1QdQU?=
 =?us-ascii?Q?hQCAHxEK67EdP8Gx4skWk4NrmRmJeZHyHrMmWCYcV9nRjPpPDucIXOCgzrW4?=
 =?us-ascii?Q?9usN0y/VYGk6ZxYPZd4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d453d2-3441-4297-79ec-08db6b493a43
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:30:46.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgFwu2FDtAUhKk6brfAd2vdsaMH/my8EwdQASYQqkyQYtP4E1I1sDwQ9QpY4zT42
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 01:27:23PM +0000, Chuck Lever III wrote:

> > I think this change will solve it.
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 93a1c48d0c32..435ac3c93c1f 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -2043,7 +2043,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >  * handlers can start running concurrently.
> >  */
> > static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
> > - 	__releases(&idprv->handler_mutex)
> > + 	__releases(&id_prv->handler_mutex)
> 
> The argument of __releases() is still mis-spelled: s/id_prv/id_priv/
> 
> I can't say I like this solution. It adds clutter but doesn't improve
> the documentation of the lock ordering.
> 
> Instead, I'd pull the mutex_unlock() out of destroy_id_handler_unlock(),
> and then make each of the call sites do the unlock. For instance:
> 
>  void rdma_destroy_id(struct rdma_cm_id *id)
>  {
>         struct rdma_id_private *id_priv =
>                 container_of(id, struct rdma_id_private, id);
> +       enum rdma_cm_state state;
> 
>         mutex_lock(&id_priv->handler_mutex);
> -       destroy_id_handler_unlock(id_priv);
> +       state = destroy_id_handler(id_priv);
> +       mutex_unlock(&id_priv->handler_mutex);
> +       _destroy_id(id_priv, state);
>  }
>  EXPORT_SYMBOL(rdma_destroy_id);
> 
> That way, no annotation is necessary, and both a human being and
> sparse can easily agree that the locking is correct.

I don't like it, there are a lot of call sites and this is tricky
stuff.

I've just been ignoring sparse locking annotations, they don't really
work IMHO.

Jason
