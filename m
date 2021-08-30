Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C038F3FB158
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhH3GrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 02:47:22 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:20449
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231839AbhH3GrV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Aug 2021 02:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHnbX6jQ/kZBRJjY7L29r/VHZ4NQ2AdzoOP4x0nAAC4Sz/oXfU6H0mK/XaBzKvIioc5Z+O9d0vr/C+/prAnaTwjJbeotE4W6PomGJhmerH2SqR9jyzxeFVKmywLQbYTHKQqWDfSKaYz4BdDR8NkuxsxcVHkRR/wzOrZfiVV8nsgY9HbBx89HfJ/rIjWh7abCBR/Ocp4awlJMvZVyGFqVvPldtDfJD2r39kHSDVlpAUdgEv8eUJxI7AF5PtngeG6GB5QXGS6zHx19EJxC/h/JpWrYXGmDz63GPfSE0JWhdFU0EKjGQFhb6tllPcX+DNbrCOaa6UzbKFfgZKMrRhU5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyPr+9GwDnuZdx5DEk/HT1JvcOmX0piAwrSCuudENmY=;
 b=STEwWJS4w1KkEtzQyYpFwRqOBQvtXGKoAEC4sWLBZ3wgN7D532vAJzVvVx8ZngKlaUQ10jXOn4in3raMCQJA/z+ArVZVdpR13pCXoXeuzYCzkp724wx2YIfJZJ4CUFfW7P0c0LncYTK4D5PsoMvU/U4N/+w/132fo8E5UDChWkOQZjZeXL1Vwn+MHvxEqGkJaC/PuWn5tLV1RI3IERvd50PdxQ40NlxWnYaUQ1QZmHxAsR0RRNAjhh5Q6kPGt4tUXrQr/9IEz+vQX+RCIlI5Y5ppi9M8Mg3eu+XmaVvk7Qchn/DLQ7mD6iuaPJlW/gWE3vPq1wuCo83RXEhjqkhDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyPr+9GwDnuZdx5DEk/HT1JvcOmX0piAwrSCuudENmY=;
 b=lmFAc4JAnGvflFy9fKtihaA3YL2bj23sJayiq27F50x5YUuL/63W4GFWlxSz10EPI3xtSVA2ZMmB24+X2WVsBZRB1mNOeCeqAKtYt3GuPGbxQFA5dXClLLrQw0ll7d2YxCnfGXhN5S1Yv0jKgBw7eNBw2V/akaEFV+8sAhxI0ZFlTw562CukD0ZwSpDcJawur1K/Ij7W5poAnk5xY0XHhOpWoBrRNLBsQ5DFHSx5PBd+2hXH+I+ngSuPN3S9Y4Q3ze59K7XgdNdgyHggz/8jKSD22Zub3ZNbDRyLtVGC/pC2NkgT4zM0ls4KhcNyMC0zJYZ5BP9LoYKridKxzJs+Ug==
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by BN6PR1201MB0227.namprd12.prod.outlook.com (2603:10b6:405:4e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 06:46:15 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::55) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend
 Transport; Mon, 30 Aug 2021 06:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 06:46:15 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 06:46:14 +0000
Received: from [10.212.111.1] (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 06:46:14 +0000
From:   Dmytro Linkin <dlinkin@nvidia.com>
Subject: Re: [bug report] net/mlx5: E-switch, Allow setting share/max tx rate
 limits of rate groups
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
References: <20210825085655.GA28138@kili>
Message-ID: <40790b29-35e6-30d2-2656-5b2efac7db94@nvidia.com>
Date:   Mon, 30 Aug 2021 09:46:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210825085655.GA28138@kili>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82593bc3-59cd-4ff4-bc7e-08d96b81dd4c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0227:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0227C9DC2968B12F5B78540DCBCB9@BN6PR1201MB0227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6H7KPR0lHvq/jWGpH8uNwSkvtbW84zwxlTvk9F+HNR4IqfYerLBaC+8j+VwKKi4vcTAsyv+fYhBteWOdpBnmc8Dn+mbL1dg3Gjq59v00xVyFqQdhRmDo5kAIP/YxST8DJJ+jF/SXxcgjIkiinKbYbBz9UwNs7LFDU6FJ5hZM9u04RLIk47o9K148Iwei6AgbA2ZNjbNJAJYSlpCISFUAra9M9J+lVfhdSfVrWMTwWUsFUlEK03AB3KAhxRINN514jrvt3HR3GfiL0cGzpPlxxKEIOFx2WWcKvv6GFFmkGN51yYlXUvvvmh6bKeCJSjbRMOxEwLCYi9Cx9d/80zFuWlrNyo+U4eVnrHtwx2WbR//sGnYiQ37+IoqqbW7y/UIkTP9m7W84zHmVyYZRgch4SGnHFfkjSVjoCa3LUDgJh5TE6kxyMoacUiweNvX99ZfLEfuZ5Ms/aY0gg2z5k02VwpVMJEQpIf87tBrqOmxdbcgBJ+EiPDqpGmYR79KyGCRtUrmnidw1FqBgqIgEe9I7eh0MMZjR0p3ifD9GyirD5tKokVDxKjmC+0QI02/5q1nAX2DZCA94FLSufLdZzG+5/bv6wfH5zmRi7wh9kykwv0bfQhO8LA3ADXXbMwDAfUDCihwDEUM2U48RxgW+sec3jwsMPaiqluc/WxbWnp9RXJ+SJCioxx7PXdE8d85TK+cpu8oe2ljQWTg6i2aRLbaUOyyKWNDrGYeSU5+je/Q1d+8=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(8936002)(53546011)(4326008)(6916009)(2906002)(336012)(83380400001)(5660300002)(8676002)(316002)(16576012)(7636003)(70586007)(36756003)(36906005)(82740400003)(186003)(356005)(2616005)(36860700001)(26005)(70206006)(82310400003)(31686004)(426003)(47076005)(86362001)(31696002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:46:15.5613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82593bc3-59cd-4ff4-bc7e-08d96b81dd4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/25/21 11:56 AM, Dan Carpenter wrote:
> Hello Dmytro Linkin,
> 
> The patch f47e04eb96e0: "net/mlx5: E-switch, Allow setting share/max
> tx rate limits of rate groups" from May 31, 2021, leads to the
> following Smatch static checker warning:
> 
> 	drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:483 esw_qos_create_rate_group()
> 	warn: passing zero to 'ERR_PTR'
> 
> drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
>     434 static struct mlx5_esw_rate_group *
>     435 esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
>     436 {
>     437 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
>     438 	struct mlx5_esw_rate_group *group;
>     439 	u32 divider;
>     440 	int err;
>     441 
>     442 	if (!MLX5_CAP_QOS(esw->dev, log_esw_max_sched_depth))
>     443 		return ERR_PTR(-EOPNOTSUPP);
>     444 
>     445 	group = kzalloc(sizeof(*group), GFP_KERNEL);
>     446 	if (!group)
>     447 		return ERR_PTR(-ENOMEM);
>     448 
>     449 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
>     450 		 esw->qos.root_tsar_ix);
>     451 	err = mlx5_create_scheduling_element_cmd(esw->dev,
>     452 						 SCHEDULING_HIERARCHY_E_SWITCH,
>     453 						 tsar_ctx,
>     454 						 &group->tsar_ix);
>     455 	if (err) {
>     456 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
>     457 		goto err_sched_elem;
>     458 	}
>     459 
>     460 	list_add_tail(&group->list, &esw->qos.groups);
>     461 
>     462 	divider = esw_qos_calculate_min_rate_divider(esw, group, true);
>     463 	if (divider) {
>     464 		err = esw_qos_normalize_groups_min_rate(esw, divider, extack);
>     465 		if (err) {
>     466 			NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
>     467 			goto err_min_rate;
> 
> Wouldn't we want to we want to propagate this error code
> 
> 
>     468 		}
>     469 	}
>     470 	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
>     471 
>     472 	return group;
>     473 
>     474 err_min_rate:
>     475 	list_del(&group->list);
>     476 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
>     477 						  SCHEDULING_HIERARCHY_E_SWITCH,
>     478 						  group->tsar_ix);
> 
> instead of this one?  Also if this succeeds we return succeess?
> 
>     479 	if (err)
>     480 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
>     481 err_sched_elem:
>     482 	kfree(group);
> --> 483 	return ERR_PTR(err);
>     484 }
> 
> regards,
> dan carpenter
> 

Hello Dan,
Thanks for reporting.

Do I need additional reference to Your report except Reported-by?

Regards,
Dmytro
