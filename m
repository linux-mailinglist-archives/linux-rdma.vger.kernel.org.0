Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68F52F115
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349363AbiETQuo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiETQuk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 12:50:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D63D4BB
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 09:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg2QvjZcMuaAfac9GG/UlKuxcQvwy7vJFc3SfAPJucIfyF/GasxvaHcbyDrhnodR46DCgZeh4FvSRdDw64v7xrE9UFYsgFIKqFe2jh7d5KsBf9cn3+W7wSDv2Xq0HfzIvCBOsmYWBx8dpR+wOEbb9qPYQxtEOpTqP6OULEL1sfw6U5nYM4iTtHN0aDyKCpHiT0AZY3PKbNOEYxvCXmZPNeZ7UqY0nDiX3sFKgY+QnNxtm94SJyutaxpnkLoAtlrw3yPf0bngLcZ2ad+zL7OxNwLYk7eEGtW6jVezJEkVpIhFJTg1UnfE0IuiqA1D1/Ye3FTKf8j6+fITQ7RYvGQFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDRgAIH55XyKHImBUCOMFM8PdlcDarGT2FbvWA0UN4w=;
 b=D9okuCgKona9TCjXlC/4ihdKn15Ry1S79Km8Z8bNQo9ij4SpEW6Jzxn8vxQm2F9DVWK/w+7exd81T8ZxnF+TR5LBpxv83BC2kXbxjG9Dlug+6aorzMvJqI7e1SfRLPvM+KD4UpMl+4JkdCIdSQeyofG32BoQQLabpoX9uxBYZVRSiN3Satof61iElSj77lFnK1rzeeaJdiac6I+GUBIRlCvS98DISFj6sfb78yBH01bwvzLgSuDRme+8ZuE+VYXY6RXzgEpU1zNNLE4qxfo4y26byzg3K5Q9h7GEgPiTcWYJpKioIJtoQHr+6gpDNTYKbmVNPVXaa+7WJVfD7Aoo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDRgAIH55XyKHImBUCOMFM8PdlcDarGT2FbvWA0UN4w=;
 b=t5gW2K8k5jUZRq+5He6gqE20LGMPkdoxB1Yp5TqyCPV+AVlqQ13uMjWTYog0pbME3Fv+kHFpXV5pLhHz4fasDHJ0hgS3bKftKfbz6F4HDl4lfdPrswdJiIK40qvTJjLCdwIoXY5p/v4AaRXEZtvahaO22wM5fT5elcmjP0eBbzVEP/VTjHVX/8OBZBuw9z83dcoPj58OjFYHnD56oJ96yR7TQoMfxIQKC+FU7Kj+8R6eR9WGyYtPkv4+si/lNz4K2V2Rn9J9a73z7l2bEf+unGKpXe8CzbeBR2RYn3BmwNEYKgxuLa95BfdEqPCs7AJXzwaNoGq1diLWenbvrkntRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 16:50:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 16:50:37 +0000
Date:   Fri, 20 May 2022 13:50:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA/core: Add an rb_tree that stores
 cm_ids sorted by ifindex and remote IP
Message-ID: <20220520165036.GA2310547@nvidia.com>
References: <cover.1652935014.git.leonro@nvidia.com>
 <7362c2ac8a6df98caf3a3f2a0476bb578d80f02e.1652935014.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7362c2ac8a6df98caf3a3f2a0476bb578d80f02e.1652935014.git.leonro@nvidia.com>
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa2fcc4-0c20-4de5-a46f-08da3a80dd54
X-MS-TrafficTypeDiagnostic: SN1PR12MB2477:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2477A9706EEA56A521188013C2D39@SN1PR12MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+/ACSC7AcxQVPp3xY0cpGlQocp1uesFj57TRMNRxk1vgIMS2+cBAK3+vmtvjL9w7Db3PSVe0YwAII3+gK4BnarfHIDn5uwszsSu+w431RwREg6JhIaqtgGDNMtJB5r0VuKrEabQGdPHOqlk2o6JWT+3JdVdOwXXI+jbUGlC5C3dwbbpkMbgxDXdPLNxTGCgvVDL5/gmuiSO4rh/YQVjMl30wYosajhnkudOct9YQOhz1zghK0lJ7G/91SVV3qpdfnEt/g1CWIwRRRAjfvRxwOjoJRXwibYGr9ZY+bFI8gFFUwEpX8cKcsL2p4HIThuVDvag063JrvH6o3mgp/TbsfmMKfAxpehRj9UV4OgeWbPzoIKJ+Fp46qVvcDpifyEVa5yI9CzoVtVHfxm5ZqOIvdS5kXrz5B0VaSQxe9/FGUJLLtD0zcbaLrSxs+zjIEyMfyrlhjM3XwRV9Vk3z3+31qXVb4lW1iklddVx+4TmJVPrN4Rh+7994AwjV7zwJKGFGSloE23FPFzuHQ3b1A2mTlCxbQyuuCpXzPbGV+/EJ2mPO42ifOyucgX7fziQZOqKzH3BqoSiYyMEI5idLEAzdajuxfaLTeXHcJS7VqNY14RkLdV/XvnnDPPcoDG/c8N1Gm9Bx+kvpyn5t0CIvBn9+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(6486002)(8936002)(86362001)(107886003)(186003)(54906003)(33656002)(6916009)(38100700002)(316002)(1076003)(36756003)(66946007)(2906002)(66556008)(66476007)(4326008)(8676002)(508600001)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7E1Ph+I4cg1pDq6JaCla+AlWz9DSyGLZcfsW2V7S3oHoUFgBQ/JGafc8zZ5r?=
 =?us-ascii?Q?KlfJkw5jgiV/Kd3oZle67tTowP9rgI8ncTxayMxaEX9p6uTfjY46QeKRrmuR?=
 =?us-ascii?Q?vrafk8jEzOes0LfUKfInBZDT8N4TrNHUubvS2d4ACwAKfmxXrIwBAwFJQiYU?=
 =?us-ascii?Q?bzxu+k9XYxFVaTnszIXL+ZxB3EdtsATIXBizLzDcZmh7fLigutt/sAiGttiQ?=
 =?us-ascii?Q?KawSfQ/cdISJHYGPAcPfjseAp1SkTN7gBvwRKJVmmLN88zXhlEdYjzxclUCU?=
 =?us-ascii?Q?PZy9fb4qK05hqSu80kZod7vDcUETa2Y6BvWqOQIvagtZoLDzB5WD7Jil0m+z?=
 =?us-ascii?Q?eteHi5ZX6hV/O3awrei1FzVdwmdTjJpvCMIndysjrJzA+0KEDX7QBG0kKYtP?=
 =?us-ascii?Q?JiS41MOb9u8hsBMwcAONbrXkvUCdaPB1iYyx74BkvhcmJASevRlyGniwAQxu?=
 =?us-ascii?Q?GOKpc+eIzaSlZTrcf26ELHSMPutpsgLUGcPBRRmM+e3PUTuPh49s5Fhbqxwx?=
 =?us-ascii?Q?XuJ/Tw2zKKY8Bu1FaX6tTKXC5RmVOW2UcXq2e4VsE1aeKp3ruzEqxoZIFt1E?=
 =?us-ascii?Q?scM30Gim65W+a/AUh9qk4DMW3uvCC+/ta82Fcy2GeFOCBZWheSK6yvku7kIm?=
 =?us-ascii?Q?wCcr/ZebiPQ/UUbAMwCCFRMU1kiwN0OeXsxAJYG35vTRvFp+WodJgcc31PVY?=
 =?us-ascii?Q?raHnalCDliOursTSsHlr8cIW1JcfaIjoX5s91JBisUC3eV6qYZbcxlNeY0U1?=
 =?us-ascii?Q?pK/I6rRKodhPjrG4hd3v0/eoRc8uNgeSlTXi0yy4YLpIuemTk+F4fCo13aJg?=
 =?us-ascii?Q?e2JfPHCFcM/MeVGS05zh+42+pfHYw2bfAArm2WtY24pzjIdVXaKP8r3o/mKb?=
 =?us-ascii?Q?dubBfESPKroD7UWfq8w0QqPq/ed6OcdlkYdEKL81jwUnvuAVD9BSRfm0LSLX?=
 =?us-ascii?Q?rRND/87vKMoHKMg7x2wcN6LTn6PiJwZLRzM6bCNk8u1y7lZdLnLjzrdd5zry?=
 =?us-ascii?Q?t1kp/qbYWN5mqKR+51DVspj8uXOMx0/pxhBNfpQsrEMq285k02KNcVTk+g7o?=
 =?us-ascii?Q?qbjJ1EbeToJFWqGtdZY4K90RGMOkM3T5ukrzaQu14FjxmtLJwnAAiluVAPKS?=
 =?us-ascii?Q?nX0SXE4FVvK1nZVCwTRO3RrqpbgIIpLSnoXEeaJJKNMdxJ/B1AxA2uzXGbRF?=
 =?us-ascii?Q?AmldXFd37+Gd5nMrpz81czbqdpRJ/Pxe6fHkQTmzn1cpvXkbMs5G+z2H2V6h?=
 =?us-ascii?Q?JhUerS8buh/hABputYN1F/Ik82hd2XzA7k9M1zTxPjEo0I7j7ux/a/adpSlL?=
 =?us-ascii?Q?2Rjl4eCo7RzuM6M38KOOqP3mwyApnx/fxNj12mc0+1k9aJEdeqj947w94Bfr?=
 =?us-ascii?Q?KilEulE15saZ54p8uL01aJFClq8iN4ArcvuzaRYbhvhhrvOyunFA4SGsAFWY?=
 =?us-ascii?Q?nuME8GEa/bgoUbg+oR8sDv8gTaTUl2YsJ+4FgHSWR1/2vi/OekbKN6z2Aj22?=
 =?us-ascii?Q?Wc/o8mkhGKme/68MdE0zJn2Q9KuqljdHpaAA6AzFF8mjShOs21ml+y+CYhkq?=
 =?us-ascii?Q?cH1/Ojan1BKBJA28X/dwa2HcHtXJYPWAzVJaOtKOHCCkMmdv4QekMnZ0RF+G?=
 =?us-ascii?Q?1oCs4jCaoYJRvtAbZXdmsrzcqnkbHVM0JtvpRfbrsTrhwDobA4l2ZQIBb6hG?=
 =?us-ascii?Q?TSgu9xDwegW+FagnTnivtV1lLuRA/MzSSl8ApyeY1UonRvB+fefk92f99z0g?=
 =?us-ascii?Q?cT9V24Pjzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa2fcc4-0c20-4de5-a46f-08da3a80dd54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 16:50:37.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOFmKRZkXvzYxloy3F4+bhB8sWwX3dZ3yJ+gzg9ghRp/2fy7LMWAFVO6BRxiAXzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 19, 2022 at 07:41:22AM +0300, Leon Romanovsky wrote:

> +static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
> +				 struct id_table_entry *entry_b)
> +{
> +	struct rdma_id_private *id_priv = list_first_entry(
> +		&entry_b->id_list, struct rdma_id_private, id_list_entry);
> +	int ifindex_b = id_priv->id.route.addr.dev_addr.bound_dev_if;
> +	struct sockaddr *sb = cma_dst_addr(id_priv);
> +
> +	if (ifindex_a != ifindex_b)
> +		return (ifindex_a > ifindex_b) ? 1 : -1;
> +
> +	if (sa->sa_family != sb->sa_family)
> +		return sa->sa_family - sb->sa_family;
> +
> +	if (sa->sa_family == AF_INET)
> +		return (int)__be32_to_cpu(
> +			       ((struct sockaddr_in *)sa)->sin_addr.s_addr) -
> +		       (int)__be32_to_cpu(
> +			       ((struct sockaddr_in *)sb)->sin_addr.s_addr);

This still overflows, just use memcmp

> +	return memcmp((char *)&((struct sockaddr_in6 *)sa)->sin6_addr,
> +		      (char *)&((struct sockaddr_in6 *)sb)->sin6_addr,
> +		      sizeof(((struct sockaddr_in6 *)sa)->sin6_addr));

This is ipv6_addr_cmp()

Jason
