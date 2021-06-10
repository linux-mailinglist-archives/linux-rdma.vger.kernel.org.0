Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC53A2BD8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJMrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:47:04 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:36960
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhFJMrD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOqsJrptGQpxl8hbgoRW80OE+wyPolkP/QikyNCqVI3yRmjrrNpj+3XY69IHmR3LlgZZotkJ1vf6fG7frGEnd4fsfHTDxVyNNzUAHXVQwot1KN59t/cqIEfLSDqg1rkNO59SP6Du3ZwsesH6fDXetDkyoIygpBpQQBkSw/EcH5fY5m56BX9PQhN6zFm421A2W8fNp/n6P0O/kBL9V15CfrgTmtjIOOAamwW5UfGJwMir0h6jagORO3hmnAs3pIgXnHvpbi6paL9gaYzaCShzK1orY1aXTesOc8l+1fuU7xyqTzuFHG2gjIqSafVKmCfI9R3RnyCL93RuoaPznHZ7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OunsOTf5c+6crV0yUZnAgNfogQyJrJ6snnMa6xf5no=;
 b=cI4mBr6vw6sKGwcBcb+HtIpVoNXpjrswtPnL6iw0+QzjSMQstErWCr/aQUopJEVSlO7VovQ2reU3ZhP8NMAuF+J2rmxcI3U0dhg6+HOhUZhSRBFNv3CgJAMqVue8bGp8S5HtNIKsgyP7wtXkAUtuyx0zfJLKVpbIXyeSiqrrWdw3hb3niGSSn/lZRaDzyXTciERbK+zR4ZOmJ19wDMqZ+ySB6jbNFyYU0qg2FR2pJL12ZIjI8inrjSeyxY/45YYjvGVm8bcqIHdgIDzCLSWRoyZbXRb7wtW3kttvKxB9BxOiCI53lS6LmVM2PAROI3fguDpRRE98J6Ts1VJFFa4Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OunsOTf5c+6crV0yUZnAgNfogQyJrJ6snnMa6xf5no=;
 b=Vx3GcOP6zaH59hqgflRwUQhuZsm/5WtL/rF56d/eR/tsFf+HtC64B2ni6imJsTV6qdH7zKv3WJFj9+6GelVPJHwFbfsnDgrLtAJ8ECnsnRDYaGr7l0O67vI46pF8P6qqsRbgd1pigZpqy8uqjKXRhU21BjUx6zZ+HjJ/QYKhTTptBhXogRThLH4UZjYPEzg24zvAghrMCbHpL9UZQzSoyij9xj2b1d/i5Cq1dIfImchi+XWxwPNsqIEtpazJPltgzzNugCFCf34aiNSDsPwN4PzXtAx6kQkoc8zbCLwMT9raZG39ZmJLvwKYVokyTdiSOOWeL+y8ziMGTiUrFHbU1w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 12:45:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 12:45:06 +0000
Date:   Thu, 10 Jun 2021 09:45:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/cm: Remove dgid from the cm_id_priv av
Message-ID: <20210610124505.GB1264557@nvidia.com>
References: <2e7c87b6f662c90c642fc1838e363ad3e6ef14a4.1623236345.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7c87b6f662c90c642fc1838e363ad3e6ef14a4.1623236345.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:208:23d::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 12:45:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrK3V-005J1E-Bf; Thu, 10 Jun 2021 09:45:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a81a21-70bb-44bb-bb5b-08d92c0d92fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5272C047F69D72946B4A5CE9C2359@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkB2joV8VGJMJxvoRqcTfYmx/rh4fNVUIMywdKK63UlM/Z809raj9YYuV8S/bU9TcZmp4ExiaIPXWthUh51j44dpLe4wKA1GLQCA55JFVdDTJ01o2/PD7u61FPKCFwZjhMZ0CIk8NP7uXrlEOmap7s52tAaBCmSotqvaXDonukz9Sy/YJUnNOD/SI6c5zWxHjDtCwu0snxyjFP3wcIdBSEwgBZ8VQVWl5LzTNEWco1xzRhKfsRHrsArwtTPcpjw53gNIxuWGqWcH+HEKw7NM7XO7K8pWf3XTs0iO5F4oBtbelUPhXii0FyezUvOSRVQ51csXIHsxECJTcisCAKR1yV3HvhnTMCcW6Csj4ZoJSd3yXD1u9fCB5SPuRRXQqV+AhQUZ0aiIqU3voj6CBmOdmaBvAxw71DsRM7KI9kuNN/SbqBs+mC5BdaMO4f+qB1E24czihKKtYrn/LlnVXW/hwApernuWOwIFPYQhOoAYyCu1bq/84x522aquY42DPxkE60sPdWZULngAcs/8djnaKlptlfz2xEWcMBnCeMiaUEkT/Dj/t1dYGNcPbB/+bSzmr4/EyC9J45jemgXJUel6Ee4DKacJwDesShMnmQnNFZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(83380400001)(8676002)(6916009)(86362001)(26005)(4744005)(107886003)(33656002)(4326008)(66476007)(66556008)(8936002)(2616005)(9786002)(1076003)(9746002)(36756003)(426003)(316002)(186003)(5660300002)(2906002)(38100700002)(478600001)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Fnfs9ayLcGIAtffyiav//G+O2awZ0FpJ7HW4Po2uvdANycY8oIB0mVfUrmu?=
 =?us-ascii?Q?2x+ISzohvmcdW2yoGztrrqI/Ni8u/ribz+y76VgTuZ+ickvo5CZKUt2ruQoD?=
 =?us-ascii?Q?0XoQgoMYNVTGghVDvzS3VxuzWYR3XcIMi5sv4gGekhADtVKlT6GjNbEC8txP?=
 =?us-ascii?Q?0ch0wyj1dUlHP4s/7LB/1CwOLib6pV4aWW/tUvpT1kuwYtL3aOWTDJvwsT3d?=
 =?us-ascii?Q?duybKdkeXWt2TPCIFqBsc0PV58AyPwbXft5pLM+RY5QvL81bPjxNfnjH1dQi?=
 =?us-ascii?Q?50Ca3RmbWtxTnyEjokmUxxhP+pqLRIxD+9eu2lKA6Q6hM3TvfnDj8U031jlP?=
 =?us-ascii?Q?rJ8QDm0xYzouEyIL9AK1dY4tiDlVCvjh72bt3pRi66bAkl73BPcd74BY88gH?=
 =?us-ascii?Q?mLGiWMh4FwG2dpeFacbCC5DpfLt36MWCzyVM83DSzmGdK9SiXjYcSN2mtcx6?=
 =?us-ascii?Q?7Ue8GeL05/LDV4dTEoAXZROD9wCDcnPlAKgCKHgQvH2hJXqdH3VEgnKiiX+F?=
 =?us-ascii?Q?GnT72gns4cwWIIlbgPtHVKZ/TP+1ocEOEgeZ9wBfhn6j7lBGRcui9klq2CqC?=
 =?us-ascii?Q?jBJkFwxcs8cq7Reu+U+muqocBmEZfWXqRcEn4HQzCMqyFA1JXC5UWcRjIKge?=
 =?us-ascii?Q?K4RYVu6pVaaUqmL4GcEksIbqu9rY+hrcCX48x5xmP2KTX+yp59grjdAjyzRI?=
 =?us-ascii?Q?R2KhaeoLz0kIJatsrkEBjhwCjyuSztAVTPTIbXHiJEyw4wa6IWU8DsQe6kMj?=
 =?us-ascii?Q?LU5O8ZZRYyeZlzaun4TzmSgAQUSTrBdLp/7ezPOcIYwo1Ew9kpzV25U1GZHk?=
 =?us-ascii?Q?xPcSwk5HmLvvLtVPjGGhoLwXWRgihJ2+9IzBo24CBmQsPF/h86jPTvik4pKz?=
 =?us-ascii?Q?OesJBTu9oLjnbzoWTOxnaOOzEcadYouw33aa3I5slwvQYl3fFkHCu3vsTljJ?=
 =?us-ascii?Q?29D/nBPoMKpPj+de33HeP+zKYm0j8yDnajn9kAdcdaDgQFDHQXEIohGojea8?=
 =?us-ascii?Q?V+xv4WxCOZ9mCvtYfeBmMRf7Rlb9Lj7UlMUsZyYaRTQQxkPZ3lyUwxFg+ep8?=
 =?us-ascii?Q?Tk29/gXtGJsJMvE7Diy9aMdFcoQC8TI3kwl0InjQUFpRCj1EpDdkJHFPIK2B?=
 =?us-ascii?Q?nQcg2Kn+UHJBOJAuQ+al74XmftFSjS9WZnX17Qau+zcWhRHTB1CECti8Cx6D?=
 =?us-ascii?Q?bDOD1G8V0xOaV9/vBwyZMeKiELqsZbkYW7Oyxy8FY4P/YY8/EWsfBNlX0Mi6?=
 =?us-ascii?Q?biOsVNXrckFOJW/GLQZmvgN9/g3cbVfYB1yzWptWaP5WGjHq5eOGfnpoDX6H?=
 =?us-ascii?Q?i8WSXTst+7pvfhcQxg5dJgDA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a81a21-70bb-44bb-bb5b-08d92c0d92fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 12:45:06.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNc5qhkdTsx+7gUg/uVlL8fiQatDHrjjfDtAIJrK0ZTKRAjLpUsBARbLG+h++Hvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 01:59:25PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> It turns out this is only being used to store the LID for SIDR mode to
> search the RB tree for request de-duplication. Store the LID value
> directly and don't pretend it is a GID.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
