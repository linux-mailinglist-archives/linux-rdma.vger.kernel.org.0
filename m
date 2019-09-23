Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A9EBBA5B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407451AbfIWRVn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 13:21:43 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41965 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407395AbfIWRVn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 13:21:43 -0400
Received: by mail-pg1-f170.google.com with SMTP id s1so7239533pgv.8;
        Mon, 23 Sep 2019 10:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wR89duXvziwuehT9M3ezyTbGyDX3St5TL6xP7dbyLZc=;
        b=QEux9+uKoCn7oHIaJeqWoN3DVc4I5IuBsFVDTgDrYxYA8WsW7/1/wl03yjjOHQJ2YJ
         qzV7cq9ekuxa+3iPfSBgyHhToCxbPNC4uhWN7xLEZMitfdZxGz6bJCMjX35ukqUAk3cP
         lcmzjIvAaS6WY7ahq220XJpw21BBnqAgwFLr965VDOlQUs/ppAnSHk7cNGD4UzOMIbVf
         uyPigo6V7s7N2dEpVajhaiegTFYsGtdbD8IebxwzVikCwU7nMCKoQ04ZQBItyRTCW/iu
         mZkdsKCwNzYSPFdQiYloHllBKsTqIWw+xh8Coky4dUUQrnAFC/g7ugXxCpCDPL3KRlVZ
         Fa6w==
X-Gm-Message-State: APjAAAXr4GA0VODWz4m6+EQ/4Tt+UAqq6EpWknojP9mJBboWHBYKHs18
        Cudxc4CqesO3N9n4/8uASNFuZI2G
X-Google-Smtp-Source: APXvYqz2GRCjrKwt0puk7dmPBAIzM4khPEuoiYfkfxjoxNDv9aHFtV5h+JnSHgBfGUy9YF3o0Cf14Q==
X-Received: by 2002:a17:90a:f83:: with SMTP id 3mr608914pjz.90.1569259301738;
        Mon, 23 Sep 2019 10:21:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d69sm10401167pfd.175.2019.09.23.10.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:21:40 -0700 (PDT)
Subject: Re: [PATCH v4 01/25] sysfs: export sysfs_remove_file_self()
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-2-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4cad763a-e803-1dd8-4ea5-d7ceab929841@acm.org>
Date:   Mon, 23 Sep 2019 10:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-2-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> Function is going to be used in transport over RDMA module
> in subsequent patches.

It seems like several words are missing from this patch description.

Bart.
