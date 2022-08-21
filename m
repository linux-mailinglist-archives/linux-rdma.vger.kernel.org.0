Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8143A59B356
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiHULfF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULfE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 07:35:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D418341
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 04:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE2Px3CoOgJE1Y52UEdPLy91jYwnuV1/YxaT1ZXiYATww6LTncuVXUhaaLj1AkdgxIPS/bxiv5qpVBYt1Ki+nHQ+8Oi6ttGgSe8M25Xhs/qTbLv1sx3R5WWPFGTOHtDKBZ7/kVUlI4r7F5C8ot68x8G+eX62H/KOCx1+DFfE7EfvkbsfFoSy3iBm67b6Q0MQwwzOf9ptKxzAGL6BRkZJIhhxd/Uc3gDoO7jhjBndHzxD4C6aHVYnItHus9+tHirjClOxaoDggejXPJNZiiDsxJzHfoFoy+wzQFMmG9qvbXRftK9py5dOH/tR5S83MSyZx3WPJXeLeWa5ZjVuhi6mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNjaGGmoytKis9Vfsae3ECgcNgI61B0HCSlSMfKFR68=;
 b=FoGFgyO7j3k7w6Vqgn7WzKrbKTKAJYS7xPm5vzgKyx+vOWHr3FH7tkR0m/Y09L5Timb76BMt1hO3iDlKWkxg3rASGPX9GHx0YQ5obkch1yLVaX/OMGiuaSvJn8Esv8IbtO75VMCegzuRMOvR8Qfhtqx22HFWKLkuCP0/LcDu3NIdp/Ic7Y9pke4XXUlXJAdyJJl0EOALcrudpFL5u2FFQBsJkq5cFfqU1yp7UsmZ0jWAArBrdOMhbdEL2W4k/ONKaSoG/xWWhIcw1S9Z8Mmmw8r7Ql/+w9qhaWNds5y5fy5XCWLDnrfmQYTC+cKI6kXw2S9yhgcWKjEuMy2dTdQj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNjaGGmoytKis9Vfsae3ECgcNgI61B0HCSlSMfKFR68=;
 b=YyArw1v0aptEW+IrfZ1pmnL1L00aYVKaUIgqtWOI7A3sACwXOSq9ZddUVR8//JGYrg6dnqDtpxMuHpPRmFQpeiXMRPBndZPyL20/FVFReI6qHSA6uqp0Z6RmK3xVqZDp0nlvYWPYr8E6/9BIlJkQ0tEBKCNE/W17qIB6rGiPzfxM7BvN8B4htM49wYgWwEoC51TCe3PcSezfj2NyjZiv2kgBxAUl7a8GeXUn914b4xrve7paDkROU31Ar+9Y8eSipK7hxl/bjOxDyma8FwNuhTiZi8da/2sWEoclfR0Xu8vkYUH3eHnQZ+P3A9y4R9JWhrFoB6JIOB9TevLX5DdO4g==
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by BN8PR12MB4596.namprd12.prod.outlook.com (2603:10b6:408:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Sun, 21 Aug
 2022 11:34:58 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::6d) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Sun, 21 Aug 2022 11:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Sun, 21 Aug 2022 11:34:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sun, 21 Aug
 2022 11:34:56 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 21 Aug
 2022 04:34:55 -0700
Date:   Sun, 21 Aug 2022 14:34:52 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <dledford@redhat.com>,
        <jiapeng.chong@linux.alibaba.com>, <cgel.zte@gmail.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask
 and service_mask parameter of cm_init_listen()
Message-ID: <YwIYXI9xTSpw4Vtj@unreal>
References: <20220819090859.957943-1-markzhang@nvidia.com>
 <20220819090859.957943-3-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220819090859.957943-3-markzhang@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288e95bb-301f-4adf-bd87-08da83692d0f
X-MS-TrafficTypeDiagnostic: BN8PR12MB4596:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Krmz/sG71r3DdNcTvS6bLYIsZ0w4Nhf8IWVN8Mm4+cPkDkyFIdtewzmT0xFnArhdGArQHsK4/T4zSakjwvVvjiHiW4jXLadqcW1KamHYmZOwk+kPERWs5toKyC5nSrJ1PAXkELbmcpEPZAPWA92K2hQMyn7tDdHtJnO2Anm08tpj3tjNbD4Ojv906HOyo8nvoRY3tg3BmkB5hPdYFgzfMqlAtbug2RcGfINLVFkvzBBzCx2GQl83vhIU3rW4fyzTgwadnR891P5D0QdlCDhKbt57lUdrT0Y7vmW9gxtuH34FjZuNJoJ2hZ9clJjm7zhu6No95zRtpKF3M3kUWd3zpu7ejQnBNyFxtVvNkqKqIyBcgA882yjB36zqoHVO02UfxECfqUwZVBpIxukZQlMGYHcSTb2bqJRy1FGTiKXlC7NwP9WhsQMiL1kX/meV0bSNr5YxS8m08s4Iy++V/FxynZWjuYK1hM7L4RFBXYt+conmkFb9afAbtFXd1ezxroebK83Rg193wHQ/lXRwHEenVVNkc/ihliMwNgGbaQieyJNgzfTlQx4Zv4/G1p5YX7tWFGO5RJVqg94g83Nyy7LWIoUfrx7dru81M0CRmvl/NWTkw46yuN9PZTzavq8e2F42Goax5WIYxLqR7vTJXJ363t7hC59TXvkEStjDju4uFigQGQ1DuWH162kLAATfP9G9Cxa1z+7uzO6FL2K8Xl2bQ44w8HCDfanS/RmERWz+vsGCaweOhw3/ZA6ow/y34Cx8ktGd0SynFWCgGGqM63b6s1uycob6I9zrQeNet8gRlBg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(83380400001)(16526019)(336012)(186003)(47076005)(426003)(81166007)(356005)(36860700001)(82740400003)(40460700003)(33716001)(70586007)(4326008)(8676002)(70206006)(316002)(54906003)(6636002)(82310400005)(2906002)(86362001)(40480700001)(8936002)(6862004)(5660300002)(478600001)(9686003)(26005)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 11:34:57.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288e95bb-301f-4adf-bd87-08da83692d0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 12:08:58PM +0300, Mark Zhang wrote:
> The service_mask is always ~cpu_to_be64(0), so the result is always
> a NOP when it is &'d with a service_id. Remove it for simplicity.
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 28 ++++++++--------------------
>  include/rdma/ib_cm.h         |  1 -
>  2 files changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index b59f864b3d79..84bb10799467 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -617,7 +617,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>  	struct rb_node *parent = NULL;
>  	struct cm_id_private *cur_cm_id_priv;
>  	__be64 service_id = cm_id_priv->id.service_id;
> -	__be64 service_mask = cm_id_priv->id.service_mask;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&cm.lock, flags);
> @@ -625,8 +624,7 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>  		parent = *link;
>  		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
>  					  service_node);
> -		if ((cur_cm_id_priv->id.service_mask & service_id) ==
> -		    (service_mask & cur_cm_id_priv->id.service_id) &&
> +		if ((service_id == cur_cm_id_priv->id.service_id) &&
>  		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
>  			/*
>  			 * Sharing an ib_cm_id with different handlers is not
> @@ -670,8 +668,7 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>  
>  	while (node) {
>  		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
> -		if ((cm_id_priv->id.service_mask & service_id) ==
> -		     cm_id_priv->id.service_id &&
> +		if ((service_id == cm_id_priv->id.service_id) &&
>  		    (cm_id_priv->id.device == device)) {
>  			refcount_inc(&cm_id_priv->refcount);
>  			return cm_id_priv;
> @@ -1158,22 +1155,17 @@ void ib_destroy_cm_id(struct ib_cm_id *cm_id)
>  }
>  EXPORT_SYMBOL(ib_destroy_cm_id);
>  
> -static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
> -			  __be64 service_mask)
> +static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id)
>  {
> -	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
> -	service_id &= service_mask;
>  	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
>  	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
>  		return -EINVAL;
>  
> -	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
> +	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
>  		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
> -		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
> -	} else {
> +	else
>  		cm_id_priv->id.service_id = service_id;
> -		cm_id_priv->id.service_mask = service_mask;
> -	}

If service_id != IB_CM_ASSIGN_SERVICE_ID, we had zero as service_mask
and not FFF... like you wrote. It puts in question all
cm_id_priv->id.service_mask & service_id => service_id conversions in
this patch.

Thanks

> +
>  	return 0;
>  }
>  
> @@ -1199,7 +1191,7 @@ int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id)
>  		goto out;
>  	}
>  
> -	ret = cm_init_listen(cm_id_priv, service_id, 0);
> +	ret = cm_init_listen(cm_id_priv, service_id);
>  	if (ret)
>  		goto out;
>  
> @@ -1247,7 +1239,7 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
>  	if (IS_ERR(cm_id_priv))
>  		return ERR_CAST(cm_id_priv);
>  
> -	err = cm_init_listen(cm_id_priv, service_id, 0);
> +	err = cm_init_listen(cm_id_priv, service_id);
>  	if (err) {
>  		ib_destroy_cm_id(&cm_id_priv->id);
>  		return ERR_PTR(err);
> @@ -1518,7 +1510,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
>  		}
>  	}
>  	cm_id->service_id = param->service_id;
> -	cm_id->service_mask = ~cpu_to_be64(0);
>  	cm_id_priv->timeout_ms = cm_convert_to_ms(
>  				    param->primary_path->packet_life_time) * 2 +
>  				 cm_convert_to_ms(
> @@ -2075,7 +2066,6 @@ static int cm_req_handler(struct cm_work *work)
>  		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
>  	cm_id_priv->id.service_id =
>  		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
> -	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>  	cm_id_priv->tid = req_msg->hdr.tid;
>  	cm_id_priv->timeout_ms = cm_convert_to_ms(
>  		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
> @@ -3482,7 +3472,6 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
>  	spin_lock_irqsave(&cm_id_priv->lock, flags);
>  	cm_move_av_from_path(&cm_id_priv->av, &av);
>  	cm_id->service_id = param->service_id;
> -	cm_id->service_mask = ~cpu_to_be64(0);
>  	cm_id_priv->timeout_ms = param->timeout_ms;
>  	cm_id_priv->max_cm_retries = param->max_cm_retries;
>  	if (cm_id->state != IB_CM_IDLE) {
> @@ -3557,7 +3546,6 @@ static int cm_sidr_req_handler(struct cm_work *work)
>  		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
>  	cm_id_priv->id.service_id =
>  		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
> -	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>  	cm_id_priv->tid = sidr_req_msg->hdr.tid;
>  
>  	wc = work->mad_recv_wc->wc;
> diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
> index fbf260c1b1df..8dae5847020a 100644
> --- a/include/rdma/ib_cm.h
> +++ b/include/rdma/ib_cm.h
> @@ -294,7 +294,6 @@ struct ib_cm_id {
>  	void			*context;
>  	struct ib_device	*device;
>  	__be64			service_id;
> -	__be64			service_mask;
>  	enum ib_cm_state	state;		/* internal CM/debug use */
>  	enum ib_cm_lap_state	lap_state;	/* internal CM/debug use */
>  	__be32			local_id;
> -- 
> 2.26.3
> 
