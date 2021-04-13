Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7C35E3D5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhDMQ0h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 12:26:37 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:31798
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232174AbhDMQ0g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 12:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhEhFYjz6l0TSp3YsCkY2VBAb0LstfM0UNhYvaNnvHiHKu5/TONbhFLvKIiRSBcWFRxJeHMo7L3d1gHiAUlnkGWsiiTbNtWIsvrMbXlcnRNlZPLn+OJ9CFKRpq2Tld10+AjY6/w4ENaHsvgBmJ1t9hzw4tGj9LiN7TKCoN3eilkDTHy8wiP+eejTw4fWk9PWP1Ov2opD4+c85O4kDz5zlTkw69YJtGs1L+MPAdte6CTuyY8ITdL3OKlkmihJatgwJ0Jq+4EL6nERRB+5g9CKeRjcUKVXJ5YX/2RiGr8EDY5BLM7pxlze7XV+BeqpMooWQOt+gIifrI+e+wYUjDViag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltH3KiZ5/AQ0Rn8oSi41dfTTgI/r4hpyb0qqY2HTQ1A=;
 b=J6//g0eHAFec7yFTXKKws3mxwWw7lHYghHtCdRnC+fQyUs3JlP14qgwR9i0bvfGFKk6oA2Nrngv2GU7bV9LxSygV0/2Rjn2X4oKKpicxRGpTXh92W1DDie4imJeOTANtFRkMqU3Ptwfav4ZAW0HUi/Wc7CaAa2OzWEc0+B+BmMHRx9p4hLL4e61cx6pBC+5EhqOgJftCRn9ov+fz5a/WKVi7TkBGaNByUYcgr6bqH6aKqww5bet6W2xC6wXvAFwat3VINfmQDe+wKFhXiNSiXafZR+SypOUoNu7mNy8hecoQQNMrlx6KdLxudjXAvgw+DTw0uJC9L8jriJiRWu+Scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltH3KiZ5/AQ0Rn8oSi41dfTTgI/r4hpyb0qqY2HTQ1A=;
 b=oqrxIo1iz9Hzg2VroFz5DzLfIPuPhKxk5V5p22yvL9udfwWgDd28Ipou1c1ganCmwrS5g5fMbY9wZJZC7jTMwM7prLPEFD+HmZPTbOT7bare+/C1HP29Ap9e9/MBjq1I2p4Z35+jEsd1fjNhoX1Zck9S2YwqFpOzDyq6L1EisWRJEdEoRBP57Q9Xv8u4Ol+/vS44F35s7JBsuEuKkECGI+G+QIgismjf1/Hl73MjRQXTvMFEBJPs3V8vwl9bV3ayo2x8fYQ8pc1Z/LUoRzmMahJDZ4IIlzGvvVJfXOe1HTF4YANe5fOoUGZEHYnm1eCveCp7QFkCWJboiC+pRNl+Mw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 16:26:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 16:26:15 +0000
Date:   Tue, 13 Apr 2021 13:26:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/5] IB/cm: Simplify ib_cancel_mad() and
 ib_modify_mad() calls
Message-ID: <20210413162614.GV7405@nvidia.com>
References: <20210411122152.59274-1-leon@kernel.org>
 <20210411122152.59274-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411122152.59274-3-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 16:26:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWLri-005W0t-G8; Tue, 13 Apr 2021 13:26:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66157d6-d9e9-4e3e-ab4f-08d8fe98dc42
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020462DD044A8AD0AC4B2A02C24F9@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcOKPWYIU8RTZJyWoLzBkJzqLIZGmyg4BrPmCGH4zj22RLqpSonvLjkTjXSg71yAfFCCFHkuVKFf6HnSC4KXWHW0r/AeCFhJ0HSHQ2MhNZQ7j99GiNm3FMai1fxwoeValthjG3qB7kQmjKzq7lnXPdF8zD2b6hcKAGMtqsaqU07w6bdl8Ox7g2gbZdGd34THZKm4gC4FYEm9ilGEXk0zn+J5Pi6iCdupRw2rrBrsNnddYkB5EBBeD3jZYhSGEb6EmEk7HZOya+ZPIwfNj019PBdresWz1Aw4wg9YiiidSmPaRa4VNUdPGL418JREpqT5mkt1YfWPWT/0UOQkw6PYY74XJnUAkbvoRXmB9YtxqO6hYyHJJkp/cCcoqnotK6paMhb8W0K186Ls0/sGr8sOjB7HZWcFRqWxXHwvTRXBQ83lR52Zi6TdHiS7jwVGH/tnkDjIuT9V/C8SifsXSB3aK0d/i4jxOejOiy8xX2rnc9wDNfkuhjHzdKZ8c9Zk28y10heXmA/UVDtOkCPtMyIzw/fa5oI1Day4N2aEJlO4xRMTIq/jdHQvywokhE0PMC4KmDxeaAcAAgcZmovQ7XyI4Pu+cm0GBhww/tDCpLoVPuQCLTzYBFQ3Le+L6GdiW7SNMGZWQq3agrsjO1N8gvBzLVeuMnVbLfMkNHf4DcXzBJJAPmDVYx4UHX81YsukWGXQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(2616005)(1076003)(36756003)(9746002)(9786002)(478600001)(6916009)(38100700002)(966005)(33656002)(8676002)(2906002)(8936002)(66556008)(4326008)(5660300002)(86362001)(186003)(66476007)(54906003)(26005)(66946007)(426003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5WYuy+22oBYM3YCJZE8bqa3WIp1/Gbi8kXC7BGNObB6IQiBDoTjUzvd4oil8?=
 =?us-ascii?Q?4WVGPiBbr72HpWXcyM6/Qbktoruh47DbLpYJ11QRTD8jSsyeRZt5qBsZPSdw?=
 =?us-ascii?Q?IEVaYV+pis+OnUArmRx3Q9URxLY7pP+1ACZZ+qS+nusmS4apeucs3K9qfKu0?=
 =?us-ascii?Q?bfAap3194BOkcSAaB7VBri5+0Ft6UpLxl9BTRw4kVnz0cm9y3MjePfXk7HvO?=
 =?us-ascii?Q?iZlbpScge0FS1CnPU/vAsD4mN7/mgkhWg9M8XlIwRHZCP1jmOL7QV8EfyLMF?=
 =?us-ascii?Q?uVtfNrKN00lPvSstgmSfcdlT8+QaOIHdJZcOnNChp6JoyNXRbrDiU54bRPxf?=
 =?us-ascii?Q?SPL2aP9WUbmJupwmZl6BPJVjovWJxpA8y8z6lTTTcT7RWL8xPYLvVqkKP8l7?=
 =?us-ascii?Q?vT23uAO4YnWslyHiKH5hoYveV/zOK2asvERORTVZvFeHguoGdllyN/5Y9SJ3?=
 =?us-ascii?Q?5j8SgQjjVgCf0C8UgeYwXN5uXYdpAEH/O9zzPLSc2eP64xZ6ouNpn6sulgCR?=
 =?us-ascii?Q?ven2UwWnvGfEOoKNlVSHeVIwW5Cg7kQeiy2mATYoBar+WgzU8y9XkBann0Wj?=
 =?us-ascii?Q?UenHi2qwdDkd8/ydzgG/BAPZAysDDDcZqMOUHAxIrNNY7hi97hCAXJVXoeaX?=
 =?us-ascii?Q?wjaDTWL86FUVJYT17wFlhUs2tILGQsLTfjaNX1agbWPsoIe+VDJ/TcLR9o4K?=
 =?us-ascii?Q?hMhczvsS2kLZS2mXxXBmZ90BNHDP/EXxZHXMiVBKr+/FyNCxwHKmxO/2JRlP?=
 =?us-ascii?Q?sWNzRG1CNtHaBCSuqCfZKzijEaCVLA0yg1Keuaf0JvWwKXVocsxm2w3oxsxW?=
 =?us-ascii?Q?QkyR3OOiml9tLN5vrIyeOKJut57RU22rbKX14KOHYPIbqxhF1pCO3+4CQopX?=
 =?us-ascii?Q?S78bAo1Xko2BzzoF1NRimsxj4C+OyVTa3zJMTjS6/gQqCRAAEXmdPzEJgEOX?=
 =?us-ascii?Q?Nd2QPBLJE8xSLvah26Ng3KQmmyN5x3dKOF1PM1bbCziKtyBjVCNLwdHW0D+A?=
 =?us-ascii?Q?7ZuQms8W41f3rpZhPsjVgFuA1/oiXo0C3c7oIbyjM2mKWiIQIIFS5ToYMPh9?=
 =?us-ascii?Q?mOPYUKIF+YWneRg4m5juRY1IIhJFHzTUoaHWg8Pp/TMljn7hlvEjTFnbj+v3?=
 =?us-ascii?Q?aoVvSQKkQY3anX+idquCsSyHTTK1/i8U4c8mKVDDkWwaz1UJmlgYPEIKP59A?=
 =?us-ascii?Q?jamYGGK2J1XhEUMxztSxmf8YPC+s0UZFqghe6gBbAedGp705YumkE8Gr6J66?=
 =?us-ascii?Q?QgjERpIzxCapEKp2zy8AkDL2/zlhTTUld5NrenkiTG7kMcgOXbaPIOlvC/Sr?=
 =?us-ascii?Q?fKWmycX4wPELnT+od2knO8EL+UxREJxDrprlaW8laJK6og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66157d6-d9e9-4e3e-ab4f-08d8fe98dc42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 16:26:15.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edGLyibDmA+FiE83naZzvPb7dy7K/RUqAvnTjcUp2+dNzePKQ8DV5lI/WPAz/sh0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 11, 2021 at 03:21:49PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> The mad_agent parameter is redundant since the struct ib_mad_send_buf
> already has a pointer of it.
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cm.c       | 101 ++++++++++++++++++-----------
>  drivers/infiniband/core/mad.c      |  17 ++---
>  drivers/infiniband/core/sa_query.c |   4 +-
>  include/rdma/ib_mad.h              |  27 ++++----
>  4 files changed, 84 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index e33b730107b4..f7f094861f79 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -1023,7 +1023,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  		break;
>  	case IB_CM_SIDR_REQ_SENT:
>  		cm_id->state = IB_CM_IDLE;
> -		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
> +		ib_cancel_mad(cm_id_priv->msg);
>  		break;
>  	case IB_CM_SIDR_REQ_RCVD:
>  		cm_send_sidr_rep_locked(cm_id_priv,
> @@ -1034,7 +1034,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  		break;
>  	case IB_CM_REQ_SENT:
>  	case IB_CM_MRA_REQ_RCVD:
> -		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
> +		ib_cancel_mad(cm_id_priv->msg);
>  		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_TIMEOUT,
>  				   &cm_id_priv->id.device->node_guid,
>  				   sizeof(cm_id_priv->id.device->node_guid),
> @@ -1052,7 +1052,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  		break;
>  	case IB_CM_REP_SENT:
>  	case IB_CM_MRA_REP_RCVD:
> -		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
> +		ib_cancel_mad(cm_id_priv->msg);
>  		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
>  				   0, NULL, 0);
>  		goto retest;
> @@ -1070,7 +1070,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>  		cm_send_dreq_locked(cm_id_priv, NULL, 0);
>  		goto retest;
>  	case IB_CM_DREQ_SENT:
> -		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
> +		ib_cancel_mad(cm_id_priv->msg);
>  		cm_enter_timewait(cm_id_priv);
>  		goto retest;
>  	case IB_CM_DREQ_RCVD:
> @@ -1473,6 +1473,8 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
>  		if (ret)
>  			goto out;
>  	}
> +
> +	spin_lock_irqsave(&cm_id_priv->lock, flags);
>  	cm_id->service_id = param->service_id;
>  	cm_id->service_mask = ~cpu_to_be64(0);
>  	cm_id_priv->timeout_ms = cm_convert_to_ms(
> @@ -1489,7 +1491,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
>  
>  	ret = cm_alloc_msg(cm_id_priv, &cm_id_priv->msg);
>  	if (ret)
> -		goto out;
> +		goto error_alloc;
>  
>  	req_msg = (struct cm_req_msg *) cm_id_priv->msg->mad;
>  	cm_format_req(req_msg, cm_id_priv, param);
> @@ -1501,19 +1503,21 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
>  	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
>  
>  	trace_icm_send_req(&cm_id_priv->id);
> -	spin_lock_irqsave(&cm_id_priv->lock, flags);
>  	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
> -	if (ret) {
> -		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> -		goto error2;
> -	}
> -	BUG_ON(cm_id->state != IB_CM_IDLE);
> +	if (ret)
> +		goto error_post_send_mad;
> +
>  	cm_id->state = IB_CM_REQ_SENT;
>  	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>  	return 0;
>  
> -error2:	cm_free_msg(cm_id_priv->msg);
> -out:	return ret;
> +error_post_send_mad:
> +	cm_free_msg(cm_id_priv->msg);
> +	cm_id_priv->msg = NULL;

No, please use the patch series I made instead of this

https://lore.kernel.org/linux-rdma/20210329124101.GA887238@nvidia.com/

Jason
