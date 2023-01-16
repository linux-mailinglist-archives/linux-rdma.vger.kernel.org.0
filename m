Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D019966CDED
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjAPRtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 12:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjAPRt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 12:49:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F03A5AC
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 09:30:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImQeY/H0B7FNmrgCO3IQYi2orLIyVMNVYbcwxYyEP80ykjFZ6i0E8sd9hcq54F/0J0hvkwqC77bS7Da+53JIFY3jn90I5i6S5CrkPwgp+BrDFn3y73dQ+MgCLB4Smz2X+kypwixwJTcERCRJDVS9nLFrPwwHUSNTB26MRLIKTx+U2WQjln7S4v+J/tvS8V0BM9R9eak52da9LpYGsqqs2goZ5UAU1FZNB0iBdx+on2LkLywSLPQzUmlq5bak9X1bTJUWdJvYc4LioN7vb8H5T+OaZitduMNdeAlOxSdYJjuK2k+utveyNVcmr7sA7KEHtZZbN77lHy670NlYH5axVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IaiG7AF4pfx3mfaFU4L1p2wKZiqtJTr43jqaRFyeFw=;
 b=E9JwfAIrHhBEJ0SpM8gOMVOT5WdVuIyVau/FEHX5Nj0xqStwIvT2F1tKBtghxVQ6qEPyGAdOiP9XG5+0lm0LLD6OVO3mtQeC5lggOH04Q75aOc/zPkXyynHX1aedrJnLFkhZrLqrjdlatmGeYd2EObOlp3bJ959PsyStyJv7DhGAB9LjeTZ7GrL2hVCs2Zpj4MyUhlc6Q8GlSqFTykuIH0bmsrDz3csh/p25RE3shP2/jizQ9evvy6tb6IjzifnwQtQNMYaqIJNbCMd52WRMd35ZVvT3jMQHS3RyLR3vWHT1/+j/OQMXXMfTkl3f+1skcGr7D13fQePK7DZ7QrLLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IaiG7AF4pfx3mfaFU4L1p2wKZiqtJTr43jqaRFyeFw=;
 b=H0ZeqtRDs4xt4ne2tRZU+06iqXCYZmtOCNXIYddSDth+Vu0KADn/+7rEgTslAjjthw02uqoDqhITs1UJwrjS1/H1AahpL5RpAOwfTaGwwqtVfNyMVFHEV2IlhKzSFYWEToPpQMMijSzwSop8k+uKS6sa3NzBzq7N6ixaCjE9oqYg+arndFuWl3zNL58LCuK6tY0pTPu9ZkanFu5iiAaiT9j3cVGmpa8u3LGHE5SFjvedK0AONVL3FTHwk+lUiWGqm/ek38/8bswum/7o6lZqTnAt5wXp2XaZlt/+RATYz6JCgBr8RuvEkLDSLpFZDLMLVpKFXoBVMToitu4Jj61n0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 17:30:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 17:30:24 +0000
Date:   Mon, 16 Jan 2023 13:30:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/cma: Allow UD qp_type to join multicast only
Message-ID: <Y8WJr3ETfPB9SOEy@nvidia.com>
References: <236616934e3b6485428671d482d131175f5c1cdd.1672821452.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236616934e3b6485428671d482d131175f5c1cdd.1672821452.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: e08fa0de-3685-4cf0-11ef-08daf7e759a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTHXPNxoMAn+PKe6zmXx5xg/W1Kg13NKBaxu2uRaPiqsHVQThqHm2KxU5pQ4qA9n4B7gDxtu61kWX57kRhsLOBTeYoj3bn4ZhQqsZAoWmO5JpBG8KvsJ5FtHZghgCJQK7931t3tmWx6/JoKv0o6IeCGWnH2luL3JZmlydq26OY/o4WAezZAjGDkhs98TTUXWIkyEGKaEMnhz8Gvn0mWU5ytyr3zv+uckve+0m+t2tA6oLiXEvFjRj3KF+eKoVvWBiMO/4F34ABjEYg4WlBmGgFU29SRq0UaxGuW52SKyaIttteXnxeE0Vh7RM64VSOS2BD74hyVLR04dz6v7+BooR/CYDEheg8g+QvF3DtLSzw9ABFD9cFQj6zzzFCMXgpdckzgOG2+PZSWjpk4H3b/XvydXBHxMJpUse4GrSsB8ffQPfUrbjtlVwbtivB0gtKjS0VHnvyX6F9zAV3TpS1NRofuEC3DTxzVJ5ubPwlihsR+ym4n3JLLQJlIsHV32GJZJiF2PMMfhppHtHQAMKhZ+7YzSK1EofxxxXa2HTnW9jAh4+MqHuIvUwU2ZzsgaEbkXNljtUE286LSBPRpLKbqLxLUj9nfQZabm4BEb32985nN1iMr8dRMl82R/+knF9NQi9iu2hlfe7bvjs0iEzeGVow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(5660300002)(41300700001)(8936002)(83380400001)(86362001)(38100700002)(36756003)(2906002)(26005)(478600001)(186003)(6512007)(6916009)(6506007)(66476007)(6486002)(4326008)(8676002)(66556008)(316002)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9WYdNF5a+5ocx6NY/ykAtrChQW5ykY8xlHE80HnsUADgCmpMrAe2F8agaH+Y?=
 =?us-ascii?Q?/wzNFnMgGdzda9koURp5bOOlqvCaUCG1ZSkoFW2npTCElS+4Yg1TSUMposjs?=
 =?us-ascii?Q?1vN8UQtJxneGh2pzf9pqZt9j1cKH0GlZXET52gG9irLQW3rrZAdmnaHWpkLa?=
 =?us-ascii?Q?hQ0NSjfxdQR2AiC1BZSnOiqtbygVyJe4vi7mtV6fAQyMdGmGBlzsuQg4L6PF?=
 =?us-ascii?Q?UobxVB7SqLkUisBwt7FIysKs4qEk1EXJUI3d+nkGW8mekuWrZr7+ju67Iifj?=
 =?us-ascii?Q?LYS+bEzgCxT6kXsEz/XFCAHohCCipXA69Nk8zp2oOUtQdkklv5fGipcwhsof?=
 =?us-ascii?Q?EMsGHRxBAg32HAKfvWONa7SiHCqWxK/NpQkrKwo8q0qYaoYYbYyF7VlIfpyB?=
 =?us-ascii?Q?iLiEV7cZuCRtQ7EE+2QNlmjAGkPfn8MffYRBK2MMHCofsp4sf2+O2hjmrngo?=
 =?us-ascii?Q?Y7gIPL4vitq2gS3O6n+xdZZYL4j7lKMevgFPVeY45PFCtrWp9wMgkp7J+W5T?=
 =?us-ascii?Q?SCdVkYoYkV7q6Be0ZtpInJdO1Ua3Jfc6K9HSJiOzSvT/btL5uOu8/o5fzWze?=
 =?us-ascii?Q?17uyM+sX71KuJJHJassL8QIVSvASl0/EP5KF1Nk1316IJz+VXIXRsgtNk5Q6?=
 =?us-ascii?Q?6scMpiNu3JOvAcMhUFN7lAOGASjJGprKAXCmIpHzRNF9p3vx87J4aHRMN4Fx?=
 =?us-ascii?Q?zrjvvry5+AWeW4PAJiJL9wXH8vAaTG+ylLVxTsWhJFvBGpMUMHvxLOo4G7q/?=
 =?us-ascii?Q?RYDcE0J98U63CnCUecUE/TdJsp3kIAB+A2w3GSvl+MDtGmEEwHbXE4aTt8eG?=
 =?us-ascii?Q?+JYppkR/hNahXsziR5R1j/Etc2gdbOuxyAY12bzYMIwG49nKvpa8ZD8Esgrj?=
 =?us-ascii?Q?w+DdPS1AmNImIDSaAmacmBfPOkqrtNWmWqOeugZDRE9avB6yDqSkd/LdEFTP?=
 =?us-ascii?Q?nr/uY4cwzNqS3ooNeBtGS6heQE0TCoMuEUoRtfyUl+gWwnp1PKoc8I+HenaD?=
 =?us-ascii?Q?sId7tRDuLLyUR1q3pP3s1ELcTBYl9UMFVkpmu2bFqaZQFpsnmCiQ7cCu/JBh?=
 =?us-ascii?Q?2F+y2pjYuquXCWLyEQ4IJCGXTP9jBSqxUM+jlsbkjCBiARXx3wW2DFmkXkK2?=
 =?us-ascii?Q?jj+M+8rNDNUI0mB96oJK+nqA078AQm2/6DgQuMMLuZUudQriZHMGziJzP8MR?=
 =?us-ascii?Q?Xsim7/hN7wuZ0m4fOI0Bh5cMG1v+vMET+9A4R4jmkKPNFLtR7EyJXIEqdzLj?=
 =?us-ascii?Q?0jR+Uw/jg2TJW3hJsKjzPUVlnKp5yH/1BP3DPqo5s93tneQO+vwbXASMVAHj?=
 =?us-ascii?Q?BbGx38vW/WpudOmnsrYOZjwGdnAC1NUnzAhYqqUwssVstFn+8NfrJKXM/8IL?=
 =?us-ascii?Q?U72GEhl/lhqeiyLIRt9hfcehbHdnp5v3R6p834lpaXFW6fteRqLPFG87XP8n?=
 =?us-ascii?Q?KiWNSQpgEE56fJ0iHRzF3Dqxj/WSBsaSeuETwOM7V2xU6cwDxgEsD7JYK3LC?=
 =?us-ascii?Q?CdauhvC7R3oba+R4OfoxOpBrvDIHuX5wfq3D3hl7SMps9zgVUmEB5H28l8XR?=
 =?us-ascii?Q?z7f43LLZrZ9aA6cVOiMAcfi14y3/rR/fYBDqkbb9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08fa0de-3685-4cf0-11ef-08daf7e759a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 17:30:24.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t0twXS6JmQ7y/QM8iCmN3HOv778oReqiBvQTrUwVVrAUVQSyJifhNnDRcTNTMpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 04, 2023 at 10:38:09AM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Only UD qp_type is allowed to join multicast.
> 
> This patch also fixes an uninit-value error: the ib->rec.qkey field is
> accessed without being initialized. This is because multicast join was
> allowed for all port spaces, even these that omit qkey.

This commit message really needs to capture some of the lengthy
discussion that led to this.
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
> @@ -649,9 +638,20 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
>  	default:
>  		break;
>  	}
> +
>  	return ret;

Unncessary hunk

>  }
>  
> +static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
> +{
> +	if (!qkey ||
> +	    (id_priv->qkey && (id_priv->qkey != qkey)))
> +		return -EINVAL;
> +
> +	id_priv->qkey = qkey;
> +	return 0;
> +}

Ok

> +
>  static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
>  {
>  	dev_addr->dev_type = ARPHRD_INFINIBAND;
> @@ -1222,7 +1222,7 @@ static int cma_ib_init_qp_attr(struct rdma_id_private *id_priv,
>  	*qp_attr_mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT;
>  
>  	if (id_priv->id.qp_type == IB_QPT_UD) {
> -		ret = cma_set_qkey(id_priv, 0);
> +		ret = cma_set_default_qkey(id_priv);
>  		if (ret)
>  			return ret;

OK

> @@ -4551,7 +4551,10 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
>  	memset(&rep, 0, sizeof rep);
>  	rep.status = status;
>  	if (status == IB_SIDR_SUCCESS) {
> -		ret = cma_set_qkey(id_priv, qkey);
> +		if (qkey)
> +			ret = cma_set_qkey(id_priv, qkey);
> +		else
> +			ret = cma_set_default_qkey(id_priv);

OK

> @@ -4859,9 +4862,11 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
>  	if (ret)
>  		return ret;
>  
> -	ret = cma_set_qkey(id_priv, 0);
> -	if (ret)
> -		return ret;
> +	if (!id_priv->qkey) {
> +		ret = cma_set_default_qkey(id_priv);
> +		if (ret)
> +			return ret;
> +	}

Seems reasonable

> @@ -4938,8 +4943,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>  	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
>  
>  	ib.rec.pkey = cpu_to_be16(0xffff);
> -	if (id_priv->id.ps == RDMA_PS_UDP)
> -		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
> +	ib.rec.qkey = id_priv->qkey ?
> +		cpu_to_be32(id_priv->qkey) : cpu_to_be32(RDMA_UDP_QKEY);

This seems obtuse, why do we put it in the rec then call set_qkey
hidden in the cma_make_mc_event ?

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68721ff10255e2..8fcf1473fe6031 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4756,9 +4756,7 @@ static void cma_make_mc_event(int status, struct rdma_id_private *id_priv,
 	enum ib_gid_type gid_type;
 	struct net_device *ndev;
 
-	if (!status)
-		status = cma_set_qkey(id_priv, be32_to_cpu(multicast->rec.qkey));
-	else
+	if (status)
 		pr_debug_ratelimited("RDMA CM: MULTICAST_ERROR: failed to join multicast. status %d\n",
 				     status);
 
@@ -4786,7 +4784,7 @@ static void cma_make_mc_event(int status, struct rdma_id_private *id_priv,
 	}
 
 	event->param.ud.qp_num = 0xFFFFFF;
-	event->param.ud.qkey = be32_to_cpu(multicast->rec.qkey);
+	event->param.ud.qkey = id_priv->qkey;
 
 out:
 	if (ndev)
@@ -4805,8 +4803,11 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	    READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING)
 		goto out;
 
-	cma_make_mc_event(status, id_priv, multicast, &event, mc);
-	ret = cma_cm_event_handler(id_priv, &event);
+	ret = cma_set_qkey(id_priv, multicast->rec.qkey);
+	if (!ret) {
+		cma_make_mc_event(status, id_priv, multicast, &event, mc);
+		ret = cma_cm_event_handler(id_priv, &event);
+	}
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	WARN_ON(ret);
 
@@ -4938,9 +4939,6 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
 
 	ib.rec.pkey = cpu_to_be16(0xffff);
-	if (id_priv->id.ps == RDMA_PS_UDP)
-		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
-
 	if (dev_addr->bound_dev_if)
 		ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
 	if (!ndev)
@@ -4966,6 +4964,9 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (err || !ib.rec.mtu)
 		return err ?: -EINVAL;
 
+	if (!id_priv->qkey)
+		cma_set_default_qkey(id_priv);
+
 	rdma_ip2gid((struct sockaddr *)&id_priv->id.route.addr.src_addr,
 		    &ib.rec.port_gid);
 	INIT_WORK(&mc->iboe_join.work, cma_iboe_join_work_handler);
