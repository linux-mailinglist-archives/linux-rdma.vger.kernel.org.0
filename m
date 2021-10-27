Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBA43CF4F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbhJ0RDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 13:03:32 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:43745
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233416AbhJ0RDa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 13:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpyIGuYG7vrciB9rWGdixg78c+3QUJfjNCs+HPCN+ESrk943GErM9QLmvB8RzaMwv5+uYNP9w2HTZ03XTSxg6PdQTsFLPUnXPkyd0xV+i8TVhwQsI2VQCxfi/6JtL0EfNCtYUo02Gi2UeZraYB99izZzpYg0v2mWFvu3eKYeCqn5YVYXDHCITsP9Fyl8WHEDwzZ6eERJ3GKFocR7wpMsySIm3jZRBebuMTSeLihovldolMT3OrXTYanz8g5KSwqiaMRb4FZE+XEFJjECyjOR1sBI4eMSqkA3vr51JuU06hTqn8xcGr9iza7pejtR8Zq5LMLjqrPKTlkHkZ5lU+5i3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2kIGlYvuhd8YYMDIZYHPntDKhicN1aS7I8kn6G4Tpo=;
 b=bu+rPHbD5hdd4C4ssqPxviTluCmx4Up8AudgyZ6Ehz7xhmlogfIPKy8YEzve4envr+Q/ZI2KLH0PqBwEG9LLEVT+6kjtVf6UpCKNRX6yBfqp/T/KNzCtbD3uXBt+v5iLofyZeuPYm6U3W7vclajZkbCon30MWjWsojggs/UhLRbK1o+Q9vIbtCRaZXLMEaTP3n3LLnkwRetKedbgjoHz1hJiRn9+51LTITnf0lqkTLOX/U+EassZHbMqLbDfn3nhf1pJXf/vDJpRbXLkeNDBoqP7CT8JYUiAkqsYGCsmqJAXtjnGWtRfHTnT3sVtz6gKk84sMDTVYYU37Lovfv4Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2kIGlYvuhd8YYMDIZYHPntDKhicN1aS7I8kn6G4Tpo=;
 b=fAqqqgJzapAboiX+7EpDZNYd0HKDY+8kP2okKwZ48YTAbyEFK5LXhgR9oCuGD8AQ+bHG3RPUp9/JFB6nB1b4LDe9gySCAOHzhCX4r3t3Y8yQBaeQU/y0+fQ6qLD8cu357Tnx6N7Rqf4DRS9MX14an2q/w3lhPVwxSfhw0udLUx7MNfp/sW82S6I6nQ34UKHqWdZekHvrZt7LD8etK5QqOuyTr7isoNT4TdBeFrQgcXa1bEZtGv+hcKJLdijjKuYZiw7tIA7DIP5H5YdzB2ni/7aLRLBcWBfXpFrZpwrAhMh5WNoWxFLnQ5j6YvK/+fmhpuTsRt7Pj2PxIxFYlkls/Q==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 17:01:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 17:01:01 +0000
Date:   Wed, 27 Oct 2021 14:00:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kheib@redhat.com>
Cc:     Alok Prasad <palok@marvell.com>, michal.kalderon@marvell.com,
        ariel.elior@marvell.com, linux-rdma@vger.kernel.org,
        smalin@marvell.com, aelior@marvell.com, alok.prasad7@gmail.com,
        Michal Kalderon <mkalderon@marvell.com>, dledford@redhat.com
Subject: Re: [v2,for-rc] RDMA/qedr: qedr crash while running rdma-tool
Message-ID: <20211027170059.GA644717@nvidia.com>
References: <20211023164557.7921-1-palok@marvell.com>
 <1871141c-2af4-5959-4c1a-1a7c9df73598@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1871141c-2af4-5959-4c1a-1a7c9df73598@redhat.com>
X-ClientProxiedBy: CH0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:610:e5::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 17:01:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfmIN-002hjg-NX; Wed, 27 Oct 2021 14:00:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d9ae868-3ec4-4ec6-2eb4-08d9996b5ae8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350DC53E1310E670D686279C2859@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvr3969LsSnRv1supbDspGvkhhmOrnGrHLsGFXHxFuhRjfyGy9tPXVM5JOjSBtKeNbhv7n77YGQI849TDTw9EYXuvAVecrQDBQOntQQKp12nRlGY+NM4e4AXsuDBKjgdq8IGZtk7grpJlIeXumpXqZvdkTiQuihWHuw89kqsvbbidzblnK4DG9XR0EWMRLtWvLUwF2H8MDa9yYXjRqgutZ3+t5DrDP/ZHqzmVMWWFyxL8hE/Aoz5E5gInZXEdS9rRB+MyvD4tS86c2mZ6QVpNbFOaMByutAG0D7Bw0LGpJE4g6ZCJM9TcH3VqLDjvVBIShwK9Yv0Ji5dwdqC4poXp0U3pciJ3wHLY/HNdA4wLruVIOTegxtnc7xhGda7uR4px/BgbLM9qYRYbpneGMJANn5VWAsSYa2IHkA7a/3b6uvbWr2reDDALCDkWkUfcICuJAzdNjaEMxz15my1/ZBuXpjlkj1BE6qZGwjNDb6l3AgIpBM6/A2VgN5MhgA4CpbDJrI1+YgKfHUWFNZve+ZgR4JEKWfFkhTTiPxDq/7jS6S5X2hxXonSwm31wol2t1txGi1o0rRe5z2W/bZtibJqE34eE+CrPRz/L2OVSNCn20AQDHhEDleZnxcFYEKfunwJ8ChfEyZHqOh3lbSm4mKLU/Gys0xwP7URa1SqKyVmuHPhoIgf93diDcoj8t9DTa2D0MZRxuZfqYicevvw6/DJAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(186003)(26005)(5660300002)(54906003)(33656002)(1076003)(2906002)(86362001)(36756003)(6916009)(508600001)(7416002)(4326008)(8936002)(4744005)(66946007)(2616005)(426003)(9746002)(8676002)(66476007)(38100700002)(9786002)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSFQHQc7aQpYMmhbcWtXOran+T3QMbD/wgFXtCVLkrjKZuhhxnyr52Iy2W1A?=
 =?us-ascii?Q?8d03tlL9UK99f14cS8JLfj6S1cnyTxy2Vd7ywmVoNKWMPR3QtOAnXaIAar1J?=
 =?us-ascii?Q?FTgbiQKi+pEEreWWq6Dhs+TtzFOtriWpMIDmOjZqyaPpfYsKJKkx1JAGZWZC?=
 =?us-ascii?Q?LCZ4IKPIu9YFl/6hqrPllSpRB7tGoCCUfUXeQeA+ZXQRaKEfd9NwKdgYUOPY?=
 =?us-ascii?Q?5rmcHYqV56Hc3PYJB2pJ3QCqZ5YGnwLu7HNcpuMkaFYG2FRyDvqIkTIIfDli?=
 =?us-ascii?Q?Hp//aO1RnHAMHiJOP3MoIx9P0xpEtiinpH9ePkcyUeSf6W9qRZL52TyrCqQ2?=
 =?us-ascii?Q?W/kmciRDqxFL4AB7UPTXOflVe9zosx0XODcx03d2AXRT8JZvRbz3DvGpapvA?=
 =?us-ascii?Q?iSkTfvYom039fQcvF2r7eY2p1+KZdNOBwL6gG48Jc+4D03a/uefMzLr43EMh?=
 =?us-ascii?Q?y+Ld/ZfSu/Tq7dq9Vv1WnoNuc+AA2k2r2uSzNQdzYdMOZD8ds8OjezJaQNgB?=
 =?us-ascii?Q?5QPoD779GO3A8NvQVZxSbyKLieZCx6Tx8OdzESXPz/spLqxanxk6UVgv763H?=
 =?us-ascii?Q?KQS0jiJ4FlAExAtUf2jb0WM1Wkpip1793gsewRJ2cfKPy+3AJiiF1r1xTKBc?=
 =?us-ascii?Q?1o1LuUh9dvNTFFM017A5sck2s+VXfBMGkVdblpRV1YSW5jTLa/FYXkEu6eNM?=
 =?us-ascii?Q?XlCrVz/NENYx3PV99yv97Nxzvp6xptQmorRWEwuj/ILxBEcvs5LIAhWJuYqK?=
 =?us-ascii?Q?ZBejEHpK8wgcWI/saaAHm+22E+WLkk5FF87xlJdH/+Ff9klEG6RBRZNu7Cns?=
 =?us-ascii?Q?WLUO3AudX3LisnNGVtJnK/dXzkADH39vi/BTgk6IwltdY9VzIlFmSFCHWPtF?=
 =?us-ascii?Q?bbzf1P0VdgWfpj4XV4Ik+iaS8vFGNtges5jBo6HIp3grAlpsKBghOs4DMvpl?=
 =?us-ascii?Q?3gc7e/8dLwV1TpqmWjM+a//c24c1TcmrZGUJ/M8JChNgLc08qkhhiIBsWCVg?=
 =?us-ascii?Q?fzdRgJSQOwSbcRzL97OlFCfTU7HEQ88ZZTW5hLaYQSpHdVqa/NogwcgCi0iH?=
 =?us-ascii?Q?TvH/WlPdl2CILu0y27Huf+LtJxw+fg116EInNRO9V0rgvSE+/HxlT5lehoK7?=
 =?us-ascii?Q?ONMz9+qLICc8DPXzeu//CMseuSbFNAqTIW/UB88RYNiVh2iOBWI0KUhnPndy?=
 =?us-ascii?Q?W6WPh/xAm1WNKQhcBT7nCRiQ62m4BeL7HTVBSjUscnMaiJCyZUBKK2XXxZlr?=
 =?us-ascii?Q?RXIVfALgPuX+dnZWmk+GFq0MshUIF0V2UJmruyRt8+51Z6jq+meiSgsOlDZU?=
 =?us-ascii?Q?gL7y6DVJ30sDZi6UvOzb16hoOD3twzyt6SOAxymL1al2WsWpMJvMpRipSVeN?=
 =?us-ascii?Q?w0mleHpLSeT1E4mCkEyOUNbKS1Z3x5+4Qhdkv8R2Y6wTj+tXeO0FqdnJr5l9?=
 =?us-ascii?Q?fJ7Wai75yB8byOJN8OevnEppzPHX3wIxjM6AJ3DYlO4pTZ/IBIrbOWtFzC40?=
 =?us-ascii?Q?KWFw49Hx+lYUOrjgdv6Wt3+f/zIgXCPCjjnt8Y5fbjpwt/DfYE6hf7CD2Epb?=
 =?us-ascii?Q?B4fg/lG2XkynLJrk8og=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9ae868-3ec4-4ec6-2eb4-08d9996b5ae8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 17:01:01.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYB58sLkSm2RwPG+GW1jriluXl422e5mCJh0TP8noDHC3+fOfnIEmjTijpgfx/zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 24, 2021 at 01:46:03PM +0300, Kamal Heib wrote:

> > diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> > index dcb3653db72d..85baa4f730df 100644
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -2744,15 +2744,20 @@ int qedr_query_qp(struct ib_qp *ibqp,
> >   	int rc = 0;
> >   	memset(&params, 0, sizeof(params));
> > +	memset(qp_attr, 0, sizeof(*qp_attr));
> > +	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
> > -	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
> > +	if (qp->qed_qp)
> 
> I suggest to use "if (qp->qp_type != IB_QPT_GSI)" to match the handling of
> GSI QPs in the QEDR driver.

Alok? Time is closing to get this in before the merge window.

Jason
