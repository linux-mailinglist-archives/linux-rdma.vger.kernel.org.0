Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECB26E475
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIQSta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 14:49:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45805 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgIQQdG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 12:33:06 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f638fb80001>; Fri, 18 Sep 2020 00:32:56 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 09:32:56 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 17 Sep 2020 09:32:56 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 16:32:56 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 16:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTWBEi5dXH5iwtnlCwDJlcj58yhCTa2x6jBZcQTYCzQnJBK74TmcB4RQvQ1ptwd3SWW/oZNmsPRuIMPfiwtLfukw9TsxVidx8PwROfoeQaFf7BAuwlY2qPshc8NhVh+mzG7RavII+c2xTy//sJpJwAmxwbAjraT7uBC3eVjzqdwfs1le2NjvlBsSyaLV4YfgKq9A5IO3xyeGCAcdM1K8aufTQVqQSjHVBVf9HVJlXFPY7Ui+fHH9sPkiyRM2xV4VVDyaGjGG0/1rMTjgR+GS8qGtaQWQ0D3pd3bbOVevOXhBDjGX1ZPGMk6kpEz1Sv0RMmBAIO30oZXgfW0QpSQOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgiUxxP/raxSyWS4v/ZLSBF2f+FIGZ8VJBIk40JPaPA=;
 b=Mh2cARzqhaLDiT87DNZ+iOnt4V0MeISO7+301gAw6rXn6jEY82HRerhpadI+T9YSoVTJkZB5B9oYK1F6dKQg1A4m63YEpzQ+3tuC7UlzQCOwAKnKph18HxdbVF/aRiGESIfEl3FVBKBU2MVeBJzxEOGw43vd5qF9qMaHMD5lOlvZ4G7YEGXro5VtH6VDp6jq71QYrvsXsCY53wrJjiL8R6pUEFLF7lpQ6bgkq35cj8S2zn1hgoIe2IgVcsy9vpf0m3ykpkVmYVWOsx7zXFMIQCEnZFQTGB+a3gz7wtjQKm4oPSIaFnXvFwmuLm0jFPRIR0NK0EQGJlw1NMe0vKUKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 16:32:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 16:32:54 +0000
Date:   Thu, 17 Sep 2020 13:32:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 01/14] RDMA/cma: Delete from restrack DB
 after successful destroy
Message-ID: <20200917163252.GR3699@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-2-leon@kernel.org>
 <20200917120636.GA103244@nvidia.com> <20200917161950.GF869610@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917161950.GF869610@unreal>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 16:32:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIwq4-000Woa-Tr; Thu, 17 Sep 2020 13:32:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a42d0c89-6711-4dd4-653c-08d85b2753b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4356BC4CE63B1AD5816B7E1EC23E0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIEUpwsjbgjfzGk3AIeYE+As5MTZycFDQnYzd9VLZyC4OX8l4zfRYqXjU0Mv/DwyLQn0KMSTRaX3aRx9Le1hLs/+7Xh6/Xsi3dfBEKKYWs29K5J/g4iS21MXSkNZDe+tBSfMP+fLexZw67mDkBVxkdsrClmOI5NgKMmwAVeX3GHN1rvN/XhxzA+eeoDl+G5xdif4To3TaVmQw3mR0zpIxHBy8M6AGZH+5byD6YaW2iFPPtDf8k5FiDryPm+LQc8c5WQO+nmM5tTp6JFwn+0x+Xme70vLwuSGZ1NMiCFkBWKryMo5FmzPuOI7WQbVoT+TZgIOVgY0RXofKYwFOhNMjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(26005)(8936002)(66946007)(4326008)(36756003)(86362001)(478600001)(2616005)(83380400001)(9786002)(6916009)(2906002)(9746002)(186003)(66556008)(66476007)(316002)(5660300002)(33656002)(426003)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qGNlgx66M9MehDv1t+Jt4bDbTGTLFvl6vivDGoLqZ18h3V2I5st1DUk78yJEPRoP3Hdv+Oh1Olos4kCHDx8EtnAqRHBSuPSH1IyLxzN78uERRofhTClu38Lzj6r5NUzlhg+EYWLEFShFOb6n8CFvdUtbFtePyDPNJTlh9h2NIYw36F+qqAjZDMicncMD/7Urw9d1xijb7Zru23UZVn1lZRnNWqj4zAsZn2RBMQv9nfauh3CDcJfCUHQwNWvvpZBzblCwE5Eayz5GX3ydF8tYmrw4mvCjsK62xm4KH1VGHgb5LD+BY9DlEnUqv081sIBbgJUYz/c/vjsY1hNZIXdnzlpS82relFFr2QOYRhSbGRPS2ZITt8Y0HhKUYLe/GptUzInKdQg8kxYiuVYEF74e6Cd7hdh7k8um3pGe+CR6YcIpOFLUxokQYL2sZ8c+NEOAeCLsn6ABREqUMNp6HfqSTRy3mn/vkXVCrp+3xqQS2TV8wT7SL1N1nRGfrJYSy2GgkzlopUszxjliRL12R25ClS8NNVc5PltVK6lrtB6S9hEtY0GHY98lPid3O0E9c7Hc2exntCmTdA60C1gdSBO+iqoGnUeItJwHfx0HdfBop89hsLdIdrzBJhmBxYMt6OKjYU0eUaedUFFPnuDl7DlPOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a42d0c89-6711-4dd4-653c-08d85b2753b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 16:32:54.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Szmms9xyWZwyNdg2K3N/1d+pJWlXIhHDtDiAYN091TtN4XuxEsH5uLSwHm3TRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600360376; bh=JgiUxxP/raxSyWS4v/ZLSBF2f+FIGZ8VJBIk40JPaPA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=f19zRlX/vxbgVzjCMfiQ+H4MnwDQssgNB1+i0EayEH8XquHeofEMgMDGfLcomJ98A
         C2hZi/QiFlELkF7899C1HkhFlLCkWcS3pvW+irCpnxvShQiN8GMx1ODUMtpO/z2hCo
         TslOTiIAmVoQIPRibhVZsKDRt6iSebgXMcJLzmdnU1c8xzDe/u/FRs5/BdWmtkuTWi
         Hmy/v0T0BXO1AKfResjMNWTgZPPqhmYRQ5NMc7Ujuvh++NBXHrBGatyArcik3qT0MU
         N7uxRb/qRwoH6ee7Sfe4nE17fbD0k3S0GBqAK0lVit8G9LXudzspyYc62TfGEX6lC/
         lTL5zcSAwT4fQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 07:19:50PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 09:06:36AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2020 at 03:21:43PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Update the code to have similar destroy pattern like other IB objects.
> > >
> > > This change create asymmetry to the rdma_id_private create flow to make
> > > sure that memory is managed by restrack.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/cma.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index f9ff8b7f05e7..24e09416de4f 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -1821,7 +1821,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > >  {
> > >  	cma_cancel_operation(id_priv, state);
> > >
> > > -	rdma_restrack_del(&id_priv->res);
> > >  	if (id_priv->cma_dev) {
> > >  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
> > >  			if (id_priv->cm_id.ib)
> > > @@ -1847,6 +1846,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > >  		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> > >
> > >  	put_net(id_priv->id.route.addr.dev_addr.net);
> > > +	rdma_restrack_del(&id_priv->res);
> > >  	kfree(id_priv);
> > >  }
> >
> > This is wrong, rdma_restrack_del() has to be called before
> > ib_destroy_cm_id() because restrack reaches into the cm_id and touches
> > that memory:
> >
> > 	case RDMA_RESTRACK_CM_ID:
> > 		return container_of(res, struct rdma_id_private,
> > 				    res)->id.device;
> >
> > Which will now be freed after this change.
> 
> We access "id" which is struct rdma_cm_id, while ib_destroy_cm_id()
> releases something different struct ib_cm_id cm_id.ib.

Hm, OK

Jason
