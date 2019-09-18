Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE21B69C0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfIRRlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 13:41:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41868 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfIRRlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 13:41:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so285918plr.8;
        Wed, 18 Sep 2019 10:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+d4tzun7r7q4QhWdwUWUdcRBoPK9Sf22U5/YR584EU=;
        b=gYFPpYQi8dOqZ+GDpRJrKnEFbDTw9q0xZwtqmPSAJCDI3kpaq4/huq2hBvSk4r7omf
         GT4f39UyCmhhd4USEqwuj1OXK/kgTtL2oWxlGgxe+eSBBZx70wpGVjtj9nTS/zm4Gc11
         Wo3bfOuETr5FQ9fscs8EcZvBiibCVACVyF5VyPfc4wJo9AlqKjnSOHODKDrqxijTeQnS
         hQpeaBKEyx+6TygRfmyHHx71CrH1Zxcoc85Ox2ggor9/Tk+pamfD1Ye53dwRvhWFgm64
         rPoC5S82+vKWfBkGZFNRuButBnQzVD2qhco+4CdC2ezuO1w+hr8sCZYjeDk8C/szxVSb
         QqNQ==
X-Gm-Message-State: APjAAAWvoNyjSk10jLvrqr8EjSqGxSSzvdWo5tWCExoRz6mZN3SgGga3
        RTvutRbTUtpaJ4IHB1Eje5o=
X-Google-Smtp-Source: APXvYqxJEvwqB9patrgYFyq1fclwFTnjys/g+6ZYdQlcHJGKP/XFK28FII/ciWC+h2CG3CieX+UGqQ==
X-Received: by 2002:a17:902:7147:: with SMTP id u7mr5444007plm.260.1568828475835;
        Wed, 18 Sep 2019 10:41:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m16sm6842486pgb.84.2019.09.18.10.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:41:14 -0700 (PDT)
Subject: Re: [PATCH v4 20/25] ibnbd: server: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-21-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5ceebb9c-b7ae-8e0c-6f07-d83e878e23d0@acm.org>
Date:   Wed, 18 Sep 2019 10:41:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-21-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt

Same comment here as for a previous patch - please do not include line 
number information in pr_fmt().

> +MODULE_AUTHOR("ibnbd@profitbricks.com");
> +MODULE_VERSION(IBNBD_VER_STRING);
> +MODULE_DESCRIPTION("InfiniBand Network Block Device Server");
> +MODULE_LICENSE("GPL");

Please remove the version number (MODULE_VERSION()).

> +static char dev_search_path[PATH_MAX] = DEFAULT_DEV_SEARCH_PATH;

Please change dev_search_path[] into a dynamically allocated string to 
avoid a hard-coded length limit.

> +	if (dup[strlen(dup) - 1] == '\n')
> +		dup[strlen(dup) - 1] = '\0';

Can this be changed into a call to strim()?

> +static void ibnbd_endio(void *priv, int error)
> +{
> +	struct ibnbd_io_private *ibnbd_priv = priv;
> +	struct ibnbd_srv_sess_dev *sess_dev = ibnbd_priv->sess_dev;
> +
> +	ibnbd_put_sess_dev(sess_dev);
> +
> +	ibtrs_srv_resp_rdma(ibnbd_priv->id, error);
> +
> +	kfree(priv);
> +}

Since ibtrs_srv_resp_rdma() starts an RDMA WRITE without waiting for the 
write completion, shouldn't the session reference be retained until the 
completion for that RDMA WRITE has been received? In other words, is 
there a risk with the current approach that the buffer that is being 
transferred to the client will be freed before the RDMA WRITE has finished?

> +static struct ibnbd_srv_sess_dev *
> +ibnbd_get_sess_dev(int dev_id, struct ibnbd_srv_session *srv_sess)
> +{
> +	struct ibnbd_srv_sess_dev *sess_dev;
> +	int ret = 0;
> +
> +	read_lock(&srv_sess->index_lock);
> +	sess_dev = idr_find(&srv_sess->index_idr, dev_id);
> +	if (likely(sess_dev))
> +		ret = kref_get_unless_zero(&sess_dev->kref);
> +	read_unlock(&srv_sess->index_lock);
> +
> +	if (unlikely(!sess_dev || !ret))
> +		return ERR_PTR(-ENXIO);
> +
> +	return sess_dev;
> +}

Something that is not important: isn't the sess_dev check superfluous in 
the if-statement just above the return statement? If ret == 1, does that 
imply that sess_dev != 0 ?

Has it been considered to return -ENODEV instead of -ENXIO if no device 
is found?

> +static int create_sess(struct ibtrs_srv *ibtrs)
> +{
 > [ ... ]
> +	strlcpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));

Please change the session name into a dynamically allocated string such 
that strdup() can be used instead of strlcpy().

> +static int process_msg_open(struct ibtrs_srv *ibtrs,
> +			    struct ibnbd_srv_session *srv_sess,
> +			    const void *msg, size_t len,
> +			    void *data, size_t datalen);
> +
> +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
> +				 struct ibnbd_srv_session *srv_sess,
> +				 const void *msg, size_t len,
> +				 void *data, size_t datalen);

Can the code be reordered such that these forward declarations can be 
dropped?

> +static struct ibnbd_srv_sess_dev *
> +ibnbd_srv_create_set_sess_dev(struct ibnbd_srv_session *srv_sess,
> +			      const struct ibnbd_msg_open *open_msg,
> +			      struct ibnbd_dev *ibnbd_dev, fmode_t open_flags,
> +			      struct ibnbd_srv_dev *srv_dev)
> +{
> +	struct ibnbd_srv_sess_dev *sdev = ibnbd_sess_dev_alloc(srv_sess);
> +
> +	if (IS_ERR(sdev))
> +		return sdev;
> +
> +	kref_init(&sdev->kref);
> +
> +	strlcpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));

Can the path name be changed into a dynamically allocated string?

> +static char *ibnbd_srv_get_full_path(struct ibnbd_srv_session *srv_sess,
> +				     const char *dev_name)
> +{
> +	char *full_path;
> +	char *a, *b;
> +
> +	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!full_path)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Replace %SESSNAME% with a real session name in order to
> +	 * create device namespace.
> +	 */
> +	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
> +	if (a) {
> +		int len = a - dev_search_path;
> +
> +		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
> +			       dev_search_path, srv_sess->sessname, dev_name);
> +		if (len >= PATH_MAX) {
> +			pr_err("Tooooo looong path: %s, %s, %s\n",
> +			       dev_search_path, srv_sess->sessname, dev_name);
> +			kfree(full_path);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	} else {
> +		snprintf(full_path, PATH_MAX, "%s/%s",
> +			 dev_search_path, dev_name);
> +	}

Has it been considered to use kasprintf() instead of kmalloc() + snprintf()?

> +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
> +				 struct ibnbd_srv_session *srv_sess,
> +				 const void *msg, size_t len,
> +				 void *data, size_t datalen)
> +{
> +	const struct ibnbd_msg_sess_info *sess_info_msg = msg;
> +	struct ibnbd_msg_sess_info_rsp *rsp = data;
> +
> +	srv_sess->ver = min_t(u8, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
> +	pr_debug("Session %s using protocol version %d (client version: %d,"
> +		 " server version: %d)\n", srv_sess->sessname,
> +		 srv_sess->ver, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);

Has this patch been verified with checkpatch? I think checkpatch 
recommends not to split literal strings.

> +/**
> + * find_srv_sess_dev() - a dev is already opened by this name
> + *
> + * Return struct ibnbd_srv_sess_dev if srv_sess already opened the dev_name
> + * NULL if the session didn't open the device yet.
> + */
> +static struct ibnbd_srv_sess_dev *
> +find_srv_sess_dev(struct ibnbd_srv_session *srv_sess, const char *dev_name)
> +{
> +	struct ibnbd_srv_sess_dev *sess_dev;
> +
> +	if (list_empty(&srv_sess->sess_dev_list))
> +		return NULL;
> +
> +	list_for_each_entry(sess_dev, &srv_sess->sess_dev_list, sess_list)
> +		if (!strcmp(sess_dev->pathname, dev_name))
> +			return sess_dev;
> +
> +	return NULL;
> +}

Is explicit the list_empty() check really necessary? Would the behavior 
of this function change if that check is left out?

Has the posted code been compiled with W=1? I'm asking this because the 
documentation of the function arguments is missing from the kernel-doc 
header. I expect that a warning will be reported if this code is 
compiled with W=1.

Thanks,

Bart.
