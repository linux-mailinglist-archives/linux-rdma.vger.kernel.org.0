Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE96395EC
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKZMEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 07:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZMEM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 07:04:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FF1A067;
        Sat, 26 Nov 2022 04:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669464251; x=1701000251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+ZA4c9gFVzQeghCz51etRgq+pcgauXUjZ6sEl0YxQ4=;
  b=dO5f5ZBj4pn7pqWL8BPF9ZWOgLqk5LlaVVajSdfhe7hmpl6ab0Sd1kda
   /Bt4NRoMVYuGzsCCG6aKVjOVAaCtzTWW5l3S/cx6FMxFm1k6/eq3wZPwz
   bY2PKm4BSC8b00LH4B1aGFc17rj3Jj0gi84KmLYb5G39rY3YStBiF3dlN
   OBk54ugm2dW/vMdqmUmbAO15Lb2W23EPO8IBN5qAOrbqbfVCLKfZHcw35
   DlB0WLFFFd/TxLWtj2Aty+M7T8epxB7ZPf6Uc0Iwtw9Rl/Pf5bbY79rg+
   BClfh48MSs5pejgDG1R4bfiyO9mINuEf7IPieCJ1PVppu1t8Bl/pqGSxo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="297947131"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="297947131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 04:04:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="785150932"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="785150932"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2022 04:04:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oytug-0007Dh-1o;
        Sat, 26 Nov 2022 14:04:06 +0200
Date:   Sat, 26 Nov 2022 14:04:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, easwar.hariharan@intel.com
Subject: Re: [PATCH v2 1/2] RDMA/hfi1: Fix error return code in
 parse_platform_config()
Message-ID: <Y4IAtiDGTxGhaF11@smile.fi.intel.com>
References: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 11:35:03AM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero, so the error
> return code may be incorrectly set to 0 instead of -EINVAL.
> Add bail_with_einval goto label and covert all "goto bail;" to "goto
> bail_with_einval:" where it's appropriate. Add dropping some duplicative
> "ret = -EINVAL;" lines, as Andy suggessted.

This one looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 97167e813415 ("staging/rdma/hfi1: Tune for unknown channel if configuration file is absent")
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/firmware.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
> index 1d77514..44d8628 100644
> --- a/drivers/infiniband/hw/hfi1/firmware.c
> +++ b/drivers/infiniband/hw/hfi1/firmware.c
> @@ -1730,7 +1730,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  	u32 *ptr = NULL;
>  	u32 header1 = 0, header2 = 0, magic_num = 0, crc = 0, file_length = 0;
>  	u32 record_idx = 0, table_type = 0, table_length_dwords = 0;
> -	int ret = -EINVAL; /* assume failure */
> +	int ret;
>  
>  	/*
>  	 * For integrated devices that did not fall back to the default file,
> @@ -1743,7 +1743,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  
>  	if (!dd->platform_config.data) {
>  		dd_dev_err(dd, "%s: Missing config file\n", __func__);
> -		goto bail;
> +		goto bail_with_einval;
>  	}
>  	ptr = (u32 *)dd->platform_config.data;
>  
> @@ -1751,7 +1751,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  	ptr++;
>  	if (magic_num != PLATFORM_CONFIG_MAGIC_NUM) {
>  		dd_dev_err(dd, "%s: Bad config file\n", __func__);
> -		goto bail;
> +		goto bail_with_einval;
>  	}
>  
>  	/* Field is file size in DWORDs */
> @@ -1774,7 +1774,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  	if (file_length > dd->platform_config.size) {
>  		dd_dev_info(dd, "%s:File claims to be larger than read size\n",
>  			    __func__);
> -		goto bail;
> +		goto bail_with_einval;
>  	} else if (file_length < dd->platform_config.size) {
>  		dd_dev_info(dd,
>  			    "%s:File claims to be smaller than read size, continuing\n",
> @@ -1794,7 +1794,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  			dd_dev_err(dd, "%s: Failed validation at offset %ld\n",
>  				   __func__, (ptr - (u32 *)
>  					      dd->platform_config.data));
> -			goto bail;
> +			goto bail_with_einval;
>  		}
>  
>  		record_idx = *ptr &
> @@ -1837,7 +1837,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  					   __func__, table_type,
>  					   (ptr - (u32 *)
>  					    dd->platform_config.data));
> -				goto bail; /* We don't trust this file now */
> +				goto bail_with_einval; /* We don't trust this file now */
>  			}
>  			pcfgcache->config_tables[table_type].table = ptr;
>  		} else {
> @@ -1856,7 +1856,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  					   __func__, table_type,
>  					   (ptr -
>  					    (u32 *)dd->platform_config.data));
> -				goto bail; /* We don't trust this file now */
> +				goto bail_with_einval; /* We don't trust this file now */
>  			}
>  			pcfgcache->config_tables[table_type].table_metadata =
>  									ptr;
> @@ -1873,8 +1873,7 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  			dd_dev_err(dd, "%s: Failed CRC check at offset %ld\n",
>  				   __func__, (ptr -
>  				   (u32 *)dd->platform_config.data));
> -			ret = -EINVAL;
> -			goto bail;
> +			goto bail_with_einval;
>  		}
>  		/* Jump the CRC DWORD */
>  		ptr++;
> @@ -1882,6 +1881,9 @@ int parse_platform_config(struct hfi1_devdata *dd)
>  
>  	pcfgcache->cache_valid = 1;
>  	return 0;
> +
> +bail_with_einval:
> +	ret = -EINVAL;
>  bail:
>  	memset(pcfgcache, 0, sizeof(struct platform_config_cache));
>  	return ret;
> -- 
> 1.8.3.1
> 

-- 
With Best Regards,
Andy Shevchenko


