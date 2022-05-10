Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7525227DB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiEJX4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 19:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiEJX4l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 19:56:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE1200F6C;
        Tue, 10 May 2022 16:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcupC5+gRQP0O9zXniO7KZiIoMhXhrPvGs6nO59Efzj7ow2xdtE9/8ZhBfdTKdnlgkOEzZtrTdqDqrCgYV330r6cBksFWGM6Llfga+SN9w++eap7vYTGRlw3l0locdJDB5IP5grFKbUeBtMySPQxgJVDYa4snbOzcujLMsFcgy9/5gi4/RPTnplRqmAtZ8p4rxe/Mk8ojfrrC9/cWEc4bXKfJ6WwOEKdu+t4ataMB7YZezytgCEhxz0Q5L0IrN5iI90RqVpRbMFVVPoHtZ2NrjScxH8lADyqrO1DSaLqbMacy2L1Cgd6mASnHMMDpidYwnA7L0n+zCJ/4tXGGtd4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccimTFkNg6kA0VRZlKJ7sbO/R7PJjhF4ZCQtXIJcn8w=;
 b=NCJjRJ3zKUqQWVSoS9ztH5AdE3Shz+WKW4KyHUiaEAbaOb3CUtFSz2ILD/wpgNHaNjMcqCUFIIuO8hOnsaMSyHNdKaCZO080k++oGOYSI21i3qZuAye03iOqjA9nFBVYD8iwXuPiaXK1vnvO7aGiAg7ElvuzUuhrZsLNsKbmJK9C38+X8Ch7H6a+eS/QFWO1yCt/1ZZQEV9PxQbYT+bAiBrxd7qeO3+lSqZlwWpEPjzWeSJ8KkxEJ0qDXpFyhNBAhpMAsQb+ybrYRviltrxOOWL3PVnnwABeuH9XiJtEqLo4mi3jEtrYXcIoAxpzk7nQkGJz5+2x135j8ImdgLTIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccimTFkNg6kA0VRZlKJ7sbO/R7PJjhF4ZCQtXIJcn8w=;
 b=Dk5cGdwv+F7SfKZgCZieQCIkY8vmhMvSFELq2Sem7kmbOq4O55DnQcsLoBAwuTe3r9lk11kJd2Y+Ojij1SgJeSuI+dTWqpsF2aNy86DprvYVwy/sbElcrppC6KMbQ72kUAolFhGVw1bkMdmPeYrTMtUimllienl80vQ/rHxQB8ByQOVI3b2HF3Cmq9HSIaAq2rOgMTJ/squ3dWy2S1kSW+y9IK9O5dyAkViaVlTLTwvrNyArnA6MqkQO6yVVJ0C0OCSWZyLrttvvK6dN5EyoreppxRhQBRLgbUq/Vlh+F42Hg5ZwSglErltYTS0LvdyX7aAyoKnaxnXdci6pXPvrXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:75::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 23:56:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 23:56:38 +0000
Date:   Tue, 10 May 2022 20:56:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/core: Add an rb_tree that stores
 cm_ids sorted by ifindex and remote IP
Message-ID: <20220510235637.GA1163656@nvidia.com>
References: <cover.1649075034.git.leonro@nvidia.com>
 <9594928bfa8c8996bfdb31bc575c289573fa5bfb.1649075034.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9594928bfa8c8996bfdb31bc575c289573fa5bfb.1649075034.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e080df-5622-4748-70b1-08da32e0b927
X-MS-TrafficTypeDiagnostic: SN6PR12MB2639:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB263985B25792D863C125CA00C2C99@SN6PR12MB2639.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWZoBT7BYnLr+nslEACL9fpplgMsnvV9RYvhbveHUjMrdqTSErhLIXHQaBpUY+6mmPbTnYFN8t5KR9x843wexRoIKlWQtHX+sFgTyNPv8zsX9HYPhQpH00XKu+g22UPQw3nx8tP708u7B6BnUHpDjBUeGhN80EYuBIBlWRG/WbFn7i4fiD3MbP20WLatJnL96nu3vWmzPrCAzPI8YQLg9GvvY7KzN4ahe17VDTxDnLdSnzuOG21gEKn4WhhzJfQ59c2AqUa3O61ujjkurIB9MJxctPddOzFwwQ1zjrY8fAQGS7IKzaF6cC4UYEoCCWYd+DD4MLIMFUSVP2Pn8r7NfMJeF7awK5U8z9XpbOiz/UGGQAY95XdPJqcTcXEAXlAvwKIeXpT3hl3meuz4sNEk7O31HjqlLz/W+CSiMPRX+csY7RI8rmpaJ36LrEGvdF9dtmr22BSAvq40/1AW3xlXZaqoLAk4Szj7bcaG2nVbw6qPnEgn2AmrjNmq+g9hUv2lonwJ7utDfh/M0uIBS8q2F/ENsPboE9O+vBFp/hb4WaGBOM6VZCtt/+ps1BhbaXZQmO1fVNqnQlQBFajS82zCYp6kDVbr2lBSpitf1B6VG4FhkFd608gpWH/DYfLGHieSFwqF8w+8wz6cprnY/5jYGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(36756003)(8936002)(38100700002)(186003)(5660300002)(107886003)(1076003)(508600001)(4326008)(83380400001)(33656002)(66946007)(66556008)(2616005)(8676002)(66476007)(54906003)(316002)(6506007)(6916009)(86362001)(26005)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSgPsP+sSnzOlX9LNKVcRasP17Zzd7IwScvPF8Mx/PSk3BkL475NtXq0tgVt?=
 =?us-ascii?Q?B67qMhkLRSGVMhQmtPPerbFtdoLVBcR28gH+Xdr81Jj1wTLx6nETCCkpXLm8?=
 =?us-ascii?Q?psH7BiqbORtMmVuMu6ECZQExyzEBDGjjsD8O7TfIOej7m70Vbb0t4JLjD2JV?=
 =?us-ascii?Q?OH1BNG4xF/cmD9qA7zhNcs2galANld6Vtb8qyG9xgcwFcdv9RPtnbgeG/3bH?=
 =?us-ascii?Q?UWaintdQYVRb8QxasE1XmmJ/yvotVeidpBe3ONYyupB04bjXE69BSEPG3ful?=
 =?us-ascii?Q?SKwIXQAUACUlkc7zvCqKibJRB5Yw+o1UsMEbgtDLxDZuQw4h5nd1Pc1M+oF5?=
 =?us-ascii?Q?IdUjJRUebUjOKfxgqfhLDnp+kIdUq4qfuy8sESVZQUZOljwsgT/0tdiPAJVa?=
 =?us-ascii?Q?nYJcA9iM9VT7coZDqjybjFmufMqLN2wtMN9hDZCLUvTE91jZrR+zFwM/EJpl?=
 =?us-ascii?Q?2OlJJDPLr7Yd8+EjjfDNj/bcY4wVQvw2TgD1ny+XFREaCwDzTvAM2xIHRpqE?=
 =?us-ascii?Q?I7m9OZijdgBGFxl7oj1JtQQSdjhmre26L7WNNYpDBp2uVIvEjXwI6Tma32vb?=
 =?us-ascii?Q?W8Lwe/QVChIk/WaEGxA9byOjW5HRalli5uDzVU6YMEMsSb0oMWPXXPve8aRu?=
 =?us-ascii?Q?AlWLKwGyEjH6VcFVsLkic+8fnjIhCH1zvnJyhqdTLhumC2C9t2/1YJjsMEbj?=
 =?us-ascii?Q?euILlzHnybLq19zoSnDIIY6FsxP0iaPtAfL8BxlQdFmsYHoI1Em+197j4QBE?=
 =?us-ascii?Q?LL9D/LK5f4RmeH0jsld+Nt828CmmZNmQS09G2mpaMoZuVaGVfwzFUDqbwBoy?=
 =?us-ascii?Q?f6UXMDEiBEOxVhiLMjg/0eEd+kR9zwIhs1lCyRrZnijktnrOqIPoqI7nw+SG?=
 =?us-ascii?Q?79fpsQxAUZxrQUxMe7Cugav5eSKRMGuOkxn9dY8pHDwc6NyRl77W6cLBfB6s?=
 =?us-ascii?Q?tDupUuPNlbFBsDQxC6qxj0RfHZbMDs5pZQf/NfgDSvwPbrwIJ+CLAU7R4LMT?=
 =?us-ascii?Q?nzyjq0wZBHNpo7sb6dR53/+ItMhFpNDww0mAHfPr/3rIm3QwaekmMdNMtp1F?=
 =?us-ascii?Q?moYnlVKMnrEAF7YrX3eBesETPlordWvGndm+Rbp3b4x+9sBJQjFfh1NAZ/BJ?=
 =?us-ascii?Q?SOFRWZBGiqPzC2mQGqGUhIyyhdot9YX4xsRSBjmIBwd17zby4pYvf00o45+J?=
 =?us-ascii?Q?cFkH8IZnuKR8hpI5DkM8NPAXerrSk8R7s4Qa0ImVP5uphW5Z2RTEJrFL+RLk?=
 =?us-ascii?Q?dxEZYgjcPNDk7du+a/wuEelQLVo78V/A/GHpwAt52SZLUN5uEV+CByUwEST9?=
 =?us-ascii?Q?t7K05++QmIMSNd5Pwd9/r03ahsXV4vBI92N8/tvJ32yLZ5mRuKL6aXeMoA8N?=
 =?us-ascii?Q?zvY/K6nTF2hNnoK+usM329lBdrorZcMXWAzHSOFeyQkKxALXN++pGJ+vxDIe?=
 =?us-ascii?Q?x4Ti49XPZ2seahk1Wp+Rgjbrk87kEIoAmuRl6SVVA1WKZb4Uc2C3WR3RLSu5?=
 =?us-ascii?Q?gs2ZVcrL8XgsJEJOUXgeqSUFmgxoVmXNeNB7P4jwjfDnlCFxrDiEOPydWdyL?=
 =?us-ascii?Q?EstoMCOFo3i2CblSAqKJrYm9f7X+XrNR3Zzzp3LPk292cw8AxV3IECZEGumB?=
 =?us-ascii?Q?GNZuXGMdc/hjggUGcr9sa70djVyUW1+zHAICpICD7T9YC8sz4roi8UaAWbes?=
 =?us-ascii?Q?OxSFgdLP/fERB46AePOSec9WamXN6iyqLXBFWo0IBZJk+W/YG5+Jat3/Jx2V?=
 =?us-ascii?Q?ZXOgnfO3Xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e080df-5622-4748-70b1-08da32e0b927
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 23:56:38.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U/sMxopDoprdD733X3vFJTOdP+DAbFVOPl3Sat8ZzQfICwUs5Dfzu9InhKG4ES6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 04, 2022 at 03:27:26PM +0300, Leon Romanovsky wrote:
> +static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
> +				 int ifindex_b, struct sockaddr *sb)
> +{
> +	if (ifindex_a != ifindex_b)
> +		return ifindex_a - ifindex_b;

These subtraction tricks don't work if the value can overflow
INT_MAX - INT_MIN == undefined


> +static int cma_add_id_to_tree(struct rdma_id_private *node_id_priv)
> +{
> +	struct rb_node **new = &id_table.rb_node, *parent = NULL;

This read of rb_node has to be under the spinlock

> +	struct id_table_entry *this, *node;
> +	struct rdma_id_private *id_priv;
> +	unsigned long flags;
> +	int result;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&id_table_lock, flags);
> +	while (*new) {
> +		this = container_of(*new, struct id_table_entry, rb_node);

Because rebalacing can alter the head

> +		id_priv = list_first_entry(
> +			&this->id_list, struct rdma_id_private, id_list_entry);
> +		result = compare_netdev_and_ip(
> +			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
> +			cma_dst_addr(node_id_priv),
> +			id_priv->id.route.addr.dev_addr.bound_dev_if,
> +			cma_dst_addr(id_priv));

This pattern keeps repeating, one of the arguments to compare should
just be the id_table_entry * and do the list_first/etc inside the
compare.

Jason
