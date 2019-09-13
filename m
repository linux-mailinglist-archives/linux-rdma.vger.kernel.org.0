Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161A7B2824
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfIMWKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 18:10:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45050 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403839AbfIMWKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 18:10:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id k1so13834018pls.11;
        Fri, 13 Sep 2019 15:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jllUiuaA02Uc7cmGfjyqP4d52QG2Uo5CdP6bwgOrw04=;
        b=dEB+hGSZiD181ogI4XuDXH+L/FClpX7XhBh3AN6pT8YyE3pB2PbAm2ogQjUu4wNwLb
         cMTjvEwYeH9sPZKBGpqAKFxlMoq2182ZsD1xQzXAT/JD0F1BVQacj+tyTrPmL+T+vgsi
         V+pOwkPWpVtOOdhwT8YwVo5Y5JvdyCHbANGpyMadauODAwui6vT7wGL74mrVCXjF4Lci
         NnpTvGW/c+WvpOMnlnEhGKMzIdOmAfJmSclX1ZuAIhFeiare4IGOYDjJ3IqWe788oWfW
         BvqL2EiUmA1axUadNxlNXPIAMbeSqbx5Sk09fwCLcHt+4TH2avORG4YroyZm7muQ5/bC
         4fpw==
X-Gm-Message-State: APjAAAW5XM+6RzZieuwsgkBE/7PJxmvp0Yx6NXGZB7jDCShqvK66q2IG
        UAGmAHHCaQ3bGcV+IlKlvk4=
X-Google-Smtp-Source: APXvYqwigthOKaPuSvWb9V7tIFp44obXARsFRnZBN847hUpWt/KtVsdpB7BFzBeth0tVuD8u8jb2KQ==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr29767476plp.104.1568412615948;
        Fri, 13 Sep 2019 15:10:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b18sm3013047pju.16.2019.09.13.15.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 15:10:15 -0700 (PDT)
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-16-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org>
Date:   Fri, 13 Sep 2019 15:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-16-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +#define ibnbd_log(fn, dev, fmt, ...) ({				\
> +	__builtin_choose_expr(						\
> +		__builtin_types_compatible_p(				\
> +			typeof(dev), struct ibnbd_clt_dev *),		\
> +		fn("<%s@%s> " fmt, (dev)->pathname,			\
> +		(dev)->sess->sessname,					\
> +		   ##__VA_ARGS__),					\
> +		__builtin_choose_expr(					\
> +			__builtin_types_compatible_p(typeof(dev),	\
> +					struct ibnbd_srv_sess_dev *),	\
> +			fn("<%s@%s>: " fmt, (dev)->pathname,		\
> +			   (dev)->sess->sessname, ##__VA_ARGS__),	\
> +			unknown_type()));				\
> +})

Please remove the __builtin_choose_expr() / 
__builtin_types_compatible_p() construct and split this macro into two 
macros or inline functions: one for struct ibnbd_clt_dev and another one 
for struct ibnbd_srv_sess_dev.

> +#define IBNBD_PROTO_VER_MAJOR 2
> +#define IBNBD_PROTO_VER_MINOR 0
> +
> +#define IBNBD_PROTO_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> +			       __stringify(IBNBD_PROTO_VER_MINOR)
> +
> +#ifndef IBNBD_VER_STRING
> +#define IBNBD_VER_STRING __stringify(IBNBD_PROTO_VER_MAJOR) "." \
> +			 __stringify(IBNBD_PROTO_VER_MINOR)

Upstream code should not have a version number.

> +/* TODO: should be configurable */
> +#define IBTRS_PORT 1234

How about converting this macro into a kernel module parameter?

> +enum ibnbd_access_mode {
> +	IBNBD_ACCESS_RO,
> +	IBNBD_ACCESS_RW,
> +	IBNBD_ACCESS_MIGRATION,
> +};

Some more information about what IBNBD_ACCESS_MIGRATION represents would 
be welcome.

> +#define _IBNBD_FILEIO  0
> +#define _IBNBD_BLOCKIO 1
> +#define _IBNBD_AUTOIO  2
 >
> +enum ibnbd_io_mode {
> +	IBNBD_FILEIO = _IBNBD_FILEIO,
> +	IBNBD_BLOCKIO = _IBNBD_BLOCKIO,
> +	IBNBD_AUTOIO = _IBNBD_AUTOIO,
> +};

Since the IBNBD_* and _IBNBD_* constants have the same numerical value, 
are the former constants really necessary?

> +/**
> + * struct ibnbd_msg_sess_info - initial session info from client to server
> + * @hdr:		message header
> + * @ver:		IBNBD protocol version
> + */
> +struct ibnbd_msg_sess_info {
> +	struct ibnbd_msg_hdr hdr;
> +	u8		ver;
> +	u8		reserved[31];
> +};

Since the wire protocol is versioned, is it really necessary to add 31 
reserved bytes?

> +struct ibnbd_msg_sess_info_rsp {
> +	struct ibnbd_msg_hdr hdr;
> +	u8		ver;
> +	u8		reserved[31];
> +};

Same comment here.

> +/**
> + * struct ibnbd_msg_open_rsp - response message to IBNBD_MSG_OPEN
> + * @hdr:		message header
> + * @nsectors:		number of sectors

What is the size of a single sector?

> + * @device_id:		device_id on server side to identify the device

Please use the same order for the members in the kernel-doc header as in 
the structure.

> + * @queue_flags:	queue_flags of the device on server side

Where is the queue_flags member?

> + * @discard_granularity: size of the internal discard allocation unit
> + * @discard_alignment: offset from internal allocation assignment
> + * @physical_block_size: physical block size device supports
> + * @logical_block_size: logical block size device supports

What is the unit for these four members?

> + * @max_segments:	max segments hardware support in one transfer

Does 'hardware' refer to the RDMA adapter that transfers the IBNBD 
message or to the storage device? In the latter case, I assume that 
transfer refers to a DMA transaction?

> + * @io_mode:		io_mode device is opened.

Should a reference to enum ibnbd_io_mode be added?

> +	u8			__padding[10];

Why ten padding bytes? Does alignment really matter for a data structure 
like this one?

> +/**
> + * struct ibnbd_msg_io_old - message for I/O read/write for
> + * ver < IBNBD_PROTO_VER_MAJOR
> + * This structure is there only to know the size of the "old" message format
> + * @hdr:	message header
> + * @device_id:	device_id on server side to find the right device
> + * @sector:	bi_sector attribute from struct bio
> + * @rw:		bitmask, valid values are defined in enum ibnbd_io_flags
> + * @bi_size:    number of bytes for I/O read/write
> + * @prio:       priority
> + */
> +struct ibnbd_msg_io_old {
> +	struct ibnbd_msg_hdr hdr;
> +	__le32		device_id;
> +	__le64		sector;
> +	__le32		rw;
> +	__le32		bi_size;
> +};

Since this is the first version of IBNBD that is being sent upstream, I 
think that ibnbd_msg_io_old should be left out.

> +
> +/**
> + * struct ibnbd_msg_io - message for I/O read/write
> + * @hdr:	message header
> + * @device_id:	device_id on server side to find the right device
> + * @sector:	bi_sector attribute from struct bio
> + * @rw:		bitmask, valid values are defined in enum ibnbd_io_flags

enum ibnbd_io_flags doesn't look like a bitmask but rather like a bit 
field (https://en.wikipedia.org/wiki/Bit_field)?

> +static inline u32 ibnbd_to_bio_flags(u32 ibnbd_flags)
> +{
> +	u32 bio_flags;

The names ibnbd_flags and bio_flags are confusing since these two 
variables not only contain flags but also an operation. How about 
changing 'flags' into 'opf' or 'op_flags'?

> +static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> +{
> +	switch (mode) {
> +	case IBNBD_FILEIO:
> +		return "fileio";
> +	case IBNBD_BLOCKIO:
> +		return "blockio";
> +	case IBNBD_AUTOIO:
> +		return "autoio";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
> +{
> +	switch (mode) {
> +	case IBNBD_ACCESS_RO:
> +		return "ro";
> +	case IBNBD_ACCESS_RW:
> +		return "rw";
> +	case IBNBD_ACCESS_MIGRATION:
> +		return "migration";
> +	default:
> +		return "unknown";
> +	}
> +}

These two functions are not in the hot path and hence should not be 
inline functions.

Note: I plan to review the entire patch series but it may take some time 
before I have finished reviewing the entire patch series.

Bart.
