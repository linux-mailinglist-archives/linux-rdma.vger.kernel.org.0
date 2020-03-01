Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28573174AAE
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 02:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCABmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Feb 2020 20:42:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40636 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCABmJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Feb 2020 20:42:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so2886854pjb.5;
        Sat, 29 Feb 2020 17:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WJQDzoXOIwDfvmohMLGreLwbnwL8PrD8T0+HbersxSo=;
        b=BZcBeB9y66waq1s0U6fGJfAgTJwVvLP7JZkWDsggNJNeeySeL2gOqVqR/ayl8qXLqz
         CNH+24fj+rJsJ9I2GBJ7esvCbnXGA3w3MaZ2JPqoZZHCimkcUtM3rtvOySq1KjvsdLub
         hTOomJdch2bIoqcKdsqYdkyFMmbvIH5yW0hQGMDWRm1RgYfJ9IVIW2msgWSCM9FKtrO0
         6ifCiw/xBoao2dQR61BgFwwxzgMEG6AvhithznuftWCp+5S6gD3gai6d0m6vfUZXXu0k
         JbpBznE6oqvSEa+mfHL4Y5cQOV8+tAbbaPyYNsNj3btRvHfcd78+II/0UyHe5HizA0dI
         MjVQ==
X-Gm-Message-State: APjAAAW1VhvkAvHWKcAAMIaAORY7f4kr6kFd+gH5D+EBhW4Cas/ILg0D
        R9NoehIXEYI2dZH9YiyHpUQ=
X-Google-Smtp-Source: APXvYqxmwyQOlWeKvzxjDjnP66hQegG75pH4SyFEgjM7yWBnMIwxawOVghIzd3b7WkrAckgTBhtelQ==
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr12659998pjt.105.1583026928098;
        Sat, 29 Feb 2020 17:42:08 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:bd83:6f94:8c5:942d? ([2601:647:4000:d7:bd83:6f94:8c5:942d])
        by smtp.gmail.com with ESMTPSA id i68sm16010596pfe.173.2020.02.29.17.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 17:42:07 -0800 (PST)
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-11-jinpuwang@gmail.com>
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
Message-ID: <c97843fa-84c4-ff7e-3b72-af3b916c059a@acm.org>
Date:   Sat, 29 Feb 2020 17:42:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221104721.350-11-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-02-21 02:47, Jack Wang wrote:
> +int rtrs_srv_get_sess_name(struct rtrs_srv *srv, char *sessname, size_t len)
> +{
> +	struct rtrs_srv_sess *sess;
> +	int err = -ENOTCONN;
> +
> +	mutex_lock(&srv->paths_mutex);
> +	list_for_each_entry(sess, &srv->paths_list, s.entry) {
> +		if (sess->state != RTRS_SRV_CONNECTED)
> +			continue;
> +		memcpy(sessname, sess->s.sessname,
> +		       min_t(size_t, sizeof(sess->s.sessname), len));
> +		err = 0;
> +		break;
> +	}
> +	mutex_unlock(&srv->paths_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(rtrs_srv_get_sess_name);

Please make sure that the returned string is '\0'-terminated, e.g. by
using strlcpy().

> +static int rtrs_rdma_do_accept(struct rtrs_srv_sess *sess,
> +			       struct rdma_cm_id *cm_id)
> +{
> +	struct rtrs_srv *srv = sess->srv;
> +	struct rtrs_msg_conn_rsp msg;
> +	struct rdma_conn_param param;
> +	int err;
> +
> +	param = (struct rdma_conn_param) {
> +	.rnr_retry_count = 7,
> +	.private_data = &msg,
> +	.private_data_len = sizeof(msg),
> +	};
> +
> +	msg = (struct rtrs_msg_conn_rsp) {
> +	.magic = cpu_to_le16(RTRS_MAGIC),
> +	.version = cpu_to_le16(RTRS_PROTO_VER),
> +	.queue_depth = cpu_to_le16(srv->queue_depth),
> +	.max_io_size = cpu_to_le32(max_chunk_size - MAX_HDR_SIZE),
> +	.max_hdr_size = cpu_to_le32(MAX_HDR_SIZE),
> +	};
> +
> +	if (always_invalidate)
> +		msg.flags = cpu_to_le32(RTRS_MSG_NEW_RKEY_F);
> +
> +	err = rdma_accept(cm_id, &param);
> +	if (err)
> +		pr_err("rdma_accept(), err: %d\n", err);
> +
> +	return err;
> +}

Please indent the members in the structure assignments.

> +static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
> +{
> +	struct rtrs_msg_conn_rsp msg;
> +	int err;
> +
> +	msg = (struct rtrs_msg_conn_rsp) {
> +	.magic = cpu_to_le16(RTRS_MAGIC),
> +	.version = cpu_to_le16(RTRS_PROTO_VER),
> +	.errno = cpu_to_le16(errno),
> +	};
> +
> +	err = rdma_reject(cm_id, &msg, sizeof(msg));
> +	if (err)
> +		pr_err("rdma_reject(), err: %d\n", err);
> +
> +	/* Bounce errno back */
> +	return errno;
> +}

Same comment for this function.

Thanks,

Bart.
