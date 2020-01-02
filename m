Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 530AB12EE53
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgABWh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:37:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38234 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbgABWh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:37:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so3951331pje.3;
        Thu, 02 Jan 2020 14:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbv+6upNBk0D6PmWDQhhJmZhbhv6Z/tvZVqWiMYj2og=;
        b=ATAoYizZrHSqld+AcOOJxKdmO+JNcudDUzVOhRJb7BbEoPAVKBOJ62sw879Hk1qax0
         8nQ1FsiRYS+ExGmgpwTwuEh83UpKUFm7QjR2j3mqI2flpkuCBMkRhIgscHqNerrTb0/l
         L3kkHc5bNxiZG6kr7DoLswBQ4B9/nBcnpGP3vKhHB52hfGsedVz8wkpyoyB/hZ3cOSy8
         tCjWRxyW20GZmEh4Y78AMso0W44oZ/dwYqHjf01Ly+ZiMuDgQm0ss3YQNWobzkefo8Sd
         c1cLJ3SUSMzeAns1uIaQRY5Yf4B2oGY8eH31yC+FE85H4EnGw9yJtA7NgQ9fImLSkM1A
         AJLw==
X-Gm-Message-State: APjAAAV94D1CI6/yFJb1oMleXBQ/XMVCTF++B94TILKNVERWu4T1R6Bo
        LQQdB93UhyPGW5DFMGKQtcA=
X-Google-Smtp-Source: APXvYqzEu88wbgSn1EY+xe3Agg7e5kT3zGYciepQSesDFJ+eowaIWXUOuHzUv/ceFvAZOLuEpqkK3w==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr59447373plo.214.1578004648440;
        Thu, 02 Jan 2020 14:37:28 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g7sm66866972pfq.33.2020.01.02.14.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:37:27 -0800 (PST)
Subject: Re: [PATCH v6 16/25] rnbd: client: private header with client structs
 and functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-17-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <23dc5d7a-06e1-7ce4-3ab6-20cb6f49987a@acm.org>
Date:   Thu, 2 Jan 2020 14:37:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-17-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +struct rnbd_iu {
> +	union {
> +		struct request *rq; /* for block io */
> +		void *buf; /* for user messages */
> +	};
> +	struct rtrs_permit	*permit;
> +	union {
> +		/* use to send msg associated with a dev */
> +		struct rnbd_clt_dev *dev;
> +		/* use to send msg associated with a sess */
> +		struct rnbd_clt_session *sess;
> +	};
> +	blk_status_t		status;
> +	struct scatterlist	sglist[BMAX_SEGMENTS];
> +	struct work_struct	work;
> +	int			errno;
> +	struct rnbd_iu_comp	comp;
> +	atomic_t		refcount;
> +};

This data structure includes both a blk_status_t and an errno value. Can 
these two members be combined into a single member?

Thanks,

Bart.
