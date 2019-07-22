Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41FF703BB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfGVP1C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:27:02 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:42088 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfGVP1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:27:02 -0400
Received: by mail-vk1-f176.google.com with SMTP id 130so7919904vkn.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fFSW3MtnFG1vgXzyH4/3x+0Vpm+vDrL59dvaPAFK60=;
        b=ms5K2o3zppDIp0xReLN5y/RFuJeMBDR+pjBlQ29CXXv61pzwrKI0eW92RJXuWDzW5u
         usuFdcGKBYnckjeAjl0w2/2BHHhxAyxO6lHGqM3g1c3Un2u7CHOZ0ymu6hW81n780gvp
         elXOYse/tJh8KnO2NPTVhD+A10nqSGeGggnPufaTyBSITyDNe8Rd8msToJumwhBCxVFn
         eXceMEb++YjYWripjjoeKfe7xvbXQ/06yA15bNgCrf1u8YgwgLZ4ORS4zjNmr+1o8UY0
         GolnqtYlgVj8EYxYUJ8Hdhm7HfRz62aAEQBzacd+Qg2+wXBkf9Hy2TOIIYRnqoW9EtAe
         RnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fFSW3MtnFG1vgXzyH4/3x+0Vpm+vDrL59dvaPAFK60=;
        b=NHdBkGLs9NldQ6cRci2eghebHT5wuDKYC6QlGbwQ5/1NZHwibegF7v9RV8J6OjSgko
         LAmSgrTqKS+RF4CXVLD23LQdfrIQS+EydyP0abQCXivINdPIvAXggFD8khUvS+yau7qp
         O9piA9D9kYH/qU6AA7tjIaZetp8mu2hUu1gNoa3dpm1/qSzufgwfHII9bEZxyVtxDVPd
         jvLPN4jSFcvue0MAEOlPgJw9OcDy/eHRrNgQ0T6pz8TTfHa1UmcBSG2pRqPfw9wMaIUH
         mq/vw7GSjspaOP2YhKiUt0d5c6Q4VS5TrTwKkoVI1fDLotQb7dWREFuc5hceUzYwSVun
         TbYQ==
X-Gm-Message-State: APjAAAXHaAH/x1sxOBAom5aBYYniYWhnNsYBXcvLis0eg2JHx4RgNqYk
        fy6uahEz9pC8vYwvdHA/bybzlA==
X-Google-Smtp-Source: APXvYqwKmXaXKwn648l2BX/4Vui36L8YiKHD/p8j6Drku1qUj6wXiQ/SJlOqZVMT03zl3PN7212BYA==
X-Received: by 2002:a1f:e586:: with SMTP id c128mr21069024vkh.44.1563809221452;
        Mon, 22 Jul 2019 08:27:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h61sm8519740uah.18.2019.07.22.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 08:27:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpaDM-0004pT-5F; Mon, 22 Jul 2019 12:27:00 -0300
Date:   Mon, 22 Jul 2019 12:27:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] Fix reference counting for rxe tasklets
Message-ID: <20190722152700.GE7607@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-6-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151426.5266-6-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 05:14:21PM +0200, Maksym Planeta wrote:
>  
>  int rxe_init_task(void *obj, struct rxe_task *task,
> -		  void *arg, int (*func)(void *), char *name)
> +		  struct rxe_qp *qp, int (*func)(void *), char *name)
>  {
>  	task->obj	= obj;
> -	task->arg	= arg;
> +	task->arg	= qp;
>  	task->func	= func;
>  	snprintf(task->name, sizeof(task->name), "%s", name);
>  	task->destroyed	= false;
>  
> +	rxe_add_ref(&qp->pelem);

Please put the kref incrs near the copy of the pointer. Those things
are logically related - copy the pointer, incr the kref.

Jason
