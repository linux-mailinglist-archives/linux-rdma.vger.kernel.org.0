Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2012EB15
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgABVOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 16:14:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40519 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgABVOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 16:14:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so22604859pfh.7;
        Thu, 02 Jan 2020 13:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttP0dw/FS32mBHO8MLcF0+pOzuH4RhM52aiO6D1ElDI=;
        b=fgWEPBA2Vx6gJ6zFLACD6AkYKV19PqQwGlDtgFH9V9Q4BluRP83Q9u/Wg4X7dw2cgZ
         zJklux8JyhasVQJa2OOn/vO9rsjRbWRVG+jbVROjdjaU4ALt1yA6CXK0zYtXK8aXTUQw
         B5Mx9kYtEGqkn4x30IvdhoHEF88ox2n1oPpj1H5YOuxf1/sKd6Iny49Plf8V9D5lzw37
         f7SdOIlkF+FuISyAmwIlMswgzM4F6NtuiVXnurCmojfrmdzm1ozsW6wImetQJmOwsPRy
         YQMSPxDkPjeL9Q7+Tm04Qgb/I5w6UUtyNv1ynt3fzPhTMeZW2AMTcPugSJ0KiW+iw9tj
         DxRg==
X-Gm-Message-State: APjAAAVmBdLi49qeIogQJF1JpK9wYQsjncUSZTdTe1Xqf8rYXuk3zwFX
        cqZdia/wW6bl59EQkWUbo6c=
X-Google-Smtp-Source: APXvYqwbpfelIqXEe2JfFmVeDRr4HSR+kukQqaPcspRmBQjdVg7cDIAtLnw19XpwL2TSHisTBVlWDQ==
X-Received: by 2002:a63:9d07:: with SMTP id i7mr96083958pgd.344.1577999663684;
        Thu, 02 Jan 2020 13:14:23 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u3sm61916285pga.72.2020.01.02.13.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 13:14:22 -0800 (PST)
Subject: Re: [PATCH v6 08/25] rtrs: client: sysfs interface functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-9-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8be61a28-baf7-99dd-c94d-53244565906f@acm.org>
Date:   Thu, 2 Jan 2020 13:14:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-9-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +static struct kobj_type ktype = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};

Can this data structure be declared 'const'?

> +static ssize_t max_reconnect_attempts_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *page)
> +{
> +	struct rtrs_clt *clt;
> +
> +	clt = container_of(dev, struct rtrs_clt, dev);

If the above two statements would be combined into a single statement, 
does the result still fit in 80 columns? If so, please combine these two 
statements into a single statement.

> +static ssize_t max_reconnect_attempts_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t count)
> +{
> +	struct rtrs_clt *clt;
> +	int value;
> +	int ret;
> +
> +	clt = container_of(dev, struct rtrs_clt, dev);

Same comment here and also for other uses of 'clt': how about combining 
the declaration and initialization of 'clt' into a single line of code?

> +static ssize_t mpath_policy_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *page)
> +{
> +	struct rtrs_clt *clt;
> +
> +	clt = container_of(dev, struct rtrs_clt, dev);
> +
> +	switch (clt->mp_policy) {
> +	case MP_POLICY_RR:
> +		return sprintf(page, "round-robin (RR: %d)\n", clt->mp_policy);
> +	case MP_POLICY_MIN_INFLIGHT:
> +		return sprintf(page, "min-inflight (MI: %d)\n", clt->mp_policy);
> +	default:
> +		return sprintf(page, "Unknown (%d)\n", clt->mp_policy);
> +	}
> +}

Is the above show function compatible with the sysfs one-value-per-file 
rule?

> +static struct kobj_attribute rtrs_clt_remove_path_attr =
> +	__ATTR(remove_path, 0644, rtrs_clt_remove_path_show,
> +	       rtrs_clt_remove_path_store);

Could __ATTR_RW() have been used here?

> +static struct kobj_attribute rtrs_clt_src_addr_attr =
> +	__ATTR(src_addr, 0444, rtrs_clt_src_addr_show, NULL);

Could __ATTR_RO() have been used here?

> +static struct attribute_group rtrs_clt_sess_attr_group = {
> +	.attrs = rtrs_clt_sess_attrs,
> +};

Can this data structure be declared 'const'?

Thanks,

Bart.
