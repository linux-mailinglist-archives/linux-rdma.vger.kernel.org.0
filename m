Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6E42C675
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhJMQfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 12:35:21 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:44640
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237395AbhJMQfS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 12:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4yTsn4wRMa2BE+FOOX+jWcqvu8dktRwiEYIBjbpgRHrBDu4vJYADU1wm5vr7SWQXGRJLaQ4sXB38nhxRllzUhyrvylkrUaagUEsvyDUKKrSjLOqQVTM+DfX3E0qRtpGc+Jdi0IE1pZk0OM0h/M1LQYazaVaJDSoHpxswNaCMTHasmoXQ82N1ovjctGJIL0g1fYbAD3PMqPwSopdLv8OtO1p4/TlcvCXu2cGhi+4SPqoKLpa9OKeuaVdHkEceAVztvvjiXeV+4iCH15y3b1MannmO0xg1KGAh3bhBQUtwfdjKfjRbj2maEZE38tg5OGNKaoFElBmShje7oct1tEJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+59+v7KZIMLQL5I7qhy1h9s98WdekJLf1G7q4H9i3K4=;
 b=Cdys/fCjYeBnU1ELNlp3DT3uU8wOAUG2gjrZ6A52zAuUvYFFfjssyH166ahV4FLfqSJTUOBgZuED2j5Qlglr6T14HJmzwF0Q1Pupn8eFZq1aczWEJLU1G1IWY222X90AEJ5YTzJmn55PFFpP9oG1+s2p+3QqyuB8pgAEA/3Nk7pUu2mIzGx5kcF3X+w8dLwzIjEEcbLlqN+PvNx4uYD+cYmPFlkAKmZyXBwZEI1kI9lHO/JjBptI6JSRYUH8YikJPAu35D1MzCycijwj9tMHSgutWCeiHfEU/T1U4jeaUIDipsiw4eq2y/O6ZKtGif+FZblVJb0+r2oP01ivysvAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+59+v7KZIMLQL5I7qhy1h9s98WdekJLf1G7q4H9i3K4=;
 b=rOuKWDylwIVwSLnQdF0/eFREhRT1Eq8DWZZJi5PO7BtKlnidJKcI/pFQbEQSXQo74g7SH9qGTfXPAFSWGOqKK1snVz+JzPKchhKadsD4WN+uWqF3OxZ6m41kR38MibiDhniiiON5QoH5A/8E6AASAr4jRRDbXUcTKcqahReTAJ7pUpfEqKmKCciH+RfH/1EO532jbg7knRG8nXhvurJKeryQ7FpdWMQRHLy6V8z3maTqeLrC/iilGjpC83XmbDHx3vGvMXOjvWU6iFQq9uwPIbryAZfWqXTGrjG5/g4Ju6yR4ChzUMGj5mJLlKy5Ht9Kbte1/3OHmghTskfnRr4GLA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:33:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 16:33:14 +0000
Date:   Wed, 13 Oct 2021 13:33:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-next] IB/hfi1: Fix abba locking issue with
 sc_disable()
Message-ID: <20211013163313.GA3468235@nvidia.com>
References: <20211013141852.128104.2682.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013141852.128104.2682.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: BL0PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:208:35::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:33:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mahBp-00EYJn-1j; Wed, 13 Oct 2021 13:33:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23947df7-99c7-4798-7654-08d98e6726fe
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174A86AFCE23C771A5136D8C2B79@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7RrDFTa4YJ9kA44I3j/Ai7RLLaYWeAG9h81cHxfnNPWnHE3OHw4f7rJWJs4rhFp+T6RANtxVKbSFBKzITiuLXHiA2IgUkIjdfruclMkY0WpXI6mdU8tS//HpYjl+n38cnFfZuof3uNdW1va0l4xX5+oHOeDDG7TJUM2gPCosFSxVVGQTdTOnv2OCU8ktwVp/vqaD0rme4ho+IZOkanb4aKlTM+RXiq+FLcKcN/Zbavcl/3RsMviScncNcTNyJBGcZpBB+F7oTbkGJHhQ6N3NZ6yhae7ywzPZOSWGvLZGmNKhGo9Hv8VoU+ZL1tGdHpEocv3P9pBgbbTUWIY8cAzBtFfjuFRti7A5L4YvUYm+4lySBIOtX2M6eadEKD2zFr0ZeycnPSCPg8b2W+f/EJYM5EurdgkdoiEHM0JfViOeI3lzvaBr6YjvKWnv0eVimAkWd6gAsGC583SuY6mMm9cK8c8nmBvm/uSmAePDAZu9Oc2T3aK9M6edSdtbabjDiGd/lV81DuV8aJZprLrOYA9gVyyEyV5mDyaZhbNs1nqtLrZ6OFlwkzILFCEAQUbt7oZNO50NDKD2ltODZB6Jf/SBnjer2xDBV6c2R13yHbYeq61towY5vSvmO3MLVozaxI0l/9Vh1cuKdhpyJ6sw5Nefg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(6916009)(2616005)(66946007)(508600001)(38100700002)(83380400001)(86362001)(66476007)(66556008)(33656002)(426003)(8936002)(2906002)(5660300002)(186003)(1076003)(9746002)(316002)(4326008)(9786002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiC3Lo5lD/F4RNDs/EHPLoibkcvG+rDrGdx7dIeEuNE/pRVLWa7pngk4nbf/?=
 =?us-ascii?Q?OQL6LFiD4kjvWNbXU3M14r9bhbEM606Sks/h8H4jtVIBgd74Rubc/YGQPlzW?=
 =?us-ascii?Q?dqoC8pgYDIMkZiPB5zhLrniRNeWoftKgqGNeMqYi2QR8my4ylLvlnIejeBAI?=
 =?us-ascii?Q?SxybkgJS7H/0QW/rvFoYvrj/DXX9P6bUKjCT7vBELkq4/AqIHYjqInXXCzPq?=
 =?us-ascii?Q?h3YOnNs29Bm3/B6DfVFjPSKxpZ6yTC2GsyBc9FRfPBsEMCqw07Nr0YHo5Xvt?=
 =?us-ascii?Q?JKzJhM8jrosFndimC+mqjWYGS2hV7T5UEp+Xop5cAZBJX7ZqdEQEbUbxemar?=
 =?us-ascii?Q?AIgUTSrO3sTVFgNBaDMv5T5DST/d6DWFchF8CfwfZ2/L7V5IAOX4+wKlG7X3?=
 =?us-ascii?Q?iiVgZWW9zkgFVzLb4B8MML1bIhUSiT5J/Dc+4fpBevL/0xC0gybVvtmI1wd7?=
 =?us-ascii?Q?T6EU2xgWrMhmZOyQodeARFNhv0m835NBUnMZKvE9Q+dGxBA4y8PyDVRL1Afk?=
 =?us-ascii?Q?5J/+E2xieen4pmarXMHaRFtaTv3f6WnEDhFb4b09ruCQPcqzpO4RfVSFMXx6?=
 =?us-ascii?Q?Qe8EUKbjOdFWgxI7FUay0e/t8seI9oSM+bRUM6uO0mvem/GQyn1MysiwyuBD?=
 =?us-ascii?Q?wxD6VoFz/SqnsxZKZLadaZdfPjOaDl+y23AMfDyye7m5YG0hX+f0bQJQWSlc?=
 =?us-ascii?Q?v4jDqBvtjq2JBwS9xlPEvolJSTFz3wZVgwoicwWRkPtUDSUBaYBl5z7h4PfK?=
 =?us-ascii?Q?XUPhZ/MsbjAyDk3G1D5EsboGqD/JnmZe9tLdxrQOZWYW6C1nvmT3I4g6kBc/?=
 =?us-ascii?Q?G1mgziauJtBbk1s+nsX5aM5Uq/5Q4THdSsOECe0Cx8QJRHPNjIG+ejE2jqkx?=
 =?us-ascii?Q?GmJhfwgg6/C4CF3wjRxas7PM+vbeG4GMXB/EDwTwbn1uE7BeJmyrxpEqpf7e?=
 =?us-ascii?Q?m0HnjD7ZCRS1n3/vU9Tc095eEmATLk5tnY+CTX7EDc2OXZfWV7pIBN3FRV08?=
 =?us-ascii?Q?PSAi7f5HprfC/IGTTj6aPHTt6NfO6hGMbKttdY6oWJnuaMXVDJqWOD49ZHEB?=
 =?us-ascii?Q?O6fsRNKRfpP1xVtwx1MtQIlZC+lmfzMepBNz1IZyo6m+joB09eC5jqcldLWK?=
 =?us-ascii?Q?q4K5DalBK5JoxzqHrpo/HE/Aok8pPBEMyHjIoVG+5VHV4B+eC0tALSvJHQId?=
 =?us-ascii?Q?UgxyHr8FqCx1YW2Y/R+YRAwMnbGsmYzMRsXBetbhR2/PeNwt65w1T0cjzADF?=
 =?us-ascii?Q?ayHl3A4yXuXDPiTpRy1YWPR+1lVXyI0OAdDpzMHeVsqyI5N750flapcdKDHs?=
 =?us-ascii?Q?8D5oYFV0JYd6IgeR1QjiPCWJaPqyu44bBA+VYzL/n9IyIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23947df7-99c7-4798-7654-08d98e6726fe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:33:14.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtc2VK+QI+rBkz5ZtrApUcYazp5QM1pZYbXkuTwE01WFAnLnMTsXwo/fgMc4mJNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 10:18:52AM -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> sc_disable() after having disabled the send context wakes up
> any waiters by calling hfi1_qp_wakeup() while holding the
> waitlock for the sc.
> 
> This is contrary to the model for all other calls to hfi1_qp_wakeup()
> where the waitlock is dropped and a local is used to drive calls
> to hfi1_qp_wakeup().
> 
> Fix by moving the sc->piowait into a local list and driving the wakeup
> calls from the list.
> 
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>  drivers/infiniband/hw/hfi1/pio.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
> index 489b436..3d42bd2 100644
> +++ b/drivers/infiniband/hw/hfi1/pio.c
> @@ -878,6 +878,7 @@ void sc_disable(struct send_context *sc)
>  {
>  	u64 reg;
>  	struct pio_buf *pbuf;
> +	LIST_HEAD(wake_list);
>  
>  	if (!sc)
>  		return;
> @@ -912,19 +913,21 @@ void sc_disable(struct send_context *sc)
>  	spin_unlock(&sc->release_lock);
>  
>  	write_seqlock(&sc->waitlock);
> -	while (!list_empty(&sc->piowait)) {
> +	if (!list_empty(&sc->piowait))
> +		list_move(&sc->piowait, &wake_list);
> +	write_sequnlock(&sc->waitlock);
> +	while (!list_empty(&wake_list)) {
>  		struct iowait *wait;
>  		struct rvt_qp *qp;
>  		struct hfi1_qp_priv *priv;
>  
> -		wait = list_first_entry(&sc->piowait, struct iowait, list);
> +		wait = list_first_entry(&wake_list, struct iowait, list);
>  		qp = iowait_to_qp(wait);
>  		priv = qp->priv;
>  		list_del_init(&priv->s_iowait.list);
>  		priv->s_iowait.lock = NULL;
>  		hfi1_qp_wakeup(qp, RVT_S_WAIT_PIO | HFI1_S_WAIT_PIO_DRAIN);
>  	}
> -	write_sequnlock(&sc->waitlock);

clangd tells me there is no read side to this seqlock? Why is it a
seqlock if everything is a write side? Indeed I was wondering because
I don't know of any seq lock safe algorithm for list manipulation -
but it turns out this is just an obfuscated spinlock. Please send a
patch to fix it.

Applied to for-rc

Thanks,
Jason
