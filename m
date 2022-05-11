Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161552281E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 02:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiEKAER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 20:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiEKAEQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 20:04:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9101DEC5B;
        Tue, 10 May 2022 17:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMQP9gj7GHPLk/8ADVI4jiwFklJ+ThtgPyl1Ys/AyuvZDryfYimtO4+F8aDx0w/FddJfN4jU5vbneei3q28NgcTAqSIjz+byARWWVAGpDCcBZSI5M/oHvoqkFcFwtnAnsAi+1IozA17fJRb1H7nNmzt9N91q6V6hsCyv/gZXcH18d1zzVf07tmJ9tUoqvr66i/GDKW3wC93sq0/8LtCKDiVrwIkbTo4q1au3BugqdP1nBWCDd08tLRX1mSthTA1UmFzNfsyfw4BvpYrYSXFGLAcgUv+FNcOmgQvHE7xb+YbX+ncgvuaEUERQ7npFDR4ieBX9nNMZXJmXRJJHtaouiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFIymLM0iTrJegpXn9dj+XzadkiMkX2G1N1lTJCw7iU=;
 b=XFIS74w4QF862bVCtxugFwvRt4XPwXh8VR5NotONjZcMvaAMuwJnm0zirYTqK3AqA8WIis06ARC7VaIOssiepYOMnXQm2CUcucmiyhBz7pvvZbbhtpqIctySrmL4nZ6WQK+miX52ypv8EOWOrdfoZR6TQ4r0gka+S4uunKmrs9qUtjQr4gkMfeMY54rbJ/0fpnu8RJ9zLj9Ki7LjUGzceSDzZElweNHWmT0LxDn3/6ijr8bwvTEQNsJioGI3nxuXMTMkadW1hkPI4vBAL5XRElQJflSq1UBDC/Y+eOYwDBIYjg7BCvF8dAvqv8Mhbh5TKTww6z5/IvfKQqyxLyxJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFIymLM0iTrJegpXn9dj+XzadkiMkX2G1N1lTJCw7iU=;
 b=dDA//pdQYYPo31EnLFLkK9iZK8dDS0p2w1bjDKtHfStMNoeClGCP75l5GeQJk7OpySLDNkbnE87MBhqJqDrcTwH2lf0zfX64inkut6pr8qWgioUt/xMYLOLDg+TRCKE5wIEp6bzsAZLre1ogr2DxX8auYuoRa67Zg5buMDgTB97V+uMAK3l2uCBxsoofRWhObyJx/pEED8zUWKpVx6SCg4mOfw9h6eYudd5BDRJ7OTKooHRg6v/7wNUzFuYKwf/a47dHeGVKjUlGJ6257ccJ+T3XEOtL0BQr3a0gCGJpnmh627nzdbTbV+VzjL56ZDBW4pz+SzjtCMtGn+Qp7DX36A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 00:04:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 00:04:12 +0000
Date:   Tue, 10 May 2022 21:04:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Add a netevent notifier to cma
Message-ID: <20220511000411.GA1164300@nvidia.com>
References: <cover.1649075034.git.leonro@nvidia.com>
 <8c85028f89a877e9b4e6bb58bdd8a7f2cb4567a9.1649075034.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c85028f89a877e9b4e6bb58bdd8a7f2cb4567a9.1649075034.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 965d8e89-6262-41d4-faee-08da32e1c785
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB435561144FEBB2C073431D2EC2C89@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWHafySM6sx6nXc4UdwjIniTU0ZL8MOPc64t76WW+Fw4e1vR4rFW7wPFkdzAfsQrtJz0sbBdWEUggHLqqqe34Iun9qn2HdMIZCOFmqz6jMLHN9oS/1SugPV9DqY1dVE9mmo+o7a7ebbiDb81MqkIHLexKccXPgk9XyHZ/l380ejry2Fam2OPbvt06HcL/A6ZTJHJ9K6q6rRqFE5bSEkvSOrxUx9xuefkRxuC//2CH0krbyYuKdAEjs7eCzPVUCV/4MBpHC3qbKemcCiEMObGOHNNIWpivj8BKIdISCtNaExOKNRUHNr1Njv+fStdSmX2SrnEFhj75ILt+cdrz9zjRkJwb9V1kRuzfPF+kH3icR9J/hK8/aGWyaca9XQoYUANSKqLjB9iRsj/5cfvqBUVv9gMuzQubbSctS6w3u8qZrjuXYLpyn0dYoU/66gska1+T719CZWl5iNo85SIc7y94WYjJsnObiUqs8qF28sAZ3kRFq2A9zGFYpdgRFTcb8+Kc+fvsurMBgkqjXMdW10eQ9FrGeW6437AESYAD5YEfocwtkbn2Gvqb3Ii8qLK7kar7cjFlXENUINco9uC7vMzB+9ix1Zj3dKq1GUyKDTqGZiXPtOtlYNZMFhCz41Z4UxQ+ORaDbVpARMI4Ta5hFZtuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(6486002)(316002)(8936002)(6916009)(54906003)(86362001)(66476007)(66946007)(8676002)(4326008)(66556008)(83380400001)(6512007)(26005)(6506007)(1076003)(2616005)(107886003)(186003)(2906002)(5660300002)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?De2te8toXSMzDjAa50ed1DRXCbR4ZOKx1QeiCAYLW3RNg8ferqgyMx/Q+iSx?=
 =?us-ascii?Q?qSvbg8iddEwZsViSa8AoRuvmamZOSbqQYF6JdQTYsGrIQ62+Sg5B2neIgpMG?=
 =?us-ascii?Q?hDhknMUsogNHBJQ7koAakbOfR41lSae4CXFS7OTSVIC7bjeeZJReKkFs76k4?=
 =?us-ascii?Q?Mb1kUm1IKO6G+Gnqtnofu5t2bB3qdMkuE2ARB93BImmsRCjEHvj+byg2BQca?=
 =?us-ascii?Q?2qsV4ipk+5xKjNsNOz09SEjnDI+W2VmmMqnEoXOOuN+gWHOy8ZB7IrYBOfDg?=
 =?us-ascii?Q?NfhMnR+T6EhJqT+2oETCj7CgoviZ4bulwZnj0pHMytQ+FtC5zzOVamnNtASW?=
 =?us-ascii?Q?eMiXpMiD528tN3hlqCMEJEj0EDGfwL02ch5w6DsFHo8rh0vCaMHBo9OvIKCy?=
 =?us-ascii?Q?PVBRZuzg+H+Y/9WmxJbctrf196iYnIe28VtSyWe9qpAn6qjyFMI38MXAwn3Q?=
 =?us-ascii?Q?g2QjxhJTANAQCxkppkQAzHRnmM2yFWMCilVzyJ+iRE1VqVQNaTiqTDeR6R51?=
 =?us-ascii?Q?afZI5V1h92KpvlYYCAFrRHJJ9n14g57a+8QHLbF45odP2O2W4WFsI9G5lurh?=
 =?us-ascii?Q?tTJtVA3OT9Yc+RrprSRQbeyXQUmsb9Qihw1j97fEjCGFQu1HqjAGUO+ZZFQq?=
 =?us-ascii?Q?mzJuPifBt97xosMU2xhRx532BRSErzQxqqRhNbWBge5hYjDzCNrocab9ZpEX?=
 =?us-ascii?Q?ZBNDxo4i59Ah3lo8E3B8OFLs4ulk+Q9e2VqCjoN5374k68WqI2hOQ6ZZrk7j?=
 =?us-ascii?Q?ReCtirU2xXKzBR+oyeWBoB8AKjPSe+jUY5V57LCf8yxVeAChRLnq9HFHi2os?=
 =?us-ascii?Q?FxeOLOxeFgZ/+NDlQqW3WHhFkqJxtuHljHPKbtGXJD9LYcn8yUr+ZnKeNz42?=
 =?us-ascii?Q?Y5TtVQShpJ17vFru1y0T7Cv80XN7rkYaSHXAne+eolZKm2UJCW21NIMzhVO0?=
 =?us-ascii?Q?0v3fo+6B91an4gAY+40vpCerCdXJeHWscU1KBXyGOjoLPx5/trLEJCJbBKQr?=
 =?us-ascii?Q?y+7iuNm+OmXmn1RrQPML9dHtbrYWJkRwWh4jMwM7gIQ+Pkkutq94HZbf6jkZ?=
 =?us-ascii?Q?V3fBzRJxwsWAA9Ho/kkFPSLnu9GsXws36tPdfHtzvL60IgLkEHfsqXuqP3b7?=
 =?us-ascii?Q?udc96QK8PbCNdCPNQio/0Q7Ge6cIlrkJVfmy82245Z+cRkn0+Z6u2nO1mlzy?=
 =?us-ascii?Q?GKwnPPDdBqXz7t4rtZXCEMbehKFTj9fkYSo8sFPSyQ9+zJ7BJmwvbnaDzeKS?=
 =?us-ascii?Q?YFGr77g0NpqYmMD5OnHWl+LXO+OzafGJpiqPG+pqFbkPffAaqBz5NVQ+mtpU?=
 =?us-ascii?Q?o8hmN29+ZsfdtkpeQrCfFl0pfAsifW4MI7pKUxKy4uEcDxKdK6BBkt0Hwmzt?=
 =?us-ascii?Q?azpdZBfFl0+Xn7dJeTcrU0QzJTSkItOz1D1NDQN8U8pcwsmmv3tPnjLbBFAZ?=
 =?us-ascii?Q?5lqJJZP/LuMe7UkEObWBo4UtL6AHyNZtwIIzAQJsjiMAswq14DpNvaRJJTef?=
 =?us-ascii?Q?GYjZ/3p7WUAQFV6NOYHKmNBxVECRbkfVDjKIlJ6oWvoi3A3zCQwpgs3MPmtx?=
 =?us-ascii?Q?TsGbbmEsf21bsUkPw4gpU7Ge35jTVB0AhEvr7vfIrctfHnDMUNspggfe8Fv6?=
 =?us-ascii?Q?5LuIqcFCxn4e5caMhwrTz5/FNnhDgSRDgU7Q6lr1pkOroHRCQY+DOfvX7lLm?=
 =?us-ascii?Q?LuAXAK4Awwx/0gYtWp7RmGgMi/VCZbh/bbpCdFGEiMtwRGOIaH14Ra6N8FmY?=
 =?us-ascii?Q?DzEu5oHj+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965d8e89-6262-41d4-faee-08da32e1c785
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 00:04:12.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnY3RAxGXwes0jQS3UcUhw5dlcKhZIOgU/Ahb91A1H71vUNYzqcWkIST/GJkQC3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

On Mon, Apr 04, 2022 at 03:27:27PM +0300, Leon Romanovsky wrote:

> @@ -5054,10 +5061,95 @@ static int cma_netdev_callback(struct notifier_block *self, unsigned long event,
>  	return ret;
>  }
>  
> +static void cma_netevent_work_handler(struct work_struct *_work)
> +{
> +	struct cma_netevent_work *network =
> +		container_of(_work, struct cma_netevent_work, work);
> +	struct rdma_cm_event event = {};
> +
> +	mutex_lock(&network->id_priv->handler_mutex);
> +
> +	if (READ_ONCE(network->id_priv->state) == RDMA_CM_DESTROYING ||
> +	    READ_ONCE(network->id_priv->state) == RDMA_CM_DEVICE_REMOVAL)
> +		goto out_unlock;
> +
> +	event.event = RDMA_CM_EVENT_UNREACHABLE;
> +	event.status = -ETIMEDOUT;
> +
> +	if (cma_cm_event_handler(network->id_priv, &event)) {
> +		__acquire(&network->id_priv->handler_mutex);

??

> +		network->id_priv->cm_id.ib = NULL;
> +		cma_id_put(network->id_priv);
> +		destroy_id_handler_unlock(network->id_priv);
> +		kfree(network);
> +		return;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&network->id_priv->handler_mutex);
> +	cma_id_put(network->id_priv);
> +	kfree(network);
> +}
> +
> +static int cma_netevent_callback(struct notifier_block *self,
> +				 unsigned long event, void *ctx)
> +{
> +	struct id_table_entry *ips_node = NULL;
> +	struct rdma_id_private *current_id;
> +	struct cma_netevent_work *network;
> +	struct neighbour *neigh = ctx;
> +	unsigned long flags;
> +
> +	if (event != NETEVENT_NEIGH_UPDATE)
> +		return NOTIFY_DONE;
> +
> +	spin_lock_irqsave(&id_table_lock, flags);
> +	if (neigh->tbl->family == AF_INET6) {
> +		struct sockaddr_in6 neigh_sock_6;
> +
> +		neigh_sock_6.sin6_family = AF_INET6;
> +		neigh_sock_6.sin6_addr = *(struct in6_addr *)neigh->primary_key;
> +		ips_node = node_from_ndev_ip(&id_table, neigh->dev->ifindex,
> +					     (struct sockaddr *)&neigh_sock_6);
> +	} else if (neigh->tbl->family == AF_INET) {
> +		struct sockaddr_in neigh_sock_4;
> +
> +		neigh_sock_4.sin_family = AF_INET;
> +		neigh_sock_4.sin_addr.s_addr = *(__be32 *)(neigh->primary_key);
> +		ips_node = node_from_ndev_ip(&id_table, neigh->dev->ifindex,
> +					     (struct sockaddr *)&neigh_sock_4);
> +	} else
> +		goto out;
> +
> +	if (!ips_node)
> +		goto out;
> +
> +	list_for_each_entry(current_id, &ips_node->id_list, id_list_entry) {
> +		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
> +			   neigh->ha, ETH_ALEN))
> +			continue;
> +		network = kzalloc(sizeof(*network), GFP_ATOMIC);
> +		if (!network)
> +			goto out;
> +
> +		INIT_WORK(&network->work, cma_netevent_work_handler);
> +		network->id_priv = current_id;
> +		cma_id_get(current_id);
> +		queue_work(cma_netevent_wq, &network->work);

This is pretty ugly that we need to do atomic allocations for every
matching id.

It would be better to add the work directly to the rdma_cm_id and just
waste that memory.

> +	cma_netevent_wq = alloc_ordered_workqueue("rdma_cm_netevent", 0);
> +	if (!cma_netevent_wq) {
> +		ret = -ENOMEM;
> +		goto err_netevent_wq;
> +	}

Why do we need another WQ? Why does it need to be ordered?

Jason
