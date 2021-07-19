Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA4A3CD477
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhGSLcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 07:32:25 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:47296
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236491AbhGSLcY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 07:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGGETxlJ4NFfarwSwNtouQeVA2Pe0MrINGbDX0/5R5posJobAXUVmN+71iUuOFVYMJBOEwmeWjb6A9lnnRZxLZsMRs3PGUiG1e66rtYQAGJ7EoNRuFe/ocLBWaSS9NG2/feunwK9MmMNCtIsm/nEYQOMiALoGMXO6/+ndxQSh0dY4FeJuF8I8A0yojlulfh20cigGEoRYkMCYEjoarmGZdBOrzqYuXxNqf9qDIBSXcBY02iuOAdgDNg1wcmUj1JOqOJleD5C01LKQQaj0Lm46HMZyoohT9nTT/3VUyRS2nVRP4hyx7k2Sfz19HRvgej5upYG95EhupN6TPa7oyfjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI0eLadBwe3gW7T/tRod2YAV51D76R3pecvZ1qpebfw=;
 b=AWOBTW9IJ+h+9RQRuFJ0O3GGUFkW1Js90OtrIugJEa70TTRLfBZ2r9MiiNKiqMSOJQnggS3uvFLVdRWDWQg/WZlDRYT82bIDWGTs+LNthKVyqpngnst/s4FwNyBx7pf+UsDSc+bRPw7lauojYy68YmFccTSQ/JIzvzk4ywGQDcWsXVn0VCpYPuDl1KvOLIVI1LpmZy/8L93NoIYCjgVfmxTPcBj3JE8cuMtW3jUI+ebFtzvtXEstzglvHrNkVcho399tvlewgY8HBcumq39WnmC/Jqu3gzct68ZP/tBBEHfFFzEUVypnsxCUu2Drqg0y/P2FrTh8z5LAWxikkKVrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI0eLadBwe3gW7T/tRod2YAV51D76R3pecvZ1qpebfw=;
 b=C6WGrZZo15Ehk535mPZJWSrS/URGdr9MvFsyTQ9TTWzIgjorBSIKyqEmLxkIjUinNB6gxgfPr72KRWNwA+KMx98VpgBer6bI8PBfGrjCB02Jmc2GnQmx0K0HJWz1dnvLEsUAmlPfO/RTBahoY+0emX28jBOJSJLfU/Bi/ahDwH5BQwAo74Z7mKbvY4QzZdQrgrZ01Xj8/L3+HQHOXxorwMj5TNtwZxnEhf+fDk0SJfkkM/3xXpnwm1O/5V3/1ghBHTUOCoYFdSfH3FGByWkvVnvoeGJHsbmdAR2KxHLI5l3Ct+L9oqFBxo7XT1ReQGOHJazLqXWw7UEJvX45QNp2MQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 12:13:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 12:13:03 +0000
Date:   Mon, 19 Jul 2021 09:13:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     lanevdenoche@gmail.com
Cc:     linux-rdma@vger.kernel.org, sagi@grimberg.me, dledford@redhat.com,
        Chesnokov Gleb <Chesnokov.G@raidix.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <20210719121302.GA1048368@nvidia.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714182646.112181-1-Chesnokov.G@raidix.com>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Mon, 19 Jul 2021 12:13:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m5S8s-004Olv-AD; Mon, 19 Jul 2021 09:13:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc281407-48e6-44c9-faf0-08d94aae8ec2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5506ACCA0CA1392F6C240048C2E19@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Y+n05uiKy03q13P49sdZgvOnni/3sSGvAh2UYXIIOtsJht2Q1SBBJARQkYUIEZPYoNuHPIMoOQ4WwmypegW4xmASg1CaBt2dqTfidRpl8e134BripX22dwtMkknV5A55w2aKSc4dx7g3cFjoAEHrTCTcsYeLTdxk9BIYyg9c5ArsK3OkzoQBpovp5Rt35cOyYMA/HTaM8+9/yJVFtT7GpeNikkvpS3QXZCkAhVvsHi6iP58sGr3yjRHi8f3+omBDCQnRLDE9YJqCL71tEGXMrPybVzD7Uo9s13CFkAFjYqrpb+0j9SPLbx5R5AKny4t/a7f5AkUEkBtDo7m04zKWX5/WmOJXkP7QJeahhnAgByV1sys3kPa60qsRqwJv0SvSPK/nA42gQ2iUoS6A3OuD0d/z2IdGFnW+dZe+P4xJTUXq6npQRP7mVkOwU2XFS3VpZsq093fQwVkVoeY9LaPYbRCVipj59HZI3oJRVGnMqmqbx2b16vjQMrtD5vRBkUYhPesk9hblqwe21ZXSAriox3EYX6bp8StUBJ6P9mpqzdPPTcBDh9dZ87NrN6PzMKU/DMyyVQQevkCPi/J1fTm7hL0jjxsOU+cev5zLYSmxuQ9o835afSmNTuW/CQFPB97bFRtb+hIdnDVu5lLEMAljg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(2906002)(66556008)(83380400001)(4744005)(1076003)(33656002)(38100700002)(6916009)(5660300002)(86362001)(508600001)(186003)(4326008)(26005)(426003)(9786002)(2616005)(316002)(8936002)(9746002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ggzEIT845qCfgCuxCrk81uSzjV8b6z/3xPzVm1Vk2z1RqN6hQA5CcBOtQvi?=
 =?us-ascii?Q?xtrLcI+F2rfYcGcs0OlB30nhqlQfkA5lKbiWKva1r4wEdfMSI6FWc3ToUvdu?=
 =?us-ascii?Q?dmmyBf1nxh0djit3rfGshxPZQ+6lnD7v8l2LxIQUjiJ30ylgbx3SuD2/wbOB?=
 =?us-ascii?Q?7CyW328cWECml1Hmjvpl3p/SBFZGN52TzC9kng7YhqDxyw5VZT7PNQCO4gny?=
 =?us-ascii?Q?ae9ZU5Ek/hgmsRc9L5KizARb9GmB/aqfXB2G77ehR02nGsxhCygCtPASo951?=
 =?us-ascii?Q?J9rNAH5K/bkx8Y9ukNjy0KxB7x5uAPS89VLcicwNFg+yxXcy2N5JvL0e18Wi?=
 =?us-ascii?Q?OxkAH9KZh8okfNfDyNOmktc5GqPkOvDe+RctHbyN8+8zpXYRiPSi1/b1Nb6q?=
 =?us-ascii?Q?Nu8H+PBl2kKRBqPxaXQSpvuFGyTT9PZRsUz7GqjfYdbFaOIj7fOmAKr3gEzL?=
 =?us-ascii?Q?KUBvGOFLrwBOMz31t7hCog3VVXYLqZ4FiQHkB6ZK7hBP3wGorkLEP7p7cqiO?=
 =?us-ascii?Q?UW3s73El4TPR9pkU2erNV0f8T3zvQVs4htwgDZKg2AmXTou03adCjocLjZVZ?=
 =?us-ascii?Q?oL254a7LYuyyO1OFrKWZjkNXKOLbvESeMfMHCKdBY9neuv9nbPsShbXg9kxh?=
 =?us-ascii?Q?OgSuNkRfyy2iy2ejcc8bYP8wwZdYWlCyIVt30ahFLSBEgr5ttM8P7cBE6Bvv?=
 =?us-ascii?Q?peipetqx8VHAQqcyJnhDxHrWeihU9mePGqlHM1R0hYwpscBgBvdmfuzLuX6/?=
 =?us-ascii?Q?HFofKK7wWERGrMM51j0oGVIWFN1a/DMcyVW8dNerwzgoPyedighhL292faeJ?=
 =?us-ascii?Q?orxECOPgMHO5McDn5RQswtxyXfBd+OAMT4KcWXr23vHa66RcS4PXRtLEkWTu?=
 =?us-ascii?Q?QJhy+y8hrwuOFohfCbExRNpa78Lh2UaMuc2jqgjJe08GMyCpZOGl8cL7M/Uz?=
 =?us-ascii?Q?C4ZH1V+vmWHXuhpWrT/1FEFqRdIv5cPMKmzU2DSWPy7fnIa64kFSKOzJNA3V?=
 =?us-ascii?Q?T4t+8YybA7PKeaT/gtBLq8558kTa3MnWTxFck4rVlfd+9QAIHgk3LwJV7DRJ?=
 =?us-ascii?Q?P5nPWEnp+q5MyQCY/esgqWCBvztPMu8PPoK3RuH6H3i44bIlDDCEudjejtQ/?=
 =?us-ascii?Q?atdAV3AqW5aXQhAP2mh2VcfBlxJE0t/r8hgfRamBF16i6JpYd2xuEwio8mcM?=
 =?us-ascii?Q?FaEwts7yNatkPE/RtNajX10j8Cnft9tLzzFQILWH1Uhe/BG2KjG09QU/qSv0?=
 =?us-ascii?Q?r79fmSRtrKMoy/UEK77a1dyllCdaUGVfTC8rqckNw/dGl0Bar1A1odxrgK0L?=
 =?us-ascii?Q?Kf4+Iv3C79nsqMz0fLvKSYz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc281407-48e6-44c9-faf0-08d94aae8ec2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 12:13:03.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMzn6enAxUzyaIh7DxbSO9sE8fCBEMB4lepelqTj032JL7/G793TS/9JVfMLhZm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 14, 2021 at 09:26:46PM +0300, lanevdenoche@gmail.com wrote:
> @@ -2466,6 +2489,8 @@ isert_free_np(struct iscsi_np *np)
>  	}
>  	mutex_unlock(&isert_np->mutex);
>  
> +	destroy_workqueue(isert_np->reinit_id_wq);
> +

This is racy, the lines above have:

	if (isert_np->cm_id)
		rdma_destroy_id(isert_np->cm_id);

And I don't see anything preventing that from running concurrently
with the WQ

What is this trying to do anyhow? If the addr has truely changed why
does the bind fail?

Jason
