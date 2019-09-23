Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC3BBAAA
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbfIWRol (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 13:44:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41690 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfIWRol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 13:44:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so9546497pfh.8;
        Mon, 23 Sep 2019 10:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCyFJnwaPK6qM/V+l3WbBpnXJnUTZEa6VNWv+6InCmE=;
        b=ay8EYFyOlq+SNPm+ELbkYcMuBS4G9iSnBaL1Mh62cgbNRIZKSlmM+EkGc3U4DOSTwl
         z7LZBxRKBpWFx6aRCuUBuxLS9khYyE9QMddm8W4riROnV57epi2CiAqxv/w8vWbtxxej
         5eB6+AlPHd1mL8pCyWaIHd7U9FFIE0cQvP4HxcMNG86ZUKfjIxqcEwXF3vAIu0cFI4fs
         Sq4eSFkzX8LdNn8F2dDrrtFuhT4W35/FpVDuwez2AAdLBOWux5Yw3WaIsBm4JQCcWO2z
         QayOdF7ADv85A4TpGmXN/1TWaYtiCX0q03H1NFmdOsptXstbKahXsOeOQrBJ4cX2UDIm
         vPEQ==
X-Gm-Message-State: APjAAAXmf0yRvRiGN7+P6qRvp0fSblzwQoJtiWWexL1+Kva5aBElpdfW
        1OZcPJ9/52N1JqcVnYR3Q68=
X-Google-Smtp-Source: APXvYqxH11vRLoj01Bj1USCJlOxVD32/gEivU6HGztrjQ25nqTfl+umTsp5FRZuJGTdAjgXg63eGoA==
X-Received: by 2002:a62:115:: with SMTP id 21mr875783pfb.110.1569260679392;
        Mon, 23 Sep 2019 10:44:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g4sm14060628pfo.33.2019.09.23.10.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:44:38 -0700 (PDT)
Subject: Re: [PATCH v4 02/25] ibtrs: public interface header to establish RDMA
 connections
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-3-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0607ca2d-6509-69da-4afc-0be6526b11c4@acm.org>
Date:   Mon, 23 Sep 2019 10:44:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-3-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> From: Roman Pen <roman.penyaev@profitbricks.com>
> 
> Introduce public header which provides set of API functions to
> establish RDMA connections from client to server machine using
> IBTRS protocol, which manages RDMA connections for each session,
> does multipathing and load balancing.
> 
> Main functions for client (active) side:
> 
>   ibtrs_clt_open() - Creates set of RDMA connections incapsulated
                              ^^^                       ^^^^^^^^^^^^
                                a?                      encapsulated?

>                      in IBTRS session and returns pointer on IBTRS
                         ^^^                       ^^^       ^^
                          a?                        a?       to an?
> 		    session object.
[ ... ]
> +/**
> + * enum ibtrs_clt_link_ev - Events about connectivity state of a client
> + * @IBTRS_CLT_LINK_EV_RECONNECTED	Client was reconnected.
> + * @IBTRS_CLT_LINK_EV_DISCONNECTED	Client was disconnected.
> + */
> +enum ibtrs_clt_link_ev {
> +	IBTRS_CLT_LINK_EV_RECONNECTED,
> +	IBTRS_CLT_LINK_EV_DISCONNECTED,
> +};
> +
> +/**
> + * Source and destination address of a path to be established
> + */
> +struct ibtrs_addr {
> +	struct sockaddr_storage *src;
> +	struct sockaddr_storage *dst;
> +};

Is it really useful to define a structure to hold two pointers or can 
these two pointers also be passed as separate arguments?

> +/**
> + * ibtrs_clt_open() - Open a session to a IBTRS client
> + * @priv:		User supplied private data.
> + * @link_ev:		Event notification for connection state changes
> + *	@priv:			user supplied data that was passed to
> + *				ibtrs_clt_open()
> + *	@ev:			Occurred event
> + * @sessname: name of the session
> + * @paths: Paths to be established defined by their src and dst addresses
> + * @path_cnt: Number of elemnts in the @paths array
> + * @port: port to be used by the IBTRS session
> + * @pdu_sz: Size of extra payload which can be accessed after tag allocation.
> + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> + * @max_segments: Max. number of segments per IO request
> + * @reconnect_delay_sec: time between reconnect tries
> + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> + *			    up, 0 for * disabled, -1 for forever
> + *
> + * Starts session establishment with the ibtrs_server. The function can block
> + * up to ~2000ms until it returns.
> + *
> + * Return a valid pointer on success otherwise PTR_ERR.
> + */
> +struct ibtrs_clt *ibtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
> +				 const char *sessname,
> +				 const struct ibtrs_addr *paths,
> +				 size_t path_cnt, short port,
> +				 size_t pdu_sz, u8 reconnect_delay_sec,
> +				 u16 max_segments,
> +				 s16 max_reconnect_attempts);

Having detailed kernel-doc headers for describing API functions is great 
but I'm not sure a .h file is the best location for such documentation. 
Many kernel developers keep kernel-doc headers in .c files because that 
makes it more likely that the documentation and the implementation stay 
in sync.

> +
> +/**
> + * ibtrs_clt_close() - Close a session
> + * @sess: Session handler, is freed on return
                      ^^^^^^^
                      handle?

This sentence suggests that the handle is freed on return. I guess that 
you meant that the session is freed upon return?

> +/**
> + * ibtrs_clt_get_tag() - allocates tag for future RDMA operation
> + * @sess:	Current session
> + * @con_type:	Type of connection to use with the tag
> + * @wait:	Wait type
> + *
> + * Description:
> + *    Allocates tag for the following RDMA operation.  Tag is used
> + *    to preallocate all resources and to propagate memory pressure
> + *    up earlier.
> + *
> + * Context:
> + *    Can sleep if @wait == IBTRS_TAG_WAIT
> + */
> +struct ibtrs_tag *ibtrs_clt_get_tag(struct ibtrs_clt *sess,
> +				    enum ibtrs_clt_con_type con_type,
> +				    int wait);

Since struct ibtrs_tag has another role than what is called a tag in the 
block layer I think a better description is needed of what struct 
ibtrs_tag actually represents.

> +/*
> + * Here goes IBTRS server API
> + */

Most software either uses the client API or the server API but not both 
at the same time. Has it been considered to use separate header files 
for the client and server APIs?

Bart.
