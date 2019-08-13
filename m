Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138F88BEC4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfHMQjl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 12:39:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:48418 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMQjl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 09:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="260176044"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga001.jf.intel.com with ESMTP; 13 Aug 2019 09:39:40 -0700
Date:   Tue, 13 Aug 2019 09:39:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Vladimir Koushnir <vladimirk@mellanox.com>
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Message-ID: <20190813163939.GA11882@iweiny-DESK2.sc.intel.com>
References: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
 <1565540962-20188-2-git-send-email-haimbo@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565540962-20188-2-git-send-email-haimbo@mellanox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 11, 2019 at 04:29:20PM +0000, Haim Boozaglo wrote:
> From: Vladimir Koushnir <vladimirk@mellanox.com>
> 
> Added new function returning a list of available InfiniBand device names.
> The returned list is not limited to 32 devices.
> 
> Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
> ---

[snip]

> diff --git a/libibumad/umad.c b/libibumad/umad.c
> index 5f8656e..9d0303b 100644
> --- a/libibumad/umad.c
> +++ b/libibumad/umad.c
> @@ -1123,3 +1123,44 @@ void umad_dump(void *umad)
>  	       mad->agent_id, mad->status, mad->timeout_ms);
>  	umad_addr_dump(&mad->addr);
>  }
> +
> +int umad_get_ca_namelist(char **cas)
> +{
> +	struct dirent **namelist;
> +	int n, i, j = 0;
> +
> +	n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
> +
> +	if (n > 0) {
> +		*cas = (char *) calloc(1, n * sizeof(char) * UMAD_CA_NAME_LEN);
> +		for (i = 0; i < n; i++) {
> +			if (*cas && strcmp(namelist[i]->d_name, ".") &&
> +			    strcmp(namelist[i]->d_name, "..")) {
> +				if (is_ib_type(namelist[i]->d_name)) {
> +					strncpy(*cas + j * UMAD_CA_NAME_LEN,
> +						namelist[i]->d_name,
> +						UMAD_CA_NAME_LEN);
> +					j++;
> +				}

This all seems overly complicated to avoid allocating the strings separate from
the pointer array.  Why not just allocate the pointer array and strdup() the
names into the array?  And then make unamd_free_ca_namelist() do some work?

Ira

> +			}
> +			free(namelist[i]);
> +		}
> +		DEBUG("return %d cas", j);
> +	} else {
> +		/* Is this still needed ? */
> +		if ((*cas = calloc(1, UMAD_CA_NAME_LEN * sizeof(char)))) {
> +			strncpy(*cas, def_ca_name, UMAD_CA_NAME_LEN);
> +			DEBUG("return 1 ca");
> +			j = 1;
> +		}
> +	}
> +	if (n >= 0)
> +		free(namelist);
> +
> +	return j;
> +}
> +
> +void umad_free_ca_namelist(char *cas)
> +{
> +	free(cas);
> +}
> diff --git a/libibumad/umad.h b/libibumad/umad.h
> index 3cc551f..70bc213 100644
> --- a/libibumad/umad.h
> +++ b/libibumad/umad.h
> @@ -208,6 +208,8 @@ int umad_register(int portid, int mgmt_class, int mgmt_version,
>  int umad_register_oui(int portid, int mgmt_class, uint8_t rmpp_version,
>  		      uint8_t oui[3], long method_mask[16 / sizeof(long)]);
>  int umad_unregister(int portid, int agentid);
> +int umad_get_ca_namelist(char **cas);
> +void umad_free_ca_namelist(char *cas);
>  
>  enum {
>  	UMAD_USER_RMPP = (1 << 0)
> -- 
> 1.8.3.1
> 
