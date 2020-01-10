Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2576E137121
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgAJP0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:26:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36822 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgAJP0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:26:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so2173591qkc.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zx70C0yvQGFPvXF/Yj93LJUn1wfj77Eq+Mgu/CTAt2Y=;
        b=KqBIDfh3Hp6Av1sZrSkY7PTNmE6rn9c8I7MgPeGnBkd5gzRYVW1x7RYH7i0nQZj5vs
         eurdCntWkoYE+5K0r5VhPgkBOuvBhy8EbBpUy0QXy/uD8Af/AGJaTOYf4osmm9PkjfPC
         Jt1WpzTKc3aeKJuJSVo8707sMcOYdzby+s2YhjBxP/TZitxlQqgNlJGP9AGTKcfZudwq
         WFohT5VL1op8GpjCeRJHnZEL/1khqHWnJMe5uY0//EYBe3XunIv0EysXABkyl8L2bjpS
         UdySMpP1oh57HyxuXK6LxjN2OofDv/7V2Jfozm66LFQc0ceOZUrml3TwAJVCCp+KrLBg
         1dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zx70C0yvQGFPvXF/Yj93LJUn1wfj77Eq+Mgu/CTAt2Y=;
        b=lEg6w6eV+cHbPwTT4l+LU1kDQXoRFitNGudOVAVL3aysf3nLF8QmqkWzPbEz7fdfSj
         tLSm3PWa95hP7LBV7LLDpjJPhOdjx9HvepgjjjMldIFDvNVxiVgw7HJT6k/Ssn7KpblT
         wT3VkmiSfc7rdzMupPvbWtnBeJDTpNT9js/tPKXbgk5hTVqmlL90wN63Syw//x1ATCN0
         psFcijIzlwqHeRqjrVB5fwxt06Qr3wLYO/3E+xYp7Ked54qFwN2ET8z+oE1ZNpIfk5HY
         zaXvqeQF9bVu1BufjW9/oE+MXxv6YBbvQ+b1BowrO65A4/T8k5UmkYalwbSdP98IPRKF
         xyig==
X-Gm-Message-State: APjAAAW7GIGvLM4FUJzSq8UzzuRa5Rj7MRMQWqlQtng3tnQLEV5LQKqt
        x0mb8WJQFpmQP/C8I7d9D7JO4w==
X-Google-Smtp-Source: APXvYqxa53wu0Gu9DJNo71TGrnMbfhTF0yHvhKB394A33UmiIl3g0l2YswG1da7BHXtf8JocZN+GvQ==
X-Received: by 2002:a05:620a:5a2:: with SMTP id q2mr3864534qkq.202.1578669963753;
        Fri, 10 Jan 2020 07:26:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n1sm962159qkk.122.2020.01.10.07.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:26:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipwAk-0003ky-SP; Fri, 10 Jan 2020 11:26:02 -0400
Date:   Fri, 10 Jan 2020 11:26:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Message-ID: <20200110152602.GC8765@ziepe.ca>
References: <1577503735-26685-1-git-send-email-liuyixian@huawei.com>
 <1577503735-26685-2-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577503735-26685-2-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 28, 2019 at 11:28:54AM +0800, Yixian Liu wrote:
> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> +{
> +	struct hns_roce_work *flush_work;
> +
> +	flush_work = kzalloc(sizeof(struct hns_roce_work), GFP_ATOMIC);
> +	if (!flush_work)
> +		return;

You changed it to only queue once, so why do we need the allocation
now? That was the whole point..

And the other patch shouldn't be manipulating being_pushed without
some kind of locking

Jason
