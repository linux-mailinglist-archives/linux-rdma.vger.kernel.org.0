Return-Path: <linux-rdma+bounces-14839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF1C95BD2
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 07:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 264A73425EC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 06:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9B1C8FBA;
	Mon,  1 Dec 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M4Ch+tZc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F19219A89
	for <linux-rdma@vger.kernel.org>; Mon,  1 Dec 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568819; cv=none; b=Vws3eE2c1c66dIxG8Gbchb5o2fHwPbOm1Khp+b5SuU5n3kh/xBE56QKfimCnAh4L8m8W7dNqQOItODx8q4Ws1IUeKph+gMqB+p6lAJ7PJczKYFPdPMMZZwFMAdUFiJ7RebzBrxrn0dhrq/rysWZY0feP3c3n6lC1ivituUi3qAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568819; c=relaxed/simple;
	bh=8a9J5WKlLvagBRrqbTenQf3r/ZwqfeRPqvzIiOxHGhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrdeF4zwWGs4rN1QFJ4hURjPht9Gz5tqMCzoZBOmD9/1EmLHO6nc58IFp4eTO6m37BeQnDiEs5937nuV5F7Ae776iLT3PfYyG/lSE9qNw1C+6TWCwnZtGRqL3Rblira8oqmoKgo/Ba25S8cjY6JFV7fX1+h5Q0TpgCL/42qq3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M4Ch+tZc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b763b4238fcso52062166b.0
        for <linux-rdma@vger.kernel.org>; Sun, 30 Nov 2025 22:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1764568814; x=1765173614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN9NHGJJqJ2uT92gc86Y3fDq1QkhW11R9R2p8AAGxuc=;
        b=M4Ch+tZcd3KadkSSZeQN1U3y0RQC9nyDresTF4lnSpxpmFYg28POEDKAbT3ik5P3JU
         x0vMcZa2uYF8OPQUDHEk3HDHxT/j4jzWfTttui+x9d1pnGUMP2P03V3cKLI/DhFjScKn
         UJakMbBW1TIu50YGYz/ETv/wIFsv8IVd5GcxJ3ao8KGlb83TR5r2x97f5lP6t49Qdmhv
         2PGq1iUbajOJZXKKroRHMypKqkli642jKuuoXX57MCWL9yIxqyXoxpACsf4XZI2nKbY3
         PeYLRntjkzBz0OUUfT899SnQls5RG9BweJZ2BQ2ZCxbfJ2bxd4FmtFKDrRbXmuX6d/6X
         l2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764568814; x=1765173614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wN9NHGJJqJ2uT92gc86Y3fDq1QkhW11R9R2p8AAGxuc=;
        b=B0U9XGMtF6JJoJS0QBJ0o46SBsr5gFDumUlUf1wG+UdCud8sYuHcTgVIru3UZfIJew
         7nqHD2KMW9ZzcwVm5fB8ZvJwno1IuTdKjzGLNScgDqakhx+FMY2PX/7CR66sPlm3G2yp
         f5PpJITGQNBCO48y4LslfzxpyI49Bq5U2ibhjZEYEizjZeHQUYOS02JZn7wMTMyDxv8a
         Swul7SxMFNjdlbDW4KWnyAyVOkj//uhrQM1LlDYuN6h3w/ShctB9ygnRCLMbVtyQG4M4
         lEp6l1qsjhh3GY5PZt+83IpegP8S1/iO6GO6lspjdwAe2hOOdyDhwpsEz+qbIUrJ1HNj
         kddw==
X-Forwarded-Encrypted: i=1; AJvYcCWPLGxy2WE5RQMNw1WJCoCkQmA/XTIozl9mp7LzoIkupPYBHRVugk5kThjqzPwTA3egtCMxgWyjYiZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIXWJlU2kSp2wOoxujLCtDge8Z+i+91mIzdCTxtMfw47ItrwF
	afAoCiN6FMQbtaxM5ud3mvKmgAt6am6iXDMQfPHjiYcJPmLol4SBiIQPxuAt75Wq+X21jy7NWEU
	weRlzUEyzokaPmvsd1C5UwrlS9/0hKLWHLFzMhhWLKQ==
X-Gm-Gg: ASbGncs5pQPgQFrpdvWv3ktQyxjAkPk40QkbUyaCWBUMdTejo5nqma02q1WQNGzWdqe
	sTsK0We8Gjv3U8aeB7QNXCJX1fV73rnLJ+DO2phUNKkXOlmbrraZvYtpHiNgDmiqQj5SAX6n6I9
	4RXN29bpo25OfpYJMuKX3vm1KccEFJRi7RMgIok1yq+RtVb2n9lBHa66VXnHQrkyjTeJCUE2UFR
	noEXE/pwnc1TtAyELfOs1rRV9VU1sJXj7Dp9obsiuqswbMWWpp14dv7xMd1YiIf25Klfv0PIQyj
	PFbNkFjc6Ozi24QiMklpf+7ueVg=
X-Google-Smtp-Source: AGHT+IGMMFBsVZC+omOIGrSvCw2NUGYUDspEWO6UPlUjmuWjs4dn3dxhi0Gk6ch1+CvmC+7S+sFywZW1F26haNuXhyc=
X-Received: by 2002:a17:906:c115:b0:b70:e685:5ac8 with SMTP id
 a640c23a62f3a-b76717243b8mr2259002166b.3.1764568814116; Sun, 30 Nov 2025
 22:00:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129022146.1498273-1-rdunlap@infradead.org>
In-Reply-To: <20251129022146.1498273-1-rdunlap@infradead.org>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 1 Dec 2025 07:00:02 +0100
X-Gm-Features: AWmQ_bkWyZaMbXEG2V-GYWWmd2Fq94zbD7UPY-vyVpF63ukh0jcAABXXbVCqRoQ
Message-ID: <CAMGffEnvLJ0oB5S_PDG3XzD2Gw1G0JiY_zNQu3=eYa0GP4cf_Q@mail.gmail.com>
Subject: Re: [PATCH] RTRS/rtrs: clean up rtrs headers kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 3:21=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix all (30+) kernel-doc warnings in rtrs.h and rtrs-pri.h.
> The changes are:
>
> - add ending ':' to enum member names
> - change enum description separators from '-' to ':'
> - add "struct" keyword to kernel-doc for structs where missing
> - fix enum names in enum rtrs_clt_con_type
> - add a '-' separator and drop the "()" in enum rtrs_clt_con_type
> - convert struct rtrs_addr to kernel-doc format
> - add missing struct member descriptions for struct rtrs_attrs
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
lgtm, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |   32 +++++++++++++++--------
>  drivers/infiniband/ulp/rtrs/rtrs.h     |   24 ++++++++++-------
>  2 files changed, 36 insertions(+), 20 deletions(-)
>
> --- linux-next-20251128.orig/drivers/infiniband/ulp/rtrs/rtrs.h
> +++ linux-next-20251128/drivers/infiniband/ulp/rtrs/rtrs.h
> @@ -24,8 +24,8 @@ struct rtrs_srv_op;
>
>  /**
>   * enum rtrs_clt_link_ev - Events about connectivity state of a client
> - * @RTRS_CLT_LINK_EV_RECONNECTED       Client was reconnected.
> - * @RTRS_CLT_LINK_EV_DISCONNECTED      Client was disconnected.
> + * @RTRS_CLT_LINK_EV_RECONNECTED:      Client was reconnected.
> + * @RTRS_CLT_LINK_EV_DISCONNECTED:     Client was disconnected.
>   */
>  enum rtrs_clt_link_ev {
>         RTRS_CLT_LINK_EV_RECONNECTED,
> @@ -33,7 +33,9 @@ enum rtrs_clt_link_ev {
>  };
>
>  /**
> - * Source and destination address of a path to be established
> + * struct rtrs_addr - Source and destination address of a path to be est=
ablished
> + * @src:       source address
> + * @dst:       destination address
>   */
>  struct rtrs_addr {
>         struct sockaddr_storage *src;
> @@ -41,7 +43,7 @@ struct rtrs_addr {
>  };
>
>  /**
> - * rtrs_clt_ops - it holds the link event callback and private pointer.
> + * struct rtrs_clt_ops - it holds the link event callback and private po=
inter.
>   * @priv: User supplied private data.
>   * @link_ev: Event notification callback function for connection state c=
hanges
>   *     @priv: User supplied data that was passed to rtrs_clt_open()
> @@ -67,10 +69,10 @@ enum wait_type {
>  };
>
>  /**
> - * enum rtrs_clt_con_type() type of ib connection to use with a given
> + * enum rtrs_clt_con_type - type of ib connection to use with a given
>   * rtrs_permit
> - * @ADMIN_CON - use connection reserved for "service" messages
> - * @IO_CON - use a connection reserved for IO
> + * @RTRS_ADMIN_CON: use connection reserved for "service" messages
> + * @RTRS_IO_CON: use a connection reserved for IO
>   */
>  enum rtrs_clt_con_type {
>         RTRS_ADMIN_CON,
> @@ -85,7 +87,7 @@ void rtrs_clt_put_permit(struct rtrs_clt
>                          struct rtrs_permit *permit);
>
>  /**
> - * rtrs_clt_req_ops - it holds the request confirmation callback
> + * struct rtrs_clt_req_ops - it holds the request confirmation callback
>   * and a private pointer.
>   * @priv: User supplied private data.
>   * @conf_fn:   callback function to be called as confirmation
> @@ -105,7 +107,11 @@ int rtrs_clt_request(int dir, struct rtr
>  int rtrs_clt_rdma_cq_direct(struct rtrs_clt_sess *clt, unsigned int inde=
x);
>
>  /**
> - * rtrs_attrs - RTRS session attributes
> + * struct rtrs_attrs - RTRS session attributes
> + * @queue_depth:       queue_depth saved from rtrs_clt_sess message
> + * @max_io_size:       max_io_size from rtrs_clt_sess message, capped to
> + *                       @max_segments * %SZ_4K
> + * @max_segments:      max_segments saved from rtrs_clt_sess message
>   */
>  struct rtrs_attrs {
>         u32             queue_depth;
> --- linux-next-20251128.orig/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ linux-next-20251128/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -150,7 +150,7 @@ enum rtrs_msg_types {
>
>  /**
>   * enum rtrs_msg_flags - RTRS message flags.
> - * @RTRS_NEED_INVAL:   Send invalidation in response.
> + * @RTRS_MSG_NEED_INVAL_F: Send invalidation in response.
>   * @RTRS_MSG_NEW_RKEY_F: Send refreshed rkey in response.
>   */
>  enum rtrs_msg_flags {
> @@ -179,16 +179,19 @@ struct rtrs_sg_desc {
>   * @recon_cnt:    Reconnections counter
>   * @sess_uuid:    UUID of a session (path)
>   * @paths_uuid:           UUID of a group of sessions (paths)
> - *
> + * @first_conn:    %1 if the connection request is the first for that se=
ssion,
> + *                     otherwise %0
>   * NOTE: max size 56 bytes, see man rdma_connect().
>   */
>  struct rtrs_msg_conn_req {
> -       /* Is set to 0 by cma.c in case of AF_IB, do not touch that.
> -        * see https://www.spinics.net/lists/linux-rdma/msg22397.html
> +       /**
> +        * @__cma_version: Is set to 0 by cma.c in case of AF_IB, do not =
touch
> +        * that. See https://www.spinics.net/lists/linux-rdma/msg22397.ht=
ml
>          */
>         u8              __cma_version;
> -       /* On sender side that should be set to 0, or cma_save_ip_info()
> -        * extract garbage and will fail.
> +       /**
> +        * @__ip_version: On sender side that should be set to 0, or
> +        * cma_save_ip_info() extract garbage and will fail.
>          */
>         u8              __ip_version;
>         __le16          magic;
> @@ -199,6 +202,7 @@ struct rtrs_msg_conn_req {
>         uuid_t          sess_uuid;
>         uuid_t          paths_uuid;
>         u8              first_conn : 1;
> +       /* private: */
>         u8              reserved_bits : 7;
>         u8              reserved[11];
>  };
> @@ -211,6 +215,7 @@ struct rtrs_msg_conn_req {
>   * @queue_depth:   max inflight messages (queue-depth) in this session
>   * @max_io_size:   max io size server supports
>   * @max_hdr_size:  max msg header size server supports
> + * @flags:        RTRS message flags for this message
>   *
>   * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accep=
t().
>   */
> @@ -222,22 +227,24 @@ struct rtrs_msg_conn_rsp {
>         __le32          max_io_size;
>         __le32          max_hdr_size;
>         __le32          flags;
> +       /* private: */
>         u8              reserved[36];
>  };
>
>  /**
> - * struct rtrs_msg_info_req
> + * struct rtrs_msg_info_req - client additional info request
>   * @type:              @RTRS_MSG_INFO_REQ
>   * @pathname:          Path name chosen by client
>   */
>  struct rtrs_msg_info_req {
>         __le16          type;
>         u8              pathname[NAME_MAX];
> +       /* private: */
>         u8              reserved[15];
>  };
>
>  /**
> - * struct rtrs_msg_info_rsp
> + * struct rtrs_msg_info_rsp - server additional info response
>   * @type:              @RTRS_MSG_INFO_RSP
>   * @sg_cnt:            Number of @desc entries
>   * @desc:              RDMA buffers where the client can write to server
> @@ -245,12 +252,14 @@ struct rtrs_msg_info_req {
>  struct rtrs_msg_info_rsp {
>         __le16          type;
>         __le16          sg_cnt;
> +       /* private: */
>         u8              reserved[4];
> +       /* public: */
>         struct rtrs_sg_desc desc[];
>  };
>
>  /**
> - * struct rtrs_msg_rkey_rsp
> + * struct rtrs_msg_rkey_rsp - server refreshed rkey response
>   * @type:              @RTRS_MSG_RKEY_RSP
>   * @buf_id:            RDMA buf_id of the new rkey
>   * @rkey:              new remote key for RDMA buffers id from server
> @@ -264,6 +273,7 @@ struct rtrs_msg_rkey_rsp {
>  /**
>   * struct rtrs_msg_rdma_read - RDMA data transfer request from client
>   * @type:              always @RTRS_MSG_READ
> + * @flags:             RTRS message flags (enum rtrs_msg_flags)
>   * @usr_len:           length of user payload
>   * @sg_cnt:            number of @desc entries
>   * @desc:              RDMA buffers where the server can write the resul=
t to
> @@ -277,7 +287,7 @@ struct rtrs_msg_rdma_read {
>  };
>
>  /**
> - * struct_msg_rdma_write - Message transferred to server with RDMA-Write
> + * struct rtrs_msg_rdma_write - Message transferred to server with RDMA-=
Write
>   * @type:              always @RTRS_MSG_WRITE
>   * @usr_len:           length of user payload
>   */
> @@ -287,7 +297,7 @@ struct rtrs_msg_rdma_write {
>  };
>
>  /**
> - * struct_msg_rdma_hdr - header for read or write request
> + * struct rtrs_msg_rdma_hdr - header for read or write request
>   * @type:              @RTRS_MSG_WRITE | @RTRS_MSG_READ
>   */
>  struct rtrs_msg_rdma_hdr {

