Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05307810B2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378527AbjHRQnd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378756AbjHRQnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 12:43:14 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5D44BC;
        Fri, 18 Aug 2023 09:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAbdpzClXVLNTORxZHPOh/az5REhQWW+JMD7ym5dHZ7W5OKcKayqEXrAVtn81LSVFmHNCXcWpS40Zzs5r3TLNDIh8c5GdIKrfLLLi/1cx5qwBAP+o0oQupL1XmSb4dR4OM0r2YZARPNlTLnpY7sNELNs4TsDQpLGr67fOAqFt858SvIzRFt/BY7pYY/G8Ki2wEJmzr+hAc4nC4xHJG0r+ecAmJrE3Eg93UR91mgVlEVvZVrj7PrF+yfLsoEpfOQK4G8/fctRj+1aUKL6M7bBI2GNGKGh9YvTg9gWHis/oLQ7I/Oyu29Evemyq+I0clheZZc4f83Y3dWMAq56htVCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUGhKfKgncdauN0m2mh6/kmGc8GQiq4LdVKKLwI0Jlw=;
 b=IYVCgncxgUv6OOs9R+LxZ5BgYfq9NOLi5cT4F+m5Xe9M7EQ9HQjp4/zkxlB+kWbxoEveiPL9tYQWORa2+IpmG4eCqWPz9HkSDpz3jUARTpDhPaak71O6Kzi1hhRMC5GYd8aKHBBCaR5JgUo2SqnY7QEQsuqnmv/wP9TnkR/VLmp7KWA6MX4lgiXNGhl5mRQB+Z2UaDdnpSVtBzqcd9wuy8hepah8cSTtYJQ7F+fHm+XADXFDx+5BAzHcuWhjpNFSRpiX0IMgXYLpgAc64c2Jb5BkJ4Rrv7ut6RCD8/PKjQrG5juG89Vfg9CiNXFGZkLztdAUQuZPgX5Z+ESsesl/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUGhKfKgncdauN0m2mh6/kmGc8GQiq4LdVKKLwI0Jlw=;
 b=ft/j57qmUxe0zSHGdsRyKP8zwOgdQTgsgQtdyf2Jrnm0EyjWc97tnrPhAlduqrAFYoj/K8Z0xj95Cm8x42B8IyYRonO6rgADLqoeYK2Gimcy9uFai1k6HftRjSVF327aXHmpWw0fAAvniTti55sGD+/0sOPPQRychj9cIIp8AwwrXuyCNXcnAKRuFMumy1e3UhbBb88U2uDp5Aax5nLIQrx/NkEUSjE7ubcdmv7FrWJiwAb2urCk4tVwnb6Ic4BYs+h4GoqB+MWxllaJVq9XVqBmCugVW2wF2HfFCQftYc1TYclIt9iix1/B6jaEqhobRzRtVEu4a+7yBX6S8dJs+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:42:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:42:32 +0000
Date:   Fri, 18 Aug 2023 13:42:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device
 is lagged
Message-ID: <ZN+fdgo4givpj12R@nvidia.com>
References: <cover.1692168533.git.leon@kernel.org>
 <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
 <ZN+dX1hkUbEIHid4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+dX1hkUbEIHid4@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e7b112-78a5-4f37-f61e-08dba00a1e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsLtDqD7CxoYo6G6Vs6gt6FKOFY8UGTxyHFNTggIyzeVlHDSR1CcA3lXt7Bdgj96348wGEdz60fmjlnNoesMMvF8FaYLcUvuXQEYTQejKTnTvF/e9mWU08dWxQLSjuTxPxG3bUrRi9G/3m9JmiQtYHKHsTxOFqk4t9HzZe5hxpUBm4ypcBXJQRBdhKfwqB2x9TUTatFM7Vv0Zf8M35seuBWLMthfIMEVMhDuALWID3DNb8BfdDDDvccqYMBIXRZbFX5VPgRMuSqNBKfwnRUFHvjs5VeKtSiG3MQUyQ+u2vR6M35odWt1VwE+3lKEwuxSEo8QMZmR6eF7qwaV20Sp8JoALdF1Ogcq0t8BBl9EQ4MILMGBmICv0zdemqE1C7OiPSVqURcrpfknVsT+Q7MY/8r53PvwcUsX3fpeY2Uts/eXUcEoibMCQI6WEEn9SVSCLubdfJVI1m0fgP22GHeIXh5CAPl70Yus05hbwZd8StcXkF+nVzEXZB92hI2fSblDP2N6u3v/oqwJ5T3ZRzcQWJpeF2t5dITRS4+B+27M0Db8tuXg/haUWnaaH9fX+eCuo1mgSjTKNQLYhyIuahwjjOsCL17jZdxNGm62BDJL7Zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(2616005)(107886003)(6486002)(26005)(6512007)(6506007)(83380400001)(5660300002)(4326008)(8936002)(8676002)(2906002)(478600001)(41300700001)(54906003)(66476007)(66556008)(316002)(6916009)(66946007)(38100700002)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?39xTEAOKjVlLm4brY8dwRePUKNr1V7X+MxeyqGxxCcrEreB2vgLA2XBJltiW?=
 =?us-ascii?Q?TbSkKFkeTewb/LSIxCW7DLxzG8J9l4R7yJQ2rznllKumGSo2mIl0hUpiqEIn?=
 =?us-ascii?Q?yHdzCzTxa6FqAkwwsA0eiVahq+Ps//oCarkwa1pu0Kine2OGk8Fe6wLpwHIp?=
 =?us-ascii?Q?TU+odQBKS0iFVlWDCifm1GxrK7TI0j+zYbC8uBbs31dSbA6xaixHn5Ha5hjJ?=
 =?us-ascii?Q?+RO2SUK+5XU3cOyyZ/0ZkL2oVGtoZW+p73DvbHT745poGyz+Q1rbfffQ6XZe?=
 =?us-ascii?Q?GnjGrlbsO/OXLvP+oVMqE7IKAYAY9qhK4t2VNFt5AG4VmkmnqveZrC30xsMa?=
 =?us-ascii?Q?xrienjz6RfTkni8f5AKwN8VLRml/OP9swzXIgCBJNjG9AafJYLaY5nCcG2P4?=
 =?us-ascii?Q?mz6WQ/N2zO8+b8Ifw4DSBnymG49VUJOrMdAQ8BSj1en+I4VisukZV/wOHMT0?=
 =?us-ascii?Q?Kjf+lW2TKTwFOSIdB4GKsPkdHRBwpIcvW49RYXZPSqv+J/0sfds02aIgSQN9?=
 =?us-ascii?Q?DecEJLQ6odVqy3qrUz5AUszdXRKs3qxeigJ6g+MuhTH8E8Sh7gT8Cz3qvrpS?=
 =?us-ascii?Q?vCr06q3ZhjbRQFDuFVRPvxBOMtexFvdiDfiac1jLlZiQ8x2BS+epxkZlXOqZ?=
 =?us-ascii?Q?qTnPptIUIL+J17kUp0TuwIx1n4n04AU9PIIiySkOWmkebE9eQ3UwZq6Yzr5D?=
 =?us-ascii?Q?8GpIM1qAz0hf4U7dRqhsLr+YSc/VxKeozt7xsNXyfpLINnsfiTXh8fTj/k1Z?=
 =?us-ascii?Q?L5Sl6F6/oo4eDVOi3n+tKCTTMYvJJm1qCgTh/M4Vz4Iz4DrzwU4OtRch7z+4?=
 =?us-ascii?Q?TssotFW6Nhu8SAkfoeL0C/MJgJYtJpC1rQgG8S5VwBkiVCLMuGLPxBvxXknV?=
 =?us-ascii?Q?hrpesIltND0d8ebJHJPBjkO3qljyOuJ1870QKRFaNLBtRhhXxwaBxFCeJkRz?=
 =?us-ascii?Q?FWxy898kLgaU8eXs1mNJm3N5TNPXabF0eIwGmGzbESAWpAQXvT3fSoBwaquR?=
 =?us-ascii?Q?x/t6qMpkYLTmvuTuGpCXQfjoJKWbTOrv4gnAoyfQ5Pt7J3YwcU8joS+eJ8v6?=
 =?us-ascii?Q?7kmYBLSo8w5WpHejeQkwrQON/RKXLNF1RDe7a5IJscluwYAxuHNwQ+4HxsGt?=
 =?us-ascii?Q?Kwd78hJlRLoplNlH9T28Y6rPeI8mGGOIQjly78Uv3L4+IG61BEevC+bWUjqt?=
 =?us-ascii?Q?rpPID/eIkpzmelMnycd0bkpswswoHn6MFREE4BdR8D9z/gtnqo6wPqtFY9cZ?=
 =?us-ascii?Q?0V38MaMEoGhZPRytUH3LOdm8dq5K+17PGKuJpCGtQkoBdQryGYrit4JIQgjP?=
 =?us-ascii?Q?bV0stND3nuSmm8KHL7QZG6sFN4BlFT1nJ1STHepsIgYaHEMEtfoZhbLQT3dY?=
 =?us-ascii?Q?YTdB+hQBtgt+Hru/8f3Gh/mV7BJ8a9bH0pXggJ9NNLMsyeBFZwMocP5ptDI1?=
 =?us-ascii?Q?c4EjhBD67N2c/AfDfE7HLf1YpDrkiD/SsUBPHjXMDCZbB9tnjMem9wiQEnNP?=
 =?us-ascii?Q?YVJ2n9L6pPVjQJUnSvhvA3nBo4ROqhCNu0VJbquOnGXCtKVmAZpC7sE45VEc?=
 =?us-ascii?Q?vsuaSZnZBiKePHbiEl6BPYDApwgogRHMpwUxkNNs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e7b112-78a5-4f37-f61e-08dba00a1e21
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:42:31.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QEtvOtkKv9wqZfU+rL94kCOGLMG+Ms7GqVayjkt7XTPPTifhKjByCqjMb6UQYdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 18, 2023 at 01:33:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 09:52:23AM +0300, Leon Romanovsky wrote:
> > From: Mark Bloch <mbloch@nvidia.com>
> > 
> > If the RDMA device isn't in LAG mode there is no need
> > to try to get the upper device.
> > 
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index f0b394ed7452..215d7b0add8f 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
> >  	case NETDEV_CHANGE:
> >  	case NETDEV_UP:
> >  	case NETDEV_DOWN: {
> > -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
> >  		struct net_device *upper = NULL;
> >  
> > -		if (lag_ndev) {
> > -			upper = netdev_master_upper_dev_get(lag_ndev);
> > -			dev_put(lag_ndev);
> > +		if (ibdev->lag_active) {
> 
> Needs locking to read lag_active

Specifically the use of the bitfield looks messed up.. If lag_active
and some others were set only during probe it could be OK.

But mixing other stuff that is being written concurrently is not OK to
do like this. (eg ib_active via a mlx5 notifier)

Jason
