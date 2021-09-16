Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2940DBEF
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhIPN6g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 09:58:36 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:56768
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236029AbhIPN6f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 09:58:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkZkj8OLQqgUUddU+no7KOxVeTF8EKumuENyCYrRMWDlVCA6FOu5KSA4Xl5j/xc0fbvnBLTwt0TtkH97D2BemPMv9WDMFIGcLHqpkpifyo2SwxBEXsW1d/Fxob9w4NWKWwzLor+W64yHBxRwaHUg0zJHgvWVkvMVSvU1z0v0zzWT7BKuA4lNw3coNS8Y8tXlzJoViOiVmCAm9Gyb4fC+GP2kD1yaokcwfH+OM6VoylX4OzWQyFHY3C5YBKC6uwuJqryo5xfflqUfgPrhMr/06SNDqHs28KcbjpAnL3N5MIl7vw5pi65nU5LKKvDfLynYsn57SMWz3V3tb/nJuT6Efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dUTbJnX95nv29AaDWpl8nEAYs1qZA2ZhA4duZY5/UkY=;
 b=LmSwSj36kyLSFe7HVG+dzQZJ8GAaVyeZQQlEmNVO+B6/5vIp1IBPKGSSmsDOVg5RgNJJdtQ+T+lZebo1hIZ439BF/Gg5FfadKq8UXKLdUWAKFWhHktOdhZN1eumd6c+qM6zpHmSBqz/ujVW/HuhQlJK7xdLJ8+BS/ZmBDXNc827C/SEAa/PH5ty6yPpWP9S4ELRwQtXtsSn3amhjx8QlrvNqlXgCIu48wICTOJe8qUUk617bUO/fp08NPnOsOY1gTqfQBDZHyT6QeMCVa1yO1zu5Bjh3CqWk1PMxMdL24Fd9+VOkWLcRo8CnTPu8bT4jaLhp7itKan/BKblqX+2DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUTbJnX95nv29AaDWpl8nEAYs1qZA2ZhA4duZY5/UkY=;
 b=BrU+FquJloFp4Neof5z2eOHSXeEctqLjbEVScwhGzUVAIn7Hk7TosSzDctRlgUM3+QK0wQ6VIszGNBFwjM9rE6SDSSVzdYzG06y10oFpJJm1pKONlnCEYIOtvR8wvUPf0I005m8NBlBLRn3UGj+02vA1XVe30OJd4rZzGYC3gAC1ZgmAOrP5SrB2drMGhHypsva0TzLuhLKlIJ4Ir9ZInOqXl1/9G1jPWpLwqUHYV5qxFDpUNRgQnUPSTaoETAS2TArFSNxdro8jbiaK4l1RQ5KjYf0Jiz9y+Y8pc4jWtAJuZz1rM+SPICEHn70yiMe5brtWMSe9BOlk+33mpNRfOg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:57:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:57:13 +0000
Date:   Thu, 16 Sep 2021 10:57:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Tao Liu <thomas.liu@ucloud.cn>, dledford@redhat.com,
        haakon.bugge@oracle.com, shayd@nvidia.com, avihaih@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.liu@ucloud.com
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
Message-ID: <20210916135712.GA327412@nvidia.com>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
 <20210914195444.GA156389@nvidia.com>
 <YUEtpNgI+Z8ksQjC@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUEtpNgI+Z8ksQjC@unreal>
X-ClientProxiedBy: CH2PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:59::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:57:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQrt2-001NdF-5a; Thu, 16 Sep 2021 10:57:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a25bb2-6b37-4a6d-1832-08d97919e2a5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5176310ED61F965939D62BA8C2DC9@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q8LXFqW107ZGH1cdWSEogB9ylkeGYxQa70o15FGRE58sTBOF4yR+4BmK/KbbAtAOt6RBGY2SqfpRr/o+/fkujIh+uyuXgyznSXFRMJd4h7RkVcHr84vNSc5DKJ+K+AOYdiyfpbPEKPmkVdIs2FoSVQC+Ln+qLTIptmBttDud0RlnnSDM7CUb3Uk6QsOc2GfIDbZJCMyB8QK9eQlqdcCdQKOglk0/mKC1y/RfiHHunG496Fp+xDHstX5aNqcL8xbArM44xLDhWmDTIqBYeHNUonBGZz5nGhmelhx5leSm2D5lRrPInOmlfWewd/5H0sZPGN83qIboFSX2tRViQfP6vkhFTGemiu/hRk7TNjzuMQXFQwhICgoFSD7VEBbWHxdcB3uApza8WMk+q3VXGNExNSl8ENwqVioLNjrckdA5r8mv22WjOKRW6VIVKjibF8JoOS3K8ogBfFNdem+tTkrRRuyM2Uw2p+nPPJb+w0xy4GfFWNSE8kwCVp113QE1l6C4grP0Sh8Idn0Lf1S1lApmdc8BxcdcrntGLQF2aRJZv2RvC4sTYqHPnBJXWRlFzgTDYp0k2J/PEDeNKZEaqpMJp+fVOuRhPUJsjc8ANQmmaSC9W/Bz0tD8TYBb6qTTGmt4fbIfkziit6mVsX0WvqBY1PviSy15iB458Mn+ZGxkv+NDAjxuTALHJlTa9PAWtbJbrfWuuMIVb2iDZ9zP2MQjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(426003)(6916009)(2616005)(5660300002)(66476007)(4326008)(316002)(38100700002)(1076003)(66946007)(26005)(66556008)(9746002)(8676002)(478600001)(83380400001)(186003)(4744005)(33656002)(8936002)(36756003)(2906002)(86362001)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZKyj1cqc585SZ1Bc2Hp5trtV5YDglJDM+MVXUR2Mevykr/rr1Uz+srT19CE?=
 =?us-ascii?Q?7wnXUgMmSVAbgFaPLN857tFjfD1Q9b67I+eJGp2oU2FMlv/6De0621fqaqjm?=
 =?us-ascii?Q?Y7cRmw7WIRxUJWZ7hIpwo21RLuuuVOEo+PXupGYbwjtLDTVyqUhKzO5qBlqr?=
 =?us-ascii?Q?nWf1fuhdSDKE9ZSSyC6ey0bnMVbJwdgIaw2wbOLFC7vJZtvLCgRGwysHIjsI?=
 =?us-ascii?Q?SJW9bjoZeDdxkf5R6sq3Yv1z7ZeCY9X4PlyNHE0dZSwxkCi/LDyXapMYPEi7?=
 =?us-ascii?Q?mKJ/L+bV44zihW0VcQRG9vzyN5dW0jW1s/zXYDSorPhfSYZWp72MPE+w5v70?=
 =?us-ascii?Q?NrbNeuVTb1TrGP5xHx4pcgxhXQY3gnbQIfSf44WC+hxKcxK1JDH+ZSgFK4Xz?=
 =?us-ascii?Q?xT5o6XwAt17/3uUEClBRK730+Kixrp7qB102/wo9CLQCXgnrYfvYGWEBtPcN?=
 =?us-ascii?Q?o7CrBdai8YuK3NQSs3F9BCuxm8F6jY/jXYtnL2WZ4J7K6+wAQfKQNeTIOtnY?=
 =?us-ascii?Q?BKF9kjI6vdXgQdC6kphyF3IaQ+MEmSoilev7D9HBuYAO1j8feLrFnfqYgD0k?=
 =?us-ascii?Q?eld+uJevElD8Tw/PNVHCUgl09fwJgBVXijT3+1jVJj6lYhXPQPqYgPizxDJn?=
 =?us-ascii?Q?lPa3iHgDtnAxKKwaIzxZE8PeS0JY9nCUAlHnltJPqeK5t9emepgGiD+FjUbB?=
 =?us-ascii?Q?E6DyAOx48mYTHtuXoYPHJbqacnD0RWgqXvU3k2G0rNDFoBfS9p9giqv64Bje?=
 =?us-ascii?Q?k9jAcEqBdduCsXk+7658Dlkke23rvV0aO26CyOesZ2s6KrkOXT0cvkuaIYOm?=
 =?us-ascii?Q?7xiaotgEuVu2xI3d4x+LPsBCjmYTzVgK2tOuxjUsavrKMa+lsXstFyuUEu6g?=
 =?us-ascii?Q?aw5flbkO9hqZ2RSOsoi07Bd3vYR2d8Yn3G2JRsKNQggK5TRlZXaTdXtZkcgm?=
 =?us-ascii?Q?oP3i5pIBoVjT0Kvtq+z28ZtXQVZWUV/+PiwvvSfallYUj4Uq06aEWRGiNunR?=
 =?us-ascii?Q?1dXgVVUuaZ+cRuC2X8Up3MH3mXfeTaHp+A7WfFMOba5Y07fpd5ppmaufOYDy?=
 =?us-ascii?Q?r1qX7ocyJLWnNjCd8GjsUr9MtYibZ2kB5ia2ALMOiG3u8ff26WtWtAoTUNQ6?=
 =?us-ascii?Q?L5cQlg3LezARIivFaA6ej+iNlcVSpOzhXKQtn/5AgpqXTN363nDQMngaJYFn?=
 =?us-ascii?Q?ZmaAn69B3Eiyr3sR46igq75AAt4iPcM0+p//uQtnjO3NrIeS3i1B4+uGdZJX?=
 =?us-ascii?Q?fiKEzex9wc2MjWY65+TKKTHsQb+Q5e49uDtTyXnx05H9hn7RI3PME2CmzGO2?=
 =?us-ascii?Q?fAQbhDJhP27562s3OtUrUNWb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a25bb2-6b37-4a6d-1832-08d97919e2a5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:57:13.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSPzuw+NyYJqZLc/d6G/9wRTEJCpwcWMzGPvw3zQzq16WwIP78qRpXfm8OBjI6vo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 02:17:56AM +0300, Leon Romanovsky wrote:

> > +static void cma_cancel_listens(struct rdma_id_private *id_priv)
> > +{
> > +	/*
> > +	 * During _destroy_id() it is not possible for this value to transition
> > +	 * from empty to !empty, test it outside to lock to avoid taking a
> > +	 * global lock on every destroy. Only listen all cases will have
> > +	 * something to do
> > +	 */
> > +	if (list_empty(&id_priv->list))
> > +		return;
> 
> IMHO, it is better do not do such check outside of the lock without real
> gain. It is too subtle to rely on _destroy_id() behaviour.

This arrangement would have solved the syzkaller bugs that are
triggering due to the other logic in _destroy_id() being too subtle
already :\

But it can't be done because priv->list is a total mess

Jason
