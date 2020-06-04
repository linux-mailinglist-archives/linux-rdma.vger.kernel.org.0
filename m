Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0881EDCB6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgFDFlY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 01:41:24 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:48670
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgFDFlX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jun 2020 01:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqxzdn6bJcBrKzpgmLDwQFhfzjTts5JEuJgBxZcF7WzkpVCdb5Cz9yMzaBLbGzrdep3WmwgkIqx/ikLKWRHi1Ee+BnMZJ3D5p42QRn5OFWLBWgaRHt7+W/HFJM/DG+RdatRg+4n27AoOiW203oP8lQQkBvoGPEadt6VAk339KKL5hMuPsuXMfUbXHMOqCp/pHzVF7H3XG3RDpSlscyvwiQEWTVSP33MKbeAuh5//chR4C3EZSDu6hsrBTFotBN2sJchOTQcoJp7qMuJkRC9cUdBctgCWSCvqSWsRKn+1HVMOupPrqbpEgMavajKkbyJE6gwoOZAPOYazgQrUpRhz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzhzH+a4/oSdXJTWe3th/r3ALOW4JJTp+smCvWKsSpQ=;
 b=TFqVSdMfh+uooUwz4LnCz9S0gt/7c4y5utgwxrymzCpgACtniha8RWv34WsNPCyAyRabClS5dgql0Wf1dt+HwgAAiNYNu/Dj7klxeT8ofuWaiX5IYQAU89/MqEoCQqHLZQ2PnkggEmRnLaHYfmmfnpvRHh3jlciPs230IXnelsZROK8zZsvJY3N16SXo1VeVK2F9gRCA9H7jvFARPChlfpI28Q+U5nXVTiLsEa1UTwUO0ruSkkAzngeSJInfkK9hovRv2E8Oyu2lsHiclZxuHkxsxhnfqfGznGB44soA4zpDYf6M8J4oMoZqq91ns2eewTuHVUmPT2x+bVKI5eaegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzhzH+a4/oSdXJTWe3th/r3ALOW4JJTp+smCvWKsSpQ=;
 b=qqj09P3Vx0oClUEm7atu6DiAU/cyHVhq93zPt+xGEJY3tyQTIT56qPb6mdmD+Ni7USoyvYNC28sQavH6Zdrf4oLV2fGTr43IXhARMRcepobUFWug01of43TAiFvrg2uOX+ZtPTz8Ldp7Gf4qduJHyesXljloVgyokHAyfEM2zI8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB7PR05MB4156.eurprd05.prod.outlook.com (2603:10a6:5:18::21) by
 DB7PR05MB5017.eurprd05.prod.outlook.com (2603:10a6:10:22::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 05:41:18 +0000
Received: from DB7PR05MB4156.eurprd05.prod.outlook.com
 ([fe80::39ab:622c:b05b:c86]) by DB7PR05MB4156.eurprd05.prod.outlook.com
 ([fe80::39ab:622c:b05b:c86%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 05:41:17 +0000
Subject: Re: [PATCH] net/mlx5: E-Switch, Fix an Oops error handling code
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Vu Pham <vuhuong@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200603175316.GC18931@mwanda>
From:   Roi Dayan <roid@mellanox.com>
Message-ID: <3f29e5cd-f02d-3eb0-f2d6-601702c6a2ae@mellanox.com>
Date:   Thu, 4 Jun 2020 08:41:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603175316.GC18931@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0077.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::18) To DB7PR05MB4156.eurprd05.prod.outlook.com
 (2603:10a6:5:18::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.170] (176.231.113.172) by AM0PR06CA0077.eurprd06.prod.outlook.com (2603:10a6:208:fa::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 05:41:16 +0000
X-Originating-IP: [176.231.113.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6565d77e-d85e-4692-56c9-08d80849e708
X-MS-TrafficTypeDiagnostic: DB7PR05MB5017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR05MB5017A7512FA2BB440E3CFF65B5890@DB7PR05MB5017.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1olN5pu+AhjrINwsm5yC+2Cioi64/gaBTOq3gGW7N9JqCXOXluRsz0fcX8hpNCBZr+ubglhmJfVOXhiXLYuMcYNIeJcPejsuA2ud2rcW8a5LnvZez9K9+4yZfqPrgm00iARbq9+5BLZcL5hywFEoR8VGrzj8GlC0muLmJxDKOn8Z06onhrpqn04MYtQ79uyzIS6S5/2kpqM/i9AFLHKULbWRKDu3coNyzKINMBjv3iw9GQDPbDejhG7yUUsqaBT9u7cS9jCHjZy6ZOAV60NDe90wDupStWOaCs0hdTyXIYNJ4aKvWEvsbhMXFHqzLS78keCL+Y0CsI7SipN2E2C4JZFUSkxeX+n9GoRqe4hcz6k2EUIrT9BE4SePC9YHqImL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB4156.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(31696002)(86362001)(36756003)(31686004)(53546011)(83380400001)(478600001)(52116002)(8676002)(66946007)(66476007)(66556008)(8936002)(6666004)(316002)(2906002)(54906003)(110136005)(16526019)(6636002)(186003)(2616005)(956004)(5660300002)(6486002)(26005)(16576012)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qFfcBO08pnpcDAsoYRkLQGG/TzepLbJHhETG1ecrK6C5Agsmca4ZiOPSTDWOxRPa5iQtHennWItys9nD0zDJaHn2sALB6xgpVdDyqq4UMK8jHwRZBtKPYYMM29y2YC1HAZN2JIvjfLll9BTHOirXgGJd8cor/9AkMJZmeXMip6MKdibpXzPiEF73XKxWpRwhm008ga7hwWrv6l8McT6BwQmqiAbCho6SNG5h0XTiKjeuhME5kZjFpKQhVl4h3/RAert5GmaHyaTWgjVGwkIofBYqigQQro6Q9iJLPRcaZisCuwG2cgGvpnb8ublAcdTns4CzPvs+XsSlmX5GfX6kbBum3DYg7YSKL9wmPyeHZ4juT6nPOWvpy710cNSY2gRJ9By6BwoBMvLTNdrRWTvCeR/qG+BZQfuCnRANX/5pmA/V9HOXaLRq6mqAkaZfHqyJrvpdYH1e9d9i94WU7MYvVPCGTveS8oTDcpgBeB45BqDaX3ns5qF+I6OEYrmLS/qG
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6565d77e-d85e-4692-56c9-08d80849e708
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 05:41:17.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjLOLWh4E5YBsl6BOHDWOMkD2IQl/TvDIw24oX24voPIuboWoK76p6wqW6BVs0ePTjFF6tCMkdAL0pGjtJDxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5017
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020-06-03 8:53 PM, Dan Carpenter wrote:
> The error handling dereferences "vport".  There is nothing we can do if
> it is an error pointer except returning the error code.
> 
> Fixes: 133dcfc577ea ("net/mlx5: E-Switch, Alloc and free unique metadata for match")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
> index 4e55d7225a265..857f6193f3b14 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
> @@ -301,8 +301,7 @@ int mlx5_esw_acl_ingress_vport_bond_update(struct mlx5_eswitch *esw, u16 vport_n
>  
>  	if (WARN_ON_ONCE(IS_ERR(vport))) {
>  		esw_warn(esw->dev, "vport(%d) invalid!\n", vport_num);
> -		err = PTR_ERR(vport);
> -		goto out;
> +		return PTR_ERR(vport);
>  	}
>  
>  	esw_acl_ingress_ofld_rules_destroy(esw, vport);
> 

thanks!

Reviewed-by: Roi Dayan <roid@mellanox.com>

