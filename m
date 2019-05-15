Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B61F67C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfEOOY4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 May 2019 10:24:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39929 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfEOOY4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 10:24:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so86622edq.6
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 07:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4KkXzMGMdsXHUxREK7EgxFfhaFvOJAo05HeWUfBBrA=;
        b=pgQ3YyKC6gTOviJyNuVazSgBJLBXbuVKBJhDdTZ/saiYEYLmd/MzzrjhnzFnxFiWlo
         lir1PHCgvG5U6LtFenv8ABKyO8CtAoG3GkP97pv6Ou019K0mSAwnBuBRpXVrQ3mpJZ9e
         W22h5CVnR47bNmP/CT4zaRXRGa6gbA5vn8ke2gJO5wyy/jDBP361ci00cSCrAN39G4EX
         OGI4EqaQiDT2+WKuHaiQZIquNM/Ru96lArM86vTmXjcUteFFrQLWy8KFnnnxhtJcJxGx
         SpElQ/fUrQYk3lPjS+eeDpU2dAAuXeZg8EnBV0Y8YToJZ59lARmT1R4RyQr0bDsdk35n
         Mnvw==
X-Gm-Message-State: APjAAAW7Gqym2GUnbGvuO5LIEYskZPYW2TilhVMPVbzbdhBdyKQiwoiQ
        eh7qJXoo8U738jGrxxrj98u0/xuz
X-Google-Smtp-Source: APXvYqzM7iKRRsJ6UU6oSv1UDJ8YcDo3CaMKG4mOevGq5Ah5Eqt71h0lcuX+gWVEm2r4s5zE93yMdA==
X-Received: by 2002:a17:906:27c5:: with SMTP id k5mr33876499ejc.141.1557930293940;
        Wed, 15 May 2019 07:24:53 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id c8sm493622ejs.87.2019.05.15.07.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 07:24:52 -0700 (PDT)
Subject: Re: [RFC PATCH rdma-next v1] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190515132026.18768-1-leon@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <446a5af5-953a-0892-0456-d5ac74225086@acm.org>
Date:   Wed, 15 May 2019 16:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515132026.18768-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/19 3:20 PM, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index a67aaf0e1f76..64f777e757f6 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -410,6 +410,9 @@ static int rename_compat_devs(struct ib_device *device)
> 
>  int ib_device_rename(struct ib_device *ibdev, const char *name)
>  {
> +	struct ib_client *client;
> +	unsigned long index;
> +	void *client_data;
>  	int ret;
> 
>  	down_write(&devices_rwsem);
> @@ -428,6 +431,19 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
>  		goto out;
>  	strlcpy(ibdev->name, name, IB_DEVICE_NAME_MAX);
>  	ret = rename_compat_devs(ibdev);
> +
> +	downgrade_write(&devices_rwsem);
> +	down_read(&clients_rwsem);
> +	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> +		if (client->rename) {
> +			client_data =
> +				xa_load(&ibdev->client_data, client->client_id);
> +			client->rename(ibdev, client_data);
> +		}
> +	}
> +	up_read(&clients_rwsem);
> +	up_read(&devices_rwsem);
> +	return 0;
>  out:
>  	up_write(&devices_rwsem);
>  	return ret;
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index be9ddcad8f28..2edd014e62db 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(ch_count,
> 
>  static void srp_add_one(struct ib_device *device);
>  static void srp_remove_one(struct ib_device *device, void *client_data);
> +static void srp_rename_dev(struct ib_device *device, void *client_data);
>  static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc);
>  static void srp_handle_qp_err(struct ib_cq *cq, struct ib_wc *wc,
>  		const char *opname);
> @@ -162,7 +163,8 @@ static struct workqueue_struct *srp_remove_wq;
>  static struct ib_client srp_client = {
>  	.name   = "srp",
>  	.add    = srp_add_one,
> -	.remove = srp_remove_one
> +	.remove = srp_remove_one,
> +	.rename = srp_rename_dev
>  };
> 
>  static struct ib_sa_client srp_sa_client;
> @@ -4112,6 +4114,20 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
>  	return NULL;
>  }
> 
> +static void srp_rename_dev(struct ib_device *device, void *client_data)
> +{
> +	struct srp_device *srp_dev = client_data;
> +	struct srp_host *host, *tmp_host;
> +
> +	list_for_each_entry_safe (host, tmp_host, &srp_dev->dev_list, list) {
> +		char name[IB_DEVICE_NAME_MAX * 2] = {};
> +
> +		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
> +			 dev_name(&device->dev), host->port);
> +		device_rename(&host->dev, name);
> +	}
> +}
> +
>  static void srp_add_one(struct ib_device *device)
>  {
>  	struct srp_device *srp_dev;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e9fffa55426b..59d0fffbf192 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2727,6 +2727,7 @@ struct ib_client {
>  	const char *name;
>  	void (*add)   (struct ib_device *);
>  	void (*remove)(struct ib_device *, void *client_data);
> +	void (*rename)(struct ib_device *, void *client_data);
> 
>  	/* Returns the net_dev belonging to this ib_client and matching the
>  	 * given parameters.

Hi Leon,

Thanks for having shared this patch early. The approach of this patch
looks good to me but please fix the checkpatch warnings triggered by
this patch:

WARNING: space prohibited between function name and open parenthesis '('
#203: FILE: drivers/infiniband/core/device.c:437:
+       xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {

WARNING: space prohibited between function name and open parenthesis '('
#247: FILE: drivers/infiniband/ulp/srp/ib_srp.c:4122:
+       list_for_each_entry_safe (host, tmp_host, &srp_dev->dev_list,
list) {

WARNING: function definition argument 'struct ib_device *' should also
have an identifier name
#267: FILE: include/rdma/ib_verbs.h:2730:
+       void (*rename)(struct ib_device *, void *client_data);

Thanks,

Bart.

