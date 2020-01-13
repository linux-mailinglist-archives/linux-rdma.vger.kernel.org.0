Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168F913930E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAMOEp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 09:04:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36692 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgAMOEp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 09:04:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so8540877qkc.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2020 06:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xVZ+swt2o10HC3gUjrQY2WV1R9wJxiXtEbx6qnxQmdQ=;
        b=TkVTWwSNBsaaX0/L7Zx9Hs32GJVpmBS8MrTtk3h4M377tZ9jIlH268lYz39vDI9yL1
         32feN4koPI5o6eC/yuJ/BELC19mUGXmQalUD1udTEx9tHyGnAN/OjnCebq0y8fCAThHy
         Fs8drQhi2rFcAmUb6kEgkkpW4gByeFhNa+0VGgfLpA8ykALsEFAlj6KltmVnIhs6OKCm
         i+7j8qGtOtdKY8yHDooQzJGIJN7ilS+43tq3Cv27lKh6oZvUNPiz1NKgQCKCyJ+9uS42
         bOgi0wG9NIsJqYmtjjfShq/UThG2y86pequSuF9vyYyT5jN8B+SmJg1HI6GjthEQSk9H
         atJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xVZ+swt2o10HC3gUjrQY2WV1R9wJxiXtEbx6qnxQmdQ=;
        b=DWRau8p0QaKp1rn+vEpJ0fDm4lJy0J0Mrpvqch+zsQiSyJ+qYQ0J06q8znYXrYpAsL
         Ayb3WIo5FkOGJj/u/hlAxIhcAq+EqwF2tIc0tN4DN85J95rzKQfXBCSzu9/z5Uu/xTXE
         G9Ojts4xsZL7RMLszWb4wooEjGDkFH1zhr43rCReA3VA9aY/wk5WeYl17xcKXnT5oT4+
         GKqiD+2y+/Kt5ULzDRxAQJc3tSdWi/e1TqYG5IM/W6V0Kyd/Ui2IRCp8nTOJe/I6jDO7
         6YJ7EKvd1WPmpRn6c9np4sCbO7Uralh3GtEDjgkM77N5PsmxNv4V/Ps/Rytx+5ocaOSg
         iosA==
X-Gm-Message-State: APjAAAUw6+rVjS+g46d2luLQ3zPCCGygfVjsW1bFxlKI1PRyqCLxau49
        65ObOEPs0/Iu/5fSne1ATlWYcA==
X-Google-Smtp-Source: APXvYqxsonoXsbuIaGl3PtS8+enZMQezgYbpy9n+raOqzmxz4GA+3NkaxKkS7PhUYZUO3xsZcXe4/w==
X-Received: by 2002:a05:620a:2041:: with SMTP id d1mr16466119qka.113.1578924284133;
        Mon, 13 Jan 2020 06:04:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m68sm5009105qke.17.2020.01.13.06.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 06:04:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ir0Kg-0003BZ-Pq; Mon, 13 Jan 2020 10:04:42 -0400
Date:   Mon, 13 Jan 2020 10:04:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Message-ID: <20200113140442.GA9861@ziepe.ca>
References: <1577503735-26685-1-git-send-email-liuyixian@huawei.com>
 <1577503735-26685-2-git-send-email-liuyixian@huawei.com>
 <20200110152602.GC8765@ziepe.ca>
 <65fb928c-5f85-02f9-c5ac-06037b3fe967@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fb928c-5f85-02f9-c5ac-06037b3fe967@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 13, 2020 at 07:26:45PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2020/1/10 23:26, Jason Gunthorpe wrote:
> > On Sat, Dec 28, 2019 at 11:28:54AM +0800, Yixian Liu wrote:
> >> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
> >> +{
> >> +	struct hns_roce_work *flush_work;
> >> +
> >> +	flush_work = kzalloc(sizeof(struct hns_roce_work), GFP_ATOMIC);
> >> +	if (!flush_work)
> >> +		return;
> > 
> > You changed it to only queue once, so why do we need the allocation
> > now? That was the whole point..
> 
> Hi Jason,
> 
> The flush work is queued **not only once**. As the flag being_pushed is set to 0 during
> the process of modifying qp like this:
> 	hns_roce_v2_modify_qp {
> 		...
> 		if (new_state == IB_QPS_ERR) {
> 			spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
> 			...
> 			hr_qp->state = IB_QPS_ERR;
> 			hr_qp->being_push = 0;
> 			...
> 		}
> 		...
> 	}
> which means the new updated PI value needs to be updated with initializing a new flush work.
> Thus, maybe there are two flush work in the workqueue. Thus, we still need the allocation here.

I don't see how you should get two? One should be pending until the
modify is done with the new PI, then once the PI is updated the same
one should be re-queued the next time the PI needs changing.

Jason
