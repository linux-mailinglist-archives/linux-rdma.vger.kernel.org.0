Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592E51B4B9
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 02:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiEEAgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 20:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiEEAgM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 20:36:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAF04BB87
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 17:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCIrMsNRnT9tokD4oRCvin9KNFfPeP7H6colpVLyqO2njDqalR3wZ8jjt695cPDT+BzfFufj47yxEiFQOUep1oFU0/7jqklFmspffp/Fv961NodFARkkyo6YfiPlguQrjMXZJRKS1F9z5kDjAAqI2M7dBwPuPiAgyMwdJ34CBnUc8ffB698onrXzW2YIbxdmbZMOeaTnwzESz8BOiDHb8jjVD+xgXO+OFl/4IJGPFVXLszg96andcpkn/gZSoUAPXtU5K0EK8XnJow3JVNIdXe+nn1285SYZWcUdv6//Zi0GSk1Ui9N4OQi+YcU55EJFzgdSORvJqtCOlsM8yOixSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUjBqc60ZdI7sWHJ1bZaH2Fo4R1w6LgnfZlH4gt2R8M=;
 b=VQc+X3xRO63j560QfqcoQ5hBANZJ4Tbfizjoa0cd08NGz04ReeHoxOUnD/mZ8hC+6p0QDeEQ/82xD6VDr0xgfN970DBpinUaBPr/g/YMzx8X1hl/UCuX3a8bhvHECRlg+n8/PczmQrjdcIcfV+kHX1mcH2d6NJlYP6I3huIGVum3b7J1z2MKXeceeabQfmInqfNp1OgUvjnE1ajAtAmrrmuGX68jA0ghPdfOShkQftk7m94mAT4bSrEPpSmV+DaZr0rgCilBqRJhty0DW5c68isPUcbeXJSJhfwkzIkdUHyd1JN5CQo+f1PFIm2FC8fNCCqqn9X0QXpqPIWH7z42Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUjBqc60ZdI7sWHJ1bZaH2Fo4R1w6LgnfZlH4gt2R8M=;
 b=K2q9FS+adi2Hs8IDcsuRMDc1VU0QJEk9jjsg+HLTU7wUn5D4KMpss74V4LI+xQ+8LPJj6oDyON1Z1dqWxFAheiJM6EeSIrlBNl4EHTrOvcMH2eRCophUMVJz/zbegAnlZMN8HCwNOGETaANfxbY1i20JeyNpeiACrvik/vnFi5Uetjg3Ich25Y0vig+FwHACnurai8aUr+ZxCtTBJU6SxIhDX3QyLeZcvA2cEodG+K+s+Ncw7fS9UZORx9qCwXp88LUoHS62uUZGJscv1gMjnAycJQfZVsdCTo/lGxjSMTEzRAN/I9ewdMSxjEOwC6U/zhNM6GZJ5+8li9WTvpcbKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 00:32:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 00:32:31 +0000
Date:   Wed, 4 May 2022 21:32:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Message-ID: <20220505003229.GO49344@nvidia.com>
References: <20220504202817.98247-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504202817.98247-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4abb1550-decc-4dba-b7be-08da2e2ebd97
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6099:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6099D833D09E1761238761AEC2C29@SJ1PR12MB6099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttGmNU9d+wZIQdHtHbizxAxPiB1ODvVavSS/WNWBrHmHp7c02koIb7WwRgvnmRQrQ2FNWLD61Kl/7lylApO/1MMJ8zVv9xcsxvbdydOdR9bX5r+FQflcbKQjjuPAaDdZwYSllvdNW+q3q2CHa8h+w0Xf6hKWBHTIiCLK9EnOW7iazGBnZnvMoLgG+HKUUtKA1JAom5k3qnOODmmUBSggLb60CvQELOAofvZKrqR2bSDpMYzy1df7kJkIVPhVFgGtvg7xAvJD7y+Bfwclwyes/LPYetH+2a9Nc2dRlj9ffwdBTKDPq4TWacB5SlrwezdJByrmqcv8FRCTVjo6pDoE33fQrMsTU/VDt6wY7fAjHUJY9w345VePGgDbdtdp2dzl1T92H3bSYQbuS88hAeSCPE1SALBmZ2KiYIXNoZKSIFC546WURKP/8AuhwiR0PbtNUTotXQMqpxAU+JWR5aN7sh9I3z8VI1C3IqV0rHVy33Ft9RwEMiiv6gqCL/tgciIFKmfUsTljoX8OiyhP6zlRWt7+McI9JussPsIvNESy4DLi51bJGoDnf1YKTXffpzGqze0SlgIkR3+tqmQ0tu/UnQB3K2Oz9L4W1HCgj9/mU9DLEmp/lWZ4jC5yB8KGtH8i4Ot2tvnfQfUAuU+0GNqObw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(36756003)(83380400001)(66946007)(2616005)(1076003)(33656002)(2906002)(8936002)(66556008)(6486002)(508600001)(5660300002)(66476007)(38100700002)(316002)(6916009)(6512007)(86362001)(26005)(8676002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NeYOtPi547RbocWM1Us33DMWCZgZEnXOZeMZqDtRSiAxxRb+7ySEJlkB3oTH?=
 =?us-ascii?Q?tHX5/TvhXtH3WBZGXoxLU88ECJtSywwQnugOhD2xadd59t0OzJJe0rvrSeSC?=
 =?us-ascii?Q?G11XUZsYqHEhduLaQCfgOzONeyluxJSlXmcbQNzmSwvnX3oJ1slVvz+AWxnk?=
 =?us-ascii?Q?UhSFZ65F4sWf3N7Cu7fl0EPYCw8epaefYzXsHlgodan99J5NpcUJuJgh3qOm?=
 =?us-ascii?Q?QJFzduOljx/ly/EeHNResa0Jq/WzzY8J0HULwgsqJWrKngTMY0NghsKqG7Uf?=
 =?us-ascii?Q?mezzjnmEeBz+oP+BYAQ8TA23OxOWCyXj8swOmWonjdYm98L1gl4ybHq0NwFu?=
 =?us-ascii?Q?mrE8nsMgst/+6W+ExxPOxsgF4GRzXagUGzHFWlwFxR7BzftFRjnRd1IRpNmh?=
 =?us-ascii?Q?lwy4yVHIrVvexOTZ/QFL7gcKQbHwD95MNo8X9VqfQoqYp2MRmldleABUmANE?=
 =?us-ascii?Q?6uyosf/bI+S9wkocwNA5oik0I8rzZw6gHrpyhWW/52L3ClUVYlRyzwKfVHjm?=
 =?us-ascii?Q?uFZrb5cBSXkfSY33Rpz20+/a4+xT331EY4cbkJ2UF2gVaX8ob57oK4UJVi0U?=
 =?us-ascii?Q?s/IgFHOuOnQfgS/SR7K4nqHDPBfNYQPawymTyI6EdPHgfeeXYhiv24d6XqI/?=
 =?us-ascii?Q?/fe8AeLx5jYQkE5xyCpLqkxG11/XaISsb938CRZPimbR7bGVBjacy7G2a09B?=
 =?us-ascii?Q?7fxC74pSVvKg/4Zc00zEQQGEiFf7DHvpLYGsBaZ+rHRUAWZZ0jL+nfwiBg6c?=
 =?us-ascii?Q?vDc+1xyOMwg9buNoSnM8Rq/G0C/zfNA/2LA1IZePXCUQ2n41D18OGU3S50RO?=
 =?us-ascii?Q?vxZS+irFpEIaKK6gTYLzhuyLPoI1IzX1opTYbOhTF1WyX6eqjWfW8tolpAG+?=
 =?us-ascii?Q?B8z4+iVmJ7nTijWcbVyWGuRscH4c8cqvESi1D7+yRakikTthXdUD7OXCl6GX?=
 =?us-ascii?Q?msTpl5I866caZCI7VVagwRUXBl0KO7Zo4wz88aJlizQ+gusAwKPtz3F1JeGV?=
 =?us-ascii?Q?zR0TBk1Lirsyv0/wiM/sKi+mZtFFZNHAJYbb2PGtb0pX6dtNSERZNpgDpXPM?=
 =?us-ascii?Q?BKA6MXd6lMUSTME7ibwJ2TzTfQGHcmnraCXZS4uE8LLnKSV7nVgj8d0z/WBl?=
 =?us-ascii?Q?3gHSX9xfO3S5+h9qOFMS5HRG+o6/iL4jcpMeC53HZXdGR7mrJiMs8+M0FzMy?=
 =?us-ascii?Q?4EKB1qc1stDSO04cWLN7FZ2L/AYm6tj4KFuW6MpgBC034sVCgmSKPysxgMvN?=
 =?us-ascii?Q?5uIGV6kOc1e0g5ZHtOg/cYbutkwygllm3W664T3rFveoqfDCJr1vp9wzrjQt?=
 =?us-ascii?Q?TgX5qm1D/k4ylHx3exTttVqYdU9PECupoH+lFZ2fWSCv04ItsKp2nUR0DTv8?=
 =?us-ascii?Q?xjeqf2S5q69s6EZ11lcPRI5B2eeOf3tJhDFPpFFWC3jbBQ2rb8KUOeOTaRiI?=
 =?us-ascii?Q?wD8WoIX+G+7oUhuz3MCz+dQ2qcrmkQC96Wr/uJiRNM3Pu1wBOHYJeu6pu6nV?=
 =?us-ascii?Q?E8jRGMTmYs2brPPg8PoKKSQc7PoFLhOOfnwyt18c9BBdha91L3eZIh8WFPp2?=
 =?us-ascii?Q?ABkUbnflJk2PZlr31+f3kjlqNlKhW9Dk/WWbQDSRfrhYex8iRg8q1ZNzJyDG?=
 =?us-ascii?Q?s1ub6bHOVAzpcygaGl14anhGTtE45495T6ZP3kXtfEyDah9lU4XFONB5pfdu?=
 =?us-ascii?Q?2dHGWUn28pcib8Dvu02zUhD+/bp3b/dofNakKOM+RJrIiVn7WWv7+ZIaX0NH?=
 =?us-ascii?Q?phFq7vSJcg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abb1550-decc-4dba-b7be-08da2e2ebd97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 00:32:31.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA+LzYxizJF1Q1wUfwBKt0/oY+Z/TNKVxAGSWb+YP/VV2Zne3NtJX2Oq4AUqu62F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 04, 2022 at 03:28:17PM -0500, Bob Pearson wrote:
> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> while rxe_recv.c uses _bh spinlocks for the same lock.
> 
> Additionally the current code issues a warning that _irqrestore
> is restoring hardware interrupts while some interrupts are
> enabled. This is traced to calls to the calls to dev_mc_add/del().
> 
> Change the locking of rxe->mcg_lock in rxe_mcast.c to use
> spin_(un)lock_bh() which matches that in rxe_recv.c. Also move
> the calls to dev_mc_add and dev_mc_del outside of spinlocks.
> 
> Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Addressed comments from Jason re not placing calls to dev_mc_add/del
>   inside of spinlocks.

I split this into two patches and put it into for-rc

Please check, and try to write commit messages in this style - "Fix
'some other commit'" is not a good subject, state what bug the patch
is correcting.

One patch per bug

Include the oops messages in the commit messages.

Jason
