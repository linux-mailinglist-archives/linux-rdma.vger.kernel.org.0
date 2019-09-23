Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82EBBEA2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392821AbfIWWui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 18:50:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42515 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392820AbfIWWui (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 18:50:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so7181984pls.9;
        Mon, 23 Sep 2019 15:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W6HuVnC9hGr4EvSC1RPOCpcPXaGFtqvq3vf8mCR2Yqk=;
        b=IfGo3xez6tZ4UKXMTI1tBri0PWzpMXlDLPEE1JraQsg+n/tHR35qGUuQHiysKxXfQd
         XOV8I71sUls2RhMj7LAkSdfQVkug9EcJj7Kk2sxq2HGIc++bPcXDeikPTXYfJsiu0inm
         VU0FVG9RyBEQYYwSK4ziDXldpp2DgQPAfAmzADwwNQbTXgX9UFbMk7jaDIOIKJoPI3Pl
         JfxRZkxxmotgf7N08sfAwJDM4HPt2MpcUznQjpdLDjDfODTcFYEHhsC2n9sTtoc7TOfO
         Nb7JRZc34+d+OSqR/bL/XVWiSb3Llb/tsIpE0OpxHEv5Ej/NaJW7yV5uNviIVS+oPnws
         sO8A==
X-Gm-Message-State: APjAAAXi/y3ZN8xW30Erzy+HynS7dIPd7mEMt0Qv9IMSUJfNFvWO0MXs
        hEHyYM388SxF+gRETc3YcRc=
X-Google-Smtp-Source: APXvYqz6G8OOlwcSwQLM4MDDNl0Yj6YeshqYAYUd487r4nq1wlBDF/MPz/0CM1yCEnFHpwjmpG+0Qg==
X-Received: by 2002:a17:902:8304:: with SMTP id bd4mr2251119plb.213.1569279037226;
        Mon, 23 Sep 2019 15:50:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b24sm8633857pgs.15.2019.09.23.15.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:50:36 -0700 (PDT)
Subject: Re: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol
 structs and helpers
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-4-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
Date:   Mon, 23 Sep 2019 15:50:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-4-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +#define P1 )
> +#define P2 ))
> +#define P3 )))
> +#define P4 ))))
> +#define P(N) P ## N
> +
> +#define CAT(a, ...) PRIMITIVE_CAT(a, __VA_ARGS__)
> +#define PRIMITIVE_CAT(a, ...) a ## __VA_ARGS__
> +
> +#define LIST(...)						\
> +	__VA_ARGS__,						\
> +	({ unknown_type(); NULL; })				\
> +	CAT(P, COUNT_ARGS(__VA_ARGS__))				\
> +
> +#define EMPTY()
> +#define DEFER(id) id EMPTY()
> +
> +#define _CASE(obj, type, member)				\
> +	__builtin_choose_expr(					\
> +	__builtin_types_compatible_p(				\
> +		typeof(obj), type),				\
> +		((type)obj)->member
> +#define CASE(o, t, m) DEFER(_CASE)(o, t, m)
> +
> +/*
> + * Below we define retrieving of sessname from common IBTRS types.
> + * Client or server related types have to be defined by special
> + * TYPES_TO_SESSNAME macro.
> + */
> +
> +void unknown_type(void);
> +
> +#ifndef TYPES_TO_SESSNAME
> +#define TYPES_TO_SESSNAME(...) ({ unknown_type(); NULL; })
> +#endif
> +
> +#define ibtrs_prefix(obj)					\
> +	_CASE(obj, struct ibtrs_con *,  sess->sessname),	\
> +	_CASE(obj, struct ibtrs_sess *, sessname),		\
> +	TYPES_TO_SESSNAME(obj)					\
> +	))

No preprocessor voodoo please. Please remove all of the above and modify 
the logging statements such that these pass the proper name string as 
first argument to logging macros.

> +struct ibtrs_msg_conn_req {
> +	u8		__cma_version; /* Is set to 0 by cma.c in case of
> +					* AF_IB, do not touch that. */
> +	u8		__ip_version;  /* On sender side that should be
> +					* set to 0, or cma_save_ip_info()
> +					* extract garbage and will fail. */
> +	__le16		magic;
> +	__le16		version;
> +	__le16		cid;
> +	__le16		cid_num;
> +	__le16		recon_cnt;
> +	uuid_t		sess_uuid;
> +	uuid_t		paths_uuid;
> +	u8		reserved[12];
> +};

Please remove the reserved[] array and check private_data_len in the 
code that receives the login request.

> +/**
> + * struct ibtrs_msg_conn_rsp - Server connection response to the client
> + * @magic:	   IBTRS magic
> + * @version:	   IBTRS protocol version
> + * @errno:	   If rdma_accept() then 0, if rdma_reject() indicates error
> + * @queue_depth:   max inflight messages (queue-depth) in this session
> + * @max_io_size:   max io size server supports
> + * @max_hdr_size:  max msg header size server supports
> + *
> + * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
> + */
> +struct ibtrs_msg_conn_rsp {
> +	__le16		magic;
> +	__le16		version;
> +	__le16		errno;
> +	__le16		queue_depth;
> +	__le32		max_io_size;
> +	__le32		max_hdr_size;
> +	u8		reserved[40];
> +};

Same comment here: please remove the reserved[] array and check 
private_data_len in the code that processes this data structure.

> +static inline int sockaddr_cmp(const struct sockaddr *a,
> +			       const struct sockaddr *b)
> +{
> +	switch (a->sa_family) {
> +	case AF_IB:
> +		return memcmp(&((struct sockaddr_ib *)a)->sib_addr,
> +			      &((struct sockaddr_ib *)b)->sib_addr,
> +			      sizeof(struct ib_addr));
> +	case AF_INET:
> +		return memcmp(&((struct sockaddr_in *)a)->sin_addr,
> +			      &((struct sockaddr_in *)b)->sin_addr,
> +			      sizeof(struct in_addr));
> +	case AF_INET6:
> +		return memcmp(&((struct sockaddr_in6 *)a)->sin6_addr,
> +			      &((struct sockaddr_in6 *)b)->sin6_addr,
> +			      sizeof(struct in6_addr));
> +	default:
> +		return -ENOENT;
> +	}
> +}
> +
> +static inline int sockaddr_to_str(const struct sockaddr *addr,
> +				   char *buf, size_t len)
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

Since these functions are not in the hot path, please move these into a 
.c file.

> +/**
> + * ibtrs_invalidate_flag() - returns proper flags for invalidation
> + *
> + * NOTE: This function is needed for compat layer, so think twice before
> + *       rename or remove.
> + */
> +static inline u32 ibtrs_invalidate_flag(void)
> +{
> +	return IBTRS_MSG_NEED_INVAL_F;
> +}

An inline function that does nothing else than returning a compile-time 
constant? That does not look useful to me. How about inlining this function?

> +#define STAT_STORE_FUNC(type, store, reset)				\
> +static ssize_t store##_store(struct kobject *kobj,			\
> +			     struct kobj_attribute *attr,		\
> +			     const char *buf, size_t count)		\
> +{									\
> +	int ret = -EINVAL;						\
> +	type *sess = container_of(kobj, type, kobj_stats);		\
> +									\
> +	if (sysfs_streq(buf, "1"))					\
> +		ret = reset(&sess->stats, true);			\
> +	else if (sysfs_streq(buf, "0"))					\
> +		ret = reset(&sess->stats, false);			\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	return count;							\
> +}

The above macro concatenates the suffix "_store" to a macro argument 
with the name 'store'. Please chose a less confusing name for the macro 
argument. Additionally, using 'reset' for the name of an macro argument 
that is a function that stores a value seems confusing to me. How about 
renaming that macro argument into 'set' or 'store_value'?

> +#define STAT_SHOW_FUNC(type, show, print)				\
> +static ssize_t show##_show(struct kobject *kobj,			\
> +			   struct kobj_attribute *attr,			\
> +			   char *page)					\
> +{									\
> +	type *sess = container_of(kobj, type, kobj_stats);		\
> +									\
> +	return print(&sess->stats, page, PAGE_SIZE);			\
> +}

Same comment for the macro argument 'show' in the above function.

Thanks,

Bart.
