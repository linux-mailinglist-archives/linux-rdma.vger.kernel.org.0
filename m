Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660D1351F64
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhDATP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:15:58 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:63937
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234614AbhDATNt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 15:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxR7lbFVNtiaoUgDEGq08iWqCPmFGG1hHEf9ko26WnuGmt6OV8s1vzh7RKChB+tpdzuxsoaCiM32e2BpaQcJ65QxsT3f6C+PLZQ9R9qg+5pWhp3TbccCeZzi1VVDe01mOrzSu67iY1qDXtCFyvsjBXDXhGp7fisdxZUmyp5KUEE/lexCQ1uijKjBzHsAsvcvwlTanjswp62CvMsoz+XlXlJDd34ewP3WR9WgNAn5u2EEcxT0EcIYWMsFeQoWjAzkHMCs/23ZOVOhRW6gaT3tRbHg4HM4dMr7eQl2Kvbb3csth49M59DAvsDVMoLRS5g3IcuwoMDAOZupSIqnKoJAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzl8KepCw/iBZo1C+F7lKo7I1IXj75ETbaOiRAlU/NE=;
 b=kfJ85/14nO3nBA5LLgQ5pmbsJ8ujCkV5Ru6vkOwznv2x6Ie4zp/egh2BcJPyUddl/aHQQw/kiY/hzobTuoXe2mMYM1Wd5/0yjd3KfUFXTCq4HjWIt8y1RObJjC0ArqFpszT0d4M/jWZtVjbraIEpthB7rzhx3YB8kMbdW74jG5EqrA57BhXoSANLN3sNrVHO1daARNDpKd+jhT1p/0YlkMlyzv3z64XNvsLAstVkVORnpgwIhRbL+E7YPlbvwsBenftGiEz3/8JAkX05hfns+Hy0dbHHXHKfJhKw0inIigLiIgmq0p5ZvVZR2Sb4+5s1ujJYcxKd8vuvf8V1NJ0etA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzl8KepCw/iBZo1C+F7lKo7I1IXj75ETbaOiRAlU/NE=;
 b=KA7+lKuryK+09xsYL7KSzgW+v5fB3hxHnAzcQLYhIcxS3qvZjqx7gEoSmefWvCZK3/5NFOQmmFfUvZosZ25H2v3dqVvl+kaF7sQVXoruS2VdEWnQ3svLRMfo1JXDSnHBCdPkPLeEZ/9L364+ncIZGhv0zEUR5W2OM9PUebf76kaGf6lRjug3vzNS1H/cbJXHvGdCKGobxtcI7ynr5odqqM7VLqypk54WnkLw5MlbWmyagICC/UZsc0GKVpme8ZJHRjpIps+8qZYKpmgCtavtkenXlGdzdRTs9iq9CUpa2b6mpiGqIYuUNjHcqBfph+un6XzzTRYDjiIaKA+aMkmIdg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 19:13:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:13:48 +0000
Date:   Thu, 1 Apr 2021 16:13:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] MAINTAINERS: remove Xavier as maintainer of
 HISILICON ROCE DRIVER
Message-ID: <20210401191346.GA1672136@nvidia.com>
References: <1617007584-39842-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617007584-39842-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 19:13:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2lG-00710Y-Ik; Thu, 01 Apr 2021 16:13:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adc77f9e-4582-4fe5-5a5b-08d8f54246d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29383A0FAB8D68B2D23C8729C27B9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxsLEE1eLPx4JpFyZm8SaksOWE8FaFcwHCUT5lGJ+jWj8Uy+54PA/TmGJDy8HngNKSk/T7+QwaNlBMco7YvDXBHiS9RvbwvOo4s35ad3u7EkPzGKDS9IsnruKHXWSw4aoiPCtnWT3m1P9RB/DHuNlTBgIR3xir47Rbyo8OZCa2gEizeZCO7tLRIEmLp5pyRXYyqghybcUQTBPoJxZGgV3VPm0zslqFRcPs0imwPzcYiNtQJKeT80INmYtdOhRjZiNmopBzSTMHGEpVG0fJ5cN1BKZnZkF0eMhGlLsgeK28b/QSJ4fURc19bd9WwSa3WgaJYjKFZ60DwwcbxfIJWcr1e7Fx+nycjUlx/vw7X63jazQ9YpxP7CbeNaBPzu3ffJtqSSZymm6EUE3Mat69BHJ0hNLgsG03xErJzltQSKqrkYfKFZa5p5UgTCvd2YoVL9mJnz82m7pRXnsh+vIR2LL8rfjjs5EbR+E6+ANkPB2J8ybVTuOCmiqoHHVvSw5epK8r4Kk24ndOevF27ccb4KjPPD6cwmFnT+F2nh/8VlmthpzLACc1VX2ZwYOh4Cdximg0DjV1jEw0P/RaTMcGEq7d1cl8aiEz4jLgRlep9AP+xog6gfg/nFOjowpA77bt1YkufqmSu9YNxWfINTjGMrsSjxzNs1vrVeSmpqG4Qrh34=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(1076003)(86362001)(4744005)(66556008)(38100700001)(9786002)(9746002)(66946007)(36756003)(66476007)(316002)(5660300002)(8936002)(6916009)(8676002)(426003)(83380400001)(4326008)(478600001)(2616005)(26005)(186003)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WZCzlUByonAufeOZs/mz0lxr81xaw+IWYTlgqSXwD1omuW1xG7Q9Gx4thTLk?=
 =?us-ascii?Q?hRfg7H1A0P4MYB3DX9x6GaP34lS/Kuw2Yb0VoEzO7tN+XSnHKEl49fawHpUv?=
 =?us-ascii?Q?PvjB75lkA9clOldDkOlGKXdUHf+l/U2OMP3ZXCLlxJUtTT6Ynh1fqnOoiMGs?=
 =?us-ascii?Q?xrVH57kmD+ur4b1qsbn/zT+P8Ky9qpQyx+KcRWLGNKOCVs6MUEHO8BkEIf6J?=
 =?us-ascii?Q?7Km2hoL5wsHzBA4EzOr58W3E/8mW/jKJVWWXLW2I6lX9QYOL+NoSIhqKtVki?=
 =?us-ascii?Q?YBJ2PRGZUlnMpyF37K/5vUaa32eMJVo7VzVahcW5RaZ5V5pVv59WabvVA3e5?=
 =?us-ascii?Q?PTAO9oqLxlHZxMQTHGZuq2s+bA/pNUQQyDs6kyuvMaSYrr2cArgQW5d+QjrS?=
 =?us-ascii?Q?dQU3dzRpBlDTap0cuLen1QRmIzx/GSMcVOAfuru/Er1o86kDSPXAflHe3Xnb?=
 =?us-ascii?Q?LnlWVTik0Bp4NQKnPlXh2s06TZLkFhQEiyo32WW8l1gtT+Yc1eLVuV5J/gJl?=
 =?us-ascii?Q?UrjPTEmC56AQQXJLAXDC0CW7EFRJgoNA7DmrCLiURRJ/6yeDItgrJxUbiUS6?=
 =?us-ascii?Q?sQR5EAN3/r8Qx+pKpqx7jQwAxcGCN+oksZ5T8CIV6RGsYMWq5+98+zxlcaBw?=
 =?us-ascii?Q?gABtKKpUFrPZRv+sauWwJ/uv4DdLv3JKwSMf2dxX0fkXWao50drleW4wbsiZ?=
 =?us-ascii?Q?QT3Vab9jHxlnThAnew/ArfANlbdazvdIgyOEF6qKotXOq2EDQRh8aA1TpdeJ?=
 =?us-ascii?Q?6YJisAbPR47w1xgdR00gVGiTTrJPaPv1zWIewEVE8bFhSV8n42tEcHWctFYs?=
 =?us-ascii?Q?CLP6rMAemVONc2L12E2tQELOZJOohl9jCSIR+jaLJ/4Wezu9383y0Yn76te7?=
 =?us-ascii?Q?hFiffUiMGdDD4kYqghmGC9ttq99nDkWjCdw79BrcYhwAx8f8jH2ZDW/4KDzC?=
 =?us-ascii?Q?Jq6Ysld6kT5LePxbExKrJKtGf2hVinEHgEYIcx90m1IVzfIrqikzQ9Ps+K6O?=
 =?us-ascii?Q?9OviIk86M4nl9cljliMNdzDou22j1Kbav3Wog8SMuhLy5U4bKtBaiBckj6zW?=
 =?us-ascii?Q?e/nr0mno+tS+M3tIYw7rP7PZLOlXeXoxDQJSjMVdOMoUAQbwrjKOawnd7ogQ?=
 =?us-ascii?Q?oiXTmb6dTt/U7EAgxt+EFEOvU/cJeNOEDiYU1sfvgBNYDbm+C1foGmr1PV6l?=
 =?us-ascii?Q?HoQ3Vr880pGNMvAp8AGdmAew+X+HsjZVO5+ezX/6y/xvfiQh7EPPsHkFoZ27?=
 =?us-ascii?Q?fP4StF5Fds3kw2lB8TXWye+7C28oI2dDxjOi0TR903AFMwcUc0nxNTDibslE?=
 =?us-ascii?Q?bCPIiAqDy0KDithvCj//v/Hk4FZRk3Z7gDg9hbpcEu3XxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc77f9e-4582-4fe5-5a5b-08d8f54246d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:13:48.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc3IsUBQ6UuLIa62JdG7JgHef7kLttgOKca5tSxQ8bU8NnFb/lDqii2lcV4rvHnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 04:46:24PM +0800, Weihang Li wrote:
> Wei Hu(Xavier) has left Hisilicon and his email address is invalid now.
> I'd be glad to add him back with another address if he wants to continue
> maintain this module.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
