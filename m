Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C0173A91
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1PCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:02:52 -0500
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:6084
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbgB1PCw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Feb 2020 10:02:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEPReQIhT7GqJDw6cEuG+3UMkP9X1SJjx18OE3d4dXYE6nXYjbcua2Hc1o4D71wFSw0Rr3B2E/iym5PwOyhNDhaYY5tD2FmzE5flT5dpgllgCHT4glnpasNPaEythnqAaqhQJbii5+VQAQXvzed1UzuMYnUYi3yinHx5SagTgwlCHvyblUaYRh9JpImLumT7ZdWaphrqKDOKZvdx0o6AxF469SdV/H/Mi0IPlt7yDbHCD1eCGsJeFKlajs+u/x8im1vkMAzIbrkstMoV73yqA0/Ps0ZYorEDuFlqtcZt/lE6ebYHbVlD+1FU/hieiUyy01/KJuGtnY7dhMZYsp/1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UUDmXb4nX0D8w2C05HSq/aXiKm+Ap2XWN1NzvZdr3c=;
 b=dIS9Ll7csBi+jw0IXNw2QRf3mY01kt8cDJZ56mKthQHsRi0G6fNRBUVR5FpWVaGaeUG0jjV2Z8OP5sAwiv1S9+juLDbJTgw+grbhoFavLfQjQI1zICyqhVpMTNYldXr3vbfbeNwIpIZc1h8XEq8maAI/xKcD3g5gK66DW/phCG0NmpAaW0a8kL05PYG5fisQnQAN4U+7wfWxNDpHJUNYnpYWZQoGCGDG/r98Q0PkHhJlLAt6P6NgqIbkOm4lDi9Vm5PE697+Uu3Q/6vGwcdmP/pXrpRZivYsYY4WPbahQ/lm6/r0x5fhcr4hoL/m25rd35amnvizkZ1GC+0KXJRtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UUDmXb4nX0D8w2C05HSq/aXiKm+Ap2XWN1NzvZdr3c=;
 b=WY1Htwsern5nmLA6wecPTMJ5JaBCQyqMkd1OxFfAokvqam30aT7rOlAOZQbE1/I+EMy/yczH7eX4pxpK503vVZU3PuPUeX100M7uLFtXKYlO+YErBtBPwxmPo5GrKxsMcWHHFM384pgi/Zn4Tc82ylPKpMC6dwhoraFzUfI6CEQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB7120.eurprd05.prod.outlook.com (20.181.33.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 28 Feb 2020 15:02:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 15:02:48 +0000
Date:   Fri, 28 Feb 2020 11:02:44 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Message-ID: <20200228150244.GT26318@mellanox.com>
References: <20200227125728.100551-1-leon@kernel.org>
 <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
 <20200227190126.GO12414@unreal>
 <MWHPR1101MB227182E4E00015AD2850AFF486EB0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1101MB227182E4E00015AD2850AFF486EB0@MWHPR1101MB2271.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.10 via Frontend Transport; Fri, 28 Feb 2020 15:02:48 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j7hA4-00039z-Qv; Fri, 28 Feb 2020 11:02:44 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b0d3b41-a75a-4f78-f957-08d7bc5f463f
X-MS-TrafficTypeDiagnostic: VI1PR05MB7120:|VI1PR05MB7120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB7120463B04FFA721AE36BBD1CFE80@VI1PR05MB7120.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(6916009)(2616005)(81156014)(81166006)(5660300002)(33656002)(66946007)(66476007)(26005)(4326008)(36756003)(52116002)(8676002)(186003)(86362001)(1076003)(66556008)(478600001)(9786002)(9746002)(2906002)(54906003)(8936002)(316002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB7120;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Vm8/zhVZMfMyVhSI0gWhJjSEw6/9DVtuwhYMZZQbvl7zk1weXoEYViTRZnSO0/kZVjjxQ08XMLIJMBvuv0rCTABamlUXvIT2jTt031iIqEp4Q5oG6LXJ/uXEI8qFSkCPM39VoVVsZqt9fchui4RwNGlb5Wu9IFhKFtifa1QDTPQtOUhG6tYNns6FuLeHOLGF50C8Jk3xQm/Rtks3VLhw24KvScNc9R3cE/sCwY4RyEsN88c7IK4VTFlmO2ChbuSeIjS/TNZquIFNUOGvrpgcaawvhxep0Fr4FOYeUMoIGF+IVJ56XcJrfjGrW8/szcUuCEgnaakE9Zv+YpyD81Ej1qCMQyIhdopyE9SZ7HsbbpF0KnzPCnCtFxXbj9ue3Z5Fq7kY+q3tejqQRVw2bFG+rH9rrmh6DjsgMk/z9p8x1tTUOdx3Fups7kGVs2h/NsocpheBCT5rAgdHyEX5NK9X0gKFsdDqnkj3SHlRGfqNyQxcVuxAqSKNg4djg3lTv98
X-MS-Exchange-AntiSpam-MessageData: EoUxa+vGOt1db+TmtRx0/2BDOi48Y4X1KoNgVLxDz81B2nk2wEfSni2MB0zzIxl6sPXkt0Leb6kIKs0AJzIlS0W2BHgjrFiutr+fhTB59IIOUiUCz7XNq550ltmCpMogmrmRH8Q+aqZKqGgXLf5rSA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0d3b41-a75a-4f78-f957-08d7bc5f463f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 15:02:48.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jbl72JbW6omMN2fn4EDI5NPHp1rDcxucoeCKffGhH63uv4r3xWKTlm3R1VTOffq3d/lFa/HO73hGYNtwLJbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7120
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 10:49:45PM +0000, Marciniszyn, Mike wrote:
> > On Thu, Feb 27, 2020 at 02:07:10PM +0000, Marciniszyn, Mike wrote:
> > > >
> > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > >
> > > > When port is part of the modify mask, then we should take
> > > > it from the qp_attr and not from the old pps. Same for PKEY.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in
> > > > get_pkey_idx_qp_list")
> > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >  drivers/infiniband/core/security.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/security.c
> > > > b/drivers/infiniband/core/security.c
> > > > index b9a36ea244d4..2d5608315dc8 100644
> > > > +++ b/drivers/infiniband/core/security.c
> > > > @@ -340,11 +340,15 @@ static struct ib_ports_pkeys
> > *get_new_pps(const
> > > > struct ib_qp *qp,
> > > >  		return NULL;
> > > >
> > > >  	if (qp_attr_mask & IB_QP_PORT)
> > > > -		new_pps->main.port_num =
> > > > -			(qp_pps) ? qp_pps->main.port_num : qp_attr-
> > > > >port_num;
> > > > +		new_pps->main.port_num = qp_attr->port_num;
> > > > +	else if (qp_pps)
> > > > +		new_pps->main.port_num = qp_pps->main.port_num;
> > > > +
> > > >  	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> > > > -		new_pps->main.pkey_index = (qp_pps) ? qp_pps-
> > > > >main.pkey_index :
> > > > -						      qp_attr->pkey_index;
> > > > +		new_pps->main.pkey_index = qp_attr->pkey_index;
> > > > +	else if (qp_pps)
> > > > +		new_pps->main.pkey_index = qp_pps->main.pkey_index;
> > > > +
> > > >  	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask &
> > > > IB_QP_PORT))
> > > >  		new_pps->main.state = IB_PORT_PKEY_VALID;
> > > >
> > >
> > > I agree with this aspect of the patch and it does fix the panic, because the
> > correct unit
> > > is gotten from qp_pps.
> > >
> > > My issue is that the new_pps->main.state will come back as 0, and the
> > insert routine will drop any new pkey index update.
> > >
> > > The sequence I'm concerned about is:
> > >
> > > 0x71 attr mask with both pkey index and port.
> > >
> > > A ulp decides to change the pkey index and does an 0x51 modify without
> > setting the unit.
> > >
> > > I see new_pps->main.state being returned as 0 and port_pkey_list_insert()
> > will early out.
> > 
> > I see, maybe we can store the main.state in qps and restore it from there?
> > 
> 
> I don't think we need to go that far.
> 
> I think all we need to do is 
> 
> 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
> 		new_pps->main.state = IB_PORT_PKEY_VALID;
> 	 else if ((qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
>                              /*
> 		 * one of the attributes modified and already copied above.
> 		 *
> 		 * correct the state based on qp_pps state
> 		 */
> 		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
> 			new_pps->main.state = IB_PORT_PKEY_VALID;
> 	}
> 
> I'm ok will a follow-up patch after Maor's patch to fix remaining issues.

Are you then OK with the patch Maor posted? Please add a tag. I'm
waiting for you :)

Jason
