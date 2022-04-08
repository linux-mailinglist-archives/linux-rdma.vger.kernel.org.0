Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD934F9CAA
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiDHS0s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbiDHS0s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:26:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C17318487;
        Fri,  8 Apr 2022 11:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGPIep/DjvhOBe/RMaUxP9RZD9vEe89itLXl0WQsxyZnbCRhSTb1EDwaaZPkw29+2MagjRIj4I8bbgj7ozRRrJd1uJvL2vsNZXn2bJ5uboYCfkupL7r+I5Knh3DMTUOQcK+9c1/i9efeiCMx4Snec9Fh6VpGSfV1KoRIZu9ZqCAC68hxN5wcvPf1dp6y17CPhVeJZaYohP+yAgqwYDxSyFuQUyzuEXG7zIcvOTRdIjimQeAvMwJZiOl9Jt0ZNLXukuqvKAG8jamG91Vb6R4CwlRKfCjG8DYVWjYetuj5BR4QHCP2LKy/HD35zhDd+lqxxyOhKxppcoiIzCylxzM/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDkoV2qrTVN7EUKNkAZXqvjtmyLKKzwTml4VBheT0go=;
 b=PkmsWUQMbUph6nDboXs5gbg0eppRAhzsTgxuMlWnT3skJN+a2/PuI73W55oWargdprB0L6Wor2PbkpM7KMBTIlEFWyfkVJoiQkvFMIN7ym25Iq+co9HctO2uJgYEPPHCBlkZWup/6AMVt+Lq5HIehtiktY4CbK8y/ZrIKpombGN4z4o6aaAB+4nPx2hOslGQE7bbpyO5Oue/+cOHb+rPWEZAsBE4ufartwAygy+VcgI8wgkABZxJmAVGYd0WFn41QyhWSQkhWNvql6ANUld0ZB1ShLAdQxYPtFMdseZFMRp20RSYZRrpOEdA7Ai6uv2uU6TrYvgfHvXvC28zld6zvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDkoV2qrTVN7EUKNkAZXqvjtmyLKKzwTml4VBheT0go=;
 b=Z5CUMCXNhirZdh+yO9qoy1F8VvMSs8IsnP1MMVUlZ5gsHPNswPcUyUzv3Y4e/R3DiQE08pTtgzTfphY2MwN/KEtqjfsMAjF+JzrkzimcYBh6GoGR7m9fE5EIgUdrRT2qSfyWV3nerQCxyA2YB2x8oYGC78EJYvtsqVTDJ1Tl9EjWTIHMNUGuRTJLPXjyBI5Jysg766EZ1kpzVfCT7X3avC58Q134bgrB9GzZMh/FIJ13wWc03pCqYfAekgF8Bo//iuzHWIig5RlLXgQGqCHxilYWMm8bnfdRjvJf4WHxuWJaKGpQpp4ucoox62AJUTSqsvCuxiuQC9MGj7zJCpp6MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 18:24:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 18:24:41 +0000
Date:   Fri, 8 Apr 2022 15:24:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Limit join multicast to UD QP type only
Message-ID: <20220408182440.GA3647277@nvidia.com>
References: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4132fdbc9fbba5dca834c84ae383d7fe6a917760.1649083917.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0de9dd1-5ad3-48ec-6939-08da198d0c39
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5636:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5636B621324152EEF4CE3233C2E99@SJ0PR12MB5636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l004tWx3PaoipWKsEO/7BcqOXjjKjglNGWUXAsJXTdXq0WxxR0STpAkdFkfB+WzJv3iGgZDY8oYS3APwnyXlL67P4VA+yE95loXX1STwT11q2qdyKogRip9HrxRFr6uxWi4CrgRJOK0cfYWlSkG5ssPru9ErVGhVARfoM5nh8D36gm3fJBarqkq5PWZz5RLHVko5u/dFt4mi9pQ26Re8nz9tY0mL5hmiTdqF7zDm2eSBl8UlB58cJ00R1YKaymfvh3MTaPYiLrbMnVsR9BxXd0oTbepNP5VKFzm4MyCyetF+nSn4ik4R5v5gc2JLh2QUMXkp3NznBVcNYikGN5R7zx43i4HhICfTxio6YpR0qdVcrWkc8yHXqGN62aVEiQ4qM3yYWNhVm9uVJe4CQz3wIsbqZi8aIDzZ3c8owuZZFvH8FGVEQYTgMAVM7TLxY3gFvu0a1ZowEk7jobmz9RuQI8ws29Wnq3lm5u5r3QiV03iKQwWFDNWNheL2BhcCLJATKAoyIChVHeWybJhLS0PZXmNlZLOpf1ssm1sKoO17rNuQXzZG7qZgVPy1MlGE9hN556X8+rrL6YhbPXLjTEkuzkXgHcuKtwcTiymVDc3kFZb1Pis362SrR3Il6FowdLOwvTb5GtdKwrMRpDO865Jldg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(2906002)(86362001)(8936002)(66556008)(66476007)(66946007)(36756003)(186003)(5660300002)(26005)(6486002)(8676002)(6916009)(6506007)(6512007)(1076003)(33656002)(508600001)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+clowzsKFayNkrpTfo4ddzdLuIHweovmBLpCMZBswzMYSbs5x3dNVegqvjr3?=
 =?us-ascii?Q?N1f+H5ogn8TVWFAlWuFtN5KuVi6+d1Yr1WNaAKfUPutZyoBYrER12t0Fn8d9?=
 =?us-ascii?Q?QvEiHYW+nLGCGK+MuKAZ2pMnF44pa8jYTZe7u8mja3yVUNelYqpLpjIslgZ4?=
 =?us-ascii?Q?VPfjgKLnZqCOYUkktYu6SKJUGR9M8FcKi7Jqw0foUiHV/JOt7Q84cLshsV66?=
 =?us-ascii?Q?5UC9glbrNJJ2nXZ/lGXR3yyyw2JSyjnBNOSXENzKZiOCbIneqmwYM86cpdtd?=
 =?us-ascii?Q?zpjp5dqWD63Hy1nzmfb4Rn2TN6oHm2wPlsjKOk71r5tHX5QWfMuEyF6U9Pn9?=
 =?us-ascii?Q?FFjEPzcCEAxbuwHPxcrGRGu+jp5unYsBAtOYdOw9XvE3+n/nlP2Owfhxkb83?=
 =?us-ascii?Q?tnQP5R7ZN6g1hU+ptSUFdE5l8kR3Yutq0f3KtR6Nq30zu/Qw+SUEP0pOTzW9?=
 =?us-ascii?Q?/pxnc6gz24xbqEfHXnQw0QqlP0v2OlMkIoADE9MU5d4cZ416aJF9gclWTsTY?=
 =?us-ascii?Q?FwliZ4cTXhdgpYoZi9g88cNJbjU8Us9Apmb5caov6T38QM3XpNsVz/ZhFNMF?=
 =?us-ascii?Q?4ROxW6Q4yxQCf0kRT4qtwojYx7KuMgw0RZV3/aPliGdbZMkNM3UmLARjPaJn?=
 =?us-ascii?Q?Hj3q3NC+1IW4Rv0kh/ShBQiBGKp21jF/vNU5Sc2XbXxqdWnbICwqM0LLmVGO?=
 =?us-ascii?Q?nfHo3WRsfUfTRLLf5hJwyWz9t0uuL1uKego5v0j8sTcLNp9NZSegKSKNm03e?=
 =?us-ascii?Q?/v2czh+HDz2AYQdKiz9H5lPa4CK/1ephU2XtMIMplCr9u6zRHTSXujmO2CkM?=
 =?us-ascii?Q?l39mlVPQy6h/EfRP0revyRA3JJ+smGLGWTxANAhRpvrHsFI6SHwTQBnimmYT?=
 =?us-ascii?Q?6VMYZwbGmcn7dc03D5iXfdM2iVgqio0YFRk6Y8YsRPp1MdCBVEdT7ptgF572?=
 =?us-ascii?Q?vCNhSU/yb45XhKgLBErQuNuIamG259YRyvsi8r1lwI+gr+2t+LOjr3iqKpmr?=
 =?us-ascii?Q?IZ5EDK54m6HmOgCNjaElNiFMVtpfI5XBp+VJ/2aanKJSRJq1Y9ZMj4UAkVg+?=
 =?us-ascii?Q?PDmbPFHcRb5T6IbU7fq36OVoCJBS5Xm7cgBekxPY5vPVWirj63db9MQUq8bS?=
 =?us-ascii?Q?ofe69Hky2RLP6SH5IG1k4XnWS4yYPzXS8CuExAFYgwFhbYXXsWBEc9jfwbUS?=
 =?us-ascii?Q?90IoRHftI12H9mbL4WUyT8TaeztFcw3UYBtfuywTnRYfzCa2hVS9+CVfTXqB?=
 =?us-ascii?Q?LWAH824w2siG0yihdiCDe79J3G1+wdx83MR7yNVO1/Kd6jHkkMkJD0rPI1r2?=
 =?us-ascii?Q?5TSZMPSzF1XYkCaX59ysbY9TQkEVhpKCrePrd0LfE8NCCYKknlPj/DHAiMi4?=
 =?us-ascii?Q?riZNRzj/b9heYo47J1AVWiWJsEJMpO4ggZXP9oIo+ZpCZWy4l2T+Tpc0sAFx?=
 =?us-ascii?Q?r/yNj6TlrLK5hBzbLksBWTHwDAolcAXiguGRnc0HpC6uF4ttgz0kM8/tW6bZ?=
 =?us-ascii?Q?fw8wu3briK2uSn2B4f7Mj7qSTwdw38vbIL+UQ53dxZAMuPPeMsAwoP6xP1sL?=
 =?us-ascii?Q?itKR7ZOrnDzjlz14OeHk2yVAb8sBPlJd0K486gE3dEVrRQP15CxJefsHwHMT?=
 =?us-ascii?Q?oNAEBlWByh7jOR+Go7E+TnVWt8a4CUaDmEFIRFGnrjtygX/taqY+H0D9+NdE?=
 =?us-ascii?Q?eApi+XHqs+JkfAqxdOOEDrWLkDaZbJDOHct7QJN1yOBRsjjL27mwzlNdHlin?=
 =?us-ascii?Q?uQm+cSkD5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0de9dd1-5ad3-48ec-6939-08da198d0c39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 18:24:41.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUFYrujqv3TaOn6QAZeJv07oCYNdVfwvyaawNxiQTtvKIpgNcCtqVB8r6bAIkfWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 04, 2022 at 05:52:18PM +0300, Leon Romanovsky wrote:
> -static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> +static int cma_set_default_qkey(struct rdma_id_private *id_priv)
>  {
>  	struct ib_sa_mcmember_rec rec;
>  	int ret = 0;
>  
> -	if (id_priv->qkey) {
> -		if (qkey && id_priv->qkey != qkey)
> -			return -EINVAL;
> -		return 0;
> -	}
> -
> -	if (qkey) {
> -		id_priv->qkey = qkey;
> -		return 0;
> -	}
> -
>  	switch (id_priv->id.ps) {
>  	case RDMA_PS_UDP:
>  	case RDMA_PS_IB:
> @@ -528,9 +517,22 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
>  	default:
>  		break;
>  	}
> +
>  	return ret;
>  }
>  
> +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> +{
> +	if (!qkey)
> +		return cma_set_default_qkey(id_priv);

This should be called in the couple of places that are actually
allowed to set a default qkey. We have some confusion about when that
is supposed to happen and when a 0 qkey can be presented.

But isn't this not the same? The original behavior was to make the
set_default a NOP if the id_priv already had a qkey:

 -	if (id_priv->qkey) {
 -		if (qkey && id_priv->qkey != qkey)

But that is gone now?

I got this:

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 3e315fc0ac16cb..ef980ea7153e51 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1102,7 +1102,7 @@ static int cma_ib_init_qp_attr(struct rdma_id_private *id_priv,
 	*qp_attr_mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT;
 
 	if (id_priv->id.qp_type == IB_QPT_UD) {
-		ret = cma_set_qkey(id_priv, 0);
+		ret = cma_set_default_qkey(id_priv);
 		if (ret)
 			return ret;
 
@@ -4430,14 +4430,10 @@ int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 
 	if (rdma_cap_ib_cm(id->device, id->port_num)) {
 		if (id->qp_type == IB_QPT_UD) {
-			if (conn_param)
-				ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
-							conn_param->qkey,
-							conn_param->private_data,
-							conn_param->private_data_len);
-			else
-				ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
-							0, NULL, 0);
+			ret = cma_send_sidr_rep(id_priv, IB_SIDR_SUCCESS,
+						conn_param->qkey,
+						conn_param->private_data,
+						conn_param->private_data_len);
 		} else {
 			if (conn_param)
 				ret = cma_accept_ib(id_priv, conn_param);
@@ -4685,7 +4681,7 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
 	if (ret)
 		return ret;
 
-	ret = cma_set_qkey(id_priv, 0);
+	ret = cma_set_default_qkey(id_priv);
 	if (ret)
 		return ret;
 

>  static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
>  {
>  	dev_addr->dev_type = ARPHRD_INFINIBAND;
> @@ -4762,8 +4764,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
>  
>  	ib.rec.pkey = cpu_to_be16(0xffff);
> -	if (id_priv->id.ps == RDMA_PS_UDP)
> -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> +	ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);

Why isn't this symetrical with the IB side:

	ret = cma_set_default_qkey(id_priv);
	if (ret)
		return ret;
	rec.qkey = cpu_to_be32(id_priv->qkey);


??

It fells like set_default_qkey() is the right thing to do incase the
qkey was already set by something, just as IB does it.

> @@ -4815,6 +4816,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
>  			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
>  		return -EINVAL;
>  
> +	if (id_priv->id.qp_type != IB_QPT_UD)
> +		return -EINVAL;
> +

This makes sense

Jason
