Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2912EB48
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 22:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgABVYF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 16:24:05 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51128 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 16:24:05 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so3774457pjb.0;
        Thu, 02 Jan 2020 13:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jluM0wmpyA0uc/8+QLUgQ2qnerpwBofJHQVOr4htCsk=;
        b=AEPD2Bs3fXKTRp1iwXBDUa2m4pyB0kZZw29ZcWQNeOvnErDilJYm4dsxPIWtfhXeYR
         X0YC/shqZd4y4S9Q6Tll1jXs5CFC5uB7iVIOIbYfBabDiLmr80fk/W70LhY/Wb2xphu9
         lqMO4DFoYL7woLdWWQBI8L0GSgWnlUwGRxHiu0j+tTYWCIzZXTK65c0QWloZeVy9lA/c
         xpPAPBQRGK+vE9zKDe/fkMF/jxzXw2Qpm8mtd5ZEh0lHcITM8ozsW/W8S1R/RQmhUMuJ
         qaKd5cihLdbhO6AlhgPhm7lCfEu4k4i5D3yZlyGnzZOz8Nw+r9WhChizPgfm5VZBJAD7
         Bj0A==
X-Gm-Message-State: APjAAAVPb9jE4sQjt2oHh4AwtD94Vk87pf7g4ymRkpsp0pLlWdq2MUBI
        qq4+CEFU8bsueVzSXnOg+EQ=
X-Google-Smtp-Source: APXvYqxi7ziuWYd9rjYkYRf28clMjmYAinvS7YAmIIbn/iMj6E0SWxEhYL75xUx7/jqUTPZMosMlwA==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr72479880plk.47.1578000244328;
        Thu, 02 Jan 2020 13:24:04 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a23sm66787365pfg.82.2020.01.02.13.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 13:24:03 -0800 (PST)
Subject: Re: [PATCH v6 09/25] rtrs: server: private header with server structs
 and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-10-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <848cdafd-60c5-b656-1569-81644b7fc5df@acm.org>
Date:   Thu, 2 Jan 2020 13:24:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-10-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +struct rtrs_stats_wc_comp {
> +	atomic64_t	calls;
> +	atomic64_t	total_wc_cnt;
> +};

Please document the meaning of the members of this data structure.

> +struct rtrs_srv_stats_rdma_stats {
> +	struct {
> +		atomic64_t	cnt;
> +		atomic64_t	size_total;
> +	} dir[2];
> +};

Please document the meaning of the members of this data structure and 
also which index (0, 1) corresponds to which direction (read, write).

> +struct rtrs_srv_op {
> +	struct rtrs_srv_con		*con;
> +	u32				msg_id;
> +	u8				dir;
> +	struct rtrs_msg_rdma_read	*rd_msg;
> +	struct ib_rdma_wr		*tx_wr;
> +	struct ib_sge			*tx_sg;
> +};

Please document the role of this data structure.

> +struct rtrs_srv_mr {
> +	struct ib_mr	*mr;
> +	struct sg_table	sgt;
> +	struct ib_cqe	inv_cqe; /* only for always_invalidate=true */
> +	u32		msg_id; /* only for always_invalidate=true */
> +	u32		msg_off; /* only for always_invalidate=true */
> +	struct rtrs_iu	*iu; /* send buffer for new rkey msg */
> +};

Please document the role of this data structure.

> +extern struct class *rtrs_dev_class;

Please make sure that the static 'rtrs_dev_class' variable in rtrs-clt.c 
and in this header file have different names.

Thanks,

Bart.
