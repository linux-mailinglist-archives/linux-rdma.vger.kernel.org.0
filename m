Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A06703D0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfGVPcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:32:07 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43234 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfGVPcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:32:07 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so26387983vsn.10
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83LVMuHoHjqhSQNZ1FrJgpxiHmtCkL35yfYZrLhbZjo=;
        b=LqJPpEmUB0a9Ke4CAk6JPoucs8wmtb+02DEs9QL9U+BbOfYQbgVeFVIqqlr7oQQAq8
         3S/c31fXk9q8SoWg6oP7zCkjauQxi8XdeFPuuQU1NEBI6kkLLcblRlt8GzFe/je8gjix
         vOHkm5H5D1AnV47vAB88S13Je7Hl7mpBe3uFaxmZnvAvkAkKIX9vchXENhZeppe+VvUl
         MuaQ06MGkLEsK+UrErQamKgEpMwyq8lwf16j83TMQILggK/TJgS+7d8jfQRFFXYWYeGB
         2JhobIzAQZt5zssUMglTgRGluDpjdCgIkrPqKnHvg060jjILe0hrONl32QrLFG+ZcDZh
         wPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83LVMuHoHjqhSQNZ1FrJgpxiHmtCkL35yfYZrLhbZjo=;
        b=EjkWlueEV44fJNU1K5/BsjscgMNhyAOvGKVq55sjDgm/BZ+ngZuj4PpslUUeLi3wwS
         lCI67xKVsaWmvqwzv1P+2BpMDk6F4v0n+6ojqz54YsZ4zrJdndf4SIO+wVY/97mIsTiF
         QvzkdY+ZndcF83dWi8tnjtLdzWj6ZyheJyQ3HHvgvQ9t4RUd/wVkozye+T6/svhxiMNR
         vZR6wSGZ2A+1ot/jbtCJI1Pp2DHpzNmyyVZGdq9YC5vg0Dam2HEl8Z3pXhEpV8ZTIXpe
         n7mslfq8PcGWKSbAm0BEIRHRcc2iWrcVxvWff65qno4zVtqR54TstRgTXNVabincxbGM
         5vSQ==
X-Gm-Message-State: APjAAAVZcaFbmz8Gw89FT5ddK339+02zsAj1rl07cyGohb9kQN+skVnY
        /CmVimZPeBpU+TTq4lHNa5JhDdX7uljrqg==
X-Google-Smtp-Source: APXvYqwfMx7NNtKhAko8Xc/SzCmuGCf752a2RG6dd2WSCibeWR5f56T3h9COdwohxrypQTGs8RQ6+Q==
X-Received: by 2002:a05:6102:1041:: with SMTP id h1mr42912194vsq.153.1563809526346;
        Mon, 22 Jul 2019 08:32:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l184sm18097130vsl.8.2019.07.22.08.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 08:32:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpaIH-0004t3-Av; Mon, 22 Jul 2019 12:32:05 -0300
Date:   Mon, 22 Jul 2019 12:32:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] Replace tasklets with workqueues
Message-ID: <20190722153205.GG7607@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 05:14:26PM +0200, Maksym Planeta wrote:
> Replace tasklets with workqueues in rxe driver.
> 
> Ensure that task is called only through a workqueue. This allows to
> simplify task logic.
> 
> Add additional dependencies to make sure that cleanup tasks do not
> happen after object's memory is already reclaimed.
> 
> Improve overal stability of the driver by removing multiple race
> conditions and use-after-free situations.

This should be described more precisely

Jason
