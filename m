Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C9BBEBC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404316AbfIWXDv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:03:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33501 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404306AbfIWXDv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:03:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so9867pls.0;
        Mon, 23 Sep 2019 16:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivLc6erw8/HbZgInQ/oFeR2xF7fmDnKjBtxCkrDkEuQ=;
        b=K8Vmx7VM5YyWmpwA5uikiPSKEzkUE+8GWfO6BtH58rKs/3J7QmutO1G/PLzKL6Ax8T
         HwLCAwCyeDBy2oWmQlgyOP4n7CS2pL2Sm/18BkchgWi5xwvBFhJ8TzToq5/MhiQ6vBRs
         bI4hpNxSY2YMjPGFdnP0VuOSXZ5mVrNSpqfSN+ywcxpbFG3tvOuUzCD/CtI/cYlrBgv/
         MWVQdk5CBi7sQIxrmKLcdLPfFgtW/LpTgt5ER5s1jUQnBg7SmytbUz1orEi8EwVqiM63
         V5umdYsEqoIkjYxgm2HAd3/YL10BLse/9dEOfwDUJauNDnSb6tkInJmBMmiZetp+/td+
         lQsQ==
X-Gm-Message-State: APjAAAXDmS3F1NyaZ97BauDCOzzvoOAoZyTYBcIWMwGBu9R0zUMg1qhH
        KCbDDD0t8Z4tGv5ngAfWNdM=
X-Google-Smtp-Source: APXvYqwW+mwkK6P69aF8rvhQjAPCpT2o2IGgZPFdGCKZojMaQynyZH2jvNZ9+cLBHFOA3xv1g5oM7A==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr2295506ple.34.1569279830606;
        Mon, 23 Sep 2019 16:03:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c14sm16513884pfm.179.2019.09.23.16.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:03:49 -0700 (PDT)
Subject: Re: [PATCH v4 04/25] ibtrs: core: lib functions shared between client
 and server modules
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-5-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f511731a-f981-8cd0-97df-03105a105b36@acm.org>
Date:   Mon, 23 Sep 2019 16:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-5-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +static int ibtrs_str_gid_to_sockaddr(const char *addr, size_t len,
> +				     short port, struct sockaddr_storage *dst)
> +{
> +	struct sockaddr_ib *dst_ib = (struct sockaddr_ib *)dst;
> +	int ret;
> +
> +	/*
> +	 * We can use some of the I6 functions since GID is a valid
> +	 * IPv6 address format
> +	 */
> +	ret = in6_pton(addr, len, dst_ib->sib_addr.sib_raw, '\0', NULL);
> +	if (ret == 0)
> +		return -EINVAL;
> +
> +	dst_ib->sib_family = AF_IB;
> +	/*
> +	 * Use the same TCP server port number as the IB service ID
> +	 * on the IB port space range
> +	 */
> +	dst_ib->sib_sid = cpu_to_be64(RDMA_IB_IP_PS_IB | port);
> +	dst_ib->sib_sid_mask = cpu_to_be64(0xffffffffffffffffULL);
> +	dst_ib->sib_pkey = cpu_to_be16(0xffff);
> +
> +	return 0;
> +}
> +
> +/**
> + * ibtrs_str_to_sockaddr() - Convert ibtrs address string to sockaddr
> + * @addr	String representation of an addr (IPv4, IPv6 or IB GID):
> + *              - "ip:192.168.1.1"
> + *              - "ip:fe80::200:5aee:feaa:20a2"
> + *              - "gid:fe80::200:5aee:feaa:20a2"
> + * @len         String address length
> + * @port	Destination port
> + * @dst		Destination sockaddr structure
> + *
> + * Returns 0 if conversion successful. Non-zero on error.
> + */
> +static int ibtrs_str_to_sockaddr(const char *addr, size_t len,
> +				 short port, struct sockaddr_storage *dst)
> +{
> +	if (strncmp(addr, "gid:", 4) == 0) {
> +		return ibtrs_str_gid_to_sockaddr(addr + 4, len - 4, port, dst);
> +	} else if (strncmp(addr, "ip:", 3) == 0) {
> +		char port_str[8];
> +		char *cpy;
> +		int err;
> +
> +		snprintf(port_str, sizeof(port_str), "%u", port);
> +		cpy = kstrndup(addr + 3, len - 3, GFP_KERNEL);
> +		err = cpy ? inet_pton_with_scope(&init_net, AF_UNSPEC,
> +						 cpy, port_str, dst) : -ENOMEM;
> +		kfree(cpy);
> +
> +		return err;
> +	}
> +	return -EPROTONOSUPPORT;
> +}

A considerable amount of code is required to support the IB/CM. Does 
supporting the IB/CM add any value? If that code would be left out, 
would anything break? Is it really useful to support IB networks where 
no IP address has been assigned to each IB port?

Thanks,

Bart.
