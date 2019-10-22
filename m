Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC7E0AFC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfJVRwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:52:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40871 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfJVRwR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:52:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id y81so13196274qkb.7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYELYeqgb6u2HwVxCCOYQhK7Ymo2hH7WNh8GwwhW5CM=;
        b=bDQW0HlXdjLizbv/Jl5OdFh6mBReWuDjZMe+gCSA3u4RNvV7nN9T2/RM3shr+8xujA
         zZDjiLxyVYJviAFaOUvZF+jPmrtJRTj1u8vQQmfQnj/r2wtyobZYgn7FwQgwMAZUMuE/
         klngz5yv6EfzGEbcf0HlURkIlEHpGdk3X/pFlBhi/lqpOwOjisp6EhjxOaIHtIZIprK1
         2GMo5+zGQIAfrytcfi/V5VjhA6Cgy0bzr3R9lQEM3L21fwO9p/phFbfKqGfbWAveGUb8
         6hQ4moWdcQy6KO+PWUktw6+GAY3OXNRLYx9BY3JqwPpu3NTg3YidMkJlq3osyx7AJHI/
         M+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYELYeqgb6u2HwVxCCOYQhK7Ymo2hH7WNh8GwwhW5CM=;
        b=DtlKnE8NVGluBsMAK9zFdrdfPJvc6Bha2txB+f88S0r9hX6Usom7ypDDDKHsVUti/b
         9Kg8Y2Q9uGF5Bf8RjbxMij1JI0OjIr8puEydVLbrcYXPGsKsa0i5+OpeGiXajUiVPvEf
         1sSFUisYxXPzeLqrarsy0wVLXmwUw5jyb8JoMiCAkxcWaaK+Oqa0WnhVCBNTUteHiDD6
         b7/vxGtx/B5oM52oVgw117kegUylaNjw1IyieJ/31WHZqaZSQNzA3GgWs1ZFDkB5RhhV
         PQn3WbyoKfECWsydPqK/KhdlRd7ei/ksFHyPG8GuI06HNm0SQ1P+zhB7TTc8rNjXU5yL
         waBA==
X-Gm-Message-State: APjAAAWSNI0khi92TpPBq48ewDLFhIw/OUNKZywgDGQB9eTlvgp4Ez7p
        44ihxfVapi4Ht4vkCU/fxpyGBfbGtTw=
X-Google-Smtp-Source: APXvYqz7BrDUSkINRnh21r1LtSQAw+f4VqRc40zrgszfx4KX51bI2hxaxDMXGmHX2qXrGIglup0Ejg==
X-Received: by 2002:a37:7641:: with SMTP id r62mr4225750qkc.496.1571766736887;
        Tue, 22 Oct 2019 10:52:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k187sm178903qkb.20.2019.10.22.10.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 10:52:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMyKO-0006ui-0C; Tue, 22 Oct 2019 14:52:16 -0300
Date:   Tue, 22 Oct 2019 14:52:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rd.dunlab@gmail.com
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h
 kernel-doc notation
Message-ID: <20191022175215.GA26528@ziepe.ca>
References: <20191010035239.532908118@gmail.com>
 <20191010035239.890311169@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010035239.890311169@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 08:52:44PM -0700, rd.dunlab@gmail.com wrote:
> Make reserved struct fields "private:" so that they don't need to
> be added to the kernel-doc notation. This removes 24 warnings.

> +++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
> @@ -129,21 +129,31 @@ struct opa_vesw_info {
>  	__be16  fabric_id;
>  	__be16  vesw_id;
>  
> +	/* private: */
>  	u8      rsvd0[6];
> +	/* public: */
>  	__be16  def_port_mask;

This seems overly ugly, is there some other way to handle these
reserved fields? Maybe wire protocol structures shouldn't be kdoc?

Jason
