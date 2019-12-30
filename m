Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CD12D4D2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfL3WZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 17:25:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43037 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3WZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 17:25:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so17800538pfo.10;
        Mon, 30 Dec 2019 14:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K2BO2LUROHaNIho7rOp6VAnB+9aiSzF+xQJYuD//s44=;
        b=AfYd5X/DVwNeR5Pm4l/lJifCYeE8+BJWzt3OmGzQnVYoyQ+LPvMUctT4l7pYSAV9o8
         xBxT/4kKTMiEM4t66Ch3KARCAme16iHF16eWd4MFWypfdWqfRSqWigzPsh8ceiGOzUif
         Jmce1WDcb5KTHwYX5Othh8va2CvXiAA1dQTmsHfSH/Jj8g9Spygd/58ypW+rgZKL5Lv/
         8Zds7bYlmy8OqPp8s6lWFCpDbkl2IWp9/CapIu65b0f/ecsELJqv08fPT00s+dVWgS4r
         /Dr2F3T7gguXzja9+9lWOWZ2SW+1KAMz95KREhBO1kODm5PSacLIKIr9XbUL9sY1j+51
         Db0A==
X-Gm-Message-State: APjAAAUV+0774nxcvDSireCSvnQYj+Kh4RkO1Zparhmlk7Llwh//1LA0
        ox2ak0xhs6kT8/Q+YRvysSE=
X-Google-Smtp-Source: APXvYqxW/MrvAaVEwPmYFNG7SyueGAkqCXfQtH4JRzpP1v0TceqOgInWaI99wchIdomtCAITrYrX6Q==
X-Received: by 2002:a63:150d:: with SMTP id v13mr73138152pgl.342.1577744720207;
        Mon, 30 Dec 2019 14:25:20 -0800 (PST)
Received: from ?IPv6:2601:647:4000:10b0:5d64:b7bb:4214:150f? ([2601:647:4000:10b0:5d64:b7bb:4214:150f])
        by smtp.gmail.com with ESMTPSA id y4sm566027pjw.9.2019.12.30.14.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 14:25:19 -0800 (PST)
Subject: Re: [PATCH v6 04/25] rtrs: core: lib functions shared between client
 and server modules
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-5-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <d4288d41-b000-9a98-d12a-0738a0f647e8@acm.org>
Date:   Mon, 30 Dec 2019 14:25:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-5-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019-12-30 02:29, Jack Wang wrote:
> + * InfiniBand Transport Layer

Is RTRS an InfiniBand or an RDMA transport layer?

> +MODULE_DESCRIPTION("RTRS Core");

Please write out RTRS in full and consider changing the word "Core" into
"client and server".

> +	WARN_ON(!queue_size);
> +	ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> +
> +	if (unlikely(!ius))
> +		return NULL;

No blank line between the 'ius' assignment and the 'ius' check please.

> +int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
> +{
> +	struct rtrs_sess *sess = con->sess;
> +	struct ib_recv_wr wr;
> +	const struct ib_recv_wr *bad_wr;
> +	struct ib_sge list;
> +
> +	list.addr   = iu->dma_addr;
> +	list.length = iu->size;
> +	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> +
> +	if (WARN_ON(list.length == 0)) {
> +		rtrs_wrn(con->sess,
> +			  "Posting receive work request failed, sg list is empty\n");
> +		return -EINVAL;
> +	}
> +
> +	wr.next    = NULL;
> +	wr.wr_cqe  = &iu->cqe;
> +	wr.sg_list = &list;
> +	wr.num_sge = 1;
> +
> +	return ib_post_recv(con->qp, &wr, &bad_wr);
> +}
> +EXPORT_SYMBOL_GPL(rtrs_iu_post_recv);

The above code is fragile: although this is unlikely, if a member would
be added in struct ib_sge or in struct ib_recv_wr then the above code
will leave some member variables uninitialized. Has it been considered
to initialize these structures using a single assignment statement, e.g.
as follows:

	wr = (struct ib_recv_wr) {
		.wr_cqe = ...,
		.sg_list = ...,
		.num_sge = 1,
	};

> +int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe)
> +{
> +	struct ib_recv_wr wr;
> +	const struct ib_recv_wr *bad_wr;
> +
> +	wr.next    = NULL;
> +	wr.wr_cqe  = cqe;
> +	wr.sg_list = NULL;
> +	wr.num_sge = 0;
> +
> +	return ib_post_recv(con->qp, &wr, &bad_wr);
> +}
> +EXPORT_SYMBOL_GPL(rtrs_post_recv_empty);

Same comment for this function.

> +int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
> +{
> +	struct ib_recv_wr wr_arr[2], *wr;
> +	const struct ib_recv_wr *bad_wr;
> +	int i;
> +
> +	memset(wr_arr, 0, sizeof(wr_arr));
> +	for (i = 0; i < ARRAY_SIZE(wr_arr); i++) {
> +		wr = &wr_arr[i];
> +		wr->wr_cqe  = cqe;
> +		if (i)
> +			/* Chain backwards */
> +			wr->next = &wr_arr[i - 1];
> +	}
> +
> +	return ib_post_recv(con->qp, wr, &bad_wr);
> +}
> +EXPORT_SYMBOL_GPL(rtrs_post_recv_empty_x2);

I have not yet seen any other RDMA code that is similar to the above
function. A comment above this function that explains its purpose would
be more than welcome.

> +int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
> +		       struct ib_send_wr *head)
> +{
> +	struct rtrs_sess *sess = con->sess;
> +	struct ib_send_wr wr;
> +	const struct ib_send_wr *bad_wr;
> +	struct ib_sge list;
> +
> +	if ((WARN_ON(size == 0)))
> +		return -EINVAL;

No superfluous parentheses please.

> +	list.addr   = iu->dma_addr;
> +	list.length = size;
> +	list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> +
> +	memset(&wr, 0, sizeof(wr));
> +	wr.next       = NULL;
> +	wr.wr_cqe     = &iu->cqe;
> +	wr.sg_list    = &list;
> +	wr.num_sge    = 1;
> +	wr.opcode     = IB_WR_SEND;
> +	wr.send_flags = IB_SEND_SIGNALED;

Has it been considered to use designated initializers instead of a
memset() followed by multiple assignments? Same question for
rtrs_iu_post_rdma_write_imm() and rtrs_post_rdma_write_imm_empty().

> +static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
> +		     u16 wr_queue_size, u32 max_sge)
> +{
> +	struct ib_qp_init_attr init_attr = {NULL};
> +	struct rdma_cm_id *cm_id = con->cm_id;
> +	int ret;
> +
> +	init_attr.cap.max_send_wr = wr_queue_size;
> +	init_attr.cap.max_recv_wr = wr_queue_size;

What code is responsible for ensuring that neither max_send_wr nor
max_recv_wr exceeds the device limits? Please document this in a comment
above this function.

> +	init_attr.cap.max_recv_sge = 1;
> +	init_attr.event_handler = qp_event_handler;
> +	init_attr.qp_context = con;
> +#undef max_send_sge
> +	init_attr.cap.max_send_sge = max_sge;

Is the "undef max_send_sge" really necessary? If so, please add a
comment that explains why it is necessary.

> +static int rtrs_str_gid_to_sockaddr(const char *addr, size_t len,
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

What is "I6"?

Is the fourth argument to this function correct? From the comment above
in6_pton(): "@delim: the delimiter of the IPv6 address in @src, -1 means
no delimiter".

> +int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
> +{
> +	int cnt;
> +
> +	switch (addr->sa_family) {
> +	case AF_IB:
> +		cnt = scnprintf(buf, len, "gid:%pI6",
> +			&((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
> +		return cnt;
> +	case AF_INET:
> +		cnt = scnprintf(buf, len, "ip:%pI4",
> +			&((struct sockaddr_in *)addr)->sin_addr);
> +		return cnt;
> +	case AF_INET6:
> +		cnt = scnprintf(buf, len, "ip:%pI6c",
> +			  &((struct sockaddr_in6 *)addr)->sin6_addr);
> +		return cnt;
> +	}
> +	cnt = scnprintf(buf, len, "<invalid address family>");
> +	pr_err("Invalid address family\n");
> +	return cnt;
> +}
> +EXPORT_SYMBOL(sockaddr_to_str);

Is the pr_err() statement in the above function useful? Will anyone be
able to figure out what is going on if the "Invalid address family"
string appears in the system log? Please consider changing that pr_err()
statement into a WARN_ON_ONCE() statement.

> +	ret = rtrs_str_to_sockaddr(str, len, port, addr->dst);
> +
> +	return ret;

Please change this into a single return statement.

> +EXPORT_SYMBOL(rtrs_addr_to_sockaddr);
> +
> +void rtrs_ib_dev_pool_init(enum ib_pd_flags pd_flags,
> +			    struct rtrs_ib_dev_pool *pool)
> +{
> +	WARN_ON(pool->ops && (!pool->ops->alloc ^ !pool->ops->free));
> +	INIT_LIST_HEAD(&pool->list);
> +	mutex_init(&pool->mutex);
> +	pool->pd_flags = pd_flags;
> +}
> +EXPORT_SYMBOL(rtrs_ib_dev_pool_init);
> +
> +void rtrs_ib_dev_pool_deinit(struct rtrs_ib_dev_pool *pool)
> +{
> +	WARN_ON(!list_empty(&pool->list));
> +}
> +EXPORT_SYMBOL(rtrs_ib_dev_pool_deinit);

Since rtrs_ib_dev_pool_init() calls mutex_init(), should
rtrs_ib_dev_pool_deinit() call mutex_destroy()?

Thanks,

Bart.

