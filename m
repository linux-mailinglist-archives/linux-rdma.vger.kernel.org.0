Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1149FFDF
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiA1SAI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 13:00:08 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:17792
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346397AbiA1SAI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 13:00:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUrVb8o5XJJn+Wy6GeCM9g4xdZyxsg3GYCVhESneNwPxYFsDqASPrWDcbULoZfdjB5+LiXDqRvgR4sPG0JFBAyKVrifjK7LjxVWkENKJwui17TFneBFsk7G2C1cRU5G02CC8UFyV/tzAddfPZMJBUngqhFjyQdmlOQ3bTfcZM7R8HjNOZdecTCwGkuNx/+UnGEcIbFTIy+g5byTAIHDU/mPiZUdFR7TzP7LzyCE+Dpr931FPryUhhm+L2O+YoZ528hNKaPNzjKEwftyiH+hoHt2q5cMLNxIBp15JZla97lzVb5aslHep4X/d4DOymz9Ivh3sQtYXU2kmkfn5t1GBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFS8KnDB+GgSfUEgsmS8XFtb2f4+puY5ut3dO55bkVA=;
 b=OGumTIzg8ijDOca/vOGDIZpX415aMhuLDInjlVQRAVkV62Fuy/B2DInCSXXqaKTiQfcwEHDkoU9G4Z9+cZuz+VxNBsIRsisRpJpmFzK9QfJD+D3OaD+DpeDMfnFztLH2G7Qziygx/jvVodeUv39vpMFA7bWFGBbBD+4kNEjlBkpFan6RunjlhW2o4EBzNI1ZjKarWfTXEZwxLhJcWAHmPjS0gXUXhOwb+IRNrm1hGudZ7sF5lUto/SIoRClQck6465b4eRxD+mRvJh4myx7FKO2ozy9bpSjgngTg8nlYAitGQFr8X1s7l83U2AHtFNp364ycS965ERAX5HxxZUCxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFS8KnDB+GgSfUEgsmS8XFtb2f4+puY5ut3dO55bkVA=;
 b=ak3LIU8g4jBaq5nCnf00vIouncTYmegQ6xS6bqX218m1HpxauFpQmF+7cfENvei3Qa/RfO+8nyMSoUHqkNRJJxi2Xa+9NBI3Zv5risu4u2O4kqJe2gxc2xDsJawd+D9fk/YVAWU6g8b+9S6sRES5jiV3z195lQiaP1PFSQPI5Y9WJnl5Hm/pX9OzlidsQ8RT0+tNfcAUuK1ZPD6QLYFJ5zyeRzcAsK/BSX6Mre2S8RrQp5D3igtfozQAgPMNLNBVEhZRgizwmhlpmgvVcW8nyjKtkmcbZIInBcpg/7w7ZjOVz8mqKaSyvIh8y4qXJtnmrJ0THNyxOSQsDBSlxZ9RLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 18:00:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 18:00:07 +0000
Date:   Fri, 28 Jan 2022 14:00:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 07/26] RDMA/rxe: Use kzmalloc/kfree for mca
Message-ID: <20220128180005.GC1786498@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-8-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-8-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0317.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453f63c1-0c73-4a13-882f-08d9e288047b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5227:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5227288A211A77C7B05BA0DEC2229@BN9PR12MB5227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRL1VFS/i9o77xUXGCRweunNzK82l4vX/VQzMzcy5pzFtPEBTNjm5M6vS1zWRV8r7r7A9bStXkSq+3G7DzXPvKkaV7y8/wS1iS3sZ+Oxuq9UPvqXJju6KebbDH0ew9ebzVH4/8U6yn0boQe3BbACx6VGSRkHO0d7N6Cpb2xwDuEFCHbyEPqMMUpLezwAw/kFRUe+eLl5l95Et4zOWyLS55vtg5EJU9tSD8Z8nskmcX8Ggz8mu6Oq6CEGEFs2EnpeQFHjdg6cHtflL8H43PQ9UKvAwDkJ9ytpEozA3Pf8hxV1VOZoKJ6rnTAp6omxRDX1ULqWoojd80y2f3ty1Kau0qYASkjzKDj7TkgQk++OqzVlq2qJF1Y2brMmlu7elUQ0nufj25Iv7dEPQz8qaNWQD/erU4lwJ6IJ3EtGPe5cawvEfv4iF7nA1e0tH1h2AAHD+XRiZlcFzSywqMe/sJK7qNVf2vBeVmkQTPuvTC4YpeNJUYogpnWBT4/0mP6oGothXNhWz3R8noMo6wFpV4gpx7b0MakP26hjL3Wfa1nfzv3dLjD7Uxf2TVHjqi2w8BiqJFqaONdqw9iTILp8ycemGpqgUnbWJ30PswrSbq8Q0H7X0A7uT61XvcL4J2SJ7HCx0xmNcQ9wUWFOnYKLeg51Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(6512007)(6506007)(316002)(66556008)(6486002)(4326008)(86362001)(8676002)(8936002)(6916009)(508600001)(66476007)(66946007)(38100700002)(26005)(2616005)(2906002)(1076003)(36756003)(83380400001)(186003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQHC04PHgExppSlQ/eQpE+XoU445S0tPOZ6nwSy9nIfeJvciOhFNlz8nMdqh?=
 =?us-ascii?Q?ICaMInV1A4LmxB1qUqpCyVk/Cz/fdmpheJYuobBiTbnYgwYbJeAtndDV6S/C?=
 =?us-ascii?Q?hqxCpXgr+G9FRXby+TfawSaj3PNzsM3EMKCL8TUFKqw6JnMai6cQX84xMDDT?=
 =?us-ascii?Q?JABAzY0TF+NRYY8Ct+2u8MXhaGexIVOnDQpt5Z+wpDjh48EyLPjs8ozBEuwA?=
 =?us-ascii?Q?W+IYaLpA04XUnCsDFyIdQOAYXoQcKJVh9KNWs1ieMsIYV3Zi1VY0Cq7VKlVw?=
 =?us-ascii?Q?RRR2losemh9Lk2f96yHnVDZ+rKUR7gyxLE+Od3FSibT7LdMeQ2ifgrvDLzop?=
 =?us-ascii?Q?tPJU5G2/VMPnsb5KJCrf1+eAj4Uuk4+QCuJbVGhfyqxPn+xB/8XK+HZaOPRt?=
 =?us-ascii?Q?vFmVSjEGyaFSTaBX3VhjgKNc0/2LKuH+oCy4rFAO8qVeDGaItgD80aAHXWU0?=
 =?us-ascii?Q?w++O8ZwpU3uOQ4txHK8EK3YVDXtMIteDrNIHbXUuucuhI7I3mRY9KROKOOJg?=
 =?us-ascii?Q?lODPQhj1eJ21JlZ79mI/xzpUs+pJ+E2+0S6EYtwhps4mpyctqiD/3Y5N5jgq?=
 =?us-ascii?Q?gL8ppdc7irdypJqVnE1Bf5Jwh6pVIgs2xWh+FNxo3epb6+RAYqitjwgcnf6F?=
 =?us-ascii?Q?oJK98Xe2DBxj+WYw6amDOQA+Ad6RDbv7yoonDnYGPfzRObh17HbRiKOZAHV5?=
 =?us-ascii?Q?I2hhvO3X9eLRFwBLYPckE0qU+0OmZZ0UWtuC+5dlh0pSvRqOTVLt6sN/S1v8?=
 =?us-ascii?Q?kA1MUdMsZ2onuB/SdlxMAmtb/6hwwLU93Kgy44RlSHIYtwKv4NRwrMFxcMPL?=
 =?us-ascii?Q?fUguoxPSy/gzRzIcGyfDf7U2prL9zbRrzaK3QrxKGi5QYAUxquUfMhZ2IK4d?=
 =?us-ascii?Q?ogZrx5Gfb/NJ6VQpj/OYygmJO2tYIYMeo/lpnvZd6C7hs9wPnbS+fyFpnFGr?=
 =?us-ascii?Q?puoH3VTZZAoOyKsC824Ka58NeXY1vsh8ZC0QPWUAUzcH/tags1hfuy8WNqX8?=
 =?us-ascii?Q?A2EwAPyIzRsnQfUKLHuxNl/n9SFO0hZLtMhaE8UtNMPiyewWjx88TxvTFcRO?=
 =?us-ascii?Q?re7jnJTlkBtJOZr1jUqZHsqIsv60Az/+AHRqT728kQy04W36BJM/lbrEU0Cl?=
 =?us-ascii?Q?r6HVhrfKV/CgOYgh1rT8SsrONn3k0suTLk/UbNr03Zg6+1JDAs0jvRrdiQwy?=
 =?us-ascii?Q?4JkrgThoxxTSxFdUeXVCNScTvFAiyGR+/mlhZyCCOZZZ1LSKzSWPr9uTPZuc?=
 =?us-ascii?Q?4vIZLPtgvqCrjf5gl/I96PgOSH6k34sPwOXyU75SjBA+KIxNMZJdHk9m4SHt?=
 =?us-ascii?Q?q/jpqmE7ZZh/DnZ1bHQMMBbSLpXHTSFZo1Nyy5MxMVcrD/N6+n/Kjg/+Z+Pr?=
 =?us-ascii?Q?GjCu9X4gyNftbz8ghTPLdooiolNjROjQFEdCwE/jx+rFJjQBw76wQozfQL7Y?=
 =?us-ascii?Q?Tpg/fzmsTqt/fq/C/BpiadygI/ZtYqXZCE75UoMLwEInPe8SoGD66uiiqKpG?=
 =?us-ascii?Q?aDKktNSp4uJ4Be/71ivgUn3VCugIQHk0HKOy2ifjezwqlnXxu4nnbG192/KY?=
 =?us-ascii?Q?lg/fT2Y59qV0G/F+UPM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453f63c1-0c73-4a13-882f-08d9e288047b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 18:00:06.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CURHkKD6jtRqu11K9/Cu0eGoQqfyWMBwK9qfEBB9TI63+igDkb8lzy7iXk6cxflu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:36PM -0600, Bob Pearson wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 9336295c4ee2..39f38ee665f2 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -36,6 +36,7 @@ static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
>  	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
>  	if (!grp)
>  		return ERR_PTR(-ENOMEM);
> +	rxe_add_ref(grp);

I have no idea what this ref is for, the grp already has a ref of 1.

You should put the ref incrs near the place that makes a copy of the
pointer. Every pointer should have a ref.

When rxe_alloc_locked() returns the ref is 1 and this ref logically
belongs to the caller

When the caller does rxe_add_key_locked() then the ref is moved into
the rbtree and is now owned by the rbtree

When the caller does rxe_drop_key_locked() then the ref is moved out
of the rbtree and is now owned again by the caller.

After this patch this is leaking the memory on the error unwind:

	err = rxe_mcast_add(rxe, mgid);
	if (unlikely(err)) {
		rxe_drop_key_locked(grp);
		rxe_drop_ref(grp);
		return ERR_PTR(err);
	}

>  	INIT_LIST_HEAD(&grp->qp_list);
>  	spin_lock_init(&grp->mcg_lock);
> @@ -85,12 +86,28 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  			   struct rxe_mcg *grp)
>  {
>  	int err;
> -	struct rxe_mca *elem;
> +	struct rxe_mca *mca, *new_mca;
>  
> -	/* check to see of the qp is already a member of the group */
> +	/* check to see if the qp is already a member of the group */
>  	spin_lock_bh(&grp->mcg_lock);
> -	list_for_each_entry(elem, &grp->qp_list, qp_list) {
> -		if (elem->qp == qp) {
> +	list_for_each_entry(mca, &grp->qp_list, qp_list) {
> +		if (mca->qp == qp) {
> +			spin_unlock_bh(&grp->mcg_lock);
> +			return 0;
> +		}
> +	}
> +	spin_unlock_bh(&grp->mcg_lock);

This would all be much simpler and faster to change it so the qp has
the list head that stores the list of groups it is joined to.

This code never seems to need to go from a group back to the list of
qps.

Jason
