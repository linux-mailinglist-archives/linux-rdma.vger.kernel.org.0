Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892A7860ED
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjHWTqC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbjHWTpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 15:45:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18610C4;
        Wed, 23 Aug 2023 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819934; x=1724355934;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Yd9VEieFFlffzurv9/t0dlKZ/+YelF4k3XttafzBi/g=;
  b=HbWgXOZDke/Vj6bCrT4PxFanSuLmP5uyC4xO++2Zln4auvSt5fS/xLxu
   Uq8ducNnwji5TMFwLJdnKuo/arZIT6GtBreJy/Dpv3BVCUGySVIV8mPYZ
   P/xtmAa+ZqhdtuUMp5JGDIX/60SlGnNpvvptR9Yy6LTBIqmy4nDUkLttr
   DkQfAAZNA8+mznRKkjtPy/MheK0sx7CUmIs5Ralr57DtSPzXzyZmdWUB3
   yQehCg+bGMXqx+0qwDq8DGItZXRMTmpWOLthGZYBq3IdFBCmTKJ0JFj2R
   6OlHhgpL6mwzd+wRovUXieaPT080gmLXaBw8J05OW2927XCRRzkx1IOaz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374233563"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374233563"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826846659"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826846659"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 12:45:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:45:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:45:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZidxmW6eFPNRxLkXvlk1X9PeGjBLEXYLB+2VVWcwXQBVV96WiR21or6mm/qWd7JBcJPQSErxFSEfohyMn7tk2T83rXXmoUyMlsZMWa6c+ewS7N07ZY37pdzu9lbm7zh24kq4b/Dlf2b1SRhmTlS+lwt6Ig88umJtAA2qzvjtuY/1QBafVBHTioAme6+TGY7KqA/wwfBXNttV7YSVvFNVb4epcRnNnQiTPj2oySrxvJzAbry0m2I44d+S25aWsjkX6X+LX5T7dxBKgZazZcV1nDk5VYPuFcapds4gvXm14TaHODSjQDB5q7tAkT3xYdIKGVA3LvZWXoYcpS/jSluygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVnoHwc/yczs9sHGxTiQd11gYce4Or4xS8TYuTv0HEU=;
 b=d6R3yB5inutF3X2NW2tDU7EkzgdAoIE+ZbUKAjWJs4F3aUIMR7Bm+J+tN8wQmdQbFgPI4zcDP0C5gfyHY/2eDMfz6xyHPkZbSAGraK7vPjMJLryiHX2rSlclXV0d+0Mq2cuVGvUxH1hGrr3hkIy5Tk5w1ty5++6caqIdf6ks+HwZ38W88PJqhmXgsWNtHuNSkMEfCGuJaSJR0fO5if1FAdlYRCBDmFiBSjLt8tDWOIxxcjYUBE5be4PBHDRFGDGHNxdNhaeslwmYPAyWL6IIXsuk/Ge3hVU5+p7M4RKdH1IfpVaKU5ML86y30XLXQQFay8uJBo3qWktLnDeWeCZGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 19:45:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:45:20 +0000
Message-ID: <414e1ec9-e3a8-d555-3d12-8689a5cc64eb@intel.com>
Date:   Wed, 23 Aug 2023 12:45:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230822062312.3982963-1-ruanjinjie@huawei.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230822062312.3982963-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6f22e8-b245-4247-b3d3-08dba4117c08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TW29oN2nar7h70hd5izKM5uINkeeGAsxRR1Fzbpsiu7a35FEcURG4jjavO+QVbtaOEtdBDPgITyMWCF5GJKUauy69zlMtPNaBfUib3mcggSnU1DQ5suxXCNCPQWleo3UvB/TSJ3FEugsyNkMIMA7nVvYxByprFvFFU8TCSdArMRGaSq32jUydBUUHYCDkdQIgo1Nvkxe/Y8RfC/IvLLPlZwj6PiAdCfRpenmWhS1x8S51IiG5EKBAfNmY4fgJhg0IQ4EoAjGAI9gnKQ/805LX2nkQPKO2SfabBd14bc4SOFzdP95LgYLKFgti7ogQyNb0hqRcQuTLIemvUAAd1E2Nm85zGFKKNTHLAiUPN0eaBvOaGMupcV2H31arzmxUftB/SvghttR2IQsRf/3TeXaUTybb+Gmmc6SpW5Wpp9Ef4FNa1DSw0Dz6uiKnKhbpG6Sv1+b1ifaoT6B4pSJb4J2TXA/nN2LXr/bnxgY/6bd6w7qnbMu6Jj20qDr82jWKIrKiFJnSSkuMuCgdD9xdAQnwpBoNaVwCvTfMictsjebavwha2S4JoMKJ2s+DyCM+lO64/c5vNd09zFkPYwk9TWibYthAtwk3i4C0zTuS7f62odaZL3GtjnUjM/QmDevbb9/aHAty8Gn4DvIyNTM0eVHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(186009)(451199024)(82960400001)(478600001)(6666004)(6486002)(110136005)(6506007)(6512007)(2616005)(2906002)(41300700001)(8936002)(26005)(86362001)(316002)(5660300002)(53546011)(8676002)(66946007)(36756003)(31696002)(66476007)(66556008)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpMOXhHREtZS1FEdmgwcE42cVYyRXJOTFRYOHV1c1NDOHduN05PSVZiaUNB?=
 =?utf-8?B?RC9neEJqYVhESU1oSWQ5bCs3VkkrUXZ5Ni9sQUt0bENncG9sQXJNbmJzRHBx?=
 =?utf-8?B?SHRyUEFoSURKemZtKy9ZMWtJOUdRV01yT0tXZUNYQm5raFB5eHZsbUR0NjRC?=
 =?utf-8?B?ZmszWEliYWVHbGhqUEVzL1ZCQVNDQ1cxTk5iYzNuQ0h6NytORElqOWVBeDdi?=
 =?utf-8?B?UVJCMUE1RUdrZmdGSDBFNWhFUDBPc2dtdjZHOU51ZXh3V2pBYm8yOUovU1p4?=
 =?utf-8?B?NG1IVTZKZ3FwYnJiaTl0b3JLTXZtejFaWUtWQ3lmU3JIRW4vNVpMbWZlbFI4?=
 =?utf-8?B?d2pWUmZGa2MzbWV6UGw0bE5FeUc1Sjd1NDg3MGhjejIxMzhGbkNBVzlQUFZ1?=
 =?utf-8?B?MXNEQWZrY3BkdXhGd1h4QWFVSW1PTzJBbVBLc21QYzVUemp4aWsxcnVPbHpn?=
 =?utf-8?B?T1NpNktscVVxSEttbzdNMkRjUnBUWnljTXdEYmFHREJoMDF3MmZLSTdVeTNp?=
 =?utf-8?B?cGNlcGF5YlkrTXRCOE8rTW9sdUFaNjVhM1VtdThYNjRFLzN2QzNqdEJDRzRZ?=
 =?utf-8?B?Q3lJVXNsUzhLYnY3RzAwQlNuVVJwdEEyYXYzZVFkQWd5VFh5eEc0bFJFQ2Jw?=
 =?utf-8?B?c1p6cGhpOEtkaDdwQXYrS0NsWk5QdW0xUHUreXBkSmxDdm50K05Tand3eWN2?=
 =?utf-8?B?K2RZMS85UGhIKzZwRW9VeUxnUHZRZTMwMEpEb3UxcSs2UThwLzlBb2lnRXc2?=
 =?utf-8?B?VnE1dkRZWlZ1UWUrQjIyTFYydDd0dDFWQi9nOUhFSm1iK1NCTmJLMlJFZ0Nr?=
 =?utf-8?B?UFNKck81ayt0TFdQWUJvRi9hZUJ5enFNTTZvNXc1dnhURHRFcW1iMEd2VXYy?=
 =?utf-8?B?NHNIbWdlNFdTOTBVbjJBekNwUkcwUVhGRDhIMFkzN0x4bGxUWWlETkxGK3ZV?=
 =?utf-8?B?ZlB4MkY1c3d0TURKQjAzNGdSUFJPeG0veWNBMURWRHJyNlFnRFBwb1BmeXBx?=
 =?utf-8?B?TkNBSm16SUFyVXRqQ1VkTDJDeDRQMW1vaXdFaHdJby85dXl5N2JIcDREUmp2?=
 =?utf-8?B?aTA5bHc3eEREcnBaRzlWSU9SdjNyT3g1bEJBYkczYU13ODJlRkxBcUFmdnJN?=
 =?utf-8?B?Rkg2dEJyK1dXWS9sazlvbm41SmRXdUFuVGdoUU9GSFNIQTZzZk5hZDV5MXFI?=
 =?utf-8?B?MXFEQXVvVitQWTdPczkxQTZQUDloTHE1WHhFOW00MlAzaGh6cEhLWFJLRmR4?=
 =?utf-8?B?b2dlY3NXL2oyZGpqUlFZM0tvSHlrZHAzMXJMNDNiWk5qNk4rVkNFUGF2VlB5?=
 =?utf-8?B?aTVIVk0rNXYvYzE4UUY4U2VhTHBKUUpxV2ZGbkFKYmZrKzV3aFFjREJlTkY1?=
 =?utf-8?B?dUpTMFVkUjJYcHA0cUJVQzFKSnBZckhtYk9BUVd1QlAxWllhSmJsamk5TWd2?=
 =?utf-8?B?ekNUVkltQTU2NGZUSTBRRFd4S284cWo5Z20wTGt5Z0NJMldmY1FkdW5mTm1l?=
 =?utf-8?B?N080Mys3c3ZETHZEMTJJTWZsZFdkZmpXM1FOUzBseWlwRHRLYTYza2lFeW1a?=
 =?utf-8?B?aUQ3ZzVLNWl3R3RJN053RjNUR3dZTkJxYlJmdStuSUQ0RTRsWkN3Ti94UzJJ?=
 =?utf-8?B?em55bytSOFNsQmRCY3oyM09lTEpraTNyZ2NWOFp1UlFEV0ZUWWQvU3p0Rms0?=
 =?utf-8?B?K21VTXdXZlM3TEpjU1ZzT3RBWkROTEthdndHSWVhbzB3K3U1aGpPSkowUEY0?=
 =?utf-8?B?NVBqVzJKZVpoamltTHdwNHFRT0ZlYW9KY05JZFhmcTBrS21vTHVFdmFUSXla?=
 =?utf-8?B?VHNkYTZMY1lxaUwzRlNySG90bzBBQXQzbllQTy9YQVM5a3VIUERCZGtISGdh?=
 =?utf-8?B?c1N2VUJpeTJTWmVjVDJkNEJhOHM1UHFTRy8wUDFSamFGaTJRSVQvYW5KeWsr?=
 =?utf-8?B?dzJGT2VqM2lKeXVxY3NOR1d6WXZJMmhKK2I3L1NGVVhXUS9wZUdtaGJRSkk1?=
 =?utf-8?B?UkVkZmlxdWtYTGFmc29Tdmk1clFzaldwbjJ4WkZrbkxYeWhicjREMXZ1RGZp?=
 =?utf-8?B?TGs2b0cxNWd2M0xqVVlYV1Y3MDU3RUxlRG5ZVXE0TkZwRVpwcVVMRjdaOFV0?=
 =?utf-8?B?ZmZNT1NqV1dQUUdHOFphTmF0WGwvVSs3MEw0T240R3pPNmtQdjRXc1N3WEZs?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6f22e8-b245-4247-b3d3-08dba4117c08
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:45:20.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czRtxpHQMahBLW0/nF/g6EMyAcr36ehSXh0AoWZAatcTBUH8uOsNFhKF2RW3sYjaOHKNsfqfQL8tNCyiY9eInFmGiIdrG7HEC9OEZuKRIms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/21/2023 11:23 PM, Jinjie Ruan wrote:
> Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
> simplify code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c        |  8 ++------
>  drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 10 ++--------
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> index 934b0d5ce1b3..777d311d44ef 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> @@ -1283,9 +1283,7 @@ static int mlx5e_create_inner_ttc_table(struct mlx5e_flow_steering *fs,
>  	mlx5e_set_inner_ttc_params(fs, rx_res, &ttc_params);
>  	fs->inner_ttc = mlx5_create_inner_ttc_table(fs->mdev,
>  						    &ttc_params);
> -	if (IS_ERR(fs->inner_ttc))
> -		return PTR_ERR(fs->inner_ttc);
> -	return 0;
> +	return PTR_ERR_OR_ZERO(fs->inner_ttc);
>  }
>  
>  int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
> @@ -1295,9 +1293,7 @@ int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
>  
>  	mlx5e_set_ttc_params(fs, rx_res, &ttc_params, true);
>  	fs->ttc = mlx5_create_ttc_table(fs->mdev, &ttc_params);
> -	if (IS_ERR(fs->ttc))
> -		return PTR_ERR(fs->ttc);
> -	return 0;
> +	return PTR_ERR_OR_ZERO(fs->ttc);
>  }
>  
>  int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> index 7d9bbb494d95..101b3bb90863 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
> @@ -507,10 +507,7 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
>  
>  	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
>  	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
> -	if (IS_ERR(port_sel->outer.ttc))
> -		return PTR_ERR(port_sel->outer.ttc);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
>  }
>  
>  static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
> @@ -521,10 +518,7 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
>  
>  	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
>  	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
> -	if (IS_ERR(port_sel->inner.ttc))
> -		return PTR_ERR(port_sel->inner.ttc);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
>  }
>  
>  int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
