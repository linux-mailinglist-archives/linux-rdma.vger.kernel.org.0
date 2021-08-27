Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5593F9937
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbhH0MwJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 08:52:09 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:30560
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231271AbhH0MwJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 08:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWMWRIvLWvlaC3BrLCCckDi95yTlCccYAhMEZg8FaiNH7W9G8QrHn//0P8THgLVTkPCQWv9Cnm/CdxIFY9TmY9HpCVTtAvs1+Yvo9haVGgoj3qd73aFvTNhOEhHowgdtanZS+vDgBTvaGquSUHmmN0MfMezjFyy1dQbY1VZy6W7u5shrNBICKE6AMPkKUrkt+6b3JuscJAAkr+XUP78YQSxJbI4xUVVtSCWfsQd2I/Kv2eYotkhLZmCkrrp6+NsVJ4hCeofBYWw5+Lgo2b/CVzgq5FwpE2AOb0mj9Zmh7hgVJ3UC2hf5Dg/1yfdKK1eva5e644uDxiPU66M1aa9a/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tushb67FIdc4EBwP+ygRiyX7mHOSKoG+3+tvaLhOnqM=;
 b=X1XgD8psSg4xB5D0mQFQhJNn/EZac7zRayDiFN94/To5zyUsYaalCqDUTita3LmZ6mdDhcDzaJfTedm2tPAy1fO53d1TnEzRZ7C0gksXyyJ9FlZr///hJO5L5ezJpLnn2ITJSwJOaRzqt1PlrDI4uG12RnytbXS1pxAvLibpKPxrmMlupCRWIly2fXO2AnUuKHJUfvHfGsLPlukbA33yxfi6JypxkxOpRG1ZIIIiIZpGPn1KIy/zXwNbBU91pXg6AZ30urGggcufa2iu2iJhSF8Vjfs5OFx62SnsWEFBq++rH6xtYg7yS9l01drNxnWUSnZkqMYNeYp5GGOXzdt6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tushb67FIdc4EBwP+ygRiyX7mHOSKoG+3+tvaLhOnqM=;
 b=s86ypvcHGZdYTX2twJeMs1jEgl5r6txZR1lhHPMYbfMa8bFrf+dOhOqVcU8PKfIa2Lx8dnuGOP8RWStZPefysCWKcRNuYgr/Ub0KlcvfHJs1lZaBbUvd98S3Hf8v7Nj9lr1tZ8uLm1fy9Vt0UfrJfm/l/vL+rZDFm66sythw+H2QTCfA00PwpWifmyLgSOqkMMjgrKyeDZ6qVAy4YNUd8wy9qS+8X2Z37vBODr0XqoP5yxqpXsBe2iHwCZxTLSzYmd26MkwZefxkvkqDkideMZa11ITdzmSQnbNUesNLE2d4uMoZ21TTuh179OWfcUZNbyUiRWmS64iYNjx6x0IsEg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.21; Fri, 27 Aug 2021 12:51:11 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 12:51:11 +0000
Date:   Fri, 27 Aug 2021 09:51:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 3/6] RDMA/rxe: Create AH index and return to user space
Message-ID: <20210827125109.GA1353574@nvidia.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
 <20210722212244.412157-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722212244.412157-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0060.namprd03.prod.outlook.com (2603:10b6:208:32d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Fri, 27 Aug 2021 12:51:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJbK9-005gAL-T2; Fri, 27 Aug 2021 09:51:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfabc3c9-80fe-4540-7a41-08d969595895
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5493B7874C206911E59447ADC2C89@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Cq6JUxbduITfNLtzHZdlRjkOW9mo8mQcCuQZwNR8v6RwWitreds/+VAqJIZnunnqhxG897qtrIOJc1tBmgSwut4JMvd/TpuBanzK7K5OJtIArqiaYXr+tx+sKAJUKD0FTZfmKbXgQS9FyvdWQSpsa6i8ST5WzK9SVjFV2PnRAXIT996vLof3W0GPOuOqJupJBACfrWBk8+X7MsUk55kmtfjH0/tobxtKC2CWfAFI9Fes25rld02fe4Gzg5ov+lPV40OYt9MgaCwGeGSI3P0jMi1I0Xmtag9f3VG08yuQeENpZFmU8e0idccezdzinBzXq4pVi18OFZSQaBwSfs979n6wCqYCZzl2X+GLV9LIPYF6+v3wEjcdtz+10O6gNQ9L/SJwmTJ8yYgYZAxfxYHUX13ZHKQoPwr7D8UvQ+dWtrt5Fb3eyXWKQFDPnG5BHloLKkK4TG61u1nJCGpkEX6DgRfu3sYTaap7LfZpKKTGkIQ7d7AxXp0Mmw0qMu9INVLL0M6PkwMo13umVBGlPX/F6XfW3EB/IFL96LrRQEsS0e6gfGO2uGk98bmQ6pqC/Qw83SGYIjndzbRwXqVOaU2SEdulgfwlR/jVDi/j7QqIv7+aNbpReCAnH/50ykyb86EtdxJXkBkb8titvB7EzjJrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(26005)(83380400001)(66946007)(2616005)(1076003)(186003)(8676002)(33656002)(86362001)(6916009)(2906002)(316002)(8936002)(66556008)(36756003)(5660300002)(478600001)(9786002)(9746002)(426003)(38100700002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KZjiYWR72rNWdWgzDte4EBVOFGzmTVOe3Vb+zpxIb14+VqZMSSAL8J/phXk?=
 =?us-ascii?Q?hp4I1XQG0OIbycziPolWp/MbZ9tcqvOxBAVxM8iwtxFK6L+YgsPAD9H/NCLn?=
 =?us-ascii?Q?c9Lbca/6/QDsebgae33opoijSyC01TATicDNlVnRYrRFkDhw5N9WujDuvTTq?=
 =?us-ascii?Q?r31cFaQN23lZh8qknbFPAyefcbiPOHS0yXHbleR465Ycpjk+CS7nJ5ETQVIG?=
 =?us-ascii?Q?y//Gfyu7qnqPkh3c3+xWlPDwn0jkrZY6nUV0mD6DmKDwVZwVgYq0WT6iZvzT?=
 =?us-ascii?Q?hj0EopGHp+4CDhqbSiJxyc7jEWpt2GqyU1bR/LazKK9zJMI39rQHiaWkmWXi?=
 =?us-ascii?Q?Z2uN+14GWwCue7PhpMx5Z4LOZK5vJ70te7tKAFgxpifD1vbh6z1zDZvjIRmr?=
 =?us-ascii?Q?rJ19wyK/wmaKUQsNooQ2gIrsHKYMilWzsPTv6Co1FDL800xx2DmGh3wQ6v1Y?=
 =?us-ascii?Q?JyySZXbcrs4cOLCeyYKHfScMJC5gIgnnAmRUTZjKVPyJy3/snctCDp1F1O7t?=
 =?us-ascii?Q?FCK3vUa9mg444/56mDssHnw1ScqW4/fVNA7qjaK7M/wkClJj/900qAVrLxQF?=
 =?us-ascii?Q?YHOWUYxWO1sVgSomn5Na7FXAkvTTeAwDwoSgdWNoVvGgyaplESJ09GNv9i2E?=
 =?us-ascii?Q?qBB6/xcMU4JXAPusxWHxuz4fB7/2HcK4jgCMUux83BS0O/d/nxbvEl2QDbOa?=
 =?us-ascii?Q?GdbhWX9Q/KgKSibymf05WFIjbWAYPJvriei2SL21dMYG5YJ83XQWGCyquCTC?=
 =?us-ascii?Q?3h7M0k9K4s3cpcQr2k+xLD8n5+fOPc7d+PD9M0pDnJCUTvOa89HvAXVwH3S3?=
 =?us-ascii?Q?GXMYKPG3KM6A6ruVRL/AwaK1V5fmHpVvSOCg95ebNPy3elzAoe6dDLkZU3e/?=
 =?us-ascii?Q?TO6w7h+gwpvz/wZaPiEjSxPXmY3C8yvlwUFoPNoQbxhhUsS602n60wqhvUyR?=
 =?us-ascii?Q?dEyqjV6R3/yhsljLi0axBvqvD5RTy7drrmPZjQj+4sSjtHQPYsksoYrsa6N9?=
 =?us-ascii?Q?S6nq/EzxVsjhZGbS/Rmq9LyvYVToC6x1K73tp/1VlS3hwijlA/NaG32J+9Wo?=
 =?us-ascii?Q?zBdEWyypCe9eOmnn+unPMpimjLjjBzlDj5LC5ahigMXUQ3fxT9beLEU86T6c?=
 =?us-ascii?Q?Y+YYuj+5qpjvI999XjuWdwLfSLZd7jgk8Uc7w1HtE/3QFhQqQmBQv01CIQt/?=
 =?us-ascii?Q?jVO0t2Z8ZTzD1CZ8Dpe40Gs78rOwIHAGapaILFjCr07+GofVm1Mv5JSqkvov?=
 =?us-ascii?Q?PFt0a6xCXfdzN7zbXtCek3pmLDF8PTbit0r/h/ez0deZ3opxEpZoN4X1xtdw?=
 =?us-ascii?Q?Ydo/RfAe3/Eln1c3dm9uCHgE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabc3c9-80fe-4540-7a41-08d969595895
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:51:11.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LprlIy2/XOWlC9AVBmTIT7jVxj0vcJvy9k67VSCyjpDpqJ24NgKqi9krhZtWszrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 04:22:42PM -0500, Bob Pearson wrote:
> Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
> the index in UD send WRs to the driver and returning the index to the rxe
> provider.
> 
> Modify rxe_create_ah() to add an index to AH when created and if
> called from a new user provider return it to user space. If called
> from an old provider mark the AH as not having a useful index.
> Modify rxe_destroy_ah to drop the index before deleting the object.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 31 ++++++++++++++++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 ++
>  include/uapi/rdma/rdma_user_rxe.h     |  8 ++++++-
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 725015a2e84c..7181e21f0c55 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -161,9 +161,19 @@ static int rxe_create_ah(struct ib_ah *ibah,
>  			 struct ib_udata *udata)
>  
>  {
> -	int err;
>  	struct rxe_dev *rxe = to_rdev(ibah->device);
>  	struct rxe_ah *ah = to_rah(ibah);
> +	struct rxe_create_ah_resp __user *uresp = NULL;
> +	int err;
> +
> +	if (udata) {
> +		/* test if new user provider */
> +		if (udata->outlen >= sizeof(*uresp))
> +			uresp = udata->outbuf;
> +		ah->is_user = true;
> +	} else {
> +		ah->is_user = false;
> +	}
>  
>  	err = rxe_av_chk_attr(rxe, init_attr->ah_attr);
>  	if (err)
> @@ -173,6 +183,24 @@ static int rxe_create_ah(struct ib_ah *ibah,
>  	if (err)
>  		return err;
>  
> +	/* create index > 0 */
> +	rxe_add_index(ah);
> +	ah->ah_num = ah->pelem.index;
> +
> +	if (uresp) {
> +		/* only if new user provider */
> +		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
> +					 sizeof(uresp->ah_num));

This should just a using a min_t(size_t udata->outlen, sizeof(*uresp))

And this needs to create the uresp on the stack and copy the whole
thing, not try to copy single values at a time

> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 959a3260fcab..500c47d84500 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -48,6 +48,8 @@ struct rxe_ah {
>  	struct rxe_pool_entry	pelem;
>  	struct rxe_pd		*pd;
>  	struct rxe_av		av;
> +	bool			is_user;
> +	int			ah_num;

unsigned int?

Jason
