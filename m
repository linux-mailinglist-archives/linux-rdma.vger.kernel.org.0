Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3B261B25
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 20:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIHS5J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 14:57:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19092 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgIHS4y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 14:56:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57d3c30001>; Tue, 08 Sep 2020 11:56:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 11:56:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Sep 2020 11:56:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 18:56:53 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 18:56:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjfYQtwZpItJo5DV/FgBlwdm5bFBUD3w/GUnI+YLcWM1LTju41SYgE/fTz981Z/MUMo1hG6StSiVakY9vDVCCFpNai25lz9dNQsOfYVWE15SMCmbfhse1bb6QydvacZICFk0MzOfnJFp3jt5vncUb+vkSyOc7eKFOU81MZEVQmH/aqzpFPsDFO0v7CPj2rhzVxynTtWHEdINmRKh3Mdo3ApLWBpwOBKi6VBTR0Uhlb/5ZsJhYxRDp5WKh3LQAuj7cQlHUim4YJZxYP9bJTZ3eeaKWzbQFsY2Ns9CHT7uREPetJhCd7nVXNqpPGaYRE1iZZzqsRstDRg+A/KzcKcL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XrGr/nGSHypzAL9Bb7pW+THHasFkrdFOsewdpmi9gQ=;
 b=Iq86KGrdJ7wVcO+y2s5Hr1ONBT9KgE2UlSXA0pQXf2HMfq4+DYuSM2pBAQiZymseA5ZG4Z74VHhf64Bf4lWW8JwE07wYRGmiZctl+QACXRe8v/nrf1v7gOA/fNL+EapdUpnYM6aEkRUg+tEKrh/Xfzqh1lfKyTE8Wy9fArkaN1t5UpXL9TuK5M5DuSBiOFXztDDU1Ym/gjbAiwKQEAcpeTxPd5y1QZwSCseCR2Rpt9GUitZoDFlCYQcJMoprk/CE9yJZoIlNRAyRlNP9Kw+sva994gPHEsNGJHUyKZ9BZFTAAIyqnPCaJccEMVpBWhou/ZG10bW6eeD5CqwgYR/ooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 18:56:52 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 18:56:52 +0000
Date:   Tue, 8 Sep 2020 15:56:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [PATCH rdma-next v2 8/9] RDMA: Restore ability to return error
 for destroy WQ
Message-ID: <20200908185649.GS9166@nvidia.com>
References: <20200907120921.476363-1-leon@kernel.org>
 <20200907120921.476363-9-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907120921.476363-9-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:208:257::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0053.namprd13.prod.outlook.com (2603:10b6:208:257::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Tue, 8 Sep 2020 18:56:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFinR-003543-Nr; Tue, 08 Sep 2020 15:56:49 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f16720-7455-45a2-8d5a-08d85428f273
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3159FB001086CF83E679F8BCC2290@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD0l/6JYQxB+scLUbAnsK0YqthCsWK3z4IxUz4egtY5hvC5ULYG6xCvxlWe4gmIGRoxg6oUeTac2EprJaCbLGaEDgWhdXfFWl4oyt43a4DQbt6iI4gCg4h8UJtu3C53GyHquYp+l9k4rhWmMQJriih5Cbm762nnTvY08B/PpMgM/HkgBB/GRk2oLFTXpt5oVpm4aqXtqx9lS/N6466zo5W334MRV/48rJ0+LdtYbV2LR54DAguvHuyx4wrrVyWFI15IQ/cS5nxdI5EY0nhGNh0HMLjBo5c6O0hNB9rAjcYdJbiPZQTiARIxegFy85Hgk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(316002)(26005)(4326008)(9746002)(33656002)(9786002)(2906002)(36756003)(66946007)(8676002)(5660300002)(1076003)(66556008)(66476007)(4744005)(478600001)(186003)(6916009)(2616005)(54906003)(86362001)(426003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YsLrjU9MIyNRQPvVECRZiYBPdW5L56ZLrnnRXzXkYD8tFdmziajtj++BRq3L5pLmHkOqYWXh+Rd25MvR1buOkoSoQP3mnyWzJD3H6BuYPBxnUlmk8O98V3uCXqfYcP7ARO9rhnIqZUlppZLNuQWKmp0Y4gZgg1sc18my01tsTOhMJ+PsQ+/ciIMTzRG41+ChsbCJ2uBy89od48PAKM5w1bP2bUgpUojVrVlZoeRVNHlunhZagKNBubQui2ouPB94d1PHOtunXATlsPKknPNNV5s7NEZvJssuWQmyb8VTyoDLh87cw5vWSUK3guT4em0/ApeNRx4/hiPktKCBPcB23bLQ4DC4tvAIVTHIWMD7AiSBWvqP+cugstesDehRt1lJ03blTm5MTjtKcOcPJILwrqkh/9BMeSiAkE3z4FDjjjfsMzsdZ02FO5+s7pxTu05pW35QZlmscp+KPFfRdEOne8b0PV/qBb0KP0yC1WqViXQsqyWdcgRoeygikye7EWCHzXktGLzAbYxQxVw/DoALXTe2XhqQqWWKdQMoW9dWH8gSvV6yy86PeLTjPN53mm9kPVstxHcI5zryo9V74LHznn+WLcs82YItsEbusV8gRv0eWE1jvWQs7rktTc2PWpe07+O1SCgPrCew+Be6IqCWXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f16720-7455-45a2-8d5a-08d85428f273
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 18:56:51.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDgA/rM6vfozy2Wh8QuL5KKn6/FONVChd7un554Z0fyW6dzaNmZK3dLgvvGbODXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599591363; bh=1XrGr/nGSHypzAL9Bb7pW+THHasFkrdFOsewdpmi9gQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=K1gF5sHd1Z2bq6k7Oer47m70In20LnhrWTmmymxrrHtOkKG6gjNvsbQQcTM0C6uK2
         uEtxvVoOwxN8s414GoxULNIvPUVsAtTqkDlomKxtsKf6Bl8bVrxjwUTWIYLUu5W0XX
         QcQl1EKa/rq7Gp4t2+itLQB75J2Zmxwrw/OL3q9WtebruS/EGLrV4nBOoaLuEqPu1c
         gxoYevXSN1/MfKtKIq/zYAjBgZHb16yHC9DZVKHo+hZtQEENBz3X3ASb1QelJhxuJ4
         WSIgKk83YxOlaoJO8rky/AypSElL7Tavc/6gvTat4z6biZXvHRP/gUHPCA0YTaSb7n
         11t0LX/O8G8Lg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:09:20PM +0300, Leon Romanovsky wrote:
> -void mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
> +int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_dev *dev = to_mdev(wq->device);
>  	struct mlx5_ib_rwq *rwq = to_mrwq(wq);
> +	int ret;
>  
> -	mlx5_core_destroy_rq_tracked(dev, &rwq->core_qp);
> +	ret = mlx5_core_destroy_rq_tracked(dev, &rwq->core_qp);
> +	if (ret && udata)
> +		return ret;

No udata check here

Jason
