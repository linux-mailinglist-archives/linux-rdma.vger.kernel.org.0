Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB57E007D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347302AbjKCJwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbjKCJv7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:51:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E827191;
        Fri,  3 Nov 2023 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699005113; x=1730541113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WkknRm6nX90QgIdELr5uYwNuyX74IPpsNdDO/DJVRrc=;
  b=R8Us7/cAVE3Tw8fzW2MpQ4gReoXOCRnMqSf3vo0y1PhGehcQcGp4nNiZ
   9WrAfjo3quiqye24PhEUUhvfQh3bKNEOXgrPAfVoZF4vZDGQXppy6OhYb
   uaPjnm5U1RoqpRoVuxt95zv7IrgSQeeHVlhkIuDi+mpOlcZs47xiSondd
   QrWeBiN+VjBjWXp1ZWyqi44vuuvpDxKqeBWBaw7ZzC/iIfWhOWcghHvd/
   BFA1lPrcfBKWEL5LZD4ngv6yGvlGFNGxs0KIKr9SMVQpAuQ552xnWZaZz
   PeBQ58hIizzlsub9d2ilWcOQnvF/kgFlP7TM1EU/iN6uv86xTo4DT9P6M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="392798338"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="392798338"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 02:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1008765882"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1008765882"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 02:51:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 02:51:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 02:51:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 02:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTpLiE+kV+E39Kx6wHVuni9COdpwDGcw/kuhQfAgjHm8PS+dduriDX1XkCxzi3WeOeL9PsQrkXt3S/8/5jrBstb1N/T83IXOrDhA4upYlvaN5rW9UKYfXJYdLWeUc7DKLQT2QRsoDfsxYcsjknm69ySx7ApcCh7zv1/RT4j9g+baUSfHxKwAIn3k1MLBFFyQ+crISjmr49CeUptDID3DypBNqCjmzTa+fH+cQ+nvqRp1HXAoE6ZQtoapxfgWf+XEMx67AfDxtzyNy19US5ErnHjfUVwIEiIjRmhmiYesCAyXGoOkf3JrtFZz2uYSphjvHyxmFpi9RA+Dar4J4jyuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCBhppvveEjBlYn3PbAy+MOPAWqbtVRIMG7NTLR7vAo=;
 b=Kx8aVlHSr9/GCeU9//1paKcCmquU5wOMOi4LlNgKU6ujcvjlt23TQsv0E2ZNDBGIXyHq+dgCCZuur7yRidcGqgKCGwdaEhvde36xgjey/8mzG9FcPO+d9jsCCVtO/HWq5FJ0qUrurHcXkfhOWEP1lw9sKYJtn7TtwViX76kJoQUIdgl/MehnBihmzuDpjZuAkvlhjaq6+AxgFajFbs39xqAdPtx80y7Jflq4SlbvV7nTTAmHD2SSsGmm0/EYPtQxv14ahQ48iZPtye15dHscypCfiaBbzJndX9R3q5q4w5MLTW1k5kOpQKOh+PzMTvWZguQZs3bubr03uk85R8XxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:51:48 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%5]) with mapi id 15.20.6933.029; Fri, 3 Nov 2023
 09:51:47 +0000
Message-ID: <62aa411f-b848-44d3-9b2c-7173b86edbd2@intel.com>
Date:   Fri, 3 Nov 2023 10:51:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix a NULL vs IS_ERR() check
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eli Cohen <elic@nvidia.com>,
        <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <4ee5fbea-7807-42dd-a9b8-738ac23249d0@moroto.mountain>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <4ee5fbea-7807-42dd-a9b8-738ac23249d0@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c613d5-0575-48f9-4431-08dbdc527ecd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNGMeNiEZ2bdBU8eX6TfkV86sDN1NcFFJhL9ZSIoY6hLZ1V+9hMbfj6YfFyTJpApibnaqo57xqVaT97r1iFrRZjutXhmipIdYUe+uK3g47LkHFUl6DXEgqAcXmX+9cL9L8l9uKbSSeitsjreaGGIDLgzNI+NU5gXAKn7algmYg1uOWXrHw6q3vsh9FfSBrQUC5acp5Wghrl/AECK6yBiS5mP7T06zGAOiHcXPSdE7o0RfTM7AByPMVriCRN8hrTRB8gyJGaJCdC19XOMxZ/t+rXKhHVBtYUb3TT71uqa0GJkSFLz/5kcYZg5+RlkKYoo1Ldp2PfX54q+Wdfso/s+yStec1hit90T0EICIG2fPWTm9qz6mkXiF8YCq4oKjtVCa6JqBL30I7/cOfbAup4Btc5cL10aUdmFaokI2POgAvQ8miuiFBlU5UhkQ9acyJ3zSmZLOBnvYDN3XA8fPSJI0tF7Rr6eWYRuQCBp4/vdigQBvZqmG3/beVd6GFJB8p6EdMBzULmClauUxrsnJMhwc1kBHtvoEdxWcflnRot4NcjRGxa8C3uD9AgaYKqMWAzfWXItaLZ4nin30UVtBsn0lCxI8EY+u5p8YFOfGTqyH5v30WXzyWmUnnwzQ/O8oi9UeNpJwO2DyU5GAWrz/2nEzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(83380400001)(53546011)(38100700002)(2616005)(5660300002)(6486002)(86362001)(7416002)(82960400001)(4326008)(8676002)(2906002)(41300700001)(31696002)(44832011)(66476007)(8936002)(6506007)(6512007)(6666004)(66946007)(316002)(66556008)(478600001)(36756003)(54906003)(110136005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZYb3hjb2xPOUhvaXBkUGx3R1J6R2VhQVdPN3VjbGVLQTdKMHRPMFhINjBt?=
 =?utf-8?B?Vm15cjBJaEJDKzhHa3pYZnd3dkZ4ZkI1Yk5scE84YzVabHdqY2Fic2NVS3lV?=
 =?utf-8?B?SW1kNmFEL2UvUUF1MVV6eGpyQlZGeHl3dmtkRXdjQ3IrRmJtNHVBY3A5OG05?=
 =?utf-8?B?d0t1Yi8zNFRKUjFYdE9nK0VpbmcxQ0FPeTVmaVlpblNIdjNTYkQvMmc5UnIw?=
 =?utf-8?B?T2tDTmczUEZjbmJ6bVdLRlY5SVNqUXV3dGwzZlI4aHVGN2NTOENJcDFyRit4?=
 =?utf-8?B?TUJabmtBaVdnOEZ5VUJ5MUQrZGYrSVo2Q05IakdnVXI5QzZIVGNFbmgxL09y?=
 =?utf-8?B?aDB3RGtvZ2xUM2RGZUZHRkJ1M1NHU2hpRUJqNFNVd2JxVWZINjRaSDd1ZUZz?=
 =?utf-8?B?eGIwM09HSFJXcVFFODRlcVdTb0x2SXJlNVZVN084YnpGUU16cHJINUpLVkR6?=
 =?utf-8?B?VjZSa0FIV0pwMGMvbHB5QlBZamFHdjNkMVB5Z25ieWR6c0JocjFsaFZobjd3?=
 =?utf-8?B?a3BqVW5MVEJOV3lwczdyUnVEeVNaSUEzVmIwUlV4c04va094UkJ3QVpFSTRJ?=
 =?utf-8?B?QnMrV2JONERjZFVMOXp2cmhsWkh0TTlGc1ZQM3VoRkpXNUtVUFlqalpyK240?=
 =?utf-8?B?dldQbm9IaUFWNVJRRzU4ZWZiT2dCT0NhbjFQUC9HTG9vVzB3dDhUODZVRHNU?=
 =?utf-8?B?MnNwWDMvU0h6WmgyRHc4WjlmS0NXU1Zxc2NUUEVjcklJazZJTUNHSkZBVDlh?=
 =?utf-8?B?MksxVU5zM202LzVoNllNdnFLMldZQ3A5UTJSbXFoRERqMkw2elh6T3N1K0ZB?=
 =?utf-8?B?TFA3YXMzWHlxOHVUeVVqYWZqQlNCNDAwZnNzUSs1cmZCL1pvR1ZRRWdVL2sz?=
 =?utf-8?B?MmdwRWxPdnNzeTVBTnJpM3RmVElKSGI3bW4yTmhPL2paek5UZzBpT1BjUldR?=
 =?utf-8?B?RC9WZzRJcncwUXo3TXIrT1diSFM1cU85M3JrNWR4UkM2N3NTcFNRZlhJdVBP?=
 =?utf-8?B?MHByRzRvNzhQZi8vSEtIaVBrWEtrUTVtbkRuMXJFOHN6d05jU0d2ckh3TUlz?=
 =?utf-8?B?cTkzY0cxVUdVMjlISzJ1WENZUENvb29aYUQ3cmlBTmI4djZzMmlzamloN2pv?=
 =?utf-8?B?OE9EaU1yeWtxMFgxUTZiaEp5YmNqbmg4eUlCdkIxNmVCQUxoa2hVL1dEay9n?=
 =?utf-8?B?ZHpHSTdMQWRVQ3NQQkNPaUl6eklWMUdhSjZ0V01oS0liSi9WSzlWYUxuejRL?=
 =?utf-8?B?WUF0Mi9JWG95TVZjMmZhZGRyT3RNM2gxY0JWU0Y3bjZxc2h4cWRvd2NYeWVP?=
 =?utf-8?B?cTVQNk1PZlo0YTZFY2NaMmR1aVdFbFAycWExdlZsd2tBRFgwb1JHZTlHZVN3?=
 =?utf-8?B?RSttOG54bDZQakJUZGgrWFRsNEMxQWU1SUQvOEVKbFpUQ2E0dHJIbWNEdis1?=
 =?utf-8?B?RU9KaStxZHJxUEZKTW9zN2lkTG84Q2gybmNrR0pRY09IQkExeVRUZHVHNDZk?=
 =?utf-8?B?WGFzTlk5dWYyRmR3Z1ZPS2ZkNW5LWGlvYjNhV2YyUUxGQ2Iva2dTSFNMVkVL?=
 =?utf-8?B?cXhXOE00V09kQlMzNDh5ZU9zMkFvck5zbndXUmUwVGxQMGFwYjBROTlkTmRK?=
 =?utf-8?B?T0VxbnlCNmlocDF3eE9wbVhBb21lY295enNPWWNVNS9BRm5INjBKYjl2TkR2?=
 =?utf-8?B?dTNQQThRZmV3amlCVHZYcjVFOFBLYWN4bTVKQVFMT09Valhza291aThqMVJ4?=
 =?utf-8?B?Tm9Ic3M0citudDdzRTZmMVBxN0FPck5oQzlMR0tGTzlJY2ZpOU0yWFN5Ukxj?=
 =?utf-8?B?dnd1V21qaWppQmVBWkN5V3hRK0JlZGxPZ1Y2YU5oZHpIZTlxb2ZrNWNIQysr?=
 =?utf-8?B?N0w5NWxXeUZ3dy9YaWpRNTBydk83b2MrL05RZkZsNzdZd0FzdGhRNU9JR2k5?=
 =?utf-8?B?SEpacUs3KzQ3SHpqQXJIQTlxZHEzOWp3eE1kb1VLWk1zblNJZ0FzTW12VElK?=
 =?utf-8?B?NUw2RUdibDJmbGhIck12aWRRM0pXVHBMQ1dzVXE0TkR3WFdLODBZT0RQS2ta?=
 =?utf-8?B?T1FRVHNESlNmbTRGVXFYeUNxalFPWHZuTlg3eXB4VTVwcGp3cjRmeG5NR3Nq?=
 =?utf-8?B?dTFHTTVoMmpJSndKWisyOVFOV01zdENOYnNLaTlwdWdCTFk0aDZKNXMyTDlL?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c613d5-0575-48f9-4431-08dbdc527ecd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 09:51:47.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2h7IiGEx+Rx54BbLSeMq0KN8sxH6UJSkJnFNUkRrpakQUheh4wUFfGmimls4jnn2jUAwLYpMNhAOvd7zrvN9kDOHdL2cytO5sUMsL2ff4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03.11.2023 07:36, Dan Carpenter wrote:
> The mlx5_esw_offloads_devlink_port() function returns error pointers, not
> NULL.
> 
> Fixes: 7bef147a6ab6 ("net/mlx5: Don't skip vport check")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I *think* these normally go through the mellanox tree and not net.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
>  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> index 693e55b010d9..5c569d4bfd00 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -1493,7 +1493,7 @@ mlx5e_vport_vf_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
>  
>  	dl_port = mlx5_esw_offloads_devlink_port(dev->priv.eswitch,
>  						 rpriv->rep->vport);
> -	if (dl_port) {
> +	if (!IS_ERR(dl_port)) {
>  		SET_NETDEV_DEVLINK_PORT(netdev, dl_port);
>  		mlx5e_rep_vnic_reporter_create(priv, dl_port);
>  	}
